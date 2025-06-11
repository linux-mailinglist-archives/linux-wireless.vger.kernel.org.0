Return-Path: <linux-wireless+bounces-23968-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72F90AD4970
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Jun 2025 05:35:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9D7A3A64A5
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Jun 2025 03:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11C2224AE8;
	Wed, 11 Jun 2025 03:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="itYqcett"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C877225390
	for <linux-wireless@vger.kernel.org>; Wed, 11 Jun 2025 03:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749612886; cv=none; b=GetcpYdHA0eXpc9cv9Z/BWlCG8KmNn/mDkWpisZi5LIULNaVHSUU4xWPYBfRBJDk0hAWPa3Z/j3cUP5/4OfErbwcOKHgIkG7c9X0CtLtUuDoYSkrXASbFkjvFaAk9avK/SEqjocGKpIwiJ9JP2lD3ahP+sGtUSRW4JA8z/kMw5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749612886; c=relaxed/simple;
	bh=RLmNVZjrSHGeXBYCymqhAETWJdCGkX14Wr1pqgtheAI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M0aE72nhN5UdHsu7zVkO/KTu+yTkM3LLATLXimud+b2NwlSdg0gVinca5pkkciYxhZVBz5FQetS7wsrcIJFm48JsxHespTdXLR6l5Xbkk4FhDxTIom7pdjM9ZLhDUgzf0V1dUmKvr2LecFRMeZfBa7YME5EnuNeVM/jd00eLr7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=itYqcett; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749612885; x=1781148885;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RLmNVZjrSHGeXBYCymqhAETWJdCGkX14Wr1pqgtheAI=;
  b=itYqcettiWuoMvCQy51GKkGhZq5gCuAJeytRQtFyrjSe9G+79HG76kVQ
   orBUkTlUWLdN3DCk8XDh969Uj/xyfwYeIyjJ3FuloiftRdqJubV2cOXPt
   yqX4oZ6eQVTPsmIU73Qnncuga5bhQDCAay+0qw28/tMSwirsuFFxZ5zV0
   YZc9Bq+cvoijLKPj890E1LZFceNIJe/fFseSEfh6851nY+kcD9vUxTPSV
   MG2IvDYyxkYjcjHODE1ANNNlIUK7gSvBBWvKJXE3l6Wpx39yZCphnNED3
   oMgjmqXyRR2jmrjfMionStsmZeL0EMlpWT0XWqmzzYl/LtJaU3LpUqLBP
   Q==;
X-CSE-ConnectionGUID: GRrk7yozR/i6A5vbAaH4AQ==
X-CSE-MsgGUID: RHUWDTLfSdy0P60GtyHGaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11460"; a="63094895"
X-IronPort-AV: E=Sophos;i="6.16,226,1744095600"; 
   d="scan'208";a="63094895"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 20:34:45 -0700
X-CSE-ConnectionGUID: cz0pmPH/TSGZabIVuAtfzQ==
X-CSE-MsgGUID: A7t9aLWKTbS65UbaQsLZgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,226,1744095600"; 
   d="scan'208";a="150880969"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 20:34:44 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 11/15] wifi: iwlwifi: pcie: fix kernel-doc warnings
Date: Wed, 11 Jun 2025 06:34:11 +0300
Message-Id: <20250611063124.7434b8ecc4b6.Ia4cfeea63e946f3b54e3e6b7bd6ab81130b0a7e6@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250611033415.1175681-1-miriam.rachel.korenblit@intel.com>
References: <20250611033415.1175681-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Also fix the name of the iwl_prph_scratch_mem_desc_addr_array
struct and some related spelling.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-v2.c      | 4 ++--
 drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/internal.h   | 5 ++++-
 .../net/wireless/intel/iwlwifi/pcie/iwl-context-info-v2.h   | 6 +++---
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-v2.c b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-v2.c
index 0df379fda463..06be929a3ca5 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-v2.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-v2.c
@@ -391,13 +391,13 @@ static int iwl_pcie_load_payloads_segments
 {
 	struct iwl_dram_data *cur_payload_dram = &dram_regions->drams[0];
 	struct iwl_dram_data *desc_dram = &dram_regions->prph_scratch_mem_desc;
-	struct iwl_prph_scrath_mem_desc_addr_array *addresses;
+	struct iwl_prph_scratch_mem_desc_addr_array *addresses;
 	const void *data;
 	u32 len;
 	int i;
 
 	/* allocate and init DRAM descriptors array */
-	len = sizeof(struct iwl_prph_scrath_mem_desc_addr_array);
+	len = sizeof(struct iwl_prph_scratch_mem_desc_addr_array);
 	desc_dram->block = iwl_pcie_ctxt_info_dma_alloc_coherent
 						(trans,
 						 len,
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/internal.h b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/internal.h
index ebcc174f6c62..b1dcaae0dc10 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/internal.h
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/internal.h
@@ -39,7 +39,7 @@ struct iwl_host_cmd;
  * trans_pcie layer */
 
 /**
- * struct iwl_rx_mem_buffer
+ * struct iwl_rx_mem_buffer - driver-side RX buffer descriptor
  * @page_dma: bus address of rxb page
  * @page: driver's pointer to the rxb page
  * @list: list entry for the membuffer
@@ -190,6 +190,7 @@ struct iwl_rb_allocator {
  * iwl_get_closed_rb_stts - get closed rb stts from different structs
  * @trans: transport pointer (for configuration)
  * @rxq: the rxq to get the rb stts from
+ * Return: last closed RB index
  */
 static inline u16 iwl_get_closed_rb_stts(struct iwl_trans *trans,
 					 struct iwl_rxq *rxq)
@@ -703,6 +704,7 @@ static inline void iwl_txq_stop(struct iwl_trans *trans, struct iwl_txq *txq)
  * iwl_txq_inc_wrap - increment queue index, wrap back to beginning
  * @trans: the transport (for configuration data)
  * @index: current index
+ * Return: the queue index incremented, subject to wrapping
  */
 static inline int iwl_txq_inc_wrap(struct iwl_trans *trans, int index)
 {
@@ -714,6 +716,7 @@ static inline int iwl_txq_inc_wrap(struct iwl_trans *trans, int index)
  * iwl_txq_dec_wrap - decrement queue index, wrap back to end
  * @trans: the transport (for configuration data)
  * @index: current index
+ * Return: the queue index decremented, subject to wrapping
  */
 static inline int iwl_txq_dec_wrap(struct iwl_trans *trans, int index)
 {
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/iwl-context-info-v2.h b/drivers/net/wireless/intel/iwlwifi/pcie/iwl-context-info-v2.h
index 8c5c0ea46181..19f67f868fe5 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/iwl-context-info-v2.h
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/iwl-context-info-v2.h
@@ -130,11 +130,11 @@ struct iwl_prph_scratch_pnvm_cfg {
 } __packed; /* PERIPH_SCRATCH_PNVM_CFG_S */
 
 /**
- * struct iwl_prph_scrath_mem_desc_addr_array
+ * struct iwl_prph_scratch_mem_desc_addr_array - DRAM 
  * @mem_descs: array of dram addresses.
- * Each address is the beggining of a pnvm payload.
+ * Each address is the beginning of a PNVM payload.
  */
-struct iwl_prph_scrath_mem_desc_addr_array {
+struct iwl_prph_scratch_mem_desc_addr_array {
 	__le64 mem_descs[IPC_DRAM_MAP_ENTRY_NUM_MAX];
 } __packed; /* PERIPH_SCRATCH_MEM_DESC_ADDR_ARRAY_S_VER_1 */
 
-- 
2.34.1


