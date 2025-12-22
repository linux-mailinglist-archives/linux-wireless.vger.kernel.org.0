Return-Path: <linux-wireless+bounces-30042-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D9BCD4A08
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Dec 2025 04:29:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A0E46300092E
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Dec 2025 03:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80DE430E84E;
	Mon, 22 Dec 2025 03:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="duau4ZXY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cUdpKDoE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437B7248893
	for <linux-wireless@vger.kernel.org>; Mon, 22 Dec 2025 03:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766374175; cv=none; b=eCVSXRd3anDPcV94WKAYTaZGUA/pSrvAHE1XaJur80iwCFfOliAUDNGqfXYvDzdiP3uBZvRpIeE9v0/rsWy8hdoNglUGyG6yF8VK65Njc0OTY0VuLF+Xafv7owtbs1dSDKkUeHcN1ECewV38RvtoI2+h4efa8j/P6uZp5jFhfh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766374175; c=relaxed/simple;
	bh=0sU1ejJvw3eo0u8bO3uG22uKexKX4P1YrQ0DYLl8jhk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V71maipN+8BhoonL96Ils6fTOSqsYD30XZJrNuyi5FKxjWnEh0v4Ny1sP6QxGJPit9dmK9r43mC5uUKrUb+zsXE7xsVxqrbOPp/81SyiiVe717D7kVD8z4yja3M+UXhZC4jCN45UIfwyodBwztPDeP+8ulTjlHvJonx8PobeoKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=duau4ZXY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cUdpKDoE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BLMtDXW239333
	for <linux-wireless@vger.kernel.org>; Mon, 22 Dec 2025 03:29:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	03tosn1oIY06DUsU9119TY9rYPMnsoOk8CTphbFAzrY=; b=duau4ZXYVPiEMvo6
	WsTyVk1LMY0GouWmSCko2tfuZdaxvHMGI2VzbE6ePAFQAHEtGfwbwZjqxewvd9+H
	Vr5rIFl8dxywNX6Am4or+09T8Ywq5Ow62xQXF5uFyV+kpW/kt8m+M3X/ypE0shUU
	7yeoC2E1JMjwhAI5pPs6qusZIBTlDYNLa2fYUTgZXY4rC9jzUpl+VExdxiFkS85M
	hzHGsl0/htNeQa2mE3xavotqYLBAgkJK7lFf2o7hhDMxrO6qv65d+dOKMh0h0eIG
	CkcZmHyMu/ucNXDD33CerS1UP3LWGhVRpmmoNRYLITafErI1GAlnxUlQp1IaeuW5
	sBQ3dQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b5mubker5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 22 Dec 2025 03:29:31 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2a0d59f0198so46879705ad.1
        for <linux-wireless@vger.kernel.org>; Sun, 21 Dec 2025 19:29:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766374171; x=1766978971; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=03tosn1oIY06DUsU9119TY9rYPMnsoOk8CTphbFAzrY=;
        b=cUdpKDoEJbGeEbpf9M6Mqi8s+eflDk5QlPiiLfMr4XV/Ifqwa/jmzS0H9mGThijS1X
         osgQznYdEHIzgRHj8qv4VmUzRcNpbfq0+tcdf+wbwpLJ3Je8I6zQetelucVEOQzeAocY
         JBIHyMh/n7v5RGTVVcksIhCyui/kFLbQ/fjxVjQdzYz1SpzLYDXX5TgNaNF9Gx6yjaL5
         YB2PxkvbKELh/wLM9W35i2LBH/QgmfBH/wfYIigHgXkO6U9axfd6O7V9nhYd8v2dIm8E
         qbWsLl6IcYfrmtyrpf1ibRZuXUNXCvy9bae2CucPX0EiF58DaIFRoP+Mb7zWSixgIhAf
         hB9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766374171; x=1766978971;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=03tosn1oIY06DUsU9119TY9rYPMnsoOk8CTphbFAzrY=;
        b=q4GTp8E4tysDAfX7PT8Y9ZbvUTDWodiLa1cH4xbWmrsGTfKGdlbx+Pd6G+ReYEt7UE
         5F4mPGiMDtIj7s+CzX+lw5GchNieQ6kmTmIpRl/ruJ5zknjuIyrJyMa5iEDOQmBw4/D0
         bAWJg2apEt4kRQbAmywksHXeHxujY6IrmrPLRj6Efswj+UyaFRsZQ13tuqjiuOnInOWX
         k5mzKIfOF/PwV+OCSD2jVFevncj/2cMOUjnRhBCeWxF2UliESFuaBCTr4EBsuPJJ7KUv
         MzJ93cVTueq+dm9/h+qFZNdkPDMwHwIwkuyDdAw8YEflHs3cFfIh89p1kZV2Wgz1arCP
         vBdg==
X-Gm-Message-State: AOJu0Yz6UKZhx9xajgwRkUoFVBY3RjRqgTCb+NvTHI0NgRI4CtYVKRUA
	Rriw+e+r8w+vqdyI42AlyUvB/Q9gfU0IUfBGBL7qUggNDFHrJQw1Aze0H2VCk+BBjra3WOlrSFq
	b4x0oPVtg2XK0BUvhnYHyePGKavkQH528rbbN3MX49GIhsh6R90KZmGo3tM/ZVB2UOaCr1P0L2Z
	0qmFfZ
X-Gm-Gg: AY/fxX5lYxtwgmWS4XSX4rs+Bc3/ZUsDQ9HyG4DdK6RWF2uRmi6BYfORE6wmbOR1xy9
	nehW5v1Ddluv+UyGsZMi58ugem5lau1n5R6rfPKBa9RHeB+DOmSCjWcwiLagY7+m75D1vAzWZyu
	DvqyfORzMaB3UaN2XE726OHnUrfDGdlYZMAd+C7TWEvf4hx9rUJgN1RM8pzbHQOHhRhWtLR2GDR
	WohgGXrpopWDaX5wr5D+8EnXX/DjVF2sLPW4uqHDpClzXKG1iOUXgCWapDvywBmsjnAY0u9UCVx
	9nZHPqj46H3Z/LEXAojDplIppDcBEkLOcb1USvWMYh37pGydvtb8AnjmqE1y/1/MwY/pus+wxuA
	+w6rw7ylvHsdPeblgoAoffwsafV/E3sdGEIP2fCNzZuA7w1Xf86nQplszLJ6t7ou0ZPO5YEsuBQ
	jMsYS5QhI=
X-Received: by 2002:a17:903:2f81:b0:295:9627:8cbd with SMTP id d9443c01a7336-2a2f27325e1mr87022515ad.33.1766374170744;
        Sun, 21 Dec 2025 19:29:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF3GjsS5o+5kl32Gbw3UPp0tdeIVrVG2KPK3bcyJvkoey9XJo35Hwbql1nLiIKbKZYnH4fUgA==
X-Received: by 2002:a17:903:2f81:b0:295:9627:8cbd with SMTP id d9443c01a7336-2a2f27325e1mr87022315ad.33.1766374170231;
        Sun, 21 Dec 2025 19:29:30 -0800 (PST)
Received: from [10.133.33.213] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3d4d36esm82370595ad.63.2025.12.21.19.29.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Dec 2025 19:29:29 -0800 (PST)
Message-ID: <d88306f3-ad0b-4659-b569-e900c2cf99c2@oss.qualcomm.com>
Date: Mon, 22 Dec 2025 11:29:25 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: ath10k: sdio: Use pm_sleep_ptr instead of #ifdef
 CONFIG_PM_SLEEP
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath10k@lists.infradead.org
References: <20251219173217.768713-2-u.kleine-koenig@baylibre.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20251219173217.768713-2-u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIyMDAyOCBTYWx0ZWRfX7F6/q1PxHhwi
 FOEzADN0NYmx988FjuZSGSxVdLMhoHPcEZ4a7X54t5s3K+TFgZtu+tjuLm6CE8KHrXJOEzeIpnH
 rK/TVwK9VsTGPZNWfjmyfQ13BbqgL4jDceyZmoRi35xA7bVkGrg6fw0Q6cW/NvFUutbhkoqzUcG
 RmxDtNCjF10ScZI2KuyNeNQ1JIqbRNDYF5+EOUQikm6W+p+H28NqDt4CB1EkJliZ/vChrnLMbS0
 dI2p8BTHeuL0CoUbdRy9RZn/zw+/xwcsmull60TJiS4RfbXIlEnATeHJyFcYUFoF/WOk1/0Tkn1
 J4yY8wv7zs+8JpvztarRzB0fkBOsskxakHCar4JQweZinvxFK/bPc9RKqC5/JN+SauUdspDEkFZ
 ZyamDoCTYFKWCdNbI9LNAmUjJtqe1+h4jZu+IAJvwyG7kDPSia0lJbLHHeDDxLWAhVBim+CKiyC
 Kxo0zuJxwdXnRleWezw==
X-Proofpoint-GUID: r-9Cx_l5nKCrDIXhr7e3pn_z7EyWAZwd
X-Proofpoint-ORIG-GUID: r-9Cx_l5nKCrDIXhr7e3pn_z7EyWAZwd
X-Authority-Analysis: v=2.4 cv=KYbfcAYD c=1 sm=1 tr=0 ts=6948bb1b cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=IpJZQVW2AAAA:8 a=EUspDBNiAAAA:8
 a=vfrWMI4ptcQzkJaQMbwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-21_05,2025-12-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 clxscore=1015 bulkscore=0 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2512220028



On 12/20/2025 1:32 AM, Uwe Kleine-König wrote:
> This increases build coverage and removes an ugly #ifdef block.
> 
> To prevent "defined but not used" warnings use
> DEFINE_SIMPLE_DEV_PM_OPS() instead of the deprecated
> SIMPLE_DEV_PM_OPS().
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
> ---
> Changes since (implicit) v1: Switch to DEFINE_SIMPLE_DEV_PM_OPS() to
> prevent warnings. Thanks to Baochen Qiang for the hint.
> 
>  drivers/net/wireless/ath/ath10k/sdio.c | 16 +++-------------
>  1 file changed, 3 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath10k/sdio.c b/drivers/net/wireless/ath/ath10k/sdio.c
> index c06d50db40b8..2e58fb1d2ca3 100644
> --- a/drivers/net/wireless/ath/ath10k/sdio.c
> +++ b/drivers/net/wireless/ath/ath10k/sdio.c
> @@ -2136,8 +2136,6 @@ static const struct ath10k_hif_ops ath10k_sdio_hif_ops = {
>  #endif
>  };
>  
> -#ifdef CONFIG_PM_SLEEP
> -
>  /* Empty handlers so that mmc subsystem doesn't remove us entirely during
>   * suspend. We instead follow cfg80211 suspend/resume handlers.
>   */
> @@ -2172,16 +2170,8 @@ static int ath10k_sdio_pm_resume(struct device *device)
>  	return 0;
>  }
>  
> -static SIMPLE_DEV_PM_OPS(ath10k_sdio_pm_ops, ath10k_sdio_pm_suspend,
> -			 ath10k_sdio_pm_resume);
> -
> -#define ATH10K_SDIO_PM_OPS (&ath10k_sdio_pm_ops)
> -
> -#else
> -
> -#define ATH10K_SDIO_PM_OPS NULL
> -
> -#endif /* CONFIG_PM_SLEEP */
> +static DEFINE_SIMPLE_DEV_PM_OPS(ath10k_sdio_pm_ops, ath10k_sdio_pm_suspend,
> +				ath10k_sdio_pm_resume);
>  
>  static int ath10k_sdio_napi_poll(struct napi_struct *ctx, int budget)
>  {
> @@ -2668,7 +2658,7 @@ static struct sdio_driver ath10k_sdio_driver = {
>  	.probe = ath10k_sdio_probe,
>  	.remove = ath10k_sdio_remove,
>  	.drv = {
> -		.pm = ATH10K_SDIO_PM_OPS,
> +		.pm = pm_sleep_ptr(&ath10k_sdio_pm_ops),
>  	},
>  };
>  module_sdio_driver(ath10k_sdio_driver);
> 
> base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>


