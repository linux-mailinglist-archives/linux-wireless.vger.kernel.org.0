Return-Path: <linux-wireless+bounces-30714-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C554D15FDB
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jan 2026 01:30:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2004F300A7A3
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jan 2026 00:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 767CA23A98D;
	Tue, 13 Jan 2026 00:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="BpctUgB7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B4323BD02
	for <linux-wireless@vger.kernel.org>; Tue, 13 Jan 2026 00:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768264210; cv=none; b=Qq1dhkp8OK3G8+m1Us0ZV388y/o9FUW0GlTz4QjqwwWt0MA8Wtsoy3fuMzcmEb67seSrqRsAXSVVRtizzEZZ174M0jMhc/wnBsKe4tRXCobVl6P306idVcWmSSQwpN83Z2pPqrJRkQ/Jjb7cd9Ev5ZKsCdibyXZgBiHIocWAYJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768264210; c=relaxed/simple;
	bh=Ji6MKDZ6JJYgWK+1wVGAl++O3WbkZ+BKeNOA7eFfwzE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=s1hIDafy4lOktOcVOIOO8irs4zwLM9AL/1F/SoB+H99vePqzOfGBWEs9s3dFMOfDVTvgDu4HDPTWNViiiv+nn3ZpnEtRg1uzByF9vVuPlunl9ecVJKFEWYLPNs6XnAm/2qmJgwunUPWS1Q+dSfXQgp0Nf5DU0CsIOGpLz0v7UoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=BpctUgB7; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 60D0TrmaE1914481, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1768264193; bh=Ji6MKDZ6JJYgWK+1wVGAl++O3WbkZ+BKeNOA7eFfwzE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=BpctUgB7nrH7ONwmKmQQ5c1e9JlMDnaYz2xQx6iY4ahlfP1DERlRlzYkOP4sLI4Fv
	 uhQP0oOZ6x81yVKaaXNxV/xopLNmff+HJHZAIus7Y50bDlFWkK7nP2MdNLJ+VjY21S
	 n8Kn/UPpqTBF/yLY3OAAQtrv0KfMVyZdN7iB4g0sW/0YNi4XdOABcgbGtqcVYdvMBE
	 TfvpHA3YF9CIU9K/Fp9vVh0EW9dX3Dw0SM4hHwSRC4cs26zlvz+De2lZqMMqLXTonI
	 gLp2iPStKhFUzCxP0sW16NQq1+BQJq3qQAQ2GvruTjMLMKRXnKwmgVHsixidC+It7L
	 gGTOLiFnUT4Dg==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 60D0TrmaE1914481
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Jan 2026 08:29:53 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 13 Jan 2026 08:29:54 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913%10]) with mapi id
 15.02.1748.010; Tue, 13 Jan 2026 08:29:54 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <u.kleine-koenig@baylibre.com>,
        Johannes Berg <johannes@sipsolutions.net>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH v2 3/3] wifi: rtw88: sdio: Migrate to use sdio specific
 shutdown function
Thread-Topic: [PATCH v2 3/3] wifi: rtw88: sdio: Migrate to use sdio specific
 shutdown function
Thread-Index: AQHcg9q8qCyvKUv0nUuCRiC+nd3QRLVPP6GQ
Date: Tue, 13 Jan 2026 00:29:54 +0000
Message-ID: <fbc90f708e02443f9968131bdc91c5cb@realtek.com>
References: <cover.1768232321.git.u.kleine-koenig@baylibre.com>
 <5a328658c20613068bbbfabd3d0e721b69b3d474.1768232321.git.u.kleine-koenig@baylibre.com>
In-Reply-To: <5a328658c20613068bbbfabd3d0e721b69b3d474.1768232321.git.u.kleine-koenig@baylibre.com>
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

VXdlIEtsZWluZS1Lw7ZuaWcgPHUua2xlaW5lLWtvZW5pZ0BiYXlsaWJyZS5jb20+IHdyb3RlOg0K
PiBUaGlzIHNhdmVzIGEgY2FzdCBpbiB0aGUgZHJpdmVyLiBUaGUgbW90aXZhdGlvbiBpcyBzdG9w
IHVzaW5nIHRoZSBjYWxsYmFjaw0KPiAuc2h1dGRvd24gaW4gcnNpX2RyaXZlci5kcnYgdG8gbWFr
ZSBpdCBwb3NzaWJsZSB0byBkcm9wIHRoYXQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBVd2UgS2xl
aW5lLUvDtm5pZyA8dS5rbGVpbmUta29lbmlnQGJheWxpYnJlLmNvbT4NCg0KQWNrZWQtYnk6IFBp
bmctS2UgU2hpaCA8cGtzaGloQHJlYWx0ZWsuY29tPg0KDQoNCg==

