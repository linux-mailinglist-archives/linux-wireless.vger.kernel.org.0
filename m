Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25B4B413340
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Sep 2021 14:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231799AbhIUMQb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Sep 2021 08:16:31 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:50320 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbhIUMQa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Sep 2021 08:16:30 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1632226501; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=Qa8YpI5GcR223JNcE4rFrVQd6SC5DSUEIG/mknI93ho=; b=kKS/5sUOZ0cN0cTmrg71z67EV3CuAs55llOQ/JfMr2IGhfSo8FBo4VwV3GZ43iYX90wB3OLp
 9DUXhdF1Ky0toLnXg/ek2c/DhmK8kX1cGEZa1E9GXgc4ovW9m69X7IpNCQSTgdrI1H9DF4oe
 FdmRQL+5TViXXPMPI/BCki0MiZU=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 6149cca9ec62f57c9ad9b457 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 21 Sep 2021 12:14:33
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E6D26C43460; Tue, 21 Sep 2021 12:14:32 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7E36DC4338F;
        Tue, 21 Sep 2021 12:14:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 7E36DC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Jouni Malinen <jouni@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Seevalamuthu Mariappan <seevalam@codeaurora.org>,
        Miles Hu <milehu@codeaurora.org>,
        Vasanthakumar Thiagarajan <vthiagar@codeaurora.org>
Subject: Re: [PATCH 3/3] ath11k: monitor mode clean up to use separate APIs
References: <20210721162053.46290-1-jouni@codeaurora.org>
        <20210721162053.46290-4-jouni@codeaurora.org>
Date:   Tue, 21 Sep 2021 15:14:26 +0300
In-Reply-To: <20210721162053.46290-4-jouni@codeaurora.org> (Jouni Malinen's
        message of "Wed, 21 Jul 2021 19:20:53 +0300")
Message-ID: <87ilyuunvh.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Jouni Malinen <jouni@codeaurora.org> writes:

> From: Seevalamuthu Mariappan <seevalam@codeaurora.org>
>
> If monitor interface is enabled in co-exist mode, only local traffic are
> captured. It's caused by missing monitor vdev in co-exist mode. So,
> monitor mode clean up is done with separate Monitor APIs. For this,
> introduce monitor_started and monitor_vdev_created boolean flags.
>
> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1-01725-QCAHKSWPL_SILICONZ-1
>
> Co-developed-by: Miles Hu <milehu@codeaurora.org>
> Signed-off-by: Miles Hu <milehu@codeaurora.org>
> Co-developed-by: Vasanthakumar Thiagarajan <vthiagar@codeaurora.org>
> Signed-off-by: Vasanthakumar Thiagarajan <vthiagar@codeaurora.org>
> Signed-off-by: Seevalamuthu Mariappan <seevalam@codeaurora.org>
> Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
> ---
>  drivers/net/wireless/ath/ath11k/core.h  |   5 --
>  drivers/net/wireless/ath/ath11k/dp_rx.c |   2 +-
>  drivers/net/wireless/ath/ath11k/dp_tx.c |   9 +-
>  drivers/net/wireless/ath/ath11k/mac.c   | 112 ++++++++++++++----------
>  4 files changed, 73 insertions(+), 55 deletions(-)
>
> diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
> index 3cddab695031..0ad5a935b52b 100644
> --- a/drivers/net/wireless/ath/ath11k/core.h
> +++ b/drivers/net/wireless/ath/ath11k/core.h
> @@ -192,10 +192,6 @@ enum ath11k_dev_flags {
>  	ATH11K_FLAG_HTC_SUSPEND_COMPLETE,
>  };
>  
> -enum ath11k_monitor_flags {
> -	ATH11K_FLAG_MONITOR_ENABLED,
> -};
> -
>  struct ath11k_vif {
>  	u32 vdev_id;
>  	enum wmi_vdev_type vdev_type;
> @@ -478,7 +474,6 @@ struct ath11k {
>  
>  	unsigned long dev_flags;
>  	unsigned int filter_flags;
> -	unsigned long monitor_flags;
>  	u32 min_tx_power;
>  	u32 max_tx_power;
>  	u32 txpower_limit_2g;
> diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
> index 9a224817630a..6fde70914e1a 100644
> --- a/drivers/net/wireless/ath/ath11k/dp_rx.c
> +++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
> @@ -5029,7 +5029,7 @@ int ath11k_dp_rx_process_mon_rings(struct ath11k_base *ab, int mac_id,
>  	struct ath11k *ar = ath11k_ab_to_ar(ab, mac_id);
>  	int ret = 0;
>  
> -	if (test_bit(ATH11K_FLAG_MONITOR_ENABLED, &ar->monitor_flags))
> +	if (ar->monitor_started)
>  		ret = ath11k_dp_mon_process_rx(ab, mac_id, napi, budget);
>  	else
>  		ret = ath11k_dp_rx_process_mon_status(ab, mac_id, napi, budget);

Moving from test_bit() to a boolean looks racy to me, I don't see how
monitor_started is serialised.

And why move away from monitor_flags and having separate booleans
anyway? I would monitor_conf_enabled and monitor_started from patch 2 to
use monitor_flags.

> @@ -1076,11 +1076,16 @@ int ath11k_dp_tx_htt_monitor_mode_ring_config(struct ath11k *ar, bool reset)
>  
>  	for (i = 0; i < ab->hw_params.num_rxmda_per_pdev; i++) {
>  		ring_id = dp->rx_mon_status_refill_ring[i].refill_buf_ring.ring_id;
> -		if (!reset)
> +		if (!reset) {
>  			tlv_filter.rx_filter =
>  					HTT_RX_MON_FILTER_TLV_FLAGS_MON_STATUS_RING;
> -		else
> +		} else {
>  			tlv_filter = ath11k_mac_mon_status_filter_default;
> +#ifdef CONFIG_ATH11K_DEBUGFS
> +			if (ar->debug.extd_rx_stats)
> +				tlv_filter.rx_filter = ar->debug.rx_filter;
> +#endif

This should use ath11k_debugfs_is_extd_rx_stats_enabled and
ath11k_debugfs_rx_filter(), then the ifdef is not needed.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
