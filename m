Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6629E2D4509
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Dec 2020 16:07:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730297AbgLIPGG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Dec 2020 10:06:06 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:35472 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730270AbgLIPGG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Dec 2020 10:06:06 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kn11q-003Dg4-Op; Wed, 09 Dec 2020 17:05:19 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Wed,  9 Dec 2020 17:05:07 +0200
Message-Id: <iwlwifi.20201209170243.5a9cff8d7345.Ib0255deb67b2fc21317e274adcacb545bb1dc669@changeid>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201209150514.944056-1-luca@coelho.fi>
References: <20201209150514.944056-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 04/11] iwlwifi: mvm: disconnect if channel switch delay is too long
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

If the channel switch delay that we would incur after the channel
switch actually happens is longer than the quiet time we're willing
to tolerate, disconnect as well.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 74631b699856..74e308b57b49 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -4545,6 +4545,9 @@ static int iwl_mvm_pre_channel_switch(struct ieee80211_hw *hw,
 
 		break;
 	case NL80211_IFTYPE_STATION:
+		if (chsw->delay > IWL_MAX_CSA_BLOCK_TX)
+			schedule_delayed_work(&mvmvif->csa_work, 0);
+
 		if (chsw->block_tx) {
 			/*
 			 * In case of undetermined / long time with immediate
-- 
2.29.2

