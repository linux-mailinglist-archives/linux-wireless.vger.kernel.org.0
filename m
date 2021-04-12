Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 814CD35BBCB
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Apr 2021 10:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237256AbhDLILe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 12 Apr 2021 04:11:34 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:39439 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237081AbhDLILe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 12 Apr 2021 04:11:34 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 13C8BAP60024916, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36502.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 13C8BAP60024916
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 12 Apr 2021 16:11:10 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36502.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 12 Apr 2021 16:11:10 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 12 Apr 2021 16:11:09 +0800
Received: from RTEXMBS04.realtek.com.tw ([::1]) by RTEXMBS04.realtek.com.tw
 ([fe80::6c03:c55:df50:5209%5]) with mapi id 15.01.2106.013; Mon, 12 Apr 2021
 16:11:09 +0800
From:   Pkshih <pkshih@realtek.com>
To:     Kalle Valo <kvalo@codeaurora.org>
CC:     "tony0620emma@gmail.com" <tony0620emma@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        DeanKu <ku920601@realtek.com>,
        Bernie Huang <phhuang@realtek.com>,
        Shaofu <shaofu@realtek.com>,
        Steven Ting <steventing@realtek.com>,
        Kevin Yang <kevin_yang@realtek.com>
Subject: RE: [PATCH 6/7] rtw88: 8822c: add CFO tracking
Thread-Topic: [PATCH 6/7] rtw88: 8822c: add CFO tracking
Thread-Index: AQHXHILi0rb6HTLCKkSAH1awbttUrqquqISAgAGc+iA=
Date:   Mon, 12 Apr 2021 08:11:09 +0000
Message-ID: <6ea1eb17f2a64fd0954b9d4060da12f0@realtek.com>
References: <20210319054218.3319-7-pkshih@realtek.com>
 <20210411091951.2B01AC433CA@smtp.codeaurora.org>
In-Reply-To: <20210411091951.2B01AC433CA@smtp.codeaurora.org>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.146]
x-kse-serverinfo: RTEXMBS04.realtek.com.tw, 9
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIxLzQvMTIg5LiK5Y2IIDAxOjEyOjAw?=
x-kse-attachment-filter-triggered-rules: Clean
x-kse-attachment-filter-triggered-filters: Clean
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 04/12/2021 07:24:49
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 163016 [Apr 11 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: pkshih@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 442 442 b985cb57763b61d2a20abb585d5d4cc10c315b09
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;realtek.com:7.1.1
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 04/12/2021 07:28:00
X-KSE-ServerInfo: RTEXH36502.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 04/12/2021 07:46:58
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 163018 [Apr 12 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: pkshih@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 442 442 b985cb57763b61d2a20abb585d5d4cc10c315b09
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
X-KSE-Antiphishing-Bases: 04/12/2021 07:50:00
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IGt2YWxvPWNvZGVhdXJvcmEu
b3JnQG1nLmNvZGVhdXJvcmEub3JnIFttYWlsdG86a3ZhbG89Y29kZWF1cm9yYS5vcmdAbWcuY29k
ZWF1cm9yYS5vcmddIE9uDQo+IEJlaGFsZiBPZiBLYWxsZSBWYWxvDQo+IFNlbnQ6IFN1bmRheSwg
QXByaWwgMTEsIDIwMjEgNToyMCBQTQ0KPiBUbzogUGtzaGloDQo+IENjOiB0b255MDYyMGVtbWFA
Z21haWwuY29tOyBsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmc7IERlYW5LdTsgQmVybmll
IEh1YW5nOyBTaGFvZnU7IFN0ZXZlbiBUaW5nOw0KPiBLZXZpbiBZYW5nDQo+IFN1YmplY3Q6IFJl
OiBbUEFUQ0ggNi83XSBydHc4ODogODgyMmM6IGFkZCBDRk8gdHJhY2tpbmcNCj4gDQo+IFBpbmct
S2UgU2hpaCA8cGtzaGloQHJlYWx0ZWsuY29tPiB3cm90ZToNCj4gDQo+ID4gRnJvbTogUG8tSGFv
IEh1YW5nIDxwaGh1YW5nQHJlYWx0ZWsuY29tPg0KPiA+DQo+ID4gQWRkIENGTyB0cmFja2luZyBt
ZWNoYW5pc20gdG8gbWl0aWdhdGUgdGhlIGVmZmVjdCBvZiBvc2NpbGxhdG9yDQo+ID4gZnJlcXVl
bmN5IGRpc2NyZXBhbmN5Lg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogUG8tSGFvIEh1YW5nIDxw
aGh1YW5nQHJlYWx0ZWsuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFBpbmctS2UgU2hpaCA8cGtz
aGloQHJlYWx0ZWsuY29tPg0KPiANCj4gV2hhdCdzIENGTz8gSSBuZWVkIHRvIHVuZGVyc3RhbmQg
dGhlIGNvbW1pdCBsb2csIHNvIHBsZWFzZSB3cml0ZSBpdCBzbyB0aGF0IGFueQ0KPiBlbmdpbmVl
ciB3b3JraW5nIHdpdGggd2lyZWxlc3MgdW5kZXJzdGFuZHMgaXQuDQo+IA0KDQpDRk8gdHJhY2tp
bmcsIHdoaWNoIHN0YW5kcyBmb3IgY2VudHJhbCBmcmVxdWVuY3kgb2Zmc2V0IHRyYWNraW5nLCBp
cyB1c2VkIHRvDQphZGp1c3Qgb3NjaWxsYXRvciB0byBhbGlnbiBjZW50cmFsIGZyZXF1ZW5jeSBv
ZiBjb25uZWN0ZWQgQVAuIFRoZW4sIHdlIGNhbg0KaGF2ZSBiZXR0ZXIgcGVyZm9ybWFuY2UuDQoN
ClNob3VsZCBJIHJlc2VuZCB0aGlzIHBhdGNoIHRvIGV4cGxhaW4gQ0ZPPw0KDQotLQ0KUGluZy1L
ZQ0KDQoNCg==
