Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDA9F3F8F26
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Aug 2021 21:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243538AbhHZTsr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Aug 2021 15:48:47 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:33436 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S233898AbhHZTsq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Aug 2021 15:48:46 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1mJLLv-002XB4-Lf; Thu, 26 Aug 2021 22:47:58 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Thu, 26 Aug 2021 22:47:41 +0300
Message-Id: <iwlwifi.20210826224715.556934ed023a.I843677252be64f4732e434ab9ef72f487625e49e@changeid>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210826194748.826360-1-luca@coelho.fi>
References: <20210826194748.826360-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH v2 05/12] iwlwifi: mvm: support broadcast TWT alone
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Shaul Triebitz <shaul.triebitz@intel.com>

Tell the firmware about broadcast TWT support
even if individual TWT is not supported.
In that case the firmware will negotiate only
a broadcast TWT session.

Signed-off-by: Shaul Triebitz <shaul.triebitz@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
index 1ebd4654d18e..fd352b2624a6 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
@@ -647,15 +647,14 @@ static int iwl_mvm_mac_ctxt_cmd_sta(struct iwl_mvm *mvm,
 
 	if (vif->bss_conf.he_support && !iwlwifi_mod_params.disable_11ax) {
 		cmd.filter_flags |= cpu_to_le32(MAC_FILTER_IN_11AX);
-		if (vif->bss_conf.twt_requester && IWL_MVM_USE_TWT) {
+		if (vif->bss_conf.twt_requester && IWL_MVM_USE_TWT)
 			ctxt_sta->data_policy |= cpu_to_le32(TWT_SUPPORTED);
-			if (vif->bss_conf.twt_protected)
-				ctxt_sta->data_policy |=
-					cpu_to_le32(PROTECTED_TWT_SUPPORTED);
-			if (vif->bss_conf.twt_broadcast)
-				ctxt_sta->data_policy |=
-					cpu_to_le32(BROADCAST_TWT_SUPPORTED);
-		}
+		if (vif->bss_conf.twt_protected)
+			ctxt_sta->data_policy |=
+				cpu_to_le32(PROTECTED_TWT_SUPPORTED);
+		if (vif->bss_conf.twt_broadcast)
+			ctxt_sta->data_policy |=
+				cpu_to_le32(BROADCAST_TWT_SUPPORTED);
 	}
 
 
-- 
2.33.0

