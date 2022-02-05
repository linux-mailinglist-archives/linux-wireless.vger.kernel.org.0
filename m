Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC974AA7DC
	for <lists+linux-wireless@lfdr.de>; Sat,  5 Feb 2022 10:21:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346155AbiBEJVv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 5 Feb 2022 04:21:51 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:37992 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1346371AbiBEJVu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 5 Feb 2022 04:21:50 -0500
Received: from 91-156-4-210.elisa-laajakaista.fi ([91.156.4.210] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <luca@coelho.fi>)
        id 1nGHGN-0006b7-5l;
        Sat, 05 Feb 2022 11:21:49 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@kernel.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sat,  5 Feb 2022 11:21:33 +0200
Message-Id: <iwlwifi.20220205112029.7b363457e1aa.Ie4634222e6a33451b88e1042c83e9ea28775bd9f@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220205092140.751171-1-luca@coelho.fi>
References: <20220205092140.751171-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 05/12] iwlwifi: mvm: don't send BAID removal to the FW during hw_restart
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

With the new ML API, we can't send the BAID removal command to
firmware during hw_restart because it will cause an assertion failure
0x350D because the BAID doesn't exist at that point.

So avoid sending the command if we are performing a hw_restart.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index 11b4dd447bc0..2cb1466ca8bd 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2012-2015, 2018-2021 Intel Corporation
+ * Copyright (C) 2012-2015, 2018-2022 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -2713,8 +2713,11 @@ int iwl_mvm_sta_rx_agg(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
 		baid = -1;
 	}
 
-	baid = iwl_mvm_fw_baid_op(mvm, mvm_sta, start, tid, ssn, buf_size,
-				  baid);
+	/* Don't send command to remove (start=0) BAID during restart */
+	if (start || !test_bit(IWL_MVM_STATUS_IN_HW_RESTART, &mvm->status))
+		baid = iwl_mvm_fw_baid_op(mvm, mvm_sta, start, tid, ssn, buf_size,
+					  baid);
+
 	if (baid < 0) {
 		ret = baid;
 		goto out_free;
-- 
2.34.1

