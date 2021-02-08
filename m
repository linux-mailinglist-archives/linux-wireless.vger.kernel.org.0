Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 500BD3132A9
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Feb 2021 13:45:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232590AbhBHMoi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 8 Feb 2021 07:44:38 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:44408 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232460AbhBHMn5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 8 Feb 2021 07:43:57 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1l95qN-0047MN-4c; Mon, 08 Feb 2021 14:40:43 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Mon,  8 Feb 2021 14:40:33 +0200
Message-Id: <iwlwifi.20210208143712.a0ef86cf4955.I30c4d26698bae1f5f8c396da80a545baa145e2ad@changeid>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210208124034.1933780-1-luca@coelho.fi>
References: <20210208124034.1933780-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 11/12] iwlwifi: when HW has rate offload don't look at control field
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mordechay Goodstein <mordechay.goodstein@intel.com>

Control field is set by mac80211 only if case rate is not offloaded to
hw.

Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c | 22 ++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
index 03afced82afa..ca69968bb0c0 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -265,20 +265,24 @@ static u32 iwl_mvm_get_tx_rate(struct iwl_mvm *mvm,
 			       struct ieee80211_tx_info *info,
 			       struct ieee80211_sta *sta, __le16 fc)
 {
-	int rate_idx;
+	int rate_idx = -1;
 	u8 rate_plcp;
 	u32 rate_flags = 0;
 	struct iwl_mvm_sta *mvmsta = iwl_mvm_sta_from_mac80211(sta);
 
-	/* HT rate doesn't make sense for a non data frame */
-	WARN_ONCE(info->control.rates[0].flags & IEEE80211_TX_RC_MCS &&
-		  !ieee80211_is_data(fc),
-		  "Got a HT rate (flags:0x%x/mcs:%d/fc:0x%x/state:%d) for a non data frame\n",
-		  info->control.rates[0].flags,
-		  info->control.rates[0].idx,
-		  le16_to_cpu(fc), mvmsta->sta_state);
+	/* info->control is only relevant for non HW rate control */
+	if (!ieee80211_hw_check(mvm->hw, HAS_RATE_CONTROL)) {
+		/* HT rate doesn't make sense for a non data frame */
+		WARN_ONCE(info->control.rates[0].flags & IEEE80211_TX_RC_MCS &&
+			  !ieee80211_is_data(fc),
+			  "Got a HT rate (flags:0x%x/mcs:%d/fc:0x%x/state:%d) for a non data frame\n",
+			  info->control.rates[0].flags,
+			  info->control.rates[0].idx,
+			  le16_to_cpu(fc), mvmsta->sta_state);
+
+		rate_idx = info->control.rates[0].idx;
+	}
 
-	rate_idx = info->control.rates[0].idx;
 	/* if the rate isn't a well known legacy rate, take the lowest one */
 	if (rate_idx < 0 || rate_idx >= IWL_RATE_COUNT_LEGACY)
 		rate_idx = rate_lowest_index(
-- 
2.30.0

