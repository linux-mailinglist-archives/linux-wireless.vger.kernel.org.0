Return-Path: <linux-wireless+bounces-10442-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE939397E4
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jul 2024 03:27:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 910311F21E10
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jul 2024 01:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E6EB7E574;
	Tue, 23 Jul 2024 01:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="GweM4/de"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15FDD433A0
	for <linux-wireless@vger.kernel.org>; Tue, 23 Jul 2024 01:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721698059; cv=none; b=gAwba4ybICA79Lw5ZaX+9Y77CORGE4S2mXLvjedWr4xHEF8eyNJdaRZaLF3VLtd2g+K0qPyjrJag28lb/EqhBHkCQ3uQO0fqfZP7ztP+qvlShcWuYbh3JN+UMIV0L9FrDFJV+mxX/9aTx4K9gF24vni3llFsMWX6s1Yd5SEBne0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721698059; c=relaxed/simple;
	bh=bk8f3mAmOfOcYzys3vaBsTDCAlA4HtYX63tneGZ4hMA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EOVWez5NRpJI5tcECn/x1MhbG+4ayurjjmv4gPbj7rFK1Tgnwk/dJWrCvReww52M337Ww/tNe6dOnb74JlQWiYMQq5MVYsZBE3bXhdv4KRVNsCBLerpLY2/s6uU8OLMrbdeBuqHEexY7hXu4RZ24eae70N/5Gq1y/tELRlQn1jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=GweM4/de; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 46N1RQML0284053, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1721698046; bh=bk8f3mAmOfOcYzys3vaBsTDCAlA4HtYX63tneGZ4hMA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=GweM4/del+oz/SljFmiivLoERAXbANZp756Zz3BeCab0RiNCU8SZI/wBgfpuEyn6p
	 CIYIpjLU48wAl4md0yUJHiSrqzFWirDPXk4AkJp3Z91szaCYpRzX9ka3gW6ri4y+7J
	 dFp30el5C0AamfSZTZXIUSlgRRfyFCViXucND9KYdBoA8YKPOd4/Ecen7CSbxDhhz6
	 3fDkmAo3XhROLmo1ucAvAk98d29hIGVaxDiwey9VQWqUaiTkRghEZpJoJauYrEW0wQ
	 Egt0Vd9UlId4pW1sRouW9ETh5xOd+lvVoZvPY8JwoLYOvurH6Zfz16HaDVE7Ab/RlF
	 WjZtayoaDcDDg==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 46N1RQML0284053
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jul 2024 09:27:26 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 23 Jul 2024 09:27:26 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 23 Jul 2024 09:27:25 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Tue, 23 Jul 2024 09:27:25 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Fiona Klute <fiona.klute@gmx.de>
Subject: RE: [PATCH 2/2] wifi: rtw88: 8703b: Fix reported RX band width
Thread-Topic: [PATCH 2/2] wifi: rtw88: 8703b: Fix reported RX band width
Thread-Index: AQHa28ETJnl9hjuhWUS8/RxWhlNz+rICGbEA///3X4CAAXRXAA==
Date: Tue, 23 Jul 2024 01:27:25 +0000
Message-ID: <b445207793b94e349eaf69bcedb428bb@realtek.com>
References: <2fbacb83-3e47-4f37-a70a-fb9f4719eb26@gmail.com>
 <712d08e3-fc90-48ad-bb61-bb601b2cf953@gmail.com>
 <aac7a0fa33fc4593bc291b2c9c800519@realtek.com>
 <bb7f5d98-1b9c-4235-b3b3-1f7da36d3e8d@gmail.com>
In-Reply-To: <bb7f5d98-1b9c-4235-b3b3-1f7da36d3e8d@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS02.realtek.com.tw, 9
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBCeSB0
aGUgd2F5LCB0aGVyZSBpcyBhbm90aGVyIHByb2JsZW0gd2l0aCB0aGUgUlggcmF0ZTogcnR3ODgN
Cj4gZG9lc24ndCByZXBvcnQgaWYgc2hvcnQgZ3VhcmQgaW50ZXJ2YWwgd2FzIHVzZWQuIFRoZSBv
bGRlcg0KPiBjaGlwcyBsaWtlIFJUTDg3MDNCIGhhdmUgdGhlIHNnaV9lbiBiaXQgaW4gdGhlIFBI
WSBzdGF0dXMNCj4gc3RydWN0LCBidXQgSSBjb3VsZG4ndCBmaW5kIG91dCBob3cgdGhlIG5ld2Vy
IGNoaXBzIGRvIGl0Lg0KDQpUaGUgbmV3ZXIgY2hpcHMgZG9uJ3QgaGF2ZSB0aGF0IGJpdCBmb3Ig
UlguDQoNCg0K

