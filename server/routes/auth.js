const express = require('express')
const User = require('../models/user')
const bcryptjs = require('bcryptjs')
const jwt = require('jsonwebtoken');
const auth = require('../middlwire/auth');
const authRouter = express()

authRouter.post('/api/signup', async (req, res) => {
    try {

        const { email, password, name } = req.body

        const existingUser = await User.findOne({ email })
       
        if (existingUser) {
            return res.status(400).json({ msg: 'User with same email already exist' })
        }
        const hashPassword = await bcryptjs.hash(password, 8)
        let user = new User({
            email,
            name,
            password: hashPassword,
        })

        user = await user.save()
        res.json(user)

    } catch (error) {
        res.status(500).json({ error: error.message })
    }

})

//signIn route

authRouter.post('/api/signIn', async (req, res) => {
    try {
        const { email, password } = req.body;
        const user = await User.findOne({email})

        if (!user) {
            return res.status(400).json({ msg: 'User with this email does not exit!' })
        }
    
        const isMatch = await bcryptjs.compareSync(password, user?.password)

        if (!isMatch) {
            return res.status(400).json({ msg: 'Password is not correct, please give a correct password!' })
        }

        const token = jwt.sign({id:user.id}, "passwordKey")
        
        return res.json({token, ...user._doc})

    } catch (error) {
        return res.status(500).json({ error: error.message })
    }
})

authRouter.post('/tokenIsValid', async(req,res) =>{
    try {

        const token = req.header('x-auth-token')
        if(!token) return res.json(false)
        const verified = jwt.verify(token, 'passwordKey')
        if(!verified) return res.json(false)

        const user = await User.findById(verified.id)
        if(!user) return res.json(false)

        res.json(true)
        
    } catch (error) {
        res.status(500).json({error: error.message})
    }
})

authRouter.get('/', auth , async (req,res) =>{
    const user = await User.findById(req.user)
    res.json(...user._doc, req.token)
})

module.exports = authRouter