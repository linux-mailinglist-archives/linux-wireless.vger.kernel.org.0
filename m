Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1C6EA43BC
	for <lists+linux-wireless@lfdr.de>; Sat, 31 Aug 2019 11:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbfHaJtJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 31 Aug 2019 05:49:09 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:39638 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726354AbfHaJtI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 31 Aug 2019 05:49:08 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1i400I-0002OQ-Uy; Sat, 31 Aug 2019 12:49:07 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sat, 31 Aug 2019 12:48:43 +0300
Message-Id: <20190831094859.6391-4-luca@coelho.fi>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190831094859.6391-1-luca@coelho.fi>
References: <20190831094859.6391-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH 03/19] iwlwifi: mvm: remove check for lq_sta in __iwl_mvm_rs_tx_status()
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

The check is not necessary anymore, because now the struct is not
allocated separately, but is part of the mvmsta struct.  Remove the
check, since it's dead code.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/rs.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rs.c b/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
index e4415e58fa78..fcd1b15d2fa0 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
@@ -3079,11 +3079,7 @@ static void __iwl_mvm_rs_tx_status(struct iwl_mvm *mvm,
 	struct iwl_mvm_sta *mvmsta = iwl_mvm_sta_from_mac80211(sta);
 	struct iwl_lq_sta *lq_sta = &mvmsta->lq_sta.rs_drv;
 
-	/* Treat uninitialized rate scaling data same as non-existing. */
-	if (!lq_sta) {
-		IWL_DEBUG_RATE(mvm, "Station rate scaling not created yet.\n");
-		return;
-	} else if (!lq_sta->pers.drv) {
+	if (!lq_sta->pers.drv) {
 		IWL_DEBUG_RATE(mvm, "Rate scaling not initialized yet.\n");
 		return;
 	}
-- 
2.23.0.rc1

