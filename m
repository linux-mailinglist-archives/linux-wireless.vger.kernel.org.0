Return-Path: <linux-wireless+bounces-3610-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 485BF855B7D
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Feb 2024 08:21:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53346B24A7C
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Feb 2024 07:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F35FD3C35;
	Thu, 15 Feb 2024 07:20:51 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74BFB33CF
	for <linux-wireless@vger.kernel.org>; Thu, 15 Feb 2024 07:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707981651; cv=none; b=q036gP8gCWOJ+mYMwuHkAGnoJ6y5bPTtCMlFiY+Qj3IarpqJZDK9kqu2a3ifpn58SlIEx8bzFucPGq80Cd2/Dm2lnmoOjAgsba0Pbb+N4uc2GWO/owWeg8a0RPKvEMwwBUbEZfBxt7c2dizAN5sWbvBUM8v+5oVL9L1BtK0JDw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707981651; c=relaxed/simple;
	bh=mSwW7yHpzltw/2h/S+IU65STfQnb9vMi2GBpqjuLr4Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mPtULETwCoZ9iiVhdNYY+Epw94nLvJZqH61xztXt/w1bTPzerZleBejszyBdiK3e8kM3qgX+r2l8qizLFo8pLQkHaS0rPrxnL3FMUwifKJ4GQyzh1pseXcuawUI13fYVPBMz+k2AnPp3AHJpS72TIaacT+cSY6elnwXkiMDIlGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 41F7KbhZ62416055, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 41F7KbhZ62416055
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Feb 2024 15:20:37 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.17; Thu, 15 Feb 2024 15:20:38 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 15 Feb 2024 15:20:38 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f]) by
 RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f%7]) with mapi id
 15.01.2507.035; Thu, 15 Feb 2024 15:20:35 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: "Larry.Finger@lwfinger.net" <Larry.Finger@lwfinger.net>
Subject: RE: [PATCH] wifi: rtlwifi: rtl8192cu: Fix TX aggregation
Thread-Topic: [PATCH] wifi: rtlwifi: rtl8192cu: Fix TX aggregation
Thread-Index: AQHaWsipl4rptCy500W5BwIBLsgXbrEGKCeAgAGvIgCAAzD2cA==
Date: Thu, 15 Feb 2024 07:20:35 +0000
Message-ID: <2b6b8a43caff4079be6ddb289d267ab8@realtek.com>
References: <651dae37-1911-4dcd-870b-4b60f759ca82@gmail.com>
 <cd687092be44f7fe596f20aa7305c0e4618437ab.camel@realtek.com>
 <62f4c9be-d7a9-45d3-bc29-9901d64ebafe@gmail.com>
In-Reply-To: <62f4c9be-d7a9-45d3-bc29-9901d64ebafe@gmail.com>
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQml0dGVyYmx1ZSBTbWl0
aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIEZlYnJ1YXJ5IDEz
LCAyMDI0IDEwOjMzIFBNDQo+IFRvOiBQaW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT47
IGxpbnV4LXdpcmVsZXNzQHZnZXIua2VybmVsLm9yZw0KPiBDYzogTGFycnkuRmluZ2VyQGx3Zmlu
Z2VyLm5ldA0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSB3aWZpOiBydGx3aWZpOiBydGw4MTkyY3U6
IEZpeCBUWCBhZ2dyZWdhdGlvbg0KPiANCj4gT24gMTIvMDIvMjAyNCAxNDo1MCwgUGluZy1LZSBT
aGloIHdyb3RlOg0KPiA+IE9uIFRodSwgMjAyNC0wMi0wOCBhdCAyMTo1NCArMDIwMCwgQml0dGVy
Ymx1ZSBTbWl0aCB3cm90ZToNCj4gPj4gICAgICAgICAgICAgICAgIHNldF90eF9kZXNjX21heF9h
Z2dfbnVtKHR4ZGVzYywgMHgxNCk7DQo+ID4NCj4gPiBIYXZlIHlvdSB0cmllZCBsYXJnZXIgbnVt
YmVyIG9mIHRoaXM/DQo+ID4gQXMgSUVFRTgwMjExX01BWF9BTVBEVV9CVUZfSFQgaXMgMHg0MCwg
c2V0IDB4M2YgaGVyZSB0byBnZXQgaGlnaGVyIFRYDQo+ID4gdGhyb3VnaHB1dCBpZiBVU0Igc3Bl
ZWQgY2FuIGFmZm9yZC4NCj4gPg0KPiANCj4gV2l0aCB0aGlzIHBhdGNoLCB0aGUgdXBsb2FkIHNw
ZWVkIGlzIDQ2IE1icHMuIEJ1dCB0aGF0J3MganVzdA0KPiBiZWNhdXNlIG15IGRldmljZSBpcyBk
ZXRlY3RlZCBhcyAxVDJSIGFuZCBpdCdzIG5vdCBhbGxvd2VkIHRvIHVzZQ0KPiByYXRlcyBhYm92
ZSBNQ1M3LiBXaGVuIEkgZml4IHRoYXQgcHJvYmxlbSB0aGUgdXBsb2FkIHNwZWVkIGlzIDgyIE1i
cHMNCj4gaW4gdGhlIHNhbWUgY29uZGl0aW9ucywgYWJvdXQgMyBtZXRlcnMgZnJvbSB0aGUgcm91
dGVyLg0KPiANCj4gSWYgSSB0aGVuIG1vdmUgdGhlIGRldmljZSBqdXN0IDYwIGNtIGF3YXksIHRo
ZSB1cGxvYWQgc3BlZWQgaXMgOTINCj4gTWJwcy4NCj4gDQo+IEkgdHJpZWQgMHgxZiBub3cgKHRo
aXMgZmllbGQgaXMgb25seSA1IGJpdHMpLiBUaGUgdXBsb2FkIHNwZWVkIGRvZXNuJ3QNCj4gZ2V0
IGJldHRlci4gTWF5YmUgaXQgZ2V0cyBhIGJpdCB3b3JzZS4NCg0KSXQgY291bGQgaGF2ZSBtb3Jl
IGludGVyZmVyZW5jZSB3aXRoIGxhcmdlciBhZ2dyZWdhdGlvbiBudW1iZXIuIExldCdzIGtlZXAN
Cml0IGFzIGl0IHdhcy4gVGhhbmtzIGZvciB0aGUgdHJ5Lg0KDQpQaW5nLUtlIA0KDQo=

