Return-Path: <linux-wireless+bounces-13856-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F053D998AC6
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Oct 2024 17:02:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D37A1C24A3E
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Oct 2024 15:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 276A81CC8BC;
	Thu, 10 Oct 2024 14:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OfZzxFyS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A0C1CF5FE
	for <linux-wireless@vger.kernel.org>; Thu, 10 Oct 2024 14:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728572197; cv=none; b=XSGa/9Uc8mu0iZu1vcFpiwiYv/llCdE6WTktr5UoKIAq88YTe1xRnvo48PNbwYzsmeNWQvA1ua6PsxgO6Q1SLyKGQ0CKa9pa+XPVkrCDNdXEGcgVnuehsr9v1nyoo2hM8PHDUGZHutlX5uyQjkuGVQuv61r2cBb1/t0OKusispo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728572197; c=relaxed/simple;
	bh=gXJ3HQevipbSKYoXkIM7QFl19f9q71ZvbHafaJ37o14=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=KrHQRmZ+iHz2pIeuOH8NfEF0SF4s6HtjU4QNfQaDckZBhlJqYPW26mQij1wLxcF8ZGNGJbvkw4YvVAzI1F5kj2Bhp9Lag0nOBfdXD+SHGy8PdREyhgEVNdt3TgGB8HrmKxGCdi8p3g/dTINniyehR/z1LrwRVxh0nOCH9fgx7jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=OfZzxFyS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49ADqTv9029116;
	Thu, 10 Oct 2024 14:56:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eX9podCORjmFR1Pc0Q8t/MkmNFpn03S9Uuj6cx09yjI=; b=OfZzxFyS6PGpsjR4
	0U0D9RzTOf/ehi/nuTrX1Z0p9/Gzl+YqxXgwvY10YIp1YMW76fBaO7v/dKsXWmCp
	3HcssVhS6z6rzLfEFgSHX2MnZe9qbqIIZbxIISAyMmbUOCQv0d4UFxmlxUNQf0AI
	rBGwT0u2+dSPu4SUukF+dN3m/iyqRfQ7AgJIkS4+z9V6Mm1iSs30BOkgh472TWix
	FqHM/scwbg6qTSV8ggL14BGZddUa3h5vjZKXg2BQYRo9ZVDLdZF9sqngxQb7SQbZ
	dAqoUV1m7V8Mf3soUMuUydtpIPaPsdpFft68df5ADuypziEfHB5ruTAIL4xoQOe5
	hhCWdA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 426g6n85kd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Oct 2024 14:56:29 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49AEuSL3012075
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Oct 2024 14:56:28 GMT
Received: from [10.48.240.152] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 10 Oct
 2024 07:56:27 -0700
Message-ID: <0cd72cf1-a444-46f0-b7bc-e1630d67f2e5@quicinc.com>
Date: Thu, 10 Oct 2024 07:56:27 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/6] wifi: ath12k: fix atomic calls in
 ath12k_mac_op_set_bitrate_mask()
To: Kalle Valo <kvalo@kernel.org>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20241007165932.78081-1-kvalo@kernel.org>
 <20241007165932.78081-2-kvalo@kernel.org>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <20241007165932.78081-2-kvalo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: jJMJNWRi2j80_RYndhmHJNUTt2W3Z2lJ
X-Proofpoint-GUID: jJMJNWRi2j80_RYndhmHJNUTt2W3Z2lJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 impostorscore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 phishscore=0 malwarescore=0
 clxscore=1015 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2410100099

On 10/7/2024 9:59 AM, Kalle Valo wrote:
> From: Kalle Valo <quic_kvalo@quicinc.com>
> 
> When I try to manually set bitrates:
> 
> iw wlan0 set bitrates legacy-2.4 1
> 
> I get sleeping from invalid context error, see below. Fix that by switching to
> use recently introduced ieee80211_iterate_stations_mtx().
> 
> Do note that WCN6855 firmware is still crashing, I'm not sure if that firmware
> even supports bitrate WMI commands and should we consider disabling
> ath12k_mac_op_set_bitrate_mask() for WCN6855? But that's for another patch.
> 
> BUG: sleeping function called from invalid context at drivers/net/wireless/ath/ath12k/wmi.c:420
> in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 2236, name: iw
> preempt_count: 0, expected: 0
> RCU nest depth: 1, expected: 0
> 3 locks held by iw/2236:
>  #0: ffffffffabc6f1d8 (cb_lock){++++}-{3:3}, at: genl_rcv+0x14/0x40
>  #1: ffff888138410810 (&rdev->wiphy.mtx){+.+.}-{3:3}, at: nl80211_pre_doit+0x54d/0x800 [cfg80211]
>  #2: ffffffffab2cfaa0 (rcu_read_lock){....}-{1:2}, at: ieee80211_iterate_stations_atomic+0x2f/0x200 [mac80211]
> CPU: 3 UID: 0 PID: 2236 Comm: iw Not tainted 6.11.0-rc7-wt-ath+ #1772
> Hardware name: Intel(R) Client Systems NUC8i7HVK/NUC8i7HVB, BIOS HNKBLi70.86A.0067.2021.0528.1339 05/28/2021
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0xa4/0xe0
>  dump_stack+0x10/0x20
>  __might_resched+0x363/0x5a0
>  ? __alloc_skb+0x165/0x340
>  __might_sleep+0xad/0x160
>  ath12k_wmi_cmd_send+0xb1/0x3d0 [ath12k]
>  ? ath12k_wmi_init_wcn7850+0xa40/0xa40 [ath12k]
>  ? __netdev_alloc_skb+0x45/0x7b0
>  ? __asan_memset+0x39/0x40
>  ? ath12k_wmi_alloc_skb+0xf0/0x150 [ath12k]
>  ? reacquire_held_locks+0x4d0/0x4d0
>  ath12k_wmi_set_peer_param+0x340/0x5b0 [ath12k]
>  ath12k_mac_disable_peer_fixed_rate+0xa3/0x110 [ath12k]
>  ? ath12k_mac_vdev_stop+0x4f0/0x4f0 [ath12k]
>  ieee80211_iterate_stations_atomic+0xd4/0x200 [mac80211]
>  ath12k_mac_op_set_bitrate_mask+0x5d2/0x1080 [ath12k]
>  ? ath12k_mac_vif_chan+0x320/0x320 [ath12k]
>  drv_set_bitrate_mask+0x267/0x470 [mac80211]
>  ieee80211_set_bitrate_mask+0x4cc/0x8a0 [mac80211]
>  ? __this_cpu_preempt_check+0x13/0x20
>  nl80211_set_tx_bitrate_mask+0x2bc/0x530 [cfg80211]
>  ? nl80211_parse_tx_bitrate_mask+0x2320/0x2320 [cfg80211]
>  ? trace_contention_end+0xef/0x140
>  ? rtnl_unlock+0x9/0x10
>  ? nl80211_pre_doit+0x557/0x800 [cfg80211]
>  genl_family_rcv_msg_doit+0x1f0/0x2e0
>  ? genl_family_rcv_msg_attrs_parse.isra.0+0x250/0x250
>  ? ns_capable+0x57/0xd0
>  genl_family_rcv_msg+0x34c/0x600
>  ? genl_family_rcv_msg_dumpit+0x310/0x310
>  ? __lock_acquire+0xc62/0x1de0
>  ? he_set_mcs_mask.isra.0+0x8d0/0x8d0 [cfg80211]
>  ? nl80211_parse_tx_bitrate_mask+0x2320/0x2320 [cfg80211]
>  ? cfg80211_external_auth_request+0x690/0x690 [cfg80211]
>  genl_rcv_msg+0xa0/0x130
>  netlink_rcv_skb+0x14c/0x400
>  ? genl_family_rcv_msg+0x600/0x600
>  ? netlink_ack+0xd70/0xd70
>  ? rwsem_optimistic_spin+0x4f0/0x4f0
>  ? genl_rcv+0x14/0x40
>  ? down_read_killable+0x580/0x580
>  ? netlink_deliver_tap+0x13e/0x350
>  ? __this_cpu_preempt_check+0x13/0x20
>  genl_rcv+0x23/0x40
>  netlink_unicast+0x45e/0x790
>  ? netlink_attachskb+0x7f0/0x7f0
>  netlink_sendmsg+0x7eb/0xdb0
>  ? netlink_unicast+0x790/0x790
>  ? __this_cpu_preempt_check+0x13/0x20
>  ? selinux_socket_sendmsg+0x31/0x40
>  ? netlink_unicast+0x790/0x790
>  __sock_sendmsg+0xc9/0x160
>  ____sys_sendmsg+0x620/0x990
>  ? kernel_sendmsg+0x30/0x30
>  ? __copy_msghdr+0x410/0x410
>  ? __kasan_check_read+0x11/0x20
>  ? mark_lock+0xe6/0x1470
>  ___sys_sendmsg+0xe9/0x170
>  ? copy_msghdr_from_user+0x120/0x120
>  ? __lock_acquire+0xc62/0x1de0
>  ? do_fault_around+0x2c6/0x4e0
>  ? do_user_addr_fault+0x8c1/0xde0
>  ? reacquire_held_locks+0x220/0x4d0
>  ? do_user_addr_fault+0x8c1/0xde0
>  ? __kasan_check_read+0x11/0x20
>  ? __fdget+0x4e/0x1d0
>  ? sockfd_lookup_light+0x1a/0x170
>  __sys_sendmsg+0xd2/0x180
>  ? __sys_sendmsg_sock+0x20/0x20
>  ? reacquire_held_locks+0x4d0/0x4d0
>  ? debug_smp_processor_id+0x17/0x20
>  __x64_sys_sendmsg+0x72/0xb0
>  ? lockdep_hardirqs_on+0x7d/0x100
>  x64_sys_call+0x894/0x9f0
>  do_syscall_64+0x64/0x130
>  entry_SYSCALL_64_after_hwframe+0x4b/0x53
> RIP: 0033:0x7f230fe04807
> Code: 64 89 02 48 c7 c0 ff ff ff ff eb bb 0f 1f 80 00 00 00 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 2e 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 89 54 24 1c 48 89 74 24 10
> RSP: 002b:00007ffe996a7ea8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
> RAX: ffffffffffffffda RBX: 0000556f9f9c3390 RCX: 00007f230fe04807
> RDX: 0000000000000000 RSI: 00007ffe996a7ee0 RDI: 0000000000000003
> RBP: 0000556f9f9c88c0 R08: 0000000000000002 R09: 0000000000000000
> R10: 0000556f965ca190 R11: 0000000000000246 R12: 0000556f9f9c8780
> R13: 00007ffe996a7ee0 R14: 0000556f9f9c87d0 R15: 0000556f9f9c88c0
>  </TASK>
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Note that current checkpatch.pl says:
WARNING:MISSING_FIXES_TAG: The commit message has 'Call Trace:', perhaps it
also needs a 'Fixes:' tag?

Is this worthy?
Or since firmware still crashes do we not consider this issue fixed?


