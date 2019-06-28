Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA62259747
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Jun 2019 11:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbfF1JUX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Jun 2019 05:20:23 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:54696 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726385AbfF1JUX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Jun 2019 05:20:23 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1hgn3N-0001ny-DH; Fri, 28 Jun 2019 12:20:21 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org,
        Naftali Goldstein <naftali.goldstein@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>
Subject: [PATCH 04/20] iwlwifi: mvm: correctly fill the ac array in the iwl_mac_ctx_cmd
Date:   Fri, 28 Jun 2019 12:19:52 +0300
Message-Id: <20190628092008.11049-5-luca@coelho.fi>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190628092008.11049-1-luca@coelho.fi>
References: <20190628092008.11049-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Naftali Goldstein <naftali.goldstein@intel.com>

The indexes into the ac array in the iwl_mac_ctx_cmd are from the iwl_ac
enum and not the txfs.  The current code therefore puts the edca params
in the wrong indexes of the array, causing wrong priority for
data-streams of different ACs.
Fix this.

Note that this bug only occurs in NICs that use the new tx api, since in
the old tx api the txf number is equal to the corresponding ac in the
iwl_ac enum.

Signed-off-by: Naftali Goldstein <naftali.goldstein@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c | 11 ++++++-----
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h      |  1 +
 drivers/net/wireless/intel/iwlwifi/mvm/utils.c    | 12 ++++++++++++
 3 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
index 53c217af13c8..699a887612b9 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
@@ -558,15 +558,16 @@ static void iwl_mvm_mac_ctxt_cmd_common(struct iwl_mvm *mvm,
 
 	for (i = 0; i < IEEE80211_NUM_ACS; i++) {
 		u8 txf = iwl_mvm_mac_ac_to_tx_fifo(mvm, i);
+		u8 ucode_ac = iwl_mvm_mac80211_ac_to_ucode_ac(i);
 
-		cmd->ac[txf].cw_min =
+		cmd->ac[ucode_ac].cw_min =
 			cpu_to_le16(mvmvif->queue_params[i].cw_min);
-		cmd->ac[txf].cw_max =
+		cmd->ac[ucode_ac].cw_max =
 			cpu_to_le16(mvmvif->queue_params[i].cw_max);
-		cmd->ac[txf].edca_txop =
+		cmd->ac[ucode_ac].edca_txop =
 			cpu_to_le16(mvmvif->queue_params[i].txop * 32);
-		cmd->ac[txf].aifsn = mvmvif->queue_params[i].aifs;
-		cmd->ac[txf].fifos_mask = BIT(txf);
+		cmd->ac[ucode_ac].aifsn = mvmvif->queue_params[i].aifs;
+		cmd->ac[ucode_ac].fifos_mask = BIT(txf);
 	}
 
 	if (vif->bss_conf.qos)
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index e3614f59d274..01a9762e109b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1539,6 +1539,7 @@ void iwl_mvm_hwrate_to_tx_rate(u32 rate_n_flags,
 			       enum nl80211_band band,
 			       struct ieee80211_tx_rate *r);
 u8 iwl_mvm_mac80211_idx_to_hwrate(int rate_idx);
+u8 iwl_mvm_mac80211_ac_to_ucode_ac(enum ieee80211_ac_numbers ac);
 void iwl_mvm_dump_nic_error_log(struct iwl_mvm *mvm);
 u8 first_antenna(u8 mask);
 u8 iwl_mvm_next_antenna(struct iwl_mvm *mvm, u8 valid, u8 last_idx);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
index b9914efc55c4..d2f06a95d75f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
@@ -238,6 +238,18 @@ u8 iwl_mvm_mac80211_idx_to_hwrate(int rate_idx)
 	return fw_rate_idx_to_plcp[rate_idx];
 }
 
+u8 iwl_mvm_mac80211_ac_to_ucode_ac(enum ieee80211_ac_numbers ac)
+{
+	static const u8 mac80211_ac_to_ucode_ac[] = {
+		AC_VO,
+		AC_VI,
+		AC_BE,
+		AC_BK
+	};
+
+	return mac80211_ac_to_ucode_ac[ac];
+}
+
 void iwl_mvm_rx_fw_error(struct iwl_mvm *mvm, struct iwl_rx_cmd_buffer *rxb)
 {
 	struct iwl_rx_packet *pkt = rxb_addr(rxb);
-- 
2.20.1

