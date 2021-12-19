Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAF47479FFC
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Dec 2021 10:01:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235448AbhLSJBj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 19 Dec 2021 04:01:39 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:51300 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S235437AbhLSJBi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 19 Dec 2021 04:01:38 -0500
Received: from 91-156-5-105.elisa-laajakaista.fi ([91.156.5.105] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mys4W-001O16-5c; Sun, 19 Dec 2021 11:01:36 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@kernel.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sun, 19 Dec 2021 11:01:28 +0200
Message-Id: <20211219090128.42417-2-luca@coelho.fi>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211219090128.42417-1-luca@coelho.fi>
References: <20211219090128.42417-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 4/4] iwlwifi: mvm: fix imbalanced locking in iwl_mvm_start_get_nvm()
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

If iwl_transt_start_hw() failed, we were returning without calling
wiphy_unlock() and rtnl_unlock(), causing a locking imbalance:

drivers/net/wireless/intel/iwlwifi/mvm/ops.c:686:12: warning: context imbalance in 'iwl_mvm_start_get_nvm' - wrong count at exit

Fix that by adding the unlock calls.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 9bd869b8a974..3941baa3eda3 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -718,6 +718,8 @@ static int iwl_mvm_start_get_nvm(struct iwl_mvm *mvm)
 	ret = iwl_trans_start_hw(mvm->trans);
 	if (ret) {
 		mutex_unlock(&mvm->mutex);
+		wiphy_unlock(mvm->hw->wiphy);
+		rtnl_unlock();
 		return ret;
 	}
 
-- 
2.34.1

