Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C319012D14
	for <lists+linux-wireless@lfdr.de>; Fri,  3 May 2019 14:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726405AbfECMBR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 May 2019 08:01:17 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:33312 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbfECMBR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 May 2019 08:01:17 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x43C16hs001831, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtitcas11.realtek.com.tw[172.21.6.12])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x43C16hs001831
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 3 May 2019 20:01:06 +0800
Received: from RTITMBSVM04.realtek.com.tw ([fe80::e404:880:2ef1:1aa1]) by
 RTITCAS11.realtek.com.tw ([fe80::7c6d:ced5:c4ff:8297%15]) with mapi id
 14.03.0399.000; Fri, 3 May 2019 20:01:06 +0800
From:   Tony Chuang <yhchuang@realtek.com>
To:     Stanislaw Gruszka <sgruszka@redhat.com>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [RFC] rtw88: fix subscript above array bounds compiler warning
Thread-Topic: [RFC] rtw88: fix subscript above array bounds compiler warning
Thread-Index: AQHVAabY923e3mCnuUOdIndDOImdQ6ZZS4jA
Date:   Fri, 3 May 2019 12:01:05 +0000
Message-ID: <F7CD281DE3E379468C6D07993EA72F84D17E8846@RTITMBSVM04.realtek.com.tw>
References: <20190503115333.GA23109@redhat.com>
In-Reply-To: <20190503115333.GA23109@redhat.com>
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

PiBTdWJqZWN0OiBbUkZDXSBydHc4ODogZml4IHN1YnNjcmlwdCBhYm92ZSBhcnJheSBib3VuZHMg
Y29tcGlsZXIgd2FybmluZw0KPiANCj4gTXkgY29tcGlsZXIgY29tcGxhaW4gYWJvdXQ6DQo+IA0K
PiBkcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg4L3BoeS5jOiBJbiBmdW5jdGlvbg0K
PiDigJhydHdfcGh5X3JmX3Bvd2VyXzJfcnNzaeKAmToNCj4gZHJpdmVycy9uZXQvd2lyZWxlc3Mv
cmVhbHRlay9ydHc4OC9waHkuYzo0MzA6MjY6IHdhcm5pbmc6IGFycmF5IHN1YnNjcmlwdCBpcw0K
PiBhYm92ZSBhcnJheSBib3VuZHMgWy1XYXJyYXktYm91bmRzXQ0KPiAgIGxpbmVhciA9IGRiX2lu
dmVydF90YWJsZVtpXVtqXTsNCj4gDQo+IEFjY29yZGluZyB0byBjb21tZW50IHBvd2VyX2RiIHNo
b3VsZCBiZSBpbiByYW5nZSAxIH4gOTYgLg0KPiBDb3JyZWN0IHJ0d19waHlfcG93ZXJfMl9kYigp
IHRvIG1ha2UgbWF4IHBvd2VyIDk2IGRiDQo+IChzdGlsbCBtaW4gaXMgMCkuIFRoaXMgbWFrZSB0
aGUgd2FybmluZyBnb25lLg0KPiANCj4gSG93ZXZlciBwb3dlciA+PSAyMCBjaGVjayBzdGlsbCBs
b29rcyBzb21ld2hhdCBzdXNwaWNpb3VzIHRvIG1lLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogU3Rh
bmlzbGF3IEdydXN6a2EgPHNncnVzemthQHJlZGhhdC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9u
ZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OC9waHkuYyB8IDYgKysrLS0tDQo+ICAxIGZpbGUgY2hh
bmdlZCwgMyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODgvcGh5LmMNCj4gYi9kcml2ZXJzL25l
dC93aXJlbGVzcy9yZWFsdGVrL3J0dzg4L3BoeS5jDQo+IGluZGV4IDM1YTM1ZGJjYTg1Zi4uYTcx
NmE0NGQ3OGIwIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0
dzg4L3BoeS5jDQo+ICsrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODgvcGh5
LmMNCj4gQEAgLTQxMCwxMiArNDEwLDEyIEBAIHZvaWQgcnR3X3BoeV9keW5hbWljX21lY2hhbmlz
bShzdHJ1Y3QgcnR3X2Rldg0KPiAqcnR3ZGV2KQ0KPiANCj4gIHN0YXRpYyB1OCBydHdfcGh5X3Bv
d2VyXzJfZGIoczggcG93ZXIpDQo+ICB7DQo+IC0JaWYgKHBvd2VyIDw9IC0xMDAgfHwgcG93ZXIg
Pj0gMjApDQo+ICsJaWYgKHBvd2VyIDw9IC05NiB8fCBwb3dlciA+PSAyMCkNCj4gIAkJcmV0dXJu
IDA7DQo+ICAJZWxzZSBpZiAocG93ZXIgPj0gMCkNCj4gLQkJcmV0dXJuIDEwMDsNCj4gKwkJcmV0
dXJuIDk2Ow0KPiAgCWVsc2UNCj4gLQkJcmV0dXJuIDEwMCArIHBvd2VyOw0KPiArCQlyZXR1cm4g
OTYgKyBwb3dlcjsNCj4gIH0NCj4gDQo+ICBzdGF0aWMgdTY0IHJ0d19waHlfZGJfMl9saW5lYXIo
dTggcG93ZXJfZGIpDQo+IC0tDQoNCkkgdGhpbmsgSSBzaG91bGQgY2hlY2sgd2l0aCB0aGUgcmFk
aW8gdGVhbSwgdGhhdCBpZiB0aGUgcG93ZXIgZnJvbSB0aGUNCnJ4IGRlc2NyaXB0b3IgZ2VuZXJh
dGVkIGJ5IGhhcmR3YXJlIGNhbiBwb3NzaWJseSBnZXQgPj0gMjANCg0KQW5kIGFsc28gY2hlY2sg
d2hhdCB0aGUgYWN0dWFsIGxvZ2ljIHRoZXkgZXhwZWN0ZWQgdG8gZGVhbCB3aXRoIHRoZSBwb3dl
ci4NClRoYW5rcyBmb3IgcmVwb3J0aW5nIGl0Lg0KDQpZYW4tSHN1YW4NCg0K
