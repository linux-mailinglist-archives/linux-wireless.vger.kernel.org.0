Return-Path: <linux-wireless+bounces-9906-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A889925795
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 12:00:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E52C5283FD2
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 10:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D07D61422C9;
	Wed,  3 Jul 2024 09:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g5ZKAOuJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CB0155335
	for <linux-wireless@vger.kernel.org>; Wed,  3 Jul 2024 09:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720000764; cv=none; b=ATCwVWAz2odR5ArIYwxXVNMMwALxDQaWYAbJ4qk19rPTDl5e5z5DgSOeLmPQWvj1rhOPxFsJ26Ve8tosIMzKRCTge8p0AjCLtPu1fsWp5BXHn3BYOLX94vfGCyW+EB0RFk+eLlTa5W6tUakZ7KDRc5MNSAp2I3G/6wTBo1QklYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720000764; c=relaxed/simple;
	bh=WLue8UanZux3fPQZr2PgHN5ljOA3ldFplAn3CSwiJVU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RJpWes94XuaWRqA/ULz3Ki9QGiO2E6iLAcfyLfp7XQ1cw4AXvFrjYIE+O/ZBEwkVLqD3ZHYI6WZIP8s6bmoee6qj2LOAKlWoohdHsB0xXNsubzWNU38YPs+e3EpD7zzGmjkQehE+hkA5yzqunRxkZ0D4e2i1blnGYTIoLyxr/jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g5ZKAOuJ; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720000763; x=1751536763;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WLue8UanZux3fPQZr2PgHN5ljOA3ldFplAn3CSwiJVU=;
  b=g5ZKAOuJ9tkGBn/Nj6DvoKidQ0wWXfwvqxd82UGNTXeLbTefQQFdwHB3
   VRpWdrR/wvNUS8XzMJ+MQqCba4bXN9SH0AiqOBN2gM8tfR2pua9YXWCzC
   ydYPpWjLE8Xsf06CSCPmEy0XmI6MPz/Vo2ECCl7jQ6iXkex4OS3B8vP9q
   0tTtGZBzHPWrx+pI2C/D4pZ264EVfs6sZVwL04kwt7TVrW0HP4q366uiB
   p/quYJghknkWNVsHmsvcDoik+iNsaEaFvUgq9EcAkiYy6Z3nt5JkCC9p2
   WEQ5rsyV98wA4uHyclSCbIVW1rHlbSN2C8reJ7oM2lqfvnFz0g2HG4lnM
   w==;
X-CSE-ConnectionGUID: Txd+ON8MQ+K9TaN472HPlA==
X-CSE-MsgGUID: 2rE7eNgITfCUczk5Ae1X9Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="27837525"
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="27837525"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 02:59:22 -0700
X-CSE-ConnectionGUID: NGtae/w1SUqaEzBq3+NBSQ==
X-CSE-MsgGUID: /uxjoK5zQFemBfg0z1G8QQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="45987744"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 02:59:20 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Benjamin Berg <benjamin.berg@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 05/18] wifi: iwlwifi: map entire SKB when sending AMSDUs
Date: Wed,  3 Jul 2024 12:58:53 +0300
Message-Id: <20240703125541.96c6006f40ff.I55b74bc97c4026761397a7513a559c88a10b6489@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240703095906.833028-1-miriam.rachel.korenblit@intel.com>
References: <20240703095906.833028-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Benjamin Berg <benjamin.berg@intel.com>

This adds logic to map the entire SKB for AMSDUs. The required scatter
gather list is allocated together with the space for TSO headers.
Unmapping happens again when free'ing the TSO header page.

For now the mapping is unused, this will be changed in a later commit.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |   5 +-
 .../wireless/intel/iwlwifi/pcie/internal.h    |  10 +-
 .../net/wireless/intel/iwlwifi/pcie/tx-gen2.c |  20 +--
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c  | 114 ++++++++++++++++--
 4 files changed, 128 insertions(+), 21 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index ecf94ec2c2b0..015f02122df6 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -120,6 +120,7 @@ enum CMD_MODE {
 	CMD_BLOCK_TXQS		= BIT(3),
 	CMD_SEND_IN_D3          = BIT(4),
 };
+#define CMD_MODE_BITS 5
 
 #define DEF_CMD_PAYLOAD_SIZE 320
 
@@ -712,7 +713,9 @@ struct iwl_dma_ptr {
 struct iwl_cmd_meta {
 	/* only for SYNC commands, iff the reply skb is wanted */
 	struct iwl_host_cmd *source;
-	u32 flags;
+	u32 flags: CMD_MODE_BITS;
+	/* sg_offset is valid if it is non-zero */
+	u32 sg_offset: PAGE_SHIFT;
 	u32 tbs;
 };
 
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
index 754928062921..d63c1c284f70 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
@@ -623,9 +623,13 @@ void iwl_trans_pcie_tx_reset(struct iwl_trans *trans);
 int iwl_pcie_txq_alloc(struct iwl_trans *trans, struct iwl_txq *txq,
 		       int slots_num, bool cmd_queue);
 
-void *iwl_pcie_get_page_hdr(struct iwl_trans *trans, size_t len,
-			    struct sk_buff *skb);
-void iwl_pcie_free_tso_page(struct iwl_trans *trans, struct sk_buff *skb);
+dma_addr_t iwl_pcie_get_sgt_tb_phys(struct sg_table *sgt, void *addr);
+struct sg_table *iwl_pcie_prep_tso(struct iwl_trans *trans, struct sk_buff *skb,
+				   struct iwl_cmd_meta *cmd_meta,
+				   u8 **hdr, unsigned int hdr_room);
+
+void iwl_pcie_free_tso_page(struct iwl_trans *trans, struct sk_buff *skb,
+			    struct iwl_cmd_meta *cmd_meta);
 
 static inline dma_addr_t
 iwl_txq_get_first_tb_dma(struct iwl_txq *txq, int idx)
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
index 543efb52b084..3dcce6a8da50 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
@@ -119,7 +119,9 @@ static int iwl_txq_gen2_set_tb_with_wa(struct iwl_trans *trans,
 
 static int iwl_txq_gen2_build_amsdu(struct iwl_trans *trans,
 				    struct sk_buff *skb,
-				    struct iwl_tfh_tfd *tfd, int start_len,
+				    struct iwl_tfh_tfd *tfd,
+				    struct iwl_cmd_meta *out_meta,
+				    int start_len,
 				    u8 hdr_len,
 				    struct iwl_device_tx_cmd *dev_cmd)
 {
@@ -130,6 +132,7 @@ static int iwl_txq_gen2_build_amsdu(struct iwl_trans *trans,
 	unsigned int mss = skb_shinfo(skb)->gso_size;
 	u16 length, amsdu_pad;
 	u8 *start_hdr;
+	struct sg_table *sgt;
 	struct tso_t tso;
 
 	trace_iwlwifi_dev_tx(trans->dev, skb, tfd, sizeof(*tfd),
@@ -145,8 +148,8 @@ static int iwl_txq_gen2_build_amsdu(struct iwl_trans *trans,
 		(3 + snap_ip_tcp_hdrlen + sizeof(struct ethhdr));
 
 	/* Our device supports 9 segments at most, it will fit in 1 page */
-	start_hdr = iwl_pcie_get_page_hdr(trans, hdr_room, skb);
-	if (!start_hdr)
+	sgt = iwl_pcie_prep_tso(trans, skb, out_meta, &start_hdr, hdr_room);
+	if (!sgt)
 		return -ENOMEM;
 
 	/*
@@ -287,8 +290,8 @@ iwl_tfh_tfd *iwl_txq_gen2_build_tx_amsdu(struct iwl_trans *trans,
 	 */
 	iwl_txq_gen2_set_tb(trans, tfd, tb_phys, len);
 
-	if (iwl_txq_gen2_build_amsdu(trans, skb, tfd, len + IWL_FIRST_TB_SIZE,
-				     hdr_len, dev_cmd))
+	if (iwl_txq_gen2_build_amsdu(trans, skb, tfd, out_meta,
+				     len + IWL_FIRST_TB_SIZE, hdr_len, dev_cmd))
 		goto out_err;
 
 	/* building the A-MSDU might have changed this data, memcpy it now */
@@ -719,7 +722,7 @@ int iwl_txq_gen2_tx(struct iwl_trans *trans, struct sk_buff *skb,
 
 	/* Set up first empty entry in queue's array of Tx/cmd buffers */
 	out_meta = &txq->entries[idx].meta;
-	out_meta->flags = 0;
+	memset(out_meta, 0, sizeof(*out_meta));
 
 	tfd = iwl_txq_gen2_build_tfd(trans, txq, dev_cmd, skb, out_meta);
 	if (!tfd) {
@@ -775,10 +778,11 @@ static void iwl_txq_gen2_unmap(struct iwl_trans *trans, int txq_id)
 
 		if (txq_id != trans_pcie->txqs.cmd.q_id) {
 			int idx = iwl_txq_get_cmd_index(txq, txq->read_ptr);
+			struct iwl_cmd_meta *cmd_meta = &txq->entries[idx].meta;
 			struct sk_buff *skb = txq->entries[idx].skb;
 
 			if (!WARN_ON_ONCE(!skb))
-				iwl_pcie_free_tso_page(trans, skb);
+				iwl_pcie_free_tso_page(trans, skb, cmd_meta);
 		}
 		iwl_txq_gen2_free_tfd(trans, txq);
 		txq->read_ptr = iwl_txq_inc_wrap(trans, txq->read_ptr);
@@ -1247,7 +1251,7 @@ int iwl_pcie_gen2_enqueue_hcmd(struct iwl_trans *trans,
 	out_cmd = txq->entries[idx].cmd;
 	out_meta = &txq->entries[idx].meta;
 
-	/* re-initialize to NULL */
+	/* re-initialize, this also marks the SG list as unused */
 	memset(out_meta, 0, sizeof(*out_meta));
 	if (cmd->flags & CMD_WANT_SKB)
 		out_meta->source = cmd;
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
index d67ad40634f9..ac545a39ad2a 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
@@ -209,7 +209,8 @@ static void iwl_pcie_clear_cmd_in_flight(struct iwl_trans *trans)
 	spin_unlock(&trans_pcie->reg_lock);
 }
 
-void iwl_pcie_free_tso_page(struct iwl_trans *trans, struct sk_buff *skb)
+void iwl_pcie_free_tso_page(struct iwl_trans *trans, struct sk_buff *skb,
+			    struct iwl_cmd_meta *cmd_meta)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	struct page **page_ptr;
@@ -224,6 +225,17 @@ void iwl_pcie_free_tso_page(struct iwl_trans *trans, struct sk_buff *skb)
 
 		next = *(void **)((u8 *)page_address(next) + PAGE_SIZE -
 				  sizeof(void *));
+
+		/* Unmap the scatter gather list that is on the last page */
+		if (!next && cmd_meta->sg_offset) {
+			struct sg_table *sgt;
+
+			sgt = (void *)((u8 *)page_address(tmp) +
+				       cmd_meta->sg_offset);
+
+			dma_unmap_sgtable(trans->dev, sgt, DMA_TO_DEVICE, 0);
+		}
+
 		__free_page(tmp);
 	}
 }
@@ -363,11 +375,13 @@ static void iwl_pcie_txq_unmap(struct iwl_trans *trans, int txq_id)
 
 		if (txq_id != trans_pcie->txqs.cmd.q_id) {
 			struct sk_buff *skb = txq->entries[txq->read_ptr].skb;
+			struct iwl_cmd_meta *cmd_meta =
+				&txq->entries[txq->read_ptr].meta;
 
 			if (WARN_ON_ONCE(!skb))
 				continue;
 
-			iwl_pcie_free_tso_page(trans, skb);
+			iwl_pcie_free_tso_page(trans, skb, cmd_meta);
 		}
 		iwl_txq_free_tfd(trans, txq);
 		txq->read_ptr = iwl_txq_inc_wrap(trans, txq->read_ptr);
@@ -1420,7 +1434,8 @@ int iwl_pcie_enqueue_hcmd(struct iwl_trans *trans,
 	out_cmd = txq->entries[idx].cmd;
 	out_meta = &txq->entries[idx].meta;
 
-	memset(out_meta, 0, sizeof(*out_meta));	/* re-initialize to NULL */
+	/* re-initialize, this also marks the SG list as unused */
+	memset(out_meta, 0, sizeof(*out_meta));
 	if (cmd->flags & CMD_WANT_SKB)
 		out_meta->source = cmd;
 
@@ -1702,8 +1717,8 @@ static int iwl_fill_data_tbs(struct iwl_trans *trans, struct sk_buff *skb,
 }
 
 #ifdef CONFIG_INET
-void *iwl_pcie_get_page_hdr(struct iwl_trans *trans,
-			    size_t len, struct sk_buff *skb)
+static void *iwl_pcie_get_page_hdr(struct iwl_trans *trans,
+				   size_t len, struct sk_buff *skb)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	struct iwl_tso_hdr_page *p = this_cpu_ptr(trans_pcie->txqs.tso_hdr_page);
@@ -1751,6 +1766,84 @@ void *iwl_pcie_get_page_hdr(struct iwl_trans *trans,
 	return ret;
 }
 
+/**
+ * iwl_pcie_get_sgt_tb_phys - Find TB address in mapped SG list
+ * @sgt: scatter gather table
+ * @addr: Virtual address
+ *
+ * Find the entry that includes the address for the given address and return
+ * correct physical address for the TB entry.
+ *
+ * Returns: Address for TB entry
+ */
+dma_addr_t iwl_pcie_get_sgt_tb_phys(struct sg_table *sgt, void *addr)
+{
+	struct scatterlist *sg;
+	int i;
+
+	for_each_sgtable_dma_sg(sgt, sg, i) {
+		if (addr >= sg_virt(sg) &&
+		    (u8 *)addr < (u8 *)sg_virt(sg) + sg_dma_len(sg))
+			return sg_dma_address(sg) +
+			       ((unsigned long)addr - (unsigned long)sg_virt(sg));
+	}
+
+	WARN_ON_ONCE(1);
+
+	return DMA_MAPPING_ERROR;
+}
+
+/**
+ * iwl_pcie_prep_tso - Prepare TSO page and SKB for sending
+ * @trans: transport private data
+ * @skb: the SKB to map
+ * @cmd_meta: command meta to store the scatter list information for unmapping
+ * @hdr: output argument for TSO headers
+ * @hdr_room: requested length for TSO headers
+ *
+ * Allocate space for a scatter gather list and TSO headers and map the SKB
+ * using the scatter gather list. The SKB is unmapped again when the page is
+ * free'ed again at the end of the operation.
+ *
+ * Returns: newly allocated and mapped scatter gather table with list
+ */
+struct sg_table *iwl_pcie_prep_tso(struct iwl_trans *trans, struct sk_buff *skb,
+				   struct iwl_cmd_meta *cmd_meta,
+				   u8 **hdr, unsigned int hdr_room)
+{
+	struct sg_table *sgt;
+
+	if (WARN_ON_ONCE(skb_has_frag_list(skb)))
+		return NULL;
+
+	*hdr = iwl_pcie_get_page_hdr(trans,
+				     hdr_room + __alignof__(struct sg_table) +
+				     sizeof(struct sg_table) +
+				     (skb_shinfo(skb)->nr_frags + 1) *
+				     sizeof(struct scatterlist),
+				     skb);
+	if (!*hdr)
+		return NULL;
+
+	sgt = (void *)PTR_ALIGN(*hdr + hdr_room, __alignof__(struct sg_table));
+	sgt->sgl = (void *)(sgt + 1);
+
+	sg_init_table(sgt->sgl, skb_shinfo(skb)->nr_frags + 1);
+
+	sgt->orig_nents = skb_to_sgvec(skb, sgt->sgl, 0, skb->len);
+	if (WARN_ON_ONCE(sgt->orig_nents <= 0))
+		return NULL;
+
+	/* And map the entire SKB */
+	if (dma_map_sgtable(trans->dev, sgt, DMA_TO_DEVICE, 0) < 0)
+		return NULL;
+
+	/* Store non-zero (i.e. valid) offset for unmapping */
+	cmd_meta->sg_offset = (unsigned long) sgt & ~PAGE_MASK;
+
+	return sgt;
+}
+
 static int iwl_fill_data_tbs_amsdu(struct iwl_trans *trans, struct sk_buff *skb,
 				   struct iwl_txq *txq, u8 hdr_len,
 				   struct iwl_cmd_meta *out_meta,
@@ -1764,6 +1857,7 @@ static int iwl_fill_data_tbs_amsdu(struct iwl_trans *trans, struct sk_buff *skb,
 	unsigned int mss = skb_shinfo(skb)->gso_size;
 	u16 length, iv_len, amsdu_pad;
 	u8 *start_hdr, *pos_hdr;
+	struct sg_table *sgt;
 	struct tso_t tso;
 
 	/* if the packet is protected, then it must be CCMP or GCMP */
@@ -1786,10 +1880,11 @@ static int iwl_fill_data_tbs_amsdu(struct iwl_trans *trans, struct sk_buff *skb,
 		(3 + snap_ip_tcp_hdrlen + sizeof(struct ethhdr)) + iv_len;
 
 	/* Our device supports 9 segments at most, it will fit in 1 page */
-	pos_hdr = start_hdr = iwl_pcie_get_page_hdr(trans, hdr_room, skb);
-	if (!start_hdr)
+	sgt = iwl_pcie_prep_tso(trans, skb, out_meta, &start_hdr, hdr_room);
+	if (!sgt)
 		return -ENOMEM;
 
+	pos_hdr = start_hdr;
 	memcpy(pos_hdr, skb->data + hdr_len, iv_len);
 	pos_hdr += iv_len;
 
@@ -2029,7 +2124,7 @@ int iwl_trans_pcie_tx(struct iwl_trans *trans, struct sk_buff *skb,
 
 	/* Set up first empty entry in queue's array of Tx/cmd buffers */
 	out_meta = &txq->entries[txq->write_ptr].meta;
-	out_meta->flags = 0;
+	memset(out_meta, 0, sizeof(*out_meta));
 
 	/*
 	 * The second TB (tb1) points to the remainder of the TX command
@@ -2228,13 +2323,14 @@ void iwl_pcie_reclaim(struct iwl_trans *trans, int txq_id, int ssn,
 	     read_ptr != tfd_num;
 	     txq->read_ptr = iwl_txq_inc_wrap(trans, txq->read_ptr),
 	     read_ptr = iwl_txq_get_cmd_index(txq, txq->read_ptr)) {
+		struct iwl_cmd_meta *cmd_meta = &txq->entries[read_ptr].meta;
 		struct sk_buff *skb = txq->entries[read_ptr].skb;
 
 		if (WARN_ONCE(!skb, "no SKB at %d (%d) on queue %d\n",
 			      read_ptr, txq->read_ptr, txq_id))
 			continue;
 
-		iwl_pcie_free_tso_page(trans, skb);
+		iwl_pcie_free_tso_page(trans, skb, cmd_meta);
 
 		__skb_queue_tail(skbs, skb);
 
-- 
2.34.1


