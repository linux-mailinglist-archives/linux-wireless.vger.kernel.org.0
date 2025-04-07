Return-Path: <linux-wireless+bounces-21204-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5AB7A7E7F5
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Apr 2025 19:16:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C589D167F67
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Apr 2025 17:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E46721C36;
	Mon,  7 Apr 2025 17:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XthXQaJn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291411EF0B9
	for <linux-wireless@vger.kernel.org>; Mon,  7 Apr 2025 17:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744046169; cv=none; b=ZEiLUfIDFxb+rC09wzmym47Ac1oNy2t1YYLVeSBSVMwncGCVqGtRTg2yokxicTmRcB40ivOPkGhWjyVIJje+2/MHpcp47fOiYTeKoKZl+DK+HFmTNw+YfN6aJkjv15eXEQ2tSYbnVvxrjkpsKBZQBtnCqGx5zrAdXpCrEtK16BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744046169; c=relaxed/simple;
	bh=+8kfxIOmkzxK6bPfmVEq65JlL1po2zKB4d1j73924ec=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MmU6+CDgUCZ+ESUVTIvRQHDHcNMrKXruDYu8F4bDRESXyQBQD8Db7ZgaOFVR938ixnxKEzt/EMc0142cvSM/VqiANLMcv2enmbvVZR8FhbdcWGTVnGUzwFy5QRD8V49t0Cu28dIQ/cLzyAG3SPqcqSRLlGzAWlc8hpWZgVVAgFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XthXQaJn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5378do1N001572
	for <linux-wireless@vger.kernel.org>; Mon, 7 Apr 2025 17:16:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	x4+It+c8FiaIPB2pViRPzT1GXbmj+h6GvvLombB8HdQ=; b=XthXQaJnsMmgzIYY
	TZ2HDBFzxq7a4L/EQh94sGaff1ZDI/cv4Lzazh8hOsorpk5h3LrUFzf7ItMbwx3S
	8Jyj6xErEpHvJ2pIY/uzFzXj2XzhQNFtQ8OyIhBYIOtgDWJq1F0gOkH2vTizOx15
	IL4whbP0yNS1lzqzw+c91zuVt+4xFG0o/Hzi+MbG1jUK00K+6UqtcqcWXK8otHVf
	wfevdPpg7jllSBf1qNpI0uY16nN5A9X9nEnrc/evqzx34wEv6TRQ4DyRun7b2Iy7
	RUvtnD4nrx9Zwnobvi0SoUDkO1MMmPcEJvwmeTMKcAHy5CTGTcAZ+7E4nTopHap4
	6Eehkg==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twtaw0jd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 07 Apr 2025 17:16:07 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-ad50a3a9766so3215403a12.0
        for <linux-wireless@vger.kernel.org>; Mon, 07 Apr 2025 10:16:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744046166; x=1744650966;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x4+It+c8FiaIPB2pViRPzT1GXbmj+h6GvvLombB8HdQ=;
        b=mav9cCjMqhzRm5XLbRy7l4ADH+ooJ43TcvPKEttUNnaN6KAWJ1X2d7Cj0S7HkTtcEC
         R+xetJ0RE1nVQL8bAat1HGYpgX1BMW+KpRoFFp7YM262Aju/gJHI4KgR13dPBeUAN0hb
         8ZKVorJORXn1jNRy+RKRD0FkjKMiEoL+qjRPNFMLFrenP3TfYSPjAfB6g0mxIH1QtEuM
         NaMmJcmHwJSQuH3FCnVJQdDKuzyyw6zcaF2maci1MYM06LkkG6rQYgsRu066pkE4ucUQ
         7MxWfIAhbvzzlixFr1Ou8YGTBl+kCg7SWsBYMRDV6ojWCJECdiy8caXSJ+n4Uzkn3A41
         tYNQ==
X-Gm-Message-State: AOJu0YxLcItjY8FOUin2MO2nN/wnn1lEUNGvADagWJlE3rFSWI2sfg40
	SDd/6njdaPYnMj7jdQOHcmxV0wxYvlKtJJwHrLjWVo2LhBFzLN5z75JXnyzznZux3tzp1Ns8GXY
	4K9IGufAKpm0F122zQcS/C62O6zmpe1NQQ0u6lIsSmq/NWDVjsw2Y7O7SemTgplPXpg==
X-Gm-Gg: ASbGncvfYXcv9hJ19axUoIBCc0/8/Wspv9SUHonoNnxv8r+F1vbMYGlbAh2EJ2VDSXQ
	LYVV6qBZ7eJ1pVJhKWdF0KFPc1fnx7hke+9Iou0j7ncdbrinEH3bZOcCLb3dvtIo7XY+jtRbn6i
	FUIIct4dQ5YuhIR7WIAJK8e903mm+kwv7RMSYg2Ag3q+nSO7m4QqRhQDK+XxnkNAyDGlAuA1QZH
	/ljIDmQugLM8+m2448DR27pSgWF7GeX05+PvEXQ/hsHzJa2r8U3qf65L82OHB0dA8c4+EJuHhGc
	4ZrMkCIIUjCYI4opTW7kHa8ObtuMIeEF8T+TROahO4I1+byuk5qcCX2mYrbLaVXIgFK1qg1f64D
	VQKhDcYYQ
X-Received: by 2002:a17:90b:2f46:b0:303:75a7:26a4 with SMTP id 98e67ed59e1d1-306af6e91b5mr15014005a91.7.1744046165603;
        Mon, 07 Apr 2025 10:16:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqRokzLd76m2Y82cCCvCYijyAExnWKd3PeIXztfoKGqbcLATqDh2s/RnOU1w4jQ0njHRmM+Q==
X-Received: by 2002:a17:90b:2f46:b0:303:75a7:26a4 with SMTP id 98e67ed59e1d1-306af6e91b5mr15013940a91.7.1744046164796;
        Mon, 07 Apr 2025 10:16:04 -0700 (PDT)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3058466dc0bsm9058682a91.15.2025.04.07.10.16.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Apr 2025 10:16:04 -0700 (PDT)
Message-ID: <406a43b8-10ad-4bb2-b27b-e97bb1c992b0@oss.qualcomm.com>
Date: Mon, 7 Apr 2025 10:16:03 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next 0/4] wifi: ath12k: Fix multicast memory leak in
 tx path
To: P Praneesh <praneesh.p@oss.qualcomm.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250402181454.2699777-1-praneesh.p@oss.qualcomm.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250402181454.2699777-1-praneesh.p@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: l2PubRszWpfIvWMsLtn9wEwPXmhtOWhO
X-Authority-Analysis: v=2.4 cv=LLlmQIW9 c=1 sm=1 tr=0 ts=67f40857 cx=c_pps a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=e70TP3dOR9hTogukJ0528Q==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=qj2aD7nG-88JOw6nMIUA:9 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: l2PubRszWpfIvWMsLtn9wEwPXmhtOWhO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-07_05,2025-04-07_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 clxscore=1015 mlxlogscore=787 malwarescore=0 phishscore=0
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 spamscore=0 adultscore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504070120

On 4/2/2025 11:14 AM, P Praneesh wrote:
> Address the memory leak caused by extended skb allocation observed during
> multicast transmission in this series.
> 
> P Praneesh (4):
>   wifi: ath12k: Handle error cases during extended skb allocation
>   wifi: ath12k: Refactor tx descriptor handling in tx completion handler
>   wifi: ath12k: Fix memory leak during extended skb allocation
>   wifi: ath12k: Use skb->len for dma_unmap_single() length parameter
> 
>  drivers/net/wireless/ath/ath12k/dp.c    | 10 ++-
>  drivers/net/wireless/ath/ath12k/dp.h    |  7 ++
>  drivers/net/wireless/ath/ath12k/dp_tx.c | 87 ++++++++++++++-----------
>  3 files changed, 64 insertions(+), 40 deletions(-)
> 
> 
> base-commit: ba613742db305037ca2193b2b552b769c4f2a5f7

Please rebase to current ath/main

Applying: wifi: ath12k: Handle error cases during extended skb allocation
Applying: wifi: ath12k: Refactor tx descriptor handling in tx completion handler
Using index info to reconstruct a base tree...
M       drivers/net/wireless/ath/ath12k/dp.h
M       drivers/net/wireless/ath/ath12k/dp_tx.c
Falling back to patching base and 3-way merge...
Auto-merging drivers/net/wireless/ath/ath12k/dp_tx.c
CONFLICT (content): Merge conflict in drivers/net/wireless/ath/ath12k/dp_tx.c
Auto-merging drivers/net/wireless/ath/ath12k/dp.h
Recorded preimage for 'drivers/net/wireless/ath/ath12k/dp_tx.c'
error: Failed to merge in the changes.
Patch failed at 0002 wifi: ath12k: Refactor tx descriptor handling in tx completion handler

/jeff

