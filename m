Return-Path: <linux-wireless+bounces-29095-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D7732C68E1F
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Nov 2025 11:43:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BAAE54E3986
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Nov 2025 10:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E121A348890;
	Tue, 18 Nov 2025 10:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="b/cmdy7D";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Buy4ORZB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328F2347FFE
	for <linux-wireless@vger.kernel.org>; Tue, 18 Nov 2025 10:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763462633; cv=none; b=u/b6u4Kz8YS2M86lLlSrHxLNPGjDBQNdPRowudHrXSgYJ06XOH6Nr95AZIGwoF0A2lmVOnotvp1ZoGYR7/tYXMF6Y9BqUxOFRddEW5RQM2Xe275twLI7u6fYQzc0WnkzvGDZqTmMnKeRVtXK9QjLCeopC/6H7llyi59FbMMB+MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763462633; c=relaxed/simple;
	bh=tENST+nVLk89mmojjPZ2XJRbT4P1pTDDW/ED/5gZbGY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WLPyp/w9/qQHbNbX7vIkf6Qi1A9kdatDX0rENOJKAryvBoMYLqmHHuwyQFIaSvtxLMUtD6QJeiPoMjFc4CBfdTFeu+FGFoHa5S8MdfWTlADFSYvymGiOgQkgaz4UDX9l3NJTwd9eMYz+pGmio8XxyR7If1yJmDvFTUK/bTVr3sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=b/cmdy7D; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Buy4ORZB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AI6Sxpm386625
	for <linux-wireless@vger.kernel.org>; Tue, 18 Nov 2025 10:43:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EWtgEKnbNZVUqCn3Q1oQ0EkBhxhseGeL81G9QqvOhIA=; b=b/cmdy7DXB0/w/h/
	OXQgtc/bCZ7XscGz8DQdNP44CgNN/TldhxkEpNnzWNzQ3g61Fehsxk6U7v3/Z3SZ
	EN0uYE1HtnMgYMJzKeOIvy0Q/s8w/hkO5k31UEs7R6C+pbUJTy/Yziy7Li8KXtOj
	+qY8fXLb9jPrhoeyvbT+CC2Gjw1y9Y/1bPtgmFlhgVXJUWZEixSASQ+yw4ESPybZ
	s9ioBOh0Y8uFpuCbscm1eW+iulQe4V7OyCxyTWSRF0zO6HZPZDKF59Ttifixxucg
	HYTI2EjU3R4nxaqh4sjU4KFj5zw1yDtx/jUaNgX2SENcb7S696tk7pi6JA4h/zMh
	XnsaYQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4agag8j5tk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 18 Nov 2025 10:43:51 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-297f3710070so101960925ad.2
        for <linux-wireless@vger.kernel.org>; Tue, 18 Nov 2025 02:43:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763462631; x=1764067431; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EWtgEKnbNZVUqCn3Q1oQ0EkBhxhseGeL81G9QqvOhIA=;
        b=Buy4ORZBHYys2XJvTfwB3zLtY1g1NsHQvm1xHClFDZoQ4f1CnGySLagGiq/ybwFgnd
         yzp3Ay3I/0zAKNuT37Ey3oWsZxQT6SnPtsJknW7xcByjbAlbVVVAlApDqh3UUyZYGCAT
         mwBaIwgn1oNFItFw9sw6pHlkOXse7exCIIKm1AejCqeecTq6wTaCGbTDWfwTm4YNjZiw
         vMDYo0EZeOHvFq7+QNVvCwazW/uTcl1RLeMGwOWlo6VXzhB2AWfhoG/zH2IRrDzhxAHZ
         KerSxkCC9s7mJj5QxhA2I1mHq6beO0yb6hhJWOXdKhLKYwpmEzq4lVma1HEFuVpQdsw6
         VdrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763462631; x=1764067431;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EWtgEKnbNZVUqCn3Q1oQ0EkBhxhseGeL81G9QqvOhIA=;
        b=jXBGsZ9n21iQWiWSreL+QIxn9DMYt2KeerWHxMzcJdQD4Q4rjaA9uZbK4kYjt/gnpK
         sYWOHVwzhSqKYLKbFvPAyDEb7RDc/ExQI/dsWLbNawlN6EOvqUPOKYdBpdUm85tKvAw3
         snOU2WtyH9K08fzBeOupw01zlJVWfgLvSHEq8hAcxQu836Pf9duGS9E9ydNguDTx/+j1
         x9OBaH519tX3b2dNRoEDHZo97+kpQ0PiXKnxh6nMJ6n1RKpZfAj6Y7WSYvRInRAj6Jgh
         5nB7HcDhU3f5q7eskNC85ly8XjZqmV/uIc72s9su8rMoZCwXOyTfRHmk80aYwCknb7jl
         Qlmw==
X-Gm-Message-State: AOJu0YwmEWyFF1WZOdfDR0nUAmN4RAHZTX/j/E8SvoSpHgXavaQUjpcu
	qa8OQhqla0GVQDV875ctASqXmufWypntsJpi9G71bjI3tCDZf3FjcA82LW7bGqzK7uTWVFOI+Lx
	rzmWQy9N+zF5k8P0+kE10sM2lKrnkTXQ6jGzTCJ/cimuwI9Va96S2NjM5/v5KrciJebLLRg==
X-Gm-Gg: ASbGncsFjcFIDlLADhRjX2sahQ3VSY4zLOXlpkCg/PF+FO6Jna4Iz3YTdlY4LhAZC3d
	B348owJDYPJDLO3KSiRyFA3yAbDc+jf0n8GhDPFFOXYLBTEYTn1i9rhD3FT8/oAjBcPYqNMZjPe
	0F5u3Up1o7yPFOm9ScitagcoHUAaTzp9l0pcGTe20PDKYlbqO7n7MAG8mBiSJ2MGLIkDMXjX8JF
	75NuaTNo8gBn3YBX1JcpqNaPA215IgN7VPARq0SMQw8UFzCabUCGW4D7sGMcdjce7IfOXgw+EsL
	jJB8G/xRsaqpLMtRJ7W+5GPOkiFsGFC7QCC2yuupjXUD+IX02J2+2Eb38S27wwBkiUe5hDi/bRm
	bjAMHnYm7kD3jSOZpXTCqSpBo9lwqz/vAmT0Te6BJEB1nN+fDlReCaqPZPwt7W728/aLR3vCI
X-Received: by 2002:a17:902:daca:b0:294:9813:4512 with SMTP id d9443c01a7336-2986a6ba40bmr210931945ad.3.1763462630684;
        Tue, 18 Nov 2025 02:43:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHRAhNCasizUkhZoGF5GqKPsHRAVDxhAtHyi3C5yJ9JopQ/Tb8UtFkOEqjhzBPNxQ+P5rz52Q==
X-Received: by 2002:a17:902:daca:b0:294:9813:4512 with SMTP id d9443c01a7336-2986a6ba40bmr210931625ad.3.1763462630156;
        Tue, 18 Nov 2025 02:43:50 -0800 (PST)
Received: from [10.133.33.104] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2346e6sm167341515ad.22.2025.11.18.02.43.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Nov 2025 02:43:49 -0800 (PST)
Message-ID: <25dc40e9-6fe6-4e8d-b767-02f8a304e1ca@oss.qualcomm.com>
Date: Tue, 18 Nov 2025 18:43:44 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: ath12k: fix endianness handling for SRNG ring
 pointer accesses
To: Alexander Wilhelm <alexander.wilhelm@westermo.com>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20251118101723.69279-1-alexander.wilhelm@westermo.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20251118101723.69279-1-alexander.wilhelm@westermo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: GfsuQaxGBtAwG23yaMBCGJtCvbJixv7c
X-Proofpoint-ORIG-GUID: GfsuQaxGBtAwG23yaMBCGJtCvbJixv7c
X-Authority-Analysis: v=2.4 cv=G6sR0tk5 c=1 sm=1 tr=0 ts=691c4de7 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=N9GNhs4bAAAA:8 a=kv6mMmUb4GUwrkqO6qEA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22 a=PZhj9NlD-CKO8hVp7yCs:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE4MDA4NSBTYWx0ZWRfX3jGscfJ+w0EP
 5w1l5AwhS8/hJyL2gJds8wwFCnchSXXK1GQh5Hgd53866RpUmoQG3+lhwr8Ad4Nm6JLu4zwzjQe
 RcYhvPlXE51mGPlib6IzObpA3fQ4f6qm7sJhiq4fXHCq+lX2wApQFr3G+8/9uAxLAXt+DhVjPJG
 T0N7t2/+wei8I7n0Di6CEAAb7R/6sNDEqf5wRsRKZ1Qe6TIxiX0Nk2pjAXfyMUTz+NfuKaA6LsV
 c3d8WV72O9QPZeBLsy14b290R4RrOsEXQ1udizH0dgWoQahmJzx//JFZzzGtu8mEqre8hjhmqY+
 Kf9AamhBAuTdgnNp6LfPFw8eABe1Hxcv5+II0kBKjORawioEVUPVzcFUKtA0LR+U1fUccwPsHYA
 esZsgfVuhP2/VXIEh3nYML9cQO+lbg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_04,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 malwarescore=0 adultscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511180085



On 11/18/2025 6:17 PM, Alexander Wilhelm wrote:
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
> Changes in v2:
> - Set '__le32 *' type for 'hp_addr/tp_addr' in both 'dst_ring' and 'src_ring'
> ---
>  drivers/net/wireless/ath/ath12k/hal.c | 35 +++++++++++++++------------
>  drivers/net/wireless/ath/ath12k/hal.h |  8 +++---
>  2 files changed, 24 insertions(+), 19 deletions(-)
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

s/volatile u32 */volatile __le32 */ ?

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

s/volatile u32 */volatile __le32 */ ?

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

s/volatile u32 */volatile __le32 */ ?

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

still my v1 comment does not get addressed:


why __le32_to_cpu() only in logging, while le32_to_cpu() elsewhere?

>  				   srng->u.dst_ring.cached_hp,
>  				   srng->u.dst_ring.last_hp,
>  				   jiffies_to_msecs(jiffies - srng->timestamp));

