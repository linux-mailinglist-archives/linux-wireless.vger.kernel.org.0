Return-Path: <linux-wireless+bounces-24112-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E6D0ADA582
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Jun 2025 03:28:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E947188EA49
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Jun 2025 01:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE8AA29408;
	Mon, 16 Jun 2025 01:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="jJlIQ2Hs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1E2AD58
	for <linux-wireless@vger.kernel.org>; Mon, 16 Jun 2025 01:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750037311; cv=none; b=psYTA+nDe+hLKHHRbfRpZQ6bk0dTYufTXtk7pfFcSGrfcYFuFKiOTzEt0rLMD3S4tNntJ+seygEtFfsrDjU5CafIi/xNcVinOWxeqXMkK09KOmQQMyuYGWwUpcftkapwUxmzOZJ1e7HIpNoJynhbbURbE4d76DX1d+CaiW5LbPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750037311; c=relaxed/simple;
	bh=nvDSc70jo+6OVJnKHEZKGLEVfe8aodWCtjKwT88D88Y=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GdMQ16l02G1iHdXsvuAM4bFuA/1d9NCqvIeC1k1KqzQznnBOu0EZlGiYjStsu2nmGwjrgkC8a08yw7+si1L6Hmx5QWZumusPCsmhi4kIxNzQq7h3E2eZ0s1T8RwyzcCXrJbOZhCCGeRQDbP+0ahLVSJDM0/1iYPTGH8VLNrmi2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=jJlIQ2Hs; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 55G1SQ6z83814163, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1750037306; bh=nvDSc70jo+6OVJnKHEZKGLEVfe8aodWCtjKwT88D88Y=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=jJlIQ2Hs+cUx4CzjzCRlt5WADpHMn5E/eMMIeYhh3yg76++GFSUXmjGolVRKc8PKm
	 l1J4sD65MK3Lk3fLoM0FrA5nzY9aHlxS9DQrRzx0MASDWzFPFC0Wq5cZrC2Ppa5pAc
	 272xh/bRNFYjcoFj8/UMmUa7HwQDuXVsNUhXxfkfLq51H4MkCehTRU0NlomNhM8ZIk
	 dubF6uBucGZ/0E0SGN3a4fvoYkTPDKB+Q4ZM7agH5q8SyC6xkLa2EyF9MUxUY1ufyj
	 RIQvB6bKdcspkoktiDM5lA2lAATJaFZ2IR4IveNrCDYDauXxA0DiuksE4olkhH9VbT
	 6Qtx/bR4ZwRZA==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 55G1SQ6z83814163
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Jun 2025 09:28:26 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 16 Jun 2025 09:28:19 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 16 Jun 2025 09:28:18 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Mon, 16 Jun 2025 09:28:18 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next v2 04/14] wifi: rtw89: Add rtw8851b_dle_mem_usb{2,3}
Thread-Topic: [PATCH rtw-next v2 04/14] wifi: rtw89: Add
 rtw8851b_dle_mem_usb{2,3}
Thread-Index: AQHb2XRn7e9sD03Zwk63KZnR4jViUrQFCNzA
Date: Mon, 16 Jun 2025 01:28:18 +0000
Message-ID: <0eeec87785ff422d9863edaaaf8c4ea7@realtek.com>
References: <6fc81cc4-a4d1-4db9-ab60-c8976e0b3c27@gmail.com>
 <bf2e3a4c-79ea-4110-b180-e388c04d54c2@gmail.com>
In-Reply-To: <bf2e3a4c-79ea-4110-b180-e388c04d54c2@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBBZGQg
cnR3ODg1MWJfZGxlX21lbV91c2IyIGFuZCBydHc4ODUxYl9kbGVfbWVtX3VzYjMgYW5kIHRoZWly
IHZhcmlvdXMNCj4gcXVvdGFzIGFuZCBzaXplcyBpbiBzdHJ1Y3QgcnR3ODlfbWFjX3NpemVfc2V0
Lg0KPiANCj4gImRsZSIgY291bGQgYmUgIkRhdGEgTGluayBFbmdpbmUiIG9yICJEb3VibGUgTGlu
ayBFbmdpbmUiLiBUaGVzZSBhcmUNCj4gc29tZSBwYXJhbWV0ZXJzIG5lZWRlZCBmb3IgUlRMODg1
MUJVLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZl
MkBnbWFpbC5jb20+DQoNCkFja2VkLWJ5OiBQaW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNv
bT4NCg0KDQo=

