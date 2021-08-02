Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B251D3DDFBB
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Aug 2021 20:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbhHBS7Y (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Aug 2021 14:59:24 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:51054 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230420AbhHBS7X (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Aug 2021 14:59:23 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1mAd9X-001ySl-6K; Mon, 02 Aug 2021 21:59:08 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Mon,  2 Aug 2021 21:58:56 +0300
Message-Id: <iwlwifi.20210802215208.e89178b22fbf.I4d62baad9a9fdfd5c645a3cc5dbffb22feab5033@changeid>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210802185856.175567-1-luca@coelho.fi>
References: <20210802185856.175567-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH 10/10] iwlwifi: mvm: simplify __iwl_mvm_set_sta_key()
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

There's no need to differentiate identical default and cipher
type cases, nor do we really need to have a 'ret' variable.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c | 26 ++++++--------------
 1 file changed, 7 insertions(+), 19 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index 7e9951993af8..a64874c05ced 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -3473,7 +3473,6 @@ static int __iwl_mvm_set_sta_key(struct iwl_mvm *mvm,
 				 u8 key_offset,
 				 bool mcast)
 {
-	int ret;
 	const u8 *addr;
 	struct ieee80211_key_seq seq;
 	u16 p1k[5];
@@ -3495,30 +3494,19 @@ static int __iwl_mvm_set_sta_key(struct iwl_mvm *mvm,
 		return -EINVAL;
 	}
 
-	switch (keyconf->cipher) {
-	case WLAN_CIPHER_SUITE_TKIP:
+	if (keyconf->cipher == WLAN_CIPHER_SUITE_TKIP) {
 		addr = iwl_mvm_get_mac_addr(mvm, vif, sta);
 		/* get phase 1 key from mac80211 */
 		ieee80211_get_key_rx_seq(keyconf, 0, &seq);
 		ieee80211_get_tkip_rx_p1k(keyconf, addr, seq.tkip.iv32, p1k);
-		ret = iwl_mvm_send_sta_key(mvm, sta_id, keyconf, mcast,
-					   seq.tkip.iv32, p1k, 0, key_offset,
-					   mfp);
-		break;
-	case WLAN_CIPHER_SUITE_CCMP:
-	case WLAN_CIPHER_SUITE_WEP40:
-	case WLAN_CIPHER_SUITE_WEP104:
-	case WLAN_CIPHER_SUITE_GCMP:
-	case WLAN_CIPHER_SUITE_GCMP_256:
-		ret = iwl_mvm_send_sta_key(mvm, sta_id, keyconf, mcast,
-					   0, NULL, 0, key_offset, mfp);
-		break;
-	default:
-		ret = iwl_mvm_send_sta_key(mvm, sta_id, keyconf, mcast,
-					   0, NULL, 0, key_offset, mfp);
+
+		return iwl_mvm_send_sta_key(mvm, sta_id, keyconf, mcast,
+					    seq.tkip.iv32, p1k, 0, key_offset,
+					    mfp);
 	}
 
-	return ret;
+	return iwl_mvm_send_sta_key(mvm, sta_id, keyconf, mcast,
+				    0, NULL, 0, key_offset, mfp);
 }
 
 int iwl_mvm_set_sta_key(struct iwl_mvm *mvm,
-- 
2.32.0

