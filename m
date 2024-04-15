Return-Path: <linux-wireless+bounces-6311-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A8CA8A4AED
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Apr 2024 10:55:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56171282BEF
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Apr 2024 08:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A377D446CF;
	Mon, 15 Apr 2024 08:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I+pvEWcn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56F341744
	for <linux-wireless@vger.kernel.org>; Mon, 15 Apr 2024 08:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713171301; cv=none; b=n53DLZ3GMykqLQ8j2xEKoZqMsXiqaDg5pGA4V2uVxf4UEc96V9jTbvddnYsiGf0lAhnEDS5HAWb6kz+1JUH6PP8uj18ScQylH3y/tsZ4T99GWx2r3A+LBssB9sVuYtd4QJZt2/+xYjWJEnix1zyi1EnGOTGSuRQY7Nivx1rjAp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713171301; c=relaxed/simple;
	bh=mdz0a3/v9mF51I5Cl5nJLcAbLuQKCZL3c0+0Liw7t80=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cJd6LhOvnr2SxCEEA1a59iCM14ginArI4F0OYgc0ysqQ1UEI0wtslnbY/w6feX+S/MRsiePfDzbXF7iKPaCzz/aKP1lJ9UKyV23bf7xDY5GRmIjFAQc5yGeMQgajwy28J1+26euDgaT8//4LMvXKt5IBEHoIzv8rWQHWva82jVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I+pvEWcn; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713171300; x=1744707300;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mdz0a3/v9mF51I5Cl5nJLcAbLuQKCZL3c0+0Liw7t80=;
  b=I+pvEWcncw9BRGMApfW4uqYsQ+i7WapjtlVJsgkAavcRZP1DrnCfMQLl
   9kaxuDiHaOLZ2sZ4j2YiAjp1y3wDDDY4VI9S60j6UXFDc8J/WfXLmoN5i
   a82NX1BKkzGt8eBehEw0ApbSPbncPMB7dncGBXCbyHzMh0l0FC4M8yJSd
   SLZmtVLZDAqG1Si/A0evE21z/Mh6n6if1llny3QPCQZWbbAIy/rOmkBEW
   IXXpSraHuB4kC5gp/D7SBpq7mMPVmHQjhdgciwxDdCB099HM+e/xvDCDH
   w0A3nG1yLMhrnL2/GsaZjRScWbq3lt0VciF41Z7oIFpvWeIZGPjg/uDBy
   w==;
X-CSE-ConnectionGUID: VH+QXrpSRheSK2aD7YOGqQ==
X-CSE-MsgGUID: btc/NsCRSjS+8Z/h3jZz9A==
X-IronPort-AV: E=McAfee;i="6600,9927,11044"; a="9100586"
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; 
   d="scan'208";a="9100586"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 01:55:00 -0700
X-CSE-ConnectionGUID: zLJsTbylQ56mtdESm1vS2Q==
X-CSE-MsgGUID: DH/jmzGsSyiqOZWr4Kgdrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; 
   d="scan'208";a="21767967"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 01:54:58 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Benjamin Berg <benjamin.berg@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 03/11] wifi: iwlwifi: mvm: move phy band to nl80211 band helper
Date: Mon, 15 Apr 2024 11:54:36 +0300
Message-Id: <20240415114847.8e456d6c599e.Ibaa76864b30c990bfc35d886ec1344d513a96d14@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240415085444.3840884-1-miriam.rachel.korenblit@intel.com>
References: <20240415085444.3840884-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Benjamin Berg <benjamin.berg@intel.com>

This function is useful in other places, so move it in order to share
it.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  | 15 +++++++++++++++
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c | 17 +----------------
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 5062298c8140..a3f42dec97d2 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -2464,6 +2464,21 @@ static inline u8 iwl_mvm_phy_band_from_nl80211(enum nl80211_band band)
 	}
 }
 
+static inline u8 iwl_mvm_nl80211_band_from_phy(u8 phy_band)
+{
+	switch (phy_band) {
+	case PHY_BAND_24:
+		return NL80211_BAND_2GHZ;
+	case PHY_BAND_5:
+		return NL80211_BAND_5GHZ;
+	case PHY_BAND_6:
+		return NL80211_BAND_6GHZ;
+	default:
+		WARN_ONCE(1, "Unsupported phy band (%u)\n", phy_band);
+		return NL80211_BAND_5GHZ;
+	}
+}
+
 /* Channel Switch */
 void iwl_mvm_channel_switch_disconnect_wk(struct work_struct *wk);
 int iwl_mvm_post_channel_switch(struct ieee80211_hw *hw,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index ce8d83c771a7..dc074fcf41a0 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -1890,21 +1890,6 @@ static void iwl_mvm_decode_lsig(struct sk_buff *skb,
 	}
 }
 
-static inline u8 iwl_mvm_nl80211_band_from_rx_msdu(u8 phy_band)
-{
-	switch (phy_band) {
-	case PHY_BAND_24:
-		return NL80211_BAND_2GHZ;
-	case PHY_BAND_5:
-		return NL80211_BAND_5GHZ;
-	case PHY_BAND_6:
-		return NL80211_BAND_6GHZ;
-	default:
-		WARN_ONCE(1, "Unsupported phy band (%u)\n", phy_band);
-		return NL80211_BAND_5GHZ;
-	}
-}
-
 struct iwl_rx_sta_csa {
 	bool all_sta_unblocked;
 	struct ieee80211_vif *vif;
@@ -2168,7 +2153,7 @@ void iwl_mvm_rx_mpdu_mq(struct iwl_mvm *mvm, struct napi_struct *napi,
 	if (iwl_mvm_is_band_in_rx_supported(mvm)) {
 		u8 band = BAND_IN_RX_STATUS(desc->mac_phy_idx);
 
-		rx_status->band = iwl_mvm_nl80211_band_from_rx_msdu(band);
+		rx_status->band = iwl_mvm_nl80211_band_from_phy(band);
 	} else {
 		rx_status->band = phy_data.channel > 14 ? NL80211_BAND_5GHZ :
 			NL80211_BAND_2GHZ;
-- 
2.34.1


