Return-Path: <linux-wireless+bounces-4657-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58E9287A119
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Mar 2024 02:55:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F8241F243EE
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Mar 2024 01:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2882B67D;
	Wed, 13 Mar 2024 01:55:44 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9FCB66C
	for <linux-wireless@vger.kernel.org>; Wed, 13 Mar 2024 01:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710294944; cv=none; b=Ae/1lyOyTywtO2Fjw1fsXOzzwH8S4ay4jaWXTFxKYe0gizNc/QWXWAVFXFnptWwoaA3D05isJvZ1tMj4VFWrHGCZaYMqEYAJMlyYtSZMe6jyhO0u2qmGCS8oncX8Gru0RHrKhOI5Dii/wnIX13gftSRO3gDqKvJRODLVjXT+6k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710294944; c=relaxed/simple;
	bh=/YpCt/YL0n0qTBr3PtogDFg0BcTMigX9OgZvatZ/7Cs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LysgWERO3vORLSfyjO+GFxGVj2mCgisdt4sF4JdnHvavL+J/mPm1JtAwy0oqo8s++9E0VNeO4veCOY/U/NDRS0E8yTChNJrbq7J2I1MRTY+tO9Vn5mxv6G+sBVyDvZgFb2QffP//cX5fOlMlWOzQlAkm4/Jrrxloql19WWsNivU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 42D1tVDc9413347, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 42D1tVDc9413347
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Mar 2024 09:55:31 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 13 Mar 2024 09:55:30 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 13 Mar 2024 09:55:29 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f]) by
 RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f%7]) with mapi id
 15.01.2507.035; Wed, 13 Mar 2024 09:55:29 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Larry Finger <Larry.Finger@lwfinger.net>
Subject: RE: [PATCH] wifi: rtlwifi: rtl8192de: Fix 5 GHz TX power
Thread-Topic: [PATCH] wifi: rtlwifi: rtl8192de: Fix 5 GHz TX power
Thread-Index: AQHadHc+y1p0wnFmpUaBbm9dm2gSZ7E05aGA
Date: Wed, 13 Mar 2024 01:55:29 +0000
Message-ID: <43c344357f564170872501e34490c851@realtek.com>
References: <9995b805-ef8b-47c9-b176-ff540066039a@gmail.com>
In-Reply-To: <9995b805-ef8b-47c9-b176-ff540066039a@gmail.com>
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
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQml0dGVyYmx1ZSBTbWl0
aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIE1hcmNoIDEyLCAy
MDI0IDg6MTcgUE0NCj4gVG86IGxpbnV4LXdpcmVsZXNzQHZnZXIua2VybmVsLm9yZw0KPiBDYzog
UGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+OyBMYXJyeSBGaW5nZXIgPExhcnJ5LkZp
bmdlckBsd2Zpbmdlci5uZXQ+DQo+IFN1YmplY3Q6IFtQQVRDSF0gd2lmaTogcnRsd2lmaTogcnRs
ODE5MmRlOiBGaXggNSBHSHogVFggcG93ZXINCj4gDQo+IERpZmZlcmVudCBjaGFubmVscyBoYXZl
IGRpZmZlcmVudCBUWCBwb3dlciBzZXR0aW5ncy4gcnRsODE5MmRlIGlzIHVzaW5nDQo+IHRoZSBU
WCBwb3dlciBzZXR0aW5nIGZyb20gdGhlIHdyb25nIGNoYW5uZWwgaW4gdGhlIDUgR0h6IGJhbmQg
YmVjYXVzZQ0KPiBfcnRsOTJjX3BoeV9nZXRfcmlnaHRjaG5scGxhY2UgZXhwZWN0cyBhbiBhcnJh
eSB3aGljaCBpbmNsdWRlcyAyLjQgR0h6DQo+IGFuZCA1IEdIeiBjaGFubmVsIG51bWJlcnMsIGJ1
dCBpdCdzIHVzaW5nIGFuIGFycmF5IHdoaWNoIGluY2x1ZGVzIG9ubHkNCj4gdGhlIDUgR0h6IGNo
YW5uZWwgbnVtYmVycy4NCj4gDQo+IFVzZSB0aGUgYXJyYXkgY2hhbm5lbF9hbGwgKGRlZmluZWQg
aW4gcnRsODE5MmRlL3BoeS5jKSBpbnN0ZWFkIG9mDQo+IHRoZSBpbmNvcnJlY3QgY2hhbm5lbDVn
IChkZWZpbmVkIGluIGNvcmUuYykuDQo+IA0KPiBUZXN0ZWQgb25seSB3aXRoIHJ0bDgxOTJkdSwg
d2hpY2ggd2lsbCB1c2UgdGhlIHNhbWUgVFggcG93ZXIgY29kZS4NCj4gU2lnbmVkLW9mZi1ieTog
Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQoNCkFja2VkLWJ5OiBQ
aW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT4NCg0K

