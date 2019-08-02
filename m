Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36F797E76F
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Aug 2019 03:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388503AbfHBBVN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 1 Aug 2019 21:21:13 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42383 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730806AbfHBBVM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 1 Aug 2019 21:21:12 -0400
Received: by mail-ot1-f67.google.com with SMTP id l15so76408371otn.9
        for <linux-wireless@vger.kernel.org>; Thu, 01 Aug 2019 18:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VmCJ2RE1VCGbHRSwcWonPoZq7zGGqhXWUXY1BeJMflI=;
        b=kOf8xQhKmJ3nc4jkzNhWpv4dmSeNQbLDD81bY7L5+R5g5QQQInRsV/mMG/YvwKzEp+
         8Vx2dWCaUy38f7viMmxmvPNjHF6MRVE8USavBS3FZ3lBT6EeipxL7jMaH7C8HYY1hFLp
         6YdoANaSvT0iojfTUZJqqAuyGXe98GpR00ozftD46ZDIpFiUHOqUlQuN9vbwPUG+oscf
         sCX4K/Hxt1CRR6wRQRfrrfMM4X/qeHx5DAvVdNMH/KvQGXQcPl+Z/FOvBPhAQLF1OUtC
         1IOwhUkmlsP+JmpivGW6jnQTr+AFfwgnCsVUktPg6nYM/PorvmEriQairPa9bCyQd/K8
         6+gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=VmCJ2RE1VCGbHRSwcWonPoZq7zGGqhXWUXY1BeJMflI=;
        b=fMybVj1DuVh/7JsGfU+g61djaL4oWiEuvv3PZ0e7+H5il4NKC5xNp7SB9NRp0C/dPN
         iVGNnV4OV88+T4360710vHBZKN8jUAROiNLTinbnxjqkZ12/hrZN6tn/OxMx1X/7HUyl
         p67NiR4JXYiC4Y35OsKTJu9dTVru9cxvyk9DiJtcQpzrOc+QUl7boIVUJetL0Ubyj5/Z
         lxNiwDTZKDxGesRSO/KaID1hdlcngqkiEarchAN0rlrpLuxdUdZpBPyX2o+IZgQzOIo2
         jHNsK05ym9H6jxYgH+O7IC0kSP87VlexOK7QIGZYtDwAAAd4jS5qXGvWYEm651lo2gMx
         amMQ==
X-Gm-Message-State: APjAAAWtfPESL1mUlLo5PBm7G7RdFKf/GLaGiW2eJs0vlp3xxIzgEiy8
        q61tsoYaUInOKF/7ePbBj9k=
X-Google-Smtp-Source: APXvYqwNLvE887x6g88fdWjgGJdYT1WNRovhcGKAo/UmqkALaXooRx78LmSiQhX3InORk2so9gJ3ig==
X-Received: by 2002:a05:6830:1293:: with SMTP id z19mr6913877otp.25.1564708870965;
        Thu, 01 Aug 2019 18:21:10 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id c64sm28112162otb.79.2019.08.01.18.21.10
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 18:21:10 -0700 (PDT)
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, pkshih@realtek.com,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH 4/4] rtlwifi: rtl8192ce: Convert inline routines to little-endian words
Date:   Thu,  1 Aug 2019 20:21:02 -0500
Message-Id: <20190802012102.7945-5-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190802012102.7945-1-Larry.Finger@lwfinger.net>
References: <20190802012102.7945-1-Larry.Finger@lwfinger.net>
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
 .../wireless/realtek/rtlwifi/rtl8192ce/trx.c  |  23 +-
 .../wireless/realtek/rtlwifi/rtl8192ce/trx.h  | 254 +++++++++---------
 2 files changed, 142 insertions(+), 135 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192ce/trx.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192ce/trx.c
index 7bff0825b264..123dbf0903a1 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192ce/trx.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192ce/trx.c
@@ -317,11 +317,12 @@ static void _rtl92ce_translate_rx_signal_stuff(struct ieee80211_hw *hw,
 bool rtl92ce_rx_query_desc(struct ieee80211_hw *hw,
 			   struct rtl_stats *stats,
 			   struct ieee80211_rx_status *rx_status,
-			   u8 *p_desc, struct sk_buff *skb)
+			   u8 *p_desc8, struct sk_buff *skb)
 {
 	struct rx_fwinfo_92c *p_drvinfo;
-	struct rx_desc_92c *pdesc = (struct rx_desc_92c *)p_desc;
+	struct rx_desc_92c *pdesc = (struct rx_desc_92c *)p_desc8;
 	struct ieee80211_hdr *hdr;
+	__le32 *p_desc = (__le32 *)p_desc8;
 	u32 phystatus = get_rx_desc_physt(p_desc);
 
 	stats->length = (u16)get_rx_desc_pkt_len(p_desc);
@@ -400,7 +401,7 @@ bool rtl92ce_rx_query_desc(struct ieee80211_hw *hw,
 }
 
 void rtl92ce_tx_fill_desc(struct ieee80211_hw *hw,
-			  struct ieee80211_hdr *hdr, u8 *pdesc_tx,
+			  struct ieee80211_hdr *hdr, u8 *pdesc8,
 			  u8 *pbd_desc_tx, struct ieee80211_tx_info *info,
 			  struct ieee80211_sta *sta,
 			  struct sk_buff *skb,
@@ -411,7 +412,7 @@ void rtl92ce_tx_fill_desc(struct ieee80211_hw *hw,
 	struct rtl_pci *rtlpci = rtl_pcidev(rtl_pcipriv(hw));
 	struct rtl_ps_ctl *ppsc = rtl_psc(rtl_priv(hw));
 	bool defaultadapter = true;
-	u8 *pdesc = pdesc_tx;
+	__le32 *pdesc = (__le32 *)pdesc8;
 	u16 seq_number;
 	__le16 fc = hdr->frame_control;
 	u8 fw_qsel = _rtl92ce_map_hwqueue_to_fwqueue(skb, hw_queue);
@@ -447,7 +448,7 @@ void rtl92ce_tx_fill_desc(struct ieee80211_hw *hw,
 
 	rtl_get_tcb_desc(hw, info, sta, skb, tcb_desc);
 
-	CLEAR_PCI_TX_DESC_CONTENT(pdesc, sizeof(struct tx_desc_92c));
+	clear_pci_tx_desc_content(pdesc, sizeof(struct tx_desc_92c));
 
 	if (ieee80211_is_nullfunc(fc) || ieee80211_is_ctl(fc)) {
 		firstseg = true;
@@ -580,12 +581,13 @@ void rtl92ce_tx_fill_desc(struct ieee80211_hw *hw,
 }
 
 void rtl92ce_tx_fill_cmddesc(struct ieee80211_hw *hw,
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
@@ -599,7 +601,7 @@ void rtl92ce_tx_fill_cmddesc(struct ieee80211_hw *hw,
 			 "DMA mapping error\n");
 		return;
 	}
-	CLEAR_PCI_TX_DESC_CONTENT(pdesc, TX_DESC_SIZE);
+	clear_pci_tx_desc_content(pdesc, TX_DESC_SIZE);
 
 	if (firstseg)
 		set_tx_desc_offset(pdesc, USB_HWDESC_HEADER_LEN);
@@ -642,9 +644,11 @@ void rtl92ce_tx_fill_cmddesc(struct ieee80211_hw *hw,
 		      "H2C Tx Cmd Content", pdesc, TX_DESC_SIZE);
 }
 
-void rtl92ce_set_desc(struct ieee80211_hw *hw, u8 *pdesc, bool istx,
+void rtl92ce_set_desc(struct ieee80211_hw *hw, u8 *pdesc8, bool istx,
 		      u8 desc_name, u8 *val)
 {
+	__le32 *pdesc = (__le32 *)pdesc8;
+
 	if (istx) {
 		switch (desc_name) {
 		case HW_DESC_OWN:
@@ -682,10 +686,11 @@ void rtl92ce_set_desc(struct ieee80211_hw *hw, u8 *pdesc, bool istx,
 	}
 }
 
-u64 rtl92ce_get_desc(struct ieee80211_hw *hw, u8 *p_desc,
+u64 rtl92ce_get_desc(struct ieee80211_hw *hw, u8 *p_desc8,
 		     bool istx, u8 desc_name)
 {
 	u32 ret = 0;
+	__le32 *p_desc = (__le32 *)p_desc8;
 
 	if (istx) {
 		switch (desc_name) {
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192ce/trx.h b/drivers/net/wireless/realtek/rtlwifi/rtl8192ce/trx.h
index 5addfa20b2b7..709dcac9d84b 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192ce/trx.h
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192ce/trx.h
@@ -16,318 +16,320 @@
 
 /* macros to read/write various fields in RX or TX descriptors */
 
-static inline void set_tx_desc_pkt_size(u8 *__pdesc, u32  __val)
+static inline void set_tx_desc_pkt_size(__le32 *__pdesc, u32  __val)
 {
-	le32p_replace_bits((__le32 *)__pdesc, __val, GENMASK(15, 0));
+	le32p_replace_bits(__pdesc, __val, GENMASK(15, 0));
 }
 
-static inline void set_tx_desc_offset(u8 *__pdesc, u32  __val)
+static inline void set_tx_desc_offset(__le32 *__pdesc, u32  __val)
 {
-	le32p_replace_bits((__le32 *)__pdesc, __val, GENMASK(23, 16));
+	le32p_replace_bits(__pdesc, __val, GENMASK(23, 16));
 }
 
-static inline void set_tx_desc_bmc(u8 *__pdesc, u32  __val)
+static inline void set_tx_desc_bmc(__le32 *__pdesc, u32  __val)
 {
-	le32p_replace_bits((__le32 *)__pdesc, __val, BIT(24));
+	le32p_replace_bits(__pdesc, __val, BIT(24));
 }
 
-static inline void set_tx_desc_htc(u8 *__pdesc, u32  __val)
+static inline void set_tx_desc_htc(__le32 *__pdesc, u32  __val)
 {
-	le32p_replace_bits((__le32 *)__pdesc, __val, BIT(25));
+	le32p_replace_bits(__pdesc, __val, BIT(25));
 }
 
-static inline void set_tx_desc_last_seg(u8 *__pdesc, u32  __val)
+static inline void set_tx_desc_last_seg(__le32 *__pdesc, u32  __val)
 {
-	le32p_replace_bits((__le32 *)__pdesc, __val, BIT(26));
+	le32p_replace_bits(__pdesc, __val, BIT(26));
 }
 
-static inline void set_tx_desc_first_seg(u8 *__pdesc, u32  __val)
+static inline void set_tx_desc_first_seg(__le32 *__pdesc, u32  __val)
 {
-	le32p_replace_bits((__le32 *)__pdesc, __val, BIT(27));
+	le32p_replace_bits(__pdesc, __val, BIT(27));
 }
 
-static inline void set_tx_desc_linip(u8 *__pdesc, u32  __val)
+static inline void set_tx_desc_linip(__le32 *__pdesc, u32  __val)
 {
-	le32p_replace_bits((__le32 *)__pdesc, __val, BIT(28));
+	le32p_replace_bits(__pdesc, __val, BIT(28));
 }
 
-static inline void set_tx_desc_own(u8 *__pdesc, u32  __val)
+static inline void set_tx_desc_own(__le32 *__pdesc, u32  __val)
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
+static inline void set_tx_desc_macid(__le32 *__pdesc, u32  __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 4), __val, GENMASK(4, 0));
+	le32p_replace_bits((__pdesc + 1), __val, GENMASK(4, 0));
 }
 
-static inline void set_tx_desc_agg_break(u8 *__pdesc, u32  __val)
+static inline void set_tx_desc_agg_break(__le32 *__pdesc, u32  __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 4), __val, BIT(5));
+	le32p_replace_bits((__pdesc + 1), __val, BIT(5));
 }
 
-static inline void set_tx_desc_rdg_enable(u8 *__pdesc, u32  __val)
+static inline void set_tx_desc_rdg_enable(__le32 *__pdesc, u32  __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 4), __val, BIT(7));
+	le32p_replace_bits((__pdesc + 1), __val, BIT(7));
 }
 
-static inline void set_tx_desc_queue_sel(u8 *__pdesc, u32  __val)
+static inline void set_tx_desc_queue_sel(__le32 *__pdesc, u32  __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 4), __val, GENMASK(12, 8));
+	le32p_replace_bits((__pdesc + 1), __val, GENMASK(12, 8));
 }
 
-static inline void set_tx_desc_rate_id(u8 *__pdesc, u32  __val)
+static inline void set_tx_desc_rate_id(__le32 *__pdesc, u32  __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 4), __val, GENMASK(19, 16));
+	le32p_replace_bits((__pdesc + 1), __val, GENMASK(19, 16));
 }
 
-static inline void set_tx_desc_sec_type(u8 *__pdesc, u32  __val)
+static inline void set_tx_desc_sec_type(__le32 *__pdesc, u32  __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 4), __val, GENMASK(23, 22));
+	le32p_replace_bits((__pdesc + 1), __val, GENMASK(23, 22));
 }
 
-static inline void set_tx_desc_more_frag(u8 *__pdesc, u32  __val)
+static inline void set_tx_desc_more_frag(__le32 *__pdesc, u32  __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 8), __val, BIT(17));
+	le32p_replace_bits((__pdesc + 2), __val, BIT(17));
 }
 
-static inline void set_tx_desc_ampdu_density(u8 *__pdesc, u32  __val)
+static inline void set_tx_desc_ampdu_density(__le32 *__pdesc, u32  __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 8), __val, GENMASK(22, 20));
+	le32p_replace_bits((__pdesc + 2), __val, GENMASK(22, 20));
 }
 
-static inline void set_tx_desc_seq(u8 *__pdesc, u32  __val)
+static inline void set_tx_desc_seq(__le32 *__pdesc, u32  __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 12), __val, GENMASK(27, 16));
+	le32p_replace_bits((__pdesc + 3), __val, GENMASK(27, 16));
 }
 
-static inline void set_tx_desc_pkt_id(u8 *__pdesc, u32  __val)
+static inline void set_tx_desc_pkt_id(__le32 *__pdesc, u32  __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 12), __val, GENMASK(31, 28));
+	le32p_replace_bits((__pdesc + 3), __val, GENMASK(31, 28));
 }
 
-static inline void set_tx_desc_rts_rate(u8 *__pdesc, u32  __val)
+static inline void set_tx_desc_rts_rate(__le32 *__pdesc, u32  __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, GENMASK(4, 0));
+	le32p_replace_bits((__pdesc + 4), __val, GENMASK(4, 0));
 }
 
-static inline void set_tx_desc_qos(u8 *__pdesc, u32  __val)
+static inline void set_tx_desc_qos(__le32 *__pdesc, u32  __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, BIT(6));
+	le32p_replace_bits((__pdesc + 4), __val, BIT(6));
 }
 
-static inline void set_tx_desc_hwseq_en(u8 *__pdesc, u32  __val)
+static inline void set_tx_desc_hwseq_en(__le32 *__pdesc, u32  __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, BIT(7));
+	le32p_replace_bits((__pdesc + 4), __val, BIT(7));
 }
 
-static inline void set_tx_desc_use_rate(u8 *__pdesc, u32  __val)
+static inline void set_tx_desc_use_rate(__le32 *__pdesc, u32  __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, BIT(8));
+	le32p_replace_bits((__pdesc + 4), __val, BIT(8));
 }
 
-static inline void set_tx_desc_disable_fb(u8 *__pdesc, u32  __val)
+static inline void set_tx_desc_disable_fb(__le32 *__pdesc, u32  __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, BIT(10));
+	le32p_replace_bits((__pdesc + 4), __val, BIT(10));
 }
 
-static inline void set_tx_desc_cts2self(u8 *__pdesc, u32  __val)
+static inline void set_tx_desc_cts2self(__le32 *__pdesc, u32  __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, BIT(11));
+	le32p_replace_bits((__pdesc + 4), __val, BIT(11));
 }
 
-static inline void set_tx_desc_rts_enable(u8 *__pdesc, u32  __val)
+static inline void set_tx_desc_rts_enable(__le32 *__pdesc, u32  __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, BIT(12));
+	le32p_replace_bits((__pdesc + 4), __val, BIT(12));
 }
 
-static inline void set_tx_desc_hw_rts_enable(u8 *__pdesc, u32  __val)
+static inline void set_tx_desc_hw_rts_enable(__le32 *__pdesc, u32  __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, BIT(13));
+	le32p_replace_bits((__pdesc + 4), __val, BIT(13));
 }
 
-static inline void set_tx_desc_tx_sub_carrier(u8 *__pdesc, u32  __val)
+static inline void set_tx_desc_tx_sub_carrier(__le32 *__pdesc, u32  __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, GENMASK(21, 20));
+	le32p_replace_bits((__pdesc + 4), __val, GENMASK(21, 20));
 }
 
-static inline void set_tx_desc_data_bw(u8 *__pdesc, u32  __val)
+static inline void set_tx_desc_data_bw(__le32 *__pdesc, u32  __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, BIT(25));
+	le32p_replace_bits((__pdesc + 4), __val, BIT(25));
 }
 
-static inline void set_tx_desc_rts_short(u8 *__pdesc, u32  __val)
+static inline void set_tx_desc_rts_short(__le32 *__pdesc, u32  __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, BIT(26));
+	le32p_replace_bits((__pdesc + 4), __val, BIT(26));
 }
 
-static inline void set_tx_desc_rts_bw(u8 *__pdesc, u32  __val)
+static inline void set_tx_desc_rts_bw(__le32 *__pdesc, u32  __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, BIT(27));
+	le32p_replace_bits((__pdesc + 4), __val, BIT(27));
 }
 
-static inline void set_tx_desc_rts_sc(u8 *__pdesc, u32  __val)
+static inline void set_tx_desc_rts_sc(__le32 *__pdesc, u32  __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, GENMASK(29, 28));
+	le32p_replace_bits((__pdesc + 4), __val, GENMASK(29, 28));
 }
 
-static inline void set_tx_desc_rts_stbc(u8 *__pdesc, u32  __val)
+static inline void set_tx_desc_rts_stbc(__le32 *__pdesc, u32  __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, GENMASK(31, 30));
+	le32p_replace_bits((__pdesc + 4), __val, GENMASK(31, 30));
 }
 
-static inline void set_tx_desc_tx_rate(u8 *__pdesc, u32  __val)
+static inline void set_tx_desc_tx_rate(__le32 *__pdesc, u32  __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 20), __val, GENMASK(5, 0));
+	le32p_replace_bits((__pdesc + 5), __val, GENMASK(5, 0));
 }
 
-static inline void set_tx_desc_data_shortgi(u8 *__pdesc, u32  __val)
+static inline void set_tx_desc_data_shortgi(__le32 *__pdesc, u32  __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 20), __val, BIT(6));
+	le32p_replace_bits((__pdesc + 5), __val, BIT(6));
 }
 
-static inline void set_tx_desc_data_rate_fb_limit(u8 *__pdesc, u32  __val)
+static inline void set_tx_desc_data_rate_fb_limit(__le32 *__pdesc, u32  __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 20), __val, GENMASK(12, 8));
+	le32p_replace_bits((__pdesc + 5), __val, GENMASK(12, 8));
 }
 
-static inline void set_tx_desc_rts_rate_fb_limit(u8 *__pdesc, u32  __val)
+static inline void set_tx_desc_rts_rate_fb_limit(__le32 *__pdesc, u32  __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 20), __val, GENMASK(16, 13));
+	le32p_replace_bits((__pdesc + 5), __val, GENMASK(16, 13));
 }
 
-static inline void set_tx_desc_max_agg_num(u8 *__pdesc, u32  __val)
+static inline void set_tx_desc_max_agg_num(__le32 *__pdesc, u32  __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 24), __val, GENMASK(15, 11));
+	le32p_replace_bits((__pdesc + 6), __val, GENMASK(15, 11));
 }
 
-static inline void set_tx_desc_tx_buffer_size(u8 *__pdesc, u32  __val)
+static inline void set_tx_desc_tx_buffer_size(__le32 *__pdesc, u32  __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 28), __val, GENMASK(15, 0));
+	le32p_replace_bits((__pdesc + 7), __val, GENMASK(15, 0));
 }
 
-static inline void set_tx_desc_tx_buffer_address(u8 *__pdesc, u32  __val)
+static inline void set_tx_desc_tx_buffer_address(__le32 *__pdesc, u32  __val)
 {
-	*(__le32 *)(__pdesc + 32) = cpu_to_le32(__val);
+	*(__pdesc + 8) = cpu_to_le32(__val);
 }
 
-static inline int get_tx_desc_tx_buffer_address(u8 *__pdesc)
+static inline int get_tx_desc_tx_buffer_address(__le32 *__pdesc)
 {
-	return le32_to_cpu(*((__le32 *)(__pdesc + 32)));
+	return le32_to_cpu(*((__pdesc + 8)));
 }
 
-static inline void set_tx_desc_next_desc_address(u8 *__pdesc, u32  __val)
+static inline void set_tx_desc_next_desc_address(__le32 *__pdesc, u32  __val)
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
 
-static inline int get_rx_desc_own(u8 *__pdesc)
+static inline int get_rx_desc_own(__le32 *__pdesc)
 {
-	return le32_get_bits(*((__le32 *)__pdesc), BIT(31));
+	return le32_get_bits(*(__pdesc), BIT(31));
 }
 
-static inline void set_rx_desc_pkt_len(u8 *__pdesc, u32  __val)
+static inline void set_rx_desc_pkt_len(__le32 *__pdesc, u32  __val)
 {
-	le32p_replace_bits((__le32 *)__pdesc, __val, GENMASK(13, 0));
+	le32p_replace_bits(__pdesc, __val, GENMASK(13, 0));
 }
 
-static inline void set_rx_desc_eor(u8 *__pdesc, u32  __val)
+static inline void set_rx_desc_eor(__le32 *__pdesc, u32  __val)
 {
-	le32p_replace_bits((__le32 *)__pdesc, __val, BIT(30));
+	le32p_replace_bits(__pdesc, __val, BIT(30));
 }
 
-static inline void set_rx_desc_own(u8 *__pdesc, u32  __val)
+static inline void set_rx_desc_own(__le32 *__pdesc, u32  __val)
 {
-	le32p_replace_bits((__le32 *)__pdesc, __val, BIT(31));
+	le32p_replace_bits(__pdesc, __val, BIT(31));
 }
 
-static inline int get_rx_desc_paggr(u8 *__pdesc)
+static inline int get_rx_desc_paggr(__le32 *__pdesc)
 {
-	return le32_get_bits(*((__le32 *)(__pdesc + 4)), BIT(14));
+	return le32_get_bits(*((__pdesc + 1)), BIT(14));
 }
 
-static inline int get_rx_desc_faggr(u8 *__pdesc)
+static inline int get_rx_desc_faggr(__le32 *__pdesc)
 {
-	return le32_get_bits(*((__le32 *)(__pdesc + 4)), BIT(15));
+	return le32_get_bits(*((__pdesc + 1)), BIT(15));
 }
 
-static inline int get_rx_desc_rxmcs(u8 *__pdesc)
+static inline int get_rx_desc_rxmcs(__le32 *__pdesc)
 {
-	return le32_get_bits(*((__le32 *)(__pdesc + 12)), GENMASK(5, 0));
+	return le32_get_bits(*((__pdesc + 3)), GENMASK(5, 0));
 }
 
-static inline int get_rx_desc_rxht(u8 *__pdesc)
+static inline int get_rx_desc_rxht(__le32 *__pdesc)
 {
-	return le32_get_bits(*((__le32 *)(__pdesc + 12)), BIT(6));
+	return le32_get_bits(*((__pdesc + 3)), BIT(6));
 }
 
-static inline int get_rx_desc_splcp(u8 *__pdesc)
+static inline int get_rx_desc_splcp(__le32 *__pdesc)
 {
-	return le32_get_bits(*((__le32 *)(__pdesc + 12)), BIT(8));
+	return le32_get_bits(*((__pdesc + 3)), BIT(8));
 }
 
-static inline int get_rx_desc_bw(u8 *__pdesc)
+static inline int get_rx_desc_bw(__le32 *__pdesc)
 {
-	return le32_get_bits(*((__le32 *)(__pdesc + 12)), BIT(9));
+	return le32_get_bits(*((__pdesc + 3)), BIT(9));
 }
 
-static inline int get_rx_desc_tsfl(u8 *__pdesc)
+static inline int get_rx_desc_tsfl(__le32 *__pdesc)
 {
-	return le32_to_cpu(*((__le32 *)(__pdesc + 20)));
+	return le32_to_cpu(*((__pdesc + 5)));
 }
 
-static inline int get_rx_desc_buff_addr(u8 *__pdesc)
+static inline int get_rx_desc_buff_addr(__le32 *__pdesc)
 {
-	return le32_to_cpu(*((__le32 *)(__pdesc + 24)));
+	return le32_to_cpu(*((__pdesc + 6)));
 }
 
-static inline void set_rx_desc_buff_addr(u8 *__pdesc, u32  __val)
+static inline void set_rx_desc_buff_addr(__le32 *__pdesc, u32  __val)
 {
-	*(__le32 *)(__pdesc + 24) = cpu_to_le32(__val);
+	*(__pdesc + 6) = cpu_to_le32(__val);
 }
 
-#define CLEAR_PCI_TX_DESC_CONTENT(__pdesc, _size)	\
-	memset(__pdesc, 0, min_t(size_t, _size, TX_DESC_NEXT_DESC_OFFSET))
+static inline void clear_pci_tx_desc_content(__le32 *__pdesc, int _size)
+{
+	memset(__pdesc, 0, min_t(size_t, _size, TX_DESC_NEXT_DESC_OFFSET));
+}
 
 struct rx_fwinfo_92c {
 	u8 gain_trsw[4];
-- 
2.22.0

