Return-Path: <linux-wireless+bounces-2734-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 309DA84134A
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 20:23:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC21228A2F5
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 19:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 904D64CB58;
	Mon, 29 Jan 2024 19:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jcvilkBs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D956A6F09C
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jan 2024 19:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706556174; cv=none; b=XvNgrGIkKq1lZAdXXPlGOibaf8cFLniAuqj8J/uSEeVkUdLqJhHZQwBXRIKM9K3qZEkYPDc7TPEcJnPzkPFB/BPooOh3CGS+uzmdk76ldHAs9QGG8aeGXnRjG6EUU2cIle9XA5YfouqpOlXwWC8OZErcfaWIUsBcgxtVeUnzhqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706556174; c=relaxed/simple;
	bh=c+vPDkmwUSa32ZO96dg7yOMX2CuR9fbYM7OUZ7/mxKQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rmW6/9w7r8HyV7cFiFEly26Jg6Tdx1H+JoWYyFX0ZxffGiHfYL2WZBBcECGdhZNektNb7ADK39zU57G/XeK//dSJD4alyEGOFK/DlxwwOX00Ba9aGBmct1ocCVNCecd1YaOLQc2bYmU8e5M5jHrnbRpRVCSZhmuIZGfcIrF2IsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jcvilkBs; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706556173; x=1738092173;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=c+vPDkmwUSa32ZO96dg7yOMX2CuR9fbYM7OUZ7/mxKQ=;
  b=jcvilkBsWY2owA1KPjE8GEX4kDO2ve84amO4XuVP0D7YF47ymXUOuttB
   6+THn0UNJqo2FPNYD81eAQJWLiyD/DVuepIoAbvbJo2205BNCqRnZSsp7
   9afPCB3Zzfd9EBBRjJgtxJIz0Rcv8LGcJy66scBukOZivrfFLN5SsJqKq
   P9uyuhuA6Art4Q4c3cgm14Ow3/EQnxgWbbzGf7eJNmpDhphrl3cYnSL9n
   vCqk4QAY4hApyZqTTyhQ7clG/47RMvso5KmGMVF/bUiX1mrlEYvRNhgov
   H1aJ6Nu0RZRIHw60UZYIgOtYuK/N2805cmQwqpS0XALA7elmXqtENptHW
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="2943065"
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="2943065"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 11:22:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="3459161"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 11:22:51 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Daniel Gabay <daniel.gabay@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 13/15] wifi: iwlwifi: mvm: support SPP A-MSDUs
Date: Mon, 29 Jan 2024 21:22:01 +0200
Message-Id: <20240129211905.15e4570e471f.I87cf284d3b19bb9f5558f0f33afaace6d6492acb@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129192203.4189915-1-miriam.rachel.korenblit@intel.com>
References: <20240129192203.4189915-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

If the firmware has the necessary support, enable SPP A-MSDUs.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Daniel Gabay <daniel.gabay@intel.com>
Reviewed-by: Gregory Greenman <gregory.greenman@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/sta.h   | 4 +++-
 drivers/net/wireless/intel/iwlwifi/fw/file.h      | 3 +++
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 5 +++++
 drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c  | 3 +++
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c      | 3 +++
 5 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/sta.h b/drivers/net/wireless/intel/iwlwifi/fw/api/sta.h
index d62fed543276..d7f8a276b683 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/sta.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/sta.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2012-2014, 2018-2021 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2021, 2023 Intel Corporation
  * Copyright (C) 2013-2014 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -109,6 +109,7 @@ enum iwl_sta_flags {
  * @STA_KEY_FLG_EN_MSK: mask for encryption algorithmi value
  * @STA_KEY_FLG_WEP_KEY_MAP: wep is either a group key (0 - legacy WEP) or from
  *	station info array (1 - n 1X mode)
+ * @STA_KEY_FLG_AMSDU_SPP: SPP (signaling and payload protected) A-MSDU
  * @STA_KEY_FLG_KEYID_MSK: the index of the key
  * @STA_KEY_FLG_KEYID_POS: key index bit position
  * @STA_KEY_NOT_VALID: key is invalid
@@ -129,6 +130,7 @@ enum iwl_sta_key_flag {
 	STA_KEY_FLG_EN_MSK		= (7 << 0),
 
 	STA_KEY_FLG_WEP_KEY_MAP		= BIT(3),
+	STA_KEY_FLG_AMSDU_SPP		= BIT(7),
 	STA_KEY_FLG_KEYID_POS		 = 8,
 	STA_KEY_FLG_KEYID_MSK		= (3 << STA_KEY_FLG_KEYID_POS),
 	STA_KEY_NOT_VALID		= BIT(11),
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/file.h b/drivers/net/wireless/intel/iwlwifi/fw/file.h
index bfc39bd5bbc6..b216da7d95fc 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/file.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/file.h
@@ -383,6 +383,8 @@ typedef unsigned int __bitwise iwl_ucode_tlv_capa_t;
  *      channels even when these are not enabled.
  * @IWL_UCODE_TLV_CAPA_DUMP_COMPLETE_SUPPORT: Support for indicating dump collection
  *	complete to FW.
+ * @IWL_UCODE_TLV_CAPA_SPP_AMSDU_SUPPORT: Support SPP (signaling and payload
+ *	protected) A-MSDU.
  *
  * @NUM_IWL_UCODE_TLV_CAPA: number of bits used
  */
@@ -468,6 +470,7 @@ enum iwl_ucode_tlv_capa {
 	IWL_UCODE_TLV_CAPA_PSC_CHAN_SUPPORT		= (__force iwl_ucode_tlv_capa_t)98,
 
 	IWL_UCODE_TLV_CAPA_BIGTK_SUPPORT		= (__force iwl_ucode_tlv_capa_t)100,
+	IWL_UCODE_TLV_CAPA_SPP_AMSDU_SUPPORT		= (__force iwl_ucode_tlv_capa_t)103,
 	IWL_UCODE_TLV_CAPA_DRAM_FRAG_SUPPORT		= (__force iwl_ucode_tlv_capa_t)104,
 	IWL_UCODE_TLV_CAPA_DUMP_COMPLETE_SUPPORT	= (__force iwl_ucode_tlv_capa_t)105,
 	IWL_UCODE_TLV_CAPA_SYNCED_TIME			= (__force iwl_ucode_tlv_capa_t)106,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 0ec1156c89c5..843544cfcfe9 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -495,6 +495,11 @@ int iwl_mvm_mac_setup_register(struct iwl_mvm *mvm)
 			IWL_UCODE_TLV_CAPA_TIME_SYNC_BOTH_FTM_TM))
 		hw->wiphy->hw_timestamp_max_peers = 1;
 
+	if (fw_has_capa(&mvm->fw->ucode_capa,
+			IWL_UCODE_TLV_CAPA_SPP_AMSDU_SUPPORT))
+		wiphy_ext_feature_set(hw->wiphy,
+				      NL80211_EXT_FEATURE_SPP_AMSDU_SUPPORT);
+
 	ieee80211_hw_set(hw, SINGLE_SCAN_ON_ALL_BANDS);
 	hw->wiphy->features |=
 		NL80211_FEATURE_SCHED_SCAN_RANDOM_MAC_ADDR |
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c
index a1ce08a5527c..bbd37a95d4c8 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c
@@ -104,6 +104,9 @@ u32 iwl_mvm_get_sec_flags(struct iwl_mvm *mvm,
 	     (keyconf->keyidx == 4 || keyconf->keyidx == 5)))
 		flags |= IWL_SEC_KEY_FLAG_MFP;
 
+	if (keyconf->flags & IEEE80211_KEY_FLAG_SPP_AMSDU)
+		flags |= IWL_SEC_KEY_FLAG_SPP_AMSDU;
+
 	return flags;
 }
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index d57fcbe4f8ac..8ffbb8efda73 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -3559,6 +3559,9 @@ static int iwl_mvm_send_sta_key(struct iwl_mvm *mvm,
 	key_flags = cpu_to_le16(keyidx);
 	key_flags |= cpu_to_le16(STA_KEY_FLG_WEP_KEY_MAP);
 
+	if (key->flags & IEEE80211_KEY_FLAG_SPP_AMSDU)
+		key_flags |= cpu_to_le16(STA_KEY_FLG_AMSDU_SPP);
+
 	switch (key->cipher) {
 	case WLAN_CIPHER_SUITE_TKIP:
 		key_flags |= cpu_to_le16(STA_KEY_FLG_TKIP);
-- 
2.34.1


