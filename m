Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1FF452873
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2019 11:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbfFYJpC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Jun 2019 05:45:02 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:54604 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727673AbfFYJpB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Jun 2019 05:45:01 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1hfi0Y-0007Nv-51; Tue, 25 Jun 2019 12:44:58 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>,
        Johannes Berg <johannes.berg@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>
Subject: [PATCH 01/12] iwlwifi: iwl_mvm_tx_mpdu() must be called with BH disabled
Date:   Tue, 25 Jun 2019 12:44:41 +0300
Message-Id: <20190625094452.19034-2-luca@coelho.fi>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190625094452.19034-1-luca@coelho.fi>
References: <20190625094452.19034-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Jiri Kosina <jkosina@suse.cz>

As iwl_mvm_tx_mpdu() is not disabling BH while obtaining iwl_mvm_sta->lock
(which is being taken from BH context as well), it has to be always
invoked with BH disabled. Make that clear in a comment.

Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
index 0c2aabc842f9..ad4760307726 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -1063,7 +1063,9 @@ static int iwl_mvm_tx_pkt_queued(struct iwl_mvm *mvm,
 }
 
 /*
- * Sets the fields in the Tx cmd that are crypto related
+ * Sets the fields in the Tx cmd that are crypto related.
+ *
+ * This function must be called with BHs disabled.
  */
 static int iwl_mvm_tx_mpdu(struct iwl_mvm *mvm, struct sk_buff *skb,
 			   struct ieee80211_tx_info *info,
-- 
2.20.1

