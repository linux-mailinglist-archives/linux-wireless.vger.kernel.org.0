Return-Path: <linux-wireless+bounces-36479-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UF0nJioVB2pQrgIAu9opvQ
	(envelope-from <linux-wireless+bounces-36479-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 14:44:26 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E5954FD25
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 14:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EC5FB3173356
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 12:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5219447ECE3;
	Fri, 15 May 2026 12:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KFz7dSmY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB2547ECFF
	for <linux-wireless@vger.kernel.org>; Fri, 15 May 2026 12:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778847024; cv=none; b=ptbqdqcO6l219AMz6OfnvQzyaKVSQ4108CphV76TioTmynzsbGrDwyvVCWwxfzW20T+n9qiAFuExJihBTVEfYD14Mf9ov6fWh2x7OZ5X8IDRxD93OkZ+gZu2jzopQTg8cIn7hmsu0MzqtslJ5tBuyzJlYMz5NCVdyeQQCod69DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778847024; c=relaxed/simple;
	bh=BYKjSB258Uz3bMvBBAR0gYWkOiPb0PfXDbQYisiaK80=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Nd9we3hyiZhMZtf2ztP6Kru0ygqCoW/YZfogRkTPiSnx2HNw9TleqbOIaqwOkvlOAeutldDaO9xmFlmiJHBI4O2XAmGjbYBMi4IF/SXdOEU3vUwLGCmVXskXDpc0yRqN7pgvKdgoa7V0Ui9DJO4eEDjG2v2idzLqrhiCJBvnfR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KFz7dSmY; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778847022; x=1810383022;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BYKjSB258Uz3bMvBBAR0gYWkOiPb0PfXDbQYisiaK80=;
  b=KFz7dSmYlCIjDQk8T1cDwwanFNX8XVwdg7BiHmYat51/Xdyp7yyd6Son
   O6E8LdmoFkgtmoGl3lUmZMire8GlP6Z6F2Q+TZ5mvUM00sUWwWD49m2rZ
   Ct7SsqSo+Ep5x9MLpXLNdWXChwjUFtet1zeLnjLv5UoUIsWzF7ANnMOvi
   LGByzhCCMIAt6kz7I1oHtGiolGEuCPXEao14bX5VAS1UKYvAn63o2B9KN
   0/PN3vm01KjSwxXfxW+5EzgQGmG5RWd2qZSZCEAML+PwxJveoZGJd1Fvx
   UwCchDeEmPKqkBtcCq3Lg+/2yWHZ0IRfa1578/kcFmLHIO+7LuQL2psVR
   w==;
X-CSE-ConnectionGUID: jlkDu9EHSW2aiveDYBe8Og==
X-CSE-MsgGUID: yQwEOMsdQ36AERE1sTIlCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11786"; a="91185693"
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="91185693"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 05:10:22 -0700
X-CSE-ConnectionGUID: zh9BtrucR0+TwI1HlN/yLg==
X-CSE-MsgGUID: LqbW6ye1QCSCz8I3Wl2YXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="243650072"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 05:10:20 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Shahar Tzarfati <shahar.tzarfati@intel.com>
Subject: [PATCH v2 iwlwifi-next 14/15] wifi: iwlwifi: mld: expose beacon avg signal
Date: Fri, 15 May 2026 15:09:47 +0300
Message-Id: <20260515150751.a74a22d90890.I74d596359c5b69364fb977fdf31396eb57ca0927@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260515120948.1157329-1-miriam.rachel.korenblit@intel.com>
References: <20260515120948.1157329-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E5E5954FD25
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36479-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

From: Shahar Tzarfati <shahar.tzarfati@intel.com>

Store beacon_average_energy from per-link FW statistics and expose it
via station_info as rx_beacon_signal_avg in sta statistics.

This fixes missing beacon average signal reporting to upper layers.

Signed-off-by: Shahar Tzarfati <shahar.tzarfati@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/link.h |  3 ++
 .../net/wireless/intel/iwlwifi/mld/stats.c    | 47 ++++++++++++++++++-
 2 files changed, 48 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/link.h b/drivers/net/wireless/intel/iwlwifi/mld/link.h
index 4527f054ce92..0b3974d86531 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/link.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/link.h
@@ -36,6 +36,8 @@ struct iwl_probe_resp_data {
  * @rcu_head: RCU head for freeing this data.
  * @fw_id: the fw id of the link.
  * @active: if the link is active or not.
+ * @avg_signal: The current average signal of beacons [dBm] retrieved from
+ *	firmware per-link periodic stats (STATISTICS_OPER_NOTIF).
  * @queue_params: QoS data from mac80211. This is updated with a call to
  *	drv_conf_tx per each AC, and then notified once with BSS_CHANGED_QOS.
  *	So we store it here and then send one link cmd for all the ACs.
@@ -68,6 +70,7 @@ struct iwl_mld_link {
 	struct_group(zeroed_on_hw_restart,
 		u8 fw_id;
 		bool active;
+		s8 avg_signal;
 		struct ieee80211_tx_queue_params queue_params[IEEE80211_NUM_ACS];
 		struct ieee80211_chanctx_conf __rcu *chan_ctx;
 		bool he_ru_2mhz_block;
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/stats.c b/drivers/net/wireless/intel/iwlwifi/mld/stats.c
index b93e0f8ab5fb..e7b283cbe199 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/stats.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/stats.c
@@ -311,6 +311,40 @@ static void iwl_mld_sta_stats_fill_txrate(struct iwl_mld_sta *mld_sta,
 	}
 }
 
+static void iwl_mld_sta_stats_fill_beacon_signal_avg(struct ieee80211_vif *vif,
+						     struct station_info *sinfo)
+{
+	struct ieee80211_bss_conf *link_conf;
+	struct iwl_mld_link *link;
+	u8 link_id;
+
+	if (iwl_mld_emlsr_active(vif))
+		return;
+
+	/* TODO: support statistics for NAN */
+	if (vif->type == NL80211_IFTYPE_NAN ||
+	    vif->type == NL80211_IFTYPE_NAN_DATA)
+		return;
+
+	link_id = iwl_mld_get_primary_link(vif);
+	link_conf = link_conf_dereference_protected(vif, link_id);
+
+	if (WARN_ONCE(!link_conf,
+		      "link_conf is NULL for link_id=%u\n", link_id))
+		return;
+
+	link = iwl_mld_link_from_mac80211(link_conf);
+	if (WARN_ONCE(!link,
+		      "iwl_mld_link is NULL for link_id=%u\n", link_id))
+		return;
+
+	if (!link->avg_signal)
+		return;
+
+	sinfo->rx_beacon_signal_avg = link->avg_signal;
+	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_BEACON_SIGNAL_AVG);
+}
+
 void iwl_mld_mac80211_sta_statistics(struct ieee80211_hw *hw,
 				     struct ieee80211_vif *vif,
 				     struct ieee80211_sta *sta,
@@ -329,9 +363,9 @@ void iwl_mld_mac80211_sta_statistics(struct ieee80211_hw *hw,
 
 	iwl_mld_sta_stats_fill_txrate(mld_sta, sinfo);
 
-	/* TODO: NL80211_STA_INFO_BEACON_RX */
+	iwl_mld_sta_stats_fill_beacon_signal_avg(vif, sinfo);
 
-	/* TODO: NL80211_STA_INFO_BEACON_SIGNAL_AVG */
+	/* TODO: NL80211_STA_INFO_BEACON_RX */
 }
 
 #define IWL_MLD_TRAFFIC_LOAD_MEDIUM_THRESH	10 /* percentage */
@@ -443,6 +477,8 @@ iwl_mld_process_per_link_stats(struct iwl_mld *mld,
 	     fw_id++) {
 		const struct iwl_stats_ntfy_per_link *link_stats;
 		struct ieee80211_bss_conf *bss_conf;
+		struct iwl_mld_link *link;
+		u32 avg_raw;
 		int sig;
 
 		bss_conf = iwl_mld_fw_id_to_link_conf(mld, fw_id);
@@ -456,6 +492,13 @@ iwl_mld_process_per_link_stats(struct iwl_mld *mld,
 		sig = -le32_to_cpu(link_stats->beacon_filter_average_energy);
 		iwl_mld_update_link_sig(bss_conf->vif, sig, bss_conf);
 
+		link = iwl_mld_link_from_mac80211(bss_conf);
+		if (WARN_ON_ONCE(!link))
+			continue;
+
+		avg_raw = le32_to_cpu(link_stats->beacon_average_energy);
+		link->avg_signal = clamp_t(int, -(int)avg_raw, S8_MIN, 0);
+
 		/* TODO: parse more fields here (task=statistics)*/
 	}
 
-- 
2.34.1


