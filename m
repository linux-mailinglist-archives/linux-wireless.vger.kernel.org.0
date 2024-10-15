Return-Path: <linux-wireless+bounces-13961-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DDBA099E6A4
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Oct 2024 13:43:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CF27B250A8
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Oct 2024 11:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E8E1E7640;
	Tue, 15 Oct 2024 11:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="n77y2Z+3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94C713F435;
	Tue, 15 Oct 2024 11:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728992617; cv=none; b=EXhmvYFGtl63RykQ5KXOl8cs1Q2gFOOFOarQYsdmzFMMdY8RCz6gnaxYyHLTNFsqP3vLyLUbFLr8mYrMy3abhNTv2HZ9UD3q0PWrj2ZE+L++c9cE3laLh3J/SYC2TKf2Z/u8xffxMYbb04cVIkTl7442zXBeqz38L+Jnh44ki1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728992617; c=relaxed/simple;
	bh=2HmICCLCX3mADMwtvcezMFAeR5AwJkkpLEQnrQgPRjU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cWS72a79Wxc8/UmN34ngmSzFnHkcnrV8gYPWXnw6Mu3if5TRu7PxMMCsLiiJNpeGxpwHEuj4E+OUslW+Obgemed7bXVaMDcJOYTqXdVMEnhCryJPTRtwrX6umadJsOuAcn+j4Bv4e33L0gjuFE5cPOmQ+MPW94yXeASZDzD4INA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=n77y2Z+3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49FBHmUO017497;
	Tue, 15 Oct 2024 11:43:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YmKSQ9uWLMBFI7m4PgxWNne7zrzM3O3nUgh/qGXvZWs=; b=n77y2Z+39q+RlDF8
	42GzNttue+xdSUa5n+LXXQH8+WAjGfgeCGWUE3kw2ZqncCwreZyCr9M+W3Ts+o/p
	ZdNIueHFAPsfhMBrCTLJOSS+9wlXqMeo1QUvllUuWEpJ2pXyUXOPRzO9iKz4muEP
	jYCMi/bdh6dtA2ilAbfenOK2tE13M219S5fJAFljg5HRUnKAkPfYZ14A2ds+xTYb
	UNKEtZqF6tT1VKVRRAA7o1b07Sfz7Ri2zVsudNlcwZU/O/CAjjcbeOcTlNOjHLAL
	ZbnfqC4qp/huennCP/2GQ3cjQpB5uefvEE1iZyYpdOJQMx+HFp3w3e0FnTYBSzow
	zjnQ6w==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 429e5g1e87-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 11:43:26 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49FBhPD8027305
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 11:43:25 GMT
Received: from [10.50.25.21] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 15 Oct
 2024 04:43:23 -0700
Message-ID: <918f03b4-cce5-44cb-9991-bfe20f04c498@quicinc.com>
Date: Tue, 15 Oct 2024 17:13:20 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: ath11k: Fix invalid ring usage in full monitor
 mode
To: Remi Pommarel <repk@triplefau.lt>, <ath11k@lists.infradead.org>,
        <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>
References: <20240924194119.15942-1-repk@triplefau.lt>
Content-Language: en-US
From: Praneesh P <quic_ppranees@quicinc.com>
In-Reply-To: <20240924194119.15942-1-repk@triplefau.lt>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: amkoE_laSqC-HBgmFSIyWTtZgfIpgT5g
X-Proofpoint-ORIG-GUID: amkoE_laSqC-HBgmFSIyWTtZgfIpgT5g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 malwarescore=0
 adultscore=0 impostorscore=0 mlxscore=0 priorityscore=1501 suspectscore=0
 bulkscore=0 phishscore=0 spamscore=0 mlxlogscore=918 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410150080



On 9/25/2024 1:11 AM, Remi Pommarel wrote:
> On full monitor HW the monitor destination rxdma ring does not have the
> same descriptor format as in the "classical" mode. The full monitor
> destination entries are of hal_sw_monitor_ring type and fetched using
> ath11k_dp_full_mon_process_rx while the classical ones are of type
> hal_reo_entrance_ring and fetched with ath11k_dp_rx_mon_dest_process.
> 
> Although both hal_sw_monitor_ring and hal_reo_entrance_ring are of same
> size, the offset to useful info (such as sw_cookie, paddr, etc) are
> different. Thus if ath11k_dp_rx_mon_dest_process gets called on full
> monitor destination ring, invalid skb buffer id will be fetched from DMA
> ring causing issues such as the following rcu_sched stall:
> 
>   rcu: INFO: rcu_sched self-detected stall on CPU
>   rcu:     0-....: (1 GPs behind) idle=c67/0/0x7 softirq=45768/45769 fqs=1012
>    (t=2100 jiffies g=14817 q=8703)
>   Task dump for CPU 0:
>   task:swapper/0       state:R  running task     stack: 0 pid:    0 ppid:     0 flags:0x0000000a
>   Call trace:
>    dump_backtrace+0x0/0x160
>    show_stack+0x14/0x20
>    sched_show_task+0x158/0x184
>    dump_cpu_task+0x40/0x4c
>    rcu_dump_cpu_stacks+0xec/0x12c
>    rcu_sched_clock_irq+0x6c8/0x8a0
>    update_process_times+0x88/0xd0
>    tick_sched_timer+0x74/0x1e0
>    __hrtimer_run_queues+0x150/0x204
>    hrtimer_interrupt+0xe4/0x240
>    arch_timer_handler_phys+0x30/0x40
>    handle_percpu_devid_irq+0x80/0x130
>    handle_domain_irq+0x5c/0x90
>    gic_handle_irq+0x8c/0xb4
>    do_interrupt_handler+0x30/0x54
>    el1_interrupt+0x2c/0x4c
>    el1h_64_irq_handler+0x14/0x1c
>    el1h_64_irq+0x74/0x78
>    do_raw_spin_lock+0x60/0x100
>    _raw_spin_lock_bh+0x1c/0x2c
>    ath11k_dp_rx_mon_mpdu_pop.constprop.0+0x174/0x650
>    ath11k_dp_rx_process_mon_status+0x8b4/0xa80
>    ath11k_dp_rx_process_mon_rings+0x244/0x510
>    ath11k_dp_service_srng+0x190/0x300
>    ath11k_pcic_ext_grp_napi_poll+0x30/0xc0
>    __napi_poll+0x34/0x174
>    net_rx_action+0xf8/0x2a0
>    _stext+0x12c/0x2ac
>    irq_exit+0x94/0xc0
>    handle_domain_irq+0x60/0x90
>    gic_handle_irq+0x8c/0xb4
>    call_on_irq_stack+0x28/0x44
>    do_interrupt_handler+0x4c/0x54
>    el1_interrupt+0x2c/0x4c
>    el1h_64_irq_handler+0x14/0x1c
>    el1h_64_irq+0x74/0x78
>    arch_cpu_idle+0x14/0x20
>    do_idle+0xf0/0x130
>    cpu_startup_entry+0x24/0x50
>    rest_init+0xf8/0x104
>    arch_call_rest_init+0xc/0x14
>    start_kernel+0x56c/0x58c
>    __primary_switched+0xa0/0xa8
> 
> Thus ath11k_dp_rx_mon_dest_process(), which use classical destination
> entry format, should no be called on full monitor capable HW.
>
Thanks, it looks good to me.
Reviewed-by: Praneesh P <quic_ppranees@quicinc.com>
> Fixes: 67a9d399fcb0 ("ath11k: enable RX PPDU stats in monitor co-exist mode")
> Signed-off-by: Remi Pommarel <repk@triplefau.lt>
> ---
> v2: set ppdu_status to DP_PPDU_STATUS_DONE as suggested by
>      https://lore.kernel.org/ath11k/d376023d-267a-4512-8749-f816fefeb842@quicinc.com/
> 
>   drivers/net/wireless/ath/ath11k/dp_rx.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
> index c087d8a0f5b2..40088e62572e 100644
> --- a/drivers/net/wireless/ath/ath11k/dp_rx.c
> +++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
> @@ -5291,8 +5291,11 @@ int ath11k_dp_rx_process_mon_status(struct ath11k_base *ab, int mac_id,
>   		    hal_status == HAL_TLV_STATUS_PPDU_DONE) {
>   			rx_mon_stats->status_ppdu_done++;
>   			pmon->mon_ppdu_status = DP_PPDU_STATUS_DONE;
> -			ath11k_dp_rx_mon_dest_process(ar, mac_id, budget, napi);
> -			pmon->mon_ppdu_status = DP_PPDU_STATUS_START;
> +			if (!ab->hw_params.full_monitor_mode) {
> +				ath11k_dp_rx_mon_dest_process(ar, mac_id,
> +							      budget, napi);
> +				pmon->mon_ppdu_status = DP_PPDU_STATUS_START;
> +			}
>   		}
>   
>   		if (ppdu_info->peer_id == HAL_INVALID_PEERID ||

