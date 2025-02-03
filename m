Return-Path: <linux-wireless+bounces-18267-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D50A25144
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Feb 2025 03:41:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B68F4162D31
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Feb 2025 02:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4541156CA;
	Mon,  3 Feb 2025 02:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="bl14MFzT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7289EAD23
	for <linux-wireless@vger.kernel.org>; Mon,  3 Feb 2025 02:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738550471; cv=none; b=GavKaq1nNn3MfF+p4pK+BgT1naFTKY8WXSMz+pJsOEJMIPwrYsH282aCnwyDwMWV+EqPHWI8A1uGxsdIRYqr+2z0ojL8auy0yeRsGtm+1zpDp10WLr5V5Bu0njGUt08cXvVAuNgqsJaZEvGH2scrU+VoD9+kKAj2r6crHyOYh3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738550471; c=relaxed/simple;
	bh=UDI5RUnUTttK2Y8ProhSPtn8jt7Ek5T8448M7QbKFCw=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=bYwvsf/b/fLrv3ZaKIzzV8VZ2F4qnXTexMjThGdnjUjOF2/tg6Eqsk7377XOvFys/tBMwqY1CkmtHnPW0V3X/9P2gX80zkyY3ZV8XvAb4gxEFYIT2hRnQFIjokBg+Bjo9WeH2awPmgB29ZIQtmz3jE191fat62sGam5x7XjYv10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=bl14MFzT; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 5132eCIh9961000, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1738550412; bh=UDI5RUnUTttK2Y8ProhSPtn8jt7Ek5T8448M7QbKFCw=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=bl14MFzTXQlE1SmmKwVQ+G5XPXcLT7DYIJm9XpJW6LM2MUXUTRRtCisMvWkrZbbVu
	 kgacVIzZcPtgRXTb4QUTqwHtwj4uxWiC7y/Ode7SUXGVelEYbAic2fbu0FEoih//ev
	 hzzD6VpSED6fub1aGUbJug0bzPDaRWePldUZ6d9+t5BAtyBj1lso/k55+S6BnPCZ5o
	 UMXbCAtHQf2TpS4Lr9vZX9BLIldQn/tbfnaDeA5cy2TWth+WI2w1GadCvXVagkMGfO
	 ES791cUzgf2ZjYa0jfJCHxKJFy9AWtToqq0Wnc4L7qJrc8WAWv8JdE1pzopdXuM7Sz
	 wFnraIDpaqlaA==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 5132eCIh9961000
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Feb 2025 10:40:12 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 3 Feb 2025 10:40:12 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 3 Feb
 2025 10:40:11 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ezra Buehler <ezra@easyb.ch>, <linux-wireless@vger.kernel.org>
CC: Jes Sorensen <Jes.Sorensen@gmail.com>, Kalle Valo <kvalo@kernel.org>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Martin Kaistra
	<martin.kaistra@linutronix.de>,
        Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Reto Schneider
	<reto.schneider@husqvarnagroup.com>,
        Ezra Buehler
	<ezra.buehler@husqvarnagroup.com>
Subject: Re: [PATCH v2] wifi: rtl8xxxu: Enable AP mode for RTL8192CU (RTL8188CUS)
In-Reply-To: <20250122071512.10165-1-ezra@easyb.ch>
References: <20250122071512.10165-1-ezra@easyb.ch>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <393aa422-3ac8-40e7-aa2f-62956a844005@RTEXMBS04.realtek.com.tw>
Date: Mon, 3 Feb 2025 10:40:11 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Ezra Buehler <ezra@easyb.ch> wrote:

> From: Ezra Buehler <ezra.buehler@husqvarnagroup.com>
> 
> This allows the driver to be used in wireless access point mode on the
> AT91SAM9G25-based GARDENA smart Gateway.
> 
> Unfortunately, the data throughput in AP mode appears to be lower than
> with the vendor driver (or in STA mode). Especially when sending, the
> data rate is significantly lower. My measurements performed with iperf3
> and an Edimax EW-7811Un (VID: 7392, PID: 7811) showed a maximum TX rate
> of about 4 Mbits/sec compared to the ~24 Mbits/sec measured with the
> rtl8192cu driver.
> 
> Although the performance might be good enough for our use case, this is
> something that should be further looked into.
> 
> Signed-off-by: Ezra Buehler <ezra.buehler@husqvarnagroup.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

4828f572b20b wifi: rtl8xxxu: Enable AP mode for RTL8192CU (RTL8188CUS)

---
https://github.com/pkshih/rtw.git


