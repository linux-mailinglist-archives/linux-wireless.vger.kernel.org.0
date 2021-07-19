Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 232183CCC5A
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Jul 2021 04:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234255AbhGSCrJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 18 Jul 2021 22:47:09 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:41080 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233720AbhGSCrI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 18 Jul 2021 22:47:08 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 16J2i2Yy9017109, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36502.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 16J2i2Yy9017109
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 19 Jul 2021 10:44:02 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36502.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 19 Jul 2021 10:44:01 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 19 Jul 2021 10:44:00 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::5bd:6f71:b434:7c91]) by
 RTEXMBS04.realtek.com.tw ([fe80::5bd:6f71:b434:7c91%5]) with mapi id
 15.01.2106.013; Mon, 19 Jul 2021 10:44:00 +0800
From:   Pkshih <pkshih@realtek.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        linux-wireless <linux-wireless@vger.kernel.org>
Subject: RE: Difficulty connecting to AP using rtw89
Thread-Topic: Difficulty connecting to AP using rtw89
Thread-Index: AQHXedzEvSHwSXSC2EGxNTyUmGxj/atE4CcwgABoiACAARvNsIAAARaAgAM0tpA=
Date:   Mon, 19 Jul 2021 02:44:00 +0000
Message-ID: <2551f3d4aff248e29118a2c6339e4d96@realtek.com>
References: <f2ee1dbd-28b5-a1e6-8f41-e7ed8dfc2521@lwfinger.net>
 <d74a6a489b2f466eb66df3f5f965a1fa@realtek.com>
 <28f2a476-b690-24dd-df7e-f88f45b9292d@lwfinger.net>
 <04a1e9643c09406697b48f5f781a3e2d@realtek.com>
 <5d598377-e587-f9f0-8d88-97ba8449dcee@lwfinger.net>
In-Reply-To: <5d598377-e587-f9f0-8d88-97ba8449dcee@lwfinger.net>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.146]
x-kse-serverinfo: RTEXDAG01.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIxLzcvMTkg5LiK5Y2IIDAxOjA2OjAw?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36502.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 07/19/2021 02:21:55
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 165067 [Jul 18 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: pkshih@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 448 448 71fb1b37213ce9a885768d4012c46ac449c77b17
X-KSE-AntiSpam-Info: {Tracking_from_exist}
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: realtek.com:7.1.1;github.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 07/19/2021 02:24:00
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IExhcnJ5IEZpbmdlciBbbWFp
bHRvOmxhcnJ5LmZpbmdlckBnbWFpbC5jb21dIE9uIEJlaGFsZiBPZiBMYXJyeSBGaW5nZXINCj4g
U2VudDogU2F0dXJkYXksIEp1bHkgMTcsIDIwMjEgNTo0MCBQTQ0KPiBUbzogUGtzaGloOyBsaW51
eC13aXJlbGVzcw0KPiBTdWJqZWN0OiBSZTogRGlmZmljdWx0eSBjb25uZWN0aW5nIHRvIEFQIHVz
aW5nIHJ0dzg5DQo+IA0KPiBPbiA3LzE2LzIxIDg6NDAgUE0sIFBrc2hpaCB3cm90ZToNCj4gPg0K
PiA+DQo+ID4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+IEZyb206IExhcnJ5IEZp
bmdlciBbbWFpbHRvOmxhcnJ5LmZpbmdlckBnbWFpbC5jb21dIE9uIEJlaGFsZiBPZiBMYXJyeSBG
aW5nZXINCj4gPj4gSW4gYSBzZXBhcmF0ZSBxdWVzdGlvbiwgd2lsbCB2NiBoYXZlIHByb3Zpc2lv
bnMgZm9yIElQdjY/DQo+ID4+DQo+ID4NCj4gPiBUaGUgZHJpdmVyIGhhbmRsZXMgTDIgdGhpbmdz
IG9ubHksIGJ1dCBJUHY2IHRoYXQgaXMgTDMgdGhhdCB3ZSBkb24ndCBoYXZlIHNwZWNpYWwgZGVh
bC4NCj4gPiBDb3VsZCBJIGtub3cgdGhlIHByb2JsZW0geW91IG1ldD8NCj4gDQo+IFBlcnNvbmFs
bHksIEkgZG8gbm90IHVzZSBJUHY2LCBidXQgb25lIG9mIHRoZSB1c2Vycw0KPiAoaHR0cHM6Ly9n
aXRodWIuY29tL2x3ZmluZ2VyL3J0dzg5L2lzc3Vlcy8xOSkgaGFzIGJhZCBJUHY0IHRocm91Z2hw
dXQgd2l0aCBoaXMNCj4gSVNQLCBidXQgYmV0dGVyIHdpdGggSVB2Ni4gVGhhdCBkb2Vzbid0IG1h
a2UgYW55IHNlbnNlIHRvIG1lLCBidXQgSSB0b2xkIGhpbQ0KPiB0aGF0IEkgd291bGQgYXNrLg0K
DQpJJ20gbm90IHN1cmUgaWYgSVNQIGxpbWl0cyB0aGUgdGhyb3VnaHB1dCBvciBub3QuDQpNeSBz
dWdnZXN0aW9uIGlzIHRvIGhhdmUgYW5vdGhlciBQQyBjb25uZWN0ZWQgdG8gQVAgd2l0aCBldGhl
cm5ldCBjYWJsZS4gVGhlbiwNCmRvIHBlcmZvcm1hbmNlIHRlc3QgYmV0d2VlbiB0d28gUENzIHRv
IGNoZWNrIHRoZSBkaWZmZXJlbmNlIGJldHdlZW4gSVB2NCBhbmQgSVB2Ni4NCg0KLS0NClBpbmct
S2UNCg0K
