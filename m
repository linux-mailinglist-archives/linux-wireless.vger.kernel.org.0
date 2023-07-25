Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 734837609FE
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jul 2023 08:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231985AbjGYGF4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Jul 2023 02:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231987AbjGYGFr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Jul 2023 02:05:47 -0400
Received: from forward103b.mail.yandex.net (forward103b.mail.yandex.net [178.154.239.150])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDF311990
        for <linux-wireless@vger.kernel.org>; Mon, 24 Jul 2023 23:05:40 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-45.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-45.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:552b:0:640:471f:0])
        by forward103b.mail.yandex.net (Yandex) with ESMTP id 4CCBB60031;
        Tue, 25 Jul 2023 09:05:38 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-45.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id X5DgcxaDR0U0-WzoiQ98J;
        Tue, 25 Jul 2023 09:05:37 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1690265137;
        bh=YLZT2zCqCrqXsRdMMgrSeJ/O8ZUtVuyJ7PCIifiBiLk=;
        h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=ALOwjYjeRul0MA+ektHQqlRcYdRDZLXsUoviL5UggAaS68+gBXbgBQub/dW2q+jf6
         9kbipI7YJ9I//FRjh3C2QnhNX9VeTM6ZjH0P7HH7zqBOb8U38cvA21kutirl0k+Loe
         ZIOAv7+iOHY+VwPimn3wU3UEWbsd3fx4ebtXkQxk=
Authentication-Results: mail-nwsmtp-smtp-production-main-45.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Dan Williams <dcbw@redhat.com>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        lvc-project@linuxtesting.org, Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 4/6] [v2] wifi: libertas: cleanup SDIO reset
Date:   Tue, 25 Jul 2023 09:04:46 +0300
Message-ID: <20230725060531.72968-4-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725060531.72968-1-dmantipov@yandex.ru>
References: <d7262341b0d3b635403f9d19ff2d381f7a543c2a.camel@redhat.com>
 <20230725060531.72968-1-dmantipov@yandex.ru>
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

Embed SDIO reset worker in 'struct if_sdio_card' and so
drop 'reset_host' and 'card_reset_work' static variables,
adjust related code. Not sure whether it's possible to do
something useful on 'mmc_add_host()' error, so just add
'dev_err()' to emit an error message.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 .../net/wireless/marvell/libertas/if_sdio.c   | 34 ++++++++++++-------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/marvell/libertas/if_sdio.c b/drivers/net/wireless/marvell/libertas/if_sdio.c
index c72081cf8a85..524034699972 100644
--- a/drivers/net/wireless/marvell/libertas/if_sdio.c
+++ b/drivers/net/wireless/marvell/libertas/if_sdio.c
@@ -123,6 +123,7 @@ struct if_sdio_card {
 
 	struct workqueue_struct	*workqueue;
 	struct work_struct	packet_worker;
+	struct work_struct	reset_worker;
 
 	u8			rx_unit;
 };
@@ -1022,10 +1023,19 @@ static int if_sdio_reset_deep_sleep_wakeup(struct lbs_private *priv)
 
 }
 
-static struct mmc_host *reset_host;
-
 static void if_sdio_reset_card_worker(struct work_struct *work)
 {
+	int ret;
+	const char *name;
+	struct device *dev;
+	struct if_sdio_card *card;
+	struct mmc_host *reset_host;
+
+	card = container_of(work, struct if_sdio_card, reset_worker);
+	reset_host = card->func->card->host;
+	name = card->priv->dev->name;
+	dev = &card->func->dev;
+
 	/*
 	 * The actual reset operation must be run outside of lbs_thread. This
 	 * is because mmc_remove_host() will cause the device to be instantly
@@ -1036,21 +1046,19 @@ static void if_sdio_reset_card_worker(struct work_struct *work)
 	 * instance for that reason.
 	 */
 
-	pr_info("Resetting card...");
+	dev_info(dev, "resetting card %s...", name);
 	mmc_remove_host(reset_host);
-	mmc_add_host(reset_host);
+	ret = mmc_add_host(reset_host);
+	if (ret)
+		dev_err(dev, "%s: can't add mmc host, error %d\n", name, ret);
 }
-static DECLARE_WORK(card_reset_work, if_sdio_reset_card_worker);
 
 static void if_sdio_reset_card(struct lbs_private *priv)
 {
 	struct if_sdio_card *card = priv->card;
 
-	if (work_pending(&card_reset_work))
-		return;
-
-	reset_host = card->func->card->host;
-	schedule_work(&card_reset_work);
+	if (!work_pending(&card->reset_worker))
+		schedule_work(&card->reset_worker);
 }
 
 static int if_sdio_power_save(struct lbs_private *priv)
@@ -1178,6 +1186,8 @@ static int if_sdio_probe(struct sdio_func *func,
 		ret = -ENOMEM;
 		goto err_queue;
 	}
+
+	INIT_WORK(&card->reset_worker, if_sdio_reset_card_worker);
 	INIT_WORK(&card->packet_worker, if_sdio_host_to_card_worker);
 	init_waitqueue_head(&card->pwron_waitq);
 
@@ -1229,6 +1239,7 @@ static int if_sdio_probe(struct sdio_func *func,
 	lbs_remove_card(priv);
 free:
 	cancel_work_sync(&card->packet_worker);
+	cancel_work_sync(&card->reset_worker);
 	destroy_workqueue(card->workqueue);
 err_queue:
 	list_for_each_entry_safe(packet, tmp, &card->packets, list)
@@ -1271,6 +1282,7 @@ static void if_sdio_remove(struct sdio_func *func)
 	lbs_remove_card(card->priv);
 
 	cancel_work_sync(&card->packet_worker);
+	cancel_work_sync(&card->reset_worker);
 	destroy_workqueue(card->workqueue);
 
 	list_for_each_entry_safe(packet, tmp, &card->packets, list)
@@ -1394,8 +1406,6 @@ static void __exit if_sdio_exit_module(void)
 	/* Set the flag as user is removing this module. */
 	user_rmmod = 1;
 
-	cancel_work_sync(&card_reset_work);
-
 	sdio_unregister_driver(&if_sdio_driver);
 }
 
-- 
2.41.0

