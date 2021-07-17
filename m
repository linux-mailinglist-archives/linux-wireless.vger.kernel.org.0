Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1343C3CC090
	for <lists+linux-wireless@lfdr.de>; Sat, 17 Jul 2021 03:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238347AbhGQBnx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 16 Jul 2021 21:43:53 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:49901 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232010AbhGQBnx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 16 Jul 2021 21:43:53 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 16H1enyQ7017818, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36502.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 16H1enyQ7017818
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sat, 17 Jul 2021 09:40:49 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36502.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Sat, 17 Jul 2021 09:40:47 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Sat, 17 Jul 2021 09:40:47 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::5bd:6f71:b434:7c91]) by
 RTEXMBS04.realtek.com.tw ([fe80::5bd:6f71:b434:7c91%5]) with mapi id
 15.01.2106.013; Sat, 17 Jul 2021 09:40:47 +0800
From:   Pkshih <pkshih@realtek.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        linux-wireless <linux-wireless@vger.kernel.org>
Subject: RE: Difficulty connecting to AP using rtw89
Thread-Topic: Difficulty connecting to AP using rtw89
Thread-Index: AQHXedzEvSHwSXSC2EGxNTyUmGxj/atE4CcwgABoiACAARvNsA==
Date:   Sat, 17 Jul 2021 01:40:47 +0000
Message-ID: <04a1e9643c09406697b48f5f781a3e2d@realtek.com>
References: <f2ee1dbd-28b5-a1e6-8f41-e7ed8dfc2521@lwfinger.net>
 <d74a6a489b2f466eb66df3f5f965a1fa@realtek.com>
 <28f2a476-b690-24dd-df7e-f88f45b9292d@lwfinger.net>
In-Reply-To: <28f2a476-b690-24dd-df7e-f88f45b9292d@lwfinger.net>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.146]
x-kse-serverinfo: RTEXDAG01.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIxLzcvMTYg5LiL5Y2IIDEwOjAwOjAw?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36502.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 07/17/2021 01:27:44
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 165065 [Jul 17 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: pkshih@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 448 448 71fb1b37213ce9a885768d4012c46ac449c77b17
X-KSE-AntiSpam-Info: {Tracking_from_exist}
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
X-KSE-Antiphishing-Bases: 07/17/2021 01:30:00
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTGFycnkgRmluZ2VyIFtt
YWlsdG86bGFycnkuZmluZ2VyQGdtYWlsLmNvbV0gT24gQmVoYWxmIE9mIExhcnJ5IEZpbmdlcg0K
PiBTZW50OiBTYXR1cmRheSwgSnVseSAxNywgMjAyMSAxMjo0MCBBTQ0KPiBUbzogUGtzaGloOyBs
aW51eC13aXJlbGVzcw0KPiBTdWJqZWN0OiBSZTogRGlmZmljdWx0eSBjb25uZWN0aW5nIHRvIEFQ
IHVzaW5nIHJ0dzg5DQo+IA0KPiBPbiA3LzE1LzIxIDEwOjE3IFBNLCBQa3NoaWggd3JvdGU6DQo+
ID4gSGkgTGFycnksDQo+ID4NCj4gPiBJJ20gbm90IHN1cmUgaWYgdGhlIHByb2JsZW0gdGhlIHVz
ZXJzIG1ldCBpcyByZWxhdGVkIHRvIHNlY3VyaXR5IG9yIG5vdC4NCj4gPiBCdXQsIHdlIGhhdmUg
YSBzb2x1dGlvbiB0byBkZWFsIHdpdGggc2ltaWxhciBzeW1wdG9tLg0KPiA+IFBsZWFzZSBhcHBs
eSBhbmQgdHJ5IGF0dGFjaGVkIHBhdGNoIHRvIHNlZSBpZiBpdCBpcyBoZWxwZnVsLg0KPiANCj4g
UGluZy1rZSwNCj4gDQo+IFR3byBvZiB0aGUgNCB1c2VycyB3aXRoIHRoZSBwcm9ibGVtIGhhdmUg
cmVwb3J0ZWQgYmFjayB0aGF0IHRoZWlyIGRldmljZSBub3cNCj4gd29ya3MuIFRoYW5rcyBmb3Ig
dGhlIHBhdGNoLg0KDQpUaGFua3MgZm9yIHRoZSBoZWxwLg0KDQo+IA0KPiBJbiBhIHNlcGFyYXRl
IHF1ZXN0aW9uLCB3aWxsIHY2IGhhdmUgcHJvdmlzaW9ucyBmb3IgSVB2Nj8NCj4gDQoNClRoZSBk
cml2ZXIgaGFuZGxlcyBMMiB0aGluZ3Mgb25seSwgYnV0IElQdjYgdGhhdCBpcyBMMyB0aGF0IHdl
IGRvbid0IGhhdmUgc3BlY2lhbCBkZWFsLg0KQ291bGQgSSBrbm93IHRoZSBwcm9ibGVtIHlvdSBt
ZXQ/DQoNCi0tDQpQaW5nLUtlDQoNCg0K
