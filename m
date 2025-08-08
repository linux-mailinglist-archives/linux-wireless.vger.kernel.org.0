Return-Path: <linux-wireless+bounces-26218-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C63B1E1ED
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Aug 2025 08:05:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19E5D166AF6
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Aug 2025 06:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 684E41E008B;
	Fri,  8 Aug 2025 06:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="T5o1G0AG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBF5367
	for <linux-wireless@vger.kernel.org>; Fri,  8 Aug 2025 06:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754633120; cv=none; b=hDcg/ZTjEieKovVvza73gZhkAFgD+xJgh5SyQGF9+Ezr8G7cKvFx5YK9zmFEoVLzJEP0ee893S8grRrZaxWI+6pOiN2KGv1C/BPuoajgC7KvVPJDDDKprxTrmmGgQamY05lgyvWXZREOhBF1982wfm0u9J1Q9AbmNLphoadY2V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754633120; c=relaxed/simple;
	bh=xBjdeGKN96NzYq3KLbGZr9Sg8b3FwAB+1pJ/nb2Y0Ho=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MTuCC9HqI51ReNtNxl0WXrTSt7gVkAvJjVc86q4oB8w/CDzFdY5aCbfnvVgPTwABppe3e7Xh+myL52gokOlTwe8oNsmbkzyMq31VF5c+7yrrlundzmuyNzp/ddM+s5YqUnO3D6/cNklQhu1RcIXzOaXU+gpmkZusgnnkAWsgjgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=T5o1G0AG; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 57865FhX42786449, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1754633115; bh=xBjdeGKN96NzYq3KLbGZr9Sg8b3FwAB+1pJ/nb2Y0Ho=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=T5o1G0AGs2+/J7ymoH62/b9L3DKAXGhkoq6VjxIaxya2EvcbSnZ4Yq6dQEVFDT3Iq
	 xfkclCD3fmqB3eRqoklqAxNgGR2A8Tf+ZdeyGsWj6JVkm4dV70xrZOrUzcH3191urw
	 JWkkHWO0mw7AtDuUS8XJy0x90BcKrAUwX0rVBt1tJ2DzwcPb8aoFG57R3+woOVxxKl
	 tq7QwY/1OaW5rc2cw0Mr6EVONB6FaUbhBfOvU+1p6L6DLoNlKgfSXk01fZ4KNxcNH8
	 oK0bS0l+JhvOIEucaG/9hg3/WNBFyV4/u10auUJDmBzrRBXuBJIzhW9y3e2c61Rf1l
	 2d3/hSbNY9VsA==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 57865FhX42786449
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 8 Aug 2025 14:05:15 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 8 Aug 2025 14:05:15 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::9617:3fd6:3830:25cc]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::9617:3fd6:3830:25cc%10]) with mapi id
 15.02.1544.011; Fri, 8 Aug 2025 14:05:15 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next v2 07/11] wifi: rtw89: Add rtw8852c_dle_mem_usb{2,3}
Thread-Topic: [PATCH rtw-next v2 07/11] wifi: rtw89: Add
 rtw8852c_dle_mem_usb{2,3}
Thread-Index: AQHcAye/QKQvyG5OBECd4g+CUMrejLRYTmbw
Date: Fri, 8 Aug 2025 06:05:15 +0000
Message-ID: <e327e14423354cc4b217e722a2745dab@realtek.com>
References: <f4a7a1c4-3d64-4af3-bc77-b12d7c1320e7@gmail.com>
 <4781c181-cc13-413c-b9b6-287d57643d86@gmail.com>
In-Reply-To: <4781c181-cc13-413c-b9b6-287d57643d86@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBBZGQg
cnR3ODg1MmNfZGxlX21lbV91c2IyIGFuZCBydHc4ODUyY19kbGVfbWVtX3VzYjMgYW5kIHRoZWly
IHZhcmlvdXMNCj4gcXVvdGFzIGFuZCBzaXplcyBpbiBzdHJ1Y3QgcnR3ODlfbWFjX3NpemVfc2V0
Lg0KPiANCj4gImRsZSIgY291bGQgYmUgIkRhdGEgTGluayBFbmdpbmUiIG9yICJEb3VibGUgTGlu
ayBFbmdpbmUiLiBUaGVzZSBhcmUNCj4gc29tZSBwYXJhbWV0ZXJzIG5lZWRlZCBmb3IgUlRMODg1
MkNVLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZl
MkBnbWFpbC5jb20+DQoNCkFja2VkLWJ5OiBQaW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNv
bT4NCg0KDQo=

