Return-Path: <linux-wireless+bounces-9908-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 963E2925797
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 12:00:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40AB728BD89
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 10:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1044158DB8;
	Wed,  3 Jul 2024 09:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lXu6wR3T"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018A015B0F4
	for <linux-wireless@vger.kernel.org>; Wed,  3 Jul 2024 09:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720000767; cv=none; b=HOoZyExHMFP3zwepmANz3tc0Jqg2l1ivmIZ34Fzvqbv9QA+UG4Kp9Ymh4+jQCSOGi4BdTkLL81eXAAqbC2deRvHUP8oSs6ANjwgh34moap/lpf2xraOTnqGuGg6JAHhhJ2otgQxs6xf2xW5Ajw44P4yJpdkdpG81hY3GkOleV7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720000767; c=relaxed/simple;
	bh=0SC4wV7YxFGpCTCmlnO636Gcek1mBa7YRg6SWIrtYg4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZtiuXswHeWw5PuHNvgzHsO75GmuGy7VHNIQvYqRyG3FUN+fI+At7u5PmbVzFOknxlzQDnFKVF7FDK65s+UW5jz1EHi+K/muXoFAF7qp4cKqbR9wtwNzxX0AHty7b7lRRGjaIwsS7MEREwqyTUXOPGZVuqDljCkcoM7QNeYq0s8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lXu6wR3T; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720000766; x=1751536766;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0SC4wV7YxFGpCTCmlnO636Gcek1mBa7YRg6SWIrtYg4=;
  b=lXu6wR3Tlik8J++T+a2sYmv+ck87swvR/mQKMK5P3mDsDNCwTlKzMQPN
   LXdmlShH2SZwbWWe4AwaBcQMmK4uTZILXY5pX78zO0YU+D2Zmbphqz4lF
   Q18eiZZ6zjLDLN5Ceh940psde6xh1mO3eVcwjLCksZxNttGTl7BCxjhGh
   w8wNbEdQJiJTSJ52F2qHHigXx0vvJIijeCxaYgz2yB+lra5eH78J1rTT+
   Lu4oFewiPCTjYFTgYoOrDFejrwSwubboHfdBRIStLkPIJuDhlWN95g7OC
   D/CiwzSDBVTEIjz6pxDsBYxxawHRfLS/YwakpHYHElPiPHU/ExuT2yYIh
   w==;
X-CSE-ConnectionGUID: TNmHEqCNQKuF88m1nkB6PA==
X-CSE-MsgGUID: yEWW/OSUTLCMNzxcTHkvPg==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="27837537"
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="27837537"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 02:59:26 -0700
X-CSE-ConnectionGUID: YGWMCNR6RviRjvnbFybunQ==
X-CSE-MsgGUID: epQBzDiER1Or6unH7G2SNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="45987770"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 02:59:24 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Benjamin Berg <benjamin.berg@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 07/18] wifi: iwlwifi: use already mapped data when TXing an AMSDU
Date: Wed,  3 Jul 2024 12:58:55 +0300
Message-Id: <20240703125541.35d89c5e4ae8.I4feb8d34e7b30768d21365ec22c944bacc274d0b@changeid>
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

The previous commits added mappings for the SKB and TSO page. This
switches the code to use these mappings instead of creating new ones.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
---
 .../net/wireless/intel/iwlwifi/pcie/tx-gen2.c | 64 ++++++++++++++-----
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c  | 21 ++++--
 2 files changed, 63 insertions(+), 22 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
index 10ee2c328458..21c3998a76c8 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
@@ -61,7 +61,8 @@ static int iwl_txq_gen2_set_tb_with_wa(struct iwl_trans *trans,
 				       struct sk_buff *skb,
 				       struct iwl_tfh_tfd *tfd,
 				       dma_addr_t phys, void *virt,
-				       u16 len, struct iwl_cmd_meta *meta)
+				       u16 len, struct iwl_cmd_meta *meta,
+				       bool unmap)
 {
 	dma_addr_t oldphys = phys;
 	struct page *page;
@@ -105,10 +106,27 @@ static int iwl_txq_gen2_set_tb_with_wa(struct iwl_trans *trans,
 
 	memcpy(page_address(page), virt, len);
 
-	phys = dma_map_single(trans->dev, page_address(page), len,
-			      DMA_TO_DEVICE);
-	if (unlikely(dma_mapping_error(trans->dev, phys)))
-		return -ENOMEM;
+	/*
+	 * This is a bit odd, but performance does not matter here, what
+	 * matters are the expectations of the calling code and TB cleanup
+	 * function.
+	 *
+	 * As such, if unmap is set, then create another mapping for the TB
+	 * entry as it will be unmapped later. On the other hand, if it is not
+	 * set, then the TB entry will not be unmapped and instead we simply
+	 * reference and sync the mapping that get_workaround_page() created.
+	 */
+	if (unmap) {
+		phys = dma_map_single(trans->dev, page_address(page), len,
+				      DMA_TO_DEVICE);
+		if (unlikely(dma_mapping_error(trans->dev, phys)))
+			return -ENOMEM;
+	} else {
+		phys = iwl_pcie_get_tso_page_phys(page_address(page));
+		dma_sync_single_for_device(trans->dev, phys, len,
+					   DMA_TO_DEVICE);
+	}
+
 	ret = iwl_txq_gen2_set_tb(trans, tfd, phys, len);
 	if (ret < 0) {
 		/* unmap the new allocation as single */
@@ -116,6 +134,7 @@ static int iwl_txq_gen2_set_tb_with_wa(struct iwl_trans *trans,
 		meta = NULL;
 		goto unmap;
 	}
+
 	IWL_DEBUG_TX(trans,
 		     "TB bug workaround: copied %d bytes from 0x%llx to 0x%llx\n",
 		     len, (unsigned long long)oldphys,
@@ -123,6 +142,9 @@ static int iwl_txq_gen2_set_tb_with_wa(struct iwl_trans *trans,
 
 	ret = 0;
 unmap:
+	if (!unmap)
+		goto trace;
+
 	if (meta)
 		dma_unmap_page(trans->dev, oldphys, len, DMA_TO_DEVICE);
 	else
@@ -146,6 +168,7 @@ static int iwl_txq_gen2_build_amsdu(struct iwl_trans *trans,
 	struct ieee80211_hdr *hdr = (void *)skb->data;
 	unsigned int snap_ip_tcp_hdrlen, ip_hdrlen, total_len, hdr_room;
 	unsigned int mss = skb_shinfo(skb)->gso_size;
+	dma_addr_t start_hdr_phys;
 	u16 length, amsdu_pad;
 	u8 *start_hdr;
 	struct sg_table *sgt;
@@ -168,6 +191,8 @@ static int iwl_txq_gen2_build_amsdu(struct iwl_trans *trans,
 	if (!sgt)
 		return -ENOMEM;
 
+	start_hdr_phys = iwl_pcie_get_tso_page_phys(start_hdr);
+
 	/*
 	 * Pull the ieee80211 header to be able to use TSO core,
 	 * we will restore it for the tx_status flow.
@@ -214,10 +239,8 @@ static int iwl_txq_gen2_build_amsdu(struct iwl_trans *trans,
 		pos_hdr += snap_ip_tcp_hdrlen;
 
 		tb_len = pos_hdr - start_hdr;
-		tb_phys = dma_map_single(trans->dev, start_hdr,
-					 tb_len, DMA_TO_DEVICE);
-		if (unlikely(dma_mapping_error(trans->dev, tb_phys)))
-			goto out_err;
+		tb_phys = iwl_pcie_get_tso_page_phys(start_hdr);
+
 		/*
 		 * No need for _with_wa, this is from the TSO page and
 		 * we leave some space at the end of it so can't hit
@@ -237,11 +260,14 @@ static int iwl_txq_gen2_build_amsdu(struct iwl_trans *trans,
 			int ret;
 
 			tb_len = min_t(unsigned int, tso.size, data_left);
-			tb_phys = dma_map_single(trans->dev, tso.data,
-						 tb_len, DMA_TO_DEVICE);
+			tb_phys = iwl_pcie_get_sgt_tb_phys(sgt, tso.data);
+			/* Not a real mapping error, use direct comparison */
+			if (unlikely(tb_phys == DMA_MAPPING_ERROR))
+				goto out_err;
+
 			ret = iwl_txq_gen2_set_tb_with_wa(trans, skb, tfd,
 							  tb_phys, tso.data,
-							  tb_len, NULL);
+							  tb_len, NULL, false);
 			if (ret)
 				goto out_err;
 
@@ -250,6 +276,9 @@ static int iwl_txq_gen2_build_amsdu(struct iwl_trans *trans,
 		}
 	}
 
+	dma_sync_single_for_device(trans->dev, start_hdr_phys, hdr_room,
+				   DMA_TO_DEVICE);
+
 	/* re -add the WiFi header */
 	skb_push(skb, hdr_len);
 
@@ -339,7 +368,7 @@ static int iwl_txq_gen2_tx_add_frags(struct iwl_trans *trans,
 					   fragsz, DMA_TO_DEVICE);
 		ret = iwl_txq_gen2_set_tb_with_wa(trans, skb, tfd, tb_phys,
 						  skb_frag_address(frag),
-						  fragsz, out_meta);
+						  fragsz, out_meta, true);
 		if (ret)
 			return ret;
 	}
@@ -413,7 +442,7 @@ iwl_tfh_tfd *iwl_txq_gen2_build_tx(struct iwl_trans *trans,
 					 tb2_len, DMA_TO_DEVICE);
 		ret = iwl_txq_gen2_set_tb_with_wa(trans, skb, tfd, tb_phys,
 						  skb->data + hdr_len, tb2_len,
-						  NULL);
+						  NULL, true);
 		if (ret)
 			goto out_err;
 	}
@@ -428,7 +457,8 @@ iwl_tfh_tfd *iwl_txq_gen2_build_tx(struct iwl_trans *trans,
 					 skb_headlen(frag), DMA_TO_DEVICE);
 		ret = iwl_txq_gen2_set_tb_with_wa(trans, skb, tfd, tb_phys,
 						  frag->data,
-						  skb_headlen(frag), NULL);
+						  skb_headlen(frag), NULL,
+						  true);
 		if (ret)
 			goto out_err;
 		if (iwl_txq_gen2_tx_add_frags(trans, frag, tfd, out_meta))
@@ -623,6 +653,10 @@ void iwl_txq_gen2_tfd_unmap(struct iwl_trans *trans,
 		return;
 	}
 
+	/* TB1 is mapped directly, the rest is the TSO page and SG list. */
+	if (meta->sg_offset)
+		num_tbs = 2;
+
 	/* first TB is never freed - it's the bidirectional DMA data */
 	for (i = 1; i < num_tbs; i++) {
 		if (meta->tbs & BIT(i))
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
index e00d85866de9..8afb5fc1972e 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
@@ -303,6 +303,10 @@ static void iwl_txq_gen1_tfd_unmap(struct iwl_trans *trans,
 		return;
 	}
 
+	/* TB1 is mapped directly, the rest is the TSO page and SG list. */
+	if (meta->sg_offset)
+		num_tbs = 2;
+
 	/* first TB is never freed - it's the bidirectional DMA data */
 
 	for (i = 1; i < num_tbs; i++) {
@@ -1892,6 +1896,7 @@ static int iwl_fill_data_tbs_amsdu(struct iwl_trans *trans, struct sk_buff *skb,
 	unsigned int snap_ip_tcp_hdrlen, ip_hdrlen, total_len, hdr_room;
 	unsigned int mss = skb_shinfo(skb)->gso_size;
 	u16 length, iv_len, amsdu_pad;
+	dma_addr_t start_hdr_phys;
 	u8 *start_hdr, *pos_hdr;
 	struct sg_table *sgt;
 	struct tso_t tso;
@@ -1920,6 +1925,7 @@ static int iwl_fill_data_tbs_amsdu(struct iwl_trans *trans, struct sk_buff *skb,
 	if (!sgt)
 		return -ENOMEM;
 
+	start_hdr_phys = iwl_pcie_get_tso_page_phys(start_hdr);
 	pos_hdr = start_hdr;
 	memcpy(pos_hdr, skb->data + hdr_len, iv_len);
 	pos_hdr += iv_len;
@@ -1971,10 +1977,8 @@ static int iwl_fill_data_tbs_amsdu(struct iwl_trans *trans, struct sk_buff *skb,
 		pos_hdr += snap_ip_tcp_hdrlen;
 
 		hdr_tb_len = pos_hdr - start_hdr;
-		hdr_tb_phys = dma_map_single(trans->dev, start_hdr,
-					     hdr_tb_len, DMA_TO_DEVICE);
-		if (unlikely(dma_mapping_error(trans->dev, hdr_tb_phys)))
-			return -EINVAL;
+		hdr_tb_phys = iwl_pcie_get_tso_page_phys(start_hdr);
+
 		iwl_pcie_txq_build_tfd(trans, txq, hdr_tb_phys,
 				       hdr_tb_len, false);
 		trace_iwlwifi_dev_tx_tb(trans->dev, skb, start_hdr,
@@ -1991,9 +1995,9 @@ static int iwl_fill_data_tbs_amsdu(struct iwl_trans *trans, struct sk_buff *skb,
 						  data_left);
 			dma_addr_t tb_phys;
 
-			tb_phys = dma_map_single(trans->dev, tso.data,
-						 size, DMA_TO_DEVICE);
-			if (unlikely(dma_mapping_error(trans->dev, tb_phys)))
+			tb_phys = iwl_pcie_get_sgt_tb_phys(sgt, tso.data);
+			/* Not a real mapping error, use direct comparison */
+			if (unlikely(tb_phys == DMA_MAPPING_ERROR))
 				return -EINVAL;
 
 			iwl_pcie_txq_build_tfd(trans, txq, tb_phys,
@@ -2006,6 +2010,9 @@ static int iwl_fill_data_tbs_amsdu(struct iwl_trans *trans, struct sk_buff *skb,
 		}
 	}
 
+	dma_sync_single_for_device(trans->dev, start_hdr_phys, hdr_room,
+				   DMA_TO_DEVICE);
+
 	/* re -add the WiFi header and IV */
 	skb_push(skb, hdr_len + iv_len);
 
-- 
2.34.1


