from ibapi.client import EClient
from ibapi.wrapper import EWrapper
from ibapi.contract import Contract
from ibapi.utils import iswrapper
import time as time
import threading as th


class MarketReader(EWrapper, EClient):
    ''' Serves as the client and the wrapper '''
    def __init__(self, addr, port, client_id):
        EWrapper.__init__(self)
        EClient. __init__(self, self)

        # Connect to TWS
        self.connect(addr, port, client_id)
        # Launch the client thread
        thread = th.Thread(target=self.run)
        thread.start()

    @iswrapper
    def tickByTickMidPoint(self, reqId, tick_time, midpoint):
        ''' Called in response to reqTickByTickData '''
        print('tickByTickMidPoint - Midpoint tick: {}'.
        format(midpoint))

    @iswrapper
    def tickPrice(self, reqId, field, price, attribs):
        ''' Called in response to reqMktData '''
        print('tickPrice - field: {}, price: {}'.format(field,
                                                        price))

    @iswrapper
    def tickSize(self, reqId, field, size):
        ''' Called in response to reqMktData '''
        print('tickSize - field: {}, size: {}'.format(field,
                                                      size))

    @iswrapper
    def realtimeBar(self, reqId, time, open, high, low,
                    close, volume, WAP, count):
        ''' Called in response to reqRealTimeBars '''
        print('realtimeBar - Opening price: {}'.format(open))

    @iswrapper
    def historicalData(self, reqId, bar):
        ''' Called in response to reqHistoricalData '''
        print('historicalData - Close price: {}'.format(bar.close))

    @iswrapper
    def fundamentalData(self, reqId, data):
        ''' Called in response to reqFundamentalData '''
        print('Fundamental data: ' + data)

    def error(self, reqId, code, msg):
        print('Error {}: {}'.format(code, msg))


# Create the client and connect to TWS
client = MarketReader('127.0.0.1', 7496, 0)

# Request the current time
con = Contract()
con.symbol = 'IBM'
con.secType = 'STK'
con.exchange = 'SMART'
con.currency = 'USD'

# Request ten ticks containing midpoint data
client.reqTickByTickData(0, con, 'MidPoint', 10, True)

# Request market data
client.reqMktData(1, con, '', False, False, [])

# Request current bars
client.reqRealTimeBars(2, con, 5, 'MIDPOINT', True, [])

# Request historical bars
now = time.datetime.now().strftime("%Y%m%d, %H:%M:%S")
client.reqHistoricalData(3, con, now, '2 w', '1 day', 'MIDPOINT', False, 1,
                         False, [])

# Request fundamental data:
client.reqFundamentalData(4, con, 'ReportSnapshot', [])
time.time.sleep(5)
client.disconnect()
