const os = require('os');
const express = require('express');
const app = express();

app.use(express.json());
app.use(express.static('static'));

const courses = [
    {id: 1, name: 'course1'},
    {id: 2, name: 'course2'},
    {id: 3, name: 'course3'},
]


app.get('/', (req, res) => {
    res.send('Hello World!!!');

});

app.get('/api/courses', (req, res) => {
    res.send([1,2,3]);
})

app.get('/api/courses/:id', (req, res) => {
    //res.send(req.params.id);
    course = courses.find(c => c.id === parseInt(req.params.id));
    if (!course) res.status(404).send('The course with the given ID was not found.')
    res.send(course);
});

app.post('/api/courses', (req, res) => {
    const course = {
        id: courses.length + 1,
        name: req.body.name
    };
    console.log('Values posted');
    courses.push(course);
    res.send(course);
});

app.get('/api/posts/:year/:month', (req, res) => {
    res.send(req.query);
});

const port = process.env.port || 3000;

app.listen(port, () => console.log('Listening on port ' + port + '...'));