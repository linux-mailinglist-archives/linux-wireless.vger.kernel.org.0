Return-Path: <linux-wireless+bounces-9907-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 793B7925796
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 12:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E085284087
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 10:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76422142651;
	Wed,  3 Jul 2024 09:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lgtk2vg/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC45158DB8
	for <linux-wireless@vger.kernel.org>; Wed,  3 Jul 2024 09:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720000766; cv=none; b=k5hCLAZZyaZgvfe5voCwzUFmGpX2gHX+b0dHv1VWWqbH2elmsAu7AxCpCio4QVYUIXq3igZUNbhrkfGzCVJbC8LOdTxjj18R8jvmpR4dNHcmqaqWLFzWjO51FhUIox8LjZOXq/HTJoAKOeQ/KL8LimZkVSPyOMuoGb6+P+NOMq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720000766; c=relaxed/simple;
	bh=4eXljENTFCg25APOo9p6TKb4gi+WQIC6KnkVCraOmgA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=vCzKMcIsxsxn9T9fheyiEuixJbLmTm7ugvg7cg4/XundpIqFe6If2YRXL5KeZE/GjMU+8bPuxVRru8eDwD9dJs9toowUEJYL9TJu/Q3jYaFJvr61wIsKsvkhkrqMORCheFsWrxm9k04aqf0CxmCeCfSClNMUf7Vus0Z4LXXhx1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lgtk2vg/; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720000764; x=1751536764;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4eXljENTFCg25APOo9p6TKb4gi+WQIC6KnkVCraOmgA=;
  b=Lgtk2vg/q1P5yvpYLgBgk4Rj+7Y8ZsqW7tKC79SD/KMQjan/n+tDl47b
   Z6eFrIi8llTjT+8ov1seqJvkNp3N7bSS/7QntOikvrM7LkhEGN2IkbWcP
   jH7xJjRGX1fTAjBbVyxeWI1L4DDYK+098f3OVKcNHFxrnCAwoaElnUkOK
   op1xE1GQIjUPjdE9t1/T8N0TIpz8tGLeA4tpeBR8Z6giC++32qkmsHUNR
   nRJefG7CxCj8RJVxU8RuYoj1n6VfYgNKPkbgf2NdVmbwdHWIkUgiFuWqW
   VuaKOpSpAp+tX0QQYgs5N677ScB7nt2muTE/gIHswPj++SNwaE4+BKKND
   Q==;
X-CSE-ConnectionGUID: ygZlfi/FT0CfFbfrnO76OA==
X-CSE-MsgGUID: RKB3TuM2S4eA/BFUzKSeGg==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="27837530"
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="27837530"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 02:59:24 -0700
X-CSE-ConnectionGUID: TMU53BMkTBeUrt2Onk/u3g==
X-CSE-MsgGUID: 4WEkk+fZTQuNPo6SOIRdAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="45987752"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 02:59:22 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Benjamin Berg <benjamin.berg@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 06/18] wifi: iwlwifi: keep the TSO and workaround pages mapped
Date: Wed,  3 Jul 2024 12:58:54 +0300
Message-Id: <20240703125541.7ced468fe431.Ibb109867dc680c37fe8d891e9ab9ef64ed5c5d2d@changeid>
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

Map the pages when allocating them so that we will not need to map each
of the used fragments at a later point.

For now the mapping is not used, this will be changed in a later commit.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
---
 .../wireless/intel/iwlwifi/pcie/internal.h    | 30 +++++++++-
 .../net/wireless/intel/iwlwifi/pcie/tx-gen2.c | 22 ++++++-
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c  | 60 +++++++++++++++----
 3 files changed, 95 insertions(+), 17 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
index d63c1c284f70..b59de4f80b4b 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
@@ -603,6 +603,22 @@ struct iwl_tso_hdr_page {
 	u8 *pos;
 };
 
+/*
+ * Note that we put this struct *last* in the page. By doing that, we ensure
+ * that no TB referencing this page can trigger the 32-bit boundary hardware
+ * bug.
+ */
+struct iwl_tso_page_info {
+	dma_addr_t dma_addr;
+	struct page *next;
+	refcount_t use_count;
+};
+
+#define IWL_TSO_PAGE_DATA_SIZE	(PAGE_SIZE - sizeof(struct iwl_tso_page_info))
+#define IWL_TSO_PAGE_INFO(addr)	\
+	((struct iwl_tso_page_info *)(((unsigned long)addr & PAGE_MASK) + \
+				      IWL_TSO_PAGE_DATA_SIZE))
+
 int iwl_pcie_tx_init(struct iwl_trans *trans);
 void iwl_pcie_tx_start(struct iwl_trans *trans, u32 scd_base_addr);
 int iwl_pcie_tx_stop(struct iwl_trans *trans);
@@ -628,8 +644,18 @@ struct sg_table *iwl_pcie_prep_tso(struct iwl_trans *trans, struct sk_buff *skb,
 				   struct iwl_cmd_meta *cmd_meta,
 				   u8 **hdr, unsigned int hdr_room);
 
-void iwl_pcie_free_tso_page(struct iwl_trans *trans, struct sk_buff *skb,
-			    struct iwl_cmd_meta *cmd_meta);
+void iwl_pcie_free_tso_pages(struct iwl_trans *trans, struct sk_buff *skb,
+			     struct iwl_cmd_meta *cmd_meta);
+
+static inline dma_addr_t iwl_pcie_get_tso_page_phys(void *addr)
+{
+	dma_addr_t res;
+
+	res = IWL_TSO_PAGE_INFO(addr)->dma_addr;
+	res += (unsigned long)addr & ~PAGE_MASK;
+
+	return res;
+}
 
 static inline dma_addr_t
 iwl_txq_get_first_tb_dma(struct iwl_txq *txq, int idx)
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
index 3dcce6a8da50..10ee2c328458 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
@@ -19,8 +19,10 @@ static struct page *get_workaround_page(struct iwl_trans *trans,
 					struct sk_buff *skb)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
+	struct iwl_tso_page_info *info;
 	struct page **page_ptr;
 	struct page *ret;
+	dma_addr_t phys;
 
 	page_ptr = (void *)((u8 *)skb->cb + trans_pcie->txqs.page_offs);
 
@@ -28,8 +30,22 @@ static struct page *get_workaround_page(struct iwl_trans *trans,
 	if (!ret)
 		return NULL;
 
+	info = IWL_TSO_PAGE_INFO(page_address(ret));
+
+	/* Create a DMA mapping for the page */
+	phys = dma_map_page_attrs(trans->dev, ret, 0, PAGE_SIZE,
+				  DMA_TO_DEVICE, DMA_ATTR_SKIP_CPU_SYNC);
+	if (unlikely(dma_mapping_error(trans->dev, phys))) {
+		__free_page(ret);
+		return NULL;
+	}
+
+	/* Store physical address and set use count */
+	info->dma_addr = phys;
+	refcount_set(&info->use_count, 1);
+
 	/* set the chaining pointer to the previous page if there */
-	*(void **)((u8 *)page_address(ret) + PAGE_SIZE - sizeof(void *)) = *page_ptr;
+	info->next = *page_ptr;
 	*page_ptr = ret;
 
 	return ret;
@@ -76,7 +92,7 @@ static int iwl_txq_gen2_set_tb_with_wa(struct iwl_trans *trans,
 	 * a new mapping for it so the device will not fail.
 	 */
 
-	if (WARN_ON(len > PAGE_SIZE - sizeof(void *))) {
+	if (WARN_ON(len > IWL_TSO_PAGE_DATA_SIZE)) {
 		ret = -ENOBUFS;
 		goto unmap;
 	}
@@ -782,7 +798,7 @@ static void iwl_txq_gen2_unmap(struct iwl_trans *trans, int txq_id)
 			struct sk_buff *skb = txq->entries[idx].skb;
 
 			if (!WARN_ON_ONCE(!skb))
-				iwl_pcie_free_tso_page(trans, skb, cmd_meta);
+				iwl_pcie_free_tso_pages(trans, skb, cmd_meta);
 		}
 		iwl_txq_gen2_free_tfd(trans, txq);
 		txq->read_ptr = iwl_txq_inc_wrap(trans, txq->read_ptr);
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
index ac545a39ad2a..e00d85866de9 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
@@ -209,8 +209,22 @@ static void iwl_pcie_clear_cmd_in_flight(struct iwl_trans *trans)
 	spin_unlock(&trans_pcie->reg_lock);
 }
 
-void iwl_pcie_free_tso_page(struct iwl_trans *trans, struct sk_buff *skb,
-			    struct iwl_cmd_meta *cmd_meta)
+static void iwl_pcie_free_and_unmap_tso_page(struct iwl_trans *trans,
+					     struct page *page)
+{
+	struct iwl_tso_page_info *info = IWL_TSO_PAGE_INFO(page_address(page));
+
+	/* Decrease internal use count and unmap/free page if needed */
+	if (refcount_dec_and_test(&info->use_count)) {
+		dma_unmap_page(trans->dev, info->dma_addr, PAGE_SIZE,
+			       DMA_TO_DEVICE);
+
+		__free_page(page);
+	}
+}
+
+void iwl_pcie_free_tso_pages(struct iwl_trans *trans, struct sk_buff *skb,
+			     struct iwl_cmd_meta *cmd_meta)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	struct page **page_ptr;
@@ -221,10 +235,11 @@ void iwl_pcie_free_tso_page(struct iwl_trans *trans, struct sk_buff *skb,
 	*page_ptr = NULL;
 
 	while (next) {
+		struct iwl_tso_page_info *info;
 		struct page *tmp = next;
 
-		next = *(void **)((u8 *)page_address(next) + PAGE_SIZE -
-				  sizeof(void *));
+		info = IWL_TSO_PAGE_INFO(page_address(next));
+		next = info->next;
 
 		/* Unmap the scatter gather list that is on the last page */
 		if (!next && cmd_meta->sg_offset) {
@@ -236,7 +251,7 @@ void iwl_pcie_free_tso_page(struct iwl_trans *trans, struct sk_buff *skb,
 			dma_unmap_sgtable(trans->dev, sgt, DMA_TO_DEVICE, 0);
 		}
 
-		__free_page(tmp);
+		iwl_pcie_free_and_unmap_tso_page(trans, tmp);
 	}
 }
 
@@ -381,7 +396,7 @@ static void iwl_pcie_txq_unmap(struct iwl_trans *trans, int txq_id)
 			if (WARN_ON_ONCE(!skb))
 				continue;
 
-			iwl_pcie_free_tso_page(trans, skb, cmd_meta);
+			iwl_pcie_free_tso_pages(trans, skb, cmd_meta);
 		}
 		iwl_txq_free_tfd(trans, txq);
 		txq->read_ptr = iwl_txq_inc_wrap(trans, txq->read_ptr);
@@ -1722,7 +1737,9 @@ static void *iwl_pcie_get_page_hdr(struct iwl_trans *trans,
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	struct iwl_tso_hdr_page *p = this_cpu_ptr(trans_pcie->txqs.tso_hdr_page);
+	struct iwl_tso_page_info *info;
 	struct page **page_ptr;
+	dma_addr_t phys;
 	void *ret;
 
 	page_ptr = (void *)((u8 *)skb->cb + trans_pcie->txqs.page_offs);
@@ -1743,23 +1760,42 @@ static void *iwl_pcie_get_page_hdr(struct iwl_trans *trans,
 	 *
 	 * (see also get_workaround_page() in tx-gen2.c)
 	 */
-	if (p->pos + len < (u8 *)page_address(p->page) + PAGE_SIZE -
-			   sizeof(void *))
+	if (((unsigned long)p->pos & ~PAGE_MASK) + len < IWL_TSO_PAGE_DATA_SIZE) {
+		info = IWL_TSO_PAGE_INFO(page_address(ret));
 		goto out;
+	}
 
 	/* We don't have enough room on this page, get a new one. */
-	__free_page(p->page);
+	iwl_pcie_free_and_unmap_tso_page(trans, p->page);
 
 alloc:
 	p->page = alloc_page(GFP_ATOMIC);
 	if (!p->page)
 		return NULL;
 	p->pos = page_address(p->page);
+
+	info = IWL_TSO_PAGE_INFO(page_address(ret));
+
 	/* set the chaining pointer to NULL */
-	*(void **)((u8 *)page_address(p->page) + PAGE_SIZE - sizeof(void *)) = NULL;
+	info->next = NULL;
+
+	/* Create a DMA mapping for the page */
+	phys = dma_map_page_attrs(trans->dev, p->page, 0, PAGE_SIZE,
+				  DMA_TO_DEVICE, DMA_ATTR_SKIP_CPU_SYNC);
+	if (unlikely(dma_mapping_error(trans->dev, phys))) {
+		__free_page(p->page);
+		p->page = NULL;
+
+		return NULL;
+	}
+
+	/* Store physical address and set use count */
+	info->dma_addr = phys;
+	refcount_set(&info->use_count, 1);
 out:
 	*page_ptr = p->page;
-	get_page(p->page);
+	/* Return an internal reference for the caller */
+	refcount_inc(&info->use_count);
 	ret = p->pos;
 	p->pos += len;
 
@@ -2330,7 +2366,7 @@ void iwl_pcie_reclaim(struct iwl_trans *trans, int txq_id, int ssn,
 			      read_ptr, txq->read_ptr, txq_id))
 			continue;
 
-		iwl_pcie_free_tso_page(trans, skb, cmd_meta);
+		iwl_pcie_free_tso_pages(trans, skb, cmd_meta);
 
 		__skb_queue_tail(skbs, skb);
 
-- 
2.34.1


