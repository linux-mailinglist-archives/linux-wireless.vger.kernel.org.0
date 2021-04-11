Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B78E35B320
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Apr 2021 12:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235233AbhDKK0F (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 11 Apr 2021 06:26:05 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:44500 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231356AbhDKK0E (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 11 Apr 2021 06:26:04 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1lVXHm-000K0H-1g; Sun, 11 Apr 2021 13:25:47 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sun, 11 Apr 2021 13:25:38 +0300
Message-Id: <iwlwifi.20210411132130.3d710091a0bd.I37a161ffdfb099a10080fbdc3b70a4deb76952e2@changeid>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210411102545.438654-1-luca@coelho.fi>
References: <20210411102545.438654-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH 1/8] iwlwifi: mvm: don't disconnect immediately if we don't hear beacons after CSA
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

When we switch channel, we may miss a few beacons on the
new channel. Don't disconnect if the time event for the
switch ends before we hear the beacons.

Note that this is relevant only for old devices that still
use the TIME_EVENT firmware API for channel switch.

The check that we hear a beacon before the time event
ends was meant to be used for the association time event
and not for the channel switch time event.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/time-event.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
index 1418a6438635..76c36f5cf9a3 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2012-2014, 2018-2020 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2021 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2017 Intel Deutschland GmbH
  */
@@ -294,6 +294,17 @@ static void iwl_mvm_te_handle_notif(struct iwl_mvm *mvm,
 			iwl_mvm_roc_finished(mvm);
 			break;
 		case NL80211_IFTYPE_STATION:
+			/*
+			 * If we are switching channel, don't disconnect
+			 * if the time event is already done. Beacons can
+			 * be delayed a bit after the switch.
+			 */
+			if (te_data->id == TE_CHANNEL_SWITCH_PERIOD) {
+				IWL_DEBUG_TE(mvm,
+					     "No beacon heard and the CS time event is over, don't disconnect\n");
+				break;
+			}
+
 			/*
 			 * By now, we should have finished association
 			 * and know the dtim period.
-- 
2.31.0

