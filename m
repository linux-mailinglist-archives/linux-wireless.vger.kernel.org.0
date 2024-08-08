Return-Path: <linux-wireless+bounces-11133-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 437FF94C41F
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Aug 2024 20:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEA072811F5
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Aug 2024 18:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF931465A0;
	Thu,  8 Aug 2024 18:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="S5o7u0jQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049B155769;
	Thu,  8 Aug 2024 18:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723140669; cv=none; b=O5FX+0HhXsXpdTOEJdu4MhRrvy3DlTBfXI66lQkAx0tMZIqAo+9QA8e9LCckeflGLUmX1e7CGeMw8p/6uFvMmNBNlpyuqab9m7toNnUu2Vs2n2K0Gprph80YNVjplE10D9mHUGYT+OVtjhNvXwCKgtUXJhIQeqyE3JmJfTYEagA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723140669; c=relaxed/simple;
	bh=tPwkBVdeSb9aZUteLQdJque5vmD2XctAv3doeqqam6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r0UKqz6htaLYNzn+5ESS60HcDIMBs8sWkRq2ZjxiRafPZ4zsv6S+wUjM4YKYBtcyHni4suFFHHdcwEdzTU5WfbY2ggg0/w96Am1eJjyNUbmaviZESHTmTFQlFeSPQS082OW2n16A9AzurRF6FaRcq9BDpjhMCqabv0yDMkjYvdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=S5o7u0jQ; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=jlqb6VwdZJwYeDOih+dioqqnm/fIXPcTOxrmBrvEGiw=; t=1723140662; x=1724350262; 
	b=S5o7u0jQ/ay/2NpBIqzAXOYq254yQJezssqKzhznZMOmwN5syuBbfOKNFk6EYOFAoo79QNfNL0K
	EY+W/bXqAYKrEJTT5X6Hg9YFg1yl5BYvs1Kc4lvTWsOTqFReeESNdwuU4OeqAjgLrLxXNSIEH1ZMP
	raNNq/yqDhTOugNKw/8lJj0iOkpN28dJBL3XW0b1hWxOq2eyMFKEyLi8VZqmlVXkoBKiInAS0wTkC
	+boHmg48mgx83H5YHl7727D88S3Ji0yny+C8b0PCmG1q7bgo8UfsXZFdSGKJjZjQWyEsntpzt6Iom
	rGpfeFYr/TKen2ruIgW9s/2bURAXoND6ae+Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1sc70M-00000009G1f-3kos;
	Thu, 08 Aug 2024 19:32:54 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: benjamin.berg@intel.com,
	miriam.rachel.korenblit@intel.com,
	regressions@lists.linux.dev,
	johannes@sipsolutions.net,
	Kalle Valo <kvalo@kernel.org>,
	Chris Bainbridge <chris.bainbridge@gmail.com>,
	Ben Greear <greearb@candelatech.com>
Subject: [PATCH] wifi: iwlwifi: correctly lookup DMA address in SG table
Date: Thu,  8 Aug 2024 19:29:48 +0200
Message-ID: <20240808172948.303258-1-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Benjamin Berg <benjamin.berg@intel.com>

The code to lookup the scatter gather table entry assumed that it was
possible to use sg_virt() in order to lookup the DMA address in a mapped
scatter gather table. However, this assumption is incorrect as the DMA
mapping code may merge multiple entries into one. In that case, the DMA
address space may have e.g. two consecutive pages which is correctly
represented by the scatter gather list entry, however the virtual
addresses for these two pages may differ and the relationship cannot be
resolved anymore.

Avoid this problem entirely by working with the offset into the mapped
area instead of using virtual addresses. With that we only use the DMA
length and DMA address from the scatter gather list entries. The
underlying DMA/IOMMU code is therefore free to merge two entries into
one even if the virtual addresses space for the area is not continuous.

Fixes: 90db50755228 ("wifi: iwlwifi: use already mapped data when TXing an AMSDU")
Reported-by: Chris Bainbridge <chris.bainbridge@gmail.com>
Closes: https://lore.kernel.org/r/ZrNRoEbdkxkKFMBi@debian.local
Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>

---

Note that I was not yet able to fully verify this patch, but will
probably get results tomorrow. Unfortunately, much of the testing we do
internally happens on machines that do not reproduce the problem.

Also, I think Ben already reported the same issue much earlier. At the
time, I was not yet aware of the internal reproductions and did not take
the report seriously.
---
 .../wireless/intel/iwlwifi/pcie/internal.h    |  2 +-
 .../net/wireless/intel/iwlwifi/pcie/tx-gen2.c |  4 ++-
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c  | 25 +++++++++++--------
 3 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
index b59de4f80b4b..3af9c2b40ef1 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
@@ -639,7 +639,7 @@ void iwl_trans_pcie_tx_reset(struct iwl_trans *trans);
 int iwl_pcie_txq_alloc(struct iwl_trans *trans, struct iwl_txq *txq,
 		       int slots_num, bool cmd_queue);
 
-dma_addr_t iwl_pcie_get_sgt_tb_phys(struct sg_table *sgt, void *addr);
+dma_addr_t iwl_pcie_get_sgt_tb_phys(struct sg_table *sgt, unsigned int offset);
 struct sg_table *iwl_pcie_prep_tso(struct iwl_trans *trans, struct sk_buff *skb,
 				   struct iwl_cmd_meta *cmd_meta,
 				   u8 **hdr, unsigned int hdr_room);
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
index 2e780fb2da42..54d26523f692 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
@@ -168,6 +168,7 @@ static int iwl_txq_gen2_build_amsdu(struct iwl_trans *trans,
 	struct ieee80211_hdr *hdr = (void *)skb->data;
 	unsigned int snap_ip_tcp_hdrlen, ip_hdrlen, total_len, hdr_room;
 	unsigned int mss = skb_shinfo(skb)->gso_size;
+	unsigned int data_offset = 0;
 	dma_addr_t start_hdr_phys;
 	u16 length, amsdu_pad;
 	u8 *start_hdr;
@@ -260,7 +261,7 @@ static int iwl_txq_gen2_build_amsdu(struct iwl_trans *trans,
 			int ret;
 
 			tb_len = min_t(unsigned int, tso.size, data_left);
-			tb_phys = iwl_pcie_get_sgt_tb_phys(sgt, tso.data);
+			tb_phys = iwl_pcie_get_sgt_tb_phys(sgt, data_offset);
 			/* Not a real mapping error, use direct comparison */
 			if (unlikely(tb_phys == DMA_MAPPING_ERROR))
 				goto out_err;
@@ -272,6 +273,7 @@ static int iwl_txq_gen2_build_amsdu(struct iwl_trans *trans,
 				goto out_err;
 
 			data_left -= tb_len;
+			data_offset += tb_len;
 			tso_build_data(skb, &tso, tb_len);
 		}
 	}
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
index 22d482ae53d9..78f417cdb9ac 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
@@ -1814,23 +1814,24 @@ static void *iwl_pcie_get_page_hdr(struct iwl_trans *trans,
 /**
  * iwl_pcie_get_sgt_tb_phys - Find TB address in mapped SG list
  * @sgt: scatter gather table
- * @addr: Virtual address
+ * @offset: Offset into the mapped memory (i.e. SKB payload data)
  *
- * Find the entry that includes the address for the given address and return
- * correct physical address for the TB entry.
+ * Find the DMA address that corresponds to the SKB payload data at the
+ * position given by @offset.
  *
  * Returns: Address for TB entry
  */
-dma_addr_t iwl_pcie_get_sgt_tb_phys(struct sg_table *sgt, void *addr)
+dma_addr_t iwl_pcie_get_sgt_tb_phys(struct sg_table *sgt, unsigned int offset)
 {
 	struct scatterlist *sg;
+	unsigned int sg_offset = 0;
 	int i;
 
 	for_each_sgtable_dma_sg(sgt, sg, i) {
-		if (addr >= sg_virt(sg) &&
-		    (u8 *)addr < (u8 *)sg_virt(sg) + sg_dma_len(sg))
-			return sg_dma_address(sg) +
-			       ((unsigned long)addr - (unsigned long)sg_virt(sg));
+		if (offset >= sg_offset && offset < sg_offset + sg_dma_len(sg))
+			return sg_dma_address(sg) + offset - sg_offset;
+
+		sg_offset += sg_dma_len(sg);
 	}
 
 	WARN_ON_ONCE(1);
@@ -1875,7 +1876,9 @@ struct sg_table *iwl_pcie_prep_tso(struct iwl_trans *trans, struct sk_buff *skb,
 
 	sg_init_table(sgt->sgl, skb_shinfo(skb)->nr_frags + 1);
 
-	sgt->orig_nents = skb_to_sgvec(skb, sgt->sgl, 0, skb->len);
+	/* Only map the data, not the header (it is copied to the TSO page) */
+	sgt->orig_nents = skb_to_sgvec(skb, sgt->sgl, skb_headlen(skb),
+				       skb->data_len);
 	if (WARN_ON_ONCE(sgt->orig_nents <= 0))
 		return NULL;
 
@@ -1900,6 +1903,7 @@ static int iwl_fill_data_tbs_amsdu(struct iwl_trans *trans, struct sk_buff *skb,
 	struct ieee80211_hdr *hdr = (void *)skb->data;
 	unsigned int snap_ip_tcp_hdrlen, ip_hdrlen, total_len, hdr_room;
 	unsigned int mss = skb_shinfo(skb)->gso_size;
+	unsigned int data_offset = 0;
 	u16 length, iv_len, amsdu_pad;
 	dma_addr_t start_hdr_phys;
 	u8 *start_hdr, *pos_hdr;
@@ -2000,7 +2004,7 @@ static int iwl_fill_data_tbs_amsdu(struct iwl_trans *trans, struct sk_buff *skb,
 						  data_left);
 			dma_addr_t tb_phys;
 
-			tb_phys = iwl_pcie_get_sgt_tb_phys(sgt, tso.data);
+			tb_phys = iwl_pcie_get_sgt_tb_phys(sgt, data_offset);
 			/* Not a real mapping error, use direct comparison */
 			if (unlikely(tb_phys == DMA_MAPPING_ERROR))
 				return -EINVAL;
@@ -2011,6 +2015,7 @@ static int iwl_fill_data_tbs_amsdu(struct iwl_trans *trans, struct sk_buff *skb,
 						tb_phys, size);
 
 			data_left -= size;
+			data_offset += size;
 			tso_build_data(skb, &tso, size);
 		}
 	}
-- 
2.46.0


