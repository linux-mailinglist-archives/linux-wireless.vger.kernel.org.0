Return-Path: <linux-wireless+bounces-8629-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A48D98FF2BF
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Jun 2024 18:42:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABCF31C25C01
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Jun 2024 16:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45128198A17;
	Thu,  6 Jun 2024 16:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="MdDcT7Sx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2661CAA9
	for <linux-wireless@vger.kernel.org>; Thu,  6 Jun 2024 16:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717692142; cv=none; b=M/jk315MFXHCDZkJINM4eNtcM/ZOCAgHKy2S6ccFK9Aig8HOBm/L4yaIbSnpdmXFHB427PonNx9PYJylB15mVHymh51r6LgQByoD0aOEScNDJiGxhi2asRshp9yT0TNq5aioMzOHq2phpeXgy/layFEacNa+Q1mZsIWIf1OU2nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717692142; c=relaxed/simple;
	bh=hdlRCj7WLV0vb3EqoXN6nTD6A5FmtTvu0oDghIB1nYY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=L2M2VdcNvbSeThmCXrJveEGR4jRHodL/FDtI0Tdq9fiUZWVDH4tqaaYyBJW5OSTYJvEu3A+ypHIIu5Su1/a3xsNuxAYkGY5GG+U5SCLf8oBKMUZN/4Awh0l+m10X2clNuX23qqccy92qimXKxJPi9LnjdDgZkuKG8roB04k67yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=MdDcT7Sx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 456DGnxs009744;
	Thu, 6 Jun 2024 16:42:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2AGY6O6/mL9mrzOqTaKewzUoQejLvRJLBcsERTFTe4Y=; b=MdDcT7SxdB1++qch
	FapCv2AwHp0lNTQq5Sk7YgX/V2mXnp2O1iHfw8cBlLpRLGV7w9IQIzcwZ++Axwzg
	VQ/bF+VAEfQDGQBcP41wcGJEf9cBKafeGw8L92XhD6OF2fsCklnPJ+Lbd+J2cXn8
	ozOyU4sVlRb3ywR5h9LSbMzDVJzm7m7coRLJSmCVLupIrMul65JDEGh+1HjGv1nT
	bzjrXt3yUkFtHMs33m0KtcYncicPFPwaM6gvgL1xrV2cpijeo/erxFededsJukaI
	1V4po2x5k6JjoopCEMQo71kwS6hqnTr+fUz5co8FbanCyLkxkF6jILgMtsEwt+A9
	IB4bhA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yj87rndua-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Jun 2024 16:42:16 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 456GgFFj014667
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 6 Jun 2024 16:42:15 GMT
Received: from [10.48.241.109] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 6 Jun 2024
 09:42:14 -0700
Message-ID: <7c7ea029-6ef9-4e7b-ac45-bdf341a8256a@quicinc.com>
Date: Thu, 6 Jun 2024 09:42:07 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/5] wifi: ath12k: Add support to parse requested
 stats_type
Content-Language: en-US
To: Ramya Gnanasekar <quic_rgnanase@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Dinesh Karthikeyan
	<quic_dinek@quicinc.com>
References: <20240603044214.960261-1-quic_rgnanase@quicinc.com>
 <20240603044214.960261-5-quic_rgnanase@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240603044214.960261-5-quic_rgnanase@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: I7hwCe8mQO6u65CXcFvCHTO3b2KR5Oja
X-Proofpoint-ORIG-GUID: I7hwCe8mQO6u65CXcFvCHTO3b2KR5Oja
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-06_13,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 phishscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 spamscore=0 mlxlogscore=999 adultscore=0 lowpriorityscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406060119

On 6/2/2024 9:42 PM, Ramya Gnanasekar wrote:
> From: Dinesh Karthikeyan <quic_dinek@quicinc.com>
> 
> Add extended htt stats parser and print the corresponding TLVs associated
> with the requested htt_stats_type.
> Add support for TX PDEV related htt stats.
> 

while reviewing some other patches in the internal pipeline I discovered I had
overlooked some things in this series, so pointing them out now...

> ---
>  .../wireless/ath/ath12k/debugfs_htt_stats.c   | 315 ++++++++++++++++++
>  .../wireless/ath/ath12k/debugfs_htt_stats.h   | 211 ++++++++++++
>  drivers/net/wireless/ath/ath12k/dp_rx.c       |  10 +-
>  drivers/net/wireless/ath/ath12k/dp_rx.h       |   4 +
>  4 files changed, 536 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
> index d98b971cde7d..e0a0acd5eec8 100644
> --- a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
> +++ b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
> @@ -9,6 +9,321 @@
>  #include "debug.h"
>  #include "debugfs_htt_stats.h"
>  #include "dp_tx.h"
> +#include "dp_rx.h"
> +
> +static u32
> +print_array_to_buf(u8 *buf, u32 offset, const char *header,
> +		   const __le32 *array, u32 array_len)
> +{
> +	int index = 0;
> +	u8 i;
> +
> +	if (header) {
> +		index += scnprintf(buf + offset,
> +				   ATH12K_HTT_STATS_BUF_SIZE - offset,
> +				   "%s = ", header);
> +	}
> +	for (i = 0; i < array_len; i++) {
> +		index += scnprintf(buf + offset + index,
> +				   (ATH12K_HTT_STATS_BUF_SIZE - offset) - index,
> +				   " %u:%u,", i, le32_to_cpu(array[i]));
> +	}

note that this will end up with a trailing comma, so suggest you add:

	/* have the next print overwrite the last trailing comma */
	index--;

> +	index += scnprintf(buf + offset + index,
> +			   (ATH12K_HTT_STATS_BUF_SIZE - offset) - index,
> +			   "\n\n");
> +	return index;
> +}
> +
> +static void
> +htt_print_tx_pdev_stats_cmn_tlv(const void *tag_buf, u16 tag_len,
> +				struct debug_htt_stats_req *stats_req)
> +{
> +	const struct ath12k_htt_tx_pdev_stats_cmn_tlv *htt_stats_buf = tag_buf;
> +	u8 *buf = stats_req->buf;
> +	u32 len = stats_req->buf_len;
> +	u32 buf_len = ATH12K_HTT_STATS_BUF_SIZE;
> +	u32 mac_id_word = le32_to_cpu(htt_stats_buf->mac_id__word);

this dereference has to occur after the length check, otherwise you may have a
buffer overread

> +
> +	if (tag_len < sizeof(struct ath12k_htt_tx_pdev_stats_cmn_tlv))

sizeof(*htt_stats_buf) is preferred

> +		return;
> +

that concludes my new comments



