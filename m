Return-Path: <linux-wireless+bounces-1863-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C78D282C8D0
	for <lists+linux-wireless@lfdr.de>; Sat, 13 Jan 2024 02:35:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BF3D1F2448F
	for <lists+linux-wireless@lfdr.de>; Sat, 13 Jan 2024 01:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24DE714001;
	Sat, 13 Jan 2024 01:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="eCIcqC95"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D89318640
	for <linux-wireless@vger.kernel.org>; Sat, 13 Jan 2024 01:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40D18vwE025938;
	Sat, 13 Jan 2024 01:35:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=lp8pcW74B7UT47GtAr+SadZetyGFFsjlsAaKtD/7ukw=; b=eC
	IcqC95LRm4I6ox8l6jEdaqvtNrE37/QbgJgbv0dAGBS0ORSmR41G+PY/OVKF/iVW
	IeDRWVHB8vGz1sqUKt4xI1/fqaqjitSFyaJyemoM/dXu2Yojuh0sfDTPveRh5OLA
	ERHFVxjMBX+52FFkILaOjQQIiTOR9CIxqq0o1nrix2GQdb6fXtOXBrO5wH+QdN8e
	jlMWU1v4XlKX/+fKw7GKb+e3LlDpMHDAhaqUMuVlmoj25DNtzc74HksTv4te7jlp
	nmuINetjsXZIebm2Qk1rEA00jPtFVpFbb3gSGMZ0hUCRbxwChGRDfZ47q7K1ur7x
	ROfxvoQyFhvK2iOBKXDQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vkcb70gaf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 13 Jan 2024 01:35:21 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40D1ZLhT031125
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 13 Jan 2024 01:35:21 GMT
Received: from [10.50.59.85] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 12 Jan
 2024 17:35:18 -0800
Message-ID: <b1cb2130-ca6c-525e-4370-ea0acbd73138@quicinc.com>
Date: Sat, 13 Jan 2024 07:05:14 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 03/10] wifi: ath12k: implement handling of P2P NoA
 event
Content-Language: en-US
To: Kang Yang <quic_kangyang@quicinc.com>, <ath12k@lists.infradead.org>,
        "Jeff
 Johnson" <quic_jjohnson@quicinc.com>
CC: <linux-wireless@vger.kernel.org>
References: <20240112092824.7664-1-quic_kangyang@quicinc.com>
 <20240112092824.7664-4-quic_kangyang@quicinc.com>
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
In-Reply-To: <20240112092824.7664-4-quic_kangyang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: NpzdppyAUzG3ExOEFty1289iLFaKc4aT
X-Proofpoint-ORIG-GUID: NpzdppyAUzG3ExOEFty1289iLFaKc4aT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 phishscore=0 suspectscore=0 spamscore=0 malwarescore=0
 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401130010


On 1/12/2024 2:58 PM, Kang Yang wrote:
> The NoA(Notice of Absence) attribute is used by the P2P Group Owner to
> signal its absence due to power save timing, concurrent operation, or
> off-channel scanning. It is also used in the P2P Presence Request-Response
> mechanism.
>
> The NoA attribute shall be present in the P2P IE in the beacon frames
> transmitted by a P2P Group Owner when a NoA schedule is being advertised,
> or when the CTWindow is non-zero.
>
> So add support to update P2P information after P2P GO is up through
> event WMI_P2P_NOA_EVENTID, and always put it in probe resp.
>
> Create p2p.c and p2p.h for P2P related functions and definitions.
>
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
>
> Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
> ---
>
> v2: add Tested-on tag of QCN9274.
>
> ---
>   drivers/net/wireless/ath/ath12k/Makefile |   3 +-
>   drivers/net/wireless/ath/ath12k/mac.c    |  25 +++-
>   drivers/net/wireless/ath/ath12k/p2p.c    | 142 +++++++++++++++++++++++
>   drivers/net/wireless/ath/ath12k/p2p.h    |  23 ++++
>   drivers/net/wireless/ath/ath12k/wmi.c    |  51 +++++++-
>   drivers/net/wireless/ath/ath12k/wmi.h    |  31 +++++
>   6 files changed, 272 insertions(+), 3 deletions(-)
>   create mode 100644 drivers/net/wireless/ath/ath12k/p2p.c
>   create mode 100644 drivers/net/wireless/ath/ath12k/p2p.h
>
> diff --git a/drivers/net/wireless/ath/ath12k/Makefile b/drivers/net/wireless/ath/ath12k/Makefile
> index 62c52e733b5e..e296fe7f8d64 100644
> --- a/drivers/net/wireless/ath/ath12k/Makefile
> +++ b/drivers/net/wireless/ath/ath12k/Makefile
> @@ -19,7 +19,8 @@ ath12k-y += core.o \
>   	    hw.o \
>   	    mhi.o \
>   	    pci.o \
> -	    dp_mon.o
> +	    dp_mon.o \
> +	    p2p.o
>   
>   ath12k-$(CONFIG_ATH12K_TRACING) += trace.o
>   
> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
> index 70a54cc52e44..a4a00a6606b4 100644
> --- a/drivers/net/wireless/ath/ath12k/mac.c
> +++ b/drivers/net/wireless/ath/ath12k/mac.c
> @@ -5045,6 +5045,25 @@ static int ath12k_mac_mgmt_tx(struct ath12k *ar, struct sk_buff *skb,
>   	return 0;
>   }
>   
> +static void ath12k_mac_add_p2p_noa_ie(struct ath12k *ar,
> +				      struct ieee80211_vif *vif,
> +				      struct sk_buff *skb,
> +				      bool is_prb_rsp)
> +{
> +	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
> +
> +	if (likely(!is_prb_rsp))
> +		return;
> +
> +	spin_lock_bh(&ar->data_lock);
> +	if (arvif->u.ap.noa_data)
> +		if (!pskb_expand_head(skb, 0, arvif->u.ap.noa_len,
> +				      GFP_ATOMIC))
> +			skb_put_data(skb, arvif->u.ap.noa_data,
> +				     arvif->u.ap.noa_len);
> +	spin_unlock_bh(&ar->data_lock);
> +}
> +
>   static void ath12k_mac_op_tx(struct ieee80211_hw *hw,
>   			     struct ieee80211_tx_control *control,
>   			     struct sk_buff *skb)
> @@ -5068,10 +5087,10 @@ static void ath12k_mac_op_tx(struct ieee80211_hw *hw,
>   		skb_cb->flags |= ATH12K_SKB_CIPHER_SET;
>   	}
>   
> +	is_prb_rsp = ieee80211_is_probe_resp(hdr->frame_control);
>   	if (info_flags & IEEE80211_TX_CTL_HW_80211_ENCAP) {
>   		skb_cb->flags |= ATH12K_SKB_HW_80211_ENCAP;
>   	} else if (ieee80211_is_mgmt(hdr->frame_control)) {
> -		is_prb_rsp = ieee80211_is_probe_resp(hdr->frame_control);
>   		ret = ath12k_mac_mgmt_tx(ar, skb, is_prb_rsp);
>   		if (ret) {
>   			ath12k_warn(ar->ab, "failed to queue management frame %d\n",
> @@ -5081,6 +5100,10 @@ static void ath12k_mac_op_tx(struct ieee80211_hw *hw,
>   		return;
>   	}
>   
> +	/* This is case only for P2P_GO */
> +	if (vif->type == NL80211_IFTYPE_AP && vif->p2p)
> +		ath12k_mac_add_p2p_noa_ie(ar, vif, skb, is_prb_rsp);
> +
>   	ret = ath12k_dp_tx(ar, arvif, skb);
>   	if (ret) {
>   		ath12k_warn(ar->ab, "failed to transmit frame %d\n", ret);
> diff --git a/drivers/net/wireless/ath/ath12k/p2p.c b/drivers/net/wireless/ath/ath12k/p2p.c
> new file mode 100644
> index 000000000000..9f067dbd54b0
> --- /dev/null
> +++ b/drivers/net/wireless/ath/ath12k/p2p.c
> @@ -0,0 +1,142 @@
> +// SPDX-License-Identifier: ISC
> +/*
> + * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#include <net/mac80211.h>
> +#include "core.h"
> +#include "mac.h"
> +#include "p2p.h"
> +
> +static void ath12k_p2p_noa_ie_fill(u8 *data, size_t len,
> +				   const struct ath12k_wmi_p2p_noa_info *noa)
> +{
> +	struct ieee80211_p2p_noa_attr *noa_attr;
> +	u8 ctwindow = le32_get_bits(noa->noa_attr, WMI_P2P_NOA_INFO_CTWIN_TU);
> +	bool oppps = le32_get_bits(noa->noa_attr, WMI_P2P_NOA_INFO_OPP_PS);
> +	__le16 *noa_attr_len;
> +	u16 attr_len;
> +	u8 noa_descriptors = le32_get_bits(noa->noa_attr,
> +					   WMI_P2P_NOA_INFO_DESC_NUM);
> +	int i;
> +
> +	/* P2P IE */
> +	data[0] = WLAN_EID_VENDOR_SPECIFIC;
> +	data[1] = len - 2;
> +	data[2] = (WLAN_OUI_WFA >> 16) & 0xff;
> +	data[3] = (WLAN_OUI_WFA >> 8) & 0xff;
> +	data[4] = (WLAN_OUI_WFA >> 0) & 0xff;
> +	data[5] = WLAN_OUI_TYPE_WFA_P2P;
> +
> +	/* NOA ATTR */
> +	data[6] = IEEE80211_P2P_ATTR_ABSENCE_NOTICE;
> +	noa_attr_len = (__le16 *)&data[7]; /* 2 bytes */
> +	noa_attr = (struct ieee80211_p2p_noa_attr *)&data[9];
> +
> +	noa_attr->index = le32_get_bits(noa->noa_attr,
> +					WMI_P2P_NOA_INFO_INDEX);
> +	noa_attr->oppps_ctwindow = ctwindow;
> +	if (oppps)
> +		noa_attr->oppps_ctwindow |= IEEE80211_P2P_OPPPS_ENABLE_BIT;
> +
> +	for (i = 0; i < noa_descriptors; i++) {
> +		noa_attr->desc[i].count =
> +			__le32_to_cpu(noa->descriptors[i].type_count);
> +		noa_attr->desc[i].duration = noa->descriptors[i].duration;
> +		noa_attr->desc[i].interval = noa->descriptors[i].interval;
> +		noa_attr->desc[i].start_time = noa->descriptors[i].start_time;
> +	}
> +
> +	attr_len = 2; /* index + oppps_ctwindow */
> +	attr_len += noa_descriptors * sizeof(struct ieee80211_p2p_noa_desc);
> +	*noa_attr_len = __cpu_to_le16(attr_len);
> +}
> +
> +static size_t ath12k_p2p_noa_ie_len_compute(const struct ath12k_wmi_p2p_noa_info *noa)
> +{
> +	size_t len = 0;
> +
> +	if (!(le32_get_bits(noa->noa_attr, WMI_P2P_NOA_INFO_DESC_NUM)) &&
> +	    !(le32_get_bits(noa->noa_attr, WMI_P2P_NOA_INFO_OPP_PS)))
> +		return 0;
> +
> +	len += 1 + 1 + 4; /* EID + len + OUI */
> +	len += 1 + 2; /* noa attr + attr len */
> +	len += 1 + 1; /* index + oppps_ctwindow */
> +	len += le32_get_bits(noa->noa_attr, WMI_P2P_NOA_INFO_DESC_NUM) *
> +			sizeof(struct ieee80211_p2p_noa_desc);
> +
> +	return len;
> +}
> +
> +static void ath12k_p2p_noa_ie_assign(struct ath12k_vif *arvif, void *ie,
> +				     size_t len)
> +{
> +	struct ath12k *ar = arvif->ar;
> +
> +	lockdep_assert_held(&ar->data_lock);
> +
> +	kfree(arvif->u.ap.noa_data);
> +
> +	arvif->u.ap.noa_data = ie;
> +	arvif->u.ap.noa_len = len;
> +}
> +
> +static void __ath12k_p2p_noa_update(struct ath12k_vif *arvif,
> +				    const struct ath12k_wmi_p2p_noa_info *noa)
> +{
> +	struct ath12k *ar = arvif->ar;
> +	void *ie;
> +	size_t len;
> +
> +	lockdep_assert_held(&ar->data_lock);
> +
> +	ath12k_p2p_noa_ie_assign(arvif, NULL, 0);
> +
> +	len = ath12k_p2p_noa_ie_len_compute(noa);
> +	if (!len)
> +		return;
> +
> +	ie = kmalloc(len, GFP_ATOMIC);
> +	if (!ie)
> +		return;
> +
> +	ath12k_p2p_noa_ie_fill(ie, len, noa);
> +	ath12k_p2p_noa_ie_assign(arvif, ie, len);
> +}
> +
> +void ath12k_p2p_noa_update(struct ath12k_vif *arvif,
> +			   const struct ath12k_wmi_p2p_noa_info *noa)
> +{
> +	struct ath12k *ar = arvif->ar;
> +
> +	spin_lock_bh(&ar->data_lock);
> +	__ath12k_p2p_noa_update(arvif, noa);
> +	spin_unlock_bh(&ar->data_lock);
> +}
> +
> +static void ath12k_p2p_noa_update_vdev_iter(void *data, u8 *mac,
> +					    struct ieee80211_vif *vif)
> +{
> +	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
> +	struct ath12k_p2p_noa_arg *arg = data;
> +
> +	if (arvif->vdev_id != arg->vdev_id)
> +		return;
> +
> +	ath12k_p2p_noa_update(arvif, arg->noa);
> +}
> +
> +void ath12k_p2p_noa_update_by_vdev_id(struct ath12k *ar, u32 vdev_id,
> +				      const struct ath12k_wmi_p2p_noa_info *noa)
> +{
> +	struct ath12k_p2p_noa_arg arg = {
> +		.vdev_id = vdev_id,
> +		.noa = noa,
> +	};
> +
> +	ieee80211_iterate_active_interfaces_atomic(ar->hw,
> +						   IEEE80211_IFACE_ITER_NORMAL,
> +						   ath12k_p2p_noa_update_vdev_iter,
> +						   &arg);


ath12k_ar_to_hw(ar) is introduced to avoid direct access of hw from radio (ie, ar->hw).

This new helper function introduced by the patchset "[PATCH v2 1/2] wifi: ath12k: Refactor the mac80211 hw access from link/radio"


@jeff

Any comments ?


> +}
> diff --git a/drivers/net/wireless/ath/ath12k/p2p.h b/drivers/net/wireless/ath/ath12k/p2p.h
> new file mode 100644
> index 000000000000..b6f177fe4ff4
> --- /dev/null
> +++ b/drivers/net/wireless/ath/ath12k/p2p.h
> @@ -0,0 +1,23 @@
> +/* SPDX-License-Identifier: ISC */
> +/*
> + * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved..
> + */
> +
> +#ifndef ATH12K_P2P_H
> +#define ATH12K_P2P_H
> +
> +#include "wmi.h"
> +
> +struct ath12k_wmi_p2p_noa_info;
> +
> +struct ath12k_p2p_noa_arg {
> +	u32 vdev_id;
> +	const struct ath12k_wmi_p2p_noa_info *noa;
> +};
> +
> +void ath12k_p2p_noa_update(struct ath12k_vif *arvif,
> +			   const struct ath12k_wmi_p2p_noa_info *noa);
> +void ath12k_p2p_noa_update_by_vdev_id(struct ath12k *ar, u32 vdev_id,
> +				      const struct ath12k_wmi_p2p_noa_info *noa);
> +
> +#endif
> diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
> index 1618760f54af..861565eaab3d 100644
> --- a/drivers/net/wireless/ath/ath12k/wmi.c
> +++ b/drivers/net/wireless/ath/ath12k/wmi.c
> @@ -19,6 +19,7 @@
>   #include "mac.h"
>   #include "hw.h"
>   #include "peer.h"
> +#include "p2p.h"
>   
>   struct ath12k_wmi_svc_ready_parse {
>   	bool wmi_svc_bitmap_done;
> @@ -162,6 +163,10 @@ static const struct ath12k_wmi_tlv_policy ath12k_wmi_tlv_policies[] = {
>   		.min_len = sizeof(struct wmi_probe_resp_tx_status_event) },
>   	[WMI_TAG_VDEV_DELETE_RESP_EVENT] = {
>   		.min_len = sizeof(struct wmi_vdev_delete_resp_event) },
> +	[WMI_TAG_P2P_NOA_INFO] = {
> +		.min_len = sizeof(struct ath12k_wmi_p2p_noa_info) },
> +	[WMI_TAG_P2P_NOA_EVENT] = {
> +		.min_len = sizeof(struct wmi_p2p_noa_event) },
>   };
>   
>   static __le32 ath12k_wmi_tlv_hdr(u32 cmd, u32 len)
> @@ -1051,7 +1056,7 @@ int ath12k_wmi_vdev_start(struct ath12k *ar, struct wmi_vdev_start_req_arg *arg,
>   	tlv->header = ath12k_wmi_tlv_hdr(WMI_TAG_ARRAY_STRUCT, 0);
>   
>   	/* Note: This is a nested TLV containing:
> -	 * [wmi_tlv][wmi_p2p_noa_descriptor][wmi_tlv]..
> +	 * [wmi_tlv][ath12k_wmi_p2p_noa_descriptor][wmi_tlv]..
>   	 */
>   
>   	ptr += sizeof(*tlv);
> @@ -6667,6 +6672,47 @@ static void ath12k_probe_resp_tx_status_event(struct ath12k_base *ab,
>   	kfree(tb);
>   }
>   
> +static int ath12k_wmi_p2p_noa_event(struct ath12k_base *ab,
> +				    struct sk_buff *skb)
> +{
> +	const void **tb;
> +	const struct wmi_p2p_noa_event *ev;
> +	const struct ath12k_wmi_p2p_noa_info *noa;
> +	struct ath12k *ar;
> +	int ret, vdev_id;
> +
> +	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
> +	if (IS_ERR(tb)) {
> +		ret = PTR_ERR(tb);
> +		ath12k_warn(ab, "failed to parse tlv: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ev = tb[WMI_TAG_P2P_NOA_EVENT];
> +	noa = tb[WMI_TAG_P2P_NOA_INFO];
> +
> +	if (!ev || !noa) {
> +		kfree(tb);
> +		return -EPROTO;
> +	}
> +
> +	vdev_id = __le32_to_cpu(ev->vdev_id);
> +
> +	ath12k_dbg(ab, ATH12K_DBG_WMI,
> +		   "wmi tlv p2p noa vdev_id %i descriptors %u\n",
> +		   vdev_id, le32_get_bits(noa->noa_attr, WMI_P2P_NOA_INFO_DESC_NUM));
> +	ar = ath12k_mac_get_ar_by_vdev_id(ab, vdev_id);
> +	if (!ar) {
> +		ath12k_warn(ab, "invalid vdev id %d in P2P NoA event\n",
> +			    vdev_id);
> +		return -EINVAL;
> +	}
> +
> +	ath12k_p2p_noa_update_by_vdev_id(ar, vdev_id, noa);
> +	kfree(tb);
> +	return 0;
> +}
> +
>   static void ath12k_rfkill_state_change_event(struct ath12k_base *ab,
>   					     struct sk_buff *skb)
>   {
> @@ -6811,6 +6857,9 @@ static void ath12k_wmi_op_rx(struct ath12k_base *ab, struct sk_buff *skb)
>   	case WMI_VDEV_DELETE_RESP_EVENTID:
>   		ath12k_vdev_delete_resp_event(ab, skb);
>   		break;
> +	case WMI_P2P_NOA_EVENTID:
> +		ath12k_wmi_p2p_noa_event(ab, skb);
> +		break;
>   	/* TODO: Add remaining events */
>   	default:
>   		ath12k_dbg(ab, ATH12K_DBG_WMI, "Unknown eventid: 0x%x\n", id);
> diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
> index b92b37784f09..0b8203bb5381 100644
> --- a/drivers/net/wireless/ath/ath12k/wmi.h
> +++ b/drivers/net/wireless/ath/ath12k/wmi.h
> @@ -3489,6 +3489,37 @@ struct wmi_get_pdev_temperature_cmd {
>   	__le32 pdev_id;
>   } __packed;
>   
> +#define WMI_P2P_MAX_NOA_DESCRIPTORS		4
> +
> +struct wmi_p2p_noa_event {
> +	__le32 vdev_id;
> +} __packed;
> +
> +struct ath12k_wmi_p2p_noa_descriptor {
> +	__le32 type_count; /* 255: continuous schedule, 0: reserved */
> +	__le32 duration;  /* Absent period duration in micro seconds */
> +	__le32 interval;   /* Absent period interval in micro seconds */
> +	__le32 start_time; /* 32 bit tsf time when in starts */
> +} __packed;
> +
> +#define WMI_P2P_NOA_INFO_CHANGED_FLAG		BIT(0)
> +#define WMI_P2P_NOA_INFO_INDEX			GENMASK(15, 8)
> +#define WMI_P2P_NOA_INFO_OPP_PS			BIT(16)
> +#define WMI_P2P_NOA_INFO_CTWIN_TU		GENMASK(23, 17)
> +#define WMI_P2P_NOA_INFO_DESC_NUM		GENMASK(31, 24)
> +
> +struct ath12k_wmi_p2p_noa_info {
> +	/* Bit 0 - Flag to indicate an update in NOA schedule
> +	 * Bits 7-1 - Reserved
> +	 * Bits 15-8 - Index (identifies the instance of NOA sub element)
> +	 * Bit  16 - Opp PS state of the AP
> +	 * Bits 23-17 -  Ctwindow in TUs
> +	 * Bits 31-24 -  Number of NOA descriptors
> +	 */
> +	__le32 noa_attr;
> +	struct ath12k_wmi_p2p_noa_descriptor descriptors[WMI_P2P_MAX_NOA_DESCRIPTORS];
> +} __packed;
> +
>   #define WMI_BEACON_TX_BUFFER_SIZE	512
>   
>   struct wmi_bcn_tmpl_cmd


Thanks

Karthikeyan


