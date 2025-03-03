Return-Path: <linux-wireless+bounces-19681-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A7FAA4B6EF
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Mar 2025 04:46:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2558B1890E72
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Mar 2025 03:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F461EB9ED;
	Mon,  3 Mar 2025 03:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="WmD3EkM3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5E81E51F2
	for <linux-wireless@vger.kernel.org>; Mon,  3 Mar 2025 03:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740973520; cv=none; b=sTHpMtFh2K5RFbLXL7aiRNqv4ZIzWX5NKu9DP8CPRjKyP8wWPTBoh4edUdDpW8wbQvnqUf5vv8XtFnyQNQV/k3OJMUXBvlvBN9KNCnlBjsiULHNjS6xzMFfxdK/WlpCeI0R2asZ1uZVpKDWLKOZUbUfxB+GVAFXlW8kKmXHZNmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740973520; c=relaxed/simple;
	bh=hsNoGYn6DnVzD2kOzGO+jaGHN0X0GRPZEAffquFozco=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mKQ5wZIpJIWcntGlDvzHb/nU+cxz3P9p+w/swynLt91S92LX48BhvM/5+qrmOEu0U8/Mc+BiuIb6+48jNBoqgtG2pOfPaIuWZXNxcZSB2sEACgIOE4/gHdvWd1JYUTNrhStHDgdhryVPFJyGv/pLvs/IqnFlcvEziYT6tZgSEkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=WmD3EkM3; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 5233jFEQ1556382, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1740973515; bh=hsNoGYn6DnVzD2kOzGO+jaGHN0X0GRPZEAffquFozco=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=WmD3EkM3TEeyBZ3IfY4FMA5E+SeClOXD5nEhFTEZTRzaVO3y10agOz/iFitmEPcMT
	 LX4ONlhbTk2IdBpunuBiudhlgJ4DpqWcsnQoOokc9mEJri/3kehcynBtjs2jSTa0D5
	 g28PQJNSdJU44qebBCo2/eKM4Lz7yVvTvnznWfAGJxyM8BMA1lzTsjIFwhhF23S6d6
	 Oq8bIJkRi70QyCJbj+S1ywP5CLCkl5RKzUzMXyMp8C0wElplZsVVR+TwyPwJxrNuWx
	 tnh6jUVoj6FYAea9XpbRK1ujr4ARujZ8RHwTlnDWtD9fjJ9Ab1hL1YQV+Z3Ms90ocN
	 wAEV8jr8OiApg==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 5233jFEQ1556382
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Mar 2025 11:45:15 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 3 Mar 2025 11:45:15 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 3 Mar 2025 11:45:15 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::f515:f604:42fb:a42b]) by
 RTEXMBS04.realtek.com.tw ([fe80::f515:f604:42fb:a42b%5]) with mapi id
 15.01.2507.035; Mon, 3 Mar 2025 11:45:15 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next 6/7] wifi: rtw88: Add rtw8814au.c
Thread-Topic: [PATCH rtw-next 6/7] wifi: rtw88: Add rtw8814au.c
Thread-Index: AQHbiLB5cogpr+SwpEi5ryLGP6+1nrNgy+QQ
Date: Mon, 3 Mar 2025 03:45:14 +0000
Message-ID: <c9ffb88b4a8e432fb21065bae1027111@realtek.com>
References: <8e9d900e-0721-425c-8466-bd57742c9f86@gmail.com>
 <dfd029db-fbaa-4fae-8bf8-0be679418a9a@gmail.com>
In-Reply-To: <dfd029db-fbaa-4fae-8bf8-0be679418a9a@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBUaGlz
IGlzIHRoZSBlbnRyeSBwb2ludCBmb3IgdGhlIG5ldyBtb2R1bGUgcnR3ODhfODgxNGF1Lg0KPiAN
Cj4gU2lnbmVkLW9mZi1ieTogQml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5j
b20+DQoNCkFja2VkLWJ5OiBQaW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT4NCg0KDQoN
Cg==

