Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86A72105C32
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Nov 2019 22:44:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbfKUVo1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 Nov 2019 16:44:27 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:38952 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbfKUVo0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 Nov 2019 16:44:26 -0500
Received: by mail-ot1-f68.google.com with SMTP id w24so4374770otk.6
        for <linux-wireless@vger.kernel.org>; Thu, 21 Nov 2019 13:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Egz7PsCpUyrlde1Qs2W2+KETuDhv/NJBZ9Q816D/sNY=;
        b=G6d948on4rA/kziOHeClDLcqIwRJ1y9up2ptoj346w96qQecMC3KMvz6PeJp7ofWyt
         FFR7sCFodY2AZN1QgZHuNcUWjftaCWpRJD65uaYeaaDxOmdARkScZdUzddyrq/iGjEXm
         OL6p02DmP4Otz2N2iEM5okpMsCopWGLTLyQviu2zN8uTr5rKtdhDTWOuySy4tMQtA4EQ
         BaoxhcUo5vhVqFDsCTcjksz1vmXBAWpPONL+MebtPJ4ErxvXIen13tUG3/j0AYwLwN/O
         iUhI6f95Eqlc5bBDED1mp4SgA1hilCZo3GueDepKPyrk17hFBjhCN9ulnAJM2BPajLDZ
         nCXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=Egz7PsCpUyrlde1Qs2W2+KETuDhv/NJBZ9Q816D/sNY=;
        b=ElBv1h6hHi6M6h6m4XqVTErsrceQ60r+Xrs8k/r5I85cIYGErcfnMbRwm92+FCcsq9
         mOxqgl0dcp/3LLLJuh/47dcJMq3bONog9OAeb5cHMspYtsIflZrWveWoi+NNdSh69KPs
         ZIxeJinc+S+BoYc3TxTvUyNPFqjQY0NMaMZG7RJMJbHzQCvd4xVTDo0n7qtvgjcDb78v
         rB5GGN+VyTQ3jTeXcmsrqn3e13pkp7kzFiPqGybvcF1zDiQTe2Cwd23TQ1gunnvLN9FI
         q5+Wks07Ty0m4eGxfu1a7aqi3Kf5l4BRmh2jwmH4WxeGJGvV4rRPirsud6GgXC/BWgy7
         jHfQ==
X-Gm-Message-State: APjAAAXphjBlFoBySmhjc85IYdtTKuWTnMyS53y4x5oERv1qbMl5iFgA
        rUetfSBxKJo3+OZK+t6cO+Eyl8gz
X-Google-Smtp-Source: APXvYqwlBT1O+S6ZBKCccypPz425FTvAka7eKQbjc0wu89ODc8v6N1q/KX7pRwYHjKFH5RMsRYDEzQ==
X-Received: by 2002:a9d:7985:: with SMTP id h5mr7829216otm.20.1574372663515;
        Thu, 21 Nov 2019 13:44:23 -0800 (PST)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id x82sm1333854oix.29.2019.11.21.13.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 13:44:22 -0800 (PST)
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, pkshih@realtek.com,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH 3/4] rtlwifi: rtl8192de: Convert macros that set descriptor
Date:   Thu, 21 Nov 2019 15:44:16 -0600
Message-Id: <20191121214417.29676-4-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191121214417.29676-1-Larry.Finger@lwfinger.net>
References: <20191121214417.29676-1-Larry.Finger@lwfinger.net>
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

Several places where checkpatch.pl complains about a space after a cast
and other warnings are fixed.

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
---
 .../wireless/realtek/rtlwifi/rtl8192de/trx.c  | 229 ++++----
 .../wireless/realtek/rtlwifi/rtl8192de/trx.h  | 498 ++++++++++++------
 2 files changed, 458 insertions(+), 269 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c
index 92c9fb45f800..18361f22337d 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c
@@ -438,49 +438,49 @@ static void _rtl92de_translate_rx_signal_stuff(struct ieee80211_hw *hw,
 
 bool rtl92de_rx_query_desc(struct ieee80211_hw *hw,	struct rtl_stats *stats,
 		struct ieee80211_rx_status *rx_status,
-		u8 *p_desc, struct sk_buff *skb)
+		u8 *pdesc, struct sk_buff *skb)
 {
 	struct rx_fwinfo_92d *p_drvinfo;
-	struct rx_desc_92d *pdesc = (struct rx_desc_92d *)p_desc;
-	u32 phystatus = GET_RX_DESC_PHYST(pdesc);
+	u32 phystatus = get_rx_desc_physt(pdesc);
 
-	stats->length = (u16) GET_RX_DESC_PKT_LEN(pdesc);
-	stats->rx_drvinfo_size = (u8) GET_RX_DESC_DRV_INFO_SIZE(pdesc) *
+	stats->length = (u16)get_rx_desc_pkt_len(pdesc);
+	stats->rx_drvinfo_size = (u8)get_rx_desc_drv_info_size(pdesc) *
 				 RX_DRV_INFO_SIZE_UNIT;
-	stats->rx_bufshift = (u8) (GET_RX_DESC_SHIFT(pdesc) & 0x03);
-	stats->icv = (u16) GET_RX_DESC_ICV(pdesc);
-	stats->crc = (u16) GET_RX_DESC_CRC32(pdesc);
+	stats->rx_bufshift = (u8)(get_rx_desc_shift(pdesc) & 0x03);
+	stats->icv = (u16)get_rx_desc_icv(pdesc);
+	stats->crc = (u16)get_rx_desc_crc32(pdesc);
 	stats->hwerror = (stats->crc | stats->icv);
-	stats->decrypted = !GET_RX_DESC_SWDEC(pdesc);
-	stats->rate = (u8) GET_RX_DESC_RXMCS(pdesc);
-	stats->shortpreamble = (u16) GET_RX_DESC_SPLCP(pdesc);
-	stats->isampdu = (bool) (GET_RX_DESC_PAGGR(pdesc) == 1);
-	stats->isfirst_ampdu = (bool) ((GET_RX_DESC_PAGGR(pdesc) == 1)
-					 && (GET_RX_DESC_FAGGR(pdesc) == 1));
-	stats->timestamp_low = GET_RX_DESC_TSFL(pdesc);
-	stats->rx_is40mhzpacket = (bool)GET_RX_DESC_BW(pdesc);
-	stats->is_ht = (bool)GET_RX_DESC_RXHT(pdesc);
+	stats->decrypted = !get_rx_desc_swdec(pdesc);
+	stats->rate = (u8)get_rx_desc_rxmcs(pdesc);
+	stats->shortpreamble = (u16)get_rx_desc_splcp(pdesc);
+	stats->isampdu = (bool)(get_rx_desc_paggr(pdesc) == 1);
+	stats->isfirst_ampdu = (bool)((get_rx_desc_paggr(pdesc) == 1) &&
+				      (get_rx_desc_faggr(pdesc) == 1));
+	stats->timestamp_low = get_rx_desc_tsfl(pdesc);
+	stats->rx_is40mhzpacket = (bool)get_rx_desc_bw(pdesc);
+	stats->is_ht = (bool)get_rx_desc_rxht(pdesc);
 	rx_status->freq = hw->conf.chandef.chan->center_freq;
 	rx_status->band = hw->conf.chandef.chan->band;
-	if (GET_RX_DESC_CRC32(pdesc))
+	if (get_rx_desc_crc32(pdesc))
 		rx_status->flag |= RX_FLAG_FAILED_FCS_CRC;
-	if (!GET_RX_DESC_SWDEC(pdesc))
+	if (!get_rx_desc_swdec(pdesc))
 		rx_status->flag |= RX_FLAG_DECRYPTED;
-	if (GET_RX_DESC_BW(pdesc))
+	if (get_rx_desc_bw(pdesc))
 		rx_status->bw = RATE_INFO_BW_40;
-	if (GET_RX_DESC_RXHT(pdesc))
+	if (get_rx_desc_rxht(pdesc))
 		rx_status->encoding = RX_ENC_HT;
 	rx_status->flag |= RX_FLAG_MACTIME_START;
 	if (stats->decrypted)
 		rx_status->flag |= RX_FLAG_DECRYPTED;
 	rx_status->rate_idx = rtlwifi_rate_mapping(hw, stats->is_ht,
 						   false, stats->rate);
-	rx_status->mactime = GET_RX_DESC_TSFL(pdesc);
+	rx_status->mactime = get_rx_desc_tsfl(pdesc);
 	if (phystatus) {
 		p_drvinfo = (struct rx_fwinfo_92d *)(skb->data +
 						     stats->rx_bufshift);
 		_rtl92de_translate_rx_signal_stuff(hw,
-						   skb, stats, pdesc,
+						   skb, stats,
+						   (struct rx_desc_92d *)pdesc,
 						   p_drvinfo);
 	}
 	/*rx_status->qual = stats->signal; */
@@ -493,13 +493,13 @@ static void _rtl92de_insert_emcontent(struct rtl_tcb_desc *ptcb_desc,
 {
 	memset(virtualaddress, 0, 8);
 
-	SET_EARLYMODE_PKTNUM(virtualaddress, ptcb_desc->empkt_num);
-	SET_EARLYMODE_LEN0(virtualaddress, ptcb_desc->empkt_len[0]);
-	SET_EARLYMODE_LEN1(virtualaddress, ptcb_desc->empkt_len[1]);
-	SET_EARLYMODE_LEN2_1(virtualaddress, ptcb_desc->empkt_len[2] & 0xF);
-	SET_EARLYMODE_LEN2_2(virtualaddress, ptcb_desc->empkt_len[2] >> 4);
-	SET_EARLYMODE_LEN3(virtualaddress, ptcb_desc->empkt_len[3]);
-	SET_EARLYMODE_LEN4(virtualaddress, ptcb_desc->empkt_len[4]);
+	set_earlymode_pktnum(virtualaddress, ptcb_desc->empkt_num);
+	set_earlymode_len0(virtualaddress, ptcb_desc->empkt_len[0]);
+	set_earlymode_len1(virtualaddress, ptcb_desc->empkt_len[1]);
+	set_earlymode_len2_1(virtualaddress, ptcb_desc->empkt_len[2] & 0xF);
+	set_earlymode_len2_2(virtualaddress, ptcb_desc->empkt_len[2] >> 4);
+	set_earlymode_len3(virtualaddress, ptcb_desc->empkt_len[3]);
+	set_earlymode_len4(virtualaddress, ptcb_desc->empkt_len[4]);
 }
 
 void rtl92de_tx_fill_desc(struct ieee80211_hw *hw,
@@ -556,8 +556,8 @@ void rtl92de_tx_fill_desc(struct ieee80211_hw *hw,
 	}
 	if (firstseg) {
 		if (rtlhal->earlymode_enable) {
-			SET_TX_DESC_PKT_OFFSET(pdesc, 1);
-			SET_TX_DESC_OFFSET(pdesc, USB_HWDESC_HEADER_LEN +
+			set_tx_desc_pkt_offset(pdesc, 1);
+			set_tx_desc_offset(pdesc, USB_HWDESC_HEADER_LEN +
 					   EM_HDR_LEN);
 			if (ptcb_desc->empkt_num) {
 				RT_TRACE(rtlpriv, COMP_SEND, DBG_LOUD,
@@ -567,60 +567,61 @@ void rtl92de_tx_fill_desc(struct ieee80211_hw *hw,
 							  (u8 *)(skb->data));
 			}
 		} else {
-			SET_TX_DESC_OFFSET(pdesc, USB_HWDESC_HEADER_LEN);
+			set_tx_desc_offset(pdesc, USB_HWDESC_HEADER_LEN);
 		}
 		/* 5G have no CCK rate */
 		if (rtlhal->current_bandtype == BAND_ON_5G)
 			if (ptcb_desc->hw_rate < DESC_RATE6M)
 				ptcb_desc->hw_rate = DESC_RATE6M;
-		SET_TX_DESC_TX_RATE(pdesc, ptcb_desc->hw_rate);
+		set_tx_desc_tx_rate(pdesc, ptcb_desc->hw_rate);
 		if (ptcb_desc->use_shortgi || ptcb_desc->use_shortpreamble)
-			SET_TX_DESC_DATA_SHORTGI(pdesc, 1);
+			set_tx_desc_data_shortgi(pdesc, 1);
 
 		if (rtlhal->macphymode == DUALMAC_DUALPHY &&
 			ptcb_desc->hw_rate == DESC_RATEMCS7)
-			SET_TX_DESC_DATA_SHORTGI(pdesc, 1);
+			set_tx_desc_data_shortgi(pdesc, 1);
 
 		if (info->flags & IEEE80211_TX_CTL_AMPDU) {
-			SET_TX_DESC_AGG_ENABLE(pdesc, 1);
-			SET_TX_DESC_MAX_AGG_NUM(pdesc, 0x14);
+			set_tx_desc_agg_enable(pdesc, 1);
+			set_tx_desc_max_agg_num(pdesc, 0x14);
 		}
-		SET_TX_DESC_SEQ(pdesc, seq_number);
-		SET_TX_DESC_RTS_ENABLE(pdesc, ((ptcb_desc->rts_enable &&
-				       !ptcb_desc->cts_enable) ? 1 : 0));
-		SET_TX_DESC_HW_RTS_ENABLE(pdesc, ((ptcb_desc->rts_enable
+		set_tx_desc_seq(pdesc, seq_number);
+		set_tx_desc_rts_enable(pdesc,
+				       ((ptcb_desc->rts_enable &&
+					!ptcb_desc->cts_enable) ? 1 : 0));
+		set_tx_desc_hw_rts_enable(pdesc, ((ptcb_desc->rts_enable
 					  || ptcb_desc->cts_enable) ? 1 : 0));
-		SET_TX_DESC_CTS2SELF(pdesc, ((ptcb_desc->cts_enable) ? 1 : 0));
-		SET_TX_DESC_RTS_STBC(pdesc, ((ptcb_desc->rts_stbc) ? 1 : 0));
+		set_tx_desc_cts2self(pdesc, ((ptcb_desc->cts_enable) ? 1 : 0));
+		set_tx_desc_rts_stbc(pdesc, ((ptcb_desc->rts_stbc) ? 1 : 0));
 		/* 5G have no CCK rate */
 		if (rtlhal->current_bandtype == BAND_ON_5G)
 			if (ptcb_desc->rts_rate < DESC_RATE6M)
 				ptcb_desc->rts_rate = DESC_RATE6M;
-		SET_TX_DESC_RTS_RATE(pdesc, ptcb_desc->rts_rate);
-		SET_TX_DESC_RTS_BW(pdesc, 0);
-		SET_TX_DESC_RTS_SC(pdesc, ptcb_desc->rts_sc);
-		SET_TX_DESC_RTS_SHORT(pdesc, ((ptcb_desc->rts_rate <=
+		set_tx_desc_rts_rate(pdesc, ptcb_desc->rts_rate);
+		set_tx_desc_rts_bw(pdesc, 0);
+		set_tx_desc_rts_sc(pdesc, ptcb_desc->rts_sc);
+		set_tx_desc_rts_short(pdesc, ((ptcb_desc->rts_rate <=
 			DESC_RATE54M) ?
 			(ptcb_desc->rts_use_shortpreamble ? 1 : 0) :
 			(ptcb_desc->rts_use_shortgi ? 1 : 0)));
 		if (bw_40) {
 			if (ptcb_desc->packet_bw) {
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
-		SET_TX_DESC_PKT_SIZE(pdesc, (u16) skb_len);
+		set_tx_desc_linip(pdesc, 0);
+		set_tx_desc_pkt_size(pdesc, (u16)skb_len);
 		if (sta) {
 			u8 ampdu_density = sta->ht_cap.ampdu_density;
-			SET_TX_DESC_AMPDU_DENSITY(pdesc, ampdu_density);
+			set_tx_desc_ampdu_density(pdesc, ampdu_density);
 		}
 		if (info->control.hw_key) {
 			struct ieee80211_key_conf *keyconf;
@@ -630,61 +631,61 @@ void rtl92de_tx_fill_desc(struct ieee80211_hw *hw,
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
-		SET_TX_DESC_DATA_RATE_FB_LIMIT(pdesc, 0x1F);
-		SET_TX_DESC_RTS_RATE_FB_LIMIT(pdesc, 0xF);
-		SET_TX_DESC_DISABLE_FB(pdesc, ptcb_desc->disable_ratefallback ?
+		set_tx_desc_pkt_id(pdesc, 0);
+		set_tx_desc_queue_sel(pdesc, fw_qsel);
+		set_tx_desc_data_rate_fb_limit(pdesc, 0x1F);
+		set_tx_desc_rts_rate_fb_limit(pdesc, 0xF);
+		set_tx_desc_disable_fb(pdesc, ptcb_desc->disable_ratefallback ?
 				       1 : 0);
-		SET_TX_DESC_USE_RATE(pdesc, ptcb_desc->use_driver_rate ? 1 : 0);
+		set_tx_desc_use_rate(pdesc, ptcb_desc->use_driver_rate ? 1 : 0);
 
 		/* Set TxRate and RTSRate in TxDesc  */
 		/* This prevent Tx initial rate of new-coming packets */
 		/* from being overwritten by retried  packet rate.*/
 		if (!ptcb_desc->use_driver_rate) {
-			SET_TX_DESC_RTS_RATE(pdesc, 0x08);
-			/* SET_TX_DESC_TX_RATE(pdesc, 0x0b); */
+			set_tx_desc_rts_rate(pdesc, 0x08);
+			/* set_tx_desc_tx_rate(pdesc, 0x0b); */
 		}
 		if (ieee80211_is_data_qos(fc)) {
 			if (mac->rdg_en) {
 				RT_TRACE(rtlpriv, COMP_SEND, DBG_TRACE,
 					 "Enable RDG function\n");
-				SET_TX_DESC_RDG_ENABLE(pdesc, 1);
-				SET_TX_DESC_HTC(pdesc, 1);
+				set_tx_desc_rdg_enable(pdesc, 1);
+				set_tx_desc_htc(pdesc, 1);
 			}
 		}
 	}
 
-	SET_TX_DESC_FIRST_SEG(pdesc, (firstseg ? 1 : 0));
-	SET_TX_DESC_LAST_SEG(pdesc, (lastseg ? 1 : 0));
-	SET_TX_DESC_TX_BUFFER_SIZE(pdesc, (u16) buf_len);
-	SET_TX_DESC_TX_BUFFER_ADDRESS(pdesc, mapping);
+	set_tx_desc_first_seg(pdesc, (firstseg ? 1 : 0));
+	set_tx_desc_last_seg(pdesc, (lastseg ? 1 : 0));
+	set_tx_desc_tx_buffer_size(pdesc, (u16)buf_len);
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
 	if (ieee80211_is_data_qos(fc))
-		SET_TX_DESC_QOS(pdesc, 1);
+		set_tx_desc_qos(pdesc, 1);
 
 	if ((!ieee80211_is_data_qos(fc)) && ppsc->fwctrl_lps) {
-		SET_TX_DESC_HWSEQ_EN(pdesc, 1);
-		SET_TX_DESC_PKT_ID(pdesc, 8);
+		set_tx_desc_hwseq_en(pdesc, 1);
+		set_tx_desc_pkt_id(pdesc, 8);
 	}
-	SET_TX_DESC_MORE_FRAG(pdesc, (lastseg ? 0 : 1));
+	set_tx_desc_more_frag(pdesc, (lastseg ? 0 : 1));
 	RT_TRACE(rtlpriv, COMP_SEND, DBG_TRACE, "\n");
 }
 
@@ -709,40 +710,40 @@ void rtl92de_tx_fill_cmddesc(struct ieee80211_hw *hw,
 	}
 	CLEAR_PCI_TX_DESC_CONTENT(pdesc, TX_DESC_SIZE);
 	if (firstseg)
-		SET_TX_DESC_OFFSET(pdesc, USB_HWDESC_HEADER_LEN);
+		set_tx_desc_offset(pdesc, USB_HWDESC_HEADER_LEN);
 	/* 5G have no CCK rate
 	 * Caution: The macros below are multi-line expansions.
 	 * The braces are needed no matter what checkpatch says
 	 */
 	if (rtlhal->current_bandtype == BAND_ON_5G) {
-		SET_TX_DESC_TX_RATE(pdesc, DESC_RATE6M);
+		set_tx_desc_tx_rate(pdesc, DESC_RATE6M);
 	} else {
-		SET_TX_DESC_TX_RATE(pdesc, DESC_RATE1M);
+		set_tx_desc_tx_rate(pdesc, DESC_RATE1M);
 	}
-	SET_TX_DESC_SEQ(pdesc, 0);
-	SET_TX_DESC_LINIP(pdesc, 0);
-	SET_TX_DESC_QUEUE_SEL(pdesc, fw_queue);
-	SET_TX_DESC_FIRST_SEG(pdesc, 1);
-	SET_TX_DESC_LAST_SEG(pdesc, 1);
-	SET_TX_DESC_TX_BUFFER_SIZE(pdesc, (u16)skb->len);
-	SET_TX_DESC_TX_BUFFER_ADDRESS(pdesc, mapping);
-	SET_TX_DESC_RATE_ID(pdesc, 7);
-	SET_TX_DESC_MACID(pdesc, 0);
-	SET_TX_DESC_PKT_SIZE(pdesc, (u16) (skb->len));
-	SET_TX_DESC_FIRST_SEG(pdesc, 1);
-	SET_TX_DESC_LAST_SEG(pdesc, 1);
-	SET_TX_DESC_OFFSET(pdesc, 0x20);
-	SET_TX_DESC_USE_RATE(pdesc, 1);
+	set_tx_desc_seq(pdesc, 0);
+	set_tx_desc_linip(pdesc, 0);
+	set_tx_desc_queue_sel(pdesc, fw_queue);
+	set_tx_desc_first_seg(pdesc, 1);
+	set_tx_desc_last_seg(pdesc, 1);
+	set_tx_desc_tx_buffer_size(pdesc, (u16)skb->len);
+	set_tx_desc_tx_buffer_address(pdesc, mapping);
+	set_tx_desc_rate_id(pdesc, 7);
+	set_tx_desc_macid(pdesc, 0);
+	set_tx_desc_pkt_size(pdesc, (u16)(skb->len));
+	set_tx_desc_first_seg(pdesc, 1);
+	set_tx_desc_last_seg(pdesc, 1);
+	set_tx_desc_offset(pdesc, 0x20);
+	set_tx_desc_use_rate(pdesc, 1);
 
 	if (!ieee80211_is_data_qos(fc) && ppsc->fwctrl_lps) {
-		SET_TX_DESC_HWSEQ_EN(pdesc, 1);
-		SET_TX_DESC_PKT_ID(pdesc, 8);
+		set_tx_desc_hwseq_en(pdesc, 1);
+		set_tx_desc_pkt_id(pdesc, 8);
 	}
 
 	RT_PRINT_DATA(rtlpriv, COMP_CMD, DBG_LOUD,
 		      "H2C Tx Cmd Content", pdesc, TX_DESC_SIZE);
 	wmb();
-	SET_TX_DESC_OWN(pdesc, 1);
+	set_tx_desc_own(pdesc, 1);
 }
 
 void rtl92de_set_desc(struct ieee80211_hw *hw, u8 *pdesc, bool istx,
@@ -752,10 +753,10 @@ void rtl92de_set_desc(struct ieee80211_hw *hw, u8 *pdesc, bool istx,
 		switch (desc_name) {
 		case HW_DESC_OWN:
 			wmb();
-			SET_TX_DESC_OWN(pdesc, 1);
+			set_tx_desc_own(pdesc, 1);
 			break;
 		case HW_DESC_TX_NEXTDESC_ADDR:
-			SET_TX_DESC_NEXT_DESC_ADDRESS(pdesc, *(u32 *) val);
+			set_tx_desc_next_desc_address(pdesc, *(u32 *)val);
 			break;
 		default:
 			WARN_ONCE(true, "rtl8192de: ERR txdesc :%d not processed\n",
@@ -766,16 +767,16 @@ void rtl92de_set_desc(struct ieee80211_hw *hw, u8 *pdesc, bool istx,
 		switch (desc_name) {
 		case HW_DESC_RXOWN:
 			wmb();
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
 			WARN_ONCE(true, "rtl8192de: ERR rxdesc :%d not processed\n",
@@ -793,10 +794,10 @@ u64 rtl92de_get_desc(struct ieee80211_hw *hw,
 	if (istx) {
 		switch (desc_name) {
 		case HW_DESC_OWN:
-			ret = GET_TX_DESC_OWN(p_desc);
+			ret = get_tx_desc_own(p_desc);
 			break;
 		case HW_DESC_TXBUFF_ADDR:
-			ret = GET_TX_DESC_TX_BUFFER_ADDRESS(p_desc);
+			ret = get_tx_desc_tx_buffer_address(p_desc);
 			break;
 		default:
 			WARN_ONCE(true, "rtl8192de: ERR txdesc :%d not processed\n",
@@ -806,13 +807,13 @@ u64 rtl92de_get_desc(struct ieee80211_hw *hw,
 	} else {
 		switch (desc_name) {
 		case HW_DESC_OWN:
-			ret = GET_RX_DESC_OWN(p_desc);
+			ret = get_rx_desc_own(p_desc);
 			break;
 		case HW_DESC_RXPKT_LEN:
-			ret = GET_RX_DESC_PKT_LEN(p_desc);
-			break;
+			ret = get_rx_desc_pkt_len(p_desc);
+		break;
 		case HW_DESC_RXBUFF_ADDR:
-			ret = GET_RX_DESC_BUFF_ADDR(p_desc);
+			ret = get_rx_desc_buff_addr(p_desc);
 			break;
 		default:
 			WARN_ONCE(true, "rtl8192de: ERR rxdesc :%d not processed\n",
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h
index 5ff1000b2400..fe81196e46b7 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h
@@ -16,167 +16,355 @@
 
 /* macros to read/write various fields in RX or TX descriptors */
 
-#define SET_TX_DESC_PKT_SIZE(__pdesc, __val)		\
-	le32p_replace_bits((__le32 *)__pdesc, __val, GENMASK(15, 0))
-#define SET_TX_DESC_OFFSET(__pdesc, __val)		\
-	le32p_replace_bits((__le32 *)__pdesc, __val, GENMASK(23, 16))
-#define SET_TX_DESC_HTC(__pdesc, __val)			\
-	le32p_replace_bits((__le32 *)__pdesc, __val, BIT(25))
-#define SET_TX_DESC_LAST_SEG(__pdesc, __val)		\
-	le32p_replace_bits((__le32 *)__pdesc, __val, BIT(26))
-#define SET_TX_DESC_FIRST_SEG(__pdesc, __val)		\
-	le32p_replace_bits((__le32 *)__pdesc, __val, BIT(27))
-#define SET_TX_DESC_LINIP(__pdesc, __val)		\
-	le32p_replace_bits((__le32 *)__pdesc, __val, BIT(28))
-#define SET_TX_DESC_OWN(__pdesc, __val)			\
-	le32p_replace_bits((__le32 *)__pdesc, __val, BIT(31))
-
-#define GET_TX_DESC_OWN(__pdesc)			\
-	le32_get_bits(*(__le32 *)__pdesc, BIT(31))
-
-#define SET_TX_DESC_MACID(__pdesc, __val)		\
-	le32p_replace_bits((__le32 *)(__pdesc + 4), __val, GENMASK(4, 0))
-#define SET_TX_DESC_AGG_ENABLE(__pdesc, __val)		\
-	le32p_replace_bits((__le32 *)(__pdesc + 4), __val, BIT(5))
-#define SET_TX_DESC_RDG_ENABLE(__pdesc, __val)		\
-	le32p_replace_bits((__le32 *)(__pdesc + 4), __val, BIT(7))
-#define SET_TX_DESC_QUEUE_SEL(__pdesc, __val)		\
-	le32p_replace_bits((__le32 *)(__pdesc + 4), __val, GENMASK(12, 8))
-#define SET_TX_DESC_RATE_ID(__pdesc, __val)		\
-	le32p_replace_bits((__le32 *)(__pdesc + 4), __val, GENMASK(19, 16))
-#define SET_TX_DESC_SEC_TYPE(__pdesc, __val)		\
-	le32p_replace_bits((__le32 *)(__pdesc + 4), __val, GENMASK(23, 22))
-#define SET_TX_DESC_PKT_OFFSET(__pdesc, __val)		\
-	le32p_replace_bits((__le32 *)(__pdesc + 4), __val, GENMASK(30, 26))
-
-#define SET_TX_DESC_MORE_FRAG(__pdesc, __val)		\
-	le32p_replace_bits((__le32 *)(__pdesc + 8), __val, BIT(17))
-#define SET_TX_DESC_AMPDU_DENSITY(__pdesc, __val)	\
-	le32p_replace_bits((__le32 *)(__pdesc + 8), __val, GENMASK(22, 20))
-
-#define SET_TX_DESC_SEQ(__pdesc, __val)			\
-	le32p_replace_bits((__le32 *)(__pdesc + 12), __val, GENMASK(27, 16))
-#define SET_TX_DESC_PKT_ID(__pdesc, __val)		\
-	le32p_replace_bits((__le32 *)(__pdesc + 12), __val, GENMASK(31, 28))
-
-#define SET_TX_DESC_RTS_RATE(__pdesc, __val)		\
-	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, GENMASK(4, 0))
-#define SET_TX_DESC_QOS(__pdesc, __val)			\
-	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, BIT(6))
-#define SET_TX_DESC_HWSEQ_EN(__pdesc, __val)		\
-	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, BIT(7))
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
-#define SET_TX_DESC_RTS_BW(__pdesc, __val)		\
-	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, BIT(27))
-#define SET_TX_DESC_RTS_SC(__pdesc, __val)		\
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
-#define GET_RX_DESC_CRC32(__pdesc)			\
-	le32_get_bits(*(__le32 *)__pdesc, BIT(14))
-#define GET_RX_DESC_ICV(__pdesc)			\
-	le32_get_bits(*(__le32 *)__pdesc, BIT(15))
-#define GET_RX_DESC_DRV_INFO_SIZE(__pdesc)		\
-	le32_get_bits(*(__le32 *)__pdesc, GENMASK(19, 16))
-#define GET_RX_DESC_SHIFT(__pdesc)			\
-	le32_get_bits(*(__le32 *)__pdesc, GENMASK(25, 24))
-#define GET_RX_DESC_PHYST(__pdesc)			\
-	le32_get_bits(*(__le32 *)__pdesc, BIT(26))
-#define GET_RX_DESC_SWDEC(__pdesc)			\
-	le32_get_bits(*(__le32 *)__pdesc, BIT(27))
-#define GET_RX_DESC_OWN(__pdesc)			\
-	le32_get_bits(*(__le32 *)__pdesc, BIT(31))
-
-#define SET_RX_DESC_PKT_LEN(__pdesc, __val)		\
-	le32p_replace_bits((__le32 *)__pdesc, __val, GENMASK(13, 0))
-#define SET_RX_DESC_EOR(__pdesc, __val)			\
-	le32p_replace_bits((__le32 *)__pdesc, __val, BIT(30))
-#define SET_RX_DESC_OWN(__pdesc, __val)			\
-	le32p_replace_bits((__le32 *)__pdesc, __val, BIT(31))
-
-#define GET_RX_DESC_PAGGR(__pdesc)			\
-	le32_get_bits(*(__le32 *)(__pdesc + 4), BIT(14))
-#define GET_RX_DESC_FAGGR(__pdesc)			\
-	le32_get_bits(*(__le32 *)(__pdesc + 4), BIT(15))
-
-#define GET_RX_DESC_RXMCS(__pdesc)			\
-	le32_get_bits(*(__le32 *)(__pdesc + 12), GENMASK(5, 0))
-#define GET_RX_DESC_RXHT(__pdesc)			\
-	le32_get_bits(*(__le32 *)(__pdesc + 12), BIT(6))
-#define GET_RX_DESC_SPLCP(__pdesc)			\
-	le32_get_bits(*(__le32 *)(__pdesc + 12), BIT(8))
-#define GET_RX_DESC_BW(__pdesc)				\
-	le32_get_bits(*(__le32 *)(__pdesc + 12), BIT(9))
-
-#define GET_RX_DESC_TSFL(__pdesc)			\
-	le32_to_cpu(*(__le32 *)(__pdesc + 20))
-
-#define GET_RX_DESC_BUFF_ADDR(__pdesc)			\
-	le32_to_cpu(*(__le32 *)(__pdesc + 24))
-#define SET_RX_DESC_BUFF_ADDR(__pdesc, __val)		\
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
+static inline void set_tx_desc_agg_enable(u8 *__pdesc, u32 __val)
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
+static inline void set_tx_desc_pkt_offset(u8 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__le32 *)(__pdesc + 4), __val, GENMASK(30, 26));
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
+
+static inline void set_tx_desc_rts_rate(u8 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, GENMASK(4, 0));
+}
+
+static inline void set_tx_desc_qos(u8 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, BIT(6));
+}
+
+static inline void set_tx_desc_hwseq_en(u8 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, BIT(7));
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
 
 #define CLEAR_PCI_TX_DESC_CONTENT(__pdesc, _size)	\
 	memset((void *)__pdesc, 0,			\
 	       min_t(size_t, _size, TX_DESC_NEXT_DESC_OFFSET))
 
 /* For 92D early mode */
-#define SET_EARLYMODE_PKTNUM(__paddr, __value)		\
-	le32p_replace_bits((__le32 *)__paddr, __value, GENMASK(2, 0))
-#define SET_EARLYMODE_LEN0(__paddr, __value)		\
-	le32p_replace_bits((__le32 *)__paddr, __value, GENMASK(15, 4))
-#define SET_EARLYMODE_LEN1(__paddr, __value)		\
-	le32p_replace_bits((__le32 *)__paddr, __value, GENMASK(27, 16))
-#define SET_EARLYMODE_LEN2_1(__paddr, __value)		\
-	le32p_replace_bits((__le32 *)__paddr, __value, GENMASK(31, 28))
-#define SET_EARLYMODE_LEN2_2(__paddr, __value)		\
-	le32p_replace_bits((__le32 *)(__paddr + 4), __value, GENMASK(7, 0))
-#define SET_EARLYMODE_LEN3(__paddr, __value)		\
-	le32p_replace_bits((__le32 *)(__paddr + 4), __value, GENMASK(19, 8))
-#define SET_EARLYMODE_LEN4(__paddr, __value)		\
-	le32p_replace_bits((__le32 *)(__paddr + 4), __value, GENMASK(31, 20))
+static inline void set_earlymode_pktnum(u8 *__paddr, u32 __value)
+{
+	le32p_replace_bits((__le32 *)__paddr, __value, GENMASK(2, 0));
+}
+
+static inline void set_earlymode_len0(u8 *__paddr, u32 __value)
+{
+	le32p_replace_bits((__le32 *)__paddr, __value, GENMASK(15, 4));
+}
+
+static inline void set_earlymode_len1(u8 *__paddr, u32 __value)
+{
+	le32p_replace_bits((__le32 *)__paddr, __value, GENMASK(27, 16));
+}
+
+static inline void set_earlymode_len2_1(u8 *__paddr, u32 __value)
+{
+	le32p_replace_bits((__le32 *)__paddr, __value, GENMASK(31, 28));
+}
+
+static inline void set_earlymode_len2_2(u8 *__paddr, u32 __value)
+{
+	le32p_replace_bits((__le32 *)(__paddr + 4), __value, GENMASK(7, 0));
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
 
 struct rx_fwinfo_92d {
 	u8 gain_trsw[4];
-- 
2.23.0

