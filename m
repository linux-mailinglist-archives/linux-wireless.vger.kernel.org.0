Return-Path: <linux-wireless+bounces-21897-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F8F2A97F1A
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 08:26:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCAB93A3778
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 06:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B429263F3F;
	Wed, 23 Apr 2025 06:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b="Ol5LzmvE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4820F157487;
	Wed, 23 Apr 2025 06:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745389607; cv=pass; b=GyEtHZ8MEJjgm+RtlCG3wljniKuyaS8oH9pa436NhHBuMjPVjD+5/T6Z0a0ZA9Io2heOOa2VEqM6aJGNE4Rwkfvzz5HKzgkq5pmWshK0QPefjcT0pdhxCe6ndUHrksVP5f/yWDwSGhoOrZhlhcDXKDkdTEM5wEueT79lUjBJxSY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745389607; c=relaxed/simple;
	bh=00dM4dFJUHwD/tB/wgZJw1pFJrJ/pLQ0/M3aCWHR5pI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fsYrtxK02U4Jc97GwbqHx64V1tehKj5xvcKF/Zjy+1FUjoVv4Dvhui24oVmeV5yxOaeSd8aez7t6OpVrmy8vIrmY/gpOmGbVswzgJsaIV0cxgLLL0lwm4YmYPHbrkZEJRH2fL+zPWKYFtRUCp/Lv5h4+6PpAMWot/fWadwMhQUs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b=Ol5LzmvE; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1745389588; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ebdmhULDCdrUhAx4aaHuQRurTciMDX++P9TMCC1yWKj12FX4PUzC3fqhzGgLCbkDhjvtLYJs2vbwChjxh3udapZtmzeCOE7jQiLL31pWBiIYokvrvdcbudMj9SrDsXPAJ/jvq9t+JTVPJweYduJDr4DiA2kAvdFRSadyR9xWmqU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1745389588; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=yTzHN7dGIHSIA2ZcTAnz8A4g6gO0WgnqyLnTZP7VHC8=; 
	b=P6fHgVM+pJcVG+MVaI/WNa73/m3V7DvK6b/pP7wPYAEbJK3cfv7kJP+qgd0sc8adA7KNj9wOlI/rKnBVfCcj5khcWZ43lWP0gtgFcyg8V2at2VxmKgK2tK/zcCz7YJa83rWVPtrI7fk0pA2tg74Jz8YiaBkcb0bST06R56Zsaf4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=usama.anjum@collabora.com;
	dmarc=pass header.from=<usama.anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1745389588;
	s=zohomail; d=collabora.com; i=usama.anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=yTzHN7dGIHSIA2ZcTAnz8A4g6gO0WgnqyLnTZP7VHC8=;
	b=Ol5LzmvEc3ZMuLQ7uqwbVYMrbSnC0B72Cd3fdt83r9QD5vrtChiefTxzo5ud7TqC
	fgebkqHpO6FsuI2XQNhGutWIPw4KK8TNqyoMpognxgyE+igoxiuNp0Ii1M5fF3gZu7a
	7Sqhn2jjwwgnFZ7U4yNIwNdt8tDJ42V047+tSFhk=
Received: by mx.zohomail.com with SMTPS id 1745389584521570.3483502691803;
	Tue, 22 Apr 2025 23:26:24 -0700 (PDT)
Message-ID: <1fc423d1-762c-4e0f-8cf1-d4610c547596@collabora.com>
Date: Wed, 23 Apr 2025 11:26:18 +0500
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath11k: Fix memory reuse logic
To: Baochen Qiang <quic_bqiang@quicinc.com>,
 Jeff Johnson <jjohnson@kernel.org>, Kalle Valo <kvalo@kernel.org>,
 Anilkumar Kolli <quic_akolli@quicinc.com>
Cc: kernel@collabora.com, linux-wireless@vger.kernel.org,
 ath11k@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250418120951.94021-1-usama.anjum@collabora.com>
 <5ae72a5c-798a-4c57-b344-02b231cb881c@quicinc.com>
 <b30bc7f6-845d-4f9d-967e-c04a2b5f13f5@collabora.com>
 <6c4ae1f8-a2ea-4ee3-b67d-4a379f097d9b@quicinc.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <6c4ae1f8-a2ea-4ee3-b67d-4a379f097d9b@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 4/22/25 1:01 PM, Baochen Qiang wrote:
> 
> 
> On 4/22/2025 3:46 PM, Muhammad Usama Anjum wrote:
>> Hi,
>>
>> Thank you for excellent review.
>>
>> On 4/22/25 7:15 AM, Baochen Qiang wrote:
>>>
>>>
>>> On 4/18/2025 8:09 PM, Muhammad Usama Anjum wrote:
>>>> Firmware requests 2 segments at first. 1st segment is of 6799360 whose
>>>> allocation fails and we return success to firmware. Then firmware asks
>>>
>>> Host won't fail in case DMA remapping is enabled. Better to rephrase to make it clear that
>>> the big segment allocation fails in case DMA remapping is not working, usually due to
>>> IOMMU not present or any necessary kernel config not enabled.
>> IOMMU is turned off. I'll make description better.
>>
>>>
>>>> for 22 smaller segments. Those get allocated. At suspend/hibernation
>>>> time, these segments aren't freed as they are reused by firmware.
>>>>
>>>> After resume the firmware asks for 2 segments again with first segment
>>>> of 6799360 and with same vaddr of the first smaller segment which we had
>>>
>>> Not follow you here. What do you mean by 'same vaddr'? firmware does not care about vaddr
>>> at all.
>> So we get request to allocate memory of size = 6799360 and vaddr =
>> 0xABC). We fail it. Then we get request to allocate memory of size =
>> 500000 and vaddr is same 0xABC which gets allocated successfully.
>>
>> When we resume, firmware asks again for 6799360 with 0xABC vaddr even
>> though we had allocated memory of 500000 size at 0xABC. I'm referring to
>> this vaddr that its same.
> 
> OK, get your point. But like I said, firmware doesn't case about vaddr, so it is not
> asking for a 'same vaddr'.
> 
> IMO just mentioning vaddr is not NULL is sufficient.
Okay. I'll update the description to avoid confusion.

> 
>>
>>>
>>>> allocated. Hence vaddr isn't NULL and we compare the type and size if it
>>>> can be reused. Unfornately, we detect that we cannot reuse it and this
>>>
>>> s/Unfornately/Unfortunately/
>>>
>>>> first smaller segment is freed. Then we continue to allocate 6799360 size
>>>> memory from dma which fails and we call ath11k_qmi_free_target_mem_chunk()
>>>> which frees the second smaller segment as well. Later success is returned
>>>> to firmware which asks for 22 smaller segments again. But as we had freed
>>>> 2 segments already, we'll allocate the first 2 new segments again and
>>>> reuse the remaining 20.
>>>>
>>>> This patch is correctiong the skip logic when vaddr is set, but size/type
>>>
>>> s/correctiong/correcting/
>>>
>>>> don't match. In this case, we should use the same skip and success logic
>>>> as used when dma_alloc_coherent fails without freeing the memory area.
>>>>
>>>> We had got reports that memory allocation in this function failed at
>>>
>>> any public link to the report?
>> There's no public report. I've attached the logs. You'll find following
>> error logs in it:
>>
>> ath11k_pci 0000:03:00.0: failed to allocate dma memory for qmi (524288 B
>> type 1)
>> ath11k_pci 0000:03:00.0: failed to allocate qmi target memory: -22
>>
>>
>>>
>>>> resume which made us debug why the reuse logic is wrong. Those failures
>>>> weren't because of the bigger chunk allocation failure as they are
>>>> skipped. Rather these failures were because of smaller chunk allocation
>>>> failures. This patch fixes freeing and allocation of 2 smaller chunks.
>>>
>>> any you saying kernels fail to alloc a smaller chunk? why? is system memory exhausted or
>>> too fragmented?
>> Yes, the smaller chunk doesn't get allocated. I've not been able to
>> reproduce it on my setup. Both system memory exhaustion and
>> fragmentation are the suspects.
> 
> so it is kernel failing to allocate the buffer, not any issue in ath12k leading to this.
> Please help make this clear to avoid confusion.
We caught the bug as kernel was unable to allocate memory at resume.
Later found out that with the optimization in ath11k, we shouldn't be
trying to allocate memory in the first place. That's why I've sent this
patch.

Let me update the description and send v2.


-- 
Regards,
Usama

