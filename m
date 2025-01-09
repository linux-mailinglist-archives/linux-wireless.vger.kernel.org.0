Return-Path: <linux-wireless+bounces-17241-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 61055A076EF
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jan 2025 14:15:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39B837A3BB0
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jan 2025 13:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC18BA2E;
	Thu,  9 Jan 2025 13:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="bba6Dacu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB05218ADF
	for <linux-wireless@vger.kernel.org>; Thu,  9 Jan 2025 13:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736428429; cv=none; b=PKJnZS8Jl0KJg171pQv05n7MlyJnIlxeL/1T8VQBjIFm/Jah4if74n9yJOXsEtaCFHyW5Sx0eYkgYa2Oc7Fc3ZwdVovyM6TCwWQVNtRaaT+IGS1Kgwh8zcRFA1UIAzfqcm0Wz+WmkNUEBgytoa0j1uhNaDgmHTZ5kQQb6ohytcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736428429; c=relaxed/simple;
	bh=tbgFllknNVFlOjw02iWDVdQPwosqU2UcmXeWY2y1oSs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bWrSh0IIh4RLLxiN6NlwSFrzsE/lrkB6/SItIq8lDzjlXPkUdJ4fS2d4mdPN1mnkkdQaZahEGMPFn6TF36V0vW1FBH3WkGd4GNf0EEdvt1ER7iNX//zksKeGBa2EdwptyNcLSZjYvIxR1Q1d5AK/La0UYmlYAibwJ3WCZfN3muU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=bba6Dacu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 509CC9Ut003633;
	Thu, 9 Jan 2025 13:13:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OUn2275MIuUj73ZXyCcTII1OJclVT0oPKmkONPClk38=; b=bba6Dacu6lXIOstp
	LTYiYx3lM2g2cCH9SUziXP72ow+iYdNdIIs4zCiSo/V1zQp3/4TnH6ACquIiB81g
	2BWXCVhbqv4RC0WPocselciGpNbYNxR4oujvXjEmF2XzzayUo/ggz6KQSjQh+bXE
	0GubPL+MM2XePZVJwGdkgIVQscNh7kAASaKEmurTCbHZ60UlvieVBXGfkeR5ephi
	373kc1KHitIfj2/e5w7rJLVHIdN7NrM1lFA3XtSTQekCVysz30LzN0wcvQ0kAe7X
	BIL2sUd72cpr8thNNylr2V12bAOp4xXnfmec8GBw25KjIKzpG3ryi5AOz8CSU99z
	j1rvKg==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 442e8cg4gn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jan 2025 13:13:42 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 509DDfBe028019
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 9 Jan 2025 13:13:41 GMT
Received: from [10.50.15.45] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 9 Jan 2025
 05:13:39 -0800
Message-ID: <5984d78e-71ff-48a6-9bf2-88ecc299bef6@quicinc.com>
Date: Thu, 9 Jan 2025 18:43:34 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/4] wifi: ath12k: Factory test mode support
To: Aditya Kumar Singh <quic_adisi@quicinc.com>, <ath12k@lists.infradead.org>,
        Kalle Valo <kvalo@kernel.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240624095305.37189-1-quic_aarasahu@quicinc.com>
 <d38ac7f6-3596-4336-bd9d-61e99f3b070c@quicinc.com>
 <b4852e3d-1f9a-40fe-9593-84d5812d25be@quicinc.com>
Content-Language: en-US
From: Aaradhana Sahu <quic_aarasahu@quicinc.com>
In-Reply-To: <b4852e3d-1f9a-40fe-9593-84d5812d25be@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: CAhpHClwbeSWqqg94PmKpHUwae6i-HE6
X-Proofpoint-ORIG-GUID: CAhpHClwbeSWqqg94PmKpHUwae6i-HE6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 impostorscore=0 adultscore=0 spamscore=0 suspectscore=0 phishscore=0
 clxscore=1015 malwarescore=0 bulkscore=0 mlxlogscore=999
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501090105



On 1/9/2025 10:25 AM, Aditya Kumar Singh wrote:
> On 1/9/25 10:13, Aaradhana Sahu wrote:
>>
>>
>> On 6/24/2024 3:23 PM, Aaradhana Sahu wrote:
>>> Device is booted in factory test mode for calibration.
>>> The commands are sent from userspace application, which
>>> is sent to firmware using wmi commands. Firmware sends
>>> the response to driver as wmi events and driver sends
>>> these events to the application via netlink message.
>>>
>>> Also added changes related to correct pdev id access for
>>> fw test cmd.
>>>
>>> Aaradhana Sahu (3):
>>>    wifi: ath: create common testmode_i.h file for ath drivers
>>>    wifi: ath12k: export ath12k_wmi_tlv_hdr for testmode
>>>    wifi: ath12k: add factory test mode support
>>>
>>> Rajat Soni (1):
>>>    wifi: ath12k: Fill pdev id for fw test cmd
>>>
>>> ---
>>> v5:
>>>    -Updated copyright
>>>    -Fixed line length within 90 char
>>> v4:
>>>    -Rebased on latest ToT
>>> v3:
>>>    -Rebased on latest ToT
>>>    -Updated Tested-on Tag
>>>    -Removed second parameter of ath12k_core_start()
>>>    -Updated copyright
>>> v2:
>>>    -Rebased on latest ath ToT
>>> ---
>>>
>>>   drivers/net/wireless/ath/ath11k/testmode.c    |  78 ++--
>>>   drivers/net/wireless/ath/ath12k/Makefile      |   1 +
>>>   drivers/net/wireless/ath/ath12k/core.c        |  22 +-
>>>   drivers/net/wireless/ath/ath12k/core.h        |  13 +
>>>   drivers/net/wireless/ath/ath12k/debug.h       |   1 +
>>>   drivers/net/wireless/ath/ath12k/dp.c          |   3 +
>>>   drivers/net/wireless/ath/ath12k/mac.c         |  15 +-
>>>   drivers/net/wireless/ath/ath12k/pci.c         |   1 +
>>>   drivers/net/wireless/ath/ath12k/testmode.c    | 423 ++++++++++++++++++
>>>   drivers/net/wireless/ath/ath12k/testmode.h    |  40 ++
>>>   drivers/net/wireless/ath/ath12k/wmi.c         |  39 +-
>>>   drivers/net/wireless/ath/ath12k/wmi.h         |  21 +
>>>   .../wireless/ath/{ath11k => }/testmode_i.h    |  54 +--
>>>   13 files changed, 636 insertions(+), 75 deletions(-)
>>>   create mode 100644 drivers/net/wireless/ath/ath12k/testmode.c
>>>   create mode 100644 drivers/net/wireless/ath/ath12k/testmode.h
>>>   rename drivers/net/wireless/ath/{ath11k => }/testmode_i.h (50%)
>>>
>>>
>>> base-commit: cac9bfd02678adbcca9a7dce770609b9f7434d37
>>
>> Hi Kalle,
>>
>> Please let me know, if any thing is pending from the developer side, to merge this series into ath.git tree.
> 
> This series does not apply cleanly on latest tip. And base commit is around 6 months old. So may be you would want to rebase and send a new version?
> 
> Applying: wifi: ath: create common testmode_i.h file for ath drivers
> Applying: wifi: ath12k: export ath12k_wmi_tlv_hdr for testmode
> Applying: wifi: ath12k: add factory test mode support
> error: patch failed: drivers/net/wireless/ath/ath12k/Makefile:26
> error: drivers/net/wireless/ath/ath12k/Makefile: patch does not apply
> error: patch failed: drivers/net/wireless/ath/ath12k/core.c:42
> error: drivers/net/wireless/ath/ath12k/core.c: patch does not apply
> error: patch failed: drivers/net/wireless/ath/ath12k/core.h:209
> error: drivers/net/wireless/ath/ath12k/core.h: patch does not apply
> error: patch failed: drivers/net/wireless/ath/ath12k/debug.h:33
> error: drivers/net/wireless/ath/ath12k/debug.h: patch does not apply
> error: patch failed: drivers/net/wireless/ath/ath12k/mac.c:13
> error: drivers/net/wireless/ath/ath12k/mac.c: patch does not apply
> error: patch failed: drivers/net/wireless/ath/ath12k/wmi.c:7150
> error: drivers/net/wireless/ath/ath12k/wmi.c: patch does not apply
> Patch failed at 0003 wifi: ath12k: add factory test mode support
> hint: Use 'git am --show-current-patch=diff' to see the failed patch
> When you have resolved this problem, run "git am --continue".
> If you prefer to skip this patch, run "git am --skip" instead.
> To restore the original branch and stop patching, run "git am --abort".
> 
> And since you'll be submitting in 2025, don't forget to update
> copyrights.
> 
> 
Sure, will address in the next version.


