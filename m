Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F4176740B22
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Jun 2023 10:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234320AbjF1IWe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 28 Jun 2023 04:22:34 -0400
Received: from forward206a.mail.yandex.net ([178.154.239.87]:47028 "EHLO
        forward206a.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234191AbjF1IO6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 28 Jun 2023 04:14:58 -0400
Received: from forward100a.mail.yandex.net (forward100a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d100])
        by forward206a.mail.yandex.net (Yandex) with ESMTP id 4D74D48B5B
        for <linux-wireless@vger.kernel.org>; Wed, 28 Jun 2023 10:24:04 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-64.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-64.vla.yp-c.yandex.net [IPv6:2a02:6b8:c0f:170e:0:640:d60c:0])
        by forward100a.mail.yandex.net (Yandex) with ESMTP id 85F1946D68;
        Wed, 28 Jun 2023 10:24:00 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-64.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id uNGuVj7DSKo0-nmkPQuhG;
        Wed, 28 Jun 2023 10:24:00 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1687937040;
        bh=iIFkOYWFmlXHtew25tqmTnOh/8dvH3PP3FqxJxsDY/M=;
        h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=Ks7m7utqg7kk/WPKLh72Ys5jfTM89/khl3E5yI1Xx5LwXRbByDGzhMHUqqPpUOC48
         Bfxh1BuRmRE5kWZHws+kJum/XtXXr/u8ShIzJr75k8ZX0E1Myno0k7itteKmx7igDN
         3LfjPvpKwqddU57LqTxEZWiwAohQ6Sq1qiIZ0bqg=
Authentication-Results: mail-nwsmtp-smtp-production-main-64.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Po-Hao Huang <phhuang@realtek.com>
Cc:     linux-wireless@vger.kernel.org, Ping-Ke Shih <pkshih@realtek.com>,
        Kalle Valo <kvalo@kernel.org>,
        Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 2/4] [v6] wifi: rtw88: remove unused and set but unused leftovers
Date:   Wed, 28 Jun 2023 10:23:16 +0300
Message-ID: <20230628072327.167196-2-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230628072327.167196-1-dmantipov@yandex.ru>
References: <20230628072327.167196-1-dmantipov@yandex.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Drop unused and set but unused 'last_push' of 'struct rtw_txq',
'wireless_set' of 'struct rtw_sta_info', 'usb_txagg_num' of
'struct rtw_usb' and 'n' of 'struct rx_usb_ctrl_block', unused
definition of 'struct rtw_timer_list', adjust related code.

Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
v6: drop unused 'struct rtw_timer_list' as well
v5: adjust to match recent changes
v4: adjust to match series
---
 drivers/net/wireless/realtek/rtw88/main.c | 1 -
 drivers/net/wireless/realtek/rtw88/main.h | 9 ---------
 drivers/net/wireless/realtek/rtw88/tx.c   | 2 --
 drivers/net/wireless/realtek/rtw88/usb.c  | 1 -
 drivers/net/wireless/realtek/rtw88/usb.h  | 2 --
 5 files changed, 15 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index c2ddb4d382af..935022246fd4 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -1303,7 +1303,6 @@ void rtw_update_sta_info(struct rtw_dev *rtwdev, struct rtw_sta_info *si,
 	si->stbc_en = stbc_en;
 	si->ldpc_en = ldpc_en;
 	si->rf_type = rf_type;
-	si->wireless_set = wireless_set;
 	si->sgi_enable = is_support_sgi;
 	si->vht_enable = is_vht_enable;
 	si->ra_mask = ra_mask;
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index f9dd2ab941c8..c42ef8294d59 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -511,12 +511,6 @@ struct rtw_txpwr_idx {
 	struct rtw_5g_txpwr_idx pwr_idx_5g;
 };
 
-struct rtw_timer_list {
-	struct timer_list timer;
-	void (*function)(void *data);
-	void *args;
-};
-
 struct rtw_channel_params {
 	u8 center_chan;
 	u8 primary_chan;
@@ -734,9 +728,7 @@ struct rtw_ra_report {
 
 struct rtw_txq {
 	struct list_head list;
-
 	unsigned long flags;
-	unsigned long last_push;
 };
 
 #define RTW_BC_MC_MACID 1
@@ -754,7 +746,6 @@ struct rtw_sta_info {
 	u8 rate_id;
 	enum rtw_bandwidth bw_mode;
 	enum rtw_rf_type rf_type;
-	enum rtw_wireless_set wireless_set;
 	u8 stbc_en:2;
 	u8 ldpc_en:2;
 	bool sgi_enable;
diff --git a/drivers/net/wireless/realtek/rtw88/tx.c b/drivers/net/wireless/realtek/rtw88/tx.c
index 2821119dc930..f63900b6621d 100644
--- a/drivers/net/wireless/realtek/rtw88/tx.c
+++ b/drivers/net/wireless/realtek/rtw88/tx.c
@@ -606,8 +606,6 @@ static int rtw_txq_push_skb(struct rtw_dev *rtwdev,
 		rtw_err(rtwdev, "failed to write TX skb to HCI\n");
 		return ret;
 	}
-	rtwtxq->last_push = jiffies;
-
 	return 0;
 }
 
diff --git a/drivers/net/wireless/realtek/rtw88/usb.c b/drivers/net/wireless/realtek/rtw88/usb.c
index 4a57efdba97b..0458ab02a89f 100644
--- a/drivers/net/wireless/realtek/rtw88/usb.c
+++ b/drivers/net/wireless/realtek/rtw88/usb.c
@@ -654,7 +654,6 @@ static int rtw_usb_alloc_rx_bufs(struct rtw_usb *rtwusb)
 	for (i = 0; i < RTW_USB_RXCB_NUM; i++) {
 		struct rx_usb_ctrl_block *rxcb = &rtwusb->rx_cb[i];
 
-		rxcb->n = i;
 		rxcb->rtwdev = rtwusb->rtwdev;
 		rxcb->rx_urb = usb_alloc_urb(0, GFP_KERNEL);
 		if (!rxcb->rx_urb)
diff --git a/drivers/net/wireless/realtek/rtw88/usb.h b/drivers/net/wireless/realtek/rtw88/usb.h
index ad1d7955c6a5..fad998005ec8 100644
--- a/drivers/net/wireless/realtek/rtw88/usb.h
+++ b/drivers/net/wireless/realtek/rtw88/usb.h
@@ -58,7 +58,6 @@ struct rx_usb_ctrl_block {
 	struct rtw_dev *rtwdev;
 	struct urb *rx_urb;
 	struct sk_buff *rx_skb;
-	int n;
 };
 
 struct rtw_usb_tx_data {
@@ -79,7 +78,6 @@ struct rtw_usb {
 	u8 pipe_in;
 	u8 out_ep[RTW_USB_EP_MAX];
 	int qsel_to_ep[TX_DESC_QSEL_MAX];
-	u8 usb_txagg_num;
 
 	struct workqueue_struct *txwq, *rxwq;
 
-- 
2.41.0

