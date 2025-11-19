Return-Path: <linux-wireless+bounces-29116-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D081DC6CB38
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Nov 2025 05:20:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A193B3523B2
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Nov 2025 04:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 229FD2BB13;
	Wed, 19 Nov 2025 04:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ne752Avp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EvrzyMdB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7256E2F5A3D
	for <linux-wireless@vger.kernel.org>; Wed, 19 Nov 2025 04:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763526037; cv=none; b=MB7HQCh5gdcePF1IiyBuogrexhNhh2ludQQl69v54gPKjIwNZvqpECIFyhUoXfwHbc5KdyWGVtVQmHlfYim7oq22KTsxjTJdzwte0ox1lt2iGEgqAGkvePIRg3LVhFisdK+ZwxLwwMxSsnLzEroz0o0aIyccxkx3m3b7XDio5rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763526037; c=relaxed/simple;
	bh=Wfgw+A9zy94v+KjnBkXZsf9110X5Gd2oGdd6W/GMdCE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DYyz/gQaqD5fPDxiN2jahcrmYLFdKuhZ7nTxxGkwHmsMN50GyOwSIolIlE4W02DB8PWh4RMr4tmMHAda/ivvHIvI0c0rBxT8ragtHJYvWSTXH36usD4mDP4ZUnxpm/NnPY9jIbFRp7tgXoLS6ODsBt7eSoN1OwJKChB2iIeLEy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ne752Avp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EvrzyMdB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AIJQ3V23373365
	for <linux-wireless@vger.kernel.org>; Wed, 19 Nov 2025 04:20:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ja5dOuwJAg4YIzd4nzL3Eh6NhlzRMEj83Ch39YAIhpU=; b=ne752AvpcKeujgUE
	2uGgBpW2z/TrdVZYDK/615aXtvgMqcKwnuIDz0SWqSXyfia1FyGkiZHGNT/XLVNI
	Xqxgg1sxcXzS4TXQa2VCPVe+i7YKx9zvPB/zpgdU8W1I00V1OS1u2msdDXwr9xJG
	4OuHH0r1g6xK2XXlpKhSeI/RD/iWRSzmKTVWP29VnJT9eXn5uJ98ToLlFcSaXen1
	m/fYyT+3nuuBEDMktCPnBRRmkHqY14KT+CDXH5yZgkipib3gkYpUiM2n5o0T1EOc
	9clvo89VapV74hQNGdMvaRLRYQ6K72fmUYUqP2fNVWRNZmgrnIJWNWQGFQZYny+O
	EKqXAA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4agxy117v9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 19 Nov 2025 04:20:34 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-295592eb5dbso50881275ad.0
        for <linux-wireless@vger.kernel.org>; Tue, 18 Nov 2025 20:20:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763526034; x=1764130834; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ja5dOuwJAg4YIzd4nzL3Eh6NhlzRMEj83Ch39YAIhpU=;
        b=EvrzyMdBLYikVz9CEpZhiZWwdiehbbcvCkM/fBUJaLeU+lk0WQzrBqrjz+Fot97+vI
         QWNGgb2WMIYjc9alZFfa8KsWWY5uQd/gUcL7/EFxlD5j8YWVasiLjjAdtnocCd87Bq0y
         0mTQ9UYfJwt6n+Ey36DMGszpw1NXTBwJWEsGbsg/iAZ75KPOw7rusEUEpRKsiTj5KulH
         2QyaL4TzTvUqOKEZ2sNDMPqVlc8cEc6plyM7fQcrMf+uFl8hxDo2ufvJp7U9ApsY9bnl
         vl83tjmfb53MTpJB4zRV/37oSiXdXO0BmAGUp+es0TPbAob1erJ9VVsBS/6uUz/Gj+HP
         B90g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763526034; x=1764130834;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ja5dOuwJAg4YIzd4nzL3Eh6NhlzRMEj83Ch39YAIhpU=;
        b=TZY86pPYyi3qqyCOkyaSayQF/oxBcDEtZ+slLrGZGOKoVDspLQsmU4EaeWNqZLVCwA
         wIhvcWkap+ahv1y4R1FHp3fY+Y73joGkubomzj9RnpD8Ky+ygCYa73g8F5rqK87bkYDa
         eNvGYi5I0GsyUzu218DZFs5SvRjbJHXKKrRsjirVrHWPGtJMptnW7BMzE3+E4PNbmWuz
         XnllQz8u8PNTiwScE6HRKMPeRt7VeTfJsWUU4md8mVIdFYgNX+ORaFt30LRF5hxCl+8W
         ZGDNTQheOKwqlbBP08V4ahBkJ7KwgFjex6aHMcJm8MblKscpNjclT0OMpjH3GlXrs807
         DL6g==
X-Gm-Message-State: AOJu0YxMSU45h5m9/toEsuyk1NNlIFlR4Td8vpnqBofbGiKyQw9R/88y
	0qZBhSdpnWVYq5+tJConZf+pp0yyVjf/4DCJjT8pAS/ykAUYQzc/e66OlVRGwlx7pTGKXOzDisu
	8iYaQmnmnR28ls7f5ATg1XszWhCZy0k7TADt5HNInmRocAmyeAq8yzri+Cr4r8FE/gZYNOVUJea
	5jNQ==
X-Gm-Gg: ASbGnctMP4+qO2sMbPsiH8bqFPMyzTwLFVu+C3C+YbETsS2DqlQxA83PYsv1P9Fa9Fb
	q1Hv8fAWqwae0HhAgpsvFQhc6Ee3wm9WGmkDcdQ/3tnDbykVx1fhFdexyMpuqH6btycN64HwT2R
	OB1G+Zh/5fp64w5hvNCrM9IlsdNPVSZ67FTRteMdedyhEB+u/BDJUUtoBZ0eWuI7A+6ENyIrjN0
	cMXO1FyejnAQrSkKoOepd02KTggmQjiCXy8cuqe9rMl5fBxBKDGV0x0Ve74fThHpTTpXYvY5UU5
	z0i7qTAbEg+AUNfKHTfETUnidOnLC/XJviOPPCtMA0G3ju+7NFmrEheemRNtSe+W4St2Cu27bRo
	TGouAYBDJ7DYvAC6qQSnKIYLA8/9o1gTCO4qKNFxht5F4sziwxaAo8XY=
X-Received: by 2002:a17:903:3c47:b0:295:6d30:e268 with SMTP id d9443c01a7336-2986a755dfemr216205015ad.59.1763526033659;
        Tue, 18 Nov 2025 20:20:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEVbTciutVO93xK7yxqRWlbbbO4+eMrZ7cPU6rbG23sfCDDFKDCVcw0uV1r3UUt9BwihNE1Vg==
X-Received: by 2002:a17:903:3c47:b0:295:6d30:e268 with SMTP id d9443c01a7336-2986a755dfemr216204755ad.59.1763526033191;
        Tue, 18 Nov 2025 20:20:33 -0800 (PST)
Received: from [10.152.204.0] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c245fa1sm191107285ad.36.2025.11.18.20.20.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Nov 2025 20:20:32 -0800 (PST)
Message-ID: <8f587649-063e-9cb2-42e9-88703c59cde0@oss.qualcomm.com>
Date: Wed, 19 Nov 2025 09:50:29 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH ath12k-ng] wifi: ath12k: add the missing RCU lock in
 ath12k_dp_tx_free_txbuf()
To: Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org
References: <20251119-ath12k-fix-missing-rcu-lock-v1-1-8155de1dc4fc@oss.qualcomm.com>
Content-Language: en-US
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20251119-ath12k-fix-missing-rcu-lock-v1-1-8155de1dc4fc@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE5MDAzMCBTYWx0ZWRfX2dmPSLTjmgNZ
 eqnDrUIK9G/HKiynVAoDDu/zOnietNj08zAdj8CtXxY+P2IRyZRS+CbKzNZcB2tSnp6Stse5Kkb
 xZFtQ/GFKZTgcmRntB2UHPm36nl7ZtvLSDUpFGYu3XJ+SMyWsvdcW6IVmznvZqcPhp+BFEFabDd
 b8R/CElh9FGudUUVD4o9/GtbxgmhGtTqxdLOwqMt0lsDgWx8yXaWaxsCl0bh2ytVF06Mn/dMm/K
 1F7hHpy1dqhjh6B6iNBNLEA2zakF3YPRDpxlQWZRoVXCb0gyD2M6YwvvihfsvnIMM+OvFHCR0WC
 Lmni4XOjnUZ2PBaR8WIAwD5DCR3cpH3/ESuw5KW7ehQeuU7c9cKpTNu1yDZQnyF7XDtjUN606rI
 7jxzNjmG3sZ5EZXUcIczkPHhIO9w1g==
X-Authority-Analysis: v=2.4 cv=Dt1bOW/+ c=1 sm=1 tr=0 ts=691d4592 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=fpXTjR_PzDRLIX1BWiwA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: F4Oi4PHT2ersPzSPkesbxiByzfzNum8i
X-Proofpoint-ORIG-GUID: F4Oi4PHT2ersPzSPkesbxiByzfzNum8i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-19_01,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 adultscore=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511190030



On 11/19/2025 7:45 AM, Baochen Qiang wrote:
> RCU read lock is missing in ath12k_dp_tx_free_txbuf() before calling
> ath12k_dp_to_pdev_dp(), causing below warning:
> 
> WARNING: suspicious RCU usage
> -----------------------------
> drivers/net/wireless/ath/ath12k/dp.h:653 ath12k dp to dp pdev called without rcu lock!
> Call Trace:
>   <IRQ>
>   show_stack
>   dump_stack_lvl
>   dump_stack
>   lockdep_rcu_suspicious.cold
>   ath12k_dp_tx_free_txbuf
>   ath12k_wifi7_dp_tx_completion_handler
>   ath12k_wifi7_dp_service_srng
>   ath12k_pci_ext_grp_napi_poll
>   [...]
>   </IRQ>
> 
> Invoke guard(rcu) to fix it.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00302-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.115823.3
> 
> Signed-off-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

