Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 937512876C5
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Oct 2020 17:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730896AbgJHPKA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Oct 2020 11:10:00 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:54460 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730806AbgJHPJ5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Oct 2020 11:09:57 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kQXYJ-002Qut-J9; Thu, 08 Oct 2020 18:09:55 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Thu,  8 Oct 2020 18:09:39 +0300
Message-Id: <iwlwifi.20201008180656.065c5abcb913.Ifebf7fe47025d720ed58dda0b7ba389b473fe590@changeid>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201008150949.331882-1-luca@coelho.fi>
References: <20201008150949.331882-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 03/13] iwlwifi: update prph scratch structure to include PNVM data
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

The ROR structure was replaced by the PNVM structure.  They are
functionally identical, only the names have changed.  For now we keep
them set to 0, which means that the PNVM was not found and should not
be loaded.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../intel/iwlwifi/iwl-context-info-gen3.h      | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-context-info-gen3.h b/drivers/net/wireless/intel/iwlwifi/iwl-context-info-gen3.h
index 9d7a04833cd0..983e5b2859b3 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-context-info-gen3.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-context-info-gen3.h
@@ -138,16 +138,16 @@ struct iwl_prph_scratch_control {
 } __packed; /* PERIPH_SCRATCH_CONTROL_S */
 
 /*
- * struct iwl_prph_scratch_ror_cfg - ror config
- * @ror_base_addr: ror start address
- * @ror_size: ror size in DWs
+ * struct iwl_prph_scratch_pnvm_cfg - ror config
+ * @pnvm_base_addr: PNVM start address
+ * @pnvm_size: PNVM size in DWs
  * @reserved: reserved
  */
-struct iwl_prph_scratch_ror_cfg {
-	__le64 ror_base_addr;
-	__le32 ror_size;
+struct iwl_prph_scratch_pnvm_cfg {
+	__le64 pnvm_base_addr;
+	__le32 pnvm_size;
 	__le32 reserved;
-} __packed; /* PERIPH_SCRATCH_ROR_CFG_S */
+} __packed; /* PERIPH_SCRATCH_PNVM_CFG_S */
 
 /*
  * struct iwl_prph_scratch_hwm_cfg - hwm config
@@ -175,14 +175,14 @@ struct iwl_prph_scratch_rbd_cfg {
  * struct iwl_prph_scratch_ctrl_cfg - prph scratch ctrl and config
  * @version: version information of context info and HW
  * @control: control flags of FH configurations
- * @ror_cfg: ror configuration
+ * @pnvm_cfg: ror configuration
  * @hwm_cfg: hwm configuration
  * @rbd_cfg: default RX queue configuration
  */
 struct iwl_prph_scratch_ctrl_cfg {
 	struct iwl_prph_scratch_version version;
 	struct iwl_prph_scratch_control control;
-	struct iwl_prph_scratch_ror_cfg ror_cfg;
+	struct iwl_prph_scratch_pnvm_cfg pnvm_cfg;
 	struct iwl_prph_scratch_hwm_cfg hwm_cfg;
 	struct iwl_prph_scratch_rbd_cfg rbd_cfg;
 } __packed; /* PERIPH_SCRATCH_CTRL_CFG_S */
-- 
2.28.0

