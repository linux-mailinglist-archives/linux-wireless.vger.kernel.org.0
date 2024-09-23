Return-Path: <linux-wireless+bounces-13080-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F6297E5CE
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Sep 2024 07:58:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 366ACB20BD1
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Sep 2024 05:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59317747F;
	Mon, 23 Sep 2024 05:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="kNBD9LZw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB46171AF
	for <linux-wireless@vger.kernel.org>; Mon, 23 Sep 2024 05:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727071122; cv=none; b=Y8Q/4QsNnXOPLCPOQTkz/epM3xeD1q03JcjbUHzrxLueHjgSpYYHw5HUz+Zw82ZuouK5zzy9YzMj371Q+mRyFxNAf9iMXBxj3NdY47Gp+7t8TJXMTJY/dsih59A37q8MkVbNbVftGT/HAQQctZK7oJelTWHncaQNm6n7OqV7/Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727071122; c=relaxed/simple;
	bh=FKfY56rKJwemaI4jEx0Kpw3b9x4hGt1EYMrrnxNclYM=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NJbUjhHUBo7phfsl8xnNUJ8Bokzg/t0ahpi+rAQaTpqWDahxUYYzCRETCeMKZMeuJnmWgjXU3U10LQEr/gLd0InQ748yR4cGk6S8gBonEJVLdGcjQUBDjZ6pgL8gd1RwqSSdCbVo1CZGyjpBfagaE4eyqCWgLXBpvRPzdKQsVWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=kNBD9LZw; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 48N5wZuV5861343, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1727071115; bh=FKfY56rKJwemaI4jEx0Kpw3b9x4hGt1EYMrrnxNclYM=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=kNBD9LZwOsSEfzs3jQ+jwWeyLcFyiY3EVGgUzhortnHbJyJBahg2Qt5pHus6eWWzr
	 67q/e9xV8W13N8IEiuPpi1AZaYTbMl3g1bJbL4WqUuRWohohrtPBAlFr17PwCFNY8x
	 Q7V/xuOqzoPn4j8Ic+lKD/k0j/FBk0cxfMopPXrxh5o68aCq1zXzIXw0hHO+x5en2S
	 KvpJSDjJQbMCpUeJVyfA4NSjjD+CxGLiEJtZrkvxAYNdKSlsYKjl2aCmA/UCdITM3r
	 fo5jI6+gq0LWjaO6dISlbJkHGHIr481Nk2bbOuErI+AJlJx52rxozyHQJIxhqK/jQo
	 ZWy2oOTTzGE1A==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.05/5.92) with ESMTPS id 48N5wZuV5861343
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Sep 2024 13:58:35 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 23 Sep 2024 13:58:36 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 23 Sep 2024 13:58:35 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Mon, 23 Sep 2024 13:58:35 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH 18/20] wifi: rtw88: Add rtw8821a.{c,h}
Thread-Topic: [PATCH 18/20] wifi: rtw88: Add rtw8821a.{c,h}
Thread-Index: AQHa7DKP0miyRAHIW0qWSqezSXaH97IpJM5AgBHQWoCAFW7yIIADltQAgAEjSvCADXPMAIACikGAgAAGIVA=
Date: Mon, 23 Sep 2024 05:58:35 +0000
Message-ID: <94abf678de114a3fa5450c1c9cf6f930@realtek.com>
References: <ade57ca1-444f-49e2-b49e-f4b9da65b2cc@gmail.com>
 <f25d00ab-4481-4540-956b-bc1028a501e1@gmail.com>
 <e365c61d730d4f49915b543dcb0063d5@realtek.com>
 <dafaac0c-fb55-4406-b8ff-69aa66d3fd06@gmail.com>
 <1aca96c68f914f90b6d1baf8780e6ce4@realtek.com>
 <bebaa40a-1c7a-4b1e-99cd-7c7aac7c76f4@gmail.com>
 <f583e9470ca84234ad2e00f3a0371664@realtek.com>
 <38553e79-6747-4ab3-9bf4-fa7f2af852cd@gmail.com>
 <73de8e7135554ae9a0f7968780644515@realtek.com>
In-Reply-To: <73de8e7135554ae9a0f7968780644515@realtek.com>
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

UGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+IHdyb3RlOg0KPiBCaXR0ZXJibHVlIFNt
aXRoIDxydGw4ODIxY2VyZmUyQGdtYWlsLmNvbT4gd3JvdGU6DQo+ID4gPj4+Pj4+ICsNCj4gPiA+
Pj4+Pj4gK2NvbnN0IHN0cnVjdCBydHdfY2hpcF9pbmZvIHJ0dzg4MTJhX2h3X3NwZWMgPSB7DQo+
ID4gPj4+Pj4NCj4gPiA+Pj4+PiBJcyBpdCBwb3NzaWJsZSBtb3ZpbmcgODgxMmEgdG8gaW5kaXZp
ZHVhbCBmaWxlPw0KPiA+ID4+Pj4+IFNpbmNlIHlvdSBoYXZlIHJ0dzg4MTJhdS5jIGFuZCBydHc4
ODIxYXUuYy4NCj4gPiA+Pj4+Pg0KPiA+ID4+Pj4NCj4gPiA+Pj4+IEkgdGhpbmsgaXQgaXMgcG9z
c2libGUuIEJ1dCBtb3N0IG9mIHRoZSBjb2RlIGlzIGNvbW1vbiB0byBib3RoIGNoaXBzLg0KPiA+
ID4+Pj4gT25seSB0aGUgSVEgY2FsaWJyYXRpb24gY291bGQgYmUgbW92ZWQuDQo+ID4gPj4+DQo+
ID4gPj4+IFllcCwgZGVwZW5kIG9uIGhvdyBtdWNoIElRSyBjb2RlIGVjaG8gY2hpcCBoYXMuDQo+
ID4gPj4+DQo+ID4gPj4NCj4gPiA+PiBUaGUgSVEgY2FsaWJyYXRpb24gZm9yIFJUTDg4MTJBVSBp
cyBhYm91dCA3MDAgbGluZXMuDQo+ID4gPg0KPiA+ID4gcnR3ODgxMmF1ICAtLS0tLT4gKGEpIHJ0
dzg4MTJhDQo+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICB8DQo+ID4gPiAgICAgICAgICAg
ICAgICAgICAgICAgICB2DQo+ID4gPiAgICAgICAgICAgICAgICAgICAoYikgcnR3ODgyMWFfY29t
bW9uICAoaGFyZCB0byBnaXZlIGEgbmFtZSkNCj4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAg
IF4NCj4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIHwNCj4gPiA+IHJ0dzg4MjFhdSAgLS0t
LS0+IChjKSBydHc4ODIxYQ0KPiA+ID4NCj4gPiA+IFB1dCBhbGwgY29tbW9uIGNvZGUgdG8gKGIp
LiBJUUsgY29kZSBpbiAoYSkgb3IgKGMpLg0KPiA+ID4NCj4gPiA+IEkgZmVlbCB5b3UgaGF2ZSB0
aG91Z2h0IGFib3ZlIHBpY3R1cmUgYWxyZWFkeS4gV2hhdCBhcmUgcHJvYmxlbXMgd2Ugd2lsbCBl
bmNvdW50ZXI/DQo+ID4gPiBNYW55IGV4cG9ydCBzeW1ib2xzPyBJZiBzbywgaG93IGFib3V0IGJl
bG93Pw0KPiA+ID4NCj4gPiA+IHJ0dzg4MTJhdSAgLS0tLS0+ICgxKSBydHc4ODEyYQ0KPiA+ID4g
ICAgICstLS0tLS0tLS0rDQo+ID4gPiAgICAgICAgICAgICAgICstPiAoMikgcnR3ODgyMWFfY29t
bW9uICAoaGFyZCB0byBnaXZlIGEgbmFtZSkNCj4gPiA+ICAgICArLS0tLS0tLS0tKw0KPiA+ID4g
cnR3ODgyMWF1ICAtLS0tLT4gKDMpIHJ0dzg4MjFhDQo+ID4gPg0KPiA+ID4gUHV0IHJ0dzg4MTJh
X2h3X3NwZWMgYW5kIHJ0dzg4MjFhX2h3X3NwZWMgaW4gKDIpLiBPbmx5IElRSyBjb2RlIGluICgx
KSBhbmQgKDMpDQo+ID4gPiByZXNwZWN0aXZlbHksIGFuZCBleHBvcnQgSVFLIGVudHJ5IG9ubHku
IERvZXMgaXQgd29yaz8NCj4gPiA+DQo+ID4gPg0KPiA+IEZvciB0aGUgbmFtZSBvZiB0aGUgY29t
bW9uIG1vZHVsZSwgSSB3YXMgdGhpbmtpbmcgcnR3ODhfODh4eGEua28uDQo+ID4NCj4gPiBJIHdv
bmRlciwgd2hhdCBpcyB0aGUgZ29hbD8gVG8gcHV0IHRoZSBjb2RlIGluIHNlcGFyYXRlIGtlcm5l
bA0KPiA+IG1vZHVsZXMsIG9yIGp1c3Qgc2VwYXJhdGUgZmlsZXM/DQo+IA0KPiBJIHdvdWxkIGxp
a2UgdG8gcmVkdWNlIHJ1bnRpbWUgbWVtb3J5LiBBcyBJIGFza2VkLCBob3cgbWFueSBJUUsgY29k
ZSBhcmUgZGlmZmVyZW50DQo+IGZyb20gdGhlbT8gSWYgeW91IGhhdmUgc2VwYXJhdGVkIGFuZCBj
b21waWxlZCB0aGVtLCBjYW4geW91IHNoYXJlIHNpemUgYnkgdGhlDQo+IG91dHB1dCBvZiAnc2l6
ZScgY29tbWFuZD8NCj4gDQo+ID4NCj4gPiBJIHRoaW5rIHdlIGNhbiBoYXZlIHJ0dzg4eHhhLmMg
KGNvbW1vbiBjb2RlKSwgcnR3ODgyMWEuYyAoSVFLIGNvZGUsDQo+ID4gcnR3ODgyMWFfaHdfc3Bl
YywgYmx1ZXRvb3RoIHN0dWZmKSwgYW5kIHJ0dzg4MTJhLmMgKElRSyBjb2RlLA0KPiA+IHJ0dzg4
MTJhX2h3X3NwZWMsIHNvbWUgZWZ1c2Ugc3R1ZmYsIGNoYW5uZWwgc3dpdGNoaW5nKS4uLiBpZiB0
aGVzZQ0KPiA+IHRocmVlIGZpbGVzIGNvbXBpbGUgaW50byBhIHNpbmdsZSBtb2R1bGUsIHJ0dzg4
Xzg4eHhhLmtvLg0KPiA+DQo+ID4gSWYgZWFjaCBmaWxlIGNvbXBpbGVzIGludG8gYSBtb2R1bGUg
b2YgaXRzIG93biwgd2UgaGF2ZSBjaXJjdWxhcg0KPiA+IGRlcGVuZGVuY2llczogcnR3ODgyMWFf
aHdfc3BlYyAtPiBjb21tb24gY29kZSAtPiBJUUsgY29kZS4NCj4gPiBJZiAqX2h3X3NwZWMgZ28g
aW4gdGhlIGNvbW1vbiBtb2R1bGUsIGl0IHN0aWxsIGRlcGVuZHMgb24gYm90aCBvZg0KPiA+IHRo
ZSBvdGhlciB0d28gbW9kdWxlcywgc28gd2hhdCB1c2UgaXMgaXQ/DQo+IA0KPiBJZiB3ZSBoYXZl
IGRlcGVuZGVuY3kgb2YgY29tbW9uIGNvZGUgLT4gSVFLIGNvZGUsIHdlIGNhbid0IHNhdmUgcnVu
dGltZQ0KPiBtZW1vcnksIGJlY2F1c2UgY29tbW9uIGNvZGUgcmVmZXJlbmNlIHRvIGJvdGggSVFL
IGNvZGUuIFNvIEkgZmVsdA0KPiBkZXBlbmRlbmN5IG9mIElRSyBjb2RlIHdvdWxkIGJlIHJ0dzg4
MTJhdSAtLT4gSVFLIGNvZGUgYXMgYWJvdmUgc2Vjb25kDQo+IGRpYWdyYW0uDQo+IA0KPiBCdXQg
aWYgdGhlIHdvcmsgaXMgY29tcGxpY2F0ZWQgYW5kIHNhdmUgZmV3IHJ1bnRpbWUgbWVtb3J5LCB3
ZSBjYW4NCj4gdXNlIHNpbXBsZSBkZXNpZ24gYXMgY3VycmVudCBkaWQuDQo+IA0KDQpTb3JyeS4g
Q29ycmVjdCB0eXBvLiAiLi4uIHNhdmUgZmV3IHJ1bnRpbWUgbWVtb3J5IC4uLiIgKHJlbW92ZSAn
bm90JykNCg0KDQo=

