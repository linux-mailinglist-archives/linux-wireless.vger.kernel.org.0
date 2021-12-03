Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDB5C4676FC
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Dec 2021 13:04:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380686AbhLCMH5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 Dec 2021 07:07:57 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:50232 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230154AbhLCMHw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 Dec 2021 07:07:52 -0500
Received: from 91-156-5-105.elisa-laajakaista.fi ([91.156.5.105] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mt7If-0015t0-LM; Fri, 03 Dec 2021 14:04:26 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Fri,  3 Dec 2021 14:04:24 +0200
Message-Id: <iwlwifi.20211203140410.1a1541d7dcb5.I606c746e11447fe168cf046376b70b04e278c3b4@changeid>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH for v5.16] iwlwifi: mvm: don't crash on invalid rate w/o STA
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

If we get to the WARN_ONCE(..., "Got a HT rate (...)", ...)
here with a NULL sta, then we crash because mvmsta is bad
and we try to dereference it. Fix that by printing -1 as the
state if no station was given.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Fixes: 6761a718263a ("iwlwifi: mvm: add explicit check for non-data frames in get Tx rate")
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
index bdd4ee432548..76e0b7b45980 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -269,17 +269,18 @@ static u32 iwl_mvm_get_tx_rate(struct iwl_mvm *mvm,
 	u8 rate_plcp;
 	u32 rate_flags = 0;
 	bool is_cck;
-	struct iwl_mvm_sta *mvmsta = iwl_mvm_sta_from_mac80211(sta);
 
 	/* info->control is only relevant for non HW rate control */
 	if (!ieee80211_hw_check(mvm->hw, HAS_RATE_CONTROL)) {
+		struct iwl_mvm_sta *mvmsta = iwl_mvm_sta_from_mac80211(sta);
+
 		/* HT rate doesn't make sense for a non data frame */
 		WARN_ONCE(info->control.rates[0].flags & IEEE80211_TX_RC_MCS &&
 			  !ieee80211_is_data(fc),
 			  "Got a HT rate (flags:0x%x/mcs:%d/fc:0x%x/state:%d) for a non data frame\n",
 			  info->control.rates[0].flags,
 			  info->control.rates[0].idx,
-			  le16_to_cpu(fc), mvmsta->sta_state);
+			  le16_to_cpu(fc), sta ? mvmsta->sta_state : -1);
 
 		rate_idx = info->control.rates[0].idx;
 	}
-- 
2.33.1

