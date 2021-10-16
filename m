Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42034430134
	for <lists+linux-wireless@lfdr.de>; Sat, 16 Oct 2021 10:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243833AbhJPIqO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 16 Oct 2021 04:46:14 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:52864 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S243825AbhJPIqN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 16 Oct 2021 04:46:13 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mbfIS-000Xqv-BB; Sat, 16 Oct 2021 11:44:05 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sat, 16 Oct 2021 11:43:57 +0300
Message-Id: <iwlwifi.20211016114029.ab0e64c3fba9.Ic6a3295fc384750b51b4270bf0b7d94984a139f2@changeid>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211016084359.246930-1-luca@coelho.fi>
References: <20211016084359.246930-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH for v5.15 3/5] iwlwifi: pnvm: don't kmemdup() more than we have
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

We shouldn't kmemdup() more data than we have, that might
cause the code to crash. Fix that by updating the length
before the kmemdup.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/pnvm.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c b/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c
index dde22bdc8703..9b0eee53488a 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c
@@ -284,16 +284,15 @@ int iwl_pnvm_load(struct iwl_trans *trans,
 	/* First attempt to get the PNVM from BIOS */
 	package = iwl_uefi_get_pnvm(trans, &len);
 	if (!IS_ERR_OR_NULL(package)) {
+		/* we need only the data */
+		len -= sizeof(*package);
 		data = kmemdup(package->data, len, GFP_KERNEL);
 
 		/* free package regardless of whether kmemdup succeeded */
 		kfree(package);
 
-		if (data) {
-			/* we need only the data size */
-			len -= sizeof(*package);
+		if (data)
 			goto parse;
-		}
 	}
 
 	/* If it's not available, try from the filesystem */
-- 
2.33.0

