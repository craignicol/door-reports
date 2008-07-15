class A:
    def method(self):
        """ This method does not exist. """
        raise NotImplementedError

    def base(self):
        """ a base method. """
        print "base"

class B(A):
    def method(self):
        """ This method does exist. """
        print ("Hello, world!")


#A().method()
A().base()
B().method()
B().base()
