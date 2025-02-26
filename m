Return-Path: <linux-wireless+bounces-19482-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09021A45D3B
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Feb 2025 12:34:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A971A1894814
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Feb 2025 11:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB4A02135A6;
	Wed, 26 Feb 2025 11:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dDOzN+AZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09019322A
	for <linux-wireless@vger.kernel.org>; Wed, 26 Feb 2025 11:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740569653; cv=none; b=HVOI8Jm2RyA77nFmXTyIeFkqraFsxQmeTIeQOYnDNyjPUT64OYe/OiPbc0YkC+2K5oJ4a9llEBJautfIHH2wD4JixvY/BX/fUAEKInaUlHf42xq8YbZRZACvvAmm1gU5DuuNTav0m5yUm3VyOT61O8fABXjwPonrygVT4xE7Ztc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740569653; c=relaxed/simple;
	bh=TnaqMCHY+vlmFsenQVRnWxbL724PZmJu5N0sUkHVhts=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=G/B3lfWbDit6yyx1RzB/d3pY4HpEbCTzAg18jUJXnkx3Vs1gPNw1LAalfbRF/GhsKsCMVApRxTDVU41v/aSpb9rnCXSarTi6Z6BhjRch13iozfqUVc+nu/HCxbZy3EtUOuJihphGqfsol0PiMIHgdR9IyaovwjWMiuTADiPynSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dDOzN+AZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51QALchl012328;
	Wed, 26 Feb 2025 11:34:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	f5Fb/Em3p3IofEQDBmXJo7eAwlYI1sy2MSlie0AadQ8=; b=dDOzN+AZqLGUODjd
	N5i7U/rlbn79fHd8k4oUE63J0iMmF4o6VIlr/tKqnp+XkBlWFTme1Oaz52WNGi/8
	pPsdVryxp5eeiI4txDuHCK1vj8xfJO/py6i9YQApVtAckULV4oX0AdI36eFXoTt/
	aZxa2nrBUJWzukRCTOhzjNC9GBtmuDeYke/Fadrjiz1xmwqdrqt+bt9ff5/wgjCN
	rS2+8U/s55IJIsLDKSWg4QJPQEc6mlad5k0awpj9b7LIzkQgRZpLq2/Wp2Bjhxvp
	6BbjOUhzpcHUNsZjmA69bygQbmAvlQLMg8sudxUKXANAAMvpDc4TF6ywnkLDF4kU
	YVQLpQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 451prk1sxs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Feb 2025 11:34:08 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51QBY7Oh021191
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Feb 2025 11:34:07 GMT
Received: from [10.110.1.92] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 26 Feb
 2025 03:34:06 -0800
Message-ID: <4c1681f7-c4fe-4101-8023-a50b4b59a17d@quicinc.com>
Date: Wed, 26 Feb 2025 19:34:03 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: ath12k: report station mode per-chain signal
 strength
To: <ath12k@lists.infradead.org>, Jeff Johnson <quic_jjohnson@quicinc.com>
CC: <linux-wireless@vger.kernel.org>
References: <20250210054050.656075-1-quic_lingbok@quicinc.com>
Content-Language: en-US
From: Lingbo Kong <quic_lingbok@quicinc.com>
In-Reply-To: <20250210054050.656075-1-quic_lingbok@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: S_XD7sWGDP4I9-aw4Q-tMueqNFLofib4
X-Proofpoint-ORIG-GUID: S_XD7sWGDP4I9-aw4Q-tMueqNFLofib4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-26_02,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 phishscore=0 spamscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 adultscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502260092



On 2025/2/10 13:40, Lingbo Kong wrote:
> Currently, command “iw wlan0 station dump” does not show per-chain signal
> strength.
> 
> This is because ath12k does not handle the num_per_chain_rssi and
> rssi_avg_beacon reported by firmware to ath12k.
> 
> To address this, update ath12k to send WMI_REQUEST_STATS_CMDID with the
> flag WMI_REQUEST_RSSI_PER_CHAIN_STAT to the firmware. Then, add logic to
> handle num_per_chain_rssi and rssi_avg_beacon in the
> ath12k_wmi_tlv_fw_stats_parse(), and assign the resulting per-chain signal
> strength to the chain_signal of struct station_info.
> 
> After that, "iw dev xxx station dump" shows the correct per-chain signal
> strength.
> Such as:
> 
> Station AA:BB:CC:DD:EE:FF (on wlan0)
>          inactive time:  212 ms
>          rx bytes:       10398
>          rx packets:     64
>          tx bytes:       4362
>          tx packets:     33
>          tx retries:     49
>          tx failed:      0
>          beacon loss:    0
>          beacon rx:      14
>          rx drop misc:   16
>          signal:         -45 [-51, -46] dBm
>          beacon signal avg:      -44 dBm
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> 
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219751
> Signed-off-by: Lingbo Kong <quic_lingbok@quicinc.com>
> ---
> v2:
> 1.add break to avoid warning
> 
>   drivers/net/wireless/ath/ath12k/core.h |  5 ++
>   drivers/net/wireless/ath/ath12k/mac.c  | 39 ++++++++++--
>   drivers/net/wireless/ath/ath12k/mac.h  |  2 +
>   drivers/net/wireless/ath/ath12k/wmi.c  | 82 ++++++++++++++++++++++++++
>   drivers/net/wireless/ath/ath12k/wmi.h  | 18 +++++-
>   5 files changed, 139 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
> index 57e71ccbbb67..967e3cad3bca 100644
> --- a/drivers/net/wireless/ath/ath12k/core.h
> +++ b/drivers/net/wireless/ath/ath12k/core.h
> @@ -508,6 +508,7 @@ struct ath12k_link_sta {
>   	u32 bw_prev;


hi jeff,
do you have any updates on this patch?🙂

/lingbo

