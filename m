Return-Path: <linux-wireless+bounces-33769-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +FaFNVBbwmnQbwQAu9opvQ
	(envelope-from <linux-wireless+bounces-33769-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2026 10:37:20 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C509E305B10
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2026 10:37:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0A2AD3026054
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2026 09:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A41753C9424;
	Tue, 24 Mar 2026 09:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jl39mOyC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282073D8138
	for <linux-wireless@vger.kernel.org>; Tue, 24 Mar 2026 09:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774344824; cv=none; b=Hwj+M3HWpF8VVwOpFYkBhrCJseC4PRGc2SRm1FZCA//snYKShZ+jr8bkS8uQAE3CZn+as/3m4tPHh/B9p+lwGt/mjaGMH7UVd8IIuAkkIP2rGBCH3ew8H/1KVmLd5ZL2j0gzwsuKa00aspBRrV6ZAFwBxv5NBKxrOsFKV5o0nP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774344824; c=relaxed/simple;
	bh=UfuX/L2OE1VfmHrzM2TGxXwcYCaHEDAQiPYQyvTB2rE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=by3aSjqO2zbOWbgLpcMVXjnul8B2s+m7yRmGWyOWALQ0PwusiGIlfAT4wrCYlEmdKRTaKIAWPk7HPFX7OlSy1nNs8Q/xpGwO/ZQjT5/w5UWE5sxN2mpyYpagbGRlX6dlcYFngJJvzBkcYyvinQ/mrgOSpB6pdTLUayBSEz1VEic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jl39mOyC; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774344824; x=1805880824;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UfuX/L2OE1VfmHrzM2TGxXwcYCaHEDAQiPYQyvTB2rE=;
  b=Jl39mOyCOuwwka0XsYhyUBYwG4hVL9RSPZQulyvWKeb2B927EYOWzHLn
   s176jLt1aKHJN7VjDX5IcMcuRA2WUXVRHKGQXnzPN6gCD7ui6s80JjjZz
   5GdkcDBPXH9gaY2CEaL/9RRmphSJK4ZKvJQYbz8oer/yvgXf1w3bf1ZIQ
   v3ZOVjQewhzovKlLUHhWdQwY6vlzEM5AmHqeOSTPjFWQtCJQQFLqbHeVj
   83Hicpb517s82/THkkEusvv5MYAH4/RQ8bX72J1mOTsrM1Rx6UKx7hBPr
   pci+27J4ogIjM/O/doc33Md7bPx5ZOUJApyrIXxJkNg2+CaYaxvNIXSV5
   w==;
X-CSE-ConnectionGUID: pmhJgELuQkaxSnZuJGIZ2A==
X-CSE-MsgGUID: sTRdQOdXT7WjIsh13XT2gw==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="75239820"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="75239820"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 02:33:43 -0700
X-CSE-ConnectionGUID: 07tSvKqCT9OFhTSlwl+4lQ==
X-CSE-MsgGUID: nwX4xGdHQXSqIF+c8+Wflg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="224302432"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 02:33:40 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-fixes 3/3] wifi: iwlwifi: mld: correctly set wifi generation data
Date: Tue, 24 Mar 2026 11:33:26 +0200
Message-Id: <20260324093333.2953495-1-miriam.rachel.korenblit@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260324113316.4c56b8bac533.I6e656d8cc30bb82c96aabadedd62bd67f4c46bf9@changeid>
References: <20260324113316.4c56b8bac533.I6e656d8cc30bb82c96aabadedd62bd67f4c46bf9@changeid>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-33769-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,intel.com:dkim,intel.com:email,intel.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C509E305B10
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

Fixes: d1e879ec600f ("wifi: iwlwifi: add iwlmld sub-driver")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://patch.msgid.link/20260319110722.404713b22177.Ic972b5e557d011a5438f8f97c1e793cc829e2ea9@changeid
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


