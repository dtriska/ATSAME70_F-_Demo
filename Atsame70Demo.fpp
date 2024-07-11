module ATSAME70 {

  @ An ATSAME70 demonstrator component
  active component Atsame70Demo {

    # ----------------------------------------------------------------------
    # Types
    # ----------------------------------------------------------------------

    enum LedState {
      ON = 0
      OFF = 1
    }

    # ----------------------------------------------------------------------
    # General ports
    # ----------------------------------------------------------------------

    @ Input Scheduler port - called periodically
    async input port Run: Svc.Sched

    @ Input port for receiving UART data
    async input port UartRead: Drv.ByteStreamRecv

    @ Output Port for writing GPIO values
    output port GpioWrite: [1] Drv.GpioWrite

    @ Output Port for writing UART data
    output port UartWrite: Drv.ByteStreamSend

    @ Output port for sending UART buffers to use for reading
    output port UartBuffers: Fw.BufferSend

    # ----------------------------------------------------------------------
    # Special ports
    # ----------------------------------------------------------------------

    @ Command receive
    command recv port cmdIn

    @ Command registration
    command reg port cmdRegOut

    @ Command response
    command resp port cmdResponseOut

    @ Event
    event port eventOut

    @ Parameter get
    param get port prmGetOut

    @ Parameter set
    param set port prmSetOut

    @ Telemetry
    telemetry port tlmOut

    @ Text event
    text event port textEventOut

    @ Time get
    time get port timeGetOut

    # ----------------------------------------------------------------------
    # Commands
    # ----------------------------------------------------------------------

    @ Command to turn LED on or off
    async command SetLed(
                          state: LedState @< LED state (ON/OFF)
                        ) \
      opcode 1

    @ Command to send a string to the UART
    async command SendUartString(
                                 $text: string size 40 @< String to send
                               ) \
      opcode 2

    # ----------------------------------------------------------------------
    # Events
    # ----------------------------------------------------------------------

    @ LED state changed
    event LedStateChanged(
                           state: LedState @< New LED state
                         ) \
      severity activity high \
      id 0 \
      format "LED state changed to {}"

    @ Message sent on UART
    event UartMsgOut(
                      msg: string size 40 @< The message
                    ) \
      severity activity high \
      id 1 \
      format "Sent msg {} on UART"

    @ Message received on UART
    event UartMsgIn(
                     msg: string size 40 @< The message
                   ) \
      severity activity high \
      id 2 \
      format "Received msg {} on UART"

    # ----------------------------------------------------------------------
    # Parameters
    # ----------------------------------------------------------------------

    @ Initial state of the LED
    param InitialLedState: LedState default LedState.OFF id 0 \
      set opcode 10 \
      save opcode 11

    # ----------------------------------------------------------------------
    # Telemetry
    # ----------------------------------------------------------------------

    @ Number of bytes sent on the UART
    telemetry UartSentBytes: U32 id 0

    @ Number of bytes received on the UART
    telemetry UartRecvBytes: U32 id 1

    @ Last received UART text message
    telemetry LastUartMsg: string size 40 id 2

  }

}
