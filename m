Return-Path: <linux-wireless+bounces-1527-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4851825A5A
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Jan 2024 19:42:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57BE31F209E2
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Jan 2024 18:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E095035EE4;
	Fri,  5 Jan 2024 18:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GR6w9Fy/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6437735EE3
	for <linux-wireless@vger.kernel.org>; Fri,  5 Jan 2024 18:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 405Cojfw012490;
	Fri, 5 Jan 2024 18:42:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=ZpAe5VRlP0STPSSdLQrWvfpnlGG/5tsPT3JNP/mE4Us=; b=GR
	6w9Fy/OyQokkRepSbrjdsGwfuBl17kzLpFxkAqkh+P9gd+/pukRDInyQMwWktBxi
	5Q/Ro/jchdIxrlKSIB2B8ubwJJX3CPvQNMzBx8NeQ8iOtoo7Kw4IvyF7sv78WBaG
	Z6Mpx5Bn+ZuKXm953ZZCMt/WYZNdZZgtcRR2Hf2mLXhNZITp27chYAU52D6uIbmy
	r3DZ0obQV72RFujjv6XwqEu+GO0kjUGXtGkeyr4tvvHOCOu/Xq7lQefzEyehUPZB
	wfLgCa0O154hPJiaQu9xEvsSA3eG/XJCPxYzWIJWo5vKx8WmC2WeS4rrhxhGBDo7
	VIvdUgSmxzGC9mGbrOiw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ve96qsy87-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Jan 2024 18:42:12 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 405IgBIc008610
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 5 Jan 2024 18:42:11 GMT
Received: from [10.216.3.245] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 5 Jan
 2024 10:42:08 -0800
Message-ID: <cd79cbd5-f118-15fa-5a1a-d3e3bed3b293@quicinc.com>
Date: Sat, 6 Jan 2024 00:12:04 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 10/13] wifi: ath12k: subscribe required word mask from rx
 tlv
Content-Language: en-US
To: Jeff Johnson <quic_jjohnson@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Kathirvel
	<quic_kathirve@quicinc.com>
References: <20231030222700.18914-1-quic_rajkbhag@quicinc.com>
 <20231030222700.18914-11-quic_rajkbhag@quicinc.com>
 <b0ac4a51-9a24-443a-8155-6100d5e6b00f@quicinc.com>
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
In-Reply-To: <b0ac4a51-9a24-443a-8155-6100d5e6b00f@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: IyYPQE39V_CHOhISzrhmPSdqL48Y0Pc4
X-Proofpoint-GUID: IyYPQE39V_CHOhISzrhmPSdqL48Y0Pc4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=0 impostorscore=0 adultscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 spamscore=0 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311290000 definitions=main-2401050152

On 10/31/2023 6:23 AM, Jeff Johnson wrote:
> On 10/30/2023 3:26 PM, Raj Kumar Bhagat wrote:
>> From: Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
>>
>> Most of the RX descriptors fields are currently not used in the
>> ath12k driver. Hence add support to selectively subscribe to the
>> required quad words (64 bits) within msdu_end and mpdu_start of
>> rx_desc.
>>
>> Add compact rx_desc structures and configure the bit mask for Rx TLVs
>> (msdu_end, mpdu_start, mpdu_end) via registers. With these registers
>> SW can configure to DMA the partial TLV struct to Rx buffer.
>>
>> Each TLV type has its own register to configure the mask value.
>> The mask value configured in register will indicate if a particular
>> QWORD has to be written to rx buffer or not i.e., if Nth bit is enabled
>> in the mask Nth QWORD will be written and it will not be written if the
>> bit is disabled in mask. While 0th bit indicates whether TLV tag will be
>> written or not.
>>
>> Advantages of Qword subscription of TLVs
>> - Avoid multiple cache-line misses as the all the required fields
>> of the TLV are within 128 bytes.
>> - Memory optimization as TLVs + DATA + SHINFO can fit in 2k buffer
>> even for 64 bit kernel.
>>
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00188-QCAHKSWPL_SILICONZ-1
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
>>
>> Signed-off-by: Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
>> Co-developed-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
>> Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
>> ---
>>   drivers/net/wireless/ath/ath12k/dp.c      |   9 +
>>   drivers/net/wireless/ath/ath12k/dp.h      |  13 +
>>   drivers/net/wireless/ath/ath12k/dp_rx.c   |  16 +-
>>   drivers/net/wireless/ath/ath12k/dp_tx.c   |  20 ++
>>   drivers/net/wireless/ath/ath12k/hal.c     | 352 ++++++++++++++++++++++
>>   drivers/net/wireless/ath/ath12k/hal.h     |   3 +
>>   drivers/net/wireless/ath/ath12k/rx_desc.h | 112 ++++++-
>>   drivers/net/wireless/ath/ath12k/wmi.h     |   2 +
>>   8 files changed, 519 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/net/wireless/ath/ath12k/dp.c b/drivers/net/wireless/ath/ath12k/dp.c
>> index 80d7ce44d..faeef965e 100644
>> --- a/drivers/net/wireless/ath/ath12k/dp.c
>> +++ b/drivers/net/wireless/ath/ath12k/dp.c
>> @@ -1001,6 +1001,15 @@ void ath12k_dp_pdev_pre_alloc(struct ath12k_base *ab)
>>     void ath12k_dp_hal_rx_desc_init(struct ath12k_base *ab)
>>   {
>> +    if (test_bit(WMI_TLV_SERVICE_WMSK_COMPACTION_RX_TLVS, ab->wmi_ab.svc_map) &&
>> +        ab->hw_params->hal_ops->rxdma_ring_wmask_rx_mpdu_start &&
>> +        ab->hw_params->hal_ops->rxdma_ring_wmask_rx_msdu_end) {
>> +        /* RX TLVS compaction is supported, hence change the hal_rx_ops
>> +         * based on device.
>> +         */
>> +        if (ab->hal_rx_ops == &hal_rx_qcn9274_ops)
>> +            ab->hal_rx_ops = &hal_rx_qcn9274_compact_ops;
> 
> I only have one comment on this patch.
> 
> in order to avoid chipset-specific logic here suggest that there should be an abstraction.
> 
> several ideas come to mind:
> 1) have a hal_ops callback to retrieve it
> 2) have a pointer to the compact ops in the hw_params
> 
> since we are already using hal_ops to get the masks, suggest that is where we should get the pointer to the compact ops
> 
Thanks Jeff for the suggestion, will implement hal_ops to retrieve
the corresponding compact ops.

>> +    }
>>       ab->hal.hal_desc_sz =
>>           ab->hal_rx_ops->rx_desc_get_desc_size();
>>   }
> 


