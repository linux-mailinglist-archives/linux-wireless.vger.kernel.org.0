Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4958A5DF53
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2019 10:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbfGCILC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 3 Jul 2019 04:11:02 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:54844 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727052AbfGCILC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 3 Jul 2019 04:11:02 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1hiaLv-0004w3-Ei; Wed, 03 Jul 2019 11:10:55 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     davem@davemloft.net
Cc:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org,
        emmanuel.grumbach@intel.com, johannes.hirte@datenkhaos.de,
        steven@uplinklabs.net, Johannes Berg <johannes.berg@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>
Subject: [PATCH for v5.2] iwlwifi: mvm: disable TX-AMSDU on older NICs
Date:   Wed,  3 Jul 2019 11:10:49 +0300
Message-Id: <20190703081049.28831-1-luca@coelho.fi>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

On older NICs, we occasionally see issues with A-MSDU support,
where the commands in the FIFO get confused and then we see an
assert EDC because the next command in the FIFO isn't TX.

We've tried to isolate this issue and understand where it comes
from, but haven't found any errors in building the A-MSDU in
software.

At least for now, disable A-MSDU support on older hardware so
that users can use it again without fearing the assert.

This fixes https://bugzilla.kernel.org/show_bug.cgi?id=203315.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index fdbabca0280e..3a076e5e319f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -468,7 +468,19 @@ int iwl_mvm_mac_setup_register(struct iwl_mvm *mvm)
 	ieee80211_hw_set(hw, SUPPORTS_VHT_EXT_NSS_BW);
 	ieee80211_hw_set(hw, BUFF_MMPDU_TXQ);
 	ieee80211_hw_set(hw, STA_MMPDU_TXQ);
-	ieee80211_hw_set(hw, TX_AMSDU);
+	/*
+	 * On older devices, enabling TX A-MSDU occasionally leads to
+	 * something getting messed up, the command read from the FIFO
+	 * gets out of sync and isn't a TX command, so that we have an
+	 * assert EDC.
+	 *
+	 * It's not clear where the bug is, but since we didn't used to
+	 * support A-MSDU until moving the mac80211 iTXQs, just leave it
+	 * for older devices. We also don't see this issue on any newer
+	 * devices.
+	 */
+	if (mvm->cfg->device_family >= IWL_DEVICE_FAMILY_9000)
+		ieee80211_hw_set(hw, TX_AMSDU);
 	ieee80211_hw_set(hw, TX_FRAG_LIST);
 
 	if (iwl_mvm_has_tlc_offload(mvm)) {
-- 
2.20.1

