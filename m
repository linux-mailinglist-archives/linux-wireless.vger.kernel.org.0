Return-Path: <linux-wireless+bounces-16843-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C6A9FDC2B
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Dec 2024 21:34:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B58E161532
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Dec 2024 20:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B27192D95;
	Sat, 28 Dec 2024 20:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CCWTu2OM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C864138DC8
	for <linux-wireless@vger.kernel.org>; Sat, 28 Dec 2024 20:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735418077; cv=none; b=fgFDWD7FfNBkvuqIAxqyCqUNh/EKRaJzDAR+egoi9mdm0Fs4kQmzgeIAfxwzkU72+rW7K9fAl6KBoWxuioCk6UbBabpYyPECBFZXrSEzScAIxLXTL8aOWTJm9LVtRRit3Z53ub1xlfVlgLsmSqVddfbcj6Cg+Wbb4AF4CLFxjFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735418077; c=relaxed/simple;
	bh=D55MPvQ/LgGYGYUWkB/rb/govWTif7mKh16tSAyR1Io=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=njl8lBOi58q3HfG7wIOr8KEOVwl4iAxUBsGorRhr0DW57mdQAnpg5CjTwjgg0TT/5Wg5kQxOHGIpAsZi4y1ONFjzVoWrRSlv5+FXzN0p7nOeAO4cb6ty2GoBGXF8czFadDC3SBBIWU/2DG9DP8Qf0ojk2wZYd50sHUElFla01bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CCWTu2OM; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735418076; x=1766954076;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=D55MPvQ/LgGYGYUWkB/rb/govWTif7mKh16tSAyR1Io=;
  b=CCWTu2OMDHnkCJ71EpNvGYK4TfMrKgNN6EuDzhL50UnUX/FsUQfg+Khg
   IVEWqE9gkhfD1l6ZR2/pfOO5msg9Gd7BpXqLH+0VgdSQaR8X5Wob5k2HF
   Zsv/fvMPEPFDx6Yb5mfV0acFq2pFExy5zgh0eJDgDGqxTAsaZGZe5DNw5
   CtRyoL9arOgC9BKUHRHa14f1kZPPVnTK4/4SofQeCRr9g0Ytb778MtYjY
   qkfJ1qyn87OOK8fhMymyJchZGO8zY054s9PkvrV9h29Wbel0t12K6zHo5
   sNKcH1G+L2Sr6ZTcL4PtwMs684/cPEJPHjUdjWhQtNTdggbv0uy7LQvAc
   Q==;
X-CSE-ConnectionGUID: U07oDJahSzK4MwpGbSa3kQ==
X-CSE-MsgGUID: TvjrYNcRSY+3uAzyRCYwnQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11299"; a="35479750"
X-IronPort-AV: E=Sophos;i="6.12,273,1728975600"; 
   d="scan'208";a="35479750"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2024 12:34:35 -0800
X-CSE-ConnectionGUID: gQerue8uSbyLUv8nU1e5Ag==
X-CSE-MsgGUID: nU4PHyJIT8SH6IfmU5Cn0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="104488355"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2024 12:34:34 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 01/15] wifi: iwlwifi: mld: make iwl_mvm_find_ie_offset a iwlwifi util
Date: Sat, 28 Dec 2024 22:34:05 +0200
Message-Id: <20241228223206.a36373eefbf2.Ib1f305b78508c98934f6000720d6455c88a860cb@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241228203419.2443350-1-miriam.rachel.korenblit@intel.com>
References: <20241228203419.2443350-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

This is needed also for more opmodes, and is really not opmode dependent.
Make it a iwlwifi util.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
---
 .../net/wireless/intel/iwlwifi/iwl-utils.h    | 20 ++++++++
 .../net/wireless/intel/iwlwifi/mvm/debugfs.c  |  7 +--
 .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c | 48 +++++++------------
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  1 -
 4 files changed, 40 insertions(+), 36 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-utils.h b/drivers/net/wireless/intel/iwlwifi/iwl-utils.h
index b43703afdff2..909460316995 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-utils.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-utils.h
@@ -5,6 +5,8 @@
 #ifndef __iwl_utils_h__
 #define __iwl_utils_h__
 
+#include <net/cfg80211.h>
+
 #ifdef CONFIG_INET
 /**
  * iwl_tx_tso_segment - Segments a TSO packet into subframes for A-MSDU.
@@ -33,4 +35,22 @@ int iwl_tx_tso_segment(struct sk_buff *skb, unsigned int num_subframes,
 }
 #endif /* CONFIG_INET */
 
+static inline
+u32 iwl_find_ie_offset(u8 *beacon, u8 eid, u32 frame_size)
+{
+	struct ieee80211_mgmt *mgmt = (void *)beacon;
+	const u8 *ie;
+
+	if (WARN_ON_ONCE(frame_size <= (mgmt->u.beacon.variable - beacon)))
+		return 0;
+
+	frame_size -= mgmt->u.beacon.variable - beacon;
+
+	ie = cfg80211_find_ie(eid, mgmt->u.beacon.variable, frame_size);
+	if (!ie)
+		return 0;
+
+	return ie - beacon;
+}
+
 #endif /* __iwl_utils_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
index 7fbfec6750c1..b8ae86039045 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
@@ -16,6 +16,7 @@
 #include "debugfs.h"
 #include "iwl-modparams.h"
 #include "iwl-drv.h"
+#include "iwl-utils.h"
 #include "fw/error-dump.h"
 #include "fw/api/phy-ctxt.h"
 
@@ -1413,9 +1414,9 @@ static int _iwl_dbgfs_inject_beacon_ie(struct iwl_mvm *mvm, char *bin, int len)
 
 		if (iwl_fw_lookup_cmd_ver(mvm->fw,
 					  BEACON_TEMPLATE_CMD, 0) >= 14) {
-			u32 offset = iwl_mvm_find_ie_offset(beacon->data,
-							    WLAN_EID_S1G_TWT,
-							    beacon->len);
+			u32 offset = iwl_find_ie_offset(beacon->data,
+							WLAN_EID_S1G_TWT,
+							beacon->len);
 
 			beacon_cmd.btwt_offset = cpu_to_le32(offset);
 		}
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
index 51ee62ae70fb..bbf0f2753f9f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
@@ -12,6 +12,7 @@
 #include "fw-api.h"
 #include "mvm.h"
 #include "time-event.h"
+#include "iwl-utils.h"
 
 const u8 iwl_mvm_ac_to_tx_fifo[] = {
 	IWL_MVM_TX_FIFO_VO,
@@ -868,23 +869,6 @@ void iwl_mvm_mac_ctxt_set_tim(struct iwl_mvm *mvm,
 	}
 }
 
-u32 iwl_mvm_find_ie_offset(u8 *beacon, u8 eid, u32 frame_size)
-{
-	struct ieee80211_mgmt *mgmt = (void *)beacon;
-	const u8 *ie;
-
-	if (WARN_ON_ONCE(frame_size <= (mgmt->u.beacon.variable - beacon)))
-		return 0;
-
-	frame_size -= mgmt->u.beacon.variable - beacon;
-
-	ie = cfg80211_find_ie(eid, mgmt->u.beacon.variable, frame_size);
-	if (!ie)
-		return 0;
-
-	return ie - beacon;
-}
-
 u8 iwl_mvm_mac_ctxt_get_lowest_rate(struct iwl_mvm *mvm,
 				    struct ieee80211_tx_info *info,
 				    struct ieee80211_vif *vif)
@@ -1078,13 +1062,13 @@ static int iwl_mvm_mac_ctxt_send_beacon_v7(struct iwl_mvm *mvm,
 					 beacon->data, beacon->len);
 
 	beacon_cmd.csa_offset =
-		cpu_to_le32(iwl_mvm_find_ie_offset(beacon->data,
-						   WLAN_EID_CHANNEL_SWITCH,
-						   beacon->len));
+		cpu_to_le32(iwl_find_ie_offset(beacon->data,
+					       WLAN_EID_CHANNEL_SWITCH,
+					       beacon->len));
 	beacon_cmd.ecsa_offset =
-		cpu_to_le32(iwl_mvm_find_ie_offset(beacon->data,
-						   WLAN_EID_EXT_CHANSWITCH_ANN,
-						   beacon->len));
+		cpu_to_le32(iwl_find_ie_offset(beacon->data,
+					       WLAN_EID_EXT_CHANSWITCH_ANN,
+					       beacon->len));
 
 	return iwl_mvm_mac_ctxt_send_beacon_cmd(mvm, beacon, &beacon_cmd,
 						sizeof(beacon_cmd));
@@ -1151,20 +1135,20 @@ static int iwl_mvm_mac_ctxt_send_beacon_v9(struct iwl_mvm *mvm,
 					 beacon->data, beacon->len);
 
 	beacon_cmd.csa_offset =
-		cpu_to_le32(iwl_mvm_find_ie_offset(beacon->data,
-						   WLAN_EID_CHANNEL_SWITCH,
-						   beacon->len));
+		cpu_to_le32(iwl_find_ie_offset(beacon->data,
+					       WLAN_EID_CHANNEL_SWITCH,
+					       beacon->len));
 	beacon_cmd.ecsa_offset =
-		cpu_to_le32(iwl_mvm_find_ie_offset(beacon->data,
-						   WLAN_EID_EXT_CHANSWITCH_ANN,
-						   beacon->len));
+		cpu_to_le32(iwl_find_ie_offset(beacon->data,
+					       WLAN_EID_EXT_CHANSWITCH_ANN,
+					       beacon->len));
 
 	if (vif->type == NL80211_IFTYPE_AP &&
 	    iwl_fw_lookup_cmd_ver(mvm->fw, BEACON_TEMPLATE_CMD, 0) >= 14)
 		beacon_cmd.btwt_offset =
-			cpu_to_le32(iwl_mvm_find_ie_offset(beacon->data,
-							   WLAN_EID_S1G_TWT,
-							   beacon->len));
+			cpu_to_le32(iwl_find_ie_offset(beacon->data,
+						       WLAN_EID_S1G_TWT,
+						       beacon->len));
 
 	return iwl_mvm_mac_ctxt_send_beacon_cmd(mvm, beacon, &beacon_cmd,
 						sizeof(beacon_cmd));
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index dbf32bf5760b..43e304f22475 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1819,7 +1819,6 @@ u8 iwl_mvm_next_antenna(struct iwl_mvm *mvm, u8 valid, u8 last_idx);
 void iwl_mvm_get_sync_time(struct iwl_mvm *mvm, int clock_type, u32 *gp2,
 			   u64 *boottime, ktime_t *realtime);
 u32 iwl_mvm_get_systime(struct iwl_mvm *mvm);
-u32 iwl_mvm_find_ie_offset(u8 *beacon, u8 eid, u32 frame_size);
 
 /* Tx / Host Commands */
 int __must_check iwl_mvm_send_cmd(struct iwl_mvm *mvm,
-- 
2.34.1


