Return-Path: <linux-wireless+bounces-27976-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0EE6BDC050
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Oct 2025 03:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A62203C7A24
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Oct 2025 01:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E99729B766;
	Wed, 15 Oct 2025 01:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iTIFByBG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3D42C029E
	for <linux-wireless@vger.kernel.org>; Wed, 15 Oct 2025 01:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760492757; cv=none; b=J0v4bSZ0sRs2LXxhvPsLiPnzV+XGNsNJIhKZ5gl9jXQrTjkTxUlZbdiYcf7zyfdCxQ1uuKFWOprlRn8k9xPEJ6M1VzeAcHNalc1FCRMI7eeZIbxVOiGUcdEYCQxD/2bvtcQDMZ0YTLaqwr7yEeE019f516kj+g/I8prbnhjcaMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760492757; c=relaxed/simple;
	bh=HvQWZPtcPcibYB3LZXntktXaSDc1pGnKwnL4OU5g5gA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LVp5MDPVcMo5SQDuC/fNtynk87u39oCbygHnZRRxXc7irPoxswF3Vm9dd3hSU1LsEpOnOqbmRatGnbtwUpmMuBbsbZHptvX9y6+jW4iTlStDQ0ZuxNfsO8FUj2YtkZawFLRqrBVecGDUlBZaweOqtwMuxuf1P8ZaBauVM01U64I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iTIFByBG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59EKR58s005481
	for <linux-wireless@vger.kernel.org>; Wed, 15 Oct 2025 01:45:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wi+qHeURx+JoyERr9BSMduX/XPgpjpnOYZE1uQwJSa8=; b=iTIFByBGb9OPzPWa
	M9yMninQYGaTRP7nT7nTifSWPPiphexxkX2D4u9cfsTPERCSWRUZOFqiq450p1Kv
	tl5FemMHSye7c/+dwsxLindsjyHnXtwQ2/MdmetfzCEYGHMeiOvCqBGkGstKMtwL
	FB1CfEDcW6bZ+39I1/YEsLRpMjiMBiNfiJFviO6T34drbvmcLogReaQE29rE6nmu
	NdYP309/xETv+b5l6rDNOl/1DCqgnChQUHgm2LKqbqb57rbsCQ5DI5DLAIy+aaKX
	Ntu6amVgP18JYz7Mw6p/G/HONXIUnyIOmXKMNm6mwWvn0fQn5OdxI3ldyGIK1VzD
	wB2ffg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfa8apnr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 15 Oct 2025 01:45:53 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-28d1747f23bso104492125ad.3
        for <linux-wireless@vger.kernel.org>; Tue, 14 Oct 2025 18:45:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760492752; x=1761097552;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wi+qHeURx+JoyERr9BSMduX/XPgpjpnOYZE1uQwJSa8=;
        b=wdUwJV2RKTpMr7ePWoOweaPl2Om3+7HF9L8uQqCNwGGxD0dgArCDm3wSQlwsNz70g/
         t52iYLoSr640kUwyf6SC4+eQD5WhfYPu0Tu6rFiZZ0JrdswCZhVa46JvYcQ95p+YFmye
         klJRgNeODLPok724lYXhIoDW+6/75lP/Woyn4Fe8+w4GLr6H42ePSiA7Txyh1asru3nG
         Am58qMH0LqKzkxFcWcVCE6BHzvbjXzfkYCtRn56CclRKQmToC0ps4TxrXN0Y/ENDcUQD
         gOfIQbRhNqgLIdnhmi5d84NekqPvKAEI4EO28IDBcyZl7HDSsY+rX4ClpTz5X5tTPDXx
         Y8tA==
X-Gm-Message-State: AOJu0YzyW69GJMyUniRTK0TtnnPuzokluyFAhsruVUdN5UCPBkc2httU
	Y+bQ0eS4piRcisG3HE31zWmZqNURTo6yloChHwIjOPol6w4K2wHEVDL1cbQYjhWjvirEGIazPWf
	75bMmvf3BHdd+m/YZ2Y2eKb78X1iRrPe7a1Bd8XL9Arhp2HgCs78w2ax1HtqdFa7KaS1Ojb5C9Z
	cVVw==
X-Gm-Gg: ASbGncu+lordZIOzHMVuh9ebjvmxQJSJPQQhrDregywMNsgay2yf1RLZZF80f0RUe/h
	hNJ4UGDoiNJ4nj4E5JMy2m1BNOM0EIxUcTxL0zwn5Uji13BNaKuaIBOAk4oR//3AEHqv+++uj0j
	hTfHhQNQDGMVI8BXi2/2hF9iXwXVP4GujtHnW5w7C2AABRYLGI54QunYniPqq/mmdMp81Mz1Ddm
	eTarAoyVIWr2yh5uQ1hYMLTVDXIrap16/Ha+Z5TvfkI3V1RZp+Ol3T96sBwM5izkWqRmKXaPERx
	gLLrmium2ENwW9lVqq5rHw+SNypooP5DozsRv35U4Bj7O446BhJwxId6KMVE8LR/7hStf4yxrk5
	gxzrgxvq/p7UR9xlLMUsyXv4tDu0ndRCJFPxw
X-Received: by 2002:a17:903:faf:b0:25c:ae94:f49e with SMTP id d9443c01a7336-290273ef0ccmr291831005ad.37.1760492752505;
        Tue, 14 Oct 2025 18:45:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFP/carV3DSUZEvBbiZSYQgiBkX/5A33RSXtVQ9JNbEUxmehndBzuBL5WbWze03nMri9S7E5w==
X-Received: by 2002:a17:903:faf:b0:25c:ae94:f49e with SMTP id d9443c01a7336-290273ef0ccmr291830615ad.37.1760492752001;
        Tue, 14 Oct 2025 18:45:52 -0700 (PDT)
Received: from [10.133.33.61] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f39a4fsm178174605ad.106.2025.10.14.18.45.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Oct 2025 18:45:51 -0700 (PDT)
Message-ID: <cb3ac428-0caa-46ab-9d71-088a7be54fdf@oss.qualcomm.com>
Date: Wed, 15 Oct 2025 09:45:48 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next v3] wifi: ath10k: move recovery check logic into
 a new work
To: Kang Yang <kang.yang@oss.qualcomm.com>, ath10k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20251014110757.155-1-kang.yang@oss.qualcomm.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20251014110757.155-1-kang.yang@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: FJYmMsBXveP5BcHgYaDtLcoqfIp33bSW
X-Proofpoint-ORIG-GUID: FJYmMsBXveP5BcHgYaDtLcoqfIp33bSW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxNyBTYWx0ZWRfXw+laMwJeTgut
 n980YAcprqAJlOHYjrtDgYXx147Ma8hWdWLPD+rSu9H9f6oDGsKXRrE4d8oDwSUw36Nhms/GJjH
 TqZYuFW8yQL6cF7bxu5Izg4WNw3DnD0RhsfObBlDkyEoqzMGegCcRyjaSlDpvNL3AKPKFYHw8nm
 LQ4/Vf7i2c5+7PU39UyasbXZuFKloJKDRX4+kBvBztBPWwMFvDPGv+XrU9RUbLKJ9EYX7l39q/J
 3XQdDibKdvAXOvdp2upH7QQ+7oJw1gCBcsLanrJnDXzYsxPeIJdP1Z3tbEnMHt08V4ArS8mGPb0
 CYvFHKtWey6yUlF0z0B32V4JNPhsfiDuVBi1S+TX3Q+e26fdNDKIPPBz/PYAUCzW6MKqpwsNUHl
 WrRxRHLF7i96/nLoYl9reEXfzqkvCg==
X-Authority-Analysis: v=2.4 cv=JLw2csKb c=1 sm=1 tr=0 ts=68eefcd2 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=MXRxBWRP9Sj2SVTaot8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_01,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110017



On 10/14/2025 7:07 PM, Kang Yang wrote:
> Currently, ath10k has a recovery check logic. It will wait for the
> last recovery to finish by wait_for_completion_timeout();
> 
> But in SDIO scenarios, the recovery function may be invoked from
> interrupt context, where long blocking waits are undesirable and can
> lead to system instability.
> 
> Additionally, Linux’s ordered workqueue processes one task at a time.
> If a previous recovery is still queued or executing, new triggers are
> ignored. This prevents accurate tracking of consecutive failures and
> delays transition to the WEDGED state.
> 
> To address this, move the recovery check logic into a different
> workqueue.
> 
> Tested-on: QCA6174 hw3.2 PCI WLAN.RM.4.4.1-00288-QCARMSWPZ-1
> Tested-on: QCA6174 hw3.2 SDIO WLAN.RMH.4.4.1-00189
> 
> Fixes: c256a94d1b1b ("wifi: ath10k: shutdown driver when hardware is unreliable")
> Signed-off-by: Kang Yang <kang.yang@oss.qualcomm.com>
> ---
> 
> v3: explain why use different workqueue for recovery_check_work.
> v2:
> 1. use workqueue_aux instead of workqueue for recovery check work.
> 2. add Test tag.
> 
> ---
>  drivers/net/wireless/ath/ath10k/core.c | 20 +++++++++-----------
>  drivers/net/wireless/ath/ath10k/core.h |  2 +-
>  drivers/net/wireless/ath/ath10k/mac.c  |  2 +-
>  3 files changed, 11 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wireless/ath/ath10k/core.c
> index 6f78f1752cd6..9ae3595fb698 100644
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
> @@ -2518,27 +2518,24 @@ static bool ath10k_core_needs_recovery(struct ath10k *ar)
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
> +	/* Use workqueue_aux to avoid blocking recovery tracking */
> +	queue_work(ar->workqueue_aux, &ar->recovery_check_work);
>  }
>  EXPORT_SYMBOL(ath10k_core_start_recovery);
>  
> @@ -3734,6 +3731,7 @@ struct ath10k *ath10k_core_create(size_t priv_size, struct device *dev,
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
> 
> base-commit: 38cf754c15eeb0d80fbf52c933da10edb33d7906

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>


