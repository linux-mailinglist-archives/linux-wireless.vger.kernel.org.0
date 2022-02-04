Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 088334A97AE
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Feb 2022 11:25:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356035AbiBDKZU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Feb 2022 05:25:20 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:37958 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S241228AbiBDKZT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Feb 2022 05:25:19 -0500
Received: from 91-156-4-210.elisa-laajakaista.fi ([91.156.4.210] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <luca@coelho.fi>)
        id 1nFvmH-0005zM-7X;
        Fri, 04 Feb 2022 12:25:18 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@kernel.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Fri,  4 Feb 2022 12:25:02 +0200
Message-Id: <iwlwifi.20220204122220.caef72dc255c.I186b787c7f190ca00c2800e1035f2503360f58a8@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220204102511.606112-1-luca@coelho.fi>
References: <20220204102511.606112-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 03/12] iwlwifi: scan: Modify return value of a function
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ilan Peer <ilan.peer@intel.com>

The function iwl_mvm_umac_scan_fill_6g_chan_list() always returns 0.
Change its return value to 'void'.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
index 4b78a00243c7..8c7cb491330d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -1656,7 +1656,7 @@ iwl_mvm_umac_scan_cfg_channels_v6(struct iwl_mvm *mvm,
 	}
 }
 
-static int
+static void
 iwl_mvm_umac_scan_fill_6g_chan_list(struct iwl_mvm *mvm,
 				    struct iwl_mvm_scan_params *params,
 				     struct iwl_scan_probe_params_v4 *pp)
@@ -1725,7 +1725,6 @@ iwl_mvm_umac_scan_fill_6g_chan_list(struct iwl_mvm *mvm,
 
 	pp->short_ssid_num = idex_s;
 	pp->bssid_num = idex_b;
-	return 0;
 }
 
 /* TODO: this function can be merged with iwl_mvm_scan_umac_fill_ch_p_v6 */
@@ -2414,9 +2413,7 @@ static int iwl_mvm_scan_umac_v14_and_above(struct iwl_mvm *mvm,
 	cp->n_aps_override[0] = IWL_SCAN_ADWELL_N_APS_GO_FRIENDLY;
 	cp->n_aps_override[1] = IWL_SCAN_ADWELL_N_APS_SOCIAL_CHS;
 
-	ret = iwl_mvm_umac_scan_fill_6g_chan_list(mvm, params, pb);
-	if (ret)
-		return ret;
+	iwl_mvm_umac_scan_fill_6g_chan_list(mvm, params, pb);
 
 	iwl_mvm_umac_scan_cfg_channels_v6_6g(params,
 					     params->n_channels,
-- 
2.34.1

