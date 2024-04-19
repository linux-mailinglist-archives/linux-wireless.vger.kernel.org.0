Return-Path: <linux-wireless+bounces-6547-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7384B8AA6E2
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Apr 2024 04:19:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 289981F21A92
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Apr 2024 02:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 724D88C1E;
	Fri, 19 Apr 2024 02:19:06 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9AB56110
	for <linux-wireless@vger.kernel.org>; Fri, 19 Apr 2024 02:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713493146; cv=none; b=BsmJoTkt/bbWUrMvSpOsoqj6HWhFDLu7Kj9yEPMgIudIb+sFGhRqJpXWkBJwF+YnvkHVTX8ZBWmZ141lfV0MRZR7wsFYBgJy+FgvrRRe+T1QiaZG3kF6EDAL2ajhNK6wZhg3j3efuyFD16jywl6gymO12v1kBNSCsqPLzTFBRd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713493146; c=relaxed/simple;
	bh=Nbva3VB2YwXmAArQk+wa1p5ZDI89bVvB+9R7Lto4kJk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JirlWY9Bqenm64G2mg+SEycwP0aAoVBmIBm/++mS+DyRIK6U0RqslR5uIx07pV2PZS2slUqNcfVwtwQZDSP9gmkivaEBa14S7/bUr5TwAfYUzmu5tCbzj8jqK4qLGlyV1DKjbkJEspTaXt/cH4trlJYKGf7KqeFilKQa6tCc8D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 43J2J0zJ4904072, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 43J2J0zJ4904072
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Apr 2024 10:19:00 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 19 Apr 2024 10:19:00 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 19 Apr 2024 10:19:00 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Fri, 19 Apr 2024 10:18:59 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Jes Sorensen <Jes.Sorensen@gmail.com>
Subject: RE: [PATCH 2/2] wifi: rtl8xxxu: Add LED control code for RTL8192CU family
Thread-Topic: [PATCH 2/2] wifi: rtl8xxxu: Add LED control code for RTL8192CU
 family
Thread-Index: AQHakdxGRzc0sb9I5EyhPnmZaf1gerFu3Aeg
Date: Fri, 19 Apr 2024 02:18:59 +0000
Message-ID: <cc9ba378d0d046d6b2af0c94a05a266b@realtek.com>
References: <a53ed8b9-27fc-4871-a20a-ad42c6d210d3@gmail.com>
 <4b5970cf-d28b-415a-b911-82cdb5e9ce99@gmail.com>
In-Reply-To: <4b5970cf-d28b-415a-b911-82cdb5e9ce99@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBBbHNv
LCBkb24ndCBzZXQgYml0IDcgb2YgTEVEQ0ZHMiBmb3IgUlRMODE5MkNVLiBJZiBiaXQgNyBpcyBz
ZXQgdGhlIExFRA0KPiBuZXZlciB0dXJucyBvbi4gSW4gdGhpcyBmYW1pbHkgb25seSBSVEw4MTg4
Q1VTIG5lZWRzIGJpdCA3IG9mIExFRENGRzINCj4gc2V0Lg0KPiANCj4gU29mdHdhcmUgY29udHJv
bCAob24vb2ZmKSBhbmQgaGFyZHdhcmUgY29udHJvbCAoYXV0b21hdGljIGJsaW5raW5nKQ0KPiB0
ZXN0ZWQgd2l0aCBOZXRjb3JlIE5XMzYyIChSVEw4MTkyQ1UpLg0KPiANCj4gU2lnbmVkLW9mZi1i
eTogQml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQoNClJldmlld2Vk
LWJ5OiBQaW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT4NCg0KDQo=

