Return-Path: <linux-wireless+bounces-20983-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5576BA75E92
	for <lists+linux-wireless@lfdr.de>; Mon, 31 Mar 2025 07:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFF05166608
	for <lists+linux-wireless@lfdr.de>; Mon, 31 Mar 2025 05:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04D7529CEB;
	Mon, 31 Mar 2025 05:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="CkWVWPbT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F4ABE67
	for <linux-wireless@vger.kernel.org>; Mon, 31 Mar 2025 05:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743399574; cv=none; b=Rx2jUUHFwLyDl4i11JGL15eJVBFU3gaiVwDquAgbSnOV7/LtAPiTu8KpV2mFNPfBrKdmqH8dq5l9pfAXVSKRRvaPuU+C70ByytDMppNCNrSCmWfUu+D37e2ZulpO4nvXQeW5jhM57izLGOPwJvh54bJPKl2rzoBOBshQvEZgeRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743399574; c=relaxed/simple;
	bh=uWYYYGpYZ1x1JmKNt9S/hH6/FPbtEpyAd2tEmDs8XnQ=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LGk6xe0rGjjpJr58CjbOKEmlp6Cq7b/IJ0QUu7FtWU4VOtqsmVdFUXup0vqojX6Il1RIIpDW2PAY09Jrcv8IRCXMajmLJsec+UUhtsvC+v2uS/3ctmOKfcclCDczjPmylS9yf5nLykCodFVEDBkKUm2RO37gyeyOiS6Z9a7mQKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=CkWVWPbT; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 52V5dSNX12843982, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1743399568; bh=uWYYYGpYZ1x1JmKNt9S/hH6/FPbtEpyAd2tEmDs8XnQ=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=CkWVWPbT5fCuBQKtTd1EZtqab+YF0aN70fxXXeXjBlfp5I8pq+WBf4P/KhXveLxu8
	 Y9Mzx6hWd1gFYbaVy1aye19/oszk6wyLj0YXnYIceu+iOJO5cbSP6BySeQBeUdrTYP
	 x/J0WwmzBFVz9cekwOBiPYYHLzgUKlAel/6rRMZJKql6w9yYj0ASmLZ/PlPmyRdB5p
	 imiyYfCwvdsA3Zz+GbERNBe5sqVTCzAawzjx7eMFTf+VtqGtkykZ3Fb9KUQCol5xl0
	 sfdejLl8ykdm71SlUCym7ZfEKXA4Q1Yuur+x7VNIDhW/P+7a0I7gJJevGMgHCl5xFc
	 l2dKtiRZeXsTg==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 52V5dSNX12843982
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Mar 2025 13:39:28 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 31 Mar 2025 13:39:29 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 31 Mar 2025 13:39:28 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Mon, 31 Mar 2025 13:39:28 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next v2 3/4] wifi: rtw88: Set AMPDU factor to hardware for RTL8814A
Thread-Topic: [PATCH rtw-next v2 3/4] wifi: rtw88: Set AMPDU factor to
 hardware for RTL8814A
Thread-Index: AQHboYP7IGLws9Tdb065n81yCmiPbLOMumvQ
Date: Mon, 31 Mar 2025 05:39:28 +0000
Message-ID: <ec6629764e494ac2a48f9303a5065eeb@realtek.com>
References: <5ccba1b8-d7de-4158-bc9a-0aa465f1b2df@gmail.com>
 <b22de162-f914-4c91-acfb-254de8776ca6@gmail.com>
In-Reply-To: <b22de162-f914-4c91-acfb-254de8776ca6@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBAQCAt
MjA1MSw2ICsyMDYxLDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBydHdfY2hpcF9vcHMgcnR3ODgx
NGFfb3BzID0gew0KPiAgICAgICAgIC5zZXRfYW50ZW5uYSAgICAgICAgICAgID0gTlVMTCwNCj4g
ICAgICAgICAuY2ZnX2xkbzI1ICAgICAgICAgICAgICA9IHJ0dzg4MTRhX2NmZ19sZG8yNSwNCj4g
ICAgICAgICAuZWZ1c2VfZ3JhbnQgICAgICAgICAgICA9IHJ0dzg4MTRhX2VmdXNlX2dyYW50LA0K
PiArICAgICAgIC5zZXRfYW1wZHVfZmFjdG9yICAgICAgID0gcnR3ODgxNGFfc2V0X2FtcGR1X2Zh
Y3RvciwNCg0KUGxlYXNlIHNldCBOVUxMIHRvIG90aGVyIGNoaXBzIHRoYXQgZG9uJ3QgaW1wbGVt
ZW50IHRoaXMgdG8gZXhwbGljaXRseQ0KcG9pbnQgb3V0IHRoZXkgZG9uJ3QgaGF2ZSB0aGlzLCBh
bmQgYWxzbyBJIGhvcGUgYWxsIGZpZWxkcyBvZiBhbGwgY2hpcHMNCmFyZSBhbGlnbmVkLiANCg0K
PiAgICAgICAgIC5mYWxzZV9hbGFybV9zdGF0aXN0aWNzID0gcnR3ODgxNGFfZmFsc2VfYWxhcm1f
c3RhdGlzdGljcywNCj4gICAgICAgICAucGh5X2NhbGlicmF0aW9uICAgICAgICA9IHJ0dzg4MTRh
X3BoeV9jYWxpYnJhdGlvbiwNCj4gICAgICAgICAuY2NrX3BkX3NldCAgICAgICAgICAgICA9IHJ0
dzg4MTRhX3BoeV9jY2tfcGRfc2V0LA0KPiAtLQ0KPiAyLjQ5LjANCg0K

