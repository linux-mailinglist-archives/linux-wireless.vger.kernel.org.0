Return-Path: <linux-wireless+bounces-21887-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61DB1A97F05
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 08:17:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 946507A749E
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 06:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2AC01F30DD;
	Wed, 23 Apr 2025 06:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OIBAe2YQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C343266B65
	for <linux-wireless@vger.kernel.org>; Wed, 23 Apr 2025 06:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745389024; cv=none; b=Hrgswp+EaJJYFoMAC67cYylTamSzyF74wTZohZd6pDojnqiahgokthJgmwKYCcSz3D0wAXYANsmS8DO86nPhx8Jsq4vR0qDGwRbj936a+Aq2r+uDZTcq5yxEfaRpJCRul6jQ1PS59Ok4wu73qcnzRrzBrWdufBjkbC/Up7Dk0hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745389024; c=relaxed/simple;
	bh=E7v+HbxbPv0UBZZyCsSQiz0aYRzKOgZiYHNQEYGcHdk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s/7/rgnRWb44qI02ULfLBnwkVZD74N12bSC/CJEFvZUsDaceDvgrHRc6LBr/s29V/8Rv9RzSKd7r1rBuPzRTcz6ZlpQctnIyOLXlh2WrYKss8BsX0uSN/VGzQHDHvqU2qbB3a9ECm1B0zSskFuTloVS9HWMK0MRSvnEZAbVQurE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OIBAe2YQ; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745389023; x=1776925023;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=E7v+HbxbPv0UBZZyCsSQiz0aYRzKOgZiYHNQEYGcHdk=;
  b=OIBAe2YQOVMp5wyfHDLXO3jWnD/k1qwcDBPSYSqgO6zDd63Bfk8Hfsp8
   ho/duY8sEgeAoPktkcQq4njOAd1AmKeexrYT6MODS2RKYP0jPeh33tIJw
   0JA5XI1455dVaUOH+FUu930f2qcQpBQnwe3ZsBT+D699qBmxVeI00JJ5c
   rhnIWw3ValwHYIibIuLtotLPMCj9kspXK9gMu7A6fyGyQuPiOAKIVs9Xd
   Jfz2NkRCIdIzU6S8HUIScmb2Vz6r34UlB1LOMbzJBD1f6puLf0lhT2i6x
   O8rRpz26EncK4nhKF67BFYemQ76aD26oVOGWbKN4C9y7T0GtXLR9bZIkD
   g==;
X-CSE-ConnectionGUID: h0pqeQR+QgKWRWTJNRffYw==
X-CSE-MsgGUID: cNKyyDY6T/2LdCKqL07kcQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11411"; a="46843629"
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="46843629"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 23:17:02 -0700
X-CSE-ConnectionGUID: O7qkkgv9QfqThDGBCFhPgw==
X-CSE-MsgGUID: sO+W/CIKR/CEsH6nMHusow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="163269039"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 23:17:02 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH wireless-next 06/15] wifi: iwlwifi: mld: remove stored_beacon support
Date: Wed, 23 Apr 2025 09:16:32 +0300
Message-Id: <20250423091408.2bb3ea3ff79b.Ie8f1d89f59d45a960a5fe63e7b717527251350ad@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250423061641.2302908-1-miriam.rachel.korenblit@intel.com>
References: <20250423061641.2302908-1-miriam.rachel.korenblit@intel.com>
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


