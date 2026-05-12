Return-Path: <linux-wireless+bounces-36338-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IODCKG+BA2pB6gEAu9opvQ
	(envelope-from <linux-wireless+bounces-36338-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 21:37:19 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 036A7528B8F
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 21:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3CA1E30F7A05
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 19:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D40FE2E542C;
	Tue, 12 May 2026 19:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YGNdtMFV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7D2368D66
	for <linux-wireless@vger.kernel.org>; Tue, 12 May 2026 19:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778614509; cv=none; b=MUxtmvvlZ+5ryYWVi4XMktXhWn9zrDeq4BJhztRedInNyeSMzpc1WEnz+LJROIMBziM6h59jXIBfSxDIHIgY0qJNJEpEmPn5hKfYHwnZxrJuOMV0aMsax/WVczqDNOMyE7Ucn7CXKmA6E/WGlQMwsA6WJKeCe0z/ahx3UhuqFUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778614509; c=relaxed/simple;
	bh=JzgJCl/+Cp5aDKSFCpJtX+4BFYJWWrmzc7SUObjdK8c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Di616vBtdOP8HKIHJh4kCYl25/KJwN+0jSzmdhew0DYMiVUacKwcpdJvIUXiwjG5g/0Z0q6V5VimAdnDfFynOCEy473adO7+HzbMQ54KJzbhHKuWmwe9PEEwluMjsfax2sBtJxxv3AYEcgkigaPqnjHJZ/y+yDFYTURRU9XhQVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YGNdtMFV; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778614508; x=1810150508;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JzgJCl/+Cp5aDKSFCpJtX+4BFYJWWrmzc7SUObjdK8c=;
  b=YGNdtMFVkHANAiYt8zFTSVplvMD6YWLTXgb1WYI1Dcw2sOEWoR6Dkt44
   lAYKjk6q2XL2QQQKyTR7Qrexi3crlF8GCmRiXZQdi/5xM10JZzedhWr+A
   Gd1x7uGa22DDAHMyfSd+sawBcdG5UXF9Pglxtwc+PIEaeu0si75/yAWF2
   /wkhohXtn53W6LmodNfOMCf8J/rSdSUAnADP/KJkwNWggQaJ/hxN353hI
   LhKSr99vToGAgVTpNEqzvddecVIvioYBgsxIzJlplk/yzWWQTSi6JNKu5
   RDXRNJrWO6B0Ur8I3vOWF/gkDq8UhkH/8ImjQE4vz1ZrULst4OBjCY8ka
   w==;
X-CSE-ConnectionGUID: zhEWbe9XQXCdZAv5lYiY6w==
X-CSE-MsgGUID: R+koiSzcTFeSkRFKKgLEKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="83148796"
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="83148796"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 12:35:08 -0700
X-CSE-ConnectionGUID: YEjQyOzSSZ+G3wgLubnoOQ==
X-CSE-MsgGUID: LZN36cLuRZSXEreNS4gSlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="231471802"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 12:35:06 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH iwlwifi-next 11/15] wifi: iwlwifi: implement the new RSC notification
Date: Tue, 12 May 2026 22:34:37 +0300
Message-Id: <20260512222731.2c0cd8b43e67.I7cfee4b57e7f84b0d38667290f45ed5be4cdd270@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260512193441.2352467-1-miriam.rachel.korenblit@intel.com>
References: <20260512193441.2352467-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 036A7528B8F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-36338-lists,linux-wireless=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim]
X-Rspamd-Action: no action

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

Add support for a new RSC notification that arrives on DATA queues.
The same RSC handling previously done in the WOWLAN flow is now done
through this notification, with backward compatibility maintained.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../wireless/intel/iwlwifi/fw/api/datapath.h  |   9 +-
 drivers/net/wireless/intel/iwlwifi/mld/d3.c   | 148 ++++++++++++++++--
 drivers/net/wireless/intel/iwlwifi/mld/d3.h   |   6 +-
 .../net/wireless/intel/iwlwifi/mld/iface.c    |   4 +-
 drivers/net/wireless/intel/iwlwifi/mld/mld.c  |   1 +
 .../net/wireless/intel/iwlwifi/mld/notif.c    |   6 +
 drivers/net/wireless/intel/iwlwifi/mld/rx.c   |  22 +++
 drivers/net/wireless/intel/iwlwifi/mld/rx.h   |   5 +-
 8 files changed, 183 insertions(+), 18 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/datapath.h b/drivers/net/wireless/intel/iwlwifi/fw/api/datapath.h
index 06370c161fe4..e494e5b18d22 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/datapath.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/datapath.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2024-2025 Intel Corporation
+ * Copyright (C) 2024-2026 Intel Corporation
  * Copyright (C) 2012-2014, 2018-2022 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
@@ -91,6 +91,13 @@ enum iwl_data_path_subcmd_ids {
 	 */
 	SEC_KEY_CMD = 0x18,
 
+	/**
+	 * @RSC_NOTIF: notification to update each Rx queue with the RSC. This
+	 *	notification is sent after resume and uses
+	 *	&struct iwl_wowlan_all_rsc_tsc_v5.
+	 */
+	RSC_NOTIF = 0xF1,
+
 	/**
 	 * @ESR_MODE_NOTIF: notification to recommend/force a wanted esr mode,
 	 *	uses &struct iwl_esr_mode_notif or &struct iwl_esr_mode_notif_v1
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/d3.c b/drivers/net/wireless/intel/iwlwifi/mld/d3.c
index c44f02f225ce..ca4222a9a6ff 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/d3.c
@@ -43,6 +43,12 @@ struct iwl_mld_resume_key_iter_data {
 	struct iwl_mld_wowlan_status *wowlan_status;
 };
 
+struct iwl_mld_rsc_resume_iter_data {
+	struct iwl_mld *mld;
+	const struct iwl_wowlan_all_rsc_tsc_v5 *notif;
+	int queue;
+};
+
 struct iwl_mld_suspend_key_iter_data {
 	struct iwl_wowlan_rsc_tsc_params_cmd *rsc;
 	bool have_rsc;
@@ -282,7 +288,8 @@ static void
 iwl_mld_convert_gtk_resume_data(struct iwl_mld *mld,
 				struct iwl_mld_wowlan_status *wowlan_status,
 				const struct iwl_wowlan_gtk_status *gtk_data,
-				const struct iwl_wowlan_all_rsc_tsc_v5 *sc)
+				const struct iwl_wowlan_all_rsc_tsc_v5 *sc,
+				int rsc_notif_ver)
 {
 	int status_idx = 0;
 
@@ -305,14 +312,18 @@ iwl_mld_convert_gtk_resume_data(struct iwl_mld *mld,
 		wowlan_status->gtk[status_idx].id =
 			wowlan_status->gtk[status_idx].flags &
 			IWL_WOWLAN_GTK_IDX_MASK;
-		/* The rsc for both gtk keys are stored in gtk[0]->sc->mcast_rsc
-		 * The gtk ids can be any two numbers between 0 and 3,
-		 * the id_map maps between the key id and the index in sc->mcast
-		 */
-		rsc_idx =
-			sc->mcast_key_id_map[wowlan_status->gtk[status_idx].id];
-		iwl_mld_convert_gtk_resume_seq(&wowlan_status->gtk[status_idx],
-					       sc, rsc_idx);
+		/* If RSC_NOTIF is not supported */
+		if (rsc_notif_ver == IWL_FW_CMD_VER_UNKNOWN) {
+			/* The rsc for both gtk keys are stored in
+			 * gtk[0]->sc->mcast_rsc. The gtk ids can be any two
+			 * numbers between 0 and 3, the id_map maps between the
+			 * key id and the index in sc->mcast
+			 */
+			rsc_idx =
+				sc->mcast_key_id_map[wowlan_status->gtk[status_idx].id];
+			iwl_mld_convert_gtk_resume_seq(&wowlan_status->gtk[status_idx],
+						       sc, rsc_idx);
+		}
 
 		if (key_status == IWL_WOWLAN_STATUS_NEW_KEY) {
 			memcpy(wowlan_status->gtk[status_idx].key,
@@ -598,6 +609,10 @@ iwl_mld_handle_wowlan_info_notif(struct iwl_mld *mld,
 						      PROT_OFFLOAD_GROUP,
 						      WOWLAN_INFO_NOTIFICATION,
 						      IWL_FW_CMD_VER_UNKNOWN);
+	int rsc_notif_ver = iwl_fw_lookup_notif_ver(mld->fw,
+						    DATA_PATH_GROUP,
+						    RSC_NOTIF,
+						    IWL_FW_CMD_VER_UNKNOWN);
 
 	if (wowlan_info_ver == 5) {
 		/* v5 format - validate before conversion */
@@ -642,8 +657,10 @@ iwl_mld_handle_wowlan_info_notif(struct iwl_mld *mld,
 		return true;
 
 	iwl_mld_convert_gtk_resume_data(mld, wowlan_status, notif->gtk,
-					&notif->gtk[0].sc);
-	iwl_mld_convert_ptk_resume_seq(mld, wowlan_status, &notif->gtk[0].sc);
+					&notif->gtk[0].sc, rsc_notif_ver);
+	if (rsc_notif_ver == IWL_FW_CMD_VER_UNKNOWN)
+		iwl_mld_convert_ptk_resume_seq(mld, wowlan_status,
+					       &notif->gtk[0].sc);
 	/* only one igtk is passed by FW */
 	iwl_mld_convert_igtk_resume_data(wowlan_status, &notif->igtk[0]);
 	iwl_mld_convert_bigtk_resume_data(wowlan_status, notif->bigtk);
@@ -902,8 +919,14 @@ iwl_mld_resume_keys_iter(struct ieee80211_hw *hw,
 	struct iwl_mld_resume_key_iter_data *data = _data;
 	struct iwl_mld_wowlan_status *wowlan_status = data->wowlan_status;
 	u8 status_idx;
-
-	if (key->keyidx >= 0 && key->keyidx <= 3) {
+	int rsc_notif_ver = iwl_fw_lookup_notif_ver(data->mld->fw,
+						    DATA_PATH_GROUP,
+						    RSC_NOTIF,
+						    IWL_FW_CMD_VER_UNKNOWN);
+
+	/* If RSC_NOTIF is not supported */
+	if (rsc_notif_ver == IWL_FW_CMD_VER_UNKNOWN &&
+	    key->keyidx >= 0 && key->keyidx <= 3) {
 		/* PTK */
 		if (sta) {
 			iwl_mld_update_ptk_rx_seq(data->mld, wowlan_status,
@@ -932,6 +955,105 @@ iwl_mld_resume_keys_iter(struct ieee80211_hw *hw,
 	}
 }
 
+static void
+iwl_mld_rsc_update_key_iter(struct ieee80211_hw *hw,
+			    struct ieee80211_vif *vif,
+			    struct ieee80211_sta *sta,
+			    struct ieee80211_key_conf *key,
+			    void *_data)
+{
+	struct iwl_mld_rsc_resume_iter_data *data = _data;
+	struct ieee80211_key_seq seq;
+
+	if (key->keyidx > 3)
+		return;
+
+	if (sta) {
+		/* PTK */
+		BUILD_BUG_ON(ARRAY_SIZE(data->notif->ucast_rsc) !=
+			     IWL_MAX_TID_COUNT);
+
+		if (key->cipher == WLAN_CIPHER_SUITE_TKIP) {
+			/* TKIP: just update key sequences */
+			for (int tid = 0; tid < IWL_MAX_TID_COUNT; tid++) {
+				iwl_mld_le64_to_tkip_seq(data->notif->ucast_rsc[tid],
+							 &seq);
+				ieee80211_set_key_rx_seq(key, tid, &seq);
+			}
+		} else {
+			struct iwl_mld_sta *mld_sta = iwl_mld_sta_from_mac80211(sta);
+			struct iwl_mld_ptk_pn *mld_ptk_pn =
+				rcu_dereference_wiphy(data->mld->wiphy,
+						      mld_sta->ptk_pn[key->keyidx]);
+
+			if (WARN_ON(!mld_ptk_pn))
+				return;
+
+			if (WARN_ON(data->queue >=
+				    data->mld->trans->info.num_rxqs))
+				return;
+
+			for (int tid = 0; tid < IWL_MAX_TID_COUNT; tid++) {
+				iwl_mld_le64_to_aes_seq(data->notif->ucast_rsc[tid],
+							&seq);
+				ieee80211_set_key_rx_seq(key, tid, &seq);
+				memcpy(mld_ptk_pn->q[data->queue].pn[tid],
+				       seq.ccmp.pn,
+				       IEEE80211_CCMP_PN_LEN);
+			}
+		}
+
+		IWL_DEBUG_WOWLAN(data->mld,
+				 "Updated PTK RSC for key %d on queue %d\n",
+				 key->keyidx, data->queue);
+	} else {
+		/* GTK */
+		int rsc_idx = data->notif->mcast_key_id_map[key->keyidx];
+
+		if (rsc_idx == IWL_MCAST_KEY_MAP_INVALID)
+			return;
+
+		if (IWL_FW_CHECK(data->mld,
+				 rsc_idx >= ARRAY_SIZE(data->notif->mcast_rsc),
+				 "Invalid mcast key mapping: %d for key %d\n",
+				 rsc_idx, key->keyidx))
+			return;
+
+		for (int tid = 0; tid < IWL_MAX_TID_COUNT; tid++) {
+			__le64 rsc =
+				data->notif->mcast_rsc[rsc_idx][tid];
+
+			if (key->cipher == WLAN_CIPHER_SUITE_TKIP)
+				iwl_mld_le64_to_tkip_seq(rsc, &seq);
+			else
+				iwl_mld_le64_to_aes_seq(rsc, &seq);
+			ieee80211_set_key_rx_seq(key, tid, &seq);
+		}
+
+		IWL_DEBUG_WOWLAN(data->mld,
+				 "Updated GTK %d RSC (rsc_idx %d) on queue %d\n",
+				 key->keyidx, rsc_idx, data->queue);
+	}
+}
+
+void
+iwl_mld_process_rsc_notification(struct iwl_mld *mld,
+				 struct ieee80211_vif *vif,
+				 const struct iwl_wowlan_all_rsc_tsc_v5 *notif,
+				 int queue)
+{
+	struct iwl_mld_rsc_resume_iter_data iter_data = {
+		.mld = mld,
+		.notif = notif,
+		.queue = queue,
+	};
+
+	/* Iterate through all active keys and update RSC */
+	ieee80211_iter_keys_rcu(mld->hw, vif,
+				iwl_mld_rsc_update_key_iter,
+				&iter_data);
+}
+
 static void
 iwl_mld_add_mcast_rekey(struct ieee80211_vif *vif,
 			struct iwl_mld *mld,
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/d3.h b/drivers/net/wireless/intel/iwlwifi/mld/d3.h
index 618d6fb3c796..c2e8ba877042 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/d3.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/d3.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2024 Intel Corporation
+ * Copyright (C) 2024, 2026 Intel Corporation
  */
 #ifndef __iwl_mld_d3_h__
 #define __iwl_mld_d3_h__
@@ -42,6 +42,10 @@ int iwl_mld_wowlan_resume(struct iwl_mld *mld);
 void iwl_mld_set_rekey_data(struct ieee80211_hw *hw,
 			    struct ieee80211_vif *vif,
 			    struct cfg80211_gtk_rekey_data *data);
+void iwl_mld_process_rsc_notification(struct iwl_mld *mld,
+				      struct ieee80211_vif *vif,
+				      const struct iwl_wowlan_all_rsc_tsc_v5 *notif,
+				      int queue);
 #if IS_ENABLED(CONFIG_IPV6)
 void iwl_mld_ipv6_addr_change(struct ieee80211_hw *hw,
 			      struct ieee80211_vif *vif,
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/iface.c b/drivers/net/wireless/intel/iwlwifi/mld/iface.c
index 4fe57d79daa6..6f2590f9a69b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/iface.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/iface.c
@@ -853,6 +853,6 @@ struct ieee80211_vif *iwl_mld_get_bss_vif(struct iwl_mld *mld)
 
 	fw_id = __ffs(fw_id_bitmap);
 
-	return wiphy_dereference(mld->wiphy,
-				 mld->fw_id_to_vif[fw_id]);
+	return rcu_dereference_wiphy(mld->wiphy,
+				     mld->fw_id_to_vif[fw_id]);
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mld.c b/drivers/net/wireless/intel/iwlwifi/mld/mld.c
index 25bab6ab6375..3caa76b9b2cb 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mld.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mld.c
@@ -260,6 +260,7 @@ static const struct iwl_hcmd_names iwl_mld_data_path_names[] = {
 	HCMD_NAME(RX_BAID_ALLOCATION_CONFIG_CMD),
 	HCMD_NAME(SCD_QUEUE_CONFIG_CMD),
 	HCMD_NAME(SEC_KEY_CMD),
+	HCMD_NAME(RSC_NOTIF),
 	HCMD_NAME(ESR_MODE_NOTIF),
 	HCMD_NAME(MONITOR_NOTIF),
 	HCMD_NAME(TLC_MNG_UPDATE_NOTIF),
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/notif.c b/drivers/net/wireless/intel/iwlwifi/mld/notif.c
index 1c81152042ab..14834395de3a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/notif.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/notif.c
@@ -599,6 +599,9 @@ void iwl_mld_rx(struct iwl_op_mode *op_mode, struct napi_struct *napi,
 	else if (unlikely(cmd_id == WIDE_ID(DATA_PATH_GROUP,
 					    RX_QUEUES_NOTIFICATION)))
 		iwl_mld_handle_rx_queues_sync_notif(mld, napi, pkt, 0);
+	else if (unlikely(cmd_id == WIDE_ID(DATA_PATH_GROUP,
+					    RSC_NOTIF)))
+		iwl_mld_handle_rsc_notif(mld, pkt, 0);
 	else if (cmd_id == WIDE_ID(DATA_PATH_GROUP, PHY_AIR_SNIFFER_NOTIF))
 		iwl_mld_handle_phy_air_sniffer_notif(mld, napi, pkt);
 	else
@@ -622,6 +625,9 @@ void iwl_mld_rx_rss(struct iwl_op_mode *op_mode, struct napi_struct *napi,
 		iwl_mld_handle_rx_queues_sync_notif(mld, napi, pkt, queue);
 	else if (unlikely(cmd_id == WIDE_ID(LEGACY_GROUP, FRAME_RELEASE)))
 		iwl_mld_handle_frame_release_notif(mld, napi, pkt, queue);
+	else if (unlikely(cmd_id == WIDE_ID(DATA_PATH_GROUP,
+					    RSC_NOTIF)))
+		iwl_mld_handle_rsc_notif(mld, pkt, queue);
 }
 
 void iwl_mld_delete_handlers(struct iwl_mld *mld, const u16 *cmds, int n_cmds)
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/rx.c b/drivers/net/wireless/intel/iwlwifi/mld/rx.c
index 01603dc07f0a..7e023fe51e3b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/rx.c
@@ -2260,6 +2260,28 @@ void iwl_mld_handle_rx_queues_sync_notif(struct iwl_mld *mld,
 		wake_up(&mld->rxq_sync.waitq);
 }
 
+void iwl_mld_handle_rsc_notif(struct iwl_mld *mld,
+			      struct iwl_rx_packet *pkt, int queue)
+{
+	const struct iwl_wowlan_all_rsc_tsc_v5 *notif = (void *)pkt->data;
+	u32 len = iwl_rx_packet_payload_len(pkt);
+	struct ieee80211_vif *bss_vif;
+
+	if (IWL_FW_CHECK(mld, len != sizeof(*notif),
+			 "invalid notification size %u (%zu)\n",
+			 len, sizeof(*notif)))
+		return;
+
+	/* for the bss lookup and updating the keys' pn */
+	guard(rcu)();
+
+	bss_vif = iwl_mld_get_bss_vif(mld);
+	if (WARN_ON(!bss_vif))
+		return;
+
+	iwl_mld_process_rsc_notification(mld, bss_vif, notif, queue);
+}
+
 static void iwl_mld_no_data_rx(struct iwl_mld *mld,
 			       struct napi_struct *napi,
 			       struct iwl_rx_phy_air_sniffer_ntfy *ntfy)
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/rx.h b/drivers/net/wireless/intel/iwlwifi/mld/rx.h
index 09dddbd40f55..f7ef70e69143 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/rx.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/rx.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2024-2025 Intel Corporation
+ * Copyright (C) 2024-2026 Intel Corporation
  */
 #ifndef __iwl_mld_rx_h__
 #define __iwl_mld_rx_h__
@@ -61,6 +61,9 @@ void iwl_mld_handle_rx_queues_sync_notif(struct iwl_mld *mld,
 					 struct napi_struct *napi,
 					 struct iwl_rx_packet *pkt, int queue);
 
+void iwl_mld_handle_rsc_notif(struct iwl_mld *mld,
+			      struct iwl_rx_packet *pkt, int queue);
+
 void iwl_mld_pass_packet_to_mac80211(struct iwl_mld *mld,
 				     struct napi_struct *napi,
 				     struct sk_buff *skb, int queue,
-- 
2.34.1


