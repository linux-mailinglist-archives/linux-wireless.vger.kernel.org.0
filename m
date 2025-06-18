Return-Path: <linux-wireless+bounces-24233-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E662BADE130
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Jun 2025 04:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 824D3161E4B
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Jun 2025 02:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F4781B4121;
	Wed, 18 Jun 2025 02:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IAj6dwQO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C551A2398
	for <linux-wireless@vger.kernel.org>; Wed, 18 Jun 2025 02:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750214432; cv=none; b=twOxe+FFQ0P7408V7Rmw+4oyOpn//YQIf1+L5C5OOi9qT0OnFmjqpk5efArhMk4+gVA+sKwWT9lARlKS21UWBcXHWEzTcNSoQs5vmkRhxzeHFLIL4yAZyM1V5elOr6j6qmYIVI6VVkpp3ePSkXMjxFH7/EU5nirg/q/CuW9ssW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750214432; c=relaxed/simple;
	bh=Ab2nQhUyPjCXqk2RYLfHiCGou78ggOxPfpSKay50+bI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qx/vCc7lp5HEhlqmR0l76UazyMn9WWwkSMYTJx4A3AfqmekQsC8EigFapqzpJgm5+4eRqOs9lr9Ai2nN5qz+eo1ZnR2kmWitd5vJ9FwTJ5dWKlYf406JlXE4j+66AAThpaF+zPW+uXqHesPXNC+xkbd6OjKYUOl32B4vIpK58Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IAj6dwQO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55HEe1oH005078
	for <linux-wireless@vger.kernel.org>; Wed, 18 Jun 2025 02:40:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Br+2G+Vn37XcwLkt+flf2jJVNP97RRrpJeTa/ZX3DA8=; b=IAj6dwQOZTTsTgZM
	PsFFvFPmyFhsp4Zn2QbeQbKNZwgJCWQfSl7mgFcooHnLddwzzxxBs+D/Ue6rmPQm
	uV1tRq2EMqhl+C1cGAKDzDDdvlybZ7yEHQHaVQ4axD5chTtxlS9NraXos/tD8wv9
	Bozer630S4P2UcZpCsicGMhIPMS3eNZdSgn/sVYr91Ns3ZnIkH/HhmbMMozhBtY4
	oUzEVUUGPiWN/BYsJ+mGhQ8fHdAh0xR6/KADBKLr/kqsz29fYiHGzDtH8QMlD15j
	Tni1hYpu1HZiZtNj0exsnYoMYemnwscXy66bgAdNyWrEoJF5i+ml04xK+w4bMOqt
	HH+xvA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ag236f8q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 18 Jun 2025 02:40:28 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3132c1942a1so10104337a91.2
        for <linux-wireless@vger.kernel.org>; Tue, 17 Jun 2025 19:40:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750214427; x=1750819227;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Br+2G+Vn37XcwLkt+flf2jJVNP97RRrpJeTa/ZX3DA8=;
        b=n3H8+Fylb76jp14B52saww0291I+FhOjObNCppi+PfJgBz5XaBYqxDAXSEpJuIZKGD
         HvOuxCyjMba6+5YlmwKw1g5FtJNBRZmrN3Vnc5ePqg3VxClRk/36cjEdn1u2lu1WxCI4
         zzHM0l57xKWLpAJyaN6uYmSUYTUArdZCM3dMrCQMsCvmipybuD6hf0HaQLsNQ3EpPwVB
         xU/91C3H/UWsQQpSPLnzf8eyQXtepdbsGE4vrQGaDs/48o/ZGwtpm8i4kuzn2zlnlZKD
         tLAm7X/W4Z/iBVm4CqdHtTudxvSrKdb1IktoWeHL8cmAaJjdwsIaac47xHJ0Ijbpvo0V
         SMPw==
X-Forwarded-Encrypted: i=1; AJvYcCUDJoS3VWUmHxppZnTahp+6R9YpZleLOTaW1ox5lHcWr4skiXIg8pnWAQilQPhQq3n0Tgv6eMyDliFkU1611Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6O6PgwXLheZ/JHnznAKAtuzpVkpqplpWfiieFjwxPnFu84189
	CVgK0RPuQaWiLgRE+S3ZGx/PEG5CDAkV9eztrydaWAXTkG13q4TbWX2u6gRZbSAv0Fkth0NLk9f
	GnPbSFV78V7yhQ7J7HmyChUgc+NDGcQRGp8XrqusfT5lXhVp2kGny+QpAjTv3P6F1yNsxEg==
X-Gm-Gg: ASbGncuKIv7Q6cLPT6itsfnMrx/aBk2i+3t80wAW7axbbtqgia7RDAOYn6o94rW12xv
	9foJPtDUHhuh+PmUmu7+0wPGg6aKzdEbrwPjXaZQkpB7V98pY2s8k0MoSfu7u6cD8/CQAzQDhXt
	nlmBeJdJFHe7Agj8r2jSGLkzwGjyAlMhzIGfO2pEC/9hW+f1rwfWoAQG3PjLz6yUqtm+/FX41TW
	UKYH+QktnDlmd1EEJmnlE05MS2qkHMtglvFjoNvP+r8vFvftqCFayGSb++eocgZy2rEB4hSo63Q
	kYMfGLF/4FHAxJCPKT5rNFQfqAVoNyMuMFQk1fshiNDZxO3gaoTj3sU41nFgaUyv384GQcwiyeI
	eJDLjd88goESdux8=
X-Received: by 2002:a17:90b:52c7:b0:311:ffe8:20e2 with SMTP id 98e67ed59e1d1-313f1ca7861mr23852226a91.4.1750214427051;
        Tue, 17 Jun 2025 19:40:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGjfWNmudbdyTRs//5yyY5SCk9ZSl/HawoM39CRh61NaezGWvahBqW/pmmG2oHlUyxoj4EifA==
X-Received: by 2002:a17:90b:52c7:b0:311:ffe8:20e2 with SMTP id 98e67ed59e1d1-313f1ca7861mr23852190a91.4.1750214426544;
        Tue, 17 Jun 2025 19:40:26 -0700 (PDT)
Received: from [10.133.33.197] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365d8a5cc5sm88291305ad.77.2025.06.17.19.40.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jun 2025 19:40:26 -0700 (PDT)
Message-ID: <17f17482-7b1a-489e-8fc8-9192b3527304@oss.qualcomm.com>
Date: Wed, 18 Jun 2025 10:40:23 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next] wifi: ath10k: shutdown driver when hardware is
 unreliable
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
References: <20250610095455.1443-1-kang.yang@oss.qualcomm.com>
 <CAFEp6-2VOQRdYCzW1gjr71L0LZrYK5DFocUGnNoSuvAiQ32CDg@mail.gmail.com>
Content-Language: en-US
From: Kang Yang <kang.yang@oss.qualcomm.com>
In-Reply-To: <CAFEp6-2VOQRdYCzW1gjr71L0LZrYK5DFocUGnNoSuvAiQ32CDg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 9hKIEYYE0aNCvEOdOymgoGQKjP_sqEZl
X-Authority-Analysis: v=2.4 cv=edY9f6EH c=1 sm=1 tr=0 ts=6852271c cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=xrYnZFTBQmgOpL-nygQA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE4MDAyMiBTYWx0ZWRfX3wuMz0ErSNoI
 /q2DKlqZ5AHM47C9ALShSxnXUPGX4uys6pSbcR1xlOddEQvv2d3ORummApZrE/Gsb2tsyO60XqC
 W+K4AMuMoX68dT411bIaB/X4tSzqBWZGHjLQGJlu+I9X4SVCL+lz3neW6ga60mfr8Y4pwo4eLQX
 raaVCFJAPLV6quAUR9PfTocBXXp9ecCUaJ3p5s+fap9JVF7gBhFl9AxGw9Ppw0pVhEnnqVZFi68
 JkNok5q8vdZ+jfwXCnINkxpAZNMtu5PHnAtg0zuzk3b5AUDx4jhqXRJtR3RHr9gjECJhjCEuxlE
 ipRtDfdzd/qMBUl9UPzjErFzxBInXGExj0gfvrAQ+3cLl/4w+ZjkaXQGi969dOBdjHuKCBm0jmG
 Kj0V52aboLxEsBXKTl9A414+2He4uTFSzYGa5+/c6eccP4zTwujCEAEcmN0IjIpGTbybk/T2
X-Proofpoint-GUID: 9hKIEYYE0aNCvEOdOymgoGQKjP_sqEZl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-18_01,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 spamscore=0 bulkscore=0
 impostorscore=0 mlxscore=0 clxscore=1015 mlxlogscore=999 malwarescore=0
 phishscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506180022



On 6/13/2025 8:59 PM, Loic Poulain wrote:
> Hi Kang,
> 
> 
> On Tue, Jun 10, 2025 at 11:55 AM Kang Yang <kang.yang@oss.qualcomm.com> wrote:
>>
>> In rare cases, ath10k may lose connection with the PCIe bus due to
>> some unknown reasons, which could further lead to system crashes during
>> resuming due to watchdog timeout:
>>
>> ath10k_pci 0000:01:00.0: wmi command 20486 timeout, restarting hardware
>> ath10k_pci 0000:01:00.0: already restarting
>> ath10k_pci 0000:01:00.0: failed to stop WMI vdev 0: -11
>> ath10k_pci 0000:01:00.0: failed to stop vdev 0: -11
>> ieee80211 phy0: PM: **** DPM device timeout ****
>> Call Trace:
>>   panic+0x125/0x315
>>   dpm_watchdog_set+0x54/0x54
>>   dpm_watchdog_handler+0x57/0x57
>>   call_timer_fn+0x31/0x13c
>>
>> At this point, all WMI commands will timeout and attempt to restart
>> device. So set a threshold for consecutive restart failures. If the
>> threshold is exceeded, consider the hardware is unreliable and all
>> ath10k operations should be skipped to avoid system crash.
>>
>> fail_cont_count and pending_recovery are atomic variables, and
>> do not involve complex conditional logic. Therefore, even if recovery
>> check and reconfig complete are executed concurrently, the recovery
>> mechanism will not be broken.
>>
>> Tested-on: QCA6174 hw3.2 PCI WLAN.RM.4.4.1-00288-QCARMSWPZ-1
>>
>> Signed-off-by: Kang Yang <kang.yang@oss.qualcomm.com>
>> ---
>>   drivers/net/wireless/ath/ath10k/core.c | 50 +++++++++++++++++++++++---
>>   drivers/net/wireless/ath/ath10k/core.h | 11 ++++--
>>   drivers/net/wireless/ath/ath10k/mac.c  |  7 +++-
>>   drivers/net/wireless/ath/ath10k/wmi.c  |  6 ++++
>>   4 files changed, 65 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wireless/ath/ath10k/core.c
>> index fe3a8f4a1cc1..f925a3cf9ebd 100644
>> --- a/drivers/net/wireless/ath/ath10k/core.c
>> +++ b/drivers/net/wireless/ath/ath10k/core.c
>> @@ -4,6 +4,7 @@
>>    * Copyright (c) 2011-2017 Qualcomm Atheros, Inc.
>>    * Copyright (c) 2018-2019, The Linux Foundation. All rights reserved.
>>    * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
>> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>>    */
>>
>>   #include <linux/module.h>
>> @@ -2491,12 +2492,51 @@ static int ath10k_init_hw_params(struct ath10k *ar)
>>          return 0;
>>   }
>>
>> +static bool ath10k_core_needs_recovery(struct ath10k *ar)
>> +{
>> +       long time_left;
>> +
>> +       /* Sometimes the recovery will fail and then the next all recovery fail,
>> +        * so avoid infinite recovery.
>> +        */
>> +       if (atomic_read(&ar->fail_cont_count) >= ATH10K_RECOVERY_MAX_FAIL_COUNT) {
>> +               ath10k_err(ar, "consecutive fail %d times, will shutdown driver!",
>> +                          atomic_read(&ar->fail_cont_count));
>> +               ar->state = ATH10K_STATE_WEDGED;
>> +               return false;
>> +       }
>> +
>> +       ath10k_dbg(ar, ATH10K_DBG_BOOT, "total recovery count: %d",
> 
> You don't need a newline.
> 
>> +                  ++ar->recovery_count);
>> +
>> +       if (atomic_read(&ar->pending_recovery)) {
>> +               /* Sometimes it happened another recovery work before the previous one
>> +                * completed, then the second recovery work will destroy the previous
>> +                * one, thus below is to avoid that.
>> +                */
>> +               time_left = wait_for_completion_timeout(&ar->driver_recovery,
>> +                                                       ATH10K_RECOVERY_TIMEOUT_HZ);
>> +               if (time_left) {
>> +                       ath10k_warn(ar, "previous recovery succeeded, skip this!\n");
>> +                       return false;
>> +               }
>> +
>> +               /* Record the continuous recovery fail count when recovery failed. */
>> +               atomic_inc(&ar->fail_cont_count);
>> +
>> +               /* Avoid having multiple recoveries at the same time. */
>> +               return false;
>> +       }
>> +
>> +       atomic_inc(&ar->pending_recovery);
>> +
>> +       return true;
>> +}
>> +
>>   void ath10k_core_start_recovery(struct ath10k *ar)
>>   {
>> -       if (test_and_set_bit(ATH10K_FLAG_RESTARTING, &ar->dev_flags)) {
>> -               ath10k_warn(ar, "already restarting\n");
>> +       if (!ath10k_core_needs_recovery(ar))
>>                  return;
>> -       }
>>
>>          queue_work(ar->workqueue, &ar->restart_work);
>>   }
>> @@ -2532,6 +2572,8 @@ static void ath10k_core_restart(struct work_struct *work)
>>          struct ath10k *ar = container_of(work, struct ath10k, restart_work);
>>          int ret;
>>
>> +       reinit_completion(&ar->driver_recovery);
>> +
>>          set_bit(ATH10K_FLAG_CRASH_FLUSH, &ar->dev_flags);
>>
>>          /* Place a barrier to make sure the compiler doesn't reorder
>> @@ -2596,8 +2638,6 @@ static void ath10k_core_restart(struct work_struct *work)
>>          if (ret)
>>                  ath10k_warn(ar, "failed to send firmware crash dump via devcoredump: %d",
>>                              ret);
>> -
>> -       complete(&ar->driver_recovery);
>>   }
>>
>>   static void ath10k_core_set_coverage_class_work(struct work_struct *work)
>> diff --git a/drivers/net/wireless/ath/ath10k/core.h b/drivers/net/wireless/ath/ath10k/core.h
>> index 446dca74f06a..06ac95707531 100644
>> --- a/drivers/net/wireless/ath/ath10k/core.h
>> +++ b/drivers/net/wireless/ath/ath10k/core.h
>> @@ -4,6 +4,7 @@
>>    * Copyright (c) 2011-2017 Qualcomm Atheros, Inc.
>>    * Copyright (c) 2018-2019, The Linux Foundation. All rights reserved.
>>    * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
>> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>>    */
>>
>>   #ifndef _CORE_H_
>> @@ -87,6 +88,8 @@
>>                                    IEEE80211_IFACE_SKIP_SDATA_NOT_IN_DRIVER)
>>   #define ATH10K_ITER_RESUME_FLAGS (IEEE80211_IFACE_ITER_RESUME_ALL |\
>>                                    IEEE80211_IFACE_SKIP_SDATA_NOT_IN_DRIVER)
>> +#define ATH10K_RECOVERY_TIMEOUT_HZ                     (5 * HZ)
>> +#define ATH10K_RECOVERY_MAX_FAIL_COUNT                 4
>>
>>   struct ath10k;
>>
>> @@ -865,9 +868,6 @@ enum ath10k_dev_flags {
>>          /* Per Station statistics service */
>>          ATH10K_FLAG_PEER_STATS,
>>
>> -       /* Indicates that ath10k device is during recovery process and not complete */
>> -       ATH10K_FLAG_RESTARTING,
>> -
>>          /* protected by conf_mutex */
>>          ATH10K_FLAG_NAPI_ENABLED,
>>   };
>> @@ -1211,6 +1211,11 @@ struct ath10k {
>>          struct work_struct bundle_tx_work;
>>          struct work_struct tx_complete_work;
>>
>> +       atomic_t pending_recovery;
>> +       u8 recovery_count;
> 
> No reason to be a u8 IMO, use unsigned int.

OK, will change this.

> 
>> +       /* continuous recovery fail count */
>> +       atomic_t fail_cont_count;
>> +


