Return-Path: <linux-wireless+bounces-22311-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF538AA611C
	for <lists+linux-wireless@lfdr.de>; Thu,  1 May 2025 18:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47F164C471F
	for <lists+linux-wireless@lfdr.de>; Thu,  1 May 2025 16:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF72204840;
	Thu,  1 May 2025 16:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Yw7F+88U"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1687618DB22;
	Thu,  1 May 2025 16:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746115231; cv=none; b=iWGcoiyTBeNAwG/+/ZQd0akglTCBsuuHFL0bWAg6UcBdE9BnOE0Gy/wAJS/y/cDrW8aRzNcacPXC7tSV4pbkMip/LsZGXs2WWSMP+JoO9Wa04I9DXm0fD5U2OdZ5G2ZqcqgpayiXv0b1e2utxdl+ybzAeNjEjwXwGRmAhRGelBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746115231; c=relaxed/simple;
	bh=QdLG6Mxfeg9stM1JIO8NgkMtgfF8uSG0xcaTqwxc4jA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WaO/MebSr4JJan4GnFUVIuMQqUsIclLbymwC/Ke6VrlSj3c+Sik2FQcyv6oyIHdnorleqF+OVCX1HMJR1uyWRtWLRWmzd6T4dGVe5nRHlGB2l9MY8focd06j/17enC1F63TSL8ENothNe8LI2RL/2qNSNzmbflHzdFwpBQMmtDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Yw7F+88U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC6A7C4CEE3;
	Thu,  1 May 2025 16:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1746115230;
	bh=QdLG6Mxfeg9stM1JIO8NgkMtgfF8uSG0xcaTqwxc4jA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Yw7F+88U1p7hXmr+E/yol8oSlQWOTDSnm9TzXi8h1FFbqpY2uy2uAFQ3QubihEcrF
	 7uUDL3iQpzSMHZS6K9b5d1ec8UNQyIrfp7fUFGX3YbiFRBsdgFnrmDGt9eRlM3tqhC
	 7uaeqvAHolASbfZ/lUhfjL5Bsx7SoY2vmpYP28KI=
Date: Thu, 1 May 2025 18:00:27 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Jeff Johnson <jjohnson@kernel.org>,
	Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
	Youssef Samir <quic_yabdulra@quicinc.com>,
	Matthew Leung <quic_mattleun@quicinc.com>,
	Yan Zhen <yanzhen@vivo.com>, Alex Elder <elder@kernel.org>,
	Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
	Kunwu Chan <chentao@kylinos.cn>,
	Troy Hanson <quic_thanson@quicinc.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>, kernel@collabora.com,
	mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
	ath11k@lists.infradead.org, ath12k@lists.infradead.org
Subject: Re: [PATCH v3] bus: mhi: host: don't free bhie tables during
 suspend/hibernation
Message-ID: <2025050110-unpeeled-spur-e4af@gregkh>
References: <20250429122112.104472-1-usama.anjum@collabora.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250429122112.104472-1-usama.anjum@collabora.com>

On Tue, Apr 29, 2025 at 05:20:56PM +0500, Muhammad Usama Anjum wrote:
> Fix dma_direct_alloc() failure at resume time during bhie_table
> allocation. There is a crash report where at resume time, the memory
> from the dma doesn't get allocated and MHI fails to re-initialize.
> There is fragmentation/memory pressure.
> 
> To fix it, don't free the memory at power down during suspend /
> hibernation. Instead, use the same allocated memory again after every
> resume / hibernation. This patch has been tested with resume and
> hibernation both.
> 
> The rddm is of constant size for a given hardware. While the fbc_image
> size depends on the firmware. If the firmware changes, we'll free and
> allocate new memory for it.
> 
> Here are the crash logs:
> 
> [ 3029.338587] mhi mhi0: Requested to power ON
> [ 3029.338621] mhi mhi0: Power on setup success
> [ 3029.668654] kworker/u33:8: page allocation failure: order:7, mode:0xc04(GFP_NOIO|GFP_DMA32), nodemask=(null),cpuset=/,mems_allowed=0
> [ 3029.668682] CPU: 4 UID: 0 PID: 2744 Comm: kworker/u33:8 Not tainted 6.11.11-valve10-1-neptune-611-gb69e902b4338 #1ed779c892334112fb968aaa3facf9686b5ff0bd7
> [ 3029.668690] Hardware name: Valve Galileo/Galileo, BIOS F7G0112 08/01/2024
> [ 3029.668694] Workqueue: mhi_hiprio_wq mhi_pm_st_worker [mhi]
> [ 3029.668717] Call Trace:
> [ 3029.668722]  <TASK>
> [ 3029.668728]  dump_stack_lvl+0x4e/0x70
> [ 3029.668738]  warn_alloc+0x164/0x190
> [ 3029.668747]  ? srso_return_thunk+0x5/0x5f
> [ 3029.668754]  ? __alloc_pages_direct_compact+0xaf/0x360
> [ 3029.668761]  __alloc_pages_slowpath.constprop.0+0xc75/0xd70
> [ 3029.668774]  __alloc_pages_noprof+0x321/0x350
> [ 3029.668782]  __dma_direct_alloc_pages.isra.0+0x14a/0x290
> [ 3029.668790]  dma_direct_alloc+0x70/0x270
> [ 3029.668796]  mhi_alloc_bhie_table+0xe8/0x190 [mhi faa917c5aa23a5f5b12d6a2c597067e16d2fedc0]
> [ 3029.668814]  mhi_fw_load_handler+0x1bc/0x310 [mhi faa917c5aa23a5f5b12d6a2c597067e16d2fedc0]
> [ 3029.668830]  mhi_pm_st_worker+0x5c8/0xaa0 [mhi faa917c5aa23a5f5b12d6a2c597067e16d2fedc0]
> [ 3029.668844]  ? srso_return_thunk+0x5/0x5f
> [ 3029.668853]  process_one_work+0x17e/0x330
> [ 3029.668861]  worker_thread+0x2ce/0x3f0
> [ 3029.668868]  ? __pfx_worker_thread+0x10/0x10
> [ 3029.668873]  kthread+0xd2/0x100
> [ 3029.668879]  ? __pfx_kthread+0x10/0x10
> [ 3029.668885]  ret_from_fork+0x34/0x50
> [ 3029.668892]  ? __pfx_kthread+0x10/0x10
> [ 3029.668898]  ret_from_fork_asm+0x1a/0x30
> [ 3029.668910]  </TASK>
> 
> Tested-on: WCN6855 WLAN.HSP.1.1-03926.13-QCAHSPSWPL_V2_SILICONZ_CE-2.52297.6
> 
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

What commit id does this fix?  Should it go to stable kernel(s)?  If so,
how far back?

thanks,

greg k-h

