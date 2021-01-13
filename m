Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 528A82F4784
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Jan 2021 10:26:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbhAMJYu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Jan 2021 04:24:50 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:45136 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbhAMJYu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Jan 2021 04:24:50 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 10D9O3nS4010649, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmbs04.realtek.com.tw[172.21.6.97])
        by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 10D9O3nS4010649
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 13 Jan 2021 17:24:03 +0800
Received: from localhost (172.21.69.213) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Wed, 13 Jan
 2021 17:24:02 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <tony0620emma@gmail.com>, <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <phhuang@realtek.com>
Subject: [PATCH 2/5] rtw88: add rts condition
Date:   Wed, 13 Jan 2021 17:23:09 +0800
Message-ID: <20210113092312.13809-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210113092312.13809-1-pkshih@realtek.com>
References: <20210113092312.13809-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.213]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Po-Hao Huang <phhuang@realtek.com>

Since we set the IEEE80211_HW_HAS_RATE_CONTROL flag, so use_rts in
ieee80211_tx_info will never be set in the ieee80211_xmit_fast path.
Add length check for skb to decide whether rts is needed.

Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/tx.c | 7 ++++++-
 drivers/net/wireless/realtek/rtw88/tx.h | 4 ++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw88/tx.c b/drivers/net/wireless/realtek/rtw88/tx.c
index ca8072177ae3..0d755d9ff5f3 100644
--- a/drivers/net/wireless/realtek/rtw88/tx.c
+++ b/drivers/net/wireless/realtek/rtw88/tx.c
@@ -58,6 +58,10 @@ void rtw_tx_fill_tx_desc(struct rtw_tx_pkt_info *pkt_info, struct sk_buff *skb)
 	SET_TX_DESC_SPE_RPT(txdesc, pkt_info->report);
 	SET_TX_DESC_SW_DEFINE(txdesc, pkt_info->sn);
 	SET_TX_DESC_USE_RTS(txdesc, pkt_info->rts);
+	if (pkt_info->rts) {
+		SET_TX_DESC_RTSRATE(txdesc, DESC_RATE24M);
+		SET_TX_DESC_DATA_RTS_SHORT(txdesc, 1);
+	}
 	SET_TX_DESC_DISQSELSEQ(txdesc, pkt_info->dis_qselseq);
 	SET_TX_DESC_EN_HWSEQ(txdesc, pkt_info->en_hwseq);
 	SET_TX_DESC_HW_SSN_SEL(txdesc, pkt_info->hw_ssn_sel);
@@ -290,6 +294,7 @@ static void rtw_tx_data_pkt_info_update(struct rtw_dev *rtwdev,
 {
 	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
+	struct ieee80211_hw *hw = rtwdev->hw;
 	struct rtw_sta_info *si;
 	u16 seq;
 	u8 ampdu_factor = 0;
@@ -313,7 +318,7 @@ static void rtw_tx_data_pkt_info_update(struct rtw_dev *rtwdev,
 		ampdu_density = get_tx_ampdu_density(sta);
 	}
 
-	if (info->control.use_rts)
+	if (info->control.use_rts || skb->len > hw->wiphy->rts_threshold)
 		pkt_info->rts = true;
 
 	if (sta->vht_cap.vht_supported)
diff --git a/drivers/net/wireless/realtek/rtw88/tx.h b/drivers/net/wireless/realtek/rtw88/tx.h
index 6673dbcaa21c..022288c9b5fc 100644
--- a/drivers/net/wireless/realtek/rtw88/tx.h
+++ b/drivers/net/wireless/realtek/rtw88/tx.h
@@ -37,6 +37,10 @@
 	le32p_replace_bits((__le32 *)(txdesc) + 0x03, value, GENMASK(21, 17))
 #define SET_TX_DESC_USE_RTS(tx_desc, value)                                    \
 	le32p_replace_bits((__le32 *)(txdesc) + 0x03, value, BIT(12))
+#define SET_TX_DESC_RTSRATE(txdesc, value)                                     \
+	le32p_replace_bits((__le32 *)(txdesc) + 0x04, value, GENMASK(28, 24))
+#define SET_TX_DESC_DATA_RTS_SHORT(txdesc, value)                              \
+	le32p_replace_bits((__le32 *)(txdesc) + 0x05, value, BIT(12))
 #define SET_TX_DESC_AMPDU_DENSITY(txdesc, value)                               \
 	le32p_replace_bits((__le32 *)(txdesc) + 0x02, value, GENMASK(22, 20))
 #define SET_TX_DESC_DATA_STBC(txdesc, value)                                   \
-- 
2.21.0

