Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83A7F487153
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jan 2022 04:43:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345872AbiAGDnC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 6 Jan 2022 22:43:02 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:51040 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345647AbiAGDnB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 6 Jan 2022 22:43:01 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 2073gvm07022872, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 2073gvm07022872
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 7 Jan 2022 11:42:57 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 7 Jan 2022 11:42:57 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Fri, 7 Jan
 2022 11:42:56 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 02/19] rtw89: use hardware SSN to TX management frame
Date:   Fri, 7 Jan 2022 11:42:22 +0800
Message-ID: <20220107034239.22002-3-pkshih@realtek.com>
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

Since firmware transmits beacon by hardware SSN, driver does it with the
same setting, then packets in the air have continual sequence number.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c | 6 +++++-
 drivers/net/wireless/realtek/rtw89/core.h | 4 ++++
 drivers/net/wireless/realtek/rtw89/txrx.h | 2 ++
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 3d1c4c3b4dcb1..7c5e9bc309706 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -383,6 +383,8 @@ rtw89_core_tx_update_mgmt_info(struct rtw89_dev *rtwdev,
 
 	desc_info->qsel = RTW89_TX_QSEL_B0_MGMT;
 	desc_info->ch_dma = ch_dma;
+	desc_info->hw_ssn_sel = RTW89_MGMT_HW_SSN_SEL;
+	desc_info->hw_seq_mode = RTW89_MGMT_HW_SEQ_MODE;
 
 	/* fixed data rate for mgmt frames */
 	desc_info->en_wd_info = true;
@@ -708,7 +710,9 @@ static __le32 rtw89_build_txwd_body0(struct rtw89_tx_desc_info *desc_info)
 		    FIELD_PREP(RTW89_TXWD_BODY0_CHANNEL_DMA, desc_info->ch_dma) |
 		    FIELD_PREP(RTW89_TXWD_BODY0_HDR_LLC_LEN, desc_info->hdr_llc_len) |
 		    FIELD_PREP(RTW89_TXWD_BODY0_WD_PAGE, desc_info->wd_page) |
-		    FIELD_PREP(RTW89_TXWD_BODY0_FW_DL, desc_info->fw_dl);
+		    FIELD_PREP(RTW89_TXWD_BODY0_FW_DL, desc_info->fw_dl) |
+		    FIELD_PREP(RTW89_TXWD_BODY0_HW_SSN_SEL, desc_info->hw_ssn_sel) |
+		    FIELD_PREP(RTW89_TXWD_BODY0_HW_SSN_MODE, desc_info->hw_seq_mode);
 
 	return cpu_to_le32(dword);
 }
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index afadfc5349d35..defa0ceebc20e 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -691,6 +691,10 @@ struct rtw89_tx_desc_info {
 	bool fw_dl;
 	u16 seq;
 	bool a_ctrl_bsr;
+	u8 hw_ssn_sel;
+#define RTW89_MGMT_HW_SSN_SEL	1
+	u8 hw_seq_mode;
+#define RTW89_MGMT_HW_SEQ_MODE	1
 };
 
 struct rtw89_core_tx_request {
diff --git a/drivers/net/wireless/realtek/rtw89/txrx.h b/drivers/net/wireless/realtek/rtw89/txrx.h
index 75b11249f3065..fb92973e96c66 100644
--- a/drivers/net/wireless/realtek/rtw89/txrx.h
+++ b/drivers/net/wireless/realtek/rtw89/txrx.h
@@ -31,6 +31,8 @@
 #define RTW89_TXWD_BODY0_HDR_LLC_LEN GENMASK(15, 11)
 #define RTW89_TXWD_BODY0_WD_PAGE BIT(7)
 #define RTW89_TXWD_BODY0_HW_AMSDU BIT(5)
+#define RTW89_TXWD_BODY0_HW_SSN_SEL GENMASK(3, 2)
+#define RTW89_TXWD_BODY0_HW_SSN_MODE GENMASK(1, 0)
 
 /* TX WD BODY DWORD 1 */
 #define RTW89_TXWD_BODY1_PAYLOAD_ID GENMASK(31, 16)
-- 
2.25.1

