Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE1814499
	for <lists+linux-wireless@lfdr.de>; Mon,  6 May 2019 08:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbfEFGv1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 May 2019 02:51:27 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:60777 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbfEFGv0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 May 2019 02:51:26 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x466pK8a007711, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtitcas12.realtek.com.tw[172.21.6.16])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x466pK8a007711
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 6 May 2019 14:51:20 +0800
Received: from RTITEXH01.realtek.com.tw (172.21.6.62) by
 RTITCAS12.realtek.com.tw (172.21.6.16) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Mon, 6 May 2019 14:51:20 +0800
Received: from RTITMBSVM04.realtek.com.tw ([fe80::e404:880:2ef1:1aa1]) by
 RTITEXH01.realtek.com.tw ([::1]) with mapi id 14.03.0439.000; Mon, 6 May 2019
 14:51:19 +0800
From:   Tony Chuang <yhchuang@realtek.com>
To:     Stanislaw Gruszka <sgruszka@redhat.com>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH 5.1] rtw88: fix subscript above array bounds compiler warning
Thread-Topic: [PATCH 5.1] rtw88: fix subscript above array bounds compiler
 warning
Thread-Index: AQHVA9RMKpvIEyXpjEKtw8K3sUTCjaZdoZeA//9+zICAAIcHIA==
Date:   Mon, 6 May 2019 06:51:18 +0000
Message-ID: <F7CD281DE3E379468C6D07993EA72F84D17EB310@RTITMBSVM04.realtek.com.tw>
References: <20190506062358.8288-1-sgruszka@redhat.com>
 <F7CD281DE3E379468C6D07993EA72F84D17EB2B5@RTITMBSVM04.realtek.com.tw>
 <20190506064357.GB5115@redhat.com>
In-Reply-To: <20190506064357.GB5115@redhat.com>
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

PiBTdWJqZWN0OiBSZTogW1BBVENIIDUuMV0gcnR3ODg6IGZpeCBzdWJzY3JpcHQgYWJvdmUgYXJy
YXkgYm91bmRzIGNvbXBpbGVyDQo+IHdhcm5pbmcNCj4gDQo+IE9uIE1vbiwgTWF5IDA2LCAyMDE5
IGF0IDA2OjMyOjAxQU0gKzAwMDAsIFRvbnkgQ2h1YW5nIHdyb3RlOg0KPiA+ID4gU3ViamVjdDog
W1BBVENIIDUuMV0gcnR3ODg6IGZpeCBzdWJzY3JpcHQgYWJvdmUgYXJyYXkgYm91bmRzIGNvbXBp
bGVyDQo+IHdhcm5pbmcNCj4gPiA+DQo+ID4gPiBNeSBjb21waWxlciBjb21wbGFpbnMgYWJvdXQ6
DQo+ID4gPg0KPiA+ID4gZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OC9waHkuYzog
SW4gZnVuY3Rpb24NCj4gPiA+IOKAmHJ0d19waHlfcmZfcG93ZXJfMl9yc3Np4oCZOg0KPiA+ID4g
ZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OC9waHkuYzo0MzA6MjY6IHdhcm5pbmc6
IGFycmF5IHN1YnNjcmlwdCBpcw0KPiA+ID4gYWJvdmUgYXJyYXkgYm91bmRzIFstV2FycmF5LWJv
dW5kc10NCj4gPiA+ICAgbGluZWFyID0gZGJfaW52ZXJ0X3RhYmxlW2ldW2pdOw0KPiA+ID4NCj4g
PiA+IEFjY29yZGluZyB0byBjb21tZW50IHBvd2VyX2RiIHNob3VsZCBiZSBpbiByYW5nZSAxIH4g
OTYgLg0KPiA+ID4gVG8gZml4IGFkZCBjaGVjayBmb3IgYm91bmRhcmllcyBiZWZvcmUgYWNjZXNz
IHRoZSBhcnJheS4NCj4gPiA+DQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBTdGFuaXNsYXcgR3J1c3pr
YSA8c2dydXN6a2FAcmVkaGF0LmNvbT4NCj4gPiA+IC0tLQ0KPiA+ID4gUkZDIC0+IHYxDQo+ID4g
PiAtIGFkZCBjaGVjayBiZWZvcmUgYWNjZXNzaW5nIHRoZSBhcnJheSBpbnN0ZWQgb2YNCj4gPiA+
ICAgcnR3X3BoeV9wb3dlcl8yX2RiKCkgY2hhbmdlLg0KPiA+ID4NCj4gPiA+ICBkcml2ZXJzL25l
dC93aXJlbGVzcy9yZWFsdGVrL3J0dzg4L3BoeS5jIHwgNSArKysrKw0KPiA+ID4gIDEgZmlsZSBj
aGFuZ2VkLCA1IGluc2VydGlvbnMoKykNCj4gPiA+DQo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OC9waHkuYw0KPiA+ID4gYi9kcml2ZXJzL25ldC93
aXJlbGVzcy9yZWFsdGVrL3J0dzg4L3BoeS5jDQo+ID4gPiBpbmRleCA0MzgxYjM2MGI1YjUuLjlj
YTUyYTRkMDI1YSAxMDA2NDQNCj4gPiA+IC0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0
ZWsvcnR3ODgvcGh5LmMNCj4gPiA+ICsrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsv
cnR3ODgvcGh5LmMNCj4gPiA+IEBAIC00MjMsNiArNDIzLDExIEBAIHN0YXRpYyB1NjQgcnR3X3Bo
eV9kYl8yX2xpbmVhcih1OCBwb3dlcl9kYikNCj4gPiA+ICAJdTggaSwgajsNCj4gPiA+ICAJdTY0
IGxpbmVhcjsNCj4gPiA+DQo+ID4gPiArCWlmIChwb3dlcl9kYiA+IDk2KQ0KPiA+ID4gKwkJcG93
ZXJfZGIgPSA5NjsNCj4gPiA+ICsJZWxzZSBpZiAocG93ZXJfZGIgPCAxKQ0KPiA+ID4gKwkJcG93
ZXJfZGIgPSAxOw0KPiA+DQo+ID4gSSB0aGluayBpdCdzICJyZXR1cm4gMSIgaGVyZS4NCj4gDQo+
IEVoaCwgSSBtaXNzZWQgdGhhdCBpbiB5b3VyIGNvbW1lbnQuIEhvd2V2ZXIgJ3JldHVybiAxJyBj
aGFuZ2UNCj4gdGhlIG91dHB1dCBvZiBydHdfcGh5X2RiXzJfbGluZWFyKCkgcXVpdGUgc3Vic3Rh
bnRpYWxseQ0KPiBhcyB0aGUgc21hbGxlc3QgdmFsdWUgKGZvciBwb3dlcl9kYiA9IDEpIGZyb20g
ZGJfaW52ZXJ0X3RhYmxlW11bXQ0KPiBpcyAxMC4gSSdsbCBwb3N0IHYyIHBhdGNoLCBidXQgcGxl
YXNlIGRvdWJsZSBjaGVjayBpdCdzIGluZGVlZA0KPiBjb3JyZWN0IGxvZ2ljLiBUaGFua3MuDQo+
IA0KDQpJIHRoaW5rICJyZXR1cm4gMSIgaXMgY29ycmVjdCBiZWNhdXNlIDAgaXMgbm90IGluIGRv
bWFpbiAxfjk2Lg0KQW5kIGluZGVlZCBhbnl0aGluZyB0byB0aGUgcG93ZXIgb2YgemVybyBpcyAx
Lg0KVGhhbmtzLg0KDQpZYW4tSHN1YW4NCg0K
