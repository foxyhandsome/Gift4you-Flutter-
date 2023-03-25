const express = require('express')
const bodyParser = require('body-parser')
const mysql = require('mysql')

const app = express()
const port = process.env.PORT || 5000;

// parse application/x-www-form-urlencoded
app.use(bodyParser.urlencoded({ extended: false }))

// parse application/json
app.use(bodyParser.json())

// MySQL
const pool  = mysql.createPool({
    connectionLimit : 10,
    host            : 'localhost',
    user            : 'root',
    // password        : '',
    database        : 'gift4you'
})

// Get all beers
app.get('/get-user', (req, res) => {
    pool.getConnection((err, connection) => {
        if(err) throw err
        // console.log('connected as username ' + connection.threadId)
        connection.query('SELECT * from user join user_role on user.role_id = user_role.role_id', (err, rows) => {
            connection.release() // return the connection to pool

            if (!err) {
                res.send(rows)
            } else {
                console.log(err)
            }

            // if(err) throw err
            console.log('The data from beer table are: \n', rows)
        })
    })
})

app.get('/get-user-role', (req, res) => {
    pool.getConnection((err, connection) => {
        if(err) throw err
        // console.log('connected as username ' + connection.threadId)
        connection.query('SELECT * from user_role', (err, rows) => {
            connection.release() // return the connection to pool

            if (!err) {
                res.send(rows)
            } else {
                console.log(err)
            }

            // if(err) throw err
            console.log('The data from beer table are: \n', rows)
        })
    })
})

app.get('/get-user-byusername/:username', (req, res) => {
    pool.getConnection((err, connection) => {
        if(err) throw err
        connection.query('SELECT * FROM user WHERE username = ?', [req.params.username], (err, rows) => {
            connection.release() // return the connection to pool
            if (!err) {
                res.send(rows)
            } else {
                console.log(err)
            }
            
            console.log('The data from beer table are: \n', rows)
        })
    })
});

app.get('/delete-by-username/:username', (req, res) => {
    pool.getConnection((err, connection) => {
        if(err) throw err
        connection.query('DELETE FROM user WHERE username = ?', [req.params.username], (err, rows) => {
            connection.release() // return the connection to pool
            if (!err) {
                res.send(rows)
            } else {
                console.log(err)
            }
            
            console.log('The data from beer table are: \n', rows)
        })
    })
});

app.post('/edit-user', (req, res) => {

    pool.getConnection((err, connection) => {
        if(err) throw err
        console.log(`connected as id ${connection.threadId}`)

        const {fullname,username} = req.body 

        connection.query('UPDATE user SET fullname = ? WHERE username = ?', [fullname,username] , (err, rows) => {
            connection.release() // return the connection to pool

            if(!err) {
                res.send(`Username with the name: ${username} has been added.`)
            } else {
                console.log(err)
            }

        })

        console.log(req.body)
    })
})

app.listen(port, () => console.log(`Listening on port ${port}`))