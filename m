Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B322538410
	for <lists+linux-wireless@lfdr.de>; Mon, 30 May 2022 17:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241545AbiE3Oov (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 30 May 2022 10:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241221AbiE3OnL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 30 May 2022 10:43:11 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D2F14B2D4
        for <linux-wireless@vger.kernel.org>; Mon, 30 May 2022 06:55:28 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1nvfrO-0007Uo-PV; Mon, 30 May 2022 15:55:06 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <sha@pengutronix.de>)
        id 1nvfrP-005SmU-0H; Mon, 30 May 2022 15:55:05 +0200
Received: from sha by dude02.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <sha@pengutronix.de>)
        id 1nvfrL-004dIW-H0; Mon, 30 May 2022 15:55:03 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     linux-wireless@vger.kernel.org
Cc:     Neo Jou <neojou@gmail.com>, Hans Ulli Kroll <linux@ulli-kroll.de>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Yan-Hsuan Chuang <tony0620emma@gmail.com>,
        Kalle Valo <kvalo@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        kernel@pengutronix.de, Johannes Berg <johannes@sipsolutions.net>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH v2 04/10] rtw88: Drop coex mutex
Date:   Mon, 30 May 2022 15:54:51 +0200
Message-Id: <20220530135457.1104091-5-s.hauer@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220530135457.1104091-1-s.hauer@pengutronix.de>
References: <20220530135457.1104091-1-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

coex->mutex is used in rtw_coex_info_request() only. Most callers of this
function hold rtwdev->mutex already, except for one callsite in the
debugfs code. The debugfs code alone doesn't justify the extra lock, so
acquire rtwdev->mutex there as well and drop the now unnecessary
spinlock.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/net/wireless/realtek/rtw88/coex.c  | 3 +--
 drivers/net/wireless/realtek/rtw88/debug.c | 2 ++
 drivers/net/wireless/realtek/rtw88/main.c  | 2 --
 drivers/net/wireless/realtek/rtw88/main.h  | 2 --
 4 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/coex.c b/drivers/net/wireless/realtek/rtw88/coex.c
index cac053f485c3b..b156f8c48ffbb 100644
--- a/drivers/net/wireless/realtek/rtw88/coex.c
+++ b/drivers/net/wireless/realtek/rtw88/coex.c
@@ -633,7 +633,7 @@ static struct sk_buff *rtw_coex_info_request(struct rtw_dev *rtwdev,
 	struct rtw_coex *coex = &rtwdev->coex;
 	struct sk_buff *skb_resp = NULL;
 
-	mutex_lock(&coex->mutex);
+	lockdep_assert_held(&rtwdev->mutex);
 
 	rtw_fw_query_bt_mp_info(rtwdev, req);
 
@@ -650,7 +650,6 @@ static struct sk_buff *rtw_coex_info_request(struct rtw_dev *rtwdev,
 	}
 
 out:
-	mutex_unlock(&coex->mutex);
 	return skb_resp;
 }
 
diff --git a/drivers/net/wireless/realtek/rtw88/debug.c b/drivers/net/wireless/realtek/rtw88/debug.c
index 79939aa6b752c..1453a32ea3ef0 100644
--- a/drivers/net/wireless/realtek/rtw88/debug.c
+++ b/drivers/net/wireless/realtek/rtw88/debug.c
@@ -842,7 +842,9 @@ static int rtw_debugfs_get_coex_info(struct seq_file *m, void *v)
 	struct rtw_debugfs_priv *debugfs_priv = m->private;
 	struct rtw_dev *rtwdev = debugfs_priv->rtwdev;
 
+	mutex_lock(&rtwdev->mutex);
 	rtw_coex_display_coex_info(rtwdev, m);
+	mutex_unlock(&rtwdev->mutex);
 
 	return 0;
 }
diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index baf4d29fde678..5afb8bef9696a 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -1998,7 +1998,6 @@ int rtw_core_init(struct rtw_dev *rtwdev)
 	spin_lock_init(&rtwdev->tx_report.q_lock);
 
 	mutex_init(&rtwdev->mutex);
-	mutex_init(&rtwdev->coex.mutex);
 	mutex_init(&rtwdev->hal.tx_power_mutex);
 
 	init_waitqueue_head(&rtwdev->coex.wait);
@@ -2066,7 +2065,6 @@ void rtw_core_deinit(struct rtw_dev *rtwdev)
 	}
 
 	mutex_destroy(&rtwdev->mutex);
-	mutex_destroy(&rtwdev->coex.mutex);
 	mutex_destroy(&rtwdev->hal.tx_power_mutex);
 }
 EXPORT_SYMBOL(rtw_core_deinit);
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index 619ee6e8d2807..fc27066a67a72 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -1507,8 +1507,6 @@ struct rtw_coex_stat {
 };
 
 struct rtw_coex {
-	/* protects coex info request section */
-	struct mutex mutex;
 	struct sk_buff_head queue;
 	wait_queue_head_t wait;
 
-- 
2.30.2

