Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 931321C34A6
	for <lists+linux-wireless@lfdr.de>; Mon,  4 May 2020 10:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbgEDIkV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 4 May 2020 04:40:21 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:43899 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726351AbgEDIkV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 4 May 2020 04:40:21 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 0448e7tN5005510, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 0448e7tN5005510
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 4 May 2020 16:40:07 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 4 May 2020 16:40:07 +0800
Received: from RTEXMB04.realtek.com.tw ([fe80::8001:f5f5:a41e:f8d4]) by
 RTEXMB04.realtek.com.tw ([fe80::8001:f5f5:a41e:f8d4%3]) with mapi id
 15.01.1779.005; Mon, 4 May 2020 16:40:07 +0800
From:   Tony Chuang <yhchuang@realtek.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC:     "kvalo@codeaurora.org" <kvalo@codeaurora.org>,
        Pkshih <pkshih@realtek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "briannorris@chromium.org" <briannorris@chromium.org>,
        Kevin Yang <kevin_yang@realtek.com>
Subject: RE: [PATCH 25/40] rtw88: 8723d: Add LC calibration
Thread-Topic: [PATCH 25/40] rtw88: 8723d: Add LC calibration
Thread-Index: AQHWFIyCw6bysH4pzUCwt/CCuRDRN6iRP3WAgAZ2aJA=
Date:   Mon, 4 May 2020 08:40:06 +0000
Message-ID: <32611827c31b42519f1aebc500cdbbb0@realtek.com>
References: <20200417074653.15591-1-yhchuang@realtek.com>
 <20200417074653.15591-26-yhchuang@realtek.com>
 <20200430135749.pjtzrnsnvkknwjim@linutronix.de>
In-Reply-To: <20200430135749.pjtzrnsnvkknwjim@linutronix.de>
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

PiBPbiAyMDIwLTA0LTE3IDE1OjQ2OjM4IFsrMDgwMF0sIHloY2h1YW5nQHJlYWx0ZWsuY29tIHdy
b3RlOg0KPiA+IGluZGV4IGNmODk3YWYzODBjMS4uOTQ3ODRjN2YwNzQzIDEwMDY0NA0KPiA+IC0t
LSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODgvcnR3ODcyM2QuYw0KPiA+ICsr
KyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODgvcnR3ODcyM2QuYw0KPiA+IEBA
IC02NCw2ICs2NCwzMyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHJ0d19od19yZWcgcnR3ODcyM2Rf
dHhhZ2NbXSA9IHsNCj4gPiAgI2RlZmluZSBXTEFOX0xUUl9DVFJMMQkJMHhDQjAwNDAxMA0KPiA+
ICAjZGVmaW5lIFdMQU5fTFRSX0NUUkwyCQkweDAxMjMzNDI1DQo+ID4NCj4gPiArc3RhdGljIHZv
aWQgcnR3ODcyM2RfbGNrKHN0cnVjdCBydHdfZGV2ICpydHdkZXYpDQo+ID4gK3sNCj4gPiArI2Rl
ZmluZSBCSVRfTENLCQlCSVQoMTUpDQo+IA0KPiBwbGVhc2UgZG9uJ3QgYWRkIGRlZmluZXMgbGlr
ZSB0aGlzIHdpdGhpbiBhIGZ1bmN0aW9uLg0KPiANCj4gPiArCXU4IHZhbF9jdHg7DQo+ID4gKwl1
MzIgbGNfY2FsLCBjbnQ7DQo+ID4gKw0KPiA+ICsJdmFsX2N0eCA9IHJ0d19yZWFkOChydHdkZXYs
IFJFR19DVFgpOw0KPiA+ICsJaWYgKCh2YWxfY3R4ICYgQklUX01BU0tfQ1RYX1RZUEUpICE9IDAp
DQo+ID4gKwkJcnR3X3dyaXRlOChydHdkZXYsIFJFR19DVFgsIHZhbF9jdHggJiB+QklUX01BU0tf
Q1RYX1RZUEUpOw0KPiA+ICsJZWxzZQ0KPiA+ICsJCXJ0d193cml0ZTgocnR3ZGV2LCBSRUdfVFhQ
QVVTRSwgMHhGRik7DQo+ID4gKwlsY19jYWwgPSBydHdfcmVhZF9yZihydHdkZXYsIFJGX1BBVEhf
QSwgUkZfQ0ZHQ0gsIFJGUkVHX01BU0spOw0KPiA+ICsNCj4gPiArCXJ0d193cml0ZV9yZihydHdk
ZXYsIFJGX1BBVEhfQSwgUkZfQ0ZHQ0gsIFJGUkVHX01BU0ssIGxjX2NhbCB8DQo+IEJJVF9MQ0sp
Ow0KPiA+ICsJZm9yIChjbnQgPSAwOyBjbnQgPCAxMDA7IGNudCsrKSB7DQo+ID4gKwkJaWYgKHJ0
d19yZWFkX3JmKHJ0d2RldiwgUkZfUEFUSF9BLCBSRl9DRkdDSCwgQklUX0xDSykgIT0gMHgxKQ0K
PiA+ICsJCQlicmVhazsNCj4gPiArCQltZGVsYXkoMTApOw0KPiANCj4gRG8geW91IGhhdmUgYW55
IG51bWJlcnMgb24gaG93IGxvbmcgdGhpcyB0YWtlcz8gTGlrZSBiZXN0LWNhc2UsIG9uIGF2ZXJh
Z2UsDQo+IHdvcnN0IGNhc2U/IEknbSBhc2tpbmcgYmVjYXVzZSBpZiB0aGUgYml0IGRvZXMgbm90
IGZsaXAgb24gdGhlIGZpcnN0DQo+IHJlYWQgdGhlbiB5b3UgYnVzeS1sb29wLWRlbGF5IGhlcmUg
Zm9yIDEwbXMuIElmIGl0IGRvZXMgbm90IGZsaXAgYXQgYWxsLA0KPiB5b3UgYnVzeSB3YWl0ZWQg
YSB3aG9sZSBzZWNvbmQgd2l0aG91dCBhbnkgY29uc2VxdWVuY2UuDQo+IA0KPiBJdCBsb29rcyBs
aWtlIHRoaXMgY29udGV4dCBoZXJlIGlzIG5vdCBhdG9taWMgc28gbXNsZWVwKCkgd291bGQgd29y
ayB3aGVyZS4NCg0KSW5kZWVkLCBJIHRoaW5rIHJlYWRfcG9sbF90aW1lb3V0KCkgd2lsbCBiZSBn
b29kIGZvciB0aGlzIGNhc2UuIFRoYW5rcy4NCg0KPiANCj4gU2ViYXN0aWFuDQo+IA0KDQpZZW4t
SHN1YW4NCg==
