Return-Path: <linux-wireless+bounces-16806-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0729E9FCBA0
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Dec 2024 16:45:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67069188322D
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Dec 2024 15:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43BB754279;
	Thu, 26 Dec 2024 15:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Go6yy8F+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F54D1EEE9
	for <linux-wireless@vger.kernel.org>; Thu, 26 Dec 2024 15:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735227919; cv=none; b=qDYslkvoXDKnH/D/qoZuuLsIK38yTy44+G39dUsn9KbSbV2BLKr3mI7ym1006GzGa8xg0QJg/W3oPgB705bZDVa7nseNrZsbKcC+0XHXEcN/+0BK0OwpRv9I2sdjZx03ZM3Fm9QAGQYAkpdb0LIsDZDCCVQzKNIU+Vrhls5bliU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735227919; c=relaxed/simple;
	bh=/m7FfTK+fae122oakqDPoISKqDM1EJw5PK+MO5HEcfg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ut3qaV3H9TK/yHAkSYtsehQtr35IjRTfjhyFDLpZXe3k5LqmTAGw1NC7F0a2ZV+6PLsIWNi2D68/HcbzSJrCQMdXPRzDrcEgToMYUNNyPay2KHZlAbi0RHaEhsi5Pd/EiUO6GIb2mSlHcn6tuDZmLFMjJOFeur9IqmhZq2aGlB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Go6yy8F+; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735227917; x=1766763917;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/m7FfTK+fae122oakqDPoISKqDM1EJw5PK+MO5HEcfg=;
  b=Go6yy8F+SJT06e9FQd9Rjawm5VQceC1E7PelLZvjdmimRhvOWLvlQmBQ
   0a6GqfmTAGJIcITZjULvZ+5HWSx3XZKVeV5TBSAZAYK+fixDjQbFiCbuL
   H86VL6JIjp8ktJzmeWLslw3cxa/XglYe4imKAm0tQ0nNd5u6nESvQWk9Y
   cqiZ4YDcxfG1ltFmPWTwmcIe86zZvOt3MRr3LdZeznYkuAJOpSVWSUscQ
   gGAFlHZ+wj6rkBlfmvdKhFxxLvcnt6PsINMa/LYKnsxGpahS9L6Nl/+Em
   92GlchwxXy/MnVwiS7W+8CWVHXsuKTclSul0fsVy0mDIeDt/RPANY4Lr9
   g==;
X-CSE-ConnectionGUID: x2MDSIlzQ0my24oBUOBWGQ==
X-CSE-MsgGUID: AtB97dv0TJeoc+7XTBRoNw==
X-IronPort-AV: E=McAfee;i="6700,10204,11296"; a="35878126"
X-IronPort-AV: E=Sophos;i="6.12,266,1728975600"; 
   d="scan'208";a="35878126"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2024 07:45:15 -0800
X-CSE-ConnectionGUID: 3P2Qk+HxT7yjZMs9/7oleg==
X-CSE-MsgGUID: mjKk9T44R1C5DsA5WYTqbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,266,1728975600"; 
   d="scan'208";a="99777975"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2024 07:45:12 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Yedidya Benshimol <yedidya.ben.shimol@intel.com>
Subject: [PATCH 01/15] wifi: iwlwifi: remove mvm from session protection cmd's name
Date: Thu, 26 Dec 2024 17:44:42 +0200
Message-Id: <20241226174257.0cd9ae2499b6.If228310b0578e5da88ccb28ff8dceb56e1c61b27@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241226154456.473690-1-miriam.rachel.korenblit@intel.com>
References: <20241226154456.473690-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Yedidya Benshimol <yedidya.ben.shimol@intel.com>

As the session protection command will be used in mld, it shouldn't
be associated by name to mvm

Signed-off-by: Yedidya Benshimol <yedidya.ben.shimol@intel.com>
---
 .../net/wireless/intel/iwlwifi/fw/api/mac-cfg.h  |  2 +-
 .../wireless/intel/iwlwifi/fw/api/time-event.h   | 16 ++++++++--------
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c     |  2 +-
 .../net/wireless/intel/iwlwifi/mvm/time-event.c  | 10 +++++-----
 4 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h b/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
index b23d5fc4bbe6..37bb7002c1c9 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
@@ -74,7 +74,7 @@ enum iwl_mac_conf_subcmd_ids {
 	 */
 	ROC_NOTIF = 0xF8,
 	/**
-	 * @SESSION_PROTECTION_NOTIF: &struct iwl_mvm_session_prot_notif
+	 * @SESSION_PROTECTION_NOTIF: &struct iwl_session_prot_notif
 	 */
 	SESSION_PROTECTION_NOTIF = 0xFB,
 
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/time-event.h b/drivers/net/wireless/intel/iwlwifi/fw/api/time-event.h
index f4b827b58bd3..18d030334a6a 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/time-event.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/time-event.h
@@ -395,7 +395,7 @@ struct iwl_roc_notif {
 } __packed; /* ROC_NOTIF_API_S_VER_1 */
 
 /**
- * enum iwl_mvm_session_prot_conf_id - session protection's configurations
+ * enum iwl_session_prot_conf_id - session protection's configurations
  * @SESSION_PROTECT_CONF_ASSOC: Start a session protection for association.
  *	The firmware will allocate two events.
  *	Valid for BSS_STA and P2P_STA.
@@ -424,7 +424,7 @@ struct iwl_roc_notif {
  *	be taken into account.
  * @SESSION_PROTECT_CONF_MAX_ID: not used
  */
-enum iwl_mvm_session_prot_conf_id {
+enum iwl_session_prot_conf_id {
 	SESSION_PROTECT_CONF_ASSOC,
 	SESSION_PROTECT_CONF_GO_CLIENT_ASSOC,
 	SESSION_PROTECT_CONF_P2P_DEVICE_DISCOV,
@@ -433,12 +433,12 @@ enum iwl_mvm_session_prot_conf_id {
 }; /* SESSION_PROTECTION_CONF_ID_E_VER_1 */
 
 /**
- * struct iwl_mvm_session_prot_cmd - configure a session protection
+ * struct iwl_session_prot_cmd - configure a session protection
  * @id_and_color: the id and color of the link (or mac, for command version 1)
  *	for which this session protection is sent
  * @action: can be either FW_CTXT_ACTION_ADD or FW_CTXT_ACTION_REMOVE,
  *	see &enum iwl_ctxt_action
- * @conf_id: see &enum iwl_mvm_session_prot_conf_id
+ * @conf_id: see &enum iwl_session_prot_conf_id
  * @duration_tu: the duration of the whole protection in TUs.
  * @repetition_count: not used
  * @interval: not used
@@ -448,7 +448,7 @@ enum iwl_mvm_session_prot_conf_id {
  * The firmware supports only one concurrent session protection per vif.
  * Adding a new session protection will remove any currently running session.
  */
-struct iwl_mvm_session_prot_cmd {
+struct iwl_session_prot_cmd {
 	/* COMMON_INDEX_HDR_API_S_VER_1 hdr */
 	__le32 id_and_color;
 	__le32 action;
@@ -462,17 +462,17 @@ struct iwl_mvm_session_prot_cmd {
  */
 
 /**
- * struct iwl_mvm_session_prot_notif - session protection started / ended
+ * struct iwl_session_prot_notif - session protection started / ended
  * @mac_link_id: the mac id (or link id, for notif ver > 2) for which the
  *	session protection started / ended
  * @status: 1 means success, 0 means failure
  * @start: 1 means the session protection started, 0 means it ended
- * @conf_id: see &enum iwl_mvm_session_prot_conf_id
+ * @conf_id: see &enum iwl_session_prot_conf_id
  *
  * Note that any session protection will always get two notifications: start
  * and end even the firmware could not schedule it.
  */
-struct iwl_mvm_session_prot_notif {
+struct iwl_session_prot_notif {
 	__le32 mac_link_id;
 	__le32 status;
 	__le32 start;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 30fcc733395e..0deaf6ed8994 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -408,7 +408,7 @@ static const struct iwl_rx_handlers iwl_mvm_rx_handlers[] = {
 		   RX_HANDLER_SYNC, struct iwl_time_event_notif),
 	RX_HANDLER_GRP(MAC_CONF_GROUP, SESSION_PROTECTION_NOTIF,
 		       iwl_mvm_rx_session_protect_notif, RX_HANDLER_SYNC,
-		       struct iwl_mvm_session_prot_notif),
+		       struct iwl_session_prot_notif),
 	RX_HANDLER(MCC_CHUB_UPDATE_CMD, iwl_mvm_rx_chub_update_mcc,
 		   RX_HANDLER_ASYNC_LOCKED, struct iwl_mcc_chub_notif),
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
index 72fa7ac86516..9216c43a35c4 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
@@ -751,7 +751,7 @@ static void iwl_mvm_cancel_session_protection(struct iwl_mvm *mvm,
 					      u32 id, s8 link_id)
 {
 	int mac_link_id = iwl_mvm_get_session_prot_id(mvm, vif, link_id);
-	struct iwl_mvm_session_prot_cmd cmd = {
+	struct iwl_session_prot_cmd cmd = {
 		.id_and_color = cpu_to_le32(mac_link_id),
 		.action = cpu_to_le32(FW_CTXT_ACTION_REMOVE),
 		.conf_id = cpu_to_le32(id),
@@ -955,7 +955,7 @@ void iwl_mvm_rx_session_protect_notif(struct iwl_mvm *mvm,
 				      struct iwl_rx_cmd_buffer *rxb)
 {
 	struct iwl_rx_packet *pkt = rxb_addr(rxb);
-	struct iwl_mvm_session_prot_notif *notif = (void *)pkt->data;
+	struct iwl_session_prot_notif *notif = (void *)pkt->data;
 	unsigned int ver =
 		iwl_fw_lookup_notif_ver(mvm->fw, MAC_CONF_GROUP,
 					SESSION_PROTECTION_NOTIF, 2);
@@ -1148,7 +1148,7 @@ iwl_mvm_start_p2p_roc_session_protection(struct iwl_mvm *mvm,
 					 enum ieee80211_roc_type type)
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
-	struct iwl_mvm_session_prot_cmd cmd = {
+	struct iwl_session_prot_cmd cmd = {
 		.id_and_color =
 			cpu_to_le32(iwl_mvm_get_session_prot_id(mvm, vif, 0)),
 		.action = cpu_to_le32(FW_CTXT_ACTION_ADD),
@@ -1417,7 +1417,7 @@ static bool iwl_mvm_session_prot_notif(struct iwl_notif_wait_data *notif_wait,
 {
 	struct iwl_mvm *mvm =
 		container_of(notif_wait, struct iwl_mvm, notif_wait);
-	struct iwl_mvm_session_prot_notif *resp;
+	struct iwl_session_prot_notif *resp;
 	int resp_len = iwl_rx_packet_payload_len(pkt);
 
 	if (WARN_ON(pkt->hdr.cmd != SESSION_PROTECTION_NOTIF ||
@@ -1449,7 +1449,7 @@ void iwl_mvm_schedule_session_protection(struct iwl_mvm *mvm,
 	const u16 notif[] = { WIDE_ID(MAC_CONF_GROUP, SESSION_PROTECTION_NOTIF) };
 	struct iwl_notification_wait wait_notif;
 	int mac_link_id = iwl_mvm_get_session_prot_id(mvm, vif, (s8)link_id);
-	struct iwl_mvm_session_prot_cmd cmd = {
+	struct iwl_session_prot_cmd cmd = {
 		.id_and_color = cpu_to_le32(mac_link_id),
 		.action = cpu_to_le32(FW_CTXT_ACTION_ADD),
 		.conf_id = cpu_to_le32(SESSION_PROTECT_CONF_ASSOC),
-- 
2.34.1


