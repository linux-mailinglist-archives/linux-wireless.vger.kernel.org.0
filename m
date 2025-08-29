Return-Path: <linux-wireless+bounces-26856-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2765BB3B32C
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Aug 2025 08:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E5771C80DD0
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Aug 2025 06:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E36D7404E;
	Fri, 29 Aug 2025 06:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="BeJBb78T"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A549238D49
	for <linux-wireless@vger.kernel.org>; Fri, 29 Aug 2025 06:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756448242; cv=none; b=DrvbbU2KSWFP0GrBG+Wt4t+YZBcxOmyEznzQH80s5r8obYbTnLbmBrBK60Ftn0yZIyzonYRSmocECvaxrKJ6Liv40QRIuSqSS8E0gEVxC1zKy+heo47atHdEivk3u4uJuvFH1unytb5MmUPQ+KDWwgOf/tu9VKGFQHQ7OS7f2Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756448242; c=relaxed/simple;
	bh=ZObh0wFMUYhaLFUBhanRMyVTY646s2ZVGe+xywI6HEA=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=H7puFUqjlsHIz0Zp8zgiE/dmxAse/QnvLGr1+wt98JCd/h5wgYdgfTz+FP9T9yB0v6xa20xHiQpCh/s8kOod4M8Fvmg3iip1W3pEzMpqfQLHUIjNx8NOkeJMksE2dzChd6IvGBfWMAZeJv0YTSP4BhjbJ/jqIaJaQbtm+qLLOMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=BeJBb78T; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 57T6HFUa83122087, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1756448235; bh=ZObh0wFMUYhaLFUBhanRMyVTY646s2ZVGe+xywI6HEA=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=BeJBb78TrTBEOaH8+BGyC6R8UI/pe1jlYz6g7QSFjR8sMFVFoP/3w7cFCvFeJmSuA
	 lCBJesgCfasxTfpN44PO0MVQ/85bktbRR2dlpkRxJewOK9BbzQZVTdSQfD9dcducM/
	 cOY/srfuLpPwuPrNb9CnYHYiu0qlf41VvW9lX2gi1xZLiU0ogr9N5K8/oSvN7DhLx/
	 MEqQWVUPXW8ccR3NBwbKpNQZpmhYWCx23jVzUGBrWxhoaJUEqfLFvk6hKQiLzhGJbK
	 UKgG7X3ujogu5ZE35btMm02iE48pU5I+u6A4Z2mVcyU/ubo5emD8FeKhfTtbBrwmPU
	 6Q3t8bQtMUpFg==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 57T6HFUa83122087
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Aug 2025 14:17:15 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Fri, 29 Aug 2025 14:17:16 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::c39a:c87d:b10b:d090]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::c39a:c87d:b10b:d090%10]) with mapi id
 15.02.1544.027; Fri, 29 Aug 2025 14:17:16 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next v3 04/11] wifi: rtw89: usb: Prepare rtw89_usb_ops_mac_post_init() for RTL8852CU
Thread-Topic: [PATCH rtw-next v3 04/11] wifi: rtw89: usb: Prepare
 rtw89_usb_ops_mac_post_init() for RTL8852CU
Thread-Index: AQHcF3Lbldu2KUn8PUqjXCaxLxuCnrR5KiZQ
Date: Fri, 29 Aug 2025 06:17:15 +0000
Message-ID: <69454c1943c74dbea777d7416bc5a491@realtek.com>
References: <fac0abab-2334-4ae2-9a80-f3fd7808e392@gmail.com>
 <1b5c6b0f-ca50-4ef4-ad3c-6ecf85adf86e@gmail.com>
In-Reply-To: <1b5c6b0f-ca50-4ef4-ad3c-6ecf85adf86e@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBUaGUg
cmVnaXN0ZXJzIHVzZWQgaW4gcnR3ODlfdXNiX29wc19tYWNfcG9zdF9pbml0KCkgYXJlIGxvY2F0
ZWQgYXQNCj4gZGlmZmVyZW50IG9mZnNldHMgaW4gUlRMODg1MkNVLCBzbyBtb3ZlIHRoZW0gdG8g
c3RydWN0IHJ0dzg5X3VzYl9pbmZvLA0KPiB3aGljaCBpcyBmaWxsZWQgaW4gZWFjaCBjaGlwJ3Mg
ZHJpdmVyLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNl
cmZlMkBnbWFpbC5jb20+DQoNCkFja2VkLWJ5OiBQaW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVr
LmNvbT4NCg0K

