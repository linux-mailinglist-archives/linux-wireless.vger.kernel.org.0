Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 284173F1D04
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Aug 2021 17:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240638AbhHSPlY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Aug 2021 11:41:24 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:56932 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S240619AbhHSPlX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Aug 2021 11:41:23 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1mGk9s-002Hje-Bw; Thu, 19 Aug 2021 18:40:45 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Thu, 19 Aug 2021 18:40:32 +0300
Message-Id: <iwlwifi.20210819183728.f3d6561dd8ee.I193d5331b43a1ecdae59eaedb37f0190a6d2311d@changeid>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210819154035.72584-1-luca@coelho.fi>
References: <20210819154035.72584-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH 08/11] iwlwifi: add 'Rx control frame to MBSSID' HE capability
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Shaul Triebitz <shaul.triebitz@intel.com>

'Rx control frame to MBSSID' is supported by HW and FW.
Add the capability to the HE mac capabilities.

Signed-off-by: Shaul Triebitz <shaul.triebitz@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
index 03387a5f8cbc..475f951d4b1e 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
@@ -549,7 +549,8 @@ static const struct ieee80211_sband_iftype_data iwl_he_capa[] = {
 				.mac_cap_info[2] =
 					IEEE80211_HE_MAC_CAP2_32BIT_BA_BITMAP,
 				.mac_cap_info[3] =
-					IEEE80211_HE_MAC_CAP3_OMI_CONTROL,
+					IEEE80211_HE_MAC_CAP3_OMI_CONTROL |
+					IEEE80211_HE_MAC_CAP3_RX_CTRL_FRAME_TO_MULTIBSS,
 				.mac_cap_info[4] =
 					IEEE80211_HE_MAC_CAP4_AMSDU_IN_AMPDU |
 					IEEE80211_HE_MAC_CAP4_MULTI_TID_AGG_TX_QOS_B39,
-- 
2.33.0

