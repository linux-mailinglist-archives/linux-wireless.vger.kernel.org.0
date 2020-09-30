Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE9C527EEDB
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Sep 2020 18:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731207AbgI3QUG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Sep 2020 12:20:06 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:53406 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728081AbgI3QUF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Sep 2020 12:20:05 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kNepn-002MPc-5V; Wed, 30 Sep 2020 19:20:03 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 30 Sep 2020 19:19:48 +0300
Message-Id: <iwlwifi.20200930191738.1c22d1bc0a88.I24e57317bdddc6c72f69725e1d95683a935e893d@changeid>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200930161959.983283-1-luca@coelho.fi>
References: <20200930161959.983283-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 01/12] iwlwifi: mvm: remove redundant log in iwl_mvm_tvqm_enable_txq()
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

We are printing the same thing twice, "Enabling TXQ #%d".  Previously
the second print was including more information, but now it only
prints the queue number, which is already in the first print.  Remove
the redundant one.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index 827e80ff5aa6..72c9235c6bd5 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -770,8 +770,6 @@ static int iwl_mvm_tvqm_enable_txq(struct iwl_mvm *mvm,
 	IWL_DEBUG_TX_QUEUES(mvm, "Enabling TXQ #%d for sta %d tid %d\n",
 			    queue, sta_id, tid);
 
-	IWL_DEBUG_TX_QUEUES(mvm, "Enabling TXQ #%d\n", queue);
-
 	return queue;
 }
 
-- 
2.28.0

