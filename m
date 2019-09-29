Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10798C15FD
	for <lists+linux-wireless@lfdr.de>; Sun, 29 Sep 2019 17:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729039AbfI2Pqu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 29 Sep 2019 11:46:50 -0400
Received: from nbd.name ([46.4.11.11]:60944 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725948AbfI2Pqu (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 29 Sep 2019 11:46:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=pQj+MbErxLF/AoTx92UNgwkNq1oEtPrBNHakCtTqRfk=; b=r9MefCVK6LutKmAXMplSGmQuh7
        nWLZNLuDsb/cNrXT34M+zmpzhvUycsbRnL0+pl+26mnB3rKdsUtW3bfXifMtznU2umIdnlE/MQaar
        nW5E3X8nxijyh3lkkJ1IWS+dTX6BZMQMPClP4S8Dxo7IbaY/GIVb/Pv3BC2KhxMDH1sA=;
Received: from p5b20652d.dip0.t-ipconnect.de ([91.32.101.45] helo=maeck.lan)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1iEbPL-0002oS-Ge; Sun, 29 Sep 2019 17:46:47 +0200
Received: by maeck.lan (Postfix, from userid 501)
        id 4EAD769F606A; Sun, 29 Sep 2019 17:46:46 +0200 (CEST)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
Subject: [PATCH 1/2] mac80211: minstrel: remove divisions in tx status path
Date:   Sun, 29 Sep 2019 17:46:45 +0200
Message-Id: <20190929154646.90901-1-nbd@nbd.name>
X-Mailer: git-send-email 2.17.0
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Use a slightly different threshold for downgrading spatial streams to
make it easier to calculate without divisions.
Slightly reduces CPU overhead.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 net/mac80211/rc80211_minstrel.c    |  3 +--
 net/mac80211/rc80211_minstrel_ht.c | 10 ++++------
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/net/mac80211/rc80211_minstrel.c b/net/mac80211/rc80211_minstrel.c
index ee86c3333999..f73017e08111 100644
--- a/net/mac80211/rc80211_minstrel.c
+++ b/net/mac80211/rc80211_minstrel.c
@@ -289,8 +289,7 @@ minstrel_tx_status(void *priv, struct ieee80211_supported_band *sband,
 	if (mi->sample_deferred > 0)
 		mi->sample_deferred--;
 
-	if (time_after(jiffies, mi->last_stats_update +
-				(mp->update_interval * HZ) / 1000))
+	if (time_after(jiffies, mi->last_stats_update + mp->update_interval))
 		minstrel_update_stats(mp, mi);
 }
 
diff --git a/net/mac80211/rc80211_minstrel_ht.c b/net/mac80211/rc80211_minstrel_ht.c
index 0ef2633349b5..21c74b200269 100644
--- a/net/mac80211/rc80211_minstrel_ht.c
+++ b/net/mac80211/rc80211_minstrel_ht.c
@@ -970,23 +970,21 @@ minstrel_ht_tx_status(void *priv, struct ieee80211_supported_band *sband,
 		 */
 		rate = minstrel_get_ratestats(mi, mi->max_tp_rate[0]);
 		if (rate->attempts > 30 &&
-		    MINSTREL_FRAC(rate->success, rate->attempts) <
-		    MINSTREL_FRAC(20, 100)) {
+		    rate->success < rate->attempts / 4) {
 			minstrel_downgrade_rate(mi, &mi->max_tp_rate[0], true);
 			update = true;
 		}
 
 		rate2 = minstrel_get_ratestats(mi, mi->max_tp_rate[1]);
 		if (rate2->attempts > 30 &&
-		    MINSTREL_FRAC(rate2->success, rate2->attempts) <
-		    MINSTREL_FRAC(20, 100)) {
+		    rate2->success < rate2->attempts / 4) {
 			minstrel_downgrade_rate(mi, &mi->max_tp_rate[1], false);
 			update = true;
 		}
 	}
 
 	if (time_after(jiffies, mi->last_stats_update +
-				(mp->update_interval / 2 * HZ) / 1000)) {
+				mp->update_interval / 2)) {
 		update = true;
 		minstrel_ht_update_stats(mp, mi, true);
 	}
@@ -1666,7 +1664,7 @@ minstrel_ht_alloc(struct ieee80211_hw *hw, struct dentry *debugfsdir)
 		mp->has_mrr = true;
 
 	mp->hw = hw;
-	mp->update_interval = 100;
+	mp->update_interval = HZ / 10;
 
 #ifdef CONFIG_MAC80211_DEBUGFS
 	mp->fixed_rate_idx = (u32) -1;
-- 
2.17.0

