Return-Path: <linux-wireless+bounces-8120-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C28AA8D07F6
	for <lists+linux-wireless@lfdr.de>; Mon, 27 May 2024 18:17:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 739B02A8761
	for <lists+linux-wireless@lfdr.de>; Mon, 27 May 2024 16:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DFA615A874;
	Mon, 27 May 2024 16:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SrAe79Y0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660E715D5D2
	for <linux-wireless@vger.kernel.org>; Mon, 27 May 2024 16:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716825995; cv=none; b=CZuFm8DA2oUIP/8+vQQBbTwUtWC/QmdxZqgdogn7UpF/rkt0w/a+fDKHIHq9dR6jfG2Bg8doaZiE95e/do0dXob36lxX7cusX8GR9eYOtd9qVyjM9xJ0V/hLwlMY2sTnpiWZHDqKF6bvCk7WCgc61And/IHb8gG0/T4u9Dm0S3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716825995; c=relaxed/simple;
	bh=c4GBhdjRv1DldMu0+bvicmxHq/r6v+Y95sJs0PPz5/U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g2i9lPA8iNikgQpEtFwse/5isfEgvLMNnuinR8n6TdMtpMESO0IpV89i4cqYzVbiK8VonWL+i11Gi7AnPR39BkHDAr1XkbhHfq8/TaFrEdzFqDxQqkj4azVTGeURpWzJb33wyNhEnvXN1AHo1aWrlObv3k/FZOEz3mwA2/ztfkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SrAe79Y0; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716825994; x=1748361994;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=c4GBhdjRv1DldMu0+bvicmxHq/r6v+Y95sJs0PPz5/U=;
  b=SrAe79Y0u2IbDfrkxHK/kEVyUbNn/Dpbo4zi9S3E8OQC0xITimMdIOcH
   0FsZKEaAxLuzH2vpp2StCSNIirK/QmhTcyczXFpRtsHASNvcylMNx34Km
   c4sQEsxCC27ti2Wfk2UE8z3q3AZy6Kn7NXpcZzKJOAJvT3vcJxJ3pMO8Z
   JiBsp9hnc8bc/75KwhTSWm7B+nx1TQYHkX2dFv4HupBY8pMeI1I7Be7ch
   KhdMjakqGQPOK5A3Zw2HrG5kWOL2yx6TF4PsRI6M48xNFmhE7NSCEi2Mx
   u/w7d5tBLeYNDUk+Y1uWtYIV0uf24/poN7OWg6g/NkgbckeRMWRkq3F6I
   A==;
X-CSE-ConnectionGUID: qcAB4I0ZQtS/CWvSJWhv8A==
X-CSE-MsgGUID: IFqX0KcESYKhCVQvRZXiew==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13002079"
X-IronPort-AV: E=Sophos;i="6.08,193,1712646000"; 
   d="scan'208";a="13002079"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 09:06:34 -0700
X-CSE-ConnectionGUID: 9OQxxAzkQb2WOYYwcIOq2Q==
X-CSE-MsgGUID: d7kItj29TNShBdzXcE47RA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,193,1712646000"; 
   d="scan'208";a="35407088"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 09:06:32 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Mukesh Sisodiya <mukesh.sisodiya@intel.com>
Subject: [PATCH 06/20] wifi: iwlwifi: mvm: handle TPE advertised by AP
Date: Mon, 27 May 2024 19:06:01 +0300
Message-Id: <20240527190228.32f1e2e1447c.I58ac91c38585362aa42bb4a8a59c7d88e67bc40b@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240527160615.1549563-1-miriam.rachel.korenblit@intel.com>
References: <20240527160615.1549563-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

6 GHz BSS SP client shall respect TX power limits advertised
by the AP in TPE elements, send the data to the firmware using
the AP_TX_POWER_CONSTRAINTS_CMD command, so do that.

Co-developed-by: Mukesh Sisodiya <mukesh.sisodiya@intel.com>
Signed-off-by: Mukesh Sisodiya <mukesh.sisodiya@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 11 ++++
 .../wireless/intel/iwlwifi/mvm/mld-mac80211.c | 55 ++++++++++++++++---
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  6 ++
 3 files changed, 63 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 752fdb6a783f..88bc0baabf7e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -2768,6 +2768,13 @@ iwl_mvm_bss_info_changed_station_common(struct iwl_mvm *mvm,
 
 	if (changes & BSS_CHANGED_BANDWIDTH)
 		iwl_mvm_update_link_smps(vif, link_conf);
+
+	if (changes & BSS_CHANGED_TPE) {
+		IWL_DEBUG_CALIB(mvm, "Changing TPE\n");
+		iwl_mvm_send_ap_tx_power_constraint_cmd(mvm, vif,
+							link_conf,
+							false);
+	}
 }
 
 static void iwl_mvm_bss_info_changed_station(struct iwl_mvm *mvm,
@@ -5122,6 +5129,10 @@ static int __iwl_mvm_assign_vif_chanctx(struct iwl_mvm *mvm,
 		}
 
 		iwl_mvm_update_quotas(mvm, false, NULL);
+
+		iwl_mvm_send_ap_tx_power_constraint_cmd(mvm, vif,
+							link_conf,
+							false);
 	}
 
 	goto out;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
index 00433d1c8564..b2b6dbdcc44f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
@@ -345,6 +345,11 @@ __iwl_mvm_mld_assign_vif_chanctx(struct iwl_mvm *mvm,
 		rcu_read_unlock();
 	}
 
+	if (vif->type == NL80211_IFTYPE_STATION)
+		iwl_mvm_send_ap_tx_power_constraint_cmd(mvm, vif,
+							link_conf,
+							false);
+
 	/* then activate */
 	ret = iwl_mvm_link_changed(mvm, vif, link_conf,
 				   LINK_CONTEXT_MODIFY_ACTIVE |
@@ -524,9 +529,37 @@ static void iwl_mvm_mld_unassign_vif_chanctx(struct ieee80211_hw *hw,
 }
 
 static void
+iwl_mvm_tpe_sta_cmd_data(struct iwl_txpower_constraints_cmd *cmd,
+			 const struct ieee80211_bss_conf *bss_info)
+{
+	u8 i;
+
+	/*
+	 * NOTE: the 0 here is IEEE80211_TPE_CAT_6GHZ_DEFAULT,
+	 * we fully ignore IEEE80211_TPE_CAT_6GHZ_SUBORDINATE
+	 */
+
+	BUILD_BUG_ON(ARRAY_SIZE(cmd->psd_pwr) !=
+		     ARRAY_SIZE(bss_info->tpe.psd_local[0].power));
+
+	/* if not valid, mac80211 puts default (max value) */
+	for (i = 0; i < ARRAY_SIZE(cmd->psd_pwr); i++)
+		cmd->psd_pwr[i] = min(bss_info->tpe.psd_local[0].power[i],
+				      bss_info->tpe.psd_reg_client[0].power[i]);
+
+	BUILD_BUG_ON(ARRAY_SIZE(cmd->eirp_pwr) !=
+		     ARRAY_SIZE(bss_info->tpe.max_local[0].power));
+
+	for (i = 0; i < ARRAY_SIZE(cmd->eirp_pwr); i++)
+		cmd->eirp_pwr[i] = min(bss_info->tpe.max_local[0].power[i],
+				       bss_info->tpe.max_reg_client[0].power[i]);
+}
+
+void
 iwl_mvm_send_ap_tx_power_constraint_cmd(struct iwl_mvm *mvm,
 					struct ieee80211_vif *vif,
-					struct ieee80211_bss_conf *bss_conf)
+					struct ieee80211_bss_conf *bss_conf,
+					bool is_ap)
 {
 	struct iwl_txpower_constraints_cmd cmd = {};
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
@@ -546,19 +579,22 @@ iwl_mvm_send_ap_tx_power_constraint_cmd(struct iwl_mvm *mvm,
 	    link_info->fw_link_id == IWL_MVM_FW_LINK_ID_INVALID)
 		return;
 
-	if (bss_conf->chanreq.oper.chan->band != NL80211_BAND_6GHZ ||
-	    bss_conf->chanreq.oper.chan->flags &
-		    IEEE80211_CHAN_NO_6GHZ_VLP_CLIENT)
+	if (bss_conf->chanreq.oper.chan->band != NL80211_BAND_6GHZ)
 		return;
 
 	cmd.link_id = cpu_to_le16(link_info->fw_link_id);
-	/*
-	 * Currently supporting VLP Soft AP only.
-	 */
-	cmd.ap_type = cpu_to_le16(IWL_6GHZ_AP_TYPE_VLP);
 	memset(cmd.psd_pwr, DEFAULT_TPE_TX_POWER, sizeof(cmd.psd_pwr));
 	memset(cmd.eirp_pwr, DEFAULT_TPE_TX_POWER, sizeof(cmd.eirp_pwr));
 
+	if (is_ap) {
+		cmd.ap_type = cpu_to_le16(IWL_6GHZ_AP_TYPE_VLP);
+	} else if (bss_conf->power_type == IEEE80211_REG_UNSET_AP) {
+		return;
+	} else {
+		cmd.ap_type = cpu_to_le16(bss_conf->power_type - 1);
+		iwl_mvm_tpe_sta_cmd_data(&cmd, bss_conf);
+	}
+
 	ret = iwl_mvm_send_cmd_pdu(mvm,
 				   WIDE_ID(PHY_OPS_GROUP,
 					   AP_TX_POWER_CONSTRAINTS_CMD),
@@ -580,7 +616,8 @@ static int iwl_mvm_mld_start_ap_ibss(struct ieee80211_hw *hw,
 	guard(mvm)(mvm);
 
 	if (vif->type == NL80211_IFTYPE_AP)
-		iwl_mvm_send_ap_tx_power_constraint_cmd(mvm, vif, link_conf);
+		iwl_mvm_send_ap_tx_power_constraint_cmd(mvm, vif,
+							link_conf, true);
 
 	/* Send the beacon template */
 	ret = iwl_mvm_mac_ctxt_beacon_changed(mvm, vif, link_conf);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index f3d9b8355c6b..9b939225990a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -2962,4 +2962,10 @@ iwl_mvm_bt_coex_calculate_esr_mode(struct iwl_mvm *mvm,
 				   bool primary);
 int iwl_mvm_esr_non_bss_link(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 			     unsigned int link_id, bool active);
+
+void
+iwl_mvm_send_ap_tx_power_constraint_cmd(struct iwl_mvm *mvm,
+					struct ieee80211_vif *vif,
+					struct ieee80211_bss_conf *bss_conf,
+					bool is_ap);
 #endif /* __IWL_MVM_H__ */
-- 
2.34.1


