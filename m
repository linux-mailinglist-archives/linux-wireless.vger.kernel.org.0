Return-Path: <linux-wireless+bounces-18312-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6AA6A2652C
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Feb 2025 21:59:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3ED533A46FE
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Feb 2025 20:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC2220E71C;
	Mon,  3 Feb 2025 20:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="X5AoGXxk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA2020E01D
	for <linux-wireless@vger.kernel.org>; Mon,  3 Feb 2025 20:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738616355; cv=none; b=GNEyIIOy7T5B4yvXqKHw6fhOa9gSHYqj/YO6oBXFrNmD2XZAkpiw9RYTD22QZWL8APNLSTY+IDHjIWqqCRoHL51crZeiu7pFPd2JMRvlvL+pb+3wPjE8Fh7dBiCiUVSNVL+XwcaGImC4J3Zdglvr3M/fYdM+7alMJXHLHKXaqXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738616355; c=relaxed/simple;
	bh=eBKQAuY+fEV3ykaC4N1gjJ2RxUTJ49IUSKCbh6xtewg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hfTzwSwycgi1Ttf7FSgyq5itNHn/wHiwizR9QQWGhO2Et43IzPyFu/IbGjLHUyLmx/ye20mneNiq3Ci0dTJDUBt4CJo8MQ6oxDIIViUO6exvZvbMZMZmcIx56hCrgFtY1KrZeoPmi9FZ5OWsDqy9AxKEzjrsVDzXhBTaCFQY6Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=X5AoGXxk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 513JfrZT019299;
	Mon, 3 Feb 2025 20:58:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/MUbjfNSPdhR8SHei4U9DD4JFD7GXBwyqXkmxDfEtoI=; b=X5AoGXxkUufxDkew
	DHWfhL9I+Te1SxvIv8qQtxGu95l9EB0FMUiipN160PKu6ZU+9MX4TkHbdhJ6tkgG
	tph3pq0MVrYhV8/i2mJJzbwvPPn84rVWkJUKSwIrL5GA+4JCP7GL+miOv0w2BUYv
	wdH2cUe5ZNxmyKIvF6m1f+RexPv9NWTLS71l2Z9eRF9Gu7jqShbmE79OhHkdRZwJ
	B2VYVNUrvtazRGdcCacqpf8iUyjlu28qkw/n2ViI17HsEodCPr8pZLgdHk4HD9Mg
	jlAaxfGuI20WB2HTHDz1soKPJ/ktwlPRxpvCI82jLQG0uIrR36yGFlHTYXJotcvG
	F13IiA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44k46d04v4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Feb 2025 20:58:54 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 513KwrMw019509
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 3 Feb 2025 20:58:53 GMT
Received: from [10.227.107.85] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 3 Feb 2025
 12:58:52 -0800
Message-ID: <f68d3f17-696b-5cd2-53c1-cb2be60e8c9f@quicinc.com>
Date: Mon, 3 Feb 2025 12:58:51 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v3 1/2] wifi: ath12k: Update HTT_TCL_METADATA version and
 bit mask definitions
Content-Language: en-US
To: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20250203075538.3982875-1-quic_bmahalin@quicinc.com>
 <20250203075538.3982875-2-quic_bmahalin@quicinc.com>
 <5b2198ea-014e-48e8-84aa-b7806aa82b4c@oss.qualcomm.com>
From: Balamurugan Mahalingam <quic_bmahalin@quicinc.com>
In-Reply-To: <5b2198ea-014e-48e8-84aa-b7806aa82b4c@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: mb-r32vP0WHODY7DwlbC0Lcj6D4fHYRf
X-Proofpoint-ORIG-GUID: mb-r32vP0WHODY7DwlbC0Lcj6D4fHYRf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-03_09,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 phishscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999
 mlxscore=0 spamscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502030151



On 2/3/2025 7:30 AM, Aditya Kumar Singh wrote:
> On 2/3/25 13:25, Balamurugan Mahalingam wrote:
>> Update the HTT_TCL_METADATA version to the latest version (2)
>> as the bit definitions have changed a little to support more
>> features. This new version allows the host to submit a packet with
>> more information to the firmware. Firmware uses this additional
>> information to do special processing for certain frames.
>>
>> All the firmware binaries available in upstream/public are compatible 
>> with
>> this HTT version update.
>>
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
>> Tested-on: WCN7850 hw2.0 PCI 
>> WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>>
>> Signed-off-by: Balamurugan Mahalingam <quic_bmahalin@quicinc.com>
>> ---
>>   drivers/net/wireless/ath/ath12k/dp.h    | 21 ++++++++++++++-------
>>   drivers/net/wireless/ath/ath12k/dp_tx.c | 12 ++++++++++--
>>   2 files changed, 24 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/net/wireless/ath/ath12k/dp.h 
>> b/drivers/net/wireless/ath/ath12k/dp.h
>> index f68bb78d4a11..7cdc62aa35be 100644
>> --- a/drivers/net/wireless/ath/ath12k/dp.h
>> +++ b/drivers/net/wireless/ath/ath12k/dp.h
>> @@ -1,7 +1,7 @@
>>   /* SPDX-License-Identifier: BSD-3-Clause-Clear */
>>   /*
>>    * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
>> - * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All 
>> rights reserved.
>> + * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All 
>> rights reserved.
>>    */
>>   #ifndef ATH12K_DP_H
>> @@ -372,17 +372,18 @@ struct ath12k_dp {
>>   };
>>   /* HTT definitions */
>> +#define HTT_TAG_TCL_METADATA_VERSION        5
>> -#define HTT_TCL_META_DATA_TYPE        BIT(0)
>> -#define HTT_TCL_META_DATA_VALID_HTT        BIT(1)
>> +#define HTT_TCL_META_DATA_TYPE        GENMASK(1, 0)
>> +#define HTT_TCL_META_DATA_VALID_HTT        BIT(2)
>>   /* vdev meta data */
>> -#define HTT_TCL_META_DATA_VDEV_ID        GENMASK(9, 2)
>> -#define HTT_TCL_META_DATA_PDEV_ID        GENMASK(11, 10)
>> -#define HTT_TCL_META_DATA_HOST_INSPECTED    BIT(12)
>> +#define HTT_TCL_META_DATA_VDEV_ID         GENMASK(10, 3)
>> +#define HTT_TCL_META_DATA_PDEV_ID         GENMASK(12, 11)
>> +#define HTT_TCL_META_DATA_HOST_INSPECTED_MISSION BIT(13)
> 
> nit: Can we align these three new additions in same column?
It actually looks aligned like inside vim. Tabs are used for indentation 
instead of space
> 
>>   /* peer meta data */
>> -#define HTT_TCL_META_DATA_PEER_ID        GENMASK(15, 2)
>> +#define HTT_TCL_META_DATA_PEER_ID        GENMASK(15, 3)
>>   /* HTT tx completion is overlaid in wbm_release_ring */
>>   #define HTT_TX_WBM_COMP_INFO0_STATUS        GENMASK(16, 13)
>> @@ -413,9 +414,15 @@ enum htt_h2t_msg_type {
>>   };
>>   #define HTT_VER_REQ_INFO_MSG_ID        GENMASK(7, 0)
>> +#define HTT_OPTION_TCL_METADATA_VER_V2    2
>> +#define HTT_OPTION_TAG        GENMASK(7, 0)
>> +#define HTT_OPTION_LEN        GENMASK(15, 8)
>> +#define HTT_OPTION_VALUE        GENMASK(31, 16)
>> +#define HTT_TCL_METADATA_VER_SZ        4
>>
> 
> Same here. All aligning in same column would be good.
It actually looks aligned like inside vim. Tabs are used for indentation
instead of space.
> 
>>   struct htt_ver_req_cmd {
>>       __le32 ver_reg_info;
>> +    __le32 tcl_metadata_version;
>>   } __packed;
>>   enum htt_srng_ring_type {
>> diff --git a/drivers/net/wireless/ath/ath12k/dp_tx.c 
>> b/drivers/net/wireless/ath/ath12k/dp_tx.c
>> index aa8058dd2da6..5ed41783d039 100644
>> --- a/drivers/net/wireless/ath/ath12k/dp_tx.c
>> +++ b/drivers/net/wireless/ath/ath12k/dp_tx.c
>> @@ -1,7 +1,7 @@
>>   // SPDX-License-Identifier: BSD-3-Clause-Clear
>>   /*
>>    * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
>> - * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All 
>> rights reserved.
>> + * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All 
>> rights reserved.
>>    */
>>   #include "core.h"
>> @@ -1103,7 +1103,15 @@ int ath12k_dp_tx_htt_h2t_ver_req_msg(struct 
>> ath12k_base *ab)
>>       skb_put(skb, len);
>>       cmd = (struct htt_ver_req_cmd *)skb->data;
>>       cmd->ver_reg_info = le32_encode_bits(HTT_H2T_MSG_TYPE_VERSION_REQ,
>> -                         HTT_VER_REQ_INFO_MSG_ID);
>> +                         HTT_OPTION_TAG);
>> +
>> +    cmd->tcl_metadata_version = 
>> le32_encode_bits(HTT_TAG_TCL_METADATA_VERSION,
>> +                             HTT_OPTION_TAG);
>> +    cmd->tcl_metadata_version |= 
>> le32_encode_bits(HTT_TCL_METADATA_VER_SZ,
>> +                              HTT_OPTION_LEN);
>> +    cmd->tcl_metadata_version |=
>> +            le32_encode_bits(HTT_OPTION_TCL_METADATA_VER_V2,
>> +                     HTT_OPTION_VALUE);
>>
> 
> Can't we write like this ?
> 
> x = a |
>      b |
>      c;
> 
> instead of
> 
> x = a;
> x |= b;
> x |= c;

Fixed in v4.

> 
>>       ret = ath12k_htc_send(&ab->htc, dp->eid, skb);
>>       if (ret) {
> 
> 

