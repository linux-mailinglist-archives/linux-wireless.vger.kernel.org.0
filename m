Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E144E3A4E5E
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Jun 2021 13:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbhFLLex (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 12 Jun 2021 07:34:53 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:47590 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231196AbhFLLex (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 12 Jun 2021 07:34:53 -0400
Received: from [192.130.48.226] (helo=kveik.superpark.guest)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1ls1sh-001V8i-4A; Sat, 12 Jun 2021 14:32:52 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sat, 12 Jun 2021 14:32:40 +0300
Message-Id: <iwlwifi.20210612142637.ba22aec1e2be.I36bfadc28c480f4fc57266c075a79e8ea4a6934f@changeid>
X-Mailer: git-send-email 2.32.0.rc2
In-Reply-To: <20210612113245.691117-1-luca@coelho.fi>
References: <20210612113245.691117-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH 07/12] iwlwifi: increase PNVM load timeout
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

The FW has a watchdog of 200ms in the PNVM load flow, so the driver
should have a slightly higher timeout.  Change the timeout from 100ms
to 250ms.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Fixes: 70d3ca86b025 ("iwlwifi: mvm: ring the doorbell and wait for PNVM load completion")
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/pnvm.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/pnvm.h b/drivers/net/wireless/intel/iwlwifi/fw/pnvm.h
index e4f91bce222d..61d3d4e0b7d9 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/pnvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/pnvm.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /******************************************************************************
  *
- * Copyright(c) 2020 Intel Corporation
+ * Copyright(c) 2020-2021 Intel Corporation
  *
  *****************************************************************************/
 
@@ -10,7 +10,7 @@
 
 #include "fw/notif-wait.h"
 
-#define MVM_UCODE_PNVM_TIMEOUT	(HZ / 10)
+#define MVM_UCODE_PNVM_TIMEOUT	(HZ / 4)
 
 int iwl_pnvm_load(struct iwl_trans *trans,
 		  struct iwl_notif_wait_data *notif_wait);
-- 
2.32.0.rc2

