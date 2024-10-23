Return-Path: <linux-wireless+bounces-14428-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4DC79ACFBE
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2024 18:10:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43EF4282A64
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2024 16:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB357D07D;
	Wed, 23 Oct 2024 16:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="TtRZVHdU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E374436E
	for <linux-wireless@vger.kernel.org>; Wed, 23 Oct 2024 16:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729699818; cv=none; b=eweYcnVNr+IIyRjUzMvaO3L8zqhGvXOtrdbM62YBbn9GikeHiecZSmeO5BND+vIW4xqDt/Qe4+rXxDJl+47pVSP11uA49VREYzfo3UzUXmao7+iK/BQIyHOXCviRbhrxnLd4GF1NZBFLZKyP+8MwxZxKQZOQLk5oLAgJuGQFo3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729699818; c=relaxed/simple;
	bh=/1rPDdbwe3zzxUM2y1hdCQYK8gfwJTXIO/UzV3yoPPo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RaeHiDdBTUUoOggH3QtgEhEal1WyzjgrbSxuoIWrvWqHAE9JqiHUzkjAwCTcEVfH/XGenzWdpxPPaSV8aCO8UemYlMpmzew+7fxbSf/kvZPdyN+LDo9d2PmMrTFOTUI5We21FRhVOXd/tJ6Mzue2L1TQPAjTLpYuowxD8afcebs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=TtRZVHdU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49N9wuki016177;
	Wed, 23 Oct 2024 16:10:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bIfVHdpxCpK+zcFiZWmxDhwEivfsNnyWJqTHhB3s/ZY=; b=TtRZVHdUIOxfKIiM
	zFuYNhFhFdrI1c3/vIHJ6kbDluzoI0/yok9NHkusbKb+3d25XzZyOje9aB5O3PjK
	FUCa7b/8r3Ez2RDlUnG73WKuWJav7nElcoQDUOM+PgfnpA/t58mGp0XE6+OksEn8
	9Aiyv7GWLitX8csulqpBY1KeV8VbgZLS6TYU9LNwWc8Iw9yVI29JXwFo42EnlcuH
	fmQKvKavJlXWl46GTsR6i34kifchJZXmKE2gYQDxfd+wSH5zCJ6fNIdqJ/kVvV+S
	zd97RwlbJuUVrcLX0TrPBSqihWtCAy1oTRND1/a49DUQm6AFqJIiIgosoQ+P2r0J
	73UKqw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42em3xjsrt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Oct 2024 16:10:10 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49NGAAcl014268
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Oct 2024 16:10:10 GMT
Received: from [10.48.242.6] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 23 Oct
 2024 09:10:09 -0700
Message-ID: <cb386a9b-2290-4640-8f08-7834cf4e79df@quicinc.com>
Date: Wed, 23 Oct 2024 09:10:09 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] wifi: ath12k: Add MLO peer assoc command support
To: Kalle Valo <kvalo@kernel.org>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20241023133004.2253830-1-kvalo@kernel.org>
 <20241023133004.2253830-9-kvalo@kernel.org>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <20241023133004.2253830-9-kvalo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: aoUDjNnLolHy-5y9QNU0k5pKGHNOe_Qi
X-Proofpoint-ORIG-GUID: aoUDjNnLolHy-5y9QNU0k5pKGHNOe_Qi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 impostorscore=0 mlxscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 mlxlogscore=999 malwarescore=0 priorityscore=1501 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410230100

On 10/23/2024 6:30 AM, Kalle Valo wrote:
> From: Sriram R <quic_srirrama@quicinc.com>
> 
> Add changes to send MLO peer assoc command with partner link details and
> primary umac details
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
> Signed-off-by: Harshitha Prem <quic_hprem@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
> ---
>  drivers/net/wireless/ath/ath12k/core.h |  7 +++
>  drivers/net/wireless/ath/ath12k/mac.c  | 62 ++++++++++++++++++++
>  drivers/net/wireless/ath/ath12k/wmi.c  | 79 ++++++++++++++++++++++++--
>  drivers/net/wireless/ath/ath12k/wmi.h  | 46 +++++++++++++++
>  4 files changed, 188 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
> index 0a0c1a1594f2..e7a2d43e7b8a 100644
> --- a/drivers/net/wireless/ath/ath12k/core.h
> +++ b/drivers/net/wireless/ath/ath12k/core.h
> @@ -487,9 +487,16 @@ struct ath12k_link_sta {
>  	struct ath12k_rx_peer_stats *rx_stats;
>  	struct ath12k_wbm_tx_stats *wbm_tx_stats;
>  	u32 bw_prev;
> +
> +	/* For now the assoc link will be considered primary */
> +	bool is_assoc_link;
> +
> +	 /* for firmware use only */
> +	u8 link_idx;
>  };
>  
>  struct ath12k_sta {
> +	struct ath12k_vif *ahvif;
>  	enum hal_pn_type pn_type;
>  	struct ath12k_link_sta deflink;
>  	struct ath12k_link_sta __rcu *link[IEEE80211_MLD_MAX_NUM_LINKS];
> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
> index b628bc2fd0f5..2e79849974f0 100644
> --- a/drivers/net/wireless/ath/ath12k/mac.c
> +++ b/drivers/net/wireless/ath/ath12k/mac.c
> @@ -2873,6 +2873,67 @@ static void ath12k_peer_assoc_h_eht(struct ath12k *ar,
>  	arg->punct_bitmap = ~arvif->punct_bitmap;
>  }
>  
> +static void ath12k_peer_assoc_h_mlo(struct ath12k_link_sta *arsta,
> +				    struct ath12k_wmi_peer_assoc_arg *arg)
> +{
> +	struct ieee80211_sta *sta = ath12k_ahsta_to_sta(arsta->ahsta);
> +	struct peer_assoc_mlo_params *ml = &arg->ml;
> +	struct ath12k_sta *ahsta = arsta->ahsta;
> +	struct ath12k_link_sta *arsta_p;
> +	struct ath12k_link_vif *arvif;
> +	unsigned long links;
> +	u8 link_id;
> +	int i;
> +
> +	if (!sta->mlo || ahsta->ml_peer_id == ATH12K_MLO_PEER_ID_INVALID)
> +		return;
> +
> +	ml->enabled = true;
> +	ml->assoc_link = arsta->is_assoc_link;
> +
> +	/* For now considering the primary umac based on assoc link */
> +	ml->primary_umac = arsta->is_assoc_link;
> +	ml->peer_id_valid = true;
> +	ml->logical_link_idx_valid = true;
> +
> +	ether_addr_copy(ml->mld_addr, sta->addr);
> +	ml->logical_link_idx = arsta->link_idx;
> +	ml->ml_peer_id = ahsta->ml_peer_id;
> +	ml->ieee_link_id = arsta->link_id;
> +	ml->num_partner_links = 0;
> +	links = ahsta->links_map;
> +
> +	rcu_read_lock();
> +
> +	i = 0;

nit: setting i=0 doesn't need to be RCU protected

> +
> +	for_each_set_bit(link_id, &links, IEEE80211_MLD_MAX_NUM_LINKS) {
> +		if (i >= ATH12K_WMI_MLO_MAX_LINKS)
> +			break;
> +
> +		arsta_p = rcu_dereference(ahsta->link[link_id]);
> +		arvif = rcu_dereference(ahsta->ahvif->link[link_id]);
> +
> +		if (arsta_p == arsta)
> +			continue;
> +
> +		if (!arvif->is_started)
> +			continue;
> +
> +		ml->partner_info[i].vdev_id = arvif->vdev_id;
> +		ml->partner_info[i].hw_link_id = arvif->ar->pdev->hw_link_id;
> +		ml->partner_info[i].assoc_link = arsta_p->is_assoc_link;
> +		ml->partner_info[i].primary_umac = arsta_p->is_assoc_link;
> +		ml->partner_info[i].logical_link_idx_valid = true;
> +		ml->partner_info[i].logical_link_idx = arsta_p->link_idx;
> +		ml->num_partner_links++;
> +
> +		i++;
> +	}
> +
> +	rcu_read_unlock();
> +}
> +
>  static void ath12k_peer_assoc_prepare(struct ath12k *ar,
>  				      struct ath12k_link_vif *arvif,
>  				      struct ath12k_link_sta *arsta,
> @@ -2897,6 +2958,7 @@ static void ath12k_peer_assoc_prepare(struct ath12k *ar,
>  	ath12k_peer_assoc_h_qos(ar, arvif, arsta, arg);
>  	ath12k_peer_assoc_h_phymode(ar, arvif, arsta, arg);
>  	ath12k_peer_assoc_h_smps(arsta, arg);
> +	ath12k_peer_assoc_h_mlo(arsta, arg);
>  
>  	/* TODO: amsdu_disable req? */
>  }
> diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
> index 0583d832fac7..73c1c6bcf48b 100644
> --- a/drivers/net/wireless/ath/ath12k/wmi.c
> +++ b/drivers/net/wireless/ath/ath12k/wmi.c
> @@ -2101,12 +2101,15 @@ int ath12k_wmi_send_peer_assoc_cmd(struct ath12k *ar,
>  	struct ath12k_wmi_vht_rate_set_params *mcs;
>  	struct ath12k_wmi_he_rate_set_params *he_mcs;
>  	struct ath12k_wmi_eht_rate_set_params *eht_mcs;
> +	struct wmi_peer_assoc_mlo_params *ml_params;
> +	struct wmi_peer_assoc_mlo_partner_info *partner_info;
>  	struct sk_buff *skb;
>  	struct wmi_tlv *tlv;
>  	void *ptr;
>  	u32 peer_legacy_rates_align;
>  	u32 peer_ht_rates_align;
>  	int i, ret, len;
> +	__le32 v;
>  
>  	peer_legacy_rates_align = roundup(arg->peer_legacy_rates.num_rates,
>  					  sizeof(u32));
> @@ -2118,8 +2121,13 @@ int ath12k_wmi_send_peer_assoc_cmd(struct ath12k *ar,
>  	      TLV_HDR_SIZE + (peer_ht_rates_align * sizeof(u8)) +
>  	      sizeof(*mcs) + TLV_HDR_SIZE +
>  	      (sizeof(*he_mcs) * arg->peer_he_mcs_count) +
> -	      TLV_HDR_SIZE + (sizeof(*eht_mcs) * arg->peer_eht_mcs_count) +
> -	      TLV_HDR_SIZE + TLV_HDR_SIZE;
> +	      TLV_HDR_SIZE + (sizeof(*eht_mcs) * arg->peer_eht_mcs_count);
> +
> +	if (arg->ml.enabled)
> +		len += TLV_HDR_SIZE + sizeof(*ml_params) +
> +		       TLV_HDR_SIZE + (arg->ml.num_partner_links * sizeof(*partner_info));
> +	else
> +		len += (2 * TLV_HDR_SIZE);
>  
>  	skb = ath12k_wmi_alloc_skb(wmi->wmi_ab, len);
>  	if (!skb)
> @@ -2243,12 +2251,38 @@ int ath12k_wmi_send_peer_assoc_cmd(struct ath12k *ar,
>  		ptr += sizeof(*he_mcs);
>  	}
>  
> -	/* MLO header tag with 0 length */
> -	len = 0;
>  	tlv = ptr;
> +	len = arg->ml.enabled ? sizeof(*ml_params) : 0;
>  	tlv->header = ath12k_wmi_tlv_hdr(WMI_TAG_ARRAY_STRUCT, len);
>  	ptr += TLV_HDR_SIZE;
> +	if (!len)
> +		goto skip_ml_params;
>  
> +	ml_params = ptr;
> +	ml_params->tlv_header = ath12k_wmi_tlv_cmd_hdr(WMI_TAG_MLO_PEER_ASSOC_PARAMS,
> +						       len);

this is another instance where we are using the same length for two
consecutive TLVs -- that doesn't seem right

> +	ml_params->flags = cpu_to_le32(ATH12K_WMI_FLAG_MLO_ENABLED);
> +
> +	if (arg->ml.assoc_link)
> +		ml_params->flags |= cpu_to_le32(ATH12K_WMI_FLAG_MLO_ASSOC_LINK);
> +
> +	if (arg->ml.primary_umac)
> +		ml_params->flags |= cpu_to_le32(ATH12K_WMI_FLAG_MLO_PRIMARY_UMAC);
> +
> +	if (arg->ml.logical_link_idx_valid)
> +		ml_params->flags |=
> +			cpu_to_le32(ATH12K_WMI_FLAG_MLO_LOGICAL_LINK_IDX_VALID);
> +
> +	if (arg->ml.peer_id_valid)
> +		ml_params->flags |= cpu_to_le32(ATH12K_WMI_FLAG_MLO_PEER_ID_VALID);
> +
> +	ether_addr_copy(ml_params->mld_addr.addr, arg->ml.mld_addr);
> +	ml_params->logical_link_idx = cpu_to_le32(arg->ml.logical_link_idx);
> +	ml_params->ml_peer_id = cpu_to_le32(arg->ml.ml_peer_id);
> +	ml_params->ieee_link_id = cpu_to_le32(arg->ml.ieee_link_id);
> +	ptr += sizeof(*ml_params);
> +
> +skip_ml_params:
>  	/* Loop through the EHT rate set */
>  	len = arg->peer_eht_mcs_count * sizeof(*eht_mcs);
>  	tlv = ptr;
> @@ -2265,12 +2299,45 @@ int ath12k_wmi_send_peer_assoc_cmd(struct ath12k *ar,
>  		ptr += sizeof(*eht_mcs);
>  	}
>  
> -	/* ML partner links tag with 0 length */
> -	len = 0;
>  	tlv = ptr;
> +	len = arg->ml.enabled ? arg->ml.num_partner_links * sizeof(*partner_info) : 0;
> +	/* fill ML Partner links */
>  	tlv->header = ath12k_wmi_tlv_hdr(WMI_TAG_ARRAY_STRUCT, len);
>  	ptr += TLV_HDR_SIZE;
>  
> +	if (len == 0)
> +		goto send;
> +
> +	for (i = 0; i < arg->ml.num_partner_links; i++) {
> +		u32 cmd = WMI_TAG_MLO_PARTNER_LINK_PARAMS_PEER_ASSOC;
> +
> +		partner_info = ptr;
> +		partner_info->tlv_header = ath12k_wmi_tlv_cmd_hdr(cmd,
> +								  sizeof(*partner_info));
> +		partner_info->vdev_id = cpu_to_le32(arg->ml.partner_info[i].vdev_id);
> +		partner_info->hw_link_id =
> +			cpu_to_le32(arg->ml.partner_info[i].hw_link_id);
> +		partner_info->flags = cpu_to_le32(ATH12K_WMI_FLAG_MLO_ENABLED);
> +
> +		if (arg->ml.partner_info[i].assoc_link)
> +			partner_info->flags |=
> +				cpu_to_le32(ATH12K_WMI_FLAG_MLO_ASSOC_LINK);
> +
> +		if (arg->ml.partner_info[i].primary_umac)
> +			partner_info->flags |=
> +				cpu_to_le32(ATH12K_WMI_FLAG_MLO_PRIMARY_UMAC);
> +
> +		if (arg->ml.partner_info[i].logical_link_idx_valid) {
> +			v = cpu_to_le32(ATH12K_WMI_FLAG_MLO_LINK_ID_VALID);
> +			partner_info->flags |= v;
> +		}
> +
> +		partner_info->logical_link_idx =
> +			cpu_to_le32(arg->ml.partner_info[i].logical_link_idx);
> +		ptr += sizeof(*partner_info);
> +	}
> +
> +send:
>  	ath12k_dbg(ar->ab, ATH12K_DBG_WMI,
>  		   "wmi peer assoc vdev id %d assoc id %d peer mac %pM peer_flags %x rate_caps %x peer_caps %x listen_intval %d ht_caps %x max_mpdu %d nss %d phymode %d peer_mpdu_density %d vht_caps %x he cap_info %x he ops %x he cap_info_ext %x he phy %x %x %x peer_bw_rxnss_override %x peer_flags_ext %x eht mac_cap %x %x eht phy_cap %x %x %x\n",
>  		   cmd->vdev_id, cmd->peer_associd, arg->peer_mac,
> diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
> index 07bd275608bf..e93f74e97771 100644
> --- a/drivers/net/wireless/ath/ath12k/wmi.h
> +++ b/drivers/net/wireless/ath/ath12k/wmi.h
> @@ -3698,6 +3698,24 @@ struct wmi_vdev_install_key_arg {
>  #define WMI_HECAP_TXRX_MCS_NSS_IDX_160		1
>  #define WMI_HECAP_TXRX_MCS_NSS_IDX_80_80	2
>  
> +#define ATH12K_WMI_MLO_MAX_PARTNER_LINKS \
> +	(ATH12K_WMI_MLO_MAX_LINKS + ATH12K_MAX_NUM_BRIDGE_LINKS - 1)
> +
> +struct peer_assoc_mlo_params {
> +	bool enabled;
> +	bool assoc_link;
> +	bool primary_umac;
> +	bool peer_id_valid;
> +	bool logical_link_idx_valid;
> +	bool bridge_peer;
> +	u8 mld_addr[ETH_ALEN];
> +	u32 logical_link_idx;
> +	u32 ml_peer_id;
> +	u32 ieee_link_id;
> +	u8 num_partner_links;
> +	struct wmi_ml_partner_info partner_info[ATH12K_WMI_MLO_MAX_LINKS];
> +};
> +
>  struct wmi_rate_set_arg {
>  	u32 num_rates;
>  	u8 rates[WMI_MAX_SUPPORTED_RATES];
> @@ -3772,8 +3790,36 @@ struct ath12k_wmi_peer_assoc_arg {
>  	u32 peer_eht_tx_mcs_set[WMI_MAX_EHTCAP_RATE_SET];
>  	struct ath12k_wmi_ppe_threshold_arg peer_eht_ppet;
>  	u32 punct_bitmap;
> +	bool is_assoc;
> +	struct peer_assoc_mlo_params ml;
>  };
>  
> +#define ATH12K_WMI_FLAG_MLO_ENABLED			BIT(0)
> +#define ATH12K_WMI_FLAG_MLO_ASSOC_LINK			BIT(1)
> +#define ATH12K_WMI_FLAG_MLO_PRIMARY_UMAC		BIT(2)
> +#define ATH12K_WMI_FLAG_MLO_LINK_ID_VALID		BIT(3)
> +#define ATH12K_WMI_FLAG_MLO_PEER_ID_VALID		BIT(4)
> +
> +struct wmi_peer_assoc_mlo_partner_info {

this doesn't follow the WMI naming convention, should be _params

> +	__le32 tlv_header;
> +	__le32 vdev_id;
> +	__le32 hw_link_id;
> +	__le32 flags;
> +	__le32 logical_link_idx;
> +} __packed;
> +
> +struct wmi_peer_assoc_mlo_params {
> +	__le32 tlv_header;
> +	__le32 flags;
> +	struct wmi_mac_addr mld_addr;
> +	__le32 logical_link_idx;
> +	__le32 ml_peer_id;
> +	__le32 ieee_link_id;
> +	__le32 emlsr_trans_timeout_us;
> +	__le32 emlsr_trans_delay_us;
> +	__le32 emlsr_padding_delay_us;
> +} __packed;
> +
>  struct wmi_peer_assoc_complete_cmd {
>  	__le32 tlv_header;
>  	struct ath12k_wmi_mac_addr_params peer_macaddr;


