Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3003B3DDFB7
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Aug 2021 20:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbhHBS7S (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Aug 2021 14:59:18 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:51030 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230486AbhHBS7Q (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Aug 2021 14:59:16 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1mAd9T-001ySl-RK; Mon, 02 Aug 2021 21:59:05 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Mon,  2 Aug 2021 21:58:52 +0300
Message-Id: <iwlwifi.20210802215208.c9bd2034dc05.I983c25caa09c3776c7640fff73fe739362ecc5b6@changeid>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210802185856.175567-1-luca@coelho.fi>
References: <20210802185856.175567-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH 06/10] iwlwifi: implement Bz NMI behaviour
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

The method to NMI the firmware also changed in Bz devices,
implement the new logic.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-csr.h | 4 ++++
 drivers/net/wireless/intel/iwlwifi/iwl-io.c  | 5 ++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-csr.h b/drivers/net/wireless/intel/iwlwifi/iwl-csr.h
index 704ff2ada122..cf796403c45c 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-csr.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-csr.h
@@ -104,6 +104,10 @@
 /* GIO Chicken Bits (PCI Express bus link power management) */
 #define CSR_GIO_CHICKEN_BITS    (CSR_BASE+0x100)
 
+/* Doorbell NMI (since Bz) */
+#define CSR_DOORBELL_VECTOR	(CSR_BASE + 0x130)
+#define CSR_DOORBELL_VECTOR_NMI	BIT(1)
+
 /* host chicken bits */
 #define CSR_HOST_CHICKEN	(CSR_BASE + 0x204)
 #define CSR_HOST_CHICKEN_PM_IDLE_SRC_DIS_SB_PME	BIT(19)
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-io.c b/drivers/net/wireless/intel/iwlwifi/iwl-io.c
index dba54b3297d1..2517c4ae07ab 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-io.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-io.c
@@ -213,9 +213,12 @@ void iwl_force_nmi(struct iwl_trans *trans)
 	else if (trans->trans_cfg->device_family < IWL_DEVICE_FAMILY_AX210)
 		iwl_write_umac_prph(trans, UREG_NIC_SET_NMI_DRIVER,
 				UREG_NIC_SET_NMI_DRIVER_NMI_FROM_DRIVER);
-	else
+	else if (trans->trans_cfg->device_family < IWL_DEVICE_FAMILY_BZ)
 		iwl_write_umac_prph(trans, UREG_DOORBELL_TO_ISR6,
 				    UREG_DOORBELL_TO_ISR6_NMI_BIT);
+	else
+		iwl_write32(trans, CSR_DOORBELL_VECTOR,
+			    CSR_DOORBELL_VECTOR_NMI);
 }
 IWL_EXPORT_SYMBOL(iwl_force_nmi);
 
-- 
2.32.0

