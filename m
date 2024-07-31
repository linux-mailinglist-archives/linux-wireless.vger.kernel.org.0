Return-Path: <linux-wireless+bounces-10767-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A92D9435D6
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jul 2024 20:51:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A9CAB22DD0
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jul 2024 18:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4007B43169;
	Wed, 31 Jul 2024 18:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GKww/9cM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA48F4778E
	for <linux-wireless@vger.kernel.org>; Wed, 31 Jul 2024 18:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722451867; cv=none; b=KFhSJGLe6G/iQnVewRYdFwjo6bmYbE4pMlm4S+I9Zu5XJK4EPiAefJEmUVF5IxKRxIXZPWmuav3uPhanoPG7vDN8xPg76/i2E1y80qQ/7qMdvoHnzVZS9o7esVVIh85J27tXnxc/pyY/Ufto10yebd4Pi9+xnTpjcolus7x1U34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722451867; c=relaxed/simple;
	bh=6VtxBv9BfJrKkqQU8yVTcJQKvlgZMv2YjIgZaQChAf8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=pvj+2LJq4yEtGrJDXOYKlx5CKzCfwEUshdeG1nZYB5WVNaG1VDsJLaZr9EO02XYXahzSo8r+0JA77EF6npuVgPLF3DUH5Y+0neM5Bl2r77soQ9tU1UsuLzxOoo3rG6hRBEFv8zlzWOEzKUZZTE4x2GN+nAl6VA2F0n57AleOSdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=GKww/9cM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46VFO0kl008728;
	Wed, 31 Jul 2024 18:51:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	s+MzzUcs6FW2kXSp1AslGCCPcw2MM7STr7knnuM3uvw=; b=GKww/9cMNXdr3gpt
	rmiMXuqYmn7TduS8Yij2p3+k6X7qaWJXloIAJjy0IV/G1mYFg0wyKFK8EacFAhWA
	PkxFP7U5n4L1nc9XmqXE/MHYV8u9ebugZQ4+cL3Con1puK99jksrI9w0x/Z6plkl
	lxrQc9MyU4XP4pwxDjqekU742JGIv2qN6QKNBkJkP4hEZA177O7WfLaEHm/DgoFX
	VAptQi7YTJZ/4Iuik2LQo1J2Qeu40vU5Xrpggupjoy/rJYtYGVnkXL4M9/aVca35
	F4itlFEHFDrnXF5xG05tRpXV76p6KB7SZweMKtzIIcEc+L0sRO64AGjukwDQUxyg
	t/WZqg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40mqw7cc5p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jul 2024 18:51:00 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46VIoxOY018900
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jul 2024 18:50:59 GMT
Received: from [10.111.177.34] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 31 Jul
 2024 11:50:58 -0700
Message-ID: <1d9eeacc-ac2b-4273-b2b7-d6db9421f59c@quicinc.com>
Date: Wed, 31 Jul 2024 11:50:58 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/3] wifi: ath12k: report station mode signal strength
Content-Language: en-US
To: Lingbo Kong <quic_lingbok@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240731113645.54738-1-quic_lingbok@quicinc.com>
 <20240731113645.54738-4-quic_lingbok@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240731113645.54738-4-quic_lingbok@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: mhg72Zc3sy7dLy5wUrNBRAyL-alC-93_
X-Proofpoint-GUID: mhg72Zc3sy7dLy5wUrNBRAyL-alC-93_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-31_10,2024-07-31_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 spamscore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0
 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407310131

On 7/31/2024 4:36 AM, Lingbo Kong wrote:
> Currently, the signal strength of "iw dev xxx station dump" always show an
> invalid value.
> 
> This is because signal strength is only set in ath12k_mgmt_rx_event()
> function, and not set for received data packet. So, change to get signal
> from firmware and report to mac80211.
> 
> After that, "iw dev xxx station dump" show the correct signal strength.
> Such as:
> 
> Station 00:03:7f:12:03:03 (on wlo1)
>         inactive time:  36 ms
>         rx bytes:       61571
>         rx packets:     336
>         tx bytes:       28204
>         tx packets:     205
>         tx retries:     49
>         tx failed:      0
>         beacon loss:    0
>         beacon rx:      83
>         rx drop misc:   66
>         signal:         -24 dBm
>         beacon signal avg:      -22 dBm
> 
> For WCN7850, the firmware supports db2dbm, so not need to add noise floor.
> For QCN9274, the firmware not support db2dbm, so need to add noise floor.
> 
> This patch affects the station mode of WCN7850 and QCN9274.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.2.1-00201-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Lingbo Kong <quic_lingbok@quicinc.com>
> ---
> v6:
> 1.rebase against wifi: ath12k: prepare sta data structure for MLO handling
> 
> v5:
> no change
> 
> v4:
> 1.no change
> 
> v3:
> 1.change wmi_vdev_stats_event to wmi_vdev_stats_params 
> 
> v2:
> 1.change name according Naming conventions for structures
> 
>  drivers/net/wireless/ath/ath12k/core.h |   3 +
>  drivers/net/wireless/ath/ath12k/mac.c  |  60 ++++++++++-
>  drivers/net/wireless/ath/ath12k/wmi.c  | 132 +++++++++++++++++++++++++
>  drivers/net/wireless/ath/ath12k/wmi.h  |  48 +++++++++
>  4 files changed, 241 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
> index 3a28b3fbe8a0..4196197d35aa 100644
> --- a/drivers/net/wireless/ath/ath12k/core.h
> +++ b/drivers/net/wireless/ath/ath12k/core.h
> @@ -470,6 +470,7 @@ struct ath12k_link_sta {
>  	struct ath12k_wbm_tx_stats *wbm_tx_stats;
>  	u32 bw_prev;
>  	u32 peer_nss;
> +	s8 rssi_beacon;
>  };
>  
>  struct ath12k_sta {
> @@ -672,6 +673,8 @@ struct ath12k {
>  	u32 freq_low;
>  	u32 freq_high;
>  
> +	struct completion fw_stats_complete;
> +
>  	bool nlo_enabled;
>  };
>  
> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
> index 6e3b3e40b2ca..6b2c1d068533 100644
> --- a/drivers/net/wireless/ath/ath12k/mac.c
> +++ b/drivers/net/wireless/ath/ath12k/mac.c
> @@ -8756,6 +8756,43 @@ static int ath12k_mac_op_get_survey(struct ieee80211_hw *hw, int idx,
>  	return 0;
>  }
>  
> +static int ath12k_mac_get_fw_stats(struct ath12k *ar, u32 pdev_id,
> +				   u32 vdev_id, u32 stats_id)
> +{
> +	struct ath12k_base *ab = ar->ab;
> +	struct ath12k_hw *ah = ath12k_ar_to_ah(ar);
> +	int ret, left;
> +
> +	mutex_lock(&ar->conf_mutex);

since you hold the lock for entire function, replace with
	guard(mutex, &ar->conf_mutex);

then you can get rid of the unlock and replace all the goto err_unlock with return

> +
> +	if (ah->state != ATH12K_HW_STATE_ON) {
> +		ret = -ENETDOWN;
> +		goto err_unlock;
> +	}
> +
> +	reinit_completion(&ar->fw_stats_complete);
> +
> +	ret = ath12k_wmi_send_stats_request_cmd(ar, stats_id, vdev_id, pdev_id);
> +
> +	if (ret) {
> +		ath12k_warn(ab, "failed to request fw stats: %d\n", ret);
> +		goto err_unlock;
> +	}
> +
> +	ath12k_dbg(ab, ATH12K_DBG_WMI,
> +		   "get fw stat pdev id %d vdev id %d stats id 0x%x\n",
> +		   pdev_id, vdev_id, stats_id);
> +
> +	left = wait_for_completion_timeout(&ar->fw_stats_complete, 1 * HZ);

s/left/time_left/

this aligns with a new convention recently introduced upstream to use
'time_left' with any wait_*() functions:
https://lore.kernel.org/all/?q=s%3Atime_left

also note that it should be an unsigned long

> +
> +	if (!left)
> +		ath12k_warn(ab, "time out while waiting for get fw stats\n");
> +err_unlock:
> +
> +	mutex_unlock(&ar->conf_mutex);
> +	return ret;
> +}
> +
>  static void ath12k_mac_op_sta_statistics(struct ieee80211_hw *hw,
>  					 struct ieee80211_vif *vif,
>  					 struct ieee80211_sta *sta,
> @@ -8764,9 +8801,15 @@ static void ath12k_mac_op_sta_statistics(struct ieee80211_hw *hw,
>  	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
>  	struct ath12k_sta *ahsta = ath12k_sta_to_ahsta(sta);
>  	struct ath12k_link_sta *arsta;
> +	struct ath12k *ar;
> +	s8 signal;
> +	bool db2dbm;
>  
>  	mutex_lock(&ah->conf_mutex);
>  	arsta = &ahsta->deflink;
> +	ar = arsta->arvif->ar;
> +	db2dbm = test_bit(WMI_TLV_SERVICE_HW_DB2DBM_CONVERSION_SUPPORT,
> +			  ar->ab->wmi_ab.svc_map);
>  	sinfo->rx_duration = arsta->rx_duration;
>  	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_RX_DURATION);
>  
> @@ -8794,8 +8837,19 @@ static void ath12k_mac_op_sta_statistics(struct ieee80211_hw *hw,
>  	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_BITRATE);
>  
>  	/* TODO: Use real NF instead of default one. */
> -	sinfo->signal = arsta->rssi_comb + ATH12K_DEFAULT_NOISE_FLOOR;
> -	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_SIGNAL);
> +	signal = arsta->rssi_comb;
> +
> +	if (!signal &&
> +	    arsta->arvif->ahvif->vdev_type == WMI_VDEV_TYPE_STA &&
> +	    !(ath12k_mac_get_fw_stats(ar, ar->pdev->pdev_id, 0,
> +				      WMI_REQUEST_VDEV_STAT)))
> +		signal = arsta->rssi_beacon;
> +
> +	if (signal) {
> +		sinfo->signal = db2dbm ? signal : signal + ATH12K_DEFAULT_NOISE_FLOOR;
> +		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_SIGNAL);
> +	}
> +
>  	mutex_unlock(&ah->conf_mutex);
>  }
>  
> @@ -9634,6 +9688,8 @@ static int ath12k_mac_hw_register(struct ath12k_hw *ah)
>  		ath12k_debugfs_register(ar);
>  	}
>  
> +	init_completion(&ar->fw_stats_complete);
> +
>  	return 0;
>  
>  err_unregister_hw:
> diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
> index f658fd583f49..2c4dd8f9e588 100644
> --- a/drivers/net/wireless/ath/ath12k/wmi.c
> +++ b/drivers/net/wireless/ath/ath12k/wmi.c
> @@ -25,6 +25,10 @@ struct ath12k_wmi_svc_ready_parse {
>  	bool wmi_svc_bitmap_done;
>  };
>  
> +struct wmi_tlv_fw_stats_parse {
> +	const struct wmi_stats_event *ev;
> +};
> +
>  struct ath12k_wmi_dma_ring_caps_parse {
>  	struct ath12k_wmi_dma_ring_caps_params *dma_ring_caps;
>  	u32 n_dma_ring_caps;
> @@ -814,6 +818,39 @@ int ath12k_wmi_mgmt_send(struct ath12k *ar, u32 vdev_id, u32 buf_id,
>  	return ret;
>  }
>  
> +int ath12k_wmi_send_stats_request_cmd(struct ath12k *ar, u32 stats_id,
> +				      u32 vdev_id, u32 pdev_id)
> +{
> +	struct ath12k_wmi_pdev *wmi = ar->wmi;
> +	struct wmi_request_stats_cmd *cmd;
> +	struct sk_buff *skb;
> +	int ret;
> +
> +	skb = ath12k_wmi_alloc_skb(wmi->wmi_ab, sizeof(*cmd));
> +	if (!skb)
> +		return -ENOMEM;
> +
> +	cmd = (struct wmi_request_stats_cmd *)skb->data;
> +	cmd->tlv_header = ath12k_wmi_tlv_cmd_hdr(WMI_TAG_REQUEST_STATS_CMD,
> +						 sizeof(*cmd));
> +
> +	cmd->stats_id = cpu_to_le32(stats_id);
> +	cmd->vdev_id = cpu_to_le32(vdev_id);
> +	cmd->pdev_id = cpu_to_le32(pdev_id);
> +
> +	ret = ath12k_wmi_cmd_send(wmi, skb, WMI_REQUEST_STATS_CMDID);
> +	if (ret) {
> +		ath12k_warn(ar->ab, "failed to send WMI_REQUEST_STATS cmd\n");
> +		dev_kfree_skb(skb);
> +	}
> +
> +	ath12k_dbg(ar->ab, ATH12K_DBG_WMI,
> +		   "WMI request stats 0x%x vdev id %d pdev id %d\n",
> +		   stats_id, vdev_id, pdev_id);
> +
> +	return ret;
> +}
> +
>  int ath12k_wmi_vdev_create(struct ath12k *ar, u8 *macaddr,
>  			   struct ath12k_wmi_vdev_create_arg *args)
>  {
> @@ -6638,8 +6675,103 @@ static void ath12k_peer_assoc_conf_event(struct ath12k_base *ab, struct sk_buff
>  	rcu_read_unlock();
>  }
>  
> +static int ath12k_wmi_tlv_fw_stats_data_parse(struct ath12k_base *ab,
> +					      struct wmi_tlv_fw_stats_parse *parse,
> +					      const void *ptr,
> +					      u16 len)
> +{
> +	const struct wmi_stats_event *ev = parse->ev;
> +	struct ath12k *ar;
> +	struct ath12k_link_vif *arvif;
> +	struct ieee80211_sta *sta;
> +	struct ath12k_sta *ahsta;
> +	struct ath12k_link_sta *arsta;
> +	int i, ret = 0;
> +	const void *data = ptr;
> +
> +	if (!ev) {
> +		ath12k_warn(ab, "failed to fetch update stats ev");
> +		return -EPROTO;
> +	}
> +
> +	rcu_read_lock();

since you hold this for the rest of the function you can replace this with
	guard(rcu)();

and you can remove the rcu_read_unlock() and return instead of goto exitfgrep
	
> +
> +	ar = ath12k_mac_get_ar_by_pdev_id(ab, le32_to_cpu(ev->pdev_id));
> +	if (!ar) {
> +		ath12k_warn(ab, "invalid pdev id %d in update stats event\n",
> +			    le32_to_cpu(ev->pdev_id));
> +		ret = -EPROTO;
> +		goto exit;
> +	}
> +
> +	for (i = 0; i < le32_to_cpu(ev->num_vdev_stats); i++) {
> +		const struct wmi_vdev_stats_params *src;
> +
> +		src = data;
> +		if (len < sizeof(*src)) {
> +			ret = -EPROTO;
> +			goto exit;
> +		}
> +
> +		arvif = ath12k_mac_get_arvif(ar, le32_to_cpu(src->vdev_id));
> +		if (arvif) {
> +			sta = ieee80211_find_sta_by_ifaddr(ath12k_ar_to_hw(ar),
> +							   arvif->bssid,
> +							   NULL);
> +			if (sta) {
> +				ahsta = ath12k_sta_to_ahsta(sta);
> +				arsta = &ahsta->deflink;
> +				arsta->rssi_beacon = le32_to_cpu(src->beacon_snr);
> +				ath12k_dbg(ab, ATH12K_DBG_WMI,
> +					   "wmi stats vdev id %d snr %d\n",
> +					   src->vdev_id, src->beacon_snr);
> +			} else {
> +				ath12k_dbg(ab, ATH12K_DBG_WMI,
> +					   "not found station bssid %pM for vdev stat\n",
> +					   arvif->bssid);
> +			}
> +		}
> +
> +		data += sizeof(*src);
> +		len -= sizeof(*src);
> +	}
> +
> +	complete(&ar->fw_stats_complete);
> +exit:
> +	rcu_read_unlock();
> +	return ret;
> +}
> +
> +static int ath12k_wmi_tlv_fw_stats_parse(struct ath12k_base *ab,
> +					 u16 tag, u16 len,
> +					 const void *ptr, void *data)
> +{
> +	struct wmi_tlv_fw_stats_parse *parse = data;
> +	int ret = 0;
> +
> +	switch (tag) {
> +	case WMI_TAG_STATS_EVENT:
> +		parse->ev = ptr;
> +		break;
> +	case WMI_TAG_ARRAY_BYTE:
> +		ret = ath12k_wmi_tlv_fw_stats_data_parse(ab, parse, ptr, len);
> +		break;
> +	default:
> +		break;
> +	}
> +	return ret;
> +}
> +
>  static void ath12k_update_stats_event(struct ath12k_base *ab, struct sk_buff *skb)
>  {
> +	int ret;
> +	struct wmi_tlv_fw_stats_parse parse = {};
> +
> +	ret = ath12k_wmi_tlv_iter(ab, skb->data, skb->len,
> +				  ath12k_wmi_tlv_fw_stats_parse,
> +				  &parse);
> +	if (ret)
> +		ath12k_warn(ab, "failed to parse fw stats %d\n", ret);
>  }
>  
>  /* PDEV_CTL_FAILSAFE_CHECK_EVENT is received from FW when the frequency scanned
> diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
> index 7f07ae1587fd..94b565c63715 100644
> --- a/drivers/net/wireless/ath/ath12k/wmi.h
> +++ b/drivers/net/wireless/ath/ath12k/wmi.h
> @@ -5460,6 +5460,52 @@ enum wmi_sta_keepalive_method {
>  #define WMI_STA_KEEPALIVE_INTERVAL_DEFAULT	30
>  #define WMI_STA_KEEPALIVE_INTERVAL_DISABLE	0
>  
> +struct wmi_stats_event {
> +	__le32 stats_id;
> +	__le32 num_pdev_stats;
> +	__le32 num_vdev_stats;
> +	__le32 num_peer_stats;
> +	__le32 num_bcnflt_stats;
> +	__le32 num_chan_stats;
> +	__le32 num_mib_stats;
> +	__le32 pdev_id;
> +	__le32 num_bcn_stats;
> +	__le32 num_peer_extd_stats;
> +	__le32 num_peer_extd2_stats;
> +} __packed;
> +
> +enum wmi_stats_id {
> +	WMI_REQUEST_VDEV_STAT	= BIT(3),
> +};
> +
> +struct wmi_request_stats_cmd {
> +	__le32 tlv_header;
> +	__le32 stats_id;
> +	__le32 vdev_id;
> +	struct ath12k_wmi_mac_addr_params peer_macaddr;
> +	__le32 pdev_id;
> +} __packed;
> +
> +#define WLAN_MAX_AC 4
> +#define MAX_TX_RATE_VALUES 10
> +
> +struct wmi_vdev_stats_params {
> +	__le32 vdev_id;
> +	__le32 beacon_snr;
> +	__le32 data_snr;
> +	__le32 num_tx_frames[WLAN_MAX_AC];
> +	__le32 num_rx_frames;
> +	__le32 num_tx_frames_retries[WLAN_MAX_AC];
> +	__le32 num_tx_frames_failures[WLAN_MAX_AC];
> +	__le32 num_rts_fail;
> +	__le32 num_rts_success;
> +	__le32 num_rx_err;
> +	__le32 num_rx_discard;
> +	__le32 num_tx_not_acked;
> +	__le32 tx_rate_history[MAX_TX_RATE_VALUES];
> +	__le32 beacon_rssi_history[MAX_TX_RATE_VALUES];
> +} __packed;
> +
>  void ath12k_wmi_init_qcn9274(struct ath12k_base *ab,
>  			     struct ath12k_wmi_resource_config_arg *config);
>  void ath12k_wmi_init_wcn7850(struct ath12k_base *ab,
> @@ -5585,6 +5631,8 @@ int ath12k_wmi_set_bios_cmd(struct ath12k_base *ab, u32 param_id,
>  			    const u8 *buf, size_t buf_len);
>  int ath12k_wmi_set_bios_sar_cmd(struct ath12k_base *ab, const u8 *psar_table);
>  int ath12k_wmi_set_bios_geo_cmd(struct ath12k_base *ab, const u8 *pgeo_table);
> +int ath12k_wmi_send_stats_request_cmd(struct ath12k *ar, u32 stats_id,
> +				      u32 vdev_id, u32 pdev_id);
>  
>  static inline u32
>  ath12k_wmi_caps_ext_get_pdev_id(const struct ath12k_wmi_caps_ext_params *param)


