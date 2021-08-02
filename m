Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 183AC3DDAC6
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Aug 2021 16:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234222AbhHBOVI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Aug 2021 10:21:08 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:50886 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S234824AbhHBOU6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Aug 2021 10:20:58 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1mAYdV-001xoA-Fs; Mon, 02 Aug 2021 17:09:46 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Mon,  2 Aug 2021 17:09:33 +0300
Message-Id: <iwlwifi.20210802170640.0108f3e322b6.Ib25a91b5c48ff1fb2185b86a9e4bf5eec637df90@changeid>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210802140944.90143-1-luca@coelho.fi>
References: <20210802140944.90143-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH 01/12] iwlwifi: iwl-nvm-parse: set STBC flags for HE phy capabilities
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mordechay Goodstein <mordechay.goodstein@intel.com>

Our HW supersets STBC for HE but never set it in assoc IE, fix it by
setting it and enable using it.

Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
index 850648ebd61c..2ce4aa26774e 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
@@ -568,7 +568,8 @@ static const struct ieee80211_sband_iftype_data iwl_he_capa[] = {
 					IEEE80211_HE_PHY_CAP1_DEVICE_CLASS_A |
 					IEEE80211_HE_PHY_CAP1_LDPC_CODING_IN_PAYLOAD,
 				.phy_cap_info[2] =
-					IEEE80211_HE_PHY_CAP2_NDP_4x_LTF_AND_3_2US,
+					IEEE80211_HE_PHY_CAP2_NDP_4x_LTF_AND_3_2US |
+					IEEE80211_HE_PHY_CAP2_STBC_RX_UNDER_80MHZ,
 				.phy_cap_info[3] =
 					IEEE80211_HE_PHY_CAP3_DCM_MAX_CONST_TX_NO_DCM |
 					IEEE80211_HE_PHY_CAP3_DCM_MAX_TX_NSS_1 |
@@ -634,6 +635,7 @@ static const struct ieee80211_sband_iftype_data iwl_he_capa[] = {
 				.phy_cap_info[1] =
 					IEEE80211_HE_PHY_CAP1_LDPC_CODING_IN_PAYLOAD,
 				.phy_cap_info[2] =
+					IEEE80211_HE_PHY_CAP2_STBC_RX_UNDER_80MHZ |
 					IEEE80211_HE_PHY_CAP2_NDP_4x_LTF_AND_3_2US,
 				.phy_cap_info[3] =
 					IEEE80211_HE_PHY_CAP3_DCM_MAX_CONST_TX_NO_DCM |
@@ -742,6 +744,8 @@ iwl_nvm_fixup_sband_iftd(struct iwl_trans *trans,
 			IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G;
 
 	if ((tx_chains & rx_chains) == ANT_AB) {
+		iftype_data->he_cap.he_cap_elem.phy_cap_info[2] |=
+			IEEE80211_HE_PHY_CAP2_STBC_TX_UNDER_80MHZ;
 		iftype_data->he_cap.he_cap_elem.phy_cap_info[5] |=
 			IEEE80211_HE_PHY_CAP5_BEAMFORMEE_NUM_SND_DIM_UNDER_80MHZ_2 |
 			IEEE80211_HE_PHY_CAP5_BEAMFORMEE_NUM_SND_DIM_ABOVE_80MHZ_2;
-- 
2.32.0

