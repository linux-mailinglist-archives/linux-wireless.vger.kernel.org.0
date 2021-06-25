Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACAAF3B3E5A
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Jun 2021 10:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbhFYIT7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Jun 2021 04:19:59 -0400
Received: from mga06.intel.com ([134.134.136.31]:61745 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230108AbhFYIT6 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Jun 2021 04:19:58 -0400
IronPort-SDR: VB7emQTcwQi5u5htPHxheSl+Dhmca/Zt2FBpgoyl2s/SwWKf77ZbtPVzE0hTKmuHQZPJuxmRNa
 ol9jPe7McvEA==
X-IronPort-AV: E=McAfee;i="6200,9189,10025"; a="268762122"
X-IronPort-AV: E=Sophos;i="5.83,298,1616482800"; 
   d="scan'208";a="268762122"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2021 01:17:38 -0700
IronPort-SDR: 6LwvqcDFeFoiPWad/GUdjDULqhljtoSbv/wmY6JO/6iRE5GJ+fjKy1HvSqz694Y7zLRDB6jfT7
 ZRVUKn/4Ng5g==
X-IronPort-AV: E=Sophos;i="5.83,298,1616482800"; 
   d="scan'208";a="488095809"
Received: from nambar-mobl1.ger.corp.intel.com (HELO egrumbac-mobl1.intel.com) ([10.255.196.185])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2021 01:17:36 -0700
From:   Emmanuel Grumbach <emmanuel.grumbach@intel.com>
To:     luciano.coelho@intel.com, kvalo@codeaurora.org,
        linux-wireless@vger.kernel.org
Cc:     egrumbach@gmail.com,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Ayala Beker <ayala.beker@intel.com>
Subject: [PATCH v4 5/5] iwlwifi: mvm: add vendor commands needed for iwlmei
Date:   Fri, 25 Jun 2021 11:17:17 +0300
Message-Id: <20210625081717.7680-5-emmanuel.grumbach@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210625081717.7680-1-emmanuel.grumbach@intel.com>
References: <20210625081717.7680-1-emmanuel.grumbach@intel.com>
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
Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/Kconfig    |  11 ++
 .../net/wireless/intel/iwlwifi/mvm/Makefile   |   1 +
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |   2 +
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |   9 +-
 .../wireless/intel/iwlwifi/mvm/vendor-cmd.c   | 186 ++++++++++++++++++
 5 files changed, 203 insertions(+), 6 deletions(-)
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mvm/vendor-cmd.c

diff --git a/drivers/net/wireless/intel/iwlwifi/Kconfig b/drivers/net/wireless/intel/iwlwifi/Kconfig
index 629aaa26a230..f91516d08b28 100644
--- a/drivers/net/wireless/intel/iwlwifi/Kconfig
+++ b/drivers/net/wireless/intel/iwlwifi/Kconfig
@@ -92,11 +92,22 @@ config IWLWIFI_BCAST_FILTERING
 	  If unsure, don't enable this option, as some programs might
 	  expect incoming broadcasts for their normal operations.
 
+config IWLMVM_VENDOR_CMDS
+	bool "Enable vendor commands"
+	depends on IWLMVM
+	help
+	  This option enables support for vendor commands, including some
+	  that don't have their own Kconfig option. Other Kconfig options
+	  depend on this one as well.
+
+	  This is not enabled by default, if unsure, say N.
+
 config IWLMEI
 	tristate "Intel Management Engine communication over WLAN"
 	depends on INTEL_MEI
 	depends on PM
 	depends on IWLMVM
+	select IWLMVM_VENDOR_CMDS
 	help
 	  Enables the iwlmei kernel module. This allows to communicate with
 	  the Intel Management Engine over Wifi. This is supported starting
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/Makefile b/drivers/net/wireless/intel/iwlwifi/mvm/Makefile
index 75fc2d935e5d..02078069d33d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/Makefile
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/Makefile
@@ -10,5 +10,6 @@ iwlmvm-y += rfi.o
 iwlmvm-$(CONFIG_IWLWIFI_DEBUGFS) += debugfs.o debugfs-vif.o
 iwlmvm-$(CONFIG_IWLWIFI_LEDS) += led.o
 iwlmvm-$(CONFIG_PM) += d3.o
+iwlmvm-$(CONFIG_IWLMVM_VENDOR_CMDS) += vendor-cmd.o
 
 ccflags-y += -I $(srctree)/$(src)/../
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index c5a5c020f5da..af32a7263e17 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -719,6 +719,8 @@ int iwl_mvm_mac_setup_register(struct iwl_mvm *mvm)
 		wiphy_ext_feature_set(hw->wiphy,
 				      NL80211_EXT_FEATURE_PROTECTED_TWT);
 
+	iwl_mvm_vendor_cmds_register(mvm);
+
 	hw->wiphy->available_antennas_tx = iwl_mvm_get_valid_tx_ant(mvm);
 	hw->wiphy->available_antennas_rx = iwl_mvm_get_valid_rx_ant(mvm);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index e5b369e5874a..bd8e00ae15fb 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -2216,11 +2216,8 @@ static inline void iwl_mvm_mei_set_sw_rfkill_state(struct iwl_mvm *mvm, bool sw_
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
index 000000000000..97e8885f1483
--- /dev/null
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/vendor-cmd.c
@@ -0,0 +1,186 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2012-2014, 2018-2021 Intel Corporation
+ * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
+ * Copyright (C) 2016-2017 Intel Deutschland GmbH
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
+__maybe_unused static struct nlattr **
+iwl_mvm_parse_vendor_data(const void *data, int data_len)
+{
+	struct nlattr **tb;
+	int err;
+
+	if (!data)
+		return ERR_PTR(-EINVAL);
+
+	tb = kcalloc(MAX_IWL_MVM_VENDOR_ATTR + 1, sizeof(*tb), GFP_KERNEL);
+	if (!tb)
+		return ERR_PTR(-ENOMEM);
+
+	err = nla_parse(tb, MAX_IWL_MVM_VENDOR_ATTR, data, data_len,
+			iwl_mvm_vendor_attr_policy, NULL);
+	if (err) {
+		kfree(tb);
+		return ERR_PTR(err);
+	}
+
+	return tb;
+}
+
+#if IS_ENABLED(CONFIG_IWLMEI)
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
+#endif
+
+static const struct wiphy_vendor_command iwl_mvm_vendor_commands[] = {
+#if IS_ENABLED(CONFIG_IWLMEI)
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
+#endif
+};
+
+enum iwl_mvm_vendor_events_idx {
+        /* 0x0 - 0x3 are deprecated */
+#if IS_ENABLED(CONFIG_IWLMEI)
+        IWL_MVM_VENDOR_EVENT_IDX_ROAMING_FORBIDDEN = 4,
+#endif
+        NUM_IWL_MVM_VENDOR_EVENT_IDX
+};
+
+static const struct nl80211_vendor_cmd_info
+iwl_mvm_vendor_events[NUM_IWL_MVM_VENDOR_EVENT_IDX] = {
+#if IS_ENABLED(CONFIG_IWLMEI)
+	[IWL_MVM_VENDOR_EVENT_IDX_ROAMING_FORBIDDEN] = {
+		.vendor_id = INTEL_OUI,
+		.subcmd = IWL_MVM_VENDOR_CMD_ROAMING_FORBIDDEN_EVENT,
+	},
+#endif
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
+#if IS_ENABLED(CONFIG_IWLMEI)
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
+#endif
-- 
2.25.1

