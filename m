Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40BD8DDD63
	for <lists+linux-wireless@lfdr.de>; Sun, 20 Oct 2019 10:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbfJTI4C (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 20 Oct 2019 04:56:02 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:50796 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726285AbfJTI4A (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 20 Oct 2019 04:56:00 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1iM70I-0003LY-U8; Sun, 20 Oct 2019 11:55:59 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sun, 20 Oct 2019 11:55:40 +0300
Message-Id: <20191020085545.16407-6-luca@coelho.fi>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191020085545.16407-1-luca@coelho.fi>
References: <20191020085545.16407-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH 07/12] iwlwifi: mvm: don't skip mgmt tid when flushing all tids
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Haim Dreyfuss <haim.dreyfuss@intel.com>

There are various of flows which require tids flushing
(disconnection, suspend, etc...).
Currently, when the driver instructs the FW to flush
he masks all the data tids(0-7).
However, the driver doesn't set the management tid (#15)
which cause the FW not to flush it.
When the FW tries to remove the mgmt queue he throws an assert
since it is not an empty queue.
instead of just set only the data tids set everything and let
the FW ignore the invalid tids.

Signed-off-by: Haim Dreyfuss <haim.dreyfuss@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c  | 3 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c       | 2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
index 754adc0146be..9970f61b9f9f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
@@ -148,7 +148,8 @@ static ssize_t iwl_dbgfs_tx_flush_write(struct iwl_mvm *mvm, char *buf,
 				    "FLUSHING all tids queues on sta_id = %d\n",
 				    flush_arg);
 		mutex_lock(&mvm->mutex);
-		ret = iwl_mvm_flush_sta_tids(mvm, flush_arg, 0xFF, 0) ? : count;
+		ret = iwl_mvm_flush_sta_tids(mvm, flush_arg, 0xFFFF, 0)
+			? : count;
 		mutex_unlock(&mvm->mutex);
 		return ret;
 	}
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index e879c02ca4db..e0ffc3cdd677 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -4644,7 +4644,7 @@ static void iwl_mvm_flush_no_vif(struct iwl_mvm *mvm, u32 queues, bool drop)
 			continue;
 
 		if (drop)
-			iwl_mvm_flush_sta_tids(mvm, i, 0xFF, 0);
+			iwl_mvm_flush_sta_tids(mvm, i, 0xFFFF, 0);
 		else
 			iwl_mvm_wait_sta_queues_empty(mvm,
 					iwl_mvm_sta_from_mac80211(sta));
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
index f4778a6a40b9..81a88a89ea74 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -2059,7 +2059,7 @@ int iwl_mvm_flush_sta(struct iwl_mvm *mvm, void *sta, bool internal, u32 flags)
 
 	if (iwl_mvm_has_new_tx_api(mvm))
 		return iwl_mvm_flush_sta_tids(mvm, mvm_sta->sta_id,
-					      0xff | BIT(IWL_MGMT_TID), flags);
+					      0xffff, flags);
 
 	if (internal)
 		return iwl_mvm_flush_tx_path(mvm, int_sta->tfd_queue_msk,
-- 
2.23.0

