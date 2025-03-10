Return-Path: <linux-wireless+bounces-20103-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11CCAA58E07
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Mar 2025 09:23:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB8CE188DB8A
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Mar 2025 08:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F03522331F;
	Mon, 10 Mar 2025 08:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="GGW3DSMS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2186F2153D6
	for <linux-wireless@vger.kernel.org>; Mon, 10 Mar 2025 08:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741594980; cv=none; b=avjHPMhDQ/YK3/txIrzzW/iLyDpwgksmmhRUVbB0HtJBCvjqn0dmfc9x/UaT4RCuXZBSrITUL5mjNvpDGlJVBnvjEQY2Vvz7XbrDQHtPNijvowMYIwZyugi5C5+B1texoBlVUEWs3BzGDseU7NtQ8x4sk1bFvSmUWWgsICSjqq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741594980; c=relaxed/simple;
	bh=f0Pw/3wUzMKnLMklJqIEXf3EJ0cOch1m/emRIkicMSo=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=teJ7b43+3Oz3Bc+E9i4mzUDy+4JOEHWYHnFFXdkY4KKFGkj91WUOcmzG4t8624AR8pjzRkTcTAJ8wdcH/cHXV+dF9NQ49kTQFjraRy5yeVDsPNHXnhFm3Vekzq7lfpFyZbr5EZfIP4VwSwMtKtn8bB+n29KhRu+Xm2lD/3l4Fi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=GGW3DSMS; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 52A8Ms8922804905, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1741594974; bh=f0Pw/3wUzMKnLMklJqIEXf3EJ0cOch1m/emRIkicMSo=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=GGW3DSMSidXC6HWzv/kkR4e+RcADL+qw8tcmChlw8mxpJlXc45B74aYNdTd3tVC1i
	 0TF2bCd51O0ZYPbhO22/TPMg0Xoj2Ffu5OMh+V1VblnUNdBByKHlyu9UnVyRTKwal9
	 ZeFmSbdH/0OCO1OtJGZpZX+IywB57sBLCRZs+6aEMOR9pGco6fAzUk6a2SDyToZySn
	 zZ3xDU1uHh24/YZEE825mvEflfVeB3xNIoadMyFQy9keUEz7k6mS9RvcTmXOVci37B
	 CH0Ml/0OapVLF0IuNqYdU7vZc+vqpYnX7L1s2BFLPAewj4JIXwlFKtw7Qxm7P360p5
	 uV6T1FseRVErQ==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 52A8Ms8922804905
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Mar 2025 16:22:54 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 10 Mar 2025 16:22:54 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 10 Mar 2025 16:22:54 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Mon, 10 Mar 2025 16:22:54 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next v2 4/7] wifi: rtw88: Add rtw8814a.{c,h}
Thread-Topic: [PATCH rtw-next v2 4/7] wifi: rtw88: Add rtw8814a.{c,h}
Thread-Index: AQHbjvdWq7uOkZhD/EOqyUgCih2ET7NsDSUw
Date: Mon, 10 Mar 2025 08:22:54 +0000
Message-ID: <8a683cf2846443d681fac8ecad9420d9@realtek.com>
References: <d25331f4-653d-4ab1-b3dd-0ec1a73209e0@gmail.com>
 <5d3b8c03-63c1-4f20-860a-89d424badad8@gmail.com>
In-Reply-To: <5d3b8c03-63c1-4f20-860a-89d424badad8@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBUaGVz
ZSBjb250YWluIGFsbCB0aGUgbG9naWMgZm9yIHRoZSBSVEw4ODE0QSBjaGlwLg0KPiANCj4gU2ln
bmVkLW9mZi1ieTogQml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQoN
CkFja2VkLWJ5OiBQaW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT4NCg0KDQo=

