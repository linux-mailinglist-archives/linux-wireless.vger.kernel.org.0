Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEAC376D34D
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Aug 2023 18:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235288AbjHBQHo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Aug 2023 12:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231887AbjHBQHj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Aug 2023 12:07:39 -0400
Received: from forward100a.mail.yandex.net (forward100a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B046F1BC1
        for <linux-wireless@vger.kernel.org>; Wed,  2 Aug 2023 09:07:34 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net [IPv6:2a02:6b8:c0f:26a7:0:640:a2d5:0])
        by forward100a.mail.yandex.net (Yandex) with ESMTP id C066642B22;
        Wed,  2 Aug 2023 19:07:29 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id S7VxvrADR8c0-jNmpETyK;
        Wed, 02 Aug 2023 19:07:29 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1690992449;
        bh=C7ljt6yolLIc6UBxKQQXhz/Xvxyzld6Ve3gsLz1Y7q8=;
        h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=Y7yMdmQcjaLep/He/rxzyuI5EsatU2qHyt9I6CII+4a4XLXPTnJhcaYPHC2R2gDGz
         VCYvG0aHzBwAwZI6AkRiYoKDpsqtocRXenyyPxrROuVWj0EehuvxNkMi4kMsy3NHYm
         NC24wL+w3z82xWUrhiHzPp5rSEFgy0eX9tOBSV5o=
Authentication-Results: mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Brian Norris <briannorris@chromium.org>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        lvc-project@linuxtesting.org, Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 2/5] [v3] wifi: mwifiex: cleanup private data structures
Date:   Wed,  2 Aug 2023 19:07:16 +0300
Message-ID: <20230802160726.85545-2-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230802160726.85545-1-dmantipov@yandex.ru>
References: <ZMlHCmjf2ZovExsP@google.com>
 <20230802160726.85545-1-dmantipov@yandex.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Drop unused fields 'status_code' of 'struct mwifiex_txinfo',
'dfs_chan_switch_timer', 'sleep_params' (including related data
type 'struct mwifiex_sleep_params') of 'struct mwifiex_adapter',
adjust related code.

Acked-by: Brian Norris <briannorris@chromium.org>
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
v3: add Acked-by: and reorder series
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
index 13c0e67ededf..d27b6e6493f3 100644
--- a/drivers/net/wireless/marvell/mwifiex/sta_tx.c
+++ b/drivers/net/wireless/marvell/mwifiex/sta_tx.c
@@ -42,7 +42,6 @@ void *mwifiex_process_sta_txpd(struct mwifiex_private *priv,
 	if (!skb->len) {
 		mwifiex_dbg(adapter, ERROR,
 			    "Tx: bad packet length: %d\n", skb->len);
-		tx_info->status_code = -1;
 		return skb->data;
 	}
 
diff --git a/drivers/net/wireless/marvell/mwifiex/uap_txrx.c b/drivers/net/wireless/marvell/mwifiex/uap_txrx.c
index 04ff051f5d18..360d36ceeb1d 100644
--- a/drivers/net/wireless/marvell/mwifiex/uap_txrx.c
+++ b/drivers/net/wireless/marvell/mwifiex/uap_txrx.c
@@ -474,7 +474,6 @@ void *mwifiex_process_uap_txpd(struct mwifiex_private *priv,
 	if (!skb->len) {
 		mwifiex_dbg(adapter, ERROR,
 			    "Tx: bad packet length: %d\n", skb->len);
-		tx_info->status_code = -1;
 		return skb->data;
 	}
 
-- 
2.41.0

