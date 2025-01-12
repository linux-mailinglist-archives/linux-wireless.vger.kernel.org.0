Return-Path: <linux-wireless+bounces-17364-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD39A0A6E5
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Jan 2025 03:02:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02F773A7EA0
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Jan 2025 02:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D91A7611E;
	Sun, 12 Jan 2025 02:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="ahmHKulK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E3ADDAB;
	Sun, 12 Jan 2025 02:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736647349; cv=none; b=DQjVtjcl99EJLaz1AJwW3fBvTvVEPZhXGAAMOjUEv4DqYp3QaHj9COmTHUu5filaMYL4phEEJaymPw2w1YRm88gEfJIwU4FYWF4/ISDRvS3DSDxkokp8NLuVAXayjREOrBctx0HQk1Er+HMBBsD6bgkFnZPLg/WEMhfOPSdIsKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736647349; c=relaxed/simple;
	bh=FEyp2C1SKUl7ggIYjpL3u/7pnqLzmyx1/rxQdy+ABTI=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=IRFQG0iPYcJSvcYdlMcYMaLoWOmm9EVD9kLuHDsX5jkAAenZf3ak0VftOfc3Hri9/4QyVFOztjtUhhzHkGt/+hPfaG8Q9dHE/grMUINQoKsSaSuMGFrfBqOGtlIlwp4xhuNmuAJXIs2AfBGyg2EpIdhtEZ8Q1hKnW0hzbhiVBW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=ahmHKulK; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 50C22EDU01603140, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1736647334; bh=FEyp2C1SKUl7ggIYjpL3u/7pnqLzmyx1/rxQdy+ABTI=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=ahmHKulKq62ODMZnWHlPct/+BsniwHtQ10RQH+IDZHDGmsnlXxHq8tfmlVW92puWN
	 y7dJa0irtVuQ4QrAG4lRZWSKDkxZzek29bpKknMCQd4cW/VdMNktXrYAMYVNlPmgjt
	 CSYRy4lWZmCmqAHlEzx8/y1BTAxNcneBjeB2mp0gnMbrduBPlGMU5KPn4pL82afeQ5
	 2o8fVzC8pGWmBThDItdiOWe5yIp0ZLuNnZitbZf8masYoDSCYycahaxsI7AZ0CaiTH
	 pFk5KrRHyTqLpYrwJ3fyxud5GdDouIZoiHeD5d55JCEymiD3J7zSTZf5C7Oo4DOSp8
	 jkt+UkEwEPXMA==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 50C22EDU01603140
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 12 Jan 2025 10:02:14 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 12 Jan 2025 10:02:14 +0800
Received: from [127.0.1.1] (172.16.16.103) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Sun, 12 Jan
 2025 10:02:13 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Vasily Khoruzhick <anarsoul@gmail.com>, Ping-Ke Shih <pkshih@realtek.com>,
        Kalle Valo <kvalo@kernel.org>, Fiona Klute <fiona.klute@gmx.de>,
        "Bitterblue
 Smith" <rtl8821cerfe2@gmail.com>,
        <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Vasily Khoruzhick <anarsoul@gmail.com>, <stable@vger.kernel.org>
Subject: Re: [PATCH] wifi: rtw88: 8703b: Fix RX/TX issues
In-Reply-To: <20250103075107.1337533-1-anarsoul@gmail.com>
References: <20250103075107.1337533-1-anarsoul@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <df464998-c973-4744-b472-1f76110bf5ff@RTEXMBS04.realtek.com.tw>
Date: Sun, 12 Jan 2025 10:02:13 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Vasily Khoruzhick <anarsoul@gmail.com> wrote:

> Fix 3 typos in 8703b driver. 2 typos in calibration routines are not
> fatal and do not seem to have any impact, just fix them to match vendor
> driver.
> 
> However the last one in rtw8703b_set_channel_bb() clears too many bits
> in REG_OFDM0_TX_PSD_NOISE, causing TX and RX issues (neither rate goes
> above MCS0-MCS1). Vendor driver clears only 2 most significant bits.
> 
> With the last typo fixed, the driver is able to reach MCS7 on Pinebook
> 
> Cc: stable@vger.kernel.org
> Fixes: 9bb762b3a957 ("wifi: rtw88: Add definitions for 8703b chip")
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>
> Tested-by: Fiona Klute <fiona.klute@gmx.de>
> Tested-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

a806a8160a0f wifi: rtw88: 8703b: Fix RX/TX issues

---
https://github.com/pkshih/rtw.git


