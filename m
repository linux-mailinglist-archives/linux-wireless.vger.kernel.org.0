Return-Path: <linux-wireless+bounces-14111-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 886F49A1736
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Oct 2024 02:36:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0F4C1C25F2A
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Oct 2024 00:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9E8A3C30;
	Thu, 17 Oct 2024 00:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="TOFpWxhW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D5123A6
	for <linux-wireless@vger.kernel.org>; Thu, 17 Oct 2024 00:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729125382; cv=none; b=l5Z1+CZDWvbNL/3uS13bSHFFgd+uP4VfiPdFB6Z4pR/yK1f/ppy00zeEm+7VZJJNtT6aKeIffiQhABsiCs3VQoc93o8UGiO+gjs3Vcn9kbYthJ2cBb10O7fWBWunJjPNLilJ7ttISSd+9bkgAVZxppnOUmv5IfXIOtvGPFXGVxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729125382; c=relaxed/simple;
	bh=zVO3Jd4vumkKOtjug0IN3GIl2UmtycEBJ1zshKSOt4Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JrGu6fARH82YCHGfptEiOMpreEjSCfwpjh1pFxWkBX7H1NnuZg0K3yLntBlamr8hfAngfVSYNbuiOsQmampKRmqacF6fk4jaUnfPKXKC3lFVY68fo7OSYwzFGlv3ifNxs1TTSZkC6gg/KwSQGUCgsb4uYewGb/uDbdeOwGupbmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=TOFpWxhW; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 49H0a43k93784787, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1729125364; bh=zVO3Jd4vumkKOtjug0IN3GIl2UmtycEBJ1zshKSOt4Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=TOFpWxhWdvQUCr0rB2MqCsbLrAK2NhNYeOPgoS2Kk4G5uVGiGibNJHEXBpzZRXdq0
	 ldjsli0W8EDTyNLXP7IDMg+PVtbIe2Nsrjwr+dLwU6AaN7pie4Wb8ZUqRoOZ1NV8iR
	 avxY430E7Ck2V/BWrSPZT/faOnK2aVs8a3MPkH++nOjCc4Pmo4vlt75mnj1I/lmXzd
	 5hJH9sQHbApnILsX9ZTX4cMXf7PZwXlH+dSHIPHmbuijYDxOM417gA/6O97GGAcXCJ
	 gAP+HRmMicmJeve23yGQfU4zJU7Fd/S94o881pxmsCGoMccYKrmTR6y3GqFvdwlEC6
	 a54GZNWTgX3rg==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 49H0a43k93784787
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 08:36:04 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 17 Oct 2024 08:36:05 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 17 Oct 2024 08:36:04 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Thu, 17 Oct 2024 08:36:04 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Josh Boyer <jwboyer@kernel.org>, Zenm Chen <zenmchen@gmail.com>
CC: "linux-firmware@kernel.org" <linux-firmware@kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "rtl8821cerfe2@gmail.com" <rtl8821cerfe2@gmail.com>
Subject: RE: [PATCH] rtlwifi: Update firmware for RTL8192FU to v7.3
Thread-Topic: [PATCH] rtlwifi: Update firmware for RTL8192FU to v7.3
Thread-Index: AQHbH8UzsWb2UM8CAkOhONa+QCMpobKI1AwAgAFEFtA=
Date: Thu, 17 Oct 2024 00:36:04 +0000
Message-ID: <8f3ebe73a46e4bf3b1b9eeb74bbc305a@realtek.com>
References: <20241016121544.5557-1-zenmchen@gmail.com>
 <CA+5PVA6gOcu611LcLzv47ZPwe-AtUb+GN2K-zK_84eMfk7Yc6A@mail.gmail.com>
In-Reply-To: <CA+5PVA6gOcu611LcLzv47ZPwe-AtUb+GN2K-zK_84eMfk7Yc6A@mail.gmail.com>
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

Sm9zaCBCb3llciA8andib3llckBrZXJuZWwub3JnPiB3cm90ZToNCj4gDQo+IFBpbmctS2UsIGNh
biB3ZSBnZXQgYW4gQWNrZWQtYnkgZm9yIHRoaXM/DQo+IA0KDQpDb25maXJtZWQgd2l0aCByZWxl
YXNlZCBwYWNrYWdlLCBzbw0KDQpBY2tlZC1ieTogUGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRl
ay5jb20+DQoNCkJ5IHRoZSB3YXksIGl0IHNlZW1zIHlvdSBtaXNzZWQgYSBwdWxsLXJlcXVlc3Qg
WzFdIGRheXMgYWdvLg0KSWYgbm90LCBzb3JyeSBmb3IgdGhlIHBpbmcuDQoNClsxXSBodHRwczov
L2xvcmUua2VybmVsLm9yZy9saW51eC1maXJtd2FyZS8yZTJlN2VhYzg2ZGI0NWU4YTE5ODAwMjFj
N2EzOTgzZEByZWFsdGVrLmNvbS9ULyN1DQoNCg0KDQo=

