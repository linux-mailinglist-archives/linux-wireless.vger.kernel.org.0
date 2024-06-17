Return-Path: <linux-wireless+bounces-9061-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 136E690ACB7
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2024 13:17:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 888901F21172
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2024 11:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51DEE19069A;
	Mon, 17 Jun 2024 11:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Q+aebDGh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5FA17B515
	for <linux-wireless@vger.kernel.org>; Mon, 17 Jun 2024 11:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718623041; cv=none; b=ZxoVldBvkB8gdLyoZR3ZeUpuOEmls7xgeeDX78eXEquHQ0UEuK4WpfXtZ8wCPOvXy4/4HQ58n0vZUsKYPnqqgAcaxGm2q6V/2Kl375oU8/obQmnC/AZVvgeJvySJZ1z9+SYNsnBOY2qQnr5EfQdf37ND0T8+bGr76AIxm+37P+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718623041; c=relaxed/simple;
	bh=jsHE8IdmgA9Gi3IVdy9rSkaxf6j+SkMH4w9r5Vnddwk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=mgbyA6JPKr6mC43nlW+Ufo1AFZOQIOe+dxkuA3vcrHowaTegcqG4Ccrtx8xabq5I4l+jpehS1DrmUCesYKkP0BozCdANj8Kh5AL5OYm6yYFBMOeF+52lmMjvC5SxbuIXBIbNBwx+DQNA4tka/fGxZU+NbW6ykhPlv89AhnUnMhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Q+aebDGh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45HAiIxo003122;
	Mon, 17 Jun 2024 11:17:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/RaIXtC6vsj3sHVRPSWqYl+q9D80xpcpne/9wrlpavI=; b=Q+aebDGhY+tUAAEl
	su+w4v53Y7DyzsxpZfWzW6JCQkdcE/d2TD56C9VOFxVeP2ctkNIGy6pEWm6kHiyb
	3zH3AMJD0O3Xu4svLhCI+X7EEfUdPYp+gmkDLj3eitZeIWwDShctTAo8dJZijC++
	btp5QEpoMp3+Jo2E924YDjM0gT6Q2xZyjF9A+k0Dk8D+MK7M8cNat/FOAIq91QRk
	rGop0DLT2UWIRlxQeozdXSi7tHv5y57q8dq90qCivPISUUNKqQGeASOMilhIKOnw
	Zw2hoMbb6oL4/cYlgFj1g0FhugWgErwpR4AxD5Kz2WZASReb29NpyEjhCAI7c/4+
	DGezZQ==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ys1y6uhxc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Jun 2024 11:17:13 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45HBHCGU015529
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Jun 2024 11:17:12 GMT
Received: from [10.152.193.243] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 17 Jun
 2024 04:17:10 -0700
Message-ID: <7e1ab778-83af-4e7e-bc5d-069bb6c83563@quicinc.com>
Date: Mon, 17 Jun 2024 16:47:01 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] ath12k: Factory test mode support
To: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <quic_jjohnson@quicinc.com>
CC: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20240611083427.881443-1-quic_aarasahu@quicinc.com>
 <cd77058f-7165-4342-893b-a59a3a18c3c5@quicinc.com>
 <875xudnf5x.fsf@kernel.org>
Content-Language: en-US
From: Aaradhana Sahu <quic_aarasahu@quicinc.com>
In-Reply-To: <875xudnf5x.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: nkyXtN-OlmobDKVUBI6HC53bA8BHMF3c
X-Proofpoint-ORIG-GUID: nkyXtN-OlmobDKVUBI6HC53bA8BHMF3c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-17_09,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 impostorscore=0 mlxscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 mlxlogscore=999 suspectscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406170087



On 6/13/2024 7:00 PM, Kalle Valo wrote:
> Jeff Johnson <quic_jjohnson@quicinc.com> writes:
> 
>> On 6/11/2024 1:34 AM, Aaradhana Sahu wrote:
>>
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
>>>   wifi: ath: create common testmode_i.h file for ath drivers
>>>   wifi: ath12k: export ath12k_wmi_tlv_hdr for testmode
>>>   wifi: ath12k: add factory test mode support
>>>
>>> Rajat Soni (1):
>>>   wifi: ath12k: Fill pdev id for fw test cmd
>>>
>>> ---
>>> v3:
>>>   -Rebased on latest ToT
>>>   -Updated Tested-on Tag
>>>   -Removed second parameter of ath12k_core_start()
>>>   -Updated copyright
>>> v2:
>>>   -Rebased on latest ath ToT
>>> ---
>>>
>>>  drivers/net/wireless/ath/ath11k/testmode.c    |  78 ++--
>>>  drivers/net/wireless/ath/ath12k/Makefile      |   1 +
>>>  drivers/net/wireless/ath/ath12k/core.c        |  22 +-
>>>  drivers/net/wireless/ath/ath12k/core.h        |  13 +
>>>  drivers/net/wireless/ath/ath12k/debug.h       |   1 +
>>>  drivers/net/wireless/ath/ath12k/dp.c          |   3 +
>>>  drivers/net/wireless/ath/ath12k/mac.c         |  15 +-
>>>  drivers/net/wireless/ath/ath12k/pci.c         |   1 +
>>>  drivers/net/wireless/ath/ath12k/testmode.c    | 422 ++++++++++++++++++
>>>  drivers/net/wireless/ath/ath12k/testmode.h    |  40 ++
>>>  drivers/net/wireless/ath/ath12k/wmi.c         |  39 +-
>>>  drivers/net/wireless/ath/ath12k/wmi.h         |  21 +
>>>  .../wireless/ath/{ath11k => }/testmode_i.h    |  52 +--
>>>  13 files changed, 634 insertions(+), 74 deletions(-)
>>>  create mode 100644 drivers/net/wireless/ath/ath12k/testmode.c
>>>  create mode 100644 drivers/net/wireless/ath/ath12k/testmode.h
>>>  rename drivers/net/wireless/ath/{ath11k => }/testmode_i.h (53%)
>>>
>>>
>>> base-commit: a116bf2be795eb1db75fa6a48aa85c397be001a6
>>
>> FYI this series is not applying cleanly in my tree for validation:
>>
>> Base: using specified base-commit a116bf2be795eb1db75fa6a48aa85c397be001a6
>> Applying: wifi: ath: create common testmode_i.h file for ath drivers
>> Using index info to reconstruct a base tree...
>> Patch failed at 0001 wifi: ath: create common testmode_i.h file for ath drivers
>> When you have resolved this problem, run "git am --continue".
>> If you prefer to skip this patch, run "git am --skip" instead.
>> To restore the original branch and stop patching, run "git am --abort".
>> error: patch failed: drivers/net/wireless/ath/ath11k/testmode_i.h:4
>> error: drivers/net/wireless/ath/ath11k/testmode_i.h: patch does not apply
>> error: Did you hand edit your patch?
>> It does not apply to blobs recorded in its index.
>>
>> I initially used b4, but tried again directly with git, and it failed for me 
>> with both mechanisms.
>> Kalle, do you have any issues with this series?
> 
> Also fails for me on top of commit a116bf2be795:
> 
> Applying: wifi: ath: create common testmode_i.h file for ath drivers
> Using index info to reconstruct a base tree...
> error: patch failed: drivers/net/wireless/ath/ath11k/testmode_i.h:4
> error: drivers/net/wireless/ath/ath11k/testmode_i.h: patch does not apply
> error: Did you hand edit your patch?
> It does not apply to blobs recorded in its index.
> Patch failed at 0001 wifi: ath: create common testmode_i.h file for ath drivers
> 
> Setting the patchset to Changes Requested.
> 

I have rebased and sent the next version.

