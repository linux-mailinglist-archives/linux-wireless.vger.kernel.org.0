Return-Path: <linux-wireless+bounces-16575-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 936969F73EA
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2024 06:29:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7FC81639D2
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2024 05:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 138FA1FC7D0;
	Thu, 19 Dec 2024 05:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="D50BEy3X"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F697082B
	for <linux-wireless@vger.kernel.org>; Thu, 19 Dec 2024 05:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734586160; cv=none; b=rlLdnxLMiNYqXXHYbXPcjYB35s6gFGztfAdW5H9ECGeaybzdxKD3ekcbxguuqn6LWUBaSu9XP72qVmyTWpmHkxcwH63K8W71R6erHsvO2A9oIky91K7SEfbdXq2iFoOlYZPeF6kfAM9ohye4VjQXZfkNn09ZK7Xzk+aE+EfxoM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734586160; c=relaxed/simple;
	bh=jSDgZnLICpspC0OXJcaPRv2GER3DS9AOIMBts4Knihs=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CzROOVzyNFsaXpzLPTQVlPq3GaiB39gMvQuTPquMz+LCDck55YwR7qvAwXQw9uoF+DzQBfF8HPJMWgENUFVDlwMI7cTcnUH9vceRQbk70YM2W/uO0rggg9ttW57Cdaj13ku2nUuyVzGMpJ6NJPNF7Wn3AmVZCA+YLiccxAhh3Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=D50BEy3X; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4BJ5TCxcC3488346, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1734586152; bh=jSDgZnLICpspC0OXJcaPRv2GER3DS9AOIMBts4Knihs=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=D50BEy3Xjy6yytXDF3LEQWzq8UfnNcHvMuvGVw6MZRuQT3eI8oubmvhsofmM/tK3z
	 GSkaoZ6fK+2Vih7kb2JcbzzohhDbvElzadSc5W2xp3uh8omi19Ztv9WNPmqSPyhvtk
	 Xxr+fQy+63BTAaivm8qYh/c3DLfWJVTCK6+mnZi/MWPgd+Je0O5qAw6eIWesH+YXZM
	 sbsqqbDP2oJwHahsF2MQxoE3mOIMTS7iPNvidNThadAOzshEPkdwhmetnpefvG1ikC
	 8ALwQxrFYDgNT5F5ichs50MqP6mWMSTPUYa9o+pxjc605IRvmcrcfM30XX4teV5Ria
	 kZ+g4Xf1mCg1A==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4BJ5TCxcC3488346
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Dec 2024 13:29:12 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 19 Dec 2024 13:29:12 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 19 Dec 2024 13:29:11 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Thu, 19 Dec 2024 13:29:11 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH 1/2] wifi: rtw88: 8812a: Support RFE type 2
Thread-Topic: [PATCH 1/2] wifi: rtw88: 8812a: Support RFE type 2
Thread-Index: AQHbUOGrfTjHUAZOy0ahnfOkcycw3rLtDAZw
Date: Thu, 19 Dec 2024 05:29:11 +0000
Message-ID: <7a2105cffabc41a499be50df5442a40f@realtek.com>
References: <2917c7fc-6d88-4007-b6a6-9130bd1991e5@gmail.com>
In-Reply-To: <2917c7fc-6d88-4007-b6a6-9130bd1991e5@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBSRiBm
cm9udCBlbmQgdHlwZSAyIGV4aXN0cyBpbiB0aGUgd2lsZCBhbmQgY2FuIGJlIHRyZWF0ZWQgbGlr
ZSB0eXBlcw0KPiAwIGFuZCAxLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQml0dGVyYmx1ZSBTbWl0
aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQoNCkFja2VkLWJ5OiBQaW5nLUtlIFNoaWggPHBr
c2hpaEByZWFsdGVrLmNvbT4NCg0K

