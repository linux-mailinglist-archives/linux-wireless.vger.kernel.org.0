Return-Path: <linux-wireless+bounces-21043-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 578FAA7861F
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Apr 2025 03:25:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 881653AF80A
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Apr 2025 01:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C59463FC7;
	Wed,  2 Apr 2025 01:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="qELfnvvM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7B63C17
	for <linux-wireless@vger.kernel.org>; Wed,  2 Apr 2025 01:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743557124; cv=none; b=Hz2m5u87t0mlzZnxjK67zoQupp4RETpkZGHwryAq3XuyqOz260/5yX/PZyWgiwC7ZZP/wWfYwxSp9RyosWlTrEcY/0OeqcjpknG1rRXOGOfL/+IJLaY8rllaCZ08vRGAqONOJZAZRiYRo76U4A96VFFQQKnooECg+M9Ohzs9xw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743557124; c=relaxed/simple;
	bh=ZNtfz6fYBMRdgX3iJrvbDFKgpPGzSQuMCe6lO7RswvE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aYfwMJCtvsQe6QVRYpzP8gQ1lU4gI+AiOcQU39sDIxywWAF/W+U1atRa5UaForIt0eSIrCKYVE0yDk/cJnwalbkMSgLg2tV2K0z9WUeqpyAdRqAScznLYTaYZhaxplFPk/Puoz3gnLTYmocTMdzaIgVu55Ox5ctOhqnN5Rq0HVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=qELfnvvM; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 5321ONBC03306897, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1743557063; bh=ZNtfz6fYBMRdgX3iJrvbDFKgpPGzSQuMCe6lO7RswvE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=qELfnvvM87uh+V/491f1tFtUD6kma33OijxWZUmTFc6wYuJ66QSNJQfk2zHXGGKOR
	 rgPlmifDMw/1WQrhRls75g67SQEctl10qbxam//dYk0V+Fs8h2J3RTYFHL4pSdCiHh
	 lLRV5qv+Ol7yLhtPZVGJIVY+k4nhsDOa97I+xs4bK8FG9oldltnSdfZHkMply5rWQT
	 RdWfu1IdcYhmYqkco/8qJQ3Gj4R0bC/BS+Sxojwjaj/doUnEFfliR5LxCrEjQJQ10Q
	 ASZWzhhKzC9oO87liNHjPvtUtmlJS3lcWFfu72I2q19n2dQKfLABsbH5NetxnAvkRj
	 QwgX8WGQDQhqg==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 5321ONBC03306897
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 2 Apr 2025 09:24:23 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 2 Apr 2025 09:24:24 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 2 Apr 2025 09:24:23 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Wed, 2 Apr 2025 09:24:23 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Shayne Chen <shayne.chen@mediatek.com>, Felix Fietkau <nbd@nbd.name>
CC: linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi
	<lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai
	<evelyn.tsai@mediatek.com>,
        linux-mediatek
	<linux-mediatek@lists.infradead.org>,
        StanleyYP Wang
	<StanleyYP.Wang@mediatek.com>,
        Peter Chiu <chui-hao.chiu@mediatek.com>
Subject: RE: [PATCH 02/10] wifi: mt76: connac: add support to load firmware for mt7990
Thread-Topic: [PATCH 02/10] wifi: mt76: connac: add support to load firmware
 for mt7990
Thread-Index: AQHbn6Xg03cjcDOIHkCak0I8sGEc67OMrjLggAGfi4CAAUtj8A==
Date: Wed, 2 Apr 2025 01:24:23 +0000
Message-ID: <d02bc733283c44afa580e9f02189012b@realtek.com>
References: <20250328055058.1648755-1-shayne.chen@mediatek.com>
	 <20250328055058.1648755-3-shayne.chen@mediatek.com>
	 <7ec7c486728d490caef7dcdac3c1c8e4@realtek.com>
 <2cb3376205353e98384ca8faa4454fa0511d47b5.camel@mediatek.com>
In-Reply-To: <2cb3376205353e98384ca8faa4454fa0511d47b5.camel@mediatek.com>
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

U2hheW5lIENoZW4gPHNoYXluZS5jaGVuQG1lZGlhdGVrLmNvbT4gd3JvdGU6DQo+IA0KPiBIaSBQ
aW5nLUtlLA0KPiANCj4gT24gTW9uLCAyMDI1LTAzLTMxIGF0IDA0OjQwICswMDAwLCBQaW5nLUtl
IFNoaWggd3JvdGU6DQo+ID4NCj4gPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xp
Y2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bnRpbA0KPiA+IHlvdSBoYXZlIHZlcmlmaWVk
IHRoZSBzZW5kZXIgb3IgdGhlIGNvbnRlbnQuDQo+ID4NCj4gPg0KPiA+IFNoYXluZSBDaGVuIDxz
aGF5bmUuY2hlbkBtZWRpYXRlay5jb20+IHdyb3RlOg0KPiA+ID4gLS0tIGEvZHJpdmVycy9uZXQv
d2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc2X2Nvbm5hYy5oDQo+ID4gPiArKysgYi9kcml2ZXJz
L25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzZfY29ubmFjLmgNCj4gPiA+IEBAIC0yMzIs
OSArMjMyLDE0IEBAIHN0YXRpYyBpbmxpbmUgYm9vbCBpc19tdDc5OTIoc3RydWN0IG10NzZfZGV2
DQo+ID4gPiAqZGV2KQ0KPiA+ID4gICAgICAgICByZXR1cm4gbXQ3Nl9jaGlwKGRldikgPT0gMHg3
OTkyOw0KPiA+ID4gIH0NCj4gPiA+DQo+ID4gPiArc3RhdGljIGlubGluZSBib29sIGlzX210Nzk5
MChzdHJ1Y3QgbXQ3Nl9kZXYgKmRldikNCj4gPiA+ICt7DQo+ID4gPiArICAgICAgIHJldHVybiBt
dDc2X2NoaXAoZGV2KSA9PSAweDc5OTM7DQo+ID4NCj4gPiBJdCBzZWVtcyBsaWtlIHBhdGNoIDAx
LzEwIHdhbnQgdG8gYXZvaWQgdGhpcyBraW5kIG9mIGNvbmZ1c2lvbi4NCj4gPg0KPiBUaGlzIGhl
bHBlciBpcyBhZGRlZCBpbiBtdDc2X2Nvbm5hYy5oLCB3aGljaCBjYW4gYmUgdXNlZCBieSBtdDc2
IGNvbW1vbg0KPiBwYXJ0IGFuZCBtdDc5OTYgcGVyLWNoaXAgZm9sZGVyLg0KPiANCj4gPiBBbHNv
LCB0aGVyZSBhcmUgdHdvIElEcyBmb3IgTVQ3OTkwOg0KPiA+DQo+ID4gI2RlZmluZSBNVDc5OTBf
REVWSUNFX0lEICAgICAgICAgICAgICAgMHg3OTkzDQo+ID4gI2RlZmluZSBNVDc5OTBfREVWSUNF
X0lEXzIgICAgICAgICAgICAgMHg3OTliDQo+ID4NCj4gVGhlc2UgdHdvIGFyZSBvbmx5IHVzZWQg
YnkgbXQ3OTk2IHBlci1jaGlwIGZvbGRlci4NCj4gDQoNCkkgd2FzIG5vdCBhd2FyZSB0aGlzIGhh
cmR3YXJlIGhhcyB0d28gUENJIElELiBPbmUgaXMgMHg3OTkzIGFuZCB0aGUgb3RoZXINCmlzIDB4
Nzk5YiBmb3IgSElGMi4gSSBndWVzcyBzdWZmaXggJ18yJyBtZWFucyAnSElGMicsIHdoaWNoIHdv
dWxkIGJlDQpjbGVhcmVyPyANCg0KQW5vdGhlciB0aGluZyBpcyB1c2FnZSBvZiByZXR1cm4gdmFs
dWUgb2YgbXQ3Nl9jaGlwKCkuIEhlcmUsIHlvdSBjb21wYXJlIA0Kd2l0aCByYXcgaGV4YWRlY2lt
YWwgMHg3OTkzLCBidXQgcmFyZWx5IGluIG10Nzk5Nl9lZXByb21fbmFtZSgpDQpNVDc5OTJfREVW
SUNFX0lEIGlzIHVzZWQuIA0KDQoNCg==

