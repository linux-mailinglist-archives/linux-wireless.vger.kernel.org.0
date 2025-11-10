Return-Path: <linux-wireless+bounces-28753-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BC642C46450
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 12:30:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 23D6A4EE576
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 11:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3937130594F;
	Mon, 10 Nov 2025 11:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kiupir3K"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852153074A6
	for <linux-wireless@vger.kernel.org>; Mon, 10 Nov 2025 11:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762774024; cv=none; b=iSOKsjH8oVcm49S6aq0duGZlOHlRFB9deSyRY/sV3tQJKZr7733cxKAMCEUOjQgP+dC40VZm7Lx8iWHoaqtxeh33RVYtSjOYvldABdlJwLNQMkIhd2Txz3tEq9KT6ixGW6ypI1+Wd2j7wN30QXF+Z7cwxuAYK4Do2clxgbpP0Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762774024; c=relaxed/simple;
	bh=iniZtC1QR3b/OSJnuk5rqEZ/wP5zS2+UsTVgvuTkU94=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LbXfwSNp5v5Ud0HjYyxCGzFLrfaKd37KPNBsNY9wMibF+A/CfFqjYAnncyeCrlVRZMlEUExJa0TtVVYA02sGeqyLuPOeh7GeEXkq/QxObJMEh9D9lpAdIDai2CtYdEc50+7H/3inynQ+bNml0P69BX3iHk8nyvRAhfPalY9Vny8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kiupir3K; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762774022; x=1794310022;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iniZtC1QR3b/OSJnuk5rqEZ/wP5zS2+UsTVgvuTkU94=;
  b=Kiupir3KOHW4HZ+awV6GYuDUtjhgYwz4g2o6AsutFuG+QoFo1yWnCE7/
   wQ4psO2GS6rcIF2A/rwJGrgxZWGuiZbldyRDNslqukaRJJV9smNUJ7JXG
   /c5LugJ8mFhf71aFt4IIwhsyM2uAUck8CAXTjawZj/pj8mc8nXXrAiWx1
   g5GyVoDTi9UoR0onEZLytg4wYhKT91N6k6aTMrPuYX1ETRaPtVhCN3Fw1
   uSUWuDEYk58Bl7+b230HtwMzUz11uh9dqM6ALUvs0yORzXKs8RcCtxvaS
   amlPcEMnUxP196BGNxTwVcBkDsdjsjMzvDVzTh27u5ipVzm4e5mHYo+Af
   Q==;
X-CSE-ConnectionGUID: NpMdWI10Rt2r5Cv0WG32PA==
X-CSE-MsgGUID: NQj7wGRXSlWXGZ5JZFqR6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11608"; a="64856420"
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="64856420"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 03:27:02 -0800
X-CSE-ConnectionGUID: GZZDDdEKRiCPuEJwaURKig==
X-CSE-MsgGUID: ul2Oi+YiRniPKipv673pQA==
X-ExtLoop1: 1
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 03:27:01 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH wireless-next 5/6] wifi: iwlwifi: mld: Support changing NAN configuration
Date: Mon, 10 Nov 2025 13:26:47 +0200
Message-Id: <20251110132506.5914b7bac3ab.Ib8576873c92f68f1bcafbda409d45ef2b4133e9f@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251110112648.4149049-1-miriam.rachel.korenblit@intel.com>
References: <20251110112648.4149049-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Ilan Peer <ilan.peer@intel.com>

Add support for changing the NAN configuration.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/mld/mac80211.c |  1 +
 drivers/net/wireless/intel/iwlwifi/mld/nan.c  | 52 ++++++++++++++-----
 drivers/net/wireless/intel/iwlwifi/mld/nan.h  |  4 ++
 3 files changed, 44 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
index 9a58f2751d4e..05ab6246eb17 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
@@ -2770,4 +2770,5 @@ const struct ieee80211_ops iwl_mld_hw_ops = {
 	.can_neg_ttlm = iwl_mld_can_neg_ttlm,
 	.start_nan = iwl_mld_start_nan,
 	.stop_nan = iwl_mld_stop_nan,
+	.nan_change_conf = iwl_mld_nan_change_config,
 };
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/nan.c b/drivers/net/wireless/intel/iwlwifi/mld/nan.c
index 31899a98e41b..d9b67c2a92a2 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/nan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/nan.c
@@ -37,22 +37,19 @@ static int iwl_mld_nan_send_config_cmd(struct iwl_mld *mld,
 	return iwl_mld_send_cmd(mld, &hcmd);
 }
 
-int iwl_mld_start_nan(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
-		      struct cfg80211_nan_conf *conf)
+static int iwl_mld_nan_config(struct iwl_mld *mld,
+			      struct ieee80211_vif *vif,
+			      struct cfg80211_nan_conf *conf,
+			      enum iwl_ctxt_action action)
 {
-	struct iwl_mld *mld = IWL_MAC80211_GET_MLD(hw);
 	struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(vif);
-	struct iwl_mld_int_sta *aux_sta = &mld_vif->aux_sta;
 	struct iwl_nan_config_cmd cmd = {
-		.action = cpu_to_le32(FW_CTXT_ACTION_ADD),
+		.action = cpu_to_le32(action),
 	};
 	u8 *data __free(kfree) = NULL;
-	int ret;
 
 	lockdep_assert_wiphy(mld->wiphy);
 
-	IWL_DEBUG_MAC80211(mld, "Start NAN: bands=0x%x\n", conf->bands);
-
 	ether_addr_copy(cmd.nmi_addr, vif->addr);
 	cmd.master_pref = conf->master_pref;
 
@@ -117,15 +114,27 @@ int iwl_mld_start_nan(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 			       conf->vendor_elems_len);
 	}
 
+	cmd.sta_id = mld_vif->aux_sta.sta_id;
+	return iwl_mld_nan_send_config_cmd(mld, &cmd, data,
+					   conf->extra_nan_attrs_len +
+					   conf->vendor_elems_len);
+}
+
+int iwl_mld_start_nan(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+		      struct cfg80211_nan_conf *conf)
+{
+	struct iwl_mld *mld = IWL_MAC80211_GET_MLD(hw);
+	struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(vif);
+	struct iwl_mld_int_sta *aux_sta = &mld_vif->aux_sta;
+	int ret;
+
+	IWL_DEBUG_MAC80211(mld, "NAN: start: bands=0x%x\n", conf->bands);
+
 	ret = iwl_mld_add_aux_sta(mld, aux_sta);
 	if (ret)
 		return ret;
 
-	cmd.sta_id = aux_sta->sta_id;
-
-	ret = iwl_mld_nan_send_config_cmd(mld, &cmd, data,
-					  conf->extra_nan_attrs_len +
-					  conf->vendor_elems_len);
+	ret = iwl_mld_nan_config(mld, vif, conf, FW_CTXT_ACTION_ADD);
 	if (ret) {
 		IWL_ERR(mld, "Failed to start NAN. ret=%d\n", ret);
 		iwl_mld_remove_aux_sta(mld, vif);
@@ -134,6 +143,23 @@ int iwl_mld_start_nan(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	return ret;
 }
 
+int iwl_mld_nan_change_config(struct ieee80211_hw *hw,
+			      struct ieee80211_vif *vif,
+			      struct cfg80211_nan_conf *conf,
+			      u32 changes)
+{
+	struct iwl_mld *mld = IWL_MAC80211_GET_MLD(hw);
+
+	IWL_DEBUG_MAC80211(mld, "NAN: change: changes=0x%x, bands=0x%x\n",
+			   changes, conf->bands);
+
+	/* Note that we do not use 'changes' as the FW always expects the
+	 * complete configuration, and mac80211 always provides the complete
+	 * configuration.
+	 */
+	return iwl_mld_nan_config(mld, vif, conf, FW_CTXT_ACTION_MODIFY);
+}
+
 int iwl_mld_stop_nan(struct ieee80211_hw *hw,
 		     struct ieee80211_vif *vif)
 {
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/nan.h b/drivers/net/wireless/intel/iwlwifi/mld/nan.h
index 97607b74a177..c9c83d1012f0 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/nan.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/nan.h
@@ -10,6 +10,10 @@ bool iwl_mld_nan_supported(struct iwl_mld *mld);
 int iwl_mld_start_nan(struct ieee80211_hw *hw,
 		      struct ieee80211_vif *vif,
 		      struct cfg80211_nan_conf *conf);
+int iwl_mld_nan_change_config(struct ieee80211_hw *hw,
+			      struct ieee80211_vif *vif,
+			      struct cfg80211_nan_conf *conf,
+			      u32 changes);
 int iwl_mld_stop_nan(struct ieee80211_hw *hw,
 		     struct ieee80211_vif *vif);
 void iwl_mld_handle_nan_cluster_notif(struct iwl_mld *mld,
-- 
2.34.1


