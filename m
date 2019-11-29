Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E677010D108
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Nov 2019 06:27:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726215AbfK2F1S (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 Nov 2019 00:27:18 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:60367 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbfK2F1S (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 Nov 2019 00:27:18 -0500
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID xAT5R9AC018709, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCAS12.realtek.com.tw[172.21.6.16])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id xAT5R9AC018709
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Nov 2019 13:27:09 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTITCAS12.realtek.com.tw (172.21.6.16) with Microsoft SMTP Server (TLS) id
 14.3.468.0; Fri, 29 Nov 2019 13:27:09 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 29 Nov 2019 13:27:08 +0800
Received: from RTEXMB04.realtek.com.tw ([fe80::7d15:f8ee:cfc7:88ce]) by
 RTEXMB04.realtek.com.tw ([fe80::7d15:f8ee:cfc7:88ce%6]) with mapi id
 15.01.1779.005; Fri, 29 Nov 2019 13:27:08 +0800
From:   Tony Chuang <yhchuang@realtek.com>
To:     Chris Chiu <chiu@endlessm.com>
CC:     Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Brian Norris <briannorris@chromium.org>
Subject: RE: [PATCH 2/6] rtw88: pci: reset dma when reset pci trx ring
Thread-Topic: [PATCH 2/6] rtw88: pci: reset dma when reset pci trx ring
Thread-Index: AQHVpeYRA3MIlkHO/UGExd89d6mRPqeg+Z+AgAChHxA=
Date:   Fri, 29 Nov 2019 05:27:08 +0000
Message-ID: <22412a77baab402f8e671160a204e019@realtek.com>
References: <20191128121907.6178-1-yhchuang@realtek.com>
 <20191128121907.6178-3-yhchuang@realtek.com>
 <CAB4CAwfoGxxZfuDJnbrxBNGXgxfsJzFNtqCXv4ZpEQx23eZRmQ@mail.gmail.com>
In-Reply-To: <CAB4CAwfoGxxZfuDJnbrxBNGXgxfsJzFNtqCXv4ZpEQx23eZRmQ@mail.gmail.com>
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

PiBTdWJqZWN0OiBSZTogW1BBVENIIDIvNl0gcnR3ODg6IHBjaTogcmVzZXQgZG1hIHdoZW4gcmVz
ZXQgcGNpIHRyeCByaW5nDQo+IA0KPiBPbiBUaHUsIE5vdiAyOCwgMjAxOSBhdCA4OjE5IFBNIDx5
aGNodWFuZ0ByZWFsdGVrLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBGcm9tOiBDaGluLVllbiBMZWUg
PHRpbWxlZUByZWFsdGVrLmNvbT4NCj4gPg0KPiA+IFdoZW4gcGNpIHRyeCByaW5nIGlzIHJlc2V0
LCBodyBkbWEgc2V0dGluZyBzaG91bGQgYmUgcmVzZXQgdG9nZXRoZXIuDQo+ID4gT3RoZXJzd2lz
ZSwgdGhlIHJ4X3RhZyBvZiByeCBmbG93IGlzIG5vdCBzeW5jaHJvbm91cyB0byBody4NCj4gPg0K
PiA+IFNpZ25lZC1vZmYtYnk6IENoaW4tWWVuIExlZSA8dGltbGVlQHJlYWx0ZWsuY29tPg0KPiA+
IFNpZ25lZC1vZmYtYnk6IFlhbi1Ic3VhbiBDaHVhbmcgPHloY2h1YW5nQHJlYWx0ZWsuY29tPg0K
PiA+IC0tLQ0KPiA+ICBkcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg4L3BjaS5jIHwg
MTcgKysrKysrKysrKy0tLS0tLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDEwIGluc2VydGlvbnMo
KyksIDcgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2ly
ZWxlc3MvcmVhbHRlay9ydHc4OC9wY2kuYw0KPiBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0
ZWsvcnR3ODgvcGNpLmMNCj4gPiBpbmRleCAwNjhmMWJlYzg4ZTYuLjc4OTcxY2VmYjk0OCAxMDA2
NDQNCj4gPiAtLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg4L3BjaS5jDQo+
ID4gKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OC9wY2kuYw0KPiA+IEBA
IC00ODYsMTMgKzQ4Niw2IEBAIHN0YXRpYyB2b2lkIHJ0d19wY2lfZGlzYWJsZV9pbnRlcnJ1cHQo
c3RydWN0DQo+IHJ0d19kZXYgKnJ0d2RldiwNCj4gPiAgICAgICAgIHJ0d3BjaS0+aXJxX2VuYWJs
ZWQgPSBmYWxzZTsNCj4gPiAgfQ0KPiA+DQo+ID4gLXN0YXRpYyBpbnQgcnR3X3BjaV9zZXR1cChz
dHJ1Y3QgcnR3X2RldiAqcnR3ZGV2KQ0KPiA+IC17DQo+ID4gLSAgICAgICBydHdfcGNpX3Jlc2V0
X3RyeF9yaW5nKHJ0d2Rldik7DQo+ID4gLQ0KPiA+IC0gICAgICAgcmV0dXJuIDA7DQo+ID4gLX0N
Cj4gPiAtDQo+ID4gIHN0YXRpYyB2b2lkIHJ0d19wY2lfZG1hX3Jlc2V0KHN0cnVjdCBydHdfZGV2
ICpydHdkZXYsIHN0cnVjdCBydHdfcGNpDQo+ICpydHdwY2kpDQo+ID4gIHsNCj4gPiAgICAgICAg
IC8qIHJlc2V0IGRtYSBhbmQgcnggdGFnICovDQo+ID4gQEAgLTUwMSw2ICs0OTQsMTYgQEAgc3Rh
dGljIHZvaWQgcnR3X3BjaV9kbWFfcmVzZXQoc3RydWN0IHJ0d19kZXYNCj4gKnJ0d2Rldiwgc3Ry
dWN0IHJ0d19wY2kgKnJ0d3BjaSkNCj4gPiAgICAgICAgIHJ0d3BjaS0+cnhfdGFnID0gMDsNCj4g
PiAgfQ0KPiA+DQo+ID4gK3N0YXRpYyBpbnQgcnR3X3BjaV9zZXR1cChzdHJ1Y3QgcnR3X2RldiAq
cnR3ZGV2KQ0KPiA+ICt7DQo+ID4gKyAgICAgICBzdHJ1Y3QgcnR3X3BjaSAqcnR3cGNpID0gKHN0
cnVjdCBydHdfcGNpICopcnR3ZGV2LT5wcml2Ow0KPiA+ICsNCj4gPiArICAgICAgIHJ0d19wY2lf
cmVzZXRfdHJ4X3JpbmcocnR3ZGV2KTsNCj4gPiArICAgICAgIHJ0d19wY2lfZG1hX3Jlc2V0KHJ0
d2RldiwgcnR3cGNpKTsNCj4gPiArDQo+ID4gKyAgICAgICByZXR1cm4gMDsNCj4gPiArfQ0KPiA+
ICsNCj4gSnVzdCBhIGxpdHRsZSBjdXJpb3VzIGFib3V0IHRoYXQgdGhlIHJ0d19wY2lfZG1hX3Jl
c2V0KCkgaXMgYWxyZWFkeSBpbg0KPiBydHdfcGNpX3N0YXJ0KCksIHRoZW4gaXMgaXQgcmVhbGx5
IG5lY2Vzc2FyeSB0byBkbyBpdCBpbiBfc2V0dXA/IE9yDQo+IG1heWJlIHRoZSBydHdfcGNpX2Rt
YV9yZXNldCgpIGluIHJ0d19wY2lfc3RhcnQgc2hvdWxkIGJlIHJlbW92ZWQ/DQo+IA0KPiBDaHJp
cw0KPiANCg0KWWVzLCBpdCBsb29rcyByZWR1bmRhbnQsIGNhbiBiZSByZW1vdmVkLg0KVGhhbmtz
Lg0KDQpZYW4gSHN1YW4NCg==
