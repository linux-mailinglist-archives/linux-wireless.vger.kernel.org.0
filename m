Return-Path: <linux-wireless+bounces-17650-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4947AA15012
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Jan 2025 14:07:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2913C163724
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Jan 2025 13:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC6FF1FF1DD;
	Fri, 17 Jan 2025 13:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="F7Ud6o52"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B67F1FBC96
	for <linux-wireless@vger.kernel.org>; Fri, 17 Jan 2025 13:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737119222; cv=none; b=lQvwMB71uOVvywYmi2e7DTiLtit0Xf/EtvvUrA3EnXhjNWzO4zYD8I7FuPq7rBWbt6oCQXmWGcH9XD8sPxcCDFr5uOqMVERWRe2fLfaCu1rNLP2cH46Tv8REsL/eOOMUpM7S+8OFBWxmvJUYeqFrnWcLBSYfuInjWV9Tb9WG2uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737119222; c=relaxed/simple;
	bh=M9n5zB2T464tXsQ95CzxeVVWnr9CGSHp25AmOI3qzRA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=aaTvgABKn8FlCaH7z6ppY0gQR03J42/HfTCjkeL3lbYUfV9QqDq/ab7yFIWLtbLQOSOkav4lk6ME4j9/WoBSLfG5Hn2hZHga77JhObw1uku8mQh310M9GwPbTO6Coj4cijMmU/eqfsIzd3LcqWwsRi7DCPvVVMKnoVO7h125454=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=F7Ud6o52; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50H7Kqe0014963;
	Fri, 17 Jan 2025 13:06:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Yc5c+T67zl6lnn4w/bB0LLqqkmCWOj2HqfxhAJ9/8cQ=; b=F7Ud6o52jO023R4F
	rxMSXIhUuoUjghgRirliPb2TBCgOYefqgVuFVfSkc5oCa4k6q7WnSyfwbSwevXWV
	e4lhFY0bXGhYo7kYTBvvP5/VrHxojMd+8ue8zjn6EiK3zdS5LRj/d15wpF8I2r1t
	PlTZLv0yBUXLvQjj81cZNRSpadteBQWk19jXCkr57JZ+H29Nhz6ARPC64M+aZBzK
	xmgPRw0S1g238U6sHCFEpzYCVsZQ/0pa1vCojASF7O9WN8CWt4bUf1atRyQIbPF7
	mzgsZtYi4OcTO3U7FipDf7qtUQdLgGCIuDTudMB/xkosA2/V1kPGDRu3wnqC5gMy
	J4eRDQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 447jr38vce-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jan 2025 13:06:56 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50HD6tTt008459
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jan 2025 13:06:55 GMT
Received: from [10.216.26.179] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 17 Jan
 2025 05:06:53 -0800
Message-ID: <e713770a-2032-f007-f828-d24935b042e2@quicinc.com>
Date: Fri, 17 Jan 2025 18:36:49 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 7/7] wifi: ath12k: add monitor interface support on
 QCN9274
Content-Language: en-US
To: Nicolas Escande <nico.escande@gmail.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, P Praneesh <quic_ppranees@quicinc.com>
References: <20250107021017.3857555-1-quic_periyasa@quicinc.com>
 <20250107021017.3857555-8-quic_periyasa@quicinc.com>
 <D74BE3ES4HZC.GJJ2MY3UH462@gmail.com>
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
In-Reply-To: <D74BE3ES4HZC.GJJ2MY3UH462@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: EEVM2UrKbLbMDu7yjxdm1Uc2b4cG6tec
X-Proofpoint-GUID: EEVM2UrKbLbMDu7yjxdm1Uc2b4cG6tec
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-17_05,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 malwarescore=0 bulkscore=0 adultscore=0 impostorscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501170105



On 1/17/2025 5:03 PM, Nicolas Escande wrote:
> On Tue Jan 7, 2025 at 3:10 AM CET, Karthikeyan Periyasamy wrote:
>> From: P Praneesh <quic_ppranees@quicinc.com>
>>
>> Currently, the monitor interface is not supported. To support the monitor
>> interface, configure the monitor vdev state identifier, configure the HTT
>> filter setup, subscribe the mac80211 WANT_MONITOR_VIF feature and prevent
>> monitor interface to transmit packet. Therefore, add these procedures to
>> add monitor interface support and enable the monitor interface support on
>> the QCN9274 platform through the hardware parameter.
>>
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
>> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>>
>> Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
>> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
>> ---
> [...]
>> diff --git a/drivers/net/wireless/ath/ath12k/dp_tx.c b/drivers/net/wireless/ath/ath12k/dp_tx.c
>> index b8f0df6f7a05..81d1ff918f48 100644
>> --- a/drivers/net/wireless/ath/ath12k/dp_tx.c
>> +++ b/drivers/net/wireless/ath/ath12k/dp_tx.c
>> @@ -1,7 +1,7 @@
>>   // SPDX-License-Identifier: BSD-3-Clause-Clear
>>   /*
>>    * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
>> - * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
>> + * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
>>    */
>>   
>>   #include "core.h"
>> @@ -1277,6 +1277,8 @@ int ath12k_dp_tx_htt_rx_monitor_mode_ring_config(struct ath12k *ar, bool reset)
>>   					HTT_RX_MON_MO_CTRL_FILTER_FLASG3 |
>>   					HTT_RX_MON_FP_DATA_FILTER_FLASG3 |
>>   					HTT_RX_MON_MO_DATA_FILTER_FLASG3;
>> +	} else {
>> +		tlv_filter.rxmon_disable = true;
> Shouldn't this be
> 	tlv_filter = ath12k_mac_mon_status_filter_default;
> To match de default value ?

In standalone monitor case, this will enable the default filter 
unnecessary, no ?


>>   	}
>>   
>>   	if (ab->hw_params->rxdma1_enable) {
>> diff --git a/drivers/net/wireless/ath/ath12k/hw.c b/drivers/net/wireless/ath/ath12k/hw.c
>> index a106ebed7870..021a4b565e8b 100644
>> --- a/drivers/net/wireless/ath/ath12k/hw.c
>> +++ b/drivers/net/wireless/ath/ath12k/hw.c
>> @@ -1,7 +1,7 @@
>>   // SPDX-License-Identifier: BSD-3-Clause-Clear
>>   /*
>>    * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
>> - * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
>> + * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
>>    */
>>   
>>   #include <linux/types.h>
>> @@ -1049,7 +1049,7 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
>>   					BIT(NL80211_IFTYPE_AP) |
>>   					BIT(NL80211_IFT

YPE_MESH_POINT) |
>>   					BIT(NL80211_IFTYPE_AP_VLAN),
>> -		.supports_monitor = false,
>> +		.supports_monitor = true,
>>   
>>   		.idle_ps = false,
>>   		.download_calib = true,
>> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
>> index abf7c7ed8967..27d44b508884 100644
>> --- a/drivers/net/wireless/ath/ath12k/mac.c
>> +++ b/drivers/net/wireless/ath/ath12k/mac.c
>> @@ -1264,6 +1264,12 @@ static int ath12k_mac_monitor_start(struct ath12k *ar)
>>   		return ret;
>>   	}
>>   
>> +	ret = ath12k_dp_tx_htt_monitor_mode_ring_config(ar, false);
> This is already done a few lines after. Shouldn't the one after be removed

yes, will remove in the next version of the patch.
-- 
Karthikeyan Periyasamy
--
கார்த்திகேயன் பெரியசாமி

