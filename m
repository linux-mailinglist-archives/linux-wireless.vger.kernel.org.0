Return-Path: <linux-wireless+bounces-4276-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D131E86D84F
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Mar 2024 01:27:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 751591F22FFC
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Mar 2024 00:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF50917E;
	Fri,  1 Mar 2024 00:27:40 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE7F622
	for <linux-wireless@vger.kernel.org>; Fri,  1 Mar 2024 00:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709252860; cv=none; b=mheWrnvTdKoYT4Eu+F0eKHBVCNJFC83sfoB6yDJIinhxY0EeNBZmrMbDCDPBsoZ9FsqGSOGq1H2jSj8siZh0aQ27X7R1OvUD8TUO3qWNLBiUSz/+Qoe/UVATzKGKf9KAbD6gtyVtLvcBu3eOf23t5TSA0O277SP5E7pCNBH7nXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709252860; c=relaxed/simple;
	bh=Z/344593MNYH0Aajv10V6EvgAgvgmCQJIUdJpNZ4NEE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EuPUXXIcL8dCTXToyS6UU5bdU+td3cjGEOXsiLTqfngSwPiaRkNZisDF9kI4lGqVjzTazQQivSFCwxDO1enoUQU3gT9gQ4DgjBLChsOUlrnqjfSc4aQ6ca321mfYfUiCWRRtY+mCSjTuT2TZg1wBzT8hnvBKVghWhSkhGP4MLTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4210RLteC1648682, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4210RLteC1648682
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 1 Mar 2024 08:27:21 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.32; Fri, 1 Mar 2024 08:27:22 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 1 Mar 2024 08:27:21 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f]) by
 RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f%7]) with mapi id
 15.01.2507.035; Fri, 1 Mar 2024 08:27:21 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Sascha Hauer <sha@pengutronix.de>, Sean Mollet <sean@malmoset.com>
Subject: RE: [PATCH v2 1/4] wifi: rtw88: 8821cu: Fix firmware upload fail
Thread-Topic: [PATCH v2 1/4] wifi: rtw88: 8821cu: Fix firmware upload fail
Thread-Index: AQHaa189tSCbijtwS0yzdt21JXpIcLEiB5tA
Date: Fri, 1 Mar 2024 00:27:21 +0000
Message-ID: <d87868d102754552a82c8ed99486c683@realtek.com>
References: <f12ed39d-28e8-4b8b-8d22-447bcf295afc@gmail.com>
In-Reply-To: <f12ed39d-28e8-4b8b-8d22-447bcf295afc@gmail.com>
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQml0dGVyYmx1ZSBTbWl0
aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQo+IFNlbnQ6IEZyaWRheSwgTWFyY2ggMSwgMjAy
NCA2OjMzIEFNDQo+IFRvOiBsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IFBp
bmctS2UgU2hpaCA8cGtzaGloQHJlYWx0ZWsuY29tPjsgU2FzY2hhIEhhdWVyIDxzaGFAcGVuZ3V0
cm9uaXguZGU+OyBTZWFuIE1vbGxldCA8c2VhbkBtYWxtb3NldC5jb20+DQo+IFN1YmplY3Q6IFtQ
QVRDSCB2MiAxLzRdIHdpZmk6IHJ0dzg4OiA4ODIxY3U6IEZpeCBmaXJtd2FyZSB1cGxvYWQgZmFp
bA0KPiANCj4gUlRMODgyMkNVLCBSVEw4ODIyQlUsIGFuZCBSVEw4ODIxQ1UgbmVlZCBhbiBleHRy
YSByZWdpc3RlciB3cml0ZSBhZnRlcg0KPiByZWFkaW5nIGFuZCB3cml0aW5nIGNlcnRhaW4gYWRk
cmVzc2VzLg0KPiANCj4gV2l0aG91dCB0aGlzLCB0aGUgZmlybXdhcmUgdXBsb2FkIGZhaWxzIGFw
cHJveGltYXRlbHkgbW9yZSB0aGFuIDUwJSBvZg0KPiB0aGUgdGltZS4NCj4gDQo+IFRlc3RlZCB3
aXRoIFJUTDg4MTFDVSAoVGVuZGEgVTkgVjIuMCkgd2hpY2ggaXMgdGhlIHNhbWUgYXMgUlRMODgy
MUNVDQo+IGJ1dCB3aXRob3V0IEJsdWV0b290aC4NCj4gDQo+IEZpeGVzOiBhODJkZmQzM2QxMjMg
KCJ3aWZpOiBydHc4ODogQWRkIGNvbW1vbiBVU0IgY2hpcCBzdXBwb3J0IikNCj4gU2lnbmVkLW9m
Zi1ieTogQml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQoNCkFja2Vk
LWJ5OiBQaW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT4NCg0K

