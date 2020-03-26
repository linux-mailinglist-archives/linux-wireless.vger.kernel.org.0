Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D798193F52
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2020 13:55:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728284AbgCZMz2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Mar 2020 08:55:28 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:44236 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728249AbgCZMz0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Mar 2020 08:55:26 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1jHS2e-00040Z-NX; Thu, 26 Mar 2020 14:55:25 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Thu, 26 Mar 2020 14:55:06 +0200
Message-Id: <iwlwifi.20200326145047.ac26247e395a.Ic1a147f935286b085ca8bdb248a7493b7c6341ea@changeid>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200326125510.621842-1-luca@coelho.fi>
References: <20200326125510.621842-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 08/12] iwlwifi: yoyo: enable yoyo by default
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Now that YoYo is more mature, we can enable it by default, so we
collect data in the new way.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
index 2d1cb4647c3b..43ebfa20a4e1 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
@@ -1715,6 +1715,7 @@ struct iwl_mod_params iwlwifi_mod_params = {
 	.bt_coex_active = true,
 	.power_level = IWL_POWER_INDEX_1,
 	.uapsd_disable = IWL_DISABLE_UAPSD_BSS | IWL_DISABLE_UAPSD_P2P_CLIENT,
+	.enable_ini = true,
 	/* the rest are 0 by default */
 };
 IWL_EXPORT_SYMBOL(iwlwifi_mod_params);
@@ -1837,7 +1838,7 @@ MODULE_PARM_DESC(uapsd_disable,
 module_param_named(enable_ini, iwlwifi_mod_params.enable_ini,
 		   bool, S_IRUGO | S_IWUSR);
 MODULE_PARM_DESC(enable_ini,
-		 "Enable debug INI TLV FW debug infrastructure (default: 0");
+		 "Enable debug INI TLV FW debug infrastructure (default: true");
 
 /*
  * set bt_coex_active to true, uCode will do kill/defer
-- 
2.25.1

