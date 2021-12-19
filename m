Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 612FB47A05C
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Dec 2021 12:28:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235634AbhLSL2o (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 19 Dec 2021 06:28:44 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:51418 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S235618AbhLSL2n (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 19 Dec 2021 06:28:43 -0500
Received: from 91-156-5-105.elisa-laajakaista.fi ([91.156.5.105] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1myuMr-001O73-Dm; Sun, 19 Dec 2021 13:28:42 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@kernel.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sun, 19 Dec 2021 13:28:27 +0200
Message-Id: <iwlwifi.20211219132536.525f2d468d22.I4d497d6a0a14ffb833f7edc7e980d26bbf8d7527@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211219112836.132859-1-luca@coelho.fi>
References: <20211219112836.132859-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 03/12] iwlwifi: mvm: correctly set schedule scan profiles
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ayala Beker <ayala.beker@intel.com>

Set scan offload profiles auth algorithms with valid
algorithms only.

Signed-off-by: Ayala Beker <ayala.beker@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/scan.h | 10 ++++++++++
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c    |  4 +++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/scan.h b/drivers/net/wireless/intel/iwlwifi/fw/api/scan.h
index 175e2ce3c82a..68064389cbc8 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/scan.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/scan.h
@@ -82,6 +82,16 @@ enum iwl_scan_offload_band_selection {
 	IWL_SCAN_OFFLOAD_SELECT_ANY	= 0xc,
 };
 
+enum iwl_scan_offload_auth_alg {
+	IWL_AUTH_ALGO_UNSUPPORTED  = 0x00,
+	IWL_AUTH_ALGO_NONE         = 0x01,
+	IWL_AUTH_ALGO_PSK          = 0x02,
+	IWL_AUTH_ALGO_8021X        = 0x04,
+	IWL_AUTH_ALGO_SAE          = 0x08,
+	IWL_AUTH_ALGO_8021X_SHA384 = 0x10,
+	IWL_AUTH_ALGO_OWE          = 0x20,
+};
+
 /**
  * struct iwl_scan_offload_profile - SCAN_OFFLOAD_PROFILE_S
  * @ssid_index:		index to ssid list in fixed part
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
index 68ee57790b17..5f92a09db374 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -579,7 +579,9 @@ iwl_mvm_config_sched_scan_profiles(struct iwl_mvm *mvm,
 		profile->ssid_index = i;
 		/* Support any cipher and auth algorithm */
 		profile->unicast_cipher = 0xff;
-		profile->auth_alg = 0xff;
+		profile->auth_alg = IWL_AUTH_ALGO_UNSUPPORTED |
+			IWL_AUTH_ALGO_NONE | IWL_AUTH_ALGO_PSK | IWL_AUTH_ALGO_8021X |
+			IWL_AUTH_ALGO_SAE | IWL_AUTH_ALGO_8021X_SHA384 | IWL_AUTH_ALGO_OWE;
 		profile->network_type = IWL_NETWORK_TYPE_ANY;
 		profile->band_selection = IWL_SCAN_OFFLOAD_SELECT_ANY;
 		profile->client_bitmap = SCAN_CLIENT_SCHED_SCAN;
-- 
2.34.1

