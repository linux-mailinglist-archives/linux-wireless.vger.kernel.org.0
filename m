Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA88759754
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Jun 2019 11:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbfF1JUw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Jun 2019 05:20:52 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:54782 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726506AbfF1JUw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Jun 2019 05:20:52 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1hgn3T-0001ny-GV; Fri, 28 Jun 2019 12:20:27 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>
Subject: [PATCH 16/20] iwlwifi: mvm: make the usage of TWT configurable
Date:   Fri, 28 Jun 2019 12:20:04 +0300
Message-Id: <20190628092008.11049-17-luca@coelho.fi>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190628092008.11049-1-luca@coelho.fi>
References: <20190628092008.11049-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

TWT is still very new and we expect issues. Make its usage
configurable and disable it by default.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/constants.h | 1 +
 drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c  | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/constants.h b/drivers/net/wireless/intel/iwlwifi/mvm/constants.h
index dff14f1ec55f..915b172da57a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/constants.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/constants.h
@@ -152,5 +152,6 @@
 #define IWL_MVM_FTM_INITIATOR_ALGO		IWL_TOF_ALGO_TYPE_MAX_LIKE
 #define IWL_MVM_FTM_INITIATOR_DYNACK		true
 #define IWL_MVM_D3_DEBUG			false
+#define IWL_MVM_USE_TWT				false
 
 #endif /* __MVM_CONSTANTS_H */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
index 699a887612b9..cea1948ac7a4 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
@@ -679,7 +679,7 @@ static int iwl_mvm_mac_ctxt_cmd_sta(struct iwl_mvm *mvm,
 
 	if (vif->bss_conf.he_support && !iwlwifi_mod_params.disable_11ax) {
 		cmd.filter_flags |= cpu_to_le32(MAC_FILTER_IN_11AX);
-		if (vif->bss_conf.twt_requester)
+		if (vif->bss_conf.twt_requester && IWL_MVM_USE_TWT)
 			ctxt_sta->data_policy |= cpu_to_le32(TWT_SUPPORTED);
 	}
 
-- 
2.20.1

