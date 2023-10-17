Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C1447CBEBA
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Oct 2023 11:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234789AbjJQJRL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Oct 2023 05:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234818AbjJQJRI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Oct 2023 05:17:08 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37C3F8E
        for <linux-wireless@vger.kernel.org>; Tue, 17 Oct 2023 02:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697534227; x=1729070227;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Nrk1edAwGnxK+zkxOd2NMBb6glTVuHbGkC4vphJZ8D0=;
  b=eKIL0p0ovptHh9DcNxQKRjv1orFVYZiZT73Vw17bPFcXzoUOHJbG9TPh
   eOFhjtX9Esf9cc8ICXvYlak9c0Au0b41jv/Ngoe9oMfY7Szq18luIHr2h
   70Sy5TpJoYJmS5sXQRZzvqvxVvuBCcCY+pRscNYv4W69u27kA/dcRf2fy
   IXCLFh9pgNsYwm2oQDmFTnVUqSHdkkF7PBiRQk4R19JusdqxC89kiPYmr
   +G6Toauz5clgqVW/wC8L6h0ACsWoam7zYHYFNIckO7zutKporDW5dRKTF
   qV5fvxwfdxJF6f9esl245hcYbpLdPRqNEjyulO15ziM8EkWoaV8jEuJKw
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="370808517"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="370808517"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 02:17:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="759731810"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="759731810"
Received: from obarinsh-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.213.101])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 02:17:05 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Miri Korenblit <miriam.rachel.korenblit@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 02/14] wifi: iwlwifi: support link_id in SESSION_PROTECTION cmd
Date:   Tue, 17 Oct 2023 12:16:37 +0300
Message-Id: <20231017115047.a3cb29ed0617.I85b8a85b0d9186d3dd4d704254e46775b0ccf7de@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20231017091649.65090-1-gregory.greenman@intel.com>
References: <20231017091649.65090-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Miri Korenblit <miriam.rachel.korenblit@intel.com>

FW is introducing an API change in which link ID will be used
for session protection cmd. Add support for it.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../intel/iwlwifi/fw/api/time-event.h         | 11 ++-
 .../wireless/intel/iwlwifi/mvm/time-event.c   | 78 ++++++++++++++-----
 2 files changed, 64 insertions(+), 25 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/time-event.h b/drivers/net/wireless/intel/iwlwifi/fw/api/time-event.h
index f0d4056199a7..701b2929c3a4 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/time-event.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/time-event.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2012-2014, 2018-2020, 2022 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2020, 2022-2023 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -432,8 +432,8 @@ enum iwl_mvm_session_prot_conf_id {
 
 /**
  * struct iwl_mvm_session_prot_cmd - configure a session protection
- * @id_and_color: the id and color of the mac for which this session protection
- *	is sent
+ * @id_and_color: the id and color of the link (or mac, for command version 1)
+ *	for which this session protection is sent
  * @action: can be either FW_CTXT_ACTION_ADD or FW_CTXT_ACTION_REMOVE,
  *	see &enum iwl_ctxt_action
  * @conf_id: see &enum iwl_mvm_session_prot_conf_id
@@ -454,7 +454,10 @@ struct iwl_mvm_session_prot_cmd {
 	__le32 duration_tu;
 	__le32 repetition_count;
 	__le32 interval;
-} __packed; /* SESSION_PROTECTION_CMD_API_S_VER_1 */
+} __packed;
+/* SESSION_PROTECTION_CMD_API_S_VER_1 and
+ * SESSION_PROTECTION_CMD_API_S_VER_2
+ */
 
 /**
  * struct iwl_mvm_session_prot_notif - session protection started / ended
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
index 54e57c7ecfc8..ecbebef80791 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
@@ -689,19 +689,46 @@ void iwl_mvm_protect_session(struct iwl_mvm *mvm,
 	}
 }
 
+/* Determine whether mac or link id should be used, and validate the link id */
+static int iwl_mvm_get_session_prot_id(struct iwl_mvm *mvm,
+				       struct ieee80211_vif *vif,
+				       u32 link_id)
+{
+	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+	int ver = iwl_fw_lookup_cmd_ver(mvm->fw,
+					WIDE_ID(MAC_CONF_GROUP,
+						SESSION_PROTECTION_CMD), 1);
+
+	if (ver < 2)
+		return mvmvif->id;
+
+	if (WARN(link_id < 0 || !mvmvif->link[link_id],
+		 "Invalid link ID for session protection: %u\n", link_id))
+		return -EINVAL;
+
+	if (WARN(ieee80211_vif_is_mld(vif) &&
+		 !(vif->active_links & BIT(link_id)),
+		 "Session Protection on an inactive link: %u\n", link_id))
+		return -EINVAL;
+
+	return mvmvif->link[link_id]->fw_link_id;
+}
+
 static void iwl_mvm_cancel_session_protection(struct iwl_mvm *mvm,
-					      struct iwl_mvm_vif *mvmvif,
-					      u32 id)
+					      struct ieee80211_vif *vif,
+					      u32 id, u32 link_id)
 {
+	int mac_link_id = iwl_mvm_get_session_prot_id(mvm, vif, link_id);
 	struct iwl_mvm_session_prot_cmd cmd = {
-		.id_and_color =
-			cpu_to_le32(FW_CMD_ID_AND_COLOR(mvmvif->id,
-							mvmvif->color)),
+		.id_and_color = cpu_to_le32(mac_link_id),
 		.action = cpu_to_le32(FW_CTXT_ACTION_REMOVE),
 		.conf_id = cpu_to_le32(id),
 	};
 	int ret;
 
+	if (mac_link_id < 0)
+		return;
+
 	ret = iwl_mvm_send_cmd_pdu(mvm,
 				   WIDE_ID(MAC_CONF_GROUP, SESSION_PROTECTION_CMD),
 				   0, sizeof(cmd), &cmd);
@@ -715,10 +742,12 @@ static bool __iwl_mvm_remove_time_event(struct iwl_mvm *mvm,
 					u32 *uid)
 {
 	u32 id;
+	struct ieee80211_vif *vif = te_data->vif;
 	struct iwl_mvm_vif *mvmvif;
 	enum nl80211_iftype iftype;
+	unsigned int link_id;
 
-	if (!te_data->vif)
+	if (!vif)
 		return false;
 
 	mvmvif = iwl_mvm_vif_from_mac80211(te_data->vif);
@@ -733,6 +762,7 @@ static bool __iwl_mvm_remove_time_event(struct iwl_mvm *mvm,
 	/* Save time event uid before clearing its data */
 	*uid = te_data->uid;
 	id = te_data->id;
+	link_id = te_data->link_id;
 
 	/*
 	 * The clear_data function handles time events that were already removed
@@ -750,7 +780,8 @@ static bool __iwl_mvm_remove_time_event(struct iwl_mvm *mvm,
 	    id != HOT_SPOT_CMD) {
 		if (mvmvif && id < SESSION_PROTECT_CONF_MAX_ID) {
 			/* Session protection is still ongoing. Cancel it */
-			iwl_mvm_cancel_session_protection(mvm, mvmvif, id);
+			iwl_mvm_cancel_session_protection(mvm, vif, id,
+							  link_id);
 			if (iftype == NL80211_IFTYPE_P2P_DEVICE) {
 				iwl_mvm_p2p_roc_finished(mvm);
 			}
@@ -941,8 +972,7 @@ iwl_mvm_start_p2p_roc_session_protection(struct iwl_mvm *mvm,
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	struct iwl_mvm_session_prot_cmd cmd = {
 		.id_and_color =
-			cpu_to_le32(FW_CMD_ID_AND_COLOR(mvmvif->id,
-							mvmvif->color)),
+			cpu_to_le32(iwl_mvm_get_session_prot_id(mvm, vif, 0)),
 		.action = cpu_to_le32(FW_CTXT_ACTION_ADD),
 		.duration_tu = cpu_to_le32(MSEC_TO_TU(duration)),
 	};
@@ -1112,8 +1142,9 @@ void iwl_mvm_stop_roc(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 		mvmvif = iwl_mvm_vif_from_mac80211(vif);
 
 		if (vif->type == NL80211_IFTYPE_P2P_DEVICE) {
-			iwl_mvm_cancel_session_protection(mvm, mvmvif,
-							  mvmvif->time_event_data.id);
+			iwl_mvm_cancel_session_protection(mvm, vif,
+							  mvmvif->time_event_data.id,
+							  mvmvif->time_event_data.link_id);
 			iwl_mvm_p2p_roc_finished(mvm);
 		} else {
 			iwl_mvm_roc_station_remove(mvm, mvmvif);
@@ -1242,15 +1273,17 @@ void iwl_mvm_schedule_session_protection(struct iwl_mvm *mvm,
 	struct iwl_mvm_time_event_data *te_data = &mvmvif->time_event_data;
 	const u16 notif[] = { WIDE_ID(MAC_CONF_GROUP, SESSION_PROTECTION_NOTIF) };
 	struct iwl_notification_wait wait_notif;
+	int mac_link_id = iwl_mvm_get_session_prot_id(mvm, vif, link_id);
 	struct iwl_mvm_session_prot_cmd cmd = {
-		.id_and_color =
-			cpu_to_le32(FW_CMD_ID_AND_COLOR(mvmvif->id,
-							mvmvif->color)),
+		.id_and_color = cpu_to_le32(mac_link_id),
 		.action = cpu_to_le32(FW_CTXT_ACTION_ADD),
 		.conf_id = cpu_to_le32(SESSION_PROTECT_CONF_ASSOC),
 		.duration_tu = cpu_to_le32(MSEC_TO_TU(duration)),
 	};
 
+	if (mac_link_id < 0)
+		return;
+
 	lockdep_assert_held(&mvm->mutex);
 
 	spin_lock_bh(&mvm->time_event_lock);
@@ -1281,11 +1314,7 @@ void iwl_mvm_schedule_session_protection(struct iwl_mvm *mvm,
 		if (iwl_mvm_send_cmd_pdu(mvm,
 					 WIDE_ID(MAC_CONF_GROUP, SESSION_PROTECTION_CMD),
 					 0, sizeof(cmd), &cmd)) {
-			IWL_ERR(mvm,
-				"Couldn't send the SESSION_PROTECTION_CMD\n");
-			spin_lock_bh(&mvm->time_event_lock);
-			iwl_mvm_te_clear_data(mvm, te_data);
-			spin_unlock_bh(&mvm->time_event_lock);
+			goto send_cmd_err;
 		}
 
 		return;
@@ -1298,12 +1327,19 @@ void iwl_mvm_schedule_session_protection(struct iwl_mvm *mvm,
 	if (iwl_mvm_send_cmd_pdu(mvm,
 				 WIDE_ID(MAC_CONF_GROUP, SESSION_PROTECTION_CMD),
 				 0, sizeof(cmd), &cmd)) {
-		IWL_ERR(mvm,
-			"Couldn't send the SESSION_PROTECTION_CMD\n");
 		iwl_remove_notification(&mvm->notif_wait, &wait_notif);
+		goto send_cmd_err;
 	} else if (iwl_wait_notification(&mvm->notif_wait, &wait_notif,
 					 TU_TO_JIFFIES(100))) {
 		IWL_ERR(mvm,
 			"Failed to protect session until session protection\n");
 	}
+	return;
+
+send_cmd_err:
+	IWL_ERR(mvm,
+		"Couldn't send the SESSION_PROTECTION_CMD\n");
+	spin_lock_bh(&mvm->time_event_lock);
+	iwl_mvm_te_clear_data(mvm, te_data);
+	spin_unlock_bh(&mvm->time_event_lock);
 }
-- 
2.38.1

