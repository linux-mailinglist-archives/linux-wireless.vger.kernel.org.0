Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF347DF1CD
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Nov 2023 12:56:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345307AbjKBL4S (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 2 Nov 2023 07:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjKBL4R (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 2 Nov 2023 07:56:17 -0400
Received: from forward100b.mail.yandex.net (forward100b.mail.yandex.net [178.154.239.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5874EC2
        for <linux-wireless@vger.kernel.org>; Thu,  2 Nov 2023 04:56:11 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-77.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-77.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:c008:0:640:847d:0])
        by forward100b.mail.yandex.net (Yandex) with ESMTP id B12CF60A70;
        Thu,  2 Nov 2023 14:56:08 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-77.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 7uVw5Z3Wna60-2IEMiWZP;
        Thu, 02 Nov 2023 14:56:08 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
        t=1698926168; bh=kYOqe9ItMvuHNpvGGEg15k4BHBVjjZXqImvg0hwSvF0=;
        h=Message-ID:Date:Cc:Subject:To:From;
        b=wlzYQ2yvRMuDZcFKXxwr7/6M3ftTqK3oAwXBc4xW+MUAxr40lPMMU8Xb/0i1UzYAU
         pzmAJ93KIAyWpyrBK5gsqTHDqDDFA5fPr57CItBe++FHn0gg5Cya0Oua5ko/eNDcGT
         g+IlWg/2XTEy+xK277u8rU/D6pfw/7ZUgEkastes=
Authentication-Results: mail-nwsmtp-smtp-production-main-77.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] wifi: rtw88: simplify __rtw_tx_work()
Date:   Thu,  2 Nov 2023 14:55:55 +0300
Message-ID: <20231102115606.69838-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Since 'ieee80211_txq_get_depth()' allows NULL for 2nd and
3rd arguments, simplify '__rtw_tx_work()' by dropping unused
'byte_cnt'. Compile tested only.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/net/wireless/realtek/rtw88/tx.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/tx.c b/drivers/net/wireless/realtek/rtw88/tx.c
index f63900b6621d..c02ac673be32 100644
--- a/drivers/net/wireless/realtek/rtw88/tx.c
+++ b/drivers/net/wireless/realtek/rtw88/tx.c
@@ -656,9 +656,8 @@ void __rtw_tx_work(struct rtw_dev *rtwdev)
 	list_for_each_entry_safe(rtwtxq, tmp, &rtwdev->txqs, list) {
 		struct ieee80211_txq *txq = rtwtxq_to_txq(rtwtxq);
 		unsigned long frame_cnt;
-		unsigned long byte_cnt;
 
-		ieee80211_txq_get_depth(txq, &frame_cnt, &byte_cnt);
+		ieee80211_txq_get_depth(txq, &frame_cnt, NULL);
 		rtw_txq_push(rtwdev, rtwtxq, frame_cnt);
 
 		list_del_init(&rtwtxq->list);
-- 
2.41.0

