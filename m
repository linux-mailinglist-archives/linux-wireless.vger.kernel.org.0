Return-Path: <linux-wireless+bounces-9609-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED22391855B
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jun 2024 17:10:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D5F01F210A5
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jun 2024 15:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35675186283;
	Wed, 26 Jun 2024 15:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rSuiBWyo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D8017FAB2
	for <linux-wireless@vger.kernel.org>; Wed, 26 Jun 2024 15:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719414599; cv=none; b=LMHSjFrmERuhlnY+wDn2qrns6QV5rm/+5rkmWzLmFf+l7YpGDWCbAolhFl/KnBaaSTcIOhTqhxK4U2DfX9+T82jxrC3kPXNSd5fo5vMLG1PsrocM49eOpMphWxkhmLj6ToBysRB3LMp66Mdv4x5LHcDbJsFtZor91DQjHSLHKXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719414599; c=relaxed/simple;
	bh=dAaV7NJ8n4m+NUsZ+yEVeSS+mfxg2Qsepxc3hxxXOe4=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=RszIu/+DTR/C4BXKkzXyN4ZNB4jZctj5Ic9hZeCNV6Au/5jifHhEUDKvuopZsyKW5NXUsH8E5H2Q1sP+444ct3BDUeNgUPd73LyOlQ7fOvmCTuBU1gBUBN8oOxARGOjoAsUyC8YHBJTaDItxAAP+XtBzwWQz9WaFYg9VvGWGkC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rSuiBWyo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C8C5C116B1;
	Wed, 26 Jun 2024 15:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719414598;
	bh=dAaV7NJ8n4m+NUsZ+yEVeSS+mfxg2Qsepxc3hxxXOe4=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=rSuiBWyoNIUlgCl6oLC1LvCNdOdiEu5OPktcuBlLVgP23xCqpzHfAzRQk1i6KhEh3
	 vMM3HU6MsalG0km2GlPUXvx3uhc+tLChaRRzTk6b8Tdq6BQXZpnp9IYydjxpvUsPP8
	 vC5RbWQGX1n35afAX7ChpGVnzcrRPdG0zSWgE1Vxq2ic4OtNDn9xwoXJuvmKX96ZgV
	 MIP3T1VmL4OJDUuFKBfSbfO5w9JA1ExKJA5ABs9VA7ldjUnsauM9guc1E+7Tn6QBqS
	 WT7/WwkSD1WCwuSLIlPG8c+mBRF/uXhVBF1s8aKjJZFXJdgV2kegwL4SMoYAdc3fHk
	 LHjFuWlMQyH7g==
From: Kalle Valo <kvalo@kernel.org>
To: Sowmiya Sree Elavalagan <quic_ssreeela@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v3]wifi: ath12k: Add firmware coredump collection support
References: <20240325183414.4016663-1-quic_ssreeela@quicinc.com>
	<171889253841.918573.15918536206746856053.kvalo@kernel.org>
Date: Wed, 26 Jun 2024 18:09:56 +0300
In-Reply-To: <171889253841.918573.15918536206746856053.kvalo@kernel.org>
	(Kalle Valo's message of "Thu, 20 Jun 2024 14:08:59 +0000 (UTC)")
Message-ID: <87zfr7hha3.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kalle Valo <kvalo@kernel.org> writes:

> Sowmiya Sree Elavalagan <quic_ssreeela@quicinc.com> wrote:
>
>> In case of firmware assert snapshot of firmware memory is essential for
>> debugging. Add firmware coredump collection support for PCI bus.
>> Collect RDDM and firmware paging dumps from MHI and pack them in TLV
>> format and also pack various memory shared during QMI phase in separate
>> TLVs.  Add necessary header and share the dumps to user space using dev
>> coredump framework. Coredump collection is disabled by default and can
>> be enabled using menuconfig. Dump collected for a radio is 55 MB
>> approximately.
>> 
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.2.1-00201-QCAHKSWPL_SILICONZ-1
>> 
>> Signed-off-by: Sowmiya Sree Elavalagan <quic_ssreeela@quicinc.com>
>> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
>> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
>
> This didn't compile for me, I added this to pci.c:
>
> +#include <linux/vmalloc.h>
>
> Also in the pending branch I made some whitespace in struct ath12k_dump_file_data:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=44ae07628b68375f476895f4fc1e89a570790ac0
>
> Any tips how to test this until we have the debugfs interface to crash the firmware?

I was able to get patch 'wifi: ath12k: Add support to simulate firmware
crash' (not yet public) and did a quick test with it. There seems to be
a KASAN warning but I can't debug this further at this time.

[ 8091.304272] ath12k_pci 0000:06:00.0: simulating firmware assert crash
[ 8091.722245] ==================================================================
[ 8091.722329] BUG: KASAN: vmalloc-out-of-bounds in ath12k_pci_coredump_download+0x1071/0x1330 [ath12k]
[ 8091.722433] Write of size 4 at addr ffffc9000644b28c by task kworker/u32:0/11
[ 8091.722517] 
[ 8091.722552] CPU: 0 PID: 11 Comm: kworker/u32:0 Not tainted 6.10.0-rc4-wt-ath+ #1663
[ 8091.722604] Hardware name: Intel(R) Client Systems NUC8i7HVK/NUC8i7HVB, BIOS HNKBLi70.86A.0067.2021.0528.1339 05/28/2021
[ 8091.722670] Workqueue: ath12k_aux_wq ath12k_core_reset [ath12k]
[ 8091.722742] Call Trace:
[ 8091.722778]  <TASK>
[ 8091.722832]  dump_stack_lvl+0x7d/0xe0
[ 8091.722920]  print_address_description.constprop.0+0x33/0x3a0
[ 8091.722999]  print_report+0xb5/0x260
[ 8091.723069]  ? kasan_addr_to_slab+0xd/0x80
[ 8091.723146]  kasan_report+0xd8/0x110
[ 8091.723217]  ? ath12k_pci_coredump_download+0x1071/0x1330 [ath12k]
[ 8091.723301]  ? ath12k_pci_coredump_download+0x1071/0x1330 [ath12k]
[ 8091.723386]  __asan_report_store_n_noabort+0x12/0x20
[ 8091.723461]  ath12k_pci_coredump_download+0x1071/0x1330 [ath12k]
[ 8091.723563]  ? ath12k_pci_coredump_calculate_size+0x730/0x730 [ath12k]
[ 8091.723632]  ? __this_cpu_preempt_check+0x13/0x20
[ 8091.723677]  ath12k_coredump_collect+0x60/0x73 [ath12k]
[ 8091.724276]  ath12k_core_reset+0x1b1/0x880 [ath12k]
[ 8091.724921]  ? _raw_spin_unlock_irq+0x22/0x50
[ 8091.725503]  ? __this_cpu_preempt_check+0x13/0x20
[ 8091.726126]  process_one_work+0x8d7/0x19f0
[ 8091.726718]  ? pwq_dec_nr_in_flight+0x580/0x580
[ 8091.727346]  ? move_linked_works+0x128/0x2c0
[ 8091.727998]  ? assign_work+0x15e/0x270
[ 8091.728601]  worker_thread+0x715/0x1270
[ 8091.729244]  ? rescuer_thread+0xdb0/0xdb0
[ 8091.729905]  kthread+0x2fa/0x3f0
[ 8091.730520]  ? kthread_insert_work_sanity_check+0xd0/0xd0
[ 8091.731192]  ret_from_fork+0x31/0x70
[ 8091.731856]  ? kthread_insert_work_sanity_check+0xd0/0xd0
[ 8091.732525]  ret_from_fork_asm+0x11/0x20
[ 8091.733212]  </TASK>
[ 8091.733909] 
[ 8091.734559] The buggy address belongs to the virtual mapping at#012[ 8091.734559]  [ffffc9000500b000, ffffc9000644d000) created by:#012[ 8091.734559]  ath12k_pci_coredump_download+0x147/0x1330 [ath12k]
[ 8091.736558] 
[ 8091.737272] The buggy address belongs to the physical page:
[ 8091.738016] page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x15a485
[ 8091.738730] flags: 0x200000000000000(node=0|zone=2)
[ 8091.739481] raw: 0200000000000000 0000000000000000 dead000000000122 0000000000000000
[ 8091.740256] raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
[ 8091.741043] page dumped because: kasan: bad access detected
[ 8091.741786] 
[ 8091.742529] Memory state around the buggy address:
[ 8091.743296]  ffffc9000644b180: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[ 8091.744087]  ffffc9000644b200: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[ 8091.744834] >ffffc9000644b280: 00 04 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
[ 8091.745598]                       ^
[ 8091.746359]  ffffc9000644b300: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
[ 8091.747152]  ffffc9000644b380: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
[ 8091.747932] ==================================================================
[ 8091.748688] Disabling lock debugging due to kernel taint
[ 8091.749699] ath12k_pci 0000:06:00.0: Uploading coredump

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

