Return-Path: <linux-wireless+bounces-33436-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yCL1JJERu2nGegIAu9opvQ
	(envelope-from <linux-wireless+bounces-33436-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2026 21:56:49 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E4D2C2C07
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2026 21:56:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C57A31B7EBF
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2026 20:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04A89372B3C;
	Wed, 18 Mar 2026 20:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IFMV4ui0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F38736F41F
	for <linux-wireless@vger.kernel.org>; Wed, 18 Mar 2026 20:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773867300; cv=none; b=bH7iSWdwpWCEs1pkRm1eJr8PffmH2CwdrsgqIc2XiIe0SuuGM3zT8oCxKZ+GsN5S1rI2erfmpB4xfQOgexKuEryVB4sF5huyQI4BS64tTXzu8+TmXp2t2hmF3TQglvssjDF2w0qHd2zLTYX4IGjocny8SK4MTtNgY36tXGmKA+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773867300; c=relaxed/simple;
	bh=yw/l4xdo4ifPwusFCqfuCfN829S+2wn6Kh7rgL7b5O4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nMUUiqCXxj0OxYU8YqZSmcCe+tsLmhblBXLDG+AZRbAK/IIdvNuZ40bhIcJcZU/bQMm0hcn+gomxmjNNr9fADloE/tTXv66ApE7tzSySKbi2apnjw+eP+a29nCjsp6gs30jtWv2YPGoKm7gxsZEWcq/qkC9ncU03xP6ReX83sZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IFMV4ui0; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773867299; x=1805403299;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yw/l4xdo4ifPwusFCqfuCfN829S+2wn6Kh7rgL7b5O4=;
  b=IFMV4ui0KZAFtJnqa8stkl+XRu3S2vpqMdFQQG8GPrLfLKHO5sb0ifTc
   i+wYS+9NJwiu1A43uvZimPvV6Ywd9A66XV37QDnjO6cPOwGLtYk1qZ8UZ
   TXVl21JwCYKqrDQRoCWOoc15Zi+WaAlihlJQrGkhG0oCRmcS/Zf8W0Ek2
   IMbbWPCuM5qkFoG5HRXJFSgscEtlq85rVhxU9GRzt11gYGPR60fJ+RE2y
   islmQqXAYEbRzRq+FDsbZQbpWiP+L5+F/K4nAlvAxiTY187v+Z0vJEus6
   PYcYWNPpQ782JVm2yu3mk+oOUl6iKr5Klrh9/W9Onb6sGNMU7XljOUBtD
   w==;
X-CSE-ConnectionGUID: pMKuz6UUQyWHPBDnuBD2AA==
X-CSE-MsgGUID: iPtk/G6wRwq5nRjAaeTBPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="75010033"
X-IronPort-AV: E=Sophos;i="6.23,128,1770624000"; 
   d="scan'208";a="75010033"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 13:54:59 -0700
X-CSE-ConnectionGUID: po6ezJajQwuLP4ffaNes1w==
X-CSE-MsgGUID: 9ioXG5goQBqt1woHH0AyFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,128,1770624000"; 
   d="scan'208";a="222793935"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 13:54:58 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 12/15] wifi: iwlwifi: mld: correctly set wifi generation data
Date: Wed, 18 Mar 2026 22:54:27 +0200
Message-Id: <20260318225236.404713b22177.Ic972b5e557d011a5438f8f97c1e793cc829e2ea9@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260318205430.614577-1-miriam.rachel.korenblit@intel.com>
References: <20260318205430.614577-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-33436-lists,linux-wireless=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.998];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:email]
X-Rspamd-Queue-Id: 18E4D2C2C07
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Johannes Berg <johannes.berg@intel.com>

In each MAC context, the firmware expects the wifi generation
data, i.e. whether or not HE/EHT (and in the future UHR) is
enabled on that MAC.

However, this is currently handled wrong in two ways:
 - EHT is only enabled when the interface is also an MLD, but
   we currently allow (despite the spec) connecting with EHT
   but without MLO.
 - when HE or EHT are used by TDLS peers, the firmware needs
   to have them enabled regardless of the AP

Fix this by iterating setting up the data depending on the
interface type:
 - for AP, just set it according to the BSS configuration
 - for monitor, set it according to HW capabilities
 - otherwise, particularly for client, iterate all stations
   and then their links on the interface in question and set
   according to their capabilities, this handles the AP and
   TDLS peers. Re-calculate this whenever a TDLS station is
   marked associated or removed so that it's kept updated,
   for the AP it's already updated on assoc/disassoc.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/mld/iface.c    | 101 ++++++++++++------
 .../net/wireless/intel/iwlwifi/mld/mac80211.c |  19 ++++
 2 files changed, 88 insertions(+), 32 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/iface.c b/drivers/net/wireless/intel/iwlwifi/mld/iface.c
index 29df747c8938..9215fc7e2eca 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/iface.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/iface.c
@@ -111,14 +111,75 @@ static bool iwl_mld_is_nic_ack_enabled(struct iwl_mld *mld,
 			       IEEE80211_HE_MAC_CAP2_ACK_EN);
 }
 
-static void iwl_mld_set_he_support(struct iwl_mld *mld,
-				   struct ieee80211_vif *vif,
-				   struct iwl_mac_config_cmd *cmd)
+struct iwl_mld_mac_wifi_gen_sta_iter_data {
+	struct ieee80211_vif *vif;
+	struct iwl_mac_wifi_gen_support *support;
+};
+
+static void iwl_mld_mac_wifi_gen_sta_iter(void *_data,
+					  struct ieee80211_sta *sta)
 {
-	if (vif->type == NL80211_IFTYPE_AP)
-		cmd->wifi_gen.he_ap_support = 1;
-	else
-		cmd->wifi_gen.he_support = 1;
+	struct iwl_mld_sta *mld_sta = iwl_mld_sta_from_mac80211(sta);
+	struct iwl_mld_mac_wifi_gen_sta_iter_data *data = _data;
+	struct ieee80211_link_sta *link_sta;
+	unsigned int link_id;
+
+	if (mld_sta->vif != data->vif)
+		return;
+
+	for_each_sta_active_link(data->vif, sta, link_sta, link_id) {
+		if (link_sta->he_cap.has_he)
+			data->support->he_support = 1;
+		if (link_sta->eht_cap.has_eht)
+			data->support->eht_support = 1;
+	}
+}
+
+static void iwl_mld_set_wifi_gen(struct iwl_mld *mld,
+				 struct ieee80211_vif *vif,
+				 struct iwl_mac_wifi_gen_support *support)
+{
+	struct iwl_mld_mac_wifi_gen_sta_iter_data sta_iter_data = {
+		.vif = vif,
+		.support = support,
+	};
+	struct ieee80211_bss_conf *link_conf;
+	unsigned int link_id;
+
+	switch (vif->type) {
+	case NL80211_IFTYPE_MONITOR:
+		/* for sniffer, set to HW capabilities */
+		support->he_support = 1;
+		support->eht_support = mld->trans->cfg->eht_supported;
+		break;
+	case NL80211_IFTYPE_AP:
+		/* for AP set according to the link configs */
+		for_each_vif_active_link(vif, link_conf, link_id) {
+			support->he_ap_support |= link_conf->he_support;
+			support->eht_support |= link_conf->eht_support;
+		}
+		break;
+	default:
+		/*
+		 * If we have MLO enabled, then the firmware needs to enable
+		 * address translation for the station(s) we add. That depends
+		 * on having EHT enabled in firmware, which in turn depends on
+		 * mac80211 in the iteration below.
+		 * However, mac80211 doesn't enable capabilities on the AP STA
+		 * until it has parsed the association response successfully,
+		 * so set EHT (and HE as a pre-requisite for EHT) when the vif
+		 * is an MLD.
+		 */
+		if (ieee80211_vif_is_mld(vif)) {
+			support->he_support = 1;
+			support->eht_support = 1;
+		}
+
+		ieee80211_iterate_stations_mtx(mld->hw,
+					       iwl_mld_mac_wifi_gen_sta_iter,
+					       &sta_iter_data);
+		break;
+	}
 }
 
 /* fill the common part for all interface types */
@@ -128,8 +189,6 @@ static void iwl_mld_mac_cmd_fill_common(struct iwl_mld *mld,
 					u32 action)
 {
 	struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(vif);
-	struct ieee80211_bss_conf *link_conf;
-	unsigned int link_id;
 
 	lockdep_assert_wiphy(mld->wiphy);
 
@@ -147,29 +206,7 @@ static void iwl_mld_mac_cmd_fill_common(struct iwl_mld *mld,
 	cmd->nic_not_ack_enabled =
 		cpu_to_le32(!iwl_mld_is_nic_ack_enabled(mld, vif));
 
-	/* If we have MLO enabled, then the firmware needs to enable
-	 * address translation for the station(s) we add. That depends
-	 * on having EHT enabled in firmware, which in turn depends on
-	 * mac80211 in the code below.
-	 * However, mac80211 doesn't enable HE/EHT until it has parsed
-	 * the association response successfully, so just skip all that
-	 * and enable both when we have MLO.
-	 */
-	if (ieee80211_vif_is_mld(vif)) {
-		iwl_mld_set_he_support(mld, vif, cmd);
-		cmd->wifi_gen.eht_support = 1;
-		return;
-	}
-
-	for_each_vif_active_link(vif, link_conf, link_id) {
-		if (!link_conf->he_support)
-			continue;
-
-		iwl_mld_set_he_support(mld, vif, cmd);
-
-		/* EHT, if supported, was already set above */
-		break;
-	}
+	iwl_mld_set_wifi_gen(mld, vif, &cmd->wifi_gen);
 }
 
 static void iwl_mld_fill_mac_cmd_sta(struct iwl_mld *mld,
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
index 0c53d6bd9651..71a9a72c9ac0 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
@@ -1761,6 +1761,16 @@ static int iwl_mld_move_sta_state_up(struct iwl_mld *mld,
 
 		if (vif->type == NL80211_IFTYPE_STATION)
 			iwl_mld_link_set_2mhz_block(mld, vif, sta);
+
+		if (sta->tdls) {
+			/*
+			 * update MAC since wifi generation flags may change,
+			 * we also update MAC on association to the AP via the
+			 * vif assoc change
+			 */
+			iwl_mld_mac_fw_action(mld, vif, FW_CTXT_ACTION_MODIFY);
+		}
+
 		/* Now the link_sta's capabilities are set, update the FW */
 		iwl_mld_config_tlc(mld, vif, sta);
 
@@ -1873,6 +1883,15 @@ static int iwl_mld_move_sta_state_down(struct iwl_mld *mld,
 			/* just removed last TDLS STA, so enable PM */
 			iwl_mld_update_mac_power(mld, vif, false);
 		}
+
+		if (sta->tdls) {
+			/*
+			 * update MAC since wifi generation flags may change,
+			 * we also update MAC on disassociation to the AP via
+			 * the vif assoc change
+			 */
+			iwl_mld_mac_fw_action(mld, vif, FW_CTXT_ACTION_MODIFY);
+		}
 	} else {
 		return -EINVAL;
 	}
-- 
2.34.1


