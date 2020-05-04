Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41C901C35FD
	for <lists+linux-wireless@lfdr.de>; Mon,  4 May 2020 11:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728379AbgEDJqH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 4 May 2020 05:46:07 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:47983 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728263AbgEDJqH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 4 May 2020 05:46:07 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 0449jn8eB026037, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 0449jn8eB026037
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 4 May 2020 17:45:49 +0800
Received: from RTEXMB01.realtek.com.tw (172.21.6.94) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 4 May 2020 17:45:49 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 4 May 2020 17:45:48 +0800
Received: from RTEXMB04.realtek.com.tw ([fe80::8001:f5f5:a41e:f8d4]) by
 RTEXMB04.realtek.com.tw ([fe80::8001:f5f5:a41e:f8d4%3]) with mapi id
 15.01.1779.005; Mon, 4 May 2020 17:45:48 +0800
From:   Tony Chuang <yhchuang@realtek.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC:     "kvalo@codeaurora.org" <kvalo@codeaurora.org>,
        Pkshih <pkshih@realtek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "briannorris@chromium.org" <briannorris@chromium.org>,
        Kevin Yang <kevin_yang@realtek.com>
Subject: RE: [PATCH 26/40] rtw88: 8723d: add IQ calibration
Thread-Topic: [PATCH 26/40] rtw88: 8723d: add IQ calibration
Thread-Index: AQHWFIx5cGbgeN0Vb0mydPKyOTuI7KiRUWsAgAZudkA=
Date:   Mon, 4 May 2020 09:45:48 +0000
Message-ID: <feb792d067fc4319a2a1c294ac3bfc6f@realtek.com>
References: <20200417074653.15591-1-yhchuang@realtek.com>
 <20200417074653.15591-27-yhchuang@realtek.com>
 <20200430150206.3bw7lp7wslgeuaqx@linutronix.de>
In-Reply-To: <20200430150206.3bw7lp7wslgeuaqx@linutronix.de>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.68.175]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

U2ViYXN0aWFuIEFuZHJ6ZWogU2lld2lvciA8YmlnZWFzeUBsaW51dHJvbml4LmRlPiB3cml0ZXM6
DQoNCj4gT24gMjAyMC0wNC0xNyAxNTo0NjozOSBbKzA4MDBdLCB5aGNodWFuZ0ByZWFsdGVrLmNv
bSB3cm90ZToNCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9y
dHc4OC9ydHc4NzIzZC5jDQo+IGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OC9y
dHc4NzIzZC5jDQo+ID4gaW5kZXggOTQ3ODRjN2YwNzQzLi5iNjZiZDk2OWUwMDcgMTAwNjQ0DQo+
ID4gLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OC9ydHc4NzIzZC5jDQo+
ID4gKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OC9ydHc4NzIzZC5jDQo+
IOKApg0KPiA+ICtzdHJ1Y3QgaXFrX2JhY2t1cF9yZWdzIHsNCj4gPiArCXUzMiBhZGRhW0lRS19B
RERBX1JFR19OVU1dOw0KPiA+ICsJdTggbWFjOFtJUUtfTUFDOF9SRUdfTlVNXTsNCj4gPiArCXUz
MiBtYWMzMltJUUtfTUFDMzJfUkVHX05VTV07DQo+ID4gKwl1MzIgYmJbSVFLX0JCX1JFR19OVU1d
Ow0KPiA+ICsNCj4gPiArCXUzMiBsdGVfcGF0aDsNCj4gPiArCXUzMiBsdGVfZ250Ow0KPiA+ICsN
Cj4gPiArCXU4IGJ0Z19zZWw7DQo+ID4gKwl1MzIgYmJfc2VsX2J0ZzsNCj4gPiArDQo+ID4gKwl1
OCBpZ2lhOw0KPiA+ICsJdTggaWdpYjsNCj4gDQo+IFRoZSBzdHJ1Y3QgaGFzIDEyOCBieXRlcy4g
UHV0dGluZyBidGdfc2VsIGFmdGVyIGJiX3NlbF9idGcgd2lsbCByZXN1bHQNCj4gaW4gMTI0IGJ5
dGVzLiBIb3cgbGlrZWx5IGlzIGl0IHRoYXQgaXQgd2lsbCBncm93PyBJJ20gYXNraW5nIGJlY2F1
c2UgaXQNCj4gaXMgYWxsb2NhdGVkIG9uIHN0YWNrLg0KDQpXZSBuZWVkIHRvIGJhY2t1cCBhIGxv
dCBvZiB0aGUgcmVnaXN0ZXIgdmFsdWVzIGZvciBkb2luZyBJUUsuDQpJIHRoaW5rIGl0J3MgaW5l
dml0YWJsZSwganVzdCBhYm91dCB3aGVyZSBzaG91bGQgd2UgcHV0IHRoZW0uDQpBbmQgYXMgdGhl
cmUncyBvbmx5IDg3MjNEIGlzIHVzaW5nIFNXIElRSywgdGhpcyBzdHJ1Y3Qgd2lsbCBvbmx5IGJl
DQp1c2VkIGJ5IDg3MjNELCBzbyBhZGQgdGhlbSBpbnRvIHJ0d2RldiBpcyBub3Qgc3VpdGFibGUu
DQoNCkFub3RoZXIgd2F5IGlzIHRoYXQgd2UgY2FuIGttYWxsb2MoKSBhbmQgdGhlbiBrZnJlZSgp
IGl0IGFmdGVyDQpJUUsgaXMgZG9uZS4NCg0KPiANCj4gPiArfTsNCj4gPiArDQo+ID4gK3N0YXRp
YyB2b2lkIHJ0dzg3MjNkX2lxa19iYWNrdXBfcmVncyhzdHJ1Y3QgcnR3X2RldiAqcnR3ZGV2LA0K
PiA+ICsJCQkJICAgICBzdHJ1Y3QgaXFrX2JhY2t1cF9yZWdzICpiYWNrdXApDQo+ID4gK3sNCj4g
PiArCWludCBpOw0KPiA+ICsNCj4gPiArCWZvciAoaSA9IDA7IGkgPCBJUUtfQUREQV9SRUdfTlVN
OyBpKyspDQo+ID4gKwkJYmFja3VwLT5hZGRhW2ldID0gcnR3X3JlYWQzMihydHdkZXYsIGlxa19h
ZGRhX3JlZ3NbaV0pOw0KPiA+ICsNCj4gPiArCWZvciAoaSA9IDA7IGkgPCBJUUtfTUFDOF9SRUdf
TlVNOyBpKyspDQo+ID4gKwkJYmFja3VwLT5tYWM4W2ldID0gcnR3X3JlYWQ4KHJ0d2RldiwgaXFr
X21hYzhfcmVnc1tpXSk7DQo+ID4gKwlmb3IgKGkgPSAwOyBpIDwgSVFLX01BQzMyX1JFR19OVU07
IGkrKykNCj4gPiArCQliYWNrdXAtPm1hYzMyW2ldID0gcnR3X3JlYWQzMihydHdkZXYsIGlxa19t
YWMzMl9yZWdzW2ldKTsNCj4gPiArDQo+ID4gKwlmb3IgKGkgPSAwOyBpIDwgSVFLX0JCX1JFR19O
VU07IGkrKykNCj4gPiArCQliYWNrdXAtPmJiW2ldID0gcnR3X3JlYWQzMihydHdkZXYsIGlxa19i
Yl9yZWdzW2ldKTsNCj4gPiArDQo+ID4gKwliYWNrdXAtPmlnaWEgPSAodTgpcnR3X3JlYWQzMl9t
YXNrKHJ0d2RldiwgUkVHX09GRE0wX1hBQUdDMSwNCj4gTUFTS0JZVEUwKTsNCj4gPiArCWJhY2t1
cC0+aWdpYiA9ICh1OClydHdfcmVhZDMyX21hc2socnR3ZGV2LCBSRUdfT0ZETTBfWEJBR0MxLA0K
PiBNQVNLQllURTApOw0KPiANCj4gaWdpW2FiXSBpcyBhbHJlYXkgdTgsIG5vIG5lZWQgZm9yIGNh
c3QuDQoNCkl0J3MgYmVjYXVzZSBydHdfcmVhZDMyX21hc2soKSByZXR1cm5zIHUzMiwgYnV0IGJl
Y2F1c2Ugd2UNCm1hc2sgd2l0aCBvbmUgYnl0ZSBvbmx5Lg0KDQo+IA0KPiA+ICsNCj4gPiArCWJh
Y2t1cC0+YmJfc2VsX2J0ZyA9IHJ0d19yZWFkMzIocnR3ZGV2LCBSRUdfQkJfU0VMX0JURyk7DQo+
ID4gK30NCj4g4oCmDQo+IA0KPiA+ICtzdGF0aWMgdTggcnR3ODcyM2RfaXFrX3J4X3BhdGgoc3Ry
dWN0IHJ0d19kZXYgKnJ0d2RldiwNCj4gPiArCQkJICAgICAgIGNvbnN0IHN0cnVjdCBydHdfODcy
M2RfaXFrX2NmZyAqaXFrX2NmZywNCj4gPiArCQkJICAgICAgIGNvbnN0IHN0cnVjdCBpcWtfYmFj
a3VwX3JlZ3MgKmJhY2t1cCkNCj4gPiArew0KPiA+ICsJdTMyIHR4X3gsIHR4X3k7DQo+ID4gKwl1
OCByZXN1bHQgPSAweDAwOw0KPiANCj4gWW91IGNvdWxkIGF2b2lkIHRoZSBleHBsaWNpdCBpbml0
IG9mIGByZXN1bHQnIChtYXliZSBldmVuIHVzZSBgcmV0JyBmb3INCj4gbGVzcyBrZXkgc3Ryb2tl
cyBhbmQgYXZvaWRpbmcgdGhlIGNvbmZ1c2lvbiB3aXRoIHRoZSBgcmVzdWx0JyBhcnJheSB1c2Vk
DQo+IGJ5IHRoZSBvdGhlciBmdW5jdGlvbnMgaGVyZSkgYW5kIHRoZW4NCg0KVGhlIHJlc3VsdCBz
aG91bGQgYmUgaW5pdGVkIHRvIHplcm8gaGVyZSwgYmVjYXVzZSB0aGUgdmFsdWUNCm9mIGl0IGlz
IG9yLWVkIGJ5IHRoZSBJUUsgc3RhdHVzLCBzdWNoIGFzOg0KDQoJcmVzdWx0IHw9IHJ0dzg3MjNk
X2lxa19jaGVja190eF9mYWlsZWQocnR3ZGV2LCBpcWtfY2ZnKTsNCg0KQW5kIHllcywgdGhlIG5h
bWUgaXMgYSBsaXR0bGUgY29uZnVzZWQgdG8gYmUgdGhlIHNhbWUuDQpTaG91bGQgdXNlIGRpZmZl
cmVudCBuYW1lIGZvciB0aGVtLg0KDQo+IA0KPiDigKYNCj4gPiArCXJ0dzg3MjNkX2lxa19vbmVf
c2hvdChydHdkZXYsIGZhbHNlLCBpcWtfY2ZnKTsNCj4gPiArCXJlc3VsdCB8PSBydHc4NzIzZF9p
cWtfY2hlY2tfdHhfZmFpbGVkKHJ0d2RldiwgaXFrX2NmZyk7DQo+IA0KPiBub3Qgb3IgdGhlIHJl
dHVybmVkIHZhbHVlIGhlcmUuIFNpbmNlIHlvdSBkb24ndCBjb2xsZWN0IGl0IGZyb20gbXVsdGlw
bGUNCj4gZnVuY3Rpb25zIEkgZG9uJ3Qgc2VlIHRoZSByZWFzb24gZm9yIGl0Lg0KDQpJdCBhY3R1
YWxseSBkb2VzIGNvbGxlY3QgdGhlbSBmcm9tIHR3byBmdW5jdGlvbnMsIHRoZXkgYXJlIHRoZQ0K
c2FtZSwgYnV0IGFyZSBkb25lIHR3aWNlLCBoZW5jZSB1c2luZyB8PSBoZXJlLg0KDQo+IA0KPiA+
ICsJaWYgKCFyZXN1bHQpDQo+ID4gKwkJZ290byByZXN0b3JlOw0KPiDigKYNCj4gPiArCXJ0dzg3
MjNkX2lxa19vbmVfc2hvdChydHdkZXYsIGZhbHNlLCBpcWtfY2ZnKTsNCj4gPiArCXJlc3VsdCB8
PSBydHc4NzIzZF9pcWtfY2hlY2tfcnhfZmFpbGVkKHJ0d2RldiwgaXFrX2NmZyk7DQo+IA0KPiBT
YW1lIGhlcmUuDQo+IA0KPiA+ICtyZXN0b3JlOg0KPiA+ICsJcnR3ODcyM2RfaXFrX3R4cnhfcGF0
aF9wb3N0KHJ0d2RldiwgaXFrX2NmZywgYmFja3VwKTsNCj4gPiArDQo+ID4gKwlyZXR1cm4gcmVz
dWx0Ow0KPiA+ICt9DQo+ID4gKw0KPiDigKYNCj4gPiArDQo+ID4gK3N0YXRpYyB2b2lkIHJ0dzg3
MjNkX3BoeV9jYWxpYnJhdGlvbihzdHJ1Y3QgcnR3X2RldiAqcnR3ZGV2KQ0KPiA+ICt7DQo+ID4g
KwlzdHJ1Y3QgcnR3X2RtX2luZm8gKmRtX2luZm8gPSAmcnR3ZGV2LT5kbV9pbmZvOw0KPiA+ICsJ
czMyIHJlc3VsdFtJUUtfUk9VTkRfU0laRV1bSVFLX05SXTsNCj4gPiArCXN0cnVjdCBpcWtfYmFj
a3VwX3JlZ3MgYmFja3VwOw0KPiANCj4gSSBkb24ndCBrbm93IGhvdyBkZWVwIHlvdSBhcmUgaW4g
dGhlIGNhbGwgY2hhaW4sIGJ1dCBgcmVzdWx0JyB0YWtlcyAxMjgNCj4gYnl0ZXMgYW5kIGBiYWNr
dXAnIGFzIHdlbGwgKHRoaXMgY291bGQgYmUgMTI0KS4NCj4gSSdtIG5vdCBzYXlpbmcgdGhhdCB0
aGlzIGlzIGJhZCwganVzdCB0aGF0IHlvdSBrZWVwIGFuIGV5ZSBvbiBpdCBzaW5jZQ0KPiB0aG9z
ZSB0d28gdGFrZSAyNTYgYnl0ZXMuDQoNCkkgY2FuIHRyeSB0byBmaXggaXQsIHRvIHNlZSBpZiB3
ZSBjYW4gcmVkdWNlIHRoYXQuDQoNCj4gDQo+ID4gKwl1OCBpLCBqOw0KPiA+ICsJdTggZmluYWxf
Y2FuZGlkYXRlID0gSVFLX1JPVU5EX0lOVkFMSUQ7DQo+ID4gKwlib29sIGdvb2Q7DQo+ID4gKw0K
PiA+ICsJcnR3X2RiZyhydHdkZXYsIFJUV19EQkdfUkZLLCAiW0lRS10gU3RhcnQhISFcbiIpOw0K
PiA+ICsNCj4gPiArCW1lbXNldChyZXN1bHQsIDAsIHNpemVvZihyZXN1bHQpKTsNCj4gDQo+IFNl
YmFzdGlhbg0KPiANCg0KWWVuLUhzdWFuDQo=
