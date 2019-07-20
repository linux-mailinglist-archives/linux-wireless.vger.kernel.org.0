Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9166EF0E
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Jul 2019 12:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727890AbfGTK0O (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 20 Jul 2019 06:26:14 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:59496 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727830AbfGTK0N (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 20 Jul 2019 06:26:13 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1homZ9-0000Hj-It; Sat, 20 Jul 2019 13:26:12 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org,
        Shahar S Matityahu <shahar.s.matityahu@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>
Date:   Sat, 20 Jul 2019 13:25:37 +0300
Message-Id: <20190720102545.5952-9-luca@coelho.fi>
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
Subject: [PATCH 08/16] iwlwifi: dbg_ini: move iwl_dbg_tlv_free outside of debugfs ifdef
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Shahar S Matityahu <shahar.s.matityahu@intel.com>

The driver should call iwl_dbg_tlv_free even if debugfs is not defined
since ini mode does not depend on debugfs ifdef.

Signed-off-by: Shahar S Matityahu <shahar.s.matityahu@intel.com>
Fixes: 68f6f492c4fa ("iwlwifi: trans: support loading ini TLVs from external file")
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
index d91686b9a540..38672dd5aae9 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
@@ -1662,8 +1662,8 @@ struct iwl_drv *iwl_drv_start(struct iwl_trans *trans)
 err_fw:
 #ifdef CONFIG_IWLWIFI_DEBUGFS
 	debugfs_remove_recursive(drv->dbgfs_drv);
-	iwl_fw_dbg_free(drv->trans);
 #endif
+	iwl_fw_dbg_free(drv->trans);
 	kfree(drv);
 err:
 	return ERR_PTR(ret);
-- 
2.20.1

