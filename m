Return-Path: <linux-wireless+bounces-3185-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 997EB84ABDD
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Feb 2024 03:02:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2B272856AB
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Feb 2024 02:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A0956759;
	Tue,  6 Feb 2024 02:02:53 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36DE56755;
	Tue,  6 Feb 2024 02:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707184973; cv=none; b=CNQNbxcpqEwkagrqrNeizDeYdeCk1qJpiAVhfXigtPR1ullPoXa9JVQJuc3/4Mf2xGVzqgmFWjTSOwqcq5xxDz7sOgg40vjc+hCDy8ydZSkt5HxYTa9BBZUumxEdeL2FgxjrJhcDKx3q9tLCjPftrD2EMMGJPedhMmANHGGDgss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707184973; c=relaxed/simple;
	bh=IT1fSmsBpetvl9lLGOXp9H1QuCKH6m1U+7Sq9GTU4C8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hkuK20TWsrU7QEjQcUK+4jUzVs/w4ONlVTWWnPIy9EnC3/hh5/P1XscCEuhx6DodqgAukrgG0UYW/SDoPWr2pCBQY1wB9vnspLJSpPAjdd9mm5rwwx4V8aVrBPJ4+j7xIatLJhxS1WvgOPI+YSRYLLIGfIN3tVvQdUT/DApLtV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 41622F8903493350, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 41622F8903493350
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 6 Feb 2024 10:02:16 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.17; Tue, 6 Feb 2024 10:02:15 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 6 Feb 2024 10:02:15 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f]) by
 RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f%7]) with mapi id
 15.01.2507.035; Tue, 6 Feb 2024 10:02:15 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Fiona Klute <fiona.klute@gmx.de>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
CC: Kalle Valo <kvalo@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Pavel Machek
	<pavel@ucw.cz>,
        =?utf-8?B?T25kxZllaiBKaXJtYW4=?= <megi@xff.cz>
Subject: RE: [PATCH 4/9] wifi: rtw88: Add rtw8703b.h
Thread-Topic: [PATCH 4/9] wifi: rtw88: Add rtw8703b.h
Thread-Index: AQHaVdEBnjIVXUjW50myYkvW9x3LeLD7B6VggAD4vYCAAI5ccA==
Date: Tue, 6 Feb 2024 02:02:14 +0000
Message-ID: <3424c26db8f24219bec0afd105b4864e@realtek.com>
References: <20240202121050.977223-1-fiona.klute@gmx.de>
 <20240202121050.977223-5-fiona.klute@gmx.de>
 <64e338d9e0dd43e69fa2e6e1dd3ecb2c@realtek.com>
 <d122d08d-b364-449c-a959-3f40597b2e8e@gmx.de>
In-Reply-To: <d122d08d-b364-449c-a959-3f40597b2e8e@gmx.de>
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRmlvbmEgS2x1dGUgPGZp
b25hLmtsdXRlQGdteC5kZT4NCj4gU2VudDogVHVlc2RheSwgRmVicnVhcnkgNiwgMjAyNCA5OjA5
IEFNDQo+IFRvOiBQaW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT47IGxpbnV4LXdpcmVs
ZXNzQHZnZXIua2VybmVsLm9yZw0KPiBDYzogS2FsbGUgVmFsbyA8a3ZhbG9Aa2VybmVsLm9yZz47
IFVsZiBIYW5zc29uIDx1bGYuaGFuc3NvbkBsaW5hcm8ub3JnPjsgbGludXgtbW1jQHZnZXIua2Vy
bmVsLm9yZzsgUGF2ZWwNCj4gTWFjaGVrIDxwYXZlbEB1Y3cuY3o+OyBPbmTFmWVqIEppcm1hbiA8
bWVnaUB4ZmYuY3o+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggNC85XSB3aWZpOiBydHc4ODogQWRk
IHJ0dzg3MDNiLmgNCj4gDQo+IEFtIDA1LjAyLjI0IHVtIDAzOjI0IHNjaHJpZWIgUGluZy1LZSBT
aGloOg0KPiA+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+PiBGcm9tOiBGaW9uYSBL
bHV0ZSA8ZmlvbmEua2x1dGVAZ214LmRlPg0KPiA+PiBTZW50OiBGcmlkYXksIEZlYnJ1YXJ5IDIs
IDIwMjQgODoxMSBQTQ0KPiA+PiBUbzogbGludXgtd2lyZWxlc3NAdmdlci5rZXJuZWwub3JnOyBQ
aW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT4NCj4gPj4gQ2M6IEthbGxlIFZhbG8gPGt2
YWxvQGtlcm5lbC5vcmc+OyBVbGYgSGFuc3NvbiA8dWxmLmhhbnNzb25AbGluYXJvLm9yZz47IGxp
bnV4LW1tY0B2Z2VyLmtlcm5lbC5vcmc7DQo+IFBhdmVsDQo+ID4+IE1hY2hlayA8cGF2ZWxAdWN3
LmN6PjsgT25kxZllaiBKaXJtYW4gPG1lZ2lAeGZmLmN6PjsgRmlvbmEgS2x1dGUgPGZpb25hLmts
dXRlQGdteC5kZT4NCj4gPj4gU3ViamVjdDogW1BBVENIIDQvOV0gd2lmaTogcnR3ODg6IEFkZCBy
dHc4NzAzYi5oDQo+ID4+DQo+ID4+IFRoaXMgaXMgdGhlIG1haW4gaGVhZGVyIGZvciB0aGUgbmV3
IHJ0dzg4Xzg3MDNiIGNoaXAgZHJpdmVyLg0KPiA+Pg0KPiA+PiBTaWduZWQtb2ZmLWJ5OiBGaW9u
YSBLbHV0ZSA8ZmlvbmEua2x1dGVAZ214LmRlPg0KPiA+PiAtLS0NCj4gPj4gICBkcml2ZXJzL25l
dC93aXJlbGVzcy9yZWFsdGVrL3J0dzg4L3J0dzg3MDNiLmggfCA2MiArKysrKysrKysrKysrKysr
KysrDQo+ID4+ICAgMSBmaWxlIGNoYW5nZWQsIDYyIGluc2VydGlvbnMoKykNCj4gPj4gICBjcmVh
dGUgbW9kZSAxMDA2NDQgZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OC9ydHc4NzAz
Yi5oDQo+ID4+DQo+ID4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVr
L3J0dzg4L3J0dzg3MDNiLmgNCj4gPj4gYi9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0
dzg4L3J0dzg3MDNiLmgNCj4gPj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gPj4gaW5kZXggMDAw
MDAwMDAwMC4uZjVmZjIzZjJlZQ0KPiA+PiAtLS0gL2Rldi9udWxsDQo+ID4+ICsrKyBiL2RyaXZl
cnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODgvcnR3ODcwM2IuaA0KPiA+PiBAQCAtMCwwICsx
LDYyIEBADQo+ID4+ICsvKiBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMCBPUiBCU0Qt
My1DbGF1c2UgKi8NCj4gPj4gKy8qIENvcHlyaWdodCBGaW9uYSBLbHV0ZSA8ZmlvbmEua2x1dGVA
Z214LmRlPiAqLw0KPiA+PiArDQo+ID4+ICsjaWZuZGVmIF9fUlRXODcwM0JfSF9fDQo+ID4+ICsj
ZGVmaW5lIF9fUlRXODcwM0JfSF9fDQo+ID4+ICsNCj4gPj4gK2V4dGVybiBjb25zdCBzdHJ1Y3Qg
cnR3X2NoaXBfaW5mbyBydHc4NzAzYl9od19zcGVjOw0KPiA+PiArDQo+ID4+ICsvKiBwaHkgc3Rh
dHVzIHBhcnNpbmcgKi8NCj4gPj4gKyNkZWZpbmUgR0VUX1BIWV9TVEFUX0FHQ19HQUlOX0EocGh5
X3N0YXQpICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcDQo+ID4+ICsgICAgICAg
KGxlMzJfZ2V0X2JpdHMoKigoX19sZTMyICopKHBoeV9zdGF0KSArIDB4MDApLCBHRU5NQVNLKDYs
IDApKSkNCj4gPg0KPiA+IFdlIGFyZSBwbGFubmluZyB0byB1c2Ugc3RydWN0IGFuZCBsZTMyX2dl
dF9iaXRzKCkgZGlyZWN0bHksIHNvIGRvbid0IGludHJvZHVjZQ0KPiA+IHRoaXMgb2xkIHN0eWxl
IGFueW1vcmUuIEFuIGV4YW1wbGUgaXMNCj4gPg0KPiA+IHN0cnVjdCBydHc4NzAzYl9waHlfc3Rh
dCB7DQo+ID4gICAgICAgX19sZTMyIHcwOw0KPiA+ICAgICAgIF9fbGUzMiB3MTsNCj4gPiAgICAg
ICAuLi4NCj4gPiB9Ow0KPiA+DQo+ID4gI2RlZmluZSBSVFc4NzAzQl9QSFlfU1RBVF9XMF9BR0Nf
R0FJTl9BIEdFTk1BU0soNiwgMCkNCj4gPg0KPiA+IHZhbF9zOCA9IGxlMzJfZ2V0X2JpdHMoc3Rh
dC0+dzAsIFJUVzg3MDNCX1BIWV9TVEFUX1cwX0FHQ19HQUlOX0EpOw0KPiANCj4gU29ycnksIG9m
IGFsbCB5b3VyIG1haWxzIHRoaXMgb25lIGdvdCBzdHVjayBpbiB0aGUgc3BhbSBmaWx0ZXIuIFRo
aXMNCj4gYW5zd2VycyBteSBxdWVzdGlvbiBhYm91dCB3aGF0IHlvdSBtZWFudCBieSBzdHJ1Y3Qg
c3R5bGUsIEkgaGFkbid0DQo+IHRob3VnaHQgb2YgdXNpbmcgX19sZSB0eXBlcy4gSSBhc3N1bWUg
eW91J2Qgc3RpbGwgd2FudCB0byB1c2UNCj4gYXBwcm9wcmlhdGVseSBzaXplZCB0eXBlcy9hcnJh
eXMgZm9yIGVsZW1lbnRzIHRoYXQgYXJlIG11bHRpcGxlcyBvZiBvbmUNCj4gYnl0ZT8NCg0KTm90
IHN1cmUgIm11bHRpcGxlcyBvZiBvbmUgYnl0ZSIgbWVhbnMuIEkgZ3Vlc3MgeW91IHdhbnQgdG8g
dXNlIHNvbWV0aGluZyBsaWtlDQp1OCBvciBfX2xlMTYgZm9yIHRoZSBlbGVtZW50cyB0aGF0IGFy
ZW4ndCByZXF1aXJlZCBiaXQgYWNjZXNzLCByaWdodD8gDQpJJ2Qgc2F5IGl0IGlzIGhhcmQgdG8g
ZGVmaW5lIHNpbmdsZSBvbmUgcnVsZSBmb3IgYWxsIGNhc2VzLiANCg0KRXhhbXBsZSAxLTEgKGZh
a2UpOiANCnN0cnVjdCBydHc4NzAzYl9waHlfc3RhdCB7DQoJdTggbWFjX2lkOw0KCXU4IHJzc2k7
DQoJdTggZXZtOw0KCXU4IGV2bV8yOw0KCS4uLg0KfSBfX3BhY2tlZDsNCg0KRXhhbXBsZSAxLTIg
KGZha2UpOiANCnN0cnVjdCBydHc4NzAzYl9waHlfc3RhdCB7DQoJX19sZTMyIHcwOw0KCS4uLg0K
fSBfX3BhY2tlZDsNCg0KI2RlZmluZSBQSFlfU1RBVF9XMF9NQUNJRCBHRU5NQVNLKDcsIDApDQoj
ZGVmaW5lIFBIWV9TVEFUX1cwX1JTU0kgR0VOTUFTSygxNSwgOCkNCiNkZWZpbmUgUEhZX1NUQVRf
VzBfRVZNIEdFTk1BU0soMjMsIDE2KQ0KI2RlZmluZSBQSFlfU1RBVF9XMF9FVk1fMiBHRU5NQVNL
KDMxLDI0KQ0KDQpJdCBpcyBjbGVhciB0aGF0IGV4YW1wbGUgMS0xIGlzIGJldHRlciB0aGFuIDEt
Mi4gDQoNCkV4YW1wbGUgMi0xIChmYWtlKTogDQpzdHJ1Y3QgcnR3ODcwM2JfcGh5X3N0YXQgew0K
CXU4IG1hY19pZDsNCgl1OCByc3NpOw0KCV9fbGUxNiBwaHlfc3Q7CQkvLyBldm06IDcsIGV2bV8y
OiA3LCByc3ZkIDoyDQoJLi4uDQp9IF9fcGFja2VkOw0KDQojZGVmaW5lIFBIWV9TVF9FVk0gR0VO
TUFTSyg2LCAwKQ0KI2RlZmluZSBQSFlfU1RfRVZNXzIgR0VOTUFTSygxMywgNykNCg0KDQpFeGFt
cGxlIDItMiAoZmFrZSk6IA0Kc3RydWN0IHJ0dzg3MDNiX3BoeV9zdGF0IHsNCglfX2xlMzIgdzA7
DQoJLi4uDQp9IF9fcGFja2VkOw0KDQojZGVmaW5lIFBIWV9TVEFUX1cwX01BQ0lEIEdFTk1BU0so
NywgMCkNCiNkZWZpbmUgUEhZX1NUQVRfVzBfUlNTSSBHRU5NQVNLKDE1LCA4KQ0KI2RlZmluZSBQ
SFlfU1RBVF9XMF9FVk0gR0VOTUFTSygyMiwgMTYpDQojZGVmaW5lIFBIWV9TVEFUX1cwX0VWTV8y
IEdFTk1BU0soMjksIDIzKQ0KDQoNCkNvbXBhcmUgMi0xIGFuZCAyLTIsIGl0IHdvdWxkIGJlIGhh
cmQgdG8gc2F5IHdoaWNoIG9uZSBpcyBiZXR0ZXIsIGJlY2F1c2UgMi0xDQptaXhlcyB1OCBhbmQg
Yml0IGZpZWxkLiBUaGlzIGlzIGp1c3QgYSBzaW1wbGUgZXhhbXBsZSwgZmllbGRzIG9mIHJlYWwg
c3RydWN0DQphcmUgbXVjaCBtb3JlLCBzbyBub3JtYWxseSBJIHVzZSAxLTIgYW5kIDItMiBzdHls
ZXMuIA0KDQo=

