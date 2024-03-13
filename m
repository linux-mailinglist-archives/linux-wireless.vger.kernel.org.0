Return-Path: <linux-wireless+bounces-4658-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D47B87A132
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Mar 2024 03:00:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA3DF1F22545
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Mar 2024 02:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90140BA2D;
	Wed, 13 Mar 2024 02:00:35 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525F5BA31
	for <linux-wireless@vger.kernel.org>; Wed, 13 Mar 2024 02:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710295235; cv=none; b=AB0+tsVDV4BGZE9vjdQJCIg4YjtoXH8XNwCsYqihuICxZv+rG5i9sVcnL2/OZx9XgenlslAZT88mqE0T8vUxudjEfNDS+BMIrVsXl7BQsMfFqtxPVSekVmjOqGXkM79BcC/ahSBfFW/qqRcdxY5NAUbpY7/DUJKMsV/nKIpzWMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710295235; c=relaxed/simple;
	bh=9xP76bPA6IFJOHAcrK4AXsaU/nyzDFMq7r7pu8k9V1U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hHNQ7p23OHIZBbEahL6wCvoynzJt+0SGONqyVjI320YjB7DbK4uT8zow04K8j4dbqzCqJ6fCD+OrNSUPcm/MKttkTJsYOvyttWQxOyE+RZ0xmeKt5m+2uzMb4pqP3OErrpgt13rYtmqC6OHb3+pnW9YD7U/CPY9oCH8JS+/sCBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 42D20OS20419394, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 42D20OS20419394
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Mar 2024 10:00:24 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 13 Mar 2024 10:00:24 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 13 Mar 2024 10:00:23 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f]) by
 RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f%7]) with mapi id
 15.01.2507.035; Wed, 13 Mar 2024 10:00:23 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Larry Finger <Larry.Finger@lwfinger.net>
Subject: RE: [PATCH] wifi: rtlwifi: rtl8192de: Fix 5 GHz TX power
Thread-Topic: [PATCH] wifi: rtlwifi: rtl8192de: Fix 5 GHz TX power
Thread-Index: AQHadHc+y1p0wnFmpUaBbm9dm2gSZ7E05aGAgAAFZjA=
Date: Wed, 13 Mar 2024 02:00:23 +0000
Message-ID: <a9a93e7bd7e94870be0f38dd6792ab29@realtek.com>
References: <9995b805-ef8b-47c9-b176-ff540066039a@gmail.com>
 <43c344357f564170872501e34490c851@realtek.com>
In-Reply-To: <43c344357f564170872501e34490c851@realtek.com>
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGluZy1LZSBTaGloIDxw
a3NoaWhAcmVhbHRlay5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgTWFyY2ggMTMsIDIwMjQgOTo1
NSBBTQ0KPiBUbzogQml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+OyBs
aW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IExhcnJ5IEZpbmdlciA8TGFycnku
RmluZ2VyQGx3ZmluZ2VyLm5ldD4NCj4gU3ViamVjdDogUkU6IFtQQVRDSF0gd2lmaTogcnRsd2lm
aTogcnRsODE5MmRlOiBGaXggNSBHSHogVFggcG93ZXINCj4gDQo+ID4gVGVzdGVkIG9ubHkgd2l0
aCBydGw4MTkyZHUsIHdoaWNoIHdpbGwgdXNlIHRoZSBzYW1lIFRYIHBvd2VyIGNvZGUuDQoNCkJl
Y2F1c2UgYW5vdGhlciBwYXRjaHNldCBhZGRpbmcgcnRsODE5MmR1IGlzIGJhc2VkIG9uIHRoaXMg
cGF0Y2gsIEkgc3VnZ2VzdA0KdG8gc2VuZCB0aGVtIGFzIHNpbmdsZSBvbmUgcGF0Y2hzZXQuIA0K
DQpQaW5nLUtlDQoNCg==

