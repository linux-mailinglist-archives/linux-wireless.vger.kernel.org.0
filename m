Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEDF62F930E
	for <lists+linux-wireless@lfdr.de>; Sun, 17 Jan 2021 15:53:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729074AbhAQOx2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 17 Jan 2021 09:53:28 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:40730 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728650AbhAQOxZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 17 Jan 2021 09:53:25 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1l19Px-003sgA-To; Sun, 17 Jan 2021 16:52:38 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sun, 17 Jan 2021 16:52:27 +0200
Message-Id: <iwlwifi.20210117164916.b9af359a675f.I996fc7eb3d94e9539f8b117017c428448c42c7ad@changeid>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210117145234.1435324-1-luca@coelho.fi>
References: <20210117145234.1435324-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 2/9] iwlwifi: mvm: csa: do not abort CSA before disconnect
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Shaul Triebitz <shaul.triebitz@intel.com>

While disconnecting from the AP due to bad channel switch
params (e.g. too long Tx block), do not send the firmware
'CSA abort' before disconnecting. That causes canceling the
immediate quiet and can cause transmitting data before the
disconnection happens.

Signed-off-by: Shaul Triebitz <shaul.triebitz@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 947741302e6a..4e14a97bd168 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -1367,15 +1367,13 @@ static void iwl_mvm_abort_channel_switch(struct ieee80211_hw *hw,
 
 static void iwl_mvm_channel_switch_disconnect_wk(struct work_struct *wk)
 {
-	struct iwl_mvm *mvm;
 	struct iwl_mvm_vif *mvmvif;
 	struct ieee80211_vif *vif;
 
 	mvmvif = container_of(wk, struct iwl_mvm_vif, csa_work.work);
 	vif = container_of((void *)mvmvif, struct ieee80211_vif, drv_priv);
-	mvm = mvmvif->mvm;
 
-	iwl_mvm_abort_channel_switch(mvm->hw, vif);
+	/* Trigger disconnect (should clear the CSA state) */
 	ieee80211_chswitch_done(vif, false);
 }
 
-- 
2.29.2

