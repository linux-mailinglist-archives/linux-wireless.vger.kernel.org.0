Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6F8C4A2E1A
	for <lists+linux-wireless@lfdr.de>; Sat, 29 Jan 2022 12:16:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237251AbiA2LQc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 29 Jan 2022 06:16:32 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:37876 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S237190AbiA2LQa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 29 Jan 2022 06:16:30 -0500
Received: from 91-156-4-210.elisa-laajakaista.fi ([91.156.4.210] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <luca@coelho.fi>)
        id 1nDliW-0002ji-AU;
        Sat, 29 Jan 2022 13:16:29 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@kernel.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sat, 29 Jan 2022 13:16:14 +0200
Message-Id: <iwlwifi.20220129105618.f7f1b31a8c75.Id349f61dfd9d3514c08ad0917b1607d35ab73dfa@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220129111622.678447-1-luca@coelho.fi>
References: <20220129111622.678447-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 04/12] iwlwifi: advertise support for HE - DCM BPSK RX/TX
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mordechay Goodstein <mordechay.goodstein@intel.com>

Our HE capable HW also supports DCM mode, so broadcast this capability
in the HE PHY capabilities.

Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
index 3803847dd31d..aebae8251eb8 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
@@ -584,9 +584,9 @@ static const struct ieee80211_sband_iftype_data iwl_he_capa[] = {
 					IEEE80211_HE_PHY_CAP2_NDP_4x_LTF_AND_3_2US |
 					IEEE80211_HE_PHY_CAP2_STBC_RX_UNDER_80MHZ,
 				.phy_cap_info[3] =
-					IEEE80211_HE_PHY_CAP3_DCM_MAX_CONST_TX_NO_DCM |
+					IEEE80211_HE_PHY_CAP3_DCM_MAX_CONST_TX_BPSK |
 					IEEE80211_HE_PHY_CAP3_DCM_MAX_TX_NSS_1 |
-					IEEE80211_HE_PHY_CAP3_DCM_MAX_CONST_RX_NO_DCM |
+					IEEE80211_HE_PHY_CAP3_DCM_MAX_CONST_RX_BPSK |
 					IEEE80211_HE_PHY_CAP3_DCM_MAX_RX_NSS_1,
 				.phy_cap_info[4] =
 					IEEE80211_HE_PHY_CAP4_SU_BEAMFORMEE |
@@ -654,9 +654,9 @@ static const struct ieee80211_sband_iftype_data iwl_he_capa[] = {
 					IEEE80211_HE_PHY_CAP2_STBC_RX_UNDER_80MHZ |
 					IEEE80211_HE_PHY_CAP2_NDP_4x_LTF_AND_3_2US,
 				.phy_cap_info[3] =
-					IEEE80211_HE_PHY_CAP3_DCM_MAX_CONST_TX_NO_DCM |
+					IEEE80211_HE_PHY_CAP3_DCM_MAX_CONST_TX_BPSK |
 					IEEE80211_HE_PHY_CAP3_DCM_MAX_TX_NSS_1 |
-					IEEE80211_HE_PHY_CAP3_DCM_MAX_CONST_RX_NO_DCM |
+					IEEE80211_HE_PHY_CAP3_DCM_MAX_CONST_RX_BPSK |
 					IEEE80211_HE_PHY_CAP3_DCM_MAX_RX_NSS_1,
 				.phy_cap_info[6] =
 					IEEE80211_HE_PHY_CAP6_PPE_THRESHOLD_PRESENT,
-- 
2.34.1

