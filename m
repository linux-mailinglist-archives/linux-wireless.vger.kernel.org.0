Return-Path: <linux-wireless+bounces-21176-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC53A7D159
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Apr 2025 02:49:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FEEE3ABC56
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Apr 2025 00:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFB2A7482;
	Mon,  7 Apr 2025 00:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="F/YUJfEH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50CB76FBF
	for <linux-wireless@vger.kernel.org>; Mon,  7 Apr 2025 00:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743986971; cv=none; b=bjEpse1tVFl6QXIknSy26fsHUDwmJ5gtfykmWlUyGdTpitcol7E0yQW9vyCrai1hdzXFWSoY6XPHA+OhisZTTYrvQPgOTzruOVkP7w9yq/Pk9hkDC48TAZNsRfSAuPXujF0P8G5wuVszEvHkCJ0Rt3E65NBCCffTpCHbqzEKi9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743986971; c=relaxed/simple;
	bh=WuDRoocAH+OjH8D1BLfGxV7n4ZBUaDnw5c3ohPGqGlQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NO4UUz1y3aIh9aRKovGpuaGvU40n7qjxGK2JFG/k6KxaefgORfzhyksbI6++sPiaLx7t0hKVKtn0ouQBA6Olp+z6s3kI8+zOOGfU676lf7aQ5z5xG5orUgGOPCJSaK+DkcOJzvG+9jrmZVSwTjnpYJNH6bkWdSJ7+oa+iV3jEac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=F/YUJfEH; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 5370mLJh9176482, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1743986901; bh=WuDRoocAH+OjH8D1BLfGxV7n4ZBUaDnw5c3ohPGqGlQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=F/YUJfEH4E0hXvlJVmTVk9rdrtxLFjn4cquaUpAG4vJUmem6n/8J1fobF3w6G4i6B
	 fdxmhEmUmEoy7Dp0Kp14hs74M4aX2NivUDn+BAknsecbMAXQppc2GzSdzhUUArpv4m
	 uYQjo9vGv5zqfi93b9udzy76fwJYvoFAOLXo12PxX6d4+wDid32QMpHcyr1OkvHdD7
	 eAQF1AInfuRgY7QFViARI0WJoXOrPC9xeE7zrhX8CNdq5WM2HemczRVQbePfmjUKGD
	 QlUOs5jn+yzAtt0gx2uv6eWB854GbL8hVv0ZozxhBAC6ztkM2xrm1kwTBU3pQ13o8X
	 W+SvvBL/Mis5w==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 5370mLJh9176482
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 7 Apr 2025 08:48:21 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 7 Apr 2025 08:48:21 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 7 Apr 2025 08:48:21 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Mon, 7 Apr 2025 08:48:21 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ben Greear <greearb@candelatech.com>,
        Shayne Chen
	<shayne.chen@mediatek.com>, Felix Fietkau <nbd@nbd.name>
CC: linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi
	<lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai
	<evelyn.tsai@mediatek.com>,
        linux-mediatek
	<linux-mediatek@lists.infradead.org>,
        StanleyYP Wang
	<StanleyYP.Wang@mediatek.com>
Subject: RE: [PATCH 09/10] wifi: mt76: mt7996: rework background radar check for mt7990
Thread-Topic: [PATCH 09/10] wifi: mt76: mt7996: rework background radar check
 for mt7990
Thread-Index: AQHbn6XvD6dY9NzS8E2HfbUbQJUEZrOMwhhggAGRpICAAUkWMIAAZ2CAgAdlF4A=
Date: Mon, 7 Apr 2025 00:48:20 +0000
Message-ID: <4c649510a1604fc49d32bea37f3ed9b6@realtek.com>
References: <20250328055058.1648755-1-shayne.chen@mediatek.com>
 <20250328055058.1648755-10-shayne.chen@mediatek.com>
 <59abf964667144b0ab10220e41b6b821@realtek.com>
 <29344a3f054368ae948415d6183365a09d1fe6d5.camel@mediatek.com>
 <44832c3d3a74429aaa095bdba4573391@realtek.com>
 <90f222c1-518d-90a2-6ae5-47cb13692c8b@candelatech.com>
In-Reply-To: <90f222c1-518d-90a2-6ae5-47cb13692c8b@candelatech.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS02.realtek.com.tw, 9
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

QmVuIEdyZWVhciA8Z3JlZWFyYkBjYW5kZWxhdGVjaC5jb20+IHdyb3RlOg0KPiANCj4gT24gNC8x
LzI1IDE4OjMwLCBQaW5nLUtlIFNoaWggd3JvdGU6DQo+ID4gU2hheW5lIENoZW4gPHNoYXluZS5j
aGVuQG1lZGlhdGVrLmNvbT4gd3JvdGU6DQo+ID4NCj4gPj4gT24gTW9uLCAyMDI1LTAzLTMxIGF0
IDA1OjU1ICswMDAwLCBQaW5nLUtlIFNoaWggd3JvdGU6DQo+ID4+Pg0KPiA+Pj4NCj4gPj4+IFNo
YXluZSBDaGVuIDxzaGF5bmUuY2hlbkBtZWRpYXRlay5jb20+IHdyb3RlOg0KPiA+Pj4NCj4gPj4+
IFsuLi5dDQo+ID4+Pg0KPiA+Pj4+ICsNCj4gPj4+PiArYm9vbCBtdDc5OTZfZWVwcm9tX2hhc19i
YWNrZ3JvdW5kX3JhZGFyKHN0cnVjdCBtdDc5OTZfZGV2ICpkZXYpDQo+ID4+Pj4gK3sNCj4gPj4+
PiArICAgICAgIHN3aXRjaCAobXQ3Nl9jaGlwKCZkZXYtPm10NzYpKSB7DQo+ID4+Pj4gKyAgICAg
ICBjYXNlIE1UNzk5Nl9ERVZJQ0VfSUQ6DQo+ID4+Pj4gKyAgICAgICAgICAgICAgIGlmIChkZXYt
PnZhci50eXBlID09IE1UNzk5Nl9WQVJfVFlQRV8yMzMpDQo+ID4+Pj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgcmV0dXJuIGZhbHNlOw0KPiA+Pj4+ICsgICAgICAgICAgICAgICBicmVhazsNCj4g
Pj4+PiArICAgICAgIGNhc2UgTVQ3OTkyX0RFVklDRV9JRDoNCj4gPj4+PiArICAgICAgICAgICAg
ICAgaWYgKGRldi0+dmFyLnR5cGUgPT0gTVQ3OTkyX1ZBUl9UWVBFXzIzKQ0KPiA+Pj4+ICsgICAg
ICAgICAgICAgICAgICAgICAgIHJldHVybiBmYWxzZTsNCj4gPj4+PiArICAgICAgICAgICAgICAg
YnJlYWs7DQo+ID4+Pj4gKyAgICAgICBjYXNlIE1UNzk5MF9ERVZJQ0VfSUQ6IHsNCj4gPj4+PiAr
ICAgICAgICAgICAgICAgdTggcGF0aCwgcnhfcGF0aCwgbnNzLCAqZWVwcm9tID0gZGV2LQ0KPiA+
Pj4+PiBtdDc2LmVlcHJvbS5kYXRhOw0KPiA+Pj4+ICsNCj4gPj4+PiArICAgICAgICAgICAgICAg
bXQ3OTk2X2VlcHJvbV9wYXJzZV9zdHJlYW0oZWVwcm9tLCBNVF9CQU5EMSwgJnBhdGgsDQo+ID4+
Pj4gJnJ4X3BhdGgsICZuc3MpOw0KPiA+Pj4+ICsgICAgICAgICAgICAgICAvKiBEaXNhYmxlIGJh
Y2tncm91bmQgcmFkYXIgY2FwYWJpbGl0eSBpbiAzVDNSICovDQo+ID4+Pj4gKyAgICAgICAgICAg
ICAgIGlmIChwYXRoID09IDMgfHwgcnhfcGF0aCA9PSAzKQ0KPiA+Pj4+ICsgICAgICAgICAgICAg
ICAgICAgICAgIHJldHVybiBmYWxzZTsNCj4gPj4+PiArICAgICAgICAgICAgICAgYnJlYWs7DQo+
ID4+Pj4gKyAgICAgICB9DQo+ID4+Pg0KPiA+Pj4gVGhlIGluZGVudGF0aW9uIG9mIGNsb3NlIGJy
YWNlIGxvb2tzIHdlaXJkLg0KPiA+Pg0KPiA+PiBXaWxsIGZpeCBpdCwgdGhhbmtzLg0KPiA+Pj4N
Cj4gPj4+IFNpbmNlIC1XZGVjbGFyYXRpb24tYWZ0ZXItc3RhdGVtZW50IGlzIGRyb3BwZWQsIEkg
dGhpbmsgY29tcGlsZXJzDQo+ID4+PiB3aWxsIG5vdA0KPiA+Pj4gd2FybiB3aXRob3V0IHRoZSBi
cmFjZXMuIEJ1dCBub3RlIHRoYXQgaXQgaXMgc3RpbGwgbm90IHJlY29tbWVuZGVkIHRvDQo+ID4+
PiBwdXQgZGVjbGFyYXRpb25zIGluIHRoZSBtaWRkbGUuDQo+ID4+Pg0KPiA+PiBTaW5jZSB0aG9z
ZSB2YXJpYWJsZXMgYXJlIGN1cnJlbnRseSBvbmx5IHVzZWQgYnkgbXQ3OTkwIGNhc2UsIEkgdGhp
bmsNCj4gPj4gdGhleSBjYW4gYmUgcHV0dGluZyB0aGVyZSBmb3IgdGhlIG1vbWVudC4NCj4gPg0K
PiA+IFRoYXQgbG9va3Mgbm90IHZlcnkgbmF0dXJhbCB0aG91Z2guLi4NCj4gPg0KPiA+IEluIGZh
Y3QsIHRoZSBkZWNsYXJhdGlvbnMgZWl0aGVyIGluIGJlZ2lubmluZyBvZiB0aGlzIGZ1bmN0aW9u
IG9yIGF0IHRoZQ0KPiA+IG10Nzk5MCBjYXNlLCB0aGUgZnJhbWUgc2l6ZSAoc3RhY2spIGFyZSB0
aGUgc2FtZS4NCj4gDQo+IFRoZSBvcGVuIHBhcmVucyBtYWtlIGl0IHRoZSBzdGFydCBvZiBhIG5l
dyBjb2RlIGJsb2NrLCBzbyBldmVuIHN0cmljdA0KPiBvbGQgYyBjb21waWxlcnMgc2hvdWxkIGhh
bmRsZSB0aGlzIGp1c3QgZmluZSwgYW5kIEkgcGVyc29uYWxseSBsaWtlDQo+IHZhcmlhYmxlcyBr
ZXB0IHRvIGEgdGlnaHQgbG9jYWwgc2NvcGUgaWYgcG9zc2libGUuICBVbmxlc3MgdGhlcmUgaXMg
YQ0KPiB0ZWNobmljYWwgcmVhc29uIHRvIGNoYW5nZSB0aGUgY29kZSwgdGhlbiB0aGVyZSBhcmUg
cHJvYmFibHkgbW9yZSBpbXBvcnRhbnQNCj4gdGhpbmdzIHRvIHdvcnJ5IGFib3V0Lg0KDQpVbmRl
cnN0b29kLiANCg0KSSBqdXN0IHdhbnRlZCB0byBtZW50aW9uZWQgd2VpcmQgYnJhY2Ugc3R5bGVz
IGluIHN3aXRjaC1jYXNlLiBJdCBsb29rcyBsaWtlDQpubyB1bmlmb3JtIHN0eWxlLCBidXQgbWFu
eSBzdHlsZXMgaW1wbGVtZW50ZWQgaW4gd2lyZWxlc3MgZHJpdmVycy4gTm90IHN1cmUNCndoaWNo
IG9uZSBpcyBwcmVmZXJyZWQuIA0KDQpzdHlsZSAoQSkgLSBjbG9zZSBicmFjZSBhbGlnbiAnY2Fz
ZScNCiAgICAgICAgc3dpdGNoIChmb28pIHsNCiAgICAgICAgY2FzZSBBOg0KICAgICAgICAgICAg
ICAgIC4uLg0KICAgICAgICBjYXNlIEI6IHsNCiAgICAgICAgICAgICAgICAuLi4NCiAgICAgICAg
ICAgICAgICBicmVhazsNCiAgICAgICAgfQ0KICAgICAgICBkZWZhdWx0Og0KICAgICAgICAgICAg
ICAgIGJyZWFrOw0KICAgICAgICB9DQoNCnN0eWxlIChCKSAtIGNsb3NlIGJyYWNlIHdpdGggaW5k
ZW50YXRpb24gDQogICAgICAgIHN3aXRjaCAoZm9vKSB7DQogICAgICAgIGNhc2UgQToNCiAgICAg
ICAgICAgICAgICAuLi4NCiAgICAgICAgY2FzZSBCOiB7DQogICAgICAgICAgICAgICAgLi4uDQog
ICAgICAgICAgICAgICAgYnJlYWs7DQogICAgICAgICAgICAgICAgfQ0KICAgICAgICBkZWZhdWx0
Og0KICAgICAgICAgICAgICAgIGJyZWFrOw0KICAgICAgICB9DQoNCnN0eWxlIChDKSAtIGxpa2Ug
KEIpLCBidXQgJ2JyZWFrJyBvdXRzaWRlIG9mIGJyYWNlLiANCiAgICAgICAgc3dpdGNoIChmb28p
IHsNCiAgICAgICAgY2FzZSBBOg0KICAgICAgICAgICAgICAgIC4uLg0KICAgICAgICBjYXNlIEI6
IHsNCiAgICAgICAgICAgICAgICAuLi4NCiAgICAgICAgICAgICAgICB9DQogICAgICAgICAgICAg
ICAgYnJlYWs7DQogICAgICAgIGRlZmF1bHQ6DQogICAgICAgICAgICAgICAgYnJlYWs7DQogICAg
ICAgIH0NCg0K

