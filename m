Return-Path: <linux-wireless+bounces-12939-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B24797B9BC
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Sep 2024 11:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D138B2871C6
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Sep 2024 09:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF6DF1791EB;
	Wed, 18 Sep 2024 09:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="L+F+53r/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1405A178376;
	Wed, 18 Sep 2024 09:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726650013; cv=none; b=TldVZCU8ycVdhUdv7R9J2By5n7l/OBBSCeTi4shED2QGVemWBtKwaiBsV3KDlcQQdc0VSf4Y7ncjt2FDqpBSq3vZXpshxAKmOkjJs31pvV8qzLFu2SA5b1MvU6CXet9AxYMUBggqDb++C6BpDDu1Ew6U2xrKF4V/NgUd4mxAUT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726650013; c=relaxed/simple;
	bh=zpWsjuIBWVAiCqX8yerATDfj5psK97U5Z6dT4Yxw4Tw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gj/b6MZZFJ4E0yUhY3uj0bvcrQ/NOQTRSAUGmq3XdCZjzc470IK+FQpgKGTFrx+RY0pgS7XrVduv3aGjFIquxhDpHwzX6ZUR9plgbDYagRtSMA8UP0EeJBYaAFpXcC0JaokkTjWXRheS9V388D16kZgYIsBm9nE1mdY5Kl1ltAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=L+F+53r/; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 48I904cD41868928, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1726650005; bh=zpWsjuIBWVAiCqX8yerATDfj5psK97U5Z6dT4Yxw4Tw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=L+F+53r/PLprrq9jPOE4sNVVK0XsuTCcXfvVkCi9TFADZ+aOtg0wFcs0vrhoYbL3q
	 ckr+N+bGpe/Jq3yePY2wF9HSOQWyIKU+nHEM+2IwnBlezMuztHwvgSjOGX0k/ZK9rk
	 EFWUITonQXwtuThYFrb08DwF8ef+Kozi1HNIRGM5PlpMTNtblhQW33mHR7Z0X61wZi
	 BiP5KBGYjR9Inw9XZuwrt5WoDArfRYRmWntPsrOP8V90yBQ/bH9Oapb3qWTFv/64hL
	 Pj5l6Oktwv8UvPjg+mNg5yI3PbCM6FcNi7DnKwjkhNg4CD63wJXSvi/43C8WMLAJHZ
	 SSS3Je5pSmSvA==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.05/5.92) with ESMTPS id 48I904cD41868928
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Sep 2024 17:00:05 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 18 Sep 2024 17:00:05 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 18 Sep 2024 17:00:04 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Wed, 18 Sep 2024 17:00:04 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: =?utf-8?B?TWFyY2VsIFdlacOfZW5iYWNo?= <mweissenbach@ignaz.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: RTL8852BE wifi no longer working after 6.11 upgrade
Thread-Topic: RTL8852BE wifi no longer working after 6.11 upgrade
Thread-Index: AQHbCMemb6H6HxFviUGmiPt2/8qxPLJdDI+A//+Vo4CAAJ3wIA==
Date: Wed, 18 Sep 2024 09:00:04 +0000
Message-ID: <63a3ef5acd70454e9f8db114204e2e2d@realtek.com>
References: <f755bbeb5bbb479f9142bf223e71102c@realtek.com>
 <20240918073237.Horde.VLueh0_KaiDw-9asEEcdM84@ignaz.org>
In-Reply-To: <20240918073237.Horde.VLueh0_KaiDw-9asEEcdM84@ignaz.org>
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

TWFyY2VsIFdlacOfZW5iYWNoIDxtd2Vpc3NlbmJhY2hAaWduYXoub3JnPiB3cm90ZToNCj4gU2V0
dGluZyByZXQgdG8gLTEgZGlkIHRoZSBqb2IsIHdpZmkgd29ya3MgYWdhaW4gYXMgZXhwZWN0ZWQu
DQo+IA0KPiBIZXJlIGlzIHRoZSBvdXRwdXQgb2YgZG1pZGVjb2RlDQo+IGh0dHBzOi8vaWduYXou
b3JnL25leHRjbG91ZC9pbmRleC5waHAvcy90WmRqWVlkeWVXcEhQSDQNCj4gDQoNCkkgd3JvdGUg
YSBxdWlyayBhY2NvcmRpbmcgdG8geW91ciBkbWlkZWNvZGUgWzFdLiBQbGVhc2UgdHJ5IGlmIHRo
aXMgY2FuDQpzdGlsbCB3b3JrIHRvIHlvdS4gSWYgeWVzLCBwbGVhc2UgaGVscCB0byByZXBseSBh
IFRlc3RlZC1ieSB0YWcgdGhlcmUuDQpUaGFua3MuIA0KDQpbMV0gaHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvbGludXgtd2lyZWxlc3MvMjAyNDA5MTgwODU1NTEuNTQ2MTEtMS1wa3NoaWhAcmVhbHRl
ay5jb20vVC8jdQ0KDQoNCg==

