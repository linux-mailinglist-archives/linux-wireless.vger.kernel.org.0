Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 629B7309E95
	for <lists+linux-wireless@lfdr.de>; Sun, 31 Jan 2021 21:07:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbhAaUG2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 31 Jan 2021 15:06:28 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:43162 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231304AbhAaUEX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 31 Jan 2021 15:04:23 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1l6HMc-0041H2-Tf; Sun, 31 Jan 2021 20:22:23 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sun, 31 Jan 2021 20:22:12 +0200
Message-Id: <iwlwifi.20210131201908.99428c76c1fc.I2b075d52119d7e4ced6a044f096ee1589c8e631e@changeid>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210131182212.929755-1-luca@coelho.fi>
References: <20210131182212.929755-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 12/12] iwlwifi: bump FW API to 61 for AX devices
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Start supporting API version 61 for AX devices.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/22000.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
index 65a2dacc083e..fa2c9f7c3d4a 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
@@ -9,7 +9,7 @@
 #include "iwl-prph.h"
 
 /* Highest firmware API version supported */
-#define IWL_22000_UCODE_API_MAX	60
+#define IWL_22000_UCODE_API_MAX	61
 
 /* Lowest firmware API version supported */
 #define IWL_22000_UCODE_API_MIN	39
-- 
2.29.2

