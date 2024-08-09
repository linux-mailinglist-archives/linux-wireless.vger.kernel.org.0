Return-Path: <linux-wireless+bounces-11230-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A9F494D5F6
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2024 20:03:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 106FE281ECF
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2024 18:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 269C23770D;
	Fri,  9 Aug 2024 18:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="iS8W/9ep"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1C31CA94
	for <linux-wireless@vger.kernel.org>; Fri,  9 Aug 2024 18:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723226632; cv=none; b=W1UpSyAWtXY2gHkmINKcAUDCL2iwjvla/nIOEkO3lDpTTlmNhnHnzwf9nmhhGm0o3+1BZEXMbqaM/yi/aDo3moQ8ldGp1kyzQ5InZ7H0hRuNjuAoDNNtZ85mG2ZhaAqq329eARQ0NAmxvB8O6P34sZsS3lF5/aYsldGWSyKEI/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723226632; c=relaxed/simple;
	bh=1YCWIii/i6R5rT/daIoObdAdlccM6AMejZ+PHrkgCyI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jPdqe/xrmf3GauYT2scdUZas2KXUC/knXeTnMgC7ok5i1S/laIJuhoAYmWHqz38gpT9tjNbG+ZgIHhbaENEh4GxOF2Z4/HnmNxQcFM9ByZSV2Clb55PeyaPTykRGokfAayngSa531aJ3NYJDHzc9NQ14w/P6SKXfnRAwwIgxOoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=iS8W/9ep; arc=none smtp.client-ip=67.231.154.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id EF77F24006E;
	Fri,  9 Aug 2024 18:03:40 +0000 (UTC)
Received: from [192.168.0.11] (c-98-247-188-21.hsd1.wa.comcast.net [98.247.188.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id EA3F013C2B0;
	Fri,  9 Aug 2024 11:03:39 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com EA3F013C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1723226620;
	bh=1YCWIii/i6R5rT/daIoObdAdlccM6AMejZ+PHrkgCyI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=iS8W/9epPVaSrbePBNd8uc0alMa7D8U4cW3iQdEMA+yTxIc/APwOGbmG7XzBOrE0c
	 Dx+a2eBevE3AuKF5ai8fnExrJU+sLqOFuEG4NtBlv4v/TrW9DDrvYVLBsW7CimluZy
	 DM4XJUvbcodT+RfNZDwy7VS0PBb8/xc8eW+g5kEk=
Message-ID: <c7e27caf-3001-4069-9e26-54e544a2e06e@candelatech.com>
Date: Fri, 9 Aug 2024 11:03:38 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: iwlwifi: correctly lookup DMA address in SG table
To: Ben Greear <greearb@candelatech.com>,
 Benjamin Berg <benjamin@sipsolutions.net>, linux-wireless@vger.kernel.org
Cc: benjamin.berg@intel.com, miriam.rachel.korenblit@intel.com,
 regressions@lists.linux.dev, johannes@sipsolutions.net,
 Kalle Valo <kvalo@kernel.org>, Chris Bainbridge
 <chris.bainbridge@gmail.com>, Rory Little <rory.little@candelatech.com>
References: <20240808172948.303258-1-benjamin@sipsolutions.net>
 <85f652fa-7dc1-44ca-e185-6ecfc6269de7@candelatech.com>
Content-Language: en-US
From: Rory Little <rory@candelatech.com>
In-Reply-To: <85f652fa-7dc1-44ca-e185-6ecfc6269de7@candelatech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MDID: 1723226622-of81SaQTi8ec
X-MDID-O:
 us5;at1;1723226622;of81SaQTi8ec;<rory@candelatech.com>;9e529b45f983a2e6a3ac1f2f5cf09fc3

Hi,

We have tested this on our system and verified that we are no longer 
seeing the issue with this patch applied.

- Rory

On 8/8/24 10:36, Ben Greear wrote:
> On 8/8/24 10:29, Benjamin Berg wrote:
>> From: Benjamin Berg <benjamin.berg@intel.com>
> 
> Hello,
> 
> We'll try testing this on our systems...
> 
> Thanks,
> Ben
> 
>>
>> The code to lookup the scatter gather table entry assumed that it was
>> possible to use sg_virt() in order to lookup the DMA address in a mapped
>> scatter gather table. However, this assumption is incorrect as the DMA
>> mapping code may merge multiple entries into one. In that case, the DMA
>> address space may have e.g. two consecutive pages which is correctly
>> represented by the scatter gather list entry, however the virtual
>> addresses for these two pages may differ and the relationship cannot be
>> resolved anymore.
>>
>> Avoid this problem entirely by working with the offset into the mapped
>> area instead of using virtual addresses. With that we only use the DMA
>> length and DMA address from the scatter gather list entries. The
>> underlying DMA/IOMMU code is therefore free to merge two entries into
>> one even if the virtual addresses space for the area is not continuous.
>>
>> Fixes: 90db50755228 ("wifi: iwlwifi: use already mapped data when 
>> TXing an AMSDU")
>> Reported-by: Chris Bainbridge <chris.bainbridge@gmail.com>
>> Closes: https://lore.kernel.org/r/ZrNRoEbdkxkKFMBi@debian.local
>> Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
>>
>> ---
>>
>> Note that I was not yet able to fully verify this patch, but will
>> probably get results tomorrow. Unfortunately, much of the testing we do
>> internally happens on machines that do not reproduce the problem.
>>
>> Also, I think Ben already reported the same issue much earlier. At the
>> time, I was not yet aware of the internal reproductions and did not take
>> the report seriously.
>> ---
>>   .../wireless/intel/iwlwifi/pcie/internal.h    |  2 +-
>>   .../net/wireless/intel/iwlwifi/pcie/tx-gen2.c |  4 ++-
>>   drivers/net/wireless/intel/iwlwifi/pcie/tx.c  | 25 +++++++++++--------
>>   3 files changed, 19 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h 
>> b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
>> index b59de4f80b4b..3af9c2b40ef1 100644
>> --- a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
>> +++ b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
>> @@ -639,7 +639,7 @@ void iwl_trans_pcie_tx_reset(struct iwl_trans 
>> *trans);
>>   int iwl_pcie_txq_alloc(struct iwl_trans *trans, struct iwl_txq *txq,
>>                  int slots_num, bool cmd_queue);
>> -dma_addr_t iwl_pcie_get_sgt_tb_phys(struct sg_table *sgt, void *addr);
>> +dma_addr_t iwl_pcie_get_sgt_tb_phys(struct sg_table *sgt, unsigned 
>> int offset);
>>   struct sg_table *iwl_pcie_prep_tso(struct iwl_trans *trans, struct 
>> sk_buff *skb,
>>                      struct iwl_cmd_meta *cmd_meta,
>>                      u8 **hdr, unsigned int hdr_room);
>> diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c 
>> b/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
>> index 2e780fb2da42..54d26523f692 100644
>> --- a/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
>> +++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
>> @@ -168,6 +168,7 @@ static int iwl_txq_gen2_build_amsdu(struct 
>> iwl_trans *trans,
>>       struct ieee80211_hdr *hdr = (void *)skb->data;
>>       unsigned int snap_ip_tcp_hdrlen, ip_hdrlen, total_len, hdr_room;
>>       unsigned int mss = skb_shinfo(skb)->gso_size;
>> +    unsigned int data_offset = 0;
>>       dma_addr_t start_hdr_phys;
>>       u16 length, amsdu_pad;
>>       u8 *start_hdr;
>> @@ -260,7 +261,7 @@ static int iwl_txq_gen2_build_amsdu(struct 
>> iwl_trans *trans,
>>               int ret;
>>               tb_len = min_t(unsigned int, tso.size, data_left);
>> -            tb_phys = iwl_pcie_get_sgt_tb_phys(sgt, tso.data);
>> +            tb_phys = iwl_pcie_get_sgt_tb_phys(sgt, data_offset);
>>               /* Not a real mapping error, use direct comparison */
>>               if (unlikely(tb_phys == DMA_MAPPING_ERROR))
>>                   goto out_err;
>> @@ -272,6 +273,7 @@ static int iwl_txq_gen2_build_amsdu(struct 
>> iwl_trans *trans,
>>                   goto out_err;
>>               data_left -= tb_len;
>> +            data_offset += tb_len;
>>               tso_build_data(skb, &tso, tb_len);
>>           }
>>       }
>> diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c 
>> b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
>> index 22d482ae53d9..78f417cdb9ac 100644
>> --- a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
>> +++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
>> @@ -1814,23 +1814,24 @@ static void *iwl_pcie_get_page_hdr(struct 
>> iwl_trans *trans,
>>   /**
>>    * iwl_pcie_get_sgt_tb_phys - Find TB address in mapped SG list
>>    * @sgt: scatter gather table
>> - * @addr: Virtual address
>> + * @offset: Offset into the mapped memory (i.e. SKB payload data)
>>    *
>> - * Find the entry that includes the address for the given address and 
>> return
>> - * correct physical address for the TB entry.
>> + * Find the DMA address that corresponds to the SKB payload data at the
>> + * position given by @offset.
>>    *
>>    * Returns: Address for TB entry
>>    */
>> -dma_addr_t iwl_pcie_get_sgt_tb_phys(struct sg_table *sgt, void *addr)
>> +dma_addr_t iwl_pcie_get_sgt_tb_phys(struct sg_table *sgt, unsigned 
>> int offset)
>>   {
>>       struct scatterlist *sg;
>> +    unsigned int sg_offset = 0;
>>       int i;
>>       for_each_sgtable_dma_sg(sgt, sg, i) {
>> -        if (addr >= sg_virt(sg) &&
>> -            (u8 *)addr < (u8 *)sg_virt(sg) + sg_dma_len(sg))
>> -            return sg_dma_address(sg) +
>> -                   ((unsigned long)addr - (unsigned long)sg_virt(sg));
>> +        if (offset >= sg_offset && offset < sg_offset + sg_dma_len(sg))
>> +            return sg_dma_address(sg) + offset - sg_offset;
>> +
>> +        sg_offset += sg_dma_len(sg);
>>       }
>>       WARN_ON_ONCE(1);
>> @@ -1875,7 +1876,9 @@ struct sg_table *iwl_pcie_prep_tso(struct 
>> iwl_trans *trans, struct sk_buff *skb,
>>       sg_init_table(sgt->sgl, skb_shinfo(skb)->nr_frags + 1);
>> -    sgt->orig_nents = skb_to_sgvec(skb, sgt->sgl, 0, skb->len);
>> +    /* Only map the data, not the header (it is copied to the TSO 
>> page) */
>> +    sgt->orig_nents = skb_to_sgvec(skb, sgt->sgl, skb_headlen(skb),
>> +                       skb->data_len);
>>       if (WARN_ON_ONCE(sgt->orig_nents <= 0))
>>           return NULL;
>> @@ -1900,6 +1903,7 @@ static int iwl_fill_data_tbs_amsdu(struct 
>> iwl_trans *trans, struct sk_buff *skb,
>>       struct ieee80211_hdr *hdr = (void *)skb->data;
>>       unsigned int snap_ip_tcp_hdrlen, ip_hdrlen, total_len, hdr_room;
>>       unsigned int mss = skb_shinfo(skb)->gso_size;
>> +    unsigned int data_offset = 0;
>>       u16 length, iv_len, amsdu_pad;
>>       dma_addr_t start_hdr_phys;
>>       u8 *start_hdr, *pos_hdr;
>> @@ -2000,7 +2004,7 @@ static int iwl_fill_data_tbs_amsdu(struct 
>> iwl_trans *trans, struct sk_buff *skb,
>>                             data_left);
>>               dma_addr_t tb_phys;
>> -            tb_phys = iwl_pcie_get_sgt_tb_phys(sgt, tso.data);
>> +            tb_phys = iwl_pcie_get_sgt_tb_phys(sgt, data_offset);
>>               /* Not a real mapping error, use direct comparison */
>>               if (unlikely(tb_phys == DMA_MAPPING_ERROR))
>>                   return -EINVAL;
>> @@ -2011,6 +2015,7 @@ static int iwl_fill_data_tbs_amsdu(struct 
>> iwl_trans *trans, struct sk_buff *skb,
>>                           tb_phys, size);
>>               data_left -= size;
>> +            data_offset += size;
>>               tso_build_data(skb, &tso, size);
>>           }
>>       }
> 

