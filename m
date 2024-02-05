Return-Path: <linux-wireless+bounces-3128-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29925849E97
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Feb 2024 16:40:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF4811F2227D
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Feb 2024 15:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57302D050;
	Mon,  5 Feb 2024 15:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VFb+m7LH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2FB2D03B
	for <linux-wireless@vger.kernel.org>; Mon,  5 Feb 2024 15:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707147622; cv=none; b=jZwzq65XFPqaRXT7gfncI1JnRhU0Sp3qFFvcAx+O/vh29nyymHrxS1oifxEoBF3XslRJBdgqwC9sfJNn7yqZP5azKhMJNcrmZpreraiN/vWZa3iNWC3lHtrhfdq6K5m099laLGJ5w+IHKsAqRftdpRGoHVKPmtt8iRmuTmRm9yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707147622; c=relaxed/simple;
	bh=BEeUYYQ4BQ/jMZcN0OFMP755Rsd6a6un6jNbBmf2Rtc=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=DPiUr5+LrG/KRW6see+qe8fegzUeFoyGA6s7rXBOp9Lwv7yt7kzAT3uOMbucWkHmEUjHLm8zKrrjRxS2E05VKUdyWiKwSNijZflLfG2nVJ8NNG7nSulyfaUeOIP+0h6gfWqRmHS7tXzlRukJ0cBwd3bBEI/+ZMsWlqK4AXuoHjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VFb+m7LH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F385C433F1;
	Mon,  5 Feb 2024 15:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707147622;
	bh=BEeUYYQ4BQ/jMZcN0OFMP755Rsd6a6un6jNbBmf2Rtc=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=VFb+m7LH8O3Umu2yjyR+jHMY5lvJ1771rksX9abcPoPZJylg5soUR8oxZJz5Sninv
	 oeyzI7AKTrId3iFjbkPWhZ75IcSumIbacf0YlnQex0orqkgXxerLRPDGkplqBxgkjM
	 fQbrb3Wu3DKZqkv6MN+gFGEvDLcx55PgsDIozG9fZzTqIzbjJPUqkbroOClauk/1JO
	 UOtTVnvrFfWLblZgbxV8O1RrCGzrVgd96/d+odOy6kXP/qL+cb+h6ZbtERIryNzNmU
	 /0CQn0209td9uY0ZabtNDoGi8CtU3ZfK17W/FmB32aN/NFRR7w6jXRjTxnwSAbDVLs
	 rtnD4mu3vmcdw==
From: Kalle Valo <kvalo@kernel.org>
To: Kang Yang <quic_kangyang@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v6 00/11] wifi: ath12k: P2P support for WCN7850
References: <20240130040303.370590-1-quic_kangyang@quicinc.com>
Date: Mon, 05 Feb 2024 17:40:19 +0200
In-Reply-To: <20240130040303.370590-1-quic_kangyang@quicinc.com> (Kang Yang's
	message of "Tue, 30 Jan 2024 12:02:52 +0800")
Message-ID: <87o7cusyvw.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kang Yang <quic_kangyang@quicinc.com> writes:

> Add P2P support for WCN7850.
>
> Kang Yang (11):
>   wifi: ath12k: fix broken structure wmi_vdev_create_cmd
>   wifi: ath12k: fix incorrect logic of calculating vdev_stats_id
>   wifi: ath12k: change interface combination for P2P mode
>   wifi: ath12k: add P2P IE in beacon template
>   wifi: ath12k: implement handling of P2P NoA event
>   wifi: ath12k: implement remain on channel for P2P mode
>   wifi: ath12k: change WLAN_SCAN_PARAMS_MAX_IE_LEN from 256 to 512
>   wifi: ath12k: allow specific mgmt frame tx while vdev is not up
>   wifi: ath12k: move peer delete after vdev stop of station for WCN7850
>   wifi: ath12k: designating channel frequency for ROC scan
>   wifi: ath12k: advertise P2P dev support for WCN7850

I did some quick tests by running various p2p commands with wpa_cli and
noticed the warning below. We might have some issues with our RCU usage,
please check. But no need to resend because of this, followup patch
fixing this is fine.

[ 1108.916980] =============================
[ 1108.917068] WARNING: suspicious RCU usage
[ 1108.917151] 6.8.0-rc2-wt-ath+ #1273 Not tainted
[ 1108.917235] -----------------------------
[ 1108.917318] drivers/net/wireless/ath/ath12k/mac.c:583 suspicious rcu_dereference_check() usage!
[ 1108.917400] #012[ 1108.917400] other info that might help us debug this:#012[ 1108.917400] 
[ 1108.917484] #012[ 1108.917484] rcu_scheduler_active = 2, debug_locks = 1
[ 1108.917566] no locks held by swapper/3/0.
[ 1108.917649] #012[ 1108.917649] stack backtrace:
[ 1108.917729] CPU: 3 PID: 0 Comm: swapper/3 Not tainted 6.8.0-rc2-wt-ath+ #1273
[ 1108.917810] Hardware name: Intel(R) Client Systems NUC8i7HVK/NUC8i7HVB, BIOS HNKBLi70.86A.0067.2021.0528.1339 05/28/2021
[ 1108.917892] Call Trace:
[ 1108.917968]  <IRQ>
[ 1108.918046]  dump_stack_lvl+0x82/0xc0
[ 1108.918132]  dump_stack+0x10/0x20
[ 1108.918206]  lockdep_rcu_suspicious+0x210/0x3a0
[ 1108.918285]  ath12k_mac_get_ar_by_vdev_id+0x18e/0x210 [ath12k]
[ 1108.918403]  ath12k_wmi_op_rx+0x2bb/0x1a30 [ath12k]
[ 1108.918511]  ? ath12k_chan_info_event+0x970/0x970 [ath12k]
[ 1108.918624]  ? __lock_acquire+0xd45/0x1de0
[ 1108.918706]  ? __kasan_check_read+0x11/0x20
[ 1108.918789]  ? debug_smp_processor_id+0x17/0x20
[ 1108.918863]  ? __lock_release.isra.0+0x49d/0xae0
[ 1108.918934]  ? debug_smp_processor_id+0x17/0x20
[ 1108.919007]  ? reacquire_held_locks+0x4d0/0x4d0
[ 1108.919080]  ? ath12k_ce_recv_process_cb+0x4b3/0x960 [ath12k]
[ 1108.919195]  ath12k_htc_rx_completion_handler+0x361/0x650 [ath12k]
[ 1108.919302]  ? ath12k_ce_recv_process_cb+0x4b3/0x960 [ath12k]
[ 1108.919409]  ? trace_hardirqs_on+0x49/0x50
[ 1108.919485]  ath12k_ce_recv_process_cb+0x5c6/0x960 [ath12k]
[ 1108.919591]  ? ath12k_ce_rx_post_pipe+0x990/0x990 [ath12k]
[ 1108.919658]  ? __wake_up_bit+0x120/0x120
[ 1108.919705]  ? handle_irq_event+0x10e/0x1c0
[ 1108.919752]  ath12k_ce_per_engine_service+0xda/0x110 [ath12k]
[ 1108.919817]  ath12k_pci_ce_tasklet+0x65/0x120 [ath12k]
[ 1108.919879]  ? trace_tasklet_entry+0xe4/0x110
[ 1108.919945]  tasklet_action_common.isra.0+0x24c/0x3d0
[ 1108.920007]  tasklet_action+0x4f/0x70
[ 1108.920068]  __do_softirq+0x1c2/0x868
[ 1108.920116]  irq_exit_rcu+0xab/0x110
[ 1108.920159]  common_interrupt+0xad/0xd0
[ 1108.920201]  </IRQ>
[ 1108.920309]  <TASK>
[ 1108.920355]  asm_common_interrupt+0x27/0x40
[ 1108.920399] RIP: 0010:cpuidle_enter_state+0xdc/0x580
[ 1108.920448] Code: ff ff ff ff 49 89 c7 e8 e2 fa 55 ff 31 ff e8 cb 29 54 fd 80 7d d0 00 0f 85 4a 02 00 00 e8 0c f9 55 ff 84 c0 0f 84 32 02 00 00 <45> 85 f6 0f 88 95 01 00 00 49 63 d6 48 83 fa 0a 0f 83 dd 02 00 00
[ 1108.920496] RSP: 0018:ffffc900001afd20 EFLAGS: 00000202
[ 1108.920545] RAX: 000000000065289d RBX: ffff888116413400 RCX: 1ffffffff47726c1
[ 1108.920593] RDX: 0000000000000000 RSI: ffffffffa2278020 RDI: ffffffffa24176e0
[ 1108.920639] RBP: ffffc900001afd70 R08: 0000000000000001 R09: fffffbfff4772c1a
[ 1108.920686] R10: ffffffffa3b960d7 R11: 0000000000000000 R12: ffffffffa34c1740
[ 1108.920733] R13: 0000000000000002 R14: 0000000000000002 R15: 000001023093b5a2
[ 1108.920793]  cpuidle_enter+0x4a/0xa0
[ 1108.920840]  call_cpuidle+0x42/0xb0
[ 1108.920882]  ? tick_nohz_idle_retain_tick+0x70/0xa0
[ 1108.920946]  cpuidle_idle_call+0x1c9/0x290
[ 1108.921002]  ? arch_cpu_idle_exit+0x30/0x30
[ 1108.921045]  ? debug_smp_processor_id+0x17/0x20
[ 1108.921092]  do_idle+0xfb/0x160
[ 1108.921137]  cpu_startup_entry+0x54/0x60
[ 1108.921182]  start_secondary+0x201/0x290
[ 1108.921227]  ? set_cpu_sibling_map+0x1f20/0x1f20
[ 1108.921273]  secondary_startup_64_no_verify+0x15e/0x16b
[ 1108.921324]  </TASK>


-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

