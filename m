Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96EA57D73D7
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Oct 2023 21:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234855AbjJYTEI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 25 Oct 2023 15:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233876AbjJYTEF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 25 Oct 2023 15:04:05 -0400
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56C95138
        for <linux-wireless@vger.kernel.org>; Wed, 25 Oct 2023 12:04:02 -0700 (PDT)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id C97793C0069
        for <linux-wireless@vger.kernel.org>; Wed, 25 Oct 2023 19:04:00 +0000 (UTC)
Received: from ben-dt5.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id 45D4B13C2B4;
        Wed, 25 Oct 2023 12:04:00 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 45D4B13C2B4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1698260640;
        bh=lgYpajGmf9M8knFdLSrg8ZriqOkDnm2hESLroq/5jfk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HmMTl3Nfjz2i168RvmRepFFwwoC9xpriXHWM8f/7pRz9W8H3C8in8hLQrFALODP/z
         zNm7rdHLU2sGsKJ2eT523E3GpkdxNFQ4m82Py27IHw1NNNqc0JG1SyHgDBptujTLei
         AWNJyGfM+9lb4u0RT3FsbvQfZ3mqTwyCZEo2vMnU=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH 04/12] wifi: mt76: mt7915: debugfs hook to enable TXS for NO_SKB pkt-ids
Date:   Wed, 25 Oct 2023 12:03:46 -0700
Message-Id: <20231025190351.2141832-4-greearb@candelatech.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20231025190351.2141832-1-greearb@candelatech.com>
References: <20231025190351.2141832-1-greearb@candelatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1698260641-ZQRLQ4kkwTrz
X-MDID-O: us5;at1;1698260641;ZQRLQ4kkwTrz;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

This lets user turn on/off this feature.  Enabling gives better
tx-rate related stats, but will cause extra driver and (maybe)
firmware work.  Not sure if it actually affects performance or
not.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 drivers/net/wireless/mediatek/mt76/debugfs.c  | 25 +++++++++++++++++++
 drivers/net/wireless/mediatek/mt76/mt76.h     |  6 +++++
 .../wireless/mediatek/mt76/mt76_connac_mac.c  |  3 ++-
 3 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/debugfs.c b/drivers/net/wireless/mediatek/mt76/debugfs.c
index 8012732e3bb8..7d92cfb0a501 100644
--- a/drivers/net/wireless/mediatek/mt76/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/debugfs.c
@@ -89,6 +89,30 @@ static int mt76_rx_queues_read(struct seq_file *s, void *data)
 	return 0;
 }
 
+static int
+mt7915_txs_for_no_skb_set(void *data, u64 val)
+{
+	struct mt76_dev *dev = data;
+
+	dev->txs_for_no_skb_enabled = !!val;
+
+	return 0;
+}
+
+static int
+mt7915_txs_for_no_skb_get(void *data, u64 *val)
+{
+	struct mt76_dev *dev = data;
+
+	*val = dev->txs_for_no_skb_enabled;
+
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(fops_txs_for_no_skb, mt7915_txs_for_no_skb_get,
+			 mt7915_txs_for_no_skb_set, "%lld\n");
+
+
 void mt76_seq_puts_array(struct seq_file *file, const char *str,
 			 s8 *val, int len)
 {
@@ -116,6 +140,7 @@ mt76_register_debugfs_fops(struct mt76_phy *phy,
 	debugfs_create_file_unsafe("regval", 0600, dir, dev, fops);
 	debugfs_create_file_unsafe("napi_threaded", 0600, dir, dev,
 				   &fops_napi_threaded);
+	debugfs_create_file("force_txs", 0600, dir, dev, &fops_txs_for_no_skb);
 	debugfs_create_blob("eeprom", 0400, dir, &dev->eeprom);
 	if (dev->otp.data)
 		debugfs_create_blob("otp", 0400, dir, &dev->otp);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 9b30d4aab952..d00a2da8d2f1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -860,6 +860,12 @@ struct mt76_dev {
 
 	u8 csa_complete;
 
+	/* Should we request TXS for MT_PACKET_ID_NO_SKB?  Doing so gives better
+	 * costs but causes a great deal more TXS packet processing by driver and
+	 * creation by firmware, so may be a performance drag.
+	 */
+	bool txs_for_no_skb_enabled;
+
 	u32 rxfilter;
 
 #ifdef CONFIG_NL80211_TESTMODE
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
index c080b60327b1..ab9a4d9fecdb 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
@@ -541,7 +541,8 @@ void mt76_connac2_mac_write_txwi(struct mt76_dev *dev, __le32 *txwi,
 	txwi[4] = 0;
 
 	val = FIELD_PREP(MT_TXD5_PID, pid);
-	if (pid >= MT_PACKET_ID_FIRST) {
+	if (pid >= MT_PACKET_ID_FIRST ||
+	    (pid == MT_PACKET_ID_NO_SKB && dev->txs_for_no_skb_enabled)) {
 		val |= MT_TXD5_TX_STATUS_HOST;
 		amsdu_en = amsdu_en && !is_mt7921(dev);
 	}
-- 
2.40.0

