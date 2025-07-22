Return-Path: <linux-wireless+bounces-25825-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42738B0D4A5
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 10:30:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B82CF1AA2A3E
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 08:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94AD92D660B;
	Tue, 22 Jul 2025 08:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dnaUZbE3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADD92D836F
	for <linux-wireless@vger.kernel.org>; Tue, 22 Jul 2025 08:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753172986; cv=none; b=ql61Io7ghBxAc2gfGOBrfDlKL5NqX9eY7+7rIK8pOcaR7wy4HKKPk+4JUv+8vGbuWzF0EV9jGcS7KdMoqQOhZ2lgJ9L/yyn3FA2TezmU9nYg23YB4Omus+BcgWk5jGwjUHIv8CxD+Vm0K6VmE80Zk4cX+JMV3HdwaupdokQKsi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753172986; c=relaxed/simple;
	bh=gAZdNU/piJ3/KXY7aD9R5kJmz3mY6BquMveBdg0I9M8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r8NMIRNbC6hPwlo65rytC94/WJwuHHntDsEKn6e9aPvW8lSmraFrV/BpMnBSx5CvszZ6kFYYXHRNVDcfPi60q1NxEUtXpNL1VR1CZghZO+ZludQfPdhe/f6i/SQVvTmwqszhc3TgByurN9DqOHZe0k4huU0PZYIGl52dBzgw/6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dnaUZbE3; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753172986; x=1784708986;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gAZdNU/piJ3/KXY7aD9R5kJmz3mY6BquMveBdg0I9M8=;
  b=dnaUZbE3TVPB4bjat9VFzYubDMvP6QxL8xYWxePHAM2WPpzyZ3Gk2xY1
   HrukrcF9ArQmrcYou80TU3VaFm4i1+wvL2bV05Dg+Cz7JjmdDPBsxyva3
   cfs0E4DgZiT2gRCvSl1MXvWI10mAETETQSsZk6jUoQ6efDp12N2VOLEKR
   UJuSSSS6OoNXjBgAKB1CxrFRys9t2IQhblxEoN01uI8CTInD36nJ5BLFB
   1cBaYnVfebDySPqfCyESWte4J8ifCJKS2rHJ40JQwZHTvltIKDBo6Uhqt
   WLud73p4pclhI6iLlSj3Ox0345Z+kDiPkWo8YsT34oiYMtI/qW649lAZf
   g==;
X-CSE-ConnectionGUID: e5aYma3aQoWrF9RM+PXUug==
X-CSE-MsgGUID: mxlkg/V1TDqBbAt1LFvOew==
X-IronPort-AV: E=McAfee;i="6800,10657,11499"; a="55569916"
X-IronPort-AV: E=Sophos;i="6.16,331,1744095600"; 
   d="scan'208";a="55569916"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 01:29:45 -0700
X-CSE-ConnectionGUID: QChe6NRARHGCIYNd7YGKug==
X-CSE-MsgGUID: SHgkgCF0S0yQ3vrNrpt6jA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,331,1744095600"; 
   d="scan'208";a="163124295"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 01:29:43 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 10/15] wifi: iwlwifi: stop supporting iwl_omi_send_status_notif ver 1
Date: Tue, 22 Jul 2025 11:29:05 +0300
Message-Id: <20250722112718.a4f8cd7ad7b3.I2a1cc4be441dbbb5566a9a3d2d330d956ff3ed38@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250722082910.1206370-1-miriam.rachel.korenblit@intel.com>
References: <20250722082910.1206370-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

This version doesn't provide the sta id, so we need to look it up -
assuming that no other sta exists, since one of the conditions of
entering OMI is not having P2P/TDLS.

But when we leave OMI, because of the P2P/TDLS activation, the P2P/TDLS
sta can already exist while we receive the notification from the FW.
This causes an error log which is incorrect.

Since OMI is only supported in SC, which is not shipped yet, no one will
use a FW with the old version.
Remove support for it.

Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../wireless/intel/iwlwifi/fw/api/datapath.h  |  9 -----
 drivers/net/wireless/intel/iwlwifi/mld/link.c | 40 +++++++------------
 .../net/wireless/intel/iwlwifi/mld/notif.c    |  1 -
 3 files changed, 14 insertions(+), 36 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/datapath.h b/drivers/net/wireless/intel/iwlwifi/fw/api/datapath.h
index ee822a87c42c..083136a0c456 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/datapath.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/datapath.h
@@ -699,15 +699,6 @@ struct iwl_sec_key_cmd {
 	} __packed u; /* SEC_KEY_OPERATION_API_U_VER_1 */
 } __packed; /* SEC_KEY_CMD_API_S_VER_1 */
 
-/**
- * struct iwl_omi_send_status_notif_v1 - OMI status notification
- * @success: indicates that the OMI was sent successfully
- *	(currently always set)
- */
-struct iwl_omi_send_status_notif_v1 {
-	__le32 success;
-} __packed; /* OMI_SEND_STATUS_NTFY_API_S_VER_1 */
-
 /**
  * struct iwl_omi_send_status_notif - OMI status notification
  * @success: indicates that the OMI was sent successfully
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/link.c b/drivers/net/wireless/intel/iwlwifi/mld/link.c
index c48cc3909637..9797510cab3f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/link.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/link.c
@@ -649,40 +649,28 @@ void iwl_mld_omi_ap_changed_bw(struct iwl_mld *mld,
 void iwl_mld_handle_omi_status_notif(struct iwl_mld *mld,
 				     struct iwl_rx_packet *pkt)
 {
-	int ver = iwl_fw_lookup_notif_ver(mld->fw, DATA_PATH_GROUP,
-					  OMI_SEND_STATUS_NOTIF, 1);
+	const struct iwl_omi_send_status_notif *notif = (const void *)pkt->data;
 	struct ieee80211_link_sta *link_sta;
 	struct iwl_mld_link *mld_link;
+	struct iwl_mld_vif *mld_vif;
 	struct ieee80211_vif *vif;
+	u32 sta_id;
 
-	if (ver == 2) {
-		const struct iwl_omi_send_status_notif *notif =
-			(const void *)pkt->data;
-		u32 sta_id = le32_to_cpu(notif->sta_id);
-		struct iwl_mld_vif *mld_vif;
+	sta_id = le32_to_cpu(notif->sta_id);
 
-		if (IWL_FW_CHECK(mld, sta_id >= mld->fw->ucode_capa.num_stations,
-				 "Invalid station %d\n", sta_id))
-			return;
+	if (IWL_FW_CHECK(mld, sta_id >= mld->fw->ucode_capa.num_stations,
+			 "Invalid station %d\n", sta_id))
+		return;
 
-		link_sta = wiphy_dereference(mld->wiphy,
-					     mld->fw_id_to_link_sta[sta_id]);
-		if (IWL_FW_CHECK(mld, !link_sta, "Station does not exist\n"))
-			return;
+	link_sta = wiphy_dereference(mld->wiphy, mld->fw_id_to_link_sta[sta_id]);
+	if (IWL_FW_CHECK(mld, !link_sta, "Station does not exist\n"))
+		return;
 
-		vif = iwl_mld_sta_from_mac80211(link_sta->sta)->vif;
-		mld_vif = iwl_mld_vif_from_mac80211(vif);
+	vif = iwl_mld_sta_from_mac80211(link_sta->sta)->vif;
+	mld_vif = iwl_mld_vif_from_mac80211(vif);
 
-		mld_link = iwl_mld_link_dereference_check(mld_vif,
-							  link_sta->link_id);
-		if (WARN(!mld_link, "Link %d does not exist\n",
-			 link_sta->link_id))
-			return;
-	} else {
-		vif = iwl_mld_get_omi_bw_reduction_pointers(mld, &link_sta,
-							    &mld_link);
-	}
-	if (IWL_FW_CHECK(mld, !vif, "unexpected OMI notification\n"))
+	mld_link = iwl_mld_link_dereference_check(mld_vif, link_sta->link_id);
+	if (WARN(!mld_link, "Link %d does not exist\n", link_sta->link_id))
 		return;
 
 	if (IWL_FW_CHECK(mld, !mld_link->rx_omi.bw_in_progress,
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/notif.c b/drivers/net/wireless/intel/iwlwifi/mld/notif.c
index 3cb700a9708e..e8f10e8145f9 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/notif.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/notif.c
@@ -351,7 +351,6 @@ CMD_VERSIONS(time_msmt_notif,
 CMD_VERSIONS(time_sync_confirm_notif,
 	     CMD_VER_ENTRY(1, iwl_time_msmt_cfm_notify))
 CMD_VERSIONS(omi_status_notif,
-	     CMD_VER_ENTRY(1, iwl_omi_send_status_notif_v1)
 	     CMD_VER_ENTRY(2, iwl_omi_send_status_notif))
 CMD_VERSIONS(ftm_resp_notif, CMD_VER_ENTRY(10, iwl_tof_range_rsp_ntfy))
 CMD_VERSIONS(beacon_filter_notif, CMD_VER_ENTRY(2, iwl_beacon_filter_notif))
-- 
2.34.1


