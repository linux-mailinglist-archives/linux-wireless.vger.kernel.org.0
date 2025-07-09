Return-Path: <linux-wireless+bounces-25042-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C42B8AFDEF6
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 07:02:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 838C81C26C81
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 05:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E3926A08F;
	Wed,  9 Jul 2025 05:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SOOWGVJr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0301E008B
	for <linux-wireless@vger.kernel.org>; Wed,  9 Jul 2025 05:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752037348; cv=none; b=b5HeONIO2Rqde9/+aiyC/TNYx6KLvwy0a/Zlkf6UMUASdQ1TgBzxHAaAfmui/s9K9qYZpSKdmr58AyGS7SqhQ846eF49j2KWo2tAd3/HqNixS+vI3dJlIRlz34DIKsLULQ+3vE881Bz0/5r/A7xGYHpPq+Mjr64p0GfWevjXKAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752037348; c=relaxed/simple;
	bh=LGwJahXtmCjPsuo8DWxBD1kmgQDWar3h/2BpSAudu0Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eJfMfts+I2CeGyfH+iPNfdbbIshN+EV+WguNdb957UYy3KL52NJ8K1qI49BMt925QNQgwgnEXevwZMzrMR5HmA8+qkGrBg8McBjCT/AA2LrgvKtPjNMoUqJNfpIOsSYS3u5fkrHZbNyrIrZRZQg90vdzFH0yVs6/G6v3U20ycKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SOOWGVJr; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752037346; x=1783573346;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LGwJahXtmCjPsuo8DWxBD1kmgQDWar3h/2BpSAudu0Y=;
  b=SOOWGVJr5rRCOzfUz2E5XO7kab25diPzrk31vvEquTMtq+d4Cvod0ssy
   mmFN+eHNvTSltBHUZ2An83MSXw9UaCD8I6DmZzhAPa7FYiVsK8ledol/q
   HUJMBxxlkdV1d8GLmsZqjWwEI4Wwj7WaE801Irogbcnnn6iqrXxC0u2Jr
   x9jZGraJZZcqD/5jLlE2jcCY2uNigZzU130+qzmHSalIr4pu9ZEUGb17k
   P9P5pOm7xsr9J7Odf/8hQLso5A7YmCgnGECHXAStnt91B0W34prL7PH6B
   Zsw3GEPQIZxDPQZNzD5AY+pXL3nnYYsSrkcnD9/WNBri9vSFUNLA8bnUB
   g==;
X-CSE-ConnectionGUID: pU76FlaxQjq5AA1EDgUwBw==
X-CSE-MsgGUID: zphPDNZPSE6SJ3PFDvU1ag==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="53501458"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="53501458"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 22:02:26 -0700
X-CSE-ConnectionGUID: AuArQK+aS7mqfg+7umjNsQ==
X-CSE-MsgGUID: T1CkWJgGQ/qRx1+kB4zpqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="192859232"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 22:02:25 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 04/15] wifi: iwlwifi: mvm: remove support for iwl_wowlan_info_notif_v2
Date: Wed,  9 Jul 2025 08:01:48 +0300
Message-Id: <20250709075928.f93bae29b99f.I8961ffbe04d0d9439d48a17840497ac926967914@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250709050159.854432-1-miriam.rachel.korenblit@intel.com>
References: <20250709050159.854432-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

FWs with this version are no longer supported on any device.

Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/fw/api/d3.h    | 33 -------------------
 .../wireless/intel/iwlwifi/fw/api/offload.h   |  5 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   | 26 +++------------
 3 files changed, 6 insertions(+), 58 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h b/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h
index 99554496300a..3fd1a1b64b07 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h
@@ -832,39 +832,6 @@ struct iwl_wowlan_info_notif_v1 {
 	u8 reserved2[2];
 } __packed; /* WOWLAN_INFO_NTFY_API_S_VER_1 */
 
-/**
- * struct iwl_wowlan_info_notif_v2 - WoWLAN information notification
- * @gtk: GTK data
- * @igtk: IGTK data
- * @replay_ctr: GTK rekey replay counter
- * @pattern_number: number of the matched patterns
- * @reserved1: reserved
- * @qos_seq_ctr: QoS sequence counters to use next
- * @wakeup_reasons: wakeup reasons, see &enum iwl_wowlan_wakeup_reason
- * @num_of_gtk_rekeys: number of GTK rekeys
- * @transmitted_ndps: number of transmitted neighbor discovery packets
- * @received_beacons: number of received beacons
- * @tid_tear_down: bit mask of tids whose BA sessions were closed
- *	in suspend state
- * @station_id: station id
- * @reserved2: reserved
- */
-struct iwl_wowlan_info_notif_v2 {
-	struct iwl_wowlan_gtk_status_v3 gtk[WOWLAN_GTK_KEYS_NUM];
-	struct iwl_wowlan_igtk_status igtk[WOWLAN_IGTK_KEYS_NUM];
-	__le64 replay_ctr;
-	__le16 pattern_number;
-	__le16 reserved1;
-	__le16 qos_seq_ctr[8];
-	__le32 wakeup_reasons;
-	__le32 num_of_gtk_rekeys;
-	__le32 transmitted_ndps;
-	__le32 received_beacons;
-	u8 tid_tear_down;
-	u8 station_id;
-	u8 reserved2[2];
-} __packed; /* WOWLAN_INFO_NTFY_API_S_VER_2 */
-
 /* MAX MLO keys of non-active links that can arrive in the notification */
 #define WOWLAN_MAX_MLO_KEYS 18
 
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/offload.h b/drivers/net/wireless/intel/iwlwifi/fw/api/offload.h
index 9b09b835560b..7d9aa8363f90 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/offload.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/offload.h
@@ -3,7 +3,7 @@
  * Copyright (C) 2012-2014 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
- * Copyright (C) 2021-2024 Intel Corporation
+ * Copyright (C) 2021-2025 Intel Corporation
  */
 #ifndef __iwl_fw_api_offload_h__
 #define __iwl_fw_api_offload_h__
@@ -19,8 +19,7 @@ enum iwl_prot_offload_subcmd_ids {
 
 	/**
 	 * @WOWLAN_INFO_NOTIFICATION: Notification in
-	 * &struct iwl_wowlan_info_notif_v1, &struct iwl_wowlan_info_notif_v2,
-	 * or &struct iwl_wowlan_info_notif
+	 * &struct iwl_wowlan_info_notif_v1, or &struct iwl_wowlan_info_notif
 	 */
 	WOWLAN_INFO_NOTIFICATION = 0xFD,
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index 66749dc38fc5..bc5f70f04d2c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -2380,8 +2380,8 @@ iwl_mvm_parse_wowlan_info_notif_v3(struct iwl_mvm *mvm,
 }
 
 static void
-iwl_mvm_parse_wowlan_info_notif_v2(struct iwl_mvm *mvm,
-				   struct iwl_wowlan_info_notif_v2 *data,
+iwl_mvm_parse_wowlan_info_notif_v1(struct iwl_mvm *mvm,
+				   struct iwl_wowlan_info_notif_v1 *data,
 				   struct iwl_wowlan_status_data *status,
 				   u32 len)
 {
@@ -3097,29 +3097,11 @@ static bool iwl_mvm_wait_d3_notif(struct iwl_notif_wait_data *notif_wait,
 			break;
 		}
 
-		if (wowlan_info_ver < 2) {
+		if (wowlan_info_ver == 1) {
 			struct iwl_wowlan_info_notif_v1 *notif_v1 =
 				(void *)pkt->data;
-			struct iwl_wowlan_info_notif_v2 *notif_v2;
 
-			notif_v2 = kmemdup(notif_v1, sizeof(*notif_v2), GFP_ATOMIC);
-
-			if (!notif_v2)
-				return false;
-
-			notif_v2->tid_tear_down = notif_v1->tid_tear_down;
-			notif_v2->station_id = notif_v1->station_id;
-			memset_after(notif_v2, 0, station_id);
-			iwl_mvm_parse_wowlan_info_notif_v2(mvm, notif_v2,
-							   d3_data->status,
-							   len);
-			kfree(notif_v2);
-
-		} else if (wowlan_info_ver == 2) {
-			struct iwl_wowlan_info_notif_v2 *notif_v2 =
-				(void *)pkt->data;
-
-			iwl_mvm_parse_wowlan_info_notif_v2(mvm, notif_v2,
+			iwl_mvm_parse_wowlan_info_notif_v1(mvm, notif_v1,
 							   d3_data->status,
 							   len);
 		} else if (wowlan_info_ver == 3) {
-- 
2.34.1


