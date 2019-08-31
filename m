Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49E47A45B9
	for <lists+linux-wireless@lfdr.de>; Sat, 31 Aug 2019 20:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728522AbfHaSHF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 31 Aug 2019 14:07:05 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:38623 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728510AbfHaSHF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 31 Aug 2019 14:07:05 -0400
Received: by mail-oi1-f194.google.com with SMTP id q8so7778628oij.5
        for <linux-wireless@vger.kernel.org>; Sat, 31 Aug 2019 11:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nt9oOKbIp7YAsRP6lUleVLU+9lC/yVCAr5JMcMkYOKI=;
        b=aM5vQDSaD7uqXlp3vBPQKiajUg9kDwtp4rFoSPt8MJ52XqbJSvOAMCZqM0W/4Q/OX2
         hk47WZ5EV7T/rw5hADgOb6QjhfALtqi32GOLYqon4ThYlmZzBu/7sg37WNzDEO3+ZWp0
         Jmq+7/i8fz1dBmSgQyDB33w5HykMcO7DBesWO1F/heUJ0N09CG2Hqv9cic1Hz0mw3wl7
         5l9C34rb4EsvWICKuoStfS10P4zoYCWWEEnB9TV9F61hKiCMgoV/ogLoEa6gc7HZPoaJ
         UTF72nVn4kuu1hOPfpd04e4z1OKtox+lA3RoZNhXbVPhMV+aS8OxnA5+wp/PyAHJWCo4
         IHpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=nt9oOKbIp7YAsRP6lUleVLU+9lC/yVCAr5JMcMkYOKI=;
        b=JdNy+W2swzTK9ovK6182xMKcc1QPc3CEXaXoJbb47Dk0A+nXNiT1P2v+bl7JoC1d27
         ecJCxa+I21mMPYt6GfX6BtTRVZKYD552oC/YEwLtr/mHqZd6Ww1IXkboTTyQw6LmbPyN
         UunMDGw7hvEMTjgv+sHtMHD/3XcMocgvPjL63+IsAxiIQLZTGOCquDhtbaFqk7he0NKS
         dHI0g8ucWB4nqM/APC1RTGGPzfLynlWpZOSh8k7J9ZV1WmpiRnqUBlE5MmfMHL05u10W
         S+0mhFPHHa+8hrBUf3jts0k4xSrA1z654oxJreW2sn+NY2rUU3G7eaB4ZbECuDR1PZYV
         DADg==
X-Gm-Message-State: APjAAAU+VxTm1aB1fEM/T0KYZ/hfqj7+DaLdQVlpGSnmoZ7FI336VIwc
        NUJdvalguEqu4FfPKoJ4mY8=
X-Google-Smtp-Source: APXvYqwCVgSSsTJiF4JUyVhtt9ScGdbWOF5UqFROkdmyf1NSL1MtYHYDx9clBCc2shcdPmA/3jn6VA==
X-Received: by 2002:a05:6808:198:: with SMTP id w24mr14154392oic.53.1567274822121;
        Sat, 31 Aug 2019 11:07:02 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id c11sm3222346otr.54.2019.08.31.11.07.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 31 Aug 2019 11:07:01 -0700 (PDT)
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, pkshih@realtek.com,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH 3/5] rtlwifi: rtl8192ee: Convert macros that set descriptor
Date:   Sat, 31 Aug 2019 13:06:42 -0500
Message-Id: <20190831180644.7937-4-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190831180644.7937-1-Larry.Finger@lwfinger.net>
References: <20190831180644.7937-1-Larry.Finger@lwfinger.net>
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
 .../net/wireless/realtek/rtlwifi/rtl8192ee/trx.c   | 252 ++++-----
 .../net/wireless/realtek/rtlwifi/rtl8192ee/trx.h   | 605 +++++++++++++++------
 2 files changed, 550 insertions(+), 307 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/trx.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/trx.c
index d297cfc0fd2b..dedd1cc8c369 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/trx.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/trx.c
@@ -277,7 +277,7 @@ static void _rtl92ee_insert_emcontent(struct rtl_tcb_desc *ptcb_desc,
 
 	memset(virtualaddress, 0, 8);
 
-	SET_EARLYMODE_PKTNUM(virtualaddress, ptcb_desc->empkt_num);
+	set_earlymode_pktnum(virtualaddress, ptcb_desc->empkt_num);
 	if (ptcb_desc->empkt_num == 1) {
 		dwtmp = ptcb_desc->empkt_len[0];
 	} else {
@@ -285,7 +285,7 @@ static void _rtl92ee_insert_emcontent(struct rtl_tcb_desc *ptcb_desc,
 		dwtmp += ((dwtmp % 4) ? (4 - dwtmp % 4) : 0) + 4;
 		dwtmp += ptcb_desc->empkt_len[1];
 	}
-	SET_EARLYMODE_LEN0(virtualaddress, dwtmp);
+	set_earlymode_len0(virtualaddress, dwtmp);
 
 	if (ptcb_desc->empkt_num <= 3) {
 		dwtmp = ptcb_desc->empkt_len[2];
@@ -294,7 +294,7 @@ static void _rtl92ee_insert_emcontent(struct rtl_tcb_desc *ptcb_desc,
 		dwtmp += ((dwtmp % 4) ? (4 - dwtmp % 4) : 0) + 4;
 		dwtmp += ptcb_desc->empkt_len[3];
 	}
-	SET_EARLYMODE_LEN1(virtualaddress, dwtmp);
+	set_earlymode_len1(virtualaddress, dwtmp);
 	if (ptcb_desc->empkt_num <= 5) {
 		dwtmp = ptcb_desc->empkt_len[4];
 	} else {
@@ -302,8 +302,8 @@ static void _rtl92ee_insert_emcontent(struct rtl_tcb_desc *ptcb_desc,
 		dwtmp += ((dwtmp % 4) ? (4 - dwtmp % 4) : 0) + 4;
 		dwtmp += ptcb_desc->empkt_len[5];
 	}
-	SET_EARLYMODE_LEN2_1(virtualaddress, dwtmp & 0xF);
-	SET_EARLYMODE_LEN2_2(virtualaddress, dwtmp >> 4);
+	set_earlymode_len2_1(virtualaddress, dwtmp & 0xF);
+	set_earlymode_len2_2(virtualaddress, dwtmp >> 4);
 	if (ptcb_desc->empkt_num <= 7) {
 		dwtmp = ptcb_desc->empkt_len[6];
 	} else {
@@ -311,7 +311,7 @@ static void _rtl92ee_insert_emcontent(struct rtl_tcb_desc *ptcb_desc,
 		dwtmp += ((dwtmp % 4) ? (4 - dwtmp % 4) : 0) + 4;
 		dwtmp += ptcb_desc->empkt_len[7];
 	}
-	SET_EARLYMODE_LEN3(virtualaddress, dwtmp);
+	set_earlymode_len3(virtualaddress, dwtmp);
 	if (ptcb_desc->empkt_num <= 9) {
 		dwtmp = ptcb_desc->empkt_len[8];
 	} else {
@@ -319,7 +319,7 @@ static void _rtl92ee_insert_emcontent(struct rtl_tcb_desc *ptcb_desc,
 		dwtmp += ((dwtmp % 4) ? (4 - dwtmp % 4) : 0) + 4;
 		dwtmp += ptcb_desc->empkt_len[9];
 	}
-	SET_EARLYMODE_LEN4(virtualaddress, dwtmp);
+	set_earlymode_len4(virtualaddress, dwtmp);
 }
 
 bool rtl92ee_rx_query_desc(struct ieee80211_hw *hw,
@@ -330,32 +330,32 @@ bool rtl92ee_rx_query_desc(struct ieee80211_hw *hw,
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	struct rx_fwinfo *p_drvinfo;
 	struct ieee80211_hdr *hdr;
-	u32 phystatus = GET_RX_DESC_PHYST(pdesc);
+	u32 phystatus = get_rx_desc_physt(pdesc);
 	u8 wake_match;
 
-	if (GET_RX_STATUS_DESC_RPT_SEL(pdesc) == 0)
+	if (get_rx_status_desc_rpt_sel(pdesc) == 0)
 		status->packet_report_type = NORMAL_RX;
 	else
 		status->packet_report_type = C2H_PACKET;
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
-	status->isampdu = (bool)(GET_RX_DESC_PAGGR(pdesc) == 1);
-	status->timestamp_low = GET_RX_DESC_TSFL(pdesc);
+	status->decrypted = !get_rx_desc_swdec(pdesc);
+	status->rate = (u8)get_rx_desc_rxmcs(pdesc);
+	status->isampdu = (bool)(get_rx_desc_paggr(pdesc) == 1);
+	status->timestamp_low = get_rx_desc_tsfl(pdesc);
 	status->is_cck = RTL92EE_RX_HAL_IS_CCK_RATE(status->rate);
 
-	status->macid = GET_RX_DESC_MACID(pdesc);
-	if (GET_RX_STATUS_DESC_PATTERN_MATCH(pdesc))
+	status->macid = get_rx_desc_macid(pdesc);
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
@@ -415,9 +415,9 @@ bool rtl92ee_rx_query_desc(struct ieee80211_hw *hw,
 	rx_status->signal = status->recvsignalpower + 10;
 	if (status->packet_report_type == TX_REPORT2) {
 		status->macid_valid_entry[0] =
-			GET_RX_RPT2_DESC_MACID_VALID_1(pdesc);
+			get_rx_rpt2_desc_macid_valid_1(pdesc);
 		status->macid_valid_entry[1] =
-			GET_RX_RPT2_DESC_MACID_VALID_2(pdesc);
+			get_rx_rpt2_desc_macid_valid_2(pdesc);
 	}
 	return true;
 }
@@ -434,17 +434,17 @@ void rtl92ee_rx_check_dma_ok(struct ieee80211_hw *hw, u8 *header_desc,
 	if (header_desc == NULL)
 		return;
 
-	total_len = (u16)GET_RX_BUFFER_DESC_TOTAL_LENGTH(header_desc);
+	total_len = (u16)get_rx_buffer_desc_total_length(header_desc);
 
-	first_seg = (u8)GET_RX_BUFFER_DESC_FS(header_desc);
+	first_seg = (u8)get_rx_buffer_desc_fs(header_desc);
 
-	last_seg = (u8)GET_RX_BUFFER_DESC_LS(header_desc);
+	last_seg = (u8)get_rx_buffer_desc_ls(header_desc);
 
 	while (total_len == 0 && first_seg == 0 && last_seg == 0) {
 		read_cnt++;
-		total_len = (u16)GET_RX_BUFFER_DESC_TOTAL_LENGTH(header_desc);
-		first_seg = (u8)GET_RX_BUFFER_DESC_FS(header_desc);
-		last_seg = (u8)GET_RX_BUFFER_DESC_LS(header_desc);
+		total_len = (u16)get_rx_buffer_desc_total_length(header_desc);
+		first_seg = (u8)get_rx_buffer_desc_fs(header_desc);
+		last_seg = (u8)get_rx_buffer_desc_ls(header_desc);
 
 		if (read_cnt > 20)
 			break;
@@ -589,15 +589,15 @@ void rtl92ee_pre_fill_tx_bd_desc(struct ieee80211_hw *hw,
 			(current_bd_desc * TX_DESC_SIZE);
 
 	/* Reset */
-	SET_TX_BUFF_DESC_LEN_0(tx_bd_desc, 0);
-	SET_TX_BUFF_DESC_PSB(tx_bd_desc, 0);
-	SET_TX_BUFF_DESC_OWN(tx_bd_desc, 0);
+	set_tx_buff_desc_len_0(tx_bd_desc, 0);
+	set_tx_buff_desc_psb(tx_bd_desc, 0);
+	set_tx_buff_desc_own(tx_bd_desc, 0);
 
 	for (i = 1; i < segmentnum; i++) {
-		SET_TXBUFFER_DESC_LEN_WITH_OFFSET(tx_bd_desc, i, 0);
-		SET_TXBUFFER_DESC_AMSDU_WITH_OFFSET(tx_bd_desc, i, 0);
-		SET_TXBUFFER_DESC_ADD_LOW_WITH_OFFSET(tx_bd_desc, i, 0);
-		SET_TXBUFFER_DESC_ADD_HIGH_WITH_OFFSET(tx_bd_desc, i, 0, dma64);
+		set_txbuffer_desc_len_with_offset(tx_bd_desc, i, 0);
+		set_txbuffer_desc_amsdu_with_offset(tx_bd_desc, i, 0);
+		set_txbuffer_desc_add_low_with_offset(tx_bd_desc, i, 0);
+		set_txbuffer_desc_add_high_with_offset(tx_bd_desc, i, 0, dma64);
 	}
 
 	/* Clear all status */
@@ -606,27 +606,27 @@ void rtl92ee_pre_fill_tx_bd_desc(struct ieee80211_hw *hw,
 	if (rtlpriv->rtlhal.earlymode_enable) {
 		if (queue_index < BEACON_QUEUE) {
 			/* This if needs braces */
-			SET_TX_BUFF_DESC_LEN_0(tx_bd_desc, desc_size + 8);
+			set_tx_buff_desc_len_0(tx_bd_desc, desc_size + 8);
 		} else {
-			SET_TX_BUFF_DESC_LEN_0(tx_bd_desc, desc_size);
+			set_tx_buff_desc_len_0(tx_bd_desc, desc_size);
 		}
 	} else {
-		SET_TX_BUFF_DESC_LEN_0(tx_bd_desc, desc_size);
+		set_tx_buff_desc_len_0(tx_bd_desc, desc_size);
 	}
-	SET_TX_BUFF_DESC_PSB(tx_bd_desc, psblen);
-	SET_TX_BUFF_DESC_ADDR_LOW_0(tx_bd_desc, desc_dma_addr);
-	SET_TX_BUFF_DESC_ADDR_HIGH_0(tx_bd_desc, ((u64)desc_dma_addr >> 32),
+	set_tx_buff_desc_psb(tx_bd_desc, psblen);
+	set_tx_buff_desc_addr_low_0(tx_bd_desc, desc_dma_addr);
+	set_tx_buff_desc_addr_high_0(tx_bd_desc, ((u64)desc_dma_addr >> 32),
 				     dma64);
 
-	SET_TXBUFFER_DESC_LEN_WITH_OFFSET(tx_bd_desc, 1, pkt_len);
+	set_txbuffer_desc_len_with_offset(tx_bd_desc, 1, pkt_len);
 	/* don't using extendsion mode. */
-	SET_TXBUFFER_DESC_AMSDU_WITH_OFFSET(tx_bd_desc, 1, 0);
-	SET_TXBUFFER_DESC_ADD_LOW_WITH_OFFSET(tx_bd_desc, 1, addr);
-	SET_TXBUFFER_DESC_ADD_HIGH_WITH_OFFSET(tx_bd_desc, 1,
+	set_txbuffer_desc_amsdu_with_offset(tx_bd_desc, 1, 0);
+	set_txbuffer_desc_add_low_with_offset(tx_bd_desc, 1, addr);
+	set_txbuffer_desc_add_high_with_offset(tx_bd_desc, 1,
 					       ((u64)addr >> 32), dma64);
 
-	SET_TX_DESC_PKT_SIZE(desc, (u16)(pkt_len));
-	SET_TX_DESC_TX_BUFFER_SIZE(desc, (u16)(pkt_len));
+	set_tx_desc_pkt_size(desc, (u16)(pkt_len));
+	set_tx_desc_tx_buffer_size(desc, (u16)(pkt_len));
 }
 
 void rtl92ee_tx_fill_desc(struct ieee80211_hw *hw,
@@ -689,8 +689,8 @@ void rtl92ee_tx_fill_desc(struct ieee80211_hw *hw,
 	}
 	if (firstseg) {
 		if (rtlhal->earlymode_enable) {
-			SET_TX_DESC_PKT_OFFSET(pdesc, 1);
-			SET_TX_DESC_OFFSET(pdesc,
+			set_tx_desc_pkt_offset(pdesc, 1);
+			set_tx_desc_offset(pdesc,
 					   USB_HWDESC_HEADER_LEN + EM_HDR_LEN);
 			if (ptcb_desc->empkt_num) {
 				RT_TRACE(rtlpriv, COMP_SEND, DBG_TRACE,
@@ -700,18 +700,18 @@ void rtl92ee_tx_fill_desc(struct ieee80211_hw *hw,
 							  (u8 *)(skb->data));
 			}
 		} else {
-			SET_TX_DESC_OFFSET(pdesc, USB_HWDESC_HEADER_LEN);
+			set_tx_desc_offset(pdesc, USB_HWDESC_HEADER_LEN);
 		}
 
 
-		SET_TX_DESC_TX_RATE(pdesc, ptcb_desc->hw_rate);
+		set_tx_desc_tx_rate(pdesc, ptcb_desc->hw_rate);
 
 		if (ieee80211_is_mgmt(fc)) {
 			ptcb_desc->use_driver_rate = true;
 		} else {
 			if (rtlpriv->ra.is_special_data) {
 				ptcb_desc->use_driver_rate = true;
-				SET_TX_DESC_TX_RATE(pdesc, DESC_RATE11M);
+				set_tx_desc_tx_rate(pdesc, DESC_RATE11M);
 			} else {
 				ptcb_desc->use_driver_rate = false;
 			}
@@ -723,46 +723,46 @@ void rtl92ee_tx_fill_desc(struct ieee80211_hw *hw,
 			short_gi = (ptcb_desc->use_shortpreamble) ? 1 : 0;
 
 		if (info->flags & IEEE80211_TX_CTL_AMPDU) {
-			SET_TX_DESC_AGG_ENABLE(pdesc, 1);
-			SET_TX_DESC_MAX_AGG_NUM(pdesc, 0x14);
+			set_tx_desc_agg_enable(pdesc, 1);
+			set_tx_desc_max_agg_num(pdesc, 0x14);
 		}
-		SET_TX_DESC_SEQ(pdesc, seq_number);
-		SET_TX_DESC_RTS_ENABLE(pdesc,
+		set_tx_desc_seq(pdesc, seq_number);
+		set_tx_desc_rts_enable(pdesc,
 				       ((ptcb_desc->rts_enable &&
 					 !ptcb_desc->cts_enable) ? 1 : 0));
-		SET_TX_DESC_HW_RTS_ENABLE(pdesc, 0);
-		SET_TX_DESC_CTS2SELF(pdesc,
+		set_tx_desc_hw_rts_enable(pdesc, 0);
+		set_tx_desc_cts2self(pdesc,
 				     ((ptcb_desc->cts_enable) ? 1 : 0));
 
-		SET_TX_DESC_RTS_RATE(pdesc, ptcb_desc->rts_rate);
-		SET_TX_DESC_RTS_SC(pdesc, ptcb_desc->rts_sc);
-		SET_TX_DESC_RTS_SHORT(pdesc,
+		set_tx_desc_rts_rate(pdesc, ptcb_desc->rts_rate);
+		set_tx_desc_rts_sc(pdesc, ptcb_desc->rts_sc);
+		set_tx_desc_rts_short(pdesc,
 				((ptcb_desc->rts_rate <= DESC_RATE54M) ?
 				 (ptcb_desc->rts_use_shortpreamble ? 1 : 0) :
 				 (ptcb_desc->rts_use_shortgi ? 1 : 0)));
 
 		if (ptcb_desc->tx_enable_sw_calc_duration)
-			SET_TX_DESC_NAV_USE_HDR(pdesc, 1);
+			set_tx_desc_nav_use_hdr(pdesc, 1);
 
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
+		set_tx_desc_linip(pdesc, 0);
 		if (sta) {
 			u8 ampdu_density = sta->ht_cap.ampdu_density;
 
-			SET_TX_DESC_AMPDU_DENSITY(pdesc, ampdu_density);
+			set_tx_desc_ampdu_density(pdesc, ampdu_density);
 		}
 		if (info->control.hw_key) {
 			struct ieee80211_key_conf *key = info->control.hw_key;
@@ -771,59 +771,59 @@ void rtl92ee_tx_fill_desc(struct ieee80211_hw *hw,
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
-		SET_TX_DESC_DISABLE_FB(pdesc,
+		set_tx_desc_queue_sel(pdesc, fw_qsel);
+		set_tx_desc_data_rate_fb_limit(pdesc, 0x1F);
+		set_tx_desc_rts_rate_fb_limit(pdesc, 0xF);
+		set_tx_desc_disable_fb(pdesc,
 				       ptcb_desc->disable_ratefallback ? 1 : 0);
-		SET_TX_DESC_USE_RATE(pdesc, ptcb_desc->use_driver_rate ? 1 : 0);
+		set_tx_desc_use_rate(pdesc, ptcb_desc->use_driver_rate ? 1 : 0);
 
-		/*SET_TX_DESC_PWR_STATUS(pdesc, pwr_status);*/
+		/*set_tx_desc_pwr_status(pdesc, pwr_status);*/
 		/* Set TxRate and RTSRate in TxDesc  */
 		/* This prevent Tx initial rate of new-coming packets */
 		/* from being overwritten by retried  packet rate.*/
 		if (!ptcb_desc->use_driver_rate) {
-			/*SET_TX_DESC_RTS_RATE(pdesc, 0x08); */
-			/* SET_TX_DESC_TX_RATE(pdesc, 0x0b); */
+			/*set_tx_desc_rts_rate(pdesc, 0x08); */
+			/* set_tx_desc_tx_rate(pdesc, 0x0b); */
 		}
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
-	SET_TX_DESC_TX_BUFFER_ADDRESS(pdesc, mapping);
+	set_tx_desc_first_seg(pdesc, (firstseg ? 1 : 0));
+	set_tx_desc_last_seg(pdesc, (lastseg ? 1 : 0));
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
 
-	SET_TX_DESC_MORE_FRAG(pdesc, (lastseg ? 0 : 1));
+	set_tx_desc_more_frag(pdesc, (lastseg ? 0 : 1));
 	if (is_multicast_ether_addr(ieee80211_get_DA(hdr)) ||
 	    is_broadcast_ether_addr(ieee80211_get_DA(hdr))) {
-		SET_TX_DESC_BMC(pdesc, 1);
+		set_tx_desc_bmc(pdesc, 1);
 	}
 	RT_TRACE(rtlpriv, COMP_SEND, DBG_TRACE, "\n");
 }
@@ -848,36 +848,36 @@ void rtl92ee_tx_fill_cmddesc(struct ieee80211_hw *hw,
 	CLEAR_PCI_TX_DESC_CONTENT(pdesc, txdesc_len);
 
 	if (firstseg)
-		SET_TX_DESC_OFFSET(pdesc, txdesc_len);
+		set_tx_desc_offset(pdesc, txdesc_len);
 
-	SET_TX_DESC_TX_RATE(pdesc, DESC_RATE1M);
+	set_tx_desc_tx_rate(pdesc, DESC_RATE1M);
 
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
 
-	SET_TX_DESC_TX_BUFFER_SIZE(pdesc, (u16)(skb->len));
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
 
-	SET_TX_DESC_OFFSET(pdesc, 40);
+	set_tx_desc_offset(pdesc, 40);
 
-	SET_TX_DESC_USE_RATE(pdesc, 1);
+	set_tx_desc_use_rate(pdesc, 1);
 
 	RT_PRINT_DATA(rtlpriv, COMP_CMD, DBG_LOUD,
 		      "H2C Tx Cmd Content\n", pdesc, txdesc_len);
@@ -893,7 +893,7 @@ void rtl92ee_set_desc(struct ieee80211_hw *hw, u8 *pdesc, bool istx,
 	if (istx) {
 		switch (desc_name) {
 		case HW_DESC_TX_NEXTDESC_ADDR:
-			SET_TX_DESC_NEXT_DESC_ADDRESS(pdesc, *(u32 *)val);
+			set_tx_desc_next_desc_address(pdesc, *(u32 *)val);
 			break;
 		case HW_DESC_OWN:{
 			struct rtl_pci *rtlpci = rtl_pcidev(rtl_pcipriv(hw));
@@ -903,7 +903,7 @@ void rtl92ee_set_desc(struct ieee80211_hw *hw, u8 *pdesc, bool istx,
 			if (q_idx == BEACON_QUEUE) {
 				ring->cur_tx_wp = 0;
 				ring->cur_tx_rp = 0;
-				SET_TX_BUFF_DESC_OWN(pdesc, 1);
+				set_tx_buff_desc_own(pdesc, 1);
 				return;
 			}
 
@@ -919,23 +919,23 @@ void rtl92ee_set_desc(struct ieee80211_hw *hw, u8 *pdesc, bool istx,
 	} else {
 		switch (desc_name) {
 		case HW_DESC_RX_PREPARE:
-			SET_RX_BUFFER_DESC_LS(pdesc, 0);
-			SET_RX_BUFFER_DESC_FS(pdesc, 0);
-			SET_RX_BUFFER_DESC_TOTAL_LENGTH(pdesc, 0);
+			set_rx_buffer_desc_ls(pdesc, 0);
+			set_rx_buffer_desc_fs(pdesc, 0);
+			set_rx_buffer_desc_total_length(pdesc, 0);
 
-			SET_RX_BUFFER_DESC_DATA_LENGTH(pdesc,
+			set_rx_buffer_desc_data_length(pdesc,
 						       MAX_RECEIVE_BUFFER_SIZE +
 						       RX_DESC_SIZE);
 
-			SET_RX_BUFFER_PHYSICAL_LOW(pdesc, (*(dma_addr_t *)val) &
+			set_rx_buffer_physical_low(pdesc, (*(dma_addr_t *)val) &
 						   DMA_BIT_MASK(32));
-			SET_RX_BUFFER_PHYSICAL_HIGH(pdesc,
+			set_rx_buffer_physical_high(pdesc,
 						    ((u64)(*(dma_addr_t *)val)
 						    >> 32),
 						    dma64);
 			break;
 		case HW_DESC_RXERO:
-			SET_RX_DESC_EOR(pdesc, 1);
+			set_rx_desc_eor(pdesc, 1);
 			break;
 		default:
 			WARN_ONCE(true,
@@ -956,11 +956,11 @@ u64 rtl92ee_get_desc(struct ieee80211_hw *hw,
 	if (istx) {
 		switch (desc_name) {
 		case HW_DESC_OWN:
-			ret = GET_TX_DESC_OWN(pdesc);
+			ret = get_tx_desc_own(pdesc);
 			break;
 		case HW_DESC_TXBUFF_ADDR:
-			ret = GET_TXBUFFER_DESC_ADDR_LOW(pdesc, 1);
-			ret |= (u64)GET_TXBUFFER_DESC_ADDR_HIGH(pdesc, 1,
+			ret = get_txbuffer_desc_addr_low(pdesc, 1);
+			ret |= (u64)get_txbuffer_desc_addr_high(pdesc, 1,
 								dma64) << 32;
 			break;
 		default:
@@ -972,13 +972,13 @@ u64 rtl92ee_get_desc(struct ieee80211_hw *hw,
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
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/trx.h b/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/trx.h
index 3b00072ba5d2..ffe8097e0ed2 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/trx.h
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/trx.h
@@ -14,219 +14,462 @@
 #define RX_DESC_SIZE					24
 #define MAX_RECEIVE_BUFFER_SIZE				8192
 
-#define SET_TX_DESC_PKT_SIZE(__pdesc, __val)		\
-	le32p_replace_bits((__le32 *)__pdesc, __val, GENMASK(15, 0))
-#define SET_TX_DESC_OFFSET(__pdesc, __val)		\
-	le32p_replace_bits((__le32 *)__pdesc, __val, GENMASK(23, 16))
-#define SET_TX_DESC_BMC(__pdesc, __val)			\
-	le32p_replace_bits((__le32 *)__pdesc, __val, BIT(24))
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
-	le32_get_bits(*((__le32 *)__pdesc), BIT(31))
-
-#define SET_TX_DESC_MACID(__pdesc, __val)		\
-	le32p_replace_bits((__le32 *)(__pdesc + 4), __val, GENMASK(6, 0))
-#define SET_TX_DESC_QUEUE_SEL(__pdesc, __val)		\
-	le32p_replace_bits((__le32 *)(__pdesc + 4), __val, GENMASK(12, 8))
-#define SET_TX_DESC_RATE_ID(__pdesc, __val)		\
-	le32p_replace_bits((__le32 *)(__pdesc + 4), __val, GENMASK(20, 16))
-#define SET_TX_DESC_SEC_TYPE(__pdesc, __val)		\
-	le32p_replace_bits((__le32 *)(__pdesc + 4), __val, GENMASK(23, 22))
-#define SET_TX_DESC_PKT_OFFSET(__pdesc, __val)		\
-	le32p_replace_bits((__le32 *)(__pdesc + 4), __val, GENMASK(28, 24))
-
-#define SET_TX_DESC_AGG_ENABLE(__pdesc, __val)		\
-	le32p_replace_bits((__le32 *)(__pdesc + 8), __val, BIT(12))
-#define SET_TX_DESC_RDG_ENABLE(__pdesc, __val)		\
-	le32p_replace_bits((__le32 *)(__pdesc + 8), __val, BIT(13))
-#define SET_TX_DESC_MORE_FRAG(__pdesc, __val)		\
-	le32p_replace_bits((__le32 *)(__pdesc + 8), __val, BIT(17))
-#define SET_TX_DESC_AMPDU_DENSITY(__pdesc, __val)	\
-	le32p_replace_bits((__le32 *)(__pdesc + 8), __val, GENMASK(22, 20))
-
-#define SET_TX_DESC_USE_RATE(__pdesc, __val)		\
-	le32p_replace_bits((__le32 *)(__pdesc + 12), __val, BIT(8))
-#define SET_TX_DESC_DISABLE_FB(__pdesc, __val)		\
-	le32p_replace_bits((__le32 *)(__pdesc + 12), __val, BIT(10))
-#define SET_TX_DESC_CTS2SELF(__pdesc, __val)		\
-	le32p_replace_bits((__le32 *)(__pdesc + 12), __val, BIT(11))
-#define SET_TX_DESC_RTS_ENABLE(__pdesc, __val)		\
-	le32p_replace_bits((__le32 *)(__pdesc + 12), __val, BIT(12))
-#define SET_TX_DESC_HW_RTS_ENABLE(__pdesc, __val)	\
-	le32p_replace_bits((__le32 *)(__pdesc + 12), __val, BIT(13))
-#define SET_TX_DESC_NAV_USE_HDR(__pdesc, __val)		\
-	le32p_replace_bits((__le32 *)(__pdesc + 12), __val, BIT(15))
-#define SET_TX_DESC_MAX_AGG_NUM(__pdesc, __val)		\
-	le32p_replace_bits((__le32 *)(__pdesc + 12), __val, GENMASK(21, 17))
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
 
 /* Dword 4 */
-#define SET_TX_DESC_TX_RATE(__pdesc, __val)		\
-	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, GENMASK(6, 0))
-#define SET_TX_DESC_DATA_RATE_FB_LIMIT(__pdesc, __val)	\
-	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, GENMASK(12, 8))
-#define SET_TX_DESC_RTS_RATE_FB_LIMIT(__pdesc, __val)	\
-	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, GENMASK(16, 13))
-#define SET_TX_DESC_RTS_RATE(__pdesc, __val)		\
-	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, GENMASK(28, 24))
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
 
 /* Dword 5 */
-#define SET_TX_DESC_TX_SUB_CARRIER(__pdesc, __val)	\
-	le32p_replace_bits((__le32 *)(__pdesc + 20), __val, GENMASK(3, 0))
-#define SET_TX_DESC_DATA_BW(__pdesc, __val)		\
-	le32p_replace_bits((__le32 *)(__pdesc + 20), __val, GENMASK(6, 5))
-#define SET_TX_DESC_RTS_SHORT(__pdesc, __val)		\
-	le32p_replace_bits((__le32 *)(__pdesc + 20), __val, BIT(12))
-#define SET_TX_DESC_RTS_SC(__pdesc, __val)		\
-	le32p_replace_bits((__le32 *)(__pdesc + 20), __val, GENMASK(16, 13))
+static inline void set_tx_desc_tx_sub_carrier(u8 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__le32 *)(__pdesc + 20), __val, GENMASK(3, 0));
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
 
 /* Dword 7 */
-#define SET_TX_DESC_TX_BUFFER_SIZE(__pdesc, __val)	\
-	le32p_replace_bits((__le32 *)(__pdesc + 28), __val, GENMASK(15, 0))
+static inline void set_tx_desc_tx_buffer_size(u8 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__le32 *)(__pdesc + 28), __val, GENMASK(15, 0));
+}
 
 /* Dword 9 */
-#define SET_TX_DESC_SEQ(__pdesc, __val)			\
-	le32p_replace_bits((__le32 *)(__pdesc + 36), __val, GENMASK(23, 12))
+static inline void set_tx_desc_seq(u8 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__le32 *)(__pdesc + 36), __val, GENMASK(23, 12));
+}
 
 /* Dword 10 */
-#define SET_TX_DESC_TX_BUFFER_ADDRESS(__pdesc, __val)	\
-	*(__le32 *)(__pdesc + 40) = cpu_to_le32(__val)
+static inline void set_tx_desc_tx_buffer_address(u8 *__pdesc, u32 __val)
+{
+	*(__le32 *)(__pdesc + 40) = cpu_to_le32(__val);
+}
 
 /* Dword 11*/
-#define SET_TX_DESC_NEXT_DESC_ADDRESS(__pdesc, __val)	\
-	*(__le32 *)(__pdesc + 48) = cpu_to_le32(__val)
-
-#define SET_EARLYMODE_PKTNUM(__paddr, __val)		\
-	le32p_replace_bits((__le32 *)__paddr, __val, GENMASK(3, 0))
-#define SET_EARLYMODE_LEN0(__paddr, __val)		\
-	le32p_replace_bits((__le32 *)__paddr, __val, GENMASK(18, 4))
-#define SET_EARLYMODE_LEN1(__paddr, __val)		\
-	le32p_replace_bits((__le32 *)__paddr, __val, GENMASK(17, 16))
-#define SET_EARLYMODE_LEN2_1(__paddr, __val)		\
-	le32p_replace_bits((__le32 *)__paddr, __val, GENMASK(5, 2))
-#define SET_EARLYMODE_LEN2_2(__paddr, __val)		\
-	le32p_replace_bits((__le32 *)(__paddr + 4), __val, GENMASK(7, 0))
-#define SET_EARLYMODE_LEN3(__paddr, __val)		\
-	le32p_replace_bits((__le32 *)(__paddr + 4), __val, GENMASK(31, 17))
-#define SET_EARLYMODE_LEN4(__paddr, __val)		\
-	le32p_replace_bits((__le32 *)(__paddr + 4), __val, GENMASK(31, 20))
+static inline void set_tx_desc_next_desc_address(u8 *__pdesc, u32 __val)
+{
+	*(__le32 *)(__pdesc + 48) = cpu_to_le32(__val);
+}
+
+static inline void set_earlymode_pktnum(u8 *__paddr, u32 __val)
+{
+	le32p_replace_bits((__le32 *)__paddr, __val, GENMASK(3, 0));
+}
+
+static inline void set_earlymode_len0(u8 *__paddr, u32 __val)
+{
+	le32p_replace_bits((__le32 *)__paddr, __val, GENMASK(18, 4));
+}
+
+static inline void set_earlymode_len1(u8 *__paddr, u32 __val)
+{
+	le32p_replace_bits((__le32 *)__paddr, __val, GENMASK(17, 16));
+}
+
+static inline void set_earlymode_len2_1(u8 *__paddr, u32 __val)
+{
+	le32p_replace_bits((__le32 *)__paddr, __val, GENMASK(5, 2));
+}
+
+static inline void set_earlymode_len2_2(u8 *__paddr, u32 __val)
+{
+	le32p_replace_bits((__le32 *)(__paddr + 4), __val, GENMASK(7, 0));
+}
+
+static inline void set_earlymode_len3(u8 *__paddr, u32 __val)
+{
+	le32p_replace_bits((__le32 *)(__paddr + 4), __val, GENMASK(31, 17));
+}
+
+static inline void set_earlymode_len4(u8 *__paddr, u32 __val)
+{
+	le32p_replace_bits((__le32 *)(__paddr + 4), __val, GENMASK(31, 20));
+}
 
 /* TX/RX buffer descriptor */
 
 /* for Txfilldescroptor92ee, fill the desc content. */
-#define SET_TXBUFFER_DESC_LEN_WITH_OFFSET(__pdesc, __offset, __val)            \
-	le32p_replace_bits((__le32 *)(__pdesc + 16 * __offset), __val,	\
-			   GENMASK(15, 0))
-#define SET_TXBUFFER_DESC_AMSDU_WITH_OFFSET(__pdesc, __offset, __val)          \
-	le32p_replace_bits((__le32 *)(__pdesc + 16 * __offset), __val, BIT(31))
-#define SET_TXBUFFER_DESC_ADD_LOW_WITH_OFFSET(__pdesc, __offset, __val)        \
-	*(__le32 *)(__pdesc + 16 * __offset + 4) = cpu_to_le32(__val)
-#define SET_TXBUFFER_DESC_ADD_HIGH_WITH_OFFSET(pbd, off, val, dma64)	       \
-	 *(__le32 *)(pbd + 16 * off + 8) = dma64 ? cpu_to_le32(val) : 0
-#define GET_TXBUFFER_DESC_ADDR_LOW(__pdesc, __offset)                          \
-	le32_to_cpu(*((__le32 *)(__pdesc + 16 * __offset + 4)))
-#define GET_TXBUFFER_DESC_ADDR_HIGH(pbd, off, dma64)			       \
-	(dma64 ? le32_to_cpu(*((__le32 *)(pbd + 16 * off + 8))) : 0)
+static inline void set_txbuffer_desc_len_with_offset(u8 *__pdesc,
+						     u8 __offset, u32 __val)
+{
+	le32p_replace_bits((__le32 *)(__pdesc + 16 * __offset), __val,
+			   GENMASK(15, 0));
+}
+
+static inline void set_txbuffer_desc_amsdu_with_offset(u8 *__pdesc,
+						       u8 __offset, u32 __val)
+{
+	le32p_replace_bits((__le32 *)(__pdesc + 16 * __offset), __val, BIT(31));
+}
+
+static inline void set_txbuffer_desc_add_low_with_offset(u8 *__pdesc,
+							 u8 __offset,
+							 u32 __val)
+{
+	*(__le32 *)(__pdesc + 16 * __offset + 4) = cpu_to_le32(__val);
+}
+
+static inline void set_txbuffer_desc_add_high_with_offset(u8 *pbd, u8 off,
+							  u32 val, bool dma64)
+{
+	if (dma64)
+		*(__le32 *)(pbd + 16 * off + 8) = cpu_to_le32(val);
+	else
+		*(__le32 *)(pbd + 16 * off + 8) = 0;
+}
+
+static inline u32 get_txbuffer_desc_addr_low(u8 *__pdesc, u8 __offset)
+{
+	return le32_to_cpu(*((__le32 *)(__pdesc + 16 * __offset + 4)));
+}
+
+static inline u32 get_txbuffer_desc_addr_high(u8 *pbd, u32 off, bool dma64)
+{
+	if (dma64)
+		return le32_to_cpu(*((__le32 *)(pbd + 16 * off + 8)));
+	return 0;
+}
 
 /* Dword 0 */
-#define SET_TX_BUFF_DESC_LEN_0(__pdesc, __val)                                 \
-	le32p_replace_bits((__le32 *)__pdesc, __val, GENMASK(13, 0))
-#define SET_TX_BUFF_DESC_PSB(__pdesc, __val)                                   \
-	le32p_replace_bits((__le32 *)__pdesc, __val, GENMASK(30, 16))
-#define SET_TX_BUFF_DESC_OWN(__pdesc, __val)                                   \
-	le32p_replace_bits((__le32 *)__pdesc, __val, BIT(31))
+static inline void set_tx_buff_desc_len_0(u8 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__le32 *)__pdesc, __val, GENMASK(13, 0));
+}
+
+static inline void set_tx_buff_desc_psb(u8 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__le32 *)__pdesc, __val, GENMASK(30, 16));
+}
+
+static inline void set_tx_buff_desc_own(u8 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__le32 *)__pdesc, __val, BIT(31));
+}
 
 /* Dword 1 */
-#define SET_TX_BUFF_DESC_ADDR_LOW_0(__pdesc, __val)                            \
-	*(__le32 *)(__pdesc + 4) = cpu_to_le32(__val)
+static inline void set_tx_buff_desc_addr_low_0(u8 *__pdesc, u32 __val)
+{
+	*(__le32 *)(__pdesc + 4) = cpu_to_le32(__val);
+}
+
 /* Dword 2 */
-#define SET_TX_BUFF_DESC_ADDR_HIGH_0(bdesc, val, dma64)			       \
-	SET_TXBUFFER_DESC_ADD_HIGH_WITH_OFFSET(bdesc, 0, val, dma64)
+static inline void set_tx_buff_desc_addr_high_0(u8 *pdesc, u32 val, bool dma64)
+{
+	if (dma64)
+		*(__le32 *)(pdesc + 8) = cpu_to_le32(val);
+	else
+		*(__le32 *)(pdesc + 8) = 0;
+}
 
 /* RX buffer  */
 
 /* DWORD 0 */
-#define SET_RX_BUFFER_DESC_DATA_LENGTH(__status, __val)	\
-	le32p_replace_bits((__le32 *)__status, __val, GENMASK(13, 0))
-#define SET_RX_BUFFER_DESC_LS(__status, __val)		\
-	le32p_replace_bits((__le32 *)__status, __val, BIT(15))
-#define SET_RX_BUFFER_DESC_FS(__status, __val)		\
-	le32p_replace_bits((__le32 *)__status, __val, BIT(16))
-#define SET_RX_BUFFER_DESC_TOTAL_LENGTH(__status, __val)	\
-	le32p_replace_bits((__le32 *)__status, __val, GENMASK(30, 16))
-
-#define GET_RX_BUFFER_DESC_LS(__status)			\
-	le32_get_bits(*((__le32 *)__status), BIT(15))
-#define GET_RX_BUFFER_DESC_FS(__status)			\
-	le32_get_bits(*((__le32 *)__status), BIT(16))
-#define GET_RX_BUFFER_DESC_TOTAL_LENGTH(__status)	\
-	le32_get_bits(*((__le32 *)__status), GENMASK(30, 16))
+static inline void set_rx_buffer_desc_data_length(u8 *__status, u32 __val)
+{
+	le32p_replace_bits((__le32 *)__status, __val, GENMASK(13, 0));
+}
+
+static inline void set_rx_buffer_desc_ls(u8 *__status, u32 __val)
+{
+	le32p_replace_bits((__le32 *)__status, __val, BIT(15));
+}
+
+static inline void set_rx_buffer_desc_fs(u8 *__status, u32 __val)
+{
+	le32p_replace_bits((__le32 *)__status, __val, BIT(16));
+}
+
+static inline void set_rx_buffer_desc_total_length(u8 *__status, u32 __val)
+{
+	le32p_replace_bits((__le32 *)__status, __val, GENMASK(30, 16));
+}
+
+static inline int get_rx_buffer_desc_ls(u8 *__status)
+{
+	return le32_get_bits(*((__le32 *)__status), BIT(15));
+}
+
+static inline int get_rx_buffer_desc_fs(u8 *__status)
+{
+	return le32_get_bits(*((__le32 *)__status), BIT(16));
+}
+
+static inline int get_rx_buffer_desc_total_length(u8 *__status)
+{
+	return le32_get_bits(*((__le32 *)__status), GENMASK(30, 16));
+}
 
 /* DWORD 1 */
-#define SET_RX_BUFFER_PHYSICAL_LOW(__status, __val)	\
-	*(__le32 *)(__status + 4) = cpu_to_le32(__val)
+static inline void set_rx_buffer_physical_low(u8 *__status, u32 __val)
+{
+	*(__le32 *)(__status + 4) = cpu_to_le32(__val);
+}
 
 /* DWORD 2 */
-#define SET_RX_BUFFER_PHYSICAL_HIGH(__rx_status_desc, __val, dma64)            \
-	*(__le32 *)(__rx_status_desc + 8) = (dma64 ? cpu_to_le32(__val) : 0)
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
-#define SET_RX_DESC_EOR(__pdesc, __val)			\
-	le32p_replace_bits((__le32 *)__pdesc, __val, BIT(30))
-
-#define GET_RX_DESC_MACID(__pdesc)			\
-	le32_get_bits(*(__le32 *)(__pdesc + 4), GENMASK(6, 0))
-#define GET_RX_DESC_PAGGR(__pdesc)			\
-	le32_get_bits(*(__le32 *)(__pdesc + 4), BIT(15))
-#define GET_RX_STATUS_DESC_RPT_SEL(__pdesc)		\
-	le32_get_bits(*(__le32 *)(__pdesc + 8), BIT(28))
-
-#define GET_RX_DESC_RXMCS(__pdesc)			\
-	le32_get_bits(*(__le32 *)(__pdesc + 12), GENMASK(6, 0))
-#define GET_RX_STATUS_DESC_PATTERN_MATCH(__pdesc)	\
-	le32_get_bits(*(__le32 *)(__pdesc + 12), BIT(29))
-#define GET_RX_STATUS_DESC_UNICAST_MATCH(__pdesc)	\
-	le32_get_bits(*(__le32 *)(__pdesc + 12), BIT(30))
-#define GET_RX_STATUS_DESC_MAGIC_MATCH(__pdesc)		\
-	le32_get_bits(*(__le32 *)(__pdesc + 12), BIT(31))
-
-#define GET_RX_DESC_TSFL(__pdesc)			\
-	le32_to_cpu(*((__le32 *)(__pdesc + 20)))
-
-#define GET_RX_DESC_BUFF_ADDR(__pdesc)			\
-	le32_to_cpu(*((__le32 *)(__pdesc + 24)))
+static inline void set_rx_buffer_physical_high(u8 *__rx_status_desc, u32 __val,
+					       bool dma64)
+{
+	if (dma64)
+		*(__le32 *)(__rx_status_desc + 8) = cpu_to_le32(__val);
+	else
+		*(__le32 *)(__rx_status_desc + 8) = 0;
+}
+
+static inline int get_rx_desc_pkt_len(u8 *__pdesc)
+{
+	return le32_get_bits(*(__le32 *)__pdesc, GENMASK(13, 0));
+}
+
+static inline int get_rx_desc_crc32(u8 *__pdesc)
+{
+	return le32_get_bits(*(__le32 *)__pdesc, BIT(14));
+}
+
+static inline int get_rx_desc_icv(u8 *__pdesc)
+{
+	return le32_get_bits(*(__le32 *)__pdesc, BIT(15));
+}
+
+static inline int get_rx_desc_drv_info_size(u8 *__pdesc)
+{
+	return le32_get_bits(*(__le32 *)__pdesc, GENMASK(19, 16));
+}
+
+static inline int get_rx_desc_shift(u8 *__pdesc)
+{
+	return le32_get_bits(*(__le32 *)__pdesc, GENMASK(25, 24));
+}
+
+static inline int get_rx_desc_physt(u8 *__pdesc)
+{
+	return le32_get_bits(*(__le32 *)__pdesc, BIT(26));
+}
+
+static inline int get_rx_desc_swdec(u8 *__pdesc)
+{
+	return le32_get_bits(*(__le32 *)__pdesc, BIT(27));
+}
+
+static inline int get_rx_desc_own(u8 *__pdesc)
+{
+	return le32_get_bits(*(__le32 *)__pdesc, BIT(31));
+}
+
+static inline void set_rx_desc_eor(u8 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__le32 *)__pdesc, __val, BIT(30));
+}
+
+static inline int get_rx_desc_macid(u8 *__pdesc)
+{
+	return le32_get_bits(*(__le32 *)(__pdesc + 4), GENMASK(6, 0));
+}
+
+static inline int get_rx_desc_paggr(u8 *__pdesc)
+{
+	return le32_get_bits(*(__le32 *)(__pdesc + 4), BIT(15));
+}
+
+static inline int get_rx_status_desc_rpt_sel(u8 *__pdesc)
+{
+	return le32_get_bits(*(__le32 *)(__pdesc + 8), BIT(28));
+}
+
+static inline int get_rx_desc_rxmcs(u8 *__pdesc)
+{
+	return le32_get_bits(*(__le32 *)(__pdesc + 12), GENMASK(6, 0));
+}
+
+static inline int get_rx_status_desc_pattern_match(u8 *__pdesc)
+{
+	return le32_get_bits(*(__le32 *)(__pdesc + 12), BIT(29));
+}
+
+static inline int get_rx_status_desc_unicast_match(u8 *__pdesc)
+{
+	return le32_get_bits(*(__le32 *)(__pdesc + 12), BIT(30));
+}
+
+static inline int get_rx_status_desc_magic_match(u8 *__pdesc)
+{
+	return le32_get_bits(*(__le32 *)(__pdesc + 12), BIT(31));
+}
+
+static inline u32 get_rx_desc_tsfl(u8 *__pdesc)
+{
+	return le32_to_cpu(*((__le32 *)(__pdesc + 20)));
+}
+
+static inline u32 get_rx_desc_buff_addr(u8 *__pdesc)
+{
+	return le32_to_cpu(*((__le32 *)(__pdesc + 24)));
+}
 
 /* TX report 2 format in Rx desc*/
 
-#define GET_RX_RPT2_DESC_MACID_VALID_1(__status)	\
-	le32_to_cpu(*((__le32 *)(__status + 16)))
-#define GET_RX_RPT2_DESC_MACID_VALID_2(__status)	\
-	le32_to_cpu(*((__le32 *)(__status + 20)))
+static inline u32 get_rx_rpt2_desc_macid_valid_1(u8 *__status)
+{
+	return le32_to_cpu(*((__le32 *)(__status + 16)));
+}
+
+static inline u32 get_rx_rpt2_desc_macid_valid_2(u8 *__status)
+{
+	return le32_to_cpu(*((__le32 *)(__status + 20)));
+}
 
 #define CLEAR_PCI_TX_DESC_CONTENT(__pdesc, _size)		\
 do {								\
-- 
2.16.4

