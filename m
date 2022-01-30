Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1958B4A357D
	for <lists+linux-wireless@lfdr.de>; Sun, 30 Jan 2022 10:53:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354535AbiA3JxN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 30 Jan 2022 04:53:13 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:37898 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S236253AbiA3JxL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 30 Jan 2022 04:53:11 -0500
Received: from 91-156-4-210.elisa-laajakaista.fi ([91.156.4.210] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <luca@coelho.fi>)
        id 1nE6tR-0003JO-9J;
        Sun, 30 Jan 2022 11:53:10 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@kernel.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sun, 30 Jan 2022 11:52:56 +0200
Message-Id: <iwlwifi.20220130115024.a90a1363558e.Ifc08db91cdc7d2e8353af55afaf899e10b2ef875@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220130095306.790573-1-luca@coelho.fi>
References: <20220130095306.790573-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 02/12] iwlwifi: read and print OTP minor version
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Sometimes it can be useful to know the OTP minor version, so read it
from the register and print it out.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c | 4 +++-
 drivers/net/wireless/intel/iwlwifi/iwl-prph.h      | 2 ++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
index aebae8251eb8..895b0bc6fd5a 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
@@ -1080,7 +1080,9 @@ static int iwl_set_hw_address(struct iwl_trans *trans,
 		return -EINVAL;
 	}
 
-	IWL_INFO(trans, "base HW address: %pM\n", data->hw_addr);
+	if (!trans->csme_own)
+		IWL_INFO(trans, "base HW address: %pM, OTP minor version: 0x%x\n",
+			 data->hw_addr, iwl_read_prph(trans, REG_OTP_MINOR));
 
 	return 0;
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-prph.h b/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
index 8d37a7e8fa6e..03d296a2b38e 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
@@ -491,4 +491,6 @@ enum {
 #define HBUS_TIMEOUT 0xA5A5A5A1
 #define WFPM_DPHY_OFF 0xDF10FF
 
+#define REG_OTP_MINOR 0xA0333C
+
 #endif				/* __iwl_prph_h__ */
-- 
2.34.1

