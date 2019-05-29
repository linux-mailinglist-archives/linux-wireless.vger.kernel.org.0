Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D74DB2DEA3
	for <lists+linux-wireless@lfdr.de>; Wed, 29 May 2019 15:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727574AbfE2NkG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 May 2019 09:40:06 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:54374 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727097AbfE2NkG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 May 2019 09:40:06 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1hVyoG-00080o-Gg; Wed, 29 May 2019 16:40:04 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, Lior Cohen <lior2.cohen@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>
Subject: [PATCH 7/7] iwlwifi: mvm: change TLC config cmd sent by rs to be async
Date:   Wed, 29 May 2019 16:39:55 +0300
Message-Id: <20190529133955.31082-8-luca@coelho.fi>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190529133955.31082-1-luca@coelho.fi>
References: <20190529133955.31082-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Lior Cohen <lior2.cohen@intel.com>

The TLC_MNG_CONFIG sync cmd sent by the rs leads to a kernel warning
of sleeping while in rcu read-side critical section. The fix is to
change the command to be ASYNC (not blocking for the response anymore).

Signed-off-by: Lior Cohen <lior2.cohen@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
index 659e21b2d4e7..be62f499c595 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
@@ -441,7 +441,8 @@ void rs_fw_rate_init(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
 	 */
 	sta->max_amsdu_len = max_amsdu_len;
 
-	ret = iwl_mvm_send_cmd_pdu(mvm, cmd_id, 0, sizeof(cfg_cmd), &cfg_cmd);
+	ret = iwl_mvm_send_cmd_pdu(mvm, cmd_id, CMD_ASYNC, sizeof(cfg_cmd),
+				   &cfg_cmd);
 	if (ret)
 		IWL_ERR(mvm, "Failed to send rate scale config (%d)\n", ret);
 }
-- 
2.20.1

