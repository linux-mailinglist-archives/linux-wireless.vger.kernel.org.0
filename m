Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC1BB4389CA
	for <lists+linux-wireless@lfdr.de>; Sun, 24 Oct 2021 17:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbhJXPXT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 24 Oct 2021 11:23:19 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:58656 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231519AbhJXPXS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 24 Oct 2021 11:23:18 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mefIt-000czj-Tt; Sun, 24 Oct 2021 18:20:56 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sun, 24 Oct 2021 18:20:33 +0300
Message-Id: <iwlwifi.20211024181719.98a5572bf0f8.I6c112ca80cf427f12b2c752899d293cb6437ba5f@changeid>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211024152037.332948-1-luca@coelho.fi>
References: <20211024152037.332948-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 08/12] iwlwifi: mvm: fix WGDS table print in iwl_mvm_chub_update_mcc()
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

WGDS table index 0 means disabled, but we were erroneously checking
for < 0 to print that it is disabled.  Fix that and make the print
more readable by mentioning that it's either disabled or there was an
error.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/nvm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/nvm.c b/drivers/net/wireless/intel/iwlwifi/mvm/nvm.c
index da705fcaf0fc..6d18a1fd649b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/nvm.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/nvm.c
@@ -583,8 +583,9 @@ void iwl_mvm_rx_chub_update_mcc(struct iwl_mvm *mvm,
 		return;
 
 	wgds_tbl_idx = iwl_mvm_get_sar_geo_profile(mvm);
-	if (wgds_tbl_idx < 0)
-		IWL_DEBUG_INFO(mvm, "SAR WGDS is disabled (%d)\n",
+	if (wgds_tbl_idx < 1)
+		IWL_DEBUG_INFO(mvm,
+			       "SAR WGDS is disabled or error received (%d)\n",
 			       wgds_tbl_idx);
 	else
 		IWL_DEBUG_INFO(mvm, "SAR WGDS: geo profile %d is configured\n",
-- 
2.33.0

