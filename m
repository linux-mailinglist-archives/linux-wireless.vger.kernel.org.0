Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03B712667EF
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Sep 2020 19:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725897AbgIKRzb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 11 Sep 2020 13:55:31 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:50300 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726129AbgIKRz0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 11 Sep 2020 13:55:26 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kGn6J-0028eU-1s; Fri, 11 Sep 2020 20:44:43 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 11 Sep 2020 20:44:29 +0300
Message-Id: <iwlwifi.20200911204056.523f5eca82ce.Ic0cd9cc86a91b1f23a5a54921736332be9abac29@changeid>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200911174439.163225-1-luca@coelho.fi>
References: <20200911174439.163225-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 01/11] iwlwifi: mvm: rs-fw: handle VHT extended NSS capability
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

If extended NSS capability is used, the NSS for 160 may be
lower than for 80.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/rs-fw.c    | 24 +++++++++++++++----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
index 6f4d241d47e9..012123268ba9 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
@@ -195,14 +195,20 @@ rs_fw_vht_set_enabled_rates(const struct ieee80211_sta *sta,
 {
 	u16 supp;
 	int i, highest_mcs;
-	u8 nss = sta->rx_nss;
+	u8 max_nss = sta->rx_nss;
+	struct ieee80211_vht_cap ieee_vht_cap = {
+		.vht_cap_info = cpu_to_le32(vht_cap->cap),
+		.supp_mcs = vht_cap->vht_mcs,
+	};
 
 	/* the station support only a single receive chain */
 	if (sta->smps_mode == IEEE80211_SMPS_STATIC)
-		nss = 1;
+		max_nss = 1;
 
-	for (i = 0; i < nss && i < IWL_TLC_NSS_MAX; i++) {
-		highest_mcs = rs_fw_vht_highest_rx_mcs_index(vht_cap, i + 1);
+	for (i = 0; i < max_nss && i < IWL_TLC_NSS_MAX; i++) {
+		int nss = i + 1;
+
+		highest_mcs = rs_fw_vht_highest_rx_mcs_index(vht_cap, nss);
 		if (!highest_mcs)
 			continue;
 
@@ -211,7 +217,15 @@ rs_fw_vht_set_enabled_rates(const struct ieee80211_sta *sta,
 			supp &= ~BIT(IWL_TLC_MNG_HT_RATE_MCS9);
 
 		cmd->ht_rates[i][IWL_TLC_HT_BW_NONE_160] = cpu_to_le16(supp);
-		if (sta->bandwidth == IEEE80211_STA_RX_BW_160)
+		/*
+		 * Check if VHT extended NSS indicates that the bandwidth/NSS
+		 * configuration is supported - only for MCS 0 since we already
+		 * decoded the MCS bits anyway ourselves.
+		 */
+		if (sta->bandwidth == IEEE80211_STA_RX_BW_160 &&
+		    ieee80211_get_vht_max_nss(&ieee_vht_cap,
+					      IEEE80211_VHT_CHANWIDTH_160MHZ,
+					      0, true, nss) >= nss)
 			cmd->ht_rates[i][IWL_TLC_HT_BW_160] =
 				cmd->ht_rates[i][IWL_TLC_HT_BW_NONE_160];
 	}
-- 
2.28.0

