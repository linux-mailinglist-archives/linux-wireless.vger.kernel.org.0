Return-Path: <linux-wireless+bounces-10702-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 644F394241A
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jul 2024 03:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E77C8285900
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jul 2024 01:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C59323DE;
	Wed, 31 Jul 2024 01:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="bvyyhaU+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F0A539A
	for <linux-wireless@vger.kernel.org>; Wed, 31 Jul 2024 01:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722388502; cv=none; b=QnyV0LuVX8qj5DLINpnxDweH9/N4bm4VHW530tGKa3sejU0i3KytAaJ1n4GWs6NEmkhYZobtlv0e3s5d4qX5pi9LmD88f3XhyWp1mm9JSX7WEX7dVczZzNVisi7GheG297SYprfOZBBkRhhyN7GYYszPZLcuw3+8eLtJO1Cu7PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722388502; c=relaxed/simple;
	bh=4iTu7/7rb8CoLo1s+BWbiVbZOYHOy+uGGTpW9+5ZXlA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=lGz6ZrGUtabDpDdLo1iGzuD1OfoaDXBOxTx/nIAJHlFoH5Tr5Cye2636D2sNWoio8/+j5vH7jHaLLKNpTYBMmIjjbAsWAKSZpxMtvQQsvOsoBCVxZtWfnIXi15XLa6auNHkKTESniadnvP7qUG/kyTqkzP21pvmUF8FddeMeSoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=bvyyhaU+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46UGR1ox004706;
	Wed, 31 Jul 2024 01:14:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tY0b9a3YdFoReXBMCcHc8XiEf/B/gSfwRerHUc6LDOY=; b=bvyyhaU+Dy9RLzYX
	ootVjz3HnQxTayvsGib6femIIXYdTVUkAmD52ChjbTfC3OPAtilGuGXpiYEUjg28
	qulLSpdEom02rJ+VWzxrrToE5ONiD06DJm3QBL+XoABgbqqDkWHmMRz5quBRSmbn
	s8Mi18QWzFiTYsCBMTDkw9UP79OdHLHR34GmJr6rmsteiUK+xt4TezAbSqqLMoKK
	/ZEoFIrSGsojy8Z6blTEBLXgl2EBdR0kDOi6VyPkQRT1gfQzPcTonBS0iUBQ946O
	SdZjY/F6wX/KtLvXdBDvsnHaaG3ggQEHIlTJHiV5EaszJklwwRIVkQdbm3zLCnKN
	GNDhUg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40mryu1hx9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jul 2024 01:14:48 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46V1ElVJ028297
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jul 2024 01:14:47 GMT
Received: from [10.231.216.207] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 30 Jul
 2024 18:14:46 -0700
Message-ID: <c65b4a74-966c-4750-9e23-6caf0aed5c21@quicinc.com>
Date: Wed, 31 Jul 2024 09:14:43 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] wifi: ath11k: use union for vaddr and iaddr in
 target_mem_chunk
To: Jeff Johnson <quic_jjohnson@quicinc.com>, <kvalo@kernel.org>
CC: <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20240730035955.788768-1-quic_miaoqing@quicinc.com>
 <6d516ba0-854e-4aec-8a53-4c2c658e9512@quicinc.com>
Content-Language: en-US
From: Miaoqing Pan <quic_miaoqing@quicinc.com>
In-Reply-To: <6d516ba0-854e-4aec-8a53-4c2c658e9512@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: A1yj7tE01uQYeB_wIJfpcxq3GW6Fu6qR
X-Proofpoint-GUID: A1yj7tE01uQYeB_wIJfpcxq3GW6Fu6qR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-30_21,2024-07-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 suspectscore=0 bulkscore=0 adultscore=0 spamscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 mlxlogscore=999
 mlxscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407310007



On 7/31/2024 1:42 AM, Jeff Johnson wrote:
> On 7/29/2024 8:59 PM, Miaoqing Pan wrote:
>> The value of 'ab->hw_params.fixed_mem_region' determins that
> 
> s/determins/determines/
> 
>> only one variable 'vaddr' or 'iaddr' is used in target_mem_chunk.
>> So use union instead, easy to check whether the memory is set
>> or not.
>>
>> Tested-on: WCN6855 hw2.1 PCI WLAN.HSP.1.1-04358-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
>>
>> Signed-off-by: Miaoqing Pan <quic_miaoqing@quicinc.com>
>> ---
>>   drivers/net/wireless/ath/ath11k/qmi.c | 45 ++++++++++++++-------------
>>   drivers/net/wireless/ath/ath11k/qmi.h |  8 +++--
>>   2 files changed, 29 insertions(+), 24 deletions(-)
>>
>> diff --git a/drivers/net/wireless/ath/ath11k/qmi.c b/drivers/net/wireless/ath/ath11k/qmi.c
>> index 1bc648920ab6..ee32027badcf 100644
>> --- a/drivers/net/wireless/ath/ath11k/qmi.c
>> +++ b/drivers/net/wireless/ath/ath11k/qmi.c
>> @@ -1955,19 +1955,21 @@ static void ath11k_qmi_free_target_mem_chunk(struct ath11k_base *ab)
>>   	int i;
>>   
>>   	for (i = 0; i < ab->qmi.mem_seg_count; i++) {
>> -		if ((ab->hw_params.fixed_mem_region ||
>> -		     test_bit(ATH11K_FLAG_FIXED_MEM_RGN, &ab->dev_flags)) &&
>> -		     ab->qmi.target_mem[i].iaddr)
>> -			iounmap(ab->qmi.target_mem[i].iaddr);
>> +		if (!ab->qmi.target_mem[i].v.iaddr)
> 
> see my comment at the end about potentially adding a new member to test for NULL
> 
>> +			continue;
>>   
>> -		if (!ab->qmi.target_mem[i].vaddr)
>> +		if (ab->hw_params.fixed_mem_region ||
>> +		    test_bit(ATH11K_FLAG_FIXED_MEM_RGN, &ab->dev_flags)) {
>> +			iounmap(ab->qmi.target_mem[i].v.iaddr);
>> +			ab->qmi.target_mem[i].v.iaddr = NULL;
>>   			continue;
>> +		}
>>   
>>   		dma_free_coherent(ab->dev,
>>   				  ab->qmi.target_mem[i].prev_size,
>> -				  ab->qmi.target_mem[i].vaddr,
>> +				  ab->qmi.target_mem[i].v.vaddr,
>>   				  ab->qmi.target_mem[i].paddr);
>> -		ab->qmi.target_mem[i].vaddr = NULL;
>> +		ab->qmi.target_mem[i].v.vaddr = NULL;
>>   	}
>>   }
>>   
>> @@ -1984,22 +1986,22 @@ static int ath11k_qmi_alloc_target_mem_chunk(struct ath11k_base *ab)
>>   		/* Firmware reloads in coldboot/firmware recovery.
>>   		 * in such case, no need to allocate memory for FW again.
>>   		 */
>> -		if (chunk->vaddr) {
>> +		if (chunk->v.vaddr) {
>>   			if (chunk->prev_type == chunk->type &&
>>   			    chunk->prev_size == chunk->size)
>>   				continue;
>>   
>>   			/* cannot reuse the existing chunk */
>>   			dma_free_coherent(ab->dev, chunk->prev_size,
>> -					  chunk->vaddr, chunk->paddr);
>> -			chunk->vaddr = NULL;
>> +					  chunk->v.vaddr, chunk->paddr);
>> +			chunk->v.vaddr = NULL;
>>   		}
>>   
>> -		chunk->vaddr = dma_alloc_coherent(ab->dev,
>> -						  chunk->size,
>> -						  &chunk->paddr,
>> -						  GFP_KERNEL | __GFP_NOWARN);
>> -		if (!chunk->vaddr) {
>> +		chunk->v.vaddr = dma_alloc_coherent(ab->dev,
>> +						    chunk->size,
>> +						    &chunk->paddr,
>> +						    GFP_KERNEL | __GFP_NOWARN);
>> +		if (!chunk->v.vaddr) {
>>   			if (ab->qmi.mem_seg_count <= ATH11K_QMI_FW_MEM_REQ_SEGMENT_CNT) {
>>   				ath11k_dbg(ab, ATH11K_DBG_QMI,
>>   					   "dma allocation failed (%d B type %u), will try later with small size\n",
>> @@ -2055,10 +2057,10 @@ static int ath11k_qmi_assign_target_mem_chunk(struct ath11k_base *ab)
>>   			}
>>   
>>   			ab->qmi.target_mem[idx].paddr = res.start;
>> -			ab->qmi.target_mem[idx].iaddr =
>> +			ab->qmi.target_mem[idx].v.iaddr =
>>   				ioremap(ab->qmi.target_mem[idx].paddr,
>>   					ab->qmi.target_mem[i].size);
>> -			if (!ab->qmi.target_mem[idx].iaddr)
>> +			if (!ab->qmi.target_mem[idx].v.iaddr)
>>   				return -EIO;
>>   
>>   			ab->qmi.target_mem[idx].size = ab->qmi.target_mem[i].size;
>> @@ -2068,7 +2070,7 @@ static int ath11k_qmi_assign_target_mem_chunk(struct ath11k_base *ab)
>>   			break;
>>   		case BDF_MEM_REGION_TYPE:
>>   			ab->qmi.target_mem[idx].paddr = ab->hw_params.bdf_addr;
>> -			ab->qmi.target_mem[idx].vaddr = NULL;
>> +			ab->qmi.target_mem[idx].v.iaddr = NULL;
>>   			ab->qmi.target_mem[idx].size = ab->qmi.target_mem[i].size;
>>   			ab->qmi.target_mem[idx].type = ab->qmi.target_mem[i].type;
>>   			idx++;
>> @@ -2083,18 +2085,19 @@ static int ath11k_qmi_assign_target_mem_chunk(struct ath11k_base *ab)
>>   				if (hremote_node) {
>>   					ab->qmi.target_mem[idx].paddr =
>>   							res.start + host_ddr_sz;
>> -					ab->qmi.target_mem[idx].iaddr =
>> +					ab->qmi.target_mem[idx].v.iaddr =
>>   						ioremap(ab->qmi.target_mem[idx].paddr,
>>   							ab->qmi.target_mem[i].size);
>> -					if (!ab->qmi.target_mem[idx].iaddr)
>> +					if (!ab->qmi.target_mem[idx].v.iaddr)
>>   						return -EIO;
>>   				} else {
>>   					ab->qmi.target_mem[idx].paddr =
>>   						ATH11K_QMI_CALDB_ADDRESS;
>> +					ab->qmi.target_mem[idx].v.iaddr = NULL;
>>   				}
>>   			} else {
>>   				ab->qmi.target_mem[idx].paddr = 0;
>> -				ab->qmi.target_mem[idx].vaddr = NULL;
>> +				ab->qmi.target_mem[idx].v.iaddr = NULL;
>>   			}
>>   			ab->qmi.target_mem[idx].size = ab->qmi.target_mem[i].size;
>>   			ab->qmi.target_mem[idx].type = ab->qmi.target_mem[i].type;
>> diff --git a/drivers/net/wireless/ath/ath11k/qmi.h b/drivers/net/wireless/ath/ath11k/qmi.h
>> index 7e06d100af57..63c957a7075e 100644
>> --- a/drivers/net/wireless/ath/ath11k/qmi.h
>> +++ b/drivers/net/wireless/ath/ath11k/qmi.h
>> @@ -1,7 +1,7 @@
>>   /* SPDX-License-Identifier: BSD-3-Clause-Clear */
>>   /*
>>    * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
>> - * Copyright (c) 2021-2023 Qualcomm Innovation Center, Inc. All rights reserved.
>> + * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
>>    */
>>   
>>   #ifndef ATH11K_QMI_H
>> @@ -102,8 +102,10 @@ struct target_mem_chunk {
>>   	u32 prev_size;
>>   	u32 prev_type;
>>   	dma_addr_t paddr;
>> -	u32 *vaddr;
>> -	void __iomem *iaddr;
>> +	union {
>> +		u32 *vaddr;
>> +		void __iomem *iaddr;
>> +	} v;
> 
> is there a reason you didn't incorporate my prior observation:
> 
> ...if you make it an anonymous union then most, if not all, of the
> code changes are unnecessary.
> 
> I'm also thinking it may make the code even cleaner to add a third member to
> the union:
> 	void *anyaddr
> 
> So you set and clear either vaddr or iaddr based upon the usage, but test
> anyaddr when testing for NULL

Actually, I want ath11k to be the same as ath12k. Anyway, it's a good 
suggestion, will update.

