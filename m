Return-Path: <linux-wireless+bounces-22846-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD33AB29CA
	for <lists+linux-wireless@lfdr.de>; Sun, 11 May 2025 18:54:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14C331645E1
	for <lists+linux-wireless@lfdr.de>; Sun, 11 May 2025 16:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B0A325D8F4;
	Sun, 11 May 2025 16:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZGkaAkp7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB99F25A658
	for <linux-wireless@vger.kernel.org>; Sun, 11 May 2025 16:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746982426; cv=none; b=qRf72POL+flBmmUWS1w8uGqwdJPxATlBpbl/9RfproI4YXDZLJD5TXq53Ny8aRPiSf4p/AZiqZjYSuONgQivOJyfOBxOQAjHPtZKKJvMRY+7WKNaDqkPnEfm0Pb9aj53Cowp+HnQMaA93/hq3BMLIVrVjeL76mUl2bGHxIjo8jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746982426; c=relaxed/simple;
	bh=vYGiRzn8LaBAQku+MNzFq2WSF3wwT87C2yIikr+Seo0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GSUKlsua70XzgEzycKepHbcJYo1WXznTZqRYB3iOXi1bhi/n5uI76yb9VLYtpkdWBlSb1ozAbtlJWKQCAsIgu0TA3bedvmISfOauLnSwwr/xocl0gprKc+Q1dR5GE0M2EL5/UgDwhozC6eL9huZAKkjP/vyHsVbEJhlN3Z0jdkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZGkaAkp7; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746982425; x=1778518425;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vYGiRzn8LaBAQku+MNzFq2WSF3wwT87C2yIikr+Seo0=;
  b=ZGkaAkp7Zd+L/i4iVxmvQV8TGgGN/FZLWn5BmE1EhrNMzBcjB8N7Xidn
   FX3I0+fawnJjXmaBS/Zm/pxHhUrGFdyPAX+sume2nauasvYnqfvCPfQuj
   X+owfr/ExqQwnaTMr9SroYXrzQEg0m046Cwsphu25UQqitF5Uyrrc5RQ6
   tvlbZvNOkk/3UpSzJ0H/8baFy0fUTSFFbqNpPqXuCc4tqtiLSmE2V+7Cc
   dlgbIQzROvqSYppFlPaYti9eM4I2/mUcYRKMQEMNRtH9bookvlX+0T4Tx
   IGpShlUjZchyz29UB001bm0curhoWroxzVb27sWG7+F4qAtMD524ljjc9
   Q==;
X-CSE-ConnectionGUID: eqpDDj11QjK7ZVMSqitZfg==
X-CSE-MsgGUID: EEhKdfXQS4W4EZRLWSKCwA==
X-IronPort-AV: E=McAfee;i="6700,10204,11430"; a="52582690"
X-IronPort-AV: E=Sophos;i="6.15,280,1739865600"; 
   d="scan'208";a="52582690"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2025 09:53:45 -0700
X-CSE-ConnectionGUID: zqczujt9T12MNX5kRvCbHQ==
X-CSE-MsgGUID: 3R15OiONR4Sifu7RLJkxbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,280,1739865600"; 
   d="scan'208";a="137655058"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2025 09:53:44 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 07/15] wifi: iwlwifi: remove GEN3 from a couple of macros
Date: Sun, 11 May 2025 19:53:13 +0300
Message-Id: <20250511195137.b7fb5b854ded.Ib52b84c6e36e312b2eeb84a3cf71c6185fb52ee7@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250511165321.590808-1-miriam.rachel.korenblit@intel.com>
References: <20250511165321.590808-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

'GEN3' here really means 'AX210'. Rename.

Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-fh.h     | 8 ++++----
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c    | 4 ++--
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c | 4 ++--
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-fh.h b/drivers/net/wireless/intel/iwlwifi/iwl-fh.h
index c1c24f33e637..df4bb499446a 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-fh.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-fh.h
@@ -378,14 +378,14 @@ static inline unsigned int FH_MEM_CBBC_QUEUE(struct iwl_trans *trans,
  * Once the RXF-to-DRAM DMA is active, this flag is immediately turned off.
  */
 #define RFH_GEN_STATUS		0xA09808
-#define RFH_GEN_STATUS_GEN3	0xA07824
+#define RFH_GEN_STATUS_AX210	0xA07824
 #define RBD_FETCH_IDLE	BIT(29)
 #define SRAM_DMA_IDLE	BIT(30)
 #define RXF_DMA_IDLE	BIT(31)
 
 /* DMA configuration */
 #define RFH_RXF_DMA_CFG		0xA09820
-#define RFH_RXF_DMA_CFG_GEN3	0xA07880
+#define RFH_RXF_DMA_CFG_AX210	0xA07880
 /* RB size */
 #define RFH_RXF_DMA_RB_SIZE_MASK (0x000F0000) /* bits 16-19 */
 #define RFH_RXF_DMA_RB_SIZE_POS 16
@@ -593,8 +593,8 @@ struct iwl_rb_status {
 #define TFD_QUEUE_CB_SIZE(x)	(ilog2(x) - 3)
 #define TFD_QUEUE_SIZE_BC_DUP	(64)
 #define TFD_QUEUE_BC_SIZE	(TFD_QUEUE_SIZE_MAX + TFD_QUEUE_SIZE_BC_DUP)
-#define TFD_QUEUE_BC_SIZE_GEN3_AX210	1024
-#define TFD_QUEUE_BC_SIZE_GEN3_BZ	(1024 * 4)
+#define TFD_QUEUE_BC_SIZE_AX210	1024
+#define TFD_QUEUE_BC_SIZE_BZ	(1024 * 4)
 #define IWL_TX_DMA_MASK        DMA_BIT_MASK(36)
 #define IWL_NUM_OF_TBS		20
 #define IWL_TFH_NUM_TBS		25
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
index c5fdadf7de1f..72ee9ddc1b19 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
@@ -146,8 +146,8 @@ int iwl_pcie_rx_stop(struct iwl_trans *trans)
 {
 	if (trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_AX210) {
 		/* TODO: remove this once fw does it */
-		iwl_write_umac_prph(trans, RFH_RXF_DMA_CFG_GEN3, 0);
-		return iwl_poll_umac_prph_bit(trans, RFH_GEN_STATUS_GEN3,
+		iwl_write_umac_prph(trans, RFH_RXF_DMA_CFG_AX210, 0);
+		return iwl_poll_umac_prph_bit(trans, RFH_GEN_STATUS_AX210,
 					      RXF_DMA_IDLE, RXF_DMA_IDLE, 1000);
 	} else if (trans->mac_cfg->mq_rx_supported) {
 		iwl_write_prph(trans, RFH_RXF_DMA_CFG, 0);
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index bc4753ec4819..694e1ed1eae0 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -3834,10 +3834,10 @@ iwl_trans_pcie_alloc(struct pci_dev *pdev,
 
 	if (trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_BZ)
 		trans_pcie->txqs.bc_tbl_size =
-			sizeof(struct iwl_gen3_bc_tbl_entry) * TFD_QUEUE_BC_SIZE_GEN3_BZ;
+			sizeof(struct iwl_gen3_bc_tbl_entry) * TFD_QUEUE_BC_SIZE_BZ;
 	else if (trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_AX210)
 		trans_pcie->txqs.bc_tbl_size =
-			sizeof(struct iwl_gen3_bc_tbl_entry) * TFD_QUEUE_BC_SIZE_GEN3_AX210;
+			sizeof(struct iwl_gen3_bc_tbl_entry) * TFD_QUEUE_BC_SIZE_AX210;
 	else
 		trans_pcie->txqs.bc_tbl_size = sizeof(struct iwlagn_scd_bc_tbl);
 	/*
-- 
2.34.1


