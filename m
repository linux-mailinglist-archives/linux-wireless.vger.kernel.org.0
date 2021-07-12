Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB93A3C46C4
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Jul 2021 12:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234983AbhGLG2i (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 12 Jul 2021 02:28:38 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:53479 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235395AbhGLG0y (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 12 Jul 2021 02:26:54 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 16C6NunJ6006909, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36502.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 16C6NunJ6006909
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 12 Jul 2021 14:23:56 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36502.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 12 Jul 2021 14:23:56 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 12 Jul 2021 14:23:55 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::5bd:6f71:b434:7c91]) by
 RTEXMBS04.realtek.com.tw ([fe80::5bd:6f71:b434:7c91%5]) with mapi id
 15.01.2106.013; Mon, 12 Jul 2021 14:23:55 +0800
From:   Pkshih <pkshih@realtek.com>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
CC:     "kvalo@codeaurora.org" <kvalo@codeaurora.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH 14/24] rtw89: 8852a: add 8852a RFK files
Thread-Topic: [PATCH 14/24] rtw89: 8852a: add 8852a RFK files
Thread-Index: AQHXZA3j53IKl6o86ku1040hSiQEe6s6hP8AgAQ5MXA=
Date:   Mon, 12 Jul 2021 06:23:55 +0000
Message-ID: <842646b179914bd8a6d33d5a4ab99ab4@realtek.com>
References: <20210618064625.14131-1-pkshih@realtek.com>
 <20210618064625.14131-15-pkshih@realtek.com>
 <20210709174112.GC2099@pengutronix.de>
In-Reply-To: <20210709174112.GC2099@pengutronix.de>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.146]
x-kse-serverinfo: RTEXMBS05.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIxLzcvMTEg5LiL5Y2IIDAxOjA3OjAw?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36502.realtek.com.tw, 9
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIxLzcvMTIg5LiK5Y2IIDAyOjMxOjAw?=
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 07/12/2021 06:10:42
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 164973 [Jul 12 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: pkshih@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 448 448 71fb1b37213ce9a885768d4012c46ac449c77b17
X-KSE-AntiSpam-Info: {Tracking_from_exist}
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: 127.0.0.199:7.1.2;realtek.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 07/12/2021 06:13:00
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE9sZWtzaWogUmVtcGVsIFtt
YWlsdG86by5yZW1wZWxAcGVuZ3V0cm9uaXguZGVdDQo+IFNlbnQ6IFNhdHVyZGF5LCBKdWx5IDEw
LCAyMDIxIDE6NDEgQU0NCj4gVG86IFBrc2hpaA0KPiBDYzoga3ZhbG9AY29kZWF1cm9yYS5vcmc7
IGxpbnV4LXdpcmVsZXNzQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDE0
LzI0XSBydHc4OTogODg1MmE6IGFkZCA4ODUyYSBSRksgZmlsZXMNCj4gDQo+IE9uIEZyaSwgSnVu
IDE4LCAyMDIxIGF0IDAyOjQ2OjE1UE0gKzA4MDAsIFBpbmctS2UgU2hpaCB3cm90ZToNCj4gPiBS
RksgY29udGFpbnMgREFDSywgSVFLLCBMT0ssIFJDSywgUlggRENLLCBEUEsgYW5kIFRTU0kuIFRo
ZXkgYXJlIGNhbGxlZCBieQ0KPiA+IHJma19pbml0LCByZmtfY2hhbm5lbCBhbmQgcmZrX3RyYWNr
IGF0IHRoZSBvY2Nhc2lvbnMgb2YgaW5pdGlhbGl6YXRpb24sDQo+ID4gY2hhbm5lbCBzd2l0Y2gg
YW5kIHBlcmlvZGljIHRyYWNrIHJlc3BlY3RpdmVseS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6
IFBpbmctS2UgU2hpaCA8cGtzaGloQHJlYWx0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+ICAuLi4vbmV0
L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODkvcnR3ODg1MmFfcmZrLmMgfCAzODA2ICsrKysrKysrKysr
KysrKysrDQo+ID4gIC4uLi9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OS9ydHc4ODUyYV9yZmsu
aCB8ICAgMjIgKw0KPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDM4MjggaW5zZXJ0aW9ucygrKQ0KPiA+
ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OS9y
dHc4ODUyYV9yZmsuYw0KPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9uZXQvd2lyZWxl
c3MvcmVhbHRlay9ydHc4OS9ydHc4ODUyYV9yZmsuaA0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODkvcnR3ODg1MmFfcmZrLmMNCj4gYi9kcml2
ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg5L3J0dzg4NTJhX3Jmay5jDQo+ID4gbmV3IGZp
bGUgbW9kZSAxMDA2NDQNCj4gPiBpbmRleCAwMDAwMDAwMDAwMDAuLjIzOTMyNzg0ZTZlMQ0KPiA+
IC0tLSAvZGV2L251bGwNCj4gPiArKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0
dzg5L3J0dzg4NTJhX3Jmay5jDQo+ID4gQEAgLTAsMCArMSwzODA2IEBADQoNClsuLi5dDQoNCj4g
PiArdm9pZCBydHc4ODUyYV90c3NpX3NjYW4oc3RydWN0IHJ0dzg5X2RldiAqcnR3ZGV2LCBlbnVt
IHJ0dzg5X3BoeV9pZHggcGh5KQ0KPiA+ICt7DQo+ID4gKwl1OCBpOw0KPiA+ICsNCj4gPiArCXJl
dHVybjsNCj4gDQo+IHJ0dzg4NTJhX3Rzc2lfc2NhbigpIGlzIG5vdCBleGVjdXRlZC4gUGxlYXNl
IHJlbW92ZSB3aXRoIGFsbA0KPiBkZXBlbmRlbmNpZXMuDQo+IA0KDQpUaGlzICdyZXR1cm4nLCB3
aGljaCBpcyB0eXBvLCB3aWxsIGJlIHJlbW92ZWQsIHNvIHJ0dzg4NTJhX3Rzc2lfc2NhbigpIHdp
bGwgYmUga2VwdC4NCg0KPiA+ICsJcnR3ODlfZGVidWcocnR3ZGV2LCBSVFc4OV9EQkdfVFNTSSwg
IltUU1NJXSAlczogcGh5PSVkXG4iLA0KPiA+ICsJCSAgICBfX2Z1bmNfXywgcGh5KTsNCj4gPiAr
DQo+ID4gKwlpZiAoIXJ0d2Rldi0+aXNfdHNzaV9tb2RlW1JGX1BBVEhfQV0pDQo+ID4gKwkJcmV0
dXJuOw0KPiA+ICsJaWYgKCFydHdkZXYtPmlzX3Rzc2lfbW9kZVtSRl9QQVRIX0JdKQ0KPiA+ICsJ
CXJldHVybjsNCj4gPiArDQo+ID4gKwlfdHNzaV9kaXNhYmxlKHJ0d2RldiwgcGh5KTsNCj4gPiAr
DQo+ID4gKwlmb3IgKGkgPSBSRl9QQVRIX0E7IGkgPCBSRl9QQVRIX05VTV84ODUyQTsgaSsrKSB7
DQo+ID4gKwkJX3Rzc2lfcmZfc2V0dGluZyhydHdkZXYsIHBoeSwgaSk7DQo+ID4gKwkJX3Rzc2lf
c2V0X3N5cyhydHdkZXYsIHBoeSk7DQo+ID4gKwkJX3Rzc2lfc2V0X3RtZXRlcl90YmwocnR3ZGV2
LCBwaHksIGkpOw0KPiA+ICsJCV90c3NpX3BhayhydHdkZXYsIHBoeSwgaSk7DQo+ID4gKwl9DQo+
ID4gKw0KPiA+ICsJX3Rzc2lfZW5hYmxlKHJ0d2RldiwgcGh5KTsNCj4gPiArCV90c3NpX3NldF9l
ZnVzZV90b19kZShydHdkZXYsIHBoeSk7DQo+ID4gK30NCj4gPiArDQo+ID4gK3ZvaWQgcnR3ODg1
MmFfdHNzaV90cmFjayhzdHJ1Y3QgcnR3ODlfZGV2ICpydHdkZXYpDQo+ID4gK3sNCj4gPiArCV90
c3NpX3RyYWNrKHJ0d2Rldik7DQo+ID4gK30NCj4gDQo+IHJ0dzg4NTJhX3Rzc2lfdHJhY2soKSBp
cyBub3QgdXNlZA0KPiANCg0KSSdsbCBjaGVjayBUU1NJIG93bmVyLg0KV2lsbCByZW1vdmUgaXQg
aWYgd2UgZG9uJ3QgbmVlZCBpdCwgb3IgY2FsbCBpdCBpZiBuZWNlc3NhcnkuDQoNCg0K
