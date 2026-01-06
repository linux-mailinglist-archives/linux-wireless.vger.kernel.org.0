Return-Path: <linux-wireless+bounces-30380-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E65CF686C
	for <lists+linux-wireless@lfdr.de>; Tue, 06 Jan 2026 03:55:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E655F3008761
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Jan 2026 02:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 686E41A256E;
	Tue,  6 Jan 2026 02:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KEUOHeOW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jEx29UmG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11EA224AF9
	for <linux-wireless@vger.kernel.org>; Tue,  6 Jan 2026 02:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767668127; cv=none; b=doNi6aqLQ4/24P9XQ5ltHdkwi4vECWtRhnSYu8WR5W6Qt53IKSP1Prt1FuSXBIbzKqNQv3k2riRcvN3toyCzsLYApTibrkwOuDUyjtZ8Z6vnK2zbJdvh5Lz7h+b0Mdk4KhZLVsIjGYhaPDpcA6JUwdl+wEPL9s2AiFAf/0ncYKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767668127; c=relaxed/simple;
	bh=e+bHD5TKtbpywM0stm8uonBloPKJPmN4SpJbj/PrQJI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OzW8agpjV/PAbdDC/hqrXPDc8gNMF27wxRaMyvULtTDwsN106hDwjZ0+KKWsDcVJSvcel2DvXrhwNsNSC52UUMpOzp7dwqxo14GRe5EN4iGnK3JOSh4anIgh8lGDuAPuw/1ey8Z5PJHpJCqOkCco0VW+aF6tUst9npZ8Asge878=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KEUOHeOW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jEx29UmG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6060nU5P2943763
	for <linux-wireless@vger.kernel.org>; Tue, 6 Jan 2026 02:55:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jeK2FlfxI96cOkTAnGRDcPuRUDyzWVMyyzk3ooH1how=; b=KEUOHeOW7w22wUh6
	/835hD5eNA5LZRwFgs0e5XSrclQoade/N+Om6uliJAR6A4Zd9BiGWZBomu3Si3w6
	EdUrLW31fMr/3d8J8h24J1qyvre1BVMZd3u88fLZ8pyMIE6aHwKVWQhGoRL13Lzz
	gNCDlr+Z7j+xZCnGTapVL0wjKmswuJI1CqJNqdlDVg1hQXgYkz9Z0Rf2ziZk0DJx
	dwVX07lJJF7W3Ec23w5mW17QSACvLRLtYX4yq8ZuntTZ55FWj66KY2Tn8S5xkObP
	+r37+5T2eWzuX/qwP39Zft5LW+trL1uehUMwXFE0CrggPp89FDpj4W+7oVoIwH5V
	ABgDnw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bgfv01qdj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 06 Jan 2026 02:55:25 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2a0a8c465c1so15216385ad.1
        for <linux-wireless@vger.kernel.org>; Mon, 05 Jan 2026 18:55:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767668124; x=1768272924; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jeK2FlfxI96cOkTAnGRDcPuRUDyzWVMyyzk3ooH1how=;
        b=jEx29UmGS1YeZ+/IWMM5Vx0YoVG3uK3ivXsFVF8rFrsTny/Sc1oefqEUTn9gWuao16
         NVubKoeKBpZQaKeureyZi2TdjjHLpwI6HpKcTtm9gF/jXOshwwl0gSLB3zPNIssbeSV/
         UhRmn/5GK/z0XDOUiLyI5pSLgx7g1h1KmbXhuiW2WM5CyNXc15eFR1rfsk01dl1Q8FlA
         ui8Yt2IsH6oKdwzgrIzzh0UajSBeN65+B+skOmFBdKuzqzhEDVCjJHsvQWBb2oHs23vu
         Bz1K0RfpUF9mYOSrqoLEVZg/vQnme2J304A+bNt9bAPnf3hWl6QxY5t0Ap/vXXt2pAyk
         IUow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767668124; x=1768272924;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jeK2FlfxI96cOkTAnGRDcPuRUDyzWVMyyzk3ooH1how=;
        b=o45xeNGwAoT2FDfuAJoWIu9HD3n7+g3bsh6sMJQlY0yxa8rZHlb3u5rr7gTbdcsB+r
         iPxfxRAsElKHfEk7Ji4Nu1E5TRqyNf3yTOoFlQzwOM0gog2OmNN3IQmgNVomDs49t3PS
         07MpTLGiVsIX25So5lmFhDwBYnEvA+rTffJ8kbn7md3rrjVlA5yGj448UpR8Mfr6SQfz
         h06+8u2MNTyJLONYtdSVAqcDeTOuf9wN71YlhgiF4Ptpg0WssKsDK/400P5jvpozEROb
         TcGuJ944jZqVBSdSGUWwdD1iGW1kHdEwewmmC8djkXSO7Gh++qY/LpYY219I1vZzo/gJ
         m9gQ==
X-Forwarded-Encrypted: i=1; AJvYcCWepo0yz6ShjRLdbxgCkvmxeXPQXVAI7hyoHyboA9eysJJ6HuItFkg2XzhogUDEXihL6P8GmEpKyLFadN94dw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyS/jmuN5KeD8fwGWoF210As2gPzaX839ic+4uVA2/sfDPmSLNx
	x2eF4Y1aqItCv5i9tB3GE99YxHv/pMsTaUKuqCBdp3CHwdsIOfkcKVRpEpsumfzebxI8J8Rgo1R
	jcBAcBBQV8eObvPDp/pYzTPiC2qBKaqd3HPus+ctW/z4+K9R9Dx4CYLxIUdq4TSvejKjzpQ==
X-Gm-Gg: AY/fxX6w42m3CDAA7RSVhKDkHokpfF+8pIWtW6ewou7Hwl0exeEvw2ZgKlUjzPrUPBg
	Bfu5plh4nQCGS1YG93zOCBCg2x62MnSrSC3cdNdc+l1DZfp848oHkX/bx9+hwhshIoyBQqwlzoz
	hJ7/9XxfaUBZt5MrNPTJodsCAPUD/AGKBbhdECPspuIRrJWSEz3XpIsnmp8e0PGgmjCdgHmlPma
	4vsX94sXSxhnI6LAAdzWmcAFPdony/EgH54Re9oAwywPobm+CV0+72bcSoidQawNu80fuJo/4oC
	+tthzgrTLEhjQpdQzWwsmuEbTzsLQktg9zqymzCJNIiR3MORcl6FBF9eQMc4Ffv8ybMrdEDoZ4A
	B9zSiHiZ/uWYuiv3ECz879IZBv9AacpJ4CABJ0ITBSTIueDZVARWcXFK6XqAT4oTnrvx0taRGe5
	+rrY1vzg==
X-Received: by 2002:a17:902:c40c:b0:29e:e5e6:247c with SMTP id d9443c01a7336-2a3e39d82bdmr10652415ad.14.1767668124321;
        Mon, 05 Jan 2026 18:55:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEm+epUO5voVQquz6sVBvYJuUN550AnDeQ2R3i6J+Q6+wFvDH9JwAks/rShsvT3f0wEY+uGtg==
X-Received: by 2002:a17:902:c40c:b0:29e:e5e6:247c with SMTP id d9443c01a7336-2a3e39d82bdmr10652225ad.14.1767668123882;
        Mon, 05 Jan 2026 18:55:23 -0800 (PST)
Received: from [10.133.33.54] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cd4be5sm5391245ad.99.2026.01.05.18.55.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jan 2026 18:55:23 -0800 (PST)
Message-ID: <ccba2a0b-3312-4a49-8de3-1601fa95d10f@oss.qualcomm.com>
Date: Tue, 6 Jan 2026 10:55:20 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] wifi: ath10k: fix dma_free_coherent() pointer
To: Thomas Fourier <fourier.thomas@gmail.com>
Cc: stable@vger.kernel.org, Jeff Johnson <jjohnson@kernel.org>,
        Kalle Valo <kvalo@qca.qualcomm.com>,
        Govind Singh
 <govinds@qti.qualcomm.com>,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20260105210439.20131-2-fourier.thomas@gmail.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260105210439.20131-2-fourier.thomas@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=e9YLiKp/ c=1 sm=1 tr=0 ts=695c799d cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=sJ90gTr51a4L_-UUfAIA:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: i5InsHMNW7O0DP_ySoCTDXb8YQFYnbHB
X-Proofpoint-ORIG-GUID: i5InsHMNW7O0DP_ySoCTDXb8YQFYnbHB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDAyMyBTYWx0ZWRfX719rRfqwzjLN
 41FhNxYqvb7yqXH2AzCwV2iDACFaH1ubFrKAJMI3odUcfvKrDtTfo2yyRWyZrx+jFcdwkYOPt8x
 TxYPtV12R5e9uEMNMkUOTVfWT8ck/97H4dRcjPBOL7s9+8s7ruV8HeMoYOGEsJ6aNi+uI3arwKs
 HJZylWhaORLAebSgwHoGRgB9o45dcd7TeXNfsW7i1ZFGEYeGAG6AEhD9nUA20/mpm2eClq1FirV
 nAPDJn7hq9TCUCeNR4pi7HCT0YtvfPSFU+PLKllh7r18eEy+j9lCS1k2HONi1MgULWDgN6UpSBd
 nIXsOBfYbk2elPXrfpkTPPxhj8EkMXOm9rrPB+iwJtksb0AZEH30PpqOSZnOBfIPGEwTxrRaUmW
 q0hrpbcoUoUOtxLa6MPfwm0m7KlpSJNqewLHjLq/mfb9gufejMvMRVURcqubTIreXAiBp+xe4MA
 E2VLhG3JpqroRyH7Biw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_02,2026-01-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601060023



On 1/6/2026 5:04 AM, Thomas Fourier wrote:
> dma_alloc_coherent() allocates a DMA mapped buffer and stores the
> addresses in XXX_unaligned fields.  Those should be reused when freeing
> the buffer rather than the aligned addresses.
> 
> Fixes: 2a1e1ad3fd37 ("ath10k: Add support for 64 bit ce descriptor")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>

> ---
>  drivers/net/wireless/ath/ath10k/ce.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath10k/ce.c b/drivers/net/wireless/ath/ath10k/ce.c
> index 7bbda46cfd93..82f120ee1c66 100644
> --- a/drivers/net/wireless/ath/ath10k/ce.c
> +++ b/drivers/net/wireless/ath/ath10k/ce.c
> @@ -1727,8 +1727,8 @@ static void _ath10k_ce_free_pipe(struct ath10k *ar, int ce_id)
>  				  (ce_state->src_ring->nentries *
>  				   sizeof(struct ce_desc) +
>  				   CE_DESC_RING_ALIGN),
> -				  ce_state->src_ring->base_addr_owner_space,
> -				  ce_state->src_ring->base_addr_ce_space);
> +				  ce_state->src_ring->base_addr_owner_space_unaligned,
> +				  ce_state->src_ring->base_addr_ce_space_unaligned);
>  		kfree(ce_state->src_ring);
>  	}
>  
> @@ -1737,8 +1737,8 @@ static void _ath10k_ce_free_pipe(struct ath10k *ar, int ce_id)
>  				  (ce_state->dest_ring->nentries *
>  				   sizeof(struct ce_desc) +
>  				   CE_DESC_RING_ALIGN),
> -				  ce_state->dest_ring->base_addr_owner_space,
> -				  ce_state->dest_ring->base_addr_ce_space);
> +				  ce_state->dest_ring->base_addr_owner_space_unaligned,
> +				  ce_state->dest_ring->base_addr_ce_space_unaligned);
>  		kfree(ce_state->dest_ring);
>  	}
>  
> @@ -1758,8 +1758,8 @@ static void _ath10k_ce_free_pipe_64(struct ath10k *ar, int ce_id)
>  				  (ce_state->src_ring->nentries *
>  				   sizeof(struct ce_desc_64) +
>  				   CE_DESC_RING_ALIGN),
> -				  ce_state->src_ring->base_addr_owner_space,
> -				  ce_state->src_ring->base_addr_ce_space);
> +				  ce_state->src_ring->base_addr_owner_space_unaligned,
> +				  ce_state->src_ring->base_addr_ce_space_unaligned);
>  		kfree(ce_state->src_ring);
>  	}
>  
> @@ -1768,8 +1768,8 @@ static void _ath10k_ce_free_pipe_64(struct ath10k *ar, int ce_id)
>  				  (ce_state->dest_ring->nentries *
>  				   sizeof(struct ce_desc_64) +
>  				   CE_DESC_RING_ALIGN),
> -				  ce_state->dest_ring->base_addr_owner_space,
> -				  ce_state->dest_ring->base_addr_ce_space);
> +				  ce_state->dest_ring->base_addr_owner_space_unaligned,
> +				  ce_state->dest_ring->base_addr_ce_space_unaligned);
>  		kfree(ce_state->dest_ring);
>  	}
>  

seems ath12k has the same issue, would you like to fix it as well?



