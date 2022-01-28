Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9D5049F968
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Jan 2022 13:31:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348478AbiA1MbY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Jan 2022 07:31:24 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:37830 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1348447AbiA1MbX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Jan 2022 07:31:23 -0500
Received: from 91-155-254-253.elisa-laajakaista.fi ([91.155.254.253] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <luca@coelho.fi>)
        id 1nDQPR-0002A0-RN;
        Fri, 28 Jan 2022 14:31:22 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@kernel.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Fri, 28 Jan 2022 14:30:56 +0200
Message-Id: <iwlwifi.20220128142706.f293861a3f92.I9553d27df1de6fd5756a43ea5f8b89d06fa1a6f2@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220128123057.524038-1-luca@coelho.fi>
References: <20220128123057.524038-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH for v5.17 7/8] iwlwifi: mvm: don't feed the hardware RFKILL into iwlmei
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

iwlmei can trigger a hardware RFKILL when the CSME firmware
does not want the host to touch the device.
But then, iwlmvm reports RFKILL which makes cfg80211 update
iwlmvm about RFKILL. iwlmvm then thinks there is a change in
the _software_ rfkill and it calls rfkill_blocked() to fetch
the RFKILL state. This returns that RFKILL is blocked (because
of iwlmei) and iwlmvm tells iwlmei that _software_ RFKILL is
asserted.

This is a bug of course.
Fix this by checking explicitly the software RFKILL state and
not the overall RFKILL state.

Fixes: 7ce1f2157e14 ("iwlwifi: mvm: read the rfkill state and feed it to iwlmei")
Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Fixes: 7ce1f2157e14 ("iwlwifi: mvm: read the rfkill state and feed it to iwlmei")
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 1dcbb0eb63c3..b1fe8434ab0d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -2225,7 +2225,7 @@ static inline void iwl_mvm_mei_device_down(struct iwl_mvm *mvm)
 static inline void iwl_mvm_mei_set_sw_rfkill_state(struct iwl_mvm *mvm)
 {
 	bool sw_rfkill =
-		mvm->hw_registered ? rfkill_blocked(mvm->hw->wiphy->rfkill) : false;
+		mvm->hw_registered ? rfkill_soft_blocked(mvm->hw->wiphy->rfkill) : false;
 
 	if (mvm->mei_registered)
 		iwl_mei_set_rfkill_state(iwl_mvm_is_radio_killed(mvm),
-- 
2.34.1

