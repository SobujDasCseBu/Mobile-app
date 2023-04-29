//import from packages
const express = require('express')
const mongoose = require('mongoose')
const cors = require('cors')

//import from other files
const authRouter = require('./routes/auth')
const adminRouter = require('./routes/admin')
const productRouter = require('./routes/product')
const userRouter = require('./routes/user')

//initialization
const PORT = 3000;
const app = express();

//middleware
app.use(cors())
app.use(express.json())
app.use(authRouter)
app.use(adminRouter)
app.use(productRouter)
app.use(userRouter)

// connections

mongoose.connect('mongodb://localhost:27017/first_project_mobileApp').then(() =>{
    console.log('Connection successfully')
}).catch((e) =>{
    console.log("Error from mongoose : ", e)
})


app.listen(PORT , () =>{
    console.log('Connected at port :'+ PORT)
})