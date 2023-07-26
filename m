Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54A53762D31
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jul 2023 09:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232556AbjGZHYT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 26 Jul 2023 03:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232927AbjGZHX1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 26 Jul 2023 03:23:27 -0400
Received: from forward102c.mail.yandex.net (forward102c.mail.yandex.net [178.154.239.213])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD330420C
        for <linux-wireless@vger.kernel.org>; Wed, 26 Jul 2023 00:21:51 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-36.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-36.sas.yp-c.yandex.net [IPv6:2a02:6b8:c08:a497:0:640:fcbf:0])
        by forward102c.mail.yandex.net (Yandex) with ESMTP id A02E7600F4;
        Wed, 26 Jul 2023 10:21:49 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-36.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id kLF1MPmWs8c0-OByCwYfA;
        Wed, 26 Jul 2023 10:21:49 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1690356109;
        bh=DobDr6a+SkCqG79SnvqDOTC5UEGFmyOiHQ28zM8Lyto=;
        h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=F45uKF337zFJcSAu6V7dY4/4pWQJYufIspo8l4JcH4hPihe9hWDMwlUzVFrT8/al9
         wols1wcpxEEAic83M1s10TBZMm2Yh7odJwjZB4TumsBzhOXI6Qn1xEoeXU4Ojxpl5P
         isRtjLYRbgRyRr/d2iJ+anA1n/QIQ3tyeaIIk/6w=
Authentication-Results: mail-nwsmtp-smtp-production-main-36.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Brian Norris <briannorris@chromium.org>,
        linux-wireless@vger.kernel.org, lvc-project@linuxtesting.org,
        Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 3/5] wifi: mwifiex: cleanup private data structures
Date:   Wed, 26 Jul 2023 10:20:54 +0300
Message-ID: <20230726072114.51964-3-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230726072114.51964-1-dmantipov@yandex.ru>
References: <20230726072114.51964-1-dmantipov@yandex.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Drop unused and set but unused fields 'status_code' of 'struct
mwifiex_txinfo', 'sleep_params' (including related data type
'struct mwifiex_sleep_params') and 'dfs_chan_switch_timer' of
'struct mwifiex_adapter', adjust related code.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/net/wireless/marvell/mwifiex/decl.h     |  1 -
 drivers/net/wireless/marvell/mwifiex/init.c     |  1 -
 drivers/net/wireless/marvell/mwifiex/main.h     | 11 -----------
 drivers/net/wireless/marvell/mwifiex/sta_tx.c   |  1 -
 drivers/net/wireless/marvell/mwifiex/uap_txrx.c |  1 -
 5 files changed, 15 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/decl.h b/drivers/net/wireless/marvell/mwifiex/decl.h
index 88648c062713..326ffb05d791 100644
--- a/drivers/net/wireless/marvell/mwifiex/decl.h
+++ b/drivers/net/wireless/marvell/mwifiex/decl.h
@@ -180,7 +180,6 @@ struct mwifiex_rxinfo {
 };
 
 struct mwifiex_txinfo {
-	u32 status_code;
 	u8 flags;
 	u8 bss_num;
 	u8 bss_type;
diff --git a/drivers/net/wireless/marvell/mwifiex/init.c b/drivers/net/wireless/marvell/mwifiex/init.c
index 7dddb4b5dea1..86293be782a2 100644
--- a/drivers/net/wireless/marvell/mwifiex/init.c
+++ b/drivers/net/wireless/marvell/mwifiex/init.c
@@ -282,7 +282,6 @@ static void mwifiex_init_adapter(struct mwifiex_adapter *adapter)
 	sleep_cfm_buf->action = cpu_to_le16(SLEEP_CONFIRM);
 	sleep_cfm_buf->resp_ctrl = cpu_to_le16(RESP_NEEDED);
 
-	memset(&adapter->sleep_params, 0, sizeof(adapter->sleep_params));
 	memset(&adapter->sleep_period, 0, sizeof(adapter->sleep_period));
 	adapter->tx_lock_flag = false;
 	adapter->null_pkt_interval = 0;
diff --git a/drivers/net/wireless/marvell/mwifiex/main.h b/drivers/net/wireless/marvell/mwifiex/main.h
index b95886e1413e..7421e9bf8650 100644
--- a/drivers/net/wireless/marvell/mwifiex/main.h
+++ b/drivers/net/wireless/marvell/mwifiex/main.h
@@ -444,15 +444,6 @@ struct mwifiex_current_bss_params {
 	u8 data_rates[MWIFIEX_SUPPORTED_RATES];
 };
 
-struct mwifiex_sleep_params {
-	u16 sp_error;
-	u16 sp_offset;
-	u16 sp_stable_time;
-	u8 sp_cal_control;
-	u8 sp_ext_sleep_clk;
-	u16 sp_reserved;
-};
-
 struct mwifiex_sleep_period {
 	u16 period;
 	u16 reserved;
@@ -681,7 +672,6 @@ struct mwifiex_private {
 	struct cfg80211_chan_def dfs_chandef;
 	struct workqueue_struct *dfs_cac_workqueue;
 	struct delayed_work dfs_cac_work;
-	struct timer_list dfs_chan_switch_timer;
 	struct workqueue_struct *dfs_chan_sw_workqueue;
 	struct delayed_work dfs_chan_sw_work;
 	struct cfg80211_beacon_data beacon_after;
@@ -955,7 +945,6 @@ struct mwifiex_adapter {
 	u8 config_bands;
 	struct mwifiex_chan_scan_param_set *scan_channels;
 	u8 tx_lock_flag;
-	struct mwifiex_sleep_params sleep_params;
 	struct mwifiex_sleep_period sleep_period;
 	u16 ps_mode;
 	u32 ps_state;
diff --git a/drivers/net/wireless/marvell/mwifiex/sta_tx.c b/drivers/net/wireless/marvell/mwifiex/sta_tx.c
index 5995a81f1ce9..b36877ee1bb7 100644
--- a/drivers/net/wireless/marvell/mwifiex/sta_tx.c
+++ b/drivers/net/wireless/marvell/mwifiex/sta_tx.c
@@ -41,7 +41,6 @@ void *mwifiex_process_sta_txpd(struct mwifiex_private *priv,
 
 	if (unlikely(!skb->len)) {
 		mwifiex_dbg(adapter, ERROR, "Tx: empty skb\n");
-		tx_info->status_code = -1;
 		return skb->data;
 	}
 	if (unlikely(skb_headroom(skb) < MWIFIEX_MIN_DATA_HEADER_LEN)) {
diff --git a/drivers/net/wireless/marvell/mwifiex/uap_txrx.c b/drivers/net/wireless/marvell/mwifiex/uap_txrx.c
index ff953e8e7413..d610e07a3051 100644
--- a/drivers/net/wireless/marvell/mwifiex/uap_txrx.c
+++ b/drivers/net/wireless/marvell/mwifiex/uap_txrx.c
@@ -454,7 +454,6 @@ void *mwifiex_process_uap_txpd(struct mwifiex_private *priv,
 
 	if (unlikely(!skb->len)) {
 		mwifiex_dbg(adapter, ERROR, "Tx: empty skb\n");
-		tx_info->status_code = -1;
 		return skb->data;
 	}
 	if (unlikely(skb_headroom(skb) < MWIFIEX_MIN_DATA_HEADER_LEN)) {
-- 
2.41.0

