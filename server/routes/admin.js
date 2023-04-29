const express = require('express');
const adminRouter = express.Router()
const admin = require('../middlwire/admin');
const {Product} = require('../models/product');

adminRouter.post('/admin/add-product', admin , async (req, res) =>{
    try {
        const {name, description, price, quantity, images, category} = req.body
        let product = Product({
            name,
            description,
            price,
            quantity,
            images,
            category,
        })
        product = await product.save();
        res.json(product)
    } catch (error) {
        res.status(500).json({error: error.message})
    }
})

// Get all products for admin

adminRouter.get('/admin/get-products', admin, async(req,res) =>{
    try {
        const products = await Product.find({})
        res.json(products)
    } catch (error) {
        res.status(500).json({error: error.message})
    }

})

// delete product

adminRouter.post('/admin/delete-product', admin , async(req, res) =>{
    try {
        const {id} = req.body
        let product = await Product.findByIdAndDelete(id)
        res.json(product)
        
    } catch (error) {
        res.status(500).json({error: error.message})
    }
})


module.exports = adminRouter