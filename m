Return-Path: <linux-wireless+bounces-24232-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CFE6EADE0F1
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Jun 2025 04:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24593189B3D2
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Jun 2025 02:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD77718DB1E;
	Wed, 18 Jun 2025 02:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JU6G86zy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB01137C2A;
	Wed, 18 Jun 2025 02:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750212069; cv=none; b=nLFf4hKAcR3OHkhJh6NNBda94s0Z06EP6cW4xdQcV9m+vsMIW5S460RbOwBdcHNsFHZopjCW0jFS9GHLnSUQzbZjTDsXy/DEkQnFKZW+85znJRrO0pOznNTu8ORLTjtGvrzfWAKJMv7l4t2SRF736/NJcKLXp4jhE9ksD0ijCgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750212069; c=relaxed/simple;
	bh=OwPy/OoqnVRNYKBvU4Pfyo1MqLZNSn0EcILXTKaK7cc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=nwjtLB/i6i6OJQ7CBBSegzQvVP8XPEvVZwXf4Zx/VNdzIdT9JMlXAVOseHgNztXMfmNTJWYdb5q/uJcJ1l5R1rkMS1yS7r4KC4T6c80GXur060iqHSWS2Sjk0XgqkF4WntZHpWZVU7XRZxdwAjzjJs6PKJqCdlyIWlDOSoBvkBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=JU6G86zy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55I1Ng9c018584;
	Wed, 18 Jun 2025 02:00:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NoIfzySfzayg7dageLe7SS/NfqGs1xEQdrrmpgxJlGc=; b=JU6G86zyrkpRhB73
	hamK4hlTOWr9VJAvk051gusnbSNVaES9Tb9vYojGoggBcsS47XVpVBMJnnDD+xNs
	0joQ8Vwk133hBIvahM0WCVTzSP+8QJdw7GrBRcfaoayt4IAI4dzTeWiFc4WbeW5A
	78JrzDSb925L/GFInVu9arZT1M9yISEqMZgbc+ZXvkMc+x4IWUwOnS0+B06Iweql
	OBNzjQfZHYlEOArQdhVU+q40vgr+RAWI+y+EiKNDYZDuNRdFERITtpyLe729XRBe
	B0ey7j7vtl7mTXVay+OVZwWyvfQ+DzBnWm2HktBn0jX9DNFwK+SbkxPOlOhZqLt+
	jXxDBQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4791h9a99n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Jun 2025 02:00:52 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 55I20p6s004238
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Jun 2025 02:00:51 GMT
Received: from [10.231.195.67] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 17 Jun
 2025 19:00:48 -0700
Message-ID: <51da74b0-d8d3-4520-9fc9-06b50b552bb2@quicinc.com>
Date: Wed, 18 Jun 2025 10:00:46 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next v3 5/6] wifi: ath11k: choose default PM policy
 for hibernation
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Johannes Berg
	<johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <ath11k@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.de>,
        Bjorn Andersson
	<bjorn.andersson@oss.qualcomm.com>,
        Johan Hovold <johan+linaro@kernel.org>
References: <20250328-ath11k-bring-hibernation-back-v3-0-23405ae23431@quicinc.com>
 <20250328-ath11k-bring-hibernation-back-v3-5-23405ae23431@quicinc.com>
 <d0cd065c-1cd1-4e56-8c57-60777b1f3664@oss.qualcomm.com>
Content-Language: en-US
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <d0cd065c-1cd1-4e56-8c57-60777b1f3664@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: xzf5JmwkMzId5DtWpz2n4SVgcRfZl5dH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE4MDAxNiBTYWx0ZWRfX92a6De305xbW
 FI9gVEgnfr2g4vtByxz0J/HxTn2OOecfyUmMhD7ET03lgjtV8JzUyvslX+8nVaZQxZ/Y5bZITBa
 MN85ux8E/5dQFpnLxzxopGJZSLqI8BbNo1FCAnL2zhJaB2nYobrlB1L6MT2O59Vcpec0QXDU9pk
 Wabi0G01t0bVKIYyjTytJosuLRtGiaJdWOCklFjCIByag6iRWRxH90tXpfnVhA5yad6bWBEL/Sp
 +QTghNff+YVnVxv+9WpMxy6BzyOFx1DO7DOKQivpRSPI7J9Wb06/7S8InSDKijf0h8jFTM92A41
 Nj72Nc53qWGNSP0xB3sQiTZ1AVFrForevO29wbv1S14QXmKXtVli57DLacnTihLcjP3Tf32bcvB
 FJh3v/PrtI0wHoGH+r9zNndeo+5/yRLmJty1aru+apm7PjogQ+PGO/arzU3EgiiZwKFWjj7D
X-Authority-Analysis: v=2.4 cv=UL/dHDfy c=1 sm=1 tr=0 ts=68521dd4 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=COk6AnOGAAAA:8
 a=6qXf7fRQBKMGMJ8BGqEA:9 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: xzf5JmwkMzId5DtWpz2n4SVgcRfZl5dH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-18_01,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 clxscore=1015 suspectscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 phishscore=0 mlxlogscore=901
 malwarescore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506180016



On 6/18/2025 8:15 AM, Konrad Dybcio wrote:
> On 3/28/25 6:32 AM, Baochen Qiang wrote:
>> Now WoWLAN mode is chosen for those machines listed in the quirk table.
>> This works for suspend (S3) but breaks for hibernation (S4), because
>> WoWLAN mode requires WLAN power to be sustained, which is not the case
>> during hibernation. For hibernation, the default mode should be used.
>>
>> Register a PM notifier with which kernel can notify us of the actual PM
>> operation: if system is going to suspend, the original PM policy is
>> honored; while if it is hibernation, overwrite it with default policy.
>>
>> To summarize: for suspend (S3), WoWLAN mode is chosen for machines listed
>> in the quirk table, non-WoWLAN mode for others; for hibernation (S4),
>> non-WoWLAN mode is chosen for all.
>>
>> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30
>>
>> Tested-by: Takashi Iwai <tiwai@suse.de>
>> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
>> ---
> 
> I've bisected the following splat to this patch, still happening on
> linux-next/master, WCN6855 + SC8280XP CRD, 100% reproducibility 
> 
> [root@sc8280xp-crd ~]# echo mem > /sys/power/state 
> [   20.267830] fb0: Framebuffer is not in virtual address space.
> [   39.863070] PM: suspend entry (s2idle)
> [   39.908067] Filesystems sync: 0.035 seconds
> [   39.934453] ------------[ cut here ]------------
> [   39.939259] Invalid notifier called!
> [   39.939268] WARNING: CPU: 5 PID: 513 at kernel/notifier.c:79 notifier_call_chain+0x84/0x1a4
> [   39.951566] Modules linked in:
> [   39.954732] CPU: 5 UID: 0 PID: 513 Comm: bash Not tainted 6.14.0-rc4longbois-01215-g32d93b51bc7e #12177
> [   39.964396] Hardware name: Qualcomm QRD, BIOS 6.0.230525.BOOT.MXF.1.1.c1-00114-MAKENA-1 05/25/2023
> [   39.973609] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [   39.980777] pc : notifier_call_chain+0x84/0x1a4
> [   39.985457] lr : notifier_call_chain+0x80/0x1a4
> [   39.990135] sp : ffff800087e63b30
> [   39.993559] x29: ffff800087e63b40 x28: ffffb17be1150da0 x27: 0000000000000000
> [   40.000913] x26: 0000000000000000 x25: 0000000000000000 x24: ffffb17be1723000
> [   40.008261] x23: ffff529452a99ac0 x22: 0000000000000003 x21: 0000000000000000
> [   40.015607] x20: 00000000fffffffa x19: ffff800087e63ba4 x18: ffff800083e7d088
> [   40.022953] x17: 0000000000000000 x16: ffff529452a9a3d8 x15: ffffb17be1a81420
> [   40.030296] x14: ffffffffffffffff x13: 0000000000000003 x12: 00000000ffffefff
> [   40.037642] x11: 0000000000000001 x10: 0000000000000003 x9 : 88af25dfec9f7000
> [   40.044988] x8 : 88af25dfec9f7000 x7 : 0000000000000000 x6 : 0000000000000000
> [   40.052336] x5 : 0000000000000001 x4 : 0000000000000000 x3 : ffff800087e63818
> [   40.059680] x2 : ffff800087e63820 x1 : 00000000ffffefff x0 : 0000000000000018
> [   40.067033] Call trace:
> [   40.069573]  notifier_call_chain+0x84/0x1a4 (P)
> [   40.074250]  notifier_call_chain_robust+0x4c/0xa8
> [   40.079108]  blocking_notifier_call_chain_robust+0x54/0x88
> [   40.084761]  pm_notifier_call_chain_robust+0x2c/0x4c
> [   40.089881]  pm_suspend+0x1f4/0x628
> [   40.093495]  state_store+0x6c/0x9c
> [   40.097010]  kobj_attr_store+0x20/0x38
> [   40.100898]  sysfs_kf_write+0x58/0x78
> [   40.104686]  kernfs_fop_write_iter+0xe8/0x184
> [   40.109181]  vfs_write+0x2dc/0x308
> [   40.112699]  ksys_write+0x80/0xe8
> [   40.116135]  __arm64_sys_write+0x24/0x34
> [   40.120195]  invoke_syscall+0x48/0x100
> [   40.124071]  el0_svc_common+0xb4/0xe8
> [   40.127853]  do_el0_svc+0x24/0x34
> [   40.131286]  el0_svc+0x58/0xb4
> [   40.134450]  el0t_64_sync_handler+0x114/0x130
> [   40.138954]  el0t_64_sync+0x1a0/0x1a4
> [   40.142747] irq event stamp: 17062
> [   40.146269] hardirqs last  enabled at (17061): [<ffffb17bdd587204>] __console_unlock+0x5c/0x8c
> [   40.155129] hardirqs last disabled at (17062): [<ffffb17bdeb6bd24>] el1_dbg+0x2c/0x80
> [   40.163186] softirqs last  enabled at (15294): [<ffffb17bdd500a98>] handle_softirqs+0x38c/0x3dc
> [   40.172137] softirqs last disabled at (15289): [<ffffb17bdd480204>] __do_softirq+0x1c/0x2c
> [   40.180644] ---[ end trace 0000000000000000 ]---
> [   40.186333] Freezing user space processes
> [   40.192527] Freezing user space processes completed (elapsed 0.002 seconds)
> [   40.199721] OOM killer disabled.
> [   40.203083] Freezing remaining freezable tasks
> [   40.209029] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)

Could you share complete kernel dmesg log?

> 
> Konrad


