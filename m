Return-Path: <linux-wireless+bounces-10632-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B052493FC55
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jul 2024 19:21:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D41051C2207F
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jul 2024 17:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C5415F3EA;
	Mon, 29 Jul 2024 17:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ROSzdJKH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D1E186E23
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jul 2024 17:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722273652; cv=none; b=GcWWKxSzsqB5NwJ1rRXkwWTcztzxr+sjrlzm1mIviTeMnendpu00TJ6oRxudRV0IJB+pGxwAXizllt+p0q9USgqJ9sYSE1rXzP3WGMU3mOgjN1KbJCjtBTZPgEBgKZBOuL2/IEqOu64ZjgV/OTdu6dMywK4X9nILArIJU/64aUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722273652; c=relaxed/simple;
	bh=uuuDM+MidvHhd2Ig3wFlbjLPlD7dKplJvtzEEV/WxpA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MBOFNeILCcmzdJ9sJgz6gyr5DSQQRucYQySPL8HrhhyrMRJbHwftOOkpFI3JCO33X+L8dJ8A2y1FEUaz1cjZZ3KMxJ9QSd6Gg3HOlJZpyKrRWcoyjsPDNF41mxfkt52CZpQO03Xn0BWnqRncHyjoCYBLA+D4jmzmSHEvMDkWagQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ROSzdJKH; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722273651; x=1753809651;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uuuDM+MidvHhd2Ig3wFlbjLPlD7dKplJvtzEEV/WxpA=;
  b=ROSzdJKHtKyVp/7xIyAHcNRmpeO6xlg73bskA9eS247vOVW4UOQFuhAZ
   O7GTwaZHVY/UMqO5P8pl4x/f7stIJU0QQqJ5gP7JgParJ1fNqYiHKoVTX
   CMBh/WUc2kLJnpGkU2qMJyNYIX3tdh3XIUWK0lXysExstOX16dtO1lBrr
   TFRRzhDqaGfNPtawZgAe//ZICOly9iFyDA/pj8Pxx5Lph8OV7235/zxlW
   X6gPexNWhbmpb0fdHF0vetN0acDgOcjSQxnU0OyGrwBOHPZdKSqeN9z2/
   P1AW7oCJGgygBAzbSVSfmpFDI4rKX5XZ5nalCDc71PWvcKrAC96Dp6qLM
   Q==;
X-CSE-ConnectionGUID: TYdDzkWHT2eyY/UL0etm8w==
X-CSE-MsgGUID: CMQ7fqGHQiO2YVTTX+lzcA==
X-IronPort-AV: E=McAfee;i="6700,10204,11148"; a="31445608"
X-IronPort-AV: E=Sophos;i="6.09,246,1716274800"; 
   d="scan'208";a="31445608"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 10:20:50 -0700
X-CSE-ConnectionGUID: YOckzLtDTl6g1J3WGayd8g==
X-CSE-MsgGUID: 1DMf3GQQQ8WJci63Ohlpnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,246,1716274800"; 
   d="scan'208";a="54288339"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 10:20:48 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 12/17] wifi: iwlwifi: mvm: s/iwl_bt_coex_profile_notif/iwl_bt_coex_prof_old_notif
Date: Mon, 29 Jul 2024 20:20:13 +0300
Message-Id: <20240729201718.dc29fd0d7817.I5881fce86ec8b76ae98d2948265434b8e7d860c1@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240729172018.1993751-1-miriam.rachel.korenblit@intel.com>
References: <20240729172018.1993751-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

The iwl_bt_coex_profile_notif is now being obsoleted. It'll be replaced
by a new notification coming with a non-legacy group. Rename it to avoid
confusion.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/coex.h     | 4 ++--
 drivers/net/wireless/intel/iwlwifi/fw/api/commands.h | 4 ++--
 drivers/net/wireless/intel/iwlwifi/mvm/coex.c        | 8 ++++----
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h         | 6 +++---
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c         | 4 ++--
 5 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/coex.h b/drivers/net/wireless/intel/iwlwifi/fw/api/coex.h
index b97a43353779..433bda61c32e 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/coex.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/coex.h
@@ -95,7 +95,7 @@ enum iwl_bt_ci_compliance {
 }; /* BT_COEX_CI_COMPLIENCE_E_VER_1 */
 
 /**
- * struct iwl_bt_coex_profile_notif - notification about BT coex
+ * struct iwl_bt_coex_prof_old_notif - notification about BT coex
  * @mbox_msg: message from BT to WiFi
  * @msg_idx: the index of the message
  * @bt_ci_compliance: enum %iwl_bt_ci_compliance
@@ -110,7 +110,7 @@ enum iwl_bt_ci_compliance {
  * @wifi_loss_mid_high_rssi: The predicted lost WiFi rate (% of air time that
  *	BT is utilizing) when the RSSI is mid/high (>= -65 dBm)
  */
-struct iwl_bt_coex_profile_notif {
+struct iwl_bt_coex_prof_old_notif {
 	__le32 mbox_msg[4];
 	__le32 msg_idx;
 	__le32 bt_ci_compliance;
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h b/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h
index 7544c4cb1a30..548eeca09881 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h
@@ -2,7 +2,7 @@
 /*
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
- * Copyright (C) 2018-2022 Intel Corporation
+ * Copyright (C) 2018-2022, 2024 Intel Corporation
  */
 #ifndef __iwl_fw_api_commands_h__
 #define __iwl_fw_api_commands_h__
@@ -467,7 +467,7 @@ enum iwl_legacy_cmds {
 	MARKER_CMD = 0xcb,
 
 	/**
-	 * @BT_PROFILE_NOTIFICATION: &struct iwl_bt_coex_profile_notif
+	 * @BT_PROFILE_NOTIFICATION: &struct iwl_bt_coex_prof_old_notif
 	 */
 	BT_PROFILE_NOTIFICATION = 0xce,
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/coex.c b/drivers/net/wireless/intel/iwlwifi/mvm/coex.c
index ad3e14a0d043..f2912105c7b5 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/coex.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/coex.c
@@ -208,7 +208,7 @@ static int iwl_mvm_bt_coex_reduced_txp(struct iwl_mvm *mvm, u8 sta_id,
 }
 
 struct iwl_bt_iterator_data {
-	struct iwl_bt_coex_profile_notif *notif;
+	struct iwl_bt_coex_prof_old_notif *notif;
 	struct iwl_mvm *mvm;
 	struct ieee80211_chanctx_conf *primary;
 	struct ieee80211_chanctx_conf *secondary;
@@ -591,11 +591,11 @@ static void iwl_mvm_bt_coex_notif_handle(struct iwl_mvm *mvm)
 	}
 }
 
-void iwl_mvm_rx_bt_coex_notif(struct iwl_mvm *mvm,
-			      struct iwl_rx_cmd_buffer *rxb)
+void iwl_mvm_rx_bt_coex_old_notif(struct iwl_mvm *mvm,
+				  struct iwl_rx_cmd_buffer *rxb)
 {
 	struct iwl_rx_packet *pkt = rxb_addr(rxb);
-	struct iwl_bt_coex_profile_notif *notif = (void *)pkt->data;
+	struct iwl_bt_coex_prof_old_notif *notif = (void *)pkt->data;
 
 	IWL_DEBUG_COEX(mvm, "BT Coex Notification received\n");
 	IWL_DEBUG_COEX(mvm, "\tBT ci compliance %d\n", notif->bt_ci_compliance);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index e2cc378d6d91..b968ca0c6a40 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1201,7 +1201,7 @@ struct iwl_mvm {
 	wait_queue_head_t rx_sync_waitq;
 
 	/* BT-Coex */
-	struct iwl_bt_coex_profile_notif last_bt_notif;
+	struct iwl_bt_coex_prof_old_notif last_bt_notif;
 	struct iwl_bt_coex_ci_cmd last_bt_ci_cmd;
 
 	u8 bt_tx_prio;
@@ -2322,8 +2322,8 @@ int iwl_mvm_send_proto_offload(struct iwl_mvm *mvm,
 
 /* BT Coex */
 int iwl_mvm_send_bt_init_conf(struct iwl_mvm *mvm);
-void iwl_mvm_rx_bt_coex_notif(struct iwl_mvm *mvm,
-			      struct iwl_rx_cmd_buffer *rxb);
+void iwl_mvm_rx_bt_coex_old_notif(struct iwl_mvm *mvm,
+				  struct iwl_rx_cmd_buffer *rxb);
 void iwl_mvm_bt_rssi_event(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 			   enum ieee80211_rssi_event_data);
 void iwl_mvm_bt_coex_vif_change(struct iwl_mvm *mvm);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index b7dcae76a05d..cb123852fe94 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -333,9 +333,9 @@ static const struct iwl_rx_handlers iwl_mvm_rx_handlers[] = {
 		       iwl_mvm_tlc_update_notif, RX_HANDLER_SYNC,
 		       struct iwl_tlc_update_notif),
 
-	RX_HANDLER(BT_PROFILE_NOTIFICATION, iwl_mvm_rx_bt_coex_notif,
+	RX_HANDLER(BT_PROFILE_NOTIFICATION, iwl_mvm_rx_bt_coex_old_notif,
 		   RX_HANDLER_ASYNC_LOCKED_WIPHY,
-		   struct iwl_bt_coex_profile_notif),
+		   struct iwl_bt_coex_prof_old_notif),
 	RX_HANDLER_NO_SIZE(BEACON_NOTIFICATION, iwl_mvm_rx_beacon_notif,
 			   RX_HANDLER_ASYNC_LOCKED),
 	RX_HANDLER_NO_SIZE(STATISTICS_NOTIFICATION, iwl_mvm_rx_statistics,
-- 
2.34.1


