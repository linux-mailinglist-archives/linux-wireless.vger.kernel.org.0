Return-Path: <linux-wireless+bounces-22929-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F00CBAB63F2
	for <lists+linux-wireless@lfdr.de>; Wed, 14 May 2025 09:18:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 824DC189F4A6
	for <lists+linux-wireless@lfdr.de>; Wed, 14 May 2025 07:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CDC11FF7B0;
	Wed, 14 May 2025 07:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b="gpFiuabP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sender3-pp-f112.zoho.com (sender3-pp-f112.zoho.com [136.143.184.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4423E4C7C;
	Wed, 14 May 2025 07:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747207118; cv=pass; b=a00zuRfAITxpv6ALVfZkAuqA+rop7tKCbo6LcgRmychJEOpQ28brKsG3uDkKWZU2oL+luW49yEE31IJyD3LCkYuqCmLj3W5Wrb0+cAkFsyNlnp+Uv4YVJlzV2/dhIOyrLLTOmSGFMO1OSD/W7TyGXKItvP1PQ188BuRySfMk3Jk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747207118; c=relaxed/simple;
	bh=vCQn8TFGM628timJ+axGQvEslXu2HdTJbzhOFutuu48=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TcjjoOcqMBL/oRTmdWYGDHKw24NGTb2zxMpPTqval0jRXYL3LY6Y9OJ8wYzjR30Lo6fFosMsWH3F9jbW+F+UahhadwF2irOICiX3EMheHC9nIU4XVaoCwjhbo6j5dUcEj0THtaLRnQ/0KqstQY1qsrpOcfgRCABKVG2wpwKqeOM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b=gpFiuabP; arc=pass smtp.client-ip=136.143.184.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1747207072; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=cy+hd7SOFg0yFgxCaFVUWI7aomD/dHrw+f6RLmsChBZjYiOU/yU++//+A338Uqgty+PXa06ZHecF/6UFcYJy8TNrS0wSDk76KOQcd8lilkuS7YGQHN7krMrszvoM04uQ5YG1LXH6RXp6LwEyt0fB88nqckkF8/LyDf/Hkg/PEbM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1747207072; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ibXEmXTnH9FdlMBQTesZfHCGW3hwMYrnoFmfNGLlv90=; 
	b=i7249UYxoUd3KeYUv4wUtv1OUCv/UCwE8ePv+ucyxUfGjPqF7wVD2kdDPM7+qYjSPF17t9zNBjF3o4QMuS4JdSM2RvEI7iJqEsSs+MBbFBCnQ+RyaZTijftAQeB8tTQALxSr1WPKP1e9HhHJtLxHMnwRcfWsGPX4vBaPHR6vjK0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=usama.anjum@collabora.com;
	dmarc=pass header.from=<usama.anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1747207072;
	s=zohomail; d=collabora.com; i=usama.anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Cc:Cc:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=ibXEmXTnH9FdlMBQTesZfHCGW3hwMYrnoFmfNGLlv90=;
	b=gpFiuabPVRr6arlU820jgsCaDYFwmcp+5BaEVU7R3S7FctE1E5IndnBuqfchYkrw
	VOvdBt1hyY3yVhyG1uHz5mZwuG1ycGuwu9C0xhY6S9jBwZ7jqjMS6bonK8p2M1a/R5C
	Y0zsZ/7F/63pZz2g9EqkiuCH2BGdDgPoNriiSgik=
Received: by mx.zohomail.com with SMTPS id 1747207069715402.95018488662095;
	Wed, 14 May 2025 00:17:49 -0700 (PDT)
Message-ID: <951203c6-44a6-4fa9-afad-6ce3973774ae@collabora.com>
Date: Wed, 14 May 2025 12:17:41 +0500
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: usama.anjum@collabora.com, kernel@collabora.com,
 sebastian.reichel@collabora.com, Carl Vanderlip <quic_carlv@quicinc.com>,
 Alex Elder <elder@kernel.org>, mhi@lists.linux.dev,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
 ath12k@lists.infradead.org
Subject: Re: [PATCH v4] bus: mhi: host: don't free bhie tables during
 suspend/hibernation
To: Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Jeff Johnson <jjohnson@kernel.org>, Youssef Samir
 <quic_yabdulra@quicinc.com>, Matthew Leung <quic_mattleun@quicinc.com>,
 Yan Zhen <yanzhen@vivo.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,
 Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
 Kunwu Chan <chentao@kylinos.cn>, Troy Hanson <quic_thanson@quicinc.com>,
 "Dr. David Alan Gilbert" <linux@treblig.org>
References: <20250506144941.2715345-1-usama.anjum@collabora.com>
 <4a6b83f4-885a-46e1-ae31-21a4f3959bae@oss.qualcomm.com>
 <5521efad-1ca8-41e3-b820-5527d634c539@collabora.com>
 <57e04b5a-9f04-49bb-8a7d-978276e9033f@oss.qualcomm.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <57e04b5a-9f04-49bb-8a7d-978276e9033f@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

On 5/13/25 8:16 PM, Jeff Hugo wrote:
> On 5/13/2025 12:44 AM, Muhammad Usama Anjum wrote:
>> On 5/12/25 11:46 PM, Jeff Hugo wrote:
>>> On 5/6/2025 8:49 AM, Muhammad Usama Anjum wrote:
>>>> Fix dma_direct_alloc() failure at resume time during bhie_table
>>>> allocation because of memory pressure. There is a report where at
>>>> resume time, the memory from the dma doesn't get allocated and MHI
>>>> fails to re-initialize.
>>>>
>>>> To fix it, don't free the memory at power down during suspend /
>>>> hibernation. Instead, use the same allocated memory again after every
>>>> resume / hibernation. This patch has been tested with resume and
>>>> hibernation both.
>>>>
>>>> The rddm is of constant size for a given hardware. While the fbc_image
>>>> size depends on the firmware. If the firmware changes, we'll free and
>>>> allocate new memory for it.
>>>
>>> Why is it valid to load new firmware as a result of suspend?  I don't
>>> users would expect that.
>> I'm not sure its valid or not. Like other users, I also don't expect
>> that firmware would get changed. It doesn't seem to be tested and hence
>> supported case.
>>
>> But other drivers have code which have implementation like this. I'd
>> mentioned previously that this patch was motivated from the ath12k [1]
>> and ath11k [2] patches. They don't free the memory and reuse the same
>> memory if new size is same.
> 
> It feels like this justification needs to be detailed in the commit
> text. I suspect at some point we'll have another MHI device where the FW
> will need to be cached.
Okay. I'll add this information to the commit message. Currently I've
not seen firmware caching being used other than graphics driver.

> 
>>>> diff --git a/drivers/bus/mhi/host/boot.c b/drivers/bus/mhi/host/boot.c
>>>> index efa3b6dddf4d2..bc8459798bbee 100644
>>>> --- a/drivers/bus/mhi/host/boot.c
>>>> +++ b/drivers/bus/mhi/host/boot.c
>>>> @@ -584,10 +584,17 @@ void mhi_fw_load_handler(struct mhi_controller
>>>> *mhi_cntrl)
>>>>         * device transitioning into MHI READY state
>>>>         */
>>>>        if (fw_load_type == MHI_FW_LOAD_FBC) {
>>>
>>> Why is this FBC specific?
>> It seems we allocate fbc_image only when firmware load type is
>> FW_LOAD_FBC. I'm just optimizing the buffer allocation here.
> 
> We alloc bhie tables in non FBC usecases. Is this somehow an FBC
> specific issue? Perhaps you could clarify the limits of this solution in
> the commit text?
Okay. I'll add information that we are optimizing the bhie allocations.
It has nothing to do with firmware type. I've found only 2 bhie
allocations; fbc_image and rddm_image. So we are optimizing those.

> 
>>
>>>
>>>> -        ret = mhi_alloc_bhie_table(mhi_cntrl, &mhi_cntrl->fbc_image,
>>>> fw_sz);
>>>> -        if (ret) {
>>>> -            release_firmware(firmware);
>>>> -            goto error_fw_load;
>>>> +        if (mhi_cntrl->fbc_image && fw_sz != mhi_cntrl->prev_fw_sz) {
>>>> +            mhi_free_bhie_table(mhi_cntrl, mhi_cntrl->fbc_image);
>>>> +            mhi_cntrl->fbc_image = NULL;
>>>> +        }
>>>> +        if (!mhi_cntrl->fbc_image) {
>>>> +            ret = mhi_alloc_bhie_table(mhi_cntrl, &mhi_cntrl-
>>>>> fbc_image, fw_sz);
>>>> +            if (ret) {
>>>> +                release_firmware(firmware);
>>>> +                goto error_fw_load;
>>>> +            }
>>>> +            mhi_cntrl->prev_fw_sz = fw_sz;
>>>>            }
>>>>              /* Load the firmware into BHIE vec table */
>>>> diff --git a/drivers/bus/mhi/host/pm.c b/drivers/bus/mhi/host/pm.c
>>>> index e6c3ff62bab1d..107d71b4cc51a 100644
>>>> --- a/drivers/bus/mhi/host/pm.c
>>>> +++ b/drivers/bus/mhi/host/pm.c
>>>> @@ -1259,10 +1259,19 @@ void mhi_power_down(struct mhi_controller
>>>> *mhi_cntrl, bool graceful)
>>>>    }
>>>>    EXPORT_SYMBOL_GPL(mhi_power_down);
>>>>    +static void __mhi_power_down_unprepare_keep_dev(struct
>>>> mhi_controller *mhi_cntrl)
>>>> +{
>>>> +    mhi_cntrl->bhi = NULL;
>>>> +    mhi_cntrl->bhie = NULL;
>>>
>>> Why?
>> This function is shorter version of mhi_unprepare_after_power_down(). As
>> we need different code path in case of suspend/hibernation case, I was
>> adding a new API which Mani asked me remove and consolidate into
>> mhi_power_down_keep_dev() instead. So this static function has been
>> added. [3]
> 
> I don't understand the need to zero these out.  Also, if you are copying
> part of the functionality of mhi_unprepare_after_power_down(), shouldn't
> that functionality be moved into your new API to eliminate duplication?
This how the cleanup works mhi_unprepare_after_power_down(). Yeah, it
makes sense to use this function in mhi_unprepare_after_power_down().

Sending next version soon.
> 


-- 
Regards,
Usama

