Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB63633C266
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Mar 2021 17:44:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbhCOQnq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 15 Mar 2021 12:43:46 -0400
Received: from z11.mailgun.us ([104.130.96.11]:14068 "EHLO z11.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231228AbhCOQnY (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 15 Mar 2021 12:43:24 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1615826603; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=O3GddaTorDxtMtita3ja9xGI7KqGP0j1IgkbeqTfA2Y=;
 b=MhNPwrRf55/xeuSauxRC1f4XEzPfm7FeFZ7VITgG32S+lHtYc84sGAg91v0LbM29XIkxgVOg
 EfyoJTGGned6B5A54c0+y6rHvQl5AjCL9WXOa8OrbDr8MfRYJfDvFlveKjIPVXSPiQjIkCfd
 qfXdy72pYsTawY+lOoFJEkXOHW4=
X-Mailgun-Sending-Ip: 104.130.96.11
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 604f8e99e3fca7d0a67fde38 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 15 Mar 2021 16:43:05
 GMT
Sender: periyasa=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E4723C43462; Mon, 15 Mar 2021 16:43:04 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: periyasa)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 35A8EC433CA;
        Mon, 15 Mar 2021 16:43:04 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 15 Mar 2021 22:13:04 +0530
From:   Karthikeyan periyasamy <periyasa@codeaurora.org>
To:     Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Miles Hu <milehu@codeaurora.org>,
        John Crispin <john@phrozen.org>,
        pradeepc=codeaurora.org@codeaurora.org
Subject: Re: [PATCH v7 1/3] ath11k: switch to using ieee80211_tx_status_ext()
In-Reply-To: <20210305230337.23047-2-pradeepc@codeaurora.org>
References: <20210305230337.23047-1-pradeepc@codeaurora.org>
 <20210305230337.23047-2-pradeepc@codeaurora.org>
Message-ID: <65a8f70609a1758611c97205abd205f2@codeaurora.org>
X-Sender: periyasa@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> --- a/drivers/net/wireless/ath/ath11k/dp_tx.c
> +++ b/drivers/net/wireless/ath/ath11k/dp_tx.c
> @@ -417,9 +417,12 @@ static void ath11k_dp_tx_complete_msdu(struct 
> ath11k *ar,
>  				       struct sk_buff *msdu,
>  				       struct hal_tx_status *ts)
>  {
> +	struct ieee80211_tx_status status = { 0 };
>  	struct ath11k_base *ab = ar->ab;
>  	struct ieee80211_tx_info *info;
>  	struct ath11k_skb_cb *skb_cb;
> +	struct ath11k_peer *peer;
> +	struct ath11k_sta *arsta;
> 
>  	if (WARN_ON_ONCE(ts->buf_rel_source != HAL_WBM_REL_SRC_MODULE_TQM)) {
>  		/* Must not happen */
> @@ -483,13 +486,22 @@ static void ath11k_dp_tx_complete_msdu(struct 
> ath11k *ar,
>  		ath11k_dp_tx_cache_peer_stats(ar, msdu, ts);
>  	}
> 
> -	/* NOTE: Tx rate status reporting. Tx completion status does not have
> -	 * necessary information (for example nss) to build the tx rate.
> -	 * Might end up reporting it out-of-band from HTT stats.
> -	 */
> -
> -	ieee80211_tx_status(ar->hw, msdu);
> -
> +	spin_lock_bh(&ab->base_lock);
> +	peer = ath11k_peer_find_by_id(ab, ts->peer_id);
> +	if (peer) {
> +		arsta = (struct ath11k_sta *)peer->sta->drv_priv;
> +		status.sta = peer->sta;
> +		status.skb = msdu;
> +		status.info = info;
> +		status.rate = &arsta->last_txrate;
> +	}
> +	rcu_read_unlock();
> +	if (peer)
> +		ieee80211_tx_status_ext(ar->hw, &status);
> +	else
> +		dev_kfree_skb_any(msdu);
> +	spin_unlock_bh(&ab->base_lock);

Why ieee80211_tx_status_ext() kept under spin_lock?

Thanks,
Karthikeyan P
