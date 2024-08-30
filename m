Return-Path: <linux-wireless+bounces-12219-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E702965400
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Aug 2024 02:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D42A5B2075C
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Aug 2024 00:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27BD723BE;
	Fri, 30 Aug 2024 00:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="BYxUXzP7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11731D1300
	for <linux-wireless@vger.kernel.org>; Fri, 30 Aug 2024 00:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724977824; cv=none; b=uJFVeylZqKPY/Qx9yttGBi+GA4fOow7pWTlMkYP+3iRFULSQ5fk++66OMzcI0/ifTFRsCHtZw7XJSXURxYEIO5r1tzPZy1Wo/Hi/ACtriEU2EI5/z+C3BYZJJbW/Y2h75Uwck+lIvJRhl5oljfMqGJsjeucH4jMEoBe7N3O8nQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724977824; c=relaxed/simple;
	bh=J4jn+ARMSjWKMj6K02Fc/PQvuuL8z8Dh0hcXuwnnK4g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rpdqhViziXmkBqcjObZAA0cAlHYxgsabzhQkgsuGyGyLSrxHWc7rDRUYX8amh6BvNhM6tXCnUnkeArUnpBkvbZ5jsPdyI/e7yj9vtu8fTTzMIvUB/MBa89ozQtm8UKSfFu1c5aqiHzt/a1dIdQo5jglylczEBoSTVVYURid5MjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=BYxUXzP7; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 47U0U4WI0019521, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1724977804; bh=J4jn+ARMSjWKMj6K02Fc/PQvuuL8z8Dh0hcXuwnnK4g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=BYxUXzP7PJ8dpHFr5X+epGtBxwGeZKtCISAYluUZHxFJpUIgAXSPrsXspx+MOt5pt
	 E92QEic3ChFZlk4UmVfPMFh2Oa8/QYzvLjOiKQBcvptXtpp7vcCVWvU1mEvZjK5iEq
	 MdJdBjshsmySvfrci+C6yhJNBtb84BAJoOG0/SpfBRy2ehA1hmHtw1AfPBSFE7Osbh
	 RN1ZqMXxw3DOAQxMz4GURjgwSVyyMZS62cnuJkLFVxGNtHueyr7xSLSV4n0EnJkua8
	 FogHjx/Qn+xCkgoMX5gYLxB0W3/1hnwGNziP1Hza+7kSw/wTQDRuoTEuxm2c26pvMA
	 2Rn6TJOLLICJw==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 47U0U4WI0019521
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Aug 2024 08:30:04 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 30 Aug 2024 08:30:04 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 30 Aug 2024 08:30:04 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Fri, 30 Aug 2024 08:30:04 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Sascha Hauer <sha@pengutronix.de>,
        Martin Blumenstingl
	<martin.blumenstingl@googlemail.com>
Subject: RE: [PATCH v2] wifi: rtw88: Fix USB/SDIO devices not transmitting beacons
Thread-Topic: [PATCH v2] wifi: rtw88: Fix USB/SDIO devices not transmitting
 beacons
Thread-Index: AQHa88uZkrWSUcxp5kOvYRABrOtmGbI+/tWg
Date: Fri, 30 Aug 2024 00:30:04 +0000
Message-ID: <1b09a87e86a344c299fe83fc38a9e323@realtek.com>
References: <49de73b5-698f-4865-ab63-100e28dfc4a1@gmail.com>
In-Reply-To: <49de73b5-698f-4865-ab63-100e28dfc4a1@gmail.com>
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

SGkgQml0dGVyYmx1ZSwgDQoNCkJpdHRlcmJsdWUgU21pdGggPHJ0bDg4MjFjZXJmZTJAZ21haWwu
Y29tPiB3cm90ZToNCj4gDQo+IEFsbCBVU0IgZGV2aWNlcyBzdXBwb3J0ZWQgYnkgcnR3ODggaGF2
ZSB0aGUgc2FtZSBwcm9ibGVtOiB0aGV5IGRvbid0DQo+IHRyYW5zbWl0IGJlYWNvbnMgaW4gQVAg
bW9kZS4gKFNvbWU/KSBTRElPIGRldmljZXMgYXJlIGFsc28gYWZmZWN0ZWQuDQo+IFRoZSBjYXVz
ZSBhcHBlYXJzIHRvIGJlIGNsZWFyaW5nIEJJVF9FTl9CQ05RX0RMIG9mIFJFR19GV0hXX1RYUV9D
VFJMDQo+IGJlZm9yZSB1cGxvYWRpbmcgdGhlIGJlYWNvbiByZXNlcnZlZCBwYWdlLCBzbyBkb24n
dCBjbGVhciB0aGUgYml0IGZvcg0KPiBVU0IgYW5kIFNESU8gZGV2aWNlcy4NCj4gDQo+IFRlc3Rl
ZCB3aXRoIFJUTDg4MTFDVSBhbmQgUlRMODcyM0RVLg0KPiANCj4gQ2M6IDxzdGFibGVAdmdlci5r
ZXJuZWwub3JnPiAjIDYuNi54DQo+IFNpZ25lZC1vZmYtYnk6IEJpdHRlcmJsdWUgU21pdGggPHJ0
bDg4MjFjZXJmZTJAZ21haWwuY29tPg0KDQpDYW4gSSBzYXkgdHdvIGJlbG93IHBhdGNoc2V0IGFy
ZSBlcXVpdmFsZW50IGluIHlvdXIgc2lkZT8NCg0KW1BhdGNoc2V0IDE6IHlvdXIgdjFdDQoxMzc0
NDA5NyBOZXcgICAgICAgICAgWzEvMl0gd2lmaTogcnR3ODg6IEZpeCBVU0IgZGV2aWNlcyBub3Qg
dHJhbnNtaXR0aW5nIGJlYWNvbnMNCjEzNzQ0MDk4IE5ldyAgICAgICAgICBbMi8yXSB3aWZpOiBy
dHc4ODogQXZvaWQgdXNpbmcgbWFjaWQgMCBpbiBBUCBtb2RlDQoNCltQYXRjaHNldCAyOiB5b3Vy
IHYyICsgbWluZV0NCjEzNzcxNTk3IE5ldyAgICAgICAgICBbdjJdIHdpZmk6IHJ0dzg4OiBGaXgg
VVNCL1NESU8gZGV2aWNlcyBub3QgdHJhbnNtaXR0aW5nIGJlYWNvbnMNCjEzNzY3NzQ2IE5ldyAg
ICAgICAgICB3aWZpOiBydHc4ODogYXNzaWduIG1hY19pZCBmb3IgdmlmL3N0YSBhbmQgdXBkYXRl
IHRvIFRYIGRlc2MNCg0KSWYgdGhpcyBjYW4gbWFrZSBBUCBtb2RlIG9uIFVTQiBkZXZpY2VzIHN0
ZXAgZm9yd2FyZCwgSSB3aWxsIG1lcmdlIHRoZW0gYWhlYWQuICANCg0KDQo=

