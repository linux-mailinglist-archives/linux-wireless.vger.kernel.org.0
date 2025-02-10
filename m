Return-Path: <linux-wireless+bounces-18673-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2396DA2E1FC
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Feb 2025 02:23:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A4901887846
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Feb 2025 01:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF21F17BA5;
	Mon, 10 Feb 2025 01:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="uHh2MI8G"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B83179A7
	for <linux-wireless@vger.kernel.org>; Mon, 10 Feb 2025 01:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739150619; cv=none; b=oGdiRLzX8dPxyCqRBLuXOOoeI2HOHPixFJf2HsxxsekuvsIwmxEeehvViRaMn/gzEUrxnVhdzi2ymDQmOiBsWhm+phUWqLWEEa4w8EBBRk5YJtguUBjdnNsHtuh611m0yM/11LI2nZEhxF1YM2WWkdyhhIgA+sObpq4L8Ogg5Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739150619; c=relaxed/simple;
	bh=1qDrcPbK6a9wBXyroNItL2Gv2eigqvJFm2SPKDyEJ4M=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=d+xpmJl6rSDdd/ULfCuU6ESqNi0gy9hAhxgqbkqbVtpUeMXZV8jlGcO5VHUcGj+j9E5PwcnZ1S5rM4UxwVzkTMu88uw21mx3DJ3u9zmu4QFKzcOK8LF1qBL8LMKTrTQxlmveb2FB6nhVJQw+i++ekR22EmqzXud7STdT1ED+Kos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=uHh2MI8G; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 51A1NWdyC1397118, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1739150612; bh=1qDrcPbK6a9wBXyroNItL2Gv2eigqvJFm2SPKDyEJ4M=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=uHh2MI8GW5rgNAErl83nGa9MxeH0DE7lSn72LiaRGJpJc9f0dNwaFmSdTGT881kj7
	 3T10iGqf8CpmLAsK+p9sLot8dQa6e8iDp6Dmpxpo7oMUGAANHjYcbLMhGsVzhJ7Tgw
	 2Ib+PzSKozw09KnA//9g+lkbSl8j0QacfK1DlEoGENGtqks1lwSJ6vfD6bHDsai2qv
	 mm0cX2S9DZ2JI84K0DWj3FmxINpqglqdG+q9aGiXWHpwUu4dh0NOXIzFhNiMqMfEch
	 JSvO5m6tB0bBTqqfir6PnokQgotptgv2ovemMQzAT3DoFYada+/4+jn2e4RLVfVzGB
	 /ABokJ3pQTYpg==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 51A1NWdyC1397118
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Feb 2025 09:23:32 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 10 Feb 2025 09:23:33 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 10 Feb 2025 09:23:32 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::48ab:b54f:96a1:6553]) by
 RTEXMBS04.realtek.com.tw ([fe80::48ab:b54f:96a1:6553%5]) with mapi id
 15.01.2507.035; Mon, 10 Feb 2025 09:23:32 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH v2 1/9] wifi: rtw88: Fix __rtw_download_firmware() for RTL8814AU
Thread-Topic: [PATCH v2 1/9] wifi: rtw88: Fix __rtw_download_firmware() for
 RTL8814AU
Thread-Index: AQHbdzPItalZyWrUCkCif1rBlZcZyLM/xeHA
Date: Mon, 10 Feb 2025 01:23:32 +0000
Message-ID: <3a8771c4587e4ac5b4bd59d95f6d5162@realtek.com>
References: <9fc518ae-7708-42c6-99ca-56ee307555b6@gmail.com>
 <55b5641f-094e-4f94-9f79-ac053733f2cf@gmail.com>
In-Reply-To: <55b5641f-094e-4f94-9f79-ac053733f2cf@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBEb24n
dCBjYWxsIGx0ZWNvZXhfcmVhZF9yZWcoKSBhbmQgbHRlY29leF9yZWdfd3JpdGUoKSB3aGVuIHRo
ZQ0KPiBsdGVjb2V4X2FkZHIgbWVtYmVyIG9mIHN0cnVjdCBydHdfY2hpcF9pbmZvIGlzIE5VTEwu
IFRoZSBSVEw4ODE0QVUNCj4gZG9lc24ndCBoYXZlIHRoaXMgZmVhdHVyZS4NCj4gDQo+IFNpZ25l
ZC1vZmYtYnk6IEJpdHRlcmJsdWUgU21pdGggPHJ0bDg4MjFjZXJmZTJAZ21haWwuY29tPg0KDQpB
Y2tlZC1ieTogUGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+DQoNCj4gLS0tDQo+IHYy
Og0KPiAgLSBObyBjaGFuZ2UuDQoNCk5leHQgdGltZSBwbGVhc2UgdGFrZSBteSBBY2tlZC1ieSBp
biB2MS4gVGhhdCB3aWxsIGhlbHAgbWUgdG8gc2F2ZSB0aW1lIGluIHYyLg0KDQo=

