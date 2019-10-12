Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1FE3D50FC
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Oct 2019 18:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729384AbfJLQ3c (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 12 Oct 2019 12:29:32 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:48738 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728338AbfJLQ3b (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 12 Oct 2019 12:29:31 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1iJKGn-00062r-V0; Sat, 12 Oct 2019 19:29:30 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sat, 12 Oct 2019 19:29:12 +0300
Message-Id: <20191012192536.0e45e69a388a.I1d63567def2526950608f62c88626ef489e18041@changeid>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191012162924.19848-1-luca@coelho.fi>
References: <20191012162924.19848-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH 01/13] iwlwifi: mvm: consider ieee80211 station max amsdu value
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mordechay Goodstein <mordechay.goodstein@intel.com>

debugfs amsdu_len sets only the max_amsdu_len for ieee80211 station
so take it into consideration while getting max amsdu

Fixes: af2984e9e625 ("iwlwifi: mvm: add a debugfs entry to set a fixed size AMSDU for all TX packets")
Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c | 8 +++++++-
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c    | 7 ++++++-
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
index 8f50e2b121bd..098d48153a38 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
@@ -350,7 +350,13 @@ void iwl_mvm_tlc_update_notif(struct iwl_mvm *mvm,
 		u16 size = le32_to_cpu(notif->amsdu_size);
 		int i;
 
-		if (WARN_ON(sta->max_amsdu_len < size))
+		/*
+		 * In debug sta->max_amsdu_len < size
+		 * so also check with orig_amsdu_len which holds the original
+		 * data before debugfs changed the value
+		 */
+		if (WARN_ON(sta->max_amsdu_len < size &&
+			    mvmsta->orig_amsdu_len < size))
 			goto out;
 
 		mvmsta->amsdu_enabled = le32_to_cpu(notif->amsdu_enabled);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
index 8a059da7a1fa..e3b2a2bf3863 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -935,7 +935,12 @@ static int iwl_mvm_tx_tso(struct iwl_mvm *mvm, struct sk_buff *skb,
 	    !(mvmsta->amsdu_enabled & BIT(tid)))
 		return iwl_mvm_tx_tso_segment(skb, 1, netdev_flags, mpdus_skb);
 
-	max_amsdu_len = iwl_mvm_max_amsdu_size(mvm, sta, tid);
+	/*
+	 * Take the min of ieee80211 station and mvm station
+	 */
+	max_amsdu_len =
+		min_t(unsigned int, sta->max_amsdu_len,
+		      iwl_mvm_max_amsdu_size(mvm, sta, tid));
 
 	/*
 	 * Limit A-MSDU in A-MPDU to 4095 bytes when VHT is not
-- 
2.23.0

