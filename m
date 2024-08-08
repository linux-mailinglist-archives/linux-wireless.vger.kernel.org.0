Return-Path: <linux-wireless+bounces-11132-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B425694C3D1
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Aug 2024 19:37:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AE84B20DA3
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Aug 2024 17:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C40A19004F;
	Thu,  8 Aug 2024 17:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="pMG/eeo8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9815913D8A3
	for <linux-wireless@vger.kernel.org>; Thu,  8 Aug 2024 17:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723138626; cv=none; b=G21lSJPvE7hpxfz2PSjN6SHNM3UVxMC2B68os/SOH34NPzy6I7qpshlvjqob/2jYJSHnm/93zLHk4ktASZ3a3t4y5fbDGnvhSrFYBVDFUpuNFGsx5OD8w3xtplgoqF8uQdodGjhv0yXdILrhFn3qT44faUkpDZy8II0DLVfZc2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723138626; c=relaxed/simple;
	bh=DjMJFSg3h/5jJEUwmskiKSHfTFoF570NS4ON6sBbhNI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZA3/bTJp1GHZzRJQEgxkQOcBSSds4QQUAnMYcnRiUC2QPy6iR1wHoH2GvAhEHp9I89INiLyOdXAfCpDquCtkaiZ5DvnF0ximz2mqhVWs/EEgpQ4txhMtwzFGaYMGVV6FzIXGiTG0ENGNJOY0UziPLWg0JBqJUDNKUrNhz/dciLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=pMG/eeo8; arc=none smtp.client-ip=67.231.154.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
Received: from dispatch1-us1.ppe-hosted.com (ip6-localhost [127.0.0.1])
	by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id C2F243056BE
	for <linux-wireless@vger.kernel.org>; Thu,  8 Aug 2024 17:37:02 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 555E28007E;
	Thu,  8 Aug 2024 17:36:54 +0000 (UTC)
Received: from [192.168.100.159] (unknown [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 9B04713C2B0;
	Thu,  8 Aug 2024 10:36:53 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 9B04713C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1723138613;
	bh=DjMJFSg3h/5jJEUwmskiKSHfTFoF570NS4ON6sBbhNI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pMG/eeo8TGS1rdMJ9SIT+GAfTe4ipzx0DYK/kOKDbcO6N0sFqSmdPseFwTHKevPs1
	 fToQ2PuYx2ng8auPxh6XLQwg21izPZAtQApvH3bcFRSXcR5pg1NbVGBnK2SvAvNaAs
	 IEQvGdwUTCnfdxVcEEIop4c8WrHjvPkGGn2LRBX4=
Message-ID: <85f652fa-7dc1-44ca-e185-6ecfc6269de7@candelatech.com>
Date: Thu, 8 Aug 2024 10:36:53 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] wifi: iwlwifi: correctly lookup DMA address in SG table
Content-Language: en-US
To: Benjamin Berg <benjamin@sipsolutions.net>, linux-wireless@vger.kernel.org
Cc: benjamin.berg@intel.com, miriam.rachel.korenblit@intel.com,
 regressions@lists.linux.dev, johannes@sipsolutions.net,
 Kalle Valo <kvalo@kernel.org>, Chris Bainbridge
 <chris.bainbridge@gmail.com>, Rory Little <rory.little@candelatech.com>
References: <20240808172948.303258-1-benjamin@sipsolutions.net>
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <20240808172948.303258-1-benjamin@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1723138616-rak8yNnzxTp4
X-MDID-O:
 us5;at1;1723138616;rak8yNnzxTp4;<greearb@candelatech.com>;9e529b45f983a2e6a3ac1f2f5cf09fc3

On 8/8/24 10:29, Benjamin Berg wrote:
> From: Benjamin Berg <benjamin.berg@intel.com>

Hello,

We'll try testing this on our systems...

Thanks,
Ben

> 
> The code to lookup the scatter gather table entry assumed that it was
> possible to use sg_virt() in order to lookup the DMA address in a mapped
> scatter gather table. However, this assumption is incorrect as the DMA
> mapping code may merge multiple entries into one. In that case, the DMA
> address space may have e.g. two consecutive pages which is correctly
> represented by the scatter gather list entry, however the virtual
> addresses for these two pages may differ and the relationship cannot be
> resolved anymore.
> 
> Avoid this problem entirely by working with the offset into the mapped
> area instead of using virtual addresses. With that we only use the DMA
> length and DMA address from the scatter gather list entries. The
> underlying DMA/IOMMU code is therefore free to merge two entries into
> one even if the virtual addresses space for the area is not continuous.
> 
> Fixes: 90db50755228 ("wifi: iwlwifi: use already mapped data when TXing an AMSDU")
> Reported-by: Chris Bainbridge <chris.bainbridge@gmail.com>
> Closes: https://lore.kernel.org/r/ZrNRoEbdkxkKFMBi@debian.local
> Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
> 
> ---
> 
> Note that I was not yet able to fully verify this patch, but will
> probably get results tomorrow. Unfortunately, much of the testing we do
> internally happens on machines that do not reproduce the problem.
> 
> Also, I think Ben already reported the same issue much earlier. At the
> time, I was not yet aware of the internal reproductions and did not take
> the report seriously.
> ---
>   .../wireless/intel/iwlwifi/pcie/internal.h    |  2 +-
>   .../net/wireless/intel/iwlwifi/pcie/tx-gen2.c |  4 ++-
>   drivers/net/wireless/intel/iwlwifi/pcie/tx.c  | 25 +++++++++++--------
>   3 files changed, 19 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
> index b59de4f80b4b..3af9c2b40ef1 100644
> --- a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
> +++ b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
> @@ -639,7 +639,7 @@ void iwl_trans_pcie_tx_reset(struct iwl_trans *trans);
>   int iwl_pcie_txq_alloc(struct iwl_trans *trans, struct iwl_txq *txq,
>   		       int slots_num, bool cmd_queue);
>   
> -dma_addr_t iwl_pcie_get_sgt_tb_phys(struct sg_table *sgt, void *addr);
> +dma_addr_t iwl_pcie_get_sgt_tb_phys(struct sg_table *sgt, unsigned int offset);
>   struct sg_table *iwl_pcie_prep_tso(struct iwl_trans *trans, struct sk_buff *skb,
>   				   struct iwl_cmd_meta *cmd_meta,
>   				   u8 **hdr, unsigned int hdr_room);
> diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
> index 2e780fb2da42..54d26523f692 100644
> --- a/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
> +++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
> @@ -168,6 +168,7 @@ static int iwl_txq_gen2_build_amsdu(struct iwl_trans *trans,
>   	struct ieee80211_hdr *hdr = (void *)skb->data;
>   	unsigned int snap_ip_tcp_hdrlen, ip_hdrlen, total_len, hdr_room;
>   	unsigned int mss = skb_shinfo(skb)->gso_size;
> +	unsigned int data_offset = 0;
>   	dma_addr_t start_hdr_phys;
>   	u16 length, amsdu_pad;
>   	u8 *start_hdr;
> @@ -260,7 +261,7 @@ static int iwl_txq_gen2_build_amsdu(struct iwl_trans *trans,
>   			int ret;
>   
>   			tb_len = min_t(unsigned int, tso.size, data_left);
> -			tb_phys = iwl_pcie_get_sgt_tb_phys(sgt, tso.data);
> +			tb_phys = iwl_pcie_get_sgt_tb_phys(sgt, data_offset);
>   			/* Not a real mapping error, use direct comparison */
>   			if (unlikely(tb_phys == DMA_MAPPING_ERROR))
>   				goto out_err;
> @@ -272,6 +273,7 @@ static int iwl_txq_gen2_build_amsdu(struct iwl_trans *trans,
>   				goto out_err;
>   
>   			data_left -= tb_len;
> +			data_offset += tb_len;
>   			tso_build_data(skb, &tso, tb_len);
>   		}
>   	}
> diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
> index 22d482ae53d9..78f417cdb9ac 100644
> --- a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
> +++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
> @@ -1814,23 +1814,24 @@ static void *iwl_pcie_get_page_hdr(struct iwl_trans *trans,
>   /**
>    * iwl_pcie_get_sgt_tb_phys - Find TB address in mapped SG list
>    * @sgt: scatter gather table
> - * @addr: Virtual address
> + * @offset: Offset into the mapped memory (i.e. SKB payload data)
>    *
> - * Find the entry that includes the address for the given address and return
> - * correct physical address for the TB entry.
> + * Find the DMA address that corresponds to the SKB payload data at the
> + * position given by @offset.
>    *
>    * Returns: Address for TB entry
>    */
> -dma_addr_t iwl_pcie_get_sgt_tb_phys(struct sg_table *sgt, void *addr)
> +dma_addr_t iwl_pcie_get_sgt_tb_phys(struct sg_table *sgt, unsigned int offset)
>   {
>   	struct scatterlist *sg;
> +	unsigned int sg_offset = 0;
>   	int i;
>   
>   	for_each_sgtable_dma_sg(sgt, sg, i) {
> -		if (addr >= sg_virt(sg) &&
> -		    (u8 *)addr < (u8 *)sg_virt(sg) + sg_dma_len(sg))
> -			return sg_dma_address(sg) +
> -			       ((unsigned long)addr - (unsigned long)sg_virt(sg));
> +		if (offset >= sg_offset && offset < sg_offset + sg_dma_len(sg))
> +			return sg_dma_address(sg) + offset - sg_offset;
> +
> +		sg_offset += sg_dma_len(sg);
>   	}
>   
>   	WARN_ON_ONCE(1);
> @@ -1875,7 +1876,9 @@ struct sg_table *iwl_pcie_prep_tso(struct iwl_trans *trans, struct sk_buff *skb,
>   
>   	sg_init_table(sgt->sgl, skb_shinfo(skb)->nr_frags + 1);
>   
> -	sgt->orig_nents = skb_to_sgvec(skb, sgt->sgl, 0, skb->len);
> +	/* Only map the data, not the header (it is copied to the TSO page) */
> +	sgt->orig_nents = skb_to_sgvec(skb, sgt->sgl, skb_headlen(skb),
> +				       skb->data_len);
>   	if (WARN_ON_ONCE(sgt->orig_nents <= 0))
>   		return NULL;
>   
> @@ -1900,6 +1903,7 @@ static int iwl_fill_data_tbs_amsdu(struct iwl_trans *trans, struct sk_buff *skb,
>   	struct ieee80211_hdr *hdr = (void *)skb->data;
>   	unsigned int snap_ip_tcp_hdrlen, ip_hdrlen, total_len, hdr_room;
>   	unsigned int mss = skb_shinfo(skb)->gso_size;
> +	unsigned int data_offset = 0;
>   	u16 length, iv_len, amsdu_pad;
>   	dma_addr_t start_hdr_phys;
>   	u8 *start_hdr, *pos_hdr;
> @@ -2000,7 +2004,7 @@ static int iwl_fill_data_tbs_amsdu(struct iwl_trans *trans, struct sk_buff *skb,
>   						  data_left);
>   			dma_addr_t tb_phys;
>   
> -			tb_phys = iwl_pcie_get_sgt_tb_phys(sgt, tso.data);
> +			tb_phys = iwl_pcie_get_sgt_tb_phys(sgt, data_offset);
>   			/* Not a real mapping error, use direct comparison */
>   			if (unlikely(tb_phys == DMA_MAPPING_ERROR))
>   				return -EINVAL;
> @@ -2011,6 +2015,7 @@ static int iwl_fill_data_tbs_amsdu(struct iwl_trans *trans, struct sk_buff *skb,
>   						tb_phys, size);
>   
>   			data_left -= size;
> +			data_offset += size;
>   			tso_build_data(skb, &tso, size);
>   		}
>   	}

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com



