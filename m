Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DDBA3F8F28
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Aug 2021 21:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243610AbhHZTst (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Aug 2021 15:48:49 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:33448 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S243589AbhHZTss (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Aug 2021 15:48:48 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1mJLLy-002XB4-7F; Thu, 26 Aug 2021 22:47:59 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Thu, 26 Aug 2021 22:47:43 +0300
Message-Id: <iwlwifi.20210826224715.30e665d39b07.I78bf7d304ef5a80cecf5fa1c1fca0b51b956cceb@changeid>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210826194748.826360-1-luca@coelho.fi>
References: <20210826194748.826360-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH v2 07/12] iwlwifi: mvm: don't use FW key ID in beacon protection
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

To check beacon protection had a mismatch of the key ID we
currently use the key ID from the firmware, but firmware
side we want to clean up the API to stop reporting this.

Instead, check the IWL_RX_MPDU_STATUS_KEY_VALID bit that
indicates that the firmware used the correct key, and if
that's set but we get invalid MIC/replay use the key ID
from the frame to look up the key and notify mac80211 of
MIC error or replay. Since both keys must have the same
cipher and thus MIC length, we can use either of them to
look up the MIC length.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c | 41 ++++++++++++-------
 1 file changed, 27 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index 06cc03820dd5..c12f303cf652 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -279,7 +279,6 @@ static int iwl_mvm_rx_mgmt_prot(struct ieee80211_sta *sta,
 {
 	struct iwl_mvm_sta *mvmsta;
 	struct iwl_mvm_vif *mvmvif;
-	u8 fwkeyid = u32_get_bits(status, IWL_RX_MPDU_STATUS_KEY);
 	u8 keyid;
 	struct ieee80211_key_conf *key;
 	u32 len = le16_to_cpu(desc->mpdu_len);
@@ -299,6 +298,10 @@ static int iwl_mvm_rx_mgmt_prot(struct ieee80211_sta *sta,
 	if (!ieee80211_is_beacon(hdr->frame_control))
 		return 0;
 
+	/* key mismatch - will also report !MIC_OK but we shouldn't count it */
+	if (!(status & IWL_RX_MPDU_STATUS_KEY_VALID))
+		return -1;
+
 	/* good cases */
 	if (likely(status & IWL_RX_MPDU_STATUS_MIC_OK &&
 		   !(status & IWL_RX_MPDU_STATUS_REPLAY_ERROR)))
@@ -309,26 +312,36 @@ static int iwl_mvm_rx_mgmt_prot(struct ieee80211_sta *sta,
 
 	mvmsta = iwl_mvm_sta_from_mac80211(sta);
 
-	/* what? */
-	if (fwkeyid != 6 && fwkeyid != 7)
-		return -1;
-
 	mvmvif = iwl_mvm_vif_from_mac80211(mvmsta->vif);
 
-	key = rcu_dereference(mvmvif->bcn_prot.keys[fwkeyid - 6]);
-	if (!key)
-		return -1;
+	/*
+	 * both keys will have the same cipher and MIC length, use
+	 * whichever one is available
+	 */
+	key = rcu_dereference(mvmvif->bcn_prot.keys[0]);
+	if (!key) {
+		key = rcu_dereference(mvmvif->bcn_prot.keys[1]);
+		if (!key)
+			return -1;
+	}
 
 	if (len < key->icv_len + IEEE80211_GMAC_PN_LEN + 2)
 		return -1;
 
-	/*
-	 * See if the key ID matches - if not this may be due to a
-	 * switch and the firmware may erroneously report !MIC_OK.
-	 */
+	/* get the real key ID */
 	keyid = frame[len - key->icv_len - IEEE80211_GMAC_PN_LEN - 2];
-	if (keyid != fwkeyid)
-		return -1;
+	/* and if that's the other key, look it up */
+	if (keyid != key->keyidx) {
+		/*
+		 * shouldn't happen since firmware checked, but be safe
+		 * in case the MIC length is wrong too, for example
+		 */
+		if (keyid != 6 && keyid != 7)
+			return -1;
+		key = rcu_dereference(mvmvif->bcn_prot.keys[keyid - 6]);
+		if (!key)
+			return -1;
+	}
 
 	/* Report status to mac80211 */
 	if (!(status & IWL_RX_MPDU_STATUS_MIC_OK))
-- 
2.33.0

