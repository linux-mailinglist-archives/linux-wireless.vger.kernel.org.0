Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 478273C46C8
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Jul 2021 12:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233833AbhGLG2m (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 12 Jul 2021 02:28:42 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:53473 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235367AbhGLG0v (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 12 Jul 2021 02:26:51 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 16C6NkznE006883, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36502.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 16C6NkznE006883
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 12 Jul 2021 14:23:46 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36502.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 12 Jul 2021 14:23:45 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 12 Jul 2021 14:23:45 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::5bd:6f71:b434:7c91]) by
 RTEXMBS04.realtek.com.tw ([fe80::5bd:6f71:b434:7c91%5]) with mapi id
 15.01.2106.013; Mon, 12 Jul 2021 14:23:45 +0800
From:   Pkshih <pkshih@realtek.com>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
CC:     "kvalo@codeaurora.org" <kvalo@codeaurora.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH 07/24] rtw89: add MAC files
Thread-Topic: [PATCH 07/24] rtw89: add MAC files
Thread-Index: AQHXZA3RWJVK/ScoVU6riR52Vdh9Zqs6hC6AgAQ1bMA=
Date:   Mon, 12 Jul 2021 06:23:45 +0000
Message-ID: <63d089da18e7440a9963ecec5f17702f@realtek.com>
References: <20210618064625.14131-1-pkshih@realtek.com>
 <20210618064625.14131-8-pkshih@realtek.com>
 <20210709173817.GB2099@pengutronix.de>
In-Reply-To: <20210709173817.GB2099@pengutronix.de>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.146]
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
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
X-KSE-AntiSpam-Info: d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;realtek.com:7.1.1;127.0.0.199:7.1.2
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogT2xla3NpaiBSZW1wZWwg
W21haWx0bzpvLnJlbXBlbEBwZW5ndXRyb25peC5kZV0NCj4gU2VudDogU2F0dXJkYXksIEp1bHkg
MTAsIDIwMjEgMTozOCBBTQ0KPiBUbzogUGtzaGloDQo+IENjOiBrdmFsb0Bjb2RlYXVyb3JhLm9y
ZzsgbGludXgtd2lyZWxlc3NAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0gg
MDcvMjRdIHJ0dzg5OiBhZGQgTUFDIGZpbGVzDQo+IA0KPiBPbiBGcmksIEp1biAxOCwgMjAyMSBh
dCAwMjo0NjowOFBNICswODAwLCBQaW5nLUtlIFNoaWggd3JvdGU6DQo+ID4gUHJvdmlkZSBpbnRl
cmZhY2VzIHRvIGFjY2VzcyBNQUMgZnVuY3Rpb24gYmxvY2tzIGluY2x1ZGluZyBwb3dlci1vbi9v
ZmYNCj4gPiBjb25maWd1cmF0aW9uLg0KPiA+DQo+ID4gTUFDIGluaXRpYWxpemF0aW9uIGRvZXMg
cG93ZXItb24sIGFuZCB0aGVuIGVuYWJsZSBIQ0kgdG8gZG93bmxvYWQgZmlybXdhcmUuDQo+ID4g
VGhlIEJCLCBSRiwgRE1BQyBhbmQgQ01BQyBmdW5jdGlvbiBibG9ja3MgYXJlIGVuYWJsZWQsIGFu
ZCB0aGVuIGNvbmZpZ3VyZQ0KPiA+IFRYUlggc2V0dGluZ3MgdGhhdCBjb250YWlucyBETUFDLCBD
TUFDLCBpbnRlcnJ1cHQgbWFzaywgYW5kIFJQUSBwYXJhbWV0ZXJzLg0KPiA+IERNQUMgaXMgc2hv
cnQgZm9yIGRhdGEgTUFDLCBpbmNsdWRpbmcgZGF0YSBsaW5rIGVuZ2luZSAoRExFKSwgSENJIGZ1
bmN0aW9uDQo+ID4gY29udHJvbCAoSEZDKSwgTVBEVSBwcm9jZXNzb3IsIHNlY3VyaXR5IGVuZ2lu
ZSBhbmQgc28gb24uIENNQUMgaXMgc2hvcnQgZm9yDQo+ID4gY29udHJvbCBNQUMsIGluY2x1ZGlu
ZyBzY2hlZHVsZXIsIGFkZHJlc3MgQ0FNLCBSWCBmaWx0ZXIsIENDQSBjb250cm9sLA0KPiA+IFRN
QUMsIFJNQUMsIHByb3RvY29sIGNvbXBvbmVudCBhbmQgc28gb24uDQo+ID4NCj4gPiBUaGUgZnVs
bCBNQUMgaW5pdGlhbGl6YXRpb24gaXMgZG9uZSBmb3Igbm9ybWFsIHVzZSBjYXNlIHdoZW4gdXNl
ciBkb2VzDQo+ID4gbmV0d29yayBpbnRlcmZhY2UgdXAuIFdoZW4gZGV2aWNlIGlzIHByb2Jpbmcs
IGRyaXZlciBkb2VzIHBhcnRpYWwNCj4gPiBpbml0aWFsaXphdGlvbiB0byBkbyBwb3dlci1vbiBh
bmQgZG93bmxvYWQgZmlybXdhcmUsIGJlY2F1c2Ugd2UgbmVlZCB0bw0KPiA+IHJlYWQgaGFyZHdh
cmUgY2FwYWJpbGl0aWVzIGZyb20gZWZ1c2UgYW5kIGZpcm13YXJlLg0KPiA+DQo+ID4gTUFDIHN1
cHBvcnRzIGZpdmUgcG9ydHMsIHNvIHdlIGNhbiBoYXZlIGZpdmUgVklGcyBhdCBtb3N0LiBUbyBj
b250cm9sIE1BQw0KPiA+IHBvcnQsIHdlIGNvbnRyb2wgYSBzZXQgb2YgcmVnaXN0ZXJzLCBhbmQg
dGhlIG1vc3QgaW1wb3J0YW50IG9uZSBhbW9uZyB0aGVtDQo+ID4gaXMgcG9ydF9jZmcgcmVnaXN0
ZXIgbmFtZWQgUl9BWF9QT1JUX0NGR19QMC4gV2UgY2FuIHR1cm4gb24vb2ZmIHRoZSBwb3J0DQo+
ID4gZnVuY3Rpb24gYW5kIGNvbmZpZ3VyZSBuZXR3b3JrIHR5cGUgKFNUQSBvciBBUCBtb2RlKSBi
eSB0aGlzIHJlZ2lzdGVyLg0KPiA+IFRoZSBhZGRyZXNzIGFuZCBCU1NJRCBjb3JyZXNwb25kaW5n
IHRvIHRoaXMgcG9ydCBhcmUgZ2l2ZW4gYnkgYWRkcmVzcw0KPiA+IGFuZCBCU1NJRCBDQU0gdGhh
dCBpcyBzZXQgYnkgZmlybXdhcmUgdmlhIEgyQyBjb21tYW5kLg0KPiA+DQo+ID4gU2luY2UgQlQg
Y29leGlzdGVuY2UgY29kZSBuZWVkcyB0byBhY2Nlc3MgY29leCByZWdpc3RlcnMsIHNvbWUgaGVs
cA0KPiA+IGZ1bmN0aW9ucyBhcmUgcHJvdmlkZWQgdG8gbWFrZSBXaUZpLW9ubHkgY2FzZSB3b3Jr
Lg0KPiA+DQo+ID4gVG8gYWNjZXNzIE1BQyByZWdpc3RlcnMsIG5vcm1hbGx5IHdlIHVzZSBydHc4
OV93cml0ZVhYL3J0dzg5X3JlYWRZWSwgYnV0DQo+ID4gd2UgdXNlIHJ0dzg5X21hY190eHB3cl93
cml0ZTMyX1paIHRvIGFjY2VzcyBUWCBwb3dlciByZWdpc3RlciB3aXRoIHByb3Blcg0KPiA+IGFk
ZHJlc3MgcmFuZ2UgY2hlY2tpbmcuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBQaW5nLUtlIFNo
aWggPHBrc2hpaEByZWFsdGVrLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9uZXQvd2lyZWxl
c3MvcmVhbHRlay9ydHc4OS9tYWMuYyB8IDQwNzAgKysrKysrKysrKysrKysrKysrKysrKw0KPiA+
ICBkcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg5L21hYy5oIHwgIDkwNSArKysrKw0K
PiA+ICAyIGZpbGVzIGNoYW5nZWQsIDQ5NzUgaW5zZXJ0aW9ucygrKQ0KPiA+ICBjcmVhdGUgbW9k
ZSAxMDA2NDQgZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OS9tYWMuYw0KPiA+ICBj
cmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OS9tYWMu
aA0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3
ODkvbWFjLmMgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg5L21hYy5jDQo+ID4g
bmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gPiBpbmRleCAwMDAwMDAwMDAwMDAuLmUwMDY1MmUxMTk0
MQ0KPiA+IC0tLSAvZGV2L251bGwNCj4gPiArKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFs
dGVrL3J0dzg5L21hYy5jDQo+ID4gQEAgLTAsMCArMSw0MDcwIEBADQoNClsuLi5dDQoNCj4gPiAr
dTE2IHJ0dzg5X21hY19nZXRfcGx0KHN0cnVjdCBydHc4OV9kZXYgKnJ0d2RldiwgdTggYmFuZCkN
Cj4gPiArew0KPiA+ICsJdTMyIHJlZzsNCj4gPiArCXUxNiBjbnQ7DQo+ID4gKw0KPiA+ICsJcmVn
ID0gcnR3ODlfbWFjX3JlZ19ieV9pZHgoUl9BWF9CVF9QTFQsIGJhbmQpOw0KPiA+ICsJY250ID0g
cnR3ODlfcmVhZDMyX21hc2socnR3ZGV2LCByZWcsIEJfQVhfQlRfUExUX1BLVF9DTlRfTUFTSyk7
DQo+ID4gKwlydHc4OV93cml0ZTE2X3NldChydHdkZXYsIHJlZywgQl9BWF9CVF9QTFRfUlNUKTsN
Cj4gPiArDQo+ID4gKwlyZXR1cm4gY250Ow0KPiA+ICt9DQo+IA0KPiBUaGlzIGZ1bmN0aW9uIGlz
IG5vdCB1c2VkLCBwbGVhc2UgcmVtb3ZlLg0KPiANCg0KT0suIFdpbGwgcmVtb3ZlIGl0Lg0KDQpb
Li4uXQ0KDQpJZiBJIG1pc3MgYW55IGNvbW1lbnQsIHBsZWFzZSBsZXQgbWUga25vdy4NCg0KLS0N
ClBpbmctS2UNCg0K
