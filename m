Return-Path: <linux-wireless+bounces-3122-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B2FD8492AA
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Feb 2024 04:10:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35ADD28339F
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Feb 2024 03:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074ED8F59;
	Mon,  5 Feb 2024 03:10:48 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30478F47;
	Mon,  5 Feb 2024 03:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707102647; cv=none; b=gPqbSI4HrUh27WPvbgkWpmQu2dkWDHZngTnACKHamyKKp7AboGhjaZRnHANajhJ6TgcgJ5bUjp75jAdG/tFZJN/mbOrOunRJ0Zr4kKAwNVh/toWnU/WHFi6OvXQWxsQhTAvUrwgmumtjLB6tNi8bM4Q6x9fY64yJs6gIzfREVgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707102647; c=relaxed/simple;
	bh=ICwP7+f1FRTE+g8A1InZdZUejk63/2kltHW+SgY4i1g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sCGoZnE7piS1FF0J68gjhX8Ei+YoW3o7UFLp6+fyFB98kpSc+bmsAY0gIrOrBVMeF8Yi/vKYyNZyBXPmpaZKBzxkJBn7c69e1eqUsc8xAqexRNTaOqZ8xCT1xNuxXwDIEnAIUaR+VeyD2s0dABwBEADRvY1ZEo6ozWDsI7VMGxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4153ATtO43034223, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4153ATtO43034223
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 5 Feb 2024 11:10:29 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.17; Mon, 5 Feb 2024 11:10:29 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 5 Feb 2024 11:10:28 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f]) by
 RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f%7]) with mapi id
 15.01.2507.035; Mon, 5 Feb 2024 11:10:28 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Fiona Klute <fiona.klute@gmx.de>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
CC: Kalle Valo <kvalo@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Pavel Machek
	<pavel@ucw.cz>,
        =?iso-8859-2?Q?Ond=F8ej_Jirman?= <megi@xff.cz>
Subject: RE: [PATCH 9/9] wifi: rtw88: SDIO device driver for RTL8723CS
Thread-Topic: [PATCH 9/9] wifi: rtw88: SDIO device driver for RTL8723CS
Thread-Index: AQHaVdEKV5hE9wEBeEeyi36pmJ9cvrD7FJnQ
Date: Mon, 5 Feb 2024 03:10:28 +0000
Message-ID: <b426d54fb44846ffb43a70e2806a064c@realtek.com>
References: <20240202121050.977223-1-fiona.klute@gmx.de>
 <20240202121050.977223-10-fiona.klute@gmx.de>
In-Reply-To: <20240202121050.977223-10-fiona.klute@gmx.de>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS02.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback



> -----Original Message-----
> From: Fiona Klute <fiona.klute@gmx.de>
> Sent: Friday, February 2, 2024 8:11 PM
> To: linux-wireless@vger.kernel.org; Ping-Ke Shih <pkshih@realtek.com>
> Cc: Kalle Valo <kvalo@kernel.org>; Ulf Hansson <ulf.hansson@linaro.org>; =
linux-mmc@vger.kernel.org; Pavel
> Machek <pavel@ucw.cz>; Ond=F8ej Jirman <megi@xff.cz>; Fiona Klute <fiona.=
klute@gmx.de>
> Subject: [PATCH 9/9] wifi: rtw88: SDIO device driver for RTL8723CS
>=20
> This driver uses the new rtw8703b chip driver code.
>=20
> Signed-off-by: Fiona Klute <fiona.klute@gmx.de>

Acked-by: Ping-Ke Shih <pkshih@realtek.com>

I have reviewed this patchset and only need some small changes, so I think
you can send firmware patch to me privately (please also tell me the vendor
driver version you are taking), and then I can check and send out the firmw=
are.

Thanks for your work!=20
Ping-Ke=20



