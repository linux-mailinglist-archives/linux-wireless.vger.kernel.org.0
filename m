Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5AC143CE
	for <lists+linux-wireless@lfdr.de>; Mon,  6 May 2019 05:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbfEFDm4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 5 May 2019 23:42:56 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:36894 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbfEFDmz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 5 May 2019 23:42:55 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x463gkF2025562, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtitcas12.realtek.com.tw[172.21.6.16])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x463gkF2025562
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 6 May 2019 11:42:46 +0800
Received: from RTITMBSVM04.realtek.com.tw ([fe80::e404:880:2ef1:1aa1]) by
 RTITCAS12.realtek.com.tw ([::1]) with mapi id 14.03.0439.000; Mon, 6 May 2019
 11:42:46 +0800
From:   Tony Chuang <yhchuang@realtek.com>
To:     Stanislaw Gruszka <sgruszka@redhat.com>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [RFC] rtw88: fix subscript above array bounds compiler warning
Thread-Topic: [RFC] rtw88: fix subscript above array bounds compiler warning
Thread-Index: AQHVAabY923e3mCnuUOdIndDOImdQ6ZZS4jA//+BWQCABKn1AA==
Date:   Mon, 6 May 2019 03:42:45 +0000
Message-ID: <F7CD281DE3E379468C6D07993EA72F84D17EB003@RTITMBSVM04.realtek.com.tw>
References: <20190503115333.GA23109@redhat.com>
 <F7CD281DE3E379468C6D07993EA72F84D17E8846@RTITMBSVM04.realtek.com.tw>
 <20190503122426.GA4423@redhat.com>
In-Reply-To: <20190503122426.GA4423@redhat.com>
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

PiBTdWJqZWN0OiBSZTogW1JGQ10gcnR3ODg6IGZpeCBzdWJzY3JpcHQgYWJvdmUgYXJyYXkgYm91
bmRzIGNvbXBpbGVyIHdhcm5pbmcNCj4gDQo+IE9uIEZyaSwgTWF5IDAzLCAyMDE5IGF0IDEyOjAx
OjA1UE0gKzAwMDAsIFRvbnkgQ2h1YW5nIHdyb3RlOg0KPiA+ID4gU3ViamVjdDogW1JGQ10gcnR3
ODg6IGZpeCBzdWJzY3JpcHQgYWJvdmUgYXJyYXkgYm91bmRzIGNvbXBpbGVyIHdhcm5pbmcNCj4g
PiA+DQo+ID4gPiBNeSBjb21waWxlciBjb21wbGFpbiBhYm91dDoNCj4gPiA+DQo+ID4gPiBkcml2
ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg4L3BoeS5jOiBJbiBmdW5jdGlvbg0KPiA+ID4g
4oCYcnR3X3BoeV9yZl9wb3dlcl8yX3Jzc2nigJk6DQo+ID4gPiBkcml2ZXJzL25ldC93aXJlbGVz
cy9yZWFsdGVrL3J0dzg4L3BoeS5jOjQzMDoyNjogd2FybmluZzogYXJyYXkgc3Vic2NyaXB0IGlz
DQo+ID4gPiBhYm92ZSBhcnJheSBib3VuZHMgWy1XYXJyYXktYm91bmRzXQ0KPiA+ID4gICBsaW5l
YXIgPSBkYl9pbnZlcnRfdGFibGVbaV1bal07DQo+ID4gPg0KPiA+ID4gQWNjb3JkaW5nIHRvIGNv
bW1lbnQgcG93ZXJfZGIgc2hvdWxkIGJlIGluIHJhbmdlIDEgfiA5NiAuDQo+ID4gPiBDb3JyZWN0
IHJ0d19waHlfcG93ZXJfMl9kYigpIHRvIG1ha2UgbWF4IHBvd2VyIDk2IGRiDQo+ID4gPiAoc3Rp
bGwgbWluIGlzIDApLiBUaGlzIG1ha2UgdGhlIHdhcm5pbmcgZ29uZS4NCj4gPiA+DQo+ID4gPiBI
b3dldmVyIHBvd2VyID49IDIwIGNoZWNrIHN0aWxsIGxvb2tzIHNvbWV3aGF0IHN1c3BpY2lvdXMg
dG8gbWUuDQo+ID4gPg0KPiA+ID4gU2lnbmVkLW9mZi1ieTogU3RhbmlzbGF3IEdydXN6a2EgPHNn
cnVzemthQHJlZGhhdC5jb20+DQo+ID4gPiAtLS0NCj4gPiA+ICBkcml2ZXJzL25ldC93aXJlbGVz
cy9yZWFsdGVrL3J0dzg4L3BoeS5jIHwgNiArKystLS0NCj4gPiA+ICAxIGZpbGUgY2hhbmdlZCwg
MyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiA+ID4NCj4gPiA+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg4L3BoeS5jDQo+ID4gPiBiL2RyaXZl
cnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODgvcGh5LmMNCj4gPiA+IGluZGV4IDM1YTM1ZGJj
YTg1Zi4uYTcxNmE0NGQ3OGIwIDEwMDY0NA0KPiA+ID4gLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxl
c3MvcmVhbHRlay9ydHc4OC9waHkuYw0KPiA+ID4gKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3Mv
cmVhbHRlay9ydHc4OC9waHkuYw0KPiA+ID4gQEAgLTQxMCwxMiArNDEwLDEyIEBAIHZvaWQgcnR3
X3BoeV9keW5hbWljX21lY2hhbmlzbShzdHJ1Y3QNCj4gcnR3X2Rldg0KPiA+ID4gKnJ0d2RldikN
Cj4gPiA+DQo+ID4gPiAgc3RhdGljIHU4IHJ0d19waHlfcG93ZXJfMl9kYihzOCBwb3dlcikNCj4g
PiA+ICB7DQo+ID4gPiAtCWlmIChwb3dlciA8PSAtMTAwIHx8IHBvd2VyID49IDIwKQ0KPiA+ID4g
KwlpZiAocG93ZXIgPD0gLTk2IHx8IHBvd2VyID49IDIwKQ0KPiA+ID4gIAkJcmV0dXJuIDA7DQo+
ID4gPiAgCWVsc2UgaWYgKHBvd2VyID49IDApDQo+ID4gPiAtCQlyZXR1cm4gMTAwOw0KPiA+ID4g
KwkJcmV0dXJuIDk2Ow0KPiA+ID4gIAllbHNlDQo+ID4gPiAtCQlyZXR1cm4gMTAwICsgcG93ZXI7
DQo+ID4gPiArCQlyZXR1cm4gOTYgKyBwb3dlcjsNCj4gPiA+ICB9DQo+ID4gPg0KPiA+ID4gIHN0
YXRpYyB1NjQgcnR3X3BoeV9kYl8yX2xpbmVhcih1OCBwb3dlcl9kYikNCj4gPiA+IC0tDQo+ID4N
Cj4gPiBJIHRoaW5rIEkgc2hvdWxkIGNoZWNrIHdpdGggdGhlIHJhZGlvIHRlYW0sIHRoYXQgaWYg
dGhlIHBvd2VyIGZyb20gdGhlDQo+ID4gcnggZGVzY3JpcHRvciBnZW5lcmF0ZWQgYnkgaGFyZHdh
cmUgY2FuIHBvc3NpYmx5IGdldCA+PSAyMA0KPiA+DQo+ID4gQW5kIGFsc28gY2hlY2sgd2hhdCB0
aGUgYWN0dWFsIGxvZ2ljIHRoZXkgZXhwZWN0ZWQgdG8gZGVhbCB3aXRoIHRoZSBwb3dlci4NCj4g
PiBUaGFua3MgZm9yIHJlcG9ydGluZyBpdC4NCj4gDQo+IFllYWgsIHRoaXMgY291bGQgYmUganVz
dCB0ZW9yZXRpY2FsIGlzc3VlIGFzIHdlIGNhbiBub3QgZ2V0IHBvd2VyDQo+IHZhbHVlcyA+PSAw
IGZyb20gSFcuIEhvd2V2ZXIgSSB0aGluayBjb21waWxlciBjb3JyZWN0bHkgY29tcGxhaW5zLCBh
cw0KPiBmb3IgcG93ZXJfZGI9MTAwIHdlIGdldCBpID0gKCgxMDAgLSAxKSA+PiAzKSA9IDEyICwg
d2hhdCBleGNlZWQgYnkgb25lDQo+IG1heCBmaXJzdCBpbmRleCBvZiBkYl9pbnZlcnRfdGFibGVb
XVtdLCB3aGljaCBzaG91bGQgYmUgaW4gcmFuZ2UNCj4gMCAtIDExLg0KPiANCg0KSSBjaGVja2Vk
IGl0LiBUaGUgcG93ZXIgc3VtIGNvdWxkIGFjdHVhbGx5IGJlIGxpa2UgMjAgb3Igc29tZXRoaW5n
Lg0KQW5kIHRoZSByZWNvbW1lbmRlZCBtb2RpZmljYXRpb24gaXMgdG8gcmVzdHJpY3QgdGhlIHZh
bHVlIHVzZWQgZm9yIGFycmF5DQpzdWJzY3JpcHQgYmV0d2VlbiAxfjk2IGJlZm9yZSBhY2Nlc3Mg
dGhlIGFycmF5LiBTdWNoIGFzOg0KDQpAQCAtNTc4LDYgKzU3OCwxMSBAQCBzdGF0aWMgdTY0IHJ0
d19waHlfZGJfMl9saW5lYXIodTggcG93ZXJfZGIpDQogICAgICAgIHU4IGksIGo7DQogICAgICAg
IHU2NCBsaW5lYXI7DQoNCisgICAgICAgaWYgKHBvd2VyX2RiID4gOTYpDQorICAgICAgICAgICAg
ICAgcG93ZXJfZGIgPSA5NjsNCisgICAgICAgZWxzZSBpZiAocG93ZXJfZGIgPCAxKQ0KKyAgICAg
ICAgICAgICAgIHJldHVybiAxOw0KKw0KICAgICAgICAvKiAxZEIgfiA5NmRCICovDQogICAgICAg
IGkgPSAocG93ZXJfZGIgLSAxKSA+PiAzOw0KICAgICAgICBqID0gKHBvd2VyX2RiIC0gMSkgLSAo
aSA8PCAzKTsNCg0KDQpZYW4tSHN1YW4NCg0K
