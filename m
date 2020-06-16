Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3C441FAC1D
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jun 2020 11:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727914AbgFPJQx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 16 Jun 2020 05:16:53 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:46541 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727103AbgFPJQs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 16 Jun 2020 05:16:48 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 05G9GX6h8021732, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 05G9GX6h8021732
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 16 Jun 2020 17:16:33 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 16 Jun 2020 17:16:33 +0800
Received: from localhost.localdomain (172.21.68.128) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 16 Jun 2020 17:16:32 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <tehuang@realtek.com>,
        <bigeasy@linutronix.de>
Subject: [PATCH v4 5/7] rtw88: 8821c: add query rx desc support
Date:   Tue, 16 Jun 2020 17:16:23 +0800
Message-ID: <20200616091625.26489-6-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200616091625.26489-1-yhchuang@realtek.com>
References: <20200616091625.26489-1-yhchuang@realtek.com>
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

Some RX packets contain also information about environment status.

Implement rtw_chip_ops::query_rx_desc() for 8821c. Parse the RX
descriptor which describes the current condition of the received
packet.

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Tzu-En Huang <tehuang@realtek.com>
Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/rtw8821c.c | 101 ++++++++++++++++++
 drivers/net/wireless/realtek/rtw88/rtw8821c.h |  16 +++
 2 files changed, 117 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821c.c b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
index 4c27d28a9f9d..bf1a2c92f2a5 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8821c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
@@ -373,6 +373,106 @@ static void rtw8821c_set_channel(struct rtw_dev *rtwdev, u8 channel, u8 bw,
 	rtw8821c_set_channel_rxdfir(rtwdev, bw);
 }
 
+static void query_phy_status_page0(struct rtw_dev *rtwdev, u8 *phy_status,
+				   struct rtw_rx_pkt_stat *pkt_stat)
+{
+	s8 min_rx_power = -120;
+	u8 pwdb = GET_PHY_STAT_P0_PWDB(phy_status);
+
+	pkt_stat->rx_power[RF_PATH_A] = pwdb - 100;
+	pkt_stat->rssi = rtw_phy_rf_power_2_rssi(pkt_stat->rx_power, 1);
+	pkt_stat->bw = RTW_CHANNEL_WIDTH_20;
+	pkt_stat->signal_power = max(pkt_stat->rx_power[RF_PATH_A],
+				     min_rx_power);
+}
+
+static void query_phy_status_page1(struct rtw_dev *rtwdev, u8 *phy_status,
+				   struct rtw_rx_pkt_stat *pkt_stat)
+{
+	u8 rxsc, bw;
+	s8 min_rx_power = -120;
+
+	if (pkt_stat->rate > DESC_RATE11M && pkt_stat->rate < DESC_RATEMCS0)
+		rxsc = GET_PHY_STAT_P1_L_RXSC(phy_status);
+	else
+		rxsc = GET_PHY_STAT_P1_HT_RXSC(phy_status);
+
+	if (rxsc >= 1 && rxsc <= 8)
+		bw = RTW_CHANNEL_WIDTH_20;
+	else if (rxsc >= 9 && rxsc <= 12)
+		bw = RTW_CHANNEL_WIDTH_40;
+	else if (rxsc >= 13)
+		bw = RTW_CHANNEL_WIDTH_80;
+	else
+		bw = GET_PHY_STAT_P1_RF_MODE(phy_status);
+
+	pkt_stat->rx_power[RF_PATH_A] = GET_PHY_STAT_P1_PWDB_A(phy_status) - 110;
+	pkt_stat->rssi = rtw_phy_rf_power_2_rssi(pkt_stat->rx_power, 1);
+	pkt_stat->bw = bw;
+	pkt_stat->signal_power = max(pkt_stat->rx_power[RF_PATH_A],
+				     min_rx_power);
+}
+
+static void query_phy_status(struct rtw_dev *rtwdev, u8 *phy_status,
+			     struct rtw_rx_pkt_stat *pkt_stat)
+{
+	u8 page;
+
+	page = *phy_status & 0xf;
+
+	switch (page) {
+	case 0:
+		query_phy_status_page0(rtwdev, phy_status, pkt_stat);
+		break;
+	case 1:
+		query_phy_status_page1(rtwdev, phy_status, pkt_stat);
+		break;
+	default:
+		rtw_warn(rtwdev, "unused phy status page (%d)\n", page);
+		return;
+	}
+}
+
+static void rtw8821c_query_rx_desc(struct rtw_dev *rtwdev, u8 *rx_desc,
+				   struct rtw_rx_pkt_stat *pkt_stat,
+				   struct ieee80211_rx_status *rx_status)
+{
+	struct ieee80211_hdr *hdr;
+	u32 desc_sz = rtwdev->chip->rx_pkt_desc_sz;
+	u8 *phy_status = NULL;
+
+	memset(pkt_stat, 0, sizeof(*pkt_stat));
+
+	pkt_stat->phy_status = GET_RX_DESC_PHYST(rx_desc);
+	pkt_stat->icv_err = GET_RX_DESC_ICV_ERR(rx_desc);
+	pkt_stat->crc_err = GET_RX_DESC_CRC32(rx_desc);
+	pkt_stat->decrypted = !GET_RX_DESC_SWDEC(rx_desc);
+	pkt_stat->is_c2h = GET_RX_DESC_C2H(rx_desc);
+	pkt_stat->pkt_len = GET_RX_DESC_PKT_LEN(rx_desc);
+	pkt_stat->drv_info_sz = GET_RX_DESC_DRV_INFO_SIZE(rx_desc);
+	pkt_stat->shift = GET_RX_DESC_SHIFT(rx_desc);
+	pkt_stat->rate = GET_RX_DESC_RX_RATE(rx_desc);
+	pkt_stat->cam_id = GET_RX_DESC_MACID(rx_desc);
+	pkt_stat->ppdu_cnt = GET_RX_DESC_PPDU_CNT(rx_desc);
+	pkt_stat->tsf_low = GET_RX_DESC_TSFL(rx_desc);
+
+	/* drv_info_sz is in unit of 8-bytes */
+	pkt_stat->drv_info_sz *= 8;
+
+	/* c2h cmd pkt's rx/phy status is not interested */
+	if (pkt_stat->is_c2h)
+		return;
+
+	hdr = (struct ieee80211_hdr *)(rx_desc + desc_sz + pkt_stat->shift +
+				       pkt_stat->drv_info_sz);
+	if (pkt_stat->phy_status) {
+		phy_status = rx_desc + desc_sz + pkt_stat->shift;
+		query_phy_status(rtwdev, phy_status, pkt_stat);
+	}
+
+	rtw_rx_fill_rx_status(rtwdev, pkt_stat, hdr, rx_status, phy_status);
+}
+
 static void
 rtw8821c_set_tx_power_index_by_rate(struct rtw_dev *rtwdev, u8 path, u8 rs)
 {
@@ -840,6 +940,7 @@ static struct rtw_prioq_addrs prioq_addrs_8821c = {
 static struct rtw_chip_ops rtw8821c_ops = {
 	.phy_set_param		= rtw8821c_phy_set_param,
 	.read_efuse		= rtw8821c_read_efuse,
+	.query_rx_desc		= rtw8821c_query_rx_desc,
 	.set_channel		= rtw8821c_set_channel,
 	.mac_init		= rtw8821c_mac_init,
 	.read_rf		= rtw_phy_read_rf,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821c.h b/drivers/net/wireless/realtek/rtw88/rtw8821c.h
index 2d33f6e50cea..741f78829c17 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8821c.h
+++ b/drivers/net/wireless/realtek/rtw88/rtw8821c.h
@@ -145,6 +145,22 @@ _rtw_write32s_mask(struct rtw_dev *rtwdev, u32 addr, u32 mask, u32 data)
 #define WLAN_RX_TSF_CFG		(WLAN_CCK_RX_TSF | (WLAN_OFDM_RX_TSF) << 8)
 #define WLAN_PRE_TXCNT_TIME_TH		0x1E4
 
+/* phy status page0 */
+#define GET_PHY_STAT_P0_PWDB(phy_stat)                                         \
+	le32_get_bits(*((__le32 *)(phy_stat) + 0x00), GENMASK(15, 8))
+
+/* phy status page1 */
+#define GET_PHY_STAT_P1_PWDB_A(phy_stat)                                       \
+	le32_get_bits(*((__le32 *)(phy_stat) + 0x00), GENMASK(15, 8))
+#define GET_PHY_STAT_P1_PWDB_B(phy_stat)                                       \
+	le32_get_bits(*((__le32 *)(phy_stat) + 0x00), GENMASK(23, 16))
+#define GET_PHY_STAT_P1_RF_MODE(phy_stat)                                      \
+	le32_get_bits(*((__le32 *)(phy_stat) + 0x03), GENMASK(29, 28))
+#define GET_PHY_STAT_P1_L_RXSC(phy_stat)                                       \
+	le32_get_bits(*((__le32 *)(phy_stat) + 0x01), GENMASK(11, 8))
+#define GET_PHY_STAT_P1_HT_RXSC(phy_stat)                                      \
+	le32_get_bits(*((__le32 *)(phy_stat) + 0x01), GENMASK(15, 12))
+
 #define REG_INIRTS_RATE_SEL 0x0480
 #define REG_HTSTFWT	0x800
 #define REG_RXPSEL	0x808
-- 
2.17.1

