Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEF4C46F238
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Dec 2021 18:39:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243120AbhLIRmj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 Dec 2021 12:42:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231476AbhLIRmi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 Dec 2021 12:42:38 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF6FDC061746
        for <linux-wireless@vger.kernel.org>; Thu,  9 Dec 2021 09:39:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 333A7CE277F
        for <linux-wireless@vger.kernel.org>; Thu,  9 Dec 2021 17:39:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94296C004DD;
        Thu,  9 Dec 2021 17:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639071541;
        bh=C57ohrRWygB7gaq8VrUriv9aNbPRrHR0eMaKh1CP4vQ=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=K357uOqbh4zOlzlYIJNy74u05MJLtafKT5KM04SBVna8gTr7m6pwTMgjELMvXLuR2
         6ACrFhN0ZoPCtGL5aPES2EwmctFkpUuSiGEWIK2mXAb5rPkKnnYtzVzWiqZng+G2Tx
         eQEGjh7kswhysmbgYsiH4yrppUMEgjDopXU9NgUqmav4HqNz9DXZBwuFo9rY5anbD3
         icpOwzPsHnBt5fdFZE+A0H2vEH9cqwZqMEkDeFXLbcxSzpLflWZt/goHRiyqiZN4k2
         /vJxG+o4Fbf7D3A6HFqOAW4U5qPRnnFnifElP17/UhesY1v/dgt9QpgiTlP7dtdwxe
         /9Wc/hJNeIZBg==
From:   Kalle Valo <kvalo@kernel.org>
To:     Wen Gong <quic_wgong@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 13/15] ath11k: discard BSS_CHANGED_TXPOWER when EXT_TPC_REG_SUPPORT for 6 GHz
References: <20211026111913.7346-1-quic_wgong@quicinc.com>
        <20211026111913.7346-14-quic_wgong@quicinc.com>
Date:   Thu, 09 Dec 2021 19:38:58 +0200
In-Reply-To: <20211026111913.7346-14-quic_wgong@quicinc.com> (Wen Gong's
        message of "Tue, 26 Oct 2021 07:19:11 -0400")
Message-ID: <87tufhvft9.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <quic_wgong@quicinc.com> writes:

> When station is connected to a 6 GHz AP, it has 2 way to configure
> the power limit to firmware. The first way is to send 2 wmi command
> WMI_PDEV_PARAM_TXPOWER_LIMIT2G/WMI_PDEV_PARAM_TXPOWER_LIMIT5G to
> firmware, the second way is to send WMI_VDEV_SET_TPC_POWER_CMDID to
> firmware which include more parameters for power control.
>
> When firmware support SERVICE_EXT_TPC_REG, it means firmware support
> the second way for WMI_VDEV_SET_TPC_POWER_CMDID, then ath11k discard
> BSS_CHANGED_TXPOWER flag from mac80211 which is used to the first way
> for 6 GHz band in this patch and select the second way in the subsequent
> patch.
>
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
>
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
> ---
>  drivers/net/wireless/ath/ath11k/core.h |  6 ++++++
>  drivers/net/wireless/ath/ath11k/mac.c  | 19 +++++++++++++++++--
>  2 files changed, 23 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
> index 6969e0a6fc7b..6ef639975725 100644
> --- a/drivers/net/wireless/ath/ath11k/core.h
> +++ b/drivers/net/wireless/ath/ath11k/core.h
> @@ -1017,4 +1017,10 @@ static inline bool ath11k_support_6G_cc_ext(struct ath11k *ar)
>  	return ath11k_support_cc_ext(ar->ab) && ar->supports_6ghz;
>  }
>  
> +static inline bool ath11k_support_tpc_ext(struct ath11k *ar)
> +{
> +	return ath11k_support_6G_cc_ext(ar) &&
> +	       test_bit(WMI_TLV_SERVICE_EXT_TPC_REG_SUPPORT, ar->ab->wmi_ab.svc_map);
> +}

Move to hw.h and rename to:

ath11k_hw_supports_tpc_ext()

> --- a/drivers/net/wireless/ath/ath11k/mac.c
> +++ b/drivers/net/wireless/ath/ath11k/mac.c
> @@ -2170,6 +2170,16 @@ static int ath11k_mac_config_obss_pd(struct ath11k *ar,
>  	return 0;
>  }
>  
> +static bool ath11k_mac_station_support_tpc(struct ath11k *ar,
> +					   struct ath11k_vif *arvif,
> +					   struct cfg80211_chan_def *chandef)
> +{
> +	return ath11k_support_tpc_ext(ar) &&
> +	       arvif->vdev_type == WMI_VDEV_TYPE_STA &&
> +	       chandef->chan &&
> +	       chandef->chan->band == NL80211_BAND_6GHZ;
> +}

ath11k_mac_supports_station_tpc()

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
