Return-Path: <linux-wireless+bounces-26737-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED9BB396DF
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Aug 2025 10:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C95353B0E0F
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Aug 2025 08:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 960472E8882;
	Thu, 28 Aug 2025 08:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BOPXYP3O"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2AD2E22AC
	for <linux-wireless@vger.kernel.org>; Thu, 28 Aug 2025 08:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756369608; cv=none; b=hdUCF79SaVkQ03VDGZ8ZYtB3/rXud/G5E05YTqCniZuUXQwBrlma0khNP/D1tJBzrBb35ANvUMoElhLOGPpGt226gGnfWuAKBCmja4IG9GpRwvGweF9gD+Smmno4BC9P8b2NxHtCXOcol68gIJJAzD0Arc9lSah5Q4v83VsbA4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756369608; c=relaxed/simple;
	bh=IJ3Rs60ZR0xMUpBnkDrRE2hLVtiawDiK8u7xPPP4OpI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nxd3gZfm4ghVQ62slaivw6D+W8ecGVeblsPUPKEhb14530Xl3pr2IY0jXxwKtZ5DaA1WDlLrewniQmFLq9oz2HTRb/+vWe9Z8VbcshQU/M8rjqebCEO9TINEcd21mDesr+NBbLXzoLTMPVvuBdwEgQQQeu5BjeWT11WGKeQAorU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BOPXYP3O; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756369607; x=1787905607;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IJ3Rs60ZR0xMUpBnkDrRE2hLVtiawDiK8u7xPPP4OpI=;
  b=BOPXYP3ODPvpwIC6wYJZmqyTKKsg0kgrPsvwzk5FzKe5dfZ9WA65XtPd
   uCcOgmyhLmLIEq94Oi7kxt+jGd6NStfZLDiZiR/bvXhGoswAC6xjwVSF2
   qDyiZ8xLEiB+FFBc0V3+whwh5KcuXY0KG/Npc4IU5efRzdL6fChKfrH9s
   9JIqqSa1FGQW/34WYzJE+45AgFsLWuo6YceHscLeWP2mhonME2VYIeeXU
   uEvzM0wKUYNWFTROl52oj3g+tjiMoKpUdyNwE2522sc+7k6DF5wk1bkze
   TeABkYj4hu1HAosowkhAGIeQVwEDpJGfELVQl9XBpjJjTjNpskJDNeHCS
   g==;
X-CSE-ConnectionGUID: gl+L1i76QTixBKee7NLsPA==
X-CSE-MsgGUID: gvgWKrUkQV2W6bf7398erw==
X-IronPort-AV: E=McAfee;i="6800,10657,11535"; a="70003330"
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="70003330"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 01:26:37 -0700
X-CSE-ConnectionGUID: mH+QaWkOQg+iEPfY1FYYag==
X-CSE-MsgGUID: VJZZ5tkbSjKoQMoVTy7Wag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="170224492"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 01:26:36 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH iwlwifi-next 04/15] wifi: iwlwifi: trans: move dev_cmd_pool to trans specific
Date: Thu, 28 Aug 2025 11:25:50 +0300
Message-Id: <20250828111032.faf685de7aa2.I83e31e36d3159aa5c7e6f82a773d9981d3aac70d@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250828082601.537908-1-miriam.rachel.korenblit@intel.com>
References: <20250828082601.537908-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

This pool has different parameters for different devices,
move it to the generation specific transport sub-layer.

Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/iwl-trans.c    | 27 ++++-----
 .../net/wireless/intel/iwlwifi/iwl-trans.h    | 24 ++------
 .../intel/iwlwifi/pcie/gen1_2/internal.h      | 23 ++++++++
 .../intel/iwlwifi/pcie/gen1_2/trans.c         | 57 ++++++++++++-------
 4 files changed, 76 insertions(+), 55 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
index a19ffff2fffb..485e00d6158c 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
@@ -268,9 +268,7 @@ static void iwl_trans_restart_wk(struct work_struct *wk)
 
 struct iwl_trans *iwl_trans_alloc(unsigned int priv_size,
 				  struct device *dev,
-				  const struct iwl_mac_cfg *mac_cfg,
-				  unsigned int txcmd_size,
-				  unsigned int txcmd_align)
+				  const struct iwl_mac_cfg *mac_cfg)
 {
 	struct iwl_trans *trans;
 #ifdef CONFIG_LOCKDEP
@@ -292,22 +290,12 @@ struct iwl_trans *iwl_trans_alloc(unsigned int priv_size,
 
 	INIT_DELAYED_WORK(&trans->restart.wk, iwl_trans_restart_wk);
 
-	snprintf(trans->dev_cmd_pool_name, sizeof(trans->dev_cmd_pool_name),
-		 "iwl_cmd_pool:%s", dev_name(trans->dev));
-	trans->dev_cmd_pool =
-		kmem_cache_create(trans->dev_cmd_pool_name,
-				  txcmd_size, txcmd_align,
-				  SLAB_HWCACHE_ALIGN, NULL);
-	if (!trans->dev_cmd_pool)
-		return NULL;
-
 	return trans;
 }
 
 void iwl_trans_free(struct iwl_trans *trans)
 {
 	cancel_delayed_work_sync(&trans->restart.wk);
-	kmem_cache_destroy(trans->dev_cmd_pool);
 }
 
 int iwl_trans_send_cmd(struct iwl_trans *trans, struct iwl_host_cmd *cmd)
@@ -345,6 +333,19 @@ int iwl_trans_send_cmd(struct iwl_trans *trans, struct iwl_host_cmd *cmd)
 }
 IWL_EXPORT_SYMBOL(iwl_trans_send_cmd);
 
+struct iwl_device_tx_cmd *iwl_trans_alloc_tx_cmd(struct iwl_trans *trans)
+{
+	return iwl_pcie_gen1_2_alloc_tx_cmd(trans);
+}
+IWL_EXPORT_SYMBOL(iwl_trans_alloc_tx_cmd);
+
+void iwl_trans_free_tx_cmd(struct iwl_trans *trans,
+			   struct iwl_device_tx_cmd *dev_cmd)
+{
+	iwl_pcie_gen1_2_free_tx_cmd(trans, dev_cmd);
+}
+IWL_EXPORT_SYMBOL(iwl_trans_free_tx_cmd);
+
 /* Comparator for struct iwl_hcmd_names.
  * Used in the binary search over a list of host commands.
  *
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index b0bf88a889b4..277fd4131999 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -854,9 +854,6 @@ struct iwl_trans_info {
  * @fail_to_parse_pnvm_image: set to true if pnvm parsing failed
  * @reduce_power_loaded: indicates reduced power section was loaded
  * @failed_to_load_reduce_power_image: set to true if pnvm loading failed
- * @dev_cmd_pool: pool for Tx cmd allocation - for internal use only.
- *	The user should use iwl_trans_{alloc,free}_tx_cmd.
- * @dev_cmd_pool_name: name for the TX command allocation pool
  * @dbgfs_dir: iwlwifi debugfs base dir for this device
  * @sync_cmd_lockdep_map: lockdep map for checking sync commands
  * @dbg: additional debug data, see &struct iwl_trans_debug
@@ -896,10 +893,6 @@ struct iwl_trans {
 	u8 reduce_power_loaded:1;
 	u8 failed_to_load_reduce_power_image:1;
 
-	/* The following fields are internal only */
-	struct kmem_cache *dev_cmd_pool;
-	char dev_cmd_pool_name[50];
-
 	struct dentry *dbgfs_dir;
 
 #ifdef CONFIG_LOCKDEP
@@ -948,19 +941,12 @@ iwl_trans_dump_data(struct iwl_trans *trans, u32 dump_mask,
 		    const struct iwl_dump_sanitize_ops *sanitize_ops,
 		    void *sanitize_ctx);
 
-static inline struct iwl_device_tx_cmd *
-iwl_trans_alloc_tx_cmd(struct iwl_trans *trans)
-{
-	return kmem_cache_zalloc(trans->dev_cmd_pool, GFP_ATOMIC);
-}
+struct iwl_device_tx_cmd *iwl_trans_alloc_tx_cmd(struct iwl_trans *trans);
 
 int iwl_trans_send_cmd(struct iwl_trans *trans, struct iwl_host_cmd *cmd);
 
-static inline void iwl_trans_free_tx_cmd(struct iwl_trans *trans,
-					 struct iwl_device_tx_cmd *dev_cmd)
-{
-	kmem_cache_free(trans->dev_cmd_pool, dev_cmd);
-}
+void iwl_trans_free_tx_cmd(struct iwl_trans *trans,
+			   struct iwl_device_tx_cmd *dev_cmd);
 
 int iwl_trans_tx(struct iwl_trans *trans, struct sk_buff *skb,
 		 struct iwl_device_tx_cmd *dev_cmd, int queue);
@@ -1187,9 +1173,7 @@ static inline void iwl_trans_finish_sw_reset(struct iwl_trans *trans)
  *****************************************************/
 struct iwl_trans *iwl_trans_alloc(unsigned int priv_size,
 				  struct device *dev,
-				  const struct iwl_mac_cfg *mac_cfg,
-				  unsigned int txcmd_size,
-				  unsigned int txcmd_align);
+				  const struct iwl_mac_cfg *mac_cfg);
 void iwl_trans_free(struct iwl_trans *trans);
 
 static inline bool iwl_trans_is_hw_error_value(u32 val)
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/internal.h b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/internal.h
index 54b978830043..b5ff7a6da325 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/internal.h
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/internal.h
@@ -400,6 +400,9 @@ struct iwl_pcie_txqs {
  * @me_recheck_wk: worker to recheck WiAMT/CSME presence
  * @invalid_tx_cmd: invalid TX command buffer
  * @wait_command_queue: wait queue for sync commands
+ * @dev_cmd_pool: pool for Tx cmd allocation - for internal use only.
+ *	The user should use iwl_trans_{alloc,free}_tx_cmd.
+ * @dev_cmd_pool_name: name for the TX command allocation pool
  */
 struct iwl_trans_pcie {
 	struct iwl_rxq *rxq;
@@ -506,6 +509,9 @@ struct iwl_trans_pcie {
 	struct iwl_dma_ptr invalid_tx_cmd;
 
 	wait_queue_head_t wait_command_queue;
+
+	struct kmem_cache *dev_cmd_pool;
+	char dev_cmd_pool_name[50];
 };
 
 static inline struct iwl_trans_pcie *
@@ -783,6 +789,23 @@ static inline u16 iwl_txq_gen1_tfd_tb_get_len(struct iwl_trans *trans,
 	return le16_to_cpu(tb->hi_n_len) >> 4;
 }
 
+static inline struct iwl_device_tx_cmd *
+iwl_pcie_gen1_2_alloc_tx_cmd(struct iwl_trans *trans)
+{
+	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
+
+	return kmem_cache_zalloc(trans_pcie->dev_cmd_pool, GFP_ATOMIC);
+}
+
+static inline void
+iwl_pcie_gen1_2_free_tx_cmd(struct iwl_trans *trans,
+			    struct iwl_device_tx_cmd *dev_cmd)
+{
+	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
+
+	kmem_cache_free(trans_pcie->dev_cmd_pool, dev_cmd);
+}
+
 void iwl_pcie_reclaim(struct iwl_trans *trans, int txq_id, int ssn,
 		      struct sk_buff_head *skbs, bool is_flush);
 void iwl_pcie_set_q_ptrs(struct iwl_trans *trans, int txq_id, int ptr);
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
index 0946ea223e46..7aa9683624f0 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
@@ -2023,6 +2023,7 @@ void iwl_trans_pcie_free(struct iwl_trans *trans)
 		free_percpu(trans_pcie->txqs.tso_hdr_page);
 	}
 
+	kmem_cache_destroy(trans_pcie->dev_cmd_pool);
 	iwl_trans_free(trans);
 }
 
@@ -3707,28 +3708,40 @@ void iwl_trans_pcie_sync_nmi(struct iwl_trans *trans)
 	iwl_trans_sync_nmi_with_addr(trans, inta_addr, sw_err_bit);
 }
 
-static int iwl_trans_pcie_set_txcmd_info(const struct iwl_mac_cfg *mac_cfg,
-					 unsigned int *txcmd_size,
-					 unsigned int *txcmd_align)
+static int iwl_trans_pcie_alloc_txcmd_pool(struct iwl_trans *trans)
 {
-	if (!mac_cfg->gen2) {
-		*txcmd_size = sizeof(struct iwl_tx_cmd_v6);
-		*txcmd_align = sizeof(void *);
-	} else if (mac_cfg->device_family < IWL_DEVICE_FAMILY_AX210) {
-		*txcmd_size = sizeof(struct iwl_tx_cmd_v9);
-		*txcmd_align = 64;
+	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
+	unsigned int txcmd_size, txcmd_align;
+
+	if (!trans->mac_cfg->gen2) {
+		txcmd_size = sizeof(struct iwl_tx_cmd_v6);
+		txcmd_align = sizeof(void *);
+	} else if (trans->mac_cfg->device_family < IWL_DEVICE_FAMILY_AX210) {
+		txcmd_size = sizeof(struct iwl_tx_cmd_v9);
+		txcmd_align = 64;
 	} else {
-		*txcmd_size = sizeof(struct iwl_tx_cmd);
-		*txcmd_align = 128;
+		txcmd_size = sizeof(struct iwl_tx_cmd);
+		txcmd_align = 128;
 	}
 
-	*txcmd_size += sizeof(struct iwl_cmd_header);
-	*txcmd_size += 36; /* biggest possible 802.11 header */
+	txcmd_size += sizeof(struct iwl_cmd_header);
+	txcmd_size += 36; /* biggest possible 802.11 header */
 
 	/* Ensure device TX cmd cannot reach/cross a page boundary in gen2 */
-	if (WARN_ON((mac_cfg->gen2 && *txcmd_size >= *txcmd_align)))
+	if (WARN_ON((trans->mac_cfg->gen2 && txcmd_size >= txcmd_align)))
 		return -EINVAL;
 
+	snprintf(trans_pcie->dev_cmd_pool_name,
+		 sizeof(trans_pcie->dev_cmd_pool_name),
+		 "iwl_cmd_pool:%s", dev_name(trans->dev));
+
+	trans_pcie->dev_cmd_pool =
+		kmem_cache_create(trans_pcie->dev_cmd_pool_name,
+				  txcmd_size, txcmd_align,
+				  SLAB_HWCACHE_ALIGN, NULL);
+	if (!trans_pcie->dev_cmd_pool)
+		return -ENOMEM;
+
 	return 0;
 }
 
@@ -3738,18 +3751,12 @@ iwl_trans_pcie_alloc(struct pci_dev *pdev,
 		     struct iwl_trans_info *info, u8 __iomem *hw_base)
 {
 	struct iwl_trans_pcie *trans_pcie, **priv;
-	unsigned int txcmd_size, txcmd_align;
 	struct iwl_trans *trans;
 	unsigned int bc_tbl_n_entries;
 	int ret, addr_size;
 
-	ret = iwl_trans_pcie_set_txcmd_info(mac_cfg, &txcmd_size,
-					    &txcmd_align);
-	if (ret)
-		return ERR_PTR(ret);
-
 	trans = iwl_trans_alloc(sizeof(struct iwl_trans_pcie), &pdev->dev,
-				mac_cfg, txcmd_size, txcmd_align);
+				mac_cfg);
 	if (!trans)
 		return ERR_PTR(-ENOMEM);
 
@@ -3760,6 +3767,10 @@ iwl_trans_pcie_alloc(struct pci_dev *pdev,
 	/* Initialize the wait queue for commands */
 	init_waitqueue_head(&trans_pcie->wait_command_queue);
 
+	ret = iwl_trans_pcie_alloc_txcmd_pool(trans);
+	if (ret)
+		goto out_free_trans;
+
 	if (trans->mac_cfg->gen2) {
 		trans_pcie->txqs.tfd.addr_size = 64;
 		trans_pcie->txqs.tfd.max_tbs = IWL_TFH_NUM_TBS;
@@ -3779,7 +3790,7 @@ iwl_trans_pcie_alloc(struct pci_dev *pdev,
 	trans_pcie->txqs.tso_hdr_page = alloc_percpu(struct iwl_tso_hdr_page);
 	if (!trans_pcie->txqs.tso_hdr_page) {
 		ret = -ENOMEM;
-		goto out_free_trans;
+		goto out_free_txcmd_pool;
 	}
 
 	if (trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_BZ)
@@ -3929,6 +3940,8 @@ iwl_trans_pcie_alloc(struct pci_dev *pdev,
 	free_netdev(trans_pcie->napi_dev);
 out_free_tso:
 	free_percpu(trans_pcie->txqs.tso_hdr_page);
+out_free_txcmd_pool:
+	kmem_cache_destroy(trans_pcie->dev_cmd_pool);
 out_free_trans:
 	iwl_trans_free(trans);
 	return ERR_PTR(ret);
-- 
2.34.1


