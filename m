Return-Path: <linux-wireless+bounces-25284-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D720B02089
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Jul 2025 17:35:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E7064A8299
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Jul 2025 15:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 156532EE260;
	Fri, 11 Jul 2025 15:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q4Iif7Ug"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3BF2ED879
	for <linux-wireless@vger.kernel.org>; Fri, 11 Jul 2025 15:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752248103; cv=none; b=fVupMIGLxlCBByEqm5p47nVWYQAJhxpvUJ0cJia3GNeTEowx0yTOj827ZKr2tazvlgI79tzVzrjV9r6P/V9IEfgluF/0nAdWe/4S6/PM3uq4D0qfh3esv39Y4OtSbiRdNP3PRKcXFfwsVLjhQFp3MexQDZWiJHpDt/PQml6m4FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752248103; c=relaxed/simple;
	bh=Sxwll7ZLGlo8cvCJyhWbMRIlTh4Pv2cQqe1Ac5n6HEE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VWMWirxNdRXCepiaKtxQM7SaALPnRud80qm8d2bBC0iY6j/8BJkdpm8nQ2HZaH6qdtjZIi9dLP+bamfoivB5tJPN/mzKk9Xn8bZ8CCJfuEzGJ7iso0FIRblKmvEoicwzZJRI1ni3reFoizusoBzsOIbcaaGGNP54rG9hTyHLJsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q4Iif7Ug; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752248102; x=1783784102;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Sxwll7ZLGlo8cvCJyhWbMRIlTh4Pv2cQqe1Ac5n6HEE=;
  b=Q4Iif7UgwKQVR4+3BKzTHne2DtK3YPKUNaqtHu1NktBI3muLQjejeq9P
   qH0tuRMs/nePm8/c28eujbx+m15mV31YVnaSaIFc4d11R0w3FzlK8kRRT
   6rkFH4HSFnK2pjPh87V5IGtVmwx30qTbZ/nmUpkmrLD+1c6dKXc9XAak1
   Ra6IPr1V0h8x2lx6EmGnJbRKR3p7iad7H0gV2gVthS2ZSy5l/UB6FBgTY
   0BQU3Y7C/wi6cg+eu0afCKi40jXN+peKq/3s+vNEo67jCcQ3GzyuOBLHR
   /wZXeRouw+KdWai5ZK7nRildX8lahfDeAD7hUTGDo2rHxgpZWUwFNKQEJ
   w==;
X-CSE-ConnectionGUID: tW72M7vVTyaG5o93LMUcUw==
X-CSE-MsgGUID: 1EOqxtSDQOaYnGfp91oazw==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="54264165"
X-IronPort-AV: E=Sophos;i="6.16,304,1744095600"; 
   d="scan'208";a="54264165"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 08:35:02 -0700
X-CSE-ConnectionGUID: vMe1QkIhTUy77LSipJ8+dQ==
X-CSE-MsgGUID: annJq6MJTOO6PyxQfqgNLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,304,1744095600"; 
   d="scan'208";a="156485134"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 08:35:00 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH iwlwifi-next 09/15] wifi: iwlwifi: mld: support iwl_omi_send_status_notif version 2
Date: Fri, 11 Jul 2025 18:34:23 +0300
Message-Id: <20250711183056.7d2cd878855f.I8625ebb2c4e1fb484aafd16a07549f2eeb506e08@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250711153429.3417098-1-miriam.rachel.korenblit@intel.com>
References: <20250711153429.3417098-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

The firmware provides the station id, use it since it makes our lives
easier. No need to assume we have a single BSS vif, and look up the
station id to whom the OMI was sent.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../wireless/intel/iwlwifi/fw/api/datapath.h  | 13 +++++++-
 drivers/net/wireless/intel/iwlwifi/mld/link.c | 30 ++++++++++++++++++-
 .../net/wireless/intel/iwlwifi/mld/notif.c    |  3 +-
 3 files changed, 43 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/datapath.h b/drivers/net/wireless/intel/iwlwifi/fw/api/datapath.h
index 6c8e6874a5e7..ee822a87c42c 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/datapath.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/datapath.h
@@ -699,13 +699,24 @@ struct iwl_sec_key_cmd {
 	} __packed u; /* SEC_KEY_OPERATION_API_U_VER_1 */
 } __packed; /* SEC_KEY_CMD_API_S_VER_1 */
 
+/**
+ * struct iwl_omi_send_status_notif_v1 - OMI status notification
+ * @success: indicates that the OMI was sent successfully
+ *	(currently always set)
+ */
+struct iwl_omi_send_status_notif_v1 {
+	__le32 success;
+} __packed; /* OMI_SEND_STATUS_NTFY_API_S_VER_1 */
+
 /**
  * struct iwl_omi_send_status_notif - OMI status notification
  * @success: indicates that the OMI was sent successfully
  *	(currently always set)
+ * @sta_id: sta_id to which the OMI was sent
  */
 struct iwl_omi_send_status_notif {
 	__le32 success;
-} __packed; /* OMI_SEND_STATUS_NTFY_API_S_VER_1 */
+	__le32 sta_id;
+} __packed; /* OMI_SEND_STATUS_NTFY_API_S_VER_2 */
 
 #endif /* __iwl_fw_api_datapath_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/link.c b/drivers/net/wireless/intel/iwlwifi/mld/link.c
index ff237f78a468..c48cc3909637 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/link.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/link.c
@@ -649,11 +649,39 @@ void iwl_mld_omi_ap_changed_bw(struct iwl_mld *mld,
 void iwl_mld_handle_omi_status_notif(struct iwl_mld *mld,
 				     struct iwl_rx_packet *pkt)
 {
+	int ver = iwl_fw_lookup_notif_ver(mld->fw, DATA_PATH_GROUP,
+					  OMI_SEND_STATUS_NOTIF, 1);
 	struct ieee80211_link_sta *link_sta;
 	struct iwl_mld_link *mld_link;
 	struct ieee80211_vif *vif;
 
-	vif = iwl_mld_get_omi_bw_reduction_pointers(mld, &link_sta, &mld_link);
+	if (ver == 2) {
+		const struct iwl_omi_send_status_notif *notif =
+			(const void *)pkt->data;
+		u32 sta_id = le32_to_cpu(notif->sta_id);
+		struct iwl_mld_vif *mld_vif;
+
+		if (IWL_FW_CHECK(mld, sta_id >= mld->fw->ucode_capa.num_stations,
+				 "Invalid station %d\n", sta_id))
+			return;
+
+		link_sta = wiphy_dereference(mld->wiphy,
+					     mld->fw_id_to_link_sta[sta_id]);
+		if (IWL_FW_CHECK(mld, !link_sta, "Station does not exist\n"))
+			return;
+
+		vif = iwl_mld_sta_from_mac80211(link_sta->sta)->vif;
+		mld_vif = iwl_mld_vif_from_mac80211(vif);
+
+		mld_link = iwl_mld_link_dereference_check(mld_vif,
+							  link_sta->link_id);
+		if (WARN(!mld_link, "Link %d does not exist\n",
+			 link_sta->link_id))
+			return;
+	} else {
+		vif = iwl_mld_get_omi_bw_reduction_pointers(mld, &link_sta,
+							    &mld_link);
+	}
 	if (IWL_FW_CHECK(mld, !vif, "unexpected OMI notification\n"))
 		return;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/notif.c b/drivers/net/wireless/intel/iwlwifi/mld/notif.c
index 4bfed90c30c5..262d8e25e62a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/notif.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/notif.c
@@ -349,7 +349,8 @@ CMD_VERSIONS(time_msmt_notif,
 CMD_VERSIONS(time_sync_confirm_notif,
 	     CMD_VER_ENTRY(1, iwl_time_msmt_cfm_notify))
 CMD_VERSIONS(omi_status_notif,
-	     CMD_VER_ENTRY(1, iwl_omi_send_status_notif))
+	     CMD_VER_ENTRY(1, iwl_omi_send_status_notif_v1)
+	     CMD_VER_ENTRY(2, iwl_omi_send_status_notif))
 CMD_VERSIONS(ftm_resp_notif, CMD_VER_ENTRY(10, iwl_tof_range_rsp_ntfy))
 CMD_VERSIONS(beacon_filter_notif, CMD_VER_ENTRY(2, iwl_beacon_filter_notif))
 
-- 
2.34.1


