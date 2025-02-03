Return-Path: <linux-wireless+bounces-18278-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FBC2A25237
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Feb 2025 07:04:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC233188430F
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Feb 2025 06:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A3DD10E0;
	Mon,  3 Feb 2025 06:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HCxnpd10"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84110F9EC
	for <linux-wireless@vger.kernel.org>; Mon,  3 Feb 2025 06:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738562684; cv=none; b=PX0Ai3aTL15i5QBr2D5WVfTwjCU8hq6vOJH8MjSjdEf7WJleJK08NFUxJhyZJaEaWzxUw5AfXcc+3AcmnTPdoE8NbgVRC3g9YsSAZEhaJc22OuhQ0qXl+/aEY1OsK7L6z0vzbRRlsq4fl45O9TIeuV0r7WJSCKT9/NGPXWIqTNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738562684; c=relaxed/simple;
	bh=0026q86RKNn8lJ0qDSobFtmbMNicD/gh+U91/aywWmU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=r2CGaKuePc1jn12DxgTmfZlrr7RoUw+4jIvLlLnRygI4a0BfbCm5KYsPKNBfeyysunHZitr/0NDlq73fNjmbEjgwK01huUjvZVAHEyOxoVDGo1vLcQiELMexNZG1cEHArBTKlNi+CZup4kSGOAim/bqA2B8LsSWkkeyAcJNbDXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=HCxnpd10; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5135lEbx007514;
	Mon, 3 Feb 2025 06:04:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2D/iY/UdUfTEfQpbZEGqSPG51j5CkcMafFH6NA40tEc=; b=HCxnpd10YwxP+T22
	v9QKKL5kVOpcXhisLmhz/yHf1/x6Vc+tvbeITB7EqpXzBM8p+hUEaYjXAQw8C+zZ
	YuQd/pmoGwVn7iBOQ5KdohVcQLJiZBWC3AE+Ygh6FipRvPIX5Rzs5lP4QSSUU6UN
	H1Bvacw3PBvvebzxQm1MP71MUhKuZcxTARQaPUHpVyGMO3RsVUZEFwDNYrakcQ4A
	qq6TqkuFz/ewkSBI7pxypoQhialpztPibM763tGVcY1G1k9Y6KKezT/HbNTLM4uy
	1/qPTanzNe3/HCwzcuS/M94mBpLhadnAVy5qKvkL2XPdhKZrhKTksMTFNrQaNezm
	KT923w==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44jqxw0103-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Feb 2025 06:04:38 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51364bxE002561
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 3 Feb 2025 06:04:37 GMT
Received: from [10.216.20.127] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 2 Feb 2025
 22:04:35 -0800
Message-ID: <6ed7ff61-a62a-9cd8-1603-6100402b4ab5@quicinc.com>
Date: Mon, 3 Feb 2025 11:34:32 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 2/2] wifi: ath12k: add get_txpower mac ops
Content-Language: en-US
To: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Aditya Kumar Singh
	<aditya.kumar.singh@oss.qualcomm.com>
References: <20250131193726.3568086-1-rameshkumar.sundaram@oss.qualcomm.com>
 <20250131193726.3568086-3-rameshkumar.sundaram@oss.qualcomm.com>
From: Mahendran P <quic_mahep@quicinc.com>
In-Reply-To: <20250131193726.3568086-3-rameshkumar.sundaram@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ziMaWbBEr_kDs0bfoWPX-4LBg7TXMBd7
X-Proofpoint-GUID: ziMaWbBEr_kDs0bfoWPX-4LBg7TXMBd7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-03_02,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 phishscore=0 bulkscore=0 priorityscore=1501 mlxscore=0 suspectscore=0
 adultscore=0 impostorscore=0 clxscore=1015 lowpriorityscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502030049

On 2/1/2025 1:07 AM, Rameshkumar Sundaram wrote:
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
>  drivers/net/wireless/ath/ath12k/mac.c  | 208 +++++++++++++++++--------
>  drivers/net/wireless/ath/ath12k/mac.h  |   3 +
>  3 files changed, 148 insertions(+), 64 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
> index 373e7baf379b..d278e4a8bb08 100644
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
> index 8cd33ea75590..efab885bdbb1 100644
> --- a/drivers/net/wireless/ath/ath12k/mac.c
> +++ b/drivers/net/wireless/ath/ath12k/mac.c
> @@ -4280,6 +4280,145 @@ static int ath12k_start_scan(struct ath12k *ar,
>  	return 0;
>  }
>  
> +int ath12k_mac_get_fw_stats(struct ath12k *ar,
> +			    struct ath12k_fw_stats_req_params *param)
> +{
> +	struct ath12k_base *ab = ar->ab;
> +	struct ath12k_hw *ah = ath12k_ar_to_ah(ar);
> +	unsigned long timeout, time_left;
> +	int ret;
> +
> +	guard(mutex)(&ah->hw_mutex);
> +
> +	if (ah->state != ATH12K_HW_STATE_ON)
> +		return -ENETDOWN;
> +
> +	/* FW stats can get split when exceeding the stats data buffer limit.
> +	 * In that case, since there is no end marking for the back-to-back
> +	 * received 'update stats' event, we keep a 3 seconds timeout in case,
> +	 * fw_stats_done is not marked yet
> +	 */
> +	timeout = jiffies + msecs_to_jiffies(3 * 1000);
> +	ath12k_fw_stats_reset(ar);
> +
> +	reinit_completion(&ar->fw_stats_complete);
> +
> +	ret = ath12k_wmi_send_stats_request_cmd(ar, param->stats_id,
> +						param->vdev_id, param->pdev_id);
> +
> +	if (ret) {
> +		ath12k_warn(ab, "failed to request fw stats: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ath12k_dbg(ab, ATH12K_DBG_WMI,
> +		   "get fw stat pdev id %d vdev id %d stats id 0x%x\n",
> +		   param->pdev_id, param->vdev_id, param->stats_id);
> +
> +	time_left = wait_for_completion_timeout(&ar->fw_stats_complete, 1 * HZ);
> +
> +	if (!time_left) {
> +		ath12k_warn(ab, "time out while waiting for get fw stats\n");
> +		return -ETIMEDOUT;
> +	}
> +
> +	/* Firmware sends WMI_UPDATE_STATS_EVENTID back-to-back
> +	 * when stats data buffer limit is reached. fw_stats_complete
> +	 * is completed once host receives first event from firmware, but
> +	 * still end might not be marked in the TLV.
> +	 * Below loop is to confirm that firmware completed sending all the event
> +	 * and fw_stats_done is marked true when end is marked in the TLV.
> +	 */
> +	for (;;) {
> +		if (time_after(jiffies, timeout))
> +			break;
> +		spin_lock_bh(&ar->data_lock);
> +		if (ar->fw_stats.fw_stats_done) {
> +			spin_unlock_bh(&ar->data_lock);
> +			break;
> +		}
> +		spin_unlock_bh(&ar->data_lock);
> +	}
> +	return 0;
> +}
> +
> +static int ath12k_mac_op_get_txpower(struct ieee80211_hw *hw,
> +				     struct ieee80211_vif *vif,
> +				     unsigned int link_id,
> +				     int *dbm)
> +{
> +	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
> +	struct ath12k_fw_stats_req_params params = {};
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
> +	params.pdev_id = ar->pdev->pdev_id;
> +	params.vdev_id = arvif->vdev_id;
> +	params.stats_id = WMI_REQUEST_PDEV_STAT;
> +	ret = ath12k_mac_get_fw_stats(ar, &params);
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
> +	/* tx power reported by firmware is in units of 0.5 dBm */
> +	ar->chan_tx_pwr = pdev->chan_tx_power / 2;
> +	spin_unlock_bh(&ar->data_lock);
> +	ar->last_tx_power_update = jiffies;
> +
> +send_tx_power:
> +	*dbm = ar->chan_tx_pwr;
> +	ath12k_dbg(ar->ab, ATH12K_DBG_MAC, "txpower fetched from firmware %d dBm\n",
> +		   *dbm);
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
> @@ -7433,6 +7572,7 @@ static int ath12k_mac_start(struct ath12k *ar)
>  	ar->num_created_vdevs = 0;
>  	ar->num_peers = 0;
>  	ar->allocated_vdev_map = 0;
> +	ar->chan_tx_pwr = ATH12K_PDEV_TX_POWER_INVALID;
>  
>  	/* Configure monitor status ring with default rx_filter to get rx status
>  	 * such as rssi, rx_duration.
> @@ -8638,6 +8778,7 @@ static int ath12k_mac_op_add_chanctx(struct ieee80211_hw *hw,
>  	 */
>  	ar->rx_channel = ctx->def.chan;
>  	spin_unlock_bh(&ar->data_lock);
> +	ar->chan_tx_pwr = ATH12K_PDEV_TX_POWER_INVALID;
>  
>  	return 0;
>  }
> @@ -8666,6 +8807,7 @@ static void ath12k_mac_op_remove_chanctx(struct ieee80211_hw *hw,
>  	 */
>  	ar->rx_channel = NULL;
>  	spin_unlock_bh(&ar->data_lock);
> +	ar->chan_tx_pwr = ATH12K_PDEV_TX_POWER_INVALID;
>  }
>  
>  static enum wmi_phy_mode
> @@ -10109,68 +10251,6 @@ static int ath12k_mac_op_get_survey(struct ieee80211_hw *hw, int idx,
>  	return 0;
>  }
>  
> -int ath12k_mac_get_fw_stats(struct ath12k *ar,
> -			    struct ath12k_fw_stats_req_params *param)
> -{
> -	struct ath12k_base *ab = ar->ab;
> -	struct ath12k_hw *ah = ath12k_ar_to_ah(ar);
> -	unsigned long timeout, time_left;
> -	int ret;
> -
> -	guard(mutex)(&ah->hw_mutex);
> -
> -	if (ah->state != ATH12K_HW_STATE_ON)
> -		return -ENETDOWN;
> -
> -	/* FW stats can get split when exceeding the stats data buffer limit.
> -	 * In that case, since there is no end marking for the back-to-back
> -	 * received 'update stats' event, we keep a 3 seconds timeout in case,
> -	 * fw_stats_done is not marked yet
> -	 */
> -	timeout = jiffies + msecs_to_jiffies(3 * 1000);
> -	ath12k_fw_stats_reset(ar);
> -
> -	reinit_completion(&ar->fw_stats_complete);
> -
> -	ret = ath12k_wmi_send_stats_request_cmd(ar, param->stats_id,
> -						param->vdev_id, param->pdev_id);
> -
> -	if (ret) {
> -		ath12k_warn(ab, "failed to request fw stats: %d\n", ret);
> -		return ret;
> -	}
> -
> -	ath12k_dbg(ab, ATH12K_DBG_WMI,
> -		   "get fw stat pdev id %d vdev id %d stats id 0x%x\n",
> -		   param->pdev_id, param->vdev_id, param->stats_id);
> -
> -	time_left = wait_for_completion_timeout(&ar->fw_stats_complete, 1 * HZ);
> -
> -	if (!time_left) {
> -		ath12k_warn(ab, "time out while waiting for get fw stats\n");
> -		return -ETIMEDOUT;
> -	}
> -
> -	/* Firmware sends WMI_UPDATE_STATS_EVENTID back-to-back
> -	 * when stats data buffer limit is reached. fw_stats_complete
> -	 * is completed once host receives first event from firmware, but
> -	 * still end might not be marked in the TLV.
> -	 * Below loop is to confirm that firmware completed sending all the event
> -	 * and fw_stats_done is marked true when end is marked in the TLV.
> -	 */
> -	for (;;) {
> -		if (time_after(jiffies, timeout))
> -			break;
> -		spin_lock_bh(&ar->data_lock);
> -		if (ar->fw_stats.fw_stats_done) {
> -			spin_unlock_bh(&ar->data_lock);
> -			break;
> -		}
> -		spin_unlock_bh(&ar->data_lock);
> -	}
> -	return 0;
> -}
> -
>  static void ath12k_mac_op_sta_statistics(struct ieee80211_hw *hw,
>  					 struct ieee80211_vif *vif,
>  					 struct ieee80211_sta *sta,
> @@ -10463,6 +10543,7 @@ static const struct ieee80211_ops ath12k_ops = {
>  	.assign_vif_chanctx		= ath12k_mac_op_assign_vif_chanctx,
>  	.unassign_vif_chanctx		= ath12k_mac_op_unassign_vif_chanctx,
>  	.switch_vif_chanctx		= ath12k_mac_op_switch_vif_chanctx,
> +	.get_txpower			= ath12k_mac_op_get_txpower,
>  	.set_rts_threshold		= ath12k_mac_op_set_rts_threshold,
>  	.set_frag_threshold		= ath12k_mac_op_set_frag_threshold,
>  	.set_bitrate_mask		= ath12k_mac_op_set_bitrate_mask,
> @@ -11210,11 +11291,10 @@ static int ath12k_mac_hw_register(struct ath12k_hw *ah)
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
> index a0de0ddf175e..8435bdea904f 100644
> --- a/drivers/net/wireless/ath/ath12k/mac.h
> +++ b/drivers/net/wireless/ath/ath12k/mac.h
> @@ -33,6 +33,9 @@ struct ath12k_generic_iter {
>  #define ATH12K_KEEPALIVE_MAX_IDLE		3895
>  #define ATH12K_KEEPALIVE_MAX_UNRESPONSIVE	3900
>  
> +#define ATH12K_PDEV_TX_POWER_INVALID		((u32)-1)
> +#define ATH12K_PDEV_TX_POWER_REFRESH_TIME_MSECS	5000 /* msecs */
> +
>  /* FIXME: should these be in ieee80211.h? */
>  #define IEEE80211_VHT_MCS_SUPPORT_0_11_MASK	GENMASK(23, 16)
>  #define IEEE80211_DISABLE_VHT_MCS_SUPPORT_0_11	BIT(24)

Series LGTM


