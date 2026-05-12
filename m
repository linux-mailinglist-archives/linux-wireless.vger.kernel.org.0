Return-Path: <linux-wireless+bounces-36293-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QM3tJyO8AmonwAEAu9opvQ
	(envelope-from <linux-wireless+bounces-36293-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 07:35:31 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4173551A27D
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 07:35:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 95052303DADA
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 05:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D017221F20;
	Tue, 12 May 2026 05:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ibP8wZHH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4B1245031
	for <linux-wireless@vger.kernel.org>; Tue, 12 May 2026 05:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778563405; cv=none; b=HfNm1o3udk6vtne+Z5Hv160gLN5odAQzix8Sb+6leo1yQm22WpsowlGhJxI/G9fwyGyIf0zR8Yy4Osq5ZvEJz050gdaHgH7b1oGSxrSK010M9uD0oMtbhOqW7rclYcH5lZf3VhdXGcNMHEFJwp6E4qjTupvTxK4iTU44niVlkyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778563405; c=relaxed/simple;
	bh=2/Lw036NiWGQHqVJjaIwcKSN3UqlsqSRB+w3/KBySSA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QvtUoP+CPQ5nyjJwuxg6Bh71u96+YcEpGQUO0Ft3wSdzGj4m22otlBKxptBTirybNBScyfvKR7FVUnHJGlAQra2OAYwr/nP2yUH/8TIS4ytJgDQqcuKVp41N2POs0UtuPsDTcnEnYQiOdI8Hq3qj4RmNv+XSjZA0i7xiKubWXm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ibP8wZHH; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778563403; x=1810099403;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2/Lw036NiWGQHqVJjaIwcKSN3UqlsqSRB+w3/KBySSA=;
  b=ibP8wZHHPjAstxOD6k50FOG/ogl5UdxWWVjjG3TkNIAlmNxoLDL+Is6n
   jgO5qM1vhN38cxT4O5lkfQpYOoga2osIFf9CUm5L0COdGNvaWEDIHQhxr
   QecZEsXeC4I9aUHPHR0X+fO46BrrnzJiql+KpYUU4IU7UHbBcEpj3vX5U
   QAgT7HgxIcqqlHNGfhE08NPVIjbqfBB60atspHIQeGUQ2X57vP6FY+dCA
   gLJoAmY8aMrpE8yNtRB+aIIYzpAlCC5EmMcyoqMK6KsTbXqQ1XQpuhBf0
   SHjeQq+bhTx6kRgY1DWt1VYkqVsOlEKdspY4r4DY2MPnludthyzOS6Wqm
   g==;
X-CSE-ConnectionGUID: CPkj18UAQw+Ibz3aeaYYFw==
X-CSE-MsgGUID: Olm4BVKzQxaLOMNEKxbokA==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="78495088"
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="78495088"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 22:23:23 -0700
X-CSE-ConnectionGUID: seodbEyQSGeZOEijK2INlg==
X-CSE-MsgGUID: gJ3sMA9nR1i3R3qGAMWiww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="233187488"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 22:23:22 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH iwlwifi-next 02/15] wifi: iwlwifi: rename iwl_system_statistics_notif_oper
Date: Tue, 12 May 2026 08:22:54 +0300
Message-Id: <20260512082114.2c3b55b1cae7.Ic982845bfe08c7c9ea16c267570e3e3856de84b8@changeid>
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
X-Rspamd-Queue-Id: 4173551A27D
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-36293-lists,linux-wireless=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

rename iwl_system_statistics_notif_oper to
iwl_system_statistics_notif_oper_v3 since v4 is on the way.
Same for iwl_stats_ntfy_per_phy, since v2 is on the way.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../wireless/intel/iwlwifi/fw/api/commands.h   |  4 ++--
 .../net/wireless/intel/iwlwifi/fw/api/stats.h  | 18 +++++++++---------
 drivers/net/wireless/intel/iwlwifi/mld/notif.c |  4 ++--
 drivers/net/wireless/intel/iwlwifi/mld/stats.c | 10 +++++-----
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c   |  4 ++--
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c    |  9 +++++----
 6 files changed, 25 insertions(+), 24 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h b/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h
index 36159a769916..dcac0ba8cccf 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h
@@ -2,7 +2,7 @@
 /*
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
- * Copyright (C) 2018-2022, 2024-2025 Intel Corporation
+ * Copyright (C) 2018-2022, 2024-2026 Intel Corporation
  */
 #ifndef __iwl_fw_api_commands_h__
 #define __iwl_fw_api_commands_h__
@@ -653,7 +653,7 @@ enum iwl_system_subcmd_ids {
 enum iwl_statistics_subcmd_ids {
 	/**
 	 * @STATISTICS_OPER_NOTIF: Notification about operational
-	 *	statistics &struct iwl_system_statistics_notif_oper
+	 *	statistics &struct iwl_system_statistics_notif_oper_v3
 	 */
 	STATISTICS_OPER_NOTIF = 0x0,
 
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/stats.h b/drivers/net/wireless/intel/iwlwifi/fw/api/stats.h
index 68983f6a0026..8d734512f4d5 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/stats.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/stats.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2012-2014, 2018, 2020-2021, 2023-2025 Intel Corporation
+ * Copyright (C) 2012-2014, 2018, 2020-2021, 2023-2026 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -557,7 +557,7 @@ struct iwl_stats_ntfy_per_mac {
 
 #define IWL_STATS_MAX_BW_INDEX 5
 /**
- * struct iwl_stats_ntfy_per_phy - per PHY statistics
+ * struct iwl_stats_ntfy_per_phy_v1 - per PHY statistics
  * @channel_load: channel load
  * @channel_load_by_us: device contribution to MCLM
  * @channel_load_not_by_us: other devices' contribution to MCLM
@@ -572,7 +572,7 @@ struct iwl_stats_ntfy_per_mac {
  *	per channel BW. note BACK counted as 1
  * @last_tx_ch_width_indx: last txed frame channel width index
  */
-struct iwl_stats_ntfy_per_phy {
+struct iwl_stats_ntfy_per_phy_v1 {
 	__le32 channel_load;
 	__le32 channel_load_by_us;
 	__le32 channel_load_not_by_us;
@@ -600,17 +600,17 @@ struct iwl_stats_ntfy_per_sta {
 #define IWL_STATS_MAX_PHY_OPERATIONAL 3
 
 /**
- * struct iwl_system_statistics_notif_oper - statistics notification
+ * struct iwl_system_statistics_notif_oper_v3 - statistics notification
  *
  * @time_stamp: time when the notification is sent from firmware
  * @per_link: per link statistics, &struct iwl_stats_ntfy_per_link
- * @per_phy: per phy statistics, &struct iwl_stats_ntfy_per_phy
+ * @per_phy: per phy statistics, &struct iwl_stats_ntfy_per_phy_v1
  * @per_sta: per sta statistics, &struct iwl_stats_ntfy_per_sta
  */
-struct iwl_system_statistics_notif_oper {
+struct iwl_system_statistics_notif_oper_v3 {
 	__le32 time_stamp;
 	struct iwl_stats_ntfy_per_link per_link[IWL_FW_MAX_LINKS];
-	struct iwl_stats_ntfy_per_phy per_phy[IWL_STATS_MAX_PHY_OPERATIONAL];
+	struct iwl_stats_ntfy_per_phy_v1 per_phy[IWL_STATS_MAX_PHY_OPERATIONAL];
 	struct iwl_stats_ntfy_per_sta per_sta[IWL_STATION_COUNT_MAX];
 } __packed; /* STATISTICS_FW_NTFY_OPERATIONAL_API_S_VER_3 */
 
@@ -642,7 +642,7 @@ struct iwl_system_statistics_end_notif {
  * @hdr: general statistics header
  * @flags: bitmap of possible notification structures
  * @per_mac: per mac statistics, &struct iwl_stats_ntfy_per_mac
- * @per_phy: per phy statistics, &struct iwl_stats_ntfy_per_phy
+ * @per_phy: per phy statistics, &struct iwl_stats_ntfy_per_phy_v1
  * @per_sta: per sta statistics, &struct iwl_stats_ntfy_per_sta
  * @rx_time: rx time
  * @tx_time: usec the radio is transmitting.
@@ -653,7 +653,7 @@ struct iwl_statistics_operational_ntfy {
 	struct iwl_statistics_ntfy_hdr hdr;
 	__le32 flags;
 	struct iwl_stats_ntfy_per_mac per_mac[MAC_INDEX_AUX];
-	struct iwl_stats_ntfy_per_phy per_phy[IWL_STATS_MAX_PHY_OPERATIONAL];
+	struct iwl_stats_ntfy_per_phy_v1 per_phy[IWL_STATS_MAX_PHY_OPERATIONAL];
 	struct iwl_stats_ntfy_per_sta per_sta[IWL_STATION_COUNT_MAX];
 	__le64 rx_time;
 	__le64 tx_time;
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/notif.c b/drivers/net/wireless/intel/iwlwifi/mld/notif.c
index 9c88a8579a75..f7aeff61d785 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/notif.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/notif.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2024-2025 Intel Corporation
+ * Copyright (C) 2024-2026 Intel Corporation
  */
 
 #include "mld.h"
@@ -330,7 +330,7 @@ CMD_VERSIONS(probe_resp_data_notif,
 CMD_VERSIONS(datapath_monitor_notif,
 	     CMD_VER_ENTRY(1, iwl_datapath_monitor_notif))
 CMD_VERSIONS(stats_oper_notif,
-	     CMD_VER_ENTRY(3, iwl_system_statistics_notif_oper))
+	     CMD_VER_ENTRY(3, iwl_system_statistics_notif_oper_v3))
 CMD_VERSIONS(stats_oper_part1_notif,
 	     CMD_VER_ENTRY(4, iwl_system_statistics_part1_notif_oper))
 CMD_VERSIONS(bt_coex_notif,
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/stats.c b/drivers/net/wireless/intel/iwlwifi/mld/stats.c
index 54eb0ead78ee..714d66324e9f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/stats.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/stats.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2024-2025 Intel Corporation
+ * Copyright (C) 2024-2026 Intel Corporation
  */
 
 #include "mld.h"
@@ -40,7 +40,7 @@ iwl_mld_fill_stats_from_oper_notif(struct iwl_mld *mld,
 				   struct iwl_rx_packet *pkt,
 				   u8 fw_sta_id, struct station_info *sinfo)
 {
-	const struct iwl_system_statistics_notif_oper *notif =
+	const struct iwl_system_statistics_notif_oper_v3 *notif =
 		(void *)&pkt->data;
 	const struct iwl_stats_ntfy_per_sta *per_sta =
 		&notif->per_sta[fw_sta_id];
@@ -483,7 +483,7 @@ static void iwl_mld_fill_chanctx_stats(struct ieee80211_hw *hw,
 				       void *data)
 {
 	struct iwl_mld_phy *phy = iwl_mld_phy_from_mac80211(ctx);
-	const struct iwl_stats_ntfy_per_phy *per_phy = data;
+	const struct iwl_stats_ntfy_per_phy_v1 *per_phy = data;
 	u32 new_load, old_load;
 
 	if (WARN_ON(phy->fw_id >= IWL_STATS_MAX_PHY_OPERATIONAL))
@@ -512,7 +512,7 @@ static void iwl_mld_fill_chanctx_stats(struct ieee80211_hw *hw,
 
 static void
 iwl_mld_process_per_phy_stats(struct iwl_mld *mld,
-			      const struct iwl_stats_ntfy_per_phy *per_phy)
+			      const struct iwl_stats_ntfy_per_phy_v1 *per_phy)
 {
 	ieee80211_iter_chan_contexts_mtx(mld->hw,
 					 iwl_mld_fill_chanctx_stats,
@@ -523,7 +523,7 @@ iwl_mld_process_per_phy_stats(struct iwl_mld *mld,
 void iwl_mld_handle_stats_oper_notif(struct iwl_mld *mld,
 				     struct iwl_rx_packet *pkt)
 {
-	const struct iwl_system_statistics_notif_oper *stats =
+	const struct iwl_system_statistics_notif_oper_v3 *stats =
 		(void *)&pkt->data;
 	u32 curr_ts_usec = le32_to_cpu(stats->time_stamp);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index ae177477b201..726477336bb4 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2012-2014, 2018-2025 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2026 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -335,7 +335,7 @@ static const struct iwl_rx_handlers iwl_mvm_rx_handlers[] = {
 	RX_HANDLER_GRP(STATISTICS_GROUP, STATISTICS_OPER_NOTIF,
 		       iwl_mvm_handle_rx_system_oper_stats,
 		       RX_HANDLER_ASYNC_LOCKED_WIPHY,
-		       struct iwl_system_statistics_notif_oper),
+		       struct iwl_system_statistics_notif_oper_v3),
 	RX_HANDLER_GRP(STATISTICS_GROUP, STATISTICS_OPER_PART1_NOTIF,
 		       iwl_mvm_handle_rx_system_oper_part1_stats,
 		       RX_HANDLER_ASYNC_LOCKED,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rx.c b/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
index d0c0faae0122..269c4b45de80 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2012-2014, 2018-2025 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2026 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -757,8 +757,9 @@ iwl_mvm_update_tcm_from_stats(struct iwl_mvm *mvm, __le32 *air_time_le,
 	spin_unlock(&mvm->tcm.lock);
 }
 
-static void iwl_mvm_handle_per_phy_stats(struct iwl_mvm *mvm,
-					 struct iwl_stats_ntfy_per_phy *per_phy)
+static void
+iwl_mvm_handle_per_phy_stats(struct iwl_mvm *mvm,
+			     struct iwl_stats_ntfy_per_phy_v1 *per_phy)
 {
 	int i;
 
@@ -937,7 +938,7 @@ void iwl_mvm_handle_rx_system_oper_stats(struct iwl_mvm *mvm,
 {
 	u8 average_energy[IWL_STATION_COUNT_MAX];
 	struct iwl_rx_packet *pkt = rxb_addr(rxb);
-	struct iwl_system_statistics_notif_oper *stats;
+	struct iwl_system_statistics_notif_oper_v3 *stats;
 	int i;
 	u32 notif_ver = iwl_fw_lookup_notif_ver(mvm->fw, STATISTICS_GROUP,
 						STATISTICS_OPER_NOTIF, 0);
-- 
2.34.1


