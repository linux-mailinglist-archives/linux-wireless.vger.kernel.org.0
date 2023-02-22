Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12EC669FF3E
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Feb 2023 00:10:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231407AbjBVXKd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 Feb 2023 18:10:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjBVXKc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Feb 2023 18:10:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D7AF55A5
        for <linux-wireless@vger.kernel.org>; Wed, 22 Feb 2023 15:10:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9DB23615B0
        for <linux-wireless@vger.kernel.org>; Wed, 22 Feb 2023 23:10:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC25AC433EF;
        Wed, 22 Feb 2023 23:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677107431;
        bh=IfYNKsteFKTudTMn05qF/mOZ2/NDenGyu0lqFxiF6zo=;
        h=From:To:Cc:Subject:Date:From;
        b=KKOi65ik6D+vNLn30qU7a6PPr/lypM+zORiQ58+rLzot5yDueDRNcVe0+nUPOx+6Y
         wCKmM9Sz63fyS7Mvj2jaUoUX727rdzm+vGO2v/whej5LZgjDPan73S7xWLypDzyds1
         e5sRZoDJTLneNStFuFc3357hN9UP9mxuitbk0UzXqTClz1GjsQELWD8iDluFgJYnZk
         rq+mv0uMukaXdPJGlPru1QjImEiqOMgoq4o2IG3epTlAcWOenFCd6eaZlkUbw5hUyL
         Ym4bDtD9+jpyGh0uzeIQ5EEFQI4lAHVm7O6nYk+WDXhiD8ii8ncIB5vR/opaYcBUZf
         K/XXIvwk0yElQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     linux-wireless@vger.kernel.org
Cc:     nbd@nbd.name, helmut@subdivi.de, lorenzo.bianconi@redhat.com
Subject: [PATCH wireless] wifi: mt76: do not run mt76_unregister_device() on unregistered hw
Date:   Thu, 23 Feb 2023 00:10:25 +0100
Message-Id: <be3457d82f4e44bb71a22b2b5db27b644a37b1e1.1677107277.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Trying to probe a mt7921e pci card without firmware results in a
successful probe where ieee80211_register_hw hasn't been called. When
removing the driver, ieee802111_unregister_hw is called unconditionally
leading to a kernel NULL pointer dereference.
Fix the issue running mt76_unregister_device routine just for registered
hw.

Link: https://bugs.debian.org/1029116
Link: https://bugs.kali.org/view.php?id=8140
Reported-by: Stuart Hayhurst <stuart.a.hayhurst@gmail.com>
Fixes: 1c71e03afe4b ("mt76: mt7921: move mt7921_init_hw in a dedicated work")
Tested-by: Helmut Grohne <helmut@freexian.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c | 8 ++++++++
 drivers/net/wireless/mediatek/mt76/mt76.h     | 1 +
 2 files changed, 9 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index b117e4467c87..34abf70f44af 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -539,6 +539,7 @@ int mt76_register_phy(struct mt76_phy *phy, bool vht,
 	if (ret)
 		return ret;
 
+	set_bit(MT76_STATE_REGISTERED, &phy->state);
 	phy->dev->phys[phy->band_idx] = phy;
 
 	return 0;
@@ -549,6 +550,9 @@ void mt76_unregister_phy(struct mt76_phy *phy)
 {
 	struct mt76_dev *dev = phy->dev;
 
+	if (!test_bit(MT76_STATE_REGISTERED, &phy->state))
+		return;
+
 	if (IS_ENABLED(CONFIG_MT76_LEDS))
 		mt76_led_cleanup(phy);
 	mt76_tx_status_check(dev, true);
@@ -719,6 +723,7 @@ int mt76_register_device(struct mt76_dev *dev, bool vht,
 		return ret;
 
 	WARN_ON(mt76_worker_setup(hw, &dev->tx_worker, NULL, "tx"));
+	set_bit(MT76_STATE_REGISTERED, &phy->state);
 	sched_set_fifo_low(dev->tx_worker.task);
 
 	return 0;
@@ -729,6 +734,9 @@ void mt76_unregister_device(struct mt76_dev *dev)
 {
 	struct ieee80211_hw *hw = dev->hw;
 
+	if (!test_bit(MT76_STATE_REGISTERED, &dev->phy.state))
+		return;
+
 	if (IS_ENABLED(CONFIG_MT76_LEDS))
 		mt76_led_cleanup(&dev->phy);
 	mt76_tx_status_check(dev, true);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index ccca0162c8f8..183b0fc5a2d4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -402,6 +402,7 @@ struct mt76_tx_cb {
 
 enum {
 	MT76_STATE_INITIALIZED,
+	MT76_STATE_REGISTERED,
 	MT76_STATE_RUNNING,
 	MT76_STATE_MCU_RUNNING,
 	MT76_SCANNING,
-- 
2.39.2

