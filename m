Return-Path: <linux-wireless+bounces-36362-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SLPiF9APBGoMDAIAu9opvQ
	(envelope-from <linux-wireless+bounces-36362-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 13 May 2026 07:44:48 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A786F52DAFB
	for <lists+linux-wireless@lfdr.de>; Wed, 13 May 2026 07:44:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 213B93081B0F
	for <lists+linux-wireless@lfdr.de>; Wed, 13 May 2026 05:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 995073A6F0D;
	Wed, 13 May 2026 05:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SVkZxzuG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA56D2030A
	for <linux-wireless@vger.kernel.org>; Wed, 13 May 2026 05:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778651064; cv=none; b=i/UBnyr3rbE056lqV8RmdlGsIXpGXyoJ1sanx9UuymQox8paF83aIMD25HR0LULDZrSmBueJwZdgxkGHwCePFOV9xjNpqMErPLL1LTlqVE/QmAaY0QnNYg+10V3KTP01Wyp91Qh0sHkLCrO3uNb34rxXX4/CjwfXwFQVSwd8hTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778651064; c=relaxed/simple;
	bh=0qeK/b+0M97BkKnRGtfl7HHdnuMls4uiYbwKQ1WoV5E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VM3YsnEDrnDJP2GhmWHtGwq8LPtvvebXcqlu51EwK6UTlXR1qx5hGVTfKO071ywgN9coTqH6/tSh6JOPsNWV0Sv+u2ozV9LN4eJFyIYoxCoZNVjIx+Im8LhXDqOsNDIPrdpbRZhlNBS/jyrKDeHYqw7bqmy1oSrZzwzPCCzRyxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SVkZxzuG; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778651063; x=1810187063;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0qeK/b+0M97BkKnRGtfl7HHdnuMls4uiYbwKQ1WoV5E=;
  b=SVkZxzuGorifYLETYkV08G/rrW/Ngj6JXa6sSvGuPI/Ekm8VeRp5/WrT
   3ODZqkp98/hwbBMYPT61ZlAddOtRIVsYgY3hqcoIIQHFU40aPF6q4CHGI
   Oh+TlQ9HtK/aLzdA7pRFzyPpc3zh1Fe7ooz/f8GYXTAjKQAgU1vSlj4cV
   ts98pj4zac0IzXLhJtaUxa2CW+MoHVJ6alz0+MFEzI1hHywLu+nfM2a+n
   zvsNuzSKwMVJSDx015anjam6yHuHby7lCaGfc74hgUWs2z5Y0gR/ALKxL
   mQZ0HuJwmo1/iLIeVbsEx6hVoYkZ3KmmK+XoZpntv85Vecm83RLM5I9Au
   g==;
X-CSE-ConnectionGUID: omh/6o5yQ9GL3NNGtLnEHg==
X-CSE-MsgGUID: 2dwe3PwEQIqbSFmKeG9T8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="79552811"
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="79552811"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 22:44:23 -0700
X-CSE-ConnectionGUID: HyXDjDvXTiaAvIV5clo1FA==
X-CSE-MsgGUID: mQsODmnqS2ihN6IJdhpTcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="238077918"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 22:44:21 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Avraham Stern <avraham.stern@intel.com>
Subject: [PATCH iwlwifi-next 05/15] wifi: iwlwifi: mld: add handler for NAN ULW attribute notification
Date: Wed, 13 May 2026 08:43:52 +0300
Message-Id: <20260513084215.76d980e195a7.Ide4aaf4553a3980e6990485cd37204a922c36913@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260513054402.2897702-1-miriam.rachel.korenblit@intel.com>
References: <20260513054402.2897702-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A786F52DAFB
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
	TAGGED_FROM(0.00)[bounces-36362-lists,linux-wireless=lfdr.de];
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

From: Avraham Stern <avraham.stern@intel.com>

When a notification about a new ULW attribute arrives, send it to
user space so the ULW attribute can be added to the relevant frames
(e.g. SDF).

Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../wireless/intel/iwlwifi/fw/api/mac-cfg.h   | 20 +++++++++++
 drivers/net/wireless/intel/iwlwifi/mld/mld.c  |  1 +
 drivers/net/wireless/intel/iwlwifi/mld/nan.c  | 33 +++++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/mld/nan.h  |  5 +++
 .../net/wireless/intel/iwlwifi/mld/notif.c    |  3 ++
 5 files changed, 62 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h b/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
index 1df81df5830e..dde6cfd9d286 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
@@ -80,6 +80,10 @@ enum iwl_mac_conf_subcmd_ids {
 	 * @NAN_PEER_CMD: &struct iwl_nan_peer_cmd
 	 */
 	NAN_PEER_CMD = 0x14,
+	/**
+	 * @NAN_ULW_ATTR_NOTIF: &struct iwl_nan_ulw_attr_notif
+	 */
+	NAN_ULW_ATTR_NOTIF = 0xf2,
 	/**
 	 * @NAN_DW_END_NOTIF: &struct iwl_nan_dw_end_notif
 	 */
@@ -1393,4 +1397,20 @@ struct iwl_nan_dw_end_notif {
 	u8 reserved[3];
 } __packed; /* NAN_DW_END_NTF_API_S_VER_1 */
 
+#define IWL_NAN_MAX_ENDLESS_ULW_ATTR_LEN	48
+
+/**
+ * struct iwl_nan_ulw_attr_notif - sent to notify the host of a change in the
+ *	ULW attribute
+ *
+ * @attr_len: length of the ULW attribute in bytes
+ * @reserved: reserved
+ * @attr: the ULW attribute including the attribute header
+ */
+struct iwl_nan_ulw_attr_notif {
+	u8 attr_len;
+	u8 reserved[3];
+	u8 attr[IWL_NAN_MAX_ENDLESS_ULW_ATTR_LEN];
+} __packed; /* NAN_ULW_ATTR_NOTIF_API_S_VER_1 */
+
 #endif /* __iwl_fw_api_mac_cfg_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mld.c b/drivers/net/wireless/intel/iwlwifi/mld/mld.c
index 3caa76b9b2cb..054bb1134425 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mld.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mld.c
@@ -237,6 +237,7 @@ static const struct iwl_hcmd_names iwl_mld_mac_conf_names[] = {
 	HCMD_NAME(NAN_CFG_CMD),
 	HCMD_NAME(NAN_SCHEDULE_CMD),
 	HCMD_NAME(NAN_PEER_CMD),
+	HCMD_NAME(NAN_ULW_ATTR_NOTIF),
 	HCMD_NAME(NAN_DW_END_NOTIF),
 	HCMD_NAME(NAN_JOINED_CLUSTER_NOTIF),
 	HCMD_NAME(MISSED_BEACONS_NOTIF),
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/nan.c b/drivers/net/wireless/intel/iwlwifi/mld/nan.c
index 351c726be51f..8f35687c58b1 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/nan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/nan.c
@@ -353,6 +353,39 @@ bool iwl_mld_cancel_nan_dw_end_notif(struct iwl_mld *mld,
 	return true;
 }
 
+bool iwl_mld_cancel_nan_ulw_attr_notif(struct iwl_mld *mld,
+				       struct iwl_rx_packet *pkt,
+				       u32 obj_id)
+{
+	return true;
+}
+
+void iwl_mld_handle_nan_ulw_attr_notif(struct iwl_mld *mld,
+				       struct iwl_rx_packet *pkt)
+{
+	struct iwl_nan_ulw_attr_notif *notif = (void *)pkt->data;
+	struct wireless_dev *wdev;
+
+	IWL_DEBUG_INFO(mld, "NAN: ULW attr update: len=%u\n", notif->attr_len);
+
+	if (IWL_FW_CHECK(mld, !mld->nan_device_vif,
+			 "NAN: ULW attr update without NAN vif\n"))
+		return;
+
+	if (IWL_FW_CHECK(mld, !ieee80211_vif_nan_started(mld->nan_device_vif),
+			 "NAN: ULW attr update without NAN started\n"))
+		return;
+
+	if (IWL_FW_CHECK(mld,
+			 notif->attr_len > IWL_NAN_MAX_ENDLESS_ULW_ATTR_LEN,
+			 "NAN: ULW attr update invalid len %u\n",
+			 notif->attr_len))
+		return;
+
+	wdev = ieee80211_vif_to_wdev(mld->nan_device_vif);
+	cfg80211_nan_ulw_update(wdev, notif->attr, notif->attr_len, GFP_KERNEL);
+}
+
 void iwl_mld_handle_nan_dw_end_notif(struct iwl_mld *mld,
 				     struct iwl_rx_packet *pkt)
 {
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/nan.h b/drivers/net/wireless/intel/iwlwifi/mld/nan.h
index caa98dbb4a75..40152dc7d906 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/nan.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/nan.h
@@ -38,11 +38,16 @@ int iwl_mld_stop_nan(struct ieee80211_hw *hw,
 		     struct ieee80211_vif *vif);
 void iwl_mld_handle_nan_cluster_notif(struct iwl_mld *mld,
 				      struct iwl_rx_packet *pkt);
+void iwl_mld_handle_nan_ulw_attr_notif(struct iwl_mld *mld,
+				       struct iwl_rx_packet *pkt);
 void iwl_mld_handle_nan_dw_end_notif(struct iwl_mld *mld,
 				     struct iwl_rx_packet *pkt);
 bool iwl_mld_cancel_nan_cluster_notif(struct iwl_mld *mld,
 				      struct iwl_rx_packet *pkt,
 				      u32 obj_id);
+bool iwl_mld_cancel_nan_ulw_attr_notif(struct iwl_mld *mld,
+				       struct iwl_rx_packet *pkt,
+				       u32 obj_id);
 bool iwl_mld_cancel_nan_dw_end_notif(struct iwl_mld *mld,
 				     struct iwl_rx_packet *pkt,
 				     u32 obj_id);
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/notif.c b/drivers/net/wireless/intel/iwlwifi/mld/notif.c
index 14834395de3a..75adc9651736 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/notif.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/notif.c
@@ -346,6 +346,7 @@ CMD_VERSIONS(time_sync_confirm_notif,
 CMD_VERSIONS(ftm_resp_notif, CMD_VER_ENTRY(10, iwl_tof_range_rsp_ntfy))
 CMD_VERSIONS(beacon_filter_notif, CMD_VER_ENTRY(2, iwl_beacon_filter_notif))
 CMD_VERSIONS(nan_cluster_notif, CMD_VER_ENTRY(1, iwl_nan_cluster_notif))
+CMD_VERSIONS(nan_ulw_attr_notif, CMD_VER_ENTRY(1, iwl_nan_ulw_attr_notif))
 CMD_VERSIONS(nan_dw_end_notif, CMD_VER_ENTRY(1, iwl_nan_dw_end_notif))
 
 DEFINE_SIMPLE_CANCELLATION(session_prot, iwl_session_prot_notif, mac_link_id)
@@ -463,6 +464,8 @@ const struct iwl_rx_handler iwl_mld_rx_handlers[] = {
 			      ftm_resp_notif)
 	RX_HANDLER_OF_NAN(MAC_CONF_GROUP, NAN_JOINED_CLUSTER_NOTIF,
 			  nan_cluster_notif)
+	RX_HANDLER_OF_NAN(MAC_CONF_GROUP, NAN_ULW_ATTR_NOTIF,
+			  nan_ulw_attr_notif)
 	RX_HANDLER_OF_NAN(MAC_CONF_GROUP, NAN_DW_END_NOTIF,
 			  nan_dw_end_notif)
 };
-- 
2.34.1


