Return-Path: <linux-wireless+bounces-27717-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BFBE9BAADA6
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Sep 2025 03:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C7FF7A23CF
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Sep 2025 01:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA5F94315F;
	Tue, 30 Sep 2025 01:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="gy3W9hE0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199AF10785;
	Tue, 30 Sep 2025 01:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759195191; cv=none; b=Vrz7HgTTkE5o7rR4Qjv3EsXuZzNKZvWLfwW0qeijuT+oT+nI2jTE+gufRpRYBcoiUoQViXJsQVr97PV6Qkfo3XThBxdeBbaugSCYsUyOPxYeCiZjMr0INVOz3LMgVzURrwCr8vMRBeY3z2ZAQzzzvmCavXsCBpfR2j5qASi1fpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759195191; c=relaxed/simple;
	bh=+X2eBqyYecJUmoG6ArUGAgGMpp0cB/of+2r97/XfFJU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oVUmAa8dHM3wh4dh543rMHfHT+6CllnZB1NfJYdND4gWR6aZ+SADERzimAJS3IuVF74WxCVY65sgvjWliAs46n/DJTbhgVuVd2HD7LQCGTFqu6TqhmyAN7aCmkrD3iaXoGSw2vIIct0DebaOja9ktU0fAt0tIIjYDgIDutnaLhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=gy3W9hE0; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 58U1Je1S2181329, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1759195181; bh=+X2eBqyYecJUmoG6ArUGAgGMpp0cB/of+2r97/XfFJU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=gy3W9hE08IbBsaO1dhFrCuN/3YJ9HeM9xs58AcWFe3Pc8khpwVF8+8AiKcXJy1eH3
	 BE9C3dQ6D2eRLbtnciXHxVeMQZb8WhVVOyc/jALzL+nXEE+hlo9NVofJZYqjshipEr
	 H4FOLwbz9XFWOrQ/liu0Jmr3LkryJUGsuRyYaqoljWo6gU4B9hXeYwV3e+sl2G65gB
	 arT2SvlbFeIQKn+NFqNoJAwYKYhRUSHAAoesnIvW7Byi8X+YaB8jxqU714psGYm0dS
	 KmOorT/ckkoVT7TyYiOwVKzf72e2Je4WrCM73/Wkx6C848rUuA8ZVe6b8afpiIktnq
	 /NqqG0ZSnZmbg==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 58U1Je1S2181329
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Sep 2025 09:19:40 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Tue, 30 Sep 2025 09:19:41 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::c39a:c87d:b10b:d090]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::c39a:c87d:b10b:d090%10]) with mapi id
 15.02.1544.027; Tue, 30 Sep 2025 09:19:41 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Yu-Chun Lin <eleanor15x@gmail.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jserv@ccns.ncku.edu.tw" <jserv@ccns.ncku.edu.tw>,
        "visitorckw@gmail.com"
	<visitorckw@gmail.com>,
        =?big5?B?U3RhbmxleSBDaGFuZ1up96h8vHdd?=
	<stanley_chang@realtek.com>,
        =?big5?B?Q1lfSHVhbmdbtsDgsq7LXQ==?=
	<cy.huang@realtek.com>
Subject: RE: [PATCH rtw-next v2] wifi: rtw89: Replace hardcoded strings with helper functions
Thread-Topic: [PATCH rtw-next v2] wifi: rtw89: Replace hardcoded strings with
 helper functions
Thread-Index: AQHcMZ3/mdEYn0w0EUij6sEji8MiZbSq7NTQ
Date: Tue, 30 Sep 2025 01:19:41 +0000
Message-ID: <a7b36065cc1549a6aa8c2f2c95bdad3f@realtek.com>
References: <20250930000545.2192692-1-eleanor15x@gmail.com>
In-Reply-To: <20250930000545.2192692-1-eleanor15x@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

WXUtQ2h1biBMaW4gPGVsZWFub3IxNXhAZ21haWwuY29tPiB3cm90ZToNCj4gUmVwbGFjZSBoYXJk
Y29kZWQgc3RyaW5ncyB3aXRoICdzdHJfb25fb2ZmKCknLCAnc3RyX2VuYWJsZV9kaXNhYmxlKCkn
LA0KPiBhbmQgJ3N0cl9yZWFkX3dyaXRlKCknLg0KPiANCj4gVGhlIGNoYW5nZSBpbXByb3ZlcyBy
ZWFkYWJpbGl0eS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFl1LUNodW4gTGluIDxlbGVhbm9yMTV4
QGdtYWlsLmNvbT4NCg0KQWNrZWQtYnk6IFBpbmctS2UgU2hpaCA8cGtzaGloQHJlYWx0ZWsuY29t
Pg0KDQoNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODkv
d293LmMgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg5L3dvdy5jDQo+IGluZGV4
IDVmYWE1MWFkODk2YS4uNjk1MGZlZDk2MjY3IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC93
aXJlbGVzcy9yZWFsdGVrL3J0dzg5L3dvdy5jDQo+ICsrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNz
L3JlYWx0ZWsvcnR3ODkvd293LmMNCj4gQEAgLTEsNiArMSw3IEBADQo+ICAvLyBTUERYLUxpY2Vu
c2UtSWRlbnRpZmllcjogR1BMLTIuMCBPUiBCU0QtMy1DbGF1c2UNCj4gIC8qIENvcHlyaWdodChj
KSAyMDE5LTIwMjIgIFJlYWx0ZWsgQ29ycG9yYXRpb24NCj4gICAqLw0KPiArDQoNCk5vIG5lZWQg
dG8gYWRkIHRoaXMgYmxpbmsgbGluZS4gSSdsbCByZW1vdmUgdGhpcyB3aGVuIG1lcmdpbmcgcGF0
Y2guIA0KKFNlbmRpbmcgdjMgaXMgYWxzbyBmaW5lIHRvIG1lKQ0KDQo+ICAjaW5jbHVkZSAiY2Ft
LmgiDQo+ICAjaW5jbHVkZSAiY29yZS5oIg0KPiAgI2luY2x1ZGUgImRlYnVnLmgiDQo+IEBAIC0x
MjQ4LDcgKzEyNDksNyBAQCBzdGF0aWMgaW50IHJ0dzg5X3dvd19jaGVja19md19zdGF0dXMoc3Ry
dWN0IHJ0dzg5X2RldiAqcnR3ZGV2LCBib29sIHdvd19lbmFibGUpDQo+ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIG1hYy0+d293X2N0cmwuYWRkciwgbWFjLT53b3dfY3Ry
bC5tYXNrKTsNCj4gICAgICAgICBpZiAocmV0KQ0KPiAgICAgICAgICAgICAgICAgcnR3ODlfZXJy
KHJ0d2RldiwgImZhaWxlZCB0byBjaGVjayB3b3cgc3RhdHVzICVzXG4iLA0KPiAtICAgICAgICAg
ICAgICAgICAgICAgICAgIHdvd19lbmFibGUgPyAiZW5hYmxlZCIgOiAiZGlzYWJsZWQiKTsNCj4g
KyAgICAgICAgICAgICAgICAgICAgICAgICBzdHJfZW5hYmxlZF9kaXNhYmxlZCh3b3dfZW5hYmxl
KSk7DQo+ICAgICAgICAgcmV0dXJuIHJldDsNCj4gIH0NCj4gDQo+IC0tDQo+IDIuMzQuMQ0KDQo=

