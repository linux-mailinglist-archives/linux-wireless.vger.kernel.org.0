Return-Path: <linux-wireless+bounces-19327-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F51DA40938
	for <lists+linux-wireless@lfdr.de>; Sat, 22 Feb 2025 15:51:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74E9519C1D08
	for <lists+linux-wireless@lfdr.de>; Sat, 22 Feb 2025 14:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B1A3189BAF;
	Sat, 22 Feb 2025 14:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LWYd1COq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5E71386B4
	for <linux-wireless@vger.kernel.org>; Sat, 22 Feb 2025 14:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740235855; cv=none; b=gtbEO7BSxveNaE++Gteqx53q5ckO0SnJVdN/VQMa6KlpdNjWNsox/Kwp0sYVg3/Bcu4ne5yuCPNaO3Qb/QkItYKqqleoAm+3Zhh1quSJvr0QGpcqoy1AfnTGteMdPiWcLOAL2bHojFMJgYpitCz9f3DoE0ddMN5YkzsBLdYIk6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740235855; c=relaxed/simple;
	bh=nTVR+Vwj05RwwX4nDm7NqdF8ziUi0rx2JXeoR8t60T8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=j98r6UJo8TTFQPdCxLxLs6YjNrsmFU9zn1SePFEk+MQUHyfh5XuUlCw6KwJ6C05NhV2vvaSkzkUIKHjYZZMVzCVQnDSNYvvBdDrr8B/SOXvKrJ0oPUAIwBKKyf4mWtsW79C99VLo0gaWCRWvCly8+KPyFDa0e13KB5G1GXgxzmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=LWYd1COq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51ME0U7a025662;
	Sat, 22 Feb 2025 14:50:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	r8/eER/E0KCYK/lGKhQf+tJW9i27Yoy266zEBjm1jRA=; b=LWYd1COquqcGcDqx
	vuB9nB4DTTej5yWnT01N7TIjwwj0A6KwP/th+09UlqhsOblKL1bobIQp7XKdf8z3
	LE/lAuRHmlDLLIDMGPlcgx2SYLS5wC7rVVDsYF0ezBFm+8I3kb/nvczI+J4tIntf
	kKls4TWJ4gq0/HXYcsLLmL0PthHMeYY9NEZfzGQInxq81SAg6ACWJ8uIXHH1iePF
	3CRG0H5aMrm8cu00xouYGdhBt9IFloyI4F93Qr8fNJtAJ4avPl1ccRryUw8gqu57
	o+rJeRArQJqgOIMnNyVMzFguuMu/0jyY0E33djNCUM0JZkp4wN/1WvWeacCZpt5W
	0wxe3A==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44y49e91cm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 22 Feb 2025 14:50:50 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51MEonvd015534
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 22 Feb 2025 14:50:49 GMT
Received: from [10.216.33.17] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sat, 22 Feb
 2025 06:50:48 -0800
Message-ID: <1d231399-eb23-c82b-d18a-9203cca93862@quicinc.com>
Date: Sat, 22 Feb 2025 20:20:44 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v7 9/9] wifi: ath12k: add monitor interface support on
 QCN9274
Content-Language: en-US
To: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, P Praneesh <quic_ppranees@quicinc.com>
References: <20250222033002.3886215-1-quic_periyasa@quicinc.com>
 <20250222033002.3886215-10-quic_periyasa@quicinc.com>
 <8385965d-1be7-12e7-b636-1a0750ee8762@oss.qualcomm.com>
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
In-Reply-To: <8385965d-1be7-12e7-b636-1a0750ee8762@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: DX2JtjzCCeF434OepuA66Ccg8qTEEpyX
X-Proofpoint-GUID: DX2JtjzCCeF434OepuA66Ccg8qTEEpyX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-22_06,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 impostorscore=0 spamscore=0 mlxlogscore=999 lowpriorityscore=0 mlxscore=0
 adultscore=0 malwarescore=0 clxscore=1015 phishscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2502220118



On 2/22/2025 7:44 PM, Vasanthakumar Thiagarajan wrote:
> 
> 
> On 2/22/2025 9:00 AM, Karthikeyan Periyasamy wrote:
>> From: P Praneesh <quic_ppranees@quicinc.com>
>>
>> Currently, the monitor interface is not supported. To support the monitor
>> interface, configure the monitor vdev state identifier, configure the HTT
>> filter setup, subscribe the mac80211 NO_VIRTUAL_MONITOR feature and
>> prevent monitor interface to transmit packet. Therefore, add these
>> procedures to add monitor interface support and enable the monitor
>> interface support on the QCN9274 platform through the hardware parameter.
>>
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
>> Tested-on: WCN7850 hw2.0 PCI 
>> WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>>
>> Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
>> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
>> ---
>>   drivers/net/wireless/ath/ath12k/core.c  |  5 +++++
>>   drivers/net/wireless/ath/ath12k/dp_tx.c |  6 +++++
>>   drivers/net/wireless/ath/ath12k/hw.c    |  4 ++--
>>   drivers/net/wireless/ath/ath12k/mac.c   | 30 ++++++++++++++++++++++++-
>>   4 files changed, 42 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/net/wireless/ath/ath12k/core.c 
>> b/drivers/net/wireless/ath/ath12k/core.c
>> index 0b2dec081c6e..ed7365ce7f95 100644
>> --- a/drivers/net/wireless/ath/ath12k/core.c
>> +++ b/drivers/net/wireless/ath/ath12k/core.c
>> @@ -1306,6 +1306,11 @@ static void 
>> ath12k_core_pre_reconfigure_recovery(struct ath12k_base *ab)
>>                        ath12k_mac_tx_mgmt_pending_free, ar);
>>               idr_destroy(&ar->txmgmt_idr);
>>               wake_up(&ar->txmgmt_empty_waitq);
>> +
>> +            ar->monitor_vdev_id = -1;
>> +            ar->monitor_conf_enabled = false;
>> +            ar->monitor_vdev_created = false;
>> +            ar->monitor_started = false;
>>           }
>>       }
>> diff --git a/drivers/net/wireless/ath/ath12k/dp_tx.c 
>> b/drivers/net/wireless/ath/ath12k/dp_tx.c
>> index 46a55554c19c..a74afa8b2236 100644
>> --- a/drivers/net/wireless/ath/ath12k/dp_tx.c
>> +++ b/drivers/net/wireless/ath/ath12k/dp_tx.c
>> @@ -7,6 +7,7 @@
>>   #include "core.h"
>>   #include "dp_tx.h"
>>   #include "debug.h"
>> +#include "debugfs.h"
>>   #include "hw.h"
>>   #include "peer.h"
>>   #include "mac.h"
>> @@ -1431,6 +1432,11 @@ int 
>> ath12k_dp_tx_htt_rx_monitor_mode_ring_config(struct ath12k *ar, bool 
>> reset)
>>                       HTT_RX_MON_MO_CTRL_FILTER_FLASG3 |
>>                       HTT_RX_MON_FP_DATA_FILTER_FLASG3 |
>>                       HTT_RX_MON_MO_DATA_FILTER_FLASG3;
>> +    } else {
>> +        tlv_filter = ath12k_mac_mon_status_filter_default;
>> +
>> +        if (ath12k_debugfs_is_extd_rx_stats_enabled(ar))
>> +            tlv_filter.rx_filter = ath12k_debugfs_rx_filter(ar);
>>       }
>>       if (ab->hw_params->rxdma1_enable) {
>> diff --git a/drivers/net/wireless/ath/ath12k/hw.c 
>> b/drivers/net/wireless/ath/ath12k/hw.c
>> index a106ebed7870..021a4b565e8b 100644
>> --- a/drivers/net/wireless/ath/ath12k/hw.c
>> +++ b/drivers/net/wireless/ath/ath12k/hw.c
>> @@ -1,7 +1,7 @@
>>   // SPDX-License-Identifier: BSD-3-Clause-Clear
>>   /*
>>    * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
>> - * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All 
>> rights reserved.
>> + * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All 
>> rights reserved.
>>    */
>>   #include <linux/types.h>
>> @@ -1049,7 +1049,7 @@ static const struct ath12k_hw_params 
>> ath12k_hw_params[] = {
>>                       BIT(NL80211_IFTYPE_AP) |
>>                       BIT(NL80211_IFTYPE_MESH_POINT) |
>>                       BIT(NL80211_IFTYPE_AP_VLAN),
>> -        .supports_monitor = false,
>> +        .supports_monitor = true,
>>           .idle_ps = false,
>>           .download_calib = true,
>> diff --git a/drivers/net/wireless/ath/ath12k/mac.c 
>> b/drivers/net/wireless/ath/ath12k/mac.c
>> index 54af9cbbf7cb..b90dad5cb2e0 100644
>> --- a/drivers/net/wireless/ath/ath12k/mac.c
>> +++ b/drivers/net/wireless/ath/ath12k/mac.c
>> @@ -1349,9 +1349,15 @@ static int ath12k_mac_monitor_start(struct 
>> ath12k *ar)
>>           return ret;
>>       }
>> +    ret = ath12k_dp_tx_htt_monitor_mode_ring_config(ar, false);
>> +    if (ret) {
>> +        ath12k_warn(ar->ab, "fail to set monitor filter: %d\n", ret);
>> +        return ret;
>> +    }
>> +
>>       ar->monitor_started = true;
>>       ar->num_started_vdevs++;
>> -    ret = ath12k_dp_tx_htt_monitor_mode_ring_config(ar, false);
>> +
>>       ath12k_dbg(ar->ab, ATH12K_DBG_MAC, "mac monitor started ret 
>> %d\n", ret);
>>       return ret;
>> @@ -7334,6 +7340,11 @@ static void ath12k_mac_op_tx(struct 
>> ieee80211_hw *hw,
>>       u8 link_id;
>>       int ret;
>> +    if (ahvif->vdev_type == WMI_VDEV_TYPE_MONITOR) {
>> +        ieee80211_free_txskb(hw, skb);
>> +        return;
>> +    }
>> +
>>       link_id = u32_get_bits(info->control.flags, 
>> IEEE80211_TX_CTRL_MLO_LINK);
>>       memset(skb_cb, 0, sizeof(*skb_cb));
>>       skb_cb->vif = vif;
>> @@ -8083,6 +8094,9 @@ int ath12k_mac_vdev_create(struct ath12k *ar, 
>> struct ath12k_link_vif *arvif)
>>       lockdep_assert_wiphy(hw->wiphy);
>> +    if (vif->type == NL80211_IFTYPE_MONITOR && ar->monitor_vdev_created)
>> +        return -EINVAL;
>> +
> 
> Some comment on the scenario that is being handled here might be helpful?
> 

sure, will address this comment in the next version of the patch.

-- 
Karthikeyan Periyasamy
--
கார்த்திகேயன் பெரியசாமி

