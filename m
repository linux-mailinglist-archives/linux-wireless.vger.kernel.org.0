Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9B1D145A1
	for <lists+linux-wireless@lfdr.de>; Mon,  6 May 2019 09:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbfEFH4s (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 May 2019 03:56:48 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:49692 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbfEFH4r (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 May 2019 03:56:47 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x467uWU0014879, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtitcasv01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x467uWU0014879
        (version=TLSv1 cipher=AES256-SHA bits=256 verify=NOT);
        Mon, 6 May 2019 15:56:32 +0800
Received: from RTITMBSVM04.realtek.com.tw ([fe80::e404:880:2ef1:1aa1]) by
 RTITCASV01.realtek.com.tw ([::1]) with mapi id 14.03.0415.000; Mon, 6 May
 2019 15:56:31 +0800
From:   Pkshih <pkshih@realtek.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "colin.king@canonical.com" <colin.king@canonical.com>,
        "kvalo@codeaurora.org" <kvalo@codeaurora.org>,
        "Larry.Finger@lwfinger.net" <Larry.Finger@lwfinger.net>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: static analysis issue in rtl8188de driver
Thread-Topic: static analysis issue in rtl8188de driver
Thread-Index: AQHVAsNxM98Kauqi0ket4FYZEsHsOaZdNsoA
Date:   Mon, 6 May 2019 07:56:30 +0000
Message-ID: <1557129390.28660.4.camel@realtek.com>
References: <a1842b3e-f0af-d1a1-8609-a76c25dfd37b@canonical.com>
In-Reply-To: <a1842b3e-f0af-d1a1-8609-a76c25dfd37b@canonical.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.114]
Content-Type: text/plain; charset="utf-8"
Content-ID: <087B30BC917E234B836B5C961AEB8BAF@realtek.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gU2F0LCAyMDE5LTA1LTA0IGF0IDIxOjUwICswMDAwLCBDb2xpbiBJYW4gS2luZyB3cm90ZToN
Cj4gSGksDQo+IA0KPiBTdGF0aWMgYW5hbHlzaXMgd2l0aCBDb3Zlcml0eSBoYXMgZm91bmQgYW4g
aXNzdWUgaW4gdGhlIHJ0bDgxODhkZQ0KPiB3aXJlbGVzcyBkcml2ZXIgaW4gZHJpdmVycy9uZXQv
d2lyZWxlc3MvcmVhbHRlay9ydGx3aWZpL3J0bDgxOTJkZS9kbS5jDQo+IGluIGZ1bmN0aW9uIHRs
OTJkX2RtX3R4cG93ZXJfdHJhY2tpbmdfY2FsbGJhY2tfdGhlcm1hbG1ldGVyLg0KPiANCj4gVGhl
IGlzc3VlIGlzIHRoYXQgdTggYXJyYXkgb2ZkbV9pbmRleFszXSBpcyBuZXZlciBpbml0aWFsaXpl
ZCwgaG93ZXZlcg0KPiBpdCBpcyBkZWNyZW1lbnRlZCBhbmQgaW5jcmVtZW50ZWQgaW4gdHdvIHBs
YWNlcyByZXN1bHRpbmcgaW4gZ2FyYmFnZQ0KPiB2YWx1ZSBmcm9tIHRoZSBzdGFjayBiZWluZyB1
cGRhdGVkIGluIHRoZSBmb2xsb3dpbmcgY29kZToNCj4gDQo+IAlpZiAodGhlcm1hbHZhbHVlID4g
cnRscHJpdi0+ZG0udGhlcm1hbHZhbHVlKSB7DQo+IMKgwqDCoMKgwqDCoMKgwqAJZm9yIChpID0g
MDsgaSA8IHJmOyBpKyspDQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgCW9mZG1f
aW5kZXhbaV0gLT0gZGVsdGE7DQo+IMKgwqDCoMKgwqDCoMKgwqAJY2NrX2luZGV4IC09IGRlbHRh
Ow0KPiAJfSBlbHNlIHsNCj4gwqDCoMKgwqDCoMKgwqDCoAlmb3IgKGkgPSAwOyBpIDwgcmY7IGkr
KykNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAJb2ZkbV9pbmRleFtpXSArPSBp
bmRleDsNCj4gwqDCoMKgwqDCoMKgwqDCoAljY2tfaW5kZXggKz0gaW5kZXg7CQ0KPiAJfQ0KPiAN
Cj4gQXQgbXkgZmlyc3QgbG9vayBhdCB0aGUgY29kZSBJIGJlbGlldmUgb2ZkbV9pbmRleCBzaG91
bGQgYmUganVzdA0KPiB6ZXJvLWluaXRpYWxpemVkIGF0IGRlY2xhcmF0aW9uIHRpbWUsIGJ1dCBJ
IHN1c3BlY3QgdGhhdCBJJ20gb3Zlcmxvb2tpbmcNCj4gc29tZXRoaW5nIG1heWJlIGEgYml0IGRl
ZXBlci4gQW55IGlkZWFzPw0KPiANCg0KDQpIaSBDb2xpbiwNCg0KVGhhbmtzIGZvciB5b3VyIHJl
cG9ydC4NCg0KQWZ0ZXIgbXkgcXVpY2sgbG9vaywgdGhlcmUgYXJlIGF0IGxlYXN0IHR3byBvYnZp
b3VzIHByb2JsZW1zLg0KT25lIGlzIGFycmF5IHNpemUgb2bCoG9mZG1faW5kZXhbXSBzaG91bGQg
YmUgdHdvIGluc3RlYWQuIEFub3RoZXIgaXMgdGhlIHZhbHVlDQpvZiBvZmRtX2luZGV4W10gc2hv
dWxkIGJlIG9idGFpbmVkIGZyb20gcnRscHJpdi0+ZG0ub2ZkbV9pbmRleFtdLsKgDQpTaW5jZSB0
aGUgbG9naWMgaXMgcXVpdGUgY29tcGxleCwgSSBuZWVkIHNvbWUgdGltZSB0byBmaXggaXQuDQoN
ClBLDQoNCg==
