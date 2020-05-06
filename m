Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 927C21C6DC0
	for <lists+linux-wireless@lfdr.de>; Wed,  6 May 2020 11:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729255AbgEFJzz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 6 May 2020 05:55:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:56574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729084AbgEFJzz (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 6 May 2020 05:55:55 -0400
Received: from localhost.localdomain.com (unknown [151.48.155.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9CB3020753;
        Wed,  6 May 2020 09:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588758954;
        bh=YD4DMNr1yHZPIipOrEnMm7bnXE3vfPRPPws1SqKjxyM=;
        h=From:To:Cc:Subject:Date:From;
        b=X6mdGeI5ChUfVpxHlYonIuxM0+q19DILwq4xrzonMLQmqVPMwFfo7tNg1UYVcxOIX
         sdILrNVDDpCSRWL9F1T7yC3gVT+19G+gX7qd4yWcSUb0kraRhaUjKFXw/VPmC231JC
         P+MZWpQSE79/rL6gQGt50J4pqsC44rHWukakOcYM=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com
Subject: [PATCH] mt76: mt7663: add support to sched scan with randomise addr
Date:   Wed,  6 May 2020 11:55:42 +0200
Message-Id: <9ff4b5dfa487c7d32cb46988fbcb09e0fef1e9de.1588758914.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Add support to sched scan with randomise addr

Co-developed-by: Wan-Feng Jiang <Wan-Feng.Jiang@mediatek.com>
Signed-off-by: Wan-Feng Jiang <Wan-Feng.Jiang@mediatek.com>
Co-developed-by: Soul Huang <Soul.Huang@mediatek.com>
Signed-off-by: Soul Huang <Soul.Huang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/init.c | 3 ++-
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c  | 7 ++++++-
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.h  | 5 +++--
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
index 1d49d65d1acd..37fc70197f92 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
@@ -139,7 +139,8 @@ void mt7615_check_offload_capability(struct mt7615_dev *dev)
 		ieee80211_hw_set(hw, SUPPORTS_PS);
 		ieee80211_hw_set(hw, SUPPORTS_DYNAMIC_PS);
 
-		wiphy->features |= NL80211_FEATURE_SCAN_RANDOM_MAC_ADDR;
+		wiphy->features |= NL80211_FEATURE_SCHED_SCAN_RANDOM_MAC_ADDR |
+				   NL80211_FEATURE_SCAN_RANDOM_MAC_ADDR;
 	} else {
 		dev->ops->hw_scan = NULL;
 		dev->ops->cancel_hw_scan = NULL;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 89fadff44fa4..96bf39a4a3da 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -2907,7 +2907,12 @@ int mt7615_mcu_sched_scan_req(struct mt7615_phy *phy,
 	req = (struct mt7615_sched_scan_req *)skb_put(skb, sizeof(*req));
 	req->version = 1;
 	req->seq_num = mvif->scan_seq_num | ext_phy << 7;
-	req->scan_func = !!(sreq->flags & NL80211_SCAN_FLAG_RANDOM_ADDR);
+
+	if (sreq->flags & NL80211_SCAN_FLAG_RANDOM_ADDR) {
+		get_random_mask_addr(req->random_mac, sreq->mac_addr,
+				     sreq->mac_addr_mask);
+		req->scan_func = 1;
+	}
 
 	req->ssids_num = sreq->n_ssids;
 	for (i = 0; i < req->ssids_num; i++) {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
index 737ccec6dd96..0f12e6da89af 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
@@ -405,10 +405,11 @@ struct mt7615_sched_scan_req {
 	u8 channel_type;
 	u8 channels_num;
 	u8 intervals_num;
-	u8 scan_func;
+	u8 scan_func; /* BIT(0) eable random mac address */
 	struct mt7615_mcu_scan_channel channels[64];
 	__le16 intervals[MT7615_MAX_SCHED_SCAN_INTERVAL];
-	u8 pad2[64];
+	u8 random_mac[ETH_ALEN]; /* valid when BIT(0) in scan_func is set */
+	u8 pad2[58];
 } __packed;
 
 struct nt7615_sched_scan_done {
-- 
2.26.2

