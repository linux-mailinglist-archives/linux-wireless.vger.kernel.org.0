Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 377FC55A7A
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jun 2019 00:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbfFYWBx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Jun 2019 18:01:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:37548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726287AbfFYWBx (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Jun 2019 18:01:53 -0400
Received: from lore-desk-wlan.lan (unknown [151.66.61.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8C742080C;
        Tue, 25 Jun 2019 22:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561500112;
        bh=UoBYvM55ZkxZSZEIRWLVjxw+oh4kvjrXUR3Y49Liqws=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E00tR+sZUTSdFhL1SZYk+BRPpz3OavWwJHDtJc/MH/cxFDcePsmLmc/1MOhW42lfI
         iLiA/BlASDvWY2cJlEpbHmJZTMRMU/Jb6NENLL9VYA1l59BdjLEHhLOaq7Czqweaiw
         O4vRryYq4VJL2COGY8mAnw+bP6GKFKCsr+VTinMM=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, royluo@google.com, yf.luo@mediatek.com
Subject: [RFC 3/5] mt76: mt7615: do not perform txcalibration before cac is complited
Date:   Wed, 26 Jun 2019 00:01:24 +0200
Message-Id: <98dd82966b4f468553ebbb6ebf41f7921c2be38b.1561499275.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1561499275.git.lorenzo@kernel.org>
References: <cover.1561499275.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Delay channel calibration after Channel Availability Check. Add some
code cleanup to mt7615_mcu_set_channel

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 25 +++++++++++--------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index c0fd0ad805b5..31bdab1b5df6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -1279,7 +1279,8 @@ int mt7615_mcu_rdd_cmd(struct mt7615_dev *dev,
 
 int mt7615_mcu_set_channel(struct mt7615_dev *dev)
 {
-	struct cfg80211_chan_def *chdef = &dev->mt76.chandef;
+	struct cfg80211_chan_def *chandef = &dev->mt76.chandef;
+	int freq1 = chandef->center_freq1, freq2 = chandef->center_freq2;
 	struct {
 		u8 control_chan;
 		u8 center_chan;
@@ -1298,17 +1299,20 @@ int mt7615_mcu_set_channel(struct mt7615_dev *dev)
 		u8 rsv1[3];
 		u8 txpower_sku[53];
 		u8 rsv2[3];
-	} req = {0};
+	} req = {
+		.control_chan = chandef->chan->hw_value,
+		.center_chan = ieee80211_frequency_to_channel(freq1),
+		.tx_streams = (dev->mt76.chainmask >> 8) & 0xf,
+		.rx_streams_mask = dev->mt76.antenna_mask,
+		.center_chan2 = ieee80211_frequency_to_channel(freq2),
+	};
 	int ret;
 
-	req.control_chan = chdef->chan->hw_value;
-	req.center_chan = ieee80211_frequency_to_channel(chdef->center_freq1);
-	req.tx_streams = (dev->mt76.chainmask >> 8) & 0xf;
-	req.rx_streams_mask = dev->mt76.antenna_mask;
-	req.switch_reason = CH_SWITCH_NORMAL;
-	req.band_idx = 0;
-	req.center_chan2 = ieee80211_frequency_to_channel(chdef->center_freq2);
-	req.txpower_drop = 0;
+	if ((chandef->chan->flags & IEEE80211_CHAN_RADAR) &&
+	    chandef->chan->dfs_state != NL80211_DFS_AVAILABLE)
+		req.switch_reason = CH_SWITCH_DFS;
+	else
+		req.switch_reason = CH_SWITCH_NORMAL;
 
 	switch (dev->mt76.chandef.width) {
 	case NL80211_CHAN_WIDTH_40:
@@ -1333,6 +1337,7 @@ int mt7615_mcu_set_channel(struct mt7615_dev *dev)
 	case NL80211_CHAN_WIDTH_20:
 	default:
 		req.bw = CMD_CBW_20MHZ;
+		break;
 	}
 	memset(req.txpower_sku, 0x3f, 49);
 
-- 
2.21.0

