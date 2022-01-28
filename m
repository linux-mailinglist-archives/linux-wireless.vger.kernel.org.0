Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DEDC49F961
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Jan 2022 13:31:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348392AbiA1MbP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Jan 2022 07:31:15 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:37818 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1348404AbiA1MbP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Jan 2022 07:31:15 -0500
Received: from 91-155-254-253.elisa-laajakaista.fi ([91.155.254.253] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <luca@coelho.fi>)
        id 1nDQPF-0002A0-PJ;
        Fri, 28 Jan 2022 14:31:13 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@kernel.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Fri, 28 Jan 2022 14:30:50 +0200
Message-Id: <iwlwifi.20220128142706.a264ac51d106.I228ba1317cdcbfef931c09d280d701fcad9048d2@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220128123057.524038-1-luca@coelho.fi>
References: <20220128123057.524038-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH for v5.17 1/8] iwlwifi: mvm: fix condition which checks the version of rate_n_flags
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Miri Korenblit <miriam.rachel.korenblit@intel.com>

We're checking the FW version of TX_CMD in order to decide whether to
convert rate_n_flags from the old format to the new one.  If the API
is smaller or equal to 6 we should convert it.  Currently we're
converting if the API version is greater than 6. Fix it.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Fixes: dc52fac37c87 ("iwlwifi: mvm: Support new TX_RSP and COMPRESSED_BA_RES versions")
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
index 6fa2c12f7955..9213f8518f10 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -1427,7 +1427,7 @@ static void iwl_mvm_hwrate_to_tx_status(const struct iwl_fw *fw,
 	struct ieee80211_tx_rate *r = &info->status.rates[0];
 
 	if (iwl_fw_lookup_notif_ver(fw, LONG_GROUP,
-				    TX_CMD, 0) > 6)
+				    TX_CMD, 0) <= 6)
 		rate_n_flags = iwl_new_rate_from_v1(rate_n_flags);
 
 	info->status.antenna =
-- 
2.34.1

