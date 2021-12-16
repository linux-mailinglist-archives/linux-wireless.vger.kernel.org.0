Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A88384777A1
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Dec 2021 17:14:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239196AbhLPQOk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Dec 2021 11:14:40 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:56944 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239187AbhLPQOk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Dec 2021 11:14:40 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A17EA61EA1
        for <linux-wireless@vger.kernel.org>; Thu, 16 Dec 2021 16:14:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E76F4C36AE0;
        Thu, 16 Dec 2021 16:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639671279;
        bh=dW9UEJ00+2ZoS26s3TIVE02Hbze05eFfClOYNsdiXK8=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=ACMxJppFF3BQ77h0oCbzY7uM4xGeyI7B+wNH8DuEBeF1/fQUWDP5XsPut7BPRGJta
         V4uwG5feInmoQxySP6+b7zB0WrDnwZ9qZjNiE3jiCMTVaFF0r7dtp2GL1wrTg4NI3A
         rZ4WukeKU0xtJUBAWyyN83fDzAKnccykJ8q8zEfQ7Nl6dMZpAoOT5YNSFTR/202yng
         rV8XfU85cWsB6O0oKHzt+s3jmtA6AaAGyvN59Q3kChpk7renygreehV8GsJoIQEUdt
         mU19x5lsVssLohFKUOaz4tu+AyFJGAZsxSymzEpqC+Aw1yvkTrw7V9z2PtZyvlTxks
         1xTHZ+B5PjUQA==
From:   Kalle Valo <kvalo@kernel.org>
To:     Jonas Jelonek <jelonek.jonas@gmail.com>
Cc:     linux-wireless@vger.kernel.org, nbd@nbd.name,
        Thomas Huehn <thomas.huehn@hs-nordhausen.de>
Subject: Re: [PATCH] ath5k: switch to rate table based lookup
References: <20211215215042.637-1-jelonek.jonas@gmail.com>
Date:   Thu, 16 Dec 2021 18:14:34 +0200
In-Reply-To: <20211215215042.637-1-jelonek.jonas@gmail.com> (Jonas Jelonek's
        message of "Wed, 15 Dec 2021 22:50:42 +0100")
Message-ID: <87sfusbk7p.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Jonas Jelonek <jelonek.jonas@gmail.com> writes:

> Switching from legacy usage of ieee80211_get_tx_rates() lookup to direct
> rate table lookup in struct ieee80211_sta->rates.
>
> The current rate control API allows drivers to directly get rates from
> ieee80211_sta->rates. ath5k is currently one of the legacy drivers that
> perform translation/merge with the internal rate table via
> ieee80211_get_tx_rates provided by rate control API.
> For our upcoming changes to rate control API and the implementation of
> transmit power control, this patch changes the behaviour. The call to
> ieee80211_get_tx_rates and subsequent calls are also avoided. ath5k now
> directly reads rates from sta->rates into its internal rate table. Cause
> ath5k does not rely on the rate array in SKB->CB, this is not considered
> anymore except for the first entry (used for probing).
>
> Tested this on a PCEngines ALIX with CMP9-GP miniPCI wifi card (Atheros
> AR5213A). Generated traffic between AP and multiple STAs before and
> after applying the patch and simultaneously measured throughput and
> captured rc_stats. Comparison resulted in same rate selection and no
> performance loss between both runs.

Good that you explained how you tested this.

> @@ -753,8 +790,11 @@ ath5k_txbuf_setup(struct ath5k_hw *ah, struct ath5k_buf *bf,
>  	if (dma_mapping_error(ah->dev, bf->skbaddr))
>  		return -ENOSPC;
>  
> -	ieee80211_get_tx_rates(info->control.vif, (control) ? control->sta : NULL, skb, bf->rates,
> -			       ARRAY_SIZE(bf->rates));
> +	if (!ath5k_merge_ratetbl((control) ? control->sta : NULL, bf, info)) {
> +		ieee80211_get_tx_rates(info->control.vif,
> +			(control) ? control->sta : NULL, skb, bf->rates,
> +			ARRAY_SIZE(bf->rates));
> +	}

I'm not really a fan of ? operator, so in the pending branch I changed
this to use a normal if statement. Please double check that I didn't
break anything.

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=9e7c92df342f884434ccc8635d2606c1d1b11ef9

diff --git a/drivers/net/wireless/ath/ath5k/base.c b/drivers/net/wireless/ath/ath5k/base.c
index 647b3b76495c..66d123f48085 100644
--- a/drivers/net/wireless/ath/ath5k/base.c
+++ b/drivers/net/wireless/ath/ath5k/base.c
@@ -774,6 +774,7 @@ ath5k_txbuf_setup(struct ath5k_hw *ah, struct ath5k_buf *bf,
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
 	unsigned int pktlen, flags, keyidx = AR5K_TXKEYIX_INVALID;
 	struct ieee80211_rate *rate;
+	struct ieee80211_sta *sta;
 	unsigned int mrr_rate[3], mrr_tries[3];
 	int i, ret;
 	u16 hw_rate;
@@ -790,10 +791,15 @@ ath5k_txbuf_setup(struct ath5k_hw *ah, struct ath5k_buf *bf,
 	if (dma_mapping_error(ah->dev, bf->skbaddr))
 		return -ENOSPC;
 
-	if (!ath5k_merge_ratetbl((control) ? control->sta : NULL, bf, info)) {
+	if (control)
+		sta = control->sta;
+	else
+		sta = NULL;
+
+	if (!ath5k_merge_ratetbl(sta, bf, info)) {
 		ieee80211_get_tx_rates(info->control.vif,
-			(control) ? control->sta : NULL, skb, bf->rates,
-			ARRAY_SIZE(bf->rates));
+				       sta, skb, bf->rates,
+				       ARRAY_SIZE(bf->rates));
 	}
 
 	rate = ath5k_get_rate(ah->hw, info, bf, 0);

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
