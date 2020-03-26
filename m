Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B21319358B
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2020 03:04:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727612AbgCZCEU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 25 Mar 2020 22:04:20 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:55649 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727598AbgCZCET (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 25 Mar 2020 22:04:19 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID 02Q24BI0018692, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTEXMB06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id 02Q24BI0018692
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Mar 2020 10:04:11 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 26 Mar 2020 10:04:11 +0800
Received: from localhost.localdomain (172.21.68.128) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 26 Mar 2020 10:04:10 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <tehuang@realtek.com>,
        <briannorris@chromium.org>
Subject: [PATCH] rtw88: fix non-increase management packet sequence number
Date:   Thu, 26 Mar 2020 10:04:08 +0800
Message-ID: <20200326020408.25218-1-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.128]
X-ClientProxiedBy: RTEXMB02.realtek.com.tw (172.21.6.95) To
 RTEXMB04.realtek.com.tw (172.21.6.97)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Tzu-En Huang <tehuang@realtek.com>

In previous setting, management packets' sequence numbers will
not increase and always stay at 0. Add hw sequence number support
for mgmt packets.
The table below shows different sequence number setting in the
tx descriptor.

seq num ctrl      | EN_HWSEQ | DISQSELSEL | HW_SSN_SEL
------------------------------------------------------
sw ctrl           |    0     |    N/A     |    N/A
hw ctrl per MACID |    1     |     0      |    N/A
hw ctrl per HWREG |    1     |     1      |HWREG(0/1/2/3)

Signed-off-by: Tzu-En Huang <tehuang@realtek.com>
Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/main.h | 3 +++
 drivers/net/wireless/realtek/rtw88/tx.c   | 6 ++++++
 drivers/net/wireless/realtek/rtw88/tx.h   | 6 ++++++
 3 files changed, 15 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index 279410a87141..138851a10051 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -562,6 +562,9 @@ struct rtw_tx_pkt_info {
 	bool short_gi;
 	bool report;
 	bool rts;
+	bool dis_qselseq;
+	bool en_hwseq;
+	u8 hw_ssn_sel;
 };
 
 struct rtw_rx_pkt_stat {
diff --git a/drivers/net/wireless/realtek/rtw88/tx.c b/drivers/net/wireless/realtek/rtw88/tx.c
index b31eb4d9664b..60989987f67b 100644
--- a/drivers/net/wireless/realtek/rtw88/tx.c
+++ b/drivers/net/wireless/realtek/rtw88/tx.c
@@ -58,6 +58,9 @@ void rtw_tx_fill_tx_desc(struct rtw_tx_pkt_info *pkt_info, struct sk_buff *skb)
 	SET_TX_DESC_SPE_RPT(txdesc, pkt_info->report);
 	SET_TX_DESC_SW_DEFINE(txdesc, pkt_info->sn);
 	SET_TX_DESC_USE_RTS(txdesc, pkt_info->rts);
+	SET_TX_DESC_DISQSELSEQ(txdesc, pkt_info->dis_qselseq);
+	SET_TX_DESC_EN_HWSEQ(txdesc, pkt_info->en_hwseq);
+	SET_TX_DESC_HW_SSN_SEL(txdesc, pkt_info->hw_ssn_sel);
 }
 EXPORT_SYMBOL(rtw_tx_fill_tx_desc);
 
@@ -227,6 +230,9 @@ static void rtw_tx_mgmt_pkt_info_update(struct rtw_dev *rtwdev,
 	pkt_info->use_rate = true;
 	pkt_info->rate_id = 6;
 	pkt_info->dis_rate_fallback = true;
+	pkt_info->dis_qselseq = true;
+	pkt_info->en_hwseq = true;
+	pkt_info->hw_ssn_sel = 0;
 }
 
 static void rtw_tx_data_pkt_info_update(struct rtw_dev *rtwdev,
diff --git a/drivers/net/wireless/realtek/rtw88/tx.h b/drivers/net/wireless/realtek/rtw88/tx.h
index e488a2643eb3..b973de0f4dc0 100644
--- a/drivers/net/wireless/realtek/rtw88/tx.h
+++ b/drivers/net/wireless/realtek/rtw88/tx.h
@@ -53,6 +53,12 @@
 	le32p_replace_bits((__le32 *)(txdesc) + 0x02, value, BIT(19))
 #define SET_TX_DESC_SW_DEFINE(tx_desc, value)                                  \
 	le32p_replace_bits((__le32 *)(txdesc) + 0x06, value, GENMASK(11, 0))
+#define SET_TX_DESC_DISQSELSEQ(txdesc, value)                                 \
+	le32p_replace_bits((__le32 *)(txdesc) + 0x00, value, BIT(31))
+#define SET_TX_DESC_EN_HWSEQ(txdesc, value)                                   \
+	le32p_replace_bits((__le32 *)(txdesc) + 0x08, value, BIT(15))
+#define SET_TX_DESC_HW_SSN_SEL(txdesc, value)                                 \
+	le32p_replace_bits((__le32 *)(txdesc) + 0x03, value, GENMASK(7, 6))
 
 enum rtw_tx_desc_queue_select {
 	TX_DESC_QSEL_TID0	= 0,
-- 
2.17.1

