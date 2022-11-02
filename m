Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4D6C61657C
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Nov 2022 16:01:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbiKBPBF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Nov 2022 11:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbiKBPBE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Nov 2022 11:01:04 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D1D248DC
        for <linux-wireless@vger.kernel.org>; Wed,  2 Nov 2022 08:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667401262; x=1698937262;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=de7wyC9ZrDpWLJM2ytzWDW6f/dzy7dRPDfoGE5P3e00=;
  b=frdqxc0ELa9q4y/T56mk6oheuGvmDU0kHmpUhLdtNQV76CRichu2svIl
   lS48HW4FMOe15def4UhDl+sDfjxB44AtLEZBFX4dJn9OogSa615zrxYbM
   xZFwHezs7QrAcy/ADJhusrgEsetP0kWXqDhF3ineEQ3DSEC1H0BxCLYl+
   EflL5EmnYjBu34hnHCSH2UFHwf7KFIA4sa0t8jeeXFDyP60Nf6BYrMd7o
   mYu4PLqj7Yg1XchRpw5T5Af30vhEhx2k1daxyBPxv+2H+vdoMwml+4WUV
   C10DLx+S/1412Y/3Aq1JHQj4AcmCNf7eztZdwUKHErlzfxZq/l+h6qWVR
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="371523529"
X-IronPort-AV: E=Sophos;i="5.95,234,1661842800"; 
   d="scan'208";a="371523529"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2022 08:00:52 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="636810617"
X-IronPort-AV: E=Sophos;i="5.95,234,1661842800"; 
   d="scan'208";a="636810617"
Received: from apetrush-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.251.180.25])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2022 08:00:50 -0700
From:   gregory.greenman@intel.com
To:     kvalo@kernel.org, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, Ilan Peer <ilan.peer@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 07/11] wifi: iwlwifi: mvm: Fix getting the lowest rate
Date:   Wed,  2 Nov 2022 16:59:54 +0200
Message-Id: <20221102165239.be8403f0d5c0.I7d141646746b96310efd75fc77ca9aebc61aefcc@changeid>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221102145958.342864-1-gregory.greenman@intel.com>
References: <20221102145958.342864-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ilan Peer <ilan.peer@intel.com>

When setting the rate for Tx, the code tried to get the lowest
allowed rate but without considering the BSS basic rates. Fix this
by considering the basic rates.

In addition, declare support for configuring beacon Tx rate and when
configured use the configured Tx beacon rate to set beacon tx command rate.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/debugfs.c  |  4 +-
 .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c | 60 ++++++++++++++++---
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  3 +
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  3 +-
 4 files changed, 59 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
index 1e8123140973..1ce9450e5add 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2012-2014, 2018-2021 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2022 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -1248,7 +1248,7 @@ static int _iwl_dbgfs_inject_beacon_ie(struct iwl_mvm *mvm, char *bin, int len)
 
 	mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	info = IEEE80211_SKB_CB(beacon);
-	rate = iwl_mvm_mac_ctxt_get_lowest_rate(info, vif);
+	rate = iwl_mvm_mac_ctxt_get_beacon_rate(mvm, info, vif);
 
 	beacon_cmd.flags =
 		cpu_to_le16(iwl_mvm_mac_ctxt_get_beacon_flags(mvm->fw, rate));
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
index de0c545d50fd..83abfe996138 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
@@ -788,14 +788,40 @@ static u32 iwl_mvm_find_ie_offset(u8 *beacon, u8 eid, u32 frame_size)
 	return ie - beacon;
 }
 
-u8 iwl_mvm_mac_ctxt_get_lowest_rate(struct ieee80211_tx_info *info,
-				    struct ieee80211_vif *vif)
+static u8 iwl_mvm_mac_ctxt_get_lowest_rate(struct iwl_mvm *mvm,
+					   struct ieee80211_tx_info *info,
+					   struct ieee80211_vif *vif)
 {
+	struct ieee80211_supported_band *sband;
+	unsigned long basic = vif->bss_conf.basic_rates;
+	u16 lowest_cck = IWL_RATE_COUNT, lowest_ofdm = IWL_RATE_COUNT;
 	u8 rate;
-	if (info->band == NL80211_BAND_2GHZ && !vif->p2p)
-		rate = IWL_FIRST_CCK_RATE;
-	else
-		rate = IWL_FIRST_OFDM_RATE;
+	u32 i;
+
+	sband = mvm->hw->wiphy->bands[info->band];
+	for_each_set_bit(i, &basic, BITS_PER_LONG) {
+		u16 hw = sband->bitrates[i].hw_value;
+
+		if (hw >= IWL_FIRST_OFDM_RATE) {
+			if (lowest_ofdm > hw)
+				lowest_ofdm = hw;
+		} else if (lowest_cck > hw) {
+			lowest_cck = hw;
+		}
+	}
+
+	if (info->band == NL80211_BAND_2GHZ && !vif->p2p) {
+		if (lowest_cck != IWL_RATE_COUNT)
+			rate = lowest_cck;
+		else if (lowest_ofdm != IWL_RATE_COUNT)
+			rate = lowest_ofdm;
+		else
+			rate = IWL_RATE_1M_INDEX;
+	} else if (lowest_ofdm != IWL_RATE_COUNT) {
+		rate = lowest_ofdm;
+	} else {
+		rate = IWL_RATE_6M_INDEX;
+	}
 
 	return rate;
 }
@@ -812,6 +838,24 @@ u16 iwl_mvm_mac_ctxt_get_beacon_flags(const struct iwl_fw *fw, u8 rate_idx)
 	return flags;
 }
 
+u8 iwl_mvm_mac_ctxt_get_beacon_rate(struct iwl_mvm *mvm,
+				    struct ieee80211_tx_info *info,
+				    struct ieee80211_vif *vif)
+{
+	struct ieee80211_supported_band *sband =
+		mvm->hw->wiphy->bands[info->band];
+	u32 legacy = vif->bss_conf.beacon_tx_rate.control[info->band].legacy;
+
+	/* if beacon rate was configured try using it */
+	if (hweight32(legacy) == 1) {
+		u32 rate = ffs(legacy) - 1;
+
+		return sband->bitrates[rate].hw_value;
+	}
+
+	return iwl_mvm_mac_ctxt_get_lowest_rate(mvm, info, vif);
+}
+
 static void iwl_mvm_mac_ctxt_set_tx(struct iwl_mvm *mvm,
 				    struct ieee80211_vif *vif,
 				    struct sk_buff *beacon,
@@ -842,7 +886,7 @@ static void iwl_mvm_mac_ctxt_set_tx(struct iwl_mvm *mvm,
 		cpu_to_le32(BIT(mvm->mgmt_last_antenna_idx) <<
 			    RATE_MCS_ANT_POS);
 
-	rate = iwl_mvm_mac_ctxt_get_lowest_rate(info, vif);
+	rate = iwl_mvm_mac_ctxt_get_beacon_rate(mvm, info, vif);
 
 	tx->rate_n_flags |=
 		cpu_to_le32(iwl_mvm_mac80211_idx_to_hwrate(mvm->fw, rate));
@@ -926,7 +970,7 @@ static int iwl_mvm_mac_ctxt_send_beacon_v9(struct iwl_mvm *mvm,
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(beacon);
 	struct iwl_mac_beacon_cmd beacon_cmd = {};
-	u8 rate = iwl_mvm_mac_ctxt_get_lowest_rate(info, vif);
+	u8 rate = iwl_mvm_mac_ctxt_get_beacon_rate(mvm, info, vif);
 	u16 flags;
 	struct ieee80211_chanctx_conf *ctx;
 	int channel;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index e923e9a75c92..a81dd488caa8 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -374,6 +374,9 @@ int iwl_mvm_mac_setup_register(struct iwl_mvm *mvm)
 		hw->wiphy->n_cipher_suites++;
 	}
 
+	wiphy_ext_feature_set(hw->wiphy,
+			      NL80211_EXT_FEATURE_BEACON_RATE_LEGACY);
+
 	if (fw_has_capa(&mvm->fw->ucode_capa,
 			IWL_UCODE_TLV_CAPA_FTM_CALIBRATED)) {
 		wiphy_ext_feature_set(hw->wiphy,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 19d7a4f4ccdc..962e304fc2b1 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1644,7 +1644,8 @@ int iwl_mvm_mac_ctxt_send_beacon(struct iwl_mvm *mvm,
 int iwl_mvm_mac_ctxt_send_beacon_cmd(struct iwl_mvm *mvm,
 				     struct sk_buff *beacon,
 				     void *data, int len);
-u8 iwl_mvm_mac_ctxt_get_lowest_rate(struct ieee80211_tx_info *info,
+u8 iwl_mvm_mac_ctxt_get_beacon_rate(struct iwl_mvm *mvm,
+				    struct ieee80211_tx_info *info,
 				    struct ieee80211_vif *vif);
 u16 iwl_mvm_mac_ctxt_get_beacon_flags(const struct iwl_fw *fw,
 				      u8 rate_idx);
-- 
2.35.3

