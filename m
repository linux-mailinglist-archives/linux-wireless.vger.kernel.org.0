Return-Path: <linux-wireless+bounces-2492-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA6E383C50E
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jan 2024 15:44:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 091B11C222B5
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jan 2024 14:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DA6663413;
	Thu, 25 Jan 2024 14:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FeYDH+SK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5605DF32
	for <linux-wireless@vger.kernel.org>; Thu, 25 Jan 2024 14:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706193890; cv=none; b=hoSyUGzSUGSMr56SRqTl9zcnvVaoFhHBFa1qJP8NQXO7phALiUXoY+G1HaIkaZDlrcq+c8PA+BlQqphuH7LhfYEY5UDaKM0xkHfjW1nEsc4FnwN6zSjR98UzoAqt14SZFttZ8JK5NAD3yRqKDpK2qZjbEQ1m/UtDkJpCY4kcbKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706193890; c=relaxed/simple;
	bh=BL3lUnsRqGCbUnIu/uOKwxG8uQe+l2907he7WcNy65Q=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=lARmh+XCdDiwJoGrGXcG0onsme4R5aG/DH5K62ezP8H2vTM4o06TKejNJUM8cD+6yaoOqTOKeJnX1K/Rxr6aBhknp+MuWbrf+WNr04oRw/kA6SH8uck4jqfa7ixBvpxhucPSqxr5bAg5wGtxBwhlknJprgC+SC+6skevhb0KT3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FeYDH+SK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2C5CC433F1;
	Thu, 25 Jan 2024 14:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706193889;
	bh=BL3lUnsRqGCbUnIu/uOKwxG8uQe+l2907he7WcNy65Q=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=FeYDH+SKaC9jBPyQELTIBCbfyPETkmzHRmX+zqQjRRILV6i0NeoCrJoz+2kKouE96
	 wM9OIa2YKBzpd8UnQHcftwFJEDuIWVyRzU3i8tfReuFMBJgFubznbqHEm2vWU7hucK
	 Ioo2GjiOZIwtSWmAo8gxPrWvSb2oKub4Zlr3doeGq9ThwCj17Vd2FgxaM2gmi4t4Tr
	 wRjBGjgyyDtRu6Qls24OxUzR3svZ72s4ak0ZICFYFzBHUwDojyk/b2DxT6Fc6BUmua
	 mCNZnWxMHMwpsjtS4a8AdZkmU0yvvIdoXW7yl37v9lZ1XoMTZKkZfuMeJAH/vjsYB1
	 Ep/NXEVEjJFpw==
From: Kalle Valo <kvalo@kernel.org>
To: Kang Yang <quic_kangyang@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v3 00/10] wifi: ath12k: P2P support for WCN7850
References: <20240122113904.8938-1-quic_kangyang@quicinc.com>
Date: Thu, 25 Jan 2024 16:44:46 +0200
In-Reply-To: <20240122113904.8938-1-quic_kangyang@quicinc.com> (Kang Yang's
	message of "Mon, 22 Jan 2024 19:38:54 +0800")
Message-ID: <87cytp1nhd.fsf@kernel.org>
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
> Kang Yang (10):
>   wifi: ath12k: change interface combination for P2P mode
>   wifi: ath12k: add P2P IE in beacon template
>   wifi: ath12k: implement handling of P2P NoA event
>   wifi: ath12k: implement remain on channel for P2P mode
>   wifi: ath12k: change WLAN_SCAN_PARAMS_MAX_IE_LEN from 256 to 512
>   wifi: ath12k: allow specific mgmt frame tx while vdev is not up
>   wifi: ath12k: fix broken structure wmi_vdev_create_cmd
>   wifi: ath12k: move peer delete after vdev stop of station for WCN7850
>   wifi: ath12k: designating channel frequency for ROC scan
>   wifi: ath12k: advertise P2P dev support for WCN7850
>
> v3: rebase on new ath-tag, use ath12k_ah_to_ar() get ar(Karthikeyan).
> v2:
>     1. add Tested-on tag of QCN9274.
>     2. update copyright in patch #1, #2, #4 and #10.

I have not been able to run any p2p tests yet but during rmmod with
WCN7850 I now see:

[  136.260660] ------------[ cut here ]------------
[  136.260909] UBSAN: shift-out-of-bounds in drivers/net/wireless/ath/ath12k/mac.c:6005:38
[  136.261008] shift exponent 255 is too large for 64-bit type 'long long int'
[  136.261096] CPU: 1 PID: 1993 Comm: rmmod Not tainted 6.8.0-rc1-wt-ath+ #1262
[  136.261180] Hardware name: Intel(R) Client Systems NUC8i7HVK/NUC8i7HVB, BIOS HNKBLi70.86A.0067.2021.0528.1339 05/28/2021
[  136.261261] Call Trace:
[  136.261343]  <TASK>
[  136.261427]  dump_stack_lvl+0x82/0xc0
[  136.261513]  dump_stack+0x10/0x20
[  136.261597]  __ubsan_handle_shift_out_of_bounds+0x13f/0x300
[  136.261711]  ath12k_mac_op_remove_interface.cold+0x17/0x86 [ath12k]
[  136.261941]  drv_remove_interface+0x215/0x4a0 [mac80211]
[  136.262102]  ieee80211_do_stop+0xfe4/0x2390 [mac80211]
[  136.262258]  ? trace_contention_end+0xe2/0x110
[  136.262359]  ? ieee80211_del_virtual_monitor+0x60/0x60 [mac80211]
[  136.262507]  ? mutex_lock_io_nested+0x1260/0x1260
[  136.262610]  ? debug_smp_processor_id+0x17/0x20
[  136.262702]  ? trace_contention_end+0xe2/0x110
[  136.262792]  ieee80211_sdata_stop+0x4d/0x70 [mac80211]
[  136.262961]  ieee80211_stop_p2p_device+0xd/0x10 [mac80211]
[  136.263127]  cfg80211_stop_p2p_device+0x18e/0x580 [cfg80211]
[  136.263282]  cfg80211_shutdown_all_interfaces+0x10c/0x190 [cfg80211]
[  136.263434]  ieee80211_remove_interfaces+0xc7/0x8f0 [mac80211]
[  136.263611]  ? __wait_for_common+0x42f/0x6d0
[  136.263702]  ? ieee80211_sdata_stop+0x70/0x70 [mac80211]
[  136.263881]  ieee80211_unregister_hw+0x4f/0x380 [mac80211]
[  136.264045]  ath12k_mac_hw_unregister+0x7a/0x250 [ath12k]
[  136.264155]  ath12k_mac_unregister+0x7f/0xc0 [ath12k]
[  136.264265]  ath12k_core_deinit+0x2e/0x130 [ath12k]
[  136.264372]  ath12k_pci_remove+0xad/0x1a0 [ath12k]
[  136.264478]  pci_device_remove+0x93/0x1b0
[  136.264567]  device_remove+0xbf/0x150
[  136.264662]  device_release_driver_internal+0x3c3/0x580
[  136.264746]  ? __kasan_check_read+0x11/0x20
[  136.264836]  driver_detach+0xc4/0x190
[  136.264924]  bus_remove_driver+0x130/0x2a0
[  136.265012]  driver_unregister+0x68/0x90
[  136.265095]  pci_unregister_driver+0x24/0x240
[  136.265177]  ? find_module_all+0x13e/0x1c0
[  136.265267]  ath12k_pci_exit+0x10/0x20 [ath12k]
[  136.265372]  __do_sys_delete_module+0x32d/0x540
[  136.265454]  ? module_flags+0x300/0x300
[  136.265708]  ? kmem_cache_free+0xea/0x3a0
[  136.265795]  ? __fput+0x404/0xa50
[  136.265887]  ? debug_smp_processor_id+0x17/0x20
[  136.265983]  __x64_sys_delete_module+0x4f/0x70
[  136.266064]  do_syscall_64+0x66/0x130
[  136.266149]  entry_SYSCALL_64_after_hwframe+0x46/0x4e
[  136.266256] RIP: 0033:0x7efe74591c8b
[  136.266347] Code: 73 01 c3 48 8b 0d 05 c2 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 b0 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d5 c1 0c 00 f7 d8 64 89 01 48
[  136.266435] RSP: 002b:00007ffea9c34cb8 EFLAGS: 00000206 ORIG_RAX: 00000000000000b0
[  136.266550] RAX: ffffffffffffffda RBX: 000055db95b4c7e0 RCX: 00007efe74591c8b
[  136.266679] RDX: 000000000000000a RSI: 0000000000000800 RDI: 000055db95b4c848
[  136.266808] RBP: 00007ffea9c34d18 R08: 0000000000000000 R09: 0000000000000000
[  136.266934] R10: 00007efe7460dac0 R11: 0000000000000206 R12: 00007ffea9c34ef0
[  136.267062] R13: 00007ffea9c36ebf R14: 000055db95b4b2a0 R15: 000055db95b4c7e0
[  136.267221]  </TASK>
[  136.267390] ---[ end trace ]---

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

