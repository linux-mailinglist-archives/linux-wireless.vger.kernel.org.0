Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C44127CAAAC
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Oct 2023 16:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233374AbjJPOAV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 16 Oct 2023 10:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232300AbjJPOAU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 16 Oct 2023 10:00:20 -0400
Received: from forward103b.mail.yandex.net (forward103b.mail.yandex.net [178.154.239.150])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6270B83
        for <linux-wireless@vger.kernel.org>; Mon, 16 Oct 2023 07:00:18 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-29.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-29.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:478a:0:640:c46b:0])
        by forward103b.mail.yandex.net (Yandex) with ESMTP id E88BF60AFC;
        Mon, 16 Oct 2023 17:00:08 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-29.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 70kRYkgDdGk0-s54eFNUL;
        Mon, 16 Oct 2023 17:00:08 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
        t=1697464808; bh=UJhUZRhptuSofMIRYK+nxtrvoFkg6cfc2JvzPsHcugc=;
        h=Message-ID:Date:Cc:Subject:To:From;
        b=XchbrFF4r+UeMZMmlAbNtophoG0EnH1YCdjeBIGUYefyp3P7uB2Ch8pnhBn0lAiB9
         dI/tJcX9LZkXmScii+EI0lz8XfuFnEshViL4AKbdD7rl4T778L2tNuvTtdJY0Xx4tu
         aRY07B594Pgq7UZ+Hf5I6gfkZy21dLhykvtopb9k=
Authentication-Results: mail-nwsmtp-smtp-production-main-29.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 1/3] wifi: rtlwifi: drop pre_fill_tx_bd_desc() from HAL interface
Date:   Mon, 16 Oct 2023 16:59:08 +0300
Message-ID: <20231016135925.129223-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Since 'pre_fill_tx_bd_desc()' is actually used for rtl8192ee only,
there is no need to maintain function pointer in 'struct rtl_hal_ops',
and 'rtl92ee_pre_fill_tx_bd_desc()' may be converted to static.
Compile tested only.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/net/wireless/realtek/rtlwifi/rtl8192ee/sw.c  | 1 -
 drivers/net/wireless/realtek/rtlwifi/rtl8192ee/trx.c | 8 +++++---
 drivers/net/wireless/realtek/rtlwifi/rtl8192ee/trx.h | 3 ---
 drivers/net/wireless/realtek/rtlwifi/wifi.h          | 3 ---
 4 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/sw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/sw.c
index 616a47d8d97a..011ce82efeff 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/sw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/sw.c
@@ -199,7 +199,6 @@ static struct rtl_hal_ops rtl8192ee_hal_ops = {
 	.get_hw_reg = rtl92ee_get_hw_reg,
 	.set_hw_reg = rtl92ee_set_hw_reg,
 	.update_rate_tbl = rtl92ee_update_hal_rate_tbl,
-	.pre_fill_tx_bd_desc = rtl92ee_pre_fill_tx_bd_desc,
 	.rx_desc_buff_remained_cnt = rtl92ee_rx_desc_buff_remained_cnt,
 	.rx_check_dma_ok = rtl92ee_rx_check_dma_ok,
 	.fill_tx_desc = rtl92ee_tx_fill_desc,
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/trx.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/trx.c
index 67388e0b3fa0..16589e18494b 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/trx.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/trx.c
@@ -550,9 +550,11 @@ u16 rtl92ee_get_available_desc(struct ieee80211_hw *hw, u8 q_idx)
 	return point_diff;
 }
 
-void rtl92ee_pre_fill_tx_bd_desc(struct ieee80211_hw *hw,
-				 u8 *tx_bd_desc8, u8 *desc8, u8 queue_index,
-				 struct sk_buff *skb, dma_addr_t addr)
+static void rtl92ee_pre_fill_tx_bd_desc(struct ieee80211_hw *hw,
+					u8 *tx_bd_desc8, u8 *desc8,
+					u8 queue_index,
+					struct sk_buff *skb,
+					dma_addr_t addr)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	struct rtl_pci *rtlpci = rtl_pcidev(rtl_pcipriv(hw));
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/trx.h b/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/trx.h
index 3852a50a688b..4c6cf4f16f95 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/trx.h
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/trx.h
@@ -720,9 +720,6 @@ void rtl92ee_rx_check_dma_ok(struct ieee80211_hw *hw, u8 *header_desc,
 u16	rtl92ee_rx_desc_buff_remained_cnt(struct ieee80211_hw *hw,
 					  u8 queue_index);
 u16 rtl92ee_get_available_desc(struct ieee80211_hw *hw, u8 queue_index);
-void rtl92ee_pre_fill_tx_bd_desc(struct ieee80211_hw *hw,
-				 u8 *tx_bd_desc, u8 *desc, u8 queue_index,
-				 struct sk_buff *skb, dma_addr_t addr);
 
 void rtl92ee_tx_fill_desc(struct ieee80211_hw *hw,
 			  struct ieee80211_hdr *hdr, u8 *pdesc_tx,
diff --git a/drivers/net/wireless/realtek/rtlwifi/wifi.h b/drivers/net/wireless/realtek/rtlwifi/wifi.h
index b60169196eab..cdaf0529244d 100644
--- a/drivers/net/wireless/realtek/rtlwifi/wifi.h
+++ b/drivers/net/wireless/realtek/rtlwifi/wifi.h
@@ -2231,9 +2231,6 @@ struct rtl_hal_ops {
 	void (*update_rate_tbl)(struct ieee80211_hw *hw,
 				struct ieee80211_sta *sta, u8 rssi_leve,
 				bool update_bw);
-	void (*pre_fill_tx_bd_desc)(struct ieee80211_hw *hw, u8 *tx_bd_desc,
-				    u8 *desc, u8 queue_index,
-				    struct sk_buff *skb, dma_addr_t addr);
 	void (*update_rate_mask)(struct ieee80211_hw *hw, u8 rssi_level);
 	u16 (*rx_desc_buff_remained_cnt)(struct ieee80211_hw *hw,
 					 u8 queue_index);
-- 
2.41.0

