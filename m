Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8582F91DE
	for <lists+linux-wireless@lfdr.de>; Sun, 17 Jan 2021 12:12:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727967AbhAQLL6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 17 Jan 2021 06:11:58 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:40626 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728193AbhAQLLd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 17 Jan 2021 06:11:33 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1l15xD-003sZv-AY; Sun, 17 Jan 2021 13:10:43 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sun, 17 Jan 2021 13:10:31 +0200
Message-Id: <iwlwifi.20210117130510.4ddc9b017268.Ie869b628ae56a5d776eba0e7b7f05f42fc566f2e@changeid>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210117111038.1402870-1-luca@coelho.fi>
References: <20210117111038.1402870-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 04/11] iwlwifi: mvm: scan: fix scheduled scan restart handling
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

When restarting firmware with an ongoing scheduled scan, we
don't (and shouldn't) mark it as aborted as mac80211 will be
restarting it, and so no event should go out to userspace.
The appropriate comment regarding this wasn't moved to this
place, so add it.

However, we _do_ need to clean up our internal state, since
mac80211 will restart the scan, and we'll otherwise get to
the WARN_ON() a few lines below for no reason whatsoever.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
index 97d2de8f1582..e89f4f1e44c6 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -2858,8 +2858,13 @@ void iwl_mvm_report_scan_aborted(struct iwl_mvm *mvm)
 			mvm->scan_uid_status[uid] = 0;
 		}
 		uid = iwl_mvm_scan_uid_by_status(mvm, IWL_MVM_SCAN_SCHED);
-		if (uid >= 0 && !mvm->fw_restart) {
-			ieee80211_sched_scan_stopped(mvm->hw);
+		if (uid >= 0) {
+			/* Sched scan will be restarted by mac80211 in
+			 * restart_hw, so do not report if FW is about to be
+			 * restarted.
+			 */
+			if (!mvm->fw_restart)
+				ieee80211_sched_scan_stopped(mvm->hw);
 			mvm->sched_scan_pass_all = SCHED_SCAN_PASS_ALL_DISABLED;
 			mvm->scan_uid_status[uid] = 0;
 		}
-- 
2.29.2

