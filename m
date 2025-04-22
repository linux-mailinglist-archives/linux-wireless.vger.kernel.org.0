Return-Path: <linux-wireless+bounces-21803-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D463BA95A6D
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Apr 2025 03:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D36091894546
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Apr 2025 01:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EB7342AB4;
	Tue, 22 Apr 2025 01:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="YdpSEgoW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E23C26ADD;
	Tue, 22 Apr 2025 01:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745284925; cv=none; b=KKve4RRFlhwniV7ZkBMpwE23S1RZx/5pZP3zxdrxvp8xQnrBoPtmUhJh+oRyv+vMeU/biG9VwI+Qj1P/pyaCxaaCOIqeOENY/ynR9M1X7hwtQKmE8vHfVFIYQZXsf1w6mfp8Q7wTv30RDM49SRoIthvGrks+iLl9GMqu10lcDVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745284925; c=relaxed/simple;
	bh=B143AVIJ23guoYJU6VO+9f4GYSeaGW/SrhvQgIzaQJA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jkELPonP9ZNlhPgQuvHLHymx8tWDc3GTZ6vuzTdYDY+AtdogGR7H0/mL30DGQxuSRxpxxZpuPI9c/ONJAvYtfCMK7WmHvy6kAzTRwq8sW1Vk8HzBNsCYCarACnnplwwKy+uYJVYSO4qIx6q1F2s77ynrCuSS8hIXeA+6mkRlgjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=YdpSEgoW; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 53M1L7Pn83818441, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1745284867; bh=B143AVIJ23guoYJU6VO+9f4GYSeaGW/SrhvQgIzaQJA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=YdpSEgoWhrPyLY+Jm1sI3DjE42GLa8YTG/9PTh8FLAFpozi3zoCHG49CqotMhXNmi
	 C7GSWU0637hhZxpXoSdkJIlL7gWcNHIWA29m89h1jON6NpHDlfNj6DpdLw6M79SmcU
	 xenzvABhV94XKJEFK7+NiDfm3HqMXaBq8qyT/P4kknJ4aawrvf3LMrt22mYDwYvE3O
	 lFx8AzCUmU4Sm9zjgD1Wzta5wVTjHIncNVT2/pjPzJmIFWhTLky5BRlXQI+oBM4ewv
	 eHfNpyj72M/Ysw/4FaXHP2zCMIhxMe/sYdupzF5jgrh2UqxB0jvQN1Hq/vk35UacqB
	 9IsJYyymODeJA==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 53M1L7Pn83818441
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Apr 2025 09:21:07 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 22 Apr 2025 09:21:07 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 22 Apr 2025 09:21:06 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Tue, 22 Apr 2025 09:21:06 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Mingcong Bai <jeffbai@aosc.io>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: Kexy Biscuit <kexybiscuit@aosc.io>,
        Liangliang Zou
	<rawdiamondmc@outlook.com>,
        "John W. Linville" <linville@tuxdriver.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
Subject: RE: [RFC PATCH] wifi: rtlwifi: disable ASPM for RTL8723BE with subsystem ID 11ad:1723
Thread-Topic: [RFC PATCH] wifi: rtlwifi: disable ASPM for RTL8723BE with
 subsystem ID 11ad:1723
Thread-Index: AQHbsQLzvT9MJD0RkUSfQMSmmYlilrOu11zA//+GmwCAAIiqYA==
Date: Tue, 22 Apr 2025 01:21:06 +0000
Message-ID: <6f0234bc99094b3d84959afd4eea55d7@realtek.com>
References: <20250419081251.285987-1-jeffbai@aosc.io>
 <4a7284bd703743959e709b9465dabf1d@realtek.com>
 <985175be-de04-4d1d-a859-fa740d87c9c3@aosc.io>
In-Reply-To: <985175be-de04-4d1d-a859-fa740d87c9c3@aosc.io>
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

TWluZ2NvbmcgQmFpIDxqZWZmYmFpQGFvc2MuaW8+IHdyb3RlOg0KPiBIaSBQaW5nLUtlLA0KPiAN
Cj4g5ZyoIDIwMjUvNC8yMiAwODoyNywgUGluZy1LZSBTaGloIOWGmemBkzoNCj4gPiBNaW5nY29u
ZyBCYWkgPGplZmZiYWlAYW9zYy5pbz4gd3JvdGU6DQo+ID4NCj4gDQo+IDxzbmlwPg0KPiANCj4g
Pj4NCj4gPj4gUGxlYXNlIG5vdGUsIGhvd2V2ZXIsIGJlZm9yZSB0aGUgcnRsODcyM2JlIGZpbmlz
aGVzIHByb2JpbmcsIHRoZSBBRVINCj4gPj4gZXJyb3JzIHJlbWFpbmVkLiBBZnRlciB0aGUgbW9k
dWxlIGZpbmlzaGVzIHByb2JpbmcsIGFsbCBBRVIgZXJyb3JzIHdvdWxkDQo+ID4+IGluZGVlZCBi
ZSBlbGltaW5hdGVkLCBhbG9uZyB3aXRoIGhlYXZ5IGxhZ3MsIHBvb3IgbmV0d29yayB0aHJvdWdo
cHV0LA0KPiA+PiBhbmQvb3Igb2NjYXNpb25hbCBsb2NrLXVwcy4NCj4gPg0KPiA+IExldCBtZSBj
bGFyaWZ5IGhlcmUgbWVhbnMuIERvIHlvdSBtZWFuIGFsbCB3b3JrIHdlbGwgYWZ0ZXIgYXBwbHlp
bmcgdGhpcw0KPiA+IHBhdGNoPyBPciBzdGlsbCBsYWcsIHBvb3IgdGhyb3VnaHB1dCBvciBsb2Nr
LXVwcz8NCj4gPg0KPiA+IElmIGFsbCBzeW1wdG9tcyBkaXNhcHBlYXIsIGl0IHdvdWxkIGJlIHdv
cnRoIHRvIHRha2UgdGhpcyAocXVpcmspIHBhdGNoLg0KPiANCj4gSW5kZWVkLCBldmVyeXRoaW5n
IHdvcmtzIHdlbGwgYWZ0ZXIgdGhpcyBwYXRjaCwgc2F2ZSBmb3IgdGhlIHJlbWFpbmluZw0KPiBB
RVIgZXJyb3JzIGR1cmluZyBkcml2ZXIgcHJvYmluZy4NCg0KR29vZC4gVGhlbiBtYWtlIGEgZm9y
bWFsIHBhdGNoLiANCg0KQnkgdGhlIHdheSwgY3VycmVudGx5IHdpcmVsZXNzIHRyZWUgcnVucyBi
dWlsZCB0ZXN0aW5nIHdpdGggTklQQSwgc28gcGxlYXNlDQpzcGVjaWZ5IHJ0dy1uZXh0IHRyZWUg
dGhpcyBwYXRjaCBpcyBnb2luZyB0by4NCmkuZS4gIltQQVRDSCBydHctbmV4dF0gd2lmaTogcnRs
d2lmaTogLi4uIg0KDQo=

