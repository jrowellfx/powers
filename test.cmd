#!/usr/bin/env python3

import sys
import cmd

class powersQuiz(cmd.Cmd):
    'Testing using cmd library for quizMe program'

    def cmdloop(self, intro=None):
        print('cmdloop(%s)' % intro)
        return cmd.Cmd.cmdloop(self, intro)

    def __init__(self) :
        self.i = 1
        cmd.Cmd.__init__(self)
        self.prompt = "1: "
    
    def preloop(self):
        print('preloop()')
    
    def postloop(self):
        print('postloop()')
        
    def parseline(self, line):
        print('parseline(%s) =>' % line, end=' ')
        ret = cmd.Cmd.parseline(self, line)
        print(ret)
        return ret
    
    def onecmd(self, s):
        print('onecmd(%s)' % s)
        return cmd.Cmd.onecmd(self, s)

    def emptyline(self):
        print('emptyline()')
        self.i += 1
        print('i = ' + str(self.i))
        self.prompt = str(self.i*self.i) + ": "
    
    def default(self, line):
        print('default(%s)' % line)
        self.i = int(line)
        print('i = ' + str(self.i))
        self.prompt = str(self.i*self.i) + ": "
    
    def precmd(self, line):
        print('precmd(%s)' % line)
        return cmd.Cmd.precmd(self, line)
    
    def postcmd(self, stop, line):
        print('postcmd(%s, %s)' % (stop, line))
        print('')
        return cmd.Cmd.postcmd(self, stop, line)
    
    def do_skip(self, line):
        "Don't know the answer, skip the question being asked"
        print('skipping')

    def do_EOF(self, line):
        "Exit"
        return True

def main():

    # Redefine the exception handling routine so that it does NOT
    # do a trace dump if the user types ^C while the command is running.
    #
    old_excepthook = sys.excepthook
    def new_hook(exceptionType, value, traceback):
        if exceptionType != KeyboardInterrupt and exceptionType != IOError:
            old_excepthook(exceptionType, value, traceback)
        else:
            pass
    sys.excepthook = new_hook

    powersQuiz().cmdloop()
    print('finished cmd - going to exit')
    sys.exit(0)
        
if __name__ == '__main__':
    main()
