Return-Path: <linux-wireless+bounces-6158-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2C28A0E7D
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Apr 2024 12:15:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25F341F21FAD
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Apr 2024 10:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B72145B28;
	Thu, 11 Apr 2024 10:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Do6Whg3A"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533CB145353
	for <linux-wireless@vger.kernel.org>; Thu, 11 Apr 2024 10:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712830511; cv=none; b=qxiRlbXDGBF9pcqerClcogKAfhSG23RpRYotQan/tFw0auJYwI145hAKoxzk1nD/1UC+/QP2aCrs5/rnBp/qgnTVldRmXoHMu6ASQciIwgJz2wcc/36nnrdpRzk6g0hwEbOdvZ0Y9uId2I4i+pZeSGvmAcTPDDL+fy8wrb0HwYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712830511; c=relaxed/simple;
	bh=qLa45aNenh/RURJ7gv5WF3Ba9t2WSQz/H2ueIwm9WaY=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:References:
	 In-Reply-To:Content-Type; b=VzY8U0jxQFBDbS/PDBNtXBok0A/YOyrmt4lv24vZEXqZ8qNjmLutXwdFl/Fu71q3VvQ7sx6w2uJRV6YRL9YSksN6IaKFL+eplnxvyeLp2dYMS6mQ2kFt87uYa2CdvFr33e+7+BhWfMSCLasOnMFdGNMFWddnBWPHGBxolY+YN2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Do6Whg3A; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43B5il4E026165;
	Thu, 11 Apr 2024 10:15:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:from:to:subject:references
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=krRxp5a4nb593Kolxs2m+buvGiiteRzXVicNhXTPIh0=; b=Do
	6Whg3AuSyvgo1S5zReqqyoB7+FGsomV0umZbSlOXx2yipRbsJ2vPd4QHAAsdeLWX
	90R/LDOCYGmrV7zyzBHRp22k6qiwXaRkLXD/gx9UZd7gpCX95k6oOyP9H5wbroEW
	r5k5C8OmpbAvapd1PUTw6UK4hfX6VAZaGU/tIQXJ7Hw3Xvd/6CyyyB+mRmJymog3
	A6AEiIW68rfx/B9mKWWss06N3m4nPCxcO0y4S3THywf78ubCvwKPqcTQ6xGAWlr1
	oo5nobPkx1Vqab23JhXQ49W75snxcOyR3AX6fN/Epb8QW7NJhdZFBuTGSkKuvZkb
	K+MrkpDRNpE+qvX4L1PA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xe8dthnrm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Apr 2024 10:15:01 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43BAF0NO018234
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Apr 2024 10:15:00 GMT
Received: from [10.110.18.37] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 11 Apr
 2024 03:14:59 -0700
Message-ID: <2034a4fd-cd5e-45f6-bfeb-21832525ce14@quicinc.com>
Date: Thu, 11 Apr 2024 18:14:57 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: <quic_kangyang@quicinc.com>
To: Kalle Valo <kvalo@kernel.org>, <ath12k@lists.infradead.org>,
        <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] wifi: ath12k: add support to handle beacon miss for
 WCN7850
References: <20240319023032.719-1-quic_kangyang@quicinc.com>
 <8734rsz0gk.fsf@kernel.org>
In-Reply-To: <8734rsz0gk.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: K1ej-TBxARdBvpDgUb4dNHyzCntoqEwr
X-Proofpoint-ORIG-GUID: K1ej-TBxARdBvpDgUb4dNHyzCntoqEwr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-11_04,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 mlxlogscore=999
 spamscore=0 mlxscore=0 malwarescore=0 suspectscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404110074



On 4/11/24 5:56 PM, Kalle Valo <kvalo@kernel.org> wrote:
> kangyang <quic_kangyang@quicinc.com> writes:
> 
> > From: Kang Yang <quic_kangyang@quicinc.com>
> >
> > When AP goes down or too far away without indication to STA, beacon miss
> > will be detected. Then for WCN7850's firmware, it will use roam event
> > to send beacon miss to host.
> >
> > If STA doesn't handle the beacon miss, will keep the fake connection
> > and unable to roam.
> >
> > So add support for WCN7850 to trigger disconnection from AP when
> > receiving this event from firmware.
> >
> > It has to be noted that beacon miss event notification for QCN9274
> > to be handled in a separate patch as it uses STA kickout WMI event
> > to notify beacon miss and the current STA kickout event is processed
> > as low_ack.
> >
> > Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> >
> > Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
> 
> There were conflicts but I fixed in the pending branch, though I admit I
> did that hastily:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=e5b7eced753bc7e5af133624f6ff37141c5b3442
> 
> But now I see warnings like below, I don't if it's caused my conflict
> fixes or was there originally.


Maybe i need to rebase on latest tag...Code changes a lot.


> 
> [ 2248.795411] ------------[ cut here ]------------
> [ 2248.796912] WARNING: CPU: 0 PID: 7431 at kernel/workqueue.c:4201 __flush_work+0x15b/0x170
> [ 2248.797566] Modules linked in: ath12k mac80211 libarc4 cfg80211 qmi_helpers qrtr_mhi mhi qrtr nvme nvme_core [last unloaded: mhi]
> [ 2248.798430] CPU: 0 PID: 7431 Comm: wpa_supplicant Tainted: G        W          6.9.0-rc2-wt-ath+ #1383
> [ 2248.799332] Hardware name: Intel(R) Client Systems NUC8i7HVK/NUC8i7HVB, BIOS HNKBLi70.86A.0067.2021.0528.1339 05/28/2021
> [ 2248.800150] RIP: 0010:__flush_work+0x15b/0x170
> [ 2248.800882] Code: 00 00 00 48 8b 55 d0 65 48 2b 14 25 28 00 00 00 75 28 48 81 c4 48 01 00 00 5b 41 5c 41 5d 41 5e 41 5f 5d c3 0f 0b 31 c0 eb b7 <0f> 0b 31 c0 eb b1 e8 3a c4 60 00 e9 55 ff ff ff e8 70 b3 bf 02 55
> [ 2248.802403] RSP: 0018:ffffc900020e70a0 EFLAGS: 00010246
> [ 2248.803186] RAX: dffffc0000000000 RBX: 1ffff9200041ce15 RCX: ffffffffa24c3106
> [ 2248.803986] RDX: 1ffff11024ee5c54 RSI: 0000000000000001 RDI: ffff88812772e2a0
> [ 2248.804788] RBP: ffffc900020e7210 R08: 0000000000000001 R09: fffffbfff6e6fa48
> [ 2248.805575] R10: ffffffffb737d247 R11: 0000000000000006 R12: ffff88812772e288
> [ 2248.806371] R13: 0000000000000001 R14: ffffc900020e71e8 R15: 0000000000000001
> [ 2248.807168] FS:  00007fd218478140(0000) GS:ffff88821ba00000(0000) knlGS:0000000000000000
> [ 2248.807979] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 2248.808780] CR2: 000055cb2ce7aa88 CR3: 000000013a101005 CR4: 00000000003706f0
> [ 2248.809579] Call Trace:
> [ 2248.810422]  <TASK>
> [ 2248.811311]  ? show_regs+0x5b/0x70
> [ 2248.812173]  ? __warn+0xc7/0x300
> [ 2248.813027]  ? reacquire_held_locks+0x4d0/0x4d0
> [ 2248.813897]  ? __flush_work+0x15b/0x170
> [ 2248.814794]  ? report_bug+0x310/0x3f0
> [ 2248.815690]  ? handle_bug+0x71/0x90
> [ 2248.816503]  ? exc_invalid_op+0x18/0x40
> [ 2248.817338]  ? asm_exc_invalid_op+0x1b/0x20
> [ 2248.818200]  ? mark_lock+0xe6/0x1470
> [ 2248.819064]  ? __flush_work+0x15b/0x170
> [ 2248.820032]  ? start_flush_work+0x9c0/0x9c0
> [ 2248.820870]  ? __kasan_check_read+0x11/0x20
> [ 2248.821717]  ? mark_lock+0xe6/0x1470
> [ 2248.822516]  ? mark_lock_irq+0x1cc0/0x1cc0
> [ 2248.823352]  ? detach_if_pending+0x370/0x370
> [ 2248.824170]  ? debug_smp_processor_id+0x17/0x20
> [ 2248.825052]  ? __cancel_work_sync+0x32f/0x480
> [ 2248.825942]  ? __this_cpu_preempt_check+0x13/0x20
> [ 2248.826805]  __cancel_work_sync+0x325/0x480
> [ 2248.827606]  ? flush_rcu_work+0x70/0x70
> [ 2248.828457]  cancel_delayed_work_sync+0xe/0x10
> [ 2248.829294]  ath12k_mac_assign_vif_to_vdev.isra.0+0x318/0xb00 [ath12k]
> [ 2248.830171]  ath12k_mac_op_add_interface+0x2d6/0x410 [ath12k]
> [ 2248.831079]  drv_add_interface+0x141/0x710 [mac80211]
> [ 2248.832043]  ieee80211_do_open+0xf20/0x1720 [mac80211]
> [ 2248.833009]  ? __this_cpu_preempt_check+0x13/0x20
> [ 2248.833931]  ieee80211_start_p2p_device+0x67/0xf0 [mac80211]
> [ 2248.834924]  nl80211_start_p2p_device+0x226/0x4c0 [cfg80211]
> [ 2248.835889]  genl_family_rcv_msg_doit+0x1f0/0x2e0
> [ 2248.836789]  ? genl_family_rcv_msg_attrs_parse.isra.0+0x250/0x250
> [ 2248.837603]  ? ns_capable+0x57/0xd0
> [ 2248.838432]  genl_family_rcv_msg+0x34c/0x600
> [ 2248.839303]  ? genl_family_rcv_msg_dumpit+0x310/0x310
> [ 2248.840117]  ? __lock_acquire+0xd43/0x1dd0
> [ 2248.840974]  ? he_set_mcs_mask.isra.0+0x8d0/0x8d0 [cfg80211]
> [ 2248.841888]  ? nl80211_associate+0x2720/0x2720 [cfg80211]
> [ 2248.842832]  ? cfg80211_external_auth_request+0x690/0x690 [cfg80211]
> [ 2248.843747]  genl_rcv_msg+0xa0/0x130
> [ 2248.844537]  netlink_rcv_skb+0x14c/0x400
> [ 2248.845355]  ? genl_family_rcv_msg+0x600/0x600
> [ 2248.846153]  ? netlink_ack+0xd70/0xd70
> [ 2248.846954]  ? rwsem_optimistic_spin+0x4f0/0x4f0
> [ 2248.847796]  ? genl_rcv+0x14/0x40
> [ 2248.848546]  ? rwsem_down_read_slowpath+0xb10/0xb10
> [ 2248.849348]  ? netlink_deliver_tap+0x143/0x350
> [ 2248.850171]  ? __this_cpu_preempt_check+0x13/0x20
> [ 2248.851022]  genl_rcv+0x23/0x40
> [ 2248.851812]  netlink_unicast+0x45c/0x790
> [ 2248.852514]  ? netlink_attachskb+0x7f0/0x7f0
> [ 2248.853270]  netlink_sendmsg+0x7eb/0xdb0
> [ 2248.854030]  ? netlink_unicast+0x790/0x790
> [ 2248.854739]  ? __this_cpu_preempt_check+0x13/0x20
> [ 2248.855429]  ? selinux_socket_sendmsg+0x31/0x40
> [ 2248.856131]  ? netlink_unicast+0x790/0x790
> [ 2248.856851]  __sock_sendmsg+0xc9/0x160
> [ 2248.857469]  ____sys_sendmsg+0x620/0x9a0
> [ 2248.858150]  ? kernel_sendmsg+0x30/0x30
> [ 2248.858858]  ? __copy_msghdr+0x410/0x410
> [ 2248.859468]  ? reacquire_held_locks+0x4d0/0x4d0
> [ 2248.860137]  ? lock_sync+0x1a0/0x1a0
> [ 2248.860790]  ___sys_sendmsg+0xe9/0x170
> [ 2248.861393]  ? copy_msghdr_from_user+0x120/0x120
> [ 2248.862049]  ? __might_fault+0xc0/0x170
> [ 2248.862694]  ? __kasan_check_write+0x14/0x20
> [ 2248.863306]  ? _copy_from_user+0x5b/0xa0
> [ 2248.863969]  ? copy_from_sockptr_offset.constprop.0+0xe7/0x110
> [ 2248.864600]  ? vfs_getattr+0x50/0x50
> [ 2248.865237]  ? netlink_seq_show+0x330/0x330
> [ 2248.865884]  ? __kasan_check_write+0x14/0x20
> [ 2248.866481]  ? __kasan_check_read+0x11/0x20
> [ 2248.867139]  ? __fget_light+0x53/0x1e0
> [ 2248.867820]  ? __fdget+0xe/0x10
> [ 2248.868412]  ? sockfd_lookup_light+0x1a/0x170
> [ 2248.869100]  __sys_sendmsg+0xd2/0x180
> [ 2248.869770]  ? __sys_sendmsg_sock+0x20/0x20
> [ 2248.870352]  ? __sys_setsockopt+0xf4/0x1b0
> [ 2248.871016]  ? debug_smp_processor_id+0x17/0x20
> [ 2248.871667]  __x64_sys_sendmsg+0x72/0xb0
> [ 2248.872264]  do_syscall_64+0x65/0x130
> [ 2248.872920]  entry_SYSCALL_64_after_hwframe+0x46/0x4e
> [ 2248.873553] RIP: 0033:0x7fd218804807
> [ 2248.874202] Code: 64 89 02 48 c7 c0 ff ff ff ff eb bb 0f 1f 80 00 00 00 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 2e 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 89 54 24 1c 48 89 74 24 10
> [ 2248.875567] RSP: 002b:00007ffd1e970b98 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
> [ 2248.876277] RAX: ffffffffffffffda RBX: 000055cb2ce3dac0 RCX: 00007fd218804807
> [ 2248.877048] RDX: 0000000000000000 RSI: 00007ffd1e970bd0 RDI: 0000000000000006
> [ 2248.877802] RBP: 000055cb2ce3d9d0 R08: 0000000000000004 R09: 00007fd2188d0b80
> [ 2248.878494] R10: 00007ffd1e970ca4 R11: 0000000000000246 R12: 000055cb2ce6d480
> [ 2248.879230] R13: 00007ffd1e970bd0 R14: 00007ffd1e970ca4 R15: 000055cb2ce6d340
> [ 2248.880017]  </TASK>
> [ 2248.880643] irq event stamp: 90483
> [ 2248.881359] hardirqs last  enabled at (90495): [<ffffffffa24f114e>] console_unlock+0x1ae/0x280
> [ 2248.882102] hardirqs last disabled at (90516): [<ffffffffa24f1133>] console_unlock+0x193/0x280
> [ 2248.882899] softirqs last  enabled at (90512): [<ffffffffa4feac7a>] __do_softirq+0x58a/0x8e5
> [ 2248.883608] softirqs last disabled at (90503): [<ffffffffa236f03a>] irq_exit_rcu+0xaa/0x110
> [ 2248.884340] ---[ end trace 0000000000000000 ]---
> 
> 

