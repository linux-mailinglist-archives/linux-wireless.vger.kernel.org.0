Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4AE134E8FE
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Mar 2021 15:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231803AbhC3NZI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 30 Mar 2021 09:25:08 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:43588 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231966AbhC3NZG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 30 Mar 2021 09:25:06 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1lREMe-0007fg-UX; Tue, 30 Mar 2021 16:25:02 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Tue, 30 Mar 2021 16:24:49 +0300
Message-Id: <iwlwifi.20210330162204.eb4f2ff1b863.Ib16238106b33d58b2b7688dc6297018b915ecef4@changeid>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210330132500.468321-1-luca@coelho.fi>
References: <20210330132500.468321-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH 01/12] iwlwifi: mvm: enable TX on new CSA channel before disconnecting
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sara Sharon <sara.sharon@intel.com>

When moving to the new channel, we block TX until we hear the
first beacon. if it is not heard, we proceed to disconnect.
Since TX is blocked (without mac80211 being aware of it) the frame
is stuck, resulting with queue hang.

Instead, reenable TX before reporting on the connection loss.
As we are on the new channel, there is no problem with that,
even if the original CSA had quiet mode.

Signed-off-by: Sara Sharon <sara.sharon@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/time-event.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
index 0b012f8c9eb2..1418a6438635 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
@@ -151,6 +151,16 @@ static bool iwl_mvm_te_check_disconnect(struct iwl_mvm *mvm,
 	if (errmsg)
 		IWL_ERR(mvm, "%s\n", errmsg);
 
+	if (mvmvif->csa_bcn_pending) {
+		struct iwl_mvm_sta *mvmsta;
+
+		rcu_read_lock();
+		mvmsta = iwl_mvm_sta_from_staid_rcu(mvm, mvmvif->ap_sta_id);
+		if (!WARN_ON(!mvmsta))
+			iwl_mvm_sta_modify_disable_tx(mvm, mvmsta, false);
+		rcu_read_unlock();
+	}
+
 	iwl_mvm_connection_loss(mvm, vif, errmsg);
 	return true;
 }
-- 
2.31.0

