Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EC7A43895B
	for <lists+linux-wireless@lfdr.de>; Sun, 24 Oct 2021 15:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231724AbhJXN5o (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 24 Oct 2021 09:57:44 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:58560 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231713AbhJXN5n (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 24 Oct 2021 09:57:43 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1medy4-000cvJ-W5; Sun, 24 Oct 2021 16:55:21 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sun, 24 Oct 2021 16:55:05 +0300
Message-Id: <iwlwifi.20211024165252.abd85e1391cb.I7681fe90735044cc1c59f120e8591b7ac125535d@changeid>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211024135506.285102-1-luca@coelho.fi>
References: <20211024135506.285102-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 10/11] iwlwifi: pcie: simplify iwl_pci_find_dev_info()
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

We currently match the list of devices from the start to
the end, but then find the *last* match, so we need to
look at each and every entry. We don't want to change the
semantics ("most generic entry must come first"), so just
change the order of matching to be back-to-front, then we
can break out once we find a match.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 3276f04cfd60..c574f041f096 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -1339,10 +1339,9 @@ iwl_pci_find_dev_info(u16 device, u16 subsystem_device,
 		      u16 mac_type, u8 mac_step,
 		      u16 rf_type, u8 cdb, u8 rf_id, u8 no_160, u8 cores)
 {
-	const struct iwl_dev_info *ret = NULL;
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(iwl_dev_info_table); i++) {
+	for (i = ARRAY_SIZE(iwl_dev_info_table) - 1; i >= 0; i--) {
 		const struct iwl_dev_info *dev_info = &iwl_dev_info_table[i];
 
 		if (dev_info->device != (u16)IWL_CFG_ANY &&
@@ -1381,10 +1380,10 @@ iwl_pci_find_dev_info(u16 device, u16 subsystem_device,
 		    dev_info->cores != cores)
 			continue;
 
-		ret = dev_info;
+		return dev_info;
 	}
 
-	return ret;
+	return NULL;
 }
 
 static int iwl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
-- 
2.33.0

