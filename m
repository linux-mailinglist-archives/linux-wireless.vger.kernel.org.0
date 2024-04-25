Return-Path: <linux-wireless+bounces-6803-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E0E8B1A69
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Apr 2024 07:42:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B4FC1F21168
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Apr 2024 05:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD6743C082;
	Thu, 25 Apr 2024 05:42:01 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328873BBD6
	for <linux-wireless@vger.kernel.org>; Thu, 25 Apr 2024 05:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714023721; cv=none; b=JPjD3cbLMRoEpYKDbD8F/gbS19n8Dy0gYhOQADoZnmVBUp/Vs9iR2T9AddaCdDHVAvypAcI+CPw/llY+pFzWSbvd/jvW71ntI4suNYMnPgbiBuTdPH9Qf3dNsgeX94F8NejpNYNDA4gLDY7oRD8W/01H6YY4xYpndMchd6iBcig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714023721; c=relaxed/simple;
	bh=X0tjQ5rDSsKd6LewhI2pT4TA4srJyFdFigpo2x9fFzE=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lWNlrHv0ixAbKMTliYlROXK4k1KPyiXxVrzVHQt2Ex8LFFJTv3gatA+L/jpLXYoXO4VhwUhG4ovOpxJAH2ZeOclhMCUCY2/wKUQcogW57hm5fukIGnfjOj1gRl3aevaXhzAIFfVn1A0HnMN8coQkGkOhpF9Ytwa4zAYk9kh0GQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 43P5fUKZ13226228, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 43P5fUKZ13226228
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Apr 2024 13:41:35 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 25 Apr 2024 13:41:31 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 25 Apr 2024 13:41:30 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Thu, 25 Apr 2024 13:41:30 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Plamen Dimitrov <plamen.dimitrov@pevogam.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: Problems with RTL8852BE PCIe 802.11ax Wireless Network Controller and Linux kernel 6.7.7-100.fc38.x86_64
Thread-Topic: Problems with RTL8852BE PCIe 802.11ax Wireless Network
 Controller and Linux kernel 6.7.7-100.fc38.x86_64
Thread-Index: AQHajxBK3TMYBDJJU02LKax8Cy6TM7FphqBQgAAfJYCAAAJakIALACyAgAAFKQCAAzAiAIAAJJ1A
Date: Thu, 25 Apr 2024 05:41:30 +0000
Message-ID: <4e6da84a3a274fcebaae86c42f80458f@realtek.com>
References: <7833fd15-5875-40b8-a20b-a68fa92f814f@pevogam.com>
 <2e67ec1dfc8b420bab05dc025c7c59cf@realtek.com>
 <f8e3d8c6-11ef-4dff-8c4e-d10e8a4006aa@pevogam.com>
 <efc3e8306e1b417cbb779109a4a5ff54@realtek.com>
 <94f3355c-b247-4215-a046-a39293c8d03e@pevogam.com>
 <8fa0fcfccfe14377ba053130f95b8917@realtek.com>
 <89fccaa8-af18-4192-8186-f76577694b97@pevogam.com>
In-Reply-To: <89fccaa8-af18-4192-8186-f76577694b97@pevogam.com>
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
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

UGxhbWVuIERpbWl0cm92IDxwbGFtZW4uZGltaXRyb3ZAcGV2b2dhbS5jb20+IHdyb3RlOg0KPiBP
biA0LzIzLzI0IDEwOjQ5LCBQaW5nLUtlIFNoaWggd3JvdGU6DQo+ID4gUGxhbWVuIERpbWl0cm92
PHBsYW1lbi5kaW1pdHJvdkBwZXZvZ2FtLmNvbT4gIHdyb3RlOg0KPiA+Pj4gQW5vdGhlciB0cnkg
aXMgdG8gZGlzYWJsZSBwb3dlciBzYXZlIGJ5ICdpdycgY29tbWFuZCByaWdodCBhZnRlciBib290
aW5nLCBsaWtlDQo+ID4+PiAgICAgc3VkbyBpdyB3bGFuMCBzZXQgcG93ZXJfc2F2ZSBvZmYNCj4g
Pj4gSSBoYWQgdG8gdGFrZSBhIHdoaWxlIHRvIG1ha2Ugc3VyZSB0aGF0IHRoaXMgaW5kZWVkIHdv
cmtlZCBhbmQgc28gZmFyIGl0IHRvb2sgc29tZSBkYXlzIHdpdGhvdXQgYW55IGZhaWx1cmUNCj4g
Pj4gd2hpY2ggbWFrZXMgbWUgZ3Vlc3MgdGhhdCB0aGlzIGhhcyBhY3R1YWxseSBoZWxwZWQuIEkg
ZXZlbiB0cmllZCByZWJvb3RpbmcgYWdhaW4gYW5kIHRoZSBwcm9ibGVtIGlzIHN0aWxsDQo+ID4+
IGxpa2VseSBmaXhlZC4gSSB3aWxsIG1vbml0b3IgdGhlIHNpdHVhdGlvbiBidXQgZm9yIHRoZSBz
YWtlIG9mIHN1c3RhaW5hYmxlIHNvbHV0aW9uLCBJIGd1ZXNzIHRoZSBhYm92ZQ0KPiA+PiBkb2Vz
IHNldCBhIHNldHRpbmcgdGhhdCB3ZSBjb3VsZCBub3Qgc2V0IGluIGFueSBvdGhlciB3YXk/IEl0
IHNlZW1zIHRvIHdvcmsgYW5kIHRoYXQncyBncmVhdCwgSSBqdXN0DQo+IHdvbmRlcg0KPiA+PiBp
ZiBydW5uaW5nIGBzdWRvIGl3IHdsYW4wIHNldCBwb3dlcl9zYXZlIG9mZmAgdXBvbiBlYWNoIHJl
Ym9vdCBvciBrZXJuZWwgdXBkYXRlIGNhbiBiZSByZXBsYWNlZCB3aXRoDQo+IHNvbWV0aGluZw0K
PiA+PiBtb3JlIGxvbmcgbGFzdGluZy4NCj4gPj4NCj4gPiBJZiB5b3UgdXNlIG5ldHdvcmsgbWFu
YWdlciBhcyBXaUZpIGNvbnRyb2xsZXIsIHNldCAnd2lmaS5wb3dlcnNhdmUgPSAyJyBpbiBjb25m
aWcgZmlsZSBbMV0uDQo+ID4NCj4gPiBbMV1odHRwczovL2dpc3QuZ2l0aHViLmNvbS9qY2JlcnRo
b24vZWE4Y2ZlMjc4OTk4OTY4YmE3YzVhOTUzNDRiYzhiNTUNCj4gDQo+IFNvIEkgYXBwbGllZCB0
aGlzIHdpdGggdGhlIHdpZmkgY2FyZCBmYWlsaW5nIGFnYWluIHdpdGggdGhlIGFib3ZlIGVycm9y
cy4gVGhlbiBJIHRyaWVkIHRoZSBzYW1lIE5ldHdvcmtNYW5hZ2VyDQo+IGNvbmZpZw0KPiBidXQg
d2l0aCBhIGZ1bGwgcmVib290IGFuZCB0aGUgd2lmaSBjcmFzaGVkIGFnYWluLiBJIHJlaXNzdWVk
IHRoZSBwcmV2aW91cyBgaXdgIGNvbW1lbnQgdG8gc2V0IHRoaXMgYnV0DQo+IHRoZW4gdGhlIHdp
ZmkNCj4gY3Jhc2hlZCBhZ2FpbiBiZWZvcmUgYW5kIGFmdGVyIGFkZGl0aW9uYWwgY29sZCByZWJv
b3QuIEkgYW0gcmVhbGx5IG5vdCBzdXJlIHdoYXQgaXMgZ29pbmcgb24gaGVyZS4gU2hvdWxkDQo+
IEkgbG9vayBmb3INCj4gbW9yZSBsb2dzIG9uY2UgdGhpcyBoYXBwZW5zIGFnYWluIGRlc3BpdGUg
dGhlIHBvd2Vyc2F2ZSBtb2RlPw0KDQpVc2luZyAnc3VkbyBpdyB3bGFuMCBnZXQgcG93ZXJfc2F2
ZScgdG8gY2hlY2sgcG93ZXIgc2F2ZSBzdGF0dXMgZXhwZWN0ZWQuDQoNCg0K

