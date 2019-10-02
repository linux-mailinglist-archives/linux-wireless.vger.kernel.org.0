Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A23DC47D6
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Oct 2019 08:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbfJBGfu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Oct 2019 02:35:50 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:57715 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbfJBGfp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Oct 2019 02:35:45 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x926ZeLq013076, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x926ZeLq013076
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 2 Oct 2019 14:35:40 +0800
Received: from localhost.localdomain (172.21.68.126) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.468.0; Wed, 2 Oct 2019 14:35:40 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>
Subject: [PATCH 09/14] rtw88: Don't set RX_FLAG_DECRYPTED if packet has no encryption
Date:   Wed, 2 Oct 2019 14:35:26 +0800
Message-ID: <20191002063531.18135-10-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191002063531.18135-1-yhchuang@realtek.com>
References: <20191002063531.18135-1-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.126]
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ping-Ke Shih <pkshih@realtek.com>

The value of GET_RX_DESC_SWDEC() indicates that if this RX
packet requires software decryption or not. And software
decryption is required when the packet was encrypted and the
hardware failed to decrypt it.

So, GET_RX_DESC_SWDEC() is negative does not mean that this
packet is decrypted, it might just have no encryption at all.
To actually see if the packet is decrypted, driver needs to
further check if the hardware has successfully decrypted it,
with a specific type of encryption algorithm.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/rtw8822b.c |  3 ++-
 drivers/net/wireless/realtek/rtw88/rtw8822c.c |  3 ++-
 drivers/net/wireless/realtek/rtw88/rx.h       | 11 +++++++++++
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822b.c b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
index 2b6cd7cf763b..1e20c4465bc9 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822b.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
@@ -836,7 +836,8 @@ static void rtw8822b_query_rx_desc(struct rtw_dev *rtwdev, u8 *rx_desc,
 	pkt_stat->phy_status = GET_RX_DESC_PHYST(rx_desc);
 	pkt_stat->icv_err = GET_RX_DESC_ICV_ERR(rx_desc);
 	pkt_stat->crc_err = GET_RX_DESC_CRC32(rx_desc);
-	pkt_stat->decrypted = !GET_RX_DESC_SWDEC(rx_desc);
+	pkt_stat->decrypted = !GET_RX_DESC_SWDEC(rx_desc) &&
+			      GET_RX_DESC_ENC_TYPE(rx_desc) != RX_DESC_ENC_NONE;
 	pkt_stat->is_c2h = GET_RX_DESC_C2H(rx_desc);
 	pkt_stat->pkt_len = GET_RX_DESC_PKT_LEN(rx_desc);
 	pkt_stat->drv_info_sz = GET_RX_DESC_DRV_INFO_SIZE(rx_desc);
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.c b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
index 4c983666e830..b1f8c417a7e1 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
@@ -1704,7 +1704,8 @@ static void rtw8822c_query_rx_desc(struct rtw_dev *rtwdev, u8 *rx_desc,
 	pkt_stat->phy_status = GET_RX_DESC_PHYST(rx_desc);
 	pkt_stat->icv_err = GET_RX_DESC_ICV_ERR(rx_desc);
 	pkt_stat->crc_err = GET_RX_DESC_CRC32(rx_desc);
-	pkt_stat->decrypted = !GET_RX_DESC_SWDEC(rx_desc);
+	pkt_stat->decrypted = !GET_RX_DESC_SWDEC(rx_desc) &&
+			      GET_RX_DESC_ENC_TYPE(rx_desc) != RX_DESC_ENC_NONE;
 	pkt_stat->is_c2h = GET_RX_DESC_C2H(rx_desc);
 	pkt_stat->pkt_len = GET_RX_DESC_PKT_LEN(rx_desc);
 	pkt_stat->drv_info_sz = GET_RX_DESC_DRV_INFO_SIZE(rx_desc);
diff --git a/drivers/net/wireless/realtek/rtw88/rx.h b/drivers/net/wireless/realtek/rtw88/rx.h
index 383f3b2babc1..3342e3761281 100644
--- a/drivers/net/wireless/realtek/rtw88/rx.h
+++ b/drivers/net/wireless/realtek/rtw88/rx.h
@@ -5,6 +5,15 @@
 #ifndef __RTW_RX_H_
 #define __RTW_RX_H_
 
+enum rtw_rx_desc_enc {
+	RX_DESC_ENC_NONE	= 0,
+	RX_DESC_ENC_WEP40	= 1,
+	RX_DESC_ENC_TKIP_WO_MIC	= 2,
+	RX_DESC_ENC_TKIP_MIC	= 3,
+	RX_DESC_ENC_AES		= 4,
+	RX_DESC_ENC_WEP104	= 5,
+};
+
 #define GET_RX_DESC_PHYST(rxdesc)                                              \
 	le32_get_bits(*((__le32 *)(rxdesc) + 0x00), BIT(26))
 #define GET_RX_DESC_ICV_ERR(rxdesc)                                            \
@@ -21,6 +30,8 @@
 	le32_get_bits(*((__le32 *)(rxdesc) + 0x00), GENMASK(19, 16))
 #define GET_RX_DESC_SHIFT(rxdesc)                                              \
 	le32_get_bits(*((__le32 *)(rxdesc) + 0x00), GENMASK(25, 24))
+#define GET_RX_DESC_ENC_TYPE(rxdesc)                                           \
+	le32_get_bits(*((__le32 *)(rxdesc) + 0x00), GENMASK(22, 20))
 #define GET_RX_DESC_RX_RATE(rxdesc)                                            \
 	le32_get_bits(*((__le32 *)(rxdesc) + 0x03), GENMASK(6, 0))
 #define GET_RX_DESC_MACID(rxdesc)                                              \
-- 
2.17.1

