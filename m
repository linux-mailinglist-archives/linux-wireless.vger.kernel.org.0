Return-Path: <linux-wireless+bounces-24572-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FBB9AEA55A
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 20:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D77B1C4323D
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 18:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 193D7339A8;
	Thu, 26 Jun 2025 18:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="F5DphSyX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F6C2EBDFF
	for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 18:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750962334; cv=none; b=ibZB6r2eb5hBXHr+aMZR0ZKFC/kkf6a0mjGoAH0ia5P7//I4iagjDK3bGKKyXg8JOaqz8YfmPqcS1JB44XUoV11Yl+9j08VtQ8IvkcSXQgR3pElU2eIgfLPyBHNJwTrFC+gFg8z7S2NSVzdpG9fdXfZXEQ9CpSTChMO1N8GdQAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750962334; c=relaxed/simple;
	bh=fOnJesGp7Jz9u+Jpp0RR3XawfMxUVOQSW2kG3HHhkCc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ux2tA4clAq84xrfayT+PrUzON2PZN+nHGZoMxL5el7MqhW7+gUWaqPlWOl0lcEnzj4TXzRy20069YX+yMuNi9xpRrQZZX5igu5B52QLQjzFljY3r7Jc3CDfJDEX+ZR7bvpIjiU/HqGb1qWsJnZzHSrqMPBOaKKCjv15GcZvoMC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=F5DphSyX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55QILpsd018613
	for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 18:25:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8DKaR3UNpAdV9bWro9TvXD4wT6Yvg2ukG4OkQhKAalo=; b=F5DphSyXAAn+rmeM
	4plIwD/SPJf6JaF9l0c4KPGh0/0rLgjWsbr/YS+2+QSM/NMlVGOazBtpR0WQH4ps
	7ldT17EhOcsKZehLZjKITHKEVP6fgsVeCTEyC493yI3ppN/sXVR6/NEIjV6jOWrx
	0BDY25Qx3gNCpX7hl7ZokvfBz8GJF9wyFMBLY4bwb2Mtp3QuGEXtlwmrg9v20Uyg
	aFH3kxol8pxRM5dFjSVnh1TYXVdGPCjKETza+sxUmn/Fp7G95C/uXOnwyLfCCMZa
	huiGOgNcOiLB+az5UHQq74BxZppQK0D8LU23osDASl6/tq9hwTBe/vAAB92WJBM0
	aY2yhQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ec26en2n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 18:25:31 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-748fd21468cso1108133b3a.1
        for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 11:25:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750962331; x=1751567131;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8DKaR3UNpAdV9bWro9TvXD4wT6Yvg2ukG4OkQhKAalo=;
        b=fsOhgZgGQf1UFiOywVsNWiV0mFXGV8KZOknuHgWrdV+1/8mqeK8G6oZLj2EORcmy3S
         t/BPD14XD4078mZanGEIeXhHTZqmow0EByWVitFNd7ijju7j/Md9WiYZLVLSxELt9tI5
         IKWThtlZxafR7cL8EtvGEfnHfmmqrIYM7IgZ4ztV/NVQxQ1mgSXhA033fFMTm9NpTN+s
         ITWYdbLrNQVVwYnp3DNzDh8e4FQhmOgVjz5V3TGdGqO0ExNw1/rpy/sZG5HBndWWyhUl
         7kkHwuxh8bZYFkbdlbd+HA8xn5ck+dRcO0V4Om8/rIwy0YR4pm44cEzkVTUbo2YMlR1K
         3hOA==
X-Gm-Message-State: AOJu0YzW1V5l8wzMhXuKhQd3g0aAqnUp+76N12ddBsWOotNsXGEsKSBP
	pwbYaZ+qT/ft4rLOUg1Irlwsugdie/9omriJzSFWefxB1vHzyTYsmaxQVBFjBFsNyPrHnYPSZLh
	sL12E9lFYWjOnLQImhdEFfWrFF4X9N93bBjWbrIhIPwgNEImLH9n+FKmFS3FbMY2qI4cAIQ==
X-Gm-Gg: ASbGncvBh6roLcDrv5WyL/+zFRBZV7CUOwGGGzGH8gfL8Nf0EHlCfVDPeBsCQqCEuJ6
	cJIyzutfh5LCO6YEI+HqwXcGynIjqEh7zkwe22ME/QctwqVHMgGaWzDHF/aX1BM7p4xy9lXGgRn
	3iyTmr1VA6i1yXoHGDG7rgj6AumGXvSOla+1/fgvd+wXQodGEDhCgTSJitCwKsHveiJNc4QAO2V
	biqyAxPCVqKuHKgATftei1loCqCCB5//O3Z1x6fPtocOKA6trHsBWF42f0L9PWPVhnkUzUpvsrx
	iZlQVebzyVXDi1hopFqvkQAB75rM84Esz7yzYRW+vquoXcaXTPAEZIyKRxwRxUfnHX44SsoPHdm
	umxvXs+94FIl7MtE=
X-Received: by 2002:a05:6a00:2190:b0:742:3fe0:8289 with SMTP id d2e1a72fcca58-74af6faf895mr277022b3a.20.1750962331014;
        Thu, 26 Jun 2025 11:25:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFg26rtk7l1GRO3acP/L5qehLKVQkKWP/wrKtG4Q2URTIoHpv4Nf9Hk1emwQxoT7rVxQT41kQ==
X-Received: by 2002:a05:6a00:2190:b0:742:3fe0:8289 with SMTP id d2e1a72fcca58-74af6faf895mr277002b3a.20.1750962330599;
        Thu, 26 Jun 2025 11:25:30 -0700 (PDT)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af54099ecsm318170b3a.11.2025.06.26.11.25.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jun 2025 11:25:30 -0700 (PDT)
Message-ID: <fca2def0-227b-4208-8104-abc40368f7fb@oss.qualcomm.com>
Date: Thu, 26 Jun 2025 11:25:29 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next v2] wifi: ath12k: Add support for transmit
 histogram stats
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>,
        Roopni Devanathan <quic_rdevanat@quicinc.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Saleemuddin Shaik <quic_saleemud@quicinc.com>
References: <20250617112139.865788-1-quic_rdevanat@quicinc.com>
 <6b32c871-0d18-4cdd-e097-97fc2e7bdf28@oss.qualcomm.com>
 <cab5daaf-bafb-4df3-9e44-1d0e6dda0341@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <cab5daaf-bafb-4df3-9e44-1d0e6dda0341@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI2MDE1NyBTYWx0ZWRfX7GY3Kl/Agf+w
 3ABIURfZ3PBXAniWuqze04WKofx9L/Sdmdx6Yn90Ur8Lvuqw1tX73+5z6QDbJNZl3I0DSRFjTgl
 EXYwWWxubT66jxKHF9fMk1D9tCWwC2fvwtO5G5yih4soEoRZMbNLFr26ndnTj1293AXShtjv2rq
 ohHOZkM245SKYhygZTcgNUSR2qLgb+zgTxhwa3ujxvS+ueyma2QbnfzEDFctyhw+m2+k6A+t1kb
 4W1OZoLhkf4Qy9VhFx1m710sPpjZgJZ9ME683jBOPQGWGjyEqzyAXp1RkD2sBBWe93ndvaQeWeu
 8lpQsJcDYk5kB6xzz2MKE3p3oMc2RFgLkmjoAJHs40vDmEuuELPlz8pNgjbUYFK/7fjx4kWKjYJ
 BL830myn1pjGuiwCseisE7O+u8AMtZJVo1BrGUap/RCRDmFrFKHBN26mmNhCLRbruMR2npHW
X-Authority-Analysis: v=2.4 cv=XPQwSRhE c=1 sm=1 tr=0 ts=685d909b cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=e70TP3dOR9hTogukJ0528Q==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=COk6AnOGAAAA:8 a=641d-tqymQqKGBjUoOgA:9
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: Br8FDI2xK2e0t23RzmL9H1fgcMhdMfd_
X-Proofpoint-ORIG-GUID: Br8FDI2xK2e0t23RzmL9H1fgcMhdMfd_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-26_06,2025-06-26_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 clxscore=1015 suspectscore=0 mlxscore=0
 spamscore=0 phishscore=0 malwarescore=0 mlxlogscore=902 bulkscore=0
 priorityscore=1501 adultscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506260157

On 6/26/2025 11:18 AM, Jeff Johnson wrote:
> On 6/26/2025 10:20 AM, Vasanthakumar Thiagarajan wrote:
>> On 6/17/2025 4:51 PM, Roopni Devanathan wrote:
>>> From: Saleemuddin Shaik <quic_saleemud@quicinc.com>
>>> +struct ath12k_htt_tx_histogram_stats_tlv {
>>> +	__le32 rate_retry_mcs_drop_cnt;
>>> +	__le32 mcs_drop_rate[ATH12K_HTT_TX_PDEV_STATS_NUM_MCS_DROP_COUNTERS];
>>> +	__le32 per_histogram_cnt[ATH12K_HTT_TX_PDEV_STATS_NUM_PER_COUNTERS];
>>> +	__le32 low_latency_rate_cnt;
>>> +	__le32 su_burst_rate_drop_cnt;
>>> +	__le32 su_burst_rate_drop_fail_cnt;
>>> +};
>>
>> Since this strcuture represents the message format used between host and firmware, pls add 
>> __packed annotation even though it may not have any effect in this case.
> 
> looks like I missed this in a few other structs as well, at least:
> ath12k_htt_tx_pdev_rate_stats_tlv
> ath12k_htt_rx_pdev_rate_ext_stats_tlv
> 
> perhaps i'll take this as-is and then have another patch that adds __packed to
> all _tlv structs that are missing it?

actually let me fix this instance in pending, and we can fix other existing
ones separately

/jeff

