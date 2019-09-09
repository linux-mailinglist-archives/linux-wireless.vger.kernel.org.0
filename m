Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB17AD1BF
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2019 04:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732719AbfIICAK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 8 Sep 2019 22:00:10 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:38924 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732706AbfIICAK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 8 Sep 2019 22:00:10 -0400
Received: by mail-oi1-f194.google.com with SMTP id w144so9282143oia.6
        for <linux-wireless@vger.kernel.org>; Sun, 08 Sep 2019 19:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pLYLeJiMcBckqXhBsppGdnd1N7wOqytAzIYOpqynu5M=;
        b=K5GligBmozBZkpR8yGGY1C1n/9yPJV3LjuIeGBLCDVhqt5MQHTVggeA0oKp/2PV4uu
         UexGJd0hPYsX8HFOlXfp+NAcgtAhPFFAjaAXak6+xCJ8r3qlhZlkO4Tj+pHQSwBb0kAV
         WgOUF5Y0DfKJdnRsB3xA967tRmfqQje1S2xq4nnQU84fv8g/zQkV0MppgkbpWtsCY1z1
         ykv1sQ1Sz+TjAyXnsRsOVwlL9zQTJBFW4dz5CoFRNTBt27BtJIhkVuQ/w4rvxPGnn10U
         tXXtXBbM59V+Bk40M3XFxmWqTilEcCuA/cBonwzoJCTJsr6PGrS0/YaPF3k9cbeoPv90
         Edsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=pLYLeJiMcBckqXhBsppGdnd1N7wOqytAzIYOpqynu5M=;
        b=uXq9wNrx3gmk2UrhZG1QzyK6FQ4wkwG1h2nYlp6pXVyTYextHj/sSKoHs24g8xAfGX
         2zRQVnKHBEMoYX/ToGct0qYqe8FuimFlzGvBiTXFVLeoORc+KALAGJ15jBEHljYe8W1A
         yEDw7gG8vpaT1J83ArMZAqDGnB8+m6XRLYdxMGXMT2It9LDDzT4AmnZ4AAwYjyUsF8v2
         rjtffnmRIR9zOL5BkimaaMshDpavLCTCjxIVkRyS/mTkMZ3HkpD/KwEKnZM8gLSv0f7F
         iFRRPR/ZXepmV/O3dIhu3R615Fp8mQg586zaug+V0Ujuy/t+nYkuxIhHG8QqXThVclST
         wgtA==
X-Gm-Message-State: APjAAAUozMsr/T6SkC4ssngr3FYQm7dxpsMPMbGUC02muZU61vuxa80B
        4ymLSR9BqBbmZx+uHej+rtc=
X-Google-Smtp-Source: APXvYqwzEvv5JkyTplb2iqG+NaoFkJr+D1KFOzbdAJqMqn94AE5C36XeE/E+lBbMqus+sODaNgRaaw==
X-Received: by 2002:aca:5ec2:: with SMTP id s185mr6130976oib.128.1567994408289;
        Sun, 08 Sep 2019 19:00:08 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id k10sm1468420oij.16.2019.09.08.19.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2019 19:00:08 -0700 (PDT)
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, pkshih@realtek.com,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH v2 8/9] rtlwifi: rtl8723be: Convert inline routines to little-endian words
Date:   Sun,  8 Sep 2019 20:59:57 -0500
Message-Id: <20190909015958.29834-9-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190909015958.29834-1-Larry.Finger@lwfinger.net>
References: <20190909015958.29834-1-Larry.Finger@lwfinger.net>
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

The macro that cleared a descriptor has now been converted into an inline
routine.

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
---
V2 - Add a missing inline direective in rtl8723be/trx.h
---
 .../wireless/realtek/rtlwifi/rtl8723be/trx.c  |  34 +-
 .../wireless/realtek/rtlwifi/rtl8723be/trx.h  | 310 +++++++++---------
 2 files changed, 175 insertions(+), 169 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8723be/trx.c b/drivers/net/wireless/realtek/rtlwifi/rtl8723be/trx.c
index a1df90250036..b8081e196cdf 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8723be/trx.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8723be/trx.c
@@ -26,7 +26,8 @@ static u8 _rtl8723be_map_hwqueue_to_fwqueue(struct sk_buff *skb, u8 hw_queue)
 }
 
 static void _rtl8723be_query_rxphystatus(struct ieee80211_hw *hw,
-					 struct rtl_stats *pstatus, u8 *pdesc,
+					 struct rtl_stats *pstatus,
+					 __le32 *pdesc,
 					 struct rx_fwinfo_8723be *p_drvinfo,
 					 bool bpacket_match_bssid,
 					 bool bpacket_toself,
@@ -189,7 +190,7 @@ static void _rtl8723be_query_rxphystatus(struct ieee80211_hw *hw,
 static void _rtl8723be_translate_rx_signal_stuff(struct ieee80211_hw *hw,
 					struct sk_buff *skb,
 					struct rtl_stats *pstatus,
-					u8 *pdesc,
+					__le32 *pdesc,
 					struct rx_fwinfo_8723be *p_drvinfo)
 {
 	struct rtl_mac *mac = rtl_mac(rtl_priv(hw));
@@ -242,7 +243,7 @@ static void _rtl8723be_translate_rx_signal_stuff(struct ieee80211_hw *hw,
 }
 
 static void _rtl8723be_insert_emcontent(struct rtl_tcb_desc *ptcb_desc,
-					u8 *virtualaddress)
+					__le32 *virtualaddress)
 {
 	u32 dwtmp = 0;
 	memset(virtualaddress, 0, 8);
@@ -295,12 +296,13 @@ static void _rtl8723be_insert_emcontent(struct rtl_tcb_desc *ptcb_desc,
 bool rtl8723be_rx_query_desc(struct ieee80211_hw *hw,
 			     struct rtl_stats *status,
 			     struct ieee80211_rx_status *rx_status,
-			     u8 *pdesc, struct sk_buff *skb)
+			     u8 *pdesc8, struct sk_buff *skb)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	struct rx_fwinfo_8723be *p_drvinfo;
 	struct ieee80211_hdr *hdr;
 	u8 wake_match;
+	__le32 *pdesc = (__le32 *)pdesc8;
 	u32 phystatus = get_rx_desc_physt(pdesc);
 
 	status->length = (u16)get_rx_desc_pkt_len(pdesc);
@@ -400,7 +402,7 @@ bool rtl8723be_rx_query_desc(struct ieee80211_hw *hw,
 }
 
 void rtl8723be_tx_fill_desc(struct ieee80211_hw *hw,
-			    struct ieee80211_hdr *hdr, u8 *pdesc_tx,
+			    struct ieee80211_hdr *hdr, u8 *pdesc8,
 			    u8 *txbd, struct ieee80211_tx_info *info,
 			    struct ieee80211_sta *sta, struct sk_buff *skb,
 			    u8 hw_queue, struct rtl_tcb_desc *ptcb_desc)
@@ -410,7 +412,7 @@ void rtl8723be_tx_fill_desc(struct ieee80211_hw *hw,
 	struct rtl_pci *rtlpci = rtl_pcidev(rtl_pcipriv(hw));
 	struct rtl_hal *rtlhal = rtl_hal(rtlpriv);
 	struct rtlwifi_tx_info *tx_info = rtl_tx_skb_cb_info(skb);
-	u8 *pdesc = (u8 *)pdesc_tx;
+	__le32 *pdesc = (__le32 *)pdesc8;
 	u16 seq_number;
 	__le16 fc = hdr->frame_control;
 	unsigned int buf_len = 0;
@@ -446,7 +448,7 @@ void rtl8723be_tx_fill_desc(struct ieee80211_hw *hw,
 		RT_TRACE(rtlpriv, COMP_SEND, DBG_TRACE, "DMA mapping error\n");
 		return;
 	}
-	CLEAR_PCI_TX_DESC_CONTENT(pdesc, sizeof(struct tx_desc_8723be));
+	clear_pci_tx_desc_content(pdesc, sizeof(struct tx_desc_8723be));
 	if (ieee80211_is_nullfunc(fc) || ieee80211_is_ctl(fc)) {
 		firstseg = true;
 		lastseg = true;
@@ -461,7 +463,7 @@ void rtl8723be_tx_fill_desc(struct ieee80211_hw *hw,
 					 "Insert 8 byte.pTcb->EMPktNum:%d\n",
 					  ptcb_desc->empkt_num);
 				_rtl8723be_insert_emcontent(ptcb_desc,
-							    (u8 *)(skb->data));
+							    (__le32 *)(skb->data));
 			}
 		} else {
 			set_tx_desc_offset(pdesc, USB_HWDESC_HEADER_LEN);
@@ -556,7 +558,7 @@ void rtl8723be_tx_fill_desc(struct ieee80211_hw *hw,
 			}
 		}
 		/* tx report */
-		rtl_set_tx_report(ptcb_desc, pdesc, hw, tx_info);
+		rtl_set_tx_report(ptcb_desc, pdesc8, hw, tx_info);
 	}
 
 	set_tx_desc_first_seg(pdesc, (firstseg ? 1 : 0));
@@ -584,13 +586,14 @@ void rtl8723be_tx_fill_desc(struct ieee80211_hw *hw,
 	RT_TRACE(rtlpriv, COMP_SEND, DBG_TRACE, "\n");
 }
 
-void rtl8723be_tx_fill_cmddesc(struct ieee80211_hw *hw, u8 *pdesc,
+void rtl8723be_tx_fill_cmddesc(struct ieee80211_hw *hw, u8 *pdesc8,
 			       bool firstseg, bool lastseg,
 			       struct sk_buff *skb)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	struct rtl_pci *rtlpci = rtl_pcidev(rtl_pcipriv(hw));
 	u8 fw_queue = QSLT_BEACON;
+	__le32 *pdesc = (__le32 *)pdesc8;
 
 	dma_addr_t mapping = pci_map_single(rtlpci->pdev,
 					    skb->data, skb->len,
@@ -601,7 +604,7 @@ void rtl8723be_tx_fill_cmddesc(struct ieee80211_hw *hw, u8 *pdesc,
 			 "DMA mapping error\n");
 		return;
 	}
-	CLEAR_PCI_TX_DESC_CONTENT(pdesc, TX_DESC_SIZE);
+	clear_pci_tx_desc_content(pdesc, TX_DESC_SIZE);
 
 	set_tx_desc_offset(pdesc, USB_HWDESC_HEADER_LEN);
 
@@ -625,7 +628,7 @@ void rtl8723be_tx_fill_cmddesc(struct ieee80211_hw *hw, u8 *pdesc,
 
 	set_tx_desc_own(pdesc, 1);
 
-	set_tx_desc_pkt_size((u8 *)pdesc, (u16)(skb->len));
+	set_tx_desc_pkt_size(pdesc, (u16)(skb->len));
 
 	set_tx_desc_first_seg(pdesc, 1);
 	set_tx_desc_last_seg(pdesc, 1);
@@ -636,9 +639,11 @@ void rtl8723be_tx_fill_cmddesc(struct ieee80211_hw *hw, u8 *pdesc,
 		      "H2C Tx Cmd Content\n", pdesc, TX_DESC_SIZE);
 }
 
-void rtl8723be_set_desc(struct ieee80211_hw *hw, u8 *pdesc,
+void rtl8723be_set_desc(struct ieee80211_hw *hw, u8 *pdesc8,
 			bool istx, u8 desc_name, u8 *val)
 {
+	__le32 *pdesc = (__le32 *)pdesc8;
+
 	if (istx) {
 		switch (desc_name) {
 		case HW_DESC_OWN:
@@ -675,9 +680,10 @@ void rtl8723be_set_desc(struct ieee80211_hw *hw, u8 *pdesc,
 }
 
 u64 rtl8723be_get_desc(struct ieee80211_hw *hw,
-		       u8 *pdesc, bool istx, u8 desc_name)
+		       u8 *pdesc8, bool istx, u8 desc_name)
 {
 	u32 ret = 0;
+	__le32 *pdesc = (__le32 *)pdesc8;
 
 	if (istx) {
 		switch (desc_name) {
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8723be/trx.h b/drivers/net/wireless/realtek/rtlwifi/rtl8723be/trx.h
index 066f7ff87d2e..174aca20c7e1 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8723be/trx.h
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8723be/trx.h
@@ -14,385 +14,385 @@
 #define USB_HWDESC_HEADER_LEN			40
 #define CRCLENGTH				4
 
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
 
-static inline u32 get_tx_desc_own(u8 *__pdesc)
+static inline u32 get_tx_desc_own(__le32 *__pdesc)
 {
-	return le32_get_bits(*(__le32 *)__pdesc, BIT(31));
+	return le32_get_bits(*__pdesc, BIT(31));
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
 
-static inline void set_tx_desc_hwseq_sel(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_hwseq_sel(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 12), __val, GENMASK(7, 6));
+	le32p_replace_bits((__pdesc + 3), __val, GENMASK(7, 6));
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
 
-static inline void set_tx_desc_tx_sub_carrier(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_tx_sub_carrier(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 20), __val, GENMASK(3, 0));
+	le32p_replace_bits((__pdesc + 5), __val, GENMASK(3, 0));
 }
 
-static inline void set_tx_desc_data_shortgi(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_data_shortgi(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 20), __val, BIT(4));
+	le32p_replace_bits((__pdesc + 5), __val, BIT(4));
 }
 
-static inline void set_tx_desc_data_bw(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_data_bw(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 20), __val, GENMASK(6, 5));
+	le32p_replace_bits((__pdesc + 5), __val, GENMASK(6, 5));
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
 
-static inline void set_tx_desc_tx_buffer_size(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_tx_buffer_size(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 28), __val, GENMASK(15, 0));
+	le32p_replace_bits((__pdesc + 7), __val, GENMASK(15, 0));
 }
 
-static inline void set_tx_desc_hwseq_en(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_hwseq_en(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 32), __val, BIT(15));
+	le32p_replace_bits((__pdesc + 8), __val, BIT(15));
 }
 
-static inline void set_tx_desc_seq(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_seq(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 36), __val, GENMASK(23, 12));
+	le32p_replace_bits((__pdesc + 9), __val, GENMASK(23, 12));
 }
 
-static inline void set_tx_desc_tx_buffer_address(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_tx_buffer_address(__le32 *__pdesc, u32 __val)
 {
-	*(__le32 *)(__pdesc + 40) = cpu_to_le32(__val);
+	*(__pdesc + 10) = cpu_to_le32(__val);
 }
 
-static inline u32 get_tx_desc_tx_buffer_address(u8 *__pdesc)
+static inline u32 get_tx_desc_tx_buffer_address(__le32 *__pdesc)
 {
-	return le32_to_cpu(*((__le32 *)(__pdesc + 40)));
+	return le32_to_cpu(*((__pdesc + 10)));
 }
 
-static inline void set_tx_desc_next_desc_address(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_next_desc_address(__le32 *__pdesc, u32 __val)
 {
-	*(__le32 *)(__pdesc + 48) = cpu_to_le32(__val);
+	*(__pdesc + 12) = cpu_to_le32(__val);
 }
 
-static inline u32 get_rx_desc_pkt_len(u8 *__pdesc)
+static inline u32 get_rx_desc_pkt_len(__le32 *__pdesc)
 {
-	return le32_get_bits(*(__le32 *)__pdesc, GENMASK(13, 0));
+	return le32_get_bits(*__pdesc, GENMASK(13, 0));
 }
 
-static inline u32 get_rx_desc_crc32(u8 *__pdesc)
+static inline u32 get_rx_desc_crc32(__le32 *__pdesc)
 {
-	return le32_get_bits(*(__le32 *)__pdesc, BIT(14));
+	return le32_get_bits(*__pdesc, BIT(14));
 }
 
-static inline u32 get_rx_desc_icv(u8 *__pdesc)
+static inline u32 get_rx_desc_icv(__le32 *__pdesc)
 {
-	return le32_get_bits(*(__le32 *)__pdesc, BIT(15));
+	return le32_get_bits(*__pdesc, BIT(15));
 }
 
-static inline u32 get_rx_desc_drv_info_size(u8 *__pdesc)
+static inline u32 get_rx_desc_drv_info_size(__le32 *__pdesc)
 {
-	return le32_get_bits(*(__le32 *)__pdesc, GENMASK(19, 16));
+	return le32_get_bits(*__pdesc, GENMASK(19, 16));
 }
 
-static inline u32 get_rx_desc_shift(u8 *__pdesc)
+static inline u32 get_rx_desc_shift(__le32 *__pdesc)
 {
-	return le32_get_bits(*(__le32 *)__pdesc, GENMASK(25, 24));
+	return le32_get_bits(*__pdesc, GENMASK(25, 24));
 }
 
-static inline u32 get_rx_desc_physt(u8 *__pdesc)
+static inline u32 get_rx_desc_physt(__le32 *__pdesc)
 {
-	return le32_get_bits(*(__le32 *)__pdesc, BIT(26));
+	return le32_get_bits(*__pdesc, BIT(26));
 }
 
-static inline u32 get_rx_desc_swdec(u8 *__pdesc)
+static inline u32 get_rx_desc_swdec(__le32 *__pdesc)
 {
-	return le32_get_bits(*(__le32 *)__pdesc, BIT(27));
+	return le32_get_bits(*__pdesc, BIT(27));
 }
 
-static inline u32 get_rx_desc_own(u8 *__pdesc)
+static inline u32 get_rx_desc_own(__le32 *__pdesc)
 {
-	return le32_get_bits(*(__le32 *)__pdesc, BIT(31));
+	return le32_get_bits(*__pdesc, BIT(31));
 }
 
-static inline void set_rx_desc_pkt_len(u8 *__pdesc, u32 __val)
+static inline void set_rx_desc_pkt_len(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)__pdesc, __val, GENMASK(13, 0));
+	le32p_replace_bits(__pdesc, __val, GENMASK(13, 0));
 }
 
-static inline void set_rx_desc_eor(u8 *__pdesc, u32 __val)
+static inline void set_rx_desc_eor(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)__pdesc, __val, BIT(30));
+	le32p_replace_bits(__pdesc, __val, BIT(30));
 }
 
-static inline void set_rx_desc_own(u8 *__pdesc, u32 __val)
+static inline void set_rx_desc_own(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)__pdesc, __val, BIT(31));
+	le32p_replace_bits(__pdesc, __val, BIT(31));
 }
 
-static inline u32 get_rx_desc_macid(u8 *__pdesc)
+static inline u32 get_rx_desc_macid(__le32 *__pdesc)
 {
-	return le32_get_bits(*(__le32 *)(__pdesc + 4), GENMASK(6, 0));
+	return le32_get_bits(*(__pdesc + 1), GENMASK(6, 0));
 }
 
-static inline u32 get_rx_desc_paggr(u8 *__pdesc)
+static inline u32 get_rx_desc_paggr(__le32 *__pdesc)
 {
-	return le32_get_bits(*(__le32 *)(__pdesc + 4), BIT(15));
+	return le32_get_bits(*(__pdesc + 1), BIT(15));
 }
 
-static inline u32 get_rx_status_desc_rpt_sel(u8 *__pdesc)
+static inline u32 get_rx_status_desc_rpt_sel(__le32 *__pdesc)
 {
-	return le32_get_bits(*(__le32 *)(__pdesc + 8), BIT(28));
+	return le32_get_bits(*(__pdesc + 2), BIT(28));
 }
 
-static inline u32 get_rx_desc_rxmcs(u8 *__pdesc)
+static inline u32 get_rx_desc_rxmcs(__le32 *__pdesc)
 {
-	return le32_get_bits(*(__le32 *)(__pdesc + 12), GENMASK(6, 0));
+	return le32_get_bits(*(__pdesc + 3), GENMASK(6, 0));
 }
 
-static inline u32 get_rx_desc_rxht(u8 *__pdesc)
+static inline u32 get_rx_desc_rxht(__le32 *__pdesc)
 {
-	return le32_get_bits(*(__le32 *)(__pdesc + 12), BIT(6));
+	return le32_get_bits(*(__pdesc + 3), BIT(6));
 }
 
-static inline u32 get_rx_status_desc_pattern_match(u8 *__pdesc)
+static inline u32 get_rx_status_desc_pattern_match(__le32 *__pdesc)
 {
-	return le32_get_bits(*(__le32 *)(__pdesc + 12), BIT(29));
+	return le32_get_bits(*(__pdesc + 3), BIT(29));
 }
 
-static inline u32 get_rx_status_desc_unicast_match(u8 *__pdesc)
+static inline u32 get_rx_status_desc_unicast_match(__le32 *__pdesc)
 {
-	return le32_get_bits(*(__le32 *)(__pdesc + 12), BIT(30));
+	return le32_get_bits(*(__pdesc + 3), BIT(30));
 }
 
-static inline u32 get_rx_status_desc_magic_match(u8 *__pdesc)
+static inline u32 get_rx_status_desc_magic_match(__le32 *__pdesc)
 {
-	return le32_get_bits(*(__le32 *)(__pdesc + 12), BIT(31));
+	return le32_get_bits(*(__pdesc + 3), BIT(31));
 }
 
-static inline u32 get_rx_desc_splcp(u8 *__pdesc)
+static inline u32 get_rx_desc_splcp(__le32 *__pdesc)
 {
-	return le32_get_bits(*(__le32 *)(__pdesc + 16), BIT(0));
+	return le32_get_bits(*(__pdesc + 4), BIT(0));
 }
 
-static inline u32 get_rx_desc_bw(u8 *__pdesc)
+static inline u32 get_rx_desc_bw(__le32 *__pdesc)
 {
-	return le32_get_bits(*(__le32 *)(__pdesc + 16), GENMASK(5, 4));
+	return le32_get_bits(*(__pdesc + 4), GENMASK(5, 4));
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
 
-static inline void set_rx_desc_buff_addr(u8 *__pdesc, u32 __val)
+static inline void set_rx_desc_buff_addr(__le32 *__pdesc, u32 __val)
 {
-	*(__le32 *)(__pdesc + 24) = cpu_to_le32(__val);
+	*(__pdesc + 6) = cpu_to_le32(__val);
 }
 
 /* TX report 2 format in Rx desc*/
 
-static inline u32 get_rx_rpt2_desc_macid_valid_1(u8 *__rxstatusdesc)
+static inline u32 get_rx_rpt2_desc_macid_valid_1(__le32 *__rxstatusdesc)
 {
-	return le32_to_cpu(*((__le32 *)(__rxstatusdesc + 16)));
+	return le32_to_cpu(*((__rxstatusdesc + 4)));
 }
 
-static inline u32 get_rx_rpt2_desc_macid_valid_2(u8 *__rxstatusdesc)
+static inline u32 get_rx_rpt2_desc_macid_valid_2(__le32 *__rxstatusdesc)
 {
-	return le32_to_cpu(*((__le32 *)(__rxstatusdesc + 20)));
+	return le32_to_cpu(*((__rxstatusdesc + 5)));
 }
 
-static inline void set_earlymode_pktnum(u8 *__paddr, u32 __value)
+static inline void set_earlymode_pktnum(__le32 *__paddr, u32 __value)
 {
-	le32p_replace_bits((__le32 *)__paddr, __value, GENMASK(3, 0));
+	le32p_replace_bits(__paddr, __value, GENMASK(3, 0));
 }
 
-static inline void set_earlymode_len0(u8 *__paddr, u32 __value)
+static inline void set_earlymode_len0(__le32 *__paddr, u32 __value)
 {
-	le32p_replace_bits((__le32 *)__paddr, __value, GENMASK(15, 4));
+	le32p_replace_bits(__paddr, __value, GENMASK(15, 4));
 }
 
-static inline void set_earlymode_len1(u8 *__paddr, u32 __value)
+static inline void set_earlymode_len1(__le32 *__paddr, u32 __value)
 {
-	le32p_replace_bits((__le32 *)__paddr, __value, GENMASK(27, 16));
+	le32p_replace_bits(__paddr, __value, GENMASK(27, 16));
 }
 
-static inline void set_earlymode_len2_1(u8 *__paddr, u32 __value)
+static inline void set_earlymode_len2_1(__le32 *__paddr, u32 __value)
 {
-	le32p_replace_bits((__le32 *)__paddr, __value, GENMASK(31, 28));
+	le32p_replace_bits(__paddr, __value, GENMASK(31, 28));
 }
 
-static inline void set_earlymode_len2_2(u8 *__paddr, u32 __value)
+static inline void set_earlymode_len2_2(__le32 *__paddr, u32 __value)
 {
-	le32p_replace_bits((__le32 *)(__paddr + 4), __value, GENMASK(7, 0));
+	le32p_replace_bits((__paddr + 1), __value, GENMASK(7, 0));
 }
 
-static inline void set_earlymode_len3(u8 *__paddr, u32 __value)
+static inline void set_earlymode_len3(__le32 *__paddr, u32 __value)
 {
-	le32p_replace_bits((__le32 *)(__paddr + 4), __value, GENMASK(19, 8));
+	le32p_replace_bits((__paddr + 1), __value, GENMASK(19, 8));
 }
 
-static inline void set_earlymode_len4(u8 *__paddr, u32 __value)
+static inline void set_earlymode_len4(__le32 *__paddr, u32 __value)
 {
-	le32p_replace_bits((__le32 *)(__paddr + 4), __value, GENMASK(31, 20));
+	le32p_replace_bits((__paddr + 1), __value, GENMASK(31, 20));
 }
 
-#define CLEAR_PCI_TX_DESC_CONTENT(__pdesc, _size)		\
-do {								\
-	if (_size > TX_DESC_NEXT_DESC_OFFSET)			\
-		memset(__pdesc, 0, TX_DESC_NEXT_DESC_OFFSET);	\
-	else							\
-		memset(__pdesc, 0, _size);			\
-} while (0)
+static inline void clear_pci_tx_desc_content(__le32 *__pdesc, u32 _size)
+{
+	if (_size > TX_DESC_NEXT_DESC_OFFSET)
+		memset(__pdesc, 0, TX_DESC_NEXT_DESC_OFFSET);
+	else
+		memset(__pdesc, 0, _size);
+}
 
 struct phy_rx_agc_info_t {
 	#ifdef __LITTLE_ENDIAN
-- 
2.23.0

