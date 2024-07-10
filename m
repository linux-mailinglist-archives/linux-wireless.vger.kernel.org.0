Return-Path: <linux-wireless+bounces-10159-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B215892DB23
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jul 2024 23:41:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D7E21F2245E
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jul 2024 21:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DF20132113;
	Wed, 10 Jul 2024 21:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="g7bYotAD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51CCA83CCB
	for <linux-wireless@vger.kernel.org>; Wed, 10 Jul 2024 21:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720647695; cv=none; b=cszSAf1F7ygD2RQpp9NdfWtP1UrVNGPTBgXhzdOHfoqzg/uM2cFGc5O2iWR+Pd+oVKWiVDXKaTSeRXFS/GO3SZ3Mkwtt+zDy4if4qYL4pY3fbhOJUBfotc4l3z2OpFi0m4dhyGhdKoZDV1VU2KuhvraKcDHjXtJaOE6P+i1oyVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720647695; c=relaxed/simple;
	bh=n1chXDuHVp7c5GNJRo9QMoH43T+sIFDUe6g3cHf3W6c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cx0FoEaisxjRwgd0TwuQSIF5ItqpYFTpmxGI9NZm+J7e8hTHJ4P85ooO1nf8+V2pU3FlxYJT8jYt1y11F+uvK6N8z4M8ErTaNpRsvxYwlbiDWdtwHgOhge+uvF2yqQxE4KSpMzCaVhUs34cqkCmB45MvLlJ991TwtmQchGcPHHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=g7bYotAD; arc=none smtp.client-ip=148.163.129.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 872715000A0;
	Wed, 10 Jul 2024 21:41:23 +0000 (UTC)
Received: from [192.168.100.159] (unknown [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 038BD13C2B0;
	Wed, 10 Jul 2024 14:41:22 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 038BD13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1720647683;
	bh=n1chXDuHVp7c5GNJRo9QMoH43T+sIFDUe6g3cHf3W6c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=g7bYotADYBrwC2kOylvwqQdrQ6tzgA7E+f3+nIG1+55mWOUeey+gUnampiI0gUKwU
	 rf0k26jE6gsZSc8KDNUI2zHVzp3uXxIi3ZeSdjuQLBbVYScu+YsnhIutIPFlhHH4xR
	 Pecc0Ie9KEdMN1DPtOzgwvuJDEVw8dCSKU7Y23rk=
Message-ID: <a0a7dbf2-b4c5-ddf8-59e9-7e8a067e2f11@candelatech.com>
Date: Wed, 10 Jul 2024 14:41:22 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 06/18] wifi: iwlwifi: keep the TSO and workaround pages
 mapped
Content-Language: en-US
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
 johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, Benjamin Berg <benjamin.berg@intel.com>,
 Johannes Berg <johannes.berg@intel.com>
References: <20240703095906.833028-1-miriam.rachel.korenblit@intel.com>
 <20240703125541.7ced468fe431.Ibb109867dc680c37fe8d891e9ab9ef64ed5c5d2d@changeid>
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <20240703125541.7ced468fe431.Ibb109867dc680c37fe8d891e9ab9ef64ed5c5d2d@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1720647684-kcyEaAiEWt7p
X-MDID-O:
 us5;ut7;1720647684;kcyEaAiEWt7p;<greearb@candelatech.com>;50171c4d2da3acbebc7f7131b075104c

On 7/3/24 02:58, Miri Korenblit wrote:
> From: Benjamin Berg <benjamin.berg@intel.com>
> 
> Map the pages when allocating them so that we will not need to map each
> of the used fragments at a later point.
> 
> For now the mapping is not used, this will be changed in a later commit.
> 
> Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
> Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
> Reviewed-by: Johannes Berg <johannes.berg@intel.com>

Hello,

I patched every iwlwifi and mac80211 patch I found on the mailing list
up to this one into my 6.10-ish tree.

I see immediate and reproducible crash when I send TCP traffic on be200
radio.  I bisected it to this particular patch.

Previously I was only testing download direction and it ran fine, and UDP
traffic upload seems to run OK, so it must be triggered by large TCP
frames, and based on what this patch is messing with, that makes sense.
Always possible I messed up when applying patches of course.


Oops: general protection fault, probably for non-canonical address 0x5088000000ff0: 0000 [#1] PREEMPT SMP
CPU: 3 PID: 800 Comm: irq/181-iwlwifi Tainted: G        W          6.10.0-rc7+ #17
Hardware name: Default string Default string/SKYBAY, BIOS 5.12 02/15/2023
RIP: 0010:iwl_pcie_prep_tso+0x213/0x2b0 [iwlwifi]
Code: 01 e0 49 c1 e4 06 41 b8 01 00 00 00 48 c1 f8 06 48 c1 e0 0c 48 01 d0 31 d2 48 89 45 08 48 b8 e8 0f 00 00 80 88 ff ff0
RSP: 0018:ffffc900001e0678 EFLAGS: 00010207
RAX: ffff888000000fe8 RBX: ffff8881263a3500 RCX: 0000000000001000
RDX: 0000000000000000 RSI: ffffffff82b6ee60 RDI: ffff8881128d3748
RBP: ffffe8ffffb882d0 R08: 0000000000000001 R09: 0000000000000020
R10: 0000000000000002 R11: ffff8881128d35b8 R12: 0005088000000fe8
R13: ffff888111b90028 R14: ffff88810f664438 R15: ffff8881263a3540
FS:  0000000000000000(0000) GS:ffff88845db80000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000040f70fe0 CR3: 0000000002a50002 CR4: 00000000003706f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  <IRQ>
  ? die_addr+0x2d/0x80
  ? exc_general_protection+0x1aa/0x3f0
  ? asm_exc_general_protection+0x22/0x30
  ? iwl_pcie_prep_tso+0x213/0x2b0 [iwlwifi]
  ? iwl_pcie_prep_tso+0x1b2/0x2b0 [iwlwifi]
  iwl_txq_gen2_tx+0x7ec/0xf10 [iwlwifi]
  iwl_mvm_tx_mpdu+0x1da/0x560 [iwlmvm]
  iwl_mvm_tx_skb_sta+0x34c/0x540 [iwlmvm]
  iwl_mvm_tx_skb+0x12/0x30 [iwlmvm]
  iwl_mvm_mac_itxq_xmit+0xbe/0x1e0 [iwlmvm]
  ieee80211_queue_skb+0x557/0x6d0 [mac80211]
  __ieee80211_xmit_fast+0x7b2/0xad0 [mac80211]
  ? lock_acquire+0xc7/0x2d0
  ? lock_is_held_type+0xa5/0x110
  ? find_held_lock+0x2b/0x80
  ? skb_mac_gso_segment+0x130/0x1e0
  ? lock_release+0xc6/0x290
  ? skb_mac_gso_segment+0x13a/0x1e0
  __ieee80211_subif_start_xmit+0x22d/0x5a0 [mac80211]
  ieee80211_subif_start_xmit+0x57/0x570 [mac80211]
  ? dev_queue_xmit_nit+0x2cd/0x3a0
  ? lock_release+0xc6/0x290
  ? dev_hard_start_xmit+0x76/0x250
  dev_hard_start_xmit+0x76/0x250
  __dev_queue_xmit+0x246/0x1270
  ? lockdep_hardirqs_on_prepare+0xa7/0x170
  ? eth_header+0x21/0xb0
  ip_finish_output2+0x230/0xaa0
  __ip_queue_xmit+0x1e6/0x760
  __tcp_transmit_skb+0x521/0xdc0
  ? find_held_lock+0x2b/0x80
  tcp_write_xmit+0x4d7/0x17a0
  ? lock_is_held_type+0xa5/0x110
  tcp_tsq_handler+0x8a/0xd0
  tcp_tasklet_func+0xbc/0x140
  tasklet_action_common.constprop.0+0xfd/0x2f0
  handle_softirqs+0xd0/0x440
  ? iwl_pcie_irq_rx_msix_handler+0xe5/0x140 [iwlwifi]
  ? iwl_pcie_irq_rx_msix_handler+0x5d/0x140 [iwlwifi]
  do_softirq.part.0+0x3a/0x90
  </IRQ>
  <TASK>
  __local_bh_enable_ip+0xbd/0xd0
  ? iwl_pcie_irq_rx_msix_handler+0xe5/0x140 [iwlwifi]
  iwl_pcie_irq_rx_msix_handler+0xed/0x140 [iwlwifi]
  ? irq_thread+0x8c/0x200
  irq_thread_fn+0x14/0x50
  ? irq_thread+0x8c/0x200
  irq_thread+0x12c/0x200
  ? disable_irq_nosync+0x10/0x10
  ? irq_set_affinity_notifier+0x140/0x140
  ? irq_check_status_bit+0xf0/0xf0
  kthread+0xd7/0x110
  ? kthread_insert_work_sanity_check+0x50/0x50
  ret_from_fork+0x28/0x40
  ? kthread_insert_work_sanity_check+0x50/0x50
  ret_from_fork_asm+0x11/0x20
  </TASK>


> ---
>   .../wireless/intel/iwlwifi/pcie/internal.h    | 30 +++++++++-
>   .../net/wireless/intel/iwlwifi/pcie/tx-gen2.c | 22 ++++++-
>   drivers/net/wireless/intel/iwlwifi/pcie/tx.c  | 60 +++++++++++++++----
>   3 files changed, 95 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
> index d63c1c284f70..b59de4f80b4b 100644
> --- a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
> +++ b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
> @@ -603,6 +603,22 @@ struct iwl_tso_hdr_page {
>   	u8 *pos;
>   };
>   
> +/*
> + * Note that we put this struct *last* in the page. By doing that, we ensure
> + * that no TB referencing this page can trigger the 32-bit boundary hardware
> + * bug.
> + */
> +struct iwl_tso_page_info {
> +	dma_addr_t dma_addr;
> +	struct page *next;
> +	refcount_t use_count;
> +};
> +
> +#define IWL_TSO_PAGE_DATA_SIZE	(PAGE_SIZE - sizeof(struct iwl_tso_page_info))
> +#define IWL_TSO_PAGE_INFO(addr)	\
> +	((struct iwl_tso_page_info *)(((unsigned long)addr & PAGE_MASK) + \
> +				      IWL_TSO_PAGE_DATA_SIZE))
> +
>   int iwl_pcie_tx_init(struct iwl_trans *trans);
>   void iwl_pcie_tx_start(struct iwl_trans *trans, u32 scd_base_addr);
>   int iwl_pcie_tx_stop(struct iwl_trans *trans);
> @@ -628,8 +644,18 @@ struct sg_table *iwl_pcie_prep_tso(struct iwl_trans *trans, struct sk_buff *skb,
>   				   struct iwl_cmd_meta *cmd_meta,
>   				   u8 **hdr, unsigned int hdr_room);
>   
> -void iwl_pcie_free_tso_page(struct iwl_trans *trans, struct sk_buff *skb,
> -			    struct iwl_cmd_meta *cmd_meta);
> +void iwl_pcie_free_tso_pages(struct iwl_trans *trans, struct sk_buff *skb,
> +			     struct iwl_cmd_meta *cmd_meta);
> +
> +static inline dma_addr_t iwl_pcie_get_tso_page_phys(void *addr)
> +{
> +	dma_addr_t res;
> +
> +	res = IWL_TSO_PAGE_INFO(addr)->dma_addr;
> +	res += (unsigned long)addr & ~PAGE_MASK;
> +
> +	return res;
> +}
>   
>   static inline dma_addr_t
>   iwl_txq_get_first_tb_dma(struct iwl_txq *txq, int idx)
> diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
> index 3dcce6a8da50..10ee2c328458 100644
> --- a/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
> +++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
> @@ -19,8 +19,10 @@ static struct page *get_workaround_page(struct iwl_trans *trans,
>   					struct sk_buff *skb)
>   {
>   	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
> +	struct iwl_tso_page_info *info;
>   	struct page **page_ptr;
>   	struct page *ret;
> +	dma_addr_t phys;
>   
>   	page_ptr = (void *)((u8 *)skb->cb + trans_pcie->txqs.page_offs);
>   
> @@ -28,8 +30,22 @@ static struct page *get_workaround_page(struct iwl_trans *trans,
>   	if (!ret)
>   		return NULL;
>   
> +	info = IWL_TSO_PAGE_INFO(page_address(ret));
> +
> +	/* Create a DMA mapping for the page */
> +	phys = dma_map_page_attrs(trans->dev, ret, 0, PAGE_SIZE,
> +				  DMA_TO_DEVICE, DMA_ATTR_SKIP_CPU_SYNC);
> +	if (unlikely(dma_mapping_error(trans->dev, phys))) {
> +		__free_page(ret);
> +		return NULL;
> +	}
> +
> +	/* Store physical address and set use count */
> +	info->dma_addr = phys;
> +	refcount_set(&info->use_count, 1);
> +
>   	/* set the chaining pointer to the previous page if there */
> -	*(void **)((u8 *)page_address(ret) + PAGE_SIZE - sizeof(void *)) = *page_ptr;
> +	info->next = *page_ptr;
>   	*page_ptr = ret;
>   
>   	return ret;
> @@ -76,7 +92,7 @@ static int iwl_txq_gen2_set_tb_with_wa(struct iwl_trans *trans,
>   	 * a new mapping for it so the device will not fail.
>   	 */
>   
> -	if (WARN_ON(len > PAGE_SIZE - sizeof(void *))) {
> +	if (WARN_ON(len > IWL_TSO_PAGE_DATA_SIZE)) {
>   		ret = -ENOBUFS;
>   		goto unmap;
>   	}
> @@ -782,7 +798,7 @@ static void iwl_txq_gen2_unmap(struct iwl_trans *trans, int txq_id)
>   			struct sk_buff *skb = txq->entries[idx].skb;
>   
>   			if (!WARN_ON_ONCE(!skb))
> -				iwl_pcie_free_tso_page(trans, skb, cmd_meta);
> +				iwl_pcie_free_tso_pages(trans, skb, cmd_meta);
>   		}
>   		iwl_txq_gen2_free_tfd(trans, txq);
>   		txq->read_ptr = iwl_txq_inc_wrap(trans, txq->read_ptr);
> diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
> index ac545a39ad2a..e00d85866de9 100644
> --- a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
> +++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
> @@ -209,8 +209,22 @@ static void iwl_pcie_clear_cmd_in_flight(struct iwl_trans *trans)
>   	spin_unlock(&trans_pcie->reg_lock);
>   }
>   
> -void iwl_pcie_free_tso_page(struct iwl_trans *trans, struct sk_buff *skb,
> -			    struct iwl_cmd_meta *cmd_meta)
> +static void iwl_pcie_free_and_unmap_tso_page(struct iwl_trans *trans,
> +					     struct page *page)
> +{
> +	struct iwl_tso_page_info *info = IWL_TSO_PAGE_INFO(page_address(page));
> +
> +	/* Decrease internal use count and unmap/free page if needed */
> +	if (refcount_dec_and_test(&info->use_count)) {
> +		dma_unmap_page(trans->dev, info->dma_addr, PAGE_SIZE,
> +			       DMA_TO_DEVICE);
> +
> +		__free_page(page);
> +	}
> +}
> +
> +void iwl_pcie_free_tso_pages(struct iwl_trans *trans, struct sk_buff *skb,
> +			     struct iwl_cmd_meta *cmd_meta)
>   {
>   	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
>   	struct page **page_ptr;
> @@ -221,10 +235,11 @@ void iwl_pcie_free_tso_page(struct iwl_trans *trans, struct sk_buff *skb,
>   	*page_ptr = NULL;
>   
>   	while (next) {
> +		struct iwl_tso_page_info *info;
>   		struct page *tmp = next;
>   
> -		next = *(void **)((u8 *)page_address(next) + PAGE_SIZE -
> -				  sizeof(void *));
> +		info = IWL_TSO_PAGE_INFO(page_address(next));
> +		next = info->next;
>   
>   		/* Unmap the scatter gather list that is on the last page */
>   		if (!next && cmd_meta->sg_offset) {
> @@ -236,7 +251,7 @@ void iwl_pcie_free_tso_page(struct iwl_trans *trans, struct sk_buff *skb,
>   			dma_unmap_sgtable(trans->dev, sgt, DMA_TO_DEVICE, 0);
>   		}
>   
> -		__free_page(tmp);
> +		iwl_pcie_free_and_unmap_tso_page(trans, tmp);
>   	}
>   }
>   
> @@ -381,7 +396,7 @@ static void iwl_pcie_txq_unmap(struct iwl_trans *trans, int txq_id)
>   			if (WARN_ON_ONCE(!skb))
>   				continue;
>   
> -			iwl_pcie_free_tso_page(trans, skb, cmd_meta);
> +			iwl_pcie_free_tso_pages(trans, skb, cmd_meta);
>   		}
>   		iwl_txq_free_tfd(trans, txq);
>   		txq->read_ptr = iwl_txq_inc_wrap(trans, txq->read_ptr);
> @@ -1722,7 +1737,9 @@ static void *iwl_pcie_get_page_hdr(struct iwl_trans *trans,
>   {
>   	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
>   	struct iwl_tso_hdr_page *p = this_cpu_ptr(trans_pcie->txqs.tso_hdr_page);
> +	struct iwl_tso_page_info *info;
>   	struct page **page_ptr;
> +	dma_addr_t phys;
>   	void *ret;
>   
>   	page_ptr = (void *)((u8 *)skb->cb + trans_pcie->txqs.page_offs);
> @@ -1743,23 +1760,42 @@ static void *iwl_pcie_get_page_hdr(struct iwl_trans *trans,
>   	 *
>   	 * (see also get_workaround_page() in tx-gen2.c)
>   	 */
> -	if (p->pos + len < (u8 *)page_address(p->page) + PAGE_SIZE -
> -			   sizeof(void *))
> +	if (((unsigned long)p->pos & ~PAGE_MASK) + len < IWL_TSO_PAGE_DATA_SIZE) {
> +		info = IWL_TSO_PAGE_INFO(page_address(ret));
>   		goto out;
> +	}
>   
>   	/* We don't have enough room on this page, get a new one. */
> -	__free_page(p->page);
> +	iwl_pcie_free_and_unmap_tso_page(trans, p->page);
>   
>   alloc:
>   	p->page = alloc_page(GFP_ATOMIC);
>   	if (!p->page)
>   		return NULL;
>   	p->pos = page_address(p->page);
> +
> +	info = IWL_TSO_PAGE_INFO(page_address(ret));
> +
>   	/* set the chaining pointer to NULL */
> -	*(void **)((u8 *)page_address(p->page) + PAGE_SIZE - sizeof(void *)) = NULL;
> +	info->next = NULL;
> +
> +	/* Create a DMA mapping for the page */
> +	phys = dma_map_page_attrs(trans->dev, p->page, 0, PAGE_SIZE,
> +				  DMA_TO_DEVICE, DMA_ATTR_SKIP_CPU_SYNC);
> +	if (unlikely(dma_mapping_error(trans->dev, phys))) {
> +		__free_page(p->page);
> +		p->page = NULL;
> +
> +		return NULL;
> +	}
> +
> +	/* Store physical address and set use count */
> +	info->dma_addr = phys;
> +	refcount_set(&info->use_count, 1);
>   out:
>   	*page_ptr = p->page;
> -	get_page(p->page);
> +	/* Return an internal reference for the caller */
> +	refcount_inc(&info->use_count);
>   	ret = p->pos;
>   	p->pos += len;
>   
> @@ -2330,7 +2366,7 @@ void iwl_pcie_reclaim(struct iwl_trans *trans, int txq_id, int ssn,
>   			      read_ptr, txq->read_ptr, txq_id))
>   			continue;
>   
> -		iwl_pcie_free_tso_page(trans, skb, cmd_meta);
> +		iwl_pcie_free_tso_pages(trans, skb, cmd_meta);
>   
>   		__skb_queue_tail(skbs, skb);
>   

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com



