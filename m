Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D95F546FB0D
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Dec 2021 08:06:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233290AbhLJHKE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 Dec 2021 02:10:04 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:50798 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231983AbhLJHKD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 Dec 2021 02:10:03 -0500
Received: from 91-156-5-105.elisa-laajakaista.fi ([91.156.5.105] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mvZz5-001F9v-Q7; Fri, 10 Dec 2021 09:06:24 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@kernel.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Fri, 10 Dec 2021 09:06:11 +0200
Message-Id: <iwlwifi.20211210090244.75b6207536e3.I7d170a48a9096e6b7269c3a9f447c326f929b171@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211210070621.236783-1-luca@coelho.fi>
References: <20211210070621.236783-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 01/11] iwlwifi: fix Bz NMI behaviour
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Contrary to what was stated before, the hardware hasn't changed
the bits here yet. In any case, the new CSR is also directly
(lower 16 bits) connected to UREG_DOORBELL_TO_ISR6, so if it
still changes the changes would be there. Adjust the code and
comments accordingly.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Fixes: 6c0795f1a524 ("iwlwifi: implement Bz NMI behaviour")
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-csr.h | 5 +++--
 drivers/net/wireless/intel/iwlwifi/iwl-io.c  | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-csr.h b/drivers/net/wireless/intel/iwlwifi/iwl-csr.h
index 21d8249980fa..f90d4662c164 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-csr.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-csr.h
@@ -109,9 +109,10 @@
 #define CSR_IPC_SLEEP_CONTROL_SUSPEND	0x3
 #define CSR_IPC_SLEEP_CONTROL_RESUME	0
 
-/* Doorbell NMI (since Bz) */
+/* Doorbell - since Bz
+ * connected to UREG_DOORBELL_TO_ISR6 (lower 16 bits only)
+ */
 #define CSR_DOORBELL_VECTOR	(CSR_BASE + 0x130)
-#define CSR_DOORBELL_VECTOR_NMI	BIT(1)
 
 /* host chicken bits */
 #define CSR_HOST_CHICKEN	(CSR_BASE + 0x204)
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-io.c b/drivers/net/wireless/intel/iwlwifi/iwl-io.c
index 46917b4216b3..253eac4cbf59 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-io.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-io.c
@@ -218,7 +218,7 @@ void iwl_force_nmi(struct iwl_trans *trans)
 				    UREG_DOORBELL_TO_ISR6_NMI_BIT);
 	else
 		iwl_write32(trans, CSR_DOORBELL_VECTOR,
-			    CSR_DOORBELL_VECTOR_NMI);
+			    UREG_DOORBELL_TO_ISR6_NMI_BIT);
 }
 IWL_EXPORT_SYMBOL(iwl_force_nmi);
 
-- 
2.34.1

