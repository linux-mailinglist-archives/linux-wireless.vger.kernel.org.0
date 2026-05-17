Return-Path: <linux-wireless+bounces-36549-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eMC3KOp1CWokbAQAu9opvQ
	(envelope-from <linux-wireless+bounces-36549-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 17 May 2026 10:01:46 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A85255FD93
	for <lists+linux-wireless@lfdr.de>; Sun, 17 May 2026 10:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 741BD3019057
	for <lists+linux-wireless@lfdr.de>; Sun, 17 May 2026 08:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1203B67E;
	Sun, 17 May 2026 08:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ijkklfni"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271882DEA6B
	for <linux-wireless@vger.kernel.org>; Sun, 17 May 2026 08:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779004845; cv=none; b=BbSlmDEYuLmTI6inK4YP5rjXD5e9h47Tnv6Qmlq5c3dBXolUH5ZkjsKOoS9GrI3HleW3R31dc3dmDCr55qm4nDM6x6FKH3Pt0c4xy19TA5SBln1SfaFQVGxOV3Y5c9fXD0y9/S+8Bxx2bFL29wbWptoOkE1Z5ZvOieK3indfc4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779004845; c=relaxed/simple;
	bh=G0/iNgEqyoajl8BcvSILudCcCIH2x2OpakqIfzsQEj4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XCF2PSA4cIDegJhvHdwgzAC9h2PtglDFtbCI/mjAHVqw+6RISbyJUiYr3jlGl12MLbOTVUlsnKSRqBoN6Tn0iay53KI1/ASxfTDJh6V+qY0oZ0xDwrdsESoju+ZnjVLiVoNauEAGLbUvKketKHR1LfbWtE7/MLX5Kf2BuMFdldc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ijkklfni; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779004844; x=1810540844;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=G0/iNgEqyoajl8BcvSILudCcCIH2x2OpakqIfzsQEj4=;
  b=IjkklfniErIJoq0T1/PzgOkGdYofPpqb4GZW7UFU84ZTq0e896uZyicc
   rfy0fsdW604zZsmsGEeXavi2ip5voTIHGk1Um0Wc+c+vOHJOwQuqBnKl/
   k2ojmUmBiGot9u0sgumTqdYQW3M14egj5k3wGaJDushYwcqyd67KeIF54
   PmQp10c2KkIez5MkSvJ4I4d8NHcIAEopJtFwGwZjoMHNpUT1p3eYbN38u
   y2Kjq/6ClIrj4G6SR3fgHM40c13SoK+KQUzmrbOJjwlqbjCusf1iXF9Op
   8neSjMhqcmy3vBl2oBM36/cMnfhYGjsd09zpzKcD5o18hYDg3z1sxY2jV
   g==;
X-CSE-ConnectionGUID: ot+b33QRQh+ywWmCsC661A==
X-CSE-MsgGUID: kjqIk/cfTlmEXjmCFVu//A==
X-IronPort-AV: E=McAfee;i="6800,10657,11788"; a="79606979"
X-IronPort-AV: E=Sophos;i="6.23,239,1770624000"; 
   d="scan'208";a="79606979"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2026 01:00:43 -0700
X-CSE-ConnectionGUID: Bx7NRkVZTTSWSusyRlG0bQ==
X-CSE-MsgGUID: Hl04bJ7aSFyoA7A9Sz7xgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,239,1770624000"; 
   d="scan'208";a="236490527"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2026 01:00:42 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2 iwlwifi-next 14/15] wifi: iwlwifi: dbg: remove unused 'range_len' arg from dump
Date: Sun, 17 May 2026 10:59:58 +0300
Message-Id: <20260517100550.ea3502f97c2a.I4ce08f0ea7ea3bacd4928b427c0710b77259d002@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260517075959.2815365-1-miriam.rachel.korenblit@intel.com>
References: <20260517075959.2815365-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2A85255FD93
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-36549-lists,linux-wireless=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim]
X-Rspamd-Action: no action

From: Johannes Berg <johannes.berg@intel.com>

None of the functions use this, and it's not really passed the
length of the specific range anyway, but rather the entire
remaining size. Remove the unused argument.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c | 45 ++++++++++-----------
 1 file changed, 22 insertions(+), 23 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index 64ead8ecd52c..069c3bad6f29 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -111,7 +111,7 @@ static int iwl_dump_ini_prph_mac_iter_common(struct iwl_fw_runtime *fwrt,
 static int
 iwl_dump_ini_prph_mac_iter(struct iwl_fw_runtime *fwrt,
 			   struct iwl_dump_ini_region_data *reg_data,
-			   void *range_ptr, u32 range_len, int idx)
+			   void *range_ptr, int idx)
 {
 	struct iwl_fw_ini_region_tlv *reg = (void *)reg_data->reg_tlv->data;
 	u32 addr = le32_to_cpu(reg->addrs[idx]) +
@@ -124,7 +124,7 @@ iwl_dump_ini_prph_mac_iter(struct iwl_fw_runtime *fwrt,
 static int
 iwl_dump_ini_prph_mac_block_iter(struct iwl_fw_runtime *fwrt,
 				 struct iwl_dump_ini_region_data *reg_data,
-				 void *range_ptr, u32 range_len, int idx)
+				 void *range_ptr, int idx)
 {
 	struct iwl_fw_ini_region_tlv *reg = (void *)reg_data->reg_tlv->data;
 	struct iwl_fw_ini_addr_size *pairs = (void *)reg->addrs;
@@ -201,7 +201,7 @@ static int iwl_dump_ini_prph_phy_iter_common(struct iwl_fw_runtime *fwrt,
 static int
 iwl_dump_ini_prph_phy_iter(struct iwl_fw_runtime *fwrt,
 			   struct iwl_dump_ini_region_data *reg_data,
-			   void *range_ptr, u32 range_len, int idx)
+			   void *range_ptr, int idx)
 {
 	struct iwl_fw_ini_region_tlv *reg = (void *)reg_data->reg_tlv->data;
 	u32 addr = le32_to_cpu(reg->addrs[idx]);
@@ -214,7 +214,7 @@ iwl_dump_ini_prph_phy_iter(struct iwl_fw_runtime *fwrt,
 static int
 iwl_dump_ini_prph_phy_block_iter(struct iwl_fw_runtime *fwrt,
 				 struct iwl_dump_ini_region_data *reg_data,
-				 void *range_ptr, u32 range_len, int idx)
+				 void *range_ptr, int idx)
 {
 	struct iwl_fw_ini_region_tlv *reg = (void *)reg_data->reg_tlv->data;
 	struct iwl_fw_ini_addr_size *pairs = (void *)reg->addrs;
@@ -227,7 +227,7 @@ iwl_dump_ini_prph_phy_block_iter(struct iwl_fw_runtime *fwrt,
 
 static int iwl_dump_ini_csr_iter(struct iwl_fw_runtime *fwrt,
 				 struct iwl_dump_ini_region_data *reg_data,
-				 void *range_ptr, u32 range_len, int idx)
+				 void *range_ptr, int idx)
 {
 	struct iwl_fw_ini_region_tlv *reg = (void *)reg_data->reg_tlv->data;
 	struct iwl_fw_ini_error_dump_range *range = range_ptr;
@@ -246,7 +246,7 @@ static int iwl_dump_ini_csr_iter(struct iwl_fw_runtime *fwrt,
 
 static int iwl_dump_ini_config_iter(struct iwl_fw_runtime *fwrt,
 				    struct iwl_dump_ini_region_data *reg_data,
-				    void *range_ptr, u32 range_len, int idx)
+				    void *range_ptr, int idx)
 {
 	struct iwl_trans *trans = fwrt->trans;
 	struct iwl_fw_ini_region_tlv *reg = (void *)reg_data->reg_tlv->data;
@@ -274,7 +274,7 @@ static int iwl_dump_ini_config_iter(struct iwl_fw_runtime *fwrt,
 
 static int iwl_dump_ini_dev_mem_iter(struct iwl_fw_runtime *fwrt,
 				     struct iwl_dump_ini_region_data *reg_data,
-				     void *range_ptr, u32 range_len, int idx)
+				     void *range_ptr, int idx)
 {
 	struct iwl_fw_ini_region_tlv *reg = (void *)reg_data->reg_tlv->data;
 	struct iwl_fw_ini_error_dump_range *range = range_ptr;
@@ -296,7 +296,7 @@ static int iwl_dump_ini_dev_mem_iter(struct iwl_fw_runtime *fwrt,
 }
 
 static int _iwl_dump_ini_paging_iter(struct iwl_fw_runtime *fwrt,
-				     void *range_ptr, u32 range_len, int idx)
+				     void *range_ptr, int idx)
 {
 	struct page *page = fwrt->fw_paging_db[idx].fw_paging_block;
 	struct iwl_fw_ini_error_dump_range *range = range_ptr;
@@ -316,7 +316,7 @@ static int _iwl_dump_ini_paging_iter(struct iwl_fw_runtime *fwrt,
 
 static int iwl_dump_ini_paging_iter(struct iwl_fw_runtime *fwrt,
 				    struct iwl_dump_ini_region_data *reg_data,
-				    void *range_ptr, u32 range_len, int idx)
+				    void *range_ptr, int idx)
 {
 	struct iwl_fw_ini_error_dump_range *range;
 	u32 page_size;
@@ -325,7 +325,7 @@ static int iwl_dump_ini_paging_iter(struct iwl_fw_runtime *fwrt,
 	idx++;
 
 	if (!fwrt->trans->mac_cfg->gen2)
-		return _iwl_dump_ini_paging_iter(fwrt, range_ptr, range_len, idx);
+		return _iwl_dump_ini_paging_iter(fwrt, range_ptr, idx);
 
 	range = range_ptr;
 	page_size = fwrt->trans->init_dram.paging[idx].size;
@@ -341,7 +341,7 @@ static int iwl_dump_ini_paging_iter(struct iwl_fw_runtime *fwrt,
 static int
 iwl_dump_ini_mon_dram_iter(struct iwl_fw_runtime *fwrt,
 			   struct iwl_dump_ini_region_data *reg_data,
-			   void *range_ptr, u32 range_len, int idx)
+			   void *range_ptr, int idx)
 {
 	struct iwl_fw_ini_region_tlv *reg = (void *)reg_data->reg_tlv->data;
 	struct iwl_fw_ini_error_dump_range *range = range_ptr;
@@ -360,7 +360,7 @@ iwl_dump_ini_mon_dram_iter(struct iwl_fw_runtime *fwrt,
 
 static int iwl_dump_ini_mon_smem_iter(struct iwl_fw_runtime *fwrt,
 				      struct iwl_dump_ini_region_data *reg_data,
-				      void *range_ptr, u32 range_len, int idx)
+				      void *range_ptr, int idx)
 {
 	struct iwl_fw_ini_region_tlv *reg = (void *)reg_data->reg_tlv->data;
 	struct iwl_fw_ini_error_dump_range *range = range_ptr;
@@ -428,7 +428,7 @@ static bool iwl_ini_txf_iter(struct iwl_fw_runtime *fwrt,
 
 static int iwl_dump_ini_txf_iter(struct iwl_fw_runtime *fwrt,
 				 struct iwl_dump_ini_region_data *reg_data,
-				 void *range_ptr, u32 range_len, int idx)
+				 void *range_ptr, int idx)
 {
 	struct iwl_fw_ini_region_tlv *reg = (void *)reg_data->reg_tlv->data;
 	struct iwl_fw_ini_error_dump_range *range = range_ptr;
@@ -497,7 +497,7 @@ static int iwl_dump_ini_txf_iter(struct iwl_fw_runtime *fwrt,
 static int
 iwl_dump_ini_prph_snps_dphyip_iter(struct iwl_fw_runtime *fwrt,
 				   struct iwl_dump_ini_region_data *reg_data,
-				   void *range_ptr, u32 range_len, int idx)
+				   void *range_ptr, int idx)
 {
 	struct iwl_fw_ini_region_tlv *reg = (void *)reg_data->reg_tlv->data;
 	struct iwl_fw_ini_error_dump_range *range = range_ptr;
@@ -610,7 +610,7 @@ static void iwl_ini_get_rxf_data(struct iwl_fw_runtime *fwrt,
 
 static int iwl_dump_ini_rxf_iter(struct iwl_fw_runtime *fwrt,
 				 struct iwl_dump_ini_region_data *reg_data,
-				 void *range_ptr, u32 range_len, int idx)
+				 void *range_ptr, int idx)
 {
 	struct iwl_fw_ini_region_tlv *reg = (void *)reg_data->reg_tlv->data;
 	struct iwl_fw_ini_error_dump_range *range = range_ptr;
@@ -676,7 +676,7 @@ static int iwl_dump_ini_rxf_iter(struct iwl_fw_runtime *fwrt,
 static int
 iwl_dump_ini_err_table_iter(struct iwl_fw_runtime *fwrt,
 			    struct iwl_dump_ini_region_data *reg_data,
-			    void *range_ptr, u32 range_len, int idx)
+			    void *range_ptr, int idx)
 {
 	struct iwl_fw_ini_region_tlv *reg = (void *)reg_data->reg_tlv->data;
 	struct iwl_fw_ini_region_err_table *err_table = &reg->err_table;
@@ -695,7 +695,7 @@ iwl_dump_ini_err_table_iter(struct iwl_fw_runtime *fwrt,
 static int
 iwl_dump_ini_special_mem_iter(struct iwl_fw_runtime *fwrt,
 			      struct iwl_dump_ini_region_data *reg_data,
-			      void *range_ptr, u32 range_len, int idx)
+			      void *range_ptr, int idx)
 {
 	struct iwl_fw_ini_region_tlv *reg = (void *)reg_data->reg_tlv->data;
 	struct iwl_fw_ini_region_special_device_memory *special_mem =
@@ -716,7 +716,7 @@ iwl_dump_ini_special_mem_iter(struct iwl_fw_runtime *fwrt,
 static int
 iwl_dump_ini_dbgi_sram_iter(struct iwl_fw_runtime *fwrt,
 			    struct iwl_dump_ini_region_data *reg_data,
-			    void *range_ptr, u32 range_len, int idx)
+			    void *range_ptr, int idx)
 {
 	struct iwl_fw_ini_region_tlv *reg = (void *)reg_data->reg_tlv->data;
 	struct iwl_fw_ini_error_dump_range *range = range_ptr;
@@ -746,7 +746,7 @@ iwl_dump_ini_dbgi_sram_iter(struct iwl_fw_runtime *fwrt,
 
 static int iwl_dump_ini_fw_pkt_iter(struct iwl_fw_runtime *fwrt,
 				    struct iwl_dump_ini_region_data *reg_data,
-				    void *range_ptr, u32 range_len, int idx)
+				    void *range_ptr, int idx)
 {
 	struct iwl_fw_ini_error_dump_range *range = range_ptr;
 	struct iwl_rx_packet *pkt = reg_data->dump_data->fw_pkt;
@@ -767,7 +767,7 @@ static int iwl_dump_ini_fw_pkt_iter(struct iwl_fw_runtime *fwrt,
 
 static int iwl_dump_ini_imr_iter(struct iwl_fw_runtime *fwrt,
 				 struct iwl_dump_ini_region_data *reg_data,
-				 void *range_ptr, u32 range_len, int idx)
+				 void *range_ptr, int idx)
 {
 	/* read the IMR memory and DMA it to SRAM */
 	struct iwl_fw_ini_error_dump_range *range = range_ptr;
@@ -1277,7 +1277,7 @@ struct iwl_dump_ini_mem_ops {
 			      void *data, u32 data_len);
 	int (*fill_range)(struct iwl_fw_runtime *fwrt,
 			  struct iwl_dump_ini_region_data *reg_data,
-			  void *range, u32 range_len, int idx);
+			  void *range, int idx);
 };
 
 struct iwl_fw_ini_dump_entry {
@@ -1413,8 +1413,7 @@ static u32 iwl_dump_ini_mem(struct iwl_fw_runtime *fwrt,
 	free_size -= header_size;
 
 	for (i = 0; i < le32_to_cpu(header->num_of_ranges); i++) {
-		int range_size = ops->fill_range(fwrt, reg_data, range,
-						 free_size, i);
+		int range_size = ops->fill_range(fwrt, reg_data, range, i);
 
 		if (range_size < 0) {
 			IWL_ERR(fwrt,
-- 
2.34.1


