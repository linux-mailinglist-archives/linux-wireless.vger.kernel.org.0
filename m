Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F370C1B8582
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Apr 2020 12:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbgDYKFR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 25 Apr 2020 06:05:17 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:58248 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726304AbgDYKFQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 25 Apr 2020 06:05:16 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1jSHgQ-000P3t-9E; Sat, 25 Apr 2020 13:05:14 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sat, 25 Apr 2020 13:04:55 +0300
Message-Id: <iwlwifi.20200425130140.e469ce6501e4.Ibdecebca830bdfbf5220693dd1f5367f7736242d@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200425100459.2778317-1-luca@coelho.fi>
References: <20200425100459.2778317-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 07/11] iwlwifi: tx: enable A-MSDU in low latency mode
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mordechay Goodstein <mordechay.goodstein@intel.com>

Tests have shown that we can meet low latency KPIs with A-MSDU
enabled so enable it to achieve max TPT.

Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
index a8d0d17f79fd..2f6484e0d726 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -8,7 +8,7 @@
  * Copyright(c) 2012 - 2014 Intel Corporation. All rights reserved.
  * Copyright(c) 2013 - 2015 Intel Mobile Communications GmbH
  * Copyright(c) 2016 - 2017 Intel Deutschland GmbH
- * Copyright(c) 2018 - 2019 Intel Corporation
+ * Copyright(c) 2018 - 2020 Intel Corporation
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of version 2 of the GNU General Public License as
@@ -31,7 +31,7 @@
  * Copyright(c) 2012 - 2014 Intel Corporation. All rights reserved.
  * Copyright(c) 2013 - 2015 Intel Mobile Communications GmbH
  * Copyright(c) 2016 - 2017 Intel Deutschland GmbH
- * Copyright(c) 2018 - 2019 Intel Corporation
+ * Copyright(c) 2018 - 2020 Intel Corporation
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
@@ -920,11 +920,8 @@ static int iwl_mvm_tx_tso(struct iwl_mvm *mvm, struct sk_buff *skb,
 	 * No need to lock amsdu_in_ampdu_allowed since it can't be modified
 	 * during an BA session.
 	 */
-	if (info->flags & IEEE80211_TX_CTL_AMPDU &&
-	    !mvmsta->tid_data[tid].amsdu_in_ampdu_allowed)
-		return iwl_mvm_tx_tso_segment(skb, 1, netdev_flags, mpdus_skb);
-
-	if (iwl_mvm_vif_low_latency(iwl_mvm_vif_from_mac80211(mvmsta->vif)) ||
+	if ((info->flags & IEEE80211_TX_CTL_AMPDU &&
+	     !mvmsta->tid_data[tid].amsdu_in_ampdu_allowed) ||
 	    !(mvmsta->amsdu_enabled & BIT(tid)))
 		return iwl_mvm_tx_tso_segment(skb, 1, netdev_flags, mpdus_skb);
 
-- 
2.26.2

