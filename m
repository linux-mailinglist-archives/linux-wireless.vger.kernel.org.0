Return-Path: <linux-wireless+bounces-25061-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE171AFDF21
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 07:17:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 658F14E0B43
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 05:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9CE826B09F;
	Wed,  9 Jul 2025 05:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kz33NPse"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E9326B2A5
	for <linux-wireless@vger.kernel.org>; Wed,  9 Jul 2025 05:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752038226; cv=none; b=qeIEi09FHM8lOs6UQp28cgaTFvsF/a/AFZ2SNzQ+9Hi6pF0c4CjI0+el5Q63hqCMGrBB3mcBTp7kTS2rPiLDBEi099GYfFmake13DtFZKadCpS3Nldra2GR7RfHuT1DVcHGvkvYmvVM6R6v7jCNQbebfQXyPtRfniItDOhJadjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752038226; c=relaxed/simple;
	bh=0O+/L2RehWpsb2o3yyjgvJkitWoxAX/PLapmiBlB8HY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XTNIjsn5tdgBQGZRR9lVyUAcXJ9gMVvZPQZNUvuxJkl5dgpoZBVV4P7POCVQbZsMmOOU7StaokSpEa1XOf9bZLAgeab4BY/dru3NGYwFe5NcLDQiGlGxp0vENYL64zl5lxgAbglg+T83cTx0BV4qDkLch9GlZMQ9booO2t0QVEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kz33NPse; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752038225; x=1783574225;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0O+/L2RehWpsb2o3yyjgvJkitWoxAX/PLapmiBlB8HY=;
  b=kz33NPsezEq8a66R+8LWAtSSiNYK4m2E7ZYgrXlkgfHg8wNvqmdwaxb6
   DFXE6lFFomtiyjIXt8fqlYn7mKr54+lt9K++t3ZDPBlnYY5MawW/r6VtI
   bI4DJ+OmldEk19aTui2sa5PPbioLNJzyvchSQbwAIx8x1CNOybjfz9oPv
   +eoFv4SXemLIRJb6rwbNDRpbi0KBYNucKyMvOIm/IIgcFxbq1Zqe6pnh1
   7cxkXY5bsKyvR7jeVN2QbHpHKmBbMS5KN/AENs+to33REWSmyqurAZm2d
   jZswPxESGZydnVPvvJnjLYXeTbo19UCef7I7P5ZzO+Yelcw3onZNYL/II
   A==;
X-CSE-ConnectionGUID: gMyzJGmoTsmntkOTtLD90w==
X-CSE-MsgGUID: uRIEwIc1RLOu8Plbm6Yy0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="58091173"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="58091173"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 22:17:05 -0700
X-CSE-ConnectionGUID: eZQAaSImST2nMAhyKmDQdw==
X-CSE-MsgGUID: KbUbp3AqQ3W/GMyBnJlxdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="161327872"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 22:17:03 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next v3 07/15] wifi: iwlwifi: trans: remove iwl_trans_init
Date: Wed,  9 Jul 2025 08:16:26 +0300
Message-Id: <20250709081300.9602fde079de.Iaede14c91095560852f9b441f1e16546b0a06bdd@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250709051634.866992-1-miriam.rachel.korenblit@intel.com>
References: <20250709051634.866992-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

We needed it for setting up trans parameters that could change later in
the probe flow.
This is no longer true, now we know all the parameters before we allocate the
trans, so we can just send the right parameters to iwl_trans_alloc and have all
initializations done there.

Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>

 .../net/wireless/intel/iwlwifi/iwl-trans.c    | 25 ++--------
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |  8 +--
 .../intel/iwlwifi/pcie/gen1_2/trans.c         | 50 ++++++++++++-------
 3 files changed, 41 insertions(+), 42 deletions(-)

---
v2: fixed a typo
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
index 6288779ff8ec..9604781dd0b7 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
@@ -268,7 +268,9 @@ static void iwl_trans_restart_wk(struct work_struct *wk)
 
 struct iwl_trans *iwl_trans_alloc(unsigned int priv_size,
 				  struct device *dev,
-				  const struct iwl_mac_cfg *mac_cfg)
+				  const struct iwl_mac_cfg *mac_cfg,
+				  unsigned int txcmd_size,
+				  unsigned int txcmd_align)
 {
 	struct iwl_trans *trans;
 #ifdef CONFIG_LOCKDEP
@@ -290,23 +292,6 @@ struct iwl_trans *iwl_trans_alloc(unsigned int priv_size,
 
 	INIT_DELAYED_WORK(&trans->restart.wk, iwl_trans_restart_wk);
 
-	return trans;
-}
-
-int iwl_trans_init(struct iwl_trans *trans, unsigned int txcmd_size,
-		   unsigned int txcmd_align)
-{
-	/* check if name/num_rx_queues were set as a proxy for info being set */
-	if (WARN_ON(!trans->info.name || !trans->info.num_rxqs))
-		return -EINVAL;
-
-	txcmd_size += sizeof(struct iwl_cmd_header);
-	txcmd_size += 36; /* biggest possible 802.11 header */
-
-	/* Ensure device TX cmd cannot reach/cross a page boundary in gen2 */
-	if (WARN_ON(trans->mac_cfg->gen2 && txcmd_size >= txcmd_align))
-		return -EINVAL;
-
 	snprintf(trans->dev_cmd_pool_name, sizeof(trans->dev_cmd_pool_name),
 		 "iwl_cmd_pool:%s", dev_name(trans->dev));
 	trans->dev_cmd_pool =
@@ -314,9 +299,9 @@ int iwl_trans_init(struct iwl_trans *trans, unsigned int txcmd_size,
 				  txcmd_size, txcmd_align,
 				  SLAB_HWCACHE_ALIGN, NULL);
 	if (!trans->dev_cmd_pool)
-		return -ENOMEM;
+		return NULL;
 
-	return 0;
+	return trans;
 }
 
 void iwl_trans_free(struct iwl_trans *trans)
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index 49a695e30109..103a36d8ee30 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -1204,10 +1204,10 @@ static inline void iwl_trans_finish_sw_reset(struct iwl_trans *trans)
  * transport helper functions
  *****************************************************/
 struct iwl_trans *iwl_trans_alloc(unsigned int priv_size,
-			  struct device *dev,
-			  const struct iwl_mac_cfg *cfg_trans);
-int iwl_trans_init(struct iwl_trans *trans, unsigned int txcmd_size,
-		   unsigned int txcmd_align);
+				  struct device *dev,
+				  const struct iwl_mac_cfg *mac_cfg,
+				  unsigned int txcmd_size,
+				  unsigned int txcmd_align);
 void iwl_trans_free(struct iwl_trans *trans);
 
 static inline bool iwl_trans_is_hw_error_value(u32 val)
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
index 3f1861efc716..ea482796c61b 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
@@ -3684,18 +3684,49 @@ void iwl_trans_pcie_sync_nmi(struct iwl_trans *trans)
 	iwl_trans_sync_nmi_with_addr(trans, inta_addr, sw_err_bit);
 }
 
+static int iwl_trans_pcie_set_txcmd_info(const struct iwl_mac_cfg *mac_cfg,
+					unsigned int *txcmd_size,
+					unsigned int *txcmd_align)
+{
+	if (!mac_cfg->gen2) {
+		*txcmd_size = sizeof(struct iwl_tx_cmd_v6);
+		*txcmd_align = sizeof(void *);
+	} else if (mac_cfg->device_family < IWL_DEVICE_FAMILY_AX210) {
+		*txcmd_size = sizeof(struct iwl_tx_cmd_v9);
+		*txcmd_align = 64;
+	} else {
+		*txcmd_size = sizeof(struct iwl_tx_cmd);
+		*txcmd_align = 128;
+	}
+
+	*txcmd_size += sizeof(struct iwl_cmd_header);
+	*txcmd_size += 36; /* biggest possible 802.11 header */
+
+	/* Ensure device TX cmd cannot reach/cross a page boundary in gen2 */
+	if (WARN_ON((mac_cfg->gen2 && *txcmd_size >= *txcmd_align)))
+		return -EINVAL;
+
+	return 0;
+}
+
 static struct iwl_trans *
 iwl_trans_pcie_alloc(struct pci_dev *pdev,
 		     const struct iwl_mac_cfg *mac_cfg,
 		     struct iwl_trans_info *info, u8 __iomem *hw_base)
 {
 	struct iwl_trans_pcie *trans_pcie, **priv;
+	unsigned int txcmd_size, txcmd_align;
 	struct iwl_trans *trans;
 	unsigned int bc_tbl_n_entries;
 	int ret, addr_size;
 
+	ret = iwl_trans_pcie_set_txcmd_info(mac_cfg, &txcmd_size,
+					    &txcmd_align);
+	if (ret)
+		return ERR_PTR(ret);
+
 	trans = iwl_trans_alloc(sizeof(struct iwl_trans_pcie), &pdev->dev,
-				mac_cfg);
+				mac_cfg, txcmd_size, txcmd_align);
 	if (!trans)
 		return ERR_PTR(-ENOMEM);
 
@@ -4109,7 +4140,6 @@ int iwl_pci_gen1_2_probe(struct pci_dev *pdev,
 	};
 	struct iwl_trans *iwl_trans;
 	struct iwl_trans_pcie *trans_pcie;
-	unsigned int txcmd_size, txcmd_align;
 	int ret;
 
 	iwl_trans = iwl_trans_pcie_alloc(pdev, trans, &info, hw_base);
@@ -4218,22 +4248,6 @@ int iwl_pci_gen1_2_probe(struct pci_dev *pdev,
 
 	iwl_trans_set_info(iwl_trans, &info);
 
-	if (!iwl_trans->mac_cfg->gen2) {
-		txcmd_size = sizeof(struct iwl_tx_cmd_v6);
-		txcmd_align = sizeof(void *);
-	} else if (iwl_trans->mac_cfg->device_family <
-		   IWL_DEVICE_FAMILY_AX210) {
-		txcmd_size = sizeof(struct iwl_tx_cmd_v9);
-		txcmd_align = 64;
-	} else {
-		txcmd_size = sizeof(struct iwl_tx_cmd);
-		txcmd_align = 128;
-	}
-	ret = iwl_trans_init(iwl_trans, txcmd_size, txcmd_align);
-
-	if (ret)
-		goto out_free_trans;
-
 	pci_set_drvdata(pdev, iwl_trans);
 
 	iwl_pcie_check_me_status(iwl_trans);
-- 
2.34.1


