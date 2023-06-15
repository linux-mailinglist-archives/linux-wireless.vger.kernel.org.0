Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A89B3731C53
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Jun 2023 17:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245753AbjFOPUB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 15 Jun 2023 11:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbjFOPT6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 15 Jun 2023 11:19:58 -0400
Received: from forward102c.mail.yandex.net (forward102c.mail.yandex.net [178.154.239.213])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BDF3B3
        for <linux-wireless@vger.kernel.org>; Thu, 15 Jun 2023 08:19:56 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-87.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-87.sas.yp-c.yandex.net [IPv6:2a02:6b8:c08:9396:0:640:dd2a:0])
        by forward102c.mail.yandex.net (Yandex) with ESMTP id C4E316008C;
        Thu, 15 Jun 2023 18:19:53 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-87.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id eJe0gi1DfKo0-UT4HVZyo;
        Thu, 15 Jun 2023 18:19:53 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1686842393;
        bh=5PIW+8MAyiHrxZjnAZKCU53be8ZUdEy24nKSGoAbb/E=;
        h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=h0WcOjwtCLCOeWdbd0Z2egQ4EWVpMZpwzqHzynSR4WqBN8uR0GFrRnLLm9QnurFC/
         JyZuTLUo8NEAp39N8K1f90NnARKrU59WYU3EyL9Yaxpv7X3HzoTXiQon3wLyt/0AMj
         a8wNUp34U3/dQfNnWvh4tNblPIzcEgjDi8Or10Y4=
Authentication-Results: mail-nwsmtp-smtp-production-main-87.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Yan-Hsuan Chuang <tony0620emma@gmail.com>,
        linux-wireless@vger.kernel.org,
        Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] [v2] wifi: rtw88: delete timer and free skb queue when unloading
Date:   Thu, 15 Jun 2023 18:19:11 +0300
Message-Id: <20230615151911.5793-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <87leglaqkl.fsf@kernel.org>
References: <87leglaqkl.fsf@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix possible crash and memory leak on driver unload by deleting
TX purge timer and freeing C2H queue in 'rtw_core_deinit()'.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
v2: fix title and commit message (Kalle Valo)
---
 drivers/net/wireless/realtek/rtw88/main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index 9447a3aae3b5..572fc126b9de 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -2180,9 +2180,11 @@ void rtw_core_deinit(struct rtw_dev *rtwdev)
 		release_firmware(wow_fw->firmware);
 
 	destroy_workqueue(rtwdev->tx_wq);
+	timer_delete_sync(&rtwdev->tx_report.purge_timer);
 	spin_lock_irqsave(&rtwdev->tx_report.q_lock, flags);
 	skb_queue_purge(&rtwdev->tx_report.queue);
 	skb_queue_purge(&rtwdev->coex.queue);
+	skb_queue_purge(&rtwdev->c2h_queue);
 	spin_unlock_irqrestore(&rtwdev->tx_report.q_lock, flags);
 
 	list_for_each_entry_safe(rsvd_pkt, tmp, &rtwdev->rsvd_page_list,
-- 
2.40.1

