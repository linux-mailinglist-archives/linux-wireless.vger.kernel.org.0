Return-Path: <linux-wireless+bounces-21866-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9964EA97E4F
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 07:51:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C91C117E1CD
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 05:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3892F264A96;
	Wed, 23 Apr 2025 05:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N8wj3xx7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734FA266EF0
	for <linux-wireless@vger.kernel.org>; Wed, 23 Apr 2025 05:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745387460; cv=none; b=jMTOEIuGErZ4uP86uS4XTdjqoRZOcQnvwxQINHP+BRdKMduBPCvMIeXBysdk3eCwRB9RcTgswRcdXZe/ZeeVb++0iD1Ht461FbAwZ100XQNZ5KxJxP8wukKU/gTjW9bd6E60DGL+nDjLZv8yOph82OTCZ0/u1vZMmYZ4yYLm7JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745387460; c=relaxed/simple;
	bh=E7v+HbxbPv0UBZZyCsSQiz0aYRzKOgZiYHNQEYGcHdk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KmyBD5AOMM4YRpYcD9DgIJO3Dm7FeLMk+AfKRsZv+cVR0j6LW7cFoipUxvRU/bwlN529vKH91xqlHh44BwJZBB1N6PAVski1SCSH2t0nyLMkMmArHglVZ2EdWKTkVfTNxk8O6vLXtiKq9u/W7gC1S6jxKSR1AFfwFdyOsDfJV+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N8wj3xx7; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745387458; x=1776923458;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=E7v+HbxbPv0UBZZyCsSQiz0aYRzKOgZiYHNQEYGcHdk=;
  b=N8wj3xx72FwKt0J+dY1iXxFJC5XbGKjf/rEU7z9k62z2e0tuld82d8bT
   2uLMm7vZshcWo56N/5ITg4dn9GyLed1EudXIK1zZx6eODloMMu4Mt+iFO
   TOWWSvLMpckvg/2M7Rlsjkj/784qr/t5jSKrVzQI/15IB15Yqn5IVIkNw
   lpS2InsD16PNCJ5UI2QEvwV1F/T1pMEQm9cZj1EaRaz4KQN8C0ZoaORWJ
   hAGz6OylKxiIaelGbWkUdgJgJg3w84A8QN++WmwiNY1AE0BPIp86/yfcO
   rYu2L+FF7BtcvYBIQP7WV1kaGv9WdwiShW6uJnjSBtWLwtCurcAUvWO18
   w==;
X-CSE-ConnectionGUID: Fez6x9xlQVObxcqr7j1/YA==
X-CSE-MsgGUID: IugdRJ+4QgSXC/MLpUtksg==
X-IronPort-AV: E=McAfee;i="6700,10204,11411"; a="46844626"
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="46844626"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 22:50:58 -0700
X-CSE-ConnectionGUID: crGBkkLFSkOPFt0BxMejFA==
X-CSE-MsgGUID: +RkQmLzJR5WbEAeOO8+6og==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="133164328"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 22:50:57 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH wireless 06/17] wifi: iwlwifi: mld: remove stored_beacon support
Date: Wed, 23 Apr 2025 08:50:25 +0300
Message-Id: <20250423084826.2bb3ea3ff79b.Ie8f1d89f59d45a960a5fe63e7b717527251350ad@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250423055036.2262960-1-miriam.rachel.korenblit@intel.com>
References: <20250423055036.2262960-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

We never ask the firmware to store the beacon, so it won't ever send the
notification.
Remove the handling of that notification.
Remove that notification from the arrays of the notifications' names and
add the ones that we forgot to add.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/mld.c  |  4 +-
 .../net/wireless/intel/iwlwifi/mld/notif.c    | 45 -------------------
 2 files changed, 3 insertions(+), 46 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mld.c b/drivers/net/wireless/intel/iwlwifi/mld/mld.c
index d4a99ae64074..367f9738c011 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mld.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mld.c
@@ -286,7 +286,9 @@ static const struct iwl_hcmd_names iwl_mld_statistics_names[] = {
  * Access is done through binary search
  */
 static const struct iwl_hcmd_names iwl_mld_prot_offload_names[] = {
-	HCMD_NAME(STORED_BEACON_NTF),
+	HCMD_NAME(WOWLAN_WAKE_PKT_NOTIFICATION),
+	HCMD_NAME(WOWLAN_INFO_NOTIFICATION),
+	HCMD_NAME(D3_END_NOTIFICATION),
 };
 
 /* Please keep this array *SORTED* by hex value.
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/notif.c b/drivers/net/wireless/intel/iwlwifi/mld/notif.c
index fc18cba8aaa8..b8a3204c7847 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/notif.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/notif.c
@@ -182,47 +182,6 @@ static void iwl_mld_handle_mu_mimo_grp_notif(struct iwl_mld *mld,
 						   notif);
 }
 
-static void
-iwl_mld_handle_stored_beacon_notif(struct iwl_mld *mld,
-				   struct iwl_rx_packet *pkt)
-{
-	unsigned int pkt_len = iwl_rx_packet_payload_len(pkt);
-	struct iwl_stored_beacon_notif *sb = (void *)pkt->data;
-	struct ieee80211_rx_status rx_status = {};
-	struct sk_buff *skb;
-	u32 size = le32_to_cpu(sb->common.byte_count);
-
-	if (size == 0)
-		return;
-
-	if (pkt_len < struct_size(sb, data, size))
-		return;
-
-	skb = alloc_skb(size, GFP_ATOMIC);
-	if (!skb) {
-		IWL_ERR(mld, "alloc_skb failed\n");
-		return;
-	}
-
-	/* update rx_status according to the notification's metadata */
-	rx_status.mactime = le64_to_cpu(sb->common.tsf);
-	/* TSF as indicated by the firmware  is at INA time */
-	rx_status.flag |= RX_FLAG_MACTIME_PLCP_START;
-	rx_status.device_timestamp = le32_to_cpu(sb->common.system_time);
-	rx_status.band =
-		iwl_mld_phy_band_to_nl80211(le16_to_cpu(sb->common.band));
-	rx_status.freq =
-		ieee80211_channel_to_frequency(le16_to_cpu(sb->common.channel),
-					       rx_status.band);
-
-	/* copy the data */
-	skb_put_data(skb, sb->data, size);
-	memcpy(IEEE80211_SKB_RXCB(skb), &rx_status, sizeof(rx_status));
-
-	/* pass it as regular rx to mac80211 */
-	ieee80211_rx_napi(mld->hw, NULL, skb, NULL);
-}
-
 static void
 iwl_mld_handle_channel_switch_start_notif(struct iwl_mld *mld,
 					  struct iwl_rx_packet *pkt)
@@ -361,8 +320,6 @@ CMD_VERSIONS(ct_kill_notif,
 	     CMD_VER_ENTRY(2, ct_kill_notif))
 CMD_VERSIONS(temp_notif,
 	     CMD_VER_ENTRY(2, iwl_dts_measurement_notif))
-CMD_VERSIONS(stored_beacon_notif,
-	     CMD_VER_ENTRY(4, iwl_stored_beacon_notif))
 CMD_VERSIONS(roc_notif,
 	     CMD_VER_ENTRY(1, iwl_roc_notif))
 CMD_VERSIONS(probe_resp_data_notif,
@@ -473,8 +430,6 @@ const struct iwl_rx_handler iwl_mld_rx_handlers[] = {
 	RX_HANDLER_OF_ROC(MAC_CONF_GROUP, ROC_NOTIF, roc_notif)
 	RX_HANDLER_NO_OBJECT(DATA_PATH_GROUP, MU_GROUP_MGMT_NOTIF,
 			     mu_mimo_grp_notif, RX_HANDLER_SYNC)
-	RX_HANDLER_NO_OBJECT(PROT_OFFLOAD_GROUP, STORED_BEACON_NTF,
-			     stored_beacon_notif, RX_HANDLER_SYNC)
 	RX_HANDLER_OF_VIF(MAC_CONF_GROUP, PROBE_RESPONSE_DATA_NOTIF,
 			  probe_resp_data_notif)
 	RX_HANDLER_NO_OBJECT(PHY_OPS_GROUP, CT_KILL_NOTIFICATION,
-- 
2.34.1


