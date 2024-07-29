Return-Path: <linux-wireless+bounces-10633-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5227793FC57
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jul 2024 19:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD2B61F2219A
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jul 2024 17:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F1E9186E4F;
	Mon, 29 Jul 2024 17:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="conzd0Ns"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285041741C6
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jul 2024 17:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722273654; cv=none; b=bEw4ZytRO6lLx0j0RI7fepU0pUhOIK9HT9gZSWv1OBjz/BDUycakjXchdkkOSvhZiWHGjS0PI9RF85wyzXHdNa9zL2K06DJj7tWDnle+S3rOtbG/V/Y4nC+QfXrWzommIc4DijkfVjefAdLL/QiKNft8whqRNBT7s1NC7EOU5YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722273654; c=relaxed/simple;
	bh=+WBaL7RtodciVAjL8g1jXFbCmk59wU7y+nTimmKhLts=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YSf2oJr2AKJ0k7vgsZsneTYgohBuPDRHmpRcIB3ckEMdocvboll7WTLcC0J0mJNZkkZ9c4fnQkFQinqa3x0mcyXR7joVNHW4Q7R4n1asvPeOTPQcbDIIyDMThiHmyGYbRKkQt/7EXwSszGOS3VurQFhvySgK2WtG0wNvtSHTfLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=conzd0Ns; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722273652; x=1753809652;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+WBaL7RtodciVAjL8g1jXFbCmk59wU7y+nTimmKhLts=;
  b=conzd0Ns6p7SDY8Ounmfnx0SsAEFKfm9En6IxapBL8hhz2P59k3U6EI+
   ibO6/pGBZdV6JPE26X36lzkgcGKs2bXlXCVuQR3muKFW1ZJ0SYl2E7dhn
   47tAOaHUQ861cTDXSchfN1n7CJgdvrIVGcbhbMGb0fS8/5AsOd2e1wAQv
   8+p2ujAsg6svylNE02k3VgeNaCikv3a2yW0iiV6wzslNAUlHdPF0swza4
   U1Y94UbudJJ22xsYEi0ptWLJkjoIL4GyP6Fw3UNS0G0PMmGfXtNfJWqbQ
   Lsq7Sv9iuIjCptdieDO3gpj5o/FD4RReyOY9YI5gKinDucTI6rDXZJoX1
   g==;
X-CSE-ConnectionGUID: cAaRk3dXR6O3MQNbNTFQ4w==
X-CSE-MsgGUID: HB7MsfavRp2Adh1uJhU+eA==
X-IronPort-AV: E=McAfee;i="6700,10204,11148"; a="31445622"
X-IronPort-AV: E=Sophos;i="6.09,246,1716274800"; 
   d="scan'208";a="31445622"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 10:20:52 -0700
X-CSE-ConnectionGUID: Wg9xTKwjT0CPX+TjLFSpQw==
X-CSE-MsgGUID: biFXYmzlTJ2NCRKecpTvxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,246,1716274800"; 
   d="scan'208";a="54288348"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 10:20:50 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 13/17] wifi: iwlwifi: mvm: start to support the new BT profile notification
Date: Mon, 29 Jul 2024 20:20:14 +0300
Message-Id: <20240729201718.637499f3a85a.I8bf654cf5d8aa038100273876c936845ecc338f7@changeid>
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

We have a new notification the BT profile. It contains almost nothing,
only the wifi loss information. Copy this into mvm. We still need to
iterate over the vifs / links to use this data.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/fw/api/coex.h  | 25 +++++++++++
 .../wireless/intel/iwlwifi/fw/api/commands.h  |  3 ++
 drivers/net/wireless/intel/iwlwifi/mvm/coex.c | 41 +++++++++++++++----
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  9 +++-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  | 11 +++++
 5 files changed, 80 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/coex.h b/drivers/net/wireless/intel/iwlwifi/fw/api/coex.h
index 433bda61c32e..ddc84430d895 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/coex.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/coex.h
@@ -126,4 +126,29 @@ struct iwl_bt_coex_prof_old_notif {
 	     * BT_COEX_PROFILE_NTFY_API_S_VER_5
 	     */
 
+/**
+ * enum iwl_bt_coex_subcmd_ids - coex configuration command IDs
+ */
+enum iwl_bt_coex_subcmd_ids {
+       /**
+	*@PROFILE_NOTIF: &struct iwl_bt_coex_profile_notif
+	*/
+	PROFILE_NOTIF = 0xFF,
+};
+
+#define COEX_NUM_BAND	3
+#define COEX_NUM_CHAINS	2
+
+/**
+ * struct iwl_bt_coex_profile_notif - notification about BT coex
+ * @wifi_loss_low_rssi: The predicted lost WiFi rate (% of air time that BT is
+ *	utilizing) when the RSSI is low (<= -65 dBm)
+ * @wifi_loss_mid_high_rssi: The predicted lost WiFi rate (% of air time that
+ *	BT is utilizing) when the RSSI is mid/high (>= -65 dBm)
+ */
+struct iwl_bt_coex_profile_notif {
+	u8 wifi_loss_low_rssi[COEX_NUM_BAND][COEX_NUM_CHAINS];
+	u8 wifi_loss_mid_high_rssi[COEX_NUM_BAND][COEX_NUM_CHAINS];
+} __packed; /* BT_COEX_BT_PROFILE_NTF_API_S_VER_1 */
+
 #endif /* __iwl_fw_api_coex_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h b/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h
index 548eeca09881..377fac278511 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h
@@ -25,6 +25,8 @@
  * @NAN_GROUP: NAN group, uses command IDs from &enum iwl_nan_subcmd_ids
  * @LOCATION_GROUP: location group, uses command IDs from
  *	&enum iwl_location_subcmd_ids
+ * @BT_COEX_GROUP: bt coex group, uses command IDs from
+ *	&enum iwl_bt_coex_subcmd_ids
  * @PROT_OFFLOAD_GROUP: protocol offload group, uses command IDs from
  *	&enum iwl_prot_offload_subcmd_ids
  * @REGULATORY_AND_NVM_GROUP: regulatory/NVM group, uses command IDs from
@@ -43,6 +45,7 @@ enum iwl_mvm_command_groups {
 	SCAN_GROUP = 0x6,
 	NAN_GROUP = 0x7,
 	LOCATION_GROUP = 0x8,
+	BT_COEX_GROUP = 0x9,
 	PROT_OFFLOAD_GROUP = 0xb,
 	REGULATORY_AND_NVM_GROUP = 0xc,
 	DEBUG_GROUP = 0xf,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/coex.c b/drivers/net/wireless/intel/iwlwifi/mvm/coex.c
index f2912105c7b5..0bfe250c3bc8 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/coex.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/coex.c
@@ -266,10 +266,26 @@ iwl_mvm_bt_coex_calculate_esr_mode(struct iwl_mvm *mvm,
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	bool have_wifi_loss_rate =
 		iwl_fw_lookup_notif_ver(mvm->fw, LEGACY_GROUP,
-					BT_PROFILE_NOTIFICATION, 0) > 4;
+					BT_PROFILE_NOTIFICATION, 0) > 4 ||
+		iwl_fw_lookup_notif_ver(mvm->fw, BT_COEX_GROUP,
+					PROFILE_NOTIF, 0) >= 1;
+	u8 wifi_loss_mid_high_rssi;
+	u8 wifi_loss_low_rssi;
 	u8 wifi_loss_rate;
 
-	if (mvm->last_bt_notif.wifi_loss_low_rssi == BT_OFF)
+	if (iwl_fw_lookup_notif_ver(mvm->fw, BT_COEX_GROUP,
+				    PROFILE_NOTIF, 0) >= 1) {
+		/* For now, we consider 2.4 GHz band / ANT_A only */
+		wifi_loss_mid_high_rssi =
+			mvm->last_bt_wifi_loss.wifi_loss_mid_high_rssi[PHY_BAND_24][0];
+		wifi_loss_low_rssi =
+			mvm->last_bt_wifi_loss.wifi_loss_low_rssi[PHY_BAND_24][0];
+	} else {
+		wifi_loss_mid_high_rssi = mvm->last_bt_notif.wifi_loss_mid_high_rssi;
+		wifi_loss_low_rssi = mvm->last_bt_notif.wifi_loss_low_rssi;
+	}
+
+	if (wifi_loss_low_rssi == BT_OFF)
 		return true;
 
 	if (primary)
@@ -286,20 +302,20 @@ iwl_mvm_bt_coex_calculate_esr_mode(struct iwl_mvm *mvm,
 	 * we will get an update on this and exit eSR.
 	 */
 	if (!link_rssi)
-		wifi_loss_rate = mvm->last_bt_notif.wifi_loss_mid_high_rssi;
+		wifi_loss_rate = wifi_loss_mid_high_rssi;
 
 	else if (mvmvif->esr_active)
 		 /* RSSI needs to get really low to disable eSR... */
 		wifi_loss_rate =
 			link_rssi <= -IWL_MVM_BT_COEX_DISABLE_ESR_THRESH ?
-				mvm->last_bt_notif.wifi_loss_low_rssi :
-				mvm->last_bt_notif.wifi_loss_mid_high_rssi;
+				wifi_loss_low_rssi :
+				wifi_loss_mid_high_rssi;
 	else
 		/* ...And really high before we enable it back */
 		wifi_loss_rate =
 			link_rssi <= -IWL_MVM_BT_COEX_ENABLE_ESR_THRESH ?
-				mvm->last_bt_notif.wifi_loss_low_rssi :
-				mvm->last_bt_notif.wifi_loss_mid_high_rssi;
+				wifi_loss_low_rssi :
+				wifi_loss_mid_high_rssi;
 
 	return wifi_loss_rate <= IWL_MVM_BT_COEX_WIFI_LOSS_THRESH;
 }
@@ -612,6 +628,17 @@ void iwl_mvm_rx_bt_coex_old_notif(struct iwl_mvm *mvm,
 	iwl_mvm_bt_coex_notif_handle(mvm);
 }
 
+void iwl_mvm_rx_bt_coex_notif(struct iwl_mvm *mvm,
+			      struct iwl_rx_cmd_buffer *rxb)
+{
+	const struct iwl_rx_packet *pkt = rxb_addr(rxb);
+	const struct iwl_bt_coex_profile_notif *notif = (const void *)pkt->data;
+
+	mvm->last_bt_wifi_loss = *notif;
+
+	/* TODO: Iterate over vifs / links to take that into account */
+}
+
 void iwl_mvm_bt_rssi_event(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 			   enum ieee80211_rssi_event_data rssi_event)
 {
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index b968ca0c6a40..9cb7045cc0ba 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1200,8 +1200,11 @@ struct iwl_mvm {
 
 	wait_queue_head_t rx_sync_waitq;
 
-	/* BT-Coex */
-	struct iwl_bt_coex_prof_old_notif last_bt_notif;
+	/* BT-Coex - only one of those will be used */
+	union {
+		struct iwl_bt_coex_prof_old_notif last_bt_notif;
+		struct iwl_bt_coex_profile_notif last_bt_wifi_loss;
+	};
 	struct iwl_bt_coex_ci_cmd last_bt_ci_cmd;
 
 	u8 bt_tx_prio;
@@ -2324,6 +2327,8 @@ int iwl_mvm_send_proto_offload(struct iwl_mvm *mvm,
 int iwl_mvm_send_bt_init_conf(struct iwl_mvm *mvm);
 void iwl_mvm_rx_bt_coex_old_notif(struct iwl_mvm *mvm,
 				  struct iwl_rx_cmd_buffer *rxb);
+void iwl_mvm_rx_bt_coex_notif(struct iwl_mvm *mvm,
+			      struct iwl_rx_cmd_buffer *rxb);
 void iwl_mvm_bt_rssi_event(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 			   enum ieee80211_rssi_event_data);
 void iwl_mvm_bt_coex_vif_change(struct iwl_mvm *mvm);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index cb123852fe94..279c92307420 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -336,6 +336,9 @@ static const struct iwl_rx_handlers iwl_mvm_rx_handlers[] = {
 	RX_HANDLER(BT_PROFILE_NOTIFICATION, iwl_mvm_rx_bt_coex_old_notif,
 		   RX_HANDLER_ASYNC_LOCKED_WIPHY,
 		   struct iwl_bt_coex_prof_old_notif),
+	RX_HANDLER_GRP(BT_COEX_GROUP, PROFILE_NOTIF, iwl_mvm_rx_bt_coex_notif,
+		       RX_HANDLER_ASYNC_LOCKED_WIPHY,
+		       struct iwl_bt_coex_profile_notif),
 	RX_HANDLER_NO_SIZE(BEACON_NOTIFICATION, iwl_mvm_rx_beacon_notif,
 			   RX_HANDLER_ASYNC_LOCKED),
 	RX_HANDLER_NO_SIZE(STATISTICS_NOTIFICATION, iwl_mvm_rx_statistics,
@@ -713,6 +716,13 @@ static const struct iwl_hcmd_names iwl_mvm_regulatory_and_nvm_names[] = {
 	HCMD_NAME(TAS_CONFIG),
 };
 
+/* Please keep this array *SORTED* by hex value.
+ * Access is done through binary search
+ */
+static const struct iwl_hcmd_names iwl_mvm_bt_coex_names[] = {
+	HCMD_NAME(PROFILE_NOTIF),
+};
+
 static const struct iwl_hcmd_arr iwl_mvm_groups[] = {
 	[LEGACY_GROUP] = HCMD_ARR(iwl_mvm_legacy_names),
 	[LONG_GROUP] = HCMD_ARR(iwl_mvm_legacy_names),
@@ -722,6 +732,7 @@ static const struct iwl_hcmd_arr iwl_mvm_groups[] = {
 	[DATA_PATH_GROUP] = HCMD_ARR(iwl_mvm_data_path_names),
 	[SCAN_GROUP] = HCMD_ARR(iwl_mvm_scan_names),
 	[LOCATION_GROUP] = HCMD_ARR(iwl_mvm_location_names),
+	[BT_COEX_GROUP] = HCMD_ARR(iwl_mvm_bt_coex_names),
 	[PROT_OFFLOAD_GROUP] = HCMD_ARR(iwl_mvm_prot_offload_names),
 	[REGULATORY_AND_NVM_GROUP] =
 		HCMD_ARR(iwl_mvm_regulatory_and_nvm_names),
-- 
2.34.1


