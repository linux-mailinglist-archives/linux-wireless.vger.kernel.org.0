Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6488D14648
	for <lists+linux-wireless@lfdr.de>; Mon,  6 May 2019 10:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726085AbfEFI3V (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 May 2019 04:29:21 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:43958 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbfEFI3V (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 May 2019 04:29:21 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x468TE9k030442, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtitcasv02.realtek.com.tw[172.21.6.19])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x468TE9k030442
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 6 May 2019 16:29:14 +0800
Received: from RTITMBSVM04.realtek.com.tw ([fe80::e404:880:2ef1:1aa1]) by
 RTITCASV02.realtek.com.tw ([::1]) with mapi id 14.03.0439.000; Mon, 6 May
 2019 16:29:13 +0800
From:   Tony Chuang <yhchuang@realtek.com>
To:     Stanislaw Gruszka <sgruszka@redhat.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH 5.1] rtw88: fix subscript above array bounds compiler warning
Thread-Topic: [PATCH 5.1] rtw88: fix subscript above array bounds compiler
 warning
Thread-Index: AQHVA97RehUJoZ7290GKHCDr+G3fWaZdw6iA
Date:   Mon, 6 May 2019 08:29:13 +0000
Message-ID: <F7CD281DE3E379468C6D07993EA72F84D17EB40A@RTITMBSVM04.realtek.com.tw>
References: <20190506073917.10106-1-sgruszka@redhat.com>
In-Reply-To: <20190506073917.10106-1-sgruszka@redhat.com>
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
PiAgIHJ0d19waHlfcG93ZXJfMl9kYigpIGNoYW5nZS4NCj4gdjEgLT4gdjI6DQo+IC0gcmV0dXJu
IDEgZm9yIHBvd2VyX2RiIDwgMQ0KPiANCj4gIGRyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsv
cnR3ODgvcGh5LmMgfCA1ICsrKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCsp
DQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OC9w
aHkuYw0KPiBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODgvcGh5LmMNCj4gaW5k
ZXggNDM4MWIzNjBiNWI1Li45Y2E1MmE0ZDAyNWEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0
L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODgvcGh5LmMNCj4gKysrIGIvZHJpdmVycy9uZXQvd2lyZWxl
c3MvcmVhbHRlay9ydHc4OC9waHkuYw0KPiBAQCAtNDIzLDYgKzQyMywxMSBAQCBzdGF0aWMgdTY0
IHJ0d19waHlfZGJfMl9saW5lYXIodTggcG93ZXJfZGIpDQo+ICAJdTggaSwgajsNCj4gIAl1NjQg
bGluZWFyOw0KPiANCj4gKwlpZiAocG93ZXJfZGIgPiA5NikNCj4gKwkJcG93ZXJfZGIgPSA5NjsN
Cj4gKwllbHNlIGlmIChwb3dlcl9kYiA8IDEpDQo+ICsJCXJldHVybiAxOw0KPiArDQo+ICAJLyog
MWRCIH4gOTZkQiAqLw0KPiAgCWkgPSAocG93ZXJfZGIgLSAxKSA+PiAzOw0KPiAgCWogPSAocG93
ZXJfZGIgLSAxKSAtIChpIDw8IDMpOw0KPiAtLQ0KDQpUaGFua3MuIEZvciB0aGlzIHBhdGNoLg0K
DQpBY2tlZC1ieTogWWFuLUhzdWFuIENodWFuZyA8eWhjaHVhbmdAcmVhbHRlay5jb20+DQoNCllh
bi1Ic3Vhbg0K
