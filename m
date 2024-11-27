Return-Path: <linux-wireless+bounces-15736-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 317CE9DA0BE
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Nov 2024 03:49:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD78E168B84
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Nov 2024 02:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F318538384;
	Wed, 27 Nov 2024 02:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="RkCpeB2x"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B0B1BC20
	for <linux-wireless@vger.kernel.org>; Wed, 27 Nov 2024 02:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732675770; cv=none; b=TkfmVpV821KeqJlAnj/vxSAXdUYlk3cuWfuk0iPsKpMZjP/mGTKP4zZEwy3xoFAM2CjK7V0LK1MGba6GUu7eGua+kj1VjsHqtMg04qG+Z0H72/Ybp8c1WrewBW9og9nsBIQAaxob2PKKGVOfKVYB+r4KHTi0DytGBmPmClSXRlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732675770; c=relaxed/simple;
	bh=c31N4B12IrlFfR6/7EYgCek+te9UMvQhLcxamGBdu64=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Te91nfsWGZf2NJOBQwP1j1bpyEmddebfptY+XM9/GLL3oWsqhmH5qcxNMQsY33CHmhUxCPVpjc7gXPqaZhodYorv9wJSotjGJNrqbRWoWSIaPqZZC7NFrBc/vq+BAl3LA4xwbG5yGlnlLt7yfzg0wkOaWn+807IrwDULBYjBSEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=RkCpeB2x; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AQKMsRx026225;
	Wed, 27 Nov 2024 02:49:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	i5AfvJFBAaohAG7CZn1K40suV9CMsYus0vShpC5iUPc=; b=RkCpeB2xys+icPoX
	8dnfkpZ7rScak50pAx+iGuJI2prmrkbYn/URbQAx17t4yon6cWeHUhEivPAhyusE
	GPUBpva2yTVxks/p3ZiQy+mEpN+ZwwuWux07jahs3Y1BqzqG+K5M+Q6MXNssji69
	LsNHG8AHEHjKRWHHMFuzftX/J9i28W+W+96woRvO5HEkil7XK4ZLsDy9UoDGj279
	mul7NGMVL3e0Vu9l+1WpyxGX6y5Ww257pxHhyIJejan+khCEen0sLIxhSuYB0POL
	1rsBU9wKFwnLGTN6WF0Ei4oIx2YFs+Ku3JUwu4gUZwN2H/C4rx7zxNIsq7etnI2U
	kSzCgQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 435gha9kt6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Nov 2024 02:49:20 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AR2nIg1030356
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Nov 2024 02:49:19 GMT
Received: from [10.231.195.67] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 26 Nov
 2024 18:49:15 -0800
Message-ID: <28bdb726-a7cf-40e7-8bc4-f7602bba1e93@quicinc.com>
Date: Wed, 27 Nov 2024 10:49:13 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/10] wifi: ath12k: ath12k_mac_op_tx(): MLO support
To: Kalle Valo <kvalo@kernel.org>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20241126171139.2350704-1-kvalo@kernel.org>
 <20241126171139.2350704-3-kvalo@kernel.org>
Content-Language: en-US
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <20241126171139.2350704-3-kvalo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Ruhh_O4o0vlURq59LXYdagn6LxuxUMEj
X-Proofpoint-GUID: Ruhh_O4o0vlURq59LXYdagn6LxuxUMEj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 phishscore=0 mlxscore=0 malwarescore=0 impostorscore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411270023



On 11/27/2024 1:11 AM, Kalle Valo wrote:
> From: Sriram R <quic_srirrama@quicinc.com>
> 
> For a frame transmission for an ML vif, mac80211 mentions transmit link id in
> the tx control info. Use it to convert the RA/TA to the corresponding link sta
> and link vif address before enqueueing the frame for transmission.
> 
> For 802.3 data frames, always enqueue the frame on the primary (assoc) link id.
> Firmware does the link selection, builds 802.11 header and therefore the address
> translation too.
> 
> Also ensure right link vif is used for WMI based management transmission and
> add comments to document when RCU read lock is held.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
> Co-developed-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
> Signed-off-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
> ---
>  drivers/net/wireless/ath/ath12k/core.h |   1 +
>  drivers/net/wireless/ath/ath12k/mac.c  | 141 ++++++++++++++++++++++++-
>  2 files changed, 138 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
> index 5be977008319..e246e3d3c162 100644
> --- a/drivers/net/wireless/ath/ath12k/core.h
> +++ b/drivers/net/wireless/ath/ath12k/core.h
> @@ -122,6 +122,7 @@ struct ath12k_skb_cb {
>  	dma_addr_t paddr_ext_desc;
>  	u32 cipher;
>  	u8 flags;
> +	u8 link_id;
>  };
>  
>  struct ath12k_skb_rxcb {
> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
> index a6fe998c177e..97a5f26cc577 100644
> --- a/drivers/net/wireless/ath/ath12k/mac.c
> +++ b/drivers/net/wireless/ath/ath12k/mac.c
> @@ -6848,6 +6848,7 @@ static void ath12k_mgmt_over_wmi_tx_purge(struct ath12k *ar)
>  static void ath12k_mgmt_over_wmi_tx_work(struct wiphy *wiphy, struct wiphy_work *work)
>  {
>  	struct ath12k *ar = container_of(work, struct ath12k, wmi_mgmt_tx_work);
> +	struct ath12k_hw *ah = ar->ah;
>  	struct ath12k_skb_cb *skb_cb;
>  	struct ath12k_vif *ahvif;
>  	struct ath12k_link_vif *arvif;
> @@ -6865,7 +6866,15 @@ static void ath12k_mgmt_over_wmi_tx_work(struct wiphy *wiphy, struct wiphy_work
>  		}
>  
>  		ahvif = ath12k_vif_to_ahvif(skb_cb->vif);
> -		arvif = &ahvif->deflink;
> +		if (!(ahvif->links_map & BIT(skb_cb->link_id))) {
> +			ath12k_warn(ar->ab,
> +				    "invalid linkid %u in mgmt over wmi tx with linkmap 0x%X\n",
s/0x%X/0x%x/ ?

> +				    skb_cb->link_id, ahvif->links_map);
> +			ath12k_mgmt_over_wmi_tx_drop(ar, skb);
> +			continue;
> +		}
> +
> +		arvif = wiphy_dereference(ah->hw->wiphy, ahvif->link[skb_cb->link_id]);
>  		if (ar->allocated_vdev_map & (1LL << arvif->vdev_id)) {
>  			ret = ath12k_mac_mgmt_tx_wmi(ar, arvif, skb);
>  			if (ret) {
> @@ -6875,9 +6884,10 @@ static void ath12k_mgmt_over_wmi_tx_work(struct wiphy *wiphy, struct wiphy_work
>  			}
>  		} else {
>  			ath12k_warn(ar->ab,
> -				    "dropping mgmt frame for vdev %d, is_started %d\n",
> +				    "dropping mgmt frame for vdev %d link_id %u, is_started %d\n",
>  				    arvif->vdev_id,
> -				    arvif->is_started);
> +				    arvif->is_started,
> +				    skb_cb->link_id);
swap 'arvif->is_started' and 'skb_cb->link_id'.

>  			ath12k_mgmt_over_wmi_tx_drop(ar, skb);
>  		}
>  	}
> @@ -6936,6 +6946,105 @@ static void ath12k_mac_add_p2p_noa_ie(struct ath12k *ar,
>  	spin_unlock_bh(&ar->data_lock);
>  }
>  
> +/* Note: called under rcu_read_lock() */
> +static u8 ath12k_mac_get_tx_link(struct ieee80211_sta *sta, struct ieee80211_vif *vif,
> +				 u8 link, struct sk_buff *skb, u32 info_flags)
> +{
> +	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
> +	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
> +	struct ieee80211_link_sta *link_sta;
> +	struct ieee80211_bss_conf *bss_conf;
> +	struct ath12k_sta *ahsta;
better to assert RCU read lock here?

> +
> +	/* Use the link id passed or the default vif link */
> +	if (!sta) {
> +		if (link != IEEE80211_LINK_UNSPECIFIED)
> +			return link;
> +
> +		return ahvif->deflink.link_id;
> +	}
> +
> +	ahsta = ath12k_sta_to_ahsta(sta);
> +
> +	/* Below translation ensures we pass proper A2 & A3 for non ML clients.
> +	 * Also it assumes for now support only for MLO AP in this path
> +	 */
> +	if (!sta->mlo) {
> +		link = ahsta->deflink.link_id;
> +
> +		if (info_flags & IEEE80211_TX_CTL_HW_80211_ENCAP)
> +			return link;
> +
> +		bss_conf = rcu_dereference(vif->link_conf[link]);
> +		if (bss_conf) {
> +			ether_addr_copy(hdr->addr2, bss_conf->addr);
> +			if (!ieee80211_has_tods(hdr->frame_control) &&
> +			    !ieee80211_has_fromds(hdr->frame_control))
> +				ether_addr_copy(hdr->addr3, bss_conf->addr);
> +		}
> +
> +		return link;
> +	}
> +
> +	/* enqueue eth enacap & data frames on primary link, FW does link
> +	 * selection and address translation.
> +	 */
> +	if (info_flags & IEEE80211_TX_CTL_HW_80211_ENCAP ||
> +	    ieee80211_is_data(hdr->frame_control))
> +		return ahsta->assoc_link_id;
> +
> +	/* 802.11 frame cases */
> +	if (link == IEEE80211_LINK_UNSPECIFIED)
> +		link = ahsta->deflink.link_id;
> +
> +	if (!ieee80211_is_mgmt(hdr->frame_control))
> +		return link;
> +
> +	/* Perform address conversion for ML STA Tx */
> +	bss_conf = rcu_dereference(vif->link_conf[link]);
> +	link_sta = rcu_dereference(sta->link[link]);
> +
> +	if (bss_conf && link_sta) {
> +		ether_addr_copy(hdr->addr1, link_sta->addr);
> +		ether_addr_copy(hdr->addr2, bss_conf->addr);
> +
> +		if (vif->type == NL80211_IFTYPE_STATION && bss_conf->bssid)
> +			ether_addr_copy(hdr->addr3, bss_conf->bssid);
> +		else if (vif->type == NL80211_IFTYPE_AP)
> +			ether_addr_copy(hdr->addr3, bss_conf->addr);
> +
> +		return link;
> +	}
> +
> +	if (bss_conf) {
> +		/* In certain cases where a ML sta associated and added subset of
> +		 * links on which the ML AP is active, but now sends some frame
> +		 * (ex. Probe request) on a different link which is active in our
> +		 * MLD but was not added during previous association, we can
> +		 * still honor the Tx to that ML STA via the requested link.
> +		 * The control would reach here in such case only when that link
> +		 * address is same as the MLD address or in worst case clients
> +		 * used MLD address at TA wrongly which would have helped
> +		 * identify the ML sta object and pass it here.
> +		 * If the link address of that STA is different from MLD address,
> +		 * then the sta object would be NULL and control won't reach
> +		 * here but return at the start of the function itself with !sta
> +		 * check. Also this would not need any translation at hdr->addr1
> +		 * from MLD to link address since the RA is the MLD address
> +		 * (same as that link address ideally) already.
> +		 */
> +		ether_addr_copy(hdr->addr2, bss_conf->addr);
> +
> +		if (vif->type == NL80211_IFTYPE_STATION && bss_conf->bssid)
> +			ether_addr_copy(hdr->addr3, bss_conf->bssid);
> +		else if (vif->type == NL80211_IFTYPE_AP)
> +			ether_addr_copy(hdr->addr3, bss_conf->addr);
> +	}
> +
> +	return link;
> +}
> +
> +/* Note: called under rcu_read_lock() */
>  static void ath12k_mac_op_tx(struct ieee80211_hw *hw,
>  			     struct ieee80211_tx_control *control,
>  			     struct sk_buff *skb)
> @@ -6945,13 +7054,16 @@ static void ath12k_mac_op_tx(struct ieee80211_hw *hw,
>  	struct ieee80211_vif *vif = info->control.vif;
>  	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
>  	struct ath12k_link_vif *arvif = &ahvif->deflink;
> -	struct ath12k *ar = arvif->ar;
>  	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
>  	struct ieee80211_key_conf *key = info->control.hw_key;
> +	struct ieee80211_sta *sta = control->sta;
>  	u32 info_flags = info->flags;
> +	struct ath12k *ar;
>  	bool is_prb_rsp;
> +	u8 link_id;
>  	int ret;
>  
better to assert RCU read lock here?

> +	link_id = u32_get_bits(info->control.flags, IEEE80211_TX_CTRL_MLO_LINK);
>  	memset(skb_cb, 0, sizeof(*skb_cb));
>  	skb_cb->vif = vif;
>  
> @@ -6960,6 +7072,27 @@ static void ath12k_mac_op_tx(struct ieee80211_hw *hw,
>  		skb_cb->flags |= ATH12K_SKB_CIPHER_SET;
>  	}
>  
> +	/* handle only for MLO case, use deflink for non MLO case */
> +	if (vif->valid_links) {
better to use ieee80211_vif_is_mld() helper?

> +		link_id = ath12k_mac_get_tx_link(sta, vif, link_id, skb, info_flags);
> +		if (link_id >= IEEE80211_MLD_MAX_NUM_LINKS) {
> +			ieee80211_free_txskb(hw, skb);
> +			return;
> +		}
> +	} else {
> +		link_id = 0;
> +	}
> +
> +	arvif = rcu_dereference(ahvif->link[link_id]);
> +	if (!arvif || !arvif->ar) {
> +		ath12k_warn(ahvif->ah, "failed to find arvif link id %u for frame transmission",
> +			    link_id);
> +		ieee80211_free_txskb(hw, skb);
> +		return;
> +	}
> +
> +	ar = arvif->ar;
> +	skb_cb->link_id = link_id;
>  	is_prb_rsp = ieee80211_is_probe_resp(hdr->frame_control);
>  
>  	if (info_flags & IEEE80211_TX_CTL_HW_80211_ENCAP) {


