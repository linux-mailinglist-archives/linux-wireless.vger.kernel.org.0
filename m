Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69A321447B
	for <lists+linux-wireless@lfdr.de>; Mon,  6 May 2019 08:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725813AbfEFGcM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 May 2019 02:32:12 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:49108 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbfEFGcL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 May 2019 02:32:11 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x466W2pn030458, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtitcas11.realtek.com.tw[172.21.6.12])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x466W2pn030458
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 6 May 2019 14:32:03 +0800
Received: from RTITMBSVM04.realtek.com.tw ([fe80::e404:880:2ef1:1aa1]) by
 RTITCAS11.realtek.com.tw ([fe80::7c6d:ced5:c4ff:8297%15]) with mapi id
 14.03.0399.000; Mon, 6 May 2019 14:32:02 +0800
From:   Tony Chuang <yhchuang@realtek.com>
To:     Stanislaw Gruszka <sgruszka@redhat.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH 5.1] rtw88: fix subscript above array bounds compiler warning
Thread-Topic: [PATCH 5.1] rtw88: fix subscript above array bounds compiler
 warning
Thread-Index: AQHVA9RMKpvIEyXpjEKtw8K3sUTCjaZdoZeA
Date:   Mon, 6 May 2019 06:32:01 +0000
Message-ID: <F7CD281DE3E379468C6D07993EA72F84D17EB2B5@RTITMBSVM04.realtek.com.tw>
References: <20190506062358.8288-1-sgruszka@redhat.com>
In-Reply-To: <20190506062358.8288-1-sgruszka@redhat.com>
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

PiBTdWJqZWN0OiBbUEFUQ0ggNS4xXSBydHc4ODogZml4IHN1YnNjcmlwdCBhYm92ZSBhcnJheSBi
b3VuZHMgY29tcGlsZXIgd2FybmluZw0KPiANCj4gTXkgY29tcGlsZXIgY29tcGxhaW5zIGFib3V0
Og0KPiANCj4gZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OC9waHkuYzogSW4gZnVu
Y3Rpb24NCj4g4oCYcnR3X3BoeV9yZl9wb3dlcl8yX3Jzc2nigJk6DQo+IGRyaXZlcnMvbmV0L3dp
cmVsZXNzL3JlYWx0ZWsvcnR3ODgvcGh5LmM6NDMwOjI2OiB3YXJuaW5nOiBhcnJheSBzdWJzY3Jp
cHQgaXMNCj4gYWJvdmUgYXJyYXkgYm91bmRzIFstV2FycmF5LWJvdW5kc10NCj4gICBsaW5lYXIg
PSBkYl9pbnZlcnRfdGFibGVbaV1bal07DQo+IA0KPiBBY2NvcmRpbmcgdG8gY29tbWVudCBwb3dl
cl9kYiBzaG91bGQgYmUgaW4gcmFuZ2UgMSB+IDk2IC4NCj4gVG8gZml4IGFkZCBjaGVjayBmb3Ig
Ym91bmRhcmllcyBiZWZvcmUgYWNjZXNzIHRoZSBhcnJheS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6
IFN0YW5pc2xhdyBHcnVzemthIDxzZ3J1c3prYUByZWRoYXQuY29tPg0KPiAtLS0NCj4gUkZDIC0+
IHYxDQo+IC0gYWRkIGNoZWNrIGJlZm9yZSBhY2Nlc3NpbmcgdGhlIGFycmF5IGluc3RlZCBvZg0K
PiAgIHJ0d19waHlfcG93ZXJfMl9kYigpIGNoYW5nZS4NCj4gDQo+ICBkcml2ZXJzL25ldC93aXJl
bGVzcy9yZWFsdGVrL3J0dzg4L3BoeS5jIHwgNSArKysrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDUg
aW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3Jl
YWx0ZWsvcnR3ODgvcGh5LmMNCj4gYi9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg4
L3BoeS5jDQo+IGluZGV4IDQzODFiMzYwYjViNS4uOWNhNTJhNGQwMjVhIDEwMDY0NA0KPiAtLS0g
YS9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg4L3BoeS5jDQo+ICsrKyBiL2RyaXZl
cnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODgvcGh5LmMNCj4gQEAgLTQyMyw2ICs0MjMsMTEg
QEAgc3RhdGljIHU2NCBydHdfcGh5X2RiXzJfbGluZWFyKHU4IHBvd2VyX2RiKQ0KPiAgCXU4IGks
IGo7DQo+ICAJdTY0IGxpbmVhcjsNCj4gDQo+ICsJaWYgKHBvd2VyX2RiID4gOTYpDQo+ICsJCXBv
d2VyX2RiID0gOTY7DQo+ICsJZWxzZSBpZiAocG93ZXJfZGIgPCAxKQ0KPiArCQlwb3dlcl9kYiA9
IDE7DQoNCkkgdGhpbmsgaXQncyAicmV0dXJuIDEiIGhlcmUuDQoNCj4gKw0KPiAgCS8qIDFkQiB+
IDk2ZEIgKi8NCj4gIAlpID0gKHBvd2VyX2RiIC0gMSkgPj4gMzsNCj4gIAlqID0gKHBvd2VyX2Ri
IC0gMSkgLSAoaSA8PCAzKTsNCj4gLS0NCg0KWWFuLUhzdWFuDQo=
