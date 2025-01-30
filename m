Return-Path: <linux-wireless+bounces-18221-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4FAAA2320D
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jan 2025 17:39:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 729DB188ACD9
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jan 2025 16:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C9F1E9B24;
	Thu, 30 Jan 2025 16:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YK01jGOV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F621DA5F
	for <linux-wireless@vger.kernel.org>; Thu, 30 Jan 2025 16:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738254995; cv=none; b=QVYT+ZeLg9girvwmPFqW7hZCl1mcU/I91+JGYLyWRLDL8J20Qv+Y40q/CLSnY2600F6CM50RdnemjHL78bKacQFUW1J3IQbb5s4VOrtjhKREEJUDxIUu8h3WTmYPiv5DEJSSwkbXcxUk5pep9eVPYfKHj4/QDhWtGXGnbHJoKTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738254995; c=relaxed/simple;
	bh=aNhzIAUtQyw/GKC30Sg80JBuV00WAFScZaym00tqBs4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h103IEX+som/bQPoxdNojm6EbqW5IdzZfP/ETOS+5AdnnrrDtmXKH/FasJFmmw1r4L8rPg7dBMPOtSVpiFpc0iRdH/JTLhVCyvmdiKRGRIZnoCpJRzFMdW9FZtor8GHKbTjvMO20FoA++jiUwQMob23XysUo+4uAJkolaCikoBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YK01jGOV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50UG0Xjs030213
	for <linux-wireless@vger.kernel.org>; Thu, 30 Jan 2025 16:36:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1+PJHHNUM7JKRtqvYn0W2n6QUA5GasDwvRyMs9d5l8c=; b=YK01jGOV7O+L4QeD
	SbzN/ZzWynCoVJwaaZ27DmlxKxEkogD+NFufqmdLnOkweV5GSA4s92AhR8htDb9B
	JnV1pfU0rp0LnbWKlp7BXxGUkx0mMMu4sF1uieZwILXBhe3wp7iz8eUoumDvUdJH
	9mP1ag7lfsipeRlhIYynb8gqNXGpNsjS0lo7BBxm3Bx06eoXIOPvjKEOhy7CMeV1
	+/Fofp2Un6j1Sw+05b/5DMP1Z8sxw4dWrN4yPioXo2eGEHmIdaqMQ7j9S7ANrv3M
	VCsTTyJGNWOrvLZ/yNm0nsIlhYsjiU5YPvEeoDZXE/UXp1QGo6TWFQVRPUYE/pHm
	I+Wfhw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44gcjqg35k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 30 Jan 2025 16:36:32 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2ef7fbd99a6so1963531a91.1
        for <linux-wireless@vger.kernel.org>; Thu, 30 Jan 2025 08:36:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738254991; x=1738859791;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1+PJHHNUM7JKRtqvYn0W2n6QUA5GasDwvRyMs9d5l8c=;
        b=e3ClPPhPmlNqRlaekzrmIo1Lsq6DhQjbbL5C9T20L0+ciB45aLD/FwKl+O5GUt62nW
         qVqQlINoFHnycNGWWul1OLgk7JF8F4lKZ1crIMBO4wys88+ctm98Uam4W/dXG7NKVZl8
         NMqOr7Le//TwK1bC8p9gMdOxMWbLdJxyzbr1K7/BGYdC9FJrZBjsU/2veEad5aQUg8KO
         LVHldAELTKhwRQESZsJhr1Di1jIiQqK+OPPoFxHKkeSnomHV1WE5Ct7QpKqSldvxRTv3
         oSmP2nToMv+TQ5XTSagSTj/u4ENQZOvo5+nZ1U8yg14KTBep5gVZE+VbyYxjZapfVYk3
         cOkA==
X-Gm-Message-State: AOJu0Yw6aUQn+X7ikRD0hrc/GSd9AToZI0pVS2w02xwRAt6Nrc3Cv93t
	C4cqPvO+zrNTOoTwwEQmt4oUBcKSt60qL881hgQwQ+5IuhPxveh3ywQasyRHyn7Zv1unTMPdIn/
	wDMUkr5laQ5OkmzFfSnT8cFdTNzsEsDiObPDx4Hnd60UYazsd93FS9tURvjT5HE675g==
X-Gm-Gg: ASbGnctFSB7qrkUJFH7h2OothM2XC8Iyj+XSX5sAy5auq1qzT8bpkHMHpuNNmYnB9IF
	Lcc4eJKqePDZlYfkdVvz/X0d3eNlSR0ikX0tVabBo8BfIGlfIdIt3sGE/GdQKUT9phx89GvaJnu
	ZG8ikg0BZdsQx9l6RRk2VHyMNVcdLQ1ZlcxOnbfwmtrQTue84Dw72RaOPTpFapxI+uJIv1RrwT4
	4K5E/jDOTrMlJmAUqplz9D/qg1vzpUOz+BGw06LbqRha8EGSqFfRVUMUi2a2JXFvp8LhMkOrfEJ
	KTHb6eGyPWuJGlo6zRWJe1cBVThd2rgl3FB4HqlmtIapjf7qhHkppxRJ9OrqJTUvvvQgd9gnOA=
	=
X-Received: by 2002:a05:6a00:2c88:b0:725:ea30:ab15 with SMTP id d2e1a72fcca58-72fd0bc25a9mr10087335b3a.1.1738254991560;
        Thu, 30 Jan 2025 08:36:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFLHEHWPHz5nU11q7K8i4TTsLhAkJXiHYkIBZpCH9/QispHX5zVscF3iDnfEjO6RtQwhjKsqA==
X-Received: by 2002:a05:6a00:2c88:b0:725:ea30:ab15 with SMTP id d2e1a72fcca58-72fd0bc25a9mr10087309b3a.1.1738254991188;
        Thu, 30 Jan 2025 08:36:31 -0800 (PST)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe631be3csm1653651b3a.7.2025.01.30.08.36.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jan 2025 08:36:30 -0800 (PST)
Message-ID: <17deba42-f7e8-4582-87e9-e51a0f3c2bb4@oss.qualcomm.com>
Date: Thu, 30 Jan 2025 08:36:29 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/4] wifi: ath12k: Add new features to ACPI
To: Aditya Kumar Singh <quic_adisi@quicinc.com>,
        Lingbo Kong <quic_lingbok@quicinc.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250113074810.29729-1-quic_lingbok@quicinc.com>
 <4dadf825-0b9b-4109-a8a4-9eecc9f1dd5c@quicinc.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <4dadf825-0b9b-4109-a8a4-9eecc9f1dd5c@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: _ZmZSqcTSHZibHJOPUaBkRTa4FudBvee
X-Proofpoint-ORIG-GUID: _ZmZSqcTSHZibHJOPUaBkRTa4FudBvee
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-30_07,2025-01-30_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 spamscore=0
 clxscore=1015 mlxscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501300126

On 1/13/2025 1:06 AM, Aditya Kumar Singh wrote:
> On 1/13/25 13:18, Lingbo Kong wrote:
>> By reading ACPI tables, implement a method to obtain the ACPI functions
>> Bitmap, enable or disable specific features based on ACPI Bitflags and
>> download board data files based on ACPI board data filename extensions.
>>
>> v4:
>> 1.rebase to 0c5fcd9069dd
>>
>> v3:
>> 1.change some function name.
>>
>> v2:
>> 1.support functions for cases where CONFIG_ACPI is disabled
>>
>> Lingbo Kong (4):
>>    wifi: ath12k: Add support for obtaining the buffer type ACPI function
>>      bitmap
>>    wifi: ath12k: Add Support for enabling or disabling specific features
>>      based on ACPI bitflag
>>    wifi: ath12k: Adjust the timing to access ACPI table
>>    wifi: ath12k: Add support for reading variant from ACPI to download
>>      board data file
>>
>>   drivers/net/wireless/ath/ath12k/acpi.c | 200 +++++++++++++++++++------
>>   drivers/net/wireless/ath/ath12k/acpi.h |  38 +++++
>>   drivers/net/wireless/ath/ath12k/core.c |   8 +-
>>   drivers/net/wireless/ath/ath12k/core.h |   7 +
>>   drivers/net/wireless/ath/ath12k/mac.c  |   3 +-
>>   drivers/net/wireless/ath/ath12k/qmi.c  |   9 ++
>>   6 files changed, 217 insertions(+), 48 deletions(-)
>>
> 
> * drivers/net/wireless/ath/ath12k/acpi.c: 2025 copyright missing
> * drivers/net/wireless/ath/ath12k/acpi.h: 2025 copyright missing
> * drivers/net/wireless/ath/ath12k/core.c: 2025 copyright missing
> * drivers/net/wireless/ath/ath12k/core.h: 2025 copyright missing
> * drivers/net/wireless/ath/ath12k/mac.c: 2025 copyright missing
> * drivers/net/wireless/ath/ath12k/qmi.c: 2025 copyright missing
> 
> No need to respin just because of this.

Some of these were already updated by other commits, adjusted the following in 'pending':

* drivers/net/wireless/ath/ath12k/acpi.c
* drivers/net/wireless/ath/ath12k/acpi.h
https://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git/commit/?h=pending&id=caf84aa5266eae44823b736c5c77a39b92d26199

* drivers/net/wireless/ath/ath12k/qmi.c
https://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git/commit/?h=pending&id=856d8cd0fe08679af8cb3b9ac98848b1a79ec4b2









