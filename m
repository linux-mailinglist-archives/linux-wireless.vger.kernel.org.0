Return-Path: <linux-wireless+bounces-8238-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E458D2A01
	for <lists+linux-wireless@lfdr.de>; Wed, 29 May 2024 03:29:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F90F289EAB
	for <lists+linux-wireless@lfdr.de>; Wed, 29 May 2024 01:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB9E15A862;
	Wed, 29 May 2024 01:29:10 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14FD15AAD9;
	Wed, 29 May 2024 01:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716946150; cv=none; b=ZMZrD/1gShE6ycCHNovvC+qWBLX2EzzlZdgStYZsryuI1ON8XSxAHbb6BfrTs2y1GWaT6W2Ia3b8TWVag1Nr2qzLhl8vrp0CIpZeRemP5eqt3auoRbWkYfzPSyySnrXL6qTi2wTQ+I8PlCIB1GV4G8tY9wLTp7tMAp1QYRw0MVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716946150; c=relaxed/simple;
	bh=lkvz82Zkg1Uxcp8tAZo4JvAUx8Uw550p4vhxe3h2Up8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sOlLPVi15YXN+l+Hv7CAhDn2CLYmchpqelDrwyoHF4yQK9ro/ZWyuI0XQLPDWPr9LqE6qJN10PPdANOiFZ4N0c/HgSBzQ3vQXGfk5YwRleqp9KAENxdAxuNE03p0UJLg7s+fJUH5Y1Wl/nU6pbH0cSLdl39fnw2/iz6BenieaW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 44T1Slj662994523, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 44T1Slj662994523
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 May 2024 09:28:47 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 29 May 2024 09:28:47 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 29 May 2024 09:28:46 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Wed, 29 May 2024 09:28:46 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: =?utf-8?B?TWFyY2luIMWabHVzYXJ6?= <marcin.slusarz@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: =?utf-8?B?TWFyY2luIMWabHVzYXJ6?= <mslusarz@renau.com>,
        Tim K
	<tpkuester@gmail.com>, Larry Finger <Larry.Finger@lwfinger.net>,
        Kalle Valo
	<kvalo@kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] wifi: rtw88: schedule rx work after everything is set up
Thread-Topic: [PATCH] wifi: rtw88: schedule rx work after everything is set up
Thread-Index: AQHasFekMjDEF5R7/k+0650S2/2b8bGrUuCQgACfb4CAAAQJAIABdicQ
Date: Wed, 29 May 2024 01:28:46 +0000
Message-ID: <801bd77995184b1fa35bf4a32ab3a036@realtek.com>
References: <13e848c1544245e6aef4b89c3f38daf0@realtek.com>
 <20240528110246.477321-1-marcin.slusarz@gmail.com>
In-Reply-To: <20240528110246.477321-1-marcin.slusarz@gmail.com>
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

TWFyY2luIMWabHVzYXJ6IDxtYXJjaW4uc2x1c2FyekBnbWFpbC5jb20+IHdyb3RlOg0KPiBGcm9t
OiBNYXJjaW4gxZpsdXNhcnogPG1zbHVzYXJ6QHJlbmF1LmNvbT4NCj4gDQo+IFJlcG9ydGVkLWJ5
OiBUaW0gSyA8dHBrdWVzdGVyQGdtYWlsLmNvbT4NCj4gQ2xvc2VzOg0KPiBodHRwczovL2xvcmUu
a2VybmVsLm9yZy9saW51eC13aXJlbGVzcy9DQStzaG9XUTdQNDlqaFFhc29mRGNUZFFoaXVhclBU
allFRGEtLU5pVlZ4NDk0V2N1UXdAbWFpbC5nbWFpbC4NCj4gY29tLw0KDQpJIGdhdmUgdGhpcyBz
dWdnZXN0aW9ucyB0b28gZWFybHksIHNpbmNlIHdlIGhhdmUgbm90IGdvdHRlbiB0ZXN0IHJlc3Vs
dCBmcm9tIFRpbS4NCkkgd2lsbCBjaGFuZ2UgdGhlbSB0byAiTGluazoiIGlmIG5vIEFDSyBmcm9t
IFRpbSB3aGlsZSBtZXJnaW5nLiANCg0KPiBTaWduZWQtb2ZmLWJ5OiBNYXJjaW4gxZpsdXNhcnog
PG1zbHVzYXJ6QHJlbmF1LmNvbT4NCj4gQ2M6IFBpbmctS2UgU2hpaCA8cGtzaGloQHJlYWx0ZWsu
Y29tPg0KPiBDYzogTGFycnkgRmluZ2VyIDxMYXJyeS5GaW5nZXJAbHdmaW5nZXIubmV0Pg0KPiBD
YzogS2FsbGUgVmFsbyA8a3ZhbG9Aa2VybmVsLm9yZz4NCj4gQ2M6IGxpbnV4LXdpcmVsZXNzQHZn
ZXIua2VybmVsLm9yZw0KPiBDYzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KDQpUaGlz
IGlzIHYyIHZlcnNpb24sIHNvIG1haWwgc3ViamVjdCBzaG91bGQgYmUgIltQQVRDSCB2Ml0gLi4u
LiIsIGFuZCBhZGQgDQpjaGFuZ2UgbG9nIGhlcmUsIGxpa2U6DQoNCi0tLSAgKGRlbGltaXRlciBp
cyBpbXBvcnRhbnQgaGVyZSkNCg0KdjI6IGFkZCBSZXBvcnRlZC1ieSBhbmQgQ2xvc2VzLg0KDQo+
IC0tLQ0KPiAgZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OC91c2IuYyB8IDEzICsr
KysrKysrKystLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspLCAzIGRlbGV0
aW9ucygtKQ0KPiANCg0KQWxzbyBJIHdvdWxkIHByZWZlciB0byBwb2ludCBvdXQgInVzYiIgaW4g
c3ViamVjdCwgcGxlYXNlIHVzZSAid2lmaTogcnR3ODg6IHVzYjogIg0KYXMgcHJlZml4Lg0KDQpb
Li4uXQ0KDQo=

