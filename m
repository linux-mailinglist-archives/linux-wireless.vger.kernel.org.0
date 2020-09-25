Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21642279390
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Sep 2020 23:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728950AbgIYVbF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Sep 2020 17:31:05 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:52322 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728733AbgIYVbD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Sep 2020 17:31:03 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kLvIz-002J1P-Hu; Sat, 26 Sep 2020 00:31:01 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sat, 26 Sep 2020 00:30:44 +0300
Message-Id: <iwlwifi.20200926002540.019a64e96d44.I609a995611ac5286e442cd54f764eaf4a7249ac0@changeid>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200925213053.454459-1-luca@coelho.fi>
References: <20200925213053.454459-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 06/15] iwlwifi: mvm: Don't install CMAC/GMAC key in AP mode
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Andrei Otcheretianski <andrei.otcheretianski@intel.com>

Due to a missing break, the management multicast key was installed even
though we don't really support it. Fix that, so mac80211 would know that
it should protect frames in software.

Signed-off-by: Andrei Otcheretianski <andrei.otcheretianski@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 73280a2607a5..5e141eb47abc 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -3438,15 +3438,16 @@ static int __iwl_mvm_mac_set_key(struct ieee80211_hw *hw,
 			 */
 			if (key->cipher == WLAN_CIPHER_SUITE_AES_CMAC ||
 			    key->cipher == WLAN_CIPHER_SUITE_BIP_GMAC_128 ||
-			    key->cipher == WLAN_CIPHER_SUITE_BIP_GMAC_256)
+			    key->cipher == WLAN_CIPHER_SUITE_BIP_GMAC_256) {
 				ret = -EOPNOTSUPP;
-			else
-				ret = 0;
+				break;
+			}
 
 			if (key->cipher != WLAN_CIPHER_SUITE_GCMP &&
 			    key->cipher != WLAN_CIPHER_SUITE_GCMP_256 &&
 			    !iwl_mvm_has_new_tx_api(mvm)) {
 				key->hw_key_idx = STA_KEY_IDX_INVALID;
+				ret = 0;
 				break;
 			}
 
@@ -3462,6 +3463,8 @@ static int __iwl_mvm_mac_set_key(struct ieee80211_hw *hw,
 
 				if (i >= ARRAY_SIZE(mvmvif->ap_early_keys))
 					ret = -ENOSPC;
+				else
+					ret = 0;
 
 				break;
 			}
-- 
2.28.0

