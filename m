Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA5363ED0B1
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Aug 2021 10:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235083AbhHPI5T (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 16 Aug 2021 04:57:19 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:37594 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234701AbhHPI5S (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 16 Aug 2021 04:57:18 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 17G8uhwyF027402, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36502.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 17G8uhwyF027402
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 16 Aug 2021 16:56:43 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36502.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 16 Aug 2021 16:56:42 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 16 Aug 2021 16:56:42 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::cdd5:82a3:e854:7098]) by
 RTEXMBS04.realtek.com.tw ([fe80::cdd5:82a3:e854:7098%5]) with mapi id
 15.01.2106.013; Mon, 16 Aug 2021 16:56:42 +0800
From:   Pkshih <pkshih@realtek.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        Steven Ting <steventing@realtek.com>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Gary Chang" <gary.chang@realtek.com>
Subject: RE: Is the extra_tx_headroom guarenteed ?
Thread-Topic: Is the extra_tx_headroom guarenteed ?
Thread-Index: AddbSjppmAX3DQgITcSrSZZ1Rzj0gwC6wIs2DQJQB/A=
Date:   Mon, 16 Aug 2021 08:56:42 +0000
Message-ID: <4c79f4cfc8ad453c9ee24e71fbbc6321@realtek.com>
References: <f045bc11c75e4603bf58f3d596448c7e@realtek.com>
         (sfid-20210607_051714_758886_6CCCA7F4)
 <e787fefd695aed489f30978a9e950d9a7390a7b1.camel@sipsolutions.net>
In-Reply-To: <e787fefd695aed489f30978a9e950d9a7390a7b1.camel@sipsolutions.net>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.146]
x-kse-serverinfo: RTEXMBS01.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIxLzgvMTYg5LiK5Y2IIDAzOjA2OjAw?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36502.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 08/16/2021 06:59:56
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 165566 [Aug 16 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: pkshih@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 454 454 39c6e442fd417993330528e7f9d13ac1bf7fdf8c
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 08/16/2021 07:03:00
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEpvaGFubmVzIEJlcmcgW21h
aWx0bzpqb2hhbm5lc0BzaXBzb2x1dGlvbnMubmV0XQ0KPiBTZW50OiBGcmlkYXksIEp1bmUgMTEs
IDIwMjEgNDoxNCBBTQ0KPiBUbzogU3RldmVuIFRpbmcNCj4gQ2M6IGxpbnV4LXdpcmVsZXNzQHZn
ZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogSXMgdGhlIGV4dHJhX3R4X2hlYWRyb29tIGd1
YXJlbnRlZWQgPw0KPiANCj4gSGksDQo+IA0KPiA+IFdlIGVuY291bnRlcmVkIGEgcHJvYmxlbSB0
aGF0IHdlIHVzZSB0aGUgZXh0cmFfdHhfaGVhZHJvb20gdG8gcmVzZXJ2ZSB0aGUgaGVhZHJvb20N
Cj4gPiB3aGljaCB3ZSBwdXQgdGhlIHR4ZGVzYyBpbi4NCj4gPg0KPiA+IEN1cnJlbnQgd29ya2Fy
b3VuZCBpcyB0aGF0IHdlIGNoZWNrIG91ciBuZWVkZWQgaGVhZHJvb20gc2l6ZSBieSBza2JfaGVh
ZHJvb20oKQ0KPiA+IGluIHRoZSBkcml2ZXIgbGF5ZXIuDQo+ID4NCj4gPiBJcyBleHRyYV90eF9o
ZWFkcm9vbSBpbiBzdHJ1Y3QgaWVlZTgwMjExX2h3IGFsd2F5cyBndWFyYW50ZWVkPw0KPiANCj4g
SXQgX3Nob3VsZF8gYmUsIElNSE8uIEhhdmluZyB0aGUgY2hlY2sgaW4gYWxsIHRoZSBkcml2ZXJz
IHdvdWxkIGJlDQo+IHBvaW50bGVzcy4NCj4gDQo+ID4gVGhlIGhlYWRlciBmaWxlIGRlc2NyaWJl
czoNCj4gPiAqIEBleHRyYV90eF9oZWFkcm9vbTogaGVhZHJvb20gdG8gcmVzZXJ2ZSBpbiBlYWNo
IHRyYW5zbWl0IHNrYg0KPiA+ICogICAgICBmb3IgdXNlIGJ5IHRoZSBkcml2ZXIgKGUuZy4gZm9y
IHRyYW5zbWl0IGhlYWRlcnMuKQ0KPiA+DQo+ID4gQnV0IHdoZW4gdGhlIHNrYiBnb2VzIHRocm91
Z2ggdGhlIGllZWU4MDIxMV9hbXNkdV9yZWFsbG9jX3BhZCgpLCBpdCBkb2VzIG5vdA0KPiA+IHRh
a2UgY2FyZSBvZiB0aGUgZXh0cmFfdHhfaGVhZHJvb20sIGkuZS4gdGhlIG9yaWdpbmFsIHJlc2Vy
dmVkIGhlYWRyb29tIG1pZ2h0IGJlDQo+ID4gZWF0ZW4uDQo+IA0KPiBPSywgc28gSSBndWVzcyB0
aGF0J3MgYSBidWcgdGhlcmUuDQo+IA0KPiA+IERvZXMgdGhlIGllZWU4MDIxMV9hbXNkdV9yZWFs
bG9jX3BhZCgpIGxhY2tzIHNvbWUgY2hlY2sgZm9yIGV4dHJhX3R4X2hlYWRyb29tDQo+ID4gb3Ig
dGhlIGV4dHJhX3R4X2hlYWRyb29tIGluIG1hYzgwMjExIGlzIG5vdCBndWFyYW50ZWVkPw0KPiAN
Cj4gSSB3b3VsZCBzYXkgaXQgbGFja3MgdGhlIGNoZWNrcyAtIHdhbnQgdG8gc2VuZCBhIHBhdGNo
Pw0KPiANCj4gPiBGdXJ0aGVybW9yZSwgZm9yIHRoZSBwYWNrZXQgdGhhdCB3b3VsZCBub3QgYmUg
YWdncmVnYXRlIGluIEEtTVNEVSBhbmQgbmRldi0+bmVlZGVkX2hlYWRyb29tDQo+ID4gaXMgbm90
IGd1YXJhbnRlZWQsIGluIHRoaXMgY2FzZSB3aGV0aGVyIG1hYzgwMjExIGxheWVyIHN0aWxsIGd1
YXJhbnRlZSB0aGUgZXh0cmFfdHhfaGVhZHJvb20gPw0KPiANCj4gWWVzLCB0aGlzIGNhc2Ugc2hv
dWxkIGJlIGhhbmRsZWQuDQo+IA0KDQpXZSBwcmVwYXJlIGEgcGF0Y2hzZXQgWzFdIHRvIGZpeCB0
aGUgYnVnIG1lbnRpb25lZCBpbiB0aGlzIG1haWwuDQoNClsxXSBodHRwczovL2xvcmUua2VybmVs
Lm9yZy9saW51eC13aXJlbGVzcy8yMDIxMDgxNjA4NTEyOC4xMDkzMS0xLXBrc2hpaEByZWFsdGVr
LmNvbS9ULyN0DQoNCi0tDQpQaW5nLUtlDQoNCg==
