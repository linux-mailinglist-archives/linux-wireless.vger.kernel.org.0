Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6B794560E3
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Nov 2021 17:46:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233695AbhKRQtB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 18 Nov 2021 11:49:01 -0500
Received: from dispatch1-us1.ppe-hosted.com ([148.163.129.48]:46978 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233673AbhKRQtA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 18 Nov 2021 11:49:00 -0500
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.7.67.131])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 409ED1C0082
        for <linux-wireless@vger.kernel.org>; Thu, 18 Nov 2021 16:45:56 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 20299980089
        for <linux-wireless@vger.kernel.org>; Thu, 18 Nov 2021 16:45:56 +0000 (UTC)
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id 84D3713C2B1;
        Thu, 18 Nov 2021 08:45:55 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 84D3713C2B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1637253955;
        bh=SKK3/2AQBaAq4Jplt3Y73agwgKUMSxKhtdNoEuOsw2k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cUj1FT8mgSJTYTSHkGf+46VM+LK+/vJNm8ble6nzWIjhGRnJa4a+vbcjachkb/zgL
         44EjxEpnk+yvt59OR+4Gc45tGrnsy/84w2TX/RoKnPosBFAYftWEzAZyfUDrLW2Mrl
         2+IAKEiTf4oFssIBSU4rB8mBf5OXjFmqA0+iv5fs=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH 2/8] mt76: mt7915: allow processing TXS for 'NO_SKB' pkt-ids
Date:   Thu, 18 Nov 2021 08:45:43 -0800
Message-Id: <20211118164549.3863-2-greearb@candelatech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211118164549.3863-1-greearb@candelatech.com>
References: <20211118164549.3863-1-greearb@candelatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1637253956-4tSUU48wlLEA
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
 .../net/wireless/mediatek/mt76/mt7915/mac.c   | 38 +++++++++++--------
 1 file changed, 22 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 61ade279b35d..adc6d4ddbccf 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -1361,26 +1361,31 @@ mt7915_mac_add_txs_skb(struct mt7915_dev *dev, struct mt76_wcid *wcid, int pid,
 	struct ieee80211_tx_info *info;
 	struct sk_buff_head list;
 	struct rate_info rate = {};
-	struct sk_buff *skb;
+	struct sk_buff *skb = NULL;
+	bool check_status;
 	bool cck = false;
 	u32 txrate, txs, mode;
 
-	mt76_tx_status_lock(mdev, &list);
-	skb = mt76_tx_status_skb_get(mdev, wcid, pid, &list);
-	if (!skb)
-		goto out_no_skb;
+	check_status = (pid >= MT_PACKET_ID_FIRST);
+
+	if (check_status) {
+		mt76_tx_status_lock(mdev, &list);
+		skb = mt76_tx_status_skb_get(mdev, wcid, pid, &list);
+	}
 
 	txs = le32_to_cpu(txs_data[0]);
 
-	info = IEEE80211_SKB_CB(skb);
-	if (!(txs & MT_TXS0_ACK_ERROR_MASK))
-		info->flags |= IEEE80211_TX_STAT_ACK;
+	if (skb) {
+		info = IEEE80211_SKB_CB(skb);
+		if (!(txs & MT_TXS0_ACK_ERROR_MASK))
+			info->flags |= IEEE80211_TX_STAT_ACK;
 
-	info->status.ampdu_len = 1;
-	info->status.ampdu_ack_len = !!(info->flags &
-					IEEE80211_TX_STAT_ACK);
+		info->status.ampdu_len = 1;
+		info->status.ampdu_ack_len = !!(info->flags &
+						IEEE80211_TX_STAT_ACK);
 
-	info->status.rates[0].idx = -1;
+		info->status.rates[0].idx = -1;
+	}
 
 	txrate = FIELD_GET(MT_TXS0_TX_RATE, txs);
 
@@ -1467,10 +1472,11 @@ mt7915_mac_add_txs_skb(struct mt7915_dev *dev, struct mt76_wcid *wcid, int pid,
 	wcid->rate = rate;
 
 out:
-	mt76_tx_status_skb_done(mdev, skb, &list);
+	if (skb)
+		mt76_tx_status_skb_done(mdev, skb, &list);
 
-out_no_skb:
-	mt76_tx_status_unlock(mdev, &list);
+	if (check_status)
+		mt76_tx_status_unlock(mdev, &list);
 
 	return !!skb;
 }
@@ -1494,7 +1500,7 @@ static void mt7915_mac_add_txs(struct mt7915_dev *dev, void *data)
 	txs = le32_to_cpu(txs_data[3]);
 	pid = FIELD_GET(MT_TXS3_PID, txs);
 
-	if (pid < MT_PACKET_ID_FIRST)
+	if (pid < MT_PACKET_ID_NO_SKB)
 		return;
 
 	if (wcidx >= MT7915_WTBL_SIZE)
-- 
2.20.1

