Return-Path: <linux-wireless+bounces-14922-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 079079BCCC5
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Nov 2024 13:31:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E729B2397B
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Nov 2024 12:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C0B1D27B3;
	Tue,  5 Nov 2024 12:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fTll0Iyb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55FD1D0BAA
	for <linux-wireless@vger.kernel.org>; Tue,  5 Nov 2024 12:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730809874; cv=none; b=IGFimpVwaZpZZ+QQJEhoHSnZ7+72dF1rQTBMv/e3GI5Tau5ynoUnTkuEWNWJjWqrvXcOmcH0Yf3zQyUoT/TdwIREqDmxEuCwcG+GNGZEq7b+OcKdBTL9nqdDRJeloldlU5uoRkVQiCPNC03wkeu34akFv+piO9UVraUf61WPWwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730809874; c=relaxed/simple;
	bh=LW2QZ1atvzgNLYAlpDic1g4S1lazUmf2JMXD3E+rY1I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YoiLmPvibKaLWOAeZ4URmUfatiJzA8IKN558CJg+6qP/Mnw3fdTFU/+3dgXCjzqeijlgAVObXGmFb5MmWpGAOC1jxcdr+w92uJa8r9xIMaMZLbRigDzj7wzyuT76bI5Dw9OU9nPPYY4tU74HXdSV8QmRiJLHz1KDJ0WLolrzXEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fTll0Iyb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4079FC4CECF;
	Tue,  5 Nov 2024 12:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730809874;
	bh=LW2QZ1atvzgNLYAlpDic1g4S1lazUmf2JMXD3E+rY1I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=fTll0IybT0WDr0T7Y99LpeijYj1KwYfAHYhAL0QhPS7egmedDFU9VIyKFVg/PY60m
	 J1tS/ck94uYbgWLZMri1FwmY4LgD9Io1xcrCZrGYZcsuB4Sdpd1B69DqiUrHC2G3z6
	 mUs3B3+4tZX6ERU0hlVic6x52H0O1F0w4lMu825XDO6N8ilDLPPjO8uSqQGGU41r/O
	 8DJbsHT2htu2qZvkTShkL5riJoelLbTKswpz4oYeR0eCez4tX3yOnFR/dzbLkDJlKz
	 MWXeK1scQkYvN2kLW04/hZkrHUAsjHaZA5FaTVz96tqQrIkcxDdWHP2h43W8vbVPlI
	 I0LjY/6YxcKMg==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 13F4B164C235; Tue, 05 Nov 2024 13:31:11 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To: Issam Hamdi <ih@simonwunderlich.de>, johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, mathias.kretschmer@fit.fraunhofer.de,
 Simon Wunderlich <simon.wunderlich@open-mesh.com>, Simon Wunderlich
 <sw@simonwunderlich.de>, Sven Eckelmann <se@simonwunderlich.de>, Issam
 Hamdi <ih@simonwunderlich.de>
Subject: Re: [PATCH 1/2] wifi: ath9k: work around AR_CFG 0xdeadbeef chip hang
In-Reply-To: <20241104171627.3789199-1-ih@simonwunderlich.de>
References: <20241104171627.3789199-1-ih@simonwunderlich.de>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 05 Nov 2024 13:31:11 +0100
Message-ID: <87jzdh981c.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Issam Hamdi <ih@simonwunderlich.de> writes:

> From: Simon Wunderlich <simon.wunderlich@open-mesh.com>
>
> QCA 802.11n chips (especially AR9330/AR9340) sometimes end up in a state in
> which a read of AR_CFG always returns 0xdeadbeef. This should not happen
> when when the power_mode of the device is ATH9K_PM_AWAKE.
>
> This problem is not yet detected by any other workaround in ath9k. No way
> is known to reproduce the problem easily.
>
> This patch originally developed by "Simon Wunderlich <simon.wunderlich@open-mesh.com>"
> and "Sven Eckelmann <sven.eckelmann@open-mesh.com>"
>
> Co-developed-by: Simon Wunderlich <sw@simonwunderlich.de>
> Co-developed-by: Sven Eckelmann <se@simonwunderlich.de>
> Signed-off-by: Issam Hamdi <ih@simonwunderlich.de>
> ---
>  drivers/net/wireless/ath/ath9k/ath9k.h |  3 +++
>  drivers/net/wireless/ath/ath9k/debug.c |  1 +
>  drivers/net/wireless/ath/ath9k/debug.h |  1 +
>  drivers/net/wireless/ath/ath9k/init.c  |  1 +
>  drivers/net/wireless/ath/ath9k/link.c  | 31 ++++++++++++++++++++++++++
>  drivers/net/wireless/ath/ath9k/main.c  |  4 ++++
>  6 files changed, 41 insertions(+)
>
> diff --git a/drivers/net/wireless/ath/ath9k/ath9k.h b/drivers/net/wireless/ath/ath9k/ath9k.h
> index 29ca65a732a6..c1ce081445a9 100644
> --- a/drivers/net/wireless/ath/ath9k/ath9k.h
> +++ b/drivers/net/wireless/ath/ath9k/ath9k.h
> @@ -739,11 +739,13 @@ void ath9k_csa_update(struct ath_softc *sc);
>  #define ATH_ANI_MAX_SKIP_COUNT    10
>  #define ATH_PAPRD_TIMEOUT         100 /* msecs */
>  #define ATH_PLL_WORK_INTERVAL     100
> +#define ATH_HANG_WORK_INTERVAL    4000
>  
>  void ath_hw_check_work(struct work_struct *work);
>  void ath_reset_work(struct work_struct *work);
>  bool ath_hw_check(struct ath_softc *sc);
>  void ath_hw_pll_work(struct work_struct *work);
> +void ath_hw_hang_work(struct work_struct *work);
>  void ath_paprd_calibrate(struct work_struct *work);
>  void ath_ani_calibrate(struct timer_list *t);
>  void ath_start_ani(struct ath_softc *sc);
> @@ -1044,6 +1046,7 @@ struct ath_softc {
>  #endif
>  	struct delayed_work hw_check_work;
>  	struct delayed_work hw_pll_work;
> +	struct delayed_work hw_hang_work;
>  	struct timer_list sleep_timer;
>  
>  #ifdef CONFIG_ATH9K_BTCOEX_SUPPORT
> diff --git a/drivers/net/wireless/ath/ath9k/debug.c b/drivers/net/wireless/ath/ath9k/debug.c
> index eff894958a73..6b2469a01f17 100644
> --- a/drivers/net/wireless/ath/ath9k/debug.c
> +++ b/drivers/net/wireless/ath/ath9k/debug.c
> @@ -750,6 +750,7 @@ static int read_file_reset(struct seq_file *file, void *data)
>  		[RESET_TYPE_CALIBRATION] = "Calibration error",
>  		[RESET_TX_DMA_ERROR] = "Tx DMA stop error",
>  		[RESET_RX_DMA_ERROR] = "Rx DMA stop error",
> +		[RESET_TYPE_DEADBEEF] = "deadbeef hang",
>  	};
>  	int i;
>  
> diff --git a/drivers/net/wireless/ath/ath9k/debug.h b/drivers/net/wireless/ath/ath9k/debug.h
> index 389459c04d14..6ebb6053a8c1 100644
> --- a/drivers/net/wireless/ath/ath9k/debug.h
> +++ b/drivers/net/wireless/ath/ath9k/debug.h
> @@ -53,6 +53,7 @@ enum ath_reset_type {
>  	RESET_TYPE_CALIBRATION,
>  	RESET_TX_DMA_ERROR,
>  	RESET_RX_DMA_ERROR,
> +	RESET_TYPE_DEADBEEF,
>  	__RESET_TYPE_MAX
>  };
>  
> diff --git a/drivers/net/wireless/ath/ath9k/init.c b/drivers/net/wireless/ath/ath9k/init.c
> index f9e77c4624d9..833474d7281f 100644
> --- a/drivers/net/wireless/ath/ath9k/init.c
> +++ b/drivers/net/wireless/ath/ath9k/init.c
> @@ -740,6 +740,7 @@ static int ath9k_init_softc(u16 devid, struct ath_softc *sc,
>  	INIT_WORK(&sc->paprd_work, ath_paprd_calibrate);
>  	INIT_DELAYED_WORK(&sc->hw_pll_work, ath_hw_pll_work);
>  	INIT_DELAYED_WORK(&sc->hw_check_work, ath_hw_check_work);
> +	INIT_DELAYED_WORK(&sc->hw_hang_work, ath_hw_hang_work);
>  
>  	ath9k_init_channel_context(sc);
>  
> diff --git a/drivers/net/wireless/ath/ath9k/link.c b/drivers/net/wireless/ath/ath9k/link.c
> index d1e5767aab3c..37438960c278 100644
> --- a/drivers/net/wireless/ath/ath9k/link.c
> +++ b/drivers/net/wireless/ath/ath9k/link.c
> @@ -142,6 +142,37 @@ void ath_hw_pll_work(struct work_struct *work)
>  				     msecs_to_jiffies(ATH_PLL_WORK_INTERVAL));
>  }
>  
> +static bool ath_hw_hang_deadbeef(struct ath_softc *sc)
> +{
> +	struct ath_common *common = ath9k_hw_common(sc->sc_ah);
> +	u32 reg;
> +
> +	/* check for stucked MAC */
> +	ath9k_ps_wakeup(sc);
> +	reg = REG_READ(sc->sc_ah, AR_CFG);
> +	ath9k_ps_restore(sc);
> +
> +	if (reg != 0xdeadbeef)
> +		return false;

ath9k_hw_check_alive() already does this exact check...

-Toke

