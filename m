Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 596F417BE13
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Mar 2020 14:17:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbgCFNQy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 6 Mar 2020 08:16:54 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:60966 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727432AbgCFNQy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 6 Mar 2020 08:16:54 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <luca@coelho.fi>)
        id 1jACqM-0005yR-Qp; Fri, 06 Mar 2020 15:16:47 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Fri,  6 Mar 2020 15:16:26 +0200
Message-Id: <iwlwifi.20200306151129.b4f940d13eca.Ieebfa889d08205a3a961ae0138fb5832e8a0f9c1@changeid>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200306131627.503176-1-luca@coelho.fi>
References: <20200306131627.503176-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.2
Subject: [PATCH v5.6 6/7] iwlwifi: mvm: Fix rate scale NSS configuration
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ilan Peer <ilan.peer@intel.com>

The TLC configuration did not take into consideration the station's
SMPS configuration, and thus configured rates for 2 NSS even if
static SMPS was reported by the station. Fix this.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/rs-fw.c    | 29 ++++++++++++++-----
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
index 80ef238a8488..ca99a9c4f70e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
@@ -6,7 +6,7 @@
  * GPL LICENSE SUMMARY
  *
  * Copyright(c) 2017        Intel Deutschland GmbH
- * Copyright(c) 2018 - 2019 Intel Corporation
+ * Copyright(c) 2018 - 2020 Intel Corporation
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of version 2 of the GNU General Public License as
@@ -27,7 +27,7 @@
  * BSD LICENSE
  *
  * Copyright(c) 2017        Intel Deutschland GmbH
- * Copyright(c) 2018 - 2019 Intel Corporation
+ * Copyright(c) 2018 - 2020 Intel Corporation
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
@@ -195,11 +195,13 @@ rs_fw_vht_set_enabled_rates(const struct ieee80211_sta *sta,
 {
 	u16 supp;
 	int i, highest_mcs;
+	u8 nss = sta->rx_nss;
 
-	for (i = 0; i < sta->rx_nss; i++) {
-		if (i == IWL_TLC_NSS_MAX)
-			break;
+	/* the station support only a single receive chain */
+	if (sta->smps_mode == IEEE80211_SMPS_STATIC)
+		nss = 1;
 
+	for (i = 0; i < nss && i < IWL_TLC_NSS_MAX; i++) {
 		highest_mcs = rs_fw_vht_highest_rx_mcs_index(vht_cap, i + 1);
 		if (!highest_mcs)
 			continue;
@@ -245,8 +247,13 @@ rs_fw_he_set_enabled_rates(const struct ieee80211_sta *sta,
 	u16 tx_mcs_160 =
 		le16_to_cpu(sband->iftype_data->he_cap.he_mcs_nss_supp.tx_mcs_160);
 	int i;
+	u8 nss = sta->rx_nss;
 
-	for (i = 0; i < sta->rx_nss && i < IWL_TLC_NSS_MAX; i++) {
+	/* the station support only a single receive chain */
+	if (sta->smps_mode == IEEE80211_SMPS_STATIC)
+		nss = 1;
+
+	for (i = 0; i < nss && i < IWL_TLC_NSS_MAX; i++) {
 		u16 _mcs_160 = (mcs_160 >> (2 * i)) & 0x3;
 		u16 _mcs_80 = (mcs_80 >> (2 * i)) & 0x3;
 		u16 _tx_mcs_160 = (tx_mcs_160 >> (2 * i)) & 0x3;
@@ -307,8 +314,14 @@ static void rs_fw_set_supp_rates(struct ieee80211_sta *sta,
 		cmd->mode = IWL_TLC_MNG_MODE_HT;
 		cmd->ht_rates[IWL_TLC_NSS_1][IWL_TLC_HT_BW_NONE_160] =
 			cpu_to_le16(ht_cap->mcs.rx_mask[0]);
-		cmd->ht_rates[IWL_TLC_NSS_2][IWL_TLC_HT_BW_NONE_160] =
-			cpu_to_le16(ht_cap->mcs.rx_mask[1]);
+
+		/* the station support only a single receive chain */
+		if (sta->smps_mode == IEEE80211_SMPS_STATIC)
+			cmd->ht_rates[IWL_TLC_NSS_2][IWL_TLC_HT_BW_NONE_160] =
+				0;
+		else
+			cmd->ht_rates[IWL_TLC_NSS_2][IWL_TLC_HT_BW_NONE_160] =
+				cpu_to_le16(ht_cap->mcs.rx_mask[1]);
 	}
 }
 
-- 
2.25.1

