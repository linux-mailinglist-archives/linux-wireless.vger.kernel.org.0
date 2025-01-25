Return-Path: <linux-wireless+bounces-17923-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 121A2A1C109
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Jan 2025 06:25:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EB78188CF88
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Jan 2025 05:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F4D207A28;
	Sat, 25 Jan 2025 05:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="k0x661ZY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2CC2582
	for <linux-wireless@vger.kernel.org>; Sat, 25 Jan 2025 05:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737782716; cv=none; b=HZgsdbMpBC97X6k7dv7rMVS58OuRnphjUXORDkCH2GdLugbQv1e/ivNC1ywpRXmP+Gr0gmDN+jcnpXdGZwOaE5e7VXQWn//H6h+2jie6nbgaVYdtC1nqQ/vrtNUtyFNPDDhgGA2vq765+MqUjbgi97HQJZAaYmb8FUpskXUJEuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737782716; c=relaxed/simple;
	bh=nftiWlZyc6mBGNiCEDWzRQPP4CQGYoZcK7f9Dy45KVQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eCd1gdpDBibWqXKjlQmP70GGaFEQU9GZ2W/Zbk34R/O8mJIWRUo3Vashup8KxYGAhdbIHYYZroKIMyj9BlU/AQWcd3h2zr0R9dgYNRV4pbBRv24PH6OufnOoQAyoe4Xl2ijEZK2mALLB6BNJ9zlvHh0YiSjPafqq5zzIN7Kocc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=k0x661ZY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50P4UkVI012819
	for <linux-wireless@vger.kernel.org>; Sat, 25 Jan 2025 05:25:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mjDXMY3kZHArBWhjkX+PEyLu0Hkov8vChyBsrqhGWmk=; b=k0x661ZYt6JZ3zpR
	r4DRC6IGcNGsn2gtCqiUImJukU3oTgLEZlVY3MuaOtwq7ERG09Uq2VlUxKH51qDF
	x7Ulw8UW9kgnQ++nkSDpmjeJx3g7AfUrAr/cw3LMgAFbveEuA74RH7O/Gmc5HBWF
	M6s3XI+7hpM0g07e6E8/ELnC8DjXYkxkZyfzVvH+c34L5ZBYfiQJubtym9x5yxLp
	JTE9nLC5MusBh8qdBNrmDR+vyzWiM72ybykzjxx2L5TmhOejpyjBaf722PC91GKU
	aRRcEL7ms2hNRjzLi5EOmEjNVKSiy27l8RuvRfbXlviJc/qwyAXYQ2/2PR/ksvf+
	0Urpgg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44cs0d01v8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Sat, 25 Jan 2025 05:25:13 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2ee5668e09bso5679281a91.3
        for <linux-wireless@vger.kernel.org>; Fri, 24 Jan 2025 21:25:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737782712; x=1738387512;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mjDXMY3kZHArBWhjkX+PEyLu0Hkov8vChyBsrqhGWmk=;
        b=ePGAz7pFogt61SaLklWHTehxSxDn1eQZL/Bs8dHL4oNZK2Kgzn5T+nThLCva1pKMgN
         gIOFwX9qzeA+Rv0ZRaKuXgweubQAmqWd9bT+5FvXGxkA4XURUhRGv5la7Utp0aeOx20u
         NGYFn4v6zOJsBAcAtN50DT2g30BB22bFe3a/Wff9cIyu47u/j9+hJX0/E0XOJTgV7BRh
         hKDTzHU/6T/vFsxUSSplWubwZ53Swbk1lS/OoWiYEpy6jVpyiTfVPwyaiA6AiW7by5j1
         T4rdR0Adh1GPRKPELidEm7/x61Ny/WUg6KdA25r7A/AW8io5x3Sn+DO9NVBgVXUftBov
         hkKA==
X-Gm-Message-State: AOJu0YyDYq294URn/yfzluQ7jZsrni0YBvI12cGd1uVxT1AMyr1eABla
	E94drg+BDQ17SZHbeSwFuOtfb0FnDl6mmUxMdNX6yKfgcrBWoAkCO7KAf5WlQgCdrn3ufwHzOjG
	WPUZlEwweoG+Qq8awZ9eo/pumQV5nOErN/soUWBJHwRwFd9AR4AcGhi4QVLRHLMziiN8vcxPPuw
	==
X-Gm-Gg: ASbGnctl7oB7h7AM0yGO70kbpfStlTToGyK25usQ3FsP4lTN069CEkh1uqhj7f9jdjA
	NWbs6P7crqj8wm0bCh/ss2IJ67tx1fokkyhni5TBktP8SZ3Xu5Ow41KQtG75IpbjzW5+Uj4U+bO
	k5ANw8/7MKh+6pQss7xmUyeOqGULGwfZqx/94n01m1nCQ20r9kXXzEv2Lkzq2GHDFJL/Zf16MnQ
	UecRIPyQE2oAqbPoU336ZGMXW/9A/Tm0vD6+8Dn9b+IPPZaynUG6aX3O1OM3eCsW51WDEI2Z/63
	KTulblzVP3ALSl2+D3Pixr2ude19sWIbNAAwQgZuGA==
X-Received: by 2002:a17:90b:2c85:b0:2ee:4b8f:a5b1 with SMTP id 98e67ed59e1d1-2f782d30ecamr48469075a91.24.1737782712150;
        Fri, 24 Jan 2025 21:25:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHIaLprj/kI67JivCpkEoWYsjtzFStjZ/jj2YInCrJPsXEHy5GT3C6WMbQE5ll2JURCdV6kFA==
X-Received: by 2002:a17:90b:2c85:b0:2ee:4b8f:a5b1 with SMTP id 98e67ed59e1d1-2f782d30ecamr48469052a91.24.1737782711763;
        Fri, 24 Jan 2025 21:25:11 -0800 (PST)
Received: from [192.168.29.221] ([49.37.208.137])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f7ffa67f7asm3015800a91.23.2025.01.24.21.25.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jan 2025 21:25:11 -0800 (PST)
Message-ID: <b237b4dc-9a07-4a22-9298-e3eab22ca2b3@oss.qualcomm.com>
Date: Sat, 25 Jan 2025 10:55:08 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] wifi: ath12k: Request beacon stats from firmware
To: Ramya Gnanasekar <ramya.gnanasekar@oss.qualcomm.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250124185330.1244585-1-ramya.gnanasekar@oss.qualcomm.com>
 <20250124185330.1244585-3-ramya.gnanasekar@oss.qualcomm.com>
Content-Language: en-US
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
In-Reply-To: <20250124185330.1244585-3-ramya.gnanasekar@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: Ec7J1P4h0p2c4bIf4Ch-yY5twNB9uzg1
X-Proofpoint-GUID: Ec7J1P4h0p2c4bIf4Ch-yY5twNB9uzg1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-25_02,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 phishscore=0 malwarescore=0 adultscore=0 suspectscore=0 priorityscore=1501
 spamscore=0 mlxlogscore=860 lowpriorityscore=0 clxscore=1015 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501250034

On 1/25/25 00:23, Ramya Gnanasekar wrote:
> Add support to request and dump beacon statistics from firmware
> 
> Sample output:
> -------------
> cat /sys/kernel/debug/ath12k/pci-0000:06:00.0/mac0/fw_stats/beacon_stats
> 
>             ath12k Beacon stats (1)
>             ===================
> 
>                         VDEV ID 0
>                VDEV MAC address 00:03:7f:04:37:58
>                ================
> 
>        Num of beacon tx success 20
>       Num of beacon tx failures 0
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Ramya Gnanasekar<ramya.gnanasekar@oss.qualcomm.com>
> ---

Reviewed-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>

-- 
Aditya

