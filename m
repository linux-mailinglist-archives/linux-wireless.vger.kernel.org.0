Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 004903D3D1D
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jul 2021 18:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230412AbhGWP0V (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 23 Jul 2021 11:26:21 -0400
Received: from dispatch1-us1.ppe-hosted.com ([67.231.154.164]:38840 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229655AbhGWP0V (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 23 Jul 2021 11:26:21 -0400
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.110.50.13])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 524DAA006D
        for <linux-wireless@vger.kernel.org>; Fri, 23 Jul 2021 16:06:53 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 2614E440078
        for <linux-wireless@vger.kernel.org>; Fri, 23 Jul 2021 16:06:53 +0000 (UTC)
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id E2AD513C2B5;
        Fri, 23 Jul 2021 09:06:32 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com E2AD513C2B5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1627056393;
        bh=216cxkfAnyP/OzDyDJqdvGQ8S/YaNDUUw/drdxBlVmo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dgcY/ysykfI8tvxRXEQ8tmNLglZsSHvTwqQsRUpKqk37L619KqCY3qJqd4b+u9o8a
         fmTALhhu4P8rsluruB9jR9R0EyrYg+LcH9flkhg7LiRcihECyRqqAV37Ix/vTkVBUZ
         STfLGpktYBa7lEp1JXBeVc4Z4N9BbMR1eoctR144=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH v3 04/11] mt76 - mt7915:  Allow processing TXS for 'NO_SKB' pkt-ids.
Date:   Fri, 23 Jul 2021 09:06:16 -0700
Message-Id: <20210723160623.14709-4-greearb@candelatech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210723160623.14709-1-greearb@candelatech.com>
References: <20210723160623.14709-1-greearb@candelatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1627056413-cBUf4XzlgYn7
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

This will let us update stats and wcid.rate for every TXS
callback we receive for a particular wcid.

For now, the TXS is not requested for NO_SKB frames, however.
That will be allowed in next patch.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 .../net/wireless/mediatek/mt76/mt7915/mac.c    | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index b1384e02e707..cf2c97bc251d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -1047,6 +1047,7 @@ void mt7915_mac_write_txwi(struct mt7915_dev *dev, __le32 *txwi,
 	txwi[4] = 0;
 
 	val = FIELD_PREP(MT_TXD5_PID, pid);
+	/* NOTE:  mt7916 does NOT request TXS for 'NO_SKB' frames by default. */
 	if (pid >= MT_PACKET_ID_FIRST)
 		val |= MT_TXD5_TX_STATUS_HOST;
 	txwi[5] = cpu_to_le32(val);
@@ -1437,10 +1438,16 @@ mt7915_mac_add_txs_skb(struct mt7915_dev *dev, struct mt76_wcid *wcid, int pid,
 	 * paired with TXS data.  This is normal datapath.
 	 */
 	struct rate_info *rate = &wcid->rate;
-	struct sk_buff *skb;
+	struct sk_buff *skb = NULL;
+	bool check_status;
 
-	mt76_tx_status_lock(mdev, &list);
-	skb = mt76_tx_status_skb_get(mdev, wcid, pid, &list);
+	check_status = ((pid >= MT_PACKET_ID_FIRST) ||
+			time_after(jiffies, mdev->next_status_jiffies));
+
+	if (check_status) {
+		mt76_tx_status_lock(mdev, &list);
+		skb = mt76_tx_status_skb_get(mdev, wcid, pid, &list);
+	}
 
 	memset(rate, 0, sizeof(*rate));
 
@@ -1454,7 +1461,8 @@ mt7915_mac_add_txs_skb(struct mt7915_dev *dev, struct mt76_wcid *wcid, int pid,
 	if (skb)
 		mt76_tx_status_skb_done(mdev, skb, &list, wcid);
 
-	mt76_tx_status_unlock(mdev, &list);
+	if (check_status)
+		mt76_tx_status_unlock(mdev, &list);
 }
 
 static void mt7915_mac_add_txs(struct mt7915_dev *dev, void *data)
@@ -1476,7 +1484,7 @@ static void mt7915_mac_add_txs(struct mt7915_dev *dev, void *data)
 	txs = le32_to_cpu(txs_data[3]);
 	pid = FIELD_GET(MT_TXS3_PID, txs);
 
-	if (pid < MT_PACKET_ID_FIRST)
+	if (pid < MT_PACKET_ID_NO_SKB)
 		return;
 
 	if (wcidx >= MT7915_WTBL_SIZE)
-- 
2.20.1

