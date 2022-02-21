Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE7F04BE107
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Feb 2022 18:52:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355453AbiBULRD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Feb 2022 06:17:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355832AbiBULPP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Feb 2022 06:15:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4963D13D
        for <linux-wireless@vger.kernel.org>; Mon, 21 Feb 2022 02:52:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DB5D261140
        for <linux-wireless@vger.kernel.org>; Mon, 21 Feb 2022 10:52:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D59DC340E9;
        Mon, 21 Feb 2022 10:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645440777;
        bh=HIwMS/QNmvIMrz2nkQTGWNzTOiKAHN4AXscIkZ5Atok=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=T5Zf17Dz54lD0Rf+lQjYJQI+6ZQ2+2KyoGb/fBLlV+Ed+qifsoexD3HImjmet6S1N
         aGrvk0LE52G2zPN6Hck0OFR8ewBnJRdFOEzpPXmzM+J7LEbMeXMGrxd96uW9oWUT3i
         IOY1C0oBK/JGPq7/EuS3kZeGbUAMzh3+1TSxUh65ksmLHnd1jcJcI0CRhjEXthnsC8
         i/Fw5BNRQ0H9ajSiZNcPOH0drAjDvttuvyKaNvBrwm4UmdXsCLOhrPz4ha93Ow5gfp
         Cognp3cQ4Q3zIhFA99zHBS80z68YUj9kAn7f96KtLxmjmUKydUwoALndFuwb5tuZWO
         lVRMDNt2/BSfw==
From:   Kalle Valo <kvalo@kernel.org>
To:     Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Miles Hu <milehu@codeaurora.org>,
        John Crispin <john@phrozen.org>
Subject: Re: [PATCH v10 1/3] ath11k: switch to using ieee80211_tx_status_ext()
References: <20220217012112.31211-1-pradeepc@codeaurora.org>
        <20220217012112.31211-2-pradeepc@codeaurora.org>
Date:   Mon, 21 Feb 2022 12:52:50 +0200
In-Reply-To: <20220217012112.31211-2-pradeepc@codeaurora.org> (Pradeep Kumar
        Chitrapu's message of "Wed, 16 Feb 2022 17:21:10 -0800")
Message-ID: <87ley4wkxp.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Pradeep Kumar Chitrapu <pradeepc@codeaurora.org> writes:

> This allows us to pass HE rates down into the stack.
>
> Co-developed-by: Miles Hu <milehu@codeaurora.org>
> Signed-off-by: Miles Hu <milehu@codeaurora.org>
> Signed-off-by: John Crispin <john@phrozen.org>
> Signed-off-by: Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
> ---
>  drivers/net/wireless/ath/ath11k/dp_tx.c | 32 +++++++++++++++++++++----
>  1 file changed, 27 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/net/wireless/ath/ath11k/dp_tx.c b/drivers/net/wireless/ath/ath11k/dp_tx.c
> index c7d7631efa5a..6f553a870e70 100644
> --- a/drivers/net/wireless/ath/ath11k/dp_tx.c
> +++ b/drivers/net/wireless/ath/ath11k/dp_tx.c
> @@ -519,9 +519,13 @@ static void ath11k_dp_tx_complete_msdu(struct ath11k *ar,
>  				       struct sk_buff *msdu,
>  				       struct hal_tx_status *ts)
>  {
> +	struct ieee80211_tx_status status = { 0 };
>  	struct ath11k_base *ab = ar->ab;
>  	struct ieee80211_tx_info *info;
>  	struct ath11k_skb_cb *skb_cb;
> +	struct ath11k_peer *peer;
> +	struct ath11k_sta *arsta;
> +	struct rate_info rate;
>  
>  	if (WARN_ON_ONCE(ts->buf_rel_source != HAL_WBM_REL_SRC_MODULE_TQM)) {
>  		/* Must not happen */
> @@ -584,12 +588,30 @@ static void ath11k_dp_tx_complete_msdu(struct ath11k *ar,
>  		ath11k_dp_tx_cache_peer_stats(ar, msdu, ts);
>  	}
>  
> -	/* NOTE: Tx rate status reporting. Tx completion status does not have
> -	 * necessary information (for example nss) to build the tx rate.
> -	 * Might end up reporting it out-of-band from HTT stats.
> -	 */
> +	spin_lock_bh(&ab->base_lock);
> +	peer = ath11k_peer_find_by_id(ab, ts->peer_id);
> +	if (!peer || !peer->sta) {
> +		ath11k_dbg(ab, ATH11K_DBG_DATA,
> +			   "dp_tx: failed to find the peer with peer_id %d\n",
> +			    ts->peer_id);
> +		spin_unlock_bh(&ab->base_lock);
> +		dev_kfree_skb_any(msdu);
> +		goto exit;
> +	}
> +	arsta = (struct ath11k_sta *)peer->sta->drv_priv;
> +	status.sta = peer->sta;
> +	status.skb = msdu;
> +	status.info = info;
> +	rate = arsta->last_txrate;
> +	status.rate = &rate;
>  
> -	ieee80211_tx_status(ar->hw, msdu);
> +	spin_unlock_bh(&ab->base_lock);
> +	rcu_read_unlock();
> +
> +	ieee80211_tx_status_ext(ar->hw, &status);
> +	return;
> +exit:
> +	rcu_read_unlock();
>  }

This patch gives a warning:

drivers/net/wireless/ath/ath11k/dp_tx.c:600:9: warning: context imbalance in 'ath11k_dp_tx_complete_msdu' - unexpected unlock

I don't understand why there's rcu_read_unlock() so in the pending
branch I removed both of the calls and also the exit label.

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=cb63b88dca170d9de9ff30a546e08917e91c6f05

Please check my changes.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
