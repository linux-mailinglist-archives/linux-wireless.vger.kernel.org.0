Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA70E2D0332
	for <lists+linux-wireless@lfdr.de>; Sun,  6 Dec 2020 12:08:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727703AbgLFLIX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 6 Dec 2020 06:08:23 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:34810 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727661AbgLFLIW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 6 Dec 2020 06:08:22 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1klrt9-003AAN-HM; Sun, 06 Dec 2020 13:07:35 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sun,  6 Dec 2020 13:07:25 +0200
Message-Id: <iwlwifi.20201206130357.2e2d999b8075.Ib2deb076b392fb516a7230bac91d7ab8a9586d86@changeid>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201206110729.488452-1-luca@coelho.fi>
References: <20201206110729.488452-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 08/12] iwlwifi: trans: consider firmware dead after errors
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

If we get an error, no longer consider the firmware to be
in IWL_TRANS_FW_ALIVE state.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index b84921e1556c..83d06fb8beca 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -1439,8 +1439,10 @@ static inline void iwl_trans_fw_error(struct iwl_trans *trans)
 		return;
 
 	/* prevent double restarts due to the same erroneous FW */
-	if (!test_and_set_bit(STATUS_FW_ERROR, &trans->status))
+	if (!test_and_set_bit(STATUS_FW_ERROR, &trans->status)) {
 		iwl_op_mode_nic_error(trans->op_mode);
+		trans->state = IWL_TRANS_NO_FW;
+	}
 }
 
 static inline bool iwl_trans_fw_running(struct iwl_trans *trans)
-- 
2.29.2

