const express = require('express');
const userRouter = express.Router()
const auth = require('../middlwire/auth');
const { Product } = require('../models/product');
const User = require('../models/user');

userRouter.post('/api/add-to-cart', auth , async (req, res) =>{
    try {

       const {id} = req.body;
       const product = await Product.findById(id);
       let user = await User.findById(req.user);
       //console.log('User cart : ', user.cart);
       if(user.cart.length == 0){
        user.cart.push({product, quantity: 1}) 
       }else{
        let isProductFound = false;
        for( let i=0; i< user.cart.length; i++){
            if(user.cart[i].product._id.equals(product._id)){
                isProductFound = true;
            }
        }
        if(isProductFound){
            let producttt = user.cart.find((productt)=>productt.product._id.equals(product._id)
            );
            //console.log('Producttt : ', producttt);
            producttt.quantity += 1;
           // producttt.quantity += 1;

        }
        else{
            user.cart.push({product, quantity: 1});
        }
       }
       //console.log(' Add to cart');
       user = await user.save()
       res.json(user)

    } catch (error) {
        //console.log('Add to cart error')
        res.status(500).json({error: error.message})
    }
})



userRouter.delete('/api/remove-from-cart/:id', auth , async (req, res) =>{
    try {

       const {id} = req.params;
       const product = await Product.findById(id);
       let user = await User.findById(req.user);
      
        for( let i=0; i< user.cart.length; i++){
            if(user.cart[i].product._id.equals(product._id)){
               if(user.cart[i].quantity == 1){
                 user.cart.splice(i,1)
               }else{
                user.cart[i].quantity -= 1;
               }
            }
        }
        
       //console.log(' Add to cart');
       user = await user.save()
       res.json(user)
       
    } catch (error) {
        //console.log('Add to cart error')
        res.status(500).json({error: error.message})
    }
})

// userRouter.get('/api/orders/me', auth , async (req, res) =>{
//     try {

//         let orders = await Order.find({userId : req.user})
//         res.json(orders);
        
//     } catch (error) {
//         res.status(500).json({error: error.message})
//     }

// })


module.exports = userRouter