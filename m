Return-Path: <linux-wireless+bounces-29085-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BE515C6895A
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Nov 2025 10:38:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D103E35D7C9
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Nov 2025 09:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C82321421;
	Tue, 18 Nov 2025 09:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jmMyNUDP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ilqR+KpD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85869320CD3
	for <linux-wireless@vger.kernel.org>; Tue, 18 Nov 2025 09:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763458521; cv=none; b=OQHAv5LD5gQBweQzYS5KLcDIQFWIjIy79LiV8z952q37Il80+WWWU4rRLDsvLnqJMqMAoHV0NWdTx/r3pWJfcQpS3F2wva6mpQx49znvpHUpTTLY5zg5BJaTBwUMFpztEnDNDOOv89+gd6FTR2/XZHa4+Dq0pUk7247yk8ehR9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763458521; c=relaxed/simple;
	bh=KRVd0BFR89i9lMHbApXTixpHS3C10ARYGNl/1oHphm8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z052LuzzTWj7//NLQDKb9+sem9AiSMo6jReIOzdbHcItV2T2bX6XJxqBtmFimAotaT10jcsOVkoWJZ1vSu4RUYqORjrZh6G8B/n7aczyDTX8jk9/BtcvvDZezSvngx8ctnC/NzwhZf+V99IjJvSD8gBYbaRe9Rs1JxcZjVIzE2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jmMyNUDP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ilqR+KpD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AI6H0UC4107434
	for <linux-wireless@vger.kernel.org>; Tue, 18 Nov 2025 09:35:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/6zb6JppFJxO6FRYEYO9HdXeQ187MTtJfuPUf1xOEa4=; b=jmMyNUDP8UqO92Fx
	PUP+9oiwXkuDq7/5oOqtr4cu0z1HypwepG4zEhXqFSHDofwXby3oebfWjTzcQUvA
	Q+9vJGcrfsfWVsc/qkWtTsDJWy+L2TIGAVjV027JC0ykDAzMEMjPah5fazZ641OO
	cxXEjcxEMCCjoLR1oOkj9x6+I2Kxty+zkwW9k+j8th9jgBy/rq6/FM3TdCvIoaZN
	DxwFboMTprM/uu7nrN8XcpfnTosl5d5nJOCqZyLq9b7uzT3B0dmiZC80/fIm1lNU
	PDzwbXHuNYlI/dxwqHH8CY6WKlCM3qpiotRpv5+AfuX3SxG8sNAEnX4y9+wg7Lkn
	5iatYQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ag2hpbj1k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 18 Nov 2025 09:35:16 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-34385d7c4a7so4952962a91.0
        for <linux-wireless@vger.kernel.org>; Tue, 18 Nov 2025 01:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763458516; x=1764063316; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/6zb6JppFJxO6FRYEYO9HdXeQ187MTtJfuPUf1xOEa4=;
        b=ilqR+KpDL5RMEn/avF75gqk8koOXCtFxNj+4SQBFA2tpRJFN1w3S9+YcULU+vAb3rT
         9FD8IoTjl7vV11VLkLPyDKD0KPzVUKu6VA7ZcNjMnt1vaKxLH03SK1B+eoZchVCWYNkb
         aNQOcLjxnfqkAFolvKDmOW57Yw7lM5duX6IxNlZdL+3P5WPIcBPEvbLTEF/bAtvWG+8/
         FGYYwjUAVGCX4Ash68Go4qMKXMUcd6lzwow8xKdaowhAfX/ZPsBOhL0E4Q09HdwQfZq8
         NU4r32hqX/VC5rfU4jMv0+UlQzGFxsmh4THt6ApLsvjVsEVBdyvndwZJYoEReY9KZYDu
         j2Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763458516; x=1764063316;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/6zb6JppFJxO6FRYEYO9HdXeQ187MTtJfuPUf1xOEa4=;
        b=uR6+XnGZPWDrWL56Mvyk9pUhg4yebW9vg7el0IiFwaysrsYZT9FXgKGQ9SYHgXe+xO
         Z4qIymE2x75gmLt7Z5YEiBPo6FHQL1AHewfImu4vnIBBc9/gU5ItX9B36JaPhW+GgbVK
         tnYVqeGvp/wzI4nnkJNO8WUGnS5pBdlO33m9aqHspdA4+PXVxoiKJMIZ5NWnioG86PyQ
         0odRW+Q+FW1tXGf6Iqsp4kmH3IjMkSvmASdy7Mwpx8A30T0qe9b5daVd2UY1E2SRLwSD
         XPmq1XyAxrwOOOt8o6VgeI6jAtE3C4UXHvGUF/4cxNsOY5mB2+pQV7H7p0pBeZlWkGHe
         9dqg==
X-Gm-Message-State: AOJu0YwrtzL4yIIfp5l8MXfAWrFyFdZXLAoscTlYGzhvgqHQKPRw7Bma
	ihUeou4z3pjax1oVpB61cle4DOz2L+PKf73N1MkubINHjlcsnaeC2A13pw16Lu4XBmjcbgSt4nl
	gQbpFa6CUDKqQB9HNGxF+BCtvEe7UO2gyqrHFWIS4IeWbQ3AhMSUodMY4RQ5P6F3Cx9EBOQ==
X-Gm-Gg: ASbGncvYwFb7/GFarofvvLd606EagTJiuGBYCGKRNrzCSyx8wu2YP6yO/TfCXWkNlr5
	AnDAP16oqRemJWcz3kvn97TUFcNrK3piC72Dj/HaYdRUQ4JrbytD0a4FrzGjxybc0w9B1eaoDOD
	DnBX9igcCH9TC4I8Pg2baIz75Fw9k0VprfmGO9KlEP6BnFWsblHsfgPk6e5vW5EPzJPqNxdLtLr
	O58IXrLTDUcgAXdoGL6FyPIiZiRQFPLPWqvwxlrqjt1otVFEzYLKJPLccwzQ4NgyO3UKynVwvlG
	+a8zKGnx6cXzPQTxwV6F2Rmlq3054glthD4l7PK8wsqibXKcQiRY2iNT0fXK89sxYp3LgDpXlDU
	kc8CKJ8nDIkEVg0LUdEt1kD6IhkFp3aF6P59dPeKCE0a4rtRlQgGp3L/nKnZrlJdpV3eRp3os
X-Received: by 2002:a17:90b:4b04:b0:343:60ab:ca95 with SMTP id 98e67ed59e1d1-345aebc9e75mr2507425a91.5.1763458515900;
        Tue, 18 Nov 2025 01:35:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGXRcxvWrlmHpBONzXrlYlYFm6xtDX6uutpSIyn78ZyHZr24J+xzPC5IkbKduQHNL3L233EVw==
X-Received: by 2002:a17:90b:4b04:b0:343:60ab:ca95 with SMTP id 98e67ed59e1d1-345aebc9e75mr2507380a91.5.1763458515374;
        Tue, 18 Nov 2025 01:35:15 -0800 (PST)
Received: from [10.133.33.104] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-343e06fe537sm21110853a91.2.2025.11.18.01.35.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Nov 2025 01:35:15 -0800 (PST)
Message-ID: <5a308d21-d463-4d6f-b5d3-95a0c2ede2c1@oss.qualcomm.com>
Date: Tue, 18 Nov 2025 17:35:09 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: fix endianness handling for SRNG ring
 pointer accesses
To: Alexander Wilhelm <alexander.wilhelm@westermo.com>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20251118072123.19355-1-alexander.wilhelm@westermo.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20251118072123.19355-1-alexander.wilhelm@westermo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 5OmUBfCtyfBupzQgsgkvgG1D0LjzqPXt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE4MDA3NSBTYWx0ZWRfX6H8Lrs6opJ8R
 Ht/01g/SEVrrQ3ci0LDF4tfvuwWx+5WMT0EfEAZebMpxqNNEoKoXrwP+bYvgIPOtpJd7E4BLuAA
 R0OIMp9ZHEWS+ts/vP7qHup/WUQGHzAJqD73gcrOopqBtWSI+zaCvaz9yGdR6hlD5ES5Cwnz6su
 8g2gX3lhsLshsSsuD/o+Is0W3g2Eh2m6AfRrKIF5howtEri8niS/l1OeVycQB2K13ppbjIUdE96
 w5OERzo8gb5KxkauOgZwGROCn+KbAZTLVSTnTPC/seN1f6f9OEsn/lsfMOjCgZTkd/9rRBDxEvw
 49bULDyCtbR3MyQpMe7N9oNLHM6I29YzONArKLM1NgMEK6F1yjCwg/9XjWggCDIZ9etMkpGyR+K
 lepSoB6bbEUzncj/JoVllgB7U6HDNA==
X-Proofpoint-ORIG-GUID: 5OmUBfCtyfBupzQgsgkvgG1D0LjzqPXt
X-Authority-Analysis: v=2.4 cv=Y5L1cxeN c=1 sm=1 tr=0 ts=691c3dd5 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=N9GNhs4bAAAA:8 a=Sty9O8k4TDZ2vQ3Klh0A:9
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22 a=PZhj9NlD-CKO8hVp7yCs:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_04,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 malwarescore=0 impostorscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511180075



On 11/18/2025 3:21 PM, Alexander Wilhelm wrote:
> The SRNG head and tail ring pointers are stored in device memory as
> little-endian values. On big-endian systems, direct dereferencing of these
> pointers leads to incorrect values being read or written, causing ring
> management issues and potentially breaking data flow.
> 
> This patch ensures all accesses to SRNG ring pointers use the appropriate
> endianness conversions. This affects both read and write paths for source
> and destination rings, as well as debug output. The changes guarantee
> correct operation on both little- and big-endian architectures.
> 
> Signed-off-by: Alexander Wilhelm <alexander.wilhelm@westermo.com>
> ---
>  drivers/net/wireless/ath/ath12k/hal.c | 35 +++++++++++++++------------
>  1 file changed, 20 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/hal.c b/drivers/net/wireless/ath/ath12k/hal.c
> index 6406fcf5d69f..bd4d1de9eb1a 100644
> --- a/drivers/net/wireless/ath/ath12k/hal.c
> +++ b/drivers/net/wireless/ath/ath12k/hal.c
> @@ -2007,7 +2007,7 @@ int ath12k_hal_srng_dst_num_free(struct ath12k_base *ab, struct hal_srng *srng,
>  	tp = srng->u.dst_ring.tp;
>  
>  	if (sync_hw_ptr) {
> -		hp = *srng->u.dst_ring.hp_addr;
> +		hp = le32_to_cpu(*srng->u.dst_ring.hp_addr);

should we also need to change its type to '__le32 *'?

>  		srng->u.dst_ring.cached_hp = hp;
>  	} else {
>  		hp = srng->u.dst_ring.cached_hp;
> @@ -2030,7 +2030,7 @@ int ath12k_hal_srng_src_num_free(struct ath12k_base *ab, struct hal_srng *srng,
>  	hp = srng->u.src_ring.hp;
>  
>  	if (sync_hw_ptr) {
> -		tp = *srng->u.src_ring.tp_addr;
> +		tp = le32_to_cpu(*srng->u.src_ring.tp_addr);
>  		srng->u.src_ring.cached_tp = tp;
>  	} else {
>  		tp = srng->u.src_ring.cached_tp;
> @@ -2149,9 +2149,9 @@ void ath12k_hal_srng_access_begin(struct ath12k_base *ab, struct hal_srng *srng)
>  
>  	if (srng->ring_dir == HAL_SRNG_DIR_SRC) {
>  		srng->u.src_ring.cached_tp =
> -			*(volatile u32 *)srng->u.src_ring.tp_addr;
> +			le32_to_cpu(*(volatile u32 *)srng->u.src_ring.tp_addr);
>  	} else {
> -		hp = READ_ONCE(*srng->u.dst_ring.hp_addr);
> +		hp = le32_to_cpu(READ_ONCE(*srng->u.dst_ring.hp_addr));
>  
>  		if (hp != srng->u.dst_ring.cached_hp) {
>  			srng->u.dst_ring.cached_hp = hp;
> @@ -2175,25 +2175,28 @@ void ath12k_hal_srng_access_end(struct ath12k_base *ab, struct hal_srng *srng)
>  		 * hence written to a shared memory location that is read by FW
>  		 */
>  		if (srng->ring_dir == HAL_SRNG_DIR_SRC) {
> -			srng->u.src_ring.last_tp =
> -				*(volatile u32 *)srng->u.src_ring.tp_addr;
> +			srng->u.src_ring.last_tp = le32_to_cpu(
> +				*(volatile u32 *)srng->u.src_ring.tp_addr);
>  			/* Make sure descriptor is written before updating the
>  			 * head pointer.
>  			 */
>  			dma_wmb();
> -			WRITE_ONCE(*srng->u.src_ring.hp_addr, srng->u.src_ring.hp);
> +			WRITE_ONCE(*srng->u.src_ring.hp_addr,
> +				   cpu_to_le32(srng->u.src_ring.hp));
>  		} else {
> -			srng->u.dst_ring.last_hp = *srng->u.dst_ring.hp_addr;
> +			srng->u.dst_ring.last_hp =
> +				le32_to_cpu(*srng->u.dst_ring.hp_addr);
>  			/* Make sure descriptor is read before updating the
>  			 * tail pointer.
>  			 */
>  			dma_mb();
> -			WRITE_ONCE(*srng->u.dst_ring.tp_addr, srng->u.dst_ring.tp);
> +			WRITE_ONCE(*srng->u.dst_ring.tp_addr,
> +				   cpu_to_le32(srng->u.dst_ring.tp));
>  		}
>  	} else {
>  		if (srng->ring_dir == HAL_SRNG_DIR_SRC) {
> -			srng->u.src_ring.last_tp =
> -				*(volatile u32 *)srng->u.src_ring.tp_addr;
> +			srng->u.src_ring.last_tp = le32_to_cpu(
> +				*(volatile u32 *)srng->u.src_ring.tp_addr);
>  			/* Assume implementation use an MMIO write accessor
>  			 * which has the required wmb() so that the descriptor
>  			 * is written before the updating the head pointer.
> @@ -2203,7 +2206,8 @@ void ath12k_hal_srng_access_end(struct ath12k_base *ab, struct hal_srng *srng)
>  					   (unsigned long)ab->mem,
>  					   srng->u.src_ring.hp);
>  		} else {
> -			srng->u.dst_ring.last_hp = *srng->u.dst_ring.hp_addr;
> +			srng->u.dst_ring.last_hp =
> +				le32_to_cpu(*srng->u.dst_ring.hp_addr);
>  			/* Make sure descriptor is read before updating the
>  			 * tail pointer.
>  			 */
> @@ -2547,7 +2551,7 @@ void ath12k_hal_srng_shadow_update_hp_tp(struct ath12k_base *ab,
>  	 * HP only when then ring isn't' empty.
>  	 */
>  	if (srng->ring_dir == HAL_SRNG_DIR_SRC &&
> -	    *srng->u.src_ring.tp_addr != srng->u.src_ring.hp)
> +	    le32_to_cpu(*srng->u.src_ring.tp_addr) != srng->u.src_ring.hp)
>  		ath12k_hal_srng_access_end(ab, srng);
>  }
>  
> @@ -2648,14 +2652,15 @@ void ath12k_hal_dump_srng_stats(struct ath12k_base *ab)
>  				   "src srng id %u hp %u, reap_hp %u, cur tp %u, cached tp %u last tp %u napi processed before %ums\n",
>  				   srng->ring_id, srng->u.src_ring.hp,
>  				   srng->u.src_ring.reap_hp,
> -				   *srng->u.src_ring.tp_addr, srng->u.src_ring.cached_tp,
> +				   __le32_to_cpu(*srng->u.src_ring.tp_addr),
> +				   srng->u.src_ring.cached_tp,
>  				   srng->u.src_ring.last_tp,
>  				   jiffies_to_msecs(jiffies - srng->timestamp));
>  		else if (srng->ring_dir == HAL_SRNG_DIR_DST)
>  			ath12k_err(ab,
>  				   "dst srng id %u tp %u, cur hp %u, cached hp %u last hp %u napi processed before %ums\n",
>  				   srng->ring_id, srng->u.dst_ring.tp,
> -				   *srng->u.dst_ring.hp_addr,
> +				   __le32_to_cpu(*srng->u.dst_ring.hp_addr),

why __le32_to_cpu() only in logging, while le32_to_cpu() elsewhere?

>  				   srng->u.dst_ring.cached_hp,
>  				   srng->u.dst_ring.last_hp,
>  				   jiffies_to_msecs(jiffies - srng->timestamp));
> 
> base-commit: be83ff7549057d184b693a85cafc10fbd520f3d7

