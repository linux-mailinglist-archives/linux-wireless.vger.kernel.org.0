Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC85734A590
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Mar 2021 11:31:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbhCZKap (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Mar 2021 06:30:45 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:43298 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230027AbhCZKam (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Mar 2021 06:30:42 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1lPjjg-0003EY-RX; Fri, 26 Mar 2021 12:30:38 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 26 Mar 2021 12:30:29 +0200
Message-Id: <20210326103035.206088-2-luca@coelho.fi>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210326103035.206088-1-luca@coelho.fi>
References: <20210326103035.206088-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH for v5.12 1/7] iwlwifi: fix 11ax disabled bit in the regulatory capability flags
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

When version 2 of the regulatory capability flags API was implemented,
the flag to disable 11ax was defined as bit 13, but this was later
changed and the bit remained as bit 10, like in version 1.  This was
never changed in the driver, so we were checking for the wrong bit in
newer devices.  Fix it.

Change-Id: Id0248d5e4662695254f49ce37b0268834ed52918
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Fixes: e27c506a985c ("iwlwifi: regulatory: regulatory capabilities api change")
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
index af684f80b0cc..c5a1e84dc1ab 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
@@ -232,7 +232,7 @@ enum iwl_reg_capa_flags_v2 {
 	REG_CAPA_V2_MCS_9_ALLOWED	= BIT(6),
 	REG_CAPA_V2_WEATHER_DISABLED	= BIT(7),
 	REG_CAPA_V2_40MHZ_ALLOWED	= BIT(8),
-	REG_CAPA_V2_11AX_DISABLED	= BIT(13),
+	REG_CAPA_V2_11AX_DISABLED	= BIT(10),
 };
 
 /*
-- 
2.31.0

