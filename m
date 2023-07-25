Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 566DC7609FD
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jul 2023 08:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231969AbjGYGFz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Jul 2023 02:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231981AbjGYGFq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Jul 2023 02:05:46 -0400
Received: from forward103b.mail.yandex.net (forward103b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C976E10E7
        for <linux-wireless@vger.kernel.org>; Mon, 24 Jul 2023 23:05:39 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-45.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-45.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:552b:0:640:471f:0])
        by forward103b.mail.yandex.net (Yandex) with ESMTP id 2304D60065;
        Tue, 25 Jul 2023 09:05:37 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-45.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id X5DgcxaDR0U0-SZr6Rgh5;
        Tue, 25 Jul 2023 09:05:36 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1690265136;
        bh=Df1Ze6sURcBUhV3+yvQcFNXNzS0oKqirEMdlGQzqbp8=;
        h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=GlPKW/sAkhyQCnnCBb+K6LtZ+tuF1RiEP2wGzkEFKS51hHD97XNEN/fvHH4gfNRN4
         CT5u9DimrpD28FOcN1YAC2XhIb8nkfMrOY2+EOdOegeW2sOwo12n1fTKUnWBo5DYCo
         QJOW20m1dJJAcq4RohUcI3DY+0sGPeW99DThr0cw=
Authentication-Results: mail-nwsmtp-smtp-production-main-45.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Dan Williams <dcbw@redhat.com>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        lvc-project@linuxtesting.org, Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 3/6] [v2] wifi: libertas: simplify list operations in free_if_spi_card()
Date:   Tue, 25 Jul 2023 09:04:45 +0300
Message-ID: <20230725060531.72968-3-dmantipov@yandex.ru>
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

Use 'list_for_each_entry_safe()' to simplify
list operations in 'free_if_spi_card()'.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/net/wireless/marvell/libertas/if_spi.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/marvell/libertas/if_spi.c b/drivers/net/wireless/marvell/libertas/if_spi.c
index 1225fc0e3352..3d53e444ba19 100644
--- a/drivers/net/wireless/marvell/libertas/if_spi.c
+++ b/drivers/net/wireless/marvell/libertas/if_spi.c
@@ -76,16 +76,13 @@ struct if_spi_card {
 
 static void free_if_spi_card(struct if_spi_card *card)
 {
-	struct list_head *cursor, *next;
-	struct if_spi_packet *packet;
+	struct if_spi_packet *packet, *tmp;
 
-	list_for_each_safe(cursor, next, &card->cmd_packet_list) {
-		packet = container_of(cursor, struct if_spi_packet, list);
+	list_for_each_entry_safe(packet, tmp, &card->cmd_packet_list, list) {
 		list_del(&packet->list);
 		kfree(packet);
 	}
-	list_for_each_safe(cursor, next, &card->data_packet_list) {
-		packet = container_of(cursor, struct if_spi_packet, list);
+	list_for_each_entry_safe(packet, tmp, &card->data_packet_list, list) {
 		list_del(&packet->list);
 		kfree(packet);
 	}
-- 
2.41.0

