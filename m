Return-Path: <linux-wireless+bounces-21428-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E97A854D5
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Apr 2025 08:57:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F0CC7B4CF9
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Apr 2025 06:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FCF527CCEA;
	Fri, 11 Apr 2025 06:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TTwPkxWl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F89C20468C
	for <linux-wireless@vger.kernel.org>; Fri, 11 Apr 2025 06:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744354624; cv=none; b=nrcb7Mh9vccYeVezKymnSM3tJOLOSIkxwfsEgDVq+IND2BZE1QkaBEJXtR3cwawpdy3VqAh0kN0CgKWL+jMg51V6zDo7fPX3+XgNeKb5OJJDyia4e2L+Gj2o9c/JM2JxACAA0LLN2iNJ8ktLxWiGmf219JXTEeZXrzs4LbXFkZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744354624; c=relaxed/simple;
	bh=szTY8LYNHbAE0AxggPpC21kPVfy/CG3A1ppua0q53F0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ilxjiH02AmIDuFCVd/Znt08QSEVVs/+1ne0CgfHEuazUhiPbB8GBc7hRKTsECm1FkoMiOZwLV02OPmT8VEquDnSaF2G//YaEbQ0genKt/+KyDYUwxxq+BqU7meYPCzHMap76DrsbEy6xAK6Rn1lcdx9XX8AEnbJqo2rzbL+bWiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TTwPkxWl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53B5eNTE000340
	for <linux-wireless@vger.kernel.org>; Fri, 11 Apr 2025 06:57:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PUn1gHbKS749ntRb6VKuKFrfUDbD7bZV4DHLH4o54Bw=; b=TTwPkxWl1hUx6xyU
	0mfwGZe+7GT4fjmrG480lXGL/x7qgdhOFLRuiDMMz2xODQIa4NxfEnquy8nhLYmB
	ufz6BV7XwjqihrciKbiPwbfGUbdwHgOannDNdoBGSZ8WDMpeUqhsNLM2HOFSwuaC
	dvGw6EIUTnrNephCqxrS700gA5CnIOW0AWI6N+RXLFG0F1iEnmKAu8YHH3NkwQu+
	2GBvsQC1NphHfysrGigoEALfEmn2vFyuAEQucRq+iKuvY+4x6L2jDz8pG6VeEf4b
	UPR/CCaWZ0fCFWkRE5D3EJuto5LQpTXwNQIqsjImR/iDvNOCD+Qpdt3uksWnIy9x
	dsO+2A==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twfks9n3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 11 Apr 2025 06:57:01 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2240c997059so19693735ad.0
        for <linux-wireless@vger.kernel.org>; Thu, 10 Apr 2025 23:57:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744354619; x=1744959419;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PUn1gHbKS749ntRb6VKuKFrfUDbD7bZV4DHLH4o54Bw=;
        b=S5gtGQgax5DngyVnQhTgVmsZgcYrvk+DF3VY6nnKPyhoMSKt/t9/Q+PZCbGcUwmyHo
         XCkZLc+2vCW96rq2PKqgETL1nhuRp5ijq2mOcDsLuhVLacjVvGjAlhvyv8up3cBORqnF
         QA6p0c9jZKs7KQK8W8VRS+Xzjl6fbkM+sriaRUg7ddIgx+ZWrFgnrRUk9vETK/XbPGnV
         CTs/OOTfo38LL+TxaSMRP2q535EbYwxF3R0ie7PBSxYRG5tTu7y2cy1lHFUvhqdSpHQ/
         hMnWkbh40uQBwrM6VfyayzV8w5GpdQYJFUU5FUBpGKtXQsMAllWL3c5wceq6os6nYYdF
         XdDg==
X-Gm-Message-State: AOJu0Yw7ciC/mguM8AiQFcooaFHONj6KnDC/klJCdG+x4ZpR+nnF3BoP
	bBiCn1vqFXJvC516GwGQXbKXegy2vThUIqNX+4W8BrmA0uZnhfXZF4yz7YCR8bdxBQr+CTBX/5g
	mwHvmtUYf7+tUqsKBM32IT2GIMV5zDalhJn7By+1wamNYUGNuia/6YZJdq6isuil4ymMIHaYb2w
	==
X-Gm-Gg: ASbGncstxfoRy42V4xCbGY93nCD3loUNPZCRdGC5uxcGHX3TLjLKEsLJouXP2vfR05r
	n6MjeHbMSh/gqrAlS2qsEYSZxFHwgE+f3G+8fj4ktGglxGnzBCHIdOQ3EDXhVQ4KgIcRIW1k0nf
	5Q7mtDP3idsN4V7PskabRqZEgGc0NcjUnejVKA8F/y6Z0i0gXg7T9+hH4jBt2bHgXtpR5GamiDV
	B36VJjHcK8BWq4kCGJeZ/gcY5MgLYEVen/wvUrqitSODzGXwQdiTEm8rX64a5SRKCFSurVkH6fA
	cMGQUBUtvBZkedSRqhuSuqF+4IzLQf5M98P3aBd7ZIjnMZgfGq1foQ==
X-Received: by 2002:a17:902:c411:b0:220:cd9a:a167 with SMTP id d9443c01a7336-22bea49524fmr27303305ad.4.1744354619571;
        Thu, 10 Apr 2025 23:56:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQtyHgf4Pn+YDHWjQLP+B73OysFo7DYvxuO+8nIBcuP82X83Pqy5/aS8jTapIsaxjx2w961g==
X-Received: by 2002:a17:902:c411:b0:220:cd9a:a167 with SMTP id d9443c01a7336-22bea49524fmr27303125ad.4.1744354619248;
        Thu, 10 Apr 2025 23:56:59 -0700 (PDT)
Received: from [10.152.204.0] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7b65a56sm42019605ad.2.2025.04.10.23.56.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Apr 2025 23:56:58 -0700 (PDT)
Message-ID: <3694d45a-a1b8-af97-6db9-3d5b6274e8ba@oss.qualcomm.com>
Date: Fri, 11 Apr 2025 12:26:55 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH ath-next v3 4/4] wifi: ath12k: Use skb->len for
 dma_unmap_single() length parameter
Content-Language: en-US
To: P Praneesh <praneesh.p@oss.qualcomm.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250411060154.1388159-1-praneesh.p@oss.qualcomm.com>
 <20250411060154.1388159-5-praneesh.p@oss.qualcomm.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250411060154.1388159-5-praneesh.p@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: qFl-y-yQz7S6wfUKkogSAOJw8K-wcrH9
X-Proofpoint-ORIG-GUID: qFl-y-yQz7S6wfUKkogSAOJw8K-wcrH9
X-Authority-Analysis: v=2.4 cv=b7Oy4sGx c=1 sm=1 tr=0 ts=67f8bd3d cx=c_pps a=cmESyDAEBpBGqyK7t0alAg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=su9HG1vMjMrjkUACNh0A:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-11_02,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 priorityscore=1501 suspectscore=0 mlxscore=0 impostorscore=0 phishscore=0
 clxscore=1015 spamscore=0 mlxlogscore=749 bulkscore=0 lowpriorityscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504110048



On 4/11/2025 11:31 AM, P Praneesh wrote:
> During dma_unmap_single() for extended skb, the driver currently uses
> sizeof() of the corresponding structure. When the allocation size changes,
> one of the parameters of dma_unmap_single() needs to be updated everywhere.
> Improve code readability by using skb->len instead of sizeof() the structure.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: P Praneesh <praneesh.p@oss.qualcomm.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

