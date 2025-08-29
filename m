Return-Path: <linux-wireless+bounces-26852-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 499ADB3B2FD
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Aug 2025 08:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09D343B614E
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Aug 2025 06:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD6021CFFA;
	Fri, 29 Aug 2025 06:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="pCG8/eLm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA81F8BEC
	for <linux-wireless@vger.kernel.org>; Fri, 29 Aug 2025 06:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756447707; cv=none; b=JA813/V9W+hX3eNTc02wRV0qfpJsiks53SVlmb14qPleXwv/p/DSsTC1biWD/+m1B0/dV7EtIN09hSEK313f1mEmOaBfwnfxTPK7/syG2P006DxBEEF7CllwdftY6kuDlcBRSyTfYmdEdqMFk2sckwcSY4sb+LMtpae1/TJHi7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756447707; c=relaxed/simple;
	bh=U3f6Z612eICOl+xpzU7GOQZGzTNpEnqxa0wDjVXMbGA=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Dez8pm7/J0Z9MjjTlN2pKV8HKLG/cL6l1vogfw1/zEjmTERgY+fCEgrYvSggTIP7bfaLcXffkpt0/MgOIcp9usd8KdukLbQk87u5yVxCqfOasRGTzSf4rEY7isUzbgw0z2NywKrqMyIcVngjootqeykXfSUp986/R2aqjlBPfOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=pCG8/eLm; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 57T68FMS03099184, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1756447696; bh=U3f6Z612eICOl+xpzU7GOQZGzTNpEnqxa0wDjVXMbGA=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=pCG8/eLm+ck77YdcoZbw7yoHfoMIYJuqeFr0+gikJTcsz/O+tHTyCu4+PzriaJmS+
	 6lvt363PvG4hkZgJkLc7l+ZKAc3mPj0op/uTVupuYAS5pY96VrZHMNFsgjBqLgMecB
	 daEfExFcOfGLnjs4yqGdNTg09BFbh4j+a74pf1RfN/ciY3/NcE3rZSGBB6S+juKowK
	 /su249vSDv4fJU69YuHssAACIFG7gcSAQNk2a/NVF3JBwe8y39tPNkO9FeWzGiL55g
	 HEWGgA2i/AptmzroC4jzUp94hYEo5iA5Ry8LzzE+xbeiTM7Oov9DkiWP38g2UF/6dw
	 uasR3uJ0HSlSg==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 57T68FMS03099184
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Aug 2025 14:08:15 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Fri, 29 Aug 2025 14:08:16 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::c39a:c87d:b10b:d090]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::c39a:c87d:b10b:d090%10]) with mapi id
 15.02.1544.027; Fri, 29 Aug 2025 14:08:16 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next v3 01/11] wifi: rtw89: Add rtw89_core_get_ch_dma_v2()
Thread-Topic: [PATCH rtw-next v3 01/11] wifi: rtw89: Add
 rtw89_core_get_ch_dma_v2()
Thread-Index: AQHcF3J7yDBgjIahBUGDCiiy1ZwV0bR5J54g
Date: Fri, 29 Aug 2025 06:08:15 +0000
Message-ID: <6d76bf9d5ac341dd8a1a433aaba6cd19@realtek.com>
References: <fac0abab-2334-4ae2-9a80-f3fd7808e392@gmail.com>
 <321a9d86-4327-418e-89f1-eb8fb242cc13@gmail.com>
In-Reply-To: <321a9d86-4327-418e-89f1-eb8fb242cc13@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBSVEw4
ODUyQ1UsIFJUTDg4NTJBVSwgYW5kIFJUTDg5MjJBVSBuZWVkIGEgZGlmZmVyZW50IG1hcHBpbmcg
b2YgVFgNCj4gcXVldWUgdG8gRE1BIGNoYW5uZWwgY29tcGFyZWQgdG8gdGhlaXIgUENJIHZlcnNp
b25zLCBzbyBtYWtlDQo+IGdldF9jaF9kbWEgaW4gc3RydWN0IHJ0dzg5X2NoaXBfb3BzIGFuIGFy
cmF5IGFuZCBhZGQNCj4gcnR3ODlfY29yZV9nZXRfY2hfZG1hX3YyKCkuDQo+IA0KPiBTaWduZWQt
b2ZmLWJ5OiBCaXR0ZXJibHVlIFNtaXRoIDxydGw4ODIxY2VyZmUyQGdtYWlsLmNvbT4NCg0KQWNr
ZWQtYnk6IFBpbmctS2UgU2hpaCA8cGtzaGloQHJlYWx0ZWsuY29tPg0KDQoNCg==

