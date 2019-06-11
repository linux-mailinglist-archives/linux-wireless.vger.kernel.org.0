Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3F2F3C45F
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jun 2019 08:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403786AbfFKGjD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Jun 2019 02:39:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:37030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390485AbfFKGjD (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Jun 2019 02:39:03 -0400
Received: from localhost.localdomain (unknown [151.66.40.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BCC1E2089E;
        Tue, 11 Jun 2019 06:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560235142;
        bh=NnEMS8VZvTXWr/rwMscqIAAkFrGcBY6jyD5d5phAZFU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nb3AhmHQlFWveS+b9391H4SSKMzCJhNy91ZDVu8ow+npUHfS+drhE9j+AIxP+DXxe
         BjEZ5cIafGvqp06dYBaAtWbQwh2OdIoDKWgu4rqQTrQkOCjkr23Ir7kNjruWLwaPuD
         NiNDwi7FiricAWBqBLr6GIr+ErJLH54nh6dJtwW0=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, royluo@google.com
Subject: [PATCH 1/2] mt76: mt7615: init per-channel target power
Date:   Tue, 11 Jun 2019 08:38:52 +0200
Message-Id: <ade300b855949dcbe0a278e363415bd56b2e1299.1560234877.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1560234876.git.lorenzo@kernel.org>
References: <cover.1560234876.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Set per-channel target power as the minimum between the regulatory
tx power and the value configured in the eeprom

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7615/init.c  | 43 +++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
index 693e597a3230..3f826e4f1cd6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
@@ -165,6 +165,46 @@ static int mt7615_init_debugfs(struct mt7615_dev *dev)
 	return 0;
 }
 
+static void
+mt7615_init_txpower(struct mt7615_dev *dev,
+		    struct ieee80211_supported_band *sband)
+{
+	int i, n_chains = hweight8(dev->mt76.antenna_mask);
+	u8 *eep = (u8 *)dev->mt76.eeprom.data;
+
+	for (i = 0; i < sband->n_channels; i++) {
+		struct ieee80211_channel *chan = &sband->channels[i];
+		u8 target_power = 0;
+		int j;
+
+		for (j = 0; j < n_chains; j++) {
+			int index;
+
+			index = mt7615_eeprom_get_power_index(chan, j);
+			target_power = max(target_power, eep[index]);
+		}
+
+		target_power = DIV_ROUND_UP(target_power, 2);
+		switch (n_chains) {
+		case 4:
+			target_power += 6;
+			break;
+		case 3:
+			target_power += 4;
+			break;
+		case 2:
+			target_power += 3;
+			break;
+		default:
+			break;
+		}
+
+		chan->max_power = min_t(int, chan->max_reg_power,
+					target_power);
+		chan->orig_mpwr = target_power;
+	}
+}
+
 int mt7615_register_device(struct mt7615_dev *dev)
 {
 	struct ieee80211_hw *hw = mt76_hw(dev);
@@ -212,6 +252,9 @@ int mt7615_register_device(struct mt7615_dev *dev)
 	if (ret)
 		return ret;
 
+	mt7615_init_txpower(dev, &dev->mt76.sband_2g.sband);
+	mt7615_init_txpower(dev, &dev->mt76.sband_5g.sband);
+
 	hw->max_tx_fragments = MT_TXP_MAX_BUF_NUM;
 
 	return mt7615_init_debugfs(dev);
-- 
2.21.0

