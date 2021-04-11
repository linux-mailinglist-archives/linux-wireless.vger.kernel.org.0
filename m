Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED1035B326
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Apr 2021 12:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235410AbhDKK0M (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 11 Apr 2021 06:26:12 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:44536 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S235388AbhDKK0K (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 11 Apr 2021 06:26:10 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1lVXHq-000K0H-U2; Sun, 11 Apr 2021 13:25:52 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sun, 11 Apr 2021 13:25:44 +0300
Message-Id: <iwlwifi.20210411132130.805401a1b8ec.I30db38184a418cfc1c5ca1a305cc14a52501d415@changeid>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210411102545.438654-1-luca@coelho.fi>
References: <20210411102545.438654-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH 7/8] iwlwifi: dbg:  disable ini debug in 9000 family and below
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mukesh Sisodiya <mukesh.sisodiya@intel.com>

Yoyo based debug is not applicable to old devices.  As init debug is
enabled by default in the driver, it needs to be disabled to work the
old debug mechanism in old devices.

Signed-off-by: Mukesh Sisodiya <mukesh.sisodiya@intel.com>
Fixes: b0d8d2c27007 ("iwlwifi: yoyo: enable yoyo by default")
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
index 579bc81cc0ae..4cd8c39cc3e9 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2018-2020 Intel Corporation
+ * Copyright (C) 2018-2021 Intel Corporation
  */
 #include <linux/firmware.h>
 #include "iwl-drv.h"
@@ -426,7 +426,8 @@ void iwl_dbg_tlv_load_bin(struct device *dev, struct iwl_trans *trans)
 	const struct firmware *fw;
 	int res;
 
-	if (!iwlwifi_mod_params.enable_ini)
+	if (!iwlwifi_mod_params.enable_ini ||
+	    trans->trans_cfg->device_family <= IWL_DEVICE_FAMILY_9000)
 		return;
 
 	res = firmware_request_nowarn(&fw, "iwl-debug-yoyo.bin", dev);
-- 
2.31.0

