Return-Path: <linux-wireless+bounces-21913-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A5D8A98BDF
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 15:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33A6C17F2B9
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 13:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B151A1AF0CE;
	Wed, 23 Apr 2025 13:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b="dinOHeGS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C7B1A9B24;
	Wed, 23 Apr 2025 13:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745416326; cv=pass; b=HUhf0J8nRdtUt4p+R+2t2/GGijP1g9ZNBe7GyqxajdscXJC0GI/876S6y86OoXZtL8NnfQ+xpAGPvL7Vn7GE33XNo1wmIsPsUeB4B4pa/qwSTCyPwomFuH9137EiJ8tG4OJZb4GPIq1+fqpeJGkNCIImseWAxQ3p/3KJFxADOIU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745416326; c=relaxed/simple;
	bh=fM6nkSTRPX6gwFgW6jrCiGCeg6Vz/TYnOOibSDDTpco=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q2z2aO9Tv5DlBHKmbh6SrSgcbqBhW98F1975G7SQcxv0UtMcBvjtnO0PeSKau/BsSkILosgiJCh+c9rFhPfd2yovWIVFU2Yt8Q/a6cxGPpISSl1Qq9gqygMbMB/nBvmMHgJWrGAhSvo7al7vu6phX30GtG5iEeyaN/CtDtPBAXI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b=dinOHeGS; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1745416305; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=bI5HCNRrXiqjvmlp6o7QMKYxgyVKyLu+RF0eljFmwHycqCT6oqePLBppjInBvylRhQzBVIbvJSj326fq1AhiVGZ8KbdQfGTUEQUg1VFxIWjl22OTLymyos/rmutWMCAkWPYv6j1fHIVvbFc/79K9Xo8N49Xm4VoXR5J0b47SIwA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1745416305; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=VtDCyMWD4o0QblVy4W0qH/IAUUG3Hf3eVcRe84lFpEE=; 
	b=fHPS3aw5iPmLYhR5BUTZp02VGAWgP9wMLl/Uwwav7IBjWUq+jnpEidVFsckJ8K6t8o0LxAgV+/5sS8iUxbr6EcVs82Uz+zLfmfbIDAX3c1nYCTUuxu6wi4lCU8Yk4rEMoiEUA1rk2REf6RhVK+Y8FiyxjQkdhrwfr+vVM7sOMqQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=usama.anjum@collabora.com;
	dmarc=pass header.from=<usama.anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1745416305;
	s=zohomail; d=collabora.com; i=usama.anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=VtDCyMWD4o0QblVy4W0qH/IAUUG3Hf3eVcRe84lFpEE=;
	b=dinOHeGS+ToMjUFjJpDI4N8sTWlWhD2KRwXLzt/KlC8D1uJlE+dybSCUMPbL5SKG
	Ry0dw2T/4vTD5wsudt0kIG/qvkJbf75+oHeDHA1cW2wAlCVMZbRgABuVrH+LhqhBj+8
	m1d7tWvsVHtxCMvfqSxRckjCQUqpmhYz+pZ7Jgxc=
Received: by mx.zohomail.com with SMTPS id 1745416303535291.784690825201;
	Wed, 23 Apr 2025 06:51:43 -0700 (PDT)
Message-ID: <e5429039-3679-474f-80cc-12f6cc01de09@collabora.com>
Date: Wed, 23 Apr 2025 18:51:36 +0500
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: ath11k: Fix memory reuse logic
To: Baochen Qiang <quic_bqiang@quicinc.com>,
 Jeff Johnson <jjohnson@kernel.org>, Kalle Valo <kvalo@kernel.org>,
 Anilkumar Kolli <quic_akolli@quicinc.com>
Cc: kernel@collabora.com, linux-wireless@vger.kernel.org,
 ath11k@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250423065931.4017574-1-usama.anjum@collabora.com>
 <f98ed1af-e190-404f-a2d2-aa64a712e7c2@quicinc.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <f98ed1af-e190-404f-a2d2-aa64a712e7c2@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 4/23/25 1:15 PM, Baochen Qiang wrote:
> 
> 
> On 4/23/2025 2:59 PM, Muhammad Usama Anjum wrote:
>> Firmware requests 2 segments at first. The first segment is of 6799360
>> whose allocation fails due to dma remapping not available. The success
>> is returned to firmware. Then firmware asks for 22 smaller segments
>> instead of 2 big ones. Those get allocated successfully. At suspend/
>> hibernation time, these segments aren't freed as they will be reused
>> by firmware after resuming.
>>
>> After resume the firmware asks for 2 segments again with first segment
>> of 6799360 and vaddr is not NULL. We compare the type and size with
> 
> suggest to rephrase as:
> 
> After resume the firmware asks for 2 segments again with first segment
> of 6799360. Since chunk->vaddr is not NULL, we compare the type and size with
> 
>> previous type and size to know if it can be reused or not.
>> Unfortunately, we detect that it cannot be reuses and this first smaller
> 
> s/reuses/reused/
> 
>> segment is freed. Then we continue to allocate 6799360 size memory from
>> dma which fails and we call ath11k_qmi_free_target_mem_chunk() which
> 
> it is odd with 'from dma' ...
> 
> I think just say 'allocate 6799360 size memory' is good enough.
> 
>> frees the second smaller segment as well. Later success is returned to
>> firmware which asks for 22 smaller segments again. But as we had freed 2
>> segments already, we'll allocate the first 2 new smaller segments again
>> and reuse the remaining 20. Hence we aren't reusing the all 22 small
>> segments, but only 20.
>>
>> This patch is correcting the skip logic when vaddr is set, but size/type
>> don't match. In this case, we should use the same skip and success logic
>> as used when dma_alloc_coherent fails without freeing the memory area.
>>
>> We had got reports that memory allocation in this function failed at
>> resume [1] which made us debug why the reuse logic is wrong. Those
> 
> The link is just v1 of this patch, it is not the report. If there is no public report,
> just don't mention it.
> 
>> failures weren't because of the bigger chunk allocation failure as they
>> are skipped. Rather these failures were because of smaller chunk
>> allocation failures. This issue is in the kernel side as because of
>> memory pressure or fragmentation, the dma memory allocation fails. This
>> patch fixes freeing and allocation of 2 smaller chunks.
> 
> I know you are describing why you start to debug this issue. But I don't think it is
> needed in the commit message. No matter kernel allocation fails or succeeds, the issue is
> there, and the description above is sufficient to make the issue clear.
> 
>>
>> Tested-on: WCN6855 WLAN.HSP.1.1-03926.13-QCAHSPSWPL_V2_SILICONZ_CE-2.52297.6
> 
> blank line needed.
> 
>> [1] https://lore.kernel.org/all/b30bc7f6-845d-4f9d-967e-c04a2b5f13f5@collabora.com
>>
>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>> ---
>> Changes since v1:
>> - Update description
>>
>> Fixes: 5962f370ce41 ("ath11k: Reuse the available memory after firmware reload")
>> I think we should keep fixes tag as ^ claimed that its adding reuse
>> support. But it left a bug in reuse which we are fixing.
>>
>> Feel free to add it or leave it as it is.
> 
> Jeff, what do you think?
I'll update the description as mentioned. Let's wait for Jeff to review
before I send v3.

> 
>> ---
>>  drivers/net/wireless/ath/ath11k/qmi.c | 10 +++++++++-
>>  1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/wireless/ath/ath11k/qmi.c b/drivers/net/wireless/ath/ath11k/qmi.c
>> index 47b9d4126d3a9..3c26f4dcf5d29 100644
>> --- a/drivers/net/wireless/ath/ath11k/qmi.c
>> +++ b/drivers/net/wireless/ath/ath11k/qmi.c
>> @@ -1990,8 +1990,16 @@ static int ath11k_qmi_alloc_target_mem_chunk(struct ath11k_base *ab)
>>  		 */
>>  		if (chunk->vaddr) {
>>  			if (chunk->prev_type == chunk->type &&
>> -			    chunk->prev_size == chunk->size)
>> +			    chunk->prev_size == chunk->size) {
>>  				continue;
>> +			} else if (ab->qmi.mem_seg_count <= ATH11K_QMI_FW_MEM_REQ_SEGMENT_CNT) {
>> +				ath11k_dbg(ab, ATH11K_DBG_QMI,
>> +					   "size/type mismatch (current %d %u) (prev %d %u), try later with small size\n",
>> +					    chunk->size, chunk->type,
>> +					    chunk->prev_size, chunk->prev_type);
>> +				ab->qmi.target_mem_delayed = true;
>> +				return 0;
>> +			}
>>  
>>  			/* cannot reuse the existing chunk */
>>  			dma_free_coherent(ab->dev, chunk->prev_size,
> 


-- 
Regards,
Usama

