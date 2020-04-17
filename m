Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F8921AD701
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2020 09:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728753AbgDQHI2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Apr 2020 03:08:28 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:56388 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728470AbgDQHI1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Apr 2020 03:08:27 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1jPL6v-000KNJ-ND; Fri, 17 Apr 2020 10:08:26 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 17 Apr 2020 10:08:12 +0300
Message-Id: <iwlwifi.20200417100405.98a79be2db6a.I3a4af6b03b87a6bc18db9b1ff9a812f397bee1fc@changeid>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200417070814.2044774-1-luca@coelho.fi>
References: <20200417070814.2044774-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH v2 v5.7 4/6] iwlwifi: mvm: limit maximum queue appropriately
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Due to some hardware issues, queue 31 isn't usable on devices that have
32 queues (7000, 8000, 9000 families), which is correctly reflected in
the configuration and TX queue initialization.

However, the firmware API and queue allocation code assumes that there
are 32 queues, and if something actually attempts to use #31 this leads
to a NULL-pointer dereference since it's not allocated.

Fix this by limiting to 31 in the IWL_MVM_DQA_MAX_DATA_QUEUE, and also
add some code to catch this earlier in the future, if the configuration
changes perhaps.

Cc: stable@vger.kernel.org # v4.9+
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/txq.h | 6 +++---
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c    | 5 +++++
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/txq.h b/drivers/net/wireless/intel/iwlwifi/fw/api/txq.h
index 73196cbc7fbe..75d958bab0e3 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/txq.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/txq.h
@@ -8,7 +8,7 @@
  * Copyright(c) 2007 - 2014 Intel Corporation. All rights reserved.
  * Copyright(c) 2013 - 2015 Intel Mobile Communications GmbH
  * Copyright(c) 2016 - 2017 Intel Deutschland GmbH
- * Copyright(c) 2019 Intel Corporation
+ * Copyright(c) 2019 - 2020 Intel Corporation
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of version 2 of the GNU General Public License as
@@ -31,7 +31,7 @@
  * Copyright(c) 2005 - 2014 Intel Corporation. All rights reserved.
  * Copyright(c) 2013 - 2015 Intel Mobile Communications GmbH
  * Copyright(c) 2016 - 2017 Intel Deutschland GmbH
- * Copyright(c) 2019 Intel Corporation
+ * Copyright(c) 2019 - 2020 Intel Corporation
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
@@ -99,7 +99,7 @@ enum iwl_mvm_dqa_txq {
 	IWL_MVM_DQA_MAX_MGMT_QUEUE = 8,
 	IWL_MVM_DQA_AP_PROBE_RESP_QUEUE = 9,
 	IWL_MVM_DQA_MIN_DATA_QUEUE = 10,
-	IWL_MVM_DQA_MAX_DATA_QUEUE = 31,
+	IWL_MVM_DQA_MAX_DATA_QUEUE = 30,
 };
 
 enum iwl_mvm_tx_fifo {
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index 64ef3f3ba23b..251d6fbb1da5 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -722,6 +722,11 @@ static int iwl_mvm_find_free_queue(struct iwl_mvm *mvm, u8 sta_id,
 
 	lockdep_assert_held(&mvm->mutex);
 
+	if (WARN(maxq >= mvm->trans->trans_cfg->base_params->num_of_queues,
+		 "max queue %d >= num_of_queues (%d)", maxq,
+		 mvm->trans->trans_cfg->base_params->num_of_queues))
+		maxq = mvm->trans->trans_cfg->base_params->num_of_queues - 1;
+
 	/* This should not be hit with new TX path */
 	if (WARN_ON(iwl_mvm_has_new_tx_api(mvm)))
 		return -ENOSPC;
-- 
2.25.1

