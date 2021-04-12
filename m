Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6A8135BBCA
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Apr 2021 10:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237177AbhDLILa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 12 Apr 2021 04:11:30 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:39432 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237081AbhDLILa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 12 Apr 2021 04:11:30 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 13C8B6a04024903, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36502.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 13C8B6a04024903
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 12 Apr 2021 16:11:06 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36502.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 12 Apr 2021 16:11:05 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 12 Apr 2021 16:11:05 +0800
Received: from RTEXMBS04.realtek.com.tw ([::1]) by RTEXMBS04.realtek.com.tw
 ([fe80::6c03:c55:df50:5209%5]) with mapi id 15.01.2106.013; Mon, 12 Apr 2021
 16:11:05 +0800
From:   Pkshih <pkshih@realtek.com>
To:     Kalle Valo <kvalo@codeaurora.org>
CC:     "tony0620emma@gmail.com" <tony0620emma@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        DeanKu <ku920601@realtek.com>,
        Bernie Huang <phhuang@realtek.com>,
        Shaofu <shaofu@realtek.com>,
        Steven Ting <steventing@realtek.com>,
        Kevin Yang <kevin_yang@realtek.com>
Subject: RE: [PATCH 2/7] rtw88: follow the AP basic rates for tx mgmt frame
Thread-Topic: [PATCH 2/7] rtw88: follow the AP basic rates for tx mgmt frame
Thread-Index: AQHXHILhha+rxT9tC0u1Umog2SASfaquqNkAgAGcrsA=
Date:   Mon, 12 Apr 2021 08:11:05 +0000
Message-ID: <632d2ab7679145eab8e1f498b9b12ceb@realtek.com>
References: <20210319054218.3319-3-pkshih@realtek.com>
 <20210411092102.40EE7C43461@smtp.codeaurora.org>
In-Reply-To: <20210411092102.40EE7C43461@smtp.codeaurora.org>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.146]
x-kse-serverinfo: RTEXDAG02.realtek.com.tw, 9
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIxLzQvMTIg5LiK5Y2IIDAxOjEyOjAw?=
x-kse-attachment-filter-triggered-rules: Clean
x-kse-attachment-filter-triggered-filters: Clean
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
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
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 04/12/2021 07:50:00
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
X-KSE-AntiSpam-Info: d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;realtek.com:7.1.1;127.0.0.199:7.1.2
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
QXByaWwgMTEsIDIwMjEgNToyMSBQTQ0KPiBUbzogUGtzaGloDQo+IENjOiB0b255MDYyMGVtbWFA
Z21haWwuY29tOyBsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmc7IERlYW5LdTsgQmVybmll
IEh1YW5nOyBTaGFvZnU7IFN0ZXZlbiBUaW5nOw0KPiBLZXZpbiBZYW5nDQo+IFN1YmplY3Q6IFJl
OiBbUEFUQ0ggMi83XSBydHc4ODogZm9sbG93IHRoZSBBUCBiYXNpYyByYXRlcyBmb3IgdHggbWdt
dCBmcmFtZQ0KPiANCj4gUGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+IHdyb3RlOg0K
PiANCj4gPiBGcm9tOiBTaGFvLUZ1IENoZW5nIDxzaGFvZnVAcmVhbHRlay5jb20+DQo+ID4NCj4g
PiBCeSBkZWZhdWx0IHRoZSBkcml2ZXIgdXNlcyB0aGUgMU0gYW5kIDZNIHJhdGUgZm9yIG1hbmFn
ZW1udCBmcmFtZXMNCj4gPiBpbiAyRyBhbmQgNUcgYmFuZHMgcmVzcGVjdGl2ZWx5LiBCdXQgd2hl
biB0aGUgYmFzaWMgcmF0ZXMgaXMgY29uZmlndXJlZA0KPiA+IGZyb20gdGhlIG1hYzgwMjExLCB3
ZSBuZWVkIHRvIHNlbmQgdGhlIG1hbmFnZW1lbnQgZnJhbWVzIGFjY29yZGluZyB0aGUNCj4gPiBi
YXNpYyByYXRlcy4NCj4gPg0KPiA+IFRoaXMgY29tbWl0IG1ha2VzIHRoZSBkcml2ZXIgdXNlIHRo
ZSBsb3dlc3QgYmFzaWMgcmF0ZXMgdG8gc2VuZA0KPiA+IHRoZSBtYW5hZ2VtZW50IGZyYW1lcyBh
bmQgYSBkZWJ1ZnMgZW50cnkgdG8gZW5hYmxlL2Rpc2FibGUgZm9yY2UgdG8gdXNlDQo+ID4gdGhl
IGxvd2VzdCByYXRlIDFNLzZNIGZvciAyLjRHLzVHIGJhbmRzLg0KPiA+DQo+ID4gb2J0YWluIGN1
cnJlbnQgc2V0dGluZw0KPiA+IGNhdCAvc3lzL2tlcm5lbC9kZWJ1Zy9pZWVlODAyMTEvcGh5WC9y
dHc4OC9iYXNpY19yYXRlcw0KPiA+DQo+ID4gZm9yY2UgbG93ZXN0IHJhdGU6DQo+ID4gZWNobyAx
ID4gL3N5cy9rZXJuZWwvZGVidWcvaWVlZTgwMjExL3BoeVgvcnR3ODgvYmFzaWNfcmF0ZXMNCj4g
Pg0KPiA+IFNpZ25lZC1vZmYtYnk6IFNoYW8tRnUgQ2hlbmcgPHNoYW9mdUByZWFsdGVrLmNvbT4N
Cj4gPiBTaWduZWQtb2ZmLWJ5OiBZdS1ZZW4gVGluZyA8c3RldmVudGluZ0ByZWFsdGVrLmNvbT4N
Cj4gPiBTaWduZWQtb2ZmLWJ5OiBQaW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT4NCj4g
DQo+IFdoeSBpcyBhIGRlYnVnZnMgaW50ZXJmYWNlIG5lZWRlZD8NCj4gDQoNCkJ5IGRlZmF1bHQs
IGRyaXZlciBmb2xsb3dzIEFQJ3MgYmFzaWMgcmF0ZXMgdGhhdCBtYXkgYmUgMjRNIGFuZCBhYm92
ZSwgYW5kDQpkb2VzIGFzc29jaWF0aW9uIHdpdGggMjRNIHJhdGUuIElmIEFQIGlzIGZhciBhd2F5
LCBpdCBtYXkgYmUgaGFyZCB0byBjb21tdW5pY2F0ZQ0Kd2l0aCAyNE0gcmF0ZS4gVGhlcmVmb3Jl
LCB3ZSBhZGQgYSBkZWJ1Z2ZzIHRvIGFsbG93IGRyaXZlciB0byBzZW5kIG1hbmFnZW1lbnQNCmZy
YW1lcyB3aXRoIGxvdyByYXRlIDZNIG9yIDFNLg0KDQotLQ0KUGluZy1LZQ0KDQoNCg==
