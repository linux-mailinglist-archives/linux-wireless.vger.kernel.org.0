Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A7E027EA00
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Sep 2020 15:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730260AbgI3Nbi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Sep 2020 09:31:38 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:53340 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730475AbgI3Nbh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Sep 2020 09:31:37 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kNcCj-002MJ5-Pu; Wed, 30 Sep 2020 16:31:34 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 30 Sep 2020 16:31:18 +0300
Message-Id: <iwlwifi.20200930161256.ec44673fae83.I8a9232600b99e27213eb9ea69bf46e8d25d7f260@changeid>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200930133123.924256-1-luca@coelho.fi>
References: <20200930133123.924256-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 07/12] iwlwifi: mvm: d3: support GCMP ciphers
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

We really should support GCMP ciphers (both sizes) since
all the handling is identical to CCMP, except for the one
case where the key material is copied.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index f027029553dd..5f6092d548cf 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -313,6 +313,8 @@ static void iwl_mvm_wowlan_program_keys(struct ieee80211_hw *hw,
 		data->use_rsc_tsc = true;
 		break;
 	case WLAN_CIPHER_SUITE_CCMP:
+	case WLAN_CIPHER_SUITE_GCMP:
+	case WLAN_CIPHER_SUITE_GCMP_256:
 		if (sta) {
 			u64 pn64;
 
@@ -1405,6 +1407,8 @@ static void iwl_mvm_set_key_rx_seq(struct iwl_mvm *mvm,
 
 	switch (key->cipher) {
 	case WLAN_CIPHER_SUITE_CCMP:
+	case WLAN_CIPHER_SUITE_GCMP:
+	case WLAN_CIPHER_SUITE_GCMP_256:
 		iwl_mvm_set_aes_rx_seq(mvm, rsc->aes.multicast_rsc, NULL, key);
 		break;
 	case WLAN_CIPHER_SUITE_TKIP:
@@ -1441,6 +1445,8 @@ static void iwl_mvm_d3_update_keys(struct ieee80211_hw *hw,
 		/* ignore WEP completely, nothing to do */
 		return;
 	case WLAN_CIPHER_SUITE_CCMP:
+	case WLAN_CIPHER_SUITE_GCMP:
+	case WLAN_CIPHER_SUITE_GCMP_256:
 	case WLAN_CIPHER_SUITE_TKIP:
 		/* we support these */
 		break;
@@ -1466,6 +1472,8 @@ static void iwl_mvm_d3_update_keys(struct ieee80211_hw *hw,
 
 		switch (key->cipher) {
 		case WLAN_CIPHER_SUITE_CCMP:
+		case WLAN_CIPHER_SUITE_GCMP:
+		case WLAN_CIPHER_SUITE_GCMP_256:
 			iwl_mvm_set_aes_rx_seq(data->mvm, sc->aes.unicast_rsc,
 					       sta, key);
 			atomic64_set(&key->tx_pn, le64_to_cpu(sc->aes.tsc.pn));
@@ -1548,11 +1556,21 @@ static bool iwl_mvm_setup_connection_keep(struct iwl_mvm *mvm,
 
 		switch (gtkdata.cipher) {
 		case WLAN_CIPHER_SUITE_CCMP:
+		case WLAN_CIPHER_SUITE_GCMP:
+			BUILD_BUG_ON(WLAN_KEY_LEN_CCMP != WLAN_KEY_LEN_GCMP);
+			BUILD_BUG_ON(sizeof(conf.key) < WLAN_KEY_LEN_CCMP);
 			conf.conf.keylen = WLAN_KEY_LEN_CCMP;
 			memcpy(conf.conf.key, status->gtk[0].key,
 			       WLAN_KEY_LEN_CCMP);
 			break;
+		case WLAN_CIPHER_SUITE_GCMP_256:
+			BUILD_BUG_ON(sizeof(conf.key) < WLAN_KEY_LEN_GCMP_256);
+			conf.conf.keylen = WLAN_KEY_LEN_GCMP_256;
+			memcpy(conf.conf.key, status->gtk[0].key,
+			       WLAN_KEY_LEN_GCMP_256);
+			break;
 		case WLAN_CIPHER_SUITE_TKIP:
+			BUILD_BUG_ON(sizeof(conf.key) < WLAN_KEY_LEN_TKIP);
 			conf.conf.keylen = WLAN_KEY_LEN_TKIP;
 			memcpy(conf.conf.key, status->gtk[0].key, 16);
 			/* leave TX MIC key zeroed, we don't use it anyway */
-- 
2.28.0

