Return-Path: <linux-wireless+bounces-13611-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD614993173
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2024 17:38:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8866C28517C
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2024 15:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 316FF1D8E09;
	Mon,  7 Oct 2024 15:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="E3Dz8ZT3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925401D8E1A
	for <linux-wireless@vger.kernel.org>; Mon,  7 Oct 2024 15:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728315479; cv=none; b=IcR56UymIHVDc1vhF7CNuIdQHPetcztMS8g6SyV7Nv1DszN6X4vL1uwHxfpTFo/+Hzh7GE+L8htrdLd8vTHu0JPlbQ2VtvJXaCGFORcLEHdt2CXWQXNxiINfMkKMk6kPKYZIYCA4lmjDBH3zoGg1YbRxGaTacr0eFceJWl6ElHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728315479; c=relaxed/simple;
	bh=+LOarsgGxDBryRCHTOQ0aAbgeP8VwkbunCr4M3Mbow0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=la3GnzJm6XT8qVxM5FOJSBcpcIjnveMgWUh2FoWti2hEow+hTDtdwozUavO//rl8ddUwZ8ajirBgvjQ6irs3TEbL+12/M/qMvSqTfBL2JKpTcOKpJoxLyTeWoKjzo7g4Y3Yu88Wnwa0+mgjvth1UTH4wDCbTN4c4xCJ9v3G6TE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=E3Dz8ZT3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 497EU5M5015709;
	Mon, 7 Oct 2024 15:37:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	R1Eplt5jSrHG+ETZBKvNMSfHB1rzYkLDGtLmplynIEc=; b=E3Dz8ZT38P8cgqI+
	H84l5j+qxxm05hSfw6NyYwc9t1kjM3D51UP+TFXr2GmdfBxM6IXKvx59tuVUEU7T
	6TW8PTpUiuSz3DOqo3Br2PQ1AOBbadtAKLTI2rpZE5c8Lgz9wFX7AExbmwkLvnAl
	M8sryHU5RfAGvSoETJbPf+2Js6vmFsLY0NKMiAzSjnVmvWgLCZW9GO+Bm4zJXImP
	KR4G2e9ZyzWaqYGNSppeDMgVij9MDB4cf5LV6jL6qJeyO3uxbeKasdCvhtLWu8Ie
	zvgB8A8d9UJyC9CL133khJAiCQzRWZel5hW48oy+2pthN40q+tREYSr9qjZepuzK
	3C+Udw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 422xs74ktr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Oct 2024 15:37:53 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 497Fbq38006139
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 7 Oct 2024 15:37:52 GMT
Received: from [10.48.240.101] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 7 Oct 2024
 08:37:52 -0700
Message-ID: <a6190d4e-aff9-48bc-b674-071656090c74@quicinc.com>
Date: Mon, 7 Oct 2024 08:37:51 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: ath12k: Support DMAC Reset Stats
To: Roopni Devanathan <quic_rdevanat@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Rajat Soni <quic_rajson@quicinc.com>
References: <20241005105207.3350790-1-quic_rdevanat@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <20241005105207.3350790-1-quic_rdevanat@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: uDdFa9LoDLjYkiiKp9j7A6fAOiYUI63z
X-Proofpoint-GUID: uDdFa9LoDLjYkiiKp9j7A6fAOiYUI63z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 suspectscore=0 priorityscore=1501 bulkscore=0 mlxlogscore=999
 clxscore=1015 malwarescore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410070110

On 10/5/2024 3:52 AM, Roopni Devanathan wrote:
> From: Rajat Soni <quic_rajson@quicinc.com>
> 
> Add support to request DMAC reset stats from firmware through HTT stats
> type 45. These stats give debug SoC error stats such as reset count, reset
> time, engage time and count, disengage time and count and destination
> ring mask.
> 
> Sample output:
> -------------
> echo 45 > /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats_type
> cat /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats
> HTT_DMAC_RESET_STATS_TLV:
> reset_count = 1
> reset_time_ms = 8036717648
> disengage_time_ms = 8036717648
> engage_time_ms = 8036717649
> disengage_count = 1
> engage_count = 1
> drain_dest_ring_mask = 0x0
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00214-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> 
> Signed-off-by: Rajat Soni <quic_rajson@quicinc.com>
> Signed-off-by: Roopni Devanathan <quic_rdevanat@quicinc.com>
> ---
> v2:
>  - Updated dependencies. No change in code.
> ---
> Depends-on:
> [PATCH v2] wifi: ath12k: Modify print_array_to_buf() to support arrays with 1-based semantics
> Link: https://lore.kernel.org/all/20241004085915.1788951-1-quic_rdevanat@quicinc.com/
> 
> [PATCH v2 0/4] wifi: ath12k: Support Ring, SFM, Transmit MU, SelfGen stats, CCA stats
> Link: https://lore.kernel.org/ath12k/20241005101816.3314728-1-quic_rdevanat@quicinc.com/
> 
> [PATCH v2] wifi: ath12k: Support Pdev OBSS Stats
> Link: https://lore.kernel.org/ath12k/20241005104206.3327143-1-quic_rdevanat@quicinc.com/
> ---
> ---
>  .../wireless/ath/ath12k/debugfs_htt_stats.c   | 41 +++++++++++++++++++
>  .../wireless/ath/ath12k/debugfs_htt_stats.h   | 15 +++++++
>  2 files changed, 56 insertions(+)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
> index d890679a3f16..2debb253185c 100644
> --- a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
> +++ b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
> @@ -2502,6 +2502,44 @@ ath12k_htt_print_pdev_obss_pd_stats_tlv(const void *tag_buf, u16 tag_len,
>  	stats_req->buf_len = len;
>  }
>  
> +static void
> +ath12k_htt_print_dmac_reset_stats_tlv(const void *tag_buf, u16 tag_len,
> +				      struct debug_htt_stats_req *stats_req)
> +{
> +	const struct ath12k_htt_dmac_reset_stats_tlv *htt_stats_buf = tag_buf;
> +	u8 *buf = stats_req->buf;
> +	u32 len = stats_req->buf_len;
> +	u32 buf_len = ATH12K_HTT_STATS_BUF_SIZE;
> +	unsigned long time;
> +
> +	if (tag_len < sizeof(*htt_stats_buf))
> +		return;
> +
> +	len += scnprintf(buf + len, buf_len - len, "HTT_DMAC_RESET_STATS_TLV:\n");
> +	len += scnprintf(buf + len, buf_len - len, "reset_count = %u\n",
> +			 le32_to_cpu(htt_stats_buf->reset_count));
> +	time = ((unsigned long)le32_to_cpu(htt_stats_buf->reset_time_hi_ms) << 32) |
> +		le32_to_cpu(htt_stats_buf->reset_time_lo_ms);

The v1 version was flagged by the Intel 0-DAY CI Kernel Test Service:
https://lore.kernel.org/all/202410040200.Mwb85JzQ-lkp@intel.com/

I believe you need to use u64 instead of unsigned long since unsigned long
will only be 32 bits on a 32-bit system. Also suggest you refactor into a
helper function to remove any ambiguity about the order of operations between
(typecast) and <<, i.e.:

/* untested */
static u64 ath12k_le32hilo_to_u64(__le32 hi, __le32 lo)
{
	u64 hi64 = le32_to_cpu(hi);
	u64 lo64 = le32_to_cpu(lo);

	return (hi64 << 32) | lo64;
}


