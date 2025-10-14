Return-Path: <linux-wireless+bounces-27962-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0003BD7207
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Oct 2025 04:51:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E501518A7CD4
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Oct 2025 02:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EBCB3064BF;
	Tue, 14 Oct 2025 02:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ShoDFbnr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8110922257E
	for <linux-wireless@vger.kernel.org>; Tue, 14 Oct 2025 02:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760410311; cv=none; b=nmi9EOcPcN8x+hzi66Ed3UHCz4i6cf00kbIXqg52HnpQyKQfA+eQycqgxgXvVFXfLSn+9vWN15oNbAsO9oODPIp6l7HtFZ++If9cRy4ZjM6fDh3asL15lEJuAM2HQEG8rFxCNQ3zQeLrrrEVd5kTd7E2c1JztTae6EKh6aj99Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760410311; c=relaxed/simple;
	bh=bfKWqbEXuLR/z3q7J3gzdBPcDAfImlv+yW7F/Og+3ow=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FdvcKOh2FlQGcTFc2ZbXgtEty1yQgLskeF6hJFLhIen+i2twkEz69f26TGCh37727mf53q0RDIVYj9o5Tfak1JgsyWdASv3OIrcnrG9+od8jvWd4IeAeogO64iQVORH3OYui94a2jcJsZ6rcb19guFcxw+1LY5GMs+QvACKfOlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ShoDFbnr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59DHDLG8009034
	for <linux-wireless@vger.kernel.org>; Tue, 14 Oct 2025 02:51:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1gVDyzrphOs3pbHINLKrp4Ebo0h/CHiw5SZj/VxIP2k=; b=ShoDFbnrdL0/NATN
	fYgg2YKHqc38SnPORBsnvRhJLFui5SD4blrhRdnbzO5oe2fyaiQc5qsfKGGqrPRX
	VyZ6+sTiQQ66FZjWHQEAF6AFj/tzwqRzm5Hr46ExC/eA3ZuvxgoJsCfOP56YdaQC
	LQWGB/oWvMzXaSFAbwIKblMsRX1Q42/w6a8IW1vGX7alOA6J9XBzAf+zNkQXhQzz
	OmFSxuBXcsaRBkBW05UUsJAdgXOCvTMhavPcHbA0cNs0nhEUjKWLrpS3wpJcYOi+
	SlFx/pVqb7jpJuvRN5WZbOabY5LpatzWOA8R0ThtmGiPb5MlU4TQ2WKHZ68hUDOg
	iV3pVA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49rtrt3php-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 14 Oct 2025 02:51:48 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-269af520712so93757955ad.2
        for <linux-wireless@vger.kernel.org>; Mon, 13 Oct 2025 19:51:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760410307; x=1761015107;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1gVDyzrphOs3pbHINLKrp4Ebo0h/CHiw5SZj/VxIP2k=;
        b=U73l2lMUXMie/C1hbmO6GOzG1oCPzoZ0+El5LGfvA4yPDjzEhLHJ/QBgV25NTsgg+B
         CQfyraEWNJSUHQ3mVIRKRtAIF8TOywycCNCk8O6fDhVH2SqGNnEFsBosLwFBSg4jl6cs
         +o2T0k9h76SlU8yjs4VBCDflWkO/rvM49sPwDj82jaLbw9TgVrh47qt9hquvj2UFk6Z3
         0/m1Xs1cdf5DjyBcWmD5QRQctinXt0Yiyy44B7KJin4G0fJGlCns/0I4S9YAiP+X21w/
         VfryrrJSgSZJrvllmR6E+sytIHv8RATP8ucr51jwmH3HQgN9Vx0YIG9akVlDCi7QPdS3
         nhLg==
X-Gm-Message-State: AOJu0YyhrBPI4qslKhVUUVhtVN68amCE38h54DG51TEBWfKNE9ztWenO
	sepwsUeXlZObp08riCTQgbvgLe72+62rOYa5EGZxbYuQ+bYOXqIYGzpeiDTMNNEcibJyIt3XDUU
	zyQQLBX2BDDDR+QhDN8V8j7LfsmEcdw4hIFJxJkxHEh8XRdf6sBb0ZalyDf9Edfnx3D+Ryg==
X-Gm-Gg: ASbGncv4ClQdRWizBDoe9COTY4+V/L+zboOSiVsjI/KnC9XcfCPp3iM767eGJ75E4+5
	lMS79VoKMJU24kNb4Z7QrxSkh3+NjsOhXItSdwR8sEhhapSwVUP1syLPeCQjf5aaJ59b0cHwB/u
	3drPflGfXZuUsJ0DOVuq0upMev1242Gt3DIMXldo85Sw6y6xrJmH7RNUUt2+99paJaPelehcA/C
	ABvgsGvCtTQG+gLfHb6U6niWq1PC8taxCwFdBzko3PVPvps8H7MjJYeuAmyJFsl9+QTdqdgFkpr
	qzfHR72n6xleN3ea40mdofwoEmMzOcuL58N9k9GK7FlygNQf04B999UxYwYQ3zVAukIj+u92hTT
	EW6qm6ElSEA+mAOPowJgiq2bjOcxRcOiyRxaf
X-Received: by 2002:a17:903:2c04:b0:28d:195a:7d79 with SMTP id d9443c01a7336-290273569aamr306125705ad.5.1760410306937;
        Mon, 13 Oct 2025 19:51:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHpa61mGAcNlYAAxBwg8YS76gvxygMOuFhT4ceD8lXjMnFgIk8i/WkiP1sKA9zxQlNcbKp/9A==
X-Received: by 2002:a17:903:2c04:b0:28d:195a:7d79 with SMTP id d9443c01a7336-290273569aamr306125415ad.5.1760410306460;
        Mon, 13 Oct 2025 19:51:46 -0700 (PDT)
Received: from [10.133.33.61] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b67d313e7f9sm2407602a12.12.2025.10.13.19.51.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 19:51:46 -0700 (PDT)
Message-ID: <10d9bfef-367f-49ce-a7c6-445001e32199@oss.qualcomm.com>
Date: Tue, 14 Oct 2025 10:51:41 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next v2] wifi: ath10k: move recovery check logic into
 a new work
To: Kang Yang <kang.yang@oss.qualcomm.com>, ath10k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20251013053259.546-1-kang.yang@oss.qualcomm.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20251013053259.546-1-kang.yang@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: Uw8FrNsvM4A-DmhPiIdWfiTwkif0ZEgL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEzMDAyMiBTYWx0ZWRfX0mUM0AN659FW
 hV76s0Fldw5avsS6YYD8nTTbyPAm1dApv70aCUad7i+Z37sY1g0lnheu5y2VdGNK2kNa0P0n3+z
 y/Kst7bKWUKhvWXMOpdT0X1h4sWnTfZmNDzARt5q5jg/9A2e0K0600fgfNuasKz4QA0kNyAu6KJ
 Q5l5FG3Oyeq37p8awpS0SlmYNjRaPNZzhaW5K0BOTLKBRAu9ChcPBYYixo7Qww9Itb6y7R4oRNi
 2FrofrVscjwTqug69cv7+U7AZ5XQ+AGBrZCkDzA8EO+Umz7NA4DBO0Swd1wlsxPGRK90LwNUq1U
 6890AnqxOtC4NdbGiBL86wyhWMNPHwlNX0IUIfQ4uiLwOK/kkkDe5oYa+ndQZ/CmzB3OlDWb0HP
 418qwL8SZOz919HxjqgBj61TdSB/sg==
X-Authority-Analysis: v=2.4 cv=SfD6t/Ru c=1 sm=1 tr=0 ts=68edbac4 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=MXRxBWRP9Sj2SVTaot8A:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: Uw8FrNsvM4A-DmhPiIdWfiTwkif0ZEgL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_09,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 adultscore=0 phishscore=0 lowpriorityscore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510130022



On 10/13/2025 1:32 PM, Kang Yang wrote:
> Currently, ath10k has a recovery check logic. It will wait for the
> last recovery to finish by wait_for_completion_timeout();
> 
> But in SDIO scenarios, the recovery function may be invoked from
> interrupt context, where long blocking waits are undesirable and can
> lead to system instability.
> 
> To address this, move the recovery check logic into a workqueue.
> 
> Tested-on: QCA6174 hw3.2 PCI WLAN.RM.4.4.1-00288-QCARMSWPZ-1
> Tested-on: QCA6174 hw3.2 SDIO WLAN.RMH.4.4.1-00189
> 
> Fixes: c256a94d1b1b ("wifi: ath10k: shutdown driver when hardware is unreliable")
> Signed-off-by: Kang Yang <kang.yang@oss.qualcomm.com>
> ---
> 
> v2:
> 1. use workqueue_aux instead of workqueue for recovery check work.
> 2. add Test tag.
> 
> ---
>  drivers/net/wireless/ath/ath10k/core.c | 19 ++++++++-----------
>  drivers/net/wireless/ath/ath10k/core.h |  2 +-
>  drivers/net/wireless/ath/ath10k/mac.c  |  2 +-
>  3 files changed, 10 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wireless/ath/ath10k/core.c
> index 6f78f1752cd6..8396268baf92 100644
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
> +	queue_work(ar->workqueue_aux, &ar->recovery_check_work);

nit: would be better to add some comments saying that we can not use the same queue as the
restart_work due to the 'ordered' nature of that queue

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


