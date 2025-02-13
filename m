Return-Path: <linux-wireless+bounces-18900-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67386A3391A
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2025 08:44:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09B99188629B
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2025 07:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F3220A5E5;
	Thu, 13 Feb 2025 07:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="QQtnQ6ya"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2FD2AD21
	for <linux-wireless@vger.kernel.org>; Thu, 13 Feb 2025 07:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739432690; cv=none; b=spne8JcgfR+MEaDAId6yPQuXH3x7zhPVZozFu13YUtMCk9jsPRrImjgQkjYQjYTGGCWy/as57nanhp/RKtrPMuOrBzj4mGWzcdA+SEpIjQ2Fxk9e+fCyJzWVWY8awjJPMj7LFUk9eB+t+pv49CAUZOXJ7kevwDi2dv+8g3z2fRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739432690; c=relaxed/simple;
	bh=PQM+qZVENOhvOixMUicjVVQ5ilVur3jpiSetZrI0Ib8=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AW9Mc+jzpBDQPBFEnmOdSvmtrjz6p+8SvNn7q1JkJpvGtNfFvTVquKDvwikBs5rCsJWyfMJKqrfSkDzDMQUaHiUirKWoHykpAieboBvn4ZWXFjIr8LnWr2mxEMDdaJv3E65UZnTLuQTRMozFDKR+Mi0ZPJwpDXwStjb3/4vDL2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=QQtnQ6ya; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 51D7ijZvB594881, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1739432685; bh=PQM+qZVENOhvOixMUicjVVQ5ilVur3jpiSetZrI0Ib8=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=QQtnQ6yaWevG3Dsk1nZq6RtaNbY8PSY4uIAshtVhq6mivX7zVpPMxEXtm7J9qGTsr
	 vjPJZosFa/Hl3nYujf3x93S7L43xzxZFvi2rBqwZoVgBz3U09uYuXwSwFA7bfPu1zT
	 xH7t10azUP9nm1V5hTBVhCQGpH5xKgNbNfrhEQTtDLrMboB7RvG0aS8X8Osxq9vwfn
	 WuRpXvfO0r5tuqR7nC0UfTFqJI4xqeWCDe9kFW+J++Z90zy11NegdKuMZmZyfhZQiB
	 3a01wFeCX+aC6deAItuBSXZWvLloPoCR5bJTXskqbYWTjDu64fuFXoGbbFduu4gou+
	 n40ct6EiAw5aQ==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 51D7ijZvB594881
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Feb 2025 15:44:45 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 13 Feb 2025 15:44:45 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 13 Feb 2025 15:44:44 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::48ab:b54f:96a1:6553]) by
 RTEXMBS04.realtek.com.tw ([fe80::48ab:b54f:96a1:6553%5]) with mapi id
 15.01.2507.035; Thu, 13 Feb 2025 15:44:44 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH 6/8] wifi: rtw88: Extend rtw_phy_config_swing_table() for RTL8814AU
Thread-Topic: [PATCH 6/8] wifi: rtw88: Extend rtw_phy_config_swing_table() for
 RTL8814AU
Thread-Index: AQHbfNPMKwNdWW+ba0OcBivIUMg9BrNE3I4w
Date: Thu, 13 Feb 2025 07:44:44 +0000
Message-ID: <ba29efcecb8946b4ac2f91b6a8034fcb@realtek.com>
References: <21111380-5db6-4a72-ace9-f18b5bcd525c@gmail.com>
 <6d04c43c-1d40-46ec-a569-1b19a2aaa59c@gmail.com>
In-Reply-To: <6d04c43c-1d40-46ec-a569-1b19a2aaa59c@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBTZWxl
Y3QgdGhlIFRYIHBvd2VyIHRyYWNraW5nIHRhYmxlcyBmb3IgUkYgcGF0aHMgQyBhbmQgRCBhcyB3
ZWxsLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZl
MkBnbWFpbC5jb20+DQoNCkFja2VkLWJ5OiBQaW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNv
bT4NCg0KDQo=

