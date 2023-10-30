Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCF917DB62C
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Oct 2023 10:32:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232375AbjJ3JcW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 30 Oct 2023 05:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232119AbjJ3JcW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 30 Oct 2023 05:32:22 -0400
Received: from forward102b.mail.yandex.net (forward102b.mail.yandex.net [178.154.239.149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B648EC2
        for <linux-wireless@vger.kernel.org>; Mon, 30 Oct 2023 02:32:18 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-canary-88.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-canary-88.sas.yp-c.yandex.net [IPv6:2a02:6b8:c08:1215:0:640:367b:0])
        by forward102b.mail.yandex.net (Yandex) with ESMTP id 4259B60A0D;
        Mon, 30 Oct 2023 12:32:16 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-canary-88.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id EWQQNA6DUSw0-ehvIU30n;
        Mon, 30 Oct 2023 12:32:15 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
        t=1698658335; bh=a/6m2uyajbW6paY5Zjoty3+34P9R0PKQ3eH/5xAjz1o=;
        h=Message-ID:Date:Cc:Subject:To:From;
        b=gBuCyBwwY/M0PBiLytMxvuBByjhzRnVrYaP/ovWb0G5nY75daoGB7EBxkX0ZwIYkf
         9pzlPI8gILsSfLBXJRV18GpjtFh4mFBGZkFVgp/25PsrzvLT3LHkf34gU/mk2myMg6
         9HREle336vU1alwZT637tPPiIFgNdckr4Jd/5DvM=
Authentication-Results: mail-nwsmtp-smtp-production-canary-88.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 1/2] wifi: rtw88: simplify rtw_chip_cfg_csi_rate()
Date:   Mon, 30 Oct 2023 12:31:38 +0300
Message-ID: <20231030093144.82504-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Since fix rate flag in 'rtw_dynamic_csi_rate()' is a hardcoded
zero and actually unused in an underlying 'rtw_bf_cfg_csi_rate()',
simplify 'rtw_chip_cfg_csi_rate()' by dropping last argument and
adjust '(*cfg_csi_rate)()' of 'struct rtw_chip_ops' accordingly.

Briefly tested on the following USB dongle:

usb 3-6: new high-speed USB device number 7 using xhci_hcd
usb 3-6: New USB device found, idVendor=0bda, idProduct=b812, bcdDevice=2.10
usb 3-6: New USB device strings: Mfr=1, Product=2, SerialNumber=3
usb 3-6: Product: USB3.0 802.11ac 1200M Adapter
usb 3-6: Manufacturer: Realtek
usb 3-6: SerialNumber: 123456
rtw_8822bu 3-6:1.0: Firmware version 27.2.0, H2C version 13
usbcore: registered new interface driver rtw_8822bu

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/net/wireless/realtek/rtw88/bf.c   | 2 +-
 drivers/net/wireless/realtek/rtw88/bf.h   | 9 +++++----
 drivers/net/wireless/realtek/rtw88/main.c | 4 +---
 drivers/net/wireless/realtek/rtw88/main.h | 2 +-
 4 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/bf.c b/drivers/net/wireless/realtek/rtw88/bf.c
index c827c4a2814b..8cf87c30adc2 100644
--- a/drivers/net/wireless/realtek/rtw88/bf.c
+++ b/drivers/net/wireless/realtek/rtw88/bf.c
@@ -379,7 +379,7 @@ void rtw_bf_phy_init(struct rtw_dev *rtwdev)
 EXPORT_SYMBOL(rtw_bf_phy_init);
 
 void rtw_bf_cfg_csi_rate(struct rtw_dev *rtwdev, u8 rssi, u8 cur_rate,
-			 u8 fixrate_en, u8 *new_rate)
+			 u8 *new_rate)
 {
 	u32 csi_cfg;
 	u16 cur_rrsr;
diff --git a/drivers/net/wireless/realtek/rtw88/bf.h b/drivers/net/wireless/realtek/rtw88/bf.h
index 7b40c2c03856..1f47c6324240 100644
--- a/drivers/net/wireless/realtek/rtw88/bf.h
+++ b/drivers/net/wireless/realtek/rtw88/bf.h
@@ -91,7 +91,8 @@ void rtw_bf_set_gid_table(struct rtw_dev *rtwdev, struct ieee80211_vif *vif,
 			  struct ieee80211_bss_conf *conf);
 void rtw_bf_phy_init(struct rtw_dev *rtwdev);
 void rtw_bf_cfg_csi_rate(struct rtw_dev *rtwdev, u8 rssi, u8 cur_rate,
-			 u8 fixrate_en, u8 *new_rate);
+			 u8 *new_rate);
+
 static inline void rtw_chip_config_bfee(struct rtw_dev *rtwdev, struct rtw_vif *vif,
 					struct rtw_bfee *bfee, bool enable)
 {
@@ -107,11 +108,11 @@ static inline void rtw_chip_set_gid_table(struct rtw_dev *rtwdev,
 		rtwdev->chip->ops->set_gid_table(rtwdev, vif, conf);
 }
 
-static inline void rtw_chip_cfg_csi_rate(struct rtw_dev *rtwdev, u8 rssi, u8 cur_rate,
-					 u8 fixrate_en, u8 *new_rate)
+static inline void rtw_chip_cfg_csi_rate(struct rtw_dev *rtwdev, u8 rssi,
+					 u8 cur_rate, u8 *new_rate)
 {
 	if (rtwdev->chip->ops->cfg_csi_rate)
 		rtwdev->chip->ops->cfg_csi_rate(rtwdev, rssi, cur_rate,
-						fixrate_en, new_rate);
+						new_rate);
 }
 #endif
diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index 4a33d2e47f33..4ea2f09709b0 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -170,7 +170,6 @@ struct rtw_watch_dog_iter_data {
 static void rtw_dynamic_csi_rate(struct rtw_dev *rtwdev, struct rtw_vif *rtwvif)
 {
 	struct rtw_bf_info *bf_info = &rtwdev->bf_info;
-	u8 fix_rate_enable = 0;
 	u8 new_csi_rate_idx;
 
 	if (rtwvif->bfee.role != RTW_BFEE_SU &&
@@ -178,8 +177,7 @@ static void rtw_dynamic_csi_rate(struct rtw_dev *rtwdev, struct rtw_vif *rtwvif)
 		return;
 
 	rtw_chip_cfg_csi_rate(rtwdev, rtwdev->dm_info.min_rssi,
-			      bf_info->cur_csi_rpt_rate,
-			      fix_rate_enable, &new_csi_rate_idx);
+			      bf_info->cur_csi_rpt_rate, &new_csi_rate_idx);
 
 	if (new_csi_rate_idx != bf_info->cur_csi_rpt_rate)
 		bf_info->cur_csi_rpt_rate = new_csi_rate_idx;
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index b6bfd4c02e2d..835898a170df 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -872,7 +872,7 @@ struct rtw_chip_ops {
 			      struct ieee80211_vif *vif,
 			      struct ieee80211_bss_conf *conf);
 	void (*cfg_csi_rate)(struct rtw_dev *rtwdev, u8 rssi, u8 cur_rate,
-			     u8 fixrate_en, u8 *new_rate);
+			     u8 *new_rate);
 	void (*adaptivity_init)(struct rtw_dev *rtwdev);
 	void (*adaptivity)(struct rtw_dev *rtwdev);
 	void (*cfo_init)(struct rtw_dev *rtwdev);
-- 
2.41.0

