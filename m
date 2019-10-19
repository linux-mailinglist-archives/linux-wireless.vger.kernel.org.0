Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D292ADD7B7
	for <lists+linux-wireless@lfdr.de>; Sat, 19 Oct 2019 11:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbfJSJj0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 19 Oct 2019 05:39:26 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:50476 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726545AbfJSJjZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 19 Oct 2019 05:39:25 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1iLlCe-0002fy-GI; Sat, 19 Oct 2019 12:39:16 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sat, 19 Oct 2019 12:39:00 +0300
Message-Id: <20191019123747.12883d40bc58.I40b4078a8a0fcc48ab6d355431e99f0ed2550652@changeid>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191019093902.29823-1-luca@coelho.fi>
References: <20191019093902.29823-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH 10/12] iwlwifi: mvm: print rate_n_flags in a pretty format
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mordechay Goodstein <mordechay.goodstein@intel.com>

Use the rs_pretty_print_rate() function to print the rate_n_flags in
more human-readable format.

Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c | 6 ++++--
 drivers/net/wireless/intel/iwlwifi/mvm/rs.c    | 6 +++---
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
index 10a08fae2942..e2cf9e015ef8 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
@@ -341,9 +341,11 @@ void iwl_mvm_tlc_update_notif(struct iwl_mvm *mvm,
 	lq_sta = &mvmsta->lq_sta.rs_fw;
 
 	if (flags & IWL_TLC_NOTIF_FLAG_RATE) {
+		char pretty_rate[100];
 		lq_sta->last_rate_n_flags = le32_to_cpu(notif->rate);
-		IWL_DEBUG_RATE(mvm, "new rate_n_flags: 0x%X\n",
-			       lq_sta->last_rate_n_flags);
+		rs_pretty_print_rate(pretty_rate, sizeof(pretty_rate),
+				     lq_sta->last_rate_n_flags);
+		IWL_DEBUG_RATE(mvm, "new rate: %s\n", pretty_rate);
 	}
 
 	if (flags & IWL_TLC_NOTIF_FLAG_AMSDU && !mvmsta->orig_amsdu_len) {
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rs.c b/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
index 0a442cb7f223..1a990ed9c3ca 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
@@ -3685,7 +3685,6 @@ static void rs_free_sta(void *mvm_r, struct ieee80211_sta *sta, void *mvm_sta)
 	IWL_DEBUG_RATE(mvm, "leave\n");
 }
 
-#ifdef CONFIG_MAC80211_DEBUGFS
 int rs_pretty_print_rate(char *buf, int bufsz, const u32 rate)
 {
 
@@ -3741,14 +3740,15 @@ int rs_pretty_print_rate(char *buf, int bufsz, const u32 rate)
 	}
 
 	return scnprintf(buf, bufsz,
-			 "%s | ANT: %s BW: %s MCS: %d NSS: %d %s%s%s%s\n",
-			 type, rs_pretty_ant(ant), bw, mcs, nss,
+			 "0x%x: %s | ANT: %s BW: %s MCS: %d NSS: %d %s%s%s%s\n",
+			 rate, type, rs_pretty_ant(ant), bw, mcs, nss,
 			 (rate & RATE_MCS_SGI_MSK) ? "SGI " : "NGI ",
 			 (rate & RATE_MCS_STBC_MSK) ? "STBC " : "",
 			 (rate & RATE_MCS_LDPC_MSK) ? "LDPC " : "",
 			 (rate & RATE_MCS_BF_MSK) ? "BF " : "");
 }
 
+#ifdef CONFIG_MAC80211_DEBUGFS
 /**
  * Program the device to use fixed rate for frame transmit
  * This is for debugging/testing only
-- 
2.23.0

