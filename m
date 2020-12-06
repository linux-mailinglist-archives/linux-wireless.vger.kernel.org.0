Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65AC52D032D
	for <lists+linux-wireless@lfdr.de>; Sun,  6 Dec 2020 12:08:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbgLFLIT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 6 Dec 2020 06:08:19 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:34768 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726604AbgLFLIS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 6 Dec 2020 06:08:18 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1klrt4-003AAN-S3; Sun, 06 Dec 2020 13:07:31 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sun,  6 Dec 2020 13:07:18 +0200
Message-Id: <iwlwifi.20201206130357.5f2b14cb2320.I31184f4be31f7c3feb9a29aef3a111e70d15c64a@changeid>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201206110729.488452-1-luca@coelho.fi>
References: <20201206110729.488452-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 01/12] iwlwifi: pcie: change 12k A-MSDU config to use 16k buffers
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

If 12k A-MSDU size is requested, we will actually allocate 16k
due to page allocation. Thus, change it to actually mean 16k,
which is useful for certain sniffer use cases.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-context-info-gen3.h | 2 ++
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c               | 2 +-
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h             | 4 ++--
 drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c   | 2 +-
 drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info.c        | 2 +-
 5 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-context-info-gen3.h b/drivers/net/wireless/intel/iwlwifi/iwl-context-info-gen3.h
index 5624fe42efd9..d0eb666b2ca1 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-context-info-gen3.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-context-info-gen3.h
@@ -98,6 +98,7 @@ enum iwl_prph_scratch_mtr_format {
  *	appropriately; use the below values for this.
  * @IWL_PRPH_SCRATCH_RB_SIZE_EXT_8K: 8kB RB size
  * @IWL_PRPH_SCRATCH_RB_SIZE_EXT_12K: 12kB RB size
+ * @IWL_PRPH_SCRATCH_RB_SIZE_EXT_16K: 16kB RB size
  */
 enum iwl_prph_scratch_flags {
 	IWL_PRPH_SCRATCH_EARLY_DEBUG_EN		= BIT(4),
@@ -111,6 +112,7 @@ enum iwl_prph_scratch_flags {
 	IWL_PRPH_SCRATCH_RB_SIZE_EXT_MASK	= 0xf << 20,
 	IWL_PRPH_SCRATCH_RB_SIZE_EXT_8K		= 8 << 20,
 	IWL_PRPH_SCRATCH_RB_SIZE_EXT_12K	= 9 << 20,
+	IWL_PRPH_SCRATCH_RB_SIZE_EXT_16K	= 10 << 20,
 };
 
 /*
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
index 9dcd2e990c9c..12b5031a793f 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
@@ -1835,7 +1835,7 @@ MODULE_PARM_DESC(11n_disable,
 module_param_named(amsdu_size, iwlwifi_mod_params.amsdu_size, int, 0444);
 MODULE_PARM_DESC(amsdu_size,
 		 "amsdu size 0: 12K for multi Rx queue devices, 2K for AX210 devices, "
-		 "4K for other devices 1:4K 2:8K 3:12K 4: 2K (default 0)");
+		 "4K for other devices 1:4K 2:8K 3:12K (16K buffers) 4: 2K (default 0)");
 module_param_named(fw_restart, iwlwifi_mod_params.fw_restart, bool, 0444);
 MODULE_PARM_DESC(fw_restart, "restart firmware in case of error (default true)");
 
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index 8f3774181b97..b84921e1556c 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -373,7 +373,7 @@ iwl_trans_get_rb_size_order(enum iwl_amsdu_size rb_size)
 	case IWL_AMSDU_8K:
 		return get_order(8 * 1024);
 	case IWL_AMSDU_12K:
-		return get_order(12 * 1024);
+		return get_order(16 * 1024);
 	default:
 		WARN_ON(1);
 		return -1;
@@ -391,7 +391,7 @@ iwl_trans_get_rb_size(enum iwl_amsdu_size rb_size)
 	case IWL_AMSDU_8K:
 		return 8 * 1024;
 	case IWL_AMSDU_12K:
-		return 12 * 1024;
+		return 16 * 1024;
 	default:
 		WARN_ON(1);
 		return 0;
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
index a0352fa873d9..166bd87c8d7e 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
@@ -148,7 +148,7 @@ int iwl_pcie_ctxt_info_gen3_init(struct iwl_trans *trans,
 	case IWL_AMSDU_12K:
 		control_flags |= IWL_PRPH_SCRATCH_RB_SIZE_4K;
 		/* if firmware supports the ext size, tell it */
-		control_flags |= IWL_PRPH_SCRATCH_RB_SIZE_EXT_12K;
+		control_flags |= IWL_PRPH_SCRATCH_RB_SIZE_EXT_16K;
 		break;
 	}
 
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info.c b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info.c
index 13fe9c00d7e8..41b439ae6278 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info.c
@@ -243,7 +243,7 @@ int iwl_pcie_ctxt_info_init(struct iwl_trans *trans,
 		rb_size = IWL_CTXT_INFO_RB_SIZE_8K;
 		break;
 	case IWL_AMSDU_12K:
-		rb_size = IWL_CTXT_INFO_RB_SIZE_12K;
+		rb_size = IWL_CTXT_INFO_RB_SIZE_16K;
 		break;
 	default:
 		WARN_ON(1);
-- 
2.29.2

