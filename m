Return-Path: <linux-wireless+bounces-13391-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C307198C801
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Oct 2024 00:17:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EA5F285C3E
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Oct 2024 22:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F1C199FCF;
	Tue,  1 Oct 2024 22:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="U/2/B+3l"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF471A276
	for <linux-wireless@vger.kernel.org>; Tue,  1 Oct 2024 22:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727821017; cv=none; b=uymOr2NVB/3uAROrhaz/pGaN3xq+GVkbV+lwZjZDss8+mgXIkZWbLQMB+jx44xl5NF4bXmMWZW2nbzRS8mS94JUlX0DjI5GrspYi7M/D9SGyLD2WOcdFArhLPv5qu45u1pWPwLNexdYVH91d/drLg8GsyB2a8kJT1WgzzUn/pgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727821017; c=relaxed/simple;
	bh=Ccai9lwq6zdF/M+odjKzEOIMYBrI+jcpq44Lm7DTVtU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=N8K2HbY/4rtBWNnab8qOh+s0zTNkvPn87dTygXSNg/f7FizkpKXx2hPeGWvY8/6UO0XSUuoigD9hMlxK3lUn5mpYJ0aGNaU2uuZ22z8SjcjSdS4lhysiwW1214C09MsaAAlqufyMbkvotANRTEqg68W3mqTLyVOtmfe9XcVeE5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=U/2/B+3l; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 491BTbjc008088;
	Tue, 1 Oct 2024 22:16:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	p+R9xUtQWR+Sw1XdO5QF5AXylA7stnEwUMbRSf4or5M=; b=U/2/B+3lqTCU3nc2
	PRIvUxyo07oztN0ftkdC226BU5kiqgvK4CBsmJB7IvGCUQwjAvW1O0sjKTsbtCo8
	yEIfV0UZhJZOT6lavV1iav2H0DgI89z3iPME2BkDDpWFS71jh3aj9Y6M8d+W2L9J
	vwCgMNGfQ1xVXly3PbdARMk3lFbqoyhejx+MdImcUwMb62GdNv8QV217ctH3BxxM
	VJeZI6sgB6lSHe6TKptt4L8ZacaMSZjc+njCFqAFsKh8Ie+cHXiH/Mjg+4ZORiUP
	JcO/l5lsXaeZYx0dDZ4fNsLGxmpEIfhBUJT92xF1jAxVpwSWF22J6rkZ1xPTtNgv
	/khaoQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41xa679tqy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Oct 2024 22:16:49 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 491MGliv020504
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 1 Oct 2024 22:16:47 GMT
Received: from [10.111.183.230] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 1 Oct 2024
 15:16:46 -0700
Message-ID: <14db82b4-dfc0-4f21-a6aa-d6ed80f42638@quicinc.com>
Date: Tue, 1 Oct 2024 15:16:46 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: ath12k: fix use-after-free in
 ath12k_dp_cc_cleanup()
To: Rameshkumar Sundaram <quic_ramess@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20241001092652.3134334-1-quic_ramess@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <20241001092652.3134334-1-quic_ramess@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: bekQMfh69v7Qf9libl6MpJg52gyuMD6P
X-Proofpoint-ORIG-GUID: bekQMfh69v7Qf9libl6MpJg52gyuMD6P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 mlxlogscore=901 malwarescore=0 mlxscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 adultscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2410010147

On 10/1/2024 2:26 AM, Rameshkumar Sundaram wrote:
> During ath12k module removal, in ath12k_core_deinit(),
> ath12k_mac_destroy() un-registers ah->hw from mac80211 and frees
> the ah->hw as well as all the ar's in it. After this
> ath12k_core_soc_destroy()-> ath12k_dp_free()-> ath12k_dp_cc_cleanup()
> tries to access one of the freed ar's from pending skb.
> 
> This is because during mac destroy, driver failed to flush few
> data packets, which were accessed later in ath12k_dp_cc_cleanup()
> and freed, but using ar from the packet led to this use-after-free.
> 
> BUG: KASAN: use-after-free in ath12k_dp_cc_cleanup.part.0+0x5e2/0xd40 [ath12k]
> Write of size 4 at addr ffff888150bd3514 by task modprobe/8926
> CPU: 0 UID: 0 PID: 8926 Comm: modprobe Not tainted
> 6.11.0-rc2-wt-ath+ #1746
> Hardware name: Intel(R) Client Systems NUC8i7HVK/NUC8i7HVB, BIOS
> HNKBLi70.86A.0067.2021.0528.1339 05/28/2021
> 
> Call Trace:
>   <TASK>
>   dump_stack_lvl+0x7d/0xe0
>   print_address_description.constprop.0+0x33/0x3a0
>   print_report+0xb5/0x260
>   ? kasan_addr_to_slab+0x24/0x80
>   kasan_report+0xd8/0x110
>   ? ath12k_dp_cc_cleanup.part.0+0x5e2/0xd40 [ath12k]
>   ? ath12k_dp_cc_cleanup.part.0+0x5e2/0xd40 [ath12k]
>   kasan_check_range+0xf3/0x1a0
>   __kasan_check_write+0x14/0x20
>   ath12k_dp_cc_cleanup.part.0+0x5e2/0xd40 [ath12k]
>   ath12k_dp_free+0x178/0x420 [ath12k]
>   ath12k_core_stop+0x176/0x200 [ath12k]
>   ath12k_core_deinit+0x13f/0x210 [ath12k]
>   ath12k_pci_remove+0xad/0x1c0 [ath12k]
>   pci_device_remove+0x9b/0x1b0
>   device_remove+0xbf/0x150
>   device_release_driver_internal+0x3c3/0x580
>   ? __kasan_check_read+0x11/0x20
>   driver_detach+0xc4/0x190
>   bus_remove_driver+0x130/0x2a0
>   driver_unregister+0x68/0x90
>   pci_unregister_driver+0x24/0x240
>   ? find_module_all+0x13e/0x1e0
>   ath12k_pci_exit+0x10/0x20 [ath12k]
>   __do_sys_delete_module+0x32c/0x580
>   ? module_flags+0x2f0/0x2f0
>   ? kmem_cache_free+0xf0/0x410
>   ? __fput+0x56f/0xab0
>   ? __fput+0x56f/0xab0
>   ? debug_smp_processor_id+0x17/0x20
>   __x64_sys_delete_module+0x4f/0x70
>   x64_sys_call+0x522/0x9f0
>   do_syscall_64+0x64/0x130
>   entry_SYSCALL_64_after_hwframe+0x4b/0x53
> RIP: 0033:0x7f8182c6ac8b
> 
> Commit 24de1b7b231c ("wifi: ath12k: fix flush failure in recovery
> scenarios") added the change to decrement the pending packets count
> in case of recovery which make sense as ah->hw as well all
> ar's in it are intact during recovery, but during core deinit there
> is no use in decrementing packets count or waking up the empty waitq
> as the module is going to be removed also ar's from pending skb's
> can't be used and the packets should just be released back.
> 
> To fix this, avoid accessing ar from skb->cb when driver is being
> unregistered.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00214-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Fixes: 24de1b7b231c ("wifi: ath12k: fix flush failure in recovery scenarios")
> Signed-off-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


