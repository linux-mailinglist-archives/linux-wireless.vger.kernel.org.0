Return-Path: <linux-wireless+bounces-28445-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9312EC24395
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Oct 2025 10:43:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBC55189BCEA
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Oct 2025 09:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 759A42E2661;
	Fri, 31 Oct 2025 09:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jXUA5gQr";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PE1guZwJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFCE3321D0
	for <linux-wireless@vger.kernel.org>; Fri, 31 Oct 2025 09:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761903793; cv=none; b=PR9/Pof7BMFV3jR5MdMZUEReYJmLUF3heQAKrSjZph0fCF14ia8zOhvsmjdXsq3R6WVRqowOQghSNtiU9Rf0cTJqKkNvLRz3TuFb0PkF5nFPI2yJrhUMeerptGpEhVPKurd2SDX8tpqg6ETVCgCi595JUlvT9Qaem9Lp/KO0yFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761903793; c=relaxed/simple;
	bh=+uSq+Rid7DuaPL6+6zGqefWZkSWpmChmpJQ0V/FmLpU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RlvuvbH2/onPrjq7iNCoOtrUcIw+MShEYGDrp6YL9YfcOAWtEhVBWMKuvtnilUpLgLJtOykVbkG5X9YjBisQKhyKAD/VFJcopj0PmntYKZTxs9GBYDVz5wze9GsGfYXN0ceHbjy5EbSIbv5S9XV5C8nUtQ9J9HYywEcPbwj/JvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jXUA5gQr; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PE1guZwJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59V17rnd1416929
	for <linux-wireless@vger.kernel.org>; Fri, 31 Oct 2025 09:43:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2r2gV9G+uV+a0gsM+/uOO6OJ5yTgkshM4YxjarPszGk=; b=jXUA5gQrby5Hb44O
	SzfrZXxE5Jmb8dPSTuEyjrZKXeEbUW9OgUVqnb32GnMEj2gg2KJ+z4L54+C5wfKR
	+M2rqbSt3oQfDIXMklPHNRSwtkHkwHZcB+EFsq3QXkiVq9qNTI8e69W3I5FZeue0
	v/RXUCyoUw0Y3RcTL/q53itPwZsJT9nfj8ZOKp+sA21K6krieliiwTVut6oVS0aT
	Zw/uJJgjOrgy2yCkiehdtXVu80ZmyrC+AWIG5ARTA2C636DU6b1vr9tGr+0tpQ6A
	QrCNiWOHbsszrU8CCVwmB8km5Hzfo+nRMvN8nisBv054r3QUHYnAXYQG8VL4JonV
	rWisgw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a4k69h990-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 31 Oct 2025 09:43:10 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-26e4fcc744dso14206535ad.3
        for <linux-wireless@vger.kernel.org>; Fri, 31 Oct 2025 02:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761903790; x=1762508590; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2r2gV9G+uV+a0gsM+/uOO6OJ5yTgkshM4YxjarPszGk=;
        b=PE1guZwJr14mEPbJOal3i4xcJI5jgA/xlP1boiYgRij/HIycQhgWa+pLidTzeidVoG
         Ps2V6t2syPLNz/zErrlasv5ZODUwqmfw9O6l6VRcbrwtBrr6JczLJjH1ed+aQdb2vTjM
         muOXzhG3ubyLgAIWzQSPOPklMOgxMqb2gU/ArmAaC8T6oKuc2k68qxLPwdt+CGuVUYsI
         VfRhgYpEDwdyXHfZP2c4UU6ey0vfLD8DUpvZVNeO9X42xbqtkjgnC51PK74VNjEx88qO
         U4Hi3Q63F18FsSalmCPP0EjS27puz+xsAH6jQuadu+Mr6v0j0N4bH7jz/p1g+ciwN6wO
         F3dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761903790; x=1762508590;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2r2gV9G+uV+a0gsM+/uOO6OJ5yTgkshM4YxjarPszGk=;
        b=FO4f7OUE9UIFCx7ToKrDV9N96+kv6b5p2PXJB///+78LVKq+sZTY4iXghpzjHc91Ty
         F3keiPlgJWcnredlksbdbUSnl17/R37UL8BVYNSYxXsN8BedTYTg43JOXQW4VLxOUzcd
         5vWBccdsSI3lJGy9v5s5JtjQFz1ZiLRD4IiL5ex+r1nrG5KHZL+3u+pEY5R/S5P3dMpl
         aWBixTYjo9Bd7PCq42TtA93ZuAaWS3rTDer0Vb6+Vv/h+6X/71Dl43ZF/VV6GuJqgbHN
         qJ6jKBKd8aHCLDE1ZOi6CJW2MXGE/FYd9/sXTsepG6ne0cEJGeE0cKCflypLUnzWAhWo
         06nQ==
X-Gm-Message-State: AOJu0Yz1oXkWaF5pXnZL9t2jH2SM+9+3iiiRed9WOCeQX9HrvNHPRv3l
	ksu/CdEzexIOsUNCG/x3oVcJ+0eqc+r10W2yV7Zxr9LiyPh3N2sT7M20kv4xwixsgI1a7vCCnJU
	NSMyC4dkwAtEf4T+IFQf24HIT61Tt6ypp3s0+/el3HC/cZNJm/+Lj6CYH0AR8GZPcym3oWw==
X-Gm-Gg: ASbGnct8BeMLJA+sELoWFocnjSp3wOiqQ2ibigoVsEraJkKN1+AzAhLF6qfWZbEdl7V
	9uE+0tRRemiVm97g3d8l3wffnxhx39NRjw4UOB1TOyYuyPjt1UiF9bamWXe6/ktFtP7JRcOj+Yt
	B0oO70/AYu7LhpFhCBPDeKBsQQ6DEpS8nYTfm2ngozXgFZM9Vr/slupdHMEBBi55ouf0+7y2lZq
	OWFQYZdy+5mof4scm3EKtlWCb75VQRNg3nErP/sPF0bc/i2SMTICVI9bEVC2O2OyAHh9hpcjgl2
	Q17+4OwhMGSyai10HF8+/Jakw5T6kH3l9MER4f6IL4ZofQkYaEm8UZBEdP3ELaBChWAyaqdRRoG
	+NAFqIhdlpbQeEKg95N0ptltCVNty+tGEZFKcvFc7q+Ku
X-Received: by 2002:a17:903:1206:b0:294:ee1c:78c7 with SMTP id d9443c01a7336-2951a527091mr39290885ad.54.1761903789595;
        Fri, 31 Oct 2025 02:43:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERLfHB/VUdV4k5DCZVAbH2GtHr7Y3ncuGgFQmvXGxpBTJEnJlVQXZT+YvVvgQGm9EO1kYiVg==
X-Received: by 2002:a17:903:1206:b0:294:ee1c:78c7 with SMTP id d9443c01a7336-2951a527091mr39290645ad.54.1761903789126;
        Fri, 31 Oct 2025 02:43:09 -0700 (PDT)
Received: from [10.152.204.0] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29526870f22sm17183475ad.12.2025.10.31.02.43.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Oct 2025 02:43:08 -0700 (PDT)
Message-ID: <4f4184ed-508c-14e3-122d-b8e3cfe5a9f2@oss.qualcomm.com>
Date: Fri, 31 Oct 2025 15:13:06 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH ath-next 0/2] wifi: ath12k: Address issues during beacon
 stats retrieval
Content-Language: en-US
To: Manish Dharanenthiran <manish.dharanenthiran@oss.qualcomm.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20251031-beacon_stats-v1-0-f52fce7b03ac@qti.qualcomm.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20251031-beacon_stats-v1-0-f52fce7b03ac@qti.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDA4OCBTYWx0ZWRfX8oQXCgOxUw/4
 5jtbow/6MjMrlDBw5PvgTyZEflv7FbEDFz/U9Xv+Cb0Xp/gaB9338oWbCxr1s5Xp6Z8DXEwZg5J
 e2tW4dVWhqRl3WCKZIQwIeUG1tarVyEpzzMJWM862UVEi457UdOd9cNGffzmNYUoC1Y/eIzMhjn
 8n4uRHAZS6E3mFK+bXgzC14IpPUEXDMxqufs5H/6KGKivzyLr5MMGmf5J6MxzCgCbngIgbcZytS
 ImT/IXfGJ2sCg81VhdoN+LzVWeRSXob7DjghQfhPV86xmbjSBW9Y1qfnaK6rOw66azUJ9fAMJ6q
 5r8s0o0D5Qbqg++Xt3c/YIYCnG2Bgev1ypyQj0jH2nRkQ5KpBLm2ISh/GvHYW0fTEHzRWVxAXB9
 UrTeWjGzGaXSnbovK8cjr8HpLSpycQ==
X-Authority-Analysis: v=2.4 cv=Bv2QAIX5 c=1 sm=1 tr=0 ts=690484ae cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=_JD12454azqmeQhFCGEA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: otOErUEMjIAtdb8msRXQrqLqAayr5uGy
X-Proofpoint-ORIG-GUID: otOErUEMjIAtdb8msRXQrqLqAayr5uGy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-31_02,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 malwarescore=0 spamscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510310088



On 10/31/2025 8:37 AM, Manish Dharanenthiran wrote:
> Currently, retrieving beacon stats is getting failed with timed out error
> when multiple BSSes are enabled. This patch series tries to address the
> mentioned issue by the following,
> 
> #1: Reset the firmware stats only after retrieving the complete stats
>   #2: Remove the wait timeout to get stats for all enabled BSSes during
>   beacon stats retrieval.
> 
> ---
> Manish Dharanenthiran (2):
>        wifi: ath12k: Make firmware stats reset caller-driven
>        wifi: ath12k: Fix timeout error during beacon stats retrieval
> 
>   drivers/net/wireless/ath/ath12k/core.c    |  2 --
>   drivers/net/wireless/ath/ath12k/core.h    |  1 -
>   drivers/net/wireless/ath/ath12k/debugfs.c |  9 +++------
>   drivers/net/wireless/ath/ath12k/mac.c     | 15 ++++++++++-----
>   drivers/net/wireless/ath/ath12k/wmi.c     | 12 +-----------
>   5 files changed, 14 insertions(+), 25 deletions(-)

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

