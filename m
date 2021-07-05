Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79DE83BB9B3
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Jul 2021 10:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbhGEJBq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 5 Jul 2021 05:01:46 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:46622 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbhGEJBq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 5 Jul 2021 05:01:46 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 1658wrr77029648, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36502.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 1658wrr77029648
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 5 Jul 2021 16:58:53 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36502.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 5 Jul 2021 16:58:52 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 5 Jul 2021 16:58:51 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::a0a3:e64a:34ad:fe28]) by
 RTEXMBS04.realtek.com.tw ([fe80::a0a3:e64a:34ad:fe28%5]) with mapi id
 15.01.2106.013; Mon, 5 Jul 2021 16:58:51 +0800
From:   Pkshih <pkshih@realtek.com>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
CC:     "kvalo@codeaurora.org" <kvalo@codeaurora.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH 04/24] rtw89: add debug files
Thread-Topic: [PATCH 04/24] rtw89: add debug files
Thread-Index: AQHXZA3L/KWeN+OUEEWYUAFkKlwvy6su1/4AgAT7bjA=
Date:   Mon, 5 Jul 2021 08:58:51 +0000
Message-ID: <ceb8911a8ca0465a9f243e1d84ab911e@realtek.com>
References: <20210618064625.14131-1-pkshih@realtek.com>
 <20210618064625.14131-5-pkshih@realtek.com>
 <20210702072308.GA4184@pengutronix.de>
In-Reply-To: <20210702072308.GA4184@pengutronix.de>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.146]
x-kse-serverinfo: RTEXDAG01.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIxLzcvNSDkuIrljYggMDQ6MjM6MDA=?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36502.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 07/05/2021 08:44:49
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 164833 [Jul 05 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: pkshih@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 448 448 71fb1b37213ce9a885768d4012c46ac449c77b17
X-KSE-AntiSpam-Info: {Tracking_from_exist}
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: realtek.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 07/05/2021 08:48:00
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogT2xla3NpaiBSZW1wZWwg
W21haWx0bzpvLnJlbXBlbEBwZW5ndXRyb25peC5kZV0NCj4gU2VudDogRnJpZGF5LCBKdWx5IDAy
LCAyMDIxIDM6MjMgUE0NCj4gVG86IFBrc2hpaA0KPiBDYzoga3ZhbG9AY29kZWF1cm9yYS5vcmc7
IGxpbnV4LXdpcmVsZXNzQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDA0
LzI0XSBydHc4OTogYWRkIGRlYnVnIGZpbGVzDQo+IA0KPiBPbiBGcmksIEp1biAxOCwgMjAyMSBh
dCAwMjo0NjowNVBNICswODAwLCBQaW5nLUtlIFNoaWggd3JvdGU6DQo+ID4gVG8gcmVjb2duaXpl
IGlzc3VlcyBoYXBwZW5lZCBpbiBmaWVsZCwgdHdvIGRlYnVnIG1ldGhvZHMsIGRlYnVnIG1lc3Nh
Z2UgYW5kDQo+ID4gZGVidWdmcywgYXJlIGFkZGVkLg0KPiA+DQo+ID4gVGhlIGRlYnVnIG1lc3Nh
Z2VzIGFyZSB3cml0dGVuIHRvIGtlcm5lbCBsb2csIGFuZCBmb3VyIGxldmVscyBjYW4gYmUgY2hv
c2VuDQo+ID4gYWNjb3JkaW5nIHRvIHRoZSBjYXNlcyAtLSBkZWJ1ZywgaW5mbywgd2FybiBhbmQg
ZXJyLg0KPiA+DQo+ID4gRGVidWdmcyBpcyB1c2VkIHRvIHJlYWQgYW5kIHdyaXRlIHJlZ2lzdGVy
cyBhbmQgZHJpdmVyIHN0YXR1cy4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFBpbmctS2UgU2hp
aCA8cGtzaGloQHJlYWx0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL25ldC93aXJlbGVz
cy9yZWFsdGVrL3J0dzg5L2RlYnVnLmMgfCAyNDA0ICsrKysrKysrKysrKysrKysrKysrDQo+ID4g
IGRyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODkvZGVidWcuaCB8ICAgNzcgKw0KPiA+
ICAyIGZpbGVzIGNoYW5nZWQsIDI0ODEgaW5zZXJ0aW9ucygrKQ0KPiA+ICBjcmVhdGUgbW9kZSAx
MDA2NDQgZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OS9kZWJ1Zy5jDQo+ID4gIGNy
ZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg5L2RlYnVn
LmgNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0
dzg5L2RlYnVnLmMNCj4gYi9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg5L2RlYnVn
LmMNCj4gPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiA+IGluZGV4IDAwMDAwMDAwMDAwMC4uMDNk
MmQyZWI4MTNkDQo+ID4gLS0tIC9kZXYvbnVsbA0KPiA+ICsrKyBiL2RyaXZlcnMvbmV0L3dpcmVs
ZXNzL3JlYWx0ZWsvcnR3ODkvZGVidWcuYw0KDQpbLi4uXQ0KDQo+ID4gK3N0YXRpYyBpbnQgcnR3
ODlfZGVidWdfcHJpdl9yZl9yZWdfZHVtcF9nZXQoc3RydWN0IHNlcV9maWxlICptLCB2b2lkICp2
KQ0KPiA+ICt7DQo+ID4gKwlzdHJ1Y3QgcnR3ODlfZGVidWdmc19wcml2ICpkZWJ1Z2ZzX3ByaXYg
PSBtLT5wcml2YXRlOw0KPiA+ICsJc3RydWN0IHJ0dzg5X2RldiAqcnR3ZGV2ID0gZGVidWdmc19w
cml2LT5ydHdkZXY7DQo+ID4gKwljb25zdCBzdHJ1Y3QgcnR3ODlfY2hpcF9pbmZvICpjaGlwID0g
cnR3ZGV2LT5jaGlwOw0KPiA+ICsJdTMyIGFkZHIsIG9mZnNldCwgZGF0YTsNCj4gPiArCXU4IHBh
dGg7DQo+ID4gKw0KPiA+ICsJZm9yIChwYXRoID0gMDsgcGF0aCA8IGNoaXAtPnJmX3BhdGhfbnVt
OyBwYXRoKyspIHsNCj4gPiArCQlzZXFfcHJpbnRmKG0sICJSRiBwYXRoICVkOlxuXG4iLCBwYXRo
KTsNCj4gPiArCQlmb3IgKGFkZHIgPSAwOyBhZGRyIDwgMHgxMDA7IGFkZHIgKz0gNCkgew0KPiA+
ICsJCQlzZXFfcHJpbnRmKG0sICIweCUwOHg6ICIsIGFkZHIpOw0KPiA+ICsJCQlmb3IgKG9mZnNl
dCA9IDA7IG9mZnNldCA8IDQ7IG9mZnNldCsrKSB7DQo+ID4gKwkJCQlkYXRhID0gcnR3ODlfcmVh
ZF9yZihydHdkZXYsIHBhdGgsDQo+ID4gKwkJCQkJCSAgICAgYWRkciArIG9mZnNldCwgUkZSRUdf
TUFTSyk7DQo+ID4gKwkJCQlzZXFfcHJpbnRmKG0sICIweCUwNXggICIsIGRhdGEpOw0KPiA+ICsJ
CQl9DQo+ID4gKwkJCXNlcV9wdXRzKG0sICJcbiIpOw0KPiA+ICsJCX0NCj4gPiArCQlzZXFfcHV0
cyhtLCAiXG4iKTsNCj4gPiArCX0NCj4gPiArDQo+ID4gKwlyZXR1cm4gMDsNCj4gPiArfQ0KPiAN
Cj4gQmFzZWQgb24gdGhpcyBhbmQgb3RoZXIgcGFydCBvZiB0aGlzIGRyaXZlciBJIHdvdWxkIHJl
Y29tbWVuZCB0byB1c2UNCj4gcmVnbWFwLiBJdCB3aWxsIHByb3ZpZGUgdG8gYWRkaXRpb25hbCBp
bnRlcmZhY2UgZm9yIHRoZSByZWdpc3Rlcg0KPiBhY2Nlc3MuIEFuZCB0eXBpY2FsbHkgZm9yIHRo
ZSBuZXR3b3JrIGRldmljZXMgd2UgaGF2ZSBhbiBldGh0b29sDQo+IGludGVyZmFjZSBmb3IgdGhh
dC4NCj4gDQoNCkNvdWxkIEkga25vdyB0aGUgJ3JlZ21hcCcgeW91IG1lbnRpb25lZD8NCg0KSSBz
dHVkeSBpbnRlcmZhY2VzIG9mIGV0aHRvb2wuIEl0IHNldHMvZ2V0cyBkdW1wIHZpYSBzdHJ1Y3Qg
ZXRodG9vbF9kdW1wLg0KSSBmYWNlIHByb2JsZW1zOiB0aGlzIGNoaXAgaGFzIG1hbnkgcmVnaXN0
ZXIgZG9tYWlucywgYnV0IHRoZXJlJ3Mgbm8gd2F5IHRvDQpzcGVjaWZ5IHRoZSBkb21haW4gdHlw
ZS4gVGhlIGFtb3VudCBvZiByZWdpc3RlcnMgaXMgbGFyZ2UsIHNvIEkgbmVlZCB0byBzcGVjaWZ5
DQp0aGUgcmFuZ2UgSSB3YW50IHRvIGR1bXAsIGJ1dCBubyBvZmZzZXQvbGVuZ3RoIGNhbiBiZSB1
c2VkIGJ5IEVUSFRPT0xfU0VUX0RVTVAuDQpBbm90aGVyIHJlYXNvbiBJIGNhbid0IGR1bXAgYWxs
IHJlZ2lzdGVycyBpcyB0aGF0IHNvbWUgZG9tYWlucyBhcmUgaW5kaXJlY3QNCmFjY2VzcyB3aXRo
IHR3byByZWdpc3RlcnMgKG9uZSBpcyBjb250cm9sIHJlZ2lzdGVyLCBhbmQgdGhlIG90aGVyIGlz
IGRhdGENCnJlZ2lzdGVyKSwgSSBjYW4ndCBhY2Nlc3MgdGhlbSBhcmJpdHJhcmlseSBiZWNhdXNl
IGZpcm13YXJlIGNhbiB1c2UgdGhlbSANCnNpbXVsdGFuZW91c2x5LiBJbnN0ZWFkLCB0aGV5IGFy
ZSBvbmx5IHVzZWQgaW4gZmF0YWwgY2FzZXMuDQoNClNvLCBJIGNhbid0IHVzZSBpbnRlcmZhY2Vz
IG9mIGV0aHRvb2wsIGJ1dCBJJ2xsIHRyeSB0byBtZXJnZSBkdXBsaWNhdGUgdG8NCnJlZHVjZSBj
b2RlIHNpemUuDQoNCi0tDQpQaW5nLUtlDQoNCg==
