Return-Path: <linux-wireless+bounces-11002-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2005B948B68
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Aug 2024 10:37:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 519091C21463
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Aug 2024 08:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB9C16C692;
	Tue,  6 Aug 2024 08:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="oY8224Sf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E92320C
	for <linux-wireless@vger.kernel.org>; Tue,  6 Aug 2024 08:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722933442; cv=none; b=l+DUUI0t/oM2+86Yujvbj7MDj9xnRVpP0dCSQSGl9p8pdsWVYzOUc879WlSnhg9dHKsZdlI4ncjNEbZjlyyDdNQ/WKnwemu+9rDAzCBhQxB3kRT37xDdbbVa/+6iQT8aElnoyAWEv7VVpeXTcesq6Rf20AeG5VNpXQhyj760tiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722933442; c=relaxed/simple;
	bh=5XGnKtF1nkqyaLvoMymoMTrVAFbKdCREsS4GhmfSq1M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Qfxl3bBb0hiRsjGcizdciBjoq4uwwsHiTjcbT42e66i71sdSPRLP2gcVEapzRfqzaFBBa21PFP6xMHhgf/GEmgrPcfsy3r4qS4CL7RnypAWgluFnkbBtz1PXMaH1xSovNzPzhuVnnPwEQrRnzoWs5P/cmM1mFew9g1+pre/HdaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=oY8224Sf; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4768b4v45916718, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1722933424; bh=5XGnKtF1nkqyaLvoMymoMTrVAFbKdCREsS4GhmfSq1M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=oY8224SfVFZmBOb3KrOv0kmqi5AP+2rWntRe+qKE23FQpBPkRSli/ZCAOWIlAc7Ym
	 Mq9RnHRlguTy2jwexMiDCV0oYSuwKNRJAmg/V+ALW/6PSmo4R9V2Oe/up16/dreEuY
	 wvd3qse9gJ/IscDAX2FGU/CTvJxcAPbYiKebtgvX+Q5FrYc+UEh1OZjsYF+qygPufU
	 6d+DW6Fx9hRzPMgWzgQpMsCldNGSbH0Nr4TTSj0SeI/ifCHe+Q03YJiNQgKZ5lPtDI
	 U+8DDE2lseBIy6yZDZgeEqfVDk2S1Cq7/nYNCV5IMo1jJULwrgY3D1fF0E/ffE/gJf
	 cSn32Y09eRoUQ==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 4768b4v45916718
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 6 Aug 2024 16:37:04 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 6 Aug 2024 16:37:04 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 6 Aug 2024 16:37:04 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Tue, 6 Aug 2024 16:37:04 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Sascha Hauer <sha@pengutronix.de>,
        Bitterblue Smith
	<rtl8821cerfe2@gmail.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH v2 3/4] wifi: rtw88: usb: Support RX aggregation
Thread-Topic: [PATCH v2 3/4] wifi: rtw88: usb: Support RX aggregation
Thread-Index: AQHa5SO/Y65U8dgaJ0S4drAdXQHZv7IXwG0AgAIsPzA=
Date: Tue, 6 Aug 2024 08:37:03 +0000
Message-ID: <e3aeab44c81b4f17a8cb7a88669fde0f@realtek.com>
References: <60856bbc-8701-4aee-804c-3d8c00d4f5c5@gmail.com>
 <ac43a1bb-d735-43df-b6bf-41c44148c9e2@gmail.com>
 <ZrB-AtNmj2NAv752@pengutronix.de>
In-Reply-To: <ZrB-AtNmj2NAv752@pengutronix.de>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Sascha Hauer <sha@pengutronix.de> wrote:
> On Sat, Aug 03, 2024 at 12:34:20AM +0300, Bitterblue Smith wrote:
> > +     struct sk_buff *next_skb =3D NULL;
>=20
> Nit: With the changes in this version initialization to NULL is no
> longer necessary.
>=20

Please update v3 for this, and take Sascha's Tested-by and Reviewed-by.=20

Otherwise, this patchset looks good to me.=20


