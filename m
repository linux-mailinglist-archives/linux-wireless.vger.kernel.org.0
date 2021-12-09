Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E58AD46EAED
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Dec 2021 16:12:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235005AbhLIPQV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 Dec 2021 10:16:21 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:59584 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235018AbhLIPQU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 Dec 2021 10:16:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 553E0B82507
        for <linux-wireless@vger.kernel.org>; Thu,  9 Dec 2021 15:12:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 435D7C341D3;
        Thu,  9 Dec 2021 15:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639062765;
        bh=Ay1H3UkuOG3XRGF9LlD5nYbVi0tr6vvRkKWIqwX7qDs=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=BtPKqBqovhLSZqaKRWplYuFmNBfkkQhvChM6aVMKbNEWbZaEKtip4TCmmvpeudvOh
         Q7mUn620lNAsVSwPAXzPggIbFkSpg5umIZFZK87c2XAuVExrWxCpr/ccWf6ZWJCFqV
         J4//16qYH87kSWfkTVUd1Bna6aQq85GSfSKqL+ybnojBQmmrGqVioGV9K3ZFhURibo
         OBB6o0C6r9SVGqVFnAVdYqPm7SUpH6g6oe38lN/QGtn1OzkCj20oXARxrrzCq8O+Vk
         Oq+EjtT2xHKkGYANX13sJD6JJtnb2aVp1U638kOjd6VY0PLPAHxFnaoxTJ2XnGT72I
         HGDnsSKzd88vg==
From:   Kalle Valo <kvalo@kernel.org>
To:     Carl Huang <cjhuang@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH 4/6] ath11k: purge rx pktlog when entering WoW
References: <20211011193750.4891-1-cjhuang@codeaurora.org>
        <20211011193750.4891-5-cjhuang@codeaurora.org>
Date:   Thu, 09 Dec 2021 17:12:41 +0200
In-Reply-To: <20211011193750.4891-5-cjhuang@codeaurora.org> (Carl Huang's
        message of "Mon, 11 Oct 2021 15:37:48 -0400")
Message-ID: <87v8zxzuae.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Carl Huang <cjhuang@codeaurora.org> writes:

> This change is to purge rx pktlog when entering WoW and reap
> the mon_status buffer to keep it empty. When leaving WoW, host
> restarts the reap timer. In WoW state, it's not allowed to feed
> into mon_status rings per firmware request.

"per firmware request" is not clear for me. Do you "per firmware team's
recommendation" or what?

> @@ -327,12 +327,7 @@ int ath11k_core_resume(struct ath11k_base *ab)
>  	ath11k_hif_ce_irq_enable(ab);
>  	ath11k_hif_irq_enable(ab);
>  
> -	ret = ath11k_dp_rx_pktlog_start(ab);
> -	if (ret) {
> -		ath11k_warn(ab, "failed to start rx pktlog during resume: %d\n",
> -			    ret);
> -		return ret;
> -	}
> +	ath11k_dp_rx_pktlog_start(ab);

Why remove error handling? We should always handle the errors.

>  
>  	ret = ath11k_wow_wakeup(ab);
>  	if (ret) {
> diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
> index 6d769ba..ae6db5d 100644
> --- a/drivers/net/wireless/ath/ath11k/dp_rx.c
> +++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
> @@ -5105,13 +5105,11 @@ int ath11k_dp_rx_pdev_mon_detach(struct ath11k *ar)
>  	return 0;
>  }
>  
> -int ath11k_dp_rx_pktlog_start(struct ath11k_base *ab)
> +void ath11k_dp_rx_pktlog_start(struct ath11k_base *ab)
>  {
>  	/* start reap timer */
>  	mod_timer(&ab->mon_reap_timer,
>  		  jiffies + msecs_to_jiffies(ATH11K_MON_TIMER_INTERVAL));
> -
> -	return 0;
>  }

Ah, you remove it here as well. But for consistency it's better to have
this return an error code.

> @@ -640,6 +657,8 @@ int ath11k_wow_op_resume(struct ieee80211_hw *hw)
>  	ath11k_hif_ce_irq_enable(ar->ab);
>  	ath11k_hif_irq_enable(ar->ab);
>  
> +	ath11k_dp_rx_pktlog_start(ar->ab);

Error handling here as well, please.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
