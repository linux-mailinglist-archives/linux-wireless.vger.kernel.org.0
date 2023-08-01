Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19B2576A81F
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Aug 2023 07:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbjHAFAQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Aug 2023 01:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbjHAFAM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Aug 2023 01:00:12 -0400
Received: from forward100a.mail.yandex.net (forward100a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A27D61FC6
        for <linux-wireless@vger.kernel.org>; Mon, 31 Jul 2023 22:00:11 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-64.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-64.vla.yp-c.yandex.net [IPv6:2a02:6b8:c0f:170e:0:640:d60c:0])
        by forward100a.mail.yandex.net (Yandex) with ESMTP id 6499746DBE;
        Tue,  1 Aug 2023 08:00:09 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-64.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 40Ji1unDfW20-rl1sXbYA;
        Tue, 01 Aug 2023 08:00:08 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1690866009;
        bh=KpWVlPUx1ReIXt7fZwOJI9RAgEno63qeKnSyebyodTc=;
        h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=jq99cJBssUlujQeIp1Nn53B7OuJ6WAt09GHpw5PkrN24xAlCQTMX52p4TDWqTI+PP
         lso/wH5tn0xOh55ZShCh5AjvCBI5A1lZ1X/eajUMGjdPkdhybnD9ukPGgtVrxDZN4p
         UQm14BoZH4rxr4RCdDyi2giUOZP/J24N1LcT0uxM=
Authentication-Results: mail-nwsmtp-smtp-production-main-64.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        lvc-project@linuxtesting.org, Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 4/4] wifi: mt76: adjust error handling in mt76s_txrx_worker()
Date:   Tue,  1 Aug 2023 07:57:23 +0300
Message-ID: <20230801050000.18864-4-dmantipov@yandex.ru>
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

Adjust error handling in 'mt76s_txrx_worker()' to issue 'dev_err()'
on all possible errors returned by 'mt76s_tx_run_queue()' and
'mt76s_rx_handler()', including newly introduced -ENOMEM in
'mt76s_rx_run_queue()'. This makes separate 'dev_err()' on SDIO
errors somewhat redundant, so remove them.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 .../net/wireless/mediatek/mt76/sdio_txrx.c    | 21 +++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/sdio_txrx.c b/drivers/net/wireless/mediatek/mt76/sdio_txrx.c
index ddd8c0cc744d..68ab325e0dcd 100644
--- a/drivers/net/wireless/mediatek/mt76/sdio_txrx.c
+++ b/drivers/net/wireless/mediatek/mt76/sdio_txrx.c
@@ -107,7 +107,6 @@ mt76s_rx_run_queue(struct mt76_dev *dev, enum mt76_rxq_id qid,
 	sdio_release_host(sdio->func);
 
 	if (err < 0) {
-		dev_err(dev->dev, "sdio read data failed:%d\n", err);
 		put_page(page);
 		return err;
 	}
@@ -127,8 +126,10 @@ mt76s_rx_run_queue(struct mt76_dev *dev, enum mt76_rxq_id qid,
 		if (!dev->drv->rx_check || dev->drv->rx_check(dev, buf, len)) {
 			e->skb = mt76s_build_rx_skb(buf, len,
 						    round_up(len + 4, 4));
-			if (!e->skb)
+			if (!e->skb) {
+				err = -ENOMEM;
 				break;
+			}
 
 			if (q->queued + i + 1 == q->ndesc)
 				break;
@@ -143,7 +144,7 @@ mt76s_rx_run_queue(struct mt76_dev *dev, enum mt76_rxq_id qid,
 	q->queued += i;
 	spin_unlock_bh(&q->lock);
 
-	return i;
+	return err < 0 ? err : i;
 }
 
 static int mt76s_rx_handler(struct mt76_dev *dev)
@@ -163,6 +164,8 @@ static int mt76s_rx_handler(struct mt76_dev *dev)
 		if (ret > 0) {
 			mt76_worker_schedule(&sdio->net_worker);
 			nframes += ret;
+		} else if (ret < 0) {
+			return ret;
 		}
 	}
 
@@ -171,6 +174,8 @@ static int mt76s_rx_handler(struct mt76_dev *dev)
 		if (ret > 0) {
 			mt76_worker_schedule(&sdio->net_worker);
 			nframes += ret;
+		} else if (ret < 0) {
+			return ret;
 		}
 	}
 
@@ -230,9 +235,6 @@ static int __mt76s_xmit_queue(struct mt76_dev *dev, u8 *data, int len)
 	err = sdio_writesb(sdio->func, MCR_WTDR1, data, len);
 	sdio_release_host(sdio->func);
 
-	if (err)
-		dev_err(dev->dev, "sdio write failed: %d\n", err);
-
 	return err;
 }
 
@@ -324,15 +326,22 @@ void mt76s_txrx_worker(struct mt76_sdio *sdio)
 			ret = mt76s_tx_run_queue(dev, dev->phy.q_tx[i]);
 			if (ret > 0)
 				nframes += ret;
+			else if (ret < 0)
+				dev_err(dev->dev, "tx error on queue %d: %d\n",
+					i, ret);
 		}
 		ret = mt76s_tx_run_queue(dev, dev->q_mcu[MT_MCUQ_WM]);
 		if (ret > 0)
 			nframes += ret;
+		else if (ret < 0)
+			dev_err(dev->dev, "tx error on MCU queue: %d\n", ret);
 
 		/* rx */
 		ret = mt76s_rx_handler(dev);
 		if (ret > 0)
 			nframes += ret;
+		else if (ret < 0)
+			dev_err(dev->dev, "rx error: %d\n", ret);
 
 		if (test_bit(MT76_MCU_RESET, &dev->phy.state) ||
 		    test_bit(MT76_STATE_SUSPEND, &dev->phy.state)) {
-- 
2.41.0

