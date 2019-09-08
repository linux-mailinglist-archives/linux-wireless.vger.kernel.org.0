Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF61FACA89
	for <lists+linux-wireless@lfdr.de>; Sun,  8 Sep 2019 06:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbfIHEDp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 8 Sep 2019 00:03:45 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:43276 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbfIHEDo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 8 Sep 2019 00:03:44 -0400
Received: by mail-oi1-f193.google.com with SMTP id t84so8093036oih.10
        for <linux-wireless@vger.kernel.org>; Sat, 07 Sep 2019 21:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZMKl4LX+cWLZTI3NXiHFdqtsN5xw5tho6N5gr1kqUvg=;
        b=Z8Fc8VYaP8RXudrNYA7EfWop3xWlv2nG8qJEao+h24Ux6545fynagE7I+aJyUxIiVj
         mOg2S2tS4XUpwgPY3Zvrpy/F4/w5OGaZstt037qE5yU/MZRsjYMXFUs0uagPOsMQS4E/
         Ho00SSv1ft7K3SRcYYumdyF/8KrTv4OPpT2ltYYAssi1oeZ4y665jUOc9fmRYdmlOSkH
         9P5m1BcoNMxpnhQL2uGqL2x2pVBmCFCLSxxQNOdeO/hyBOFj3Stic25lQvYNxIDeU7E+
         P7CJBzQNepuYvFZMpu0YdPM5eddXBB/hsYTxoo0GvMjETHpQoQToH7i7AFU9PMt0rsEk
         Kjbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=ZMKl4LX+cWLZTI3NXiHFdqtsN5xw5tho6N5gr1kqUvg=;
        b=OW3pkjN3yH/ml4AjpvWQkk+bfstbOSKw77W4h4ZUvecAYvm44+6M36Oc5buIHsM/0O
         JCw+KofGbhT/o0Q1xKLUFsqCnxWRJtpj55sUJ1+BxPrXuR+cT29tgMdz48VKu2vZt8Dm
         6ITAzqiiCDT71Tai4NQsax7uOMlkdYY43Ro+JQ7OcIqNfJLW4Ez6pYYQC4ab1uyN51Lc
         V0H74vU95ZSN8z/qOHWY8JE8esmA8JVku3jpyeFNqFxxgIZnZPwJp/8ParLQJLthfNLw
         8RYcZOLQkopfTbMrHQDxOmagleSssr+O7q8SxUXOCmM9eu0cbdDwTQvED/EMwT2JviPL
         2/Yw==
X-Gm-Message-State: APjAAAWRa7xdpxeZv3inpOoV8Xq+LHAknSbWlzr2K8eVfYV7BRkcO419
        ikbVQcxt22LtLQYBJPETNXo=
X-Google-Smtp-Source: APXvYqzrQzNt8s0TutKJcaFUW7nPQP8hH9PI/Q+GI2jrWzZRxgF3MSRUQjYAxqyKBLYUtVTk1HVi4Q==
X-Received: by 2002:aca:280a:: with SMTP id 10mr13043595oix.79.1567915422874;
        Sat, 07 Sep 2019 21:03:42 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id x80sm1419178oia.37.2019.09.07.21.03.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Sep 2019 21:03:42 -0700 (PDT)
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, pkshih@realtek.com,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH 4/9] rtlwifi: rtl8723ae: Convert inline routines to little-endian words
Date:   Sat,  7 Sep 2019 23:03:30 -0500
Message-Id: <20190908040335.19838-5-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190908040335.19838-1-Larry.Finger@lwfinger.net>
References: <20190908040335.19838-1-Larry.Finger@lwfinger.net>
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

