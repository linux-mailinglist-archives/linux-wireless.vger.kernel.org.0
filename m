Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30CED3DDAA5
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Aug 2021 16:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238401AbhHBORd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Aug 2021 10:17:33 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:50848 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S238701AbhHBOPx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Aug 2021 10:15:53 -0400
X-Greylist: delayed 355 seconds by postgrey-1.27 at vger.kernel.org; Mon, 02 Aug 2021 10:15:52 EDT
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1mAYdW-001xoA-7w; Mon, 02 Aug 2021 17:09:47 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Mon,  2 Aug 2021 17:09:34 +0300
Message-Id: <iwlwifi.20210802170640.736c3b1bc915.I10583bb6f808aa60954da26106bbc8c26620cbe8@changeid>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210802140944.90143-1-luca@coelho.fi>
References: <20210802140944.90143-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH 02/12] iwlwifi: mvm: set BROADCAST_TWT_SUPPORTED in MAC policy
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Shaul Triebitz <shaul.triebitz@intel.com>

If broadcast TWT is supported in the BSS, tell the
firmware about it by setting the BROADCAST_TWT_SUPPORTED
in the MAC context command.

Signed-off-by: Shaul Triebitz <shaul.triebitz@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/mac.h   | 4 +++-
 drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c | 5 ++++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/mac.h b/drivers/net/wireless/intel/iwlwifi/fw/api/mac.h
index 93084bbad534..7be7715b431d 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/mac.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/mac.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2012-2014, 2018-2020 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2021 Intel Corporation
  * Copyright (C) 2017 Intel Deutschland GmbH
  */
 #ifndef __iwl_fw_api_mac_h__
@@ -137,12 +137,14 @@ struct iwl_mac_data_ibss {
  *	early termination detection.
  * @FLEXIBLE_TWT_SUPPORTED: AP supports flexible TWT schedule
  * @PROTECTED_TWT_SUPPORTED: AP supports protected TWT frames (with 11w)
+ * @BROADCAST_TWT_SUPPORTED: AP and STA support broadcast TWT
  */
 enum iwl_mac_data_policy {
 	TWT_SUPPORTED = BIT(0),
 	MORE_DATA_ACK_SUPPORTED = BIT(1),
 	FLEXIBLE_TWT_SUPPORTED = BIT(2),
 	PROTECTED_TWT_SUPPORTED = BIT(3),
+	BROADCAST_TWT_SUPPORTED = BIT(4),
 };
 
 /**
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
index fd5e08961651..76a658cb5493 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2012-2014, 2018-2020 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2021 Intel Corporation
  * Copyright (C) 2013-2014 Intel Mobile Communications GmbH
  * Copyright (C) 2015-2017 Intel Deutschland GmbH
  */
@@ -652,6 +652,9 @@ static int iwl_mvm_mac_ctxt_cmd_sta(struct iwl_mvm *mvm,
 			if (vif->bss_conf.twt_protected)
 				ctxt_sta->data_policy |=
 					cpu_to_le32(PROTECTED_TWT_SUPPORTED);
+			if (vif->bss_conf.twt_broadcast)
+				ctxt_sta->data_policy |=
+					cpu_to_le32(BROADCAST_TWT_SUPPORTED);
 		}
 	}
 
-- 
2.32.0

