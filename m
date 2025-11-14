Return-Path: <linux-wireless+bounces-28941-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 856BEC5ADAB
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Nov 2025 01:54:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43EBA3A2844
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Nov 2025 00:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E4421E097;
	Fri, 14 Nov 2025 00:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="E+8HfvrI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5276D21C9E1
	for <linux-wireless@vger.kernel.org>; Fri, 14 Nov 2025 00:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763081642; cv=none; b=NIw1nbKCT7psyD8rs9BQ5nz4Dg8RXHY93jTr7iYd4Coi3WlAlwJ31fnKNv2qodqHuRbIve2/F01oVzBv52BjwXZ0URCS4A7RNdkYcOwO30zK/BMqPhunn7OqPTwsui9u0GaP2UZADf82VP7cGFBKMCR/kBsFUetxiMGOWKCr1+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763081642; c=relaxed/simple;
	bh=xRhSmDOsNvuQIaFZ/NUVq8ZuFGn3wU4+mqGIR0Svq+I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IufKzGUwZldzQbUiLLkjS0e8wFXQJhwKusthckh+ztIH/h17IGOqnB1rwYhGBn4/EHm3nqBqE+yw0HgKugEr+cIJ89Ry4o7HaAsP2ufppBKk3/UX9hHApNnSj5wOElczkFCK6do1oOHFkf1cA2fzHr4AUKRcAJre5uPvPr0mOCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=E+8HfvrI; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5AE0rmO23552691, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1763081628; bh=xRhSmDOsNvuQIaFZ/NUVq8ZuFGn3wU4+mqGIR0Svq+I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=E+8HfvrIJIym2N54RY5nY+CELmsnX/ZC+p3j9BX+oIQxgHRgrG8wwsnQaw3ZOOjsr
	 OkiDJF1mvYV4SPFkFSVcDV8EgjkBrpKMJtaa4F/BAN6Uww0jaLtMzB33tmBUJ8Uiig
	 fceJMtHmcQlPb0eNnAhI2dfYbNEKIL7sf6aE+xdtL5ujHqxq972DiM57ffuAwVG3K2
	 4HCLbxhTKiTVITkNb4yBj8mDE4dcEh3FV36i/7gCEV6p7VNrFuOyfVengAufQco7fi
	 dGbjDOltOqd5+LfD5pK5B/F5dnThRpqJNpp8BSyNDQe5ixw9QpW5xjAoK+FsmC3BYR
	 5CFAVT36CITLw==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5AE0rmO23552691
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Nov 2025 08:53:48 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Fri, 14 Nov 2025 08:53:49 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Fri, 14 Nov 2025 08:53:48 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::744:4bc9:832c:9b7e%10]) with mapi id
 15.02.1544.027; Fri, 14 Nov 2025 08:53:48 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next] wifi: rtw89: use separated function to set RX
 filter
Thread-Topic: [PATCH rtw-next] wifi: rtw89: use separated function to set RX
 filter
Thread-Index: AQHcVF9jhiuO+ccme0KK2OoFehcsMLTwFIgAgAFEI4A=
Date: Fri, 14 Nov 2025 00:53:48 +0000
Message-ID: <fccadfe07e4244b993f44ac7315d3d52@realtek.com>
References: <20251113053459.34995-1-pkshih@realtek.com>
 <CAMuHMdVt+5yOA6tuasX4KQgZud5wtRwu0A15UkEfQJbcd_xvVw@mail.gmail.com>
In-Reply-To: <CAMuHMdVt+5yOA6tuasX4KQgZud5wtRwu0A15UkEfQJbcd_xvVw@mail.gmail.com>
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

SGkgR2VlcnQsDQoNCkdlZXJ0IFV5dHRlcmhvZXZlbiA8Z2VlcnRAbGludXgtbTY4ay5vcmc+IHdy
b3RlOg0KPiBIaSBQaW5nLWtlLA0KPiANCj4gT24gVGh1LCAxMyBOb3YgMjAyNSBhdCAwNjozNSwg
UGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+IHdyb3RlOg0KPiA+IE5vcm1hbGx5IHVz
ZSBydHc4OV93cml0ZTMyX21hc2soKSB3aXRoIGEgY29uc2VjdXRpdmUgYml0IG1hc2ssIGJ1dCBt
YXNrIG9mDQo+ID4gUlggZmlsdGVyIEJfQVhfUlhfRkxUUl9DRkdfTUFTSyBpcyBiaXRzIDMxLTIy
IGFuZCAxNS0wLCB3aGljaCBleGNsdWRlcyBiaXRzDQo+ID4gb2YgQl9BWF9SWF9NUERVX01BWF9M
RU5fTUFTSyAoYml0cyAyMS0xNikuDQo+ID4NCj4gPiBUaG91Z2ggdGhlIG9yaWdpbmFsIGxvZ2lj
IGlzIHdlbGwgdG8gc2V0IFJYIGZpbHRlciwgY2hhbmdlIGl0IHRvIGEgc2VwYXJhdGUNCj4gPiBm
dW5jdGlvbiB0byBhdm9pZCB0aGUgdHJpY2t5IGRlc2lnbi4NCj4gPg0KPiA+IENjOiBHZWVydCBV
eXR0ZXJob2V2ZW4gPGdlZXJ0QGxpbnV4LW02OGsub3JnPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFBp
bmctS2UgU2hpaCA8cGtzaGloQHJlYWx0ZWsuY29tPg0KPiANCj4gUmV2aWV3ZWQtYnk6IEdlZXJ0
IFV5dHRlcmhvZXZlbiA8Z2VlcnQrcmVuZXNhc0BnbGlkZXIuYmU+DQo+IA0KPiA+IEkgcGxhbiB0
byBoYXZlIHRoaXMgY2hhbmdlIGluIG5leHQgcmVsZWFzZSBjeWNsZSwgYW5kIHRoZW4geW91IGNh
biBzZW5kDQo+ID4geW91ciBwYXRjaGVzIHdpdGhvdXQgZXJyb3JzIGNhdXNlZCBieSB0aGlzLg0K
PiANCj4gSSBmb3VuZCB0d28gbW9yZSBjbGFzc2VzIG9mIGlzc3VlczoNCj4gDQo+ICAgMS4gZHJp
dmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OS9ydHc4ODUyYV9yZmsuYyBoYXMgdHdpY2U6
DQo+IA0KPiAgICAgICAgICAgcnR3ODlfcGh5X3dyaXRlMzJfbWFzayhydHdkZXYsIFJfQURDX0ZJ
Rk8sIEJfQURDX0ZJRk9fUlNULCAweDAzMDMpOw0KPiANCj4gICAgICBCX0FEQ19GSUZPX1JTVCBp
cyBvbmx5IDggYml0cyB3aWRlLCBzbyAweDAzMDMgZG9lcyBub3QgZml0Lg0KPiAgICAgIE90aGVy
IGNhbGwgc2l0ZXMgd3JpdGUgdGhlIG1hZ2ljIHZhbHVlIDB4MDMwMyB0byBCX0FEQ19GSUZPX1JY
SywNCj4gICAgICBzbyBwZXJoYXBzIHRoYXQgZmllbGQgd2FzIGludGVuZGVkPw0KPiANCj4gICAg
ICAgICAgI2RlZmluZSBCX0FEQ19GSUZPX1JTVCBHRU5NQVNLKDMxLCAyNCkNCj4gICAgICAgICAg
I2RlZmluZSBCX0FEQ19GSUZPX1JYSyBHRU5NQVNLKDMxLCAxNikNCg0KQnkgdmVuZG9yIGRyaXZl
ciwgaXQgc2hvdWxkIGJlIEJfQURDX0ZJRk9fUlhLLiBJIHdpbGwgY29ycmVjdCBpdC4NCg0KPiAN
Cj4gICAyLiBkcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg5L3J0dzg4NTFiLmMNCj4g
ICAgICBkcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg5L3J0dzg4NTJiLmMNCj4gICAg
ICBkcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg5L3J0dzg4NTJjLmMNCj4gDQo+ICAg
ICAgICAgICAgX193cml0ZV9jdHJsKFJfQVhfUFdSX0NPRVhUX0NUUkwsIEJfQVhfVFhBR0NfQlRf
TUFTSywgdmFsLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICBCX0FYX1RYQUdDX0JUX0VOLCBh
cmcuY3RybF9nbnRfYnQgIT0gMHhmZmZmKTsNCj4gDQo+ICAgICAgQl9BWF9UWEFHQ19CVF9NQVNL
IGFuZCBCX0FYX1RYQUdDX0JUX0VOIGFyZSBjb21iaW5lZCwNCj4gICAgICB0aHVzIGZvcm1pbmcg
YSBub24tY29uc2VjdXRpdmUgbWFzay4NCj4gDQo+ICAgICAgICAgICNkZWZpbmUgQl9BWF9UWEFH
Q19CVF9FTiBCSVQoMSkNCj4gICAgICAgICAgI2RlZmluZSBCX0FYX1RYQUdDX0JUX01BU0sgR0VO
TUFTSygxMSwgMykNCg0KSSB3aWxsIGNvbnZlcnQgdGhpcyB0byBzb21ldGhpbmcgbGlrZSB0aGUg
c3R5bGUgb2YgdGhpcyBwYXRjaC4NCg0KDQo=

