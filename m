Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB288762D33
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jul 2023 09:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232571AbjGZHYV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 26 Jul 2023 03:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232926AbjGZHX1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 26 Jul 2023 03:23:27 -0400
Received: from forward100b.mail.yandex.net (forward100b.mail.yandex.net [178.154.239.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5CE34213
        for <linux-wireless@vger.kernel.org>; Wed, 26 Jul 2023 00:21:52 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-36.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-36.sas.yp-c.yandex.net [IPv6:2a02:6b8:c08:a497:0:640:fcbf:0])
        by forward100b.mail.yandex.net (Yandex) with ESMTP id AAD2A60026;
        Wed, 26 Jul 2023 10:21:50 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-36.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id kLF1MPmWs8c0-X8x4UPgF;
        Wed, 26 Jul 2023 10:21:50 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1690356110;
        bh=xGio33KrJJkGvgtafrIfL+XZJIunJj3/d4ILeq58FO4=;
        h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=gh54bETzTcezGGha6XcUr4xx3NCfzsUNYDLqC/XxpEEjj4Hw10wUAN9PUteNTql4R
         HlelBQeHxM+F6ojexmd45/iCqne44JONhJTDW0VNsB3aBDTIOsJU6lSOLuO9hobAv9
         3LnEPD8Eb13vSeth1LZrcN/hVgqd0e6QmPzXxSfU=
Authentication-Results: mail-nwsmtp-smtp-production-main-36.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Brian Norris <briannorris@chromium.org>,
        linux-wireless@vger.kernel.org, lvc-project@linuxtesting.org,
        Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 4/5] wifi: mwifiex: handle possible sscanf() errors
Date:   Wed, 26 Jul 2023 10:20:55 +0300
Message-ID: <20230726072114.51964-4-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230726072114.51964-1-dmantipov@yandex.ru>
References: <20230726072114.51964-1-dmantipov@yandex.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Return -EINVAL on possible 'sscanf()' errors in
'mwifiex_regrdwr_write()' and 'mwifiex_rdeeprom_write()'.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/net/wireless/marvell/mwifiex/debugfs.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/debugfs.c b/drivers/net/wireless/marvell/mwifiex/debugfs.c
index 0cdd6c50c1c0..f9c9fec7c792 100644
--- a/drivers/net/wireless/marvell/mwifiex/debugfs.c
+++ b/drivers/net/wireless/marvell/mwifiex/debugfs.c
@@ -425,7 +425,10 @@ mwifiex_regrdwr_write(struct file *file,
 	if (IS_ERR(buf))
 		return PTR_ERR(buf);
 
-	sscanf(buf, "%u %x %x", &reg_type, &reg_offset, &reg_value);
+	if (sscanf(buf, "%u %x %x", &reg_type, &reg_offset, &reg_value) != 3) {
+		ret = -EINVAL;
+		goto done;
+	}
 
 	if (reg_type == 0 || reg_offset == 0) {
 		ret = -EINVAL;
@@ -691,7 +694,10 @@ mwifiex_rdeeprom_write(struct file *file,
 	if (IS_ERR(buf))
 		return PTR_ERR(buf);
 
-	sscanf(buf, "%d %d", &offset, &bytes);
+	if (sscanf(buf, "%d %d", &offset, &bytes) != 2) {
+		ret = -EINVAL;
+		goto done;
+	}
 
 	if (offset == -1 || bytes == -1) {
 		ret = -EINVAL;
-- 
2.41.0

