Return-Path: <linux-wireless+bounces-14207-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 210E39A375E
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Oct 2024 09:38:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF7C3B24FAA
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Oct 2024 07:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A90452BAEF;
	Fri, 18 Oct 2024 07:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="id2ITAok"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C09C17C7C2
	for <linux-wireless@vger.kernel.org>; Fri, 18 Oct 2024 07:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729237079; cv=none; b=pltDh+gvAz6GyTtSK/Or1iHi+ESeX/A+XzB3pW5w5YuXJmJNzacWRtwffPmCteql5N3EwZxz0ABEBjSoXCjxpyvQhdntSsCH5mWbf20SqSNFKhf4bnFyFcaAQCiiDmj/zi/J9hHs88etCmMudPkKYo2hUTdL5E/EfgUSyxME3q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729237079; c=relaxed/simple;
	bh=z5PdxxN3KUJ8jWB26/lccCGNJS+QjczC2+pLUnps45I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UVNy0yWYISGEySpfdy3vcgoO/HD/UxABb/99mfa15ghJmH5x/Q+B8k8+wnrJOONKMD95SmqcDcLWUHeo8AVaMOGev5bUCR0nAj9hlQjuEqE6LsGZOZ0fFJkOT0UrsLy4kZ73OpXYvJtff0Opn2I//B2UgDyHfrEdms5D11mBYKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=id2ITAok; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 49I7bj6bB1686848, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1729237065; bh=z5PdxxN3KUJ8jWB26/lccCGNJS+QjczC2+pLUnps45I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=id2ITAokO09LIzpjBVSaqtfpHFf/AKyfkUZdN1mcZBvWxyzf/X5/NFoFqVmpZLDOX
	 hceHBHvinFCltJSJG01/4NABxeT2wB2Ddhox9+oizKyYTC5AE29wji9P+Ap1CkUqqt
	 wh9GuF0BGCv2bGCRpIePtuDOExfWEj6E1edc6KI5rnPfIl+bE4ArXej78oTGAq+Z60
	 prpDV4obBGwpke51PNpVYibGJk9Q6C2nZcR3R9GMCM5VWNIWoJyTEirVdnf5nvFPZQ
	 MSIDNHlWNd4XZBaYf4XbqIiSWXg3EYc6wPmmPtiKaLeI6bR2iTzXX7XEOAqAm5lsYJ
	 EBb4/V3VjUNOg==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 49I7bj6bB1686848
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Oct 2024 15:37:45 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 18 Oct 2024 15:37:45 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 18 Oct 2024 15:37:44 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Fri, 18 Oct 2024 15:37:44 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Zenm Chen <zenmchen@gmail.com>, Christian Hewitt <chewitt@libreelec.tv>,
        Nick Morrow <usbwifi2024@gmail.com>
Subject: RE: [PATCH v2 22/22] wifi: rtw88: Enable the new RTL8821AU/RTL8812AU drivers
Thread-Topic: [PATCH v2 22/22] wifi: rtw88: Enable the new RTL8821AU/RTL8812AU
 drivers
Thread-Index: AQHbHCB89+4hh8e6LEqmMAl6w6BpxrKMJ9VQ
Date: Fri, 18 Oct 2024 07:37:44 +0000
Message-ID: <fe266bed9b3244f3a531e5e5fc04e344@realtek.com>
References: <d2870a44-9b91-4090-9a25-873eb62997f5@gmail.com>
 <144dc024-e82b-464a-8182-4b051c009cd8@gmail.com>
In-Reply-To: <144dc024-e82b-464a-8182-4b051c009cd8@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBUaGVz
ZSBhcmUgb2xkZXIgV2lmaSA1IGNoaXBzLiBSVEw4ODIxQVUgaXMgMXgxLCB3aXRoIG9yIHdpdGhv
dXQNCj4gQmx1ZXRvb3RoLiBSVEw4ODEyQVUgaXMgMngyLCB3aXRob3V0IEJsdWV0b290aC4NCj4g
DQo+IEJlYW1mb3JtaW5nIGlzIG5vdCBpbXBsZW1lbnRlZC4gSXQgbG9va3MgbGlrZSB0aGVzZSBj
aGlwcyBuZWVkIGENCj4gZGlmZmVyZW50IGltcGxlbWVudGF0aW9uIHRoYW4gd2hhdCBpcyBpbiBi
Zi5jLg0KPiANCj4gU3BlZWQgdGVzdHMgd2l0aCBSVEw4ODIxQVU6IDEzNyBNYnBzIGRvd25sb2Fk
LCAxNDQgTWJwcyB1cGxvYWQuDQo+IFNwZWVkIHRlc3RzIHdpdGggUlRMODgxMkFVOiAzNDQgTWJw
cyBkb3dubG9hZCwgMzg3IE1icHMgdXBsb2FkLg0KPiANCj4gU3RhdGlvbiBtb2RlIGFuZCBBUCBt
b2RlIHdlcmUgdGVzdGVkLg0KPiANCj4gQmx1ZXRvb3RoIGNvZXhpc3RlbmNlIHdvcmtzLiBJIHVz
ZWQgbXkgQmx1ZXRvb3RoIGhlYWRwaG9uZXMgZm9yDQo+IHNldmVyYWwgZGF5cywgbGlzdGVuaW5n
IHRvIG11c2ljIGFuZCB3YXRjaGluZyB2aWRlb3MuIFRoZXJlIGlzIG9ubHkNCj4gYSBwcm9ibGVt
IHdpdGggdGhlIHdpZmkgc3BlZWRzIHdpdGggb25lIHJvdXRlcjoNCj4gDQo+IFdpdGggSVNQJ3Mg
SEc2NTQ0QyByb3V0ZXI6DQo+IE9mZmljaWFsIGRyaXZlcjogMy81IE1icHMuDQo+IHJ0dzg4OiBh
IGJpdCBtb3JlLCBidXQgbm90IHN0ZWFkeSBhdCBhbGwuIE5vdCBlbm91Z2ggdG8gd2F0Y2ggYSAx
MDgwcA0KPiBZb3V0dWJlIHZpZGVvLg0KPiANCj4gV2l0aCBteSBELUxpbmsgRWFnbGUgUjMyIHJv
dXRlciBydW5uaW5nIE9wZW53cnQsIG9uIHRoZSBzYW1lIGNoYW5uZWw6DQo+IE9mZmljaWFsIGRy
aXZlcjogNi8xMCBNYnBzLg0KPiBydHc4ODogZG93bmxvYWQgc3RhcnRzIGFyb3VuZCAzMCwgY2xp
bWJzIHRvIDUwIC8gdXBsb2FkIGlzIDEwIE1icHMuDQo+IEkgY2FuIHdhdGNoIGEgMTA4MHAgWW91
dHViZSB2aWRlby4NCj4gDQo+IFRoZSBtdXNpYyBkb2Vzbid0IGN1dCBvdXQgZHVyaW5nIGFueSBz
cGVlZCB0ZXN0cy4NCj4gDQo+IEkgYWxzbyB0ZXN0ZWQgdHJhbnNmZXJyaW5nIGZpbGVzIHRvIGFu
ZCBmcm9tIG15IHBob25lLiBJIGRvbid0IGhhdmUNCj4gb3RoZXIgdHlwZXMgb2YgQmx1ZXRvb3Ro
IGRldmljZXMgdG8gdGVzdC4NCj4gDQoNClJlYWxseSBnb29kIHdvcmsuIE9ubHkgc29tZSBtaW5v
ciBzdWdnZXN0aW9ucyBmb3IgdjIuDQoNCg0KPiBAQCAtMTg5LDYgKzIwMCwyOCBAQCBjb25maWcg
UlRXODhfODgyMUNVDQo+IA0KPiAgICAgICAgICAgODAyLjExYWMgVVNCIHdpcmVsZXNzIG5ldHdv
cmsgYWRhcHRlcg0KPiANCj4gK2NvbmZpZyBSVFc4OF84ODIxQVUNCj4gKyAgICAgICB0cmlzdGF0
ZSAiUmVhbHRlayA4ODIxQVUgVVNCIHdpcmVsZXNzIG5ldHdvcmsgYWRhcHRlciINCg0KQWxzbyBt
ZW50aW9uIDg4MTFBVT8NCg0KPiArICAgICAgIGRlcGVuZHMgb24gVVNCDQo+ICsgICAgICAgc2Vs
ZWN0IFJUVzg4X0NPUkUNCj4gKyAgICAgICBzZWxlY3QgUlRXODhfVVNCDQo+ICsgICAgICAgc2Vs
ZWN0IFJUVzg4Xzg4MjFBDQo+ICsgICAgICAgaGVscA0KPiArICAgICAgICAgU2VsZWN0IHRoaXMg
b3B0aW9uIHdpbGwgZW5hYmxlIHN1cHBvcnQgZm9yIDg4MjFBVSBjaGlwc2V0DQo+ICsNCj4gKyAg
ICAgICAgIDgwMi4xMWFjIFVTQiB3aXJlbGVzcyBuZXR3b3JrIGFkYXB0ZXINCj4gKw0KDQo=

