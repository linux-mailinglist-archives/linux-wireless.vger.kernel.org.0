Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF9967CC80C
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Oct 2023 17:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344166AbjJQPw2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Oct 2023 11:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344158AbjJQPw1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Oct 2023 11:52:27 -0400
Received: from forward102c.mail.yandex.net (forward102c.mail.yandex.net [178.154.239.213])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E3B5F1
        for <linux-wireless@vger.kernel.org>; Tue, 17 Oct 2023 08:52:22 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-38.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-38.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:1116:0:640:d64e:0])
        by forward102c.mail.yandex.net (Yandex) with ESMTP id B40FE60AAE;
        Tue, 17 Oct 2023 18:52:18 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-38.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id Hqmlvc3DSmI0-2kdC7MXk;
        Tue, 17 Oct 2023 18:52:18 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
        t=1697557938; bh=5MG0dgvbUmsU6VEei/HHpKIa4rth6yLORoK9jt1Jc80=;
        h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
        b=jk0mYBveQIPcXqurUNDn51PTwsMQFFiUJJMmXOuXIZbch1A6GoDVgKPDqvxoYFGx4
         ljAB7tvoQ9FTAQ1HTRrOJi/T+de1pQKByBqD7I7pKFx5Y1zOIw7DbJLr3MEb06xQkx
         Wq++YaIYCSR9RgiqRsfVzHxwH8Gyyy8w9oTqy/8M=
Authentication-Results: mail-nwsmtp-smtp-production-main-38.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] wifi: ath9k: fix -Wformat-truncation warning
Date:   Tue, 17 Oct 2023 18:49:50 +0300
Message-ID: <20231017155201.111950-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <87fs2k5l1a.fsf@kernel.org>
References: <87fs2k5l1a.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix the following warning observed with GCC 13.2 and -Wformat-truncation:

drivers/net/wireless/ath/ath9k/hif_usb.c: In function ‘ath9k_hif_request_firmware’:
drivers/net/wireless/ath/ath9k/hif_usb.c:1223:42: warning: ‘.0.fw’ directive output
may be truncated writing 5 bytes into a region of size between 4 and 11 [-Wformat-truncation=]
 1223 |                          "%s/htc_%s-%d.%s.0.fw", HTC_FW_PATH,
      |                                          ^~~~~
drivers/net/wireless/ath/ath9k/hif_usb.c:1222:17: note: ‘snprintf’ output between
27 and 34 bytes into a destination of size 32
 1222 |                 snprintf(hif_dev->fw_name, sizeof(hif_dev->fw_name),
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1223 |                          "%s/htc_%s-%d.%s.0.fw", HTC_FW_PATH,
      |                          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1224 |                          chip, MAJOR_VERSION_REQ, index);

According to the comment in 'ath9k_hif_request_firmware()', 36 bytes should be enough.

Suggested-by: Kalle Valo <kvalo@kernel.org>
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/net/wireless/ath/ath9k/hif_usb.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath9k/hif_usb.h b/drivers/net/wireless/ath/ath9k/hif_usb.h
index 5985aa15ca93..752ae288de1d 100644
--- a/drivers/net/wireless/ath/ath9k/hif_usb.h
+++ b/drivers/net/wireless/ath/ath9k/hif_usb.h
@@ -126,7 +126,7 @@ struct hif_device_usb {
 	struct usb_anchor reg_in_submitted;
 	struct usb_anchor mgmt_submitted;
 	struct sk_buff *remain_skb;
-	char fw_name[32];
+	char fw_name[36];
 	int fw_minor_index;
 	int rx_remain_len;
 	int rx_pkt_len;
-- 
2.41.0

