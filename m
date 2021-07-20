Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE9A83D01A9
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jul 2021 20:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232712AbhGTRq2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Jul 2021 13:46:28 -0400
Received: from dispatch1-us1.ppe-hosted.com ([148.163.129.49]:46630 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234863AbhGTRmi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Jul 2021 13:42:38 -0400
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.7.64.31])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 28EA12006C
        for <linux-wireless@vger.kernel.org>; Tue, 20 Jul 2021 18:23:01 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 03A04600079
        for <linux-wireless@vger.kernel.org>; Tue, 20 Jul 2021 18:23:00 +0000 (UTC)
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id A7B5913C2B5;
        Tue, 20 Jul 2021 11:23:00 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com A7B5913C2B5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1626805380;
        bh=2UauqE3f7Cam0vwROvYDo6iV1RUP1TvRA8VFULOqqMQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fi6p/evSfYg3b4ui/cTKgeRT0z+kfiH+9AsAHAWYIt50XwcilotlKYBnkxLpB8UzO
         8t2vKbVRcTcWAgadNGq02utrVqx4gQTGwndx7mWnmW4BfIh/5AJaBhzNyjw2JO+OYG
         JHopNvOW22+aLzPG0yNz9M3VUPSAJGlr9w3flzeQ=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH 04/11] mt76 - mt7915:  Allow processing TXS for 'NO_SKB' pkt-ids.
Date:   Tue, 20 Jul 2021 11:22:48 -0700
Message-Id: <20210720182256.30536-4-greearb@candelatech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210720182256.30536-1-greearb@candelatech.com>
References: <20210720182256.30536-1-greearb@candelatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1626805381-CUsEQuSYUZAs
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
index 0dcbe7403831..84be95c9b65a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -1048,6 +1048,7 @@ void mt7915_mac_write_txwi(struct mt7915_dev *dev, __le32 *txwi,
 	txwi[4] = 0;
 
 	val = FIELD_PREP(MT_TXD5_PID, pid);
+        /* NOTE:  mt7916 does NOT request TXS for 'NO_SKB' frames by default. */
 	if (pid >= MT_PACKET_ID_FIRST)
 		val |= MT_TXD5_TX_STATUS_HOST;
 	txwi[5] = cpu_to_le32(val);
@@ -1431,10 +1432,16 @@ mt7915_mac_add_txs_skb(struct mt7915_dev *dev, struct mt76_wcid *wcid, int pid,
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
 
@@ -1448,7 +1455,8 @@ mt7915_mac_add_txs_skb(struct mt7915_dev *dev, struct mt76_wcid *wcid, int pid,
 	if (skb)
 		mt76_tx_status_skb_done(mdev, skb, &list, wcid);
 
-	mt76_tx_status_unlock(mdev, &list);
+	if (check_status)
+		mt76_tx_status_unlock(mdev, &list);
 }
 
 static void mt7915_mac_add_txs(struct mt7915_dev *dev, void *data)
@@ -1470,7 +1478,7 @@ static void mt7915_mac_add_txs(struct mt7915_dev *dev, void *data)
 	txs = le32_to_cpu(txs_data[3]);
 	pid = FIELD_GET(MT_TXS3_PID, txs);
 
-	if (pid < MT_PACKET_ID_FIRST)
+	if (pid < MT_PACKET_ID_NO_SKB)
 		return;
 
 	if (wcidx >= MT7915_WTBL_SIZE)
-- 
2.20.1

