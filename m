Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9B832A70FC
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Nov 2020 00:11:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730543AbgKDXLe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Nov 2020 18:11:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727107AbgKDXLe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Nov 2020 18:11:34 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9FF2C0613CF
        for <linux-wireless@vger.kernel.org>; Wed,  4 Nov 2020 15:11:32 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id t14so157446pgg.1
        for <linux-wireless@vger.kernel.org>; Wed, 04 Nov 2020 15:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+bXLtcNmpGx/o0XJ0M+6MKVfaBexlwpKp4u5QNyYDrw=;
        b=Ic10O2h8gw72RFZuUGwDiu6cFMJrpgqBrZlFYJGG+wvhJvqaoav/r7X7ZK9OPGqrB0
         W/5ioMidZERpwRVCe8DR2mjN5XxovsUrNvVyQuiGW/ZUxHer14OGeIO11w8SHLsoQtmj
         fZeE+4fcgbMB7tNGN5ZoTuqs9c2QpjDLSEIw8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+bXLtcNmpGx/o0XJ0M+6MKVfaBexlwpKp4u5QNyYDrw=;
        b=s3Dg665RPpQmFfFFaqg2b+gcp9Hwy0qCDywtiUnGUDlpjGfP1JgjSiboxXixFmQnuz
         gbeWoLMQcrUw4992s3WDZ4HS+44708YBZTfCPb72S5zLPW9d55UzjEdoF5KsPc4nHS8A
         rRiaOoqefpOc3dhJtT1MRq67svW88kFOEbl6ukunDdwIoIEd4iiHZC1Jj42E7maK3pbs
         IRRolSKJ24856UsvinFEctaPGD0EOVo1+Eizr27oBugW3weY1q/SKeN/7cOKESAAN34s
         orx4uEt/3b98v8hbWt1++ku82wLLvANVtbjDgiMQg/cpzTJ8mFSGO4aEFO3jQsZOZ0jq
         M6cw==
X-Gm-Message-State: AOAM5308JMRM2gfwhCGa+MAU1PjxA13S+BAkPkOt2ouPWJcVRCxH+Ikl
        GxH/BXBw5M9AYQYdXXhZ4Sk/Pw==
X-Google-Smtp-Source: ABdhPJzcgg8n5lbLegv3GdMVw3cAnR1QYHGE7qTtKFeikqplJRQ/lTSojORxaYZssPCOwAfx22JkeQ==
X-Received: by 2002:a63:c64:: with SMTP id 36mr247945pgm.255.1604531492262;
        Wed, 04 Nov 2020 15:11:32 -0800 (PST)
Received: from google.com ([2620:15c:202:201:8edc:d4ff:fe53:350d])
        by smtp.gmail.com with ESMTPSA id 14sm3336671pjn.48.2020.11.04.15.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 15:11:31 -0800 (PST)
Date:   Wed, 4 Nov 2020 15:11:28 -0800
From:   Brian Norris <briannorris@chromium.org>
To:     Carl Huang <cjhuang@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        dianders@chromium.org, kuabhs@google.com
Subject: Re: [RFC 2/2] ath10k: allow dynamic SAR power limits via common API
Message-ID: <20201104231128.GA3212577@google.com>
References: <1600753775-4745-1-git-send-email-cjhuang@codeaurora.org>
 <1600753775-4745-2-git-send-email-cjhuang@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1600753775-4745-2-git-send-email-cjhuang@codeaurora.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

On Tue, Sep 22, 2020 at 01:49:35PM +0800, Carl Huang wrote:
> ath10k assigns ath10k_mac_set_sar_specs to ath10k_ops, and
> this function is called when user space application calls
> NL80211_CMD_SET_SAR_SPECS. ath10k also registers SAR type,
> and supported frequency ranges to wiphy so user space can
> query SAR capabilities.
> 
> ath10k_mac_set_sar_specs further sets the power to firmware
> to limit the TX power.
> 
> This feature is controlled by hw parameter: dynamic_sar_support.
> 
> Signed-off-by: Carl Huang <cjhuang@codeaurora.org>
> ---

> diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
> index 2e3eb5b..830c61f 100644
> --- a/drivers/net/wireless/ath/ath10k/mac.c
> +++ b/drivers/net/wireless/ath/ath10k/mac.c
> @@ -81,6 +81,17 @@ static struct ieee80211_rate ath10k_rates_rev2[] = {
>  	{ .bitrate = 540, .hw_value = ATH10K_HW_RATE_OFDM_54M },
>  };
>  
> +static const struct cfg80211_sar_freq_ranges ath10k_sar_freq_ranges[] = {
> +	{ .index = 0, .start_freq = 2412000, .end_freq = 2484000 },

2412 MHz is a center frequency, but other parts of the nl80211 API use
band edges. For example:

 * @NL80211_ATTR_FREQ_RANGE_START: starting frequencry for the regulatory
 *      rule in KHz. This is not a center of frequency but an actual regulatory
 *      band edge.
 * @NL80211_ATTR_FREQ_RANGE_END: ending frequency for the regulatory rule
 *      in KHz. This is not a center a frequency but an actual regulatory
 *      band edge.

Seems like we should improve the nl80211.h docs (patch 1) and make these
edges (this patch).

> +	{ .index = 1, .start_freq = 2484000, .end_freq = 5865000 },
> +};
> +
> +static const struct cfg80211_sar_capa ath10k_sar_capa = {
> +	.type = NL80211_SAR_TYPE_POWER,
> +	.num_freq_ranges = (ARRAY_SIZE(ath10k_sar_freq_ranges)),
> +	.freq_ranges = &ath10k_sar_freq_ranges[0],
> +};
> +
>  #define ATH10K_MAC_FIRST_OFDM_RATE_IDX 4
>  
>  #define ath10k_a_rates (ath10k_rates + ATH10K_MAC_FIRST_OFDM_RATE_IDX)
> @@ -2880,6 +2891,95 @@ static int ath10k_mac_vif_recalc_txbf(struct ath10k *ar,
>  	return 0;
>  }
>  
> +static bool ath10k_mac_is_connected(struct ath10k *ar)
> +{
> +	struct ath10k_vif *arvif;
> +
> +	list_for_each_entry(arvif, &ar->arvifs, list) {
> +		if (arvif->is_up && arvif->vdev_type == WMI_VDEV_TYPE_STA)
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
> +int ath10k_mac_set_sar_power(struct ath10k *ar)

This function should be static.

> +{
> +	int ret;
> +
> +	if (!ar->hw_params.dynamic_sar_support)
> +		return 0;

return -EOPNOTSUPP ?

> +
> +	if (ar->tx_power_2g_limit == 0 || ar->tx_power_5g_limit == 0)

ath10k_mac_txpower_recalc() doesn't care about this -- why should you?
This also seems especially weird, because one of the 2 could be valid
nonzero values, and yet you're silently rejecting it. Regardless, the
following seems wrong:

> +		return 0;

This should probably be an error.

> +
> +	if (!ath10k_mac_is_connected(ar))
> +		return 0;

Note to self (since this wasn't obvious to me the first read-through):
you're calling this function from ath10k_bss_assoc() too, so even if you
weren't connected the first time around, it'll get called later.

> +
> +	ret = ath10k_wmi_pdev_set_param(ar,
> +					ar->wmi.pdev_param->txpower_limit2g,
> +					ar->tx_power_2g_limit);
> +	if (ret) {
> +		ath10k_warn(ar, "failed to set 2.4G txpower %d: %d\n",
> +			    ar->tx_power_2g_limit, ret);
> +		return ret;
> +	}
> +
> +	ret = ath10k_wmi_pdev_set_param(ar,
> +					ar->wmi.pdev_param->txpower_limit5g,
> +					ar->tx_power_5g_limit);
> +	if (ret) {
> +		ath10k_warn(ar, "failed to set 5G txpower %d: %d\n",
> +			    ar->tx_power_5g_limit, ret);
> +		return ret;
> +	}

Hmm, so these are the same params configured by
ath10k_mac_txpower_recalc(), except that we're not taking into account
the limitations in ath10k_mac_txpower_recalc() (and vice versa) -- isn't
that bad? Should we be merging the SAR limitation into
ath10k_mac_txpower_recalc() and calling that instead?

Brian

> +
> +	ath10k_dbg(ar, ATH10K_DBG_MAC, "set txpower 2G:%d, 5G:%d successfully\n",
> +		   ar->tx_power_2g_limit, ar->tx_power_5g_limit);
> +
> +	return ret;
> +}
> +
