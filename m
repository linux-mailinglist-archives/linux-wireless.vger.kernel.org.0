Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11C2177BB6C
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Aug 2023 16:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbjHNOVl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Aug 2023 10:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231128AbjHNOVO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Aug 2023 10:21:14 -0400
Received: from forward102b.mail.yandex.net (forward102b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BA6EAB
        for <linux-wireless@vger.kernel.org>; Mon, 14 Aug 2023 07:21:09 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-29.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-29.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:5faf:0:640:dd1b:0])
        by forward102b.mail.yandex.net (Yandex) with ESMTP id 9B66E6008B;
        Mon, 14 Aug 2023 17:21:06 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-29.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 5LfxSnYWveA0-y9EQhnBI;
        Mon, 14 Aug 2023 17:21:06 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1692022866;
        bh=j/NtqR/j+W7CsJfocnLLvX9grW2ugCf4BY5L+cP/DUs=;
        h=Message-ID:Date:Cc:Subject:To:From;
        b=ozlZ/gAc4SHSV6+6qr5OYB1XqhPiw0HM1nY0VbFx0RH2FUE7NdnTnZrldTcwvqrQW
         Q52A/oGZ7v5tW1aOr23Pa2VTuQwb5985vXyU27rbZKU8wPZuFyOZWOUdJn96/zSmNM
         BzyCLUkLEA4kiE1rAGXS/F/QUeQt5fWaObMOEGHk=
Authentication-Results: mail-nwsmtp-smtp-production-main-29.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Brian Norris <briannorris@chromium.org>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 1/2] wifi: mwifiex: cleanup adapter data
Date:   Mon, 14 Aug 2023 17:19:04 +0300
Message-ID: <20230814142101.60308-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Remove unused and set but unused 'dfs_workqueue', 'dfs_work', and
'scan_channels' members of 'struct mwifiex_adapter', adjust users.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/net/wireless/marvell/mwifiex/init.c | 1 -
 drivers/net/wireless/marvell/mwifiex/main.h | 3 ---
 drivers/net/wireless/marvell/mwifiex/scan.c | 4 ----
 3 files changed, 8 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/init.c b/drivers/net/wireless/marvell/mwifiex/init.c
index 7dddb4b5dea1..e4d2e87dc99c 100644
--- a/drivers/net/wireless/marvell/mwifiex/init.c
+++ b/drivers/net/wireless/marvell/mwifiex/init.c
@@ -289,7 +289,6 @@ static void mwifiex_init_adapter(struct mwifiex_adapter *adapter)
 	adapter->fw_bands = 0;
 	adapter->config_bands = 0;
 	adapter->adhoc_start_band = 0;
-	adapter->scan_channels = NULL;
 	adapter->fw_release_number = 0;
 	adapter->fw_cap_info = 0;
 	memset(&adapter->upld_buf, 0, sizeof(adapter->upld_buf));
diff --git a/drivers/net/wireless/marvell/mwifiex/main.h b/drivers/net/wireless/marvell/mwifiex/main.h
index b95886e1413e..5a356e7644ec 100644
--- a/drivers/net/wireless/marvell/mwifiex/main.h
+++ b/drivers/net/wireless/marvell/mwifiex/main.h
@@ -888,8 +888,6 @@ struct mwifiex_adapter {
 	struct work_struct main_work;
 	struct workqueue_struct *rx_workqueue;
 	struct work_struct rx_work;
-	struct workqueue_struct *dfs_workqueue;
-	struct work_struct dfs_work;
 	bool rx_work_enabled;
 	bool rx_processing;
 	bool delay_main_work;
@@ -953,7 +951,6 @@ struct mwifiex_adapter {
 	u8 fw_bands;
 	u8 adhoc_start_band;
 	u8 config_bands;
-	struct mwifiex_chan_scan_param_set *scan_channels;
 	u8 tx_lock_flag;
 	struct mwifiex_sleep_params sleep_params;
 	struct mwifiex_sleep_period sleep_period;
diff --git a/drivers/net/wireless/marvell/mwifiex/scan.c b/drivers/net/wireless/marvell/mwifiex/scan.c
index 644b1e134b01..7f5939b2409e 100644
--- a/drivers/net/wireless/marvell/mwifiex/scan.c
+++ b/drivers/net/wireless/marvell/mwifiex/scan.c
@@ -612,7 +612,6 @@ mwifiex_scan_channel_list(struct mwifiex_private *priv,
 	struct mwifiex_adapter *adapter = priv->adapter;
 	int ret = 0;
 	struct mwifiex_chan_scan_param_set *tmp_chan_list;
-	struct mwifiex_chan_scan_param_set *start_chan;
 	u32 tlv_idx, rates_size, cmd_no;
 	u32 total_scan_time;
 	u32 done_early;
@@ -643,7 +642,6 @@ mwifiex_scan_channel_list(struct mwifiex_private *priv,
 		total_scan_time = 0;
 		radio_type = 0;
 		chan_tlv_out->header.len = 0;
-		start_chan = tmp_chan_list;
 		done_early = false;
 
 		/*
@@ -750,8 +748,6 @@ mwifiex_scan_channel_list(struct mwifiex_private *priv,
 		rates_size = mwifiex_append_rate_tlv(priv, scan_cfg_out,
 						     radio_type);
 
-		priv->adapter->scan_channels = start_chan;
-
 		/* Send the scan command to the firmware with the specified
 		   cfg */
 		if (priv->adapter->ext_scan)
-- 
2.41.0

