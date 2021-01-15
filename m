Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57AB52F77B0
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Jan 2021 12:33:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbhAOLcv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 15 Jan 2021 06:32:51 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:40402 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725831AbhAOLcv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 15 Jan 2021 06:32:51 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1l0Mvk-003hBK-9S; Fri, 15 Jan 2021 13:06:12 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 15 Jan 2021 13:05:58 +0200
Message-Id: <iwlwifi.20210115130253.217a9d6a6a12.If964cb582ab0aaa94e81c4ff3b279eaafda0fd3f@changeid>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210115110558.1248847-1-luca@coelho.fi>
References: <20210115110558.1248847-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH for v5.11 12/12] iwlwifi: pcie: reschedule in long-running memory reads
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

If we spin for a long time in memory reads that (for some reason in
hardware) take a long time, then we'll eventually get messages such
as

  watchdog: BUG: soft lockup - CPU#2 stuck for 24s! [kworker/2:2:272]

This is because the reading really does take a very long time, and
we don't schedule, so we're hogging the CPU with this task, at least
if CONFIG_PREEMPT is not set, e.g. with CONFIG_PREEMPT_VOLUNTARY=y.

Previously I misinterpreted the situation and thought that this was
only going to happen if we had interrupts disabled, and then fixed
this (which is good anyway, however), but that didn't always help;
looking at it again now I realized that the spin unlock will only
reschedule if CONFIG_PREEMPT is used.

In order to avoid this issue, change the code to cond_resched() if
we've been spinning for too long here.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Fixes: 04516706bb99 ("iwlwifi: pcie: limit memory read spin time")
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index e3760c41b31e..ab93a848a466 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -2108,6 +2108,7 @@ static int iwl_trans_pcie_read_mem(struct iwl_trans *trans, u32 addr,
 	while (offs < dwords) {
 		/* limit the time we spin here under lock to 1/2s */
 		unsigned long end = jiffies + HZ / 2;
+		bool resched = false;
 
 		if (iwl_trans_grab_nic_access(trans, &flags)) {
 			iwl_write32(trans, HBUS_TARG_MEM_RADDR,
@@ -2118,10 +2119,15 @@ static int iwl_trans_pcie_read_mem(struct iwl_trans *trans, u32 addr,
 							HBUS_TARG_MEM_RDAT);
 				offs++;
 
-				if (time_after(jiffies, end))
+				if (time_after(jiffies, end)) {
+					resched = true;
 					break;
+				}
 			}
 			iwl_trans_release_nic_access(trans, &flags);
+
+			if (resched)
+				cond_resched();
 		} else {
 			return -EBUSY;
 		}
-- 
2.29.2

