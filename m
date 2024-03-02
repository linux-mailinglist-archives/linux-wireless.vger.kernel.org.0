Return-Path: <linux-wireless+bounces-4310-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F56886ED77
	for <lists+linux-wireless@lfdr.de>; Sat,  2 Mar 2024 01:34:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9BC11F22DB2
	for <lists+linux-wireless@lfdr.de>; Sat,  2 Mar 2024 00:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE523A32;
	Sat,  2 Mar 2024 00:33:59 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DE7801;
	Sat,  2 Mar 2024 00:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709339639; cv=none; b=WVPKLYeckPD01A3vVBM2C6kXVj/u+iWMicnbMmIYlgevYDa+Eo5bB1ZQroygb9RXd9AtAhVKsZF845JQxaDDBpnSSKz3ZQbSyKnG6kRPXGEZO1k6BTXsVB/mu9teDFJnkzIjF92jXyaK0URnmH2istjN9Gwv/rkcmctpfoOASv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709339639; c=relaxed/simple;
	bh=RJxu0g3yBOIhnalI2t/nCNkyXfE69tQXXMpyWxcUpQw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UQ4qIYC6G2me5S/pynBK+khA4DOBINBwtqrCmixZZCzmQ17pJxXHbh4CICrYfdZOXal/gLcesDSkVG1MWwjKJ4DBqOxKF8P8PKIJnPW5xDimRsqUCLrcqhPQ5FmeTLXSR7/UznlJhWXmrEjYP2K5sjwK5ugCpNxcJVPhWa2067A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4220Xe4722363131, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4220Xe4722363131
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 2 Mar 2024 08:33:40 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.32; Sat, 2 Mar 2024 08:33:41 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sat, 2 Mar 2024 08:33:40 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f]) by
 RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f%7]) with mapi id
 15.01.2507.035; Sat, 2 Mar 2024 08:33:40 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "fiona.klute@gmx.de" <fiona.klute@gmx.de>
CC: "kvalo@kernel.org" <kvalo@kernel.org>,
        "ulf.hansson@linaro.org"
	<ulf.hansson@linaro.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "megi@xff.cz"
	<megi@xff.cz>
Subject: Re: [PATCH v2 4/9] wifi: rtw88: Add rtw8703b.h
Thread-Topic: [PATCH v2 4/9] wifi: rtw88: Add rtw8703b.h
Thread-Index: AQHaadiMK/BK89PGSkKvgAdLkkf/lLEiJPZAgABuMQCAAIVfgA==
Date: Sat, 2 Mar 2024 00:33:40 +0000
Message-ID: <613176601db939f6e078b398c4207b6cd279b120.camel@realtek.com>
References: <20240227235507.781615-1-fiona.klute@gmx.de>
	 <20240227235507.781615-5-fiona.klute@gmx.de>
	 <368ebc04c2ec436791a27b5661189783@realtek.com>
	 <db9e7f0d-a60f-467b-82df-da6170d02151@gmx.de>
In-Reply-To: <db9e7f0d-a60f-467b-82df-da6170d02151@gmx.de>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
user-agent: Evolution 3.36.1-2 
x-kse-serverinfo: RTEXMBS02.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-ID: <CF624BE9BC0D4B4A9023C2792BFABAD7@realtek.com>
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

T24gRnJpLCAyMDI0LTAzLTAxIGF0IDE3OjM1ICswMTAwLCBGaW9uYSBLbHV0ZSB3cm90ZToNCj4g
DQo+IEFtIDAxLjAzLjI0IHVtIDAzOjA5IHNjaHJpZWIgUGluZy1LZSBTaGloOg0KPiA+ID4gKysr
IGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OC9ydHc4NzAzYi5oDQo+ID4gPiBA
QCAtMCwwICsxLDEwMyBAQA0KPiA+ID4gKy8qIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwt
Mi4wIE9SIEJTRC0zLUNsYXVzZSAqLw0KPiA+ID4gKy8qIENvcHlyaWdodCBGaW9uYSBLbHV0ZSA8
ZmlvbmEua2x1dGVAZ214LmRlPiAqLw0KPiA+ID4gKw0KPiA+ID4gKyNpZm5kZWYgX19SVFc4NzAz
Ql9IX18NCj4gPiA+ICsjZGVmaW5lIF9fUlRXODcwM0JfSF9fDQo+ID4gPiArDQo+ID4gPiArI2lu
Y2x1ZGUgPGxpbnV4L3R5cGVzLmg+DQo+ID4gPiArI2luY2x1ZGUgPGxpbnV4L2NvbXBpbGVyX2F0
dHJpYnV0ZXMuaD4NCj4gPiANCj4gPiBSZW1vdmluZyB0aGVzZSB0d28gaGVhZGVycyBjYW4gc3Rp
bGwgY29tcGlsZWQgcGFzcyBpbiBteSBzaWRlLiBQbGVhc2UgY2hlY2sgd2h5DQo+ID4geW91IG5l
ZWQgdGhlbS4NCj4gDQo+IElmIEkgcmVtb3ZlIHRoZW0gd2hldGhlciB0aGUgY29kZSBjb21waWxl
cyBkZXBlbmRzIG9uIHRoZSBvcmRlciBvZg0KPiAjaW5jbHVkZXMuIElmIHNvbWUgb3RoZXIgaGVh
ZGVyIHRoYXQgaW5jbHVkZXMgdGhvc2UgdHdvIGlzIGluY2x1ZGVkDQo+IGJlZm9yZSBydHc4NzAz
Yi5oIGl0IHdvcmtzLCBvdGhlcndpc2UgaXQgd2lsbCBicmVhay4gSSBkb24ndCB0aGluaw0KPiB0
aGF0J3MgZGVzaXJhYmxlLCB0aG91Z2ggb3RoZXIgcnR3ODggaGVhZGVycyBhbHJlYWR5IGJlaGF2
ZSB0aGF0IHdheQ0KPiAoZS5nLiBtYWluLmggbXVzdCBiZSBpbmNsdWRlZCBiZWZvcmUgdGhlIG90
aGVycykuIEFsc28sIGNsYW5nZCB3aWxsDQo+IGNvbXBsYWluIGFib3V0IHVuZGVmaW5lZCB0eXBl
cyAodTgsIHM4KSwgd2hpY2ggaXMgbGVzcyBpbXBvcnRhbnQgYnV0DQo+IHN0aWxsIGFubm95aW5n
IHdoZW4gd29ya2luZyBvbiB0aGUgY29kZS4gU28gSSdkIHByZWZlciB0byBrZWVwIHRoZSBpbmNs
dWRlcy4NCj4gDQo+ID4gQnkgdGhlIHdheSwgcnR3ODcyM2QuaCBkb2VzDQo+ID4gICAgICNpbmNs
dWRlICJydHc4NzIzeC5oIg0KPiA+IA0KPiA+IENhbiB3ZSB1c2UgdGhlIHNhbWUgc3R1ZmY/DQo+
IA0KPiBJIGRvbid0IHRoaW5rIHNvLiBUaGUgdmVuZG9yIGRyaXZlciBoYXMgZGlmZmVyZW50IGNv
ZGUgcGF0aHM6IFdpdGggODcyM0QNCj4gaXQgdGFrZXMgb25lIGZvciAiUEhZU1RTXzJORF9UWVBF
X0lDIiBbMV0sIHdpdGggODcwM0IgdGhlIG9uZSBmb3INCj4gIk9ETV9JQ18xMU5fU0VSSUVTIiBh
IGZldyBsaW5lcyBiZWxvdy4gRm9yIHRob3NlICIybmQgdHlwZSIgSUNzIHRoZXJlDQo+IGFyZSBk
aWZmZXJlbnQgc3RydWN0cyBkZXBlbmRpbmcgb24gdGhlIHBhZ2UgbnVtYmVyDQo+IChwaHlfc3Rz
X3JwdF9qZ3IyX3R5cGVbMC0yXSksIHdoaWxlIHRoZSAiMTFOIHNlcmllcyIgb25lcyBhbHdheXMg
dXNlDQo+IHBoeV9zdGF0dXNfcnB0XzgxOTJjZCAoYWxsIGRlZmluZWQgaW4gWzJdKS4NCj4gDQo+
IEhvd2V2ZXIsIHRoZSBtYWlubGluZSBydGx3aWZpIGRyaXZlciBoYXMgYW4gZXF1aXZhbGVudCBz
dHJ1Y3QgY2FsbGVkDQo+ICJwaHlfc3RhdHVzX3JwdCIgaW4NCj4gZHJpdmVycy9uZXQvd2lyZWxl
c3MvcmVhbHRlay9ydGx3aWZpL3J0bDg3MjNiZS90cnguaC4gSSBkb24ndCBrbm93IGlmDQo+IHNo
YXJpbmcgc3VjaCBkZWZpbml0aW9ucyBiZXR3ZWVuIGRpZmZlcmVudCBkcml2ZXJzIGlzIGRlc2ly
YWJsZS4gSWYgeWVzLA0KPiBwbGVhc2UgbGV0IG1lIGtub3cgd2hlcmUgdGhlIGhlYWRlciBzaG91
bGQgZ28uDQo+IA0KPiBbMV0NCj4gaHR0cHM6Ly94ZmYuY3ovZ2l0L2xpbnV4L3RyZWUvZHJpdmVy
cy9zdGFnaW5nL3J0bDg3MjNjcy9oYWwvcGh5ZG0vcGh5ZG1fcGh5c3RhdHVzLmM/aD1vcmFuZ2Ut
cGktNi43I24zMTQyDQo+IFsyXQ0KPiBodHRwczovL3hmZi5jei9naXQvbGludXgvdHJlZS9kcml2
ZXJzL3N0YWdpbmcvcnRsODcyM2NzL2hhbC9waHlkbS9waHlkbV9waHlzdGF0dXMuaD9oPW9yYW5n
ZS1waS02LjcNCj4gDQoNClNvcnJ5IGZvciBjb25mdXNpbmcuIEkgbWVhbnQgdG8gcmVtb3ZlDQog
ICAjaW5jbHVkZSA8bGludXgvdHlwZXMuaD4NCiAgICNpbmNsdWRlIDxsaW51eC9jb21waWxlcl9h
dHRyaWJ1dGVzLmg+DQphbmQgdG8gYWRkDQogICAjaW5jbHVkZSAicnR3ODcyM3guaCINCmxpa2Ug
cnR3ODcyM2QuaCBkb2VzIGFmdGVyIHRoaXMgcGF0Y2hzZXQsIG5vdCByZWZlcmVuY2UgdG8gdmVu
ZG9yIGRyaXZlci4gDQogIA0KUGluZy1LZSANCg0K

