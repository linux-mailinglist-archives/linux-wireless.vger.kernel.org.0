Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73060443DEF
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Nov 2021 09:02:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbhKCIEe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 3 Nov 2021 04:04:34 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:37952 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231151AbhKCIEV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 3 Nov 2021 04:04:21 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 1A381Q7K0027232, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36503.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 1A381Q7K0027232
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 3 Nov 2021 16:01:26 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36503.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Wed, 3 Nov 2021 16:01:25 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 3 Nov 2021 01:01:24 -0700
Received: from RTEXMBS04.realtek.com.tw ([fe80::dc53:1026:298b:c584]) by
 RTEXMBS04.realtek.com.tw ([fe80::dc53:1026:298b:c584%5]) with mapi id
 15.01.2308.015; Wed, 3 Nov 2021 16:01:24 +0800
From:   Pkshih <pkshih@realtek.com>
To:     Bogdan Nicolae <bogdan.nicolae@acm.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: No support for Realtek 8821CE RFE Type 6
Thread-Topic: No support for Realtek 8821CE RFE Type 6
Thread-Index: AQHXy7lkSRIUIcq7CEaFpFpEp9A8RqvxU6VAgAAlr2A=
Date:   Wed, 3 Nov 2021 08:01:24 +0000
Message-ID: <46a80ab50f594ec1af1016ca272e82fd@realtek.com>
References: <CA+ORkNR97EvqPzHu-CoJXwKGH-HQ4B++57RE88MEF-mG=D=Jeg@mail.gmail.com> 
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXDAG01.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIxLzExLzMg5LiK5Y2IIDA2OjA3OjAw?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36503.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 11/03/2021 07:43:20
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 167068 [Nov 03 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: pkshih@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 465 465 eb31509370142567679dd183ac984a0cb2ee3296
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: realtek.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 11/03/2021 07:46:00
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFBrc2hpaA0KPiBTZW50OiBX
ZWRuZXNkYXksIE5vdmVtYmVyIDMsIDIwMjEgMTo0NSBQTQ0KPiBUbzogJ0JvZ2RhbiBOaWNvbGFl
JyA8Ym9nZGFuLm5pY29sYWVAYWNtLm9yZz47IGxpbnV4LXdpcmVsZXNzQHZnZXIua2VybmVsLm9y
Zw0KPiBTdWJqZWN0OiBSRTogTm8gc3VwcG9ydCBmb3IgUmVhbHRlayA4ODIxQ0UgUkZFIFR5cGUg
Ng0KPiANCj4gDQo+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiBGcm9tOiBCb2dk
YW4gTmljb2xhZSA8Ym9nZGFuLm5pY29sYWVAYWNtLm9yZz4NCj4gPiBTZW50OiBUaHVyc2RheSwg
T2N0b2JlciAyOCwgMjAyMSAxOjA1IFBNDQo+ID4gVG86IGxpbnV4LXdpcmVsZXNzQHZnZXIua2Vy
bmVsLm9yZw0KPiA+IFN1YmplY3Q6IE5vIHN1cHBvcnQgZm9yIFJlYWx0ZWsgODgyMUNFIFJGRSBU
eXBlIDYNCj4gPg0KPiA+IEFsbCwNCj4gPg0KPiA+IFRoZSBjaGlwc2V0IGluIHF1ZXN0aW9uIGlz
IFJlYWx0ZWsgV2lmaSA4ODIxQ0UgUkZFIFR5cGUgNi4gU3VwcG9ydCBpcw0KPiA+IG9ubHkgYXZh
aWxhYmxlIHVwIHRvIFR5cGUgNCAoS2VybmVsIDUuMTQuMTQpLiBBcmUgdGhlcmUgYW55IHBsYW5z
IHRvDQo+ID4gcHJvdmlkZSBzdXBwb3J0IGZvciBUeXBlIDY/IElmIHNvLCB3aGVuPw0KPiA+DQo+
IA0KPiBXZSB3aWxsIGFycmFuZ2UgcmVzb3VyY2VzIHRvIHN1cHBvcnQgUkZFIHR5cGUgNi4NCj4g
RVRBIGlzIGFib3V0IDMgbW9udGhzLg0KPiANCg0KSSBjaGVjayBpbnRlcm5hbGx5IHdpdGggdGhp
cyBSRkUgdHlwZSwgYnV0IHdlIGRvbid0IGNsZWFyIHdoaWNoIG5vdGVib29rL2NvbXB1dGVyDQp1
c2VzIHRoaXMgdHlwZS4gQ291bGQgeW91IHNoYXJlIHRoZSBtb2RlbCBuYW1lIG9mIHlvdXIgY29t
cHV0ZXI/DQpPciwgeW91IGJ1eSB0aGUgY2hpcHNldCBzb21ld2hlcmU/DQpPciwgeW91IHdhbnQg
dG8gYnVpbGQgdGhpcyBjaGlwc2V0IGludG8geW91ciBwcm9kdWN0LiANClBsZWFzZSBnaXZlIHVz
IG1vcmUgaW5mb3JtYXRpb24gdG8gbW92ZSBmdXJ0aGVyLg0KDQotLQ0KUGluZy1LZQ0KDQo=
