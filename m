Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96D6D35B2DF
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Apr 2021 11:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235369AbhDKJra (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 11 Apr 2021 05:47:30 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:44450 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S235331AbhDKJrZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 11 Apr 2021 05:47:25 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1lVWfs-000Jkq-8D; Sun, 11 Apr 2021 12:46:37 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sun, 11 Apr 2021 12:46:24 +0300
Message-Id: <iwlwifi.20210411124417.2a2fb9f9c25e.I7c7bbcfbdc1d35d2c3338778fb397dd5b08ea0e8@changeid>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210411094630.431873-1-luca@coelho.fi>
References: <20210411094630.431873-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP,TVD_SUBJ_WIPE_DEBT autolearn=no autolearn_force=no
        version=3.4.5-pre1
Subject: [PATCH 06/12] iwlwifi: mvm: remove PS from lower rates.
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mordechay Goodstein <mordechay.goodstein@intel.com>

Power save (PS) should only be enabled when we reach the max phy rate.
Before we reach it (MCS_9) for VHT, we should keep trying to improve the
throughput.

Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/rs.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rs.c b/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
index 91b6541d579f..b97708cb869d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
- * Copyright(c) 2005 - 2014, 2018 - 2020 Intel Corporation. All rights reserved.
+ * Copyright(c) 2005 - 2014, 2018 - 2021 Intel Corporation. All rights reserved.
  * Copyright(c) 2013 - 2015 Intel Mobile Communications GmbH
  * Copyright(c) 2016 - 2017 Intel Deutschland GmbH
  *
@@ -1926,9 +1926,7 @@ static bool rs_tpc_allowed(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	if (is_ht(rate))
 		return index == IWL_RATE_MCS_7_INDEX;
 	if (is_vht(rate))
-		return index == IWL_RATE_MCS_7_INDEX ||
-		       index == IWL_RATE_MCS_8_INDEX ||
-		       index == IWL_RATE_MCS_9_INDEX;
+		return index == IWL_RATE_MCS_9_INDEX;
 
 	WARN_ON_ONCE(1);
 	return false;
-- 
2.31.0

