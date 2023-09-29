Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45B0A7B3734
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Sep 2023 17:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233665AbjI2PqO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 Sep 2023 11:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233548AbjI2PqM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 Sep 2023 11:46:12 -0400
Received: from forward102c.mail.yandex.net (forward102c.mail.yandex.net [IPv6:2a02:6b8:c03:500:1:45:d181:d102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A930E1A7
        for <linux-wireless@vger.kernel.org>; Fri, 29 Sep 2023 08:46:07 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-78.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-78.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:2991:0:640:f02b:0])
        by forward102c.mail.yandex.net (Yandex) with ESMTP id 0D43B6004E;
        Fri, 29 Sep 2023 18:46:05 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-78.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 3kUKMc5DaiE0-AZOxEzi5;
        Fri, 29 Sep 2023 18:46:04 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
        t=1696002364; bh=IHHiu9J3qjPvCqA5o5syaVW0pliP3UUj+flQC8NJBiE=;
        h=Message-ID:Date:Cc:Subject:To:From;
        b=JPIWtMZLXgOI0I3jVzXB+qE0kFaPdMym8+Y7iiaqn67qWcSIxVOVZ7C6D0ET9gFrJ
         cQVtyp3524qSI38bFXdf3A+vjvJE8s1Av9z6tWdjPM9BNr9fVI0v4WDd3KQQntExXr
         6MEcdoLnWiZbORdrFeEreydTkJiZygNBYXLN9yk8=
Authentication-Results: mail-nwsmtp-smtp-production-main-78.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] wifi: rtlwifi: use unsigned long for rtl_bssid_entry timestamp
Date:   Fri, 29 Sep 2023 18:45:20 +0300
Message-ID: <20230929154524.222498-1-dmantipov@yandex.ru>
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

Since 'age' of 'struct rtl_bssid_entry' is in jiffies, prefer 'unsigned
long' over 'u32' to avoid possible truncation in 'rtl_collect_scan_list()'
and thus weird result in 'rtl_scan_list_expire()'. Compile tested only.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/net/wireless/realtek/rtlwifi/wifi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/wifi.h b/drivers/net/wireless/realtek/rtlwifi/wifi.h
index 2e7e04f91279..0f99e3446796 100644
--- a/drivers/net/wireless/realtek/rtlwifi/wifi.h
+++ b/drivers/net/wireless/realtek/rtlwifi/wifi.h
@@ -2708,7 +2708,7 @@ struct rtl_c2hcmd {
 struct rtl_bssid_entry {
 	struct list_head list;
 	u8 bssid[ETH_ALEN];
-	u32 age;
+	unsigned long age;
 };
 
 struct rtl_scan_list {
-- 
2.41.0

