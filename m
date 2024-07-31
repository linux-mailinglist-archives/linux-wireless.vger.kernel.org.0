Return-Path: <linux-wireless+bounces-10762-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F583943518
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jul 2024 19:42:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03EB51F22537
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jul 2024 17:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B362BAFC;
	Wed, 31 Jul 2024 17:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Qnt2RbZ5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66F02940D
	for <linux-wireless@vger.kernel.org>; Wed, 31 Jul 2024 17:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722447769; cv=none; b=mfuHPW8tQoL1WgdC2jN17i6jmhDHHUAiY+M6TtD8wGAroheXHzAXNUCWCbvY+CoVnPIpWpzdqVxfZEFFcFCz0Ee1HIOPUbp7o11OERsmcBfKo5j4bNqW8XU5I1FUr3C01IQYSrzMKss+CyKOlEuQmjfZGtX64eoYry/Xv2ZEea4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722447769; c=relaxed/simple;
	bh=O/FdxfvY6B/s/CyDBsrobxzyC8vgBm93rXS3g+UXraY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QpnH4g4DMSIuvPZGLMxmNDafUHZHnS8eP6RNU4nCGhEH+yaemdN6N5Psyklc9JhyrnWnvz2bBu0xdjAfQW7r0Fd1vv6/c9k6tycqFNgMvnFDu0Zb5h678bPlj5alvVv2JrhGuGDX8pVM3ZPIxin7oBRWjgaDgLlK4SivCydOd80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Qnt2RbZ5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46VGuq6o029956;
	Wed, 31 Jul 2024 17:42:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HKYj1Vo3t4XJmzCKEDfy/TnSk+QVSotG6sA0LSp/Zv0=; b=Qnt2RbZ5xGWBb0W/
	Uf4gkKTUQzS+25ShDtUPMeWgpdu2KBUuiHoSofc7KD3PvxD0kba74baiHpfj7ZSa
	5Td+e5YruHJHSZC02V+V5Ff5KDmXxUCswFSrheUiaZ5KERVVztADLMeh357c4u4v
	JkkrTZcb5V0PG/F7OdbsoPKcJidpb2IAzSp2Dj3bSEy/x9aw8ujir0G+rHpvgwVa
	TW8ZjwTj05kaV8f68a3SwtApOtGaDLKgnlfnyHg+kV1Ug7fa/lnANV12eSinSmTA
	42G5rCfxLD1RdLH+Ka3kMN/0MhzEPsmxa3/H1J+j8rMJTuJbbb/+d8cwVPnpvPdT
	Ide9Nw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40pq5268ha-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jul 2024 17:42:39 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46VHgc8d015638
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jul 2024 17:42:38 GMT
Received: from [10.111.177.34] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 31 Jul
 2024 10:42:38 -0700
Message-ID: <37472d36-1649-411f-afbe-ce3c176b4db8@quicinc.com>
Date: Wed, 31 Jul 2024 10:42:37 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/3] wifi: ath12k: report station mode transmit rate
Content-Language: en-US
To: Lingbo Kong <quic_lingbok@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240731113645.54738-1-quic_lingbok@quicinc.com>
 <20240731113645.54738-2-quic_lingbok@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240731113645.54738-2-quic_lingbok@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Z6urOeq5TNJftNgAmTFtI0Ia1dr0aDLJ
X-Proofpoint-ORIG-GUID: Z6urOeq5TNJftNgAmTFtI0Ia1dr0aDLJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-31_10,2024-07-31_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 adultscore=0 priorityscore=1501 spamscore=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407310123

On 7/31/2024 4:36 AM, Lingbo Kong wrote:
...
> +static void ath12k_dp_tx_update_txcompl(struct ath12k *ar, struct hal_tx_status *ts)
> +{
...
> +
> +	if (ts->pkt_type == HAL_TX_RATE_STATS_PKT_TYPE_11A ||
> +	    ts->pkt_type == HAL_TX_RATE_STATS_PKT_TYPE_11B) {

I think this if else if else if else if would this be clearer as:

	switch (ts->pkt_type) {
	case HAL_TX_RATE_STATS_PKT_TYPE_11A:
	case HAL_TX_RATE_STATS_PKT_TYPE_11B:
		...
		break;
	case HAL_TX_RATE_STATS_PKT_TYPE_11N:
		...
		break;

...

> @@ -610,10 +723,23 @@ static void ath12k_dp_tx_status_parse(struct ath12k_base *ab,
>  
>  	ts->ppdu_id = le32_get_bits(desc->info1,
>  				    HAL_WBM_COMPL_TX_INFO1_TQM_STATUS_NUMBER);
> -	if (le32_to_cpu(desc->rate_stats.info0) & HAL_TX_RATE_STATS_INFO0_VALID)
> -		ts->rate_stats = le32_to_cpu(desc->rate_stats.info0);
> -	else
> -		ts->rate_stats = 0;
> +
> +	ts->peer_id = le32_get_bits(desc->info3, HAL_WBM_COMPL_TX_INFO3_PEER_ID);
> +
> +	if (le32_to_cpu(desc->rate_stats.info0) & HAL_TX_RATE_STATS_INFO0_VALID) {

since you are extracting multiple fields from info0, suggest you have a local
u32 info0 = le32_to_cpu(desc->rate_stats.info0) and then use u32_get_bits()
everywhere. note this will have no impact on LE systems but would potentially
be better for BE systems.

> +		ts->pkt_type = le32_get_bits(desc->rate_stats.info0,
> +					     HAL_TX_RATE_STATS_INFO0_PKT_TYPE);
> +		ts->mcs = le32_get_bits(desc->rate_stats.info0,
> +					HAL_TX_RATE_STATS_INFO0_MCS);
> +		ts->sgi = le32_get_bits(desc->rate_stats.info0,
> +					HAL_TX_RATE_STATS_INFO0_SGI);
> +		ts->bw = le32_get_bits(desc->rate_stats.info0,
> +				       HAL_TX_RATE_STATS_INFO0_BW);
> +		ts->tones = le32_get_bits(desc->rate_stats.info0,
> +					  HAL_TX_RATE_STATS_INFO0_TONES_IN_RU);
> +		ts->ofdma = le32_get_bits(desc->rate_stats.info0,
> +					  HAL_TX_RATE_STATS_INFO0_OFDMA_TX);
> +	}
>  }

/jeff



