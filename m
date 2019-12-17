Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 444721231F0
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2019 17:18:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728872AbfLQQSo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Dec 2019 11:18:44 -0500
Received: from nbd.name ([46.4.11.11]:49362 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729374AbfLQQSg (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Dec 2019 11:18:36 -0500
Received: from pd95fd66b.dip0.t-ipconnect.de ([217.95.214.107] helo=bertha.fritz.box)
        by ds12 with esmtpa (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1ihFYR-0003HI-1s; Tue, 17 Dec 2019 17:18:35 +0100
From:   John Crispin <john@phrozen.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        Venkateswara Naralasetty <vnaralas@codeaurora.org>,
        John Crispin <john@phrozen.org>
Subject: [PATCH] ath11k: properly convert peer stats
Date:   Tue, 17 Dec 2019 17:18:28 +0100
Message-Id: <20191217161828.1318-1-john@phrozen.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Venkateswara Naralasetty <vnaralas@codeaurora.org>

The bandwidth was not converted from mac80211 to ath11k values correctly.
This patch adds a helper function to do it for us.

Signed-off-by: John Crispin <john@phrozen.org>
Signed-off-by: Venkateswara Naralasetty <vnaralas@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/debugfs_sta.c | 24 ++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/debugfs_sta.c b/drivers/net/wireless/ath/ath11k/debugfs_sta.c
index d851d87e8a37..1d562133ae1e 100644
--- a/drivers/net/wireless/ath/ath11k/debugfs_sta.c
+++ b/drivers/net/wireless/ath/ath11k/debugfs_sta.c
@@ -11,6 +11,28 @@
 #include "dp_tx.h"
 #include "debug_htt_stats.h"
 
+static u8 mac80211_bw_to_ath11k_bw(u8 bw)
+{
+	u8 ret = 0;
+
+	switch (bw) {
+	case RATE_INFO_BW_20:
+		ret = ATH11K_BW_20;
+		break;
+	case RATE_INFO_BW_40:
+		ret = ATH11K_BW_40;
+		break;
+	case RATE_INFO_BW_80:
+		ret = ATH11K_BW_80;
+		break;
+	case RATE_INFO_BW_160:
+		ret = ATH11K_BW_160;
+		break;
+	}
+
+	return ret;
+}
+
 void
 ath11k_accumulate_per_peer_tx_stats(struct ath11k_sta *arsta,
 				    struct ath11k_per_peer_tx_stats *peer_stats,
@@ -26,7 +48,7 @@ ath11k_accumulate_per_peer_tx_stats(struct ath11k_sta *arsta,
 	tx_stats = arsta->tx_stats;
 	gi = FIELD_GET(RATE_INFO_FLAGS_SHORT_GI, arsta->txrate.flags);
 	mcs = txrate->mcs;
-	bw = txrate->bw;
+	bw = mac80211_bw_to_ath11k_bw(txrate->bw);
 	nss = txrate->nss - 1;
 
 #define STATS_OP_FMT(name) tx_stats->stats[ATH11K_STATS_TYPE_##name]
-- 
2.20.1

