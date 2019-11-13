Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A053FAAB7
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Nov 2019 08:16:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbfKMHQ6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Nov 2019 02:16:58 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:39176 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbfKMHQ5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Nov 2019 02:16:57 -0500
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID xAD7Gl0a011488, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCAS11.realtek.com.tw[172.21.6.12])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id xAD7Gl0a011488
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Nov 2019 15:16:47 +0800
Received: from RTITMBSVM04.realtek.com.tw ([fe80::e404:880:2ef1:1aa1]) by
 RTITCAS11.realtek.com.tw ([fe80::7c6d:ced5:c4ff:8297%15]) with mapi id
 14.03.0468.000; Wed, 13 Nov 2019 15:16:47 +0800
From:   Tony Chuang <yhchuang@realtek.com>
To:     Chris Chiu <chiu@endlessm.com>
CC:     Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Brian Norris <briannorris@chromium.org>
Subject: RE: [PATCH 3/4] rtw88: pci: enable CLKREQ function if host supports it
Thread-Topic: [PATCH 3/4] rtw88: pci: enable CLKREQ function if host
 supports it
Thread-Index: AQHVlVzGDP6XmjIWP0CNsTeAQy9ElaeIIiEAgACWhrA=
Date:   Wed, 13 Nov 2019 07:16:46 +0000
Message-ID: <F7CD281DE3E379468C6D07993EA72F84D1927EEB@RTITMBSVM04.realtek.com.tw>
References: <20191107111603.12317-1-yhchuang@realtek.com>
 <20191107111603.12317-4-yhchuang@realtek.com>
 <CAB4CAwd6MDSyPTVGr-3T6nNTpJiJy1jEfNWtyriqoMJyV83jdw@mail.gmail.com>
In-Reply-To: <CAB4CAwd6MDSyPTVGr-3T6nNTpJiJy1jEfNWtyriqoMJyV83jdw@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.68.183]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

PiBPbiBUaHUsIE5vdiA3LCAyMDE5IGF0IDc6MTYgUE0gPHloY2h1YW5nQHJlYWx0ZWsuY29tPiB3
cm90ZToNCj4gPg0KPiA+IEZyb206IFlhbi1Ic3VhbiBDaHVhbmcgPHloY2h1YW5nQHJlYWx0ZWsu
Y29tPg0KPiA+DQo+ID4gQnkgUmVhbHRlaydzIGRlc2lnbiwgdGhlcmUgYXJlIHR3byBIVyBtb2R1
bGVzIGFzc29jaWF0ZWQgZm9yIENMS1JFUSwNCj4gPiBvbmUgaXMgcmVzcG9uc2libGUgdG8gZm9s
bG93IHRoZSBQQ0lFIGhvc3Qgc2V0dGluZ3MsIGFuZCBhbm90aGVyDQo+ID4gaXMgdG8gYWN0dWFs
bHkgd29ya2luZyBvbiBpdC4gQnV0IHRoZSBtb2R1bGUgdGhhdCBpcyBhY3R1YWxseSB3b3JraW5n
DQo+ID4gb24gaXQgaXMgZGVmYXVsdCBkaXNhYmxlZCwgYW5kIGRyaXZlciBzaG91bGQgZW5hYmxl
IHRoYXQgbW9kdWxlIGlmDQo+ID4gaG9zdCBhbmQgZGV2aWNlIGhhdmUgc3VjY2Vzc2Z1bGx5IHN5
bmMnZWQgd2l0aCBlYWNoIG90aGVyLg0KPiA+DQo+ID4gVGhlIG1vZHVsZSBpcyBkZWZhdWx0IGRp
c2FibGVkIGJlY2F1c2Ugc29tZXRpbWVzIHRoZSBob3N0IGRvZXMgbm90DQo+ID4gc3VwcG9ydCBp
dCwgYW5kIGlmIHRoZXJlIGlzIGFueSBpbmNvcnJlY3Qgc2V0dGluZ3MgKGV4LiBDTEtSRVEjIGlz
DQo+ID4gbm90IEJpLURpcmVjdGlvbiksIGRldmljZSBjYW4gYmUgbG9zdCBhbmQgZGlzY29ubmVj
dGVkIHRvIHRoZSBob3N0Lg0KPiA+DQo+ID4gU28gZHJpdmVyIHNob3VsZCBmaXJzdCBjaGVjayBh
ZnRlciBob3N0IGFuZCBkZXZpY2UgYXJlIHN5bmMnZWQsIGFuZA0KPiA+IHRoZSBob3N0IGRvZXMg
c3VwcG9ydCB0aGUgZnVuY3Rpb24gYW5kIHNldCBpdCBpbiBjb25maWd1cmF0aW9uDQo+ID4gc3Bh
Y2UsIHRoZW4gZHJpdmVyIGNhbiB0dXJuIG9uIHRoZSBIVyBtb2R1bGUgdG8gd29ya2luZyBvbiBp
dC4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFlhbi1Ic3VhbiBDaHVhbmcgPHloY2h1YW5nQHJl
YWx0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0
dzg4L3BjaS5jIHwgODMNCj4gKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gIGRyaXZlcnMv
bmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODgvcGNpLmggfCAgNSArKw0KPiA+ICAyIGZpbGVzIGNo
YW5nZWQsIDg4IGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25l
dC93aXJlbGVzcy9yZWFsdGVrL3J0dzg4L3BjaS5jDQo+IGIvZHJpdmVycy9uZXQvd2lyZWxlc3Mv
cmVhbHRlay9ydHc4OC9wY2kuYw0KPiA+IGluZGV4IDZkMWFhNmY0MWU4NC4uNGZjZWY4YTZmYzQy
IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODgvcGNp
LmMNCj4gPiArKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg4L3BjaS5jDQo+
ID4gQEAgLTEwODEsNiArMTA4MSwzMyBAQCBzdGF0aWMgdm9pZCBydHdfZGJpX3dyaXRlOChzdHJ1
Y3QgcnR3X2Rldg0KPiAqcnR3ZGV2LCB1MTYgYWRkciwgdTggZGF0YSkNCj4gPiAgICAgICAgIFdB
Uk4oZmxhZywgImZhaWxlZCB0byB3cml0ZSB0byBEQkkgcmVnaXN0ZXIsIGFkZHI9MHglMDR4XG4i
LA0KPiBhZGRyKTsNCj4gPiAgfQ0KPiA+DQo+ID4gK3N0YXRpYyBpbnQgcnR3X2RiaV9yZWFkOChz
dHJ1Y3QgcnR3X2RldiAqcnR3ZGV2LCB1MTYgYWRkciwgdTggKnZhbHVlKQ0KPiA+ICt7DQo+ID4g
KyAgICAgICB1MTYgcmVhZF9hZGRyID0gYWRkciAmIEJJVFNfREJJX0FERFJfTUFTSzsNCj4gPiAr
ICAgICAgIHU4IGZsYWc7DQo+ID4gKyAgICAgICB1OCBjbnQ7DQo+ID4gKw0KPiA+ICsgICAgICAg
cnR3X3dyaXRlMTYocnR3ZGV2LCBSRUdfREJJX0ZMQUdfVjEsIHJlYWRfYWRkcik7DQo+ID4gKyAg
ICAgICBydHdfd3JpdGU4KHJ0d2RldiwgUkVHX0RCSV9GTEFHX1YxICsgMiwgQklUX0RCSV9SRkxB
RyA+Pg0KPiAxNik7DQo+ID4gKw0KPiA+ICsgICAgICAgZm9yIChjbnQgPSAwOyBjbnQgPCBSVFdf
UENJX1dSX1JFVFJZX0NOVDsgY250KyspIHsNCj4gPiArICAgICAgICAgICAgICAgZmxhZyA9IHJ0
d19yZWFkOChydHdkZXYsIFJFR19EQklfRkxBR19WMSArIDIpOw0KPiA+ICsgICAgICAgICAgICAg
ICBpZiAoZmxhZyA9PSAwKQ0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGJyZWFrOw0KPiBX
aHkgbm90IGp1c3QgZG9pbmcgJyBydHdfcmVhZDgocnR3ZGV2LCByZWFkX2FkZHIpOycgYW5kIHJl
dHVybiBoZXJlPw0KPiBUaGVuIHlvdSBkb24ndCBuZWVkIHRvIGNoZWNrIHRoZSBmbGFnICE9IDAg
YXQgdGhlIGZvbGxvd2luZy4gSXQgd291bGQNCj4gbWFrZSB0aGUgY29kZSBjbGVhbmVyIGFuZCBz
YW1lIGV4cHJlc3NpdmUuDQoNCk1heWJlIGl0IHdvdWxkIGxvb2sgY2xlYW5lciwgYnV0IHlvdSBu
ZWVkIHRvIGFkZCBzdGF0ZW1lbnRzIHdoZW4NCidpZiAoZmxhZyA9PSAwKScsIHRoZW4gdGhlIGlu
ZGVudHMgd2lsbCBiZSBkZWVwZXIuDQpBbHNvIHlvdSB3aWxsIG5lZWQgdG8gcmV0dXJuIDAgYXQg
dGhlIGVuZCBpZiAnZmxhZyA9PSAwJy4NCg0KU28geW91IHN0aWxsIHRoaW5rIGl0J3MgY2xlYW5l
ciB0byB3cml0ZSBpdCB0aGF0IHdheT8gSWYgc28sIEkgY2FuIHRyeSB0byBzZW5kDQp2MiBmb3Ig
aXQuDQoNCj4gDQo+ID4gKw0KPiA+ICsgICAgICAgICAgICAgICB1ZGVsYXkoMTApOw0KPiA+ICsg
ICAgICAgfQ0KPiA+ICsNCj4gPiArICAgICAgIGlmIChmbGFnICE9IDApIHsNCj4gPiArICAgICAg
ICAgICAgICAgV0FSTigxLCAiZmFpbGVkIHRvIHJlYWQgREJJIHJlZ2lzdGVyLCBhZGRyPTB4JTA0
eFxuIiwNCj4gYWRkcik7DQo+ID4gKyAgICAgICAgICAgICAgIHJldHVybiAtRUlPOw0KPiA+ICsg
ICAgICAgfQ0KPiA+ICsNCj4gPiArICAgICAgIHJlYWRfYWRkciA9IFJFR19EQklfUkRBVEFfVjEg
KyAoYWRkciAmIDMpOw0KPiA+ICsgICAgICAgKnZhbHVlID0gcnR3X3JlYWQ4KHJ0d2RldiwgcmVh
ZF9hZGRyKTsNCj4gPiArICAgICAgIHJldHVybiAwOw0KPiA+ICt9DQo+ID4gKw0KPiA+IC0tDQo+
ID4gMi4xNy4xDQo+ID4NCj4gDQoNCllhbi1Ic3Vhbg0K
