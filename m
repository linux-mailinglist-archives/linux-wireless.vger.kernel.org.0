Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4C9C43098A
	for <lists+linux-wireless@lfdr.de>; Sun, 17 Oct 2021 16:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343797AbhJQOCR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 17 Oct 2021 10:02:17 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:53964 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1343803AbhJQOCP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 17 Oct 2021 10:02:15 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mc6hl-000Yi6-7d; Sun, 17 Oct 2021 17:00:01 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sun, 17 Oct 2021 16:59:50 +0300
Message-Id: <iwlwifi.20211017165728.8e6b1eb8a436.I5fd6caee968007e91d03b93d6ea84b670ce047e9@changeid>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211017135954.504836-1-luca@coelho.fi>
References: <20211017135954.504836-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 06/10] iwlwifi: mvm: improve log when processing CSA
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Gregory Greenman <gregory.greenman@intel.com>

Sometimes driver fails to detect misbehaving AP since we may
miss a few beacons (AP is declared misbehaving only after the second
time CSA counter has a wrong jump).
Move the print to the start of the function to avoid doubts when
analysing this kind of issues.

Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 5277f63dac3d..2645dd8fef83 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -4732,6 +4732,9 @@ static void iwl_mvm_channel_switch_rx_beacon(struct ieee80211_hw *hw,
 	if (!fw_has_capa(&mvm->fw->ucode_capa, IWL_UCODE_TLV_CAPA_CS_MODIFY))
 		return;
 
+	IWL_DEBUG_MAC80211(mvm, "Modify CSA on mac %d count = %d (old %d) mode = %d\n",
+			   mvmvif->id, chsw->count, mvmvif->csa_count, chsw->block_tx);
+
 	if (chsw->count >= mvmvif->csa_count && chsw->block_tx) {
 		if (mvmvif->csa_misbehave) {
 			/* Second time, give up on this AP*/
@@ -4748,8 +4751,6 @@ static void iwl_mvm_channel_switch_rx_beacon(struct ieee80211_hw *hw,
 	if (mvmvif->csa_failed)
 		goto out_unlock;
 
-	IWL_DEBUG_MAC80211(mvm, "Modify CSA on mac %d count = %d mode = %d\n",
-			   mvmvif->id, chsw->count, chsw->block_tx);
 	WARN_ON(iwl_mvm_send_cmd_pdu(mvm,
 				     WIDE_ID(MAC_CONF_GROUP,
 					     CHANNEL_SWITCH_TIME_EVENT_CMD),
-- 
2.33.0

