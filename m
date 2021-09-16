Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B13540D5A0
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Sep 2021 11:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235240AbhIPJPb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Sep 2021 05:15:31 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:45086 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235160AbhIPJPb (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Sep 2021 05:15:31 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1631783651; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=GK5RrJBohqVNyxkCsNpqXozYtZFMscFYkIM9WyaOMZQ=; b=eDPla5BPXcm9Twcf7I2l70l8IjO4cXe2q5y/X6LrOkx0jv6Uo1ATiEZit1cO1wC/5EyolyE9
 UlfX/y8JOSu+WicydT4RPbDlwVR31ns9/TTu0VnmM44iTIXnNM1o0WGLENr6eSJiF1fh/vIq
 B6gzyuPAwWh4T/VMqtuCenbBIf0=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 61430ae1ec62f57c9a06e096 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 16 Sep 2021 09:14:09
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 2C62BC4360C; Thu, 16 Sep 2021 09:14:08 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4CFDEC4338F;
        Thu, 16 Sep 2021 09:14:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 4CFDEC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Jouni Malinen <jouni@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Sathishkumar Muruganandam <murugana@codeaurora.org>
Subject: Re: [PATCH 1/2] ath11k: fix 4-addr tx failure for AP and STA modes
References: <20210720213147.90042-1-jouni@codeaurora.org>
Date:   Thu, 16 Sep 2021 12:14:02 +0300
In-Reply-To: <20210720213147.90042-1-jouni@codeaurora.org> (Jouni Malinen's
        message of "Wed, 21 Jul 2021 00:31:46 +0300")
Message-ID: <87wnngzxut.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Jouni Malinen <jouni@codeaurora.org> writes:

> From: Sathishkumar Muruganandam <murugana@codeaurora.org>
>
> Ath11k FW requires peer parameter WMI_PEER_USE_4ADDR to be set for
> 4-addr peers allowing 4-address frame transmission to those peers.
>
> Add ath11k driver callback for sta_set_4addr() to queue new workq
> set_4addr_wk only once based on new boolean, use_4addr_set.
>
> sta_set_4addr() will be called during 4-addr STA association cases
> applicable for both AP and STA modes.
>
> In ath11k_sta_set_4addr_wk(),
>
> AP mode:
>         WMI_PEER_USE_4ADDR will be set for the corresponding
>         associated 4-addr STA(s)
>
> STA mode:
>         WMI_PEER_USE_4ADDR will be set for the AP to which the
>         4-addr STA got associated.
>
> Tested-on: IPQ8074 WLAN.HK.2.1.0.1-01238-QCAHKSWPL_SILICONZ-1
>
> Signed-off-by: Sathishkumar Muruganandam <murugana@codeaurora.org>
> Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
> ---
>  drivers/net/wireless/ath/ath11k/core.h |  3 ++
>  drivers/net/wireless/ath/ath11k/mac.c  | 48 ++++++++++++++++++++++++--
>  2 files changed, 49 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
> index 018fb2385f2a..11c8dffd0236 100644
> --- a/drivers/net/wireless/ath/ath11k/core.h
> +++ b/drivers/net/wireless/ath/ath11k/core.h
> @@ -362,6 +362,7 @@ struct ath11k_sta {
>  	enum hal_pn_type pn_type;
>  
>  	struct work_struct update_wk;
> +	struct work_struct set_4addr_wk;
>  	struct rate_info txrate;
>  	struct rate_info last_txrate;
>  	u64 rx_duration;
> @@ -374,6 +375,8 @@ struct ath11k_sta {
>  	/* protected by conf_mutex */
>  	bool aggr_mode;
>  #endif
> +
> +	bool use_4addr_set;
>  };

[...]

> +static void ath11k_mac_op_sta_set_4addr(struct ieee80211_hw *hw,
> +					struct ieee80211_vif *vif,
> +					struct ieee80211_sta *sta, bool enabled)
> +{
> +	struct ath11k *ar = hw->priv;
> +	struct ath11k_sta *arsta = (struct ath11k_sta *)sta->drv_priv;
> +
> +	if (enabled && !arsta->use_4addr_set) {
> +		ieee80211_queue_work(ar->hw, &arsta->set_4addr_wk);
> +		arsta->use_4addr_set = true;
> +	}
> +}

There's no locking for accessing arsta->use_4addr_set. Most likely it's
just a theoretical issue but wanted to point out anyway. Maybe mac80211
handles serialisation of this callback?

I'm going to apply this patch anyway so that I get my patch queue
smaller, we can fix any issues in a followup patch.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
