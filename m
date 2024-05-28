Return-Path: <linux-wireless+bounces-8153-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A93E48D125B
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2024 05:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B18D1F218A0
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2024 03:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1623BFC0B;
	Tue, 28 May 2024 03:00:32 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2833EEC5;
	Tue, 28 May 2024 03:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716865232; cv=none; b=IvoaXGWmBnKQHR5Zf8fyABXrQdPPi87Oa67hvNvGDPpQaVHfov75kQt9s1A9gYXWs4H48RAmRdChwcsqfDS/pcndOXKULWRQLD3aX3eL4WTHld7a9n5+CthK9utMFPMQVWA1IgwVd//nD5MHDC4WBx/nAdN+tiqBxreY9p8EPLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716865232; c=relaxed/simple;
	bh=vdwsbhUlI0b/qUwqYCGO7dXDGP/od7QNsNHkoQLwTeY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hmEglkpvobWMLllHJp5BULYcbIDqvgRG8syzIU9sSN9DFv1tHwGQLCwC7O4YVw1KBlz+LBG0DKzR4B114M2n7A9fY8V7HWfo5dQmtCAx+mLO/vZdVV21d9SOUdD8M3GCgMlXToiaxco3GhZFilHmzUZS13LtB4GggUD7TrmdAKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 44S306w241876719, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 44S306w241876719
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 May 2024 11:00:06 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 28 May 2024 11:00:06 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 28 May 2024 11:00:06 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Tue, 28 May 2024 11:00:05 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Kalle Valo <kvalo@kernel.org>,
        "marcin.slusarz@gmail.com"
	<marcin.slusarz@gmail.com>,
        "tpkuester@gmail.com" <tpkuester@gmail.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        =?utf-8?B?TWFyY2luIMWabHVzYXJ6?= <mslusarz@renau.com>,
        Larry Finger
	<Larry.Finger@lwfinger.net>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] wifi: rtw88: schedule rx work after everything is set up
Thread-Topic: [PATCH] wifi: rtw88: schedule rx work after everything is set up
Thread-Index: AQHasFekMjDEF5R7/k+0650S2/2b8bGrUuCQgACfb4CAAAI8gA==
Date: Tue, 28 May 2024 03:00:05 +0000
Message-ID: <bb41155129f844caac955e80915f8b24@realtek.com>
References: <20240527170137.455671-1-marcin.slusarz@gmail.com>
 <87jzjf8990.fsf@kernel.org> <13e848c1544245e6aef4b89c3f38daf0@realtek.com>
In-Reply-To: <13e848c1544245e6aef4b89c3f38daf0@realtek.com>
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

KyBUaW0gSyAocmVwb3J0ZXIpDQoNCkhpIFRpbSwNCg0KQ291bGQgeW91IHBsZWFzZSB0cnkgdGhp
cyBwYXRjaCBjYW4gaGVscCB5b3VyIHJ0dzg4MjJidT8gDQoNClBpbmctS2UgU2hpaCA8cGtzaGlo
QHJlYWx0ZWsuY29tPiB3cm90ZToNCj4gS2FsbGUgVmFsbyA8a3ZhbG9Aa2VybmVsLm9yZz4gd3Jv
dGU6DQo+ID4gbWFyY2luLnNsdXNhcnpAZ21haWwuY29tIHdyaXRlczoNCj4gPg0KPiA+ID4gRnJv
bTogTWFyY2luIMWabHVzYXJ6IDxtc2x1c2FyekByZW5hdS5jb20+DQo+ID4gPg0KPiA+ID4gUmln
aHQgbm93IGl0J3MgcG9zc2libGUgdG8gaGl0IE5VTEwgcG9pbnRlciBkZXJlZmVyZW5jZSBpbg0K
PiA+ID4gcnR3X3J4X2ZpbGxfcnhfc3RhdHVzIG9uIGh3IG9iamVjdCBhbmQvb3IgaXRzIGZpZWxk
cyBiZWNhdXNlDQo+ID4gPiBpbml0aWFsaXphdGlvbiByb3V0aW5lIGNhbiBzdGFydCBnZXR0aW5n
IFVTQiByZXBsaWVzIGJlZm9yZQ0KPiA+ID4gcnR3X2RldiBpcyBmdWxseSBzZXR1cC4NCj4gPiA+
DQo+ID4gPiBUaGUgc3RhY2sgdHJhY2UgbG9va3MgbGlrZSB0aGlzOg0KPiA+ID4NCj4gPiA+IHJ0
d19yeF9maWxsX3J4X3N0YXR1cw0KPiA+ID4gcnR3ODgyMWNfcXVlcnlfcnhfZGVzYw0KPiA+ID4g
cnR3X3VzYl9yeF9oYW5kbGVyDQo+ID4gPiAuLi4NCj4gPiA+IHF1ZXVlX3dvcmsNCj4gPiA+IHJ0
d191c2JfcmVhZF9wb3J0X2NvbXBsZXRlDQo+ID4gPiAuLi4NCj4gPiA+IHVzYl9zdWJtaXRfdXJi
DQo+ID4gPiBydHdfdXNiX3J4X3Jlc3VibWl0DQo+ID4gPiBydHdfdXNiX2luaXRfcngNCj4gPiA+
IHJ0d191c2JfcHJvYmUNCj4gPiA+DQo+ID4gPiBTbyB3aGlsZSB3ZSBkbyB0aGUgYXN5bmMgc3R1
ZmYgcnR3X3VzYl9wcm9iZSBjb250aW51ZXMgYW5kIGNhbGxzDQo+ID4gPiBydHdfcmVnaXN0ZXJf
aHcsIHdoaWNoIGRvZXMgYWxsIGtpbmRzIG9mIGluaXRpYWxpemF0aW9uIChlLmcuDQo+ID4gPiB2
aWEgaWVlZTgwMjExX3JlZ2lzdGVyX2h3KSB0aGF0IHJ0d19yeF9maWxsX3J4X3N0YXR1cyByZWxp
ZXMgb24uDQo+ID4gPg0KPiA+ID4gRml4IHRoaXMgYnkgbW92aW5nIHRoZSBmaXJzdCB1c2Jfc3Vi
bWl0X3VyYiBhZnRlciBldmVyeXRoaW5nDQo+ID4gPiBpcyBzZXQgdXAuDQo+ID4gPg0KPiA+ID4g
Rm9yIG1lLCB0aGlzIGJ1ZyBtYW5pZmVzdGVkIGFzOg0KPiA+ID4gWyAgICA4Ljg5MzE3N10gcnR3
Xzg4MjFjdSAxLTE6MS4yOiBiYW5kIHdyb25nLCBwYWNrZXQgZHJvcHBlZA0KPiA+ID4gWyAgICA4
LjkxMDkwNF0gcnR3Xzg4MjFjdSAxLTE6MS4yOiBody0+Y29uZi5jaGFuZGVmLmNoYW4gTlVMTCBp
biBydHdfcnhfZmlsbF9yeF9zdGF0dXMNCj4gPiA+IGJlY2F1c2UgSSdtIHVzaW5nIExhcnJ5J3Mg
YmFja3BvcnQgb2YgcnR3ODggZHJpdmVyIHdpdGggdGhlIE5VTEwNCj4gPiA+IGNoZWNrcyBpbiBy
dHdfcnhfZmlsbF9yeF9zdGF0dXMuDQo+ID4gPg0KPiA+ID4gVGhpcyBzaG91bGQgZml4Og0KPiA+
ID4gaHR0cHM6Ly9tYXJjLmluZm8vP2w9bGludXgtd2lyZWxlc3MmbT0xNjc5MDc2ODgzMTE5NDMm
dz0yDQo+ID4NCj4gPiBQbGVhc2UgdXNlIHBlcm1hbGlua3MgZnJvbSBsb3JlLmtlcm5lbC5vcmcs
IG1hcmMgbGlua3MgZG9uJ3QgY29udGFpbiB0aGUNCj4gPiBNZXNzYWdlLUlkIGFuZCBhcmUgaGVu
Y2UgdW5yZWxpYWJsZS4NCj4gPg0KPiANCj4gVXNlIHRhZ3MgYmVsb3c6DQo+IA0KPiBSZXBvcnRl
ZC1ieTogVGltIEsgPHRwa3Vlc3RlckBnbWFpbC5jb20+DQo+IENsb3NlczoNCj4gaHR0cHM6Ly9s
b3JlLmtlcm5lbC5vcmcvbGludXgtd2lyZWxlc3MvQ0Erc2hvV1E3UDQ5amhRYXNvZkRjVGRRaGl1
YXJQVGpZRURhLS1OaVZWeDQ5NFdjdVF3QG1haWwuZ21haWwuDQo+IGNvbS8NCj4gDQoNCg0K

