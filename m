Return-Path: <linux-wireless+bounces-9892-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86DBE92546D
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 09:13:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C9A31C21046
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 07:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A16135A6F;
	Wed,  3 Jul 2024 07:13:32 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939D44DA14;
	Wed,  3 Jul 2024 07:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719990812; cv=none; b=pRYqy1UfczLovWTIvu4JxNBHXr3d/QBFBqAq+KnI556zxNPdHDMyDiZ2ZsRqYsfbtMKLnqVDTBN1AwFxIeIwIMWVid668IBXNPWOhzU3RmCIiZZvGm+OeCTYKrlltee25caJGcuI3cTsTVu0yFPp/GM1cqLABA283NaP6KHoomc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719990812; c=relaxed/simple;
	bh=gxhry6f7Qq+X1gSMbYw3QVD/pApH+V7KFggIkoGMSzg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lXBN2PQcnb/vQLeQ1jhL19k5LW5GknfvGzH74PTuaFJR4vOVNksQrOHCqjypNdyf7k1pyPDBWlZ3l9istcCaKhgHsBmToBUHBMubfsErHPQd7lix8sQX998RmR9PZJx9+uKwt18uuPuvW8L87gcxfvJYiESGUpdTVVwG7UxBzZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4637D5IG01903813, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 4637D5IG01903813
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 3 Jul 2024 15:13:05 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 3 Jul 2024 15:13:06 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 3 Jul 2024 15:13:05 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Wed, 3 Jul 2024 15:13:05 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: =?utf-8?B?RnJlZHJpayBMw7ZubmVncmVu?= <fredrik@frelon.se>,
        Kalle Valo
	<kvalo@kernel.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] wifi: rtlwifi: fix default typo
Thread-Topic: [PATCH] wifi: rtlwifi: fix default typo
Thread-Index: AQHazReaKZBOQ9EV5kewY1BwpfyCZrHkle/w
Date: Wed, 3 Jul 2024 07:13:05 +0000
Message-ID: <afdfd27b079d460c8a064d91d1aa99e2@realtek.com>
References: <20240703070627.135328-1-fredrik@frelon.se>
In-Reply-To: <20240703070627.135328-1-fredrik@frelon.se>
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

RnJlZHJpayBMw7ZubmVncmVuIDxmcmVkcmlrQGZyZWxvbi5zZT4gd3JvdGU6DQo+IFN1YmplY3Q6
IFtQQVRDSF0gd2lmaTogcnRsd2lmaTogZml4IGRlZmF1bHQgdHlwbw0KDQpHZW5lcmFsbHkgc3Vi
amVjdCBvZiB2MiBwYXRjaCBzaG91bGQgYmUgIltQQVRDSCB2Ml0iIGFuZCBuZWVkIGEgY2hhbmdl
bG9nLg0KQnV0IG5vIG5lZWQgcmVzZW5kIGZvciB0aGlzIHBhdGNoLiANCg0KPiANCj4gQ2hhbmdl
ICdkZWZ1bHQnIHRvICdkZWZhdWx0JyBpbiBjb21tZW50cyBpbiBzZXZlcmFsIHJ0bHdpZmkgZHJp
dmVycy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEZyZWRyaWsgTMO2bm5lZ3JlbiA8ZnJlZHJpa0Bm
cmVsb24uc2U+DQoNCkFja2VkLWJ5OiBQaW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT4N
Cg0K

