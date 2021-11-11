Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3799644D1C2
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Nov 2021 06:52:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbhKKFyM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 11 Nov 2021 00:54:12 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:49777 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbhKKFyM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 11 Nov 2021 00:54:12 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 1AB5pKUw9031011, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 1AB5pKUw9031011
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 11 Nov 2021 13:51:20 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Thu, 11 Nov 2021 13:51:19 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 10 Nov 2021 21:51:18 -0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::dc53:1026:298b:c584]) by
 RTEXMBS04.realtek.com.tw ([fe80::dc53:1026:298b:c584%5]) with mapi id
 15.01.2308.015; Thu, 11 Nov 2021 13:51:18 +0800
From:   Pkshih <pkshih@realtek.com>
To:     Nikolay Stanchev <stanchev.nick@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: rtw89 driver
Thread-Topic: rtw89 driver
Thread-Index: AQHX1iOlv6Bp0qpgk02n56c4Bis5lKv9zGtw
Date:   Thu, 11 Nov 2021 05:51:18 +0000
Message-ID: <16486a1c4ec348318fd35c0d6ca6a454@realtek.com>
References: <CA+=fEQPeogtO9qr2ZYob27aH-nsnfu=eTJ4g3qqU7bfEiV5diw@mail.gmail.com>
 <15846b1b-5cad-796d-b562-1ab31743fd82@gmail.com>
In-Reply-To: <15846b1b-5cad-796d-b562-1ab31743fd82@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXDAG01.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIxLzExLzExIOS4iuWNiCAwNDoyMDowMA==?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 11/11/2021 05:36:45
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 167193 [Nov 11 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: pkshih@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 465 465 eb31509370142567679dd183ac984a0cb2ee3296
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;forums.lenovo.com:7.1.1;github.com:7.1.1;127.0.0.199:7.1.2;realtek.com:7.1.1;wiki.ubuntu.com:7.1.1
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 11/11/2021 05:39:00
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE5pa29sYXkgU3RhbmNoZXYg
PHN0YW5jaGV2Lm5pY2tAZ21haWwuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIE5vdmVtYmVyIDEw
LCAyMDIxIDc6MTEgUE0NCj4gVG86IGxpbnV4LXdpcmVsZXNzQHZnZXIua2VybmVsLm9yZw0KPiBT
dWJqZWN0OiBGd2Q6IHJ0dzg5IGRyaXZlcg0KPiANCj4gSGkgdGhlcmUsDQo+IA0KPiBBIGNvdXBs
ZSBvZiBtb250aHMgYWdvIEkgYm91Z2h0IGEgbmV3IG1hY2hpbmUgZnJvbSBMZW5vdm8gKFQxNCBB
TUQgR2VuIDINCj4gNTg1MFUpIGFuZCBJJ20gdXNpbmcgdGhpcyB3aWZpIGRyaXZlciB3aXRoIFVi
dW50dSAyMS4xMCB3aXRoIGtlcm5lbA0KPiA1LjEzLjAtMjAtZ2VuZXJpYzoNCj4gaHR0cHM6Ly9n
aXRodWIuY29tL2x3ZmluZ2VyL3J0dzg5DQo+IFRoZSBwcm9ibGVtIGlzIHRoYXQgdGhlIG1hY2hp
bmUgcmVib290cyByYW5kb21seS4gSSd2ZSBhdHRhY2hlZCBsb2dzIGFuZA0KPiBpdCBzZWVtcyB0
aGlzIGlzIGNhdXNlZCBieSB0aGUgZHJpdmVyLg0KPiBUaGUgc3lzdGVtIGxvZyBpcyBhdHRhY2hl
ZCBhbmQgdGhlIGlzc3VlIGlzIGFsc28gZGVzY3JpYmVkIGluIHRoaXMgdGhyZWFkOg0KPiBodHRw
czovL2ZvcnVtcy5sZW5vdm8uY29tL3Q1L1VidW50dS9UMTQtQU1ELUdlbi0yLTU4NTBVL20tcC81
MTA4Mjk4P3BhZ2U9MSM1NDc5MDUzDQoNCkkgc2VlIHlvdSBwb3N0IGFuIGlzc3VlIGluIExhcnJ5
J3MgZ2l0aHViLCBhbmQgSSBzdWdnZXN0IHRvIGFkZCBhbiBhZGRpdGlvbmFsDQptb2R1bGUgcGFy
YW1ldGVyOiANCg0KL2V0Yy9tb2Rwcm9iZS5kLzUwLXJ0dzg5LmNvbmYNCm9wdGlvbnMgcnR3ODlw
Y2kgZGlzYWJsZV9hc3BtX2wxPXkgZGlzYWJsZV9hc3BtX2wxc3M9eSBkaXNhYmxlX2Nsa3JlcT15
DQoNCkFmdGVyIHJlYm9vdGluZyBtYWNoaW5lLCBwbGVhc2UgY2hlY2sgL3N5cy9tb2R1bGUvcnR3
ODlfcGNpL3BhcmFtZXRlcnMvKiB0bw0Kc2VlIGlmIGFib3ZlIHZhbHVlcyBhcmUgZXhwZWN0ZWQu
DQoNCg0KU2luY2UgeW91ciBsb2cgaXMgdHJ1bmNhdGVkLCBJIHN1Z2dlc3QgdG8gdXNlIG5ldGNv
bnNvbGUgWzFdIHRvIGNhcHR1cmUNCnRoZSBsb2cuIFRvIGRvIHRoaXMsIHlvdSBuZWVkIGFuIGFk
ZGl0aW9uYWwgUEMgd2l0aCBFdGhlcm5ldCBjb25uZWN0IHRvDQp0aGlzIFBDLg0KDQpbMV0gaHR0
cHM6Ly93aWtpLnVidW50dS5jb20vS2VybmVsL05ldGNvbnNvbGUNCg0KLS0NClBpbmctS2UNCg0K
DQo=
