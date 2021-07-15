Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1720F3C967D
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Jul 2021 05:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbhGODg7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 14 Jul 2021 23:36:59 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:43173 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbhGODg6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 14 Jul 2021 23:36:58 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 16F3XmMH2010589, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36502.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 16F3XmMH2010589
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 15 Jul 2021 11:33:48 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36502.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 15 Jul 2021 11:33:47 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 15 Jul 2021 11:33:47 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::5bd:6f71:b434:7c91]) by
 RTEXMBS04.realtek.com.tw ([fe80::5bd:6f71:b434:7c91%5]) with mapi id
 15.01.2106.013; Thu, 15 Jul 2021 11:33:47 +0800
From:   Pkshih <pkshih@realtek.com>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
CC:     "kvalo@codeaurora.org" <kvalo@codeaurora.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH 14/24] rtw89: 8852a: add 8852a RFK files
Thread-Topic: [PATCH 14/24] rtw89: 8852a: add 8852a RFK files
Thread-Index: AQHXZA3j53IKl6o86ku1040hSiQEe6s6hP8AgAQ5MXCABM1gIA==
Date:   Thu, 15 Jul 2021 03:33:47 +0000
Message-ID: <b752f356a4ee482ca21db867dc7254b2@realtek.com>
References: <20210618064625.14131-1-pkshih@realtek.com>
 <20210618064625.14131-15-pkshih@realtek.com>
 <20210709174112.GC2099@pengutronix.de> 
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.146]
x-kse-serverinfo: RTEXMBS05.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIxLzcvMTUg5LiK5Y2IIDEyOjQwOjAw?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36502.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 07/15/2021 03:17:51
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 165043 [Jul 14 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: pkshih@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 448 448 71fb1b37213ce9a885768d4012c46ac449c77b17
X-KSE-AntiSpam-Info: {Tracking_from_exist}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: 127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;realtek.com:7.1.1
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 07/15/2021 03:21:00
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFBrc2hpaA0KPiBTZW50OiBN
b25kYXksIEp1bHkgMTIsIDIwMjEgMjoyNCBQTQ0KPiBUbzogJ09sZWtzaWogUmVtcGVsJw0KPiBD
Yzoga3ZhbG9AY29kZWF1cm9yYS5vcmc7IGxpbnV4LXdpcmVsZXNzQHZnZXIua2VybmVsLm9yZw0K
PiBTdWJqZWN0OiBSRTogW1BBVENIIDE0LzI0XSBydHc4OTogODg1MmE6IGFkZCA4ODUyYSBSRksg
ZmlsZXMNCj4gDQoNClsuLi5dDQoNCj4gDQo+ID4gPiArCXJ0dzg5X2RlYnVnKHJ0d2RldiwgUlRX
ODlfREJHX1RTU0ksICJbVFNTSV0gJXM6IHBoeT0lZFxuIiwNCj4gPiA+ICsJCSAgICBfX2Z1bmNf
XywgcGh5KTsNCj4gPiA+ICsNCj4gPiA+ICsJaWYgKCFydHdkZXYtPmlzX3Rzc2lfbW9kZVtSRl9Q
QVRIX0FdKQ0KPiA+ID4gKwkJcmV0dXJuOw0KPiA+ID4gKwlpZiAoIXJ0d2Rldi0+aXNfdHNzaV9t
b2RlW1JGX1BBVEhfQl0pDQo+ID4gPiArCQlyZXR1cm47DQo+ID4gPiArDQo+ID4gPiArCV90c3Np
X2Rpc2FibGUocnR3ZGV2LCBwaHkpOw0KPiA+ID4gKw0KPiA+ID4gKwlmb3IgKGkgPSBSRl9QQVRI
X0E7IGkgPCBSRl9QQVRIX05VTV84ODUyQTsgaSsrKSB7DQo+ID4gPiArCQlfdHNzaV9yZl9zZXR0
aW5nKHJ0d2RldiwgcGh5LCBpKTsNCj4gPiA+ICsJCV90c3NpX3NldF9zeXMocnR3ZGV2LCBwaHkp
Ow0KPiA+ID4gKwkJX3Rzc2lfc2V0X3RtZXRlcl90YmwocnR3ZGV2LCBwaHksIGkpOw0KPiA+ID4g
KwkJX3Rzc2lfcGFrKHJ0d2RldiwgcGh5LCBpKTsNCj4gPiA+ICsJfQ0KPiA+ID4gKw0KPiA+ID4g
KwlfdHNzaV9lbmFibGUocnR3ZGV2LCBwaHkpOw0KPiA+ID4gKwlfdHNzaV9zZXRfZWZ1c2VfdG9f
ZGUocnR3ZGV2LCBwaHkpOw0KPiA+ID4gK30NCj4gPiA+ICsNCj4gPiA+ICt2b2lkIHJ0dzg4NTJh
X3Rzc2lfdHJhY2soc3RydWN0IHJ0dzg5X2RldiAqcnR3ZGV2KQ0KPiA+ID4gK3sNCj4gPiA+ICsJ
X3Rzc2lfdHJhY2socnR3ZGV2KTsNCj4gPiA+ICt9DQo+ID4NCj4gPiBydHc4ODUyYV90c3NpX3Ry
YWNrKCkgaXMgbm90IHVzZWQNCj4gPg0KPiANCj4gSSdsbCBjaGVjayBUU1NJIG93bmVyLg0KPiBX
aWxsIHJlbW92ZSBpdCBpZiB3ZSBkb24ndCBuZWVkIGl0LCBvciBjYWxsIGl0IGlmIG5lY2Vzc2Fy
eS4NCj4gDQoNCkkgaGF2ZSBjb25maXJtZWQgd2l0aCBUU1NJIG93bmVyOyB3ZSdsbCBjYWxsIGl0
IGZyb20gcnR3ODg1MmFfcmZrX3RyYWNrKCkuDQpUaGFua3MgZm9yIHRoZSBjYXRjaC4NCg0KLS0N
ClBpbmctS2UNCg0K
