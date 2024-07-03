Return-Path: <linux-wireless+bounces-9905-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D18925793
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 11:59:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC0031C25D2A
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 09:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35CE8155C81;
	Wed,  3 Jul 2024 09:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MHslcbP9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F0F1422C9
	for <linux-wireless@vger.kernel.org>; Wed,  3 Jul 2024 09:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720000763; cv=none; b=Nc6w+oZYdElVAlRnxsbOXexzMs+8MkilHtCCTRbx5d8ox75Tzank6pyH2HT1cXb8KxnDf/DYAhKIbcGB5Rb8QbgMfGf8ML0YEZFvkKfeRpG5t23eMDFTeYEtlevtIaHV/cAFyeNSz/ZgtFKnvJ0DdtzQdTeLNyaeNEiQxvSPD+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720000763; c=relaxed/simple;
	bh=fehBCLNPMBgjV+po50JnP1GYnptAjKZ6spyHotkJ0yw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IyO5e27esU1eGRzAHvqMBsBQN75XTX6BTRa+ShJVOnKzLa1ZGuV/FiM+UoJ/jOP1VVsrVmVbQOj2VmUnMoCyLDaAdkL61obzbF8kx9VJ904ZnXX5vWwS+BRMba1Jf6V1mOqj/4kPS1kmTG+yu10ORZmJpWF0rukTcE5kKrh0dHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MHslcbP9; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720000761; x=1751536761;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fehBCLNPMBgjV+po50JnP1GYnptAjKZ6spyHotkJ0yw=;
  b=MHslcbP97m/MaG9/PteviX/23gj7WGBd1/r770FTMM0Y04n6tsViqMv7
   mOkzCAKM7W0ne9pag3F7k8fDGRRlfQ+7uk9gIGzEQnFlHgkC44pe5Sa2v
   hdmQvmwOut4X1Lt27eK6qyTUHcbp5Mtuvy+1JwaKGGxEm7B4lylp2E+9z
   TgQn95GyUSKj0AWLfxSboeqWO2IhOpfEhdcTsX//JFRsL1Nr+dnIbw9AA
   XVk5JRqvEJEz43psC8xPDRqOX+PJ8Vlgs+aws5MY8OOv3E8tsn3RAN5pn
   4k/JR0y/VeFZ5sR1yrHF58NW96TjuvTo/+6VQD/rztBSIO1nG/gYqgFTf
   A==;
X-CSE-ConnectionGUID: SCXGS5sYQDKVaJg+viEohQ==
X-CSE-MsgGUID: 9UuO20mMR2exKaqDfVFoNA==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="27837521"
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="27837521"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 02:59:21 -0700
X-CSE-ConnectionGUID: iBKAqh2eQb6Kxm2xXFey6w==
X-CSE-MsgGUID: vwYadu8SSFu0Tizd6Es1zg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="45987736"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 02:59:18 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Benjamin Berg <benjamin.berg@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 04/18] wifi: iwlwifi: return a new allocation for hdr page space
Date: Wed,  3 Jul 2024 12:58:52 +0300
Message-Id: <20240703125541.044f2cb373f1.I52a807ac6f311b89530e18deacc7452638a6f5d8@changeid>
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

Instead of returning the pointer to the structure describing the header
page, return the pointer to the newly allocated area. This disentangles
the user from the allocation within the page as it does not need to
advance the position itself.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
---
 .../wireless/intel/iwlwifi/pcie/internal.h    |  4 +-
 .../net/wireless/intel/iwlwifi/pcie/tx-gen2.c | 35 ++++++-------
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c  | 50 ++++++++++---------
 3 files changed, 44 insertions(+), 45 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
index f2bb34270ccf..754928062921 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
@@ -623,8 +623,8 @@ void iwl_trans_pcie_tx_reset(struct iwl_trans *trans);
 int iwl_pcie_txq_alloc(struct iwl_trans *trans, struct iwl_txq *txq,
 		       int slots_num, bool cmd_queue);
 
-struct iwl_tso_hdr_page *iwl_pcie_get_page_hdr(struct iwl_trans *trans,
-					       size_t len, struct sk_buff *skb);
+void *iwl_pcie_get_page_hdr(struct iwl_trans *trans, size_t len,
+			    struct sk_buff *skb);
 void iwl_pcie_free_tso_page(struct iwl_trans *trans, struct sk_buff *skb);
 
 static inline dma_addr_t
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
index b897de1b9226..543efb52b084 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
@@ -130,7 +130,6 @@ static int iwl_txq_gen2_build_amsdu(struct iwl_trans *trans,
 	unsigned int mss = skb_shinfo(skb)->gso_size;
 	u16 length, amsdu_pad;
 	u8 *start_hdr;
-	struct iwl_tso_hdr_page *hdr_page;
 	struct tso_t tso;
 
 	trace_iwlwifi_dev_tx(trans->dev, skb, tfd, sizeof(*tfd),
@@ -146,12 +145,10 @@ static int iwl_txq_gen2_build_amsdu(struct iwl_trans *trans,
 		(3 + snap_ip_tcp_hdrlen + sizeof(struct ethhdr));
 
 	/* Our device supports 9 segments at most, it will fit in 1 page */
-	hdr_page = iwl_pcie_get_page_hdr(trans, hdr_room, skb);
-	if (!hdr_page)
+	start_hdr = iwl_pcie_get_page_hdr(trans, hdr_room, skb);
+	if (!start_hdr)
 		return -ENOMEM;
 
-	start_hdr = hdr_page->pos;
-
 	/*
 	 * Pull the ieee80211 header to be able to use TSO core,
 	 * we will restore it for the tx_status flow.
@@ -172,32 +169,32 @@ static int iwl_txq_gen2_build_amsdu(struct iwl_trans *trans,
 		unsigned int data_left = min_t(unsigned int, mss, total_len);
 		unsigned int tb_len;
 		dma_addr_t tb_phys;
-		u8 *subf_hdrs_start = hdr_page->pos;
+		u8 *pos_hdr = start_hdr;
 
 		total_len -= data_left;
 
-		memset(hdr_page->pos, 0, amsdu_pad);
-		hdr_page->pos += amsdu_pad;
+		memset(pos_hdr, 0, amsdu_pad);
+		pos_hdr += amsdu_pad;
 		amsdu_pad = (4 - (sizeof(struct ethhdr) + snap_ip_tcp_hdrlen +
 				  data_left)) & 0x3;
-		ether_addr_copy(hdr_page->pos, ieee80211_get_DA(hdr));
-		hdr_page->pos += ETH_ALEN;
-		ether_addr_copy(hdr_page->pos, ieee80211_get_SA(hdr));
-		hdr_page->pos += ETH_ALEN;
+		ether_addr_copy(pos_hdr, ieee80211_get_DA(hdr));
+		pos_hdr += ETH_ALEN;
+		ether_addr_copy(pos_hdr, ieee80211_get_SA(hdr));
+		pos_hdr += ETH_ALEN;
 
 		length = snap_ip_tcp_hdrlen + data_left;
-		*((__be16 *)hdr_page->pos) = cpu_to_be16(length);
-		hdr_page->pos += sizeof(length);
+		*((__be16 *)pos_hdr) = cpu_to_be16(length);
+		pos_hdr += sizeof(length);
 
 		/*
 		 * This will copy the SNAP as well which will be considered
 		 * as MAC header.
 		 */
-		tso_build_hdr(skb, hdr_page->pos, &tso, data_left, !total_len);
+		tso_build_hdr(skb, pos_hdr, &tso, data_left, !total_len);
 
-		hdr_page->pos += snap_ip_tcp_hdrlen;
+		pos_hdr += snap_ip_tcp_hdrlen;
 
-		tb_len = hdr_page->pos - start_hdr;
+		tb_len = pos_hdr - start_hdr;
 		tb_phys = dma_map_single(trans->dev, start_hdr,
 					 tb_len, DMA_TO_DEVICE);
 		if (unlikely(dma_mapping_error(trans->dev, tb_phys)))
@@ -211,10 +208,10 @@ static int iwl_txq_gen2_build_amsdu(struct iwl_trans *trans,
 		trace_iwlwifi_dev_tx_tb(trans->dev, skb, start_hdr,
 					tb_phys, tb_len);
 		/* add this subframe's headers' length to the tx_cmd */
-		le16_add_cpu(&tx_cmd->len, hdr_page->pos - subf_hdrs_start);
+		le16_add_cpu(&tx_cmd->len, tb_len);
 
 		/* prepare the start_hdr for the next subframe */
-		start_hdr = hdr_page->pos;
+		start_hdr = pos_hdr;
 
 		/* put the payload */
 		while (data_left) {
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
index f4452732417d..d67ad40634f9 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
@@ -1702,12 +1702,13 @@ static int iwl_fill_data_tbs(struct iwl_trans *trans, struct sk_buff *skb,
 }
 
 #ifdef CONFIG_INET
-struct iwl_tso_hdr_page *iwl_pcie_get_page_hdr(struct iwl_trans *trans,
-					       size_t len, struct sk_buff *skb)
+void *iwl_pcie_get_page_hdr(struct iwl_trans *trans,
+			    size_t len, struct sk_buff *skb)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	struct iwl_tso_hdr_page *p = this_cpu_ptr(trans_pcie->txqs.tso_hdr_page);
 	struct page **page_ptr;
+	void *ret;
 
 	page_ptr = (void *)((u8 *)skb->cb + trans_pcie->txqs.page_offs);
 
@@ -1744,7 +1745,10 @@ struct iwl_tso_hdr_page *iwl_pcie_get_page_hdr(struct iwl_trans *trans,
 out:
 	*page_ptr = p->page;
 	get_page(p->page);
-	return p;
+	ret = p->pos;
+	p->pos += len;
+
+	return ret;
 }
 
 static int iwl_fill_data_tbs_amsdu(struct iwl_trans *trans, struct sk_buff *skb,
@@ -1759,8 +1763,7 @@ static int iwl_fill_data_tbs_amsdu(struct iwl_trans *trans, struct sk_buff *skb,
 	unsigned int snap_ip_tcp_hdrlen, ip_hdrlen, total_len, hdr_room;
 	unsigned int mss = skb_shinfo(skb)->gso_size;
 	u16 length, iv_len, amsdu_pad;
-	u8 *start_hdr;
-	struct iwl_tso_hdr_page *hdr_page;
+	u8 *start_hdr, *pos_hdr;
 	struct tso_t tso;
 
 	/* if the packet is protected, then it must be CCMP or GCMP */
@@ -1783,13 +1786,12 @@ static int iwl_fill_data_tbs_amsdu(struct iwl_trans *trans, struct sk_buff *skb,
 		(3 + snap_ip_tcp_hdrlen + sizeof(struct ethhdr)) + iv_len;
 
 	/* Our device supports 9 segments at most, it will fit in 1 page */
-	hdr_page = iwl_pcie_get_page_hdr(trans, hdr_room, skb);
-	if (!hdr_page)
+	pos_hdr = start_hdr = iwl_pcie_get_page_hdr(trans, hdr_room, skb);
+	if (!start_hdr)
 		return -ENOMEM;
 
-	start_hdr = hdr_page->pos;
-	memcpy(hdr_page->pos, skb->data + hdr_len, iv_len);
-	hdr_page->pos += iv_len;
+	memcpy(pos_hdr, skb->data + hdr_len, iv_len);
+	pos_hdr += iv_len;
 
 	/*
 	 * Pull the ieee80211 header + IV to be able to use TSO core,
@@ -1812,32 +1814,32 @@ static int iwl_fill_data_tbs_amsdu(struct iwl_trans *trans, struct sk_buff *skb,
 			min_t(unsigned int, mss, total_len);
 		unsigned int hdr_tb_len;
 		dma_addr_t hdr_tb_phys;
-		u8 *subf_hdrs_start = hdr_page->pos;
+		u8 *subf_hdrs_start = pos_hdr;
 
 		total_len -= data_left;
 
-		memset(hdr_page->pos, 0, amsdu_pad);
-		hdr_page->pos += amsdu_pad;
+		memset(pos_hdr, 0, amsdu_pad);
+		pos_hdr += amsdu_pad;
 		amsdu_pad = (4 - (sizeof(struct ethhdr) + snap_ip_tcp_hdrlen +
 				  data_left)) & 0x3;
-		ether_addr_copy(hdr_page->pos, ieee80211_get_DA(hdr));
-		hdr_page->pos += ETH_ALEN;
-		ether_addr_copy(hdr_page->pos, ieee80211_get_SA(hdr));
-		hdr_page->pos += ETH_ALEN;
+		ether_addr_copy(pos_hdr, ieee80211_get_DA(hdr));
+		pos_hdr += ETH_ALEN;
+		ether_addr_copy(pos_hdr, ieee80211_get_SA(hdr));
+		pos_hdr += ETH_ALEN;
 
 		length = snap_ip_tcp_hdrlen + data_left;
-		*((__be16 *)hdr_page->pos) = cpu_to_be16(length);
-		hdr_page->pos += sizeof(length);
+		*((__be16 *)pos_hdr) = cpu_to_be16(length);
+		pos_hdr += sizeof(length);
 
 		/*
 		 * This will copy the SNAP as well which will be considered
 		 * as MAC header.
 		 */
-		tso_build_hdr(skb, hdr_page->pos, &tso, data_left, !total_len);
+		tso_build_hdr(skb, pos_hdr, &tso, data_left, !total_len);
 
-		hdr_page->pos += snap_ip_tcp_hdrlen;
+		pos_hdr += snap_ip_tcp_hdrlen;
 
-		hdr_tb_len = hdr_page->pos - start_hdr;
+		hdr_tb_len = pos_hdr - start_hdr;
 		hdr_tb_phys = dma_map_single(trans->dev, start_hdr,
 					     hdr_tb_len, DMA_TO_DEVICE);
 		if (unlikely(dma_mapping_error(trans->dev, hdr_tb_phys)))
@@ -1847,10 +1849,10 @@ static int iwl_fill_data_tbs_amsdu(struct iwl_trans *trans, struct sk_buff *skb,
 		trace_iwlwifi_dev_tx_tb(trans->dev, skb, start_hdr,
 					hdr_tb_phys, hdr_tb_len);
 		/* add this subframe's headers' length to the tx_cmd */
-		le16_add_cpu(&tx_cmd->len, hdr_page->pos - subf_hdrs_start);
+		le16_add_cpu(&tx_cmd->len, pos_hdr - subf_hdrs_start);
 
 		/* prepare the start_hdr for the next subframe */
-		start_hdr = hdr_page->pos;
+		start_hdr = pos_hdr;
 
 		/* put the payload */
 		while (data_left) {
-- 
2.34.1


