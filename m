Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50113A45BB
	for <lists+linux-wireless@lfdr.de>; Sat, 31 Aug 2019 20:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728525AbfHaSHF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 31 Aug 2019 14:07:05 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:43237 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728519AbfHaSHF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 31 Aug 2019 14:07:05 -0400
Received: by mail-oi1-f195.google.com with SMTP id y8so7764133oih.10
        for <linux-wireless@vger.kernel.org>; Sat, 31 Aug 2019 11:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=h9vkFSIyZKr/2ZT3potH3SV9JMxBedNQOEGKRc6BAO0=;
        b=ql6Wt/+TF2BCuBVoVtDSttrpQp3OPGa8mBNekdSqBe5cKYok1EbRNu22gHmvEEKWrU
         Kx/eBO43BW4UxvtODtbQkf4WiFr4zM0RyCHvJ7iTvgOwuLQn7YbphNa0W7/vNP5XqLsg
         hyZWYo2jVJSABxNKYr1WkXG3DJ3XN7c+5StrW2ZvrnGRVVpnHAcf6Fi0XJZwYQdIodIl
         E6VnPyI4hAC/2Av00X54zLaYVsVD9ygZwoiUtSBG71ED+e894OOmIzZfXYVanVJ7SUJx
         fX9MkNRc8JXh01n4IvUToqNbUtEFBLuLNriGTdNA1iFu39IKyuRUab7Kfb/RCV4xdkTE
         rIRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=h9vkFSIyZKr/2ZT3potH3SV9JMxBedNQOEGKRc6BAO0=;
        b=DPbnEPRHQQh/6PclYBeemkfdBsOIv35hWk+ifF3iI02aM7AJO4eAslQbpNJf9Swbfr
         CnSPfRxLJmBB6mrGrleRViX1UKXHKdR6IKaP6LhxT6JAAsj9rV9Mi0BPa6DIz/PXyxfQ
         O+4d7HdgxiKde5aOFhTo2uFjeZqCUHXG1lwNtN6rDw5U3qYm5ofUU+Kc6xYT7gsK2gGG
         ccDEFRXg16NgPVx6IZtm09yz461h33VMCv2rVCbKUU8x52K815WpQnuZyFsI58MYIMoM
         cm7MXt8chiuUF7ai1eCLzeWNWj0T91BFNvIm8zRCNkKHRI6jNAJNB3419KyfO2smLH4I
         iVsw==
X-Gm-Message-State: APjAAAVvxHNSTXxyTWWstAYIoYYA454x8fl7Ic1JqeLBKd558XoQ6FMF
        vvBV+IuvInfO1IsaPsBhm8I=
X-Google-Smtp-Source: APXvYqxt+se0BXKseY/OBlV8aGkAyCLs1ir/Y69lPcZUjKNrvQVV9Ze/+LTnxDeoB4TOsmMjPSPt1Q==
X-Received: by 2002:aca:f4ca:: with SMTP id s193mr13676046oih.131.1567274823935;
        Sat, 31 Aug 2019 11:07:03 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id c11sm3222346otr.54.2019.08.31.11.07.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 31 Aug 2019 11:07:03 -0700 (PDT)
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, pkshih@realtek.com,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH 5/5] rtlwifi: rtl8192ee: Remove some variable initializations
Date:   Sat, 31 Aug 2019 13:06:44 -0500
Message-Id: <20190831180644.7937-6-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190831180644.7937-1-Larry.Finger@lwfinger.net>
References: <20190831180644.7937-1-Larry.Finger@lwfinger.net>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

A number of variables are initialized when declared that set later in the
routine, thus the initialization can be removed.

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
---
 .../net/wireless/realtek/rtlwifi/rtl8192ee/trx.c   | 26 ++++++++++++----------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/trx.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/trx.c
index 0706888fe3de..27f1a631b569 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/trx.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/trx.c
@@ -34,7 +34,7 @@ static void _rtl92ee_query_rxphystatus(struct ieee80211_hw *hw,
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	struct phy_status_rpt *p_phystrpt = (struct phy_status_rpt *)p_drvinfo;
-	s8 rx_pwr_all = 0, rx_pwr[4];
+	s8 rx_pwr_all, rx_pwr[4];
 	u8 rf_rx_num = 0, evm, pwdb_all;
 	u8 i, max_spatial_stream;
 	u32 rssi, total_rssi = 0;
@@ -95,6 +95,7 @@ static void _rtl92ee_query_rxphystatus(struct ieee80211_hw *hw,
 				rx_pwr_all = 14 - 2 * vga_idx;
 				break;
 		default:
+				rx_pwr_all = 0;
 				break;
 		}
 		rx_pwr_all += 16;
@@ -273,7 +274,7 @@ static void _rtl92ee_translate_rx_signal_stuff(struct ieee80211_hw *hw,
 static void _rtl92ee_insert_emcontent(struct rtl_tcb_desc *ptcb_desc,
 				      u8 *virtualaddress8)
 {
-	u32 dwtmp = 0;
+	u32 dwtmp;
 	__le32 *virtualaddress = (__le32 *)virtualaddress8;
 
 	memset(virtualaddress, 0, 8);
@@ -458,8 +459,8 @@ u16 rtl92ee_rx_desc_buff_remained_cnt(struct ieee80211_hw *hw, u8 queue_index)
 {
 	struct rtl_pci *rtlpci = rtl_pcidev(rtl_pcipriv(hw));
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
-	u16 read_point = 0, write_point = 0, remind_cnt = 0;
-	u32 tmp_4byte = 0;
+	u16 read_point, write_point, remind_cnt;
+	u32 tmp_4byte;
 	static bool start_rx;
 
 	tmp_4byte = rtl_read_dword(rtlpriv, REG_RXQ_TXBD_IDX);
@@ -493,7 +494,7 @@ u16 rtl92ee_rx_desc_buff_remained_cnt(struct ieee80211_hw *hw, u8 queue_index)
 
 static u16 get_desc_addr_fr_q_idx(u16 queue_index)
 {
-	u16 desc_address = REG_BEQ_TXBD_IDX;
+	u16 desc_address;
 
 	switch (queue_index) {
 	case BK_QUEUE:
@@ -524,6 +525,7 @@ static u16 get_desc_addr_fr_q_idx(u16 queue_index)
 		desc_address = REG_BEQ_TXBD_IDX;
 		break;
 	default:
+		desc_address = REG_BEQ_TXBD_IDX;
 		break;
 	}
 	return desc_address;
@@ -533,7 +535,7 @@ u16 rtl92ee_get_available_desc(struct ieee80211_hw *hw, u8 q_idx)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	u16 point_diff = 0;
-	u16 current_tx_read_point = 0, current_tx_write_point = 0;
+	u16 current_tx_read_point, current_tx_write_point;
 	u32 tmp_4byte;
 
 	tmp_4byte = rtl_read_dword(rtlpriv,
@@ -557,10 +559,10 @@ void rtl92ee_pre_fill_tx_bd_desc(struct ieee80211_hw *hw,
 	u32 pkt_len = skb->len;
 	u16 desc_size = 40; /*tx desc size*/
 	u32 psblen = 0;
-	u16 tx_page_size = 0;
-	u32 total_packet_size = 0;
+	u16 tx_page_size;
+	u32 total_packet_size;
 	u16 current_bd_desc;
-	u8 i = 0;
+	u8 i;
 	u16 real_desc_size = 0x28;
 	u16	append_early_mode_size = 0;
 	u8 segmentnum = 1 << (RTL8192EE_SEG_NUM + 1);
@@ -649,7 +651,7 @@ void rtl92ee_tx_fill_desc(struct ieee80211_hw *hw,
 	struct rtlwifi_tx_info *tx_info = rtl_tx_skb_cb_info(skb);
 	u16 seq_number;
 	__le16 fc = hdr->frame_control;
-	unsigned int buf_len = 0;
+	unsigned int buf_len;
 	u8 fw_qsel = _rtl92ee_map_hwqueue_to_fwqueue(skb, hw_queue);
 	bool firstseg = ((hdr->seq_ctrl &
 			    cpu_to_le16(IEEE80211_SCTL_FRAG)) == 0);
@@ -657,7 +659,7 @@ void rtl92ee_tx_fill_desc(struct ieee80211_hw *hw,
 			   cpu_to_le16(IEEE80211_FCTL_MOREFRAGS)) == 0);
 	dma_addr_t mapping;
 	u8 bw_40 = 0;
-	u8 short_gi = 0;
+	u8 short_gi;
 	__le32 *pdesc = (__le32 *)pdesc8;
 
 	if (mac->opmode == NL80211_IFTYPE_STATION) {
@@ -1009,7 +1011,7 @@ bool rtl92ee_is_tx_desc_closed(struct ieee80211_hw *hw, u8 hw_queue, u16 index)
 
 	{
 		u16 cur_tx_rp, cur_tx_wp;
-		u32 tmpu32 = 0;
+		u32 tmpu32;
 
 		tmpu32 =
 		  rtl_read_dword(rtlpriv,
-- 
2.16.4

