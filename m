Return-Path: <linux-wireless+bounces-27128-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B43B49FF9
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Sep 2025 05:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15AB31B249C2
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Sep 2025 03:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA15126F280;
	Tue,  9 Sep 2025 03:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MaI3Fz+I"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3CE291C1F
	for <linux-wireless@vger.kernel.org>; Tue,  9 Sep 2025 03:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757388130; cv=none; b=lBLZUzg01xa1BcW9lvlSBWzNpquo9q4+nDgBp8doydLPlCTLoaCHbEM/u/E1OM3ZZdaAZrfoXLyEXFAQlJUMNgayDn5fHar5eH8qR8sQQfjxLRLOS6tOelLjanuxzMWrFO+vGHKZ5SVPc/CRQOiYWdmgMlFhbPXJrkJ7S40xIrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757388130; c=relaxed/simple;
	bh=/u4/m829LYh94P1CVuwdTs7EdA9cAkSPZ3zpvPFWiYQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MH+Fg0vyteitvUsxei0y4nszsMp7FEQhGkpq5bqbc8KokkjHP+J45j9ZTgozCit4Rv4mseBACEYDbTythZYroy+NuMZK+YSo5mEXzVXn1iOMzopSxXJnPMPwylcilFwsCx8XKwVKP13lmPo+2oKI144bKBJjA7ZFPb8lUhJyWVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MaI3Fz+I; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757388128; x=1788924128;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/u4/m829LYh94P1CVuwdTs7EdA9cAkSPZ3zpvPFWiYQ=;
  b=MaI3Fz+Ik/prYjK3b7m5rB7TkmDXLT8L+H9+r6C9EZaJczSDaMUU2+CU
   rwDAVbxtlvtIaZRAJjgVa7AxhcIJZUfTcg28kBOGD2/LKhEFRqS6iLzn0
   47Hz3EielZcDDB5/tRmltE7yBEZs5ddvB54jtRVqra35BkqLuOksOPjWE
   jYXCzW3Jr7i/VXDp7coVfxk7YF0+58oY5bE5v84XD78e7inwTHqO/ptxm
   /vV4d6/zrbtbM5r9yaKCnS+PpNBSa/9ZQmNHcvOc0hFXItxgFkfEL3pSC
   znxN20JdAjqT6tzOigp6m5f0OZRoM+fUYItmoRhxCHmWeo5iQfL4hUnqE
   g==;
X-CSE-ConnectionGUID: xhtBl2ZYSNKEI4H4sPIvcA==
X-CSE-MsgGUID: ReK7EFPHSmqyEADIZmUTtw==
X-IronPort-AV: E=McAfee;i="6800,10657,11547"; a="70281063"
X-IronPort-AV: E=Sophos;i="6.18,250,1751266800"; 
   d="scan'208";a="70281063"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 20:22:08 -0700
X-CSE-ConnectionGUID: PvVKx8yPQBOrfTFsAYVnAA==
X-CSE-MsgGUID: F8kJ11FiR1qD/zkkdanESQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,250,1751266800"; 
   d="scan'208";a="203950387"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 20:22:06 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Rotem Kerem <rotem.kerem@intel.com>
Subject: [PATCH v2 iwlwifi-next 09/15] wifi: iwlwifi: implement wowlan status notification API update
Date: Tue,  9 Sep 2025 06:21:22 +0300
Message-Id: <20250909061931.0a2e7a62504c.Id195c9c83f9f767d1e3e458468af2d933774daa1@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250909032128.3318193-1-miriam.rachel.korenblit@intel.com>
References: <20250909032128.3318193-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Rotem Kerem <rotem.kerem@intel.com>

Add per key status indication in the WOWLAN status notification.
This update is required for fips. Each key entry now
includes a status field.

Keys are now processed as follows:
0: no key, ignore entry
1: old, use only metadata
2: new, use key material and metadata

While at it, fix tid_offloaded_tx error message to print the
actual variable being validated in iwl_mld_handle_wowlan_info_notif.

Signed-off-by: Rotem Kerem <rotem.kerem@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/fw/api/d3.h    | 112 ++++++++-
 .../wireless/intel/iwlwifi/fw/api/offload.h   |   2 +-
 drivers/net/wireless/intel/iwlwifi/mld/d3.c   | 233 +++++++++++++++---
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   |   8 +-
 4 files changed, 306 insertions(+), 49 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h b/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h
index 9103f70c41c0..d3bed0216df4 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h
@@ -632,9 +632,64 @@ struct iwl_wowlan_gtk_status_v3 {
 	struct iwl_wowlan_all_rsc_tsc_v5 sc;
 } __packed; /* WOWLAN_GTK_MATERIAL_VER_3 */
 
+/**
+ * enum iwl_wowlan_key_status - Status of security keys in WoWLAN notifications
+ * @IWL_WOWLAN_NOTIF_NO_KEY: No key is present; this entry should be ignored.
+ * @IWL_WOWLAN_STATUS_OLD_KEY: old key exists; no rekey occurred, and only
+ *	metadata is available.
+ * @IWL_WOWLAN_STATUS_NEW_KEY: A new key was created after a rekey; new key
+ *	material is available.
+ */
+enum iwl_wowlan_key_status {
+	IWL_WOWLAN_NOTIF_NO_KEY = 0,
+	IWL_WOWLAN_STATUS_OLD_KEY = 1,
+	IWL_WOWLAN_STATUS_NEW_KEY = 2
+};
+
+/**
+ * struct iwl_wowlan_gtk_status - GTK status
+ * @key: GTK material
+ * @key_len: GTK length, if set to 0, the key is not available
+ * @key_flags: information about the key:
+ *	bits[0:1]:  key index assigned by the AP
+ *	bits[2:6]:  GTK index of the key in the internal DB
+ *	bit[7]:     Set iff this is the currently used GTK
+ * @key_status: key status, see &enum iwl_wowlan_key_status
+ * @reserved: padding
+ * @tkip_mic_key: TKIP RX MIC key
+ * @sc: RSC/TSC counters
+ */
+struct iwl_wowlan_gtk_status {
+	u8 key[WOWLAN_KEY_MAX_SIZE];
+	u8 key_len;
+	u8 key_flags;
+	u8 key_status;
+	u8 reserved;
+	u8 tkip_mic_key[IWL_MIC_KEY_SIZE];
+	struct iwl_wowlan_all_rsc_tsc_v5 sc;
+} __packed; /* WOWLAN_GTK_MATERIAL_VER_4 */
+
 #define IWL_WOWLAN_GTK_IDX_MASK		(BIT(0) | BIT(1))
 #define IWL_WOWLAN_IGTK_BIGTK_IDX_MASK	(BIT(0))
 
+/**
+ * struct iwl_wowlan_igtk_status_v1 - IGTK status
+ * @key: IGTK material
+ * @ipn: the IGTK packet number (replay counter)
+ * @key_len: IGTK length, if set to 0, the key is not available
+ * @key_flags: information about the key:
+ *	bits[0]: key index assigned by the AP (0: index 4, 1: index 5)
+ *	(0: index 6, 1: index 7 with bigtk)
+ *	bits[1:5]: IGTK index of the key in the internal DB
+ *	bit[6]: Set iff this is the currently used IGTK
+ */
+struct iwl_wowlan_igtk_status_v1 {
+	u8 key[WOWLAN_KEY_MAX_SIZE];
+	u8 ipn[6];
+	u8 key_len;
+	u8 key_flags;
+} __packed; /* WOWLAN_IGTK_MATERIAL_VER_1 */
+
 /**
  * struct iwl_wowlan_igtk_status - IGTK status
  * @key: IGTK material
@@ -645,13 +700,17 @@ struct iwl_wowlan_gtk_status_v3 {
  *	(0: index 6, 1: index 7 with bigtk)
  *	bits[1:5]: IGTK index of the key in the internal DB
  *	bit[6]: Set iff this is the currently used IGTK
+ * @key_status: key status, see &enum iwl_wowlan_key_status
+ * @reserved: padding
  */
 struct iwl_wowlan_igtk_status {
 	u8 key[WOWLAN_KEY_MAX_SIZE];
 	u8 ipn[6];
 	u8 key_len;
 	u8 key_flags;
-} __packed; /* WOWLAN_IGTK_MATERIAL_VER_1 */
+	u8 key_status;
+	u8 reserved[3];
+} __packed; /* WOWLAN_IGTK_MATERIAL_VER_2 */
 
 /**
  * struct iwl_wowlan_status_v6 - WoWLAN status
@@ -701,7 +760,7 @@ struct iwl_wowlan_status_v6 {
  */
 struct iwl_wowlan_status_v7 {
 	struct iwl_wowlan_gtk_status_v2 gtk[WOWLAN_GTK_KEYS_NUM];
-	struct iwl_wowlan_igtk_status igtk[WOWLAN_IGTK_KEYS_NUM];
+	struct iwl_wowlan_igtk_status_v1 igtk[WOWLAN_IGTK_KEYS_NUM];
 	__le64 replay_ctr;
 	__le16 pattern_number;
 	__le16 non_qos_seq_ctr;
@@ -736,7 +795,7 @@ struct iwl_wowlan_status_v7 {
  */
 struct iwl_wowlan_info_notif_v1 {
 	struct iwl_wowlan_gtk_status_v3 gtk[WOWLAN_GTK_KEYS_NUM];
-	struct iwl_wowlan_igtk_status igtk[WOWLAN_IGTK_KEYS_NUM];
+	struct iwl_wowlan_igtk_status_v1 igtk[WOWLAN_IGTK_KEYS_NUM];
 	__le64 replay_ctr;
 	__le16 pattern_number;
 	__le16 reserved1;
@@ -818,8 +877,8 @@ struct iwl_wowlan_mlo_gtk {
  */
 struct iwl_wowlan_info_notif_v3 {
 	struct iwl_wowlan_gtk_status_v3 gtk[WOWLAN_GTK_KEYS_NUM];
-	struct iwl_wowlan_igtk_status igtk[WOWLAN_IGTK_KEYS_NUM];
-	struct iwl_wowlan_igtk_status bigtk[WOWLAN_BIGTK_KEYS_NUM];
+	struct iwl_wowlan_igtk_status_v1 igtk[WOWLAN_IGTK_KEYS_NUM];
+	struct iwl_wowlan_igtk_status_v1 bigtk[WOWLAN_BIGTK_KEYS_NUM];
 	__le64 replay_ctr;
 	__le16 pattern_number;
 	__le16 reserved1;
@@ -833,6 +892,45 @@ struct iwl_wowlan_info_notif_v3 {
 	u8 reserved2[2];
 } __packed; /* WOWLAN_INFO_NTFY_API_S_VER_3 */
 
+/**
+ * struct iwl_wowlan_info_notif_v5 - WoWLAN information notification
+ * @gtk: GTK data
+ * @igtk: IGTK data
+ * @bigtk: BIGTK data
+ * @replay_ctr: GTK rekey replay counter
+ * @pattern_number: number of the matched patterns
+ * @qos_seq_ctr: QoS sequence counters to use next
+ * @wakeup_reasons: wakeup reasons, see &enum iwl_wowlan_wakeup_reason
+ * @num_of_gtk_rekeys: number of GTK rekeys
+ * @transmitted_ndps: number of transmitted neighbor discovery packets
+ * @received_beacons: number of received beacons
+ * @tid_tear_down: bit mask of tids whose BA sessions were closed
+ *	in suspend state
+ * @station_id: station id
+ * @num_mlo_link_keys: number of &struct iwl_wowlan_mlo_gtk structs
+ *	following this notif
+ * @tid_offloaded_tx: tid used by the firmware to transmit data packets
+ *	while in wowlan
+ * @mlo_gtks: array of GTKs of size num_mlo_link_keys
+ */
+struct iwl_wowlan_info_notif_v5 {
+	struct iwl_wowlan_gtk_status_v3 gtk[WOWLAN_GTK_KEYS_NUM];
+	struct iwl_wowlan_igtk_status_v1 igtk[WOWLAN_IGTK_KEYS_NUM];
+	struct iwl_wowlan_igtk_status_v1 bigtk[WOWLAN_BIGTK_KEYS_NUM];
+	__le64 replay_ctr;
+	__le16 pattern_number;
+	__le16 qos_seq_ctr;
+	__le32 wakeup_reasons;
+	__le32 num_of_gtk_rekeys;
+	__le32 transmitted_ndps;
+	__le32 received_beacons;
+	u8 tid_tear_down;
+	u8 station_id;
+	u8 num_mlo_link_keys;
+	u8 tid_offloaded_tx;
+	struct iwl_wowlan_mlo_gtk mlo_gtks[];
+} __packed; /* WOWLAN_INFO_NTFY_API_S_VER_5 */
+
 /**
  * struct iwl_wowlan_info_notif - WoWLAN information notification
  * @gtk: GTK data
@@ -855,7 +953,7 @@ struct iwl_wowlan_info_notif_v3 {
  * @mlo_gtks: array of GTKs of size num_mlo_link_keys
  */
 struct iwl_wowlan_info_notif {
-	struct iwl_wowlan_gtk_status_v3 gtk[WOWLAN_GTK_KEYS_NUM];
+	struct iwl_wowlan_gtk_status gtk[WOWLAN_GTK_KEYS_NUM];
 	struct iwl_wowlan_igtk_status igtk[WOWLAN_IGTK_KEYS_NUM];
 	struct iwl_wowlan_igtk_status bigtk[WOWLAN_BIGTK_KEYS_NUM];
 	__le64 replay_ctr;
@@ -870,7 +968,7 @@ struct iwl_wowlan_info_notif {
 	u8 num_mlo_link_keys;
 	u8 tid_offloaded_tx;
 	struct iwl_wowlan_mlo_gtk mlo_gtks[];
-} __packed; /* WOWLAN_INFO_NTFY_API_S_VER_5 */
+} __packed; /* WOWLAN_INFO_NTFY_API_S_VER_6 */
 
 /**
  * struct iwl_wowlan_wake_pkt_notif - WoWLAN wake packet notification
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/offload.h b/drivers/net/wireless/intel/iwlwifi/fw/api/offload.h
index 2a1c2b0f19e4..bb801650a565 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/offload.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/offload.h
@@ -20,7 +20,7 @@ enum iwl_prot_offload_subcmd_ids {
 	/**
 	 * @WOWLAN_INFO_NOTIFICATION: Notification in
 	 * &struct iwl_wowlan_info_notif_v1, iwl_wowlan_info_notif_v3,
-	 * or &struct iwl_wowlan_info_notif
+	 * &struct iwl_wowlan_info_notif_v5 or &struct iwl_wowlan_info_notif
 	 */
 	WOWLAN_INFO_NOTIFICATION = 0xFD,
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/d3.c b/drivers/net/wireless/intel/iwlwifi/mld/d3.c
index f10732d31242..1d4282a21f09 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/d3.c
@@ -281,7 +281,7 @@ iwl_mld_convert_gtk_resume_seq(struct iwl_mld_mcast_key_data *gtk_data,
 static void
 iwl_mld_convert_gtk_resume_data(struct iwl_mld *mld,
 				struct iwl_mld_wowlan_status *wowlan_status,
-				const struct iwl_wowlan_gtk_status_v3 *gtk_data,
+				const struct iwl_wowlan_gtk_status *gtk_data,
 				const struct iwl_wowlan_all_rsc_tsc_v5 *sc)
 {
 	int status_idx = 0;
@@ -293,8 +293,9 @@ iwl_mld_convert_gtk_resume_data(struct iwl_mld *mld,
 	for (int notif_idx = 0; notif_idx < ARRAY_SIZE(wowlan_status->gtk);
 	     notif_idx++) {
 		int rsc_idx;
+		u8 key_status = gtk_data[notif_idx].key_status;
 
-		if (!(gtk_data[notif_idx].key_len))
+		if (!key_status)
 			continue;
 
 		wowlan_status->gtk[status_idx].len =
@@ -304,10 +305,6 @@ iwl_mld_convert_gtk_resume_data(struct iwl_mld *mld,
 		wowlan_status->gtk[status_idx].id =
 			wowlan_status->gtk[status_idx].flags &
 			IWL_WOWLAN_GTK_IDX_MASK;
-		memcpy(wowlan_status->gtk[status_idx].key,
-		       gtk_data[notif_idx].key,
-		       sizeof(gtk_data[notif_idx].key));
-
 		/* The rsc for both gtk keys are stored in gtk[0]->sc->mcast_rsc
 		 * The gtk ids can be any two numbers between 0 and 3,
 		 * the id_map maps between the key id and the index in sc->mcast
@@ -317,13 +314,27 @@ iwl_mld_convert_gtk_resume_data(struct iwl_mld *mld,
 		iwl_mld_convert_gtk_resume_seq(&wowlan_status->gtk[status_idx],
 					       sc, rsc_idx);
 
-		/* if it's as long as the TKIP encryption key, copy MIC key */
-		if (wowlan_status->gtk[status_idx].len ==
-		    NL80211_TKIP_DATA_OFFSET_TX_MIC_KEY)
-			memcpy(wowlan_status->gtk[status_idx].key +
-			       NL80211_TKIP_DATA_OFFSET_RX_MIC_KEY,
-			       gtk_data[notif_idx].tkip_mic_key,
-			       sizeof(gtk_data[notif_idx].tkip_mic_key));
+		if (key_status == IWL_WOWLAN_STATUS_NEW_KEY) {
+			memcpy(wowlan_status->gtk[status_idx].key,
+			       gtk_data[notif_idx].key,
+			       sizeof(gtk_data[notif_idx].key));
+
+			/* if it's as long as the TKIP encryption key,
+			 * copy MIC key
+			 */
+			if (wowlan_status->gtk[status_idx].len ==
+			    NL80211_TKIP_DATA_OFFSET_TX_MIC_KEY)
+				memcpy(wowlan_status->gtk[status_idx].key +
+				       NL80211_TKIP_DATA_OFFSET_RX_MIC_KEY,
+				       gtk_data[notif_idx].tkip_mic_key,
+				       sizeof(gtk_data[notif_idx].tkip_mic_key));
+		} else {
+			/* If the key status is WOWLAN_STATUS_OLD_KEY, it
+			 * indicates that no key material is present, Set the
+			 * key length to 0 as an indication
+			 */
+			wowlan_status->gtk[status_idx].len = 0;
+		}
 		status_idx++;
 	}
 }
@@ -370,11 +381,11 @@ static void
 iwl_mld_convert_igtk_resume_data(struct iwl_mld_wowlan_status *wowlan_status,
 				 const struct iwl_wowlan_igtk_status *igtk)
 {
-	BUILD_BUG_ON(sizeof(wowlan_status->igtk.key) < sizeof(igtk->key));
-
-	if (!igtk->key_len)
+	if (!igtk->key_status)
 		return;
 
+	BUILD_BUG_ON(sizeof(wowlan_status->igtk.key) < sizeof(igtk->key));
+
 	wowlan_status->igtk.len = igtk->key_len;
 	wowlan_status->igtk.flags = igtk->key_flags;
 	wowlan_status->igtk.id =
@@ -382,7 +393,15 @@ iwl_mld_convert_igtk_resume_data(struct iwl_mld_wowlan_status *wowlan_status,
 			     IWL_WOWLAN_IGTK_BIGTK_IDX_MASK) +
 		WOWLAN_IGTK_MIN_INDEX;
 
-	memcpy(wowlan_status->igtk.key, igtk->key, sizeof(igtk->key));
+	if (igtk->key_status == IWL_WOWLAN_STATUS_NEW_KEY)
+		memcpy(wowlan_status->igtk.key, igtk->key, sizeof(igtk->key));
+	else
+		/* If the key status is WOWLAN_STATUS_OLD_KEY, it indicates
+		 * that no key material is present. Set the key length to 0
+		 * as an indication.
+		 */
+		wowlan_status->igtk.len = 0;
+
 	iwl_mld_convert_mcast_ipn(&wowlan_status->igtk, igtk);
 }
 
@@ -396,7 +415,7 @@ iwl_mld_convert_bigtk_resume_data(struct iwl_mld_wowlan_status *wowlan_status,
 
 	for (int notif_idx = 0; notif_idx < WOWLAN_BIGTK_KEYS_NUM;
 	     notif_idx++) {
-		if (!bigtk[notif_idx].key_len)
+		if (!bigtk[notif_idx].key_status)
 			continue;
 
 		wowlan_status->bigtk[status_idx].len = bigtk[notif_idx].key_len;
@@ -409,8 +428,17 @@ iwl_mld_convert_bigtk_resume_data(struct iwl_mld_wowlan_status *wowlan_status,
 
 		BUILD_BUG_ON(sizeof(wowlan_status->bigtk[status_idx].key) <
 			     sizeof(bigtk[notif_idx].key));
-		memcpy(wowlan_status->bigtk[status_idx].key,
-		       bigtk[notif_idx].key, sizeof(bigtk[notif_idx].key));
+		if (bigtk[notif_idx].key_status == IWL_WOWLAN_STATUS_NEW_KEY)
+			memcpy(wowlan_status->bigtk[status_idx].key,
+			       bigtk[notif_idx].key,
+			       sizeof(bigtk[notif_idx].key));
+		else
+			/* If the key status is WOWLAN_STATUS_OLD_KEY, it
+			 * indicates that no key material is present. Set the
+			 * key length to 0 as an indication.
+			 */
+			wowlan_status->bigtk[status_idx].len = 0;
+
 		iwl_mld_convert_mcast_ipn(&wowlan_status->bigtk[status_idx],
 					  &bigtk[notif_idx]);
 		status_idx++;
@@ -453,34 +481,165 @@ iwl_mld_convert_mlo_keys(struct iwl_mld *mld,
 	}
 }
 
+static void
+iwl_mld_convert_wowlan_notif_v5(const struct iwl_wowlan_info_notif_v5 *notif_v5,
+				struct iwl_wowlan_info_notif *notif)
+{
+	/* Convert GTK from v3 to the new format */
+	BUILD_BUG_ON(ARRAY_SIZE(notif->gtk) != ARRAY_SIZE(notif_v5->gtk));
+
+	for (int i = 0; i < ARRAY_SIZE(notif_v5->gtk); i++) {
+		const struct iwl_wowlan_gtk_status_v3 *gtk_v3 = &notif_v5->gtk[i];
+		struct iwl_wowlan_gtk_status *gtk = &notif->gtk[i];
+
+		/* Copy key material and metadata */
+		BUILD_BUG_ON(sizeof(gtk->key) != sizeof(gtk_v3->key));
+		BUILD_BUG_ON(sizeof(gtk->tkip_mic_key) != sizeof(gtk_v3->tkip_mic_key));
+
+		memcpy(gtk->key, gtk_v3->key, sizeof(gtk_v3->key));
+
+		gtk->key_len = gtk_v3->key_len;
+		gtk->key_flags = gtk_v3->key_flags;
+
+		memcpy(gtk->tkip_mic_key, gtk_v3->tkip_mic_key,
+		       sizeof(gtk_v3->tkip_mic_key));
+		gtk->sc = gtk_v3->sc;
+
+		/* Set key_status based on whether key material is present.
+		 * in v5, a key is either invalid (should be skipped) or has
+		 * both meta data and the key itself.
+		 */
+		if (gtk_v3->key_len)
+			gtk->key_status = IWL_WOWLAN_STATUS_NEW_KEY;
+	}
+
+	/* Convert IGTK from v1 to the new format, only one IGTK is passed by FW */
+	BUILD_BUG_ON(offsetof(struct iwl_wowlan_igtk_status, key_status) !=
+		     sizeof(struct iwl_wowlan_igtk_status_v1));
+
+	memcpy(&notif->igtk[0], &notif_v5->igtk[0],
+	       offsetof(struct iwl_wowlan_igtk_status, key_status));
+
+	/* Set key_status based on whether key material is present.
+	 * in v5, a key is either invalid (should be skipped) or has
+	 * both meta data and the key itself.
+	 */
+	if (notif_v5->igtk[0].key_len)
+		notif->igtk[0].key_status = IWL_WOWLAN_STATUS_NEW_KEY;
+
+	/* Convert BIGTK from v1 to the new format */
+	BUILD_BUG_ON(ARRAY_SIZE(notif->bigtk) != ARRAY_SIZE(notif_v5->bigtk));
+
+	for (int i = 0; i < ARRAY_SIZE(notif_v5->bigtk); i++) {
+		/* Copy everything until key_status */
+		memcpy(&notif->bigtk[i], &notif_v5->bigtk[i],
+		       offsetof(struct iwl_wowlan_igtk_status, key_status));
+
+		/* Set key_status based on whether key material is present.
+		 * in v5, a key is either invalid (should be skipped) or has
+		 * both meta data and the key itself.
+		 */
+		if (notif_v5->bigtk[i].key_len)
+			notif->bigtk[i].key_status = IWL_WOWLAN_STATUS_NEW_KEY;
+	}
+
+	notif->replay_ctr = notif_v5->replay_ctr;
+	notif->pattern_number = notif_v5->pattern_number;
+	notif->qos_seq_ctr = notif_v5->qos_seq_ctr;
+	notif->wakeup_reasons = notif_v5->wakeup_reasons;
+	notif->num_of_gtk_rekeys = notif_v5->num_of_gtk_rekeys;
+	notif->transmitted_ndps = notif_v5->transmitted_ndps;
+	notif->received_beacons = notif_v5->received_beacons;
+	notif->tid_tear_down = notif_v5->tid_tear_down;
+	notif->station_id = notif_v5->station_id;
+	notif->num_mlo_link_keys = notif_v5->num_mlo_link_keys;
+	notif->tid_offloaded_tx = notif_v5->tid_offloaded_tx;
+
+	/* Copy MLO GTK keys */
+	if (notif_v5->num_mlo_link_keys) {
+		memcpy(notif->mlo_gtks, notif_v5->mlo_gtks,
+		       notif_v5->num_mlo_link_keys * sizeof(struct iwl_wowlan_mlo_gtk));
+	}
+}
+
+static bool iwl_mld_validate_wowlan_notif_size(struct iwl_mld *mld,
+					       u32 len,
+					       u32 expected_len,
+					       u8 num_mlo_keys,
+					       int version)
+{
+	u32 len_with_mlo_keys;
+
+	if (IWL_FW_CHECK(mld, len < expected_len,
+			 "Invalid wowlan_info_notif v%d (expected=%u got=%u)\n",
+			 version, expected_len, len))
+		return false;
+
+	len_with_mlo_keys = expected_len +
+		(num_mlo_keys * sizeof(struct iwl_wowlan_mlo_gtk));
+
+	if (IWL_FW_CHECK(mld, len < len_with_mlo_keys,
+			 "Invalid wowlan_info_notif v%d with MLO keys (expected=%u got=%u)\n",
+			 version, len_with_mlo_keys, len))
+		return false;
+
+	return true;
+}
+
 static bool
 iwl_mld_handle_wowlan_info_notif(struct iwl_mld *mld,
 				 struct iwl_mld_wowlan_status *wowlan_status,
 				 struct iwl_rx_packet *pkt)
 {
-	const struct iwl_wowlan_info_notif *notif = (void *)pkt->data;
+	const struct iwl_wowlan_info_notif *notif;
+	struct iwl_wowlan_info_notif *converted_notif __free(kfree) = NULL;
 	u32 len = iwl_rx_packet_payload_len(pkt);
-	u32 len_with_mlo_keys;
-
-	if (IWL_FW_CHECK(mld, len < sizeof(*notif),
-			 "Invalid wowlan_info_notif (expected=%zu got=%u)\n",
-			 sizeof(*notif), len))
-		return true;
-
-	/* Now that we know that we have at least sizeof(notif),
-	 * check also the variable length part
-	 */
-	len_with_mlo_keys = sizeof(*notif) +
-		notif->num_mlo_link_keys * sizeof(notif->mlo_gtks[0]);
+	int wowlan_info_ver = iwl_fw_lookup_notif_ver(mld->fw,
+						      PROT_OFFLOAD_GROUP,
+						      WOWLAN_INFO_NOTIFICATION,
+						      IWL_FW_CMD_VER_UNKNOWN);
+
+	if (wowlan_info_ver == 5) {
+		/* v5 format - validate before conversion */
+		const struct iwl_wowlan_info_notif_v5 *notif_v5 = (void *)pkt->data;
+
+		if (!iwl_mld_validate_wowlan_notif_size(mld, len,
+							sizeof(*notif_v5),
+							notif_v5->num_mlo_link_keys,
+							5))
+			return true;
+
+		converted_notif = kzalloc(struct_size(converted_notif,
+						      mlo_gtks,
+						      notif_v5->num_mlo_link_keys),
+					  GFP_ATOMIC);
+		if (!converted_notif) {
+			IWL_ERR(mld,
+				"Failed to allocate memory for converted wowlan_info_notif\n");
+			return true;
+		}
 
-	if (IWL_FW_CHECK(mld, len < len_with_mlo_keys,
-			 "Invalid wowlan_info_notif (expected=%ud got=%u)\n",
-			 len_with_mlo_keys, len))
+		iwl_mld_convert_wowlan_notif_v5(notif_v5,
+						converted_notif);
+		notif = converted_notif;
+	} else if (wowlan_info_ver == 6) {
+		notif = (void *)pkt->data;
+		if (!iwl_mld_validate_wowlan_notif_size(mld, len,
+							sizeof(*notif),
+							notif->num_mlo_link_keys,
+							6))
+			return true;
+	} else {
+		/* smaller versions are not supported */
+		IWL_WARN(mld,
+			 "Unsupported wowlan_info_notif version %d\n",
+			 wowlan_info_ver);
 		return true;
+	}
 
 	if (IWL_FW_CHECK(mld, notif->tid_offloaded_tx != IWL_WOWLAN_OFFLOAD_TID,
 			 "Invalid tid_offloaded_tx %d\n",
-			 wowlan_status->tid_offloaded_tx))
+			 notif->tid_offloaded_tx))
 		return true;
 
 	iwl_mld_convert_gtk_resume_data(mld, wowlan_status, notif->gtk,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index 431504195e33..07f1a84c274e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -2082,7 +2082,7 @@ static void iwl_mvm_convert_gtk_v3(struct iwl_wowlan_status_data *status,
 }
 
 static void iwl_mvm_convert_igtk(struct iwl_wowlan_status_data *status,
-				 struct iwl_wowlan_igtk_status *data)
+				 struct iwl_wowlan_igtk_status_v1 *data)
 {
 	int i;
 
@@ -2106,7 +2106,7 @@ static void iwl_mvm_convert_igtk(struct iwl_wowlan_status_data *status,
 }
 
 static void iwl_mvm_convert_bigtk(struct iwl_wowlan_status_data *status,
-				  const struct iwl_wowlan_igtk_status *data)
+				  const struct iwl_wowlan_igtk_status_v1 *data)
 {
 	int data_idx, status_idx = 0;
 
@@ -2137,7 +2137,7 @@ static void iwl_mvm_convert_bigtk(struct iwl_wowlan_status_data *status,
 }
 
 static void iwl_mvm_parse_wowlan_info_notif(struct iwl_mvm *mvm,
-					    struct iwl_wowlan_info_notif *data,
+					    struct iwl_wowlan_info_notif_v5 *data,
 					    struct iwl_wowlan_status_data *status,
 					    u32 len)
 {
@@ -2907,7 +2907,7 @@ static bool iwl_mvm_wait_d3_notif(struct iwl_notif_wait_data *notif_wait,
 			iwl_mvm_parse_wowlan_info_notif_v3(mvm, notif,
 							   d3_data->status, len);
 		} else if (wowlan_info_ver == 5) {
-			struct iwl_wowlan_info_notif *notif =
+			struct iwl_wowlan_info_notif_v5 *notif =
 				(void *)pkt->data;
 
 			iwl_mvm_parse_wowlan_info_notif(mvm, notif,
-- 
2.34.1


