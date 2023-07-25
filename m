Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFA597609FC
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jul 2023 08:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231956AbjGYGFy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Jul 2023 02:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231969AbjGYGFq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Jul 2023 02:05:46 -0400
Received: from forward103c.mail.yandex.net (forward103c.mail.yandex.net [IPv6:2a02:6b8:c03:500:1:45:d181:d103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6DB41BF6
        for <linux-wireless@vger.kernel.org>; Mon, 24 Jul 2023 23:05:38 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-45.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-45.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:552b:0:640:471f:0])
        by forward103c.mail.yandex.net (Yandex) with ESMTP id EFE5D60055;
        Tue, 25 Jul 2023 09:05:35 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-45.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id X5DgcxaDR0U0-YAsg4RGH;
        Tue, 25 Jul 2023 09:05:35 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1690265135;
        bh=co5MNK1DYZg46V1IZMKbLnGJGfuREGWF5GKLCjKMuLo=;
        h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=U1h2XFaFlTdRdpJglzykkQWgPWYFJTBS5A1YGHFHYZtG6FkDzJmpc7jEq6tALSXPs
         dyJdFYPaPuOQbxISZHg8odL6RjfrRtOk6Y4PgTur2rTeRWUfNaFSU0iVGOLgemAH8E
         m7jYzezeTnWHaXIvu0E8TQXgEYioDjJbdXnEYvL8=
Authentication-Results: mail-nwsmtp-smtp-production-main-45.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Dan Williams <dcbw@redhat.com>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        lvc-project@linuxtesting.org, Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 2/6] [v2] wifi: libertas: use convenient lists to manage SDIO packets
Date:   Tue, 25 Jul 2023 09:04:44 +0300
Message-ID: <20230725060531.72968-2-dmantipov@yandex.ru>
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

Use convenient lists to manage SDIO packets, adjust
'struct if_sdio_packet', 'struct if_sdio_card' and
related code accordingly.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 .../net/wireless/marvell/libertas/if_sdio.c   | 37 +++++++------------
 1 file changed, 13 insertions(+), 24 deletions(-)

diff --git a/drivers/net/wireless/marvell/libertas/if_sdio.c b/drivers/net/wireless/marvell/libertas/if_sdio.c
index a35b33e84670..c72081cf8a85 100644
--- a/drivers/net/wireless/marvell/libertas/if_sdio.c
+++ b/drivers/net/wireless/marvell/libertas/if_sdio.c
@@ -101,7 +101,7 @@ MODULE_FIRMWARE("sd8688_helper.bin");
 MODULE_FIRMWARE("sd8688.bin");
 
 struct if_sdio_packet {
-	struct if_sdio_packet	*next;
+	struct list_head	list;
 	u16			nb;
 	u8			buffer[] __aligned(4);
 };
@@ -119,7 +119,7 @@ struct if_sdio_card {
 	u8			buffer[65536] __attribute__((aligned(4)));
 
 	spinlock_t		lock;
-	struct if_sdio_packet	*packets;
+	struct list_head	packets;
 
 	struct workqueue_struct	*workqueue;
 	struct work_struct	packet_worker;
@@ -404,9 +404,10 @@ static void if_sdio_host_to_card_worker(struct work_struct *work)
 
 	while (1) {
 		spin_lock_irqsave(&card->lock, flags);
-		packet = card->packets;
+		packet = list_first_entry_or_null(&card->packets,
+						  struct if_sdio_packet, list);
 		if (packet)
-			card->packets = packet->next;
+			list_del(&packet->list);
 		spin_unlock_irqrestore(&card->lock, flags);
 
 		if (!packet)
@@ -909,7 +910,7 @@ static int if_sdio_host_to_card(struct lbs_private *priv,
 {
 	int ret;
 	struct if_sdio_card *card;
-	struct if_sdio_packet *packet, *cur;
+	struct if_sdio_packet *packet;
 	u16 size;
 	unsigned long flags;
 
@@ -934,7 +935,6 @@ static int if_sdio_host_to_card(struct lbs_private *priv,
 		goto out;
 	}
 
-	packet->next = NULL;
 	packet->nb = size;
 
 	/*
@@ -949,14 +949,7 @@ static int if_sdio_host_to_card(struct lbs_private *priv,
 
 	spin_lock_irqsave(&card->lock, flags);
 
-	if (!card->packets)
-		card->packets = packet;
-	else {
-		cur = card->packets;
-		while (cur->next)
-			cur = cur->next;
-		cur->next = packet;
-	}
+	list_add_tail(&packet->list, &card->packets);
 
 	switch (type) {
 	case MVMS_CMD:
@@ -1137,7 +1130,7 @@ static int if_sdio_probe(struct sdio_func *func,
 	struct lbs_private *priv;
 	int ret, i;
 	unsigned int model;
-	struct if_sdio_packet *packet;
+	struct if_sdio_packet *packet, *tmp;
 
 	for (i = 0;i < func->card->num_info;i++) {
 		if (sscanf(func->card->info[i],
@@ -1178,6 +1171,8 @@ static int if_sdio_probe(struct sdio_func *func,
 	}
 
 	spin_lock_init(&card->lock);
+	INIT_LIST_HEAD(&card->packets);
+
 	card->workqueue = alloc_workqueue("libertas_sdio", WQ_MEM_RECLAIM, 0);
 	if (unlikely(!card->workqueue)) {
 		ret = -ENOMEM;
@@ -1236,11 +1231,8 @@ static int if_sdio_probe(struct sdio_func *func,
 	cancel_work_sync(&card->packet_worker);
 	destroy_workqueue(card->workqueue);
 err_queue:
-	while (card->packets) {
-		packet = card->packets;
-		card->packets = card->packets->next;
+	list_for_each_entry_safe(packet, tmp, &card->packets, list)
 		kfree(packet);
-	}
 
 	kfree(card);
 
@@ -1250,7 +1242,7 @@ static int if_sdio_probe(struct sdio_func *func,
 static void if_sdio_remove(struct sdio_func *func)
 {
 	struct if_sdio_card *card;
-	struct if_sdio_packet *packet;
+	struct if_sdio_packet *packet, *tmp;
 
 	card = sdio_get_drvdata(func);
 
@@ -1281,11 +1273,8 @@ static void if_sdio_remove(struct sdio_func *func)
 	cancel_work_sync(&card->packet_worker);
 	destroy_workqueue(card->workqueue);
 
-	while (card->packets) {
-		packet = card->packets;
-		card->packets = card->packets->next;
+	list_for_each_entry_safe(packet, tmp, &card->packets, list)
 		kfree(packet);
-	}
 
 	kfree(card);
 }
-- 
2.41.0

