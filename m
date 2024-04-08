Return-Path: <linux-wireless+bounces-5959-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8BF989B616
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Apr 2024 04:46:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 491D41F21594
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Apr 2024 02:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E11CD4C8A;
	Mon,  8 Apr 2024 02:46:31 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C044C63
	for <linux-wireless@vger.kernel.org>; Mon,  8 Apr 2024 02:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712544391; cv=none; b=rneLBMTgMlYB7A4gl9L9MIuB4ajjdG7/e1sN0ZTGF1tK66L4s10ik0noB7zJCP74Ch2bQIypKgT03xfrCCj+cByU1zqzPWT43YrECpROWIMFOJqw3McQ4HeD7SOO4u1W8/oGkdHd2KHQOPEIDORtpq0dAEpaanFhIHidKWBj8ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712544391; c=relaxed/simple;
	bh=/81W9d2mBp0W0wsvMJ+MuxZ/LrU4KtC93+VWAa3PWh8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=W4Fyip8VxcLgqGYLNqb7n6J2dtFqeYVIED6OD6I9P/VuoDLClMkQDVrAGvMljNRfP/HwRSp1tiZtlYOFKyXdXFgdsQPK0+nxn54euT9qPUvXrJacsSX+Sy95+w4dl+Wgne5MSRZpq+v9r7Qo9EFwA2uDmELMGhh9jvCddOx2nFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4382jo1631372928, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4382jo1631372928
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Apr 2024 10:45:50 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 8 Apr 2024 10:45:50 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 8 Apr 2024 10:45:49 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Mon, 8 Apr 2024 10:45:49 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "kvalo@kernel.org"
	<kvalo@kernel.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Larry.Finger@lwfinger.net" <Larry.Finger@lwfinger.net>,
        "s.l-h@gmx.de"
	<s.l-h@gmx.de>,
        "chewitt@libreelec.tv" <chewitt@libreelec.tv>
Subject: RE: [PATCH v3 11/12] wifi: rtlwifi: Add rtl8192du/sw.{c,h}
Thread-Topic: [PATCH v3 11/12] wifi: rtlwifi: Add rtl8192du/sw.{c,h}
Thread-Index: AQHaev7lVhGGoQ4nQ0GxbEPAiHfc3rFCwUMAgAhizQCAANTTI///vigAgAAwEwCAAMUwAIABPbAAgAPR/oCAAO0mAIAJogKAgAFx7VA=
Date: Mon, 8 Apr 2024 02:45:49 +0000
Message-ID: <21299940bf9342ae9c82916084ea7d9e@realtek.com>
References: <7f4b3309-1580-48f3-9426-29f1eb4052fd@gmail.com>
 <2eb79c8c-cf2c-4696-b958-e8d961628e17@gmail.com>
 <f86a40493745a53ff73083f87b3e8fae215eac77.camel@realtek.com>
 <66565618-3638-47e5-afe5-3530214da0c9@gmail.com> <87ttkrzf1m.fsf@kernel.org>
 <5696990a-4450-4d92-bbda-1d9ca3a9a619@gmail.com>
 <4672072ef782ae1200886a190c740e0f3ccec2c8.camel@realtek.com>
 <7873dee1-46a8-48a7-9059-bc300ac98c23@gmail.com>
 <1f8ebed6a04a4fbebf33b0a3edc2f50b@realtek.com>
 <ff3b97d0-118c-42b3-be0b-47cfcf06ab74@gmail.com>
 <7741a59a6ebf4e0f8c55b0f5c3f55a41@realtek.com>
 <321c6855-2e58-48ae-b131-a3f6d7041713@gmail.com>
In-Reply-To: <321c6855-2e58-48ae-b131-a3f6d7041713@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

DQo+IEkgZGlkIG5vdCBjb25zaWRlciB1c2luZyBhIHJlZl9jbnQgdmFyaWFibGUuIEkgbWFkZSB0
aGUgZmlyc3QNCj4gcHJvYmUgYWxsb2NhdGUgdGhlIHRoaW5ncyBhbmQgdGhlIGZpcnN0IGRpc2Nv
bm5lY3QgZnJlZXMgdGhlbToNCg0KVGhlIGFsbG9jYXRpb24gc2VlbXMgZmluZSwgYnV0IEkgZmVl
bCB3ZSBzaG91bGQgZnJlZSBzaGFyZWQgZGF0YSBieSBzZWNvbmQNCmRpc2Nvbm5lY3QgYmVjYXVz
ZSB0aGUgb3RoZXIgaW50ZiBjYW4gc3RpbGwgdXNlIHRoZW0sIG5vPw0KDQo+IA0KPiANCj4gc3Rh
dGljIHN0cnVjdCB1c2JfaW50ZXJmYWNlICpydGw5MmR1X2dldF9vdGhlcl9pbnRmKHN0cnVjdCBp
ZWVlODAyMTFfaHcgKmh3KQ0KPiB7DQo+ICAgICAgICAgc3RydWN0IHVzYl9pbnRlcmZhY2UgKmlu
dGY7DQo+ICAgICAgICAgc3RydWN0IHVzYl9kZXZpY2UgKnVkZXY7DQo+ICAgICAgICAgdTggb3Ro
ZXJfaW50ZXJmYWNlaW5kZXg7DQo+IA0KPiAgICAgICAgIC8qIFNlZSBTRVRfSUVFRTgwMjExX0RF
VihodywgJmludGYtPmRldik7IGluIHVzYi5jICovDQo+ICAgICAgICAgaW50ZiA9IGNvbnRhaW5l
cl9vZl9jb25zdCh3aXBoeV9kZXYoaHctPndpcGh5KSwgc3RydWN0IHVzYl9pbnRlcmZhY2UsIGRl
dik7DQo+IA0KPiAgICAgICAgIG90aGVyX2ludGVyZmFjZWluZGV4ID0gMSAtIGludGYtPmFsdHNl
dHRpbmdbMF0uZGVzYy5iSW50ZXJmYWNlTnVtYmVyOw0KDQpUaGUgdmFsdWUgb2YgYkludGVyZmFj
ZU51bWJlciBmb3IgdHdvIGluc3RhbmNlcyBhcmUgMCBhbmQgMSwgcmlnaHQ/IFRoZW4NCicxIC0g
eCcgdG8gZ2V0IGVhY2ggb3RoZXIgLS0gdGhhdCBsb29rcyBhIGxpdHRsZSB0cmlja3kgOy0pIA0K
DQo+IA0KPiAgICAgICAgIHVkZXYgPSBpbnRlcmZhY2VfdG9fdXNiZGV2KGludGYpOw0KPiANCj4g
ICAgICAgICByZXR1cm4gdXNiX2lmbnVtX3RvX2lmKHVkZXYsIG90aGVyX2ludGVyZmFjZWluZGV4
KTsNCj4gfQ0KPiANCg0KWy4uLl0NCg0KPiANCj4gc3RhdGljIHZvaWQgcnRsOTJkdV9kZWluaXRf
c2hhcmVkX2RhdGEoc3RydWN0IGllZWU4MDIxMV9odyAqaHcpDQo+IHsNCj4gICAgICAgICBzdHJ1
Y3QgdXNiX2ludGVyZmFjZSAqb3RoZXJfaW50ZiA9IHJ0bDkyZHVfZ2V0X290aGVyX2ludGYoaHcp
Ow0KPiAgICAgICAgIHN0cnVjdCBydGxfcHJpdiAqcnRscHJpdiA9IHJ0bF9wcml2KGh3KTsNCj4g
DQo+ICAgICAgICAgaWYgKCFvdGhlcl9pbnRmIHx8IHVzYl9nZXRfaW50ZmRhdGEob3RoZXJfaW50
ZikpIHsNCj4gICAgICAgICAgICAgICAgIC8qIFRoZSBvdGhlciBpbnRlcmZhY2UgZG9lc24ndCBl
eGlzdCBvciB3YXMgbm90IGRpc2Nvbm5lY3RlZCB5ZXQuICovDQoNCkZvciB0aGUgVVNCIGFkYXB0
b3Igd2l0aCBzaW5nbGUgb25lIGludGVyZmFjZSwgeW91IGRvbid0IGhhdmUgb3RoZXJfaW50Zi4N
ClRoZW4sIGp1c3QgZnJlZSB0aGVtLg0KDQpJZiB0aGUgVVNCIGFkYXB0b3IgaGFzIHR3byBpbnRl
cmZhY2VzLCBpdCBoYXMgYm90aCBvdGhlcl9pbnRmIGFuZA0KdXNiX2dldF9pbnRmZGF0YShvdGhl
cl9pbnRmKSwgc28geW91IHdhbnQgdG8gZnJlZSB0aGVtLiBCdXQsIEkgd29uZGVyIGlmIGJvdGgg
DQppbnRlcmZhY2VzIGNhbiBlbnRlciB0aGlzIGJyYW5jaD8NCg0KQWxzbyBhcyBJIG1lbnRpb25l
ZCBhYm92ZSwgaG93IGNhbiB5b3UgZW5zdXJlIG90aGVyX2ludGYgaXNuJ3Qgc3RpbGwgdXNpbmcg
dGhlDQpzaGFyZWQgZGF0YT8NCg0KDQo+ICAgICAgICAgICAgICAgICBrZnJlZShydGxwcml2LT5j
dXJ2ZWluZGV4XzJnKTsNCj4gICAgICAgICAgICAgICAgIGtmcmVlKHJ0bHByaXYtPmN1cnZlaW5k
ZXhfNWcpOw0KPiAgICAgICAgICAgICAgICAgaWYgKHJ0bHByaXYtPm11dGV4X2Zvcl9wb3dlcl9v
bl9vZmYpDQo+ICAgICAgICAgICAgICAgICAgICAgICAgIG11dGV4X2Rlc3Ryb3kocnRscHJpdi0+
bXV0ZXhfZm9yX3Bvd2VyX29uX29mZik7DQo+ICAgICAgICAgICAgICAgICBpZiAocnRscHJpdi0+
bXV0ZXhfZm9yX2h3X2luaXQpDQo+ICAgICAgICAgICAgICAgICAgICAgICAgIG11dGV4X2Rlc3Ry
b3kocnRscHJpdi0+bXV0ZXhfZm9yX2h3X2luaXQpOw0KPiAgICAgICAgICAgICAgICAga2ZyZWUo
cnRscHJpdi0+bXV0ZXhfZm9yX3Bvd2VyX29uX29mZik7DQo+ICAgICAgICAgICAgICAgICBrZnJl
ZShydGxwcml2LT5tdXRleF9mb3JfaHdfaW5pdCk7DQo+ICAgICAgICAgfQ0KPiB9DQo+IA0KDQpb
Li4uXQ0KDQo=

