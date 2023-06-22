Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9520D739792
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Jun 2023 08:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbjFVGoe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 22 Jun 2023 02:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbjFVGod (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 22 Jun 2023 02:44:33 -0400
Received: from forward102b.mail.yandex.net (forward102b.mail.yandex.net [178.154.239.149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5087A19AF
        for <linux-wireless@vger.kernel.org>; Wed, 21 Jun 2023 23:44:30 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-63.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-63.sas.yp-c.yandex.net [IPv6:2a02:6b8:c14:6e01:0:640:627f:0])
        by forward102b.mail.yandex.net (Yandex) with ESMTP id 87CF56002F;
        Thu, 22 Jun 2023 09:44:27 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-63.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id Qi9Pt8GDVCg0-yqIMKypt;
        Thu, 22 Jun 2023 09:44:27 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1687416267;
        bh=GP8UjbhXzWfTOijSVhz39D09FTFIms4JHl4jpigR9rg=;
        h=Message-ID:Date:Cc:Subject:To:From;
        b=IleDaqamKF4bzY2Cz4amK74Fyr8RMKzGcJPo6392zeLIR1MYHzh4mk4/c/ZY6Nrbt
         WmC3NDIKsfx8WbJ3jFom4gpwl9n4XjhRDRpKM3mZMEBJzbU9hsVhK02e6oBudtbYEL
         5P9yCiJuF0VIyNm3zAVUUR2OkGBBOYUkice0+5BQ=
Authentication-Results: mail-nwsmtp-smtp-production-main-63.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Po-Hao Huang <phhuang@realtek.com>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        Dmitry Antipov <dmantipov@yandex.ru>,
        Ping-Ke Shih <pkshih@realtek.com>
Subject: [PATCH 1/4] [v5] wifi: rtw88: delete timer and free skb queue when unloading
Date:   Thu, 22 Jun 2023 09:44:15 +0300
Message-ID: <20230622064424.38498-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix possible crash and memory leak on driver unload by deleting
TX purge timer and freeing C2H queue in 'rtw_core_deinit()',
shrink critical section in the latter by freeing COEX queue
out of TX report lock scope.

Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
v5: adjust to match recent changes
v4: adjust to match series
v3: shrink critical section in rtw_core_deinit() (Ping-Ke Shih)
v2: fix title and commit message (Kalle Valo)
---
 drivers/net/wireless/realtek/rtw88/main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index c853e2f2d448..c2ddb4d382af 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -2183,10 +2183,12 @@ void rtw_core_deinit(struct rtw_dev *rtwdev)
 		release_firmware(wow_fw->firmware);
 
 	destroy_workqueue(rtwdev->tx_wq);
+	timer_delete_sync(&rtwdev->tx_report.purge_timer);
 	spin_lock_irqsave(&rtwdev->tx_report.q_lock, flags);
 	skb_queue_purge(&rtwdev->tx_report.queue);
-	skb_queue_purge(&rtwdev->coex.queue);
 	spin_unlock_irqrestore(&rtwdev->tx_report.q_lock, flags);
+	skb_queue_purge(&rtwdev->coex.queue);
+	skb_queue_purge(&rtwdev->c2h_queue);
 
 	list_for_each_entry_safe(rsvd_pkt, tmp, &rtwdev->rsvd_page_list,
 				 build_list) {
-- 
2.41.0

