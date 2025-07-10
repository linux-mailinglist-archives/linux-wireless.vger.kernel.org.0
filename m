Return-Path: <linux-wireless+bounces-25179-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E0BB004E7
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 16:16:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59B25486B5F
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 14:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F339D27056B;
	Thu, 10 Jul 2025 14:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b="OIDPkdGX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049A8231A24;
	Thu, 10 Jul 2025 14:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752156944; cv=pass; b=DRHq9dtcO5+mEYaUySW3PK9LzWD7wNawODkoQbem7wxIurpaCUNom5Z4gRDEu6XPehbL0h7j4jEMe2PHcEJgi/hQt1pEHYKU4fez4ehm0wo69i+F5Rfv9VFBrlG44ocmD2HnLmgM+E+HiLbIXa40lAZOfQWMYereCxWRM2eCa+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752156944; c=relaxed/simple;
	bh=VkWIov4pncN1CxRUjWnTedpZphrnmnhBJGxO59cUQio=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n2CQrgplkTih2p4fEEmR0nElUcznkLn245ObJbRF1vHfJR4RRvbBh8ObswkBTzAOEMH3zQhxNTR3y7r+hAvb4l3qBnmyz+sYhH+CmzBGPBkbdpxympvPUcR1Q6v055HhvdzUVjF4wxUUPe5jXwBr8WmhQSDfyGpe3YJ9wd1fclY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b=OIDPkdGX; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1752156866; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=BxbU6/hBdzFK5J83uPrxiRnMJK5DwDubdmhCFsE8xTFJLhOQwhMIoE0J/wBnyQyVlNelxEurbeyG3Xb5KTEPiBLS8OuGd9aH4/YeNeOF16WOmHfai83x8rCj2fNCFcM8D0abUMGw+4K606NNNvOwossKZ2ZMZhpe21y84FzzmbQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1752156866; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=+Bd1ScZrM2JC5+XfTmUMVfKPSMOMu2+hKdobUpn9uAo=; 
	b=AWvkfaannUwK9VBk/+ID3M8INlNR+LiGkN7SOXEEnqmMuDP4zI3T+5yxF6efYDCxhR+Z8TG8xY5n450grEiA0kOdZ/E3Nz80+CF01Blo8mcW30Zc5SpF8UpJdaUFNybrwuCMUjWqAScmFQb47e2MLe3O+kweM9JCdjLvuO2frAU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=usama.anjum@collabora.com;
	dmarc=pass header.from=<usama.anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1752156866;
	s=zohomail; d=collabora.com; i=usama.anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=+Bd1ScZrM2JC5+XfTmUMVfKPSMOMu2+hKdobUpn9uAo=;
	b=OIDPkdGXgEeMzXE5rpruOGW/k17fl/ejoogEYAs4cEaibKURNF8jt9+ONc15Ma8w
	ynSLNOGF5peSetDKVHK6VxLJi/C1EuJNxkmowaFbwvPQuPK8ez2Ud3aSag9e1SxQypg
	MVpEQC+ZI+L9/HgMSDY9Yc3FhtnaiQxRiVysRfBA=
Received: by mx.zohomail.com with SMTPS id 1752156862699411.0438114787785;
	Thu, 10 Jul 2025 07:14:22 -0700 (PDT)
Message-ID: <d4e9f38b-895e-45ea-90db-3c2839c76c70@collabora.com>
Date: Thu, 10 Jul 2025 19:14:15 +0500
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] bus: mhi: host: keep bhi buffer through suspend cycle
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
 Manivannan Sadhasivam <mani@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
 Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
 Youssef Samir <quic_yabdulra@quicinc.com>,
 Matthew Leung <quic_mattleun@quicinc.com>, Yan Zhen <yanzhen@vivo.com>,
 Alexander Wilhelm <alexander.wilhelm@westermo.com>,
 Alex Elder <elder@kernel.org>, Kunwu Chan <chentao@kylinos.cn>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Siddartha Mohanadoss <smohanad@codeaurora.org>,
 Sujeev Dias <sdias@codeaurora.org>, Julia Lawall <julia.lawall@lip6.fr>,
 John Crispin <john@phrozen.org>, Muna Sinada <quic_msinada@quicinc.com>,
 Venkateswara Naralasetty <quic_vnaralas@quicinc.com>,
 Maharaja Kennadyrajan <quic_mkenna@quicinc.com>, mhi@lists.linux.dev,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
Cc: kernel@collabora.com
References: <20250630074330.253867-1-usama.anjum@collabora.com>
 <20250630074330.253867-2-usama.anjum@collabora.com>
 <b76cfe82-b977-4166-85d8-368539b392fd@oss.qualcomm.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <b76cfe82-b977-4166-85d8-368539b392fd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Thank you so much for review.

On 7/8/25 2:47 PM, Krishna Chaitanya Chundru wrote:
> 
> 
> On 6/30/2025 1:13 PM, Muhammad Usama Anjum wrote:
>> When there is memory pressure, at resume time dma_alloc_coherent()
>> returns error which in turn fails the loading of firmware and hence
>> the driver crashes:
>>
> why only bhi? bhie can also have same issue.
I was thinking I'd handled all bhie cases in earlier patch. But I haven't. I'll post
fix for bhie in next version.

>> kernel: kworker/u33:5: page allocation failure: order:7,
>> mode:0xc04(GFP_NOIO|GFP_DMA32), nodemask=(null),cpuset=/,mems_allowed=0
>> kernel: CPU: 1 UID: 0 PID: 7693 Comm: kworker/u33:5 Not tainted
>> 6.11.11-valve17-1-neptune-611-g027868a0ac03 #1
>> 3843143b92e9da0fa2d3d5f21f51beaed15c7d59
>> kernel: Hardware name: Valve Galileo/Galileo, BIOS F7G0112 08/01/2024
>> kernel: Workqueue: mhi_hiprio_wq mhi_pm_st_worker [mhi]
>> kernel: Call Trace:
>> kernel:  <TASK>
>> kernel:  dump_stack_lvl+0x4e/0x70
>> kernel:  warn_alloc+0x164/0x190
>> kernel:  ? srso_return_thunk+0x5/0x5f
>> kernel:  ? __alloc_pages_direct_compact+0xaf/0x360
>> kernel:  __alloc_pages_slowpath.constprop.0+0xc75/0xd70
>> kernel:  __alloc_pages_noprof+0x321/0x350
>> kernel:  __dma_direct_alloc_pages.isra.0+0x14a/0x290
>> kernel:  dma_direct_alloc+0x70/0x270
>> kernel:  mhi_fw_load_handler+0x126/0x340 [mhi
>> a96cb91daba500cc77f86bad60c1f332dc3babdf]
>> kernel:  mhi_pm_st_worker+0x5e8/0xac0 [mhi
>> a96cb91daba500cc77f86bad60c1f332dc3babdf]
>> kernel:  ? srso_return_thunk+0x5/0x5f
>> kernel:  process_one_work+0x17e/0x330
>> kernel:  worker_thread+0x2ce/0x3f0
>> kernel:  ? __pfx_worker_thread+0x10/0x10
>> kernel:  kthread+0xd2/0x100
>> kernel:  ? __pfx_kthread+0x10/0x10
>> kernel:  ret_from_fork+0x34/0x50
>> kernel:  ? __pfx_kthread+0x10/0x10
>> kernel:  ret_from_fork_asm+0x1a/0x30
>> kernel:  </TASK>
>> kernel: Mem-Info:
>> kernel: active_anon:513809 inactive_anon:152 isolated_anon:0
>>      active_file:359315 inactive_file:2487001 isolated_file:0
>>      unevictable:637 dirty:19 writeback:0
>>      slab_reclaimable:160391 slab_unreclaimable:39729
>>      mapped:175836 shmem:51039 pagetables:4415
>>      sec_pagetables:0 bounce:0
>>      kernel_misc_reclaimable:0
>>      free:125666 free_pcp:0 free_cma:0
>>
>> In above example, if we sum all the consumed memory, it comes out
>> to be 15.5GB and free memory is ~ 500MB from a total of 16GB RAM.
>> Even though memory is present. But all of the dma memory has been
>> exhausted or fragmented.
>>
>> Fix it by allocating it only once and then reuse the same allocated
>> memory. As we'll allocate this memory only once, this memory will stay
>> allocated.
>>
>> Tested-on: WCN6855 WLAN.HSP.1.1-03926.13-QCAHSPSWPL_V2_SILICONZ_CE-2.52297.6
>>
>> Fixes: cd457afb1667 ("bus: mhi: core: Add support for downloading firmware over BHIe")
>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>> ---
>> Reported here:
>> https://lore.kernel.org/all/ead32f5b-730a-4b81-b38f-93d822f990c6@collabora.com
>>
>> Still a lot of more fixes are required. Hence, I'm not adding closes tag.
>> ---
>>   drivers/bus/mhi/host/boot.c     | 19 ++++++++++---------
>>   drivers/bus/mhi/host/init.c     |  5 +++++
>>   drivers/bus/mhi/host/internal.h |  2 ++
>>   include/linux/mhi.h             |  1 +
>>   4 files changed, 18 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/bus/mhi/host/boot.c b/drivers/bus/mhi/host/boot.c
>> index b3a85aa3c4768..11bb8c12ac597 100644
>> --- a/drivers/bus/mhi/host/boot.c
>> +++ b/drivers/bus/mhi/host/boot.c
>> @@ -302,8 +302,8 @@ static int mhi_fw_load_bhi(struct mhi_controller *mhi_cntrl,
>>       return -EIO;
>>   }
>>   -static void mhi_free_bhi_buffer(struct mhi_controller *mhi_cntrl,
>> -                struct image_info *image_info)
>> +void mhi_free_bhi_buffer(struct mhi_controller *mhi_cntrl,
>> +             struct image_info *image_info)
>>   {
>>       struct mhi_buf *mhi_buf = image_info->mhi_buf;
>>   @@ -455,18 +455,19 @@ static enum mhi_fw_load_type mhi_fw_load_type_get(const struct mhi_controller *m
>>     static int mhi_load_image_bhi(struct mhi_controller *mhi_cntrl, const u8 *fw_data, size_t size)
>>   {
>> -    struct image_info *image;
>> +    struct image_info *image = mhi_cntrl->bhi_image;
>>       int ret;
>>   -    ret = mhi_alloc_bhi_buffer(mhi_cntrl, &image, size);
>> -    if (ret)
>> -        return ret;
>> +    if (!image) {
>> +        ret = mhi_alloc_bhi_buffer(mhi_cntrl, &image, size);
>> +        if (ret)
>> +            return ret;
>>   -    /* Load the firmware into BHI vec table */
>> -    memcpy(image->mhi_buf->buf, fw_data, size);
>> +        /* Load the firmware into BHI vec table */
>> +        memcpy(image->mhi_buf->buf, fw_data, size);
>> +    }
>>         ret = mhi_fw_load_bhi(mhi_cntrl, &image->mhi_buf[image->entries - 1]);
> if mhi fw load fails didn't we need to free bhi buffer.
Good point. I'll fix in v2.


