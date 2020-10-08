Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 693D92876E7
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Oct 2020 17:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730831AbgJHPO2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Oct 2020 11:14:28 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:54640 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730650AbgJHPO1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Oct 2020 11:14:27 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kQXbI-002QxQ-PN; Thu, 08 Oct 2020 18:13:01 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Thu,  8 Oct 2020 18:12:47 +0300
Message-Id: <iwlwifi.20201008181047.77300b00d3ce.I89d7e45e71f19fd36d89f363a28b4759b59b8765@changeid>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201008151250.332346-1-luca@coelho.fi>
References: <20201008151250.332346-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 10/13] iwlwifi: add trans op to set PNVM
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Add an op to allow setting the PNVM data in the trans.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index caae7b5aa9e6..5dbb5d45304f 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -568,6 +568,8 @@ struct iwl_trans_rxq_dma_data {
  *	Note that the transport must fill in the proper file headers.
  * @debugfs_cleanup: used in the driver unload flow to make a proper cleanup
  *	of the trans debugfs
+ * @set_pnvm: set the pnvm data in the prph scratch buffer, inside the
+ *	context info.
  */
 struct iwl_trans_ops {
 
@@ -640,6 +642,7 @@ struct iwl_trans_ops {
 						 u32 dump_mask);
 	void (*debugfs_cleanup)(struct iwl_trans *trans);
 	void (*sync_nmi)(struct iwl_trans *trans);
+	int (*set_pnvm)(struct iwl_trans *trans, const void *data, u32 len);
 };
 
 /**
@@ -1449,6 +1452,15 @@ static inline void iwl_trans_sync_nmi(struct iwl_trans *trans)
 		trans->ops->sync_nmi(trans);
 }
 
+static inline int iwl_trans_set_pnvm(struct iwl_trans *trans,
+				     const void *data, u32 len)
+{
+	if (trans->ops->set_pnvm)
+		return trans->ops->set_pnvm(trans, data, len);
+
+	return 0;
+}
+
 static inline bool iwl_trans_dbg_ini_valid(struct iwl_trans *trans)
 {
 	return trans->dbg.internal_ini_cfg != IWL_INI_CFG_STATE_NOT_LOADED ||
-- 
2.28.0

