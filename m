Return-Path: <linux-wireless+bounces-6413-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 298058A7A93
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Apr 2024 04:31:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A228B21681
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Apr 2024 02:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECB3163A;
	Wed, 17 Apr 2024 02:30:54 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F1C37B
	for <linux-wireless@vger.kernel.org>; Wed, 17 Apr 2024 02:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713321054; cv=none; b=LITudTbYTsb9UMWyYf6oFGMxS/K+jN5z52vR1woQbPuiC9FWmHTB/Q5SdthOMU6zEOxoqHywm7SjlvtGjacLDrm+EMyTa8gbKHjmttoNml3NtYghO09rBpVbcU3S5EIZb56d5+qHHxR9RrAtQrpnx18loMPveA9d/6pNrd/UGfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713321054; c=relaxed/simple;
	bh=yw0dCoJEKxdOyfGn6AFIbxCq70O28HjEB+vbF5MMK40=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=T4fN8d98xyTQBFREIjdkR0b33l/9Px+r64b1eKf4Z0PRWxIul65/hKrzyZhwvJtC1YiTSj2xY3U/p5l75ltBfHhSaB1chUxa/UH/i5GaeCTpi4fTVfdTOI2/F4Z7zVGLvA6SH2CBRtd6eHNihppQC1EBlg42qmmTP/RY1js/tEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 43H2UQB102884621, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 43H2UQB102884621
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Apr 2024 10:30:26 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 17 Apr 2024 10:30:26 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 17 Apr 2024 10:30:26 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Wed, 17 Apr 2024 10:30:26 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Larry Finger <Larry.Finger@lwfinger.net>,
        Stefan Lippers-Hollmann
	<s.l-h@gmx.de>,
        Christian Hewitt <chewitt@libreelec.tv>
Subject: RE: [PATCH v5 3/6] wifi: rtlwifi: rtl8192de: Fix endianness issue in RX path
Thread-Topic: [PATCH v5 3/6] wifi: rtlwifi: rtl8192de: Fix endianness issue in
 RX path
Thread-Index: AQHaj3MtK+hpjKVrv0mRnJNhnw9ulrFrvz0w
Date: Wed, 17 Apr 2024 02:30:26 +0000
Message-ID: <e64e352fe4d0441eb7d0c787961fccb0@realtek.com>
References: <561cc9e4-3ddc-40cd-a076-2c14c44eea87@gmail.com>
 <4f5feba7-82ad-4287-a34f-648529a972d0@gmail.com>
In-Reply-To: <4f5feba7-82ad-4287-a34f-648529a972d0@gmail.com>
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
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KDQo+IFN0
cnVjdHMgcnhfZGVzY185MmQgYW5kIHJ4X2Z3aW5mb185MmQgd2lsbCBub3Qgd29yayBmb3IgYmln
IGVuZGlhbg0KPiBzeXN0ZW1zLg0KPiANCj4gRGVsZXRlIHJ4X2Rlc2NfOTJkIGJlY2F1c2UgaXQn
cyBiaWcgYW5kIGJhcmVseSB1c2VkLCBhbmQgaW5zdGVhZCB1c2UNCj4gdGhlIGdldF9yeF9kZXNj
X3J4bWNzIGFuZCBnZXRfcnhfZGVzY19yeGh0IGZ1bmN0aW9ucywgd2hpY2ggd29yayBvbiBiaWcN
Cj4gZW5kaWFuIHN5c3RlbXMgdG9vLg0KPiANCj4gRml4IHJ4X2Z3aW5mb185MmQgYnkgZHVwbGlj
YXRpbmcgZm91ciBvZiBpdHMgbWVtYmVycyBpbiB0aGUgY29ycmVjdA0KPiBvcmRlci4NCj4gDQo+
IFRlc3RlZCBvbmx5IHdpdGggUlRMODE5MkRVLCB3aGljaCB3aWxsIHVzZSB0aGUgc2FtZSBjb2Rl
Lg0KPiBUZXN0ZWQgb25seSBvbiBhIGxpdHRsZSBlbmRpYW4gc3lzdGVtLg0KPiANCj4gQ2M6IHN0
YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4gU2lnbmVkLW9mZi1ieTogQml0dGVyYmx1ZSBTbWl0aCA8
cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQoNCkFja2VkLWJ5OiBQaW5nLUtlIFNoaWggPHBrc2hp
aEByZWFsdGVrLmNvbT4NCg0KDQoNCg0K

