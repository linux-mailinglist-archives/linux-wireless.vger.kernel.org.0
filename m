Return-Path: <linux-wireless+bounces-36246-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2K9/ICAVAmrangEAu9opvQ
	(envelope-from <linux-wireless+bounces-36246-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 19:42:56 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E8EBC513A81
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 19:42:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 12FEF306BEBC
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 17:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACACA43DA43;
	Mon, 11 May 2026 17:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nX7bcgSs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F70F4534A8
	for <linux-wireless@vger.kernel.org>; Mon, 11 May 2026 17:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778521018; cv=none; b=unL4XkWnV1IsQP9oB0nAvGK4qh0F1T7uGGmXVP5cr8dzrhWYfCNMMvdZtM474kiMvgNeBT9Q1AGlJtCPzMx0yp+rFNY/XC1jJLrfLCiyzAK/oTgCTIty8PfWnjfFaXmDDzUkeKNppwQgfzff219j8dLeGSJTsaXB1jlgoJQ38vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778521018; c=relaxed/simple;
	bh=UzT0POQvA1Q7rOM/qAnrxmHWnavI04n1fHN1+nxV+Es=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m4Ju/WMYddZELLUKPiBz8gBffozimXXOApSpZslRg17wUaGBOzN3iMKq7eGTcsUqY5A9c+Wf2ZfjLf1jVsiVfcCtw0r0q0Z0BgyMuFMKhzjl9eIO93h/RA/L4D6SxxtFCMoIrQgCp3wMM8ih3MtXa2MUbghGjt6eXFSJhZp14To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nX7bcgSs; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778521018; x=1810057018;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UzT0POQvA1Q7rOM/qAnrxmHWnavI04n1fHN1+nxV+Es=;
  b=nX7bcgSsuPw0AzqZX9QGusupTt4eYxwbKhFVvRdeLfbDhJnnh02i9Hn9
   Uf8wYk7vASxJgW4BqvcEinD5Rdb/kz926+2DhyfTqMj50fpicUKB2L/Zx
   0b+BiMEUMmBsI9MfdFqjV41o/eos6dR8MTDIcXwUdNeHbDfq7woQOwOFd
   FeK74M+JEb2K2sErn4A5Fnt0ssRzBsC0TJITWO5S+BENIrPZVPjYKSL4S
   Gp4KojuELGPCgmzBHMSkE+8nlrF9Up6gpS8kM6WEmyf+t8kVCa8/YxDEG
   X4turQa4vmBBMfrbO8UqS+rWCeEx/BdqPMwNfasFvPs1txj3q+yMvOY2/
   Q==;
X-CSE-ConnectionGUID: MLTloxdrQ5eJ/Wj2uSyyYg==
X-CSE-MsgGUID: kVacy74VSuygVwJTmpmShQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="79314798"
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="79314798"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 10:36:56 -0700
X-CSE-ConnectionGUID: PgacZArCQAqdZuvNLp/9yw==
X-CSE-MsgGUID: 1cjh4COeQee7DyZx5fVjWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="261004708"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 10:36:51 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH iwlwifi-next 05/15] wifi: iwlwifi: mld: move iwl_mld_link_info_changed_ap_ibss to ap.c
Date: Mon, 11 May 2026 20:36:21 +0300
Message-Id: <20260511203428.83ea430fbd74.I5ac85373c250b684cb46978d9e6bd42ba0e88171@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260511173631.1067831-1-miriam.rachel.korenblit@intel.com>
References: <20260511173631.1067831-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E8EBC513A81
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-36246-lists,linux-wireless=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,intel.com:dkim]
X-Rspamd-Action: no action

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

This function is ap mode related, move it to ap.c.
Also, don't call iwl_mld_ftm_responder_clear from stop_ap() since
mac80211 does it now before stopping the AP.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/ap.c   | 37 ++++++++++++++++++-
 drivers/net/wireless/intel/iwlwifi/mld/ap.h   |  8 ++--
 .../net/wireless/intel/iwlwifi/mld/mac80211.c | 33 -----------------
 3 files changed, 40 insertions(+), 38 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/ap.c b/drivers/net/wireless/intel/iwlwifi/mld/ap.c
index c29e4a77be05..bc426b911ce5 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/ap.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/ap.c
@@ -239,8 +239,8 @@ int iwl_mld_store_ap_early_key(struct iwl_mld *mld,
 	return -ENOSPC;
 }
 
-void iwl_mld_stop_beacon(struct iwl_mld *mld, struct ieee80211_vif *vif,
-			 struct ieee80211_bss_conf *link)
+static void iwl_mld_stop_beacon(struct iwl_mld *mld, struct ieee80211_vif *vif,
+				struct ieee80211_bss_conf *link)
 {
 	struct iwl_mld_link *mld_link = iwl_mld_link_from_mac80211(link);
 	struct iwl_mac_beacon_cmd cmd = {};
@@ -258,6 +258,39 @@ void iwl_mld_stop_beacon(struct iwl_mld *mld, struct ieee80211_vif *vif,
 	iwl_mld_send_cmd_pdu(mld, BEACON_TEMPLATE_CMD, &cmd);
 }
 
+void
+iwl_mld_link_info_changed_ap_ibss(struct iwl_mld *mld,
+				  struct ieee80211_vif *vif,
+				  struct ieee80211_bss_conf *link,
+				  u64 changes)
+{
+	u32 link_changes = 0;
+
+	if (changes & BSS_CHANGED_ERP_SLOT)
+		link_changes |= LINK_CONTEXT_MODIFY_RATES_INFO;
+
+	if (changes & (BSS_CHANGED_ERP_CTS_PROT | BSS_CHANGED_HT))
+		link_changes |= LINK_CONTEXT_MODIFY_PROTECT_FLAGS;
+
+	if (changes & (BSS_CHANGED_QOS | BSS_CHANGED_BANDWIDTH))
+		link_changes |= LINK_CONTEXT_MODIFY_QOS_PARAMS;
+
+	if (changes & BSS_CHANGED_HE_BSS_COLOR)
+		link_changes |= LINK_CONTEXT_MODIFY_HE_PARAMS;
+
+	if (link_changes)
+		iwl_mld_change_link_in_fw(mld, link, link_changes);
+
+	if (changes & BSS_CHANGED_BEACON) {
+		WARN_ON(!link->enable_beacon);
+		iwl_mld_update_beacon_template(mld, vif, link);
+	}
+
+	/* Enabling beacons was already covered above */
+	if ((changes & BSS_CHANGED_BEACON_ENABLED) && !link->enable_beacon)
+		iwl_mld_stop_beacon(mld, vif, link);
+}
+
 static int iwl_mld_send_ap_early_keys(struct iwl_mld *mld,
 				      struct ieee80211_vif *vif,
 				      struct ieee80211_bss_conf *link)
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/ap.h b/drivers/net/wireless/intel/iwlwifi/mld/ap.h
index a3b6bed814ad..f10e9c9a38ff 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/ap.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/ap.h
@@ -14,9 +14,11 @@ int iwl_mld_update_beacon_template(struct iwl_mld *mld,
 				   struct ieee80211_vif *vif,
 				   struct ieee80211_bss_conf *link_conf);
 
-void iwl_mld_stop_beacon(struct iwl_mld *mld,
-			 struct ieee80211_vif *vif,
-			 struct ieee80211_bss_conf *link_conf);
+void
+iwl_mld_link_info_changed_ap_ibss(struct iwl_mld *mld,
+				  struct ieee80211_vif *vif,
+				  struct ieee80211_bss_conf *link,
+				  u64 changes);
 
 int iwl_mld_start_ap_ibss(struct ieee80211_hw *hw,
 			  struct ieee80211_vif *vif,
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
index 403bc38ac2bc..c02994e63b14 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
@@ -1235,39 +1235,6 @@ int iwl_mld_mac80211_set_rts_threshold(struct ieee80211_hw *hw, int radio_idx,
 	return 0;
 }
 
-static void
-iwl_mld_link_info_changed_ap_ibss(struct iwl_mld *mld,
-				  struct ieee80211_vif *vif,
-				  struct ieee80211_bss_conf *link,
-				  u64 changes)
-{
-	u32 link_changes = 0;
-
-	if (changes & BSS_CHANGED_ERP_SLOT)
-		link_changes |= LINK_CONTEXT_MODIFY_RATES_INFO;
-
-	if (changes & (BSS_CHANGED_ERP_CTS_PROT | BSS_CHANGED_HT))
-		link_changes |= LINK_CONTEXT_MODIFY_PROTECT_FLAGS;
-
-	if (changes & (BSS_CHANGED_QOS | BSS_CHANGED_BANDWIDTH))
-		link_changes |= LINK_CONTEXT_MODIFY_QOS_PARAMS;
-
-	if (changes & BSS_CHANGED_HE_BSS_COLOR)
-		link_changes |= LINK_CONTEXT_MODIFY_HE_PARAMS;
-
-	if (link_changes)
-		iwl_mld_change_link_in_fw(mld, link, link_changes);
-
-	if (changes & BSS_CHANGED_BEACON) {
-		WARN_ON(!link->enable_beacon);
-		iwl_mld_update_beacon_template(mld, vif, link);
-	}
-
-	/* Enabling beacons was already covered above */
-	if ((changes & BSS_CHANGED_BEACON_ENABLED) && !link->enable_beacon)
-		iwl_mld_stop_beacon(mld, vif, link);
-}
-
 static
 u32 iwl_mld_link_changed_mapping(struct iwl_mld *mld,
 				 struct ieee80211_vif *vif,
-- 
2.34.1


