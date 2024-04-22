Return-Path: <linux-wireless+bounces-6617-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 72DE48AC2ED
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Apr 2024 05:14:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DF28B2099F
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Apr 2024 03:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF9B8462;
	Mon, 22 Apr 2024 03:14:04 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85102F37
	for <linux-wireless@vger.kernel.org>; Mon, 22 Apr 2024 03:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713755644; cv=none; b=qxCXI0PpELzYk3jIkvmU8C+Je2659ncIkhGwEYeFn67eyJbjj6F/ElTwY/PgGuEVZIGOeZCJ6iIeYAkaBYl6EQAzFIoF5IFSrh8IHGl/6AcDybks+UE+xsTN3kASEtE+MSttpdv8Ur2OHJ1gm14U6T80DFOQKw8OXJ4FIr8X0mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713755644; c=relaxed/simple;
	bh=oiLXAAW+Aja3RG47EjoIT74kACQGboaw5slSyGWCRdo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=arZjU4Mkd5Xmlj9u31jwtH4VXcFYMcqDij1FwWKhGApYCkRabdGd0yQfHBex+0fzp2u/WHWga3slNfJ6rT5WAJJKcPALq0S7x7sbceZ2j53qSgght3Xhy875SLCN1xEt1nPfJR0MmAT0rnrypURJ3MwOp4qoR2mALenageZlQFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 43M3DXZO03803751, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 43M3DXZO03803751
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Apr 2024 11:13:33 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 22 Apr 2024 11:13:33 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 22 Apr 2024 11:13:33 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Mon, 22 Apr 2024 11:13:33 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Larry Finger <Larry.Finger@lwfinger.net>,
        Stefan Lippers-Hollmann
	<s.l-h@gmx.de>,
        Christian Hewitt <chewitt@libreelec.tv>
Subject: RE: [PATCH v6 5/6] wifi: rtlwifi: Clean up rtl8192d-common a bit
Thread-Topic: [PATCH v6 5/6] wifi: rtlwifi: Clean up rtl8192d-common a bit
Thread-Index: AQHakl7m3VEUiDOpF0S1SPORZ/eAMLFzn8xg
Date: Mon, 22 Apr 2024 03:13:33 +0000
Message-ID: <13ed709559ee4a48993519c88223a8d3@realtek.com>
References: <9d54a192-d389-4a56-9286-2e7721cbbc27@gmail.com>
 <fe031948-9602-4f6b-9c13-7797047c03b6@gmail.com>
In-Reply-To: <fe031948-9602-4f6b-9c13-7797047c03b6@gmail.com>
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
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBJbXBy
b3ZlIHJlYWRhYmlsaXR5Og0KPiAgKiBhZGQgZW1wdHkgbGluZXMNCj4gICogdXNlIGFic19kaWZm
IGluIHJ0bDkyZF9kbV90eHBvd2VyX3RyYWNraW5nX2NhbGxiYWNrX3RoZXJtYWxtZXRlcg0KPiAg
KiByb2xsIHVwIHJlcGVhdGVkIHN0YXRlbWVudHMgaW50byBhIGZvciBsb29wIGluDQo+ICAgIHJ0
bDkyZF9kbV90eHBvd2VyX3RyYWNraW5nX2NhbGxiYWNrX3RoZXJtYWxtZXRlcg0KPiAgKiBzaG9y
dGVuIGxpbmVzIGJ5IHJlcGxhY2luZyBtYW55IGluc3RhbmNlcyBvZiAicnRscHJpdi0+ZG0iIHdp
dGggImRtIg0KPiAgICBwb2ludGVyIGluIHJ0bDkyZF9kbV90eHBvd2VyX3RyYWNraW5nX2NhbGxi
YWNrX3RoZXJtYWxtZXRlcg0KPiAgKiBzb3J0IHNvbWUgZGVjbGFyYXRpb25zIGJ5IGxlbmd0aA0K
PiAgKiByZWZhY3RvciBfcnRsOTJkX2dldF90eHBvd2VyX3dyaXRldmFsX2J5X3JlZ3VsYXRvcnkg
YSBsaXR0bGUNCj4gICogcmVmYWN0b3IgX3J0bDkyZGVfcmVhZHBvd2VydmFsdWVfZnJvbXByb20g
YSBsaXR0bGUNCj4gDQo+IERlbGV0ZSB1bnVzZWQgc3RydWN0cyB0YWdfZHluYW1pY19pbml0X2dh
aW5fb3BlcmF0aW9uX3R5cGVfZGVmaW5pdGlvbg0KPiBhbmQgc3dhdC4NCj4gDQo+IFNpbXBsaWZ5
IHJ0bDkyZF9maWxsX2gyY19jbWQgYSBsaXR0bGUgYW5kIGRlbGV0ZSBhIHBvaW50bGVzcyB3cmFw
cGVyDQo+IGZ1bmN0aW9uLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQml0dGVyYmx1ZSBTbWl0aCA8
cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQoNClRoYW5rcyBmb3IgdGhlIGNsZWFudXAgYW5kIHRl
c3QuIFBsZWFzZSBhbHNvIHByb3ZpZGUgdGVzdGVkIGRldmljZXMNCnRvIG1lLg0KDQpSZXZpZXdl
ZC1ieTogUGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+DQoNCg0K

