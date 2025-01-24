Return-Path: <linux-wireless+bounces-17876-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F21C7A1AF53
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Jan 2025 05:11:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80E257A22EC
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Jan 2025 04:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF061D79A6;
	Fri, 24 Jan 2025 04:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="oNUKDtdV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AEC81D63FB;
	Fri, 24 Jan 2025 04:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737691872; cv=none; b=jtbX2aT0TVmMGRvy2kI9i3o5Et3dXanPQSn+r778MPFXoxqyt7Ncz2Xqig+cw18zb1NLwMa2RjK5xBTlAmEbHzlPTHrQHT5WQykbFZy1f6NohpbJXTfgoMvUfrN2kYL3/uQGApILPgH79mN3EezRPWeJ0NszkxpLTmJamliuelU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737691872; c=relaxed/simple;
	bh=hJji8Xb5lLg6HIGgZSrM3DtcVBTgcJcsNYAsjrODfXE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=PfWrvC2utfpGbQ0zCHvX79jqAfnMKBPjh32RljNmnnhX5Pjwjlb0AGfIZTEZAs7LrxJNhH0ZJlQkunpOe59MxihhpgnfUbhEyeJoKv+dJ7IkxjdbrKVUJTto2axrRZAkWPVVQgvjTgLGRSv9gyXiJEQd6mvaufw6PVTxXeS7Vbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=oNUKDtdV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50NMm10f004131;
	Fri, 24 Jan 2025 04:11:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EuDpzg3ornkFM3/Es+Hiwaapi2f1gyJ+GQYQHdJRSMQ=; b=oNUKDtdVylkAaw55
	OLfeO5GxRL7SSbBxcgKwVABlhmeDyoFqZilxzCsQQBBf6QCrX6gg5sNJqWv4+QvU
	4aPsydCqicNuV4iz/NbNO2drgdKYR+lkGl+/LPhGNr5s43ibaYmQUGbijFhNzlt2
	rrQ6CpFmwgT6Symph/tq1AN/fOPKJWhjG9p3m2xOcF2QzsDW6usrIvIg/RjRu3pI
	zm6+nS1203FlSrvodsFko56/K/McMrdNH8tumK+MPi3/tXxPEnDeSd+eagLfVnqd
	zvrMXGCX6NeD6MDUpCS4mpr5ZVOa3H57kUjsKpoiv1HosKQEoU2b1h0lDKyzlCZD
	VuhhGw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44bxvpgh66-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jan 2025 04:11:01 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50O4AxEf014045
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jan 2025 04:10:59 GMT
Received: from [10.216.47.245] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 23 Jan
 2025 20:10:53 -0800
Message-ID: <d4f6be06-871a-4ec3-a8f2-4024f7689f1a@quicinc.com>
Date: Fri, 24 Jan 2025 09:40:48 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/10] wifi: ath12k: fixes for rmmod and recovery
 issues with hardware grouping
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        Kalle Valo
	<kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        "Karthikeyan
 Periyasamy" <quic_periyasa@quicinc.com>,
        Harshitha Prem
	<quic_hprem@quicinc.com>
CC: Kalle Valo <quic_kvalo@quicinc.com>, <linux-wireless@vger.kernel.org>,
        <ath12k@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20250120-fix_reboot_issues_with_hw_grouping-v2-0-b7d073bb2a22@quicinc.com>
 <c9c9dfb7-7198-4575-a576-d5e184ba2cba@oss.qualcomm.com>
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
Content-Language: en-US
In-Reply-To: <c9c9dfb7-7198-4575-a576-d5e184ba2cba@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: W1-zczC4df9viX0Dy1OC4--L5kLvukbJ
X-Proofpoint-GUID: W1-zczC4df9viX0Dy1OC4--L5kLvukbJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-24_01,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 impostorscore=0 mlxscore=0 lowpriorityscore=0 adultscore=0 spamscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 suspectscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501240027

On 1/23/25 23:17, Jeff Johnson wrote:
> On 1/20/2025 1:48 AM, Aditya Kumar Singh wrote:
>> With hardware grouping, there is a kernel crash with signature -
>>
>> $ rmmod ath12k.ko
>> Unable to handle kernel paging request at virtual address 000000000000d1a8
>> [...]
>> Call trace:
>>   ath12k_reg_free+0x14/0x74 [ath12k] (P)
>>   ath12k_core_hw_group_destroy+0x7c/0xb4 [ath12k] (L)
>>   ath12k_core_hw_group_destroy+0x7c/0xb4 [ath12k]
>>   ath12k_core_deinit+0xd8/0x124 [ath12k]
>>   ath12k_pci_remove+0x6c/0x130 [ath12k]
>>   pci_device_remove+0x44/0xe8
>>   device_remove+0x4c/0x80
>>   device_release_driver_internal+0x1d0/0x22c
>>   driver_detach+0x50/0x98
>>   bus_remove_driver+0x70/0xf4
>>   driver_unregister+0x30/0x60
>>   pci_unregister_driver+0x24/0x9c
>>   ath12k_pci_exit+0x18/0x24 [ath12k]
>>   __arm64_sys_delete_module+0x1a0/0x2a8
>>   invoke_syscall+0x48/0x110
>>   el0_svc_common.constprop.0+0x40/0xe0
>>   do_el0_svc+0x1c/0x28
>>   el0_svc+0x30/0xd0
>>   el0t_64_sync_handler+0x10c/0x138
>>   el0t_64_sync+0x198/0x19c
>> Code: a9bd7bfd 910003fd a9025bf5 91402015 (f968d6a1)
>> ---[ end trace 0000000000000000 ]---
>> Segmentation fault
>>
>> This series aims to fix this stability issue. With this now, 100+ iteration
>> of rmmod and insmod works perfectly.
>>
>> Also, firmware recovery with grouping is not working fine. Randomly, some
>> NULL pointer crash or another firmware assert is seen. This series aims to
>> fix that as well.
>>
>> With this in place now, 100+ iteration of firmware recovery with one 3 link
>> AP MLD up works fine.
>>
>> ---
>> Changes in v2:
>> - Rebased on ToT.
>> - No changes in 1-4, 6-10.
>> - Removed regd_freed flag in 5.
>> - Link to v1: https://lore.kernel.org/r/20250109-fix_reboot_issues_with_hw_grouping-v1-0-fb39ec03451e@quicinc.com
>>
>> ---
>> Aditya Kumar Singh (10):
>>        wifi: ath12k: prevent race condition in ath12k_core_hw_group_destroy()
>>        wifi: ath12k: add reference counting for core attachment to hardware group
>>        wifi: ath12k: fix failed to set mhi state error during reboot with hardware grouping
>>        wifi: ath12k: fix firmware assert during reboot with hardware grouping
>>        wifi: ath12k: fix SLUB BUG - Object already free in ath12k_reg_free()
>>        wifi: ath12k: fix ath12k_core_pre_reconfigure_recovery() with grouping
>>        wifi: ath12k: fix ATH12K_FLAG_REGISTERED flag handling
>>        wifi: ath12k: handle ath12k_core_restart() with hardware grouping
>>        wifi: ath12k: handle ath12k_core_reset() with hardware grouping
>>        wifi: ath12k: reset MLO global memory during recovery
>>
>>   drivers/net/wireless/ath/ath12k/core.c | 115 ++++++++++++++++++++++++++++++---
>>   drivers/net/wireless/ath/ath12k/core.h |  15 +----
>>   drivers/net/wireless/ath/ath12k/mac.c  |   6 --
>>   drivers/net/wireless/ath/ath12k/pci.c  |  28 +++++++-
>>   drivers/net/wireless/ath/ath12k/qmi.c  |  24 ++++++-
>>   drivers/net/wireless/ath/ath12k/qmi.h  |   4 +-
>>   drivers/net/wireless/ath/ath12k/reg.c  |   4 +-
>>   7 files changed, 163 insertions(+), 33 deletions(-)
>> ---
>> base-commit: e7ef944b3e2c31b608800925e784f67596375770
>> change-id: 20241218-fix_reboot_issues_with_hw_grouping-0c2d367a587b
>>
> 
> Fails to apply to current ath/main
> 
> * Applying v2_20250120_quic_adisi_wifi_ath12k_fixes_for_rmmod_and_recovery_issues_with_hardware_grouping.mbx
> Applying: wifi: ath12k: prevent race condition in ath12k_core_hw_group_destroy()
> Applying: wifi: ath12k: add reference counting for core attachment to hardware group
> Using index info to reconstruct a base tree...
> M       drivers/net/wireless/ath/ath12k/core.c
> M       drivers/net/wireless/ath/ath12k/core.h
> Falling back to patching base and 3-way merge...
> Auto-merging drivers/net/wireless/ath/ath12k/core.h
> CONFLICT (content): Merge conflict in drivers/net/wireless/ath/ath12k/core.h
> Auto-merging drivers/net/wireless/ath/ath12k/core.c
> Recorded preimage for 'drivers/net/wireless/ath/ath12k/core.h'
> error: Failed to merge in the changes.
> Patch failed at 0002 wifi: ath12k: add reference counting for core attachment to hardware group
> 

FTM changes are conflicting in .h file. I will rebase on ToT and send 
new version.

-- 
Aditya

