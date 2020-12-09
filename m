Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA9202D4510
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Dec 2020 16:07:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732686AbgLIPGL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Dec 2020 10:06:11 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:35510 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732680AbgLIPGL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Dec 2020 10:06:11 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kn11u-003Dg4-UA; Wed, 09 Dec 2020 17:05:23 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Wed,  9 Dec 2020 17:05:13 +0200
Message-Id: <iwlwifi.20201209170243.c08124dc94e3.I0b5c51aa87e86c964e2eae6d959a96e232840ef5@changeid>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201209150514.944056-1-luca@coelho.fi>
References: <20201209150514.944056-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 10/11] iwlwifi: mvm: purge the BSS table upon firmware load
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

When the firmware is loaded, its internal timer (GP2) is
reset and all the time_sync in the BSS table is now
unusable. Ask cfg80211 to purge the BSS table.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 75bd05f0ba44..8f15f68ffc70 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -402,6 +402,14 @@ static int iwl_mvm_load_ucode_wait_alive(struct iwl_mvm *mvm,
 	iwl_fw_set_dbg_rec_on(&mvm->fwrt);
 #endif
 
+	/*
+	 * All the BSSes in the BSS table include the GP2 in the system
+	 * at the beacon Rx time, this is of course no longer relevant
+	 * since we are resetting the firmware.
+	 * Purge all the BSS table.
+	 */
+	cfg80211_bss_flush(mvm->hw->wiphy);
+
 	return 0;
 }
 
-- 
2.29.2

