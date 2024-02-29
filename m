Return-Path: <linux-wireless+bounces-4220-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E110986BE6D
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Feb 2024 02:43:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F20A1C20F02
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Feb 2024 01:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50AF62E405;
	Thu, 29 Feb 2024 01:43:12 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05CEA23
	for <linux-wireless@vger.kernel.org>; Thu, 29 Feb 2024 01:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709170992; cv=none; b=Gh/xOkXWqe9k+Owzr/wH/xVwcbYx2atYXdaVY0SHOdZhdKX7PGLV20KaVyQtIUmaz+EvkRP3b5kxGmwvfx/VdZh+gWdJ/TnEn5U9SoF8O2yM5j9uhCpv77JGt7AsfdF6PFUSj3J/+7477K1+eJUnerZcs9OLZ+Ruq0SQ8YRE0zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709170992; c=relaxed/simple;
	bh=wuemIMH1cbUsomqabjnGZEG+zyMWnWWh+H9+STLH9h4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hQ+tahwzX+GbE4kswV/lG5xeanCiglBU26sWAFAMS1Y+8ZLzEy4YF+6XJt9QAKzMcdkVl8NeQip0Ci9RuMUNP78x0RGoiLLCZVzgt29JEuJH+hHD6sCz+loEJYWsZSV51vMWm73vfGAbEhm/6k8YGJ5iPA14wTHZyT0ynJyc2bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 41T1h1F31989642, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 41T1h1F31989642
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Feb 2024 09:43:01 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.32; Thu, 29 Feb 2024 09:43:01 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 29 Feb 2024 09:43:00 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f]) by
 RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f%7]) with mapi id
 15.01.2507.035; Thu, 29 Feb 2024 09:43:00 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Sascha Hauer <sha@pengutronix.de>,
        Bitterblue Smith
	<rtl8821cerfe2@gmail.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Sean
 Mollet" <sean@malmoset.com>
Subject: RE: [PATCH 1/4] wifi: rtw88: 8821cu: Fix firmware upload fail
Thread-Topic: [PATCH 1/4] wifi: rtw88: 8821cu: Fix firmware upload fail
Thread-Index: AQHaaXcR3HkprUxyPEepnjoj4RB95rEdn6yAgAA7GoCAARQJgIABmkjQgAAE1zA=
Date: Thu, 29 Feb 2024 01:43:00 +0000
Message-ID: <a0a19f8bde3e4e0d92b3badfcda78d5d@realtek.com>
References: <731ea688-04ef-4f02-9d01-3e9026981057@gmail.com>
 <Zd3b81m3_Hh47lww@pengutronix.de>
 <aacc9bf5-90e3-4e7a-af44-33d11fe89c18@gmail.com>
 <Zd71FWoTDn5plI5R@pengutronix.de>
 <d03453973370468aaf5213d61e8e3089@realtek.com>
In-Reply-To: <d03453973370468aaf5213d61e8e3089@realtek.com>
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
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback



> -----Original Message-----
> From: Ping-Ke Shih <pkshih@realtek.com>
> Sent: Thursday, February 29, 2024 9:37 AM
> To: Sascha Hauer <sha@pengutronix.de>; Bitterblue Smith <rtl8821cerfe2@gm=
ail.com>
> Cc: linux-wireless@vger.kernel.org; Sean Mollet <sean@malmoset.com>
> Subject: RE: [PATCH 1/4] wifi: rtw88: 8821cu: Fix firmware upload fail
>=20
>   2. off (< 0xFE00; but not on section): this section could be powered of=
f

2. off (< 0xFE00; exclude on-section): this section could be powered off

Correct wording to avoid confusing.=20



