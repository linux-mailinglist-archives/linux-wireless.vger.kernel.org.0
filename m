Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF2CB4D7554
	for <lists+linux-wireless@lfdr.de>; Sun, 13 Mar 2022 13:49:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233831AbiCMMul (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 13 Mar 2022 08:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233751AbiCMMui (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 13 Mar 2022 08:50:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC5170330
        for <linux-wireless@vger.kernel.org>; Sun, 13 Mar 2022 05:49:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D88CEB80CA6
        for <linux-wireless@vger.kernel.org>; Sun, 13 Mar 2022 12:49:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17DEBC340E8;
        Sun, 13 Mar 2022 12:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647175768;
        bh=7adOgiLt2r66OQbWnreCRQ/NSVnIjZDWQcWzyT/CjsI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U+M8TbcYfMkT2rA95e6Wz+B7zf7wUO+/1w4bpiJC/fd6ZWnl1Y68nTihu769xHRjf
         7aSeH5ewKsCQhUU3LVaZ0i5OKvxbwFVz8cFsnv8sIFRza6D+qWnFt4ZJf4BvdIxjnO
         UbsK7yusV5GZ4vP41pw7xaudKTk0VtekdLbYeNc1cn4Ys/xgJW28nONDKiLYo+dd2u
         jRCrzocnFbib+iRPwXx8F5zwSe2UzvFuR/yKIDylp1CCqFQW2veDwZrXJ/LkRrHxxT
         Ye0VcAEz+FMIpfG+maKgqOZENL2ktY6eCT4qfhL5dbRI4BMjmZDllZGQPBToxx+LtO
         96fzlvj6UsHlg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, deren.wu@mediatek.com,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v3 4/9] mt76: mt7921: disable runtime pm for usb
Date:   Sun, 13 Mar 2022 13:48:54 +0100
Message-Id: <779e54963d964faad416065a715c52e4d5d0f396.1647175554.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1647175554.git.lorenzo@kernel.org>
References: <cover.1647175554.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Runtime-pm is not currently supported by usb driver

Tested-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c |  6 ++++++
 drivers/net/wireless/mediatek/mt76/mt7921/init.c    | 10 ++++++----
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c
index 32004b55a360..bce76417f95d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c
@@ -267,6 +267,9 @@ mt7921_pm_set(void *data, u64 val)
 	struct mt7921_dev *dev = data;
 	struct mt76_connac_pm *pm = &dev->pm;
 
+	if (mt76_is_usb(&dev->mt76))
+		return -EOPNOTSUPP;
+
 	mutex_lock(&dev->mt76.mutex);
 
 	if (val == pm->enable_user)
@@ -311,6 +314,9 @@ mt7921_deep_sleep_set(void *data, u64 val)
 	bool monitor = !!(dev->mphy.hw->conf.flags & IEEE80211_CONF_MONITOR);
 	bool enable = !!val;
 
+	if (mt76_is_usb(&dev->mt76))
+		return -EOPNOTSUPP;
+
 	mt7921_mutex_acquire(dev);
 	if (pm->ds_enable_user == enable)
 		goto out;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
index fa6af85bba7b..54f51e7b48a0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
@@ -226,10 +226,12 @@ int mt7921_register_device(struct mt7921_dev *dev)
 	dev->pm.idle_timeout = MT7921_PM_TIMEOUT;
 	dev->pm.stats.last_wake_event = jiffies;
 	dev->pm.stats.last_doze_event = jiffies;
-	dev->pm.enable_user = true;
-	dev->pm.enable = true;
-	dev->pm.ds_enable_user = true;
-	dev->pm.ds_enable = true;
+	if (!mt76_is_usb(&dev->mt76)) {
+		dev->pm.enable_user = true;
+		dev->pm.enable = true;
+		dev->pm.ds_enable_user = true;
+		dev->pm.ds_enable = true;
+	}
 
 	if (mt76_is_sdio(&dev->mt76))
 		hw->extra_tx_headroom += MT_SDIO_TXD_SIZE + MT_SDIO_HDR_SIZE;
-- 
2.35.1

