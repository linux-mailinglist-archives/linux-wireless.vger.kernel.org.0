Return-Path: <linux-wireless+bounces-21950-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3170A9A037
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 06:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4202F3A2ED5
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 04:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF4E11624DE;
	Thu, 24 Apr 2025 04:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b="OhFshwA6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FD74A23;
	Thu, 24 Apr 2025 04:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745469953; cv=pass; b=KZx008p1qbKVG5QLnpNCRPrZ8VfbnvjsvI5YlQkWcowJYv+2Ke9PHTa3Z1aP6X0MSkOZKb++EPdbsv6UnszlovfGHWfmGpAXdgrcZfe1oRW1ELdQI9MWjf3+lG4bnUDCbmiaH5lAnNsv865bvQg9quD1M4uJQ9HVdnPD0Bj2khM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745469953; c=relaxed/simple;
	bh=yx9bia+2OjSoSR4sMmX/f7s/jQ4LRHYaWdLHTFLDJaw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bg2Z2BWbA8/yDhQYSLn1EHz+ZGLfIcEgAO0GZjkWspr6K6+BgpgLSAfplWdqPd7kVRZFTl8kWVwKawq2qGNruLkyjcPdB2uoTSsopc8NRJddOiVdBNIzDgoMsQUtLUf9jthA8FGzU7TCBB/3ZJdXOGhtNz5jdBywijxVWJP5Xgg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b=OhFshwA6; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1745469929; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=H4VGPCw8nTAWwtwdbAtBTE/Mo5u2WDp5C9tMV0DMF81Ckn1mJsqxoIs8DpyBmsZFWKqFJ5s5JavcTuX77LPzEjqYs4bh1JuTCXHNcbSAhWYam6wqR4uuHDLssFCQClrs/iV61hpdT4At0xyzA6TO+pyk7I+GiCrODJeFkMH5pK0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1745469929; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=1Einm1/iIrnFazLd9EPpQGtzJH6JLy7QJYdzKbUdRw4=; 
	b=IB5khyDdmXcKXSWn1GUGHlQ93rl+Qqe1OuvhoCvBbXHGDwZ/63c9GMHr5E06+Ty3c8QYjv8C4OPqFlHwL/j1hTSczRUP5sz2eicZu1fpnVB0KFoHHDapYJNCmF9cRfBjvFt9zs1Eym7i1e2neOHBp6tX2zOsJtOQIfY8/rl8gTc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=usama.anjum@collabora.com;
	dmarc=pass header.from=<usama.anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1745469929;
	s=zohomail; d=collabora.com; i=usama.anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=1Einm1/iIrnFazLd9EPpQGtzJH6JLy7QJYdzKbUdRw4=;
	b=OhFshwA6NrQnnveB09b6WlcRsspO/edxEoDcNepooEapPoSKkR62BbU0fIWa61/+
	3LADMDY+kQqVw+SGDftIJQK22QZQONstbf9NrAWG9QGBWFAhOkqGDm5MDY0zhxPhpv0
	R5kv8n0/0jn1oZ9LE57uSSeu/O+DLWMwaYWAOO8Q=
Received: by mx.zohomail.com with SMTPS id 1745469925816636.275804169616;
	Wed, 23 Apr 2025 21:45:25 -0700 (PDT)
Message-ID: <0dfa628a-b7b2-4aba-885b-a28b7a9b66d4@collabora.com>
Date: Thu, 24 Apr 2025 09:45:19 +0500
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: ath11k: Fix memory reuse logic
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
 Baochen Qiang <quic_bqiang@quicinc.com>, Jeff Johnson <jjohnson@kernel.org>,
 Kalle Valo <kvalo@kernel.org>, Anilkumar Kolli <quic_akolli@quicinc.com>
Cc: kernel@collabora.com, linux-wireless@vger.kernel.org,
 ath11k@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250423065931.4017574-1-usama.anjum@collabora.com>
 <f98ed1af-e190-404f-a2d2-aa64a712e7c2@quicinc.com>
 <228546c4-a4b5-4f21-950d-2623a48f60a6@oss.qualcomm.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <228546c4-a4b5-4f21-950d-2623a48f60a6@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

On 4/23/25 7:28 PM, Jeff Johnson wrote:
> On 4/23/2025 1:15 AM, Baochen Qiang wrote:
>> On 4/23/2025 2:59 PM, Muhammad Usama Anjum wrote:
> 
> For starters, can we make the subject a bit more specific, i.e.
> Fix MHI target memory reuse logic
Will do.

> 
>>> Firmware requests 2 segments at first. The first segment is of 6799360
>>> whose allocation fails due to dma remapping not available. The success
> 
> the memory allocation succeeds but the remapping fails? that seems like some
> specific information that actually isn't very useful. From the perspective of
> the driver all we really care about is that dma_alloc_coherent() fails, not
> why it fails.
I'm explaining the code flow here to define what's wrong. If I hadn't
mentioned this, I would have been asked how this bug gets triggered.

> 
>>> is returned to firmware. Then firmware asks for 22 smaller segments
>>> instead of 2 big ones. Those get allocated successfully. At suspend/
>>> hibernation time, these segments aren't freed as they will be reused
>>> by firmware after resuming.
>>>
>>> After resume the firmware asks for 2 segments again with first segment
>>> of 6799360 and vaddr is not NULL. We compare the type and size with
>>
>> suggest to rephrase as:
>>
>> After resume the firmware asks for 2 segments again with first segment
>> of 6799360. Since chunk->vaddr is not NULL, we compare the type and size with
>>
>>> previous type and size to know if it can be reused or not.
>>> Unfortunately, we detect that it cannot be reuses and this first smaller
>>
>> s/reuses/reused/
>>
>>> segment is freed. Then we continue to allocate 6799360 size memory from
>>> dma which fails and we call ath11k_qmi_free_target_mem_chunk() which
>>
>> it is odd with 'from dma' ...
>>
>> I think just say 'allocate 6799360 size memory' is good enough.
>>
>>> frees the second smaller segment as well. Later success is returned to
>>> firmware which asks for 22 smaller segments again. But as we had freed 2
>>> segments already, we'll allocate the first 2 new smaller segments again
>>> and reuse the remaining 20. Hence we aren't reusing the all 22 small
>>> segments, but only 20.
>>>
>>> This patch is correcting the skip logic when vaddr is set, but size/type
> 
> see
> <https://www.kernel.org/doc/html/latest/process/submitting-patches.html#describe-your-changes>
> 
> Specifically:
> Describe your changes in imperative mood, e.g. “make xyzzy do frotz” instead
> of “[This patch] makes xyzzy do frotz” or “[I] changed xyzzy to do frotz”, as
> if you are giving orders to the codebase to change its behaviour.
> 
>>> don't match. In this case, we should use the same skip and success logic
> 
> who is "we"? the driver is performing the action. As part of changing the text
> to be in imperative mood this should go away.
> 
>>> as used when dma_alloc_coherent fails without freeing the memory area.
> 
> add () to function references
> 
Will do

>>>
>>> We had got reports that memory allocation in this function failed at
>>> resume [1] which made us debug why the reuse logic is wrong. Those
>>
>> The link is just v1 of this patch, it is not the report. If there is no public report,
>> just don't mention it.
>>
>>> failures weren't because of the bigger chunk allocation failure as they
>>> are skipped. Rather these failures were because of smaller chunk
>>> allocation failures. This issue is in the kernel side as because of
>>> memory pressure or fragmentation, the dma memory allocation fails. This
>>> patch fixes freeing and allocation of 2 smaller chunks.
>>
>> I know you are describing why you start to debug this issue. But I don't think it is
>> needed in the commit message. No matter kernel allocation fails or succeeds, the issue is
>> there, and the description above is sufficient to make the issue clear.
> 
> Concur with this.
> 
>>
>>>
>>> Tested-on: WCN6855 WLAN.HSP.1.1-03926.13-QCAHSPSWPL_V2_SILICONZ_CE-2.52297.6
>>
>> blank line needed.
>>
>>> [1] https://lore.kernel.org/all/b30bc7f6-845d-4f9d-967e-c04a2b5f13f5@collabora.com
>>>
>>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>>> ---
>>> Changes since v1:
>>> - Update description
>>>
>>> Fixes: 5962f370ce41 ("ath11k: Reuse the available memory after firmware reload")
>>> I think we should keep fixes tag as ^ claimed that its adding reuse
>>> support. But it left a bug in reuse which we are fixing.
>>>
>>> Feel free to add it or leave it as it is.
>>
>> Jeff, what do you think?
> 
> I would drop the tag. As I understand it, the issue described is due to memory
> fragmentation/starvation, and not due to the fact that ath11k does not
> actually reuse the first two segments.
Ath11k not reusing the segment is also an logical issue. The patch
adding reuse logic claims that it added reuse logic. But it had missed
this use case.

Anyways not a blocker for me. I just wanted this patch to get backported
to stable kernels as its fixing the reuse logic and of course issue
arising from fragmentation.

> 
>>
>>> ---
>>>  drivers/net/wireless/ath/ath11k/qmi.c | 10 +++++++++-
>>>  1 file changed, 9 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/net/wireless/ath/ath11k/qmi.c b/drivers/net/wireless/ath/ath11k/qmi.c
>>> index 47b9d4126d3a9..3c26f4dcf5d29 100644
>>> --- a/drivers/net/wireless/ath/ath11k/qmi.c
>>> +++ b/drivers/net/wireless/ath/ath11k/qmi.c
>>> @@ -1990,8 +1990,16 @@ static int ath11k_qmi_alloc_target_mem_chunk(struct ath11k_base *ab)
>>>  		 */
>>>  		if (chunk->vaddr) {
>>>  			if (chunk->prev_type == chunk->type &&
>>> -			    chunk->prev_size == chunk->size)
>>> +			    chunk->prev_size == chunk->size) {
> 
> please don't change this...

> 
>>>  				continue;
>>> +			} else if (ab->qmi.mem_seg_count <= ATH11K_QMI_FW_MEM_REQ_SEGMENT_CNT) {
> 
> ...instead just use if here. we normally don't use else after a statement that
> changes the code flow (return, goto, continue, etc.)
Will send v3.

> 
> 
>>> +				ath11k_dbg(ab, ATH11K_DBG_QMI,
>>> +					   "size/type mismatch (current %d %u) (prev %d %u), try later with small size\n",
>>> +					    chunk->size, chunk->type,
>>> +					    chunk->prev_size, chunk->prev_type);
>>> +				ab->qmi.target_mem_delayed = true;
>>> +				return 0;
>>> +			}
>>>  
>>>  			/* cannot reuse the existing chunk */
>>>  			dma_free_coherent(ab->dev, chunk->prev_size,
>>
>>
> 


-- 
Regards,
Usama

