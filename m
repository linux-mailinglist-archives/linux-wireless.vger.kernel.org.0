Return-Path: <linux-wireless+bounces-24714-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6D51AEF4FA
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Jul 2025 12:25:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76F94442C42
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Jul 2025 10:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04FD426FDAC;
	Tue,  1 Jul 2025 10:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="p3c02I6n"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B777426F44D;
	Tue,  1 Jul 2025 10:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751365520; cv=none; b=SDy00I/6v5BECxr7Qt2BOpaLLLgOvWwCGcbttnwRFrUrNkqPt0jt/xpNHFZ9tg/IwJ2pUsMdyFpfzXQpdst9MMLwypfBpbVVKt1J2RB6Df/U42yyIJjj1VgJaxIBleN3CZDqaA5YbUrkG8qXPG5a/wrS9TQn++nCHophr6exJ4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751365520; c=relaxed/simple;
	bh=9RyQdyiAoOXQkmRKHGEM+UrK8rxs3ganX7Ohn3kLeeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q26EmS1oswNCisJP33+D3cHjJtDFGjafm6vpobbJV7fqkwbUudqY6qBCoehCMYdVSsTKJ5RymMInbIl6c72fqbuDT0Liaw0dBCjgC+1tboPZUiIZqfclLFuCLDtQYdiOcx4gBhwZfCcY/D+Dlay30FAsU4eQn/1AAVIU0clmq10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=p3c02I6n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB2DEC4CEEB;
	Tue,  1 Jul 2025 10:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751365519;
	bh=9RyQdyiAoOXQkmRKHGEM+UrK8rxs3ganX7Ohn3kLeeI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p3c02I6nM7k6XvfI/FAHAITk7ZG0eSvIsAd8bV7L9WWG3QZMpcQzHpZbcLTujugVL
	 WaNJWHECeb8JrbgVpXhBOILO5r2vMjogCUjGMwqwN987rD4E2e8t6S6Rbc5WzCGb1o
	 QUnWkvJ3lLydpiiV/k8FKbo0cgNSMtUHbLX5qAVw=
Date: Tue, 1 Jul 2025 12:25:16 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Jeff Johnson <jjohnson@kernel.org>,
	Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
	Youssef Samir <quic_yabdulra@quicinc.com>,
	Matthew Leung <quic_mattleun@quicinc.com>,
	Yan Zhen <yanzhen@vivo.com>,
	Alexander Wilhelm <alexander.wilhelm@westermo.com>,
	Alex Elder <elder@kernel.org>, Kunwu Chan <chentao@kylinos.cn>,
	Siddartha Mohanadoss <smohanad@codeaurora.org>,
	Sujeev Dias <sdias@codeaurora.org>,
	Julia Lawall <julia.lawall@lip6.fr>,
	John Crispin <john@phrozen.org>,
	Muna Sinada <quic_msinada@quicinc.com>,
	Venkateswara Naralasetty <quic_vnaralas@quicinc.com>,
	Maharaja Kennadyrajan <quic_mkenna@quicinc.com>,
	mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
	ath11k@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH 1/3] bus: mhi: host: keep bhi buffer through suspend cycle
Message-ID: <2025070143-hatchback-roundness-bec2@gregkh>
References: <20250630074330.253867-1-usama.anjum@collabora.com>
 <20250630074330.253867-2-usama.anjum@collabora.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630074330.253867-2-usama.anjum@collabora.com>

On Mon, Jun 30, 2025 at 12:43:28PM +0500, Muhammad Usama Anjum wrote:
> When there is memory pressure, at resume time dma_alloc_coherent()
> returns error which in turn fails the loading of firmware and hence
> the driver crashes:
> 
> kernel: kworker/u33:5: page allocation failure: order:7,
> mode:0xc04(GFP_NOIO|GFP_DMA32), nodemask=(null),cpuset=/,mems_allowed=0
> kernel: CPU: 1 UID: 0 PID: 7693 Comm: kworker/u33:5 Not tainted
> 6.11.11-valve17-1-neptune-611-g027868a0ac03 #1
> 3843143b92e9da0fa2d3d5f21f51beaed15c7d59

Please don't wrap kernel log lines.

> kernel: Hardware name: Valve Galileo/Galileo, BIOS F7G0112 08/01/2024
> kernel: Workqueue: mhi_hiprio_wq mhi_pm_st_worker [mhi]
> kernel: Call Trace:
> kernel:  <TASK>
> kernel:  dump_stack_lvl+0x4e/0x70
> kernel:  warn_alloc+0x164/0x190
> kernel:  ? srso_return_thunk+0x5/0x5f
> kernel:  ? __alloc_pages_direct_compact+0xaf/0x360
> kernel:  __alloc_pages_slowpath.constprop.0+0xc75/0xd70
> kernel:  __alloc_pages_noprof+0x321/0x350
> kernel:  __dma_direct_alloc_pages.isra.0+0x14a/0x290
> kernel:  dma_direct_alloc+0x70/0x270
> kernel:  mhi_fw_load_handler+0x126/0x340 [mhi
> a96cb91daba500cc77f86bad60c1f332dc3babdf]
> kernel:  mhi_pm_st_worker+0x5e8/0xac0 [mhi
> a96cb91daba500cc77f86bad60c1f332dc3babdf]

Same here.

> kernel:  ? srso_return_thunk+0x5/0x5f
> kernel:  process_one_work+0x17e/0x330
> kernel:  worker_thread+0x2ce/0x3f0
> kernel:  ? __pfx_worker_thread+0x10/0x10
> kernel:  kthread+0xd2/0x100
> kernel:  ? __pfx_kthread+0x10/0x10
> kernel:  ret_from_fork+0x34/0x50
> kernel:  ? __pfx_kthread+0x10/0x10
> kernel:  ret_from_fork_asm+0x1a/0x30
> kernel:  </TASK>
> kernel: Mem-Info:
> kernel: active_anon:513809 inactive_anon:152 isolated_anon:0
>     active_file:359315 inactive_file:2487001 isolated_file:0
>     unevictable:637 dirty:19 writeback:0
>     slab_reclaimable:160391 slab_unreclaimable:39729
>     mapped:175836 shmem:51039 pagetables:4415
>     sec_pagetables:0 bounce:0
>     kernel_misc_reclaimable:0
>     free:125666 free_pcp:0 free_cma:0
> 
> In above example, if we sum all the consumed memory, it comes out
> to be 15.5GB and free memory is ~ 500MB from a total of 16GB RAM.
> Even though memory is present. But all of the dma memory has been
> exhausted or fragmented.
> 
> Fix it by allocating it only once and then reuse the same allocated
> memory. As we'll allocate this memory only once, this memory will stay
> allocated.
> 
> Tested-on: WCN6855 WLAN.HSP.1.1-03926.13-QCAHSPSWPL_V2_SILICONZ_CE-2.52297.6
> 
> Fixes: cd457afb1667 ("bus: mhi: core: Add support for downloading firmware over BHIe")

No cc: stable?

> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
> Reported here:
> https://lore.kernel.org/all/ead32f5b-730a-4b81-b38f-93d822f990c6@collabora.com
> 
> Still a lot of more fixes are required. Hence, I'm not adding closes tag.
> ---
>  drivers/bus/mhi/host/boot.c     | 19 ++++++++++---------
>  drivers/bus/mhi/host/init.c     |  5 +++++
>  drivers/bus/mhi/host/internal.h |  2 ++
>  include/linux/mhi.h             |  1 +
>  4 files changed, 18 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/bus/mhi/host/boot.c b/drivers/bus/mhi/host/boot.c
> index b3a85aa3c4768..11bb8c12ac597 100644
> --- a/drivers/bus/mhi/host/boot.c
> +++ b/drivers/bus/mhi/host/boot.c
> @@ -302,8 +302,8 @@ static int mhi_fw_load_bhi(struct mhi_controller *mhi_cntrl,
>  	return -EIO;
>  }
>  
> -static void mhi_free_bhi_buffer(struct mhi_controller *mhi_cntrl,
> -				struct image_info *image_info)
> +void mhi_free_bhi_buffer(struct mhi_controller *mhi_cntrl,
> +			 struct image_info *image_info)
>  {
>  	struct mhi_buf *mhi_buf = image_info->mhi_buf;
>  
> @@ -455,18 +455,19 @@ static enum mhi_fw_load_type mhi_fw_load_type_get(const struct mhi_controller *m
>  
>  static int mhi_load_image_bhi(struct mhi_controller *mhi_cntrl, const u8 *fw_data, size_t size)
>  {
> -	struct image_info *image;
> +	struct image_info *image = mhi_cntrl->bhi_image;
>  	int ret;
>  
> -	ret = mhi_alloc_bhi_buffer(mhi_cntrl, &image, size);
> -	if (ret)
> -		return ret;
> +	if (!image) {

What prevents image from going away right after you tested it?

thanks,

greg k-h

