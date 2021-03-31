Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3641D34FC63
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Mar 2021 11:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234683AbhCaJPn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 31 Mar 2021 05:15:43 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:43796 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229832AbhCaJPX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 31 Mar 2021 05:15:23 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1lRWwJ-00087q-GT; Wed, 31 Mar 2021 12:15:04 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 31 Mar 2021 12:14:52 +0300
Message-Id: <iwlwifi.20210331121101.449b3092c330.I515edcc41913ca7fbe4a4de923671d120d5618c6@changeid>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210331091452.543321-1-luca@coelho.fi>
References: <20210331091452.543321-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH 12/12] iwlwifi: mvm: Use IWL_INFO in fw_reset_handshake()
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ravi Darsi <ravi.darsi@intel.com>

Debug message "firmware didn't ACK the reset - continue anyway\n"
in fw_reset_handshake() is classified as error, however this is not
an error as it is ignored. So, change it to info message for proper
classification of debug messages.

Signed-off-by: Ravi Darsi <ravi.darsi@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
index 497ef3405da3..73894793ed4f 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
@@ -108,8 +108,8 @@ static void iwl_trans_pcie_fw_reset_handshake(struct iwl_trans *trans)
 	ret = wait_event_timeout(trans_pcie->fw_reset_waitq,
 				 trans_pcie->fw_reset_done, FW_RESET_TIMEOUT);
 	if (!ret)
-		IWL_ERR(trans,
-			"firmware didn't ACK the reset - continue anyway\n");
+		IWL_INFO(trans,
+			 "firmware didn't ACK the reset - continue anyway\n");
 }
 
 void _iwl_trans_pcie_gen2_stop_device(struct iwl_trans *trans)
-- 
2.31.0

