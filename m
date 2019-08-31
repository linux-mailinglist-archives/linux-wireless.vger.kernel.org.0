Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6927A45BA
	for <lists+linux-wireless@lfdr.de>; Sat, 31 Aug 2019 20:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728527AbfHaSHF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 31 Aug 2019 14:07:05 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:38973 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728504AbfHaSHF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 31 Aug 2019 14:07:05 -0400
Received: by mail-ot1-f65.google.com with SMTP id n7so2595726otk.6
        for <linux-wireless@vger.kernel.org>; Sat, 31 Aug 2019 11:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xaLM7m11T8+Jd4Gtp0h7BfrMug0pvh6awugwv2rGFBY=;
        b=WbBh6KKdvoBWWzonp7/eXoACYfwOSh34qDGBvuqmEPddM3MIxYPoS5jCFUvjvn1wo4
         K9yLyT3U+r2udxTiRLJtwyqS45WFI3fLJKc4gkS+fONO9CP/NqHvJObSeFOYITLnGwIF
         2tFt/MoC+b20Yor7gyfgGOV45wDjLk/sAY07RSgcD7c4Pv66oVKyZiL+moUXDAqGFHg2
         bFPOOWriUTQncuHOWt2npNDN7+v5xVHfK/+1UjLp/JpZOEfWwqat8ZmT8X8ey4kl/wmp
         DDHykh3HWznlxHxla3tGEnf5HXiUmxBcw2Q7FIBmQ7D8rMC1p17vUHViXNETaXx6XAZi
         Uo0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=xaLM7m11T8+Jd4Gtp0h7BfrMug0pvh6awugwv2rGFBY=;
        b=QpCYTgaCoW3OPd9cPay+0x+8+uO9PzlDFSQD3OEtwZrYG2R3UHj2FhM/iPkvX6QUz8
         5UHNIpauVP39lsBVi0GL7kLsJWI6H4UOeIWozmEemwBMKwrn3reLBMYFk2Zc54BKKNKK
         8u7GHcrWfvMxtJMWJc6HVGHlqfog2PjsKuuXgIDYWPAZhYmzDzZITW4fsSFHDwhvlW2I
         68m/7wSQ4SvOmV2EYPPi0PQ6EiCgwiIsu1oVzGHsoFqpaI46aeqs/fgphNyNx+yOA5Zc
         aHXKt/EuioKsRZ7k3qsyuHiDYQohc14TOXQT8hexgC7RPXJY3uULayz4OnZSB9hDPZgm
         cgJA==
X-Gm-Message-State: APjAAAVwra+/nWOy58Ma/fbf2WlKJ2HFYNR7rG6HzmEPS3Fz0P5CJTGm
        FVhkU5C9zc2+FWQkWe7MOWsKM5zP
X-Google-Smtp-Source: APXvYqzcuGyECXHjC2f1oDOb9TrKZWWvtTfUs11MFtMDCiXuYyPZ8iwFZWcMaUOCYUX/G9/LRvShiQ==
X-Received: by 2002:a9d:725b:: with SMTP id a27mr10907505otk.17.1567274822888;
        Sat, 31 Aug 2019 11:07:02 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id c11sm3222346otr.54.2019.08.31.11.07.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 31 Aug 2019 11:07:02 -0700 (PDT)
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, pkshih@realtek.com,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH 4/5] rtlwifi: rtl8192ee: Convert inline routines to little-endian words
Date:   Sat, 31 Aug 2019 13:06:43 -0500
Message-Id: <20190831180644.7937-5-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190831180644.7937-1-Larry.Finger@lwfinger.net>
References: <20190831180644.7937-1-Larry.Finger@lwfinger.net>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In this step, the read/write routines for the descriptors are converted
to use __le32 quantities, thus a lot of casts can be removed. Callback
routines still use the 8-bit arrays, but these are changed within the
specified routine.

The macro that cleared a descriptor has now been converted into an inline
routine.

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
---
 .../net/wireless/realtek/rtlwifi/rtl8192ee/trx.c   |  38 ++-
 .../net/wireless/realtek/rtlwifi/rtl8192ee/trx.h   | 359 +++++++++++----------
 2 files changed, 203 insertions(+), 194 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/trx.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/trx.c
index dedd1cc8c369..0706888fe3de 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/trx.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/trx.c
@@ -271,9 +271,10 @@ static void _rtl92ee_translate_rx_signal_stuff(struct ieee80211_hw *hw,
 }
 
 static void _rtl92ee_insert_emcontent(struct rtl_tcb_desc *ptcb_desc,
-				      u8 *virtualaddress)
+				      u8 *virtualaddress8)
 {
 	u32 dwtmp = 0;
+	__le32 *virtualaddress = (__le32 *)virtualaddress8;
 
 	memset(virtualaddress, 0, 8);
 
@@ -325,11 +326,12 @@ static void _rtl92ee_insert_emcontent(struct rtl_tcb_desc *ptcb_desc,
 bool rtl92ee_rx_query_desc(struct ieee80211_hw *hw,
 			   struct rtl_stats *status,
 			   struct ieee80211_rx_status *rx_status,
-			   u8 *pdesc, struct sk_buff *skb)
+			   u8 *pdesc8, struct sk_buff *skb)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	struct rx_fwinfo *p_drvinfo;
 	struct ieee80211_hdr *hdr;
+	__le32 *pdesc = (__le32 *)pdesc8;
 	u32 phystatus = get_rx_desc_physt(pdesc);
 	u8 wake_match;
 
@@ -409,7 +411,7 @@ bool rtl92ee_rx_query_desc(struct ieee80211_hw *hw,
 		p_drvinfo = (struct rx_fwinfo *)(skb->data +
 						 status->rx_bufshift + 24);
 
-		_rtl92ee_translate_rx_signal_stuff(hw, skb, status, pdesc,
+		_rtl92ee_translate_rx_signal_stuff(hw, skb, status, pdesc8,
 						   p_drvinfo);
 	}
 	rx_status->signal = status->recvsignalpower + 10;
@@ -423,13 +425,14 @@ bool rtl92ee_rx_query_desc(struct ieee80211_hw *hw,
 }
 
 /*in Windows, this == Rx_92EE_Interrupt*/
-void rtl92ee_rx_check_dma_ok(struct ieee80211_hw *hw, u8 *header_desc,
+void rtl92ee_rx_check_dma_ok(struct ieee80211_hw *hw, u8 *header_desc8,
 			     u8 queue_index)
 {
 	u8 first_seg = 0;
 	u8 last_seg = 0;
 	u16 total_len = 0;
 	u16 read_cnt = 0;
+	__le32 *header_desc = (__le32 *)header_desc8;
 
 	if (header_desc == NULL)
 		return;
@@ -546,7 +549,7 @@ u16 rtl92ee_get_available_desc(struct ieee80211_hw *hw, u8 q_idx)
 }
 
 void rtl92ee_pre_fill_tx_bd_desc(struct ieee80211_hw *hw,
-				 u8 *tx_bd_desc, u8 *desc, u8 queue_index,
+				 u8 *tx_bd_desc8, u8 *desc8, u8 queue_index,
 				 struct sk_buff *skb, dma_addr_t addr)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
@@ -563,6 +566,8 @@ void rtl92ee_pre_fill_tx_bd_desc(struct ieee80211_hw *hw,
 	u8 segmentnum = 1 << (RTL8192EE_SEG_NUM + 1);
 	dma_addr_t desc_dma_addr;
 	bool dma64 = rtlpriv->cfg->mod_params->dma64;
+	__le32 *desc = (__le32 *)desc8;
+	__le32 *tx_bd_desc = (__le32 *)tx_bd_desc8;
 
 	tx_page_size = 2;
 	current_bd_desc = rtlpci->tx_ring[queue_index].cur_tx_wp;
@@ -601,7 +606,7 @@ void rtl92ee_pre_fill_tx_bd_desc(struct ieee80211_hw *hw,
 	}
 
 	/* Clear all status */
-	CLEAR_PCI_TX_DESC_CONTENT(desc, TX_DESC_SIZE);
+	clear_pci_tx_desc_content(desc, TX_DESC_SIZE);
 
 	if (rtlpriv->rtlhal.earlymode_enable) {
 		if (queue_index < BEACON_QUEUE) {
@@ -630,7 +635,7 @@ void rtl92ee_pre_fill_tx_bd_desc(struct ieee80211_hw *hw,
 }
 
 void rtl92ee_tx_fill_desc(struct ieee80211_hw *hw,
-			  struct ieee80211_hdr *hdr, u8 *pdesc_tx,
+			  struct ieee80211_hdr *hdr, u8 *pdesc8,
 			  u8 *pbd_desc_tx,
 			  struct ieee80211_tx_info *info,
 			  struct ieee80211_sta *sta,
@@ -642,7 +647,6 @@ void rtl92ee_tx_fill_desc(struct ieee80211_hw *hw,
 	struct rtl_pci *rtlpci = rtl_pcidev(rtl_pcipriv(hw));
 	struct rtl_hal *rtlhal = rtl_hal(rtlpriv);
 	struct rtlwifi_tx_info *tx_info = rtl_tx_skb_cb_info(skb);
-	u8 *pdesc = (u8 *)pdesc_tx;
 	u16 seq_number;
 	__le16 fc = hdr->frame_control;
 	unsigned int buf_len = 0;
@@ -654,6 +658,7 @@ void rtl92ee_tx_fill_desc(struct ieee80211_hw *hw,
 	dma_addr_t mapping;
 	u8 bw_40 = 0;
 	u8 short_gi = 0;
+	__le32 *pdesc = (__le32 *)pdesc8;
 
 	if (mac->opmode == NL80211_IFTYPE_STATION) {
 		bw_40 = mac->bw_40;
@@ -680,7 +685,7 @@ void rtl92ee_tx_fill_desc(struct ieee80211_hw *hw,
 	}
 
 	if (pbd_desc_tx != NULL)
-		rtl92ee_pre_fill_tx_bd_desc(hw, pbd_desc_tx, pdesc, hw_queue,
+		rtl92ee_pre_fill_tx_bd_desc(hw, pbd_desc_tx, pdesc8, hw_queue,
 					    skb, mapping);
 
 	if (ieee80211_is_nullfunc(fc) || ieee80211_is_ctl(fc)) {
@@ -806,7 +811,7 @@ void rtl92ee_tx_fill_desc(struct ieee80211_hw *hw,
 			}
 		}
 		/* tx report */
-		rtl_set_tx_report(ptcb_desc, pdesc, hw, tx_info);
+		rtl_set_tx_report(ptcb_desc, pdesc8, hw, tx_info);
 	}
 
 	set_tx_desc_first_seg(pdesc, (firstseg ? 1 : 0));
@@ -829,7 +834,7 @@ void rtl92ee_tx_fill_desc(struct ieee80211_hw *hw,
 }
 
 void rtl92ee_tx_fill_cmddesc(struct ieee80211_hw *hw,
-			     u8 *pdesc, bool firstseg,
+			     u8 *pdesc8, bool firstseg,
 			     bool lastseg, struct sk_buff *skb)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
@@ -839,13 +844,14 @@ void rtl92ee_tx_fill_cmddesc(struct ieee80211_hw *hw,
 					    skb->data, skb->len,
 					    PCI_DMA_TODEVICE);
 	u8 txdesc_len = 40;
+	__le32 *pdesc = (__le32 *)pdesc8;
 
 	if (pci_dma_mapping_error(rtlpci->pdev, mapping)) {
 		RT_TRACE(rtlpriv, COMP_SEND, DBG_TRACE,
 			 "DMA mapping error\n");
 		return;
 	}
-	CLEAR_PCI_TX_DESC_CONTENT(pdesc, txdesc_len);
+	clear_pci_tx_desc_content(pdesc, txdesc_len);
 
 	if (firstseg)
 		set_tx_desc_offset(pdesc, txdesc_len);
@@ -870,7 +876,7 @@ void rtl92ee_tx_fill_cmddesc(struct ieee80211_hw *hw,
 
 	set_tx_desc_own(pdesc, 1);
 
-	set_tx_desc_pkt_size((u8 *)pdesc, (u16)(skb->len));
+	set_tx_desc_pkt_size(pdesc, (u16)(skb->len));
 
 	set_tx_desc_first_seg(pdesc, 1);
 	set_tx_desc_last_seg(pdesc, 1);
@@ -883,12 +889,13 @@ void rtl92ee_tx_fill_cmddesc(struct ieee80211_hw *hw,
 		      "H2C Tx Cmd Content\n", pdesc, txdesc_len);
 }
 
-void rtl92ee_set_desc(struct ieee80211_hw *hw, u8 *pdesc, bool istx,
+void rtl92ee_set_desc(struct ieee80211_hw *hw, u8 *pdesc8, bool istx,
 		      u8 desc_name, u8 *val)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	u8 q_idx = *val;
 	bool dma64 = rtlpriv->cfg->mod_params->dma64;
+	__le32 *pdesc = (__le32 *)pdesc8;
 
 	if (istx) {
 		switch (desc_name) {
@@ -947,11 +954,12 @@ void rtl92ee_set_desc(struct ieee80211_hw *hw, u8 *pdesc, bool istx,
 }
 
 u64 rtl92ee_get_desc(struct ieee80211_hw *hw,
-		     u8 *pdesc, bool istx, u8 desc_name)
+		     u8 *pdesc8, bool istx, u8 desc_name)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	u64 ret = 0;
 	bool dma64 = rtlpriv->cfg->mod_params->dma64;
+	__le32 *pdesc = (__le32 *)pdesc8;
 
 	if (istx) {
 		switch (desc_name) {
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/trx.h b/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/trx.h
index ffe8097e0ed2..967cef3a9cbf 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/trx.h
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/trx.h
@@ -14,470 +14,471 @@
 #define RX_DESC_SIZE					24
 #define MAX_RECEIVE_BUFFER_SIZE				8192
 
-static inline void set_tx_desc_pkt_size(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_pkt_size(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)__pdesc, __val, GENMASK(15, 0));
+	le32p_replace_bits(__pdesc, __val, GENMASK(15, 0));
 }
 
-static inline void set_tx_desc_offset(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_offset(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)__pdesc, __val, GENMASK(23, 16));
+	le32p_replace_bits(__pdesc, __val, GENMASK(23, 16));
 }
 
-static inline void set_tx_desc_bmc(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_bmc(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)__pdesc, __val, BIT(24));
+	le32p_replace_bits(__pdesc, __val, BIT(24));
 }
 
-static inline void set_tx_desc_htc(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_htc(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)__pdesc, __val, BIT(25));
+	le32p_replace_bits(__pdesc, __val, BIT(25));
 }
 
-static inline void set_tx_desc_last_seg(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_last_seg(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)__pdesc, __val, BIT(26));
+	le32p_replace_bits(__pdesc, __val, BIT(26));
 }
 
-static inline void set_tx_desc_first_seg(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_first_seg(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)__pdesc, __val, BIT(27));
+	le32p_replace_bits(__pdesc, __val, BIT(27));
 }
 
-static inline void set_tx_desc_linip(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_linip(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)__pdesc, __val, BIT(28));
+	le32p_replace_bits(__pdesc, __val, BIT(28));
 }
 
-static inline void set_tx_desc_own(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_own(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)__pdesc, __val, BIT(31));
+	le32p_replace_bits(__pdesc, __val, BIT(31));
 }
 
-static inline int get_tx_desc_own(u8 *__pdesc)
+static inline int get_tx_desc_own(__le32 *__pdesc)
 {
-	return le32_get_bits(*((__le32 *)__pdesc), BIT(31));
+	return le32_get_bits(*(__pdesc), BIT(31));
 }
 
-static inline void set_tx_desc_macid(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_macid(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 4), __val, GENMASK(6, 0));
+	le32p_replace_bits((__pdesc + 1), __val, GENMASK(6, 0));
 }
 
-static inline void set_tx_desc_queue_sel(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_queue_sel(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 4), __val, GENMASK(12, 8));
+	le32p_replace_bits((__pdesc + 1), __val, GENMASK(12, 8));
 }
 
-static inline void set_tx_desc_rate_id(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_rate_id(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 4), __val, GENMASK(20, 16));
+	le32p_replace_bits((__pdesc + 1), __val, GENMASK(20, 16));
 }
 
-static inline void set_tx_desc_sec_type(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_sec_type(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 4), __val, GENMASK(23, 22));
+	le32p_replace_bits((__pdesc + 1), __val, GENMASK(23, 22));
 }
 
-static inline void set_tx_desc_pkt_offset(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_pkt_offset(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 4), __val, GENMASK(28, 24));
+	le32p_replace_bits((__pdesc + 1), __val, GENMASK(28, 24));
 }
 
-static inline void set_tx_desc_agg_enable(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_agg_enable(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 8), __val, BIT(12));
+	le32p_replace_bits((__pdesc + 2), __val, BIT(12));
 }
 
-static inline void set_tx_desc_rdg_enable(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_rdg_enable(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 8), __val, BIT(13));
+	le32p_replace_bits((__pdesc + 2), __val, BIT(13));
 }
 
-static inline void set_tx_desc_more_frag(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_more_frag(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 8), __val, BIT(17));
+	le32p_replace_bits((__pdesc + 2), __val, BIT(17));
 }
 
-static inline void set_tx_desc_ampdu_density(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_ampdu_density(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 8), __val, GENMASK(22, 20));
+	le32p_replace_bits((__pdesc + 2), __val, GENMASK(22, 20));
 }
 
-static inline void set_tx_desc_use_rate(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_use_rate(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 12), __val, BIT(8));
+	le32p_replace_bits((__pdesc + 3), __val, BIT(8));
 }
 
-static inline void set_tx_desc_disable_fb(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_disable_fb(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 12), __val, BIT(10));
+	le32p_replace_bits((__pdesc + 3), __val, BIT(10));
 }
 
-static inline void set_tx_desc_cts2self(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_cts2self(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 12), __val, BIT(11));
+	le32p_replace_bits((__pdesc + 3), __val, BIT(11));
 }
 
-static inline void set_tx_desc_rts_enable(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_rts_enable(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 12), __val, BIT(12));
+	le32p_replace_bits((__pdesc + 3), __val, BIT(12));
 }
 
-static inline void set_tx_desc_hw_rts_enable(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_hw_rts_enable(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 12), __val, BIT(13));
+	le32p_replace_bits((__pdesc + 3), __val, BIT(13));
 }
 
-static inline void set_tx_desc_nav_use_hdr(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_nav_use_hdr(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 12), __val, BIT(15));
+	le32p_replace_bits((__pdesc + 3), __val, BIT(15));
 }
 
-static inline void set_tx_desc_max_agg_num(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_max_agg_num(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 12), __val, GENMASK(21, 17));
+	le32p_replace_bits((__pdesc + 3), __val, GENMASK(21, 17));
 }
 
 /* Dword 4 */
-static inline void set_tx_desc_tx_rate(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_tx_rate(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, GENMASK(6, 0));
+	le32p_replace_bits((__pdesc + 4), __val, GENMASK(6, 0));
 }
 
-static inline void set_tx_desc_data_rate_fb_limit(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_data_rate_fb_limit(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, GENMASK(12, 8));
+	le32p_replace_bits((__pdesc + 4), __val, GENMASK(12, 8));
 }
 
-static inline void set_tx_desc_rts_rate_fb_limit(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_rts_rate_fb_limit(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, GENMASK(16, 13));
+	le32p_replace_bits((__pdesc + 4), __val, GENMASK(16, 13));
 }
 
-static inline void set_tx_desc_rts_rate(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_rts_rate(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, GENMASK(28, 24));
+	le32p_replace_bits((__pdesc + 4), __val, GENMASK(28, 24));
 }
 
 /* Dword 5 */
-static inline void set_tx_desc_tx_sub_carrier(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_tx_sub_carrier(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 20), __val, GENMASK(3, 0));
+	le32p_replace_bits((__pdesc + 5), __val, GENMASK(3, 0));
 }
 
-static inline void set_tx_desc_data_bw(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_data_bw(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 20), __val, GENMASK(6, 5));
+	le32p_replace_bits((__pdesc + 4), __val, GENMASK(6, 5));
 }
 
-static inline void set_tx_desc_rts_short(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_rts_short(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 20), __val, BIT(12));
+	le32p_replace_bits((__pdesc + 5), __val, BIT(12));
 }
 
-static inline void set_tx_desc_rts_sc(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_rts_sc(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 20), __val, GENMASK(16, 13));
+	le32p_replace_bits((__pdesc + 5), __val, GENMASK(16, 13));
 }
 
 /* Dword 7 */
-static inline void set_tx_desc_tx_buffer_size(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_tx_buffer_size(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 28), __val, GENMASK(15, 0));
+	le32p_replace_bits((__pdesc + 7), __val, GENMASK(15, 0));
 }
 
 /* Dword 9 */
-static inline void set_tx_desc_seq(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_seq(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 36), __val, GENMASK(23, 12));
+	le32p_replace_bits((__pdesc + 9), __val, GENMASK(23, 12));
 }
 
 /* Dword 10 */
-static inline void set_tx_desc_tx_buffer_address(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_tx_buffer_address(__le32 *__pdesc, u32 __val)
 {
-	*(__le32 *)(__pdesc + 40) = cpu_to_le32(__val);
+	*(__pdesc + 10) = cpu_to_le32(__val);
 }
 
 /* Dword 11*/
-static inline void set_tx_desc_next_desc_address(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_next_desc_address(__le32 *__pdesc, u32 __val)
 {
-	*(__le32 *)(__pdesc + 48) = cpu_to_le32(__val);
+	*(__pdesc + 12) = cpu_to_le32(__val);
 }
 
-static inline void set_earlymode_pktnum(u8 *__paddr, u32 __val)
+static inline void set_earlymode_pktnum(__le32 *__paddr, u32 __val)
 {
-	le32p_replace_bits((__le32 *)__paddr, __val, GENMASK(3, 0));
+	le32p_replace_bits(__paddr, __val, GENMASK(3, 0));
 }
 
-static inline void set_earlymode_len0(u8 *__paddr, u32 __val)
+static inline void set_earlymode_len0(__le32 *__paddr, u32 __val)
 {
-	le32p_replace_bits((__le32 *)__paddr, __val, GENMASK(18, 4));
+	le32p_replace_bits(__paddr, __val, GENMASK(18, 4));
 }
 
-static inline void set_earlymode_len1(u8 *__paddr, u32 __val)
+static inline void set_earlymode_len1(__le32 *__paddr, u32 __val)
 {
-	le32p_replace_bits((__le32 *)__paddr, __val, GENMASK(17, 16));
+	le32p_replace_bits(__paddr, __val, GENMASK(17, 16));
 }
 
-static inline void set_earlymode_len2_1(u8 *__paddr, u32 __val)
+static inline void set_earlymode_len2_1(__le32 *__paddr, u32 __val)
 {
-	le32p_replace_bits((__le32 *)__paddr, __val, GENMASK(5, 2));
+	le32p_replace_bits(__paddr, __val, GENMASK(5, 2));
 }
 
-static inline void set_earlymode_len2_2(u8 *__paddr, u32 __val)
+static inline void set_earlymode_len2_2(__le32 *__paddr, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__paddr + 4), __val, GENMASK(7, 0));
+	le32p_replace_bits((__paddr + 1), __val, GENMASK(7, 0));
 }
 
-static inline void set_earlymode_len3(u8 *__paddr, u32 __val)
+static inline void set_earlymode_len3(__le32 *__paddr, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__paddr + 4), __val, GENMASK(31, 17));
+	le32p_replace_bits((__paddr + 1), __val, GENMASK(31, 17));
 }
 
-static inline void set_earlymode_len4(u8 *__paddr, u32 __val)
+static inline void set_earlymode_len4(__le32 *__paddr, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__paddr + 4), __val, GENMASK(31, 20));
+	le32p_replace_bits((__paddr + 1), __val, GENMASK(31, 20));
 }
 
 /* TX/RX buffer descriptor */
 
 /* for Txfilldescroptor92ee, fill the desc content. */
-static inline void set_txbuffer_desc_len_with_offset(u8 *__pdesc,
+static inline void set_txbuffer_desc_len_with_offset(__le32 *__pdesc,
 						     u8 __offset, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 16 * __offset), __val,
+	le32p_replace_bits((__pdesc + 4 * __offset), __val,
 			   GENMASK(15, 0));
 }
 
-static inline void set_txbuffer_desc_amsdu_with_offset(u8 *__pdesc,
+static inline void set_txbuffer_desc_amsdu_with_offset(__le32 *__pdesc,
 						       u8 __offset, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 16 * __offset), __val, BIT(31));
+	le32p_replace_bits((__pdesc + 4 * __offset), __val, BIT(31));
 }
 
-static inline void set_txbuffer_desc_add_low_with_offset(u8 *__pdesc,
+static inline void set_txbuffer_desc_add_low_with_offset(__le32 *__pdesc,
 							 u8 __offset,
 							 u32 __val)
 {
-	*(__le32 *)(__pdesc + 16 * __offset + 4) = cpu_to_le32(__val);
+	*(__pdesc + 4 * __offset + 1) = cpu_to_le32(__val);
 }
 
-static inline void set_txbuffer_desc_add_high_with_offset(u8 *pbd, u8 off,
+static inline void set_txbuffer_desc_add_high_with_offset(__le32 *pbd, u8 off,
 							  u32 val, bool dma64)
 {
 	if (dma64)
-		*(__le32 *)(pbd + 16 * off + 8) = cpu_to_le32(val);
+		*(pbd + 4 * off + 2) = cpu_to_le32(val);
 	else
-		*(__le32 *)(pbd + 16 * off + 8) = 0;
+		*(pbd + 4 * off + 2) = 0;
 }
 
-static inline u32 get_txbuffer_desc_addr_low(u8 *__pdesc, u8 __offset)
+static inline u32 get_txbuffer_desc_addr_low(__le32 *__pdesc, u8 __offset)
 {
-	return le32_to_cpu(*((__le32 *)(__pdesc + 16 * __offset + 4)));
+	return le32_to_cpu(*((__pdesc + 4 * __offset + 1)));
 }
 
-static inline u32 get_txbuffer_desc_addr_high(u8 *pbd, u32 off, bool dma64)
+static inline u32 get_txbuffer_desc_addr_high(__le32 *pbd, u32 off, bool dma64)
 {
 	if (dma64)
-		return le32_to_cpu(*((__le32 *)(pbd + 16 * off + 8)));
+		return le32_to_cpu(*((pbd + 4 * off + 2)));
 	return 0;
 }
 
 /* Dword 0 */
-static inline void set_tx_buff_desc_len_0(u8 *__pdesc, u32 __val)
+static inline void set_tx_buff_desc_len_0(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)__pdesc, __val, GENMASK(13, 0));
+	le32p_replace_bits(__pdesc, __val, GENMASK(13, 0));
 }
 
-static inline void set_tx_buff_desc_psb(u8 *__pdesc, u32 __val)
+static inline void set_tx_buff_desc_psb(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)__pdesc, __val, GENMASK(30, 16));
+	le32p_replace_bits(__pdesc, __val, GENMASK(30, 16));
 }
 
-static inline void set_tx_buff_desc_own(u8 *__pdesc, u32 __val)
+static inline void set_tx_buff_desc_own(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)__pdesc, __val, BIT(31));
+	le32p_replace_bits(__pdesc, __val, BIT(31));
 }
 
 /* Dword 1 */
-static inline void set_tx_buff_desc_addr_low_0(u8 *__pdesc, u32 __val)
+static inline void set_tx_buff_desc_addr_low_0(__le32 *__pdesc, u32 __val)
 {
-	*(__le32 *)(__pdesc + 4) = cpu_to_le32(__val);
+	*(__pdesc + 1) = cpu_to_le32(__val);
 }
 
 /* Dword 2 */
-static inline void set_tx_buff_desc_addr_high_0(u8 *pdesc, u32 val, bool dma64)
+static inline void set_tx_buff_desc_addr_high_0(__le32 *pdesc, u32 val,
+						bool dma64)
 {
 	if (dma64)
-		*(__le32 *)(pdesc + 8) = cpu_to_le32(val);
+		*(pdesc + 2) = cpu_to_le32(val);
 	else
-		*(__le32 *)(pdesc + 8) = 0;
+		*(pdesc + 2) = 0;
 }
 
 /* RX buffer  */
 
 /* DWORD 0 */
-static inline void set_rx_buffer_desc_data_length(u8 *__status, u32 __val)
+static inline void set_rx_buffer_desc_data_length(__le32 *__status, u32 __val)
 {
-	le32p_replace_bits((__le32 *)__status, __val, GENMASK(13, 0));
+	le32p_replace_bits(__status, __val, GENMASK(13, 0));
 }
 
-static inline void set_rx_buffer_desc_ls(u8 *__status, u32 __val)
+static inline void set_rx_buffer_desc_ls(__le32 *__status, u32 __val)
 {
-	le32p_replace_bits((__le32 *)__status, __val, BIT(15));
+	le32p_replace_bits(__status, __val, BIT(15));
 }
 
-static inline void set_rx_buffer_desc_fs(u8 *__status, u32 __val)
+static inline void set_rx_buffer_desc_fs(__le32 *__status, u32 __val)
 {
-	le32p_replace_bits((__le32 *)__status, __val, BIT(16));
+	le32p_replace_bits(__status, __val, BIT(16));
 }
 
-static inline void set_rx_buffer_desc_total_length(u8 *__status, u32 __val)
+static inline void set_rx_buffer_desc_total_length(__le32 *__status, u32 __val)
 {
-	le32p_replace_bits((__le32 *)__status, __val, GENMASK(30, 16));
+	le32p_replace_bits(__status, __val, GENMASK(30, 16));
 }
 
-static inline int get_rx_buffer_desc_ls(u8 *__status)
+static inline int get_rx_buffer_desc_ls(__le32 *__status)
 {
-	return le32_get_bits(*((__le32 *)__status), BIT(15));
+	return le32_get_bits(*(__status), BIT(15));
 }
 
-static inline int get_rx_buffer_desc_fs(u8 *__status)
+static inline int get_rx_buffer_desc_fs(__le32 *__status)
 {
-	return le32_get_bits(*((__le32 *)__status), BIT(16));
+	return le32_get_bits(*(__status), BIT(16));
 }
 
-static inline int get_rx_buffer_desc_total_length(u8 *__status)
+static inline int get_rx_buffer_desc_total_length(__le32 *__status)
 {
-	return le32_get_bits(*((__le32 *)__status), GENMASK(30, 16));
+	return le32_get_bits(*(__status), GENMASK(30, 16));
 }
 
 /* DWORD 1 */
-static inline void set_rx_buffer_physical_low(u8 *__status, u32 __val)
+static inline void set_rx_buffer_physical_low(__le32 *__status, u32 __val)
 {
-	*(__le32 *)(__status + 4) = cpu_to_le32(__val);
+	*(__status + 1) = cpu_to_le32(__val);
 }
 
 /* DWORD 2 */
-static inline void set_rx_buffer_physical_high(u8 *__rx_status_desc, u32 __val,
-					       bool dma64)
+static inline void set_rx_buffer_physical_high(__le32 *__rx_status_desc,
+					       u32 __val, bool dma64)
 {
 	if (dma64)
-		*(__le32 *)(__rx_status_desc + 8) = cpu_to_le32(__val);
+		*(__rx_status_desc + 2) = cpu_to_le32(__val);
 	else
-		*(__le32 *)(__rx_status_desc + 8) = 0;
+		*(__rx_status_desc + 2) = 0;
 }
 
-static inline int get_rx_desc_pkt_len(u8 *__pdesc)
+static inline int get_rx_desc_pkt_len(__le32 *__pdesc)
 {
-	return le32_get_bits(*(__le32 *)__pdesc, GENMASK(13, 0));
+	return le32_get_bits(*__pdesc, GENMASK(13, 0));
 }
 
-static inline int get_rx_desc_crc32(u8 *__pdesc)
+static inline int get_rx_desc_crc32(__le32 *__pdesc)
 {
-	return le32_get_bits(*(__le32 *)__pdesc, BIT(14));
+	return le32_get_bits(*__pdesc, BIT(14));
 }
 
-static inline int get_rx_desc_icv(u8 *__pdesc)
+static inline int get_rx_desc_icv(__le32 *__pdesc)
 {
-	return le32_get_bits(*(__le32 *)__pdesc, BIT(15));
+	return le32_get_bits(*__pdesc, BIT(15));
 }
 
-static inline int get_rx_desc_drv_info_size(u8 *__pdesc)
+static inline int get_rx_desc_drv_info_size(__le32 *__pdesc)
 {
-	return le32_get_bits(*(__le32 *)__pdesc, GENMASK(19, 16));
+	return le32_get_bits(*__pdesc, GENMASK(19, 16));
 }
 
-static inline int get_rx_desc_shift(u8 *__pdesc)
+static inline int get_rx_desc_shift(__le32 *__pdesc)
 {
-	return le32_get_bits(*(__le32 *)__pdesc, GENMASK(25, 24));
+	return le32_get_bits(*__pdesc, GENMASK(25, 24));
 }
 
-static inline int get_rx_desc_physt(u8 *__pdesc)
+static inline int get_rx_desc_physt(__le32 *__pdesc)
 {
-	return le32_get_bits(*(__le32 *)__pdesc, BIT(26));
+	return le32_get_bits(*__pdesc, BIT(26));
 }
 
-static inline int get_rx_desc_swdec(u8 *__pdesc)
+static inline int get_rx_desc_swdec(__le32 *__pdesc)
 {
-	return le32_get_bits(*(__le32 *)__pdesc, BIT(27));
+	return le32_get_bits(*__pdesc, BIT(27));
 }
 
-static inline int get_rx_desc_own(u8 *__pdesc)
+static inline int get_rx_desc_own(__le32 *__pdesc)
 {
-	return le32_get_bits(*(__le32 *)__pdesc, BIT(31));
+	return le32_get_bits(*__pdesc, BIT(31));
 }
 
-static inline void set_rx_desc_eor(u8 *__pdesc, u32 __val)
+static inline void set_rx_desc_eor(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)__pdesc, __val, BIT(30));
+	le32p_replace_bits(__pdesc, __val, BIT(30));
 }
 
-static inline int get_rx_desc_macid(u8 *__pdesc)
+static inline int get_rx_desc_macid(__le32 *__pdesc)
 {
-	return le32_get_bits(*(__le32 *)(__pdesc + 4), GENMASK(6, 0));
+	return le32_get_bits(*(__pdesc + 1), GENMASK(6, 0));
 }
 
-static inline int get_rx_desc_paggr(u8 *__pdesc)
+static inline int get_rx_desc_paggr(__le32 *__pdesc)
 {
-	return le32_get_bits(*(__le32 *)(__pdesc + 4), BIT(15));
+	return le32_get_bits(*(__pdesc + 1), BIT(15));
 }
 
-static inline int get_rx_status_desc_rpt_sel(u8 *__pdesc)
+static inline int get_rx_status_desc_rpt_sel(__le32 *__pdesc)
 {
-	return le32_get_bits(*(__le32 *)(__pdesc + 8), BIT(28));
+	return le32_get_bits(*(__pdesc + 2), BIT(28));
 }
 
-static inline int get_rx_desc_rxmcs(u8 *__pdesc)
+static inline int get_rx_desc_rxmcs(__le32 *__pdesc)
 {
-	return le32_get_bits(*(__le32 *)(__pdesc + 12), GENMASK(6, 0));
+	return le32_get_bits(*(__pdesc + 3), GENMASK(6, 0));
 }
 
-static inline int get_rx_status_desc_pattern_match(u8 *__pdesc)
+static inline int get_rx_status_desc_pattern_match(__le32 *__pdesc)
 {
-	return le32_get_bits(*(__le32 *)(__pdesc + 12), BIT(29));
+	return le32_get_bits(*(__pdesc + 3), BIT(29));
 }
 
-static inline int get_rx_status_desc_unicast_match(u8 *__pdesc)
+static inline int get_rx_status_desc_unicast_match(__le32 *__pdesc)
 {
-	return le32_get_bits(*(__le32 *)(__pdesc + 12), BIT(30));
+	return le32_get_bits(*(__pdesc + 3), BIT(30));
 }
 
-static inline int get_rx_status_desc_magic_match(u8 *__pdesc)
+static inline int get_rx_status_desc_magic_match(__le32 *__pdesc)
 {
-	return le32_get_bits(*(__le32 *)(__pdesc + 12), BIT(31));
+	return le32_get_bits(*(__pdesc + 3), BIT(31));
 }
 
-static inline u32 get_rx_desc_tsfl(u8 *__pdesc)
+static inline u32 get_rx_desc_tsfl(__le32 *__pdesc)
 {
-	return le32_to_cpu(*((__le32 *)(__pdesc + 20)));
+	return le32_to_cpu(*((__pdesc + 5)));
 }
 
-static inline u32 get_rx_desc_buff_addr(u8 *__pdesc)
+static inline u32 get_rx_desc_buff_addr(__le32 *__pdesc)
 {
-	return le32_to_cpu(*((__le32 *)(__pdesc + 24)));
+	return le32_to_cpu(*((__pdesc + 6)));
 }
 
 /* TX report 2 format in Rx desc*/
 
-static inline u32 get_rx_rpt2_desc_macid_valid_1(u8 *__status)
+static inline u32 get_rx_rpt2_desc_macid_valid_1(__le32 *__status)
 {
-	return le32_to_cpu(*((__le32 *)(__status + 16)));
+	return le32_to_cpu(*((__status + 4)));
 }
 
-static inline u32 get_rx_rpt2_desc_macid_valid_2(u8 *__status)
+static inline u32 get_rx_rpt2_desc_macid_valid_2(__le32 *__status)
 {
-	return le32_to_cpu(*((__le32 *)(__status + 20)));
+	return le32_to_cpu(*((__status + 5)));
 }
 
-#define CLEAR_PCI_TX_DESC_CONTENT(__pdesc, _size)		\
-do {								\
-	if (_size > TX_DESC_NEXT_DESC_OFFSET)			\
-		memset(__pdesc, 0, TX_DESC_NEXT_DESC_OFFSET);	\
-	else							\
-		memset(__pdesc, 0, _size);			\
-} while (0)
+static inline void clear_pci_tx_desc_content(__le32 *__pdesc, int _size)
+{
+	if (_size > TX_DESC_NEXT_DESC_OFFSET)
+		memset(__pdesc, 0, TX_DESC_NEXT_DESC_OFFSET);
+	else
+		memset(__pdesc, 0, _size);
+}
 
 #define RTL92EE_RX_HAL_IS_CCK_RATE(rxmcs)\
 	(rxmcs == DESC_RATE1M ||\
-- 
2.16.4

