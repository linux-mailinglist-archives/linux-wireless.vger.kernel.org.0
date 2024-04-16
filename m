Return-Path: <linux-wireless+bounces-6381-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A76F8A6922
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Apr 2024 12:54:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D0381C20E0E
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Apr 2024 10:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20FBB1292F3;
	Tue, 16 Apr 2024 10:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ms/oE9uE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCF3127E3D
	for <linux-wireless@vger.kernel.org>; Tue, 16 Apr 2024 10:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713264871; cv=none; b=akpH0MRzUqY68b66js1voae+Jk5G5Ldn0mHKjepFJOMEIdSjRaMQXOjKNcxMniNh3aA9evJHJLSmusV5zxYO4O5K5+WyaW8ojU9I9VJE5a10HH8Olv960hAK86SRFl+Sl1bIRHYPJrq7vuAR28DsbVuZh7x6ljh9XvM1tvajpzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713264871; c=relaxed/simple;
	bh=Z9dt0LPnnkPqSwwZgQgGdrBngK9llLWAJkYTdJqHFs4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uWhvurOTeThbObCllXz1aXmncU+Z4rz5KAThc6wbpIYsLbW6PN1581iOFCvnJSUxJpkEdZ9iPmkJ3UWcdfFwsSWcIWv4qpe+XIILuRXn+fo1tuYSfTUORHuyrPY/0jvYJKUAvNIeu7chYAxZ5b2/V2xZtJFlTlhn8ZqI9mol9ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ms/oE9uE; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713264870; x=1744800870;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Z9dt0LPnnkPqSwwZgQgGdrBngK9llLWAJkYTdJqHFs4=;
  b=ms/oE9uErbvHzAlCHIcEMvb32ZzH2408YtSy0hbzWWO5bRmxffu+Onnx
   YUuaCg8390zFF0soBxCTkPZ6Nu6ccgCRA6H3ow5NKH1u9FrLMRu5JsaFD
   3yq5ePhO/lBolhwUd1fQtj0qH6f5zJOKWIxdMK3ebnyOXZeEaHn/QgaWf
   0mNaNrjKmYtFCjPK6IUyxv3aVWvK5zbFyc1aOZ0S//62x6f6HPV0n1XDc
   oe5H+Swv1euUL08WzPWoJ9yy+ss1O2rcxmsf5EfcXvwLSSItPVVe4FShX
   ZLtp/3qrxGpy5oG/Qit6x8jFSowRYREF7Qy9728+yNCwex25yNhg5xyJE
   w==;
X-CSE-ConnectionGUID: xiHBwGWcRj++PjdP5POXLw==
X-CSE-MsgGUID: ptKIFHqcTLCrGmMaUimcRg==
X-IronPort-AV: E=McAfee;i="6600,9927,11045"; a="8556037"
X-IronPort-AV: E=Sophos;i="6.07,205,1708416000"; 
   d="scan'208";a="8556037"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 03:54:29 -0700
X-CSE-ConnectionGUID: 0AI6rRIhQ02UDZ5w1hKBFQ==
X-CSE-MsgGUID: YFg5hFkcQz27nIvUZC9ZGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,205,1708416000"; 
   d="scan'208";a="26872449"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 03:54:28 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 04/16] wifi: iwlwifi: mvm: calculate EMLSR mode after connection
Date: Tue, 16 Apr 2024 13:53:59 +0300
Message-Id: <20240416134215.a767e243366e.I3b32d36cda23f67dc103a28a9bdccb0039d22574@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240416105411.706221-1-miriam.rachel.korenblit@intel.com>
References: <20240416105411.706221-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

The function iwl_mvm_can_enter_esr() is (among others) calculating
if EMLSR mode is disabled due to BT coex by calling
iwl_mvm_bt_coex_calculate_esr_mode(), then stores the decision in
mvmvif::esr_disable_reason.
But there is no need to calculate this every time iwl_mvm_can_enter_esr
is called. Fix this by calculating it once after authorization,
and in iwl_mvm_can_enter_esr only check mvmvif::esr_disable_reason.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/coex.c | 10 ++++-----
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 21 +++++++++++++++++++
 .../wireless/intel/iwlwifi/mvm/mld-mac80211.c | 13 ++++--------
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  9 +++-----
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c   |  4 ++--
 5 files changed, 35 insertions(+), 22 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/coex.c b/drivers/net/wireless/intel/iwlwifi/mvm/coex.c
index 41afd5d50d81..f31752bcd2a2 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/coex.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/coex.c
@@ -279,7 +279,7 @@ static void iwl_mvm_bt_coex_enable_esr(struct iwl_mvm *mvm,
  * This function receives the LB link id and checks if eSR should be
  * enabled or disabled (due to BT coex)
  */
-bool
+static bool
 iwl_mvm_bt_coex_calculate_esr_mode(struct iwl_mvm *mvm,
 				   struct ieee80211_vif *vif,
 				   int link_id, int primary_link)
@@ -336,9 +336,9 @@ iwl_mvm_bt_coex_calculate_esr_mode(struct iwl_mvm *mvm,
 	return wifi_loss_rate <= IWL_MVM_BT_COEX_WIFI_LOSS_THRESH;
 }
 
-void iwl_mvm_bt_coex_update_vif_esr(struct iwl_mvm *mvm,
-				    struct ieee80211_vif *vif,
-				    int link_id)
+void iwl_mvm_bt_coex_update_link_esr(struct iwl_mvm *mvm,
+				     struct ieee80211_vif *vif,
+				     int link_id)
 {
 	unsigned long usable_links = ieee80211_vif_usable_links(vif);
 	int primary_link = iwl_mvm_mld_get_primary_link(mvm, vif,
@@ -400,7 +400,7 @@ static void iwl_mvm_bt_notif_per_link(struct iwl_mvm *mvm,
 		return;
 	}
 
-	iwl_mvm_bt_coex_update_vif_esr(mvm, vif, link_id);
+	iwl_mvm_bt_coex_update_link_esr(mvm, vif, link_id);
 
 	if (fw_has_capa(&mvm->fw->ucode_capa, IWL_UCODE_TLV_CAPA_COEX_SCHEMA_2))
 		min_ag_for_static_smps = BT_VERY_HIGH_TRAFFIC;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index ac7d986d9cd7..0791dac086e1 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -3842,6 +3842,24 @@ iwl_mvm_sta_state_auth_to_assoc(struct ieee80211_hw *hw,
 	return callbacks->update_sta(mvm, vif, sta);
 }
 
+static void iwl_mvm_bt_coex_update_vif_esr(struct iwl_mvm *mvm,
+					   struct ieee80211_vif *vif)
+{
+	unsigned long usable_links = ieee80211_vif_usable_links(vif);
+	u8 link_id;
+
+	for_each_set_bit(link_id, &usable_links, IEEE80211_MLD_MAX_NUM_LINKS) {
+		struct ieee80211_bss_conf *link_conf =
+			link_conf_dereference_protected(vif, link_id);
+
+		if (WARN_ON_ONCE(!link_conf))
+			return;
+
+		if (link_conf->chanreq.oper.chan->band == NL80211_BAND_2GHZ)
+			iwl_mvm_bt_coex_update_link_esr(mvm, vif, link_id);
+	}
+}
+
 static int
 iwl_mvm_sta_state_assoc_to_authorized(struct iwl_mvm *mvm,
 				      struct ieee80211_vif *vif,
@@ -3869,6 +3887,9 @@ iwl_mvm_sta_state_assoc_to_authorized(struct iwl_mvm *mvm,
 		callbacks->mac_ctxt_changed(mvm, vif, false);
 		iwl_mvm_mei_host_associated(mvm, vif, mvm_sta);
 
+		/* Calculate eSR mode due to BT coex */
+		iwl_mvm_bt_coex_update_vif_esr(mvm, vif);
+
 		/* when client is authorized (AP station marked as such),
 		 * try to enable more links
 		 */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
index bcf2fd23300f..25d98ea6db44 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
@@ -1344,13 +1344,13 @@ static bool iwl_mvm_can_enter_esr(struct iwl_mvm *mvm,
 				  unsigned long desired_links)
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
-	int primary_link = iwl_mvm_mld_get_primary_link(mvm, vif,
-							desired_links);
+	u16 usable_links = ieee80211_vif_usable_links(vif);
 	const struct wiphy_iftype_ext_capab *ext_capa;
 	bool ret = true;
 	int link_id;
 
-	if (primary_link < 0)
+	if (!ieee80211_vif_is_mld(vif) || !vif->cfg.assoc ||
+	    hweight16(usable_links) <= 1)
 		return false;
 
 	if (!(vif->cfg.eml_cap & IEEE80211_EML_CAP_EMLSR_SUPP))
@@ -1373,12 +1373,7 @@ static bool iwl_mvm_can_enter_esr(struct iwl_mvm *mvm,
 		if (link_conf->chanreq.oper.chan->band != NL80211_BAND_2GHZ)
 			continue;
 
-		ret = iwl_mvm_bt_coex_calculate_esr_mode(mvm, vif, link_id,
-							 primary_link);
-		// Mark eSR as disabled for the next time
-		if (!ret)
-			mvmvif->esr_disable_reason |= IWL_MVM_ESR_DISABLE_COEX;
-		break;
+		return !(mvmvif->esr_disable_reason & IWL_MVM_ESR_DISABLE_COEX);
 	}
 
 	return ret;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index c477978d8fa3..77786c1a7528 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -2155,12 +2155,9 @@ bool iwl_mvm_bt_coex_is_tpc_allowed(struct iwl_mvm *mvm,
 u8 iwl_mvm_bt_coex_get_single_ant_msk(struct iwl_mvm *mvm, u8 enabled_ants);
 u8 iwl_mvm_bt_coex_tx_prio(struct iwl_mvm *mvm, struct ieee80211_hdr *hdr,
 			   struct ieee80211_tx_info *info, u8 ac);
-bool iwl_mvm_bt_coex_calculate_esr_mode(struct iwl_mvm *mvm,
-					struct ieee80211_vif *vif,
-					int link_id, int primary_link);
-void iwl_mvm_bt_coex_update_vif_esr(struct iwl_mvm *mvm,
-				    struct ieee80211_vif *vif,
-				    int link_id);
+void iwl_mvm_bt_coex_update_link_esr(struct iwl_mvm *mvm,
+				     struct ieee80211_vif *vif,
+				     int link_id);
 
 /* beacon filtering */
 #ifdef CONFIG_IWLWIFI_DEBUGFS
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rx.c b/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
index f8f57e191c59..4f578f3e7e74 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
@@ -895,8 +895,8 @@ iwl_mvm_stat_iterator_all_links(struct iwl_mvm *mvm,
 
 		if (link_info->phy_ctxt &&
 		    link_info->phy_ctxt->channel->band == NL80211_BAND_2GHZ)
-			iwl_mvm_bt_coex_update_vif_esr(mvm, bss_conf->vif,
-						       link_id);
+			iwl_mvm_bt_coex_update_link_esr(mvm, bss_conf->vif,
+							link_id);
 
 		/* make sure that beacon statistics don't go backwards with TCM
 		 * request to clear statistics
-- 
2.34.1


