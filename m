Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD92309BB4
	for <lists+linux-wireless@lfdr.de>; Sun, 31 Jan 2021 12:48:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbhAaLlW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 31 Jan 2021 06:41:22 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:42904 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231483AbhAaLiL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 31 Jan 2021 06:38:11 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1l6AY4-004131-53; Sun, 31 Jan 2021 13:05:44 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sun, 31 Jan 2021 13:05:32 +0200
Message-Id: <iwlwifi.20210131125922.20a74526d395.Id24304ec1ae4b3096dbb8112bd146b364920e89e@changeid>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210131110533.887130-1-luca@coelho.fi>
References: <20210131110533.887130-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 11/12] iwlwifi: mvm: make iwl_mvm_tt_temp_changed() static
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

This is only needed within tt.c, make it static.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h | 1 -
 drivers/net/wireless/intel/iwlwifi/mvm/tt.c  | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 4925792257d1..308ba2e961e7 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1906,7 +1906,6 @@ int iwl_mvm_reconfig_scd(struct iwl_mvm *mvm, int queue, int fifo, int sta_id,
 
 /* Thermal management and CT-kill */
 void iwl_mvm_tt_tx_backoff(struct iwl_mvm *mvm, u32 backoff);
-void iwl_mvm_tt_temp_changed(struct iwl_mvm *mvm, u32 temp);
 void iwl_mvm_temp_notif(struct iwl_mvm *mvm,
 			struct iwl_rx_cmd_buffer *rxb);
 void iwl_mvm_tt_handler(struct iwl_mvm *mvm);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tt.c b/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
index 9dfe0381cbeb..790bc68a515a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
@@ -44,7 +44,7 @@ static void iwl_mvm_exit_ctkill(struct iwl_mvm *mvm)
 	iwl_mvm_set_hw_ctkill_state(mvm, false);
 }
 
-void iwl_mvm_tt_temp_changed(struct iwl_mvm *mvm, u32 temp)
+static void iwl_mvm_tt_temp_changed(struct iwl_mvm *mvm, u32 temp)
 {
 	/* ignore the notification if we are in test mode */
 	if (mvm->temperature_test)
-- 
2.29.2

