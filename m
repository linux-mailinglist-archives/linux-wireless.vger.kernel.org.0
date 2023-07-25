Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB3C77609FF
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jul 2023 08:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231975AbjGYGF6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Jul 2023 02:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231996AbjGYGFs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Jul 2023 02:05:48 -0400
Received: from forward103b.mail.yandex.net (forward103b.mail.yandex.net [178.154.239.150])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E72D41BCC
        for <linux-wireless@vger.kernel.org>; Mon, 24 Jul 2023 23:05:40 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-45.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-45.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:552b:0:640:471f:0])
        by forward103b.mail.yandex.net (Yandex) with ESMTP id 419B56003C;
        Tue, 25 Jul 2023 09:05:39 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-45.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id X5DgcxaDR0U0-BHwb9MU5;
        Tue, 25 Jul 2023 09:05:38 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1690265138;
        bh=jEwRI6wSKypyUo4XaDhg84FxPURxjsnDa2yCIlf3xWs=;
        h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=orR+nCl617xuEaV1K6llnDJZWpDJgH7pUvxYLrMM5lXuZbeBrPlkHSBhlt3LyVySQ
         KbxX1PoHVtMO/aaqhIxodBN7euizYQ6Qqqz0d7XaPAv/Ffw/FyBTtbxDCg6WQxORvR
         NNzto9hh1wTXkko8akrPLJMwdjclI5wLL0T5Ylmc=
Authentication-Results: mail-nwsmtp-smtp-production-main-45.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Dan Williams <dcbw@redhat.com>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        lvc-project@linuxtesting.org, Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 5/6] [v2] wifi: libertas: handle possible spu_write_u16() errors
Date:   Tue, 25 Jul 2023 09:04:47 +0300
Message-ID: <20230725060531.72968-5-dmantipov@yandex.ru>
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

Check and handle (well, report at least, as it's done through the rest
of the module) possible 'spu_write_u16()' errors in 'if_spi_e2h()'.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/net/wireless/marvell/libertas/if_spi.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/marvell/libertas/if_spi.c b/drivers/net/wireless/marvell/libertas/if_spi.c
index 3d53e444ba19..8690b0114e23 100644
--- a/drivers/net/wireless/marvell/libertas/if_spi.c
+++ b/drivers/net/wireless/marvell/libertas/if_spi.c
@@ -826,11 +826,16 @@ static void if_spi_e2h(struct if_spi_card *card)
 		goto out;
 
 	/* re-enable the card event interrupt */
-	spu_write_u16(card, IF_SPI_HOST_INT_STATUS_REG,
-			~IF_SPI_HICU_CARD_EVENT);
+	err = spu_write_u16(card, IF_SPI_HOST_INT_STATUS_REG,
+			    ~IF_SPI_HICU_CARD_EVENT);
+	if (err)
+		goto out;
 
 	/* generate a card interrupt */
-	spu_write_u16(card, IF_SPI_CARD_INT_CAUSE_REG, IF_SPI_CIC_HOST_EVENT);
+	err = spu_write_u16(card, IF_SPI_CARD_INT_CAUSE_REG,
+			    IF_SPI_CIC_HOST_EVENT);
+	if (err)
+		goto out;
 
 	lbs_queue_event(priv, cause & 0xff);
 out:
-- 
2.41.0

