Return-Path: <linux-wireless+bounces-1652-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69BD282960D
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jan 2024 10:16:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF4591F2172B
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jan 2024 09:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC33210B;
	Wed, 10 Jan 2024 09:16:22 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E9A3C689
	for <linux-wireless@vger.kernel.org>; Wed, 10 Jan 2024 09:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 40A9FvApA971080, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 40A9FvApA971080
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jan 2024 17:15:58 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Wed, 10 Jan 2024 17:15:57 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 10 Jan 2024 17:15:57 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e4c4:c4f:4e4c:d23c]) by
 RTEXMBS04.realtek.com.tw ([fe80::e4c4:c4f:4e4c:d23c%5]) with mapi id
 15.01.2507.035; Wed, 10 Jan 2024 17:15:57 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Viacheslav <adeep@lexina.in>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
CC: =?utf-8?B?SmVybmVqIMWga3JhYmVj?= <jernej.skrabec@gmail.com>,
        "Martin
 Blumenstingl" <martin.blumenstingl@googlemail.com>
Subject: RE: rtw88: rtl8822cs AP mode not working
Thread-Topic: rtw88: rtl8822cs AP mode not working
Thread-Index: AQHaQ5OsSQGQ9nw7J0iwO3LVKmuk7LDSwwJA
Date: Wed, 10 Jan 2024 09:15:56 +0000
Message-ID: <11c7333aee0d45fd9fbfc65f6e2a3aa2@realtek.com>
References: <36972ff5-0c48-4bd2-8f9a-9649bfa24225@lexina.in>
In-Reply-To: <36972ff5-0c48-4bd2-8f9a-9649bfa24225@lexina.in>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXDAG02.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVmlhY2hlc2xhdiA8YWRl
ZXBAbGV4aW5hLmluPg0KPiBTZW50OiBXZWRuZXNkYXksIEphbnVhcnkgMTAsIDIwMjQgMzowNyBQ
TQ0KPiBUbzogbGludXgtd2lyZWxlc3NAdmdlci5rZXJuZWwub3JnDQo+IENjOiBQaW5nLUtlIFNo
aWggPHBrc2hpaEByZWFsdGVrLmNvbT47IEplcm5laiDFoGtyYWJlYyA8amVybmVqLnNrcmFiZWNA
Z21haWwuY29tPjsgTWFydGluIEJsdW1lbnN0aW5nbA0KPiA8bWFydGluLmJsdW1lbnN0aW5nbEBn
b29nbGVtYWlsLmNvbT4NCj4gU3ViamVjdDogcnR3ODg6IHJ0bDg4MjJjcyBBUCBtb2RlIG5vdCB3
b3JraW5nDQo+IA0KPiBIZWxsbyENCj4gDQo+IFdlIHVzZSBSVEw4ODIyQ1MgbW9kdWxlcyBpbiBv
dXIgZGV2aWNlcyBhbmQgd2Ugc3dpdGNoZWQgdG8gcnR3ODggZnJvbSBhbg0KPiBleHRlcm5hbCBk
cml2ZXIgYnkgUmVhbHRlay4gU3VkZGVubHkgd2UgZGlzY292ZXJlZCB0aGF0IHRoZSBBUCBtb2Rl
DQo+IChob3RzcG90KSBzdG9wcGVkIHdvcmtpbmcuIFRoZSBob3RzcG90IGlzIHNldCB1cCwgYnV0
IGl0IGRvZXMgbm90DQo+IGF1dGhvcml6ZSBjbGllbnQgY29ubmVjdGlvbnMuDQo+IA0KPiBJbiBh
dHRhY21lbnRzIGxvZyBhbmQgY29uZmlnIGZpbGVzLg0KPiANCj4gY2xpZW50IC0gbm90ZWJvb2sg
d2l0aCBpd2x3aWZpIDAwMDA6MDA6MTQuMzogRGV0ZWN0ZWQgS2lsbGVyKFIpIFdpLUZpIDZFDQo+
IEFYMTY3NWkgMTYwTUh6IFdpcmVsZXNzIE5ldHdvcmsgQWRhcHRlciAoMjExTkdXKSwgUkVWPTB4
MzcwDQo+IA0KDQpJdCBpcyBwcm9iYWJseSBiZWNhdXNlIFJUTDg4MjJDUyBkb2Vzbid0IGlzc3Vl
IGJlYWNvbiBwcm9wZXJseS4gVHJ5aW5nIHRvDQpjYXB0dXJlIGFpciBwYWNrZXRzIHdpbGwgYmUg
aGVscGZ1bCB0byBjbGFyaWZ5IHRoZSBwcm9ibGVtLg0KDQpKYW4gMTAgMDk6NDU6NTcgYWRlZXBu
IHdwYV9zdXBwbGljYW50WzMzMjZdOiB3bG8xOiBBc3NvY2lhdGVkIHdpdGggNWM6YzU6NjM6MmE6
NzA6N2ENCkphbiAxMCAwOTo0NTo1OCBhZGVlcG4gd3BhX3N1cHBsaWNhbnRbMzMyNl06IHdsbzE6
IENUUkwtRVZFTlQtQkVBQ09OLUxPU1MNCkphbiAxMCAwOTo0NTo1OCBhZGVlcG4gd3BhX3N1cHBs
aWNhbnRbMzMyNl06IHdsbzE6IENUUkwtRVZFTlQtQkVBQ09OLUxPU1MNCkphbiAxMCAwOTo0NTo1
OCBhZGVlcG4gd3BhX3N1cHBsaWNhbnRbMzMyNl06IHdsbzE6IENUUkwtRVZFTlQtQkVBQ09OLUxP
U1MNCkphbiAxMCAwOTo0NTo1OCBhZGVlcG4gd3BhX3N1cHBsaWNhbnRbMzMyNl06IHdsbzE6IENU
UkwtRVZFTlQtQkVBQ09OLUxPU1MNCkphbiAxMCAwOTo0NTo1OSBhZGVlcG4gd3BhX3N1cHBsaWNh
bnRbMzMyNl06IHdsbzE6IENUUkwtRVZFTlQtQkVBQ09OLUxPU1MNCkphbiAxMCAwOTo0NTo1OSBh
ZGVlcG4gd3BhX3N1cHBsaWNhbnRbMzMyNl06IHdsbzE6IENUUkwtRVZFTlQtRElTQ09OTkVDVEVE
IGJzc2lkPTVjOmM1OjYzOjJhOjcwOjdhIHJlYXNvbj00IGxvY2FsbHlfZ2VuZXJhdGVkPTENCg0K
DQo=

