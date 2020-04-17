Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BE601ADADD
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2020 12:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729025AbgDQKVy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Apr 2020 06:21:54 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:56574 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728346AbgDQKVx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Apr 2020 06:21:53 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1jPO87-000Kba-AZ; Fri, 17 Apr 2020 13:21:51 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 17 Apr 2020 13:21:35 +0300
Message-Id: <iwlwifi.20200417131727.a64a018f244e.Ie75ac5bb0f0f524d26944800138855ef2228339a@changeid>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200417102142.2173014-1-luca@coelho.fi>
References: <20200417102142.2173014-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 03/10] iwlwifi: nvm: use iwl_nl80211_band_from_channel_idx
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Tova Mussai <tova.mussai@intel.com>

Use iwl_nl80211_band_from_channel_idx in iwl_parse_nvm_mcc_info

Signed-off-by: Tova Mussai <tova.mussai@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
index 9e9810d2b262..6047b98691eb 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
@@ -1168,8 +1168,7 @@ iwl_parse_nvm_mcc_info(struct device *dev, const struct iwl_cfg *cfg,
 
 	for (ch_idx = 0; ch_idx < num_of_ch; ch_idx++) {
 		ch_flags = (u16)__le32_to_cpup(channels + ch_idx);
-		band = (ch_idx < NUM_2GHZ_CHANNELS) ?
-		       NL80211_BAND_2GHZ : NL80211_BAND_5GHZ;
+		band = iwl_nl80211_band_from_channel_idx(ch_idx);
 		center_freq = ieee80211_channel_to_frequency(nvm_chan[ch_idx],
 							     band);
 		new_rule = false;
-- 
2.25.1

