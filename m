Return-Path: <linux-wireless+bounces-6278-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 858D98A3EBD
	for <lists+linux-wireless@lfdr.de>; Sat, 13 Apr 2024 23:31:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C5ED1C20A22
	for <lists+linux-wireless@lfdr.de>; Sat, 13 Apr 2024 21:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE5C455C35;
	Sat, 13 Apr 2024 21:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="iIeFn15T"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20791EB31
	for <linux-wireless@vger.kernel.org>; Sat, 13 Apr 2024 21:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713043855; cv=none; b=kJEXNC1ZySzlmlk2E3fOG/m09INBAOo5w/mPArPhQz1vrVQEuJBYDQjDklWo52VQ/wTyAZgjA6H43eipPfYNElCBHWMUOQ1Oac+hsQykJYupyYF4HmdfJOxNrtfHF9fw/hO3Hzuq5QjIO0+fY1Fv3bICCpWwbaGCKbspgOmG654=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713043855; c=relaxed/simple;
	bh=77McnsVzR9E2758aFOexzcWEsf21lra0kNipg4nQ/RA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=d2f4G6yx9a/78SlAV6RTFufhXi374T5L2z3TQrbObD3gJjczli0isdf+WKZ+f2ycULEX9/+jkgdc1SD/jRH9JXeeGK423jCXnQjnkw4PbxEtLmSkavzou+T706PadFvoJyx+e0r0dUBPgLRTp+zfnHxzI/epcKwiCQkO/kURqFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=iIeFn15T; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43DLQjLL019348;
	Sat, 13 Apr 2024 21:30:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=d1da14MjNE3vvz6Ae3Yqnwi2DYHAzO+K/p/czapAY4k=; b=iI
	eFn15TJhXG/6hwZbAdBsKUt+WFOnVw9NTUsGI+kP2QmNIyBgrokwVRve+/84vsBb
	VW/w0KBQQRTHqB6dToKx6BTapovpYry9BE4Jx6tFNKi2tkliYOjM6Cr8ymmmeTBE
	wEVuY4dUBN9Ew1fnmau+OznFU8zl1EWjnyn9msXuWXifd4xEjXa+d58TZW1GpYwS
	woxGRoIvo3VwROX7dWFug+J4HqiQoKK1/DK7m3XeS4bfsr0pG2+8R8Z4uZ4NOZ03
	7b/aQaU2j7E5RNusHRa14Z3v8rsg0EQsvYq+SKFLCf1+gAVpHw9fOgqNw3sEk+pe
	Pz5TGJ+LehzbDYVow8rw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xfj4yrwyd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 13 Apr 2024 21:30:48 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43DLUk1e013267
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 13 Apr 2024 21:30:46 GMT
Received: from [10.110.3.16] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sat, 13 Apr
 2024 14:30:45 -0700
Message-ID: <b9e8fb0f-25a9-4a96-a20a-94e3336698d6@quicinc.com>
Date: Sat, 13 Apr 2024 14:30:45 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] wifi: ath12k: report station mode signal strength
Content-Language: en-US
To: Lingbo Kong <quic_lingbok@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240412101600.55344-1-quic_lingbok@quicinc.com>
 <20240412101600.55344-4-quic_lingbok@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240412101600.55344-4-quic_lingbok@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: y9e2-_T3yLr8-aG-Wd0BEk0Je-hZ6k0K
X-Proofpoint-GUID: y9e2-_T3yLr8-aG-Wd0BEk0Je-hZ6k0K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-13_10,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 impostorscore=0
 priorityscore=1501 suspectscore=0 adultscore=0 phishscore=0 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404130159

On 4/12/2024 3:16 AM, Lingbo Kong wrote:
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
> v2:
> 1.change name according Naming conventions for structures
> 
>  drivers/net/wireless/ath/ath12k/core.h |   3 +
>  drivers/net/wireless/ath/ath12k/mac.c  |  56 ++++++++++-
>  drivers/net/wireless/ath/ath12k/wmi.c  | 130 +++++++++++++++++++++++++
>  drivers/net/wireless/ath/ath12k/wmi.h  |  48 +++++++++
>  4 files changed, 235 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
> index 575829a39116..db4d9241ac43 100644
> --- a/drivers/net/wireless/ath/ath12k/core.h
> +++ b/drivers/net/wireless/ath/ath12k/core.h
> @@ -448,6 +448,7 @@ struct ath12k_sta {
>  	struct ath12k_wbm_tx_stats *wbm_tx_stats;
>  	u32 bw_prev;
>  	u32 peer_nss;
> +	s8 rssi_beacon;
>  };
>  
>  #define ATH12K_MIN_5G_FREQ 4150
> @@ -631,6 +632,8 @@ struct ath12k {
>  
>  	u32 freq_low;
>  	u32 freq_high;
> +
> +	struct completion fw_stats_complete;
>  };
>  
>  struct ath12k_hw {
> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
> index d55e9a9b293b..50c087e34ce0 100644
> --- a/drivers/net/wireless/ath/ath12k/mac.c
> +++ b/drivers/net/wireless/ath/ath12k/mac.c
> @@ -8020,12 +8020,52 @@ static int ath12k_mac_op_get_survey(struct ieee80211_hw *hw, int idx,
>  	return 0;
>  }
>  
> +static int ath12k_mac_get_fw_stats(struct ath12k *ar, u32 pdev_id,
> +				   u32 vdev_id, u32 stats_id)
> +{
> +	struct ath12k_base *ab = ar->ab;
> +	int ret, left;
> +
> +	mutex_lock(&ar->conf_mutex);
> +
> +	if (ar->state != ATH12K_STATE_ON) {
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
>  					 struct station_info *sinfo)
>  {
>  	struct ath12k_sta *arsta = ath12k_sta_to_arsta(sta);
> +	struct ath12k *ar = arsta->arvif->ar;
> +	s8 signal;
> +	bool db2dbm = test_bit(WMI_TLV_SERVICE_HW_DB2DBM_CONVERSION_SUPPORT,
> +			       ar->ab->wmi_ab.svc_map);
>  
>  	sinfo->rx_duration = arsta->rx_duration;
>  	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_RX_DURATION);
> @@ -8052,8 +8092,18 @@ static void ath12k_mac_op_sta_statistics(struct ieee80211_hw *hw,
>  	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_BITRATE);
>  
>  	/* TODO: Use real NF instead of default one. */
> -	sinfo->signal = arsta->rssi_comb + ATH12K_DEFAULT_NOISE_FLOOR;
> -	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_SIGNAL);
> +	signal = arsta->rssi_comb;
> +
> +	if (!signal &&
> +	    arsta->arvif->vdev_type == WMI_VDEV_TYPE_STA &&
> +	    !(ath12k_mac_get_fw_stats(ar, ar->pdev->pdev_id, 0,
> +				      WMI_REQUEST_VDEV_STAT)))
> +		signal = arsta->rssi_beacon;
> +
> +	if (signal) {
> +		sinfo->signal = db2dbm ? signal : signal + ATH12K_DEFAULT_NOISE_FLOOR;
> +		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_SIGNAL);
> +	}
>  }
>  
>  static int ath12k_mac_op_cancel_remain_on_channel(struct ieee80211_hw *hw,
> @@ -8739,6 +8789,8 @@ static int ath12k_mac_hw_register(struct ath12k_hw *ah)
>  
>  	ath12k_debugfs_register(ar);
>  
> +	init_completion(&ar->fw_stats_complete);
> +
>  	return 0;
>  
>  err_unregister_hw:
> diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
> index a5575ce9eed4..b22be8066834 100644
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
> @@ -6459,8 +6463,101 @@ static void ath12k_peer_assoc_conf_event(struct ath12k_base *ab, struct sk_buff
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
> +	struct ath12k_vif *arvif;
> +	struct ieee80211_sta *sta;
> +	struct ath12k_sta *arsta;
> +	int i, ret = 0;
> +	const void *data = ptr;
> +
> +	if (!ev) {
> +		ath12k_warn(ab, "failed to fetch update stats ev");
> +		return -EPROTO;
> +	}
> +
> +	rcu_read_lock();
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
> +		const struct wmi_vdev_stats_event *src;
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
> +				arsta = ath12k_sta_to_arsta(sta);
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
> @@ -7183,3 +7280,36 @@ void ath12k_wmi_detach(struct ath12k_base *ab)
>  
>  	ath12k_wmi_free_dbring_caps(ab);
>  }
> +
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
> diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
> index 78afc94a815d..ddab15d03a21 100644
> --- a/drivers/net/wireless/ath/ath12k/wmi.h
> +++ b/drivers/net/wireless/ath/ath12k/wmi.h
> @@ -4811,6 +4811,52 @@ struct wmi_twt_disable_event {
>  	__le32 status;
>  } __packed;
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
> +struct wmi_vdev_stats_event {
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

from my v1 comment:
note that _event should only be used for the first TLV in the event payload.
Any subsequent TLVs in either a command or event should use _params

WMI_TAG_STATS_EVENT => _event
WMI_TAG_ARRAY_BYTE => _params


