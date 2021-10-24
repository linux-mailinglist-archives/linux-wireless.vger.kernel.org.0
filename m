Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1095B438957
	for <lists+linux-wireless@lfdr.de>; Sun, 24 Oct 2021 15:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231710AbhJXN5j (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 24 Oct 2021 09:57:39 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:58536 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231702AbhJXN5i (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 24 Oct 2021 09:57:38 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1medy0-000cvJ-0W; Sun, 24 Oct 2021 16:55:16 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sun, 24 Oct 2021 16:55:01 +0300
Message-Id: <iwlwifi.20211024165252.f115ad455aca.I5de854fe8ce58c85c21a7adf43526acb29156a08@changeid>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211024135506.285102-1-luca@coelho.fi>
References: <20211024135506.285102-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 06/11] iwlwifi: mvm: Use all Rx chains for roaming scan
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ilan Peer <ilan.peer@intel.com>

To improve chances of hearing beacons and probe responses during
a scan which (based on the scan request parameters) looks like a
roaming scan, enable reception on all chains.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
index ce8bdbc70b7e..a138b5c4cce8 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -1995,8 +1995,16 @@ static u16 iwl_mvm_scan_umac_flags_v2(struct iwl_mvm *mvm,
 {
 	u16 flags = 0;
 
+	/*
+	 * If no direct SSIDs are provided perform a passive scan. Otherwise,
+	 * if there is a single SSID which is not the broadcast SSID, assume
+	 * that the scan is intended for roaming purposes and thus enable Rx on
+	 * all chains to improve chances of hearing the beacons/probe responses.
+	 */
 	if (params->n_ssids == 0)
 		flags |= IWL_UMAC_SCAN_GEN_FLAGS_V2_FORCE_PASSIVE;
+	else if (params->n_ssids == 1 && params->ssids[0].ssid_len)
+		flags |= IWL_UMAC_SCAN_GEN_FLAGS_V2_USE_ALL_RX_CHAINS;
 
 	if (iwl_mvm_is_scan_fragmented(params->type))
 		flags |= IWL_UMAC_SCAN_GEN_FLAGS_V2_FRAGMENTED_LMAC1;
-- 
2.33.0

