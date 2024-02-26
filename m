Return-Path: <linux-wireless+bounces-4028-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 507C286817C
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Feb 2024 20:54:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3C041F25934
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Feb 2024 19:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0628860BA1;
	Mon, 26 Feb 2024 19:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WqJW17Y3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134481D558
	for <linux-wireless@vger.kernel.org>; Mon, 26 Feb 2024 19:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708977260; cv=none; b=KV2AQEvQm1VqmOYWr0x2hNzZIqcuNy0D+aVRfMHSNPzkAlhM363AdgyxxmSgnsGEKLSXGqnNhKTMMjUmXr2pjArI0GSJUD349PLwSgS9qS0L0HrgdBoBZvPhyEbzEYx/VPl3xq3cfc4ixjh7Y9eA3g5JneJPFMuT95w1pKZe5hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708977260; c=relaxed/simple;
	bh=9ogZANn7koshyoJb1cvTnbcLGpJeFnqQLKNEWzXmzjw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rLbVJmeOblyO6n/UcELAMYIJhwOHTqBRBqAxDegd4R9DkYGrHbJBSbG5Y997RdloqY5BsAocuu2w5hmJ3+hK5T3604708Wjwjuxz1dyqE3nJ1yWsMUUXZ2fps4QeOwAm6OytwLbzKVlqFL7Fo46vKhQxMYyveYiWyCif5PdSNRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=WqJW17Y3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41QJRVhb031351;
	Mon, 26 Feb 2024 19:54:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=VKH/Sx6kh/WjXl23umFhUU1ntM/8jGMxKgb2MYu85+4=; b=Wq
	JW17Y3oa3fqS/Xx52MDnGQDRUy+5HvxEizP5G1QqbIjc2wIMHsPrVp7rixvVpSu1
	khxDldzm0aDqM7fpUwUb1fWBB18m6leEZLvLujwvCSTJfMk+vlehJXx9sLFiJAxl
	bQai7g2iQriIIvATKG2c6kdWoMH3qgU2Y9wLYmMtYi3lSeRk6vNpKwS82womDEkR
	rzs952HG3b2z6UbLeR9Q5GUREjPiNIPZjMB37PKO6BqXN1L/37ySNZA1FXGBvbK5
	Bn/OvjgUb40z222ANrGrp3aXK2S9gubKqTVn8e5IotjwNrtKGpFu8BjZuALLP36p
	x5bFw4+8qY7UjPKcOzKw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wgwjvgmm6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Feb 2024 19:54:15 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41QJsESW024404
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Feb 2024 19:54:14 GMT
Received: from [10.227.110.203] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 26 Feb
 2024 11:54:13 -0800
Message-ID: <fdf45b59-0032-4e08-bfb5-d0148a6caf4e@quicinc.com>
Date: Mon, 26 Feb 2024 11:54:13 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] wifi: ath11k: add P2P IE in beacon template
Content-Language: en-US
To: Kang Yang <quic_kangyang@quicinc.com>, <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240226060203.2040444-1-quic_kangyang@quicinc.com>
 <20240226060203.2040444-3-quic_kangyang@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240226060203.2040444-3-quic_kangyang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 8bd1Bw5WqCySJMBzx0_JycqFryn5FCoH
X-Proofpoint-ORIG-GUID: 8bd1Bw5WqCySJMBzx0_JycqFryn5FCoH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_11,2024-02-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 clxscore=1015 adultscore=0 bulkscore=0 phishscore=0 impostorscore=0
 mlxscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402260152

On 2/25/2024 10:01 PM, Kang Yang wrote:
> P2P Element is a necessary component of P2P protocol communication.
> It contains the Vendor Specific Information Element which includes
> the WFA OUI and an OUI Type indicating P2P.
> 
> Add P2P IE in beacon template, and implement WMI interface for it.
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.37
> Tested-on: QCA2066 hw2.1 PCI WLAN.HSP.1.1-03926.13-QCAHSPSWPL_V2_SILICONZ_CE-2.52297.2
> 
> Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
> ---
>  drivers/net/wireless/ath/ath11k/mac.c | 103 ++++++++++++++++++++++++--
>  drivers/net/wireless/ath/ath11k/wmi.c |  39 ++++++++++
>  drivers/net/wireless/ath/ath11k/wmi.h |   9 +++
>  3 files changed, 143 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
> index 9240dedf3217..f52dd52dabbb 100644
> --- a/drivers/net/wireless/ath/ath11k/mac.c
> +++ b/drivers/net/wireless/ath/ath11k/mac.c
> @@ -1430,10 +1430,67 @@ static bool ath11k_mac_set_nontx_vif_params(struct ath11k_vif *tx_arvif,
>  	return false;
>  }
>  
> -static void ath11k_mac_set_vif_params(struct ath11k_vif *arvif,
> -				      struct sk_buff *bcn)
> +static int ath11k_mac_setup_bcn_p2p_ie(struct ath11k_vif *arvif,
> +				       struct sk_buff *bcn)
>  {
> +	struct ath11k *ar = arvif->ar;
> +	struct ieee80211_mgmt *mgmt;
> +	const u8 *p2p_ie;
> +	int ret = 0;

unnecessary initializer?

> +
> +	mgmt = (void *)bcn->data;
> +	p2p_ie = cfg80211_find_vendor_ie(WLAN_OUI_WFA, WLAN_OUI_TYPE_WFA_P2P,
> +					 mgmt->u.beacon.variable,
> +					 bcn->len - (mgmt->u.beacon.variable -
> +						     bcn->data));
> +	if (!p2p_ie)
> +		return -ENOENT;
> +
> +	ret = ath11k_wmi_p2p_go_bcn_ie(ar, arvif->vdev_id, p2p_ie);
> +	if (ret) {
> +		ath11k_warn(ar->ab, "failed to submit P2P GO bcn ie for vdev %i: %d\n",
> +			    arvif->vdev_id, ret);
> +		return ret;
> +	}
> +
> +	return ret;
> +}
> +
> +static int ath11k_mac_remove_vendor_ie(struct sk_buff *skb, unsigned int oui,
> +				       u8 oui_type, size_t ie_offset)
> +{
> +	size_t len;
> +	const u8 *next, *end;
> +	u8 *ie;
> +
> +	if (WARN_ON(skb->len < ie_offset))
> +		return -EINVAL;
> +
> +	ie = (u8 *)cfg80211_find_vendor_ie(oui, oui_type,
> +					   skb->data + ie_offset,
> +					   skb->len - ie_offset);
> +	if (!ie)
> +		return -ENOENT;
> +
> +	len = ie[1] + 2;
> +	end = skb->data + skb->len;
> +	next = ie + len;
> +
> +	if (WARN_ON(next > end))
> +		return -EINVAL;
> +
> +	memmove(ie, next, end - next);
> +	skb_trim(skb, skb->len - len);
> +
> +	return 0;
> +}
> +
> +static int ath11k_mac_set_vif_params(struct ath11k_vif *arvif,
> +				     struct sk_buff *bcn)
> +{
> +	struct ath11k_base *ab = arvif->ar->ab;
>  	struct ieee80211_mgmt *mgmt;
> +	int ret = 0;
>  	u8 *ies;
>  
>  	ies = bcn->data + ieee80211_get_hdrlen_from_skb(bcn);
> @@ -1451,6 +1508,32 @@ static void ath11k_mac_set_vif_params(struct ath11k_vif *arvif,
>  		arvif->wpaie_present = true;
>  	else
>  		arvif->wpaie_present = false;
> +
> +	if (arvif->vif->type != NL80211_IFTYPE_AP || !arvif->vif->p2p)
> +		return ret;
> +
> +	ret = ath11k_mac_setup_bcn_p2p_ie(arvif, bcn);
> +	if (ret) {
> +		ath11k_warn(ab, "failed to setup P2P GO bcn ie: %d\n",
> +			    ret);
> +		return ret;
> +	}
> +
> +	/* P2P IE is inserted by firmware automatically (as
> +	 * configured above) so remove it from the base beacon
> +	 * template to avoid duplicate P2P IEs in beacon frames.
> +	 */
> +	ret = ath11k_mac_remove_vendor_ie(bcn, WLAN_OUI_WFA,
> +					  WLAN_OUI_TYPE_WFA_P2P,
> +					  offsetof(struct ieee80211_mgmt,
> +						   u.beacon.variable));
> +	if (ret) {
> +		ath11k_warn(ab, "failed to remove P2P vendor ie: %d\n",
> +			    ret);
> +		return ret;
> +	}
> +
> +	return ret;
>  }
>  
>  static int ath11k_mac_setup_bcn_tmpl_ema(struct ath11k_vif *arvif)
> @@ -1472,10 +1555,12 @@ static int ath11k_mac_setup_bcn_tmpl_ema(struct ath11k_vif *arvif)
>  		return -EPERM;
>  	}
>  
> -	if (tx_arvif == arvif)
> -		ath11k_mac_set_vif_params(tx_arvif, beacons->bcn[0].skb);
> -	else
> +	if (tx_arvif == arvif) {
> +		if (ath11k_mac_set_vif_params(tx_arvif, beacons->bcn[0].skb))
> +			return -EINVAL;
> +	} else {
>  		arvif->wpaie_present = tx_arvif->wpaie_present;
> +	}
>  
>  	for (i = 0; i < beacons->cnt; i++) {
>  		if (tx_arvif != arvif && !nontx_vif_params_set)
> @@ -1534,10 +1619,12 @@ static int ath11k_mac_setup_bcn_tmpl_mbssid(struct ath11k_vif *arvif)
>  		return -EPERM;
>  	}
>  
> -	if (tx_arvif == arvif)
> -		ath11k_mac_set_vif_params(tx_arvif, bcn);
> -	else if (!ath11k_mac_set_nontx_vif_params(tx_arvif, arvif, bcn))
> +	if (tx_arvif == arvif) {
> +		if (ath11k_mac_set_vif_params(tx_arvif, bcn))
> +			return -EINVAL;
> +	} else if (!ath11k_mac_set_nontx_vif_params(tx_arvif, arvif, bcn)) {
>  		return -EINVAL;
> +	}
>  
>  	ret = ath11k_wmi_bcn_tmpl(ar, arvif->vdev_id, &offs, bcn, 0);
>  	kfree_skb(bcn);
> diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
> index 34ab9631ff36..d86fcdd374c6 100644
> --- a/drivers/net/wireless/ath/ath11k/wmi.c
> +++ b/drivers/net/wireless/ath/ath11k/wmi.c
> @@ -1704,6 +1704,45 @@ int ath11k_wmi_send_bcn_offload_control_cmd(struct ath11k *ar,
>  	return ret;
>  }
>  
> +int ath11k_wmi_p2p_go_bcn_ie(struct ath11k *ar, u32 vdev_id,
> +			     const u8 *p2p_ie)
> +{
> +	struct ath11k_pdev_wmi *wmi = ar->wmi;
> +	struct wmi_p2p_go_set_beacon_ie_cmd *cmd;
> +	size_t p2p_ie_len, aligned_len;
> +	struct wmi_tlv *tlv;
> +	struct sk_buff *skb;
> +	int ret, len;
> +
> +	p2p_ie_len = p2p_ie[1] + 2;
> +	aligned_len = roundup(p2p_ie_len, 4);
> +
> +	len = sizeof(*cmd) + TLV_HDR_SIZE + aligned_len;
> +
> +	skb = ath11k_wmi_alloc_skb(wmi->wmi_ab, len);
> +	if (!skb)
> +		return -ENOMEM;
> +
> +	cmd = (struct wmi_p2p_go_set_beacon_ie_cmd *)skb->data;
> +	cmd->tlv_header = FIELD_PREP(WMI_TLV_TAG, WMI_TAG_P2P_GO_SET_BEACON_IE) |
> +			  FIELD_PREP(WMI_TLV_LEN, sizeof(*cmd) - TLV_HDR_SIZE);
> +	cmd->vdev_id = vdev_id;
> +	cmd->ie_buf_len = p2p_ie_len;
> +
> +	tlv = (struct wmi_tlv *)cmd->tlv;
> +	tlv->header = FIELD_PREP(WMI_TLV_TAG, WMI_TAG_ARRAY_BYTE) |
> +		      FIELD_PREP(WMI_TLV_LEN, aligned_len);
> +	memcpy(tlv->value, p2p_ie, p2p_ie_len);
> +
> +	ret = ath11k_wmi_cmd_send(wmi, skb, WMI_P2P_GO_SET_BEACON_IE);
> +	if (ret) {
> +		ath11k_warn(ar->ab, "failed to send WMI_P2P_GO_SET_BEACON_IE\n");
> +		dev_kfree_skb(skb);
> +	}
> +
> +	return ret;
> +}
> +
>  int ath11k_wmi_bcn_tmpl(struct ath11k *ar, u32 vdev_id,
>  			struct ieee80211_mutable_offsets *offs,
>  			struct sk_buff *bcn, u32 ema_params)
> diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
> index bb419e3abb00..4c20202947c7 100644
> --- a/drivers/net/wireless/ath/ath11k/wmi.h
> +++ b/drivers/net/wireless/ath/ath11k/wmi.h
> @@ -3653,6 +3653,13 @@ struct wmi_bcn_tmpl_cmd {
>  	u32 ema_params;
>  } __packed;
>  
> +struct wmi_p2p_go_set_beacon_ie_cmd {
> +	u32 tlv_header;
> +	u32 vdev_id;
> +	u32 ie_buf_len;
> +	u8 tlv[];
> +} __packed;
> +
>  struct wmi_key_seq_counter {
>  	u32 key_seq_counter_l;
>  	u32 key_seq_counter_h;
> @@ -6349,6 +6356,8 @@ int ath11k_wmi_cmd_send(struct ath11k_pdev_wmi *wmi, struct sk_buff *skb,
>  struct sk_buff *ath11k_wmi_alloc_skb(struct ath11k_wmi_base *wmi_sc, u32 len);
>  int ath11k_wmi_mgmt_send(struct ath11k *ar, u32 vdev_id, u32 buf_id,
>  			 struct sk_buff *frame);
> +int ath11k_wmi_p2p_go_bcn_ie(struct ath11k *ar, u32 vdev_id,
> +			     const u8 *p2p_ie);
>  int ath11k_wmi_bcn_tmpl(struct ath11k *ar, u32 vdev_id,
>  			struct ieee80211_mutable_offsets *offs,
>  			struct sk_buff *bcn, u32 ema_param);


