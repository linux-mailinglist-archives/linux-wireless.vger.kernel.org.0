Return-Path: <linux-wireless+bounces-3182-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6C884AB49
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Feb 2024 01:59:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64E5EB231AE
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Feb 2024 00:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6678C10E4;
	Tue,  6 Feb 2024 00:59:32 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662D4A41;
	Tue,  6 Feb 2024 00:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707181172; cv=none; b=IFy8oi1wo9uYhO404yG0TzoRKEXiPcqwu/oISrN+YOLeqOxPhbS3QiQQI+mVmDXDYSUJpk/WOdNz4or/UDSDZpJZwM/XMmB7WN14/2/6cCC23bIQ+ecgHVdczyy7mxGzVrPTYuNPAkbzuj4qoQD3Q5s2gWTdMvJfZlbdZrAk3bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707181172; c=relaxed/simple;
	bh=+kgcZQp5yAaIso4A0qXVSZDSdr2KUiidE+4calQsHoI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Wh3BvP2taYEwJ7qzQdlSSUvmNtLDLW7FFlUXHM7VewCM7Ui1BIFzSmLL/jfFaMn5+Js7QNU7lYFZ38Nh4TB0FNF0RfPE+ElKJXkGN7n7rqz6LsouMx0+T38OrNxaDh2mXO20dIVOltrZGLY7Wyov/SZTvQ70vqvM+0xYy4J6nLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4160x4qeD3461595, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4160x4qeD3461595
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 6 Feb 2024 08:59:04 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.32; Tue, 6 Feb 2024 08:59:05 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 6 Feb 2024 08:59:05 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f]) by
 RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f%7]) with mapi id
 15.01.2507.035; Tue, 6 Feb 2024 08:59:04 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Fiona Klute <fiona.klute@gmx.de>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
CC: Kalle Valo <kvalo@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Pavel Machek
	<pavel@ucw.cz>,
        =?utf-8?B?T25kxZllaiBKaXJtYW4=?= <megi@xff.cz>
Subject: RE: [PATCH 1/9] wifi: rtw88: Shared module for rtw8723x devices
Thread-Topic: [PATCH 1/9] wifi: rtw88: Shared module for rtw8723x devices
Thread-Index: AQHaVdEUTzPlOvo4Mky3DaFmsU9017D6+D/ggAB8BACAAQ5BgA==
Date: Tue, 6 Feb 2024 00:59:04 +0000
Message-ID: <6985f2c220494bb78d20e1820823ad77@realtek.com>
References: <20240202121050.977223-1-fiona.klute@gmx.de>
 <20240202121050.977223-2-fiona.klute@gmx.de>
 <ef2a9567a01642a99eb20d67269713e2@realtek.com>
 <080d2209-151c-4493-93bb-8fddd51f0e1b@gmx.de>
In-Reply-To: <080d2209-151c-4493-93bb-8fddd51f0e1b@gmx.de>
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRmlvbmEgS2x1dGUgPGZp
b25hLmtsdXRlQGdteC5kZT4NCj4gU2VudDogVHVlc2RheSwgRmVicnVhcnkgNiwgMjAyNCAxMjo0
NyBBTQ0KPiBUbzogUGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+OyBsaW51eC13aXJl
bGVzc0B2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IEthbGxlIFZhbG8gPGt2YWxvQGtlcm5lbC5vcmc+
OyBVbGYgSGFuc3NvbiA8dWxmLmhhbnNzb25AbGluYXJvLm9yZz47IGxpbnV4LW1tY0B2Z2VyLmtl
cm5lbC5vcmc7IFBhdmVsDQo+IE1hY2hlayA8cGF2ZWxAdWN3LmN6PjsgT25kxZllaiBKaXJtYW4g
PG1lZ2lAeGZmLmN6Pg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDEvOV0gd2lmaTogcnR3ODg6IFNo
YXJlZCBtb2R1bGUgZm9yIHJ0dzg3MjN4IGRldmljZXMNCj4gDQo+IElmIHlvdSAob3IgYW55b25l
IGVsc2UgcmVhZGluZyB0aGlzKQ0KPiBoYXZlIHRoZSBvcHBvcnR1bml0eSB0byB0ZXN0IHdpdGgg
YW4gODcyM0QgZGV2aWNlIHRvIG1ha2Ugc3VyZSBJIGRpZG4ndA0KPiBtYWtlIGFueSBtaXN0YWtl
IHRoYXQgYnJlYWtzIHRoaW5ncyB0aGVyZSB0aGF0J2QgYmUgZ3JlYXQuDQo+IA0KDQpJIHRlc3Rl
ZCA4NzIzREUgdGhhdCB3b3JrcyBhcyB1c3VhbCB3aXRob3V0IGFueSB3ZWlyZCBtZXNzYWdlcy4g
SSBjYW4ndCBjaGVjaw0KdGhlIHRocm91Z2hwdXQgdGhvdWdoLCBiZWNhdXNlIHRoZXJlIGlzIGEg
bG90IG9mIGludGVyZmVyZW5jZSBhdCAyLjRHSHogYXQNCm9mZmljZSwgc28gdGhyb3VnaHB1dCBp
cyBxdWl0ZSBsb3cuIA0KDQpQaW5nLUtlIA0KDQo=

