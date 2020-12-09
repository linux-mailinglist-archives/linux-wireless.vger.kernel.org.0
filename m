Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6F302D4CED
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Dec 2020 22:36:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727369AbgLIVez (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Dec 2020 16:34:55 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:35870 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387893AbgLIVeT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Dec 2020 16:34:19 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kn6pl-003Drx-S8; Wed, 09 Dec 2020 23:17:14 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Wed,  9 Dec 2020 23:16:30 +0200
Message-Id: <iwlwifi.20201209231352.2f982365d085.Id09daabfd331ba9e120abcbbedd2ad6448902ed0@changeid>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201209211651.968276-1-luca@coelho.fi>
References: <20201209211651.968276-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH v2 26/47] iwlwifi: mvm: fix 22000 series driver NMI
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

For triggering an NMI in the firmware, we should only set BIT(24)
in the corresponding register, not the entire mask that's usable
by the driver.

This currently doesn't matter because the firmware only enables
BIT(24), but we'll start using BIT(25) for other purposes with an
upcoming API change.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-io.c   | 2 +-
 drivers/net/wireless/intel/iwlwifi/iwl-prph.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-io.c b/drivers/net/wireless/intel/iwlwifi/iwl-io.c
index 2139f0b8f2bb..b24160fe73d3 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-io.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-io.c
@@ -279,7 +279,7 @@ void iwl_force_nmi(struct iwl_trans *trans)
 			       DEVICE_SET_NMI_VAL_DRV);
 	else if (trans->trans_cfg->device_family < IWL_DEVICE_FAMILY_AX210)
 		iwl_write_umac_prph(trans, UREG_NIC_SET_NMI_DRIVER,
-				UREG_NIC_SET_NMI_DRIVER_NMI_FROM_DRIVER_MSK);
+				UREG_NIC_SET_NMI_DRIVER_NMI_FROM_DRIVER);
 	else
 		iwl_write_umac_prph(trans, UREG_DOORBELL_TO_ISR6,
 				    UREG_DOORBELL_TO_ISR6_NMI_BIT);
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-prph.h b/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
index 6c44a49640be..1a1628550cce 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
@@ -109,7 +109,7 @@
 #define DEVICE_SET_NMI_VAL_DRV BIT(7)
 /* Device NMI register and value for 9000 family and above hw's */
 #define UREG_NIC_SET_NMI_DRIVER 0x00a05c10
-#define UREG_NIC_SET_NMI_DRIVER_NMI_FROM_DRIVER_MSK 0xff000000
+#define UREG_NIC_SET_NMI_DRIVER_NMI_FROM_DRIVER BIT(24)
 
 /* Shared registers (0x0..0x3ff, via target indirect or periphery */
 #define SHR_BASE	0x00a10000
-- 
2.29.2

