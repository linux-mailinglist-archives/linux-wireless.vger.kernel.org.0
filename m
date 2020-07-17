Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F85C2230EE
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Jul 2020 04:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbgGQCCo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Jul 2020 22:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbgGQCCY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Jul 2020 22:02:24 -0400
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 977FFC08C5CE
        for <linux-wireless@vger.kernel.org>; Thu, 16 Jul 2020 19:02:24 -0700 (PDT)
Received: by mail-oo1-xc41.google.com with SMTP id a9so1571270oof.12
        for <linux-wireless@vger.kernel.org>; Thu, 16 Jul 2020 19:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wZI1WXTRJPVi6Xq8CO/pVt/12rXatfV6fRwZnqUZV2M=;
        b=ajxelQc8SvcB8S3AvGQjf9+23/Is31PIqsB8bfD1Bl5XxWmU+yzLwd2ryvrISGd7Cz
         ygfkkRAxUaZ5CPX93PELD1xjFXYCFRGShOauuvYHZFdkZITHFzNCP8P92aKzlAf5DNm9
         C8fFTs62bwCGW3Jt+8rK3LT9CcQRopvbFVOXHwg0z59OCrPxwKYzrQAHkZkxrzh7r+Wn
         vZb5hhQHhGGHZXE62M03MxEMFNF7kKwNIIr1xFEp79DKctsu1TMNtpvbK5W5qwqMu6g+
         IRwW7PhoOqzULvHq1rSR1hgYAU/J2v4TsDgGnRkV9MFBSzIw9GxADudmuF2Q3ROVb+h/
         3RQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=wZI1WXTRJPVi6Xq8CO/pVt/12rXatfV6fRwZnqUZV2M=;
        b=TAZ2GKWKQ/CPiE306j/N5aDnD3b7yw/bPAoY8DgEwyAV6mKqHTZqOj7Z6eTXY+4eEN
         ox6ITk66fyMXl5a7QluVxpL0hqi4yTFxfT/LOrK/1tSmowahGkv3giBW4/GwsU2fDVCN
         gW1W13p1smU1GQ1Z3JrpLopBFCxTAxRix3rZSLWuMnVimf0b5/lRNzol8gH5nGGNRtsU
         0O6Bn67ftilk3/ufcI745CUQh6BJndqUeoh6DbT3zpBu/ta6uTgND62eUWDTW7ytyzOF
         60hBBdOEXB0xCVXjzoBO392YxfZmEoyKU1Q4NA7DHZeN7KSJ2HZYjvUsuUxfNtM5By6k
         zk1Q==
X-Gm-Message-State: AOAM533/MiEtLMjznvpl/ofhdXuEpbg8s/MdPlQQWyMiVTFMtifUCep5
        d87ifmsY462r2e2vyBPbu/nZrjle
X-Google-Smtp-Source: ABdhPJzh6wAuBD2/XQwbq4XtdqGPtQgZa9iLbjz1hT/Xa5j0TLA9P6LO58lVfHEIz/8aXNSeyl6sBA==
X-Received: by 2002:a4a:2a0e:: with SMTP id k14mr6714804oof.67.1594951343156;
        Thu, 16 Jul 2020 19:02:23 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id h16sm1585985otr.10.2020.07.16.19.02.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 19:02:22 -0700 (PDT)
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH 01/14] rtlwifi: Replace RT_TRACE with RT_DEBUG
Date:   Thu, 16 Jul 2020 21:01:48 -0500
Message-Id: <20200717020201.18209-2-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200717020201.18209-1-Larry.Finger@lwfinger.net>
References: <20200717020201.18209-1-Larry.Finger@lwfinger.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The macro name RT_TRACE makes it seem that it is used for tracing, when
is actually used for debugging. Change the name to RT_DEBUG.

In the initial step, RT_TRACE must be kept to allow building. It will
be removed at the end of the patch series.

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
---
 drivers/net/wireless/realtek/rtlwifi/base.c  |  72 +++++-----
 drivers/net/wireless/realtek/rtlwifi/cam.c   |  38 +++---
 drivers/net/wireless/realtek/rtlwifi/core.c  | 130 +++++++++----------
 drivers/net/wireless/realtek/rtlwifi/debug.c |   2 +-
 drivers/net/wireless/realtek/rtlwifi/debug.h |  11 ++
 drivers/net/wireless/realtek/rtlwifi/efuse.c |  38 +++---
 drivers/net/wireless/realtek/rtlwifi/pci.c   | 116 ++++++++---------
 drivers/net/wireless/realtek/rtlwifi/ps.c    |  40 +++---
 drivers/net/wireless/realtek/rtlwifi/regd.c  |   8 +-
 drivers/net/wireless/realtek/rtlwifi/usb.c   |   8 +-
 10 files changed, 237 insertions(+), 226 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/base.c b/drivers/net/wireless/realtek/rtlwifi/base.c
index a4489b9302d4..39ec4968ece0 100644
--- a/drivers/net/wireless/realtek/rtlwifi/base.c
+++ b/drivers/net/wireless/realtek/rtlwifi/base.c
@@ -195,7 +195,7 @@ static void _rtl_init_hw_ht_capab(struct ieee80211_hw *hw,
 	} else {
 		if (get_rf_type(rtlphy) == RF_1T2R ||
 		    get_rf_type(rtlphy) == RF_2T2R) {
-			RT_TRACE(rtlpriv, COMP_INIT, DBG_DMESG,
+			RT_DEBUG(rtlpriv, COMP_INIT, DBG_DMESG,
 				 "1T2R or 2T2R\n");
 			ht_cap->mcs.rx_mask[0] = 0xFF;
 			ht_cap->mcs.rx_mask[1] = 0xFF;
@@ -204,7 +204,7 @@ static void _rtl_init_hw_ht_capab(struct ieee80211_hw *hw,
 			ht_cap->mcs.rx_highest =
 				 cpu_to_le16(MAX_BIT_RATE_40MHZ_MCS15);
 		} else if (get_rf_type(rtlphy) == RF_1T1R) {
-			RT_TRACE(rtlpriv, COMP_INIT, DBG_DMESG, "1T1R\n");
+			RT_DEBUG(rtlpriv, COMP_INIT, DBG_DMESG, "1T1R\n");
 
 			ht_cap->mcs.rx_mask[0] = 0xFF;
 			ht_cap->mcs.rx_mask[1] = 0x00;
@@ -1324,7 +1324,7 @@ bool rtl_tx_mgmt_proc(struct ieee80211_hw *hw, struct sk_buff *skb)
 			rtlpriv->cfg->ops->chk_switch_dmdp(hw);
 	}
 	if (ieee80211_is_auth(fc)) {
-		RT_TRACE(rtlpriv, COMP_SEND, DBG_DMESG, "MAC80211_LINKING\n");
+		RT_DEBUG(rtlpriv, COMP_SEND, DBG_DMESG, "MAC80211_LINKING\n");
 
 		mac->link_state = MAC80211_LINKING;
 		/* Dul mac */
@@ -1385,7 +1385,7 @@ bool rtl_action_proc(struct ieee80211_hw *hw, struct sk_buff *skb, u8 is_tx)
 			if (mac->act_scanning)
 				return false;
 
-			RT_TRACE(rtlpriv, (COMP_SEND | COMP_RECV), DBG_DMESG,
+			RT_DEBUG(rtlpriv, (COMP_SEND | COMP_RECV), DBG_DMESG,
 				"%s ACT_ADDBAREQ From :%pM\n",
 				is_tx ? "Tx" : "Rx", hdr->addr2);
 			RT_PRINT_DATA(rtlpriv, COMP_INIT, DBG_DMESG, "req\n",
@@ -1400,7 +1400,7 @@ bool rtl_action_proc(struct ieee80211_hw *hw, struct sk_buff *skb, u8 is_tx)
 				rcu_read_lock();
 				sta = rtl_find_sta(hw, hdr->addr3);
 				if (sta == NULL) {
-					RT_TRACE(rtlpriv, COMP_SEND | COMP_RECV,
+					RT_DEBUG(rtlpriv, COMP_SEND | COMP_RECV,
 						 DBG_DMESG, "sta is NULL\n");
 					rcu_read_unlock();
 					return true;
@@ -1428,12 +1428,12 @@ bool rtl_action_proc(struct ieee80211_hw *hw, struct sk_buff *skb, u8 is_tx)
 			}
 			break;
 		case ACT_ADDBARSP:
-			RT_TRACE(rtlpriv, (COMP_SEND | COMP_RECV), DBG_DMESG,
+			RT_DEBUG(rtlpriv, (COMP_SEND | COMP_RECV), DBG_DMESG,
 				 "%s ACT_ADDBARSP From :%pM\n",
 				  is_tx ? "Tx" : "Rx", hdr->addr2);
 			break;
 		case ACT_DELBA:
-			RT_TRACE(rtlpriv, (COMP_SEND | COMP_RECV), DBG_DMESG,
+			RT_DEBUG(rtlpriv, (COMP_SEND | COMP_RECV), DBG_DMESG,
 				 "ACT_ADDBADEL From :%pM\n", hdr->addr2);
 			break;
 		}
@@ -1519,7 +1519,7 @@ u8 rtl_is_special_data(struct ieee80211_hw *hw, struct sk_buff *skb, u8 is_tx,
 				/* 68 : UDP BOOTP client
 				 * 67 : UDP BOOTP server
 				 */
-				RT_TRACE(rtlpriv, (COMP_SEND | COMP_RECV),
+				RT_DEBUG(rtlpriv, (COMP_SEND | COMP_RECV),
 					 DBG_DMESG, "dhcp %s !!\n",
 					 (is_tx) ? "Tx" : "Rx");
 
@@ -1540,7 +1540,7 @@ u8 rtl_is_special_data(struct ieee80211_hw *hw, struct sk_buff *skb, u8 is_tx,
 		rtlpriv->btcoexist.btc_info.in_4way = true;
 		rtlpriv->btcoexist.btc_info.in_4way_ts = jiffies;
 
-		RT_TRACE(rtlpriv, (COMP_SEND | COMP_RECV), DBG_DMESG,
+		RT_DEBUG(rtlpriv, (COMP_SEND | COMP_RECV), DBG_DMESG,
 			 "802.1X %s EAPOL pkt!!\n", (is_tx) ? "Tx" : "Rx");
 
 		if (is_tx) {
@@ -1583,11 +1583,11 @@ static void rtl_tx_status(struct ieee80211_hw *hw, struct sk_buff *skb,
 	info = IEEE80211_SKB_CB(skb);
 	ieee80211_tx_info_clear_status(info);
 	if (ack) {
-		RT_TRACE(rtlpriv, COMP_TX_REPORT, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_TX_REPORT, DBG_LOUD,
 			 "tx report: ack\n");
 		info->flags |= IEEE80211_TX_STAT_ACK;
 	} else {
-		RT_TRACE(rtlpriv, COMP_TX_REPORT, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_TX_REPORT, DBG_LOUD,
 			 "tx report: not ack\n");
 		info->flags &= ~IEEE80211_TX_STAT_ACK;
 	}
@@ -1626,7 +1626,7 @@ static u16 rtl_get_tx_report_sn(struct ieee80211_hw *hw,
 	tx_report->last_sent_time = jiffies;
 	tx_info->sn = sn;
 	tx_info->send_time = tx_report->last_sent_time;
-	RT_TRACE(rtlpriv, COMP_TX_REPORT, DBG_DMESG,
+	RT_DEBUG(rtlpriv, COMP_TX_REPORT, DBG_DMESG,
 		 "Send TX-Report sn=0x%X\n", sn);
 
 	return sn;
@@ -1674,7 +1674,7 @@ void rtl_tx_report_handler(struct ieee80211_hw *hw, u8 *tmp_buf, u8 c2h_cmd_len)
 			break;
 		}
 	}
-	RT_TRACE(rtlpriv, COMP_TX_REPORT, DBG_DMESG,
+	RT_DEBUG(rtlpriv, COMP_TX_REPORT, DBG_DMESG,
 		 "Recv TX-Report st=0x%02X sn=0x%X retry=0x%X\n",
 		 st, sn, retry);
 }
@@ -1689,7 +1689,7 @@ bool rtl_check_tx_report_acked(struct ieee80211_hw *hw)
 		return true;
 
 	if (time_before(tx_report->last_sent_time + 3 * HZ, jiffies)) {
-		RT_TRACE(rtlpriv, COMP_TX_REPORT, DBG_WARNING,
+		RT_DEBUG(rtlpriv, COMP_TX_REPORT, DBG_WARNING,
 			 "Check TX-Report timeout!! s_sn=0x%X r_sn=0x%X\n",
 			 tx_report->last_sent_sn, tx_report->last_recv_sn);
 		return true;	/* 3 sec. (timeout) seen as acked */
@@ -1707,7 +1707,7 @@ void rtl_wait_tx_report_acked(struct ieee80211_hw *hw, u32 wait_ms)
 		if (rtl_check_tx_report_acked(hw))
 			break;
 		usleep_range(1000, 2000);
-		RT_TRACE(rtlpriv, COMP_SEC, DBG_DMESG,
+		RT_DEBUG(rtlpriv, COMP_SEC, DBG_DMESG,
 			 "Wait 1ms (%d/%d) to disable key.\n", i, wait_ms);
 	}
 }
@@ -1770,7 +1770,7 @@ int rtl_tx_agg_start(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		return -ENXIO;
 	tid_data = &sta_entry->tids[tid];
 
-	RT_TRACE(rtlpriv, COMP_SEND, DBG_DMESG,
+	RT_DEBUG(rtlpriv, COMP_SEND, DBG_DMESG,
 		 "on ra = %pM tid = %d seq:%d\n", sta->addr, tid,
 		 *ssn);
 
@@ -1788,7 +1788,7 @@ int rtl_tx_agg_stop(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	if (sta == NULL)
 		return -EINVAL;
 
-	RT_TRACE(rtlpriv, COMP_SEND, DBG_DMESG,
+	RT_DEBUG(rtlpriv, COMP_SEND, DBG_DMESG,
 		 "on ra = %pM tid = %d\n", sta->addr, tid);
 
 	if (unlikely(tid >= MAX_TID_COUNT))
@@ -1828,7 +1828,7 @@ int rtl_rx_agg_start(struct ieee80211_hw *hw,
 		return -ENXIO;
 	tid_data = &sta_entry->tids[tid];
 
-	RT_TRACE(rtlpriv, COMP_RECV, DBG_DMESG,
+	RT_DEBUG(rtlpriv, COMP_RECV, DBG_DMESG,
 		 "on ra = %pM tid = %d\n", sta->addr, tid);
 
 	tid_data->agg.rx_agg_state = RTL_RX_AGG_START;
@@ -1844,7 +1844,7 @@ int rtl_rx_agg_stop(struct ieee80211_hw *hw,
 	if (sta == NULL)
 		return -EINVAL;
 
-	RT_TRACE(rtlpriv, COMP_SEND, DBG_DMESG,
+	RT_DEBUG(rtlpriv, COMP_SEND, DBG_DMESG,
 		 "on ra = %pM tid = %d\n", sta->addr, tid);
 
 	if (unlikely(tid >= MAX_TID_COUNT))
@@ -1865,7 +1865,7 @@ int rtl_tx_agg_oper(struct ieee80211_hw *hw,
 	if (sta == NULL)
 		return -EINVAL;
 
-	RT_TRACE(rtlpriv, COMP_SEND, DBG_DMESG,
+	RT_DEBUG(rtlpriv, COMP_SEND, DBG_DMESG,
 		 "on ra = %pM tid = %d\n", sta->addr, tid);
 
 	if (unlikely(tid >= MAX_TID_COUNT))
@@ -1886,7 +1886,7 @@ void rtl_rx_ampdu_apply(struct rtl_priv *rtlpriv)
 		btc_ops->btc_get_ampdu_cfg(rtlpriv, &reject_agg,
 					   &ctrl_agg_size, &agg_size);
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
 		 "Set RX AMPDU: coex - reject=%d, ctrl_agg_size=%d, size=%d",
 		 reject_agg, ctrl_agg_size, agg_size);
 
@@ -1976,7 +1976,7 @@ void rtl_scan_list_expire(struct ieee80211_hw *hw)
 		list_del(&entry->list);
 		rtlpriv->scan_list.num--;
 
-		RT_TRACE(rtlpriv, COMP_SCAN, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_SCAN, DBG_LOUD,
 			 "BSSID=%pM is expire in scan list (total=%d)\n",
 			 entry->bssid, rtlpriv->scan_list.num);
 		kfree(entry);
@@ -2012,7 +2012,7 @@ void rtl_collect_scan_list(struct ieee80211_hw *hw, struct sk_buff *skb)
 		if (memcmp(entry->bssid, hdr->addr3, ETH_ALEN) == 0) {
 			list_del_init(&entry->list);
 			entry_found = true;
-			RT_TRACE(rtlpriv, COMP_SCAN, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_SCAN, DBG_LOUD,
 				 "Update BSSID=%pM to scan list (total=%d)\n",
 				 hdr->addr3, rtlpriv->scan_list.num);
 			break;
@@ -2028,7 +2028,7 @@ void rtl_collect_scan_list(struct ieee80211_hw *hw, struct sk_buff *skb)
 		memcpy(entry->bssid, hdr->addr3, ETH_ALEN);
 		rtlpriv->scan_list.num++;
 
-		RT_TRACE(rtlpriv, COMP_SCAN, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_SCAN, DBG_LOUD,
 			 "Add BSSID=%pM to scan list (total=%d)\n",
 			 hdr->addr3, rtlpriv->scan_list.num);
 	}
@@ -2190,7 +2190,7 @@ void rtl_watchdog_wq_callback(void *data)
 		if ((rtlpriv->link_info.bcn_rx_inperiod +
 		    rtlpriv->link_info.num_rx_inperiod) == 0) {
 			rtlpriv->link_info.roam_times++;
-			RT_TRACE(rtlpriv, COMP_ERR, DBG_DMESG,
+			RT_DEBUG(rtlpriv, COMP_ERR, DBG_DMESG,
 				 "AP off for %d s\n",
 				(rtlpriv->link_info.roam_times * 2));
 
@@ -2304,10 +2304,10 @@ static void rtl_c2h_content_parsing(struct ieee80211_hw *hw,
 
 	switch (cmd_id) {
 	case C2H_DBG:
-		RT_TRACE(rtlpriv, COMP_FW, DBG_LOUD, "[C2H], C2H_DBG!!\n");
+		RT_DEBUG(rtlpriv, COMP_FW, DBG_LOUD, "[C2H], C2H_DBG!!\n");
 		break;
 	case C2H_TXBF:
-		RT_TRACE(rtlpriv, COMP_FW, DBG_TRACE,
+		RT_DEBUG(rtlpriv, COMP_FW, DBG_TRACE,
 			 "[C2H], C2H_TXBF!!\n");
 		break;
 	case C2H_TX_REPORT:
@@ -2318,19 +2318,19 @@ static void rtl_c2h_content_parsing(struct ieee80211_hw *hw,
 			hal_ops->c2h_ra_report_handler(hw, cmd_buf, cmd_len);
 		break;
 	case C2H_BT_INFO:
-		RT_TRACE(rtlpriv, COMP_FW, DBG_TRACE,
+		RT_DEBUG(rtlpriv, COMP_FW, DBG_TRACE,
 			 "[C2H], C2H_BT_INFO!!\n");
 		if (rtlpriv->cfg->ops->get_btc_status())
 			btc_ops->btc_btinfo_notify(rtlpriv, cmd_buf, cmd_len);
 		break;
 	case C2H_BT_MP:
-		RT_TRACE(rtlpriv, COMP_FW, DBG_TRACE,
+		RT_DEBUG(rtlpriv, COMP_FW, DBG_TRACE,
 			 "[C2H], C2H_BT_MP!!\n");
 		if (rtlpriv->cfg->ops->get_btc_status())
 			btc_ops->btc_btmpinfo_notify(rtlpriv, cmd_buf, cmd_len);
 		break;
 	default:
-		RT_TRACE(rtlpriv, COMP_FW, DBG_TRACE,
+		RT_DEBUG(rtlpriv, COMP_FW, DBG_TRACE,
 			 "[C2H], Unknown packet!! cmd_id(%#X)!\n", cmd_id);
 		break;
 	}
@@ -2355,7 +2355,7 @@ void rtl_c2hcmd_launcher(struct ieee80211_hw *hw, int exec)
 		if (!skb)
 			break;
 
-		RT_TRACE(rtlpriv, COMP_FW, DBG_DMESG, "C2H rx_desc_shift=%d\n",
+		RT_DEBUG(rtlpriv, COMP_FW, DBG_DMESG, "C2H rx_desc_shift=%d\n",
 			 *((u8 *)skb->cb));
 		RT_PRINT_DATA(rtlpriv, COMP_FW, DBG_DMESG,
 			      "C2H data: ", skb->data, skb->len);
@@ -2701,29 +2701,29 @@ void rtl_recognize_peer(struct ieee80211_hw *hw, u8 *data, unsigned int len)
 		(memcmp(mac->bssid, ap5_6, 3) == 0) ||
 		vendor == PEER_ATH) {
 		vendor = PEER_ATH;
-		RT_TRACE(rtlpriv, COMP_MAC80211, DBG_LOUD, "=>ath find\n");
+		RT_DEBUG(rtlpriv, COMP_MAC80211, DBG_LOUD, "=>ath find\n");
 	} else if ((memcmp(mac->bssid, ap4_4, 3) == 0) ||
 		(memcmp(mac->bssid, ap4_5, 3) == 0) ||
 		(memcmp(mac->bssid, ap4_1, 3) == 0) ||
 		(memcmp(mac->bssid, ap4_2, 3) == 0) ||
 		(memcmp(mac->bssid, ap4_3, 3) == 0) ||
 		vendor == PEER_RAL) {
-		RT_TRACE(rtlpriv, COMP_MAC80211, DBG_LOUD, "=>ral find\n");
+		RT_DEBUG(rtlpriv, COMP_MAC80211, DBG_LOUD, "=>ral find\n");
 		vendor = PEER_RAL;
 	} else if (memcmp(mac->bssid, ap6_1, 3) == 0 ||
 		vendor == PEER_CISCO) {
 		vendor = PEER_CISCO;
-		RT_TRACE(rtlpriv, COMP_MAC80211, DBG_LOUD, "=>cisco find\n");
+		RT_DEBUG(rtlpriv, COMP_MAC80211, DBG_LOUD, "=>cisco find\n");
 	} else if ((memcmp(mac->bssid, ap3_1, 3) == 0) ||
 		(memcmp(mac->bssid, ap3_2, 3) == 0) ||
 		(memcmp(mac->bssid, ap3_3, 3) == 0) ||
 		vendor == PEER_BROAD) {
-		RT_TRACE(rtlpriv, COMP_MAC80211, DBG_LOUD, "=>broad find\n");
+		RT_DEBUG(rtlpriv, COMP_MAC80211, DBG_LOUD, "=>broad find\n");
 		vendor = PEER_BROAD;
 	} else if (memcmp(mac->bssid, ap7_1, 3) == 0 ||
 		vendor == PEER_MARV) {
 		vendor = PEER_MARV;
-		RT_TRACE(rtlpriv, COMP_MAC80211, DBG_LOUD, "=>marv find\n");
+		RT_DEBUG(rtlpriv, COMP_MAC80211, DBG_LOUD, "=>marv find\n");
 	}
 
 	mac->vendor = vendor;
diff --git a/drivers/net/wireless/realtek/rtlwifi/cam.c b/drivers/net/wireless/realtek/rtlwifi/cam.c
index bf0e0bb1f99b..13f0b7211720 100644
--- a/drivers/net/wireless/realtek/rtlwifi/cam.c
+++ b/drivers/net/wireless/realtek/rtlwifi/cam.c
@@ -43,12 +43,12 @@ static void rtl_cam_program_entry(struct ieee80211_hw *hw, u32 entry_no,
 			rtl_write_dword(rtlpriv, rtlpriv->cfg->maps[RWCAM],
 					target_command);
 
-			RT_TRACE(rtlpriv, COMP_SEC, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_SEC, DBG_LOUD,
 				 "WRITE %x: %x\n",
 				 rtlpriv->cfg->maps[WCAMI], target_content);
-			RT_TRACE(rtlpriv, COMP_SEC, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_SEC, DBG_LOUD,
 				 "The Key ID is %d\n", entry_no);
-			RT_TRACE(rtlpriv, COMP_SEC, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_SEC, DBG_LOUD,
 				 "WRITE %x: %x\n",
 				 rtlpriv->cfg->maps[RWCAM], target_command);
 
@@ -64,9 +64,9 @@ static void rtl_cam_program_entry(struct ieee80211_hw *hw, u32 entry_no,
 			rtl_write_dword(rtlpriv, rtlpriv->cfg->maps[RWCAM],
 					target_command);
 
-			RT_TRACE(rtlpriv, COMP_SEC, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_SEC, DBG_LOUD,
 				 "WRITE A4: %x\n", target_content);
-			RT_TRACE(rtlpriv, COMP_SEC, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_SEC, DBG_LOUD,
 				 "WRITE A0: %x\n", target_command);
 
 		} else {
@@ -83,14 +83,14 @@ static void rtl_cam_program_entry(struct ieee80211_hw *hw, u32 entry_no,
 			rtl_write_dword(rtlpriv, rtlpriv->cfg->maps[RWCAM],
 					target_command);
 
-			RT_TRACE(rtlpriv, COMP_SEC, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_SEC, DBG_LOUD,
 				 "WRITE A4: %x\n", target_content);
-			RT_TRACE(rtlpriv, COMP_SEC, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_SEC, DBG_LOUD,
 				 "WRITE A0: %x\n", target_command);
 		}
 	}
 
-	RT_TRACE(rtlpriv, COMP_SEC, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_SEC, DBG_LOUD,
 		 "after set key, usconfig:%x\n", us_config);
 }
 
@@ -101,13 +101,13 @@ u8 rtl_cam_add_one_entry(struct ieee80211_hw *hw, u8 *mac_addr,
 	u32 us_config;
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 
-	RT_TRACE(rtlpriv, COMP_SEC, DBG_DMESG,
+	RT_DEBUG(rtlpriv, COMP_SEC, DBG_DMESG,
 		 "EntryNo:%x, ulKeyId=%x, ulEncAlg=%x, ulUseDK=%x MacAddr %pM\n",
 		 ul_entry_idx, ul_key_id, ul_enc_alg,
 		 ul_default_key, mac_addr);
 
 	if (ul_key_id == TOTAL_CAM_ENTRY) {
-		RT_TRACE(rtlpriv, COMP_ERR, DBG_WARNING,
+		RT_DEBUG(rtlpriv, COMP_ERR, DBG_WARNING,
 			 "ulKeyId exceed!\n");
 		return 0;
 	}
@@ -120,7 +120,7 @@ u8 rtl_cam_add_one_entry(struct ieee80211_hw *hw, u8 *mac_addr,
 	rtl_cam_program_entry(hw, ul_entry_idx, mac_addr,
 			      (u8 *)key_content, us_config);
 
-	RT_TRACE(rtlpriv, COMP_SEC, DBG_DMESG, "end\n");
+	RT_DEBUG(rtlpriv, COMP_SEC, DBG_DMESG, "end\n");
 
 	return 1;
 
@@ -133,7 +133,7 @@ int rtl_cam_delete_one_entry(struct ieee80211_hw *hw,
 	u32 ul_command;
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 
-	RT_TRACE(rtlpriv, COMP_SEC, DBG_DMESG, "key_idx:%d\n", ul_key_id);
+	RT_DEBUG(rtlpriv, COMP_SEC, DBG_DMESG, "key_idx:%d\n", ul_key_id);
 
 	ul_command = ul_key_id * CAM_CONTENT_COUNT;
 	ul_command = ul_command | BIT(31) | BIT(16);
@@ -141,9 +141,9 @@ int rtl_cam_delete_one_entry(struct ieee80211_hw *hw,
 	rtl_write_dword(rtlpriv, rtlpriv->cfg->maps[WCAMI], 0);
 	rtl_write_dword(rtlpriv, rtlpriv->cfg->maps[RWCAM], ul_command);
 
-	RT_TRACE(rtlpriv, COMP_SEC, DBG_DMESG,
+	RT_DEBUG(rtlpriv, COMP_SEC, DBG_DMESG,
 		 "rtl_cam_delete_one_entry(): WRITE A4: %x\n", 0);
-	RT_TRACE(rtlpriv, COMP_SEC, DBG_DMESG,
+	RT_DEBUG(rtlpriv, COMP_SEC, DBG_DMESG,
 		 "rtl_cam_delete_one_entry(): WRITE A0: %x\n", ul_command);
 
 	return 0;
@@ -195,9 +195,9 @@ void rtl_cam_mark_invalid(struct ieee80211_hw *hw, u8 uc_index)
 	rtl_write_dword(rtlpriv, rtlpriv->cfg->maps[WCAMI], ul_content);
 	rtl_write_dword(rtlpriv, rtlpriv->cfg->maps[RWCAM], ul_command);
 
-	RT_TRACE(rtlpriv, COMP_SEC, DBG_DMESG,
+	RT_DEBUG(rtlpriv, COMP_SEC, DBG_DMESG,
 		 "rtl_cam_mark_invalid(): WRITE A4: %x\n", ul_content);
-	RT_TRACE(rtlpriv, COMP_SEC, DBG_DMESG,
+	RT_DEBUG(rtlpriv, COMP_SEC, DBG_DMESG,
 		 "rtl_cam_mark_invalid(): WRITE A0: %x\n", ul_command);
 }
 EXPORT_SYMBOL(rtl_cam_mark_invalid);
@@ -245,10 +245,10 @@ void rtl_cam_empty_entry(struct ieee80211_hw *hw, u8 uc_index)
 		rtl_write_dword(rtlpriv, rtlpriv->cfg->maps[WCAMI], ul_content);
 		rtl_write_dword(rtlpriv, rtlpriv->cfg->maps[RWCAM], ul_command);
 
-		RT_TRACE(rtlpriv, COMP_SEC, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_SEC, DBG_LOUD,
 			 "rtl_cam_empty_entry(): WRITE A4: %x\n",
 			 ul_content);
-		RT_TRACE(rtlpriv, COMP_SEC, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_SEC, DBG_LOUD,
 			 "rtl_cam_empty_entry(): WRITE A0: %x\n",
 			 ul_command);
 	}
@@ -313,7 +313,7 @@ void rtl_cam_del_entry(struct ieee80211_hw *hw, u8 *sta_addr)
 			/* Remove from HW Security CAM */
 			eth_zero_addr(rtlpriv->sec.hwsec_cam_sta_addr[i]);
 			rtlpriv->sec.hwsec_cam_bitmap &= ~(BIT(0) << i);
-			RT_TRACE(rtlpriv, COMP_SEC, DBG_DMESG,
+			RT_DEBUG(rtlpriv, COMP_SEC, DBG_DMESG,
 				 "&&&&&&&&&del entry %d\n", i);
 		}
 	}
diff --git a/drivers/net/wireless/realtek/rtlwifi/core.c b/drivers/net/wireless/realtek/rtlwifi/core.c
index 4dd82c6052f0..e289cec7c381 100644
--- a/drivers/net/wireless/realtek/rtlwifi/core.c
+++ b/drivers/net/wireless/realtek/rtlwifi/core.c
@@ -76,7 +76,7 @@ static void rtl_fw_do_work(const struct firmware *firmware, void *context,
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	int err;
 
-	RT_TRACE(rtlpriv, COMP_ERR, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_ERR, DBG_LOUD,
 		 "Firmware callback routine entered!\n");
 	complete(&rtlpriv->firmware_loading_complete);
 	if (!firmware) {
@@ -214,7 +214,7 @@ static int rtl_op_add_interface(struct ieee80211_hw *hw,
 	u8 retry_limit = 0x30;
 
 	if (mac->vif) {
-		RT_TRACE(rtlpriv, COMP_ERR, DBG_WARNING,
+		RT_DEBUG(rtlpriv, COMP_ERR, DBG_WARNING,
 			 "vif has been set!! mac->vif = 0x%p\n", mac->vif);
 		return -EOPNOTSUPP;
 	}
@@ -230,7 +230,7 @@ static int rtl_op_add_interface(struct ieee80211_hw *hw,
 		/*fall through*/
 	case NL80211_IFTYPE_STATION:
 		if (mac->beacon_enabled == 1) {
-			RT_TRACE(rtlpriv, COMP_MAC80211, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_MAC80211, DBG_LOUD,
 				 "NL80211_IFTYPE_STATION\n");
 			mac->beacon_enabled = 0;
 			rtlpriv->cfg->ops->update_interrupt_mask(hw, 0,
@@ -238,7 +238,7 @@ static int rtl_op_add_interface(struct ieee80211_hw *hw,
 		}
 		break;
 	case NL80211_IFTYPE_ADHOC:
-		RT_TRACE(rtlpriv, COMP_MAC80211, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_MAC80211, DBG_LOUD,
 			 "NL80211_IFTYPE_ADHOC\n");
 
 		mac->link_state = MAC80211_LINKED;
@@ -256,7 +256,7 @@ static int rtl_op_add_interface(struct ieee80211_hw *hw,
 		mac->p2p = P2P_ROLE_GO;
 		/*fall through*/
 	case NL80211_IFTYPE_AP:
-		RT_TRACE(rtlpriv, COMP_MAC80211, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_MAC80211, DBG_LOUD,
 			 "NL80211_IFTYPE_AP\n");
 
 		mac->link_state = MAC80211_LINKED;
@@ -271,7 +271,7 @@ static int rtl_op_add_interface(struct ieee80211_hw *hw,
 		retry_limit = 0x07;
 		break;
 	case NL80211_IFTYPE_MESH_POINT:
-		RT_TRACE(rtlpriv, COMP_MAC80211, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_MAC80211, DBG_LOUD,
 			 "NL80211_IFTYPE_MESH_POINT\n");
 
 		mac->link_state = MAC80211_LINKED;
@@ -293,7 +293,7 @@ static int rtl_op_add_interface(struct ieee80211_hw *hw,
 	}
 
 	if (mac->p2p) {
-		RT_TRACE(rtlpriv, COMP_MAC80211, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_MAC80211, DBG_LOUD,
 			 "p2p role %x\n", vif->type);
 		mac->basic_rates = 0xff0;/*disable cck rate for p2p*/
 		rtlpriv->cfg->ops->set_hw_reg(hw, HW_VAR_BASIC_RATE,
@@ -360,7 +360,7 @@ static int rtl_op_change_interface(struct ieee80211_hw *hw,
 	vif->type = new_type;
 	vif->p2p = p2p;
 	ret = rtl_op_add_interface(hw, vif);
-	RT_TRACE(rtlpriv, COMP_MAC80211, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_MAC80211, DBG_LOUD,
 		 "p2p  %x\n", p2p);
 	return ret;
 }
@@ -435,7 +435,7 @@ static void _rtl_add_wowlan_patterns(struct ieee80211_hw *hw,
 		memset(mask, 0, MAX_WOL_BIT_MASK_SIZE);
 		if (patterns[i].pattern_len < 0 ||
 		    patterns[i].pattern_len > MAX_WOL_PATTERN_SIZE) {
-			RT_TRACE(rtlpriv, COMP_POWER, DBG_WARNING,
+			RT_DEBUG(rtlpriv, COMP_POWER, DBG_WARNING,
 				 "Pattern[%d] is too long\n", i);
 			continue;
 		}
@@ -515,7 +515,7 @@ static void _rtl_add_wowlan_patterns(struct ieee80211_hw *hw,
 			      "pattern to hw\n", content, len);
 		/* 3. calculate crc */
 		rtl_pattern.crc = _calculate_wol_pattern_crc(content, len);
-		RT_TRACE(rtlpriv, COMP_POWER, DBG_TRACE,
+		RT_DEBUG(rtlpriv, COMP_POWER, DBG_TRACE,
 			 "CRC_Remainder = 0x%x\n", rtl_pattern.crc);
 
 		/* 4. write crc & mask_for_hw to hw */
@@ -531,7 +531,7 @@ static int rtl_op_suspend(struct ieee80211_hw *hw,
 	struct rtl_hal *rtlhal = rtl_hal(rtlpriv);
 	struct rtl_ps_ctl *ppsc = rtl_psc(rtl_priv(hw));
 
-	RT_TRACE(rtlpriv, COMP_POWER, DBG_DMESG, "\n");
+	RT_DEBUG(rtlpriv, COMP_POWER, DBG_DMESG, "\n");
 	if (WARN_ON(!wow))
 		return -EINVAL;
 
@@ -557,7 +557,7 @@ static int rtl_op_resume(struct ieee80211_hw *hw)
 	struct rtl_mac *mac = rtl_mac(rtl_priv(hw));
 	time64_t now;
 
-	RT_TRACE(rtlpriv, COMP_POWER, DBG_DMESG, "\n");
+	RT_DEBUG(rtlpriv, COMP_POWER, DBG_DMESG, "\n");
 	rtlhal->driver_is_goingto_unload = false;
 	rtlhal->enter_pnp_sleep = false;
 	rtlhal->wake_from_pnp_sleep = true;
@@ -588,7 +588,7 @@ static int rtl_op_config(struct ieee80211_hw *hw, u32 changed)
 
 	mutex_lock(&rtlpriv->locks.conf_mutex);
 	if (changed & IEEE80211_CONF_CHANGE_LISTEN_INTERVAL) {	/* BIT(2)*/
-		RT_TRACE(rtlpriv, COMP_MAC80211, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_MAC80211, DBG_LOUD,
 			 "IEEE80211_CONF_CHANGE_LISTEN_INTERVAL\n");
 	}
 
@@ -632,7 +632,7 @@ static int rtl_op_config(struct ieee80211_hw *hw, u32 changed)
 	}
 
 	if (changed & IEEE80211_CONF_CHANGE_RETRY_LIMITS) {
-		RT_TRACE(rtlpriv, COMP_MAC80211, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_MAC80211, DBG_LOUD,
 			 "IEEE80211_CONF_CHANGE_RETRY_LIMITS %x\n",
 			 hw->conf.long_frame_max_tx_count);
 		/* brought up everything changes (changed == ~0) indicates first
@@ -809,12 +809,12 @@ static void rtl_op_configure_filter(struct ieee80211_hw *hw,
 		if (*new_flags & FIF_ALLMULTI) {
 			mac->rx_conf |= rtlpriv->cfg->maps[MAC_RCR_AM] |
 			    rtlpriv->cfg->maps[MAC_RCR_AB];
-			RT_TRACE(rtlpriv, COMP_MAC80211, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_MAC80211, DBG_LOUD,
 				 "Enable receive multicast frame\n");
 		} else {
 			mac->rx_conf &= ~(rtlpriv->cfg->maps[MAC_RCR_AM] |
 					  rtlpriv->cfg->maps[MAC_RCR_AB]);
-			RT_TRACE(rtlpriv, COMP_MAC80211, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_MAC80211, DBG_LOUD,
 				 "Disable receive multicast frame\n");
 		}
 		update_rcr = true;
@@ -823,11 +823,11 @@ static void rtl_op_configure_filter(struct ieee80211_hw *hw,
 	if (changed_flags & FIF_FCSFAIL) {
 		if (*new_flags & FIF_FCSFAIL) {
 			mac->rx_conf |= rtlpriv->cfg->maps[MAC_RCR_ACRC32];
-			RT_TRACE(rtlpriv, COMP_MAC80211, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_MAC80211, DBG_LOUD,
 				 "Enable receive FCS error frame\n");
 		} else {
 			mac->rx_conf &= ~rtlpriv->cfg->maps[MAC_RCR_ACRC32];
-			RT_TRACE(rtlpriv, COMP_MAC80211, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_MAC80211, DBG_LOUD,
 				 "Disable receive FCS error frame\n");
 		}
 		if (!update_rcr)
@@ -855,11 +855,11 @@ static void rtl_op_configure_filter(struct ieee80211_hw *hw,
 		if (*new_flags & FIF_CONTROL) {
 			mac->rx_conf |= rtlpriv->cfg->maps[MAC_RCR_ACF];
 
-			RT_TRACE(rtlpriv, COMP_MAC80211, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_MAC80211, DBG_LOUD,
 				 "Enable receive control frame.\n");
 		} else {
 			mac->rx_conf &= ~rtlpriv->cfg->maps[MAC_RCR_ACF];
-			RT_TRACE(rtlpriv, COMP_MAC80211, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_MAC80211, DBG_LOUD,
 				 "Disable receive control frame.\n");
 		}
 		if (!update_rcr)
@@ -869,11 +869,11 @@ static void rtl_op_configure_filter(struct ieee80211_hw *hw,
 	if (changed_flags & FIF_OTHER_BSS) {
 		if (*new_flags & FIF_OTHER_BSS) {
 			mac->rx_conf |= rtlpriv->cfg->maps[MAC_RCR_AAP];
-			RT_TRACE(rtlpriv, COMP_MAC80211, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_MAC80211, DBG_LOUD,
 				 "Enable receive other BSS's frame.\n");
 		} else {
 			mac->rx_conf &= ~rtlpriv->cfg->maps[MAC_RCR_AAP];
-			RT_TRACE(rtlpriv, COMP_MAC80211, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_MAC80211, DBG_LOUD,
 				 "Disable receive other BSS's frame.\n");
 		}
 		if (!update_rcr)
@@ -923,7 +923,7 @@ static int rtl_op_sta_add(struct ieee80211_hw *hw,
 			sta->supp_rates[0] &= 0xfffffff0;
 
 		memcpy(sta_entry->mac_addr, sta->addr, ETH_ALEN);
-		RT_TRACE(rtlpriv, COMP_MAC80211, DBG_DMESG,
+		RT_DEBUG(rtlpriv, COMP_MAC80211, DBG_DMESG,
 			"Add sta addr is %pM\n", sta->addr);
 		rtlpriv->cfg->ops->update_rate_tbl(hw, sta, 0, true);
 	}
@@ -939,7 +939,7 @@ static int rtl_op_sta_remove(struct ieee80211_hw *hw,
 	struct rtl_sta_info *sta_entry;
 
 	if (sta) {
-		RT_TRACE(rtlpriv, COMP_MAC80211, DBG_DMESG,
+		RT_DEBUG(rtlpriv, COMP_MAC80211, DBG_DMESG,
 			 "Remove sta addr is %pM\n", sta->addr);
 		sta_entry = (struct rtl_sta_info *)sta->drv_priv;
 		sta_entry->wireless_mode = 0;
@@ -988,7 +988,7 @@ static int rtl_op_conf_tx(struct ieee80211_hw *hw,
 	int aci;
 
 	if (queue >= AC_MAX) {
-		RT_TRACE(rtlpriv, COMP_ERR, DBG_WARNING,
+		RT_DEBUG(rtlpriv, COMP_ERR, DBG_WARNING,
 			 "queue number %d is incorrect!\n", queue);
 		return -EINVAL;
 	}
@@ -1034,7 +1034,7 @@ static void rtl_op_bss_info_changed(struct ieee80211_hw *hw,
 		    (changed & BSS_CHANGED_BEACON_ENABLED &&
 		     bss_conf->enable_beacon)) {
 			if (mac->beacon_enabled == 0) {
-				RT_TRACE(rtlpriv, COMP_MAC80211, DBG_DMESG,
+				RT_DEBUG(rtlpriv, COMP_MAC80211, DBG_DMESG,
 					 "BSS_CHANGED_BEACON_ENABLED\n");
 
 				/*start hw beacon interrupt. */
@@ -1052,7 +1052,7 @@ static void rtl_op_bss_info_changed(struct ieee80211_hw *hw,
 		if ((changed & BSS_CHANGED_BEACON_ENABLED &&
 		    !bss_conf->enable_beacon)) {
 			if (mac->beacon_enabled == 1) {
-				RT_TRACE(rtlpriv, COMP_MAC80211, DBG_DMESG,
+				RT_DEBUG(rtlpriv, COMP_MAC80211, DBG_DMESG,
 					 "ADHOC DISABLE BEACON\n");
 
 				mac->beacon_enabled = 0;
@@ -1062,7 +1062,7 @@ static void rtl_op_bss_info_changed(struct ieee80211_hw *hw,
 			}
 		}
 		if (changed & BSS_CHANGED_BEACON_INT) {
-			RT_TRACE(rtlpriv, COMP_BEACON, DBG_TRACE,
+			RT_DEBUG(rtlpriv, COMP_BEACON, DBG_TRACE,
 				 "BSS_CHANGED_BEACON_INT\n");
 			mac->beacon_interval = bss_conf->beacon_int;
 			rtlpriv->cfg->ops->set_bcn_intv(hw);
@@ -1102,7 +1102,7 @@ static void rtl_op_bss_info_changed(struct ieee80211_hw *hw,
 				rcu_read_unlock();
 				goto out;
 			}
-			RT_TRACE(rtlpriv, COMP_EASY_CONCURRENT, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_EASY_CONCURRENT, DBG_LOUD,
 				 "send PS STATIC frame\n");
 			if (rtlpriv->dm.supp_phymode_switch) {
 				if (sta->ht_cap.ht_supported)
@@ -1143,7 +1143,7 @@ static void rtl_op_bss_info_changed(struct ieee80211_hw *hw,
 						      HW_VAR_KEEP_ALIVE,
 						      (u8 *)(&keep_alive));
 
-			RT_TRACE(rtlpriv, COMP_MAC80211, DBG_DMESG,
+			RT_DEBUG(rtlpriv, COMP_MAC80211, DBG_DMESG,
 				 "BSS_CHANGED_ASSOC\n");
 		} else {
 			struct cfg80211_bss *bss = NULL;
@@ -1161,13 +1161,13 @@ static void rtl_op_bss_info_changed(struct ieee80211_hw *hw,
 					       IEEE80211_BSS_TYPE_ESS,
 					       IEEE80211_PRIVACY_OFF);
 
-			RT_TRACE(rtlpriv, COMP_MAC80211, DBG_DMESG,
+			RT_DEBUG(rtlpriv, COMP_MAC80211, DBG_DMESG,
 				 "bssid = %pMF\n", mac->bssid);
 
 			if (bss) {
 				cfg80211_unlink_bss(hw->wiphy, bss);
 				cfg80211_put_bss(hw->wiphy, bss);
-				RT_TRACE(rtlpriv, COMP_MAC80211, DBG_DMESG,
+				RT_DEBUG(rtlpriv, COMP_MAC80211, DBG_DMESG,
 					 "cfg80211_unlink !!\n");
 			}
 
@@ -1179,7 +1179,7 @@ static void rtl_op_bss_info_changed(struct ieee80211_hw *hw,
 				if (rtlpriv->cfg->ops->chk_switch_dmdp)
 					rtlpriv->cfg->ops->chk_switch_dmdp(hw);
 			}
-			RT_TRACE(rtlpriv, COMP_MAC80211, DBG_DMESG,
+			RT_DEBUG(rtlpriv, COMP_MAC80211, DBG_DMESG,
 				 "BSS_CHANGED_UN_ASSOC\n");
 		}
 		rtlpriv->cfg->ops->set_network_type(hw, vif->type);
@@ -1198,13 +1198,13 @@ static void rtl_op_bss_info_changed(struct ieee80211_hw *hw,
 	}
 
 	if (changed & BSS_CHANGED_ERP_CTS_PROT) {
-		RT_TRACE(rtlpriv, COMP_MAC80211, DBG_TRACE,
+		RT_DEBUG(rtlpriv, COMP_MAC80211, DBG_TRACE,
 			 "BSS_CHANGED_ERP_CTS_PROT\n");
 		mac->use_cts_protect = bss_conf->use_cts_prot;
 	}
 
 	if (changed & BSS_CHANGED_ERP_PREAMBLE) {
-		RT_TRACE(rtlpriv, COMP_MAC80211, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_MAC80211, DBG_LOUD,
 			 "BSS_CHANGED_ERP_PREAMBLE use short preamble:%x\n",
 			  bss_conf->use_short_preamble);
 
@@ -1214,7 +1214,7 @@ static void rtl_op_bss_info_changed(struct ieee80211_hw *hw,
 	}
 
 	if (changed & BSS_CHANGED_ERP_SLOT) {
-		RT_TRACE(rtlpriv, COMP_MAC80211, DBG_TRACE,
+		RT_DEBUG(rtlpriv, COMP_MAC80211, DBG_TRACE,
 			 "BSS_CHANGED_ERP_SLOT\n");
 
 		if (bss_conf->use_short_slot)
@@ -1229,7 +1229,7 @@ static void rtl_op_bss_info_changed(struct ieee80211_hw *hw,
 	if (changed & BSS_CHANGED_HT) {
 		struct ieee80211_sta *sta = NULL;
 
-		RT_TRACE(rtlpriv, COMP_MAC80211, DBG_TRACE,
+		RT_DEBUG(rtlpriv, COMP_MAC80211, DBG_TRACE,
 			 "BSS_CHANGED_HT\n");
 
 		rcu_read_lock();
@@ -1261,7 +1261,7 @@ static void rtl_op_bss_info_changed(struct ieee80211_hw *hw,
 		rtlpriv->cfg->ops->set_hw_reg(hw, HW_VAR_BSSID,
 					      (u8 *)bss_conf->bssid);
 
-		RT_TRACE(rtlpriv, COMP_MAC80211, DBG_DMESG,
+		RT_DEBUG(rtlpriv, COMP_MAC80211, DBG_DMESG,
 			 "bssid: %pM\n", bss_conf->bssid);
 
 		mac->vendor = PEER_UNKNOWN;
@@ -1393,26 +1393,26 @@ static int rtl_op_ampdu_action(struct ieee80211_hw *hw,
 
 	switch (action) {
 	case IEEE80211_AMPDU_TX_START:
-		RT_TRACE(rtlpriv, COMP_MAC80211, DBG_TRACE,
+		RT_DEBUG(rtlpriv, COMP_MAC80211, DBG_TRACE,
 			 "IEEE80211_AMPDU_TX_START: TID:%d\n", tid);
 		return rtl_tx_agg_start(hw, vif, sta, tid, ssn);
 	case IEEE80211_AMPDU_TX_STOP_CONT:
 	case IEEE80211_AMPDU_TX_STOP_FLUSH:
 	case IEEE80211_AMPDU_TX_STOP_FLUSH_CONT:
-		RT_TRACE(rtlpriv, COMP_MAC80211, DBG_TRACE,
+		RT_DEBUG(rtlpriv, COMP_MAC80211, DBG_TRACE,
 			 "IEEE80211_AMPDU_TX_STOP: TID:%d\n", tid);
 		return rtl_tx_agg_stop(hw, vif, sta, tid);
 	case IEEE80211_AMPDU_TX_OPERATIONAL:
-		RT_TRACE(rtlpriv, COMP_MAC80211, DBG_TRACE,
+		RT_DEBUG(rtlpriv, COMP_MAC80211, DBG_TRACE,
 			 "IEEE80211_AMPDU_TX_OPERATIONAL:TID:%d\n", tid);
 		rtl_tx_agg_oper(hw, sta, tid);
 		break;
 	case IEEE80211_AMPDU_RX_START:
-		RT_TRACE(rtlpriv, COMP_MAC80211, DBG_TRACE,
+		RT_DEBUG(rtlpriv, COMP_MAC80211, DBG_TRACE,
 			 "IEEE80211_AMPDU_RX_START:TID:%d\n", tid);
 		return rtl_rx_agg_start(hw, sta, tid);
 	case IEEE80211_AMPDU_RX_STOP:
-		RT_TRACE(rtlpriv, COMP_MAC80211, DBG_TRACE,
+		RT_DEBUG(rtlpriv, COMP_MAC80211, DBG_TRACE,
 			 "IEEE80211_AMPDU_RX_STOP:TID:%d\n", tid);
 		return rtl_rx_agg_stop(hw, sta, tid);
 	default:
@@ -1429,7 +1429,7 @@ static void rtl_op_sw_scan_start(struct ieee80211_hw *hw,
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	struct rtl_mac *mac = rtl_mac(rtl_priv(hw));
 
-	RT_TRACE(rtlpriv, COMP_MAC80211, DBG_LOUD, "\n");
+	RT_DEBUG(rtlpriv, COMP_MAC80211, DBG_LOUD, "\n");
 	mac->act_scanning = true;
 	if (rtlpriv->link_info.higher_busytraffic) {
 		mac->skip_scan = true;
@@ -1467,7 +1467,7 @@ static void rtl_op_sw_scan_complete(struct ieee80211_hw *hw,
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	struct rtl_mac *mac = rtl_mac(rtl_priv(hw));
 
-	RT_TRACE(rtlpriv, COMP_MAC80211, DBG_LOUD, "\n");
+	RT_DEBUG(rtlpriv, COMP_MAC80211, DBG_LOUD, "\n");
 	mac->act_scanning = false;
 	mac->skip_scan = false;
 
@@ -1517,7 +1517,7 @@ static int rtl_op_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 	rtlpriv->btcoexist.btc_info.in_4way = false;
 
 	if (rtlpriv->cfg->mod_params->sw_crypto || rtlpriv->sec.use_sw_sec) {
-		RT_TRACE(rtlpriv, COMP_ERR, DBG_WARNING,
+		RT_DEBUG(rtlpriv, COMP_ERR, DBG_WARNING,
 			 "not open hw encryption\n");
 		return -ENOSPC;	/*User disabled HW-crypto */
 	}
@@ -1526,7 +1526,7 @@ static int rtl_op_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 	     vif->type == NL80211_IFTYPE_MESH_POINT) &&
 	    !(key->flags & IEEE80211_KEY_FLAG_PAIRWISE))
 		return -ENOSPC;
-	RT_TRACE(rtlpriv, COMP_SEC, DBG_DMESG,
+	RT_DEBUG(rtlpriv, COMP_SEC, DBG_DMESG,
 		 "%s hardware based encryption for keyidx: %d, mac: %pM\n",
 		  cmd == SET_KEY ? "Using" : "Disabling", key->keyidx,
 		  sta ? sta->addr : bcast_addr);
@@ -1538,27 +1538,27 @@ static int rtl_op_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 	switch (key->cipher) {
 	case WLAN_CIPHER_SUITE_WEP40:
 		key_type = WEP40_ENCRYPTION;
-		RT_TRACE(rtlpriv, COMP_SEC, DBG_DMESG, "alg:WEP40\n");
+		RT_DEBUG(rtlpriv, COMP_SEC, DBG_DMESG, "alg:WEP40\n");
 		break;
 	case WLAN_CIPHER_SUITE_WEP104:
-		RT_TRACE(rtlpriv, COMP_SEC, DBG_DMESG, "alg:WEP104\n");
+		RT_DEBUG(rtlpriv, COMP_SEC, DBG_DMESG, "alg:WEP104\n");
 		key_type = WEP104_ENCRYPTION;
 		break;
 	case WLAN_CIPHER_SUITE_TKIP:
 		key_type = TKIP_ENCRYPTION;
-		RT_TRACE(rtlpriv, COMP_SEC, DBG_DMESG, "alg:TKIP\n");
+		RT_DEBUG(rtlpriv, COMP_SEC, DBG_DMESG, "alg:TKIP\n");
 		break;
 	case WLAN_CIPHER_SUITE_CCMP:
 		key_type = AESCCMP_ENCRYPTION;
-		RT_TRACE(rtlpriv, COMP_SEC, DBG_DMESG, "alg:CCMP\n");
+		RT_DEBUG(rtlpriv, COMP_SEC, DBG_DMESG, "alg:CCMP\n");
 		break;
 	case WLAN_CIPHER_SUITE_AES_CMAC:
 		/* HW don't support CMAC encryption,
 		 * use software CMAC encryption
 		 */
 		key_type = AESCMAC_ENCRYPTION;
-		RT_TRACE(rtlpriv, COMP_SEC, DBG_DMESG, "alg:CMAC\n");
-		RT_TRACE(rtlpriv, COMP_SEC, DBG_DMESG,
+		RT_DEBUG(rtlpriv, COMP_SEC, DBG_DMESG, "alg:CMAC\n");
+		RT_DEBUG(rtlpriv, COMP_SEC, DBG_DMESG,
 			 "HW don't support CMAC encryption, use software CMAC encryption\n");
 		err = -EOPNOTSUPP;
 		goto out_unlock;
@@ -1605,7 +1605,7 @@ static int rtl_op_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 			    key_type == WEP104_ENCRYPTION))
 				wep_only = true;
 			rtlpriv->sec.pairwise_enc_algorithm = key_type;
-			RT_TRACE(rtlpriv, COMP_SEC, DBG_DMESG,
+			RT_DEBUG(rtlpriv, COMP_SEC, DBG_DMESG,
 				 "set enable_hw_sec, key_type:%x(OPEN:0 WEP40:1 TKIP:2 AES:4 WEP104:5)\n",
 				 key_type);
 			rtlpriv->cfg->ops->enable_hw_sec(hw);
@@ -1615,7 +1615,7 @@ static int rtl_op_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 	switch (cmd) {
 	case SET_KEY:
 		if (wep_only) {
-			RT_TRACE(rtlpriv, COMP_SEC, DBG_DMESG,
+			RT_DEBUG(rtlpriv, COMP_SEC, DBG_DMESG,
 				 "set WEP(group/pairwise) key\n");
 			/* Pairwise key with an assigned MAC address. */
 			rtlpriv->sec.pairwise_enc_algorithm = key_type;
@@ -1626,7 +1626,7 @@ static int rtl_op_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 			rtlpriv->sec.key_len[key_idx] = key->keylen;
 			eth_zero_addr(mac_addr);
 		} else if (group_key) {	/* group key */
-			RT_TRACE(rtlpriv, COMP_SEC, DBG_DMESG,
+			RT_DEBUG(rtlpriv, COMP_SEC, DBG_DMESG,
 				 "set group key\n");
 			/* group key */
 			rtlpriv->sec.group_enc_algorithm = key_type;
@@ -1636,7 +1636,7 @@ static int rtl_op_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 			rtlpriv->sec.key_len[key_idx] = key->keylen;
 			memcpy(mac_addr, bcast_addr, ETH_ALEN);
 		} else {	/* pairwise key */
-			RT_TRACE(rtlpriv, COMP_SEC, DBG_DMESG,
+			RT_DEBUG(rtlpriv, COMP_SEC, DBG_DMESG,
 				 "set pairwise key\n");
 			if (!sta) {
 				WARN_ONCE(true,
@@ -1669,7 +1669,7 @@ static int rtl_op_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 			key->flags |= IEEE80211_KEY_FLAG_SW_MGMT_TX;
 		break;
 	case DISABLE_KEY:
-		RT_TRACE(rtlpriv, COMP_SEC, DBG_DMESG,
+		RT_DEBUG(rtlpriv, COMP_SEC, DBG_DMESG,
 			 "disable key delete one entry\n");
 		/*set local buf about wep key. */
 		if (vif->type == NL80211_IFTYPE_AP ||
@@ -1718,7 +1718,7 @@ static void rtl_op_rfkill_poll(struct ieee80211_hw *hw)
 		if (unlikely(radio_state != rtlpriv->rfkill.rfkill_state)) {
 			rtlpriv->rfkill.rfkill_state = radio_state;
 
-			RT_TRACE(rtlpriv, COMP_RF, DBG_DMESG,
+			RT_DEBUG(rtlpriv, COMP_RF, DBG_DMESG,
 				 "wireless radio switch turned %s\n",
 				  radio_state ? "on" : "off");
 
@@ -1765,7 +1765,7 @@ bool rtl_hal_pwrseqcmdparsing(struct rtl_priv *rtlpriv, u8 cut_version,
 
 	do {
 		cfg_cmd = pwrcfgcmd[ary_idx];
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
+		RT_DEBUG(rtlpriv, COMP_INIT, DBG_TRACE,
 			 "rtl_hal_pwrseqcmdparsing(): offset(%#x),cut_msk(%#x), famsk(%#x), interface_msk(%#x), base(%#x), cmd(%#x), msk(%#x), value(%#x)\n",
 			 GET_PWR_CFG_OFFSET(cfg_cmd),
 					    GET_PWR_CFG_CUT_MASK(cfg_cmd),
@@ -1779,11 +1779,11 @@ bool rtl_hal_pwrseqcmdparsing(struct rtl_priv *rtlpriv, u8 cut_version,
 		    (GET_PWR_CFG_INTF_MASK(cfg_cmd)&interface_type)) {
 			switch (GET_PWR_CFG_CMD(cfg_cmd)) {
 			case PWR_CMD_READ:
-				RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
+				RT_DEBUG(rtlpriv, COMP_INIT, DBG_TRACE,
 					"rtl_hal_pwrseqcmdparsing(): PWR_CMD_READ\n");
 				break;
 			case PWR_CMD_WRITE:
-				RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
+				RT_DEBUG(rtlpriv, COMP_INIT, DBG_TRACE,
 					 "%s(): PWR_CMD_WRITE\n", __func__);
 				offset = GET_PWR_CFG_OFFSET(cfg_cmd);
 
@@ -1797,7 +1797,7 @@ bool rtl_hal_pwrseqcmdparsing(struct rtl_priv *rtlpriv, u8 cut_version,
 				rtl_write_byte(rtlpriv, offset, value);
 				break;
 			case PWR_CMD_POLLING:
-				RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
+				RT_DEBUG(rtlpriv, COMP_INIT, DBG_TRACE,
 					"rtl_hal_pwrseqcmdparsing(): PWR_CMD_POLLING\n");
 				polling_bit = false;
 				offset = GET_PWR_CFG_OFFSET(cfg_cmd);
@@ -1818,7 +1818,7 @@ bool rtl_hal_pwrseqcmdparsing(struct rtl_priv *rtlpriv, u8 cut_version,
 				} while (!polling_bit);
 				break;
 			case PWR_CMD_DELAY:
-				RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
+				RT_DEBUG(rtlpriv, COMP_INIT, DBG_TRACE,
 					 "rtl_hal_pwrseqcmdparsing(): PWR_CMD_DELAY\n");
 				if (GET_PWR_CFG_VALUE(cfg_cmd) ==
 				    PWRSEQ_DELAY_US)
@@ -1827,7 +1827,7 @@ bool rtl_hal_pwrseqcmdparsing(struct rtl_priv *rtlpriv, u8 cut_version,
 					mdelay(GET_PWR_CFG_OFFSET(cfg_cmd));
 				break;
 			case PWR_CMD_END:
-				RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
+				RT_DEBUG(rtlpriv, COMP_INIT, DBG_TRACE,
 					 "rtl_hal_pwrseqcmdparsing(): PWR_CMD_END\n");
 				return true;
 			default:
diff --git a/drivers/net/wireless/realtek/rtlwifi/debug.c b/drivers/net/wireless/realtek/rtlwifi/debug.c
index 55db71c766fe..35a716eb108e 100644
--- a/drivers/net/wireless/realtek/rtlwifi/debug.c
+++ b/drivers/net/wireless/realtek/rtlwifi/debug.c
@@ -404,7 +404,7 @@ static ssize_t rtl_debugfs_set_write_rfreg(struct file *filp,
 		     &path, &addr, &bitmask, &data);
 
 	if (num != 4) {
-		RT_TRACE(rtlpriv, COMP_ERR, DBG_DMESG,
+		RT_DEBUG(rtlpriv, COMP_ERR, DBG_DMESG,
 			 "Format is <path> <addr> <mask> <data>\n");
 		return count;
 	}
diff --git a/drivers/net/wireless/realtek/rtlwifi/debug.h b/drivers/net/wireless/realtek/rtlwifi/debug.h
index 69f169d4d4ae..7cb38644a4e7 100644
--- a/drivers/net/wireless/realtek/rtlwifi/debug.h
+++ b/drivers/net/wireless/realtek/rtlwifi/debug.h
@@ -160,6 +160,10 @@ void _rtl_dbg_print_data(struct rtl_priv *rtlpriv, u64 comp, int level,
 			 const char *titlestring,
 			 const void *hexdata, int hexdatalen);
 
+#define RT_DEBUG(rtlpriv, comp, level, fmt, ...)			\
+	_rtl_dbg_trace(rtlpriv, comp, level,				\
+		       fmt, ##__VA_ARGS__)
+
 #define RT_TRACE(rtlpriv, comp, level, fmt, ...)			\
 	_rtl_dbg_trace(rtlpriv, comp, level,				\
 		       fmt, ##__VA_ARGS__)
@@ -176,6 +180,13 @@ void _rtl_dbg_print_data(struct rtl_priv *rtlpriv, u64 comp, int level,
 
 struct rtl_priv;
 
+__printf(4, 5)
+static inline void RT_DEBUG(struct rtl_priv *rtlpriv,
+			    u64 comp, int level,
+			    const char *fmt, ...)
+{
+}
+
 __printf(4, 5)
 static inline void RT_TRACE(struct rtl_priv *rtlpriv,
 			    u64 comp, int level,
diff --git a/drivers/net/wireless/realtek/rtlwifi/efuse.c b/drivers/net/wireless/realtek/rtlwifi/efuse.c
index cef9f2a9303b..2c8ca0debe6d 100644
--- a/drivers/net/wireless/realtek/rtlwifi/efuse.c
+++ b/drivers/net/wireless/realtek/rtlwifi/efuse.c
@@ -120,7 +120,7 @@ void efuse_write_1byte(struct ieee80211_hw *hw, u16 address, u8 value)
 	const u32 efuse_len =
 		rtlpriv->cfg->maps[EFUSE_REAL_CONTENT_SIZE];
 
-	RT_TRACE(rtlpriv, COMP_EFUSE, DBG_LOUD, "Addr=%x Data =%x\n",
+	RT_DEBUG(rtlpriv, COMP_EFUSE, DBG_LOUD, "Addr=%x Data =%x\n",
 		 address, value);
 
 	if (address < efuse_len) {
@@ -211,7 +211,7 @@ void read_efuse(struct ieee80211_hw *hw, u16 _offset, u16 _size_byte, u8 *pbuf)
 	u8 efuse_usage;
 
 	if ((_offset + _size_byte) > rtlpriv->cfg->maps[EFUSE_HWSET_MAX_SIZE]) {
-		RT_TRACE(rtlpriv, COMP_EFUSE, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_EFUSE, DBG_LOUD,
 			 "read_efuse(): Invalid offset(%#x) with read bytes(%#x)!!\n",
 			 _offset, _size_byte);
 		return;
@@ -376,7 +376,7 @@ bool efuse_shadow_update_chk(struct ieee80211_hw *hw)
 	    (EFUSE_MAX_SIZE - rtlpriv->cfg->maps[EFUSE_OOB_PROTECT_BYTES_LEN]))
 		result = false;
 
-	RT_TRACE(rtlpriv, COMP_EFUSE, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_EFUSE, DBG_LOUD,
 		 "efuse_shadow_update_chk(): totalbytes(%#x), hdr_num(%#x), words_need(%#x), efuse_used(%d)\n",
 		 totalbytes, hdr_num, words_need, efuse_used);
 
@@ -416,7 +416,7 @@ bool efuse_shadow_update(struct ieee80211_hw *hw)
 	u8 word_en = 0x0F;
 	u8 first_pg = false;
 
-	RT_TRACE(rtlpriv, COMP_EFUSE, DBG_LOUD, "\n");
+	RT_DEBUG(rtlpriv, COMP_EFUSE, DBG_LOUD, "\n");
 
 	if (!efuse_shadow_update_chk(hw)) {
 		efuse_read_all_map(hw, &rtlefuse->efuse_map[EFUSE_INIT_MAP][0]);
@@ -424,7 +424,7 @@ bool efuse_shadow_update(struct ieee80211_hw *hw)
 		       &rtlefuse->efuse_map[EFUSE_INIT_MAP][0],
 		       rtlpriv->cfg->maps[EFUSE_HWSET_MAX_SIZE]);
 
-		RT_TRACE(rtlpriv, COMP_EFUSE, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_EFUSE, DBG_LOUD,
 			 "efuse out of capacity!!\n");
 		return false;
 	}
@@ -464,7 +464,7 @@ bool efuse_shadow_update(struct ieee80211_hw *hw)
 
 			if (!efuse_pg_packet_write(hw, (u8) offset, word_en,
 						   tmpdata)) {
-				RT_TRACE(rtlpriv, COMP_ERR, DBG_WARNING,
+				RT_DEBUG(rtlpriv, COMP_ERR, DBG_WARNING,
 					 "PG section(%#x) fail!!\n", offset);
 				break;
 			}
@@ -478,7 +478,7 @@ bool efuse_shadow_update(struct ieee80211_hw *hw)
 	       &rtlefuse->efuse_map[EFUSE_INIT_MAP][0],
 	       rtlpriv->cfg->maps[EFUSE_HWSET_MAX_SIZE]);
 
-	RT_TRACE(rtlpriv, COMP_EFUSE, DBG_LOUD, "\n");
+	RT_DEBUG(rtlpriv, COMP_EFUSE, DBG_LOUD, "\n");
 	return true;
 }
 
@@ -616,7 +616,7 @@ static int efuse_one_byte_write(struct ieee80211_hw *hw, u16 addr, u8 data)
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	u8 tmpidx = 0;
 
-	RT_TRACE(rtlpriv, COMP_EFUSE, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_EFUSE, DBG_LOUD,
 		 "Addr = %x Data=%x\n", addr, data);
 
 	rtl_write_byte(rtlpriv,
@@ -996,7 +996,7 @@ static int efuse_pg_packet_write(struct ieee80211_hw *hw,
 
 	if (efuse_addr >= (EFUSE_MAX_SIZE -
 		rtlpriv->cfg->maps[EFUSE_OOB_PROTECT_BYTES_LEN])) {
-		RT_TRACE(rtlpriv, COMP_EFUSE, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_EFUSE, DBG_LOUD,
 			 "efuse_addr(%#x) Out of size!!\n", efuse_addr);
 	}
 
@@ -1037,7 +1037,7 @@ static u8 enable_efuse_data_write(struct ieee80211_hw *hw,
 	u8 tmpdata[8];
 
 	memset(tmpdata, 0xff, PGPKT_DATA_SIZE);
-	RT_TRACE(rtlpriv, COMP_EFUSE, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_EFUSE, DBG_LOUD,
 		 "word_en = %x efuse_addr=%x\n", word_en, efuse_addr);
 
 	if (!(word_en & BIT(0))) {
@@ -1240,11 +1240,11 @@ int rtl_get_hwinfo(struct ieee80211_hw *hw, struct rtl_priv *rtlpriv,
 
 	eeprom_id = *((u16 *)&hwinfo[0]);
 	if (eeprom_id != params[0]) {
-		RT_TRACE(rtlpriv, COMP_ERR, DBG_WARNING,
+		RT_DEBUG(rtlpriv, COMP_ERR, DBG_WARNING,
 			 "EEPROM ID(%#x) is invalid!!\n", eeprom_id);
 		rtlefuse->autoload_failflag = true;
 	} else {
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD, "Autoload OK\n");
+		RT_DEBUG(rtlpriv, COMP_INIT, DBG_LOUD, "Autoload OK\n");
 		rtlefuse->autoload_failflag = false;
 	}
 
@@ -1255,29 +1255,29 @@ int rtl_get_hwinfo(struct ieee80211_hw *hw, struct rtl_priv *rtlpriv,
 	rtlefuse->eeprom_did = *(u16 *)&hwinfo[params[2]];
 	rtlefuse->eeprom_svid = *(u16 *)&hwinfo[params[3]];
 	rtlefuse->eeprom_smid = *(u16 *)&hwinfo[params[4]];
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_INIT, DBG_LOUD,
 		 "EEPROMId = 0x%4x\n", eeprom_id);
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_INIT, DBG_LOUD,
 		 "EEPROM VID = 0x%4x\n", rtlefuse->eeprom_vid);
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_INIT, DBG_LOUD,
 		 "EEPROM DID = 0x%4x\n", rtlefuse->eeprom_did);
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_INIT, DBG_LOUD,
 		 "EEPROM SVID = 0x%4x\n", rtlefuse->eeprom_svid);
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_INIT, DBG_LOUD,
 		 "EEPROM SMID = 0x%4x\n", rtlefuse->eeprom_smid);
 
 	for (i = 0; i < 6; i += 2) {
 		usvalue = *(u16 *)&hwinfo[params[5] + i];
 		*((u16 *)(&rtlefuse->dev_addr[i])) = usvalue;
 	}
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_DMESG, "%pM\n", rtlefuse->dev_addr);
+	RT_DEBUG(rtlpriv, COMP_INIT, DBG_DMESG, "%pM\n", rtlefuse->dev_addr);
 
 	rtlefuse->eeprom_channelplan = *&hwinfo[params[6]];
 	rtlefuse->eeprom_version = *(u16 *)&hwinfo[params[7]];
 	rtlefuse->txpwr_fromeprom = true;
 	rtlefuse->eeprom_oemid = *&hwinfo[params[8]];
 
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_INIT, DBG_LOUD,
 		 "EEPROM Customer ID: 0x%2x\n", rtlefuse->eeprom_oemid);
 
 	/* set channel plan to world wide 13 */
diff --git a/drivers/net/wireless/realtek/rtlwifi/pci.c b/drivers/net/wireless/realtek/rtlwifi/pci.c
index 25335bd2873b..0478b4dd6481 100644
--- a/drivers/net/wireless/realtek/rtlwifi/pci.c
+++ b/drivers/net/wireless/realtek/rtlwifi/pci.c
@@ -204,7 +204,7 @@ static void rtl_pci_disable_aspm(struct ieee80211_hw *hw)
 		return;
 
 	if (pcibridge_vendor == PCI_BRIDGE_VENDOR_UNKNOWN) {
-		RT_TRACE(rtlpriv, COMP_POWER, DBG_TRACE,
+		RT_DEBUG(rtlpriv, COMP_POWER, DBG_TRACE,
 			 "PCI(Bridge) UNKNOWN\n");
 
 		return;
@@ -254,7 +254,7 @@ static void rtl_pci_enable_aspm(struct ieee80211_hw *hw)
 		return;
 
 	if (pcibridge_vendor == PCI_BRIDGE_VENDOR_UNKNOWN) {
-		RT_TRACE(rtlpriv, COMP_POWER, DBG_TRACE,
+		RT_DEBUG(rtlpriv, COMP_POWER, DBG_TRACE,
 			 "PCI(Bridge) UNKNOWN\n");
 		return;
 	}
@@ -271,7 +271,7 @@ static void rtl_pci_enable_aspm(struct ieee80211_hw *hw)
 	pci_write_config_byte(rtlpci->pdev, (num4bytes << 2),
 			      u_pcibridge_aspmsetting);
 
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_INIT, DBG_LOUD,
 		 "PlatformEnableASPM(): Write reg[%x] = %x\n",
 		 (pcipriv->ndis_adapter.pcibridge_pciehdr_offset + 0x10),
 		 u_pcibridge_aspmsetting);
@@ -331,10 +331,10 @@ static bool rtl_pci_check_buddy_priv(struct ieee80211_hw *hw,
 		list_for_each_entry(tpriv, &rtlpriv->glb_var->glb_priv_list,
 				    list) {
 			tpcipriv = (struct rtl_pci_priv *)tpriv->priv;
-			RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_INIT, DBG_LOUD,
 				 "pcipriv->ndis_adapter.funcnumber %x\n",
 				pcipriv->ndis_adapter.funcnumber);
-			RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_INIT, DBG_LOUD,
 				 "tpcipriv->ndis_adapter.funcnumber %x\n",
 				tpcipriv->ndis_adapter.funcnumber);
 
@@ -350,7 +350,7 @@ static bool rtl_pci_check_buddy_priv(struct ieee80211_hw *hw,
 		}
 	}
 
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_INIT, DBG_LOUD,
 		 "find_buddy_priv %d\n", find_buddy_priv);
 
 	if (find_buddy_priv)
@@ -388,7 +388,7 @@ static void rtl_pci_parse_configuration(struct pci_dev *pdev,
 	pcie_capability_read_word(pdev, PCI_EXP_LNKCTL, &linkctrl_reg);
 	pcipriv->ndis_adapter.linkctrl_reg = (u8)linkctrl_reg;
 
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE, "Link Control Register =%x\n",
+	RT_DEBUG(rtlpriv, COMP_INIT, DBG_TRACE, "Link Control Register =%x\n",
 		 pcipriv->ndis_adapter.linkctrl_reg);
 
 	pci_read_config_byte(pdev, 0x98, &tmp);
@@ -557,7 +557,7 @@ static void _rtl_pci_tx_isr(struct ieee80211_hw *hw, int prio)
 		if (rtlpriv->rtlhal.earlymode_enable)
 			skb_pull(skb, EM_HDR_LEN);
 
-		RT_TRACE(rtlpriv, (COMP_INTR | COMP_SEND), DBG_TRACE,
+		RT_DEBUG(rtlpriv, (COMP_INTR | COMP_SEND), DBG_TRACE,
 			 "new ring->idx:%d, free: skb_queue_len:%d, free: seq:%x\n",
 			 ring->idx,
 			 skb_queue_len(&ring->queue),
@@ -608,7 +608,7 @@ static void _rtl_pci_tx_isr(struct ieee80211_hw *hw, int prio)
 		}
 
 		if ((ring->entries - skb_queue_len(&ring->queue)) <= 4) {
-			RT_TRACE(rtlpriv, COMP_ERR, DBG_DMESG,
+			RT_DEBUG(rtlpriv, COMP_ERR, DBG_DMESG,
 				 "more desc left, wake skb_queue@%d, ring->idx = %d, skb_queue_len = 0x%x\n",
 				 prio, ring->idx,
 				 skb_queue_len(&ring->queue));
@@ -801,7 +801,7 @@ static void _rtl_pci_rx_interrupt(struct ieee80211_hw *hw)
 				skb_reserve(skb, stats.rx_drvinfo_size +
 					    stats.rx_bufshift);
 		} else {
-			RT_TRACE(rtlpriv, COMP_ERR, DBG_WARNING,
+			RT_DEBUG(rtlpriv, COMP_ERR, DBG_WARNING,
 				 "skb->end - skb->tail = %d, len is %d\n",
 				 skb->end - skb->tail, len);
 			dev_kfree_skb_any(skb);
@@ -925,34 +925,34 @@ static irqreturn_t _rtl_pci_interrupt(int irq, void *dev_id)
 
 	/*<1> beacon related */
 	if (intvec.inta & rtlpriv->cfg->maps[RTL_IMR_TBDOK])
-		RT_TRACE(rtlpriv, COMP_INTR, DBG_TRACE,
+		RT_DEBUG(rtlpriv, COMP_INTR, DBG_TRACE,
 			 "beacon ok interrupt!\n");
 
 	if (unlikely(intvec.inta & rtlpriv->cfg->maps[RTL_IMR_TBDER]))
-		RT_TRACE(rtlpriv, COMP_INTR, DBG_TRACE,
+		RT_DEBUG(rtlpriv, COMP_INTR, DBG_TRACE,
 			 "beacon err interrupt!\n");
 
 	if (intvec.inta & rtlpriv->cfg->maps[RTL_IMR_BDOK])
-		RT_TRACE(rtlpriv, COMP_INTR, DBG_TRACE, "beacon interrupt!\n");
+		RT_DEBUG(rtlpriv, COMP_INTR, DBG_TRACE, "beacon interrupt!\n");
 
 	if (intvec.inta & rtlpriv->cfg->maps[RTL_IMR_BCNINT]) {
-		RT_TRACE(rtlpriv, COMP_INTR, DBG_TRACE,
+		RT_DEBUG(rtlpriv, COMP_INTR, DBG_TRACE,
 			 "prepare beacon for interrupt!\n");
 		tasklet_schedule(&rtlpriv->works.irq_prepare_bcn_tasklet);
 	}
 
 	/*<2> Tx related */
 	if (unlikely(intvec.intb & rtlpriv->cfg->maps[RTL_IMR_TXFOVW]))
-		RT_TRACE(rtlpriv, COMP_ERR, DBG_WARNING, "IMR_TXFOVW!\n");
+		RT_DEBUG(rtlpriv, COMP_ERR, DBG_WARNING, "IMR_TXFOVW!\n");
 
 	if (intvec.inta & rtlpriv->cfg->maps[RTL_IMR_MGNTDOK]) {
-		RT_TRACE(rtlpriv, COMP_INTR, DBG_TRACE,
+		RT_DEBUG(rtlpriv, COMP_INTR, DBG_TRACE,
 			 "Manage ok interrupt!\n");
 		_rtl_pci_tx_isr(hw, MGNT_QUEUE);
 	}
 
 	if (intvec.inta & rtlpriv->cfg->maps[RTL_IMR_HIGHDOK]) {
-		RT_TRACE(rtlpriv, COMP_INTR, DBG_TRACE,
+		RT_DEBUG(rtlpriv, COMP_INTR, DBG_TRACE,
 			 "HIGH_QUEUE ok interrupt!\n");
 		_rtl_pci_tx_isr(hw, HIGH_QUEUE);
 	}
@@ -960,7 +960,7 @@ static irqreturn_t _rtl_pci_interrupt(int irq, void *dev_id)
 	if (intvec.inta & rtlpriv->cfg->maps[RTL_IMR_BKDOK]) {
 		rtlpriv->link_info.num_tx_inperiod++;
 
-		RT_TRACE(rtlpriv, COMP_INTR, DBG_TRACE,
+		RT_DEBUG(rtlpriv, COMP_INTR, DBG_TRACE,
 			 "BK Tx OK interrupt!\n");
 		_rtl_pci_tx_isr(hw, BK_QUEUE);
 	}
@@ -968,7 +968,7 @@ static irqreturn_t _rtl_pci_interrupt(int irq, void *dev_id)
 	if (intvec.inta & rtlpriv->cfg->maps[RTL_IMR_BEDOK]) {
 		rtlpriv->link_info.num_tx_inperiod++;
 
-		RT_TRACE(rtlpriv, COMP_INTR, DBG_TRACE,
+		RT_DEBUG(rtlpriv, COMP_INTR, DBG_TRACE,
 			 "BE TX OK interrupt!\n");
 		_rtl_pci_tx_isr(hw, BE_QUEUE);
 	}
@@ -976,7 +976,7 @@ static irqreturn_t _rtl_pci_interrupt(int irq, void *dev_id)
 	if (intvec.inta & rtlpriv->cfg->maps[RTL_IMR_VIDOK]) {
 		rtlpriv->link_info.num_tx_inperiod++;
 
-		RT_TRACE(rtlpriv, COMP_INTR, DBG_TRACE,
+		RT_DEBUG(rtlpriv, COMP_INTR, DBG_TRACE,
 			 "VI TX OK interrupt!\n");
 		_rtl_pci_tx_isr(hw, VI_QUEUE);
 	}
@@ -984,7 +984,7 @@ static irqreturn_t _rtl_pci_interrupt(int irq, void *dev_id)
 	if (intvec.inta & rtlpriv->cfg->maps[RTL_IMR_VODOK]) {
 		rtlpriv->link_info.num_tx_inperiod++;
 
-		RT_TRACE(rtlpriv, COMP_INTR, DBG_TRACE,
+		RT_DEBUG(rtlpriv, COMP_INTR, DBG_TRACE,
 			 "Vo TX OK interrupt!\n");
 		_rtl_pci_tx_isr(hw, VO_QUEUE);
 	}
@@ -993,7 +993,7 @@ static irqreturn_t _rtl_pci_interrupt(int irq, void *dev_id)
 		if (intvec.intd & rtlpriv->cfg->maps[RTL_IMR_H2CDOK]) {
 			rtlpriv->link_info.num_tx_inperiod++;
 
-			RT_TRACE(rtlpriv, COMP_INTR, DBG_TRACE,
+			RT_DEBUG(rtlpriv, COMP_INTR, DBG_TRACE,
 				 "H2C TX OK interrupt!\n");
 			_rtl_pci_tx_isr(hw, H2C_QUEUE);
 		}
@@ -1003,7 +1003,7 @@ static irqreturn_t _rtl_pci_interrupt(int irq, void *dev_id)
 		if (intvec.inta & rtlpriv->cfg->maps[RTL_IMR_COMDOK]) {
 			rtlpriv->link_info.num_tx_inperiod++;
 
-			RT_TRACE(rtlpriv, COMP_INTR, DBG_TRACE,
+			RT_DEBUG(rtlpriv, COMP_INTR, DBG_TRACE,
 				 "CMD TX OK interrupt!\n");
 			_rtl_pci_tx_isr(hw, TXCMD_QUEUE);
 		}
@@ -1011,25 +1011,25 @@ static irqreturn_t _rtl_pci_interrupt(int irq, void *dev_id)
 
 	/*<3> Rx related */
 	if (intvec.inta & rtlpriv->cfg->maps[RTL_IMR_ROK]) {
-		RT_TRACE(rtlpriv, COMP_INTR, DBG_TRACE, "Rx ok interrupt!\n");
+		RT_DEBUG(rtlpriv, COMP_INTR, DBG_TRACE, "Rx ok interrupt!\n");
 		_rtl_pci_rx_interrupt(hw);
 	}
 
 	if (unlikely(intvec.inta & rtlpriv->cfg->maps[RTL_IMR_RDU])) {
-		RT_TRACE(rtlpriv, COMP_ERR, DBG_WARNING,
+		RT_DEBUG(rtlpriv, COMP_ERR, DBG_WARNING,
 			 "rx descriptor unavailable!\n");
 		_rtl_pci_rx_interrupt(hw);
 	}
 
 	if (unlikely(intvec.intb & rtlpriv->cfg->maps[RTL_IMR_RXFOVW])) {
-		RT_TRACE(rtlpriv, COMP_ERR, DBG_WARNING, "rx overflow !\n");
+		RT_DEBUG(rtlpriv, COMP_ERR, DBG_WARNING, "rx overflow !\n");
 		_rtl_pci_rx_interrupt(hw);
 	}
 
 	/*<4> fw related*/
 	if (rtlhal->hw_type == HARDWARE_TYPE_RTL8723AE) {
 		if (intvec.inta & rtlpriv->cfg->maps[RTL_IMR_C2HCMD]) {
-			RT_TRACE(rtlpriv, COMP_INTR, DBG_TRACE,
+			RT_DEBUG(rtlpriv, COMP_INTR, DBG_TRACE,
 				 "firmware interrupt!\n");
 			queue_delayed_work(rtlpriv->works.rtl_wq,
 					   &rtlpriv->works.fwevt_wq, 0);
@@ -1046,7 +1046,7 @@ static irqreturn_t _rtl_pci_interrupt(int irq, void *dev_id)
 	    rtlhal->hw_type == HARDWARE_TYPE_RTL8723BE) {
 		if (unlikely(intvec.inta &
 		    rtlpriv->cfg->maps[RTL_IMR_HSISR_IND])) {
-			RT_TRACE(rtlpriv, COMP_INTR, DBG_TRACE,
+			RT_DEBUG(rtlpriv, COMP_INTR, DBG_TRACE,
 				 "hsisr interrupt!\n");
 			_rtl_pci_hs_interrupt(hw);
 		}
@@ -1251,7 +1251,7 @@ static int _rtl_pci_init_tx_ring(struct ieee80211_hw *hw,
 	rtlpci->tx_ring[prio].entries = entries;
 	skb_queue_head_init(&rtlpci->tx_ring[prio].queue);
 
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD, "queue:%d, ring_addr:%p\n",
+	RT_DEBUG(rtlpriv, COMP_INIT, DBG_LOUD, "queue:%d, ring_addr:%p\n",
 		 prio, desc);
 
 	/* init every desc in this ring */
@@ -1649,7 +1649,7 @@ static int rtl_pci_tx(struct ieee80211_hw *hw,
 				true, HW_DESC_OWN);
 
 		if (own == 1 && hw_queue != BEACON_QUEUE) {
-			RT_TRACE(rtlpriv, COMP_ERR, DBG_WARNING,
+			RT_DEBUG(rtlpriv, COMP_ERR, DBG_WARNING,
 				 "No more TX desc@%d, ring->idx = %d, idx = %d, skb_queue_len = 0x%x\n",
 				 hw_queue, ring->idx, idx,
 				 skb_queue_len(&ring->queue));
@@ -1662,7 +1662,7 @@ static int rtl_pci_tx(struct ieee80211_hw *hw,
 
 	if (rtlpriv->cfg->ops->get_available_desc &&
 	    rtlpriv->cfg->ops->get_available_desc(hw, hw_queue) == 0) {
-		RT_TRACE(rtlpriv, COMP_ERR, DBG_WARNING,
+		RT_DEBUG(rtlpriv, COMP_ERR, DBG_WARNING,
 			 "get_available_desc fail\n");
 		spin_unlock_irqrestore(&rtlpriv->locks.irq_th_lock, flags);
 		return skb->len;
@@ -1686,7 +1686,7 @@ static int rtl_pci_tx(struct ieee80211_hw *hw,
 
 	if ((ring->entries - skb_queue_len(&ring->queue)) < 2 &&
 	    hw_queue != BEACON_QUEUE) {
-		RT_TRACE(rtlpriv, COMP_ERR, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_ERR, DBG_LOUD,
 			 "less desc left, stop skb_queue@%d, ring->idx = %d, idx = %d, skb_queue_len = 0x%x\n",
 			 hw_queue, ring->idx, idx,
 			 skb_queue_len(&ring->queue));
@@ -1794,7 +1794,7 @@ static int rtl_pci_start(struct ieee80211_hw *hw)
 
 	err = rtlpriv->cfg->ops->hw_init(hw);
 	if (err) {
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_DMESG,
+		RT_DEBUG(rtlpriv, COMP_INIT, DBG_DMESG,
 			 "Failed to config hardware!\n");
 		kfree(rtlpriv->btcoexist.btc_context);
 		kfree(rtlpriv->btcoexist.wifi_only_context);
@@ -1804,7 +1804,7 @@ static int rtl_pci_start(struct ieee80211_hw *hw)
 			&rtlmac->retry_long);
 
 	rtlpriv->cfg->ops->enable_interrupt(hw);
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD, "enable_interrupt OK\n");
+	RT_DEBUG(rtlpriv, COMP_INIT, DBG_LOUD, "enable_interrupt OK\n");
 
 	rtl_init_rx_config(hw);
 
@@ -1815,7 +1815,7 @@ static int rtl_pci_start(struct ieee80211_hw *hw)
 
 	rtlpci->up_first_time = false;
 
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_DMESG, "%s OK\n", __func__);
+	RT_DEBUG(rtlpriv, COMP_INIT, DBG_DMESG, "%s OK\n", __func__);
 	return 0;
 }
 
@@ -1909,19 +1909,19 @@ static bool _rtl_pci_find_adapter(struct pci_dev *pdev,
 	    deviceid == RTL_PCI_8171_DID) {
 		switch (revisionid) {
 		case RTL_PCI_REVISION_ID_8192PCIE:
-			RT_TRACE(rtlpriv, COMP_INIT, DBG_DMESG,
+			RT_DEBUG(rtlpriv, COMP_INIT, DBG_DMESG,
 				 "8192 PCI-E is found - vid/did=%x/%x\n",
 				 venderid, deviceid);
 			rtlhal->hw_type = HARDWARE_TYPE_RTL8192E;
 			return false;
 		case RTL_PCI_REVISION_ID_8192SE:
-			RT_TRACE(rtlpriv, COMP_INIT, DBG_DMESG,
+			RT_DEBUG(rtlpriv, COMP_INIT, DBG_DMESG,
 				 "8192SE is found - vid/did=%x/%x\n",
 				 venderid, deviceid);
 			rtlhal->hw_type = HARDWARE_TYPE_RTL8192SE;
 			break;
 		default:
-			RT_TRACE(rtlpriv, COMP_ERR, DBG_WARNING,
+			RT_DEBUG(rtlpriv, COMP_ERR, DBG_WARNING,
 				 "Err: Unknown device - vid/did=%x/%x\n",
 				 venderid, deviceid);
 			rtlhal->hw_type = HARDWARE_TYPE_RTL8192SE;
@@ -1929,7 +1929,7 @@ static bool _rtl_pci_find_adapter(struct pci_dev *pdev,
 		}
 	} else if (deviceid == RTL_PCI_8723AE_DID) {
 		rtlhal->hw_type = HARDWARE_TYPE_RTL8723AE;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_DMESG,
+		RT_DEBUG(rtlpriv, COMP_INIT, DBG_DMESG,
 			 "8723AE PCI-E is found - vid/did=%x/%x\n",
 			 venderid, deviceid);
 	} else if (deviceid == RTL_PCI_8192CET_DID ||
@@ -1937,42 +1937,42 @@ static bool _rtl_pci_find_adapter(struct pci_dev *pdev,
 		   deviceid == RTL_PCI_8191CE_DID ||
 		   deviceid == RTL_PCI_8188CE_DID) {
 		rtlhal->hw_type = HARDWARE_TYPE_RTL8192CE;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_DMESG,
+		RT_DEBUG(rtlpriv, COMP_INIT, DBG_DMESG,
 			 "8192C PCI-E is found - vid/did=%x/%x\n",
 			 venderid, deviceid);
 	} else if (deviceid == RTL_PCI_8192DE_DID ||
 		   deviceid == RTL_PCI_8192DE_DID2) {
 		rtlhal->hw_type = HARDWARE_TYPE_RTL8192DE;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_DMESG,
+		RT_DEBUG(rtlpriv, COMP_INIT, DBG_DMESG,
 			 "8192D PCI-E is found - vid/did=%x/%x\n",
 			 venderid, deviceid);
 	} else if (deviceid == RTL_PCI_8188EE_DID) {
 		rtlhal->hw_type = HARDWARE_TYPE_RTL8188EE;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_INIT, DBG_LOUD,
 			 "Find adapter, Hardware type is 8188EE\n");
 	} else if (deviceid == RTL_PCI_8723BE_DID) {
 		rtlhal->hw_type = HARDWARE_TYPE_RTL8723BE;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_INIT, DBG_LOUD,
 			 "Find adapter, Hardware type is 8723BE\n");
 	} else if (deviceid == RTL_PCI_8192EE_DID) {
 		rtlhal->hw_type = HARDWARE_TYPE_RTL8192EE;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_INIT, DBG_LOUD,
 			 "Find adapter, Hardware type is 8192EE\n");
 	} else if (deviceid == RTL_PCI_8821AE_DID) {
 		rtlhal->hw_type = HARDWARE_TYPE_RTL8821AE;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_INIT, DBG_LOUD,
 			 "Find adapter, Hardware type is 8821AE\n");
 	} else if (deviceid == RTL_PCI_8812AE_DID) {
 		rtlhal->hw_type = HARDWARE_TYPE_RTL8812AE;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_INIT, DBG_LOUD,
 			 "Find adapter, Hardware type is 8812AE\n");
 	} else if (deviceid == RTL_PCI_8822BE_DID) {
 		rtlhal->hw_type = HARDWARE_TYPE_RTL8822BE;
 		rtlhal->bandset = BAND_ON_BOTH;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_INIT, DBG_LOUD,
 			 "Find adapter, Hardware type is 8822BE\n");
 	} else {
-		RT_TRACE(rtlpriv, COMP_ERR, DBG_WARNING,
+		RT_DEBUG(rtlpriv, COMP_ERR, DBG_WARNING,
 			 "Err: Unknown device - vid/did=%x/%x\n",
 			 venderid, deviceid);
 
@@ -1982,16 +1982,16 @@ static bool _rtl_pci_find_adapter(struct pci_dev *pdev,
 	if (rtlhal->hw_type == HARDWARE_TYPE_RTL8192DE) {
 		if (revisionid == 0 || revisionid == 1) {
 			if (revisionid == 0) {
-				RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
+				RT_DEBUG(rtlpriv, COMP_INIT, DBG_LOUD,
 					 "Find 92DE MAC0\n");
 				rtlhal->interfaceindex = 0;
 			} else if (revisionid == 1) {
-				RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
+				RT_DEBUG(rtlpriv, COMP_INIT, DBG_LOUD,
 					 "Find 92DE MAC1\n");
 				rtlhal->interfaceindex = 1;
 			}
 		} else {
-			RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_INIT, DBG_LOUD,
 				 "Unknown device - VendorID/DeviceID=%x/%x, Revision=%x\n",
 				 venderid, deviceid, revisionid);
 			rtlhal->interfaceindex = 0;
@@ -2026,7 +2026,7 @@ static bool _rtl_pci_find_adapter(struct pci_dev *pdev,
 		for (tmp = 0; tmp < PCI_BRIDGE_VENDOR_MAX; tmp++) {
 			if (bridge_pdev->vendor == pcibridge_vendors[tmp]) {
 				pcipriv->ndis_adapter.pcibridge_vendor = tmp;
-				RT_TRACE(rtlpriv, COMP_INIT, DBG_DMESG,
+				RT_DEBUG(rtlpriv, COMP_INIT, DBG_DMESG,
 					 "Pci Bridge Vendor is found index: %d\n",
 					 tmp);
 				break;
@@ -2056,14 +2056,14 @@ static bool _rtl_pci_find_adapter(struct pci_dev *pdev,
 		}
 	}
 
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_DMESG,
+	RT_DEBUG(rtlpriv, COMP_INIT, DBG_DMESG,
 		 "pcidev busnumber:devnumber:funcnumber:vendor:link_ctl %d:%d:%d:%x:%x\n",
 		 pcipriv->ndis_adapter.busnumber,
 		 pcipriv->ndis_adapter.devnumber,
 		 pcipriv->ndis_adapter.funcnumber,
 		 pdev->vendor, pcipriv->ndis_adapter.linkctrl_reg);
 
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_DMESG,
+	RT_DEBUG(rtlpriv, COMP_INIT, DBG_DMESG,
 		 "pci_bridge busnumber:devnumber:funcnumber:vendor:pcie_cap:link_ctl_reg:amd %d:%d:%d:%x:%x:%x:%x\n",
 		 pcipriv->ndis_adapter.pcibridge_busnum,
 		 pcipriv->ndis_adapter.pcibridge_devnum,
@@ -2099,7 +2099,7 @@ static int rtl_pci_intr_mode_msi(struct ieee80211_hw *hw)
 
 	rtlpci->using_msi = true;
 
-	RT_TRACE(rtlpriv, COMP_INIT | COMP_INTR, DBG_DMESG,
+	RT_DEBUG(rtlpriv, COMP_INIT | COMP_INTR, DBG_DMESG,
 		 "MSI Interrupt Mode!\n");
 	return 0;
 }
@@ -2117,7 +2117,7 @@ static int rtl_pci_intr_mode_legacy(struct ieee80211_hw *hw)
 		return ret;
 
 	rtlpci->using_msi = false;
-	RT_TRACE(rtlpriv, COMP_INIT | COMP_INTR, DBG_DMESG,
+	RT_DEBUG(rtlpriv, COMP_INIT | COMP_INTR, DBG_DMESG,
 		 "Pin-based Interrupt Mode!\n");
 	return 0;
 }
@@ -2245,7 +2245,7 @@ int rtl_pci_probe(struct pci_dev *pdev,
 		goto fail2;
 	}
 
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_DMESG,
+	RT_DEBUG(rtlpriv, COMP_INIT, DBG_DMESG,
 		 "mem mapped space: start: 0x%08lx len:%08lx flags:%08lx, after map:0x%08lx\n",
 		 pmem_start, pmem_len, pmem_flags,
 		 rtlpriv->io.pci_mem_start);
@@ -2310,7 +2310,7 @@ int rtl_pci_probe(struct pci_dev *pdev,
 	rtlpci = rtl_pcidev(pcipriv);
 	err = rtl_pci_intr_mode_decide(hw);
 	if (err) {
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_DMESG,
+		RT_DEBUG(rtlpriv, COMP_INIT, DBG_DMESG,
 			 "%s: failed to register IRQ handler\n",
 			 wiphy_name(hw->wiphy));
 		goto fail3;
diff --git a/drivers/net/wireless/realtek/rtlwifi/ps.c b/drivers/net/wireless/realtek/rtlwifi/ps.c
index bc0ac96ee615..90febe42298f 100644
--- a/drivers/net/wireless/realtek/rtlwifi/ps.c
+++ b/drivers/net/wireless/realtek/rtlwifi/ps.c
@@ -19,7 +19,7 @@ bool rtl_ps_enable_nic(struct ieee80211_hw *hw)
 		rtlpriv->intf_ops->reset_trx_ring(hw);
 
 	if (is_hal_stop(rtlhal))
-		RT_TRACE(rtlpriv, COMP_ERR, DBG_WARNING,
+		RT_DEBUG(rtlpriv, COMP_ERR, DBG_WARNING,
 			 "Driver is already down!\n");
 
 	/*<2> Enable Adapter */
@@ -80,7 +80,7 @@ static bool rtl_ps_set_rf_state(struct ieee80211_hw *hw,
 		if (ppsc->rfchange_inprogress) {
 			spin_unlock(&rtlpriv->locks.rf_ps_lock);
 
-			RT_TRACE(rtlpriv, COMP_ERR, DBG_WARNING,
+			RT_DEBUG(rtlpriv, COMP_ERR, DBG_WARNING,
 				 "RF Change in progress! Wait to set..state_toset(%d).\n",
 				  state_toset);
 
@@ -191,7 +191,7 @@ void rtl_ips_nic_off_wq_callback(void *data)
 	enum rf_pwrstate rtstate;
 
 	if (mac->opmode != NL80211_IFTYPE_STATION) {
-		RT_TRACE(rtlpriv, COMP_ERR, DBG_WARNING,
+		RT_DEBUG(rtlpriv, COMP_ERR, DBG_WARNING,
 			 "not station return\n");
 		return;
 	}
@@ -228,7 +228,7 @@ void rtl_ips_nic_off_wq_callback(void *data)
 		    !ppsc->swrf_processing &&
 		    (mac->link_state == MAC80211_NOLINK) &&
 		    !mac->act_scanning) {
-			RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE,
+			RT_DEBUG(rtlpriv, COMP_RF, DBG_TRACE,
 				 "IPSEnter(): Turn off RF\n");
 
 			ppsc->inactive_pwrstate = ERFOFF;
@@ -307,7 +307,7 @@ static bool rtl_get_fwlps_doze(struct ieee80211_hw *hw)
 				       ppsc->last_delaylps_stamp_jiffies);
 
 	if (ps_timediff < 2000) {
-		RT_TRACE(rtlpriv, COMP_POWER, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_POWER, DBG_LOUD,
 			 "Delay enter Fw LPS for DHCP, ARP, or EAPOL exchanging state\n");
 		return false;
 	}
@@ -353,7 +353,7 @@ void rtl_lps_set_psmode(struct ieee80211_hw *hw, u8 rt_psmode)
 
 	if ((ppsc->fwctrl_lps) && ppsc->report_linked) {
 		if (ppsc->dot11_psmode == EACTIVE) {
-			RT_TRACE(rtlpriv, COMP_RF, DBG_DMESG,
+			RT_DEBUG(rtlpriv, COMP_RF, DBG_DMESG,
 				 "FW LPS leave ps_mode:%x\n",
 				  FW_PS_ACTIVE_MODE);
 			enter_fwlps = false;
@@ -368,7 +368,7 @@ void rtl_lps_set_psmode(struct ieee80211_hw *hw, u8 rt_psmode)
 				rtlpriv->btcoexist.btc_ops->btc_lps_notify(rtlpriv, rt_psmode);
 		} else {
 			if (rtl_get_fwlps_doze(hw)) {
-				RT_TRACE(rtlpriv, COMP_RF, DBG_DMESG,
+				RT_DEBUG(rtlpriv, COMP_RF, DBG_DMESG,
 					 "FW LPS enter ps_mode:%x\n",
 					 ppsc->fwctrl_psmode);
 				if (rtlpriv->cfg->ops->get_btc_status())
@@ -420,7 +420,7 @@ static void rtl_lps_enter_core(struct ieee80211_hw *hw)
 	 * bt_ccoexist may ask to enter lps.
 	 * In normal case, this constraint move to rtl_lps_set_psmode().
 	 */
-	RT_TRACE(rtlpriv, COMP_POWER, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_POWER, DBG_LOUD,
 		 "Enter 802.11 power save mode...\n");
 	rtl_lps_set_psmode(hw, EAUTOPS);
 
@@ -449,7 +449,7 @@ static void rtl_lps_leave_core(struct ieee80211_hw *hw)
 				RT_CLEAR_PS_LEVEL(ppsc, RT_PS_LEVEL_ASPM);
 			}
 
-			RT_TRACE(rtlpriv, COMP_POWER, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_POWER, DBG_LOUD,
 				 "Busy Traffic,Leave 802.11 power save..\n");
 
 			rtl_lps_set_psmode(hw, EACTIVE);
@@ -534,7 +534,7 @@ void rtl_swlps_beacon(struct ieee80211_hw *hw, void *data, unsigned int len)
 		queue_delayed_work(rtlpriv->works.rtl_wq,
 				   &rtlpriv->works.ps_work, MSECS(5));
 	} else {
-		RT_TRACE(rtlpriv, COMP_POWER, DBG_DMESG,
+		RT_DEBUG(rtlpriv, COMP_POWER, DBG_DMESG,
 			 "u_bufferd: %x, m_buffered: %x\n", u_buffed, m_buffed);
 	}
 }
@@ -630,7 +630,7 @@ void rtl_swlps_rf_sleep(struct ieee80211_hw *hw)
 	/* this print should always be dtim_conter = 0 &
 	 * sleep  = dtim_period, that meaons, we should
 	 * awake before every dtim */
-	RT_TRACE(rtlpriv, COMP_POWER, DBG_DMESG,
+	RT_DEBUG(rtlpriv, COMP_POWER, DBG_DMESG,
 		 "dtim_counter:%x will sleep :%d beacon_intv\n",
 		  rtlpriv->psc.dtim_counter, sleep_intv);
 
@@ -744,7 +744,7 @@ static void rtl_p2p_noa_ie(struct ieee80211_hw *hw, void *data,
 		if (ie[0] == 12) {
 			find_p2p_ps_ie = true;
 			if ((noa_len - 2) % 13 != 0) {
-				RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
+				RT_DEBUG(rtlpriv, COMP_INIT, DBG_LOUD,
 					 "P2P notice of absence: invalid length.%d\n",
 					 noa_len);
 				return;
@@ -757,7 +757,7 @@ static void rtl_p2p_noa_ie(struct ieee80211_hw *hw, void *data,
 			noa_index = ie[3];
 			if (rtlpriv->psc.p2p_ps_info.p2p_ps_mode ==
 			    P2P_PS_NONE || noa_index != p2pinfo->noa_index) {
-				RT_TRACE(rtlpriv, COMP_FW, DBG_LOUD,
+				RT_DEBUG(rtlpriv, COMP_FW, DBG_LOUD,
 					 "update NOA ie.\n");
 				p2pinfo->noa_index = noa_index;
 				p2pinfo->opp_ps = (ie[4] >> 7);
@@ -829,7 +829,7 @@ static void rtl_p2p_action_ie(struct ieee80211_hw *hw, void *data,
 	if (ie == NULL)
 		return;
 
-	RT_TRACE(rtlpriv, COMP_FW, DBG_LOUD, "action frame find P2P IE.\n");
+	RT_DEBUG(rtlpriv, COMP_FW, DBG_LOUD, "action frame find P2P IE.\n");
 	/*to find noa ie*/
 	while (ie + 1 < end) {
 		noa_len = le16_to_cpu(*(__le16 *)&ie[1]);
@@ -837,11 +837,11 @@ static void rtl_p2p_action_ie(struct ieee80211_hw *hw, void *data,
 			return;
 
 		if (ie[0] == 12) {
-			RT_TRACE(rtlpriv, COMP_FW, DBG_LOUD, "find NOA IE.\n");
+			RT_DEBUG(rtlpriv, COMP_FW, DBG_LOUD, "find NOA IE.\n");
 			RT_PRINT_DATA(rtlpriv, COMP_FW, DBG_LOUD, "noa ie ",
 				      ie, noa_len);
 			if ((noa_len - 2) % 13 != 0) {
-				RT_TRACE(rtlpriv, COMP_FW, DBG_LOUD,
+				RT_DEBUG(rtlpriv, COMP_FW, DBG_LOUD,
 					 "P2P notice of absence: invalid length.%d\n",
 					 noa_len);
 				return;
@@ -901,7 +901,7 @@ void rtl_p2p_ps_cmd(struct ieee80211_hw *hw , u8 p2p_ps_state)
 	struct rtl_ps_ctl *rtlps = rtl_psc(rtl_priv(hw));
 	struct rtl_p2p_ps_info  *p2pinfo = &(rtlpriv->psc.p2p_ps_info);
 
-	RT_TRACE(rtlpriv, COMP_FW, DBG_LOUD, " p2p state %x\n" , p2p_ps_state);
+	RT_DEBUG(rtlpriv, COMP_FW, DBG_LOUD, " p2p state %x\n" , p2p_ps_state);
 	switch (p2p_ps_state) {
 	case P2P_PS_DISABLE:
 		p2pinfo->p2p_ps_state = p2p_ps_state;
@@ -953,10 +953,10 @@ void rtl_p2p_ps_cmd(struct ieee80211_hw *hw , u8 p2p_ps_state)
 	default:
 		break;
 	}
-	RT_TRACE(rtlpriv, COMP_FW, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_FW, DBG_LOUD,
 		 "ctwindow %x oppps %x\n",
 		 p2pinfo->ctwindow , p2pinfo->opp_ps);
-	RT_TRACE(rtlpriv, COMP_FW, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_FW, DBG_LOUD,
 		 "count %x duration %x index %x interval %x start time %x noa num %x\n",
 		 p2pinfo->noa_count_type[0],
 		 p2pinfo->noa_duration[0],
@@ -964,7 +964,7 @@ void rtl_p2p_ps_cmd(struct ieee80211_hw *hw , u8 p2p_ps_state)
 		 p2pinfo->noa_interval[0],
 		 p2pinfo->noa_start_time[0],
 		 p2pinfo->noa_num);
-	RT_TRACE(rtlpriv, COMP_FW, DBG_LOUD, "end\n");
+	RT_DEBUG(rtlpriv, COMP_FW, DBG_LOUD, "end\n");
 }
 
 void rtl_p2p_info(struct ieee80211_hw *hw, void *data, unsigned int len)
diff --git a/drivers/net/wireless/realtek/rtlwifi/regd.c b/drivers/net/wireless/realtek/rtlwifi/regd.c
index 8be31e0ad878..f9a86b843c81 100644
--- a/drivers/net/wireless/realtek/rtlwifi/regd.c
+++ b/drivers/net/wireless/realtek/rtlwifi/regd.c
@@ -393,12 +393,12 @@ int rtl_regd_init(struct ieee80211_hw *hw,
 	rtlpriv->regd.country_code =
 		channel_plan_to_country_code(rtlpriv->efuse.channel_plan);
 
-	RT_TRACE(rtlpriv, COMP_REGD, DBG_DMESG,
+	RT_DEBUG(rtlpriv, COMP_REGD, DBG_DMESG,
 		 "rtl: EEPROM regdomain: 0x%0x country code: %d\n",
 		 rtlpriv->efuse.channel_plan, rtlpriv->regd.country_code);
 
 	if (rtlpriv->regd.country_code >= COUNTRY_CODE_MAX) {
-		RT_TRACE(rtlpriv, COMP_REGD, DBG_DMESG,
+		RT_DEBUG(rtlpriv, COMP_REGD, DBG_DMESG,
 			 "rtl: EEPROM indicates invalid country code, world wide 13 should be used\n");
 
 		rtlpriv->regd.country_code = COUNTRY_CODE_WORLD_WIDE_13;
@@ -414,7 +414,7 @@ int rtl_regd_init(struct ieee80211_hw *hw,
 		rtlpriv->regd.alpha2[1] = '0';
 	}
 
-	RT_TRACE(rtlpriv, COMP_REGD, DBG_TRACE,
+	RT_DEBUG(rtlpriv, COMP_REGD, DBG_TRACE,
 		 "rtl: Country alpha2 being used: %c%c\n",
 		  rtlpriv->regd.alpha2[0], rtlpriv->regd.alpha2[1]);
 
@@ -428,7 +428,7 @@ void rtl_reg_notifier(struct wiphy *wiphy, struct regulatory_request *request)
 	struct ieee80211_hw *hw = wiphy_to_ieee80211_hw(wiphy);
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 
-	RT_TRACE(rtlpriv, COMP_REGD, DBG_LOUD, "\n");
+	RT_DEBUG(rtlpriv, COMP_REGD, DBG_LOUD, "\n");
 
 	_rtl_reg_notifier_apply(wiphy, request, &rtlpriv->regd);
 }
diff --git a/drivers/net/wireless/realtek/rtlwifi/usb.c b/drivers/net/wireless/realtek/rtlwifi/usb.c
index c66c6dc00378..256c364de32b 100644
--- a/drivers/net/wireless/realtek/rtlwifi/usb.c
+++ b/drivers/net/wireless/realtek/rtlwifi/usb.c
@@ -259,14 +259,14 @@ static int _rtl_usb_init_tx(struct ieee80211_hw *hw)
 						    ? USB_HIGH_SPEED_BULK_SIZE
 						    : USB_FULL_SPEED_BULK_SIZE;
 
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_DMESG, "USB Max Bulk-out Size=%d\n",
+	RT_DEBUG(rtlpriv, COMP_INIT, DBG_DMESG, "USB Max Bulk-out Size=%d\n",
 		 rtlusb->max_bulk_out_size);
 
 	for (i = 0; i < __RTL_TXQ_NUM; i++) {
 		u32 ep_num = rtlusb->ep_map.ep_mapping[i];
 
 		if (!ep_num) {
-			RT_TRACE(rtlpriv, COMP_INIT, DBG_DMESG,
+			RT_DEBUG(rtlpriv, COMP_INIT, DBG_DMESG,
 				 "Invalid endpoint map setting!\n");
 			return -EINVAL;
 		}
@@ -337,7 +337,7 @@ static int _rtl_usb_init(struct ieee80211_hw *hw)
 		else if (usb_endpoint_dir_out(pep_desc))
 			rtlusb->out_ep_nums++;
 
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_DMESG,
+		RT_DEBUG(rtlpriv, COMP_INIT, DBG_DMESG,
 			 "USB EP(0x%02x), MaxPacketSize=%d, Interval=%d\n",
 			 pep_desc->bEndpointAddress, pep_desc->wMaxPacketSize,
 			 pep_desc->bInterval);
@@ -928,7 +928,7 @@ static void _rtl_usb_tx_preprocess(struct ieee80211_hw *hw,
 
 	memset(&tcb_desc, 0, sizeof(struct rtl_tcb_desc));
 	if (ieee80211_is_auth(fc)) {
-		RT_TRACE(rtlpriv, COMP_SEND, DBG_DMESG, "MAC80211_LINKING\n");
+		RT_DEBUG(rtlpriv, COMP_SEND, DBG_DMESG, "MAC80211_LINKING\n");
 	}
 
 	if (rtlpriv->psc.sw_ps_enabled) {
-- 
2.27.0

