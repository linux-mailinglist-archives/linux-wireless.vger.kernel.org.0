Return-Path: <linux-wireless+bounces-15763-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 374E69DAAB5
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Nov 2024 16:23:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA43DB20C44
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Nov 2024 15:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACCCB1FF7C2;
	Wed, 27 Nov 2024 15:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lKN3ZFe/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2F61FF7C0;
	Wed, 27 Nov 2024 15:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732721004; cv=none; b=IOg7rb/R0u++qGN+nyr7NuyP9KvmymqxRPDetkm69rM+jhfTbg0utwTKtS84isgCkHeZ5hcV8jCyIslBSjSGLo7CisCl4TgAsda+LAlwOSUtakjdgGlMVvXbrPuxFysy/N40bwtbiwgWFP4MnnMaE7Meq8s2op/zqbpkSl+tBXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732721004; c=relaxed/simple;
	bh=NYhwksv5Pxsyvcsc4XKuWCWXnkZX3QeMCw80wDvn12w=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QWc6rLKqvjFVnkrv2XrV/PuDbxRbVM6ZqfQecUIgE/oX4cDrTMNjk1BEkoVRgP0AIEww6+IIpoKHZiQm4f01tLCf7m60bT9xMr2fwXun/qXCWJ62TSyYW7JaQapwyZcn4OcGuPOe7Ypn9Tjve+Yfudqnlz2lHA6ht/VKFwxrv4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=lKN3ZFe/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ARAgRUA018284;
	Wed, 27 Nov 2024 15:23:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SHYAX+xAbeW/GuhoTfgzvsc/2BcrL6l2T6Lxp5gCdD4=; b=lKN3ZFe/eg6DG5DI
	2+mKeRd93up7hbmsVhcnP1Wb6HNVPZKNYM87ygdg6Eab0JPfTY90dReEfS+AwUAs
	5gzRn4tnO3shxYsatcoK2Jr3kODo/5ZOgWNXwMMp1eF5mxFY/cZ9u7vndeIF+f0i
	AieDO708Xr1krHPCWy1wN/9R+nd3i/jNv9cdi3u0qbePB5iA7QUTWM1JZd+sjZmn
	M+4V40g366VX7RFhi7ttz45kYe+dBKus5sbY29PbNXW06ZkD8h1ERr8y+GPajS83
	/XKnPnzjyNzs+XybImuP5h0+ZGtI+L/uF6YqOZ0uNzsIG8wFBZ2XcziPTCzVIXC/
	xYnauw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4361wcgtdu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Nov 2024 15:23:15 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4ARFNEXs017002
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Nov 2024 15:23:14 GMT
Received: from [10.216.34.221] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 27 Nov
 2024 07:23:11 -0800
Message-ID: <f0077f4f-922d-56b1-a5b7-bb01e4462e87@quicinc.com>
Date: Wed, 27 Nov 2024 20:53:07 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v5] wifi: ath11k: Fix NULL pointer check in
 ath11k_ce_rx_post_pipe()
Content-Language: en-US
To: Baichuan Qi <zghbqbc@gmail.com>, <markus.elfring@web.de>
CC: <ath11k@lists.infradead.org>, <jjohnson@kernel.org>, <kvalo@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-wireless@vger.kernel.org>
References: <30b208e0-55a2-400f-9638-1765e7ed3bfa@web.de>
 <20241127143804.30075-1-zghbqbc@gmail.com>
From: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
In-Reply-To: <20241127143804.30075-1-zghbqbc@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ISkNkP16tpVYkKOeT4Yi-iLlLqHFkxZS
X-Proofpoint-ORIG-GUID: ISkNkP16tpVYkKOeT4Yi-iLlLqHFkxZS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 malwarescore=0 priorityscore=1501 clxscore=1011 mlxscore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411270122



On 11/27/2024 8:08 PM, Baichuan Qi wrote:
> Current implementation of `ath11k_ce_rx_post_pipe()` checks for
> NON-NULL of either `dest_ring` or `status_ring` using an OR (||).
> Both rings, especially `dest_ring`, should be ensured to be
> NON-NULL in this function.
> 
> If only one of the rings is valid, such as `dest_ring` is NULL
> and `status_ring` is NON-NULL, the OR (||) check would not stop
> `ath11k_ce_rx_post_pipe()`, the subsequent call to
> `ath11k_ce_rx_buf_enqueue_pipe()` will access the NULL pointer,
> resulting in a driver crash.
> 
> Fix the NON-NULL check by changing the OR (||) to AND (&&),
> and return an error code `-EIO` to indicate
> `ath11k_ce_rx_post_pipe()` is stopped with an NULL pointer
> error, ensuring that the function only proceeds when both
> `dest_ring` and `status_ring` are NON-NULL.
> 
> Link: https://lore.kernel.org/ath11k/a9ccc947-20b2-4322-84e5-c96aaa604e63@web.de
> Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")

This does not really fix any real issue. Please check ath11k_ce_alloc_pipe()
where initialization would fail if anyone of pipe->dest_ring and
pipe->status_ring allocation fails for ce pipe used for Rx.

> Signed-off-by: Baichuan Qi <zghbqbc@gmail.com>
> ---
> V4 -> V5: add err code in NULL check
> V3 -> V4: reorder describe info
> V2 -> V3: add Link URL to mailing list archives
> V1 -> V2: rewrite commit message and fix tag
> 
>   drivers/net/wireless/ath/ath11k/ce.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/ce.c b/drivers/net/wireless/ath/ath11k/ce.c
> index e66e86bdec20..223dab928453 100644
> --- a/drivers/net/wireless/ath/ath11k/ce.c
> +++ b/drivers/net/wireless/ath/ath11k/ce.c
> @@ -324,8 +324,10 @@ static int ath11k_ce_rx_post_pipe(struct ath11k_ce_pipe *pipe)
>   	dma_addr_t paddr;
>   	int ret = 0;
>   
> -	if (!(pipe->dest_ring || pipe->status_ring))
> -		return 0;
> +	if (!(pipe->dest_ring && pipe->status_ring)) {
> +		ret = -EIO;
> +		return ret;
> +	}

This will always fail as the caller loops through all the supported ce pipes
and ce pipes used for Tx will not have either dest_ring or status_ring.
Please ensure the patch is tested properly.

So NAK

Vasanth

