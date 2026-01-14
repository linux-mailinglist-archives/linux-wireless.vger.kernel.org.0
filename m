Return-Path: <linux-wireless+bounces-30823-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC12D1FF51
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jan 2026 16:53:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 965F730012DB
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jan 2026 15:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D04E139B493;
	Wed, 14 Jan 2026 15:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AUXfQFux";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IjJ8TYB6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF0B399A60
	for <linux-wireless@vger.kernel.org>; Wed, 14 Jan 2026 15:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768405992; cv=none; b=B8UC6MGSVBAP4lO2QVMjJYdOfNhQoYQejh4fnRyHFsE3kNor1/E8EfK7+W4xaYQSby9tr/185yHj5sEV02NhJeZVm85oApWw70K8VxDPiYzELYeS21d+fz44RfhVViM6DjG9tIGnZ/q5fBn+xCi6wf2zFr9X5gA3PF4+mWZWcR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768405992; c=relaxed/simple;
	bh=MD3Q/eKA8Bg2nYkxvuGRiHO71JFcoHURut/25DxpxpE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pqfK0A0ygmJmCrQ+I/EvvlwZ1goqx6A0iQEO7GXNZNw5QfKCkACKIm1uVCxrRxQKWtAaZf82+2/11oyxS4EfQSZJmWseTnxX2MsBqI/4Eh4x7eKaeLl6+oO6z9p/frKX+8Whvl+iQvz9faRJsUGXIosvagRa6I8tmHop+IA4zC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AUXfQFux; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IjJ8TYB6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60EFNdXh1943035
	for <linux-wireless@vger.kernel.org>; Wed, 14 Jan 2026 15:53:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MzzHnWe4mjqtiAA9/E5M6TfbY0kOzCmUNRbO5q8s3ag=; b=AUXfQFuxzPsHLsEL
	+llFNA7pRNFgKGWQK2iJT0As7oIuZcM1DIIP8f9mmHrbO41ZvFGukzl730UK9D3x
	pwn/DsuD/bLYDsHsmiEcKyHLCeG38EPO8ACWdiy38G1+9i+t2JH+kZGGa1wFicfG
	BFp94Lm2Vz9TAlkflm6iHokYuXYgD5NIgyMyhueDHurFso3dPOnNK0J2Su28Lp5q
	3pZqItCiGgNSLyIIrFyruf3z5VVrvt8haaZMSuYPlTqS2U2V4zVmgcg++72z00xi
	XFA1bh3bmGmf+PtxhhDRlp8Izgvo+7qE1hXSBc6oXobLZkA+diV6MLJC+XoaGEJq
	pYXWeA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bp7b6sn5s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 14 Jan 2026 15:53:10 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2b04f8c5e84so10302576eec.1
        for <linux-wireless@vger.kernel.org>; Wed, 14 Jan 2026 07:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768405989; x=1769010789; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MzzHnWe4mjqtiAA9/E5M6TfbY0kOzCmUNRbO5q8s3ag=;
        b=IjJ8TYB6ndvX0edf+St4vQqb496HTKHGpx0rfqxcvo3w0KnW/4ZOzFfGzz2UaPZTzH
         j/KJwCr6Rf4roGMXNKOcwQhJPGIF0SUEvCMankJPMJ+chj75zBfuQ8FDUigDCxddFogF
         bemfiEcDSsP3i27iQuT2jw1dcL/Eu83VU1Ou4nRBIsRwJwfz5g+rE5dXzKukcuCicM+R
         GOQy7kuB89oHyZanGwS3+1iWFMFhduefrSYMX104AE9HNJSheLH1N6lu/GrNnxRiB5d0
         tEMbnVQGKhZY4K5mROTRUMx71MvznMGpiWlsHhVQPrbdz8NCyoPaaRdG8UFqdsfb7XaF
         vLHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768405989; x=1769010789;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MzzHnWe4mjqtiAA9/E5M6TfbY0kOzCmUNRbO5q8s3ag=;
        b=O5E9hxxU8omtZtehYosgSSVufAnT5okUDzThGMGaZ8EprwhLVmtT08cSSCPySs87CS
         jltDi+iPUIu080F2ssx+cyxe7wqkhl/qkd5x4tHAFTORfvB+xZ9IsSL5xty3qCeowQcC
         jbOZY8vd5ccXGn5WYfGiRZImdqqN8LLs5q8MvcxDl5EeBOBhaBs/MgcNeRB7pGqrSvur
         kHs+pCd7VrVreLpRfKii124OshPvecIoHJNbUoL7p9W2KPBbGIA7+6jmoBSBNAU9nLg8
         1KeeNqhY5NlHhTSTonkacNI4tbvQY5kg6n3qWOvnZbbyCCMTI3Q6YkDl0ZPN9LqteqHr
         tW6g==
X-Forwarded-Encrypted: i=1; AJvYcCXE6TwbhAAt3colQjPqodMRz+co+7mt1aj3E8skBCOzNNBh1DZhw9snny39mQndN945CJKZUkxi9E95TKu8PQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YybWGxx8y1jsEBhBPjXyldTtA1oY5gnMVo+4jHhtJsYgHQjbngs
	xlhGLI81On8FgQZKoX7bGPYd0izzlexWawsCo6s+eFgH6LnYJi+XUEU6myUd8rzRITj4InGRB9k
	h12odrlYZrrtCjmyCqFJvdvZTbrkuEtT3gxkxjnuTtd7pMqlGDECP79CF3TIB0jI2fWLVDQ==
X-Gm-Gg: AY/fxX7chF64iNOccKO1dnreGGBGOCiASkq9nLOp7LfN3dOrLoZrVUvmg5uJee5pg0P
	2kM/R6x0EhIYeCOObm1m77oCANckFYJg2DxapIrjkpO8OBl6na+FkTOr+aswZfjeLbh6GQIgIvC
	6fNZjc8EoHpNI3S46MX5QmG9C4VR4lx5AgoNeWyWwVwUJd8jRh6MGo+o2txci/DxgWrZzx7jnlr
	HW7L9DTsKuHMWkCXTcAp5P7Y5DrN5Ij4yeWEmCJ1OFXpEjWgAOAoSZATx6jCDPqtfEl2XOgiQ3v
	OwBu9fK/cxR5MQcnSRDMg0WMJ29ms0y4BPLSWY74zGRT0ACmNyQucBU00kVBgwIZGVVb/Pprb2C
	2pfEG1BxmuWwCdDyXkPOKjdiGErq8Jkq5XYmQHx8Tqj1zwURi+DMjympYWjITuAnCqIXgCw==
X-Received: by 2002:a05:7300:372c:b0:2b0:4c5f:c05c with SMTP id 5a478bee46e88-2b486b7da27mr3799956eec.4.1768405989072;
        Wed, 14 Jan 2026 07:53:09 -0800 (PST)
X-Received: by 2002:a05:7300:372c:b0:2b0:4c5f:c05c with SMTP id 5a478bee46e88-2b486b7da27mr3799902eec.4.1768405988379;
        Wed, 14 Jan 2026 07:53:08 -0800 (PST)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b17078dd84sm19498688eec.17.2026.01.14.07.53.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jan 2026 07:53:07 -0800 (PST)
Message-ID: <cf6b81ea-3ab2-420a-ac10-e847be54c9c3@oss.qualcomm.com>
Date: Wed, 14 Jan 2026 07:53:06 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ath9k: debug.h: fix kernel-doc bad lines and struct
 ath_tx_stats
To: Randy Dunlap <rdunlap@infradead.org>, netdev@vger.kernel.org
Cc: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
References: <20251117020304.448687-1-rdunlap@infradead.org>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20251117020304.448687-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: DyaENHrHIWz0nndggwJaSV2zfd5RxfVl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE0MDEzMyBTYWx0ZWRfXyQBPJe08QTIF
 TqXSNfOZzQDuZuRD3ht0xU/XjJzxMyPFctDNq4g/rKjbeGmHIWLeiBBGFe9NGK5BXic6sP+Yj1f
 uN025QZlDsvy74D+n724BBNL/xbn/8CpRxlruEOMGg+bbRhaI8AnA2uww9XpvH0DudX7Cp9T1au
 z+L6anhzLewqL0eT6J9lNe5+GeHd5sx+anXo0XFg4igbnfLT+r+I16ikNlXURypg24RfroOFL8k
 Lk0SgYH9/FKOXsPnPVn6vNGshl57JdTd5fhgN3VdfSj6KFUA7LUrO5nA3kYtcx8YLWrRti22Dfv
 B/vMJ2xurYZf2LxHdgaLKu8pJNfDE5UBT1/x/i65RCAxl3o6tmoaM4wBHEfa1q16DRYRdHrHJT4
 Wk4U/bmtPMBHTuXzNujf7pLaYwe0XYDLF6bFrZvUTsv2h5cGGnVQeekGdj67HoWPMmXkmyiwfOl
 ecyxHfOqzsZifiD06dQ==
X-Authority-Analysis: v=2.4 cv=W+w1lBWk c=1 sm=1 tr=0 ts=6967bbe6 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=JfrnYn6hAAAA:8 a=stkexhm8AAAA:8 a=VwQbUJbxAAAA:8
 a=bN4pwD7rly7kb_o33PIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22 a=1CNFftbPRP8L7MoqJWF3:22 a=pIW3pCRaVxJDc-hWtpF8:22
X-Proofpoint-GUID: DyaENHrHIWz0nndggwJaSV2zfd5RxfVl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_04,2026-01-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 suspectscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601140133

On 11/16/2025 6:03 PM, Randy Dunlap wrote:
> Repair "bad line" warnings by starting each line with " *".
> Add or correct kernel-doc entries for missing struct members in
> struct ath_tx_stats.
> 
> Warning: ../drivers/net/wireless/ath/ath9k/debug.h:144 bad line:
>   may have had errors.
> Warning: ../drivers/net/wireless/ath/ath9k/debug.h:146 bad line:
>   may have had errors.
> Warning: ../drivers/net/wireless/ath/ath9k/debug.h:156 bad line:
>   Valid only for:
> Warning: ../drivers/net/wireless/ath/ath9k/debug.h:157 bad line:
>   - non-aggregate condition.
> Warning: ../drivers/net/wireless/ath/ath9k/debug.h:158 bad line:
>   - first packet of aggregate.
> Warning: drivers/net/wireless/ath/ath9k/debug.h:191 struct member
>  'xretries' not described in 'ath_tx_stats'
> Warning: drivers/net/wireless/ath/ath9k/debug.h:191 struct member
>  'data_underrun' not described in 'ath_tx_stats'
> Warning: drivers/net/wireless/ath/ath9k/debug.h:191 struct member
>  'delim_underrun' not described in 'ath_tx_stats'
> 
> Fixes: 99c15bf575b1 ("ath9k: Report total tx/rx bytes and packets in debugfs.")
> Fixes: fec247c0d5bf ("ath9k: Add debug counters for TX")
> Fixes: 5a6f78afdabe ("ath9k: show excessive-retry MPDUs in debugfs")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> ---
> Cc: Toke Høiland-Jørgensen <toke@toke.dk>
> Cc: Johannes Berg <johannes@sipsolutions.net>
> Cc: linux-wireless@vger.kernel.org

I'm picking this up, but my automation noticed there are still kdoc issues:
Warning: drivers/net/wireless/ath/ath9k/debug.h:138 struct member 'txeol' not described in 'ath_interrupt_stats'
...
Warning: drivers/net/wireless/ath/ath9k/debug.h:138 struct member 'mac_sleep_access' not described in 'ath_interrupt_stats'
19 warnings as errors

Are these handled elsewhere, or will they need to be handled later?

/jeff

