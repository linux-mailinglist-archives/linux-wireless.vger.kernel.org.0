Return-Path: <linux-wireless+bounces-26509-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D3E5EB2F8B8
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Aug 2025 14:49:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CAD37BB1B2
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Aug 2025 12:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 554E0327780;
	Thu, 21 Aug 2025 12:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C3mYPZ8G"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF622311C3C
	for <linux-wireless@vger.kernel.org>; Thu, 21 Aug 2025 12:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755780319; cv=none; b=sPhnOBMQRp/ZQkaujmaa8eZW9U6hKuCY677swybwB5BpLUGzw/2vsyslWJqDyZ7HzCnZ9NoxSEc3SiMjKhdG3V0nMDVLU56t5VGlMo/VzWRQzf567/V6Zk35bWQKTbHYAF28aAH4FxDjsBvQLOyFBbKGQMMBiGe3uk2EbNbu43M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755780319; c=relaxed/simple;
	bh=60MIe90YO2J1AnPxOb3ycDAwOCRAzfrMK6Fh6ffV50Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZpqfnsVgiugE2od6HcJtt6d8FHf2L+uqTvUS5JlyAB1UVyBNxa3hCf2zFUPKSf5+CWM+S7hx5uWkSCdUGC7KmKKLPusf5IkpC0iINwilg0VSUDpTDhVFgDJ0M2CEovS1dPuQaozrdI4ZY4237QbccbqBGc3Ginlyn774OfBW6Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C3mYPZ8G; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755780318; x=1787316318;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=60MIe90YO2J1AnPxOb3ycDAwOCRAzfrMK6Fh6ffV50Q=;
  b=C3mYPZ8G0UZA12jVGGhP7lhxVjDOcfNTJUmGUwWWPyfx1wrT5uY4XJIQ
   +mU0Eyx3TgOrX0zBKZeEUGVeb8i4NXAfNNBp4EbxFF4xD0ieqg+X7PS7o
   advyj5FCZnflLUex5Nu0Kohye+k+oU92At8pkHB+tstXYsyZA5Xi3CmdI
   cP398VJP2SPcIP09ZNKh9b1ayme04aNmm36WJxavZ8LwA2NLqO1fZLCle
   7ZIQDkKT5aFwk1DD1ou06RQqHEH5wQCR06dnHNR2Guv3gQongcdX/CTCF
   pb2P5Gpte0VThbDOKsAPNuo8h66ztkS1aSia5ugx33uq3OlIfgugoTNYC
   Q==;
X-CSE-ConnectionGUID: CVyfLEl1T3mZ/8Eo4U5Xqw==
X-CSE-MsgGUID: fc4qrcbiTqWbzODr1w5NvA==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="61895768"
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="61895768"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 05:45:18 -0700
X-CSE-ConnectionGUID: KsxSOMJsQ6Sj8lIeqy9Jhg==
X-CSE-MsgGUID: Fum62nESRwunDewaXpDlpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="172622227"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 05:45:17 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 14/15] wifi: iwlwifi: mld: rename iwl_mld_set_key_rx_seq
Date: Thu, 21 Aug 2025 15:44:32 +0300
Message-Id: <20250821154216.ebf93a07905a.I8380b5cf9f6095b3a0b35fe4b7d56c544b921600@changeid>
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

This function should only be used for group keys. For pairwise keys we
have iwl_mld_update_ptk_rx_seq. Make that clear from the name.

Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/d3.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/d3.c b/drivers/net/wireless/intel/iwlwifi/mld/d3.c
index db0c83a425fa..b27b874b3e84 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/d3.c
@@ -679,8 +679,8 @@ iwl_mld_set_key_rx_seq_tids(struct ieee80211_key_conf *key,
 }
 
 static void
-iwl_mld_set_key_rx_seq(struct ieee80211_key_conf *key,
-		       struct iwl_mld_mcast_key_data *key_data)
+iwl_mld_update_mcast_rx_seq(struct ieee80211_key_conf *key,
+			    struct iwl_mld_mcast_key_data *key_data)
 {
 	switch (key->cipher) {
 	case WLAN_CIPHER_SUITE_CCMP:
@@ -768,7 +768,7 @@ iwl_mld_resume_keys_iter(struct ieee80211_hw *hw,
 		}
 
 		status_idx = key->keyidx == wowlan_status->gtk[1].id;
-		iwl_mld_set_key_rx_seq(key, &wowlan_status->gtk[status_idx]);
+		iwl_mld_update_mcast_rx_seq(key, &wowlan_status->gtk[status_idx]);
 		break;
 	case WLAN_CIPHER_SUITE_BIP_GMAC_128:
 	case WLAN_CIPHER_SUITE_BIP_GMAC_256:
@@ -776,11 +776,13 @@ iwl_mld_resume_keys_iter(struct ieee80211_hw *hw,
 	case WLAN_CIPHER_SUITE_AES_CMAC:
 		if (key->keyidx == 4 || key->keyidx == 5) {
 			if (key->keyidx == wowlan_status->igtk.id)
-				iwl_mld_set_key_rx_seq(key, &wowlan_status->igtk);
+				iwl_mld_update_mcast_rx_seq(key,
+							    &wowlan_status->igtk);
 		}
 		if (key->keyidx == 6 || key->keyidx == 7) {
 			status_idx = key->keyidx == wowlan_status->bigtk[1].id;
-			iwl_mld_set_key_rx_seq(key, &wowlan_status->bigtk[status_idx]);
+			iwl_mld_update_mcast_rx_seq(key,
+						    &wowlan_status->bigtk[status_idx]);
 		}
 		break;
 	default:
@@ -807,7 +809,7 @@ iwl_mld_add_mcast_rekey(struct ieee80211_vif *vif,
 	if (IS_ERR(key_config))
 		return;
 
-	iwl_mld_set_key_rx_seq(key_config, key_data);
+	iwl_mld_update_mcast_rx_seq(key_config, key_data);
 
 	/* The FW holds only one igtk so we keep track of the valid one */
 	if (key_config->keyidx == 4 || key_config->keyidx == 5) {
-- 
2.34.1


