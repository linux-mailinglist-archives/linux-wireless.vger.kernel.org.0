Return-Path: <linux-wireless+bounces-33768-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GExLFH9cwmlKcAQAu9opvQ
	(envelope-from <linux-wireless+bounces-33768-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2026 10:42:23 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A0176305C49
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2026 10:42:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1AA08301DE33
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2026 09:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2DFC27EFEE;
	Tue, 24 Mar 2026 09:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DqzCHLBd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827AF3DB656
	for <linux-wireless@vger.kernel.org>; Tue, 24 Mar 2026 09:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774344820; cv=none; b=mqrhHMbiz1GQQLQ+SL3YAm35XzjbNxcjZI1HDQdUdqZyukqSy9rPUV9C4ikRyOFN/XxQDM+cE66Pr9DsugCg89lbBJWykCZ4MIZUbHYBt3sCcj3KAZgQG5D611+641HV8loQUQzaaQORhyrHYJDQo3k0JmVowMnUK+t7o+vkMgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774344820; c=relaxed/simple;
	bh=AoTxC1BhQv6fgsOITx5Yu2rkmippmSprp0E4Y0RxXCY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=keUEeG7tqvF7TV7PMBa0RkjhSA4NJC6uoaV26ShlDDMP1zTlNI7ThtQJkaH/N/Szzs1kFebxuiTeM8iSoQqCVo61ulK215LwOigregzL582uOecSq+B+KkwtHG3yaAldDZWquWdSed5XI7367+SI3TTgLupjQTD465gtgam6xgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DqzCHLBd; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774344819; x=1805880819;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=AoTxC1BhQv6fgsOITx5Yu2rkmippmSprp0E4Y0RxXCY=;
  b=DqzCHLBdc8zOyyKtkzPCAxEI0ihhzOL3yGPiYBLaGylb75Xt82ays3BO
   xx4zForgpSfa3Cag+zlJ9+J9GLUUWamgU13KtGCgJLVtLGdAufFkGZzuk
   HzhJBXq9KQOuWNgHyLTeza1n1+st2T402Rd3QHpHGZE0DWe25JiKngez3
   LGE1xnxqX+5ns8Xssj6WyDxyBNysQcazNLEePGa7nS/AGfQEogwGAVaAs
   iMQn063wqCeRwVYfPM5HyDpYUxWToHyaqvc8jfRxCng3ZIdMCccHhnaKT
   Amp+s9LyZukBmHaFJWEbPYPNJNpU7O/Mf883Bq9Iz618iNxjXbMEf4ZKo
   w==;
X-CSE-ConnectionGUID: W/UzmFmkSzeKhdGIXbUqww==
X-CSE-MsgGUID: l6NFxRAoSCmklXpMr3lKOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="75239816"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="75239816"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 02:33:38 -0700
X-CSE-ConnectionGUID: m1kBOy1eR+CsfbrHqyNUfA==
X-CSE-MsgGUID: 1+7vBbRpTgORnvoe+Ti2bg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="224302418"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 02:33:36 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Subject: [PATCH iwlwifi-fixes 1/3] wifi: iwlwifi: mld: Fix MLO scan timing
Date: Tue, 24 Mar 2026 11:33:24 +0200
Message-Id: <20260324113316.4c56b8bac533.I6e656d8cc30bb82c96aabadedd62bd67f4c46bf9@changeid>
X-Mailer: git-send-email 2.34.1
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
	TAGGED_FROM(0.00)[bounces-33768-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:email]
X-Rspamd-Queue-Id: A0176305C49
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>

Calculate MLO scan start time based on actual
scan start notification from firmware instead of recording
time when scan command is sent.

Currently, MLO scan start time was captured immediately
after sending the scan command to firmware. However, the
actual scan start time may differ due to the FW being busy
with a previous scan.

In that case, the link selection code will think that the MLO
scan is too old, and will warn.

To fix it, Implement start scan notification handling to
capture the precise moment when firmware begins the scan
operation.

Fixes: 9324731b9985 ("wifi: iwlwifi: mld: avoid selecting bad links")
Signed-off-by: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../wireless/intel/iwlwifi/fw/api/commands.h  |  5 ++++
 .../net/wireless/intel/iwlwifi/fw/api/scan.h  | 10 +++++++
 drivers/net/wireless/intel/iwlwifi/mld/mld.c  |  1 +
 drivers/net/wireless/intel/iwlwifi/mld/mlo.c  |  4 +--
 .../net/wireless/intel/iwlwifi/mld/notif.c    |  5 ++++
 drivers/net/wireless/intel/iwlwifi/mld/scan.c | 30 +++++++++++++++++--
 drivers/net/wireless/intel/iwlwifi/mld/scan.h |  9 ++++--
 7 files changed, 56 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h b/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h
index 8d64a271bb94..36159a769916 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h
@@ -296,6 +296,11 @@ enum iwl_legacy_cmds {
 	 */
 	SCAN_OFFLOAD_UPDATE_PROFILES_CMD = 0x6E,
 
+	/**
+	 * @SCAN_START_NOTIFICATION_UMAC: uses &struct iwl_umac_scan_start
+	 */
+	SCAN_START_NOTIFICATION_UMAC = 0xb2,
+
 	/**
 	 * @MATCH_FOUND_NOTIFICATION: scan match found
 	 */
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/scan.h b/drivers/net/wireless/intel/iwlwifi/fw/api/scan.h
index 60f0a4924ddf..46fcc32608e3 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/scan.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/scan.h
@@ -1156,6 +1156,16 @@ enum iwl_umac_scan_abort_status {
 	IWL_UMAC_SCAN_ABORT_STATUS_NOT_FOUND,
 };
 
+/**
+ * struct iwl_umac_scan_start - scan start notification
+ * @uid: scan id, &enum iwl_umac_scan_uid_offsets
+ * @reserved: for future use
+ */
+struct iwl_umac_scan_start {
+	__le32 uid;
+	__le32 reserved;
+} __packed; /* SCAN_START_UMAC_API_S_VER_1 */
+
 /**
  * struct iwl_umac_scan_complete - scan complete notification
  * @uid: scan id, &enum iwl_umac_scan_uid_offsets
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mld.c b/drivers/net/wireless/intel/iwlwifi/mld/mld.c
index 495e9d8f3af6..9af79297c3b6 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mld.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mld.c
@@ -171,6 +171,7 @@ static const struct iwl_hcmd_names iwl_mld_legacy_names[] = {
 	HCMD_NAME(MISSED_BEACONS_NOTIFICATION),
 	HCMD_NAME(MAC_PM_POWER_TABLE),
 	HCMD_NAME(MFUART_LOAD_NOTIFICATION),
+	HCMD_NAME(SCAN_START_NOTIFICATION_UMAC),
 	HCMD_NAME(RSS_CONFIG_CMD),
 	HCMD_NAME(SCAN_ITERATION_COMPLETE_UMAC),
 	HCMD_NAME(REPLY_RX_MPDU_CMD),
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mlo.c b/drivers/net/wireless/intel/iwlwifi/mld/mlo.c
index f842f5183223..fbff5915f7fd 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mlo.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mlo.c
@@ -739,7 +739,7 @@ iwl_mld_set_link_sel_data(struct iwl_mld *mld,
 
 		/* Ignore any BSS that was not seen in the last MLO scan */
 		if (ktime_before(link_conf->bss->ts_boottime,
-				 mld->scan.last_mlo_scan_time))
+				 mld->scan.last_mlo_scan_start_time))
 			continue;
 
 		data[n_data].link_id = link_id;
@@ -945,7 +945,7 @@ static void _iwl_mld_select_links(struct iwl_mld *mld,
 	if (!mld_vif->authorized || hweight16(usable_links) <= 1)
 		return;
 
-	if (WARN(ktime_before(mld->scan.last_mlo_scan_time,
+	if (WARN(ktime_before(mld->scan.last_mlo_scan_start_time,
 			      ktime_sub_ns(ktime_get_boottime_ns(),
 					   5ULL * NSEC_PER_SEC)),
 		"Last MLO scan was too long ago, can't select links\n"))
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/notif.c b/drivers/net/wireless/intel/iwlwifi/mld/notif.c
index 240526d8b632..9c88a8579a75 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/notif.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/notif.c
@@ -287,6 +287,8 @@ static void iwl_mld_handle_beacon_notification(struct iwl_mld *mld,
  * at least enough bytes to cover the structure listed in the CMD_VER_ENTRY.
  */
 
+CMD_VERSIONS(scan_start_notif,
+	     CMD_VER_ENTRY(1, iwl_umac_scan_start))
 CMD_VERSIONS(scan_complete_notif,
 	     CMD_VER_ENTRY(1, iwl_umac_scan_complete))
 CMD_VERSIONS(scan_iter_complete_notif,
@@ -360,6 +362,7 @@ DEFINE_SIMPLE_CANCELLATION(datapath_monitor, iwl_datapath_monitor_notif,
 			   link_id)
 DEFINE_SIMPLE_CANCELLATION(roc, iwl_roc_notif, activity)
 DEFINE_SIMPLE_CANCELLATION(scan_complete, iwl_umac_scan_complete, uid)
+DEFINE_SIMPLE_CANCELLATION(scan_start, iwl_umac_scan_start, uid)
 DEFINE_SIMPLE_CANCELLATION(probe_resp_data, iwl_probe_resp_data_notif,
 			   mac_id)
 DEFINE_SIMPLE_CANCELLATION(uapsd_misbehaving_ap, iwl_uapsd_misbehaving_ap_notif,
@@ -402,6 +405,8 @@ const struct iwl_rx_handler iwl_mld_rx_handlers[] = {
 			     RX_HANDLER_SYNC)
 	RX_HANDLER_NO_OBJECT(LEGACY_GROUP, BA_NOTIF, compressed_ba_notif,
 			     RX_HANDLER_SYNC)
+	RX_HANDLER_OF_SCAN(LEGACY_GROUP, SCAN_START_NOTIFICATION_UMAC,
+			   scan_start_notif)
 	RX_HANDLER_OF_SCAN(LEGACY_GROUP, SCAN_COMPLETE_UMAC,
 			   scan_complete_notif)
 	RX_HANDLER_NO_OBJECT(LEGACY_GROUP, SCAN_ITERATION_COMPLETE_UMAC,
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/scan.c b/drivers/net/wireless/intel/iwlwifi/mld/scan.c
index a1a4cf3ab3d3..abd4281b4b0e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/scan.c
@@ -473,6 +473,9 @@ iwl_mld_scan_get_cmd_gen_flags(struct iwl_mld *mld,
 	    params->flags & NL80211_SCAN_FLAG_COLOCATED_6GHZ)
 		flags |= IWL_UMAC_SCAN_GEN_FLAGS_V2_TRIGGER_UHB_SCAN;
 
+	if (scan_status == IWL_MLD_SCAN_INT_MLO)
+		flags |= IWL_UMAC_SCAN_GEN_FLAGS_V2_NTF_START;
+
 	if (params->enable_6ghz_passive)
 		flags |= IWL_UMAC_SCAN_GEN_FLAGS_V2_6GHZ_PASSIVE_SCAN;
 
@@ -1817,9 +1820,6 @@ static void iwl_mld_int_mlo_scan_start(struct iwl_mld *mld,
 	ret = _iwl_mld_single_scan_start(mld, vif, req, &ies,
 					 IWL_MLD_SCAN_INT_MLO);
 
-	if (!ret)
-		mld->scan.last_mlo_scan_time = ktime_get_boottime_ns();
-
 	IWL_DEBUG_SCAN(mld, "Internal MLO scan: ret=%d\n", ret);
 }
 
@@ -1904,6 +1904,30 @@ void iwl_mld_handle_match_found_notif(struct iwl_mld *mld,
 	ieee80211_sched_scan_results(mld->hw);
 }
 
+void iwl_mld_handle_scan_start_notif(struct iwl_mld *mld,
+				     struct iwl_rx_packet *pkt)
+{
+	struct iwl_umac_scan_complete *notif = (void *)pkt->data;
+	u32 uid = le32_to_cpu(notif->uid);
+
+	if (IWL_FW_CHECK(mld, uid >= ARRAY_SIZE(mld->scan.uid_status),
+			 "FW reports out-of-range scan UID %d\n", uid))
+		return;
+
+	if (IWL_FW_CHECK(mld, !(mld->scan.uid_status[uid] & mld->scan.status),
+			 "FW reports scan UID %d we didn't trigger\n", uid))
+		return;
+
+	IWL_DEBUG_SCAN(mld, "Scan started: uid=%u type=%u\n", uid,
+		       mld->scan.uid_status[uid]);
+	if (IWL_FW_CHECK(mld, mld->scan.uid_status[uid] != IWL_MLD_SCAN_INT_MLO,
+			 "FW reports scan start notification %d we didn't trigger\n",
+			 mld->scan.uid_status[uid]))
+		return;
+
+	mld->scan.last_mlo_scan_start_time = ktime_get_boottime_ns();
+}
+
 void iwl_mld_handle_scan_complete_notif(struct iwl_mld *mld,
 					struct iwl_rx_packet *pkt)
 {
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/scan.h b/drivers/net/wireless/intel/iwlwifi/mld/scan.h
index 69110f0cfc8e..de5620e7f463 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/scan.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/scan.h
@@ -27,6 +27,9 @@ int iwl_mld_sched_scan_start(struct iwl_mld *mld,
 void iwl_mld_handle_match_found_notif(struct iwl_mld *mld,
 				      struct iwl_rx_packet *pkt);
 
+void iwl_mld_handle_scan_start_notif(struct iwl_mld *mld,
+				     struct iwl_rx_packet *pkt);
+
 void iwl_mld_handle_scan_complete_notif(struct iwl_mld *mld,
 					struct iwl_rx_packet *pkt);
 
@@ -114,8 +117,8 @@ enum iwl_mld_traffic_load {
  *	in jiffies.
  * @last_start_time_jiffies: stores the last start time in jiffies
  *	(interface up/reset/resume).
- * @last_mlo_scan_time: start time of the last MLO scan in nanoseconds since
- *	boot.
+ * @last_mlo_scan_start_time: start time of the last MLO scan in nanoseconds
+ * since boot.
  */
 struct iwl_mld_scan {
 	/* Add here fields that need clean up on restart */
@@ -136,7 +139,7 @@ struct iwl_mld_scan {
 	void *cmd;
 	unsigned long last_6ghz_passive_jiffies;
 	unsigned long last_start_time_jiffies;
-	u64 last_mlo_scan_time;
+	u64 last_mlo_scan_start_time;
 };
 
 /**
-- 
2.34.1


