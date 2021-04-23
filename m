Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BDC336949D
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Apr 2021 16:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238664AbhDWO15 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 23 Apr 2021 10:27:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:48746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231220AbhDWO14 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 23 Apr 2021 10:27:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F0B3161464;
        Fri, 23 Apr 2021 14:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619188040;
        bh=bzEpUG9DtwoR6hryB1/VQuL1aDl3S1f0W3cgUrKLaRA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cDWveOk9baAuLixDQllNkV50W5X8sUgR9xzHAmb4d4UlZ25cP7LRHqHv+JIK5Dzef
         +f5daCtWtll9194WGhx52jYNDcYXkpu9Ko97K5LCvidWBKZgdXWUaCcly3XnaVFl2V
         5vBWYPyLY1/V6CQXFLx7H8gl9zRFgqhpYRAmUpR505I50rvxJeyUP4RSL+rrgDcSuM
         T05YKuVF1TQr31ycQDwUgt1iHnXdK6nhsbU5eSmfirToWKhJTXoeaOt4t7lMjB/8g4
         e0MBT5fVeoWk54OcQK8Qjr4nS/8Zg3nwwanWcg4VvJUfXSKy4OBC/0LJDa26i8V8AF
         j3LN86frohodQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, kvalo@codeaurora.org
Subject: [PATCH 1/3] mt76: mt7921: fix possible AOOB issue in mt7921_mcu_tx_rate_report
Date:   Fri, 23 Apr 2021 16:27:09 +0200
Message-Id: <91a1e8f6b6a3e6a929de560ed68132f6eb421720.1619187875.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1619187875.git.lorenzo@kernel.org>
References: <cover.1619187875.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix possible array out of bound access in mt7921_mcu_tx_rate_report.
Remove unnecessary varibable in mt7921_mcu_tx_rate_report

Fixes: 1c099ab44727c ("mt76: mt7921: add MCU support")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7921/mcu.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index 5f3d56d570a5..67dc4b4cc094 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -402,20 +402,22 @@ static void
 mt7921_mcu_tx_rate_report(struct mt7921_dev *dev, struct sk_buff *skb,
 			  u16 wlan_idx)
 {
-	struct mt7921_mcu_wlan_info_event *wtbl_info =
-		(struct mt7921_mcu_wlan_info_event *)(skb->data);
-	struct rate_info rate = {};
-	u8 curr_idx = wtbl_info->rate_info.rate_idx;
-	u16 curr = le16_to_cpu(wtbl_info->rate_info.rate[curr_idx]);
-	struct mt7921_mcu_peer_cap peer = wtbl_info->peer_cap;
+	struct mt7921_mcu_wlan_info_event *wtbl_info;
 	struct mt76_phy *mphy = &dev->mphy;
 	struct mt7921_sta_stats *stats;
+	struct rate_info rate = {};
 	struct mt7921_sta *msta;
 	struct mt76_wcid *wcid;
+	u8 idx;
 
 	if (wlan_idx >= MT76_N_WCIDS)
 		return;
 
+	wtbl_info = (struct mt7921_mcu_wlan_info_event *)skb->data;
+	idx = wtbl_info->rate_info.rate_idx;
+	if (idx >= ARRAY_SIZE(wtbl_info->rate_info.rate))
+		return;
+
 	rcu_read_lock();
 
 	wcid = rcu_dereference(dev->mt76.wcid[wlan_idx]);
@@ -426,7 +428,8 @@ mt7921_mcu_tx_rate_report(struct mt7921_dev *dev, struct sk_buff *skb,
 	stats = &msta->stats;
 
 	/* current rate */
-	mt7921_mcu_tx_rate_parse(mphy, &peer, &rate, curr);
+	mt7921_mcu_tx_rate_parse(mphy, &wtbl_info->peer_cap, &rate,
+				 le16_to_cpu(wtbl_info->rate_info.rate[idx]));
 	stats->tx_rate = rate;
 out:
 	rcu_read_unlock();
-- 
2.30.2

