Return-Path: <linux-wireless+bounces-7100-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C3FC58B937C
	for <lists+linux-wireless@lfdr.de>; Thu,  2 May 2024 04:55:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC42BB22451
	for <lists+linux-wireless@lfdr.de>; Thu,  2 May 2024 02:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD6E17C6C;
	Thu,  2 May 2024 02:55:41 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0A017997
	for <linux-wireless@vger.kernel.org>; Thu,  2 May 2024 02:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714618541; cv=none; b=P17TSFyBg+SeQWZdByqRap0XTMsFgys01EIXXt5o7Y3cJPsMQOq3ocKqa33DRYXPMNoBEv/2zromyup13uvGBlRjoDqtXhz7LqGkLcRi7tCecEnn40J9vhfHUlPd1OPt8thWVKsB81vGExwGOw5dgw9Ir415N4slnra8mh0Lcbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714618541; c=relaxed/simple;
	bh=vfqYEiEGIVVoZ2wS37La0l+ZM29glFAlGxTEj2Gs1tM=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=eChCKRnbDdJWgs0Ttml3Cv0Tm5QxAsb2TcG5+BX2h7JaqMsjmKJxSeuSGT3S4khoC9I9mePy2PrnP1nAo2/YqXDiMCm2DDzhADsNYldhg3aOirdFaAFeAga2N9GPwc5DaBdYbbnfjK6fvhIIjEJwz88j1fe6Ff3rrGdwBiuv3pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4422t91f92047261, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4422t91f92047261
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 2 May 2024 10:55:09 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 2 May 2024 10:55:09 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 2 May
 2024 10:55:09 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Ping-Ke Shih <pkshih@realtek.com>,
        Larry Finger
	<Larry.Finger@lwfinger.net>,
        Stefan Lippers-Hollmann <s.l-h@gmx.de>,
        Christian Hewitt <chewitt@libreelec.tv>
Subject: Re: [PATCH v7 1/6] wifi: rtlwifi: rtl8192de: Fix 5 GHz TX power
In-Reply-To: <c7653517-cf88-4f57-b79a-8edb0a8b32f0@gmail.com>
References: <72231f87-60fd-4d87-8cf4-ee2967f22dd2@gmail.com> <c7653517-cf88-4f57-b79a-8edb0a8b32f0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <fcb4316d-75c0-4d70-8509-281abba51727@RTEXMBS04.realtek.com.tw>
Date: Thu, 2 May 2024 10:55:09 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:

> Different channels have different TX power settings. rtl8192de is using
> the TX power setting from the wrong channel in the 5 GHz band because
> _rtl92c_phy_get_rightchnlplace expects an array which includes all the
> channel numbers, but it's using an array which includes only the 5 GHz
> channel numbers.
> 
> Use the array channel_all (defined in rtl8192de/phy.c) instead of
> the incorrect channel5g (defined in core.c).
> 
> Tested only with rtl8192du, which will use the same TX power code.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>

6 patch(es) applied to rtw-next branch of rtw.git, thanks.

de4d4be4fa64 wifi: rtlwifi: rtl8192de: Fix 5 GHz TX power
a7c0f48410f5 wifi: rtlwifi: rtl8192de: Fix low speed with WPA3-SAE
2f228d364da9 wifi: rtlwifi: rtl8192de: Fix endianness issue in RX path
db5ae2e1826b wifi: rtlwifi: Move code from rtl8192de to rtl8192d-common
d75589a0133d wifi: rtlwifi: Clean up rtl8192d-common a bit
014bba73b525 wifi: rtlwifi: Adjust rtl8192d-common for USB

---
https://github.com/pkshih/rtw.git


