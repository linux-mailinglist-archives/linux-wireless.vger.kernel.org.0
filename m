Return-Path: <linux-wireless+bounces-16020-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CFA99E8B94
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 07:37:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DD842818B6
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 06:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 810262135D0;
	Mon,  9 Dec 2024 06:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="k2V9NdZt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2596C2144D7;
	Mon,  9 Dec 2024 06:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733726243; cv=none; b=Aiw+O+riiMDO5jIHI+v9kuTixW+E/iEceMeWUkNjq+PJh1fRGqU5BYh9G+kjpjMezungrY5O31PwiUvcUXQ9r4XXR8rPdkai8yfVaY0RvGymBnOLndE6hNL9/m6zsVpPQQvA12IMYA9F2Uq/TcnwIKtXNbY2Vh2RpO7DwYd9Gas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733726243; c=relaxed/simple;
	bh=eEJrBLMMmXq9YpHxaQ+oZ1t2lVaKcmbGm1kX+g5RNi4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eYeVYjUSmaVdvld0/Fq8CrJEq2LGt6SWGlBRFh8zoMnHjJcmTEIhiHNACFO8PYsQTCMdPPXDoAQX+hGrr+fE/N9sSvw5CRChNwEZ5U4gH8ZQvUg4eKzCTcNQ/WhE3/8CpiuKljk6qVTwtRFgTVreBz1AiZEF+gb/pOOfFBGzkzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=k2V9NdZt; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4B96b88b9145487, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1733726228; bh=eEJrBLMMmXq9YpHxaQ+oZ1t2lVaKcmbGm1kX+g5RNi4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=k2V9NdZtZNjCoC9PrGoxzepwYYH4Z8golHdXVOYwXwaAt5cvM3x+b9CDMnATpb96F
	 yy7LOWRJyWrr+Iv/Rj3zs4O7jgpsLaI6f5D3gC+96LXYW234EcI7gARae2Mp7jGhwQ
	 geCI/yQS8i5A35cKYIlOd8L7Imf2sIdCHpnG/GBVCq4fz27FdKFIZ9Wh+YRwkXWiBO
	 Q7Z1IW9l9qF1iw9kN4+7Jiw0ZqwArOcg62HI8A1t0MxwsXM0Dnm2dDqFeWz5YuWJiL
	 VHvFs4IkwOa4nUmhwa6IBibBixYeS7ii9Xsjw+BFZ8VqH5Spw4Ofv020NOo7HSIPZv
	 Be8Q6eP3J9MMQ==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4B96b88b9145487
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Dec 2024 14:37:08 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 9 Dec 2024 14:37:09 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 9 Dec 2024 14:37:08 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Mon, 9 Dec 2024 14:37:08 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: liujing <liujing@cmss.chinamobile.com>, kvalo <kvalo@kernel.org>,
        suhui
	<suhui@nfschina.com>
CC: linux-wireless <linux-wireless@vger.kernel.org>,
        linux-kernel
	<linux-kernel@vger.kernel.org>
Subject: RE: RE: [PATCH] rtlwifi: rtl8188ee: fix spelling error in _rtl88e_phy_set_rfpath_switch()
Thread-Topic: RE: [PATCH] rtlwifi: rtl8188ee: fix spelling error in
 _rtl88e_phy_set_rfpath_switch()
Thread-Index: AQHbSf4Bnwk1YuLp4kSNEDFg7w8YhbLddJvg
Date: Mon, 9 Dec 2024 06:37:08 +0000
Message-ID: <d6b9d0b67dd14032b458c6e568437a39@realtek.com>
References: <2024120913484116132252@cmss.chinamobile.com>
In-Reply-To: <2024120913484116132252@cmss.chinamobile.com>
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

DQpsaXVqaW5nIDxsaXVqaW5nQGNtc3MuY2hpbmFtb2JpbGUuY29tPiAgd3JvdGU6DQoNCj4gbm8g
ZHVwbGljYXRlIGlzIHNlbnQsIGJ1dCB0aGUgcGF0Y2ggb2YgdHdvIGZpbGVzIGlzIHN1Ym1pdHRl
ZC4NCj4gDQo+IE9uZTogZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydGx3aWZpL3J0bDgx
ODhlZS9waHkuYw0KPiBUd286wqBkcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0bHdpZmkv
cnRsODE5MmVlL3BoeS5jDQoNCkFzIEkgc2VlLCBib3RoIGFyZSBydGw4MTg4ZWU6DQoNCmh0dHBz
Oi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9saW51eC13aXJlbGVzcy9wYXRjaC8yMDI0
MTIwOTAzMjEzMy4yOTc0LTEtbGl1amluZ0BjbXNzLmNoaW5hbW9iaWxlLmNvbS8NCmh0dHBzOi8v
cGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9saW51eC13aXJlbGVzcy9wYXRjaC8yMDI0MTIw
OTAzMjU0OC4zMTAwLTEtbGl1amluZ0BjbXNzLmNoaW5hbW9iaWxlLmNvbS8NCg0KDQpBbHNvLCBw
bGVhc2Ugbm8gdG9wIHBvc3RpbmcgYW5kIGluIHBsYWluIHRleHQgbW9kZSBmb3IgbGludXgtd2ly
ZWxlc3MuDQpPdGhlcndpc2UsIG1lc3NhZ2VzIHdpbGwgYmUgaWdub3JlZCBieSBwYXRjaHdvcmsu
IA0KDQoNCg==

