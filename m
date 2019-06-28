Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A81D59758
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Jun 2019 11:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbfF1JVn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Jun 2019 05:21:43 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:54794 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726506AbfF1JVn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Jun 2019 05:21:43 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1hgn3V-0001ny-Jh; Fri, 28 Jun 2019 12:20:29 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org,
        Luca Coelho <luciano.coelho@intel.com>
Subject: [PATCH 20/20] iwlwifi: mvm: remove MAC_FILTER_IN_11AX for AP mode
Date:   Fri, 28 Jun 2019 12:20:08 +0300
Message-Id: <20190628092008.11049-21-luca@coelho.fi>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190628092008.11049-1-luca@coelho.fi>
References: <20190628092008.11049-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

The FW API was clarified saying that this flag should only be set in
BSS client mode.  Remove it from the MAC_CTXT command we send in AP
and GO modes.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Fixes: 3b5ee8dd8bb1 ("iwlwifi: mvm: set MAC_FILTER_IN_11AX in AP mode")
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
index cea1948ac7a4..cb22d447fcb8 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
@@ -1082,9 +1082,6 @@ static void iwl_mvm_mac_ctxt_cmd_fill_ap(struct iwl_mvm *mvm,
 		IWL_DEBUG_HC(mvm, "No need to receive beacons\n");
 	}
 
-	if (vif->bss_conf.he_support && !iwlwifi_mod_params.disable_11ax)
-		cmd->filter_flags |= cpu_to_le32(MAC_FILTER_IN_11AX);
-
 	ctxt_ap->bi = cpu_to_le32(vif->bss_conf.beacon_int);
 	ctxt_ap->dtim_interval = cpu_to_le32(vif->bss_conf.beacon_int *
 					     vif->bss_conf.dtim_period);
-- 
2.20.1

