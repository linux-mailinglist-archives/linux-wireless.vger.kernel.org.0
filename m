Return-Path: <linux-wireless+bounces-27545-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77417B8CFD3
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Sep 2025 21:46:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 313FD1662B8
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Sep 2025 19:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34C00239E8B;
	Sat, 20 Sep 2025 19:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ENwRgwZd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDD5232395
	for <linux-wireless@vger.kernel.org>; Sat, 20 Sep 2025 19:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758397594; cv=none; b=DYIImHeFOJosS2bNZoBU5e/wZhy/qUVZoU1IxKwEkEDfYGaJ9Jje6niubCC8wwcDKWfGJekAbT6rpz3cM34iMj0ORzL9MQxjaK8TsXnfR2cZgDvUczADTA/o3skYgpCN6833P5xL40bTZmAZkXX0EPrWh9Sn14dOR/s76lWK3ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758397594; c=relaxed/simple;
	bh=ndgvGXDsJYPWF7e0gIdBC2EOWhUHn+ouXj800VEB26o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sxtn+3nN6QhgxrIeM6+6r8rDAwEICpYowlEyS/dOwlv3cmeyhnRcZ2Mr7vf5lJqVV4bbJBq9+66eQQiK6ufBmOZrVqXZVCyXrcvStEIs8Rlsgl1kV4KGtSNvdbKDvGZ4yDHzx/wvSHV+FsIcIYH5LwsoOqR8D/B8scB26A7hRfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ENwRgwZd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58KHNX3D006790
	for <linux-wireless@vger.kernel.org>; Sat, 20 Sep 2025 19:46:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	K+Qp/m/JETzGQ8dHPwi3BdlfjnS6iTU4HRNyDuWKnz4=; b=ENwRgwZdVNZNXdFz
	ycybmKp/HWNa09Y8W85rnMeNQF1QfEJSagB7xuAiqsmb7M4+gJJgq8Li5QjERHbQ
	2bNlFk/vV2IXKMkZqeIykuConwsiqg9jPXe81idovS/Gyf0U1urF+ouQJi7QzXpo
	fn6u4/exrz0jmadYAWVZE06denu/4DvrBp9ovHn28rhj3MQ9E4L07+olDkL7a/g9
	pvFy2+G/yu4JmTGQV99eXiTUZBAsy5d3o+E8ZBaQu2tFnPCLL9kPgcLBhSeFXboH
	U1USMsRh5SemE1L6RXEa679D9ijq4LonbylYMlCEdIFLT8xJlKFleZUUqcjBGQC3
	7+W7IQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499mn796yu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Sat, 20 Sep 2025 19:46:30 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-77ecac44d33so1315932b3a.1
        for <linux-wireless@vger.kernel.org>; Sat, 20 Sep 2025 12:46:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758397589; x=1759002389;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K+Qp/m/JETzGQ8dHPwi3BdlfjnS6iTU4HRNyDuWKnz4=;
        b=K66NzHznf3UjQmGvOyBiVD57Q3ME6RuzywWCzMiWD/wPb3mo3z0aGX21+U7Iz3qDai
         Bb9LN6Wos4Tn8QeOSGI/vBu6vBvqLAF2bXzjEnN7dyZ6vuHwJKxSgvXKBcLY+aSwMzZy
         ZE88O0NLT6We6o670CIpSnGWJyo5/QIqs7NkTD5xSMmQv86dEiapr/IuwN7S5YBSJzvK
         Nq4bJYZuq+2E+iJSL5NYlRgJAneadM9o1HPn+ATsJ+kSVr+0+PzPsBQwn8kSSzcsq4iF
         mQ5xsXKEjW1wb11p7jCM+qD7Ekyewba9ZDQEimk9LnVHAT25Xw21uJJMn/jxS1tVZjKw
         eh4Q==
X-Gm-Message-State: AOJu0YxP0QF9527s+BfWdbEA2gxK8OBNTpwCs25AhgFetYsbc9tG7Dtq
	dOeRnH0EupWQ4+zrjO1Ve2ck9HSxCIxIiAulR/ie8tlKzCeyzCJitIsBqKjCtwqYO+1DcYXhEZA
	MxdCd9ylQcIU2rK77QJdvFxF/nDz7t5z+sR8dZmcpSSSzTBVzoyq0wxCg96eKw7dFQsHOnQ==
X-Gm-Gg: ASbGncs1L9StzouBeLsen4ZTbojCHkVWyToSzC2HZxOAOfUvtSCThW/WSHJTiwgJuib
	vBetlCInfwgSK8ujqdCEPAZ1HvTyx3A8OG9Rp1GEZoH9rfO6CsTlrzNQnp/N5GjVTMUveZ8A82s
	FWY4AxKqMgg9EjUTIErc1tqADHNnsAiBG3kqiKjrJdoz3LziENUSoYG5jOrtnr+yJMkQ9ym56OI
	04DTfPkpT+sfOZHkKYxzS/saH5pNHWZJZ7miduQwvht9+eVdKQSfKpy06c1h3LMuKFdzPQcofJa
	Rea0Oc/8r1wnH3msuM7drtulFXxzoqsAqy9W5xqnvjKU791TBMek6+dJE0R93ucD694Qn+sd+bw
	yLQ7OXX3CiFjU5uE=
X-Received: by 2002:a05:6a00:2da7:b0:77f:2140:9685 with SMTP id d2e1a72fcca58-77f21409b33mr2283275b3a.9.1758397588953;
        Sat, 20 Sep 2025 12:46:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHaTOg4LtoZXY/Rm551CcEocJGCIjjbXNI6cEnN1T2SzpyZ0nXKyTQ4XSOIscy4c9q0a0PYBg==
X-Received: by 2002:a05:6a00:2da7:b0:77f:2140:9685 with SMTP id d2e1a72fcca58-77f21409b33mr2283259b3a.9.1758397588510;
        Sat, 20 Sep 2025 12:46:28 -0700 (PDT)
Received: from [192.168.225.142] ([157.49.98.153])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77cfbb79c05sm8457047b3a.4.2025.09.20.12.46.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Sep 2025 12:46:28 -0700 (PDT)
Message-ID: <9ed7f62c-2035-6ab2-3ed7-3796018da1ac@oss.qualcomm.com>
Date: Sun, 21 Sep 2025 01:16:24 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH ath-current 0/7] wifi: ath12k: Fix Issues in REO RX Queue
 Updates
To: Nithyanantham Paramasivam <nithyanantham.paramasivam@oss.qualcomm.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250806111750.3214584-1-nithyanantham.paramasivam@oss.qualcomm.com>
Content-Language: en-US
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250806111750.3214584-1-nithyanantham.paramasivam@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAzMyBTYWx0ZWRfX1Jym3JRUIlNN
 rr+kK0ycbIJnVc9Kxxdapt7HAsN/PSHDsFvHX08AWxEWarGJwc2zs3nWlugosnjjq2+8x/GsLLT
 Swk6W7yZbzV4uHfcj0K/1UaAIenmL6RrMOa+nJ5ix23ceYwKvVK8s3wFcuwzZt9rZhjoxxMNF2L
 EWLBR4Ykk1270O3QFCGxTRDfSo+e3H4WhZqlhNLue5cXOyQ8aEwjgZcFRDraI3RPzNpFLYZLlUi
 njIQEjwJQ6FZWULD5r3XPpEX1GQAqmvBYNu038d/7ReZZXBVNzsoTYT09qyz+wySlV8WE+0bjHW
 GxuBnr5F5LYFNWA8A79091lPOXrSLxMMAg+1mvZmUF2GaU7cgqCPjIxyq03Cy8xyW3D2liVlaTm
 1pu4cTse
X-Proofpoint-GUID: fgUhQXLTRW0XPJZtkz-8BITQKmX6A7ru
X-Proofpoint-ORIG-GUID: fgUhQXLTRW0XPJZtkz-8BITQKmX6A7ru
X-Authority-Analysis: v=2.4 cv=EZrIQOmC c=1 sm=1 tr=0 ts=68cf0496 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=D2/kxzoxEJci86hTnT1oBw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=xzmuE1EisdE_tCyGCEEA:9
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-20_07,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 phishscore=0 suspectscore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 spamscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509200033



On 8/6/2025 4:47 PM, Nithyanantham Paramasivam wrote:
> During stress test scenarios, when the REO command ring becomes full,
> the RX queue update command issued during peer deletion fails due to
> insufficient space. In response, the host performs a dma_unmap and
> frees the associated memory. However, the hardware still retains a
> reference to the same memory address. If the kernel later reallocates
> this address, unaware that the hardware is still using it, it can
> lead to memory corruption-since the host might access or modify
> memory that is still actively referenced by the hardware.
> 
> Implement a retry mechanism for the HAL_REO_CMD_UPDATE_RX_QUEUE
> command during TID deletion to prevent memory corruption. Introduce
> a new list, reo_cmd_update_rx_queue_list, in the dp structure to
> track pending RX queue updates. Protect this list with
> reo_rxq_flush_lock, which also ensures synchronized access to
> reo_cmd_cache_flush_list. Defer memory release until hardware
> confirms the virtual address is no longer in use, avoiding immediate
> deallocation on command failure. Release memory for pending RX queue
> updates via ath12k_dp_rx_reo_cmd_list_cleanup() on system reset
> if hardware confirmation is not received.
> 
> Additionally, increase DP_REO_CMD_RING_SIZE to 256 to reduce the
> likelihood of ring exhaustion. Use a 1KB cache flush command for
> QoS TID descriptors to improve efficiency.
> 
> Manish Dharanenthiran (2):
>    wifi: ath12k: Add Retry Mechanism for REO RX Queue Update Failures
>    wifi: ath12k: Use 1KB Cache Flush Command for QoS TID Descriptors
> 
> Nithyanantham Paramasivam (5):
>    wifi: ath12k: Increase DP_REO_CMD_RING_SIZE to 256
>    wifi: ath12k: Refactor RX TID deletion handling into helper function
>    wifi: ath12k: Refactor RX TID buffer cleanup into helper function
>    wifi: ath12k: Refactor REO command to use ath12k_dp_rx_tid_rxq
>    wifi: ath12k: Fix flush cache failure during RX queue update
> 
>   drivers/net/wireless/ath/ath12k/dp.c       |   2 +
>   drivers/net/wireless/ath/ath12k/dp.h       |  12 +-
>   drivers/net/wireless/ath/ath12k/dp_rx.c    | 336 ++++++++++++++-------
>   drivers/net/wireless/ath/ath12k/dp_rx.h    |  18 +-
>   drivers/net/wireless/ath/ath12k/hal.h      |   1 +
>   drivers/net/wireless/ath/ath12k/hal_desc.h |   1 +
>   drivers/net/wireless/ath/ath12k/hal_rx.c   |   3 +
>   7 files changed, 251 insertions(+), 122 deletions(-)
> 

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

