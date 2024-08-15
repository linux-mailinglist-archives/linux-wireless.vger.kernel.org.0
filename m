Return-Path: <linux-wireless+bounces-11475-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91025952AA9
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Aug 2024 10:34:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EED9D282772
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Aug 2024 08:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D42A1A00CE;
	Thu, 15 Aug 2024 08:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="KUgBnEOM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE004CA62
	for <linux-wireless@vger.kernel.org>; Thu, 15 Aug 2024 08:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723708889; cv=none; b=ilQ7Rwc47RiEK9kbwnJHfv8JkWBAZTcH3txOwg40ULGzi+9En8LObUvl1X2m9asSwQhZyreQP5TdMPot0rjmVLZs/70jdcj3QYfOdxeEXRo3KIqNDdARABQiPXYIv73N1f3jLnVUuuA+xSQLfpzwAOpRS0W7vbk8tHVrk1aWOl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723708889; c=relaxed/simple;
	bh=esHWbZy8IB7MJXfHW9QGRx0rk9eeHBy7UC6sEL53JnM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Jmvri60jSMLQ4PLOC/zK7e4XVr1XqHGTqm3s5NL9U2nBQ/Cz2Z+lQBxqoKndFQhxxbCwCgN9yS7x//KYfPwQjCOE1TYHtX5Iq+rv5MSdzowpR4NEsuc8eSjoTTo3bnaVHl6nLo9JQERKu5GMfRMi5zW9vWKV/aFKq3v+gWDBCaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=KUgBnEOM; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 47F81F6H03760612, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1723708875; bh=esHWbZy8IB7MJXfHW9QGRx0rk9eeHBy7UC6sEL53JnM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=KUgBnEOMbeOcjSgHcGBXYOCL5ugApCABxpQrp+lhdCsFRjCaZ+wiYSy6CcXrSeTTt
	 rYZqxihZXSgLUjOvE+wLWqs4oij+MQfn2E3l6fydYKASyYG+quaq8Q5UIrj3Bi2Fss
	 nTPqye4wLaB1+BLQLchIaBUSei5Uz0qFqx5BA7DRWkjg8fIACujA45exOacSpJhlge
	 UMJf0E/SLyBEcxPCB5y3TsDDFOy4di9sekctAU216h9WUQznRwuW9WLrTo+udMSs18
	 zgMQqwXUv7VmltKZt+WWX1X45Kax4uflbx3mj2BdFyicPVyXxn6CF2uDtbtjLyDENs
	 XTC9A9IcsZ9vw==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 47F81F6H03760612
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Aug 2024 16:01:15 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 15 Aug 2024 16:01:15 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 15 Aug 2024 16:01:15 +0800
Received: from RTEXDAG02.realtek.com.tw ([fe80::1849:eb4c:c240:1ba0]) by
 RTEXDAG02.realtek.com.tw ([fe80::1849:eb4c:c240:1ba0%5]) with mapi id
 15.01.2507.035; Thu, 15 Aug 2024 16:01:15 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Zenm Chen <zenmchen@gmail.com>, Christian Hewitt <chewitt@libreelec.tv>,
        Nick Morrow <usbwifi2024@gmail.com>
Subject: RE: [PATCH 20/20] wifi: rtw88: Enable the new RTL8821AU/RTL8812AU drivers
Thread-Topic: [PATCH 20/20] wifi: rtw88: Enable the new RTL8821AU/RTL8812AU
 drivers
Thread-Index: AQHa7DMdfngbJ5k2H0mm/rlMwmtSbrIn+XVQ
Date: Thu, 15 Aug 2024 08:01:15 +0000
Message-ID: <0ba8bfdfa558462da3016a27b1015996@realtek.com>
References: <ade57ca1-444f-49e2-b49e-f4b9da65b2cc@gmail.com>
 <9add94a5-c2e7-4583-9d34-a0b14884903f@gmail.com>
In-Reply-To: <9add94a5-c2e7-4583-9d34-a0b14884903f@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBUaGVz
ZSBhcmUgb2xkZXIgV2lmaSA1IGNoaXBzLiBSVEw4ODIxQVUgaXMgMXgxLCB3aXRoIG9yIHdpdGhv
dXQNCj4gQmx1ZXRvb3RoLiBSVEw4ODEyQVUgaXMgMngyLCB3aXRob3V0IEJsdWV0b290aC4NCj4g
DQo+IEJlYW1mb3JtaW5nIGlzIG5vdCBpbXBsZW1lbnRlZC4gSXQgbG9va3MgbGlrZSB0aGVzZSBj
aGlwcyBuZWVkIGENCj4gZGlmZmVyZW50IGltcGxlbWVudGF0aW9uIHRoYW4gd2hhdCBpcyBpbiBi
Zi5jLg0KPiANCj4gU3BlZWQgdGVzdHMgd2l0aCBSVEw4ODIxQVU6IDEzNyBNYnBzIGRvd25sb2Fk
LCAxNDQgTWJwcyB1cGxvYWQuDQo+IFNwZWVkIHRlc3RzIHdpdGggUlRMODgxMkFVOiAzNDQgTWJw
cyBkb3dubG9hZCwgMzg3IE1icHMgdXBsb2FkLg0KPiANCj4gUlRMODgxMkFVIHNob3VsZCBiZSBm
YXN0ZXIsIGJ1dCBteSByb3V0ZXIgaXMgY3VycmVudGx5IGxpbWl0ZWQgdG8NCj4gdHJhbnNtaXR0
aW5nIG9ubHkgb25lIHNwYXRpYWwgc3RyZWFtIGR1ZSB0byBhIGtlcm5lbCBidWcuDQoNCkNvdWxk
IHlvdSBhbHNvIG1lbnRpb24gb3BlcmF0aW9uIG1vZGUgKGUuZy4gU1RBIGFuZCBBUCkgeW91IGhh
dmUgdGVzdGVkPw0KSSB0aGluayBBUCBtb2RlIHBhdGNoIGNhbid0IHdvcmsgZm9yIG5vdywgYmVj
YXVzZSBJIGhhdmUgbm90IHlldCBzZW50IG91dA0KdGhlIGZpeGVzLg0KDQpQYXRjaCAxOC8yMCBp
cyBxdWl0ZSBsYXJnZS4gUGxlYXNlIGdpdmUgbWUgc29tZSB0aW1lIHRvIHJldmlldy4NCg0K

