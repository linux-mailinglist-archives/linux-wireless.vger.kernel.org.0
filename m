Return-Path: <linux-wireless+bounces-36150-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WGccFQnRAGoMNAEAu9opvQ
	(envelope-from <linux-wireless+bounces-36150-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 10 May 2026 20:40:09 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B0A505B94
	for <lists+linux-wireless@lfdr.de>; Sun, 10 May 2026 20:40:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AAA0830058E4
	for <lists+linux-wireless@lfdr.de>; Sun, 10 May 2026 18:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56664313522;
	Sun, 10 May 2026 18:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jJMLie8R"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A143002A0
	for <linux-wireless@vger.kernel.org>; Sun, 10 May 2026 18:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778438400; cv=none; b=gfa9JudQePdaLvv0xh6fYP4gTTnC4vuoK1B4Y6KYA6pCuMg/OdU2UEezFU0qritOavWkkRIRLvNeIT084VwWiWnD9wpyfS9F4z0oStHgiwhT4WDGmuk9/k1LgmzwkRBwMPJeqkloGsiswwyX+mlChSzFnFKmM8c3Wz5XNNmX4hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778438400; c=relaxed/simple;
	bh=mxeCko/rSefmibJOmRwa3kSxv1JkqBrXHTQDSWP5BE8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pJY2NEmWe7eJhmiR54WjCJjssMaoDwI6LQ4pny5WBO9s6T4rGKHrJ8N0jMgzCRqOLtyU58m6ZLaGeQ0ehPklp71aEUFUmjEc7JsP5Rpq+wFOIzY1nMVExzrPAcKRIgAyiI9wzS2hC2rOR94UZVSBPrLfpspKCwsj+E92+Nsz12s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jJMLie8R; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778438398; x=1809974398;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mxeCko/rSefmibJOmRwa3kSxv1JkqBrXHTQDSWP5BE8=;
  b=jJMLie8RWvMoALVHzAPMuLOA6oDkK1Q3pK4E3s5T42FpCbg8oxJDNZHO
   oxDHqxKYwGPRj7iooCrntjMdbqJAnHlPPN8iEw/5AbOFTWOUU6fr0zLKp
   fK//+9UTQuMpQpoGY7kzceHWrF6zSt4r0PpUK1uFTi4L4yix3r8JUo7Pb
   B9AK88zGvJzKwUCi7XOlG3DOgaxh+Onuvt+0w2Lb8D+nWMbwBL43V1i0f
   HfhjoDeemp6uB6L+NZZz4p1dWsjHMU+KFSZBPXCaW0GNt97TUX2L1Hh4K
   zMDSfobDkAaYOHoDohO9U7Bjzy5n7BQMWDTuJxF228s0tvkWZo8ZvsieU
   Q==;
X-CSE-ConnectionGUID: d0F/FN/LSiqv6pG673ZHHQ==
X-CSE-MsgGUID: XaRObJHwS9qyXEkIA0hdHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11782"; a="83208974"
X-IronPort-AV: E=Sophos;i="6.23,227,1770624000"; 
   d="scan'208";a="83208974"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2026 11:39:58 -0700
X-CSE-ConnectionGUID: 9iPDUedgTL2rCrWjmDGMxg==
X-CSE-MsgGUID: dQF0vNKxSVeNLNXurCe0ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,227,1770624000"; 
   d="scan'208";a="267626766"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2026 11:39:57 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 05/15] wifi: iwlwifi: mld: add NAN link management
Date: Sun, 10 May 2026 21:39:28 +0300
Message-Id: <20260510213745.a39f125ea998.I81ff6dc02e912396040f922e21888fd94b3c26e6@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260510183938.4182886-1-miriam.rachel.korenblit@intel.com>
References: <20260510183938.4182886-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E2B0A505B94
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-36150-lists,linux-wireless=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Johannes Berg <johannes.berg@intel.com>

The firmware requires links for NAN which mac80211 doesn't use,
so introduce a new NAN link data structure that the driver has
for itself only, and handle the link command sending code for
NAN using this data structure, most of the bss_conf data isn't
used for NAN anyway, so those structures aren't useful.

With that, add, activate, deactivate or remove links depending
on the local NAN schedule updates.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Co-developed-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/mld/iface.c    |  15 +-
 .../net/wireless/intel/iwlwifi/mld/iface.h    |   9 +
 drivers/net/wireless/intel/iwlwifi/mld/link.c |  12 +-
 drivers/net/wireless/intel/iwlwifi/mld/link.h |   7 +
 drivers/net/wireless/intel/iwlwifi/mld/mld.h  |   8 +-
 drivers/net/wireless/intel/iwlwifi/mld/nan.c  | 301 +++++++++++++++++-
 drivers/net/wireless/intel/iwlwifi/mld/nan.h  |  19 ++
 drivers/net/wireless/intel/iwlwifi/mld/rx.c   |   2 +-
 .../wireless/intel/iwlwifi/mld/tests/utils.c  |   2 -
 9 files changed, 356 insertions(+), 19 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/iface.c b/drivers/net/wireless/intel/iwlwifi/mld/iface.c
index 150ad095e0ae..5fc3f6729455 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/iface.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/iface.c
@@ -5,6 +5,7 @@
 #include <net/cfg80211.h>
 
 #include "iface.h"
+#include "nan.h"
 #include "hcmd.h"
 #include "key.h"
 #include "mlo.h"
@@ -55,8 +56,12 @@ void iwl_mld_cleanup_vif(void *data, u8 *mac, struct ieee80211_vif *vif)
 
 	ieee80211_iter_keys(mld->hw, vif, iwl_mld_cleanup_keys_iter, NULL);
 
-	if (vif->type == NL80211_IFTYPE_NAN)
+	if (vif->type == NL80211_IFTYPE_NAN) {
 		mld_vif->nan.mac_added = false;
+		/* Clean up NAN links */
+		for (int i = 0; i < ARRAY_SIZE(mld_vif->nan.links); i++)
+			iwl_mld_cleanup_nan_link(&mld_vif->nan.links[i]);
+	}
 
 	CLEANUP_STRUCT(mld_vif);
 }
@@ -515,6 +520,14 @@ iwl_mld_init_vif(struct iwl_mld *mld, struct ieee80211_vif *vif)
 		wiphy_delayed_work_init(&mld_vif->mlo_scan_start_wk,
 					iwl_mld_mlo_scan_start_wk);
 	}
+
+	if (vif->type == NL80211_IFTYPE_NAN) {
+		for (int i = 0; i < ARRAY_SIZE(mld_vif->nan.links); i++) {
+			memset(&mld_vif->nan.links[i], 0, sizeof(mld_vif->nan.links[i]));
+			mld_vif->nan.links[i].fw_id = FW_CTXT_ID_INVALID;
+		}
+	}
+
 	iwl_mld_init_internal_sta(&mld_vif->aux_sta);
 }
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/iface.h b/drivers/net/wireless/intel/iwlwifi/mld/iface.h
index 1ac14996985c..ce4f8ca885cf 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/iface.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/iface.h
@@ -8,6 +8,7 @@
 #include <net/mac80211.h>
 
 #include "link.h"
+#include "nan.h"
 #include "session-protect.h"
 #include "d3.h"
 #include "fw/api/time-event.h"
@@ -153,6 +154,7 @@ struct iwl_mld_emlsr {
  * @aux_sta: station used for remain on channel. Used in P2P device.
  * @mlo_scan_start_wk: worker to start a deferred MLO scan
  * @nan: NAN parameters
+ * @nan.links: NAN links for FW (indexed by FW link ID)
  * @nan.mac_added: track whether or not the MAC was added to FW
  */
 struct iwl_mld_vif {
@@ -179,6 +181,7 @@ struct iwl_mld_vif {
 
 	struct {
 		/* use only with wiphy protection */
+		struct iwl_mld_nan_link links[IWL_FW_MAX_LINKS];
 		bool mac_added;
 	} nan;
 
@@ -242,6 +245,12 @@ static inline bool iwl_mld_vif_fw_id_valid(struct iwl_mld_vif *mld_vif)
 	     link_id++)							\
 		if ((mld_link = iwl_mld_link_dereference_check(mld_vif, link_id)))
 
+#define for_each_mld_nan_valid_link(mld_vif, nan_link)			\
+	for (nan_link = &(mld_vif)->nan.links[0];			\
+	     nan_link < &(mld_vif)->nan.links[ARRAY_SIZE((mld_vif)->nan.links)]; \
+	     nan_link++)						\
+		if (nan_link->fw_id != FW_CTXT_ID_INVALID)
+
 /* Retrieve pointer to mld link from mac80211 structures */
 static inline struct iwl_mld_link *
 iwl_mld_link_from_mac80211(struct ieee80211_bss_conf *bss_conf)
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/link.c b/drivers/net/wireless/intel/iwlwifi/mld/link.c
index b66e84d2365f..9e40b334ee1f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/link.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/link.c
@@ -16,14 +16,17 @@
 #include "fw/api/context.h"
 #include "fw/dbg.h"
 
-static int iwl_mld_send_link_cmd(struct iwl_mld *mld,
-				 struct iwl_link_config_cmd *cmd,
-				 enum iwl_ctxt_action action)
+int iwl_mld_send_link_cmd(struct iwl_mld *mld,
+			  struct iwl_link_config_cmd *cmd,
+			  enum iwl_ctxt_action action)
 {
 	int ret;
 
 	lockdep_assert_wiphy(mld->wiphy);
 
+	if (WARN_ON_ONCE(cmd->link_id == cpu_to_le32(FW_CTXT_ID_INVALID)))
+		return -EINVAL;
+
 	cmd->action = cpu_to_le32(action);
 	ret = iwl_mld_send_cmd_pdu(mld,
 				   WIDE_ID(MAC_CONF_GROUP, LINK_CONFIG_CMD),
@@ -437,7 +440,8 @@ iwl_mld_rm_link_from_fw(struct iwl_mld *mld, struct ieee80211_bss_conf *link)
 	iwl_mld_send_link_cmd(mld, &cmd, FW_CTXT_ACTION_REMOVE);
 }
 
-static IWL_MLD_ALLOC_FN(link, bss_conf)
+IWL_MLD_ALLOC_FN(link, bss_conf)
+EXPORT_SYMBOL_IF_IWLWIFI_KUNIT(iwl_mld_allocate_link_fw_id);
 
 /* Constructor function for struct iwl_mld_link */
 static int
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/link.h b/drivers/net/wireless/intel/iwlwifi/mld/link.h
index ca691259fc5e..84d9a24134a8 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/link.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/link.h
@@ -99,6 +99,13 @@ iwl_mld_cleanup_link(struct iwl_mld *mld, struct iwl_mld_link *link)
 /* Convert a percentage from [0,100] to [0,255] */
 #define NORMALIZE_PERCENT_TO_255(percentage) ((percentage) * 256 / 100)
 
+int iwl_mld_allocate_link_fw_id(struct iwl_mld *mld, u8 *fw_id,
+				struct ieee80211_bss_conf *mac80211_ptr);
+
+int iwl_mld_send_link_cmd(struct iwl_mld *mld,
+			  struct iwl_link_config_cmd *cmd,
+			  enum iwl_ctxt_action action);
+
 int iwl_mld_add_link(struct iwl_mld *mld,
 		     struct ieee80211_bss_conf *bss_conf);
 void iwl_mld_remove_link(struct iwl_mld *mld,
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mld.h b/drivers/net/wireless/intel/iwlwifi/mld/mld.h
index 606cb64f8ea4..69da3c346394 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mld.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mld.h
@@ -558,12 +558,18 @@ iwl_mld_allocate_##_type##_fw_id(struct iwl_mld *mld,					\
 static inline struct ieee80211_bss_conf *
 iwl_mld_fw_id_to_link_conf(struct iwl_mld *mld, u8 fw_link_id)
 {
+	struct ieee80211_bss_conf *link;
+
 	if (IWL_FW_CHECK(mld, fw_link_id >= mld->fw->ucode_capa.num_links,
 			 "Invalid fw_link_id: %d\n", fw_link_id))
 		return NULL;
 
-	return wiphy_dereference(mld->wiphy,
+	link = wiphy_dereference(mld->wiphy,
 				 mld->fw_id_to_bss_conf[fw_link_id]);
+	if (IS_ERR(link))
+		return NULL;
+
+	return link;
 }
 
 #define MSEC_TO_TU(_msec)	((_msec) * 1000 / 1024)
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/nan.c b/drivers/net/wireless/intel/iwlwifi/mld/nan.c
index 96e79ba5234a..6ea11b66a545 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/nan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/nan.c
@@ -5,8 +5,11 @@
 
 #include "mld.h"
 #include "iface.h"
+#include "link.h"
 #include "mlo.h"
 #include "fw/api/mac-cfg.h"
+#include "fw/api/mac.h"
+#include "fw/api/rs.h"
 
 #define IWL_NAN_DISOVERY_BEACON_INTERNVAL_TU 512
 #define IWL_NAN_RSSI_CLOSE 55
@@ -297,24 +300,302 @@ void iwl_mld_handle_nan_dw_end_notif(struct iwl_mld *mld,
 	cfg80211_next_nan_dw_notif(wdev, chan, GFP_KERNEL);
 }
 
+static void iwl_mld_nan_fill_rates(struct iwl_link_config_cmd *cmd)
+{
+	u32 ofdm = 0;
+
+	/* All OFDM rates - NAN uses OFDM only, no CCK */
+	ofdm |= IWL_RATE_BIT_MSK(6) >> IWL_FIRST_OFDM_RATE;
+	ofdm |= IWL_RATE_BIT_MSK(9) >> IWL_FIRST_OFDM_RATE;
+	ofdm |= IWL_RATE_BIT_MSK(12) >> IWL_FIRST_OFDM_RATE;
+	ofdm |= IWL_RATE_BIT_MSK(18) >> IWL_FIRST_OFDM_RATE;
+	ofdm |= IWL_RATE_BIT_MSK(24) >> IWL_FIRST_OFDM_RATE;
+	ofdm |= IWL_RATE_BIT_MSK(36) >> IWL_FIRST_OFDM_RATE;
+	ofdm |= IWL_RATE_BIT_MSK(48) >> IWL_FIRST_OFDM_RATE;
+	ofdm |= IWL_RATE_BIT_MSK(54) >> IWL_FIRST_OFDM_RATE;
+
+	cmd->ofdm_rates = cpu_to_le32(ofdm);
+	cmd->short_slot = cpu_to_le32(1);
+}
+
+static void iwl_mld_nan_fill_qos(struct iwl_ac_qos *ac, __le32 *qos_flags)
+{
+	/* AC_BK: CWmin=15, CWmax=1023, AIFSN=7, TXOP=0 */
+	ac[AC_BK].cw_min = cpu_to_le16(15);
+	ac[AC_BK].cw_max = cpu_to_le16(1023);
+	ac[AC_BK].aifsn = 7;
+	ac[AC_BK].fifos_mask = BIT(IWL_BZ_EDCA_TX_FIFO_BK);
+	ac[AC_BK].edca_txop = 0;
+
+	/* AC_BE: CWmin=15, CWmax=1023, AIFSN=3, TXOP=0 */
+	ac[AC_BE].cw_min = cpu_to_le16(15);
+	ac[AC_BE].cw_max = cpu_to_le16(1023);
+	ac[AC_BE].aifsn = 3;
+	ac[AC_BE].fifos_mask = BIT(IWL_BZ_EDCA_TX_FIFO_BE);
+	ac[AC_BE].edca_txop = 0;
+
+	/* AC_VI: CWmin=7, CWmax=15, AIFSN=2, TXOP=3008us */
+	ac[AC_VI].cw_min = cpu_to_le16(7);
+	ac[AC_VI].cw_max = cpu_to_le16(15);
+	ac[AC_VI].aifsn = 2;
+	ac[AC_VI].fifos_mask = BIT(IWL_BZ_EDCA_TX_FIFO_VI);
+	ac[AC_VI].edca_txop = cpu_to_le16(3008);
+
+	/* AC_VO: CWmin=3, CWmax=7, AIFSN=2, TXOP=1504us */
+	ac[AC_VO].cw_min = cpu_to_le16(3);
+	ac[AC_VO].cw_max = cpu_to_le16(7);
+	ac[AC_VO].aifsn = 2;
+	ac[AC_VO].fifos_mask = BIT(IWL_BZ_EDCA_TX_FIFO_VO);
+	ac[AC_VO].edca_txop = cpu_to_le16(1504);
+
+	*qos_flags |= cpu_to_le32(MAC_QOS_FLG_UPDATE_EDCA);
+}
+
+static void
+iwl_mld_nan_link_prep_cmd(struct iwl_mld *mld,
+			  struct iwl_mld_nan_link *nan_link,
+			  struct iwl_link_config_cmd *cmd,
+			  u32 modify_flags)
+{
+	struct ieee80211_vif *vif = mld->nan_device_vif;
+	struct iwl_mld_vif *mld_vif;
+
+	if (WARN_ON_ONCE(!vif))
+		return;
+
+	mld_vif = iwl_mld_vif_from_mac80211(vif);
+
+	memset(cmd, 0, sizeof(*cmd));
+
+	if (!nan_link->chanctx) {
+		cmd->phy_id = cpu_to_le32(FW_CTXT_ID_INVALID);
+	} else {
+		struct iwl_mld_phy *mld_phy;
+
+		mld_phy = iwl_mld_phy_from_mac80211(nan_link->chanctx);
+		cmd->phy_id = cpu_to_le32(mld_phy->fw_id);
+	}
+
+	if (modify_flags & LINK_CONTEXT_MODIFY_RATES_INFO)
+		iwl_mld_nan_fill_rates(cmd);
+
+	if (modify_flags & LINK_CONTEXT_MODIFY_QOS_PARAMS)
+		iwl_mld_nan_fill_qos(cmd->ac, &cmd->qos_flags);
+
+	cmd->link_id = cpu_to_le32(nan_link->fw_id);
+	cmd->mac_id = cpu_to_le32(mld_vif->fw_id);
+	cmd->active = cpu_to_le32(nan_link->active);
+
+	ether_addr_copy(cmd->local_link_addr, vif->addr);
+
+	cmd->modify_mask = cpu_to_le32(modify_flags);
+}
+
+static struct iwl_mld_nan_link *
+iwl_mld_nan_link_add(struct iwl_mld *mld,
+		     struct iwl_mld_vif *mld_vif,
+		     struct ieee80211_chanctx_conf *chanctx)
+{
+	struct iwl_mld_nan_link *nan_link;
+	struct iwl_link_config_cmd cmd;
+	u8 fw_id;
+	int ret;
+
+	ret = iwl_mld_allocate_link_fw_id(mld, &fw_id, ERR_PTR(-ENODEV));
+	if (ret < 0)
+		return NULL;
+
+	nan_link = &mld_vif->nan.links[fw_id];
+
+	if (WARN_ON_ONCE(nan_link->fw_id != FW_CTXT_ID_INVALID))
+		goto err;
+
+	nan_link->fw_id = fw_id;
+	nan_link->chanctx = chanctx;
+
+	iwl_mld_nan_link_prep_cmd(mld, nan_link, &cmd,
+				  LINK_CONTEXT_MODIFY_RATES_INFO |
+				  LINK_CONTEXT_MODIFY_QOS_PARAMS);
+
+	ret = iwl_mld_send_link_cmd(mld, &cmd, FW_CTXT_ACTION_ADD);
+	if (ret) {
+		nan_link->fw_id = FW_CTXT_ID_INVALID;
+		nan_link->chanctx = NULL;
+		goto err;
+	}
+
+	return nan_link;
+err:
+	RCU_INIT_POINTER(mld->fw_id_to_bss_conf[fw_id], NULL);
+	return NULL;
+}
+
+static int iwl_mld_nan_link_set_active(struct iwl_mld *mld,
+				       struct iwl_mld_nan_link *nan_link,
+				       bool active)
+{
+	struct iwl_link_config_cmd cmd;
+	int ret;
+
+	if (nan_link->active == active)
+		return 0;
+
+	nan_link->active = active;
+
+	iwl_mld_nan_link_prep_cmd(mld, nan_link, &cmd,
+				  LINK_CONTEXT_MODIFY_ACTIVE);
+
+	ret = iwl_mld_send_link_cmd(mld, &cmd, FW_CTXT_ACTION_MODIFY);
+	if (ret) {
+		nan_link->active = !nan_link->active;
+		return ret;
+	}
+
+	if (!active)
+		nan_link->chanctx = NULL;
+
+	return 0;
+}
+
+static void iwl_mld_nan_link_remove(struct iwl_mld *mld,
+				    struct iwl_mld_nan_link *nan_link)
+{
+	struct iwl_link_config_cmd cmd = {
+		.link_id = cpu_to_le32(nan_link->fw_id),
+		.phy_id = cpu_to_le32(FW_CTXT_ID_INVALID),
+	};
+
+	if (WARN_ON_ONCE(nan_link->fw_id == FW_CTXT_ID_INVALID))
+		return;
+
+	iwl_mld_send_link_cmd(mld, &cmd, FW_CTXT_ACTION_REMOVE);
+
+	RCU_INIT_POINTER(mld->fw_id_to_bss_conf[nan_link->fw_id], NULL);
+	nan_link->fw_id = FW_CTXT_ID_INVALID;
+	nan_link->active = false;
+	nan_link->chanctx = NULL;
+}
+
+static bool iwl_mld_nan_have_links(struct iwl_mld_vif *mld_vif)
+{
+	struct iwl_mld_nan_link *nan_link;
+
+	for_each_mld_nan_valid_link(mld_vif, nan_link)
+		return true;
+
+	return false;
+}
+
+static struct iwl_mld_nan_link *
+iwl_mld_nan_find_link(struct iwl_mld_vif *mld_vif,
+		      struct ieee80211_chanctx_conf *chanctx)
+{
+	struct iwl_mld_nan_link *nan_link;
+
+	for_each_mld_nan_valid_link(mld_vif, nan_link) {
+		if (nan_link->chanctx == chanctx)
+			return nan_link;
+	}
+
+	return NULL;
+}
+
 void iwl_mld_nan_vif_cfg_changed(struct iwl_mld *mld,
 				 struct ieee80211_vif *vif,
 				 u64 changes)
 {
-	struct ieee80211_nan_sched_cfg *sched_cfg = &vif->cfg.nan_sched;
 	struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(vif);
-	bool has_sched = memchr_inv(sched_cfg->schedule, 0,
-				    sizeof(sched_cfg->schedule));
-
-	lockdep_assert_wiphy(mld->wiphy);
+	bool previously_empty_schedule = !iwl_mld_nan_have_links(mld_vif);
+	struct ieee80211_nan_sched_cfg *sched_cfg = &vif->cfg.nan_sched;
+	struct iwl_mld_nan_link *links[ARRAY_SIZE(sched_cfg->channels)] = {};
+	bool link_used[ARRAY_SIZE(mld_vif->nan.links)] = {};
+	struct iwl_mld_nan_link *nan_link;
+	bool empty_schedule = true;
+	int ret;
 
 	if (!(changes & BSS_CHANGED_NAN_LOCAL_SCHED))
 		return;
 
-	if (has_sched && !mld_vif->nan.mac_added) {
-		if (iwl_mld_add_nan_vif(mld, vif))
-			IWL_ERR(mld, "Failed to add NAN vif\n");
-	} else if (!has_sched && mld_vif->nan.mac_added) {
-		iwl_mld_rm_vif(mld, vif);
+	for (int i = 0; i < ARRAY_SIZE(sched_cfg->channels); i++) {
+		if (!sched_cfg->channels[i].chanreq.oper.chan)
+			continue;
+		empty_schedule = false;
+		break;
+	}
+
+	/* add the MAC if needed (before adding links) */
+	if (!empty_schedule && previously_empty_schedule) {
+		WARN_ON(mld_vif->nan.mac_added);
+		ret = iwl_mld_add_nan_vif(mld, vif);
+
+		if (ret) {
+			IWL_ERR(mld, "NAN: failed to add MAC (%d)\n", ret);
+			return;
+		}
+	}
+
+	if (!mld_vif->nan.mac_added) {
+		/* nothing to do */
+		return;
+	}
+
+	/* find links we can keep (same chanctx/PHY) */
+	for (int i = 0; i < ARRAY_SIZE(sched_cfg->channels); i++) {
+		struct ieee80211_chanctx_conf *chanctx;
+		struct iwl_mld_nan_link *link;
+
+		chanctx = sched_cfg->channels[i].chanctx_conf;
+		/* ULW */
+		if (!chanctx)
+			continue;
+
+		link = iwl_mld_nan_find_link(mld_vif, chanctx);
+		links[i] = link;
+		if (link)
+			link_used[link->fw_id] = true;
+	}
+
+	/* add/reassign links for new channels */
+	for (int i = 0; i < ARRAY_SIZE(sched_cfg->channels); i++) {
+		struct ieee80211_chanctx_conf *chanctx;
+
+		/* already have an existing active link */
+		if (links[i])
+			continue;
+
+		chanctx = sched_cfg->channels[i].chanctx_conf;
+		/* ULW or unused slot */
+		if (!chanctx)
+			continue;
+
+		/*
+		 * if this fails we still update the schedule, but
+		 * without a valid link we'll always ULW it
+		 */
+		links[i] = iwl_mld_nan_link_add(mld, mld_vif, chanctx);
+
+		/* we have a link, activate it */
+		if (links[i]) {
+			link_used[links[i]->fw_id] = true;
+			iwl_mld_nan_link_set_active(mld, links[i], true);
+		}
+	}
+
+	/* delete unused links */
+	for_each_mld_nan_valid_link(mld_vif, nan_link) {
+		if (!link_used[nan_link->fw_id]) {
+			iwl_mld_nan_link_set_active(mld, nan_link, false);
+			iwl_mld_nan_link_remove(mld, nan_link);
+		}
+	}
+
+	/* remove MAC if needed */
+	if (!previously_empty_schedule && empty_schedule) {
+		/* must have been added */
+		WARN_ON_ONCE(!mld_vif->nan.mac_added);
+
+		/* mac80211 should reconfigure same state */
+		if (!WARN_ON_ONCE(mld->fw_status.in_hw_restart))
+			iwl_mld_rm_vif(mld, vif);
 	}
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/nan.h b/drivers/net/wireless/intel/iwlwifi/mld/nan.h
index 9487155cf6b3..933e16c3c274 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/nan.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/nan.h
@@ -7,6 +7,25 @@
 #include <net/cfg80211.h>
 #include <linux/etherdevice.h>
 
+/**
+ * struct iwl_mld_nan_link - struct representing a NAN link
+ * @chanctx: the channel context
+ * @active: indicates the NAN link is currently active
+ * @fw_id: FW link ID
+ */
+struct iwl_mld_nan_link {
+	struct ieee80211_chanctx_conf *chanctx;
+	bool active;
+	u8 fw_id;
+};
+
+/* Cleanup function for struct iwl_mld_nan_link, will be called in restart */
+static inline void iwl_mld_cleanup_nan_link(struct iwl_mld_nan_link *nan_link)
+{
+	memset(nan_link, 0, sizeof(*nan_link));
+	nan_link->fw_id = FW_CTXT_ID_INVALID;
+}
+
 bool iwl_mld_nan_supported(struct iwl_mld *mld);
 int iwl_mld_start_nan(struct ieee80211_hw *hw,
 		      struct ieee80211_vif *vif,
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/rx.c b/drivers/net/wireless/intel/iwlwifi/mld/rx.c
index a2e586c6ea67..b270cf87824d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/rx.c
@@ -158,7 +158,7 @@ static bool iwl_mld_used_average_energy(struct iwl_mld *mld, int link_id,
 	guard(rcu)();
 
 	link_conf = rcu_dereference(mld->fw_id_to_bss_conf[link_id]);
-	if (!link_conf)
+	if (IS_ERR_OR_NULL(link_conf))
 		return false;
 
 	mld_link = iwl_mld_link_from_mac80211(link_conf);
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/tests/utils.c b/drivers/net/wireless/intel/iwlwifi/mld/tests/utils.c
index dce747270167..0cdbbb86dbd9 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/tests/utils.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/tests/utils.c
@@ -68,8 +68,6 @@ int iwlmld_kunit_test_init(struct kunit *test)
 	return 0;
 }
 
-static IWL_MLD_ALLOC_FN(link, bss_conf)
-
 static void iwlmld_kunit_init_link(struct ieee80211_vif *vif,
 				   struct ieee80211_bss_conf *link,
 				   struct iwl_mld_link *mld_link, int link_id)
-- 
2.34.1


