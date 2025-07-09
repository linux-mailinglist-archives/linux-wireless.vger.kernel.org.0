Return-Path: <linux-wireless+bounces-25069-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CFBDAFDF29
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 07:17:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 888401C24941
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 05:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA5A226B08F;
	Wed,  9 Jul 2025 05:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FOAvOfLU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2020426AABA
	for <linux-wireless@vger.kernel.org>; Wed,  9 Jul 2025 05:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752038237; cv=none; b=kMCn4lrO0s0/vJM7/DgmYs9nDRgqZ+8NQSP0SFsDjO/gz73dOYnk6XFEIh5zUNfcaJnvweZ3ZV0FnSiylE94lJxvxWQoii8DARAwkqwS9Jwqu6eFIfC3WLOUGvToyIjKCaMi6V8HyMUwhd8eofYk2nkqYMh3WsU13nWU4tQMBm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752038237; c=relaxed/simple;
	bh=c+4KpCoF/sVcc19/O0BP2e2MCGNmlfj3Ck7wYvp7xUQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VPbpsIbk42G/JPIl7vgYnjQaZbi1qCrUB4ims0IVdI9ezPSPnTvzVksUElvlG4VKTDiE9a+DPbua2yUAfd0RovAG6zoHu95msJ9hFHypBa1evcDTcB0D720dgA1zu4lTgYwsmUqLBelRFLX+vrtv+5iuln6I1CA02xAxAefgkEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FOAvOfLU; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752038236; x=1783574236;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=c+4KpCoF/sVcc19/O0BP2e2MCGNmlfj3Ck7wYvp7xUQ=;
  b=FOAvOfLUm/gWRXAxroQl1Mtk7fkiKQvzl4ll7NRpmGeqNUntTj+xCtt9
   HIlbyrf9Fri5Zm0hf2vgtCFH5ZhGd8TU/1t0o2X/c8+0puMVBd0fAgcP/
   CwvNTJsBXycyFrBs4vE7p+0LU56XIovDdi3+Tx3cMzb6rV5NbI2X+uIPs
   jvJDYcY2BSCaCoHlo4S6l9b7RhX/LFwMq4c5Yc+ltsQuCv3Tm8O1dq5e5
   lLdT4qoNidFotzE9NFJT8/0hVl/V9mis0YeIEcHcFfXbR9SFBkfYkXvZd
   fDpv9XTBpbtR5BIzM4FKezKORIhaHxQ6BshqegrGpEeJwO+bvzwEEbZol
   g==;
X-CSE-ConnectionGUID: WwQFWO/7Rb2Dyz7hNjqL/g==
X-CSE-MsgGUID: DaWSIMoxRdCiDf/X4z7KEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="58091184"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="58091184"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 22:17:16 -0700
X-CSE-ConnectionGUID: moLK1bygT4GtJaeUoCQdMA==
X-CSE-MsgGUID: kUu1ojnxSgu5hBnsgK7Kow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="161327903"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 22:17:15 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next v3 15/15] wifi: iwlwifi: mvm: remove support for iwl_wowlan_info_notif_v4
Date: Wed,  9 Jul 2025 08:16:34 +0300
Message-Id: <20250709081300.1668a7430521.I488d69251aed62f0b11a2553f972a1730bc8b6cf@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250709051634.866992-1-miriam.rachel.korenblit@intel.com>
References: <20250709051634.866992-1-miriam.rachel.korenblit@intel.com>
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


