Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B48E43132BA
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Feb 2021 13:51:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbhBHMuK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 8 Feb 2021 07:50:10 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:44462 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230094AbhBHMtr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 8 Feb 2021 07:49:47 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1l95yE-0047PC-88; Mon, 08 Feb 2021 14:48:50 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Mon,  8 Feb 2021 14:48:38 +0200
Message-Id: <iwlwifi.20210208144305.7a692be70096.I9a0ad29f80daba8956a6aa077ba865e19b2150be@changeid>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210208124847.1934441-1-luca@coelho.fi>
References: <20210208124847.1934441-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 03/12] iwlwifi: dbg: add op_mode callback for collecting debug data.
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mordechay Goodstein <mordechay.goodstein@intel.com>

The first use is collecting debug data when transport stops the device.

Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.h   |  4 +++-
 drivers/net/wireless/intel/iwlwifi/iwl-op-mode.h   | 14 +++++++++++++-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c       | 12 +++++++++++-
 .../net/wireless/intel/iwlwifi/pcie/trans-gen2.c   |  4 ++++
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c    |  4 ++++
 5 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.h b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.h
index 246823878281..f11dcf5ec436 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.h
@@ -1,12 +1,14 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2018-2019 Intel Corporation
+ * Copyright (C) 2018-2020 Intel Corporation
  */
 #ifndef __iwl_dbg_tlv_h__
 #define __iwl_dbg_tlv_h__
 
 #include <linux/device.h>
 #include <linux/types.h>
+#include <fw/file.h>
+#include <fw/api/dbg-tlv.h>
 
 /**
  * struct iwl_dbg_tlv_node - debug TLV node
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-op-mode.h b/drivers/net/wireless/intel/iwlwifi/iwl-op-mode.h
index 9097fe310693..868da7e79a45 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-op-mode.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-op-mode.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2005-2014, 2018-2019 Intel Corporation
+ * Copyright (C) 2005-2014, 2018-2020 Intel Corporation
  * Copyright (C) 2013-2014 Intel Mobile Communications GmbH
  * Copyright (C) 2015 Intel Deutschland GmbH
  */
@@ -9,6 +9,7 @@
 
 #include <linux/netdevice.h>
 #include <linux/debugfs.h>
+#include "iwl-dbg-tlv.h"
 
 struct iwl_op_mode;
 struct iwl_trans;
@@ -83,6 +84,7 @@ struct iwl_cfg;
  * @nic_config: configure NIC, called before firmware is started.
  *	May sleep
  * @wimax_active: invoked when WiMax becomes active. May sleep
+ * @time_point: called when transport layer wants to collect debug data
  */
 struct iwl_op_mode_ops {
 	struct iwl_op_mode *(*start)(struct iwl_trans *trans,
@@ -104,6 +106,9 @@ struct iwl_op_mode_ops {
 	void (*cmd_queue_full)(struct iwl_op_mode *op_mode);
 	void (*nic_config)(struct iwl_op_mode *op_mode);
 	void (*wimax_active)(struct iwl_op_mode *op_mode);
+	void (*time_point)(struct iwl_op_mode *op_mode,
+			   enum iwl_fw_ini_time_point tp_id,
+			   union iwl_dbg_tlv_tp_data *tp_data);
 };
 
 int iwl_opmode_register(const char *name, const struct iwl_op_mode_ops *ops);
@@ -196,4 +201,11 @@ static inline void iwl_op_mode_wimax_active(struct iwl_op_mode *op_mode)
 	op_mode->ops->wimax_active(op_mode);
 }
 
+static inline void iwl_op_mode_time_point(struct iwl_op_mode *op_mode,
+					  enum iwl_fw_ini_time_point tp_id,
+					  union iwl_dbg_tlv_tp_data *tp_data)
+{
+	op_mode->ops->time_point(op_mode, tp_id, tp_data);
+}
+
 #endif /* __iwl_op_mode_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index a1c7572285dc..72e4a388d5a2 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -1407,6 +1407,15 @@ static void iwl_mvm_cmd_queue_full(struct iwl_op_mode *op_mode)
 	iwl_mvm_nic_restart(mvm, true);
 }
 
+static void iwl_op_mode_mvm_time_point(struct iwl_op_mode *op_mode,
+				       enum iwl_fw_ini_time_point tp_id,
+				       union iwl_dbg_tlv_tp_data *tp_data)
+{
+	struct iwl_mvm *mvm = IWL_OP_MODE_GET_MVM(op_mode);
+
+	iwl_dbg_tlv_time_point(&mvm->fwrt, tp_id, tp_data);
+}
+
 #define IWL_MVM_COMMON_OPS					\
 	/* these could be differentiated */			\
 	.async_cb = iwl_mvm_async_cb,				\
@@ -1419,7 +1428,8 @@ static void iwl_mvm_cmd_queue_full(struct iwl_op_mode *op_mode)
 	.nic_config = iwl_mvm_nic_config,			\
 	/* as we only register one, these MUST be common! */	\
 	.start = iwl_op_mode_mvm_start,				\
-	.stop = iwl_op_mode_mvm_stop
+	.stop = iwl_op_mode_mvm_stop,				\
+	.time_point = iwl_op_mode_mvm_time_point
 
 static const struct iwl_op_mode_ops iwl_mvm_ops = {
 	IWL_MVM_COMMON_OPS,
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
index 70515550c91e..0e55aacd6175 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
@@ -198,6 +198,10 @@ void iwl_trans_pcie_gen2_stop_device(struct iwl_trans *trans)
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	bool was_in_rfkill;
 
+	iwl_op_mode_time_point(trans->op_mode,
+			       IWL_FW_INI_TIME_POINT_HOST_DEVICE_DISABLE,
+			       NULL);
+
 	mutex_lock(&trans_pcie->mutex);
 	trans_pcie->opmode_down = true;
 	was_in_rfkill = test_bit(STATUS_RFKILL_OPMODE, &trans->status);
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index 88915406eb1e..ce64d9aeb363 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -1380,6 +1380,10 @@ static void iwl_trans_pcie_stop_device(struct iwl_trans *trans)
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	bool was_in_rfkill;
 
+	iwl_op_mode_time_point(trans->op_mode,
+			       IWL_FW_INI_TIME_POINT_HOST_DEVICE_DISABLE,
+			       NULL);
+
 	mutex_lock(&trans_pcie->mutex);
 	trans_pcie->opmode_down = true;
 	was_in_rfkill = test_bit(STATUS_RFKILL_OPMODE, &trans->status);
-- 
2.30.0

