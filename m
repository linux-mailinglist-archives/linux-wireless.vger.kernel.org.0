Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81AC475EE23
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Jul 2023 10:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbjGXIpe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 24 Jul 2023 04:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231809AbjGXIpP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 24 Jul 2023 04:45:15 -0400
Received: from forward103c.mail.yandex.net (forward103c.mail.yandex.net [IPv6:2a02:6b8:c03:500:1:45:d181:d103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C45A410CF
        for <linux-wireless@vger.kernel.org>; Mon, 24 Jul 2023 01:45:11 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-77.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-77.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:5e29:0:640:21c5:0])
        by forward103c.mail.yandex.net (Yandex) with ESMTP id 02AAD60155;
        Mon, 24 Jul 2023 11:45:09 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-77.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 8jE97fQDSuQ0-NZaXUhPc;
        Mon, 24 Jul 2023 11:45:08 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1690188308;
        bh=WVRDTSuqwhQYr0iyHkC8g0h1lLfYfMsqY1SBsRXxG0Q=;
        h=Message-ID:Date:Cc:Subject:To:From;
        b=O+oWMBBGqyPFwi+mRMn6hlO1UTm0oKJ39xxD3Ny3Jw+BAWJbBtGYOfxjISyT2QCvD
         kl6WCpY3wHsLN0HPAMzrLg5sbFVhnNkvRIv5GSjrG+bGBsbdXigHZO82BsQWrjJWyM
         OR+0vNrHoEiN+Z/4SEvdJmKuSudsbUBunZqE9iAw=
Authentication-Results: mail-nwsmtp-smtp-production-main-77.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Doug Brown <doug@schmorgal.com>, linux-wireless@vger.kernel.org,
        lvc-project@linuxtesting.org, Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 1/4] wifi: libertas: add missing calls to cancel_work_sync()
Date:   Mon, 24 Jul 2023 11:44:40 +0300
Message-ID: <20230724084457.64995-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

