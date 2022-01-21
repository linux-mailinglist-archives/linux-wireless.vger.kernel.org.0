Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F293A496615
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jan 2022 20:55:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232969AbiAUTzw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 21 Jan 2022 14:55:52 -0500
Received: from dispatch1-us1.ppe-hosted.com ([148.163.129.48]:36470 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232933AbiAUTzv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 21 Jan 2022 14:55:51 -0500
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.7.67.119])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 5A2351C0082
        for <linux-wireless@vger.kernel.org>; Fri, 21 Jan 2022 19:55:50 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 38A787C007C
        for <linux-wireless@vger.kernel.org>; Fri, 21 Jan 2022 19:55:50 +0000 (UTC)
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id AC80313C2B0;
        Fri, 21 Jan 2022 11:55:49 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com AC80313C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1642794949;
        bh=U/pFmYzQKZ+/bFOW6PqGZmd3hPtOTb2xao27uFn586s=;
        h=From:To:Cc:Subject:Date:From;
        b=QF1YcvPeajgn6co9qsNPUetBC94hYpFIh3gzvqA5xA1gh/fXgxvFImvFw6EetDBI4
         yFG63V4ACTtbjMZTj6AoomRZ1M9Lr5HbHj40yRl7ZLp5zF3onjRw43A1PKlU0PV+pu
         4E3RfWOmOLQmbat9Ozd6VRRtfbY0Dovh7tnJNNww=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH] mt76:  Ensure sale skb status list is processed.
Date:   Fri, 21 Jan 2022 11:55:48 -0800
Message-Id: <20220121195548.17476-1-greearb@candelatech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1642794950-kGYxSTXW-5tf
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

The old code might not ever run the stale skb status processing
list, so change it to ensure the stale entries are cleaned up
regularly.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 drivers/net/wireless/mediatek/mt76/mt76.h |  1 +
 drivers/net/wireless/mediatek/mt76/tx.c   | 24 +++++++++++++++++------
 2 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 37d82d806c09..bfb68788251f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -271,6 +271,7 @@ struct mt76_wcid {
 
 	struct list_head list;
 	struct idr pktid;
+	unsigned long last_idr_check_at; /* in jiffies */
 };
 
 struct mt76_txq {
diff --git a/drivers/net/wireless/mediatek/mt76/tx.c b/drivers/net/wireless/mediatek/mt76/tx.c
index 938353ac272f..b6f0d74fd563 100644
--- a/drivers/net/wireless/mediatek/mt76/tx.c
+++ b/drivers/net/wireless/mediatek/mt76/tx.c
@@ -157,24 +157,35 @@ mt76_tx_status_skb_get(struct mt76_dev *dev, struct mt76_wcid *wcid, int pktid,
 		       struct sk_buff_head *list)
 {
 	struct sk_buff *skb;
+	struct sk_buff *skb2;
 	int id;
+	/* Check twice as often as the timeout value so that we mitigate
+	 * worse-case timeout detection (where we do the check right before
+	 * the per skb timer would have expired and so have to wait another interval
+	 * to detect the skb status timeout.)
+	 */
+	static const int check_interval = MT_TX_STATUS_SKB_TIMEOUT / 2;
 
 	lockdep_assert_held(&dev->status_lock);
 
 	skb = idr_remove(&wcid->pktid, pktid);
-	if (skb)
+
+	/* If we have not checked for stale entries recently,
+	 * then do that check now.
+	 */
+	if (time_is_after_jiffies(wcid->last_idr_check_at + check_interval))
 		goto out;
 
 	/* look for stale entries in the wcid idr queue */
-	idr_for_each_entry(&wcid->pktid, skb, id) {
-		struct mt76_tx_cb *cb = mt76_tx_skb_cb(skb);
+	idr_for_each_entry(&wcid->pktid, skb2, id) {
+		struct mt76_tx_cb *cb = mt76_tx_skb_cb(skb2);
 
 		if (pktid >= 0) {
 			if (!(cb->flags & MT_TX_CB_DMA_DONE))
 				continue;
 
 			if (time_is_after_jiffies(cb->jiffies +
-						   MT_TX_STATUS_SKB_TIMEOUT))
+						  MT_TX_STATUS_SKB_TIMEOUT))
 				continue;
 		}
 
@@ -182,9 +193,10 @@ mt76_tx_status_skb_get(struct mt76_dev *dev, struct mt76_wcid *wcid, int pktid,
 		 * and stop waiting for TXS callback.
 		 */
 		idr_remove(&wcid->pktid, cb->pktid);
-		__mt76_tx_status_skb_done(dev, skb, MT_TX_CB_TXS_FAILED |
-						    MT_TX_CB_TXS_DONE, list);
+		__mt76_tx_status_skb_done(dev, skb2, MT_TX_CB_TXS_FAILED |
+					  MT_TX_CB_TXS_DONE, list);
 	}
+	wcid->last_idr_check_at = jiffies;
 
 out:
 	if (idr_is_empty(&wcid->pktid))
-- 
2.20.1

