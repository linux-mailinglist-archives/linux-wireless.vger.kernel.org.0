Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5574B9E767
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2019 14:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbfH0MMD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 27 Aug 2019 08:12:03 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:53894 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbfH0MMD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 27 Aug 2019 08:12:03 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x7RCBrZd019444, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCAS12.realtek.com.tw[172.21.6.16])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x7RCBrZd019444
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Aug 2019 20:11:53 +0800
Received: from RTITMBSVM04.realtek.com.tw ([fe80::e404:880:2ef1:1aa1]) by
 RTITCAS12.realtek.com.tw ([::1]) with mapi id 14.03.0439.000; Tue, 27 Aug
 2019 20:11:52 +0800
From:   Tony Chuang <yhchuang@realtek.com>
To:     =?utf-8?B?SsOhbiBWZXNlbMO9?= <jano.vesely@gmail.com>,
        Daniel Drake <drake@endlessm.com>
CC:     "briannorris@chromium.org" <briannorris@chromium.org>,
        "gojun077@gmail.com" <gojun077@gmail.com>,
        "kvalo@codeaurora.org" <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        "linux@endlessm.com" <linux@endlessm.com>
Subject: RE: [PATCH v2] rtw88: pci: enable MSI interrupt
Thread-Topic: [PATCH v2] rtw88: pci: enable MSI interrupt
Thread-Index: AQHVTPoaeqcBDNg9T0OOoI++rn3wpqcH2mYAgAAMhwCABxwygA==
Date:   Tue, 27 Aug 2019 12:11:51 +0000
Message-ID: <F7CD281DE3E379468C6D07993EA72F84D18AE7C8@RTITMBSVM04.realtek.com.tw>
References: <1565166487-22048-1-git-send-email-yhchuang@realtek.com>
 <20190823063728.14117-1-drake@endlessm.com>
 <CA+K+NcSYKEkdx5ux6iwUs7pMidObZBrg9yDcP1zT73DcccpDPQ@mail.gmail.com>
In-Reply-To: <CA+K+NcSYKEkdx5ux6iwUs7pMidObZBrg9yDcP1zT73DcccpDPQ@mail.gmail.com>
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

SGkgRGFuaWVsIGFuZCBKw6FuLA0KDQoNCj4gRnJvbTogSsOhbiBWZXNlbMO9ID4gU2VudDogRnJp
ZGF5LCBBdWd1c3QgMjMsIDIwMTkgMzoyMiBQTQ0KPiBPbiBGcmksIEF1ZyAyMywgMjAxOSBhdCAy
OjM3IEFNIERhbmllbCBEcmFrZSA8ZHJha2VAZW5kbGVzc20uY29tPiB3cm90ZToNCj4gPg0KPiA+
ID4gKyAgICAgcnR3X3BjaV9kaXNhYmxlX2ludGVycnVwdChydHdkZXYsIHJ0d3BjaSk7DQo+ID4N
Cj4gPiBJIGNoZWNrZWQgdGhlIGRpc2N1c3Npb24gb24gdGhlIHYxIHBhdGNoIHRocmVhZCBidXQg
SSBzdGlsbCBkb24ndCBmb2xsb3cNCj4gPiB0aGlzLg0KPiA+DQo+ID4gWW91J3JlIHdvcnJpZWQg
YWJvdXQgdGhlIGNhc2Ugd2hlcmUgd2UncmUgaW5zaWRlIHRoZSBpbnRlcnJ1cHQgaGFuZGxlciBh
bmQ6DQo+ID4gIDEuIFdlIHJlYWQgdGhlIGludGVycnVwdCBzdGF0dXMgdG8gbm90ZSB3aGF0IG5l
ZWRzIHRvIGJlIGRvbmUNCj4gPiAgMi4gPGFub3RoZXIgaW50ZXJydXB0IGFycml2ZXMgaGVyZSwg
cmVxdWlyaW5nIG90aGVyIHdvcmsgdG8gYmUgZG9uZT4NCj4gPiAgMy4gV2UgY2xlYXIgdGhlIGlu
dGVycnVwdCBzdGF0dXMgYml0cw0KPiA+ICA0LiBXZSBwcm9jZWVkIHRvIGhhbmRsZSB0aGUgaW50
ZXJydXB0IGJ1dCBtaXNzaW5nIGFueSB3b3JrIHJlcXVlc3RlZCBieQ0KPiA+ICAgICB0aGUgaW50
ZXJydXB0IGluIHN0ZXAgMi4NCj4gPg0KPiA+IElzIHRoYXQgcmlnaHQ/DQo+ID4NCj4gPiBJJ20g
bm90IGFuIGV4cGVydCBoZXJlLCBidXQgSSBkb24ndCB0aGluayB0aGlzIGlzIHNvbWV0aGluZyB0
aGF0IGRyaXZlcnMNCj4gPiBoYXZlIHRvIHdvcnJ5IGFib3V0LiBTdXJlbHkgdGhlIGludGVycnVw
dCBjb250cm9sbGVyIGNhbiBiZSBleHBlY3RlZCB0bw0KPiA+IGhhdmUgYSBtZWNoYW5pc20gdG8g
InF1ZXVlIHVwIiBhbnkgaW50ZXJydXB0IHRoYXQgYXJyaXZlcyB3aGlsZSBhbg0KPiA+IGludGVy
cnVwdCBpcyBiZWluZyBoYW5kbGVkPyBPdGhlcndpc2UgaGFuZGxpbmcgb2YgYWxsIHR5cGVzIG9m
DQo+ID4gZWRnZS10cmlnZ2VyZWQgaW50ZXJydXB0cyAobm90IGp1c3QgTVNJKSB3b3VsZCBiZSBv
dmVybHkgcGFpbmZ1bCBhY3Jvc3MgdGhlDQo+ID4gYm9hcmQuDQo+IA0KPiBUaGF0J3MgbXkgdW5k
ZXJzdGFuZGluZyBhcyB3ZWxsLg0KPiBlbnRlcmluZyB0aGUgaW50ZXJydXB0IHZlY3RvciBjbGVh
cnMgdGhlIElGTEFHLCBzbyBhbnkgaW50ZXJydXB0IHdpbGwNCj4gd2FpdCB1bnRpbCB0aGUgSUZM
QUcgaXMgcmVzdG9yZWQsIG9yIGRlbGl2ZXJlZCB0byBhIGRpZmZlcmVudCBDUFUuDQo+IHdvdWxk
bid0IGl0IGJlIHNhZmVyIHRvIGVuYWJsZSBpbnRlcnJ1cHRzIG9ubHkgX2FmdGVyXyByZWdpc3Rl
cmluZyB0aGUNCj4gaGFuZGxlciBpbiB0aGUgInJ0d19wY2lfcmVxdWVzdF9pcnEiIGZ1bmN0aW9u
Pw0KPiANCj4gcmVnYXJkcywNCj4gSmFuDQoNCg0KWWVzIHRoYXQncyBub3Qgc29tZXRoaW5nIGRy
aXZlcnMgbmVlZCB0byBjYXJlIGFib3V0LiBCdXQgSSB0aGluayBpdCBpcw0KQmVjYXVzZSB0aGVy
ZSdzIGEgcmFjZSBjb25kaXRpb24gYmV0d2VlbiBTVy9IVyB3aGVuIGNsZWFyaW5nIHRoZSBJU1Iu
DQpJZiBpbnRlcnJ1cHQgY29tZXMgYWZ0ZXIgcmVhZGluZyBJU1IgYW5kIGJlZm9yZSB3cml0ZS0x
LWNsZWFyLCB0aGUgaW50ZXJydXB0DQpjb250cm9sbGVyIHdvdWxkIGhhdmUgaW50ZXJydXB0IHN0
YXR1cyByYWlzZWQsIGFuZCBuZXZlciBpc3N1ZSBpbnRlcnJ1cHQNCnNpZ25hbCB0byBob3N0IHdo
ZW4gb3RoZXIgbmV3IGludGVycnVwdHMgc3RhdHVzIGFyZSByYWlzZWQuDQoNClRvIGF2b2lkIHRo
aXMsIGRyaXZlciByZXF1aXJlcyB0byBwcm90ZWN0IHRoZSBJU1Igd3JpdGUtMS1jbGVhciBwcm9j
ZXNzIGJ5DQpkaXNhYmxpbmcgdGhlIElNUi4NCg0KDQo+IA0KPiANCj4gPg0KPiA+IFNlZSBlLmcu
IGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcGF0Y2gvMzMzMzY4MS8gYXMgYSByZWZlcmVu
Y2UgZm9yDQo+ID4gd2hhdCBjb3JyZWN0IGludGVycnVwdCBjb250cm9sbGVyIGJlaGF2aW91ciBz
aG91bGQgbG9vayBsaWtlLg0KPiA+DQo+ID4gPiArICAgICAgICAgICAgIHJldCA9IHBjaV9lbmFi
bGVfbXNpKHBkZXYpOw0KPiA+DQo+ID4gcGNpX2VuYWJsZV9tc2koKSBpcyAiZGVwcmVjYXRlZCwg
ZG9uJ3QgdXNlIg0KDQpEbyB5b3UgbWVhbiBJIHNob3VsZCByZW1vdmUgdGhpcz8NCkJ1dCBJIGNh
bm5vdCBmaW5kIGFub3RoZXIgcHJvcGVyIHdheSB0byBlbmFibGUgdGhlIE1TSS4NCk1heWJlIHBj
aV9hbGxvY19pcnFfdmVjdG9ycygpIGNvdWxkIHdvcmsgYnV0IEkgYW0gbm90IHN1cmUgaWYNCkl0
IGlzIHJlY29tbWVuZGVkLg0KDQoNCllhbi1Ic3Vhbg0KDQo=
