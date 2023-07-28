Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0028A766787
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Jul 2023 10:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235108AbjG1Ioh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Jul 2023 04:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjG1IoV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Jul 2023 04:44:21 -0400
Received: from forward103c.mail.yandex.net (forward103c.mail.yandex.net [IPv6:2a02:6b8:c03:500:1:45:d181:d103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01FA0269E
        for <linux-wireless@vger.kernel.org>; Fri, 28 Jul 2023 01:44:19 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-18.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-18.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:a712:0:640:d986:0])
        by forward103c.mail.yandex.net (Yandex) with ESMTP id 771BE60024;
        Fri, 28 Jul 2023 11:44:18 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-18.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id EiIwG59DYW20-9iJCj6uV;
        Fri, 28 Jul 2023 11:44:17 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1690533858;
        bh=oiMgKnqI9z8BNt3/nCM7TktyaZSbKJChWemgIGZow8I=;
        h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=vkvOkmLDLsMLgYmZuD/fEfJ43ydtUiBH+p/5KxOdQFsKJZOyYGBYKDtXAGuVjYUcG
         49Mt943+oCnxSNSUdi/U5qi7mY9R7st+Fm/X9sSgF3dBaIDg/lrQCWefbUaKAY/aDU
         BbR7LeecgjmoJoKQC2n1ZL/QUMe1ljiwIBcXiI3w=
Authentication-Results: mail-nwsmtp-smtp-production-main-18.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Brian Norris <briannorris@chromium.org>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        lvc-project@linuxtesting.org, Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 3/5] [v2] wifi: mwifiex: cleanup private data structures
Date:   Fri, 28 Jul 2023 11:43:44 +0300
Message-ID: <20230728084407.101930-3-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230728084407.101930-1-dmantipov@yandex.ru>
References: <ZMFzBStAKemf+dLL@google.com>
 <20230728084407.101930-1-dmantipov@yandex.ru>
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

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
v2: adjust to match series
---
 drivers/net/wireless/marvell/mwifiex/decl.h |  1 -
 drivers/net/wireless/marvell/mwifiex/init.c |  1 -
 drivers/net/wireless/marvell/mwifiex/main.h | 11 -----------
 3 files changed, 13 deletions(-)

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
index cba934055b2a..1cfcd4f13fbd 100644
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
-- 
2.41.0

