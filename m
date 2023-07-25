Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22D8C7609FB
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jul 2023 08:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231974AbjGYGFt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Jul 2023 02:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231962AbjGYGFm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Jul 2023 02:05:42 -0400
Received: from forward100b.mail.yandex.net (forward100b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B9D51BE2
        for <linux-wireless@vger.kernel.org>; Mon, 24 Jul 2023 23:05:36 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-45.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-45.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:552b:0:640:471f:0])
        by forward100b.mail.yandex.net (Yandex) with ESMTP id 7328D600DE;
        Tue, 25 Jul 2023 09:05:34 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-45.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id X5DgcxaDR0U0-r0WZq22m;
        Tue, 25 Jul 2023 09:05:34 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1690265134;
        bh=WVRDTSuqwhQYr0iyHkC8g0h1lLfYfMsqY1SBsRXxG0Q=;
        h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=GjPJv1eKg3G4clq6NcG/R1ykW+a1X2Ec10CNXYEIQ5m6KPgq2CR6psvXGKHIhUcJS
         vJXWQXrGKt16+HPjbRUgonfPC6/k5KP9O1fWaG2Uiz+FyCKWepkzBgHHqYi5GNIKfg
         XcxNmQwLC1ERijiCO10pyj7V0X/SE/xD8Ge/NW/0=
Authentication-Results: mail-nwsmtp-smtp-production-main-45.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Dan Williams <dcbw@redhat.com>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        lvc-project@linuxtesting.org, Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 1/6] [v2] wifi: libertas: add missing calls to cancel_work_sync()
Date:   Tue, 25 Jul 2023 09:04:43 +0300
Message-ID: <20230725060531.72968-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <d7262341b0d3b635403f9d19ff2d381f7a543c2a.camel@redhat.com>
References: <d7262341b0d3b635403f9d19ff2d381f7a543c2a.camel@redhat.com>
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

Add missing 'cancel_work_sync()' in 'if_sdio_remove()'
and on error handling path in 'if_sdio_probe()'.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/net/wireless/marvell/libertas/if_sdio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/marvell/libertas/if_sdio.c b/drivers/net/wireless/marvell/libertas/if_sdio.c
index a63c5e622ee3..a35b33e84670 100644
--- a/drivers/net/wireless/marvell/libertas/if_sdio.c
+++ b/drivers/net/wireless/marvell/libertas/if_sdio.c
@@ -1233,6 +1233,7 @@ static int if_sdio_probe(struct sdio_func *func,
 	flush_workqueue(card->workqueue);
 	lbs_remove_card(priv);
 free:
+	cancel_work_sync(&card->packet_worker);
 	destroy_workqueue(card->workqueue);
 err_queue:
 	while (card->packets) {
@@ -1277,6 +1278,7 @@ static void if_sdio_remove(struct sdio_func *func)
 	lbs_stop_card(card->priv);
 	lbs_remove_card(card->priv);
 
+	cancel_work_sync(&card->packet_worker);
 	destroy_workqueue(card->workqueue);
 
 	while (card->packets) {
-- 
2.41.0

