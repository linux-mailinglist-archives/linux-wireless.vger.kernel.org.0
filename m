Return-Path: <linux-wireless+bounces-10150-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E6892D62C
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jul 2024 18:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89FE91F210BC
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jul 2024 16:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060FA194A66;
	Wed, 10 Jul 2024 16:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X4x++dXN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B3A1946CF
	for <linux-wireless@vger.kernel.org>; Wed, 10 Jul 2024 16:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720628453; cv=none; b=mmkmAgmoESTaKdFpqNmbofqYxZsQccDUzJdR4ZbFPmj0fhDjqrfKt6SoyrGrL2N8JPULojcfqRVCgah+bXOkCv24zp0HeNtYzKBq6dtCRgqZXaLQ63GGqbwjdFMilrwmefFHWpkXQ1k023YFPM9+4WIA6Hcdgn/VWVj3JQ/mYKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720628453; c=relaxed/simple;
	bh=0GqJPhrRtpd/DsTVXuni30JA9st9StBGfuFEjySZ4AQ=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=mCjCfZH9BWnlxl7hqvuxJ80bPnwQS7C1uvwdqReE2eTZuEwP1VGUImoDMXPjcz+VLlkO9hWLxJc/F5quA2FcPnjlI+zdTRWZrv3wm/RYc8LhpdD6wBG7ZJj8hp2v9S31N76atRCpwAFuXmhFy2V7kXAvxapDqBChepA2+ZmWRd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X4x++dXN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47FDEC32781;
	Wed, 10 Jul 2024 16:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720628453;
	bh=0GqJPhrRtpd/DsTVXuni30JA9st9StBGfuFEjySZ4AQ=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=X4x++dXNMD51NCkXpvtvz9gRb4vNNorvGbhAgMsXUtjd8pak5orgW0rga8aKcVcUW
	 oaonNKC1d5DuDkwSFE0xRJkFR4U2d52glr/y+FYVPNVYVpi4JAC+sDkKKxCbXQ34Dv
	 zkBtVB+5JO97iyg5pzEDuhFMgC94g8XSoTBjEznkBiczT68KCvz97hOclJ0wXM1igQ
	 2zPiNO6GYc6gvHtEv8+sGriYqBjsNtq4zqtReFxm0BdKeob/Vi0u4UBhQ6VT0P3SrF
	 1EegUQC0KTOYgNMSFcWWr2ZdYgvNpR2MHy3p5vaoT3+1Zkz0NVMQn0ZXED7K0CEe5/
	 UcUo2LwRgt2Zg==
From: Kalle Valo <kvalo@kernel.org>
To: Miaoqing Pan <quic_miaoqing@quicinc.com>
Cc: <quic_jjohnson@quicinc.com>,  <ath11k@lists.infradead.org>,
  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v2] wifi: ath11k: Add firmware coredump collection support
References: <20240605034639.3942219-1-quic_miaoqing@quicinc.com>
Date: Wed, 10 Jul 2024 19:20:50 +0300
In-Reply-To: <20240605034639.3942219-1-quic_miaoqing@quicinc.com> (Miaoqing
	Pan's message of "Wed, 5 Jun 2024 11:46:39 +0800")
Message-ID: <874j8xb4m5.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Miaoqing Pan <quic_miaoqing@quicinc.com> writes:

> In case of firmware assert snapshot of firmware memory is essential for
> debugging. Add firmware coredump collection support for PCI bus.
> Collect RDDM and firmware paging dumps from MHI and pack them in TLV
> format and also pack various memory shared during QMI phase in separate
> TLVs.  Add necessary header and share the dumps to user space using dev
> coredump framework. Coredump collection is disabled by default and can
> be enabled using menuconfig. Dump collected for a radio is 55 MB
> approximately.
>
> The changeset is mostly copied from:
> https://lore.kernel.org/all/20240325183414.4016663-1-quic_ssreeela@quicinc.com/.
>
> Tested-on: WCN6855 hw2.1 PCI WLAN.HSP.1.1-04358-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
>
> Signed-off-by: Miaoqing Pan <quic_miaoqing@quicinc.com>

This has a similar KASAN warning as did the ath12k patch:

[   48.364483] modprobe (1116) used greatest stack depth: 21760 bytes left
[   48.450859] ath11k_pci 0000:06:00.0: chip_id 0x2 chip_family 0xb board_id 0x106 soc_id 0x400c0200
[   48.451252] ath11k_pci 0000:06:00.0: fw_version 0x11088c35 fw_build_timestamp 2024-04-17 08:34 fw_build_id WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.41
[   63.694922] ath11k_pci 0000:06:00.0: simulating firmware assert crash
[   64.118179] ath11k_pci 0000:06:00.0: firmware crashed: MHI_CB_EE_RDDM
[   64.132388] ==================================================================
[   64.132470] BUG: KASAN: vmalloc-out-of-bounds in ath11k_pci_coredump_download+0x10db/0x12c0 [ath11k_pci]
[   64.132530] Write of size 4 at addr ffffc9000497520c by task kworker/u32:2/88
[   64.132578] 
[   64.132610] CPU: 5 PID: 88 Comm: kworker/u32:2 Not tainted 6.10.0-rc6-wt-ath+ #1678
[   64.132659] Hardware name: Intel(R) Client Systems NUC8i7HVK/NUC8i7HVB, BIOS HNKBLi70.86A.0067.2021.0528.1339 05/28/2021
[   64.132719] Workqueue: ath11k_aux_wq ath11k_core_reset [ath11k]
[   64.132791] Call Trace:
[   64.132827]  <TASK>
[   64.132867]  dump_stack_lvl+0x7d/0xe0
[   64.132910]  print_address_description.constprop.0+0x33/0x3a0
[   64.132958]  print_report+0xb5/0x260
[   64.133038]  ? kasan_addr_to_slab+0xd/0x80
[   64.133096]  kasan_report+0xd8/0x110
[   64.133132]  ? ath11k_pci_coredump_download+0x10db/0x12c0 [ath11k_pci]
[   64.133179]  ? ath11k_pci_coredump_download+0x10db/0x12c0 [ath11k_pci]
[   64.133225]  __asan_report_store_n_noabort+0x12/0x20
[   64.133266]  ath11k_pci_coredump_download+0x10db/0x12c0 [ath11k_pci]
[   64.133311]  ? ath11k_pci_coredump_calculate_size+0x710/0x710 [ath11k_pci]
[   64.133358]  ? lock_sync+0x1a0/0x1a0
[   64.133398]  ath11k_coredump_collect+0x60/0x73 [ath11k]
[   64.133466]  ath11k_core_reset+0x225/0x640 [ath11k]
[   64.133524]  ? debug_smp_processor_id+0x17/0x20
[   64.133564]  process_one_work+0x8cc/0x19c0
[   64.133893]  ? pwq_dec_nr_in_flight+0x580/0x580
[   64.133934]  ? move_linked_works+0x128/0x2c0
[   64.134007]  ? assign_work+0x15e/0x270
[   64.134074]  worker_thread+0x715/0x1230
[   64.134114]  ? __this_cpu_preempt_check+0x13/0x20
[   64.134153]  ? lockdep_hardirqs_on+0x7d/0x100
[   64.134192]  ? rescuer_thread+0xdb0/0xdb0
[   64.134229]  kthread+0x2fa/0x3f0
[   64.134266]  ? kthread_insert_work_sanity_check+0xd0/0xd0
[   64.134308]  ret_from_fork+0x31/0x70
[   64.134345]  ? kthread_insert_work_sanity_check+0xd0/0xd0
[   64.134386]  ret_from_fork_asm+0x11/0x20
[   64.134426]  </TASK>
[   64.134459] 
[   64.134498] The buggy address belongs to the virtual mapping at#012[   64.134498]  [ffffc90003965000, ffffc90004977000) created by:#012[   64.134498]  ath11k_pci_coredump_download+0x144/0x12c0 [ath11k_pci]
[   64.134576] 
[   64.134606] The buggy address belongs to the physical page:
[   64.134648] page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x13faee
[   64.134699] flags: 0x200000000000000(node=0|zone=2)
[   64.134746] raw: 0200000000000000 0000000000000000 dead000000000122 0000000000000000
[   64.134796] raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
[   64.135523] page dumped because: kasan: bad access detected
[   64.136273] 
[   64.136928] Memory state around the buggy address:
[   64.137641]  ffffc90004975100: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[   64.138361]  ffffc90004975180: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[   64.139074] >ffffc90004975200: 00 04 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
[   64.139742]                       ^
[   64.140495]  ffffc90004975280: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
[   64.141222]  ffffc90004975300: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
[   64.141892] ==================================================================
[   64.142674] Disabling lock debugging due to kernel taint
[   64.143630] ath11k_pci 0000:06:00.0: Uploading coredump

> ---
> v2: fix implicit declaration of function 'vzalloc'.
>
>  drivers/net/wireless/ath/ath11k/Kconfig    |  11 ++
>  drivers/net/wireless/ath/ath11k/Makefile   |   1 +
>  drivers/net/wireless/ath/ath11k/core.c     |   2 +
>  drivers/net/wireless/ath/ath11k/core.h     |   5 +
>  drivers/net/wireless/ath/ath11k/coredump.c |  52 ++++++
>  drivers/net/wireless/ath/ath11k/coredump.h |  79 +++++++++
>  drivers/net/wireless/ath/ath11k/hif.h      |   7 +
>  drivers/net/wireless/ath/ath11k/mhi.c      |   5 +
>  drivers/net/wireless/ath/ath11k/mhi.h      |   1 +
>  drivers/net/wireless/ath/ath11k/pci.c      | 191 +++++++++++++++++++++
>  drivers/net/wireless/ath/ath11k/qmi.c      |  45 ++---
>  drivers/net/wireless/ath/ath11k/qmi.h      |   9 +-
>  12 files changed, 384 insertions(+), 24 deletions(-)
>  create mode 100644 drivers/net/wireless/ath/ath11k/coredump.c
>  create mode 100644 drivers/net/wireless/ath/ath11k/coredump.h

I feel that the QMI changes should be in a separat patch and explaining
in detail what they are about. Didn't review those now as there's no
explanation.

> diff --git a/drivers/net/wireless/ath/ath11k/Kconfig b/drivers/net/wireless/ath/ath11k/Kconfig
> index 27f0523bf967..bb91da0098b4 100644
> --- a/drivers/net/wireless/ath/ath11k/Kconfig
> +++ b/drivers/net/wireless/ath/ath11k/Kconfig
> @@ -57,3 +57,14 @@ config ATH11K_SPECTRAL
>  	  Enable ath11k spectral scan support
>  
>  	  Say Y to enable access to the FFT/spectral data via debugfs.
> +
> +config ATH11K_COREDUMP
> +	bool "ath11k coredump"
> +	depends on ATH11K
> +	select WANT_DEV_COREDUMP
> +	help
> +	  Enable ath11k coredump collection
> +
> +	  If unsure, say Y to make it easier to debug problems. But if
> +	  dump collection not required choose N.

I'm not sure if a new Kconfig option is justified? Maybe instead just
use CONFIG_DEV_COREDUMP directly.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

