Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED3649F969
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Jan 2022 13:31:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348487AbiA1MbZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Jan 2022 07:31:25 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:37832 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1348477AbiA1MbY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Jan 2022 07:31:24 -0500
Received: from 91-155-254-253.elisa-laajakaista.fi ([91.155.254.253] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <luca@coelho.fi>)
        id 1nDQPS-0002A0-Gt;
        Fri, 28 Jan 2022 14:31:23 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@kernel.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Fri, 28 Jan 2022 14:30:57 +0200
Message-Id: <iwlwifi.20220128142706.a136f9f46336.Ief7506dc3b1813a1943a5a639aa45d8e5f284f31@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220128123057.524038-1-luca@coelho.fi>
References: <20220128123057.524038-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH for v5.17 8/8] iwlwifi: mei: report RFKILL upon register when needed
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

When we register and we are in link protection passive, meaning
that the host can't touch the device, report RFKILL immediately
upon register() and don't wait for the CSME firmware to let us
know again about the link protection state.

What happens if we wait is that the host will not see RFKILL soon
enough and we'll have a window of time during which it can bring
up the device which will request ownership.

Fixes: 2da4366f9e2c ("iwlwifi: mei: add the driver to allow cooperation with CSME")
Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mei/main.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mei/main.c b/drivers/net/wireless/intel/iwlwifi/mei/main.c
index 6cc5553027a0..2f7f0f994ca3 100644
--- a/drivers/net/wireless/intel/iwlwifi/mei/main.c
+++ b/drivers/net/wireless/intel/iwlwifi/mei/main.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Copyright (C) 2021 Intel Corporation
+ * Copyright (C) 2021-2022 Intel Corporation
  */
 
 #include <linux/etherdevice.h>
@@ -146,6 +146,7 @@ struct iwl_mei_filters {
  * @csme_taking_ownership: true when CSME is taking ownership. Used to remember
  *	to send CSME_OWNERSHIP_CONFIRMED when the driver completes its down
  *	flow.
+ * @link_prot_state: true when we are in link protection PASSIVE
  * @csa_throttle_end_wk: used when &csa_throttled is true
  * @data_q_lock: protects the access to the data queues which are
  *	accessed without the mutex.
@@ -165,6 +166,7 @@ struct iwl_mei {
 	bool amt_enabled;
 	bool csa_throttled;
 	bool csme_taking_ownership;
+	bool link_prot_state;
 	struct delayed_work csa_throttle_end_wk;
 	spinlock_t data_q_lock;
 
@@ -667,6 +669,8 @@ iwl_mei_handle_conn_status(struct mei_cl_device *cldev,
 
 	iwl_mei_cache.ops->me_conn_status(iwl_mei_cache.priv, &conn_info);
 
+	mei->link_prot_state = status->link_prot_state;
+
 	/*
 	 * Update the Rfkill state in case the host does not own the device:
 	 * if we are in Link Protection, ask to not touch the device, else,
@@ -1661,9 +1665,11 @@ int iwl_mei_register(void *priv, const struct iwl_mei_ops *ops)
 			mei_cldev_get_drvdata(iwl_mei_global_cldev);
 
 		/* we have already a SAP connection */
-		if (iwl_mei_is_connected())
+		if (iwl_mei_is_connected()) {
 			iwl_mei_send_sap_msg(mei->cldev,
 					     SAP_MSG_NOTIF_WIFIDR_UP);
+			ops->rfkill(priv, mei->link_prot_state);
+		}
 	}
 	ret = 0;
 
-- 
2.34.1

