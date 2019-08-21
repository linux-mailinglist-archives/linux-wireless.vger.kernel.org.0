Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3562A97B23
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Aug 2019 15:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729029AbfHUNkP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Aug 2019 09:40:15 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:37872 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726484AbfHUNkP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Aug 2019 09:40:15 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1i0QoZ-0000lZ-4M; Wed, 21 Aug 2019 16:38:15 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 21 Aug 2019 16:37:54 +0300
Message-Id: <20190821133800.23636-13-luca@coelho.fi>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190821133800.23636-1-luca@coelho.fi>
References: <20190821133800.23636-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH 12/18] iwlwifi: scan: don't pass large argument by value
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ayala Beker <ayala.beker@intel.com>

Function iwl_mvm_scan_set_legacy_probe_req() second argument
size is too large to be passed by value.
Fix it to be passed by reference.

Signed-off-by: Ayala Beker <ayala.beker@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
index 85e33310804e..afa44345f37b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -961,15 +961,15 @@ static int iwl_mvm_scan_lmac_flags(struct iwl_mvm *mvm,
 
 static void
 iwl_mvm_scan_set_legacy_probe_req(struct iwl_scan_probe_req_v1 *p_req,
-				  struct iwl_scan_probe_req src_p_req)
+				  struct iwl_scan_probe_req *src_p_req)
 {
 	int i;
 
-	p_req->mac_header = src_p_req.mac_header;
+	p_req->mac_header = src_p_req->mac_header;
 	for (i = 0; i < SCAN_NUM_BAND_PROBE_DATA_V_1; i++)
-		p_req->band_data[i] = src_p_req.band_data[i];
-	p_req->common_data = src_p_req.common_data;
-	memcpy(p_req->buf, src_p_req.buf, SCAN_OFFLOAD_PROBE_REQ_SIZE);
+		p_req->band_data[i] = src_p_req->band_data[i];
+	p_req->common_data = src_p_req->common_data;
+	memcpy(p_req->buf, src_p_req->buf, sizeof(p_req->buf));
 }
 
 static int iwl_mvm_scan_lmac(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
@@ -1046,7 +1046,7 @@ static int iwl_mvm_scan_lmac(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	iwl_mvm_lmac_scan_cfg_channels(mvm, params->channels,
 				       params->n_channels, ssid_bitmap, cmd);
 
-	iwl_mvm_scan_set_legacy_probe_req(preq, params->preq);
+	iwl_mvm_scan_set_legacy_probe_req(preq, &params->preq);
 
 	return 0;
 }
@@ -1592,7 +1592,8 @@ static int iwl_mvm_scan_umac(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 		direct_scan = tail_v2->direct_scan;
 	} else {
 		tail_v1 = (struct iwl_scan_req_umac_tail_v1 *)sec_part;
-		iwl_mvm_scan_set_legacy_probe_req(&tail_v1->preq, params->preq);
+		iwl_mvm_scan_set_legacy_probe_req(&tail_v1->preq,
+						  &params->preq);
 		direct_scan = tail_v1->direct_scan;
 	}
 	iwl_scan_build_ssids(params, direct_scan, &ssid_bitmap);
-- 
2.23.0.rc1

