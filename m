Return-Path: <linux-wireless+bounces-24036-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9E3AAD68FB
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jun 2025 09:26:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9828A1885107
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jun 2025 07:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 457641EB1BF;
	Thu, 12 Jun 2025 07:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gov0/ZPB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22FDE20371F
	for <linux-wireless@vger.kernel.org>; Thu, 12 Jun 2025 07:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749713174; cv=none; b=dkUUgtQSqNBcqjAKTF+0AinJyzH+uQWY+OGDTGzuu21pE21b3J7kln84fkgw4vMgKff3Tej5pGdX+sdynGxsXqAjTiig3jVRD6ovUwtaezrdz1T/73QxuRAB5uRAwiMn/NgtUUOg0TYG979eMSZqYN1pN5nnavjlXX+0f6Z/aC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749713174; c=relaxed/simple;
	bh=7nrCkvp8L6CwS+OvDHUZY5BzH1LXbTD5qltZ3by4hNI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XTMhAfsYcaeOxlOrYtwBP3ImSip+OU0TB0lrlcrk0P1Rmv/ZIM7TZPmcC3z/1NEmXgeBBzyYcsGZ/yRmkJU9SoszTJD1FZc6vMZ2qSSRNzhJo8MZooF2334MNjLHlnUldjJ0DwKgi97HF6+sWKiLOGbN8V5fYknDj92NQSVeeSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=gov0/ZPB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55BJ9C82029276;
	Thu, 12 Jun 2025 07:25:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TkqyvtD4yUHDLk1qavELgP1NQ2WS0LnUcOpxQpjdWRs=; b=gov0/ZPBmeangHmN
	byPOmGCxO05nReDmVgeGacnjKLnewuUHa1sV2xG+iKlL7bD1chH5yScRYuhnk8rY
	ZibOQK7Igitqz5v6+KR9djMLPXkCmTCVPIYKlrtXKmasAO873egAdm9Z3jWoriRP
	1lNVshr96cGwc3LxfHKx/twfqPmp2cCLWcKG5XYxepvcQ07JmMihwKlZg+bGXD1m
	/CFIXsYAiBBvnBaldZYHzRX4XLje54DURZMG/XpIgiNXukPX2EdorQbziJ7lrfua
	wPdHfHp83aogP/uArFcYATHJbfT/QSM0xOyIGwSIsdtRgOWFk6qppyPloVaiCJ16
	v26yew==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 474dn6fkyf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Jun 2025 07:25:47 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 55C7PlDF016864
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Jun 2025 07:25:47 GMT
Received: from [10.152.204.0] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 12 Jun
 2025 00:25:44 -0700
Message-ID: <a7558f69-4a1f-a9a1-d280-365b3b9f7bd9@quicinc.com>
Date: Thu, 12 Jun 2025 12:55:41 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 RESEND] ath11k: add support for dynamic vlan (ap/vlan)
To: =?UTF-8?Q?David_Rapa=c5=88?= <david@rapan.cz>,
        "ath11k@lists.infradead.org" <ath11k@lists.infradead.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "jjohnson@kernel.org" <jjohnson@kernel.org>,
        "johannes@sipsolutions.net"
	<johannes@sipsolutions.net>
References: <DB6PR08MB2693F4C5448E5911E9560E4ADF6CA@DB6PR08MB2693.eurprd08.prod.outlook.com>
Content-Language: en-US
From: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
In-Reply-To: <DB6PR08MB2693F4C5448E5911E9560E4ADF6CA@DB6PR08MB2693.eurprd08.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEyMDA1NiBTYWx0ZWRfX6Sg/JUhfEWIb
 7jG5e7g6m2Ow++Qn9ub2MabbMTPb/aQiyg5Dz09NNFTmqVruKbr1OYxvOKXRjSMUC5LcizuuD5y
 reKRzrLBvRxN689j9QhxKfO6jbscHJOt1ioKu+Tx6pDDoh/5XhDbnFivB+yOJcaLqoiy0Siqz/1
 LmXyoM1gEfFLjyJn1wXxsxYrZKpAi2KytLAw1f33CjAj512A8/T70JqDzrsq/CTtZ+ZmxyeYTE/
 5mBEh4X2rw8tA+YqtJif4UFomk724xXWnp0raQ9jpOxTipNUX7kkx3yxVmpdJPmuItbBXAbEVqG
 kvjaHApXfQfwI7aKzTD7ZAACoX+iyIHSkdZNALMcTc43JDSV7f1k8760nF0okSob1fXJHcw0VYJ
 ZJ8Basrp0EtIHZLcQQvIAzfPAHlZrbtiQndQkUQCoD4Bl+73JG8yMmUcHDzyxkXes5cyrvHI
X-Proofpoint-GUID: FNysh1m4K-FHfodrzVVCj2W8CumHY0d6
X-Authority-Analysis: v=2.4 cv=FaQ3xI+6 c=1 sm=1 tr=0 ts=684a80fb cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=LpQP-O61AAAA:8
 a=nxn0ltvvKMxvSYCdZUEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=pioyyrs4ZptJ924tMmac:22
X-Proofpoint-ORIG-GUID: FNysh1m4K-FHfodrzVVCj2W8CumHY0d6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-12_04,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 suspectscore=0 malwarescore=0
 priorityscore=1501 clxscore=1011 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506120056



On 6/5/2025 4:52 AM, David Rapaň wrote:
> ath11k currently lacks support for dynamic vlan (AP/VLAN), so make
> '__ath11k_mac_register' in dp_tx to register 'NL80211_IFTYPE_AP_VLAN'
> as available interface mode.
> 
> Make 'ath11k_dp_tx' in dp_tx to add metadata info to notify firmware
> that the multicast/broadcast packets are encrypted in software.
> 
> Make '__ieee80211_subif_start_xmit' in tx to offload encapsulation
> for VLAN unicast packets using 8023 xmit path instead of current
> 80211 xmit path.
> 
> Tested, long-term in production environment using OpenWrt platform
> installed on multiple AX3600 with FT:
>   Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.9.0.1-01385-QCAHKSWPL_SILICONZ-1
>   Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.9.0.1-01977-QCAHKSWPL_SILICONZ-1
> 
> Co-developed-by: Seevalamuthu Mariappan <seevalam@codeaurora.org>
> Signed-off-by: Seevalamuthu Mariappan <seevalam@codeaurora.org>
> Signed-off-by: David Rapan <david@rapan.cz>
> ---
> v1 -> v2: Move 'cpu_to_be16(ETH_P_PAE)' to earlier condition and add
>   'ieee80211_is_qos_nullfunc' check so QoS NULL Data frames are
>   properly send as open type frames with TID 7 in ethernet encap
>   instead of QoS Data with TID 0.
> v2 -> v3: Make 'hal_tx_msdu_metadata' struct to comply with current
>   coding standard (no use of bit masks in '__packed').
>   Make key retrieval in 8023 xmit path from
>   '__ieee80211_subif_start_xmit' to be on pair with the standard flow in
>   'ieee80211_subif_start_xmit_8023' where it also falls back to
>   'default_unicast_key'.
> 
>   drivers/net/wireless/ath/ath11k/core.h     |   1 +
>   drivers/net/wireless/ath/ath11k/dp_tx.c    |  83 +++++++++-
>   drivers/net/wireless/ath/ath11k/hal_desc.h | 160 ++++++++++++++++++++
>   drivers/net/wireless/ath/ath11k/mac.c      |   3 +
>   net/mac80211/tx.c                          |  15 +++
>   5 files changed, 260 insertions(+), 2 deletions(-)
> 
> base-commit: ff8069c7cf3eb0fcd53adebdf341b6aaa98bdd3b
> 
> --- a/drivers/net/wireless/ath/ath11k/core.h
> +++ b/drivers/net/wireless/ath/ath11k/core.h
> @@ -120,6 +120,7 @@ struct ath11k_skb_cb {
>   	u32 cipher;
>   	struct ath11k *ar;
>   	struct ieee80211_vif *vif;
> +	u32 pkt_offset;
>   } __packed;
>   
>   struct ath11k_skb_rxcb {
> --- a/drivers/net/wireless/ath/ath11k/dp_tx.c
> +++ b/drivers/net/wireless/ath/ath11k/dp_tx.c
> @@ -79,6 +79,43 @@ enum hal_encrypt_type ath11k_dp_tx_get_e
>   	}
>   }
>   
> +#define HTT_META_DATA_ALIGNMENT	0x8
> +
> +static int ath11k_dp_metadata_align_skb(struct sk_buff *skb, u8 align_len)
> +{
> +	if (unlikely(skb_cow_head(skb, align_len)))
> +		return -ENOMEM;
> +
> +	skb_push(skb, align_len);
> +	memset(skb->data, 0, align_len);
> +	return 0;
> +}
> +
> +static int ath11k_dp_prepare_htt_metadata(struct sk_buff *skb,
> +					 u8 *htt_metadata_size)
> +{
> +	u8 htt_desc_size;
> +	/* Size rounded of multiple of 8 bytes */
> +	u8 htt_desc_size_aligned;
> +	int ret;
> +	struct hal_tx_msdu_metadata *desc_ext;
> +
> +	htt_desc_size = sizeof(struct hal_tx_msdu_metadata);
> +	htt_desc_size_aligned = ALIGN(htt_desc_size, HTT_META_DATA_ALIGNMENT);
> +
> +	ret = ath11k_dp_metadata_align_skb(skb, htt_desc_size_aligned);
> +	if (unlikely(ret))
> +		return ret;
> +
> +	desc_ext = (struct hal_tx_msdu_metadata *)skb->data;
> +	desc_ext->info0 = le32_encode_bits(1, HAL_TX_MSDU_METADATA_INFO0_ENCRYPT_FLAG) |
> +			  le32_encode_bits(0, HAL_TX_MSDU_METADATA_INFO0_ENCRYPT_TYPE) |
> +			  le32_encode_bits(1,
> +					   HAL_TX_MSDU_METADATA_INFO0_HOST_TX_DESC_POOL);
> +	*htt_metadata_size = htt_desc_size_aligned;
> +	return 0;
> +}
> +
>   int ath11k_dp_tx(struct ath11k *ar, struct ath11k_vif *arvif,
>   		 struct ath11k_sta *arsta, struct sk_buff *skb)
>   {
> @@ -97,6 +134,9 @@ int ath11k_dp_tx(struct ath11k *ar, stru
>   	u32 ring_selector = 0;
>   	u8 ring_map = 0;
>   	bool tcl_ring_retry;
> +	bool is_diff_encap = false;
> +	u8 align_pad;
> +	u8 htt_meta_size = 0;
>   
>   	if (unlikely(test_bit(ATH11K_FLAG_CRASH_FLUSH, &ar->ab->dev_flags)))
>   		return -ESHUTDOWN;
> @@ -189,7 +229,12 @@ tcl_ring_sel:
>   
>   	switch (ti.encap_type) {
>   	case HAL_TCL_ENCAP_TYPE_NATIVE_WIFI:
> -		ath11k_dp_tx_encap_nwifi(skb);
> +		if ((arvif->vif->offload_flags & IEEE80211_OFFLOAD_ENCAP_ENABLED) &&
> +		    (skb->protocol == cpu_to_be16(ETH_P_PAE) ||
> +		     ieee80211_is_qos_nullfunc(hdr->frame_control)))
> +			is_diff_encap = true;
> +		else
> +			ath11k_dp_tx_encap_nwifi(skb);

I dont think this is related to dynamic AP_VLAN

>   		break;
>   	case HAL_TCL_ENCAP_TYPE_RAW:
>   		if (!test_bit(ATH11K_FLAG_RAW_MODE, &ab->dev_flags)) {
> @@ -208,6 +253,33 @@ tcl_ring_sel:
>   		goto fail_remove_idr;
>   	}
>   
> +	/* Add metadata for software encryption of vlan group traffic */
> +	if ((!test_bit(ATH11K_FLAG_HW_CRYPTO_DISABLED, &ar->ab->dev_flags) &&
> +	     !(info->control.flags & IEEE80211_TX_CTL_HW_80211_ENCAP) &&
> +	     !info->control.hw_key && ieee80211_has_protected(hdr->frame_control)) ||
> +	    is_diff_encap) {
> +		/* HW requirement is that metadata should always point to a
> +		 * 8-byte aligned address. So we add alignment pad to start of
> +		 * buffer. HTT Metadata should be ensured to be multiple of 8-bytes
> +		 * to get 8-byte aligned start address along with align_pad added
> +		 */
> +		align_pad = ((unsigned long)skb->data) & (HTT_META_DATA_ALIGNMENT - 1);
> +		ret = ath11k_dp_metadata_align_skb(skb, align_pad);
> +		if (unlikely(ret))
> +			goto fail_remove_idr;
> +
> +		ti.pkt_offset += align_pad;
> +		ret = ath11k_dp_prepare_htt_metadata(skb, &htt_meta_size);
> +		if (unlikely(ret))
> +			goto fail_remove_idr;
> +
> +		ti.pkt_offset += htt_meta_size;
> +		ti.meta_data_flags |= HTT_TCL_META_DATA_VALID_HTT;
> +		ti.flags0 |= FIELD_PREP(HAL_TCL_DATA_CMD_INFO1_TO_FW, 1);
> +		ti.encap_type = HAL_TCL_ENCAP_TYPE_RAW;
> +		ti.encrypt_type = HAL_ENCRYPT_TYPE_OPEN;
> +	}
> +
>   	ti.paddr = dma_map_single(ab->dev, skb->data, skb->len, DMA_TO_DEVICE);
>   	if (unlikely(dma_mapping_error(ab->dev, ti.paddr))) {
>   		atomic_inc(&ab->soc_stats.tx_err.misc_fail);
> @@ -216,7 +288,8 @@ tcl_ring_sel:
>   		goto fail_remove_idr;
>   	}
>   
> -	ti.data_len = skb->len;
> +	ti.data_len = skb->len - ti.pkt_offset;
> +	skb_cb->pkt_offset = ti.pkt_offset;
>   	skb_cb->paddr = ti.paddr;
>   	skb_cb->vif = arvif->vif;
>   	skb_cb->ar = ar;
> @@ -272,6 +345,8 @@ fail_unmap_dma:
>   	dma_unmap_single(ab->dev, ti.paddr, ti.data_len, DMA_TO_DEVICE);
>   
>   fail_remove_idr:
> +	if (ti.pkt_offset)
> +		skb_pull(skb, ti.pkt_offset);
>   	spin_lock_bh(&tx_ring->tx_idr_lock);
>   	idr_remove(&tx_ring->txbuf_idr,
>   		   FIELD_GET(DP_TX_DESC_ID_MSDU_ID, ti.desc_id));
> @@ -348,6 +423,10 @@ ath11k_dp_tx_htt_tx_complete_buf(struct
>   		return;
>   	}
>   
> +	if (skb_cb->pkt_offset)
> +		/* Removing the alignment and htt meta data */
> +		skb_pull(msdu, skb_cb->pkt_offset);
> +
>   	memset(&info->status, 0, sizeof(info->status));
>   
>   	if (ts->acked) {
> --- a/drivers/net/wireless/ath/ath11k/hal_desc.h
> +++ b/drivers/net/wireless/ath/ath11k/hal_desc.h
> @@ -2490,5 +2490,165 @@
>    *		A count value that indicates the number of times the producer of
>    *		entries into this Ring has looped around the ring.
>    */
> +
> +#define HAL_TX_MSDU_METADATA_INFO0_ENCRYPT_FLAG		BIT(8)
> +#define HAL_TX_MSDU_METADATA_INFO0_ENCRYPT_TYPE		GENMASK(16, 15)
> +#define HAL_TX_MSDU_METADATA_INFO0_HOST_TX_DESC_POOL	BIT(31)
> +
> +struct hal_tx_msdu_metadata {
> +	__le32 info0;
> +	__le32 rsvd0[6];
> +} __packed;
> +
> +/* hal_tx_msdu_metadata
> + *
> + * valid_pwr
> + *		If set, tx pwr spec is valid
> + *
> + * valid_mcs_mask
> + *		If set, tx MCS mask is valid
> + *
> + * valid_nss_mask
> + *		If set, tx Nss mask is valid
> + *
> + * valid_preamble_type
> + *		If set, tx preamble spec is valid
> + *
> + * valid_retries
> + *		If set, tx retries spec is valid
> + *
> + * valid_bw_info
> + *		If set, tx dyn_bw and bw_mask are valid
> + *
> + * valid_guard_interval
> + *		If set, tx guard intv spec is valid
> + *
> + * valid_chainmask
> + *		If set, tx chainmask is valid
> + *
> + * valid_encrypt_type
> + *		If set, encrypt type is valid
> + *
> + * valid_key_flags
> + *		If set, key flags is valid
> + *
> + * valid_expire_tsf
> + *		If set, tx expire TSF spec is valid
> + *
> + * valid_chanfreq
> + *		If set, chanfreq is valid
> + *
> + * is_dsrc
> + *		If set, MSDU is a DSRC frame
> + *
> + * guard_interval
> + *		0.4us, 0.8us, 1.6us, 3.2us
> + *
> + * encrypt_type
> + *		0 = NO_ENCRYPT,
> + *		1 = ENCRYPT,
> + *		2 ~ 3 - Reserved
> + *
> + * retry_limit
> + *		Specify the maximum number of transmissions, including the
> + *		initial transmission, to attempt before giving up if no ack
> + *		is received.
> + *		If the tx rate is specified, then all retries shall use the
> + *		same rate as the initial transmission.
> + *		If no tx rate is specified, the target can choose whether to
> + *		retain the original rate during the retransmissions, or to
> + *		fall back to a more robust rate.
> + *
> + * use_dcm_11ax
> + *		If set, Use Dual subcarrier modulation.
> + *		Valid only for 11ax preamble types HE_SU
> + *		and HE_EXT_SU
> + *
> + * ltf_subtype_11ax
> + *		Takes enum values of htt_11ax_ltf_subtype_t
> + *		Valid only for 11ax preamble types HE_SU
> + *		and HE_EXT_SU
> + *
> + * dyn_bw
> + *		0 = static bw, 1 = dynamic bw
> + *
> + * bw_mask
> + *		Valid only if dyn_bw == 0 (static bw).
> + *
> + * host_tx_desc_pool
> + *		If set, Firmware allocates tx_descriptors
> + *		in WAL_BUFFERID_TX_HOST_DATA_EXP,instead
> + *		of WAL_BUFFERID_TX_TCL_DATA_EXP.
> + *		Use cases:
> + *		Any time firmware uses TQM-BYPASS for Data
> + *		TID, firmware expect host to set this bit.
> + *
> + * power
> + *		Unit of the power field is 0.5 dbm
> + *		signed value ranging from -64dbm to 63.5 dbm
> + *
> + * mcs_mask
> + *		mcs bit mask of 0 ~ 11
> + *		Setting more than one MCS isn't currently
> + *		supported by the target but is supported
> + *		in the interface in case in the future
> + *		the target supports specifications of
> + *		a limited set of MCS values.
> + *
> + * nss_mask
> + *		Nss bit mask 0 ~ 7
> + *		Setting more than one Nss isn't currently
> + *		supported by the target but is supported
> + *		in the interface in case in the future
> + *		the target supports specifications of
> + *		a limited set of Nss values.
> + *
> + * pream_type
> + *		Preamble types
> + *
> + * update_peer_cache
> + *		When set these custom values will be
> + *		used for all packets, until the next
> + *		update via this ext header.
> + *		This is to make sure not all packets
> + *		need to include this header.
> + *
> + * chain_mask
> + *		Specify which chains to transmit from
> + *
> + * key_flags
> + *		Key Index and related flags - used in mesh mode
> + *
> + * chanfreq
> + *		Channel frequency: This identifies the desired channel
> + *		frequency (in MHz) for tx frames. This is used by FW to help
> + *		determine when it is safe to transmit or drop frames for
> + *		off-channel operation.
> + *		The default value of zero indicates to FW that the corresponding
> + *		VDEV's home channel (if there is one) is the desired channel
> + *		frequency.
> + *
> + * expire_tsf_lo
> + *		tx expiry time (TSF) LSBs
> + *
> + * expire_tsf_hi
> + *		tx expiry time (TSF) MSBs
> + *
> + * learning_frame
> + *		When this flag is set, this frame will be dropped by FW
> + *		rather than being enqueued to the Transmit Queue Manager (TQM) HW.
> + *
> + * send_as_standalone
> + *		This will indicate if the msdu needs to be sent as a singleton PPDU,
> + *		i.e. with no A-MSDU or A-MPDU aggregation.
> + *		The scope is extended to other use-cases.
> + *
> + * is_host_opaque_valid
> + *		Set this bit to 1 if the host_opaque_cookie is populated
> + *		with valid information.
> + *
> + * host_opaque_cookie
> + *		Host opaque cookie for special frames
> + */

With bit fields removed, may be this doc is not of much help?

>   
>   #endif /* ATH11K_HAL_DESC_H */
> --- a/drivers/net/wireless/ath/ath11k/mac.c
> +++ b/drivers/net/wireless/ath/ath11k/mac.c
> @@ -10324,6 +10324,9 @@ static int __ath11k_mac_register(struct
>   		goto err_free_if_combs;
>   	}
>   
> +	ar->hw->wiphy->interface_modes |= BIT(NL80211_IFTYPE_AP_VLAN);
> +	ar->hw->wiphy->software_iftypes |= BIT(NL80211_IFTYPE_AP_VLAN);
> +
>   	if (!ab->hw_params.supports_monitor)
>   		/* There's a race between calling ieee80211_register_hw()
>   		 * and here where the monitor mode is enabled for a little
> --- a/net/mac80211/tx.c
> +++ b/net/mac80211/tx.c
> @@ -40,6 +40,10 @@
>   
>   /* misc utils */
>   
> +static void ieee80211_8023_xmit(struct ieee80211_sub_if_data *sdata,
> +				struct net_device *dev, struct sta_info *sta,
> +				struct ieee80211_key *key, struct sk_buff *skb);
> +
>   static __le16 ieee80211_duration(struct ieee80211_tx_data *tx,
>   				 struct sk_buff *skb, int group_addr,
>   				 int next_frag_len)
> @@ -4281,5 +4285,16 @@ void __ieee80211_subif_start_xmit(struct
>   	if (IS_ERR(sta))
>   		sta = NULL;
>   
> +	if (sta && sdata->vif.type == NL80211_IFTYPE_AP_VLAN &&
> +	    get_bss_sdata(sdata)->vif.offload_flags & IEEE80211_OFFLOAD_ENCAP_ENABLED &&
> +	    !is_multicast_ether_addr(skb->data)) {
> +		struct ieee80211_key *key = rcu_dereference(sta->ptk[sta->ptk_idx]);
> +		if (!key)
> +			key = rcu_dereference(get_bss_sdata(sdata)->default_unicast_key);
> +		ieee80211_8023_xmit(sdata, dev, sta, key, skb);
> +		rcu_read_unlock();
> +		return;
> +	}
> +

In general, have mac80211 changes in a separate patch. I dont think this particular change
is really required as AP_VLAN xmit will also be 8023 if the master interface supports it.

Vasanth

