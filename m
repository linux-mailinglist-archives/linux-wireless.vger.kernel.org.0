Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 722C53169E3
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Feb 2021 16:16:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231860AbhBJPQR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 Feb 2021 10:16:17 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:45268 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230294AbhBJPQJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 Feb 2021 10:16:09 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1l9rD6-0049kS-EG; Wed, 10 Feb 2021 17:15:20 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 10 Feb 2021 17:15:09 +0200
Message-Id: <iwlwifi.20210210171218.835db8987b8a.Ic6c5d28d744302db1bc6c4314bd3138ba472f834@changeid>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210210151514.416221-1-luca@coelho.fi>
References: <20210210151514.416221-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 07/12] iwlwifi: mvm: don't check if CSA event is running before removing
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sara Sharon <sara.sharon@intel.com>

We may want to remove it before it started (i.e. before the
actual switch time).

Signed-off-by: Sara Sharon <sara.sharon@intel.com>
Fixes: 58ddd9b6d194 ("iwlwifi: mvm: don't send a CSA command the firmware doesn't know")
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/time-event.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
index 4e1bdf13e5e7..0b012f8c9eb2 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
@@ -999,9 +999,6 @@ void iwl_mvm_remove_csa_period(struct iwl_mvm *mvm,
 
 	lockdep_assert_held(&mvm->mutex);
 
-	if (!te_data->running)
-		return;
-
 	spin_lock_bh(&mvm->time_event_lock);
 	id = te_data->id;
 	spin_unlock_bh(&mvm->time_event_lock);
-- 
2.30.0

