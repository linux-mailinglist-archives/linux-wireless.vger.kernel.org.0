Return-Path: <linux-wireless+bounces-17283-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7367BA08659
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jan 2025 05:59:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D138167D90
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jan 2025 04:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F411C5F27;
	Fri, 10 Jan 2025 04:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="c/Ulaug/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794E479D0
	for <linux-wireless@vger.kernel.org>; Fri, 10 Jan 2025 04:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736485175; cv=none; b=oDSbrpxHT8sAbx/I+Fc3yDU8vGhwAEuy2HCk3GVG50SLFwUylYHpyRbXaBqFebER5oY3XKa39GAreIrH/vkkhrzT5iRTe4uDYr5jUZTCkPU7TM7HN1lZ/reB03KtglwMI48Rxrr3m46beGoYYNRScpXJD++Ym99EgKAou+j+1Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736485175; c=relaxed/simple;
	bh=Oa/IaacOpnwpsUVpQokzTEmXbYpJavmaRFJaugNkcz4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Aa+FQqgkzT+ik0QK3L92TGhBX/75OL5lFDf5phqSo/hf720fU3923GjpdpeXz8Ihg8qXLV5wK1Qy+qB86LWNZad81vprSdfQu+Vx+SxMs5U3hSXUmkLGf0tG8XXattM71V4/oQZl31k6VpVNkhXR9o7l0H4MYoOA9Lw30us7KpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=c/Ulaug/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50A3vRoG016198;
	Fri, 10 Jan 2025 04:59:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3R6Ch1hWLTkLnfTiUEzZv4VOwoBlFF/FhiZgJvr0gOs=; b=c/Ulaug/TAiy1dOH
	mtjzauB8VXPXkXVIINXGszz62s/mANzu+TKlkmbFn0AmFBX+eDwx5DQHjH/x9a6C
	UXGidmqW7bERwtSZsqe+0unQxybn6l3VPXiFesf7bgiz74Ox8CvJ2ZATT3Um3r0J
	w212QoBjRxjo6NPptz0HN3MVF52gF3JP1jl6jko423cKySiG7yoplrPixPwEjwYT
	UK68oCrIf4hItIL1DuZBfjQ+X17BjWLxHl51Q4B52e49Btt0TIu9S60CdEBQsc9Q
	GW/ojGZUplCap0Zl28h9dNPRXgelmavQijcx/QsbR1q/uXTNqX8Vaf7+vK39Yoa2
	wIv9dQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 442v3rg3hs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jan 2025 04:59:29 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50A4xSX7022907
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jan 2025 04:59:28 GMT
Received: from [10.216.28.93] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 9 Jan 2025
 20:59:27 -0800
Message-ID: <173844c1-b7c6-4aad-b414-d32b761b91df@quicinc.com>
Date: Fri, 10 Jan 2025 10:29:23 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/5] wifi: ath12k: Disable MLO in Factory Test Mode
To: Aaradhana Sahu <quic_aarasahu@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20250109183551.1028791-1-quic_aarasahu@quicinc.com>
 <20250109183551.1028791-6-quic_aarasahu@quicinc.com>
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
Content-Language: en-US
In-Reply-To: <20250109183551.1028791-6-quic_aarasahu@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: d2eSDs7-2FoVOOu1_iGGEZDmkpAOl7uS
X-Proofpoint-ORIG-GUID: d2eSDs7-2FoVOOu1_iGGEZDmkpAOl7uS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=837 spamscore=0
 clxscore=1015 mlxscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 adultscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501100039

On 1/10/25 00:05, Aaradhana Sahu wrote:
> Factory test mode(FTM) is supported only non-mlo(multi-link operation)
> mode. Therefore, disable MLO when driver boots in FTM mode.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Aaradhana Sahu <quic_aarasahu@quicinc.com>
> ---
>   drivers/net/wireless/ath/ath12k/core.c | 5 ++---
>   drivers/net/wireless/ath/ath12k/qmi.c  | 4 ++--
>   2 files changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
> index d0cf82ca6dae..6705e33074aa 100644
> --- a/drivers/net/wireless/ath/ath12k/core.c
> +++ b/drivers/net/wireless/ath/ath12k/core.c
> @@ -1630,10 +1630,9 @@ static struct ath12k_hw_group *ath12k_core_hw_group_assign(struct ath12k_base *a
>   			return NULL;
>   		}
>   
> -		if (ath12k_core_get_wsi_info(ag, ab) ||
> +		if (ath12k_ftm_mode || ath12k_core_get_wsi_info(ag, ab) ||
>   		    ath12k_core_get_wsi_index(ag, ab)) {
> -			ath12k_dbg(ab, ATH12K_DBG_BOOT,
> -				   "unable to get wsi info from dt, grouping single device");
> +			ath12k_dbg(ab, ATH12K_DBG_BOOT, "grouping single device");
>   			ag->id = ATH12K_INVALID_GROUP_ID;
>   			ag->num_devices = 1;

Why to even bother and check group list to see if a grp already exist
and if not then create a grp and then check ftm_mode?

I think better would be to have something like below?

--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -1598,6 +1598,9 @@ static struct ath12k_hw_group *ath12k_core_hw_group_assign(struct ath12k_base *a
  
         lockdep_assert_held(&ath12k_hw_group_mutex);
  
+       if (ath12k_ftm_mode)
+               goto invalid_group;
+
         /* The grouping of multiple devices will be done based on device tree file.
          * The platforms that do not have any valid group information would have
          * each device to be part of its own invalid group.


>   			memset(ag->wsi_node, 0, sizeof(ag->wsi_node));
> diff --git a/drivers/net/wireless/ath/ath12k/qmi.c b/drivers/net/wireless/ath/ath12k/qmi.c
> index 5c3563383fab..344c12b3b937 100644
> --- a/drivers/net/wireless/ath/ath12k/qmi.c
> +++ b/drivers/net/wireless/ath/ath12k/qmi.c
> @@ -1,7 +1,7 @@
>   // SPDX-License-Identifier: BSD-3-Clause-Clear
>   /*
>    * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
> - * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
> + * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
>    */
>   
>   #include <linux/elf.h>
> @@ -2265,7 +2265,7 @@ static void ath12k_qmi_phy_cap_send(struct ath12k_base *ab)
>   		goto out;
>   	}
>   
> -	if (resp.single_chip_mlo_support_valid &&
> +	if (!ath12k_ftm_mode && resp.single_chip_mlo_support_valid &&
>   	    resp.single_chip_mlo_support)
>   		ab->single_chip_mlo_supp = true;
>   

Better place would be to set ag->mlo_capable as false in
ath12k_core_hw_group_set_mlo_capable() ?

-- 
Aditya

