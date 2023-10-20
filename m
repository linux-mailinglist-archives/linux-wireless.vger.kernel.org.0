Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8435B7D0C39
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Oct 2023 11:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376642AbjJTJrr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Oct 2023 05:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376319AbjJTJro (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Oct 2023 05:47:44 -0400
Received: from forward102b.mail.yandex.net (forward102b.mail.yandex.net [178.154.239.149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6F3011B
        for <linux-wireless@vger.kernel.org>; Fri, 20 Oct 2023 02:47:40 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-45.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-45.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:4110:0:640:2904:0])
        by forward102b.mail.yandex.net (Yandex) with ESMTP id 9097F60976;
        Fri, 20 Oct 2023 12:47:37 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-45.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id alGG179BWiE0-HYuRQl4n;
        Fri, 20 Oct 2023 12:47:37 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
        t=1697795257; bh=lehyrglspCYlZoOFe6aAzj+uE6xZrxNxmMSJs9IJcA4=;
        h=Message-ID:Date:Cc:Subject:To:From;
        b=vUvK2vEqoZGlyDkHi13f1vn91BnS6tyZsP2M6zRstMmLwOextIEFV+I0DY015mAVU
         1OZopGuxFIcUaQCJR3PVHBXqt7pFZe9D0wffCg8mdOGbSj4pA47aMPvtFhogUeFjk0
         Q9qLPdWeNhnqlcPt3/NL9JfhHJ2xT4wBC7UUjZx8=
Authentication-Results: mail-nwsmtp-smtp-production-main-45.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Brian Norris <briannorris@chromium.org>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        lvc-project@linuxtesting.org, Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 1/2] wifi: mwifiex: fix SDIO firmware read timeout handling
Date:   Fri, 20 Oct 2023 12:46:28 +0300
Message-ID: <20231020094654.33258-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In 'mwifiex_sdio_generic_fw_dump()', move the check whether
'sdio_readb()' has failed for MAX_POLL_TRIES times out of
the reading loop. Compile tested only.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/net/wireless/marvell/mwifiex/sdio.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/sdio.c b/drivers/net/wireless/marvell/mwifiex/sdio.c
index 6462a0ffe698..d80bd3816e3c 100644
--- a/drivers/net/wireless/marvell/mwifiex/sdio.c
+++ b/drivers/net/wireless/marvell/mwifiex/sdio.c
@@ -2889,12 +2889,12 @@ static void mwifiex_sdio_generic_fw_dump(struct mwifiex_adapter *adapter)
 			}
 			if (start_flag == 0)
 				break;
-			if (tries == MAX_POLL_TRIES) {
-				mwifiex_dbg(adapter, ERROR,
-					    "FW not ready to dump\n");
-				ret = -1;
-				goto done;
-			}
+		}
+		if (tries == MAX_POLL_TRIES) {
+			mwifiex_dbg(adapter, ERROR,
+				    "FW not ready to dump\n");
+			ret = -1;
+			goto done;
 		}
 		usleep_range(100, 200);
 	}
-- 
2.41.0

