Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2D444D0A3B
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Mar 2022 22:46:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233093AbiCGVrn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Mar 2022 16:47:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231745AbiCGVrm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Mar 2022 16:47:42 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C0F66210
        for <linux-wireless@vger.kernel.org>; Mon,  7 Mar 2022 13:46:42 -0800 (PST)
X-UUID: 07391791181a4c1082c5a9a568f962f7-20220308
X-UUID: 07391791181a4c1082c5a9a568f962f7-20220308
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1918053857; Tue, 08 Mar 2022 05:46:39 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 8 Mar 2022 05:46:38 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 8 Mar
 2022 05:46:37 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 8 Mar 2022 05:46:37 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <Deren.Wu@mediatek.com>, <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Sean Wang <sean.wang@mediatek.com>
Subject: Re: [PATCH] mt76: mt7921: move mt7921_init_hw in a dedicated work
Date:   Tue, 8 Mar 2022 05:46:36 +0800
Message-ID: <1646689596-21189-1-git-send-email-sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <0358e31e71481dec87f7ecb3b040db53076ffc4a.1646654230.git.lorenzo@kernel.org>
References: <0358e31e71481dec87f7ecb3b040db53076ffc4a.1646654230.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

>Firmware initialization can take a while. Move mt7921_init_hw routine in a dedicated work in order to not slow down bootstrap process.

Hi, Lore

I don't think the patch is really needed and it creates the different state of the driver after mt7921_*_probe between without and with the patch
we should be careful to handle it.

For example.

1) It is possible that ieee80211_ops mt7921_ops is working while mt7921_init_work is not completed, so that creates the race issue between ieee80211_ops mt7921_ops and mt7921_init_work still in progress

2) mt7921[k,s,e].ko are always successful probed ( the .ko are always shown in `lsmod` ) that would confuse the users even when we actually got the failure of hardware initialization in mt7921_init_work

so I would prefer to wait a while in mt7921_*_proble until the hardware is ready to be working to get rid of the extra synchronization to be added as well as keep the driver much simple.

        Sean

>
>Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
>---
> .../net/wireless/mediatek/mt76/mt7921/init.c  | 66 +++++++++++++------
> .../wireless/mediatek/mt76/mt7921/mt7921.h    |  2 +
> 2 files changed, 49 insertions(+), 19 deletions(-)
>
>diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
>index fa6af85bba7b..332af886b95a 100644
>--- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
>+++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
>@@ -165,7 +165,7 @@ static int __mt7921_init_hardware(struct mt7921_dev *dev)
>
> static int mt7921_init_hardware(struct mt7921_dev *dev)  {
>-	int ret, idx, i;
>+	int ret, i;
>
>	set_bit(MT76_STATE_INITIALIZED, &dev->mphy.state);
>
>@@ -182,6 +182,13 @@ static int mt7921_init_hardware(struct mt7921_dev *dev)
>		return ret;
>	}
>
>+	return 0;
>+}
>+
>+static int mt7921_init_wcid(struct mt7921_dev *dev) {
>+	int idx;
>+
>	/* Beacon and mgmt frames should occupy wcid 0 */
>	idx = mt76_wcid_alloc(dev->mt76.wcid_mask, MT7921_WTBL_STA - 1);
>	if (idx)
>@@ -195,6 +202,42 @@ static int mt7921_init_hardware(struct mt7921_dev *dev)
>	return 0;
> }
>
>+static void mt7921_init_work(struct work_struct *work) {
>+	struct mt7921_dev *dev = container_of(work, struct mt7921_dev,
>+					      init_work);
>+	int ret;
>+
>+	ret = mt7921_init_hardware(dev);
>+	if (ret)
>+		return;
>+
>+	mt76_set_stream_caps(&dev->mphy, true);
>+	mt7921_set_stream_he_caps(&dev->phy);
>+
>+	ret = mt76_register_device(&dev->mt76, true, mt76_rates,
>+				   ARRAY_SIZE(mt76_rates));
>+	if (ret) {
>+		dev_err(dev->mt76.dev, "register device failed\n");
>+		return;
>+	}
>+
>+	ret = mt7921_init_debugfs(dev);
>+	if (ret) {
>+		dev_err(dev->mt76.dev, "debugfs register failed\n");
>+		goto error;
>+	}
>+
>+	ret = mt76_connac_mcu_set_deep_sleep(&dev->mt76, dev->pm.ds_enable);
>+	if (ret)
>+		goto error;
>+
>+	dev->hw_init_done = true;
>+	return;
>+error:
>+	mt76_unregister_device(&dev->mt76);
>+}
>+
> int mt7921_register_device(struct mt7921_dev *dev)  {
>	struct ieee80211_hw *hw = mt76_hw(dev); @@ -222,6 +265,7 @@ int mt7921_register_device(struct mt7921_dev *dev)
>	spin_lock_init(&dev->sta_poll_lock);
>
>	INIT_WORK(&dev->reset_work, mt7921_mac_reset_work);
>+	INIT_WORK(&dev->init_work, mt7921_init_work);
>
>	dev->pm.idle_timeout = MT7921_PM_TIMEOUT;
>	dev->pm.stats.last_wake_event = jiffies; @@ -234,7 +278,7 @@ int mt7921_register_device(struct mt7921_dev *dev)
>	if (mt76_is_sdio(&dev->mt76))
>		hw->extra_tx_headroom += MT_SDIO_TXD_SIZE + MT_SDIO_HDR_SIZE;
>
>-	ret = mt7921_init_hardware(dev);
>+	ret = mt7921_init_wcid(dev);
>	if (ret)
>		return ret;
>
>@@ -262,23 +306,7 @@ int mt7921_register_device(struct mt7921_dev *dev)
>	dev->mphy.hw->wiphy->available_antennas_rx = dev->mphy.chainmask;
>	dev->mphy.hw->wiphy->available_antennas_tx = dev->mphy.chainmask;
>
>-	mt76_set_stream_caps(&dev->mphy, true);
>-	mt7921_set_stream_he_caps(&dev->phy);
>-
>-	ret = mt76_register_device(&dev->mt76, true, mt76_rates,
>-				   ARRAY_SIZE(mt76_rates));
>-	if (ret)
>-		return ret;
>-
>-	ret = mt7921_init_debugfs(dev);
>-	if (ret)
>-		return ret;
>-
>-	ret = mt76_connac_mcu_set_deep_sleep(&dev->mt76, dev->pm.ds_enable);
>-	if (ret)
>-		return ret;
>-
>-	dev->hw_init_done = true;
>+	queue_work(system_wq, &dev->init_work);
>
>	return 0;
> }
>diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
>index 394a677140da..b6c8f84acb64 100644
>--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
>+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
>@@ -204,6 +204,8 @@ struct mt7921_dev {
>	struct list_head sta_poll_list;
>	spinlock_t sta_poll_lock;
>
>+	struct work_struct init_work;
>+
>	u8 fw_debug;
>
>	struct mt76_connac_pm pm;
>--
>2.35.1
>
>
>
