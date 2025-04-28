Return-Path: <linux-wireless+bounces-22111-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 892EEA9E720
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Apr 2025 06:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCF291898632
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Apr 2025 04:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEFAE17A2E3;
	Mon, 28 Apr 2025 04:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b="agl9AlWx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A59FBF6;
	Mon, 28 Apr 2025 04:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745814986; cv=pass; b=RrWrb8CeVY6TluvPCBSvBK5BbrSG2nvZYKIV71t5AZp8SUAmr9n/AyUnkBZVQKzXrk5wmGiNY6waYtMFibdlNdzBUMK5tT7JDBOE1TYkQ5VGq1yS4frkCMiQ8q6wP/1cUPepfla1e40f1vXzWJxCB5vHBdPTe/OUr9PZsS+9XPE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745814986; c=relaxed/simple;
	bh=7NzPxFDCjoVYFYldvDP+JNk7iVkn0yogdQHW79W4AyE=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=qekKko37ttYGve3rJh3tXzlCf11HVgDQ7RF53P84zu7/vh6lx0aXnX8bbnBk0VNB5mWLpRtaZoD1ZNeV3EoWEwJVx2fxRCIdFQnzSa5UKGLP48Uci/lEqceCt6IMwtQ6YWMzEXYbqRJzkE5a4w/P0JQQDxlbNJvew9M+mMujotE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b=agl9AlWx; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1745814959; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=edilIt4dSo/yunV/YZpulBxWmWEheVnH2qByv9pM8x3mWT8WLfEUFrgjKOZD1ZlnBsGc5ekmaDl7+1nJj06BWL9QaVwpvBkKk6/ZzqOoYg/BbRW3tOKuf6gw+c8Ew3cFhs7kVp4IWdQC4OL3hd0txCZHgeP9UyUpaYwr39YUkeA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1745814959; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=rc2LNRC1473KtbUTlBXY0VjET6Xd2eY/BCp0ByumbA8=; 
	b=l9aUoducX4+Xaf/rxzPxYM8mSlchqpShYGtYxLRbg+VCZ6YSOc5LOATOsAC5VOcyDuI/R72bSAjoFckxW1Tv2vh4p5fGLnY9IAPOd58nA7XJpYtjp/6Xjjl9trNI7SA2bCGULJMIGcCd+zWTeDgRhVUBDx3L5TxQKKkdHzZsr1E=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=usama.anjum@collabora.com;
	dmarc=pass header.from=<usama.anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1745814959;
	s=zohomail; d=collabora.com; i=usama.anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Cc:Cc:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=rc2LNRC1473KtbUTlBXY0VjET6Xd2eY/BCp0ByumbA8=;
	b=agl9AlWxZo7IS3Ba90mtDugjkMEosy/b9wbV8vICW4VCV4hWgCgZk3ps3aD0DCWj
	s71eEGJ9PJQ3xa6rcprbgnTjwbDfvpW1WU/LsTXrULlb+C6ztTap8v4W6gKQMLYHCp0
	/t5mjwOvL5jXgZIhbBu4YJu1g051Wk1rtblMsnbI=
Received: by mx.zohomail.com with SMTPS id 174581495773834.76018741853284;
	Sun, 27 Apr 2025 21:35:57 -0700 (PDT)
Message-ID: <8981527a-7bf9-4a34-acd8-38099d37ba6d@collabora.com>
Date: Mon, 28 Apr 2025 09:35:51 +0500
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: usama.anjum@collabora.com, kernel@collabora.com,
 linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] wifi: ath11k: Fix MHI target memory reuse logic
To: Baochen Qiang <quic_bqiang@quicinc.com>, jeff.johnson@oss.qualcomm.com,
 Jeff Johnson <jjohnson@kernel.org>
References: <20250425110424.2530460-1-usama.anjum@collabora.com>
 <dee649f1-0516-4a59-a70d-ba206388e568@quicinc.com>
 <4b3a18e3-14ac-4876-9b51-acee142464b3@quicinc.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <4b3a18e3-14ac-4876-9b51-acee142464b3@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 4/28/25 7:03 AM, Baochen Qiang wrote:
> 
> 
> On 4/25/2025 7:08 PM, Baochen Qiang wrote:
>>
>>
>> On 4/25/2025 7:04 PM, Muhammad Usama Anjum wrote:
>>> Firmware requests 2 segments at first. The first segment is of 6799360
>>> whose allocation fails due to dma remapping not available. The success
>>> is returned to firmware. Then firmware asks for 22 smaller segments
>>> instead of 2 big ones. Those get allocated successfully. At suspend/
>>> hibernation time, these segments aren't freed as they will be reused
>>> by firmware after resuming.
>>>
>>> After resuming, the firmware asks for the 2 segments again with the
>>> first segment of 6799360 size. Since chunk->vaddr is not NULL, the
>>> type and size are compared with the previous type and size to know if
>>> it can be reused or not. Unfortunately, it is detected that it cannot
>>> be reused and this first smaller segment is freed. Then we continue to
>>> allocate 6799360 size memory which fails and ath11k_qmi_free_target_mem_chunk()
>>> is called which frees the second smaller segment as well. Later success
>>> is returned to firmware which asks for 22 smaller segments again. But
>>> as we had freed 2 segments already, we'll allocate the first 2 new
>>> smaller segments again and reuse the remaining 20. Hence 20 small
>>> segments are being reused instead of 22.
>>>
>>> Add skip logic when vaddr is set, but size/type don't match. Use the
>>> same skip and success logic as used when dma_alloc_coherent() fails.
>>> By skipping, the possibility of resume failure due to kernel failing to
>>> allocate memory for QMI can be avoided.
>>>
>>> 	kernel: ath11k_pci 0000:03:00.0: failed to allocate dma memory for qmi (524288 B type 1)
>>> 	ath11k_pci 0000:03:00.0: failed to allocate qmi target memory: -22
>>>
>>> Tested-on: WCN6855 WLAN.HSP.1.1-03926.13-QCAHSPSWPL_V2_SILICONZ_CE-2.52297.6
>>>
>>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>>> ---
>>> Changes since v1:
>>> - Update description
>>>
>>> Changes since v2:
>>> - Update description
>>>
>>> Changes since v3:
>>> - Update description
> 
> The subject since previous is changed, but not mentioned here.
> 
> Please describe all your changes.
> 
>>> ---
>>>  drivers/net/wireless/ath/ath11k/qmi.c | 9 +++++++++
>>>  1 file changed, 9 insertions(+)
>>>
>>> diff --git a/drivers/net/wireless/ath/ath11k/qmi.c b/drivers/net/wireless/ath/ath11k/qmi.c
>>> index 47b9d4126d3a9..2782f4723e413 100644
>>> --- a/drivers/net/wireless/ath/ath11k/qmi.c
>>> +++ b/drivers/net/wireless/ath/ath11k/qmi.c
>>> @@ -1993,6 +1993,15 @@ static int ath11k_qmi_alloc_target_mem_chunk(struct ath11k_base *ab)
>>>  			    chunk->prev_size == chunk->size)
>>>  				continue;
>>>  
>>> +			if (ab->qmi.mem_seg_count <= ATH11K_QMI_FW_MEM_REQ_SEGMENT_CNT) {
>>> +				ath11k_dbg(ab, ATH11K_DBG_QMI,
>>> +					   "size/type mismatch (current %d %u) (prev %d %u), try later with small size\n",
>>> +					    chunk->size, chunk->type,
>>> +					    chunk->prev_size, chunk->prev_type);
>>> +				ab->qmi.target_mem_delayed = true;
>>> +				return 0;
>>> +			}
>>> +
>>>  			/* cannot reuse the existing chunk */
>>>  			dma_free_coherent(ab->dev, chunk->prev_size,
>>>  					  chunk->vaddr, chunk->paddr);
>>
>> LGTM
>>
>> Reviewed-by: Baochen Qiang <quic_bqiang@quicinc.com>
> 
> Withdraw above tag as I didn't notice that the patch subject is incorrect since v3.
> 
> The QMI memory has nothing to do with MHI. IMO the v1/v2 subject is good:
> 
> 	wifi: ath11k: Fix memory reuse logic
> 
> while even better mention QMI:
> 
> 	wifi: ath11k: Fix QMI memory reuse logicJeff had asked for changed subject here [1]. Let me change again and
send the patch.

[1]
https://lore.kernel.org/all/228546c4-a4b5-4f21-950d-2623a48f60a6@oss.qualcomm.com

> 
> 
>>
> 


-- 
Regards,
Usama

