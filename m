Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 985372FB9AA
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Jan 2021 15:37:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392074AbhASOhA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 19 Jan 2021 09:37:00 -0500
Received: from mx4.wp.pl ([212.77.101.12]:41905 "EHLO mx4.wp.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389643AbhASKHQ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 19 Jan 2021 05:07:16 -0500
Received: (wp-smtpd smtp.wp.pl 23915 invoked from network); 19 Jan 2021 11:06:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1611050782; bh=EPavF1Kd+IbkWeecPv5YGdehGXKFSl2PxPSczImQbOc=;
          h=From:To:Cc:Subject;
          b=C3e1YcKT82wxfYSiVrk/8TWInocwS6SF7C1ZAdO+jvot76sGgZWs7DvYhCZGEjFdy
           uUHs4YxY+J6vP4U5aZxEYUpSgaNtr4ud9ms9u4MBQtKuh2gOuapi76eAkK9PAxa89k
           WCOtSOe5fpYaaah5qEIRdZ1XuG5E6lxMaWRTnlcA=
Received: from ip4-46-39-164-203.cust.nbox.cz (HELO localhost) (stf_xl@wp.pl@[46.39.164.203])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <linux-wireless@vger.kernel.org>; 19 Jan 2021 11:06:22 +0100
From:   stf_xl@wp.pl
To:     linux-wireless@vger.kernel.org
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] iwl4965: do not process non-QOS frames on txq->sched_retry path
Date:   Tue, 19 Jan 2021 11:06:21 +0100
Message-Id: <20210119100621.439134-1-stf_xl@wp.pl>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-WP-MailID: ea52de2d867fe22444c72910d1a5cc32
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [kWNE]                               
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Stanislaw Gruszka <stf_xl@wp.pl>

We have already WARN_ON(!qc) for non-QOS frame on txq->sched_retry path,
but we continue to process, what makes no sense since tid is not
initialized. Non QOS frame should never happen when aggregation
is enabled on queue, so do not process that.

Patch should fix smatch warning:
drivers/net/wireless/intel/iwlegacy/4965-mac.c:2822 il4965_hdl_tx() error: uninitialized symbol 'tid'.

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Stanislaw Gruszka <stf_xl@wp.pl>
---
 drivers/net/wireless/intel/iwlegacy/4965-mac.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlegacy/4965-mac.c b/drivers/net/wireless/intel/iwlegacy/4965-mac.c
index 28675a4ad861..98cd06287b43 100644
--- a/drivers/net/wireless/intel/iwlegacy/4965-mac.c
+++ b/drivers/net/wireless/intel/iwlegacy/4965-mac.c
@@ -2813,8 +2813,10 @@ il4965_hdl_tx(struct il_priv *il, struct il_rx_buf *rxb)
 	spin_lock_irqsave(&il->sta_lock, flags);
 	if (txq->sched_retry) {
 		const u32 scd_ssn = il4965_get_scd_ssn(tx_resp);
-		struct il_ht_agg *agg = NULL;
-		WARN_ON(!qc);
+		struct il_ht_agg *agg;
+
+		if (WARN_ON(!qc))
+			goto out;
 
 		agg = &il->stations[sta_id].tid[tid].agg;
 
@@ -2830,9 +2832,7 @@ il4965_hdl_tx(struct il_priv *il, struct il_rx_buf *rxb)
 			D_TX_REPLY("Retry scheduler reclaim scd_ssn "
 				   "%d idx %d\n", scd_ssn, idx);
 			freed = il4965_tx_queue_reclaim(il, txq_id, idx);
-			if (qc)
-				il4965_free_tfds_in_queue(il, sta_id, tid,
-							  freed);
+			il4965_free_tfds_in_queue(il, sta_id, tid, freed);
 
 			if (il->mac80211_registered &&
 			    il_queue_space(&txq->q) > txq->q.low_mark &&
@@ -2862,6 +2862,7 @@ il4965_hdl_tx(struct il_priv *il, struct il_rx_buf *rxb)
 		    il_queue_space(&txq->q) > txq->q.low_mark)
 			il_wake_queue(il, txq);
 	}
+out:
 	if (qc && likely(sta_id != IL_INVALID_STATION))
 		il4965_txq_check_empty(il, sta_id, tid, txq_id);
 
-- 
2.25.4

