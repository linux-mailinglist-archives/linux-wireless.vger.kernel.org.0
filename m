Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FABC732ABF
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jun 2023 10:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245031AbjFPI7e (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 16 Jun 2023 04:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbjFPI7c (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 16 Jun 2023 04:59:32 -0400
Received: from forward103a.mail.yandex.net (forward103a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2FD230C5
        for <linux-wireless@vger.kernel.org>; Fri, 16 Jun 2023 01:59:30 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-52.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-52.vla.yp-c.yandex.net [IPv6:2a02:6b8:c15:2f8a:0:640:b50b:0])
        by forward103a.mail.yandex.net (Yandex) with ESMTP id 544A946CF1;
        Fri, 16 Jun 2023 11:59:28 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-52.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id JxYhO6BDda60-SX1yVKkr;
        Fri, 16 Jun 2023 11:59:27 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1686905967;
        bh=KjstYsp1If2Wm0TxmNJNyIL481l9+ldp/VIkcBPqoPg=;
        h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=VIqg4MH19Vf4dxrGXG/gs2Fe1dbtP6s5WTDuysCexcdf9Bn9veml23yegZ3Y/Sigc
         TZmJ1wvyTf3W5o8ZPNF9WoAyjP/LqHuPNtu/a96BDIlbMKqQPnyPCsyGH0rany+yKo
         esfQDCxRbPQmrqkLMw8SBrNo7zEAP3tm1dk7FU3c=
Authentication-Results: mail-nwsmtp-smtp-production-main-52.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 2/3] [v3] wifi: rtw88: remove unused and set but unused leftovers
Date:   Fri, 16 Jun 2023 11:59:16 +0300
Message-Id: <20230616085917.60662-2-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230616085917.60662-1-dmantipov@yandex.ru>
References: <20230616085917.60662-1-dmantipov@yandex.ru>
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

Drop unused and set but unused 'last_push' of 'struct rtw_txq',
'wireless_set' of 'struct rtw_sta_info', 'usb_txagg_num' of
'struct rtw_usb' and 'n' of 'struct rx_usb_ctrl_block', adjust
related code.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/net/wireless/realtek/rtw88/main.c | 1 -
 drivers/net/wireless/realtek/rtw88/main.h | 3 ---
 drivers/net/wireless/realtek/rtw88/tx.c   | 2 --
 drivers/net/wireless/realtek/rtw88/usb.c  | 1 -
 drivers/net/wireless/realtek/rtw88/usb.h  | 2 --
 5 files changed, 9 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index c190598c47c3..64fd527286e1 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -1300,7 +1300,6 @@ void rtw_update_sta_info(struct rtw_dev *rtwdev, struct rtw_sta_info *si,
 	si->stbc_en = stbc_en;
 	si->ldpc_en = ldpc_en;
 	si->rf_type = rf_type;
-	si->wireless_set = wireless_set;
 	si->sgi_enable = is_support_sgi;
 	si->vht_enable = is_vht_enable;
 	si->ra_mask = ra_mask;
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index 9e841f6991a9..265ae9456f06 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -734,9 +734,7 @@ struct rtw_ra_report {
 
 struct rtw_txq {
 	struct list_head list;
-
 	unsigned long flags;
-	unsigned long last_push;
 };
 
 #define RTW_BC_MC_MACID 1
@@ -754,7 +752,6 @@ struct rtw_sta_info {
 	u8 rate_id;
 	enum rtw_bandwidth bw_mode;
 	enum rtw_rf_type rf_type;
-	enum rtw_wireless_set wireless_set;
 	u8 stbc_en:2;
 	u8 ldpc_en:2;
 	bool sgi_enable;
diff --git a/drivers/net/wireless/realtek/rtw88/tx.c b/drivers/net/wireless/realtek/rtw88/tx.c
index bb5c7492c98b..3a4c37fdfeb1 100644
--- a/drivers/net/wireless/realtek/rtw88/tx.c
+++ b/drivers/net/wireless/realtek/rtw88/tx.c
@@ -592,8 +592,6 @@ static int rtw_txq_push_skb(struct rtw_dev *rtwdev,
 		rtw_err(rtwdev, "failed to write TX skb to HCI\n");
 		return ret;
 	}
-	rtwtxq->last_push = jiffies;
-
 	return 0;
 }
 
diff --git a/drivers/net/wireless/realtek/rtw88/usb.c b/drivers/net/wireless/realtek/rtw88/usb.c
index 976eafa739a2..6862338b1d51 100644
--- a/drivers/net/wireless/realtek/rtw88/usb.c
+++ b/drivers/net/wireless/realtek/rtw88/usb.c
@@ -647,7 +647,6 @@ static int rtw_usb_alloc_rx_bufs(struct rtw_usb *rtwusb)
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
2.40.1

