Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE2CACA88
	for <lists+linux-wireless@lfdr.de>; Sun,  8 Sep 2019 06:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbfIHEDo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 8 Sep 2019 00:03:44 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:42991 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726217AbfIHEDo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 8 Sep 2019 00:03:44 -0400
Received: by mail-ot1-f68.google.com with SMTP id c10so9392457otd.9
        for <linux-wireless@vger.kernel.org>; Sat, 07 Sep 2019 21:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=41ABdIXrrS/oNYi7ldeUpjemtoR/lz5nyFXJpX4BAOE=;
        b=NUAheYayBn2kNHq4LIFPLowC8K9GDe8OrD+LP288yuAtj4+4IZoHai6lURnSfIbOWN
         /k8YSCAHXcgCk34ejyf7T0z4R9u62oWHVeuNaTGJ5g8j0ZaA9AncXFY/sz5M8JEa03vt
         GQ+yMfbn9O7nPX9V/Lgo8+wpjbPIwYRpcN0h9TNmjNje46BuYG8zt70pkWoFjqKDT3wR
         u98mUpvpwa01yH3uxSZEzMw/5YBszlEzq8wLNaCp1xWtolSOI29sIwwtyg+uEgUN4Lfo
         w8PTwrwsmJLZ8dU1vcLLZQDUGsoxopUkIPDO0BaJGkNkg1OjZ6pFpEFJj6k8DLxJhVBe
         52Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=41ABdIXrrS/oNYi7ldeUpjemtoR/lz5nyFXJpX4BAOE=;
        b=i00RGA8HBSMzibzeO4PaKg2Au3jDzJ+HHQ0ckLosq1dN3NGAdkPvJvPe4m+Y0y9isX
         XtbkJfaGcIALR2M2RwF9vMUcIVC2z96+iAV5pamysXbLmSz0MndBdXPJwelorFrgnK1F
         NQZczyAVRj0rFqJKHpTPFuRbzGvNSO/sO2EOfYckm+w7XR4H1+zkFkgxGHfyipjXq+VL
         0E2MicXM1gHMVa0y88hn8lPa2nMErkqc408PXwqKmqyOxjRHLiyMN/eEpWgUWQXEoq1H
         rZlGrjS27n7yUUPhdYmh9Srf1aAcGCJ08nl9jkErdqbkbO4V6x2KPKpEuGrz/ECv8pao
         FROw==
X-Gm-Message-State: APjAAAUuzMEmeW7GHe4ccKz5dv5XMsJqpgMDQ+qF+3mdD4I0WEB5nSwD
        P5pOiWHilDIX01k3aGRhokk=
X-Google-Smtp-Source: APXvYqz2D2iNdF1kZnJjlcpjtHQuYL5p20bydytpANFDdvoEXnGhhXT+3H2Tdw5Ge5feMpL5+i+Ijg==
X-Received: by 2002:a9d:68d6:: with SMTP id i22mr4536015oto.232.1567915422180;
        Sat, 07 Sep 2019 21:03:42 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id x80sm1419178oia.37.2019.09.07.21.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Sep 2019 21:03:41 -0700 (PDT)
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, pkshih@realtek.com,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH 3/9] rtlwifi: rtl8723ae: Convert macros that set descriptor
Date:   Sat,  7 Sep 2019 23:03:29 -0500
Message-Id: <20190908040335.19838-4-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190908040335.19838-1-Larry.Finger@lwfinger.net>
References: <20190908040335.19838-1-Larry.Finger@lwfinger.net>
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
That will be changed in the next patch.

Several places where checkpatch.pl reports lines too long are fixed.

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
---
 .../wireless/realtek/rtlwifi/rtl8723ae/trx.c  | 190 +++----
 .../wireless/realtek/rtlwifi/rtl8723ae/trx.h  | 466 ++++++++++++------
 2 files changed, 411 insertions(+), 245 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/trx.c b/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/trx.c
index 90dc91b0d35b..84557ce07f38 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/trx.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/trx.c
@@ -264,24 +264,24 @@ bool rtl8723e_rx_query_desc(struct ieee80211_hw *hw,
 {
 	struct rx_fwinfo_8723e *p_drvinfo;
 	struct ieee80211_hdr *hdr;
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
-	status->isfirst_ampdu = (bool)((GET_RX_DESC_PAGGR(pdesc) == 1) &&
-				       (GET_RX_DESC_FAGGR(pdesc) == 1));
-	status->timestamp_low = GET_RX_DESC_TSFL(pdesc);
-	status->rx_is40mhzpacket = (bool)GET_RX_DESC_BW(pdesc);
-	status->is_ht = (bool)GET_RX_DESC_RXHT(pdesc);
+	status->decrypted = !get_rx_desc_swdec(pdesc);
+	status->rate = (u8)get_rx_desc_rxmcs(pdesc);
+	status->shortpreamble = (u16)get_rx_desc_splcp(pdesc);
+	status->isampdu = (bool)(get_rx_desc_paggr(pdesc) == 1);
+	status->isfirst_ampdu = (bool)((get_rx_desc_paggr(pdesc) == 1) &&
+				       (get_rx_desc_faggr(pdesc) == 1));
+	status->timestamp_low = get_rx_desc_tsfl(pdesc);
+	status->rx_is40mhzpacket = (bool)get_rx_desc_bw(pdesc);
+	status->is_ht = (bool)get_rx_desc_rxht(pdesc);
 
 	status->is_cck = RX_HAL_IS_CCK_RATE(status->rate);
 
@@ -391,58 +391,58 @@ void rtl8723e_tx_fill_desc(struct ieee80211_hw *hw,
 	}
 
 	if (firstseg) {
-		SET_TX_DESC_OFFSET(pdesc, USB_HWDESC_HEADER_LEN);
+		set_tx_desc_offset(pdesc, USB_HWDESC_HEADER_LEN);
 
-		SET_TX_DESC_TX_RATE(pdesc, ptcb_desc->hw_rate);
+		set_tx_desc_tx_rate(pdesc, ptcb_desc->hw_rate);
 
 		if (ptcb_desc->use_shortgi || ptcb_desc->use_shortpreamble)
-			SET_TX_DESC_DATA_SHORTGI(pdesc, 1);
+			set_tx_desc_data_shortgi(pdesc, 1);
 
 		if (info->flags & IEEE80211_TX_CTL_AMPDU) {
-			SET_TX_DESC_AGG_BREAK(pdesc, 1);
-			SET_TX_DESC_MAX_AGG_NUM(pdesc, 0x14);
+			set_tx_desc_agg_break(pdesc, 1);
+			set_tx_desc_max_agg_num(pdesc, 0x14);
 		}
-		SET_TX_DESC_SEQ(pdesc, seq_number);
+		set_tx_desc_seq(pdesc, seq_number);
 
-		SET_TX_DESC_RTS_ENABLE(pdesc,
+		set_tx_desc_rts_enable(pdesc,
 				       ((ptcb_desc->rts_enable &&
 					!ptcb_desc->cts_enable) ? 1 : 0));
-		SET_TX_DESC_HW_RTS_ENABLE(pdesc,
+		set_tx_desc_hw_rts_enable(pdesc,
 					  ((ptcb_desc->rts_enable ||
 					  ptcb_desc->cts_enable) ? 1 : 0));
-		SET_TX_DESC_CTS2SELF(pdesc,
+		set_tx_desc_cts2self(pdesc,
 				     ((ptcb_desc->cts_enable) ? 1 : 0));
-		SET_TX_DESC_RTS_STBC(pdesc,
+		set_tx_desc_rts_stbc(pdesc,
 				     ((ptcb_desc->rts_stbc) ? 1 : 0));
 
-		SET_TX_DESC_RTS_RATE(pdesc, ptcb_desc->rts_rate);
-		SET_TX_DESC_RTS_BW(pdesc, 0);
-		SET_TX_DESC_RTS_SC(pdesc, ptcb_desc->rts_sc);
-		SET_TX_DESC_RTS_SHORT(pdesc,
+		set_tx_desc_rts_rate(pdesc, ptcb_desc->rts_rate);
+		set_tx_desc_rts_bw(pdesc, 0);
+		set_tx_desc_rts_sc(pdesc, ptcb_desc->rts_sc);
+		set_tx_desc_rts_short(pdesc,
 				((ptcb_desc->rts_rate <= DESC92C_RATE54M) ?
 				(ptcb_desc->rts_use_shortpreamble ? 1 : 0)
 				: (ptcb_desc->rts_use_shortgi ? 1 : 0)));
 
 		if (bw_40) {
 			if (ptcb_desc->packet_bw == HT_CHANNEL_WIDTH_20_40) {
-				SET_TX_DESC_DATA_BW(pdesc, 1);
-				SET_TX_DESC_TX_SUB_CARRIER(pdesc, 3);
+				set_tx_desc_data_bw(pdesc, 1);
+				set_tx_desc_tx_sub_carrier(pdesc, 3);
 			} else {
-				SET_TX_DESC_DATA_BW(pdesc, 0);
-				SET_TX_DESC_TX_SUB_CARRIER(pdesc,
+				set_tx_desc_data_bw(pdesc, 0);
+				set_tx_desc_tx_sub_carrier(pdesc,
 					mac->cur_40_prime_sc);
 			}
 		} else {
-			SET_TX_DESC_DATA_BW(pdesc, 0);
-			SET_TX_DESC_TX_SUB_CARRIER(pdesc, 0);
+			set_tx_desc_data_bw(pdesc, 0);
+			set_tx_desc_tx_sub_carrier(pdesc, 0);
 		}
 
-		SET_TX_DESC_LINIP(pdesc, 0);
-		SET_TX_DESC_PKT_SIZE(pdesc, (u16) skb->len);
+		set_tx_desc_linip(pdesc, 0);
+		set_tx_desc_pkt_size(pdesc, (u16)skb->len);
 
 		if (sta) {
 			u8 ampdu_density = sta->ht_cap.ampdu_density;
-			SET_TX_DESC_AMPDU_DENSITY(pdesc, ampdu_density);
+			set_tx_desc_ampdu_density(pdesc, ampdu_density);
 		}
 
 		if (info->control.hw_key) {
@@ -453,66 +453,66 @@ void rtl8723e_tx_fill_desc(struct ieee80211_hw *hw,
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
 
-		SET_TX_DESC_PKT_ID(pdesc, 0);
-		SET_TX_DESC_QUEUE_SEL(pdesc, fw_qsel);
+		set_tx_desc_pkt_id(pdesc, 0);
+		set_tx_desc_queue_sel(pdesc, fw_qsel);
 
-		SET_TX_DESC_DATA_RATE_FB_LIMIT(pdesc, 0x1F);
-		SET_TX_DESC_RTS_RATE_FB_LIMIT(pdesc, 0xF);
-		SET_TX_DESC_DISABLE_FB(pdesc, 0);
-		SET_TX_DESC_USE_RATE(pdesc, ptcb_desc->use_driver_rate ? 1 : 0);
+		set_tx_desc_data_rate_fb_limit(pdesc, 0x1F);
+		set_tx_desc_rts_rate_fb_limit(pdesc, 0xF);
+		set_tx_desc_disable_fb(pdesc, 0);
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
 	}
 
-	SET_TX_DESC_FIRST_SEG(pdesc, (firstseg ? 1 : 0));
-	SET_TX_DESC_LAST_SEG(pdesc, (lastseg ? 1 : 0));
+	set_tx_desc_first_seg(pdesc, (firstseg ? 1 : 0));
+	set_tx_desc_last_seg(pdesc, (lastseg ? 1 : 0));
 
-	SET_TX_DESC_TX_BUFFER_SIZE(pdesc, (u16) skb->len);
+	set_tx_desc_tx_buffer_size(pdesc, (u16)skb->len);
 
-	SET_TX_DESC_TX_BUFFER_ADDRESS(pdesc, mapping);
+	set_tx_desc_tx_buffer_address(pdesc, mapping);
 
 	if (rtlpriv->dm.useramask) {
-		SET_TX_DESC_RATE_ID(pdesc, ptcb_desc->ratr_index);
-		SET_TX_DESC_MACID(pdesc, ptcb_desc->mac_id);
+		set_tx_desc_rate_id(pdesc, ptcb_desc->ratr_index);
+		set_tx_desc_macid(pdesc, ptcb_desc->mac_id);
 	} else {
-		SET_TX_DESC_RATE_ID(pdesc, 0xC + ptcb_desc->ratr_index);
-		SET_TX_DESC_MACID(pdesc, ptcb_desc->ratr_index);
+		set_tx_desc_rate_id(pdesc, 0xC + ptcb_desc->ratr_index);
+		set_tx_desc_macid(pdesc, ptcb_desc->ratr_index);
 	}
 
 	if ((!ieee80211_is_data_qos(fc)) && ppsc->fwctrl_lps) {
-		SET_TX_DESC_HWSEQ_EN_8723(pdesc, 1);
-		/* SET_TX_DESC_HWSEQ_EN(pdesc, 1); */
-		/* SET_TX_DESC_PKT_ID(pdesc, 8); */
+		set_tx_desc_hwseq_en_8723(pdesc, 1);
+		/* set_tx_desc_hwseq_en(pdesc, 1); */
+		/* set_tx_desc_pkt_id(pdesc, 8); */
 
 		if (!b_defaultadapter)
-			SET_TX_DESC_HWSEQ_SEL_8723(pdesc, 1);
-	/* SET_TX_DESC_QOS(pdesc, 1); */
+			set_tx_desc_hwseq_sel_8723(pdesc, 1);
+	/* set_tx_desc_qos(pdesc, 1); */
 	}
 
-	SET_TX_DESC_MORE_FRAG(pdesc, (lastseg ? 0 : 1));
+	set_tx_desc_more_frag(pdesc, (lastseg ? 0 : 1));
 
 	if (is_multicast_ether_addr(ieee80211_get_DA(hdr)) ||
 	    is_broadcast_ether_addr(ieee80211_get_DA(hdr))) {
-		SET_TX_DESC_BMC(pdesc, 1);
+		set_tx_desc_bmc(pdesc, 1);
 	}
 
 	RT_TRACE(rtlpriv, COMP_SEND, DBG_TRACE, "\n");
@@ -541,41 +541,41 @@ void rtl8723e_tx_fill_cmddesc(struct ieee80211_hw *hw,
 	CLEAR_PCI_TX_DESC_CONTENT(pdesc, TX_DESC_SIZE);
 
 	if (firstseg)
-		SET_TX_DESC_OFFSET(pdesc, USB_HWDESC_HEADER_LEN);
+		set_tx_desc_offset(pdesc, USB_HWDESC_HEADER_LEN);
 
-	SET_TX_DESC_TX_RATE(pdesc, DESC92C_RATE1M);
+	set_tx_desc_tx_rate(pdesc, DESC92C_RATE1M);
 
-	SET_TX_DESC_SEQ(pdesc, 0);
+	set_tx_desc_seq(pdesc, 0);
 
-	SET_TX_DESC_LINIP(pdesc, 0);
+	set_tx_desc_linip(pdesc, 0);
 
-	SET_TX_DESC_QUEUE_SEL(pdesc, fw_queue);
+	set_tx_desc_queue_sel(pdesc, fw_queue);
 
-	SET_TX_DESC_FIRST_SEG(pdesc, 1);
-	SET_TX_DESC_LAST_SEG(pdesc, 1);
+	set_tx_desc_first_seg(pdesc, 1);
+	set_tx_desc_last_seg(pdesc, 1);
 
-	SET_TX_DESC_TX_BUFFER_SIZE(pdesc, (u16) (skb->len));
+	set_tx_desc_tx_buffer_size(pdesc, (u16)(skb->len));
 
-	SET_TX_DESC_TX_BUFFER_ADDRESS(pdesc, mapping);
+	set_tx_desc_tx_buffer_address(pdesc, mapping);
 
-	SET_TX_DESC_RATE_ID(pdesc, 7);
-	SET_TX_DESC_MACID(pdesc, 0);
+	set_tx_desc_rate_id(pdesc, 7);
+	set_tx_desc_macid(pdesc, 0);
 
-	SET_TX_DESC_OWN(pdesc, 1);
+	set_tx_desc_own(pdesc, 1);
 
-	SET_TX_DESC_PKT_SIZE((u8 *)pdesc, (u16)(skb->len));
+	set_tx_desc_pkt_size((u8 *)pdesc, (u16)(skb->len));
 
-	SET_TX_DESC_FIRST_SEG(pdesc, 1);
-	SET_TX_DESC_LAST_SEG(pdesc, 1);
+	set_tx_desc_first_seg(pdesc, 1);
+	set_tx_desc_last_seg(pdesc, 1);
 
-	SET_TX_DESC_OFFSET(pdesc, 0x20);
+	set_tx_desc_offset(pdesc, 0x20);
 
-	SET_TX_DESC_USE_RATE(pdesc, 1);
+	set_tx_desc_use_rate(pdesc, 1);
 
 	if (!ieee80211_is_data_qos(fc)) {
-		SET_TX_DESC_HWSEQ_EN_8723(pdesc, 1);
-		/* SET_TX_DESC_HWSEQ_EN(pdesc, 1); */
-		/* SET_TX_DESC_PKT_ID(pdesc, 8); */
+		set_tx_desc_hwseq_en_8723(pdesc, 1);
+		/* set_tx_desc_hwseq_en(pdesc, 1); */
+		/* set_tx_desc_pkt_id(pdesc, 8); */
 	}
 
 	RT_PRINT_DATA(rtlpriv, COMP_CMD, DBG_LOUD,
@@ -589,10 +589,10 @@ void rtl8723e_set_desc(struct ieee80211_hw *hw, u8 *pdesc,
 	if (istx == true) {
 		switch (desc_name) {
 		case HW_DESC_OWN:
-			SET_TX_DESC_OWN(pdesc, 1);
+			set_tx_desc_own(pdesc, 1);
 			break;
 		case HW_DESC_TX_NEXTDESC_ADDR:
-			SET_TX_DESC_NEXT_DESC_ADDRESS(pdesc, *(u32 *) val);
+			set_tx_desc_next_desc_address(pdesc, *(u32 *)val);
 			break;
 		default:
 			WARN_ONCE(true, "rtl8723ae: ERR txdesc :%d not processed\n",
@@ -602,16 +602,16 @@ void rtl8723e_set_desc(struct ieee80211_hw *hw, u8 *pdesc,
 	} else {
 		switch (desc_name) {
 		case HW_DESC_RXOWN:
-			SET_RX_DESC_OWN(pdesc, 1);
+			set_rx_desc_own(pdesc, 1);
 			break;
 		case HW_DESC_RXBUFF_ADDR:
-			SET_RX_DESC_BUFF_ADDR(pdesc, *(u32 *) val);
+			set_rx_desc_buff_addr(pdesc, *(u32 *)val);
 			break;
 		case HW_DESC_RXPKT_LEN:
-			SET_RX_DESC_PKT_LEN(pdesc, *(u32 *) val);
+			set_rx_desc_pkt_len(pdesc, *(u32 *)val);
 			break;
 		case HW_DESC_RXERO:
-			SET_RX_DESC_EOR(pdesc, 1);
+			set_rx_desc_eor(pdesc, 1);
 			break;
 		default:
 			WARN_ONCE(true, "rtl8723ae: ERR rxdesc :%d not processed\n",
@@ -629,10 +629,10 @@ u64 rtl8723e_get_desc(struct ieee80211_hw *hw,
 	if (istx == true) {
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
 			WARN_ONCE(true, "rtl8723ae: ERR txdesc :%d not processed\n",
@@ -642,13 +642,13 @@ u64 rtl8723e_get_desc(struct ieee80211_hw *hw,
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
 			WARN_ONCE(true, "rtl8723ae: ERR rxdesc :%d not processed\n",
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/trx.h b/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/trx.h
index b116181366b6..156f0f56a7b5 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/trx.h
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/trx.h
@@ -14,158 +14,324 @@
 #define USB_HWDESC_HEADER_LEN			32
 #define CRCLENGTH						4
 
-#define SET_TX_DESC_PKT_SIZE(__pdesc, __val)		\
-	le32p_replace_bits((__le32 *)__pdesc, __val, GENMASK(15, 0))
-#define SET_TX_DESC_OFFSET(__pdesc, __val)			\
-	le32p_replace_bits((__le32 *)__pdesc, __val, GENMASK(23, 16))
-#define SET_TX_DESC_BMC(__pdesc, __val)				\
-	le32p_replace_bits((__le32 *)__pdesc, __val, BIT(24))
-#define SET_TX_DESC_HTC(__pdesc, __val)				\
-	le32p_replace_bits((__le32 *)__pdesc, __val, BIT(25))
-#define SET_TX_DESC_LAST_SEG(__pdesc, __val)		\
-	le32p_replace_bits((__le32 *)__pdesc, __val, BIT(26))
-#define SET_TX_DESC_FIRST_SEG(__pdesc, __val)		\
-	le32p_replace_bits((__le32 *)__pdesc, __val, BIT(27))
-#define SET_TX_DESC_LINIP(__pdesc, __val)			\
-	le32p_replace_bits((__le32 *)__pdesc, __val, BIT(28))
-#define SET_TX_DESC_OWN(__pdesc, __val)				\
-	le32p_replace_bits((__le32 *)__pdesc, __val, BIT(31))
-
-#define GET_TX_DESC_OWN(__pdesc)				\
-	le32_get_bits(*(__le32 *)__pdesc, BIT(31))
-
-#define SET_TX_DESC_MACID(__pdesc, __val)			\
-	le32p_replace_bits((__le32 *)(__pdesc + 4), __val, GENMASK(4, 0))
-#define SET_TX_DESC_AGG_BREAK(__pdesc, __val)		\
-	le32p_replace_bits((__le32 *)(__pdesc + 4), __val, BIT(5))
-#define SET_TX_DESC_RDG_ENABLE(__pdesc, __val)		\
-	le32p_replace_bits((__le32 *)(__pdesc + 4), __val, BIT(7))
-#define SET_TX_DESC_QUEUE_SEL(__pdesc, __val)		\
-	le32p_replace_bits((__le32 *)(__pdesc + 4), __val, GENMASK(12, 8))
-#define SET_TX_DESC_RATE_ID(__pdesc, __val)		\
-	le32p_replace_bits((__le32 *)(__pdesc + 4), __val, GENMASK(19, 16))
-#define SET_TX_DESC_SEC_TYPE(__pdesc, __val)		\
-	le32p_replace_bits((__le32 *)(__pdesc + 4), __val, GENMASK(23, 22))
-
-#define SET_TX_DESC_MORE_FRAG(__pdesc, __val)		\
-	le32p_replace_bits((__le32 *)(__pdesc + 8), __val, BIT(17))
-#define SET_TX_DESC_AMPDU_DENSITY(__pdesc, __val)	\
-	le32p_replace_bits((__le32 *)(__pdesc + 8), __val, GENMASK(22, 20))
-
-#define SET_TX_DESC_SEQ(__pdesc, __val)				\
-	le32p_replace_bits((__le32 *)(__pdesc + 12), __val, GENMASK(27, 16))
-#define SET_TX_DESC_PKT_ID(__pdesc, __val)			\
-	le32p_replace_bits((__le32 *)(__pdesc + 12), __val, GENMASK(31, 28))
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
+static inline u32 get_tx_desc_own(u8 *__pdesc)
+{
+	return le32_get_bits(*(__le32 *)__pdesc, BIT(31));
+}
+
+static inline void set_tx_desc_macid(u8 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__le32 *)(__pdesc + 4), __val, GENMASK(4, 0));
+}
+
+static inline void set_tx_desc_agg_break(u8 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__le32 *)(__pdesc + 4), __val, BIT(5));
+}
+
+static inline void set_tx_desc_rdg_enable(u8 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__le32 *)(__pdesc + 4), __val, BIT(7));
+}
+
+static inline void set_tx_desc_queue_sel(u8 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__le32 *)(__pdesc + 4), __val, GENMASK(12, 8));
+}
+
+static inline void set_tx_desc_rate_id(u8 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__le32 *)(__pdesc + 4), __val, GENMASK(19, 16));
+}
+
+static inline void set_tx_desc_sec_type(u8 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__le32 *)(__pdesc + 4), __val, GENMASK(23, 22));
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
+static inline void set_tx_desc_seq(u8 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__le32 *)(__pdesc + 12), __val, GENMASK(27, 16));
+}
+
+static inline void set_tx_desc_pkt_id(u8 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__le32 *)(__pdesc + 12), __val, GENMASK(31, 28));
+}
 
 /* For RTL8723 */
-#define SET_TX_DESC_HWSEQ_EN_8723(__pdesc, __val)   \
-	le32p_replace_bits((__le32 *)(__pdesc + 12), __val, BIT(31))
-#define SET_TX_DESC_HWSEQ_SEL_8723(__txdesc, __value) \
-	le32p_replace_bits((__le32 *)(__txdesc + 16), __value, GENMASK(7, 6))
-
-#define SET_TX_DESC_RTS_RATE(__pdesc, __val)		\
-	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, GENMASK(4, 0))
-#define SET_TX_DESC_USE_RATE(__pdesc, __val)		\
-	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, BIT(8))
-#define SET_TX_DESC_DISABLE_FB(__pdesc, __val)		\
-	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, BIT(10))
-#define SET_TX_DESC_CTS2SELF(__pdesc, __val)		\
-	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, BIT(11))
-#define SET_TX_DESC_RTS_ENABLE(__pdesc, __val)		\
-	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, BIT(12))
-#define SET_TX_DESC_HW_RTS_ENABLE(__pdesc, __val)	\
-	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, BIT(13))
-#define SET_TX_DESC_TX_SUB_CARRIER(__pdesc, __val)	\
-	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, GENMASK(21, 20))
-#define SET_TX_DESC_DATA_BW(__pdesc, __val)		\
-	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, BIT(25))
-#define SET_TX_DESC_RTS_SHORT(__pdesc, __val)		\
-	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, BIT(26))
-#define SET_TX_DESC_RTS_BW(__pdesc, __val)			\
-	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, BIT(27))
-#define SET_TX_DESC_RTS_SC(__pdesc, __val)			\
-	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, GENMASK(29, 28))
-#define SET_TX_DESC_RTS_STBC(__pdesc, __val)		\
-	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, GENMASK(31, 30))
-
-#define SET_TX_DESC_TX_RATE(__pdesc, __val)		\
-	le32p_replace_bits((__le32 *)(__pdesc + 20), __val, GENMASK(5, 0))
-#define SET_TX_DESC_DATA_SHORTGI(__pdesc, __val)	\
-	le32p_replace_bits((__le32 *)(__pdesc + 20), __val, BIT(6))
-#define SET_TX_DESC_DATA_RATE_FB_LIMIT(__pdesc, __val)	\
-	le32p_replace_bits((__le32 *)(__pdesc + 20), __val, GENMASK(12, 8))
-#define SET_TX_DESC_RTS_RATE_FB_LIMIT(__pdesc, __val)	\
-	le32p_replace_bits((__le32 *)(__pdesc + 20), __val, GENMASK(16, 13))
-
-#define SET_TX_DESC_MAX_AGG_NUM(__pdesc, __val)		\
-	le32p_replace_bits((__le32 *)(__pdesc + 24), __val, GENMASK(15, 11))
-
-#define SET_TX_DESC_TX_BUFFER_SIZE(__pdesc, __val)	\
-	le32p_replace_bits((__le32 *)(__pdesc + 28), __val, GENMASK(15, 0))
-
-#define SET_TX_DESC_TX_BUFFER_ADDRESS(__pdesc, __val)	\
-	*(__le32 *)(__pdesc + 32) = cpu_to_le32(__val)
-
-#define GET_TX_DESC_TX_BUFFER_ADDRESS(__pdesc)		\
-	le32_to_cpu(*(__le32 *)(__pdesc + 32))
-
-#define SET_TX_DESC_NEXT_DESC_ADDRESS(__pdesc, __val)	\
-	*(__le32 *)(__pdesc + 40) = cpu_to_le32(__val)
-
-#define GET_RX_DESC_PKT_LEN(__pdesc)			\
-	le32_get_bits(*(__le32 *)__pdesc, GENMASK(13, 0))
-#define GET_RX_DESC_CRC32(__pdesc)				\
-	le32_get_bits(*(__le32 *)__pdesc, BIT(14))
-#define GET_RX_DESC_ICV(__pdesc)				\
-	le32_get_bits(*(__le32 *)__pdesc, BIT(15))
-#define GET_RX_DESC_DRV_INFO_SIZE(__pdesc)		\
-	le32_get_bits(*(__le32 *)__pdesc, GENMASK(19, 16))
-#define GET_RX_DESC_SHIFT(__pdesc)				\
-	le32_get_bits(*(__le32 *)__pdesc, GENMASK(25, 24))
-#define GET_RX_DESC_PHYST(__pdesc)				\
-	le32_get_bits(*(__le32 *)__pdesc, BIT(26))
-#define GET_RX_DESC_SWDEC(__pdesc)				\
-	le32_get_bits(*(__le32 *)__pdesc, BIT(27))
-#define GET_RX_DESC_OWN(__pdesc)				\
-	le32_get_bits(*(__le32 *)__pdesc, BIT(31))
-
-#define SET_RX_DESC_PKT_LEN(__pdesc, __val)	\
-	le32p_replace_bits((__le32 *)__pdesc, __val, GENMASK(13, 0))
-#define SET_RX_DESC_EOR(__pdesc, __val)			\
-	le32p_replace_bits((__le32 *)__pdesc, __val, BIT(30))
-#define SET_RX_DESC_OWN(__pdesc, __val)			\
-	le32p_replace_bits((__le32 *)__pdesc, __val, BIT(31))
-
-#define GET_RX_DESC_PAGGR(__pdesc)				\
-	le32_get_bits(*(__le32 *)(__pdesc + 4), BIT(14))
-#define GET_RX_DESC_FAGGR(__pdesc)				\
-	le32_get_bits(*(__le32 *)(__pdesc + 4), BIT(15))
-
-#define GET_RX_DESC_RXMCS(__pdesc)				\
-	le32_get_bits(*(__le32 *)(__pdesc + 12), GENMASK(5, 0))
-#define GET_RX_DESC_RXHT(__pdesc)				\
-	le32_get_bits(*(__le32 *)(__pdesc + 12), BIT(6))
-#define GET_RX_DESC_SPLCP(__pdesc)				\
-	le32_get_bits(*(__le32 *)(__pdesc + 12), BIT(8))
-#define GET_RX_DESC_BW(__pdesc)					\
-	le32_get_bits(*(__le32 *)(__pdesc + 12), BIT(9))
-
-#define GET_RX_DESC_TSFL(__pdesc)				\
-	le32_to_cpu(*(__le32 *)(__pdesc + 20))
-
-#define GET_RX_DESC_BUFF_ADDR(__pdesc)			\
-	le32_to_cpu(*(__le32 *)(__pdesc + 24))
-
-#define SET_RX_DESC_BUFF_ADDR(__pdesc, __val)	\
-	*(__le32 *)(__pdesc + 24) = cpu_to_le32(__val)
-
-#define CLEAR_PCI_TX_DESC_CONTENT(__pdesc, _size)		\
-do {								\
-	if (_size > TX_DESC_NEXT_DESC_OFFSET)			\
-		memset(__pdesc, 0, TX_DESC_NEXT_DESC_OFFSET);	\
-	else							\
-		memset(__pdesc, 0, _size);			\
-} while (0)
+static inline void set_tx_desc_hwseq_en_8723(u8 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__le32 *)(__pdesc + 12), __val, BIT(31));
+}
+
+static inline void set_tx_desc_hwseq_sel_8723(u8 *__txdesc, u32 __value)
+{
+	le32p_replace_bits((__le32 *)(__txdesc + 16), __value, GENMASK(7, 6));
+}
+
+static inline void set_tx_desc_rts_rate(u8 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, GENMASK(4, 0));
+}
+
+static inline void set_tx_desc_use_rate(u8 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, BIT(8));
+}
+
+static inline void set_tx_desc_disable_fb(u8 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, BIT(10));
+}
+
+static inline void set_tx_desc_cts2self(u8 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, BIT(11));
+}
+
+static inline void set_tx_desc_rts_enable(u8 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, BIT(12));
+}
+
+static inline void set_tx_desc_hw_rts_enable(u8 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, BIT(13));
+}
+
+static inline void set_tx_desc_tx_sub_carrier(u8 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, GENMASK(21, 20));
+}
+
+static inline void set_tx_desc_data_bw(u8 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, BIT(25));
+}
+
+static inline void set_tx_desc_rts_short(u8 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, BIT(26));
+}
+
+static inline void set_tx_desc_rts_bw(u8 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, BIT(27));
+}
+
+static inline void set_tx_desc_rts_sc(u8 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, GENMASK(29, 28));
+}
+
+static inline void set_tx_desc_rts_stbc(u8 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, GENMASK(31, 30));
+}
+
+static inline void set_tx_desc_tx_rate(u8 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__le32 *)(__pdesc + 20), __val, GENMASK(5, 0));
+}
+
+static inline void set_tx_desc_data_shortgi(u8 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__le32 *)(__pdesc + 20), __val, BIT(6));
+}
+
+static inline void set_tx_desc_data_rate_fb_limit(u8 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__le32 *)(__pdesc + 20), __val, GENMASK(12, 8));
+}
+
+static inline void set_tx_desc_rts_rate_fb_limit(u8 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__le32 *)(__pdesc + 20), __val, GENMASK(16, 13));
+}
+
+static inline void set_tx_desc_max_agg_num(u8 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__le32 *)(__pdesc + 24), __val, GENMASK(15, 11));
+}
+
+static inline void set_tx_desc_tx_buffer_size(u8 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__le32 *)(__pdesc + 28), __val, GENMASK(15, 0));
+}
+
+static inline void set_tx_desc_tx_buffer_address(u8 *__pdesc, u32 __val)
+{
+	*(__le32 *)(__pdesc + 32) = cpu_to_le32(__val);
+}
+
+static inline u32 get_tx_desc_tx_buffer_address(u8 *__pdesc)
+{
+	return le32_to_cpu(*(__le32 *)(__pdesc + 32));
+}
+
+static inline void set_tx_desc_next_desc_address(u8 *__pdesc, u32 __val)
+{
+	*(__le32 *)(__pdesc + 40) = cpu_to_le32(__val);
+}
+
+static inline u32 get_rx_desc_pkt_len(u8 *__pdesc)
+{
+	return le32_get_bits(*(__le32 *)__pdesc, GENMASK(13, 0));
+}
+
+static inline u32 get_rx_desc_crc32(u8 *__pdesc)
+{
+	return le32_get_bits(*(__le32 *)__pdesc, BIT(14));
+}
+
+static inline u32 get_rx_desc_icv(u8 *__pdesc)
+{
+	return le32_get_bits(*(__le32 *)__pdesc, BIT(15));
+}
+
+static inline u32 get_rx_desc_drv_info_size(u8 *__pdesc)
+{
+	return le32_get_bits(*(__le32 *)__pdesc, GENMASK(19, 16));
+}
+
+static inline u32 get_rx_desc_shift(u8 *__pdesc)
+{
+	return le32_get_bits(*(__le32 *)__pdesc, GENMASK(25, 24));
+}
+
+static inline u32 get_rx_desc_physt(u8 *__pdesc)
+{
+	return le32_get_bits(*(__le32 *)__pdesc, BIT(26));
+}
+
+static inline u32 get_rx_desc_swdec(u8 *__pdesc)
+{
+	return le32_get_bits(*(__le32 *)__pdesc, BIT(27));
+}
+
+static inline u32 get_rx_desc_own(u8 *__pdesc)
+{
+	return le32_get_bits(*(__le32 *)__pdesc, BIT(31));
+}
+
+static inline void set_rx_desc_pkt_len(u8 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__le32 *)__pdesc, __val, GENMASK(13, 0));
+}
+
+static inline void set_rx_desc_eor(u8 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__le32 *)__pdesc, __val, BIT(30));
+}
+
+static inline void set_rx_desc_own(u8 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__le32 *)__pdesc, __val, BIT(31));
+}
+
+static inline u32 get_rx_desc_paggr(u8 *__pdesc)
+{
+	return le32_get_bits(*(__le32 *)(__pdesc + 4), BIT(14));
+}
+
+static inline u32 get_rx_desc_faggr(u8 *__pdesc)
+{
+	return le32_get_bits(*(__le32 *)(__pdesc + 4), BIT(15));
+}
+
+static inline u32 get_rx_desc_rxmcs(u8 *__pdesc)
+{
+	return le32_get_bits(*(__le32 *)(__pdesc + 12), GENMASK(5, 0));
+}
+
+static inline u32 get_rx_desc_rxht(u8 *__pdesc)
+{
+	return le32_get_bits(*(__le32 *)(__pdesc + 12), BIT(6));
+}
+
+static inline u32 get_rx_desc_splcp(u8 *__pdesc)
+{
+	return le32_get_bits(*(__le32 *)(__pdesc + 12), BIT(8));
+}
+
+static inline u32 get_rx_desc_bw(u8 *__pdesc)
+{
+	return le32_get_bits(*(__le32 *)(__pdesc + 12), BIT(9));
+}
+
+static inline u32 get_rx_desc_tsfl(u8 *__pdesc)
+{
+	return le32_to_cpu(*(__le32 *)(__pdesc + 20));
+}
+
+static inline u32 get_rx_desc_buff_addr(u8 *__pdesc)
+{
+	return le32_to_cpu(*(__le32 *)(__pdesc + 24));
+}
+
+static inline void set_rx_desc_buff_addr(u8 *__pdesc, u32 __val)
+{
+	*(__le32 *)(__pdesc + 24) = cpu_to_le32(__val);
+}
+
+static inline void CLEAR_PCI_TX_DESC_CONTENT(u8 *__pdesc, u32 _size)
+{
+	if (_size > TX_DESC_NEXT_DESC_OFFSET)
+		memset(__pdesc, 0, TX_DESC_NEXT_DESC_OFFSET);
+	else
+		memset(__pdesc, 0, _size);
+}
 
 struct rx_fwinfo_8723e {
 	u8 gain_trsw[4];
-- 
2.23.0

