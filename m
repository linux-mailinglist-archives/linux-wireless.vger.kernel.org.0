Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E4307B736
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jul 2019 02:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbfGaAdT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 30 Jul 2019 20:33:19 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:42291 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbfGaAdS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 30 Jul 2019 20:33:18 -0400
Received: by mail-ot1-f65.google.com with SMTP id l15so68302722otn.9
        for <linux-wireless@vger.kernel.org>; Tue, 30 Jul 2019 17:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=256tg/71f9aE16UfGqukzQP451L8F6beesTtfpsqk94=;
        b=Z1EL2qeo7x3OF0NHGZx3MecyCM7fFv6tiUR41cTxN3FxBnr/Q06jZXb5kuqWCJLUsL
         cEE6eOKLxNUJUnShM2q8K8Fqs6ll34hdCM/+4A8qacSDKweL8QPtGmUYrhJRdSA58q9U
         5LP52/U7YdLkPO50kNtHuijA5y3Gr2O+XEJQ/x9GOWUEUqjGrXqSOtqjA3SsyFZG1EJv
         POaXzy5yWh8//RWXUETU1DO5gY5nA6i62jiSxl9vtuGQdfliQMu+KpPgU+tciZ4LHkex
         f9G64Laz9iEfTW7MFXEpOJK3YWyaqjb+WQIM/op0h2mHRu1OT/YrdbsESssK7cxTkQLT
         Bh7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=256tg/71f9aE16UfGqukzQP451L8F6beesTtfpsqk94=;
        b=ES/cCM1ZQL/URCXyHwqb5nCc7u9QTOvFbOoe6v2Fh0XwyUDzYdZJ0BPXqilMMpYejU
         hPvRwl/KWaLkSk5+G29RBAxXWEwajpQLL4fYmWZQ9+NwPXuH2nE90YXGh/A6daM5hfkG
         Bqkf6AXwUXwCPeZGbCBehO2knZhKlnPdvPlBOHRS+s82xR7EDImQss6C1LQAkS9Uq8vq
         9xFrd7MapCYSIAf3fa1gDe1j2Do05OJcRDF55KBDQk/wfCyGiqieFNPYblltroit/frn
         sSTwAqokHGtFA6x64J1WaL+vfAJiKtPvPDWPNwlkFHjAb1wCTN4mvMPYAyl4WrFX5/Qw
         VHYw==
X-Gm-Message-State: APjAAAUrSFhHtqjkPcl6Ud+sM5Ax2zlv+smUT/pBauXONfgl5afI5bNd
        rhssGFHn2rSUmxTtUuIrFkE=
X-Google-Smtp-Source: APXvYqyUiqIWkamDb2jZ90CyrUNmgreUe5N1C+h+sBIqiDbvGALw5Ne4VAjRce5u2krIyM+jV575BQ==
X-Received: by 2002:a9d:7d83:: with SMTP id j3mr5879157otn.191.1564533196456;
        Tue, 30 Jul 2019 17:33:16 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id t11sm22156016otq.13.2019.07.30.17.33.15
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 17:33:15 -0700 (PDT)
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, pkshih@realtek.com,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH 3/5] rtlwifi: rtl8188ee: Convert macros that set descriptor
Date:   Tue, 30 Jul 2019 19:33:02 -0500
Message-Id: <20190731003304.14377-4-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190731003304.14377-1-Larry.Finger@lwfinger.net>
References: <20190731003304.14377-1-Larry.Finger@lwfinger.net>
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

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
---
 .../wireless/realtek/rtlwifi/rtl8188ee/dm.c   |   6 +-
 .../wireless/realtek/rtlwifi/rtl8188ee/trx.c  | 222 ++---
 .../wireless/realtek/rtlwifi/rtl8188ee/trx.h  | 760 ++++++++++++------
 3 files changed, 642 insertions(+), 346 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/dm.c b/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/dm.c
index 85360353f557..1ba339788d3a 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/dm.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/dm.c
@@ -1414,9 +1414,9 @@ void rtl88e_dm_set_tx_ant_by_tx_info(struct ieee80211_hw *hw,
 
 	if ((rtlefuse->antenna_div_type == CG_TRX_HW_ANTDIV) ||
 	    (rtlefuse->antenna_div_type == CG_TRX_SMART_ANTDIV)) {
-		SET_TX_DESC_ANTSEL_A(pdesc, pfat_table->antsel_a[mac_id]);
-		SET_TX_DESC_ANTSEL_B(pdesc, pfat_table->antsel_b[mac_id]);
-		SET_TX_DESC_ANTSEL_C(pdesc, pfat_table->antsel_c[mac_id]);
+		set_tx_desc_antsel_a(pdesc, pfat_table->antsel_a[mac_id]);
+		set_tx_desc_antsel_b(pdesc, pfat_table->antsel_b[mac_id]);
+		set_tx_desc_antsel_c(pdesc, pfat_table->antsel_c[mac_id]);
 	}
 }
 
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/trx.c b/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/trx.c
index 483dc8bdc555..d5be69e72838 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/trx.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/trx.c
@@ -319,7 +319,7 @@ static void _rtl88ee_insert_emcontent(struct rtl_tcb_desc *ptcb_desc,
 	u32 dwtmp = 0;
 	memset(virtualaddress, 0, 8);
 
-	SET_EARLYMODE_PKTNUM(virtualaddress, ptcb_desc->empkt_num);
+	set_earlymode_pktnum(virtualaddress, ptcb_desc->empkt_num);
 	if (ptcb_desc->empkt_num == 1) {
 		dwtmp = ptcb_desc->empkt_len[0];
 	} else {
@@ -327,7 +327,7 @@ static void _rtl88ee_insert_emcontent(struct rtl_tcb_desc *ptcb_desc,
 		dwtmp += ((dwtmp%4) ? (4-dwtmp%4) : 0)+4;
 		dwtmp += ptcb_desc->empkt_len[1];
 	}
-	SET_EARLYMODE_LEN0(virtualaddress, dwtmp);
+	set_earlymode_len0(virtualaddress, dwtmp);
 
 	if (ptcb_desc->empkt_num <= 3) {
 		dwtmp = ptcb_desc->empkt_len[2];
@@ -336,7 +336,7 @@ static void _rtl88ee_insert_emcontent(struct rtl_tcb_desc *ptcb_desc,
 		dwtmp += ((dwtmp%4) ? (4-dwtmp%4) : 0)+4;
 		dwtmp += ptcb_desc->empkt_len[3];
 	}
-	SET_EARLYMODE_LEN1(virtualaddress, dwtmp);
+	set_earlymode_len1(virtualaddress, dwtmp);
 	if (ptcb_desc->empkt_num <= 5) {
 		dwtmp = ptcb_desc->empkt_len[4];
 	} else {
@@ -344,8 +344,8 @@ static void _rtl88ee_insert_emcontent(struct rtl_tcb_desc *ptcb_desc,
 		dwtmp += ((dwtmp%4) ? (4-dwtmp%4) : 0)+4;
 		dwtmp += ptcb_desc->empkt_len[5];
 	}
-	SET_EARLYMODE_LEN2_1(virtualaddress, dwtmp & 0xF);
-	SET_EARLYMODE_LEN2_2(virtualaddress, dwtmp >> 4);
+	set_earlymode_len2_1(virtualaddress, dwtmp & 0xF);
+	set_earlymode_len2_2(virtualaddress, dwtmp >> 4);
 	if (ptcb_desc->empkt_num <= 7) {
 		dwtmp = ptcb_desc->empkt_len[6];
 	} else {
@@ -353,7 +353,7 @@ static void _rtl88ee_insert_emcontent(struct rtl_tcb_desc *ptcb_desc,
 		dwtmp += ((dwtmp%4) ? (4-dwtmp%4) : 0)+4;
 		dwtmp += ptcb_desc->empkt_len[7];
 	}
-	SET_EARLYMODE_LEN3(virtualaddress, dwtmp);
+	set_earlymode_len3(virtualaddress, dwtmp);
 	if (ptcb_desc->empkt_num <= 9) {
 		dwtmp = ptcb_desc->empkt_len[8];
 	} else {
@@ -361,7 +361,7 @@ static void _rtl88ee_insert_emcontent(struct rtl_tcb_desc *ptcb_desc,
 		dwtmp += ((dwtmp%4) ? (4-dwtmp%4) : 0)+4;
 		dwtmp += ptcb_desc->empkt_len[9];
 	}
-	SET_EARLYMODE_LEN4(virtualaddress, dwtmp);
+	set_earlymode_len4(virtualaddress, dwtmp);
 }
 
 bool rtl88ee_rx_query_desc(struct ieee80211_hw *hw,
@@ -373,38 +373,38 @@ bool rtl88ee_rx_query_desc(struct ieee80211_hw *hw,
 	struct rx_fwinfo_88e *p_drvinfo;
 	struct ieee80211_hdr *hdr;
 	u8 wake_match;
-	u32 phystatus = GET_RX_DESC_PHYST(pdesc);
+	u32 phystatus = get_rx_desc_physt(pdesc);
 
-	status->packet_report_type = (u8)GET_RX_STATUS_DESC_RPT_SEL(pdesc);
+	status->packet_report_type = (u8)get_rx_status_desc_rpt_sel(pdesc);
 	if (status->packet_report_type == TX_REPORT2)
-		status->length = (u16)GET_RX_RPT2_DESC_PKT_LEN(pdesc);
+		status->length = (u16)get_rx_rpt2_desc_pkt_len(pdesc);
 	else
-		status->length = (u16)GET_RX_DESC_PKT_LEN(pdesc);
-	status->rx_drvinfo_size = (u8)GET_RX_DESC_DRV_INFO_SIZE(pdesc) *
+		status->length = (u16)get_rx_desc_pkt_len(pdesc);
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
-	status->isampdu = (bool) (GET_RX_DESC_PAGGR(pdesc) == 1);
-	status->isfirst_ampdu = (bool)((GET_RX_DESC_PAGGR(pdesc) == 1) &&
-				(GET_RX_DESC_FAGGR(pdesc) == 1));
+	status->decrypted = !get_rx_desc_swdec(pdesc);
+	status->rate = (u8)get_rx_desc_rxmcs(pdesc);
+	status->shortpreamble = (u16)get_rx_desc_splcp(pdesc);
+	status->isampdu = (bool) (get_rx_desc_paggr(pdesc) == 1);
+	status->isfirst_ampdu = (bool)((get_rx_desc_paggr(pdesc) == 1) &&
+				(get_rx_desc_faggr(pdesc) == 1));
 	if (status->packet_report_type == NORMAL_RX)
-		status->timestamp_low = GET_RX_DESC_TSFL(pdesc);
-	status->rx_is40mhzpacket = (bool)GET_RX_DESC_BW(pdesc);
-	status->is_ht = (bool)GET_RX_DESC_RXHT(pdesc);
+		status->timestamp_low = get_rx_desc_tsfl(pdesc);
+	status->rx_is40mhzpacket = (bool)get_rx_desc_bw(pdesc);
+	status->is_ht = (bool)get_rx_desc_rxht(pdesc);
 
 	status->is_cck = RTL8188_RX_HAL_IS_CCK_RATE(status->rate);
 
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
@@ -465,9 +465,9 @@ bool rtl88ee_rx_query_desc(struct ieee80211_hw *hw,
 	rx_status->signal = status->recvsignalpower + 10;
 	if (status->packet_report_type == TX_REPORT2) {
 		status->macid_valid_entry[0] =
-			 GET_RX_RPT2_DESC_MACID_VALID_1(pdesc);
+			 get_rx_rpt2_desc_macid_valid_1(pdesc);
 		status->macid_valid_entry[1] =
-			 GET_RX_RPT2_DESC_MACID_VALID_2(pdesc);
+			 get_rx_rpt2_desc_macid_valid_2(pdesc);
 	}
 	return true;
 }
@@ -528,8 +528,8 @@ void rtl88ee_tx_fill_desc(struct ieee80211_hw *hw,
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
@@ -539,59 +539,59 @@ void rtl88ee_tx_fill_desc(struct ieee80211_hw *hw,
 							  (u8 *)(skb->data));
 			}
 		} else {
-			SET_TX_DESC_OFFSET(pdesc, USB_HWDESC_HEADER_LEN);
+			set_tx_desc_offset(pdesc, USB_HWDESC_HEADER_LEN);
 		}
 
 		ptcb_desc->use_driver_rate = true;
-		SET_TX_DESC_TX_RATE(pdesc, ptcb_desc->hw_rate);
+		set_tx_desc_tx_rate(pdesc, ptcb_desc->hw_rate);
 		if (ptcb_desc->hw_rate > DESC92C_RATEMCS0)
 			short_gi = (ptcb_desc->use_shortgi) ? 1 : 0;
 		else
 			short_gi = (ptcb_desc->use_shortpreamble) ? 1 : 0;
 
-		SET_TX_DESC_DATA_SHORTGI(pdesc, short_gi);
+		set_tx_desc_data_shortgi(pdesc, short_gi);
 
 		if (info->flags & IEEE80211_TX_CTL_AMPDU) {
-			SET_TX_DESC_AGG_ENABLE(pdesc, 1);
-			SET_TX_DESC_MAX_AGG_NUM(pdesc, 0x14);
+			set_tx_desc_agg_enable(pdesc, 1);
+			set_tx_desc_max_agg_num(pdesc, 0x14);
 		}
-		SET_TX_DESC_SEQ(pdesc, seq_number);
-		SET_TX_DESC_RTS_ENABLE(pdesc, ((ptcb_desc->rts_enable &&
+		set_tx_desc_seq(pdesc, seq_number);
+		set_tx_desc_rts_enable(pdesc, ((ptcb_desc->rts_enable &&
 						!ptcb_desc->cts_enable) ? 1 : 0));
-		SET_TX_DESC_HW_RTS_ENABLE(pdesc, 0);
-		SET_TX_DESC_CTS2SELF(pdesc, ((ptcb_desc->cts_enable) ? 1 : 0));
-		SET_TX_DESC_RTS_STBC(pdesc, ((ptcb_desc->rts_stbc) ? 1 : 0));
-
-		SET_TX_DESC_RTS_RATE(pdesc, ptcb_desc->rts_rate);
-		SET_TX_DESC_RTS_BW(pdesc, 0);
-		SET_TX_DESC_RTS_SC(pdesc, ptcb_desc->rts_sc);
-		SET_TX_DESC_RTS_SHORT(pdesc,
+		set_tx_desc_hw_rts_enable(pdesc, 0);
+		set_tx_desc_cts2self(pdesc, ((ptcb_desc->cts_enable) ? 1 : 0));
+		set_tx_desc_rts_stbc(pdesc, ((ptcb_desc->rts_stbc) ? 1 : 0));
+
+		set_tx_desc_rts_rate(pdesc, ptcb_desc->rts_rate);
+		set_tx_desc_rts_bw(pdesc, 0);
+		set_tx_desc_rts_sc(pdesc, ptcb_desc->rts_sc);
+		set_tx_desc_rts_short(pdesc,
 			((ptcb_desc->rts_rate <= DESC92C_RATE54M) ?
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
-		SET_TX_DESC_PKT_SIZE(pdesc, (u16)skb_len);
+		set_tx_desc_linip(pdesc, 0);
+		set_tx_desc_pkt_size(pdesc, (u16)skb_len);
 		if (sta) {
 			u8 ampdu_density = sta->ht_cap.ampdu_density;
-			SET_TX_DESC_AMPDU_DENSITY(pdesc, ampdu_density);
+			set_tx_desc_ampdu_density(pdesc, ampdu_density);
 		}
 		if (info->control.hw_key) {
 			struct ieee80211_key_conf *keyconf;
@@ -601,63 +601,63 @@ void rtl88ee_tx_fill_desc(struct ieee80211_hw *hw,
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
 	}
 
-	SET_TX_DESC_FIRST_SEG(pdesc, (firstseg ? 1 : 0));
-	SET_TX_DESC_LAST_SEG(pdesc, (lastseg ? 1 : 0));
-	SET_TX_DESC_TX_BUFFER_SIZE(pdesc, (u16)buf_len);
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
 
 	if (!ieee80211_is_data_qos(fc))
-		SET_TX_DESC_HWSEQ_EN(pdesc, 1);
-	SET_TX_DESC_MORE_FRAG(pdesc, (lastseg ? 0 : 1));
+		set_tx_desc_hwseq_en(pdesc, 1);
+	set_tx_desc_more_frag(pdesc, (lastseg ? 0 : 1));
 	if (is_multicast_ether_addr(ieee80211_get_DA(hdr)) ||
 	    is_broadcast_ether_addr(ieee80211_get_DA(hdr))) {
-		SET_TX_DESC_BMC(pdesc, 1);
+		set_tx_desc_bmc(pdesc, 1);
 	}
 
 	rtl88e_dm_set_tx_ant_by_tx_info(hw, pdesc, ptcb_desc->mac_id);
@@ -687,39 +687,39 @@ void rtl88ee_tx_fill_cmddesc(struct ieee80211_hw *hw,
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
 
-	SET_TX_DESC_PKT_SIZE(pdesc, (u16)(skb->len));
+	set_tx_desc_pkt_size(pdesc, (u16)(skb->len));
 
-	SET_TX_DESC_FIRST_SEG(pdesc, 1);
-	SET_TX_DESC_LAST_SEG(pdesc, 1);
+	set_tx_desc_first_seg(pdesc, 1);
+	set_tx_desc_last_seg(pdesc, 1);
 
-	SET_TX_DESC_OFFSET(pdesc, 0x20);
+	set_tx_desc_offset(pdesc, 0x20);
 
-	SET_TX_DESC_USE_RATE(pdesc, 1);
+	set_tx_desc_use_rate(pdesc, 1);
 
 	if (!ieee80211_is_data_qos(fc))
-		SET_TX_DESC_HWSEQ_EN(pdesc, 1);
+		set_tx_desc_hwseq_en(pdesc, 1);
 
 	RT_PRINT_DATA(rtlpriv, COMP_CMD, DBG_LOUD,
 		      "H2C Tx Cmd Content\n",
@@ -732,10 +732,10 @@ void rtl88ee_set_desc(struct ieee80211_hw *hw, u8 *pdesc,
 	if (istx == true) {
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
 			WARN_ONCE(true, "rtl8188ee: ERR txdesc :%d not processed\n",
@@ -745,16 +745,16 @@ void rtl88ee_set_desc(struct ieee80211_hw *hw, u8 *pdesc,
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
 			WARN_ONCE(true, "rtl8188ee: ERR rxdesc :%d not processed\n",
@@ -772,10 +772,10 @@ u64 rtl88ee_get_desc(struct ieee80211_hw *hw,
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
 			WARN_ONCE(true, "rtl8188ee: ERR txdesc :%d not processed\n",
@@ -785,13 +785,13 @@ u64 rtl88ee_get_desc(struct ieee80211_hw *hw,
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
 			WARN_ONCE(true, "rtl8188ee: ERR rxdesc :%d not processed\n",
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/trx.h b/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/trx.h
index 8147e95a4cc6..6b054361ed5d 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/trx.h
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/trx.h
@@ -14,241 +14,537 @@
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
-#define GET_TX_DESC_OWN(__pdesc)					\
-	le32_get_bits(*((__le32 *)__pdesc), BIT(31))
-
-#define SET_TX_DESC_MACID(__pdesc, __val)			\
-	le32p_replace_bits((__le32 *)(__pdesc + 4), __val, GENMASK(5, 0))
-#define SET_TX_DESC_QUEUE_SEL(__pdesc, __val)		\
-	le32p_replace_bits((__le32 *)(__pdesc + 4), __val, GENMASK(12, 8))
-#define SET_TX_DESC_RATE_ID(__pdesc, __val)		\
-	le32p_replace_bits((__le32 *)(__pdesc + 4), __val, GENMASK(19, 16))
-#define SET_TX_DESC_NAV_USE_HDR(__pdesc, __val)		\
-	le32p_replace_bits((__le32 *)(__pdesc + 4), __val, BIT(20))
-#define SET_TX_DESC_SEC_TYPE(__pdesc, __val)		\
-	le32p_replace_bits((__le32 *)(__pdesc + 4), __val, GENMASK(23, 22))
-#define SET_TX_DESC_PKT_OFFSET(__pdesc, __val)		\
-	le32p_replace_bits((__le32 *)(__pdesc + 4), __val, GENMASK(30, 26))
-
-#define SET_TX_DESC_AGG_ENABLE(__pdesc, __val)			\
-	le32p_replace_bits((__le32 *)(__pdesc + 8), __val, BIT(12))
-#define SET_TX_DESC_RDG_ENABLE(__pdesc, __val)			\
-	le32p_replace_bits((__le32 *)(__pdesc + 8), __val, BIT(13))
-#define SET_TX_DESC_MORE_FRAG(__pdesc, __val)			\
-	le32p_replace_bits((__le32 *)(__pdesc + 8), __val, BIT(17))
-#define SET_TX_DESC_AMPDU_DENSITY(__pdesc, __val)		\
-	le32p_replace_bits((__le32 *)(__pdesc + 8), __val, GENMASK(22, 20))
-#define SET_TX_DESC_ANTSEL_A(__pdesc, __val)			\
-	le32p_replace_bits((__le32 *)(__pdesc + 8), __val, BIT(24))
-#define SET_TX_DESC_ANTSEL_B(__pdesc, __val)			\
-	le32p_replace_bits((__le32 *)(__pdesc + 8), __val, BIT(25))
-
-#define SET_TX_DESC_SEQ(__pdesc, __val)			\
-	le32p_replace_bits((__le32 *)(__pdesc + 12), __val, GENMASK(27, 16))
-#define SET_TX_DESC_HWSEQ_EN(__pdesc, __val)			\
-	le32p_replace_bits((__le32 *)(__pdesc + 12), __val, BIT(31))
-
-#define SET_TX_DESC_RTS_RATE(__pdesc, __val)		\
-	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, GENMASK(4, 0))
-#define SET_TX_DESC_QOS(__pdesc, __val)			\
-	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, BIT(6))
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
-#define SET_TX_DESC_TX_STBC(__pdesc, __val)		\
-	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, GENMASK(23, 22))
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
-#define SET_TX_DESC_ANTSEL_C(__pdesc, __val)		\
-	le32p_replace_bits((__le32 *)(__pdesc + 28), __val, BIT(29))
-#define SET_TX_DESC_TX_BUFFER_SIZE(__pdesc, __val)     \
-	le32p_replace_bits((__le32 *)(__pdesc + 28), __val, GENMASK(15, 0))
-#define GET_TX_DESC_TX_BUFFER_SIZE(__pdesc)		\
-	le32_get_bits(*((__le32 *)(__pdesc + 28)), GENMASK(15, 0))
-
-#define SET_TX_DESC_TX_BUFFER_ADDRESS(__pdesc, __val)	\
-	*(__le32 *)(__pdesc + 32) = cpu_to_le32(__val)
-
-#define GET_TX_DESC_TX_BUFFER_ADDRESS(__pdesc)		\
-	le32_to_cpu(*((__le32 *)(__pdesc + 32)))
-
-#define SET_TX_DESC_NEXT_DESC_ADDRESS(__pdesc, __val)	\
-	*(__le32 *)(__pdesc + 40) = cpu_to_le32(__val)
-
-#define GET_RX_DESC_PKT_LEN(__pdesc)			\
-	le32_get_bits(*((__le32 *)__pdesc), GENMASK(13, 0))
-#define GET_RX_DESC_CRC32(__pdesc)			\
-	le32_get_bits(*((__le32 *)__pdesc), BIT(14))
-#define GET_RX_DESC_ICV(__pdesc)			\
-	le32_get_bits(*((__le32 *)__pdesc), BIT(15))
-#define GET_RX_DESC_DRV_INFO_SIZE(__pdesc)		\
-	le32_get_bits(*((__le32 *)__pdesc), GENMASK(19, 16))
-#define GET_RX_DESC_SECURITY(__pdesc)			\
-	le32_get_bits(*((__le32 *)__pdesc), GENMASK(22, 20))
-#define GET_RX_DESC_QOS(__pdesc)			\
-	le32_get_bits(*((__le32 *)__pdesc), BIT(23))
-#define GET_RX_DESC_SHIFT(__pdesc)			\
-	le32_get_bits(*((__le32 *)__pdesc), GENMASK(25, 24))
-#define GET_RX_DESC_PHYST(__pdesc)			\
-	le32_get_bits(*((__le32 *)__pdesc), BIT(26))
-#define GET_RX_DESC_SWDEC(__pdesc)			\
-	le32_get_bits(*((__le32 *)__pdesc), BIT(27))
-#define GET_RX_DESC_LS(__pdesc)				\
-	le32_get_bits(*((__le32 *)__pdesc), BIT(28))
-#define GET_RX_DESC_FS(__pdesc)				\
-	le32_get_bits(*((__le32 *)__pdesc), BIT(29))
-#define GET_RX_DESC_EOR(__pdesc)			\
-	le32_get_bits(*((__le32 *)__pdesc), BIT(30))
-#define GET_RX_DESC_OWN(__pdesc)			\
-	le32_get_bits(*((__le32 *)__pdesc), BIT(31))
-
-#define SET_RX_DESC_PKT_LEN(__pdesc, __val)		\
-	le32p_replace_bits((__le32 *)__pdesc, __val, GENMASK(13, 0))
-#define SET_RX_DESC_EOR(__pdesc, __val)			\
-	le32p_replace_bits((__le32 *)__pdesc, __val, BIT(30))
-#define SET_RX_DESC_OWN(__pdesc, __val)			\
-	le32p_replace_bits((__le32 *)__pdesc, __val, BIT(31))
-
-#define GET_RX_DESC_MACID(__pdesc)			\
-	le32_get_bits(*((__le32 *)(__pdesc + 4)), GENMASK(5, 0))
-#define GET_RX_DESC_PAGGR(__pdesc)			\
-	le32_get_bits(*((__le32 *)(__pdesc + 4)), BIT(14))
-#define GET_RX_DESC_FAGGR(__pdesc)			\
-	le32_get_bits(*((__le32 *)(__pdesc + 4)), BIT(15))
-#define GET_RX_DESC_A1_FIT(__pdesc)			\
-	le32_get_bits(*((__le32 *)(__pdesc + 4)), GENMASK(19, 16))
-#define GET_RX_DESC_A2_FIT(__pdesc)			\
-	le32_get_bits(*((__le32 *)(__pdesc + 4)), GENMASK(23, 20))
-#define GET_RX_DESC_PAM(__pdesc)			\
-	le32_get_bits(*((__le32 *)(__pdesc + 4)), BIT(24))
-#define GET_RX_DESC_PWR(__pdesc)			\
-	le32_get_bits(*((__le32 *)(__pdesc + 4)), BIT(25))
-#define GET_RX_DESC_MD(__pdesc)				\
-	le32_get_bits(*((__le32 *)(__pdesc + 4)), BIT(26))
-#define GET_RX_DESC_MF(__pdesc)				\
-	le32_get_bits(*((__le32 *)(__pdesc + 4)), BIT(27))
-#define GET_RX_DESC_TYPE(__pdesc)			\
-	le32_get_bits(*((__le32 *)(__pdesc + 4)), GENMASK(29, 28))
-#define GET_RX_DESC_MC(__pdesc)				\
-	le32_get_bits(*((__le32 *)(__pdesc + 4)), BIT(30))
-#define GET_RX_DESC_BC(__pdesc)				\
-	le32_get_bits(*((__le32 *)(__pdesc + 4)), BIT(31))
-#define GET_RX_DESC_SEQ(__pdesc)			\
-	le32_get_bits(*((__le32 *)(__pdesc + 8)), GENMASK(11, 0))
-#define GET_RX_DESC_FRAG(__pdesc)			\
-	le32_get_bits(*((__le32 *)(__pdesc + 8)), GENMASK(15, 12))
-
-#define GET_RX_DESC_RXMCS(__pdesc)			\
-	le32_get_bits(*((__le32 *)(__pdesc + 12)), GENMASK(5, 0))
-#define GET_RX_DESC_RXHT(__pdesc)			\
-	le32_get_bits(*((__le32 *)(__pdesc + 12)), BIT(6))
-#define GET_RX_STATUS_DESC_RX_GF(__pdesc)		\
-	le32_get_bits(*((__le32 *)(__pdesc + 12)), BIT(7))
-#define GET_RX_DESC_SPLCP(__pdesc)			\
-	le32_get_bits(*((__le32 *)(__pdesc + 12)), BIT(8))
-#define GET_RX_DESC_BW(__pdesc)				\
-	le32_get_bits(*((__le32 *)(__pdesc + 12)), BIT(9))
-#define GET_RX_DESC_HTC(__pdesc)			\
-	le32_get_bits(*((__le32 *)(__pdesc + 12)), BIT(10))
-#define GET_RX_STATUS_DESC_EOSP(__pdesc)		\
-	le32_get_bits(*((__le32 *)(__pdesc + 12)), BIT(11))
-#define GET_RX_STATUS_DESC_BSSID_FIT(__pdesc)		\
-	le32_get_bits(*((__le32 *)(__pdesc + 12)), GENMASK(13, 12))
-#define GET_RX_STATUS_DESC_RPT_SEL(__pdesc)		\
-	le32_get_bits(*((__le32 *)(__pdesc + 12)), GENMASK(15, 14))
-
-#define GET_RX_STATUS_DESC_PATTERN_MATCH(__pdesc)	\
-	le32_get_bits(*((__le32 *)(__pdesc + 12)), BIT(29))
-#define GET_RX_STATUS_DESC_UNICAST_MATCH(__pdesc)	\
-	le32_get_bits(*((__le32 *)(__pdesc + 12)), BIT(30))
-#define GET_RX_STATUS_DESC_MAGIC_MATCH(__pdesc)		\
-	le32_get_bits(*((__le32 *)(__pdesc + 12)), BIT(31))
-
-#define GET_RX_DESC_IV1(__pdesc)			\
-	le32_to_cpu(*((__le32 *)(__pdesc + 16)))
-#define GET_RX_DESC_TSFL(__pdesc)			\
-	le32_to_cpu(*((__le32 *)(__pdesc + 20)))
-
-#define GET_RX_DESC_BUFF_ADDR(__pdesc)			\
-	le32_to_cpu(*((__le32 *)(__pdesc + 24)))
-#define GET_RX_DESC_BUFF_ADDR64(__pdesc)		\
-	le32_to_cpu(*((__le32 *)(__pdesc + 28)))
-
-#define SET_RX_DESC_BUFF_ADDR(__pdesc, __val)	\
-	*(__le32 *)(__pdesc + 24) = cpu_to_le32(__val)
-#define SET_RX_DESC_BUFF_ADDR64(__pdesc, __val) \
-	*(__le32 *)(__pdesc + 28) = cpu_to_le32(__val)
+static inline void set_tx_desc_pkt_size(u8 *__pdesc, u32  __val)
+{
+	le32p_replace_bits((__le32 *)__pdesc, __val, GENMASK(15, 0));
+}
+
+static inline void set_tx_desc_offset(u8 *__pdesc, u32  __val)
+{
+	le32p_replace_bits((__le32 *)__pdesc, __val, GENMASK(23, 16));
+}
+
+static inline void set_tx_desc_bmc(u8 *__pdesc, u32  __val)
+{
+	le32p_replace_bits((__le32 *)__pdesc, __val, BIT(24));
+}
+
+static inline void set_tx_desc_htc(u8 *__pdesc, u32  __val)
+{
+	le32p_replace_bits((__le32 *)__pdesc, __val, BIT(25));
+}
+
+static inline void set_tx_desc_last_seg(u8 *__pdesc, u32  __val)
+{
+	le32p_replace_bits((__le32 *)__pdesc, __val, BIT(26));
+}
+
+static inline void set_tx_desc_first_seg(u8 *__pdesc, u32  __val)
+{
+	le32p_replace_bits((__le32 *)__pdesc, __val, BIT(27));
+}
+
+static inline void set_tx_desc_linip(u8 *__pdesc, u32  __val)
+{
+	le32p_replace_bits((__le32 *)__pdesc, __val, BIT(28));
+}
+
+static inline void set_tx_desc_own(u8 *__pdesc, u32  __val)
+{
+	le32p_replace_bits((__le32 *)__pdesc, __val, BIT(31));
+}
+
+static inline int get_tx_desc_own(u8 *__pdesc)
+{
+	return le32_get_bits(*((__le32 *)__pdesc), BIT(31));
+}
+
+static inline void set_tx_desc_macid(u8 *__pdesc, u32  __val)
+{
+	le32p_replace_bits((__le32 *)(__pdesc + 4), __val, GENMASK(5, 0));
+}
+
+static inline void set_tx_desc_queue_sel(u8 *__pdesc, u32  __val)
+{
+	le32p_replace_bits((__le32 *)(__pdesc + 4), __val, GENMASK(12, 8));
+}
+
+static inline void set_tx_desc_rate_id(u8 *__pdesc, u32  __val)
+{
+	le32p_replace_bits((__le32 *)(__pdesc + 4), __val, GENMASK(19, 16));
+}
+
+static inline void set_tx_desc_nav_use_hdr(u8 *__pdesc, u32  __val)
+{
+	le32p_replace_bits((__le32 *)(__pdesc + 4), __val, BIT(20));
+}
+
+static inline void set_tx_desc_sec_type(u8 *__pdesc, u32  __val)
+{
+	le32p_replace_bits((__le32 *)(__pdesc + 4), __val, GENMASK(23, 22));
+}
+
+static inline void set_tx_desc_pkt_offset(u8 *__pdesc, u32  __val)
+{
+	le32p_replace_bits((__le32 *)(__pdesc + 4), __val, GENMASK(30, 26));
+}
+
+static inline void set_tx_desc_agg_enable(u8 *__pdesc, u32  __val)
+{
+	le32p_replace_bits((__le32 *)(__pdesc + 8), __val, BIT(12));
+}
+
+static inline void set_tx_desc_rdg_enable(u8 *__pdesc, u32  __val)
+{
+	le32p_replace_bits((__le32 *)(__pdesc + 8), __val, BIT(13));
+}
+
+static inline void set_tx_desc_more_frag(u8 *__pdesc, u32  __val)
+{
+	le32p_replace_bits((__le32 *)(__pdesc + 8), __val, BIT(17));
+}
+
+static inline void set_tx_desc_ampdu_density(u8 *__pdesc, u32  __val)
+{
+	le32p_replace_bits((__le32 *)(__pdesc + 8), __val, GENMASK(22, 20));
+}
+
+static inline void set_tx_desc_antsel_a(u8 *__pdesc, u32  __val)
+{
+	le32p_replace_bits((__le32 *)(__pdesc + 8), __val, BIT(24));
+}
+
+static inline void set_tx_desc_antsel_b(u8 *__pdesc, u32  __val)
+{
+	le32p_replace_bits((__le32 *)(__pdesc + 8), __val, BIT(25));
+}
+
+static inline void set_tx_desc_seq(u8 *__pdesc, u32  __val)
+{
+	le32p_replace_bits((__le32 *)(__pdesc + 12), __val, GENMASK(27, 16));
+}
+
+static inline void set_tx_desc_hwseq_en(u8 *__pdesc, u32  __val)
+{
+	le32p_replace_bits((__le32 *)(__pdesc + 12), __val, BIT(31));
+}
+
+static inline void set_tx_desc_rts_rate(u8 *__pdesc, u32  __val)
+{
+	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, GENMASK(4, 0));
+}
+
+static inline void set_tx_desc_qos(u8 *__pdesc, u32  __val)
+{
+	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, BIT(6));
+}
+
+static inline void set_tx_desc_use_rate(u8 *__pdesc, u32  __val)
+{
+	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, BIT(8));
+}
+
+static inline void set_tx_desc_disable_fb(u8 *__pdesc, u32  __val)
+{
+	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, BIT(10));
+}
+
+static inline void set_tx_desc_cts2self(u8 *__pdesc, u32  __val)
+{
+	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, BIT(11));
+}
+
+static inline void set_tx_desc_rts_enable(u8 *__pdesc, u32  __val)
+{
+	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, BIT(12));
+}
+
+static inline void set_tx_desc_hw_rts_enable(u8 *__pdesc, u32  __val)
+{
+	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, BIT(13));
+}
+
+static inline void set_tx_desc_tx_sub_carrier(u8 *__pdesc, u32  __val)
+{
+	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, GENMASK(21, 20));
+}
+
+static inline void set_tx_desc_tx_stbc(u8 *__pdesc, u32  __val)
+{
+	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, GENMASK(23, 22));
+}
+
+static inline void set_tx_desc_data_bw(u8 *__pdesc, u32  __val)
+{
+	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, BIT(25));
+}
+
+static inline void set_tx_desc_rts_short(u8 *__pdesc, u32  __val)
+{
+	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, BIT(26));
+}
+
+static inline void set_tx_desc_rts_bw(u8 *__pdesc, u32  __val)
+{
+	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, BIT(27));
+}
+
+static inline void set_tx_desc_rts_sc(u8 *__pdesc, u32  __val)
+{
+	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, GENMASK(29, 28));
+}
+
+static inline void set_tx_desc_rts_stbc(u8 *__pdesc, u32  __val)
+{
+	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, GENMASK(31, 30));
+}
+
+static inline void set_tx_desc_tx_rate(u8 *__pdesc, u32  __val)
+{
+	le32p_replace_bits((__le32 *)(__pdesc + 20), __val, GENMASK(5, 0));
+}
+
+static inline void set_tx_desc_data_shortgi(u8 *__pdesc, u32  __val)
+{
+	le32p_replace_bits((__le32 *)(__pdesc + 20), __val, BIT(6));
+}
+
+static inline void set_tx_desc_data_rate_fb_limit(u8 *__pdesc, u32  __val)
+{
+	le32p_replace_bits((__le32 *)(__pdesc + 20), __val, GENMASK(12, 8));
+}
+
+static inline void set_tx_desc_rts_rate_fb_limit(u8 *__pdesc, u32  __val)
+{
+	le32p_replace_bits((__le32 *)(__pdesc + 20), __val, GENMASK(16, 13));
+}
+
+static inline void set_tx_desc_max_agg_num(u8 *__pdesc, u32  __val)
+{
+	le32p_replace_bits((__le32 *)(__pdesc + 24), __val, GENMASK(15, 11));
+}
+
+static inline void set_tx_desc_antsel_c(u8 *__pdesc, u32  __val)
+{
+	le32p_replace_bits((__le32 *)(__pdesc + 28), __val, BIT(29));
+}
+
+static inline void set_tx_desc_tx_buffer_size(u8 *__pdesc, u32  __val)
+{
+	le32p_replace_bits((__le32 *)(__pdesc + 28), __val, GENMASK(15, 0));
+}
+
+static inline int get_tx_desc_tx_buffer_size(u8 *__pdesc)
+{
+	return le32_get_bits(*((__le32 *)(__pdesc + 28)), GENMASK(15, 0));
+}
+
+static inline void set_tx_desc_tx_buffer_address(u8 *__pdesc, u32  __val)
+{
+	*(__le32 *)(__pdesc + 32) = cpu_to_le32(__val);
+}
+
+static inline int get_tx_desc_tx_buffer_address(u8 *__pdesc)
+{
+	return le32_to_cpu(*((__le32 *)(__pdesc + 32)));
+}
+
+static inline void set_tx_desc_next_desc_address(u8 *__pdesc, u32  __val)
+{
+	*(__le32 *)(__pdesc + 40) = cpu_to_le32(__val);
+}
+
+static inline int get_rx_desc_pkt_len(u8 *__pdesc)
+{
+	return le32_get_bits(*((__le32 *)__pdesc), GENMASK(13, 0));
+}
+
+static inline int get_rx_desc_crc32(u8 *__pdesc)
+{
+	return le32_get_bits(*((__le32 *)__pdesc), BIT(14));
+}
+
+static inline int get_rx_desc_icv(u8 *__pdesc)
+{
+	return le32_get_bits(*((__le32 *)__pdesc), BIT(15));
+}
+
+static inline int get_rx_desc_drv_info_size(u8 *__pdesc)
+{
+	return le32_get_bits(*((__le32 *)__pdesc), GENMASK(19, 16));
+}
+
+static inline int get_rx_desc_security(u8 *__pdesc)
+{
+	return le32_get_bits(*((__le32 *)__pdesc), GENMASK(22, 20));
+}
+
+static inline int get_rx_desc_qos(u8 *__pdesc)
+{
+	return le32_get_bits(*((__le32 *)__pdesc), BIT(23));
+}
+
+static inline int get_rx_desc_shift(u8 *__pdesc)
+{
+	return le32_get_bits(*((__le32 *)__pdesc), GENMASK(25, 24));
+}
+
+static inline int get_rx_desc_physt(u8 *__pdesc)
+{
+	return le32_get_bits(*((__le32 *)__pdesc), BIT(26));
+}
+
+static inline int get_rx_desc_swdec(u8 *__pdesc)
+{
+	return le32_get_bits(*((__le32 *)__pdesc), BIT(27));
+}
+
+static inline int get_rx_desc_ls(u8 *__pdesc)
+{
+	return le32_get_bits(*((__le32 *)__pdesc), BIT(28));
+}
+
+static inline int get_rx_desc_fs(u8 *__pdesc)
+{
+	return le32_get_bits(*((__le32 *)__pdesc), BIT(29));
+}
+
+static inline int get_rx_desc_eor(u8 *__pdesc)
+{
+	return le32_get_bits(*((__le32 *)__pdesc), BIT(30));
+}
+
+static inline int get_rx_desc_own(u8 *__pdesc)
+{
+	return le32_get_bits(*((__le32 *)__pdesc), BIT(31));
+}
+
+static inline void set_rx_desc_pkt_len(u8 *__pdesc, u32  __val)
+{
+	le32p_replace_bits((__le32 *)__pdesc, __val, GENMASK(13, 0));
+}
+
+static inline void set_rx_desc_eor(u8 *__pdesc, u32  __val)
+{
+	le32p_replace_bits((__le32 *)__pdesc, __val, BIT(30));
+}
+
+static inline void set_rx_desc_own(u8 *__pdesc, u32  __val)
+{
+	le32p_replace_bits((__le32 *)__pdesc, __val, BIT(31));
+}
+
+static inline int get_rx_desc_macid(u8 *__pdesc)
+{
+	return le32_get_bits(*((__le32 *)(__pdesc + 4)), GENMASK(5, 0));
+}
+
+static inline int get_rx_desc_paggr(u8 *__pdesc)
+{
+	return le32_get_bits(*((__le32 *)(__pdesc + 4)), BIT(14));
+}
+
+static inline int get_rx_desc_faggr(u8 *__pdesc)
+{
+	return le32_get_bits(*((__le32 *)(__pdesc + 4)), BIT(15));
+}
+
+static inline int get_rx_desc_a1_fit(u8 *__pdesc)
+{
+	return le32_get_bits(*((__le32 *)(__pdesc + 4)), GENMASK(19, 16));
+}
+
+static inline int get_rx_desc_a2_fit(u8 *__pdesc)
+{
+	return le32_get_bits(*((__le32 *)(__pdesc + 4)), GENMASK(23, 20));
+}
+
+static inline int get_rx_desc_pam(u8 *__pdesc)
+{
+	return le32_get_bits(*((__le32 *)(__pdesc + 4)), BIT(24));
+}
+
+static inline int get_rx_desc_pwr(u8 *__pdesc)
+{
+	return le32_get_bits(*((__le32 *)(__pdesc + 4)), BIT(25));
+}
+
+static inline int get_rx_desc_md(u8 *__pdesc)
+{
+	return le32_get_bits(*((__le32 *)(__pdesc + 4)), BIT(26));
+}
+
+static inline int get_rx_desc_mf(u8 *__pdesc)
+{
+	return le32_get_bits(*((__le32 *)(__pdesc + 4)), BIT(27));
+}
+
+static inline int get_rx_desc_type(u8 *__pdesc)
+{
+	return le32_get_bits(*((__le32 *)(__pdesc + 4)), GENMASK(29, 28));
+}
+
+static inline int get_rx_desc_mc(u8 *__pdesc)
+{
+	return le32_get_bits(*((__le32 *)(__pdesc + 4)), BIT(30));
+}
+
+static inline int get_rx_desc_bc(u8 *__pdesc)
+{
+	return le32_get_bits(*((__le32 *)(__pdesc + 4)), BIT(31));
+}
+
+static inline int get_rx_desc_seq(u8 *__pdesc)
+{
+	return le32_get_bits(*((__le32 *)(__pdesc + 8)), GENMASK(11, 0));
+}
+
+static inline int get_rx_desc_frag(u8 *__pdesc)
+{
+	return le32_get_bits(*((__le32 *)(__pdesc + 8)), GENMASK(15, 12));
+}
+
+static inline int get_rx_desc_rxmcs(u8 *__pdesc)
+{
+	return le32_get_bits(*((__le32 *)(__pdesc + 12)), GENMASK(5, 0));
+}
+
+static inline int get_rx_desc_rxht(u8 *__pdesc)
+{
+	return le32_get_bits(*((__le32 *)(__pdesc + 12)), BIT(6));
+}
+
+static inline int get_rx_status_desc_rx_gf(u8 *__pdesc)
+{
+	return le32_get_bits(*((__le32 *)(__pdesc + 12)), BIT(7));
+}
+
+static inline int get_rx_desc_splcp(u8 *__pdesc)
+{
+	return le32_get_bits(*((__le32 *)(__pdesc + 12)), BIT(8));
+}
+
+static inline int get_rx_desc_bw(u8 *__pdesc)
+{
+	return le32_get_bits(*((__le32 *)(__pdesc + 12)), BIT(9));
+}
+
+static inline int get_rx_desc_htc(u8 *__pdesc)
+{
+	return le32_get_bits(*((__le32 *)(__pdesc + 12)), BIT(10));
+}
+
+static inline int get_rx_status_desc_eosp(u8 *__pdesc)
+{
+	return le32_get_bits(*((__le32 *)(__pdesc + 12)), BIT(11));
+}
+
+static inline int get_rx_status_desc_bssid_fit(u8 *__pdesc)
+{
+	return le32_get_bits(*((__le32 *)(__pdesc + 12)), GENMASK(13, 12));
+}
+
+static inline int get_rx_status_desc_rpt_sel(u8 *__pdesc)
+{
+	return le32_get_bits(*((__le32 *)(__pdesc + 12)), GENMASK(15, 14));
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
+static inline int get_rx_desc_iv1(u8 *__pdesc)
+{
+	return le32_to_cpu(*((__le32 *)(__pdesc + 16)));
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
+static inline int get_rx_desc_buff_addr64(u8 *__pdesc)
+{
+	return le32_to_cpu(*((__le32 *)(__pdesc + 28)));
+}
+
+static inline void set_rx_desc_buff_addr(u8 *__pdesc, u32  __val)
+{
+	*(__le32 *)(__pdesc + 24) = cpu_to_le32(__val);
+}
+
+static inline void set_rx_desc_buff_addr64(u8 *__pdesc, u32  __val)
+{
+	*(__le32 *)(__pdesc + 28) = cpu_to_le32(__val);
+}
 
 /* TX report 2 format in Rx desc*/
 
-#define GET_RX_RPT2_DESC_PKT_LEN(__status)	\
-	le32_get_bits(*((__le32 *)__status), GENMASK(8, 0))
-#define GET_RX_RPT2_DESC_MACID_VALID_1(__status)	\
-	le32_to_cpu(*((__le32 *)(__status + 16)))
-#define GET_RX_RPT2_DESC_MACID_VALID_2(__status)	\
-	le32_to_cpu(*((__le32 *)(__status + 20)))
-
-#define SET_EARLYMODE_PKTNUM(__paddr, __value)	\
-	le32p_replace_bits((__le32 *)__paddr, __value, GENMASK(3, 0))
-#define SET_EARLYMODE_LEN0(__paddr, __value)	\
-	le32p_replace_bits((__le32 *)__paddr, __value, GENMASK(15, 4))
-#define SET_EARLYMODE_LEN1(__paddr, __value)	\
-	le32p_replace_bits((__le32 *)__paddr, __value, GENMASK(27, 16))
-#define SET_EARLYMODE_LEN2_1(__paddr, __value)	\
-	le32p_replace_bits((__le32 *)__paddr, __value, GENMASK(31, 28))
-#define SET_EARLYMODE_LEN2_2(__paddr, __value)	\
-	le32p_replace_bits((__le32 *)(__paddr + 4), __value, GENMASK(7, 0))
-#define SET_EARLYMODE_LEN3(__paddr, __value)	\
-	le32p_replace_bits((__le32 *)(__paddr + 4), __value, GENMASK(19, 8))
-#define SET_EARLYMODE_LEN4(__paddr, __value)	\
-	le32p_replace_bits((__le32 *)(__paddr + 4), __value, GENMASK(31, 20))
+static inline int get_rx_rpt2_desc_pkt_len(u8 *__status)
+{
+	return le32_get_bits(*((__le32 *)__status), GENMASK(8, 0));
+}
+
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
+static inline void set_earlymode_pktnum(u8 *__paddr, u32  __value)
+{
+	le32p_replace_bits((__le32 *)__paddr, __value, GENMASK(3, 0));
+}
+
+static inline void set_earlymode_len0(u8 *__paddr, u32  __value)
+{
+	le32p_replace_bits((__le32 *)__paddr, __value, GENMASK(15, 4));
+}
+
+static inline void set_earlymode_len1(u8 *__paddr, u32  __value)
+{
+	le32p_replace_bits((__le32 *)__paddr, __value, GENMASK(27, 16));
+}
+
+static inline void set_earlymode_len2_1(u8 *__paddr, u32  __value)
+{
+	le32p_replace_bits((__le32 *)__paddr, __value, GENMASK(31, 28));
+}
+
+static inline void set_earlymode_len2_2(u8 *__paddr, u32  __value)
+{
+	le32p_replace_bits((__le32 *)(__paddr + 4), __value, GENMASK(7, 0));
+}
+
+static inline void set_earlymode_len3(u8 *__paddr, u32  __value)
+{
+	le32p_replace_bits((__le32 *)(__paddr + 4), __value, GENMASK(19, 8));
+}
+
+static inline void set_earlymode_len4(u8 *__paddr, u32  __value)
+{
+	le32p_replace_bits((__le32 *)(__paddr + 4), __value, GENMASK(31, 20));
+}
 
 #define CLEAR_PCI_TX_DESC_CONTENT(__pdesc, _size)		\
 do {								\
-- 
2.22.0

