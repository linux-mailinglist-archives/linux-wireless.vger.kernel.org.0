Return-Path: <linux-wireless+bounces-16294-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9FAE9EE0B4
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Dec 2024 08:56:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA233285A65
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Dec 2024 07:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2365520C008;
	Thu, 12 Dec 2024 07:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mf5Jz7ok"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F334420B81F
	for <linux-wireless@vger.kernel.org>; Thu, 12 Dec 2024 07:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733990175; cv=none; b=RlnLKse/nauzc6uzzlJ+EeBVXVpULXhN8oB8URPjMZ3yY+M/EORBfoMn3piEzqAaOzwxWxWMDolawtOE3ECzRe7xvC75Z9i9eo2Sty4GcmBf9LYVzuXli6nkTekBjk+4HLpNYtLrhiXTi140DkzVOVPGk6IfBqQjSwtwcC7zNdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733990175; c=relaxed/simple;
	bh=D3zlEDcL4QLLYv4J9NPmxlbqpr4tLNzH9v7WwkjbKJI=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=X5UzO3MUgDCX3iZTww6J6vagPehzJTvMoQly5c5jppGdXfzKiuBuMfoip1HfgD0tiY1um61MPZodGD7EjOF3oAESrfrdP0uqrrmoDAF6s/hf12vev82J08fGC5y4nYOdlpF7AkLH93qTwzKcMW6uhED2jogxBI1oEJnqRrez3vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mf5Jz7ok; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98C06C4CECE;
	Thu, 12 Dec 2024 07:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733990174;
	bh=D3zlEDcL4QLLYv4J9NPmxlbqpr4tLNzH9v7WwkjbKJI=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=mf5Jz7okKQSj+bwBrfYUF7dAisuuodNaejtDAJdTyLdeFKoEclA/mOnvL3ZS+syu3
	 lQXP4gYat2vlBZY8NKsCBebOm/7krtB40NuEx4i03+xGMSzoQ+TANRStGSiup3lDnA
	 tNXtXvpP6XyvSJXAueJb/vUeuRTeXLVVezhk9N/uf6+wBU67EnvnPgbOX9nbVxdtJD
	 atBZnPU4ZMCRoo8ou6oj0RkXHrL1ObKvDTgVUTVkeWYvihaB15ye17RxKPh+iEfytf
	 Xahva59/g5gZpw6gDb1Qfdn17CfcutbvfQ5sxXoHKPEb3eGI59jpZmsz3XHaxReRyi
	 KRkmRY2EemKVg==
From: Kalle Valo <kvalo@kernel.org>
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 4/4] wifi: ath12k: Fix uninitialized variable access in
 ath12k_mac_allocate() function
References: <20241212004906.3087425-1-quic_periyasa@quicinc.com>
	<20241212004906.3087425-5-quic_periyasa@quicinc.com>
Date: Thu, 12 Dec 2024 09:56:11 +0200
In-Reply-To: <20241212004906.3087425-5-quic_periyasa@quicinc.com> (Karthikeyan
	Periyasamy's message of "Thu, 12 Dec 2024 06:19:06 +0530")
Message-ID: <87v7vppc6c.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthikeyan Periyasamy <quic_periyasa@quicinc.com> writes:

> Currently, the uninitialized variable 'ab' is accessed in the
> ath12k_mac_allocate() function. Initialize 'ab' with the first radio device
> present in the hardware abstraction handle (ah). Additionally, move the
> default setting procedure from the pdev mapping iteration to the total
> radio calculating iteration for better code readability. Perform the
> maximum radio validation check for total_radio to ensure that both num_hw
> and radio_per_hw are validated indirectly, as these variables are derived
> from total_radio. This also fixes the below Smatch static checker warning.
>
> Smatch warning:
> ath12k_mac_allocate() error: uninitialized symbol 'ab'
>
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
>
> Fixes: a343d97f27f5 ("wifi: ath12k: move struct ath12k_hw from per device to group")
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
> ---
>  drivers/net/wireless/ath/ath12k/mac.c | 27 +++++++++++++++++++++------
>  1 file changed, 21 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
> index 5cdc1c38b049..98b2f853d243 100644
> --- a/drivers/net/wireless/ath/ath12k/mac.c
> +++ b/drivers/net/wireless/ath/ath12k/mac.c
> @@ -10962,8 +10962,20 @@ int ath12k_mac_allocate(struct ath12k_hw_group *ag)
>  	u8 radio_per_hw;
>  
>  	total_radio = 0;
> -	for (i = 0; i < ag->num_devices; i++)
> -		total_radio += ag->ab[i]->num_radios;
> +	for (i = 0; i < ag->num_devices; i++) {
> +		ab = ag->ab[i];
> +		if (!ab)
> +			continue;
> +
> +		ath12k_mac_set_device_defaults(ab);
> +		total_radio += ab->num_radios;
> +	}
> +
> +	if (!total_radio)
> +		return -EINVAL;

'total_radio == 0' is more readable as it's a counter. Also please add ath12k_warn()

> +
> +	if (WARN_ON(total_radio > ATH12K_GROUP_MAX_RADIO))
> +		return -ENOSPC;

BTW ath12k_warn() is preferred over WARN_ON(), but this is just for the
future as this WARN_ON() was already there before.

>  
>  	/* All pdev get combined and register as single wiphy based on
>  	 * hardware group which participate in multi-link operation else
> @@ -10976,14 +10988,16 @@ int ath12k_mac_allocate(struct ath12k_hw_group *ag)
>  
>  	num_hw = total_radio / radio_per_hw;
>  
> -	if (WARN_ON(num_hw >= ATH12K_GROUP_MAX_RADIO))
> -		return -ENOSPC;
> -
>  	ag->num_hw = 0;
>  	device_id = 0;
>  	mac_id = 0;
>  	for (i = 0; i < num_hw; i++) {
>  		for (j = 0; j < radio_per_hw; j++) {
> +			if (device_id >= ag->num_devices || !ag->ab[device_id]) {
> +				ret = -ENOSPC;
> +				goto err;
> +			}

ath12k_warn()

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

