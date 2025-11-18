Return-Path: <linux-wireless+bounces-29075-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B30C67150
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Nov 2025 04:01:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id A538828D37
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Nov 2025 03:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDFA52FE04A;
	Tue, 18 Nov 2025 03:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="ha8wm4r3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B953002D0
	for <linux-wireless@vger.kernel.org>; Tue, 18 Nov 2025 03:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763434895; cv=none; b=RYCXh0FsVRSX7067PJqoZMGJYPOGUWDfZLYAXEzTHMhdCSYobd8XaEHTp+oHdzysXeK+Aod7T5crf7j1j2e1ynuqHru0PMoPWsSilYhRfAosS9hucFsuNSHrNuZcxhgQGmF+fkCTBP/Tf1/9LbVnCEaXGb4Aq62vIKcbok+FIM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763434895; c=relaxed/simple;
	bh=GnyJWvEcnvFjhla2+b3CPw1f3nZVXsQ26zhb0l6+Zz4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TEoKYgac+uHIoMTXV5M+Oul2ZmUwdVmRFfa3doBbb/0EQMiQzB+U81d3Euy1XGbk6trZU8gnyqwO+PFayfX+S+DK18bWNb41hWETIUnxZ3gLAD3x8HA4dpxuIyqfBqFlqGq0BWsgn4EFwsZ9ADO87RPGN7sIKk94IAncYGTsN8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=ha8wm4r3; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5AI31UWJ0696038, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1763434890; bh=GnyJWvEcnvFjhla2+b3CPw1f3nZVXsQ26zhb0l6+Zz4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=ha8wm4r3C35Hg1Cidw2n+I+ekVNTR4Z7p+HW//Mhxp2Yz788A++kQQg7xXwZzxdGK
	 leoJoaKy18HjHKF0N3jKBEMlcCDhYzVk162VV7nbH/oCSAMRKM+ELEqSi8B5rdhF5Z
	 CJDFo1SFkcZHbKqTITlFgN65C/XXPTagQyZzcg0Q0kqflinvzLMDIqkzSBdTxVM/6K
	 xFjgiIw7rERRSqqX7T43wlTio4pk/3+RGkYUVvXFUN8RhB5JwPYNTUHug913yuL6UA
	 m0eCC4Qym73Q969yn1b/0JqwovV1+9td7wNkUfije1YHIu1KLlV457pXGlsMdJeeTD
	 vbwseTh7+J2dw==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5AI31UWJ0696038
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Nov 2025 11:01:30 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Tue, 18 Nov 2025 11:01:30 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::744:4bc9:832c:9b7e%10]) with mapi id
 15.02.1544.027; Tue, 18 Nov 2025 11:01:30 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Jes Sorensen <Jes.Sorensen@gmail.com>
Subject: RE: [PATCH rtw-next 5/5] wifi: rtl8xxxu: Enable 40 MHz width by
 default
Thread-Topic: [PATCH rtw-next 5/5] wifi: rtl8xxxu: Enable 40 MHz width by
 default
Thread-Index: AQHcVzgIWNmrmATwSkuI/wwe+xPa2LT3wLbg
Date: Tue, 18 Nov 2025 03:01:30 +0000
Message-ID: <bb7c1eb515c14d78b0089f4fab7f5fda@realtek.com>
References: <b735b9c6-f17f-405a-8972-a7c98f3c89e2@gmail.com>
 <5000a39b-0d0b-4625-aafb-be6fc668d6cd@gmail.com>
In-Reply-To: <5000a39b-0d0b-4625-aafb-be6fc668d6cd@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiA0MCBN
SHogc3VwcG9ydCBpcyBoaWRkZW4gYmVoaW5kIHRoZSBodDQwXzJnIG1vZHVsZSBwYXJhbWV0ZXIg
d2l0aA0KPiB0aGlzIGNvbW1lbnQ6DQo+IA0KPiAvKg0KPiAgKiBTb21lIEFQcyB3aWxsIG5lZ290
aWF0ZSBIVDIwXzQwIGluIGEgbm9pc3kgZW52aXJvbm1lbnQgbGVhZGluZw0KPiAgKiB0byBtaXNl
cmFibGUgcGVyZm9ybWFuY2UuIFJhdGhlciB0aGFuIGRlZmF1bHRpbmcgdG8gdGhpcywgb25seQ0K
PiAgKiBlbmFibGUgaXQgaWYgZXhwbGljaXRseSByZXF1ZXN0ZWQgYXQgbW9kdWxlIGxvYWQgdGlt
ZS4NCj4gICovDQo+IA0KPiBUaGlzIHBhcmFtZXRlciB3YXMgYWRkZWQgaW4gY29tbWl0IDI2ZjFm
YWQyOWFkOSAoIk5ldyBkcml2ZXI6DQo+IHJ0bDh4eHh1IChtYWM4MDIxMSkiKS4gQmFjayB0aGVu
IHJ0bDh4eHh1IG9ubHkgc3VwcG9ydGVkIFJUTDg3MjNBVQ0KPiBhbmQgdGhlIFJUTDgxOTJDVSBm
YW1pbHkuIEl0J3MgZW50aXJlbHkgcG9zc2libGUgdGhlIG1pc2VyYWJsZQ0KPiBwZXJmb3JtYW5j
ZSB3YXMgZHVlIHRvIG1pc3Rha2VzIGluIHRoZSBjaGFubmVsIHN3aXRjaGluZyBmdW5jdGlvbiwN
Cj4gd2hpY2ggd2VyZSBmaXhlZCBpbiBhIHByZXZpb3VzIHBhdGNoLg0KPiANCj4gRGVsZXRlIHRo
ZSBodDQwXzJnIG1vZHVsZSBwYXJhbWV0ZXIuIElmIHNvbWVvbmUgc3RpbGwgbmVlZHMgdG8NCj4g
ZGlzYWJsZSA0MCBNSHogc3VwcG9ydCwgY2ZnODAyMTEgaGFzIHRoZSBtb2R1bGUgcGFyYW1ldGVy
DQo+IGNmZzgwMjExX2Rpc2FibGVfNDBtaHpfMjRnaHouIFRoYXQgd29ya3MgdG9vLg0KPiANCj4g
U2lnbmVkLW9mZi1ieTogQml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+
DQoNClJldmlld2VkLWJ5OiBQaW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT4NCg0KDQo=

