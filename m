Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E252123E63
	for <lists+linux-wireless@lfdr.de>; Mon, 20 May 2019 19:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390383AbfETRYZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 May 2019 13:24:25 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:37923 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390343AbfETRYZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 May 2019 13:24:25 -0400
Received: by mail-oi1-f195.google.com with SMTP id u199so10594614oie.5
        for <linux-wireless@vger.kernel.org>; Mon, 20 May 2019 10:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Vs25EkcIMPCD6AkPSk8KK35fD/jESEEoPnZmpnAEszQ=;
        b=DAkf3bb5ofsp0LdC5ISyInAg1PIBlz37O7frMR/RVoyz79gGn2o2g494kEP8RX8Ber
         Ca8v8JyDGS8r1CKT+fZm8TFHk3UCyrjdFRw2F+oQyGJXhP42Cqj8/tf2EJE1i2h3HMuf
         xXub04X8mnb/jEBp9IjvIChAIC70Spr72Cz+kCCTsKSWJKrqcgxVLexsr/3lnrIXpHxk
         Q1m6onHX0Ik9RkjbfuB8JPEszy61/Zy3NmJ3GQiQDW9P6c4Gqrk2JVgSJgPgEiOhmm7M
         Y5oMVwaivhAFQKmbDsoQj4dFQmK1oQBxtk674hq3l8ImbI0AKhhJseoISS8HqP1xN+py
         qt7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=Vs25EkcIMPCD6AkPSk8KK35fD/jESEEoPnZmpnAEszQ=;
        b=C1t4qvCq4OC2OmAoZ/gQnbXZJR5CE8/LOU8ixT1QB2GrjQRMNvZp09slrdrynSrx50
         GLmyyH9RB3SOJEf9wmH7zE3SC/D84YAaxatoEl420FMnM9yQJKR+m9xqtFCih2ju1eZH
         JZyZxAURNEL7FPK5iNnw0Pg/pDpP6P9zuAo2l7hvvSe+eLSeM1E8B/7pn3/UfHCBo/ct
         f/W31xLDLvy9lSjY2RipJUIEmn6Y2In5pIts8i6wFLXmT4QqxOPi6VueijcGNXdSJduI
         gwFSAYTNyoLlsVJFLPdvliK7BLtsN8whvvLZIV5viDK97rp+2IOzGMdeNW7dN87UH2kc
         oOOg==
X-Gm-Message-State: APjAAAUv3Ahvh12Cj9A7MZTBU7bqFG2L40JUBcOPS7mDvO0es89sWliy
        HcFN9brmWxdaxrs7YCKmMOlAc+1P
X-Google-Smtp-Source: APXvYqxW00nLxjC6gYB3nZ7IS1ookVIVw9y7E2++onGqxing6az34nby3FigTaAd6dfXNY+i+GyHYw==
X-Received: by 2002:a05:6808:a08:: with SMTP id n8mr62446oij.20.1558373063869;
        Mon, 20 May 2019 10:24:23 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id z190sm6556865oia.21.2019.05.20.10.24.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 10:24:23 -0700 (PDT)
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, pkshih@realtek.com,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH 3/4] rtlwifi: rtl8821ae: Convert macros that set descriptor
Date:   Mon, 20 May 2019 12:23:58 -0500
Message-Id: <20190520172359.9993-4-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190520172359.9993-1-Larry.Finger@lwfinger.net>
References: <20190520172359.9993-1-Larry.Finger@lwfinger.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

As a first step in the conversion, the macros that set the RX and TX
descriptors are converted to static inline routines, and the names are
changed from upper to lower case. To minimize the changes in a given
step, the input descriptor information is left as as a byte array
(u8 *), even though it should be a little-endian word array (__le32 *).
That will be changed later.

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
---
 .../wireless/realtek/rtlwifi/rtl8821ae/dm.c   |   2 +-
 .../wireless/realtek/rtlwifi/rtl8821ae/trx.c  | 208 +++----
 .../wireless/realtek/rtlwifi/rtl8821ae/trx.h  | 539 ++++++++++++------
 3 files changed, 474 insertions(+), 275 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/dm.c b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/dm.c
index 49d05b631ba1..e1c994f79d71 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/dm.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/dm.c
@@ -2963,5 +2963,5 @@ void rtl8821ae_dm_set_tx_ant_by_tx_info(struct ieee80211_hw *hw,
 		return;
 
 	if (rtlefuse->antenna_div_type == CG_TRX_HW_ANTDIV)
-		SET_TX_DESC_TX_ANT(pdesc, pfat_table->antsel_a[mac_id]);
+		set_tx_desc_tx_ant(pdesc, pfat_table->antsel_a[mac_id]);
 }
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/trx.c b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/trx.c
index 7b6faf38e09c..88cbae1ef328 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/trx.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/trx.c
@@ -339,7 +339,7 @@ static void _rtl8821ae_insert_emcontent(struct rtl_tcb_desc *ptcb_desc,
 
 	memset(virtualaddress, 0, 8);
 
-	SET_EARLYMODE_PKTNUM(virtualaddress, ptcb_desc->empkt_num);
+	set_earlymode_pktnum(virtualaddress, ptcb_desc->empkt_num);
 	if (ptcb_desc->empkt_num == 1) {
 		dwtmp = ptcb_desc->empkt_len[0];
 	} else {
@@ -347,7 +347,7 @@ static void _rtl8821ae_insert_emcontent(struct rtl_tcb_desc *ptcb_desc,
 		dwtmp += ((dwtmp % 4) ? (4 - dwtmp % 4) : 0)+4;
 		dwtmp += ptcb_desc->empkt_len[1];
 	}
-	SET_EARLYMODE_LEN0(virtualaddress, dwtmp);
+	set_earlymode_len0(virtualaddress, dwtmp);
 
 	if (ptcb_desc->empkt_num <= 3) {
 		dwtmp = ptcb_desc->empkt_len[2];
@@ -356,7 +356,7 @@ static void _rtl8821ae_insert_emcontent(struct rtl_tcb_desc *ptcb_desc,
 		dwtmp += ((dwtmp % 4) ? (4 - dwtmp % 4) : 0)+4;
 		dwtmp += ptcb_desc->empkt_len[3];
 	}
-	SET_EARLYMODE_LEN1(virtualaddress, dwtmp);
+	set_earlymode_len1(virtualaddress, dwtmp);
 	if (ptcb_desc->empkt_num <= 5) {
 		dwtmp = ptcb_desc->empkt_len[4];
 	} else {
@@ -364,8 +364,8 @@ static void _rtl8821ae_insert_emcontent(struct rtl_tcb_desc *ptcb_desc,
 		dwtmp += ((dwtmp % 4) ? (4 - dwtmp % 4) : 0)+4;
 		dwtmp += ptcb_desc->empkt_len[5];
 	}
-	SET_EARLYMODE_LEN2_1(virtualaddress, dwtmp & 0xF);
-	SET_EARLYMODE_LEN2_2(virtualaddress, dwtmp >> 4);
+	set_earlymode_len2_1(virtualaddress, dwtmp & 0xF);
+	set_earlymode_len2_2(virtualaddress, dwtmp >> 4);
 	if (ptcb_desc->empkt_num <= 7) {
 		dwtmp = ptcb_desc->empkt_len[6];
 	} else {
@@ -373,7 +373,7 @@ static void _rtl8821ae_insert_emcontent(struct rtl_tcb_desc *ptcb_desc,
 		dwtmp += ((dwtmp % 4) ? (4 - dwtmp % 4) : 0)+4;
 		dwtmp += ptcb_desc->empkt_len[7];
 	}
-	SET_EARLYMODE_LEN3(virtualaddress, dwtmp);
+	set_earlymode_len3(virtualaddress, dwtmp);
 	if (ptcb_desc->empkt_num <= 9) {
 		dwtmp = ptcb_desc->empkt_len[8];
 	} else {
@@ -381,7 +381,7 @@ static void _rtl8821ae_insert_emcontent(struct rtl_tcb_desc *ptcb_desc,
 		dwtmp += ((dwtmp % 4) ? (4 - dwtmp % 4) : 0)+4;
 		dwtmp += ptcb_desc->empkt_len[9];
 	}
-	SET_EARLYMODE_LEN4(virtualaddress, dwtmp);
+	set_earlymode_len4(virtualaddress, dwtmp);
 }
 
 static bool rtl8821ae_get_rxdesc_is_ht(struct ieee80211_hw *hw, u8 *pdesc)
@@ -389,7 +389,7 @@ static bool rtl8821ae_get_rxdesc_is_ht(struct ieee80211_hw *hw, u8 *pdesc)
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	u8 rx_rate = 0;
 
-	rx_rate = GET_RX_DESC_RXMCS(pdesc);
+	rx_rate = get_rx_desc_rxmcs(pdesc);
 
 	RT_TRACE(rtlpriv, COMP_RXDESC, DBG_LOUD, "rx_rate=0x%02x.\n", rx_rate);
 
@@ -403,7 +403,7 @@ static bool rtl8821ae_get_rxdesc_is_vht(struct ieee80211_hw *hw, u8 *pdesc)
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	u8 rx_rate = 0;
 
-	rx_rate = GET_RX_DESC_RXMCS(pdesc);
+	rx_rate = get_rx_desc_rxmcs(pdesc);
 
 	RT_TRACE(rtlpriv, COMP_RXDESC, DBG_LOUD, "rx_rate=0x%02x.\n", rx_rate);
 
@@ -417,7 +417,7 @@ static u8 rtl8821ae_get_rx_vht_nss(struct ieee80211_hw *hw, u8 *pdesc)
 	u8 rx_rate = 0;
 	u8 vht_nss = 0;
 
-	rx_rate = GET_RX_DESC_RXMCS(pdesc);
+	rx_rate = get_rx_desc_rxmcs(pdesc);
 	if ((rx_rate >= DESC_RATEVHT1SS_MCS0) &&
 	    (rx_rate <= DESC_RATEVHT1SS_MCS9))
 		vht_nss = 1;
@@ -437,24 +437,24 @@ bool rtl8821ae_rx_query_desc(struct ieee80211_hw *hw,
 	struct rx_fwinfo_8821ae *p_drvinfo;
 	struct ieee80211_hdr *hdr;
 	u8 wake_match;
-	u32 phystatus = GET_RX_DESC_PHYST(pdesc);
+	u32 phystatus = get_rx_desc_physt(pdesc);
 
-	status->length = (u16)GET_RX_DESC_PKT_LEN(pdesc);
-	status->rx_drvinfo_size = (u8)GET_RX_DESC_DRV_INFO_SIZE(pdesc) *
+	status->length = (u16)get_rx_desc_pkt_len(pdesc);
+	status->rx_drvinfo_size = (u8)get_rx_desc_drv_info_size(pdesc) *
 	    RX_DRV_INFO_SIZE_UNIT;
-	status->rx_bufshift = (u8)(GET_RX_DESC_SHIFT(pdesc) & 0x03);
-	status->icv = (u16)GET_RX_DESC_ICV(pdesc);
-	status->crc = (u16)GET_RX_DESC_CRC32(pdesc);
+	status->rx_bufshift = (u8)(get_rx_desc_shift(pdesc) & 0x03);
+	status->icv = (u16)get_rx_desc_icv(pdesc);
+	status->crc = (u16)get_rx_desc_crc32(pdesc);
 	status->hwerror = (status->crc | status->icv);
-	status->decrypted = !GET_RX_DESC_SWDEC(pdesc);
-	status->rate = (u8)GET_RX_DESC_RXMCS(pdesc);
-	status->shortpreamble = (u16)GET_RX_DESC_SPLCP(pdesc);
-	status->isampdu = (bool)(GET_RX_DESC_PAGGR(pdesc) == 1);
-	status->isfirst_ampdu = (bool)(GET_RX_DESC_PAGGR(pdesc) == 1);
-	status->timestamp_low = GET_RX_DESC_TSFL(pdesc);
-	status->rx_packet_bw = GET_RX_DESC_BW(pdesc);
-	status->macid = GET_RX_DESC_MACID(pdesc);
-	status->is_short_gi = !(bool)GET_RX_DESC_SPLCP(pdesc);
+	status->decrypted = !get_rx_desc_swdec(pdesc);
+	status->rate = (u8)get_rx_desc_rxmcs(pdesc);
+	status->shortpreamble = (u16)get_rx_desc_splcp(pdesc);
+	status->isampdu = (bool)(get_rx_desc_paggr(pdesc) == 1);
+	status->isfirst_ampdu = (bool)(get_rx_desc_paggr(pdesc) == 1);
+	status->timestamp_low = get_rx_desc_tsfl(pdesc);
+	status->rx_packet_bw = get_rx_desc_bw(pdesc);
+	status->macid = get_rx_desc_macid(pdesc);
+	status->is_short_gi = !(bool)get_rx_desc_splcp(pdesc);
 	status->is_ht = rtl8821ae_get_rxdesc_is_ht(hw, pdesc);
 	status->is_vht = rtl8821ae_get_rxdesc_is_vht(hw, pdesc);
 	status->vht_nss = rtl8821ae_get_rx_vht_nss(hw, pdesc);
@@ -467,16 +467,16 @@ bool rtl8821ae_rx_query_desc(struct ieee80211_hw *hw,
 		 status->is_ht, status->is_vht, status->vht_nss,
 		 status->is_short_gi);
 
-	if (GET_RX_STATUS_DESC_RPT_SEL(pdesc))
+	if (get_rx_status_desc_rpt_sel(pdesc))
 		status->packet_report_type = C2H_PACKET;
 	else
 		status->packet_report_type = NORMAL_RX;
 
-	if (GET_RX_STATUS_DESC_PATTERN_MATCH(pdesc))
+	if (get_rx_status_desc_pattern_match(pdesc))
 		wake_match = BIT(2);
-	else if (GET_RX_STATUS_DESC_MAGIC_MATCH(pdesc))
+	else if (get_rx_status_desc_magic_match(pdesc))
 		wake_match = BIT(1);
-	else if (GET_RX_STATUS_DESC_UNICAST_MATCH(pdesc))
+	else if (get_rx_status_desc_unicast_match(pdesc))
 		wake_match = BIT(0);
 	else
 		wake_match = 0;
@@ -543,9 +543,9 @@ bool rtl8821ae_rx_query_desc(struct ieee80211_hw *hw,
 	rx_status->signal = status->recvsignalpower + 10;
 	if (status->packet_report_type == TX_REPORT2) {
 		status->macid_valid_entry[0] =
-		  GET_RX_RPT2_DESC_MACID_VALID_1(pdesc);
+		  get_rx_rpt2_desc_macid_valid_1(pdesc);
 		status->macid_valid_entry[1] =
-		  GET_RX_RPT2_DESC_MACID_VALID_2(pdesc);
+		  get_rx_rpt2_desc_macid_valid_2(pdesc);
 	}
 	return true;
 }
@@ -679,6 +679,7 @@ void rtl8821ae_tx_fill_desc(struct ieee80211_hw *hw,
 			 cpu_to_le16(IEEE80211_FCTL_MOREFRAGS)) == 0);
 	dma_addr_t mapping;
 	u8 short_gi = 0;
+	bool tmp_bool;
 
 	seq_number = (le16_to_cpu(hdr->seq_ctrl) & IEEE80211_SCTL_SEQ) >> 4;
 	rtl_get_tcb_desc(hw, info, sta, skb, ptcb_desc);
@@ -702,8 +703,8 @@ void rtl8821ae_tx_fill_desc(struct ieee80211_hw *hw,
 	}
 	if (firstseg) {
 		if (rtlhal->earlymode_enable) {
-			SET_TX_DESC_PKT_OFFSET(pdesc, 1);
-			SET_TX_DESC_OFFSET(pdesc, USB_HWDESC_HEADER_LEN +
+			set_tx_desc_pkt_offset(pdesc, 1);
+			set_tx_desc_offset(pdesc, USB_HWDESC_HEADER_LEN +
 					   EM_HDR_LEN);
 			if (ptcb_desc->empkt_num) {
 				RT_TRACE(rtlpriv, COMP_SEND, DBG_TRACE,
@@ -713,51 +714,52 @@ void rtl8821ae_tx_fill_desc(struct ieee80211_hw *hw,
 					 (u8 *)(skb->data));
 			}
 		} else {
-			SET_TX_DESC_OFFSET(pdesc, USB_HWDESC_HEADER_LEN);
+			set_tx_desc_offset(pdesc, USB_HWDESC_HEADER_LEN);
 		}
 
 
 		/* ptcb_desc->use_driver_rate = true; */
-		SET_TX_DESC_TX_RATE(pdesc, ptcb_desc->hw_rate);
+		set_tx_desc_tx_rate(pdesc, ptcb_desc->hw_rate);
 		if (ptcb_desc->hw_rate > DESC_RATEMCS0)
 			short_gi = (ptcb_desc->use_shortgi) ? 1 : 0;
 		else
 			short_gi = (ptcb_desc->use_shortpreamble) ? 1 : 0;
 
-		SET_TX_DESC_DATA_SHORTGI(pdesc, short_gi);
+		set_tx_desc_data_shortgi(pdesc, short_gi);
 
 		if (info->flags & IEEE80211_TX_CTL_AMPDU) {
-			SET_TX_DESC_AGG_ENABLE(pdesc, 1);
-			SET_TX_DESC_MAX_AGG_NUM(pdesc, 0x1f);
+			set_tx_desc_agg_enable(pdesc, 1);
+			set_tx_desc_max_agg_num(pdesc, 0x1f);
 		}
-		SET_TX_DESC_SEQ(pdesc, seq_number);
-		SET_TX_DESC_RTS_ENABLE(pdesc, ((ptcb_desc->rts_enable &&
+		set_tx_desc_seq(pdesc, seq_number);
+		set_tx_desc_rts_enable(pdesc,
+				       ((ptcb_desc->rts_enable &&
 					!ptcb_desc->cts_enable) ? 1 : 0));
-		SET_TX_DESC_HW_RTS_ENABLE(pdesc, 0);
-		SET_TX_DESC_CTS2SELF(pdesc, ((ptcb_desc->cts_enable) ? 1 : 0));
+		set_tx_desc_hw_rts_enable(pdesc, 0);
+		set_tx_desc_cts2self(pdesc, ((ptcb_desc->cts_enable) ? 1 : 0));
 
-		SET_TX_DESC_RTS_RATE(pdesc, ptcb_desc->rts_rate);
-		SET_TX_DESC_RTS_SC(pdesc, ptcb_desc->rts_sc);
-		SET_TX_DESC_RTS_SHORT(pdesc,
-			((ptcb_desc->rts_rate <= DESC_RATE54M) ?
-			(ptcb_desc->rts_use_shortpreamble ? 1 : 0) :
-			(ptcb_desc->rts_use_shortgi ? 1 : 0)));
+		set_tx_desc_rts_rate(pdesc, ptcb_desc->rts_rate);
+		set_tx_desc_rts_sc(pdesc, ptcb_desc->rts_sc);
+		tmp_bool = ((ptcb_desc->rts_rate <= DESC_RATE54M) ?
+			    (ptcb_desc->rts_use_shortpreamble ? 1 : 0) :
+			    (ptcb_desc->rts_use_shortgi ? 1 : 0));
+		set_tx_desc_rts_short(pdesc, tmp_bool);
 
 		if (ptcb_desc->tx_enable_sw_calc_duration)
-			SET_TX_DESC_NAV_USE_HDR(pdesc, 1);
+			set_tx_desc_nav_use_hdr(pdesc, 1);
 
-		SET_TX_DESC_DATA_BW(pdesc,
-			rtl8821ae_bw_mapping(hw, ptcb_desc));
+		set_tx_desc_data_bw(pdesc,
+				    rtl8821ae_bw_mapping(hw, ptcb_desc));
 
-		SET_TX_DESC_TX_SUB_CARRIER(pdesc,
-			rtl8821ae_sc_mapping(hw, ptcb_desc));
+		set_tx_desc_tx_sub_carrier(pdesc,
+					   rtl8821ae_sc_mapping(hw, ptcb_desc));
 
-		SET_TX_DESC_LINIP(pdesc, 0);
-		SET_TX_DESC_PKT_SIZE(pdesc, (u16)skb_len);
+		set_tx_desc_linip(pdesc, 0);
+		set_tx_desc_pkt_size(pdesc, (u16)skb_len);
 		if (sta) {
 			u8 ampdu_density = sta->ht_cap.ampdu_density;
 
-			SET_TX_DESC_AMPDU_DENSITY(pdesc, ampdu_density);
+			set_tx_desc_ampdu_density(pdesc, ampdu_density);
 		}
 		if (info->control.hw_key) {
 			struct ieee80211_key_conf *keyconf =
@@ -766,56 +768,56 @@ void rtl8821ae_tx_fill_desc(struct ieee80211_hw *hw,
 			case WLAN_CIPHER_SUITE_WEP40:
 			case WLAN_CIPHER_SUITE_WEP104:
 			case WLAN_CIPHER_SUITE_TKIP:
-				SET_TX_DESC_SEC_TYPE(pdesc, 0x1);
+				set_tx_desc_sec_type(pdesc, 0x1);
 				break;
 			case WLAN_CIPHER_SUITE_CCMP:
-				SET_TX_DESC_SEC_TYPE(pdesc, 0x3);
+				set_tx_desc_sec_type(pdesc, 0x3);
 				break;
 			default:
-				SET_TX_DESC_SEC_TYPE(pdesc, 0x0);
+				set_tx_desc_sec_type(pdesc, 0x0);
 				break;
 			}
 		}
 
-		SET_TX_DESC_QUEUE_SEL(pdesc, fw_qsel);
-		SET_TX_DESC_DATA_RATE_FB_LIMIT(pdesc, 0x1F);
-		SET_TX_DESC_RTS_RATE_FB_LIMIT(pdesc, 0xF);
-		SET_TX_DESC_DISABLE_FB(pdesc, ptcb_desc->disable_ratefallback ?
+		set_tx_desc_queue_sel(pdesc, fw_qsel);
+		set_tx_desc_data_rate_fb_limit(pdesc, 0x1F);
+		set_tx_desc_rts_rate_fb_limit(pdesc, 0xF);
+		set_tx_desc_disable_fb(pdesc, ptcb_desc->disable_ratefallback ?
 				       1 : 0);
-		SET_TX_DESC_USE_RATE(pdesc, ptcb_desc->use_driver_rate ? 1 : 0);
+		set_tx_desc_use_rate(pdesc, ptcb_desc->use_driver_rate ? 1 : 0);
 
 		if (ieee80211_is_data_qos(fc)) {
 			if (mac->rdg_en) {
 				RT_TRACE(rtlpriv, COMP_SEND, DBG_TRACE,
 					 "Enable RDG function.\n");
-				SET_TX_DESC_RDG_ENABLE(pdesc, 1);
-				SET_TX_DESC_HTC(pdesc, 1);
+				set_tx_desc_rdg_enable(pdesc, 1);
+				set_tx_desc_htc(pdesc, 1);
 			}
 		}
 		/* tx report */
 		rtl_set_tx_report(ptcb_desc, pdesc, hw, tx_info);
 	}
 
-	SET_TX_DESC_FIRST_SEG(pdesc, (firstseg ? 1 : 0));
-	SET_TX_DESC_LAST_SEG(pdesc, (lastseg ? 1 : 0));
-	SET_TX_DESC_TX_BUFFER_SIZE(pdesc, (u16)buf_len);
-	SET_TX_DESC_TX_BUFFER_ADDRESS(pdesc, mapping);
+	set_tx_desc_first_seg(pdesc, (firstseg ? 1 : 0));
+	set_tx_desc_last_seg(pdesc, (lastseg ? 1 : 0));
+	set_tx_desc_tx_buffer_size(pdesc, (u16)buf_len);
+	set_tx_desc_tx_buffer_address(pdesc, mapping);
 	/* if (rtlpriv->dm.useramask) { */
 	if (1) {
-		SET_TX_DESC_RATE_ID(pdesc, ptcb_desc->ratr_index);
-		SET_TX_DESC_MACID(pdesc, ptcb_desc->mac_id);
+		set_tx_desc_rate_id(pdesc, ptcb_desc->ratr_index);
+		set_tx_desc_macid(pdesc, ptcb_desc->mac_id);
 	} else {
-		SET_TX_DESC_RATE_ID(pdesc, 0xC + ptcb_desc->ratr_index);
-		SET_TX_DESC_MACID(pdesc, ptcb_desc->mac_id);
+		set_tx_desc_rate_id(pdesc, 0xC + ptcb_desc->ratr_index);
+		set_tx_desc_macid(pdesc, ptcb_desc->mac_id);
 	}
 	if (!ieee80211_is_data_qos(fc))  {
-		SET_TX_DESC_HWSEQ_EN(pdesc, 1);
-		SET_TX_DESC_HWSEQ_SEL(pdesc, 0);
+		set_tx_desc_hwseq_en(pdesc, 1);
+		set_tx_desc_hwseq_sel(pdesc, 0);
 	}
-	SET_TX_DESC_MORE_FRAG(pdesc, (lastseg ? 0 : 1));
+	set_tx_desc_more_frag(pdesc, (lastseg ? 0 : 1));
 	if (is_multicast_ether_addr(ieee80211_get_DA(hdr)) ||
 	    is_broadcast_ether_addr(ieee80211_get_DA(hdr))) {
-		SET_TX_DESC_BMC(pdesc, 1);
+		set_tx_desc_bmc(pdesc, 1);
 	}
 
 	rtl8821ae_dm_set_tx_ant_by_tx_info(hw, pdesc, ptcb_desc->mac_id);
@@ -841,30 +843,30 @@ void rtl8821ae_tx_fill_cmddesc(struct ieee80211_hw *hw,
 	}
 	CLEAR_PCI_TX_DESC_CONTENT(pdesc, TX_DESC_SIZE);
 
-	SET_TX_DESC_FIRST_SEG(pdesc, 1);
-	SET_TX_DESC_LAST_SEG(pdesc, 1);
+	set_tx_desc_first_seg(pdesc, 1);
+	set_tx_desc_last_seg(pdesc, 1);
 
-	SET_TX_DESC_PKT_SIZE((u8 *)pdesc, (u16)(skb->len));
+	set_tx_desc_pkt_size((u8 *)pdesc, (u16)(skb->len));
 
-	SET_TX_DESC_OFFSET(pdesc, USB_HWDESC_HEADER_LEN);
+	set_tx_desc_offset(pdesc, USB_HWDESC_HEADER_LEN);
 
-	SET_TX_DESC_USE_RATE(pdesc, 1);
-	SET_TX_DESC_TX_RATE(pdesc, DESC_RATE1M);
-	SET_TX_DESC_DISABLE_FB(pdesc, 1);
+	set_tx_desc_use_rate(pdesc, 1);
+	set_tx_desc_tx_rate(pdesc, DESC_RATE1M);
+	set_tx_desc_disable_fb(pdesc, 1);
 
-	SET_TX_DESC_DATA_BW(pdesc, 0);
+	set_tx_desc_data_bw(pdesc, 0);
 
-	SET_TX_DESC_HWSEQ_EN(pdesc, 1);
+	set_tx_desc_hwseq_en(pdesc, 1);
 
-	SET_TX_DESC_QUEUE_SEL(pdesc, fw_queue);
+	set_tx_desc_queue_sel(pdesc, fw_queue);
 
-	SET_TX_DESC_TX_BUFFER_SIZE(pdesc, (u16)(skb->len));
+	set_tx_desc_tx_buffer_size(pdesc, (u16)(skb->len));
 
-	SET_TX_DESC_TX_BUFFER_ADDRESS(pdesc, mapping);
+	set_tx_desc_tx_buffer_address(pdesc, mapping);
 
-	SET_TX_DESC_MACID(pdesc, 0);
+	set_tx_desc_macid(pdesc, 0);
 
-	SET_TX_DESC_OWN(pdesc, 1);
+	set_tx_desc_own(pdesc, 1);
 
 	RT_PRINT_DATA(rtlpriv, COMP_CMD, DBG_LOUD,
 		      "H2C Tx Cmd Content\n",
@@ -877,10 +879,10 @@ void rtl8821ae_set_desc(struct ieee80211_hw *hw, u8 *pdesc,
 	if (istx) {
 		switch (desc_name) {
 		case HW_DESC_OWN:
-			SET_TX_DESC_OWN(pdesc, 1);
+			set_tx_desc_own(pdesc, 1);
 			break;
 		case HW_DESC_TX_NEXTDESC_ADDR:
-			SET_TX_DESC_NEXT_DESC_ADDRESS(pdesc, *(u32 *)val);
+			set_tx_desc_next_desc_address(pdesc, *(u32 *)val);
 			break;
 		default:
 			WARN_ONCE(true,
@@ -891,16 +893,16 @@ void rtl8821ae_set_desc(struct ieee80211_hw *hw, u8 *pdesc,
 	} else {
 		switch (desc_name) {
 		case HW_DESC_RXOWN:
-			SET_RX_DESC_OWN(pdesc, 1);
+			set_rx_desc_own(pdesc, 1);
 			break;
 		case HW_DESC_RXBUFF_ADDR:
-			SET_RX_DESC_BUFF_ADDR(pdesc, *(u32 *)val);
+			set_rx_desc_buff_addr(pdesc, *(u32 *)val);
 			break;
 		case HW_DESC_RXPKT_LEN:
-			SET_RX_DESC_PKT_LEN(pdesc, *(u32 *)val);
+			set_rx_desc_pkt_len(pdesc, *(u32 *)val);
 			break;
 		case HW_DESC_RXERO:
-			SET_RX_DESC_EOR(pdesc, 1);
+			set_rx_desc_eor(pdesc, 1);
 			break;
 		default:
 			WARN_ONCE(true,
@@ -919,10 +921,10 @@ u64 rtl8821ae_get_desc(struct ieee80211_hw *hw,
 	if (istx) {
 		switch (desc_name) {
 		case HW_DESC_OWN:
-			ret = GET_TX_DESC_OWN(pdesc);
+			ret = get_tx_desc_own(pdesc);
 			break;
 		case HW_DESC_TXBUFF_ADDR:
-			ret = GET_TX_DESC_TX_BUFFER_ADDRESS(pdesc);
+			ret = get_tx_desc_tx_buffer_address(pdesc);
 			break;
 		default:
 			WARN_ONCE(true,
@@ -933,13 +935,13 @@ u64 rtl8821ae_get_desc(struct ieee80211_hw *hw,
 	} else {
 		switch (desc_name) {
 		case HW_DESC_OWN:
-			ret = GET_RX_DESC_OWN(pdesc);
+			ret = get_rx_desc_own(pdesc);
 			break;
 		case HW_DESC_RXPKT_LEN:
-			ret = GET_RX_DESC_PKT_LEN(pdesc);
+			ret = get_rx_desc_pkt_len(pdesc);
 			break;
 		case HW_DESC_RXBUFF_ADDR:
-			ret = GET_RX_DESC_BUFF_ADDR(pdesc);
+			ret = get_rx_desc_buff_addr(pdesc);
 			break;
 		default:
 			WARN_ONCE(true,
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/trx.h b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/trx.h
index 9437d173850a..8c96c8efc180 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/trx.h
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/trx.h
@@ -14,180 +14,377 @@
 #define USB_HWDESC_HEADER_LEN			40
 #define CRCLENGTH						4
 
-#define SET_TX_DESC_PKT_SIZE(__pdesc, __val)			\
-	le32p_replace_bits((__le32 *)__pdesc, __val, GENMASK(15, 0))
-#define SET_TX_DESC_OFFSET(__pdesc, __val)			\
-	le32p_replace_bits((__le32 *)__pdesc, __val, GENMASK(23, 16))
-#define SET_TX_DESC_BMC(__pdesc, __val)				\
-	le32p_replace_bits((__le32 *)__pdesc, __val, BIT(24))
-#define SET_TX_DESC_HTC(__pdesc, __val)				\
-	le32p_replace_bits((__le32 *)__pdesc, __val, BIT(25))
-#define SET_TX_DESC_LAST_SEG(__pdesc, __val)			\
-	le32p_replace_bits((__le32 *)__pdesc, __val, BIT(26))
-#define SET_TX_DESC_FIRST_SEG(__pdesc, __val)			\
-	le32p_replace_bits((__le32 *)__pdesc, __val, BIT(27))
-#define SET_TX_DESC_LINIP(__pdesc, __val)			\
-	le32p_replace_bits((__le32 *)__pdesc, __val, BIT(28))
-#define SET_TX_DESC_OWN(__pdesc, __val)				\
-	le32p_replace_bits((__le32 *)__pdesc, __val, BIT(31))
-
-#define GET_TX_DESC_OWN(__pdesc)				\
-	le32_get_bits(*((__le32 *)__pdesc), BIT(31))
-
-#define SET_TX_DESC_MACID(__pdesc, __val)			\
-	le32p_replace_bits((__le32 *)(__pdesc + 4), __val, GENMASK(6, 0))
-#define SET_TX_DESC_QUEUE_SEL(__pdesc, __val)			\
-	le32p_replace_bits((__le32 *)(__pdesc + 4), __val, GENMASK(12, 8))
-#define SET_TX_DESC_RATE_ID(__pdesc, __val)			\
-	le32p_replace_bits((__le32 *)(__pdesc + 4), __val, GENMASK(20, 16))
-#define SET_TX_DESC_SEC_TYPE(__pdesc, __val)			\
-	le32p_replace_bits((__le32 *)(__pdesc + 4), __val, GENMASK(23, 22))
-#define SET_TX_DESC_PKT_OFFSET(__pdesc, __val)			\
-	le32p_replace_bits((__le32 *)(__pdesc + 4), __val, GENMASK(28, 24))
-
-#define SET_TX_DESC_AGG_ENABLE(__pdesc, __val)			\
-	le32p_replace_bits((__le32 *)(__pdesc + 8), __val, BIT(12))
-#define SET_TX_DESC_RDG_ENABLE(__pdesc, __val)			\
-	le32p_replace_bits((__le32 *)(__pdesc + 8), __val, BIT(13))
-#define SET_TX_DESC_MORE_FRAG(__pdesc, __val)			\
-	le32p_replace_bits((__le32 *)(__pdesc + 8), __val, BIT(17))
-#define SET_TX_DESC_AMPDU_DENSITY(__pdesc, __val)		\
-	le32p_replace_bits((__le32 *)(__pdesc + 8), __val, GENMASK(22, 20))
-
-#define SET_TX_DESC_HWSEQ_SEL(__pdesc, __val)			\
-	le32p_replace_bits((__le32 *)(__pdesc + 12), __val, GENMASK(7, 6))
-#define SET_TX_DESC_USE_RATE(__pdesc, __val)			\
-	le32p_replace_bits((__le32 *)(__pdesc + 12), __val, BIT(8))
-#define SET_TX_DESC_DISABLE_FB(__pdesc, __val)			\
-	le32p_replace_bits((__le32 *)(__pdesc + 12), __val, BIT(10))
-#define SET_TX_DESC_CTS2SELF(__pdesc, __val)			\
-	le32p_replace_bits((__le32 *)(__pdesc + 12), __val, BIT(11))
-#define SET_TX_DESC_RTS_ENABLE(__pdesc, __val)			\
-	le32p_replace_bits((__le32 *)(__pdesc + 12), __val, BIT(12))
-#define SET_TX_DESC_HW_RTS_ENABLE(__pdesc, __val)		\
-	le32p_replace_bits((__le32 *)(__pdesc + 12), __val, BIT(13))
-#define SET_TX_DESC_NAV_USE_HDR(__pdesc, __val)			\
-	le32p_replace_bits((__le32 *)(__pdesc + 12), __val, BIT(15))
-#define SET_TX_DESC_MAX_AGG_NUM(__pdesc, __val)			\
-	le32p_replace_bits((__le32 *)(__pdesc + 12), __val, GENMASK(21, 17))
-#define SET_TX_DESC_TX_ANT(__pdesc, __val)			\
-	le32p_replace_bits((__le32 *)(__pdesc + 20), __val, GENMASK(27, 24))
-
-#define SET_TX_DESC_TX_RATE(__pdesc, __val)			\
-	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, GENMASK(6, 0))
-#define SET_TX_DESC_DATA_RATE_FB_LIMIT(__pdesc, __val)		\
-	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, GENMASK(12, 8))
-#define SET_TX_DESC_RTS_RATE_FB_LIMIT(__pdesc, __val)		\
-	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, GENMASK(16, 13))
-#define SET_TX_DESC_RTS_RATE(__pdesc, __val)			\
-	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, GENMASK(28, 24))
-
-#define SET_TX_DESC_TX_SUB_CARRIER(__pdesc, __val)		\
-	le32p_replace_bits((__le32 *)(__pdesc + 20), __val, GENMASK(3, 0))
-#define SET_TX_DESC_DATA_SHORTGI(__pdesc, __val)		\
-	le32p_replace_bits((__le32 *)(__pdesc + 20), __val, BIT(4))
-#define SET_TX_DESC_DATA_BW(__pdesc, __val)			\
-	le32p_replace_bits((__le32 *)(__pdesc + 20), __val, GENMASK(6, 5))
-#define SET_TX_DESC_RTS_SHORT(__pdesc, __val)			\
-	le32p_replace_bits((__le32 *)(__pdesc + 20), __val, BIT(12))
-#define SET_TX_DESC_RTS_SC(__pdesc, __val)			\
-	le32p_replace_bits((__le32 *)(__pdesc + 20), __val, GENMASK(16, 13))
-
-#define SET_TX_DESC_TX_BUFFER_SIZE(__pdesc, __val)		\
-	le32p_replace_bits((__le32 *)(__pdesc + 28), __val, GENMASK(15, 0))
-
-#define SET_TX_DESC_HWSEQ_EN(__pdesc, __val)			\
-	le32p_replace_bits((__le32 *)(__pdesc + 32), __val, BIT(15))
-
-#define SET_TX_DESC_SEQ(__pdesc, __val)				\
-	le32p_replace_bits((__le32 *)(__pdesc + 36), __val, GENMASK(23, 12))
-
-#define SET_TX_DESC_TX_BUFFER_ADDRESS(__pdesc, __val)		\
-	*(__le32 *)(__pdesc + 40) = cpu_to_le32(__val)
-
-#define GET_TX_DESC_TX_BUFFER_ADDRESS(__pdesc)			\
-	le32_to_cpu(*((__le32 *)(__pdesc + 40)))
-
-#define SET_TX_DESC_NEXT_DESC_ADDRESS(__pdesc, __val)		\
-	*(__le32 *)(__pdesc + 48) = cpu_to_le32(__val)
-
-#define GET_RX_DESC_PKT_LEN(__pdesc)				\
-	le32_get_bits(*((__le32 *)(__pdesc)), GENMASK(13, 0))
-#define GET_RX_DESC_CRC32(__pdesc)				\
-	le32_get_bits(*((__le32 *)(__pdesc)), BIT(14))
-#define GET_RX_DESC_ICV(__pdesc)				\
-	le32_get_bits(*((__le32 *)(__pdesc)), BIT(15))
-#define GET_RX_DESC_DRV_INFO_SIZE(__pdesc)			\
-	le32_get_bits(*((__le32 *)(__pdesc)), GENMASK(19, 16))
-#define GET_RX_DESC_SHIFT(__pdesc)				\
-	le32_get_bits(*((__le32 *)(__pdesc)), GENMASK(25, 24))
-#define GET_RX_DESC_PHYST(__pdesc)				\
-	le32_get_bits(*((__le32 *)(__pdesc)), BIT(26))
-#define GET_RX_DESC_SWDEC(__pdesc)				\
-	le32_get_bits(*((__le32 *)(__pdesc)), BIT(27))
-#define GET_RX_DESC_OWN(__pdesc)				\
-	le32_get_bits(*((__le32 *)(__pdesc)), BIT(31))
-
-#define SET_RX_DESC_PKT_LEN(__pdesc, __val)			\
-	le32p_replace_bits((__le32 *)(__pdesc), __val, GENMASK(13, 0))
-#define SET_RX_DESC_EOR(__pdesc, __val)				\
-	le32p_replace_bits((__le32 *)(__pdesc), __val, BIT(30))
-#define SET_RX_DESC_OWN(__pdesc, __val)				\
-	le32p_replace_bits((__le32 *)(__pdesc), __val, BIT(31))
-
-#define GET_RX_DESC_MACID(__pdesc)				\
-	le32_get_bits(*((__le32 *)(__pdesc + 4)), GENMASK(6, 0))
-#define GET_RX_DESC_PAGGR(__pdesc)				\
-	le32_get_bits(*((__le32 *)(__pdesc + 4)), BIT(15))
-
-#define GET_RX_STATUS_DESC_RPT_SEL(__pdesc)			\
-	le32_get_bits(*((__le32 *)(__pdesc + 4)), BIT(28))
-
-#define GET_RX_DESC_RXMCS(__pdesc)				\
-	le32_get_bits(*((__le32 *)(__pdesc + 12)), GENMASK(6, 0))
-
-#define GET_RX_STATUS_DESC_PATTERN_MATCH(__pdesc)		\
-	le32_get_bits(*((__le32 *)(__pdesc + 12)), BIT(29))
-#define GET_RX_STATUS_DESC_UNICAST_MATCH(__pdesc)		\
-	le32_get_bits(*((__le32 *)(__pdesc + 12)), BIT(30))
-#define GET_RX_STATUS_DESC_MAGIC_MATCH(__pdesc)			\
-	le32_get_bits(*((__le32 *)(__pdesc + 12)), BIT(31))
-
-#define GET_RX_DESC_SPLCP(__pdesc)				\
-	le32_get_bits(*((__le32 *)(__pdesc + 16)), BIT(0))
-#define GET_RX_DESC_BW(__pdesc)					\
-	le32_get_bits(*((__le32 *)(__pdesc + 16)), GENMASK(5, 4))
-
-#define GET_RX_DESC_TSFL(__pdesc)				\
-	le32_to_cpu(*((__le32 *)(__pdesc + 20)))
-
-#define GET_RX_DESC_BUFF_ADDR(__pdesc)				\
-	le32_to_cpu(*((__le32 *)(__pdesc + 24)))
-
-#define SET_RX_DESC_BUFF_ADDR(__pdesc, __val)			\
-	*(__le32 *)(__pdesc + 24) = cpu_to_le32(__val)
+static inline void set_tx_desc_pkt_size(u8 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__le32 *)__pdesc, __val, GENMASK(15, 0));
+}
+
+static inline void set_tx_desc_offset(u8 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__le32 *)__pdesc, __val, GENMASK(23, 16));
+}
+
+static inline void set_tx_desc_bmc(u8 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__le32 *)__pdesc, __val, BIT(24));
+}
+
+static inline void set_tx_desc_htc(u8 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__le32 *)__pdesc, __val, BIT(25));
+}
+
+static inline void set_tx_desc_last_seg(u8 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__le32 *)__pdesc, __val, BIT(26));
+}
+
+static inline void set_tx_desc_first_seg(u8 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__le32 *)__pdesc, __val, BIT(27));
+}
+
+static inline void set_tx_desc_linip(u8 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__le32 *)__pdesc, __val, BIT(28));
+}
+
+static inline void set_tx_desc_own(u8 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__le32 *)__pdesc, __val, BIT(31));
+}
+
+static inline int get_tx_desc_own(u8 *__pdesc)
+{
+	return le32_get_bits(*((__le32 *)__pdesc), BIT(31));
+}
+
+static inline void set_tx_desc_macid(u8 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__le32 *)(__pdesc + 4), __val, GENMASK(6, 0));
+}
+
+static inline void set_tx_desc_queue_sel(u8 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__le32 *)(__pdesc + 4), __val, GENMASK(12, 8));
+}
+
+static inline void set_tx_desc_rate_id(u8 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__le32 *)(__pdesc + 4), __val, GENMASK(20, 16));
+}
+
+static inline void set_tx_desc_sec_type(u8 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__le32 *)(__pdesc + 4), __val, GENMASK(23, 22));
+}
+
+static inline void set_tx_desc_pkt_offset(u8 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__le32 *)(__pdesc + 4), __val, GENMASK(28, 24));
+}
+
+static inline void set_tx_desc_agg_enable(u8 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__le32 *)(__pdesc + 8), __val, BIT(12));
+}
+
+static inline void set_tx_desc_rdg_enable(u8 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__le32 *)(__pdesc + 8), __val, BIT(13));
+}
+
+static inline void set_tx_desc_more_frag(u8 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__le32 *)(__pdesc + 8), __val, BIT(17));
+}
+
+static inline void set_tx_desc_ampdu_density(u8 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__le32 *)(__pdesc + 8), __val, GENMASK(22, 20));
+}
+
+static inline void set_tx_desc_hwseq_sel(u8 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__le32 *)(__pdesc + 12), __val, GENMASK(7, 6));
+}
+
+static inline void set_tx_desc_use_rate(u8 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__le32 *)(__pdesc + 12), __val, BIT(8));
+}
+
+static inline void set_tx_desc_disable_fb(u8 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__le32 *)(__pdesc + 12), __val, BIT(10));
+}
+
+static inline void set_tx_desc_cts2self(u8 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__le32 *)(__pdesc + 12), __val, BIT(11));
+}
+
+static inline void set_tx_desc_rts_enable(u8 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__le32 *)(__pdesc + 12), __val, BIT(12));
+}
+
+static inline void set_tx_desc_hw_rts_enable(u8 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__le32 *)(__pdesc + 12), __val, BIT(13));
+}
+
+static inline void set_tx_desc_nav_use_hdr(u8 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__le32 *)(__pdesc + 12), __val, BIT(15));
+}
+
+static inline void set_tx_desc_max_agg_num(u8 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__le32 *)(__pdesc + 12), __val, GENMASK(21, 17));
+}
+
+static inline void set_tx_desc_tx_ant(u8 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__le32 *)(__pdesc + 20), __val, GENMASK(27, 24));
+}
+
+static inline void set_tx_desc_tx_rate(u8 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, GENMASK(6, 0));
+}
+
+static inline void set_tx_desc_data_rate_fb_limit(u8 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, GENMASK(12, 8));
+}
+
+static inline void set_tx_desc_rts_rate_fb_limit(u8 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, GENMASK(16, 13));
+}
+
+static inline void set_tx_desc_rts_rate(u8 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, GENMASK(28, 24));
+}
+
+static inline void set_tx_desc_tx_sub_carrier(u8 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__le32 *)(__pdesc + 20), __val, GENMASK(3, 0));
+}
+
+static inline void set_tx_desc_data_shortgi(u8 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__le32 *)(__pdesc + 20), __val, BIT(4));
+}
+
+static inline void set_tx_desc_data_bw(u8 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__le32 *)(__pdesc + 20), __val, GENMASK(6, 5));
+}
+
+static inline void set_tx_desc_rts_short(u8 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__le32 *)(__pdesc + 20), __val, BIT(12));
+}
+
+static inline void set_tx_desc_rts_sc(u8 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__le32 *)(__pdesc + 20), __val, GENMASK(16, 13));
+}
+
+static inline void set_tx_desc_tx_buffer_size(u8 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__le32 *)(__pdesc + 28), __val, GENMASK(15, 0));
+}
+
+static inline void set_tx_desc_hwseq_en(u8 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__le32 *)(__pdesc + 32), __val, BIT(15));
+}
+
+static inline void set_tx_desc_seq(u8 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__le32 *)(__pdesc + 36), __val, GENMASK(23, 12));
+}
+
+static inline void set_tx_desc_tx_buffer_address(u8 *__pdesc, u32 __val)
+{
+	*(__le32 *)(__pdesc + 40) = cpu_to_le32(__val);
+}
+
+static inline int get_tx_desc_tx_buffer_address(u8 *__pdesc)
+{
+	return le32_to_cpu(*((__le32 *)(__pdesc + 40)));
+}
+
+static inline void set_tx_desc_next_desc_address(u8 *__pdesc, u32 __val)
+{
+	*(__le32 *)(__pdesc + 48) = cpu_to_le32(__val);
+}
+
+static inline int get_rx_desc_pkt_len(u8 *__pdesc)
+{
+	return le32_get_bits(*((__le32 *)(__pdesc)), GENMASK(13, 0));
+}
+
+static inline int get_rx_desc_crc32(u8 *__pdesc)
+{
+	return le32_get_bits(*((__le32 *)(__pdesc)), BIT(14));
+}
+
+static inline int get_rx_desc_icv(u8 *__pdesc)
+{
+	return le32_get_bits(*((__le32 *)(__pdesc)), BIT(15));
+}
+
+static inline int get_rx_desc_drv_info_size(u8 *__pdesc)
+{
+	return le32_get_bits(*((__le32 *)(__pdesc)), GENMASK(19, 16));
+}
+
+static inline int get_rx_desc_shift(u8 *__pdesc)
+{
+	return le32_get_bits(*((__le32 *)(__pdesc)), GENMASK(25, 24));
+}
+
+static inline int get_rx_desc_physt(u8 *__pdesc)
+{
+	return le32_get_bits(*((__le32 *)(__pdesc)), BIT(26));
+}
+
+static inline int get_rx_desc_swdec(u8 *__pdesc)
+{
+	return le32_get_bits(*((__le32 *)(__pdesc)), BIT(27));
+}
+
+static inline int get_rx_desc_own(u8 *__pdesc)
+{
+	return le32_get_bits(*((__le32 *)(__pdesc)), BIT(31));
+}
+
+static inline void set_rx_desc_pkt_len(u8 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__le32 *)(__pdesc), __val, GENMASK(13, 0));
+}
+
+static inline void set_rx_desc_eor(u8 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__le32 *)(__pdesc), __val, BIT(30));
+}
+
+static inline void set_rx_desc_own(u8 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__le32 *)(__pdesc), __val, BIT(31));
+}
+
+static inline int get_rx_desc_macid(u8 *__pdesc)
+{
+	return le32_get_bits(*((__le32 *)(__pdesc + 4)), GENMASK(6, 0));
+}
+
+static inline int get_rx_desc_paggr(u8 *__pdesc)
+{
+	return le32_get_bits(*((__le32 *)(__pdesc + 4)), BIT(15));
+}
+
+static inline int get_rx_status_desc_rpt_sel(u8 *__pdesc)
+{
+	return le32_get_bits(*((__le32 *)(__pdesc + 4)), BIT(28));
+}
+
+static inline int get_rx_desc_rxmcs(u8 *__pdesc)
+{
+	return le32_get_bits(*((__le32 *)(__pdesc + 12)), GENMASK(6, 0));
+}
+
+static inline int get_rx_status_desc_pattern_match(u8 *__pdesc)
+{
+	return le32_get_bits(*((__le32 *)(__pdesc + 12)), BIT(29));
+}
+
+static inline int get_rx_status_desc_unicast_match(u8 *__pdesc)
+{
+	return le32_get_bits(*((__le32 *)(__pdesc + 12)), BIT(30));
+}
+
+static inline int get_rx_status_desc_magic_match(u8 *__pdesc)
+{
+	return le32_get_bits(*((__le32 *)(__pdesc + 12)), BIT(31));
+}
+
+static inline int get_rx_desc_splcp(u8 *__pdesc)
+{
+	return le32_get_bits(*((__le32 *)(__pdesc + 16)), BIT(0));
+}
+
+static inline int get_rx_desc_bw(u8 *__pdesc)
+{
+	return le32_get_bits(*((__le32 *)(__pdesc + 16)), GENMASK(5, 4));
+}
+
+static inline int get_rx_desc_tsfl(u8 *__pdesc)
+{
+	return le32_to_cpu(*((__le32 *)(__pdesc + 20)));
+}
+
+static inline int get_rx_desc_buff_addr(u8 *__pdesc)
+{
+	return le32_to_cpu(*((__le32 *)(__pdesc + 24)));
+}
+
+static inline void set_rx_desc_buff_addr(u8 *__pdesc, u32 __val)
+{
+	*(__le32 *)(__pdesc + 24) = cpu_to_le32(__val);
+}
 
 /* TX report 2 format in Rx desc*/
 
-#define GET_RX_RPT2_DESC_MACID_VALID_1(__status)		\
-	le32_to_cpu(*((__le32 *)(__status + 16)))
-#define GET_RX_RPT2_DESC_MACID_VALID_2(__status)		\
-	le32_to_cpu(*((__le32 *)(__status + 20)))
-
-#define SET_EARLYMODE_PKTNUM(__paddr, __value)			\
-	le32p_replace_bits((__le32 *)(__paddr), __value, GENMASK(3, 0))
-#define SET_EARLYMODE_LEN0(__paddr, __value)			\
-	le32p_replace_bits((__le32 *)(__paddr), __value, GENMASK(15, 4))
-#define SET_EARLYMODE_LEN1(__paddr, __value)			\
-	le32p_replace_bits((__le32 *)(__paddr), __value, GENMASK(27, 16))
-#define SET_EARLYMODE_LEN2_1(__paddr, __value)			\
-	le32p_replace_bits((__le32 *)(__paddr), __value, GENMASK(31, 28))
-#define SET_EARLYMODE_LEN2_2(__paddr, __value)			\
-	le32p_replace_bits((__le32 *)(__paddr), __value, GENMASK(7, 0))
-#define SET_EARLYMODE_LEN3(__paddr, __value)			\
-	le32p_replace_bits((__le32 *)(__paddr + 4), __value, GENMASK(19, 8))
-#define SET_EARLYMODE_LEN4(__paddr, __value)			\
-	le32p_replace_bits((__le32 *)(__paddr + 4), __value, GENMASK(31, 20))
+static inline int get_rx_rpt2_desc_macid_valid_1(u8 *__status)
+{
+	return le32_to_cpu(*((__le32 *)(__status + 16)));
+}
+
+static inline int get_rx_rpt2_desc_macid_valid_2(u8 *__status)
+{
+	return le32_to_cpu(*((__le32 *)(__status + 20)));
+}
+
+static inline void set_earlymode_pktnum(u8 *__paddr, u32 __value)
+{
+	le32p_replace_bits((__le32 *)(__paddr), __value, GENMASK(3, 0));
+}
+
+static inline void set_earlymode_len0(u8 *__paddr, u32 __value)
+{
+	le32p_replace_bits((__le32 *)(__paddr), __value, GENMASK(15, 4));
+}
+
+static inline void set_earlymode_len1(u8 *__paddr, u32 __value)
+{
+	le32p_replace_bits((__le32 *)(__paddr), __value, GENMASK(27, 16));
+}
+
+static inline void set_earlymode_len2_1(u8 *__paddr, u32 __value)
+{
+	le32p_replace_bits((__le32 *)(__paddr), __value, GENMASK(31, 28));
+}
+
+static inline void set_earlymode_len2_2(u8 *__paddr, u32 __value)
+{
+	le32p_replace_bits((__le32 *)(__paddr), __value, GENMASK(7, 0));
+}
+
+static inline void set_earlymode_len3(u8 *__paddr, u32 __value)
+{
+	le32p_replace_bits((__le32 *)(__paddr + 4), __value, GENMASK(19, 8));
+}
+
+static inline void set_earlymode_len4(u8 *__paddr, u32 __value)
+{
+	le32p_replace_bits((__le32 *)(__paddr + 4), __value, GENMASK(31, 20));
+}
 
 #define CLEAR_PCI_TX_DESC_CONTENT(__pdesc, _size)		\
 do {								\
-- 
2.21.0

