Return-Path: <linux-wireless+bounces-25113-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8777AFF2A4
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 22:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 257745C0750
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 20:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B1E25FA2D;
	Wed,  9 Jul 2025 20:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kvMQsXUY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FEC259C82
	for <linux-wireless@vger.kernel.org>; Wed,  9 Jul 2025 20:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752091570; cv=none; b=TtamQbhciucJ0DtLnM7mlJdVvaV2Tl9k5u7sbJDWPaavWmJ7KahycIWnLeEiJcKkkxjmqZ+IaAvn238rmh9VKEtaUdalcL2CXEMtFm8dNepjZU31mcgOfsiZ+SAjj37uGYn0vPDPJ/ZvEqwDRvitLlJKKdFPasfvohPNHOBPGHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752091570; c=relaxed/simple;
	bh=LGwJahXtmCjPsuo8DWxBD1kmgQDWar3h/2BpSAudu0Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h1rjSHLUnpsmjkSJ8Awkk7i0QmgDzUrUskQAz1VShoeWyx7QwV2KVadI8Yz99epy7eMzNOikNtpGYUXGvpHaHRsxiKVstbzNVgeb/bRLbmfKIX/JC3i+XSzSV92eEESkzFAGtoKNkVAyP8jeBNFOdomj3SAq3sTDOh6sO4oSOic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kvMQsXUY; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752091568; x=1783627568;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LGwJahXtmCjPsuo8DWxBD1kmgQDWar3h/2BpSAudu0Y=;
  b=kvMQsXUYZqWGlQv7Wb+4Hj8G2cqzcTLocuMRmwVXmKNwaoWBQlGeeTZA
   D8iObhHsfY8zdQczFnUWfoJAaoDV/yEtWciHO6zP6HVk/vI/7PZ790YD9
   anuqaJPUYLKYg1wIlDAfOJQh5hZdfNZtxglPEqsPQQbgwhUxmYCua1BZZ
   AJWFHGTwBIA9F2PKA5/HqXot9+jqMi3fR6nJJ2wASW/GmmEdul6iU+5rn
   skra6INW+8DHQKhlt2NsQfbOE/boMxcAuwZQlOybu50wiBq4qbiZ1OuMz
   C/C6QLeY19wdBXwuY9E6v9sPmTmgGyi/8r9X8Yj+sbvpaNfeacOS8WMFB
   g==;
X-CSE-ConnectionGUID: +SsduWfAS/isd0oV/8nJjQ==
X-CSE-MsgGUID: MV+BQM0XRQWOK+Le4vyVtA==
X-IronPort-AV: E=McAfee;i="6800,10657,11489"; a="54240303"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="54240303"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 13:06:08 -0700
X-CSE-ConnectionGUID: c1rs5cuIRp6nwRTlS/jL0Q==
X-CSE-MsgGUID: ZTsl55eMS/6ikFCo7scWfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="160126024"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 13:06:07 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 04/15] wifi: iwlwifi: mvm: remove support for iwl_wowlan_info_notif_v2
Date: Wed,  9 Jul 2025 23:05:32 +0300
Message-Id: <20250709230308.d92f63207232.I8961ffbe04d0d9439d48a17840497ac926967914@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250709200543.1628666-1-miriam.rachel.korenblit@intel.com>
References: <20250709200543.1628666-1-miriam.rachel.korenblit@intel.com>
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


