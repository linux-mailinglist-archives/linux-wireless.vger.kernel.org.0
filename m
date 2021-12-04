Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0669146860D
	for <lists+linux-wireless@lfdr.de>; Sat,  4 Dec 2021 16:50:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348724AbhLDPxX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 4 Dec 2021 10:53:23 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:50490 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1348309AbhLDPxW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 4 Dec 2021 10:53:22 -0500
Received: from 91-156-5-105.elisa-laajakaista.fi ([91.156.5.105] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mtXIQ-0017qB-Hm; Sat, 04 Dec 2021 17:49:56 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sat,  4 Dec 2021 17:49:39 +0200
Message-Id: <iwlwifi.20211204174546.497b2f2c587d.If71fa8cbed043c15f927bb78cb8a695625a362dd@changeid>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211204154944.914175-1-luca@coelho.fi>
References: <20211204154944.914175-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 07/12] iwlwifi: Fix FW name for gl
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Matti Gottlieb <matti.gottlieb@intel.com>

Fix FW name for gl use the crf fm and not fm7, since the
later no longer exists.

Signed-off-by: Matti Gottlieb <matti.gottlieb@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/22000.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
index c9ccbbe3b92d..b1ad0e1c472a 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
@@ -54,7 +54,7 @@
 #define IWL_BZ_A_GF4_A_FW_PRE		"iwlwifi-bz-a0-gf4-a0-"
 #define IWL_BZ_A_MR_A_FW_PRE		"iwlwifi-bz-a0-mr-a0-"
 #define IWL_BZ_A_FM_A_FW_PRE		"iwlwifi-bz-a0-fm-a0-"
-#define IWL_GL_A_FM_A_FW_PRE		"iwlwifi-gl-a0-fm7-a0-"
+#define IWL_GL_A_FM_A_FW_PRE		"iwlwifi-gl-a0-fm-a0-"
 #define IWL_BZ_Z_GF_A_FW_PRE		"iwlwifi-bz-z0-gf-a0-"
 
 
-- 
2.33.1

