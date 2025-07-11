Return-Path: <linux-wireless+bounces-25249-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 124B2B012B7
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Jul 2025 07:31:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 052B8542380
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Jul 2025 05:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D50C71C84BB;
	Fri, 11 Jul 2025 05:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gjnQ3vLV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F95944F
	for <linux-wireless@vger.kernel.org>; Fri, 11 Jul 2025 05:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752211867; cv=none; b=ZqoDgkd3lqpT9xNKFByQdRae1xP1xbThIbFArdc9vJWTuiA9KSpa+k4lUxoSGWXIEB1H7HZDjxyi6RFJUxnpANwo2n/0ry8dRRbCJbI4SiXuTJZLiqQYUzMZJ3Ebfyh1c15/6AbgweHP7mKXJHYJlXhuV7aAfg7dNQ4BijnoWPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752211867; c=relaxed/simple;
	bh=U173yKLrCeiqto8RiQJZWjFoXE9jXxylW49nnYHipXM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XXm1XKWubbIDjtwxHw6TIJnd0VYgj0byNDBkJgdyjf+XvoXNeC+9YtgCrxR8fceUSLcYk8WfK3erPENNL2YYcfYctyI+VB+Yh7FSVYnoJnguRXj3tj4413zUmm15kgZTorG7X3a/IvkDIJ6Rtn4oCeOAVwvLmysK4ATCW9elkGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gjnQ3vLV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56B1XDQU022589
	for <linux-wireless@vger.kernel.org>; Fri, 11 Jul 2025 05:31:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SNVflDDkNFoihhjGJq8umn74evciGG4j45Wyl6wItrw=; b=gjnQ3vLV7kPPvTQV
	lv7lcDtYa+Y+T5jUPEk9ycAMNr5eBX/Kvt0fx8nYYvyXuSzdlyrBzidnGLtS8ruC
	uvu3UgN1tnNhj0Z8eq4hKycAFfJOVjgJ1iaFwGFkMSH4nNhaso7DQcau1lodyFtH
	inSpzckV3aFhs4v4MRDDjTgI3F/VBQ6qmcTLhXwkmNfcRwUz3tGC8Z9Q+gA9B5If
	XhUjpQY+4yu+5R3G+ceVAWT9O3Hx2vxE0jnthGyMrA89ew8NCVXaFDWzCsH/oA1U
	AkUFesQdanjIHWyw9uzUQkcEAZDqof0l026WhJPyDTzOhlfm4UrA6r6l1/ESkr9V
	fRVfyw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47r9b18bmx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 11 Jul 2025 05:31:01 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-747ddba7c90so1534015b3a.0
        for <linux-wireless@vger.kernel.org>; Thu, 10 Jul 2025 22:31:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752211860; x=1752816660;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SNVflDDkNFoihhjGJq8umn74evciGG4j45Wyl6wItrw=;
        b=Oim+Y0AL7L+V4AfmijE6GDjOSxnZLQIM5ScOswqfFjFypbX1eSDaolpXdN3xggbSF3
         pcx5sXEsnhUmim9o4mOH8kL/R18lxk/P3PlV7mtVfdZkgfhxGx68lD28l29eATKCRsMK
         lmb8vV7ji6e+OX8L0PQ5wvsDPDh22nosAo1JT0CTJ4NElJpyBnjk4klRBD+LM1EWYza9
         HSsnkz0bcGo6ZsjkVMkn02lRmFNT71Nf3T3tHmIuCtEB98TY6Ww/iO9OZbA76UTvX7N3
         471t3HYubel/brFu3HrWFj6DCDQVPQh1+ax6HukuVlBCoLIs+UbON00msLlk2gFHujMx
         411A==
X-Gm-Message-State: AOJu0Yz+stpHLgx75cuMG6kRRFMOHoxownw3xDSPEhMU9mmM/LTUZzlR
	EVy6XzbJPbsayXWyGETDUf0fx/5M/T14t53Grncj8DcDcZB9ROhqqVXl3EHYF1EGGnKXTiACN5m
	Ya2RwXo2iWKvWJAZrt2B1zsjEkh+AqWzUsZwlsXwsztRLn+RM8QwuEI07A3CjknFueVCv3w==
X-Gm-Gg: ASbGncuWhE5bHWXSzfulZGAZJEYFvVCA/ZkRHNNLaE0EJZhp0+2aVwpcXLCMueErTLb
	PzAiQ7evzyUPAH9zUzUCQK+3aqH3X/e/v895zNEC6aFTy2hH+s+X3zPcXDnfQeYpCLD5EIkBU5F
	qb9A1wcbv27AgK7+E3kRKSGmAaNnnn9JHjX5tr/cSwv9nuVOBYcp2as2VQzLi4hBFbRA6Oe7NDv
	n5Fz92Ve+XVYp2j9JtNISF9cuz5foB7lS0dycE+Q+1mDxIB6uqW6aLe7jMmQMbfZQFp6NzXx8qV
	+AiDAqsu9IW2y6s6UdgBoKah6nMZJ4jwMWM0TogJf/fcPv77NBwNTlz7RGUxczRk9c+MMpFN+UF
	aSW3XSmJ+Ng4=
X-Received: by 2002:a05:6a00:3a1b:b0:748:e1e4:71e7 with SMTP id d2e1a72fcca58-74ee362a3b5mr2276147b3a.23.1752211860109;
        Thu, 10 Jul 2025 22:31:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqPmCFcasTUJx8zqmpSWnL9OX8BO5+kq4ZO2xZy7Xkljbdq+VjE2ym8EXbi+lGbr8rixsMXg==
X-Received: by 2002:a05:6a00:3a1b:b0:748:e1e4:71e7 with SMTP id d2e1a72fcca58-74ee362a3b5mr2276118b3a.23.1752211859649;
        Thu, 10 Jul 2025 22:30:59 -0700 (PDT)
Received: from [192.168.225.142] ([157.49.235.30])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9f4a023sm3806898b3a.121.2025.07.10.22.30.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jul 2025 22:30:59 -0700 (PDT)
Message-ID: <6e8eb4b3-2112-3536-cf2f-e68dec7323c7@oss.qualcomm.com>
Date: Fri, 11 Jul 2025 11:00:56 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH ath-next 0/4] wifi: ath12k: Add low-memory profile support
 for QCN9274
Content-Language: en-US
To: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250708181102.4111054-1-aaradhana.sahu@oss.qualcomm.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250708181102.4111054-1-aaradhana.sahu@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=dYuA3WXe c=1 sm=1 tr=0 ts=6870a195 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=qj7j/dCbgmX8y5u3oU6Y8g==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=2j2roQ-58BhgqnNodNMA:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDAzNiBTYWx0ZWRfXw298uT+j0KsY
 TBrBd4kx/Q5qRQBK9UVtQJ1tzjHPrJH3BwqDe1KFcN1A0irmJSXRymOq+bfRA5NwkS8Ck49Nry9
 tVQ4A76ohwf3wBX57jFH891j4GBa7M/QmMgeblbacOZvr27Ef96z542MzAIeqZ4cy0l+BdZikwu
 piYROZadKeuO39YQ+ta0C8d7JJQcCfSsqnLTApEUubFGPIHvpgjXhUgYBEK/nO47tdKKyf2FCZ2
 M56hxKRRNqlB7Nwrm2ceJsa35aXQaHn6s14QxLqyx0KIX9ZT5HMr+htdUabIDXaNCXdPZT51eaE
 fn46sV+3sPyNKE6Kxo6c0BlqolqYj40WV7u1AQiwwBejNL1Upes4cDR1nKH1Lq7x4Td6Zto96+F
 0DrI/R8CunyD6H7cQBxsHz/d7O+EYOC9NGub3hpywEwrtRVzY10A3hrGGNPqeBArrnsEAdaP
X-Proofpoint-GUID: _FJEHafo1r3Z2ZR-X81O3AbiUWFEQ82W
X-Proofpoint-ORIG-GUID: _FJEHafo1r3Z2ZR-X81O3AbiUWFEQ82W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_01,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 adultscore=0 mlxlogscore=760 malwarescore=0
 mlxscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507110036



On 7/8/2025 11:40 PM, Aaradhana Sahu wrote:
> The ath12k driver currently assumes availability of ample DDR memory
> and configures internal buffers and descriptors accordingly.
> 
> Introduce support for a low-memory profile to optimize memory usage in
> constrained environments. This mode is useful in scenarios where
> memory constraints are a concern.
> 
> To add support for low-memory profile make below changes:
> - Introduce module load time memory profile selection based on
>    meminfo.
> - Add logic to configures internal buffers and descriptors according
>    to memory profile.
> 
> Aaradhana Sahu (4):
>    wifi: ath12k: Add a table of parameters entries impacting memory
>      consumption
>    wifi: ath12k: Remove redundant TID calculation for QCN9274
>    wifi: ath12k: Refactor macros to use memory profile-based values
>    wifi: ath12k: Enable memory profile selection for QCN9274
> 
>   drivers/net/wireless/ath/ath12k/ahb.c   |   1 +
>   drivers/net/wireless/ath/ath12k/core.c  |  76 ++++++++++----
>   drivers/net/wireless/ath/ath12k/core.h  |  20 +++-
>   drivers/net/wireless/ath/ath12k/dp.c    | 129 +++++++++++++++---------
>   drivers/net/wireless/ath/ath12k/dp.h    |  37 ++++---
>   drivers/net/wireless/ath/ath12k/dp_rx.c |   4 +-
>   drivers/net/wireless/ath/ath12k/dp_tx.c |  13 ++-
>   drivers/net/wireless/ath/ath12k/hw.h    |  30 ++----
>   drivers/net/wireless/ath/ath12k/mac.c   |  11 +-
>   drivers/net/wireless/ath/ath12k/pci.c   |   2 +
>   drivers/net/wireless/ath/ath12k/qmi.c   |   2 +-
>   drivers/net/wireless/ath/ath12k/qmi.h   |   6 +-
>   drivers/net/wireless/ath/ath12k/wmi.c   |   3 +-
>   13 files changed, 211 insertions(+), 123 deletions(-)

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

