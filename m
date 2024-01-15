Return-Path: <linux-wireless+bounces-1900-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 832AB82D321
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jan 2024 03:37:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07B351F209B3
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jan 2024 02:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD47628;
	Mon, 15 Jan 2024 02:37:01 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16ABC368
	for <linux-wireless@vger.kernel.org>; Mon, 15 Jan 2024 02:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 40F2am7cB3498785, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 40F2am7cB3498785
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Jan 2024 10:36:49 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Mon, 15 Jan 2024 10:36:48 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 15 Jan 2024 10:36:48 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e4c4:c4f:4e4c:d23c]) by
 RTEXMBS04.realtek.com.tw ([fe80::e4c4:c4f:4e4c:d23c%5]) with mapi id
 15.01.2507.035; Mon, 15 Jan 2024 10:36:48 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Fiona Klute <fiona.klute@gmx.de>,
        linux-wireless
	<linux-wireless@vger.kernel.org>
Subject: RE: Extending rtw88 for rtl8723cs/rtl8703b SDIO chips
Thread-Topic: Extending rtw88 for rtl8723cs/rtl8703b SDIO chips
Thread-Index: AQHaRw8ogS2u8ut2kkOrDcZC3GGVg7DaJeRQ
Date: Mon, 15 Jan 2024 02:36:48 +0000
Message-ID: <55e87e59794744eebdf8033931c94bdc@realtek.com>
References: <1154e0cc-4c37-4d69-8f2e-d81ae5b93624@gmx.de>
In-Reply-To: <1154e0cc-4c37-4d69-8f2e-d81ae5b93624@gmx.de>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXDAG01.realtek.com.tw, 9
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRmlvbmEgS2x1dGUgPGZp
b25hLmtsdXRlQGdteC5kZT4NCj4gU2VudDogTW9uZGF5LCBKYW51YXJ5IDE1LCAyMDI0IDE6Mjkg
QU0NCj4gVG86IGxpbnV4LXdpcmVsZXNzIDxsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmc+
DQo+IENjOiBQaW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT4NCj4gU3ViamVjdDogRXh0
ZW5kaW5nIHJ0dzg4IGZvciBydGw4NzIzY3MvcnRsODcwM2IgU0RJTyBjaGlwcw0KPiANCj4gSGks
DQo+IA0KPiBJJ20gdHJ5aW5nIHRvIGV4dGVuZCB0aGUgcnR3ODggZHJpdmVyIHRvIHN1cHBvcnQg
dGhlIHJ0bDg3MjNjcyBjYXJkIHVzZWQNCj4gaW4gdGhlIFBpbmVwaG9uZSwgd2l0aCBpdHMgcnRs
ODcwM2IgY2hpcC4gVGhlIGNvZGUgaXMgZmFyIGZyb20gcmVhZHkgZm9yDQo+IHJldmlldyAoSSdt
IGhhbGZ3YXkgaW50byBjaGlwIGluaXRpYWxpemF0aW9uIHNvIGZhciwgbG9vayBhdCBbMV0gaWYg
eW91DQo+IGxpa2UpLCBidXQgSSdkIGxpa2UgdG8gYXNrIGEgZmV3IHF1ZXN0aW9uIHRvIGF2b2lk
IHdhc3RpbmcgdGltZS4NCj4gDQo+IDEpIFRoZSA4NzAzYiBjaGlwIGlzIHByZXR0eSBzaW1pbGFy
IHRvIHRoZSBhbHJlYWR5IHN1cHBvcnRlZCA4NzIzZCwgSQ0KPiBjYW4gZGlyZWN0bHkgcmV1c2Ug
c29tZSBmdW5jdGlvbnMgZGVmaW5lZCBpbiBydHc4NzIzZC5jIChlLmcuIGVmdXNlDQo+IHBhcnNp
bmcpLiBXb3VsZCBtb3ZpbmcgdGhvc2UgdG8gYSBzaGFyZWQgc3VwcG9ydCBtb2R1bGUgKCJydHc4
OF84N3gzIiBvcg0KPiBzaW1pbGFyKSBiZSBhY2NlcHRhYmxlPyBJZiBub3QsIHdoYXQncyB0aGUg
cmVjb21tZW5kZWQgYXBwcm9hY2g/DQoNCkkgcHJlZmVyIHJ0dzg4Xzg3MjNfY29tbW9uLCBiZWNh
dXNlIDg3MjNjcyBpcyBtb3JlIGZvcm1hbCBhbmQgODcwM2NzIGlzIGp1c3QNCmEgc3VidHlwZSBv
ZiA4NzIzY3MsIA0KDQo+IA0KPiAyKSBJJ20gY3VycmVudGx5IHVzaW5nIGZpcm13YXJlIGV4dHJh
Y3RlZCBmcm9tIHRoZSAobm90IGluIG1haW5saW5lIGFuZA0KPiBsaWtlbHkgbmV2ZXIgd2lsbCBi
ZSkgcnRsODcyM2NzIGRyaXZlciBbMl0sIHdoZXJlIGl0J3Mgc3RvcmVkIGFzIHU4DQo+IGFycmF5
cyBpbiBzb3VyY2Ugd2l0aCBHUEwgbGljZW5zZSBoZWFkZXIuIERvIHlvdSBrbm93IGlmIHRoYXQn
ZCBiZQ0KPiBhY2NlcHRhYmxlIGZvciBsaW51eC1maXJtd2FyZT8gUGluZy1LZSwgZnJvbSB5b3Vy
IG1haWwgYWRkcmVzcyBJJ20NCj4gZ3Vlc3NpbmcgeW91IHdvcmsgYXQgUmVhbHRlaywgaXMgdGhl
cmUgYW55IGNoYW5jZSB0byBnZXQgODcwM2IgZmlybXdhcmUNCj4gcmVsZWFzZWQgZGlyZWN0bHk/
IEFzIGEgZmFsbGJhY2ssIGNvdWxkIHRoZSBkcml2ZXIgYmUgYWNjZXB0ZWQgaWYgcGVvcGxlDQo+
IHdpbGwgc3RpbGwgbmVlZCB0byBnZXQgZmlybXdhcmUgc2VwYXJhdGVseT8NCg0KRmlybXdhcmUg
c2hvdWxkIGdvIHZpYSBsaW51eC1maXJtd2FyZSBbMV0uIFlvdSBjYW4gc2VuZCBhbiBpbmRpdmlk
dWFsDQpmaXJtd2FyZSBwYXRjaCB3aXRoIHRvIG1lLiBJIHdpbGwgaGVscCB0byBzZW5kIGEgcHVs
bCByZXF1ZXN0IHdpdGgNCm15IHMtby1iLg0KDQo+IA0KPiAzKSBGaW5hbGx5LCBsaWNlbnNpbmc6
IEFyZSBHUEwtb25seSBtb2R1bGUvY2hpcCBkcml2ZXJzIGZvciBydHc4OA0KPiBhY2NlcHRhYmxl
PyBBIHNoYXJlZCBzdXBwb3J0IG1vZHVsZSB3b3VsZCBvZiBjb3Vyc2Ugc3RpY2sgd2l0aCB0aGUN
Cj4gY3VycmVudCBkdWFsIGxpY2Vuc2UuDQoNCkkgdGhpbmsgeW91IGNhbiBkZWNsYXJlIGR1YWwg
bGljZW5zZSB0byBuZXcgYWRkZWQvcmV3cml0dGVuIDg3MjNjcyouDQpJJ20gbm90IGEgbGF3eWVy
LCBidXQgd2UgaGF2ZSBkb25lIG1hbnkgZHJpdmVycyBhbHJlYWR5LiANCg0KUGluZy1LZSANCg0K
WzFdIGdpdDovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9maXJtd2Fy
ZS9saW51eC1maXJtd2FyZS5naXQNCg0K

