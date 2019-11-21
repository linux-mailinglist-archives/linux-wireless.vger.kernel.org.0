Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D28C105C31
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Nov 2019 22:44:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbfKUVo1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 Nov 2019 16:44:27 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:38169 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbfKUVo0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 Nov 2019 16:44:26 -0500
Received: by mail-ot1-f68.google.com with SMTP id z25so4370160oti.5
        for <linux-wireless@vger.kernel.org>; Thu, 21 Nov 2019 13:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jmcOnl4dE1zgbI4NVhOZtwF6Crlq4Qiw8phlvodZpSM=;
        b=GSI50kU1y9Ox2/cLqmT7LfbbJitIBfbtNm20MmUUIYstPbAP+h1w7ihDMY/ClhkKwB
         Md5mO2vstTaqdgbNxHEX+RchlNdTDfA9IWLxDwhtH+2CaCqBobatB77n+rbLrXSyFLs0
         Kn6XR1E3+qpV98vzgKT21tclb3i7CbIjbrymUlqVkblv8S6DnkHMrAKe1lC3rJStlZlq
         pp/MGuya9CzgioIgLM19H0j/FIaixiCyxorNumHIBdLCiQ27FJ/WHxBlhZW7NDdzv/Ow
         dWF6ivJkr6ZJ7x4IWRJUzMCulFB6VKfO7neRFqBr31aKyx/XUQ7E+B96oaJc1J6HDU0l
         vlQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=jmcOnl4dE1zgbI4NVhOZtwF6Crlq4Qiw8phlvodZpSM=;
        b=TYBFXWuUHIrWQOVKHaF8hKC9XZX97a1Ev9XxGl8CLpFzcBh7+Wwxo2irs7fQ9Stew6
         tFWRNyZGQMYZZmon3ZItVhtw5rAHJ/IuBBCjpZ/JStOfCJ+VPydlNnGy+hekofZXjdkU
         2bonwI4ciVYOEAB1g2P4wlVGPiO1hsvL8DFtbDvxGd+A2HEL/UFdz1cnJsSxwGMziLHT
         lTnwdeWs/k47FK1RAmgr9Ib4bL4YIXfr2EWIW0GkxCB2weN3qDIBO7nQ/rL3skxjkfrA
         27pCOpfaraehqhtLeqZnvWxGWkRphYeRrCxVZyKnConAAsqUb9T6pEdo1joVEHkD4wBk
         sJjA==
X-Gm-Message-State: APjAAAWM5D/Rg5MTcynzdw8/sYYrWhhps1p5cDH0e/g6FVLWJ+KeeYsZ
        m+WpCqtwecUjxLW2s3xMTNI=
X-Google-Smtp-Source: APXvYqw0VkkaxDvql212hSYgletVl28cLPUxMD+9Jpx4lx9IaVLMFITRpTVG7lOy4wvkvpNhiQO6Qw==
X-Received: by 2002:a9d:3d76:: with SMTP id a109mr8521736otc.233.1574372664226;
        Thu, 21 Nov 2019 13:44:24 -0800 (PST)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id x82sm1333854oix.29.2019.11.21.13.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 13:44:23 -0800 (PST)
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, pkshih@realtek.com,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH 4/4] rtlwifi: rtl8192de: Convert inline routines to little-endian words
Date:   Thu, 21 Nov 2019 15:44:17 -0600
Message-Id: <20191121214417.29676-5-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191121214417.29676-1-Larry.Finger@lwfinger.net>
References: <20191121214417.29676-1-Larry.Finger@lwfinger.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
 .../wireless/realtek/rtlwifi/rtl8192de/trx.c  |  25 +-
 .../wireless/realtek/rtlwifi/rtl8192de/trx.h  | 284 +++++++++---------
 2 files changed, 159 insertions(+), 150 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c
index 18361f22337d..bb64612654b9 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c
@@ -438,8 +438,9 @@ static void _rtl92de_translate_rx_signal_stuff(struct ieee80211_hw *hw,
 
 bool rtl92de_rx_query_desc(struct ieee80211_hw *hw,	struct rtl_stats *stats,
 		struct ieee80211_rx_status *rx_status,
-		u8 *pdesc, struct sk_buff *skb)
+		u8 *pdesc8, struct sk_buff *skb)
 {
+	__le32 *pdesc = (__le32 *)pdesc8;
 	struct rx_fwinfo_92d *p_drvinfo;
 	u32 phystatus = get_rx_desc_physt(pdesc);
 
@@ -489,8 +490,10 @@ bool rtl92de_rx_query_desc(struct ieee80211_hw *hw,	struct rtl_stats *stats,
 }
 
 static void _rtl92de_insert_emcontent(struct rtl_tcb_desc *ptcb_desc,
-				      u8 *virtualaddress)
+				      u8 *virtualaddress8)
 {
+	__le32 *virtualaddress = (__le32 *)virtualaddress8;
+
 	memset(virtualaddress, 0, 8);
 
 	set_earlymode_pktnum(virtualaddress, ptcb_desc->empkt_num);
@@ -503,7 +506,7 @@ static void _rtl92de_insert_emcontent(struct rtl_tcb_desc *ptcb_desc,
 }
 
 void rtl92de_tx_fill_desc(struct ieee80211_hw *hw,
-			  struct ieee80211_hdr *hdr, u8 *pdesc_tx,
+			  struct ieee80211_hdr *hdr, u8 *pdesc8,
 			  u8 *pbd_desc_tx, struct ieee80211_tx_info *info,
 			  struct ieee80211_sta *sta,
 			  struct sk_buff *skb,
@@ -514,7 +517,7 @@ void rtl92de_tx_fill_desc(struct ieee80211_hw *hw,
 	struct rtl_pci *rtlpci = rtl_pcidev(rtl_pcipriv(hw));
 	struct rtl_hal *rtlhal = rtl_hal(rtlpriv);
 	struct rtl_ps_ctl *ppsc = rtl_psc(rtl_priv(hw));
-	u8 *pdesc = pdesc_tx;
+	__le32 *pdesc = (__le32 *)pdesc8;
 	u16 seq_number;
 	__le16 fc = hdr->frame_control;
 	unsigned int buf_len = 0;
@@ -549,7 +552,7 @@ void rtl92de_tx_fill_desc(struct ieee80211_hw *hw,
 			 "DMA mapping error\n");
 		return;
 	}
-	CLEAR_PCI_TX_DESC_CONTENT(pdesc, sizeof(struct tx_desc_92d));
+	clear_pci_tx_desc_content(pdesc, sizeof(struct tx_desc_92d));
 	if (ieee80211_is_nullfunc(fc) || ieee80211_is_ctl(fc)) {
 		firstseg = true;
 		lastseg = true;
@@ -690,7 +693,7 @@ void rtl92de_tx_fill_desc(struct ieee80211_hw *hw,
 }
 
 void rtl92de_tx_fill_cmddesc(struct ieee80211_hw *hw,
-			     u8 *pdesc, bool firstseg,
+			     u8 *pdesc8, bool firstseg,
 			     bool lastseg, struct sk_buff *skb)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
@@ -702,13 +705,14 @@ void rtl92de_tx_fill_cmddesc(struct ieee80211_hw *hw,
 		    skb->data, skb->len, PCI_DMA_TODEVICE);
 	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)(skb->data);
 	__le16 fc = hdr->frame_control;
+	__le32 *pdesc = (__le32 *)pdesc8;
 
 	if (pci_dma_mapping_error(rtlpci->pdev, mapping)) {
 		RT_TRACE(rtlpriv, COMP_SEND, DBG_TRACE,
 			 "DMA mapping error\n");
 		return;
 	}
-	CLEAR_PCI_TX_DESC_CONTENT(pdesc, TX_DESC_SIZE);
+	clear_pci_tx_desc_content(pdesc, TX_DESC_SIZE);
 	if (firstseg)
 		set_tx_desc_offset(pdesc, USB_HWDESC_HEADER_LEN);
 	/* 5G have no CCK rate
@@ -746,9 +750,11 @@ void rtl92de_tx_fill_cmddesc(struct ieee80211_hw *hw,
 	set_tx_desc_own(pdesc, 1);
 }
 
-void rtl92de_set_desc(struct ieee80211_hw *hw, u8 *pdesc, bool istx,
+void rtl92de_set_desc(struct ieee80211_hw *hw, u8 *pdesc8, bool istx,
 		      u8 desc_name, u8 *val)
 {
+	__le32  *pdesc = (__le32 *)pdesc8;
+
 	if (istx) {
 		switch (desc_name) {
 		case HW_DESC_OWN:
@@ -787,8 +793,9 @@ void rtl92de_set_desc(struct ieee80211_hw *hw, u8 *pdesc, bool istx,
 }
 
 u64 rtl92de_get_desc(struct ieee80211_hw *hw,
-		     u8 *p_desc, bool istx, u8 desc_name)
+		     u8 *p_desc8, bool istx, u8 desc_name)
 {
+	__le32 *p_desc = (__le32 *)p_desc8;
 	u32 ret = 0;
 
 	if (istx) {
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h
index fe81196e46b7..80bf73fe37d1 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h
@@ -16,354 +16,356 @@
 
 /* macros to read/write various fields in RX or TX descriptors */
 
-static inline void set_tx_desc_pkt_size(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_pkt_size(u32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)__pdesc, __val, GENMASK(15, 0));
+	le32p_replace_bits(__pdesc, __val, GENMASK(15, 0));
 }
 
-static inline void set_tx_desc_offset(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_offset(u32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)__pdesc, __val, GENMASK(23, 16));
+	le32p_replace_bits(__pdesc, __val, GENMASK(23, 16));
 }
 
-static inline void set_tx_desc_htc(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_htc(u32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)__pdesc, __val, BIT(25));
+	le32p_replace_bits(__pdesc, __val, BIT(25));
 }
 
-static inline void set_tx_desc_last_seg(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_last_seg(u32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)__pdesc, __val, BIT(26));
+	le32p_replace_bits(__pdesc, __val, BIT(26));
 }
 
-static inline void set_tx_desc_first_seg(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_first_seg(u32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)__pdesc, __val, BIT(27));
+	le32p_replace_bits(__pdesc, __val, BIT(27));
 }
 
-static inline void set_tx_desc_linip(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_linip(u32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)__pdesc, __val, BIT(28));
+	le32p_replace_bits(__pdesc, __val, BIT(28));
 }
 
-static inline void set_tx_desc_own(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_own(u32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)__pdesc, __val, BIT(31));
+	le32p_replace_bits(__pdesc, __val, BIT(31));
 }
 
-static inline u32 get_tx_desc_own(u8 *__pdesc)
+static inline u32 get_tx_desc_own(u32 *__pdesc)
 {
-	return le32_get_bits(*(__le32 *)__pdesc, BIT(31));
+	return le32_get_bits(*__pdesc, BIT(31));
 }
 
-static inline void set_tx_desc_macid(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_macid(u32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 4), __val, GENMASK(4, 0));
+	le32p_replace_bits((__pdesc + 1), __val, GENMASK(4, 0));
 }
 
-static inline void set_tx_desc_agg_enable(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_agg_enable(u32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 4), __val, BIT(5));
+	le32p_replace_bits((__pdesc + 1), __val, BIT(5));
 }
 
-static inline void set_tx_desc_rdg_enable(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_rdg_enable(u32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 4), __val, BIT(7));
+	le32p_replace_bits((__pdesc + 1), __val, BIT(7));
 }
 
-static inline void set_tx_desc_queue_sel(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_queue_sel(u32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 4), __val, GENMASK(12, 8));
+	le32p_replace_bits((__pdesc + 1), __val, GENMASK(12, 8));
 }
 
-static inline void set_tx_desc_rate_id(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_rate_id(u32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 4), __val, GENMASK(19, 16));
+	le32p_replace_bits((__pdesc + 1), __val, GENMASK(19, 16));
 }
 
-static inline void set_tx_desc_sec_type(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_sec_type(u32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 4), __val, GENMASK(23, 22));
+	le32p_replace_bits((__pdesc + 1), __val, GENMASK(23, 22));
 }
 
-static inline void set_tx_desc_pkt_offset(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_pkt_offset(u32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 4), __val, GENMASK(30, 26));
+	le32p_replace_bits((__pdesc + 1), __val, GENMASK(30, 26));
 }
 
-static inline void set_tx_desc_more_frag(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_more_frag(u32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 8), __val, BIT(17));
+	le32p_replace_bits((__pdesc + 2), __val, BIT(17));
 }
 
-static inline void set_tx_desc_ampdu_density(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_ampdu_density(u32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 8), __val, GENMASK(22, 20));
+	le32p_replace_bits((__pdesc + 2), __val, GENMASK(22, 20));
 }
 
-static inline void set_tx_desc_seq(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_seq(u32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 12), __val, GENMASK(27, 16));
+	le32p_replace_bits((__pdesc + 3), __val, GENMASK(27, 16));
 }
 
-static inline void set_tx_desc_pkt_id(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_pkt_id(u32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 12), __val, GENMASK(31, 28));
+	le32p_replace_bits((__pdesc + 3), __val, GENMASK(31, 28));
 }
 
-static inline void set_tx_desc_rts_rate(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_rts_rate(u32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, GENMASK(4, 0));
+	le32p_replace_bits((__pdesc + 4), __val, GENMASK(4, 0));
 }
 
-static inline void set_tx_desc_qos(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_qos(u32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, BIT(6));
+	le32p_replace_bits((__pdesc + 4), __val, BIT(6));
 }
 
-static inline void set_tx_desc_hwseq_en(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_hwseq_en(u32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, BIT(7));
+	le32p_replace_bits((__pdesc + 4), __val, BIT(7));
 }
 
-static inline void set_tx_desc_use_rate(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_use_rate(u32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, BIT(8));
+	le32p_replace_bits((__pdesc + 4), __val, BIT(8));
 }
 
-static inline void set_tx_desc_disable_fb(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_disable_fb(u32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, BIT(10));
+	le32p_replace_bits((__pdesc + 4), __val, BIT(10));
 }
 
-static inline void set_tx_desc_cts2self(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_cts2self(u32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, BIT(11));
+	le32p_replace_bits((__pdesc + 4), __val, BIT(11));
 }
 
-static inline void set_tx_desc_rts_enable(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_rts_enable(u32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, BIT(12));
+	le32p_replace_bits((__pdesc + 4), __val, BIT(12));
 }
 
-static inline void set_tx_desc_hw_rts_enable(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_hw_rts_enable(u32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, BIT(13));
+	le32p_replace_bits((__pdesc + 4), __val, BIT(13));
 }
 
-static inline void set_tx_desc_tx_sub_carrier(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_tx_sub_carrier(u32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, GENMASK(21, 20));
+	le32p_replace_bits((__pdesc + 4), __val, GENMASK(21, 20));
 }
 
-static inline void set_tx_desc_data_bw(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_data_bw(u32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, BIT(25));
+	le32p_replace_bits((__pdesc + 4), __val, BIT(25));
 }
 
-static inline void set_tx_desc_rts_short(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_rts_short(u32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, BIT(26));
+	le32p_replace_bits((__pdesc + 4), __val, BIT(26));
 }
 
-static inline void set_tx_desc_rts_bw(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_rts_bw(u32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, BIT(27));
+	le32p_replace_bits((__pdesc + 4), __val, BIT(27));
 }
 
-static inline void set_tx_desc_rts_sc(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_rts_sc(u32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, GENMASK(29, 28));
+	le32p_replace_bits((__pdesc + 4), __val, GENMASK(29, 28));
 }
 
-static inline void set_tx_desc_rts_stbc(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_rts_stbc(u32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, GENMASK(31, 30));
+	le32p_replace_bits((__pdesc + 4), __val, GENMASK(31, 30));
 }
 
-static inline void set_tx_desc_tx_rate(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_tx_rate(u32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 20), __val, GENMASK(5, 0));
+	le32p_replace_bits((__pdesc + 5), __val, GENMASK(5, 0));
 }
 
-static inline void set_tx_desc_data_shortgi(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_data_shortgi(u32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 20), __val, BIT(6));
+	le32p_replace_bits((__pdesc + 5), __val, BIT(6));
 }
 
-static inline void set_tx_desc_data_rate_fb_limit(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_data_rate_fb_limit(u32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 20), __val, GENMASK(12, 8));
+	le32p_replace_bits((__pdesc + 5), __val, GENMASK(12, 8));
 }
 
-static inline void set_tx_desc_rts_rate_fb_limit(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_rts_rate_fb_limit(u32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 20), __val, GENMASK(16, 13));
+	le32p_replace_bits((__pdesc + 5), __val, GENMASK(16, 13));
 }
 
-static inline void set_tx_desc_max_agg_num(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_max_agg_num(u32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 24), __val, GENMASK(15, 11));
+	le32p_replace_bits((__pdesc + 6), __val, GENMASK(15, 11));
 }
 
-static inline void set_tx_desc_tx_buffer_size(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_tx_buffer_size(u32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 28), __val, GENMASK(15, 0));
+	le32p_replace_bits((__pdesc + 7), __val, GENMASK(15, 0));
 }
 
-static inline void set_tx_desc_tx_buffer_address(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_tx_buffer_address(u32 *__pdesc, u32 __val)
 {
-	*(__le32 *)(__pdesc + 32) = cpu_to_le32(__val);
+	*(__pdesc + 8) = cpu_to_le32(__val);
 }
 
-static inline u32 get_tx_desc_tx_buffer_address(u8 *__pdesc)
+static inline u32 get_tx_desc_tx_buffer_address(u32 *__pdesc)
 {
-	return le32_to_cpu(*(__le32 *)(__pdesc + 32));
+	return le32_to_cpu(*(__pdesc + 8));
 }
 
-static inline void set_tx_desc_next_desc_address(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_next_desc_address(u32 *__pdesc, u32 __val)
 {
-	*(__le32 *)(__pdesc + 40) = cpu_to_le32(__val);
+	*(__pdesc + 10) = cpu_to_le32(__val);
 }
 
-static inline u32 get_rx_desc_pkt_len(u8 *__pdesc)
+static inline u32 get_rx_desc_pkt_len(u32 *__pdesc)
 {
-	return le32_get_bits(*(__le32 *)__pdesc, GENMASK(13, 0));
+	return le32_get_bits(*__pdesc, GENMASK(13, 0));
 }
 
-static inline u32 get_rx_desc_crc32(u8 *__pdesc)
+static inline u32 get_rx_desc_crc32(u32 *__pdesc)
 {
-	return le32_get_bits(*(__le32 *)__pdesc, BIT(14));
+	return le32_get_bits(*__pdesc, BIT(14));
 }
 
-static inline u32 get_rx_desc_icv(u8 *__pdesc)
+static inline u32 get_rx_desc_icv(u32 *__pdesc)
 {
-	return le32_get_bits(*(__le32 *)__pdesc, BIT(15));
+	return le32_get_bits(*__pdesc, BIT(15));
 }
 
-static inline u32 get_rx_desc_drv_info_size(u8 *__pdesc)
+static inline u32 get_rx_desc_drv_info_size(u32 *__pdesc)
 {
-	return le32_get_bits(*(__le32 *)__pdesc, GENMASK(19, 16));
+	return le32_get_bits(*__pdesc, GENMASK(19, 16));
 }
 
-static inline u32 get_rx_desc_shift(u8 *__pdesc)
+static inline u32 get_rx_desc_shift(u32 *__pdesc)
 {
-	return le32_get_bits(*(__le32 *)__pdesc, GENMASK(25, 24));
+	return le32_get_bits(*__pdesc, GENMASK(25, 24));
 }
 
-static inline u32 get_rx_desc_physt(u8 *__pdesc)
+static inline u32 get_rx_desc_physt(u32 *__pdesc)
 {
-	return le32_get_bits(*(__le32 *)__pdesc, BIT(26));
+	return le32_get_bits(*__pdesc, BIT(26));
 }
 
-static inline u32 get_rx_desc_swdec(u8 *__pdesc)
+static inline u32 get_rx_desc_swdec(u32 *__pdesc)
 {
-	return le32_get_bits(*(__le32 *)__pdesc, BIT(27));
+	return le32_get_bits(*__pdesc, BIT(27));
 }
 
-static inline u32 get_rx_desc_own(u8 *__pdesc)
+static inline u32 get_rx_desc_own(u32 *__pdesc)
 {
-	return le32_get_bits(*(__le32 *)__pdesc, BIT(31));
+	return le32_get_bits(*__pdesc, BIT(31));
 }
 
-static inline void set_rx_desc_pkt_len(u8 *__pdesc, u32 __val)
+static inline void set_rx_desc_pkt_len(u32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)__pdesc, __val, GENMASK(13, 0));
+	le32p_replace_bits(__pdesc, __val, GENMASK(13, 0));
 }
 
-static inline void set_rx_desc_eor(u8 *__pdesc, u32 __val)
+static inline void set_rx_desc_eor(u32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)__pdesc, __val, BIT(30));
+	le32p_replace_bits(__pdesc, __val, BIT(30));
 }
 
-static inline void set_rx_desc_own(u8 *__pdesc, u32 __val)
+static inline void set_rx_desc_own(u32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)__pdesc, __val, BIT(31));
+	le32p_replace_bits(__pdesc, __val, BIT(31));
 }
 
-static inline u32 get_rx_desc_paggr(u8 *__pdesc)
+static inline u32 get_rx_desc_paggr(u32 *__pdesc)
 {
-	return le32_get_bits(*(__le32 *)(__pdesc + 4), BIT(14));
+	return le32_get_bits(*(__pdesc + 1), BIT(14));
 }
 
-static inline u32 get_rx_desc_faggr(u8 *__pdesc)
+static inline u32 get_rx_desc_faggr(u32 *__pdesc)
 {
-	return le32_get_bits(*(__le32 *)(__pdesc + 4), BIT(15));
+	return le32_get_bits(*(__pdesc + 1), BIT(15));
 }
 
-static inline u32 get_rx_desc_rxmcs(u8 *__pdesc)
+static inline u32 get_rx_desc_rxmcs(u32 *__pdesc)
 {
-	return le32_get_bits(*(__le32 *)(__pdesc + 12), GENMASK(5, 0));
+	return le32_get_bits(*(__pdesc + 3), GENMASK(5, 0));
 }
 
-static inline u32 get_rx_desc_rxht(u8 *__pdesc)
+static inline u32 get_rx_desc_rxht(u32 *__pdesc)
 {
-	return le32_get_bits(*(__le32 *)(__pdesc + 12), BIT(6));
+	return le32_get_bits(*(__pdesc + 3), BIT(6));
 }
 
-static inline u32 get_rx_desc_splcp(u8 *__pdesc)
+static inline u32 get_rx_desc_splcp(u32 *__pdesc)
 {
-	return le32_get_bits(*(__le32 *)(__pdesc + 12), BIT(8));
+	return le32_get_bits(*(__pdesc + 3), BIT(8));
 }
 
-static inline u32 get_rx_desc_bw(u8 *__pdesc)
+static inline u32 get_rx_desc_bw(u32 *__pdesc)
 {
-	return le32_get_bits(*(__le32 *)(__pdesc + 12), BIT(9));
+	return le32_get_bits(*(__pdesc + 3), BIT(9));
 }
 
-static inline u32 get_rx_desc_tsfl(u8 *__pdesc)
+static inline u32 get_rx_desc_tsfl(u32 *__pdesc)
 {
-	return le32_to_cpu(*(__le32 *)(__pdesc + 20));
+	return le32_to_cpu(*(__pdesc + 5));
 }
 
-static inline u32 get_rx_desc_buff_addr(u8 *__pdesc)
+static inline u32 get_rx_desc_buff_addr(u32 *__pdesc)
 {
-	return le32_to_cpu(*(__le32 *)(__pdesc + 24));
+	return le32_to_cpu(*(__pdesc + 6));
 }
 
-static inline void set_rx_desc_buff_addr(u8 *__pdesc, u32 __val)
+static inline void set_rx_desc_buff_addr(u32 *__pdesc, u32 __val)
 {
-	*(__le32 *)(__pdesc + 24) = cpu_to_le32(__val);
+	*(__pdesc + 6) = cpu_to_le32(__val);
 }
 
-#define CLEAR_PCI_TX_DESC_CONTENT(__pdesc, _size)	\
-	memset((void *)__pdesc, 0,			\
-	       min_t(size_t, _size, TX_DESC_NEXT_DESC_OFFSET))
+static inline void clear_pci_tx_desc_content(__le32 *__pdesc, u32 _size)
+{
+	memset((void *)__pdesc, 0,
+	       min_t(size_t, _size, TX_DESC_NEXT_DESC_OFFSET));
+}
 
 /* For 92D early mode */
-static inline void set_earlymode_pktnum(u8 *__paddr, u32 __value)
+static inline void set_earlymode_pktnum(u32 *__paddr, u32 __value)
 {
-	le32p_replace_bits((__le32 *)__paddr, __value, GENMASK(2, 0));
+	le32p_replace_bits(__paddr, __value, GENMASK(2, 0));
 }
 
-static inline void set_earlymode_len0(u8 *__paddr, u32 __value)
+static inline void set_earlymode_len0(u32 *__paddr, u32 __value)
 {
-	le32p_replace_bits((__le32 *)__paddr, __value, GENMASK(15, 4));
+	le32p_replace_bits(__paddr, __value, GENMASK(15, 4));
 }
 
-static inline void set_earlymode_len1(u8 *__paddr, u32 __value)
+static inline void set_earlymode_len1(u32 *__paddr, u32 __value)
 {
-	le32p_replace_bits((__le32 *)__paddr, __value, GENMASK(27, 16));
+	le32p_replace_bits(__paddr, __value, GENMASK(27, 16));
 }
 
-static inline void set_earlymode_len2_1(u8 *__paddr, u32 __value)
+static inline void set_earlymode_len2_1(u32 *__paddr, u32 __value)
 {
-	le32p_replace_bits((__le32 *)__paddr, __value, GENMASK(31, 28));
+	le32p_replace_bits(__paddr, __value, GENMASK(31, 28));
 }
 
-static inline void set_earlymode_len2_2(u8 *__paddr, u32 __value)
+static inline void set_earlymode_len2_2(u32 *__paddr, u32 __value)
 {
-	le32p_replace_bits((__le32 *)(__paddr + 4), __value, GENMASK(7, 0));
+	le32p_replace_bits((__paddr + 1), __value, GENMASK(7, 0));
 }
 
-static inline void set_earlymode_len3(u8 *__paddr, u32 __value)
+static inline void set_earlymode_len3(u32 *__paddr, u32 __value)
 {
-	le32p_replace_bits((__le32 *)(__paddr + 4), __value, GENMASK(19, 8));
+	le32p_replace_bits((__paddr + 1), __value, GENMASK(19, 8));
 }
 
-static inline void set_earlymode_len4(u8 *__paddr, u32 __value)
+static inline void set_earlymode_len4(u32 *__paddr, u32 __value)
 {
-	le32p_replace_bits((__le32 *)(__paddr + 4), __value, GENMASK(31, 20));
+	le32p_replace_bits((__paddr + 1), __value, GENMASK(31, 20));
 }
 
 struct rx_fwinfo_92d {
-- 
2.23.0

