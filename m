Return-Path: <linux-wireless+bounces-8151-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8F678D1224
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2024 04:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79C90282BFF
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2024 02:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8AF1DDBC;
	Tue, 28 May 2024 02:40:10 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7529450
	for <linux-wireless@vger.kernel.org>; Tue, 28 May 2024 02:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716864010; cv=none; b=GRGhIjbEPNJspOHa2eMP8ZiyeCzse/PtpRO9ufyn+Lev5kbWkqQ4FEupGYZKKUG8JOMtFmpnQA7oLu58j0ZM8vaQP7ycfEn0j7igHNSQVmgTvZ0JAMGGZj2nvEzhPR56/2cTZoaGBp8T7BfZnAE7GCRMBerI3Em6F0SLyemcv6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716864010; c=relaxed/simple;
	bh=FDQaLI4oqsk1pFwvhiPQVIVhAYSzr28ifO1JLQOsvRU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Nc4cvGybggfRSabMPrhFccU5Ap4we/UJNZY4l1zEDkhZgw2KcuhA2xgi5vrPdfu4cd4OQAP/UWcg8B58/KkrF6fXyLKmHigNikboxmB3coXvn+Pw4m9VyT9TWbHigpIvqj4Q2edDEF73GFg7JMDQy664n5HuTqM4a4wU35EIaPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 44S2dTo651859752, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 44S2dTo651859752
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 May 2024 10:39:29 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 28 May 2024 10:39:29 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 28 May 2024 10:39:28 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Tue, 28 May 2024 10:39:28 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        Stefan Lippers-Hollmann
	<s.l-h@gmx.de>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Larry
 Finger" <Larry.Finger@lwfinger.net>,
        Christian Hewitt <chewitt@libreelec.tv>,
        Johannes Berg <johannes@sipsolutions.net>
Subject: RE: [PATCH v7 12/12] wifi: rtlwifi: Enable the new rtl8192du driver
Thread-Topic: [PATCH v7 12/12] wifi: rtlwifi: Enable the new rtl8192du driver
Thread-Index: AQHarSBdbyWf9lKLLkKgqAnWSxDd/bGquXUA//+V1QCAAOVVgIAAt3Qg
Date: Tue, 28 May 2024 02:39:28 +0000
Message-ID: <ee442840754e4afba8388951f56c5e82@realtek.com>
References: <8805826b-60b9-4026-9509-7d92c3a43577@gmail.com>
 <5f2da7ee-876a-42fc-8fec-ec5386fa8c26@gmail.com>
 <0002749a3b584bc39fa18b3137153fdf@realtek.com> <20240527112534.4dbcdf75@mir>
 <29f850c5-4f61-466f-9a7a-437b05bc8251@gmail.com>
In-Reply-To: <29f850c5-4f61-466f-9a7a-437b05bc8251@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBKb2hh
bm5lcyBzdWdnZXN0ZWQgdGhhdCB3ZSBzaG91bGQgc2V0IGh3LT53aXBoeS0+cmV0cnlfe2xvbmcs
c2hvcnR9DQo+IGJlZm9yZSBpZWVlODAyMTFfcmVnaXN0ZXJfaHcoKS4gU28gdGhhdCB3b3VsZCBn
byBpbg0KPiBfcnRsX2luaXRfbWFjODAyMTEoKS4gVGhhdCBoYXMgdGhlIGFkZGVkIGJlbmVmaXQg
b2YgbWFraW5nIHRoZQ0KPiB0cnVlIHJldHJ5IGxpbWl0cyB2aXNpYmxlIHRvIHVzZXJzcGFjZSAo
Iml3IHBoeSIpLg0KPiANCj4gVGhlIHByb2JsZW0gaXMgdGhhdCBzZXR0aW5nIGh3LT53aXBoeS0+
cmV0cnlfe2xvbmcsc2hvcnR9IGlzDQo+IG5vdCBlbm91Z2guIHJ0bHdpZmkgc3RpbGwgZ2V0cyB0
aGUgZGVmYXVsdCByZXRyeSBsaW1pdHMgb2YgNA0KPiBhbmQgNywgYmVjYXVzZSBpZWVlODAyMTFf
cmVnaXN0ZXJfaHcoKSBkb2Vzbid0IHNldA0KPiBody0+Y29uZi5sb25nX2ZyYW1lX21heF90eF9j
b3VudCAoYW5kIGh3LT5jb25mLnNob3J0X2ZyYW1lX21heF90eF9jb3VudCkuDQo+IEpvaGFubmVz
IHN1Z2dlc3RlZCBtb3ZpbmcgdGhpcyBjb2RlIGZyb20gaWVlZTgwMjExX2FsbG9jX2h3X25tKCkN
Cj4gdG8gaWVlZTgwMjExX3JlZ2lzdGVyX2h3KCk6DQo+IA0KPiAgICAgICAgIGxvY2FsLT5ody5j
b25mLmxvbmdfZnJhbWVfbWF4X3R4X2NvdW50ID0gd2lwaHktPnJldHJ5X2xvbmc7DQo+ICAgICAg
ICAgbG9jYWwtPmh3LmNvbmYuc2hvcnRfZnJhbWVfbWF4X3R4X2NvdW50ID0gd2lwaHktPnJldHJ5
X3Nob3J0Ow0KPiANCj4gSSBkaWRuJ3QgZG8gdGhpcyB5ZXQgcGFydGx5IGJlY2F1c2UgSSBkb24n
dCB3YW50IHRvIGNvbXBpbGUNCj4gdGhlIGVudGlyZSBrZXJuZWwsIGFuZCBwYXJ0bHkgYmVjYXVz
ZSBJJ20gbm90IHN1cmUgaG93IHRvIGhhbmRsZQ0KPiB0aGUgZGlmZmVyZW50IHJldHJ5IGxpbWl0
cyBmb3IgQVAvSUJTUyBtb2RlIGFuZCBzdGF0aW9uIG1vZGUuDQo+IA0KPiBDYW4gd2UgY2hhbmdl
IGh3LT53aXBoeS0+cmV0cnlfe2xvbmcsc2hvcnR9IGFueSB0aW1lLCBub3QganVzdA0KPiBiZWZv
cmUgaWVlZTgwMjExX3JlZ2lzdGVyX2h3KCk/IElmIHllcywgd2hhdCBpcyBldmVuIHRoZSBwb2lu
dA0KPiBvZiBody0+Y29uZi57c2hvcnQsbG9uZ31fZnJhbWVfbWF4X3R4X2NvdW50ID8gSXQgd291
bGQgYmUgc2ltcGxlcg0KPiBpZiB3ZSBjYW4gaWdub3JlIHRoZW0gYW5kIHVzZSBody0+d2lwaHkt
PnJldHJ5X3tsb25nLHNob3J0fQ0KPiBkaXJlY3RseS4NCj4gDQo+IFdoYXQgZG8geSdhbGwgdGhp
bms/DQoNCkxvZ2ljYWxseSBJIHRoaW5rIHlvdSBjYW4gY2hhbmdlIGh3LT53aXBoeS0+cmV0cnlf
e2xvbmcsc2hvcnR9IGFueSB0aW1lLA0KYmVjYXVzZSBjZmc4MDIxMS9tYWM4MDIxMSBzZWVtaW5n
bHkganVzdCBieXBhc3MgdGhlIHZhbHVlcyB0byBkcml2ZXIuIA0KDQpPbmUgdGhpbmcgaXMgdGhh
dCBzaG91bGQgd2UgaG9ub3IgdGhlIHZhbHVlcyBzZXQgYnkgdXNlciBzcGFjZT8NCkJ1dCB3ZSBj
YW4ndCBrbm93IGlmIHVzZXIgc3BhY2UgaGFzIHNldCB0aGUgdmFsdWUsIHJpZ2h0Pw0KDQpJZiB1
c2VyIHNwYWNlIGhhcyBub3Qgc2V0LCBkcml2ZXIgd2FudHMgdG8gY29udHJvbCB0aGlzIHZhbHVl
IGJ5IGl0c2VsZg0KYWNjb3JkaW5nIHRvIEFQL0lCU1Mvc3RhdGlvbiBtb2Rlcy4NCklmIHVzZXIg
c3BhY2UgaGFzIHNldCwgZHJpdmVyIGZ1bGx5IGZvbGxvd3MgdGhlIHZhbHVlIGZyb20gdXNlciBz
cGFjZS4NCklzIGFib3ZlIHRoZSBiZWhhdmlvciB5b3Ugd2FudD8NCg0K

