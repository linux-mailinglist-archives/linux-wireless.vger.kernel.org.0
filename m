Return-Path: <linux-wireless+bounces-14178-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8700E9A2ED8
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Oct 2024 22:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4700D28128E
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Oct 2024 20:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A91D227B81;
	Thu, 17 Oct 2024 20:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Fz94uDlo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5AE417BB32
	for <linux-wireless@vger.kernel.org>; Thu, 17 Oct 2024 20:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729197629; cv=none; b=eLUBsYjjOI3p6TzGVhjdX4VHTH42Mp6UR41D5O6pSmIeaD/8x2Qt5XOauU3aByvEGjWiugg9aBopA+CdwML0YpJfA7/qVVz1EmU1Q41Tzw78J63WijHX232U17hLFqFWg4fYfJimlmpFAxSPGz/mSihywYvF5kYr5ULqSlDgiOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729197629; c=relaxed/simple;
	bh=8oYN/JtZIU6wu1IlMGN4vqlkMK6MzJIKa7RMMjZYNo4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jKYXBRQzDBihQwYfYXETP/LeeM5PqYjsJvnH2j81DUI86cwQSHwztHucSpW+GJRbe8Sldew1U0plW6JvTDlQUb7fjJHSfH0TBBy8jHyL33o2k7Lv35QlPj3p74nV+9OPMlDLxWtPLgwbs+L6xSEe4ZrTz2a1T0+dmq067lXWigs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Fz94uDlo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49HAMg54019917;
	Thu, 17 Oct 2024 20:40:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6GEad3yt4EIkTVEEet9acfOr34ysa0sRiX1/Tq4mcOg=; b=Fz94uDlo4HgaxHBM
	12cdnQynkT5aCSQTnWKBb7HS+h+tA4IUPI+nFaLhtPcwhMuLP718r94lC0I8SX9i
	1jtgkyMTN2cTARZNZe2QPxA1OJk9KOGynUKjDkVEa6E2WzCGKaIYeT4setD+Iy1t
	sbMYdDySFeybhAk5MDm9l0IgSe+NjpA88TA/fKY8vmer5ltnWkiF7k/qS7QWe7XJ
	CUwKoc3oJn57gQx0RR54H4wyPv+/OGSesDc29oqaGRSeb8Os+wS8KMaGhUa+ntFl
	szod19m4eRvVW2hVqJ7Gkg3zc+53g/8OXaMwiAoJweLxf2f2vFUeTy7gWLgVR+bV
	UFMJaw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42b0rx1ra1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Oct 2024 20:40:17 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49HKeHKU013094
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Oct 2024 20:40:17 GMT
Received: from [10.48.241.64] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 17 Oct
 2024 13:40:16 -0700
Message-ID: <4b75e9d9-0ae0-4427-a3c4-a49c6a3f8d75@quicinc.com>
Date: Thu, 17 Oct 2024 13:40:15 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/11] wifi: ath12k: fix struct hal_rx_ppdu_start
To: Kang Yang <quic_kangyang@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20241017031056.1714-1-quic_kangyang@quicinc.com>
 <20241017031056.1714-5-quic_kangyang@quicinc.com>
Content-Language: en-US
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20241017031056.1714-5-quic_kangyang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: CpxapnPPKVA9ggKMS8l4EHIiOR0p41Uu
X-Proofpoint-ORIG-GUID: CpxapnPPKVA9ggKMS8l4EHIiOR0p41Uu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 mlxscore=0 priorityscore=1501 spamscore=0 suspectscore=0 impostorscore=0
 mlxlogscore=648 malwarescore=0 lowpriorityscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410170139

On 10/16/2024 8:10 PM, Kang Yang wrote:
> Current struct hal_rx_ppdu_start in hal_rx.h is not matched with
> hardware descriptor definition.
> 
> So update this structure and related code.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
> ---
>  drivers/net/wireless/ath/ath12k/dp_mon.c | 16 ++++++++++++----
>  drivers/net/wireless/ath/ath12k/hal_rx.h | 11 ++++++++---
>  2 files changed, 20 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wireless/ath/ath12k/dp_mon.c
> index 8aef25c0d98b..86796efe5acd 100644
> --- a/drivers/net/wireless/ath/ath12k/dp_mon.c
> +++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
> @@ -593,12 +593,20 @@ ath12k_dp_mon_rx_parse_status_tlv(struct ath12k_base *ab,
>  		struct hal_rx_ppdu_start *ppdu_start =
>  			(struct hal_rx_ppdu_start *)tlv_data;
>  
> +		u64 ppdu_ts = __le32_to_cpu(ppdu_start->ppdu_start_ts_31_0) |
> +			(u64)(__le32_to_cpu(ppdu_start->ppdu_start_ts_63_32)) << 32;

a recent debugfs change introduced ath12k_le32hilo_to_u64()
https://lore.kernel.org/all/20241014065259.3968727-1-quic_rdevanat@quicinc.com/

but this is currently static within debugfs_htt_stats.c

perhaps we should move this into a header files and make it inline so that it
can be shared with this code

> +
>  		info[0] = __le32_to_cpu(ppdu_start->info0);
>  
> -		ppdu_info->ppdu_id =
> -			u32_get_bits(info[0], HAL_RX_PPDU_START_INFO0_PPDU_ID);
> -		ppdu_info->chan_num = __le32_to_cpu(ppdu_start->chan_num);
> -		ppdu_info->ppdu_ts = __le32_to_cpu(ppdu_start->ppdu_start_ts);
> +		ppdu_info->ppdu_id = u32_get_bits(info[0],
> +						  HAL_RX_PPDU_START_INFO0_PPDU_ID);
> +
> +		info[1] = __le32_to_cpu(ppdu_start->info1);
> +		ppdu_info->chan_num = u32_get_bits(info[1],
> +						   HAL_RX_PPDU_START_INFO1_CHAN_NUM);
> +		ppdu_info->freq = u32_get_bits(info[1],
> +					       HAL_RX_PPDU_START_INFO1_CHAN_FREQ);
> +		ppdu_info->ppdu_ts = ppdu_ts;
>  
>  		if (ppdu_info->ppdu_id != ppdu_info->last_ppdu_id) {
>  			ppdu_info->last_ppdu_id = ppdu_info->ppdu_id;
> diff --git a/drivers/net/wireless/ath/ath12k/hal_rx.h b/drivers/net/wireless/ath/ath12k/hal_rx.h
> index 837ba4adba88..6ab33d5f1b2a 100644
> --- a/drivers/net/wireless/ath/ath12k/hal_rx.h
> +++ b/drivers/net/wireless/ath/ath12k/hal_rx.h
> @@ -156,6 +156,7 @@ struct hal_rx_mon_ppdu_info {
>  	u32 preamble_type;
>  	u32 mpdu_len;
>  	u16 chan_num;
> +	u16 freq;
>  	u16 tcp_msdu_count;
>  	u16 tcp_ack_msdu_count;
>  	u16 udp_msdu_count;
> @@ -232,12 +233,16 @@ struct hal_rx_mon_ppdu_info {
>  	u8 medium_prot_type;
>  };
>  
> -#define HAL_RX_PPDU_START_INFO0_PPDU_ID		GENMASK(15, 0)
> +#define HAL_RX_PPDU_START_INFO0_PPDU_ID			GENMASK(15, 0)
> +#define HAL_RX_PPDU_START_INFO1_CHAN_NUM		GENMASK(15, 0)
> +#define HAL_RX_PPDU_START_INFO1_CHAN_FREQ		GENMASK(31, 16)
>  
>  struct hal_rx_ppdu_start {
>  	__le32 info0;
> -	__le32 chan_num;
> -	__le32 ppdu_start_ts;
> +	__le32 info1;
> +	__le32 ppdu_start_ts_31_0;
> +	__le32 ppdu_start_ts_63_32;
> +	__le32 rsvd[2];
>  } __packed;
>  
>  #define HAL_RX_PPDU_END_USER_STATS_INFO0_MPDU_CNT_FCS_ERR	GENMASK(26, 16)


