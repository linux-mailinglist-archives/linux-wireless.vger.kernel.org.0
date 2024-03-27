Return-Path: <linux-wireless+bounces-5318-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA4888DA46
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Mar 2024 10:31:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4189E29B58A
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Mar 2024 09:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA171F606;
	Wed, 27 Mar 2024 09:31:21 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F580171D2
	for <linux-wireless@vger.kernel.org>; Wed, 27 Mar 2024 09:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711531881; cv=none; b=kVVAUiM5bjXCG/TqSBLMnoPwzdSEcHfSippzsyECh44lRu64bdtVj9mfBwoaYoDwOFlRzet7O2WbChVYkzbYB/GnpSYVfP+OT4ZVcEZzan8cX8b2hhcSd3PCC9urNEFVf6dN3WBfJl5+0C/aHfiOM7+3sas25SfMghMBagFYs3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711531881; c=relaxed/simple;
	bh=WUKXPErArQ261sLs1cPxTLoNn8aYpyKhxpT/z24H58A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Th5OuKSUexN9HZYFdbDy1r1DEDBZ7nama6Zj8rU/8hS1gsLLR7/Smvb6L3xwjnNTESO73VIy60FS5KPC+914MN0NJsPEPUIInNTOhRRQv35T4Ww8veHqZoT8jytnFxdNez/iXNn5NkPmu4DH5KxBl0XtIOBI+spnOyKS0o9ALIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 42R9UZ6h8763952, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 42R9UZ6h8763952
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Mar 2024 17:30:35 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 27 Mar 2024 17:30:36 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 27 Mar 2024 17:30:35 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c42:f80:bcc2:d00f]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c42:f80:bcc2:d00f%5]) with mapi id
 15.01.2507.035; Wed, 27 Mar 2024 17:30:35 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: "kvalo@kernel.org" <kvalo@kernel.org>,
        "rtl8821cerfe2@gmail.com"
	<rtl8821cerfe2@gmail.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Larry.Finger@lwfinger.net" <Larry.Finger@lwfinger.net>,
        "s.l-h@gmx.de"
	<s.l-h@gmx.de>,
        "chewitt@libreelec.tv" <chewitt@libreelec.tv>
Subject: Re: [PATCH v3 04/12] wifi: rtlwifi: Add rtl8192du/table.{c,h}
Thread-Topic: [PATCH v3 04/12] wifi: rtlwifi: Add rtl8192du/table.{c,h}
Thread-Index: AQHaev3qY3Nayk5vYE26xHTZIDMXTLFCmpOAgAcv14CAAY8s8v//fNcA
Date: Wed, 27 Mar 2024 09:30:35 +0000
Message-ID: <5d117cf09134b034e704b8a1b5167235963a9c88.camel@realtek.com>
References: <7f4b3309-1580-48f3-9426-29f1eb4052fd@gmail.com>
	 <ed50254c-889e-4dcd-93db-f63b776e3503@gmail.com>
	 <5170c29a7b565fdec2e004f9391d325328ef5a72.camel@realtek.com>
	 <8a90f3cb-7218-4f23-8aa7-fcc68e2f4a93@gmail.com>
	 <87y1a4yqvh.fsf@kernel.org>
In-Reply-To: <87y1a4yqvh.fsf@kernel.org>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
user-agent: Evolution 3.36.1-2 
Content-Type: text/plain; charset="utf-8"
Content-ID: <BADF21C715B8D04798118596D796244F@realtek.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

T24gV2VkLCAyMDI0LTAzLTI3IGF0IDExOjE4ICswMjAwLCBLYWxsZSBWYWxvIHdyb3RlOg0KPiAN
Cj4gQml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyaXRlczoNCj4g
DQo+ID4gPiA+IC0tLSAvZGV2L251bGwNCj4gPiA+ID4gKysrIGIvZHJpdmVycy9uZXQvd2lyZWxl
c3MvcmVhbHRlay9ydGx3aWZpL3J0bDgxOTJkdS90YWJsZS5jDQo+ID4gPiA+IEBAIC0wLDAgKzEs
MTY3NSBAQA0KPiA+ID4gPiArLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjANCj4g
PiA+ID4gKy8qIENvcHlyaWdodChjKSAyMDA5LTIwMTIgIFJlYWx0ZWsgQ29ycG9yYXRpb24uKi8N
Cj4gPiA+ID4gKw0KPiA+ID4gPiArI2luY2x1ZGUgPGxpbnV4L3R5cGVzLmg+DQo+ID4gPiA+ICsN
Cj4gPiA+ID4gKyNpbmNsdWRlICJ0YWJsZS5oIg0KPiA+ID4gPiArDQo+ID4gPiA+ICt1MzIgcnRs
ODE5MmR1X3BoeV9yZWdfMnRhcnJheVtQSFlfUkVHXzJUX0FSUkFZTEVOR1RIXSA9IHsNCj4gPiA+
IA0KPiA+ID4gc3RhdGljIGNvbnN0ID8NCj4gPiA+IA0KPiA+ID4gPiArDQo+ID4gPiA+ICt1MzIg
cnRsODE5MmR1X3BoeV9yZWdfYXJyYXlfcGdbUEhZX1JFR19BUlJBWV9QR19MRU5HVEhdID0gew0K
PiA+ID4gDQo+ID4gPiBzdGF0aWMgY29uc3QgPw0KPiA+ID4gDQo+ID4gDQo+ID4gSSBjYW4gbWFr
ZSB0aGVtIHN0YXRpYyBpZiBJIG1vdmUgdGhlbSB0byB0YWJsZS5oLiBPbmx5IHBoeS5jDQo+ID4g
aW5jbHVkZXMgdGhpcyBoZWFkZXIsIHNvIHRoYXQgc2hvdWxkIGJlIGZpbmUuDQo+IA0KPiBEbyBu
b3RlIHRoYXQgLmggZmlsZXMgY2FuJ3QgY29udGFpbiBzdGF0aWMgdmFyaWFibGVzLCBvdGhlcndp
c2UgdGhlcmUNCj4gd2lsbCBiZSBkdXBsaWNhdGUgZGF0YS4NCj4gDQoNCkluZGVlZCwgc28gdGhl
c2UgY2FzZXMgc2hvdWxkIGJlICdjb25zdCB1MzInLCBubyBuZWVkICdzdGF0aWMnLiANCg0KDQo=

