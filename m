Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94A7A76678F
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Jul 2023 10:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235139AbjG1IpB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Jul 2023 04:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231986AbjG1IoY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Jul 2023 04:44:24 -0400
Received: from forward102c.mail.yandex.net (forward102c.mail.yandex.net [IPv6:2a02:6b8:c03:500:1:45:d181:d102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 495242D45
        for <linux-wireless@vger.kernel.org>; Fri, 28 Jul 2023 01:44:23 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-18.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-18.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:a712:0:640:d986:0])
        by forward102c.mail.yandex.net (Yandex) with ESMTP id EB919600DE;
        Fri, 28 Jul 2023 11:44:20 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-18.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id EiIwG59DYW20-YXlFXpbD;
        Fri, 28 Jul 2023 11:44:20 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1690533860;
        bh=tYIyowycezUMHidQ+WwJabxeqSI4RL7nRLMFEfOLK18=;
        h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=lNZSCo4UkT1hJZogOzRMD455w7Ewg0kHZV46db7iP55mmzWk5xDn9P/p2km9G/s2T
         WWq/bNyoEtPogHSd1s/QLrgdpio3tXSIG18vV8r9lPGfAyapNDG5hLXJNXdy+AyLvP
         6KjPPns2Y8T5AHi1qAMmsNpCqHh3hPX7eL82eHpI=
Authentication-Results: mail-nwsmtp-smtp-production-main-18.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Brian Norris <briannorris@chromium.org>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        lvc-project@linuxtesting.org, Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 5/5] [v2] wifi: mwifiex: handle possible mwifiex_write_reg() errors
Date:   Fri, 28 Jul 2023 11:43:46 +0300
Message-ID: <20230728084407.101930-5-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230728084407.101930-1-dmantipov@yandex.ru>
References: <ZMFzBStAKemf+dLL@google.com>
 <20230728084407.101930-1-dmantipov@yandex.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Return -1 on possible 'mwifiex_write_reg()' errors in
'mwifiex_init_sdio_ioport()', do not ignore the value
returned by the latter in 'mwifiex_init_sdio()' and
'mwifiex_sdio_up_dev()' as well.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
v2: adjust to match series
---
 drivers/net/wireless/marvell/mwifiex/sdio.c | 22 +++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/sdio.c b/drivers/net/wireless/marvell/mwifiex/sdio.c
index a24bd40dd41a..0d60484cd5df 100644
--- a/drivers/net/wireless/marvell/mwifiex/sdio.c
+++ b/drivers/net/wireless/marvell/mwifiex/sdio.c
@@ -1083,17 +1083,17 @@ static int mwifiex_init_sdio_ioport(struct mwifiex_adapter *adapter)
 		    "info: SDIO FUNC1 IO port: %#x\n", adapter->ioport);
 
 	/* Set Host interrupt reset to read to clear */
-	if (!mwifiex_read_reg(adapter, card->reg->host_int_rsr_reg, &reg))
-		mwifiex_write_reg(adapter, card->reg->host_int_rsr_reg,
-				  reg | card->reg->sdio_int_mask);
-	else
+	if (mwifiex_read_reg(adapter, card->reg->host_int_rsr_reg, &reg))
+		return -1;
+	if (mwifiex_write_reg(adapter, card->reg->host_int_rsr_reg,
+			      reg | card->reg->sdio_int_mask))
 		return -1;
 
 	/* Dnld/Upld ready set to auto reset */
-	if (!mwifiex_read_reg(adapter, card->reg->card_misc_cfg_reg, &reg))
-		mwifiex_write_reg(adapter, card->reg->card_misc_cfg_reg,
-				  reg | AUTO_RE_ENABLE_INT);
-	else
+	if (mwifiex_read_reg(adapter, card->reg->card_misc_cfg_reg, &reg))
+		return -1;
+	if (mwifiex_write_reg(adapter, card->reg->card_misc_cfg_reg,
+			      reg | AUTO_RE_ENABLE_INT))
 		return -1;
 
 	return 0;
@@ -2525,7 +2525,8 @@ static int mwifiex_init_sdio(struct mwifiex_adapter *adapter)
 	mwifiex_read_reg(adapter, card->reg->host_int_status_reg, &sdio_ireg);
 
 	/* Get SDIO ioport */
-	mwifiex_init_sdio_ioport(adapter);
+	if (mwifiex_init_sdio_ioport(adapter))
+		return -EIO;
 
 	/* Initialize SDIO variables in card */
 	card->mp_rd_bitmap = 0;
@@ -3141,7 +3142,8 @@ static void mwifiex_sdio_up_dev(struct mwifiex_adapter *adapter)
 	 */
 	mwifiex_read_reg(adapter, card->reg->host_int_status_reg, &sdio_ireg);
 
-	mwifiex_init_sdio_ioport(adapter);
+	if (mwifiex_init_sdio_ioport(adapter))
+		dev_err(&card->func->dev, "error enabling SDIO port\n");
 }
 
 static struct mwifiex_if_ops sdio_ops = {
-- 
2.41.0

