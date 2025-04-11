Return-Path: <linux-wireless+bounces-21431-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6B2A854E7
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Apr 2025 09:03:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DFD07A84E2
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Apr 2025 07:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00CFC1E9B38;
	Fri, 11 Apr 2025 07:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b="dcZ00M8/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18481372;
	Fri, 11 Apr 2025 07:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744355032; cv=pass; b=VjYecKd6mPtB0mXChtwhbyfD5mNWUBUn9JzTzbCsf/cJ3Afv+96BWtNA7FxDuEjwDlUa2tO5Mn1rTtA6ym+e/kYTPNKxzRqbnaoNHO4S07Ekgw6clXxwsfJVp2oTNANjIKnGzJJ5xxO0JqlbgLTMtjtYvyJk92DSXlGEhnevIWc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744355032; c=relaxed/simple;
	bh=pDh/Z2P2+afoqaSc2VW1inIVZr8To+m7Y5rZeW92KNs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u2m9OXd2DdupyCplOZ4XM784ZbbVN7gVcAt2JIfG7UuMuJW0JTQoD+ouPaMHS3WKhs77Pv6t+WXGydDlwNsSEzJYXVwqxSFBFVHZMrkIc9vptnPTyt9Cc0hPf/Uo7+YS+kUQttdbKHXhD5gyiBP8b+zUQFPssnl2hpy8zLEUcmY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b=dcZ00M8/; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1744354975; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=M+yp07Gk7WNCsUFMKFghOIUqq5nlvDX0lUZrZEvktdM14+kGYdhHBGDNRwkDzx1CTmdfsG/KJGr8ux8iG9Qg4Jl5tCG6/WB7cACvev/eac5Zt7nNK3PCRbJc6WnEBVmqTZpR6iurtqvnPPhmN11j0SjHRxZB0FyCgHhZue6uPUE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1744354975; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=2zPPDni+SN4aNv4ehP5vMPoh9AnuieE+EM0hjqT77a8=; 
	b=DShuyARTQBdwCf4a8aOQv305HDh2W5EgbUsCxyHUeohOxkKz/T/heL6SF0kBI//Ub48/1Y5ropqLgGoeZrQ1upv9p0KGnoQNBp2hCbUGHXJ1YQsAgys+ASbOAjj/uccqgeDYB5XCmiKSgtMc8jUsuk3Bm0vq3vZb2UxJsIZl3dg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=usama.anjum@collabora.com;
	dmarc=pass header.from=<usama.anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1744354975;
	s=zohomail; d=collabora.com; i=usama.anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=2zPPDni+SN4aNv4ehP5vMPoh9AnuieE+EM0hjqT77a8=;
	b=dcZ00M8/4snmUh040m/o/LSZ+Tj9AOVl6ONjlSuHmbWLME8z4o+GMwig7QJjzofu
	Kt/PXz3VBBf9JVZRqNY7XrKBl2aU9ZYdMsD8RHlA+rqLhQ833Tb4uGgwKfEPvTR5mt6
	39msYPeC6FYc1CaB9UHYVSk1lzfZzhcyCtV/laWc=
Received: by mx.zohomail.com with SMTPS id 1744354973824408.0624420135464;
	Fri, 11 Apr 2025 00:02:53 -0700 (PDT)
Message-ID: <fc9ca0da-9f6a-42b5-aa79-abcd43c97043@collabora.com>
Date: Fri, 11 Apr 2025 12:02:44 +0500
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] bus: mhi: host: don't free bhie tables during
 suspend/hibernation
To: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Johannes Berg <johannes@sipsolutions.net>, Jeff Johnson
 <jjohnson@kernel.org>, Jeffrey Hugo <quic_jhugo@quicinc.com>,
 Yan Zhen <yanzhen@vivo.com>, Youssef Samir <quic_yabdulra@quicinc.com>,
 Qiang Yu <quic_qianyu@quicinc.com>, Alex Elder <elder@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Kunwu Chan <chentao@kylinos.cn>
Cc: kernel@collabora.com, mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
 ath11k@lists.infradead.org
References: <20250410145704.207969-1-usama.anjum@collabora.com>
 <ba09ae0c-fe8d-8f4e-a1b8-9c7e5913c84e@quicinc.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <ba09ae0c-fe8d-8f4e-a1b8-9c7e5913c84e@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

On 4/11/25 8:37 AM, Krishna Chaitanya Chundru wrote:
> 
> 
> On 4/10/2025 8:26 PM, Muhammad Usama Anjum wrote:
>> Fix dma_direct_alloc() failure at resume time during bhie_table
>> allocation. There is a crash report where at resume time, the memory
>> from the dma doesn't get allocated and MHI fails to re-initialize.
>> There may be fragmentation of some kind which fails the allocation
>> call.
>>
>> To fix it, don't free the memory at power down during suspend /
>> hibernation. Instead, use the same allocated memory again after every
>> resume / hibernation. This patch has been tested with resume and
>> hibernation both.
>>
>> The rddm is of constant size for a given hardware. While the fbc_image
>> size depends on the firmware. If the firmware changes, we'll free and
> If firmware image will change between suspend and resume ?
Yes, correct.

>> allocate new memory for it.
>>
>> Here are the crash logs:
>>
>> [ 3029.338587] mhi mhi0: Requested to power ON
>> [ 3029.338621] mhi mhi0: Power on setup success
>> [ 3029.668654] kworker/u33:8: page allocation failure: order:7,
>> mode:0xc04(GFP_NOIO|GFP_DMA32), nodemask=(null),cpuset=/,mems_allowed=0
>> [ 3029.668682] CPU: 4 UID: 0 PID: 2744 Comm: kworker/u33:8 Not tainted
>> 6.11.11-valve10-1-neptune-611-gb69e902b4338
>> #1ed779c892334112fb968aaa3facf9686b5ff0bd7
>> [ 3029.668690] Hardware name: Valve Galileo/Galileo, BIOS F7G0112
>> 08/01/2024
>> [ 3029.668694] Workqueue: mhi_hiprio_wq mhi_pm_st_worker [mhi]
>> [ 3029.668717] Call Trace:
>> [ 3029.668722]  <TASK>
>> [ 3029.668728]  dump_stack_lvl+0x4e/0x70
>> [ 3029.668738]  warn_alloc+0x164/0x190
>> [ 3029.668747]  ? srso_return_thunk+0x5/0x5f
>> [ 3029.668754]  ? __alloc_pages_direct_compact+0xaf/0x360
>> [ 3029.668761]  __alloc_pages_slowpath.constprop.0+0xc75/0xd70
>> [ 3029.668774]  __alloc_pages_noprof+0x321/0x350
>> [ 3029.668782]  __dma_direct_alloc_pages.isra.0+0x14a/0x290
>> [ 3029.668790]  dma_direct_alloc+0x70/0x270
>> [ 3029.668796]  mhi_alloc_bhie_table+0xe8/0x190 [mhi
>> faa917c5aa23a5f5b12d6a2c597067e16d2fedc0]
>> [ 3029.668814]  mhi_fw_load_handler+0x1bc/0x310 [mhi
>> faa917c5aa23a5f5b12d6a2c597067e16d2fedc0]
>> [ 3029.668830]  mhi_pm_st_worker+0x5c8/0xaa0 [mhi
>> faa917c5aa23a5f5b12d6a2c597067e16d2fedc0]
>> [ 3029.668844]  ? srso_return_thunk+0x5/0x5f
>> [ 3029.668853]  process_one_work+0x17e/0x330
>> [ 3029.668861]  worker_thread+0x2ce/0x3f0
>> [ 3029.668868]  ? __pfx_worker_thread+0x10/0x10
>> [ 3029.668873]  kthread+0xd2/0x100
>> [ 3029.668879]  ? __pfx_kthread+0x10/0x10
>> [ 3029.668885]  ret_from_fork+0x34/0x50
>> [ 3029.668892]  ? __pfx_kthread+0x10/0x10
>> [ 3029.668898]  ret_from_fork_asm+0x1a/0x30
>> [ 3029.668910]  </TASK>
>>
>> Tested-on: QCNFA765 WLAN.HSP.1.1-03926.13-
>> QCAHSPSWPL_V2_SILICONZ_CE-2.52297.6
>>
>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>> ---
>> Changes sice v1:
>> - Don't free bhie tables during suspend/hibernation only
>> - Handle fbc_image changed size correctly
>> - Remove fbc_image getting set to NULL in *free_bhie_table()
>> ---
>>   drivers/bus/mhi/host/boot.c           | 15 +++++++++++----
>>   drivers/bus/mhi/host/init.c           | 13 ++++++++++---
>>   drivers/net/wireless/ath/ath11k/mhi.c |  9 +++++----
>>   include/linux/mhi.h                   |  7 +++++++
>>   4 files changed, 33 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/bus/mhi/host/boot.c b/drivers/bus/mhi/host/boot.c
>> index 9dcc7184817d5..0df26100c8f9c 100644
>> --- a/drivers/bus/mhi/host/boot.c
>> +++ b/drivers/bus/mhi/host/boot.c
>> @@ -487,10 +487,17 @@ void mhi_fw_load_handler(struct mhi_controller
>> *mhi_cntrl)
>>        * device transitioning into MHI READY state
>>        */
>>       if (mhi_cntrl->fbc_download) {
>> -        ret = mhi_alloc_bhie_table(mhi_cntrl, &mhi_cntrl->fbc_image,
>> fw_sz);
>> -        if (ret) {
>> -            release_firmware(firmware);
>> -            goto error_fw_load;
>> +        if (mhi_cntrl->fbc_image && fw_sz != mhi_cntrl->prev_fw_sz) {
>> +            mhi_free_bhie_table(mhi_cntrl, mhi_cntrl->fbc_image);
>> +            mhi_cntrl->fbc_image = NULL;
>> +        }
>> +        if (!mhi_cntrl->fbc_image) {
>> +            ret = mhi_alloc_bhie_table(mhi_cntrl, &mhi_cntrl-
>> >fbc_image, fw_sz);
>> +            if (ret) {
>> +                release_firmware(firmware);
>> +                goto error_fw_load;
>> +            }
>> +            mhi_cntrl->prev_fw_sz = fw_sz;
>>           }
>>             /* Load the firmware into BHIE vec table */
>> diff --git a/drivers/bus/mhi/host/init.c b/drivers/bus/mhi/host/init.c
>> index a9b1f8beee7bc..09b946b86ac46 100644
>> --- a/drivers/bus/mhi/host/init.c
>> +++ b/drivers/bus/mhi/host/init.c
>> @@ -1173,8 +1173,9 @@ int mhi_prepare_for_power_up(struct
>> mhi_controller *mhi_cntrl)
>>           /*
>>            * Allocate RDDM table for debugging purpose if specified
>>            */
>> -        mhi_alloc_bhie_table(mhi_cntrl, &mhi_cntrl->rddm_image,
>> -                     mhi_cntrl->rddm_size);
>> +        if (!mhi_cntrl->rddm_image)
>> +            mhi_alloc_bhie_table(mhi_cntrl, &mhi_cntrl->rddm_image,
>> +                         mhi_cntrl->rddm_size);
>>           if (mhi_cntrl->rddm_image) {
>>               ret = mhi_rddm_prepare(mhi_cntrl,
>>                              mhi_cntrl->rddm_image);
>> @@ -1212,12 +1213,18 @@ void mhi_unprepare_after_power_down(struct
>> mhi_controller *mhi_cntrl)
>>           mhi_cntrl->rddm_image = NULL;
>>       }
>>   +    mhi_partial_unprepare_after_power_down(mhi_cntrl);
>> +}
>> +EXPORT_SYMBOL_GPL(mhi_unprepare_after_power_down);
>> +
>> +void mhi_partial_unprepare_after_power_down(struct mhi_controller
>> *mhi_cntrl)
>> +{
>>       mhi_cntrl->bhi = NULL;
>>       mhi_cntrl->bhie = NULL;
>>         mhi_deinit_dev_ctxt(mhi_cntrl);
>>   }
>> -EXPORT_SYMBOL_GPL(mhi_unprepare_after_power_down);
>> +EXPORT_SYMBOL_GPL(mhi_partial_unprepare_after_power_down);
>>   
> Instead of adding new API you can free memory from the unregister
> controller also.
> 
> - Krishna Chaitanya.
>>   static void mhi_release_device(struct device *dev)
>>   {
>> diff --git a/drivers/net/wireless/ath/ath11k/mhi.c b/drivers/net/
>> wireless/ath/ath11k/mhi.c
>> index acd76e9392d31..f77cec79b5b80 100644
>> --- a/drivers/net/wireless/ath/ath11k/mhi.c
>> +++ b/drivers/net/wireless/ath/ath11k/mhi.c
>> @@ -460,12 +460,13 @@ void ath11k_mhi_stop(struct ath11k_pci *ab_pci,
>> bool is_suspend)
>>        * workaround, otherwise ath11k_core_resume() will timeout
>>        * during resume.
>>        */
>> -    if (is_suspend)
>> +    if (is_suspend) {
>>           mhi_power_down_keep_dev(ab_pci->mhi_ctrl, true);
>> -    else
>> +        mhi_partial_unprepare_after_power_down(ab_pci->mhi_ctrl);
>> +    } else {
>>           mhi_power_down(ab_pci->mhi_ctrl, true);
>> -
>> -    mhi_unprepare_after_power_down(ab_pci->mhi_ctrl);
>> +        mhi_unprepare_after_power_down(ab_pci->mhi_ctrl);
>> +    }
>>   }
>>     int ath11k_mhi_suspend(struct ath11k_pci *ab_pci)
>> diff --git a/include/linux/mhi.h b/include/linux/mhi.h
>> index 059dc94d20bb6..65a47c712b3a0 100644
>> --- a/include/linux/mhi.h
>> +++ b/include/linux/mhi.h
>> @@ -382,6 +382,7 @@ struct mhi_controller {
>>       const char *fw_image;
>>       const u8 *fw_data;
>>       size_t fw_sz;
>> +    size_t prev_fw_sz;
>>       const char *edl_image;
>>       size_t rddm_size;
>>       size_t sbl_size;
>> @@ -662,6 +663,12 @@ void mhi_power_down_keep_dev(struct
>> mhi_controller *mhi_cntrl, bool graceful);
>>    */
>>   void mhi_unprepare_after_power_down(struct mhi_controller *mhi_cntrl);
>>   +/**
>> + * mhi_partial_unprepare_after_power_down - Free any allocated memory
>> after power down partially
>> + * @mhi_cntrl: MHI controller
>> + */
>> +void mhi_partial_unprepare_after_power_down(struct mhi_controller
>> *mhi_cntrl);
>> +
>>   /**
>>    * mhi_pm_suspend - Move MHI into a suspended state
>>    * @mhi_cntrl: MHI controller


-- 
Regards,
Usama

