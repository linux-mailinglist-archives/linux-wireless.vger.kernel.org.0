Return-Path: <linux-wireless+bounces-18670-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AACA5A2DDD3
	for <lists+linux-wireless@lfdr.de>; Sun,  9 Feb 2025 13:35:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3C8A1886773
	for <lists+linux-wireless@lfdr.de>; Sun,  9 Feb 2025 12:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F8D1DE2C4;
	Sun,  9 Feb 2025 12:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K9ppKDOo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9A01DEFD6
	for <linux-wireless@vger.kernel.org>; Sun,  9 Feb 2025 12:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739104527; cv=none; b=FzE2kEMCVIXJnZ4MyfGN3x7Tkefw56KOu/Vd5iPv6GhO7QyxQEgZ0Xb7222l/NwiwqupYzsgdaHNTAHOcU2rIXaas9ER//jAFlxlntxQYE5AUavNQ50Hin97dO4FbQ+xL78plc3feOXgexgzHyvxJv4AFBmwbCrEWyvcEpRezos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739104527; c=relaxed/simple;
	bh=bg2k8jcm1b6E6qh/13yDOWN1E8H7Z9dRhancspZ0TLU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GFCSa6mmd0jw+9PUs6PZKoj4B2pEqaHBNyilNJCnIkwpHeoiPLxuwFSt3dDM2Am7sqqLhxnnZScQ8vtKE5+k7XaOSExds3FliSBfv3jHXt2xKbZp0dG487H3dIrk6OH6nTAhBwepdJ/Eg403V4jInWSpb5xAPPFpKl+3fEWWjTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K9ppKDOo; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739104525; x=1770640525;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bg2k8jcm1b6E6qh/13yDOWN1E8H7Z9dRhancspZ0TLU=;
  b=K9ppKDOorfXicZB7bDjVsXh1RKgmijJyutFHoz6MAdBT/Z7kwsSvgeq6
   tPrBYq4j7s9P2U0H13GtQavx2e11LETppAr2QFmPeGedlNUK/KxEyuiQK
   Aqe04LeWqCe6dKLsuI9vk7P5Kr8H7S9cG9q06+m+tGD74zXJsC8g+dolX
   snR3vpho5asZMwhJjYzASNrTvV4CIHL514I2kVODNfcK4ggjosomPxk0n
   eiI3L7EQEPejthA1vFuRrFvmV2ogbv7C5570X8ey9KRavCDowRS4RgNly
   kQQR0vzjX3qt2UW1jranTFA2RLhNwNeyURuBU19Tj1i1Ssq9y4T9OSZG2
   w==;
X-CSE-ConnectionGUID: KT+MetTvS1uYBv+jYeLu/A==
X-CSE-MsgGUID: bU7My2H+QbKQop7nkt1tsQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="51125990"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="51125990"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2025 04:35:25 -0800
X-CSE-ConnectionGUID: t/LaAuWLTPOONhVlV1UQzw==
X-CSE-MsgGUID: oP0cNllLSWe9nznpyWvLig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="111782471"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2025 04:35:23 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Ilan Peer <ilan.peer@intel.com>,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH 9/9] wifi: iwlwifi: Fix A-MSDU TSO preparation
Date: Sun,  9 Feb 2025 14:34:53 +0200
Message-Id: <20250209143303.75769a4769bf.Iaf79e8538093cdf8c446c292cc96164ad6498f61@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250209123453.2010013-1-miriam.rachel.korenblit@intel.com>
References: <20250209123453.2010013-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Ilan Peer <ilan.peer@intel.com>

The TSO preparation assumed that the skb head contained the headers
while the rest of the data was in the fragments. Since this is not
always true, e.g., it is possible that the data was linearised, modify
the TSO preparation to start the data processing after the network
headers.

Fixes: 7f5e3038f029 ("wifi: iwlwifi: map entire SKB when sending AMSDUs")
Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Reviewed-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../wireless/intel/iwlwifi/pcie/internal.h    |  5 +++--
 .../net/wireless/intel/iwlwifi/pcie/tx-gen2.c |  5 +++--
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c  | 20 +++++++++++--------
 3 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
index 856b7e9f717d..45460f93d24a 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2003-2015, 2018-2024 Intel Corporation
+ * Copyright (C) 2003-2015, 2018-2025 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -646,7 +646,8 @@ dma_addr_t iwl_pcie_get_sgt_tb_phys(struct sg_table *sgt, unsigned int offset,
 				    unsigned int len);
 struct sg_table *iwl_pcie_prep_tso(struct iwl_trans *trans, struct sk_buff *skb,
 				   struct iwl_cmd_meta *cmd_meta,
-				   u8 **hdr, unsigned int hdr_room);
+				   u8 **hdr, unsigned int hdr_room,
+				   unsigned int offset);
 
 void iwl_pcie_free_tso_pages(struct iwl_trans *trans, struct sk_buff *skb,
 			     struct iwl_cmd_meta *cmd_meta);
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
index dce5096db82b..401919f9fe88 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
  * Copyright (C) 2017 Intel Deutschland GmbH
- * Copyright (C) 2018-2020, 2023-2024 Intel Corporation
+ * Copyright (C) 2018-2020, 2023-2025 Intel Corporation
  */
 #include <net/tso.h>
 #include <linux/tcp.h>
@@ -188,7 +188,8 @@ static int iwl_txq_gen2_build_amsdu(struct iwl_trans *trans,
 		(3 + snap_ip_tcp_hdrlen + sizeof(struct ethhdr));
 
 	/* Our device supports 9 segments at most, it will fit in 1 page */
-	sgt = iwl_pcie_prep_tso(trans, skb, out_meta, &start_hdr, hdr_room);
+	sgt = iwl_pcie_prep_tso(trans, skb, out_meta, &start_hdr, hdr_room,
+				snap_ip_tcp_hdrlen + hdr_len);
 	if (!sgt)
 		return -ENOMEM;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
index 334ebd4c12fa..7b6071a59b69 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2003-2014, 2018-2021, 2023-2024 Intel Corporation
+ * Copyright (C) 2003-2014, 2018-2021, 2023-2025 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -1855,6 +1855,7 @@ dma_addr_t iwl_pcie_get_sgt_tb_phys(struct sg_table *sgt, unsigned int offset,
  * @cmd_meta: command meta to store the scatter list information for unmapping
  * @hdr: output argument for TSO headers
  * @hdr_room: requested length for TSO headers
+ * @offset: offset into the data from which mapping should start
  *
  * Allocate space for a scatter gather list and TSO headers and map the SKB
  * using the scatter gather list. The SKB is unmapped again when the page is
@@ -1864,18 +1865,20 @@ dma_addr_t iwl_pcie_get_sgt_tb_phys(struct sg_table *sgt, unsigned int offset,
  */
 struct sg_table *iwl_pcie_prep_tso(struct iwl_trans *trans, struct sk_buff *skb,
 				   struct iwl_cmd_meta *cmd_meta,
-				   u8 **hdr, unsigned int hdr_room)
+				   u8 **hdr, unsigned int hdr_room,
+				   unsigned int offset)
 {
 	struct sg_table *sgt;
+	unsigned int n_segments;
 
 	if (WARN_ON_ONCE(skb_has_frag_list(skb)))
 		return NULL;
 
+	n_segments = DIV_ROUND_UP(skb->len - offset, skb_shinfo(skb)->gso_size);
 	*hdr = iwl_pcie_get_page_hdr(trans,
 				     hdr_room + __alignof__(struct sg_table) +
 				     sizeof(struct sg_table) +
-				     (skb_shinfo(skb)->nr_frags + 1) *
-				     sizeof(struct scatterlist),
+				     n_segments * sizeof(struct scatterlist),
 				     skb);
 	if (!*hdr)
 		return NULL;
@@ -1883,11 +1886,11 @@ struct sg_table *iwl_pcie_prep_tso(struct iwl_trans *trans, struct sk_buff *skb,
 	sgt = (void *)PTR_ALIGN(*hdr + hdr_room, __alignof__(struct sg_table));
 	sgt->sgl = (void *)(sgt + 1);
 
-	sg_init_table(sgt->sgl, skb_shinfo(skb)->nr_frags + 1);
+	sg_init_table(sgt->sgl, n_segments);
 
 	/* Only map the data, not the header (it is copied to the TSO page) */
-	sgt->orig_nents = skb_to_sgvec(skb, sgt->sgl, skb_headlen(skb),
-				       skb->data_len);
+	sgt->orig_nents = skb_to_sgvec(skb, sgt->sgl, offset,
+				       skb->len - offset);
 	if (WARN_ON_ONCE(sgt->orig_nents <= 0))
 		return NULL;
 
@@ -1939,7 +1942,8 @@ static int iwl_fill_data_tbs_amsdu(struct iwl_trans *trans, struct sk_buff *skb,
 		(3 + snap_ip_tcp_hdrlen + sizeof(struct ethhdr)) + iv_len;
 
 	/* Our device supports 9 segments at most, it will fit in 1 page */
-	sgt = iwl_pcie_prep_tso(trans, skb, out_meta, &start_hdr, hdr_room);
+	sgt = iwl_pcie_prep_tso(trans, skb, out_meta, &start_hdr, hdr_room,
+				snap_ip_tcp_hdrlen + hdr_len + iv_len);
 	if (!sgt)
 		return -ENOMEM;
 
-- 
2.34.1


