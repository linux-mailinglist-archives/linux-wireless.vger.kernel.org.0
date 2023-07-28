Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3D60766789
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Jul 2023 10:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235121AbjG1Iom (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Jul 2023 04:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233951AbjG1IoW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Jul 2023 04:44:22 -0400
Received: from forward103c.mail.yandex.net (forward103c.mail.yandex.net [IPv6:2a02:6b8:c03:500:1:45:d181:d103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 182BF2728
        for <linux-wireless@vger.kernel.org>; Fri, 28 Jul 2023 01:44:21 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-18.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-18.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:a712:0:640:d986:0])
        by forward103c.mail.yandex.net (Yandex) with ESMTP id B23FD6009C;
        Fri, 28 Jul 2023 11:44:19 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-18.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id EiIwG59DYW20-WQz64S0s;
        Fri, 28 Jul 2023 11:44:19 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1690533859;
        bh=pMw6xofZHOSIHegJ1kvDTVYC2zzE+2xrkl70iyfOzxo=;
        h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=WZdryhG5UeqEOjy6VJaL/ph0YU7NyZ6TpcbvwSR4OLH2xo7gZaD70liEatM/2t7vL
         kNxqHilXuZyWYeMPYCxEqc1jA00OF1KPGv4c3e8MJ01UMWjSY8MTBq5Wnnh9CV6cQB
         tK52z9CryhZGxwZXNo+FT/U+MNVQl1HFPKw7Hkw8=
Authentication-Results: mail-nwsmtp-smtp-production-main-18.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Brian Norris <briannorris@chromium.org>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        lvc-project@linuxtesting.org, Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 4/5] [v2] wifi: mwifiex: handle possible sscanf() errors
Date:   Fri, 28 Jul 2023 11:43:45 +0300
Message-ID: <20230728084407.101930-4-dmantipov@yandex.ru>
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

Return -EINVAL on possible 'sscanf()' errors in
'mwifiex_regrdwr_write()' and 'mwifiex_rdeeprom_write()'.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
v2: adjust to match series
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

