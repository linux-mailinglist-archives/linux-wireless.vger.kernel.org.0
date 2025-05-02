Return-Path: <linux-wireless+bounces-22318-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F2AAA6A08
	for <lists+linux-wireless@lfdr.de>; Fri,  2 May 2025 07:06:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5017D7B6AB5
	for <lists+linux-wireless@lfdr.de>; Fri,  2 May 2025 05:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3728D19DF5B;
	Fri,  2 May 2025 05:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fh9i/ey0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A014C8E;
	Fri,  2 May 2025 05:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746162396; cv=none; b=IhorzqUB8o8E4bUubBO9kv5zvrYmICa9qasyAPSnV7zIZ7cKJaaM41QeqWbbOEFY7WMGuGXVwnqmSgYzG++zA+VMhuGuiMaA4ww2dqaVJw8V33LtV0kd57adSVWBNUhBl/oxHw5IX+acCj5es3MY0+g3Vt0UB/tMYAiW+PhhbBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746162396; c=relaxed/simple;
	bh=9JE4pYtNWB/SHJMFnYwXCS9E2BpkOQ7Sf7/0bWmnk0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B1CRun7ueuX7XPr8TNGXGxYS5aoW+WFHHzP5HCBSKzBb1LFGWquu3w0w5dDUL7nj347fPvE5bYomr+aHtHrc4JvRkj7Sgbp3jywoHZNiYhF89WyQbH5iQP9ojZY/TqRRuLtyjn3iinYlanPnHVmj6rwfQ4wDoZIXaf/qG6r0blo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fh9i/ey0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A66DC4CEE4;
	Fri,  2 May 2025 05:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1746162393;
	bh=9JE4pYtNWB/SHJMFnYwXCS9E2BpkOQ7Sf7/0bWmnk0E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fh9i/ey0MG5Weu9XsA3P2apGoeurMNEyuRXvRw4bhLKJ9XQxC1k4KD7swj2C8saoM
	 Yan7v+d3C+4wiN7A/9DqilGy28/yB/+Md9s3tSsXBOwdlo80r8EfyabcboJIKbnhVh
	 K0hL1IafBJKqjRnBoE/RRG+onqDVn5tqWc0C31VE=
Date: Fri, 2 May 2025 07:06:30 +0200
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
Message-ID: <2025050254-astride-grapple-797e@gregkh>
References: <20250429122112.104472-1-usama.anjum@collabora.com>
 <2025050110-unpeeled-spur-e4af@gregkh>
 <bdc89d09-ce50-43a4-9043-3ca6a9245eb4@collabora.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bdc89d09-ce50-43a4-9043-3ca6a9245eb4@collabora.com>

On Fri, May 02, 2025 at 09:15:10AM +0500, Muhammad Usama Anjum wrote:
> Hi Greg,
> 
> On 5/1/25 9:00 PM, Greg Kroah-Hartman wrote:
> > On Tue, Apr 29, 2025 at 05:20:56PM +0500, Muhammad Usama Anjum wrote:
> >> Fix dma_direct_alloc() failure at resume time during bhie_table
> >> allocation. There is a crash report where at resume time, the memory
> >> from the dma doesn't get allocated and MHI fails to re-initialize.
> >> There is fragmentation/memory pressure.
> >>
> >> To fix it, don't free the memory at power down during suspend /
> >> hibernation. Instead, use the same allocated memory again after every
> >> resume / hibernation. This patch has been tested with resume and
> >> hibernation both.
> >>
> >> The rddm is of constant size for a given hardware. While the fbc_image
> >> size depends on the firmware. If the firmware changes, we'll free and
> >> allocate new memory for it.
> >>
> >> Here are the crash logs:
> >>
> >> [ 3029.338587] mhi mhi0: Requested to power ON
> >> [ 3029.338621] mhi mhi0: Power on setup success
> >> [ 3029.668654] kworker/u33:8: page allocation failure: order:7, mode:0xc04(GFP_NOIO|GFP_DMA32), nodemask=(null),cpuset=/,mems_allowed=0
> >> [ 3029.668682] CPU: 4 UID: 0 PID: 2744 Comm: kworker/u33:8 Not tainted 6.11.11-valve10-1-neptune-611-gb69e902b4338 #1ed779c892334112fb968aaa3facf9686b5ff0bd7
> >> [ 3029.668690] Hardware name: Valve Galileo/Galileo, BIOS F7G0112 08/01/2024
> >> [ 3029.668694] Workqueue: mhi_hiprio_wq mhi_pm_st_worker [mhi]
> >> [ 3029.668717] Call Trace:
> >> [ 3029.668722]  <TASK>
> >> [ 3029.668728]  dump_stack_lvl+0x4e/0x70
> >> [ 3029.668738]  warn_alloc+0x164/0x190
> >> [ 3029.668747]  ? srso_return_thunk+0x5/0x5f
> >> [ 3029.668754]  ? __alloc_pages_direct_compact+0xaf/0x360
> >> [ 3029.668761]  __alloc_pages_slowpath.constprop.0+0xc75/0xd70
> >> [ 3029.668774]  __alloc_pages_noprof+0x321/0x350
> >> [ 3029.668782]  __dma_direct_alloc_pages.isra.0+0x14a/0x290
> >> [ 3029.668790]  dma_direct_alloc+0x70/0x270
> >> [ 3029.668796]  mhi_alloc_bhie_table+0xe8/0x190 [mhi faa917c5aa23a5f5b12d6a2c597067e16d2fedc0]
> >> [ 3029.668814]  mhi_fw_load_handler+0x1bc/0x310 [mhi faa917c5aa23a5f5b12d6a2c597067e16d2fedc0]
> >> [ 3029.668830]  mhi_pm_st_worker+0x5c8/0xaa0 [mhi faa917c5aa23a5f5b12d6a2c597067e16d2fedc0]
> >> [ 3029.668844]  ? srso_return_thunk+0x5/0x5f
> >> [ 3029.668853]  process_one_work+0x17e/0x330
> >> [ 3029.668861]  worker_thread+0x2ce/0x3f0
> >> [ 3029.668868]  ? __pfx_worker_thread+0x10/0x10
> >> [ 3029.668873]  kthread+0xd2/0x100
> >> [ 3029.668879]  ? __pfx_kthread+0x10/0x10
> >> [ 3029.668885]  ret_from_fork+0x34/0x50
> >> [ 3029.668892]  ? __pfx_kthread+0x10/0x10
> >> [ 3029.668898]  ret_from_fork_asm+0x1a/0x30
> >> [ 3029.668910]  </TASK>
> >>
> >> Tested-on: WCN6855 WLAN.HSP.1.1-03926.13-QCAHSPSWPL_V2_SILICONZ_CE-2.52297.6
> >>
> >> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> > 
> > What commit id does this fix?  Should it go to stable kernel(s)?  If so,
> > how far back?
> This patch is fixing the dma_coherent_alloc() failure when there is
> memory pressure and its unable to allocate memory. Its not a bug in
> allocation API or the driver. I think it should be considered an
> improvement instead of the fix. Please correct me if I'm wrong.

You show a kernel crash in the changelog, that's a major issue (i.e.
will get assigned a CVE), so you need to show what commit id it fixes
for people to know how far back to take the fix to.

thanks,

greg k-h

