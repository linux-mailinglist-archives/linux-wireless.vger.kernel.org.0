Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B35691C4A70
	for <lists+linux-wireless@lfdr.de>; Tue,  5 May 2020 01:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728476AbgEDXiP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 4 May 2020 19:38:15 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:18747 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728475AbgEDXiO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 4 May 2020 19:38:14 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588635493; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=lOZ4tyU3hhbnZJSh2lBCxUEl4+xkzrxlUN3eXX+6mN8=;
 b=ZuiOEIBsnh/4pdsy2UUCYWi4PVJVNLRt1HaHc2CGe2Rt4mlfxyX+YuJAT7DK/DefMIedgWen
 LBjLBmrsL0FQBAvOMhlKij5GZKAVy4GwXvXyYtYqfrrskHrsDqXpKVk6mfuBjMwQhPbSRlmJ
 Ic6ejUNaEvGh7iNtw6F5dJnUvfo=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb0a747.7ffa973a50a0-smtp-out-n04;
 Mon, 04 May 2020 23:37:43 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6CFCAC4478F; Mon,  4 May 2020 23:37:42 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: rmanohar)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 91D9EC433BA;
        Mon,  4 May 2020 23:37:41 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 04 May 2020 16:37:41 -0700
From:   Rajkumar Manoharan <rmanohar@codeaurora.org>
To:     Markus Theil <markus.theil@tu-ilmenau.de>
Cc:     linux-wireless@vger.kernel.org, kvalo@codeaurora.org,
        ath10k@lists.infradead.org, ath11k@lists.infradead.org,
        linux-wireless-owner@vger.kernel.org
Subject: Re: [PATCH 2/2] ath11k: use cumulative survey statistics
In-Reply-To: <20200504154122.91862-2-markus.theil@tu-ilmenau.de>
References: <20200504154122.91862-1-markus.theil@tu-ilmenau.de>
 <20200504154122.91862-2-markus.theil@tu-ilmenau.de>
Message-ID: <85fa2d5f9183b3a12c5283b800f3750f@codeaurora.org>
X-Sender: rmanohar@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-05-04 08:41, Markus Theil wrote:
> ath11k currently reports survey results for the last interval between 
> each
> invocation of NL80211_CMD_GET_SURVEY. For concurrent invocations, this
> can lead to unexpectedly small results, e.g. when hostapd uses survey
> data and iw survey dump is invoked in parallel. Fix this by returning
> cumulative results, that don't depend on the last invocation. Other
> drivers, e.g. ath9k or mt76 also use this behavior.
> 
> Signed-off-by: Markus Theil <markus.theil@tu-ilmenau.de>
> ---
>  drivers/net/wireless/ath/ath11k/wmi.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/wmi.c
> b/drivers/net/wireless/ath/ath11k/wmi.c
> index c2a972377687..322ddfda5bfd 100644
> --- a/drivers/net/wireless/ath/ath11k/wmi.c
> +++ b/drivers/net/wireless/ath/ath11k/wmi.c
> @@ -5610,16 +5610,16 @@ ath11k_pdev_bss_chan_info_event(struct
> ath11k_base *ab, struct sk_buff *skb)
> 
>  	survey = &ar->survey[idx];
> 
> -	survey->noise     = bss_ch_info_ev.noise_floor;
> -	survey->time      = div_u64(total, cc_freq_hz);
> -	survey->time_busy = div_u64(busy, cc_freq_hz);
> -	survey->time_rx   = div_u64(rx_bss, cc_freq_hz);
> -	survey->time_tx   = div_u64(tx, cc_freq_hz);
> -	survey->filled   |= (SURVEY_INFO_NOISE_DBM |
> -			     SURVEY_INFO_TIME |
> -			     SURVEY_INFO_TIME_BUSY |
> -			     SURVEY_INFO_TIME_RX |
> -			     SURVEY_INFO_TIME_TX);
> +	survey->noise      = bss_ch_info_ev.noise_floor;
> +	survey->time      += div_u64(total, cc_freq_hz);
> +	survey->time_busy += div_u64(busy, cc_freq_hz);
> +	survey->time_rx   += div_u64(rx_bss, cc_freq_hz);
> +	survey->time_tx   += div_u64(tx, cc_freq_hz);
> +	survey->filled    |= (SURVEY_INFO_NOISE_DBM |
> +			      SURVEY_INFO_TIME |
> +			      SURVEY_INFO_TIME_BUSY |
> +			      SURVEY_INFO_TIME_RX |
> +			      SURVEY_INFO_TIME_TX);

Markus,

It depends on type of survey request is given to firmware. In ath11k, 
firmware reports
accumulated values. So the above addition is wrong and report double 
value. Have you
tested this change?

-Rajkumar
