Return-Path: <linux-wireless+bounces-21403-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 465BDA84AFB
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Apr 2025 19:29:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EB831730AB
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Apr 2025 17:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EFCD1EF397;
	Thu, 10 Apr 2025 17:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="C+lsCRxt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0B420ED
	for <linux-wireless@vger.kernel.org>; Thu, 10 Apr 2025 17:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744306186; cv=none; b=fNEZqUOfsR2sZnWg/RIWwLOGDGV8wFbKG3bs9nXHIy19Hsi7nHB/ojJRXE9ZqYg40CO8TZKQ92X/bDBGFIkoj8ytalHrzCWIQKqM4NYvsRpxhsL4lZPiEixpDy7FCIFFhhaSDE7CDL1nIwUSTmsxyAyKLTfhVd/vSqNUpAXqA7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744306186; c=relaxed/simple;
	bh=sZkkg4FHzf3CqAL0r8ylcq97bxB/mCKhw8YnXSUHlHo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cSoBcpok5RKXytwVwjfHQEHuhMOtSF3p6itOuOwqyt+bwmKeKHBM3rGiXmja5eaGe6MvZsUGyVmvLjTt5C26pDWE9Dj+ZExCuig+02R5d4QoJa1Wqh4au5XxybRk56aI9eBgyiR9Hns4AitpIzgmEDu+oSkBo3E1dWlQoBeSdrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=C+lsCRxt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53AFp8uB013900
	for <linux-wireless@vger.kernel.org>; Thu, 10 Apr 2025 17:29:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AnrcxTo06c9o2oy9wzzrpk++e7CPzYP7UWeWvj6S8G4=; b=C+lsCRxtFti7Vumn
	C95rPc9YApR/ZUmR436xvuRitZOH/vdbeydPy8l3CeSVXyV9d59Kp6YBaLRZqTS9
	Y7r2+8BKqZYYf7Och1+yXNpNmZvSv9+PL3Oax0p1PG2l3sJJEJXYvFrP2+eD9znE
	Op449UmSpC6gKiGP1IqkiJE59l/kKbUaoCv5LC2NNV6+//RpsJ4+URCF38u67ec4
	gHaiDc7BV5yXXXIjvYx3jkMQ/bfEGgAwWl+qjc6RuIfe/WLpETZusRgl7GPMpZPd
	yl/e5pWSn3fPlyDNegu77ly6G6hVLVkk1JEkmJa6lnEQNARN4RhHC7REfPggybv0
	zoDOjg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twbefvsy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 10 Apr 2025 17:29:43 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-af534e796baso732730a12.3
        for <linux-wireless@vger.kernel.org>; Thu, 10 Apr 2025 10:29:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744306182; x=1744910982;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AnrcxTo06c9o2oy9wzzrpk++e7CPzYP7UWeWvj6S8G4=;
        b=inj3NeLQr9tog/VJjbhEO4TZGhfllOKVPuYbEwrBoyg52SNCWO9BJb0jifZfB8cQq/
         dmV8dOifUdEg5xpsJKPgeNAz0LKqhRxMv8QupkKJEgdp+hKMJ4msVuUNzKnQiH6E0bsv
         0zHmX0sQR9yo+KJJnLpfRU5P3YFlbAi+UT+PMEdfo5MCARuHCeQQDKfY+OkoONUYJw8l
         jabQlh4jDxKIIgAfvoZ8QdkhTIeHjWgOCc/baIano4PlTDUicZKmD7pyy/6ZwkFfoFx3
         uqGghYPnRrHE7L9Oy1NvZ34kT9+Pkx6ZwpLKZu3RiNAbvIW3jt0FC+lhYsg2wDjXBcv1
         Z0IA==
X-Gm-Message-State: AOJu0Yw/SivQEHnSfZSwT8ts3jurIkcTZUt2Yjr5cKXxNbTDqbJsuMvc
	PbEFITg/CIree2097UhfIgV5zBHKNuGau2+eWo9qSYtIhMrJK6hczhonFjvumSD02dKB5JZ+W3d
	+p0f9OZlYME3C+aOdeLaUVy1giSdAhXGNLUqHGHpcxfAVa7rpo181UMV++0db8EtUguUuDBiYwA
	==
X-Gm-Gg: ASbGncuNRItUoal7xqwG4DoLypL2wr0tCKMy44V/WX5gFNSdZ62RPiEuAnG23V6kOnA
	elc7KX6nV5egYw3PxSGQtYP6F3+rvNtyq5yFkqJsZSr4i5DwQh9TWO0PIA5gM+TOCHnX4Egcid8
	sf1m+El8KxZABkXRUg50u7PE7RSPoyns/tTzuXEyazK68F/1xLGq78HXAfZ3xNzB7iDPtA9CCIc
	BtPA0E1Wm0CBMDJsxKCtdfKevu63KysZv1itvFt7hBscJPld6ibaVodUB7DWf4xdLi4y8LXmNzO
	qloVWC5D9ApuTsJ9wVVzR4CKGc8CYnzDDY3QSYZ2F7KWKpjZI0sF1kwycZsqzNrJaHbDs2SRz2h
	mFkLl
X-Received: by 2002:a05:6a21:4a4b:b0:1fd:f48b:f397 with SMTP id adf61e73a8af0-2016cd5ec16mr4314589637.23.1744306182263;
        Thu, 10 Apr 2025 10:29:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHWtPsisoIv6XSliwjGzBZFHr5cpJYt0ZyuLeyZu9YaURO2s8l9gPgZySOZTq6mo1UvdTVi1g==
X-Received: by 2002:a05:6a21:4a4b:b0:1fd:f48b:f397 with SMTP id adf61e73a8af0-2016cd5ec16mr4314567637.23.1744306181848;
        Thu, 10 Apr 2025 10:29:41 -0700 (PDT)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b02a2d39624sm2809763a12.59.2025.04.10.10.29.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Apr 2025 10:29:41 -0700 (PDT)
Message-ID: <171e226a-eddd-4841-9672-b81b6b5a3038@oss.qualcomm.com>
Date: Thu, 10 Apr 2025 10:29:40 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath11k: Use of_property_present() to test property
 presence
To: "Rob Herring (Arm)" <robh@kernel.org>, Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20250408190211.2505737-2-robh@kernel.org>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250408190211.2505737-2-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: ucMB-197cAJ-SZ3FGFc09GuU0bGmbnYH
X-Authority-Analysis: v=2.4 cv=T7OMT+KQ c=1 sm=1 tr=0 ts=67f80007 cx=c_pps a=rz3CxIlbcmazkYymdCej/Q==:117 a=e70TP3dOR9hTogukJ0528Q==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=bC-a23v3AAAA:8 a=VwQbUJbxAAAA:8 a=no2ZJX3K_zlcQ_1UBIIA:9 a=QEXdDO2ut3YA:10
 a=-FEs8UIgK8oA:10 a=bFCP_H2QrGi7Okbo017w:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-ORIG-GUID: ucMB-197cAJ-SZ3FGFc09GuU0bGmbnYH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-10_04,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=820 lowpriorityscore=0 adultscore=0 phishscore=0 bulkscore=0
 mlxscore=0 malwarescore=0 suspectscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504100126

On 4/8/2025 12:02 PM, Rob Herring (Arm) wrote:
> The use of of_property_read_u32() isn't really correct as
> "memory-region" contains phandles (though those happen to be u32s. As
> it is just testing for property presence, use of_property_present()
> instead.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
> I'm assuming this should still go to linux-wireless list? I had to 
> manually add that, so looks like recent MAINTAINERS changes aren't quite 
> right.

Yes, it should go to both ath11k and linux-wireless

Johannes has a fix that needs to make its way through the trees:
https://msgid.link/20250329220135.8bfaffbad97d.I946354c2395f4a30b8c435857a92553b1b58df5b@changeid

> 
>  drivers/net/wireless/ath/ath11k/pci.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
> index 412f4a134e4a..87ef7f321065 100644
> --- a/drivers/net/wireless/ath/ath11k/pci.c
> +++ b/drivers/net/wireless/ath/ath11k/pci.c
> @@ -929,7 +929,7 @@ static int ath11k_pci_probe(struct pci_dev *pdev,
>  {
>  	struct ath11k_base *ab;
>  	struct ath11k_pci *ab_pci;
> -	u32 soc_hw_version_major, soc_hw_version_minor, addr;
> +	u32 soc_hw_version_major, soc_hw_version_minor;
>  	int ret;
>  	u32 sub_version;
>  
> @@ -955,8 +955,7 @@ static int ath11k_pci_probe(struct pci_dev *pdev,
>  	 * from DT. If memory is reserved from DT for FW, ath11k driver need not
>  	 * allocate memory.
>  	 */
> -	ret = of_property_read_u32(ab->dev->of_node, "memory-region", &addr);
> -	if (!ret)
> +	if (of_property_present(ab->dev->of_node, "memory-region"))
>  		set_bit(ATH11K_FLAG_FIXED_MEM_RGN, &ab->dev_flags);
>  
>  	ret = ath11k_pci_claim(ab_pci, pdev);

LGTM, I'll pick this up


