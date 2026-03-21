Return-Path: <linux-wireless+bounces-33635-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UKg7K9jVvmlwewMAu9opvQ
	(envelope-from <linux-wireless+bounces-33635-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Mar 2026 18:31:04 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CB0862E68C7
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Mar 2026 18:31:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 043D4302A6F4
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Mar 2026 17:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7C1317171;
	Sat, 21 Mar 2026 17:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ekahqUft"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC97633B6DA
	for <linux-wireless@vger.kernel.org>; Sat, 21 Mar 2026 17:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774114185; cv=none; b=RYtrHtSSJsyAzjz+K7IdjMzJ3itxE9aF47lgcx/S7q/VnAjUqX5bCtOUnW7q3AvUt9QUsRmf7EuXdp0f6waisetmhQwL5DA3PTJ/Wz4q+nPMMDzjyT+HFB4VttSQ74clcFyeyKLvFduUiz3qsIDGhn0sSvQCFTUJYjOCJabsQto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774114185; c=relaxed/simple;
	bh=gw+jspMtIBuOAflH5De7b85Vt4ulyxxPL2IrxxWBk54=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ILw5sYLQTeBapMaPvqFPa9vD7k9Dx522ouXz8NOPwgGhyg2rs1W1oPkEkiamxwPyQ+g4omwtIyMScZFc8ZS0ab4K5THoYT2SCfq3B1ZM6TtyAX2QLkZ0LAaAQr1k56mW2UUVnxLIKeqw8E7h4eLMqwO8xn8cfI/yArUtdeYnHNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ekahqUft; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774114184; x=1805650184;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=gw+jspMtIBuOAflH5De7b85Vt4ulyxxPL2IrxxWBk54=;
  b=ekahqUft13lF7B9DY5GlFYSiRoazwHJjWcMCjJqQP4iXwb77u7Rr14M+
   A9VH7LZ3gO4SAPTIr6jcirVXHT5GCRGcVKgLIOlnHtmgm8S3QPSiQLoC1
   ePHAu16C5vDzFGU4EOMUBUxbQCPQr8uwJjWZnqhfaRbvcuB4/4vstBMo+
   sc5WZjBiXwo6uKdaMTujOumX2mHNZzoRGs/klilZm/ZKHErfNPLnzFEY5
   5cEBfoQ9HhneDo6qN+rezXbpZ6ENtG1dAbAovFRjsMJFAfEzrbaQucHj6
   6XET9dar2nr9udf6wn3Y6EOrVz5H4PZK4iuCyJcWdp3Vek49t3SensKs4
   g==;
X-CSE-ConnectionGUID: 7siSIS2jR9SLwfQxuNNvuA==
X-CSE-MsgGUID: lHquNjQmSISAOPtmg5rkzw==
X-IronPort-AV: E=McAfee;i="6800,10657,11736"; a="75244592"
X-IronPort-AV: E=Sophos;i="6.23,133,1770624000"; 
   d="scan'208";a="75244592"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2026 10:29:43 -0700
X-CSE-ConnectionGUID: CyFQKLFERROj7t+7MAwbRQ==
X-CSE-MsgGUID: R9iBz8xSTw6hboLymgFLTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,133,1770624000"; 
   d="scan'208";a="223813593"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2026 10:29:43 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH iwlwifi-next 08/15] wifi: iwlwifi: add a macro for max FW links
Date: Sat, 21 Mar 2026 19:29:15 +0200
Message-Id: <20260321192637.8da9f991526f.I72709f1db90036265c98c5d45682bcf5f36be7ba@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260321172922.3938740-1-miriam.rachel.korenblit@intel.com>
References: <20260321172922.3938740-1-miriam.rachel.korenblit@intel.com>
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
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33635-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_ONE(0.00)[1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:email]
X-Rspamd-Queue-Id: CB0862E68C7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Currently we use IWL_FW_MAX_LINK_ID + 1 to indicate the maximum number
of link that the fw supports. This is a bit confusing.
Add a macro that indicates the number if maximum links that the FW
supports and use it instead.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h  | 1 +
 drivers/net/wireless/intel/iwlwifi/fw/api/stats.h    | 5 ++---
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c         | 2 +-
 drivers/net/wireless/intel/iwlwifi/mld/mld.h         | 2 +-
 drivers/net/wireless/intel/iwlwifi/mld/sta.c         | 2 +-
 drivers/net/wireless/intel/iwlwifi/mld/sta.h         | 2 +-
 drivers/net/wireless/intel/iwlwifi/mld/tests/utils.c | 2 +-
 7 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h b/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
index 180eb8227582..25c57753ff34 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
@@ -709,6 +709,7 @@ struct iwl_link_config_cmd {
  */
 #define IWL_FW_MAX_ACTIVE_LINKS_NUM 2
 #define IWL_FW_MAX_LINK_ID 3
+#define IWL_FW_MAX_LINKS IWL_FW_MAX_LINK_ID + 1
 
 /**
  * enum iwl_fw_sta_type - FW station types
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/stats.h b/drivers/net/wireless/intel/iwlwifi/fw/api/stats.h
index 8d9a5058d5a5..68983f6a0026 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/stats.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/stats.h
@@ -598,7 +598,6 @@ struct iwl_stats_ntfy_per_sta {
 } __packed; /* STATISTICS_NTFY_PER_STA_API_S_VER_1 */
 
 #define IWL_STATS_MAX_PHY_OPERATIONAL 3
-#define IWL_STATS_MAX_FW_LINKS	(IWL_FW_MAX_LINK_ID + 1)
 
 /**
  * struct iwl_system_statistics_notif_oper - statistics notification
@@ -610,7 +609,7 @@ struct iwl_stats_ntfy_per_sta {
  */
 struct iwl_system_statistics_notif_oper {
 	__le32 time_stamp;
-	struct iwl_stats_ntfy_per_link per_link[IWL_STATS_MAX_FW_LINKS];
+	struct iwl_stats_ntfy_per_link per_link[IWL_FW_MAX_LINKS];
 	struct iwl_stats_ntfy_per_phy per_phy[IWL_STATS_MAX_PHY_OPERATIONAL];
 	struct iwl_stats_ntfy_per_sta per_sta[IWL_STATION_COUNT_MAX];
 } __packed; /* STATISTICS_FW_NTFY_OPERATIONAL_API_S_VER_3 */
@@ -624,7 +623,7 @@ struct iwl_system_statistics_notif_oper {
  */
 struct iwl_system_statistics_part1_notif_oper {
 	__le32 time_stamp;
-	struct iwl_stats_ntfy_part1_per_link per_link[IWL_STATS_MAX_FW_LINKS];
+	struct iwl_stats_ntfy_part1_per_link per_link[IWL_FW_MAX_LINKS];
 	__le32 per_phy_crc_error_stats[IWL_STATS_MAX_PHY_OPERATIONAL];
 } __packed; /* STATISTICS_FW_NTFY_OPERATIONAL_PART1_API_S_VER_4 */
 
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
index 4cdd0fe1b788..d5ded4d3a30b 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
@@ -1315,7 +1315,7 @@ static int iwl_parse_tlv_firmware(struct iwl_drv *drv,
 			if (tlv_len != sizeof(u32))
 				goto invalid_tlv_len;
 			if (le32_to_cpup((const __le32 *)tlv_data) >
-			    IWL_FW_MAX_LINK_ID + 1) {
+			    IWL_FW_MAX_LINKS) {
 				IWL_ERR(drv,
 					"%d is an invalid number of links\n",
 					le32_to_cpup((const __le32 *)tlv_data));
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mld.h b/drivers/net/wireless/intel/iwlwifi/mld/mld.h
index ea3d1fab6f46..606cb64f8ea4 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mld.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mld.h
@@ -205,7 +205,7 @@
 struct iwl_mld {
 	/* Add here fields that need clean up on restart */
 	struct_group(zeroed_on_hw_restart,
-		struct ieee80211_bss_conf __rcu *fw_id_to_bss_conf[IWL_FW_MAX_LINK_ID + 1];
+		struct ieee80211_bss_conf __rcu *fw_id_to_bss_conf[IWL_FW_MAX_LINKS];
 		struct ieee80211_vif __rcu *fw_id_to_vif[NUM_MAC_INDEX_DRIVER];
 		struct ieee80211_txq __rcu *fw_id_to_txq[IWL_MAX_TVQM_QUEUES];
 		u8 used_phy_ids: NUM_PHY_CTX;
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/sta.c b/drivers/net/wireless/intel/iwlwifi/mld/sta.c
index eda2cbbb3b30..4c97d12ce2d0 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/sta.c
@@ -938,7 +938,7 @@ static void iwl_mld_count_mpdu(struct ieee80211_link_sta *link_sta, int queue,
 	if (!(mld_vif->emlsr.blocked_reasons & IWL_MLD_EMLSR_BLOCKED_TPT))
 		goto unlock;
 
-	for (int i = 0; i <= IWL_FW_MAX_LINK_ID; i++)
+	for (int i = 0; i < IWL_FW_MAX_LINKS; i++)
 		total_mpdus += tx ? queue_counter->per_link[i].tx :
 				    queue_counter->per_link[i].rx;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/sta.h b/drivers/net/wireless/intel/iwlwifi/mld/sta.h
index 5f6c440bf058..36288c2fb38c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/sta.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/sta.h
@@ -89,7 +89,7 @@ struct iwl_mld_per_link_mpdu_counter {
  */
 struct iwl_mld_per_q_mpdu_counter {
 	spinlock_t lock;
-	struct iwl_mld_per_link_mpdu_counter per_link[IWL_FW_MAX_LINK_ID + 1];
+	struct iwl_mld_per_link_mpdu_counter per_link[IWL_FW_MAX_LINKS];
 	unsigned long window_start_time;
 } ____cacheline_aligned_in_smp;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/tests/utils.c b/drivers/net/wireless/intel/iwlwifi/mld/tests/utils.c
index 176dbbf4c643..dce747270167 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/tests/utils.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/tests/utils.c
@@ -42,7 +42,7 @@ int iwlmld_kunit_test_init(struct kunit *test)
 	iwl_construct_mld(mld, trans, cfg, fw, hw, NULL);
 
 	fw->ucode_capa.num_stations = IWL_STATION_COUNT_MAX;
-	fw->ucode_capa.num_links = IWL_FW_MAX_LINK_ID + 1;
+	fw->ucode_capa.num_links = IWL_FW_MAX_LINKS;
 
 	mld->fwrt.trans = trans;
 	mld->fwrt.fw = fw;
-- 
2.34.1


