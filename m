Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB292F9313
	for <lists+linux-wireless@lfdr.de>; Sun, 17 Jan 2021 15:53:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729143AbhAQOxf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 17 Jan 2021 09:53:35 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:40748 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728994AbhAQOx1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 17 Jan 2021 09:53:27 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1l19Pz-003sgA-Te; Sun, 17 Jan 2021 16:52:40 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sun, 17 Jan 2021 16:52:30 +0200
Message-Id: <iwlwifi.20210117164916.d9ded010c4ce.Ie1d5a33d7175c0bcb35c10b5729748646671da31@changeid>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210117145234.1435324-1-luca@coelho.fi>
References: <20210117145234.1435324-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 5/9] iwlwifi: mvm: add explicit check for non-data frames in get Tx rate
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Krishnanand Prabhu <krishnanand.prabhu@intel.com>

In roaming flows and during reassociation, its possible that data frames
such as EAPOLs for 4 way handshake/ 802.1x authentication are initially set
to higher MCS rate. Though these are pruned down to a lower legacy rate
before sending to the FW, driver also emits a kernel warning - intended for
non-data frames. Add checks to avoid such warnings for data frames, while
also enhancing the debug data printed.

Signed-off-by: Krishnanand Prabhu <krishnanand.prabhu@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
index c8c07b7fe0ad..b102fe116f04 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -263,17 +263,20 @@ static u32 iwl_mvm_get_tx_ant(struct iwl_mvm *mvm,
 
 static u32 iwl_mvm_get_tx_rate(struct iwl_mvm *mvm,
 			       struct ieee80211_tx_info *info,
-			       struct ieee80211_sta *sta)
+			       struct ieee80211_sta *sta, __le16 fc)
 {
 	int rate_idx;
 	u8 rate_plcp;
 	u32 rate_flags = 0;
+	struct iwl_mvm_sta *mvmsta = iwl_mvm_sta_from_mac80211(sta);
 
 	/* HT rate doesn't make sense for a non data frame */
-	WARN_ONCE(info->control.rates[0].flags & IEEE80211_TX_RC_MCS,
-		  "Got an HT rate (flags:0x%x/mcs:%d) for a non data frame\n",
+	WARN_ONCE(info->control.rates[0].flags & IEEE80211_TX_RC_MCS &&
+		  !ieee80211_is_data(fc),
+		  "Got a HT rate (flags:0x%x/mcs:%d/fc:0x%x/state:%d) for a non data frame\n",
 		  info->control.rates[0].flags,
-		  info->control.rates[0].idx);
+		  info->control.rates[0].idx,
+		  le16_to_cpu(fc), mvmsta->sta_state);
 
 	rate_idx = info->control.rates[0].idx;
 	/* if the rate isn't a well known legacy rate, take the lowest one */
@@ -305,7 +308,7 @@ static u32 iwl_mvm_get_tx_rate_n_flags(struct iwl_mvm *mvm,
 				       struct ieee80211_tx_info *info,
 				       struct ieee80211_sta *sta, __le16 fc)
 {
-	return iwl_mvm_get_tx_rate(mvm, info, sta) |
+	return iwl_mvm_get_tx_rate(mvm, info, sta, fc) |
 		iwl_mvm_get_tx_ant(mvm, info, sta, fc);
 }
 
-- 
2.29.2

