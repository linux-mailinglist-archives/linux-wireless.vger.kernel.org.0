Return-Path: <linux-wireless+bounces-22064-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C463A9C69F
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Apr 2025 13:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71ED74C2930
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Apr 2025 11:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED37723FC49;
	Fri, 25 Apr 2025 11:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b="LJ8iAYbR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0932D23644D;
	Fri, 25 Apr 2025 11:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745578965; cv=pass; b=F2kUuuM2WZimdZ342V3PMbXskTWUZtnYuiChJZPhh2MU8ticU6NrlLPmAROUde9xFZi6B7xQPGU1uWBOkMdokMm/Y11Xj5/5vuzCgqqHFEvTMWK3Mc9jPzxFTm3wgj9/YNNLmmoj7OfHB3AYoD2p07YSBAf6sHV9efl7ndztpHo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745578965; c=relaxed/simple;
	bh=BVgx1QySlNxUPNCBrRwJJyxTA6sC6sB0fEe63mP+ULo=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=GC/nn4+WKGhVjEhnR0pYzxakR5WfdGlSmh+KQ2kNJ+lqx5j6JIp4+zshQSQJcmiraQM9a6898ps9IxjbR8mqVTBiHvE2FkKXKuNgIsld4DiemagR9JnWfqlYv2CbutWtLVJaVwbzp41Ju/JKEisUU81/JvHLmCZ7/qwWGHg1QU4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b=LJ8iAYbR; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1745578945; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=oGEJHjQKTfu8Q6UyGnSVrrN+r4htVB6m+ue6Y/BKbRXL7j6ovKminEdixEiQVMSCxQdFL8WuhMjfS4eJZNj4NTxmqGGIFanHmshWQTxtvhMJzGV32tG5Jc6xlhvRahrro37xDB9xwL2/lzqasofbZXC5y7yGByVfMtl/xbenKaQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1745578945; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=nd5vulT6QD8qk2DwgRwQTIs7bhDvO/LHs3zkNtr0Exs=; 
	b=ZWWL+uFGVd9Ql0v89/LF/3TUkVYQxKX1fDToCxxDw9/+GBjbhrnNenj61yXgTQfXN0HWOKDPSPAQ2zeSLhC8SqNBgyA19G4sTFZuOiiRUtlphfp/mDcgU0Q3TkY8ZM2xjajButpec9DKum4EKORqNw8LNQGRZ0dPMWcbNJqz7FI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=usama.anjum@collabora.com;
	dmarc=pass header.from=<usama.anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1745578945;
	s=zohomail; d=collabora.com; i=usama.anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Cc:Cc:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=nd5vulT6QD8qk2DwgRwQTIs7bhDvO/LHs3zkNtr0Exs=;
	b=LJ8iAYbRsxUS79RtDlzA1kfCSv4rl2Z4/n6O8gCjrq7u5xt5M1tXXFSInGnvzF/p
	SNIatSvLl6AcTnqaETW2g2juCLYMBlhlNJJQo8Oftb3v/uCjY/roRwAdFSDHr4OaLjp
	+yjVCkw8/VAI/tC45hYksfVKNBcikQVn+UHIgRGk=
Received: by mx.zohomail.com with SMTPS id 17455789416681019.0003601830132;
	Fri, 25 Apr 2025 04:02:21 -0700 (PDT)
Message-ID: <5f51e283-f29a-4b3f-ad36-d6d851baeb7f@collabora.com>
Date: Fri, 25 Apr 2025 16:02:15 +0500
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
Subject: Re: [PATCH v3] wifi: ath11k: Fix MHI target memory reuse logic
To: Baochen Qiang <quic_bqiang@quicinc.com>, jeff.johnson@oss.qualcomm.com,
 Jeff Johnson <jjohnson@kernel.org>
References: <20250425055141.2041712-1-usama.anjum@collabora.com>
 <d83868de-7ff6-4a54-8bee-4652c2479da3@quicinc.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <d83868de-7ff6-4a54-8bee-4652c2479da3@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 4/25/25 3:36 PM, Baochen Qiang wrote:
> 
> 
> On 4/25/2025 1:51 PM, Muhammad Usama Anjum wrote:
>> Firmware requests 2 segments at first. The first segment is of 6799360
>> whose allocation fails due to dma remapping not available. The success
>> is returned to firmware. Then firmware asks for 22 smaller segments
>> instead of 2 big ones. Those get allocated successfully. At suspend/
>> hibernation time, these segments aren't freed as they will be reused
>> by firmware after resuming.
>>
>> After resuming, the firmware asks for the 2 segments again with the
>> first segment of 6799360 size. Since chunk->vaddr is not NULL, the
>> type and size are compared with the previous type and size to know if
>> it can be reused or not. Unfortunately, it is detected that it cannot
>> be reused and this first smaller segment is freed. Then we continue to
>> allocate 6799360 size memory which fails and ath11k_qmi_free_target_mem_chunk()
>> is called which frees the second smaller segment as well. Later success
>> is returned to firmware which asks for 22 smaller segments again. But
>> as we had freed 2 segments already, we'll allocate the first 2 new
>> smaller segments again and reuse the remaining 20. Hence 20 small
>> segments are being reused instead of 22.
>>
>> Add skip logic when vaddr is set, but size/type don't match. Use the
>> same skip and success logic as used when dma_alloc_coherent() fails
> 
> 
> till here it is good.
> 
> but from below
> 
>> without freeing the memory area. The following error are being fixed at
>> resume:
>>
>> 	kernel: ath11k_pci 0000:03:00.0: failed to allocate dma memory for qmi (524288 B type 1)
>> 	ath11k_pci 0000:03:00.0: failed to allocate qmi target memory: -22
>>
>> Those failures aren't because of the bigger chunk allocation failure as
>> they are skipped. Rather these failures are because of smaller chunk
>> allocation failures. This patch fixes freeing and allocation of 2 smaller
>> chunks.
> 
> to here not good to me, as it gives me the impression that you are fixing a kernel
> allocation failure.
> 
> How about rephrase like:
> 
> By skipping, the possibility of resume failure due to kernel failing to allocate memory
> for QMI can be avoided.
I don't know why do you feel like that even in v3.

Anyways, I'll send v4 and hope that you'll ack that one.

> 
>>
>> Tested-on: WCN6855 WLAN.HSP.1.1-03926.13-QCAHSPSWPL_V2_SILICONZ_CE-2.52297.6
>>
>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>> ---
>> Changes since v1:
>> - Update description
>>
>> Changes since v2:
>> - Update description
>> ---
>>  drivers/net/wireless/ath/ath11k/qmi.c | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>>
>> diff --git a/drivers/net/wireless/ath/ath11k/qmi.c b/drivers/net/wireless/ath/ath11k/qmi.c
>> index 47b9d4126d3a9..2782f4723e413 100644
>> --- a/drivers/net/wireless/ath/ath11k/qmi.c
>> +++ b/drivers/net/wireless/ath/ath11k/qmi.c
>> @@ -1993,6 +1993,15 @@ static int ath11k_qmi_alloc_target_mem_chunk(struct ath11k_base *ab)
>>  			    chunk->prev_size == chunk->size)
>>  				continue;
>>  
>> +			if (ab->qmi.mem_seg_count <= ATH11K_QMI_FW_MEM_REQ_SEGMENT_CNT) {
>> +				ath11k_dbg(ab, ATH11K_DBG_QMI,
>> +					   "size/type mismatch (current %d %u) (prev %d %u), try later with small size\n",
>> +					    chunk->size, chunk->type,
>> +					    chunk->prev_size, chunk->prev_type);
>> +				ab->qmi.target_mem_delayed = true;
>> +				return 0;
>> +			}
>> +
>>  			/* cannot reuse the existing chunk */
>>  			dma_free_coherent(ab->dev, chunk->prev_size,
>>  					  chunk->vaddr, chunk->paddr);
> 


-- 
Regards,
Usama

