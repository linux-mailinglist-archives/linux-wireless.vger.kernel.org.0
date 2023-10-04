Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29ECB7B7C0B
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Oct 2023 11:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241796AbjJDJZ6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Oct 2023 05:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241786AbjJDJZ5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Oct 2023 05:25:57 -0400
Received: from forward102b.mail.yandex.net (forward102b.mail.yandex.net [178.154.239.149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A889B4
        for <linux-wireless@vger.kernel.org>; Wed,  4 Oct 2023 02:25:50 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-18.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-18.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:a712:0:640:d986:0])
        by forward102b.mail.yandex.net (Yandex) with ESMTP id 4F4EA60048;
        Wed,  4 Oct 2023 12:25:17 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-18.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id GPToqNUDbSw0-vFloPHod;
        Wed, 04 Oct 2023 12:25:16 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
        t=1696411516; bh=y8vnpVFH0nfmZzRBaLfb3Y5VHCCT8BS9rmi7kT8eIY4=;
        h=Message-ID:Date:Cc:Subject:To:From;
        b=Dj78jkPFKnC4le+w/dY+5Jbf3OhkM8P5s2wDAz/XaNUG2BuTTZjX4nj+VUNTUTBR6
         QtrPqK6sJO42fopUat1MGQFKuPU1rHnEE4OP+mKICtVhskmE4SXDu3oMj2Hb1T7hCM
         ly34YTDq/4N65aqErdkRqcO0a477F8eByTbGtmb4=
Authentication-Results: mail-nwsmtp-smtp-production-main-18.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] wifi: rtlwifi: use unsigned long for bt_coexist_8723 timestamp
Date:   Wed,  4 Oct 2023 12:24:15 +0300
Message-ID: <20231004092418.73337-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Since 'bt_inq_page_start_time' of 'struct bt_coexist_8723' is
in jiffies, prefer 'unsigned long' over 'u32' to avoid possible
truncation in 'rtl8723e_dm_bt_inq_page_monitor()' and adjust
related code. Found with clang's -Wshorten-64-to-32, compile
tested only.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 .../wireless/realtek/rtlwifi/rtl8723ae/hal_btc.c | 16 +++++++---------
 drivers/net/wireless/realtek/rtlwifi/wifi.h      |  2 +-
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/hal_btc.c b/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/hal_btc.c
index 53af0d209b11..b34dffc6a30c 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/hal_btc.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/hal_btc.c
@@ -1122,7 +1122,7 @@ static void rtl8723e_dm_bt_2_ant_hid_sco_esco(struct ieee80211_hw *hw)
 	/* Always ignore WlanAct if bHid|bSCOBusy|bSCOeSCO */
 
 	rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
-		"[BTCoex], BT btInqPageStartTime = 0x%x, btTxRxCntLvl = %d\n",
+		"[BTCoex], BT btInqPageStartTime = 0x%lx, btTxRxCntLvl = %d\n",
 		hal_coex_8723.bt_inq_page_start_time, bt_tx_rx_cnt_lvl);
 	if ((hal_coex_8723.bt_inq_page_start_time) ||
 	    (BT_TXRX_CNT_LEVEL_3 == bt_tx_rx_cnt_lvl)) {
@@ -1335,7 +1335,7 @@ static void rtl8723e_dm_bt_2_ant_ftp_a2dp(struct ieee80211_hw *hw)
 		btdm8723.dec_bt_pwr = true;
 
 	rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
-		"[BTCoex], BT btInqPageStartTime = 0x%x, btTxRxCntLvl = %d\n",
+		"[BTCoex], BT btInqPageStartTime = 0x%lx, btTxRxCntLvl = %d\n",
 		hal_coex_8723.bt_inq_page_start_time, bt_tx_rx_cnt_lvl);
 
 	if ((hal_coex_8723.bt_inq_page_start_time) ||
@@ -1358,9 +1358,8 @@ static void rtl8723e_dm_bt_2_ant_ftp_a2dp(struct ieee80211_hw *hw)
 static void rtl8723e_dm_bt_inq_page_monitor(struct ieee80211_hw *hw)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
-	u32 cur_time;
+	unsigned long cur_time = jiffies;
 
-	cur_time = jiffies;
 	if (hal_coex_8723.c2h_bt_inquiry_page) {
 		/* bt inquiry or page is started. */
 		if (hal_coex_8723.bt_inq_page_start_time == 0) {
@@ -1368,18 +1367,17 @@ static void rtl8723e_dm_bt_inq_page_monitor(struct ieee80211_hw *hw)
 			BT_COEX_STATE_BT_INQ_PAGE;
 			hal_coex_8723.bt_inq_page_start_time = cur_time;
 			rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
-				"[BTCoex], BT Inquiry/page is started at time : 0x%x\n",
+				"[BTCoex], BT Inquiry/page is started at time : 0x%lx\n",
 				hal_coex_8723.bt_inq_page_start_time);
 		}
 	}
 	rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
-		"[BTCoex], BT Inquiry/page started time : 0x%x, cur_time : 0x%x\n",
+		"[BTCoex], BT Inquiry/page started time : 0x%lx, cur_time : 0x%lx\n",
 		hal_coex_8723.bt_inq_page_start_time, cur_time);
 
 	if (hal_coex_8723.bt_inq_page_start_time) {
-		if ((((long)cur_time -
-			(long)hal_coex_8723.bt_inq_page_start_time) / HZ)
-			>= 10) {
+		if (jiffies_to_msecs(cur_time -
+				     hal_coex_8723.bt_inq_page_start_time) >= 10000) {
 			rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
 				"[BTCoex], BT Inquiry/page >= 10sec!!!\n");
 			hal_coex_8723.bt_inq_page_start_time = 0;
diff --git a/drivers/net/wireless/realtek/rtlwifi/wifi.h b/drivers/net/wireless/realtek/rtlwifi/wifi.h
index 0f99e3446796..47b4685b6d24 100644
--- a/drivers/net/wireless/realtek/rtlwifi/wifi.h
+++ b/drivers/net/wireless/realtek/rtlwifi/wifi.h
@@ -1597,7 +1597,7 @@ struct bt_coexist_8723 {
 	u8 c2h_bt_info;
 	bool c2h_bt_info_req_sent;
 	bool c2h_bt_inquiry_page;
-	u32 bt_inq_page_start_time;
+	unsigned long bt_inq_page_start_time;
 	u8 bt_retry_cnt;
 	u8 c2h_bt_info_original;
 	u8 bt_inquiry_page_cnt;
-- 
2.41.0

