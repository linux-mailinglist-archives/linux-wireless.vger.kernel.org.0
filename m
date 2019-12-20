Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E9F1127A5A
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Dec 2019 12:56:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727400AbfLTL4y (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Dec 2019 06:56:54 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:54002 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727391AbfLTL4y (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Dec 2019 06:56:54 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <luca@coelho.fi>)
        id 1iiGtn-0007ip-AV; Fri, 20 Dec 2019 13:56:51 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 20 Dec 2019 13:56:36 +0200
Message-Id: <20191220115638.1299888-9-luca@coelho.fi>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191220115638.1299888-1-luca@coelho.fi>
References: <20191220115638.1299888-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.2
Subject: [PATCH v5.5 08/10] iwlwifi: mvm: report TX rate to mac80211 directly for RS offload
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

If we have offloaded rate scaling, which is always true for those
devices supporting HE, then report the TX rate directly from the
data the firmware gives us, instead of only passing it to mac80211
on frame status only and for it to track it.

First of all, this makes us always report the last good rate that
the rate scaling algorithm picked, which is better than reporting
the last rate for any frame since management frames etc. are sent
with very low rates and could interfere.

Additionally, this allows us to properly report HE rates, though
in case there's a lot of trigger-based traffic, we don't get any
choice in the rates and don't report that properly right now.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 126 ++++++++++++++++++
 1 file changed, 126 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 32dc9d6f0fb6..481f1c9d814f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -4771,6 +4771,125 @@ static int iwl_mvm_mac_get_survey(struct ieee80211_hw *hw, int idx,
 	return ret;
 }
 
+static void iwl_mvm_set_sta_rate(u32 rate_n_flags, struct rate_info *rinfo)
+{
+	switch (rate_n_flags & RATE_MCS_CHAN_WIDTH_MSK) {
+	case RATE_MCS_CHAN_WIDTH_20:
+		rinfo->bw = RATE_INFO_BW_20;
+		break;
+	case RATE_MCS_CHAN_WIDTH_40:
+		rinfo->bw = RATE_INFO_BW_40;
+		break;
+	case RATE_MCS_CHAN_WIDTH_80:
+		rinfo->bw = RATE_INFO_BW_80;
+		break;
+	case RATE_MCS_CHAN_WIDTH_160:
+		rinfo->bw = RATE_INFO_BW_160;
+		break;
+	}
+
+	if (rate_n_flags & RATE_MCS_HT_MSK) {
+		rinfo->flags |= RATE_INFO_FLAGS_MCS;
+		rinfo->mcs = u32_get_bits(rate_n_flags, RATE_HT_MCS_INDEX_MSK);
+		rinfo->nss = u32_get_bits(rate_n_flags,
+					  RATE_HT_MCS_NSS_MSK) + 1;
+		if (rate_n_flags & RATE_MCS_SGI_MSK)
+			rinfo->flags |= RATE_INFO_FLAGS_SHORT_GI;
+	} else if (rate_n_flags & RATE_MCS_VHT_MSK) {
+		rinfo->flags |= RATE_INFO_FLAGS_VHT_MCS;
+		rinfo->mcs = u32_get_bits(rate_n_flags,
+					  RATE_VHT_MCS_RATE_CODE_MSK);
+		rinfo->nss = u32_get_bits(rate_n_flags,
+					  RATE_VHT_MCS_NSS_MSK) + 1;
+		if (rate_n_flags & RATE_MCS_SGI_MSK)
+			rinfo->flags |= RATE_INFO_FLAGS_SHORT_GI;
+	} else if (rate_n_flags & RATE_MCS_HE_MSK) {
+		u32 gi_ltf = u32_get_bits(rate_n_flags,
+					  RATE_MCS_HE_GI_LTF_MSK);
+
+		rinfo->flags |= RATE_INFO_FLAGS_HE_MCS;
+		rinfo->mcs = u32_get_bits(rate_n_flags,
+					  RATE_VHT_MCS_RATE_CODE_MSK);
+		rinfo->nss = u32_get_bits(rate_n_flags,
+					  RATE_VHT_MCS_NSS_MSK) + 1;
+
+		if (rate_n_flags & RATE_MCS_HE_106T_MSK) {
+			rinfo->bw = RATE_INFO_BW_HE_RU;
+			rinfo->he_ru_alloc = NL80211_RATE_INFO_HE_RU_ALLOC_106;
+		}
+
+		switch (rate_n_flags & RATE_MCS_HE_TYPE_MSK) {
+		case RATE_MCS_HE_TYPE_SU:
+		case RATE_MCS_HE_TYPE_EXT_SU:
+			if (gi_ltf == 0 || gi_ltf == 1)
+				rinfo->he_gi = NL80211_RATE_INFO_HE_GI_0_8;
+			else if (gi_ltf == 2)
+				rinfo->he_gi = NL80211_RATE_INFO_HE_GI_1_6;
+			else if (rate_n_flags & RATE_MCS_SGI_MSK)
+				rinfo->he_gi = NL80211_RATE_INFO_HE_GI_0_8;
+			else
+				rinfo->he_gi = NL80211_RATE_INFO_HE_GI_3_2;
+			break;
+		case RATE_MCS_HE_TYPE_MU:
+			if (gi_ltf == 0 || gi_ltf == 1)
+				rinfo->he_gi = NL80211_RATE_INFO_HE_GI_0_8;
+			else if (gi_ltf == 2)
+				rinfo->he_gi = NL80211_RATE_INFO_HE_GI_1_6;
+			else
+				rinfo->he_gi = NL80211_RATE_INFO_HE_GI_3_2;
+			break;
+		case RATE_MCS_HE_TYPE_TRIG:
+			if (gi_ltf == 0 || gi_ltf == 1)
+				rinfo->he_gi = NL80211_RATE_INFO_HE_GI_1_6;
+			else
+				rinfo->he_gi = NL80211_RATE_INFO_HE_GI_3_2;
+			break;
+		}
+
+		if (rate_n_flags & RATE_HE_DUAL_CARRIER_MODE_MSK)
+			rinfo->he_dcm = 1;
+	} else {
+		switch (u32_get_bits(rate_n_flags, RATE_LEGACY_RATE_MSK)) {
+		case IWL_RATE_1M_PLCP:
+			rinfo->legacy = 10;
+			break;
+		case IWL_RATE_2M_PLCP:
+			rinfo->legacy = 20;
+			break;
+		case IWL_RATE_5M_PLCP:
+			rinfo->legacy = 55;
+			break;
+		case IWL_RATE_11M_PLCP:
+			rinfo->legacy = 110;
+			break;
+		case IWL_RATE_6M_PLCP:
+			rinfo->legacy = 60;
+			break;
+		case IWL_RATE_9M_PLCP:
+			rinfo->legacy = 90;
+			break;
+		case IWL_RATE_12M_PLCP:
+			rinfo->legacy = 120;
+			break;
+		case IWL_RATE_18M_PLCP:
+			rinfo->legacy = 180;
+			break;
+		case IWL_RATE_24M_PLCP:
+			rinfo->legacy = 240;
+			break;
+		case IWL_RATE_36M_PLCP:
+			rinfo->legacy = 360;
+			break;
+		case IWL_RATE_48M_PLCP:
+			rinfo->legacy = 480;
+			break;
+		case IWL_RATE_54M_PLCP:
+			rinfo->legacy = 540;
+			break;
+		}
+	}
+}
+
 static void iwl_mvm_mac_sta_statistics(struct ieee80211_hw *hw,
 				       struct ieee80211_vif *vif,
 				       struct ieee80211_sta *sta,
@@ -4785,6 +4904,13 @@ static void iwl_mvm_mac_sta_statistics(struct ieee80211_hw *hw,
 		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_SIGNAL_AVG);
 	}
 
+	if (iwl_mvm_has_tlc_offload(mvm)) {
+		struct iwl_lq_sta_rs_fw *lq_sta = &mvmsta->lq_sta.rs_fw;
+
+		iwl_mvm_set_sta_rate(lq_sta->last_rate_n_flags, &sinfo->txrate);
+		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_BITRATE);
+	}
+
 	/* if beacon filtering isn't on mac80211 does it anyway */
 	if (!(vif->driver_flags & IEEE80211_VIF_BEACON_FILTER))
 		return;
-- 
2.24.0

