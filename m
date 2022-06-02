Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9812153BB35
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jun 2022 16:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236248AbiFBOv3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 2 Jun 2022 10:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236247AbiFBOvU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 2 Jun 2022 10:51:20 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E24762ACB55
        for <linux-wireless@vger.kernel.org>; Thu,  2 Jun 2022 07:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1654181476; x=1685717476;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qcwQFVtmq8r0vhU/0TOaqMOXjETEKJUk2tflWPRaOcA=;
  b=K4IoWAe7d0iYWnG8WVoag6W5J8Fz3+YZQL3VS3G0M4jqHSzLBek5APBa
   pOHgTTTkjID1vmJITO41IsfPa8wslDafBKMEwrIUidQJsxfV61PKGruvS
   wdaw+O2+KilnuXYy0nAOcAMYeERLZN9jA9eFR0iIfPRWQegbbUxxvEpP6
   U=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 02 Jun 2022 07:51:16 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2022 07:51:16 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 2 Jun 2022 07:51:15 -0700
Received: from [10.110.9.238] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 2 Jun 2022
 07:51:14 -0700
Message-ID: <f6414575-6a9c-2e8a-dbb9-68680aca8822@quicinc.com>
Date:   Thu, 2 Jun 2022 07:51:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 2/2] ath11k: add get_txpower mac ops
Content-Language: en-US
To:     Aditya Kumar Singh <quic_adisi@quicinc.com>,
        <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
References: <20220602051425.9265-1-quic_adisi@quicinc.com>
 <20220602051425.9265-3-quic_adisi@quicinc.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20220602051425.9265-3-quic_adisi@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 6/1/2022 10:14 PM, Aditya Kumar Singh wrote:
> Driver does not support get_txpower mac ops because of which
> cfg80211 returns vif->bss_conf.txpower to user space. bss_conf.txpower
> gets its value from ieee80211_channel->max_reg_power. However, the final
> txpower is dependent on few other parameters apart from max regulatory
> supported power. It is the firmware which knows about all these
> parameters and considers the minimum for each packet transmission.
> 
> All ath11k firmware reports the final tx power in firmware pdev stats
> which falls under fw_stats.
> 
> Add get_txpower mac ops to get the tx power from firmware leveraging
> fw_stats and return it accordingly.
> 
> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.5.0.1-01100-QCAHKSWPL_SILICONZ-1
> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.5.0.1-01100-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3
> 
> Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
> ---
>   drivers/net/wireless/ath/ath11k/mac.c | 91 +++++++++++++++++++++++++++
>   1 file changed, 91 insertions(+)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
> index f11956163822..f2502ce7deac 100644
> --- a/drivers/net/wireless/ath/ath11k/mac.c
> +++ b/drivers/net/wireless/ath/ath11k/mac.c
> @@ -8471,6 +8471,94 @@ static int ath11k_mac_op_remain_on_channel(struct ieee80211_hw *hw,
>   	return ret;
>   }
>   
> +static int ath11k_fw_stats_request(struct ath11k *ar,
> +				   struct stats_request_params *req_param)
> +{
> +	struct ath11k_base *ab = ar->ab;
> +	unsigned long time_left;
> +	int ret;
> +
> +	lockdep_assert_held(&ar->conf_mutex);
> +
> +	spin_lock_bh(&ar->data_lock);
> +	ar->fw_stats_done = false;
> +	ath11k_fw_stats_pdevs_free(&ar->fw_stats.pdevs);
> +	spin_unlock_bh(&ar->data_lock);
> +
> +	reinit_completion(&ar->fw_stats_complete);
> +
> +	ret = ath11k_wmi_send_stats_request_cmd(ar, req_param);
> +	if (ret) {
> +		ath11k_warn(ab, "could not request fw stats (%d)\n",
> +			    ret);
> +		return ret;
> +	}
> +
> +	time_left = wait_for_completion_timeout(&ar->fw_stats_complete,
> +						1 * HZ);
> +
> +	if (!time_left)
> +		return -ETIMEDOUT;
> +
> +	return 0;
> +}
> +
> +static int ath11k_mac_op_get_txpower(struct ieee80211_hw *hw,
> +				     struct ieee80211_vif *vif,
> +				     int *dbm)
> +{
> +	struct ath11k *ar = hw->priv;
> +	struct ath11k_base *ab = ar->ab;
> +	struct stats_request_params req_param;

suggest you use an = {} initializer here.

> +	struct ath11k_fw_stats_pdev *pdev;
> +	int ret;
> +
> +	/* Final Tx power is minimum of Target Power, CTL power, Regulatory
> +	 * Power, PSD EIRP Power. We just know the Regulatory power from the
> +	 * regulatory rules obtained. FW knows all these power and sets the min
> +	 * of these. Hence, we request the FW pdev stats in which FW reports
> +	 * the minimum of all vdev's channel Tx power.
> +	 */
> +	mutex_lock(&ar->conf_mutex);
> +
> +	if (ar->state != ATH11K_STATE_ON)
> +		goto err_fallback;
> +
> +	req_param.pdev_id = ar->pdev->pdev_id;
> +	req_param.vdev_id = 0;

and remove this explicit setting of an unused param to 0 since it will 
not be needed if the entire struct is zeroed. the reason for this 
approach is that if, in the future, any additional fields are added to 
the struct, you don't want to have a situation where you forget to add 
code to clear the new fields, and as a result you potentially leak stack 
memory contents to firmware, which is a security hole.

> +	req_param.stats_id = WMI_REQUEST_PDEV_STAT;
> +
> +	ret = ath11k_fw_stats_request(ar, &req_param);
> +	if (ret) {
> +		ath11k_warn(ab, "failed to request fw pdev stats: %d\n", ret);
> +		goto err_fallback;
> +	}
> +
> +	spin_lock_bh(&ar->data_lock);
> +	pdev = list_first_entry_or_null(&ar->fw_stats.pdevs,
> +					struct ath11k_fw_stats_pdev, list);
> +	if (!pdev) {
> +		spin_unlock_bh(&ar->data_lock);
> +		goto err_fallback;
> +	}
> +
> +	/* tx power is set as 2 units per dBm in FW. */
> +	*dbm = pdev->chan_tx_power / 2;
> +
> +	spin_unlock_bh(&ar->data_lock);
> +	mutex_unlock(&ar->conf_mutex);
> +
> +	ath11k_dbg(ar->ab, ATH11K_DBG_MAC, "%s: txpower: %d from fw\n", __func__, *dbm);

IMO this is misleading. technically pdev->chan_tx_power is the txpower 
from firmware, *dbm is the derived power after converting units. maybe 
that is splitting hairs, but when debugging issues you usually want to 
be very clear about what is the raw data and what is the calculated data

Also follow ath11k coding style for debug messages (which follows 
ath10k) which does not allow colons

so I'd suggest "txpower from firmware %d reported %d"

> +	return 0;
> +
> +err_fallback:
> +	mutex_unlock(&ar->conf_mutex);
> +	/* We didn't get txpower from FW. Hence, relying on vif->bss_conf.txpower */
> +	*dbm = vif->bss_conf.txpower;
> +	ath11k_dbg(ar->ab, ATH11K_DBG_MAC, "%s: txpower from bss_conf\n", __func__);

I'd log *dbm here as well

> +	return 0;
> +}
> +
>   static const struct ieee80211_ops ath11k_ops = {
>   	.tx				= ath11k_mac_op_tx,
>   	.start                          = ath11k_mac_op_start,
> @@ -8521,6 +8609,7 @@ static const struct ieee80211_ops ath11k_ops = {
>   #if IS_ENABLED(CONFIG_IPV6)
>   	.ipv6_addr_change = ath11k_mac_op_ipv6_changed,
>   #endif
> +	.get_txpower                    = ath11k_mac_op_get_txpower,
>   
>   	.set_sar_specs			= ath11k_mac_op_set_bios_sar_specs,
>   	.remain_on_channel		= ath11k_mac_op_remain_on_channel,
> @@ -9129,6 +9218,8 @@ int ath11k_mac_allocate(struct ath11k_base *ab)
>   		clear_bit(ATH11K_FLAG_MONITOR_VDEV_CREATED, &ar->monitor_flags);
>   		ar->vdev_id_11d_scan = ATH11K_11D_INVALID_VDEV_ID;
>   		init_completion(&ar->completed_11d_scan);
> +
> +		ath11k_fw_stats_init(ar);
>   	}
>   
>   	return 0;

