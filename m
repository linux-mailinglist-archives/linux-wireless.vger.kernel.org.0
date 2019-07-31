Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B50C97B738
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jul 2019 02:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbfGaAdU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 30 Jul 2019 20:33:20 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:42294 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbfGaAdS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 30 Jul 2019 20:33:18 -0400
Received: by mail-ot1-f68.google.com with SMTP id l15so68302743otn.9
        for <linux-wireless@vger.kernel.org>; Tue, 30 Jul 2019 17:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/fmRwrlOSrZeTiTRwMm+iAcLYeAl6o8O0s5KPyfsZe0=;
        b=evLB1FOraKiXKn7PiXZSbDnwYgtQdNqVzbpr8IBQU8q93OS7rgLP1Ho4mqi9II9yNb
         SAMj+2V9oWYk5tPWjEzcffarVnuO8sr+/MKdSI4eYrJP04VR+kDL2GYd4SMnV791zMZ8
         h7+FAt4Cd0/MVBh4YdLw+hunKC4hCPcHxC6YV5addJ9+ms8u+DMJ5efe0fB2mJbRKK/+
         buvERR/faZeWmJW97QKA6Ptk8VsMSl2TqKCkOktNl8i/bV6B8dJNVNEPArxL2cidW1yp
         itRdAns6uhDv6FXhB+cMp7dGAVo4ezy52SKwAGvukd5YXqVoGZBtos0AyStsm+dyu9GP
         jKDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=/fmRwrlOSrZeTiTRwMm+iAcLYeAl6o8O0s5KPyfsZe0=;
        b=Mwb97CkWM4oZEsA0EKTfs9jr6cIRHWslYP0mDd+fMVEQygX1gXck+T/hUrHyj4VzFW
         S8YnjTmzkgt3yfGrDNCz/T/dVqhpiTml341quVh7X/G04665WRTI6ItD398kvHF+sV4o
         /DR/sCtANZ8p/Z89GVN/mD/LhHbPng1RGk35P40eaU9sHJoTG8ulJHM9VvbeYOu0mY8K
         c76iFSK6cOM0dCSQwioDUZevD07EEQdD/u9U/aFiQ99BLxw3u5mv6zsrAID6tuD+r2tz
         Qol519z9y6MEB3xQ2KdFjQU/TczXZmnU71Kq5B3LaK2Mvx15FcugFbQ3AQEu4TvJs5vs
         UPwg==
X-Gm-Message-State: APjAAAVrQQ4tCwTvfbpLLdal+3j7LKCOJVYUqTTGvsJsiXXimtkP6VHu
        pc3YiQzsT/p+JRbLsPsF5mM=
X-Google-Smtp-Source: APXvYqwpgn2nIIKPp9nl0rz2FDy35xMqkdHuesqlyenhU0TYr/Uc0Xmmp4i84wdqhJ/5oFU0zGac2A==
X-Received: by 2002:a05:6830:15c4:: with SMTP id j4mr33010498otr.115.1564533197181;
        Tue, 30 Jul 2019 17:33:17 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id t11sm22156016otq.13.2019.07.30.17.33.16
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 17:33:16 -0700 (PDT)
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, pkshih@realtek.com,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH 4/5] rtlwifi: rtl8188ee: Convert inline routines to little-endian words
Date:   Tue, 30 Jul 2019 19:33:03 -0500
Message-Id: <20190731003304.14377-5-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190731003304.14377-1-Larry.Finger@lwfinger.net>
References: <20190731003304.14377-1-Larry.Finger@lwfinger.net>
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
 .../wireless/realtek/rtlwifi/rtl8188ee/dm.c   |   7 +-
 .../wireless/realtek/rtlwifi/rtl8188ee/trx.c  |  35 +-
 .../wireless/realtek/rtlwifi/rtl8188ee/trx.h  | 438 +++++++++---------
 3 files changed, 243 insertions(+), 237 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/dm.c b/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/dm.c
index 1ba339788d3a..333e355c9281 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/dm.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/dm.c
@@ -1411,12 +1411,13 @@ void rtl88e_dm_set_tx_ant_by_tx_info(struct ieee80211_hw *hw,
 	struct rtl_efuse *rtlefuse = rtl_efuse(rtl_priv(hw));
 	struct rtl_dm *rtldm = rtl_dm(rtl_priv(hw));
 	struct fast_ant_training *pfat_table = &rtldm->fat_table;
+	__le32 *pdesc32 = (__le32 *)pdesc;
 
 	if ((rtlefuse->antenna_div_type == CG_TRX_HW_ANTDIV) ||
 	    (rtlefuse->antenna_div_type == CG_TRX_SMART_ANTDIV)) {
-		set_tx_desc_antsel_a(pdesc, pfat_table->antsel_a[mac_id]);
-		set_tx_desc_antsel_b(pdesc, pfat_table->antsel_b[mac_id]);
-		set_tx_desc_antsel_c(pdesc, pfat_table->antsel_c[mac_id]);
+		set_tx_desc_antsel_a(pdesc32, pfat_table->antsel_a[mac_id]);
+		set_tx_desc_antsel_b(pdesc32, pfat_table->antsel_b[mac_id]);
+		set_tx_desc_antsel_c(pdesc32, pfat_table->antsel_c[mac_id]);
 	}
 }
 
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/trx.c b/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/trx.c
index d5be69e72838..aa2e9e88be53 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/trx.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/trx.c
@@ -25,7 +25,7 @@ static u8 _rtl88ee_map_hwqueue_to_fwqueue(struct sk_buff *skb, u8 hw_queue)
 }
 
 static void _rtl88ee_query_rxphystatus(struct ieee80211_hw *hw,
-			struct rtl_stats *pstatus, u8 *pdesc,
+			struct rtl_stats *pstatus, __le32 *pdesc,
 			struct rx_fwinfo_88e *p_drvinfo,
 			bool bpacket_match_bssid,
 			bool bpacket_toself, bool packet_beacon)
@@ -271,7 +271,7 @@ static void _rtl88ee_smart_antenna(struct ieee80211_hw *hw,
 static void _rtl88ee_translate_rx_signal_stuff(struct ieee80211_hw *hw,
 					       struct sk_buff *skb,
 					       struct rtl_stats *pstatus,
-					       u8 *pdesc,
+					       __le32 *pdesc,
 					       struct rx_fwinfo_88e *p_drvinfo)
 {
 	struct rtl_mac *mac = rtl_mac(rtl_priv(hw));
@@ -313,8 +313,8 @@ static void _rtl88ee_translate_rx_signal_stuff(struct ieee80211_hw *hw,
 	rtl_process_phyinfo(hw, tmp_buf, pstatus);
 }
 
-static void _rtl88ee_insert_emcontent(struct rtl_tcb_desc *ptcb_desc,
-				      u8 *virtualaddress)
+static void rtl88ee_insert_emcontent(struct rtl_tcb_desc *ptcb_desc,
+				     __le32 *virtualaddress)
 {
 	u32 dwtmp = 0;
 	memset(virtualaddress, 0, 8);
@@ -367,12 +367,13 @@ static void _rtl88ee_insert_emcontent(struct rtl_tcb_desc *ptcb_desc,
 bool rtl88ee_rx_query_desc(struct ieee80211_hw *hw,
 			   struct rtl_stats *status,
 			   struct ieee80211_rx_status *rx_status,
-			   u8 *pdesc, struct sk_buff *skb)
+			   u8 *pdesc8, struct sk_buff *skb)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	struct rx_fwinfo_88e *p_drvinfo;
 	struct ieee80211_hdr *hdr;
 	u8 wake_match;
+	__le32 *pdesc = (__le32 *)pdesc8;
 	u32 phystatus = get_rx_desc_physt(pdesc);
 
 	status->packet_report_type = (u8)get_rx_status_desc_rpt_sel(pdesc);
@@ -473,7 +474,7 @@ bool rtl88ee_rx_query_desc(struct ieee80211_hw *hw,
 }
 
 void rtl88ee_tx_fill_desc(struct ieee80211_hw *hw,
-			  struct ieee80211_hdr *hdr, u8 *pdesc_tx,
+			  struct ieee80211_hdr *hdr, u8 *pdesc8,
 			  u8 *txbd, struct ieee80211_tx_info *info,
 			  struct ieee80211_sta *sta,
 			  struct sk_buff *skb,
@@ -484,7 +485,6 @@ void rtl88ee_tx_fill_desc(struct ieee80211_hw *hw,
 	struct rtl_mac *mac = rtl_mac(rtl_priv(hw));
 	struct rtl_pci *rtlpci = rtl_pcidev(rtl_pcipriv(hw));
 	struct rtl_hal *rtlhal = rtl_hal(rtlpriv);
-	u8 *pdesc = (u8 *)pdesc_tx;
 	u16 seq_number;
 	__le16 fc = hdr->frame_control;
 	unsigned int buf_len = 0;
@@ -497,6 +497,7 @@ void rtl88ee_tx_fill_desc(struct ieee80211_hw *hw,
 	dma_addr_t mapping;
 	u8 bw_40 = 0;
 	u8 short_gi = 0;
+	__le32 *pdesc = (u32 *)pdesc8;
 
 	if (mac->opmode == NL80211_IFTYPE_STATION) {
 		bw_40 = mac->bw_40;
@@ -521,7 +522,7 @@ void rtl88ee_tx_fill_desc(struct ieee80211_hw *hw,
 			 "DMA mapping error\n");
 		return;
 	}
-	CLEAR_PCI_TX_DESC_CONTENT(pdesc, sizeof(struct tx_desc_88e));
+	clear_pci_tx_desc_content(pdesc, sizeof(struct tx_desc_88e));
 	if (ieee80211_is_nullfunc(fc) || ieee80211_is_ctl(fc)) {
 		firstseg = true;
 		lastseg = true;
@@ -535,8 +536,8 @@ void rtl88ee_tx_fill_desc(struct ieee80211_hw *hw,
 				RT_TRACE(rtlpriv, COMP_SEND, DBG_TRACE,
 					 "Insert 8 byte.pTcb->EMPktNum:%d\n",
 					  ptcb_desc->empkt_num);
-				_rtl88ee_insert_emcontent(ptcb_desc,
-							  (u8 *)(skb->data));
+				rtl88ee_insert_emcontent(ptcb_desc,
+							 (__le32 *)(skb->data));
 			}
 		} else {
 			set_tx_desc_offset(pdesc, USB_HWDESC_HEADER_LEN);
@@ -660,17 +661,18 @@ void rtl88ee_tx_fill_desc(struct ieee80211_hw *hw,
 		set_tx_desc_bmc(pdesc, 1);
 	}
 
-	rtl88e_dm_set_tx_ant_by_tx_info(hw, pdesc, ptcb_desc->mac_id);
+	rtl88e_dm_set_tx_ant_by_tx_info(hw, pdesc8, ptcb_desc->mac_id);
 	RT_TRACE(rtlpriv, COMP_SEND, DBG_TRACE, "\n");
 }
 
 void rtl88ee_tx_fill_cmddesc(struct ieee80211_hw *hw,
-			     u8 *pdesc, bool firstseg,
+			     u8 *pdesc8, bool firstseg,
 			     bool lastseg, struct sk_buff *skb)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	struct rtl_pci *rtlpci = rtl_pcidev(rtl_pcipriv(hw));
 	u8 fw_queue = QSLT_BEACON;
+	__le32 *pdesc = (__le32 *)pdesc8;
 
 	dma_addr_t mapping = pci_map_single(rtlpci->pdev,
 					    skb->data, skb->len,
@@ -684,7 +686,7 @@ void rtl88ee_tx_fill_cmddesc(struct ieee80211_hw *hw,
 			 "DMA mapping error\n");
 		return;
 	}
-	CLEAR_PCI_TX_DESC_CONTENT(pdesc, TX_DESC_SIZE);
+	clear_pci_tx_desc_content(pdesc, TX_DESC_SIZE);
 
 	if (firstseg)
 		set_tx_desc_offset(pdesc, USB_HWDESC_HEADER_LEN);
@@ -726,9 +728,11 @@ void rtl88ee_tx_fill_cmddesc(struct ieee80211_hw *hw,
 		      pdesc, TX_DESC_SIZE);
 }
 
-void rtl88ee_set_desc(struct ieee80211_hw *hw, u8 *pdesc,
+void rtl88ee_set_desc(struct ieee80211_hw *hw, u8 *pdesc8,
 		      bool istx, u8 desc_name, u8 *val)
 {
+	__le32 *pdesc = (__le32 *)pdesc8;
+
 	if (istx == true) {
 		switch (desc_name) {
 		case HW_DESC_OWN:
@@ -765,9 +769,10 @@ void rtl88ee_set_desc(struct ieee80211_hw *hw, u8 *pdesc,
 }
 
 u64 rtl88ee_get_desc(struct ieee80211_hw *hw,
-		     u8 *pdesc, bool istx, u8 desc_name)
+		     u8 *pdesc8, bool istx, u8 desc_name)
 {
 	u32 ret = 0;
+	__le32 *pdesc = (__le32 *)pdesc8;
 
 	if (istx == true) {
 		switch (desc_name) {
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/trx.h b/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/trx.h
index 6b054361ed5d..4e3682ded89e 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/trx.h
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/trx.h
@@ -14,545 +14,545 @@
 #define USB_HWDESC_HEADER_LEN			32
 #define CRCLENGTH						4
 
-static inline void set_tx_desc_pkt_size(u8 *__pdesc, u32  __val)
+static inline void set_tx_desc_pkt_size(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)__pdesc, __val, GENMASK(15, 0));
+	le32p_replace_bits(__pdesc, __val, GENMASK(15, 0));
 }
 
-static inline void set_tx_desc_offset(u8 *__pdesc, u32  __val)
+static inline void set_tx_desc_offset(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)__pdesc, __val, GENMASK(23, 16));
+	le32p_replace_bits(__pdesc, __val, GENMASK(23, 16));
 }
 
-static inline void set_tx_desc_bmc(u8 *__pdesc, u32  __val)
+static inline void set_tx_desc_bmc(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)__pdesc, __val, BIT(24));
+	le32p_replace_bits(__pdesc, __val, BIT(24));
 }
 
-static inline void set_tx_desc_htc(u8 *__pdesc, u32  __val)
+static inline void set_tx_desc_htc(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)__pdesc, __val, BIT(25));
+	le32p_replace_bits(__pdesc, __val, BIT(25));
 }
 
-static inline void set_tx_desc_last_seg(u8 *__pdesc, u32  __val)
+static inline void set_tx_desc_last_seg(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)__pdesc, __val, BIT(26));
+	le32p_replace_bits(__pdesc, __val, BIT(26));
 }
 
-static inline void set_tx_desc_first_seg(u8 *__pdesc, u32  __val)
+static inline void set_tx_desc_first_seg(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)__pdesc, __val, BIT(27));
+	le32p_replace_bits(__pdesc, __val, BIT(27));
 }
 
-static inline void set_tx_desc_linip(u8 *__pdesc, u32  __val)
+static inline void set_tx_desc_linip(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)__pdesc, __val, BIT(28));
+	le32p_replace_bits(__pdesc, __val, BIT(28));
 }
 
-static inline void set_tx_desc_own(u8 *__pdesc, u32  __val)
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
 
-static inline void set_tx_desc_macid(u8 *__pdesc, u32  __val)
+static inline void set_tx_desc_macid(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 4), __val, GENMASK(5, 0));
+	le32p_replace_bits(__pdesc + 1, __val, GENMASK(5, 0));
 }
 
-static inline void set_tx_desc_queue_sel(u8 *__pdesc, u32  __val)
+static inline void set_tx_desc_queue_sel(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 4), __val, GENMASK(12, 8));
+	le32p_replace_bits(__pdesc + 1, __val, GENMASK(12, 8));
 }
 
-static inline void set_tx_desc_rate_id(u8 *__pdesc, u32  __val)
+static inline void set_tx_desc_rate_id(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 4), __val, GENMASK(19, 16));
+	le32p_replace_bits(__pdesc + 1, __val, GENMASK(19, 16));
 }
 
-static inline void set_tx_desc_nav_use_hdr(u8 *__pdesc, u32  __val)
+static inline void set_tx_desc_nav_use_hdr(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 4), __val, BIT(20));
+	le32p_replace_bits(__pdesc + 1, __val, BIT(20));
 }
 
-static inline void set_tx_desc_sec_type(u8 *__pdesc, u32  __val)
+static inline void set_tx_desc_sec_type(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 4), __val, GENMASK(23, 22));
+	le32p_replace_bits(__pdesc + 1, __val, GENMASK(23, 22));
 }
 
-static inline void set_tx_desc_pkt_offset(u8 *__pdesc, u32  __val)
+static inline void set_tx_desc_pkt_offset(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 4), __val, GENMASK(30, 26));
+	le32p_replace_bits(__pdesc + 1, __val, GENMASK(30, 26));
 }
 
-static inline void set_tx_desc_agg_enable(u8 *__pdesc, u32  __val)
+static inline void set_tx_desc_agg_enable(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 8), __val, BIT(12));
+	le32p_replace_bits(__pdesc + 2, __val, BIT(12));
 }
 
-static inline void set_tx_desc_rdg_enable(u8 *__pdesc, u32  __val)
+static inline void set_tx_desc_rdg_enable(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 8), __val, BIT(13));
+	le32p_replace_bits(__pdesc + 2, __val, BIT(13));
 }
 
-static inline void set_tx_desc_more_frag(u8 *__pdesc, u32  __val)
+static inline void set_tx_desc_more_frag(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 8), __val, BIT(17));
+	le32p_replace_bits(__pdesc + 2, __val, BIT(17));
 }
 
-static inline void set_tx_desc_ampdu_density(u8 *__pdesc, u32  __val)
+static inline void set_tx_desc_ampdu_density(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 8), __val, GENMASK(22, 20));
+	le32p_replace_bits(__pdesc + 2, __val, GENMASK(22, 20));
 }
 
-static inline void set_tx_desc_antsel_a(u8 *__pdesc, u32  __val)
+static inline void set_tx_desc_antsel_a(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 8), __val, BIT(24));
+	le32p_replace_bits(__pdesc + 2, __val, BIT(24));
 }
 
-static inline void set_tx_desc_antsel_b(u8 *__pdesc, u32  __val)
+static inline void set_tx_desc_antsel_b(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 8), __val, BIT(25));
+	le32p_replace_bits(__pdesc + 2, __val, BIT(25));
 }
 
-static inline void set_tx_desc_seq(u8 *__pdesc, u32  __val)
+static inline void set_tx_desc_seq(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 12), __val, GENMASK(27, 16));
+	le32p_replace_bits(__pdesc + 3, __val, GENMASK(27, 16));
 }
 
-static inline void set_tx_desc_hwseq_en(u8 *__pdesc, u32  __val)
+static inline void set_tx_desc_hwseq_en(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 12), __val, BIT(31));
+	le32p_replace_bits(__pdesc + 3, __val, BIT(31));
 }
 
-static inline void set_tx_desc_rts_rate(u8 *__pdesc, u32  __val)
+static inline void set_tx_desc_rts_rate(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, GENMASK(4, 0));
+	le32p_replace_bits(__pdesc + 4, __val, GENMASK(4, 0));
 }
 
-static inline void set_tx_desc_qos(u8 *__pdesc, u32  __val)
+static inline void set_tx_desc_qos(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, BIT(6));
+	le32p_replace_bits(__pdesc + 4, __val, BIT(6));
 }
 
-static inline void set_tx_desc_use_rate(u8 *__pdesc, u32  __val)
+static inline void set_tx_desc_use_rate(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, BIT(8));
+	le32p_replace_bits(__pdesc + 4, __val, BIT(8));
 }
 
-static inline void set_tx_desc_disable_fb(u8 *__pdesc, u32  __val)
+static inline void set_tx_desc_disable_fb(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, BIT(10));
+	le32p_replace_bits(__pdesc + 4, __val, BIT(10));
 }
 
-static inline void set_tx_desc_cts2self(u8 *__pdesc, u32  __val)
+static inline void set_tx_desc_cts2self(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, BIT(11));
+	le32p_replace_bits(__pdesc + 4, __val, BIT(11));
 }
 
-static inline void set_tx_desc_rts_enable(u8 *__pdesc, u32  __val)
+static inline void set_tx_desc_rts_enable(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, BIT(12));
+	le32p_replace_bits(__pdesc + 4, __val, BIT(12));
 }
 
-static inline void set_tx_desc_hw_rts_enable(u8 *__pdesc, u32  __val)
+static inline void set_tx_desc_hw_rts_enable(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, BIT(13));
+	le32p_replace_bits(__pdesc + 4, __val, BIT(13));
 }
 
-static inline void set_tx_desc_tx_sub_carrier(u8 *__pdesc, u32  __val)
+static inline void set_tx_desc_tx_sub_carrier(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, GENMASK(21, 20));
+	le32p_replace_bits(__pdesc + 4, __val, GENMASK(21, 20));
 }
 
-static inline void set_tx_desc_tx_stbc(u8 *__pdesc, u32  __val)
+static inline void set_tx_desc_tx_stbc(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, GENMASK(23, 22));
+	le32p_replace_bits(__pdesc + 4, __val, GENMASK(23, 22));
 }
 
-static inline void set_tx_desc_data_bw(u8 *__pdesc, u32  __val)
+static inline void set_tx_desc_data_bw(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, BIT(25));
+	le32p_replace_bits(__pdesc + 4, __val, BIT(25));
 }
 
-static inline void set_tx_desc_rts_short(u8 *__pdesc, u32  __val)
+static inline void set_tx_desc_rts_short(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, BIT(26));
+	le32p_replace_bits(__pdesc + 4, __val, BIT(26));
 }
 
-static inline void set_tx_desc_rts_bw(u8 *__pdesc, u32  __val)
+static inline void set_tx_desc_rts_bw(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, BIT(27));
+	le32p_replace_bits(__pdesc + 4, __val, BIT(27));
 }
 
-static inline void set_tx_desc_rts_sc(u8 *__pdesc, u32  __val)
+static inline void set_tx_desc_rts_sc(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, GENMASK(29, 28));
+	le32p_replace_bits(__pdesc + 4, __val, GENMASK(29, 28));
 }
 
-static inline void set_tx_desc_rts_stbc(u8 *__pdesc, u32  __val)
+static inline void set_tx_desc_rts_stbc(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, GENMASK(31, 30));
+	le32p_replace_bits(__pdesc + 4, __val, GENMASK(31, 30));
 }
 
-static inline void set_tx_desc_tx_rate(u8 *__pdesc, u32  __val)
+static inline void set_tx_desc_tx_rate(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 20), __val, GENMASK(5, 0));
+	le32p_replace_bits(__pdesc + 5, __val, GENMASK(5, 0));
 }
 
-static inline void set_tx_desc_data_shortgi(u8 *__pdesc, u32  __val)
+static inline void set_tx_desc_data_shortgi(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 20), __val, BIT(6));
+	le32p_replace_bits(__pdesc + 5, __val, BIT(6));
 }
 
-static inline void set_tx_desc_data_rate_fb_limit(u8 *__pdesc, u32  __val)
+static inline void set_tx_desc_data_rate_fb_limit(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 20), __val, GENMASK(12, 8));
+	le32p_replace_bits(__pdesc + 5, __val, GENMASK(12, 8));
 }
 
-static inline void set_tx_desc_rts_rate_fb_limit(u8 *__pdesc, u32  __val)
+static inline void set_tx_desc_rts_rate_fb_limit(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 20), __val, GENMASK(16, 13));
+	le32p_replace_bits(__pdesc + 5, __val, GENMASK(16, 13));
 }
 
-static inline void set_tx_desc_max_agg_num(u8 *__pdesc, u32  __val)
+static inline void set_tx_desc_max_agg_num(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 24), __val, GENMASK(15, 11));
+	le32p_replace_bits(__pdesc + 6, __val, GENMASK(15, 11));
 }
 
-static inline void set_tx_desc_antsel_c(u8 *__pdesc, u32  __val)
+static inline void set_tx_desc_antsel_c(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 28), __val, BIT(29));
+	le32p_replace_bits(__pdesc + 7, __val, BIT(29));
 }
 
-static inline void set_tx_desc_tx_buffer_size(u8 *__pdesc, u32  __val)
+static inline void set_tx_desc_tx_buffer_size(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 28), __val, GENMASK(15, 0));
+	le32p_replace_bits(__pdesc + 7, __val, GENMASK(15, 0));
 }
 
-static inline int get_tx_desc_tx_buffer_size(u8 *__pdesc)
+static inline int get_tx_desc_tx_buffer_size(__le32 *__pdesc)
 {
-	return le32_get_bits(*((__le32 *)(__pdesc + 28)), GENMASK(15, 0));
+	return le32_get_bits(*(__pdesc + 7), GENMASK(15, 0));
 }
 
-static inline void set_tx_desc_tx_buffer_address(u8 *__pdesc, u32  __val)
+static inline void set_tx_desc_tx_buffer_address(__le32 *__pdesc, u32 __val)
 {
-	*(__le32 *)(__pdesc + 32) = cpu_to_le32(__val);
+	*(__pdesc + 8) = cpu_to_le32(__val);
 }
 
-static inline int get_tx_desc_tx_buffer_address(u8 *__pdesc)
+static inline int get_tx_desc_tx_buffer_address(__le32 *__pdesc)
 {
-	return le32_to_cpu(*((__le32 *)(__pdesc + 32)));
+	return le32_to_cpu(*(__pdesc + 8));
 }
 
-static inline void set_tx_desc_next_desc_address(u8 *__pdesc, u32  __val)
+static inline void set_tx_desc_next_desc_address(__le32 *__pdesc, u32 __val)
 {
-	*(__le32 *)(__pdesc + 40) = cpu_to_le32(__val);
+	*(__pdesc + 10) = cpu_to_le32(__val);
 }
 
-static inline int get_rx_desc_pkt_len(u8 *__pdesc)
+static inline int get_rx_desc_pkt_len(__le32 *__pdesc)
 {
-	return le32_get_bits(*((__le32 *)__pdesc), GENMASK(13, 0));
+	return le32_get_bits(*(__pdesc), GENMASK(13, 0));
 }
 
-static inline int get_rx_desc_crc32(u8 *__pdesc)
+static inline int get_rx_desc_crc32(__le32 *__pdesc)
 {
-	return le32_get_bits(*((__le32 *)__pdesc), BIT(14));
+	return le32_get_bits(*(__pdesc), BIT(14));
 }
 
-static inline int get_rx_desc_icv(u8 *__pdesc)
+static inline int get_rx_desc_icv(__le32 *__pdesc)
 {
-	return le32_get_bits(*((__le32 *)__pdesc), BIT(15));
+	return le32_get_bits(*(__pdesc), BIT(15));
 }
 
-static inline int get_rx_desc_drv_info_size(u8 *__pdesc)
+static inline int get_rx_desc_drv_info_size(__le32 *__pdesc)
 {
-	return le32_get_bits(*((__le32 *)__pdesc), GENMASK(19, 16));
+	return le32_get_bits(*(__pdesc), GENMASK(19, 16));
 }
 
-static inline int get_rx_desc_security(u8 *__pdesc)
+static inline int get_rx_desc_security(__le32 *__pdesc)
 {
-	return le32_get_bits(*((__le32 *)__pdesc), GENMASK(22, 20));
+	return le32_get_bits(*(__pdesc), GENMASK(22, 20));
 }
 
-static inline int get_rx_desc_qos(u8 *__pdesc)
+static inline int get_rx_desc_qos(__le32 *__pdesc)
 {
-	return le32_get_bits(*((__le32 *)__pdesc), BIT(23));
+	return le32_get_bits(*(__pdesc), BIT(23));
 }
 
-static inline int get_rx_desc_shift(u8 *__pdesc)
+static inline int get_rx_desc_shift(__le32 *__pdesc)
 {
-	return le32_get_bits(*((__le32 *)__pdesc), GENMASK(25, 24));
+	return le32_get_bits(*(__pdesc), GENMASK(25, 24));
 }
 
-static inline int get_rx_desc_physt(u8 *__pdesc)
+static inline int get_rx_desc_physt(__le32 *__pdesc)
 {
-	return le32_get_bits(*((__le32 *)__pdesc), BIT(26));
+	return le32_get_bits(*(__pdesc), BIT(26));
 }
 
-static inline int get_rx_desc_swdec(u8 *__pdesc)
+static inline int get_rx_desc_swdec(__le32 *__pdesc)
 {
-	return le32_get_bits(*((__le32 *)__pdesc), BIT(27));
+	return le32_get_bits(*(__pdesc), BIT(27));
 }
 
-static inline int get_rx_desc_ls(u8 *__pdesc)
+static inline int get_rx_desc_ls(__le32 *__pdesc)
 {
-	return le32_get_bits(*((__le32 *)__pdesc), BIT(28));
+	return le32_get_bits(*(__pdesc), BIT(28));
 }
 
-static inline int get_rx_desc_fs(u8 *__pdesc)
+static inline int get_rx_desc_fs(__le32 *__pdesc)
 {
-	return le32_get_bits(*((__le32 *)__pdesc), BIT(29));
+	return le32_get_bits(*(__pdesc), BIT(29));
 }
 
-static inline int get_rx_desc_eor(u8 *__pdesc)
+static inline int get_rx_desc_eor(__le32 *__pdesc)
 {
-	return le32_get_bits(*((__le32 *)__pdesc), BIT(30));
+	return le32_get_bits(*(__pdesc), BIT(30));
 }
 
-static inline int get_rx_desc_own(u8 *__pdesc)
+static inline int get_rx_desc_own(__le32 *__pdesc)
 {
-	return le32_get_bits(*((__le32 *)__pdesc), BIT(31));
+	return le32_get_bits(*(__pdesc), BIT(31));
 }
 
-static inline void set_rx_desc_pkt_len(u8 *__pdesc, u32  __val)
+static inline void set_rx_desc_pkt_len(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)__pdesc, __val, GENMASK(13, 0));
+	le32p_replace_bits(__pdesc, __val, GENMASK(13, 0));
 }
 
-static inline void set_rx_desc_eor(u8 *__pdesc, u32  __val)
+static inline void set_rx_desc_eor(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)__pdesc, __val, BIT(30));
+	le32p_replace_bits(__pdesc, __val, BIT(30));
 }
 
-static inline void set_rx_desc_own(u8 *__pdesc, u32  __val)
+static inline void set_rx_desc_own(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)__pdesc, __val, BIT(31));
+	le32p_replace_bits(__pdesc, __val, BIT(31));
 }
 
-static inline int get_rx_desc_macid(u8 *__pdesc)
+static inline int get_rx_desc_macid(__le32 *__pdesc)
 {
-	return le32_get_bits(*((__le32 *)(__pdesc + 4)), GENMASK(5, 0));
+	return le32_get_bits(*(__pdesc + 1), GENMASK(5, 0));
 }
 
-static inline int get_rx_desc_paggr(u8 *__pdesc)
+static inline int get_rx_desc_paggr(__le32 *__pdesc)
 {
-	return le32_get_bits(*((__le32 *)(__pdesc + 4)), BIT(14));
+	return le32_get_bits(*(__pdesc + 1), BIT(14));
 }
 
-static inline int get_rx_desc_faggr(u8 *__pdesc)
+static inline int get_rx_desc_faggr(__le32 *__pdesc)
 {
-	return le32_get_bits(*((__le32 *)(__pdesc + 4)), BIT(15));
+	return le32_get_bits(*(__pdesc + 1), BIT(15));
 }
 
-static inline int get_rx_desc_a1_fit(u8 *__pdesc)
+static inline int get_rx_desc_a1_fit(__le32 *__pdesc)
 {
-	return le32_get_bits(*((__le32 *)(__pdesc + 4)), GENMASK(19, 16));
+	return le32_get_bits(*(__pdesc + 1), GENMASK(19, 16));
 }
 
-static inline int get_rx_desc_a2_fit(u8 *__pdesc)
+static inline int get_rx_desc_a2_fit(__le32 *__pdesc)
 {
-	return le32_get_bits(*((__le32 *)(__pdesc + 4)), GENMASK(23, 20));
+	return le32_get_bits(*(__pdesc + 1), GENMASK(23, 20));
 }
 
-static inline int get_rx_desc_pam(u8 *__pdesc)
+static inline int get_rx_desc_pam(__le32 *__pdesc)
 {
-	return le32_get_bits(*((__le32 *)(__pdesc + 4)), BIT(24));
+	return le32_get_bits(*(__pdesc + 1), BIT(24));
 }
 
-static inline int get_rx_desc_pwr(u8 *__pdesc)
+static inline int get_rx_desc_pwr(__le32 *__pdesc)
 {
-	return le32_get_bits(*((__le32 *)(__pdesc + 4)), BIT(25));
+	return le32_get_bits(*(__pdesc + 1), BIT(25));
 }
 
-static inline int get_rx_desc_md(u8 *__pdesc)
+static inline int get_rx_desc_md(__le32 *__pdesc)
 {
-	return le32_get_bits(*((__le32 *)(__pdesc + 4)), BIT(26));
+	return le32_get_bits(*(__pdesc + 1), BIT(26));
 }
 
-static inline int get_rx_desc_mf(u8 *__pdesc)
+static inline int get_rx_desc_mf(__le32 *__pdesc)
 {
-	return le32_get_bits(*((__le32 *)(__pdesc + 4)), BIT(27));
+	return le32_get_bits(*(__pdesc + 1), BIT(27));
 }
 
-static inline int get_rx_desc_type(u8 *__pdesc)
+static inline int get_rx_desc_type(__le32 *__pdesc)
 {
-	return le32_get_bits(*((__le32 *)(__pdesc + 4)), GENMASK(29, 28));
+	return le32_get_bits(*(__pdesc + 1), GENMASK(29, 28));
 }
 
-static inline int get_rx_desc_mc(u8 *__pdesc)
+static inline int get_rx_desc_mc(__le32 *__pdesc)
 {
-	return le32_get_bits(*((__le32 *)(__pdesc + 4)), BIT(30));
+	return le32_get_bits(*(__pdesc + 1), BIT(30));
 }
 
-static inline int get_rx_desc_bc(u8 *__pdesc)
+static inline int get_rx_desc_bc(__le32 *__pdesc)
 {
-	return le32_get_bits(*((__le32 *)(__pdesc + 4)), BIT(31));
+	return le32_get_bits(*(__pdesc + 1), BIT(31));
 }
 
-static inline int get_rx_desc_seq(u8 *__pdesc)
+static inline int get_rx_desc_seq(__le32 *__pdesc)
 {
-	return le32_get_bits(*((__le32 *)(__pdesc + 8)), GENMASK(11, 0));
+	return le32_get_bits(*(__pdesc + 2), GENMASK(11, 0));
 }
 
-static inline int get_rx_desc_frag(u8 *__pdesc)
+static inline int get_rx_desc_frag(__le32 *__pdesc)
 {
-	return le32_get_bits(*((__le32 *)(__pdesc + 8)), GENMASK(15, 12));
+	return le32_get_bits(*(__pdesc + 2), GENMASK(15, 12));
 }
 
-static inline int get_rx_desc_rxmcs(u8 *__pdesc)
+static inline int get_rx_desc_rxmcs(__le32 *__pdesc)
 {
-	return le32_get_bits(*((__le32 *)(__pdesc + 12)), GENMASK(5, 0));
+	return le32_get_bits(*(__pdesc + 3), GENMASK(5, 0));
 }
 
-static inline int get_rx_desc_rxht(u8 *__pdesc)
+static inline int get_rx_desc_rxht(__le32 *__pdesc)
 {
-	return le32_get_bits(*((__le32 *)(__pdesc + 12)), BIT(6));
+	return le32_get_bits(*(__pdesc + 3), BIT(6));
 }
 
-static inline int get_rx_status_desc_rx_gf(u8 *__pdesc)
+static inline int get_rx_status_desc_rx_gf(__le32 *__pdesc)
 {
-	return le32_get_bits(*((__le32 *)(__pdesc + 12)), BIT(7));
+	return le32_get_bits(*(__pdesc + 3), BIT(7));
 }
 
-static inline int get_rx_desc_splcp(u8 *__pdesc)
+static inline int get_rx_desc_splcp(__le32 *__pdesc)
 {
-	return le32_get_bits(*((__le32 *)(__pdesc + 12)), BIT(8));
+	return le32_get_bits(*(__pdesc + 3), BIT(8));
 }
 
-static inline int get_rx_desc_bw(u8 *__pdesc)
+static inline int get_rx_desc_bw(__le32 *__pdesc)
 {
-	return le32_get_bits(*((__le32 *)(__pdesc + 12)), BIT(9));
+	return le32_get_bits(*(__pdesc + 3), BIT(9));
 }
 
-static inline int get_rx_desc_htc(u8 *__pdesc)
+static inline int get_rx_desc_htc(__le32 *__pdesc)
 {
-	return le32_get_bits(*((__le32 *)(__pdesc + 12)), BIT(10));
+	return le32_get_bits(*(__pdesc + 3), BIT(10));
 }
 
-static inline int get_rx_status_desc_eosp(u8 *__pdesc)
+static inline int get_rx_status_desc_eosp(__le32 *__pdesc)
 {
-	return le32_get_bits(*((__le32 *)(__pdesc + 12)), BIT(11));
+	return le32_get_bits(*(__pdesc + 3), BIT(11));
 }
 
-static inline int get_rx_status_desc_bssid_fit(u8 *__pdesc)
+static inline int get_rx_status_desc_bssid_fit(__le32 *__pdesc)
 {
-	return le32_get_bits(*((__le32 *)(__pdesc + 12)), GENMASK(13, 12));
+	return le32_get_bits(*(__pdesc + 3), GENMASK(13, 12));
 }
 
-static inline int get_rx_status_desc_rpt_sel(u8 *__pdesc)
+static inline int get_rx_status_desc_rpt_sel(__le32 *__pdesc)
 {
-	return le32_get_bits(*((__le32 *)(__pdesc + 12)), GENMASK(15, 14));
+	return le32_get_bits(*(__pdesc + 3), GENMASK(15, 14));
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
 
-static inline int get_rx_desc_iv1(u8 *__pdesc)
+static inline int get_rx_desc_iv1(__le32 *__pdesc)
 {
-	return le32_to_cpu(*((__le32 *)(__pdesc + 16)));
+	return le32_to_cpu(*(__pdesc + 4));
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
 
-static inline int get_rx_desc_buff_addr64(u8 *__pdesc)
+static inline int get_rx_desc_buff_addr64(__le32 *__pdesc)
 {
-	return le32_to_cpu(*((__le32 *)(__pdesc + 28)));
+	return le32_to_cpu(*(__pdesc + 7));
 }
 
-static inline void set_rx_desc_buff_addr(u8 *__pdesc, u32  __val)
+static inline void set_rx_desc_buff_addr(__le32 *__pdesc, u32 __val)
 {
-	*(__le32 *)(__pdesc + 24) = cpu_to_le32(__val);
+	*(__pdesc + 6) = cpu_to_le32(__val);
 }
 
-static inline void set_rx_desc_buff_addr64(u8 *__pdesc, u32  __val)
+static inline void set_rx_desc_buff_addr64(__le32 *__pdesc, u32 __val)
 {
-	*(__le32 *)(__pdesc + 28) = cpu_to_le32(__val);
+	*(__pdesc + 7) = cpu_to_le32(__val);
 }
 
 /* TX report 2 format in Rx desc*/
 
-static inline int get_rx_rpt2_desc_pkt_len(u8 *__status)
+static inline int get_rx_rpt2_desc_pkt_len(__le32 *__status)
 {
-	return le32_get_bits(*((__le32 *)__status), GENMASK(8, 0));
+	return le32_get_bits(*(__status), GENMASK(8, 0));
 }
 
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
 
-static inline void set_earlymode_pktnum(u8 *__paddr, u32  __value)
+static inline void set_earlymode_pktnum(__le32 *__paddr, u32 __value)
 {
-	le32p_replace_bits((__le32 *)__paddr, __value, GENMASK(3, 0));
+	le32p_replace_bits(__paddr, __value, GENMASK(3, 0));
 }
 
-static inline void set_earlymode_len0(u8 *__paddr, u32  __value)
+static inline void set_earlymode_len0(__le32 *__paddr, u32 __value)
 {
-	le32p_replace_bits((__le32 *)__paddr, __value, GENMASK(15, 4));
+	le32p_replace_bits(__paddr, __value, GENMASK(15, 4));
 }
 
-static inline void set_earlymode_len1(u8 *__paddr, u32  __value)
+static inline void set_earlymode_len1(__le32 *__paddr, u32 __value)
 {
-	le32p_replace_bits((__le32 *)__paddr, __value, GENMASK(27, 16));
+	le32p_replace_bits(__paddr, __value, GENMASK(27, 16));
 }
 
-static inline void set_earlymode_len2_1(u8 *__paddr, u32  __value)
+static inline void set_earlymode_len2_1(__le32 *__paddr, u32 __value)
 {
-	le32p_replace_bits((__le32 *)__paddr, __value, GENMASK(31, 28));
+	le32p_replace_bits(__paddr, __value, GENMASK(31, 28));
 }
 
-static inline void set_earlymode_len2_2(u8 *__paddr, u32  __value)
+static inline void set_earlymode_len2_2(__le32 *__paddr, u32 __value)
 {
-	le32p_replace_bits((__le32 *)(__paddr + 4), __value, GENMASK(7, 0));
+	le32p_replace_bits(__paddr + 1, __value, GENMASK(7, 0));
 }
 
-static inline void set_earlymode_len3(u8 *__paddr, u32  __value)
+static inline void set_earlymode_len3(__le32 *__paddr, u32 __value)
 {
-	le32p_replace_bits((__le32 *)(__paddr + 4), __value, GENMASK(19, 8));
+	le32p_replace_bits(__paddr + 1, __value, GENMASK(19, 8));
 }
 
-static inline void set_earlymode_len4(u8 *__paddr, u32  __value)
+static inline void set_earlymode_len4(__le32 *__paddr, u32 __value)
 {
-	le32p_replace_bits((__le32 *)(__paddr + 4), __value, GENMASK(31, 20));
+	le32p_replace_bits(__paddr + 1, __value, GENMASK(31, 20));
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
 
 #define RTL8188_RX_HAL_IS_CCK_RATE(rxmcs)\
 	(rxmcs == DESC92C_RATE1M ||\
-- 
2.22.0

