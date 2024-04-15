Return-Path: <linux-wireless+bounces-6294-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7498A4686
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Apr 2024 03:19:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60AC01C216DC
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Apr 2024 01:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F2F4C7C;
	Mon, 15 Apr 2024 01:19:48 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CD43FDB
	for <linux-wireless@vger.kernel.org>; Mon, 15 Apr 2024 01:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713143988; cv=none; b=m7m3uOIKf9rTdnAwNvB7Lzl9VvgolYAZgFU2iGalQhp7c36TjdmT708G8TZxs5yofTr0JjxcgIG6+TGWjXht2RH7C2ou/PncDvKTIwUnDtXNswB6HDZ/aBs4RVxI7rgYitnOtL6QAx8Wa41w6MrdO5bfq0UeJo0gqHCVvqhxZ3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713143988; c=relaxed/simple;
	bh=4zaoS9L40wbehr/gPNdpG1eDTlYP9jOta1bI17G2XEo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=G4BmupfFZKW4fLscXV3lAfXXb4B+6qkGmDcD6Tzs9T3dPT71rF2mE4HZW5RRNkaEZUq8a7CrClgmoIiRJIruF9XO9OTm+YoTTgYP1XwNN/eu9DcpRQJh35nfHPRA1zIiC7AB970IgZf0DnQLb4WA1OU6/mxm+hU4WJsBzoCiFFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 43F1JfJP2359392, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 43F1JfJP2359392
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Apr 2024 09:19:41 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 15 Apr 2024 09:19:41 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 15 Apr 2024 09:19:41 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Mon, 15 Apr 2024 09:19:41 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Nick Morrow <morrownr@gmail.com>, Gabriel Tisan <gabriel.tisan@gmail.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: rtw88: rtw8822cu (LM842) on Raspi4 -> driver get stucked while sending data
Thread-Topic: rtw88: rtw8822cu (LM842) on Raspi4 -> driver get stucked while
 sending data
Thread-Index: AQHajOjmyZjlxCnDHEmqg33GnwZuKrFkWzSAgAQwciA=
Date: Mon, 15 Apr 2024 01:19:41 +0000
Message-ID: <c68a406361524b6888d973a1e428118b@realtek.com>
References: <CAD9ZU8Coc0r3AiWz+rA4eoXuDQBBCAMY0J4w5x-Pa1JEpbmdWA@mail.gmail.com>
 <CAFktD2cp5eXJufdQibxDPGvN2iMfMZKDOunFzxv0TBNLqcMAQg@mail.gmail.com>
In-Reply-To: <CAFktD2cp5eXJufdQibxDPGvN2iMfMZKDOunFzxv0TBNLqcMAQg@mail.gmail.com>
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

TmljayBNb3Jyb3cgPG1vcnJvd25yQGdtYWlsLmNvbT4gd3JvdGU6DQoNCj4gPiBJIHdhbnQgdG8g
dXNlIExNODQyIFVTQiBzdGljayBvbiBhIFJhc3BiZXJyeSBQaSA0IHVzaW5nIFJhc3BiZXJyeSBQ
aSBPUw0KPiA+ICg2NC1iaXQgRGViaWFuIEJvb2t3b3JtIHdpdGgga2VybmVsIDYuNi4yMCksIGJ1
dCB0aGUgZHJpdmVyIGdldCBzdHVja2VkLg0KPiA+DQo+ID4gVGhlIExNODQyIG9uIFJhc3BpIGlz
IHVzZWQgYXMgQVAuDQo+IA0KPiBCYXNlZCBvbiBteSB0ZXN0aW5nIG9mIHJ0dzg4OiBydHc4ODIy
Y3UsIGl0IGlzIG5vbi1mdW5jdGlvbmFsIGluIEFQIG1vZGUuDQoNCkluIGRpc2N1c3Npb24gWzFd
LCBWaWFjaGVzbGF2IHJlcG9ydGVkIDg4MjFDVSB3b3Jrcy4gVGhhdCBtaWdodCBiZSBhIHJlZmVy
ZW5jZQ0KZm9yIGRpZ2dpbmcgcHJvYmxlbS4gDQoNClsxXSBodHRwczovL2xvcmUua2VybmVsLm9y
Zy9saW51eC13aXJlbGVzcy9lNGNjZjg0MC1hMzhjLTQ1NWUtYWY3NS01ZjRkYjhhOTc3MDJAbGV4
aW5hLmluLw0KDQo=

