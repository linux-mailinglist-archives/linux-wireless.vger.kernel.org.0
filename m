Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2273AC5A6
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Jun 2021 10:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232702AbhFRIFG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Jun 2021 04:05:06 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:48060 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232782AbhFRIDq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Jun 2021 04:03:46 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1lu9RM-001YIf-Dn; Fri, 18 Jun 2021 11:01:25 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Fri, 18 Jun 2021 11:01:13 +0300
Message-Id: <iwlwifi.20210618105614.64df994c8fbb.I0fa5cda3a5f893a396eef30a01522422be359e69@changeid>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618080121.588233-1-luca@coelho.fi>
References: <20210618080121.588233-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH 02/10] iwlwifi: mvm: don't request mac80211 to disable/enable sta's queues
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Naftali Goldstein <naftali.goldstein@intel.com>

When operating in AP mode with NICs supporting the AP_LINK_PS hw flag,
mac80211 doesn't need to start/stop queueing tx for connected stations
because the FW already handles that.

Signed-off-by: Naftali Goldstein <naftali.goldstein@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index f618368eda83..9c45a64c5009 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -3794,8 +3794,12 @@ void iwl_mvm_sta_modify_disable_tx_ap(struct iwl_mvm *mvm,
 
 	mvm_sta->disable_tx = disable;
 
-	/* Tell mac80211 to start/stop queuing tx for this station */
-	ieee80211_sta_block_awake(mvm->hw, sta, disable);
+	/*
+	 * If sta PS state is handled by mac80211, tell it to start/stop
+	 * queuing tx for this station.
+	 */
+	if (!ieee80211_hw_check(mvm->hw, AP_LINK_PS))
+		ieee80211_sta_block_awake(mvm->hw, sta, disable);
 
 	iwl_mvm_sta_modify_disable_tx(mvm, mvm_sta, disable);
 
-- 
2.32.0

