Return-Path: <linux-wireless+bounces-24992-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 02C89AFD79E
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 21:52:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8D831888053
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 19:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 976BF239E9F;
	Tue,  8 Jul 2025 19:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y/HIl298"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8318242910
	for <linux-wireless@vger.kernel.org>; Tue,  8 Jul 2025 19:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752004294; cv=none; b=h8+MUHNqn+os2MwXwnd6GzPMJvr4JU9/TEFKDeQ4wCin3gHSnTEmo2ZwB7t4LonlDwJnHQ2rXx5ZdSfzF5SGgOaVA9F+9rnzday6/z/Zkx/XhpKpdBzZwFi4Jg5HtzXEdv77n9TMk25oCoVoj/hjzJXZ9OVPAoBmVS1tbqK32sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752004294; c=relaxed/simple;
	bh=c+4KpCoF/sVcc19/O0BP2e2MCGNmlfj3Ck7wYvp7xUQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NPFtK0sUkiacouE4Z+qyREk0fGPUaaC3m/NsWqtEKu2fHEHAecdviJdYQBWmz9ymFuRANT+X0GQS0btT7WeRwVuLpc4ZT2ssM/C7Y2XD8Pkag0bE4d7lAmGXdPaWrmL79ImYTJIEsbWavq+mpzLDeqqcmSrdSF2Tjhs3wAjXgdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y/HIl298; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752004293; x=1783540293;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=c+4KpCoF/sVcc19/O0BP2e2MCGNmlfj3Ck7wYvp7xUQ=;
  b=Y/HIl298JBDCY3YheIH5KbYR8U3L5bvZRiZFZqoHeWjPKMGFYFnPJwJj
   h0ULTSCNeYuLFXO59BfrWNWou3Y+k6Dlbh2qCBTTW/rM/49HWETl+uYux
   guYKDWPiRwh5rSk5JdBW/whgzsobQQZUryUywYZWw/L3hFvuJD/tLcPMT
   Z2vh7irw0tjEUJ03ouRzp7NYk5BHrBy9yn8+fEt3yx9yZE+GGX8Rdj4oC
   ibw85gzC4z9uR2X3wsbS2ls+At6+6MFnLw7SsjksAACcDzIqjxlzFVSrx
   WArjmtRJzRy0lQICha8LDs5/nszALty+3ZPV7ZZrzUOqkvqUA8ydlA0kt
   g==;
X-CSE-ConnectionGUID: vSD9v5z1RI2gZk0BVE8RRw==
X-CSE-MsgGUID: WCFRk2RTT8eLrvt+O4CvnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="54229733"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="54229733"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 12:51:32 -0700
X-CSE-ConnectionGUID: KvKgfrvHQFmpJmOXh2znGw==
X-CSE-MsgGUID: kCEOXaE7R1uavP284X4ttQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="155669006"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 12:51:31 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 15/15] wifi: iwlwifi: mvm: remove support for iwl_wowlan_info_notif_v4
Date: Tue,  8 Jul 2025 22:50:53 +0300
Message-Id: <20250708224652.721f70e65497.I488d69251aed62f0b11a2553f972a1730bc8b6cf@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250708195053.451143-1-miriam.rachel.korenblit@intel.com>
References: <20250708195053.451143-1-miriam.rachel.korenblit@intel.com>
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


