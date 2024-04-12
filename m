Return-Path: <linux-wireless+bounces-6209-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 047C88A240F
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Apr 2024 04:58:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 361401C22277
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Apr 2024 02:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3870B134BD;
	Fri, 12 Apr 2024 02:58:43 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B879A12E6A
	for <linux-wireless@vger.kernel.org>; Fri, 12 Apr 2024 02:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712890723; cv=none; b=vA/HgXiuptxtPxPibBzv+Nhw124ayCcVXWk8GX5xHw7HbnSF78ThwUXpjDTYeCpf3bTT2GonhqO6uoXAXE49WqVIC1aWn2CHVuSp1ovou5Gc9g17/ikPRw3SiXPiqsYWfQrhqOEFesBFaTUHHUzepbuWaHG+w8qLPGFfiK50ywA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712890723; c=relaxed/simple;
	bh=W75D2D97I9x7kCZLRqor3MQgpc7UUkUTHlb6YBqmHeQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cilMbUsccHko0oEHFeIRpqBJRekKGbrXqDT77OArnYG0CPa/+qjmePREkislg5WNlO8nEdTDjvVtItUaAnOTqHa0PCUFQSN4o0fvQxOp825s7oJjo3UoueISHbFkbLnRa4LI9mu5/b9LhE9zZM0Esltb+xCiS10akY53huXIdrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 43C2w64h91696529, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 43C2w64h91696529
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Apr 2024 10:58:07 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 12 Apr 2024 10:58:07 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 12 Apr 2024 10:58:06 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Fri, 12 Apr 2024 10:58:06 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Larry Finger <Larry.Finger@lwfinger.net>,
        Stefan Lippers-Hollmann
	<s.l-h@gmx.de>,
        Christian Hewitt <chewitt@libreelec.tv>
Subject: RE: [PATCH v4 01/14] wifi: rtlwifi: rtl8192de: Fix 5 GHz TX power
Thread-Topic: [PATCH v4 01/14] wifi: rtlwifi: rtl8192de: Fix 5 GHz TX power
Thread-Index: AQHairaoMbcPBHxv0k+AgfuFOnt0krFj9OYg
Date: Fri, 12 Apr 2024 02:58:06 +0000
Message-ID: <48dcd43302d64346a06a94a192b51a79@realtek.com>
References: <91d932b3-5c72-4416-920e-f2bf4fc9b039@gmail.com>
 <4bc08a14-4b6f-463f-a913-ad7f11b89d4f@gmail.com>
In-Reply-To: <4bc08a14-4b6f-463f-a913-ad7f11b89d4f@gmail.com>
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
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

DQpCaXR0ZXJibHVlIFNtaXRoIDxydGw4ODIxY2VyZmUyQGdtYWlsLmNvbT4gd3JvdGU6DQoNCg0K
PiBEaWZmZXJlbnQgY2hhbm5lbHMgaGF2ZSBkaWZmZXJlbnQgVFggcG93ZXIgc2V0dGluZ3MuIHJ0
bDgxOTJkZSBpcyB1c2luZw0KPiB0aGUgVFggcG93ZXIgc2V0dGluZyBmcm9tIHRoZSB3cm9uZyBj
aGFubmVsIGluIHRoZSA1IEdIeiBiYW5kIGJlY2F1c2UNCj4gX3J0bDkyY19waHlfZ2V0X3JpZ2h0
Y2hubHBsYWNlIGV4cGVjdHMgYW4gYXJyYXkgd2hpY2ggaW5jbHVkZXMgYWxsIHRoZQ0KPiBjaGFu
bmVsIG51bWJlcnMsIGJ1dCBpdCdzIHVzaW5nIGFuIGFycmF5IHdoaWNoIGluY2x1ZGVzIG9ubHkg
dGhlIDUgR0h6DQo+IGNoYW5uZWwgbnVtYmVycy4NCj4gDQo+IFVzZSB0aGUgYXJyYXkgY2hhbm5l
bF9hbGwgKGRlZmluZWQgaW4gcnRsODE5MmRlL3BoeS5jKSBpbnN0ZWFkIG9mDQo+IHRoZSBpbmNv
cnJlY3QgY2hhbm5lbDVnIChkZWZpbmVkIGluIGNvcmUuYykuDQo+IA0KPiBUZXN0ZWQgb25seSB3
aXRoIHJ0bDgxOTJkdSwgd2hpY2ggd2lsbCB1c2UgdGhlIHNhbWUgVFggcG93ZXIgY29kZS4NCj4g
DQo+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+IFNpZ25lZC1vZmYtYnk6IEJpdHRlcmJs
dWUgU21pdGggPHJ0bDg4MjFjZXJmZTJAZ21haWwuY29tPg0KDQoNCkFja2VkLWJ5OiBQaW5nLUtl
IFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT4NCg0KDQoNCg==

