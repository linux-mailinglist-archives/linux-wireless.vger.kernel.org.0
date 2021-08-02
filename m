Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 651323DDB06
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Aug 2021 16:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234070AbhHBO2z (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Aug 2021 10:28:55 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:50968 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S234330AbhHBO2y (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Aug 2021 10:28:54 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1mAYvn-001xts-NV; Mon, 02 Aug 2021 17:28:41 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Mon,  2 Aug 2021 17:28:28 +0300
Message-Id: <iwlwifi.20210802172232.80611a3c1ee7.I8a3d2b269421b6d8bada8c12cce3e095e6cfaeed@changeid>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210802142829.109448-1-luca@coelho.fi>
References: <20210802142829.109448-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH 11/12] iwlwifi: mvm: clean up number of HW queues
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Since switching to mac80211 TXQs, we no longer need to
advertise more hardware queues than ACs, since we don't
even set QUEUE_CONTROL anyway, so the vif->hw_queue[]
mapping array won't be used.

All we need (at least for now) is for hw->queues to
indicate that we have enough queues to handle QoS.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index b2072e19b5dc..f38d2476d5a3 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -390,7 +390,7 @@ int iwl_mvm_mac_setup_register(struct iwl_mvm *mvm)
 	if (mvm->trans->max_skb_frags)
 		hw->netdev_features = NETIF_F_HIGHDMA | NETIF_F_SG;
 
-	hw->queues = IEEE80211_MAX_QUEUES;
+	hw->queues = IEEE80211_NUM_ACS;
 	hw->offchannel_tx_hw_queue = IWL_MVM_OFFCHANNEL_QUEUE;
 	hw->radiotap_mcs_details |= IEEE80211_RADIOTAP_MCS_HAVE_FEC |
 				    IEEE80211_RADIOTAP_MCS_HAVE_STBC;
-- 
2.32.0

