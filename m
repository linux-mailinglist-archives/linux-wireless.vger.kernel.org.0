Return-Path: <linux-wireless+bounces-22374-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67563AA825E
	for <lists+linux-wireless@lfdr.de>; Sat,  3 May 2025 21:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B52D189D76B
	for <lists+linux-wireless@lfdr.de>; Sat,  3 May 2025 19:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E69427EC76;
	Sat,  3 May 2025 19:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Iz8uzEll"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C56B1A83E8
	for <linux-wireless@vger.kernel.org>; Sat,  3 May 2025 19:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746301505; cv=none; b=QBtvbnOYP7flBr3q/G2jVBGtQsk/cn4nnknmzPODX1tdLI7XdV+Yni5WL73j8eiISIJAzbACX8QXZaGVbeHELtIZwezLFanDDRqLpKSEKs9zXXORskWknDR8Z3A8gViCFe2q2q7Qv+pkkni3TVuFAeA3yqQm4OHBsv4vjwIjvCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746301505; c=relaxed/simple;
	bh=qmanLoEtoIwgNiKiLgVUsYn0xUDzRdDxoLiW+NAR1vc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fV13BCLiK3vg2h8hY2MgdVsWqVmyMGfoFnwBPU7GzjP674ZosvUdUiK043q/cemwxdJk5FnRU1hEoyMWOtoekjPCPCfZe8A/m5xUGZkvyqWCyJ8wP/T2lHNBBVWYL22MJ3PNh3yuIPHDdtCi9yCzZGvH1OxD9cDDQmvxChZy8fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Iz8uzEll; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746301503; x=1777837503;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qmanLoEtoIwgNiKiLgVUsYn0xUDzRdDxoLiW+NAR1vc=;
  b=Iz8uzEll5QPlRAK4eU4FOdHSQ6jstXeUrA2yFzzyCn//+WlZnNb1PhMb
   0SiZ/M84rX32LfXCYbvEypugl55qHYRIBRJjIcZ4rOXdtftDkQWhcWf+v
   gXOSuN3OJgIv7jKDIDX7dk05wN2ahiEWI7wi6tlJOMOekQJfSULq16Z0k
   lterKOZMh1du+rL9tHc6hhgru192JQW5e5en9COm8uTw804DCoBD+637k
   s9xWXoYrGkP5A+M4B/tCF3VN2HXGbmOMg2/YS1mHH6/MDuIcK8jUjswUt
   L2LbbDBFCypkRkolTsmLb7W58bflrslMAOifU0wMF3ezNf+Bo2NM4bkN4
   w==;
X-CSE-ConnectionGUID: 9p+5TPbLTI+B5zYFvF7DGQ==
X-CSE-MsgGUID: 8VsmYNiCTbqEv6jXg6KE0g==
X-IronPort-AV: E=McAfee;i="6700,10204,11422"; a="58613264"
X-IronPort-AV: E=Sophos;i="6.15,258,1739865600"; 
   d="scan'208";a="58613264"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2025 12:45:03 -0700
X-CSE-ConnectionGUID: USgFb4qBSQOe+9jMrIVtiA==
X-CSE-MsgGUID: pkqLAbcsQByiveBw1ylSrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,258,1739865600"; 
   d="scan'208";a="134644305"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2025 12:45:01 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org,
	Somashekhar Puttagangaiah <somashekhar.puttagangaiah@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 07/15] wifi: iwlwifi: handle reasons recommended by FW for leaving EMLSR
Date: Sat,  3 May 2025 22:44:26 +0300
Message-Id: <20250503224231.0582726248a4.I9d1d00eb98d10a3a742cb3e06665ce10e5ec93f0@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250503194434.147426-1-miriam.rachel.korenblit@intel.com>
References: <20250503194434.147426-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Somashekhar Puttagangaiah <somashekhar.puttagangaiah@intel.com>

FW sends new notification version 2 indicating whether activating EMLSR
mode is recommended or not. If recommendation is to leave EMLSR or force
leave then FW sends the reason. Add debug log for the reason sent by FW.

Signed-off-by: Somashekhar Puttagangaiah <somashekhar.puttagangaiah@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../wireless/intel/iwlwifi/fw/api/datapath.h  |  2 +-
 .../wireless/intel/iwlwifi/fw/api/mac-cfg.h   | 43 ++++++++++++++++---
 drivers/net/wireless/intel/iwlwifi/mld/mlo.c  | 31 ++++++++++---
 .../net/wireless/intel/iwlwifi/mld/notif.c    |  3 +-
 4 files changed, 66 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/datapath.h b/drivers/net/wireless/intel/iwlwifi/fw/api/datapath.h
index c139b965980d..9c88bb280609 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/datapath.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/datapath.h
@@ -98,7 +98,7 @@ enum iwl_data_path_subcmd_ids {
 
 	/**
 	 * @ESR_MODE_NOTIF: notification to recommend/force a wanted esr mode,
-	 *	uses &struct iwl_esr_mode_notif
+	 *	uses &struct iwl_esr_mode_notif or &struct iwl_esr_mode_notif_v1
 	 */
 	ESR_MODE_NOTIF = 0xF3,
 
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h b/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
index b511e3aa6bb2..35a370918251 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
@@ -686,9 +686,9 @@ struct iwl_mvm_sta_disable_tx_cmd {
 
 /**
  * enum iwl_mvm_fw_esr_recommendation - FW recommendation code
- * @ESR_RECOMMEND_LEAVE: recommendation to leave esr
- * @ESR_FORCE_LEAVE: force exiting esr
- * @ESR_RECOMMEND_ENTER: recommendation to enter esr
+ * @ESR_RECOMMEND_LEAVE: recommendation to leave EMLSR
+ * @ESR_FORCE_LEAVE: force exiting EMLSR
+ * @ESR_RECOMMEND_ENTER: recommendation to enter EMLSR
  */
 enum iwl_mvm_fw_esr_recommendation {
 	ESR_RECOMMEND_LEAVE,
@@ -697,14 +697,45 @@ enum iwl_mvm_fw_esr_recommendation {
 }; /* ESR_MODE_RECOMMENDATION_CODE_API_E_VER_1 */
 
 /**
- * struct iwl_esr_mode_notif - FWs recommendation/force for esr mode
+ * struct iwl_esr_mode_notif_v1 - FW recommendation/force for EMLSR mode
  *
- * @action: the action to apply on esr state. See &iwl_mvm_fw_esr_recommendation
+ * @action: the action to apply on EMLSR state.
+ *	See &iwl_mvm_fw_esr_recommendation
  */
-struct iwl_esr_mode_notif {
+struct iwl_esr_mode_notif_v1 {
 	__le32 action;
 } __packed; /* ESR_MODE_RECOMMENDATION_NTFY_API_S_VER_1 */
 
+/**
+ * enum iwl_esr_leave_reason - reasons for leaving EMLSR mode
+ *
+ * @ESR_LEAVE_REASON_OMI_MU_UL_DISALLOWED: OMI MU UL disallowed
+ * @ESR_LEAVE_REASON_NO_TRIG_FOR_ESR_STA: No trigger for EMLSR station
+ * @ESR_LEAVE_REASON_NO_ESR_STA_IN_MU_DL: No EMLSR station in MU DL
+ * @ESR_LEAVE_REASON_BAD_ACTIV_FRAME_TH: Bad activation frame threshold
+ * @ESR_LEAVE_REASON_RTS_IN_DUAL_LISTEN: RTS in dual listen
+ */
+enum iwl_esr_leave_reason {
+	ESR_LEAVE_REASON_OMI_MU_UL_DISALLOWED	= BIT(0),
+	ESR_LEAVE_REASON_NO_TRIG_FOR_ESR_STA	= BIT(1),
+	ESR_LEAVE_REASON_NO_ESR_STA_IN_MU_DL	= BIT(2),
+	ESR_LEAVE_REASON_BAD_ACTIV_FRAME_TH	= BIT(3),
+	ESR_LEAVE_REASON_RTS_IN_DUAL_LISTEN	= BIT(4),
+};
+
+/**
+ * struct iwl_esr_mode_notif - FW recommendation/force for EMLSR mode
+ *
+ * @action: the action to apply on EMLSR state.
+ *	See &iwl_mvm_fw_esr_recommendation
+ * @leave_reason_mask: mask for various reasons to leave EMLSR mode.
+ *	See &iwl_esr_leave_reason
+ */
+struct iwl_esr_mode_notif {
+	__le32 action;
+	__le32 leave_reason_mask;
+} __packed; /* ESR_MODE_RECOMMENDATION_NTFY_API_S_VER_2 */
+
 /**
  * struct iwl_missed_beacons_notif - sent when by the firmware upon beacon loss
  *  ( MISSED_BEACONS_NOTIF = 0xF6 )
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mlo.c b/drivers/net/wireless/intel/iwlwifi/mld/mlo.c
index 824a328da28e..189946d5b2cb 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mlo.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mlo.c
@@ -326,23 +326,44 @@ static void
 iwl_mld_vif_iter_emlsr_mode_notif(void *data, u8 *mac,
 				  struct ieee80211_vif *vif)
 {
-	struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(vif);
-	struct iwl_esr_mode_notif *notif = (void *)data;
+	const struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(vif);
+	enum iwl_mvm_fw_esr_recommendation action;
+	const struct iwl_esr_mode_notif *notif = NULL;
+
+	if (iwl_fw_lookup_notif_ver(mld_vif->mld->fw, DATA_PATH_GROUP,
+				    ESR_MODE_NOTIF, 0) > 1) {
+		notif = (void *)data;
+		action = le32_to_cpu(notif->action);
+	} else {
+		const struct iwl_esr_mode_notif_v1 *notif_v1 = (void *)data;
+
+		action = le32_to_cpu(notif_v1->action);
+	}
 
 	if (!iwl_mld_vif_has_emlsr_cap(vif))
 		return;
 
-	switch (le32_to_cpu(notif->action)) {
+	switch (action) {
 	case ESR_RECOMMEND_LEAVE:
+		if (notif)
+			IWL_DEBUG_INFO(mld_vif->mld,
+				       "FW recommend leave reason = 0x%x\n",
+				       le32_to_cpu(notif->leave_reason_mask));
+
 		iwl_mld_exit_emlsr(mld_vif->mld, vif,
 				   IWL_MLD_EMLSR_EXIT_FW_REQUEST,
 				   iwl_mld_get_primary_link(vif));
 		break;
-	case ESR_RECOMMEND_ENTER:
 	case ESR_FORCE_LEAVE:
+		if (notif)
+			IWL_DEBUG_INFO(mld_vif->mld,
+				       "FW force leave reason = 0x%x\n",
+				       le32_to_cpu(notif->leave_reason_mask));
+		fallthrough;
+	case ESR_RECOMMEND_ENTER:
 	default:
 		IWL_WARN(mld_vif->mld, "Unexpected EMLSR notification: %d\n",
-			 le32_to_cpu(notif->action));
+			 action);
 	}
 }
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/notif.c b/drivers/net/wireless/intel/iwlwifi/mld/notif.c
index 76b1a21135a8..61e00b13f2ce 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/notif.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/notif.c
@@ -336,7 +336,8 @@ CMD_VERSIONS(bt_coex_notif,
 CMD_VERSIONS(beacon_notification,
 	     CMD_VER_ENTRY(6, iwl_extended_beacon_notif))
 CMD_VERSIONS(emlsr_mode_notif,
-	     CMD_VER_ENTRY(1, iwl_esr_mode_notif))
+	     CMD_VER_ENTRY(1, iwl_esr_mode_notif_v1)
+	     CMD_VER_ENTRY(2, iwl_esr_mode_notif))
 CMD_VERSIONS(emlsr_trans_fail_notif,
 	     CMD_VER_ENTRY(1, iwl_esr_trans_fail_notif))
 CMD_VERSIONS(uapsd_misbehaving_ap_notif,
-- 
2.34.1


