Return-Path: <linux-wireless+bounces-27692-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 458A5BA870C
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Sep 2025 10:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6400D7AAD39
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Sep 2025 08:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A6E219A89;
	Mon, 29 Sep 2025 08:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VMHyGCbn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC721625
	for <linux-wireless@vger.kernel.org>; Mon, 29 Sep 2025 08:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759135544; cv=none; b=gnMkYS49TzVdTJwK7znf0UgrrSm7hoxsSwl0Ji9Z4iiDE6tQEEFgLOdG8/UhwaHy+u8a1tXlxdD3fzZA1NEXqgqSCVlNodb7ul/y7uyHDdbA7oFw58lRdf4rIlZP/SzTeBqqKBROWKMKAL2fGsS6zcdsGHlsmdudHnPnjqVhuYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759135544; c=relaxed/simple;
	bh=8bkULly/CbEX2S33yyAelSacle/hUMf3+UASd3LEio8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=inheS3LL/SZVBa4+XqNhzPxR8WN+qkwOkH3gLzDwHIkzkVKdyUuGvFZF2/eMM7njtDMIcmH5D+8x5p6uE0fBKhgX1gnjrpd5jagJLtq9HbeqgLnHoso4aoO9OEarrtCOncWeNUPXiLOnhTm9XsdKwN60dW65YQlEKBcynoYnTOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VMHyGCbn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58SN0boZ014794
	for <linux-wireless@vger.kernel.org>; Mon, 29 Sep 2025 08:45:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	C2ntDCZtreZkBJyi3hTRHMA9Z3zwZ1uUO1XAO7BfNKA=; b=VMHyGCbnv8KOJ1kc
	lhzXcOVxY/HmcpjiZOdklKDzwZ7pQ2c+1iLPBwcoEJd0FiokDztBenLRlPddmmkH
	+Z21kWvqCCJ5dvI+U2N7nQWSB9SfhL5GEbVpwUfvbkUrwrQkZldYqkr1yptj6HNZ
	EGAHfiDXanGZSvhNrRjVEmGKE5Ewkr/x6B6MK9/CD7JWKh9/DOTLWOm60+nmO4/v
	QxrBmNlZI31qOUuaUFCxcpw8Z/BcHlrClYSRkmG5pe+8mGlF+RsSodsBDgB0C3hc
	BJdCI9C+DolhIuFD8HeDEPHp7kZXhA4NFd7tBP+X4oKDHHz1PX7hRHgPPa/uMF9K
	fmKfuw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e8pdcaka-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 29 Sep 2025 08:45:41 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b59682541d5so3390670a12.0
        for <linux-wireless@vger.kernel.org>; Mon, 29 Sep 2025 01:45:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759135541; x=1759740341;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C2ntDCZtreZkBJyi3hTRHMA9Z3zwZ1uUO1XAO7BfNKA=;
        b=jXzXyhQd+VMJEmvQic94kZP+riOMeLM5GyUoJ6MLlGpZeYghU5LbW1sIE03fMteq+X
         2ngYbVav1K2RmD6ABCrL9E9rwcHYJV7uK/Znb1/+k3bHhA3wt2uwMmh8lZqcoG9GfTVI
         wKHHlEgeoSxEaChcU90AweMHeiCK+Q8e+c0FfLOt1gTmclfPCkpXwWfLGo+IZLuDQJbR
         e9b9FFuYRf+evWMGsmpV220hW+7lgDM72P5ayI4lTexvz24kUYRRGZDAkQOOdliCGxw8
         3w4tt7M+oAN5rk8aZ8hQ1tQBtyMdpf/MErhmM6cje4o79eYZe0QSOg73WYdLhj2xRJ9u
         RPyA==
X-Gm-Message-State: AOJu0YxHqS18Y0SaKmXFQ6TcLWMkqbxs2e33FOvgfJb65OuYRxA0U9MF
	v9ihvR5tGHRXzWW0jcQR1tinFkkwzTcJ3ZxB6lEprUaATDMSVt/cVZJ6Mn2Pc4SKKsx8iFU7Btl
	grJcgGtOFJbdRnQZTBnK4aJQ7DCxMKPMX31KJktMPT7crjoJGcVwpNKZOTSUwkveZ30e+Dg==
X-Gm-Gg: ASbGnctcJGIOTO8Em6QIk1sxw+kXQp75PcbO270YwIFTZBhTBZyVLV4Nr9D+5mcnzqa
	Hlr0+D8TUsAYTe0UiNE178oV8Mm51IGpTJWyB3MLIrdFIc0Hsrm6XOBD6W+XGH/+wppvF8VS8QU
	PMJt+4F7LuFWROYMsCnH3MB1MFxLmuIk6x1u4zRiUffah6vD7kQpFfKoNl3RUddCOcuiSTFCBMu
	8ewZvp8YC6qkQflDwObkOPbXQvP/+1qvOfY89a2O6sBYCwEfv9atFPMz3T5Y63e8EYcwv93uMod
	9nuu8Z/tXVcoBarKeueYKn2ZsQaLExck/LbKnv9tFy88tqf5wGR4scTAhPvb09Lg3LgTk99r2hc
	KzU7t4PIvEDrFrPFh0rIyYra0PG2HEoib9iHoNA==
X-Received: by 2002:a05:6a20:72a5:b0:2b0:ff55:f825 with SMTP id adf61e73a8af0-2e7ca400a8dmr18985490637.25.1759135540855;
        Mon, 29 Sep 2025 01:45:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUKauQkMfubuA79B9sZuHOqVjAu3KmmFDtAwOKUOSirKQHfO7R6YPh4F7ZDvJVQ+SVLOwRbg==
X-Received: by 2002:a05:6a20:72a5:b0:2b0:ff55:f825 with SMTP id adf61e73a8af0-2e7ca400a8dmr18985464637.25.1759135540416;
        Mon, 29 Sep 2025 01:45:40 -0700 (PDT)
Received: from [10.133.33.193] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b58a829dde9sm6760797a12.32.2025.09.29.01.45.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Sep 2025 01:45:40 -0700 (PDT)
Message-ID: <d1abaed4-8a67-4cf3-b700-e228ddbf9f16@oss.qualcomm.com>
Date: Mon, 29 Sep 2025 16:45:35 +0800
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
 <95f50699-fe14-4858-aab6-f2e5a427587c@oss.qualcomm.com>
 <e9522baf-9664-46b7-96bb-bf755fc152a5@oss.qualcomm.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <e9522baf-9664-46b7-96bb-bf755fc152a5@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: MUEmYo7gZAgNwgGLEza4-NHSSdfOsgf9
X-Authority-Analysis: v=2.4 cv=MYZhep/f c=1 sm=1 tr=0 ts=68da4735 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=9pUgK3D33me1o42NUb8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: MUEmYo7gZAgNwgGLEza4-NHSSdfOsgf9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAzNiBTYWx0ZWRfXzkob94gtWswi
 NCD6KIBn017o1I2bmferWXIa8mG8SSHQRFyunMLRr8yaZOE93yeugVwxEZ8S+3MhP+Kze27Nau+
 lRP7HJj01G5hEdWnXO2Oz2uKsx8outIIVGOjoIXKWTzvj+COlRVaZ2Ci/d2vYX+IHkZowzyfxGc
 6vA5cwXewU7kH2GYwIcm9UO+FxFbcnYdjWrrbV2mxGRTtKHlZP3CBhCf6OH4mNTK0oh8SsJt5Mz
 /PqrfnepwM5ytZZtG0+yQ4anmaDmKoOQQY0oX2Q6p+/iWGx3bcyLs9y+58VZ5kWuppRBzX4CvlK
 kQ5IHfsj9mVimXLkph+u2igVfTrhAnmnum4ykfTn5NOviNq+IDU2PbUy2wXCPzleUO7U4ZMVeGb
 dQ0GWqQcTLaPrUbX3zDgl9D5rzU1/Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-29_03,2025-09-29_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 spamscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509270036



On 9/29/2025 10:37 AM, Kang Yang wrote:
> 
> 
> Baochen Qiang 於 9/22/2025 6:00 PM 寫道:
>>
>>
>> On 9/22/2025 2:31 PM, Kang Yang wrote:
>>> Currently, ath10k has a recovery check logic. It will wait for the
>>> last recovery to finish by wait_for_completion_timeout();
>>>
>>> But in SDIO scenarios, the recovery function may be invoked from
>>> interrupt context, where long blocking waits are undesirable and can
>>> lead to system instability.
>>>
>>> To address this, move the recovery check logic into a workqueue.
>>> Fixes: c256a94d1b1b ("wifi: ath10k: shutdown driver when hardware is unreliable")
>>> Signed-off-by: Kang Yang <kang.yang@oss.qualcomm.com>
>>> ---
>>>   drivers/net/wireless/ath/ath10k/core.c | 19 ++++++++-----------
>>>   drivers/net/wireless/ath/ath10k/core.h |  2 +-
>>>   drivers/net/wireless/ath/ath10k/mac.c  |  2 +-
>>>   3 files changed, 10 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wireless/ath/ath10k/
>>> core.c
>>> index 6f78f1752cd6..991fe8d92297 100644
>>> --- a/drivers/net/wireless/ath/ath10k/core.c
>>> +++ b/drivers/net/wireless/ath/ath10k/core.c
>>> @@ -3,7 +3,6 @@
>>>    * Copyright (c) 2005-2011 Atheros Communications Inc.
>>>    * Copyright (c) 2011-2017 Qualcomm Atheros, Inc.
>>>    * Copyright (c) 2018-2019, The Linux Foundation. All rights reserved.
>>> - * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
>>>    * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>>>    */
>>>   @@ -2493,8 +2492,9 @@ static int ath10k_init_hw_params(struct ath10k *ar)
>>>       return 0;
>>>   }
>>>   -static bool ath10k_core_needs_recovery(struct ath10k *ar)
>>> +static void ath10k_core_recovery_check_work(struct work_struct *work)
>>>   {
>>> +    struct ath10k *ar = container_of(work, struct ath10k, recovery_check_work);
>>>       long time_left;
>>>         /* Sometimes the recovery will fail and then the next all recovery fail,
>>> @@ -2504,7 +2504,7 @@ static bool ath10k_core_needs_recovery(struct ath10k *ar)
>>>           ath10k_err(ar, "consecutive fail %d times, will shutdown driver!",
>>>                  atomic_read(&ar->fail_cont_count));
>>>           ar->state = ATH10K_STATE_WEDGED;
>>> -        return false;
>>> +        return;
>>>       }
>>>         ath10k_dbg(ar, ATH10K_DBG_BOOT, "total recovery count: %d", ++ar->recovery_count);
>>> @@ -2518,27 +2518,23 @@ static bool ath10k_core_needs_recovery(struct ath10k *ar)
>>>                               ATH10K_RECOVERY_TIMEOUT_HZ);
>>>           if (time_left) {
>>>               ath10k_warn(ar, "previous recovery succeeded, skip this!\n");
>>> -            return false;
>>> +            return;
>>>           }
>>>             /* Record the continuous recovery fail count when recovery failed. */
>>>           atomic_inc(&ar->fail_cont_count);
>>>             /* Avoid having multiple recoveries at the same time. */
>>> -        return false;
>>> +        return;
>>>       }
>>>         atomic_inc(&ar->pending_recovery);
>>> -
>>> -    return true;
>>> +    queue_work(ar->workqueue, &ar->restart_work);
>>>   }
>>>     void ath10k_core_start_recovery(struct ath10k *ar)
>>>   {
>>> -    if (!ath10k_core_needs_recovery(ar))
>>> -        return;
>>> -
>>> -    queue_work(ar->workqueue, &ar->restart_work);
>>> +    queue_work(ar->workqueue, &ar->recovery_check_work);
>>>   }
>>>   EXPORT_SYMBOL(ath10k_core_start_recovery);
>>>   @@ -3734,6 +3730,7 @@ struct ath10k *ath10k_core_create(size_t priv_size, struct
>>> device *dev,
>>>         INIT_WORK(&ar->register_work, ath10k_core_register_work);
>>>       INIT_WORK(&ar->restart_work, ath10k_core_restart);
>>> +    INIT_WORK(&ar->recovery_check_work, ath10k_core_recovery_check_work);
>>>       INIT_WORK(&ar->set_coverage_class_work,
>>>             ath10k_core_set_coverage_class_work);
>>>   diff --git a/drivers/net/wireless/ath/ath10k/core.h b/drivers/net/wireless/ath/
>>> ath10k/core.h
>>> index 8c72ed386edb..859176fcb5a2 100644
>>> --- a/drivers/net/wireless/ath/ath10k/core.h
>>> +++ b/drivers/net/wireless/ath/ath10k/core.h
>>> @@ -3,7 +3,6 @@
>>>    * Copyright (c) 2005-2011 Atheros Communications Inc.
>>>    * Copyright (c) 2011-2017 Qualcomm Atheros, Inc.
>>>    * Copyright (c) 2018-2019, The Linux Foundation. All rights reserved.
>>> - * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
>>>    * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>>>    */
>>>   @@ -1208,6 +1207,7 @@ struct ath10k {
>>>         struct work_struct register_work;
>>>       struct work_struct restart_work;
>>> +    struct work_struct recovery_check_work;
>>
>> Instead of adding a new work item, how about just moving the recovery check logic into the
>> exsiting restart_work?
>>
> 
> If we use only one work, Linux’s workqueue mechanism will ignore new recovery triggers
> while the previous one is still queued or executing. This means we can't track consecutive
> failures or enter the WEDGED state in consecutive failures cases.

OK, makes sense.

But ar->workqueue is an ordered workqueue, meaning recovery_check_work won't run until
previous recovery work done.

> 
> 
> 
> 
>>>       struct work_struct bundle_tx_work;
>>>       struct work_struct tx_complete_work;
>>>   diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/
>>> mac.c
>>> index 154ac7a70982..da6f7957a0ae 100644
>>> --- a/drivers/net/wireless/ath/ath10k/mac.c
>>> +++ b/drivers/net/wireless/ath/ath10k/mac.c
>>> @@ -3,7 +3,6 @@
>>>    * Copyright (c) 2005-2011 Atheros Communications Inc.
>>>    * Copyright (c) 2011-2017 Qualcomm Atheros, Inc.
>>>    * Copyright (c) 2018-2019, The Linux Foundation. All rights reserved.
>>> - * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
>>>    * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>>>    */
>>>   @@ -5428,6 +5427,7 @@ static void ath10k_stop(struct ieee80211_hw *hw, bool suspend)
>>>       cancel_work_sync(&ar->set_coverage_class_work);
>>>       cancel_delayed_work_sync(&ar->scan.timeout);
>>>       cancel_work_sync(&ar->restart_work);
>>> +    cancel_work_sync(&ar->recovery_check_work);
>>>   }
>>>     static int ath10k_config_ps(struct ath10k *ar)
>>
> 


