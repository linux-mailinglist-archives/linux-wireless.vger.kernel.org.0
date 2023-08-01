Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8F3476A81C
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Aug 2023 07:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbjHAFAM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Aug 2023 01:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjHAFAL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Aug 2023 01:00:11 -0400
Received: from forward101a.mail.yandex.net (forward101a.mail.yandex.net [178.154.239.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E551FC3
        for <linux-wireless@vger.kernel.org>; Mon, 31 Jul 2023 22:00:09 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-64.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-64.vla.yp-c.yandex.net [IPv6:2a02:6b8:c0f:170e:0:640:d60c:0])
        by forward101a.mail.yandex.net (Yandex) with ESMTP id 2D5BD46C76;
        Tue,  1 Aug 2023 08:00:07 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-64.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 40Ji1unDfW20-Ox7efaRJ;
        Tue, 01 Aug 2023 08:00:06 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1690866006;
        bh=W5W7rPkOZCjf4eEXAecF+cJutWQYN7zZF7eEwmOs6zQ=;
        h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=jhddqpnvmCXdXXllRhyORPvrF7fxbqEqlI5ksG449oHtTQKwzE5mdc6VO7RkEEKBa
         1qmH3TwKqwxmoggMIIhTLU0zdOJqnAlNLN0Nxy9QbmZctyDCHuXd/jg+ERB9ESLFff
         xUdVjbdNhjwwIeoF8xxRX8d+qK1ZWPZOrgjLhA/o=
Authentication-Results: mail-nwsmtp-smtp-production-main-64.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        lvc-project@linuxtesting.org, Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 2/4] wifi: mt76: handle possible hardware timeout in mt7603_pse_client_reset()
Date:   Tue,  1 Aug 2023 07:57:21 +0300
Message-ID: <20230801050000.18864-2-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801050000.18864-1-dmantipov@yandex.ru>
References: <20230801050000.18864-1-dmantipov@yandex.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Handle possible 'mt76_poll_msec()' timeout in 'mt7603_pse_client_reset()',
convert the latter from 'void' to return 'int', propagate return value to
'mt7603_dma_init()' and 'WARN_ON()' on it in 'mt7603_mac_watchdog_reset()'.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/net/wireless/mediatek/mt76/mt7603/dma.c  |  4 +++-
 drivers/net/wireless/mediatek/mt76/mt7603/mac.c  | 16 ++++++++++------
 .../net/wireless/mediatek/mt76/mt7603/mt7603.h   |  2 +-
 3 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/dma.c b/drivers/net/wireless/mediatek/mt76/mt7603/dma.c
index 03ba11a61c90..15c6564f212a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/dma.c
@@ -169,7 +169,9 @@ int mt7603_dma_init(struct mt7603_dev *dev)
 		   MT_WPDMA_GLO_CFG_TX_WRITEBACK_DONE);
 
 	mt76_wr(dev, MT_WPDMA_RST_IDX, ~0);
-	mt7603_pse_client_reset(dev);
+	ret = mt7603_pse_client_reset(dev);
+	if (ret)
+		return ret;
 
 	for (i = 0; i < ARRAY_SIZE(wmm_queue_map); i++) {
 		ret = mt76_init_tx_queue(&dev->mphy, i, wmm_queue_map[i],
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
index 12e0af52082a..fe38b9a8034d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
@@ -1367,7 +1367,7 @@ void mt7603_mac_stop(struct mt7603_dev *dev)
 	mt76_clear(dev, MT_WF_ARB_RQCR, MT_WF_ARB_RQCR_RX_START);
 }
 
-void mt7603_pse_client_reset(struct mt7603_dev *dev)
+int mt7603_pse_client_reset(struct mt7603_dev *dev)
 {
 	u32 addr;
 
@@ -1383,20 +1383,24 @@ void mt7603_pse_client_reset(struct mt7603_dev *dev)
 
 	/* Start PSE client TX abort */
 	mt76_set(dev, addr, MT_CLIENT_RESET_TX_R_E_1);
-	mt76_poll_msec(dev, addr, MT_CLIENT_RESET_TX_R_E_1_S,
-		       MT_CLIENT_RESET_TX_R_E_1_S, 500);
+	if (!mt76_poll_msec(dev, addr, MT_CLIENT_RESET_TX_R_E_1_S,
+			    MT_CLIENT_RESET_TX_R_E_1_S, 500))
+		return -ETIMEDOUT;
 
 	mt76_set(dev, addr, MT_CLIENT_RESET_TX_R_E_2);
 	mt76_set(dev, MT_WPDMA_GLO_CFG, MT_WPDMA_GLO_CFG_SW_RESET);
 
 	/* Wait for PSE client to clear TX FIFO */
-	mt76_poll_msec(dev, addr, MT_CLIENT_RESET_TX_R_E_2_S,
-		       MT_CLIENT_RESET_TX_R_E_2_S, 500);
+	if (!mt76_poll_msec(dev, addr, MT_CLIENT_RESET_TX_R_E_2_S,
+			    MT_CLIENT_RESET_TX_R_E_2_S, 500))
+		return -ETIMEDOUT;
 
 	/* Clear PSE client TX abort state */
 	mt76_clear(dev, addr,
 		   MT_CLIENT_RESET_TX_R_E_1 |
 		   MT_CLIENT_RESET_TX_R_E_2);
+
+	return 0;
 }
 
 static void mt7603_dma_sched_reset(struct mt7603_dev *dev)
@@ -1450,7 +1454,7 @@ static void mt7603_mac_watchdog_reset(struct mt7603_dev *dev)
 
 	mt76_set(dev, MT_WPDMA_GLO_CFG, MT_WPDMA_GLO_CFG_FORCE_TX_EOF);
 
-	mt7603_pse_client_reset(dev);
+	WARN_ON(mt7603_pse_client_reset(dev) < 0);
 
 	mt76_queue_tx_cleanup(dev, dev->mt76.q_mcu[MT_MCUQ_WM], true);
 	for (i = 0; i < __MT_TXQ_MAX; i++)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h b/drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h
index 7c3be596da09..d651a13efe8c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h
@@ -215,7 +215,7 @@ void mt7603_mac_tx_ba_reset(struct mt7603_dev *dev, int wcid, int tid,
 			    int ba_size);
 void mt7603_mac_sta_poll(struct mt7603_dev *dev);
 
-void mt7603_pse_client_reset(struct mt7603_dev *dev);
+int mt7603_pse_client_reset(struct mt7603_dev *dev);
 
 int mt7603_mcu_set_channel(struct mt7603_dev *dev);
 int mt7603_mcu_set_eeprom(struct mt7603_dev *dev);
-- 
2.41.0

