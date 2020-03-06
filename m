Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7978D17BE11
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Mar 2020 14:17:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727412AbgCFNQu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 6 Mar 2020 08:16:50 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:60950 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727420AbgCFNQt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 6 Mar 2020 08:16:49 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <luca@coelho.fi>)
        id 1jACqN-0005yR-Gg; Fri, 06 Mar 2020 15:16:47 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Fri,  6 Mar 2020 15:16:27 +0200
Message-Id: <iwlwifi.20200306151129.1cd986ef467c.Idc0b111475ae3d38b68ae062613c080b574e33e1@changeid>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200306131627.503176-1-luca@coelho.fi>
References: <20200306131627.503176-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.2
Subject: [PATCH v5.6 7/7] iwlwifi: cfg: use antenna diversity with all AX101 devices
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

We were erroneously only setting the tx_with_siso_diversity flag in
the Qu B-step configurations for AX101 devices, though we should do
it on all configurations.  Add the flag to the other two
configurations, namely Qu C-step and QuZ.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/22000.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
index a22a830019c0..355af47c5f73 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
@@ -283,6 +283,7 @@ const struct iwl_cfg iwl_ax101_cfg_qu_c0_hr_b0 = {
 	 * HT size; mac80211 would otherwise pick the HE max (256) by default.
 	 */
 	.max_tx_agg_size = IEEE80211_MAX_AMPDU_BUF_HT,
+	.tx_with_siso_diversity = true,
 	.num_rbds = IWL_NUM_RBDS_22000_HE,
 };
 
@@ -309,6 +310,7 @@ const struct iwl_cfg iwl_ax101_cfg_quz_hr = {
 	 * HT size; mac80211 would otherwise pick the HE max (256) by default.
 	 */
 	.max_tx_agg_size = IEEE80211_MAX_AMPDU_BUF_HT,
+	.tx_with_siso_diversity = true,
 	.num_rbds = IWL_NUM_RBDS_22000_HE,
 };
 
-- 
2.25.1

