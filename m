Return-Path: <linux-wireless+bounces-27689-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8AB9BA7CED
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Sep 2025 04:38:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D8367AB3C4
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Sep 2025 02:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D0F219F40A;
	Mon, 29 Sep 2025 02:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ltFssjnH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC46BA3D
	for <linux-wireless@vger.kernel.org>; Mon, 29 Sep 2025 02:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759113475; cv=none; b=bs6DpQ+SREXMqobhHJk/3a9nXUh531TTKhMcyY3GdmP9/CRPxbNozyMt9pnqgwCFFXl5qNh74OKDDITjphPECozaZI1sKupiRGjoI1QSRrXscVBjgIei3KVWD/GdW7SwTCMeFf0iB+2pJcrFeG8TvlVCSPDl8QT3U2X0yPBNkII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759113475; c=relaxed/simple;
	bh=LO7Sg14gPkjV6YeGEJMaDXlD/C4o1i/xIzvhJI+8Ibk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T3xToiJqcFfPpCVAX5rAvO9HVco29gDxk4Jv8hNEIpJNfoxr4Rd5CuHUioK3BZXYkTJ/AhUD5tJBMg4LDIbCxxekSbqj7v9VgSUZ1FhPlqJlCPUbmVn27Ecz11geKQBHCtaF2mhYXLjLn6suwNL77WjzzATgD7fMSUyuxZNakEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ltFssjnH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58SMeVjd012945
	for <linux-wireless@vger.kernel.org>; Mon, 29 Sep 2025 02:37:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Wtkq/RIwquyvizpMMHtEwBnorP29FuXfx2iUtY56Uuw=; b=ltFssjnHf5mxjE3l
	/MolRvZK/O1+ju03GxtQxRMpd9xKb6rEi1AEpXS35WBtz+3FCbAvcDtW6vp66VoE
	3qZKR3s6n6EE1omAPgjvgr6K+BXwJd/yYZOONwlOeFc16pC9HQTaluB9gNBtCKlV
	nfy4hXn0e4Isfw/xB6RPp5dgN5RUlDGdy88v2z9nkEBhz3fZlGMWPJxLt7N2E1pu
	jxYzoHqnxOqelZlHUfn5MJ1jMWzpg2GqKhtDrDREmABTc8KaAFJ9HYxqFs7QTx67
	fOkDnzgyixmK7s/deY2lEiD4jAW8QHhJDmNXN+5jP6yQ7ITYWm8L/+uX0ofLGa6A
	6BIPBg==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e7gxkmn3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 29 Sep 2025 02:37:51 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-780d26fb6b4so3534486b3a.0
        for <linux-wireless@vger.kernel.org>; Sun, 28 Sep 2025 19:37:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759113470; x=1759718270;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wtkq/RIwquyvizpMMHtEwBnorP29FuXfx2iUtY56Uuw=;
        b=RxAnyZ4hc5JOqtwYNgdcHf7TRfZ5hdM0Wc8jghWxdcJVPFXp+6WOSDxwf4C4Q5ByoD
         1k26rv3Ui83UYYMsRzO//421yAysUpETDd4/UxuOCyHwtoGxiVEVB/4ui3PBj1+x/M10
         TKIIhGeFm9Lh2NZfIjlCD4GdlcDjvSNGKTVLE+gRnN90wk+vxZer2uj0m7maLDDviwsK
         3qTYpMrfs24Jvf1eA5X3h4ECbz3uIgC4eB/JtUgI/N9MR6YPYqYOaG0k1JZWo4PBfVPK
         LXlfeNPFBhfB6T8X5ZdSWTVtee9Tz37tM5yLUwZ/9oKotaPSSGth66B1cxioMdXuQDw3
         j9Zg==
X-Gm-Message-State: AOJu0Yzr6nYg37IVpOqN4K3aSgZB+6g1EsysV1EQ+J4k5gFYCa6y/0jn
	upbl3uVxQMRJUE8f+LhdJlfH6obwVZX9WXnJF96m8WXFGTKDbjjUuq3m6umpfeLRbVpqrz+K416
	oCK0wJ9VnYNLk9FD0xXPg9qQ9ajsTPBN7F+LsMUL9RiZWJPe45yKRsQi7RtKQzDCI/bncQg==
X-Gm-Gg: ASbGncsK38LtaVSoGph4eFR2NganAHH6kc6SID36HSUTDazfLFBzd8D7BEROUKr35Ce
	XD4tZY7mYX4pbUbTnkGiXsDRkSxYN2/2Jj3OqDvlOrb3S9KYpUwL+U4QNgR4dluoQPKB+17asrP
	I+MsN3xmkWtyuFgQaQrzRupn4pWwdiZhWtcwZSAvu3Y19pT8bOShEqQVMzoLP7IoeaLTl1Gv8NC
	M/glA7+NQ2CSqj5bKsItUYFi8YMke2gNUZrd63PtlAxvTFs6RSlRMMuJjxEO4INQCdevuEapmT1
	YCnwJBVVbZWGSEpHbBLaixtuiokIBfaazxi+Cp8iNjWOth+3tw4BoPxoBfBPq4PAep92kqlmdyB
	xK4veG8BowaQpkEDFB7zokQ1HkJ5TN0Bx
X-Received: by 2002:a05:6a20:729e:b0:2fc:3b64:4473 with SMTP id adf61e73a8af0-2fc3b644678mr10212750637.24.1759113470335;
        Sun, 28 Sep 2025 19:37:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgJMVolgeIwDhkDBzJOISZnIkWwoG3Ljmsf84HrsMxG+TTuH25F7jtBeWsyMovsJ17CNRqQw==
X-Received: by 2002:a05:6a20:729e:b0:2fc:3b64:4473 with SMTP id adf61e73a8af0-2fc3b644678mr10212718637.24.1759113469831;
        Sun, 28 Sep 2025 19:37:49 -0700 (PDT)
Received: from [10.133.33.184] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78102c07696sm9666636b3a.74.2025.09.28.19.37.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Sep 2025 19:37:49 -0700 (PDT)
Message-ID: <e9522baf-9664-46b7-96bb-bf755fc152a5@oss.qualcomm.com>
Date: Mon, 29 Sep 2025 10:37:44 +0800
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
Content-Language: en-US
From: Kang Yang <kang.yang@oss.qualcomm.com>
In-Reply-To: <95f50699-fe14-4858-aab6-f2e5a427587c@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: ZaLY8EdaTtrXQsscovwVt-oA9l9G7L9t
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAyNSBTYWx0ZWRfX6h2teeQ3OyB0
 H3oj2ZACbRiTJqJcb4P6/BfxpY2MGaUIATBqlrwcDkwBBd46nTC0aq4pN0gtndmuaiU81TAYWx5
 U4GeV82h1ZYA6U7pr5/qDcdms1H1Q25cCMKmPoe4sVSAH7+QLi641ddkqY54DBR9Tn7mCgYxwXd
 2gM8H8k/BWvO6jDAAPDecTI2nt2QtrhZz8im/71wyEwCc7zVTG/CTLKbvJ0hmxemXSEwY/Ad68p
 ohhgk3EaSVso3lFktDEDDCxC7geZ2meQfy/6++26+YMxzm4DnickZElDXKgS93rEqFddvDUPBss
 0qlam26IzstF/1z7BVotgPRn7SWjnGkfLhE0WegdGim2U/QSlV0PxSzYHkeYLfN3iD96JUP/4rV
 DVl/w5VqOcoNdQZ4pM9VJuaBJt18FQ==
X-Proofpoint-GUID: ZaLY8EdaTtrXQsscovwVt-oA9l9G7L9t
X-Authority-Analysis: v=2.4 cv=dP6rWeZb c=1 sm=1 tr=0 ts=68d9f0ff cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=nQwDUS0l7koZsR_CKIQA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-29_01,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 spamscore=0
 malwarescore=0 bulkscore=0 impostorscore=0 phishscore=0 suspectscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509270025



Baochen Qiang 於 9/22/2025 6:00 PM 寫道:
> 
> 
> On 9/22/2025 2:31 PM, Kang Yang wrote:
>> Currently, ath10k has a recovery check logic. It will wait for the
>> last recovery to finish by wait_for_completion_timeout();
>>
>> But in SDIO scenarios, the recovery function may be invoked from
>> interrupt context, where long blocking waits are undesirable and can
>> lead to system instability.
>>
>> To address this, move the recovery check logic into a workqueue.
>> Fixes: c256a94d1b1b ("wifi: ath10k: shutdown driver when hardware is unreliable")
>> Signed-off-by: Kang Yang <kang.yang@oss.qualcomm.com>
>> ---
>>   drivers/net/wireless/ath/ath10k/core.c | 19 ++++++++-----------
>>   drivers/net/wireless/ath/ath10k/core.h |  2 +-
>>   drivers/net/wireless/ath/ath10k/mac.c  |  2 +-
>>   3 files changed, 10 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wireless/ath/ath10k/core.c
>> index 6f78f1752cd6..991fe8d92297 100644
>> --- a/drivers/net/wireless/ath/ath10k/core.c
>> +++ b/drivers/net/wireless/ath/ath10k/core.c
>> @@ -3,7 +3,6 @@
>>    * Copyright (c) 2005-2011 Atheros Communications Inc.
>>    * Copyright (c) 2011-2017 Qualcomm Atheros, Inc.
>>    * Copyright (c) 2018-2019, The Linux Foundation. All rights reserved.
>> - * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
>>    * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>>    */
>>   
>> @@ -2493,8 +2492,9 @@ static int ath10k_init_hw_params(struct ath10k *ar)
>>   	return 0;
>>   }
>>   
>> -static bool ath10k_core_needs_recovery(struct ath10k *ar)
>> +static void ath10k_core_recovery_check_work(struct work_struct *work)
>>   {
>> +	struct ath10k *ar = container_of(work, struct ath10k, recovery_check_work);
>>   	long time_left;
>>   
>>   	/* Sometimes the recovery will fail and then the next all recovery fail,
>> @@ -2504,7 +2504,7 @@ static bool ath10k_core_needs_recovery(struct ath10k *ar)
>>   		ath10k_err(ar, "consecutive fail %d times, will shutdown driver!",
>>   			   atomic_read(&ar->fail_cont_count));
>>   		ar->state = ATH10K_STATE_WEDGED;
>> -		return false;
>> +		return;
>>   	}
>>   
>>   	ath10k_dbg(ar, ATH10K_DBG_BOOT, "total recovery count: %d", ++ar->recovery_count);
>> @@ -2518,27 +2518,23 @@ static bool ath10k_core_needs_recovery(struct ath10k *ar)
>>   							ATH10K_RECOVERY_TIMEOUT_HZ);
>>   		if (time_left) {
>>   			ath10k_warn(ar, "previous recovery succeeded, skip this!\n");
>> -			return false;
>> +			return;
>>   		}
>>   
>>   		/* Record the continuous recovery fail count when recovery failed. */
>>   		atomic_inc(&ar->fail_cont_count);
>>   
>>   		/* Avoid having multiple recoveries at the same time. */
>> -		return false;
>> +		return;
>>   	}
>>   
>>   	atomic_inc(&ar->pending_recovery);
>> -
>> -	return true;
>> +	queue_work(ar->workqueue, &ar->restart_work);
>>   }
>>   
>>   void ath10k_core_start_recovery(struct ath10k *ar)
>>   {
>> -	if (!ath10k_core_needs_recovery(ar))
>> -		return;
>> -
>> -	queue_work(ar->workqueue, &ar->restart_work);
>> +	queue_work(ar->workqueue, &ar->recovery_check_work);
>>   }
>>   EXPORT_SYMBOL(ath10k_core_start_recovery);
>>   
>> @@ -3734,6 +3730,7 @@ struct ath10k *ath10k_core_create(size_t priv_size, struct device *dev,
>>   
>>   	INIT_WORK(&ar->register_work, ath10k_core_register_work);
>>   	INIT_WORK(&ar->restart_work, ath10k_core_restart);
>> +	INIT_WORK(&ar->recovery_check_work, ath10k_core_recovery_check_work);
>>   	INIT_WORK(&ar->set_coverage_class_work,
>>   		  ath10k_core_set_coverage_class_work);
>>   
>> diff --git a/drivers/net/wireless/ath/ath10k/core.h b/drivers/net/wireless/ath/ath10k/core.h
>> index 8c72ed386edb..859176fcb5a2 100644
>> --- a/drivers/net/wireless/ath/ath10k/core.h
>> +++ b/drivers/net/wireless/ath/ath10k/core.h
>> @@ -3,7 +3,6 @@
>>    * Copyright (c) 2005-2011 Atheros Communications Inc.
>>    * Copyright (c) 2011-2017 Qualcomm Atheros, Inc.
>>    * Copyright (c) 2018-2019, The Linux Foundation. All rights reserved.
>> - * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
>>    * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>>    */
>>   
>> @@ -1208,6 +1207,7 @@ struct ath10k {
>>   
>>   	struct work_struct register_work;
>>   	struct work_struct restart_work;
>> +	struct work_struct recovery_check_work;
> 
> Instead of adding a new work item, how about just moving the recovery check logic into the
> exsiting restart_work?
> 

If we use only one work, Linux’s workqueue mechanism will ignore new 
recovery triggers while the previous one is still queued or executing. 
This means we can't track consecutive failures or enter the WEDGED state 
in consecutive failures cases.




>>   	struct work_struct bundle_tx_work;
>>   	struct work_struct tx_complete_work;
>>   
>> diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
>> index 154ac7a70982..da6f7957a0ae 100644
>> --- a/drivers/net/wireless/ath/ath10k/mac.c
>> +++ b/drivers/net/wireless/ath/ath10k/mac.c
>> @@ -3,7 +3,6 @@
>>    * Copyright (c) 2005-2011 Atheros Communications Inc.
>>    * Copyright (c) 2011-2017 Qualcomm Atheros, Inc.
>>    * Copyright (c) 2018-2019, The Linux Foundation. All rights reserved.
>> - * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
>>    * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>>    */
>>   
>> @@ -5428,6 +5427,7 @@ static void ath10k_stop(struct ieee80211_hw *hw, bool suspend)
>>   	cancel_work_sync(&ar->set_coverage_class_work);
>>   	cancel_delayed_work_sync(&ar->scan.timeout);
>>   	cancel_work_sync(&ar->restart_work);
>> +	cancel_work_sync(&ar->recovery_check_work);
>>   }
>>   
>>   static int ath10k_config_ps(struct ath10k *ar)
> 


