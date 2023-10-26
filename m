Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17DD77D8447
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Oct 2023 16:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345135AbjJZOLz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Oct 2023 10:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345110AbjJZOLz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Oct 2023 10:11:55 -0400
Received: from forward100a.mail.yandex.net (forward100a.mail.yandex.net [178.154.239.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88BC51A2
        for <linux-wireless@vger.kernel.org>; Thu, 26 Oct 2023 07:11:49 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-64.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-64.vla.yp-c.yandex.net [IPv6:2a02:6b8:c0f:170e:0:640:d60c:0])
        by forward100a.mail.yandex.net (Yandex) with ESMTP id 0A8D646C8B;
        Thu, 26 Oct 2023 17:11:47 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-64.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id kBR2w36DV8c0-E7LlFLlg;
        Thu, 26 Oct 2023 17:11:46 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
        t=1698329506; bh=ifNb91q8pbjGI7gl6T7qE0+WJGGVr8YNRKUyHzVd1g0=;
        h=Message-ID:Date:Cc:Subject:To:From;
        b=LkpHUZeYcJnDAd/eiH26+DGcycMKU2MzTg0bNyEbAEOHQLT8g2cJ1RUdEq64AVyHc
         0dEkIqfCMM9t18Pia10SSPyorrMo4oZm30BRjfBDyRwSfIXc7m3P0PX7adPNtFoVol
         DhLAY4UN1M06buoaeKZZXO5Nbt8LYNwVevsyHh5g=
Authentication-Results: mail-nwsmtp-smtp-production-main-64.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Ajay Singh <ajay.kathat@microchip.com>
Cc:     Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 1/2] wifi: wilc1000: simplify remain on channel support
Date:   Thu, 26 Oct 2023 17:10:11 +0300
Message-ID: <20231026141016.71407-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

For 'struct wilc_remain_ch', drop set but otherwise unused 'duration'
field and adjust 'expired' callback assuming that the only data passed
to it is 'struct wilc_vif *', thus making 'wilc_remain_on_channel()'
a bit simpler as well. Compile tested only.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/net/wireless/microchip/wilc1000/cfg80211.c |  8 +++-----
 drivers/net/wireless/microchip/wilc1000/hif.c      | 13 +++++--------
 drivers/net/wireless/microchip/wilc1000/hif.h      | 13 +++++--------
 3 files changed, 13 insertions(+), 21 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/cfg80211.c b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
index da52f91693b5..bf2a60533506 100644
--- a/drivers/net/wireless/microchip/wilc1000/cfg80211.c
+++ b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
@@ -1094,9 +1094,8 @@ static void wilc_wfi_mgmt_tx_complete(void *priv, int status)
 	kfree(pv_data);
 }
 
-static void wilc_wfi_remain_on_channel_expired(void *data, u64 cookie)
+static void wilc_wfi_remain_on_channel_expired(struct wilc_vif *vif, u64 cookie)
 {
-	struct wilc_vif *vif = data;
 	struct wilc_priv *priv = &vif->priv;
 	struct wilc_wfi_p2p_listen_params *params = &priv->remain_on_ch_params;
 
@@ -1128,9 +1127,8 @@ static int remain_on_channel(struct wiphy *wiphy,
 	if (id == 0)
 		id = ++priv->inc_roc_cookie;
 
-	ret = wilc_remain_on_channel(vif, id, duration, chan->hw_value,
-				     wilc_wfi_remain_on_channel_expired,
-				     (void *)vif);
+	ret = wilc_remain_on_channel(vif, id, chan->hw_value,
+				     wilc_wfi_remain_on_channel_expired);
 	if (ret)
 		return ret;
 
diff --git a/drivers/net/wireless/microchip/wilc1000/hif.c b/drivers/net/wireless/microchip/wilc1000/hif.c
index a28da5938481..2c42683dd5fb 100644
--- a/drivers/net/wireless/microchip/wilc1000/hif.c
+++ b/drivers/net/wireless/microchip/wilc1000/hif.c
@@ -878,7 +878,7 @@ static int handle_remain_on_chan(struct wilc_vif *vif,
 	if (result)
 		return -EBUSY;
 
-	hif_drv->remain_on_ch.arg = hif_remain_ch->arg;
+	hif_drv->remain_on_ch.vif = hif_remain_ch->vif;
 	hif_drv->remain_on_ch.expired = hif_remain_ch->expired;
 	hif_drv->remain_on_ch.ch = hif_remain_ch->ch;
 	hif_drv->remain_on_ch.cookie = hif_remain_ch->cookie;
@@ -915,7 +915,7 @@ static int wilc_handle_roc_expired(struct wilc_vif *vif, u64 cookie)
 		}
 
 		if (hif_drv->remain_on_ch.expired) {
-			hif_drv->remain_on_ch.expired(hif_drv->remain_on_ch.arg,
+			hif_drv->remain_on_ch.expired(hif_drv->remain_on_ch.vif,
 						      cookie);
 		}
 	} else {
@@ -1669,18 +1669,15 @@ void wilc_scan_complete_received(struct wilc *wilc, u8 *buffer, u32 length)
 	}
 }
 
-int wilc_remain_on_channel(struct wilc_vif *vif, u64 cookie,
-			   u32 duration, u16 chan,
-			   void (*expired)(void *, u64),
-			   void *user_arg)
+int wilc_remain_on_channel(struct wilc_vif *vif, u64 cookie, u16 chan,
+			   void (*expired)(struct wilc_vif *, u64))
 {
 	struct wilc_remain_ch roc;
 	int result;
 
 	roc.ch = chan;
 	roc.expired = expired;
-	roc.arg = user_arg;
-	roc.duration = duration;
+	roc.vif = vif;
 	roc.cookie = cookie;
 	result = handle_remain_on_chan(vif, &roc);
 	if (result)
diff --git a/drivers/net/wireless/microchip/wilc1000/hif.h b/drivers/net/wireless/microchip/wilc1000/hif.h
index 8e386db72e45..b0cb35590027 100644
--- a/drivers/net/wireless/microchip/wilc1000/hif.h
+++ b/drivers/net/wireless/microchip/wilc1000/hif.h
@@ -118,11 +118,11 @@ struct wilc_conn_info {
 	void *param;
 };
 
+struct wilc_vif;
 struct wilc_remain_ch {
 	u16 ch;
-	u32 duration;
-	void (*expired)(void *priv, u64 cookie);
-	void *arg;
+	void (*expired)(struct wilc_vif *vif, u64 cookie);
+	struct wilc_vif *vif;
 	u64 cookie;
 };
 
@@ -150,7 +150,6 @@ struct host_if_drv {
 	u8 assoc_resp[WILC_MAX_ASSOC_RESP_FRAME_SIZE];
 };
 
-struct wilc_vif;
 int wilc_add_ptk(struct wilc_vif *vif, const u8 *ptk, u8 ptk_key_len,
 		 const u8 *mac_addr, const u8 *rx_mic, const u8 *tx_mic,
 		 u8 mode, u8 cipher_mode, u8 index);
@@ -192,10 +191,8 @@ int wilc_edit_station(struct wilc_vif *vif, const u8 *mac,
 int wilc_set_power_mgmt(struct wilc_vif *vif, bool enabled, u32 timeout);
 int wilc_setup_multicast_filter(struct wilc_vif *vif, u32 enabled, u32 count,
 				u8 *mc_list);
-int wilc_remain_on_channel(struct wilc_vif *vif, u64 cookie,
-			   u32 duration, u16 chan,
-			   void (*expired)(void *, u64),
-			   void *user_arg);
+int wilc_remain_on_channel(struct wilc_vif *vif, u64 cookie, u16 chan,
+			   void (*expired)(struct wilc_vif *, u64));
 int wilc_listen_state_expired(struct wilc_vif *vif, u64 cookie);
 void wilc_frame_register(struct wilc_vif *vif, u16 frame_type, bool reg);
 int wilc_set_operation_mode(struct wilc_vif *vif, int index, u8 mode,
-- 
2.41.0

