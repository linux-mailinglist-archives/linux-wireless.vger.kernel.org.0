Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C54345F7BE
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Nov 2021 02:00:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242503AbhK0BDZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Nov 2021 20:03:25 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:42324 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344304AbhK0BBY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Nov 2021 20:01:24 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 1AR0w3oA5018140, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36503.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 1AR0w3oA5018140
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sat, 27 Nov 2021 08:58:03 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36503.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sat, 27 Nov 2021 08:58:03 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sat, 27 Nov 2021 08:58:02 +0800
Received: from RTEXDAG02.realtek.com.tw ([fe80::b4ec:3ff6:125f:9d2d]) by
 RTEXDAG02.realtek.com.tw ([fe80::b4ec:3ff6:125f:9d2d%7]) with mapi id
 15.01.2308.020; Sat, 27 Nov 2021 08:58:02 +0800
From:   Pkshih <pkshih@realtek.com>
To:     "kvalo@codeaurora.org" <kvalo@codeaurora.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Bernie Huang" <phhuang@realtek.com>
Subject: Re: [PATCH 1/2] rtw89: update scan_mac_addr during scanning period
Thread-Topic: [PATCH 1/2] rtw89: update scan_mac_addr during scanning period
Thread-Index: AQHX1qUXmOkfVzSwQU6gpEJ2+wUplawVjXgAgACSroA=
Date:   Sat, 27 Nov 2021 00:58:02 +0000
Message-ID: <2021378f787172b58115f6b12973e5a20af6fce0.camel@realtek.com>
References: <20211111023706.14154-2-pkshih@realtek.com>
         <163794315660.10370.15822860839880748383.kvalo@codeaurora.org>
In-Reply-To: <163794315660.10370.15822860839880748383.kvalo@codeaurora.org>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.1-2 
x-originating-ip: [125.224.69.196]
x-kse-serverinfo: RTEXDAG02.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIxLzExLzI2IOS4i+WNiCAxMDowMDowMA==?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="utf-8"
Content-ID: <80E0B4A1DC779048BB292955B47AC7CF@realtek.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36503.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gRnJpLCAyMDIxLTExLTI2IGF0IDE2OjEyICswMDAwLCBLYWxsZSBWYWxvIHdyb3RlOg0KPiBQ
aW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT4gd3JvdGU6DQo+IA0KPiA+IFVwZGF0ZSBz
Y2FuX21hY19hZGRyIHRvIGFkZHJlc3MgQ0FNIGFzIEExLCBzbyBoYXJkd2FyZSBjYW4gQUNLIHBy
b2JlDQo+ID4gcmVzcG9uc2UgcHJvcGVybHkuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogUGlu
Zy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+DQo+IA0KPiBGYWlsZWQgdG8gYXBwbHkgdG8g
d2lyZWxlc3MtZHJpdmVycy1uZXh0LCBwbGVhc2UgcmVzcGluLg0KPiANCj4gZXJyb3I6IHNoYTEg
aW5mb3JtYXRpb24gaXMgbGFja2luZyBvciB1c2VsZXNzIChkcml2ZXJzL25ldC93aXJlbGVzcy9y
ZWFsdGVrL3J0dzg5L3R4cnguaCkuDQo+IGVycm9yOiBjb3VsZCBub3QgYnVpbGQgZmFrZSBhbmNl
c3Rvcg0KPiBoaW50OiBVc2UgJ2dpdCBhbSAtLXNob3ctY3VycmVudC1wYXRjaCcgdG8gc2VlIHRo
ZSBmYWlsZWQgcGF0Y2gNCj4gQXBwbHlpbmc6IHJ0dzg5OiBmaXggaW5jb3JyZWN0IGNoYW5uZWwg
aW5mbyBkdXJpbmcgc2Nhbg0KPiBQYXRjaCBmYWlsZWQgYXQgMDAwMSBydHc4OTogZml4IGluY29y
cmVjdCBjaGFubmVsIGluZm8gZHVyaW5nIHNjYW4NCj4gDQo+IDIgcGF0Y2hlcyBzZXQgdG8gQ2hh
bmdlcyBSZXF1ZXN0ZWQuDQo+IA0KPiAxMjYxMzk1NyBbMS8yXSBydHc4OTogdXBkYXRlIHNjYW5f
bWFjX2FkZHIgZHVyaW5nIHNjYW5uaW5nIHBlcmlvZA0KPiAxMjYxMzk1OSBbMi8yXSBydHc4OTog
Zml4IGluY29ycmVjdCBjaGFubmVsIGluZm8gZHVyaW5nIHNjYW4NCj4gDQoNClRoaXMgcGF0Y2hz
ZXQgaXMgYmFzZWQgb24gdGhlIHRoZSAyIHBhdGNoZXMgb2YgYW5vdGhlciBwYXRjaHNldA0Kd2hv
c2Ugc3RhdHVzIGlzIEF3YWl0aW5nIFVwc3RyZWFtOg0KDQoxMjYyODIwOSBbdjMsMi8zXSBydHc4
OTogYWRkIGNvbnN0IGluIHRoZSBjYXN0IG9mIGxlMzJfZ2V0X2JpdHMoKQ0KMTI2MjgyMTEgW3Yz
LDMvM10gcnR3ODk6IHVzZSBpbmxpbmUgZnVuY3Rpb24gaW5zdGVhZCBtYWNybyB0byBzZXQgSDJD
IGFuZCBDQU0NCg0KSWYgSSBkbyByZWJhc2Ugb24gdGhpcyBwYXRjaHNldCBhbmQgZ2V0IG1lcmdl
ZCwgdGhlIGF3YWl0aW5nIHBhdGNoc2V0DQpjb3VsZCBiZSBjb25mbGljdC4gU2hvdWxkIEkgd2Fp
dCB0aGUgYXdhaXRpbmcgcGF0Y2hzZXQgZ2V0IG1lcmdlZD8NCg0KUGxlYXNlIGd1aWRlIG1lIHRo
ZSB3YXkgdG8gZGVhbCB3aXRoIHRoaXMuDQpTb3JyeSBmb3IgdGhlIGluY29udmVuaWVuY2UuDQoN
Ci0tDQpQaW5nLUtlDQoNCg==
