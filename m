Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CBA16EF14
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Jul 2019 12:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbfGTK12 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 20 Jul 2019 06:27:28 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:59576 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727851AbfGTK11 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 20 Jul 2019 06:27:27 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1homZS-0000Hj-S9; Sat, 20 Jul 2019 13:26:32 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org,
        Luca Coelho <luciano.coelho@intel.com>
Date:   Sat, 20 Jul 2019 13:25:45 +0300
Message-Id: <20190720102545.5952-17-luca@coelho.fi>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190720102545.5952-1-luca@coelho.fi>
References: <20190720102545.5952-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.2
Subject: [PATCH 16/16] iwlwifi: mvm: fix version check for GEO_TX_POWER_LIMIT support
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

We erroneously added a check for FW API version 41 before sending
GEO_TX_POWER_LIMIT, but this was already implemented in version 38.
Additionally, it was cherry-picked to older versions, namely 17, 26
and 29, so check for those as well.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index a837cf40afde..00c89bcfdf6a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -886,9 +886,14 @@ static bool iwl_mvm_sar_geo_support(struct iwl_mvm *mvm)
 	 * The GEO_TX_POWER_LIMIT command is not supported on earlier
 	 * firmware versions.  Unfortunately, we don't have a TLV API
 	 * flag to rely on, so rely on the major version which is in
-	 * the first byte of ucode_ver.
+	 * the first byte of ucode_ver.  This was implemented
+	 * initially on version 38 and then backported to 36, 29 and
+	 * 17.
 	 */
-	return IWL_UCODE_SERIAL(mvm->fw->ucode_ver) >= 41;
+	return IWL_UCODE_SERIAL(mvm->fw->ucode_ver) >= 38 ||
+	       IWL_UCODE_SERIAL(mvm->fw->ucode_ver) == 36 ||
+	       IWL_UCODE_SERIAL(mvm->fw->ucode_ver) == 29 ||
+	       IWL_UCODE_SERIAL(mvm->fw->ucode_ver) == 17;
 }
 
 int iwl_mvm_get_sar_geo_profile(struct iwl_mvm *mvm)
-- 
2.20.1

