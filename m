Return-Path: <linux-wireless+bounces-25116-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06314AFF2A9
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 22:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35625164CEF
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 20:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 256AE25A2DD;
	Wed,  9 Jul 2025 20:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QVDIIfc2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743F02586EF
	for <linux-wireless@vger.kernel.org>; Wed,  9 Jul 2025 20:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752091574; cv=none; b=Dtd3bhn5sfHVjPVX8au0aw/cGVLdUv2rBDVF927F0xfAPisLUzrwMw4bK0PznGsxl0jRqWxA14357A/ddaUTqnUU0qd52/rT8evxDGSv+LMTL8hukh8AoczvH+XAvG2tgBowgLpyrO48UZ6/R5qSzQnURA6xWDkaVDXHrEy5g+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752091574; c=relaxed/simple;
	bh=PUyWi8ClMcyrkYRR79+xuJKFqKMIZA46Qs1qHpX/Kdw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Fk3mFnJEAY8wgJZjlm7enS0dcRefRZMljIJRxS9rrJhyNmadyQ5xnDdotEhlGA5feoW6bQENiR2/2l4rGpmlzUgY9xwpiS42U3sr6uHkpQaJ9D2kz0HpDP9ujyZw9HO42YLDot36RQR2VcMr2M0brYicb7Rz+WDtP7eUXm1tAC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QVDIIfc2; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752091572; x=1783627572;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PUyWi8ClMcyrkYRR79+xuJKFqKMIZA46Qs1qHpX/Kdw=;
  b=QVDIIfc2C0Sus7p/MmTxTDk9q2aNYbRx/07X18NVKHNyJIIGGvC7rDsZ
   mqcwA6tcAuYzYcRubSCnumUSkwt6d/W/Gb0LMBvSD3zIlmsbu2PN+LDgE
   ucx8YAD4B3WQUvp6HIZDiCtY/bP6lO3bahEKSNnAbUwCzAgi+r0TEti9p
   pHQBHsSAE6rC1qWQb1Jn/3oqUD/D+Yzmnn5VpvswX44yTSoc/tUWuqfL0
   UYOHTT40BIui5loJ9E9RPzrdQC1ywOggIatZ81TOFqIJJRMTkZMbsctv8
   5W2Rdk/jtcBoLftxIUVdgYq6w5RxG9a4YQtDCsSOmoGK40cQA7WzBucg7
   A==;
X-CSE-ConnectionGUID: Grp4N/pwRw6yA3vc99eIlg==
X-CSE-MsgGUID: Rth1/ysBQcWHM0IJ6ZtV/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11489"; a="54240307"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="54240307"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 13:06:12 -0700
X-CSE-ConnectionGUID: gH/v8BMjTGOVBKzkTgQJ0Q==
X-CSE-MsgGUID: Knet6VhhSkW86723shUDvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="160126047"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 13:06:11 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 07/15] wifi: iwlwifi: mvm: remove support for iwl_wowlan_status_v9
Date: Wed,  9 Jul 2025 23:05:35 +0300
Message-Id: <20250709230308.22864efb5074.I51f270f8848970fd2ca1078c14ad31f4a8853e7d@changeid>
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
 .../wireless/intel/iwlwifi/fw/api/commands.h  |  4 +-
 .../net/wireless/intel/iwlwifi/fw/api/d3.h    | 38 -------------------
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   | 16 --------
 3 files changed, 2 insertions(+), 56 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h b/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h
index 3f8f9e3fcba8..997b0c9ce984 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h
@@ -573,8 +573,8 @@ enum iwl_legacy_cmds {
 	WOWLAN_KEK_KCK_MATERIAL = 0xe4,
 
 	/**
-	 * @WOWLAN_GET_STATUSES: response in &struct iwl_wowlan_status_v6,
-	 *	&struct iwl_wowlan_status_v7, &struct iwl_wowlan_status_v9
+	 * @WOWLAN_GET_STATUSES: response in &struct iwl_wowlan_status_v6 or
+	 *	&struct iwl_wowlan_status_v7
 	 */
 	WOWLAN_GET_STATUSES = 0xe5,
 
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h b/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h
index a73b1f63da1c..b16bd8aa136a 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h
@@ -719,44 +719,6 @@ struct iwl_wowlan_status_v7 {
 	u8 wake_packet[]; /* can be truncated from _length to _bufsize */
 } __packed; /* WOWLAN_STATUSES_API_S_VER_7 */
 
-/**
- * struct iwl_wowlan_status_v9 - WoWLAN status (versions 9 and 10)
- * @gtk: GTK data
- * @igtk: IGTK data
- * @replay_ctr: GTK rekey replay counter
- * @pattern_number: number of the matched pattern
- * @non_qos_seq_ctr: non-QoS sequence counter to use next.
- *                   Reserved if the struct has version >= 10.
- * @qos_seq_ctr: QoS sequence counters to use next
- * @wakeup_reasons: wakeup reasons, see &enum iwl_wowlan_wakeup_reason
- * @num_of_gtk_rekeys: number of GTK rekeys
- * @transmitted_ndps: number of transmitted neighbor discovery packets
- * @received_beacons: number of received beacons
- * @wake_packet_length: wakeup packet length
- * @wake_packet_bufsize: wakeup packet buffer size
- * @tid_tear_down: bit mask of tids whose BA sessions were closed
- *		   in suspend state
- * @reserved: unused
- * @wake_packet: wakeup packet
- */
-struct iwl_wowlan_status_v9 {
-	struct iwl_wowlan_gtk_status_v2 gtk[WOWLAN_GTK_KEYS_NUM];
-	struct iwl_wowlan_igtk_status igtk[WOWLAN_IGTK_KEYS_NUM];
-	__le64 replay_ctr;
-	__le16 pattern_number;
-	__le16 non_qos_seq_ctr;
-	__le16 qos_seq_ctr[8];
-	__le32 wakeup_reasons;
-	__le32 num_of_gtk_rekeys;
-	__le32 transmitted_ndps;
-	__le32 received_beacons;
-	__le32 wake_packet_length;
-	__le32 wake_packet_bufsize;
-	u8 tid_tear_down;
-	u8 reserved[3];
-	u8 wake_packet[]; /* can be truncated from _length to _bufsize */
-} __packed; /* WOWLAN_STATUSES_RSP_API_S_VER_9 */
-
 /**
  * struct iwl_wowlan_info_notif_v1 - WoWLAN information notification
  * @gtk: GTK data
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index 36890e9c7a2f..d9d678fbdaab 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -2466,7 +2466,6 @@ iwl_mvm_parse_wowlan_status_common_ ## _ver(struct iwl_mvm *mvm,	\
 
 iwl_mvm_parse_wowlan_status_common(v6)
 iwl_mvm_parse_wowlan_status_common(v7)
-iwl_mvm_parse_wowlan_status_common(v9)
 
 static struct iwl_wowlan_status_data *
 iwl_mvm_send_wowlan_get_status(struct iwl_mvm *mvm, u8 sta_id)
@@ -2543,21 +2542,6 @@ iwl_mvm_send_wowlan_get_status(struct iwl_mvm *mvm, u8 sta_id)
 		iwl_mvm_convert_key_counters(status, &v7->gtk[0].rsc.all_tsc_rsc);
 		iwl_mvm_convert_gtk_v2(status, &v7->gtk[0]);
 		iwl_mvm_convert_igtk(status, &v7->igtk[0]);
-	} else if (notif_ver == 9 || notif_ver == 10 || notif_ver == 11) {
-		struct iwl_wowlan_status_v9 *v9 = (void *)cmd.resp_pkt->data;
-
-		/* these three command versions have same layout and size, the
-		 * difference is only in a few not used (reserved) fields.
-		 */
-		status = iwl_mvm_parse_wowlan_status_common_v9(mvm, v9, len);
-		if (!status)
-			goto out_free_resp;
-
-		iwl_mvm_convert_key_counters(status, &v9->gtk[0].rsc.all_tsc_rsc);
-		iwl_mvm_convert_gtk_v2(status, &v9->gtk[0]);
-		iwl_mvm_convert_igtk(status, &v9->igtk[0]);
-
-		status->tid_tear_down = v9->tid_tear_down;
 	} else {
 		IWL_ERR(mvm,
 			"Firmware advertises unknown WoWLAN status response %d!\n",
-- 
2.34.1


