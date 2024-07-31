Return-Path: <linux-wireless+bounces-10754-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E1429433E8
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jul 2024 18:12:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52476286773
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jul 2024 16:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 855EA1BBBD9;
	Wed, 31 Jul 2024 16:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LOhH95g1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2241B29A7
	for <linux-wireless@vger.kernel.org>; Wed, 31 Jul 2024 16:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722442355; cv=none; b=t8AOrqwCxWNYunZZebxH6DHOpIisWEKG+CGsX1HgDbLMuWdSJWO+ux1JIbLPA668GCHb+qJinIxdB8fyBYTo1jNUgVhtFaUXg24B2YayR5hQj3Nm0xtNzUE8H04D/zCWA4Yus+j5IWKgjfjwoabFJJB5MN5ZbiQ0T3tSMO4En/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722442355; c=relaxed/simple;
	bh=YT8GUAoSqMyL/3fhzZ8hFWhs2GLst0pPrWnPVwzRtcc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jYxJACXwRRypDT/euf0LJ0UIxSFqLCoSbH6q2pBfwx+FJ59ngCwM4caFT8P56wIzzUMlCil2g2au4l4hdh1qbOZIVPkzE/yb4Az5E53ikm+CRiUn89/hF0rPwJ5+UqSRypqurDpLpNn91OAdt9BuMRpbtv9AMxexXst8f/Etg4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=LOhH95g1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46VEUach021139;
	Wed, 31 Jul 2024 16:12:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tpJvRAJ4QBKQFyqv3JWnZLJJYgw3GUQh13M7TFcCy1M=; b=LOhH95g17a04ttfK
	8sYx6RKOiHGKcVZnGhZdlo4mOvQDTOlBGBSas3E1D200bl2mDJl3XHWeeMmI8l6H
	xlnuCx0yTISfG7meaG55ltapx/52WPEeUZvTzLJG3E77Xvs/PBy91OO+Sdnx64rH
	XpyKB9kchdtoprsUqooqwQ5varVi+VEpDK8T+UNdJUUnJB6tqfZe6ty3I3U24izc
	b5i1oR5Z8dMqKwmh9HJC0YSmq6ZCI+o0+gzF3NZLL05cO78YAOx3ukkz4uo5x19v
	aCSQPRYGqMi7Rk90OnmM3kdxgXnmWWxqStAC1RpEi8r5SoUCl6P8gNNkiIir16tX
	Oj805w==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40mqw7bu7c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jul 2024 16:12:30 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46VGCTj9006514
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jul 2024 16:12:29 GMT
Received: from [10.111.177.34] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 31 Jul
 2024 09:12:28 -0700
Message-ID: <cc2f3c6f-357f-4c96-90a1-5dabb754eafa@quicinc.com>
Date: Wed, 31 Jul 2024 09:12:28 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] wifi: ath12k: Add support to allocate MLO global
 memory region
Content-Language: en-US
To: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
References: <20240730170910.3281816-1-quic_rajkbhag@quicinc.com>
 <20240730170910.3281816-3-quic_rajkbhag@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240730170910.3281816-3-quic_rajkbhag@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: pd3VtGWA7yecHh21U_kG3-XvveONf-6n
X-Proofpoint-GUID: pd3VtGWA7yecHh21U_kG3-XvveONf-6n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-31_10,2024-07-31_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 spamscore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0
 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407310113

On 7/30/2024 10:09 AM, Raj Kumar Bhagat wrote:
> From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
> 
> To enable Multi Link Operation (MLO), QCN9274 firmware requests MLO
> global memory (MLO_GLOBAL_MEM_REGION_TYPE). This memory region is
> shared across all the firmware (SoC) that are participation in the
> MLO.
> 
> Hence, add support to allocate and free MLO global memory region.
> Allocate one MLO global memory per ath12k_hw_group and assign the same
> memory to all firmware in the same ath12k_hw_group. WCN7850 firmware
> does not request this memory type, therefore this change will have no
> impact on WCN7850 device.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00210-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
> Co-developed-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
> Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
> ---
>  drivers/net/wireless/ath/ath12k/core.h |   7 ++
>  drivers/net/wireless/ath/ath12k/qmi.c  | 118 ++++++++++++++++++++++---
>  drivers/net/wireless/ath/ath12k/qmi.h  |   1 +
>  3 files changed, 116 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
> index 27bd0a14b9f4..c8cd687847e7 100644
> --- a/drivers/net/wireless/ath/ath12k/core.h
> +++ b/drivers/net/wireless/ath/ath12k/core.h
> @@ -758,6 +758,12 @@ struct ath12k_soc_dp_stats {
>  	struct ath12k_soc_dp_tx_err_stats tx_err;
>  };
>  
> +struct ath12k_mlo_memory {
> +	struct target_mem_chunk chunk[ATH12K_QMI_WLANFW_MAX_NUM_MEM_SEG_V01];
> +	int mlo_mem_size;
> +	bool init_done;
> +};
> +
>  /* Holds info on the group of devices that are registered as a single wiphy */
>  struct ath12k_hw_group {
>  	struct list_head list;
> @@ -786,6 +792,7 @@ struct ath12k_hw_group {
>  	 */
>  	struct ath12k_hw *ah[ATH12K_GROUP_MAX_RADIO];
>  	u8 num_hw;
> +	struct ath12k_mlo_memory mlo_mem;
>  };
>  
>  /**
> diff --git a/drivers/net/wireless/ath/ath12k/qmi.c b/drivers/net/wireless/ath/ath12k/qmi.c
> index 11bf16eaadd9..da61ea60e5f8 100644
> --- a/drivers/net/wireless/ath/ath12k/qmi.c
> +++ b/drivers/net/wireless/ath/ath12k/qmi.c
> @@ -2350,19 +2350,61 @@ static int ath12k_qmi_respond_fw_mem_request(struct ath12k_base *ab)
>  	return ret;
>  }
>  
> +static void ath12k_qmi_free_mlo_mem_chunk(struct ath12k_base *ab,
> +					  struct target_mem_chunk *chunk,
> +					  int idx)
> +{
> +	struct ath12k_hw_group *ag = ab->ag;
> +	struct target_mem_chunk *mlo_chunk;
> +
> +	lockdep_assert_held(&ag->mutex_lock);
> +	if (!ag->mlo_mem.init_done || ag->num_started)
> +		return;
> +
> +	if (idx >= ARRAY_SIZE(ag->mlo_mem.chunk)) {
> +		ath12k_warn(ab, "invalid idx %d for MLO memory chunk free\n", idx);
> +		return;
> +	}
> +
> +	mlo_chunk = &ag->mlo_mem.chunk[idx];
> +	if (mlo_chunk->v.addr) {
> +		dma_free_coherent(ab->dev,
> +				  mlo_chunk->size,
> +				  mlo_chunk->v.addr,
> +				  mlo_chunk->paddr);
> +		mlo_chunk->v.addr = NULL;
> +	}
> +	mlo_chunk->paddr = 0;
> +	mlo_chunk->size = 0;
> +	chunk->v.addr = NULL;
> +	chunk->paddr = 0;
> +	chunk->size = 0;

is there a reason to leave the type, prev_size, & prev_type unchanged?
just curious why you don't just zero the entire struct instead of zeroing just
half of the individual members. but then again, why zero paddr and size based
upon my observation below...

> +}
> +
>  static void ath12k_qmi_free_target_mem_chunk(struct ath12k_base *ab)
>  {
> -	int i;
> +	struct ath12k_hw_group *ag = ab->ag;
> +	int i, mlo_idx;
>  
> -	for (i = 0; i < ab->qmi.mem_seg_count; i++) {
> +	for (i = 0, mlo_idx = 0; i < ab->qmi.mem_seg_count; i++) {
>  		if (!ab->qmi.target_mem[i].v.addr)
>  			continue;
>  
> -		dma_free_coherent(ab->dev,
> -				  ab->qmi.target_mem[i].prev_size,
> -				  ab->qmi.target_mem[i].v.addr,
> -				  ab->qmi.target_mem[i].paddr);
> -		ab->qmi.target_mem[i].v.addr = NULL;
> +		if (ab->qmi.target_mem[i].type == MLO_GLOBAL_MEM_REGION_TYPE) {
> +			ath12k_qmi_free_mlo_mem_chunk(ab,
> +						      &ab->qmi.target_mem[i],
> +						      mlo_idx++);
> +		} else {
> +			dma_free_coherent(ab->dev,
> +					  ab->qmi.target_mem[i].prev_size,
> +					  ab->qmi.target_mem[i].v.addr,
> +					  ab->qmi.target_mem[i].paddr);
> +			ab->qmi.target_mem[i].v.addr = NULL;

note here you only zero v.addr, so why zero paddr and size in the code I
commented on above?  seems there should be consistency.

> +		}
> +	}
> +	if (!ag->num_started && ag->mlo_mem.init_done) {
> +		ag->mlo_mem.init_done = false;
> +		ag->mlo_mem.mlo_mem_size = 0;
>  	}
>  }
>  
> @@ -2409,12 +2451,21 @@ static int ath12k_qmi_alloc_chunk(struct ath12k_base *ab,
>  
>  static int ath12k_qmi_alloc_target_mem_chunk(struct ath12k_base *ab)
>  {
> -	int i, ret = 0;
> -	struct target_mem_chunk *chunk;
> +	struct ath12k_hw_group *ag = ab->ag;
> +	struct target_mem_chunk *chunk, *mlo_chunk;
> +	int i, mlo_idx, ret;
> +	int mlo_size = 0;
> +
> +	mutex_lock(&ag->mutex_lock);

since you hold this for the entire function this would be a good candidate for:
	guard(mutex, &ag->mutex_lock);

then you can get rid of the mutex_unlock() calls and can directly return in
places where no additional cleanup is required

> +
> +	if (!ag->mlo_mem.init_done) {
> +		memset(ag->mlo_mem.chunk, 0, sizeof(ag->mlo_mem.chunk));
> +		ag->mlo_mem.init_done = true;
> +	}
>  
>  	ab->qmi.target_mem_delayed = false;
>  
> -	for (i = 0; i < ab->qmi.mem_seg_count; i++) {
> +	for (i = 0, mlo_idx = 0; i < ab->qmi.mem_seg_count; i++) {
>  		chunk = &ab->qmi.target_mem[i];
>  
>  		/* Allocate memory for the region and the functionality supported
> @@ -2427,6 +2478,37 @@ static int ath12k_qmi_alloc_target_mem_chunk(struct ath12k_base *ab)
>  		case PAGEABLE_MEM_REGION_TYPE:
>  		case CALDB_MEM_REGION_TYPE:
>  			ret = ath12k_qmi_alloc_chunk(ab, chunk);
> +			if (ret)
> +				goto out;
> +			break;
> +		case MLO_GLOBAL_MEM_REGION_TYPE:
> +			mlo_size += chunk->size;
> +			if (ag->mlo_mem.mlo_mem_size &&
> +			    mlo_size > ag->mlo_mem.mlo_mem_size) {
> +				ret = -EINVAL;
> +				ath12k_err(ab, "qmi MLO mem err, req size %d is more than alloc size %d",
> +					   mlo_size, ag->mlo_mem.mlo_mem_size);
> +				goto out;
> +			}
> +			mlo_chunk = &ag->mlo_mem.chunk[mlo_idx];
> +			if (mlo_chunk->paddr) {
> +				if (chunk->size != mlo_chunk->size) {
> +					ret = -EINVAL;
> +					ath12k_err(ab, "qmi MLO mem err, mlo_idx %d, req chunk %d, alloc chunk %d",
> +						   mlo_idx, chunk->size, mlo_chunk->size);
> +					goto out;
> +				}
> +			} else {
> +				mlo_chunk->size = chunk->size;
> +				mlo_chunk->type = chunk->type;
> +				ret = ath12k_qmi_alloc_chunk(ab, mlo_chunk);
> +				if (ret)
> +					goto out;
> +				memset(mlo_chunk->v.addr, 0, mlo_chunk->size);
> +			}
> +			chunk->paddr = mlo_chunk->paddr;
> +			chunk->v.addr = mlo_chunk->v.addr;
> +			mlo_idx++;
>  			break;
>  		default:
>  			ath12k_warn(ab, "memory type %u not supported\n",
> @@ -2436,6 +2518,22 @@ static int ath12k_qmi_alloc_target_mem_chunk(struct ath12k_base *ab)
>  			break;
>  		}
>  	}
> +
> +	if (!ag->mlo_mem.mlo_mem_size) {
> +		ag->mlo_mem.mlo_mem_size = mlo_size;
> +	} else if (ag->mlo_mem.mlo_mem_size != mlo_size) {
> +		ath12k_err(ab, "qmi MLO mem err, expected size %d, req size %d",
> +			   ag->mlo_mem.mlo_mem_size, mlo_size);
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	mutex_unlock(&ag->mutex_lock);
> +	return 0;
> +
> +out:
> +	ath12k_qmi_free_target_mem_chunk(ab);
> +	mutex_unlock(&ag->mutex_lock);
>  	return ret;
>  }
>  
> diff --git a/drivers/net/wireless/ath/ath12k/qmi.h b/drivers/net/wireless/ath/ath12k/qmi.h
> index 0dfcbd8cb59b..d8f78794e67e 100644
> --- a/drivers/net/wireless/ath/ath12k/qmi.h
> +++ b/drivers/net/wireless/ath/ath12k/qmi.h
> @@ -167,6 +167,7 @@ enum ath12k_qmi_target_mem {
>  	BDF_MEM_REGION_TYPE = 0x2,
>  	M3_DUMP_REGION_TYPE = 0x3,
>  	CALDB_MEM_REGION_TYPE = 0x4,
> +	MLO_GLOBAL_MEM_REGION_TYPE = 0x8,
>  	PAGEABLE_MEM_REGION_TYPE = 0x9,
>  };
>  


