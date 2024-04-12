Return-Path: <linux-wireless+bounces-6224-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E878A264B
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Apr 2024 08:15:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1EC1287461
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Apr 2024 06:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E27225D7;
	Fri, 12 Apr 2024 06:15:22 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B339B200D4
	for <linux-wireless@vger.kernel.org>; Fri, 12 Apr 2024 06:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712902522; cv=none; b=S0Eneakvwe+uAp7W6vQ6H7fK488su6lEHQh3ejO7tzBthocQCfm9oFF80IfVGeLyEKHir4X294LMVA0MSGy+wFzAZiMuwj0DQfIkzIbzyB6NtGNxT4a+SPUIZzZHbQlYQ1avUDmopp2Tp7C3XG3bqwrBVfo4tGV4OLwqHnkb+jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712902522; c=relaxed/simple;
	bh=a1u4XJkM2iyfG+mgTJgqiYXqH/LUGa2dTaIqXCWkcn4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ucFG3XN6wzykNZvzjMpN2lqixRgBW8Sfa76Jtg4U7/zMuzDhz9FjB7iAtfltVuoQq5qYpUN/DpWJO8Q1yjgDtse2wkXMrgd2Ht5zU2dX8R3DpZQW5V5sfILZohdvRt+Pmky4GeggBnlAwOEdEr+mzjrhwY+DfdelmCC0OZu/v0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 43C6EuNS21836187, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 43C6EuNS21836187
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Apr 2024 14:14:56 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 12 Apr 2024 14:14:56 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 12 Apr 2024 14:14:56 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Fri, 12 Apr 2024 14:14:56 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Larry Finger <Larry.Finger@lwfinger.net>,
        Stefan Lippers-Hollmann
	<s.l-h@gmx.de>,
        Christian Hewitt <chewitt@libreelec.tv>
Subject: RE: [PATCH v4 02/14] wifi: rtlwifi: rtl8192de: Fix low speed with WPA3-SAE
Thread-Topic: [PATCH v4 02/14] wifi: rtlwifi: rtl8192de: Fix low speed with
 WPA3-SAE
Thread-Index: AQHairdvUMe/7B68+kiF9oqMdp/1u7FkK+fw
Date: Fri, 12 Apr 2024 06:14:56 +0000
Message-ID: <1df4953f01f84aeebc9de25ccf6f9d9c@realtek.com>
References: <91d932b3-5c72-4416-920e-f2bf4fc9b039@gmail.com>
 <ed12ec17-ae6e-45fa-a72f-23e0a34654da@gmail.com>
In-Reply-To: <ed12ec17-ae6e-45fa-a72f-23e0a34654da@gmail.com>
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

DQpCaXR0ZXJibHVlIFNtaXRoIDxydGw4ODIxY2VyZmUyQGdtYWlsLmNvbT4gd3JvdGU6DQoNCj4g
U29tZSAoYWxsPykgbWFuYWdlbWVudCBmcmFtZXMgYXJlIGluY29ycmVjdGx5IHJlcG9ydGVkIHRv
IG1hYzgwMjExIGFzDQo+IGRlY3J5cHRlZCB3aGVuIGFjdHVhbGx5IHRoZSBoYXJkd2FyZSBkaWQg
bm90IGRlY3J5cHQgdGhlbS4gVGhpcyByZXN1bHRzDQo+IGluIHNwZWVkcyAzLTUgdGltZXMgbG93
ZXIgdGhhbiBleHBlY3RlZCwgMjAtMzAgTWJwcyBpbnN0ZWFkIG9mIDEwMA0KPiBNYnBzLg0KPiAN
Cj4gRml4IHRoaXMgYnkgY2hlY2tpbmcgdGhlIGVuY3J5cHRpb24gdHlwZSBmaWVsZCBvZiB0aGUg
UlggZGVzY3JpcHRvci4NCj4gcnR3ODggZG9lcyB0aGUgc2FtZSB0aGluZy4NCj4gDQo+IFRoaXMg
Zml4IHdhcyB0ZXN0ZWQgb25seSB3aXRoIHJ0bDgxOTJkdSwgd2hpY2ggd2lsbCB1c2UgdGhlIHNh
bWUgY29kZS4NCj4gDQo+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+IFNpZ25lZC1vZmYt
Ynk6IEJpdHRlcmJsdWUgU21pdGggPHJ0bDg4MjFjZXJmZTJAZ21haWwuY29tPg0KDQpBY2tlZC1i
eTogUGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+DQoNCg0K

