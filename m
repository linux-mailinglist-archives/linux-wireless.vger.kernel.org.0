Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB65A4A21
	for <lists+linux-wireless@lfdr.de>; Sun,  1 Sep 2019 17:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729171AbfIAPrQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 1 Sep 2019 11:47:16 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:43150 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729159AbfIAPrP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 1 Sep 2019 11:47:15 -0400
Received: by mail-oi1-f196.google.com with SMTP id y8so8807562oih.10
        for <linux-wireless@vger.kernel.org>; Sun, 01 Sep 2019 08:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NHmmgKODSWneMcnDKK8/QTwogiTmmswI0WqUwJ9TKB0=;
        b=Zy5dLCiGVLLiSZEcvI3kAFHgrcLXCr04e9aCjipLqX+mjd0VOXrEnOS+WD+lBx/hFY
         nhEYwY6J9ArS5cxicC5GRqCXf9ClEBgBADnjhxckmSNjCTsksPD4dXJln+VGHzCQX1QC
         xjZipx4C1tOXTjTyeO3GGerbIgnrTH0sSZPdDv123M1SNF2SypiMlgnKCVCuW1Z8MCSE
         cKIUo6vwDqCihdOFzfHtbeyrybLVY6McdW3EHei+xZdaspbq+oekmvScHBTqJmRfqIOJ
         ci2g/F99DtwUAX/P0CSKujZxm7V+zgUD9PwP5nh+x/opvOl5GS0joIpPfB8ca70HfyvH
         DAFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=NHmmgKODSWneMcnDKK8/QTwogiTmmswI0WqUwJ9TKB0=;
        b=ZE56X0IoJ5HL0RFTVbaZ0IOWS0KwsWo4UgsfbYLF/6zgFvaA2oNp1FOjiu6aUw7fug
         nwxoAFKyrmVTU8B1pfFtBaHfcendtzrq2lpH7M1eIsknlCedBH/fbdb+uBflGLAdnNFq
         xWZbS5bGMAvvqHkoFoHnR/3Ahz6P5q1NyY3KlTyffjpJSB7Ob93LJshz6D033viaN9ud
         eEhhmrh1bQBU3gh6Qe2D4FtkDoTGFc/eK4RLFR9cpdVyaB5PGC+BnzSsutsbQxSxfaF0
         fynLUtg5Em8fv2B8wRTQpPCfNhKpAqYK2fytbVUmKRH8T0h+RBiTkRtGLhcrt+NL0xiS
         LUQw==
X-Gm-Message-State: APjAAAVhcs00HsMIlITh7NhKOIAg8IClwX1SrnoOZHhM7T7D9EU+GIux
        oCrZsDDGL6lLA8vB24YKdz1w0m39
X-Google-Smtp-Source: APXvYqxAWNHlIR7OZI7Sfhn9xGZvkYKOUoqlbCB9aOf25+Vgw2rs5BJeocKri3aT6od51T+g20vOmg==
X-Received: by 2002:aca:d694:: with SMTP id n142mr3743246oig.69.1567352832871;
        Sun, 01 Sep 2019 08:47:12 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id b19sm3186440oie.34.2019.09.01.08.47.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 Sep 2019 08:47:12 -0700 (PDT)
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, pkshih@realtek.com,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH 4/4] rtlwifi: rtl8192cu: Convert inline routines to little-endian words
Date:   Sun,  1 Sep 2019 10:47:06 -0500
Message-Id: <20190901154706.24193-5-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190901154706.24193-1-Larry.Finger@lwfinger.net>
References: <20190901154706.24193-1-Larry.Finger@lwfinger.net>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In this step, the read/write routines for the descriptors are converted
to use __le32 quantities, thus a lot of casts can be removed. Callback
routines still use the 8-bit arrays, but these are changed within the
specified routine.

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
---
 .../net/wireless/realtek/rtlwifi/rtl8192cu/mac.c   |   2 +-
 .../net/wireless/realtek/rtlwifi/rtl8192cu/trx.c   |  26 ++-
 .../net/wireless/realtek/rtlwifi/rtl8192cu/trx.h   | 220 ++++++++++-----------
 3 files changed, 127 insertions(+), 121 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/mac.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/mac.c
index a2f878de0a70..c8daad1e749f 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/mac.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/mac.c
@@ -638,7 +638,7 @@ static void _rtl92c_query_rxphystatus(struct ieee80211_hw *hw,
 	u32 rssi, total_rssi = 0;
 	bool in_powersavemode = false;
 	bool is_cck_rate;
-	u8 *pdesc = (u8 *)p_desc;
+	__le32 *pdesc = (__le32 *)p_desc;
 
 	is_cck_rate = RX_HAL_IS_CCK_RATE(p_desc->rxmcs);
 	pstats->packet_matchbssid = packet_match_bssid;
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.c
index a9f16868791f..fc526477740f 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.c
@@ -282,10 +282,11 @@ static enum rtl_desc_qsel _rtl8192cu_mq_to_descq(struct ieee80211_hw *hw,
 bool rtl92cu_rx_query_desc(struct ieee80211_hw *hw,
 			   struct rtl_stats *stats,
 			   struct ieee80211_rx_status *rx_status,
-			   u8 *pdesc, struct sk_buff *skb)
+			   u8 *pdesc8, struct sk_buff *skb)
 {
 	struct rx_fwinfo_92c *p_drvinfo;
-	struct rx_desc_92c *p_desc = (struct rx_desc_92c *)pdesc;
+	struct rx_desc_92c *p_desc = (struct rx_desc_92c *)pdesc8;
+	__le32 *pdesc = (__le32 *)pdesc8;
 	u32 phystatus = get_rx_desc_phy_status(pdesc);
 
 	stats->length = (u16)get_rx_desc_pkt_len(pdesc);
@@ -339,7 +340,7 @@ static void _rtl_rx_process(struct ieee80211_hw *hw, struct sk_buff *skb)
 		 (struct ieee80211_rx_status *)IEEE80211_SKB_RXCB(skb);
 	u32 skb_len, pkt_len, drvinfo_len;
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
-	u8 *rxdesc;
+	__le32 *rxdesc;
 	struct rtl_stats stats = {
 		.signal = 0,
 		.rate = 0,
@@ -350,7 +351,7 @@ static void _rtl_rx_process(struct ieee80211_hw *hw, struct sk_buff *skb)
 	struct ieee80211_hdr *hdr;
 
 	memset(rx_status, 0, sizeof(*rx_status));
-	rxdesc	= skb->data;
+	rxdesc	= (__le32 *)skb->data;
 	skb_len	= skb->len;
 	drvinfo_len = (get_rx_desc_drvinfo_size(rxdesc) * RTL_RX_DRV_INFO_UNIT);
 	pkt_len		= get_rx_desc_pkt_len(rxdesc);
@@ -440,7 +441,7 @@ struct sk_buff *rtl8192c_tx_aggregate_hdl(struct ieee80211_hw *hw,
 
 /*======================================== trx ===============================*/
 
-static void _rtl_fill_usb_tx_desc(u8 *txdesc)
+static void _rtl_fill_usb_tx_desc(__le32 *txdesc)
 {
 	set_tx_desc_own(txdesc, 1);
 	set_tx_desc_last_seg(txdesc, 1);
@@ -450,7 +451,7 @@ static void _rtl_fill_usb_tx_desc(u8 *txdesc)
 /**
  *	For HW recovery information
  */
-static void _rtl_tx_desc_checksum(u8 *txdesc)
+static void _rtl_tx_desc_checksum(__le32 *txdesc)
 {
 	__le16 *ptr = (__le16 *)txdesc;
 	u16	checksum = 0;
@@ -483,11 +484,13 @@ void rtl92cu_tx_fill_desc(struct ieee80211_hw *hw,
 	u16 pktlen = skb->len;
 	enum rtl_desc_qsel fw_qsel = _rtl8192cu_mq_to_descq(hw, fc,
 						skb_get_queue_mapping(skb));
-	u8 *txdesc;
+	u8 *txdesc8;
+	__le32 *txdesc;
 
 	seq_number = (le16_to_cpu(hdr->seq_ctrl) & IEEE80211_SCTL_SEQ) >> 4;
 	rtl_get_tcb_desc(hw, info, sta, skb, tcb_desc);
-	txdesc = skb_push(skb, RTL_TX_HEADER_SIZE);
+	txdesc8 = skb_push(skb, RTL_TX_HEADER_SIZE);
+	txdesc = (__le32 *)txdesc8;
 	memset(txdesc, 0, RTL_TX_HEADER_SIZE);
 	set_tx_desc_pkt_size(txdesc, pktlen);
 	set_tx_desc_linip(txdesc, 0);
@@ -597,9 +600,11 @@ void rtl92cu_tx_fill_desc(struct ieee80211_hw *hw,
 	RT_TRACE(rtlpriv, COMP_SEND, DBG_TRACE, "==>\n");
 }
 
-void rtl92cu_fill_fake_txdesc(struct ieee80211_hw *hw, u8 *pdesc,
+void rtl92cu_fill_fake_txdesc(struct ieee80211_hw *hw, u8 *pdesc8,
 			      u32 buffer_len, bool is_pspoll)
 {
+	__le32 *pdesc = (__le32 *)pdesc8;
+
 	/* Clear all status */
 	memset(pdesc, 0, RTL_TX_HEADER_SIZE);
 	set_tx_desc_first_seg(pdesc, 1); /* bFirstSeg; */
@@ -622,13 +627,14 @@ void rtl92cu_fill_fake_txdesc(struct ieee80211_hw *hw, u8 *pdesc,
 }
 
 void rtl92cu_tx_fill_cmddesc(struct ieee80211_hw *hw,
-			     u8 *pdesc, bool firstseg,
+			     u8 *pdesc8, bool firstseg,
 			     bool lastseg, struct sk_buff *skb)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	u8 fw_queue = QSLT_BEACON;
 	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)(skb->data);
 	__le16 fc = hdr->frame_control;
+	__le32 *pdesc = (__le32 *)pdesc8;
 
 	memset((void *)pdesc, 0, RTL_TX_HEADER_SIZE);
 	if (firstseg)
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.h b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.h
index 3d8a913d799d..171fe39dfb0c 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.h
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.h
@@ -73,80 +73,80 @@ struct rx_drv_info_92c {
 /* macros to read various fields in RX descriptor */
 
 /* DWORD 0 */
-static inline u32 get_rx_desc_pkt_len(u8 *__rxdesc)
+static inline u32 get_rx_desc_pkt_len(__le32 *__rxdesc)
 {
-	return le32_get_bits(*(__le32 *)__rxdesc, GENMASK(13, 0));
+	return le32_get_bits(*__rxdesc, GENMASK(13, 0));
 }
 
-static inline u32 get_rx_desc_crc32(u8 *__rxdesc)
+static inline u32 get_rx_desc_crc32(__le32 *__rxdesc)
 {
-	return le32_get_bits(*(__le32 *)__rxdesc, BIT(14));
+	return le32_get_bits(*__rxdesc, BIT(14));
 }
 
-static inline u32 get_rx_desc_icv(u8 *__rxdesc)
+static inline u32 get_rx_desc_icv(__le32 *__rxdesc)
 {
-	return le32_get_bits(*(__le32 *)__rxdesc, BIT(15));
+	return le32_get_bits(*__rxdesc, BIT(15));
 }
 
-static inline u32 get_rx_desc_drvinfo_size(u8 *__rxdesc)
+static inline u32 get_rx_desc_drvinfo_size(__le32 *__rxdesc)
 {
-	return le32_get_bits(*(__le32 *)__rxdesc, GENMASK(19, 16));
+	return le32_get_bits(*__rxdesc, GENMASK(19, 16));
 }
 
-static inline u32 get_rx_desc_shift(u8 *__rxdesc)
+static inline u32 get_rx_desc_shift(__le32 *__rxdesc)
 {
-	return le32_get_bits(*(__le32 *)__rxdesc, GENMASK(25, 24));
+	return le32_get_bits(*__rxdesc, GENMASK(25, 24));
 }
 
-static inline u32 get_rx_desc_phy_status(u8 *__rxdesc)
+static inline u32 get_rx_desc_phy_status(__le32 *__rxdesc)
 {
-	return le32_get_bits(*(__le32 *)__rxdesc, BIT(26));
+	return le32_get_bits(*__rxdesc, BIT(26));
 }
 
-static inline u32 get_rx_desc_swdec(u8 *__rxdesc)
+static inline u32 get_rx_desc_swdec(__le32 *__rxdesc)
 {
-	return le32_get_bits(*(__le32 *)__rxdesc, BIT(27));
+	return le32_get_bits(*__rxdesc, BIT(27));
 }
 
 
 /* DWORD 1 */
-static inline u32 get_rx_desc_paggr(u8 *__rxdesc)
+static inline u32 get_rx_desc_paggr(__le32 *__rxdesc)
 {
-	return le32_get_bits(*(__le32 *)(__rxdesc + 4), BIT(14));
+	return le32_get_bits(*(__rxdesc + 1), BIT(14));
 }
 
-static inline u32 get_rx_desc_faggr(u8 *__rxdesc)
+static inline u32 get_rx_desc_faggr(__le32 *__rxdesc)
 {
-	return le32_get_bits(*(__le32 *)(__rxdesc + 4), BIT(15));
+	return le32_get_bits(*(__rxdesc + 1), BIT(15));
 }
 
 
 /* DWORD 3 */
-static inline u32 get_rx_desc_rx_mcs(u8 *__rxdesc)
+static inline u32 get_rx_desc_rx_mcs(__le32 *__rxdesc)
 {
-	return le32_get_bits(*(__le32 *)(__rxdesc + 12), GENMASK(5, 0));
+	return le32_get_bits(*(__rxdesc + 3), GENMASK(5, 0));
 }
 
-static inline u32 get_rx_desc_rx_ht(u8 *__rxdesc)
+static inline u32 get_rx_desc_rx_ht(__le32 *__rxdesc)
 {
-	return le32_get_bits(*(__le32 *)(__rxdesc + 12), BIT(6));
+	return le32_get_bits(*(__rxdesc + 3), BIT(6));
 }
 
-static inline u32 get_rx_desc_splcp(u8 *__rxdesc)
+static inline u32 get_rx_desc_splcp(__le32 *__rxdesc)
 {
-	return le32_get_bits(*(__le32 *)(__rxdesc + 12), BIT(8));
+	return le32_get_bits(*(__rxdesc + 3), BIT(8));
 }
 
-static inline u32 get_rx_desc_bw(u8 *__rxdesc)
+static inline u32 get_rx_desc_bw(__le32 *__rxdesc)
 {
-	return le32_get_bits(*(__le32 *)(__rxdesc + 12), BIT(9));
+	return le32_get_bits(*(__rxdesc + 3), BIT(9));
 }
 
 
 /* DWORD 5 */
-static inline u32 get_rx_desc_tsfl(u8 *__rxdesc)
+static inline u32 get_rx_desc_tsfl(__le32 *__rxdesc)
 {
-	return le32_to_cpu(*((__le32 *)(__rxdesc + 20)));
+	return le32_to_cpu(*((__rxdesc + 5)));
 }
 
 
@@ -155,223 +155,223 @@ static inline u32 get_rx_desc_tsfl(u8 *__rxdesc)
 /* macros to set various fields in TX descriptor */
 
 /* Dword 0 */
-static inline void set_tx_desc_pkt_size(u8 *__txdesc, u32 __value)
+static inline void set_tx_desc_pkt_size(__le32 *__txdesc, u32 __value)
 {
-	le32p_replace_bits((__le32 *)__txdesc, __value, GENMASK(15, 0));
+	le32p_replace_bits(__txdesc, __value, GENMASK(15, 0));
 }
 
-static inline void set_tx_desc_offset(u8 *__txdesc, u32 __value)
+static inline void set_tx_desc_offset(__le32 *__txdesc, u32 __value)
 {
-	le32p_replace_bits((__le32 *)__txdesc, __value, GENMASK(23, 16));
+	le32p_replace_bits(__txdesc, __value, GENMASK(23, 16));
 }
 
-static inline void set_tx_desc_bmc(u8 *__txdesc, u32 __value)
+static inline void set_tx_desc_bmc(__le32 *__txdesc, u32 __value)
 {
-	le32p_replace_bits((__le32 *)__txdesc, __value, BIT(24));
+	le32p_replace_bits(__txdesc, __value, BIT(24));
 }
 
-static inline void set_tx_desc_htc(u8 *__txdesc, u32 __value)
+static inline void set_tx_desc_htc(__le32 *__txdesc, u32 __value)
 {
-	le32p_replace_bits((__le32 *)__txdesc, __value, BIT(25));
+	le32p_replace_bits(__txdesc, __value, BIT(25));
 }
 
-static inline void set_tx_desc_last_seg(u8 *__txdesc, u32 __value)
+static inline void set_tx_desc_last_seg(__le32 *__txdesc, u32 __value)
 {
-	le32p_replace_bits((__le32 *)__txdesc, __value, BIT(26));
+	le32p_replace_bits(__txdesc, __value, BIT(26));
 }
 
-static inline void set_tx_desc_first_seg(u8 *__txdesc, u32 __value)
+static inline void set_tx_desc_first_seg(__le32 *__txdesc, u32 __value)
 {
-	le32p_replace_bits((__le32 *)__txdesc, __value, BIT(27));
+	le32p_replace_bits(__txdesc, __value, BIT(27));
 }
 
-static inline void set_tx_desc_linip(u8 *__txdesc, u32 __value)
+static inline void set_tx_desc_linip(__le32 *__txdesc, u32 __value)
 {
-	le32p_replace_bits((__le32 *)__txdesc, __value, BIT(28));
+	le32p_replace_bits(__txdesc, __value, BIT(28));
 }
 
-static inline void set_tx_desc_own(u8 *__txdesc, u32 __value)
+static inline void set_tx_desc_own(__le32 *__txdesc, u32 __value)
 {
-	le32p_replace_bits((__le32 *)__txdesc, __value, BIT(31));
+	le32p_replace_bits(__txdesc, __value, BIT(31));
 }
 
 
 /* Dword 1 */
-static inline void set_tx_desc_macid(u8 *__txdesc, u32 __value)
+static inline void set_tx_desc_macid(__le32 *__txdesc, u32 __value)
 {
-	le32p_replace_bits((__le32 *)(__txdesc + 4), __value, GENMASK(4, 0));
+	le32p_replace_bits((__txdesc + 1), __value, GENMASK(4, 0));
 }
 
-static inline void set_tx_desc_agg_enable(u8 *__txdesc, u32 __value)
+static inline void set_tx_desc_agg_enable(__le32 *__txdesc, u32 __value)
 {
-	le32p_replace_bits((__le32 *)(__txdesc + 4), __value, BIT(5));
+	le32p_replace_bits((__txdesc + 1), __value, BIT(5));
 }
 
-static inline void set_tx_desc_agg_break(u8 *__txdesc, u32 __value)
+static inline void set_tx_desc_agg_break(__le32 *__txdesc, u32 __value)
 {
-	le32p_replace_bits((__le32 *)(__txdesc + 4), __value, BIT(6));
+	le32p_replace_bits((__txdesc + 1), __value, BIT(6));
 }
 
-static inline void set_tx_desc_rdg_enable(u8 *__txdesc, u32 __value)
+static inline void set_tx_desc_rdg_enable(__le32 *__txdesc, u32 __value)
 {
-	le32p_replace_bits((__le32 *)(__txdesc + 4), __value, BIT(7));
+	le32p_replace_bits((__txdesc + 1), __value, BIT(7));
 }
 
-static inline void set_tx_desc_queue_sel(u8 *__txdesc, u32 __value)
+static inline void set_tx_desc_queue_sel(__le32 *__txdesc, u32 __value)
 {
-	le32p_replace_bits((__le32 *)(__txdesc + 4), __value, GENMASK(12, 8));
+	le32p_replace_bits((__txdesc + 1), __value, GENMASK(12, 8));
 }
 
-static inline void set_tx_desc_rate_id(u8 *__txdesc, u32 __value)
+static inline void set_tx_desc_rate_id(__le32 *__txdesc, u32 __value)
 {
-	le32p_replace_bits((__le32 *)(__txdesc + 4), __value, GENMASK(19, 16));
+	le32p_replace_bits((__txdesc + 1), __value, GENMASK(19, 16));
 }
 
-static inline void set_tx_desc_nav_use_hdr(u8 *__txdesc, u32 __value)
+static inline void set_tx_desc_nav_use_hdr(__le32 *__txdesc, u32 __value)
 {
-	le32p_replace_bits((__le32 *)(__txdesc + 4), __value, BIT(20));
+	le32p_replace_bits((__txdesc + 1), __value, BIT(20));
 }
 
-static inline void set_tx_desc_sec_type(u8 *__txdesc, u32 __value)
+static inline void set_tx_desc_sec_type(__le32 *__txdesc, u32 __value)
 {
-	le32p_replace_bits((__le32 *)(__txdesc + 4), __value, GENMASK(23, 22));
+	le32p_replace_bits((__txdesc + 1), __value, GENMASK(23, 22));
 }
 
-static inline void set_tx_desc_pkt_offset(u8 *__txdesc, u32 __value)
+static inline void set_tx_desc_pkt_offset(__le32 *__txdesc, u32 __value)
 {
-	le32p_replace_bits((__le32 *)(__txdesc + 4), __value, GENMASK(30, 26));
+	le32p_replace_bits((__txdesc + 1), __value, GENMASK(30, 26));
 }
 
 
 /* Dword 2 */
-static inline void set_tx_desc_more_frag(u8 *__txdesc, u32 __value)
+static inline void set_tx_desc_more_frag(__le32 *__txdesc, u32 __value)
 {
-	le32p_replace_bits((__le32 *)(__txdesc + 8), __value, BIT(17));
+	le32p_replace_bits((__txdesc + 2), __value, BIT(17));
 }
 
-static inline void set_tx_desc_ampdu_density(u8 *__txdesc, u32 __value)
+static inline void set_tx_desc_ampdu_density(__le32 *__txdesc, u32 __value)
 {
-	le32p_replace_bits((__le32 *)(__txdesc + 8), __value, GENMASK(22, 20));
+	le32p_replace_bits((__txdesc + 2), __value, GENMASK(22, 20));
 }
 
 
 /* Dword 3 */
-static inline void set_tx_desc_seq(u8 *__txdesc, u32 __value)
+static inline void set_tx_desc_seq(__le32 *__txdesc, u32 __value)
 {
-	le32p_replace_bits((__le32 *)(__txdesc + 12), __value, GENMASK(27, 16));
+	le32p_replace_bits((__txdesc + 3), __value, GENMASK(27, 16));
 }
 
-static inline void set_tx_desc_pkt_id(u8 *__txdesc, u32 __value)
+static inline void set_tx_desc_pkt_id(__le32 *__txdesc, u32 __value)
 {
-	le32p_replace_bits((__le32 *)(__txdesc + 12), __value, GENMASK(31, 28));
+	le32p_replace_bits((__txdesc + 3), __value, GENMASK(31, 28));
 }
 
 
 /* Dword 4 */
-static inline void set_tx_desc_rts_rate(u8 *__txdesc, u32 __value)
+static inline void set_tx_desc_rts_rate(__le32 *__txdesc, u32 __value)
 {
-	le32p_replace_bits((__le32 *)(__txdesc + 16), __value, GENMASK(4, 0));
+	le32p_replace_bits((__txdesc + 4), __value, GENMASK(4, 0));
 }
 
-static inline void set_tx_desc_qos(u8 *__txdesc, u32 __value)
+static inline void set_tx_desc_qos(__le32 *__txdesc, u32 __value)
 {
-	le32p_replace_bits((__le32 *)(__txdesc + 16), __value, BIT(6));
+	le32p_replace_bits((__txdesc + 4), __value, BIT(6));
 }
 
-static inline void set_tx_desc_hwseq_en(u8 *__txdesc, u32 __value)
+static inline void set_tx_desc_hwseq_en(__le32 *__txdesc, u32 __value)
 {
-	le32p_replace_bits((__le32 *)(__txdesc + 16), __value, BIT(7));
+	le32p_replace_bits((__txdesc + 4), __value, BIT(7));
 }
 
-static inline void set_tx_desc_use_rate(u8 *__txdesc, u32 __value)
+static inline void set_tx_desc_use_rate(__le32 *__txdesc, u32 __value)
 {
-	le32p_replace_bits((__le32 *)(__txdesc + 16), __value, BIT(8));
+	le32p_replace_bits((__txdesc + 4), __value, BIT(8));
 }
 
-static inline void set_tx_desc_disable_fb(u8 *__txdesc, u32 __value)
+static inline void set_tx_desc_disable_fb(__le32 *__txdesc, u32 __value)
 {
-	le32p_replace_bits((__le32 *)(__txdesc + 16), __value, BIT(10));
+	le32p_replace_bits((__txdesc + 4), __value, BIT(10));
 }
 
-static inline void set_tx_desc_cts2self(u8 *__txdesc, u32 __value)
+static inline void set_tx_desc_cts2self(__le32 *__txdesc, u32 __value)
 {
-	le32p_replace_bits((__le32 *)(__txdesc + 16), __value, BIT(11));
+	le32p_replace_bits((__txdesc + 4), __value, BIT(11));
 }
 
-static inline void set_tx_desc_rts_enable(u8 *__txdesc, u32 __value)
+static inline void set_tx_desc_rts_enable(__le32 *__txdesc, u32 __value)
 {
-	le32p_replace_bits((__le32 *)(__txdesc + 16), __value, BIT(12));
+	le32p_replace_bits((__txdesc + 4), __value, BIT(12));
 }
 
-static inline void set_tx_desc_hw_rts_enable(u8 *__txdesc, u32 __value)
+static inline void set_tx_desc_hw_rts_enable(__le32 *__txdesc, u32 __value)
 {
-	le32p_replace_bits((__le32 *)(__txdesc + 16), __value, BIT(13));
+	le32p_replace_bits((__txdesc + 4), __value, BIT(13));
 }
 
-static inline void set_tx_desc_data_sc(u8 *__txdesc, u32 __value)
+static inline void set_tx_desc_data_sc(__le32 *__txdesc, u32 __value)
 {
-	le32p_replace_bits((__le32 *)(__txdesc + 16), __value, GENMASK(21, 20));
+	le32p_replace_bits((__txdesc + 4), __value, GENMASK(21, 20));
 }
 
-static inline void set_tx_desc_data_bw(u8 *__txdesc, u32 __value)
+static inline void set_tx_desc_data_bw(__le32 *__txdesc, u32 __value)
 {
-	le32p_replace_bits((__le32 *)(__txdesc + 16), __value, BIT(25));
+	le32p_replace_bits((__txdesc + 4), __value, BIT(25));
 }
 
-static inline void set_tx_desc_rts_short(u8 *__txdesc, u32 __value)
+static inline void set_tx_desc_rts_short(__le32 *__txdesc, u32 __value)
 {
-	le32p_replace_bits((__le32 *)(__txdesc + 16), __value, BIT(26));
+	le32p_replace_bits((__txdesc + 4), __value, BIT(26));
 }
 
-static inline void set_tx_desc_rts_bw(u8 *__txdesc, u32 __value)
+static inline void set_tx_desc_rts_bw(__le32 *__txdesc, u32 __value)
 {
-	le32p_replace_bits((__le32 *)(__txdesc + 16), __value, BIT(27));
+	le32p_replace_bits((__txdesc + 4), __value, BIT(27));
 }
 
-static inline void set_tx_desc_rts_sc(u8 *__txdesc, u32 __value)
+static inline void set_tx_desc_rts_sc(__le32 *__txdesc, u32 __value)
 {
-	le32p_replace_bits((__le32 *)(__txdesc + 16), __value, GENMASK(29, 28));
+	le32p_replace_bits((__txdesc + 4), __value, GENMASK(29, 28));
 }
 
-static inline void set_tx_desc_rts_stbc(u8 *__txdesc, u32 __value)
+static inline void set_tx_desc_rts_stbc(__le32 *__txdesc, u32 __value)
 {
-	le32p_replace_bits((__le32 *)(__txdesc + 16), __value, GENMASK(31, 30));
+	le32p_replace_bits((__txdesc + 4), __value, GENMASK(31, 30));
 }
 
 
 /* Dword 5 */
-static inline void set_tx_desc_tx_rate(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_tx_rate(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 20), __val, GENMASK(5, 0));
+	le32p_replace_bits((__pdesc + 5), __val, GENMASK(5, 0));
 }
 
-static inline void set_tx_desc_data_shortgi(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_data_shortgi(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 20), __val, BIT(6));
+	le32p_replace_bits((__pdesc + 5), __val, BIT(6));
 }
 
-static inline void set_tx_desc_data_rate_fb_limit(u8 *__txdesc, u32 __value)
+static inline void set_tx_desc_data_rate_fb_limit(__le32 *__txdesc, u32 __value)
 {
-	le32p_replace_bits((__le32 *)(__txdesc + 20), __value, GENMASK(12, 8));
+	le32p_replace_bits((__txdesc + 5), __value, GENMASK(12, 8));
 }
 
-static inline void set_tx_desc_rts_rate_fb_limit(u8 *__txdesc, u32 __value)
+static inline void set_tx_desc_rts_rate_fb_limit(__le32 *__txdesc, u32 __value)
 {
-	le32p_replace_bits((__le32 *)(__txdesc + 20), __value, GENMASK(16, 13));
+	le32p_replace_bits((__txdesc + 5), __value, GENMASK(16, 13));
 }
 
 
 /* Dword 6 */
-static inline void set_tx_desc_max_agg_num(u8 *__txdesc, u32 __value)
+static inline void set_tx_desc_max_agg_num(__le32 *__txdesc, u32 __value)
 {
-	le32p_replace_bits((__le32 *)(__txdesc + 24), __value, GENMASK(15, 11));
+	le32p_replace_bits((__txdesc + 6), __value, GENMASK(15, 11));
 }
 
 
 /* Dword 7 */
-static inline void set_tx_desc_tx_desc_checksum(u8 *__txdesc, u32 __value)
+static inline void set_tx_desc_tx_desc_checksum(__le32 *__txdesc, u32 __value)
 {
-	le32p_replace_bits((__le32 *)(__txdesc + 28), __value, GENMASK(15, 0));
+	le32p_replace_bits((__txdesc + 7), __value, GENMASK(15, 0));
 }
 
 
-- 
2.16.4

