Return-Path: <linux-wireless+bounces-4962-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A8DE880EB2
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 10:35:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A9121C20F58
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 09:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2679A39FF2;
	Wed, 20 Mar 2024 09:35:07 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4599D32C60
	for <linux-wireless@vger.kernel.org>; Wed, 20 Mar 2024 09:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710927307; cv=none; b=dZLoEc91NyGcXahF3PoQ2wrEQcCRbD8grcevaFcSQTNT6uJRCi7A14bVGAB2wpZeJZSTSLqDybDgwaeBMgoSZnkCIRmdGmfQaYxQ++L0LvtemG0Cb9P73rBV1q2trJTjeVaEQLkicRL0LY6sW3LFvgxOb7uJkJWso2ZbsLDzyqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710927307; c=relaxed/simple;
	bh=JmdCiyClq1MWCZtwV9HLKqQzrd97kryBzPBGA0T2NEM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DHIrPJBkJqikDHhY2/FeFz7UTVnf5r4XCWtn4VCUsERGsJg1Z1GY9/EEmmlgoBqSeJ8tHorcp2yhDsWNvX+m2xDWBDfix6NkN1ZD+yuR+ws2KsE9uIebL0N9Je2hK03GK53RXgyY6LGk9GKOghg3uW7rMKyKUBtXrylPQCQINEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 42K9YA0N0384908, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 42K9YA0N0384908
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Mar 2024 17:34:10 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 20 Mar 2024 17:34:11 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 20 Mar 2024 17:34:10 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c42:f80:bcc2:d00f]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c42:f80:bcc2:d00f%5]) with mapi id
 15.01.2507.035; Wed, 20 Mar 2024 17:34:10 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Kalle Valo <kvalo@kernel.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
        "fiona.klute@gmx.de"
	<fiona.klute@gmx.de>,
        "Jes.Sorensen@gmail.com" <Jes.Sorensen@gmail.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "rtl8821cerfe2@gmail.com"
	<rtl8821cerfe2@gmail.com>,
        "Larry.Finger@lwfinger.net"
	<Larry.Finger@lwfinger.net>,
        "martin.kaistra@linutronix.de"
	<martin.kaistra@linutronix.de>,
        "martin.blumenstingl@googlemail.com"
	<martin.blumenstingl@googlemail.com>,
        "brianwitte@mailfence.com"
	<brianwitte@mailfence.com>
Subject: RE: Git tree to manage Realtek WiFi drivers
Thread-Topic: Git tree to manage Realtek WiFi drivers
Thread-Index: AQHaeZ1wC1DGpCikcU2zHRKFE8bG1LFAVphtgAAHXYA=
Date: Wed, 20 Mar 2024 09:34:10 +0000
Message-ID: <94c25902ef33433dbb582fc1c503704c@realtek.com>
References: <503a9152324a817c251193ee486e1bbcb48d2fa8.camel@realtek.com>
 <87edc5b7oc.fsf@kernel.org>
In-Reply-To: <87edc5b7oc.fsf@kernel.org>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS02.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback


> Ping-Ke, a big thank you for starting to maintain the rtw tree! Not only
> that it helps me, I suspect Realtek driver development will be faster as
> I'm not the bottleneck anymore.

I feel probably registers of Realtek WiFi residing in driver eat lots of yo=
ur
bandwidth. Now I can take that part myself, so you can get your time back.
Again, your review is always helpful to our drivers!

Ping-Ke


