Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4157D762D2F
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jul 2023 09:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232357AbjGZHYP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 26 Jul 2023 03:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232915AbjGZHXZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 26 Jul 2023 03:23:25 -0400
Received: from forward103c.mail.yandex.net (forward103c.mail.yandex.net [178.154.239.214])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 795D34203
        for <linux-wireless@vger.kernel.org>; Wed, 26 Jul 2023 00:21:49 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-36.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-36.sas.yp-c.yandex.net [IPv6:2a02:6b8:c08:a497:0:640:fcbf:0])
        by forward103c.mail.yandex.net (Yandex) with ESMTP id 24D606004B;
        Wed, 26 Jul 2023 10:21:47 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-36.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id kLF1MPmWs8c0-138ylmzN;
        Wed, 26 Jul 2023 10:21:46 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1690356106;
        bh=NO40i8OOR61r7KLXzluQn5AjB3Vg8yqt8Yc8yNxfEuQ=;
        h=Message-ID:Date:Cc:Subject:To:From;
        b=Hc2OA70IsFhnTxqdBgPIKcmWLBu/MEbaJOd9vmoz8fpIiYzAApZRhhdeOg1AYSPnS
         IAJ+ZeILo+o1p3udov+FKamPaRDJU620A4ldKuBfBAKjhjQ3yrxYcO12Y/YvT2lX+U
         A+hSGqq2J8WqYgZDsknJGtV4Ghl7crh8U8cwHATk=
Authentication-Results: mail-nwsmtp-smtp-production-main-36.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Brian Norris <briannorris@chromium.org>,
        linux-wireless@vger.kernel.org, lvc-project@linuxtesting.org,
        Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 1/5] wifi: mwifiex: fix memory leak in mwifiex_histogram_read()
Date:   Wed, 26 Jul 2023 10:20:52 +0300
Message-ID: <20230726072114.51964-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Always free the zeroed page on return from 'mwifiex_histogram_read()'.

Fixes: cbf6e05527a7 ("mwifiex: add rx histogram statistics support")
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
NOTE: this series supersedes all of the previous mwifiex patches not
yet accepted into wireless-next tree.
---
 drivers/net/wireless/marvell/mwifiex/debugfs.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/debugfs.c b/drivers/net/wireless/marvell/mwifiex/debugfs.c
index 52b18f4a774b..0cdd6c50c1c0 100644
--- a/drivers/net/wireless/marvell/mwifiex/debugfs.c
+++ b/drivers/net/wireless/marvell/mwifiex/debugfs.c
@@ -253,8 +253,11 @@ mwifiex_histogram_read(struct file *file, char __user *ubuf,
 	if (!p)
 		return -ENOMEM;
 
-	if (!priv || !priv->hist_data)
-		return -EFAULT;
+	if (!priv || !priv->hist_data) {
+		ret = -EFAULT;
+		goto free_and_exit;
+	}
+
 	phist_data = priv->hist_data;
 
 	p += sprintf(p, "\n"
@@ -309,6 +312,8 @@ mwifiex_histogram_read(struct file *file, char __user *ubuf,
 	ret = simple_read_from_buffer(ubuf, count, ppos, (char *)page,
 				      (unsigned long)p - page);
 
+free_and_exit:
+	free_page(page);
 	return ret;
 }
 
-- 
2.41.0

