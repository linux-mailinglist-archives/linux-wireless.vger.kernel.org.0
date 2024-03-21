Return-Path: <linux-wireless+bounces-5082-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A418881C70
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Mar 2024 07:21:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DC5C282ADA
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Mar 2024 06:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E9A83A1C5;
	Thu, 21 Mar 2024 06:21:31 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E861BB65F
	for <linux-wireless@vger.kernel.org>; Thu, 21 Mar 2024 06:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711002091; cv=none; b=rELXACyT3qIr6Ga350qFrrl/KiPC1TgwKibSqVIsU7CN9+xrg3n9R3chTsHBkNa45SKhRBUtBU/FSVlqm3E5lmlg5otONrgxh9+e1Ad3ry3KQinLHEIQlFLoRHrjFEN0fFLndtvApNgzYb90frM10hZ3u44lYlWea2hhN/2BO8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711002091; c=relaxed/simple;
	bh=QGDhzEsfpHSToH5Euh+LbP971mHWseO2zcxXqszomhc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eJ+6DgZ0MI8tvm3mJqZM8bl7FQuO3tTBU5CwmucXl+zZodB5eKKDBCpL6xRv/1SOb087tPlHiEMjXBr3zgrB4gKOKyQ+CwUfZcjKnop5aufh4/ivAQg5hz5+6oInXNhH32S49p5kCCvxGDHI3nTxvohdSXWPa5uPhtPOSqOEy6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 42L6LMakC914766, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 42L6LMakC914766
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Mar 2024 14:21:22 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 21 Mar 2024 14:21:22 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 21 Mar 2024 14:21:22 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c42:f80:bcc2:d00f]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c42:f80:bcc2:d00f%5]) with mapi id
 15.01.2507.035; Thu, 21 Mar 2024 14:21:22 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: "kvalo@kernel.org" <kvalo@kernel.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Leo.Li"
	<leo.li@realtek.com>
Subject: Re: [PATCH] wifi: rtw89: disable txptctrl IMR to avoid flase alarm
Thread-Topic: [PATCH] wifi: rtw89: disable txptctrl IMR to avoid flase alarm
Thread-Index: AQHaezuD0B/f5lkmzkaOqNn1/IzumbFBpkXY//9/XgCAAI5OC///eyeAgACJzA///3o6gA==
Date: Thu, 21 Mar 2024 06:21:22 +0000
Message-ID: <b1babfd26efb957dc239bfe61a63f145371602b9.camel@realtek.com>
References: <20240321025603.20614-1-pkshih@realtek.com>
	 <878r2c2mob.fsf@kernel.org>
	 <2eefd73994778c1fa1dc03acf04708d686ec3185.camel@realtek.com>
	 <87jzlw9l8y.fsf@kernel.org>
	 <01c674f6f1442494bc7ec9778bd650aa63e6ad95.camel@realtek.com>
	 <87frwk9kfg.fsf@kernel.org>
In-Reply-To: <87frwk9kfg.fsf@kernel.org>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
user-agent: Evolution 3.36.1-2 
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-ID: <A3395E2FBA69404898A0BFD43834652F@realtek.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback

T24gVGh1LCAyMDI0LTAzLTIxIGF0IDA4OjE4ICswMjAwLCBLYWxsZSBWYWxvIHdyb3RlOg0KPiAN
Cj4gQWN0dWFsbHkgbm8gbmVlZCBldmVuIGZvciB0aGF0LiBJIHRha2UgYWxsIHBhdGNoZXMgYW5k
IHB1bGwgcmVxdWVzdHMNCj4gZnJvbSBwYXRjaHdvcmsgYW55d2F5IDopDQo+IA0KDQpHb3QgaXQg
OikNCg0KUGluZy1LZQ0KDQo=

