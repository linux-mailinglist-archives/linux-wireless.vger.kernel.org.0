Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C42EE1E75EF
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2020 08:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725808AbgE2Gbj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 May 2020 02:31:39 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:48899 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbgE2Gbj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 May 2020 02:31:39 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 04T6VOFB0006925, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 04T6VOFB0006925
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 29 May 2020 14:31:24 +0800
Received: from RTEXMB02.realtek.com.tw (172.21.6.95) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 29 May 2020 14:31:24 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 29 May 2020 14:31:24 +0800
Received: from RTEXMB04.realtek.com.tw ([fe80::8001:f5f5:a41e:f8d4]) by
 RTEXMB04.realtek.com.tw ([fe80::8001:f5f5:a41e:f8d4%3]) with mapi id
 15.01.1779.005; Fri, 29 May 2020 14:31:24 +0800
From:   Tony Chuang <yhchuang@realtek.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC:     "kvalo@codeaurora.org" <kvalo@codeaurora.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Andy Huang <tehuang@realtek.com>
Subject: RE: [PATCH 7/7] rtw88: 8821c: add phy calibration
Thread-Topic: [PATCH 7/7] rtw88: 8821c: add phy calibration
Thread-Index: AQHWLmbadmjgN7WKfUOnkjTSuDi34ai9NtaAgAFxddA=
Date:   Fri, 29 May 2020 06:31:23 +0000
Message-ID: <c0f716a120b74c7a8f3ce3fd79d8471c@realtek.com>
References: <20200520052335.22466-1-yhchuang@realtek.com>
 <20200520052335.22466-8-yhchuang@realtek.com>
 <20200528162727.57bxyoi76bqpacge@linutronix.de>
In-Reply-To: <20200528162727.57bxyoi76bqpacge@linutronix.de>
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

PiBPbiAyMDIwLTA1LTIwIDEzOjIzOjM1IFsrMDgwMF0sIHloY2h1YW5nQHJlYWx0ZWsuY29tIHdy
b3RlOg0KPiA+IEZyb206IFR6dS1FbiBIdWFuZyA8dGVodWFuZ0ByZWFsdGVrLmNvbT4NCj4gPg0K
PiA+IEluIG9yZGVyIHRvIGdldCBhIGJldHRlciB0cmFtaXQgRVZNLCB3ZSBuZWVkIHRvIHBlcmZv
cm0gY2FsaWJyYXRpb24NCj4gDQo+IHMvdHJhbWl0L3RyYW5zbWl0LyA/DQo+IA0KPiA+IGFmdGVy
IGFzc29jaWF0aW9uLg0KPiA+IFRoZSBjYWxpYnJhdGlvbiBuZWVkZWQgZm9yIDg4MjFjIGlzIGNh
bGxlZCBpcSBjYWxpYnJhdGlvbiwgd2hpY2ggaXMNCj4gPiBkb25lIGluIGZpcm13YXJlLiBJbXBs
ZW1lbnQgdGhlIGNhbGxiYWNrIGZ1bmN0aW9uIGZvciB0cmlnZ2VyaW5nDQo+ID4gZmlybXdhcmUg
dG8gZG8gaXQuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBUenUtRW4gSHVhbmcgPHRlaHVhbmdA
cmVhbHRlay5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogWWFuLUhzdWFuIENodWFuZyA8eWhjaHVh
bmdAcmVhbHRlay5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0
ZWsvcnR3ODgvcnR3ODgyMWMuYyB8IDM0DQo+ICsrKysrKysrKysrKysrKysrKysNCj4gPiAgMSBm
aWxlIGNoYW5nZWQsIDM0IGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg4L3J0dzg4MjFjLmMNCj4gYi9kcml2ZXJzL25l
dC93aXJlbGVzcy9yZWFsdGVrL3J0dzg4L3J0dzg4MjFjLmMNCj4gPiBpbmRleCA3MTY5ZTZmYjlj
YTkuLjc0OTU2OWVhYjkxMiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9y
ZWFsdGVrL3J0dzg4L3J0dzg4MjFjLmMNCj4gPiArKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9y
ZWFsdGVrL3J0dzg4L3J0dzg4MjFjLmMNCj4gPiBAQCAtNTU1LDYgKzU1NSwzOSBAQCBzdGF0aWMg
dm9pZCBydHc4ODIxY19mYWxzZV9hbGFybV9zdGF0aXN0aWNzKHN0cnVjdA0KPiBydHdfZGV2ICpy
dHdkZXYpDQo+ID4gIAlydHdfd3JpdGUzMl9jbHIocnR3ZGV2LCAweGI1OCwgQklUKDApKTsNCj4g
PiAgfQ0KPiA+DQo+ID4gK3N0YXRpYyB2b2lkIHJ0dzg4MjFjX2RvX2lxayhzdHJ1Y3QgcnR3X2Rl
diAqcnR3ZGV2KQ0KPiA+ICt7DQo+ID4gKwlzdGF0aWMgaW50IGRvX2lxa19jbnQ7DQo+ID4gKwlz
dHJ1Y3QgcnR3X2lxa19wYXJhIHBhcmEgPSB7LmNsZWFyID0gMCwgLnNlZ21lbnRfaXFrID0gMH07
DQo+ID4gKwl1MzIgcmZfcmVnLCBpcWtfZmFpbF9tYXNrOw0KPiA+ICsJaW50IGNvdW50ZXI7DQo+
ID4gKwlib29sIHJlbG9hZDsNCj4gPiArDQo+ID4gKwlpZiAocnR3X2lzX2Fzc29jKHJ0d2Rldikp
DQo+ID4gKwkJcGFyYS5zZWdtZW50X2lxayA9IDE7DQo+ID4gKw0KPiA+ICsJcnR3X2Z3X2RvX2lx
ayhydHdkZXYsICZwYXJhKTsNCj4gPiArDQo+ID4gKwlmb3IgKGNvdW50ZXIgPSAwOyBjb3VudGVy
IDwgMzAwOyBjb3VudGVyKyspIHsNCj4gPiArCQlyZl9yZWcgPSBydHdfcmVhZF9yZihydHdkZXYs
IFJGX1BBVEhfQSwgUkZfRFRYTE9LLA0KPiBSRlJFR19NQVNLKTsNCj4gPiArCQlpZiAocmZfcmVn
ID09IDB4YWJjZGUpDQo+ID4gKwkJCWJyZWFrOw0KPiA+ICsJCW1zbGVlcCgyMCk7DQo+ID4gKwl9
DQo+ID4gKwlydHdfd3JpdGVfcmYocnR3ZGV2LCBSRl9QQVRIX0EsIFJGX0RUWExPSywgUkZSRUdf
TUFTSywgMHgwKTsNCj4gPiArDQo+ID4gKwlyZWxvYWQgPSAhIXJ0d19yZWFkMzJfbWFzayhydHdk
ZXYsIFJFR19JUUtGQUlMTVNLLCBCSVQoMTYpKTsNCj4gPiArCWlxa19mYWlsX21hc2sgPSBydHdf
cmVhZDMyX21hc2socnR3ZGV2LCBSRUdfSVFLRkFJTE1TSywgR0VOTUFTSyg3LA0KPiAwKSk7DQo+
ID4gKwlydHdfZGJnKHJ0d2RldiwgUlRXX0RCR19QSFksDQo+ID4gKwkJImlxayBjb3VudGVyPSVk
IHJlbG9hZD0lZCBkb19pcWtfY250PSVkDQo+IG5faXFrX2ZhaWwobWFzayk9MHglMDJ4XG4iLA0K
PiA+ICsJCWNvdW50ZXIsIHJlbG9hZCwgKytkb19pcWtfY250LCBpcWtfZmFpbF9tYXNrKTsNCj4g
PiArfQ0KPiA+ICsNCj4gPiArc3RhdGljIHZvaWQgcnR3ODgyMWNfcGh5X2NhbGlicmF0aW9uKHN0
cnVjdCBydHdfZGV2ICpydHdkZXYpDQo+ID4gK3sNCj4gPiArCXJ0dzg4MjFjX2RvX2lxayhydHdk
ZXYpOw0KPiANCj4gV2h5IHRoaXMgZXh0cmEgc3RlcD8gWW91IGNvdWxkIG5hbWUgaXQgcnR3ODgy
MWNfcGh5X2NhbGlicmF0aW9uX2lxaygpLg0KPiANCg0KVGhpcyBpcyBob29rZWQgYXQgcnR3X2No
aXBfb3BzOjpwaHlfY2FsaWJyYXRpb24oKS4gRm9yIDg4MjFDLCBvbmx5IElRSyBpcw0KcmVxdWly
ZWQuIFNvIGp1c3Qga2VlcCB0aGUgbmFtZSBjb25zaXN0ZW50Lg0KDQpZYW4tSHN1YW4NCg==
