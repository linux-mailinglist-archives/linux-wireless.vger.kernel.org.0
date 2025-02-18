Return-Path: <linux-wireless+bounces-19085-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6370A38FDC
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Feb 2025 01:12:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89CE1188FE65
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Feb 2025 00:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2C4A47;
	Tue, 18 Feb 2025 00:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="d/6Fxrv4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414BB819
	for <linux-wireless@vger.kernel.org>; Tue, 18 Feb 2025 00:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739837530; cv=none; b=DWluxJ9JRPWOV3DGqXttbC0uimfjAewfKe9UA9zwYIIKeKXdIaIwUBzPz/N6bpDL+70hHNL+OCJGpnldwCOsSalmdDs7gbKIAMKmYsKEiBt2zQjSIQC3xz8sVAYuxVekNLEBip6cfGcVBeQ6/Qmmvx7THuHwBZRdhyf4MMQ5ads=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739837530; c=relaxed/simple;
	bh=EL5ftmjCC+CAFwwswqNOLfq3lcfH4JJ8ZweYsMDXMSE=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WNCUSiOOYkBD4cIwkaGgJwdj63ZOV0XUSb+PveBPi7mEdb/Iont1hZZCpiWo/IEh6qHhrk8waJYzhdpQp0fgyo7YxB7UB7qnhVW9e8Oatt8XaaTNHfmLqn8N4cFZQIgtCQHtePnT1ftJWGGUD7t1uFtn5ZZJwLsfy5LtQbgg42w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=d/6Fxrv4; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 51I0C2TQ03877033, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1739837522; bh=EL5ftmjCC+CAFwwswqNOLfq3lcfH4JJ8ZweYsMDXMSE=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=d/6Fxrv4YiYqp4KHidzRYs0aSohE0LPVuMBz40kP60UXlbGkVzXJvs1B6TykQKdKS
	 zHf+7TKnD+m1vBr3f2oWHq6G0SHM3uZXhmdpDr8m4ky20KEhOl6hFuqhrqrll7iLEu
	 NQqBDafiwpRCJoJ2ugXPfPDrGeD19PStYL8t/fsywHBN7tOjRL/hzD5VEkN8I6ljsV
	 N+7L1YxmCV4wLY4DD30OMcLuzZ7QPMEATHxwEqGdJ08EbIHfaDY0hgt/+2toAD6H7g
	 6X+Kr76rFz83wccoe4icMgCbMcgLgjkDG6UiKEB9vtRmvxbhXpVcMd5fPSzzAwTkgH
	 c4nS3dbgntmRg==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 51I0C2TQ03877033
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Feb 2025 08:12:02 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 18 Feb 2025 08:12:03 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 18 Feb 2025 08:12:02 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::f515:f604:42fb:a42b]) by
 RTEXMBS04.realtek.com.tw ([fe80::f515:f604:42fb:a42b%5]) with mapi id
 15.01.2507.035; Tue, 18 Feb 2025 08:12:02 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH v3 2/8] wifi: rtw88: Fix rtw_desc_to_mcsrate() to handle MCS16-31
Thread-Topic: [PATCH v3 2/8] wifi: rtw88: Fix rtw_desc_to_mcsrate() to handle
 MCS16-31
Thread-Index: AQHbgZPci7CtFw9y4UagSy9JkNAgWrNMMDQA
Date: Tue, 18 Feb 2025 00:12:02 +0000
Message-ID: <2d45cc0434844265a60a9cb148b25205@realtek.com>
References: <3908a496-d687-40fb-a1af-6add5c7e1dd4@gmail.com>
 <d0a5a86b-4869-47f6-a5a7-01c0f987cc7f@gmail.com>
In-Reply-To: <d0a5a86b-4869-47f6-a5a7-01c0f987cc7f@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBUaGlz
IGZ1bmN0aW9uIHRyYW5zbGF0ZXMgdGhlIHJhdGUgbnVtYmVyIHJlcG9ydGVkIGJ5IHRoZSBoYXJk
d2FyZSBpbnRvDQo+IHNvbWV0aGluZyBtYWM4MDIxMSBjYW4gdW5kZXJzdGFuZC4gSXQgd2FzIGln
bm9yaW5nIHRoZSAzU1MgYW5kIDRTUyBIVA0KPiByYXRlcy4gVHJhbnNsYXRlIHRoZW0gdG9vLg0K
PiANCj4gQWxzbyBzZXQgKm5zcyB0byAwIGZvciB0aGUgSFQgcmF0ZXMsIGp1c3QgdG8gbWFrZSBz
dXJlIGl0J3MNCj4gaW5pdGlhbGlzZWQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBCaXR0ZXJibHVl
IFNtaXRoIDxydGw4ODIxY2VyZmUyQGdtYWlsLmNvbT4NCg0KQWNrZWQtYnk6IFBpbmctS2UgU2hp
aCA8cGtzaGloQHJlYWx0ZWsuY29tPg0KDQoNCg==

