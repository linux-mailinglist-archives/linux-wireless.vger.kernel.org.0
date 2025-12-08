Return-Path: <linux-wireless+bounces-29583-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 90309CABFA8
	for <lists+linux-wireless@lfdr.de>; Mon, 08 Dec 2025 04:46:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 23B03300C0DD
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Dec 2025 03:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66CEF20ED;
	Mon,  8 Dec 2025 03:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="YmctYTUw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1693B8D41
	for <linux-wireless@vger.kernel.org>; Mon,  8 Dec 2025 03:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765165609; cv=none; b=NpLmaSuydj4bBKd0gb17TyM/HU8Mha2kWqvEMmyTBTr52hE/OP5BxXjMPMywKgf7ubFUpGdhWscdYUMjgi0DSWgjZKEQ3bQ5Y/9AqsZEnMIpGuNJOZR2IaNnTldry/m5y9f9op1eS4VWsgh1rka339UorqfKa+Ld9DDYKDznIUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765165609; c=relaxed/simple;
	bh=VOL2X/XSfVzOUXWkagbyPIKXVTJclZAzMaYZrgXOMMQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=s7y0lhfpuK7QCzebztEYRrP/3FCH+mWpPUo3BGZY68PZTeoUgu+rOlB6J0M9xAr4dJiG6xS//5XLnEBUlz05KaEwRTkUNXYhTGsVC1oE9IwtXGtZeyuvM0QMApdwneIR0Yd2yx3Z0884Himks7CN+9c/BEmrMGSnskq7PEZsO0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=YmctYTUw; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5B83kdIiB3272655, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1765165600; bh=VOL2X/XSfVzOUXWkagbyPIKXVTJclZAzMaYZrgXOMMQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=YmctYTUwcpdlWZGHx2z+SiLXWA58dL4vSvSR5q2KpsN2S1IMID7zalLtb3OE3lAA0
	 Wk5iN0HPzUO2FF8wuPUh6WHquZORSA7WubPbN+ouOQHutq8PM8Mr2/OuDbhA9n27y9
	 YUEk3xsIKOp+Gud+3AHM0ejAqVIsRBBmlPCoQZeQT5NjjIz3O4hUDrz7S9SBrVVQGo
	 CWBZzbZkr2bz6EKnnR1h1BMz8jlCjsAntxQdmJSxKhuIFonMbF9qPJGJnKJ99ibVLn
	 D5KhXDkpK9pmHH4YH6+pz8ygSbjEfzyr2bOcG/B9NpdaK9gpiN+/nZJUE2FwEN91Cs
	 GQoDx3J9VtWFg==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5B83kdIiB3272655
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Dec 2025 11:46:39 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Mon, 8 Dec 2025 11:46:40 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::2fa5:eccb:34ee:7bb%10]) with mapi id
 15.02.1544.027; Mon, 8 Dec 2025 11:46:40 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Zenm Chen <zenmchen@gmail.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "marco.crivellari@suse.com" <marco.crivellari@suse.com>,
        "rtl8821cerfe2@gmail.com" <rtl8821cerfe2@gmail.com>
Subject: RE: [PATCH rtw-next] Revert "wifi: rtw88: add WQ_UNBOUND to
 alloc_workqueue users"
Thread-Topic: [PATCH rtw-next] Revert "wifi: rtw88: add WQ_UNBOUND to
 alloc_workqueue users"
Thread-Index: AQHcZt66JkU/0qBLKkWq0rXfVDO7QLUW53QQ//+MloCAAI1Y8P//jfwAgACLfYA=
Date: Mon, 8 Dec 2025 03:46:40 +0000
Message-ID: <a23db8e36520457e8440e41715974d98@realtek.com>
References: <c5ea34777592402caeb7fb83af7d6f07@realtek.com>
 <20251208032033.5793-1-zenmchen@gmail.com>
In-Reply-To: <20251208032033.5793-1-zenmchen@gmail.com>
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

WmVubSBDaGVuIDx6ZW5tY2hlbkBnbWFpbC5jb20+IHdyb3RlOg0KPiBIaSBQaW5nLUtlLA0KPiAN
Cj4gUGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+IOaWvCAyMDI15bm0MTLmnIg45pel
6YCx5LiAIOS4iuWNiDEwOjEx5a+r6YGT77yaDQo+ID4NCj4gPiBIaSBaZW5tLA0KPiA+DQo+ID4g
WmVubSBDaGVuIDx6ZW5tY2hlbkBnbWFpbC5jb20+DQo+ID4gPiBIaSwNCj4gPiA+DQo+ID4gPiBM
YXN0IHdlZWtlbmQgSSB0cmllZCBhcHBseWluZyB0aGUgdjEgWzFdIHRvIHRoZSBrZXJuZWwgNi4x
Ny45LCBidXQgdGhhdCBvbmUgZGlkbid0IHdvcmssIGVpdGhlci4NCj4gPiA+DQo+ID4gPiBbMV0N
Cj4gPiA+DQo+IGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9saW51eC13aXJl
bGVzcy9wYXRjaC8yMDI1MTExMzE2MDYwNS4zODE3NzctMy1tYXJjby5jcml2ZWxsYXJpQHN1cw0K
PiA+ID4gZS5jb20vDQo+ID4gPg0KPiA+ID4gWyAgMzA2LjAzNTc1OV0gdXNiIDMtMjogbmV3IGhp
Z2gtc3BlZWQgVVNCIGRldmljZSBudW1iZXIgNSB1c2luZyBlaGNpLXBjaQ0KPiA+ID4gWyAgMzA2
LjE2MjI1OF0gdXNiIDMtMjogTmV3IFVTQiBkZXZpY2UgZm91bmQsIGlkVmVuZG9yPTBiZGEsIGlk
UHJvZHVjdD1iODJjLCBiY2REZXZpY2U9IDIuMTANCj4gPiA+IFsgIDMwNi4xNjIyNzJdIHVzYiAz
LTI6IE5ldyBVU0IgZGV2aWNlIHN0cmluZ3M6IE1mcj0xLCBQcm9kdWN0PTIsIFNlcmlhbE51bWJl
cj0zDQo+ID4gPiBbICAzMDYuMTYyMjc4XSB1c2IgMy0yOiBQcm9kdWN0OiA4MDIuMTFhYyBOSUMN
Cj4gPiA+IFsgIDMwNi4xNjIyODJdIHVzYiAzLTI6IE1hbnVmYWN0dXJlcjogUmVhbHRlaw0KPiA+
ID4gWyAgMzA2LjE2MjI4Nl0gdXNiIDMtMjogU2VyaWFsTnVtYmVyOiAxMjM0NTYNCj4gPiA+IFsg
IDMwNi4yMzkxNDNdIC0tLS0tLS0tLS0tLVsgY3V0IGhlcmUgXS0tLS0tLS0tLS0tLQ0KPiA+ID4g
WyAgMzA2LjIzOTE0OF0gV0FSTklORzogQ1BVOiAzIFBJRDogMjg4NiBhdCBrZXJuZWwvd29ya3F1
ZXVlLmM6NTY2NyBhbGxvY193b3JrcXVldWVfbm9wcm9mKzB4Njc2LzB4NzcwDQo+ID4NCj4gPiBJ
IHRoaW5rIHRoaXMgaXMgYmVjYXVzZSBrZXJuZWwgNi4xNy45IGRlZmluZXM6DQo+ID4NCj4gPiBf
X1dRX0JIX0FMTE9XUyAgICAgICAgICA9IFdRX0JIIHwgV1FfSElHSFBSSSwNCj4gPg0KPiA+IGFu
ZCB0aGUgbGF0ZXN0IGlzOg0KPiA+DQo+ID4gX19XUV9CSF9BTExPV1MgICAgICAgICAgPSBXUV9C
SCB8IFdRX0hJR0hQUkkgfCBXUV9QRVJDUFUsDQo+ID4NCj4gDQo+IFRoYW5rIHlvdSBmb3IgcG9p
bnRpbmcgb3V0IHRoaXMuIEhhdmUgY29uZmlybWVkIHRoZSBwYXRjaCB2MSBkb2VzIHdvcmsgb24N
Cj4gQXJjaCBMaW51eCB3aXRoIGtlcm5lbCA2LjE4LjAtMS1tYWlubGluZS4NCg0KVGhhbmtzIGZv
ciB5b3VyIGNvbmZpcm1hdGlvbi4gSSdkIHJlLW9wZW4gdGhlIHBhdGNoIGFzIE5ldyBpbiBwYXRj
aHdvcmsuDQoNCk1vcmUsIHRoYXQgbWVhbnMgaWYgeW91IHdhbnQgdG8gYmFja3BvcnQgdGhpcyBk
cml2ZXIgb24gNi4xNyBvciBlYXJsaWVyLCB5b3UNCm5lZWQgc29tZSB0cmVhdG1lbnRzIGZvciB0
aGlzIGNoYW5nZS4gDQoNCg==

