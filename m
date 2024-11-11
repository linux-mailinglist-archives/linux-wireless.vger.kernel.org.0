Return-Path: <linux-wireless+bounces-15184-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52FBC9C4268
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Nov 2024 17:11:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED0CFB2678A
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Nov 2024 16:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85680189BBB;
	Mon, 11 Nov 2024 16:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="a2H+AZB5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9992143C63;
	Mon, 11 Nov 2024 16:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731341505; cv=none; b=UUV+X1BTg0BkGY4G7MI/5o/MAjT+PSfIZJ23DP8zErmGMtuSgKeJ+LL/V4y5f9d5+QnbSI3CM8/hp3p5TWGJ+jfitwUEmOOzY9JUVzzSoP400f/48JXgEIqqdmA1EgEbbP4ZZWTpwqJwdsMmFLdKCk/dGMNGDZkcYSySnUyzTHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731341505; c=relaxed/simple;
	bh=Izar/xqYbmfSHHP4FPBq+UdT55uwIfzcFr+NPQ45RO8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=n87k+t/MbTNXBufVByjSgD+lo5e3XjxiE+oWoMNQzO4JiavLAm6nHd8Gh7Ibp39fzAE/9zzQX3T93Kegiwmp5x3RXNDJNjzoXXorZWjxTT/GP05W+JNHyi9Iw8nMeHfsMYC3qxNAzV7qDMGPxMQwtWaaWLz5LsG8z/96og4ZA/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=a2H+AZB5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ABCqpVY018012;
	Mon, 11 Nov 2024 16:11:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	w2sWgc0ovsFV9iei6VjhRgC907cKGYyYnD2bWlocphI=; b=a2H+AZB5gvPb1CY8
	iwZbMk6lofaFP632BEmDMoycRwIk/b67qDmKjSqUS5Xzy+lU8gITGFN/+Gexr+dF
	vFtBrHfbyOJbXrn0xR5KIb8ZCbcG9AjrpRYBqBiQMsTm/grNA5fgaU2iBe5iS6Rv
	UbSDJzQbA/8CnLgnntuPCXCHfnQ5i52WPbd1CqkF79ja+Ys3M3Elt6PNQJ5bKyTf
	Y2ieBUY1nNJrI5WiVSfrwL9pzYUQ+ytObJxlv3FS15l83ZpjJoazV69Wm0ukUjsq
	z7DVdGAPz0VWIpeRpV3zbU6feqDFIBeEq1wglOYq1kFy9MDhY0eaCi88GgJD9UgO
	bsmcwQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42syax4qxm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Nov 2024 16:11:14 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4ABGBDHO024896
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Nov 2024 16:11:13 GMT
Received: from [10.48.243.207] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 11 Nov
 2024 08:11:12 -0800
Message-ID: <b6f60714-070c-412d-8e39-35f705d91791@quicinc.com>
Date: Mon, 11 Nov 2024 08:11:11 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] wifi: ath12k: Fix for out-of bound access error
To: Karol Przybylski <karprzy7@gmail.com>, <kvalo@kernel.org>,
        <jjohnson@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <ath12k@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <skhan@linuxfoundation.org>
References: <20241105101132.374372-1-karprzy7@gmail.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <20241105101132.374372-1-karprzy7@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 2KiSqoQTF_rrKtzvxdr2GCQvbNz-MMNY
X-Proofpoint-GUID: 2KiSqoQTF_rrKtzvxdr2GCQvbNz-MMNY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0 mlxlogscore=999
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411110132

On 11/5/2024 2:11 AM, Karol Przybylski wrote:
> Selfgen stats are placed in a buffer using print_array_to_buf_index() function.
> Array length parameter passed to the function is too big, resulting in possible
> out-of bound memory error.
> Decreasing buffer size by one fixes faulty upper bound of passed array.
> 
> Discovered in coverity scan, CID 1600742 and CID 1600758
> 
> Signed-off-by: Karol Przybylski <karprzy7@gmail.com>
> ---
> Changes in v3:
> - Code style: added spaces before and after '-'
> - Improved commit msg
> - Fixed same error in different function
> - Link to previous discussion: https://lore.kernel.org/all/08767ff7-f764-473d-a44b-c3c3b1695008@quicinc.com/
> ---
>  drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
> index 799b865b89e5..2d47aca681f4 100644
> --- a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
> +++ b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
> @@ -1562,7 +1562,7 @@ ath12k_htt_print_tx_selfgen_ac_stats_tlv(const void *tag_buf, u16 tag_len,
>  			 le32_to_cpu(htt_stats_buf->ac_mu_mimo_ndp));
>  	len += print_array_to_buf_index(buf, len, "ac_mu_mimo_brpollX_tried = ", 1,
>  					htt_stats_buf->ac_mu_mimo_brpoll,
> -					ATH12K_HTT_TX_NUM_AC_MUMIMO_USER_STATS, "\n\n");
> +					ATH12K_HTT_TX_NUM_AC_MUMIMO_USER_STATS - 1, "\n\n");

Our ath12k-check tool reports:
drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c:1565: line length of 92
exceeds 90 columns

I'll fix this in the 'pending' branch

>  
>  	stats_req->buf_len = len;
>  }
> @@ -1590,7 +1590,7 @@ ath12k_htt_print_tx_selfgen_ax_stats_tlv(const void *tag_buf, u16 tag_len,
>  			 le32_to_cpu(htt_stats_buf->ax_mu_mimo_ndp));
>  	len += print_array_to_buf_index(buf, len, "ax_mu_mimo_brpollX_tried = ", 1,
>  					htt_stats_buf->ax_mu_mimo_brpoll,
> -					ATH12K_HTT_TX_NUM_AX_MUMIMO_USER_STATS, "\n");
> +					ATH12K_HTT_TX_NUM_AX_MUMIMO_USER_STATS - 1, "\n");
>  	len += scnprintf(buf + len, buf_len - len, "ax_basic_trigger = %u\n",
>  			 le32_to_cpu(htt_stats_buf->ax_basic_trigger));
>  	len += scnprintf(buf + len, buf_len - len, "ax_ulmumimo_total_trigger = %u\n",



