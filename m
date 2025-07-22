Return-Path: <linux-wireless+bounces-25778-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F782B0D016
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 05:13:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67EE01893C26
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 03:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160D028C009;
	Tue, 22 Jul 2025 03:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="KU9szrnk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8461922ED
	for <linux-wireless@vger.kernel.org>; Tue, 22 Jul 2025 03:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753154022; cv=none; b=jxnqtxAswkwSH3adJF1uAuIezkHKf1ecrpStcI/6H7jqhd1K53PLWcihLVvonXSHitjwFC041dH/tjTjSJ0/ThCuhJYD0zH3vuNqg84SaMnuMZYikxLCaf6FOprS3eqV5q8xdl2+SBe37w9AQYvrPi+HvSXl57nnZlYapiZZatY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753154022; c=relaxed/simple;
	bh=Pr6NTEEJPtcyqHWQmjYXVBr7MwW6K4YFZ6AZes0Df+E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=V4nsbrmbu8hInnBEpgls7T7dhJ2+ZalUKH5S37xiKmiRtfrZl5x/6sW2zw4M2s94ftIWKs7H7xoSIKpsr1jQFXkRmb1aYB7HXWXkvVczkxbBIujCucd+BSbc6lbcysUQB6xi0R/2T0zShYOm2XCCFm4ANjowF5LlmxDrYnK9m3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=KU9szrnk; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 56M3DTSf8255209, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1753154009; bh=Pr6NTEEJPtcyqHWQmjYXVBr7MwW6K4YFZ6AZes0Df+E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=KU9szrnkqwV5W9jER9KtWE2QXe1EpgMx9LrUMgVe1QE8F0mrAoEyq4n7H708zVqxN
	 0uWtGZxUyGkW0nevjDO+PFKkiZESarSBoz2Hbuq3b+FwNgYpMoHb5McuBm5yZGKscZ
	 /yo0CGw31Y3dkcfiAbMcaFCzWgK6Y2PB2QD1CjHQ4iCyzZwYpsLuuvMBogfFD01l6G
	 7iqUmUtVx6Ifls2yskbCbfTW15Pg28Q9qVlnXUyYl+n40NbMSN0nHZhJ2HCtO053Em
	 N6Q0BNItKy70s/rBG/8Sdwn3xeqx0O5Gh51OlPNMIMc5pps8npl9+C6CeA6S8qynv4
	 R2onyUXxMUhgg==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 56M3DTSf8255209
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Jul 2025 11:13:29 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 22 Jul 2025 11:13:29 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 22 Jul 2025 11:13:28 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::81fc:50c6:85d5:cb47]) by
 RTEXMBS04.realtek.com.tw ([fe80::81fc:50c6:85d5:cb47%5]) with mapi id
 15.01.2507.035; Tue, 22 Jul 2025 11:13:28 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: "Berg, Johannes" <johannes.berg@intel.com>
Subject: RE: [PATCH wireless-next v2 1/1] wifi: mac80211: don't require cipher and keylen in gtk rekey
Thread-Topic: [PATCH wireless-next v2 1/1] wifi: mac80211: don't require
 cipher and keylen in gtk rekey
Thread-Index: AQHb+nB2/BAQjh3uPkitHqmUw+fPrLQ9cV6w//9/DwCAAIdYAA==
Date: Tue, 22 Jul 2025 03:13:28 +0000
Message-ID: <6cb91515df024945bcf68a663f824617@realtek.com>
References: <20250721185049.634010-1-miriam.rachel.korenblit@intel.com>
 <20250721214922.3c5c023bfae9.Ie6594ae2b4b6d5b3d536e642b349046ebfce7a5d@changeid>
 <5bb337eb86924d538939b4bb967289a2@realtek.com>
 <DM3PPF63A6024A99A52D871F6B7B060DE66A35CA@DM3PPF63A6024A9.namprd11.prod.outlook.com>
In-Reply-To: <DM3PPF63A6024A99A52D871F6B7B060DE66A35CA@DM3PPF63A6024A9.namprd11.prod.outlook.com>
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

S29yZW5ibGl0LCBNaXJpYW0gUmFjaGVsIDxtaXJpYW0ucmFjaGVsLmtvcmVuYmxpdEBpbnRlbC5j
b20+IHdyb3RlOg0KPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gRnJvbTogUGlu
Zy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+DQo+ID4gU2VudDogVHVlc2RheSwgMjIgSnVs
eSAyMDI1IDU6NTENCj4gPiBUbzogS29yZW5ibGl0LCBNaXJpYW0gUmFjaGVsIDxtaXJpYW0ucmFj
aGVsLmtvcmVuYmxpdEBpbnRlbC5jb20+OyBsaW51eC0NCj4gPiB3aXJlbGVzc0B2Z2VyLmtlcm5l
bC5vcmcNCj4gPiBDYzogQmVyZywgSm9oYW5uZXMgPGpvaGFubmVzLmJlcmdAaW50ZWwuY29tPg0K
PiA+IFN1YmplY3Q6IFJFOiBbUEFUQ0ggd2lyZWxlc3MtbmV4dCB2MiAxLzFdIHdpZmk6IG1hYzgw
MjExOiBkb24ndCByZXF1aXJlIGNpcGhlcg0KPiA+IGFuZCBrZXlsZW4gaW4gZ3RrIHJla2V5DQo+
ID4NCj4gPg0KPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsv
cnR3ODkvd293LmMNCj4gPiA+IGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OS93
b3cuYw0KPiA+ID4gaW5kZXggMDcxYzc1NzdkZjUyLi41YmI3YzFhNDJmMWQgMTAwNjQ0DQo+ID4g
PiAtLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg5L3dvdy5jDQo+ID4gPiAr
KysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg5L3dvdy5jDQo+ID4gPiBAQCAt
NjE5LDkgKzYxOSwxMiBAQCBzdGF0aWMgc3RydWN0IGllZWU4MDIxMV9rZXlfY29uZg0KPiA+ICpy
dHc4OV93b3dfZ3RrX3Jla2V5KHN0cnVjdCBydHc4OV9kZXYgKnJ0d2RldiwNCj4gPiA+ICAgICAg
ICAgICAgICAgIGZsZXhfYXJyYXlfc2l6ZShyZWtleV9jb25mLCBrZXksIGNpcGhlcl9pbmZvLT5s
ZW4pKTsNCj4gPiA+DQo+ID4gPiAgICAgICAgIGlmIChpZWVlODAyMTFfdmlmX2lzX21sZCh3b3df
dmlmKSkNCj4gPiA+IC0gICAgICAgICAgICAgICBrZXkgPSBpZWVlODAyMTFfZ3RrX3Jla2V5X2Fk
ZCh3b3dfdmlmLCByZWtleV9jb25mLCBydHd2aWZfbGluay0NCj4gPiA+bGlua19pZCk7DQo+ID4g
PiArICAgICAgICAgICAgICAga2V5ID0gaWVlZTgwMjExX2d0a19yZWtleV9hZGQod293X3ZpZiwg
a2V5aWR4LCBndGssDQo+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgY2lwaGVyX2luZm8tPmxlbiwNCj4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBydHd2aWZfbGluay0+bGlua19pZCk7DQo+ID4gPiAgICAg
ICAgIGVsc2UNCj4gPiA+IC0gICAgICAgICAgICAgICBrZXkgPSBpZWVlODAyMTFfZ3RrX3Jla2V5
X2FkZCh3b3dfdmlmLCByZWtleV9jb25mLCAtMSk7DQo+ID4gPiArICAgICAgICAgICAgICAga2V5
ID0gaWVlZTgwMjExX2d0a19yZWtleV9hZGQod293X3ZpZiwga2V5aWR4LCBndGssDQo+ID4gPiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY2lwaGVyX2luZm8t
PmxlbiwgLTEpOw0KPiA+ID4NCj4gPiA+ICAgICAgICAga2ZyZWUocmVrZXlfY29uZik7DQo+ID4N
Cj4gPiBGb3IgdGhlIHJ0dzg5IHBhcnQsIHRoZSBsb2NhbCBhbGxvY2F0ZS9mcmVlIGluc3RhbmNl
IG9mIHJla2V5X2NvbmYgaXNuJ3QgdXNlZA0KPiA+IGFueW1vcmUuIFBsZWFzZSByZW1vdmUgaXQg
YnkgdGhlIHdheS4NCj4gDQo+IEpvaGFubmVzIGFza2VkIG1lIG5vdCB0byBkbyBtdWNoIGRyaXZl
ciBjbGVhbnVwcyBhbmQgaGF2ZSB0aGlzIGNvbW1pdCBzbWFsbCBhcyBwb3NzaWJsZSB3cnQgdG8g
ZHJpdmVyIGNoYW5nZXMuDQo+IFRoaXMgcGF0Y2ggaXMgb25seSB0byBtYWtlIHRoaW5ncyB3b3Jr
LiBDbGVhbnVwcyBjYW4gYmUgZG9uZSBsYXRlci4NCg0KVW5kZXJzdG9vZC4gWW91IG9yIEkgY2Fu
IGRvIGl0IGFmdGVyd2FyZC4gDQoNCj4gSm9oYW5uZXMsIHVubGVzcyB5b3UgY29uc2lkZXIgdGhp
cyBjbGVhbnVwIHNtYWxsIGVub3VnaD8NCj4gDQo+ID4NCj4gPiA+ICAgICAgICAgaWYgKElTX0VS
UihrZXkpKSB7DQo+ID4NCg0K

