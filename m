Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17F5C7C586C
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Oct 2023 17:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235033AbjJKPrB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Oct 2023 11:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235013AbjJKPq7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Oct 2023 11:46:59 -0400
Received: from forward100a.mail.yandex.net (forward100a.mail.yandex.net [178.154.239.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B235793
        for <linux-wireless@vger.kernel.org>; Wed, 11 Oct 2023 08:46:55 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-74.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-74.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1d:47bd:0:640:2492:0])
        by forward100a.mail.yandex.net (Yandex) with ESMTP id 4DDFE46C5D;
        Wed, 11 Oct 2023 18:46:54 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-74.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id pkg2t9WDf8c0-lgQapH8z;
        Wed, 11 Oct 2023 18:46:53 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
        t=1697039213; bh=J5FCv2BO6E9gqLWpxqeUJlw9vpvu2Y7aYUZwfylWUgo=;
        h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=ERZomUeV7W/yGW25UvPhhHFuZ4eZtvjCuujE0jtzwDp9IBPTcnYppVPOYR4+zZ9tY
         NCkKBaZ0e/YK2qED90gnXIpCKC9IIf/eqKeG4eHiUeYAyYJXJqw8KdcJvSUqB9S2AB
         S5pzEZHy52Z2/JXQCsADrviqi78xlBOH0pgiKurM=
Authentication-Results: mail-nwsmtp-smtp-production-main-74.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 2/2] wifi: rtlwifi: simplify TX command fill callbacks
Date:   Wed, 11 Oct 2023 18:44:37 +0300
Message-ID: <20231011154442.52457-2-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231011154442.52457-1-dmantipov@yandex.ru>
References: <20231011154442.52457-1-dmantipov@yandex.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Since 'rtlpriv->cfg->ops->fill_tx_cmddesc()' is always called
with 'firstseg' and 'lastseg' set to 1 (and the latter is
never actually used), all of the relevant chip-specific
routines may be simplified. Compile tested only.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/net/wireless/realtek/rtlwifi/core.c          | 2 +-
 drivers/net/wireless/realtek/rtlwifi/rtl8188ee/trx.c | 8 +++-----
 drivers/net/wireless/realtek/rtlwifi/rtl8188ee/trx.h | 1 -
 drivers/net/wireless/realtek/rtlwifi/rtl8192ce/trx.c | 9 +++------
 drivers/net/wireless/realtek/rtlwifi/rtl8192ce/trx.h | 1 -
 drivers/net/wireless/realtek/rtlwifi/rtl8192cu/hw.c  | 2 +-
 drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.c | 8 +++-----
 drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.h | 5 ++---
 drivers/net/wireless/realtek/rtlwifi/rtl8192de/fw.c  | 2 +-
 drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c | 8 +++-----
 drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h | 1 -
 drivers/net/wireless/realtek/rtlwifi/rtl8192ee/trx.c | 8 +++-----
 drivers/net/wireless/realtek/rtlwifi/rtl8192ee/trx.h | 1 -
 drivers/net/wireless/realtek/rtlwifi/rtl8192se/fw.c  | 2 +-
 drivers/net/wireless/realtek/rtlwifi/rtl8192se/trx.c | 2 +-
 drivers/net/wireless/realtek/rtlwifi/rtl8192se/trx.h | 4 ++--
 drivers/net/wireless/realtek/rtlwifi/rtl8723ae/trx.c | 8 +++-----
 drivers/net/wireless/realtek/rtlwifi/rtl8723ae/trx.h | 1 -
 drivers/net/wireless/realtek/rtlwifi/rtl8723be/trx.c | 1 -
 drivers/net/wireless/realtek/rtlwifi/rtl8723be/trx.h | 1 -
 drivers/net/wireless/realtek/rtlwifi/rtl8821ae/trx.c | 5 ++---
 drivers/net/wireless/realtek/rtlwifi/rtl8821ae/trx.h | 1 -
 drivers/net/wireless/realtek/rtlwifi/wifi.h          | 1 -
 23 files changed, 29 insertions(+), 53 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/core.c b/drivers/net/wireless/realtek/rtlwifi/core.c
index 3835b639d453..cc9b2a459386 100644
--- a/drivers/net/wireless/realtek/rtlwifi/core.c
+++ b/drivers/net/wireless/realtek/rtlwifi/core.c
@@ -1897,7 +1897,7 @@ bool rtl_cmd_send_packet(struct ieee80211_hw *hw, struct sk_buff *skb)
 	/*this is wrong, fill_tx_cmddesc needs update*/
 	pdesc = &ring->desc[0];
 
-	rtlpriv->cfg->ops->fill_tx_cmddesc(hw, (u8 *)pdesc, 1, 1, skb);
+	rtlpriv->cfg->ops->fill_tx_cmddesc(hw, (u8 *)pdesc, skb);
 
 	__skb_queue_tail(&ring->queue, skb);
 
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/trx.c b/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/trx.c
index 65ebe52883d3..d094163a9a71 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/trx.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/trx.c
@@ -665,9 +665,8 @@ void rtl88ee_tx_fill_desc(struct ieee80211_hw *hw,
 	rtl_dbg(rtlpriv, COMP_SEND, DBG_TRACE, "\n");
 }
 
-void rtl88ee_tx_fill_cmddesc(struct ieee80211_hw *hw,
-			     u8 *pdesc8, bool firstseg,
-			     bool lastseg, struct sk_buff *skb)
+void rtl88ee_tx_fill_cmddesc(struct ieee80211_hw *hw, u8 *pdesc8,
+			     struct sk_buff *skb)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	struct rtl_pci *rtlpci = rtl_pcidev(rtl_pcipriv(hw));
@@ -687,8 +686,7 @@ void rtl88ee_tx_fill_cmddesc(struct ieee80211_hw *hw,
 	}
 	clear_pci_tx_desc_content(pdesc, TX_DESC_SIZE);
 
-	if (firstseg)
-		set_tx_desc_offset(pdesc, USB_HWDESC_HEADER_LEN);
+	set_tx_desc_offset(pdesc, USB_HWDESC_HEADER_LEN);
 
 	set_tx_desc_tx_rate(pdesc, DESC92C_RATE1M);
 
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/trx.h b/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/trx.h
index e17f70b4d199..aae654b0e3ba 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/trx.h
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/trx.h
@@ -797,6 +797,5 @@ bool rtl88ee_is_tx_desc_closed(struct ieee80211_hw *hw,
 			       u8 hw_queue, u16 index);
 void rtl88ee_tx_polling(struct ieee80211_hw *hw, u8 hw_queue);
 void rtl88ee_tx_fill_cmddesc(struct ieee80211_hw *hw, u8 *pdesc,
-			     bool firstseg, bool lastseg,
 			     struct sk_buff *skb);
 #endif
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192ce/trx.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192ce/trx.c
index 5376bb34251f..50e139186a93 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192ce/trx.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192ce/trx.c
@@ -518,9 +518,8 @@ void rtl92ce_tx_fill_desc(struct ieee80211_hw *hw,
 	rtl_dbg(rtlpriv, COMP_SEND, DBG_TRACE, "\n");
 }
 
-void rtl92ce_tx_fill_cmddesc(struct ieee80211_hw *hw,
-			     u8 *pdesc8, bool firstseg,
-			     bool lastseg, struct sk_buff *skb)
+void rtl92ce_tx_fill_cmddesc(struct ieee80211_hw *hw, u8 *pdesc8,
+			     struct sk_buff *skb)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	struct rtl_pci *rtlpci = rtl_pcidev(rtl_pcipriv(hw));
@@ -540,9 +539,7 @@ void rtl92ce_tx_fill_cmddesc(struct ieee80211_hw *hw,
 	}
 	clear_pci_tx_desc_content(pdesc, TX_DESC_SIZE);
 
-	if (firstseg)
-		set_tx_desc_offset(pdesc, USB_HWDESC_HEADER_LEN);
-
+	set_tx_desc_offset(pdesc, USB_HWDESC_HEADER_LEN);
 	set_tx_desc_tx_rate(pdesc, DESC_RATE1M);
 
 	set_tx_desc_seq(pdesc, 0);
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192ce/trx.h b/drivers/net/wireless/realtek/rtlwifi/rtl8192ce/trx.h
index b45b05a6a523..f3ffe3d9883c 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192ce/trx.h
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192ce/trx.h
@@ -527,6 +527,5 @@ bool rtl92ce_is_tx_desc_closed(struct ieee80211_hw *hw,
 			       u8 hw_queue, u16 index);
 void rtl92ce_tx_polling(struct ieee80211_hw *hw, u8 hw_queue);
 void rtl92ce_tx_fill_cmddesc(struct ieee80211_hw *hw, u8 *pdesc,
-			     bool b_firstseg, bool b_lastseg,
 			     struct sk_buff *skb);
 #endif
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/hw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/hw.c
index a040c07791d1..5ec0eb8773a5 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/hw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/hw.c
@@ -1539,7 +1539,7 @@ static bool usb_cmd_send_packet(struct ieee80211_hw *hw, struct sk_buff *skb)
    * if its "here".
    *
    * This is maybe necessary:
-   * rtlpriv->cfg->ops->fill_tx_cmddesc(hw, buffer, 1, 1, skb);
+   * rtlpriv->cfg->ops->fill_tx_cmddesc(hw, buffer, skb);
    */
 	dev_kfree_skb(skb);
 
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.c
index b70767e72f3d..9969e9d1fc4b 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.c
@@ -626,9 +626,8 @@ void rtl92cu_fill_fake_txdesc(struct ieee80211_hw *hw, u8 *pdesc8,
 	_rtl_tx_desc_checksum(pdesc);
 }
 
-void rtl92cu_tx_fill_cmddesc(struct ieee80211_hw *hw,
-			     u8 *pdesc8, bool firstseg,
-			     bool lastseg, struct sk_buff *skb)
+void rtl92cu_tx_fill_cmddesc(struct ieee80211_hw *hw, u8 *pdesc8,
+			     struct sk_buff *skb)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	u8 fw_queue = QSLT_BEACON;
@@ -637,8 +636,7 @@ void rtl92cu_tx_fill_cmddesc(struct ieee80211_hw *hw,
 	__le32 *pdesc = (__le32 *)pdesc8;
 
 	memset((void *)pdesc, 0, RTL_TX_HEADER_SIZE);
-	if (firstseg)
-		set_tx_desc_offset(pdesc, RTL_TX_HEADER_SIZE);
+	set_tx_desc_offset(pdesc, RTL_TX_HEADER_SIZE);
 	set_tx_desc_tx_rate(pdesc, DESC_RATE1M);
 	set_tx_desc_seq(pdesc, 0);
 	set_tx_desc_linip(pdesc, 0);
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.h b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.h
index 171fe39dfb0c..cc4ef2bfd2e7 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.h
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.h
@@ -396,8 +396,7 @@ void rtl92cu_tx_fill_desc(struct ieee80211_hw *hw,
 			  struct rtl_tcb_desc *tcb_desc);
 void rtl92cu_fill_fake_txdesc(struct ieee80211_hw *hw, u8 *pdesc,
 			       u32 buffer_len, bool ispspoll);
-void rtl92cu_tx_fill_cmddesc(struct ieee80211_hw *hw,
-			     u8 *pdesc, bool b_firstseg,
-			     bool b_lastseg, struct sk_buff *skb);
+void rtl92cu_tx_fill_cmddesc(struct ieee80211_hw *hw, u8 *pdesc,
+			     struct sk_buff *skb);
 
 #endif
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/fw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/fw.c
index 9ddb8478784b..e1fb29962801 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/fw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/fw.c
@@ -469,7 +469,7 @@ static bool _rtl92d_cmd_send_packet(struct ieee80211_hw *hw,
 	pdesc = &ring->desc[idx];
 	/* discard output from call below */
 	rtlpriv->cfg->ops->get_desc(hw, (u8 *)pdesc, true, HW_DESC_OWN);
-	rtlpriv->cfg->ops->fill_tx_cmddesc(hw, (u8 *) pdesc, 1, 1, skb);
+	rtlpriv->cfg->ops->fill_tx_cmddesc(hw, (u8 *)pdesc, skb);
 	__skb_queue_tail(&ring->queue, skb);
 	spin_unlock_irqrestore(&rtlpriv->locks.irq_th_lock, flags);
 	rtlpriv->cfg->ops->tx_polling(hw, BEACON_QUEUE);
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c
index c09c0c312665..02ac69c08ed3 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c
@@ -655,9 +655,8 @@ void rtl92de_tx_fill_desc(struct ieee80211_hw *hw,
 	rtl_dbg(rtlpriv, COMP_SEND, DBG_TRACE, "\n");
 }
 
-void rtl92de_tx_fill_cmddesc(struct ieee80211_hw *hw,
-			     u8 *pdesc8, bool firstseg,
-			     bool lastseg, struct sk_buff *skb)
+void rtl92de_tx_fill_cmddesc(struct ieee80211_hw *hw, u8 *pdesc8,
+			     struct sk_buff *skb)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	struct rtl_pci *rtlpci = rtl_pcidev(rtl_pcipriv(hw));
@@ -678,8 +677,7 @@ void rtl92de_tx_fill_cmddesc(struct ieee80211_hw *hw,
 		return;
 	}
 	clear_pci_tx_desc_content(pdesc, TX_DESC_SIZE);
-	if (firstseg)
-		set_tx_desc_offset(pdesc, USB_HWDESC_HEADER_LEN);
+	set_tx_desc_offset(pdesc, USB_HWDESC_HEADER_LEN);
 	/* 5G have no CCK rate
 	 * Caution: The macros below are multi-line expansions.
 	 * The braces are needed no matter what checkpatch says
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h
index d01578875cd5..2992668c156c 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h
@@ -564,7 +564,6 @@ bool rtl92de_is_tx_desc_closed(struct ieee80211_hw *hw,
 			       u8 hw_queue, u16 index);
 void rtl92de_tx_polling(struct ieee80211_hw *hw, u8 hw_queue);
 void rtl92de_tx_fill_cmddesc(struct ieee80211_hw *hw, u8 *pdesc,
-			     bool b_firstseg, bool b_lastseg,
 			     struct sk_buff *skb);
 
 #endif
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/trx.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/trx.c
index a182cdeb58e2..67388e0b3fa0 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/trx.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/trx.c
@@ -827,9 +827,8 @@ void rtl92ee_tx_fill_desc(struct ieee80211_hw *hw,
 	rtl_dbg(rtlpriv, COMP_SEND, DBG_TRACE, "\n");
 }
 
-void rtl92ee_tx_fill_cmddesc(struct ieee80211_hw *hw,
-			     u8 *pdesc8, bool firstseg,
-			     bool lastseg, struct sk_buff *skb)
+void rtl92ee_tx_fill_cmddesc(struct ieee80211_hw *hw, u8 *pdesc8,
+			     struct sk_buff *skb)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	struct rtl_pci *rtlpci = rtl_pcidev(rtl_pcipriv(hw));
@@ -846,8 +845,7 @@ void rtl92ee_tx_fill_cmddesc(struct ieee80211_hw *hw,
 	}
 	clear_pci_tx_desc_content(pdesc, txdesc_len);
 
-	if (firstseg)
-		set_tx_desc_offset(pdesc, txdesc_len);
+	set_tx_desc_offset(pdesc, txdesc_len);
 
 	set_tx_desc_tx_rate(pdesc, DESC_RATE1M);
 
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/trx.h b/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/trx.h
index 967cef3a9cbf..3852a50a688b 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/trx.h
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/trx.h
@@ -743,6 +743,5 @@ u64 rtl92ee_get_desc(struct ieee80211_hw *hw,
 bool rtl92ee_is_tx_desc_closed(struct ieee80211_hw *hw, u8 hw_queue, u16 index);
 void rtl92ee_tx_polling(struct ieee80211_hw *hw, u8 hw_queue);
 void rtl92ee_tx_fill_cmddesc(struct ieee80211_hw *hw, u8 *pdesc,
-			     bool firstseg, bool lastseg,
 			     struct sk_buff *skb);
 #endif
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192se/fw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192se/fw.c
index f570495af044..579b1789d6d1 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192se/fw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192se/fw.c
@@ -122,7 +122,7 @@ static bool _rtl92s_cmd_send_packet(struct ieee80211_hw *hw,
 
 	idx = (ring->idx + skb_queue_len(&ring->queue)) % ring->entries;
 	pdesc = &ring->desc[idx];
-	rtlpriv->cfg->ops->fill_tx_cmddesc(hw, (u8 *)pdesc, 1, 1, skb);
+	rtlpriv->cfg->ops->fill_tx_cmddesc(hw, (u8 *)pdesc, skb);
 	__skb_queue_tail(&ring->queue, skb);
 
 	spin_unlock_irqrestore(&rtlpriv->locks.irq_th_lock, flags);
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192se/trx.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192se/trx.c
index a5853a170b58..f104cdb649f8 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192se/trx.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192se/trx.c
@@ -492,7 +492,7 @@ void rtl92se_tx_fill_desc(struct ieee80211_hw *hw,
 }
 
 void rtl92se_tx_fill_cmddesc(struct ieee80211_hw *hw, u8 *pdesc8,
-			     bool firstseg, bool lastseg, struct sk_buff *skb)
+			     struct sk_buff *skb)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	struct rtl_pci *rtlpci = rtl_pcidev(rtl_pcipriv(hw));
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192se/trx.h b/drivers/net/wireless/realtek/rtlwifi/rtl8192se/trx.h
index 90aa12fc6a7f..40291a6a15d0 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192se/trx.h
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192se/trx.h
@@ -10,8 +10,8 @@ void rtl92se_tx_fill_desc(struct ieee80211_hw *hw,
 			  struct ieee80211_sta *sta,
 			  struct sk_buff *skb, u8 hw_queue,
 			  struct rtl_tcb_desc *ptcb_desc);
-void rtl92se_tx_fill_cmddesc(struct ieee80211_hw *hw, u8 *pdesc, bool firstseg,
-			     bool lastseg, struct sk_buff *skb);
+void rtl92se_tx_fill_cmddesc(struct ieee80211_hw *hw, u8 *pdesc,
+			     struct sk_buff *skb);
 bool rtl92se_rx_query_desc(struct ieee80211_hw *hw, struct rtl_stats *stats,
 			   struct ieee80211_rx_status *rx_status, u8 *pdesc,
 			   struct sk_buff *skb);
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/trx.c b/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/trx.c
index 7f294e698994..d9823ddab7be 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/trx.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/trx.c
@@ -519,9 +519,8 @@ void rtl8723e_tx_fill_desc(struct ieee80211_hw *hw,
 	rtl_dbg(rtlpriv, COMP_SEND, DBG_TRACE, "\n");
 }
 
-void rtl8723e_tx_fill_cmddesc(struct ieee80211_hw *hw,
-			      u8 *pdesc8, bool firstseg,
-			      bool lastseg, struct sk_buff *skb)
+void rtl8723e_tx_fill_cmddesc(struct ieee80211_hw *hw, u8 *pdesc8,
+			      struct sk_buff *skb)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	struct rtl_pci *rtlpci = rtl_pcidev(rtl_pcipriv(hw));
@@ -541,8 +540,7 @@ void rtl8723e_tx_fill_cmddesc(struct ieee80211_hw *hw,
 	}
 	clear_pci_tx_desc_content(pdesc, TX_DESC_SIZE);
 
-	if (firstseg)
-		set_tx_desc_offset(pdesc, USB_HWDESC_HEADER_LEN);
+	set_tx_desc_offset(pdesc, USB_HWDESC_HEADER_LEN);
 
 	set_tx_desc_tx_rate(pdesc, DESC92C_RATE1M);
 
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/trx.h b/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/trx.h
index 2d25f62a4d52..f352fddfff32 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/trx.h
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/trx.h
@@ -530,6 +530,5 @@ bool rtl8723e_is_tx_desc_closed(struct ieee80211_hw *hw,
 				u8 hw_queue, u16 index);
 void rtl8723e_tx_polling(struct ieee80211_hw *hw, u8 hw_queue);
 void rtl8723e_tx_fill_cmddesc(struct ieee80211_hw *hw, u8 *pdesc,
-			      bool firstseg, bool lastseg,
 			      struct sk_buff *skb);
 #endif
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8723be/trx.c b/drivers/net/wireless/realtek/rtlwifi/rtl8723be/trx.c
index 24ef7cc52e99..8b6352f7f93b 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8723be/trx.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8723be/trx.c
@@ -585,7 +585,6 @@ void rtl8723be_tx_fill_desc(struct ieee80211_hw *hw,
 }
 
 void rtl8723be_tx_fill_cmddesc(struct ieee80211_hw *hw, u8 *pdesc8,
-			       bool firstseg, bool lastseg,
 			       struct sk_buff *skb)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8723be/trx.h b/drivers/net/wireless/realtek/rtlwifi/rtl8723be/trx.h
index 174aca20c7e1..da027f915cf4 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8723be/trx.h
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8723be/trx.h
@@ -642,6 +642,5 @@ bool rtl8723be_is_tx_desc_closed(struct ieee80211_hw *hw,
 				 u8 hw_queue, u16 index);
 void rtl8723be_tx_polling(struct ieee80211_hw *hw, u8 hw_queue);
 void rtl8723be_tx_fill_cmddesc(struct ieee80211_hw *hw, u8 *pdesc,
-			       bool firstseg, bool lastseg,
 			       struct sk_buff *skb);
 #endif
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/trx.c b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/trx.c
index d7cb3319d885..bd71592fe26a 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/trx.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/trx.c
@@ -828,9 +828,8 @@ void rtl8821ae_tx_fill_desc(struct ieee80211_hw *hw,
 	rtl_dbg(rtlpriv, COMP_SEND, DBG_TRACE, "\n");
 }
 
-void rtl8821ae_tx_fill_cmddesc(struct ieee80211_hw *hw,
-			       u8 *pdesc8, bool firstseg,
-			       bool lastseg, struct sk_buff *skb)
+void rtl8821ae_tx_fill_cmddesc(struct ieee80211_hw *hw, u8 *pdesc8,
+			       struct sk_buff *skb)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	struct rtl_pci *rtlpci = rtl_pcidev(rtl_pcipriv(hw));
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/trx.h b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/trx.h
index a9ed6fd41089..1155365348f3 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/trx.h
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/trx.h
@@ -648,6 +648,5 @@ bool rtl8821ae_is_tx_desc_closed(struct ieee80211_hw *hw,
 				 u8 hw_queue, u16 index);
 void rtl8821ae_tx_polling(struct ieee80211_hw *hw, u8 hw_queue);
 void rtl8821ae_tx_fill_cmddesc(struct ieee80211_hw *hw, u8 *pdesc,
-			       bool firstseg, bool lastseg,
 			       struct sk_buff *skb);
 #endif
diff --git a/drivers/net/wireless/realtek/rtlwifi/wifi.h b/drivers/net/wireless/realtek/rtlwifi/wifi.h
index cabf6c82a639..bb4c69944e6a 100644
--- a/drivers/net/wireless/realtek/rtlwifi/wifi.h
+++ b/drivers/net/wireless/realtek/rtlwifi/wifi.h
@@ -2246,7 +2246,6 @@ struct rtl_hal_ops {
 	void (*fill_fake_txdesc)(struct ieee80211_hw *hw, u8 *pdesc,
 				 u32 buffer_len, bool bsspspoll);
 	void (*fill_tx_cmddesc)(struct ieee80211_hw *hw, u8 *pdesc,
-				bool firstseg, bool lastseg,
 				struct sk_buff *skb);
 	void (*fill_tx_special_desc)(struct ieee80211_hw *hw,
 				     u8 *pdesc, u8 *pbd_desc,
-- 
2.41.0

