schedule:
  highstate:
    function: state.highstate
    minutes: 30
    range:
        start: 12:00am
        end: 1:00pm

