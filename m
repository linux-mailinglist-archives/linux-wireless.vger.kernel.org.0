Return-Path: <linux-wireless+bounces-27579-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A6FB8FE35
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Sep 2025 12:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C3EE189DA00
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Sep 2025 10:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A41D17A5BE;
	Mon, 22 Sep 2025 10:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lLEtZqGF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD34182B4
	for <linux-wireless@vger.kernel.org>; Mon, 22 Sep 2025 10:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758535232; cv=none; b=nnc1FQS/y9NUvSjXBFQottvGcILIfOcGh115DCEpVkQ1Gv8AWjmUbwpzhfU0NNxG+mteWj+zPU+oU7RqaTxOFvNb0PoU0iyFB4kD3drZqwmG0KbD6GEHVkbnicW6OpheRTDCYvGb2dENh3se4FF0pLi5xxi7ReAn+sw5uJdWEpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758535232; c=relaxed/simple;
	bh=WUjf2nr/zBVgTBH19HZHpA2Urqn/4+Zx8YVX6YrCq30=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=df0VW5f+lV091xV23+zb7R71gz8uBHTpUvm6boBxHxjTc3z+rlkn1+FsdWP7G/nhQnU0ow7OhI1t+tF/LrC+t2xRTk7Lh3xVBC+uyl7zXmG08smEhB4h3qGxi9IViwk8phT0tAKGMmfM7cV6xLJslyoKy4bvANmOVwUE/lsw/FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lLEtZqGF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58M90bMN017057
	for <linux-wireless@vger.kernel.org>; Mon, 22 Sep 2025 10:00:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PY4sY6MmrFt3xxsaiWMW5QYeC8Yx0jKssOaY6t1KKpY=; b=lLEtZqGFMgPnHcr/
	KOksm0XgShheHAArOKMspnID8roMuBH6M0YA/caR9BnYPu59XAI4efzsjxJ8cY6C
	OCKkJ6XyIF0pJdraddn52bRFC+FCOh5GGZdoCPA99k43MYIMz+begh0fRGRko85E
	6U68c3B7YDP17/qYagYHJggjRxHT3SPFYURX5jcq5QaOGVU3ZoKHDGFYro1VDG9q
	hTCM6eLEmm7q9NR3Nt+RgZ2DfSOPap+MadY1Lv9gw9kc6WQ3SCl9bi9HYt0+gxPT
	SohpnCOWZ/91Hlby554/p71edbCJhP4S5nsNqgQkcC1UGL4iic7TwvBKcUJLS62f
	DXh12A==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499k98cbqg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 22 Sep 2025 10:00:29 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-77f352c04adso897909b3a.3
        for <linux-wireless@vger.kernel.org>; Mon, 22 Sep 2025 03:00:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758535228; x=1759140028;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PY4sY6MmrFt3xxsaiWMW5QYeC8Yx0jKssOaY6t1KKpY=;
        b=lUvKArcruKZi8LpD0g+UhHQsXRcG8sjqw01lJ0LO0lG7K4dwfInJOjVGqv1l9D+L1B
         a3NgYB4B5VwM9vmWvOqF3rhpwKEwpwt8499ZkM98/kHIHOfEpJ9edbXE8iG4WwEq/WjL
         ON9o+3qsQHBMMchz0HcTpjpbKrXaR7uwoG69goxXWQLePvuGshcl9Z1cnHQY7aqu8+NR
         AOiop6VAwKGRT88NXnzdsq1b3RoY+Msb2lNrMavUmTQfX1iUB4DNVeyYbNpVs7ptJkrZ
         3AxQzMP5Liit96nwv85YyFwbtV2vrvz/MwWE9DXcyurEYRJSSpbleLtZ4oVGArlLER9S
         UAfg==
X-Gm-Message-State: AOJu0Yy9tgwVSnewI5ydpaUkpcxjP/91foI/zo6CFfVHMyM/IjYEGSYR
	816C+nsn3v9LGxcBrfpnNzjG3+08FSXtPH+MEEyW86icdUeGP3+psknN/60G7YcnlnS77lSjG79
	YXnE7P2SuamMIgN59t7HiF8JT4US9qXND+YvOUh0FO0IDdWU4yKhtmv/saIumeJJF7UtFHA==
X-Gm-Gg: ASbGncs90fwfD0J23uFbVzSoGuWbD+mO4TwgkB/QcKiy1CVYW0wK6mjW86n4Dl/qTxc
	/qbv2LMFu7Fpr5DFO6sbUQihsCIyQxdVbgmBNvsWzn/jgHtfuWWMbRObuNc2EooNpvYoGwlZJlk
	Uo6yrnQL+1SexZ+gnNOtAvf+s62wAu0nWMey2zkUbBm3RokRIIDfYnMHq9HgE70JYXTnrXVfzoX
	ukjjgAq4AfWwZchTbQd7iU02BECRi8W4czE27g7FbgmTkjo2xleGMqnE9fTuqoYaaCOP6l8uqeY
	QWrYBLc7ZedAsAIDjZ3lsSxGEECqbQ7iO/VLATz47fa05BZlDsFtKa8RWmM3GxCPYDLR4nMUCLY
	6YnzKTiS0YUr46g6dpW1yQmnvzpjblILaTXw9
X-Received: by 2002:a05:6a00:22d1:b0:77f:414d:3774 with SMTP id d2e1a72fcca58-77f414d38e0mr2261247b3a.4.1758535228085;
        Mon, 22 Sep 2025 03:00:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECC0E5x38QUGEQsU0mrBt2q89oRS5DQAvPo5rg7+WX8hj7GkAgpphvgJRzcLcQaUXkRnqWgQ==
X-Received: by 2002:a05:6a00:22d1:b0:77f:414d:3774 with SMTP id d2e1a72fcca58-77f414d38e0mr2261180b3a.4.1758535227365;
        Mon, 22 Sep 2025 03:00:27 -0700 (PDT)
Received: from [10.133.33.83] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77cfc2473d0sm11963900b3a.27.2025.09.22.03.00.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 03:00:27 -0700 (PDT)
Message-ID: <95f50699-fe14-4858-aab6-f2e5a427587c@oss.qualcomm.com>
Date: Mon, 22 Sep 2025 18:00:24 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next] wifi: ath10k: move recovery check logic into a
 new work
To: Kang Yang <kang.yang@oss.qualcomm.com>, ath10k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250922063112.1324-1-kang.yang@oss.qualcomm.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250922063112.1324-1-kang.yang@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: v1UnH-RZfJ7lPwB1pUy0VDb22wyhvlAA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAxOCBTYWx0ZWRfX7A8ZX3UZvi1H
 XwifjKESQQGNDjDVJGHpu7OAEsiKFTnqk5zCciiEzKZZ5jMvgwXBsuLjBRXLT8E+cmqizxiiCqV
 eoHlc+ia8ddZARnEiPicToAiKQvdMsNdepMJVBugrusOz2AkXfrYkEta7I7Ul55wKNvOA5agmAA
 nZc6ALu5CXHyGfQx/HDDcDOxrcgj6mi2mPygvIer6TVF5mtH9dMu2g7MI/Ur7zWVV94dMleTaX+
 HA/U6lVhWjcH+eHvV9A5h/7et5gmq7qQh84VVDCS/5+NZPveP14/hMpNQcEgcmuhBolNe1n7iKS
 +Qx8fRMxcECpqFch2itK9pbR3xKCu4G/JW8b6acVeyB1zI5l76tSiMmPHIiiaHh2NHtxRAlPvNf
 6nos6WFB
X-Proofpoint-ORIG-GUID: v1UnH-RZfJ7lPwB1pUy0VDb22wyhvlAA
X-Authority-Analysis: v=2.4 cv=Dp1W+H/+ c=1 sm=1 tr=0 ts=68d11e3d cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=MXRxBWRP9Sj2SVTaot8A:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-22_01,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200018



On 9/22/2025 2:31 PM, Kang Yang wrote:
> Currently, ath10k has a recovery check logic. It will wait for the
> last recovery to finish by wait_for_completion_timeout();
> 
> But in SDIO scenarios, the recovery function may be invoked from
> interrupt context, where long blocking waits are undesirable and can
> lead to system instability.
> 
> To address this, move the recovery check logic into a workqueue.
> Fixes: c256a94d1b1b ("wifi: ath10k: shutdown driver when hardware is unreliable")
> Signed-off-by: Kang Yang <kang.yang@oss.qualcomm.com>
> ---
>  drivers/net/wireless/ath/ath10k/core.c | 19 ++++++++-----------
>  drivers/net/wireless/ath/ath10k/core.h |  2 +-
>  drivers/net/wireless/ath/ath10k/mac.c  |  2 +-
>  3 files changed, 10 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wireless/ath/ath10k/core.c
> index 6f78f1752cd6..991fe8d92297 100644
> --- a/drivers/net/wireless/ath/ath10k/core.c
> +++ b/drivers/net/wireless/ath/ath10k/core.c
> @@ -3,7 +3,6 @@
>   * Copyright (c) 2005-2011 Atheros Communications Inc.
>   * Copyright (c) 2011-2017 Qualcomm Atheros, Inc.
>   * Copyright (c) 2018-2019, The Linux Foundation. All rights reserved.
> - * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
>   * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>   */
>  
> @@ -2493,8 +2492,9 @@ static int ath10k_init_hw_params(struct ath10k *ar)
>  	return 0;
>  }
>  
> -static bool ath10k_core_needs_recovery(struct ath10k *ar)
> +static void ath10k_core_recovery_check_work(struct work_struct *work)
>  {
> +	struct ath10k *ar = container_of(work, struct ath10k, recovery_check_work);
>  	long time_left;
>  
>  	/* Sometimes the recovery will fail and then the next all recovery fail,
> @@ -2504,7 +2504,7 @@ static bool ath10k_core_needs_recovery(struct ath10k *ar)
>  		ath10k_err(ar, "consecutive fail %d times, will shutdown driver!",
>  			   atomic_read(&ar->fail_cont_count));
>  		ar->state = ATH10K_STATE_WEDGED;
> -		return false;
> +		return;
>  	}
>  
>  	ath10k_dbg(ar, ATH10K_DBG_BOOT, "total recovery count: %d", ++ar->recovery_count);
> @@ -2518,27 +2518,23 @@ static bool ath10k_core_needs_recovery(struct ath10k *ar)
>  							ATH10K_RECOVERY_TIMEOUT_HZ);
>  		if (time_left) {
>  			ath10k_warn(ar, "previous recovery succeeded, skip this!\n");
> -			return false;
> +			return;
>  		}
>  
>  		/* Record the continuous recovery fail count when recovery failed. */
>  		atomic_inc(&ar->fail_cont_count);
>  
>  		/* Avoid having multiple recoveries at the same time. */
> -		return false;
> +		return;
>  	}
>  
>  	atomic_inc(&ar->pending_recovery);
> -
> -	return true;
> +	queue_work(ar->workqueue, &ar->restart_work);
>  }
>  
>  void ath10k_core_start_recovery(struct ath10k *ar)
>  {
> -	if (!ath10k_core_needs_recovery(ar))
> -		return;
> -
> -	queue_work(ar->workqueue, &ar->restart_work);
> +	queue_work(ar->workqueue, &ar->recovery_check_work);
>  }
>  EXPORT_SYMBOL(ath10k_core_start_recovery);
>  
> @@ -3734,6 +3730,7 @@ struct ath10k *ath10k_core_create(size_t priv_size, struct device *dev,
>  
>  	INIT_WORK(&ar->register_work, ath10k_core_register_work);
>  	INIT_WORK(&ar->restart_work, ath10k_core_restart);
> +	INIT_WORK(&ar->recovery_check_work, ath10k_core_recovery_check_work);
>  	INIT_WORK(&ar->set_coverage_class_work,
>  		  ath10k_core_set_coverage_class_work);
>  
> diff --git a/drivers/net/wireless/ath/ath10k/core.h b/drivers/net/wireless/ath/ath10k/core.h
> index 8c72ed386edb..859176fcb5a2 100644
> --- a/drivers/net/wireless/ath/ath10k/core.h
> +++ b/drivers/net/wireless/ath/ath10k/core.h
> @@ -3,7 +3,6 @@
>   * Copyright (c) 2005-2011 Atheros Communications Inc.
>   * Copyright (c) 2011-2017 Qualcomm Atheros, Inc.
>   * Copyright (c) 2018-2019, The Linux Foundation. All rights reserved.
> - * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
>   * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>   */
>  
> @@ -1208,6 +1207,7 @@ struct ath10k {
>  
>  	struct work_struct register_work;
>  	struct work_struct restart_work;
> +	struct work_struct recovery_check_work;

Instead of adding a new work item, how about just moving the recovery check logic into the
exsiting restart_work?

>  	struct work_struct bundle_tx_work;
>  	struct work_struct tx_complete_work;
>  
> diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
> index 154ac7a70982..da6f7957a0ae 100644
> --- a/drivers/net/wireless/ath/ath10k/mac.c
> +++ b/drivers/net/wireless/ath/ath10k/mac.c
> @@ -3,7 +3,6 @@
>   * Copyright (c) 2005-2011 Atheros Communications Inc.
>   * Copyright (c) 2011-2017 Qualcomm Atheros, Inc.
>   * Copyright (c) 2018-2019, The Linux Foundation. All rights reserved.
> - * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
>   * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>   */
>  
> @@ -5428,6 +5427,7 @@ static void ath10k_stop(struct ieee80211_hw *hw, bool suspend)
>  	cancel_work_sync(&ar->set_coverage_class_work);
>  	cancel_delayed_work_sync(&ar->scan.timeout);
>  	cancel_work_sync(&ar->restart_work);
> +	cancel_work_sync(&ar->recovery_check_work);
>  }
>  
>  static int ath10k_config_ps(struct ath10k *ar)


