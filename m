Return-Path: <linux-wireless+bounces-10751-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7955C94339D
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jul 2024 17:45:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9E5C1F27CF3
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jul 2024 15:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EEBA442C;
	Wed, 31 Jul 2024 15:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Zf5B+9zR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DAF51B3721
	for <linux-wireless@vger.kernel.org>; Wed, 31 Jul 2024 15:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722440737; cv=none; b=uOKGFSApWznnhdLUiywbaEn6IaHaE59XxvJBmhoafkNybZJzMN6Gj5fzlR8ucKWo9gH9tvJXsy3dFd1s1dBz7iQ2EZ1BCv26bAUHZn9gE4vBQ2Z2rpXB/EwZPx5z/98t5rh6fwVA0d5DblpPrYD0OmHTERCZc7cdD2zdiGGIolE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722440737; c=relaxed/simple;
	bh=3y65TJKwwZNtkZk4SqoEcKlh69bhob407BMyyJpGqH8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=McZlLUvRans3Ck+n9Uw+m2r67EI7alLj8SeMshy2ODQsty4d7ipKUTD5rSKGQVs1MQwaHZzvDr7l2nOmRfAGdIje4KkkGxWcMREllZlisObIVp/B6K5+kD3tdlTWChzjpYEcdt95WEOXXiMS75wfIFTAItBZLCxX79Isopyb0QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Zf5B+9zR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46V6qKLA022117;
	Wed, 31 Jul 2024 15:45:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0bfNoF5u5E/LYxGYAQNTPgdagyfykUCKHrT52KkAGxo=; b=Zf5B+9zRWILVIM7C
	pAP1qym5v2H5bpeXgrgObq26TCpBOMdEPXaZ3MYDGw8cz+Dhk9S5pYJN6Wq1L0+O
	+da87it4iECqFWsZTstCwJURM8gIVn+KedAljAAXAiUgPgC+5kkOmM2klXttEClv
	kEleFVJKhfWPO4lewRs6EZkeZg9zbkJMBc06m/EwTcfUzDlfI0yLjG8UYZhQ0KtQ
	IcfirFTBf6p5FBhJYdbW037MvBNFxDjWSp5Rxa8AZZ64rfb9p8OuGQ1cXAS0KjkD
	5VgoFYeC73FneKT3QYsAcNIQ/x0bFdgSj3cczTqUx31SJGnc4AGKuF3oBcLMw+pT
	lro/dg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40mp8n42nk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jul 2024 15:45:27 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46VFjAVd002164
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jul 2024 15:45:10 GMT
Received: from [10.111.177.34] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 31 Jul
 2024 08:45:10 -0700
Message-ID: <4ed6f40e-f27a-4868-8670-c81d95a14a3d@quicinc.com>
Date: Wed, 31 Jul 2024 08:45:09 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] wifi: ath12k: Refactor
 ath12k_qmi_alloc_target_mem_chunk function
Content-Language: en-US
To: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
References: <20240730170910.3281816-1-quic_rajkbhag@quicinc.com>
 <20240730170910.3281816-2-quic_rajkbhag@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240730170910.3281816-2-quic_rajkbhag@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: pmxA4pwVOQSDq8SpgBFhITcaOh8bNYmJ
X-Proofpoint-ORIG-GUID: pmxA4pwVOQSDq8SpgBFhITcaOh8bNYmJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-31_10,2024-07-31_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 mlxscore=0 clxscore=1015 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407310110

On 7/30/2024 10:09 AM, Raj Kumar Bhagat wrote:
> From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
> 
> Currently, all QMI target memory types share the same allocation
> logic within the function ath12k_qmi_alloc_target_mem_chunk().
> However, for Multi Link Operation (MLO), firmware requests a new MLO
> global memory region. This memory is shared across different firmware
> (SoC) participating in the MLO. To accommodate this logic change,
> refactor ath12k_qmi_alloc_target_mem_chunk() and introduce a helper
> function ath12k_qmi_alloc_chunk() for memory chunk allocation.
> Subsequent patch will add MLO global memory allocation logic.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00210-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
> Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
> ---
>  drivers/net/wireless/ath/ath12k/qmi.c | 82 ++++++++++++++-------------
>  1 file changed, 44 insertions(+), 38 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/qmi.c b/drivers/net/wireless/ath/ath12k/qmi.c
> index 047393bc8bea..11bf16eaadd9 100644
> --- a/drivers/net/wireless/ath/ath12k/qmi.c
> +++ b/drivers/net/wireless/ath/ath12k/qmi.c
> @@ -2366,9 +2366,50 @@ static void ath12k_qmi_free_target_mem_chunk(struct ath12k_base *ab)
>  	}
>  }
>  
> +static int ath12k_qmi_alloc_chunk(struct ath12k_base *ab,
> +				  struct target_mem_chunk *chunk)
> +{
> +	/* Firmware reloads in recovery/resume.
> +	 * In such cases, no need to allocate memory for FW again.
> +	 */
> +	if (chunk->v.addr) {
> +		if (chunk->prev_type == chunk->type &&
> +		    chunk->prev_size == chunk->size)
> +			goto this_chunk_done;

since this is a refactor I appreciate the desire to exactly copy the existing
code. however since this is now a separate function, IMO we can make small
tweaks which take advantage of that, so here I would just:

			return 0;
> +
> +		/* cannot reuse the existing chunk */
> +		dma_free_coherent(ab->dev, chunk->prev_size,
> +				  chunk->v.addr, chunk->paddr);
> +		chunk->v.addr = NULL;
> +	}
> +
> +	chunk->v.addr = dma_alloc_coherent(ab->dev,
> +					   chunk->size,
> +					   &chunk->paddr,
> +					   GFP_KERNEL | __GFP_NOWARN);
> +	if (!chunk->v.addr) {
> +		if (chunk->size > ATH12K_QMI_MAX_CHUNK_SIZE) {
> +			ab->qmi.target_mem_delayed = true;
> +			ath12k_warn(ab,
> +				    "qmi dma allocation failed (%d B type %u), will try later with small size\n",
> +				    chunk->size,
> +				    chunk->type);
> +			ath12k_qmi_free_target_mem_chunk(ab);
> +			return 0;
> +		}
> +		ath12k_warn(ab, "memory allocation failure for %u size: %d\n",
> +			    chunk->type, chunk->size);
> +		return -ENOMEM;
> +	}
> +	chunk->prev_type = chunk->type;
> +	chunk->prev_size = chunk->size;
> +this_chunk_done:

with the above change this label is no longer needed

> +	return 0;
> +}
> +
>  static int ath12k_qmi_alloc_target_mem_chunk(struct ath12k_base *ab)
>  {
> -	int i;
> +	int i, ret = 0;
>  	struct target_mem_chunk *chunk;
>  
>  	ab->qmi.target_mem_delayed = false;
> @@ -2385,42 +2426,7 @@ static int ath12k_qmi_alloc_target_mem_chunk(struct ath12k_base *ab)
>  		case M3_DUMP_REGION_TYPE:
>  		case PAGEABLE_MEM_REGION_TYPE:
>  		case CALDB_MEM_REGION_TYPE:
> -			/* Firmware reloads in recovery/resume.
> -			 * In such cases, no need to allocate memory for FW again.
> -			 */
> -			if (chunk->v.addr) {
> -				if (chunk->prev_type == chunk->type &&
> -				    chunk->prev_size == chunk->size)
> -					goto this_chunk_done;
> -
> -				/* cannot reuse the existing chunk */
> -				dma_free_coherent(ab->dev, chunk->prev_size,
> -						  chunk->v.addr, chunk->paddr);
> -				chunk->v.addr = NULL;
> -			}
> -
> -			chunk->v.addr = dma_alloc_coherent(ab->dev,
> -							   chunk->size,
> -							   &chunk->paddr,
> -							   GFP_KERNEL | __GFP_NOWARN);
> -			if (!chunk->v.addr) {
> -				if (chunk->size > ATH12K_QMI_MAX_CHUNK_SIZE) {
> -					ab->qmi.target_mem_delayed = true;
> -					ath12k_warn(ab,
> -						    "qmi dma allocation failed (%d B type %u), will try later with small size\n",
> -						    chunk->size,
> -						    chunk->type);
> -					ath12k_qmi_free_target_mem_chunk(ab);
> -					return 0;
> -				}
> -				ath12k_warn(ab, "memory allocation failure for %u size: %d\n",
> -					    chunk->type, chunk->size);
> -				return -ENOMEM;
> -			}
> -
> -			chunk->prev_type = chunk->type;
> -			chunk->prev_size = chunk->size;
> -this_chunk_done:
> +			ret = ath12k_qmi_alloc_chunk(ab, chunk);

seems like you need to test ret and return if non-zero here since currently if
you get a bad ret in one loop but you continue and get a good ret on the
remaining iterations then you'll end up returning success from this function.

In other words, your refactoring doesn't correct handle that the original
"return -ENOMEM" would return from *this* function at this point

>  			break;
>  		default:
>  			ath12k_warn(ab, "memory type %u not supported\n",
> @@ -2430,7 +2436,7 @@ static int ath12k_qmi_alloc_target_mem_chunk(struct ath12k_base *ab)
>  			break;
>  		}
>  	}
> -	return 0;
> +	return ret;

if you test ret above then there is no need to make this change since this
will always be the success case

>  }
>  
>  static int ath12k_qmi_request_target_cap(struct ath12k_base *ab)


