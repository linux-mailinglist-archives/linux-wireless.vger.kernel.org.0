Return-Path: <linux-wireless+bounces-22884-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5343AB49D7
	for <lists+linux-wireless@lfdr.de>; Tue, 13 May 2025 05:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C5DC16EF9E
	for <lists+linux-wireless@lfdr.de>; Tue, 13 May 2025 03:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98EDD17A2FC;
	Tue, 13 May 2025 03:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="SslmS5sT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01142BCF5
	for <linux-wireless@vger.kernel.org>; Tue, 13 May 2025 03:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747105448; cv=none; b=rkDoGSDQcLT+v3tVlJTqlNG01+bky7ws8n50ACOi7FTSVliXKD2WDbRGWHevlECw1deRPa1CthdBx5L/BXIHeeCSo4KzLn9oqv1Axem24lZXKC5J2c8WVir1VrFzFcMVC74BX0BzAwdQJ0m9fZGyjuwVyb+A0ZK2nEMVhiUX9cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747105448; c=relaxed/simple;
	bh=2f7U6IK2AP+zDDfFVq9Kp6+zOgBPBWdkawcE83365v4=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Owcm224oRE12XGLU5BJbpczq+CYoQ0mOxyxnyMcWGmO0SgfSTLXgjCwE/V4ydGr/ECiCAPytv5KlhEyAh18m+tLOwj3pla8gt9tQ9mm4DpFWWRZ353uiFZXKcOE+sEC0XDwfN8jcP2W8zis/Lp0jDIup+IwYB7xPswMeP73yd/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=SslmS5sT; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 54D341E103566853, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1747105442; bh=2f7U6IK2AP+zDDfFVq9Kp6+zOgBPBWdkawcE83365v4=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=SslmS5sTifc2oX9JJ67TxnlVAsV0xpc7X7nEt2lYucoyVZRrEAE4C0eWabxqyapUR
	 BoRt4QMII0HH4ByoY18PPGfSQyAzO+wgZdSt7vZ/LwHdriAd3zvF1lZmkYHTUGF43A
	 EgDcm+PN1D96khvZaJQ/OXhiT9p8ePAPtmGL39ZyMQDJGXOcySh59/dGbJkdc724tY
	 /ihtapWOH92xaLs6jo7Cwn+hIxtCmrCSxkI4LLB3GasC68GW7/x8KNCp9KNExjSJJM
	 hP1SfyD6tKust+Oh29WpXKJ/qOZQf5L7Bz5lXXjOQAX+hQw6cxMm2lCudJKjvFb+n7
	 dSRlDcw+dJY5Q==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 54D341E103566853
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 May 2025 11:04:02 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 13 May 2025 11:04:01 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 13 May 2025 11:04:00 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Tue, 13 May 2025 11:04:00 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next v1 03/13] wifi: rtw89: Rename hfc_param_ini to hfc_param_ini_pcie
Thread-Topic: [PATCH rtw-next v1 03/13] wifi: rtw89: Rename hfc_param_ini to
 hfc_param_ini_pcie
Thread-Index: AQHbvTYcsBdwObnxiUeDTuxSv+Ol/LPP7NAA
Date: Tue, 13 May 2025 03:04:00 +0000
Message-ID: <2b77a995e6af415b89d85bc83e506e4a@realtek.com>
References: <b146b670-d91c-41a7-96f0-c37945040aea@gmail.com>
 <26968663-f928-4479-bfbc-8e9e3195f27a@gmail.com>
In-Reply-To: <26968663-f928-4479-bfbc-8e9e3195f27a@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBSZW5h
bWUgaGZjX3BhcmFtX2luaSBpbiBzdHJ1Y3QgcnR3ODlfY2hpcF9pbmZvIHRvIGhmY19wYXJhbV9p
bmlfcGNpZS4NCj4gVVNCIGFuZCBTRElPIHdpbGwgbmVlZCBkaWZmZXJlbnQgc2V0cyBvZiB2YWx1
ZXMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBCaXR0ZXJibHVlIFNtaXRoIDxydGw4ODIxY2VyZmUy
QGdtYWlsLmNvbT4NCg0KQWNrZWQtYnk6IFBpbmctS2UgU2hpaCA8cGtzaGloQHJlYWx0ZWsuY29t
Pg0KDQo=

