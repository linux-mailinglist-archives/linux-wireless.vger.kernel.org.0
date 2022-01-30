Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6415E4A357E
	for <lists+linux-wireless@lfdr.de>; Sun, 30 Jan 2022 10:53:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354539AbiA3JxO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 30 Jan 2022 04:53:14 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:37900 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1354528AbiA3JxM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 30 Jan 2022 04:53:12 -0500
Received: from 91-156-4-210.elisa-laajakaista.fi ([91.156.4.210] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <luca@coelho.fi>)
        id 1nE6tR-0003JO-Vk;
        Sun, 30 Jan 2022 11:53:10 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@kernel.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sun, 30 Jan 2022 11:52:57 +0200
Message-Id: <iwlwifi.20220130115024.3cb9828df280.I14abe7c71b45bbae3d3cd503e6e13fa2cd372ed4@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220130095306.790573-1-luca@coelho.fi>
References: <20220130095306.790573-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 03/12] iwlwifi: mvm: use debug print instead of WARN_ON()
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Miri Korenblit <miriam.rachel.korenblit@intel.com>

In MCC_UPDATE_CMD we get from the FW the number of entries in the
channel info array. We used to WARN_ON if this parameter is greater
than we expected. Since this is not really a driver bug, and since it
might happen in some valid cases too, we shouldn't use a warning here.

Fix this by replacing the WARN_ON with a debug print.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
index 895b0bc6fd5a..0693dfda43a3 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
@@ -1387,8 +1387,12 @@ iwl_parse_nvm_mcc_info(struct device *dev, const struct iwl_cfg *cfg,
 		nvm_chan = iwl_nvm_channels;
 	}
 
-	if (WARN_ON(num_of_ch > max_num_ch))
+	if (num_of_ch > max_num_ch) {
+		IWL_DEBUG_DEV(dev, IWL_DL_LAR,
+			      "Num of channels (%d) is greater than expected. Truncating to %d\n",
+			      num_of_ch, max_num_ch);
 		num_of_ch = max_num_ch;
+	}
 
 	if (WARN_ON_ONCE(num_of_ch > NL80211_MAX_SUPP_REG_RULES))
 		return ERR_PTR(-EINVAL);
-- 
2.34.1

