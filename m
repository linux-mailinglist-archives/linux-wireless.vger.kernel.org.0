Return-Path: <linux-wireless+bounces-36434-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oLg6A4smBmqmfgIAu9opvQ
	(envelope-from <linux-wireless+bounces-36434-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 14 May 2026 21:46:19 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 614FD5467B7
	for <lists+linux-wireless@lfdr.de>; Thu, 14 May 2026 21:46:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CBC023050463
	for <lists+linux-wireless@lfdr.de>; Thu, 14 May 2026 19:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BBE839AD32;
	Thu, 14 May 2026 19:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c7qmodEv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C003BA239
	for <linux-wireless@vger.kernel.org>; Thu, 14 May 2026 19:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778787911; cv=none; b=dCUexl+awPWI8tWDWefXdG9oDQ39+TIyaQB/MpUF/K2N30UPFd73X3hoRjGpV86d80zZsglLj6npBhOxRNNpSXxG4HrATk2cMssaB8BttDcAEEAOt075E1ekmSXjIER5XiL0H70H2KYgkjp3x6xo+o8nOwDxQj18wjZ63FsSntc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778787911; c=relaxed/simple;
	bh=QhImjUglwWPaN+T49e+GQRpzTlOwIg2Dck913odjZM4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W/mNcmV8jhzFvck3BkHk+zaKZI4gPMX7JzTamFClkfJqijTCraiD8GLkLrK8cOUHG+ZRlZpZKvIKtluaMtvXs5KbeAu09IDbPAkKQSZQydCxyKzJ2FiUbNVOQymJfr9rGsTVvuX4QS2PTcKikoXe+Yr0jDLE0qEHQpf+pgcvGpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c7qmodEv; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778787910; x=1810323910;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QhImjUglwWPaN+T49e+GQRpzTlOwIg2Dck913odjZM4=;
  b=c7qmodEvKASbji69H1qyDWu/ETCJeKrziCGa+JLrnbw3fsLKyA/ZWMYe
   Vn2QM32ThryUUhnx2emo046wv/J3rZYPOjOut3meMfZ00ZspdoYbAZ+OY
   +zeU+j/KLRz3aQRQ7ts+uixVyXdF7JMCdXZb7OJfyz3E2mh9SowH99xCR
   sfsq5RHQrXwWlyGFMFc2SB1gIN8zEiMR/tb2WG3UjVspECY9K4romED6K
   u2fUFdKpuKGxSiDCAEz3yAzjjZZrLLlMCOQTgAZa8SSaQiQTOUoBPY+Zi
   8UHEmJZRCDT6tmxnMgiIfOKZPRS5/mQVcUXysk8gjbyRrp8A/RaNaHf8d
   A==;
X-CSE-ConnectionGUID: Ql1VnUegTCe/72VBcX167Q==
X-CSE-MsgGUID: dcJvzrv4RVK6gTJNZwI6Pg==
X-IronPort-AV: E=McAfee;i="6800,10657,11786"; a="83352620"
X-IronPort-AV: E=Sophos;i="6.23,235,1770624000"; 
   d="scan'208";a="83352620"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2026 12:45:09 -0700
X-CSE-ConnectionGUID: tTFrjQ9GSEO5JwL4xkHpZQ==
X-CSE-MsgGUID: Ogr7sc3DT3+YrmYazzcuRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,235,1770624000"; 
   d="scan'208";a="237616382"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2026 12:45:08 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Shahar Tzarfati <shahar.tzarfati@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH iwlwifi-next 14/15] wifi: iwlwifi: mld: expose beacon avg signal
Date: Thu, 14 May 2026 22:44:33 +0300
Message-Id: <20260514224230.cf98920a8ba5.I74d596359c5b69364fb977fdf31396eb57ca0927@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260514194434.401241-1-miriam.rachel.korenblit@intel.com>
References: <20260514194434.401241-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 614FD5467B7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-36434-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
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

From: Shahar Tzarfati <shahar.tzarfati@intel.com>

Store beacon_average_energy from per-link FW statistics and expose it
via station_info as rx_beacon_signal_avg in sta statistics.

This fixes missing beacon average signal reporting to upper layers.

Signed-off-by: Shahar Tzarfati <shahar.tzarfati@intel.com>
tested: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
PerCI-Ready: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Tested-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
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


