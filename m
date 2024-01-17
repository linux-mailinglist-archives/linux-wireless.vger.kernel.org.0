Return-Path: <linux-wireless+bounces-2099-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 005D3830775
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jan 2024 15:02:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54586B245BD
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jan 2024 14:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 279AC200DD;
	Wed, 17 Jan 2024 14:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z64IBclE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E27200D9
	for <linux-wireless@vger.kernel.org>; Wed, 17 Jan 2024 14:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705500144; cv=none; b=AEDi05oU5rSsIEd3menAbeXBo3hJ5omkMiexOO450uXjuUCkhn9usl1Jevywmy2J7+n5wn8fAzcR+jN9pBrV+zb9wYG2HKDZBun5VDXoDSDdTurOuPc/2TcaDBUYtWfpPhuhpN01CraDN6csdcDXR7PY6eKex9/tz4Hjfn6iClI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705500144; c=relaxed/simple;
	bh=XieUT0Mhj4DzACLsUYZdtPklFHe3f7LfJIHmqhjFG/o=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:References:Date:
	 In-Reply-To:Message-ID:User-Agent:MIME-Version:Content-Type; b=LmyxM2IYFR73OP4v1NFkUmFnDi1BWRBXm8Du3i8lUIaUsS519ppzNzrzLTSxvoomECi++R/7XdBt5Wqk906gbwLohnuH++qty+nK2TyRA1gF0tsdpHlQbEL1BDXLgrs3RMcdtZEjd/nBQQDOLP8nvhDhykpNPkIiafen9AEau0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z64IBclE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDA29C433C7;
	Wed, 17 Jan 2024 14:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705500143;
	bh=XieUT0Mhj4DzACLsUYZdtPklFHe3f7LfJIHmqhjFG/o=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=Z64IBclEbguTJHaJQS7kNyXyNmnrWWeuPSIigbwupIY0bfxjZeK3AfjgLf03XDPvh
	 uDHBhAGLdCtfIxPfilSxnNvASuueH4+0tEUglWSaL2lIswgZoYTBAC1dsvkAivPiWf
	 vM7+0z0W7b/HO+AufZeQcCPHp9GiBtUOFBiP8N4Oe4BhufWkXC8H8iQg5eFZFChxCN
	 ov5Ns4IamRJPCUziZ/chQRtB2eVQvojGd+czEZom6BdI4bZZHcJTGEjS32CKjIvppW
	 e9t3vaoCllgj+iif0nX60Y9kKrK92eVyc1u6ybLxZ41CBpYV4EkQlcL17GR9+g9e8y
	 Sbh5ioKDHCS7Q==
From: Kalle Valo <kvalo@kernel.org>
To: Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 0/3] wifi: ath12k: Remove unsupported and unused ring
 configurations
References: <20231122063932.10321-1-quic_tamizhr@quicinc.com>
	<878r4o5b08.fsf@kernel.org>
Date: Wed, 17 Jan 2024 16:02:20 +0200
In-Reply-To: <878r4o5b08.fsf@kernel.org> (Kalle Valo's message of "Wed, 17 Jan
	2024 15:45:43 +0200")
Message-ID: <87zfx43vo3.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kalle Valo <kvalo@kernel.org> writes:

> Tamizh Chelvam Raja <quic_tamizhr@quicinc.com> writes:
>
>> Currently in driver doing memory allocation for tx_monitor, tcl_cmd_ring
>> and tcl_status ring. Here driver support for tx_monitor mode is not
>> there and memory for tcl_cmd and tcl_status rings are allocated by
>> firmware and it uses that memory instead of host allocated. So avoid
>> these unused ring setup configuration.
>>
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
>>
>> Tamizh Chelvam Raja (3):
>>   wifi: ath12k: fix calling correct function for rx monitor mode
>>   wifi: ath12k: Remove unsupported tx monitor handling
>>   wifi: ath12k: Remove unused tcl_*_ring configuration
>
> I had several conflict, please double check:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=cfb7ae2dc5d32206d6978625bac055e1f431f450
> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=d9e193e606e87fc4da445c1aed12113d2ae72151
> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=23c88b95ce6a67eb422ab858e22c90312028b69d

Actually I see a new warning with WCN7850. I don't know if I caused it
while fixing the conflicts, or it was there originally, but anyway
please fix this and submit v2.

[ 5806.723781] INFO: trying to register non-static key.
[ 5806.723837] The code is fine but needs lockdep annotation, or maybe
[ 5806.723869] you didn't initialize this object before use?
[ 5806.723900] turning off the locking correctness validator.
[ 5806.723933] CPU: 6 PID: 4327 Comm: rmmod Not tainted 6.7.0-wt-ath+ #1232
[ 5806.723968] Hardware name: Intel(R) Client Systems NUC8i7HVK/NUC8i7HVB, BIOS HNKBLi70.86A.0067.2021.0528.1339 05/28/2021
[ 5806.724000] Call Trace:
[ 5806.724030]  <TASK>
[ 5806.724061]  dump_stack_lvl+0x5c/0xc0
[ 5806.724100]  dump_stack+0x10/0x20
[ 5806.724135]  register_lock_class+0x123c/0x19c0
[ 5806.724171]  ? is_dynamic_key+0x230/0x230
[ 5806.724203]  ? lock_contended+0x290/0x290
[ 5806.724235]  __lock_acquire+0x95/0x1bb0
[ 5806.724267]  ? kasan_quarantine_put+0x106/0x240
[ 5806.724299]  lock_acquire+0x1bc/0x530
[ 5806.724330]  ? ath12k_dp_rxdma_mon_buf_ring_free.isra.0+0x8e/0x2d0 [ath12k]
[ 5806.724382]  ? lock_sync+0x1a0/0x1a0
[ 5806.724412]  ? reacquire_held_locks+0x4d0/0x4d0
[ 5806.724443]  ? __local_bh_enable_ip+0xa5/0x120
[ 5806.724473]  ? __this_cpu_preempt_check+0x13/0x20
[ 5806.724504]  ? lockdep_hardirqs_on+0x7e/0x100
[ 5806.724534]  _raw_spin_lock_bh+0x36/0x70
[ 5806.724565]  ? ath12k_dp_rxdma_mon_buf_ring_free.isra.0+0x8e/0x2d0 [ath12k]
[ 5806.724614]  ath12k_dp_rxdma_mon_buf_ring_free.isra.0+0x8e/0x2d0 [ath12k]
[ 5806.724664]  ? ath12k_dp_rx_link_desc_return.isra.0+0xf0/0xf0 [ath12k]
[ 5806.724713]  ? dma_free_attrs+0xef/0x130
[ 5806.724746]  ath12k_dp_rx_free+0x234/0x2e0 [ath12k]
[ 5806.724796]  ath12k_dp_free+0x32b/0x430 [ath12k]
[ 5806.724847]  ath12k_core_deinit+0xe0/0x130 [ath12k]
[ 5806.724893]  ath12k_pci_remove+0xad/0x1b0 [ath12k]
[ 5806.724943]  pci_device_remove+0x93/0x1b0
[ 5806.724975]  device_remove+0xbf/0x150
[ 5806.725007]  device_release_driver_internal+0x3c3/0x580
[ 5806.725037]  ? __kasan_check_read+0x11/0x20
[ 5806.725069]  driver_detach+0xc4/0x190
[ 5806.725101]  bus_remove_driver+0x130/0x2a0
[ 5806.725133]  driver_unregister+0x68/0x90
[ 5806.725166]  pci_unregister_driver+0x24/0x240
[ 5806.725198]  ? find_module_all+0x13e/0x1c0
[ 5806.725229]  ath12k_pci_exit+0x10/0x20 [ath12k]
[ 5806.725277]  __do_sys_delete_module+0x32d/0x540
[ 5806.725306]  ? module_flags+0x300/0x300
[ 5806.725336]  ? kmem_cache_free+0x306/0x330
[ 5806.725367]  ? __fput+0x404/0xa50
[ 5806.725398]  ? syscall_enter_from_user_mode+0x20/0x50
[ 5806.725428]  ? __this_cpu_preempt_check+0x13/0x20
[ 5806.725458]  __x64_sys_delete_module+0x4f/0x70
[ 5806.725487]  do_syscall_64+0x3c/0xe0
[ 5806.725518]  entry_SYSCALL_64_after_hwframe+0x46/0x4e
[ 5806.725548] RIP: 0033:0x7f0d24d7bc8b
[ 5806.725581] Code: 73 01 c3 48 8b 0d 05 c2 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 b0 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d5 c1 0c 00 f7 d8 64 89 01 48
[ 5806.725613] RSP: 002b:00007ffdf5aa4de8 EFLAGS: 00000206 ORIG_RAX: 00000000000000b0
[ 5806.725647] RAX: ffffffffffffffda RBX: 000055e1720b77e0 RCX: 00007f0d24d7bc8b
[ 5806.725678] RDX: 000000000000000a RSI: 0000000000000800 RDI: 000055e1720b7848
[ 5806.725710] RBP: 00007ffdf5aa4e48 R08: 0000000000000000 R09: 0000000000000000
[ 5806.725740] R10: 00007f0d24df7ac0 R11: 0000000000000206 R12: 00007ffdf5aa5020
[ 5806.725774] R13: 00007ffdf5aa6ebf R14: 000055e1720b62a0 R15: 000055e1720b77e0
[ 5806.725808]  </TASK>

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

