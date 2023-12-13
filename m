Return-Path: <linux-wireless+bounces-726-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8598981071F
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Dec 2023 02:00:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B29AE1C20D64
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Dec 2023 01:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 321B8A49;
	Wed, 13 Dec 2023 01:00:36 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6761FA0
	for <linux-wireless@vger.kernel.org>; Tue, 12 Dec 2023 17:00:33 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3BD10PcA43841876, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3BD10PcA43841876
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Dec 2023 09:00:26 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.32; Wed, 13 Dec 2023 09:00:26 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 13 Dec 2023 09:00:26 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Wed, 13 Dec 2023 09:00:26 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Kalle Valo <kvalo@kernel.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH 1/6] wifi: rtw89: fw: load TX power track tables from fw_element
Thread-Topic: [PATCH 1/6] wifi: rtw89: fw: load TX power track tables from
 fw_element
Thread-Index: AQHaKEJHcLCPC03YDEGRs5IWhn9B8LClRp6AgAEmKPA=
Date: Wed, 13 Dec 2023 01:00:26 +0000
Message-ID: <1fa30c946dfa4e959f3f820388c520f0@realtek.com>
References: <20231206124448.10537-2-pkshih@realtek.com>
 <170239437797.306086.16729667007676555795.kvalo@kernel.org>
In-Reply-To: <170239437797.306086.16729667007676555795.kvalo@kernel.org>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS01.realtek.com.tw, 9
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS2FsbGUgVmFsbyA8a3Zh
bG9Aa2VybmVsLm9yZz4NCj4gU2VudDogVHVlc2RheSwgRGVjZW1iZXIgMTIsIDIwMjMgMTE6MjAg
UE0NCj4gVG86IFBpbmctS2UgU2hpaCA8cGtzaGloQHJlYWx0ZWsuY29tPg0KPiBDYzogbGludXgt
d2lyZWxlc3NAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMS82XSB3aWZp
OiBydHc4OTogZnc6IGxvYWQgVFggcG93ZXIgdHJhY2sgdGFibGVzIGZyb20gZndfZWxlbWVudA0K
PiANCj4gUGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+IHdyb3RlOg0KPiANCj4gPiBU
aGUgVFggcG93ZXIgdHJhY2sgdGFibGVzIGFyZSB1c2VkIHRvIGRlZmluZSBjb21wZW5zYXRpb24g
cG93ZXIgcmVmbGVjdGVkDQo+ID4gdG8gdGhlcm1hbCB2YWx1ZS4gQ3VycmVudGx5LCB3ZSBoYXZl
IDE2ICgyICogNCAqIDIpIHRhYmxlcyBtYWRlIGJ5DQo+ID4gY29tYmluYXRpb25zIG9mDQo+ID4g
ICB7bmVnYXRpdmUvcG9zaXRpdmUgdGhlcm1hbCB2YWx1ZSwgMkdIei8yR0h6LUNDSy81R0h6LzZH
SHosIHBhdGggQS9CfQ0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogUGluZy1LZSBTaGloIDxwa3No
aWhAcmVhbHRlay5jb20+DQo+IA0KPiBGYWlsZWQgdG8gYXBwbHksIGRvbid0IGtub3cgd2h5Lg0K
PiANCg0KVGhhdCBpcyBiZWNhdXNlIGFub3RoZXIgcGF0Y2hzZXQgY2hhbmdlZCBkcml2ZXJzL25l
dC93aXJlbGVzcy9yZWFsdGVrL3J0dzg5L2Z3LmgsDQpidXQgSSBhbSBub3QgYXdhcmUgb2YgdGhp
cyB3aGVuIHNlbmRpbmcgdGhpcyBwYXRjaHNldC4gSSBkaWQgcmViYXNlIGFuZA0Kc2VudCB2MiB0
byBjb3JyZWN0IHRoaXMuIFNvcnJ5IGZvciB0aGUgaW5jb252ZW5pZW5jZS4gDQoNCg0K

