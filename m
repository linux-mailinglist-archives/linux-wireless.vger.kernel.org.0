Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C289F48715D
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jan 2022 04:43:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345903AbiAGDnU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 6 Jan 2022 22:43:20 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:51093 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345898AbiAGDnS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 6 Jan 2022 22:43:18 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 2073hENE1022969, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 2073hENE1022969
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 7 Jan 2022 11:43:14 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 7 Jan 2022 11:43:14 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Fri, 7 Jan
 2022 11:43:13 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 10/19] rtw89: send broadcast/multicast packets via HIQ if STAs are in sleep mode
Date:   Fri, 7 Jan 2022 11:42:30 +0800
Message-ID: <20220107034239.22002-11-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220107034239.22002-1-pkshih@realtek.com>
References: <20220107034239.22002-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.188]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 01/07/2022 03:26:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzEvNyCkV6TIIDAxOjMzOjAw?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

If a packet we are going to send is broadcast/multicast and certain STAs
are in sleep mode, a flag IEEE80211_TX_CTL_SEND_AFTER_DTIM is added to
txinfo. Then, this kind of packets must be sent via HIQ instead of regular
AC queues, because they should be sent right after beacon.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c | 8 +++++---
 drivers/net/wireless/realtek/rtw89/core.h | 1 +
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 175d9924761c1..50bbc93196085 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -378,10 +378,10 @@ rtw89_core_tx_update_mgmt_info(struct rtw89_dev *rtwdev,
 	struct rtw89_tx_desc_info *desc_info = &tx_req->desc_info;
 	u8 qsel, ch_dma;
 
-	qsel = RTW89_TX_QSEL_B0_MGMT;
+	qsel = desc_info->hiq ? RTW89_TX_QSEL_B0_HI : RTW89_TX_QSEL_B0_MGMT;
 	ch_dma = rtw89_core_get_ch_dma(rtwdev, qsel);
 
-	desc_info->qsel = RTW89_TX_QSEL_B0_MGMT;
+	desc_info->qsel = qsel;
 	desc_info->ch_dma = ch_dma;
 	desc_info->hw_ssn_sel = RTW89_MGMT_HW_SSN_SEL;
 	desc_info->hw_seq_mode = RTW89_MGMT_HW_SEQ_MODE;
@@ -535,7 +535,7 @@ rtw89_core_tx_update_data_info(struct rtw89_dev *rtwdev,
 
 	tid = skb->priority & IEEE80211_QOS_CTL_TAG1D_MASK;
 	tid_indicate = rtw89_core_get_tid_indicate(rtwdev, tid);
-	qsel = rtw89_core_get_qsel(rtwdev, tid);
+	qsel = desc_info->hiq ? RTW89_TX_QSEL_B0_HI : rtw89_core_get_qsel(rtwdev, tid);
 	ch_dma = rtw89_core_get_ch_dma(rtwdev, qsel);
 
 	desc_info->ch_dma = ch_dma;
@@ -601,6 +601,7 @@ rtw89_core_tx_update_desc_info(struct rtw89_dev *rtwdev,
 {
 	struct rtw89_tx_desc_info *desc_info = &tx_req->desc_info;
 	struct sk_buff *skb = tx_req->skb;
+	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
 	struct ieee80211_hdr *hdr = (void *)skb->data;
 	enum rtw89_core_tx_type tx_type;
 	enum btc_pkt_type pkt_type;
@@ -619,6 +620,7 @@ rtw89_core_tx_update_desc_info(struct rtw89_dev *rtwdev,
 	desc_info->pkt_size = skb->len;
 	desc_info->is_bmc = is_bmc;
 	desc_info->wd_page = true;
+	desc_info->hiq = info->flags & IEEE80211_TX_CTL_SEND_AFTER_DTIM;
 
 	switch (tx_req->tx_type) {
 	case RTW89_CORE_TX_TYPE_MGMT:
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index ae8943d4fb43d..cf795d2f14776 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -695,6 +695,7 @@ struct rtw89_tx_desc_info {
 #define RTW89_MGMT_HW_SSN_SEL	1
 	u8 hw_seq_mode;
 #define RTW89_MGMT_HW_SEQ_MODE	1
+	bool hiq;
 };
 
 struct rtw89_core_tx_request {
-- 
2.25.1

