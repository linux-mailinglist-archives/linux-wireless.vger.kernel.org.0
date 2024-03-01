Return-Path: <linux-wireless+bounces-4279-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C0E086D854
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Mar 2024 01:29:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6A131F228E0
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Mar 2024 00:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E97365;
	Fri,  1 Mar 2024 00:29:46 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ECCA622
	for <linux-wireless@vger.kernel.org>; Fri,  1 Mar 2024 00:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709252986; cv=none; b=rGAo68ETDbMZfWbPc7E54+VOg8rbhp/C1fx+PcULFjyFPRcfq+iexlsyRA7xPszQVb2//dmZFXJEgP58CgiHezBmYDT5ZE3jAB9Jp2T7utaux9oRvuW0x2+aID5+X1+BR/UdduQakQsUyAvFLu7TPsR8IYlksqazDw79M1wMxvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709252986; c=relaxed/simple;
	bh=XjprWXJeSeOcf1t3fBDeQ7hlY6aFaIljMsdW4TZBj78=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VmRGHztIUdP6+nkoHtfr8+agFU55G4bGGiEe4dqxxvWN/8YNhL7GbVe/SZVPkqPVt8ASrpFo87PWrlIkg+l7FC0DF05FA+6sAzhwfdwHQe6xK9nOJnMs3+cXkgSWMlSlH1X4WxEc6P/mDMbdM57c/hbFgQcwVp2O7yXABhZyG38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4210TaHU21648794, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4210TaHU21648794
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 1 Mar 2024 08:29:36 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.17; Fri, 1 Mar 2024 08:29:37 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 1 Mar 2024 08:29:37 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f]) by
 RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f%7]) with mapi id
 15.01.2507.035; Fri, 1 Mar 2024 08:29:37 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Sascha Hauer <sha@pengutronix.de>
Subject: RE: [PATCH v2 4/4] wifi: rtw88: 8821c: Fix false alarm count
Thread-Topic: [PATCH v2 4/4] wifi: rtw88: 8821c: Fix false alarm count
Thread-Index: AQHaa1+uutG0UtpX8kSOOvVu0AaaA7EiCB9Q
Date: Fri, 1 Mar 2024 00:29:36 +0000
Message-ID: <702510fda0764d219a005a35f76dddd0@realtek.com>
References: <f12ed39d-28e8-4b8b-8d22-447bcf295afc@gmail.com>
 <f3cb6d17-e4e4-44a7-9c9b-72aed994b5c9@gmail.com>
In-Reply-To: <f3cb6d17-e4e4-44a7-9c9b-72aed994b5c9@gmail.com>
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQml0dGVyYmx1ZSBTbWl0
aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQo+IFNlbnQ6IEZyaWRheSwgTWFyY2ggMSwgMjAy
NCA2OjM2IEFNDQo+IFRvOiBsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IFBp
bmctS2UgU2hpaCA8cGtzaGloQHJlYWx0ZWsuY29tPjsgU2FzY2hhIEhhdWVyIDxzaGFAcGVuZ3V0
cm9uaXguZGU+DQo+IFN1YmplY3Q6IFtQQVRDSCB2MiA0LzRdIHdpZmk6IHJ0dzg4OiA4ODIxYzog
Rml4IGZhbHNlIGFsYXJtIGNvdW50DQo+IA0KPiB0b3RhbF9mYV9jbnQgaXMgc3VwcG9zZWQgdG8g
aW5jbHVkZSBjY2tfZmFfY250IGFuZCBvZmRtX2ZhX2NudCwgbm90IGp1c3QNCj4gb2ZkbV9mYV9j
bnQuDQo+IA0KPiBGaXhlczogOTYwMzYxMjM4Yjg2ICgicnR3ODg6IDg4MjFjOiBhZGQgZmFsc2Ug
YWxhcm0gc3RhdGlzdGljcyIpDQo+IFNpZ25lZC1vZmYtYnk6IEJpdHRlcmJsdWUgU21pdGggPHJ0
bDg4MjFjZXJmZTJAZ21haWwuY29tPg0KDQpBY2tlZC1ieTogUGluZy1LZSBTaGloIDxwa3NoaWhA
cmVhbHRlay5jb20+DQoNClRoYW5rcyBmb3IgeW91ciBncmVhdCB3b3JrIQ0KDQo=

