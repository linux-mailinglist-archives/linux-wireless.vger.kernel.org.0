Return-Path: <linux-wireless+bounces-10665-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE27494086F
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jul 2024 08:33:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEBC3284851
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jul 2024 06:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A90C215FA6A;
	Tue, 30 Jul 2024 06:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="wMJRfZIa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3547FBAC
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jul 2024 06:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722321203; cv=none; b=sInYwCK7qb/G9qVlWMF/hqhvRI/8Fx0SCwET7XNWQQctSXISe6o5/MzvhsusZxCph2BHSl2ZqWOM3hB19m7BYrkCCaF3C298oW9Qelwx1BDAuuMdaUm3WHVDEvQuYUiYWHH3p96QDANHEmGH0/T0DqVrbY7b38U4z8yqsYMf+lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722321203; c=relaxed/simple;
	bh=t5Vz+gPWYLuJlNvjp/qcSmsc2En0OgyXjpWRyl/mgS0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dqipxdlsIzHzE7OfWDbZhW0cUQ4e1hzANKOWYTmlwRt1kldmOk6XBhDjHJhVVEtkpKDy/8Q18GwUbZHmn9nKcdZpIWlp+sSwS/KCH/OPUIi5AyWE8Kkk9nsVk4La0nix7Px9yxLVtfLUROirx7x9CywXBKz6I7HpV081E76BO1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=wMJRfZIa; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 46U6XAojC773908, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1722321190; bh=t5Vz+gPWYLuJlNvjp/qcSmsc2En0OgyXjpWRyl/mgS0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=wMJRfZIaauZlU0lW5aJUQGYspyY9kPDkSJbZpGSN+51CzZx4EkBQy5V2ItROU2FOS
	 LROA5/ISEbo9XBHkGhdYwRTec/3fjmrb1xYf/yNgQqlWliHO8bQC7dY/VaGbL5Nw3+
	 VONjpi1qMOOZ0y5AJ9dIs54vnFSKKOd7bBjrlZNqxOBH/mKwX89tvcOUI/je+u4xRk
	 y/X94CDYwGBqH6tM7FgCWFSgwoyojzHu5gFySUOs2Fhe0WnF+epzkOkrNx9omyPmF1
	 XWUwTh4NPbAG072s4VCCLr6yZ9ne1u6am33+D57oKROwIATU8BkmiHiJ4TjO7P9Wm0
	 wtOIcugLm9mgg==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 46U6XAojC773908
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jul 2024 14:33:10 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 30 Jul 2024 14:33:10 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 30 Jul 2024 14:33:10 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Tue, 30 Jul 2024 14:33:10 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Sascha Hauer <sha@pengutronix.de>,
        Martin Blumenstingl
	<martin.blumenstingl@googlemail.com>
Subject: RE: [PATCH 2/2] wifi: rtw88: Avoid using macid 0 in AP mode
Thread-Topic: [PATCH 2/2] wifi: rtw88: Avoid using macid 0 in AP mode
Thread-Index: AQHa4UC4lZ9xsp59ME2YErnRO2fzALIO0JLQ
Date: Tue, 30 Jul 2024 06:33:10 +0000
Message-ID: <9356af89520243ccacc0be72b8b03252@realtek.com>
References: <9174a776-4771-4351-85fa-476e240d8ace@gmail.com>
 <e4be0a75-43b2-4ae5-9aab-5c4a88e78097@gmail.com>
In-Reply-To: <e4be0a75-43b2-4ae5-9aab-5c4a88e78097@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiANCj4g
SW4gQVAgbW9kZSwgdGhlIGZpcm13YXJlIHN0b3BzIHRyYW5zbWl0dGluZyBiZWFjb25zIGlmIGl0
IHJlY2VpdmVzDQo+IEgyQ19DTURfUkFfSU5GTyBmb3IgbWFjaWQgMC4NCj4gDQo+IExlYXZlIG1h
Y2lkIDAgdW51c2VkIGluIEFQIG1vZGUuIE1hY2lkIDEgaXMgYWxyZWFkeSByZXNlcnZlZCBmb3IN
Cj4gYnJvYWRjYXN0L211bHRpY2FzdC4gQXNzaWduIG1hY2lkIDIgdG8gdGhlIGZpcnN0IGNvbm5l
Y3RlZCBjbGllbnQuDQoNClNlZW1pbmdseSB3ZSBtaXNzZWQgdG8gc2V0IG1hY19pZCBpbiBUWCBk
ZXNjIGZvciBhIGxvbmcgdGltZS4NCg0KKyNkZWZpbmUgUlRXX1RYX0RFU0NfVzFfTUFDSUQgR0VO
TUFTSyg3LCAwKQ0KICNkZWZpbmUgUlRXX1RYX0RFU0NfVzFfUVNFTCBHRU5NQVNLKDEyLCA4KQ0K
ICNkZWZpbmUgUlRXX1RYX0RFU0NfVzFfUkFURV9JRCBHRU5NQVNLKDIwLCAxNikNCg0KVGhlIG1h
Y19pZCBzaG91bGQgYmUgZnJvbSBydHd2aWYtPm1hY19pZCBvciBzaS0+bWFjX2lkIGFjY29yZGlu
ZyB0bw0Kb3BlcmF0aW5nIG1vZGUgYW5kIHJvbGUuDQoNCkFuZCBJIHN1cHBvc2UgbWFjX2lkIGFz
c2lnbm1lbnQgZm9yIEFQIGlzIG1hY19pZCAwIGZvciBicm9hZGNhc3QvbXVsdGljYXN0LCBhbmQN
Cm90aGVyIG1hY19pZCBjYW4gYmUgdXNlZCBieSBjb25uZWN0ZWQgc3RhdGlvbnMgcmVndWxhcmx5
LiANCg0K

