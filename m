Return-Path: <linux-wireless+bounces-8336-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8726D8D591B
	for <lists+linux-wireless@lfdr.de>; Fri, 31 May 2024 05:42:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2EB01C21970
	for <lists+linux-wireless@lfdr.de>; Fri, 31 May 2024 03:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9190C17C64;
	Fri, 31 May 2024 03:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="S5BziXFR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F671C697
	for <linux-wireless@vger.kernel.org>; Fri, 31 May 2024 03:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717126972; cv=none; b=GKoFtdhLDg9H2ca2c9VJotAJHGhGi93tzJkVEJLH8XB5bwE+mCnMKlNeZBBDXHE8qPekvzqJU+odm1QL8HW7+m8sh0DpaQqcnQF9N0jIc9DcyHPU4pYyoPkNGnAhTQyrGMiVU89Ek3j4saEWjwEUbOjQ2vVn9Blgp+KhBiJUVcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717126972; c=relaxed/simple;
	bh=8N6cCHDmvDLMfJRDa3Ej2MUTxUjcGy8agFOd/rLdNfc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=h8pdov6P2XzOG1v5EaHnM+xWOd9toM0zfqMG+GvAlwTfVEZ/MWgazPKfkOJ473wNJ65fuyRgHI207MrhJLbYfu2CNmgocLx//r+xU5WfL7/aPAaRtMJ6z+ILoE6KsmGGUJvVGVpLQq186t3G7VCtTprnghrSF2T/ZYQ2FsKeDcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=S5BziXFR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44UMQM1C006307;
	Fri, 31 May 2024 03:42:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RjPHmcNn+PyTSV2SjWP3nnW9QUqIPyrj/m4nz+U5NBI=; b=S5BziXFRNhbZ5HzA
	NrHIRmps5RSabaosybjo2k+SVPXGGOkgbE4OwKSeUnZbwWX2icNu9RLnfLt5msi0
	Y1rmpI58DxQO7ZRIQv/e/iI5zgk6BqpubKDvOZq+B0+iIXQISQR0dYsbh+PWrMFp
	LxefYt9RCrzYsJU1pMnxnl34EvRjIdzC388zbxk3MNopTLLKJJm9tp/8t2v+ZJIu
	jewgw+uPEC0P00U3MjKt0BIbutsbBKRk8+lQ47J3YPbzmP+P/F/Bc7Pg2u32hgvI
	7Ccwp4FUInByqXCVSmDwyF2kU4XroQFAqSyWzMtfJ7V1NtkK4+1q9VVwNE/fgoPb
	qyOVpA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yba0pwhg2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 May 2024 03:42:45 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44V3giWC015271
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 May 2024 03:42:44 GMT
Received: from [10.231.195.67] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 30 May
 2024 20:42:42 -0700
Message-ID: <17721436-19fb-4337-9058-b20f4df2792c@quicinc.com>
Date: Fri, 31 May 2024 11:42:40 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/8] wifi: ath12k: support ARP and NS offload
To: Jeff Johnson <quic_jjohnson@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240530072714.25671-1-quic_bqiang@quicinc.com>
 <20240530072714.25671-7-quic_bqiang@quicinc.com>
 <ccf9791b-e050-4844-8c37-35873fb3fcaf@quicinc.com>
Content-Language: en-US
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <ccf9791b-e050-4844-8c37-35873fb3fcaf@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: MLbPJ8Yy1w0hu059bpYPK-smXUqheVhL
X-Proofpoint-GUID: MLbPJ8Yy1w0hu059bpYPK-smXUqheVhL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-30_21,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=761 bulkscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 mlxscore=0 spamscore=0 adultscore=0 phishscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405310027



On 5/31/2024 2:26 AM, Jeff Johnson wrote:
> On 5/30/2024 12:27 AM, Baochen Qiang wrote:
>> Support ARP and NS offload in WoW state.
>>
>> Tested this way: put machine A with QCA6390 to WoW state,
>> ping/ping6 machine A from another machine B, check sniffer to see
>> any ARP response and Neighbor Advertisement from machine A.
>>
>> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
>>
>> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
>> ---
>>  drivers/net/wireless/ath/ath12k/core.h |   1 +
>>  drivers/net/wireless/ath/ath12k/mac.c  |  15 ++
>>  drivers/net/wireless/ath/ath12k/wmi.c  | 148 ++++++++++++++++++++
>>  drivers/net/wireless/ath/ath12k/wmi.h  |  66 +++++++++
>>  drivers/net/wireless/ath/ath12k/wow.c  | 185 +++++++++++++++++++++++++
>>  5 files changed, 415 insertions(+)
>>
>> diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
>> index af5c489b9fd2..f98c3e7c413e 100644
>> --- a/drivers/net/wireless/ath/ath12k/core.h
>> +++ b/drivers/net/wireless/ath/ath12k/core.h
>> @@ -285,6 +285,7 @@ struct ath12k_vif {
>>  	u32 punct_bitmap;
>>  	bool ps;
>>  	struct ath12k_vif_cache *cache;
>> +	struct inet6_dev *idev;
>>  };
>>  
>>  struct ath12k_vif_iter {
>> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
>> index 1d45692c3102..70311b94fef8 100644
>> --- a/drivers/net/wireless/ath/ath12k/mac.c
>> +++ b/drivers/net/wireless/ath/ath12k/mac.c
>> @@ -6,6 +6,7 @@
>>  
>>  #include <net/mac80211.h>
>>  #include <linux/etherdevice.h>
>> +
>>  #include "mac.h"
>>  #include "core.h"
>>  #include "debug.h"
>> @@ -8505,6 +8506,16 @@ static int ath12k_mac_op_remain_on_channel(struct ieee80211_hw *hw,
>>  	return ret;
>>  }
>>  
>> +static __maybe_unused void ath12k_mac_op_ipv6_changed(struct ieee80211_hw *hw,
>> +						      struct ieee80211_vif *vif,
>> +						      struct inet6_dev *idev)
>> +{
>> +	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
>> +
>> +	/* just cache here, would revisit it during WoW offload */
>> +	arvif->idev = idev;
> 
> so there is no possibility that this can later disappear, leaving us with a
> dangling pointer? if so, suggest you enhance the comment to describe why this
> is safe
> 
> But alternately, if we no longer act upon this immediately when it changes,
> why do we need to cache this? Can we just get to this by back referencing the
> netdev from the arvif?
makes sense. will remove this callback in next version.

> 
>> +}
>> +
>>  static const struct ieee80211_ops ath12k_ops = {
>>  	.tx				= ath12k_mac_op_tx,
>>  	.wake_tx_queue			= ieee80211_handle_wake_tx_queue,
>> @@ -8547,6 +8558,10 @@ static const struct ieee80211_ops ath12k_ops = {
>>  	.resume				= ath12k_wow_op_resume,
>>  	.set_wakeup			= ath12k_wow_op_set_wakeup,
>>  #endif
>> +
>> +#if IS_ENABLED(CONFIG_IPV6)
>> +	.ipv6_addr_change		= ath12k_mac_op_ipv6_changed,
>> +#endif
>>  };
>>  
>>  static void ath12k_mac_update_ch_list(struct ath12k *ar,
>> diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
>> index 851f320e73c7..8148e518969e 100644
>> --- a/drivers/net/wireless/ath/ath12k/wmi.c
>> +++ b/drivers/net/wireless/ath/ath12k/wmi.c
>> @@ -7780,3 +7780,151 @@ int ath12k_wmi_wow_config_pno(struct ath12k *ar, u32 vdev_id,
>>  
>>  	return ath12k_wmi_cmd_send(ar->wmi, skb, WMI_NETWORK_LIST_OFFLOAD_CONFIG_CMDID);
>>  }
>> +
>> +static void ath12k_wmi_fill_ns_offload(struct ath12k *ar,
>> +				       struct wmi_arp_ns_offload_arg *offload,
>> +				       void **ptr,
>> +				       bool enable,
>> +				       bool ext)
>> +{
>> +	struct wmi_ns_offload_params *ns;
>> +	struct wmi_tlv *tlv;
>> +	void *buf_ptr = *ptr;
>> +	u32 ns_cnt, ns_ext_tuples;
>> +	int i, max_offloads;
>> +
>> +	ns_cnt = offload->ipv6_count;
>> +
>> +	tlv  = buf_ptr;
>> +
>> +	if (ext) {
>> +		ns_ext_tuples = offload->ipv6_count - WMI_MAX_NS_OFFLOADS;
>> +		tlv->header = ath12k_wmi_tlv_hdr(WMI_TAG_ARRAY_STRUCT,
>> +						 ns_ext_tuples * sizeof(*ns));
>> +		i = WMI_MAX_NS_OFFLOADS;
>> +		max_offloads = offload->ipv6_count;
>> +	} else {
>> +		tlv->header = ath12k_wmi_tlv_hdr(WMI_TAG_ARRAY_STRUCT,
>> +						 WMI_MAX_NS_OFFLOADS * sizeof(*ns));
>> +		i = 0;
>> +		max_offloads = WMI_MAX_NS_OFFLOADS;
>> +	}
>> +
>> +	buf_ptr += sizeof(*tlv);
>> +
>> +	for (; i < max_offloads; i++) {
>> +		ns = buf_ptr;
>> +		ns->tlv_header = ath12k_wmi_tlv_cmd_hdr(WMI_TAG_NS_OFFLOAD_TUPLE,
>> +							sizeof(*ns));
>> +
>> +		if (enable) {
>> +			if (i < ns_cnt)
>> +				ns->flags |= cpu_to_le32(WMI_NSOL_FLAGS_VALID);
>> +
>> +			memcpy(ns->target_ipaddr[0], offload->ipv6_addr[i], 16);
>> +			memcpy(ns->solicitation_ipaddr, offload->self_ipv6_addr[i], 16);
>> +
>> +			if (offload->ipv6_type[i])
>> +				ns->flags |= cpu_to_le32(WMI_NSOL_FLAGS_IS_IPV6_ANYCAST);
>> +
>> +			memcpy(ns->target_mac.addr, offload->mac_addr, ETH_ALEN);
>> +
>> +			if (!is_zero_ether_addr(ns->target_mac.addr))
>> +				ns->flags |= cpu_to_le32(WMI_NSOL_FLAGS_MAC_VALID);
>> +
>> +			ath12k_dbg(ar->ab, ATH12K_DBG_WMI,
>> +				   "wmi index %d ns_solicited %pI6 target %pI6",
>> +				   i, ns->solicitation_ipaddr,
>> +				   ns->target_ipaddr[0]);
>> +		}
>> +
>> +		buf_ptr += sizeof(*ns);
>> +	}
>> +
>> +	*ptr = buf_ptr;
>> +}
>> +
>> +static void ath12k_wmi_fill_arp_offload(struct ath12k *ar,
>> +					struct wmi_arp_ns_offload_arg *offload,
>> +					void **ptr,
>> +					bool enable)
>> +{
>> +	struct wmi_arp_offload_params *arp;
>> +	struct wmi_tlv *tlv;
>> +	void *buf_ptr = *ptr;
>> +	int i;
>> +
>> +	/* fill arp tuple */
>> +	tlv = buf_ptr;
>> +	tlv->header = ath12k_wmi_tlv_hdr(WMI_TAG_ARRAY_STRUCT,
>> +					 WMI_MAX_ARP_OFFLOADS * sizeof(*arp));
>> +	buf_ptr += sizeof(*tlv);
>> +
>> +	for (i = 0; i < WMI_MAX_ARP_OFFLOADS; i++) {
>> +		arp = buf_ptr;
>> +		arp->tlv_header = ath12k_wmi_tlv_cmd_hdr(WMI_TAG_ARP_OFFLOAD_TUPLE,
>> +							 sizeof(*arp));
>> +
>> +		if (enable && i < offload->ipv4_count) {
>> +			/* Copy the target ip addr and flags */
>> +			arp->flags = cpu_to_le32(WMI_ARPOL_FLAGS_VALID);
>> +			memcpy(arp->target_ipaddr, offload->ipv4_addr[i], 4);
>> +
>> +			ath12k_dbg(ar->ab, ATH12K_DBG_WMI, "wmi arp offload address %pI4",
>> +				   arp->target_ipaddr);
>> +		}
>> +
>> +		buf_ptr += sizeof(*arp);
>> +	}
>> +
>> +	*ptr = buf_ptr;
>> +}
>> +
>> +int ath12k_wmi_arp_ns_offload(struct ath12k *ar,
>> +			      struct ath12k_vif *arvif,
>> +			      struct wmi_arp_ns_offload_arg *offload,
>> +			      bool enable)
>> +{
>> +	struct wmi_set_arp_ns_offload_cmd *cmd;
>> +	struct wmi_tlv *tlv;
>> +	struct sk_buff *skb;
>> +	void *buf_ptr;
>> +	size_t len;
>> +	u8 ns_cnt, ns_ext_tuples = 0;
>> +
>> +	ns_cnt = offload->ipv6_count;
>> +
>> +	len = sizeof(*cmd) +
>> +	      sizeof(*tlv) +
>> +	      WMI_MAX_NS_OFFLOADS * sizeof(struct wmi_ns_offload_params) +
>> +	      sizeof(*tlv) +
>> +	      WMI_MAX_ARP_OFFLOADS * sizeof(struct wmi_arp_offload_params);
>> +
>> +	if (ns_cnt > WMI_MAX_NS_OFFLOADS) {
>> +		ns_ext_tuples = ns_cnt - WMI_MAX_NS_OFFLOADS;
>> +		len += sizeof(*tlv) +
>> +		       ns_ext_tuples * sizeof(struct wmi_ns_offload_params);
>> +	}
>> +
>> +	skb = ath12k_wmi_alloc_skb(ar->wmi->wmi_ab, len);
>> +	if (!skb)
>> +		return -ENOMEM;
>> +
>> +	buf_ptr = skb->data;
>> +	cmd = buf_ptr;
>> +	cmd->tlv_header = ath12k_wmi_tlv_cmd_hdr(WMI_TAG_SET_ARP_NS_OFFLOAD_CMD,
>> +						 sizeof(*cmd));
>> +	cmd->flags = cpu_to_le32(0);
>> +	cmd->vdev_id = cpu_to_le32(arvif->vdev_id);
>> +	cmd->num_ns_ext_tuples = cpu_to_le32(ns_ext_tuples);
>> +
>> +	buf_ptr += sizeof(*cmd);
>> +
>> +	ath12k_wmi_fill_ns_offload(ar, offload, &buf_ptr, enable, 0);
>> +	ath12k_wmi_fill_arp_offload(ar, offload, &buf_ptr, enable);
>> +
>> +	if (ns_ext_tuples)
>> +		ath12k_wmi_fill_ns_offload(ar, offload, &buf_ptr, enable, 1);
>> +
>> +	return ath12k_wmi_cmd_send(ar->wmi, skb, WMI_SET_ARP_NS_OFFLOAD_CMDID);
>> +}
>> diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
>> index 477e2a37eb9c..0542d599d33d 100644
>> --- a/drivers/net/wireless/ath/ath12k/wmi.h
>> +++ b/drivers/net/wireless/ath/ath12k/wmi.h
>> @@ -24,6 +24,7 @@
>>  
>>  struct ath12k_base;
>>  struct ath12k;
>> +struct ath12k_vif;
>>  
>>  /* There is no signed version of __le32, so for a temporary solution come
>>   * up with our own version. The idea is from fs/ntfs/endian.h.
>> @@ -5316,6 +5317,66 @@ struct wmi_hw_data_filter_arg {
>>  	u32 hw_filter_bitmap;
>>  };
>>  
>> +#define WMI_IPV6_UC_TYPE     0
>> +#define WMI_IPV6_AC_TYPE     1
>> +
>> +#define WMI_IPV6_MAX_COUNT   16
>> +#define WMI_IPV4_MAX_COUNT   2
>> +
>> +struct wmi_arp_ns_offload_arg {
>> +	u8  ipv4_addr[WMI_IPV4_MAX_COUNT][4];
>> +	u32 ipv4_count;
>> +	u32 ipv6_count;
>> +	u8  ipv6_addr[WMI_IPV6_MAX_COUNT][16];
>> +	u8  self_ipv6_addr[WMI_IPV6_MAX_COUNT][16];
>> +	u8  ipv6_type[WMI_IPV6_MAX_COUNT];
>> +	bool ipv6_valid[WMI_IPV6_MAX_COUNT];
>> +	u8  mac_addr[ETH_ALEN];
>> +};
>> +
>> +#define WMI_MAX_NS_OFFLOADS           2
>> +#define WMI_MAX_ARP_OFFLOADS          2
>> +
>> +#define WMI_ARPOL_FLAGS_VALID              BIT(0)
>> +#define WMI_ARPOL_FLAGS_MAC_VALID          BIT(1)
>> +#define WMI_ARPOL_FLAGS_REMOTE_IP_VALID    BIT(2)
>> +
>> +struct wmi_arp_offload_params {
>> +	__le32 tlv_header;
>> +	__le32 flags;
>> +	u8 target_ipaddr[4];
>> +	u8 remote_ipaddr[4];
>> +	struct ath12k_wmi_mac_addr_params target_mac;
>> +} __packed;
>> +
>> +#define WMI_NSOL_FLAGS_VALID               BIT(0)
>> +#define WMI_NSOL_FLAGS_MAC_VALID           BIT(1)
>> +#define WMI_NSOL_FLAGS_REMOTE_IP_VALID     BIT(2)
>> +#define WMI_NSOL_FLAGS_IS_IPV6_ANYCAST     BIT(3)
>> +
>> +#define WMI_NSOL_MAX_TARGET_IPS    2
>> +
>> +struct wmi_ns_offload_params {
>> +	__le32 tlv_header;
>> +	__le32 flags;
>> +	u8 target_ipaddr[WMI_NSOL_MAX_TARGET_IPS][16];
>> +	u8 solicitation_ipaddr[16];
>> +	u8 remote_ipaddr[16];
>> +	struct ath12k_wmi_mac_addr_params target_mac;
>> +} __packed;
>> +
>> +struct wmi_set_arp_ns_offload_cmd {
>> +	__le32 tlv_header;
>> +	__le32 flags;
>> +	__le32 vdev_id;
>> +	__le32 num_ns_ext_tuples;
>> +	/* The TLVs follow:
>> +	 * wmi_ns_offload_params  ns[WMI_MAX_NS_OFFLOADS];
>> +	 * wmi_arp_offload_params arp[WMI_MAX_ARP_OFFLOADS];
>> +	 * wmi_ns_offload_params  ns_ext[num_ns_ext_tuples];
>> +	 */
>> +} __packed;
>> +
>>  void ath12k_wmi_init_qcn9274(struct ath12k_base *ab,
>>  			     struct ath12k_wmi_resource_config_arg *config);
>>  void ath12k_wmi_init_wcn7850(struct ath12k_base *ab,
>> @@ -5481,4 +5542,9 @@ int ath12k_wmi_wow_config_pno(struct ath12k *ar, u32 vdev_id,
>>  			      struct wmi_pno_scan_req_arg  *pno_scan);
>>  int ath12k_wmi_hw_data_filter_cmd(struct ath12k *ar,
>>  				  struct wmi_hw_data_filter_arg *arg);
>> +int ath12k_wmi_arp_ns_offload(struct ath12k *ar,
>> +			      struct ath12k_vif *arvif,
>> +			      struct wmi_arp_ns_offload_arg *offload,
>> +			      bool enable);
>> +
>>  #endif
>> diff --git a/drivers/net/wireless/ath/ath12k/wow.c b/drivers/net/wireless/ath/ath12k/wow.c
>> index 77658a01bb41..92bcafd517e7 100644
>> --- a/drivers/net/wireless/ath/ath12k/wow.c
>> +++ b/drivers/net/wireless/ath/ath12k/wow.c
>> @@ -5,6 +5,9 @@
>>   */
>>  
>>  #include <linux/delay.h>
>> +#include <linux/inetdevice.h>
>> +#include <net/if_inet6.h>
>> +#include <net/ipv6.h>
>>  
>>  #include "mac.h"
>>  
>> @@ -591,6 +594,174 @@ static int ath12k_wow_clear_hw_filter(struct ath12k *ar)
>>  	return 0;
>>  }
>>  
>> +static void ath12k_wow_generate_ns_mc_addr(struct ath12k_base *ab,
>> +					   struct wmi_arp_ns_offload_arg *offload)
>> +{
>> +	int i;
>> +
>> +	for (i = 0; i < offload->ipv6_count; i++) {
>> +		offload->self_ipv6_addr[i][0] = 0xff;
>> +		offload->self_ipv6_addr[i][1] = 0x02;
>> +		offload->self_ipv6_addr[i][11] = 0x01;
>> +		offload->self_ipv6_addr[i][12] = 0xff;
>> +		offload->self_ipv6_addr[i][13] =
>> +					offload->ipv6_addr[i][13];
>> +		offload->self_ipv6_addr[i][14] =
>> +					offload->ipv6_addr[i][14];
>> +		offload->self_ipv6_addr[i][15] =
>> +					offload->ipv6_addr[i][15];
>> +		ath12k_dbg(ab, ATH12K_DBG_WOW, "NS solicited addr %pI6\n",
>> +			   offload->self_ipv6_addr[i]);
>> +	}
>> +}
>> +
>> +static void ath12k_wow_prepare_ns_offload(struct ath12k_vif *arvif,
>> +					  struct wmi_arp_ns_offload_arg *offload)
>> +{
>> +	struct inet6_dev *idev = arvif->idev;
> 
> as noted above does it make more sense to get the netdev associated with the
> arvif and then use in6_dev_get(net_device) to get the inet6_dev rather than
> caching the pointer from the ipv6_addr_changed() callback?
Ah.. I didn't note that we can get inet6_dev in such a way, just thought the only way is to cache it in ipv6_changed() callback.

will get it using the following in next version:
	struct ieee80211_vif *vif = container_of(arvif)
	struct ieee80211_sub_if_data *sub_if_data = container_of(vif)
	struct net_dev *ndev = sub_if_data->dev
	struct inet6_dev *idev = in6_dev_get(ndev)
> 
>> +	struct ath12k_base *ab = arvif->ar->ab;
>> +	struct inet6_ifaddr *ifa6;
>> +	struct ifacaddr6 *ifaca6;
>> +	u32 count = 0, scope;
>> +	struct list_head *p;
>> +
>> +	if (!idev)
>> +		return;
>> +
>> +	ath12k_dbg(ab, ATH12K_DBG_WOW, "wow prepare ns offload\n");
>> +
>> +	read_lock_bh(&idev->lock);
>> +
>> +	/* get unicast address */
>> +	list_for_each(p, &idev->addr_list) {
>> +		if (count >= WMI_IPV6_MAX_COUNT)
>> +			goto unlock;
>> +
>> +		ifa6 = list_entry(p, struct inet6_ifaddr, if_list);
>> +		if (ifa6->flags & IFA_F_DADFAILED)
>> +			continue;
>> +
>> +		scope = ipv6_addr_src_scope(&ifa6->addr);
>> +		if (scope != IPV6_ADDR_SCOPE_LINKLOCAL &&
>> +		    scope != IPV6_ADDR_SCOPE_GLOBAL) {
>> +			ath12k_dbg(ab, ATH12K_DBG_WOW,
>> +				   "Unsupported ipv6 scope: %d\n", scope);
>> +			continue;
>> +		}
>> +
>> +		memcpy(offload->ipv6_addr[count], &ifa6->addr.s6_addr,
>> +		       sizeof(ifa6->addr.s6_addr));
>> +		offload->ipv6_type[count] = WMI_IPV6_UC_TYPE;
>> +		ath12k_dbg(ab, ATH12K_DBG_WOW, "mac count %d ipv6 uc %pI6 scope %d\n",
>> +			   count, offload->ipv6_addr[count],
>> +			   scope);
>> +		count++;
>> +	}
>> +
>> +	/* get anycast address */
>> +	rcu_read_lock();
>> +
>> +	for (ifaca6 = rcu_dereference(idev->ac_list); ifaca6;
>> +	     ifaca6 = rcu_dereference(ifaca6->aca_next)) {
>> +		if (count >= WMI_IPV6_MAX_COUNT) {
>> +			rcu_read_unlock();
>> +			goto unlock;
>> +		}
>> +
>> +		scope = ipv6_addr_src_scope(&ifaca6->aca_addr);
>> +		if (scope != IPV6_ADDR_SCOPE_LINKLOCAL &&
>> +		    scope != IPV6_ADDR_SCOPE_GLOBAL) {
>> +			ath12k_dbg(ab, ATH12K_DBG_WOW,
>> +				   "Unsupported ipv scope: %d\n", scope);
>> +			continue;
>> +		}
>> +
>> +		memcpy(offload->ipv6_addr[count], &ifaca6->aca_addr,
>> +		       sizeof(ifaca6->aca_addr));
>> +		offload->ipv6_type[count] = WMI_IPV6_AC_TYPE;
>> +		ath12k_dbg(ab, ATH12K_DBG_WOW, "mac count %d ipv6 ac %pI6 scope %d\n",
>> +			   count, offload->ipv6_addr[count],
>> +			   scope);
>> +		count++;
>> +	}
>> +
>> +	rcu_read_unlock();
>> +
>> +unlock:
>> +	read_unlock_bh(&idev->lock);
>> +
>> +	offload->ipv6_count = count;
>> +	ath12k_wow_generate_ns_mc_addr(ab, offload);
>> +}
>> +
>> +static void ath12k_wow_prepare_arp_offload(struct ath12k_vif *arvif,
>> +					   struct wmi_arp_ns_offload_arg *offload)
>> +{
>> +	struct ieee80211_vif *vif = arvif->vif;
>> +	struct ieee80211_vif_cfg vif_cfg = vif->cfg;
>> +	struct ath12k_base *ab = arvif->ar->ab;
>> +	u32 ipv4_cnt;
>> +
>> +	ath12k_dbg(ab, ATH12K_DBG_WOW, "wow prepare arp offload\n");
>> +
>> +	ipv4_cnt = min(vif_cfg.arp_addr_cnt, WMI_IPV4_MAX_COUNT);
>> +	memcpy(offload->ipv4_addr, vif_cfg.arp_addr_list, ipv4_cnt * sizeof(u32));
>> +	offload->ipv4_count = ipv4_cnt;
>> +
>> +	ath12k_dbg(ab, ATH12K_DBG_WOW,
>> +		   "wow arp_addr_cnt %d vif->addr %pM, offload_addr %pI4\n",
>> +		   vif_cfg.arp_addr_cnt, vif->addr, offload->ipv4_addr);
>> +}
>> +
>> +static int ath12k_wow_arp_ns_offload(struct ath12k *ar, bool enable)
>> +{
>> +	struct wmi_arp_ns_offload_arg *offload;
>> +	struct ath12k_vif *arvif;
>> +	int ret;
>> +
>> +	lockdep_assert_held(&ar->conf_mutex);
>> +
>> +	offload = kmalloc(sizeof(*offload), GFP_KERNEL);
>> +	if (!offload)
>> +		return -ENOMEM;
>> +
>> +	list_for_each_entry(arvif, &ar->arvifs, list) {
>> +		if (arvif->vdev_type != WMI_VDEV_TYPE_STA)
>> +			continue;
>> +
>> +		memset(offload, 0, sizeof(*offload));
>> +
>> +		memcpy(offload->mac_addr, arvif->vif->addr, ETH_ALEN);
>> +		ath12k_wow_prepare_ns_offload(arvif, offload);
>> +		ath12k_wow_prepare_arp_offload(arvif, offload);
>> +
>> +		ret = ath12k_wmi_arp_ns_offload(ar, arvif, offload, enable);
>> +		if (ret) {
>> +			ath12k_warn(ar->ab, "failed to set arp ns offload vdev %i: enable %d, ret %d\n",
>> +				    arvif->vdev_id, enable, ret);
>> +			return ret;
>> +		}
>> +	}
>> +
>> +	kfree(offload);
>> +
>> +	return 0;
>> +}
>> +
>> +static int ath12k_wow_protocol_offload(struct ath12k *ar, bool enable)
>> +{
>> +	int ret;
>> +
>> +	ret = ath12k_wow_arp_ns_offload(ar, enable);
>> +	if (ret) {
>> +		ath12k_warn(ar->ab, "failed to offload ARP and NS %d %d\n",
>> +			    enable, ret);
>> +		return ret;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>  int ath12k_wow_op_suspend(struct ieee80211_hw *hw,
>>  			  struct cfg80211_wowlan *wowlan)
>>  {
>> @@ -614,6 +785,13 @@ int ath12k_wow_op_suspend(struct ieee80211_hw *hw,
>>  		goto cleanup;
>>  	}
>>  
>> +	ret = ath12k_wow_protocol_offload(ar, true);
>> +	if (ret) {
>> +		ath12k_warn(ar->ab, "failed to set wow protocol offload events: %d\n",
>> +			    ret);
>> +		goto cleanup;
>> +	}
>> +
>>  	ret = ath12k_mac_wait_tx_complete(ar);
>>  	if (ret) {
>>  		ath12k_warn(ar->ab, "failed to wait tx complete: %d\n", ret);
>> @@ -700,6 +878,13 @@ int ath12k_wow_op_resume(struct ieee80211_hw *hw)
>>  		goto exit;
>>  	}
>>  
>> +	ret = ath12k_wow_protocol_offload(ar, false);
>> +	if (ret) {
>> +		ath12k_warn(ar->ab, "failed to clear wow protocol offload events: %d\n",
>> +			    ret);
>> +		goto exit;
>> +	}
>> +
>>  exit:
>>  	if (ret) {
>>  		switch (ah->state) {
> 

