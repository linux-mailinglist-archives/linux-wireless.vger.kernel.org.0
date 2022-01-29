Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB2D4A2E1B
	for <lists+linux-wireless@lfdr.de>; Sat, 29 Jan 2022 12:16:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237454AbiA2LQd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 29 Jan 2022 06:16:33 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:37878 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S237223AbiA2LQb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 29 Jan 2022 06:16:31 -0500
Received: from 91-156-4-210.elisa-laajakaista.fi ([91.156.4.210] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <luca@coelho.fi>)
        id 1nDliX-0002ji-A1;
        Sat, 29 Jan 2022 13:16:30 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@kernel.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sat, 29 Jan 2022 13:16:15 +0200
Message-Id: <iwlwifi.20220129105618.9416aade2ba0.I0b71142f89e3f158aa058a1dfb2517c8c1fa3726@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220129111622.678447-1-luca@coelho.fi>
References: <20220129111622.678447-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 05/12] iwlwifi: mvm: don't iterate unadded vifs when handling FW SMPS req
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

We may not have all the interfaces added to the driver when we get the
THERMAL_DUAL_CHAIN_REQUEST notification from the FW, so instead of
iterating all vifs to update SMPS, iterate only the ones that are
already assigned.  The interfaces that were not assigned yet, will be
updated accordingly when we start using them.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Fixes: 2a7ce54ccc23 ("iwlwifi: mvm: honour firmware SMPS requests")
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index ba19ed30f85a..86dd2dc1a8ab 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -235,7 +235,8 @@ static void iwl_mvm_rx_thermal_dual_chain_req(struct iwl_mvm *mvm,
 	 */
 	mvm->fw_static_smps_request =
 		req->event == cpu_to_le32(THERMAL_DUAL_CHAIN_REQ_DISABLE);
-	ieee80211_iterate_interfaces(mvm->hw, IEEE80211_IFACE_ITER_NORMAL,
+	ieee80211_iterate_interfaces(mvm->hw,
+				     IEEE80211_IFACE_SKIP_SDATA_NOT_IN_DRIVER,
 				     iwl_mvm_intf_dual_chain_req, NULL);
 }
 
-- 
2.34.1

