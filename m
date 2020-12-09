Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 800F32D4CE1
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Dec 2020 22:32:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388191AbgLIVbz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Dec 2020 16:31:55 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:35842 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726877AbgLIVby (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Dec 2020 16:31:54 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kn6py-003Drx-1l; Wed, 09 Dec 2020 23:17:26 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Wed,  9 Dec 2020 23:16:47 +0200
Message-Id: <iwlwifi.20201209231352.2d07dcee0d35.I07a61b5d734478db57d9434ff303e4c90bf6c32b@changeid>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201209211651.968276-1-luca@coelho.fi>
References: <20201209211651.968276-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH v2 43/47] iwlwifi: mvm: hook up missing RX handlers
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

The RX handlers for probe response data and channel switch weren't
hooked up properly, fix that.

Fixes: 86e177d80ff7 ("iwlwifi: mvm: add NOA and CSA to a probe response")
Fixes: d3a108a48dc6 ("iwlwifi: mvm: Support CSA countdown offloading")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index fc5e66bc7c58..98f62d78cf9c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -260,6 +260,12 @@ static const struct iwl_rx_handlers iwl_mvm_rx_handlers[] = {
 		       iwl_mvm_mu_mimo_grp_notif, RX_HANDLER_SYNC),
 	RX_HANDLER_GRP(DATA_PATH_GROUP, STA_PM_NOTIF,
 		       iwl_mvm_sta_pm_notif, RX_HANDLER_SYNC),
+	RX_HANDLER_GRP(MAC_CONF_GROUP, PROBE_RESPONSE_DATA_NOTIF,
+		       iwl_mvm_probe_resp_data_notif,
+		       RX_HANDLER_ASYNC_LOCKED),
+	RX_HANDLER_GRP(MAC_CONF_GROUP, CHANNEL_SWITCH_NOA_NOTIF,
+		       iwl_mvm_channel_switch_noa_notif,
+		       RX_HANDLER_SYNC),
 };
 #undef RX_HANDLER
 #undef RX_HANDLER_GRP
-- 
2.29.2

