Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F83C48715E
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jan 2022 04:43:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345904AbiAGDnV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 6 Jan 2022 22:43:21 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:51097 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345890AbiAGDnU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 6 Jan 2022 22:43:20 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 2073hGaM5022977, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 2073hGaM5022977
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 7 Jan 2022 11:43:16 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 7 Jan 2022 11:43:15 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Fri, 7 Jan
 2022 11:43:15 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 11/19] rtw89: set mac_id and port ID to TXWD
Date:   Fri, 7 Jan 2022 11:42:31 +0800
Message-ID: <20220107034239.22002-12-pkshih@realtek.com>
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
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

One mac_id is corresponding to one connected station, and port ID is a
ID of virtual interfaces. With proper mac_id and port ID, firmware and
hardware can handle a packet with correct context.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c | 26 +++++++++++++++++++++--
 drivers/net/wireless/realtek/rtw89/core.h |  2 ++
 drivers/net/wireless/realtek/rtw89/txrx.h |  1 +
 3 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 50bbc93196085..8f8891badf0e8 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -375,6 +375,8 @@ static void
 rtw89_core_tx_update_mgmt_info(struct rtw89_dev *rtwdev,
 			       struct rtw89_core_tx_request *tx_req)
 {
+	struct ieee80211_vif *vif = tx_req->vif;
+	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
 	struct rtw89_tx_desc_info *desc_info = &tx_req->desc_info;
 	u8 qsel, ch_dma;
 
@@ -383,6 +385,7 @@ rtw89_core_tx_update_mgmt_info(struct rtw89_dev *rtwdev,
 
 	desc_info->qsel = qsel;
 	desc_info->ch_dma = ch_dma;
+	desc_info->port = desc_info->hiq ? rtwvif->port : 0;
 	desc_info->hw_ssn_sel = RTW89_MGMT_HW_SSN_SEL;
 	desc_info->hw_seq_mode = RTW89_MGMT_HW_SEQ_MODE;
 
@@ -520,6 +523,21 @@ rtw89_core_tx_update_he_qos_htc(struct rtw89_dev *rtwdev,
 	desc_info->bk = true;
 }
 
+static u8 rtw89_core_tx_get_mac_id(struct rtw89_dev *rtwdev,
+				   struct rtw89_core_tx_request *tx_req)
+{
+	struct ieee80211_vif *vif = tx_req->vif;
+	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
+	struct ieee80211_sta *sta = tx_req->sta;
+	struct rtw89_sta *rtwsta;
+
+	if (!sta)
+		return rtwvif->mac_id;
+
+	rtwsta = (struct rtw89_sta *)sta->drv_priv;
+	return rtwsta->mac_id;
+}
+
 static void
 rtw89_core_tx_update_data_info(struct rtw89_dev *rtwdev,
 			       struct rtw89_core_tx_request *tx_req)
@@ -541,6 +559,8 @@ rtw89_core_tx_update_data_info(struct rtw89_dev *rtwdev,
 	desc_info->ch_dma = ch_dma;
 	desc_info->tid_indicate = tid_indicate;
 	desc_info->qsel = qsel;
+	desc_info->mac_id = rtw89_core_tx_get_mac_id(rtwdev, tx_req);
+	desc_info->port = desc_info->hiq ? rtwvif->port : 0;
 
 	/* enable wd_info for AMPDU */
 	desc_info->en_wd_info = true;
@@ -723,7 +743,8 @@ static __le32 rtw89_build_txwd_body2(struct rtw89_tx_desc_info *desc_info)
 {
 	u32 dword = FIELD_PREP(RTW89_TXWD_BODY2_TID_INDICATE, desc_info->tid_indicate) |
 		    FIELD_PREP(RTW89_TXWD_BODY2_QSEL, desc_info->qsel) |
-		    FIELD_PREP(RTW89_TXWD_BODY2_TXPKT_SIZE, desc_info->pkt_size);
+		    FIELD_PREP(RTW89_TXWD_BODY2_TXPKT_SIZE, desc_info->pkt_size) |
+		    FIELD_PREP(RTW89_TXWD_BODY2_MACID, desc_info->mac_id);
 
 	return cpu_to_le32(dword);
 }
@@ -741,7 +762,8 @@ static __le32 rtw89_build_txwd_info0(struct rtw89_tx_desc_info *desc_info)
 {
 	u32 dword = FIELD_PREP(RTW89_TXWD_INFO0_USE_RATE, desc_info->use_rate) |
 		    FIELD_PREP(RTW89_TXWD_INFO0_DATA_RATE, desc_info->data_rate) |
-		    FIELD_PREP(RTW89_TXWD_INFO0_DISDATAFB, desc_info->dis_data_fb);
+		    FIELD_PREP(RTW89_TXWD_INFO0_DISDATAFB, desc_info->dis_data_fb) |
+		    FIELD_PREP(RTW89_TXWD_INFO0_MULTIPORT_ID, desc_info->port);
 
 	return cpu_to_le32(dword);
 }
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index cf795d2f14776..8cb907da6cb05 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -670,6 +670,7 @@ struct rtw89_rxdesc_long {
 struct rtw89_tx_desc_info {
 	u16 pkt_size;
 	u8 wp_offset;
+	u8 mac_id;
 	u8 qsel;
 	u8 ch_dma;
 	u8 hdr_llc_len;
@@ -696,6 +697,7 @@ struct rtw89_tx_desc_info {
 	u8 hw_seq_mode;
 #define RTW89_MGMT_HW_SEQ_MODE	1
 	bool hiq;
+	u8 port;
 };
 
 struct rtw89_core_tx_request {
diff --git a/drivers/net/wireless/realtek/rtw89/txrx.h b/drivers/net/wireless/realtek/rtw89/txrx.h
index fb92973e96c66..86e3d8b400d6c 100644
--- a/drivers/net/wireless/realtek/rtw89/txrx.h
+++ b/drivers/net/wireless/realtek/rtw89/txrx.h
@@ -58,6 +58,7 @@
 #define RTW89_TXWD_INFO0_GI_LTF GENMASK(27, 25)
 #define RTW89_TXWD_INFO0_DATA_RATE GENMASK(24, 16)
 #define RTW89_TXWD_INFO0_DISDATAFB BIT(10)
+#define RTW89_TXWD_INFO0_MULTIPORT_ID GENMASK(6, 4)
 
 /* TX WD INFO DWORD 1 */
 #define RTW89_TXWD_INFO1_DATA_RTY_LOWEST_RATE GENMASK(24, 16)
-- 
2.25.1

