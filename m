Return-Path: <linux-wireless+bounces-4309-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F9886ED73
	for <lists+linux-wireless@lfdr.de>; Sat,  2 Mar 2024 01:29:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5639B1C21238
	for <lists+linux-wireless@lfdr.de>; Sat,  2 Mar 2024 00:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40646801;
	Sat,  2 Mar 2024 00:29:22 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5DA7E9;
	Sat,  2 Mar 2024 00:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709339362; cv=none; b=q8ahWxzIXbTkzHExG96AkJL1ItE8hy50Cl//fmYEJ2ChivAYOI242oD8hSuzl0R7Z1fzmwEkdgWhKQbmySgd6eSYn2BaVNTW3wHvhwXQzjhNAq78SmbKkU1bH8ELO7LEUcPbJPqyXg8Dz6bflJwqplCn/JJw59POnLK4LVz0EfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709339362; c=relaxed/simple;
	bh=ucE4vECd1gLRX+LXenRnMdvlCouIW1g4o8+789YdMgI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=roPDaQ8qmsOc91HnblhAkRVMZgyyBm9SB4IZhC7VXcpoJtPgQQ4tOq5OTG0Tutu7OwDEvNdl1U+Lt8mXcvBADfafvf/Gi59D82lH8atMVNlhWork61PdBaqdZB+1ROf+YsHDkd5pSc0EUYiQzIUh7D256+FfOpfKetSY1hIZg+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4220Sg1Y22362898, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4220Sg1Y22362898
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 2 Mar 2024 08:28:42 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.32; Sat, 2 Mar 2024 08:28:42 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sat, 2 Mar 2024 08:28:42 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f]) by
 RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f%7]) with mapi id
 15.01.2507.035; Sat, 2 Mar 2024 08:28:42 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "fiona.klute@gmx.de" <fiona.klute@gmx.de>
CC: "kvalo@kernel.org" <kvalo@kernel.org>,
        "ulf.hansson@linaro.org"
	<ulf.hansson@linaro.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "megi@xff.cz"
	<megi@xff.cz>
Subject: Re: [PATCH v2 7/9] wifi: rtw88: Add rtw8703b_tables.c
Thread-Topic: [PATCH v2 7/9] wifi: rtw88: Add rtw8703b_tables.c
Thread-Index: AQHaadh+VjiQRYuLIE6Vkan7rS/d/rEiLnWwgABn3wCAAIDNAA==
Date: Sat, 2 Mar 2024 00:28:42 +0000
Message-ID: <11508a32e72768ac2ec01dae1015a20b2333549b.camel@realtek.com>
References: <20240227235507.781615-1-fiona.klute@gmx.de>
	 <20240227235507.781615-8-fiona.klute@gmx.de>
	 <9ee0cb2bd7694e0da8f0576da6a182b5@realtek.com>
	 <da4b13d0-fe4f-4aec-8dfa-e64a5959387e@gmx.de>
In-Reply-To: <da4b13d0-fe4f-4aec-8dfa-e64a5959387e@gmx.de>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
user-agent: Evolution 3.36.1-2 
Content-Type: text/plain; charset="utf-8"
Content-ID: <3195BA11CE4C6F4CAC54AE7552F76C23@realtek.com>
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

T24gRnJpLCAyMDI0LTAzLTAxIGF0IDE3OjQ2ICswMTAwLCBGaW9uYSBLbHV0ZSB3cm90ZToNCj4g
DQo+IEknbGwgYWRkIHRoZSAjaW5jbHVkZS4gT2RkbHkgSSBkb24ndCBnZXQgdGhvc2Ugd2Fybmlu
Z3MsIEkgd29uZGVyIGlmDQo+IGl0J3MgYSBkaWZmZXJlbmNlIGJldHdlZW4gQ2xhbmcgKHdoaWNo
IEknbSB1c2luZyBmb3IgZWFzaWVyDQo+IGNyb3NzLWNvbXBpbGluZykgYW5kIEdDQz8NCj4gDQoN
ClRoZXNlIHdhcm5pbmdzIHdlcmUgcmVwb3J0ZWQgYnkgc3BhcnNlLCBhIHN0YXRpYyBhbmFseXNp
cyB0b29sLiANCkFsc28sIEkgdXNlIHNtYXRjaCBhcyB3ZWxsIHRvIGNoZWNrIHRoaXMgcGF0Y2hz
ZXQsIGFuZCBubyB3YXJuaW5ncy4NCg0KUGluZy1LZSANCg0K

