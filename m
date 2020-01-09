Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 357F6135A07
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jan 2020 14:27:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729900AbgAIN1I (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 Jan 2020 08:27:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:51180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727861AbgAIN1I (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 Jan 2020 08:27:08 -0500
Received: from localhost.localdomain.com (mob-176-246-50-46.net.vodafone.it [176.246.50.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D609320661;
        Thu,  9 Jan 2020 13:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578576427;
        bh=5Dutj5SPgZdkqUE2Bxk1qhUQSr/44SA549RFqckrHbM=;
        h=From:To:Cc:Subject:Date:From;
        b=pLY4Kd37SM6Aigh14jddXrmGQ1bZWdDZRr1SyHlCg9+WmjE045ay6FuUYdfPFQcz1
         1Sc3NsaL7mstdCaxi8pAeRspWcqkkgAKXkAFkIoKTW8XWLmRod59fWPRZmQSRszIXi
         3JoPoy/5rYEu6HSawcS5DY5i58HZ1+QwuzzVXl6Y=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, ryder.lee@mediatek.com,
        linux-wireless@vger.kernel.org
Subject: [PATCH] mt76: mt7615: remove leftover routine declaration
Date:   Thu,  9 Jan 2020 14:26:53 +0100
Message-Id: <d3c445a6de21fd2d02e4ba8e1b972148140b0043.1578576181.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Get rid of mt76_dfs_start_rdd unused declaration

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
This patch is based on "mt76: mt7615: initialize radar specs from host driver"
https://patchwork.kernel.org/patch/11314021/
---
 drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index 963aa421c719..59059b7b66bb 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -333,7 +333,6 @@ void mt7615_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 void mt7615_mac_work(struct work_struct *work);
 void mt7615_txp_skb_unmap(struct mt76_dev *dev,
 			  struct mt76_txwi_cache *txwi);
-int mt76_dfs_start_rdd(struct mt7615_dev *dev, bool force);
 int mt7615_mcu_set_fcc5_lpn(struct mt7615_dev *dev, int val);
 int mt7615_mcu_set_pulse_th(struct mt7615_dev *dev,
 			    const struct mt7615_dfs_pulse *pulse);
-- 
2.21.1

