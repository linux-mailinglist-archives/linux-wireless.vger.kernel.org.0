Return-Path: <linux-wireless+bounces-8542-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 286B88FC9AF
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Jun 2024 13:06:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA302282ABF
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Jun 2024 11:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB3C81922ED;
	Wed,  5 Jun 2024 11:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FvE/tHIp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D131922EC
	for <linux-wireless@vger.kernel.org>; Wed,  5 Jun 2024 11:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717585530; cv=none; b=DjV558vBhtolbIcysmrzzt7bADQa4EaLJgFiTxo9vGCrFsSmLy3gwYUT12uaXejhCqjzMC8AudxSupKckNErS8larXQz1fRIseZ9NdXG9FijUK+weegAJyXBiRa83UWbqEHuFTClRCp4rFU8O3EIBDhiF3FhyjqsyfZ8lkDiiFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717585530; c=relaxed/simple;
	bh=b1dT0mT3AHV4vmExhLblZ961+cBKUCtjFgttfXLQEUk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lrR4PjnMswOhBy3xR/L9GCWKXQTB3HjscilCwI7XnPMEKp4MYzNpa409TpjkTbwweOtpLX1zTtb6PIKD8N3ZOiikhnPXzYEWhWtftm6VLMT8e6Rnm7EXgUQD525hiTYCtAAcmUyBEp2yw5PNueTpQAWtpYykbVW7BLKP+Jrtcds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FvE/tHIp; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717585527; x=1749121527;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=b1dT0mT3AHV4vmExhLblZ961+cBKUCtjFgttfXLQEUk=;
  b=FvE/tHIpng0zi9ZkpCOxFs/nNIclupTtikNFO9lf4DJTzlkbwPcT3Idn
   eqFXT2Ch4TaAGiqp5tUPk+9XrdvLS2Amvlv81x71BPBu4bpACgTN+hxCs
   uzv5MVdqejHB96xI8mgGepxjLoUfxqDMFUqKY/lzuzAInkfDpya+OLfdi
   8r9BbrHawqtMZKV7OZ7W/AjddE0FMDoHgGA2PKL2kDR7BbCp1LJn4V6mI
   cdqr1CTGpMOhgNSt53zWt70xhY8u/PxNfmDnNrgUIctUb2qb0qiBRBVaL
   GifzA/IRcbffPce/JbAJXMA2QL1xyoKak5oiwe1CvYZadJJtb0jnuROpB
   g==;
X-CSE-ConnectionGUID: u3/ft+QAQIiQZ/DKWdPQRw==
X-CSE-MsgGUID: BD4Spt45Tc+hsj1Bn0PHCw==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="14402191"
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; 
   d="scan'208";a="14402191"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 04:05:25 -0700
X-CSE-ConnectionGUID: jMH3bQd6TMS1Et6MY5xKtg==
X-CSE-MsgGUID: wf5QphFMScy3noMRD7O0NQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; 
   d="scan'208";a="41997390"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 04:05:24 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Yedidya Benshimol <yedidya.ben.shimol@intel.com>
Subject: [PATCH 07/11] wifi: iwlwifi: remove struct iwl_trans_ops
Date: Wed,  5 Jun 2024 14:05:03 +0300
Message-Id: <20240605140327.8315ff64f9f3.Ifdbc1f26d49766f7de553dcb5f613885f4ee65cc@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240605110507.2044059-1-miriam.rachel.korenblit@intel.com>
References: <20240605110507.2044059-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Yedidya Benshimol <yedidya.ben.shimol@intel.com>

This was needed when we had multiple types of transports. Now we only
have pcie, so there is no need for this ops.
Cleanup the code such as the different trans APIs will call the pcie
function directly, instead of calling the callback,
and remove struct iwl_trans_ops.

Signed-off-by: Yedidya Benshimol <yedidya.ben.shimol@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/dvm/mac80211.c |   6 +-
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   |   6 +-
 .../net/wireless/intel/iwlwifi/iwl-dbg-tlv.c  |   6 -
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c  |   2 +-
 .../net/wireless/intel/iwlwifi/iwl-trans.c    | 391 +++++++++++-
 .../net/wireless/intel/iwlwifi/iwl-trans.h    | 566 +++---------------
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |   2 -
 .../wireless/intel/iwlwifi/pcie/internal.h    |  43 ++
 .../net/wireless/intel/iwlwifi/pcie/trans.c   | 167 ++----
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c  |  12 +-
 10 files changed, 552 insertions(+), 649 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/dvm/mac80211.c
index 52b008ce53bd..826f129ecefa 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/mac80211.c
@@ -2,7 +2,7 @@
 /******************************************************************************
  *
  * Copyright(c) 2003 - 2014 Intel Corporation. All rights reserved.
- * Copyright(C) 2018 - 2019, 2022 - 2023 Intel Corporation
+ * Copyright(C) 2018 - 2019, 2022 - 2024 Intel Corporation
  *
  * Portions of this file are derived from the ipw3945 project, as well
  * as portions of the ieee80211 subsystem header files.
@@ -145,8 +145,6 @@ int iwlagn_mac_setup_register(struct iwl_priv *priv,
 
 #ifdef CONFIG_PM_SLEEP
 	if (priv->fw->img[IWL_UCODE_WOWLAN].num_sec &&
-	    priv->trans->ops->d3_suspend &&
-	    priv->trans->ops->d3_resume &&
 	    device_can_wakeup(priv->trans->dev)) {
 		priv->wowlan_support.flags = WIPHY_WOWLAN_MAGIC_PKT |
 					     WIPHY_WOWLAN_DISCONNECT |
@@ -730,8 +728,6 @@ static int iwlagn_mac_ampdu_action(struct ieee80211_hw *hw,
 		ret = iwl_sta_rx_agg_stop(priv, sta, tid);
 		break;
 	case IEEE80211_AMPDU_TX_START:
-		if (!priv->trans->ops->txq_enable)
-			break;
 		if (!iwl_enable_tx_ampdu())
 			break;
 		IWL_DEBUG_HT(priv, "start Tx\n");
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index 945ffc083d25..fa57df336785 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -1168,17 +1168,13 @@ static int iwl_dump_ini_config_iter(struct iwl_fw_runtime *fwrt,
 		   le32_to_cpu(reg->dev_addr.offset);
 	int i;
 
-	/* we shouldn't get here if the trans doesn't have read_config32 */
-	if (WARN_ON_ONCE(!trans->ops->read_config32))
-		return -EOPNOTSUPP;
-
 	range->internal_base_addr = cpu_to_le32(addr);
 	range->range_data_size = reg->dev_addr.size;
 	for (i = 0; i < le32_to_cpu(reg->dev_addr.size); i += 4) {
 		int ret;
 		u32 tmp;
 
-		ret = trans->ops->read_config32(trans, addr + i, &tmp);
+		ret = iwl_trans_read_config32(trans, addr + i, &tmp);
 		if (ret < 0)
 			return ret;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
index 561d0c261123..9810a7f4a591 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
@@ -223,12 +223,6 @@ static int iwl_dbg_tlv_alloc_region(struct iwl_trans *trans,
 		return -EINVAL;
 	}
 
-	if (type == IWL_FW_INI_REGION_PCI_IOSF_CONFIG &&
-	    !trans->ops->read_config32) {
-		IWL_ERR(trans, "WRT: Unsupported region type %u\n", type);
-		return -EOPNOTSUPP;
-	}
-
 	if (type == IWL_FW_INI_REGION_INTERNAL_BUFFER) {
 		trans->dbg.imr_data.sram_addr =
 			le32_to_cpu(reg->internal_buffer.base_addr);
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
index a392a5f1847f..08e3e973bdc7 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
@@ -1836,7 +1836,7 @@ void iwl_drv_stop(struct iwl_drv *drv)
 	mutex_unlock(&iwlwifi_opmode_table_mtx);
 
 #ifdef CONFIG_IWLWIFI_DEBUGFS
-	drv->trans->ops->debugfs_cleanup(drv->trans);
+	iwl_trans_debugfs_cleanup(drv->trans);
 
 	debugfs_remove_recursive(drv->dbgfs_drv);
 #endif
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
index 327db93e8d84..eeee5c35668e 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
@@ -13,10 +13,11 @@
 #include "iwl-fh.h"
 #include <linux/dmapool.h>
 #include "fw/api/commands.h"
+#include "pcie/internal.h"
+#include "iwl-context-info-gen3.h"
 
 struct iwl_trans *iwl_trans_alloc(unsigned int priv_size,
 				  struct device *dev,
-				  const struct iwl_trans_ops *ops,
 				  const struct iwl_cfg_trans_params *cfg_trans)
 {
 	struct iwl_trans *trans;
@@ -36,11 +37,8 @@ struct iwl_trans *iwl_trans_alloc(unsigned int priv_size,
 #endif
 
 	trans->dev = dev;
-	trans->ops = ops;
 	trans->num_rx_queues = 1;
 
-	WARN_ON(!ops->wait_txq_empty && !ops->wait_tx_queues_empty);
-
 	return trans;
 }
 
@@ -190,3 +188,388 @@ int iwl_cmd_groups_verify_sorted(const struct iwl_trans_config *trans)
 	return 0;
 }
 IWL_EXPORT_SYMBOL(iwl_cmd_groups_verify_sorted);
+
+void iwl_trans_configure(struct iwl_trans *trans,
+			 const struct iwl_trans_config *trans_cfg)
+{
+	trans->op_mode = trans_cfg->op_mode;
+
+	iwl_trans_pcie_configure(trans, trans_cfg);
+	WARN_ON(iwl_cmd_groups_verify_sorted(trans_cfg));
+}
+IWL_EXPORT_SYMBOL(iwl_trans_configure);
+
+int iwl_trans_start_hw(struct iwl_trans *trans)
+{
+	might_sleep();
+
+	return iwl_trans_pcie_start_hw(trans);
+}
+IWL_EXPORT_SYMBOL(iwl_trans_start_hw);
+
+void iwl_trans_op_mode_leave(struct iwl_trans *trans)
+{
+	might_sleep();
+
+	iwl_trans_pcie_op_mode_leave(trans);
+
+	trans->op_mode = NULL;
+
+	trans->state = IWL_TRANS_NO_FW;
+}
+IWL_EXPORT_SYMBOL(iwl_trans_op_mode_leave);
+
+void iwl_trans_write8(struct iwl_trans *trans, u32 ofs, u8 val)
+{
+	iwl_trans_pcie_write8(trans, ofs, val);
+}
+IWL_EXPORT_SYMBOL(iwl_trans_write8);
+
+void iwl_trans_write32(struct iwl_trans *trans, u32 ofs, u32 val)
+{
+	iwl_trans_pcie_write32(trans, ofs, val);
+}
+IWL_EXPORT_SYMBOL(iwl_trans_write32);
+
+u32 iwl_trans_read32(struct iwl_trans *trans, u32 ofs)
+{
+	return iwl_trans_pcie_read32(trans, ofs);
+}
+IWL_EXPORT_SYMBOL(iwl_trans_read32);
+
+u32 iwl_trans_read_prph(struct iwl_trans *trans, u32 ofs)
+{
+	return iwl_trans_pcie_read_prph(trans, ofs);
+}
+IWL_EXPORT_SYMBOL(iwl_trans_read_prph);
+
+void iwl_trans_write_prph(struct iwl_trans *trans, u32 ofs, u32 val)
+{
+	return iwl_trans_pcie_write_prph(trans, ofs, val);
+}
+IWL_EXPORT_SYMBOL(iwl_trans_write_prph);
+
+int iwl_trans_read_mem(struct iwl_trans *trans, u32 addr,
+		       void *buf, int dwords)
+{
+	return iwl_trans_pcie_read_mem(trans, addr, buf, dwords);
+}
+IWL_EXPORT_SYMBOL(iwl_trans_read_mem);
+
+int iwl_trans_write_mem(struct iwl_trans *trans, u32 addr,
+			const void *buf, int dwords)
+{
+	return iwl_trans_pcie_write_mem(trans, addr, buf, dwords);
+}
+IWL_EXPORT_SYMBOL(iwl_trans_write_mem);
+
+void iwl_trans_set_pmi(struct iwl_trans *trans, bool state)
+{
+	if (state)
+		set_bit(STATUS_TPOWER_PMI, &trans->status);
+	else
+		clear_bit(STATUS_TPOWER_PMI, &trans->status);
+}
+IWL_EXPORT_SYMBOL(iwl_trans_set_pmi);
+
+int iwl_trans_sw_reset(struct iwl_trans *trans, bool retake_ownership)
+{
+	return iwl_trans_pcie_sw_reset(trans, retake_ownership);
+}
+IWL_EXPORT_SYMBOL(iwl_trans_sw_reset);
+
+struct iwl_trans_dump_data *
+iwl_trans_dump_data(struct iwl_trans *trans, u32 dump_mask,
+		    const struct iwl_dump_sanitize_ops *sanitize_ops,
+		    void *sanitize_ctx)
+{
+	return iwl_trans_pcie_dump_data(trans, dump_mask,
+					sanitize_ops, sanitize_ctx);
+}
+IWL_EXPORT_SYMBOL(iwl_trans_dump_data);
+
+int iwl_trans_d3_suspend(struct iwl_trans *trans, bool test, bool reset)
+{
+	might_sleep();
+
+	return iwl_trans_pcie_d3_suspend(trans, test, reset);
+}
+IWL_EXPORT_SYMBOL(iwl_trans_d3_suspend);
+
+int iwl_trans_d3_resume(struct iwl_trans *trans, enum iwl_d3_status *status,
+			bool test, bool reset)
+{
+	might_sleep();
+
+	return iwl_trans_pcie_d3_resume(trans, status, test, reset);
+}
+IWL_EXPORT_SYMBOL(iwl_trans_d3_resume);
+
+void iwl_trans_interrupts(struct iwl_trans *trans, bool enable)
+{
+	iwl_trans_pci_interrupts(trans, enable);
+}
+IWL_EXPORT_SYMBOL(iwl_trans_interrupts);
+
+void iwl_trans_sync_nmi(struct iwl_trans *trans)
+{
+	iwl_trans_pcie_sync_nmi(trans);
+}
+IWL_EXPORT_SYMBOL(iwl_trans_sync_nmi);
+
+int iwl_trans_write_imr_mem(struct iwl_trans *trans, u32 dst_addr,
+			    u64 src_addr, u32 byte_cnt)
+{
+	return iwl_trans_pcie_copy_imr(trans, dst_addr, src_addr, byte_cnt);
+}
+IWL_EXPORT_SYMBOL(iwl_trans_write_imr_mem);
+
+void iwl_trans_set_bits_mask(struct iwl_trans *trans, u32 reg,
+			     u32 mask, u32 value)
+{
+	iwl_trans_pcie_set_bits_mask(trans, reg, mask, value);
+}
+IWL_EXPORT_SYMBOL(iwl_trans_set_bits_mask);
+
+int iwl_trans_read_config32(struct iwl_trans *trans, u32 ofs,
+			    u32 *val)
+{
+	return iwl_trans_pcie_read_config32(trans, ofs, val);
+}
+IWL_EXPORT_SYMBOL(iwl_trans_read_config32);
+
+bool _iwl_trans_grab_nic_access(struct iwl_trans *trans)
+{
+	return iwl_trans_pcie_grab_nic_access(trans);
+}
+IWL_EXPORT_SYMBOL(_iwl_trans_grab_nic_access);
+
+void __releases(nic_access)
+iwl_trans_release_nic_access(struct iwl_trans *trans)
+{
+	iwl_trans_pcie_release_nic_access(trans);
+	__release(nic_access);
+}
+IWL_EXPORT_SYMBOL(iwl_trans_release_nic_access);
+
+void iwl_trans_fw_alive(struct iwl_trans *trans, u32 scd_addr)
+{
+	might_sleep();
+
+	trans->state = IWL_TRANS_FW_ALIVE;
+
+	if (trans->trans_cfg->gen2)
+		iwl_trans_pcie_gen2_fw_alive(trans, scd_addr);
+	else
+		iwl_trans_pcie_fw_alive(trans, scd_addr);
+}
+IWL_EXPORT_SYMBOL(iwl_trans_fw_alive);
+
+int iwl_trans_start_fw(struct iwl_trans *trans, const struct fw_img *fw,
+		       bool run_in_rfkill)
+{
+	int ret;
+
+	might_sleep();
+
+	WARN_ON_ONCE(!trans->rx_mpdu_cmd);
+
+	clear_bit(STATUS_FW_ERROR, &trans->status);
+
+	if (trans->trans_cfg->gen2)
+		ret = iwl_trans_pcie_gen2_start_fw(trans, fw, run_in_rfkill);
+	else
+		ret = iwl_trans_pcie_start_fw(trans, fw, run_in_rfkill);
+
+	if (ret == 0)
+		trans->state = IWL_TRANS_FW_STARTED;
+
+	return ret;
+}
+IWL_EXPORT_SYMBOL(iwl_trans_start_fw);
+
+void iwl_trans_stop_device(struct iwl_trans *trans)
+{
+	might_sleep();
+
+	if (trans->trans_cfg->gen2)
+		iwl_trans_pcie_gen2_stop_device(trans);
+	else
+		iwl_trans_pcie_stop_device(trans);
+
+	trans->state = IWL_TRANS_NO_FW;
+}
+IWL_EXPORT_SYMBOL(iwl_trans_stop_device);
+
+int iwl_trans_tx(struct iwl_trans *trans, struct sk_buff *skb,
+		 struct iwl_device_tx_cmd *dev_cmd, int queue)
+{
+	if (unlikely(test_bit(STATUS_FW_ERROR, &trans->status)))
+		return -EIO;
+
+	if (WARN_ON_ONCE(trans->state != IWL_TRANS_FW_ALIVE)) {
+		IWL_ERR(trans, "%s bad state = %d\n", __func__, trans->state);
+		return -EIO;
+	}
+
+	if (trans->trans_cfg->gen2)
+		return iwl_txq_gen2_tx(trans, skb, dev_cmd, queue);
+
+	return iwl_trans_pcie_tx(trans, skb, dev_cmd, queue);
+}
+IWL_EXPORT_SYMBOL(iwl_trans_tx);
+
+void iwl_trans_reclaim(struct iwl_trans *trans, int queue, int ssn,
+		       struct sk_buff_head *skbs, bool is_flush)
+{
+	if (WARN_ON_ONCE(trans->state != IWL_TRANS_FW_ALIVE)) {
+		IWL_ERR(trans, "%s bad state = %d\n", __func__, trans->state);
+		return;
+	}
+
+	iwl_pcie_reclaim(trans, queue, ssn, skbs, is_flush);
+}
+IWL_EXPORT_SYMBOL(iwl_trans_reclaim);
+
+void iwl_trans_txq_disable(struct iwl_trans *trans, int queue,
+			   bool configure_scd)
+{
+	iwl_trans_pcie_txq_disable(trans, queue, configure_scd);
+}
+IWL_EXPORT_SYMBOL(iwl_trans_txq_disable);
+
+bool iwl_trans_txq_enable_cfg(struct iwl_trans *trans, int queue, u16 ssn,
+			      const struct iwl_trans_txq_scd_cfg *cfg,
+			      unsigned int queue_wdg_timeout)
+{
+	might_sleep();
+
+	if (WARN_ON_ONCE(trans->state != IWL_TRANS_FW_ALIVE)) {
+		IWL_ERR(trans, "%s bad state = %d\n", __func__, trans->state);
+		return false;
+	}
+
+	return iwl_trans_pcie_txq_enable(trans, queue, ssn,
+					 cfg, queue_wdg_timeout);
+}
+IWL_EXPORT_SYMBOL(iwl_trans_txq_enable_cfg);
+
+int iwl_trans_wait_txq_empty(struct iwl_trans *trans, int queue)
+{
+	if (WARN_ON_ONCE(trans->state != IWL_TRANS_FW_ALIVE)) {
+		IWL_ERR(trans, "%s bad state = %d\n", __func__, trans->state);
+		return -EIO;
+	}
+
+	return iwl_trans_pcie_wait_txq_empty(trans, queue);
+}
+IWL_EXPORT_SYMBOL(iwl_trans_wait_txq_empty);
+
+int iwl_trans_wait_tx_queues_empty(struct iwl_trans *trans, u32 txqs)
+{
+	/* No need to wait if the firmware is not alive */
+	if (trans->state != IWL_TRANS_FW_ALIVE) {
+		IWL_ERR(trans, "%s bad state = %d\n", __func__, trans->state);
+		return -EIO;
+	}
+
+	return iwl_trans_pcie_wait_txqs_empty(trans, txqs);
+}
+IWL_EXPORT_SYMBOL(iwl_trans_wait_tx_queues_empty);
+
+void iwl_trans_freeze_txq_timer(struct iwl_trans *trans,
+				unsigned long txqs, bool freeze)
+{
+	if (WARN_ON_ONCE(trans->state != IWL_TRANS_FW_ALIVE)) {
+		IWL_ERR(trans, "%s bad state = %d\n", __func__, trans->state);
+		return;
+	}
+
+	iwl_pcie_freeze_txq_timer(trans, txqs, freeze);
+}
+IWL_EXPORT_SYMBOL(iwl_trans_freeze_txq_timer);
+
+void iwl_trans_txq_set_shared_mode(struct iwl_trans *trans,
+				   int txq_id, bool shared_mode)
+{
+	iwl_trans_pcie_txq_set_shared_mode(trans, txq_id, shared_mode);
+}
+IWL_EXPORT_SYMBOL(iwl_trans_txq_set_shared_mode);
+
+#ifdef CONFIG_IWLWIFI_DEBUGFS
+void iwl_trans_debugfs_cleanup(struct iwl_trans *trans)
+{
+	iwl_trans_pcie_debugfs_cleanup(trans);
+}
+IWL_EXPORT_SYMBOL(iwl_trans_debugfs_cleanup);
+#endif
+
+void iwl_trans_set_q_ptrs(struct iwl_trans *trans, int queue, int ptr)
+{
+	if (WARN_ON_ONCE(trans->state != IWL_TRANS_FW_ALIVE)) {
+		IWL_ERR(trans, "%s bad state = %d\n", __func__, trans->state);
+		return;
+	}
+
+	iwl_pcie_set_q_ptrs(trans, queue, ptr);
+}
+IWL_EXPORT_SYMBOL(iwl_trans_set_q_ptrs);
+
+int iwl_trans_txq_alloc(struct iwl_trans *trans, u32 flags, u32 sta_mask,
+			u8 tid, int size, unsigned int wdg_timeout)
+{
+	might_sleep();
+
+	if (WARN_ON_ONCE(trans->state != IWL_TRANS_FW_ALIVE)) {
+		IWL_ERR(trans, "%s bad state = %d\n", __func__, trans->state);
+		return -EIO;
+	}
+
+	return iwl_txq_dyn_alloc(trans, flags, sta_mask, tid,
+				 size, wdg_timeout);
+}
+IWL_EXPORT_SYMBOL(iwl_trans_txq_alloc);
+
+void iwl_trans_txq_free(struct iwl_trans *trans, int queue)
+{
+	iwl_txq_dyn_free(trans, queue);
+}
+IWL_EXPORT_SYMBOL(iwl_trans_txq_free);
+
+int iwl_trans_get_rxq_dma_data(struct iwl_trans *trans, int queue,
+			       struct iwl_trans_rxq_dma_data *data)
+{
+	return iwl_trans_pcie_rxq_dma_data(trans, queue, data);
+}
+IWL_EXPORT_SYMBOL(iwl_trans_get_rxq_dma_data);
+
+int iwl_trans_load_pnvm(struct iwl_trans *trans,
+			const struct iwl_pnvm_image *pnvm_data,
+			const struct iwl_ucode_capabilities *capa)
+{
+	return iwl_trans_pcie_ctx_info_gen3_load_pnvm(trans, pnvm_data, capa);
+}
+IWL_EXPORT_SYMBOL(iwl_trans_load_pnvm);
+
+void iwl_trans_set_pnvm(struct iwl_trans *trans,
+			const struct iwl_ucode_capabilities *capa)
+{
+	iwl_trans_pcie_ctx_info_gen3_set_pnvm(trans, capa);
+}
+IWL_EXPORT_SYMBOL(iwl_trans_set_pnvm);
+
+int iwl_trans_load_reduce_power(struct iwl_trans *trans,
+				const struct iwl_pnvm_image *payloads,
+				const struct iwl_ucode_capabilities *capa)
+{
+	return iwl_trans_pcie_ctx_info_gen3_load_reduce_power(trans, payloads,
+							      capa);
+}
+IWL_EXPORT_SYMBOL(iwl_trans_load_reduce_power);
+
+void iwl_trans_set_reduce_power(struct iwl_trans *trans,
+				const struct iwl_ucode_capabilities *capa)
+{
+	iwl_trans_pcie_ctx_info_gen3_set_reduce_power(trans, capa);
+}
+IWL_EXPORT_SYMBOL(iwl_trans_set_reduce_power);
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index 27f92b393f8e..006eb51a705f 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -473,183 +473,6 @@ struct iwl_pnvm_image {
 	u32 version;
 };
 
-/**
- * struct iwl_trans_ops - transport specific operations
- *
- * All the handlers MUST be implemented
- *
- * @start_hw: starts the HW. From that point on, the HW can send interrupts.
- *	May sleep.
- * @op_mode_leave: Turn off the HW RF kill indication if on
- *	May sleep
- * @start_fw: allocates and inits all the resources for the transport
- *	layer. Also kick a fw image.
- *	May sleep
- * @fw_alive: called when the fw sends alive notification. If the fw provides
- *	the SCD base address in SRAM, then provide it here, or 0 otherwise.
- *	May sleep
- * @stop_device: stops the whole device (embedded CPU put to reset) and stops
- *	the HW. From that point on, the HW will be stopped but will still issue
- *	an interrupt if the HW RF kill switch is triggered.
- *	This callback must do the right thing and not crash even if %start_hw()
- *	was called but not &start_fw(). May sleep.
- * @d3_suspend: put the device into the correct mode for WoWLAN during
- *	suspend. This is optional, if not implemented WoWLAN will not be
- *	supported. This callback may sleep.
- * @d3_resume: resume the device after WoWLAN, enabling the opmode to
- *	talk to the WoWLAN image to get its status. This is optional, if not
- *	implemented WoWLAN will not be supported. This callback may sleep.
- * @send_cmd:send a host command. Must return -ERFKILL if RFkill is asserted.
- *	If RFkill is asserted in the middle of a SYNC host command, it must
- *	return -ERFKILL straight away.
- *	May sleep only if CMD_ASYNC is not set
- * @tx: send an skb. The transport relies on the op_mode to zero the
- *	the ieee80211_tx_info->driver_data. If the MPDU is an A-MSDU, all
- *	the CSUM will be taken care of (TCP CSUM and IP header in case of
- *	IPv4). If the MPDU is a single MSDU, the op_mode must compute the IP
- *	header if it is IPv4.
- *	Must be atomic
- * @reclaim: free packet until ssn. Returns a list of freed packets.
- *	Must be atomic
- * @set_q_ptrs: set queue pointers internally, after D3 when HW state changed
- * @txq_enable: setup a queue. To setup an AC queue, use the
- *	iwl_trans_ac_txq_enable wrapper. fw_alive must have been called before
- *	this one. The op_mode must not configure the HCMD queue. The scheduler
- *	configuration may be %NULL, in which case the hardware will not be
- *	configured. If true is returned, the operation mode needs to increment
- *	the sequence number of the packets routed to this queue because of a
- *	hardware scheduler bug. May sleep.
- * @txq_disable: de-configure a Tx queue to send AMPDUs
- *	Must be atomic
- * @txq_alloc: Allocate a new TX queue, may sleep.
- * @txq_free: Free a previously allocated TX queue.
- * @txq_set_shared_mode: change Tx queue shared/unshared marking
- * @wait_tx_queues_empty: wait until tx queues are empty. May sleep.
- * @wait_txq_empty: wait until specific tx queue is empty. May sleep.
- * @freeze_txq_timer: prevents the timer of the queue from firing until the
- *	queue is set to awake. Must be atomic.
- * @write8: write a u8 to a register at offset ofs from the BAR
- * @write32: write a u32 to a register at offset ofs from the BAR
- * @read32: read a u32 register at offset ofs from the BAR
- * @read_prph: read a DWORD from a periphery register
- * @write_prph: write a DWORD to a periphery register
- * @read_mem: read device's SRAM in DWORD
- * @write_mem: write device's SRAM in DWORD. If %buf is %NULL, then the memory
- *	will be zeroed.
- * @read_config32: read a u32 value from the device's config space at
- *	the given offset.
- * @configure: configure parameters required by the transport layer from
- *	the op_mode. May be called several times before start_fw, can't be
- *	called after that.
- * @set_pmi: set the power pmi state
- * @sw_reset: trigger software reset of the NIC
- * @grab_nic_access: wake the NIC to be able to access non-HBUS regs.
- *	Sleeping is not allowed between grab_nic_access and
- *	release_nic_access.
- * @release_nic_access: let the NIC go to sleep. The "flags" parameter
- *	must be the same one that was sent before to the grab_nic_access.
- * @set_bits_mask: set SRAM register according to value and mask.
- * @dump_data: return a vmalloc'ed buffer with debug data, maybe containing last
- *	TX'ed commands and similar. The buffer will be vfree'd by the caller.
- *	Note that the transport must fill in the proper file headers.
- * @debugfs_cleanup: used in the driver unload flow to make a proper cleanup
- *	of the trans debugfs
- * @sync_nmi: trigger a firmware NMI and wait for it to complete
- * @load_pnvm: save the pnvm data in DRAM
- * @set_pnvm: set the pnvm data in the prph scratch buffer, inside the
- *	context info.
- * @load_reduce_power: copy reduce power table to the corresponding DRAM memory
- * @set_reduce_power: set reduce power table addresses in the sratch buffer
- * @interrupts: disable/enable interrupts to transport
- * @imr_dma_data: set up IMR DMA
- * @rxq_dma_data: retrieve RX queue DMA data, see @struct iwl_trans_rxq_dma_data
- */
-struct iwl_trans_ops {
-
-	int (*start_hw)(struct iwl_trans *iwl_trans);
-	void (*op_mode_leave)(struct iwl_trans *iwl_trans);
-	int (*start_fw)(struct iwl_trans *trans, const struct fw_img *fw,
-			bool run_in_rfkill);
-	void (*fw_alive)(struct iwl_trans *trans, u32 scd_addr);
-	void (*stop_device)(struct iwl_trans *trans);
-
-	int (*d3_suspend)(struct iwl_trans *trans, bool test, bool reset);
-	int (*d3_resume)(struct iwl_trans *trans, enum iwl_d3_status *status,
-			 bool test, bool reset);
-
-	int (*send_cmd)(struct iwl_trans *trans, struct iwl_host_cmd *cmd);
-
-	int (*tx)(struct iwl_trans *trans, struct sk_buff *skb,
-		  struct iwl_device_tx_cmd *dev_cmd, int queue);
-	void (*reclaim)(struct iwl_trans *trans, int queue, int ssn,
-			struct sk_buff_head *skbs, bool is_flush);
-
-	void (*set_q_ptrs)(struct iwl_trans *trans, int queue, int ptr);
-
-	bool (*txq_enable)(struct iwl_trans *trans, int queue, u16 ssn,
-			   const struct iwl_trans_txq_scd_cfg *cfg,
-			   unsigned int queue_wdg_timeout);
-	void (*txq_disable)(struct iwl_trans *trans, int queue,
-			    bool configure_scd);
-	/* 22000 functions */
-	int (*txq_alloc)(struct iwl_trans *trans, u32 flags,
-			 u32 sta_mask, u8 tid,
-			 int size, unsigned int queue_wdg_timeout);
-	void (*txq_free)(struct iwl_trans *trans, int queue);
-	int (*rxq_dma_data)(struct iwl_trans *trans, int queue,
-			    struct iwl_trans_rxq_dma_data *data);
-
-	void (*txq_set_shared_mode)(struct iwl_trans *trans, u32 txq_id,
-				    bool shared);
-
-	int (*wait_tx_queues_empty)(struct iwl_trans *trans, u32 txq_bm);
-	int (*wait_txq_empty)(struct iwl_trans *trans, int queue);
-	void (*freeze_txq_timer)(struct iwl_trans *trans, unsigned long txqs,
-				 bool freeze);
-
-	void (*write8)(struct iwl_trans *trans, u32 ofs, u8 val);
-	void (*write32)(struct iwl_trans *trans, u32 ofs, u32 val);
-	u32 (*read32)(struct iwl_trans *trans, u32 ofs);
-	u32 (*read_prph)(struct iwl_trans *trans, u32 ofs);
-	void (*write_prph)(struct iwl_trans *trans, u32 ofs, u32 val);
-	int (*read_mem)(struct iwl_trans *trans, u32 addr,
-			void *buf, int dwords);
-	int (*write_mem)(struct iwl_trans *trans, u32 addr,
-			 const void *buf, int dwords);
-	int (*read_config32)(struct iwl_trans *trans, u32 ofs, u32 *val);
-	void (*configure)(struct iwl_trans *trans,
-			  const struct iwl_trans_config *trans_cfg);
-	void (*set_pmi)(struct iwl_trans *trans, bool state);
-	int (*sw_reset)(struct iwl_trans *trans, bool retake_ownership);
-	bool (*grab_nic_access)(struct iwl_trans *trans);
-	void (*release_nic_access)(struct iwl_trans *trans);
-	void (*set_bits_mask)(struct iwl_trans *trans, u32 reg, u32 mask,
-			      u32 value);
-
-	struct iwl_trans_dump_data *(*dump_data)(struct iwl_trans *trans,
-						 u32 dump_mask,
-						 const struct iwl_dump_sanitize_ops *sanitize_ops,
-						 void *sanitize_ctx);
-	void (*debugfs_cleanup)(struct iwl_trans *trans);
-	void (*sync_nmi)(struct iwl_trans *trans);
-	int (*load_pnvm)(struct iwl_trans *trans,
-			 const struct iwl_pnvm_image *pnvm_payloads,
-			 const struct iwl_ucode_capabilities *capa);
-	void (*set_pnvm)(struct iwl_trans *trans,
-			 const struct iwl_ucode_capabilities *capa);
-	int (*load_reduce_power)(struct iwl_trans *trans,
-				 const struct iwl_pnvm_image *payloads,
-				 const struct iwl_ucode_capabilities *capa);
-	void (*set_reduce_power)(struct iwl_trans *trans,
-				 const struct iwl_ucode_capabilities *capa);
-
-	void (*interrupts)(struct iwl_trans *trans, bool enable);
-	int (*imr_dma_data)(struct iwl_trans *trans,
-			    u32 dst_addr, u64 src_addr,
-			    u32 byte_cnt);
-
-};
-
 /**
  * enum iwl_trans_state - state of the transport layer
  *
@@ -994,7 +817,6 @@ struct iwl_txq {
  * struct iwl_trans - transport common data
  *
  * @csme_own: true if we couldn't get ownership on the device
- * @ops: pointer to iwl_trans_ops
  * @op_mode: pointer to the op_mode
  * @trans_cfg: the trans-specific configuration part
  * @cfg: pointer to the configuration
@@ -1055,7 +877,6 @@ struct iwl_txq {
  */
 struct iwl_trans {
 	bool csme_own;
-	const struct iwl_trans_ops *ops;
 	struct iwl_op_mode *op_mode;
 	const struct iwl_cfg_trans_params *trans_cfg;
 	const struct iwl_cfg *cfg;
@@ -1127,101 +948,29 @@ struct iwl_trans {
 const char *iwl_get_cmd_string(struct iwl_trans *trans, u32 id);
 int iwl_cmd_groups_verify_sorted(const struct iwl_trans_config *trans);
 
-static inline void iwl_trans_configure(struct iwl_trans *trans,
-				       const struct iwl_trans_config *trans_cfg)
-{
-	trans->op_mode = trans_cfg->op_mode;
-
-	trans->ops->configure(trans, trans_cfg);
-	WARN_ON(iwl_cmd_groups_verify_sorted(trans_cfg));
-}
-
-static inline int iwl_trans_start_hw(struct iwl_trans *trans)
-{
-	might_sleep();
-
-	return trans->ops->start_hw(trans);
-}
-
-static inline void iwl_trans_op_mode_leave(struct iwl_trans *trans)
-{
-	might_sleep();
-
-	if (trans->ops->op_mode_leave)
-		trans->ops->op_mode_leave(trans);
+void iwl_trans_configure(struct iwl_trans *trans,
+			 const struct iwl_trans_config *trans_cfg);
 
-	trans->op_mode = NULL;
-
-	trans->state = IWL_TRANS_NO_FW;
-}
-
-static inline void iwl_trans_fw_alive(struct iwl_trans *trans, u32 scd_addr)
-{
-	might_sleep();
-
-	trans->state = IWL_TRANS_FW_ALIVE;
-
-	trans->ops->fw_alive(trans, scd_addr);
-}
-
-static inline int iwl_trans_start_fw(struct iwl_trans *trans,
-				     const struct fw_img *fw,
-				     bool run_in_rfkill)
-{
-	int ret;
-
-	might_sleep();
-
-	WARN_ON_ONCE(!trans->rx_mpdu_cmd);
-
-	clear_bit(STATUS_FW_ERROR, &trans->status);
-	ret = trans->ops->start_fw(trans, fw, run_in_rfkill);
-	if (ret == 0)
-		trans->state = IWL_TRANS_FW_STARTED;
-
-	return ret;
-}
-
-static inline void iwl_trans_stop_device(struct iwl_trans *trans)
-{
-	might_sleep();
+int iwl_trans_start_hw(struct iwl_trans *trans);
 
-	trans->ops->stop_device(trans);
+void iwl_trans_op_mode_leave(struct iwl_trans *trans);
 
-	trans->state = IWL_TRANS_NO_FW;
-}
+void iwl_trans_fw_alive(struct iwl_trans *trans, u32 scd_addr);
 
-static inline int iwl_trans_d3_suspend(struct iwl_trans *trans, bool test,
-				       bool reset)
-{
-	might_sleep();
-	if (!trans->ops->d3_suspend)
-		return -EOPNOTSUPP;
+int iwl_trans_start_fw(struct iwl_trans *trans, const struct fw_img *fw,
+		       bool run_in_rfkill);
 
-	return trans->ops->d3_suspend(trans, test, reset);
-}
+void iwl_trans_stop_device(struct iwl_trans *trans);
 
-static inline int iwl_trans_d3_resume(struct iwl_trans *trans,
-				      enum iwl_d3_status *status,
-				      bool test, bool reset)
-{
-	might_sleep();
-	if (!trans->ops->d3_resume)
-		return -EOPNOTSUPP;
+int iwl_trans_d3_suspend(struct iwl_trans *trans, bool test, bool reset);
 
-	return trans->ops->d3_resume(trans, status, test, reset);
-}
+int iwl_trans_d3_resume(struct iwl_trans *trans, enum iwl_d3_status *status,
+			bool test, bool reset);
 
-static inline struct iwl_trans_dump_data *
+struct iwl_trans_dump_data *
 iwl_trans_dump_data(struct iwl_trans *trans, u32 dump_mask,
 		    const struct iwl_dump_sanitize_ops *sanitize_ops,
-		    void *sanitize_ctx)
-{
-	if (!trans->ops->dump_data)
-		return NULL;
-	return trans->ops->dump_data(trans, dump_mask,
-				     sanitize_ops, sanitize_ctx);
-}
+		    void *sanitize_ctx);
 
 static inline struct iwl_device_tx_cmd *
 iwl_trans_alloc_tx_cmd(struct iwl_trans *trans)
@@ -1237,109 +986,31 @@ static inline void iwl_trans_free_tx_cmd(struct iwl_trans *trans,
 	kmem_cache_free(trans->dev_cmd_pool, dev_cmd);
 }
 
-static inline int iwl_trans_tx(struct iwl_trans *trans, struct sk_buff *skb,
-			       struct iwl_device_tx_cmd *dev_cmd, int queue)
-{
-	if (unlikely(test_bit(STATUS_FW_ERROR, &trans->status)))
-		return -EIO;
+int iwl_trans_tx(struct iwl_trans *trans, struct sk_buff *skb,
+		 struct iwl_device_tx_cmd *dev_cmd, int queue);
 
-	if (WARN_ON_ONCE(trans->state != IWL_TRANS_FW_ALIVE)) {
-		IWL_ERR(trans, "%s bad state = %d\n", __func__, trans->state);
-		return -EIO;
-	}
+void iwl_trans_reclaim(struct iwl_trans *trans, int queue, int ssn,
+		       struct sk_buff_head *skbs, bool is_flush);
 
-	return trans->ops->tx(trans, skb, dev_cmd, queue);
-}
+void iwl_trans_set_q_ptrs(struct iwl_trans *trans, int queue, int ptr);
 
-static inline void iwl_trans_reclaim(struct iwl_trans *trans, int queue,
-				     int ssn, struct sk_buff_head *skbs,
-				     bool is_flush)
-{
-	if (WARN_ON_ONCE(trans->state != IWL_TRANS_FW_ALIVE)) {
-		IWL_ERR(trans, "%s bad state = %d\n", __func__, trans->state);
-		return;
-	}
+void iwl_trans_txq_disable(struct iwl_trans *trans, int queue,
+			   bool configure_scd);
 
-	trans->ops->reclaim(trans, queue, ssn, skbs, is_flush);
-}
+bool iwl_trans_txq_enable_cfg(struct iwl_trans *trans, int queue, u16 ssn,
+			      const struct iwl_trans_txq_scd_cfg *cfg,
+			      unsigned int queue_wdg_timeout);
 
-static inline void iwl_trans_set_q_ptrs(struct iwl_trans *trans, int queue,
-					int ptr)
-{
-	if (WARN_ON_ONCE(trans->state != IWL_TRANS_FW_ALIVE)) {
-		IWL_ERR(trans, "%s bad state = %d\n", __func__, trans->state);
-		return;
-	}
+int iwl_trans_get_rxq_dma_data(struct iwl_trans *trans, int queue,
+			       struct iwl_trans_rxq_dma_data *data);
 
-	trans->ops->set_q_ptrs(trans, queue, ptr);
-}
-
-static inline void iwl_trans_txq_disable(struct iwl_trans *trans, int queue,
-					 bool configure_scd)
-{
-	trans->ops->txq_disable(trans, queue, configure_scd);
-}
-
-static inline bool
-iwl_trans_txq_enable_cfg(struct iwl_trans *trans, int queue, u16 ssn,
-			 const struct iwl_trans_txq_scd_cfg *cfg,
-			 unsigned int queue_wdg_timeout)
-{
-	might_sleep();
-
-	if (WARN_ON_ONCE(trans->state != IWL_TRANS_FW_ALIVE)) {
-		IWL_ERR(trans, "%s bad state = %d\n", __func__, trans->state);
-		return false;
-	}
+void iwl_trans_txq_free(struct iwl_trans *trans, int queue);
 
-	return trans->ops->txq_enable(trans, queue, ssn,
-				      cfg, queue_wdg_timeout);
-}
-
-static inline int
-iwl_trans_get_rxq_dma_data(struct iwl_trans *trans, int queue,
-			   struct iwl_trans_rxq_dma_data *data)
-{
-	if (WARN_ON_ONCE(!trans->ops->rxq_dma_data))
-		return -EOPNOTSUPP;
+int iwl_trans_txq_alloc(struct iwl_trans *trans, u32 flags, u32 sta_mask,
+			u8 tid, int size, unsigned int wdg_timeout);
 
-	return trans->ops->rxq_dma_data(trans, queue, data);
-}
-
-static inline void
-iwl_trans_txq_free(struct iwl_trans *trans, int queue)
-{
-	if (WARN_ON_ONCE(!trans->ops->txq_free))
-		return;
-
-	trans->ops->txq_free(trans, queue);
-}
-
-static inline int
-iwl_trans_txq_alloc(struct iwl_trans *trans,
-		    u32 flags, u32 sta_mask, u8 tid,
-		    int size, unsigned int wdg_timeout)
-{
-	might_sleep();
-
-	if (WARN_ON_ONCE(!trans->ops->txq_alloc))
-		return -EOPNOTSUPP;
-
-	if (WARN_ON_ONCE(trans->state != IWL_TRANS_FW_ALIVE)) {
-		IWL_ERR(trans, "%s bad state = %d\n", __func__, trans->state);
-		return -EIO;
-	}
-
-	return trans->ops->txq_alloc(trans, flags, sta_mask, tid,
-				     size, wdg_timeout);
-}
-
-static inline void iwl_trans_txq_set_shared_mode(struct iwl_trans *trans,
-						 int queue, bool shared_mode)
-{
-	if (trans->ops->txq_set_shared_mode)
-		trans->ops->txq_set_shared_mode(trans, queue, shared_mode);
-}
+void iwl_trans_txq_set_shared_mode(struct iwl_trans *trans,
+				   int txq_id, bool shared_mode);
 
 static inline void iwl_trans_txq_enable(struct iwl_trans *trans, int queue,
 					int fifo, int sta_id, int tid,
@@ -1372,78 +1043,32 @@ void iwl_trans_ac_txq_enable(struct iwl_trans *trans, int queue, int fifo,
 	iwl_trans_txq_enable_cfg(trans, queue, 0, &cfg, queue_wdg_timeout);
 }
 
-static inline void iwl_trans_freeze_txq_timer(struct iwl_trans *trans,
-					      unsigned long txqs,
-					      bool freeze)
-{
-	if (WARN_ON_ONCE(trans->state != IWL_TRANS_FW_ALIVE)) {
-		IWL_ERR(trans, "%s bad state = %d\n", __func__, trans->state);
-		return;
-	}
+void iwl_trans_freeze_txq_timer(struct iwl_trans *trans,
+				unsigned long txqs, bool freeze);
 
-	if (trans->ops->freeze_txq_timer)
-		trans->ops->freeze_txq_timer(trans, txqs, freeze);
-}
+int iwl_trans_wait_tx_queues_empty(struct iwl_trans *trans, u32 txqs);
 
-static inline int iwl_trans_wait_tx_queues_empty(struct iwl_trans *trans,
-						 u32 txqs)
-{
-	if (WARN_ON_ONCE(!trans->ops->wait_tx_queues_empty))
-		return -EOPNOTSUPP;
-
-	/* No need to wait if the firmware is not alive */
-	if (trans->state != IWL_TRANS_FW_ALIVE) {
-		IWL_ERR(trans, "%s bad state = %d\n", __func__, trans->state);
-		return -EIO;
-	}
-
-	return trans->ops->wait_tx_queues_empty(trans, txqs);
-}
+int iwl_trans_wait_txq_empty(struct iwl_trans *trans, int queue);
 
-static inline int iwl_trans_wait_txq_empty(struct iwl_trans *trans, int queue)
-{
-	if (WARN_ON_ONCE(!trans->ops->wait_txq_empty))
-		return -EOPNOTSUPP;
+void iwl_trans_write8(struct iwl_trans *trans, u32 ofs, u8 val);
 
-	if (WARN_ON_ONCE(trans->state != IWL_TRANS_FW_ALIVE)) {
-		IWL_ERR(trans, "%s bad state = %d\n", __func__, trans->state);
-		return -EIO;
-	}
+void iwl_trans_write32(struct iwl_trans *trans, u32 ofs, u32 val);
 
-	return trans->ops->wait_txq_empty(trans, queue);
-}
+u32 iwl_trans_read32(struct iwl_trans *trans, u32 ofs);
 
-static inline void iwl_trans_write8(struct iwl_trans *trans, u32 ofs, u8 val)
-{
-	trans->ops->write8(trans, ofs, val);
-}
+u32 iwl_trans_read_prph(struct iwl_trans *trans, u32 ofs);
 
-static inline void iwl_trans_write32(struct iwl_trans *trans, u32 ofs, u32 val)
-{
-	trans->ops->write32(trans, ofs, val);
-}
+void iwl_trans_write_prph(struct iwl_trans *trans, u32 ofs, u32 val);
 
-static inline u32 iwl_trans_read32(struct iwl_trans *trans, u32 ofs)
-{
-	return trans->ops->read32(trans, ofs);
-}
+int iwl_trans_read_mem(struct iwl_trans *trans, u32 addr,
+		       void *buf, int dwords);
 
-static inline u32 iwl_trans_read_prph(struct iwl_trans *trans, u32 ofs)
-{
-	return trans->ops->read_prph(trans, ofs);
-}
+int iwl_trans_read_config32(struct iwl_trans *trans, u32 ofs,
+			    u32 *val);
 
-static inline void iwl_trans_write_prph(struct iwl_trans *trans, u32 ofs,
-					u32 val)
-{
-	return trans->ops->write_prph(trans, ofs, val);
-}
-
-static inline int iwl_trans_read_mem(struct iwl_trans *trans, u32 addr,
-				     void *buf, int dwords)
-{
-	return trans->ops->read_mem(trans, addr, buf, dwords);
-}
+#ifdef CONFIG_IWLWIFI_DEBUGFS
+void iwl_trans_debugfs_cleanup(struct iwl_trans *trans);
+#endif
 
 #define iwl_trans_read_mem_bytes(trans, addr, buf, bufsize)		      \
 	do {								      \
@@ -1452,14 +1077,8 @@ static inline int iwl_trans_read_mem(struct iwl_trans *trans, u32 addr,
 		iwl_trans_read_mem(trans, addr, buf, (bufsize) / sizeof(u32));\
 	} while (0)
 
-static inline int iwl_trans_write_imr_mem(struct iwl_trans *trans,
-					  u32 dst_addr, u64 src_addr,
-					  u32 byte_cnt)
-{
-	if (trans->ops->imr_dma_data)
-		return trans->ops->imr_dma_data(trans, dst_addr, src_addr, byte_cnt);
-	return 0;
-}
+int iwl_trans_write_imr_mem(struct iwl_trans *trans, u32 dst_addr,
+			    u64 src_addr, u32 byte_cnt);
 
 static inline u32 iwl_trans_read_mem32(struct iwl_trans *trans, u32 addr)
 {
@@ -1471,11 +1090,8 @@ static inline u32 iwl_trans_read_mem32(struct iwl_trans *trans, u32 addr)
 	return value;
 }
 
-static inline int iwl_trans_write_mem(struct iwl_trans *trans, u32 addr,
-				      const void *buf, int dwords)
-{
-	return trans->ops->write_mem(trans, addr, buf, dwords);
-}
+int iwl_trans_write_mem(struct iwl_trans *trans, u32 addr,
+			const void *buf, int dwords);
 
 static inline u32 iwl_trans_write_mem32(struct iwl_trans *trans, u32 addr,
 					u32 val)
@@ -1483,36 +1099,21 @@ static inline u32 iwl_trans_write_mem32(struct iwl_trans *trans, u32 addr,
 	return iwl_trans_write_mem(trans, addr, &val, 1);
 }
 
-static inline void iwl_trans_set_pmi(struct iwl_trans *trans, bool state)
-{
-	if (trans->ops->set_pmi)
-		trans->ops->set_pmi(trans, state);
-}
+void iwl_trans_set_pmi(struct iwl_trans *trans, bool state);
 
-static inline int iwl_trans_sw_reset(struct iwl_trans *trans,
-				     bool retake_ownership)
-{
-	if (trans->ops->sw_reset)
-		return trans->ops->sw_reset(trans, retake_ownership);
-	return 0;
-}
+int iwl_trans_sw_reset(struct iwl_trans *trans, bool retake_ownership);
 
-static inline void
-iwl_trans_set_bits_mask(struct iwl_trans *trans, u32 reg, u32 mask, u32 value)
-{
-	trans->ops->set_bits_mask(trans, reg, mask, value);
-}
+void iwl_trans_set_bits_mask(struct iwl_trans *trans, u32 reg,
+			     u32 mask, u32 value);
+
+bool _iwl_trans_grab_nic_access(struct iwl_trans *trans);
 
 #define iwl_trans_grab_nic_access(trans)		\
 	__cond_lock(nic_access,				\
-		    likely((trans)->ops->grab_nic_access(trans)))
+		    likely(_iwl_trans_grab_nic_access(trans)))
 
-static inline void __releases(nic_access)
-iwl_trans_release_nic_access(struct iwl_trans *trans)
-{
-	trans->ops->release_nic_access(trans);
-	__release(nic_access);
-}
+void __releases(nic_access)
+iwl_trans_release_nic_access(struct iwl_trans *trans);
 
 static inline void iwl_trans_fw_error(struct iwl_trans *trans, bool sync)
 {
@@ -1531,44 +1132,24 @@ static inline bool iwl_trans_fw_running(struct iwl_trans *trans)
 	return trans->state == IWL_TRANS_FW_ALIVE;
 }
 
-static inline void iwl_trans_sync_nmi(struct iwl_trans *trans)
-{
-	if (trans->ops->sync_nmi)
-		trans->ops->sync_nmi(trans);
-}
+void iwl_trans_sync_nmi(struct iwl_trans *trans);
 
 void iwl_trans_sync_nmi_with_addr(struct iwl_trans *trans, u32 inta_addr,
 				  u32 sw_err_bit);
 
-static inline int iwl_trans_load_pnvm(struct iwl_trans *trans,
-				      const struct iwl_pnvm_image *pnvm_data,
-				      const struct iwl_ucode_capabilities *capa)
-{
-	return trans->ops->load_pnvm(trans, pnvm_data, capa);
-}
+int iwl_trans_load_pnvm(struct iwl_trans *trans,
+			const struct iwl_pnvm_image *pnvm_data,
+			const struct iwl_ucode_capabilities *capa);
 
-static inline void iwl_trans_set_pnvm(struct iwl_trans *trans,
-				      const struct iwl_ucode_capabilities *capa)
-{
-	if (trans->ops->set_pnvm)
-		trans->ops->set_pnvm(trans, capa);
-}
+void iwl_trans_set_pnvm(struct iwl_trans *trans,
+			const struct iwl_ucode_capabilities *capa);
 
-static inline int iwl_trans_load_reduce_power
-				(struct iwl_trans *trans,
-				 const struct iwl_pnvm_image *payloads,
-				 const struct iwl_ucode_capabilities *capa)
-{
-	return trans->ops->load_reduce_power(trans, payloads, capa);
-}
+int iwl_trans_load_reduce_power(struct iwl_trans *trans,
+				const struct iwl_pnvm_image *payloads,
+				const struct iwl_ucode_capabilities *capa);
 
-static inline void
-iwl_trans_set_reduce_power(struct iwl_trans *trans,
-			   const struct iwl_ucode_capabilities *capa)
-{
-	if (trans->ops->set_reduce_power)
-		trans->ops->set_reduce_power(trans, capa);
-}
+void iwl_trans_set_reduce_power(struct iwl_trans *trans,
+				const struct iwl_ucode_capabilities *capa);
 
 static inline bool iwl_trans_dbg_ini_valid(struct iwl_trans *trans)
 {
@@ -1576,18 +1157,13 @@ static inline bool iwl_trans_dbg_ini_valid(struct iwl_trans *trans)
 		trans->dbg.external_ini_cfg != IWL_INI_CFG_STATE_NOT_LOADED;
 }
 
-static inline void iwl_trans_interrupts(struct iwl_trans *trans, bool enable)
-{
-	if (trans->ops->interrupts)
-		trans->ops->interrupts(trans, enable);
-}
+void iwl_trans_interrupts(struct iwl_trans *trans, bool enable);
 
 /*****************************************************
  * transport helper functions
  *****************************************************/
 struct iwl_trans *iwl_trans_alloc(unsigned int priv_size,
 			  struct device *dev,
-			  const struct iwl_trans_ops *ops,
 			  const struct iwl_cfg_trans_params *cfg_trans);
 int iwl_trans_init(struct iwl_trans *trans);
 void iwl_trans_free(struct iwl_trans *trans);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 7b030995a6a4..727047d5ddb2 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -727,8 +727,6 @@ int iwl_mvm_mac_setup_register(struct iwl_mvm *mvm)
 
 #ifdef CONFIG_PM_SLEEP
 	if ((unified || mvm->fw->img[IWL_UCODE_WOWLAN].num_sec) &&
-	    mvm->trans->ops->d3_suspend &&
-	    mvm->trans->ops->d3_resume &&
 	    device_can_wakeup(mvm->trans->dev)) {
 		mvm->wowlan.flags |= WIPHY_WOWLAN_MAGIC_PKT |
 				     WIPHY_WOWLAN_DISCONNECT |
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
index 3bdbb907d91a..3ce626c93651 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
@@ -761,6 +761,8 @@ void iwl_pcie_reclaim(struct iwl_trans *trans, int txq_id, int ssn,
 void iwl_pcie_set_q_ptrs(struct iwl_trans *trans, int txq_id, int ptr);
 void iwl_pcie_freeze_txq_timer(struct iwl_trans *trans,
 			       unsigned long txqs, bool freeze);
+int iwl_trans_pcie_wait_txq_empty(struct iwl_trans *trans, int txq_idx);
+int iwl_trans_pcie_wait_txqs_empty(struct iwl_trans *trans, u32 txq_bm);
 
 /*****************************************************
 * Error handling
@@ -1027,12 +1029,51 @@ void iwl_trans_pcie_dump_regs(struct iwl_trans *trans);
 
 #ifdef CONFIG_IWLWIFI_DEBUGFS
 void iwl_trans_pcie_dbgfs_register(struct iwl_trans *trans);
+void iwl_trans_pcie_debugfs_cleanup(struct iwl_trans *trans);
 #else
 static inline void iwl_trans_pcie_dbgfs_register(struct iwl_trans *trans) { }
 #endif
 
 void iwl_pcie_rx_allocator_work(struct work_struct *data);
 
+/* common trans ops for all generations transports */
+void iwl_trans_pcie_configure(struct iwl_trans *trans,
+			      const struct iwl_trans_config *trans_cfg);
+int iwl_trans_pcie_start_hw(struct iwl_trans *trans);
+void iwl_trans_pcie_op_mode_leave(struct iwl_trans *trans);
+void iwl_trans_pcie_write8(struct iwl_trans *trans, u32 ofs, u8 val);
+void iwl_trans_pcie_write32(struct iwl_trans *trans, u32 ofs, u32 val);
+u32 iwl_trans_pcie_read32(struct iwl_trans *trans, u32 ofs);
+u32 iwl_trans_pcie_read_prph(struct iwl_trans *trans, u32 reg);
+void iwl_trans_pcie_write_prph(struct iwl_trans *trans, u32 addr, u32 val);
+int iwl_trans_pcie_read_mem(struct iwl_trans *trans, u32 addr,
+			    void *buf, int dwords);
+int iwl_trans_pcie_write_mem(struct iwl_trans *trans, u32 addr,
+			     const void *buf, int dwords);
+int iwl_trans_pcie_sw_reset(struct iwl_trans *trans, bool retake_ownership);
+struct iwl_trans_dump_data *
+iwl_trans_pcie_dump_data(struct iwl_trans *trans, u32 dump_mask,
+			 const struct iwl_dump_sanitize_ops *sanitize_ops,
+			 void *sanitize_ctx);
+int iwl_trans_pcie_d3_resume(struct iwl_trans *trans,
+			     enum iwl_d3_status *status,
+			     bool test,  bool reset);
+int iwl_trans_pcie_d3_suspend(struct iwl_trans *trans, bool test, bool reset);
+void iwl_trans_pci_interrupts(struct iwl_trans *trans, bool enable);
+void iwl_trans_pcie_sync_nmi(struct iwl_trans *trans);
+void iwl_trans_pcie_set_bits_mask(struct iwl_trans *trans, u32 reg,
+				  u32 mask, u32 value);
+int iwl_trans_pcie_read_config32(struct iwl_trans *trans, u32 ofs,
+				 u32 *val);
+bool iwl_trans_pcie_grab_nic_access(struct iwl_trans *trans);
+void iwl_trans_pcie_release_nic_access(struct iwl_trans *trans);
+
+/* transport gen 1 exported functions */
+void iwl_trans_pcie_fw_alive(struct iwl_trans *trans, u32 scd_addr);
+int iwl_trans_pcie_start_fw(struct iwl_trans *trans,
+			    const struct fw_img *fw, bool run_in_rfkill);
+void iwl_trans_pcie_stop_device(struct iwl_trans *trans);
+
 /* common functions that are used by gen2 transport */
 int iwl_pcie_gen2_apm_init(struct iwl_trans *trans);
 void iwl_pcie_apm_config(struct iwl_trans *trans);
@@ -1069,5 +1110,7 @@ void iwl_trans_pcie_copy_imr_fh(struct iwl_trans *trans,
 				u32 dst_addr, u64 src_addr, u32 byte_cnt);
 int iwl_trans_pcie_copy_imr(struct iwl_trans *trans,
 			    u32 dst_addr, u64 src_addr, u32 byte_cnt);
+int iwl_trans_pcie_rxq_dma_data(struct iwl_trans *trans, int queue,
+				struct iwl_trans_rxq_dma_data *data);
 
 #endif /* __iwl_trans_int_pcie_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index 48ae38f3120d..94502e004719 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -127,8 +127,7 @@ void iwl_trans_pcie_dump_regs(struct iwl_trans *trans)
 	kfree(buf);
 }
 
-static int iwl_trans_pcie_sw_reset(struct iwl_trans *trans,
-				   bool retake_ownership)
+int iwl_trans_pcie_sw_reset(struct iwl_trans *trans, bool retake_ownership)
 {
 	/* Reset entire device - do controller reset (results in SHRD_HW_RST) */
 	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_BZ) {
@@ -1336,8 +1335,8 @@ void iwl_pcie_synchronize_irqs(struct iwl_trans *trans)
 	}
 }
 
-static int iwl_trans_pcie_start_fw(struct iwl_trans *trans,
-				   const struct fw_img *fw, bool run_in_rfkill)
+int iwl_trans_pcie_start_fw(struct iwl_trans *trans,
+			    const struct fw_img *fw, bool run_in_rfkill)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	bool hw_rfkill;
@@ -1423,7 +1422,7 @@ static int iwl_trans_pcie_start_fw(struct iwl_trans *trans,
 	return ret;
 }
 
-static void iwl_trans_pcie_fw_alive(struct iwl_trans *trans, u32 scd_addr)
+void iwl_trans_pcie_fw_alive(struct iwl_trans *trans, u32 scd_addr)
 {
 	iwl_pcie_reset_ict(trans);
 	iwl_pcie_tx_start(trans, scd_addr);
@@ -1458,7 +1457,7 @@ void iwl_trans_pcie_handle_stop_rfkill(struct iwl_trans *trans,
 		iwl_trans_pcie_rf_kill(trans, hw_rfkill, false);
 }
 
-static void iwl_trans_pcie_stop_device(struct iwl_trans *trans)
+void iwl_trans_pcie_stop_device(struct iwl_trans *trans)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	bool was_in_rfkill;
@@ -1552,8 +1551,7 @@ static int iwl_pcie_d3_handshake(struct iwl_trans *trans, bool suspend)
 	return 0;
 }
 
-static int iwl_trans_pcie_d3_suspend(struct iwl_trans *trans, bool test,
-				     bool reset)
+int iwl_trans_pcie_d3_suspend(struct iwl_trans *trans, bool test, bool reset)
 {
 	int ret;
 
@@ -1571,9 +1569,9 @@ static int iwl_trans_pcie_d3_suspend(struct iwl_trans *trans, bool test,
 	return 0;
 }
 
-static int iwl_trans_pcie_d3_resume(struct iwl_trans *trans,
-				    enum iwl_d3_status *status,
-				    bool test,  bool reset)
+int iwl_trans_pcie_d3_resume(struct iwl_trans *trans,
+			     enum iwl_d3_status *status,
+			     bool test,  bool reset)
 {
 	struct iwl_trans_pcie *trans_pcie =  IWL_TRANS_GET_PCIE_TRANS(trans);
 	u32 val;
@@ -1874,7 +1872,7 @@ static int _iwl_trans_pcie_start_hw(struct iwl_trans *trans)
 	return 0;
 }
 
-static int iwl_trans_pcie_start_hw(struct iwl_trans *trans)
+int iwl_trans_pcie_start_hw(struct iwl_trans *trans)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	int ret;
@@ -1886,7 +1884,7 @@ static int iwl_trans_pcie_start_hw(struct iwl_trans *trans)
 	return ret;
 }
 
-static void iwl_trans_pcie_op_mode_leave(struct iwl_trans *trans)
+void iwl_trans_pcie_op_mode_leave(struct iwl_trans *trans)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 
@@ -1906,17 +1904,17 @@ static void iwl_trans_pcie_op_mode_leave(struct iwl_trans *trans)
 	iwl_pcie_synchronize_irqs(trans);
 }
 
-static void iwl_trans_pcie_write8(struct iwl_trans *trans, u32 ofs, u8 val)
+void iwl_trans_pcie_write8(struct iwl_trans *trans, u32 ofs, u8 val)
 {
 	writeb(val, IWL_TRANS_GET_PCIE_TRANS(trans)->hw_base + ofs);
 }
 
-static void iwl_trans_pcie_write32(struct iwl_trans *trans, u32 ofs, u32 val)
+void iwl_trans_pcie_write32(struct iwl_trans *trans, u32 ofs, u32 val)
 {
 	writel(val, IWL_TRANS_GET_PCIE_TRANS(trans)->hw_base + ofs);
 }
 
-static u32 iwl_trans_pcie_read32(struct iwl_trans *trans, u32 ofs)
+u32 iwl_trans_pcie_read32(struct iwl_trans *trans, u32 ofs)
 {
 	return readl(IWL_TRANS_GET_PCIE_TRANS(trans)->hw_base + ofs);
 }
@@ -1929,7 +1927,7 @@ static u32 iwl_trans_pcie_prph_msk(struct iwl_trans *trans)
 		return 0x000FFFFF;
 }
 
-static u32 iwl_trans_pcie_read_prph(struct iwl_trans *trans, u32 reg)
+u32 iwl_trans_pcie_read_prph(struct iwl_trans *trans, u32 reg)
 {
 	u32 mask = iwl_trans_pcie_prph_msk(trans);
 
@@ -1938,8 +1936,7 @@ static u32 iwl_trans_pcie_read_prph(struct iwl_trans *trans, u32 reg)
 	return iwl_trans_pcie_read32(trans, HBUS_TARG_PRPH_RDAT);
 }
 
-static void iwl_trans_pcie_write_prph(struct iwl_trans *trans, u32 addr,
-				      u32 val)
+void iwl_trans_pcie_write_prph(struct iwl_trans *trans, u32 addr, u32 val)
 {
 	u32 mask = iwl_trans_pcie_prph_msk(trans);
 
@@ -1948,8 +1945,8 @@ static void iwl_trans_pcie_write_prph(struct iwl_trans *trans, u32 addr,
 	iwl_trans_pcie_write32(trans, HBUS_TARG_PRPH_WDAT, val);
 }
 
-static void iwl_trans_pcie_configure(struct iwl_trans *trans,
-				     const struct iwl_trans_config *trans_cfg)
+void iwl_trans_pcie_configure(struct iwl_trans *trans,
+			      const struct iwl_trans_config *trans_cfg)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 
@@ -2095,14 +2092,6 @@ void iwl_trans_pcie_free(struct iwl_trans *trans)
 	iwl_trans_free(trans);
 }
 
-static void iwl_trans_pcie_set_pmi(struct iwl_trans *trans, bool state)
-{
-	if (state)
-		set_bit(STATUS_TPOWER_PMI, &trans->status);
-	else
-		clear_bit(STATUS_TPOWER_PMI, &trans->status);
-}
-
 struct iwl_trans_pcie_removal {
 	struct pci_dev *pdev;
 	struct work_struct work;
@@ -2266,7 +2255,7 @@ bool __iwl_trans_pcie_grab_nic_access(struct iwl_trans *trans)
 	return true;
 }
 
-static bool iwl_trans_pcie_grab_nic_access(struct iwl_trans *trans)
+bool iwl_trans_pcie_grab_nic_access(struct iwl_trans *trans)
 {
 	bool ret;
 
@@ -2280,7 +2269,7 @@ static bool iwl_trans_pcie_grab_nic_access(struct iwl_trans *trans)
 	return false;
 }
 
-static void iwl_trans_pcie_release_nic_access(struct iwl_trans *trans)
+void iwl_trans_pcie_release_nic_access(struct iwl_trans *trans)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 
@@ -2310,8 +2299,8 @@ static void iwl_trans_pcie_release_nic_access(struct iwl_trans *trans)
 	spin_unlock_bh(&trans_pcie->reg_lock);
 }
 
-static int iwl_trans_pcie_read_mem(struct iwl_trans *trans, u32 addr,
-				   void *buf, int dwords)
+int iwl_trans_pcie_read_mem(struct iwl_trans *trans, u32 addr,
+			    void *buf, int dwords)
 {
 #define IWL_MAX_HW_ERRS 5
 	unsigned int num_consec_hw_errors = 0;
@@ -2360,8 +2349,8 @@ static int iwl_trans_pcie_read_mem(struct iwl_trans *trans, u32 addr,
 	return 0;
 }
 
-static int iwl_trans_pcie_write_mem(struct iwl_trans *trans, u32 addr,
-				    const void *buf, int dwords)
+int iwl_trans_pcie_write_mem(struct iwl_trans *trans, u32 addr,
+			     const void *buf, int dwords)
 {
 	int offs, ret = 0;
 	const u32 *vals = buf;
@@ -2378,8 +2367,8 @@ static int iwl_trans_pcie_write_mem(struct iwl_trans *trans, u32 addr,
 	return ret;
 }
 
-static int iwl_trans_pcie_read_config32(struct iwl_trans *trans, u32 ofs,
-					u32 *val)
+int iwl_trans_pcie_read_config32(struct iwl_trans *trans, u32 ofs,
+				 u32 *val)
 {
 	return pci_read_config_dword(IWL_TRANS_GET_PCIE_TRANS(trans)->pci_dev,
 				     ofs, val);
@@ -2387,8 +2376,8 @@ static int iwl_trans_pcie_read_config32(struct iwl_trans *trans, u32 ofs,
 
 #define IWL_FLUSH_WAIT_MS	2000
 
-static int iwl_trans_pcie_rxq_dma_data(struct iwl_trans *trans, int queue,
-				       struct iwl_trans_rxq_dma_data *data)
+int iwl_trans_pcie_rxq_dma_data(struct iwl_trans *trans, int queue,
+				struct iwl_trans_rxq_dma_data *data)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 
@@ -2403,7 +2392,7 @@ static int iwl_trans_pcie_rxq_dma_data(struct iwl_trans *trans, int queue,
 	return 0;
 }
 
-static int iwl_trans_pcie_wait_txq_empty(struct iwl_trans *trans, int txq_idx)
+int iwl_trans_pcie_wait_txq_empty(struct iwl_trans *trans, int txq_idx)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	struct iwl_txq *txq;
@@ -2465,7 +2454,7 @@ static int iwl_trans_pcie_wait_txq_empty(struct iwl_trans *trans, int txq_idx)
 	return 0;
 }
 
-static int iwl_trans_pcie_wait_txqs_empty(struct iwl_trans *trans, u32 txq_bm)
+int iwl_trans_pcie_wait_txqs_empty(struct iwl_trans *trans, u32 txq_bm)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	int cnt;
@@ -2491,8 +2480,8 @@ static int iwl_trans_pcie_wait_txqs_empty(struct iwl_trans *trans, u32 txq_bm)
 	return ret;
 }
 
-static void iwl_trans_pcie_set_bits_mask(struct iwl_trans *trans, u32 reg,
-					 u32 mask, u32 value)
+void iwl_trans_pcie_set_bits_mask(struct iwl_trans *trans, u32 reg,
+				  u32 mask, u32 value)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 
@@ -3071,7 +3060,7 @@ void iwl_trans_pcie_dbgfs_register(struct iwl_trans *trans)
 	DEBUGFS_ADD_FILE(rf, dir, 0400);
 }
 
-static void iwl_trans_pcie_debugfs_cleanup(struct iwl_trans *trans)
+void iwl_trans_pcie_debugfs_cleanup(struct iwl_trans *trans)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	struct cont_rec *data = &trans_pcie->fw_mon_data;
@@ -3349,9 +3338,8 @@ static int iwl_trans_get_fw_monitor_len(struct iwl_trans *trans, u32 *len)
 	return 0;
 }
 
-static struct iwl_trans_dump_data *
-iwl_trans_pcie_dump_data(struct iwl_trans *trans,
-			 u32 dump_mask,
+struct iwl_trans_dump_data *
+iwl_trans_pcie_dump_data(struct iwl_trans *trans, u32 dump_mask,
 			 const struct iwl_dump_sanitize_ops *sanitize_ops,
 			 void *sanitize_ctx)
 {
@@ -3500,7 +3488,7 @@ iwl_trans_pcie_dump_data(struct iwl_trans *trans,
 	return dump_data;
 }
 
-static void iwl_trans_pci_interrupts(struct iwl_trans *trans, bool enable)
+void iwl_trans_pci_interrupts(struct iwl_trans *trans, bool enable)
 {
 	if (enable)
 		iwl_enable_interrupts(trans);
@@ -3508,7 +3496,7 @@ static void iwl_trans_pci_interrupts(struct iwl_trans *trans, bool enable)
 		iwl_disable_interrupts(trans);
 }
 
-static void iwl_trans_pcie_sync_nmi(struct iwl_trans *trans)
+void iwl_trans_pcie_sync_nmi(struct iwl_trans *trans)
 {
 	u32 inta_addr, sw_err_bit;
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
@@ -3527,81 +3515,6 @@ static void iwl_trans_pcie_sync_nmi(struct iwl_trans *trans)
 	iwl_trans_sync_nmi_with_addr(trans, inta_addr, sw_err_bit);
 }
 
-#define IWL_TRANS_COMMON_OPS						\
-	.op_mode_leave = iwl_trans_pcie_op_mode_leave,			\
-	.write8 = iwl_trans_pcie_write8,				\
-	.write32 = iwl_trans_pcie_write32,				\
-	.read32 = iwl_trans_pcie_read32,				\
-	.read_prph = iwl_trans_pcie_read_prph,				\
-	.write_prph = iwl_trans_pcie_write_prph,			\
-	.read_mem = iwl_trans_pcie_read_mem,				\
-	.write_mem = iwl_trans_pcie_write_mem,				\
-	.read_config32 = iwl_trans_pcie_read_config32,			\
-	.configure = iwl_trans_pcie_configure,				\
-	.set_pmi = iwl_trans_pcie_set_pmi,				\
-	.sw_reset = iwl_trans_pcie_sw_reset,				\
-	.grab_nic_access = iwl_trans_pcie_grab_nic_access,		\
-	.release_nic_access = iwl_trans_pcie_release_nic_access,	\
-	.set_bits_mask = iwl_trans_pcie_set_bits_mask,			\
-	.dump_data = iwl_trans_pcie_dump_data,				\
-	.d3_suspend = iwl_trans_pcie_d3_suspend,			\
-	.d3_resume = iwl_trans_pcie_d3_resume,				\
-	.interrupts = iwl_trans_pci_interrupts,				\
-	.sync_nmi = iwl_trans_pcie_sync_nmi,				\
-	.imr_dma_data = iwl_trans_pcie_copy_imr				\
-
-static const struct iwl_trans_ops trans_ops_pcie = {
-	IWL_TRANS_COMMON_OPS,
-	.start_hw = iwl_trans_pcie_start_hw,
-	.fw_alive = iwl_trans_pcie_fw_alive,
-	.start_fw = iwl_trans_pcie_start_fw,
-	.stop_device = iwl_trans_pcie_stop_device,
-
-	.send_cmd = iwl_pcie_enqueue_hcmd,
-
-	.tx = iwl_trans_pcie_tx,
-	.reclaim = iwl_pcie_reclaim,
-
-	.txq_disable = iwl_trans_pcie_txq_disable,
-	.txq_enable = iwl_trans_pcie_txq_enable,
-
-	.txq_set_shared_mode = iwl_trans_pcie_txq_set_shared_mode,
-
-	.wait_tx_queues_empty = iwl_trans_pcie_wait_txqs_empty,
-
-	.freeze_txq_timer = iwl_pcie_freeze_txq_timer,
-#ifdef CONFIG_IWLWIFI_DEBUGFS
-	.debugfs_cleanup = iwl_trans_pcie_debugfs_cleanup,
-#endif
-};
-
-static const struct iwl_trans_ops trans_ops_pcie_gen2 = {
-	IWL_TRANS_COMMON_OPS,
-	.start_hw = iwl_trans_pcie_start_hw,
-	.fw_alive = iwl_trans_pcie_gen2_fw_alive,
-	.start_fw = iwl_trans_pcie_gen2_start_fw,
-	.stop_device = iwl_trans_pcie_gen2_stop_device,
-
-	.send_cmd = iwl_pcie_gen2_enqueue_hcmd,
-
-	.tx = iwl_txq_gen2_tx,
-	.reclaim = iwl_pcie_reclaim,
-
-	.set_q_ptrs = iwl_pcie_set_q_ptrs,
-
-	.txq_alloc = iwl_txq_dyn_alloc,
-	.txq_free = iwl_txq_dyn_free,
-	.wait_txq_empty = iwl_trans_pcie_wait_txq_empty,
-	.rxq_dma_data = iwl_trans_pcie_rxq_dma_data,
-	.load_pnvm = iwl_trans_pcie_ctx_info_gen3_load_pnvm,
-	.set_pnvm = iwl_trans_pcie_ctx_info_gen3_set_pnvm,
-	.load_reduce_power = iwl_trans_pcie_ctx_info_gen3_load_reduce_power,
-	.set_reduce_power = iwl_trans_pcie_ctx_info_gen3_set_reduce_power,
-#ifdef CONFIG_IWLWIFI_DEBUGFS
-	.debugfs_cleanup = iwl_trans_pcie_debugfs_cleanup,
-#endif
-};
-
 struct iwl_trans *iwl_trans_pcie_alloc(struct pci_dev *pdev,
 			       const struct pci_device_id *ent,
 			       const struct iwl_cfg_trans_params *cfg_trans)
@@ -3609,13 +3522,9 @@ struct iwl_trans *iwl_trans_pcie_alloc(struct pci_dev *pdev,
 	struct iwl_trans_pcie *trans_pcie, **priv;
 	struct iwl_trans *trans;
 	int ret, addr_size;
-	const struct iwl_trans_ops *ops = &trans_ops_pcie_gen2;
 	void __iomem * const *table;
 	u32 bar0;
 
-	if (!cfg_trans->gen2)
-		ops = &trans_ops_pcie;
-
 	/* reassign our BAR 0 if invalid due to possible runtime PM races */
 	pci_read_config_dword(pdev, PCI_BASE_ADDRESS_0, &bar0);
 	if (bar0 == PCI_BASE_ADDRESS_MEM_TYPE_64) {
@@ -3628,7 +3537,7 @@ struct iwl_trans *iwl_trans_pcie_alloc(struct pci_dev *pdev,
 	if (ret)
 		return ERR_PTR(ret);
 
-	trans = iwl_trans_alloc(sizeof(struct iwl_trans_pcie), &pdev->dev, ops,
+	trans = iwl_trans_alloc(sizeof(struct iwl_trans_pcie), &pdev->dev,
 				cfg_trans);
 	if (!trans)
 		return ERR_PTR(-ENOMEM);
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
index fd47c4400b4e..f4452732417d 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
@@ -2385,7 +2385,11 @@ static int iwl_trans_pcie_send_hcmd_sync(struct iwl_trans *trans,
 
 	IWL_DEBUG_INFO(trans, "Setting HCMD_ACTIVE for command %s\n", cmd_str);
 
-	cmd_idx = trans->ops->send_cmd(trans, cmd);
+	if (trans->trans_cfg->gen2)
+		cmd_idx = iwl_pcie_gen2_enqueue_hcmd(trans, cmd);
+	else
+		cmd_idx = iwl_pcie_enqueue_hcmd(trans, cmd);
+
 	if (cmd_idx < 0) {
 		ret = cmd_idx;
 		clear_bit(STATUS_SYNC_HCMD_ACTIVE, &trans->status);
@@ -2485,7 +2489,11 @@ int iwl_trans_pcie_send_hcmd(struct iwl_trans *trans,
 		if (WARN_ON(cmd->flags & CMD_WANT_SKB))
 			return -EINVAL;
 
-		ret = trans->ops->send_cmd(trans, cmd);
+		if (trans->trans_cfg->gen2)
+			ret = iwl_pcie_gen2_enqueue_hcmd(trans, cmd);
+		else
+			ret = iwl_pcie_enqueue_hcmd(trans, cmd);
+
 		if (ret < 0) {
 			IWL_ERR(trans,
 				"Error sending %s: enqueue_hcmd failed: %d\n",
-- 
2.34.1


