Return-Path: <linux-wireless+bounces-14282-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0CB29A9474
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Oct 2024 02:03:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEA421C2146F
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Oct 2024 00:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE827647;
	Tue, 22 Oct 2024 00:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="M2jKoMSk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14393360;
	Tue, 22 Oct 2024 00:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729555433; cv=none; b=n0krr0AwB3ZB65QNf5OhlGqu2NyzXW+FNWfqvdzYpMH/z8gFdZ3B7G4/niYo0v1vQ0GQhnj96aMRETwoa7cm1m9NWWk9mRhwxHI6O4rJ5etzo0ADm/vug1zplDuBF5NwMPpBQZIVDgmjc62SrGksMqps63kBIaGF7WSo3t/vHvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729555433; c=relaxed/simple;
	bh=la6+mSD3E4cWykUp+bMo0m61VOjKIcAEjePnOyL/d7c=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=BJZmWZvXwpk9h+hcmm/Tzo2IX/o1FiJE201AYMn+tzce6U2Q58Fqiw3vx0KdNBWJsreypzgq/sC9C73pNkVJPIue8Uoe98U4ZnP8AfMozx6JM7oPxBVWb3nzc5tZmaKgwGeLeOp30CiYdpDTW0UT1bNNBhNsIWv8JdV6iMCexI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=M2jKoMSk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49LNGOBC019303;
	Tue, 22 Oct 2024 00:03:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6WM7Ott1G6v7WRCxJzN5NLSNfN64lKptPUJSvoYiAnY=; b=M2jKoMSkxeNVv/Tx
	cTLDFq9+lIsQjTGy3+3mO6ajMQmNHRaRroS6nG+O3iTe6uh/BWyk2qO2FT9G1+gm
	oAlFHMj5j3frWYjbX1Vierj7dyTLK4cwWoSizJmnBFxWWkga0zU3j8lOdLOzHD2W
	jq2qmxhXKhOUlW9aReqRiQtB/mNGqNujdAaPiRrX1Jvg71y7R3WaRg/zFWteq8L2
	TXcLHaYhPfvC7DVESaXZf3FBVf3NQm+TBFq4LZe0l7ihOBGFNIRKIQkZLkLuM1k7
	QRqQLK+cl3v+dFB6r+2b7YS8KpOQHIDrxm0ceJvVI4r18W/hGrGWeHZU6OGT7+hn
	9SHMzA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42c6tsp987-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Oct 2024 00:03:42 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49M03fm1018799
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Oct 2024 00:03:41 GMT
Received: from [10.48.242.6] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 21 Oct
 2024 17:03:40 -0700
Message-ID: <08767ff7-f764-473d-a44b-c3c3b1695008@quicinc.com>
Date: Mon, 21 Oct 2024 17:03:40 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: ath12k: Fix for out-of bound access error
To: Karol Przybylski <karprzy7@gmail.com>, <kvalo@kernel.org>,
        <jjohnson@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <ath12k@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <skhan@linuxfoundation.org>
References: <20241021204814.728090-1-karprzy7@gmail.com>
Content-Language: en-US
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20241021204814.728090-1-karprzy7@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: t92Cu2D_BIIKJ-HhCGNFxRK1kDKhwOGQ
X-Proofpoint-ORIG-GUID: t92Cu2D_BIIKJ-HhCGNFxRK1kDKhwOGQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 spamscore=0 mlxlogscore=719 phishscore=0 adultscore=0
 mlxscore=0 clxscore=1011 bulkscore=0 malwarescore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410210168

On 10/21/2024 1:48 PM, Karol Przybylski wrote:
> Size of array passed to print_array_to_buf_index is decremented by 1

This is not a clear commit message.
Please follow the order normally used in the kernel:
1) describe the current code
2) describe the problem with the current code
3) describe how to fix the code (in imperative voice)

> 
> Discovered in coverity scan, CID 1600742
> ---
> Changes in v2:
> - Code style: added spaces before and after '-'
> - Link to v1: https://lore.kernel.org/all/8734kpq0wo.fsf@kernel.org/
> ---
> 
> Signed-off-by: Karol Przybylski <karprzy7@gmail.com>

SOB needs to be before the first "---"

> ---
>  drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
> index 799b865b89e5..8371df570c42 100644
> --- a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
> +++ b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
> @@ -1590,7 +1590,7 @@ ath12k_htt_print_tx_selfgen_ax_stats_tlv(const void *tag_buf, u16 tag_len,
>  			 le32_to_cpu(htt_stats_buf->ax_mu_mimo_ndp));
>  	len += print_array_to_buf_index(buf, len, "ax_mu_mimo_brpollX_tried = ", 1,
>  					htt_stats_buf->ax_mu_mimo_brpoll,
> -					ATH12K_HTT_TX_NUM_AX_MUMIMO_USER_STATS, "\n");
> +					ATH12K_HTT_TX_NUM_AX_MUMIMO_USER_STATS - 1, "\n");
>  	len += scnprintf(buf + len, buf_len - len, "ax_basic_trigger = %u\n",
>  			 le32_to_cpu(htt_stats_buf->ax_basic_trigger));
>  	len += scnprintf(buf + len, buf_len - len, "ax_ulmumimo_total_trigger = %u\n",

Aren't there more than this one? This also looks suspect:

	len += print_array_to_buf_index(buf, len, "ac_mu_mimo_brpollX_tried = ", 1,
					htt_stats_buf->ac_mu_mimo_brpoll,
					ATH12K_HTT_TX_NUM_AC_MUMIMO_USER_STATS, "\n\n");




