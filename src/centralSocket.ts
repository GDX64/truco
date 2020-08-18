import io from 'socket.io-client'

const socket = io('http://localhost:5000/')

export default () => {
    socket.on('welcome', (message: string) => {
        console.log(message)
        socket.emit('thanks', "thank you")
    })
}

export { socket }