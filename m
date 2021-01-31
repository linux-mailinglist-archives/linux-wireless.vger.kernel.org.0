Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB1D7309EE6
	for <lists+linux-wireless@lfdr.de>; Sun, 31 Jan 2021 21:27:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbhAaUYo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 31 Jan 2021 15:24:44 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:43164 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231982AbhAaUKr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 31 Jan 2021 15:10:47 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1l6HMZ-0041H2-Mf; Sun, 31 Jan 2021 20:22:20 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sun, 31 Jan 2021 20:22:07 +0200
Message-Id: <iwlwifi.20210131201908.c9d35b7d8748.I4e4cf61d8fa6ff91d9b0cab2b1ec9ede4be346f5@changeid>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210131182212.929755-1-luca@coelho.fi>
References: <20210131182212.929755-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 07/12] iwlwifi: mvm: implement approved list for the PPAG feature
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

We should only allow PPAG to be enabled by OEMs that are in the
approved list.  In order to do this, we need to compare the system
vendor string retrieved from SMBIOS to a list maintained in the
driver.  If the vendor string is not in the list, we don't allow PPAG
to be used.

For now the list is empty, but entries will be added to it
individually, in subsequent patches.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 9f8751ceb45b..e29f2d310fb6 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -6,6 +6,7 @@
  */
 #include <net/mac80211.h>
 #include <linux/netdevice.h>
+#include <linux/dmi.h>
 
 #include "iwl-trans.h"
 #include "iwl-op-mode.h"
@@ -1043,6 +1044,9 @@ int iwl_mvm_ppag_send_cmd(struct iwl_mvm *mvm)
 	return ret;
 }
 
+static const struct dmi_system_id dmi_ppag_approved_list[] = {
+};
+
 static int iwl_mvm_ppag_init(struct iwl_mvm *mvm)
 {
 	int ret;
@@ -1054,6 +1058,15 @@ static int iwl_mvm_ppag_init(struct iwl_mvm *mvm)
 				ret);
 		return 0;
 	}
+
+	if (!dmi_check_system(dmi_ppag_approved_list)) {
+		IWL_DEBUG_RADIO(mvm,
+				"System vendor '%s' is not in the approved list, disabling PPAG.\n",
+				dmi_get_system_info(DMI_SYS_VENDOR));
+		mvm->fwrt.ppag_table.v1.enabled = cpu_to_le32(0);
+		return 0;
+	}
+
 	return iwl_mvm_ppag_send_cmd(mvm);
 }
 
-- 
2.29.2

