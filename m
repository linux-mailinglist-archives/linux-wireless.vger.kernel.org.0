Return-Path: <linux-wireless+bounces-36467-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QCibGt0RB2rgrQIAu9opvQ
	(envelope-from <linux-wireless+bounces-36467-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 14:30:21 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D301D54F935
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 14:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 02F0030ED879
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 12:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21ADE47CC8E;
	Fri, 15 May 2026 12:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L35kGM6x"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B23D1A285
	for <linux-wireless@vger.kernel.org>; Fri, 15 May 2026 12:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778847008; cv=none; b=X4r7/zROloxVDq58J0/xZH0m0iE2LSzYMYh1GCtFTXcskdnBZAh+eil1X6HX7iySLavFWvwYFm4N4ZyiXQ0WHIuQUspPJteKH/5U8zplFc8NQ3L5Mmsrdw3Esxs/phlkUjH3F2+n6R1IndTW0EP4qD4YJDulbq5F7kfFHsCPQv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778847008; c=relaxed/simple;
	bh=gNwc0dosNMtTFxzmv6WOS18GGV3axZx67CqT9wqo8g4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Qpq4vUd5ThcNOMkZ+JZvyaiTqWk7Yjp6cQm9j+Bn9PiEasXmYlXzzMD4sunNSZiSP+ca0MEW/ZU91A73kzFgBvOYxr3g/yuhNgC9tSTEshrf4Kkn0NmgFEeuQF+rND87JxHb3E5PAprB3umkjYE7t0lMdaaeCmPeC0UThonWN5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L35kGM6x; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778847006; x=1810383006;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gNwc0dosNMtTFxzmv6WOS18GGV3axZx67CqT9wqo8g4=;
  b=L35kGM6xE7B53tebjUGzqwDuE83+xK/Hb2HJ8UKb9Oe+AnxqSQzTuymB
   3cBoxVfrHQ7/0cm7fSx5qzXGAt3soT6xxnR9VHDMsWtpX9aBBlJxBzLoe
   TPHI/Hhl22u+tPBWaLafGFpbSkhYsshnR8DCi7VE9ewPP1THVs2vNAOtE
   eQRxQWVgBw7Ep2ASddiDii/zbP6Ts5jKF6DKraAmG/V3qiBXyTvxGnRKi
   WhB5/uk55EUt9BA0k8Guhff4BCr+Ex13ns61RLwBW/K4RjxOIW6RyQoxP
   WLsXAKXQqI0nXV60lqSeT0RQ3nmRk0P3qHsWC0d2M4xZkSlj3/q/+YJ4N
   w==;
X-CSE-ConnectionGUID: u1u4M6NeRP+B3qxXkd1Zpg==
X-CSE-MsgGUID: vM8Ijw+ZRvaFIqMhGHUnhg==
X-IronPort-AV: E=McAfee;i="6800,10657,11786"; a="91185665"
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="91185665"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 05:10:06 -0700
X-CSE-ConnectionGUID: Qz//PUtcSMqMyONkSGjf9w==
X-CSE-MsgGUID: 0OEx9sLRQmmKvTA4sRUBtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="243649964"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 05:10:04 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Avraham Stern <avraham.stern@intel.com>
Subject: [PATCH v2 iwlwifi-next 02/15] wifi: iwlwifi: mld: add support for deferred nan schedule config
Date: Fri, 15 May 2026 15:09:35 +0300
Message-Id: <20260515150751.a69730d26890.I2ae54cbed8b507e6398a55c19795b27d5ea03aba@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260515120948.1157329-1-miriam.rachel.korenblit@intel.com>
References: <20260515120948.1157329-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D301D54F935
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-36467-lists,linux-wireless=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Avraham Stern <avraham.stern@intel.com>

Add support for deferred schedule update. Notify mac80211 that the
schedule update is done when the firmware notifies that the schedule
is applied.

Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../wireless/intel/iwlwifi/fw/api/mac-cfg.h   | 29 +++++++++++++
 drivers/net/wireless/intel/iwlwifi/mld/mld.c  |  1 +
 drivers/net/wireless/intel/iwlwifi/mld/nan.c  | 43 +++++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/mld/nan.h  |  5 +++
 .../net/wireless/intel/iwlwifi/mld/notif.c    |  4 ++
 5 files changed, 82 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h b/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
index d03a2bda4e68..09f869b5be0c 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
@@ -84,6 +84,11 @@ enum iwl_mac_conf_subcmd_ids {
 	 * @NAN_ULW_ATTR_NOTIF: &struct iwl_nan_ulw_attr_notif
 	 */
 	NAN_ULW_ATTR_NOTIF = 0xf2,
+	/**
+	 * @NAN_SCHED_UPDATE_COMPLETED_NOTIF:
+	 *	&struct iwl_nan_sched_update_completed_notif
+	 */
+	NAN_SCHED_UPDATE_COMPLETED_NOTIF = 0xf3,
 	/**
 	 * @NAN_DW_END_NOTIF: &struct iwl_nan_dw_end_notif
 	 */
@@ -1421,4 +1426,28 @@ struct iwl_nan_ulw_attr_notif {
 	u8 attr[IWL_NAN_MAX_ENDLESS_ULW_ATTR_LEN];
 } __packed; /* NAN_ULW_ATTR_NOTIF_API_S_VER_1 */
 
+/**
+ * enum iwl_nan_sched_update_status - NAN schedule update status
+ *
+ * @IWL_NAN_SCHED_UPDATE_SUCCESS: schedule update completed successfully
+ * @IWL_NAN_SCHED_UPDATE_FAILURE: schedule update failed. Currently not expected
+ *	to happen, but reserved for future use.
+ */
+enum iwl_nan_sched_update_status {
+	IWL_NAN_SCHED_UPDATE_SUCCESS = 0,
+	IWL_NAN_SCHED_UPDATE_FAILURE = 1,
+};
+
+/**
+ * struct iwl_nan_sched_update_completed_notif - NAN schedule update completed
+ *
+ * @status: status of the schedule update operation. See
+ *	&enum iwl_nan_sched_update_status
+ * @reserved: reserved
+ */
+struct iwl_nan_sched_update_completed_notif {
+	u8 status;
+	u8 reserved[3];
+} __packed; /* NAN_SCHED_UPDATE_COMPLETED_NTF_API_S_VER_1 */
+
 #endif /* __iwl_fw_api_mac_cfg_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mld.c b/drivers/net/wireless/intel/iwlwifi/mld/mld.c
index 054bb1134425..0ef7c24831d8 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mld.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mld.c
@@ -238,6 +238,7 @@ static const struct iwl_hcmd_names iwl_mld_mac_conf_names[] = {
 	HCMD_NAME(NAN_SCHEDULE_CMD),
 	HCMD_NAME(NAN_PEER_CMD),
 	HCMD_NAME(NAN_ULW_ATTR_NOTIF),
+	HCMD_NAME(NAN_SCHED_UPDATE_COMPLETED_NOTIF),
 	HCMD_NAME(NAN_DW_END_NOTIF),
 	HCMD_NAME(NAN_JOINED_CLUSTER_NOTIF),
 	HCMD_NAME(MISSED_BEACONS_NOTIF),
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/nan.c b/drivers/net/wireless/intel/iwlwifi/mld/nan.c
index d13b2374b642..d34a9a2cbeae 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/nan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/nan.c
@@ -689,11 +689,20 @@ void iwl_mld_nan_vif_cfg_changed(struct iwl_mld *mld,
 
 	switch (version) {
 	case 1:
+		if (sched_cfg->deferred) {
+			IWL_ERR(mld,
+				"NAN: deferred schedule not supported by FW\n");
+			return;
+		}
+
 		cmd_size = sizeof(struct iwl_nan_schedule_cmd_v1);
 		break;
 	case 2:
 		cmd_size = sizeof(struct iwl_nan_schedule_cmd);
 
+		if (sched_cfg->deferred)
+			cmd.deferred = 1;
+
 		if (sched_cfg->avail_blob_len &&
 		    !WARN_ON(sched_cfg->avail_blob_len >
 			     sizeof(cmd.avail_attr.attr))) {
@@ -869,6 +878,40 @@ void iwl_mld_nan_vif_cfg_changed(struct iwl_mld *mld,
 	}
 }
 
+bool iwl_mld_cancel_nan_sched_update_completed_notif(struct iwl_mld *mld,
+						     struct iwl_rx_packet *pkt,
+						     u32 obj_id)
+{
+	return true;
+}
+
+void iwl_mld_handle_nan_sched_update_completed_notif(struct iwl_mld *mld,
+						     struct iwl_rx_packet *pkt)
+{
+	struct iwl_nan_sched_update_completed_notif *notif = (void *)pkt->data;
+	struct ieee80211_vif *vif = mld->nan_device_vif;
+
+	if (IWL_FW_CHECK(mld, !vif,
+			 "NAN: schedule update completed without NAN vif\n"))
+		return;
+
+	if (IWL_FW_CHECK(mld, !ieee80211_vif_nan_started(vif),
+			 "NAN: schedule update completed without NAN started\n"))
+		return;
+
+	/*
+	 * Deferred schedule update should not fail in firmware since all
+	 * channels and links were added.
+	 */
+	IWL_FW_CHECK(mld, notif->status != IWL_NAN_SCHED_UPDATE_SUCCESS,
+		     "NAN: deferred schedule update failed\n");
+
+	if (WARN_ON(!vif->cfg.nan_sched.deferred))
+		return;
+
+	ieee80211_nan_sched_update_done(vif);
+}
+
 int iwl_mld_mac802111_nan_peer_sched_changed(struct ieee80211_hw *hw,
 					     struct ieee80211_sta *sta)
 {
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/nan.h b/drivers/net/wireless/intel/iwlwifi/mld/nan.h
index f4e4cd4b4e8d..5411bca52cde 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/nan.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/nan.h
@@ -42,6 +42,8 @@ void iwl_mld_handle_nan_ulw_attr_notif(struct iwl_mld *mld,
 				       struct iwl_rx_packet *pkt);
 void iwl_mld_handle_nan_dw_end_notif(struct iwl_mld *mld,
 				     struct iwl_rx_packet *pkt);
+void iwl_mld_handle_nan_sched_update_completed_notif(struct iwl_mld *mld,
+						     struct iwl_rx_packet *pkt);
 bool iwl_mld_cancel_nan_cluster_notif(struct iwl_mld *mld,
 				      struct iwl_rx_packet *pkt,
 				      u32 obj_id);
@@ -51,6 +53,9 @@ bool iwl_mld_cancel_nan_ulw_attr_notif(struct iwl_mld *mld,
 bool iwl_mld_cancel_nan_dw_end_notif(struct iwl_mld *mld,
 				     struct iwl_rx_packet *pkt,
 				     u32 obj_id);
+bool iwl_mld_cancel_nan_sched_update_completed_notif(struct iwl_mld *mld,
+						     struct iwl_rx_packet *pkt,
+						     u32 obj_id);
 void iwl_mld_nan_vif_cfg_changed(struct iwl_mld *mld,
 				 struct ieee80211_vif *vif,
 				 u64 changes);
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/notif.c b/drivers/net/wireless/intel/iwlwifi/mld/notif.c
index a5074bbc7e24..d7383022a0ed 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/notif.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/notif.c
@@ -348,6 +348,8 @@ CMD_VERSIONS(beacon_filter_notif, CMD_VER_ENTRY(2, iwl_beacon_filter_notif))
 CMD_VERSIONS(nan_cluster_notif, CMD_VER_ENTRY(1, iwl_nan_cluster_notif))
 CMD_VERSIONS(nan_ulw_attr_notif, CMD_VER_ENTRY(1, iwl_nan_ulw_attr_notif))
 CMD_VERSIONS(nan_dw_end_notif, CMD_VER_ENTRY(1, iwl_nan_dw_end_notif))
+CMD_VERSIONS(nan_sched_update_completed_notif,
+	     CMD_VER_ENTRY(1, iwl_nan_sched_update_completed_notif))
 
 DEFINE_SIMPLE_CANCELLATION(session_prot, iwl_session_prot_notif, mac_link_id)
 DEFINE_SIMPLE_CANCELLATION(tlc, iwl_tlc_update_notif, sta_id)
@@ -468,6 +470,8 @@ const struct iwl_rx_handler iwl_mld_rx_handlers[] = {
 			  nan_ulw_attr_notif)
 	RX_HANDLER_OF_NAN(MAC_CONF_GROUP, NAN_DW_END_NOTIF,
 			  nan_dw_end_notif)
+	RX_HANDLER_OF_NAN(MAC_CONF_GROUP, NAN_SCHED_UPDATE_COMPLETED_NOTIF,
+			  nan_sched_update_completed_notif)
 };
 EXPORT_SYMBOL_IF_IWLWIFI_KUNIT(iwl_mld_rx_handlers);
 
-- 
2.34.1


