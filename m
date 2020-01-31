Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40D8514EDBB
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Jan 2020 14:45:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728839AbgAaNpu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 31 Jan 2020 08:45:50 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:55984 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728659AbgAaNpl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 31 Jan 2020 08:45:41 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <luca@coelho.fi>)
        id 1ixWc7-0002Nv-99; Fri, 31 Jan 2020 15:45:39 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 31 Jan 2020 15:45:25 +0200
Message-Id: <20200131134530.931641-3-luca@coelho.fi>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200131134530.931641-1-luca@coelho.fi>
References: <20200131134530.931641-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.2
Subject: [PATCH v5.6 2/7] iwlwifi: don't throw error when trying to remove IGTK
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

The IGTK keys are only removed by mac80211 after it has already
removed the AP station.  This causes the driver to throw an error
because mac80211 is trying to remove the IGTK when the station doesn't
exist anymore.

The firmware is aware that the station has been removed and can deal
with it the next time we try to add an IGTK for a station, so we
shouldn't try to remove the key if the station ID is
IWL_MVM_INVALID_STA.  Do this by removing the check for mvm_sta before
calling iwl_mvm_send_sta_igtk() and check return from that function
gracefully if the station ID is invalid.

Cc: stable@vger.kernel.org # 4.12+
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index 7b35f416404c..64ef3f3ba23b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -3320,6 +3320,10 @@ static int iwl_mvm_send_sta_igtk(struct iwl_mvm *mvm,
 	igtk_cmd.sta_id = cpu_to_le32(sta_id);
 
 	if (remove_key) {
+		/* This is a valid situation for IGTK */
+		if (sta_id == IWL_MVM_INVALID_STA)
+			return 0;
+
 		igtk_cmd.ctrl_flags |= cpu_to_le32(STA_KEY_NOT_VALID);
 	} else {
 		struct ieee80211_key_seq seq;
@@ -3574,9 +3578,9 @@ int iwl_mvm_remove_sta_key(struct iwl_mvm *mvm,
 	IWL_DEBUG_WEP(mvm, "mvm remove dynamic key: idx=%d sta=%d\n",
 		      keyconf->keyidx, sta_id);
 
-	if (mvm_sta && (keyconf->cipher == WLAN_CIPHER_SUITE_AES_CMAC ||
-			keyconf->cipher == WLAN_CIPHER_SUITE_BIP_GMAC_128 ||
-			keyconf->cipher == WLAN_CIPHER_SUITE_BIP_GMAC_256))
+	if (keyconf->cipher == WLAN_CIPHER_SUITE_AES_CMAC ||
+	    keyconf->cipher == WLAN_CIPHER_SUITE_BIP_GMAC_128 ||
+	    keyconf->cipher == WLAN_CIPHER_SUITE_BIP_GMAC_256)
 		return iwl_mvm_send_sta_igtk(mvm, keyconf, sta_id, true);
 
 	if (!__test_and_clear_bit(keyconf->hw_key_idx, mvm->fw_key_table)) {
-- 
2.24.1

