Return-Path: <linux-wireless+bounces-24769-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E48B4AF5CDF
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Jul 2025 17:26:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C60BF16B927
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Jul 2025 15:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 316FF2D9485;
	Wed,  2 Jul 2025 15:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b="arvctNSY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5583327FD6E;
	Wed,  2 Jul 2025 15:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751469976; cv=pass; b=Tq4rtar0PNX3C4+jp1OF1iaHea31opNBUao6q8KleBym9pRyrNHeu/Id6eiZF1+6O9CODrFg9hlDA0KVjmcT40NTcKs8rRrQE1H9gh/w+edPqHL4iO99nRpHdsIYNhxCALyIMkEFdhKae0tyN8SD29drXLsrB7YarzFKmq7iR+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751469976; c=relaxed/simple;
	bh=wQMRoNUnzA9UQB2mB3kuixYX3T0g/KtNqFHwiGUze28=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GNj6G3R/2bOHpCzUKj0+ltsDIslpMEq1/NvIU+/Rtj+XPuBn2Rm4h7aJdZkqaGQs+YjVVXt1Asn6awmRRU16XmTtd+Pt3E5sRnOZB3tyZHe7txzsDhZpQeyA7hCW4BwSKfOcYcUmDTrj48+O6zbsubrccAO0u2h9pVVbKxW4pm8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b=arvctNSY; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1751469894; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=WpmPIDERd62a9YcFDQAaOKN47Tzg/1JmdIjZoGY86x5IWb2DWIs3zTuR9ILYtqEaD/UmXiSsHKy1CZNmVwil0Qxdf6KbIHUqODsUQ2jRLym08lxff3GowMQUqjm/VdGs0SJdu0zvH9lBE2hsh0crhY7aFDyTPr0liefQtd2Mup4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1751469894; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=4NVWTCsF8+Y+0HyJZ6iLTeR9+84JjIwIGI7caUUiPfk=; 
	b=WTzsVjl8qqQSkPWxm1e1GRZ7vEwVgSeL0jVkZu28Tnz0+WvsjDxEAPHx5DgHvZ/dKXps2gNsK0WbUmgeomIkfShSUmeRPykOI/qr0WCqCDZXi6jzRbSW/ednvlGGall3A0KWJ+hNP1C0fXnKNxtuhZvJHIm2vEUh4hEbo7i+V60=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=usama.anjum@collabora.com;
	dmarc=pass header.from=<usama.anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1751469894;
	s=zohomail; d=collabora.com; i=usama.anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=4NVWTCsF8+Y+0HyJZ6iLTeR9+84JjIwIGI7caUUiPfk=;
	b=arvctNSYqPEhFDsNKsyUzPBgo0Wwowa+zYdl8u38k47zPbYrUyIh6AWxkbB20cD+
	arRZkRv/dcTwSJF77HtG7MhRcw9Z825S2H33xcMx/6nIEIkNlUHkmonv3tCWixyX6U6
	+VTlJonTyp6NpNZWKLc9tKj+XkDUsNOQ/9NLFsv4=
Received: by mx.zohomail.com with SMTPS id 1751469891448470.8632580255727;
	Wed, 2 Jul 2025 08:24:51 -0700 (PDT)
Message-ID: <2df35ac2-34f6-4552-8630-5fe380bbdba4@collabora.com>
Date: Wed, 2 Jul 2025 20:24:45 +0500
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] bus: mhi: host: keep bhi buffer through suspend cycle
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
 Jeff Johnson <jjohnson@kernel.org>, Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
 Youssef Samir <quic_yabdulra@quicinc.com>,
 Matthew Leung <quic_mattleun@quicinc.com>, Yan Zhen <yanzhen@vivo.com>,
 Alexander Wilhelm <alexander.wilhelm@westermo.com>,
 Alex Elder <elder@kernel.org>, Kunwu Chan <chentao@kylinos.cn>,
 Siddartha Mohanadoss <smohanad@codeaurora.org>,
 Sujeev Dias <sdias@codeaurora.org>, Julia Lawall <julia.lawall@lip6.fr>,
 John Crispin <john@phrozen.org>, Muna Sinada <quic_msinada@quicinc.com>,
 Venkateswara Naralasetty <quic_vnaralas@quicinc.com>,
 Maharaja Kennadyrajan <quic_mkenna@quicinc.com>, mhi@lists.linux.dev,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
 kernel@collabora.com
References: <20250630074330.253867-1-usama.anjum@collabora.com>
 <20250630074330.253867-2-usama.anjum@collabora.com>
 <2025070143-hatchback-roundness-bec2@gregkh>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <2025070143-hatchback-roundness-bec2@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

Thanks for reviewing!

On 7/1/25 3:25 PM, Greg Kroah-Hartman wrote:
> On Mon, Jun 30, 2025 at 12:43:28PM +0500, Muhammad Usama Anjum wrote:
>> When there is memory pressure, at resume time dma_alloc_coherent()
>> returns error which in turn fails the loading of firmware and hence
>> the driver crashes:
>>
>> kernel: kworker/u33:5: page allocation failure: order:7,
>> mode:0xc04(GFP_NOIO|GFP_DMA32), nodemask=(null),cpuset=/,mems_allowed=0
>> kernel: CPU: 1 UID: 0 PID: 7693 Comm: kworker/u33:5 Not tainted
>> 6.11.11-valve17-1-neptune-611-g027868a0ac03 #1
>> 3843143b92e9da0fa2d3d5f21f51beaed15c7d59
> 
> Please don't wrap kernel log lines.
Sorry, missed fixing it. I'll fix it.

> 
>> kernel: Hardware name: Valve Galileo/Galileo, BIOS F7G0112 08/01/2024
>> kernel: Workqueue: mhi_hiprio_wq mhi_pm_st_worker [mhi]
>> kernel: Call Trace:
>> kernel:  <TASK>
>> kernel:  dump_stack_lvl+0x4e/0x70
>> kernel:  warn_alloc+0x164/0x190
>> kernel:  ? srso_return_thunk+0x5/0x5f
>> kernel:  ? __alloc_pages_direct_compact+0xaf/0x360
>> kernel:  __alloc_pages_slowpath.constprop.0+0xc75/0xd70
>> kernel:  __alloc_pages_noprof+0x321/0x350
>> kernel:  __dma_direct_alloc_pages.isra.0+0x14a/0x290
>> kernel:  dma_direct_alloc+0x70/0x270
>> kernel:  mhi_fw_load_handler+0x126/0x340 [mhi
>> a96cb91daba500cc77f86bad60c1f332dc3babdf]
>> kernel:  mhi_pm_st_worker+0x5e8/0xac0 [mhi
>> a96cb91daba500cc77f86bad60c1f332dc3babdf]
> 
> Same here.
I'll fix it.

> 
>> kernel:  ? srso_return_thunk+0x5/0x5f
>> kernel:  process_one_work+0x17e/0x330
>> kernel:  worker_thread+0x2ce/0x3f0
>> kernel:  ? __pfx_worker_thread+0x10/0x10
>> kernel:  kthread+0xd2/0x100
>> kernel:  ? __pfx_kthread+0x10/0x10
>> kernel:  ret_from_fork+0x34/0x50
>> kernel:  ? __pfx_kthread+0x10/0x10
>> kernel:  ret_from_fork_asm+0x1a/0x30
>> kernel:  </TASK>
>> kernel: Mem-Info:
>> kernel: active_anon:513809 inactive_anon:152 isolated_anon:0
>>     active_file:359315 inactive_file:2487001 isolated_file:0
>>     unevictable:637 dirty:19 writeback:0
>>     slab_reclaimable:160391 slab_unreclaimable:39729
>>     mapped:175836 shmem:51039 pagetables:4415
>>     sec_pagetables:0 bounce:0
>>     kernel_misc_reclaimable:0
>>     free:125666 free_pcp:0 free_cma:0
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
> 
> No cc: stable?
I'll add stable in v2.

> 
>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>> ---
>> Reported here:
>> https://lore.kernel.org/all/ead32f5b-730a-4b81-b38f-93d822f990c6@collabora.com
>>
>> Still a lot of more fixes are required. Hence, I'm not adding closes tag.
>> ---
>>  drivers/bus/mhi/host/boot.c     | 19 ++++++++++---------
>>  drivers/bus/mhi/host/init.c     |  5 +++++
>>  drivers/bus/mhi/host/internal.h |  2 ++
>>  include/linux/mhi.h             |  1 +
>>  4 files changed, 18 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/bus/mhi/host/boot.c b/drivers/bus/mhi/host/boot.c
>> index b3a85aa3c4768..11bb8c12ac597 100644
>> --- a/drivers/bus/mhi/host/boot.c
>> +++ b/drivers/bus/mhi/host/boot.c
>> @@ -302,8 +302,8 @@ static int mhi_fw_load_bhi(struct mhi_controller *mhi_cntrl,
>>  	return -EIO;
>>  }
>>  
>> -static void mhi_free_bhi_buffer(struct mhi_controller *mhi_cntrl,
>> -				struct image_info *image_info)
>> +void mhi_free_bhi_buffer(struct mhi_controller *mhi_cntrl,
>> +			 struct image_info *image_info)
>>  {
>>  	struct mhi_buf *mhi_buf = image_info->mhi_buf;
>>  
>> @@ -455,18 +455,19 @@ static enum mhi_fw_load_type mhi_fw_load_type_get(const struct mhi_controller *m
>>  
>>  static int mhi_load_image_bhi(struct mhi_controller *mhi_cntrl, const u8 *fw_data, size_t size)
>>  {
>> -	struct image_info *image;
>> +	struct image_info *image = mhi_cntrl->bhi_image;
>>  	int ret;
>>  
>> -	ret = mhi_alloc_bhi_buffer(mhi_cntrl, &image, size);
>> -	if (ret)
>> -		return ret;
>> +	if (!image) {
> 
> What prevents image from going away right after you tested it?
The changed code isn't doing what it should be doing. I'll completely fix in v2. 

> 
> thanks,
> 
> greg k-h


