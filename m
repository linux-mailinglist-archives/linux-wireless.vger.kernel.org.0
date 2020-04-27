Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3D401BA6F9
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2020 16:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbgD0Oyj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 Apr 2020 10:54:39 -0400
Received: from mail2.candelatech.com ([208.74.158.173]:38002 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727010AbgD0Oyj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 Apr 2020 10:54:39 -0400
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id 8D0A313C2B0;
        Mon, 27 Apr 2020 07:54:38 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 8D0A313C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1587999278;
        bh=0tGzDKRIO3qnsG4Sb0tCEgkRcqfUN2aVPcI9wmhzKK8=;
        h=From:To:Cc:Subject:Date:From;
        b=eI6yfMDOppSEgOrND6TrlVEAXRfR7xQrexOjowgXInRBosBj5kV8vTxqvcEMmh2zu
         GS8/+Teg+RBRYQ8726OpT02WQyD+DIj2fbm5gWonZWP1bHq9Vv7PNbSQtmaURLxfVp
         y1+jhGYeKSfpOvbXrtJE6XsH3q/uy7Y12o9hSdgA=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH] ath10k:  Restart xmit queues below low-water mark.
Date:   Mon, 27 Apr 2020 07:54:35 -0700
Message-Id: <20200427145435.13151-1-greearb@candelatech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

While running tcp upload + download tests with ~200
concurrent TCP streams, 1-2 processes, and 30 station
vdevs, I noticed that the __ieee80211_stop_queue was taking
around 20% of the CPU according to perf-top, which other locking
taking an additional ~15%.

I believe the issue is that the ath10k driver would unlock the
txqueue when a single frame could be transmitted, instead of
waiting for a low water mark.

So, this patch adds a low-water mark that is 1/4 of the total
tx buffers allowed.

This appears to resolve the performance problem that I saw.

Tested with recent wave-1 ath10k-ct firmware.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 drivers/net/wireless/ath/ath10k/htt.h    | 1 +
 drivers/net/wireless/ath/ath10k/htt_tx.c | 8 ++++++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/htt.h b/drivers/net/wireless/ath/ath10k/htt.h
index 31c4ddbf45cb..b5634781c0dc 100644
--- a/drivers/net/wireless/ath/ath10k/htt.h
+++ b/drivers/net/wireless/ath/ath10k/htt.h
@@ -1941,6 +1941,7 @@ struct ath10k_htt {
 
 	u8 target_version_major;
 	u8 target_version_minor;
+	bool needs_unlock;
 	struct completion target_version_received;
 	u8 max_num_amsdu;
 	u8 max_num_ampdu;
diff --git a/drivers/net/wireless/ath/ath10k/htt_tx.c b/drivers/net/wireless/ath/ath10k/htt_tx.c
index 9b3c3b080e92..44795d9a7c0c 100644
--- a/drivers/net/wireless/ath/ath10k/htt_tx.c
+++ b/drivers/net/wireless/ath/ath10k/htt_tx.c
@@ -145,8 +145,10 @@ void ath10k_htt_tx_dec_pending(struct ath10k_htt *htt)
 	lockdep_assert_held(&htt->tx_lock);
 
 	htt->num_pending_tx--;
-	if (htt->num_pending_tx == htt->max_num_pending_tx - 1)
+	if ((htt->num_pending_tx <= (htt->max_num_pending_tx / 4)) && htt->needs_unlock) {
+		htt->needs_unlock = false;
 		ath10k_mac_tx_unlock(htt->ar, ATH10K_TX_PAUSE_Q_FULL);
+	}
 }
 
 int ath10k_htt_tx_inc_pending(struct ath10k_htt *htt)
@@ -157,8 +159,10 @@ int ath10k_htt_tx_inc_pending(struct ath10k_htt *htt)
 		return -EBUSY;
 
 	htt->num_pending_tx++;
-	if (htt->num_pending_tx == htt->max_num_pending_tx)
+	if (htt->num_pending_tx == htt->max_num_pending_tx) {
+		htt->needs_unlock = true;
 		ath10k_mac_tx_lock(htt->ar, ATH10K_TX_PAUSE_Q_FULL);
+	}
 
 	return 0;
 }
-- 
2.20.1

