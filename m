Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1515E3DDAFD
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Aug 2021 16:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234062AbhHBO2q (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Aug 2021 10:28:46 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:50918 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S234057AbhHBO2p (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Aug 2021 10:28:45 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1mAYvg-001xts-U2; Mon, 02 Aug 2021 17:28:34 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Mon,  2 Aug 2021 17:28:20 +0300
Message-Id: <iwlwifi.20210802172232.0cdcac5660da.I9ee7956fd4f48399855d1f97728bc58b36caf112@changeid>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210802142829.109448-1-luca@coelho.fi>
References: <20210802142829.109448-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH 03/12] iwlwifi: mvm: restrict FW SMPS request
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

The firmware SMPS request should only be honoured if the
connection is currently with HE and on 160 MHz, so check
that and then potentially reapply any request if the BW
changes.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c |  3 +++
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c      | 11 +++++++----
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 3a7f756c4545..b2072e19b5dc 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -2440,6 +2440,9 @@ static void iwl_mvm_bss_info_changed_station(struct iwl_mvm *mvm,
 		IWL_DEBUG_MAC80211(mvm, "arp filter changed\n");
 		iwl_mvm_configure_bcast_filter(mvm);
 	}
+
+	if (changes & BSS_CHANGED_BANDWIDTH)
+		iwl_mvm_apply_fw_smps_request(vif);
 }
 
 static int iwl_mvm_start_ap_ibss(struct ieee80211_hw *hw,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 880cf2042531..564ccfbd15bd 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -214,11 +214,14 @@ void iwl_mvm_apply_fw_smps_request(struct ieee80211_vif *vif)
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	struct iwl_mvm *mvm = mvmvif->mvm;
+	enum ieee80211_smps_mode mode = IEEE80211_SMPS_AUTOMATIC;
 
-	iwl_mvm_update_smps(mvm, vif, IWL_MVM_SMPS_REQ_FW,
-			    mvm->fw_static_smps_request ?
-				IEEE80211_SMPS_STATIC :
-				IEEE80211_SMPS_AUTOMATIC);
+	if (mvm->fw_static_smps_request &&
+	    vif->bss_conf.chandef.width == NL80211_CHAN_WIDTH_160 &&
+	    vif->bss_conf.he_support)
+		mode = IEEE80211_SMPS_STATIC;
+
+	iwl_mvm_update_smps(mvm, vif, IWL_MVM_SMPS_REQ_FW, mode);
 }
 
 static void iwl_mvm_intf_dual_chain_req(void *data, u8 *mac,
-- 
2.32.0

