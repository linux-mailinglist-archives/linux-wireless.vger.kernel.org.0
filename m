Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7599AD1BC
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2019 04:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732693AbfIICAH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 8 Sep 2019 22:00:07 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:42606 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732681AbfIICAG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 8 Sep 2019 22:00:06 -0400
Received: by mail-ot1-f68.google.com with SMTP id c10so10939910otd.9
        for <linux-wireless@vger.kernel.org>; Sun, 08 Sep 2019 19:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cuVjQCqIEkGYlqSm61X7y3W30KshfT+zQU4R7HnGAEA=;
        b=MJMEtjL7inTkhOteKM+vN7dtaWj1/4S5w/rqelfFE85VFj8rWwm6Nigvg+lOnf9/OR
         YV2Pa4d8tBnHIfkue+qxFTzGkbGWg4qdeI78IFuMlOrGR2se9ZO40Kd25dda68RZRbhI
         zo96rmBUazH08GzbYF9iSMO3ET5MlufOtNBnicNwHj7Z/gEacXnXDIJz/+7NLhjMYaN0
         c1bO0QGMGVUoG24Kwb6Tg+go/4pzV+du3Hj56l78MaENqYURhpoqiSd3eO6P9ngX4U8M
         zOuHgtr354KOwEFsfG9D7KyT6Qa1SxVy8Gcr/qzsBCa7lfOkLkDmCbc6YU1RrTifSj0D
         HnFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=cuVjQCqIEkGYlqSm61X7y3W30KshfT+zQU4R7HnGAEA=;
        b=VvVsyVqGspwOw9G9W0bfmch5PZcES2vOpEOS5V7Y1y6znX5bot57kAXWcG03EfcCeu
         Qe9zjajtupkx4ITPARCzRJkRm0+9boemlsUNbtsQDfrfZUkOgjJh34kFXM4Lcg0vBmTk
         AVpQdIAh8nPEKjWIF1jraDPZPTR9BCQ881LhUPFucvDlvmEEK7liVuZHMsqhPkkx6GFO
         UduRSo60ZTTiFoND9BY0XI94yGBUOaeSiy+BNg1G8/JKwMMbUremUoAIBmA0NRIIz76P
         FGuajmMBaTQl9tWdXsQ8Z6f0J5HFPhxz1TdynI1Kn5OEqei+8+eaw0+p8pdkJXEzn7GQ
         eJmA==
X-Gm-Message-State: APjAAAUZUjqnxyzDLBRD/5IYc6aHLsOGXOMK0AgsV/tU6QHQZGDCog98
        ko8Lxf5fFrQoQWPeVSs86hw=
X-Google-Smtp-Source: APXvYqy26FUXTUjezQqXDjufgFc/LHOX+7V0AOmBA1BaRQXK17NZxBoUoUEbJkgymh/ZXhkLGsHnmA==
X-Received: by 2002:a9d:5911:: with SMTP id t17mr16707086oth.1.1567994405165;
        Sun, 08 Sep 2019 19:00:05 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id k10sm1468420oij.16.2019.09.08.19.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2019 19:00:04 -0700 (PDT)
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, pkshih@realtek.com,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH v2 4/9] rtlwifi: rtl8723ae: Convert inline routines to little-endian words
Date:   Sun,  8 Sep 2019 20:59:53 -0500
Message-Id: <20190909015958.29834-5-Larry.Finger@lwfinger.net>
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
v2 - no changes
---
 .../wireless/realtek/rtlwifi/rtl8723ae/trx.c  |  24 +-
 .../wireless/realtek/rtlwifi/rtl8723ae/trx.h  | 250 +++++++++---------
 2 files changed, 140 insertions(+), 134 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/trx.c b/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/trx.c
index 84557ce07f38..a04ce15d5538 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/trx.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/trx.c
@@ -260,10 +260,11 @@ static void translate_rx_signal_stuff(struct ieee80211_hw *hw,
 bool rtl8723e_rx_query_desc(struct ieee80211_hw *hw,
 			    struct rtl_stats *status,
 			    struct ieee80211_rx_status *rx_status,
-			    u8 *pdesc, struct sk_buff *skb)
+			    u8 *pdesc8, struct sk_buff *skb)
 {
 	struct rx_fwinfo_8723e *p_drvinfo;
 	struct ieee80211_hdr *hdr;
+	__le32 *pdesc = (__le32 *)pdesc8;
 	u32 phystatus = get_rx_desc_physt(pdesc);
 
 	status->length = (u16)get_rx_desc_pkt_len(pdesc);
@@ -331,7 +332,7 @@ bool rtl8723e_rx_query_desc(struct ieee80211_hw *hw,
 		p_drvinfo = (struct rx_fwinfo_8723e *)(skb->data +
 						     status->rx_bufshift);
 
-		translate_rx_signal_stuff(hw, skb, status, pdesc, p_drvinfo);
+		translate_rx_signal_stuff(hw, skb, status, pdesc8, p_drvinfo);
 	}
 	rx_status->signal = status->recvsignalpower + 10;
 	return true;
@@ -350,7 +351,8 @@ void rtl8723e_tx_fill_desc(struct ieee80211_hw *hw,
 	struct rtl_ps_ctl *ppsc = rtl_psc(rtl_priv(hw));
 	bool b_defaultadapter = true;
 	/* bool b_trigger_ac = false; */
-	u8 *pdesc = (u8 *)pdesc_tx;
+	u8 *pdesc8 = (u8 *)pdesc_tx;
+	__le32 *pdesc = (__le32 *)pdesc8;
 	u16 seq_number;
 	__le16 fc = hdr->frame_control;
 	u8 fw_qsel = _rtl8723e_map_hwqueue_to_fwqueue(skb, hw_queue);
@@ -383,7 +385,7 @@ void rtl8723e_tx_fill_desc(struct ieee80211_hw *hw,
 
 	rtl_get_tcb_desc(hw, info, sta, skb, ptcb_desc);
 
-	CLEAR_PCI_TX_DESC_CONTENT(pdesc, sizeof(struct tx_desc_8723e));
+	clear_pci_tx_desc_content(pdesc, sizeof(struct tx_desc_8723e));
 
 	if (ieee80211_is_nullfunc(fc) || ieee80211_is_ctl(fc)) {
 		firstseg = true;
@@ -519,12 +521,13 @@ void rtl8723e_tx_fill_desc(struct ieee80211_hw *hw,
 }
 
 void rtl8723e_tx_fill_cmddesc(struct ieee80211_hw *hw,
-			      u8 *pdesc, bool firstseg,
+			      u8 *pdesc8, bool firstseg,
 			      bool lastseg, struct sk_buff *skb)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	struct rtl_pci *rtlpci = rtl_pcidev(rtl_pcipriv(hw));
 	u8 fw_queue = QSLT_BEACON;
+	__le32 *pdesc = (__le32 *)pdesc8;
 
 	dma_addr_t mapping = pci_map_single(rtlpci->pdev,
 					    skb->data, skb->len,
@@ -538,7 +541,7 @@ void rtl8723e_tx_fill_cmddesc(struct ieee80211_hw *hw,
 			 "DMA mapping error\n");
 		return;
 	}
-	CLEAR_PCI_TX_DESC_CONTENT(pdesc, TX_DESC_SIZE);
+	clear_pci_tx_desc_content(pdesc, TX_DESC_SIZE);
 
 	if (firstseg)
 		set_tx_desc_offset(pdesc, USB_HWDESC_HEADER_LEN);
@@ -563,7 +566,7 @@ void rtl8723e_tx_fill_cmddesc(struct ieee80211_hw *hw,
 
 	set_tx_desc_own(pdesc, 1);
 
-	set_tx_desc_pkt_size((u8 *)pdesc, (u16)(skb->len));
+	set_tx_desc_pkt_size(pdesc, (u16)(skb->len));
 
 	set_tx_desc_first_seg(pdesc, 1);
 	set_tx_desc_last_seg(pdesc, 1);
@@ -583,9 +586,11 @@ void rtl8723e_tx_fill_cmddesc(struct ieee80211_hw *hw,
 		      pdesc, TX_DESC_SIZE);
 }
 
-void rtl8723e_set_desc(struct ieee80211_hw *hw, u8 *pdesc,
+void rtl8723e_set_desc(struct ieee80211_hw *hw, u8 *pdesc8,
 		       bool istx, u8 desc_name, u8 *val)
 {
+	__le32 *pdesc = (__le32 *)pdesc8;
+
 	if (istx == true) {
 		switch (desc_name) {
 		case HW_DESC_OWN:
@@ -622,9 +627,10 @@ void rtl8723e_set_desc(struct ieee80211_hw *hw, u8 *pdesc,
 }
 
 u64 rtl8723e_get_desc(struct ieee80211_hw *hw,
-		      u8 *pdesc, bool istx, u8 desc_name)
+		      u8 *pdesc8, bool istx, u8 desc_name)
 {
 	u32 ret = 0;
+	__le32 *pdesc = (__le32 *)pdesc8;
 
 	if (istx == true) {
 		switch (desc_name) {
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/trx.h b/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/trx.h
index 156f0f56a7b5..2d25f62a4d52 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/trx.h
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/trx.h
@@ -14,318 +14,318 @@
 #define USB_HWDESC_HEADER_LEN			32
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
 
-static inline u32 get_tx_desc_own(u8 *__pdesc)
+static inline u32 get_tx_desc_own(__le32 *__pdesc)
 {
-	return le32_get_bits(*(__le32 *)__pdesc, BIT(31));
+	return le32_get_bits(*__pdesc, BIT(31));
 }
 
-static inline void set_tx_desc_macid(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_macid(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 4), __val, GENMASK(4, 0));
+	le32p_replace_bits((__pdesc + 1), __val, GENMASK(4, 0));
 }
 
-static inline void set_tx_desc_agg_break(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_agg_break(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 4), __val, BIT(5));
+	le32p_replace_bits((__pdesc + 1), __val, BIT(5));
 }
 
-static inline void set_tx_desc_rdg_enable(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_rdg_enable(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 4), __val, BIT(7));
+	le32p_replace_bits((__pdesc + 1), __val, BIT(7));
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
-	le32p_replace_bits((__le32 *)(__pdesc + 4), __val, GENMASK(19, 16));
+	le32p_replace_bits((__pdesc + 1), __val, GENMASK(19, 16));
 }
 
-static inline void set_tx_desc_sec_type(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_sec_type(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 4), __val, GENMASK(23, 22));
+	le32p_replace_bits((__pdesc + 1), __val, GENMASK(23, 22));
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
 
-static inline void set_tx_desc_seq(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_seq(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 12), __val, GENMASK(27, 16));
+	le32p_replace_bits((__pdesc + 3), __val, GENMASK(27, 16));
 }
 
-static inline void set_tx_desc_pkt_id(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_pkt_id(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 12), __val, GENMASK(31, 28));
+	le32p_replace_bits((__pdesc + 3), __val, GENMASK(31, 28));
 }
 
 /* For RTL8723 */
-static inline void set_tx_desc_hwseq_en_8723(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_hwseq_en_8723(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 12), __val, BIT(31));
+	le32p_replace_bits((__pdesc + 3), __val, BIT(31));
 }
 
-static inline void set_tx_desc_hwseq_sel_8723(u8 *__txdesc, u32 __value)
+static inline void set_tx_desc_hwseq_sel_8723(__le32 *__txdesc, u32 __value)
 {
-	le32p_replace_bits((__le32 *)(__txdesc + 16), __value, GENMASK(7, 6));
+	le32p_replace_bits((__txdesc + 4), __value, GENMASK(7, 6));
 }
 
-static inline void set_tx_desc_rts_rate(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_rts_rate(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, GENMASK(4, 0));
+	le32p_replace_bits((__pdesc + 4), __val, GENMASK(4, 0));
 }
 
-static inline void set_tx_desc_use_rate(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_use_rate(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, BIT(8));
+	le32p_replace_bits((__pdesc + 4), __val, BIT(8));
 }
 
-static inline void set_tx_desc_disable_fb(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_disable_fb(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, BIT(10));
+	le32p_replace_bits((__pdesc + 4), __val, BIT(10));
 }
 
-static inline void set_tx_desc_cts2self(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_cts2self(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, BIT(11));
+	le32p_replace_bits((__pdesc + 4), __val, BIT(11));
 }
 
-static inline void set_tx_desc_rts_enable(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_rts_enable(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, BIT(12));
+	le32p_replace_bits((__pdesc + 4), __val, BIT(12));
 }
 
-static inline void set_tx_desc_hw_rts_enable(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_hw_rts_enable(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, BIT(13));
+	le32p_replace_bits((__pdesc + 4), __val, BIT(13));
 }
 
-static inline void set_tx_desc_tx_sub_carrier(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_tx_sub_carrier(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, GENMASK(21, 20));
+	le32p_replace_bits((__pdesc + 4), __val, GENMASK(21, 20));
 }
 
-static inline void set_tx_desc_data_bw(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_data_bw(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, BIT(25));
+	le32p_replace_bits((__pdesc + 4), __val, BIT(25));
 }
 
-static inline void set_tx_desc_rts_short(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_rts_short(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, BIT(26));
+	le32p_replace_bits((__pdesc + 4), __val, BIT(26));
 }
 
-static inline void set_tx_desc_rts_bw(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_rts_bw(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, BIT(27));
+	le32p_replace_bits((__pdesc + 4), __val, BIT(27));
 }
 
-static inline void set_tx_desc_rts_sc(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_rts_sc(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, GENMASK(29, 28));
+	le32p_replace_bits((__pdesc + 4), __val, GENMASK(29, 28));
 }
 
-static inline void set_tx_desc_rts_stbc(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_rts_stbc(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, GENMASK(31, 30));
+	le32p_replace_bits((__pdesc + 4), __val, GENMASK(31, 30));
 }
 
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
 
-static inline void set_tx_desc_data_rate_fb_limit(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_data_rate_fb_limit(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 20), __val, GENMASK(12, 8));
+	le32p_replace_bits((__pdesc + 5), __val, GENMASK(12, 8));
 }
 
-static inline void set_tx_desc_rts_rate_fb_limit(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_rts_rate_fb_limit(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 20), __val, GENMASK(16, 13));
+	le32p_replace_bits((__pdesc + 5), __val, GENMASK(16, 13));
 }
 
-static inline void set_tx_desc_max_agg_num(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_max_agg_num(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 24), __val, GENMASK(15, 11));
+	le32p_replace_bits((__pdesc + 6), __val, GENMASK(15, 11));
 }
 
-static inline void set_tx_desc_tx_buffer_size(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_tx_buffer_size(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 28), __val, GENMASK(15, 0));
+	le32p_replace_bits((__pdesc + 7), __val, GENMASK(15, 0));
 }
 
-static inline void set_tx_desc_tx_buffer_address(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_tx_buffer_address(__le32 *__pdesc, u32 __val)
 {
-	*(__le32 *)(__pdesc + 32) = cpu_to_le32(__val);
+	*(__pdesc + 8) = cpu_to_le32(__val);
 }
 
-static inline u32 get_tx_desc_tx_buffer_address(u8 *__pdesc)
+static inline u32 get_tx_desc_tx_buffer_address(__le32 *__pdesc)
 {
-	return le32_to_cpu(*(__le32 *)(__pdesc + 32));
+	return le32_to_cpu(*(__pdesc + 8));
 }
 
-static inline void set_tx_desc_next_desc_address(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_next_desc_address(__le32 *__pdesc, u32 __val)
 {
-	*(__le32 *)(__pdesc + 40) = cpu_to_le32(__val);
+	*(__pdesc + 10) = cpu_to_le32(__val);
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
 
-static inline u32 get_rx_desc_paggr(u8 *__pdesc)
+static inline u32 get_rx_desc_paggr(__le32 *__pdesc)
 {
-	return le32_get_bits(*(__le32 *)(__pdesc + 4), BIT(14));
+	return le32_get_bits(*(__pdesc + 1), BIT(14));
 }
 
-static inline u32 get_rx_desc_faggr(u8 *__pdesc)
+static inline u32 get_rx_desc_faggr(__le32 *__pdesc)
 {
-	return le32_get_bits(*(__le32 *)(__pdesc + 4), BIT(15));
+	return le32_get_bits(*(__pdesc + 1), BIT(15));
 }
 
-static inline u32 get_rx_desc_rxmcs(u8 *__pdesc)
+static inline u32 get_rx_desc_rxmcs(__le32 *__pdesc)
 {
-	return le32_get_bits(*(__le32 *)(__pdesc + 12), GENMASK(5, 0));
+	return le32_get_bits(*(__pdesc + 3), GENMASK(5, 0));
 }
 
-static inline u32 get_rx_desc_rxht(u8 *__pdesc)
+static inline u32 get_rx_desc_rxht(__le32 *__pdesc)
 {
-	return le32_get_bits(*(__le32 *)(__pdesc + 12), BIT(6));
+	return le32_get_bits(*(__pdesc + 3), BIT(6));
 }
 
-static inline u32 get_rx_desc_splcp(u8 *__pdesc)
+static inline u32 get_rx_desc_splcp(__le32 *__pdesc)
 {
-	return le32_get_bits(*(__le32 *)(__pdesc + 12), BIT(8));
+	return le32_get_bits(*(__pdesc + 3), BIT(8));
 }
 
-static inline u32 get_rx_desc_bw(u8 *__pdesc)
+static inline u32 get_rx_desc_bw(__le32 *__pdesc)
 {
-	return le32_get_bits(*(__le32 *)(__pdesc + 12), BIT(9));
+	return le32_get_bits(*(__pdesc + 3), BIT(9));
 }
 
-static inline u32 get_rx_desc_tsfl(u8 *__pdesc)
+static inline u32 get_rx_desc_tsfl(__le32 *__pdesc)
 {
-	return le32_to_cpu(*(__le32 *)(__pdesc + 20));
+	return le32_to_cpu(*(__pdesc + 5));
 }
 
-static inline u32 get_rx_desc_buff_addr(u8 *__pdesc)
+static inline u32 get_rx_desc_buff_addr(__le32 *__pdesc)
 {
-	return le32_to_cpu(*(__le32 *)(__pdesc + 24));
+	return le32_to_cpu(*(__pdesc + 6));
 }
 
-static inline void set_rx_desc_buff_addr(u8 *__pdesc, u32 __val)
+static inline void set_rx_desc_buff_addr(__le32 *__pdesc, u32 __val)
 {
-	*(__le32 *)(__pdesc + 24) = cpu_to_le32(__val);
+	*(__pdesc + 6) = cpu_to_le32(__val);
 }
 
-static inline void CLEAR_PCI_TX_DESC_CONTENT(u8 *__pdesc, u32 _size)
+static inline void clear_pci_tx_desc_content(__le32 *__pdesc, u32 _size)
 {
 	if (_size > TX_DESC_NEXT_DESC_OFFSET)
 		memset(__pdesc, 0, TX_DESC_NEXT_DESC_OFFSET);
-- 
2.23.0

