Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE9CE732ABA
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jun 2023 10:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244577AbjFPI7c (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 16 Jun 2023 04:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbjFPI7b (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 16 Jun 2023 04:59:31 -0400
Received: from forward102a.mail.yandex.net (forward102a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2CF9B3
        for <linux-wireless@vger.kernel.org>; Fri, 16 Jun 2023 01:59:28 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-52.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-52.vla.yp-c.yandex.net [IPv6:2a02:6b8:c15:2f8a:0:640:b50b:0])
        by forward102a.mail.yandex.net (Yandex) with ESMTP id 71AFE46D27;
        Fri, 16 Jun 2023 11:59:26 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-52.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id JxYhO6BDda60-8snXQ5fB;
        Fri, 16 Jun 2023 11:59:26 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1686905966;
        bh=86Gqe/QcSepv0PMxG27wlWA/ox7HAGTYH9SaqHE3nUI=;
        h=Message-Id:Date:Cc:Subject:To:From;
        b=wpz8bXMHnIqQKg/pJ9L12OKzUoIpFO/rtaPtcGgIddw5NVSJl7ykD+WP/qnYH21/F
         jiikzfDxF4S7qEaGxv8f6O6doJ9t2GQ1Ccfv04lLR85LHi7S060dhTgbcdII8+fJf7
         DLcE9z5Jm34mgfTpiyWAr7bsRy5D8Q60cYBYItOM=
Authentication-Results: mail-nwsmtp-smtp-production-main-52.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 1/3] [v3] wifi: rtw88: delete timer and free skb queue when unloading
Date:   Fri, 16 Jun 2023 11:59:15 +0300
Message-Id: <20230616085917.60662-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix possible crash and memory leak on driver unload by deleting
TX purge timer and freeing C2H queue in 'rtw_core_deinit()',
shrink critical section in the latter by freeing COEX queue
out of TX report lock scope.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
v3: shrink critical section in rtw_core_deinit() (Ping-Ke Shih)
v2: fix title and commit message (Kalle Valo)
---
 drivers/net/wireless/realtek/rtw88/main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index 9447a3aae3b5..c190598c47c3 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -2180,10 +2180,12 @@ void rtw_core_deinit(struct rtw_dev *rtwdev)
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
2.40.1

