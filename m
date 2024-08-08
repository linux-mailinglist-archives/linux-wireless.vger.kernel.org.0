Return-Path: <linux-wireless+bounces-11140-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 857FA94C5A0
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Aug 2024 22:23:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F2141C214B2
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Aug 2024 20:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4546315A4B0;
	Thu,  8 Aug 2024 20:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G6ekyLjJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B05C155A25
	for <linux-wireless@vger.kernel.org>; Thu,  8 Aug 2024 20:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723148591; cv=none; b=G0rteiWo9WpoVpsDYObkOP7G7EYA0ByU3bFrkCpZYiy7UMN2vfkxL7mG2WjS/GIyDyFS29WzQpRS6ym1PlaMDsJvfOHH9LfbHssuwgN0SzJZKHb4cYXiDPzqxvvnQmREzhQTDc1udnQL7J7lNPxrLPO4kxtw8akq48CMtlV26Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723148591; c=relaxed/simple;
	bh=S1EbqH5RJ+aYLz+GYv9bV9f/XN7u36bNismKc4ZJ8Fw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P8SSZmqEjBVMnOQqpCks6BYkrRjK9eImHQfTpUbzCqK3tocBw0E1+4JQoNAGhVBJeZifAzu9p7h02ejaFAwttndgVs8qctLqSNL+KUf+F6ngCZonSJsmm4AGE7DEO9MjGPMs5lyVUeS42Cu3OYqfWNTiJvxAGVv8dD0KfDQXWN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G6ekyLjJ; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723148588; x=1754684588;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=S1EbqH5RJ+aYLz+GYv9bV9f/XN7u36bNismKc4ZJ8Fw=;
  b=G6ekyLjJCiUUzTK5H6KA6YCYqQLhintn24kguE32fgEfxwtSKEnM06tz
   ZanptbOmLsjJkdcOqeg10zTvecg7ABE5vLYJVArbtIlL9yCiChJFE042u
   QRzdkN66GowPzmRJ1QhuuiNSuL/o3R+zJ2TeBa2R/iYWbAwcHmeojMvFn
   9K8lTklAQYLwdFxnSO49dFWzsAmUlyXCVBeS0YA1Ti3cs4R+BL2spPI+w
   0WPZVLqJFg6eRgFFVidN9l0ZxMn/MUDf33Xk0KFR51o1vJ1+c51Pfe7Pv
   Tq9KN4uw3luSKDZoZMDwdOZu8163Z+CNZ85SeyBNzcby1LriieuhfBJgD
   w==;
X-CSE-ConnectionGUID: 5HqUr1y8QW+0tfm/4rtZgw==
X-CSE-MsgGUID: FrpdaOKuRRKcG8yYL9xxmw==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="38808839"
X-IronPort-AV: E=Sophos;i="6.09,274,1716274800"; 
   d="scan'208";a="38808839"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 13:23:07 -0700
X-CSE-ConnectionGUID: ryyJjK77QciD4/UHqvUYzg==
X-CSE-MsgGUID: kl6dsuoATm6rFGAQZd4LBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,274,1716274800"; 
   d="scan'208";a="57305291"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 13:23:05 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 04/13] wifi: iwlwifi: mvm: handle the new missed beacons notification
Date: Thu,  8 Aug 2024 23:22:40 +0300
Message-Id: <20240808232017.a64ffc998569.I7d181052b1a69c331d07263f20c1e00cbc0bc891@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240808202249.4004087-1-miriam.rachel.korenblit@intel.com>
References: <20240808202249.4004087-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

Use the same handler for both types and just convert the old version to
the new. Drop the unused fields from the old one and fake the new
fields.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c | 49 ++++++++++++++++---
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  2 +
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |  7 ++-
 3 files changed, 49 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
index 9209814b465c..4a8f50f8bb79 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
@@ -1586,11 +1586,11 @@ void iwl_mvm_rx_beacon_notif(struct iwl_mvm *mvm,
 	}
 }
 
-void iwl_mvm_rx_missed_beacons_notif(struct iwl_mvm *mvm,
-				     struct iwl_rx_cmd_buffer *rxb)
+static void
+iwl_mvm_handle_missed_beacons_notif(struct iwl_mvm *mvm,
+				    const struct iwl_missed_beacons_notif *mb,
+				    struct iwl_rx_packet *pkt)
 {
-	struct iwl_rx_packet *pkt = rxb_addr(rxb);
-	struct iwl_missed_beacons_notif_v4 *mb = (void *)pkt->data;
 	struct iwl_fw_dbg_trigger_missed_bcon *bcon_trig;
 	struct iwl_fw_dbg_trigger_tlv *trigger;
 	u32 stop_trig_missed_bcon, stop_trig_missed_bcon_since_rx;
@@ -1604,6 +1604,16 @@ void iwl_mvm_rx_missed_beacons_notif(struct iwl_mvm *mvm,
 	u8 notif_ver = iwl_fw_lookup_notif_ver(mvm->fw, LEGACY_GROUP,
 					       MISSED_BEACONS_NOTIFICATION,
 					       0);
+	u8 new_notif_ver = iwl_fw_lookup_notif_ver(mvm->fw, MAC_CONF_GROUP,
+						   MISSED_BEACONS_NOTIF, 0);
+
+	/* If the firmware uses the new notification (from MAC_CONF_GROUP),
+	 * refer to that notification's version.
+	 * Note that the new notification from MAC_CONF_GROUP starts from
+	 * version 5.
+	 */
+	if (new_notif_ver)
+		notif_ver = new_notif_ver;
 
 	/* before version four the ID in the notification refers to mac ID */
 	if (notif_ver < 4) {
@@ -1620,13 +1630,11 @@ void iwl_mvm_rx_missed_beacons_notif(struct iwl_mvm *mvm,
 	}
 
 	IWL_DEBUG_INFO(mvm,
-		       "missed bcn %s_id=%u, consecutive=%u (%u, %u, %u)\n",
+		       "missed bcn %s_id=%u, consecutive=%u (%u)\n",
 		       notif_ver < 4 ? "mac" : "link",
 		       id,
 		       le32_to_cpu(mb->consec_missed_beacons),
-		       le32_to_cpu(mb->consec_missed_beacons_since_last_rx),
-		       le32_to_cpu(mb->num_recvd_beacons),
-		       le32_to_cpu(mb->num_expected_beacons));
+		       le32_to_cpu(mb->consec_missed_beacons_since_last_rx));
 
 	if (!vif)
 		return;
@@ -1687,6 +1695,31 @@ void iwl_mvm_rx_missed_beacons_notif(struct iwl_mvm *mvm,
 		iwl_fw_dbg_collect_trig(&mvm->fwrt, trigger, NULL);
 }
 
+void iwl_mvm_rx_missed_beacons_notif(struct iwl_mvm *mvm,
+				     struct iwl_rx_cmd_buffer *rxb)
+{
+	struct iwl_rx_packet *pkt = rxb_addr(rxb);
+
+	iwl_mvm_handle_missed_beacons_notif(mvm, (const void *)pkt->data, pkt);
+}
+
+void iwl_mvm_rx_missed_beacons_notif_legacy(struct iwl_mvm *mvm,
+					    struct iwl_rx_cmd_buffer *rxb)
+{
+	struct iwl_rx_packet *pkt = rxb_addr(rxb);
+	const struct iwl_missed_beacons_notif_v4 *mb_v4 =
+		(const void *)pkt->data;
+	struct iwl_missed_beacons_notif mb = {
+		.link_id = mb_v4->link_id,
+		.consec_missed_beacons = mb_v4->consec_missed_beacons,
+		.consec_missed_beacons_since_last_rx =
+			mb_v4->consec_missed_beacons_since_last_rx,
+		.other_link_id = cpu_to_le32(IWL_MVM_FW_LINK_ID_INVALID),
+	};
+
+	iwl_mvm_handle_missed_beacons_notif(mvm, &mb, pkt);
+}
+
 void iwl_mvm_rx_stored_beacon_notif(struct iwl_mvm *mvm,
 				    struct iwl_rx_cmd_buffer *rxb)
 {
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 4cacaa7b398e..f9e676374daa 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -2073,6 +2073,8 @@ void iwl_mvm_rx_beacon_notif(struct iwl_mvm *mvm,
 			     struct iwl_rx_cmd_buffer *rxb);
 void iwl_mvm_rx_missed_beacons_notif(struct iwl_mvm *mvm,
 				     struct iwl_rx_cmd_buffer *rxb);
+void iwl_mvm_rx_missed_beacons_notif_legacy(struct iwl_mvm *mvm,
+					    struct iwl_rx_cmd_buffer *rxb);
 void iwl_mvm_rx_stored_beacon_notif(struct iwl_mvm *mvm,
 				    struct iwl_rx_cmd_buffer *rxb);
 void iwl_mvm_mu_mimo_grp_notif(struct iwl_mvm *mvm,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index dd2631ff452d..0b91877592a8 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -394,10 +394,15 @@ static const struct iwl_rx_handlers iwl_mvm_rx_handlers[] = {
 		   iwl_mvm_rx_umac_scan_iter_complete_notif, RX_HANDLER_SYNC,
 		   struct iwl_umac_scan_iter_complete_notif),
 
-	RX_HANDLER(MISSED_BEACONS_NOTIFICATION, iwl_mvm_rx_missed_beacons_notif,
+	RX_HANDLER(MISSED_BEACONS_NOTIFICATION,
+		   iwl_mvm_rx_missed_beacons_notif_legacy,
 		   RX_HANDLER_ASYNC_LOCKED_WIPHY,
 		   struct iwl_missed_beacons_notif_v4),
 
+	RX_HANDLER_GRP(MAC_CONF_GROUP, MISSED_BEACONS_NOTIF,
+		       iwl_mvm_rx_missed_beacons_notif,
+		       RX_HANDLER_ASYNC_LOCKED_WIPHY,
+		       struct iwl_missed_beacons_notif),
 	RX_HANDLER(REPLY_ERROR, iwl_mvm_rx_fw_error, RX_HANDLER_SYNC,
 		   struct iwl_error_resp),
 	RX_HANDLER(PSM_UAPSD_AP_MISBEHAVING_NOTIFICATION,
-- 
2.34.1


