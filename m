Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2BB441D0F0
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Sep 2021 03:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345243AbhI3B3U (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 Sep 2021 21:29:20 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:46980 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbhI3B3U (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 Sep 2021 21:29:20 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 18U1RY5t8015413, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36503.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 18U1RY5t8015413
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 30 Sep 2021 09:27:34 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36503.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Thu, 30 Sep 2021 09:27:34 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 30 Sep 2021 09:27:33 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::cdd5:82a3:e854:7098]) by
 RTEXMBS04.realtek.com.tw ([fe80::cdd5:82a3:e854:7098%5]) with mapi id
 15.01.2106.013; Thu, 30 Sep 2021 09:27:33 +0800
From:   Pkshih <pkshih@realtek.com>
To:     Will Yang <willyangywt@gmail.com>,
        "tony0620emma@gmail.com" <tony0620emma@gmail.com>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: rtw8822ce: support for miracast?
Thread-Topic: rtw8822ce: support for miracast?
Thread-Index: AQHXtRg8SJdUyyEd8kmmrthzAm82Dqu7ya2A
Date:   Thu, 30 Sep 2021 01:27:33 +0000
Message-ID: <a68ffbe845ad4867a0b14c811b2c5fbf@realtek.com>
References: <CAKCvHdezdR29EXKS3eZMde3VgTEWMoxV5mc6gxZsCMhhbZhNZw@mail.gmail.com>
In-Reply-To: <CAKCvHdezdR29EXKS3eZMde3VgTEWMoxV5mc6gxZsCMhhbZhNZw@mail.gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS05.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIxLzkvMjkg5LiL5Y2IIDExOjI3OjAw?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36503.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFdpbGwgWWFuZyA8d2lsbHlh
bmd5d3RAZ21haWwuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIFNlcHRlbWJlciAyOSwgMjAyMSA1
OjU2IFBNDQo+IFRvOiB0b255MDYyMGVtbWFAZ21haWwuY29tDQo+IENjOiBsaW51eC13aXJlbGVz
c0B2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogcnR3ODgyMmNlOiBzdXBwb3J0IGZvciBtaXJh
Y2FzdD8NCj4gDQo+IChJIGFtIHJlYWxseSBzb3JyeSBmb3IgdGhlIGR1cGxpY2F0aW9uIG9mIGVt
YWlscywgaXQncyBqdXN0IEkga2VlcA0KPiByZWplY3RlZCBieSB0aGUgbGludXgtd2lyZWxlc3Mg
bWFpbGluZyBsaXN0IGJlY2F1c2Ugb2Ygb3V0bG9vayBhbmQNCj4gSFRNTCBlbWFpbCkNCj4gSGkg
dG9ueS1lbW1hLA0KPiANCj4gSSBhbSB1c2luZyBhIGZlZG9yYSBsaW51eCAzNCB3aXRoIGEgUlRM
ODgyMkNFLCBhbmQgdGhpcyBuZXR3b3JrDQo+IGNvbnRyb2xsZXIgaXMgaGFyZHdhcmUgY2FwYWJs
ZSBvZiBydW5uaW5nIG1pcmFjYXN0IChha2Egd2lmaSBwMnApLCBidXQNCj4gaXQgZG9lc24ndCBz
ZWVtcyB0byBoYXZlIGRyaXZlciBzdXBwb3J0IGZvciBpdC4NCj4gDQo+IElzIHRoZSBzdXBwb3J0
IGZvciBtaXJhY2FzdCBhbHJlYWR5IGluIHRoZSBrZXJuZWwgZHJpdmVyPyBJZiBub3QsIGNhbg0K
PiBpdCBiZSBhZGRlZD8NCj4gDQo+IFRoYW5rIHlvdSENCj4gDQo+IGBpdyBwaHlgDQo+IFdpcGh5
IHBoeTANCj4gU3VwcG9ydGVkIGludGVyZmFjZSBtb2RlczoNCj4gICogSUJTUw0KPiAgKiBtYW5h
Z2VkDQo+ICAqIEFQDQo+ICAqIEFQL1ZMQU4NCj4gICogbW9uaXRvcg0KPiAgKiBtZXNoIHBvaW50
DQo+IA0KPiBBdHRhY2hlZCBvdXRwdXQgb2YgYHN1ZG8gbHNwY2kgLXZ2YCBhbmQgYGl3IHBoeWAN
Cg0KSGksDQoNClRoZSBydHc4OCBkcml2ZXIgZG9lc24ndCBzdXBwb3J0IFAyUCB5ZXQsIGJ1dCBp
dCdzIHBvc3NpYmxlIHRvIG1ha2UgDQpydHc4ODIyY2Ugc3VwcG9ydCBtaXJhY2FzdC4gV2UnbGwg
dHJ5IGZlZG9yYSBsaW51eCAzNCB0byBzZWUgd2hhdA0Kd2UgbmVlZCB0byBhZGQuDQoNCi0tDQpQ
aW5nLUtlDQoNCg==
