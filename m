Return-Path: <linux-wireless+bounces-23313-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA1FBAC100D
	for <lists+linux-wireless@lfdr.de>; Thu, 22 May 2025 17:33:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58336165BC8
	for <lists+linux-wireless@lfdr.de>; Thu, 22 May 2025 15:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B348428D834;
	Thu, 22 May 2025 15:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="c/xeNK0T"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBF122172C
	for <linux-wireless@vger.kernel.org>; Thu, 22 May 2025 15:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747928005; cv=none; b=Vmo51j6ZW8rLkLjSZpFRyLD38KJRSpie7mYZ0IyxUsb0xCr/MhPqqktcO9wacsDn7EvhmYd2OE/oji+w6zkDr/58IX57jOsp3SJhcf9/CkwCazu668EQFsvUtQsITXtQx3reU2vl/rbkAVxYLMJss7r2lWOg2gU8CHRrHOQKOPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747928005; c=relaxed/simple;
	bh=QmMUdPfn4ztSRHbQ6uyj1D9uRr2DXMNKowS0OgjQOfM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=knfKdyXEvyafhhfLhgq12clGNrPqDm78b43G9bVP+9ljpvqBNvLVZT5yePZDMbfRDT4dxlGYEXSNZU1NwJWUx8DbLoUKn13WFJoYDTNLV1ODyYQ+5av4jDQGmL8v2qkHwxEY43dUukSdhxr/sEssj+tVvP5ufQDrQI4w70rLV2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=c/xeNK0T; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54M8ZdZe027524
	for <linux-wireless@vger.kernel.org>; Thu, 22 May 2025 15:33:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MdS4YPTeQcLMqGWS3uWoTExyrGM6JzmerMv3Q+6wR2A=; b=c/xeNK0ThBeELsAG
	6YDWTAWa5ZnhTXQfX/rwM8997h8/jDaVzanjoVzUd4ioO7M/mVhQo20Eaj9NnIX4
	fDAXCGd4BtfGxeWKG4Y4oV0SS8hGAyD4v2dUNTQ6cHz5CT5viwV662+4Mvx+1tbd
	EJLiGmAKcSOy3ZJQU1UWilnLtA7QWo1kdsVrRnNdQl9LcFPscZ39KvREKb5fuXAA
	wgTtgNEB+3W/VgBeJob1mxWtL3EvYNwTtCEQpxZIblYI3uKHslcDQFZur06XkZ5z
	/txn+RJMPEflJ3g2ro6HIHZLAnoWKi44xMn9PrJRi+05yCm1uLP2FuBbTi7AJq4q
	CyYucw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46s8c25fmf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 22 May 2025 15:33:22 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-23209d8ba1bso51949225ad.3
        for <linux-wireless@vger.kernel.org>; Thu, 22 May 2025 08:33:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747928002; x=1748532802;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MdS4YPTeQcLMqGWS3uWoTExyrGM6JzmerMv3Q+6wR2A=;
        b=KDQruyaTcK0WhLOl5VJg0U0S4+Zf9YLebC4yubG3SFWzI1UiMZTOU1BjAtiTXmkUnJ
         kP5NlAJ7gnjgb8qLs9Ew8tIKGT0eIxfexAK17Xd8u1GWD3AL7Rk21AFcYZR8VuDqCYeu
         GgrhARXAdlAQRBt0X4K/+0hm2O/xiXVCi288ycaJuZ2892F/c9bwA0dKM8BfoHwQiZLr
         kWSQeVwsrxsL5gfYtfIS13qighVvktkvNUCsq7y0Xb1sIBmpvVQ1Vjj733miyA7VaZ2o
         QKUOWvyyW6MT7BgNHCg6YPjhJb1plJTpFR0KpG+aNG7fi4vCmGFnQ2exLydxx+jhYkh9
         PrpA==
X-Forwarded-Encrypted: i=1; AJvYcCWnu90+2COo+V0QGOc76M+rugVlwTUJ4zrvdDNQR2Irzb5rTwZ6LR8GW26VvDpU83VMkwIajYeI5fM9sEHO+w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8RgvD1dbKlF//8HTgVFzVeOc4DHMTG3S6P1oclzxY6Mb9EH8A
	wiMayR4FERoCkCAMBQaXF6imlfC77+79d7YtScerQkFtHTEiPg5ImAFHNA+jb4oUmGVdcTeuouC
	ERy1YbJDFiLtAeFXWrO6BTEcJrsJnu+4QZ3BNboaKmKE6C/0u9WUNSeUj/2ceeP9OIPjp4A==
X-Gm-Gg: ASbGncsexGfnH5Txc7+0wV3CbGBEowEWy/2IY48Qwv/hczEMcbG0FNFHz3WIT7LymWb
	SortTVzTdJgfmHGOogDUsnOneLLuqNM1YJHo7EinVrIjbh6Llqs+r0+SMN80rOJwb5QbJarSbm+
	+8iW+T3jWQ4bg6JzZco3cOcmjcsr6IBTW0GpZ8l7UQ1szeQMT7C+jdDzIGV2I7UzrgxKj3of200
	poScO9E/us8RuSwlZKLxF9GaMkQcJ6QnBTSMMFjhxsyHe2rt+8l/uxYIDxYM2NCUB8YBYqvJJFA
	glabRi5Oo9sj/MQe8UIw1w40tRDVQd8uSOC0soa4H/xrDoZqZPCpepFPQulDERAX7h5RguUdQg8
	xAAqo
X-Received: by 2002:a17:903:2303:b0:21a:8300:b9d5 with SMTP id d9443c01a7336-231d4524c4bmr360572885ad.23.1747928001976;
        Thu, 22 May 2025 08:33:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFkNByRwc0A0/HzOKP5rJ7ZbRS9XUCdJ1a7kCjVVDtfqq+Z01Gf1iVCby5DmblLg9YPnnWZfA==
X-Received: by 2002:a17:903:2303:b0:21a:8300:b9d5 with SMTP id d9443c01a7336-231d4524c4bmr360572485ad.23.1747928001504;
        Thu, 22 May 2025 08:33:21 -0700 (PDT)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2982c04d12sm4399479a12.21.2025.05.22.08.33.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 May 2025 08:33:21 -0700 (PDT)
Message-ID: <22c8e651-8feb-43a7-9a9c-b028e4eb2358@oss.qualcomm.com>
Date: Thu, 22 May 2025 08:33:20 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath10k: Fix unbalanced IRQ enabling
To: Loic Poulain <loic.poulain@oss.qualcomm.com>, jjohnson@kernel.org
Cc: kvalo@kernel.org, quic_svishnoi@quicinc.com, quic_pillair@quicinc.com,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org
References: <20250522120954.605722-1-loic.poulain@oss.qualcomm.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250522120954.605722-1-loic.poulain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIyMDE1NyBTYWx0ZWRfX9AC4zm028Nx2
 RtM/Puv+1nxHtg8Q87gpOcvqw8HPP3jdAwwoDk4FRdya2dGqjrf7raB5WDYaMPUDUK5GNj21dF2
 Eoh874N2Czdea63d9bYMZZ0duqCLEAhUvS1qzHqBwrDZk/LAuT8jdAmbgPKZlREKMFz6v5+odR+
 3JZj/S/dSBJS7St9fftoXEEjyBwn62jWboLblk5y3QtuV7eAql0HuduiTh5/RtW3ezCncPiB8MR
 sxvxi8FMH2eag2GjoYNRqBQF31EYBQXSXgDqMR93ERKciDzwEumhhXiW95m+EvYGp5SzZlr4qYl
 hR8Um7N3BedKqiYdtB3WXh3vzw9x+3y2Y8niiAfC1IlnR3E+3EhBZSKFgd9PfMMpd1521NdA09a
 kKe9I/pYDxNAgacxrbqvEzYjObPanBG4fOr2zz9OAGHBUYWk2NtwW0AxbFxFXfxv2+XjqS/y
X-Authority-Analysis: v=2.4 cv=RIuzH5i+ c=1 sm=1 tr=0 ts=682f43c2 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=e70TP3dOR9hTogukJ0528Q==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8 a=iGDt7Nnd7u1T594T9AEA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: hUftG7lxZwEIMfzTuI5zVDOEvJZCBhKd
X-Proofpoint-GUID: hUftG7lxZwEIMfzTuI5zVDOEvJZCBhKd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-22_07,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 mlxlogscore=579 spamscore=0 lowpriorityscore=0 mlxscore=0 priorityscore=1501
 adultscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505220157

On 5/22/2025 5:09 AM, Loic Poulain wrote:
> When the firmware goes down, both RECOVERY and CRASH_FLUSH flags are set,
> triggering a full recovery sequence once the firmware is back up. This
> includes stopping and restarting the SNOC interface.
> 
> However, this sequence leads to an Unbalanced IRQ warning:
> 
> ------------[ cut here ]------------
> Unbalanced enable for IRQ 112
> WARNING: CPU: 2 PID: 120 at kernel/irq/manage.c:792 __enable_irq+0x4c/0x7c
> CPU: 2 UID: 0 PID: 120 Comm: kworker/2:4 Not tainted [...] #234 PREEMPT
> Hardware name: Qualcomm Technologies, Inc. Robotics RB1 (DT)
> Workqueue: events_freezable ieee80211_restart_work
> pstate: 600000c5 (nZCv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : __enable_irq+0x4c/0x7c
> lr : __enable_irq+0x4c/0x7c
> sp : ffff800081b3bab0
> [...]
> Call trace:
>  __enable_irq+0x4c/0x7c (P)
>  enable_irq+0x48/0x9c
>  ath10k_snoc_hif_start+0x6c/0x13c
>  ath10k_core_start+0x360/0x1344
>  ath10k_start+0x100/0x8fc
>  drv_start+0x34/0x58
>  ieee80211_reconfig+0xf4/0xfc0
>  ieee80211_restart_work+0x110/0x17c
>  process_one_work+0x150/0x294
>  worker_thread+0x2dc/0x3dc
>  kthread+0x130/0x204
>  ret_from_fork+0x10/0x20
> ---

this causes git to chop the description at this point, which also chops the
tags, so remove it.

> 
> This can be reproduced by restarting rmtfs or triggering remoteproc restart
> via sysfs.
> 
> The root cause is that IRQs are not disabled during SNOC stop in recovery
> scenarios, but are unconditionally re-enabled during SNOC start, leading to
> an imbalance.
> 
> Fix this by skipping IRQ re-enablement in `ath10k_snoc_hif_start()` if a
> firmware recovery is in progress, restoring IRQ state symmetry.
> 
> Fixes: 0e622f67e041 ("ath10k: add support for WCN3990 firmware crash recovery")
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> ---
>  drivers/net/wireless/ath/ath10k/snoc.c | 3 ++-

My Qualcomm copyright checker flags:
* drivers/net/wireless/ath/ath10k/snoc.c no QuIC copyright

>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/ath10k/snoc.c b/drivers/net/wireless/ath/ath10k/snoc.c
> index 866bad2db334..e15e1ab30458 100644
> --- a/drivers/net/wireless/ath/ath10k/snoc.c
> +++ b/drivers/net/wireless/ath/ath10k/snoc.c
> @@ -937,7 +937,8 @@ static int ath10k_snoc_hif_start(struct ath10k *ar)
>  
>  	dev_set_threaded(ar->napi_dev, true);
>  	ath10k_core_napi_enable(ar);
> -	ath10k_snoc_irq_enable(ar);
> +	if (!test_bit(ATH10K_SNOC_FLAG_RECOVERY, &ar_snoc->flags))
> +		ath10k_snoc_irq_enable(ar);
>  	ath10k_snoc_rx_post(ar);
>  
>  	clear_bit(ATH10K_SNOC_FLAG_RECOVERY, &ar_snoc->flags);


