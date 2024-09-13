Return-Path: <linux-wireless+bounces-12820-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE3997765B
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Sep 2024 03:21:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D989B21A17
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Sep 2024 01:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 289633D6B;
	Fri, 13 Sep 2024 01:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="LWi9plxG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99831FA5;
	Fri, 13 Sep 2024 01:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726190463; cv=none; b=HwbopeMdQS/EnK4uv6wRw+7aKRW8whHNm6dXWwJoenaUEXBajwypz4nlTN6j+guDyfp0qRYwaljwrMsIqE9K9q4ZA4ZA165pWml33MJFasytmJyBjpsAMopfAlAd5JDanyRUq5A3NCkX8h0IE6V56RpVL6aKitMWgjY7jA+8xw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726190463; c=relaxed/simple;
	bh=yi8Fzl1i9+PpIayISuMGypW4nou4TzFzAOOdTRRgHKA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JGmuDauVAkcRYn3Mue+pd2CugVy+UthqaPdWxwlV1n6uwJWXfG22uJm852hk4gswEHrVE8uchb5yI/0soxbfBRPbPKQKvk4L4rgRwRt1J4H+q9y13YYiNc/T94fSlTHf0oBPEp4ZJw1LEfTFgXyE6JFS66OkzdZHFUf/rw6T9NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=LWi9plxG; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 48D1KkqK62078355, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1726190446; bh=yi8Fzl1i9+PpIayISuMGypW4nou4TzFzAOOdTRRgHKA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=LWi9plxGemzbyTJXxQlYHEW4SoAkNMl0ED0UlljpugELLwKj6tauOrYUmlpSbQj9d
	 8eI3kIAnXxNU4F1gYpK+3wvXO7ppMHd4mfV9ObwVxeKDrLcMxDVT6v39B4hB9LG+dd
	 igrW9dtsypA/H1YOQ+lgCBxiOn7q1dYdrOs+qAIeqzR6sOgFgvSquabO3k+ph/NsAJ
	 rUf1YR7Ww7E8+phWreOvlyCNRUm2TfjRQQJwy41/LPXEFIVgcdvO10yZmQvfZt87JJ
	 JJAQyVq1MGynwLhgO2H8iH8M4OkaFkiTHrQQQKA7HrGq7/9oR1+hvWZX36uVkMKQ2e
	 swp1vcTLM+4LQ==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.05/5.92) with ESMTPS id 48D1KkqK62078355
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Sep 2024 09:20:46 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 13 Sep 2024 09:20:45 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 13 Sep 2024 09:20:45 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Fri, 13 Sep 2024 09:20:45 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Colin Ian King <colin.i.king@gmail.com>, Kalle Valo <kvalo@kernel.org>,
        Dmitry Antipov <dmantipov@yandex.ru>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
CC: "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH][next] wifi: rtlwifi: make read-only arrays static const
Thread-Topic: [PATCH][next] wifi: rtlwifi: make read-only arrays static const
Thread-Index: AQHbBRsuUlJ76Z1Mb0GnQxRPAMYupbJU6//g
Date: Fri, 13 Sep 2024 01:20:45 +0000
Message-ID: <05085e265b174d6482b108f6378921b9@realtek.com>
References: <20240912135335.590464-1-colin.i.king@gmail.com>
In-Reply-To: <20240912135335.590464-1-colin.i.king@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS02.realtek.com.tw, 9
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

Q29saW4gSWFuIEtpbmcgPGNvbGluLmkua2luZ0BnbWFpbC5jb20+IHdyb3RlOg0KPiBEb24ndCBw
b3B1bGF0ZSB0aGUgcmVhZC1vbmx5IGFycmF5cyBwYXJhbXMsIHRvc2hpYmFfc21pZDEsIHRvc2hp
YmFfc21pZDIsDQo+IHNhbXN1bmdfc21pZCBhbmQgbGVub3ZvX3NtaWQgb24gdGhlIHN0YWNrIGF0
IHJ1biB0aW1lLCBpbnN0ZWFkIG1ha2UgdGhlbQ0KPiBzdGF0aWMgY29uc3QuDQo+IA0KPiBTaWdu
ZWQtb2ZmLWJ5OiBDb2xpbiBJYW4gS2luZyA8Y29saW4uaS5raW5nQGdtYWlsLmNvbT4NCg0KQWNr
ZWQtYnk6IFBpbmctS2UgU2hpaCA8cGtzaGloQHJlYWx0ZWsuY29tPg0KDQoNCg==

