Return-Path: <linux-wireless+bounces-27693-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7194ABA8775
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Sep 2025 10:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5201189D170
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Sep 2025 08:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89984219A89;
	Mon, 29 Sep 2025 08:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dMoVxOAJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9C827A900
	for <linux-wireless@vger.kernel.org>; Mon, 29 Sep 2025 08:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759136047; cv=none; b=s74lRKg+8/dFSj33Ef5D6BToAl2WT+FV3qD5DMRQvWYZWVFOsWJvo71bv+H+EYwOJxp6JezmKChjHLKdevH4ZUG8M1GVbrpgJmxuFYVwf/U7eWkycJXqHk4u2tP3wbk2hG6ZRM+WEz1S5wCPniY/P6rkK2IdLsj5EjzdrDEjP9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759136047; c=relaxed/simple;
	bh=mZt49ZAJ08kULoZgJcWmEg+l2WoxjcyxjVyVs8H/Xxo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jd4dz7F4LKpJNYhlJixgwCtU66OEZ9U533MnrzKUNXEXrSW0CuauHpDuRvDBwb1tPgqpnLS0MoxS3RR5LO6jYgkst/+tpBq0izvkYNBBcRvFuAVuA9CZ/5NgCkcUOfk/3HbbsMbX2ODo1QANyeEH9bkEVUeL3Pnt+O/M9z5azVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dMoVxOAJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58SLNqam030383
	for <linux-wireless@vger.kernel.org>; Mon, 29 Sep 2025 08:54:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EASzld02XLmuA+mA1P/w9caMg0zMfySCqWZOwgugM5g=; b=dMoVxOAJvG/LW2bu
	q1HLbT3Q8RhPlcRHQNEAl9U2gnNiRufwgtLK4SSRbijRZPrMrpbF7BaxqO5DSmBf
	F4nsNpx1KhsU1Roe5tKV0Rlds1KxBcscro/7TiyQpcaPU7tImZRztPxRecz7zM/B
	VMSiHtTIjbLV/e3ptg3nL6zxJ+4awKg+Mvy4Cv9y2rQEP9ENbRlWUJ5fxohRBty+
	eed8iUb9jARh/U7DmVkY4W+jwFl/f7gBEAs/OFoiWeYc0kEI2qGnQGEwMP0mdhpv
	r/Hy4GOpRLExmYIqB6ezjmg7gYo4hJDnbC45FOQChA5r3tVetjiOlpC+oHK4RdfB
	TjZacw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e93hcbd1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 29 Sep 2025 08:54:04 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-336b646768eso2116390a91.1
        for <linux-wireless@vger.kernel.org>; Mon, 29 Sep 2025 01:54:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759136044; x=1759740844;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EASzld02XLmuA+mA1P/w9caMg0zMfySCqWZOwgugM5g=;
        b=VFOR/i7K67Uv0Nh9z/bI5aTsFHcn7b7MFHqdBVUZUuElBXOBV+o+9QeygsKolgNEVE
         dJwA1V4w1gTfTJ91VRs7NOlGXtoG60CkQ1ErJKVWtGiMsbJkIH8vRSvumrBPyobUQypp
         +ExO9iueLTZ1JWqkbUi8j29AQDAukQe1m7CNd9qgbqcnf1M7l22sES+qBCXUhMiqylig
         f0Bof5YQtUl41qg78a4DKd86DYuu2GnxFIf73CqoNb2fAWUt0a9MvWDeKkG+GdzfWhpS
         KEbjD6WtH/4LWeRjJ39UqpVO7OYAxrVEPdwbeJQQ/+NCoA1bE0O6skdRuHnfTP4CHSRF
         ia0g==
X-Gm-Message-State: AOJu0YwMG1Rh+OwWhDdVlODMcGAvdx/RkeOiU2/S3CB2GhyjJiQ8L0nI
	ihyvyCmNI1iyDs581SfKezVAPS+hnW0yLsmtH2wwZya9zdzzZoEUsfxlkTpWi18JSVju4HJRIoY
	QLgiwagiGXADE34RyiSjOHAS1FF1qZE7ICF9AsrZ1D3hrAwYB5hhbabLaFUFSgIz+RReN1Q==
X-Gm-Gg: ASbGncvqtNYNyq4WzXjiFr/+5QY0Pwktu2ZOlALC+0iurwF6JPi7QMOyOuEhZxTRu6Y
	j9hP/P3pwHJcpE6WCo9qD+hYn9zvQW1Zt25a4vvqcC7K1bGONMUz/VIzogTM+nA2f5NaZupOfaS
	wiLVVn4tcNzclGJTwJdsLGyanhoZCmh/wFnsjJF5sMk628xhyMhue1irev1EkiJjDfbgOySZVSF
	Z3knAUtMVUO7TPn3uTDo+dJzmdbzPUNKiByuw6PM6bU/SeLbQT1wLRmBYLJKewA72sRTvVZODxz
	xIL9YDjtjgLI7Dh5agK3J4PzTmo6RbvfMuW3HKF7UwiLPNMtejHuiESK1rxCCTzic9lYurckhju
	sZwwn76Zh1TsMt5lPBDluGnKA3FUM99O/
X-Received: by 2002:a17:90b:1d06:b0:336:9e78:c4c1 with SMTP id 98e67ed59e1d1-3369e78d5c6mr9311396a91.15.1759136043704;
        Mon, 29 Sep 2025 01:54:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IER8bt0QxZaoLP8UQfKdsoPVM0Tm71yxR5PPT3yi2bDC7c3evwytaKLINNkWGu0IJy6pN3paA==
X-Received: by 2002:a17:90b:1d06:b0:336:9e78:c4c1 with SMTP id 98e67ed59e1d1-3369e78d5c6mr9311361a91.15.1759136043191;
        Mon, 29 Sep 2025 01:54:03 -0700 (PDT)
Received: from [10.133.33.184] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-338386fe167sm493101a91.6.2025.09.29.01.54.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Sep 2025 01:54:02 -0700 (PDT)
Message-ID: <09aac315-10c1-45c9-a220-c5ec0fce787c@oss.qualcomm.com>
Date: Mon, 29 Sep 2025 16:54:00 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next] wifi: ath10k: move recovery check logic into a
 new work
To: Baochen Qiang <baochen.qiang@oss.qualcomm.com>, ath10k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250922063112.1324-1-kang.yang@oss.qualcomm.com>
 <95f50699-fe14-4858-aab6-f2e5a427587c@oss.qualcomm.com>
 <e9522baf-9664-46b7-96bb-bf755fc152a5@oss.qualcomm.com>
 <d1abaed4-8a67-4cf3-b700-e228ddbf9f16@oss.qualcomm.com>
Content-Language: en-US
From: Kang Yang <kang.yang@oss.qualcomm.com>
In-Reply-To: <d1abaed4-8a67-4cf3-b700-e228ddbf9f16@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDA0MSBTYWx0ZWRfX5O4x30U3cKAJ
 0S2GSpQLhUokh3RMJDfr9XGNUkSIvRG2e1wlq1uoD/gxOux4bhPKyO6qPFGZNG0+EZvmYvT6DMc
 iyJVhUhgrwxOmTrurvtJHAO86vW11xqae6fd5dH2xEfJT7HVto1glYBnapBjVYwPEMQD66U+xTM
 5iG07tvcLdzNU+Ja3b3hHjIEVjwlRlKiLLjGNv6ntYoLkbM0AQurZoq02v3QugMceh4DyPmmLIL
 TuOYmHWthixZbuFGKQJQkKzZJWb1Aga+R2apszYWHm67+d7T6W6L9dxVGfw0+uWRpP1g7uWWY0Z
 IzscPQzm8T0Pv9/MXv+o+m+M3bZ+XAcj8lVyCeABWALSrSyo+vka710ZkB+XnIcqYx0GQ+4Evpd
 SMyMOHfWqGlNh1zf6JLLEeNhonjExA==
X-Proofpoint-GUID: J8enV_Tv5OgAgJddki63lHxqmKsp5wCm
X-Proofpoint-ORIG-GUID: J8enV_Tv5OgAgJddki63lHxqmKsp5wCm
X-Authority-Analysis: v=2.4 cv=Rfydyltv c=1 sm=1 tr=0 ts=68da492c cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=owF4nD8nE7yPxU6-CcQA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-29_03,2025-09-29_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 bulkscore=0 adultscore=0 lowpriorityscore=0
 impostorscore=0 clxscore=1015 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270041



Baochen Qiang 於 9/29/2025 4:45 PM 寫道:
> 
> 
> On 9/29/2025 10:37 AM, Kang Yang wrote:
>>
>>
>> Baochen Qiang 於 9/22/2025 6:00 PM 寫道:
>>>
>>>
>>> On 9/22/2025 2:31 PM, Kang Yang wrote:
>>>> Currently, ath10k has a recovery check logic. It will wait for the
>>>> last recovery to finish by wait_for_completion_timeout();
>>>>
>>>> But in SDIO scenarios, the recovery function may be invoked from
>>>> interrupt context, where long blocking waits are undesirable and can
>>>> lead to system instability.
>>>>
>>>> To address this, move the recovery check logic into a workqueue.
>>>> Fixes: c256a94d1b1b ("wifi: ath10k: shutdown driver when hardware is unreliable")
>>>> Signed-off-by: Kang Yang <kang.yang@oss.qualcomm.com>
>>>> ---
>>>>    drivers/net/wireless/ath/ath10k/core.c | 19 ++++++++-----------
>>>>    drivers/net/wireless/ath/ath10k/core.h |  2 +-
>>>>    drivers/net/wireless/ath/ath10k/mac.c  |  2 +-
>>>>    3 files changed, 10 insertions(+), 13 deletions(-)
>>>>
>>>> diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wireless/ath/ath10k/
>>>> core.c
>>>> index 6f78f1752cd6..991fe8d92297 100644
>>>> --- a/drivers/net/wireless/ath/ath10k/core.c
>>>> +++ b/drivers/net/wireless/ath/ath10k/core.c
>>>> @@ -3,7 +3,6 @@
>>>>     * Copyright (c) 2005-2011 Atheros Communications Inc.
>>>>     * Copyright (c) 2011-2017 Qualcomm Atheros, Inc.
>>>>     * Copyright (c) 2018-2019, The Linux Foundation. All rights reserved.
>>>> - * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
>>>>     * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>>>>     */
>>>>    @@ -2493,8 +2492,9 @@ static int ath10k_init_hw_params(struct ath10k *ar)
>>>>        return 0;
>>>>    }
>>>>    -static bool ath10k_core_needs_recovery(struct ath10k *ar)
>>>> +static void ath10k_core_recovery_check_work(struct work_struct *work)
>>>>    {
>>>> +    struct ath10k *ar = container_of(work, struct ath10k, recovery_check_work);
>>>>        long time_left;
>>>>          /* Sometimes the recovery will fail and then the next all recovery fail,
>>>> @@ -2504,7 +2504,7 @@ static bool ath10k_core_needs_recovery(struct ath10k *ar)
>>>>            ath10k_err(ar, "consecutive fail %d times, will shutdown driver!",
>>>>                   atomic_read(&ar->fail_cont_count));
>>>>            ar->state = ATH10K_STATE_WEDGED;
>>>> -        return false;
>>>> +        return;
>>>>        }
>>>>          ath10k_dbg(ar, ATH10K_DBG_BOOT, "total recovery count: %d", ++ar->recovery_count);
>>>> @@ -2518,27 +2518,23 @@ static bool ath10k_core_needs_recovery(struct ath10k *ar)
>>>>                                ATH10K_RECOVERY_TIMEOUT_HZ);
>>>>            if (time_left) {
>>>>                ath10k_warn(ar, "previous recovery succeeded, skip this!\n");
>>>> -            return false;
>>>> +            return;
>>>>            }
>>>>              /* Record the continuous recovery fail count when recovery failed. */
>>>>            atomic_inc(&ar->fail_cont_count);
>>>>              /* Avoid having multiple recoveries at the same time. */
>>>> -        return false;
>>>> +        return;
>>>>        }
>>>>          atomic_inc(&ar->pending_recovery);
>>>> -
>>>> -    return true;
>>>> +    queue_work(ar->workqueue, &ar->restart_work);
>>>>    }
>>>>      void ath10k_core_start_recovery(struct ath10k *ar)
>>>>    {
>>>> -    if (!ath10k_core_needs_recovery(ar))
>>>> -        return;
>>>> -
>>>> -    queue_work(ar->workqueue, &ar->restart_work);
>>>> +    queue_work(ar->workqueue, &ar->recovery_check_work);
>>>>    }
>>>>    EXPORT_SYMBOL(ath10k_core_start_recovery);
>>>>    @@ -3734,6 +3730,7 @@ struct ath10k *ath10k_core_create(size_t priv_size, struct
>>>> device *dev,
>>>>          INIT_WORK(&ar->register_work, ath10k_core_register_work);
>>>>        INIT_WORK(&ar->restart_work, ath10k_core_restart);
>>>> +    INIT_WORK(&ar->recovery_check_work, ath10k_core_recovery_check_work);
>>>>        INIT_WORK(&ar->set_coverage_class_work,
>>>>              ath10k_core_set_coverage_class_work);
>>>>    diff --git a/drivers/net/wireless/ath/ath10k/core.h b/drivers/net/wireless/ath/
>>>> ath10k/core.h
>>>> index 8c72ed386edb..859176fcb5a2 100644
>>>> --- a/drivers/net/wireless/ath/ath10k/core.h
>>>> +++ b/drivers/net/wireless/ath/ath10k/core.h
>>>> @@ -3,7 +3,6 @@
>>>>     * Copyright (c) 2005-2011 Atheros Communications Inc.
>>>>     * Copyright (c) 2011-2017 Qualcomm Atheros, Inc.
>>>>     * Copyright (c) 2018-2019, The Linux Foundation. All rights reserved.
>>>> - * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
>>>>     * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>>>>     */
>>>>    @@ -1208,6 +1207,7 @@ struct ath10k {
>>>>          struct work_struct register_work;
>>>>        struct work_struct restart_work;
>>>> +    struct work_struct recovery_check_work;
>>>
>>> Instead of adding a new work item, how about just moving the recovery check logic into the
>>> exsiting restart_work?
>>>
>>
>> If we use only one work, Linux’s workqueue mechanism will ignore new recovery triggers
>> while the previous one is still queued or executing. This means we can't track consecutive
>> failures or enter the WEDGED state in consecutive failures cases.
> 
> OK, makes sense.
> 
> But ar->workqueue is an ordered workqueue, meaning recovery_check_work won't run until
> previous recovery work done.
> 

It seems that i need to use different queues for them.

>>
>>
>>
>>
>>>>        struct work_struct bundle_tx_work;
>>>>        struct work_struct tx_complete_work;
>>>>    diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/
>>>> mac.c
>>>> index 154ac7a70982..da6f7957a0ae 100644
>>>> --- a/drivers/net/wireless/ath/ath10k/mac.c
>>>> +++ b/drivers/net/wireless/ath/ath10k/mac.c
>>>> @@ -3,7 +3,6 @@
>>>>     * Copyright (c) 2005-2011 Atheros Communications Inc.
>>>>     * Copyright (c) 2011-2017 Qualcomm Atheros, Inc.
>>>>     * Copyright (c) 2018-2019, The Linux Foundation. All rights reserved.
>>>> - * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
>>>>     * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>>>>     */
>>>>    @@ -5428,6 +5427,7 @@ static void ath10k_stop(struct ieee80211_hw *hw, bool suspend)
>>>>        cancel_work_sync(&ar->set_coverage_class_work);
>>>>        cancel_delayed_work_sync(&ar->scan.timeout);
>>>>        cancel_work_sync(&ar->restart_work);
>>>> +    cancel_work_sync(&ar->recovery_check_work);
>>>>    }
>>>>      static int ath10k_config_ps(struct ath10k *ar)
>>>
>>
> 


