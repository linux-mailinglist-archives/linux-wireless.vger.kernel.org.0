Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90EC43E7CE0
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Aug 2021 17:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242547AbhHJPzK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 10 Aug 2021 11:55:10 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:59415 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236347AbhHJPzK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 10 Aug 2021 11:55:10 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1628610888; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=0EHxLVlZlJBMo/aM7aac2qrxctgwztSCU2PKgDLdGHw=;
 b=BAcIfVYzLbztdgxlFBsIkNskSfm9Qf1RHvnUxZsJc+Y7dt9R8eGo0TkmnHWtIFzg69FP6UE3
 53+YowcGf3D+HE5LAJDzCtY1qr9S686AUpLSPp/Mj4E9N/OOPKjeTGR4o4L3g+paOZk/udng
 LchVHTk4tGPOmunxMKxxQIbQ+uo=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 6112a13e454b7a558ffe7f0d (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 10 Aug 2021 15:54:38
 GMT
Sender: jjohnson=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 42256C4338A; Tue, 10 Aug 2021 15:54:38 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: jjohnson)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8E2C9C433F1;
        Tue, 10 Aug 2021 15:54:37 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 10 Aug 2021 08:54:37 -0700
From:   Jeff Johnson <jjohnson@codeaurora.org>
To:     Maharaja Kennadyrajan <mkenna@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        ath11k <ath11k-bounces@lists.infradead.org>
Subject: Re: [PATCH v5 3/3] ath11k: Add support for beacon tx mode
In-Reply-To: <1628585783-21139-4-git-send-email-mkenna@codeaurora.org>
References: <1628585783-21139-1-git-send-email-mkenna@codeaurora.org>
 <1628585783-21139-4-git-send-email-mkenna@codeaurora.org>
Message-ID: <f5df29c9e3322a82198bf21689779326@codeaurora.org>
X-Sender: jjohnson@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021-08-10 01:56, Maharaja Kennadyrajan wrote:
> Add support to configure the beacon tx mode in
> the driver.
> 
> Beacons can be sent out in burst(continuously in a single shot
> one after another) or staggered (equally spread out over beacon
> interval) mode.
> 
> Use the below configuration in the hostapd/wpa_supplicant
> for AP/MESH mode to configure the beacon tx mode.
> 
> "beacon_tx_mode=N", where N = 1 for STAGGERED beacon mode
> and N = 2 for BURST beacon mode.
> 
> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.5.0.1-00480-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Maharaja Kennadyrajan <mkenna@codeaurora.org>
> ---
>  drivers/net/wireless/ath/ath11k/mac.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/mac.c
> b/drivers/net/wireless/ath/ath11k/mac.c
> index e9b3689..2eda788 100644
> --- a/drivers/net/wireless/ath/ath11k/mac.c
> +++ b/drivers/net/wireless/ath/ath11k/mac.c
> @@ -2136,7 +2136,10 @@ static void 
> ath11k_mac_op_bss_info_changed(struct
> ieee80211_hw *hw,
> 
>  	if (changed & BSS_CHANGED_BEACON) {
>  		param_id = WMI_PDEV_PARAM_BEACON_TX_MODE;
> -		param_value = WMI_BEACON_STAGGERED_MODE;
> +		if (info->beacon_tx_mode == NL80211_BEACON_BURST_MODE)
> +			param_value = WMI_BEACON_BURST_MODE;
> +		else
> +			param_value = WMI_BEACON_STAGGERED_MODE;
>  		ret = ath11k_wmi_pdev_set_param(ar, param_id,
>  						param_value,
> ar->pdev->pdev_id);
>  		if (ret)
> @@ -2144,8 +2147,9 @@ static void ath11k_mac_op_bss_info_changed(struct
> ieee80211_hw *hw,
>  				    arvif->vdev_id);
>  		else
>  			ath11k_dbg(ar->ab, ATH11K_DBG_MAC,
> -				   "Set staggered beacon mode for VDEV:
> %d\n",
> -				   arvif->vdev_id);
> +				   "Set %s beacon mode for VDEV: %d mode:
> %d\n",
> +				   param_value ? "burst" : "staggered",

Suggest this should be param_value == WMI_BEACON_BURST_MODE ?
or other similar logic since ideally code should avoid making 
assumptions about the values assigned to enumerators

> +				   arvif->vdev_id, param_value);
> 
>  		ret = ath11k_mac_setup_bcn_tmpl(arvif);
>  		if (ret)
> --
> 2.7.4

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
Forum,
a Linux Foundation Collaborative Project
