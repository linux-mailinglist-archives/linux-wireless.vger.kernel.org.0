Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4BC38038A
	for <lists+linux-wireless@lfdr.de>; Fri, 14 May 2021 08:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232136AbhENGKC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 May 2021 02:10:02 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:60146 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbhENGKA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 May 2021 02:10:00 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 14E68SMB0025574, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36502.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 14E68SMB0025574
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 14 May 2021 14:08:28 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36502.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 14 May 2021 14:08:27 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 14 May 2021 14:08:26 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1d8:ba7d:61ca:bd74]) by
 RTEXMBS04.realtek.com.tw ([fe80::1d8:ba7d:61ca:bd74%5]) with mapi id
 15.01.2106.013; Fri, 14 May 2021 14:08:26 +0800
From:   Pkshih <pkshih@realtek.com>
To:     =?utf-8?B?6YKx5ZCN56Kp?= <ccchiu77@gmail.com>,
        Andy Huang <tehuang@realtek.com>,
        "Larry.Finger@lwfinger.net" <Larry.Finger@lwfinger.net>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "kvalo@codeaurora.org" <kvalo@codeaurora.org>,
        Reto Schneider <reto.schneider@husqvarnagroup.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: How does the rate adaptive mask work on Realtek WiFi driver
Thread-Topic: How does the rate adaptive mask work on Realtek WiFi driver
Thread-Index: AQHXRXeJ96JiGH6RoUuehd+sRUk43arifRnQ
Date:   Fri, 14 May 2021 06:08:26 +0000
Message-ID: <89da58fc162b46558d60495110fcf75f@realtek.com>
References: <CANgQ54dicgKSZFm3w9sbAYztFw9xBHZnt8aQMNCEfMn_twBbWQ@mail.gmail.com>
In-Reply-To: <CANgQ54dicgKSZFm3w9sbAYztFw9xBHZnt8aQMNCEfMn_twBbWQ@mail.gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.146]
x-kse-serverinfo: RTEXMBS01.realtek.com.tw, 9
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIxLzUvMTQg5LiK5Y2IIDAxOjM1OjAw?=
x-kse-attachment-filter-triggered-rules: Clean
x-kse-attachment-filter-triggered-filters: Clean
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 05/14/2021 05:52:47
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 163650 [May 14 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: pkshih@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 445 445 d5f7ae5578b0f01c45f955a2a751ac25953290c9
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: 127.0.0.199:7.1.2;realtek.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1
X-KSE-AntiSpam-Info: {Track_Chinese_Simplified, text}
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 05/14/2021 05:56:00
X-KSE-ServerInfo: RTEXH36502.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 05/14/2021 05:52:47
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 163650 [May 14 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: pkshih@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 445 445 d5f7ae5578b0f01c45f955a2a751ac25953290c9
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;realtek.com:7.1.1;127.0.0.199:7.1.2
X-KSE-AntiSpam-Info: {Track_Chinese_Simplified, text}
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 05/14/2021 06:00:00
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IOmCseWQjeeiqSBbbWFpbHRv
OmNjY2hpdTc3QGdtYWlsLmNvbV0NCj4gU2VudDogTW9uZGF5LCBNYXkgMTAsIDIwMjEgNDozNiBQ
TQ0KPiBUbzogUGtzaGloOyBBbmR5IEh1YW5nOyBMYXJyeS5GaW5nZXJAbHdmaW5nZXIubmV0OyBr
dWJhQGtlcm5lbC5vcmc7IGt2YWxvQGNvZGVhdXJvcmEub3JnOyBSZXRvDQo+IFNjaG5laWRlcjsg
bGludXgtd2lyZWxlc3NAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwu
b3JnDQo+IFN1YmplY3Q6IEhvdyBkb2VzIHRoZSByYXRlIGFkYXB0aXZlIG1hc2sgd29yayBvbiBS
ZWFsdGVrIFdpRmkgZHJpdmVyDQo+IA0KPiBIaSBndXlzLA0KPiAgICAgSSBoYWQgYSBwcm9ibGVt
IHdoaWxlIHZlcmlmeWluZyB0aGUgYW1wZHUgdHggdGhyb3VnaHB1dCB3aXRoIHRoZQ0KPiBydGw4
eHh4dSBkcml2ZXIgb24gUlRMODE4OENVUyBtb2R1bGUuIFRoZSB0aHJvdWdocHV0IG51bWJlciBp
cw0KPiByZWxhdGl2ZWx5IGdvb2QsIDM5fjQyTWJwcyAgVENQIG9uIDIuNEdIeiBjaGFubmVsLiBI
b3dldmVyLCB0aGUNCj4gcmV0cmFuc21pc3Npb24gcmF0ZSBpcyBoaWdoLCBpdCdzIDE1JSB+IDIx
JSB3aXRoIHJ0bDh4eHh1IGRyaXZlciBhbmQNCj4gSXQncyBhbG1vc3QgdGhlIHNhbWUgcmVzdWx0
IHdpdGggdGhlIHJ0bDgxOTJjdSBkcml2ZXIuIEkgY2FuIGdldA0KPiBhdmVyYWdlbHkgN34xMCUg
cmV0cmFuc21pc3Npb24gcmF0ZSBpbiB0aGUgc2FtZSB0ZXN0IGJlZCB3aXRoIFJlYWx0ZWsNCj4g
dmVuZG9yIGRyaXZlci4NCj4gDQo+ICAgICBGcm9tIHRoZSBhaXIgY2FwdHVyZSwgSSBjYW4gc2Vl
IHRoZSBydGw4eHh4dSBkcml2ZXIga2VlcCBzZW5kaW5nDQo+IHRoZSBhZ2dyZWdhdGVkIGZyYW1l
cyBpbiBNQ1M3IGFuZCBkb2Vzbid0IGV2ZW4gZmFsbCBiYWNrIHRvIGxvd2VyIE1DUw0KPiBpbmRl
eCBpbiB0aGUgc3Vic2VxdWVudCByZXRyaWVzLiBJIGNhbiBvbmx5IHNlZSB2ZXJ5IGZldyByZXRy
aWVkDQo+IHBhY2tldHMgYmVlbiBzZW50IHdpdGggTUNTMCBvciA2TWJwcyBncmF0ZS4gT24gdGhl
IHZlbmRvciBkcml2ZXIsIEknbGwNCj4gc2VlIHRoZSByZXRyaWVkIGFtcGR1IHBhY2tldHMgd2l0
aCBNQ1M0IGFmdGVyIDMgcmV0cmllcyB3L28gYWNrIGZyb20NCj4gdGhlIHJlY2VpdmVyLg0KPiAN
Cj4gICAgIEZyb20gdGhlIHJhdGUgbWFzayBjb21tYW5kIGlzc3VlZCBieSB0aGUgaDJjIGNvbW1h
bmQsIEkgZm9yY2UgYm90aA0KPiB0aGUgcnRsOHh4eHUgZHJpdmVyIGFuZCB2ZW5kb3IgZHJpdmVy
IHRvIHVzZSB0aGUgc2FtZSByYXRlbWFzayAweGZmZmZmDQo+IChNQ1MgMC03IGFuZCBiL2cgcmF0
ZSBpbmNsdWRlZCkgYW5kIGxlYXZlIHRoZSBhcmcwIGFzLWlzIChtb3N0bHkgMHhhMCkNCj4gYW5k
IEkgZXhwZWN0IGJvdGggZHJpdmVycyBjYW4gZG8gdGhlIHJhdGUgYWRhcHRpdmUgdGhpbmcgaW4g
dGhlIHNhbWUNCj4gd2F5LCBidXQgaXQgc2VlbXMgdG8gbWFrZSBubyBkaWZmZXJlbmNlLiBUaGUg
cnRsOHh4eHUgZHJpdmVyIHN0aWxsDQo+IHNlbmRzIHRoZSBwYWNrZXRzIHdpdGggaGlnaGVzdCBN
Q1MuDQo+IA0KPiAgICAgQ2FuIGFueW9uZSB0ZWxsIG1lIHdoYXQgc2hvdWxkIEkgZXhwZWN0IHRo
ZSByYXRlIGFkYXB0aXZlIHRvIHdvcmsNCj4gd2l0aCB0aGUgcmF0ZSBtYXNrIDB4ZmZmZmYgYW5k
IDB4ZjAwMDA/IERvZXMgdGhlIDB4ZjAwMDAgbWVhbnMgdGhhdCBpdA0KPiB3aWxsIHBpY2sgdXAg
YSB0eCByYXRlIG9ubHkgYmV0d2VlbiBucmF0ZSBNQ1M0IHRvIE1DUzc/IEkgbmVlZCBhIGJhc2UN
Cj4gbGluZSBzbyB0aGF0IEkgY2FuIGp1ZGdlIGl0J3Mgc2ltcGx5IGEgcmF0ZSBtYXNrIHByb2Js
ZW0gb3IgbWF5YmUgdGhlDQo+IGgyYyBjb21tYW5kIGlzIG5vdCB3cml0dGVuIGNvcnJlY3RseS4g
UGxlYXNlIGtpbmRseSBzdWdnZXN0IHdoYXQgSQ0KPiBzaG91bGQgZG8gbmV4dC4gVGhhbmtzDQo+
IA0KDQpUaGUgcmF0ZSBtYXNrIGluZGljYXRlcyB3aGljaCByYXRlcyB3aWxsIGJlIHVzZWQgYnkg
cmF0ZSBhZGFwdGl2ZSBtZWNoYW5pc20uDQpJJ20gbm90IHN1cmUgdGhlIGV4YWN0IGJpdCBhbGxv
Y2F0aW9uIGZvciBDQ0svT0ZETS9NQ1MsIG1heWJlDQoweDAwMDBmLzB4MDBmZjAvMHhmZjAwMDAg
Zm9yIENDSy9PRkRNL01DUyByZXNwZWN0aXZlbHksIGJ1dCB5b3UgY2FuIHRyYWNlDQp2ZW5kb3Ig
ZHJpdmVyIHRvIGtub3cgdGhlIGRldGFpbC4NCg0KSSBzdWdnZXN0IHlvdSBjYW4gdHJ5IHRvIHNl
bmQgb25seSBPRkRNIHJhdGUgbWFzaywgYW5kIGV4cGVjdCB0byBzZWUgT0ZETQ0KcmF0ZSBvbmx5
IGJ5IHlvdXIgc25pZmZlci4gSWYgaXQncyBzdGlsbCBrZWVwIG9uIE1DUzcsIHJhdGUgYWRhcHRp
dmUgbWF5DQpub3Qgd29yayBwcm9wZXJseS4NCg0KQWxzbywgeW91IGNhbiBjb21wYXJlIHRoZSBj
b250ZW50IG9mIHJhdGUgYWRhcHRpdmUgSDJDIHdpdGggdmVuZG9yIGRyaXZlciB0bw0Kc2VlIGlm
IHRoZSBmb3JtYXQgaXMgY29ycmVjdC4NCg0KQW5vdGhlciB0aGluZyBpcyB0byB0cnkgJ2ZpeF9y
YXRlJyBpbiB0eF9kZXNjLiBDaGVjayB0aGUgdmVuZG9yIGRyaXZlciB0bw0Ka25vdyB0aGUgdXNl
X3JhdGUvcmF0ZS9idyBmaWVsZHMgb2YgdHhfZGVzYy4gVGhlbiwgdHJ5IHRvIGZpeCB0aGUgcmF0
ZSB5b3UNCndhbnQuDQoNCi0tDQpQaW5nLUtlDQoNCg==
