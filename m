Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28EACDD7AF
	for <lists+linux-wireless@lfdr.de>; Sat, 19 Oct 2019 11:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbfJSJjN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 19 Oct 2019 05:39:13 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:50410 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725828AbfJSJjM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 19 Oct 2019 05:39:12 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1iLlCZ-0002fy-FL; Sat, 19 Oct 2019 12:39:11 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sat, 19 Oct 2019 12:38:54 +0300
Message-Id: <20191019093902.29823-3-luca@coelho.fi>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191019093902.29823-1-luca@coelho.fi>
References: <20191019093902.29823-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH 04/12] iwlwifi: mvm: in VHT connection use only VHT capabilities
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mordechay Goodstein <mordechay.goodstein@intel.com>

mac80211 limits amsdu size to the minimum of HT and VHT capabilities
but since in a VHT connection we don't transmit HT frames we can discard
HT limits.

Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c | 2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rs.c    | 2 ++
 drivers/net/wireless/intel/iwlwifi/mvm/rs.h    | 2 ++
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
index 098d48153a38..10a08fae2942 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
@@ -384,7 +384,7 @@ void iwl_mvm_tlc_update_notif(struct iwl_mvm *mvm,
 	rcu_read_unlock();
 }
 
-static u16 rs_fw_get_max_amsdu_len(struct ieee80211_sta *sta)
+u16 rs_fw_get_max_amsdu_len(struct ieee80211_sta *sta)
 {
 	const struct ieee80211_sta_vht_cap *vht_cap = &sta->vht_cap;
 	const struct ieee80211_sta_ht_cap *ht_cap = &sta->ht_cap;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rs.c b/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
index 42d525e46e80..0a442cb7f223 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
@@ -1533,6 +1533,8 @@ static void rs_set_amsdu_len(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
 	struct iwl_mvm_sta *mvmsta = iwl_mvm_sta_from_mac80211(sta);
 	int i;
 
+	sta->max_amsdu_len = rs_fw_get_max_amsdu_len(sta);
+
 	/*
 	 * In case TLC offload is not active amsdu_enabled is either 0xFFFF
 	 * or 0, since there is no per-TID alg.
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rs.h b/drivers/net/wireless/intel/iwlwifi/mvm/rs.h
index 7cd62c5622ce..32104c9f8f5e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs.h
@@ -452,4 +452,6 @@ int rs_fw_tx_protection(struct iwl_mvm *mvm, struct iwl_mvm_sta *mvmsta,
 			bool enable);
 void iwl_mvm_tlc_update_notif(struct iwl_mvm *mvm,
 			      struct iwl_rx_cmd_buffer *rxb);
+
+u16 rs_fw_get_max_amsdu_len(struct ieee80211_sta *sta);
 #endif /* __rs__ */
-- 
2.23.0

