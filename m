Return-Path: <linux-wireless+bounces-22392-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7DDBAA85F5
	for <lists+linux-wireless@lfdr.de>; Sun,  4 May 2025 12:27:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C2841788A6
	for <lists+linux-wireless@lfdr.de>; Sun,  4 May 2025 10:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F671A83E8;
	Sun,  4 May 2025 10:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QNL/bWMB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AAC71A5B99
	for <linux-wireless@vger.kernel.org>; Sun,  4 May 2025 10:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746354421; cv=none; b=eUW0hGrKgfRmMV+vMj4eOY41b/nGABtbWX/hlyhdM1pAHleO73H98c1Syla1F7Air/EvC3GWlBERx2FUfvKQTrxrpPUubvNTcrKMd4ibTJkqX8TqIQu665jusAWg7mt37uNnj2YyNsCJOrI6hzaa7xCdudZ37PNgYh5ZP1PA95c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746354421; c=relaxed/simple;
	bh=/72RCLHTGfJLGZQhnmmgarSNp6wuc5+bM3RbBbzbsJk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jy3DD1un8VKAP45Q8V64fUQRRrIu0YoM5XYPEV8kywBlh94LqRF3w6+po+0XPGmALG+pikH2847LRgdexTbVg38Fbss276o58W9QY/CDdd+gn29nrL0fwizUCVfgOZPsCBGucZ6oRnYDvV/aBty3WHRdDndb5WSfMa0HFCxX+68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QNL/bWMB; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746354420; x=1777890420;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/72RCLHTGfJLGZQhnmmgarSNp6wuc5+bM3RbBbzbsJk=;
  b=QNL/bWMB7XlmMieOFQDifmqjjYYx6b2KjLshhF+IoGjKrjrG55KQnfRC
   Xc53uZ/ce/qBHJXVShmDCx+r4g63yecqpIeTT1rmhJbuo80iBQXKDZIZb
   7wPMspgvlWyaDu0XIu6EJ7spQfBtK/rSVgCWvCpBdI3F6Qoql2XQpRPHY
   SK/C99bugzROzX52sJ/sX5PNAo8hvj5k7dLwReOdW4vfUvot58pfNM3N6
   L3LynCfvi8u1e7w17soNIbPvlIClBLtHgg+IehusqJCyBNZVDWS30aTtx
   cv8mhlstB4bGttEJXuPG7feE9eCxT7C7c8aCQK/l9rGQLu3iEoJdjvrdt
   w==;
X-CSE-ConnectionGUID: n9LNpkh3R/ac2bxRq/BhQA==
X-CSE-MsgGUID: 2FluJUdGSo2nW2Rtmw9sVw==
X-IronPort-AV: E=McAfee;i="6700,10204,11422"; a="65511490"
X-IronPort-AV: E=Sophos;i="6.15,261,1739865600"; 
   d="scan'208";a="65511490"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2025 03:27:00 -0700
X-CSE-ConnectionGUID: 6KeWEVTmRxaa/VA8r5R73w==
X-CSE-MsgGUID: bgSKoh7MSkGAJsVjxK9xxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,261,1739865600"; 
   d="scan'208";a="139778882"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2025 03:26:58 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 07/15] wifi: iwlwifi: mld: build HT/VHT injected rate in v2
Date: Sun,  4 May 2025 13:26:22 +0300
Message-Id: <20250504132447.0e6e4ae4469f.Ib49eda9a3083b2e0f0bcaff08ad784e151978307@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250504102630.757937-1-miriam.rachel.korenblit@intel.com>
References: <20250504102630.757937-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Instead of building the injected rate in version 1 of the
format and then converting, build it in version 2 directly.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/tx.c | 41 +++++++++------------
 1 file changed, 17 insertions(+), 24 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/tx.c b/drivers/net/wireless/intel/iwlwifi/mld/tx.c
index a6e312b1edbe..c25222116075 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/tx.c
@@ -425,47 +425,40 @@ static u32 iwl_mld_get_inject_tx_rate(struct iwl_mld *mld,
 	struct ieee80211_tx_rate *rate = &info->control.rates[0];
 	u32 result;
 
-	/* we only care about legacy/HT/VHT so far, so we can
-	 * build in v1 and use iwl_new_rate_from_v1()
-	 * FIXME: in newer devices we only support the new rates, build
-	 * the rate_n_flags in the new format here instead of using v1 and
-	 * converting it.
-	 */
-
 	if (rate->flags & IEEE80211_TX_RC_VHT_MCS) {
 		u8 mcs = ieee80211_rate_get_vht_mcs(rate);
 		u8 nss = ieee80211_rate_get_vht_nss(rate);
 
-		result = RATE_MCS_VHT_MSK_V1;
-		result |= u32_encode_bits(mcs, RATE_VHT_MCS_RATE_CODE_MSK);
+		result = RATE_MCS_MOD_TYPE_VHT;
+		result |= u32_encode_bits(mcs, RATE_MCS_CODE_MSK);
 		result |= u32_encode_bits(nss, RATE_MCS_NSS_MSK);
 
 		if (rate->flags & IEEE80211_TX_RC_SHORT_GI)
-			result |= RATE_MCS_SGI_MSK_V1;
+			result |= RATE_MCS_SGI_MSK;
 
 		if (rate->flags & IEEE80211_TX_RC_40_MHZ_WIDTH)
-			result |= u32_encode_bits(1, RATE_MCS_CHAN_WIDTH_MSK_V1);
+			result |= RATE_MCS_CHAN_WIDTH_40;
 		else if (rate->flags & IEEE80211_TX_RC_80_MHZ_WIDTH)
-			result |= u32_encode_bits(2, RATE_MCS_CHAN_WIDTH_MSK_V1);
+			result |= RATE_MCS_CHAN_WIDTH_80;
 		else if (rate->flags & IEEE80211_TX_RC_160_MHZ_WIDTH)
-			result |= u32_encode_bits(3, RATE_MCS_CHAN_WIDTH_MSK_V1);
-
-		result = iwl_new_rate_from_v1(result);
+			result |= RATE_MCS_CHAN_WIDTH_160;
 	} else if (rate->flags & IEEE80211_TX_RC_MCS) {
-		result = RATE_MCS_HT_MSK_V1;
-		result |= u32_encode_bits(rate->idx,
-					  RATE_HT_MCS_RATE_CODE_MSK_V1 |
-					  RATE_HT_MCS_NSS_MSK_V1);
+		/* only MCS 0-15 are supported */
+		u8 mcs = rate->idx & 7;
+		u8 nss = rate->idx > 7;
+
+		result = RATE_MCS_MOD_TYPE_HT;
+		result |= u32_encode_bits(mcs, RATE_MCS_CODE_MSK);
+		result |= u32_encode_bits(nss, RATE_MCS_NSS_MSK);
+
 		if (rate->flags & IEEE80211_TX_RC_SHORT_GI)
-			result |= RATE_MCS_SGI_MSK_V1;
+			result |= RATE_MCS_SGI_MSK;
 		if (rate->flags & IEEE80211_TX_RC_40_MHZ_WIDTH)
-			result |= u32_encode_bits(1, RATE_MCS_CHAN_WIDTH_MSK_V1);
+			result |= RATE_MCS_CHAN_WIDTH_40;
 		if (info->flags & IEEE80211_TX_CTL_LDPC)
-			result |= RATE_MCS_LDPC_MSK_V1;
+			result |= RATE_MCS_LDPC_MSK;
 		if (u32_get_bits(info->flags, IEEE80211_TX_CTL_STBC))
 			result |= RATE_MCS_STBC_MSK;
-
-		result = iwl_new_rate_from_v1(result);
 	} else {
 		result = iwl_mld_mac80211_rate_idx_to_fw(mld, info, rate->idx);
 	}
-- 
2.34.1


