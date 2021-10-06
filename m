Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89E534247DA
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Oct 2021 22:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239435AbhJFUWE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 6 Oct 2021 16:22:04 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:44558 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232273AbhJFUWD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 6 Oct 2021 16:22:03 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1633551611; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=qKnVoVXIJvpVlqQWbP2fBZsvjO2Pe2LOuGkd23cSLWw=;
 b=hDI2UHt5lKZv0P5hcvWO5Xkw5v6JecFGZ5er08HM6/acFMds5DDoaXwNS+l0Gc4ZV/tNAdDv
 CX3ml/hz3ShMOiCZWEqi3JfmO+wO3X0UFijnH8kw8fAsGeJXRVyu4G9TbATfa7O+mwWz77pb
 oDI7CupZkf9jmY2VawI3JIZVQt4=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 615e04fa30ce13d2b4afd8aa (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 06 Oct 2021 20:20:10
 GMT
Sender: alokad=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7D4E2C43460; Wed,  6 Oct 2021 20:20:10 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: alokad)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BD552C4338F;
        Wed,  6 Oct 2021 20:20:09 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 06 Oct 2021 13:20:09 -0700
From:   Aloka Dixit <alokad@codeaurora.org>
To:     johannes@sipsolutions.net, linux-wireless@vger.kernel.org
Cc:     alokad=codeaurora.org@codeaurora.org
Subject: Re: [v13 1/3] mac80211: split beacon retrieval functions
In-Reply-To: <20211006040938.9531-2-alokad@codeaurora.org>
References: <20211006040938.9531-1-alokad@codeaurora.org>
 <20211006040938.9531-2-alokad@codeaurora.org>
Message-ID: <ad3a3412669925daaa35c143f84172fb@codeaurora.org>
X-Sender: alokad@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021-10-05 21:09, Aloka Dixit wrote:
> Split __ieee80211_beacon_get() into a separate function for AP mode
> ieee80211_beacon_get_ap().
> Also, move the code common to all modes (AP, adhoc and mesh) to
> a separate function ieee80211_beacon_get_finish().
> 
> Signed-off-by: Aloka Dixit <alokad@codeaurora.org>
> ---
> v13:New addition to the patch series compared to v12.
> This change is added in a separate patch for better readability.
> 
>  net/mac80211/tx.c | 203 +++++++++++++++++++++++++++-------------------
>  1 file changed, 118 insertions(+), 85 deletions(-)
> 
> diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
> index 2d1193ed3eb5..ac9ab007dc6f 100644
> --- a/net/mac80211/tx.c
> +++ b/net/mac80211/tx.c
> @@ -4979,6 +4979,115 @@ static int ieee80211_beacon_protect(struct 
> sk_buff *skb,
>  	return 0;
>  }
> 
> +static void
> +ieee80211_beacon_get_finish(struct ieee80211_hw *hw,
> +			    struct ieee80211_vif *vif,
> +			    struct ieee80211_mutable_offsets *offs,
> +			    struct beacon_data *beacon,
> +			    struct sk_buff *skb,
> +			    struct ieee80211_chanctx_conf *chanctx_conf,
> +			    u16 csa_off_base)
> +{
> +	struct ieee80211_local *local = hw_to_local(hw);
> +	struct ieee80211_sub_if_data *sdata = vif_to_sdata(vif);
> +	struct ieee80211_tx_info *info;
> +	enum nl80211_band band;
> +	struct ieee80211_tx_rate_control txrc;
> +
> +	/* CSA offsets */
> +	if (offs && beacon) {
> +		u16 i;
> +
> +		for (i = 0; i < IEEE80211_MAX_CNTDWN_COUNTERS_NUM; i++) {
> +			u16 csa_off = beacon->cntdwn_counter_offsets[i];
> +
> +			if (!csa_off)
> +				continue;
> +
> +			offs->cntdwn_counter_offs[i] = csa_off_base + csa_off;
> +		}
> +	}
> +

I just now realized that the CSA offset part can be moved to the AP 
specific function.
ieee80211_beacon_get_finish() won't even need csa_off_base as an input 
in that case.
Will wait for other comments and then move it.
