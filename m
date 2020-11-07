Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 100472AA3FC
	for <lists+linux-wireless@lfdr.de>; Sat,  7 Nov 2020 09:50:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728346AbgKGIuV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 7 Nov 2020 03:50:21 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:58812 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728337AbgKGIuU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 7 Nov 2020 03:50:20 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kbJvO-002on9-2i; Sat, 07 Nov 2020 10:50:18 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sat,  7 Nov 2020 10:50:11 +0200
Message-Id: <iwlwifi.20201107104557.d64de2c17bff.Iedd0d2afa20a2aacba5259a5cae31cb3a119a4eb@changeid>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201107085011.57943-1-luca@coelho.fi>
References: <20201107085011.57943-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 6/6] iwlwifi: mvm: fix kernel panic in case of assert during CSA
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sara Sharon <sara.sharon@intel.com>

During CSA, we briefly nullify the phy context, in __iwl_mvm_unassign_vif_chanctx.
In case we have a FW assert right after it, it remains NULL though.
We end up running into endless loop due to mac80211 trying repeatedly to
move us to ASSOC state, and we keep returning -EINVAL. Later down the road
we hit a kernel panic.

Detect and avoid this endless loop.

Signed-off-by: Sara Sharon <sara.sharon@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 62e884f3e29e..b627e7da7ac9 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -3080,7 +3080,7 @@ static int iwl_mvm_mac_sta_state(struct ieee80211_hw *hw,
 
 	/* this would be a mac80211 bug ... but don't crash */
 	if (WARN_ON_ONCE(!mvmvif->phy_ctxt))
-		return -EINVAL;
+		return test_bit(IWL_MVM_STATUS_HW_RESTART_REQUESTED, &mvm->status) ? 0 : -EINVAL;
 
 	/*
 	 * If we are in a STA removal flow and in DQA mode:
-- 
2.28.0

