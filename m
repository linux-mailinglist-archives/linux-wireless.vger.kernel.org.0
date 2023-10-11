Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9B27C586B
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Oct 2023 17:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234961AbjJKPq6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Oct 2023 11:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232739AbjJKPq5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Oct 2023 11:46:57 -0400
Received: from forward100a.mail.yandex.net (forward100a.mail.yandex.net [178.154.239.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ED0B8F
        for <linux-wireless@vger.kernel.org>; Wed, 11 Oct 2023 08:46:54 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-74.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-74.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1d:47bd:0:640:2492:0])
        by forward100a.mail.yandex.net (Yandex) with ESMTP id 17DEC429D7;
        Wed, 11 Oct 2023 18:46:52 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-74.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id pkg2t9WDf8c0-49q1YBQE;
        Wed, 11 Oct 2023 18:46:51 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
        t=1697039211; bh=mSXb3zdvuoyrctJTsAkGHz98ViUElZdLI+UiDcHVd4o=;
        h=Message-ID:Date:Cc:Subject:To:From;
        b=ZFukbZUGsTxLJGSsnQ3gw2lrbdOJz2pyAj7DUAe8IFdJnCJQaR+5cb4rIDCEOpaUA
         2ddbV7sLQbo0lKHaciEdK5H7IyWRSyIg6atTiLAda2YkzEvp/iAudvhuxIyWydnnCw
         UAJntvczBaXS3hDXX9v3994jLtKYmdrZsbvYlNvM=
Authentication-Results: mail-nwsmtp-smtp-production-main-74.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 1/2] wifi: rtlwifi: cleanup struct rtl_ps_ctl
Date:   Wed, 11 Oct 2023 18:44:36 +0300
Message-ID: <20231011154442.52457-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Remove set but otherwise unused 'sleep_ms', 'last_action',
and 'last_slept' members of 'struct rtl_ps_ctl' (these
seems to be a leftovers from some older code) and adjust
'rtl_swlps_wq_callback()' accordingly.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/net/wireless/realtek/rtlwifi/ps.c   | 10 ----------
 drivers/net/wireless/realtek/rtlwifi/wifi.h |  3 ---
 2 files changed, 13 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/ps.c b/drivers/net/wireless/realtek/rtlwifi/ps.c
index 629c03271bde..ba61fcec9fae 100644
--- a/drivers/net/wireless/realtek/rtlwifi/ps.c
+++ b/drivers/net/wireless/realtek/rtlwifi/ps.c
@@ -688,16 +688,6 @@ void rtl_swlps_wq_callback(struct work_struct *work)
 	/* we can sleep after ps null send ok */
 	if (rtlpriv->psc.state_inap) {
 		rtl_swlps_rf_sleep(hw);
-
-		if (rtlpriv->psc.state && !ps) {
-			rtlpriv->psc.sleep_ms = jiffies_to_msecs(jiffies -
-						 rtlpriv->psc.last_action);
-		}
-
-		if (ps)
-			rtlpriv->psc.last_slept = jiffies;
-
-		rtlpriv->psc.last_action = jiffies;
 		rtlpriv->psc.state = ps;
 	}
 }
diff --git a/drivers/net/wireless/realtek/rtlwifi/wifi.h b/drivers/net/wireless/realtek/rtlwifi/wifi.h
index 47b4685b6d24..cabf6c82a639 100644
--- a/drivers/net/wireless/realtek/rtlwifi/wifi.h
+++ b/drivers/net/wireless/realtek/rtlwifi/wifi.h
@@ -2037,14 +2037,11 @@ struct rtl_ps_ctl {
 	bool multi_buffered;
 	u16 nullfunc_seq;
 	unsigned int dtim_counter;
-	unsigned int sleep_ms;
 	unsigned long last_sleep_jiffies;
 	unsigned long last_awake_jiffies;
 	unsigned long last_delaylps_stamp_jiffies;
 	unsigned long last_dtim;
 	unsigned long last_beacon;
-	unsigned long last_action;
-	unsigned long last_slept;
 
 	/*For P2P PS */
 	struct rtl_p2p_ps_info p2p_ps_info;
-- 
2.41.0

