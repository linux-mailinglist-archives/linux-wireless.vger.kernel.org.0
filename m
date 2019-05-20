Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE3923E64
	for <lists+linux-wireless@lfdr.de>; Mon, 20 May 2019 19:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390343AbfETRY0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 May 2019 13:24:26 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:36587 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390374AbfETRY0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 May 2019 13:24:26 -0400
Received: by mail-ot1-f67.google.com with SMTP id c3so13744192otr.3
        for <linux-wireless@vger.kernel.org>; Mon, 20 May 2019 10:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OjtYuGE6qDyi0ZKSGUYOyL+Wz083k3ZtuiC7Jiphtdk=;
        b=LRt6toS9jV4zZE9LEZaoZZSkmOpIR5MLq0fKcHpSozZDjyppyCmD76q7liNi82MAAP
         8y/1wKc7kP1ckYq85MGgp71XZOlWLNc1h7xJ1q0SSRn37kUfYp1qVPLJBnD+qGN1jiCG
         Opd+HOeDPexJ7yIZQmikBFxI/LkMcQI63dowVWXI+AO26usHiPlrG/fweRtmE8jgXbKW
         Se2x3oMKPqZg5yB4TkFHcv+1Cs586SAPB0w1gHb/3ZeNXCWOC+DDwA4I/4Qb6ooUpLmq
         bhRlQNkOW4ew3MFndNuKD1e0p7qc4z9BMdn6p+VcFA7mY3/R4/f+fBjjWTQJZGYw4h0y
         2Ztg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=OjtYuGE6qDyi0ZKSGUYOyL+Wz083k3ZtuiC7Jiphtdk=;
        b=iZGO5AFZ+dtxaXAINHhcBkWWgvqQDdcGRlXe78bSjZI/v/HZPVr6x/HSYwvVczk50H
         nnQgjxdPXtnDLyr8crbb7u0K5BfDHlE5vEfmo+O6wUaGImVmfK72+ShDTD/DvGh4P0KA
         O8xSleC09bA6J55vSIkicyaUHEgrepKaHOhA/10SZB1gINt+NmxeF8itQ8Y7L366iR/9
         cG4zythItX0k9VP2lWp6BBnBINgmLWLWYGNtn18qYdkL2sQKdH/bqI8Q4jQME6AeJ9D0
         73vzyfDTIJVvG/acOCmrL5cHsC8CIt9KMiIInruNKzYXZpT4ZR0v6XRf8Mou0UKOcM10
         yJGQ==
X-Gm-Message-State: APjAAAXQ5FdHNZyAzcWjcEttF6/S35h2UxunbYo9IjGAlORM6vEFAgbb
        0Ub3eO1zzGlvs3c0yk3ad8U=
X-Google-Smtp-Source: APXvYqwvG5eFA0BIzyfen5KrWWpMHzOxv0a7tdKgReN5PPuCZztTjEfFb6lFoh9B1TAE2borWle8LQ==
X-Received: by 2002:a9d:826:: with SMTP id 35mr46510566oty.114.1558373064709;
        Mon, 20 May 2019 10:24:24 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id z190sm6556865oia.21.2019.05.20.10.24.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 10:24:24 -0700 (PDT)
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, pkshih@realtek.com,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH 4/4] rtlwifi: rtl8821ae: Convert inline routines to little-endian words
Date:   Mon, 20 May 2019 12:23:59 -0500
Message-Id: <20190520172359.9993-5-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190520172359.9993-1-Larry.Finger@lwfinger.net>
References: <20190520172359.9993-1-Larry.Finger@lwfinger.net>
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
 .../wireless/realtek/rtlwifi/rtl8821ae/dm.c   |   3 +-
 .../wireless/realtek/rtlwifi/rtl8821ae/trx.c  |  51 +--
 .../wireless/realtek/rtlwifi/rtl8821ae/trx.h  | 310 +++++++++---------
 3 files changed, 185 insertions(+), 179 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/dm.c b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/dm.c
index e1c994f79d71..96d6ed59e771 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/dm.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/dm.c
@@ -2958,10 +2958,11 @@ void rtl8821ae_dm_set_tx_ant_by_tx_info(struct ieee80211_hw *hw,
 	struct rtl_hal *rtlhal = rtl_hal(rtl_priv(hw));
 	struct rtl_dm *rtldm = rtl_dm(rtl_priv(hw));
 	struct fast_ant_training *pfat_table = &rtldm->fat_table;
+	__le32 *pdesc32 = (__le32 *)pdesc;
 
 	if (rtlhal->hw_type != HARDWARE_TYPE_RTL8812AE)
 		return;
 
 	if (rtlefuse->antenna_div_type == CG_TRX_HW_ANTDIV)
-		set_tx_desc_tx_ant(pdesc, pfat_table->antsel_a[mac_id]);
+		set_tx_desc_tx_ant(pdesc32, pfat_table->antsel_a[mac_id]);
 }
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/trx.c b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/trx.c
index 88cbae1ef328..cd809c992245 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/trx.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/trx.c
@@ -56,7 +56,7 @@ static u8 _rtl8821ae_evm_dbm_jaguar(s8 value)
 }
 
 static void query_rxphystatus(struct ieee80211_hw *hw,
-			      struct rtl_stats *pstatus, u8 *pdesc,
+			      struct rtl_stats *pstatus, __le32 *pdesc,
 			      struct rx_fwinfo_8821ae *p_drvinfo,
 			      bool bpacket_match_bssid,
 			      bool bpacket_toself, bool packet_beacon)
@@ -274,7 +274,7 @@ static void query_rxphystatus(struct ieee80211_hw *hw,
 
 static void translate_rx_signal_stuff(struct ieee80211_hw *hw,
 				      struct sk_buff *skb,
-				      struct rtl_stats *pstatus, u8 *pdesc,
+				      struct rtl_stats *pstatus, __le32 *pdesc,
 				      struct rx_fwinfo_8821ae *p_drvinfo)
 {
 	struct rtl_mac *mac = rtl_mac(rtl_priv(hw));
@@ -332,8 +332,8 @@ static void translate_rx_signal_stuff(struct ieee80211_hw *hw,
 	rtl_process_phyinfo(hw, tmp_buf, pstatus);
 }
 
-static void _rtl8821ae_insert_emcontent(struct rtl_tcb_desc *ptcb_desc,
-					u8 *virtualaddress)
+static void rtl8821ae_insert_emcontent(struct rtl_tcb_desc *ptcb_desc,
+				       __le32 *virtualaddress)
 {
 	u32 dwtmp = 0;
 
@@ -384,7 +384,7 @@ static void _rtl8821ae_insert_emcontent(struct rtl_tcb_desc *ptcb_desc,
 	set_earlymode_len4(virtualaddress, dwtmp);
 }
 
-static bool rtl8821ae_get_rxdesc_is_ht(struct ieee80211_hw *hw, u8 *pdesc)
+static bool rtl8821ae_get_rxdesc_is_ht(struct ieee80211_hw *hw, __le32 *pdesc)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	u8 rx_rate = 0;
@@ -398,7 +398,7 @@ static bool rtl8821ae_get_rxdesc_is_ht(struct ieee80211_hw *hw, u8 *pdesc)
 	return false;
 }
 
-static bool rtl8821ae_get_rxdesc_is_vht(struct ieee80211_hw *hw, u8 *pdesc)
+static bool rtl8821ae_get_rxdesc_is_vht(struct ieee80211_hw *hw, __le32 *pdesc)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	u8 rx_rate = 0;
@@ -412,7 +412,7 @@ static bool rtl8821ae_get_rxdesc_is_vht(struct ieee80211_hw *hw, u8 *pdesc)
 	return false;
 }
 
-static u8 rtl8821ae_get_rx_vht_nss(struct ieee80211_hw *hw, u8 *pdesc)
+static u8 rtl8821ae_get_rx_vht_nss(struct ieee80211_hw *hw, __le32 *pdesc)
 {
 	u8 rx_rate = 0;
 	u8 vht_nss = 0;
@@ -431,12 +431,13 @@ static u8 rtl8821ae_get_rx_vht_nss(struct ieee80211_hw *hw, u8 *pdesc)
 bool rtl8821ae_rx_query_desc(struct ieee80211_hw *hw,
 			     struct rtl_stats *status,
 			     struct ieee80211_rx_status *rx_status,
-			     u8 *pdesc, struct sk_buff *skb)
+			     u8 *pdesc8, struct sk_buff *skb)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	struct rx_fwinfo_8821ae *p_drvinfo;
 	struct ieee80211_hdr *hdr;
 	u8 wake_match;
+	__le32 *pdesc = (__le32 *)pdesc8;
 	u32 phystatus = get_rx_desc_physt(pdesc);
 
 	status->length = (u16)get_rx_desc_pkt_len(pdesc);
@@ -656,7 +657,7 @@ static u8 rtl8821ae_sc_mapping(struct ieee80211_hw *hw,
 }
 
 void rtl8821ae_tx_fill_desc(struct ieee80211_hw *hw,
-			    struct ieee80211_hdr *hdr, u8 *pdesc_tx, u8 *txbd,
+			    struct ieee80211_hdr *hdr, u8 *pdesc8, u8 *txbd,
 			    struct ieee80211_tx_info *info,
 			    struct ieee80211_sta *sta,
 			    struct sk_buff *skb,
@@ -667,7 +668,6 @@ void rtl8821ae_tx_fill_desc(struct ieee80211_hw *hw,
 	struct rtl_pci *rtlpci = rtl_pcidev(rtl_pcipriv(hw));
 	struct rtl_hal *rtlhal = rtl_hal(rtlpriv);
 	struct rtlwifi_tx_info *tx_info = rtl_tx_skb_cb_info(skb);
-	u8 *pdesc = (u8 *)pdesc_tx;
 	u16 seq_number;
 	__le16 fc = hdr->frame_control;
 	unsigned int buf_len = 0;
@@ -680,6 +680,7 @@ void rtl8821ae_tx_fill_desc(struct ieee80211_hw *hw,
 	dma_addr_t mapping;
 	u8 short_gi = 0;
 	bool tmp_bool;
+	__le32 *pdesc = (__le32 *)pdesc8;
 
 	seq_number = (le16_to_cpu(hdr->seq_ctrl) & IEEE80211_SCTL_SEQ) >> 4;
 	rtl_get_tcb_desc(hw, info, sta, skb, ptcb_desc);
@@ -696,7 +697,7 @@ void rtl8821ae_tx_fill_desc(struct ieee80211_hw *hw,
 			 "DMA mapping error\n");
 		return;
 	}
-	CLEAR_PCI_TX_DESC_CONTENT(pdesc, sizeof(struct tx_desc_8821ae));
+	clear_pci_tx_desc_content(pdesc, sizeof(struct tx_desc_8821ae));
 	if (ieee80211_is_nullfunc(fc) || ieee80211_is_ctl(fc)) {
 		firstseg = true;
 		lastseg = true;
@@ -710,8 +711,8 @@ void rtl8821ae_tx_fill_desc(struct ieee80211_hw *hw,
 				RT_TRACE(rtlpriv, COMP_SEND, DBG_TRACE,
 					 "Insert 8 byte.pTcb->EMPktNum:%d\n",
 					  ptcb_desc->empkt_num);
-				_rtl8821ae_insert_emcontent(ptcb_desc,
-					 (u8 *)(skb->data));
+				rtl8821ae_insert_emcontent(ptcb_desc,
+							   (__le32 *)skb->data);
 			}
 		} else {
 			set_tx_desc_offset(pdesc, USB_HWDESC_HEADER_LEN);
@@ -795,12 +796,12 @@ void rtl8821ae_tx_fill_desc(struct ieee80211_hw *hw,
 			}
 		}
 		/* tx report */
-		rtl_set_tx_report(ptcb_desc, pdesc, hw, tx_info);
+		rtl_set_tx_report(ptcb_desc, pdesc8, hw, tx_info);
 	}
 
 	set_tx_desc_first_seg(pdesc, (firstseg ? 1 : 0));
 	set_tx_desc_last_seg(pdesc, (lastseg ? 1 : 0));
-	set_tx_desc_tx_buffer_size(pdesc, (u16)buf_len);
+	set_tx_desc_tx_buffer_size(pdesc, buf_len);
 	set_tx_desc_tx_buffer_address(pdesc, mapping);
 	/* if (rtlpriv->dm.useramask) { */
 	if (1) {
@@ -820,17 +821,18 @@ void rtl8821ae_tx_fill_desc(struct ieee80211_hw *hw,
 		set_tx_desc_bmc(pdesc, 1);
 	}
 
-	rtl8821ae_dm_set_tx_ant_by_tx_info(hw, pdesc, ptcb_desc->mac_id);
+	rtl8821ae_dm_set_tx_ant_by_tx_info(hw, pdesc8, ptcb_desc->mac_id);
 	RT_TRACE(rtlpriv, COMP_SEND, DBG_TRACE, "\n");
 }
 
 void rtl8821ae_tx_fill_cmddesc(struct ieee80211_hw *hw,
-			       u8 *pdesc, bool firstseg,
+			       u8 *pdesc8, bool firstseg,
 			       bool lastseg, struct sk_buff *skb)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	struct rtl_pci *rtlpci = rtl_pcidev(rtl_pcipriv(hw));
 	u8 fw_queue = QSLT_BEACON;
+	__le32 *pdesc = (__le32 *)pdesc8;
 
 	dma_addr_t mapping = pci_map_single(rtlpci->pdev,
 					    skb->data, skb->len,
@@ -841,12 +843,12 @@ void rtl8821ae_tx_fill_cmddesc(struct ieee80211_hw *hw,
 			 "DMA mapping error\n");
 		return;
 	}
-	CLEAR_PCI_TX_DESC_CONTENT(pdesc, TX_DESC_SIZE);
+	clear_pci_tx_desc_content(pdesc, TX_DESC_SIZE);
 
 	set_tx_desc_first_seg(pdesc, 1);
 	set_tx_desc_last_seg(pdesc, 1);
 
-	set_tx_desc_pkt_size((u8 *)pdesc, (u16)(skb->len));
+	set_tx_desc_pkt_size(pdesc, (u16)(skb->len));
 
 	set_tx_desc_offset(pdesc, USB_HWDESC_HEADER_LEN);
 
@@ -860,7 +862,7 @@ void rtl8821ae_tx_fill_cmddesc(struct ieee80211_hw *hw,
 
 	set_tx_desc_queue_sel(pdesc, fw_queue);
 
-	set_tx_desc_tx_buffer_size(pdesc, (u16)(skb->len));
+	set_tx_desc_tx_buffer_size(pdesc, skb->len);
 
 	set_tx_desc_tx_buffer_address(pdesc, mapping);
 
@@ -870,12 +872,14 @@ void rtl8821ae_tx_fill_cmddesc(struct ieee80211_hw *hw,
 
 	RT_PRINT_DATA(rtlpriv, COMP_CMD, DBG_LOUD,
 		      "H2C Tx Cmd Content\n",
-		      pdesc, TX_DESC_SIZE);
+		      pdesc8, TX_DESC_SIZE);
 }
 
-void rtl8821ae_set_desc(struct ieee80211_hw *hw, u8 *pdesc,
+void rtl8821ae_set_desc(struct ieee80211_hw *hw, u8 *pdesc8,
 			bool istx, u8 desc_name, u8 *val)
 {
+	__le32 *pdesc = (__le32 *)pdesc8;
+
 	if (istx) {
 		switch (desc_name) {
 		case HW_DESC_OWN:
@@ -914,9 +918,10 @@ void rtl8821ae_set_desc(struct ieee80211_hw *hw, u8 *pdesc,
 }
 
 u64 rtl8821ae_get_desc(struct ieee80211_hw *hw,
-		       u8 *pdesc, bool istx, u8 desc_name)
+		       u8 *pdesc8, bool istx, u8 desc_name)
 {
 	u32 ret = 0;
+	__le32 *pdesc = (__le32 *)pdesc8;
 
 	if (istx) {
 		switch (desc_name) {
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/trx.h b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/trx.h
index 8c96c8efc180..81951f0c80b6 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/trx.h
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/trx.h
@@ -14,385 +14,385 @@
 #define USB_HWDESC_HEADER_LEN			40
 #define CRCLENGTH						4
 
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
+	le32p_replace_bits(__pdesc + 1, __val, GENMASK(6, 0));
 }
 
-static inline void set_tx_desc_queue_sel(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_queue_sel(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 4), __val, GENMASK(12, 8));
+	le32p_replace_bits(__pdesc + 1, __val, GENMASK(12, 8));
 }
 
-static inline void set_tx_desc_rate_id(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_rate_id(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 4), __val, GENMASK(20, 16));
+	le32p_replace_bits(__pdesc + 1, __val, GENMASK(20, 16));
 }
 
-static inline void set_tx_desc_sec_type(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_sec_type(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 4), __val, GENMASK(23, 22));
+	le32p_replace_bits(__pdesc + 1, __val, GENMASK(23, 22));
 }
 
-static inline void set_tx_desc_pkt_offset(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_pkt_offset(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 4), __val, GENMASK(28, 24));
+	le32p_replace_bits(__pdesc + 1, __val, GENMASK(28, 24));
 }
 
-static inline void set_tx_desc_agg_enable(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_agg_enable(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 8), __val, BIT(12));
+	le32p_replace_bits(__pdesc + 2, __val, BIT(12));
 }
 
-static inline void set_tx_desc_rdg_enable(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_rdg_enable(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 8), __val, BIT(13));
+	le32p_replace_bits(__pdesc + 2, __val, BIT(13));
 }
 
-static inline void set_tx_desc_more_frag(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_more_frag(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 8), __val, BIT(17));
+	le32p_replace_bits(__pdesc + 2, __val, BIT(17));
 }
 
-static inline void set_tx_desc_ampdu_density(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_ampdu_density(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 8), __val, GENMASK(22, 20));
+	le32p_replace_bits(__pdesc + 2, __val, GENMASK(22, 20));
 }
 
-static inline void set_tx_desc_hwseq_sel(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_hwseq_sel(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 12), __val, GENMASK(7, 6));
+	le32p_replace_bits(__pdesc + 3, __val, GENMASK(7, 6));
 }
 
-static inline void set_tx_desc_use_rate(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_use_rate(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 12), __val, BIT(8));
+	le32p_replace_bits(__pdesc + 3, __val, BIT(8));
 }
 
-static inline void set_tx_desc_disable_fb(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_disable_fb(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 12), __val, BIT(10));
+	le32p_replace_bits(__pdesc + 3, __val, BIT(10));
 }
 
-static inline void set_tx_desc_cts2self(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_cts2self(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 12), __val, BIT(11));
+	le32p_replace_bits(__pdesc + 3, __val, BIT(11));
 }
 
-static inline void set_tx_desc_rts_enable(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_rts_enable(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 12), __val, BIT(12));
+	le32p_replace_bits(__pdesc + 3, __val, BIT(12));
 }
 
-static inline void set_tx_desc_hw_rts_enable(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_hw_rts_enable(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 12), __val, BIT(13));
+	le32p_replace_bits(__pdesc + 3, __val, BIT(13));
 }
 
-static inline void set_tx_desc_nav_use_hdr(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_nav_use_hdr(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 12), __val, BIT(15));
+	le32p_replace_bits(__pdesc + 3, __val, BIT(15));
 }
 
-static inline void set_tx_desc_max_agg_num(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_max_agg_num(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 12), __val, GENMASK(21, 17));
+	le32p_replace_bits(__pdesc + 3, __val, GENMASK(21, 17));
 }
 
-static inline void set_tx_desc_tx_ant(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_tx_ant(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 20), __val, GENMASK(27, 24));
+	le32p_replace_bits(__pdesc + 5, __val, GENMASK(27, 24));
 }
 
-static inline void set_tx_desc_tx_rate(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_tx_rate(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, GENMASK(6, 0));
+	le32p_replace_bits(__pdesc + 4, __val, GENMASK(6, 0));
 }
 
-static inline void set_tx_desc_data_rate_fb_limit(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_data_rate_fb_limit(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, GENMASK(12, 8));
+	le32p_replace_bits(__pdesc + 4, __val, GENMASK(12, 8));
 }
 
-static inline void set_tx_desc_rts_rate_fb_limit(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_rts_rate_fb_limit(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, GENMASK(16, 13));
+	le32p_replace_bits(__pdesc + 4, __val, GENMASK(16, 13));
 }
 
-static inline void set_tx_desc_rts_rate(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_rts_rate(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, GENMASK(28, 24));
+	le32p_replace_bits(__pdesc + 4, __val, GENMASK(28, 24));
 }
 
-static inline void set_tx_desc_tx_sub_carrier(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_tx_sub_carrier(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 20), __val, GENMASK(3, 0));
+	le32p_replace_bits(__pdesc + 5, __val, GENMASK(3, 0));
 }
 
-static inline void set_tx_desc_data_shortgi(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_data_shortgi(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 20), __val, BIT(4));
+	le32p_replace_bits(__pdesc + 5, __val, BIT(4));
 }
 
-static inline void set_tx_desc_data_bw(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_data_bw(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 20), __val, GENMASK(6, 5));
+	le32p_replace_bits(__pdesc + 5, __val, GENMASK(6, 5));
 }
 
-static inline void set_tx_desc_rts_short(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_rts_short(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 20), __val, BIT(12));
+	le32p_replace_bits(__pdesc + 5, __val, BIT(12));
 }
 
-static inline void set_tx_desc_rts_sc(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_rts_sc(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 20), __val, GENMASK(16, 13));
+	le32p_replace_bits(__pdesc + 5, __val, GENMASK(16, 13));
 }
 
-static inline void set_tx_desc_tx_buffer_size(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_tx_buffer_size(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 28), __val, GENMASK(15, 0));
+	le32p_replace_bits(__pdesc + 7, __val, GENMASK(15, 0));
 }
 
-static inline void set_tx_desc_hwseq_en(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_hwseq_en(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 32), __val, BIT(15));
+	le32p_replace_bits(__pdesc + 8, __val, BIT(15));
 }
 
-static inline void set_tx_desc_seq(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_seq(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 36), __val, GENMASK(23, 12));
+	le32p_replace_bits(__pdesc + 9, __val, GENMASK(23, 12));
 }
 
-static inline void set_tx_desc_tx_buffer_address(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_tx_buffer_address(__le32 *__pdesc, u32 __val)
 {
-	*(__le32 *)(__pdesc + 40) = cpu_to_le32(__val);
+	*(__pdesc + 10) = cpu_to_le32(__val);
 }
 
-static inline int get_tx_desc_tx_buffer_address(u8 *__pdesc)
+static inline int get_tx_desc_tx_buffer_address(__le32 *__pdesc)
 {
-	return le32_to_cpu(*((__le32 *)(__pdesc + 40)));
+	return le32_to_cpu(*(__pdesc + 10));
 }
 
-static inline void set_tx_desc_next_desc_address(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_next_desc_address(__le32 *__pdesc, u32 __val)
 {
-	*(__le32 *)(__pdesc + 48) = cpu_to_le32(__val);
+	*(__pdesc + 12) = cpu_to_le32(__val);
 }
 
-static inline int get_rx_desc_pkt_len(u8 *__pdesc)
+static inline int get_rx_desc_pkt_len(__le32 *__pdesc)
 {
-	return le32_get_bits(*((__le32 *)(__pdesc)), GENMASK(13, 0));
+	return le32_get_bits(*(__pdesc), GENMASK(13, 0));
 }
 
-static inline int get_rx_desc_crc32(u8 *__pdesc)
+static inline int get_rx_desc_crc32(__le32 *__pdesc)
 {
-	return le32_get_bits(*((__le32 *)(__pdesc)), BIT(14));
+	return le32_get_bits(*(__pdesc), BIT(14));
 }
 
-static inline int get_rx_desc_icv(u8 *__pdesc)
+static inline int get_rx_desc_icv(__le32 *__pdesc)
 {
-	return le32_get_bits(*((__le32 *)(__pdesc)), BIT(15));
+	return le32_get_bits(*(__pdesc), BIT(15));
 }
 
-static inline int get_rx_desc_drv_info_size(u8 *__pdesc)
+static inline int get_rx_desc_drv_info_size(__le32 *__pdesc)
 {
-	return le32_get_bits(*((__le32 *)(__pdesc)), GENMASK(19, 16));
+	return le32_get_bits(*(__pdesc), GENMASK(19, 16));
 }
 
-static inline int get_rx_desc_shift(u8 *__pdesc)
+static inline int get_rx_desc_shift(__le32 *__pdesc)
 {
-	return le32_get_bits(*((__le32 *)(__pdesc)), GENMASK(25, 24));
+	return le32_get_bits(*(__pdesc), GENMASK(25, 24));
 }
 
-static inline int get_rx_desc_physt(u8 *__pdesc)
+static inline int get_rx_desc_physt(__le32 *__pdesc)
 {
-	return le32_get_bits(*((__le32 *)(__pdesc)), BIT(26));
+	return le32_get_bits(*(__pdesc), BIT(26));
 }
 
-static inline int get_rx_desc_swdec(u8 *__pdesc)
+static inline int get_rx_desc_swdec(__le32 *__pdesc)
 {
-	return le32_get_bits(*((__le32 *)(__pdesc)), BIT(27));
+	return le32_get_bits(*(__pdesc), BIT(27));
 }
 
-static inline int get_rx_desc_own(u8 *__pdesc)
+static inline int get_rx_desc_own(__le32 *__pdesc)
 {
-	return le32_get_bits(*((__le32 *)(__pdesc)), BIT(31));
+	return le32_get_bits(*(__pdesc), BIT(31));
 }
 
-static inline void set_rx_desc_pkt_len(u8 *__pdesc, u32 __val)
+static inline void set_rx_desc_pkt_len(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc), __val, GENMASK(13, 0));
+	le32p_replace_bits(__pdesc, __val, GENMASK(13, 0));
 }
 
-static inline void set_rx_desc_eor(u8 *__pdesc, u32 __val)
+static inline void set_rx_desc_eor(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc), __val, BIT(30));
+	le32p_replace_bits(__pdesc, __val, BIT(30));
 }
 
-static inline void set_rx_desc_own(u8 *__pdesc, u32 __val)
+static inline void set_rx_desc_own(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc), __val, BIT(31));
+	le32p_replace_bits(__pdesc, __val, BIT(31));
 }
 
-static inline int get_rx_desc_macid(u8 *__pdesc)
+static inline int get_rx_desc_macid(__le32 *__pdesc)
 {
-	return le32_get_bits(*((__le32 *)(__pdesc + 4)), GENMASK(6, 0));
+	return le32_get_bits(*(__pdesc + 1), GENMASK(6, 0));
 }
 
-static inline int get_rx_desc_paggr(u8 *__pdesc)
+static inline int get_rx_desc_paggr(__le32 *__pdesc)
 {
-	return le32_get_bits(*((__le32 *)(__pdesc + 4)), BIT(15));
+	return le32_get_bits(*(__pdesc + 1), BIT(15));
 }
 
-static inline int get_rx_status_desc_rpt_sel(u8 *__pdesc)
+static inline int get_rx_status_desc_rpt_sel(__le32 *__pdesc)
 {
-	return le32_get_bits(*((__le32 *)(__pdesc + 4)), BIT(28));
+	return le32_get_bits(*(__pdesc + 1), BIT(28));
 }
 
-static inline int get_rx_desc_rxmcs(u8 *__pdesc)
+static inline int get_rx_desc_rxmcs(__le32 *__pdesc)
 {
-	return le32_get_bits(*((__le32 *)(__pdesc + 12)), GENMASK(6, 0));
+	return le32_get_bits(*(__pdesc + 3), GENMASK(6, 0));
 }
 
-static inline int get_rx_status_desc_pattern_match(u8 *__pdesc)
+static inline int get_rx_status_desc_pattern_match(__le32 *__pdesc)
 {
-	return le32_get_bits(*((__le32 *)(__pdesc + 12)), BIT(29));
+	return le32_get_bits(*(__pdesc + 3), BIT(29));
 }
 
-static inline int get_rx_status_desc_unicast_match(u8 *__pdesc)
+static inline int get_rx_status_desc_unicast_match(__le32 *__pdesc)
 {
-	return le32_get_bits(*((__le32 *)(__pdesc + 12)), BIT(30));
+	return le32_get_bits(*(__pdesc + 3), BIT(30));
 }
 
-static inline int get_rx_status_desc_magic_match(u8 *__pdesc)
+static inline int get_rx_status_desc_magic_match(__le32 *__pdesc)
 {
-	return le32_get_bits(*((__le32 *)(__pdesc + 12)), BIT(31));
+	return le32_get_bits(*(__pdesc + 3), BIT(31));
 }
 
-static inline int get_rx_desc_splcp(u8 *__pdesc)
+static inline int get_rx_desc_splcp(__le32 *__pdesc)
 {
-	return le32_get_bits(*((__le32 *)(__pdesc + 16)), BIT(0));
+	return le32_get_bits(*(__pdesc + 4), BIT(0));
 }
 
-static inline int get_rx_desc_bw(u8 *__pdesc)
+static inline int get_rx_desc_bw(__le32 *__pdesc)
 {
-	return le32_get_bits(*((__le32 *)(__pdesc + 16)), GENMASK(5, 4));
+	return le32_get_bits(*(__pdesc + 4), GENMASK(5, 4));
 }
 
-static inline int get_rx_desc_tsfl(u8 *__pdesc)
+static inline int get_rx_desc_tsfl(__le32 *__pdesc)
 {
-	return le32_to_cpu(*((__le32 *)(__pdesc + 20)));
+	return le32_to_cpu(*(__pdesc + 5));
 }
 
-static inline int get_rx_desc_buff_addr(u8 *__pdesc)
+static inline int get_rx_desc_buff_addr(__le32 *__pdesc)
 {
-	return le32_to_cpu(*((__le32 *)(__pdesc + 24)));
+	return le32_to_cpu(*(__pdesc + 6));
 }
 
-static inline void set_rx_desc_buff_addr(u8 *__pdesc, u32 __val)
+static inline void set_rx_desc_buff_addr(__le32 *__pdesc, u32 __val)
 {
-	*(__le32 *)(__pdesc + 24) = cpu_to_le32(__val);
+	*(__pdesc + 6) = cpu_to_le32(__val);
 }
 
 /* TX report 2 format in Rx desc*/
 
-static inline int get_rx_rpt2_desc_macid_valid_1(u8 *__status)
+static inline int get_rx_rpt2_desc_macid_valid_1(__le32 *__status)
 {
-	return le32_to_cpu(*((__le32 *)(__status + 16)));
+	return le32_to_cpu(*(__status + 4));
 }
 
-static inline int get_rx_rpt2_desc_macid_valid_2(u8 *__status)
+static inline int get_rx_rpt2_desc_macid_valid_2(__le32 *__status)
 {
-	return le32_to_cpu(*((__le32 *)(__status + 20)));
+	return le32_to_cpu(*(__status + 5));
 }
 
-static inline void set_earlymode_pktnum(u8 *__paddr, u32 __value)
+static inline void set_earlymode_pktnum(__le32 *__paddr, u32 __value)
 {
-	le32p_replace_bits((__le32 *)(__paddr), __value, GENMASK(3, 0));
+	le32p_replace_bits(__paddr, __value, GENMASK(3, 0));
 }
 
-static inline void set_earlymode_len0(u8 *__paddr, u32 __value)
+static inline void set_earlymode_len0(__le32 *__paddr, u32 __value)
 {
-	le32p_replace_bits((__le32 *)(__paddr), __value, GENMASK(15, 4));
+	le32p_replace_bits(__paddr, __value, GENMASK(15, 4));
 }
 
-static inline void set_earlymode_len1(u8 *__paddr, u32 __value)
+static inline void set_earlymode_len1(__le32 *__paddr, u32 __value)
 {
-	le32p_replace_bits((__le32 *)(__paddr), __value, GENMASK(27, 16));
+	le32p_replace_bits(__paddr, __value, GENMASK(27, 16));
 }
 
-static inline void set_earlymode_len2_1(u8 *__paddr, u32 __value)
+static inline void set_earlymode_len2_1(__le32 *__paddr, u32 __value)
 {
-	le32p_replace_bits((__le32 *)(__paddr), __value, GENMASK(31, 28));
+	le32p_replace_bits(__paddr, __value, GENMASK(31, 28));
 }
 
-static inline void set_earlymode_len2_2(u8 *__paddr, u32 __value)
+static inline void set_earlymode_len2_2(__le32 *__paddr, u32 __value)
 {
-	le32p_replace_bits((__le32 *)(__paddr), __value, GENMASK(7, 0));
+	le32p_replace_bits(__paddr, __value, GENMASK(7, 0));
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
+static inline void clear_pci_tx_desc_content(__le32 *__pdesc, int _size)
+{
+	if (_size > TX_DESC_NEXT_DESC_OFFSET)
+		memset(__pdesc, 0, TX_DESC_NEXT_DESC_OFFSET);
+	else
+		memset(__pdesc, 0, _size);
+}
 
 #define RTL8821AE_RX_HAL_IS_CCK_RATE(rxmcs)\
 	(rxmcs == DESC_RATE1M ||\
-- 
2.21.0

