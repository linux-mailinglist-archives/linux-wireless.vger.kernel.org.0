Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD2EF6CB8EF
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Mar 2023 10:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232701AbjC1IAX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Mar 2023 04:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjC1IAS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Mar 2023 04:00:18 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B46F40CA
        for <linux-wireless@vger.kernel.org>; Tue, 28 Mar 2023 01:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679990417; x=1711526417;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=t4PlJAkYjjOUNETdkXIUVr4gGm4bwlEnxU3FwTFZ/8s=;
  b=e/XHmt7l+25rlfaNm1V+f/za/tGEsYFpBoayesIXTxmXfz2/dOXAOn2e
   8tAyFp0+NSe/Rw/dL2QvAByud9mP0HqRYiXSyqOUSp90t0VgPAcL5L0EL
   WU62N4oAT6EsuqB6eJLQCyRWQoR14Hx+tYs0Qe9QnB2eMA4+Z/0v76P1N
   81EWhacQ/XsmCRloieAxrHaxx/dNy0/8fnBrLipdN//yj+d8/SzwufBUY
   oRJfeV9OngFVvc9RzOx7quzzQ5CLJj77NrDAtuvTs76UbJDz028qtjhh6
   DcFH0IKcBg76szJ9ekr7euOyfwSOuhzP1pxcCAxWmVTusy8KfrCtSjmDF
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="328958190"
X-IronPort-AV: E=Sophos;i="5.98,296,1673942400"; 
   d="scan'208";a="328958190"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 00:59:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="773045170"
X-IronPort-AV: E=Sophos;i="5.98,296,1673942400"; 
   d="scan'208";a="773045170"
Received: from gershonr-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.194.136])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 00:59:58 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Gregory Greenman <gregory.greenman@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 17/31] wifi: iwlwifi: mvm: adjust mld_mac_ctxt_/beacon_changed() for MLO
Date:   Tue, 28 Mar 2023 10:58:57 +0300
Message-Id: <20230328104949.5ef4efeda2dd.I6ebda2b71c964b9aa63240c9fa1ee0d28099fe6e@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230328075911.2370108-1-gregory.greenman@intel.com>
References: <20230328075911.2370108-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Gregory Greenman <gregory.greenman@intel.com>

HE/EHT support is reported to FW if there's at least one link
that supports it. Configure beacon separately for each link.
Don't send the beacon template before adding the MAC.

Co-developed-by: Johannes Berg <johannes.berg@intel.com>
Co-developed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../net/wireless/intel/iwlwifi/fw/api/tx.h    | 10 ++--
 .../net/wireless/intel/iwlwifi/mvm/debugfs.c  | 22 +++++----
 .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c | 24 +++++----
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 39 ++++++++++-----
 .../net/wireless/intel/iwlwifi/mvm/mld-mac.c  | 49 ++++++++++++++++---
 .../wireless/intel/iwlwifi/mvm/mld-mac80211.c | 12 ++---
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  6 ++-
 7 files changed, 115 insertions(+), 47 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h b/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h
index ecc6706f66ed..97edf5477ba7 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h
@@ -800,7 +800,7 @@ enum iwl_mac_beacon_flags {
  *	is &enum iwl_mac_beacon_flags.
  * @short_ssid: Short SSID
  * @reserved: reserved
- * @template_id: currently equal to the mac context id of the coresponding mac.
+ * @link_id: the firmware id of the link that will use this beacon
  * @tim_idx: the offset of the tim IE in the beacon
  * @tim_size: the length of the tim IE
  * @ecsa_offset: offset to the ECSA IE if present
@@ -812,15 +812,17 @@ struct iwl_mac_beacon_cmd {
 	__le16 flags;
 	__le32 short_ssid;
 	__le32 reserved;
-	__le32 template_id;
+	__le32 link_id;
 	__le32 tim_idx;
 	__le32 tim_size;
 	__le32 ecsa_offset;
 	__le32 csa_offset;
 	struct ieee80211_hdr frame[];
 } __packed; /* BEACON_TEMPLATE_CMD_API_S_VER_10,
-	       BEACON_TEMPLATE_CMD_API_S_VER_11,
-	       BEACON_TEMPLATE_CMD_API_S_VER_12 */
+	     * BEACON_TEMPLATE_CMD_API_S_VER_11,
+	     * BEACON_TEMPLATE_CMD_API_S_VER_12,
+	     * BEACON_TEMPLATE_CMD_API_S_VER_13
+	     */
 
 struct iwl_beacon_notif {
 	struct iwl_mvm_tx_resp beacon_notify_hdr;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
index b5eb0ee298ad..2c72f5cb19f1 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
@@ -1388,6 +1388,7 @@ static int _iwl_dbgfs_inject_beacon_ie(struct iwl_mvm *mvm, char *bin, int len)
 	struct sk_buff *beacon;
 	struct ieee80211_tx_info *info;
 	struct iwl_mac_beacon_cmd beacon_cmd = {};
+	unsigned int link_id;
 	u8 rate;
 	int i;
 
@@ -1436,17 +1437,20 @@ static int _iwl_dbgfs_inject_beacon_ie(struct iwl_mvm *mvm, char *bin, int len)
 	info = IEEE80211_SKB_CB(beacon);
 	rate = iwl_mvm_mac_ctxt_get_beacon_rate(mvm, info, vif);
 
-	beacon_cmd.flags =
-		cpu_to_le16(iwl_mvm_mac_ctxt_get_beacon_flags(mvm->fw, rate));
-	beacon_cmd.byte_cnt = cpu_to_le16((u16)beacon->len);
-	beacon_cmd.template_id = cpu_to_le32((u32)mvmvif->id);
+	for_each_mvm_vif_valid_link(mvmvif, link_id) {
+		beacon_cmd.flags =
+			cpu_to_le16(iwl_mvm_mac_ctxt_get_beacon_flags(mvm->fw,
+								      rate));
+		beacon_cmd.byte_cnt = cpu_to_le16((u16)beacon->len);
+		beacon_cmd.link_id = cpu_to_le32((u32)mvmvif->id);
 
-	iwl_mvm_mac_ctxt_set_tim(mvm, &beacon_cmd.tim_idx,
-				 &beacon_cmd.tim_size,
-				 beacon->data, beacon->len);
+		iwl_mvm_mac_ctxt_set_tim(mvm, &beacon_cmd.tim_idx,
+					 &beacon_cmd.tim_size,
+					 beacon->data, beacon->len);
 
-	iwl_mvm_mac_ctxt_send_beacon_cmd(mvm, beacon, &beacon_cmd,
-					 sizeof(beacon_cmd));
+		iwl_mvm_mac_ctxt_send_beacon_cmd(mvm, beacon, &beacon_cmd,
+						 sizeof(beacon_cmd));
+	}
 	mutex_unlock(&mvm->mutex);
 
 	dev_kfree_skb(beacon);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
index 10dc1fdbdeb3..a06513989469 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
@@ -1039,7 +1039,8 @@ static int iwl_mvm_mac_ctxt_send_beacon_v7(struct iwl_mvm *mvm,
 
 static int iwl_mvm_mac_ctxt_send_beacon_v9(struct iwl_mvm *mvm,
 					   struct ieee80211_vif *vif,
-					   struct sk_buff *beacon)
+					   struct sk_buff *beacon,
+					   struct ieee80211_bss_conf *link_conf)
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(beacon);
@@ -1052,7 +1053,7 @@ static int iwl_mvm_mac_ctxt_send_beacon_v9(struct iwl_mvm *mvm,
 
 	/* Enable FILS on PSC channels only */
 	rcu_read_lock();
-	ctx = rcu_dereference(vif->bss_conf.chanctx_conf);
+	ctx = rcu_dereference(link_conf->chanctx_conf);
 	channel = ieee80211_frequency_to_channel(ctx->def.chan->center_freq);
 	WARN_ON(channel == 0);
 	if (cfg80211_channel_is_psc(ctx->def.chan) &&
@@ -1069,7 +1070,7 @@ static int iwl_mvm_mac_ctxt_send_beacon_v9(struct iwl_mvm *mvm,
 
 	beacon_cmd.flags = cpu_to_le16(flags);
 	beacon_cmd.byte_cnt = cpu_to_le16((u16)beacon->len);
-	beacon_cmd.template_id = cpu_to_le32((u32)mvmvif->id);
+	beacon_cmd.link_id = cpu_to_le32((u32)mvmvif->id);
 
 	if (vif->type == NL80211_IFTYPE_AP)
 		iwl_mvm_mac_ctxt_set_tim(mvm, &beacon_cmd.tim_idx,
@@ -1091,7 +1092,8 @@ static int iwl_mvm_mac_ctxt_send_beacon_v9(struct iwl_mvm *mvm,
 
 int iwl_mvm_mac_ctxt_send_beacon(struct iwl_mvm *mvm,
 				 struct ieee80211_vif *vif,
-				 struct sk_buff *beacon)
+				 struct sk_buff *beacon,
+				 struct ieee80211_bss_conf *link_conf)
 {
 	if (WARN_ON(!beacon))
 		return -EINVAL;
@@ -1105,14 +1107,16 @@ int iwl_mvm_mac_ctxt_send_beacon(struct iwl_mvm *mvm,
 
 	if (fw_has_api(&mvm->fw->ucode_capa,
 		       IWL_UCODE_TLV_API_NEW_BEACON_TEMPLATE))
-		return iwl_mvm_mac_ctxt_send_beacon_v9(mvm, vif, beacon);
+		return iwl_mvm_mac_ctxt_send_beacon_v9(mvm, vif, beacon,
+						       link_conf);
 
 	return iwl_mvm_mac_ctxt_send_beacon_v7(mvm, vif, beacon);
 }
 
 /* The beacon template for the AP/GO/IBSS has changed and needs update */
 int iwl_mvm_mac_ctxt_beacon_changed(struct iwl_mvm *mvm,
-				    struct ieee80211_vif *vif)
+				    struct ieee80211_vif *vif,
+				    struct ieee80211_bss_conf *link_conf)
 {
 	struct sk_buff *beacon;
 	int ret;
@@ -1120,7 +1124,8 @@ int iwl_mvm_mac_ctxt_beacon_changed(struct iwl_mvm *mvm,
 	WARN_ON(vif->type != NL80211_IFTYPE_AP &&
 		vif->type != NL80211_IFTYPE_ADHOC);
 
-	beacon = ieee80211_beacon_get_template(mvm->hw, vif, NULL, 0);
+	beacon = ieee80211_beacon_get_template(mvm->hw, vif, NULL,
+					       link_conf->link_id);
 	if (!beacon)
 		return -ENOMEM;
 
@@ -1131,7 +1136,7 @@ int iwl_mvm_mac_ctxt_beacon_changed(struct iwl_mvm *mvm,
 	}
 #endif
 
-	ret = iwl_mvm_mac_ctxt_send_beacon(mvm, vif, beacon);
+	ret = iwl_mvm_mac_ctxt_send_beacon(mvm, vif, beacon, link_conf);
 	dev_kfree_skb(beacon);
 	return ret;
 }
@@ -1398,7 +1403,8 @@ static void iwl_mvm_csa_count_down(struct iwl_mvm *mvm,
 	if (!ieee80211_beacon_cntdwn_is_complete(csa_vif)) {
 		int c = ieee80211_beacon_update_cntdwn(csa_vif);
 
-		iwl_mvm_mac_ctxt_beacon_changed(mvm, csa_vif);
+		iwl_mvm_mac_ctxt_beacon_changed(mvm, csa_vif,
+						&csa_vif->bss_conf);
 		if (csa_vif->p2p &&
 		    !iwl_mvm_te_scheduled(&mvmvif->time_event_data) && gp2 &&
 		    tx_success) {
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index e922cc45c390..d9caf326535f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -2748,11 +2748,6 @@ static int iwl_mvm_start_ap_ibss(struct ieee80211_hw *hw,
 
 	mutex_lock(&mvm->mutex);
 
-	/* Send the beacon template */
-	ret = iwl_mvm_mac_ctxt_beacon_changed(mvm, vif);
-	if (ret)
-		goto out_unlock;
-
 	/*
 	 * Re-calculate the tsf id, as the leader-follower relations depend on
 	 * the beacon interval, which was not known when the AP interface
@@ -2761,10 +2756,31 @@ static int iwl_mvm_start_ap_ibss(struct ieee80211_hw *hw,
 	if (vif->type == NL80211_IFTYPE_AP)
 		iwl_mvm_mac_ctxt_recalc_tsf_id(mvm, vif);
 
-	/* Add the mac context */
-	ret = iwl_mvm_mac_ctxt_add(mvm, vif);
-	if (ret)
-		goto out_unlock;
+	/* For older devices need to send beacon template before adding mac
+	 * context. For the newer, the beacon is a resource that belongs to a
+	 * MAC, so need to send beacon template after adding the mac.
+	 */
+	if (mvm->trans->trans_cfg->device_family > IWL_DEVICE_FAMILY_22000) {
+		/* Add the mac context */
+		ret = iwl_mvm_mac_ctxt_add(mvm, vif);
+		if (ret)
+			goto out_unlock;
+
+		/* Send the beacon template */
+		ret = iwl_mvm_mac_ctxt_beacon_changed(mvm, vif, link_conf);
+		if (ret)
+			goto out_unlock;
+	} else {
+		/* Send the beacon template */
+		ret = iwl_mvm_mac_ctxt_beacon_changed(mvm, vif, link_conf);
+		if (ret)
+			goto out_unlock;
+
+		/* Add the mac context */
+		ret = iwl_mvm_mac_ctxt_add(mvm, vif);
+		if (ret)
+			goto out_unlock;
+	}
 
 	/* Perform the binding */
 	ret = iwl_mvm_binding_add_vif(mvm, vif);
@@ -2961,7 +2977,7 @@ iwl_mvm_bss_info_changed_ap_ibss(struct iwl_mvm *mvm,
 
 	/* Need to send a new beacon template to the FW */
 	if (changes & BSS_CHANGED_BEACON &&
-	    iwl_mvm_mac_ctxt_beacon_changed(mvm, vif))
+	    iwl_mvm_mac_ctxt_beacon_changed(mvm, vif, &vif->bss_conf))
 		IWL_WARN(mvm, "Failed updating beacon data\n");
 
 	if (changes & BSS_CHANGED_FTM_RESPONDER) {
@@ -4965,7 +4981,8 @@ int iwl_mvm_set_tim(struct ieee80211_hw *hw, struct ieee80211_sta *sta,
 		return -EINVAL;
 	}
 
-	return iwl_mvm_mac_ctxt_beacon_changed(mvm, mvm_sta->vif);
+	return iwl_mvm_mac_ctxt_beacon_changed(mvm, mvm_sta->vif,
+					       &mvm_sta->vif->bss_conf);
 }
 
 #ifdef CONFIG_NL80211_TESTMODE
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac.c
index 240f51d2fd53..c9a0f68c5d48 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac.c
@@ -10,6 +10,8 @@ static void iwl_mvm_mld_mac_ctxt_cmd_common(struct iwl_mvm *mvm,
 					    u32 action)
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+	struct ieee80211_bss_conf *link_conf;
+	unsigned int link_id;
 
 	cmd->id_and_color = cpu_to_le32(mvmvif->id);
 	cmd->action = cpu_to_le32(action);
@@ -18,19 +20,53 @@ static void iwl_mvm_mld_mac_ctxt_cmd_common(struct iwl_mvm *mvm,
 
 	memcpy(cmd->local_mld_addr, vif->addr, ETH_ALEN);
 
-	cmd->filter_flags = cpu_to_le32(0);
-	cmd->he_support = cpu_to_le32(0);
-	cmd->eht_support = cpu_to_le32(0);
+	cmd->he_support = 0;
+	cmd->eht_support = 0;
+
+	/* should be set by specific context type handler */
+	cmd->filter_flags = 0;
 
 	cmd->nic_not_ack_enabled =
 		cpu_to_le32(!iwl_mvm_is_nic_ack_enabled(mvm, vif));
 
 	if (iwlwifi_mod_params.disable_11ax)
 		return;
-	cmd->he_support = cpu_to_le32(vif->bss_conf.he_support);
 
-	if (!iwlwifi_mod_params.disable_11be && cmd->he_support)
-		cmd->eht_support = cpu_to_le32(vif->bss_conf.eht_support);
+	/* If we have MLO enabled, then the firmware needs to enable
+	 * address translation for the station(s) we add. That depends
+	 * on having EHT enabled in firmware, which in turn depends on
+	 * mac80211 in the code below.
+	 * However, mac80211 doesn't enable HE/EHT until it has parsed
+	 * the association response successfully, so just skip all that
+	 * and enable both when we have MLO.
+	 */
+	if (vif->valid_links) {
+		cmd->he_support = cpu_to_le32(1);
+		cmd->eht_support = cpu_to_le32(1);
+		return;
+	}
+
+	rcu_read_lock();
+	for (link_id = 0; link_id < ARRAY_SIZE((vif)->link_conf); link_id++) {
+		link_conf = rcu_dereference(vif->link_conf[link_id]);
+		if (!link_conf)
+			continue;
+
+		if (link_conf->he_support)
+			cmd->he_support = cpu_to_le32(1);
+
+		/* it's not reasonable to have EHT without HE and FW API doesn't
+		 * support it. Ignore EHT in this case.
+		 */
+		if (!link_conf->he_support && link_conf->eht_support)
+			continue;
+
+		if (link_conf->eht_support) {
+			cmd->eht_support = cpu_to_le32(1);
+			break;
+		}
+	}
+	rcu_read_unlock();
 }
 
 static int iwl_mvm_mld_mac_ctxt_send_cmd(struct iwl_mvm *mvm,
@@ -66,6 +102,7 @@ static int iwl_mvm_mld_mac_ctxt_cmd_sta(struct iwl_mvm *mvm,
 		cmd.client.ctwin =
 			iwl_mvm_mac_ctxt_cmd_p2p_sta_get_oppps_ctwin(mvm, vif);
 
+	/* FIXME: assume for now that DTIM period is the same for all links */
 	if (vif->cfg.assoc && vif->bss_conf.dtim_period &&
 	    !force_assoc_off) {
 		struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
index 5be8058ca669..ec0789484d8b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
@@ -258,11 +258,6 @@ static int iwl_mvm_mld_start_ap_ibss(struct ieee80211_hw *hw,
 
 	mutex_lock(&mvm->mutex);
 
-	/* Send the beacon template */
-	ret = iwl_mvm_mac_ctxt_beacon_changed(mvm, vif);
-	if (ret)
-		goto out_unlock;
-
 	/* No need to re-calculate the tsf_is, as it was offloaded */
 
 	/* Add the mac context */
@@ -270,6 +265,11 @@ static int iwl_mvm_mld_start_ap_ibss(struct ieee80211_hw *hw,
 	if (ret)
 		goto out_unlock;
 
+	/* Send the beacon template */
+	ret = iwl_mvm_mac_ctxt_beacon_changed(mvm, vif, link_conf);
+	if (ret)
+		goto out_unlock;
+
 	/* Add link and activate it */
 	ret = iwl_mvm_add_link(mvm, vif);
 	if (ret)
@@ -532,7 +532,7 @@ iwl_mvm_mld_bss_info_changed_ap_ibss(struct iwl_mvm *mvm,
 
 	/* Need to send a new beacon template to the FW */
 	if (changes & BSS_CHANGED_BEACON &&
-	    iwl_mvm_mac_ctxt_beacon_changed(mvm, vif))
+	    iwl_mvm_mac_ctxt_beacon_changed(mvm, vif, &vif->bss_conf))
 		IWL_WARN(mvm, "Failed updating beacon data\n");
 
 	if (changes & BSS_CHANGED_FTM_RESPONDER) {
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 6f4ed5d1efb9..9c5e772d619e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1759,10 +1759,12 @@ int iwl_mvm_mac_ctxt_changed(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 			     bool force_assoc_off, const u8 *bssid_override);
 int iwl_mvm_mac_ctxt_remove(struct iwl_mvm *mvm, struct ieee80211_vif *vif);
 int iwl_mvm_mac_ctxt_beacon_changed(struct iwl_mvm *mvm,
-				    struct ieee80211_vif *vif);
+				    struct ieee80211_vif *vif,
+				    struct ieee80211_bss_conf *link_conf);
 int iwl_mvm_mac_ctxt_send_beacon(struct iwl_mvm *mvm,
 				 struct ieee80211_vif *vif,
-				 struct sk_buff *beacon);
+				 struct sk_buff *beacon,
+				 struct ieee80211_bss_conf *link_conf);
 int iwl_mvm_mac_ctxt_send_beacon_cmd(struct iwl_mvm *mvm,
 				     struct sk_buff *beacon,
 				     void *data, int len);
-- 
2.38.1

