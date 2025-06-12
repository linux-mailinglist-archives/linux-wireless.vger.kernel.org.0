Return-Path: <linux-wireless+bounces-24019-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF1FAD651E
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jun 2025 03:28:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB5057A42C5
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jun 2025 01:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 202E87DA82;
	Thu, 12 Jun 2025 01:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="Z4rCwKTe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76FA172613;
	Thu, 12 Jun 2025 01:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749691702; cv=none; b=gB9N5qcCHZY4E/BI7KvnfdFyyHwKvbCHQDQGTz4GrdqJvlblenev61KxK0X2lGLHSfKtq3lHluz6QTFB0f1ofbKryDI9cHoHWJWxbVHmBgHYRf5HrdwnwfvJz7tDAIQR4U/4ERpV940UVXkDqOHwDbxNmRzymSxdP4Ch1esQ4lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749691702; c=relaxed/simple;
	bh=wZHSfTsYJJTuBLEu3RXhZb3Lf0kJvZHbZUlHZWlqOQ4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rR+T5pjKoKrn4fEelY63jknveeQcjkISvy2tYW8LJeKL71q6pwz4zaOj/4+7Lc3kl4V4nbfqG+4SELxUnWvutOG0mJC9P+16MC7EoNprPayNQX43WO2WR5qfnXAX9pvQqXVWWjfTvVhTMInRTGTBfFJzAtdxVc3y9M0p2F7HXZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=Z4rCwKTe; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 55C1S0dS41631548, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1749691680; bh=wZHSfTsYJJTuBLEu3RXhZb3Lf0kJvZHbZUlHZWlqOQ4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=Z4rCwKTeSitv9AfShvsFSRjRdYA6dEJu2dsj/6crMUaIqCWpO4JYHC47YF0Wg6/NX
	 lKQJotGMTJ7jutlOotx53LFzMfj/7cYoXwh1OSV4S5th5W39KeupTuL6zLAFPEUJMT
	 nSjd+9ZKaiR+ZHGg+Auv3v7xrt9SVx9eOx6j95xS1JY/Aogh68bk21iMKNqprmpkkv
	 dlchF2yDMNrdPpH/hZM51uo1iKfO5XkmN3/R2mf+6hqhYyX3opI9h4Ib6L0R0rXcQy
	 AvXZF+hqKkFytikSb3oxiy0IltlS4w4GEEj/CoHVvNx05H6y3dzz4YtnJPgKGFKU6/
	 qxBQy2Uykno7w==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 55C1S0dS41631548
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Jun 2025 09:28:00 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 12 Jun 2025 09:28:00 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 12 Jun 2025 09:27:58 +0800
Received: from RTEXDAG02.realtek.com.tw ([fe80::1d65:b3df:d72:eb25]) by
 RTEXDAG02.realtek.com.tw ([fe80::1d65:b3df:d72:eb25%5]) with mapi id
 15.01.2507.035; Thu, 12 Jun 2025 09:27:58 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        kernel test robot
	<lkp@intel.com>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
CC: "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>
Subject: RE: [PATCH rtw-next v2 14/14] wifi: rtw89: Enable the new USB modules
Thread-Topic: [PATCH rtw-next v2 14/14] wifi: rtw89: Enable the new USB
 modules
Thread-Index: AQHb2XV4UvlgvG5pOESwpZNcSugO9rP7xDMAgAAbN4CAATzvcIAARemAgAFSCLA=
Date: Thu, 12 Jun 2025 01:27:58 +0000
Message-ID: <b34d246be15849a99310bf326a66b07c@realtek.com>
References: <663044d3-0816-4b1b-874d-776835e774e9@gmail.com>
 <202506101956.cNXM2Qvb-lkp@intel.com>
 <b8690413-059d-4330-992b-36a7af10aa30@gmail.com>
 <01eb10716bdb4241a012d378d1f7b67d@realtek.com>
 <0d712ef0-ea93-4825-8a4c-45f9d7f9e8d9@gmail.com>
In-Reply-To: <0d712ef0-ea93-4825-8a4c-45f9d7f9e8d9@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS01.realtek.com.tw, 9
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBPbiAx
MS8wNi8yMDI1IDAzOjMyLCBQaW5nLUtlIFNoaWggd3JvdGU6DQo+ID4+Pg0KPiA+Pj4+PiBkcml2
ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg5L3J0dzg4NTFiLmM6NTIzOjQ3OiBlcnJvcjog
dXNlIG9mIHVuZGVjbGFyZWQgaWRlbnRpZmllcg0KPiA+PiAnQl9BWF9TT1BfRURTV1InDQo+ID4+
PiAgICAgIDUyMyB8ICAgICAgICAgICAgICAgICBydHc4OV93cml0ZTMyX2NscihydHdkZXYsIFJf
QVhfU1lTX1BXX0NUUkwsIEJfQVhfU09QX0VEU1dSKTsNCj4gPj4+ICAgICAgICAgIHwgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXg0K
PiA+Pj4gICAgMSBlcnJvciBnZW5lcmF0ZWQuDQo+ID4+Pg0KPiA+PiBPb3BzLCBJJ2xsIGFkZCB0
aGF0IHRvIHJlZy5oIGluIHYzLg0KPiA+DQo+ID4gVGhlIE5BUEkgYWxzbyByZXBvcnRlZCB0aGUg
c2FtZSB0aGluZ3MgWzFdIFsyXS4NCj4gPg0KPiA+IE5vdCBzdXJlIGlmIHlvdSB3aWxsIHNlbmQg
djMgcmlnaHQgYXdheS4gSWYgc28sIEkgd2lsbCBpZ25vcmUgdjIuDQo+ID4NCj4gPiBbMV0gaHR0
cDovL3dpZmlib3Quc2lwc29sdXRpb25zLm5ldC9yZXN1bHRzLzk2OTk4MC8xNDExMTE4Ny9idWls
ZF8zMmJpdC9zdGRlcnINCj4gPiBbMl0gaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wcm9q
ZWN0L2xpbnV4LXdpcmVsZXNzL2xpc3QvP3Nlcmllcz05Njk5ODANCj4gPg0KPiANCj4gSSB3b3Vs
ZCBwcmVmZXIgdG8gd2FpdCBmb3IgeW91ciByZXZpZXcuIElzIHRoYXQgb2theT8NCg0KWWVzLiBJ
IHdpbGwgcmV2aWV3IHYyLg0KDQo=

