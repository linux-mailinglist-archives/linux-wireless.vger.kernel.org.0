Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44B0B59748
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Jun 2019 11:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbfF1JUY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Jun 2019 05:20:24 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:54702 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726697AbfF1JUX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Jun 2019 05:20:23 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1hgn3N-0001ny-TW; Fri, 28 Jun 2019 12:20:22 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org,
        Shaul Triebitz <shaul.triebitz@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>
Subject: [PATCH 05/20] iwlwifi: mvm: convert to FW AC when configuring MU EDCA
Date:   Fri, 28 Jun 2019 12:19:53 +0300
Message-Id: <20190628092008.11049-6-luca@coelho.fi>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190628092008.11049-1-luca@coelho.fi>
References: <20190628092008.11049-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Shaul Triebitz <shaul.triebitz@intel.com>

The AC numbers used by mac80211 differ from those used
by the firmware.  When setting MU EDCA params for each
AC, use the correct FW AC numbers.

Signed-off-by: Shaul Triebitz <shaul.triebitz@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 5f7ed51c96ab..27d4d92e237c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -2365,22 +2365,23 @@ static void iwl_mvm_cfg_he_sta(struct iwl_mvm *mvm,
 
 	/* Mark MU EDCA as enabled, unless none detected on some AC */
 	flags |= STA_CTXT_HE_MU_EDCA_CW;
-	for (i = 0; i < AC_NUM; i++) {
+	for (i = 0; i < IEEE80211_NUM_ACS; i++) {
 		struct ieee80211_he_mu_edca_param_ac_rec *mu_edca =
 			&mvmvif->queue_params[i].mu_edca_param_rec;
+		u8 ac = iwl_mvm_mac80211_ac_to_ucode_ac(i);
 
 		if (!mvmvif->queue_params[i].mu_edca) {
 			flags &= ~STA_CTXT_HE_MU_EDCA_CW;
 			break;
 		}
 
-		sta_ctxt_cmd.trig_based_txf[i].cwmin =
+		sta_ctxt_cmd.trig_based_txf[ac].cwmin =
 			cpu_to_le16(mu_edca->ecw_min_max & 0xf);
-		sta_ctxt_cmd.trig_based_txf[i].cwmax =
+		sta_ctxt_cmd.trig_based_txf[ac].cwmax =
 			cpu_to_le16((mu_edca->ecw_min_max & 0xf0) >> 4);
-		sta_ctxt_cmd.trig_based_txf[i].aifsn =
+		sta_ctxt_cmd.trig_based_txf[ac].aifsn =
 			cpu_to_le16(mu_edca->aifsn);
-		sta_ctxt_cmd.trig_based_txf[i].mu_time =
+		sta_ctxt_cmd.trig_based_txf[ac].mu_time =
 			cpu_to_le16(mu_edca->mu_edca_timer);
 	}
 
-- 
2.20.1

