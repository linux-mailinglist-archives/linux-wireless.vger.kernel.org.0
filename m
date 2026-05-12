Return-Path: <linux-wireless+bounces-36295-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OB6ULp26AmonwAEAu9opvQ
	(envelope-from <linux-wireless+bounces-36295-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 07:29:01 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A95A051A0BF
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 07:29:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CBFF43047AA6
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 05:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86C273328FA;
	Tue, 12 May 2026 05:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TtTGEvwA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33CF335BA8
	for <linux-wireless@vger.kernel.org>; Tue, 12 May 2026 05:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778563407; cv=none; b=bj/QCpK6oMcs124qgH09VPqs+I25Ujvp/wdSk0Z+TNAl8R5NlEDPt3ObMlIEeXwqbkUrRMfJEtGyeVRCkrK7Vx3k4qPo0y8684HMQdp2wuVZyk88UMrB+yq+HAdXnlSVk7F2u6jIWWaFhX/WVQzzQ7YE7adz31l2iOoqa1cImBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778563407; c=relaxed/simple;
	bh=lEIiczdintbfvT+pB0y0VyUHtBpXqSW5hgMoQUAojGw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QC8hfVZCj5rqIGUYwxvXnhN50qnce0WpkTGY4tWKkn3Pc4QuaTLGiSZMCglxbtG8fYpkIaVIzw+acEgzdZDAaH64/BQCReki+tDr8Soa3UAUarE242bP9sO9JPd3l9SnWMiNSWTV5aFHzA203m+yp2cZns8zznGxthgLghfy8fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TtTGEvwA; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778563405; x=1810099405;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lEIiczdintbfvT+pB0y0VyUHtBpXqSW5hgMoQUAojGw=;
  b=TtTGEvwAEcfBKaeBHiR4lNVsQ21sb6z8/CztZltrNWn2wmjpoJJT2/Sf
   k8S72wkWh2c7Yyro13FyJOn33IlWFSJdxrZIvtjUHiacW+xwCo4+tBnH4
   bFNbjEZ3PSr+ML7nxydtRW0rg2sEkvHAcHNv16DLm+QHHfcgiXPHpH2Xo
   Jw/aUmCw/InibNX1Z8u4aczPp1tKLQJqzOxZ56KFP98u7ji2j9H71+MOp
   aMiKrv1y8cHBJvCIDkxbdDzleAfPKTossiE3mnt+Q1AMMReo63DeLXSWl
   3sVnR7BVIoI53n2Eji7F/gbPqvDVOfKckQ0ksf0ObJ76lwQFdBC8U4Ea0
   Q==;
X-CSE-ConnectionGUID: 0Z+8MQgzQMqypGn7wMEpQw==
X-CSE-MsgGUID: PEtVkvWDTMW5HdXAUMxxYg==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="78495091"
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="78495091"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 22:23:25 -0700
X-CSE-ConnectionGUID: ucBQ2CvUQuKpTTfwVsZ6bg==
X-CSE-MsgGUID: ba3nNe0cRLGrZNI6s23W3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="233187516"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 22:23:24 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH iwlwifi-next 04/15] wifi: iwlwifi: mld: support the new statistics APIs
Date: Tue, 12 May 2026 08:22:56 +0300
Message-Id: <20260512082114.04ccf0f3f2c6.Iaff5ac57a53fe62ea7c1313bc57a81b23b1e2fdf@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260512052307.1603442-1-miriam.rachel.korenblit@intel.com>
References: <20260512052307.1603442-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A95A051A0BF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-36295-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:email,intel.com:dkim]
X-Rspamd-Action: no action

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

This new API adds information about Coexistence.
It changes the layout of the notification, adapt the code accordingly.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/mld/notif.c    |  3 +-
 .../net/wireless/intel/iwlwifi/mld/stats.c    | 59 +++++++++++++++----
 2 files changed, 48 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/notif.c b/drivers/net/wireless/intel/iwlwifi/mld/notif.c
index f7aeff61d785..692251257116 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/notif.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/notif.c
@@ -330,7 +330,8 @@ CMD_VERSIONS(probe_resp_data_notif,
 CMD_VERSIONS(datapath_monitor_notif,
 	     CMD_VER_ENTRY(1, iwl_datapath_monitor_notif))
 CMD_VERSIONS(stats_oper_notif,
-	     CMD_VER_ENTRY(3, iwl_system_statistics_notif_oper_v3))
+	     CMD_VER_ENTRY(3, iwl_system_statistics_notif_oper_v3)
+	     CMD_VER_ENTRY(4, iwl_system_statistics_notif_oper))
 CMD_VERSIONS(stats_oper_part1_notif,
 	     CMD_VER_ENTRY(4, iwl_system_statistics_part1_notif_oper))
 CMD_VERSIONS(bt_coex_notif,
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/stats.c b/drivers/net/wireless/intel/iwlwifi/mld/stats.c
index 714d66324e9f..0daf16766d24 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/stats.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/stats.c
@@ -40,13 +40,21 @@ iwl_mld_fill_stats_from_oper_notif(struct iwl_mld *mld,
 				   struct iwl_rx_packet *pkt,
 				   u8 fw_sta_id, struct station_info *sinfo)
 {
-	const struct iwl_system_statistics_notif_oper_v3 *notif =
-		(void *)&pkt->data;
-	const struct iwl_stats_ntfy_per_sta *per_sta =
-		&notif->per_sta[fw_sta_id];
+	const struct iwl_stats_ntfy_per_sta *per_sta;
 	struct ieee80211_link_sta *link_sta;
 	struct iwl_mld_link_sta *mld_link_sta;
 
+	if (iwl_fw_lookup_notif_ver(mld->fw, STATISTICS_GROUP,
+				    STATISTICS_OPER_NOTIF, 3) >= 4) {
+		const struct iwl_system_statistics_notif_oper *notif =
+			(void *)&pkt->data;
+		per_sta = &notif->per_sta[fw_sta_id];
+	} else {
+		const struct iwl_system_statistics_notif_oper_v3 *notif =
+			(void *)&pkt->data;
+		per_sta = &notif->per_sta[fw_sta_id];
+	}
+
 	/* 0 isn't a valid value, but FW might send 0.
 	 * In that case, set the latest non-zero value we stored
 	 */
@@ -483,7 +491,7 @@ static void iwl_mld_fill_chanctx_stats(struct ieee80211_hw *hw,
 				       void *data)
 {
 	struct iwl_mld_phy *phy = iwl_mld_phy_from_mac80211(ctx);
-	const struct iwl_stats_ntfy_per_phy_v1 *per_phy = data;
+	const struct iwl_stats_ntfy_per_phy *per_phy = data;
 	u32 new_load, old_load;
 
 	if (WARN_ON(phy->fw_id >= IWL_STATS_MAX_PHY_OPERATIONAL))
@@ -512,7 +520,7 @@ static void iwl_mld_fill_chanctx_stats(struct ieee80211_hw *hw,
 
 static void
 iwl_mld_process_per_phy_stats(struct iwl_mld *mld,
-			      const struct iwl_stats_ntfy_per_phy_v1 *per_phy)
+			      const struct iwl_stats_ntfy_per_phy *per_phy)
 {
 	ieee80211_iter_chan_contexts_mtx(mld->hw,
 					 iwl_mld_fill_chanctx_stats,
@@ -523,17 +531,42 @@ iwl_mld_process_per_phy_stats(struct iwl_mld *mld,
 void iwl_mld_handle_stats_oper_notif(struct iwl_mld *mld,
 				     struct iwl_rx_packet *pkt)
 {
-	const struct iwl_system_statistics_notif_oper_v3 *stats =
+	struct iwl_system_statistics_notif_oper *_notif __free(kfree) = NULL;
+	const struct iwl_system_statistics_notif_oper *notif =
 		(void *)&pkt->data;
-	u32 curr_ts_usec = le32_to_cpu(stats->time_stamp);
 
-	BUILD_BUG_ON(ARRAY_SIZE(stats->per_sta) != IWL_STATION_COUNT_MAX);
-	BUILD_BUG_ON(ARRAY_SIZE(stats->per_link) <
+	BUILD_BUG_ON(ARRAY_SIZE(notif->per_sta) != IWL_STATION_COUNT_MAX);
+	BUILD_BUG_ON(ARRAY_SIZE(notif->per_link) <
 		     ARRAY_SIZE(mld->fw_id_to_bss_conf));
 
-	iwl_mld_process_per_link_stats(mld, stats->per_link, curr_ts_usec);
-	iwl_mld_process_per_sta_stats(mld, stats->per_sta);
-	iwl_mld_process_per_phy_stats(mld, stats->per_phy);
+	if (iwl_fw_lookup_notif_ver(mld->fw, STATISTICS_GROUP,
+				    STATISTICS_OPER_NOTIF, 3) == 3) {
+		const struct iwl_system_statistics_notif_oper_v3 *stats =
+			(void *)&pkt->data;
+		_notif = kzalloc(sizeof(*_notif), GFP_KERNEL);
+
+		if (!_notif)
+			return;
+
+		_notif->time_stamp = stats->time_stamp;
+		for (int i = 0; i < ARRAY_SIZE(_notif->per_link); i++)
+			_notif->per_link[i] = stats->per_link[i];
+
+		BUILD_BUG_ON(sizeof(_notif->per_phy[0]) <
+			     sizeof(stats->per_phy[0]));
+		for (int i = 0; i < ARRAY_SIZE(_notif->per_phy); i++)
+			memcpy(&_notif->per_phy[i], &stats->per_phy[i],
+			       sizeof(stats->per_phy[i]));
+		for (int i = 0; i < ARRAY_SIZE(_notif->per_sta); i++)
+			_notif->per_sta[i] = stats->per_sta[i];
+
+		notif = _notif;
+	}
+
+	iwl_mld_process_per_link_stats(mld, notif->per_link,
+				       le32_to_cpu(notif->time_stamp));
+	iwl_mld_process_per_sta_stats(mld, notif->per_sta);
+	iwl_mld_process_per_phy_stats(mld, notif->per_phy);
 }
 
 void iwl_mld_handle_stats_oper_part1_notif(struct iwl_mld *mld,
-- 
2.34.1


