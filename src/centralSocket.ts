import io from 'socket.io-client'

const socket = io('http://localhost:5000/')

export default () => {
    console.log("Init")
}

export { socket }