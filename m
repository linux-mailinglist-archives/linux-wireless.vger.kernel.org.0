Return-Path: <linux-wireless+bounces-17205-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60A52A06A65
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jan 2025 02:44:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 625B01663CB
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jan 2025 01:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1DD615E8B;
	Thu,  9 Jan 2025 01:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="OsRz38tW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D7FB677
	for <linux-wireless@vger.kernel.org>; Thu,  9 Jan 2025 01:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736387079; cv=none; b=qGHWVct9flWKX8iVnd0Rr4fZ4vbzclP6a/D+b09uYPJpWCC3a+TdiWPYtZHliOSkTiDDf5Nn5uV9lIuyzQgIkPgqE+Hl5MdqCyyD1YrYVgCzrZZmp558HdtkW/H/lrraSLsqCjfJrouF5wdV7WoRu4dv4K60KqtzttrIOl5Zitg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736387079; c=relaxed/simple;
	bh=99C7Iavof6kWQnI0sPp2+5l0wBuKcmlnKjbiQyHaOlA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=M1LMrWmEsPUf8QELT4Xq5V2t8N1Is0Lqsh2vlQRN25kuTUdRQYbMklwx9yRbhqA70iGOvMiqqGaCY6/Rtf6c691DLDz7aZNkIilOMrbpJkwKvkExeMnU6uhWsq+7EPMWhingwXqGyDDC6l4Nn3n0LpoOx213eAJSJxTEPu+yAd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=OsRz38tW; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 5091iKEd92280894, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1736387060; bh=99C7Iavof6kWQnI0sPp2+5l0wBuKcmlnKjbiQyHaOlA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=OsRz38tWFnqyFJueGw5RGdre4gKiiRNCTDvBECAuWv8QSeMOAEOKBxqP2yz1VlOsT
	 dqCxO90TVfYUuEF4laQ+pTXM/ZaUJjCzdPFL96miXfEvaBPq+u3Xv40EAc6GZMPyHC
	 8t3IOw1dEC1/aj+2DKVQjdDHGIM8620xlNEb+capOZ4GX17UkZJ1z3HTqCU/nZjXCP
	 qvAi/II857888TyXW0irelOl3CH15NUkYqtCRSvqCbfgYjgRDGPitoiQZ00jU3Tcuv
	 vZr2XLfqFoxv11XljEpCgp8voiAU5P7OuUw3VwcuAWg+p+XB6JrJ7cMmtHtaB75X3f
	 sP3odvSQ3rlXA==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 5091iKEd92280894
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 Jan 2025 09:44:20 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 9 Jan 2025 09:44:21 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 9 Jan 2025 09:44:21 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Thu, 9 Jan 2025 09:44:20 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Sascha Hauer <sha@pengutronix.de>
Subject: RE: [PATCH v3] wifi: rtw88: Add support for LED blinking
Thread-Topic: [PATCH v3] wifi: rtw88: Add support for LED blinking
Thread-Index: AQHbYcJDG/F8wn09QUqtrFg3mpXWdrMNrF0w
Date: Thu, 9 Jan 2025 01:44:20 +0000
Message-ID: <646acdbfde054f0ab1e3590a9c994c52@realtek.com>
References: <6c43451f-ab2f-4e76-ac6e-ff5a18dd981d@gmail.com>
In-Reply-To: <6c43451f-ab2f-4e76-ac6e-ff5a18dd981d@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBSZWdp
c3RlciBhIHN0cnVjdCBsZWRfY2xhc3NkZXYgd2l0aCB0aGUga2VybmVsJ3MgTEVEIHN1YnN5c3Rl
bSBhbmQNCj4gY3JlYXRlIGEgdGhyb3VnaHB1dC1iYXNlZCB0cmlnZ2VyIGZvciBpdC4gVGhlbiBt
YWM4MDIxMSBtYWtlcyB0aGUgTEVEDQo+IGJsaW5rLg0KPiANCj4gVGVzdGVkIHdpdGggVGVuZGEg
VTEyIChSVEw4ODEyQVUpLCBUZW5kYSBVOSAoUlRMODgxMUNVKSwgVFAtTGluayBBcmNoZXINCj4g
VDJVIE5hbm8gKFJUTDg4MTFBVSksIFRQLUxpbmsgQXJjaGVyIFQzVSBQbHVzIChSVEw4ODEyQlUp
LCBFZGltYXgNCj4gRVctNzYxMVVDQiAoUlRMODgyMUFVKSwgTE04NDIgKFJUTDg4MjJDVSkuDQo+
IA0KPiBBbHNvIHRlc3RlZCB3aXRoIGRldmljZXMgd2hpY2ggZG9uJ3QgaGF2ZSBMRURzOiB0aGUg
bGFwdG9wJ3MgaW50ZXJuYWwNCj4gUlRMODgyMkNFIGFuZCBhIG5vLW5hbWUgUlRMODcyM0RVLg0K
PiANCj4gU2lnbmVkLW9mZi1ieTogQml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFp
bC5jb20+DQoNCkFja2VkLWJ5OiBQaW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT4NCg0K
DQo=

