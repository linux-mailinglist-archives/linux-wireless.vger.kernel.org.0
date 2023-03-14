Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74D516B9D88
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Mar 2023 18:52:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbjCNRwN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Mar 2023 13:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbjCNRwM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Mar 2023 13:52:12 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85008B4831
        for <linux-wireless@vger.kernel.org>; Tue, 14 Mar 2023 10:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678816302; x=1710352302;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rKAtKvdIoEMnSkO1Jcr0alrSohi48Q4nD4uc7EfAblE=;
  b=JujEf88/xX9G4XbZ2wv8DyJPlUFyFbFap/vyPDF10cShxskMOvAwfXU3
   NZKhoGBSHhhLMTtd37aD6AX0KDs6Oy05fv64g0wGBpDSsjL1dZZ46MLo6
   Ij1l1CXGFG1K+UQDAl3hn7HeTNbHa+rYgokApomc6brc4Khc+mb1Q/qf4
   sobjW0I6QZmEh2adop2GkM9LB5K/snPym3Ymy2rHo6bvGdTXTCK8cCAab
   C/s+zaKI72yn6nS6+675Tf1mKxJe7VJFiSW/Gmlwlila9eRSDpN8mmIk3
   mcqGCq9LvRT9vtJRf9HfbuJt5VpbGeh41bhxJHpwN30xYczj5LRFYpp+t
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="317149555"
X-IronPort-AV: E=Sophos;i="5.98,260,1673942400"; 
   d="scan'208";a="317149555"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2023 10:50:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="768200521"
X-IronPort-AV: E=Sophos;i="5.98,260,1673942400"; 
   d="scan'208";a="768200521"
Received: from litalcoh-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.192.4])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2023 10:50:08 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Miri Korenblit <miriam.rachel.korenblit@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 08/22] wifi: iwlwifi: mvm: add support for the new STA related commands
Date:   Tue, 14 Mar 2023 19:49:20 +0200
Message-Id: <20230314194113.132873ce015c.I7b12a77e5be066730762e6ceeeaa7190293c3df1@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230314174934.893149-1-gregory.greenman@intel.com>
References: <20230314174934.893149-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Miri Korenblit <miriam.rachel.korenblit@intel.com>

As a part of the new MLD FW API changes, we have new commands for STA
related operations (add/remove/aux/disable tx).
Add structures and enum definitions, along with part of the functions
that sends this commands.
This functions will be in used and more will be added in the next patches.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../wireless/intel/iwlwifi/fw/api/mac-cfg.h   | 128 ++++++++
 .../net/wireless/intel/iwlwifi/mvm/Makefile   |   2 +-
 .../net/wireless/intel/iwlwifi/mvm/mld-sta.c  | 281 ++++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |   4 +
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c  |   8 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.h  |  16 +-
 6 files changed, 431 insertions(+), 8 deletions(-)
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h b/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
index 301f34f13523..a111e7366d49 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
@@ -41,6 +41,22 @@ enum iwl_mac_conf_subcmd_ids {
 	 * @LINK_CONFIG_CMD: &struct iwl_link_config_cmd
 	 */
 	LINK_CONFIG_CMD = 0x9,
+	/**
+	 * @STA_CONFIG_CMD: &struct iwl_mvm_sta_cfg_cmd
+	 */
+	STA_CONFIG_CMD = 0xA,
+	/**
+	 * @AUX_STA_CMD: &struct iwl_mvm_aux_sta_cmd
+	 */
+	AUX_STA_CMD = 0xB,
+	/**
+	 * @STA_REMOVE_CMD: &struct iwl_mvm_remove_sta_cmd
+	 */
+	STA_REMOVE_CMD = 0xC,
+	/**
+	 * @STA_DISABLE_TX_CMD: &struct iwl_mvm_sta_disable_tx_cmd
+	 */
+	STA_DISABLE_TX_CMD = 0xD,
 	/**
 	 * @SESSION_PROTECTION_NOTIF: &struct iwl_mvm_session_prot_notif
 	 */
@@ -466,4 +482,116 @@ struct iwl_link_config_cmd {
 	u8 reserved[2];
 } __packed; /* LINK_CONTEXT_CONFIG_CMD_API_S_VER_1 */
 
+/**
+ * enum iwl_fw_sta_type - FW station types
+ * @STATION_TYPE_PEER: represents a peer - AP in BSS, a TDLS sta, a client in
+ *	P2P.
+ * @STATION_TYPE_BCAST_MGMT: The station used to send beacons and
+ *	probe responses. Also used for traffic injection in sniffer mode
+ * @STATION_TYPE_MCAST: the station used for BCAST / MCAST in GO. Will be
+ *	suspended / resumed at the right timing depending on the clients'
+ *	power save state and the DTIM timing
+ */
+enum iwl_fw_sta_type {
+	STATION_TYPE_PEER,
+	STATION_TYPE_BCAST_MGMT,
+	STATION_TYPE_MCAST,
+}; /* STATION_TYPE_E_VER_1 */
+
+/**
+ * struct iwl_mvm_sta_cfg_cmd - cmd structure to add a peer sta to the uCode's
+ *	station table
+ * ( STA_CONFIG_CMD = 0xA )
+ *
+ * @sta_id: index of station in uCode's station table
+ * @link_id: the id of the link that is used to communicate with this sta
+ * @peer_mld_address: the peers mld address
+ * @reserved_for_peer_mld_address: reserved
+ * @peer_link_address: the address of the link that is used to communicate
+ *	with this sta
+ * @reserved_for_peer_link_address: reserved
+ * @station_type: type of this station. See &enum iwl_fw_sta_type
+ * @assoc_id: for GO only
+ * @beamform_flags: beam forming controls
+ * @mfp: indicates whether the STA uses management frame protection or not.
+ * @mimo: indicates whether the sta uses mimo or not
+ * @mimo_protection: indicates whether the sta uses mimo protection or not
+ * @ack_enabled: indicates that the AP supports receiving ACK-
+ *	enabled AGG, i.e. both BACK and non-BACK frames in a single AGG
+ * @trig_rnd_alloc: indicates that trigger based random allocation
+ *	is enabled according to UORA element existence
+ * @tx_ampdu_spacing: minimum A-MPDU spacing:
+ *	4 - 2us density, 5 - 4us density, 6 - 8us density, 7 - 16us density
+ * @tx_ampdu_max_size: maximum A-MPDU length: 0 - 8K, 1 - 16K, 2 - 32K,
+ *	3 - 64K, 4 - 128K, 5 - 256K, 6 - 512K, 7 - 1024K.
+ * @sp_length: the size of the SP in actual number of frames
+ * @uapsd_acs:  4 LS bits are trigger enabled ACs, 4 MS bits are the deliver
+ *	enabled ACs.
+ * @pkt_ext: optional, exists according to PPE-present bit in the HE/EHT-PHY
+ *	capa
+ * @htc_flags: which features are supported in HTC
+ */
+struct iwl_mvm_sta_cfg_cmd {
+	__le32 sta_id;
+	__le32 link_id;
+	u8 peer_mld_address[ETH_ALEN];
+	__le16 reserved_for_peer_mld_address;
+	u8 peer_link_address[ETH_ALEN];
+	__le16 reserved_for_peer_link_address;
+	__le32 station_type;
+	__le32 assoc_id;
+	__le32 beamform_flags;
+	__le32 mfp;
+	__le32 mimo;
+	__le32 mimo_protection;
+	__le32 ack_enabled;
+	__le32 trig_rnd_alloc;
+	__le32 tx_ampdu_spacing;
+	__le32 tx_ampdu_max_size;
+	__le32 sp_length;
+	__le32 uapsd_acs;
+	struct iwl_he_pkt_ext_v2 pkt_ext;
+	__le32 htc_flags;
+} __packed; /* STA_CMD_API_S_VER_1 */
+
+/**
+ * struct iwl_mvm_aux_sta_cmd - command for AUX STA configuration
+ * ( AUX_STA_CMD = 0xB )
+ *
+ * @sta_id: index of aux sta to configure
+ * @lmac_id: ?
+ * @mac_addr: mac addr of the auxilary sta
+ * @reserved_for_mac_addr: reserved
+ */
+struct iwl_mvm_aux_sta_cmd {
+	__le32 sta_id;
+	__le32 lmac_id;
+	u8 mac_addr[ETH_ALEN];
+	__le16 reserved_for_mac_addr;
+
+} __packed; /* AUX_STA_CMD_API_S_VER_1 */
+
+/**
+ * struct iwl_mvm_remove_sta_cmd - a cmd structure to remove a sta added by
+ *	STA_CONFIG_CMD or AUX_STA_CONFIG_CMD
+ * ( STA_REMOVE_CMD = 0xC )
+ *
+ * @sta_id: index of station to remove
+ */
+struct iwl_mvm_remove_sta_cmd {
+	__le32 sta_id;
+} __packed; /* REMOVE_STA_API_S_VER_1 */
+
+/**
+ * struct iwl_mvm_sta_disable_tx_cmd - disable / re-enable tx to a sta
+ * ( STA_DISABLE_TX_CMD = 0xD )
+ *
+ * @sta_id: index of the station to disable tx to
+ * @disable: indicates if to disable or re-enable tx
+ */
+struct iwl_mvm_sta_disable_tx_cmd {
+	__le32 sta_id;
+	__le32 disable;
+} __packed; /* STA_DISABLE_TX_API_S_VER_1 */
+
 #endif /* __iwl_fw_api_mac_cfg_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/Makefile b/drivers/net/wireless/intel/iwlwifi/mvm/Makefile
index ec6346c6c8e4..0e9b5381e265 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/Makefile
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/Makefile
@@ -7,7 +7,7 @@ iwlmvm-y += power.o coex.o
 iwlmvm-y += tt.o offloading.o tdls.o
 iwlmvm-y += ftm-responder.o ftm-initiator.o
 iwlmvm-y += rfi.o
-iwlmvm-y += mld-key.o mld-mac.o link.o
+iwlmvm-y += mld-key.o mld-mac.o link.o mld-sta.o
 iwlmvm-$(CONFIG_IWLWIFI_DEBUGFS) += debugfs.o debugfs-vif.o
 iwlmvm-$(CONFIG_IWLWIFI_LEDS) += led.o
 iwlmvm-$(CONFIG_PM) += d3.o
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
new file mode 100644
index 000000000000..cef4fc441afe
--- /dev/null
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
@@ -0,0 +1,281 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * Copyright (C) 2022 Intel Corporation
+ */
+#include "mvm.h"
+
+static int iwl_mvm_mld_send_sta_cmd(struct iwl_mvm *mvm,
+				    struct iwl_mvm_sta_cfg_cmd *cmd)
+{
+	int ret = iwl_mvm_send_cmd_pdu(mvm,
+				       WIDE_ID(MAC_CONF_GROUP, STA_CONFIG_CMD),
+				       0, sizeof(*cmd), cmd);
+	if (ret)
+		IWL_ERR(mvm, "STA_CONFIG_CMD send failed, ret=0x%x\n", ret);
+	return ret;
+}
+
+/*
+ * Add an internal station to the FW table
+ */
+static int iwl_mvm_mld_add_int_sta_to_fw(struct iwl_mvm *mvm,
+					 struct iwl_mvm_int_sta *sta,
+					 const u8 *addr,
+					 u16 phy_id)
+{
+	struct iwl_mvm_sta_cfg_cmd cmd;
+
+	lockdep_assert_held(&mvm->mutex);
+
+	memset(&cmd, 0, sizeof(cmd));
+	cmd.sta_id = cpu_to_le32((u8)sta->sta_id);
+
+	cmd.link_id = cpu_to_le32(phy_id);
+
+	cmd.station_type = cpu_to_le32(sta->type);
+
+	if (addr) {
+		memcpy(cmd.peer_mld_address, addr, ETH_ALEN);
+		memcpy(cmd.peer_link_address, addr, ETH_ALEN);
+	}
+
+	return iwl_mvm_mld_send_sta_cmd(mvm, &cmd);
+}
+
+/*
+ * Remove a station from the FW table. Before sending the command to remove
+ * the station validate that the station is indeed known to the driver (sanity
+ * only).
+ */
+static int iwl_mvm_mld_rm_sta_from_fw(struct iwl_mvm *mvm, u32 sta_id)
+{
+	struct ieee80211_sta *sta;
+	struct iwl_mvm_remove_sta_cmd rm_sta_cmd = {
+		.sta_id = cpu_to_le32(sta_id),
+	};
+	int ret;
+
+	sta = rcu_dereference_protected(mvm->fw_id_to_mac_id[sta_id],
+					lockdep_is_held(&mvm->mutex));
+
+	/* Note: internal stations are marked as error values */
+	if (!sta) {
+		IWL_ERR(mvm, "Invalid station id\n");
+		return -EINVAL;
+	}
+
+	ret = iwl_mvm_send_cmd_pdu(mvm, WIDE_ID(MAC_CONF_GROUP, STA_REMOVE_CMD),
+				   0, sizeof(rm_sta_cmd), &rm_sta_cmd);
+	if (ret) {
+		IWL_ERR(mvm, "Failed to remove station. Id=%d\n", sta_id);
+		return ret;
+	}
+
+	return 0;
+}
+
+/*
+ * Adds an internal sta to the FW table with its queues
+ */
+static int iwl_mvm_mld_add_int_sta_with_queue(struct iwl_mvm *mvm,
+					      struct iwl_mvm_int_sta *sta,
+					      const u8 *addr, int phy_id,
+					      u16 *queue, u8 tid,
+					      unsigned int *_wdg_timeout)
+{
+	int ret, txq;
+	unsigned int wdg_timeout = _wdg_timeout ? *_wdg_timeout :
+		mvm->trans->trans_cfg->base_params->wd_timeout;
+
+	if (WARN_ON_ONCE(sta->sta_id == IWL_MVM_INVALID_STA))
+		return -ENOSPC;
+
+	ret = iwl_mvm_mld_add_int_sta_to_fw(mvm, sta, addr, phy_id);
+	if (ret)
+		return ret;
+
+	/*
+	 * For 22000 firmware and on we cannot add queue to a station unknown
+	 * to firmware so enable queue here - after the station was added
+	 */
+	txq = iwl_mvm_tvqm_enable_txq(mvm, NULL, sta->sta_id, tid,
+				      wdg_timeout);
+	if (txq < 0) {
+		iwl_mvm_mld_rm_sta_from_fw(mvm, sta->sta_id);
+		return txq;
+	}
+	*queue = txq;
+
+	return 0;
+}
+
+/*
+ * Adds a new int sta: allocate it in the driver, add it to the FW table,
+ * and add its queues.
+ */
+static int iwl_mvm_mld_add_int_sta(struct iwl_mvm *mvm,
+				   struct iwl_mvm_int_sta *int_sta, u16 *queue,
+				   enum nl80211_iftype iftype,
+				   enum iwl_fw_sta_type sta_type,
+				   int phy_id, const u8 *addr, u8 tid,
+				   unsigned int *wdg_timeout)
+{
+	int ret;
+
+	lockdep_assert_held(&mvm->mutex);
+
+	/* qmask argument is not used in the new tx api, send a don't care */
+	ret = iwl_mvm_allocate_int_sta(mvm, int_sta, 0, iftype,
+				       sta_type);
+	if (ret)
+		return ret;
+
+	ret = iwl_mvm_mld_add_int_sta_with_queue(mvm, int_sta, addr, phy_id,
+						 queue, tid, wdg_timeout);
+	if (ret) {
+		iwl_mvm_dealloc_int_sta(mvm, int_sta);
+		return ret;
+	}
+
+	return 0;
+}
+
+/* Allocate a new station entry for the broadcast station to the given vif,
+ * and send it to the FW.
+ * Note that each P2P mac should have its own broadcast station.
+ */
+int iwl_mvm_mld_add_bcast_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
+{
+	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+	struct iwl_mvm_int_sta *bsta = &mvmvif->bcast_sta;
+	static const u8 _baddr[] = {0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF};
+	const u8 *baddr = _baddr;
+	unsigned int wdg_timeout =
+		iwl_mvm_get_wd_timeout(mvm, vif, false, false);
+	u16 *queue;
+
+	lockdep_assert_held(&mvm->mutex);
+
+	if (vif->type == NL80211_IFTYPE_ADHOC)
+		baddr = vif->bss_conf.bssid;
+
+	if (vif->type == NL80211_IFTYPE_AP ||
+	    vif->type == NL80211_IFTYPE_ADHOC) {
+		queue = &mvm->probe_queue;
+	} else if (vif->type == NL80211_IFTYPE_P2P_DEVICE) {
+		queue = &mvm->p2p_dev_queue;
+	} else {
+		WARN(1, "Missing required TXQ for adding bcast STA\n");
+		return -EINVAL;
+	}
+
+	return iwl_mvm_mld_add_int_sta(mvm, bsta, queue,
+				       ieee80211_vif_type_p2p(vif),
+				       STATION_TYPE_BCAST_MGMT,
+				       mvmvif->phy_ctxt->id, baddr,
+				       IWL_MAX_TID_COUNT, &wdg_timeout);
+}
+
+/* Allocate a new station entry for the sniffer station to the given vif,
+ * and send it to the FW.
+ */
+int iwl_mvm_mld_add_snif_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
+{
+	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+
+	lockdep_assert_held(&mvm->mutex);
+
+	return iwl_mvm_mld_add_int_sta(mvm, &mvm->snif_sta, &mvm->snif_queue,
+				       vif->type, STATION_TYPE_BCAST_MGMT,
+				       mvmvif->phy_ctxt->id, NULL,
+				       IWL_MAX_TID_COUNT, NULL);
+}
+
+static int iwl_mvm_mld_disable_txq(struct iwl_mvm *mvm,
+				   struct ieee80211_sta *sta,
+				   u16 *queueptr, u8 tid)
+{
+	struct iwl_mvm_sta *mvmsta = iwl_mvm_sta_from_mac80211(sta);
+	int queue = *queueptr;
+	int ret = 0;
+
+	if (mvm->sta_remove_requires_queue_remove) {
+		u32 cmd_id = WIDE_ID(DATA_PATH_GROUP,
+				     SCD_QUEUE_CONFIG_CMD);
+		struct iwl_scd_queue_cfg_cmd remove_cmd = {
+			.operation = cpu_to_le32(IWL_SCD_QUEUE_REMOVE),
+			.u.remove.tid = cpu_to_le32(tid),
+			.u.remove.sta_mask =
+				cpu_to_le32(BIT(mvmsta->sta_id)),
+		};
+
+		ret = iwl_mvm_send_cmd_pdu(mvm, cmd_id, 0,
+					   sizeof(remove_cmd),
+					   &remove_cmd);
+	}
+
+	iwl_trans_txq_free(mvm->trans, queue);
+	*queueptr = IWL_MVM_INVALID_QUEUE;
+
+	return ret;
+}
+
+/* Removes a sta from the FW table, disable its queues, and dealloc it
+ */
+static int iwl_mvm_mld_rm_int_sta(struct iwl_mvm *mvm,
+				  struct iwl_mvm_int_sta *int_sta,
+				  bool flush, u8 tid, u16 *queuptr)
+{
+	int ret;
+
+	lockdep_assert_held(&mvm->mutex);
+
+	if (WARN_ON_ONCE(int_sta->sta_id == IWL_MVM_INVALID_STA))
+		return -EINVAL;
+
+	if (flush)
+		iwl_mvm_flush_sta(mvm, int_sta, true);
+
+	iwl_mvm_mld_disable_txq(mvm, NULL, queuptr, tid);
+
+	ret = iwl_mvm_mld_rm_sta_from_fw(mvm, int_sta->sta_id);
+	if (ret)
+		IWL_WARN(mvm, "Failed sending remove station\n");
+
+	iwl_mvm_dealloc_int_sta(mvm, int_sta);
+
+	return ret;
+}
+
+int iwl_mvm_mld_rm_bcast_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
+{
+	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+	u16 *queueptr;
+
+	lockdep_assert_held(&mvm->mutex);
+
+	switch (vif->type) {
+	case NL80211_IFTYPE_AP:
+	case NL80211_IFTYPE_ADHOC:
+		queueptr = &mvm->probe_queue;
+		break;
+	case NL80211_IFTYPE_P2P_DEVICE:
+		queueptr = &mvm->p2p_dev_queue;
+		break;
+	default:
+		WARN(1, "Can't free bcast queue on vif type %d\n",
+		     vif->type);
+		return -EINVAL;
+	}
+
+	return iwl_mvm_mld_rm_int_sta(mvm, &mvmvif->bcast_sta, true,
+				      IWL_MAX_TID_COUNT, queueptr);
+}
+
+int iwl_mvm_mld_rm_snif_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
+{
+	lockdep_assert_held(&mvm->mutex);
+
+	return iwl_mvm_mld_rm_int_sta(mvm, &mvm->snif_sta, false,
+				      IWL_MAX_TID_COUNT, &mvm->snif_queue);
+}
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index c3767f62026a..03da4e53de67 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -523,6 +523,10 @@ static const struct iwl_hcmd_names iwl_mvm_mac_conf_names[] = {
 	HCMD_NAME(SESSION_PROTECTION_CMD),
 	HCMD_NAME(MAC_CONFIG_CMD),
 	HCMD_NAME(LINK_CONFIG_CMD),
+	HCMD_NAME(STA_CONFIG_CMD),
+	HCMD_NAME(AUX_STA_CMD),
+	HCMD_NAME(STA_REMOVE_CMD),
+	HCMD_NAME(STA_DISABLE_TX_CMD),
 	HCMD_NAME(SESSION_PROTECTION_NOTIF),
 	HCMD_NAME(CHANNEL_SWITCH_START_NOTIF),
 };
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index 46af2b422849..313c5416ae5e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -783,9 +783,9 @@ static int iwl_mvm_get_queue_size(struct ieee80211_sta *sta)
 	return IWL_DEFAULT_QUEUE_SIZE;
 }
 
-static int iwl_mvm_tvqm_enable_txq(struct iwl_mvm *mvm,
-				   struct ieee80211_sta *sta,
-				   u8 sta_id, u8 tid, unsigned int timeout)
+int iwl_mvm_tvqm_enable_txq(struct iwl_mvm *mvm,
+			    struct ieee80211_sta *sta,
+			    u8 sta_id, u8 tid, unsigned int timeout)
 {
 	int queue, size;
 
@@ -2005,7 +2005,7 @@ int iwl_mvm_rm_sta_id(struct iwl_mvm *mvm,
 int iwl_mvm_allocate_int_sta(struct iwl_mvm *mvm,
 			     struct iwl_mvm_int_sta *sta,
 			     u32 qmask, enum nl80211_iftype iftype,
-			     enum iwl_sta_type type)
+			     u8 type)
 {
 	if (!test_bit(IWL_MVM_STATUS_IN_HW_RESTART, &mvm->status) ||
 	    sta->sta_id == IWL_MVM_INVALID_STA) {
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.h b/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
index f1a4fc3e4038..d11851b47684 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2012-2014, 2018-2021 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2022 Intel Corporation
  * Copyright (C) 2013-2014 Intel Mobile Communications GmbH
  * Copyright (C) 2015-2016 Intel Deutschland GmbH
  */
@@ -436,7 +436,7 @@ iwl_mvm_sta_from_mac80211(struct ieee80211_sta *sta)
  */
 struct iwl_mvm_int_sta {
 	u32 sta_id;
-	enum iwl_sta_type type;
+	u8 type;
 	u32 tfd_queue_msk;
 };
 
@@ -519,7 +519,7 @@ int iwl_mvm_rm_mcast_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif);
 int iwl_mvm_allocate_int_sta(struct iwl_mvm *mvm,
 			     struct iwl_mvm_int_sta *sta,
 				    u32 qmask, enum nl80211_iftype iftype,
-				    enum iwl_sta_type type);
+				    u8 type);
 void iwl_mvm_dealloc_bcast_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif);
 void iwl_mvm_dealloc_int_sta(struct iwl_mvm *mvm, struct iwl_mvm_int_sta *sta);
 int iwl_mvm_add_snif_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif);
@@ -551,4 +551,14 @@ int iwl_mvm_add_pasn_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 void iwl_mvm_cancel_channel_switch(struct iwl_mvm *mvm,
 				   struct ieee80211_vif *vif,
 				   u32 mac_id);
+/* Queues */
+int iwl_mvm_tvqm_enable_txq(struct iwl_mvm *mvm,
+			    struct ieee80211_sta *sta,
+			    u8 sta_id, u8 tid, unsigned int timeout);
+
+/* New MLD STA related APIs */
+int iwl_mvm_mld_add_bcast_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif);
+int iwl_mvm_mld_add_snif_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif);
+int iwl_mvm_mld_rm_bcast_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif);
+int iwl_mvm_mld_rm_snif_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif);
 #endif /* __sta_h__ */
-- 
2.38.1

