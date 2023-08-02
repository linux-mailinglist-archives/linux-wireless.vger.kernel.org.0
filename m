Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9A176D34B
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Aug 2023 18:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230412AbjHBQHl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Aug 2023 12:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231203AbjHBQHj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Aug 2023 12:07:39 -0400
Received: from forward102a.mail.yandex.net (forward102a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37FB91BF1
        for <linux-wireless@vger.kernel.org>; Wed,  2 Aug 2023 09:07:34 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net [IPv6:2a02:6b8:c0f:26a7:0:640:a2d5:0])
        by forward102a.mail.yandex.net (Yandex) with ESMTP id F12D246CD8;
        Wed,  2 Aug 2023 19:07:30 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id S7VxvrADR8c0-sF1lYpgr;
        Wed, 02 Aug 2023 19:07:30 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1690992450;
        bh=XU4zMpxtFU3pFJZHOgbCJP678AVVYlVIEZtNfMTii+s=;
        h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=Yj7z7SzkWzn/HpNTGKc7ItbzTINxarFD2+QVIAiIcwbKvkS8NmFoxGi32VRx34uTP
         1USmnxRwT+k5lPxl9od0PPM96RqX4QqdHGiIYahvd+gqap0232r4Jmkdq1Infi5MkH
         FZqQhUuCMPm53wvcDxqYb2wLYGnVty1l3ob+Gmss=
Authentication-Results: mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Brian Norris <briannorris@chromium.org>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        lvc-project@linuxtesting.org, Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 3/5] [v3] wifi: mwifiex: handle possible sscanf() errors
Date:   Wed,  2 Aug 2023 19:07:17 +0300
Message-ID: <20230802160726.85545-3-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230802160726.85545-1-dmantipov@yandex.ru>
References: <ZMlHCmjf2ZovExsP@google.com>
 <20230802160726.85545-1-dmantipov@yandex.ru>
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

Return -EINVAL on possible 'sscanf()' errors in
'mwifiex_regrdwr_write()' and 'mwifiex_rdeeprom_write()'.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Acked-by: Brian Norris <briannorris@chromium.org>
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
v3: add Acked-by: and reorder series
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

