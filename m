Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBEC3BC5AE
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Sep 2019 12:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409467AbfIXKbF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 Sep 2019 06:31:05 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:44742 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387644AbfIXKbF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 Sep 2019 06:31:05 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1iCi63-0005Je-8E; Tue, 24 Sep 2019 13:31:03 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Tue, 24 Sep 2019 13:30:57 +0300
Message-Id: <20190924103057.17147-1-luca@coelho.fi>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH v5.4] iwlwifi: fw: don't send GEO_TX_POWER_LIMIT command to FW version 36
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

The intention was to have the GEO_TX_POWER_LIMIT command in FW version
36 as well, but not all 8000 family got this feature enabled.  The
8000 family is the only one using version 36, so skip this version
entirely.  If we try to send this command to the firmwares that do not
support it, we get a BAD_COMMAND response from the firmware.

This fixes https://bugzilla.kernel.org/show_bug.cgi?id=204151.

Cc: stable@vger.kernel.org # 4.19+
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 014eca6596e2..32a5e4e5461f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -889,11 +889,13 @@ static bool iwl_mvm_sar_geo_support(struct iwl_mvm *mvm)
 	 * firmware versions.  Unfortunately, we don't have a TLV API
 	 * flag to rely on, so rely on the major version which is in
 	 * the first byte of ucode_ver.  This was implemented
-	 * initially on version 38 and then backported to 36, 29 and
-	 * 17.
+	 * initially on version 38 and then backported to29 and 17.
+	 * The intention was to have it in 36 as well, but not all
+	 * 8000 family got this feature enabled.  The 8000 family is
+	 * the only one using version 36, so skip this version
+	 * entirely.
 	 */
 	return IWL_UCODE_SERIAL(mvm->fw->ucode_ver) >= 38 ||
-	       IWL_UCODE_SERIAL(mvm->fw->ucode_ver) == 36 ||
 	       IWL_UCODE_SERIAL(mvm->fw->ucode_ver) == 29 ||
 	       IWL_UCODE_SERIAL(mvm->fw->ucode_ver) == 17;
 }
-- 
2.23.0

