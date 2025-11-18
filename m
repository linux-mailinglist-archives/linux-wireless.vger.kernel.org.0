Return-Path: <linux-wireless+bounces-29074-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 87187C67140
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Nov 2025 03:59:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 80C1E4EB938
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Nov 2025 02:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5745262FC0;
	Tue, 18 Nov 2025 02:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="M8QSqxgS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94BA283FDC
	for <linux-wireless@vger.kernel.org>; Tue, 18 Nov 2025 02:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763434772; cv=none; b=ubtawjKjGzUI+OiTKfFpzGZfGluQYWmQGDcd4Dh00lJuIjAwCGJBQHs0rrCVH1lGRa1hHnzct3L2OKH/lA771xpEXvPP9hkIut8t8sCt7MSBEZcyy9q0IItokAQ699SCGMnHDRP8hTtYhaurFf5hPG7HALcC352038goeb2BKCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763434772; c=relaxed/simple;
	bh=z6WpuBPwzOsdpz9UCRN+1CNXdyDGlU2GocetumnsxUg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lzKTsBdrgDBtSpXEU/IcSmbShnARgFw4JucDo/L56mMTLykqFCZp9Fec7ybiBJrPbXXGSQuF+ZC2rnv6gBAfTVmR/3W2eD1a/Vjriscehel/852rFy7WrX16f5xduf8Z7BeUhPtulXY9c92bPxp0h74PjTvR/AFAHdbi1iikWJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=M8QSqxgS; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5AI2xQ001693376, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1763434766; bh=z6WpuBPwzOsdpz9UCRN+1CNXdyDGlU2GocetumnsxUg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=M8QSqxgSW0U7AlILeI9sABhN9fyb4vUVAp4D/jqEwUOxGaUUDtmm/Ao2peVEC/hGZ
	 T4ooQ/MBr4cO7KBWYHzcXnZEjTCyPwHey20icreSabW2MrdX4/arBYBQWpEQXZRgWa
	 xCAqvXyx/ifWzGMsVdStQFeborqLwChnQTJryLdVHSuuyzfdrxZp4hjVPcYADSVc9Y
	 oH4kGrreJZukOJFD9LW88BbB9xcjXme0IlYPomS3KgkMHF5FDnnwdwiF++zmELQj9T
	 UOSFkv1VilblUWV/sbvJHUDv4WN1p3o6tMGVWLOBAnBPSZOtvQsBvMpIpA9S4k1Od4
	 9xp9sPRyftdIg==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5AI2xQ001693376
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Nov 2025 10:59:26 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Tue, 18 Nov 2025 10:59:26 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::744:4bc9:832c:9b7e%10]) with mapi id
 15.02.1544.027; Tue, 18 Nov 2025 10:59:26 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Jes Sorensen <Jes.Sorensen@gmail.com>
Subject: RE: [PATCH rtw-next 4/5] wifi: rtl8xxxu: Fix RX channel width
 reported by RTL8192FU
Thread-Topic: [PATCH rtw-next 4/5] wifi: rtl8xxxu: Fix RX channel width
 reported by RTL8192FU
Thread-Index: AQHcVzfjMbkwLSTgKEOo+HgLaiSJBLT3v/NA
Date: Tue, 18 Nov 2025 02:59:26 +0000
Message-ID: <988bfe53bd5b42bbb411745f34114db1@realtek.com>
References: <b735b9c6-f17f-405a-8972-a7c98f3c89e2@gmail.com>
 <afd60ba6-4af8-4944-a915-4e2b814bbed3@gmail.com>
In-Reply-To: <afd60ba6-4af8-4944-a915-4e2b814bbed3@gmail.com>
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

DQpCaXR0ZXJibHVlIFNtaXRoIDxydGw4ODIxY2VyZmUyQGdtYWlsLmNvbT4gd3JvdGU6DQo+IFRo
ZSBvdGhlciBjaGlwcyByZXBvcnQgdGhlIFJYIGNoYW5uZWwgd2lkdGggaW4gdGhlIFJYIGRlc2Ny
aXB0b3IsDQo+IGJ1dCB0aGlzIG9uZSBkb2Vzbid0Lg0KPiANCj4gR2V0IHRoZSBSWCBjaGFubmVs
IHdpZHRoIGZyb20gdGhlIFBIWSBzdGF0dXMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBCaXR0ZXJi
bHVlIFNtaXRoIDxydGw4ODIxY2VyZmUyQGdtYWlsLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IFBpbmct
S2UgU2hpaCA8cGtzaGloQHJlYWx0ZWsuY29tPg0KDQoNCj4gLS0tDQo+ICBkcml2ZXJzL25ldC93
aXJlbGVzcy9yZWFsdGVrL3J0bDh4eHh1L2NvcmUuYyB8IDEyICsrKysrKysrKysrLQ0KPiAgMSBm
aWxlIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0bDh4eHh1L2NvcmUuYw0KPiBi
L2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnRsOHh4eHUvY29yZS5jDQo+IGluZGV4IDcz
OTQ1NjY0MGNhOC4uNjY4MDE4MjI5ZjdjIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC93aXJl
bGVzcy9yZWFsdGVrL3J0bDh4eHh1L2NvcmUuYw0KPiArKysgYi9kcml2ZXJzL25ldC93aXJlbGVz
cy9yZWFsdGVrL3J0bDh4eHh1L2NvcmUuYw0KPiBAQCAtNTcwMSw3ICs1NzAxLDcgQEAgc3RhdGlj
IHZvaWQgamFndWFyMl9yeF9wYXJzZV9waHlzdGF0c190eXBlMShzdHJ1Y3QgcnRsOHh4eHVfcHJp
diAqcHJpdiwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICFydGw4eHh4dV9pc19zdGFfc3Rh
KHByaXYpICYmDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAocnRsOHh4eHVfaXNfcGFja2V0
X21hdGNoX2Jzc2lkKHByaXYsIGhkciwgMCkgfHwNCj4gICAgICAgICAgICAgICAgICAgICAgICAg
ICBydGw4eHh4dV9pc19wYWNrZXRfbWF0Y2hfYnNzaWQocHJpdiwgaGRyLCAxKSk7DQo+IC0gICAg
ICAgdTggcHdkYl9tYXggPSAwOw0KPiArICAgICAgIHU4IHB3ZGJfbWF4ID0gMCwgcnhzYzsNCj4g
ICAgICAgICBpbnQgcnhfcGF0aDsNCj4gDQo+ICAgICAgICAgaWYgKHBhcnNlX2Nmbykgew0KPiBA
QCAtNTcxNiw2ICs1NzE2LDE2IEBAIHN0YXRpYyB2b2lkIGphZ3VhcjJfcnhfcGFyc2VfcGh5c3Rh
dHNfdHlwZTEoc3RydWN0IHJ0bDh4eHh1X3ByaXYgKnByaXYsDQo+ICAgICAgICAgICAgICAgICBw
d2RiX21heCA9IG1heChwd2RiX21heCwgcGh5X3N0YXRzMS0+cHdkYltyeF9wYXRoXSk7DQo+IA0K
PiAgICAgICAgIHJ4X3N0YXR1cy0+c2lnbmFsID0gcHdkYl9tYXggLSAxMTA7DQo+ICsNCj4gKyAg
ICAgICBpZiAocnhtY3MgPiBERVNDX1JBVEVfMTFNICYmIHJ4bWNzIDwgREVTQ19SQVRFX01DUzAp
DQoNCk5pdDogd291bGQgaXQgYmUgY2xlYXIgdGhhdCAnIGlmIChyeG1jcyA+PSBERVNDX1JBVEVf
Nk0gJiYgcnhtY3MgPD0gREVTQ19SQVRFXzU0TSknID8NCg0KPiArICAgICAgICAgICAgICAgcnhz
YyA9IHBoeV9zdGF0czEtPmxfcnhzYzsNCj4gKyAgICAgICBlbHNlDQo+ICsgICAgICAgICAgICAg
ICByeHNjID0gcGh5X3N0YXRzMS0+aHRfcnhzYzsNCj4gKw0KPiArICAgICAgIGlmIChwaHlfc3Rh
dHMxLT5yZl9tb2RlID09IDAgfHwgcnhzYyA9PSAxIHx8IHJ4c2MgPT0gMikNCj4gKyAgICAgICAg
ICAgICAgIHJ4X3N0YXR1cy0+YncgPSBSQVRFX0lORk9fQldfMjA7DQo+ICsgICAgICAgZWxzZQ0K
PiArICAgICAgICAgICAgICAgcnhfc3RhdHVzLT5idyA9IFJBVEVfSU5GT19CV180MDsNCj4gIH0N
Cj4gDQo+ICBzdGF0aWMgdm9pZCBqYWd1YXIyX3J4X3BhcnNlX3BoeXN0YXRzX3R5cGUyKHN0cnVj
dCBydGw4eHh4dV9wcml2ICpwcml2LA0KPiAtLQ0KPiAyLjUxLjENCg0K

