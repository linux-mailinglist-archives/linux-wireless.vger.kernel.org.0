Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDA843B2526
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Jun 2021 04:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbhFXCnz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Jun 2021 22:43:55 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:54457 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbhFXCnx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Jun 2021 22:43:53 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 15O2fSZC1013641, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36502.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 15O2fSZC1013641
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 24 Jun 2021 10:41:28 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36502.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 24 Jun 2021 10:41:27 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 24 Jun 2021 10:41:27 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::a0a3:e64a:34ad:fe28]) by
 RTEXMBS04.realtek.com.tw ([fe80::a0a3:e64a:34ad:fe28%5]) with mapi id
 15.01.2106.013; Thu, 24 Jun 2021 10:41:27 +0800
From:   Pkshih <pkshih@realtek.com>
To:     Kalle Valo <kvalo@codeaurora.org>
CC:     "tony0620emma@gmail.com" <tony0620emma@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Bernie Huang" <phhuang@realtek.com>
Subject: RE: [PATCH] rtw88: fix c2h memory leak
Thread-Topic: [PATCH] rtw88: fix c2h memory leak
Thread-Index: AQHXZoh7C0b/dkelIUGEHl3zoMjlP6shXHEAgAEbLNA=
Date:   Thu, 24 Jun 2021 02:41:27 +0000
Message-ID: <268f7949e5944eb7aeadbd6d179a3130@realtek.com>
References: <20210621103023.41928-1-pkshih@realtek.com>
 <20210623174718.ABFCEC43460@smtp.codeaurora.org>
In-Reply-To: <20210623174718.ABFCEC43460@smtp.codeaurora.org>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.146]
x-kse-serverinfo: RTEXMBS04.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIxLzYvMjMg5LiL5Y2IIDEwOjU1OjAw?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36502.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 06/24/2021 02:27:48
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 164592 [Jun 23 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: pkshih@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 448 448 71fb1b37213ce9a885768d4012c46ac449c77b17
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: 127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;realtek.com:7.1.1
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 06/24/2021 02:30:00
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IGt2YWxvPWNvZGVhdXJvcmEu
b3JnQG1nLmNvZGVhdXJvcmEub3JnIFttYWlsdG86a3ZhbG89Y29kZWF1cm9yYS5vcmdAbWcuY29k
ZWF1cm9yYS5vcmddIE9uDQo+IEJlaGFsZiBPZiBLYWxsZSBWYWxvDQo+IFNlbnQ6IFRodXJzZGF5
LCBKdW5lIDI0LCAyMDIxIDE6NDcgQU0NCj4gVG86IFBrc2hpaA0KPiBDYzogdG9ueTA2MjBlbW1h
QGdtYWlsLmNvbTsgbGludXgtd2lyZWxlc3NAdmdlci5rZXJuZWwub3JnOyBCZXJuaWUgSHVhbmcN
Cj4gU3ViamVjdDogUmU6IFtQQVRDSF0gcnR3ODg6IGZpeCBjMmggbWVtb3J5IGxlYWsNCj4gDQo+
IFBpbmctS2UgU2hpaCA8cGtzaGloQHJlYWx0ZWsuY29tPiB3cm90ZToNCj4gDQo+ID4gRnJvbTog
UG8tSGFvIEh1YW5nIDxwaGh1YW5nQHJlYWx0ZWsuY29tPg0KPiA+DQo+ID4gRml4IGVycm9uZW91
cyBjb2RlIHRoYXQgbGVhZHMgdG8gdW5yZWZlcmVuY2VkIG9iamVjdHMuIER1cmluZyBIMkMNCj4g
PiBvcGVyYXRpb25zLCBzb21lIGZ1bmN0aW9ucyByZXR1cm5lZCB3aXRob3V0IGZyZWVpbmcgdGhl
IG1lbW9yeSB0aGF0IG9ubHkNCj4gPiB0aGUgZnVuY3Rpb24gaGF2ZSBhY2Nlc3MgdG8uIFJlbGVh
c2UgdGhlc2Ugb2JqZWN0cyB3aGVuIHRoZXkncmUgbm8gbG9uZ2VyDQo+ID4gbmVlZGVkIHRvIGF2
b2lkIHBvdGVudGlhbGx5IG1lbW9yeSBsZWFrcy4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFBv
LUhhbyBIdWFuZyA8cGhodWFuZ0ByZWFsdGVrLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBQaW5n
LUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT4NCj4gDQo+IEZhaWxlZCB0byBhcHBseSwgcGxl
YXNlIHJlYmFzZToNCj4gDQo+IFJlY29yZGVkIHByZWltYWdlIGZvciAnZHJpdmVycy9uZXQvd2ly
ZWxlc3MvcmVhbHRlay9ydHc4OC9jb2V4LmMnDQo+IGVycm9yOiBGYWlsZWQgdG8gbWVyZ2UgaW4g
dGhlIGNoYW5nZXMuDQo+IGhpbnQ6IFVzZSAnZ2l0IGFtIC0tc2hvdy1jdXJyZW50LXBhdGNoJyB0
byBzZWUgdGhlIGZhaWxlZCBwYXRjaA0KPiBBcHBseWluZzogcnR3ODg6IGZpeCBjMmggbWVtb3J5
IGxlYWsNCj4gVXNpbmcgaW5kZXggaW5mbyB0byByZWNvbnN0cnVjdCBhIGJhc2UgdHJlZS4uLg0K
PiBNCWRyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODgvY29leC5jDQo+IE0JZHJpdmVy
cy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OC9mdy5jDQo+IE0JZHJpdmVycy9uZXQvd2lyZWxl
c3MvcmVhbHRlay9ydHc4OC9tYWluLmMNCj4gRmFsbGluZyBiYWNrIHRvIHBhdGNoaW5nIGJhc2Ug
YW5kIDMtd2F5IG1lcmdlLi4uDQo+IEF1dG8tbWVyZ2luZyBkcml2ZXJzL25ldC93aXJlbGVzcy9y
ZWFsdGVrL3J0dzg4L21haW4uYw0KPiBBdXRvLW1lcmdpbmcgZHJpdmVycy9uZXQvd2lyZWxlc3Mv
cmVhbHRlay9ydHc4OC9mdy5jDQo+IEF1dG8tbWVyZ2luZyBkcml2ZXJzL25ldC93aXJlbGVzcy9y
ZWFsdGVrL3J0dzg4L2NvZXguYw0KPiBDT05GTElDVCAoY29udGVudCk6IE1lcmdlIGNvbmZsaWN0
IGluIGRyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODgvY29leC5jDQo+IFBhdGNoIGZh
aWxlZCBhdCAwMDAxIHJ0dzg4OiBmaXggYzJoIG1lbW9yeSBsZWFrDQo+IA0KPiBQYXRjaCBzZXQg
dG8gQ2hhbmdlcyBSZXF1ZXN0ZWQuDQo+IA0KDQp2MiBpcyBzZW50Lg0KVGhhbmsgeW91DQotLQ0K
UGluZy1LZQ0KDQo=
