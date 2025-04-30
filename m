Return-Path: <linux-wireless+bounces-22270-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3005AA4C6C
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Apr 2025 15:02:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD2D217CDC6
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Apr 2025 12:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC7AD25B1F2;
	Wed, 30 Apr 2025 12:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gX8rl6Tc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15AE92609D8
	for <linux-wireless@vger.kernel.org>; Wed, 30 Apr 2025 12:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746017877; cv=none; b=PMbKyMRhXGdtdS15El8AIVTccDeF64P7znm1/wU2fTpB4I2SFyr7RDuy8j25b3GnB6XuMRevtipzLf+ZSBhJueLXNVUjSY7zT3Z8mmsX1NLRqVW2PkEmOvaYd1fESf7hpIW0Rl4EGeBZp2jJZaaDN+taIGYgqdkeYuySjcfe0b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746017877; c=relaxed/simple;
	bh=ILusB7PFnxQyIzjTvRv7q+NAVKnZaSMYDt87e+8C8KU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SMYAvJ6OyhjFlxFjE9imvX2e7oCUZtxZEvvnUiJoiuJDq0BwRYwJaFYS0ZrqLKft6ahCfTv1R08zkxMFgh66mCAosTCH1Fh6Y0X2AlGFJCCkGE4THcYjVuBzhNgVHe4HutUnOGegdWokgmSHRiZKFs4vpvjr+MtwHYcXC4WuJpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gX8rl6Tc; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746017876; x=1777553876;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ILusB7PFnxQyIzjTvRv7q+NAVKnZaSMYDt87e+8C8KU=;
  b=gX8rl6Tc4FLXcJtN3mq9EkxIr5hV3Xcx7/sLBTW88Lm6O4YM7bbrbEQM
   26RcVEfegEKQyGb38H/mAcxdnr2C6DvYVkBWIghAvahVAYTEzQcZbnXsr
   QOryAtkXyGFxQm9EA26XdmY60pQ1yMVrciZOQThy2NhQLbp7jq30qZv14
   o09vPbV/OaNhJ9ZIadlCiVfvKVKri5qLZ7KGxgZKfJrGJUYqGBfYgGMKq
   Mo8oZtAeLQ2Gvyj/QdIDdXqGrQjtMdLL5c4LP0iXRkucgi7ghz5v/NAc7
   ffjSrbFtODvZQy/exctqNKdqwhHue0+kjn0pItHdRlwv7odc6TDxaGiid
   A==;
X-CSE-ConnectionGUID: BAD2j5XyTtyTjVvNDommgw==
X-CSE-MsgGUID: bH28n5wtSL2QGs6m7QA9VA==
X-IronPort-AV: E=McAfee;i="6700,10204,11419"; a="58332345"
X-IronPort-AV: E=Sophos;i="6.15,251,1739865600"; 
   d="scan'208";a="58332345"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 05:57:56 -0700
X-CSE-ConnectionGUID: nJ5qVZBkTomcEi9quI4Wag==
X-CSE-MsgGUID: TeBDrhQZTz+cMXXKf8OTXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,251,1739865600"; 
   d="scan'208";a="134632113"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 05:57:54 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org,
	Daniel Gabay <daniel.gabay@intel.com>
Subject: [PATCH iwlwifi-next 09/15] wifi: iwlwifi: mld: add monitor internal station
Date: Wed, 30 Apr 2025 15:57:23 +0300
Message-Id: <20250430155443.5ec460d3f1c2.Ic8456efb4cdd722dcd9c4910a1569ef9d3e4e066@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250430125729.1122751-1-miriam.rachel.korenblit@intel.com>
References: <20250430125729.1122751-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Daniel Gabay <daniel.gabay@intel.com>

This is needed for TX injection over monitor interface.

Signed-off-by: Daniel Gabay <daniel.gabay@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/link.c |  1 +
 drivers/net/wireless/intel/iwlwifi/mld/link.h |  4 +++
 .../net/wireless/intel/iwlwifi/mld/mac80211.c | 12 +++++--
 drivers/net/wireless/intel/iwlwifi/mld/sta.c  | 34 +++++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/mld/sta.h  |  8 +++++
 drivers/net/wireless/intel/iwlwifi/mld/tx.c   |  4 ++-
 6 files changed, 60 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/link.c b/drivers/net/wireless/intel/iwlwifi/mld/link.c
index 82a4979a3af3..fa822b748791 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/link.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/link.c
@@ -783,6 +783,7 @@ iwl_mld_init_link(struct iwl_mld *mld, struct ieee80211_bss_conf *link,
 	iwl_mld_init_internal_sta(&mld_link->bcast_sta);
 	iwl_mld_init_internal_sta(&mld_link->mcast_sta);
 	iwl_mld_init_internal_sta(&mld_link->aux_sta);
+	iwl_mld_init_internal_sta(&mld_link->mon_sta);
 
 	wiphy_delayed_work_init(&mld_link->rx_omi.finished_work,
 				iwl_mld_omi_bw_finished_work);
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/link.h b/drivers/net/wireless/intel/iwlwifi/mld/link.h
index 42b7bdcbd741..40492f0974e2 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/link.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/link.h
@@ -40,6 +40,7 @@ struct iwl_probe_resp_data {
  * @bcast_sta: station used for broadcast packets. Used in AP, GO and IBSS.
  * @mcast_sta: station used for multicast packets. Used in AP, GO and IBSS.
  * @aux_sta: station used for remain on channel. Used in P2P device.
+ * @mon_sta: station used for TX injection in monitor interface.
  * @link_id: over the air link ID
  * @ap_early_keys: The firmware cannot install keys before bcast/mcast STAs,
  *	but higher layers work differently, so we store the keys here for
@@ -73,6 +74,7 @@ struct iwl_mld_link {
 	struct iwl_mld_int_sta bcast_sta;
 	struct iwl_mld_int_sta mcast_sta;
 	struct iwl_mld_int_sta aux_sta;
+	struct iwl_mld_int_sta mon_sta;
 	u8 link_id;
 
 	struct {
@@ -107,6 +109,8 @@ iwl_mld_cleanup_link(struct iwl_mld *mld, struct iwl_mld_link *link)
 		iwl_mld_free_internal_sta(mld, &link->mcast_sta);
 	if (link->aux_sta.sta_id != IWL_INVALID_STA)
 		iwl_mld_free_internal_sta(mld, &link->aux_sta);
+	if (link->mon_sta.sta_id != IWL_INVALID_STA)
+		iwl_mld_free_internal_sta(mld, &link->mon_sta);
 }
 
 /* Convert a percentage from [0,100] to [0,255] */
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
index ef976e4d700f..b64e3f290e71 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
@@ -1021,12 +1021,19 @@ int iwl_mld_assign_vif_chanctx(struct ieee80211_hw *hw,
 		iwl_mld_send_ap_tx_power_constraint_cmd(mld, vif, link);
 
 	if (vif->type == NL80211_IFTYPE_MONITOR) {
-		/* TODO: task=sniffer add sniffer station */
+		ret = iwl_mld_add_mon_sta(mld, vif, link);
+		if (ret)
+			goto deactivate_link;
+
 		mld->monitor.p80 =
 			iwl_mld_chandef_get_primary_80(&vif->bss_conf.chanreq.oper);
 	}
 
 	return 0;
+
+deactivate_link:
+	if (mld_link->active)
+		iwl_mld_deactivate_link(mld, link);
 err:
 	RCU_INIT_POINTER(mld_link->chan_ctx, NULL);
 	return ret;
@@ -1052,7 +1059,8 @@ void iwl_mld_unassign_vif_chanctx(struct ieee80211_hw *hw,
 
 	iwl_mld_deactivate_link(mld, link);
 
-	/* TODO: task=sniffer remove sniffer station */
+	if (vif->type == NL80211_IFTYPE_MONITOR)
+		iwl_mld_remove_mon_sta(mld, vif, link);
 
 	if (n_active > 1) {
 		/* Indicate to mac80211 that EML is disabled */
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/sta.c b/drivers/net/wireless/intel/iwlwifi/mld/sta.c
index 332a7aecec2d..dfaa885dd1d0 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/sta.c
@@ -1087,6 +1087,24 @@ int iwl_mld_add_aux_sta(struct iwl_mld *mld,
 					0, NULL, IWL_MAX_TID_COUNT);
 }
 
+int iwl_mld_add_mon_sta(struct iwl_mld *mld,
+			struct ieee80211_vif *vif,
+			struct ieee80211_bss_conf *link)
+{
+	struct iwl_mld_link *mld_link = iwl_mld_link_from_mac80211(link);
+
+	if (WARN_ON(!mld_link))
+		return -EINVAL;
+
+	if (WARN_ON(vif->type != NL80211_IFTYPE_MONITOR))
+		return -EINVAL;
+
+	return iwl_mld_add_internal_sta(mld, &mld_link->mon_sta,
+					STATION_TYPE_BCAST_MGMT,
+					mld_link->fw_id, NULL,
+					IWL_MAX_TID_COUNT);
+}
+
 static void iwl_mld_remove_internal_sta(struct iwl_mld *mld,
 					struct iwl_mld_int_sta *internal_sta,
 					bool flush, u8 tid)
@@ -1156,6 +1174,22 @@ void iwl_mld_remove_aux_sta(struct iwl_mld *mld,
 				    IWL_MAX_TID_COUNT);
 }
 
+void iwl_mld_remove_mon_sta(struct iwl_mld *mld,
+			    struct ieee80211_vif *vif,
+			    struct ieee80211_bss_conf *link)
+{
+	struct iwl_mld_link *mld_link = iwl_mld_link_from_mac80211(link);
+
+	if (WARN_ON(!mld_link))
+		return;
+
+	if (WARN_ON(vif->type != NL80211_IFTYPE_MONITOR))
+		return;
+
+	iwl_mld_remove_internal_sta(mld, &mld_link->mon_sta, false,
+				    IWL_MAX_TID_COUNT);
+}
+
 static int iwl_mld_update_sta_resources(struct iwl_mld *mld,
 					struct ieee80211_vif *vif,
 					struct ieee80211_sta *sta,
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/sta.h b/drivers/net/wireless/intel/iwlwifi/mld/sta.h
index ddcffd7b9fde..c45d815d0c73 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/sta.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/sta.h
@@ -247,6 +247,10 @@ int iwl_mld_add_mcast_sta(struct iwl_mld *mld,
 int iwl_mld_add_aux_sta(struct iwl_mld *mld,
 			struct iwl_mld_int_sta *internal_sta);
 
+int iwl_mld_add_mon_sta(struct iwl_mld *mld,
+			struct ieee80211_vif *vif,
+			struct ieee80211_bss_conf *link);
+
 void iwl_mld_remove_bcast_sta(struct iwl_mld *mld,
 			      struct ieee80211_vif *vif,
 			      struct ieee80211_bss_conf *link);
@@ -259,6 +263,10 @@ void iwl_mld_remove_aux_sta(struct iwl_mld *mld,
 			    struct ieee80211_vif *vif,
 			    struct ieee80211_bss_conf *link);
 
+void iwl_mld_remove_mon_sta(struct iwl_mld *mld,
+			    struct ieee80211_vif *vif,
+			    struct ieee80211_bss_conf *link);
+
 int iwl_mld_update_link_stas(struct iwl_mld *mld,
 			     struct ieee80211_vif *vif,
 			     struct ieee80211_sta *sta,
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/tx.c b/drivers/net/wireless/intel/iwlwifi/mld/tx.c
index 543abe72e465..f818545fae97 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/tx.c
@@ -649,8 +649,10 @@ iwl_mld_get_tx_queue_id(struct iwl_mld *mld, struct ieee80211_txq *txq,
 		WARN_ON(!ieee80211_is_mgmt(fc));
 
 		return mld_vif->deflink.aux_sta.queue_id;
+	case NL80211_IFTYPE_MONITOR:
+		mld_vif = iwl_mld_vif_from_mac80211(info->control.vif);
+		return mld_vif->deflink.mon_sta.queue_id;
 	default:
-		/* TODO: consider monitor (task=monitor) */
 		WARN_ONCE(1, "Unsupported vif type\n");
 		break;
 	}
-- 
2.34.1


