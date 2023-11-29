Return-Path: <linux-wireless+bounces-181-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6BF07FCC70
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Nov 2023 02:52:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF7C0282F60
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Nov 2023 01:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 075761FB2;
	Wed, 29 Nov 2023 01:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gt/Rjkdd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A8A1BE
	for <linux-wireless@vger.kernel.org>; Tue, 28 Nov 2023 17:52:24 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AT0Y7eg026206;
	Wed, 29 Nov 2023 01:52:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=3mIceyA9jzplnutS0JR6UTNXrw4wjABji6TYQcXxFMY=;
 b=gt/RjkddM1JtGoLRcE9RHYa0JQRFVN6UJBKzridKsJRpYcu+RnNGM4a4d+riBQa1L06t
 3A8AeN77p/An2Iz6lXrDjvAPfrBZ9LSLVtiDONeZ4AbhOymteKYKkZ0WaFigrR04nonV
 DLzejkJUlzdDK/Ul8zM81K8q0C2rqY6W5mSwHe1Fly01kqUp2G951AvvZyhayQF1ctA1
 3o4kNVAhP9Pnm6hN+Ne/LkF7VesohEnEtIe0putKBhQp57cQG/i/x87r73jtsIAVXboV
 ADGG7KEzp8AbQRv/ogFKUznggAfE6qOOlzktA8lerbdgl0/PtGkx0d2H5cItrTLRScVx 4A== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3unfn4t35b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Nov 2023 01:52:18 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AT1qGU8022859
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Nov 2023 01:52:17 GMT
Received: from [10.231.195.68] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 28 Nov
 2023 17:52:15 -0800
Message-ID: <b7ac484a-4b60-4743-bb77-7e3a38180e7d@quicinc.com>
Date: Wed, 29 Nov 2023 09:52:13 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] wifi: ath12k: add support for BA1024
Content-Language: en-US
To: Jeff Johnson <quic_jjohnson@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20231128025440.46988-1-quic_bqiang@quicinc.com>
 <20231128025440.46988-3-quic_bqiang@quicinc.com>
 <803affe3-c332-457a-b0ca-92450664cb6e@quicinc.com>
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <803affe3-c332-457a-b0ca-92450664cb6e@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: h90b8kQ8Wr10B1vR3iqcjCoo5oPRz3gz
X-Proofpoint-GUID: h90b8kQ8Wr10B1vR3iqcjCoo5oPRz3gz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-28_27,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 impostorscore=0 adultscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 mlxscore=0 bulkscore=0 mlxlogscore=999 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311290012



On 11/28/2023 11:47 PM, Jeff Johnson wrote:
> On 11/27/2023 6:54 PM, Baochen Qiang wrote:
>> Currently the maximum block ACK window size supported is 256.
>> This results in that, when connected to an AP which supports
>> larger BA sizes like BA512 or BA1024, only BA256 is
>> established, leading to a lower peak throughput.
>>
>> So add support for BA1024, this is doen by allocating a larger
> 
> nit: s/doen/done/
> 
>> REO queue and advertising IEEE80211_MAX_AMPDU_BUF_EHT support
>> to MAC80211.
>>
>> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
>>
>> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
>> ---
>>   drivers/net/wireless/ath/ath12k/dp.h       |  2 +-
>>   drivers/net/wireless/ath/ath12k/hal_desc.h | 28 ++++++++++++++++++++++
>>   drivers/net/wireless/ath/ath12k/hal_rx.c   | 11 ++++++---
>>   drivers/net/wireless/ath/ath12k/mac.c      |  2 +-
>>   4 files changed, 38 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/net/wireless/ath/ath12k/dp.h b/drivers/net/wireless/ath/ath12k/dp.h
>> index 61f765432516..50db1403ebce 100644
>> --- a/drivers/net/wireless/ath/ath12k/dp.h
>> +++ b/drivers/net/wireless/ath/ath12k/dp.h
>> @@ -145,7 +145,7 @@ struct ath12k_pdev_dp {
>>   
>>   #define DP_RX_HASH_ENABLE	1 /* Enable hash based Rx steering */
>>   
>> -#define DP_BA_WIN_SZ_MAX	256
>> +#define DP_BA_WIN_SZ_MAX	1024
>>   
>>   #define DP_TCL_NUM_RING_MAX	4
>>   
>> diff --git a/drivers/net/wireless/ath/ath12k/hal_desc.h b/drivers/net/wireless/ath/ath12k/hal_desc.h
>> index ec204939e50c..f12977aa6afe 100644
>> --- a/drivers/net/wireless/ath/ath12k/hal_desc.h
>> +++ b/drivers/net/wireless/ath/ath12k/hal_desc.h
>> @@ -2517,6 +2517,34 @@ struct hal_reo_update_rx_queue {
>>   	__le32 pn[4];
>>   } __packed;
>>   
>> +struct hal_rx_reo_queue_1k {
>> +	struct hal_desc_header desc_hdr;
>> +	__le32 rx_bitmap_319_288;
> 
> are these individual bitmap members ever directly referenced? seems it
> would make more sense to have simply:
> 	__le32 rx_bitmap_1023_288[23]
> 
> this would align with struct hal_rx_reo_queue which defines:
> 	__le32 rx_bitmap[9]
> 
>> +	__le32 rx_bitmap_351_320;
>> +	__le32 rx_bitmap_383_352;
>> +	__le32 rx_bitmap_415_384;
>> +	__le32 rx_bitmap_447_416;
>> +	__le32 rx_bitmap_479_448;
>> +	__le32 rx_bitmap_511_480;
>> +	__le32 rx_bitmap_543_512;
>> +	__le32 rx_bitmap_575_544;
>> +	__le32 rx_bitmap_607_576;
>> +	__le32 rx_bitmap_639_608;
>> +	__le32 rx_bitmap_671_640;
>> +	__le32 rx_bitmap_703_672;
>> +	__le32 rx_bitmap_735_704;
>> +	__le32 rx_bitmap_767_736;
>> +	__le32 rx_bitmap_799_768;
>> +	__le32 rx_bitmap_831_800;
>> +	__le32 rx_bitmap_863_832;
>> +	__le32 rx_bitmap_895_864;
>> +	__le32 rx_bitmap_927_896;
>> +	__le32 rx_bitmap_959_928;
>> +	__le32 rx_bitmap_991_960;
>> +	__le32 rx_bitmap_1023_992;
>> +	__le32 reserved[8];
>> +} __packed;
>> +
>>   #define HAL_REO_UNBLOCK_CACHE_INFO0_UNBLK_CACHE		BIT(0)
>>   #define HAL_REO_UNBLOCK_CACHE_INFO0_RESOURCE_IDX	GENMASK(2, 1)
>>   
>> diff --git a/drivers/net/wireless/ath/ath12k/hal_rx.c b/drivers/net/wireless/ath/ath12k/hal_rx.c
>> index f6afbd8196bf..6fa874a93d3a 100644
>> --- a/drivers/net/wireless/ath/ath12k/hal_rx.c
>> +++ b/drivers/net/wireless/ath/ath12k/hal_rx.c
>> @@ -688,23 +688,28 @@ void ath12k_hal_reo_update_rx_reo_queue_status(struct ath12k_base *ab,
>>   
>>   u32 ath12k_hal_reo_qdesc_size(u32 ba_window_size, u8 tid)
>>   {
>> -	u32 num_ext_desc;
>> +	u32 num_ext_desc, num_1k_desc = 0;
>>   
>>   	if (ba_window_size <= 1) {
>>   		if (tid != HAL_DESC_REO_NON_QOS_TID)
>>   			num_ext_desc = 1;
>>   		else
>>   			num_ext_desc = 0;
>> +
>>   	} else if (ba_window_size <= 105) {
>>   		num_ext_desc = 1;
>>   	} else if (ba_window_size <= 210) {
>>   		num_ext_desc = 2;
>> -	} else {
>> +	} else if (ba_window_size <= 256) {
>>   		num_ext_desc = 3;
>> +	} else {
>> +		num_ext_desc = 10;
>> +		num_1k_desc = 1;
>>   	}
>>   
>>   	return sizeof(struct hal_rx_reo_queue) +
>> -		(num_ext_desc * sizeof(struct hal_rx_reo_queue_ext));
>> +		(num_ext_desc * sizeof(struct hal_rx_reo_queue_ext)) +
>> +		(num_1k_desc * sizeof(struct hal_rx_reo_queue_1k));
>>   }
>>   
>>   void ath12k_hal_reo_qdesc_setup(struct hal_rx_reo_queue *qdesc,
>> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
>> index fc0d14ea328e..3cfb17f71aa6 100644
>> --- a/drivers/net/wireless/ath/ath12k/mac.c
>> +++ b/drivers/net/wireless/ath/ath12k/mac.c
>> @@ -7474,7 +7474,7 @@ static int __ath12k_mac_register(struct ath12k *ar)
>>   	ar->hw->queues = ATH12K_HW_MAX_QUEUES;
>>   	ar->hw->wiphy->tx_queue_len = ATH12K_QUEUE_LEN;
>>   	ar->hw->offchannel_tx_hw_queue = ATH12K_HW_MAX_QUEUES - 1;
>> -	ar->hw->max_rx_aggregation_subframes = IEEE80211_MAX_AMPDU_BUF_HE;
>> +	ar->hw->max_rx_aggregation_subframes = IEEE80211_MAX_AMPDU_BUF_EHT;
>>   
>>   	ar->hw->vif_data_size = sizeof(struct ath12k_vif);
>>   	ar->hw->sta_data_size = sizeof(struct ath12k_sta);
> 
> Are any related changes needed to struct hal_reo_get_queue_stats_status?
> Or to ath12k_hal_reo_status_queue_stats()?
> There I see the 256-bit bitmap being dumped -- do you need to dump the
> 1024-bit bitmap? Is there a mechanism which allows that?
I don't think it's possible. As you can see, struct 
hal_reo_get_queue_stats_status is directly extracted from REO_STATUS 
ring, which is queued by firmware/HW. That is to say firmware/HW doesn't 
upload other bitmap info, except for the first 256 bits, to host, so 
host has no way to dump them.
> 
> 

