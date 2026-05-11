Return-Path: <linux-wireless+bounces-36250-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WIROOdAaAmofoAEAu9opvQ
	(envelope-from <linux-wireless+bounces-36250-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 20:07:12 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 65EB1514136
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 20:07:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 922C131E44CB
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 17:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 647354611C4;
	Mon, 11 May 2026 17:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QUPOgBB2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99BAD4534A8
	for <linux-wireless@vger.kernel.org>; Mon, 11 May 2026 17:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778521021; cv=none; b=OYEAFNB+PbLvmIILw0QPGs62CV1jddO47q5BPlNUKw4OouFvwrVDiYCRkq00rFYhKtBMEcB+h1CQZ42UmBYqDOnij4NRGUqdHi4r94g17TWMM4pGDd0uVoSStKtJYqzwCJMRxWSM9j3KWJZxwMiiAZFT7VzVUqdqfkEyn5pHyHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778521021; c=relaxed/simple;
	bh=1qFcPi9CGPeaI9TptljVzzXtE5MFlFKN/Dsrv8E4pxI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ewXCifq1qt0fQ+Xe25c/irdZBq12nRzaYjL6krHPW04p9UOyHUANNQi99W8dCN+7QW64Roj+M3xZasZXqgDlw37gt7wpp2omnjXbAxpE4t4BI877uJbwG/R9puJFoeprRzESDHaJgKOC3enhpWnsc6rSK/gZWUpG1S9p9sqtfeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QUPOgBB2; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778521020; x=1810057020;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1qFcPi9CGPeaI9TptljVzzXtE5MFlFKN/Dsrv8E4pxI=;
  b=QUPOgBB23THkoHJYqnFCiUnaiQ/GjgXpvvPrm3pJ8pHxL8IiYGl9GaZl
   quoSXPccqCiG7rcsrdKt+2C7PpJsC3jf7cIq/RQiA+QmlV02BpEEf0oTT
   Sv6NqlYgyp5F/G81UQiBNcP5YWfRQTwrMZGP8yvFqz05lQW0yb/Oigsk7
   nQJSkWHIfluf+c9ofb7t4CJvkPSdScO1HMiWV4z1UrY+gSX4gke5NThif
   PPpvoy1Tn0LiZ1QOlkLV1QrePvotBQ5H1wRiz64BfW/H4ykG9aqX2hgOE
   MUDBP90tAtzM+fMk6v76UheN8EIv+1iI6WkX81yKKh1AvRnBy0Zs5vnvf
   w==;
X-CSE-ConnectionGUID: Qp+Z/rGzTPCy5uyGeltxuw==
X-CSE-MsgGUID: gqIq1tILQTSRNSH4CfLiXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="79314817"
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="79314817"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 10:36:58 -0700
X-CSE-ConnectionGUID: TT0hfQq4Q+KojoNJNBWuHw==
X-CSE-MsgGUID: MZerorZmRUqzKIjzthXigg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="261004756"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 10:36:54 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 08/15] wifi: iwlwifi: mld: add TLC support for NAN stations
Date: Mon, 11 May 2026 20:36:24 +0300
Message-Id: <20260511203428.ea4112d28331.Ie11049c12a4765a97f3e6dfd1ea4afb265c93817@changeid>
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
X-Rspamd-Queue-Id: 65EB1514136
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-36250-lists,linux-wireless=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Johannes Berg <johannes.berg@intel.com>

In order to support NAN, TLC now has a station bitmap. Use this
and update TLC for the NAN stations accordingly whenever links
(and thus PHYs) change, and whenever else mac80211 might update
the rate scale information.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Co-developed-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/nan.c |  29 ++-
 drivers/net/wireless/intel/iwlwifi/mld/tlc.c | 189 +++++++++++++++----
 2 files changed, 182 insertions(+), 36 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/nan.c b/drivers/net/wireless/intel/iwlwifi/mld/nan.c
index ceea66c01205..59e85818b613 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/nan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/nan.c
@@ -7,6 +7,7 @@
 #include "iface.h"
 #include "link.h"
 #include "mlo.h"
+#include "tlc.h"
 #include "fw/api/mac-cfg.h"
 #include "fw/api/mac.h"
 #include "fw/api/rs.h"
@@ -437,15 +438,26 @@ iwl_mld_nan_link_add(struct iwl_mld *mld,
 }
 
 static int iwl_mld_nan_link_set_active(struct iwl_mld *mld,
+				       struct ieee80211_vif *vif,
 				       struct iwl_mld_nan_link *nan_link,
 				       bool active)
 {
 	struct iwl_link_config_cmd cmd;
+	struct ieee80211_sta *sta;
 	int ret;
 
 	if (nan_link->active == active)
 		return 0;
 
+	if (active) {
+		for_each_station(sta, mld->hw) {
+			struct iwl_mld_sta *mld_sta = iwl_mld_sta_from_mac80211(sta);
+
+			if (mld_sta->sta_type == STATION_TYPE_NAN_PEER_NDI)
+				iwl_mld_config_tlc(mld, mld_sta->vif, sta);
+		}
+	}
+
 	nan_link->active = active;
 
 	iwl_mld_nan_link_prep_cmd(mld, nan_link, &cmd,
@@ -457,8 +469,10 @@ static int iwl_mld_nan_link_set_active(struct iwl_mld *mld,
 		return ret;
 	}
 
-	if (!active)
+	if (!active) {
 		nan_link->chanctx = NULL;
+		/* TODO: when FW is ready, Update phy in TLC to invalid after */
+	}
 
 	return 0;
 }
@@ -590,7 +604,7 @@ void iwl_mld_nan_vif_cfg_changed(struct iwl_mld *mld,
 		if (links[i]) {
 			added_links = true;
 			link_used[links[i]->fw_id] = true;
-			iwl_mld_nan_link_set_active(mld, links[i], true);
+			iwl_mld_nan_link_set_active(mld, vif, links[i], true);
 		}
 	}
 
@@ -630,7 +644,7 @@ void iwl_mld_nan_vif_cfg_changed(struct iwl_mld *mld,
 	/* prepare stations for links we'll remove */
 	for_each_mld_nan_valid_link(mld_vif, nan_link) {
 		if (!link_used[nan_link->fw_id]) {
-			iwl_mld_nan_link_set_active(mld, nan_link, false);
+			iwl_mld_nan_link_set_active(mld, vif, nan_link, false);
 			remove_link_ids |= BIT(nan_link->fw_id);
 			/* mark unused for STA updates */
 			nan_link->fw_id = FW_CTXT_ID_INVALID;
@@ -694,6 +708,15 @@ int iwl_mld_mac802111_nan_peer_sched_changed(struct ieee80211_hw *hw,
 		.len[1] = sched->ulw_size,
 		.dataflags[1] = IWL_HCMD_DFL_DUP,
 	};
+	struct ieee80211_sta *iter;
+
+	/* Update TLC in case peer channels were added/removed/updated */
+	for_each_station(iter, mld->hw) {
+		struct iwl_mld_sta *tmp = iwl_mld_sta_from_mac80211(iter);
+
+		if (tmp->sta_type == STATION_TYPE_NAN_PEER_NDI)
+			iwl_mld_config_tlc(mld, tmp->vif, iter);
+	}
 
 	for (int i = 0; i < ARRAY_SIZE(sched->maps); i++) {
 		if (sched->maps[i].map_id == CFG80211_NAN_INVALID_MAP_ID)
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/tlc.c b/drivers/net/wireless/intel/iwlwifi/mld/tlc.c
index b1722982db9c..7db56eefc7df 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/tlc.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/tlc.c
@@ -529,7 +529,7 @@ static int iwl_mld_convert_tlc_cmd_to_v4(struct iwl_tlc_config_cmd *cmd,
 static void iwl_mld_send_tlc_cmd(struct iwl_mld *mld,
 				 struct ieee80211_vif *vif,
 				 struct iwl_mld_sta *mld_sta,
-				 int fw_sta_id, int phy_id,
+				 int fw_sta_mask, int phy_id,
 				 struct iwl_mld_tlc_sta_capa *capa)
 {
 	struct iwl_tlc_config_cmd cmd = {
@@ -550,10 +550,7 @@ static void iwl_mld_send_tlc_cmd(struct iwl_mld *mld,
 	u8 cmd_size;
 	int ret;
 
-	if (fw_sta_id < 0)
-		return;
-
-	cmd.sta_mask = cpu_to_le32(BIT(fw_sta_id));
+	cmd.sta_mask = cpu_to_le32(fw_sta_mask);
 	cmd.phy_id = cpu_to_le32(phy_id);
 
 	iwl_mld_fill_supp_rates(mld, vif, capa, &cmd);
@@ -617,25 +614,27 @@ int iwl_mld_send_tlc_dhc(struct iwl_mld *mld, u8 sta_id, u32 type, u32 data)
 	return ret;
 }
 
-void iwl_mld_config_tlc_link(struct iwl_mld *mld,
-			     struct ieee80211_vif *vif,
-			     struct ieee80211_bss_conf *link_conf,
-			     struct ieee80211_link_sta *link_sta)
+static void _iwl_mld_config_tlc_link(struct iwl_mld *mld,
+				     struct ieee80211_vif *vif,
+				     struct ieee80211_chanctx_conf *chan_ctx,
+				     u32 fw_sta_mask,
+				     struct ieee80211_link_sta *link_sta,
+				     struct iwl_mld_tlc_sta_capa *capa)
 {
 	struct iwl_mld_sta *mld_sta = iwl_mld_sta_from_mac80211(link_sta->sta);
-	struct iwl_mld_link *mld_link = iwl_mld_link_from_mac80211(link_conf);
-	struct ieee80211_chanctx_conf *chan_ctx;
 	struct ieee80211_supported_band *sband;
-	struct iwl_mld_tlc_sta_capa capa = {};
 	unsigned long rates_bitmap;
 	enum nl80211_band band;
-	int fw_sta_id, i;
+	int i;
 
-	if (WARN_ON_ONCE(!mld_link))
-		return;
+	/*
+	 * Note: Due to NAN, the chan_ctx here might not be the same as the
+	 * vif->links[link_sta->link_id] one (which is NULL in NAN), so some
+	 * care is needed in this function (and the 'capa' exists to make it
+	 * less error-prone, the other functions need not worry about it.)
+	 */
 
-	chan_ctx = rcu_dereference_wiphy(mld->wiphy, mld_link->chan_ctx);
-	if (WARN_ON_ONCE(!chan_ctx))
+	if (WARN_ON(!chan_ctx))
 		return;
 
 	band = chan_ctx->def.chan->band;
@@ -653,25 +652,18 @@ void iwl_mld_config_tlc_link(struct iwl_mld *mld,
 	/* non HT rates */
 	rates_bitmap = link_sta->supp_rates[sband->band];
 	for_each_set_bit(i, &rates_bitmap, BITS_PER_LONG)
-		capa.non_ht_rates |= BIT(sband->bitrates[i].hw_value);
+		capa->non_ht_rates |= BIT(sband->bitrates[i].hw_value);
 
-	capa.rx_nss = link_sta->rx_nss;
-	capa.smps_mode = link_sta->smps_mode;
-	capa.bandwidth = link_sta->bandwidth;
-	capa.max_amsdu_len = link_sta->agg.max_amsdu_len;
-	capa.ht_cap = &link_sta->ht_cap;
-	capa.vht_cap = &link_sta->vht_cap;
-	capa.he_cap = &link_sta->he_cap;
-	capa.eht_cap = &link_sta->eht_cap;
-	capa.uhr_cap = &link_sta->uhr_cap;
-	capa.own_he_cap = ieee80211_get_he_iftype_cap_vif(sband, vif);
-	capa.own_eht_cap = ieee80211_get_eht_iftype_cap_vif(sband, vif);
-	capa.own_uhr_cap = ieee80211_get_uhr_iftype_cap_vif(sband, vif);
+	capa->max_amsdu_len = link_sta->agg.max_amsdu_len;
+	capa->ht_cap = &link_sta->ht_cap;
+	capa->vht_cap = &link_sta->vht_cap;
+	capa->he_cap = &link_sta->he_cap;
+	capa->eht_cap = &link_sta->eht_cap;
+	capa->uhr_cap = &link_sta->uhr_cap;
 
-	fw_sta_id = iwl_mld_fw_sta_id_from_link_sta(mld, link_sta);
-	iwl_mld_send_tlc_cmd(mld, vif, mld_sta, fw_sta_id,
+	iwl_mld_send_tlc_cmd(mld, vif, mld_sta, fw_sta_mask,
 			     iwl_mld_phy_from_mac80211(chan_ctx)->fw_id,
-			     &capa);
+			     capa);
 }
 
 void iwl_mld_tlc_update_phy(struct iwl_mld *mld, struct ieee80211_vif *vif,
@@ -717,6 +709,136 @@ void iwl_mld_tlc_update_phy(struct iwl_mld *mld, struct ieee80211_vif *vif,
 	}
 }
 
+static void iwl_mld_config_tlc_nan(struct iwl_mld *mld,
+				   struct ieee80211_vif *vif,
+				   struct ieee80211_link_sta *link_sta,
+				   int fw_sta_id)
+{
+	struct ieee80211_nan_peer_sched *sched;
+	struct iwl_mld_nan_link *nan_link;
+	struct ieee80211_sta *nmi, *iter;
+	struct iwl_mld_vif *nan_mld_vif;
+	u32 fw_sta_mask;
+
+	nmi = wiphy_dereference(mld->wiphy, link_sta->sta->nmi);
+	if (WARN_ON(!nmi))
+		return;
+
+	sched = nmi->nan_sched;
+
+	/* This sta might not be in the list yet as it is just getting added */
+	fw_sta_mask = BIT(fw_sta_id);
+	for_each_station(iter, mld->hw) {
+		struct iwl_mld_sta *mld_sta = iwl_mld_sta_from_mac80211(iter);
+		struct ieee80211_sta *iter_nmi;
+
+		iter_nmi = wiphy_dereference(mld->wiphy, iter->nmi);
+
+		if (iter_nmi == nmi)
+			fw_sta_mask |= BIT(mld_sta->deflink.fw_id);
+	}
+
+	if (WARN_ON(!mld->nan_device_vif))
+		return;
+
+	nan_mld_vif = iwl_mld_vif_from_mac80211(mld->nan_device_vif);
+
+	for_each_mld_nan_valid_link(nan_mld_vif, nan_link) {
+		struct ieee80211_chanctx_conf *chan_ctx;
+		struct iwl_mld_tlc_sta_capa capa = {};
+		struct cfg80211_chan_def *chandef;
+		bool common_channel = false;
+
+		chan_ctx = nan_link->chanctx;
+		if (!chan_ctx)
+			continue;
+
+		chandef = iwl_mld_get_chandef_from_chanctx(mld, chan_ctx);
+
+		capa.smps_mode = IEEE80211_SMPS_OFF; /* always off */
+
+		capa.rx_nss = 2; /* maximum we support */
+		capa.bandwidth = ieee80211_chan_width_to_rx_bw(chandef->width);
+
+		for (int j = 0; j < (sched ? sched->n_channels : 0); j++) {
+			enum ieee80211_sta_rx_bandwidth rx_bw;
+			enum nl80211_chan_width width;
+			int chains;
+
+			if (sched->channels[j].chanctx_conf != chan_ctx)
+				continue;
+
+			common_channel = true;
+
+			width = sched->channels[j].chanreq.oper.width;
+			rx_bw = ieee80211_chan_width_to_rx_bw(width);
+			capa.bandwidth = min(capa.bandwidth, rx_bw);
+
+			chains = sched->channels[j].needed_rx_chains;
+			capa.rx_nss = min(capa.rx_nss, chains);
+		}
+
+		/* Apply minimum parameters if there is no common channel */
+		if (!common_channel) {
+			capa.bandwidth = IEEE80211_STA_RX_BW_20;
+			capa.rx_nss = 1;
+		}
+
+		capa.own_he_cap = &mld->wiphy->nan_capa.phy.he;
+		/* no EHT/UHR for NAN */
+
+		_iwl_mld_config_tlc_link(mld, vif, chan_ctx, fw_sta_mask,
+					 link_sta, &capa);
+	}
+}
+
+void iwl_mld_config_tlc_link(struct iwl_mld *mld,
+			     struct ieee80211_vif *vif,
+			     struct ieee80211_bss_conf *link_conf,
+			     struct ieee80211_link_sta *link_sta)
+{
+	struct iwl_mld_link *mld_link = iwl_mld_link_from_mac80211(link_conf);
+	int fw_sta_id = iwl_mld_fw_sta_id_from_link_sta(mld, link_sta);
+	struct ieee80211_chanctx_conf *chan_ctx;
+	struct ieee80211_supported_band *sband;
+	struct iwl_mld_tlc_sta_capa capa = {};
+	struct cfg80211_chan_def *chandef;
+	enum nl80211_band band;
+
+	if (fw_sta_id < 0)
+		return;
+
+	if (vif->type == NL80211_IFTYPE_NAN)
+		return;
+
+	if (vif->type == NL80211_IFTYPE_NAN_DATA) {
+		iwl_mld_config_tlc_nan(mld, vif, link_sta, fw_sta_id);
+		return;
+	}
+
+	if (WARN_ON_ONCE(!mld_link))
+		return;
+
+	chan_ctx = rcu_dereference_wiphy(mld->wiphy, mld_link->chan_ctx);
+	if (WARN_ON_ONCE(!chan_ctx))
+		return;
+
+	chandef = &iwl_mld_phy_from_mac80211(chan_ctx)->chandef;
+	band = chandef->chan->band;
+	sband = mld->hw->wiphy->bands[band];
+
+	capa.smps_mode = link_sta->smps_mode;
+	capa.rx_nss = link_sta->rx_nss;
+	capa.bandwidth = ieee80211_chan_width_to_rx_bw(chandef->width);
+	capa.bandwidth = min(capa.bandwidth, link_sta->bandwidth);
+	capa.own_he_cap = ieee80211_get_he_iftype_cap_vif(sband, vif);
+	capa.own_eht_cap = ieee80211_get_eht_iftype_cap_vif(sband, vif);
+	capa.own_uhr_cap = ieee80211_get_uhr_iftype_cap_vif(sband, vif);
+
+	_iwl_mld_config_tlc_link(mld, vif, chan_ctx, BIT(fw_sta_id),
+				 link_sta, &capa);
+}
+
 void iwl_mld_config_tlc(struct iwl_mld *mld, struct ieee80211_vif *vif,
 			struct ieee80211_sta *sta)
 {
@@ -725,6 +847,7 @@ void iwl_mld_config_tlc(struct iwl_mld *mld, struct ieee80211_vif *vif,
 
 	lockdep_assert_wiphy(mld->wiphy);
 
+	/* Note: for NAN this is only the mac80211-level deflink */
 	for_each_vif_active_link(vif, link, link_id) {
 		struct ieee80211_link_sta *link_sta =
 			link_sta_dereference_check(sta, link_id);
-- 
2.34.1


