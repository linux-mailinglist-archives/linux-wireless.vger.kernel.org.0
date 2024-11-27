Return-Path: <linux-wireless+bounces-15754-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C4259DA5C3
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Nov 2024 11:30:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEC2D165C6A
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Nov 2024 10:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA9AE155389;
	Wed, 27 Nov 2024 10:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UP5geYxF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BDF1990BD;
	Wed, 27 Nov 2024 10:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732703433; cv=none; b=qpiEagVU7gmwr79uYo6XaiWZEEofPeQP3SDYbLorvRGV1TWRoud9j0233nIgw+Bbgq1sFVmlammMU4AvRDje+oAo84A21oob/5tFVHm7xk5AJ79VIYmV3lSXODhGWzFT80Jhb9BaTb7u37HQV26XIcxtQwScByCdaWKn+llb0ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732703433; c=relaxed/simple;
	bh=L1ISwpfiIXiP5zeO9y5IbY+euqSLxP6SkE0Y3RbKxnI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GDCEFyUDSrsD2r0aNhRC/U4YR1iSBSpxJWEksl8SiQDAvC/1Vy7daExkPVnY0FmnoyZqT+WiU1D2wism7dGpGQxvFJ1owrkQUQvmn9qUhhOLy/MXYRQQjnxMAawTSxRa8wehGL6VHDhl/AYThnEiu3wxkufZ18pB1U2lZwv2FK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UP5geYxF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AR93mMJ007146;
	Wed, 27 Nov 2024 10:30:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aqdcIm1htWFFascJevOmAsV6FIpg5ooOxh9zwCuY9LY=; b=UP5geYxFuWVC+4Ep
	MluKXWgZVcSE0d0TSgCS0gvynmOQec0mFhMjrUR8RfAW3++Cc3MtM0yPwAnLkaZs
	aMEiykU/VtSRKCkYcuW2wFdoulIL8yhlEPBnM1xTD4eGUkcaUiac+JTYpR2xxSTO
	eFVg8CYUpXODbZuRrf4Jrd1/c6NyGc8WR6Fu7E6y3g5/tt9rjjGQICyRZQkyVbiC
	Llpd0AtQojqh2f9SXGWu9UktDdSTo7ISVyLUEz+jEskQY0tztPJHMak7dct38Jok
	X8s2dTj0OoxgO17zXt/TCQOs4nL1NBAYQtEYHlr0wPFurY+bl3UqSTj7gzLrJ4iw
	eBQdAw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 434sw9ec76-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Nov 2024 10:30:25 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4ARAUOQQ013304
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Nov 2024 10:30:24 GMT
Received: from [10.253.78.253] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 27 Nov
 2024 02:30:18 -0800
Message-ID: <6f4037b4-8084-4e1d-b339-274e25f6d317@quicinc.com>
Date: Wed, 27 Nov 2024 18:30:15 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] wifi: ath11k: Fix NULL pointer check in
 ath11k_ce_rx_post_pipe()
To: Baichuan Qi <zghbqbc@gmail.com>, <markus.elfring@web.de>
CC: <ath11k@lists.infradead.org>, <jjohnson@kernel.org>, <kvalo@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-wireless@vger.kernel.org>
References: <a77fe99d-079b-4ef3-a1ce-6aea10256860@web.de>
 <20241127094317.303815-1-zghbqbc@gmail.com>
Content-Language: en-US
From: Kang Yang <quic_kangyang@quicinc.com>
In-Reply-To: <20241127094317.303815-1-zghbqbc@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 6CjFbIR4pvu_Y28EpLLVjOMYNRZreN9J
X-Proofpoint-ORIG-GUID: 6CjFbIR4pvu_Y28EpLLVjOMYNRZreN9J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=808 adultscore=0 spamscore=0 impostorscore=0
 priorityscore=1501 phishscore=0 clxscore=1011 mlxscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411270086



On 11/27/2024 5:43 PM, Baichuan Qi wrote:
> Fix the NON-NULL check by changing the OR (||) to AND (&&),
> ensuring that the function only proceeds when both `dest_ring`
> and `status_ring` are NON-NULL.
> 
> The current implementation of `ath11k_ce_rx_post_pipe` checks for
> NON-NULL of either `dest_ring` or `status_ring` using a
> logical OR (||). However, both rings, especially `dest_ring`,
> should be ensured to be NON-NULL in this function.
> If only one of the rings is valid, such as `dest_ring` is NULL
> and `status_ring` is NON-NULL, the subsequent call to
> `ath11k_ce_rx_buf_enqueue_pipe()` will access the NULL pointer,
> resulting in a driver crash.
> 
> Link: https://lore.kernel.org/ath11k/a9ccc947-20b2-4322-84e5-c96aaa604e63@web.de
> Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
> Signed-off-by: Baichuan Qi <zghbqbc@gmail.com>
> ---

So this is version 3, please remember adding you version change here🙂:

v3: add link URL.
v2: rewrite commit message, add fix tag.

---
https://www.kernel.org/doc/html/latest/process/submitting-patches.html#backtraces-in-commit-messages

>   drivers/net/wireless/ath/ath11k/ce.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/ce.c b/drivers/net/wireless/ath/ath11k/ce.c
> index e66e86bdec20..cc9ad014d800 100644
> --- a/drivers/net/wireless/ath/ath11k/ce.c
> +++ b/drivers/net/wireless/ath/ath11k/ce.c
> @@ -324,7 +324,7 @@ static int ath11k_ce_rx_post_pipe(struct ath11k_ce_pipe *pipe)
>   	dma_addr_t paddr;
>   	int ret = 0;
>   
> -	if (!(pipe->dest_ring || pipe->status_ring))
> +	if (!(pipe->dest_ring && pipe->status_ring))
>   		return 0;
>   
>   	spin_lock_bh(&ab->ce.ce_lock);


