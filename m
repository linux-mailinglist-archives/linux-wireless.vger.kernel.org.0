Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3772D782842
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Aug 2023 13:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233575AbjHULxp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Aug 2023 07:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231792AbjHULxo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Aug 2023 07:53:44 -0400
Received: from forward102a.mail.yandex.net (forward102a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0D62CC
        for <linux-wireless@vger.kernel.org>; Mon, 21 Aug 2023 04:53:42 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-31.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-31.vla.yp-c.yandex.net [IPv6:2a02:6b8:c18:3b87:0:640:4625:0])
        by forward102a.mail.yandex.net (Yandex) with ESMTP id 5E85F463B9;
        Mon, 21 Aug 2023 14:53:39 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-31.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id crGqrg1W0Gk0-G2ctmIIW;
        Mon, 21 Aug 2023 14:53:39 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1692618819;
        bh=i6BydlDb2XDUniJEwIhG83pQBLeUg35Xb9KRH54aC7Y=;
        h=Message-ID:Date:Cc:Subject:To:From;
        b=PRR65eRiwW7i0aOkyjYwNmwiZFSKYnQgTmFLnyllSWOeh1vywx7mQl1ysNnsJNeXf
         XrxMzmDIOAR4D/C0YdA65ryZL2xzxqX3UAeHxaT17oV4wxyU8CS7ds2X5fan+zqtPW
         Y/w1bs33ujgp836vSfAeYI8KoMqKNhtd7+S88APY=
Authentication-Results: mail-nwsmtp-smtp-production-main-31.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Brian Norris <briannorris@chromium.org>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] wifi: mwifiex: cleanup struct mwifiex_sdio_mpa_rx
Date:   Mon, 21 Aug 2023 14:52:50 +0300
Message-ID: <20230821115254.167552-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Drop filled with NULL pointers but otherwise unused 'skb_arr'
array of 'struct mwifiex_sdio_mpa_rx', adjust related code.

Fixes: 960d6d08e395 ("mwifiex: delay skb allocation for RX until cmd53 over")
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/net/wireless/marvell/mwifiex/sdio.c | 10 ----------
 drivers/net/wireless/marvell/mwifiex/sdio.h |  4 ----
 2 files changed, 14 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/sdio.c b/drivers/net/wireless/marvell/mwifiex/sdio.c
index a24bd40dd41a..daf2078420af 100644
--- a/drivers/net/wireless/marvell/mwifiex/sdio.c
+++ b/drivers/net/wireless/marvell/mwifiex/sdio.c
@@ -2554,20 +2554,11 @@ static int mwifiex_init_sdio(struct mwifiex_adapter *adapter)
 	if (!card->mp_regs)
 		return -ENOMEM;
 
-	/* Allocate skb pointer buffers */
-	card->mpa_rx.skb_arr = kcalloc(card->mp_agg_pkt_limit, sizeof(void *),
-				       GFP_KERNEL);
-	if (!card->mpa_rx.skb_arr) {
-		kfree(card->mp_regs);
-		return -ENOMEM;
-	}
-
 	card->mpa_rx.len_arr = kcalloc(card->mp_agg_pkt_limit,
 				       sizeof(*card->mpa_rx.len_arr),
 				       GFP_KERNEL);
 	if (!card->mpa_rx.len_arr) {
 		kfree(card->mp_regs);
-		kfree(card->mpa_rx.skb_arr);
 		return -ENOMEM;
 	}
 
@@ -2622,7 +2613,6 @@ static void mwifiex_cleanup_sdio(struct mwifiex_adapter *adapter)
 	cancel_work_sync(&card->work);
 
 	kfree(card->mp_regs);
-	kfree(card->mpa_rx.skb_arr);
 	kfree(card->mpa_rx.len_arr);
 	kfree(card->mpa_tx.buf);
 	kfree(card->mpa_rx.buf);
diff --git a/drivers/net/wireless/marvell/mwifiex/sdio.h b/drivers/net/wireless/marvell/mwifiex/sdio.h
index ae94c172310f..b86a9263a6a8 100644
--- a/drivers/net/wireless/marvell/mwifiex/sdio.h
+++ b/drivers/net/wireless/marvell/mwifiex/sdio.h
@@ -164,10 +164,7 @@ struct mwifiex_sdio_mpa_rx {
 	u32 pkt_cnt;
 	u32 ports;
 	u16 start_port;
-
-	struct sk_buff **skb_arr;
 	u32 *len_arr;
-
 	u8 enabled;
 	u32 buf_size;
 	u32 pkt_aggr_limit;
@@ -372,7 +369,6 @@ static inline void mp_rx_aggr_setup(struct sdio_mmc_card *card,
 		else
 			card->mpa_rx.ports |= 1 << (card->mpa_rx.pkt_cnt + 1);
 	}
-	card->mpa_rx.skb_arr[card->mpa_rx.pkt_cnt] = NULL;
 	card->mpa_rx.len_arr[card->mpa_rx.pkt_cnt] = rx_len;
 	card->mpa_rx.pkt_cnt++;
 }
-- 
2.41.0

