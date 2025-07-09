Return-Path: <linux-wireless+bounces-25035-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58952AFDE8C
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 05:46:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA7601C24946
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 03:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C634521ABD5;
	Wed,  9 Jul 2025 03:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LGAZOAxr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C0521CC71
	for <linux-wireless@vger.kernel.org>; Wed,  9 Jul 2025 03:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752032657; cv=none; b=piOU1bBHwOIIypXCw6CPF7Z3x7yMAsIrOKEPLQB5xU93wQzQtT8ssv1o9hu8bTYfCcFfcd743kj1x1XzGJM7H0THXXIyKzWKhkkgHB2wUXIYj8Z328npb/a+BzF9byOjCL+gT0B91iw/LOA29Nm85pcAkVNd2B6X+onDMlE6kC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752032657; c=relaxed/simple;
	bh=c+4KpCoF/sVcc19/O0BP2e2MCGNmlfj3Ck7wYvp7xUQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KVFojRXlymi4TXpnQPfvwblUmN6ShO3x69gsP7Rkp/TNTN3o4PrTsxOdH4SXaJm3o6qNp6PLLOPyunMyzzKip3olpPHXYsWmyyS81Ks+69L1jo7J3hdMJ0M5PKnGDRsDlwQtm4DiFvkgWdp07fgddwbKjXYZ6tGzwBu3MMYwScI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LGAZOAxr; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752032656; x=1783568656;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=c+4KpCoF/sVcc19/O0BP2e2MCGNmlfj3Ck7wYvp7xUQ=;
  b=LGAZOAxroYP1iw6tvwHMQWdAutSNUW9Jue+pFFvXVakKNbjtqS36wbXI
   8ONmRv7P9PKswNultWOcXTuRuoilUiXRPnBYQZTG5efh5r+yO1VdMguE0
   6ypf9aeWTNU/ONrnAbGA798lqKway4I9pOt2pcU8Ht3ww88BNYiHEUM7l
   vH+FS918ZWb7vfoY+4kxwus+G9p2EfwxNDjEGcB9PaMb0GCVkgzTcZqmf
   xBY3/EuX/O8xLC9bWDzYaWIQ+LDjI9cXmSyC1ndiR3hD1UwzML0cEwYhT
   6wlC2UH5X/WbWNe/tGiGXWVUA1QAjFQRnGBmUy3cwwQjuAga/Z98SwHRs
   Q==;
X-CSE-ConnectionGUID: zN3PBSKpR6KY40CxoVvUCg==
X-CSE-MsgGUID: 9TYFfPHRRuiVpYOslpYfrQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="79720675"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="79720675"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 20:44:16 -0700
X-CSE-ConnectionGUID: +IN6R6fvQHuRgC4K/73gQg==
X-CSE-MsgGUID: rpOZCUiNS9OktQfZU6K+JA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="156390579"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 20:44:15 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next v2 15/15] wifi: iwlwifi: mvm: remove support foriwl_wowlan_info_notif_v4
Date: Wed,  9 Jul 2025 06:43:39 +0300
Message-Id: <20250709063858.df8eed63a95c.I488d69251aed62f0b11a2553f972a1730bc8b6cf@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250709034339.794677-1-miriam.rachel.korenblit@intel.com>
References: <20250709034339.794677-1-miriam.rachel.korenblit@intel.com>
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
 .../net/wireless/intel/iwlwifi/fw/api/d3.h    | 13 ++++--------
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   | 21 ++++++++++---------
 2 files changed, 15 insertions(+), 19 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h b/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h
index 9ce819503aed..99554496300a 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h
@@ -912,7 +912,7 @@ struct iwl_wowlan_mlo_gtk {
 } __packed; /* WOWLAN_MLO_GTK_KEY_API_S_VER_1 */
 
 /**
- * struct iwl_wowlan_info_notif_v4 - WoWLAN information notification
+ * struct iwl_wowlan_info_notif_v3 - WoWLAN information notification
  * @gtk: GTK data
  * @igtk: IGTK data
  * @bigtk: BIGTK data
@@ -927,12 +927,9 @@ struct iwl_wowlan_mlo_gtk {
  * @tid_tear_down: bit mask of tids whose BA sessions were closed
  *	in suspend state
  * @station_id: station id
- * @num_mlo_link_keys: number of &struct iwl_wowlan_mlo_gtk structs
- *	following this notif, or reserved in version < 4
  * @reserved2: reserved
- * @mlo_gtks: array of GTKs of size num_mlo_link_keys for version >= 4
  */
-struct iwl_wowlan_info_notif_v4 {
+struct iwl_wowlan_info_notif_v3 {
 	struct iwl_wowlan_gtk_status_v3 gtk[WOWLAN_GTK_KEYS_NUM];
 	struct iwl_wowlan_igtk_status igtk[WOWLAN_IGTK_KEYS_NUM];
 	struct iwl_wowlan_igtk_status bigtk[WOWLAN_BIGTK_KEYS_NUM];
@@ -946,10 +943,8 @@ struct iwl_wowlan_info_notif_v4 {
 	__le32 received_beacons;
 	u8 tid_tear_down;
 	u8 station_id;
-	u8 num_mlo_link_keys;
-	u8 reserved2;
-	struct iwl_wowlan_mlo_gtk mlo_gtks[];
-} __packed; /* WOWLAN_INFO_NTFY_API_S_VER_3, _VER_4 */
+	u8 reserved2[2];
+} __packed; /* WOWLAN_INFO_NTFY_API_S_VER_3 */
 
 /**
  * struct iwl_wowlan_info_notif - WoWLAN information notification
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index 7f0b2089ab8e..66749dc38fc5 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -2347,17 +2347,13 @@ static void iwl_mvm_parse_wowlan_info_notif(struct iwl_mvm *mvm,
 }
 
 static void
-iwl_mvm_parse_wowlan_info_notif_v4(struct iwl_mvm *mvm,
-				   struct iwl_wowlan_info_notif_v4 *data,
+iwl_mvm_parse_wowlan_info_notif_v3(struct iwl_mvm *mvm,
+				   struct iwl_wowlan_info_notif_v3 *data,
 				   struct iwl_wowlan_status_data *status,
 				   u32 len)
 {
 	u32 i;
 
-	if (IWL_FW_CHECK(mvm, data->num_mlo_link_keys,
-			 "MLO is not supported, shouldn't receive MLO keys\n"))
-		return;
-
 	if (len < sizeof(*data)) {
 		IWL_ERR(mvm, "Invalid WoWLAN info notification!\n");
 		status = NULL;
@@ -3126,18 +3122,23 @@ static bool iwl_mvm_wait_d3_notif(struct iwl_notif_wait_data *notif_wait,
 			iwl_mvm_parse_wowlan_info_notif_v2(mvm, notif_v2,
 							   d3_data->status,
 							   len);
-		} else if (wowlan_info_ver < 5) {
-			struct iwl_wowlan_info_notif_v4 *notif =
+		} else if (wowlan_info_ver == 3) {
+			struct iwl_wowlan_info_notif_v3 *notif =
 				(void *)pkt->data;
 
-			iwl_mvm_parse_wowlan_info_notif_v4(mvm, notif,
+			iwl_mvm_parse_wowlan_info_notif_v3(mvm, notif,
 							   d3_data->status, len);
-		} else {
+		} else if (wowlan_info_ver == 5) {
 			struct iwl_wowlan_info_notif *notif =
 				(void *)pkt->data;
 
 			iwl_mvm_parse_wowlan_info_notif(mvm, notif,
 							d3_data->status, len);
+		} else {
+			IWL_FW_CHECK(mvm, 1,
+				     "Firmware advertises unknown WoWLAN info notification %d!\n",
+				     wowlan_info_ver);
+			return false;
 		}
 
 		d3_data->notif_received |= IWL_D3_NOTIF_WOWLAN_INFO;
-- 
2.34.1


