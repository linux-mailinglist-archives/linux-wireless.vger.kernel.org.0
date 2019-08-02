Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5BA17E770
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Aug 2019 03:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390632AbfHBBVN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 1 Aug 2019 21:21:13 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:45427 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730767AbfHBBVN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 1 Aug 2019 21:21:13 -0400
Received: by mail-oi1-f194.google.com with SMTP id m206so55577449oib.12
        for <linux-wireless@vger.kernel.org>; Thu, 01 Aug 2019 18:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oRTFxZs/rHIYPgv0LRYAXyBnoakvMujbsdTXgdd9E6g=;
        b=JYJIEE3xjE6aYQQRyqpEPvublAhdKl3cBvYvp/3CTCZMjNCLjj9m2meX4AGkY7EOjW
         q0Irz6W98LtJxWiDlnnX4CJJLQKiUQQ8Zz9d4iNaWMtXkGVpzOQ6EfADF9c7+8Xr+DWV
         PtiqZgGLMmcTP7vPnY0IvynQ5++fiqZkqSLs/Dg2XzYpnpKkKPOwnn3sHIZ7hz+1Iu+W
         3gbAI2zgyw4TzhEHgOWOCjpVK7xYR0bV5aDsTS8crhmZtw5mqrmkhBy+nrrnMnoMu0fv
         Om03Z2HFOqJXVzt/gcA+BPR6xMLjA2RQ9kLuK6BsKMqejF9KU9T/U5QRScFt/Ewt3mGN
         AptA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=oRTFxZs/rHIYPgv0LRYAXyBnoakvMujbsdTXgdd9E6g=;
        b=VXy6eVFIzKGuY9r3EoxcgFK8gKRvRE7RG2yy35ibp+G5VfdZaSC00E2PyxnWnusXKL
         +5HOVNJUdrtcAFcXTeZErfQTQKR6OsVhXqUE93f94ETq4Dq6DMzHoZqu3nDD9X1r19Av
         n5VeYiPf20YFLeK4gpejAdt2fc9mfMfFw2gRduV2igKmFqbviJVtQB/sGlRjxmWepP3J
         phITWeIzjl1PrWo+mPsXqG/k4gjBEqCJHjZyE7BvSljaKemM2q0ZGcWJW9AtMQ6dGUsH
         JdY4M53d19FIHI7NKHFGcnpOh+OQTq8ZJUxEYCDGQBRurxqwLBrfV6F99wrqDyerRaAO
         Wtvw==
X-Gm-Message-State: APjAAAX4xGC44C3gPSr40iUNLzwjvPFkpdjAIu5Tq4qvA8b98m/yzLCY
        xf/XD9F+FHtxqpRavIqOxOg=
X-Google-Smtp-Source: APXvYqxjEC2i71pIKpQvd6PR5ddS8ld1tnMHaMOiaAFAu3qBxIUFj1TwkvFpxPUTtriQEBiCTo76dg==
X-Received: by 2002:aca:c48b:: with SMTP id u133mr1045696oif.95.1564708870322;
        Thu, 01 Aug 2019 18:21:10 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id c64sm28112162otb.79.2019.08.01.18.21.08
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 18:21:08 -0700 (PDT)
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, pkshih@realtek.com,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH 3/4] rtlwifi: rtl8192ce: Convert macros that set descriptor
Date:   Thu,  1 Aug 2019 20:21:01 -0500
Message-Id: <20190802012102.7945-4-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190802012102.7945-1-Larry.Finger@lwfinger.net>
References: <20190802012102.7945-1-Larry.Finger@lwfinger.net>
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
are fixed.

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
---
 .../wireless/realtek/rtlwifi/rtl8192ce/trx.c  | 192 ++++----
 .../wireless/realtek/rtlwifi/rtl8192ce/trx.h  | 451 ++++++++++++------
 2 files changed, 405 insertions(+), 238 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192ce/trx.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192ce/trx.c
index 18a0ab59631a..7bff0825b264 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192ce/trx.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192ce/trx.c
@@ -251,8 +251,8 @@ static void _rtl92ce_query_rxphystatus(struct ieee80211_hw *hw,
 				 */
 				if (i == 0)
 					pstats->signalquality =
-					    (u8) (evm & 0xff);
-				pstats->rx_mimo_sig_qual[i] = (u8) (evm & 0xff);
+					    (u8)(evm & 0xff);
+				pstats->rx_mimo_sig_qual[i] = (u8)(evm & 0xff);
 			}
 		}
 	}
@@ -262,10 +262,10 @@ static void _rtl92ce_query_rxphystatus(struct ieee80211_hw *hw,
 	 */
 	if (is_cck_rate)
 		pstats->signalstrength =
-		    (u8) (_rtl92ce_signal_scale_mapping(hw, pwdb_all));
+		    (u8)(_rtl92ce_signal_scale_mapping(hw, pwdb_all));
 	else if (rf_rx_num != 0)
 		pstats->signalstrength =
-		    (u8) (_rtl92ce_signal_scale_mapping
+		    (u8)(_rtl92ce_signal_scale_mapping
 			  (hw, total_rssi /= rf_rx_num));
 }
 
@@ -322,24 +322,24 @@ bool rtl92ce_rx_query_desc(struct ieee80211_hw *hw,
 	struct rx_fwinfo_92c *p_drvinfo;
 	struct rx_desc_92c *pdesc = (struct rx_desc_92c *)p_desc;
 	struct ieee80211_hdr *hdr;
-	u32 phystatus = GET_RX_DESC_PHYST(pdesc);
+	u32 phystatus = get_rx_desc_physt(p_desc);
 
-	stats->length = (u16) GET_RX_DESC_PKT_LEN(pdesc);
-	stats->rx_drvinfo_size = (u8) GET_RX_DESC_DRV_INFO_SIZE(pdesc) *
+	stats->length = (u16)get_rx_desc_pkt_len(p_desc);
+	stats->rx_drvinfo_size = (u8)get_rx_desc_drv_info_size(p_desc) *
 	    RX_DRV_INFO_SIZE_UNIT;
-	stats->rx_bufshift = (u8) (GET_RX_DESC_SHIFT(pdesc) & 0x03);
-	stats->icv = (u16) GET_RX_DESC_ICV(pdesc);
-	stats->crc = (u16) GET_RX_DESC_CRC32(pdesc);
+	stats->rx_bufshift = (u8)(get_rx_desc_shift(p_desc) & 0x03);
+	stats->icv = (u16)get_rx_desc_icv(p_desc);
+	stats->crc = (u16)get_rx_desc_crc32(p_desc);
 	stats->hwerror = (stats->crc | stats->icv);
-	stats->decrypted = !GET_RX_DESC_SWDEC(pdesc);
-	stats->rate = (u8) GET_RX_DESC_RXMCS(pdesc);
-	stats->shortpreamble = (u16) GET_RX_DESC_SPLCP(pdesc);
-	stats->isampdu = (bool) (GET_RX_DESC_PAGGR(pdesc) == 1);
-	stats->isfirst_ampdu = (bool) ((GET_RX_DESC_PAGGR(pdesc) == 1)
-				   && (GET_RX_DESC_FAGGR(pdesc) == 1));
-	stats->timestamp_low = GET_RX_DESC_TSFL(pdesc);
-	stats->rx_is40mhzpacket = (bool)GET_RX_DESC_BW(pdesc);
-	stats->is_ht = (bool)GET_RX_DESC_RXHT(pdesc);
+	stats->decrypted = !get_rx_desc_swdec(p_desc);
+	stats->rate = (u8)get_rx_desc_rxmcs(p_desc);
+	stats->shortpreamble = (u16)get_rx_desc_splcp(p_desc);
+	stats->isampdu = (bool)(get_rx_desc_paggr(p_desc) == 1);
+	stats->isfirst_ampdu = (bool)((get_rx_desc_paggr(p_desc) == 1) &&
+				      (get_rx_desc_faggr(p_desc) == 1));
+	stats->timestamp_low = get_rx_desc_tsfl(p_desc);
+	stats->rx_is40mhzpacket = (bool)get_rx_desc_bw(p_desc);
+	stats->is_ht = (bool)get_rx_desc_rxht(p_desc);
 
 	stats->is_cck = RX_HAL_IS_CCK_RATE(pdesc->rxmcs);
 
@@ -454,57 +454,57 @@ void rtl92ce_tx_fill_desc(struct ieee80211_hw *hw,
 		lastseg = true;
 	}
 	if (firstseg) {
-		SET_TX_DESC_OFFSET(pdesc, USB_HWDESC_HEADER_LEN);
+		set_tx_desc_offset(pdesc, USB_HWDESC_HEADER_LEN);
 
-		SET_TX_DESC_TX_RATE(pdesc, tcb_desc->hw_rate);
+		set_tx_desc_tx_rate(pdesc, tcb_desc->hw_rate);
 
 		if (tcb_desc->use_shortgi || tcb_desc->use_shortpreamble)
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
 
-		SET_TX_DESC_RTS_ENABLE(pdesc, ((tcb_desc->rts_enable &&
+		set_tx_desc_rts_enable(pdesc, ((tcb_desc->rts_enable &&
 						!tcb_desc->
 						cts_enable) ? 1 : 0));
-		SET_TX_DESC_HW_RTS_ENABLE(pdesc,
+		set_tx_desc_hw_rts_enable(pdesc,
 					  ((tcb_desc->rts_enable
 					    || tcb_desc->cts_enable) ? 1 : 0));
-		SET_TX_DESC_CTS2SELF(pdesc, ((tcb_desc->cts_enable) ? 1 : 0));
-		SET_TX_DESC_RTS_STBC(pdesc, ((tcb_desc->rts_stbc) ? 1 : 0));
+		set_tx_desc_cts2self(pdesc, ((tcb_desc->cts_enable) ? 1 : 0));
+		set_tx_desc_rts_stbc(pdesc, ((tcb_desc->rts_stbc) ? 1 : 0));
 
-		SET_TX_DESC_RTS_RATE(pdesc, tcb_desc->rts_rate);
-		SET_TX_DESC_RTS_BW(pdesc, 0);
-		SET_TX_DESC_RTS_SC(pdesc, tcb_desc->rts_sc);
-		SET_TX_DESC_RTS_SHORT(pdesc,
+		set_tx_desc_rts_rate(pdesc, tcb_desc->rts_rate);
+		set_tx_desc_rts_bw(pdesc, 0);
+		set_tx_desc_rts_sc(pdesc, tcb_desc->rts_sc);
+		set_tx_desc_rts_short(pdesc,
 				      ((tcb_desc->rts_rate <= DESC_RATE54M) ?
 				       (tcb_desc->rts_use_shortpreamble ? 1 : 0)
 				       : (tcb_desc->rts_use_shortgi ? 1 : 0)));
 
 		if (bw_40) {
 			if (tcb_desc->packet_bw) {
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
@@ -515,65 +515,65 @@ void rtl92ce_tx_fill_desc(struct ieee80211_hw *hw,
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
-		SET_TX_DESC_USE_RATE(pdesc, tcb_desc->use_driver_rate ? 1 : 0);
+		set_tx_desc_data_rate_fb_limit(pdesc, 0x1F);
+		set_tx_desc_rts_rate_fb_limit(pdesc, 0xF);
+		set_tx_desc_disable_fb(pdesc, 0);
+		set_tx_desc_use_rate(pdesc, tcb_desc->use_driver_rate ? 1 : 0);
 
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
 	rcu_read_unlock();
 
-	SET_TX_DESC_FIRST_SEG(pdesc, (firstseg ? 1 : 0));
-	SET_TX_DESC_LAST_SEG(pdesc, (lastseg ? 1 : 0));
+	set_tx_desc_first_seg(pdesc, (firstseg ? 1 : 0));
+	set_tx_desc_last_seg(pdesc, (lastseg ? 1 : 0));
 
-	SET_TX_DESC_TX_BUFFER_SIZE(pdesc, (u16) skb->len);
+	set_tx_desc_tx_buffer_size(pdesc, (u16)skb->len);
 
-	SET_TX_DESC_TX_BUFFER_ADDRESS(pdesc, mapping);
+	set_tx_desc_tx_buffer_address(pdesc, mapping);
 
 	if (rtlpriv->dm.useramask) {
-		SET_TX_DESC_RATE_ID(pdesc, tcb_desc->ratr_index);
-		SET_TX_DESC_MACID(pdesc, tcb_desc->mac_id);
+		set_tx_desc_rate_id(pdesc, tcb_desc->ratr_index);
+		set_tx_desc_macid(pdesc, tcb_desc->mac_id);
 	} else {
-		SET_TX_DESC_RATE_ID(pdesc, 0xC + tcb_desc->ratr_index);
-		SET_TX_DESC_MACID(pdesc, tcb_desc->ratr_index);
+		set_tx_desc_rate_id(pdesc, 0xC + tcb_desc->ratr_index);
+		set_tx_desc_macid(pdesc, tcb_desc->ratr_index);
 	}
 
 	if ((!ieee80211_is_data_qos(fc)) && ppsc->fwctrl_lps) {
-		SET_TX_DESC_HWSEQ_EN(pdesc, 1);
-		SET_TX_DESC_PKT_ID(pdesc, 8);
+		set_tx_desc_hwseq_en(pdesc, 1);
+		set_tx_desc_pkt_id(pdesc, 8);
 
 		if (!defaultadapter)
-			SET_TX_DESC_QOS(pdesc, 1);
+			set_tx_desc_qos(pdesc, 1);
 	}
 
-	SET_TX_DESC_MORE_FRAG(pdesc, (lastseg ? 0 : 1));
+	set_tx_desc_more_frag(pdesc, (lastseg ? 0 : 1));
 
 	if (is_multicast_ether_addr(ieee80211_get_DA(hdr)) ||
 	    is_broadcast_ether_addr(ieee80211_get_DA(hdr))) {
-		SET_TX_DESC_BMC(pdesc, 1);
+		set_tx_desc_bmc(pdesc, 1);
 	}
 
 	RT_TRACE(rtlpriv, COMP_SEND, DBG_TRACE, "\n");
@@ -602,40 +602,40 @@ void rtl92ce_tx_fill_cmddesc(struct ieee80211_hw *hw,
 	CLEAR_PCI_TX_DESC_CONTENT(pdesc, TX_DESC_SIZE);
 
 	if (firstseg)
-		SET_TX_DESC_OFFSET(pdesc, USB_HWDESC_HEADER_LEN);
+		set_tx_desc_offset(pdesc, USB_HWDESC_HEADER_LEN);
 
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
 
-	SET_TX_DESC_PKT_SIZE(pdesc, (u16) (skb->len));
+	set_tx_desc_pkt_size(pdesc, (u16)(skb->len));
 
-	SET_TX_DESC_FIRST_SEG(pdesc, 1);
-	SET_TX_DESC_LAST_SEG(pdesc, 1);
+	set_tx_desc_first_seg(pdesc, 1);
+	set_tx_desc_last_seg(pdesc, 1);
 
-	SET_TX_DESC_OFFSET(pdesc, 0x20);
+	set_tx_desc_offset(pdesc, 0x20);
 
-	SET_TX_DESC_USE_RATE(pdesc, 1);
+	set_tx_desc_use_rate(pdesc, 1);
 
 	if (!ieee80211_is_data_qos(fc)) {
-		SET_TX_DESC_HWSEQ_EN(pdesc, 1);
-		SET_TX_DESC_PKT_ID(pdesc, 8);
+		set_tx_desc_hwseq_en(pdesc, 1);
+		set_tx_desc_pkt_id(pdesc, 8);
 	}
 
 	RT_PRINT_DATA(rtlpriv, COMP_CMD, DBG_LOUD,
@@ -649,10 +649,10 @@ void rtl92ce_set_desc(struct ieee80211_hw *hw, u8 *pdesc, bool istx,
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
 			WARN_ONCE(true, "rtl8192ce: ERR txdesc :%d not processed\n",
@@ -663,16 +663,16 @@ void rtl92ce_set_desc(struct ieee80211_hw *hw, u8 *pdesc, bool istx,
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
 			WARN_ONCE(true, "rtl8192ce: ERR rxdesc :%d not processed\n",
@@ -690,10 +690,10 @@ u64 rtl92ce_get_desc(struct ieee80211_hw *hw, u8 *p_desc,
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
 			WARN_ONCE(true, "rtl8192ce: ERR txdesc :%d not processed\n",
@@ -703,13 +703,13 @@ u64 rtl92ce_get_desc(struct ieee80211_hw *hw, u8 *p_desc,
 	} else {
 		switch (desc_name) {
 		case HW_DESC_OWN:
-			ret = GET_RX_DESC_OWN(p_desc);
+			ret = get_rx_desc_own(p_desc);
 			break;
 		case HW_DESC_RXPKT_LEN:
-			ret = GET_RX_DESC_PKT_LEN(p_desc);
+			ret = get_rx_desc_pkt_len(p_desc);
 			break;
 		case HW_DESC_RXBUFF_ADDR:
-			ret = GET_RX_DESC_BUFF_ADDR(p_desc);
+			ret = get_rx_desc_buff_addr(p_desc);
 			break;
 		default:
 			WARN_ONCE(true, "rtl8192ce: ERR rxdesc :%d not processed\n",
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192ce/trx.h b/drivers/net/wireless/realtek/rtlwifi/rtl8192ce/trx.h
index f4dbeeda062f..5addfa20b2b7 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192ce/trx.h
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192ce/trx.h
@@ -16,148 +16,315 @@
 
 /* macros to read/write various fields in RX or TX descriptors */
 
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
-#define GET_RX_DESC_SHIFT(__pdesc)			\
-	le32_get_bits(*((__le32 *)__pdesc), GENMASK(25, 24))
-#define GET_RX_DESC_PHYST(__pdesc)			\
-	le32_get_bits(*((__le32 *)__pdesc), BIT(26))
-#define GET_RX_DESC_SWDEC(__pdesc)			\
-	le32_get_bits(*((__le32 *)__pdesc), BIT(27))
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
-#define GET_RX_DESC_PAGGR(__pdesc)			\
-	le32_get_bits(*((__le32 *)(__pdesc + 4)), BIT(14))
-#define GET_RX_DESC_FAGGR(__pdesc)			\
-	le32_get_bits(*((__le32 *)(__pdesc + 4)), BIT(15))
-
-#define GET_RX_DESC_RXMCS(__pdesc)			\
-	le32_get_bits(*((__le32 *)(__pdesc + 12)), GENMASK(5, 0))
-#define GET_RX_DESC_RXHT(__pdesc)			\
-	le32_get_bits(*((__le32 *)(__pdesc + 12)), BIT(6))
-#define GET_RX_DESC_SPLCP(__pdesc)			\
-	le32_get_bits(*((__le32 *)(__pdesc + 12)), BIT(8))
-#define GET_RX_DESC_BW(__pdesc)				\
-	le32_get_bits(*((__le32 *)(__pdesc + 12)), BIT(9))
-
-#define GET_RX_DESC_TSFL(__pdesc)			\
-	le32_to_cpu(*((__le32 *)(__pdesc + 20)))
-
-#define GET_RX_DESC_BUFF_ADDR(__pdesc)			\
-	le32_to_cpu(*((__le32 *)(__pdesc + 24)))
-
-#define SET_RX_DESC_BUFF_ADDR(__pdesc, __val)		\
-	*(__le32 *)(__pdesc + 24) = cpu_to_le32(__val)
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
+	le32p_replace_bits((__le32 *)(__pdesc + 4), __val, GENMASK(4, 0));
+}
+
+static inline void set_tx_desc_agg_break(u8 *__pdesc, u32  __val)
+{
+	le32p_replace_bits((__le32 *)(__pdesc + 4), __val, BIT(5));
+}
+
+static inline void set_tx_desc_rdg_enable(u8 *__pdesc, u32  __val)
+{
+	le32p_replace_bits((__le32 *)(__pdesc + 4), __val, BIT(7));
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
+static inline void set_tx_desc_sec_type(u8 *__pdesc, u32  __val)
+{
+	le32p_replace_bits((__le32 *)(__pdesc + 4), __val, GENMASK(23, 22));
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
+static inline void set_tx_desc_seq(u8 *__pdesc, u32  __val)
+{
+	le32p_replace_bits((__le32 *)(__pdesc + 12), __val, GENMASK(27, 16));
+}
+
+static inline void set_tx_desc_pkt_id(u8 *__pdesc, u32  __val)
+{
+	le32p_replace_bits((__le32 *)(__pdesc + 12), __val, GENMASK(31, 28));
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
+static inline void set_tx_desc_hwseq_en(u8 *__pdesc, u32  __val)
+{
+	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, BIT(7));
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
+static inline void set_tx_desc_tx_buffer_size(u8 *__pdesc, u32  __val)
+{
+	le32p_replace_bits((__le32 *)(__pdesc + 28), __val, GENMASK(15, 0));
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
+static inline void set_rx_desc_buff_addr(u8 *__pdesc, u32  __val)
+{
+	*(__le32 *)(__pdesc + 24) = cpu_to_le32(__val);
+}
 
 #define CLEAR_PCI_TX_DESC_CONTENT(__pdesc, _size)	\
 	memset(__pdesc, 0, min_t(size_t, _size, TX_DESC_NEXT_DESC_OFFSET))
-- 
2.22.0

