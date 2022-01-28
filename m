Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0D049F963
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Jan 2022 13:31:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348425AbiA1MbS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Jan 2022 07:31:18 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:37822 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1348395AbiA1MbR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Jan 2022 07:31:17 -0500
Received: from 91-155-254-253.elisa-laajakaista.fi ([91.155.254.253] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <luca@coelho.fi>)
        id 1nDQPL-0002A0-Ji;
        Fri, 28 Jan 2022 14:31:16 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@kernel.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Fri, 28 Jan 2022 14:30:52 +0200
Message-Id: <iwlwifi.20220128142706.5d16821d1433.Id259699ddf9806459856d6aefbdbe54477aecffd@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220128123057.524038-1-luca@coelho.fi>
References: <20220128123057.524038-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH for v5.17 3/8] iwlwifi: pcie: fix locking when "HW not ready"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

If we run into this error path, we shouldn't unlock the mutex
since it's not locked since. Fix this.

Fixes: a6bd005fe92d ("iwlwifi: pcie: fix RF-Kill vs. firmware load race")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index a63386a01232..ef14584fc0a1 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -1329,8 +1329,7 @@ static int iwl_trans_pcie_start_fw(struct iwl_trans *trans,
 	/* This may fail if AMT took ownership of the device */
 	if (iwl_pcie_prepare_card_hw(trans)) {
 		IWL_WARN(trans, "Exit HW not ready\n");
-		ret = -EIO;
-		goto out;
+		return -EIO;
 	}
 
 	iwl_enable_rfkill_int(trans);
-- 
2.34.1

