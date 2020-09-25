Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C472427938F
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Sep 2020 23:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728930AbgIYVbE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Sep 2020 17:31:04 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:52316 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726744AbgIYVbD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Sep 2020 17:31:03 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kLvIy-002J1P-VF; Sat, 26 Sep 2020 00:31:01 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sat, 26 Sep 2020 00:30:43 +0300
Message-Id: <iwlwifi.20200926002540.c76108b9c476.Ib06008665e7bf1199c360aa92691d9c74fb84990@changeid>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200925213053.454459-1-luca@coelho.fi>
References: <20200925213053.454459-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 05/15] iwlwifi: mvm: split a print to avoid a WARNING in ROC
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

A print in the remain on channel code was too long and caused
a WARNING, split it.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Fixes: 758cba88d008 ("iwlwifi: mvm: ROC: Extend the ROC max delay duration & limit ROC duration")
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 6e8af84f386a..73280a2607a5 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -3703,9 +3703,12 @@ static int iwl_mvm_send_aux_roc_cmd(struct iwl_mvm *mvm,
 	tail->apply_time_max_delay = cpu_to_le32(delay);
 
 	IWL_DEBUG_TE(mvm,
-		     "ROC: Requesting to remain on channel %u for %ums (requested = %ums, max_delay = %ums, dtim_interval = %ums)\n",
-		     channel->hw_value, req_dur, duration, delay,
-		     dtim_interval);
+		     "ROC: Requesting to remain on channel %u for %ums\n",
+		     channel->hw_value, req_dur);
+	IWL_DEBUG_TE(mvm,
+		     "\t(requested = %ums, max_delay = %ums, dtim_interval = %ums)\n",
+		     duration, delay, dtim_interval);
+
 	/* Set the node address */
 	memcpy(tail->node_addr, vif->addr, ETH_ALEN);
 
-- 
2.28.0

