Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA3C430135
	for <lists+linux-wireless@lfdr.de>; Sat, 16 Oct 2021 10:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243844AbhJPIqQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 16 Oct 2021 04:46:16 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:52876 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S243825AbhJPIqP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 16 Oct 2021 04:46:15 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mbfIT-000Xqv-B8; Sat, 16 Oct 2021 11:44:06 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sat, 16 Oct 2021 11:43:58 +0300
Message-Id: <iwlwifi.20211016114029.33feba783518.I54a5cf33975d0330792b3d208b225d479e168f32@changeid>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211016084359.246930-1-luca@coelho.fi>
References: <20211016084359.246930-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH for v5.15 4/5] iwlwifi: pnvm: read EFI data only if long enough
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

If the data we get from EFI is not even long enough for
the package struct we expect then ignore it entirely.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Fixes: a1a6a4cf49ec ("iwlwifi: pnvm: implement reading PNVM from UEFI")
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/pnvm.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c b/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c
index 9b0eee53488a..069fcbc46d2b 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c
@@ -284,9 +284,13 @@ int iwl_pnvm_load(struct iwl_trans *trans,
 	/* First attempt to get the PNVM from BIOS */
 	package = iwl_uefi_get_pnvm(trans, &len);
 	if (!IS_ERR_OR_NULL(package)) {
-		/* we need only the data */
-		len -= sizeof(*package);
-		data = kmemdup(package->data, len, GFP_KERNEL);
+		if (len >= sizeof(*package)) {
+			/* we need only the data */
+			len -= sizeof(*package);
+			data = kmemdup(package->data, len, GFP_KERNEL);
+		} else {
+			data = NULL;
+		}
 
 		/* free package regardless of whether kmemdup succeeded */
 		kfree(package);
-- 
2.33.0

