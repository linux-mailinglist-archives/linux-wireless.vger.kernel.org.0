Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4C5739793
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Jun 2023 08:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbjFVGof (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 22 Jun 2023 02:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbjFVGod (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 22 Jun 2023 02:44:33 -0400
Received: from forward100c.mail.yandex.net (forward100c.mail.yandex.net [IPv6:2a02:6b8:c03:500:1:45:d181:d100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B515519B4
        for <linux-wireless@vger.kernel.org>; Wed, 21 Jun 2023 23:44:31 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-63.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-63.sas.yp-c.yandex.net [IPv6:2a02:6b8:c14:6e01:0:640:627f:0])
        by forward100c.mail.yandex.net (Yandex) with ESMTP id 10E2A600A1;
        Thu, 22 Jun 2023 09:44:29 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-63.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id Qi9Pt8GDVCg0-CT9uh7et;
        Thu, 22 Jun 2023 09:44:28 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1687416268;
        bh=mj6D8KoSJLwJO6tIHiTVnNO4bS7keggGkDu4w/OgoeA=;
        h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=GcTyhldjP3RkMtgBbxByp+ZIaN7YggMWTnkfN3tfO81OLqNKFy8sMIhGWe4goLwfb
         b/uEGPsslyQ0p7F0Biu/o573M7dhk/8utCkuvjAmTxqoT5NgmztdrMjuZL9QdZlWjI
         T2CUKYcZ9fOeuLnOjW70JaOfw1s+fAP7snWWxauE=
Authentication-Results: mail-nwsmtp-smtp-production-main-63.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Po-Hao Huang <phhuang@realtek.com>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        Dmitry Antipov <dmantipov@yandex.ru>,
        Ping-Ke Shih <pkshih@realtek.com>
Subject: [PATCH 2/4] [v5] wifi: rtw88: remove unused and set but unused leftovers
Date:   Thu, 22 Jun 2023 09:44:16 +0300
Message-ID: <20230622064424.38498-2-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230622064424.38498-1-dmantipov@yandex.ru>
References: <20230622064424.38498-1-dmantipov@yandex.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Drop unused and set but unused 'last_push' of 'struct rtw_txq',
'wireless_set' of 'struct rtw_sta_info', 'usb_txagg_num' of
'struct rtw_usb' and 'n' of 'struct rx_usb_ctrl_block', adjust
related code.

Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
v5: adjust to match recent changes
v4: adjust to match series
---
 drivers/net/wireless/realtek/rtw88/main.c | 1 -
 drivers/net/wireless/realtek/rtw88/main.h | 3 ---
 drivers/net/wireless/realtek/rtw88/tx.c   | 2 --
 drivers/net/wireless/realtek/rtw88/usb.c  | 1 -
 drivers/net/wireless/realtek/rtw88/usb.h  | 2 --
 5 files changed, 9 deletions(-)

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
index f9dd2ab941c8..8ba53df0ad19 100644
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

