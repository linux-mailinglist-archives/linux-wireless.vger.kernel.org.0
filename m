Return-Path: <linux-wireless+bounces-3273-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0116A84C527
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Feb 2024 07:50:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A52A9283995
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Feb 2024 06:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD5F21CD2B;
	Wed,  7 Feb 2024 06:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hgaU+gxe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D5B1CD2C
	for <linux-wireless@vger.kernel.org>; Wed,  7 Feb 2024 06:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707288654; cv=none; b=bJ7pJNWTG3udaqgpsWKDPoUyPaz2iU9NyH2nj6CAO+1e0x48TBLljzgO7fC24uHDW+q2i+DnFaPtoGv0NmT3YiMfrMLmZJQMSEsxWDXDQy+pxOFdMM7XvIZ3ahNSIG0AMeKHfJvLstvf72EtFSC1jSTGppupRc0h/zKQlNEuwOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707288654; c=relaxed/simple;
	bh=syIdTO4skBBNLTXf5ZprJaVPDVY07OT4J7aiEbuwAAY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=DQ2eDpS3gJqXb/e2yS91YGuwVv1BDfSUDIwJx9+N7ajWU/JV+Xy8QQuO1KNOi01huL/cW/uduNwzlqfhILz2pPXbSapPk9iMw9n1cJi2UR6+N2kBclKSJAUnyleUEQ+MLiz1NwjDHtSk4Us0ZpR5otCZduoZiwiFRB4BykGGl8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hgaU+gxe; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4175oHEr010213;
	Wed, 7 Feb 2024 06:50:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=h62OCVjWYJwhPaIZAEXjzrnaoG23A+xfzYHtHhnO3kU=; b=hg
	aU+gxeL/XIf5k0WcpQNSAYao+JCugUTsKklG+8vkEQ7XDlPHs0VTCA6nYOOc914R
	hCbDzlmENDKW3uvBPnrROEQy0P52//IhnDvzjUnRJHtZr+j+OFN66gHM9sVRXvvF
	C5/Ix/CHjRya46EVhFS7BPN18qp35RWwq03ffL+PY8AU8PvT9p3Ph0fhBhO+iRxJ
	XZi7QvIc/jKWkg5GyXJlZMlTk6vyg9a8P8yNj9dMIsSwGp8+x8gCVECg7lCOcrL2
	6si777xDIbjy62vvOoTJBgtEzfoqIL0mZABZaj6OifVLdA+UYCE3fn0Vlx+Vpj//
	GPD7nHBi9M0CFx3sV8nQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w4425r3f3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Feb 2024 06:50:45 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4176oi94015649
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 7 Feb 2024 06:50:44 GMT
Received: from [10.253.13.207] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 6 Feb
 2024 22:50:43 -0800
Message-ID: <4e7c6f81-ed22-4384-a4b2-afae9e13e60e@quicinc.com>
Date: Wed, 7 Feb 2024 14:50:40 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/11] wifi: ath12k: P2P support for WCN7850
Content-Language: en-US
To: Kalle Valo <kvalo@kernel.org>
CC: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20240130040303.370590-1-quic_kangyang@quicinc.com>
 <87o7cusyvw.fsf@kernel.org>
From: Kang Yang <quic_kangyang@quicinc.com>
In-Reply-To: <87o7cusyvw.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: DWV-gTLwZlc4nSf8eUxTj7GqhOMMR7mv
X-Proofpoint-GUID: DWV-gTLwZlc4nSf8eUxTj7GqhOMMR7mv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-06_16,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 spamscore=0 malwarescore=0 phishscore=0 mlxscore=0
 priorityscore=1501 mlxlogscore=664 clxscore=1015 lowpriorityscore=0
 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402070049



On 2/5/2024 11:40 PM, Kalle Valo wrote:
> Kang Yang <quic_kangyang@quicinc.com> writes:
> 
>> Add P2P support for WCN7850.
>>
>> Kang Yang (11):
>>    wifi: ath12k: fix broken structure wmi_vdev_create_cmd
>>    wifi: ath12k: fix incorrect logic of calculating vdev_stats_id
>>    wifi: ath12k: change interface combination for P2P mode
>>    wifi: ath12k: add P2P IE in beacon template
>>    wifi: ath12k: implement handling of P2P NoA event
>>    wifi: ath12k: implement remain on channel for P2P mode
>>    wifi: ath12k: change WLAN_SCAN_PARAMS_MAX_IE_LEN from 256 to 512
>>    wifi: ath12k: allow specific mgmt frame tx while vdev is not up
>>    wifi: ath12k: move peer delete after vdev stop of station for WCN7850
>>    wifi: ath12k: designating channel frequency for ROC scan
>>    wifi: ath12k: advertise P2P dev support for WCN7850
> 
> I did some quick tests by running various p2p commands with wpa_cli and
> noticed the warning below. We might have some issues with our RCU usage,
> please check. But no need to resend because of this, followup patch
> fixing this is fine.
> 
> [ 1108.916980] =============================
> [ 1108.917068] WARNING: suspicious RCU usage
> [ 1108.917151] 6.8.0-rc2-wt-ath+ #1273 Not tainted
> [ 1108.917235] -----------------------------
> [ 1108.917318] drivers/net/wireless/ath/ath12k/mac.c:583 suspicious rcu_dereference_check() usage!
> [ 1108.917400] #012[ 1108.917400] other info that might help us debug this:#012[ 1108.917400]
> [ 1108.917484] #012[ 1108.917484] rcu_scheduler_active = 2, debug_locks = 1
> [ 1108.917566] no locks held by swapper/3/0.


I conducted a simple test, but cannot reproduce.

It seems i need to use rcu_read_lock() and rcu_read_unlock() for 
rcu_dereference().

Will fix it in a separate patch.


> [ 1108.917649] #012[ 1108.917649] stack backtrace:
> [ 1108.917729] CPU: 3 PID: 0 Comm: swapper/3 Not tainted 6.8.0-rc2-wt-ath+ #1273
> [ 1108.917810] Hardware name: Intel(R) Client Systems NUC8i7HVK/NUC8i7HVB, BIOS HNKBLi70.86A.0067.2021.0528.1339 05/28/2021
> [ 1108.917892] Call Trace:
> [ 1108.917968]  <IRQ>
> [ 1108.918046]  dump_stack_lvl+0x82/0xc0
> [ 1108.918132]  dump_stack+0x10/0x20
> [ 1108.918206]  lockdep_rcu_suspicious+0x210/0x3a0
> [ 1108.918285]  ath12k_mac_get_ar_by_vdev_id+0x18e/0x210 [ath12k]
> [ 1108.918403]  ath12k_wmi_op_rx+0x2bb/0x1a30 [ath12k]
> [ 1108.918511]  ? ath12k_chan_info_event+0x970/0x970 [ath12k]
> [ 1108.918624]  ? __lock_acquire+0xd45/0x1de0
> [ 1108.918706]  ? __kasan_check_read+0x11/0x20
> [ 1108.918789]  ? debug_smp_processor_id+0x17/0x20
> [ 1108.918863]  ? __lock_release.isra.0+0x49d/0xae0
> [ 1108.918934]  ? debug_smp_processor_id+0x17/0x20
> [ 1108.919007]  ? reacquire_held_locks+0x4d0/0x4d0
> [ 1108.919080]  ? ath12k_ce_recv_process_cb+0x4b3/0x960 [ath12k]
> [ 1108.919195]  ath12k_htc_rx_completion_handler+0x361/0x650 [ath12k]
> [ 1108.919302]  ? ath12k_ce_recv_process_cb+0x4b3/0x960 [ath12k]
> [ 1108.919409]  ? trace_hardirqs_on+0x49/0x50
> [ 1108.919485]  ath12k_ce_recv_process_cb+0x5c6/0x960 [ath12k]
> [ 1108.919591]  ? ath12k_ce_rx_post_pipe+0x990/0x990 [ath12k]
> [ 1108.919658]  ? __wake_up_bit+0x120/0x120
> [ 1108.919705]  ? handle_irq_event+0x10e/0x1c0
> [ 1108.919752]  ath12k_ce_per_engine_service+0xda/0x110 [ath12k]
> [ 1108.919817]  ath12k_pci_ce_tasklet+0x65/0x120 [ath12k]
> [ 1108.919879]  ? trace_tasklet_entry+0xe4/0x110
> [ 1108.919945]  tasklet_action_common.isra.0+0x24c/0x3d0
> [ 1108.920007]  tasklet_action+0x4f/0x70
> [ 1108.920068]  __do_softirq+0x1c2/0x868
> [ 1108.920116]  irq_exit_rcu+0xab/0x110
> [ 1108.920159]  common_interrupt+0xad/0xd0
> [ 1108.920201]  </IRQ>
> [ 1108.920309]  <TASK>
> [ 1108.920355]  asm_common_interrupt+0x27/0x40
> [ 1108.920399] RIP: 0010:cpuidle_enter_state+0xdc/0x580
> [ 1108.920448] Code: ff ff ff ff 49 89 c7 e8 e2 fa 55 ff 31 ff e8 cb 29 54 fd 80 7d d0 00 0f 85 4a 02 00 00 e8 0c f9 55 ff 84 c0 0f 84 32 02 00 00 <45> 85 f6 0f 88 95 01 00 00 49 63 d6 48 83 fa 0a 0f 83 dd 02 00 00
> [ 1108.920496] RSP: 0018:ffffc900001afd20 EFLAGS: 00000202
> [ 1108.920545] RAX: 000000000065289d RBX: ffff888116413400 RCX: 1ffffffff47726c1
> [ 1108.920593] RDX: 0000000000000000 RSI: ffffffffa2278020 RDI: ffffffffa24176e0
> [ 1108.920639] RBP: ffffc900001afd70 R08: 0000000000000001 R09: fffffbfff4772c1a
> [ 1108.920686] R10: ffffffffa3b960d7 R11: 0000000000000000 R12: ffffffffa34c1740
> [ 1108.920733] R13: 0000000000000002 R14: 0000000000000002 R15: 000001023093b5a2
> [ 1108.920793]  cpuidle_enter+0x4a/0xa0
> [ 1108.920840]  call_cpuidle+0x42/0xb0
> [ 1108.920882]  ? tick_nohz_idle_retain_tick+0x70/0xa0
> [ 1108.920946]  cpuidle_idle_call+0x1c9/0x290
> [ 1108.921002]  ? arch_cpu_idle_exit+0x30/0x30
> [ 1108.921045]  ? debug_smp_processor_id+0x17/0x20
> [ 1108.921092]  do_idle+0xfb/0x160
> [ 1108.921137]  cpu_startup_entry+0x54/0x60
> [ 1108.921182]  start_secondary+0x201/0x290
> [ 1108.921227]  ? set_cpu_sibling_map+0x1f20/0x1f20
> [ 1108.921273]  secondary_startup_64_no_verify+0x15e/0x16b
> [ 1108.921324]  </TASK>
> 
> 

