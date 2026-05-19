Return-Path: <linux-wireless+bounces-36639-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EH1bJnkHDGodUAUAu9opvQ
	(envelope-from <linux-wireless+bounces-36639-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 08:47:21 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EE36857850C
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 08:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A76F430B5844
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 06:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6885739D6D4;
	Tue, 19 May 2026 06:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lTW7nF4o"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D641739DBF8
	for <linux-wireless@vger.kernel.org>; Tue, 19 May 2026 06:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779172844; cv=none; b=unc9uQ7jPNHUlSw9wSjDCY2VKqU4pqBUycoseqQZZPcXhe/B1BdJCJF8mq1PlQ0nGK1yU5xHLRisDwffTunq7kASzFBWZjcWF6NVLlKDkzOtd74gFOdqEgJc6BHyX7S8tUbuJBMS/ZutFKLA9p0dyreIz0y4TmFsdIWswgNj3kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779172844; c=relaxed/simple;
	bh=YITjsKLxZh7S+twiNJ9YnZmppZp6i4LnpOR1QrC4meM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FAkuJdQiiZ16HIwoFQCj1S3XKsR3DzbvVYS+SDM1jcYq0fABAHITZ6hDy+/l5hQobHRm61qBHfmsbUp4pzb4xW9qQvr5VI8kpZDBTCwa6yfl8Xmvd2IO65YR7pDKJ/IL9t7GD1XxLFay2gK3xcmYtTopaXpax7Yf5Vx1JbQnUIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lTW7nF4o; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779172843; x=1810708843;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YITjsKLxZh7S+twiNJ9YnZmppZp6i4LnpOR1QrC4meM=;
  b=lTW7nF4o0/vyBkpbAF8bE+Sm1qHroLhpRYo6PhqadBGlOn9zmvY5da5p
   jnMwtWjG7tMqg/ykCAPOCqKF8R5yjSCmAb1QiqWgLHMcb6Ss3iKitB4Cy
   W5d7f4lSzlQ7ueYv/L8C04pmQFOytm6Vo8WK42eeBfN78M/QmEYEA7+XQ
   nJzosQnRxZ97tECSS2dKCa2ARDAT1AHNilK24i+lbQGA0nhBea1sH5O0m
   l7C/ek9NZ9Q7xRnJEMVk07UI6qe/lSteTCxzyAPuwfizd3bLDdpJNDZr9
   f6/3d7h9Lyemuj1qT9A2D4zfKdcuekhw/B8Zm4eAPc5fu0+fBJB3MPiN2
   Q==;
X-CSE-ConnectionGUID: bfCOa78lSAqDjCOED/FfLg==
X-CSE-MsgGUID: juJ/+6ZPToOjFNzVrleshA==
X-IronPort-AV: E=McAfee;i="6800,10657,11790"; a="82605677"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="82605677"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 23:40:43 -0700
X-CSE-ConnectionGUID: UlGc+bWpT1KZit/o7kxvYg==
X-CSE-MsgGUID: cWlTe57mTva058+BHD4SKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="235227327"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 23:40:41 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v3 iwlwifi-next 14/15] wifi: iwlwifi: dbg: remove unused 'range_len' arg from dump
Date: Tue, 19 May 2026 09:40:09 +0300
Message-Id: <20260519064010.549003-15-miriam.rachel.korenblit@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260519064010.549003-1-miriam.rachel.korenblit@intel.com>
References: <20260519064010.549003-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-36639-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:mid,intel.com:dkim,msgid.link:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: EE36857850C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Johannes Berg <johannes.berg@intel.com>

None of the functions use this, and it's not really passed the
length of the specific range anyway, but rather the entire
remaining size. Remove the unused argument.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Link: https://patch.msgid.link/20260517100550.ea3502f97c2a.I4ce08f0ea7ea3bacd4928b427c0710b77259d002@changeid
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


