Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC6BB14EDB6
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Jan 2020 14:45:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728771AbgAaNpn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 31 Jan 2020 08:45:43 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:56004 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728696AbgAaNpm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 31 Jan 2020 08:45:42 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <luca@coelho.fi>)
        id 1ixWc9-0002Nv-Bp; Fri, 31 Jan 2020 15:45:41 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 31 Jan 2020 15:45:28 +0200
Message-Id: <20200131134530.931641-6-luca@coelho.fi>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200131134530.931641-1-luca@coelho.fi>
References: <20200131134530.931641-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.2
Subject: [PATCH v5.6 5/7] iwlwifi: mvm: Check the sta is not NULL in iwl_mvm_cfg_he_sta()
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Andrei Otcheretianski <andrei.otcheretianski@intel.com>

Fix a kernel panic by checking that the sta is not NULL.
This could happen during a reconfig flow, as mac80211 moves the sta
between all the states without really checking if the previous state was
successfully set. So, if for some reason we failed to add back the
station, subsequent calls to sta_state() callback will be done when the
station is NULL. This would result in a following panic:

BUG: unable to handle kernel NULL pointer dereference at
0000000000000040
IP: iwl_mvm_cfg_he_sta+0xfc/0x690 [iwlmvm]
[..]
Call Trace:
 iwl_mvm_mac_sta_state+0x629/0x6f0 [iwlmvm]
 drv_sta_state+0xf4/0x950 [mac80211]
 ieee80211_reconfig+0xa12/0x2180 [mac80211]
 ieee80211_restart_work+0xbb/0xe0 [mac80211]
 process_one_work+0x1e2/0x610
 worker_thread+0x4d/0x3e0
[..]

Signed-off-by: Andrei Otcheretianski <andrei.otcheretianski@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 6717f25c46b1..8ecd1f6875de 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -5,10 +5,9 @@
  *
  * GPL LICENSE SUMMARY
  *
- * Copyright(c) 2012 - 2014 Intel Corporation. All rights reserved.
  * Copyright(c) 2013 - 2015 Intel Mobile Communications GmbH
  * Copyright(c) 2016 - 2017 Intel Deutschland GmbH
- * Copyright(c) 2018 - 2019 Intel Corporation
+ * Copyright(c) 2012 - 2014, 2018 - 2020 Intel Corporation
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of version 2 of the GNU General Public License as
@@ -28,10 +27,9 @@
  *
  * BSD LICENSE
  *
- * Copyright(c) 2012 - 2014 Intel Corporation. All rights reserved.
  * Copyright(c) 2013 - 2015 Intel Mobile Communications GmbH
  * Copyright(c) 2016 - 2017 Intel Deutschland GmbH
- * Copyright(c) 2018 - 2019 Intel Corporation
+ * Copyright(c) 2012 - 2014, 2018 - 2020 Intel Corporation
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
@@ -2037,7 +2035,7 @@ static void iwl_mvm_cfg_he_sta(struct iwl_mvm *mvm,
 	rcu_read_lock();
 
 	sta = rcu_dereference(mvm->fw_id_to_mac_id[sta_ctxt_cmd.sta_id]);
-	if (IS_ERR(sta)) {
+	if (IS_ERR_OR_NULL(sta)) {
 		rcu_read_unlock();
 		WARN(1, "Can't find STA to configure HE\n");
 		return;
-- 
2.24.1

