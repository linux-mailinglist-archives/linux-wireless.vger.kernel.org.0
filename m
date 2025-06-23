Return-Path: <linux-wireless+bounces-24339-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B6AAE34B3
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Jun 2025 07:21:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE49316FC79
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Jun 2025 05:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BABB1A3145;
	Mon, 23 Jun 2025 05:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="k7r51ujp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B767261A
	for <linux-wireless@vger.kernel.org>; Mon, 23 Jun 2025 05:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750656099; cv=none; b=J2ZEv3+gD8ipqK8wd5Q3nObfXjo+KvFG+IU+N/78qla2LcmYAjdEH7tUbzFO0njCPeRet4b4uKAZoXpP0H4QASHwxkkny3lMWbuyWDD9b0tU5CRQniitq9ftFIiJIgF1UOJ2PfuPvB62eXG9lTSOY75n4uYMsZyIYQ7XD+NErSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750656099; c=relaxed/simple;
	bh=UTR6HOeh0slhKRM6sTG45oSnGpzthLh4z9wsfrd+xGA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z2nqOcwKVQ/lOWrFVU650JAfd8LX+cAF376ZvChTPOHuQ2kC05UPhRRYkNaDxTPME0XaBFNbPIUVDfhmnsHi7LArABH/T7c8TMzzFfEwUahKvYm3mLxgnbRWF6TzspDglDa+8H21UgP+KRWdxLAV2/MeYycA4NDmA/l9/BbrPPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=k7r51ujp; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55N0PhuD015721
	for <linux-wireless@vger.kernel.org>; Mon, 23 Jun 2025 05:21:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7l0WaXKSK8b4eq+N2P1B1qUpB3QaJt1KGeeB9Kc3sMA=; b=k7r51ujpJXOuQlZ6
	COM0hvm2AuUmIXlK0QHRh1ZLaLNfpi1TQJb6m8Te4hiiotx5iDE0KgURTooRIDxr
	4uC2AkRRUT4gUana6dqki1XFAuLL1yRE2OnM+4+0GoACJpyjv+f9rw0yy57QrIOb
	JfGlalVp5hwb5t3oBk0zOKjjc/k0+ihYXw5swYhaqDj3qQPzQtgOCwxNExi2nzEa
	VQIuvgjW6FjROHXL3y9dGILPKMsRNklbpG+yHKQHgkuX6QQ+6OWqMJ5/hfyF+uQ+
	QaEiAX95hN3gUgmZ/mcGsEvJUkmfA1v/+T3qFOrU7leHUfAHm5XQlp1qaSMyiFFd
	dpDTVQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47evc5gg7c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 23 Jun 2025 05:21:35 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-31315427249so3769013a91.1
        for <linux-wireless@vger.kernel.org>; Sun, 22 Jun 2025 22:21:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750656094; x=1751260894;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7l0WaXKSK8b4eq+N2P1B1qUpB3QaJt1KGeeB9Kc3sMA=;
        b=X+rVW4sfaOkgjLYVSWpY/DxOtqT5KIMnX0tdHDtdYigaGF/JKc2okGNH1+TCWznabA
         hYnidh1zpLRYlqb4kcApPHtdZ+CBenDaCoeF05bKL7bVJd4OFkLuSyI6f34e/5RTPNuu
         qXiUEilZEJi+rGT0/qSgxTgW64UJ83qdXVLIGxk47PmRyvd8k8AM90y+cc4IzqJgCr4y
         XgicRWnKsAH0+gAqjoVS7BbqC6dzNyi9QwVipxbfw/LrJ6ttswncW/CQEBnPvLSnMPQs
         SduFrEkq23javDZgiw6FUhhGXGjGEQQAqcO4xb4SbK0NhnLcgqXpgp7QK1JTQKGDA3yk
         ViLQ==
X-Gm-Message-State: AOJu0YzXgpKH080eNOJISPDeRt+LH0Fv7BenqtXcvkzDQe8DYacDY1Wr
	VkO2ObVH+Zx6ZTEzOGra84pK9+mkqbTaM0tUEiodEpPU++tYTVuM64brhl4gi1qbvtN0U35lm8+
	sM3MG0IZCzOmbIW+R1y+25spTkIy93W0OfAK3WlNlkqkP+iClgB9wStdk1v2mx0YGF7o6dg==
X-Gm-Gg: ASbGncsiBlkh9FSZTDIs81mUShLm4coSPJIlDxIJElLXFpPmfkSiWI8vkZTBUnh0NFa
	mdqKZ85iBK5foWi20eXhYX4OE0jspXBPlF/jQehlpwq4pQOTvWtxM+T5VdNW7BjFMH7pSWPdEF0
	wtxzBJQIvtdn+gQ1FZbaBLlh5tGC/UiIlP7gdqesUJpPvvSxAdap+rXKKnJxan/i58JQdnohzGQ
	OrT65laus/9kvCkRscyFZHI6BSUEoqEdwvhVWd2jtu89MGwXO4WfA3yreQew4dCLSCnsgLI54Q2
	L3hVbFT59OLFBUqZ47fDR7qbKjZ6+qxqrPYkl94N+I4iyX1VTdkTEtqglAT6GUFh
X-Received: by 2002:a17:90b:268a:b0:312:e90b:419e with SMTP id 98e67ed59e1d1-3159d646d0fmr19146364a91.12.1750656094573;
        Sun, 22 Jun 2025 22:21:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4lgU7KFjffMXbhjmtkB6X4i4vuMqMFcgqOcVorProC4mPzsKamEdzkFloaoYhhYFKhVV7Hg==
X-Received: by 2002:a17:90b:268a:b0:312:e90b:419e with SMTP id 98e67ed59e1d1-3159d646d0fmr19146339a91.12.1750656094214;
        Sun, 22 Jun 2025 22:21:34 -0700 (PDT)
Received: from [10.152.204.0] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3158a2f35e9sm9629365a91.24.2025.06.22.22.21.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Jun 2025 22:21:33 -0700 (PDT)
Message-ID: <f30000bb-cec7-bd07-3328-1f11578cd1c3@oss.qualcomm.com>
Date: Mon, 23 Jun 2025 10:51:30 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH ath-next 4/5] wifi: ath11k: Add missing include of
 export.h
Content-Language: en-US
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        Jeff Johnson <jjohnson@kernel.org>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vu?=
 =?UTF-8?Q?sen?= <toke@toke.dk>
Cc: linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        linux-kernel@vger.kernel.org, ath11k@lists.infradead.org,
        ath12k@lists.infradead.org
References: <20250611-ath-unused-export-v1-0-c36819df7e7b@oss.qualcomm.com>
 <20250611-ath-unused-export-v1-4-c36819df7e7b@oss.qualcomm.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250611-ath-unused-export-v1-4-c36819df7e7b@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: IZTQs5K44MCwmvxGRK9rDGMACd8QBkM5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIzMDAyOSBTYWx0ZWRfX1AVQVM6PfqnS
 g4vi32wrNtmkL5YG2ANCft0kwB6glS21LLJuwOMLQpYT6hkkicNphqPg+FKONCvoYjii+HPBhKF
 xmzD/i33DjgrtgVopTadtM7lsCezLuAnd1SzixCExzFeRJvTtksslAITZzGVjzsJlcsJYKDsk29
 hGklxhf5H0mfsmPMtieD7nFLj90Ji34nnzL5Q34/H4xHICQUkns9GDg2SZTbaP80xFFNLLSuPvf
 WVNLxPdMZ9oz7WFVAqq6ZNhsWgN96Sr/D72W5ocw/KpCoRqKzhEQnLObClL+6wIk1x9sd6s9Y+W
 dG+PE/hJcYoK/hgFtdjFCL6EAJRBCs5KirM7x7XOtRdRDdHMHYK5cusa27IyUfrhMm1qMPok4F0
 +viqH2CEVf6N5oJCrSfVbJbmeGIyDY6xUYS2/NAypBH3Bw76Q7JcRnU9SDysn5P7GW/Iyh4j
X-Authority-Analysis: v=2.4 cv=caHSrmDM c=1 sm=1 tr=0 ts=6858e45f cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=U89tM0JWt6iRefauG40A:9
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: IZTQs5K44MCwmvxGRK9rDGMACd8QBkM5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-23_01,2025-06-20_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 mlxlogscore=952 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 adultscore=0 mlxscore=0 spamscore=0
 malwarescore=0 phishscore=0 clxscore=1015 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506230029



On 6/11/2025 9:43 PM, Jeff Johnson wrote:
> Commit a934a57a42f6 ("scripts/misc-check: check missing #include
> <linux/export.h> when W=1") introduced a new check that is producing
> the following warnings:
> 
> drivers/net/wireless/ath/ath11k/ce.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
> drivers/net/wireless/ath/ath11k/core.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
> drivers/net/wireless/ath/ath11k/coredump.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
> drivers/net/wireless/ath/ath11k/debug.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
> drivers/net/wireless/ath/ath11k/debugfs.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
> drivers/net/wireless/ath/ath11k/dp.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
> drivers/net/wireless/ath/ath11k/fw.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
> drivers/net/wireless/ath/ath11k/hal.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
> drivers/net/wireless/ath/ath11k/pcic.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
> drivers/net/wireless/ath/ath11k/qmi.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
> drivers/net/wireless/ath/ath11k/trace.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
> 
> Add the missing #include to satisfy the check.
> 
> Signed-off-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

