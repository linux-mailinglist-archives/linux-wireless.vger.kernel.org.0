Return-Path: <linux-wireless+bounces-21987-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB4DA9ADAE
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 14:39:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 308665A7DAA
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 12:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9BBC1DEFC8;
	Thu, 24 Apr 2025 12:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hWXpJjIV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C117C27B500
	for <linux-wireless@vger.kernel.org>; Thu, 24 Apr 2025 12:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745498342; cv=none; b=Nnwgc3FoQx2sE3kAaQZ4Y98ZWyIdztjymp97Q64Fqx5W5bWf8e8S5esJUL6+GJfKx4mCRSKe5axzD/WjkL7zk02Mham3Nc6FQRNBaFGqrprVny7jxGhdEJ2JkdFNXR10w4JtFxqd61/XZiJ+IEof7p1W6ahSqjwj2Ns0lkWT4WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745498342; c=relaxed/simple;
	bh=y2sm5bgQxC+v4pQNZPBKguGJWNjbVNxn4b9QFLppdiI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BG3iAw0JfQCkJ+5rB4VabvibbXd+CyHwHScApTO4MszozMKyI7gvOc5Ml9+5RNbAX8iq/JIRp1ts7nflbgo+8AYwBL1GyiM+aURZYhkishnwPDTzmTVqx5rf6kZWXuf9dmcM8lf1fWQ+eqg5rRXhrBMSgMDCVIK6LPumnAS43mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hWXpJjIV; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745498340; x=1777034340;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=y2sm5bgQxC+v4pQNZPBKguGJWNjbVNxn4b9QFLppdiI=;
  b=hWXpJjIVG6eUE1hg2qOY3MVReaYGN8L0yrlNUNq/u3sakDcKgr3Fy3BZ
   kEllODRyaOEUq7MZbwHNXHFTRh8SnGOGFh9Zr/qblmggz1RNvd7Aeejqp
   8V+q7aqK2kCVg9R1LZz1pEg4UteKo3ORJf9U3k8DJXiXwRqDiMISO8nIY
   FejgjxZ5Q+Dwxi94eKxhcZT28xXPUEbN3IjUJempMWHq9JoOoDFczj4S1
   eOVMJJhwm6mJ29AscgsIE/PwoI3M2jFuYf1y+yCvHU0ffTd5WRVUVRb9B
   1WVb1mLPRZE3BfRcYbhL3l2BJNfYootwm90vxP3VePTJSbPmGoLsSrXbh
   A==;
X-CSE-ConnectionGUID: OsCjqOu1TNamPmCbIIjzVw==
X-CSE-MsgGUID: WGbkMblBR9Oj8P2vKbhJaw==
X-IronPort-AV: E=McAfee;i="6700,10204,11413"; a="47302424"
X-IronPort-AV: E=Sophos;i="6.15,236,1739865600"; 
   d="scan'208";a="47302424"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 05:38:59 -0700
X-CSE-ConnectionGUID: wxTdCS1aSgu70wL+7vMKdQ==
X-CSE-MsgGUID: fcehO+C5S4i9rxZcmGEjVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,236,1739865600"; 
   d="scan'208";a="133137436"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 05:38:58 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next 08/14] wifi: iwlwifi: clean up band in RX metadata
Date: Thu, 24 Apr 2025 15:38:25 +0300
Message-Id: <20250424153620.c41058510800.Ic3f16ce2f0c991fde2cfe7bcd58ee3b875575fce@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250424123831.3524359-1-miriam.rachel.korenblit@intel.com>
References: <20250424123831.3524359-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Use u8_get_bits() instead of open-coding, and adjust the
name as well. Also don't use enum nl80211_band for the
variable holding an entirely different type.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/rx.h | 16 +++++++++-------
 drivers/net/wireless/intel/iwlwifi/mld/rx.c    |  4 ++--
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c  |  5 +++--
 3 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/rx.h b/drivers/net/wireless/intel/iwlwifi/fw/api/rx.h
index 691c879cb90d..42ddd03c1c65 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/rx.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/rx.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2012-2014, 2018-2024 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2025 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2015-2017 Intel Deutschland GmbH
  */
@@ -193,10 +193,11 @@ enum iwl_rx_mpdu_amsdu_info {
 	IWL_RX_MPDU_AMSDU_LAST_SUBFRAME		= 0x80,
 };
 
-#define RX_MPDU_BAND_POS 6
-#define RX_MPDU_BAND_MASK 0xC0
-#define BAND_IN_RX_STATUS(_val) \
-	(((_val) & RX_MPDU_BAND_MASK) >> RX_MPDU_BAND_POS)
+enum iwl_rx_mpdu_mac_phy_band {
+	IWL_RX_MPDU_MAC_PHY_BAND_MAC_MASK	= 0x0f,
+	IWL_RX_MPDU_MAC_PHY_BAND_PHY_MASK	= 0x30,
+	IWL_RX_MPDU_MAC_PHY_BAND_BAND_MASK	= 0xc0,
+};
 
 enum iwl_rx_l3_proto_values {
 	IWL_RX_L3_TYPE_NONE,
@@ -668,9 +669,10 @@ struct iwl_rx_mpdu_desc {
 	 */
 	__le16 phy_info;
 	/**
-	 * @mac_phy_idx: MAC/PHY index
+	 * @mac_phy_band: MAC ID, PHY ID, band;
+	 *	see &enum iwl_rx_mpdu_mac_phy_band
 	 */
-	u8 mac_phy_idx;
+	u8 mac_phy_band;
 	/* DW4 */
 	union {
 		struct {
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/rx.c b/drivers/net/wireless/intel/iwlwifi/mld/rx.c
index c4f189bcece2..c04097b1c825 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/rx.c
@@ -1739,9 +1739,9 @@ iwl_mld_fill_rx_status_band_freq(struct iwl_mld_rx_phy_data *phy_data,
 				 struct iwl_rx_mpdu_desc *mpdu_desc,
 				 struct ieee80211_rx_status *rx_status)
 {
-	enum nl80211_band band;
+	u8 band = u8_get_bits(mpdu_desc->mac_phy_band,
+			      IWL_RX_MPDU_MAC_PHY_BAND_BAND_MASK);
 
-	band = BAND_IN_RX_STATUS(mpdu_desc->mac_phy_idx);
 	rx_status->band = iwl_mld_phy_band_to_nl80211(band);
 	rx_status->freq = ieee80211_channel_to_frequency(phy_data->channel,
 							 rx_status->band);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index 14ea89f931bb..358643ae0e42 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2012-2014, 2018-2024 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2025 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2015-2017 Intel Deutschland GmbH
  */
@@ -2157,7 +2157,8 @@ void iwl_mvm_rx_mpdu_mq(struct iwl_mvm *mvm, struct napi_struct *napi,
 	}
 
 	if (iwl_mvm_is_band_in_rx_supported(mvm)) {
-		u8 band = BAND_IN_RX_STATUS(desc->mac_phy_idx);
+		u8 band = u8_get_bits(desc->mac_phy_band,
+				      IWL_RX_MPDU_MAC_PHY_BAND_BAND_MASK);
 
 		rx_status->band = iwl_mvm_nl80211_band_from_phy(band);
 	} else {
-- 
2.34.1


