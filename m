Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3ECDD50FD
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Oct 2019 18:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729409AbfJLQ3d (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 12 Oct 2019 12:29:33 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:48744 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727423AbfJLQ3c (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 12 Oct 2019 12:29:32 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1iJKGo-00062r-Lb; Sat, 12 Oct 2019 19:29:31 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sat, 12 Oct 2019 19:29:13 +0300
Message-Id: <20191012192536.b19d3eee1f27.I93055bd331b9a3b609ea3f1a2ffcf42607bccb48@changeid>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191012162924.19848-1-luca@coelho.fi>
References: <20191012162924.19848-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH 02/13] iwlwifi: mvm: add support for new version for D0I3_END_CMD
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Haim Dreyfuss <haim.dreyfuss@intel.com>

During D3 state there are some flows which requires FW reset.
Add new API to support it.

Signed-off-by: Haim Dreyfuss <haim.dreyfuss@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/fw/api/d3.h    |  8 +++++
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   | 29 ++++++++++++++++++-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  4 +++
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  | 27 +++++++++++++++++
 4 files changed, 67 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h b/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h
index 4c3219e7beb6..3643b6ba6385 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h
@@ -64,6 +64,14 @@
 #ifndef __iwl_fw_api_d3_h__
 #define __iwl_fw_api_d3_h__
 
+/**
+ * enum iwl_d0i3_flags - d0i3 flags
+ * @IWL_D0I3_RESET_REQUIRE: FW require reset upon resume
+ */
+enum iwl_d0i3_flags {
+	IWL_D0I3_RESET_REQUIRE = BIT(0),
+};
+
 /**
  * enum iwl_d3_wakeup_flags - D3 manager wakeup flags
  * @IWL_WAKEUP_D3_CONFIG_FW_ERROR: wake up on firmware sysassert
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index 86c2c587e755..1a9d83d6230f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -1955,12 +1955,39 @@ static int __iwl_mvm_resume(struct iwl_mvm *mvm, bool test)
 	}
 
 	if (d0i3_first) {
-		ret = iwl_mvm_send_cmd_pdu(mvm, D0I3_END_CMD, 0, 0, NULL);
+		struct iwl_host_cmd cmd = {
+			.id = D0I3_END_CMD,
+			.flags = CMD_WANT_SKB,
+		};
+		int len;
+
+		ret = iwl_mvm_send_cmd(mvm, &cmd);
 		if (ret < 0) {
 			IWL_ERR(mvm, "Failed to send D0I3_END_CMD first (%d)\n",
 				ret);
 			goto err;
 		}
+		switch (mvm->cmd_ver.d0i3_resp) {
+		case 0:
+			break;
+		case 1:
+			len = iwl_rx_packet_payload_len(cmd.resp_pkt);
+			if (len != sizeof(u32)) {
+				IWL_ERR(mvm,
+					"Error with D0I3_END_CMD response size (%d)\n",
+					len);
+				goto err;
+			}
+			if (IWL_D0I3_RESET_REQUIRE &
+			    le32_to_cpu(*(__le32 *)cmd.resp_pkt->data)) {
+				iwl_write32(mvm->trans, CSR_RESET,
+					    CSR_RESET_REG_FLAG_FORCE_NMI);
+				iwl_free_resp(&cmd);
+			}
+			break;
+		default:
+			WARN_ON(1);
+		}
 	}
 
 	/*
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 843d00bf2bd5..43257579ab48 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1122,6 +1122,10 @@ struct iwl_mvm {
 		int responses[IWL_MVM_TOF_MAX_APS];
 	} ftm_initiator;
 
+	struct {
+		u8 d0i3_resp;
+	} cmd_ver;
+
 	struct ieee80211_vif *nan_vif;
 #define IWL_MAX_BAID	32
 	struct iwl_mvm_baid_data __rcu *baid_map[IWL_MAX_BAID];
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 3acbd5b7ab4b..cc4b5554c715 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -608,6 +608,27 @@ static const struct iwl_fw_runtime_ops iwl_mvm_fwrt_ops = {
 	.d3_debug_enable = iwl_mvm_d3_debug_enable,
 };
 
+static u8 iwl_mvm_lookup_notif_ver(struct iwl_mvm *mvm, u8 grp, u8 cmd, u8 def)
+{
+	const struct iwl_fw_cmd_version *entry;
+	unsigned int i;
+
+	if (!mvm->fw->ucode_capa.cmd_versions ||
+	    !mvm->fw->ucode_capa.n_cmd_versions)
+		return def;
+
+	entry = mvm->fw->ucode_capa.cmd_versions;
+	for (i = 0; i < mvm->fw->ucode_capa.n_cmd_versions; i++, entry++) {
+		if (entry->group == grp && entry->cmd == cmd) {
+			if (entry->notif_ver == IWL_FW_CMD_VER_UNKNOWN)
+				return def;
+			return entry->notif_ver;
+		}
+	}
+
+	return def;
+}
+
 static struct iwl_op_mode *
 iwl_op_mode_mvm_start(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 		      const struct iwl_fw *fw, struct dentry *dbgfs_dir)
@@ -722,6 +743,12 @@ iwl_op_mode_mvm_start(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 
 	INIT_DELAYED_WORK(&mvm->cs_tx_unblock_dwork, iwl_mvm_tx_unblock_dwork);
 
+	mvm->cmd_ver.d0i3_resp =
+		iwl_mvm_lookup_notif_ver(mvm, LEGACY_GROUP, D0I3_END_CMD, 0);
+	/* we only support version 1 */
+	if (WARN_ON_ONCE(mvm->cmd_ver.d0i3_resp > 1))
+		goto out_free;
+
 	/*
 	 * Populate the state variables that the transport layer needs
 	 * to know about.
-- 
2.23.0

