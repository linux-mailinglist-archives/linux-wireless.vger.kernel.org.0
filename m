Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 189AE7A7A53
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Sep 2023 13:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233786AbjITLXr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Sep 2023 07:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233727AbjITLXp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Sep 2023 07:23:45 -0400
Received: from forward101b.mail.yandex.net (forward101b.mail.yandex.net [178.154.239.148])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF74A3
        for <linux-wireless@vger.kernel.org>; Wed, 20 Sep 2023 04:23:37 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-91.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-91.sas.yp-c.yandex.net [IPv6:2a02:6b8:c08:47a7:0:640:b27a:0])
        by forward101b.mail.yandex.net (Yandex) with ESMTP id 389476001E;
        Wed, 20 Sep 2023 14:23:34 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-91.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id XNHoIXCWpiE0-hbhFZ5PY;
        Wed, 20 Sep 2023 14:23:33 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
        t=1695209013; bh=m3vux/j8uFBfQnbpqxJmOqQ+33wRiaV6nSHI3iTnRTU=;
        h=Message-ID:Date:Cc:Subject:To:From;
        b=msfkMJoxGpNqNM+8BxIqJ0aEPvYMWAJUcGWVsHeq2WPdse6nsRVDtnGyoDVszBFn1
         pcFLChtX9SQ2AaE1OfG8dLD+qYz/AdG0l4gZXmX8Zy6o8BQcqYzUAY9MUW9zTu2qjR
         6ox3leiZ6OlQzAOikgXqv6o0LcisBXPkBY7NpBYM=
Authentication-Results: mail-nwsmtp-smtp-production-main-91.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Brian Norris <briannorris@chromium.org>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        lvc-project@linuxtesting.org, Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] wifi: mwifiex: fix SDIO firmware dump wait
Date:   Wed, 20 Sep 2023 14:22:32 +0300
Message-ID: <20230920112259.18656-1-dmantipov@yandex.ru>
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

In 'mwifiex_sdio_generic_fw_dump()', move (presumably placed
by mistake) 'if (tries == MAX_POLL_TRIES)' check to an outer
waiting loop.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/net/wireless/marvell/mwifiex/sdio.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/sdio.c b/drivers/net/wireless/marvell/mwifiex/sdio.c
index 774858cfe86f..98f16eb8f298 100644
--- a/drivers/net/wireless/marvell/mwifiex/sdio.c
+++ b/drivers/net/wireless/marvell/mwifiex/sdio.c
@@ -2899,12 +2899,12 @@ static void mwifiex_sdio_generic_fw_dump(struct mwifiex_adapter *adapter)
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

