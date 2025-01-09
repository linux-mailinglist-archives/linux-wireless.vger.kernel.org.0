Return-Path: <linux-wireless+bounces-17265-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC78CA081D0
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jan 2025 21:55:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB559160D9C
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jan 2025 20:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8F17204F9D;
	Thu,  9 Jan 2025 20:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IWCjcF3y"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA781FC114
	for <linux-wireless@vger.kernel.org>; Thu,  9 Jan 2025 20:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736456030; cv=none; b=aQmu/M3mJRWJnTSeQ1kHyYaD6cSNlqC1ULCDo614VEkXpIPpHEK4EhR5RncioxpbJXIWCo5U5163+wewBMnd/IRCADbp5XrptowYSy9u6rlYiwSMJ18JC/xcqp6gOzLelSBymI41/FJUFIo5S+MhjlUmIHhib7/ke9hnnOMB7ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736456030; c=relaxed/simple;
	bh=rm3Byw4n9WWD+7ggs1FrEk0PehLL6RnbZ114z0KFCVQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pB6bzzPlx56W0e7Vpe9okD66W67oXZETTsSngKOSkk+dv90ODkqADG9NRHC124M4C1H8ppnTXIRNUXhCuo6iANm9Wz1FbjsLhZYHiOrEWA2eWhUtQ4N0PMRe6IoWLyuQDSio0Y5lMDD6cs1JCL0qfITx4J9U3ACVAT0Yh5MfXxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IWCjcF3y; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 509K2CiQ031514
	for <linux-wireless@vger.kernel.org>; Thu, 9 Jan 2025 20:53:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QnNXGZR8YPidWZPnB4J0xVHahEH8RcI5bHz01S7I2Xs=; b=IWCjcF3yY/yaAFJ5
	15KueRD2cwFYzYtAC5KHEqEOn40QxxzV98nJkEsXfR00fF5493Nb7hLcABeUSLwI
	+W1e2cRcpw1/+Pir6RFKOcKXGXR02PqsxxBfH3rXPliOyJQ0y3cCn6mWeyxe0wCJ
	G71n6Qv9ebCqlD30tcMIwmeQ+Di0GDmRz9jS+1ZvYJ2AmEhqdT1Wm+oJPJtotlQ1
	iw4COkcG10uU6fZI7Oyo+/O/B6of2WnsVaEvFDjUTSwlZdPytj1Xd3bFe14puRl9
	MDQosBULwHo8PmwYcQGgLN5Fb4H25/FlAsL9Bsx167GZdIHoKtv6WTZkVba7dz6y
	Xi53hA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 442n4r036s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 09 Jan 2025 20:53:47 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2163a2a1ec2so37111945ad.1
        for <linux-wireless@vger.kernel.org>; Thu, 09 Jan 2025 12:53:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736456026; x=1737060826;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QnNXGZR8YPidWZPnB4J0xVHahEH8RcI5bHz01S7I2Xs=;
        b=SUVEHado3v2EnCbuuNI5psEQsGSwdvf/FE7Qi6vVYF+77FspnEY3L0k5SAwkP1ogNr
         HVJb2x+3qJJEqd0CbvYclFsdIYxlUj1iKLNYVxTrKDaaTUvbysTJQAwASXfK0uOAepOS
         efDSA/4gYIaT2goosxyjT1B2HhnIOITmpNaIODeTmQgwifoYo5nby1bYC9bmhGqiISYI
         PZz3XXGUyUED0Et6RI2aX2vcy0Oo+rXm3+HGgc4L+9BOty2/6rTMa9LH7MdWYmTLA8Pn
         egRwoAzUc/8og0cQ6ulFbsGav0pfnxkYtcy9pMPNGp6RtL/p7TgJ4mFEn7pFIWD3ADRn
         ODSA==
X-Forwarded-Encrypted: i=1; AJvYcCXDy5YUS9DGsZnBZusCLo9xg+30c2cnTKTmZHaUbM0IrLo62XK5DRj4vWgvoxfKy4P0RR8xKUbFCha88Rivbw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwgtpYqhKXMmAPHVlVY1zHFOxXFM6PvZeZwe2YmexmJnin1hv+I
	oZHsaY4WtZAjSlNt0hAPhnIc8nje9rJj0KiV/TdMG9PJzl8QDc7AMJqHv7INTzV6Ix/1mFYlQYP
	7yAkPu2F2IWx6o0c8pSdufQgLROXgMdPt7o0jJ6L3hivro0eOCflTYo9bWWhOddRMuA==
X-Gm-Gg: ASbGncsMZ2zUz4GMoOQKMDjbcLCeqSdRENYBNM/SPFekGCeZ4K3lRyRPcvH2xiTidNY
	u8vasx8MzKavBTm5RBkpqOzsLakDWXCzQ3dnMEs3J8SCSMUh9NgCjd2VTtSwArRym4tRFYiXtWn
	7EgJBTiTisEGR5xva9aZ2d5m5aqnKinc/zC65s4nodufKW3byTy/N/EOWr5z5gcp0KJ5ZMpzewa
	lPXYqLvqmEMVCZZGBY4IqtTLl1bFy1nj3wSgo5NZG9EUTNJ6LDk5LaeRNIcI63KzMINP0aISoQw
	crU2WQXN4eTKLJwwDNhBdqPBvgc6noJrFyH4
X-Received: by 2002:a05:6a00:1906:b0:72a:bc6a:3a85 with SMTP id d2e1a72fcca58-72d22007a0dmr11571565b3a.22.1736456025926;
        Thu, 09 Jan 2025 12:53:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHMC0RtDE+bv9hpJa0chTgo5Higx5f4zVcR+3kaoP9tDpUUtSWFmJ6Ni14+wdYRMnZwpbeGjg==
X-Received: by 2002:a05:6a00:1906:b0:72a:bc6a:3a85 with SMTP id d2e1a72fcca58-72d22007a0dmr11571533b3a.22.1736456025534;
        Thu, 09 Jan 2025 12:53:45 -0800 (PST)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d406a94e2sm220464b3a.172.2025.01.09.12.53.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jan 2025 12:53:45 -0800 (PST)
Message-ID: <03378c82-49a1-4271-b90f-3e2959b09e5c@oss.qualcomm.com>
Date: Thu, 9 Jan 2025 12:53:44 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/4] wifi: ath12k: Factory test mode support
To: Aaradhana Sahu <quic_aarasahu@quicinc.com>, Kalle Valo <kvalo@kernel.org>
Cc: Aditya Kumar Singh <quic_adisi@quicinc.com>, ath12k@lists.infradead.org,
        linux-wireless@vger.kernel.org
References: <20240624095305.37189-1-quic_aarasahu@quicinc.com>
 <d38ac7f6-3596-4336-bd9d-61e99f3b070c@quicinc.com>
 <b4852e3d-1f9a-40fe-9593-84d5812d25be@quicinc.com>
 <5f05898c-cc5c-4c31-891e-9d5cb9cf5bfa@oss.qualcomm.com>
 <87tta8du5h.fsf@kernel.org>
 <fb0aac6d-ddaf-4f86-a55b-5576c4894b89@quicinc.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <fb0aac6d-ddaf-4f86-a55b-5576c4894b89@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: cnGcGQV7Gza5kFEKCY9oII2YjpXjSvdS
X-Proofpoint-ORIG-GUID: cnGcGQV7Gza5kFEKCY9oII2YjpXjSvdS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 spamscore=0 impostorscore=0 clxscore=1015 malwarescore=0 adultscore=0
 bulkscore=0 lowpriorityscore=0 mlxlogscore=999 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501090165

On 1/9/2025 5:15 AM, Aaradhana Sahu wrote:
> 
> 
> On 1/9/2025 6:24 PM, Kalle Valo wrote:
>> Jeff Johnson <jeff.johnson@oss.qualcomm.com> writes:
>>
>>> On 1/8/2025 8:55 PM, Aditya Kumar Singh wrote:
>>>
>>>> On 1/9/25 10:13, Aaradhana Sahu wrote:
>>>>>
>>>>>
>>>>> On 6/24/2024 3:23 PM, Aaradhana Sahu wrote:
>>>>>> Device is booted in factory test mode for calibration.
>>>>>> The commands are sent from userspace application, which
>>>>>> is sent to firmware using wmi commands. Firmware sends
>>>>>> the response to driver as wmi events and driver sends
>>>>>> these events to the application via netlink message.
>>>>>>
>>>>>> Also added changes related to correct pdev id access for
>>>>>> fw test cmd.
>>>>>>
>>>>>> Aaradhana Sahu (3):
>>>>>>    wifi: ath: create common testmode_i.h file for ath drivers
>>>>>>    wifi: ath12k: export ath12k_wmi_tlv_hdr for testmode
>>>>>>    wifi: ath12k: add factory test mode support
>>>>>>
>>>>>> Rajat Soni (1):
>>>>>>    wifi: ath12k: Fill pdev id for fw test cmd
>>>>>>
>>>>>> ---
>>>>>> v5:
>>>>>>    -Updated copyright
>>>>>>    -Fixed line length within 90 char
>>>>>> v4:
>>>>>>    -Rebased on latest ToT
>>>>>> v3:
>>>>>>    -Rebased on latest ToT
>>>>>>    -Updated Tested-on Tag
>>>>>>    -Removed second parameter of ath12k_core_start()
>>>>>>    -Updated copyright
>>>>>> v2:
>>>>>>    -Rebased on latest ath ToT
>>>>>> ---
>>>>>>
>>>>>>   drivers/net/wireless/ath/ath11k/testmode.c    |  78 ++--
>>>>>>   drivers/net/wireless/ath/ath12k/Makefile      |   1 +
>>>>>>   drivers/net/wireless/ath/ath12k/core.c        |  22 +-
>>>>>>   drivers/net/wireless/ath/ath12k/core.h        |  13 +
>>>>>>   drivers/net/wireless/ath/ath12k/debug.h       |   1 +
>>>>>>   drivers/net/wireless/ath/ath12k/dp.c          |   3 +
>>>>>>   drivers/net/wireless/ath/ath12k/mac.c         |  15 +-
>>>>>>   drivers/net/wireless/ath/ath12k/pci.c         |   1 +
>>>>>>   drivers/net/wireless/ath/ath12k/testmode.c    | 423 ++++++++++++++++++
>>>>>>   drivers/net/wireless/ath/ath12k/testmode.h    |  40 ++
>>>>>>   drivers/net/wireless/ath/ath12k/wmi.c         |  39 +-
>>>>>>   drivers/net/wireless/ath/ath12k/wmi.h         |  21 +
>>>>>>   .../wireless/ath/{ath11k => }/testmode_i.h    |  54 +--
>>>>>>   13 files changed, 636 insertions(+), 75 deletions(-)
>>>>>>   create mode 100644 drivers/net/wireless/ath/ath12k/testmode.c
>>>>>>   create mode 100644 drivers/net/wireless/ath/ath12k/testmode.h
>>>>>>   rename drivers/net/wireless/ath/{ath11k => }/testmode_i.h (50%)
>>>>>>
>>>>>>
>>>>>> base-commit: cac9bfd02678adbcca9a7dce770609b9f7434d37
>>>>>
>>>>> Hi Kalle,
>>>>>
>>>>> Please let me know, if any thing is pending from the developer side, to merge this series into ath.git tree.
>>>>
>>>> This series does not apply cleanly on latest tip. And base commit is 
>>>> around 6 months old. So may be you would want to rebase and send a new 
>>>> version?
>>>>
>>>> Applying: wifi: ath: create common testmode_i.h file for ath drivers
>>>> Applying: wifi: ath12k: export ath12k_wmi_tlv_hdr for testmode
>>>> Applying: wifi: ath12k: add factory test mode support
>>>> error: patch failed: drivers/net/wireless/ath/ath12k/Makefile:26
>>>> error: drivers/net/wireless/ath/ath12k/Makefile: patch does not apply
>>>> error: patch failed: drivers/net/wireless/ath/ath12k/core.c:42
>>>> error: drivers/net/wireless/ath/ath12k/core.c: patch does not apply
>>>> error: patch failed: drivers/net/wireless/ath/ath12k/core.h:209
>>>> error: drivers/net/wireless/ath/ath12k/core.h: patch does not apply
>>>> error: patch failed: drivers/net/wireless/ath/ath12k/debug.h:33
>>>> error: drivers/net/wireless/ath/ath12k/debug.h: patch does not apply
>>>> error: patch failed: drivers/net/wireless/ath/ath12k/mac.c:13
>>>> error: drivers/net/wireless/ath/ath12k/mac.c: patch does not apply
>>>> error: patch failed: drivers/net/wireless/ath/ath12k/wmi.c:7150
>>>> error: drivers/net/wireless/ath/ath12k/wmi.c: patch does not apply
>>>> Patch failed at 0003 wifi: ath12k: add factory test mode support
>>>> hint: Use 'git am --show-current-patch=diff' to see the failed patch
>>>> When you have resolved this problem, run "git am --continue".
>>>> If you prefer to skip this patch, run "git am --skip" instead.
>>>> To restore the original branch and stop patching, run "git am --abort".
>>>>
>>>> And since you'll be submitting in 2025, don't forget to update
>>>> copyrights.
>>>>
>>>>
>>>
>>> Make sure to review all the changes that Kalle made locally to the pending
>>> version and incorporate those.
>>
>> BTW my changes are available in tag ath-pending-202407031443 and these
>> are the commit ids:
>>
>> 194fb8d58727 wifi: ath12k: Fill pdev id for fw test cmd
>> 0ca2ecc31b40 wifi: ath12k: add factory test mode support
>> df17f461e7c3 wifi: ath12k: export ath12k_wmi_tlv_hdr for testmode
>> 593b976359bf wifi: ath: create common testmode_i.h file for ath drivers
>>
> Thanks, I will pick your changes as well.

I've verified that v6 picks up Kalle's local changes

/jeff

