Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBEE7442812
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Nov 2021 08:16:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231303AbhKBHSj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 2 Nov 2021 03:18:39 -0400
Received: from mga02.intel.com ([134.134.136.20]:22772 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231232AbhKBHSh (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 2 Nov 2021 03:18:37 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10155"; a="218394174"
X-IronPort-AV: E=Sophos;i="5.87,202,1631602800"; 
   d="scan'208";a="218394174"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2021 00:16:02 -0700
X-IronPort-AV: E=Sophos;i="5.87,202,1631602800"; 
   d="scan'208";a="638100009"
Received: from egrumbac-mobl1.jer.intel.com ([10.13.16.230])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2021 00:16:01 -0700
From:   Emmanuel Grumbach <emmanuel.grumbach@intel.com>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 5/6] iwlwifi: mvm: add vendor commands needed for iwlmei
Date:   Tue,  2 Nov 2021 09:15:48 +0200
Message-Id: <20211102071549.5833-5-emmanuel.grumbach@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211102071549.5833-1-emmanuel.grumbach@intel.com>
References: <20211102071549.5833-1-emmanuel.grumbach@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add the vendor commands that must be used by the network manager
to allow proper operation of iwlmei.

* Send information on the AP CSME is connected to
* Notify the userspace when roaming is forbidden
* Allow the userspace to require ownership

Co-Developed-by: Ayala Beker <ayala.beker@intel.com>
Signed-off-by: Ayala Beker <ayala.beker@intel.com>
Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

v6: remove the VENDOR_CMDS Kconfig option and make the whole infra
    depend on IWLMEI directly
v7: remove // comments
    remove an unneeded function
---
 .../net/wireless/intel/iwlwifi/mvm/Makefile   |   1 +
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |   2 +
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  20 ++-
 .../wireless/intel/iwlwifi/mvm/vendor-cmd.c   | 151 ++++++++++++++++++
 4 files changed, 168 insertions(+), 6 deletions(-)
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mvm/vendor-cmd.c

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/Makefile b/drivers/net/wireless/intel/iwlwifi/mvm/Makefile
index 75fc2d935e5d..11e814b7cad0 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/Makefile
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/Makefile
@@ -10,5 +10,6 @@ iwlmvm-y += rfi.o
 iwlmvm-$(CONFIG_IWLWIFI_DEBUGFS) += debugfs.o debugfs-vif.o
 iwlmvm-$(CONFIG_IWLWIFI_LEDS) += led.o
 iwlmvm-$(CONFIG_PM) += d3.o
+iwlmvm-$(CONFIG_IWLMEI) += vendor-cmd.o
 
 ccflags-y += -I $(srctree)/$(src)/../
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index c96a0ece8066..9a666cc259f4 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -720,6 +720,8 @@ int iwl_mvm_mac_setup_register(struct iwl_mvm *mvm)
 		wiphy_ext_feature_set(hw->wiphy,
 				      NL80211_EXT_FEATURE_PROTECTED_TWT);
 
+	iwl_mvm_vendor_cmds_register(mvm);
+
 	hw->wiphy->available_antennas_tx = iwl_mvm_get_valid_tx_ant(mvm);
 	hw->wiphy->available_antennas_rx = iwl_mvm_get_valid_rx_ant(mvm);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 515591b29b0c..34b4a280a293 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1959,6 +1959,17 @@ void iwl_mvm_enter_ctkill(struct iwl_mvm *mvm);
 int iwl_mvm_send_temp_report_ths_cmd(struct iwl_mvm *mvm);
 int iwl_mvm_ctdp_command(struct iwl_mvm *mvm, u32 op, u32 budget);
 
+#if IS_ENABLED(CONFIG_IWLMEI)
+
+/* vendor commands */
+void iwl_mvm_vendor_cmds_register(struct iwl_mvm *mvm);
+
+#else
+
+static inline void iwl_mvm_vendor_cmds_register(struct iwl_mvm *mvm) {}
+
+#endif
+
 /* Location Aware Regulatory */
 struct iwl_mcc_update_resp *
 iwl_mvm_update_mcc(struct iwl_mvm *mvm, const char *alpha2,
@@ -2213,11 +2224,8 @@ static inline void iwl_mvm_mei_set_sw_rfkill_state(struct iwl_mvm *mvm, bool sw_
 		iwl_mei_set_rfkill_state(iwl_mvm_is_radio_killed(mvm), sw_rfkill);
 }
 
-static inline void iwl_mvm_send_roaming_forbidden_event(struct iwl_mvm *mvm,
-							struct ieee80211_vif *vif,
-							bool forbidden)
-{
-	/* TODO */
-}
+void iwl_mvm_send_roaming_forbidden_event(struct iwl_mvm *mvm,
+					  struct ieee80211_vif *vif,
+					  bool forbidden);
 
 #endif /* __IWL_MVM_H__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/vendor-cmd.c b/drivers/net/wireless/intel/iwlwifi/mvm/vendor-cmd.c
new file mode 100644
index 000000000000..f702ad85e609
--- /dev/null
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/vendor-cmd.c
@@ -0,0 +1,151 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2021 Intel Corporation
+ */
+#include "mvm.h"
+#include <linux/nl80211-vnd-intel.h>
+
+static const struct nla_policy
+iwl_mvm_vendor_attr_policy[NUM_IWL_MVM_VENDOR_ATTR] = {
+	[IWL_MVM_VENDOR_ATTR_ROAMING_FORBIDDEN] = { .type = NLA_U8 },
+	[IWL_MVM_VENDOR_ATTR_AUTH_MODE] = { .type = NLA_U32 },
+	[IWL_MVM_VENDOR_ATTR_CHANNEL_NUM] = { .type = NLA_U8 },
+	[IWL_MVM_VENDOR_ATTR_SSID] = { .type = NLA_BINARY,
+				       .len = IEEE80211_MAX_SSID_LEN },
+	[IWL_MVM_VENDOR_ATTR_BAND] = { .type = NLA_U8 },
+	[IWL_MVM_VENDOR_ATTR_COLLOC_CHANNEL] = { .type = NLA_U8 },
+	[IWL_MVM_VENDOR_ATTR_COLLOC_ADDR] = { .type = NLA_BINARY, .len = ETH_ALEN },
+};
+
+static int iwl_mvm_vendor_get_csme_conn_info(struct wiphy *wiphy,
+					     struct wireless_dev *wdev,
+					     const void *data, int data_len)
+{
+	struct ieee80211_hw *hw = wiphy_to_ieee80211_hw(wiphy);
+	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
+	struct iwl_mvm_csme_conn_info *csme_conn_info;
+	struct sk_buff *skb;
+	int err = 0;
+
+	mutex_lock(&mvm->mutex);
+	csme_conn_info = iwl_mvm_get_csme_conn_info(mvm);
+
+	if (!csme_conn_info) {
+		err = -EINVAL;
+		goto out_unlock;
+	}
+
+	skb = cfg80211_vendor_cmd_alloc_reply_skb(wiphy, 200);
+	if (!skb) {
+		err = -ENOMEM;
+		goto out_unlock;
+	}
+
+	if (nla_put_u32(skb, IWL_MVM_VENDOR_ATTR_AUTH_MODE,
+			csme_conn_info->conn_info.auth_mode) ||
+	    nla_put(skb, IWL_MVM_VENDOR_ATTR_SSID,
+		    csme_conn_info->conn_info.ssid_len,
+		    csme_conn_info->conn_info.ssid) ||
+	    nla_put_u32(skb, IWL_MVM_VENDOR_ATTR_STA_CIPHER,
+			csme_conn_info->conn_info.pairwise_cipher) ||
+	    nla_put_u8(skb, IWL_MVM_VENDOR_ATTR_CHANNEL_NUM,
+		       csme_conn_info->conn_info.channel) ||
+	    nla_put(skb, IWL_MVM_VENDOR_ATTR_ADDR, ETH_ALEN,
+		    csme_conn_info->conn_info.bssid)) {
+		kfree_skb(skb);
+		err = -ENOBUFS;
+	}
+
+out_unlock:
+	mutex_unlock(&mvm->mutex);
+	if (err)
+		return err;
+
+	return cfg80211_vendor_cmd_reply(skb);
+}
+
+static int iwl_mvm_vendor_host_get_ownership(struct wiphy *wiphy,
+					     struct wireless_dev *wdev,
+					     const void *data, int data_len)
+{
+	struct ieee80211_hw *hw = wiphy_to_ieee80211_hw(wiphy);
+	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
+
+	mutex_lock(&mvm->mutex);
+	iwl_mvm_mei_get_ownership(mvm);
+	mutex_unlock(&mvm->mutex);
+
+	return 0;
+}
+
+static const struct wiphy_vendor_command iwl_mvm_vendor_commands[] = {
+	{
+		.info = {
+			.vendor_id = INTEL_OUI,
+			.subcmd = IWL_MVM_VENDOR_CMD_GET_CSME_CONN_INFO,
+		},
+		.doit = iwl_mvm_vendor_get_csme_conn_info,
+		.flags = WIPHY_VENDOR_CMD_NEED_WDEV,
+		.policy = iwl_mvm_vendor_attr_policy,
+		.maxattr = MAX_IWL_MVM_VENDOR_ATTR,
+	},
+	{
+		.info = {
+			.vendor_id = INTEL_OUI,
+			.subcmd = IWL_MVM_VENDOR_CMD_HOST_GET_OWNERSHIP,
+		},
+		.doit = iwl_mvm_vendor_host_get_ownership,
+		.flags = WIPHY_VENDOR_CMD_NEED_WDEV,
+		.policy = iwl_mvm_vendor_attr_policy,
+		.maxattr = MAX_IWL_MVM_VENDOR_ATTR,
+	},
+};
+
+enum iwl_mvm_vendor_events_idx {
+        /* 0x0 - 0x3 are deprecated */
+        IWL_MVM_VENDOR_EVENT_IDX_ROAMING_FORBIDDEN = 4,
+        NUM_IWL_MVM_VENDOR_EVENT_IDX
+};
+
+static const struct nl80211_vendor_cmd_info
+iwl_mvm_vendor_events[NUM_IWL_MVM_VENDOR_EVENT_IDX] = {
+	[IWL_MVM_VENDOR_EVENT_IDX_ROAMING_FORBIDDEN] = {
+		.vendor_id = INTEL_OUI,
+		.subcmd = IWL_MVM_VENDOR_CMD_ROAMING_FORBIDDEN_EVENT,
+	},
+};
+
+void iwl_mvm_vendor_cmds_register(struct iwl_mvm *mvm)
+{
+	mvm->hw->wiphy->vendor_commands = iwl_mvm_vendor_commands;
+	mvm->hw->wiphy->n_vendor_commands = ARRAY_SIZE(iwl_mvm_vendor_commands);
+	mvm->hw->wiphy->vendor_events = iwl_mvm_vendor_events;
+	mvm->hw->wiphy->n_vendor_events = ARRAY_SIZE(iwl_mvm_vendor_events);
+}
+
+void iwl_mvm_send_roaming_forbidden_event(struct iwl_mvm *mvm,
+					  struct ieee80211_vif *vif,
+					  bool forbidden)
+{
+	struct sk_buff *msg =
+		cfg80211_vendor_event_alloc(mvm->hw->wiphy,
+					    ieee80211_vif_to_wdev(vif),
+					    200, IWL_MVM_VENDOR_EVENT_IDX_ROAMING_FORBIDDEN,
+					    GFP_ATOMIC);
+	if (!msg)
+		return;
+
+	if (WARN_ON(!vif))
+		return;
+
+	if (nla_put(msg, IWL_MVM_VENDOR_ATTR_VIF_ADDR,
+		    ETH_ALEN, vif->addr) ||
+	    nla_put_u8(msg, IWL_MVM_VENDOR_ATTR_ROAMING_FORBIDDEN, forbidden))
+		goto nla_put_failure;
+
+	cfg80211_vendor_event(msg, GFP_ATOMIC);
+	return;
+
+ nla_put_failure:
+	kfree_skb(msg);
+}
-- 
2.25.1

