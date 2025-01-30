Return-Path: <linux-wireless+bounces-18202-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E7BA228E3
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jan 2025 07:26:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 236DA7A2461
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jan 2025 06:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2178B33987;
	Thu, 30 Jan 2025 06:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="P0uJR9T+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BEEA1898FB
	for <linux-wireless@vger.kernel.org>; Thu, 30 Jan 2025 06:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738218356; cv=none; b=H52KCoDXufgyviQoaIXHmaRTy9NvAc5A1Ck1qbk8sCMqfzQHMjMOdjazQsByMQfTIVCRbq3KEEOqYt5c3HVDCCDXLWn+8FHCmPFzG1pJGZ5nZXdnfubVvrIfQfDbRMwLhHzhFKT+0ylCeTIf3jfBDD6Wqn3bbOhPzibBt9feMLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738218356; c=relaxed/simple;
	bh=UETKtBzljQsQ+NdSUGCS1q4IAo9HM7jeLw4E8Dz4YuY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Ql5kchpj/YK/b3d2y3bWY3rRgrNDLkXUD+3U/qjCuQ+99Z7xIzaI4vbZWXBqnRJDfW/tuaQdexX1UrzqbEceDCsgID+lBVSYvQoo/66eU0tn4fhmt2KEgpRddYveM17dxGxq3IjslytwEStwpWjwF1EV3PjmR3Xg0RCkGEzZzAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=P0uJR9T+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50U1wkB9031539;
	Thu, 30 Jan 2025 06:25:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mFk3sF9BM5sks/Z1xHdQKlRSwY4Ezpz3B0HB98/HDGg=; b=P0uJR9T+PAwnjj+N
	NIjGweZrr5KBRpuckY9ema8FVOdWGOtMcSaN1QOxlC2FvaT/Jr3ax+QL33dR5plI
	DdrDe7bl9iOGhicSG1shHmeRHnJqhg8IMtsy62lmlgUizJwTHGBDURx8KSoT+ZQb
	bKPoMPf4tNSE7iYuemALB9YvsosLvaW2I1h43pvDnaqta1jJB1YMBcVhbqOGN4Og
	DVLE9e0n0ESUgXTCPNTES85vmG0pju3XOo0rOlzS6CkMKpU5vxhldgChG89krNBt
	csmUf/s3ktrFtMaK/w/fH0Uv6u4X1kSGYUwc+IKqXII+LxiXC6seGiCnKx1j1cJH
	riO7Vg==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44g0830cxc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jan 2025 06:25:51 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50U6PoR6022216
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jan 2025 06:25:50 GMT
Received: from [10.216.38.203] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 29 Jan
 2025 22:25:47 -0800
Message-ID: <1dcc7a0a-1350-e761-2926-01c96c3a9e79@quicinc.com>
Date: Thu, 30 Jan 2025 11:55:44 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 2/2] wifi: ath12k: add get_txpower mac ops
Content-Language: en-US
To: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Aditya Kumar Singh
	<aditya.kumar.singh@oss.qualcomm.com>
References: <20250127172202.1410429-1-rameshkumar.sundaram@oss.qualcomm.com>
 <20250127172202.1410429-3-rameshkumar.sundaram@oss.qualcomm.com>
From: Mahendran P <quic_mahep@quicinc.com>
In-Reply-To: <20250127172202.1410429-3-rameshkumar.sundaram@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: fDwDJQaac664sAQaA_yhMSG8HjlPuXQc
X-Proofpoint-ORIG-GUID: fDwDJQaac664sAQaA_yhMSG8HjlPuXQc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-30_03,2025-01-29_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 clxscore=1015 adultscore=0 impostorscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501300047

On 1/27/2025 10:52 PM, Rameshkumar Sundaram wrote:
> From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
> 
> Driver does not support get_txpower mac ops because of which
> cfg80211 returns vif->bss_conf.txpower to user space. bss_conf.txpower
> gets its value from ieee80211_channel->max_reg_power. However, the final
> txpower is dependent on few other parameters apart from max regulatory
> supported power. It is the firmware which knows about all these
> parameters and considers the minimum for each packet transmission.
> 
> All ath12k firmware reports the final TX power in firmware pdev stats
> which falls under fw_stats. add get_txpower mac ops to get the TX power
> from firmware leveraging fw_stats and return it accordingly.
> 
> While at it, there is a possibility that repeated stats request WMI
> commands are queued to FW if mac80211/userspace does get tx power back
> to back(in Multiple BSS cases). This could potentially consume the WMI
> queue completely. Hence limit this by fetching the power only for every
> 5 seconds and reusing the value until the refresh timeout or when there
> is a change in channel.
> 
> Also remove init_completion(&ar->fw_stats_complete) in
> ath12k_mac_hw_register() as ath12k_fw_stats_init() takes care of
> it for each ar.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
> Signed-off-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
> ---
>  drivers/net/wireless/ath/ath12k/core.h |   1 +
>  drivers/net/wireless/ath/ath12k/mac.c  | 155 +++++++++++++++++++------
>  drivers/net/wireless/ath/ath12k/mac.h  |   3 +
>  3 files changed, 123 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
> index e4f51ad6a59f..42da19870713 100644
> --- a/drivers/net/wireless/ath/ath12k/core.h
> +++ b/drivers/net/wireless/ath/ath12k/core.h
> @@ -731,6 +731,7 @@ struct ath12k {
>  	u32 mlo_setup_status;
>  	u8 ftm_msgref;
>  	struct ath12k_fw_stats fw_stats;
> +	unsigned long last_tx_power_update;
>  };
>  
>  struct ath12k_hw {
> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
> index 4fb7e235be66..54fe3a2c9c0b 100644
> --- a/drivers/net/wireless/ath/ath12k/mac.c
> +++ b/drivers/net/wireless/ath/ath12k/mac.c
> @@ -4280,6 +4280,120 @@ static int ath12k_start_scan(struct ath12k *ar,
>  	return 0;
>  }
>  
> +static int ath12k_mac_get_fw_stats(struct ath12k *ar, u32 pdev_id,
> +				   u32 vdev_id, u32 stats_id)
> +{
> +	struct ath12k_base *ab = ar->ab;
> +	struct ath12k_hw *ah = ath12k_ar_to_ah(ar);
> +	unsigned long time_left;
> +	int ret;
> +
> +	guard(mutex)(&ah->hw_mutex);
> +
> +	if (ah->state != ATH12K_HW_STATE_ON)
> +		return -ENETDOWN;
> +
> +	spin_lock_bh(&ar->data_lock);
> +	ar->fw_stats.fw_stats_done = false;
> +	ath12k_fw_stats_free(&ar->fw_stats);
> +	spin_unlock_bh(&ar->data_lock);

rename ath12k_debugfs_fw_stats_reset and reuse instead of the above 4 lines

> +	reinit_completion(&ar->fw_stats_complete);
> +
> +	ret = ath12k_wmi_send_stats_request_cmd(ar, stats_id, vdev_id, pdev_id);
> +
> +	if (ret) {
> +		ath12k_warn(ab, "failed to request fw stats: stats id %u ret %d\n",
> +			    stats_id, ret);
> +		return ret;
> +	}
> +
> +	ath12k_dbg(ab, ATH12K_DBG_WMI,
> +		   "get fw stat pdev id %d vdev id %d stats id 0x%x\n",
> +		   pdev_id, vdev_id, stats_id);
> +
> +	time_left = wait_for_completion_timeout(&ar->fw_stats_complete, 1 * HZ);
> +
> +	if (!time_left)
> +		ath12k_warn(ab, "time out while waiting for get fw stats\n");
> +

suggestion is to create a separate function and move some of the common code in ath12k_mac_get_fw_stats and ath12k_debugfs_fw_stats_request

> +	return ret;
> +}
> +
> +static int ath12k_mac_op_get_txpower(struct ieee80211_hw *hw,
> +				     struct ieee80211_vif *vif,
> +				     unsigned int link_id,
> +				     int *dbm)
> +{
> +	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
> +	struct ath12k_fw_stats_pdev *pdev;
> +	struct ath12k_hw *ah = hw->priv;
> +	struct ath12k_link_vif *arvif;
> +	struct ath12k_base *ab;
> +	struct ath12k *ar;
> +	int ret;
> +
> +	/* Final Tx power is minimum of Target Power, CTL power, Regulatory
> +	 * Power, PSD EIRP Power. We just know the Regulatory power from the
> +	 * regulatory rules obtained. FW knows all these power and sets the min
> +	 * of these. Hence, we request the FW pdev stats in which FW reports
> +	 * the minimum of all vdev's channel Tx power.
> +	 */
> +	lockdep_assert_wiphy(hw->wiphy);
> +
> +	arvif = wiphy_dereference(ah->hw->wiphy, ahvif->link[link_id]);
> +	if (!arvif || !arvif->ar)
> +		return -EINVAL;
> +
> +	ar = arvif->ar;
> +	ab = ar->ab;
> +	if (ah->state != ATH12K_HW_STATE_ON)
> +		goto err_fallback;
> +
> +	if (test_bit(ATH12K_FLAG_CAC_RUNNING, &ar->dev_flags))
> +		return -EAGAIN;
> +
> +	/* Limit the requests to Firmware for fetching the tx power */
> +	if (ar->chan_tx_pwr != ATH12K_PDEV_TX_POWER_INVALID &&
> +	    time_before(jiffies,
> +			msecs_to_jiffies(ATH12K_PDEV_TX_POWER_REFRESH_TIME_MSECS) +
> +					 ar->last_tx_power_update))
> +		goto send_tx_power;
> +
> +	ret = ath12k_mac_get_fw_stats(ar, ar->pdev->pdev_id, arvif->vdev_id,
> +				      WMI_REQUEST_PDEV_STAT);
> +	if (ret) {
> +		ath12k_warn(ab, "failed to request fw pdev stats: %d\n", ret);
> +		goto err_fallback;
> +	}
> +
> +	spin_lock_bh(&ar->data_lock);
> +	pdev = list_first_entry_or_null(&ar->fw_stats.pdevs,
> +					struct ath12k_fw_stats_pdev, list);
> +	if (!pdev) {
> +		spin_unlock_bh(&ar->data_lock);
> +		goto err_fallback;
> +	}
> +
> +	ar->chan_tx_pwr = pdev->chan_tx_power;

It is better to divide and store

> +	spin_unlock_bh(&ar->data_lock);
> +	ar->last_tx_power_update = jiffies;
> +
> +send_tx_power:
> +	/* tx power reported by firmware is in units of 0.5 dBm */
> +	*dbm = ar->chan_tx_pwr / 2;

based on the above comment, we dont need to do divide everytime here during repeated calls

> +	ath12k_dbg(ar->ab, ATH12K_DBG_MAC, "txpower from firmware %d, reported %d dBm\n",
> +		   ar->chan_tx_pwr, *dbm);
> +	return 0;
> +
> +err_fallback:
> +	/* We didn't get txpower from FW. Hence, relying on vif->bss_conf.txpower */
> +	*dbm = vif->bss_conf.txpower;
> +	ath12k_dbg(ar->ab, ATH12K_DBG_MAC, "txpower from firmware NaN, reported %d dBm\n",
> +		   *dbm);
> +	return 0;
> +}
> +
>  static u8
>  ath12k_mac_find_link_id_by_ar(struct ath12k_vif *ahvif, struct ath12k *ar)
>  {
> @@ -7433,6 +7547,7 @@ static int ath12k_mac_start(struct ath12k *ar)
>  	ar->num_created_vdevs = 0;
>  	ar->num_peers = 0;
>  	ar->allocated_vdev_map = 0;
> +	ar->chan_tx_pwr = ATH12K_PDEV_TX_POWER_INVALID;

ar->chan_tx_pwr type u32..and assigning signed value. fix it.

>  
>  	/* Configure monitor status ring with default rx_filter to get rx status
>  	 * such as rssi, rx_duration.
> @@ -8638,6 +8753,7 @@ static int ath12k_mac_op_add_chanctx(struct ieee80211_hw *hw,
>  	 */
>  	ar->rx_channel = ctx->def.chan;
>  	spin_unlock_bh(&ar->data_lock);
> +	ar->chan_tx_pwr = ATH12K_PDEV_TX_POWER_INVALID;
>  
>  	return 0;
>  }
> @@ -8666,6 +8782,7 @@ static void ath12k_mac_op_remove_chanctx(struct ieee80211_hw *hw,
>  	 */
>  	ar->rx_channel = NULL;
>  	spin_unlock_bh(&ar->data_lock);
> +	ar->chan_tx_pwr = ATH12K_PDEV_TX_POWER_INVALID;
>  }
>  
>  static enum wmi_phy_mode
> @@ -10109,40 +10226,6 @@ static int ath12k_mac_op_get_survey(struct ieee80211_hw *hw, int idx,
>  	return 0;
>  }
>  
> -static int ath12k_mac_get_fw_stats(struct ath12k *ar, u32 pdev_id,
> -				   u32 vdev_id, u32 stats_id)
> -{
> -	struct ath12k_base *ab = ar->ab;
> -	struct ath12k_hw *ah = ath12k_ar_to_ah(ar);
> -	unsigned long time_left;
> -	int ret;
> -
> -	guard(mutex)(&ah->hw_mutex);
> -
> -	if (ah->state != ATH12K_HW_STATE_ON)
> -		return -ENETDOWN;
> -
> -	reinit_completion(&ar->fw_stats_complete);
> -
> -	ret = ath12k_wmi_send_stats_request_cmd(ar, stats_id, vdev_id, pdev_id);
> -
> -	if (ret) {
> -		ath12k_warn(ab, "failed to request fw stats: %d\n", ret);
> -		return ret;
> -	}
> -
> -	ath12k_dbg(ab, ATH12K_DBG_WMI,
> -		   "get fw stat pdev id %d vdev id %d stats id 0x%x\n",
> -		   pdev_id, vdev_id, stats_id);
> -
> -	time_left = wait_for_completion_timeout(&ar->fw_stats_complete, 1 * HZ);
> -
> -	if (!time_left)
> -		ath12k_warn(ab, "time out while waiting for get fw stats\n");
> -
> -	return ret;
> -}
> -
>  static void ath12k_mac_op_sta_statistics(struct ieee80211_hw *hw,
>  					 struct ieee80211_vif *vif,
>  					 struct ieee80211_sta *sta,
> @@ -10431,6 +10514,7 @@ static const struct ieee80211_ops ath12k_ops = {
>  	.assign_vif_chanctx		= ath12k_mac_op_assign_vif_chanctx,
>  	.unassign_vif_chanctx		= ath12k_mac_op_unassign_vif_chanctx,
>  	.switch_vif_chanctx		= ath12k_mac_op_switch_vif_chanctx,
> +	.get_txpower			= ath12k_mac_op_get_txpower,
>  	.set_rts_threshold		= ath12k_mac_op_set_rts_threshold,
>  	.set_frag_threshold		= ath12k_mac_op_set_frag_threshold,
>  	.set_bitrate_mask		= ath12k_mac_op_set_bitrate_mask,
> @@ -11178,11 +11262,10 @@ static int ath12k_mac_hw_register(struct ath12k_hw *ah)
>  			goto err_unregister_hw;
>  		}
>  
> +		ath12k_fw_stats_init(ar);
>  		ath12k_debugfs_register(ar);
>  	}
>  
> -	init_completion(&ar->fw_stats_complete);
> -
>  	return 0;
>  
>  err_unregister_hw:
> diff --git a/drivers/net/wireless/ath/ath12k/mac.h b/drivers/net/wireless/ath/ath12k/mac.h
> index 1acaf3f68292..af0d3c6a2a6c 100644
> --- a/drivers/net/wireless/ath/ath12k/mac.h
> +++ b/drivers/net/wireless/ath/ath12k/mac.h
> @@ -33,6 +33,9 @@ struct ath12k_generic_iter {
>  #define ATH12K_KEEPALIVE_MAX_IDLE		3895
>  #define ATH12K_KEEPALIVE_MAX_UNRESPONSIVE	3900
>  
> +#define ATH12K_PDEV_TX_POWER_INVALID		(-1)
> +#define ATH12K_PDEV_TX_POWER_REFRESH_TIME_MSECS	5000 /* msecs */
> +
>  /* FIXME: should these be in ieee80211.h? */
>  #define IEEE80211_VHT_MCS_SUPPORT_0_11_MASK	GENMASK(23, 16)
>  #define IEEE80211_DISABLE_VHT_MCS_SUPPORT_0_11	BIT(24)


