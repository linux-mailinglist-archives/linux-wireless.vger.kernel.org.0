Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49D03226D07
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Jul 2020 19:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729003AbgGTRTe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Jul 2020 13:19:34 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:22341 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728654AbgGTRTe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Jul 2020 13:19:34 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1595265573; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=EL36CV+TYt/E4EVM/3b+OwT9aaaTbLsaXn5rhtHObv4=; b=wgbtM1eBTCy9SSpVFpDLNrVs02aYPpwClIyTDGSk66WfnCFiAq5nkrcGSYTTVgxHOqBRieDY
 sIPyL15ekGJpYJfdcCXQjkYd1L9o7X1McHmLfriYvC1Ozbxlu9q3ymsMSTI+3O1IggXb6L2w
 xpdK87IfIdKXsicnI0RD0C/WeDk=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n16.prod.us-east-1.postgun.com with SMTP id
 5f15d224c7a053446a99524a (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 20 Jul 2020 17:19:32
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id ACF10C433CB; Mon, 20 Jul 2020 17:19:31 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from tynnyri.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 35636C433C9;
        Mon, 20 Jul 2020 17:19:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 35636C433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Loic Poulain <loic.poulain@linaro.org>
Cc:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH 2/4] wcn36xx: Add TX ack support
References: <1593524821-32115-1-git-send-email-loic.poulain@linaro.org>
        <1593524821-32115-2-git-send-email-loic.poulain@linaro.org>
Date:   Mon, 20 Jul 2020 20:19:28 +0300
In-Reply-To: <1593524821-32115-2-git-send-email-loic.poulain@linaro.org> (Loic
        Poulain's message of "Tue, 30 Jun 2020 15:46:59 +0200")
Message-ID: <875zaiayu7.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Loic Poulain <loic.poulain@linaro.org> writes:

> The controller is capable of reporting TX indication which can be used
> to report TX ack. It was only partially implemented.
>
> Signed-off-by: Loic Poulain <loic.poulain@linaro.org>

[...]

> +static void wcn36xx_dxe_tx_timer(struct timer_list *t)
> +{
> +	struct wcn36xx *wcn = from_timer(wcn, t, tx_ack_timer);
> +	struct ieee80211_tx_info *info;
> +	unsigned long flags;
> +	struct sk_buff *skb;
> +
> +	/* TX Timeout */
> +	wcn36xx_dbg(WCN36XX_DBG_DXE, "TX timeout\n");
> +
> +	spin_lock_irqsave(&wcn->dxe_lock, flags);
> +	skb = wcn->tx_ack_skb;
> +	wcn->tx_ack_skb = NULL;
> +	spin_unlock_irqrestore(&wcn->dxe_lock, flags);
> +
> +	if (!skb)
> +		return;
> +
> +	info = IEEE80211_SKB_CB(skb);
> +	info->flags &= ~IEEE80211_TX_STAT_ACK;
> +	info->flags &= ~IEEE80211_TX_STAT_NOACK_TRANSMITTED;
> +
> +	ieee80211_tx_status_irqsafe(wcn->hw, skb);
> +	ieee80211_wake_queues(wcn->hw);
> +}

What's this timer thing? The commit log mentions nothing about that. To
me this looks like a some kind of TX timeout detection and has nothing
to do ACK handling, but of course I might have misunderstood.

Should it be in a separate patch to follow one logical change per patch
rule?

> --- a/drivers/net/wireless/ath/wcn36xx/smd.c
> +++ b/drivers/net/wireless/ath/wcn36xx/smd.c
> @@ -45,8 +45,8 @@ static struct wcn36xx_cfg_val wcn36xx_cfg_vals[] = {
>  	WCN36XX_CFG_VAL(MAX_MEDIUM_TIME, 6000),
>  	WCN36XX_CFG_VAL(MAX_MPDUS_IN_AMPDU, 64),
>  	WCN36XX_CFG_VAL(RTS_THRESHOLD, 2347),
> -	WCN36XX_CFG_VAL(SHORT_RETRY_LIMIT, 6),
> -	WCN36XX_CFG_VAL(LONG_RETRY_LIMIT, 6),
> +	WCN36XX_CFG_VAL(SHORT_RETRY_LIMIT, 15),
> +	WCN36XX_CFG_VAL(LONG_RETRY_LIMIT, 15),

Also there's no mention of these changes in the commit log. Should these
in a third patch as they are more like a separate change?

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
