Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D51A4B6CCF
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Feb 2022 13:58:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235480AbiBOM6V (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 15 Feb 2022 07:58:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233460AbiBOM6U (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 15 Feb 2022 07:58:20 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 951976D84E
        for <linux-wireless@vger.kernel.org>; Tue, 15 Feb 2022 04:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=7LvKglReSTh4y7oDa0HipqMwhaVfqLHknTKkCB4eOz0=; b=I/380slJmM2gtX4P2l9ApuK4fn
        OL0uIAkQHNXUfGb6TDL1ttNQK8hB8blWt1nM+m7Nrq1AWI0XgHLQoLShufKjnORnq9ZshdUmycOcY
        SMOhV2/6zwS+22ed+XRFTnRuYqgh4U/YinfN87QPfWDuPleqpEPC1KcNa2QVs8a/4/YQ=;
Received: from p200300daa7140c00dd8883896a7868c3.dip0.t-ipconnect.de ([2003:da:a714:c00:dd88:8389:6a78:68c3] helo=Maecks.lan)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1nJxPE-0004E9-Nc
        for linux-wireless@vger.kernel.org; Tue, 15 Feb 2022 13:58:08 +0100
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH] mt76: improve signal strength reporting
Date:   Tue, 15 Feb 2022 13:58:08 +0100
Message-Id: <20220215125808.72378-1-nbd@nbd.name>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Instead of just taking the maximum per-chain signal strength values,
add an approximation for the sum of the combined signal.
This should more accurately reflect the real signal strength, especially
if the per-chain signal strength values are close to each other

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c | 32 +++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7603/mac.c   |  5 ---
 .../net/wireless/mediatek/mt76/mt7615/mac.c   |  9 ------
 .../net/wireless/mediatek/mt76/mt76x02_mac.c  |  2 --
 .../net/wireless/mediatek/mt76/mt7915/mac.c   | 11 +------
 .../net/wireless/mediatek/mt76/mt7921/mac.c   |  3 --
 6 files changed, 33 insertions(+), 29 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index a4bb281a74e6..9796419c99e1 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -932,6 +932,35 @@ void mt76_wcid_key_setup(struct mt76_dev *dev, struct mt76_wcid *wcid,
 }
 EXPORT_SYMBOL(mt76_wcid_key_setup);
 
+static int
+mt76_rx_signal(struct mt76_rx_status *status)
+{
+	s8 *chain_signal = status->chain_signal;
+	int signal = -128;
+	u8 chains;
+
+	for (chains = status->chains; chains; chains >>= 1, chain_signal++) {
+		int cur, diff;
+
+		if (!(chains & BIT(0)))
+			continue;
+
+		cur = *chain_signal;
+		if (cur > signal)
+			swap(cur, signal);
+
+		diff = signal - cur;
+		if (diff == 0)
+			signal += 3;
+		else if (diff <= 2)
+			signal += 2;
+		else if (diff <= 6)
+			signal += 1;
+	}
+
+	return signal;
+}
+
 static void
 mt76_rx_convert(struct mt76_dev *dev, struct sk_buff *skb,
 		struct ieee80211_hw **hw,
@@ -960,6 +989,9 @@ mt76_rx_convert(struct mt76_dev *dev, struct sk_buff *skb,
 	status->ampdu_reference = mstat.ampdu_ref;
 	status->device_timestamp = mstat.timestamp;
 	status->mactime = mstat.timestamp;
+	status->signal = mt76_rx_signal(&mstat);
+	if (status->signal <= -128)
+		status->flag |= RX_FLAG_NO_SIGNAL_VAL;
 
 	if (ieee80211_is_beacon(hdr->frame_control) ||
 	    ieee80211_is_probe_resp(hdr->frame_control))
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
index a272d64808c3..2e5d26616bc2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
@@ -643,11 +643,6 @@ mt7603_mac_fill_rx(struct mt7603_dev *dev, struct sk_buff *skb)
 		status->chain_signal[1] = FIELD_GET(MT_RXV4_IB_RSSI1, rxdg3) +
 					  dev->rssi_offset[1];
 
-		status->signal = status->chain_signal[0];
-		if (status->chains & BIT(1))
-			status->signal = max(status->signal,
-					     status->chain_signal[1]);
-
 		if (FIELD_GET(MT_RXV1_FRAME_MODE, rxdg0) == 1)
 			status->bw = RATE_INFO_BW_40;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index 13109864b6d6..d1d87240f24f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -576,15 +576,6 @@ static int mt7615_mac_fill_rx(struct mt7615_dev *dev, struct sk_buff *skb)
 		status->chain_signal[1] = to_rssi(MT_RXV4_RCPI1, rxdg3);
 		status->chain_signal[2] = to_rssi(MT_RXV4_RCPI2, rxdg3);
 		status->chain_signal[3] = to_rssi(MT_RXV4_RCPI3, rxdg3);
-		status->signal = status->chain_signal[0];
-
-		for (i = 1; i < hweight8(mphy->antenna_mask); i++) {
-			if (!(status->chains & BIT(i)))
-				continue;
-
-			status->signal = max(status->signal,
-					     status->chain_signal[i]);
-		}
 
 		mt7615_mac_fill_tm_rx(mphy->priv, rxd);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
index dc2aeaab72ec..2afad8c76ca6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
@@ -860,9 +860,7 @@ int mt76x02_mac_process_rx(struct mt76x02_dev *dev, struct sk_buff *skb,
 		status->chain_signal[1] = mt76x02_mac_get_rssi(dev,
 							       rxwi->rssi[1],
 							       1);
-		signal = max_t(s8, signal, status->chain_signal[1]);
 	}
-	status->signal = signal;
 	status->freq = dev->mphy.chandef.chan->center_freq;
 	status->band = dev->mphy.chandef.chan->band;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index e64afa2f181d..06186c034d93 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -593,7 +593,7 @@ mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_buff *skb)
 	u16 seq_ctrl = 0;
 	u8 qos_ctl = 0;
 	__le16 fc = 0;
-	int i, idx;
+	int idx;
 
 	memset(status, 0, sizeof(*status));
 
@@ -753,15 +753,6 @@ mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_buff *skb)
 		status->chain_signal[1] = to_rssi(MT_PRXV_RCPI1, v1);
 		status->chain_signal[2] = to_rssi(MT_PRXV_RCPI2, v1);
 		status->chain_signal[3] = to_rssi(MT_PRXV_RCPI3, v1);
-		status->signal = status->chain_signal[0];
-
-		for (i = 1; i < hweight8(mphy->antenna_mask); i++) {
-			if (!(status->chains & BIT(i)))
-				continue;
-
-			status->signal = max(status->signal,
-					     status->chain_signal[i]);
-		}
 
 		/* RXD Group 5 - C-RXV */
 		if (rxd1 & MT_RXD1_NORMAL_GROUP_5) {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index 8e88445102ab..0a6c269a2fb6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -670,9 +670,6 @@ mt7921_mac_fill_rx(struct mt7921_dev *dev, struct sk_buff *skb)
 					     status->chain_signal[i]);
 		}
 
-		if (status->signal == -128)
-			status->flag |= RX_FLAG_NO_SIGNAL_VAL;
-
 		stbc = FIELD_GET(MT_PRXV_STBC, v0);
 		gi = FIELD_GET(MT_PRXV_SGI, v0);
 		cck = false;
-- 
2.32.0 (Apple Git-132)

