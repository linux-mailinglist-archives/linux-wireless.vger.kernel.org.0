Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39B403F21DB
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Aug 2021 22:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235310AbhHSUuk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Aug 2021 16:50:40 -0400
Received: from dispatch1-us1.ppe-hosted.com ([148.163.129.49]:52736 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235533AbhHSUuj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Aug 2021 16:50:39 -0400
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.7.67.132])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 7E46B1A0068
        for <linux-wireless@vger.kernel.org>; Thu, 19 Aug 2021 20:50:00 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 5CC76500077
        for <linux-wireless@vger.kernel.org>; Thu, 19 Aug 2021 20:50:00 +0000 (UTC)
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id D4AC513C2B5;
        Thu, 19 Aug 2021 13:49:55 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com D4AC513C2B5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1629406195;
        bh=1bEtj1Ib3f4Uf08FKQ7wd6mqy8Ya3kvyoEy3613pNao=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WmagER++JrFy13wOsOwx7zgmkDFNiGXsQu5gh/muXTZ5Sx12jrrx3u7UVwP10xtJH
         jENFDFUDNmSBjd5WjemD3VqPCiMIU7N7jFWjNoq2lKI6G0tWJs0nBgkbnS+rOGognx
         qFDgL1J6T4uefAQhuKgVd0Y2nEH7huIQy+vJ52b0=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH v8 4/9] mt76: mt7915:  allow processing TXS for 'NO_SKB' pkt-ids
Date:   Thu, 19 Aug 2021 13:49:45 -0700
Message-Id: <20210819204950.12150-4-greearb@candelatech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210819204950.12150-1-greearb@candelatech.com>
References: <20210819204950.12150-1-greearb@candelatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1629406201-gEFAqCX105eg
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
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 6f92e207680f..f6ed5d5febb7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -1430,10 +1430,16 @@ mt7915_mac_add_txs_skb(struct mt7915_dev *dev, struct mt76_wcid *wcid, int pid,
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
 
@@ -1447,7 +1453,8 @@ mt7915_mac_add_txs_skb(struct mt7915_dev *dev, struct mt76_wcid *wcid, int pid,
 	if (skb)
 		mt76_tx_status_skb_done(mdev, skb, &list, wcid);
 
-	mt76_tx_status_unlock(mdev, &list);
+	if (check_status)
+		mt76_tx_status_unlock(mdev, &list);
 }
 
 static void mt7915_mac_add_txs(struct mt7915_dev *dev, void *data)
@@ -1469,7 +1476,7 @@ static void mt7915_mac_add_txs(struct mt7915_dev *dev, void *data)
 	txs = le32_to_cpu(txs_data[3]);
 	pid = FIELD_GET(MT_TXS3_PID, txs);
 
-	if (pid < MT_PACKET_ID_FIRST)
+	if (pid < MT_PACKET_ID_NO_SKB)
 		return;
 
 	if (wcidx >= MT7915_WTBL_SIZE)
-- 
2.20.1

