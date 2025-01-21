Return-Path: <linux-wireless+bounces-17776-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C69A179EE
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Jan 2025 10:14:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E08981882D27
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Jan 2025 09:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D27A41BD9E3;
	Tue, 21 Jan 2025 09:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="o2VkuAS/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18EC31BBBCC
	for <linux-wireless@vger.kernel.org>; Tue, 21 Jan 2025 09:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737450864; cv=none; b=Y1I2Ll8StOd7dus14nEORFSke31tmI1sdgQALdi3pFferurTL2+6LG8WuG+ViQ7OiWCq/HsFF+GWmPAxFYcqmJprVpgzkI1arTTMTV/kEkdw/rr1tx2hmI45xXKteisj6Pdpuo6idr0nY0wkZ5IwSEGU9C8JcV4hGVP+54/u3ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737450864; c=relaxed/simple;
	bh=fOHFqzIRe0SfG79ZWzhJv3I46RWQzKX7nZ3nZG6n24Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HpBhmiXzzgteAUR/+DpYR12YheyID+kmrrNOy9lYAKGi7oqRrWqj+Ly9zZqLK+sOSdaehc+Rnk3ICKp97DWq7//tdx4KivHemAFuevanZFV77KdaeWHbY5Jr9nMRdyyw1218WbjH5Gbn9NcNFkAs2FABUfkc1OGOYXWbXH3Thu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=o2VkuAS/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50L8ZvvY019681;
	Tue, 21 Jan 2025 09:14:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RlqZ1GN5fNvtpjl3rKpOWEvyw+2k4NJ5BNR/dXhHIe4=; b=o2VkuAS/uvQhcxAs
	ihLyQ2QdDtv4Ly8DhUnWdxs9yO0sKKjBAqgH+uZ4iYuxVdsfaFmzozfx99QEzPHY
	kaV44/ZkZMl+mNR0C9+c0j3qAN1jJqRbkweXqTgjxhjgNpl8AyNPbbRa01cPE6vq
	iSFRX+Oar/gPkgXa/GyNTvrCdyuAIDIkWWojyNbzf6NdlrOALcb4BEVlbtXlX+yb
	ob/sZulBLgEjCHZXUFTxRgaVX2BEHCOw5QjivXEZstY/YSRPPI0tx8f1ToQXsYau
	6hMuBUgspsEamX9bCBx0EbX24yorMT2J48CV8CAUJllzJ4NzSGnJF7chmv7VKZgb
	DRjXLA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44a85r8474-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Jan 2025 09:14:12 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50L9EBYG005154
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Jan 2025 09:14:11 GMT
Received: from [10.216.58.135] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 21 Jan
 2025 01:14:09 -0800
Message-ID: <8d81dd30-587c-89bd-56ec-2a86ec7accd7@quicinc.com>
Date: Tue, 21 Jan 2025 14:42:48 +0530
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
To: Nicolas Escande <nico.escande@gmail.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, P Praneesh <quic_ppranees@quicinc.com>
References: <20250107021017.3857555-1-quic_periyasa@quicinc.com>
 <20250107021017.3857555-8-quic_periyasa@quicinc.com>
 <D74BE3ES4HZC.GJJ2MY3UH462@gmail.com>
 <e713770a-2032-f007-f828-d24935b042e2@quicinc.com>
 <D74DNZH2FACA.1EWK96IOHSY6I@gmail.com>
Content-Language: en-US
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
In-Reply-To: <D74DNZH2FACA.1EWK96IOHSY6I@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 3k7Hym9M_CFRoyKsrYery-u0ZUvaYoed
X-Proofpoint-ORIG-GUID: 3k7Hym9M_CFRoyKsrYery-u0ZUvaYoed
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-21_04,2025-01-21_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 clxscore=1015 impostorscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 priorityscore=1501 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501210074



On 1/17/2025 6:50 PM, Nicolas Escande wrote:
> On Fri Jan 17, 2025 at 2:06 PM CET, Karthikeyan Periyasamy wrote:
>>
>>
>> On 1/17/2025 5:03 PM, Nicolas Escande wrote:
>>> On Tue Jan 7, 2025 at 3:10 AM CET, Karthikeyan Periyasamy wrote:
>>>> From: P Praneesh <quic_ppranees@quicinc.com>
>>>>
>>>> Currently, the monitor interface is not supported. To support the monitor
>>>> interface, configure the monitor vdev state identifier, configure the HTT
>>>> filter setup, subscribe the mac80211 WANT_MONITOR_VIF feature and prevent
>>>> monitor interface to transmit packet. Therefore, add these procedures to
>>>> add monitor interface support and enable the monitor interface support on
>>>> the QCN9274 platform through the hardware parameter.
>>>>
>>>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
>>>> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>>>>
>>>> Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
>>>> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
>>>> ---
>>> [...]
>>>> diff --git a/drivers/net/wireless/ath/ath12k/dp_tx.c b/drivers/net/wireless/ath/ath12k/dp_tx.c
>>>> index b8f0df6f7a05..81d1ff918f48 100644
>>>> --- a/drivers/net/wireless/ath/ath12k/dp_tx.c
>>>> +++ b/drivers/net/wireless/ath/ath12k/dp_tx.c
>>>> @@ -1,7 +1,7 @@
>>>>    // SPDX-License-Identifier: BSD-3-Clause-Clear
>>>>    /*
>>>>     * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
>>>> - * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
>>>> + * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
>>>>     */
>>>>    
>>>>    #include "core.h"
>>>> @@ -1277,6 +1277,8 @@ int ath12k_dp_tx_htt_rx_monitor_mode_ring_config(struct ath12k *ar, bool reset)
>>>>    					HTT_RX_MON_MO_CTRL_FILTER_FLASG3 |
>>>>    					HTT_RX_MON_FP_DATA_FILTER_FLASG3 |
>>>>    					HTT_RX_MON_MO_DATA_FILTER_FLASG3;
>>>> +	} else {
>>>> +		tlv_filter.rxmon_disable = true;
>>> Shouldn't this be
>>> 	tlv_filter = ath12k_mac_mon_status_filter_default;
>>> To match de default value ?
>>
>> In standalone monitor case, this will enable the default filter
>> unnecessary, no ?
> 
> I'm not too familiar with the driver but clearly this is the part that breaks
> sta info update when running a monitor while an ap is running.
> 
> And as this is a valid interface combination it should work right ?
> 
> So this change works around the problem I reported earlier, I just confirmed it
> on my setup. But maybe this is not the right fix indeed but hopefully it
> points towards the culprit.
> 
>>

Addressed in the next version of the patch.


-- 
Karthikeyan Periyasamy
--
கார்த்திகேயன் பெரியசாமி

