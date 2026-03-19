Return-Path: <linux-wireless+bounces-33474-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kI5aHQPCu2n1ngIAu9opvQ
	(envelope-from <linux-wireless+bounces-33474-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 10:29:39 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F8E2C8AD0
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 10:29:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D9ED32C7D7C
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 09:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 420A23B4E83;
	Thu, 19 Mar 2026 09:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fdC+b9iv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E883B95FD
	for <linux-wireless@vger.kernel.org>; Thu, 19 Mar 2026 09:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773911398; cv=none; b=TE6fMqnfRvGDAkXVsNDpOgoVACfOECr7thqUkyLxFXY0i8ZDCiyU5TvZc/ZvFo/Y2nwFBfyAAmEz4cmVZRzAfsF+xp1gg/9Blr7+lplPK/9QsLjhYXSK1ikjW3IllvtsDJK0Vn8OmsekvLWLgtKHBWYEdbmV16yk3BqLkVMSRJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773911398; c=relaxed/simple;
	bh=yw/l4xdo4ifPwusFCqfuCfN829S+2wn6Kh7rgL7b5O4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AoE8BBhRrz3QFnmgrCE17rphcwQ9GxHbboeQdQLIRRh+yqfQHXPjkC2oelhGs8QyOiIWnm3GXIcDNLHvbkoNb0G6uEqw2nvgJk7QN0pl9QqKo5NUgAxhdlRV8M7KOqx3XcKm5DLTpJALpCLodFMOWbzZ0CRS1DqcgnEGJE0HaGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fdC+b9iv; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773911395; x=1805447395;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yw/l4xdo4ifPwusFCqfuCfN829S+2wn6Kh7rgL7b5O4=;
  b=fdC+b9iv4n3vzM+biCfEiBYGjBwbQcNDzlZ8RNRH3eVczlJWWbDSjKg6
   q4Qchy+u0p13GdXgVWDRxBFkrEghVFNyyH7uk2NkgjMMC8UCm13v/K5pl
   MTouygfJifM4hnbQLEBBEhTTTjQBcEAyAmKO0B1bD/IBDUIorXkz8CZ8o
   FfpTaKk7NSryfQs8VJjT/X4g/tVUznXkLCB6joNVrHG3q8gVPllG3ctgq
   hK1YdSq0fufFRdfyCiKXKZqXuEPg4i6LZNe7D3VEhqx27ntCFx0a29AWh
   88My+GzTjYihb8jhrepSvDe9AwaoA6N488YaGTH0QMm+AybaxoZP8RNej
   Q==;
X-CSE-ConnectionGUID: stCjVj7ESTKZaZofX+BIpw==
X-CSE-MsgGUID: cbe1Pyt7Tv+AQ8G7t8mQ4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="73992738"
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="73992738"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 02:09:55 -0700
X-CSE-ConnectionGUID: Egry7BFbTyKx5mX4ur2kTQ==
X-CSE-MsgGUID: xK77a83wT8izW0SBgggFEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="218387157"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 02:09:54 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2 iwlwifi-next 12/15] wifi: iwlwifi: mld: correctly set wifi generation data
Date: Thu, 19 Mar 2026 11:09:24 +0200
Message-Id: <20260319110722.404713b22177.Ic972b5e557d011a5438f8f97c1e793cc829e2ea9@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260319090927.1090112-1-miriam.rachel.korenblit@intel.com>
References: <20260319090927.1090112-1-miriam.rachel.korenblit@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-33474-lists,linux-wireless=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:email]
X-Rspamd-Queue-Id: 16F8E2C8AD0
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


