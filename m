Return-Path: <linux-wireless+bounces-26498-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD35B2F8DB
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Aug 2025 14:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFAE53AE0DE
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Aug 2025 12:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA3C2E7F28;
	Thu, 21 Aug 2025 12:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U2Fjm11T"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B593218A2
	for <linux-wireless@vger.kernel.org>; Thu, 21 Aug 2025 12:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755780307; cv=none; b=Bw8tsvS66b/Ul/bmSnob+8scexsNZ89xsZzsalpa/j3+VuYU8JlXzT1X4LdsxqocUACfV4F/+E5dOWnacoMoOZdJz0sOsy/uMSyk3ug7O4daI2B3emVKuo/GCZYtla96x8/1cEoPKgBux6x1uey9FXWUxThJkpkNO+shWBXuo1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755780307; c=relaxed/simple;
	bh=ZAWqsUNgGWBDBfAwTtTDYNOkzOiI29QaEuvfeqlhl/M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=loQ4SmHLzrpLIBQ8VqgEz4d5lSP3qmI/85jzCNtOm1iV1JfANe4XiFI4IXiO4weg9Zmbpjj0cVph84jy5D75TVfngTksdxz+NoTtNPtnOBZIpQpxDpYn9a0GMMXMf5QV4F4K66TqVCHEfQOpkoCoDvxZReobsvGoeW00repW6PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U2Fjm11T; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755780306; x=1787316306;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZAWqsUNgGWBDBfAwTtTDYNOkzOiI29QaEuvfeqlhl/M=;
  b=U2Fjm11T1A9+r5fan5t28WRLMu3SMX980bptsu25letGuft6+OkmEkzn
   8f0HkA3mvjOagcoFhgMG28J64w5QVUGCsSWXzybrwB1phBWy+JRCSEYGM
   VNAzOPsZ6snnc+7p9ttBTSfV04CNXlfe/Q3ZwPwPIf7sxYju8on8petuv
   Q47wVmCmzq6DVgbUeAAoK6+xPF54INYTCgE/H00wwqDiOWx0ZFcAsg8Em
   ZctmXI2+vnRq16zcw4doDScNn/0QBI9Ijbz/xE7Y2F9zf2OvlhdyfUNT2
   ZfNV47bYlVUhBksra4JotI3eeh6w6VmmwuHwMfxKF1j3yt4vqgDeG4Zzi
   w==;
X-CSE-ConnectionGUID: cDAZ0+J2Q6upZER5XSq3yw==
X-CSE-MsgGUID: yK3k0WYVQz2Z4keSo6mmfw==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="61895738"
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="61895738"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 05:45:06 -0700
X-CSE-ConnectionGUID: yN3lVJ3YT266zFGxKbC4Dg==
X-CSE-MsgGUID: 5D9Vf5ePS0mvBChLyo3d5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="172622158"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 05:45:05 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 04/15] wifi: iwlwifi: mld: support MLO rekey on resume
Date: Thu, 21 Aug 2025 15:44:22 +0300
Message-Id: <20250821154216.fae2b42fbbfc.I7fcba97b6424577e49f7295f0c40b7d294ab56d8@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250821124433.2234183-1-miriam.rachel.korenblit@intel.com>
References: <20250821124433.2234183-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

When resuming from wowlan, update mac80211 on rekeys of MLO group keys
and set the PN for those keys.

Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/d3.c | 126 ++++++++++++++++++--
 1 file changed, 118 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/d3.c b/drivers/net/wireless/intel/iwlwifi/mld/d3.c
index daa01fe62f84..0ac6ceddb44f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/d3.c
@@ -71,6 +71,12 @@ struct iwl_mld_mcast_key_data {
 
 };
 
+struct iwl_mld_wowlan_mlo_key {
+	u8 key[WOWLAN_KEY_MAX_SIZE];
+	u8 idx, type, link_id;
+	u8 pn[6];
+};
+
 /**
  * struct iwl_mld_wowlan_status - contains wowlan status data from
  * all wowlan notifications
@@ -89,6 +95,8 @@ struct iwl_mld_mcast_key_data {
  * @bigtk: data of the last two used gtk's by the FW upon resume
  * @ptk: last seq numbers per tid passed by the FW,
  *	holds both in tkip and aes formats
+ * @num_mlo_keys: number of &struct iwl_mld_wowlan_mlo_key structs
+ * @mlo_keys: array of MLO keys
  */
 struct iwl_mld_wowlan_status {
 	u32 wakeup_reasons;
@@ -108,6 +116,9 @@ struct iwl_mld_wowlan_status {
 		struct ieee80211_key_seq tkip_seq[IWL_MAX_TID_COUNT];
 
 	} ptk;
+
+	int num_mlo_keys;
+	struct iwl_mld_wowlan_mlo_key mlo_keys[WOWLAN_MAX_MLO_KEYS];
 };
 
 #define NETDETECT_QUERY_BUF_LEN \
@@ -407,19 +418,65 @@ iwl_mld_convert_bigtk_resume_data(struct iwl_mld_wowlan_status *wowlan_status,
 	}
 }
 
+static void
+iwl_mld_convert_mlo_keys(struct iwl_mld *mld,
+			 const struct iwl_wowlan_info_notif *notif,
+			 struct iwl_mld_wowlan_status *wowlan_status)
+{
+	if (!notif->num_mlo_link_keys)
+		return;
+
+	wowlan_status->num_mlo_keys = notif->num_mlo_link_keys;
+
+	if (IWL_FW_CHECK(mld, wowlan_status->num_mlo_keys > WOWLAN_MAX_MLO_KEYS,
+			 "Too many MLO keys: %d, max %d\n",
+			 wowlan_status->num_mlo_keys, WOWLAN_MAX_MLO_KEYS))
+		wowlan_status->num_mlo_keys = WOWLAN_MAX_MLO_KEYS;
+
+	for (int i = 0; i < wowlan_status->num_mlo_keys; i++) {
+		const struct iwl_wowlan_mlo_gtk *fw_mlo_key = &notif->mlo_gtks[i];
+		struct iwl_mld_wowlan_mlo_key *driver_mlo_key =
+			&wowlan_status->mlo_keys[i];
+		u16 flags = le16_to_cpu(fw_mlo_key->flags);
+
+		driver_mlo_key->link_id =
+			u16_get_bits(flags, WOWLAN_MLO_GTK_FLAG_LINK_ID_MSK);
+		driver_mlo_key->type =
+			u16_get_bits(flags, WOWLAN_MLO_GTK_FLAG_KEY_TYPE_MSK);
+		driver_mlo_key->idx =
+			u16_get_bits(flags, WOWLAN_MLO_GTK_FLAG_KEY_ID_MSK);
+
+		BUILD_BUG_ON(sizeof(driver_mlo_key->key) != sizeof(fw_mlo_key->key));
+		BUILD_BUG_ON(sizeof(driver_mlo_key->pn) != sizeof(fw_mlo_key->pn));
+
+		memcpy(driver_mlo_key->key, fw_mlo_key->key, sizeof(fw_mlo_key->key));
+		memcpy(driver_mlo_key->pn, fw_mlo_key->pn, sizeof(fw_mlo_key->pn));
+	}
+}
+
 static bool
 iwl_mld_handle_wowlan_info_notif(struct iwl_mld *mld,
 				 struct iwl_mld_wowlan_status *wowlan_status,
 				 struct iwl_rx_packet *pkt)
 {
 	const struct iwl_wowlan_info_notif *notif = (void *)pkt->data;
-	u32 expected_len, len = iwl_rx_packet_payload_len(pkt);
+	u32 len = iwl_rx_packet_payload_len(pkt);
+	u32 len_with_mlo_keys;
 
-	expected_len = sizeof(*notif);
+	if (IWL_FW_CHECK(mld, len < sizeof(*notif),
+			 "Invalid wowlan_info_notif (expected=%zu got=%u)\n",
+			 sizeof(*notif), len))
+		return true;
 
-	if (IWL_FW_CHECK(mld, len < expected_len,
-			 "Invalid wowlan_info_notif (expected=%ud got=%ud)\n",
-			 expected_len, len))
+	/* Now that we know that we have at least sizeof(notif),
+	 * check also the variable length part
+	 */
+	len_with_mlo_keys = sizeof(*notif) +
+		notif->num_mlo_link_keys * sizeof(notif->mlo_gtks[0]);
+
+	if (IWL_FW_CHECK(mld, len < len_with_mlo_keys,
+			 "Invalid wowlan_info_notif (expected=%ud got=%u)\n",
+			 len_with_mlo_keys, len))
 		return true;
 
 	if (IWL_FW_CHECK(mld, notif->tid_offloaded_tx != IWL_WOWLAN_OFFLOAD_TID,
@@ -442,8 +499,10 @@ iwl_mld_handle_wowlan_info_notif(struct iwl_mld *mld,
 	wowlan_status->num_of_gtk_rekeys =
 		le32_to_cpu(notif->num_of_gtk_rekeys);
 	wowlan_status->wakeup_reasons = le32_to_cpu(notif->wakeup_reasons);
+
+	iwl_mld_convert_mlo_keys(mld, notif, wowlan_status);
+
 	return false;
-	/* TODO: mlo_links (task=MLO)*/
 }
 
 static bool
@@ -687,7 +746,6 @@ iwl_mld_resume_keys_iter(struct ieee80211_hw *hw,
 	struct iwl_mld_wowlan_status *wowlan_status = data->wowlan_status;
 	u8 status_idx;
 
-	/* TODO: check key link id (task=MLO) */
 	if (data->unhandled_cipher)
 		return;
 
@@ -797,6 +855,57 @@ iwl_mld_add_all_rekeys(struct ieee80211_vif *vif,
 					link_conf);
 }
 
+static void iwl_mld_mlo_rekey(struct iwl_mld *mld,
+			      struct iwl_mld_wowlan_status *wowlan_status,
+			      struct ieee80211_vif *vif)
+{
+	struct iwl_mld_old_mlo_keys *old_keys __free(kfree) = NULL;
+
+	IWL_DEBUG_WOWLAN(mld, "Num of MLO Keys: %d\n", wowlan_status->num_mlo_keys);
+
+	if (!wowlan_status->num_mlo_keys)
+		return;
+
+	for (int i = 0; i < wowlan_status->num_mlo_keys; i++) {
+		struct iwl_mld_wowlan_mlo_key *mlo_key = &wowlan_status->mlo_keys[i];
+		struct ieee80211_key_conf *key;
+		struct ieee80211_key_seq seq;
+		u8 link_id = mlo_key->link_id;
+
+		if (IWL_FW_CHECK(mld, mlo_key->link_id >= IEEE80211_MLD_MAX_NUM_LINKS ||
+				      mlo_key->idx >= 8 ||
+				      mlo_key->type >= WOWLAN_MLO_GTK_KEY_NUM_TYPES,
+				      "Invalid MLO key link_id %d, idx %d, type %d\n",
+				      mlo_key->link_id, mlo_key->idx, mlo_key->type))
+			continue;
+
+		if (!(vif->valid_links & BIT(link_id)) ||
+		    (vif->active_links & BIT(link_id)))
+			continue;
+
+		IWL_DEBUG_WOWLAN(mld, "Add MLO key id %d, link id %d\n",
+				 mlo_key->idx, link_id);
+
+		key = ieee80211_gtk_rekey_add(vif, mlo_key->idx, mlo_key->key,
+					      sizeof(mlo_key->key), link_id);
+
+		if (IS_ERR(key))
+			continue;
+
+		/*
+		 * mac80211 expects the PN in big-endian
+		 * also note that seq is a union of all cipher types
+		 * (ccmp, gcmp, cmac, gmac), and they all have the same
+		 * pn field (of length 6) so just copy it to ccmp.pn.
+		 */
+		for (int j = 5; j >= 0; j--)
+			seq.ccmp.pn[5 - j] = mlo_key->pn[j];
+
+		/* group keys are non-QoS and use TID 0 */
+		ieee80211_set_key_rx_seq(key, 0, &seq);
+	}
+}
+
 static bool
 iwl_mld_update_sec_keys(struct iwl_mld *mld,
 			struct ieee80211_vif *vif,
@@ -831,9 +940,10 @@ iwl_mld_update_sec_keys(struct iwl_mld *mld,
 	iwl_mld_add_all_rekeys(vif, wowlan_status, &key_iter_data,
 			       link_conf);
 
+	iwl_mld_mlo_rekey(mld, wowlan_status, vif);
+
 	ieee80211_gtk_rekey_notify(vif, link_conf->bssid,
 				   (void *)&replay_ctr, GFP_KERNEL);
-	/* TODO: MLO rekey (task=MLO) */
 	return true;
 }
 
-- 
2.34.1


