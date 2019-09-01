Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD7F3A4A20
	for <lists+linux-wireless@lfdr.de>; Sun,  1 Sep 2019 17:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729166AbfIAPrP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 1 Sep 2019 11:47:15 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:37678 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728621AbfIAPrO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 1 Sep 2019 11:47:14 -0400
Received: by mail-ot1-f66.google.com with SMTP id 97so8605004otr.4
        for <linux-wireless@vger.kernel.org>; Sun, 01 Sep 2019 08:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8hOYI62P0dEa0jRVkJEIjHuMfDfEaEj0ant+x7m7yvA=;
        b=onzUV9wTxLc0zfNwHX3Y+UVm7CJ9vCQDwlnaGojs4Fk3naZK0NWXp8HquqyfltveX5
         tZTH8hNK1Af4D8HgMNIziEYW+rs3JPMN9Sg9mD79hL1Qkqd5avPGi9o4V1OHnZCU7LLE
         uZxuRVPefsuDTuK6e3+bms+9zQ8EZDwLxzyvzTHrIZXLDmVE/fHV25WFaICahWQY5ts6
         92dYY07W9iII0hBuBUwgZFabfKwhMPm4r8nYeDiVCuGy1qtbHU2P2oQ+iMu1MJp82SM+
         vH2nRP2tGNZP2mZ4SXjheWVRgIuuIbWPzzdObjvnT67usg1QLyn4BgKuqcrOMRmlZSUO
         uvbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=8hOYI62P0dEa0jRVkJEIjHuMfDfEaEj0ant+x7m7yvA=;
        b=bWTLapcIZc1yKJqfXYJ0hoqwp9eoHgJljx9DkJ1LBLiLNx/CvMvOhMXP5POOBedFlZ
         mZ7QtTvAKphgPzo7tOv8HwL74Fxn8hYP/5i63Ti6z+chpSXVV+mSSRlfJw3WTBKUbgei
         k7xtAYRaJpwvBi9LLDxGsL7BYTmSecDe+1maaT38L9hUWjkFi6qjRxuGlB4/SkgEJdil
         x0ZLEgiZwtBZ2fHYROxsyHM37j+JeluDxgIx0X+664d5vpdHGBqgkeoteDk4xZm+5UkY
         DnMu6StVyyHpZ6Shi0g423Kt11PXbRV4ImvqAa89oiIEhvZj2y4CnePwN5oZzjgYl2X9
         2Trw==
X-Gm-Message-State: APjAAAXEsLV+VN1QpWDlqAAOv3hMm64p4gt7yG/j9tcUsVUMRH0Vi+Ja
        YONPKP5kjmeTf6HJFwv4FHI=
X-Google-Smtp-Source: APXvYqypv/31c/x6efJ2b5Azo9JABJobHZzj615t/4P96dX/CH+SdgeEm0vJC/J8MWHFDusgC0GcYQ==
X-Received: by 2002:a05:6830:4da:: with SMTP id s26mr19370997otd.223.1567352832249;
        Sun, 01 Sep 2019 08:47:12 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id b19sm3186440oie.34.2019.09.01.08.47.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 Sep 2019 08:47:11 -0700 (PDT)
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, pkshih@realtek.com,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH 3/4] rtlwifi: rtl8192cu: Convert macros that set descriptor
Date:   Sun,  1 Sep 2019 10:47:05 -0500
Message-Id: <20190901154706.24193-4-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190901154706.24193-1-Larry.Finger@lwfinger.net>
References: <20190901154706.24193-1-Larry.Finger@lwfinger.net>
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
 .../net/wireless/realtek/rtlwifi/rtl8192cu/mac.c   |   6 +-
 .../net/wireless/realtek/rtlwifi/rtl8192cu/trx.c   | 246 ++++++-------
 .../net/wireless/realtek/rtlwifi/rtl8192cu/trx.h   | 385 +++++++++++++++------
 3 files changed, 402 insertions(+), 235 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/mac.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/mac.c
index b3ce8000d52d..a2f878de0a70 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/mac.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/mac.c
@@ -736,9 +736,9 @@ static void _rtl92c_query_rxphystatus(struct ieee80211_hw *hw,
 		pstats->rx_pwdb_all = pwdb_all;
 		pstats->rxpower = rx_pwr_all;
 		pstats->recvsignalpower = rx_pwr_all;
-		if (GET_RX_DESC_RX_MCS(pdesc) &&
-		    GET_RX_DESC_RX_MCS(pdesc) >= DESC_RATEMCS8 &&
-		    GET_RX_DESC_RX_MCS(pdesc) <= DESC_RATEMCS15)
+		if (get_rx_desc_rx_mcs(pdesc) &&
+		    get_rx_desc_rx_mcs(pdesc) >= DESC_RATEMCS8 &&
+		    get_rx_desc_rx_mcs(pdesc) <= DESC_RATEMCS15)
 			max_spatial_stream = 2;
 		else
 			max_spatial_stream = 1;
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.c
index 9b5c7ec6b6f7..a9f16868791f 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.c
@@ -286,40 +286,40 @@ bool rtl92cu_rx_query_desc(struct ieee80211_hw *hw,
 {
 	struct rx_fwinfo_92c *p_drvinfo;
 	struct rx_desc_92c *p_desc = (struct rx_desc_92c *)pdesc;
-	u32 phystatus = GET_RX_DESC_PHY_STATUS(pdesc);
+	u32 phystatus = get_rx_desc_phy_status(pdesc);
 
-	stats->length = (u16) GET_RX_DESC_PKT_LEN(pdesc);
-	stats->rx_drvinfo_size = (u8)GET_RX_DESC_DRVINFO_SIZE(pdesc) *
+	stats->length = (u16)get_rx_desc_pkt_len(pdesc);
+	stats->rx_drvinfo_size = (u8)get_rx_desc_drvinfo_size(pdesc) *
 				 RX_DRV_INFO_SIZE_UNIT;
-	stats->rx_bufshift = (u8) (GET_RX_DESC_SHIFT(pdesc) & 0x03);
-	stats->icv = (u16) GET_RX_DESC_ICV(pdesc);
-	stats->crc = (u16) GET_RX_DESC_CRC32(pdesc);
+	stats->rx_bufshift = (u8)(get_rx_desc_shift(pdesc) & 0x03);
+	stats->icv = (u16)get_rx_desc_icv(pdesc);
+	stats->crc = (u16)get_rx_desc_crc32(pdesc);
 	stats->hwerror = (stats->crc | stats->icv);
-	stats->decrypted = !GET_RX_DESC_SWDEC(pdesc);
-	stats->rate = (u8) GET_RX_DESC_RX_MCS(pdesc);
-	stats->shortpreamble = (u16) GET_RX_DESC_SPLCP(pdesc);
-	stats->isampdu = (bool) (GET_RX_DESC_PAGGR(pdesc) == 1);
-	stats->isfirst_ampdu = (bool)((GET_RX_DESC_PAGGR(pdesc) == 1)
-				   && (GET_RX_DESC_FAGGR(pdesc) == 1));
-	stats->timestamp_low = GET_RX_DESC_TSFL(pdesc);
-	stats->rx_is40mhzpacket = (bool)GET_RX_DESC_BW(pdesc);
-	stats->is_ht = (bool)GET_RX_DESC_RX_HT(pdesc);
+	stats->decrypted = !get_rx_desc_swdec(pdesc);
+	stats->rate = (u8)get_rx_desc_rx_mcs(pdesc);
+	stats->shortpreamble = (u16)get_rx_desc_splcp(pdesc);
+	stats->isampdu = (bool)(get_rx_desc_paggr(pdesc) == 1);
+	stats->isfirst_ampdu = (bool)((get_rx_desc_paggr(pdesc) == 1) &&
+				      (get_rx_desc_faggr(pdesc) == 1));
+	stats->timestamp_low = get_rx_desc_tsfl(pdesc);
+	stats->rx_is40mhzpacket = (bool)get_rx_desc_bw(pdesc);
+	stats->is_ht = (bool)get_rx_desc_rx_ht(pdesc);
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
-	if (GET_RX_DESC_RX_HT(pdesc))
+	if (get_rx_desc_rx_ht(pdesc))
 		rx_status->encoding = RX_ENC_HT;
 	rx_status->flag |= RX_FLAG_MACTIME_START;
 	if (stats->decrypted)
 		rx_status->flag |= RX_FLAG_DECRYPTED;
 	rx_status->rate_idx = rtlwifi_rate_mapping(hw, stats->is_ht,
 						   false, stats->rate);
-	rx_status->mactime = GET_RX_DESC_TSFL(pdesc);
+	rx_status->mactime = get_rx_desc_tsfl(pdesc);
 	if (phystatus) {
 		p_drvinfo = (struct rx_fwinfo_92c *)(skb->data +
 						     stats->rx_bufshift);
@@ -352,42 +352,42 @@ static void _rtl_rx_process(struct ieee80211_hw *hw, struct sk_buff *skb)
 	memset(rx_status, 0, sizeof(*rx_status));
 	rxdesc	= skb->data;
 	skb_len	= skb->len;
-	drvinfo_len = (GET_RX_DESC_DRVINFO_SIZE(rxdesc) * RTL_RX_DRV_INFO_UNIT);
-	pkt_len		= GET_RX_DESC_PKT_LEN(rxdesc);
+	drvinfo_len = (get_rx_desc_drvinfo_size(rxdesc) * RTL_RX_DRV_INFO_UNIT);
+	pkt_len		= get_rx_desc_pkt_len(rxdesc);
 	/* TODO: Error recovery. drop this skb or something. */
 	WARN_ON(skb_len < (pkt_len + RTL_RX_DESC_SIZE + drvinfo_len));
-	stats.length = (u16) GET_RX_DESC_PKT_LEN(rxdesc);
-	stats.rx_drvinfo_size = (u8)GET_RX_DESC_DRVINFO_SIZE(rxdesc) *
+	stats.length = (u16)get_rx_desc_pkt_len(rxdesc);
+	stats.rx_drvinfo_size = (u8)get_rx_desc_drvinfo_size(rxdesc) *
 				RX_DRV_INFO_SIZE_UNIT;
-	stats.rx_bufshift = (u8) (GET_RX_DESC_SHIFT(rxdesc) & 0x03);
-	stats.icv = (u16) GET_RX_DESC_ICV(rxdesc);
-	stats.crc = (u16) GET_RX_DESC_CRC32(rxdesc);
+	stats.rx_bufshift = (u8)(get_rx_desc_shift(rxdesc) & 0x03);
+	stats.icv = (u16)get_rx_desc_icv(rxdesc);
+	stats.crc = (u16)get_rx_desc_crc32(rxdesc);
 	stats.hwerror = (stats.crc | stats.icv);
-	stats.decrypted = !GET_RX_DESC_SWDEC(rxdesc);
-	stats.rate = (u8) GET_RX_DESC_RX_MCS(rxdesc);
-	stats.shortpreamble = (u16) GET_RX_DESC_SPLCP(rxdesc);
-	stats.isampdu = (bool) ((GET_RX_DESC_PAGGR(rxdesc) == 1)
-				   && (GET_RX_DESC_FAGGR(rxdesc) == 1));
-	stats.timestamp_low = GET_RX_DESC_TSFL(rxdesc);
-	stats.rx_is40mhzpacket = (bool)GET_RX_DESC_BW(rxdesc);
-	stats.is_ht = (bool)GET_RX_DESC_RX_HT(rxdesc);
+	stats.decrypted = !get_rx_desc_swdec(rxdesc);
+	stats.rate = (u8)get_rx_desc_rx_mcs(rxdesc);
+	stats.shortpreamble = (u16)get_rx_desc_splcp(rxdesc);
+	stats.isampdu = (bool)((get_rx_desc_paggr(rxdesc) == 1) &&
+			       (get_rx_desc_faggr(rxdesc) == 1));
+	stats.timestamp_low = get_rx_desc_tsfl(rxdesc);
+	stats.rx_is40mhzpacket = (bool)get_rx_desc_bw(rxdesc);
+	stats.is_ht = (bool)get_rx_desc_rx_ht(rxdesc);
 	/* TODO: is center_freq changed when doing scan? */
 	/* TODO: Shall we add protection or just skip those two step? */
 	rx_status->freq = hw->conf.chandef.chan->center_freq;
 	rx_status->band = hw->conf.chandef.chan->band;
-	if (GET_RX_DESC_CRC32(rxdesc))
+	if (get_rx_desc_crc32(rxdesc))
 		rx_status->flag |= RX_FLAG_FAILED_FCS_CRC;
-	if (!GET_RX_DESC_SWDEC(rxdesc))
+	if (!get_rx_desc_swdec(rxdesc))
 		rx_status->flag |= RX_FLAG_DECRYPTED;
-	if (GET_RX_DESC_BW(rxdesc))
+	if (get_rx_desc_bw(rxdesc))
 		rx_status->bw = RATE_INFO_BW_40;
-	if (GET_RX_DESC_RX_HT(rxdesc))
+	if (get_rx_desc_rx_ht(rxdesc))
 		rx_status->encoding = RX_ENC_HT;
 	/* Data rate */
 	rx_status->rate_idx = rtlwifi_rate_mapping(hw, stats.is_ht,
 						   false, stats.rate);
 	/*  There is a phy status after this rx descriptor. */
-	if (GET_RX_DESC_PHY_STATUS(rxdesc)) {
+	if (get_rx_desc_phy_status(rxdesc)) {
 		p_drvinfo = (struct rx_fwinfo_92c *)(rxdesc + RTL_RX_DESC_SIZE);
 		rtl92c_translate_rx_signal_stuff(hw, skb, &stats,
 				 (struct rx_desc_92c *)rxdesc, p_drvinfo);
@@ -442,9 +442,9 @@ struct sk_buff *rtl8192c_tx_aggregate_hdl(struct ieee80211_hw *hw,
 
 static void _rtl_fill_usb_tx_desc(u8 *txdesc)
 {
-	SET_TX_DESC_OWN(txdesc, 1);
-	SET_TX_DESC_LAST_SEG(txdesc, 1);
-	SET_TX_DESC_FIRST_SEG(txdesc, 1);
+	set_tx_desc_own(txdesc, 1);
+	set_tx_desc_last_seg(txdesc, 1);
+	set_tx_desc_first_seg(txdesc, 1);
 }
 
 /**
@@ -457,10 +457,10 @@ static void _rtl_tx_desc_checksum(u8 *txdesc)
 	u32 index;
 
 	/* Clear first */
-	SET_TX_DESC_TX_DESC_CHECKSUM(txdesc, 0);
+	set_tx_desc_tx_desc_checksum(txdesc, 0);
 	for (index = 0; index < 16; index++)
 		checksum = checksum ^ le16_to_cpu(*(ptr + index));
-	SET_TX_DESC_TX_DESC_CHECKSUM(txdesc, checksum);
+	set_tx_desc_tx_desc_checksum(txdesc, checksum);
 }
 
 void rtl92cu_tx_fill_desc(struct ieee80211_hw *hw,
@@ -489,55 +489,57 @@ void rtl92cu_tx_fill_desc(struct ieee80211_hw *hw,
 	rtl_get_tcb_desc(hw, info, sta, skb, tcb_desc);
 	txdesc = skb_push(skb, RTL_TX_HEADER_SIZE);
 	memset(txdesc, 0, RTL_TX_HEADER_SIZE);
-	SET_TX_DESC_PKT_SIZE(txdesc, pktlen);
-	SET_TX_DESC_LINIP(txdesc, 0);
-	SET_TX_DESC_PKT_OFFSET(txdesc, RTL_DUMMY_OFFSET);
-	SET_TX_DESC_OFFSET(txdesc, RTL_TX_HEADER_SIZE);
-	SET_TX_DESC_TX_RATE(txdesc, tcb_desc->hw_rate);
+	set_tx_desc_pkt_size(txdesc, pktlen);
+	set_tx_desc_linip(txdesc, 0);
+	set_tx_desc_pkt_offset(txdesc, RTL_DUMMY_OFFSET);
+	set_tx_desc_offset(txdesc, RTL_TX_HEADER_SIZE);
+	set_tx_desc_tx_rate(txdesc, tcb_desc->hw_rate);
 	if (tcb_desc->use_shortgi || tcb_desc->use_shortpreamble)
-		SET_TX_DESC_DATA_SHORTGI(txdesc, 1);
+		set_tx_desc_data_shortgi(txdesc, 1);
 	if (mac->tids[tid].agg.agg_state == RTL_AGG_ON &&
 		    info->flags & IEEE80211_TX_CTL_AMPDU) {
-		SET_TX_DESC_AGG_ENABLE(txdesc, 1);
-		SET_TX_DESC_MAX_AGG_NUM(txdesc, 0x14);
+		set_tx_desc_agg_enable(txdesc, 1);
+		set_tx_desc_max_agg_num(txdesc, 0x14);
 	} else {
-		SET_TX_DESC_AGG_BREAK(txdesc, 1);
+		set_tx_desc_agg_break(txdesc, 1);
 	}
-	SET_TX_DESC_SEQ(txdesc, seq_number);
-	SET_TX_DESC_RTS_ENABLE(txdesc, ((tcb_desc->rts_enable &&
-			       !tcb_desc->cts_enable) ? 1 : 0));
-	SET_TX_DESC_HW_RTS_ENABLE(txdesc, ((tcb_desc->rts_enable ||
-				  tcb_desc->cts_enable) ? 1 : 0));
-	SET_TX_DESC_CTS2SELF(txdesc, ((tcb_desc->cts_enable) ? 1 : 0));
-	SET_TX_DESC_RTS_STBC(txdesc, ((tcb_desc->rts_stbc) ? 1 : 0));
-	SET_TX_DESC_RTS_RATE(txdesc, tcb_desc->rts_rate);
-	SET_TX_DESC_RTS_BW(txdesc, 0);
-	SET_TX_DESC_RTS_SC(txdesc, tcb_desc->rts_sc);
-	SET_TX_DESC_RTS_SHORT(txdesc,
+	set_tx_desc_seq(txdesc, seq_number);
+	set_tx_desc_rts_enable(txdesc,
+			       ((tcb_desc->rts_enable &&
+				!tcb_desc->cts_enable) ? 1 : 0));
+	set_tx_desc_hw_rts_enable(txdesc,
+				  ((tcb_desc->rts_enable ||
+				   tcb_desc->cts_enable) ? 1 : 0));
+	set_tx_desc_cts2self(txdesc, ((tcb_desc->cts_enable) ? 1 : 0));
+	set_tx_desc_rts_stbc(txdesc, ((tcb_desc->rts_stbc) ? 1 : 0));
+	set_tx_desc_rts_rate(txdesc, tcb_desc->rts_rate);
+	set_tx_desc_rts_bw(txdesc, 0);
+	set_tx_desc_rts_sc(txdesc, tcb_desc->rts_sc);
+	set_tx_desc_rts_short(txdesc,
 			      ((tcb_desc->rts_rate <= DESC_RATE54M) ?
 			       (tcb_desc->rts_use_shortpreamble ? 1 : 0)
 			       : (tcb_desc->rts_use_shortgi ? 1 : 0)));
 	if (mac->bw_40) {
 		if (rate_flag & IEEE80211_TX_RC_DUP_DATA) {
-			SET_TX_DESC_DATA_BW(txdesc, 1);
-			SET_TX_DESC_DATA_SC(txdesc, 3);
+			set_tx_desc_data_bw(txdesc, 1);
+			set_tx_desc_data_sc(txdesc, 3);
 		} else if(rate_flag & IEEE80211_TX_RC_40_MHZ_WIDTH){
-			SET_TX_DESC_DATA_BW(txdesc, 1);
-			SET_TX_DESC_DATA_SC(txdesc, mac->cur_40_prime_sc);
+			set_tx_desc_data_bw(txdesc, 1);
+			set_tx_desc_data_sc(txdesc, mac->cur_40_prime_sc);
 		} else {
-			SET_TX_DESC_DATA_BW(txdesc, 0);
-			SET_TX_DESC_DATA_SC(txdesc, 0);
+			set_tx_desc_data_bw(txdesc, 0);
+			set_tx_desc_data_sc(txdesc, 0);
 		}
 	} else {
-		SET_TX_DESC_DATA_BW(txdesc, 0);
-		SET_TX_DESC_DATA_SC(txdesc, 0);
+		set_tx_desc_data_bw(txdesc, 0);
+		set_tx_desc_data_sc(txdesc, 0);
 	}
 	rcu_read_lock();
 	sta = ieee80211_find_sta(mac->vif, mac->bssid);
 	if (sta) {
 		u8 ampdu_density = sta->ht_cap.ampdu_density;
 
-		SET_TX_DESC_AMPDU_DENSITY(txdesc, ampdu_density);
+		set_tx_desc_ampdu_density(txdesc, ampdu_density);
 	}
 	rcu_read_unlock();
 	if (info->control.hw_key) {
@@ -547,49 +549,49 @@ void rtl92cu_tx_fill_desc(struct ieee80211_hw *hw,
 		case WLAN_CIPHER_SUITE_WEP40:
 		case WLAN_CIPHER_SUITE_WEP104:
 		case WLAN_CIPHER_SUITE_TKIP:
-			SET_TX_DESC_SEC_TYPE(txdesc, 0x1);
+			set_tx_desc_sec_type(txdesc, 0x1);
 			break;
 		case WLAN_CIPHER_SUITE_CCMP:
-			SET_TX_DESC_SEC_TYPE(txdesc, 0x3);
+			set_tx_desc_sec_type(txdesc, 0x3);
 			break;
 		default:
-			SET_TX_DESC_SEC_TYPE(txdesc, 0x0);
+			set_tx_desc_sec_type(txdesc, 0x0);
 			break;
 		}
 	}
-	SET_TX_DESC_PKT_ID(txdesc, 0);
-	SET_TX_DESC_QUEUE_SEL(txdesc, fw_qsel);
-	SET_TX_DESC_DATA_RATE_FB_LIMIT(txdesc, 0x1F);
-	SET_TX_DESC_RTS_RATE_FB_LIMIT(txdesc, 0xF);
-	SET_TX_DESC_DISABLE_FB(txdesc, 0);
-	SET_TX_DESC_USE_RATE(txdesc, tcb_desc->use_driver_rate ? 1 : 0);
+	set_tx_desc_pkt_id(txdesc, 0);
+	set_tx_desc_queue_sel(txdesc, fw_qsel);
+	set_tx_desc_data_rate_fb_limit(txdesc, 0x1F);
+	set_tx_desc_rts_rate_fb_limit(txdesc, 0xF);
+	set_tx_desc_disable_fb(txdesc, 0);
+	set_tx_desc_use_rate(txdesc, tcb_desc->use_driver_rate ? 1 : 0);
 	if (ieee80211_is_data_qos(fc)) {
 		if (mac->rdg_en) {
 			RT_TRACE(rtlpriv, COMP_SEND, DBG_TRACE,
 				 "Enable RDG function\n");
-			SET_TX_DESC_RDG_ENABLE(txdesc, 1);
-			SET_TX_DESC_HTC(txdesc, 1);
+			set_tx_desc_rdg_enable(txdesc, 1);
+			set_tx_desc_htc(txdesc, 1);
 		}
 	}
 	if (rtlpriv->dm.useramask) {
-		SET_TX_DESC_RATE_ID(txdesc, tcb_desc->ratr_index);
-		SET_TX_DESC_MACID(txdesc, tcb_desc->mac_id);
+		set_tx_desc_rate_id(txdesc, tcb_desc->ratr_index);
+		set_tx_desc_macid(txdesc, tcb_desc->mac_id);
 	} else {
-		SET_TX_DESC_RATE_ID(txdesc, 0xC + tcb_desc->ratr_index);
-		SET_TX_DESC_MACID(txdesc, tcb_desc->ratr_index);
+		set_tx_desc_rate_id(txdesc, 0xC + tcb_desc->ratr_index);
+		set_tx_desc_macid(txdesc, tcb_desc->ratr_index);
 	}
 	if ((!ieee80211_is_data_qos(fc)) && ppsc->leisure_ps &&
 	      ppsc->fwctrl_lps) {
-		SET_TX_DESC_HWSEQ_EN(txdesc, 1);
-		SET_TX_DESC_PKT_ID(txdesc, 8);
+		set_tx_desc_hwseq_en(txdesc, 1);
+		set_tx_desc_pkt_id(txdesc, 8);
 		if (!defaultadapter)
-			SET_TX_DESC_QOS(txdesc, 1);
+			set_tx_desc_qos(txdesc, 1);
 	}
 	if (ieee80211_has_morefrags(fc))
-		SET_TX_DESC_MORE_FRAG(txdesc, 1);
+		set_tx_desc_more_frag(txdesc, 1);
 	if (is_multicast_ether_addr(ieee80211_get_DA(hdr)) ||
 	    is_broadcast_ether_addr(ieee80211_get_DA(hdr)))
-		SET_TX_DESC_BMC(txdesc, 1);
+		set_tx_desc_bmc(txdesc, 1);
 	_rtl_fill_usb_tx_desc(txdesc);
 	_rtl_tx_desc_checksum(txdesc);
 	RT_TRACE(rtlpriv, COMP_SEND, DBG_TRACE, "==>\n");
@@ -600,22 +602,22 @@ void rtl92cu_fill_fake_txdesc(struct ieee80211_hw *hw, u8 *pdesc,
 {
 	/* Clear all status */
 	memset(pdesc, 0, RTL_TX_HEADER_SIZE);
-	SET_TX_DESC_FIRST_SEG(pdesc, 1); /* bFirstSeg; */
-	SET_TX_DESC_LAST_SEG(pdesc, 1); /* bLastSeg; */
-	SET_TX_DESC_OFFSET(pdesc, RTL_TX_HEADER_SIZE); /* Offset = 32 */
-	SET_TX_DESC_PKT_SIZE(pdesc, buffer_len); /* Buffer size + command hdr */
-	SET_TX_DESC_QUEUE_SEL(pdesc, QSLT_MGNT); /* Fixed queue of Mgnt queue */
+	set_tx_desc_first_seg(pdesc, 1); /* bFirstSeg; */
+	set_tx_desc_last_seg(pdesc, 1); /* bLastSeg; */
+	set_tx_desc_offset(pdesc, RTL_TX_HEADER_SIZE); /* Offset = 32 */
+	set_tx_desc_pkt_size(pdesc, buffer_len); /* Buffer size + command hdr */
+	set_tx_desc_queue_sel(pdesc, QSLT_MGNT); /* Fixed queue of Mgnt queue */
 	/* Set NAVUSEHDR to prevent Ps-poll AId filed to be changed to error
 	 * vlaue by Hw. */
 	if (is_pspoll) {
-		SET_TX_DESC_NAV_USE_HDR(pdesc, 1);
+		set_tx_desc_nav_use_hdr(pdesc, 1);
 	} else {
-		SET_TX_DESC_HWSEQ_EN(pdesc, 1); /* Hw set sequence number */
-		SET_TX_DESC_PKT_ID(pdesc, BIT(3)); /* set bit3 to 1. */
+		set_tx_desc_hwseq_en(pdesc, 1); /* Hw set sequence number */
+		set_tx_desc_pkt_id(pdesc, BIT(3)); /* set bit3 to 1. */
 	}
-	SET_TX_DESC_USE_RATE(pdesc, 1); /* use data rate which is set by Sw */
-	SET_TX_DESC_OWN(pdesc, 1);
-	SET_TX_DESC_TX_RATE(pdesc, DESC_RATE1M);
+	set_tx_desc_use_rate(pdesc, 1); /* use data rate which is set by Sw */
+	set_tx_desc_own(pdesc, 1);
+	set_tx_desc_tx_rate(pdesc, DESC_RATE1M);
 	_rtl_tx_desc_checksum(pdesc);
 }
 
@@ -630,24 +632,24 @@ void rtl92cu_tx_fill_cmddesc(struct ieee80211_hw *hw,
 
 	memset((void *)pdesc, 0, RTL_TX_HEADER_SIZE);
 	if (firstseg)
-		SET_TX_DESC_OFFSET(pdesc, RTL_TX_HEADER_SIZE);
-	SET_TX_DESC_TX_RATE(pdesc, DESC_RATE1M);
-	SET_TX_DESC_SEQ(pdesc, 0);
-	SET_TX_DESC_LINIP(pdesc, 0);
-	SET_TX_DESC_QUEUE_SEL(pdesc, fw_queue);
-	SET_TX_DESC_FIRST_SEG(pdesc, 1);
-	SET_TX_DESC_LAST_SEG(pdesc, 1);
-	SET_TX_DESC_RATE_ID(pdesc, 7);
-	SET_TX_DESC_MACID(pdesc, 0);
-	SET_TX_DESC_OWN(pdesc, 1);
-	SET_TX_DESC_PKT_SIZE(pdesc, (u16)skb->len);
-	SET_TX_DESC_FIRST_SEG(pdesc, 1);
-	SET_TX_DESC_LAST_SEG(pdesc, 1);
-	SET_TX_DESC_OFFSET(pdesc, 0x20);
-	SET_TX_DESC_USE_RATE(pdesc, 1);
+		set_tx_desc_offset(pdesc, RTL_TX_HEADER_SIZE);
+	set_tx_desc_tx_rate(pdesc, DESC_RATE1M);
+	set_tx_desc_seq(pdesc, 0);
+	set_tx_desc_linip(pdesc, 0);
+	set_tx_desc_queue_sel(pdesc, fw_queue);
+	set_tx_desc_first_seg(pdesc, 1);
+	set_tx_desc_last_seg(pdesc, 1);
+	set_tx_desc_rate_id(pdesc, 7);
+	set_tx_desc_macid(pdesc, 0);
+	set_tx_desc_own(pdesc, 1);
+	set_tx_desc_pkt_size(pdesc, (u16)skb->len);
+	set_tx_desc_first_seg(pdesc, 1);
+	set_tx_desc_last_seg(pdesc, 1);
+	set_tx_desc_offset(pdesc, 0x20);
+	set_tx_desc_use_rate(pdesc, 1);
 	if (!ieee80211_is_data_qos(fc)) {
-		SET_TX_DESC_HWSEQ_EN(pdesc, 1);
-		SET_TX_DESC_PKT_ID(pdesc, 8);
+		set_tx_desc_hwseq_en(pdesc, 1);
+		set_tx_desc_pkt_id(pdesc, 8);
 	}
 	RT_PRINT_DATA(rtlpriv, COMP_CMD, DBG_LOUD, "H2C Tx Cmd Content",
 		      pdesc, RTL_TX_DESC_SIZE);
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.h b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.h
index 916fa0e98123..3d8a913d799d 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.h
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.h
@@ -73,142 +73,307 @@ struct rx_drv_info_92c {
 /* macros to read various fields in RX descriptor */
 
 /* DWORD 0 */
-#define GET_RX_DESC_PKT_LEN(__rxdesc)		\
-	le32_get_bits(*(__le32 *)__rxdesc, GENMASK(13, 0))
-#define GET_RX_DESC_CRC32(__rxdesc)		\
-	le32_get_bits(*(__le32 *)__rxdesc, BIT(14))
-#define GET_RX_DESC_ICV(__rxdesc)		\
-	le32_get_bits(*(__le32 *)__rxdesc, BIT(15))
-#define GET_RX_DESC_DRVINFO_SIZE(__rxdesc)	\
-	le32_get_bits(*(__le32 *)__rxdesc, GENMASK(19, 16))
-#define GET_RX_DESC_SHIFT(__rxdesc)		\
-	le32_get_bits(*(__le32 *)__rxdesc, GENMASK(25, 24))
-#define GET_RX_DESC_PHY_STATUS(__rxdesc)	\
-	le32_get_bits(*(__le32 *)__rxdesc, BIT(26))
-#define GET_RX_DESC_SWDEC(__rxdesc)		\
-	le32_get_bits(*(__le32 *)__rxdesc, BIT(27))
+static inline u32 get_rx_desc_pkt_len(u8 *__rxdesc)
+{
+	return le32_get_bits(*(__le32 *)__rxdesc, GENMASK(13, 0));
+}
+
+static inline u32 get_rx_desc_crc32(u8 *__rxdesc)
+{
+	return le32_get_bits(*(__le32 *)__rxdesc, BIT(14));
+}
+
+static inline u32 get_rx_desc_icv(u8 *__rxdesc)
+{
+	return le32_get_bits(*(__le32 *)__rxdesc, BIT(15));
+}
+
+static inline u32 get_rx_desc_drvinfo_size(u8 *__rxdesc)
+{
+	return le32_get_bits(*(__le32 *)__rxdesc, GENMASK(19, 16));
+}
+
+static inline u32 get_rx_desc_shift(u8 *__rxdesc)
+{
+	return le32_get_bits(*(__le32 *)__rxdesc, GENMASK(25, 24));
+}
+
+static inline u32 get_rx_desc_phy_status(u8 *__rxdesc)
+{
+	return le32_get_bits(*(__le32 *)__rxdesc, BIT(26));
+}
+
+static inline u32 get_rx_desc_swdec(u8 *__rxdesc)
+{
+	return le32_get_bits(*(__le32 *)__rxdesc, BIT(27));
+}
+
 
 /* DWORD 1 */
-#define GET_RX_DESC_PAGGR(__rxdesc)		\
-	le32_get_bits(*(__le32 *)(__rxdesc + 4), BIT(14))
-#define GET_RX_DESC_FAGGR(__rxdesc)		\
-	le32_get_bits(*(__le32 *)(__rxdesc + 4), BIT(15))
+static inline u32 get_rx_desc_paggr(u8 *__rxdesc)
+{
+	return le32_get_bits(*(__le32 *)(__rxdesc + 4), BIT(14));
+}
+
+static inline u32 get_rx_desc_faggr(u8 *__rxdesc)
+{
+	return le32_get_bits(*(__le32 *)(__rxdesc + 4), BIT(15));
+}
+
 
 /* DWORD 3 */
-#define GET_RX_DESC_RX_MCS(__rxdesc)		\
-	le32_get_bits(*(__le32 *)(__rxdesc + 12), GENMASK(5, 0))
-#define GET_RX_DESC_RX_HT(__rxdesc)            \
-	le32_get_bits(*(__le32 *)(__rxdesc + 12), BIT(6))
-#define GET_RX_DESC_SPLCP(__rxdesc)            \
-	le32_get_bits(*(__le32 *)(__rxdesc + 12), BIT(8))
-#define GET_RX_DESC_BW(__rxdesc)               \
-	le32_get_bits(*(__le32 *)(__rxdesc + 12), BIT(9))
+static inline u32 get_rx_desc_rx_mcs(u8 *__rxdesc)
+{
+	return le32_get_bits(*(__le32 *)(__rxdesc + 12), GENMASK(5, 0));
+}
+
+static inline u32 get_rx_desc_rx_ht(u8 *__rxdesc)
+{
+	return le32_get_bits(*(__le32 *)(__rxdesc + 12), BIT(6));
+}
+
+static inline u32 get_rx_desc_splcp(u8 *__rxdesc)
+{
+	return le32_get_bits(*(__le32 *)(__rxdesc + 12), BIT(8));
+}
+
+static inline u32 get_rx_desc_bw(u8 *__rxdesc)
+{
+	return le32_get_bits(*(__le32 *)(__rxdesc + 12), BIT(9));
+}
+
 
 /* DWORD 5 */
-#define GET_RX_DESC_TSFL(__rxdesc)		\
-	le32_to_cpu(*((__le32 *)(__rxdesc + 20)))
+static inline u32 get_rx_desc_tsfl(u8 *__rxdesc)
+{
+	return le32_to_cpu(*((__le32 *)(__rxdesc + 20)));
+}
+
 
 /*======================= tx desc ============================================*/
 
 /* macros to set various fields in TX descriptor */
 
 /* Dword 0 */
-#define SET_TX_DESC_PKT_SIZE(__txdesc, __value)		\
-	le32p_replace_bits((__le32 *)__txdesc, __value, GENMASK(15, 0))
-#define SET_TX_DESC_OFFSET(__txdesc, __value)		\
-	le32p_replace_bits((__le32 *)__txdesc, __value, GENMASK(23, 16))
-#define SET_TX_DESC_BMC(__txdesc, __value)		\
-	le32p_replace_bits((__le32 *)__txdesc, __value, BIT(24))
-#define SET_TX_DESC_HTC(__txdesc, __value)		\
-	le32p_replace_bits((__le32 *)__txdesc, __value, BIT(25))
-#define SET_TX_DESC_LAST_SEG(__txdesc, __value)		\
-	le32p_replace_bits((__le32 *)__txdesc, __value, BIT(26))
-#define SET_TX_DESC_FIRST_SEG(__txdesc, __value)	\
-	le32p_replace_bits((__le32 *)__txdesc, __value, BIT(27))
-#define SET_TX_DESC_LINIP(__txdesc, __value)		\
-	le32p_replace_bits((__le32 *)__txdesc, __value, BIT(28))
-#define SET_TX_DESC_OWN(__txdesc, __value)		\
-	le32p_replace_bits((__le32 *)__txdesc, __value, BIT(31))
+static inline void set_tx_desc_pkt_size(u8 *__txdesc, u32 __value)
+{
+	le32p_replace_bits((__le32 *)__txdesc, __value, GENMASK(15, 0));
+}
+
+static inline void set_tx_desc_offset(u8 *__txdesc, u32 __value)
+{
+	le32p_replace_bits((__le32 *)__txdesc, __value, GENMASK(23, 16));
+}
+
+static inline void set_tx_desc_bmc(u8 *__txdesc, u32 __value)
+{
+	le32p_replace_bits((__le32 *)__txdesc, __value, BIT(24));
+}
+
+static inline void set_tx_desc_htc(u8 *__txdesc, u32 __value)
+{
+	le32p_replace_bits((__le32 *)__txdesc, __value, BIT(25));
+}
+
+static inline void set_tx_desc_last_seg(u8 *__txdesc, u32 __value)
+{
+	le32p_replace_bits((__le32 *)__txdesc, __value, BIT(26));
+}
+
+static inline void set_tx_desc_first_seg(u8 *__txdesc, u32 __value)
+{
+	le32p_replace_bits((__le32 *)__txdesc, __value, BIT(27));
+}
+
+static inline void set_tx_desc_linip(u8 *__txdesc, u32 __value)
+{
+	le32p_replace_bits((__le32 *)__txdesc, __value, BIT(28));
+}
+
+static inline void set_tx_desc_own(u8 *__txdesc, u32 __value)
+{
+	le32p_replace_bits((__le32 *)__txdesc, __value, BIT(31));
+}
+
 
 /* Dword 1 */
-#define SET_TX_DESC_MACID(__txdesc, __value)		\
-	le32p_replace_bits((__le32 *)(__txdesc + 4), __value, GENMASK(4, 0))
-#define SET_TX_DESC_AGG_ENABLE(__txdesc, __value)	\
-	le32p_replace_bits((__le32 *)(__txdesc + 4), __value, BIT(5))
-#define SET_TX_DESC_AGG_BREAK(__txdesc, __value)	\
-	le32p_replace_bits((__le32 *)(__txdesc + 4), __value, BIT(6))
-#define SET_TX_DESC_RDG_ENABLE(__txdesc, __value)	\
-	le32p_replace_bits((__le32 *)(__txdesc + 4), __value, BIT(7))
-#define SET_TX_DESC_QUEUE_SEL(__txdesc, __value)	\
-	le32p_replace_bits((__le32 *)(__txdesc + 4), __value, GENMASK(12, 8))
-#define SET_TX_DESC_RATE_ID(__txdesc, __value)		\
-	le32p_replace_bits((__le32 *)(__txdesc + 4), __value, GENMASK(19, 16))
-#define SET_TX_DESC_NAV_USE_HDR(__txdesc, __value)	\
-	le32p_replace_bits((__le32 *)(__txdesc + 4), __value, BIT(20))
-#define SET_TX_DESC_SEC_TYPE(__txdesc, __value)		\
-	le32p_replace_bits((__le32 *)(__txdesc + 4), __value, GENMASK(23, 22))
-#define SET_TX_DESC_PKT_OFFSET(__txdesc, __value)	\
-	le32p_replace_bits((__le32 *)(__txdesc + 4), __value, GENMASK(30, 26))
+static inline void set_tx_desc_macid(u8 *__txdesc, u32 __value)
+{
+	le32p_replace_bits((__le32 *)(__txdesc + 4), __value, GENMASK(4, 0));
+}
+
+static inline void set_tx_desc_agg_enable(u8 *__txdesc, u32 __value)
+{
+	le32p_replace_bits((__le32 *)(__txdesc + 4), __value, BIT(5));
+}
+
+static inline void set_tx_desc_agg_break(u8 *__txdesc, u32 __value)
+{
+	le32p_replace_bits((__le32 *)(__txdesc + 4), __value, BIT(6));
+}
+
+static inline void set_tx_desc_rdg_enable(u8 *__txdesc, u32 __value)
+{
+	le32p_replace_bits((__le32 *)(__txdesc + 4), __value, BIT(7));
+}
+
+static inline void set_tx_desc_queue_sel(u8 *__txdesc, u32 __value)
+{
+	le32p_replace_bits((__le32 *)(__txdesc + 4), __value, GENMASK(12, 8));
+}
+
+static inline void set_tx_desc_rate_id(u8 *__txdesc, u32 __value)
+{
+	le32p_replace_bits((__le32 *)(__txdesc + 4), __value, GENMASK(19, 16));
+}
+
+static inline void set_tx_desc_nav_use_hdr(u8 *__txdesc, u32 __value)
+{
+	le32p_replace_bits((__le32 *)(__txdesc + 4), __value, BIT(20));
+}
+
+static inline void set_tx_desc_sec_type(u8 *__txdesc, u32 __value)
+{
+	le32p_replace_bits((__le32 *)(__txdesc + 4), __value, GENMASK(23, 22));
+}
+
+static inline void set_tx_desc_pkt_offset(u8 *__txdesc, u32 __value)
+{
+	le32p_replace_bits((__le32 *)(__txdesc + 4), __value, GENMASK(30, 26));
+}
+
 
 /* Dword 2 */
-#define SET_TX_DESC_MORE_FRAG(__txdesc, __value)	\
-	le32p_replace_bits((__le32 *)(__txdesc + 8), __value, BIT(17))
-#define SET_TX_DESC_AMPDU_DENSITY(__txdesc, __value)	\
-	le32p_replace_bits((__le32 *)(__txdesc + 8), __value, GENMASK(22, 20))
+static inline void set_tx_desc_more_frag(u8 *__txdesc, u32 __value)
+{
+	le32p_replace_bits((__le32 *)(__txdesc + 8), __value, BIT(17));
+}
+
+static inline void set_tx_desc_ampdu_density(u8 *__txdesc, u32 __value)
+{
+	le32p_replace_bits((__le32 *)(__txdesc + 8), __value, GENMASK(22, 20));
+}
+
 
 /* Dword 3 */
-#define SET_TX_DESC_SEQ(__txdesc, __value)		\
-	le32p_replace_bits((__le32 *)(__txdesc + 12), __value, GENMASK(27, 16))
-#define SET_TX_DESC_PKT_ID(__txdesc, __value)		\
-	le32p_replace_bits((__le32 *)(__txdesc + 12), __value, GENMASK(31, 28))
+static inline void set_tx_desc_seq(u8 *__txdesc, u32 __value)
+{
+	le32p_replace_bits((__le32 *)(__txdesc + 12), __value, GENMASK(27, 16));
+}
+
+static inline void set_tx_desc_pkt_id(u8 *__txdesc, u32 __value)
+{
+	le32p_replace_bits((__le32 *)(__txdesc + 12), __value, GENMASK(31, 28));
+}
+
 
 /* Dword 4 */
-#define SET_TX_DESC_RTS_RATE(__txdesc, __value)		\
-	le32p_replace_bits((__le32 *)(__txdesc + 16), __value, GENMASK(4, 0))
-#define SET_TX_DESC_QOS(__txdesc, __value)		\
-	le32p_replace_bits((__le32 *)(__txdesc + 16), __value, BIT(6))
-#define SET_TX_DESC_HWSEQ_EN(__txdesc, __value)		\
-	le32p_replace_bits((__le32 *)(__txdesc + 16), __value, BIT(7))
-#define SET_TX_DESC_USE_RATE(__txdesc, __value)		\
-	le32p_replace_bits((__le32 *)(__txdesc + 16), __value, BIT(8))
-#define SET_TX_DESC_DISABLE_FB(__txdesc, __value)	\
-	le32p_replace_bits((__le32 *)(__txdesc + 16), __value, BIT(10))
-#define SET_TX_DESC_CTS2SELF(__txdesc, __value)		\
-	le32p_replace_bits((__le32 *)(__txdesc + 16), __value, BIT(11))
-#define SET_TX_DESC_RTS_ENABLE(__txdesc, __value)	\
-	le32p_replace_bits((__le32 *)(__txdesc + 16), __value, BIT(12))
-#define SET_TX_DESC_HW_RTS_ENABLE(__txdesc, __value)	\
-	le32p_replace_bits((__le32 *)(__txdesc + 16), __value, BIT(13))
-#define SET_TX_DESC_DATA_SC(__txdesc, __value)		\
-	le32p_replace_bits((__le32 *)(__txdesc + 16), __value, GENMASK(21, 20))
-#define SET_TX_DESC_DATA_BW(__txdesc, __value)		\
-	le32p_replace_bits((__le32 *)(__txdesc + 16), __value, BIT(25))
-#define SET_TX_DESC_RTS_SHORT(__txdesc, __value)	\
-	le32p_replace_bits((__le32 *)(__txdesc + 16), __value, BIT(26))
-#define SET_TX_DESC_RTS_BW(__txdesc, __value)		\
-	le32p_replace_bits((__le32 *)(__txdesc + 16), __value, BIT(27))
-#define SET_TX_DESC_RTS_SC(__txdesc, __value)		\
-	le32p_replace_bits((__le32 *)(__txdesc + 16), __value, GENMASK(29, 28))
-#define SET_TX_DESC_RTS_STBC(__txdesc, __value)		\
-	le32p_replace_bits((__le32 *)(__txdesc + 16), __value, GENMASK(31, 30))
+static inline void set_tx_desc_rts_rate(u8 *__txdesc, u32 __value)
+{
+	le32p_replace_bits((__le32 *)(__txdesc + 16), __value, GENMASK(4, 0));
+}
+
+static inline void set_tx_desc_qos(u8 *__txdesc, u32 __value)
+{
+	le32p_replace_bits((__le32 *)(__txdesc + 16), __value, BIT(6));
+}
+
+static inline void set_tx_desc_hwseq_en(u8 *__txdesc, u32 __value)
+{
+	le32p_replace_bits((__le32 *)(__txdesc + 16), __value, BIT(7));
+}
+
+static inline void set_tx_desc_use_rate(u8 *__txdesc, u32 __value)
+{
+	le32p_replace_bits((__le32 *)(__txdesc + 16), __value, BIT(8));
+}
+
+static inline void set_tx_desc_disable_fb(u8 *__txdesc, u32 __value)
+{
+	le32p_replace_bits((__le32 *)(__txdesc + 16), __value, BIT(10));
+}
+
+static inline void set_tx_desc_cts2self(u8 *__txdesc, u32 __value)
+{
+	le32p_replace_bits((__le32 *)(__txdesc + 16), __value, BIT(11));
+}
+
+static inline void set_tx_desc_rts_enable(u8 *__txdesc, u32 __value)
+{
+	le32p_replace_bits((__le32 *)(__txdesc + 16), __value, BIT(12));
+}
+
+static inline void set_tx_desc_hw_rts_enable(u8 *__txdesc, u32 __value)
+{
+	le32p_replace_bits((__le32 *)(__txdesc + 16), __value, BIT(13));
+}
+
+static inline void set_tx_desc_data_sc(u8 *__txdesc, u32 __value)
+{
+	le32p_replace_bits((__le32 *)(__txdesc + 16), __value, GENMASK(21, 20));
+}
+
+static inline void set_tx_desc_data_bw(u8 *__txdesc, u32 __value)
+{
+	le32p_replace_bits((__le32 *)(__txdesc + 16), __value, BIT(25));
+}
+
+static inline void set_tx_desc_rts_short(u8 *__txdesc, u32 __value)
+{
+	le32p_replace_bits((__le32 *)(__txdesc + 16), __value, BIT(26));
+}
+
+static inline void set_tx_desc_rts_bw(u8 *__txdesc, u32 __value)
+{
+	le32p_replace_bits((__le32 *)(__txdesc + 16), __value, BIT(27));
+}
+
+static inline void set_tx_desc_rts_sc(u8 *__txdesc, u32 __value)
+{
+	le32p_replace_bits((__le32 *)(__txdesc + 16), __value, GENMASK(29, 28));
+}
+
+static inline void set_tx_desc_rts_stbc(u8 *__txdesc, u32 __value)
+{
+	le32p_replace_bits((__le32 *)(__txdesc + 16), __value, GENMASK(31, 30));
+}
+
 
 /* Dword 5 */
-#define SET_TX_DESC_TX_RATE(__pdesc, __val)		\
-	le32p_replace_bits((__le32 *)(__pdesc + 20), __val, GENMASK(5, 0))
-#define SET_TX_DESC_DATA_SHORTGI(__pdesc, __val)	\
-	le32p_replace_bits((__le32 *)(__pdesc + 20), __val, BIT(6))
-#define SET_TX_DESC_DATA_RATE_FB_LIMIT(__txdesc, __value) \
-	le32p_replace_bits((__le32 *)(__txdesc + 20), __value, GENMASK(12, 8))
-#define SET_TX_DESC_RTS_RATE_FB_LIMIT(__txdesc, __value) \
-	le32p_replace_bits((__le32 *)(__txdesc + 20), __value, GENMASK(16, 13))
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
+static inline void set_tx_desc_data_rate_fb_limit(u8 *__txdesc, u32 __value)
+{
+	le32p_replace_bits((__le32 *)(__txdesc + 20), __value, GENMASK(12, 8));
+}
+
+static inline void set_tx_desc_rts_rate_fb_limit(u8 *__txdesc, u32 __value)
+{
+	le32p_replace_bits((__le32 *)(__txdesc + 20), __value, GENMASK(16, 13));
+}
+
 
 /* Dword 6 */
-#define SET_TX_DESC_MAX_AGG_NUM(__txdesc, __value)	\
-	le32p_replace_bits((__le32 *)(__txdesc + 24), __value, GENMASK(15, 11))
+static inline void set_tx_desc_max_agg_num(u8 *__txdesc, u32 __value)
+{
+	le32p_replace_bits((__le32 *)(__txdesc + 24), __value, GENMASK(15, 11));
+}
+
 
 /* Dword 7 */
-#define SET_TX_DESC_TX_DESC_CHECKSUM(__txdesc, __value) \
-	le32p_replace_bits((__le32 *)(__txdesc + 28), __value, GENMASK(15, 0))
+static inline void set_tx_desc_tx_desc_checksum(u8 *__txdesc, u32 __value)
+{
+	le32p_replace_bits((__le32 *)(__txdesc + 28), __value, GENMASK(15, 0));
+}
+
 
 int  rtl8192cu_endpoint_mapping(struct ieee80211_hw *hw);
 u16 rtl8192cu_mq_to_hwq(__le16 fc, u16 mac80211_queue_index);
-- 
2.16.4

