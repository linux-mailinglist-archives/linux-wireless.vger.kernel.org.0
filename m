Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E11594682F4
	for <lists+linux-wireless@lfdr.de>; Sat,  4 Dec 2021 07:36:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239878AbhLDGja (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 4 Dec 2021 01:39:30 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:50278 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S238276AbhLDGj3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 4 Dec 2021 01:39:29 -0500
Received: from 91-156-5-105.elisa-laajakaista.fi ([91.156.5.105] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mtOeQ-0017AH-Qg; Sat, 04 Dec 2021 08:36:03 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sat,  4 Dec 2021 08:35:45 +0200
Message-Id: <iwlwifi.20211204083238.51aea5b79ea4.I88a44798efda16e9fe480fb3e94224931d311b29@changeid>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211204063555.769822-1-luca@coelho.fi>
References: <20211204063555.769822-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 02/12] iwlwifi: mvm: synchronize with FW after multicast commands
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

If userspace installs a lot of multicast groups very quickly, then
we may run out of command queue space as we send the updates in an
asynchronous fashion (due to locking concerns), and the CPU can
create them faster than the firmware can process them. This is true
even when mac80211 has a work struct that gets scheduled.

Fix this by synchronizing with the firmware after sending all those
commands - outside of the iteration we can send a synchronous echo
command that just has the effect of the CPU waiting for the prior
asynchronous commands to finish. This also will cause fewer of the
commands to be sent to the firmware overall, because the work will
only run once when rescheduled multiple times while it's running.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=213649
Suggested-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Reported-by: Maximilian Ernestus <maximilian@ernestus.de>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c   | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 20422e640059..9d84be991469 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -1710,6 +1710,7 @@ static void iwl_mvm_recalc_multicast(struct iwl_mvm *mvm)
 	struct iwl_mvm_mc_iter_data iter_data = {
 		.mvm = mvm,
 	};
+	int ret;
 
 	lockdep_assert_held(&mvm->mutex);
 
@@ -1719,6 +1720,22 @@ static void iwl_mvm_recalc_multicast(struct iwl_mvm *mvm)
 	ieee80211_iterate_active_interfaces_atomic(
 		mvm->hw, IEEE80211_IFACE_ITER_NORMAL,
 		iwl_mvm_mc_iface_iterator, &iter_data);
+
+	/*
+	 * Send a (synchronous) ech command so that we wait for the
+	 * multiple asynchronous MCAST_FILTER_CMD commands sent by
+	 * the interface iterator. Otherwise, we might get here over
+	 * and over again (by userspace just sending a lot of these)
+	 * and the CPU can send them faster than the firmware can
+	 * process them.
+	 * Note that the CPU is still faster - but with this we'll
+	 * actually send fewer commands overall because the CPU will
+	 * not schedule the work in mac80211 as frequently if it's
+	 * still running when rescheduled (possibly multiple times).
+	 */
+	ret = iwl_mvm_send_cmd_pdu(mvm, ECHO_CMD, 0, 0, NULL);
+	if (ret)
+		IWL_ERR(mvm, "Failed to synchronize multicast groups update\n");
 }
 
 static u64 iwl_mvm_prepare_multicast(struct ieee80211_hw *hw,
-- 
2.33.1

