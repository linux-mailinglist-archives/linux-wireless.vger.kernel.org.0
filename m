Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABBC543098E
	for <lists+linux-wireless@lfdr.de>; Sun, 17 Oct 2021 16:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343822AbhJQOCW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 17 Oct 2021 10:02:22 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:53988 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1343821AbhJQOCU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 17 Oct 2021 10:02:20 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mc6ho-000Yi6-Ft; Sun, 17 Oct 2021 17:00:09 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sun, 17 Oct 2021 16:59:54 +0300
Message-Id: <iwlwifi.20211017165728.83422182774a.I40703fd517534133eb67d644ee16532ba8a67e35@changeid>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211017135954.504836-1-luca@coelho.fi>
References: <20211017135954.504836-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 10/10] iwlwifi: pnvm: print out the version properly
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

The version really is a git sha1, not a hex number, so we
need to print it out with leading zeroes (8 digits) and
without 0x prefix.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/pnvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c b/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c
index dde22bdc8703..3b0880127c66 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c
@@ -162,7 +162,7 @@ static int iwl_pnvm_handle_section(struct iwl_trans *trans, const u8 *data,
 		goto out;
 	}
 
-	IWL_INFO(trans, "loaded PNVM version 0x%0x\n", sha1);
+	IWL_INFO(trans, "loaded PNVM version %08x\n", sha1);
 
 	ret = iwl_trans_set_pnvm(trans, pnvm_data, size);
 out:
-- 
2.33.0

