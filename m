Return-Path: <linux-wireless+bounces-9033-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2AF290A1DC
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2024 03:41:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A82A61C2103A
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2024 01:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C70C650285;
	Mon, 17 Jun 2024 01:41:03 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8871E210F8
	for <linux-wireless@vger.kernel.org>; Mon, 17 Jun 2024 01:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718588463; cv=none; b=cvtcUA2L4ruuGDCJKXdtL2PHpjdN3wFVAfhQ/JlVZi8kYtEBZpqcoJ1NDkiXkYau6EB3WgJ5I3gyWr56eJySOBc3bGyotsj+WjSIMElWDmB+HlSJCPvj0Iwyef1QAKyK9bkxIOYsY8+DpDRb9JqOtF1/Ji1hDbEI+rWf/ubuJkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718588463; c=relaxed/simple;
	bh=+YPb34zs1Xs+e3yee/gbyFYH3e57YGjxmmj9Ca+h6RM=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WptBILQS15WMrTL36uX1gCCsmSWVOIAd+rYz477tWtxiKRLHeJfVQWnMXW7ymdlEME0SwPL/ji+hQUGpb61M7SFZv5cxlP5Fd5wDDDb78MBmIX0+EULCiFEhhiSDhfSA0LrtH8LB3qJsr8JdB4nFgm01IsbhT+leE6tPvNbK9pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 45H1ewStB2517027, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 45H1ewStB2517027
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Jun 2024 09:40:58 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 17 Jun 2024 09:40:58 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 17 Jun 2024 09:40:57 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Mon, 17 Jun 2024 09:40:57 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: =?utf-8?B?TWFyY2luIMWabHVzYXJ6?= <marcin.slusarz@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH v2 1/2] wifi: rtw88: 8821cu: keep power on always for 8821CU
Thread-Topic: [PATCH v2 1/2] wifi: rtw88: 8821cu: keep power on always for
 8821CU
Thread-Index: AQHavlRVKP+0aQesnEeLhSKNM3JtzLHLLr+Q
Date: Mon, 17 Jun 2024 01:40:57 +0000
Message-ID: <13d9db6015e84083b2cb56c4caf0c7e0@realtek.com>
References: <CA+GA0_tK_+Rsj0FAxO-_VXBLLFMoxW9FHsWhL6gEoWaOMKwWrA@mail.gmail.com>
 <20240614121339.525935-1-mslusarz@renau.com>
In-Reply-To: <20240614121339.525935-1-mslusarz@renau.com>
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

TWFyY2luIMWabHVzYXJ6IDxtYXJjaW4uc2x1c2FyekBnbWFpbC5jb20+IHdyb3RlOiANCj4gRnJv
bTogUGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+DQo+IA0KPiBUaGlzIGNoaXAgZmFp
bHMgdG8gcmVsaWFibHkgd2FrZSB1cCBmcm9tIHBvd2VyIG9mZi4NCg0KInNvIGtlZXAgcG93ZXIg
b24gLi4uLiIgKG1vcmUgZGVzY3JpcHRpb24pDQoNCj4gDQo+IENoYW5nZS1JZDogSTI5NWRlM2M3
MWZlOTFhZjM3ZThjYzM5YjcwNzI4YThiYTdlOTRiMmYNCg0KTm8gY2hhbmdlLUlELiBQbGVhc2Ug
cnVuIGNoZWNrcGF0Y2gucGwgYmVmb3JlIHNlbmRpbmcuIA0KDQo+IFJlcG9ydGVkLWJ5OiBNYXJj
aW4gxZpsdXNhcnogPG1hcmNpbi5zbHVzYXJ6QGdtYWlsLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTog
UGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+DQoNCkkgdGhpbmsgeW91IGNhbiBlZGl0
IHRoaXMgcGF0Y2ggYXMgd2hhdCB5b3Ugd2FudC4gVGhlbiBJIGNhbiBiZWNvbWUgdGhlDQpDby1k
ZXZlbG9wZXIgKHVzZSBDby1kZXZlbG9wZWQtYnkpLiANCg0KDQo=

