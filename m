Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D071A158E6B
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2020 13:26:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728348AbgBKM0R (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Feb 2020 07:26:17 -0500
Received: from nbd.name ([46.4.11.11]:59476 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728355AbgBKM0R (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Feb 2020 07:26:17 -0500
Received: from [46.59.221.152] (helo=bertha.fritz.box)
        by ds12 with esmtpa (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1j1UcH-000356-04; Tue, 11 Feb 2020 13:26:13 +0100
From:   John Crispin <john@phrozen.org>
To:     Johannes Berg <johannes@sipsolutions.net>,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        John Crispin <john@phrozen.org>
Subject: [PATCH 1/2] mac80211: allow setting queue_len for drivers not using wake_tx_queue
Date:   Tue, 11 Feb 2020 13:26:04 +0100
Message-Id: <20200211122605.13002-1-john@phrozen.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Currently a mac80211 driver can only set the txq_limit when using
wake_tx_queue. Not all drivers use wake_tx_queue. This patch adds a new
element to wiphy allowing a driver to set a custom tx_queue_len and the
code that will apply it in case it is set. The current default is
1000 which is too low for ath11k when doing HE rates.

Signed-off-by: John Crispin <john@phrozen.org>
---
 include/net/cfg80211.h | 2 ++
 net/mac80211/iface.c   | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 0939645567e9..254080a04ee3 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -4742,6 +4742,8 @@ struct wiphy {
 	u32 txq_memory_limit;
 	u32 txq_quantum;
 
+	unsigned long tx_queue_len;
+
 	u8 support_mbssid:1,
 	   support_only_he_mbssid:1;
 
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 3c00408e9c8c..128b3468d13e 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -1834,6 +1834,10 @@ int ieee80211_if_add(struct ieee80211_local *local, const char *name,
 					if_setup, txqs, 1);
 		if (!ndev)
 			return -ENOMEM;
+
+		if (!local->ops->wake_tx_queue && local->hw.wiphy->tx_queue_len)
+			ndev->tx_queue_len = local->hw.wiphy->tx_queue_len;
+
 		dev_net_set(ndev, wiphy_net(local->hw.wiphy));
 
 		ndev->tstats = netdev_alloc_pcpu_stats(struct pcpu_sw_netstats);
-- 
2.20.1

