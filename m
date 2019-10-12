Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0D5D50FE
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Oct 2019 18:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729426AbfJLQ3d (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 12 Oct 2019 12:29:33 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:48750 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728338AbfJLQ3d (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 12 Oct 2019 12:29:33 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1iJKGp-00062r-DK; Sat, 12 Oct 2019 19:29:31 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sat, 12 Oct 2019 19:29:14 +0300
Message-Id: <20191012192536.9bbc08ae13d9.I4844a20ce5ef57c58703a4011a00eb842c548b40@changeid>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191012162924.19848-1-luca@coelho.fi>
References: <20191012162924.19848-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH 03/13] iwlwifi: mvm: remove leftover rs_remove_sta_debugfs() prototype
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

This prototype is no longer used, remove it.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/rs.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rs.h b/drivers/net/wireless/intel/iwlwifi/mvm/rs.h
index 428642e66658..7cd62c5622ce 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs.h
@@ -445,10 +445,6 @@ int iwl_mvm_tx_protection(struct iwl_mvm *mvm, struct iwl_mvm_sta *mvmsta,
 void iwl_mvm_reset_frame_stats(struct iwl_mvm *mvm);
 #endif
 
-#ifdef CONFIG_MAC80211_DEBUGFS
-void rs_remove_sta_debugfs(void *mvm, void *mvm_sta);
-#endif
-
 void iwl_mvm_rs_add_sta(struct iwl_mvm *mvm, struct iwl_mvm_sta *mvmsta);
 void rs_fw_rate_init(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
 		     enum nl80211_band band, bool update);
-- 
2.23.0

