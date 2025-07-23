Return-Path: <linux-wireless+bounces-25901-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE18B0EAE0
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Jul 2025 08:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E42A5660FF
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Jul 2025 06:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4839826FA7B;
	Wed, 23 Jul 2025 06:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g3JsyT1N"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83475271442
	for <linux-wireless@vger.kernel.org>; Wed, 23 Jul 2025 06:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753253154; cv=none; b=G1/dd37bHoQAgNk6dov/VX+yeAvr+5/0z7g/X5S/5jSxrMC4xYXJPkEd0c2MZkyYAENZRDvPrJ2lPr1Vx5owJv9X5gqRXQ0X+vr4OcI3vDozAVq9QfaZ1gwe7wukPJzdizatk6rIibyfmgWzDB1E2pUZ7h92LEs6r3wwRd3Gwbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753253154; c=relaxed/simple;
	bh=gAZdNU/piJ3/KXY7aD9R5kJmz3mY6BquMveBdg0I9M8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CJvB5/yFQFJZl45x+0B9RdAY9d5A+q0MjO2YeEtf1wsPAumCizdNwahoQCiG1fIums5DArIEhdaDgDs7P03MyB6T0pKblijmMAZqhFf/LLnF9dChlCIa0mzQy4rAjMXqRL6k48nD3Fmx2IvShUE9Ec4WfjgTUHrVyOl93coshII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g3JsyT1N; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753253152; x=1784789152;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gAZdNU/piJ3/KXY7aD9R5kJmz3mY6BquMveBdg0I9M8=;
  b=g3JsyT1NOM/fpXsxzd+myLikWiUZjN9xH7Szx8/+Ut1xa8SqID4ceL0P
   uNex+EQcBhmyoNZ2MBRfKEYqh23l/nZW9gIWh7kEEU7fYAS755+kbemc2
   DzaYKBMjl6Tvi7Sup0X6PoF9q6YnIF/ow6KR6PeA/gEJRuACKLho//ky+
   Qk10KGCcPj1xXecPYKQEHVnx6Xlm4Wac2p9kmQGqTaHbaz5bULqx3ZDeu
   s3AczT5pCU8qHFwQKp/QM0znXo71g+8PJXQixCT2v9M5V617kmQB14dWE
   l9KzH5rYu3zBRwWUAoIYTZVtpJhBrHchJsco6CNPwhJNPO1wx0noWfL/s
   A==;
X-CSE-ConnectionGUID: QnhQ8Q89R/+lFPfXRlHFbw==
X-CSE-MsgGUID: kPh5qfcnRIykoo5HmImBzw==
X-IronPort-AV: E=McAfee;i="6800,10657,11500"; a="59340770"
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="59340770"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 23:45:47 -0700
X-CSE-ConnectionGUID: DWMb8TJYQCGAcWWE/cvFCQ==
X-CSE-MsgGUID: +8picd/6QweGk1/YYbnPww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="159918095"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 23:45:46 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 08/14] wifi: iwlwifi: stop supporting iwl_omi_send_status_notif ver 1
Date: Wed, 23 Jul 2025 09:45:09 +0300
Message-Id: <20250723094230.b716b9cebaa7.I2a1cc4be441dbbb5566a9a3d2d330d956ff3ed38@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250723064515.2084903-1-miriam.rachel.korenblit@intel.com>
References: <20250723064515.2084903-1-miriam.rachel.korenblit@intel.com>
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


