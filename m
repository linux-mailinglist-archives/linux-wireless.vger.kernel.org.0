Return-Path: <linux-wireless+bounces-17439-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 183A4A0C13D
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jan 2025 20:21:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 846513A5D19
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jan 2025 19:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E5E1CB31D;
	Mon, 13 Jan 2025 19:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lHa+jbQH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534BF1C5F28
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jan 2025 19:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736796095; cv=none; b=S9gnQxELcWTNrT05rPQojhiMPaSsHt50ASHa6hwLPjvaA52qJnWB/McPNm/ILHir2kI1+usnJcJdgtvpAKzzIaf/9IG4tBRXkN94lAYgxll/WyJI9NbOCVVB8xKkCf+zvVQbJdfld5+gUFrHHQMvS6ruaazeee7yuBX3e0KCZtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736796095; c=relaxed/simple;
	bh=gil3k7cu2wg8V11ttntxg97xfLiA/fqWSPmac9JKYyI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a49kh49Q9Rb0zd0HYWYi3r0sF+aO4BbeTVtOKqxNG4y28p2eGTHH/aiXZZTa50WRRNF/AuJe+KCMbK5e81Vl8rOPC0gT1L89AYMYR9gjkyKg9AEbPGne4nL4SjrX1acIt1EcU+eD0mkOOAapcbexT1a7QvghbHIYNV0DUPahTKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lHa+jbQH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50DH3i32020117
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jan 2025 19:21:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	I9vVDbIRWymnD5eeoVU7r9SArOy7Qyw7Q1Uof2y9aIk=; b=lHa+jbQHj32XaQP3
	y9PR1+Qn/pOs5//ynAN/93aer4TZvT87AWS/71YLHNV5oFCPT8uM7c+jo9WiGyWo
	d5+GsfyuN6OAlApXbhkVAHpl1ZH7HvWGc1M2fiiJQolFR+MSWvlhIhVRmgO6RdEg
	2e2m/mpibSLRyF9mHVFAM2OQVkkzMfe4vW6WalpWMXjcR0IEsHaOZVLixm9/1k7h
	gdDJADrKounNMAL2Bidm/ZeQOIHZU7BRCAd8hA/zeZ3IFwbMT5nbDhr+6sQSbbJE
	4HrrF4SOc+U+fTSEi+A3FJHSka3XguTJ9ZlHo/vsU9YtBo2jwYluMgnHRxhxm0Bi
	/9Foxg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4456wa8bap-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jan 2025 19:21:31 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2166855029eso85243905ad.0
        for <linux-wireless@vger.kernel.org>; Mon, 13 Jan 2025 11:21:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736796090; x=1737400890;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I9vVDbIRWymnD5eeoVU7r9SArOy7Qyw7Q1Uof2y9aIk=;
        b=QePinhzkBnAdtbomBH2zdcFrayeDEWNHHhSGIUDbxWwYRde4sl7ES0dg5iPInOqDWx
         MbIYqwI386EnBY1C8iPIWaNA/MitYUpkF8Vp6iIK2n0PL6WEbD32qYpYtw8/2QhdOzGM
         IR5qn2ah9l3RBjMHTn8H6DGXsZJgo25OI5cehvFiyeuwvge+1SnQEeGFyZRoZ+8dPZ+D
         kL/GUYbZUkPkEFwZcTERxLr57wJi5xJSrmItSxiwTcKuIu4EGHjypVd8WVs2lYLctKhx
         pOnlT5SRGpPhL2UUJgOjwhlZCxLzX7TcOd/JpRBsppO4DV60UEdISKZTbC/VHjVnMtWp
         xo8g==
X-Forwarded-Encrypted: i=1; AJvYcCXcCuAqAMa618sJrzfi2kBeKT7TnnIsvNAN+VRQ3c70qWLcCiwJtd9O81yzz4LDofH9hxcBODh09mhPQ679qw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwmEg+27Xovz4LOujJRKLlF5tVtOHlX2DsSC061oGx6WHUK9Vh3
	60nbA5rYl+5tXufbYKa9/0xZCIyXInP629eQPJZM+F9Lcnu0afXGnqcDptC9fy5Ozj0wpt21dRb
	ywHn8+KH65XKMW5r3q9bFK+SucSLDDFngihmM7pSfsoeyG/g6KWnxlQVzg4xIoONqw9YbZh9Ktg
	==
X-Gm-Gg: ASbGncuu5NYTWbiwQpDByuiCwMwirZNbFVnUlwpPDanpLv+ospA3ataR3AgymE/BPP1
	DaD8Cdcm6duhr/WuXOjNvkUvENec5r4BDjzzA0cnmvPRHk8a8N9CQoW3Q0k74E/T0mHv1j6Mu+3
	etstI/K7I4rkJvsioVc5F9aVro8ojRXEOBW4zpJpKqRJ+0G73CaYnXCd6vMDFW8Irrmw3D3g2dH
	EMaM28NqwrV6laLDU8dNi+4wCUT3Qs924YsmXzmvMk6hbU25Youd30zvGr0ZkYEMkqQR/vaEaO5
	/BQZ9GonkTgX2uSz7fpl/FSooMpw6ra9rco8t4fgpU5rBnlxHQ==
X-Received: by 2002:a17:902:e5ce:b0:215:8ca3:3bac with SMTP id d9443c01a7336-21a83f4e46fmr293950785ad.16.1736796090318;
        Mon, 13 Jan 2025 11:21:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGoRfY9+/565KAx7ktGhzlpZoEHUY4KiHXTYSSmODFBQOK5p4BjNwZRLI83gbTChHxacB3Hhw==
X-Received: by 2002:a17:902:e5ce:b0:215:8ca3:3bac with SMTP id d9443c01a7336-21a83f4e46fmr293950495ad.16.1736796089934;
        Mon, 13 Jan 2025 11:21:29 -0800 (PST)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f10f4d7sm56074695ad.10.2025.01.13.11.21.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jan 2025 11:21:29 -0800 (PST)
Message-ID: <22fdc80a-7ad9-4305-8435-0422d201b1ce@oss.qualcomm.com>
Date: Mon, 13 Jan 2025 11:21:28 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/10] wifi: ath12k: fix SLUB BUG - Object already free in
 ath12k_reg_free()
To: Aditya Kumar Singh <quic_adisi@quicinc.com>,
        Kalle Valo
 <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        Harshitha Prem <quic_hprem@quicinc.com>
Cc: Kalle Valo <quic_kvalo@quicinc.com>, linux-wireless@vger.kernel.org,
        ath12k@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250109-fix_reboot_issues_with_hw_grouping-v1-0-fb39ec03451e@quicinc.com>
 <20250109-fix_reboot_issues_with_hw_grouping-v1-5-fb39ec03451e@quicinc.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250109-fix_reboot_issues_with_hw_grouping-v1-5-fb39ec03451e@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: vknjgAuUEUc-gQv1_jS3saRdUd9E3IEv
X-Proofpoint-ORIG-GUID: vknjgAuUEUc-gQv1_jS3saRdUd9E3IEv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 suspectscore=0 adultscore=0 mlxlogscore=999 priorityscore=1501
 phishscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501130155

On 1/8/2025 8:25 PM, Aditya Kumar Singh wrote:
> During rmmod of ath12k module with SLUB debug enabled, following print is
> seen -
> 
> =============================================================================
> BUG kmalloc-1k (Not tainted): Object already free
> -----------------------------------------------------------------------------
> 
> Allocated in ath12k_reg_build_regd+0x94/0xa20 [ath12k] age=10470 cpu=0 pid=0
>  __kmalloc_noprof+0xf4/0x368
>  ath12k_reg_build_regd+0x94/0xa20 [ath12k]
>  ath12k_wmi_op_rx+0x199c/0x2c14 [ath12k]
>  ath12k_htc_rx_completion_handler+0x398/0x554 [ath12k]
>  ath12k_ce_per_engine_service+0x248/0x368 [ath12k]
>  ath12k_pci_ce_workqueue+0x28/0x50 [ath12k]
>  process_one_work+0x14c/0x28c
>  bh_worker+0x22c/0x27c
>  workqueue_softirq_action+0x80/0x90
>  tasklet_action+0x14/0x3c
>  handle_softirqs+0x108/0x240
>  __do_softirq+0x14/0x20
> Freed in ath12k_reg_free+0x40/0x74 [ath12k] age=136 cpu=2 pid=166
>  kfree+0x148/0x248
>  ath12k_reg_free+0x40/0x74 [ath12k]
>  ath12k_core_hw_group_destroy+0x68/0xac [ath12k]
>  ath12k_core_deinit+0xd8/0x124 [ath12k]
>  ath12k_pci_remove+0x6c/0x130 [ath12k]
>  pci_device_remove+0x44/0xe8
>  device_remove+0x4c/0x80
>  device_release_driver_internal+0x1d0/0x22c
>  driver_detach+0x50/0x98
>  bus_remove_driver+0x70/0xf4
>  driver_unregister+0x30/0x60
>  pci_unregister_driver+0x24/0x9c
>  ath12k_pci_exit+0x18/0x24 [ath12k]
>  __arm64_sys_delete_module+0x1a0/0x2a8
>  invoke_syscall+0x48/0x110
>  el0_svc_common.constprop.0+0x40/0xe0
> Slab 0xfffffdffc0033600 objects=10 used=6 fp=0xffff000000cdcc00 flags=0x3fffe0000000240(workingset|head|node=0|zone=0|lastcpupid=0x1ffff)
> Object 0xffff000000cdcc00 @offset=19456 fp=0xffff000000cde400
> [...]
> 
> This issue arises because in ath12k_core_hw_group_destroy(), each device
> calls ath12k_core_soc_destroy() for itself and all its partners within the
> same group. Since ath12k_core_hw_group_destroy() is invoked for each
> device, this results in a double free condition, eventually causing the
> SLUB bug.
> 
> To resolve this, a new member regd_freed is introduced in the ath12k_base
> object. Once regd is freed, regd_freed is set to true. This ensures that
> in the removal context of other devices, regd is not freed again if
> regd_freed is already true. And since there could be a race condition to
> read this member, guard ath12k_core_soc_destroy() with the mutext lock.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> 
> Fixes: 6f245ea0ec6c ("wifi: ath12k: introduce device group abstraction")
> Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
> ---
>  drivers/net/wireless/ath/ath12k/core.c | 2 ++
>  drivers/net/wireless/ath/ath12k/core.h | 1 +
>  drivers/net/wireless/ath/ath12k/reg.c  | 8 +++++++-
>  drivers/net/wireless/ath/ath12k/wmi.c  | 4 +++-
>  4 files changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
> index 299d7686616b78752164d9cb064c1805af9a1155..72e6e3a0cf7be03b20b7421866c479dfcb8038ff 100644
> --- a/drivers/net/wireless/ath/ath12k/core.c
> +++ b/drivers/net/wireless/ath/ath12k/core.c
> @@ -1757,7 +1757,9 @@ static void ath12k_core_hw_group_destroy(struct ath12k_hw_group *ag)
>  		if (!ab)
>  			continue;
>  
> +		mutex_lock(&ab->core_lock);
>  		ath12k_core_soc_destroy(ab);
> +		mutex_unlock(&ab->core_lock);
>  	}
>  	mutex_unlock(&ag->mutex);
>  }
> diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
> index 58ebc56991af99de08e8ed783e98f742a687eddf..cc1bfcc1e65c87e30d86dad4c0bcd1905e6a2f51 100644
> --- a/drivers/net/wireless/ath/ath12k/core.h
> +++ b/drivers/net/wireless/ath/ath12k/core.h
> @@ -961,6 +961,7 @@ struct ath12k_base {
>  	 * This may or may not be used during the runtime
>  	 */
>  	struct ieee80211_regdomain *new_regd[MAX_RADIOS];
> +	bool regd_freed;
>  
>  	/* Current DFS Regulatory */
>  	enum ath12k_dfs_region dfs_region;
> diff --git a/drivers/net/wireless/ath/ath12k/reg.c b/drivers/net/wireless/ath/ath12k/reg.c
> index 439d61f284d89222e79c05d6cff8e85d0d315aad..b4d7fa1a04ca0e72728e8989c29b82d089171fc2 100644
> --- a/drivers/net/wireless/ath/ath12k/reg.c
> +++ b/drivers/net/wireless/ath/ath12k/reg.c
> @@ -1,7 +1,7 @@
>  // SPDX-License-Identifier: BSD-3-Clause-Clear
>  /*
>   * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
> - * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
> + * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
>   */
>  #include <linux/rtnetlink.h>
>  #include "core.h"
> @@ -777,8 +777,14 @@ void ath12k_reg_free(struct ath12k_base *ab)
>  {
>  	int i;
>  
> +	if (ab->regd_freed)
> +		return;
> +
>  	for (i = 0; i < ab->hw_params->max_radios; i++) {
>  		kfree(ab->default_regd[i]);
>  		kfree(ab->new_regd[i]);
> +		ab->default_regd[i] = NULL;
> +		ab->new_regd[i] = NULL;
> +		ab->regd_freed = true;

since it is loop invariant, should this last assignment be outside the loop,
either before or after the loop?

but then again, why is a flag needed since setting the pointers to NULL should
already show they are freed, and any race conditions with those pointers would
also exist with the new flag (which you have addressed with the locking change).

>  	}
>  }
> diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
> index 4dd6cdf84571d3652cd03281ffa6486e3d340c42..1de6ed6cceaee3a22de63a2369358fe53fb0d638 100644
> --- a/drivers/net/wireless/ath/ath12k/wmi.c
> +++ b/drivers/net/wireless/ath/ath12k/wmi.c
> @@ -1,7 +1,7 @@
>  // SPDX-License-Identifier: BSD-3-Clause-Clear
>  /*
>   * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
> - * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
> + * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
>   */
>  #include <linux/skbuff.h>
>  #include <linux/ctype.h>
> @@ -5950,6 +5950,8 @@ static int ath12k_reg_chan_list_event(struct ath12k_base *ab, struct sk_buff *sk
>  		/* This regd would be applied during mac registration */
>  		ab->default_regd[pdev_idx] = regd;
>  	}
> +
> +	ab->regd_freed = false;
>  	ab->dfs_region = reg_info->dfs_region;
>  	spin_unlock(&ab->base_lock);
>  
> 


