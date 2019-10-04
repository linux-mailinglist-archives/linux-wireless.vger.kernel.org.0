Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45C69CBB5F
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Oct 2019 15:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388312AbfJDNOY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Oct 2019 09:14:24 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:46566 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387796AbfJDNOX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Oct 2019 09:14:23 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1iGNPZ-0000l2-Lh; Fri, 04 Oct 2019 16:14:22 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Fri,  4 Oct 2019 16:14:09 +0300
Message-Id: <20191004131414.27372-4-luca@coelho.fi>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191004131414.27372-1-luca@coelho.fi>
References: <20191004131414.27372-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH 3/8] iwlwifi: mvm: force single phy init
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Haim Dreyfuss <haim.dreyfuss@intel.com>

The PHY is initialized during device initialization, but devices with
the tx_siso_diversity flag set need to send PHY_CONFIGURATION_CMD first,
otherwise the PHY would be reinitialized, causing a SYSASSERT.

To fix this, use a bit that tells the FW not to complete the PHY
initialization before a PHY_CONFIGURATION_CMD is received.

Signed-off-by: Haim Dreyfuss <haim.dreyfuss@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index b2eb18eedf02..0d2229319261 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -420,6 +420,9 @@ static int iwl_run_unified_mvm_ucode(struct iwl_mvm *mvm, bool read_nvm)
 	};
 	int ret;
 
+	if (mvm->trans->cfg->tx_with_siso_diversity)
+		init_cfg.init_flags |= cpu_to_le32(BIT(IWL_INIT_PHY));
+
 	lockdep_assert_held(&mvm->mutex);
 
 	mvm->rfkill_safe_init_done = false;
-- 
2.23.0

