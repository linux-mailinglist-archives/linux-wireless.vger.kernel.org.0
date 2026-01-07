Return-Path: <linux-wireless+bounces-30426-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C06AACFC979
	for <lists+linux-wireless@lfdr.de>; Wed, 07 Jan 2026 09:27:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8633F303A191
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Jan 2026 08:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3646279794;
	Wed,  7 Jan 2026 08:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="a89aR+29";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PwT4MvNP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190C723372C
	for <linux-wireless@vger.kernel.org>; Wed,  7 Jan 2026 08:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767774217; cv=none; b=mWKjIcBXdZmhsVLkuCVWp4VFwiBHyJRumsOd9J7JypqWHIAdNIxOi8FBl0ZDc9ArnVe348tgXz+s5itw/ImcYd3wSEpCzLKjTAbWjiVHXiPk1UOG14gq1v7CX6Kb3l1Lh7AGSGRgnOW2prHaha3r+UHMjAteNqRdqY/y+2ahaSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767774217; c=relaxed/simple;
	bh=mqYuAEoz002Bcwg7J14MVgFQd8uvzbi1FJwyFvYMGuo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SFWh1FCoBh3Ya7zYTe5oMVW04b/qoRhuljjuKTT78v+YDQMH1vOjPzE4m1dqLGWVo2ZM6pdXP3qIf4EWBxz7mC1d9tNXXI8Y4XZ+qGp1Fx1cLrvyWCZgF9myfx8k+WBPpdlul8AfUVcZbXN1E6nNIGc2nK5aqplFEoLZPqup4sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=a89aR+29; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PwT4MvNP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6072vHXt3889010
	for <linux-wireless@vger.kernel.org>; Wed, 7 Jan 2026 08:23:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KBuwaMm4bZ+yPyQdkYpjplpxW3pZ1MDyEeCZZ5McEt8=; b=a89aR+293YWI+gEF
	8hziP09TCK5C4nQIC/AukMkZGEhoNex3EfbRhx9ACXh8Kb+3rC1TPnUNVPgsOPbN
	u672wiLlNsJxcJohaQnzJU8o/niHUcXUt5ez7Y1vI2XlqfRuO5IfJBhff0UzZwk2
	13JENiEhJCDUl0wwpV5bTi+wGTCD+x7ZSZFiMEHlCgaNdO7tOMsXiv2e2CirFcPS
	q7+G3ebbaC9tX8+myN9gtGUhtGtsdTUgExIXivGO1jvlav5qqDSkaRr6y4lS31jD
	vf/Tqa04Otrz3U04nv/Flr3rghM8CIiypNWOcin8y2DOjhh7wnKXn2bV4ulFBtYl
	37Ii6w==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bh6a0jgye-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 07 Jan 2026 08:23:34 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2a0e952f153so49014525ad.0
        for <linux-wireless@vger.kernel.org>; Wed, 07 Jan 2026 00:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767774213; x=1768379013; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KBuwaMm4bZ+yPyQdkYpjplpxW3pZ1MDyEeCZZ5McEt8=;
        b=PwT4MvNPz1mhWvh0sKFl2vIT1Zrmr7m183ku/gTV5ffpobDC78PL8wZ98Y+JUSZmzR
         LO/YuURroBbpQkZegsvt6zS83pAUruUhq8+Wa4ICkVR+pK8aapfEQYD0AqZGJTq6UJjy
         gStA4MRD2p3yaNzwekM8ebL5CWku3zIWZEIITbiXZ0RfdZz3f05fFWbAPdPnOHlmv/DG
         LQXzp+JLLO3v1Q5edTRB/nE946r3b+mqVJ8/YOXQUJzYlAlojyG/IiaVbXiQ94Di6tx4
         WDikQRILenja/MMQch/uih+q8ZYB4r5BWJ+J0iAClqkNyjgMqOZOF61XtCYfrwEXv1rE
         T1/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767774213; x=1768379013;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KBuwaMm4bZ+yPyQdkYpjplpxW3pZ1MDyEeCZZ5McEt8=;
        b=BRJV+bvkRJqGir5eZwFFY8XrtHnHwXQj1/PPUvM2lwd0D0w9NNsZWaHD6fUzqoJXtw
         K6nlqfscUEXMBU7jPDRdkGzhvO2FsVkLUWb74EfDjS6fvF06rwKIT8IIO6tBzPr6s5K0
         WUsBMFh+6Y6xUbQQNI5rCo+EVG2PFoH2jrn3aQD/C/2VT24PzZVsEdbvgpOplaTXIK6/
         sKmuGBX4qMf8uwjc0BMLe2KEDas/YvFWGa36fSp0/gv28DWmxuBa3iU00yzejx9EHd8X
         qPzFbXK68K7uBHGssm2YQNRYGCrepNl4WCH2cChYDkRU6tghf7KKEqX7Vo6Da0/YLJVj
         Qb4Q==
X-Gm-Message-State: AOJu0YxPnjkw2woXHRwPbthhJGl6Vuf1xtfibB/wzjji4zyijGc8aYCs
	UnqUjxBevVH82i3DoJspbdqoknyt7RDkzBCG4P6Lh0lLya3cwpt9JeF1beTH0UCftJOpVp2iJpy
	Lli0bL5DeWmeKuqp3U4KsOvVgn0BdOu+3OKVPmZFp9bNo68+pR04lU/PA8qJ3+a9tpI76Wj1R1b
	/Hmg==
X-Gm-Gg: AY/fxX68YoKd7YHQ/r5X9hQ0LEH837BS0NZJksHEK88D8lXTBW77Yna6jW+1mu4u0tf
	q4dA8bO7ii87F/LtIij+BhtwvqT46RzWvZMTnL60+T6xJYKXzGSaVEW3vzhdI50apaPmGFYXM/J
	4l0nvRdR05CFHF3bUyy3RsFPw6YpgXINIWIoT4N1Bw62PwmXPDfQA107YGdirIDXWGrhfxmHT1S
	gQ6lfRRg2j+mkAEfVEGWvNb9jXk4u1YjGzA+5UWx/O48eQCV9zVNTnuSt69Rjix9dKF4ZhMPqT/
	HKLYdLURUtSMZh8Yli++DkmW+6lOg1xTkTXyg40m9tyf5KmvENpGGbbko4sssRI3fzO3T1xC9HK
	1cQ2hLNGTQBaOfzxg/gWl65abj2XAVMOlzrI1p7Ps9YLf+O8GeN25kja5q5OJ1dZVr7OUwL9DrN
	Qkf8rQIw==
X-Received: by 2002:a17:903:9cf:b0:2a0:c1ed:d0d9 with SMTP id d9443c01a7336-2a3ee49b022mr14956965ad.46.1767774213510;
        Wed, 07 Jan 2026 00:23:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF3TZ4GQaPbdT3f2ezunaG9T1GNbXJf8ctiV6LrSX+qsLZ85jLkn3gXZQO5gR77jNLghh88Wg==
X-Received: by 2002:a17:903:9cf:b0:2a0:c1ed:d0d9 with SMTP id d9443c01a7336-2a3ee49b022mr14956855ad.46.1767774213030;
        Wed, 07 Jan 2026 00:23:33 -0800 (PST)
Received: from [10.133.33.54] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cc88e3sm42588685ad.75.2026.01.07.00.23.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jan 2026 00:23:32 -0800 (PST)
Message-ID: <bac6e271-5bd8-42be-ac20-6873d88c16a3@oss.qualcomm.com>
Date: Wed, 7 Jan 2026 16:23:29 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next v1] wifi: ath11k: Fix failure to connect to a 6
 GHz AP
To: Qian Zhang <qian.zhang@oss.qualcomm.com>, ath11k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20260107060255.29530-1-qian.zhang@oss.qualcomm.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260107060255.29530-1-qian.zhang@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: F31qnrZf78vuZkd8v6O_qVhQ5tK31sct
X-Proofpoint-GUID: F31qnrZf78vuZkd8v6O_qVhQ5tK31sct
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA3MDA2NyBTYWx0ZWRfX+jEp0iJTAT47
 QHRlxik9TPaIpkQjVAQrX9d2KOorlLPbBHooIFAiUIxq0YdTVW3X8JfBodVueFDmS5R1Uo1EC6i
 Uo5ir75tse/cqyjpDE/M+ggXPiOsFT8kqJhgmiI6TCsq7rOUJn7ThntgPQSC4XhuyqTqUSA9f27
 y1kdFNQGnHEcKZkcajwh2c8IWN/HZNS3lpUSeMKtOg/pqYxoVn3XkyOU3EiARbCGPKiMGKR3MxE
 0a/Qr5L3/g6S0MujbBYO7uOwAU7uMTv31as2f3vZ7hO3M3XoYz9YEcYG0YGIDqhwl3906GpoL2Y
 kirKT+SK8gCI0Np09F/NEHQ818arT2YG0qdX8xhBT7BnzGYci4o72nFEpH4dMhrh9mI8r9kS6MM
 GVUf7RxvAdD0DY3xlkhIOizFkM6DKvm/kI0FkK8wJXFzDZmj8VZTjwERHwORJ01gGPp+J/sFc8Z
 6scvFBgnV1LSmtv1Jsg==
X-Authority-Analysis: v=2.4 cv=MtdfKmae c=1 sm=1 tr=0 ts=695e1806 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=PKyBAWt5R5Rl1cvDm-IA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-06_03,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 adultscore=0 bulkscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 spamscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601070067



On 1/7/2026 2:02 PM, Qian Zhang wrote:
> STA fails to connect to a 6 GHz AP with the following errors:
>  ath11k_pci 0000:01:00.0: failed to handle chan list with power type 1
>  wlp1s0: deauthenticating from c8:a3:e8:dd:41:e3 by local choice (Reason: 3=DEAUTH_LEAVING)
> 
> ath11k_reg_handle_chan_list() treats the update as redundant and
> returns -EINVAL. That causes the connection attempt to fail.
> 
> Avoid unnecessary validation during association. Apply the regulatory
> redundant check only when the power type is IEEE80211_REG_UNSET_AP,
> which only occurs during core initialization.
> 
> Tested-on: WCN6855 hw2.1 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.41
> 
> Signed-off-by: Qian Zhang <qian.zhang@oss.qualcomm.com>
> ---
>  drivers/net/wireless/ath/ath11k/reg.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/reg.c b/drivers/net/wireless/ath/ath11k/reg.c
> index d62a2014315a..8786ca3870fc 100644
> --- a/drivers/net/wireless/ath/ath11k/reg.c
> +++ b/drivers/net/wireless/ath/ath11k/reg.c
> @@ -1,7 +1,7 @@
>  // SPDX-License-Identifier: BSD-3-Clause-Clear
>  /*
>   * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
> - * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>   */
>  #include <linux/rtnetlink.h>
>  
> @@ -926,8 +926,11 @@ int ath11k_reg_handle_chan_list(struct ath11k_base *ab,
>  	 */
>  	if (ab->default_regd[pdev_idx] && !ab->new_regd[pdev_idx] &&
>  	    !memcmp((char *)ab->default_regd[pdev_idx]->alpha2,
> -		    (char *)reg_info->alpha2, 2))
> -		goto retfail;
> +		    (char *)reg_info->alpha2, 2)) {
> +		if (power_type == IEEE80211_REG_UNSET_AP)
> +			ath11k_reg_reset_info(reg_info);
> +		return 0;
> +	}
>  
>  	/* Intersect new rules with default regd if a new country setting was
>  	 * requested, i.e a default regd was already set during initialization
> 
> base-commit: e33fc1c6d54ee1569a57255e11c2978ba9a42ffc

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>


