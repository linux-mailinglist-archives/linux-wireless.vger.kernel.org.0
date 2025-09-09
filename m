Return-Path: <linux-wireless+bounces-27189-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11C43B500E2
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Sep 2025 17:19:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD130360F31
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Sep 2025 15:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B250D34DCFF;
	Tue,  9 Sep 2025 15:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="EcVA834f"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABBC34AB10
	for <linux-wireless@vger.kernel.org>; Tue,  9 Sep 2025 15:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757431183; cv=none; b=VdTlnwWvSXU1+7q4R6BbXiT+7NqMvKFt94JoBQufiUMNDzzy4r9wnr171Sqr5zMKCNVDnGWaVj6Pm4zXumnlbrf/7SUJlOs4gNcRBDfR7xc5eESW8Ku2rlZX5wiVRJPpq7B5OWXd2ldmPyk5mTq1jzWMn187G2OtGC3RZbc5Ldc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757431183; c=relaxed/simple;
	bh=64O7GDbTmUvT2Qeoquc3xn27K4+yPn/0R/4Kv6IYMmE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NgUVeX8EdCk611Im4rGPybwLR0RVwjipTHwfjIvvtbwTgmx6eqzWh8FIbS7X7vIkC0xaxwo+dARID/sm2HvSkh29gAoIY0HwWbWCvAVW4O0Wa+luOrLq1WBKR6Uo5CkZe/VbEk+mQKk3dudzs978WjssOzj+OzoNO8ncQplZYHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=EcVA834f; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5899Levn030639;
	Tue, 9 Sep 2025 15:19:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TatlOtSbzuzSlCQ4tewR0XPRGjgV7yOt9oE8GbOF6aE=; b=EcVA834fzbt1on8/
	tMxTz3NzYs6H3DWNK3JN/nCK6qi5sRXAKh5tOs0LLsNDwfIJiEeDIC7TbJqxy1If
	WkaTXhe7561bGwKjHBeAz+WmoBLzbxRN8aHWu4nXgOujbdSb+yfu14q51cos6McU
	8mpFpmvKAvwLs+ctAK9kKxlRv0GbjCjDTyordXdlR1ZEKMC4ViD30jBaoQuodb0H
	6eQPvyr1TUw+aCw53nFsKS1U9i09+RYiWURJAuQ+iOhMEoitmIdzdC00a6DVa1xs
	d5dVTg2HtHgHvHUNHRMTpsFP/2IPyBk4R1+fV61iDDu2Mm75cSMIIRfixukoWhvJ
	tkIrtw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490c9j8rmc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Sep 2025 15:19:37 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 589FJbQI020421
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 9 Sep 2025 15:19:37 GMT
Received: from [10.79.125.216] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.24; Tue, 9 Sep
 2025 08:19:35 -0700
Message-ID: <0b711017-930f-4f94-9e89-ab9a8274032c@quicinc.com>
Date: Tue, 9 Sep 2025 20:49:32 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath12k-ng 7/8] wifi: ath12k: Remove hal_rx_ops and merge
 into hal_ops
Content-Language: en-GB
To: Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20250908162757.2938849-1-quic_rdeuri@quicinc.com>
 <20250908162757.2938849-8-quic_rdeuri@quicinc.com>
 <1e8be82e-6abe-4764-939e-fede6c4368ea@oss.qualcomm.com>
From: Ripan Deuri <quic_rdeuri@quicinc.com>
In-Reply-To: <1e8be82e-6abe-4764-939e-fede6c4368ea@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyMiBTYWx0ZWRfX0Ebef/bhL61G
 eABpb++8uJOR3u7dVXKUZAm7aA1QwYkPu7xpGg+BulBhV11fleTfhiO/lasSvyWXlE54iahUy7B
 L1cllealzLF7WrhNPbKtS5YBZvgSvmgFoIHyHH29wHYS5QCQRCKcefyuqpq3fkRSyA/6TBjVBQ3
 D9avWp8XxvBFO8/elRJGmA8NJslLWpA0mRXhOQpS3g1D2i/ZxWyxt7Z7qiZRKAikEmSnWdzAAWB
 yw430kbjxo9qUOuaj8444iA99USl10morAzKEy5J/omSTCHky1ZMmunuLJ6fzoUHN3s/DdnJbrZ
 6ho3BIokVD8qF5XCMgtugjjYMKqd6r/BpEy5KWq+2KtwR0DuuSEvNso9AUIIXL4MMM9igX+AR+J
 3ePKZ44+
X-Proofpoint-ORIG-GUID: Lh7KVnQy9x5k9ReKioeoY23WGnF9v7e5
X-Authority-Analysis: v=2.4 cv=PpOTbxM3 c=1 sm=1 tr=0 ts=68c0458a cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8
 a=Uz6xC2GNqLfSg5GIiKEA:9 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: Lh7KVnQy9x5k9ReKioeoY23WGnF9v7e5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_02,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 spamscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 adultscore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060022



On 9/9/2025 9:12 AM, Baochen Qiang wrote:
> 
> 
> On 9/9/2025 12:27 AM, Ripan Deuri wrote:
>> Move following ops from hal_rx_ops to hal_ops to simplify the HAL interface.
>>
>> rx_desc_get_l3_pad_bytes
>> rx_desc_get_mpdu_start_tag
>> rx_desc_get_mpdu_ppdu_id
>> rx_desc_get_msdu_payload
>>
>> Remove the compact_ops as they become unused with this change.
> 
> Are you intending to say hal_rx_ops?

Yes, will use hal_rx_ops here in the next revision.

> 
>>
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
>> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>>
>> Signed-off-by: Ripan Deuri <quic_rdeuri@quicinc.com>
>> ---
>>  drivers/net/wireless/ath/ath12k/core.h      |  2 --
>>  drivers/net/wireless/ath/ath12k/dp_mon.c    |  2 +-
>>  drivers/net/wireless/ath/ath12k/dp_rx.h     |  6 +++---
>>  drivers/net/wireless/ath/ath12k/hal.c       | 22 +++++++--------------
>>  drivers/net/wireless/ath/ath12k/hal.h       | 14 ++++---------
>>  drivers/net/wireless/ath/ath12k/wifi7/pci.c |  2 --
>>  6 files changed, 15 insertions(+), 33 deletions(-)
>>
>> diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
>> index b68f063283fe..9ae98556dd94 100644
>> --- a/drivers/net/wireless/ath/ath12k/core.h
>> +++ b/drivers/net/wireless/ath/ath12k/core.h
>> @@ -1196,8 +1196,6 @@ struct ath12k_base {
>>  		bool fw_features_valid;
>>  	} fw;
>>  
>> -	const struct hal_rx_ops *hal_rx_ops;
>> -
>>  	struct completion restart_completed;
>>  
>>  #ifdef CONFIG_ACPI
>> diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wireless/ath/ath12k/dp_mon.c
>> index 0ae500ec3463..3315a9e3d40a 100644
>> --- a/drivers/net/wireless/ath/ath12k/dp_mon.c
>> +++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
>> @@ -2046,7 +2046,7 @@ ath12k_dp_mon_rx_merg_msdus(struct ath12k *ar,
>>  
>>  		rx_desc = (struct hal_rx_desc *)head_msdu->data;
>>  		hdr_desc =
>> -			ab->hal_rx_ops->rx_desc_get_msdu_payload(rx_desc);
>> +			ab->hw_params->hal_ops->rx_desc_get_msdu_payload(rx_desc);
>>  
>>  		/* Base size */
>>  		wh = (struct ieee80211_hdr_3addr *)hdr_desc;
>> diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.h b/drivers/net/wireless/ath/ath12k/dp_rx.h
>> index 432707d60fca..ff214bff389b 100644
>> --- a/drivers/net/wireless/ath/ath12k/dp_rx.h
>> +++ b/drivers/net/wireless/ath/ath12k/dp_rx.h
>> @@ -109,7 +109,7 @@ static inline u16 ath12k_dp_rx_h_frag_no(struct ath12k_base *ab,
>>  static inline u8 ath12k_dp_rx_h_l3pad(struct ath12k_base *ab,
>>  				      struct hal_rx_desc *desc)
>>  {
>> -	return ab->hal_rx_ops->rx_desc_get_l3_pad_bytes(desc);
>> +	return ab->hw_params->hal_ops->rx_desc_get_l3_pad_bytes(desc);
>>  }
>>  
>>  static inline void ath12k_dp_rx_desc_end_tlv_copy(struct ath12k_base *ab,
>> @@ -129,7 +129,7 @@ static inline void ath12k_dp_rxdesc_set_msdu_len(struct ath12k_base *ab,
>>  static inline u32 ath12k_dp_rxdesc_get_ppduid(struct ath12k_base *ab,
>>  					      struct hal_rx_desc *rx_desc)
>>  {
>> -	return ab->hal_rx_ops->rx_desc_get_mpdu_ppdu_id(rx_desc);
>> +	return ab->hw_params->hal_ops->rx_desc_get_mpdu_ppdu_id(rx_desc);
>>  }
>>  
>>  static inline bool ath12k_dp_rxdesc_mpdu_valid(struct ath12k_base *ab,
>> @@ -137,7 +137,7 @@ static inline bool ath12k_dp_rxdesc_mpdu_valid(struct ath12k_base *ab,
>>  {
>>  	u32 tlv_tag;
>>  
>> -	tlv_tag = ab->hal_rx_ops->rx_desc_get_mpdu_start_tag(rx_desc);
>> +	tlv_tag = ab->hw_params->hal_ops->rx_desc_get_mpdu_start_tag(rx_desc);
>>  
>>  	return tlv_tag == HAL_RX_MPDU_START;
>>  }
>> diff --git a/drivers/net/wireless/ath/ath12k/hal.c b/drivers/net/wireless/ath/ath12k/hal.c
>> index db6294ba6771..a14a7d8dc69f 100644
>> --- a/drivers/net/wireless/ath/ath12k/hal.c
>> +++ b/drivers/net/wireless/ath/ath12k/hal.c
>> @@ -406,13 +406,6 @@ static int ath12k_hal_srng_create_config_qcn9274(struct ath12k_base *ab)
>>  	return 0;
>>  }
>>  
>> -const struct hal_rx_ops hal_rx_qcn9274_compact_ops = {
>> -	.rx_desc_get_l3_pad_bytes = ath12k_hal_rx_desc_get_l3_pad_bytes_qcn9274,
>> -	.rx_desc_get_mpdu_ppdu_id = ath12k_hal_rx_desc_get_mpdu_ppdu_id_qcn9274,
>> -	.rx_desc_get_msdu_payload = ath12k_hal_rx_desc_get_msdu_payload_qcn9274,
>> -};
>> -EXPORT_SYMBOL(hal_rx_qcn9274_compact_ops);
>> -
>>  const struct hal_ops hal_qcn9274_ops = {
>>  	.create_srng_config = ath12k_hal_srng_create_config_qcn9274,
>>  	.tcl_to_wbm_rbm_map = ath12k_hal_qcn9274_tcl_to_wbm_rbm_map,
>> @@ -423,6 +416,9 @@ const struct hal_ops hal_qcn9274_ops = {
>>  	.rx_desc_get_msdu_src_link_id = ath12k_hal_rx_desc_get_msdu_src_link_qcn9274,
>>  	.extract_rx_desc_data = ath12k_hal_extract_rx_desc_data_qcn9274,
>>  	.rx_desc_get_desc_size = ath12k_hal_get_rx_desc_size_qcn9274,
>> +	.rx_desc_get_l3_pad_bytes = ath12k_hal_rx_desc_get_l3_pad_bytes_qcn9274,
>> +	.rx_desc_get_mpdu_ppdu_id = ath12k_hal_rx_desc_get_mpdu_ppdu_id_qcn9274,
>> +	.rx_desc_get_msdu_payload = ath12k_hal_rx_desc_get_msdu_payload_qcn9274,
>>  };
>>  EXPORT_SYMBOL(hal_qcn9274_ops);
>>  
>> @@ -550,14 +546,6 @@ static int ath12k_hal_srng_create_config_wcn7850(struct ath12k_base *ab)
>>  	return 0;
>>  }
>>  
>> -const struct hal_rx_ops hal_rx_wcn7850_ops = {
>> -	.rx_desc_get_l3_pad_bytes = ath12k_hal_rx_desc_get_l3_pad_bytes_wcn7850,
>> -	.rx_desc_get_mpdu_start_tag = ath12k_hal_rx_desc_get_mpdu_start_tag_wcn7850,
>> -	.rx_desc_get_mpdu_ppdu_id = ath12k_hal_rx_desc_get_mpdu_ppdu_id_wcn7850,
>> -	.rx_desc_get_msdu_payload = ath12k_hal_rx_desc_get_msdu_payload_wcn7850,
>> -};
>> -EXPORT_SYMBOL(hal_rx_wcn7850_ops);
>> -
>>  const struct hal_ops hal_wcn7850_ops = {
>>  	.create_srng_config = ath12k_hal_srng_create_config_wcn7850,
>>  	.tcl_to_wbm_rbm_map = ath12k_hal_wcn7850_tcl_to_wbm_rbm_map,
>> @@ -568,6 +556,10 @@ const struct hal_ops hal_wcn7850_ops = {
>>  	.rx_desc_get_msdu_src_link_id = ath12k_hal_rx_desc_get_msdu_src_link_wcn7850,
>>  	.extract_rx_desc_data = ath12k_hal_extract_rx_desc_data_wcn7850,
>>  	.rx_desc_get_desc_size = ath12k_hal_get_rx_desc_size_wcn7850,
>> +	.rx_desc_get_l3_pad_bytes = ath12k_hal_rx_desc_get_l3_pad_bytes_wcn7850,
>> +	.rx_desc_get_mpdu_start_tag = ath12k_hal_rx_desc_get_mpdu_start_tag_wcn7850,
>> +	.rx_desc_get_mpdu_ppdu_id = ath12k_hal_rx_desc_get_mpdu_ppdu_id_wcn7850,
>> +	.rx_desc_get_msdu_payload = ath12k_hal_rx_desc_get_msdu_payload_wcn7850,
>>  };
>>  EXPORT_SYMBOL(hal_wcn7850_ops);
>>  
>> diff --git a/drivers/net/wireless/ath/ath12k/hal.h b/drivers/net/wireless/ath/ath12k/hal.h
>> index 37593bb7953b..692d495d01c9 100644
>> --- a/drivers/net/wireless/ath/ath12k/hal.h
>> +++ b/drivers/net/wireless/ath/ath12k/hal.h
>> @@ -1578,13 +1578,6 @@ enum nl80211_he_ru_alloc ath12k_he_ru_tones_to_nl80211_he_ru_alloc(u16 ru_tones)
>>  	return ret;
>>  }
>>  
>> -struct hal_rx_ops {
>> -	u8 (*rx_desc_get_l3_pad_bytes)(struct hal_rx_desc *desc);
>> -	u32 (*rx_desc_get_mpdu_start_tag)(struct hal_rx_desc *desc);
>> -	u32 (*rx_desc_get_mpdu_ppdu_id)(struct hal_rx_desc *desc);
>> -	u8 *(*rx_desc_get_msdu_payload)(struct hal_rx_desc *desc);
>> -};
>> -
>>  struct hal_ops {
>>  	int (*create_srng_config)(struct ath12k_base *ab);
>>  	const struct ath12k_hal_tcl_to_wbm_rbm_map *tcl_to_wbm_rbm_map;
>> @@ -1601,14 +1594,15 @@ struct hal_ops {
>>  				     struct hal_rx_desc *rx_desc,
>>  				     struct hal_rx_desc *ldesc);
>>  	u32 (*rx_desc_get_desc_size)(void);
>> +	u32 (*rx_desc_get_mpdu_start_tag)(struct hal_rx_desc *desc);
>> +	u32 (*rx_desc_get_mpdu_ppdu_id)(struct hal_rx_desc *desc);
>> +	u8 (*rx_desc_get_l3_pad_bytes)(struct hal_rx_desc *desc);
>> +	u8 *(*rx_desc_get_msdu_payload)(struct hal_rx_desc *desc);
>>  };
>>  
>>  extern const struct hal_ops hal_qcn9274_ops;
>>  extern const struct hal_ops hal_wcn7850_ops;
>>  
>> -extern const struct hal_rx_ops hal_rx_qcn9274_compact_ops;
>> -extern const struct hal_rx_ops hal_rx_wcn7850_ops;
>> -
>>  u32 ath12k_hal_reo_qdesc_size(u32 ba_window_size, u8 tid);
>>  void ath12k_hal_reo_qdesc_setup(struct hal_rx_reo_queue *qdesc,
>>  				int tid, u32 ba_window_size,
>> diff --git a/drivers/net/wireless/ath/ath12k/wifi7/pci.c b/drivers/net/wireless/ath/ath12k/wifi7/pci.c
>> index abdb3b8ff658..ba8c19c24ae6 100644
>> --- a/drivers/net/wireless/ath/ath12k/wifi7/pci.c
>> +++ b/drivers/net/wireless/ath/ath12k/wifi7/pci.c
>> @@ -101,7 +101,6 @@ static int ath12k_wifi7_pci_probe(struct pci_dev *pdev,
>>  		ab_pci->msi_config = &ath12k_wifi7_msi_config[0];
>>  		ab->static_window_map = true;
>>  		ab_pci->pci_ops = &ath12k_wifi7_pci_ops_qcn9274;
>> -		ab->hal_rx_ops = &hal_rx_qcn9274_compact_ops;
>>  		ath12k_wifi7_pci_read_hw_version(ab, &soc_hw_version_major,
>>  						 &soc_hw_version_minor);
>>  		ab->target_mem_mode = ath12k_core_get_memory_mode(ab);
>> @@ -124,7 +123,6 @@ static int ath12k_wifi7_pci_probe(struct pci_dev *pdev,
>>  		ab_pci->msi_config = &ath12k_wifi7_msi_config[0];
>>  		ab->static_window_map = false;
>>  		ab_pci->pci_ops = &ath12k_wifi7_pci_ops_wcn7850;
>> -		ab->hal_rx_ops = &hal_rx_wcn7850_ops;
>>  		ath12k_wifi7_pci_read_hw_version(ab, &soc_hw_version_major,
>>  						 &soc_hw_version_minor);
>>  		ab->target_mem_mode = ATH12K_QMI_MEMORY_MODE_DEFAULT;
> 


