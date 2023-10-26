Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7A407D8446
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Oct 2023 16:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235017AbjJZOLz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Oct 2023 10:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230507AbjJZOLy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Oct 2023 10:11:54 -0400
Received: from forward102a.mail.yandex.net (forward102a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A13831AA
        for <linux-wireless@vger.kernel.org>; Thu, 26 Oct 2023 07:11:49 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-64.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-64.vla.yp-c.yandex.net [IPv6:2a02:6b8:c0f:170e:0:640:d60c:0])
        by forward102a.mail.yandex.net (Yandex) with ESMTP id 6C33160030;
        Thu, 26 Oct 2023 17:11:47 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-64.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id kBR2w36DV8c0-MpVWPlNu;
        Thu, 26 Oct 2023 17:11:47 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
        t=1698329507; bh=6EvCt7EfDSENJKxxIjMJGNpPc2FJSlZha5HbjeHUvLE=;
        h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=OMEnDEhUFLmT+igYu64wq0/ZPeiGiFqRm1Dbfb+GydTdhLWxah5uXHkY4o8ClDYXA
         59dUGmDgac+H4mnloMU4gMFCOA+08Q58IIOp9AaE0XWqXhswGMD2X141iG3uI4qDqe
         5Icf4dlueb3Hked7YWQmY4ai9nGtHWilGOc0XjYA=
Authentication-Results: mail-nwsmtp-smtp-production-main-64.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Ajay Singh <ajay.kathat@microchip.com>
Cc:     Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 2/2] wifi: wilc1000: always release SDIO host in wilc_sdio_cmd53()
Date:   Thu, 26 Oct 2023 17:10:12 +0300
Message-ID: <20231026141016.71407-2-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231026141016.71407-1-dmantipov@yandex.ru>
References: <20231026141016.71407-1-dmantipov@yandex.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ensure 'sdio_release_host()' is always issued on return
from 'wilc_sdio_cmd53()'. Compile tested only.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/net/wireless/microchip/wilc1000/sdio.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/sdio.c b/drivers/net/wireless/microchip/wilc1000/sdio.c
index 87948ba69a22..0d13e3e46e98 100644
--- a/drivers/net/wireless/microchip/wilc1000/sdio.c
+++ b/drivers/net/wireless/microchip/wilc1000/sdio.c
@@ -106,9 +106,10 @@ static int wilc_sdio_cmd53(struct wilc *wilc, struct sdio_cmd53 *cmd)
 		size = cmd->count;
 
 	if (cmd->use_global_buf) {
-		if (size > sizeof(u32))
-			return -EINVAL;
-
+		if (size > sizeof(u32)) {
+			ret = -EINVAL;
+			goto out;
+		}
 		buf = sdio_priv->cmd53_buf;
 	}
 
@@ -123,7 +124,7 @@ static int wilc_sdio_cmd53(struct wilc *wilc, struct sdio_cmd53 *cmd)
 		if (cmd->use_global_buf)
 			memcpy(cmd->buffer, buf, size);
 	}
-
+out:
 	sdio_release_host(func);
 
 	if (ret)
-- 
2.41.0

