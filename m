Return-Path: <linux-wireless+bounces-28108-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DA05CBF1DFB
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Oct 2025 16:34:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ABBB64E1275
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Oct 2025 14:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA51A1F9F47;
	Mon, 20 Oct 2025 14:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HHyqkNUA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBF01F4180
	for <linux-wireless@vger.kernel.org>; Mon, 20 Oct 2025 14:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760970864; cv=none; b=NWxquAzJqK0MWcEaQL9K0eHwci5aa6NbCb2+3k9imK5WorrxdUwTFG3RdMq2AKIW5uNNxFL0gcLcEE5ZJ8awPtk3+13TF3HmkJ+YYxm58THGy5ZhzOfaKnRKqAKWpF3G3tkS8wq902OhfDN9esxag3Q5HCRaJGRUO4xn0T7HLsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760970864; c=relaxed/simple;
	bh=nBTdipMKcpgT5fqnSkhwzl6DUTOlQBkyL74k2v6bOSE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o+M4PA97ZJmG6Pp0Hsk9suQ2eHMHrZ+ENXoBgeTls5xKIfWrLyeqEYnaSO+5ef4xQJRwUMQriX4j+6T45fNrPyXRjYu87h+sZPug+TolZqtvIUemddhQ1YAIee7/Aojfw9WuwBG5VIG7/E2Pl5Sh1j3fSfw9q9kPdTw0X+Do/U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HHyqkNUA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59KB1HMC010027
	for <linux-wireless@vger.kernel.org>; Mon, 20 Oct 2025 14:34:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Xq9CxQfbcojNitsTANwpHy66YODPVnxM+AcIKPao30E=; b=HHyqkNUAohqX/zSj
	V+kYVHsACLmYuBNq5kRJTArg/kcoJLDfp2jvgOPEctVB4HMOW5Q6FVXwaQak5pxc
	1hUMt+nHoj4jtFFuByQ1UiEhie5EPIVNq0TaPaNGe8Q5FwQqnlumtW6yevDLqPxP
	NNjbA3GcBk7eHRelxOSPDFrHi5u/LjkNGeu3DMRwEkwJyCIJPKA0jfrsiPffQcVk
	T1wHJWkioTF8SEvN2gY0RwRZex4gyztUsgvRwhK4s0pOzTunkHT14VU0zuuyS9TE
	V4NRP8oiRhoXMJZqONMgd7wh8kjLPVa6RPMInTf1f8q7r+kakDPW9cPEfTkgEt/C
	1kdbag==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v0kfda72-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 20 Oct 2025 14:34:22 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7811a602576so6889376b3a.0
        for <linux-wireless@vger.kernel.org>; Mon, 20 Oct 2025 07:34:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760970861; x=1761575661;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xq9CxQfbcojNitsTANwpHy66YODPVnxM+AcIKPao30E=;
        b=DXOm1mB8XUpuNDmzTdP4ToZupkvgvnEAoz8FeeLvrzLNdCIw9ehojsqR7QinXvoqE1
         9aECPofkPyp010d15Ii+ljx+jks73p8Z1o/e/A8U4iD745ECSI8nTXtfZokEJXjaYsmz
         yQIUBK2KwvhtLfIgS0Q6XAmgHT+GXkOmX0do9PwRTv/FfK9RsiUcgF/aqTlKSFvrJ2ue
         550XGHaL9YzNWhI93T26vVEERa/nbySwotnEUr5tDwB1kR/C4IDkW/mhCMS/zklgK3/r
         YMx3WzEXaDWjrH97mrEcKHoKcUgP6LI43NmUCwjEc9RrdVi6sRcvIqGwFTL0UNUj5rxT
         vFXw==
X-Gm-Message-State: AOJu0YwrtD0QoolLbNs5SPAhye/1tt77140+rKRcOaZ4VKXsvPbIcbFA
	cEWoJDBKRvOQGtyHBPK2v+LCevWY3laiKeqinQqY8fATVh94BnQ8ojW8hCldqqMxAwfnA4XKcEt
	xXh2bbaroZRuqZ58l+jzltBD+i+ZKHIb9nFr+xVedhKJeNy3ymh0tsCamoDj1CsF/TA9QBg==
X-Gm-Gg: ASbGnct6GO4LSYunROh5xRSM4PhAdeENYZ3+7fCobuT0WngbfjgniKvE+XqkuGE68+u
	YXtQtJ0db+bHy40tk7bLMzRLsPo9M2rThpnWUMh+wBEs90ShAgietUydAz3NFqGWePOM2f0I8OP
	0MXcNauBBcMZhK+dZxkAcqBHvP5X+PyHPWnIJELOlVKZutABxKqRAVt2HLyLTocnyr9qUbcukzJ
	evYw/nal+NXFaW7mLBdPlzQ0gGvaFmDI3i9kFQoaVZmK7P9uFjDQ6yDh3xipDw+ju6uoHQRpAgY
	sYLrMy5lWFa7h7PXFTJr0VtiD+nS7ZOS4JOqVTK1BC/XedWel8TF5D6/R42DCTau2CONhnIQQ5F
	pXPDzsQCAHCGljvu8+0Z8DjBjIEcUnrhj5XYK6tH7QRqoPjv/pI4h0SOwIlE=
X-Received: by 2002:a05:6a00:21c5:b0:771:fdd9:efa0 with SMTP id d2e1a72fcca58-7a220d232a7mr19060757b3a.15.1760970861144;
        Mon, 20 Oct 2025 07:34:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEkPETGlPpcX0Zo9s2ESi1So00sm6zV6o2zy82cpXUbyNgFbOaafAOcbpXtiZ8iRl3YTUq5tA==
X-Received: by 2002:a05:6a00:21c5:b0:771:fdd9:efa0 with SMTP id d2e1a72fcca58-7a220d232a7mr19060708b3a.15.1760970860474;
        Mon, 20 Oct 2025 07:34:20 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a230121f96sm8506538b3a.76.2025.10.20.07.34.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 07:34:19 -0700 (PDT)
Message-ID: <39434456-04a5-422c-a42e-9c4ef40dbe8e@oss.qualcomm.com>
Date: Mon, 20 Oct 2025 07:34:18 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: nl80211: call kfree without a NULL check
To: Emmanuel Grumbach <emmanuel.grumbach@intel.com>, johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, miriam.rachel.korenblit@intel.com,
        Johannes Berg <johannes.berg@intel.com>
References: <20251020075745.44168-1-emmanuel.grumbach@intel.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20251020075745.44168-1-emmanuel.grumbach@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=E6LAZKdl c=1 sm=1 tr=0 ts=68f6486e cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=6xGJIMmgAAAA:8 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8 a=LqYiVqGUzrrRF6NuEA8A:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22 a=aWz6Jz32kaLdCzdWRG-w:22
X-Proofpoint-ORIG-GUID: YBDNWCWuHl4UulIxl0z_7hjGVfJRdgxT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAwMiBTYWx0ZWRfXwsWZRF8Gcj/Z
 AVQ/2lim/tq5C4X9IN01E7FfSYXh8NrWiJ46EhVSjgAUvcN+7cGLBOaRHuKWMEFDna/9bC3Bare
 o2azb6dTiA26LKW+84UomZk/cauxVwtxXiHhffc0lSidT7up0XVlAqP+XKTArVRH2qW7fdfSXQY
 KsM9XjEKW1F6kFIY+zBebBGG6FpCnFGas2E9RaVbFE0jYqgWVuV05ZuqMzc9WoHEHa/8geIkvvx
 2W6e8HLFmu3BOaZAZJ1e9pPjjLqAiklTKWxdxVKEVUxwqYhtkdJ2VuqkpGgFlxF3SBgigzWDklP
 NpJxcwJYRqmjTYH7nuOAzgI0wL1rVwQLWSz/qO9ezvjOGsg/C4mcpIcBTxdADHrBD+pLeMA0qsf
 64ksceyUJkhwaJljAXPqZUL3Ib/8QQ==
X-Proofpoint-GUID: YBDNWCWuHl4UulIxl0z_7hjGVfJRdgxT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 phishscore=0 impostorscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180002

On 10/20/2025 12:57 AM, Emmanuel Grumbach wrote:
> Coverity is unhappy because we may leak old_radio_rts_threshold.

Is this being flagged in a public Coverity instance?

I don't see this at either of:
https://scan.coverity.com/projects/linux
https://scan.coverity.com/projects/linux-next-weekly-scan

> Fixes: 264637941cf4 ("wifi: cfg80211: Add Support to Set RTS Threshold for each Radio")

If there is a public instance, would be nice to add a Closes: tag that points
to it

> Reviewed-by: Johannes Berg <johannes.berg@intel.com>

Reviewed-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>

> Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
> ---
>  net/wireless/nl80211.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
> index 346dfd2bd987..03d07b54359a 100644
> --- a/net/wireless/nl80211.c
> +++ b/net/wireless/nl80211.c
> @@ -4136,8 +4136,7 @@ static int nl80211_set_wiphy(struct sk_buff *skb, struct genl_info *info)
>  			rdev->wiphy.txq_quantum = old_txq_quantum;
>  		}
>  
> -		if (old_rts_threshold)
> -			kfree(old_radio_rts_threshold);
> +		kfree(old_radio_rts_threshold);
>  		return result;
>  	}
>  


