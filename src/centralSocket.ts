import io from 'socket.io-client'

const socket = io('https://supertruco.herokuapp.com/')

export default () => {
    console.log("Init")
}

export { socket }