Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7122797B06
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Aug 2019 15:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728863AbfHUNiK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Aug 2019 09:38:10 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:37754 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726371AbfHUNiJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Aug 2019 09:38:09 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1i0QoR-0000lZ-QX; Wed, 21 Aug 2019 16:38:08 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 21 Aug 2019 16:37:45 +0300
Message-Id: <20190821133800.23636-4-luca@coelho.fi>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190821133800.23636-1-luca@coelho.fi>
References: <20190821133800.23636-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH 03/18] iwlwifi: mvm: name magic numbers with enum
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mordechay Goodstein <mordechay.goodstein@intel.com>

It's hard to follow the numbers so rename it with enum

Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/fw/api/rs.h    | 18 +++++++++++++-----
 .../net/wireless/intel/iwlwifi/mvm/rs-fw.c    | 19 +++++++++++--------
 2 files changed, 24 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/rs.h b/drivers/net/wireless/intel/iwlwifi/fw/api/rs.h
index 9eddc4dc2ae6..4347be6491e9 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/rs.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/rs.h
@@ -7,7 +7,7 @@
  *
  * Copyright(c) 2012 - 2014 Intel Corporation. All rights reserved.
  * Copyright(c) 2017 Intel Deutschland GmbH
- * Copyright(c) 2018 Intel Corporation
+ * Copyright(c) 2018 - 2019 Intel Corporation
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of version 2 of the GNU General Public License as
@@ -29,7 +29,7 @@
  *
  * Copyright(c) 2012 - 2014 Intel Corporation. All rights reserved.
  * Copyright(c) 2017 Intel Deutschland GmbH
- * Copyright(c) 2018 Intel Corporation
+ * Copyright(c) 2018 - 2019 Intel Corporation
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
@@ -166,8 +166,16 @@ enum iwl_tlc_mng_ht_rates {
 	IWL_TLC_MNG_HT_RATE_MAX = IWL_TLC_MNG_HT_RATE_MCS11,
 };
 
-/* Maximum supported tx antennas number */
-#define MAX_NSS 2
+enum IWL_TLC_MNG_NSS {
+	IWL_TLC_NSS_1,
+	IWL_TLC_NSS_2,
+	IWL_TLC_NSS_MAX
+};
+
+enum IWL_TLC_HT_BW_RATES {
+	IWL_TLC_HT_BW_NONE_160,
+	IWL_TLC_HT_BW_160,
+};
 
 /**
  * struct tlc_config_cmd - TLC configuration
@@ -195,7 +203,7 @@ struct iwl_tlc_config_cmd {
 	u8 amsdu;
 	__le16 flags;
 	__le16 non_ht_rates;
-	__le16 ht_rates[MAX_NSS][2];
+	__le16 ht_rates[IWL_TLC_NSS_MAX][2];
 	__le16 max_mpdu_len;
 	u8 sgi_ch_width_supp;
 	u8 reserved2[1];
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
index 08b67812e94e..8f50e2b121bd 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
@@ -193,7 +193,7 @@ rs_fw_vht_set_enabled_rates(const struct ieee80211_sta *sta,
 	int i, highest_mcs;
 
 	for (i = 0; i < sta->rx_nss; i++) {
-		if (i == MAX_NSS)
+		if (i == IWL_TLC_NSS_MAX)
 			break;
 
 		highest_mcs = rs_fw_vht_highest_rx_mcs_index(vht_cap, i + 1);
@@ -204,9 +204,10 @@ rs_fw_vht_set_enabled_rates(const struct ieee80211_sta *sta,
 		if (sta->bandwidth == IEEE80211_STA_RX_BW_20)
 			supp &= ~BIT(IWL_TLC_MNG_HT_RATE_MCS9);
 
-		cmd->ht_rates[i][0] = cpu_to_le16(supp);
+		cmd->ht_rates[i][IWL_TLC_HT_BW_NONE_160] = cpu_to_le16(supp);
 		if (sta->bandwidth == IEEE80211_STA_RX_BW_160)
-			cmd->ht_rates[i][1] = cmd->ht_rates[i][0];
+			cmd->ht_rates[i][IWL_TLC_HT_BW_160] =
+				cmd->ht_rates[i][IWL_TLC_HT_BW_NONE_160];
 	}
 }
 
@@ -241,7 +242,7 @@ rs_fw_he_set_enabled_rates(const struct ieee80211_sta *sta,
 		le16_to_cpu(sband->iftype_data->he_cap.he_mcs_nss_supp.tx_mcs_160);
 	int i;
 
-	for (i = 0; i < sta->rx_nss && i < MAX_NSS; i++) {
+	for (i = 0; i < sta->rx_nss && i < IWL_TLC_NSS_MAX; i++) {
 		u16 _mcs_160 = (mcs_160 >> (2 * i)) & 0x3;
 		u16 _mcs_80 = (mcs_80 >> (2 * i)) & 0x3;
 		u16 _tx_mcs_160 = (tx_mcs_160 >> (2 * i)) & 0x3;
@@ -255,7 +256,7 @@ rs_fw_he_set_enabled_rates(const struct ieee80211_sta *sta,
 		}
 		if (_mcs_80 > _tx_mcs_80)
 			_mcs_80 = _tx_mcs_80;
-		cmd->ht_rates[i][0] =
+		cmd->ht_rates[i][IWL_TLC_HT_BW_NONE_160] =
 			cpu_to_le16(rs_fw_he_ieee80211_mcs_to_rs_mcs(_mcs_80));
 
 		/* If one side doesn't support - mark both as not supporting */
@@ -266,7 +267,7 @@ rs_fw_he_set_enabled_rates(const struct ieee80211_sta *sta,
 		}
 		if (_mcs_160 > _tx_mcs_160)
 			_mcs_160 = _tx_mcs_160;
-		cmd->ht_rates[i][1] =
+		cmd->ht_rates[i][IWL_TLC_HT_BW_160] =
 			cpu_to_le16(rs_fw_he_ieee80211_mcs_to_rs_mcs(_mcs_160));
 	}
 }
@@ -300,8 +301,10 @@ static void rs_fw_set_supp_rates(struct ieee80211_sta *sta,
 		rs_fw_vht_set_enabled_rates(sta, vht_cap, cmd);
 	} else if (ht_cap->ht_supported) {
 		cmd->mode = IWL_TLC_MNG_MODE_HT;
-		cmd->ht_rates[0][0] = cpu_to_le16(ht_cap->mcs.rx_mask[0]);
-		cmd->ht_rates[1][0] = cpu_to_le16(ht_cap->mcs.rx_mask[1]);
+		cmd->ht_rates[IWL_TLC_NSS_1][IWL_TLC_HT_BW_NONE_160] =
+			cpu_to_le16(ht_cap->mcs.rx_mask[0]);
+		cmd->ht_rates[IWL_TLC_NSS_2][IWL_TLC_HT_BW_NONE_160] =
+			cpu_to_le16(ht_cap->mcs.rx_mask[1]);
 	}
 }
 
-- 
2.23.0.rc1

