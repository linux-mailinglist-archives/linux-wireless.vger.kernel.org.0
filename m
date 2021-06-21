Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64D0E3AE446
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Jun 2021 09:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbhFUHkL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Jun 2021 03:40:11 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:48454 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230137AbhFUHkK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Jun 2021 03:40:10 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1lvEVF-001aFa-VL; Mon, 21 Jun 2021 10:37:55 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Mon, 21 Jun 2021 10:37:40 +0300
Message-Id: <iwlwifi.20210621103449.8144a5b7d9a7.Ibf77fd7daa7d22f7c46d1c4a572ab9441a761299@changeid>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210621073740.1105911-1-luca@coelho.fi>
References: <20210621073740.1105911-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH 9/9] iwlwifi: bump FW API to 64 for AX devices
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Start supporting API version 64 for AX devices.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/22000.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
index 0256d0042f71..7f1faa9d97b4 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
  * Copyright (C) 2015-2017 Intel Deutschland GmbH
- * Copyright (C) 2018-2020 Intel Corporation
+ * Copyright (C) 2018-2021 Intel Corporation
  */
 #include <linux/module.h>
 #include <linux/stringify.h>
@@ -9,7 +9,7 @@
 #include "iwl-prph.h"
 
 /* Highest firmware API version supported */
-#define IWL_22000_UCODE_API_MAX	63
+#define IWL_22000_UCODE_API_MAX	64
 
 /* Lowest firmware API version supported */
 #define IWL_22000_UCODE_API_MIN	39
-- 
2.32.0

