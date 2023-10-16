Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4967CAAAA
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Oct 2023 16:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232549AbjJPOAT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 16 Oct 2023 10:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232313AbjJPOAS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 16 Oct 2023 10:00:18 -0400
Received: from forward101b.mail.yandex.net (forward101b.mail.yandex.net [178.154.239.148])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 532E2FA
        for <linux-wireless@vger.kernel.org>; Mon, 16 Oct 2023 07:00:13 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-29.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-29.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:478a:0:640:c46b:0])
        by forward101b.mail.yandex.net (Yandex) with ESMTP id 8B98460AF4;
        Mon, 16 Oct 2023 17:00:10 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-29.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 70kRYkgDdGk0-y3wXrQZg;
        Mon, 16 Oct 2023 17:00:10 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
        t=1697464810; bh=gsu0l6eQ1pHIECFrOjyDfSqnOcOMNGdV4TzAaTdrVaM=;
        h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=L+ifKkXWdFTgY4jFuN6ZjBzaT8NI7V54dGCoPZhXiev62PwVTXTgAm0NHcNfmhXY/
         8U77ugH+T4UlPOumwDC//81Vfo5DEIDZhoWdC+ykqURu1btyeDfdK4H9+ofR1E7xNc
         E9bAscqBMZNjPF/Q2sSdZS/GlKJEwNmTau25kvcY=
Authentication-Results: mail-nwsmtp-smtp-production-main-29.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 2/3] wifi: rtlwifi: drop fill_fake_txdesc() from HAL interface
Date:   Mon, 16 Oct 2023 16:59:09 +0300
Message-ID: <20231016135925.129223-2-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231016135925.129223-1-dmantipov@yandex.ru>
References: <20231016135925.129223-1-dmantipov@yandex.ru>
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

Since 'fill_fake_txdesc()' is actually implemented for rtl8192cu
only but never used, there is no need to maintain function pointer
in 'struct rtl_hal_ops' and 'rtl92cu_fill_fake_txdesc()' may be
dropped. Compile tested only.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 .../wireless/realtek/rtlwifi/rtl8192cu/sw.c   |  1 -
 .../wireless/realtek/rtlwifi/rtl8192cu/trx.c  | 26 -------------------
 .../wireless/realtek/rtlwifi/rtl8192cu/trx.h  |  2 --
 drivers/net/wireless/realtek/rtlwifi/wifi.h   |  2 --
 4 files changed, 31 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/sw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/sw.c
index e6403d4c937c..20b4aac69642 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/sw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/sw.c
@@ -102,7 +102,6 @@ static struct rtl_hal_ops rtl8192cu_hal_ops = {
 	.set_hw_reg = rtl92cu_set_hw_reg,
 	.update_rate_tbl = rtl92cu_update_hal_rate_tbl,
 	.fill_tx_desc = rtl92cu_tx_fill_desc,
-	.fill_fake_txdesc = rtl92cu_fill_fake_txdesc,
 	.fill_tx_cmddesc = rtl92cu_tx_fill_cmddesc,
 	.query_rx_desc = rtl92cu_rx_query_desc,
 	.set_channel_access = rtl92cu_update_channel_access_setting,
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.c
index 9969e9d1fc4b..2f44c8aa6066 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.c
@@ -600,32 +600,6 @@ void rtl92cu_tx_fill_desc(struct ieee80211_hw *hw,
 	rtl_dbg(rtlpriv, COMP_SEND, DBG_TRACE, "==>\n");
 }
 
-void rtl92cu_fill_fake_txdesc(struct ieee80211_hw *hw, u8 *pdesc8,
-			      u32 buffer_len, bool is_pspoll)
-{
-	__le32 *pdesc = (__le32 *)pdesc8;
-
-	/* Clear all status */
-	memset(pdesc, 0, RTL_TX_HEADER_SIZE);
-	set_tx_desc_first_seg(pdesc, 1); /* bFirstSeg; */
-	set_tx_desc_last_seg(pdesc, 1); /* bLastSeg; */
-	set_tx_desc_offset(pdesc, RTL_TX_HEADER_SIZE); /* Offset = 32 */
-	set_tx_desc_pkt_size(pdesc, buffer_len); /* Buffer size + command hdr */
-	set_tx_desc_queue_sel(pdesc, QSLT_MGNT); /* Fixed queue of Mgnt queue */
-	/* Set NAVUSEHDR to prevent Ps-poll AId filed to be changed to error
-	 * vlaue by Hw. */
-	if (is_pspoll) {
-		set_tx_desc_nav_use_hdr(pdesc, 1);
-	} else {
-		set_tx_desc_hwseq_en(pdesc, 1); /* Hw set sequence number */
-		set_tx_desc_pkt_id(pdesc, BIT(3)); /* set bit3 to 1. */
-	}
-	set_tx_desc_use_rate(pdesc, 1); /* use data rate which is set by Sw */
-	set_tx_desc_own(pdesc, 1);
-	set_tx_desc_tx_rate(pdesc, DESC_RATE1M);
-	_rtl_tx_desc_checksum(pdesc);
-}
-
 void rtl92cu_tx_fill_cmddesc(struct ieee80211_hw *hw, u8 *pdesc8,
 			     struct sk_buff *skb)
 {
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.h b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.h
index cc4ef2bfd2e7..5f81cab205cc 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.h
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.h
@@ -394,8 +394,6 @@ void rtl92cu_tx_fill_desc(struct ieee80211_hw *hw,
 			  struct sk_buff *skb,
 			  u8 queue_index,
 			  struct rtl_tcb_desc *tcb_desc);
-void rtl92cu_fill_fake_txdesc(struct ieee80211_hw *hw, u8 *pdesc,
-			       u32 buffer_len, bool ispspoll);
 void rtl92cu_tx_fill_cmddesc(struct ieee80211_hw *hw, u8 *pdesc,
 			     struct sk_buff *skb);
 
diff --git a/drivers/net/wireless/realtek/rtlwifi/wifi.h b/drivers/net/wireless/realtek/rtlwifi/wifi.h
index cdaf0529244d..434cb2b4ec8b 100644
--- a/drivers/net/wireless/realtek/rtlwifi/wifi.h
+++ b/drivers/net/wireless/realtek/rtlwifi/wifi.h
@@ -2243,8 +2243,6 @@ struct rtl_hal_ops {
 			     struct ieee80211_sta *sta,
 			     struct sk_buff *skb, u8 hw_queue,
 			     struct rtl_tcb_desc *ptcb_desc);
-	void (*fill_fake_txdesc)(struct ieee80211_hw *hw, u8 *pdesc,
-				 u32 buffer_len, bool bsspspoll);
 	void (*fill_tx_cmddesc)(struct ieee80211_hw *hw, u8 *pdesc,
 				struct sk_buff *skb);
 	void (*fill_tx_special_desc)(struct ieee80211_hw *hw,
-- 
2.41.0

