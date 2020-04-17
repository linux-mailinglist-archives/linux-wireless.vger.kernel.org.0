Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06EAB1AD7DA
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2020 09:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729441AbgDQHrc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Apr 2020 03:47:32 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:37043 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729266AbgDQHrM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Apr 2020 03:47:12 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 03H7l5oD5020081, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 03H7l5oD5020081
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 17 Apr 2020 15:47:05 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 17 Apr 2020 15:47:02 +0800
Received: from localhost.localdomain (172.21.68.128) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 17 Apr 2020 15:47:02 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>,
        <briannorris@chromium.org>, <kevin_yang@realtek.com>
Subject: [PATCH 18/40] rtw88: 8723d: Add query_rx_desc
Date:   Fri, 17 Apr 2020 15:46:31 +0800
Message-ID: <20200417074653.15591-19-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200417074653.15591-1-yhchuang@realtek.com>
References: <20200417074653.15591-1-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.128]
X-ClientProxiedBy: RTEXMB03.realtek.com.tw (172.21.6.96) To
 RTEXMB04.realtek.com.tw (172.21.6.97)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ping-Ke Shih <pkshih@realtek.com>

This ops is used to parse RX descriptor to know the length of received
packet and containing PHY status. If PHY status is existing, the order is
RX descriptor, PHY status and then packet.

There are two types of PHY status, named CCK and OFDM. Their size are the
same, but formats are different.

struct ieee80211_rx_status is also filled depends on above information.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/rtw8723d.c | 116 ++++++++++++++++++
 drivers/net/wireless/realtek/rtw88/rtw8723d.h |  22 ++++
 2 files changed, 138 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723d.c b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
index 52afa72caf8f..653cfa9445fc 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8723d.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
@@ -172,6 +172,121 @@ static int rtw8723d_read_efuse(struct rtw_dev *rtwdev, u8 *log_map)
 	return 0;
 }
 
+static void query_phy_status_page0(struct rtw_dev *rtwdev, u8 *phy_status,
+				   struct rtw_rx_pkt_stat *pkt_stat)
+{
+	struct rtw_dm_info *dm_info = &rtwdev->dm_info;
+	s8 min_rx_power = -120;
+	u8 pwdb = GET_PHY_STAT_P0_PWDB(phy_status);
+
+	pkt_stat->rx_power[RF_PATH_A] = pwdb - 97;
+	pkt_stat->rssi = rtw_phy_rf_power_2_rssi(pkt_stat->rx_power, 1);
+	pkt_stat->bw = RTW_CHANNEL_WIDTH_20;
+	pkt_stat->signal_power = max(pkt_stat->rx_power[RF_PATH_A],
+				     min_rx_power);
+	dm_info->rssi[RF_PATH_A] = pkt_stat->rssi;
+}
+
+static void query_phy_status_page1(struct rtw_dev *rtwdev, u8 *phy_status,
+				   struct rtw_rx_pkt_stat *pkt_stat)
+{
+	struct rtw_dm_info *dm_info = &rtwdev->dm_info;
+	u8 rxsc, bw;
+	s8 min_rx_power = -120;
+	s8 rx_evm;
+
+	if (pkt_stat->rate > DESC_RATE11M && pkt_stat->rate < DESC_RATEMCS0)
+		rxsc = GET_PHY_STAT_P1_L_RXSC(phy_status);
+	else
+		rxsc = GET_PHY_STAT_P1_HT_RXSC(phy_status);
+
+	if (GET_PHY_STAT_P1_RF_MODE(phy_status) == 0)
+		bw = RTW_CHANNEL_WIDTH_20;
+	else if ((rxsc == 1) || (rxsc == 2))
+		bw = RTW_CHANNEL_WIDTH_20;
+	else
+		bw = RTW_CHANNEL_WIDTH_40;
+
+	pkt_stat->rx_power[RF_PATH_A] = GET_PHY_STAT_P1_PWDB_A(phy_status) - 110;
+	pkt_stat->rssi = rtw_phy_rf_power_2_rssi(pkt_stat->rx_power, 1);
+	pkt_stat->bw = bw;
+	pkt_stat->signal_power = max(pkt_stat->rx_power[RF_PATH_A],
+				     min_rx_power);
+	pkt_stat->rx_evm[RF_PATH_A] = GET_PHY_STAT_P1_RXEVM_A(phy_status);
+	pkt_stat->rx_snr[RF_PATH_A] = GET_PHY_STAT_P1_RXSNR_A(phy_status);
+	pkt_stat->cfo_tail[RF_PATH_A] = GET_PHY_STAT_P1_CFO_TAIL_A(phy_status);
+
+	dm_info->curr_rx_rate = pkt_stat->rate;
+	dm_info->rssi[RF_PATH_A] = pkt_stat->rssi;
+	dm_info->rx_snr[RF_PATH_A] = pkt_stat->rx_snr[RF_PATH_A] >> 1;
+	dm_info->cfo_tail[RF_PATH_A] = (pkt_stat->cfo_tail[RF_PATH_A] * 5) >> 1;
+
+	rx_evm = clamp_t(s8, -pkt_stat->rx_evm[RF_PATH_A] >> 1, 0, 64);
+	rx_evm &= 0x3F;	/* 64->0: second path of 1SS rate is 64 */
+	dm_info->rx_evm_dbm[RF_PATH_A] = rx_evm;
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
+static void rtw8723d_query_rx_desc(struct rtw_dev *rtwdev, u8 *rx_desc,
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
+	pkt_stat->decrypted = !GET_RX_DESC_SWDEC(rx_desc) &&
+			      GET_RX_DESC_ENC_TYPE(rx_desc) != RX_DESC_ENC_NONE;
+	pkt_stat->is_c2h = GET_RX_DESC_C2H(rx_desc);
+	pkt_stat->pkt_len = GET_RX_DESC_PKT_LEN(rx_desc);
+	pkt_stat->drv_info_sz = GET_RX_DESC_DRV_INFO_SIZE(rx_desc);
+	pkt_stat->shift = GET_RX_DESC_SHIFT(rx_desc);
+	pkt_stat->rate = GET_RX_DESC_RX_RATE(rx_desc);
+	pkt_stat->cam_id = GET_RX_DESC_MACID(rx_desc);
+	pkt_stat->ppdu_cnt = 0;
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
 #define BIT_CFENDFORM		BIT(9)
 #define BIT_WMAC_TCR_ERR0	BIT(12)
 #define BIT_WMAC_TCR_ERR1	BIT(13)
@@ -267,6 +382,7 @@ static void rtw8723d_efuse_grant(struct rtw_dev *rtwdev, bool on)
 static struct rtw_chip_ops rtw8723d_ops = {
 	.phy_set_param		= rtw8723d_phy_set_param,
 	.read_efuse		= rtw8723d_read_efuse,
+	.query_rx_desc		= rtw8723d_query_rx_desc,
 	.mac_init		= rtw8723d_mac_init,
 	.read_rf		= rtw_phy_read_rf_sipi,
 	.write_rf		= rtw_phy_write_rf_reg_sipi,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723d.h b/drivers/net/wireless/realtek/rtw88/rtw8723d.h
index 6321dea83519..035049a29e7c 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8723d.h
+++ b/drivers/net/wireless/realtek/rtw88/rtw8723d.h
@@ -44,6 +44,28 @@ struct rtw8723d_efuse {
 	struct rtw8723de_efuse e;
 };
 
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
+#define GET_PHY_STAT_P1_RXEVM_A(phy_stat)                                      \
+	le32_get_bits(*((__le32 *)(phy_stat) + 0x04), GENMASK(7, 0))
+#define GET_PHY_STAT_P1_CFO_TAIL_A(phy_stat)                                   \
+	le32_get_bits(*((__le32 *)(phy_stat) + 0x05), GENMASK(7, 0))
+#define GET_PHY_STAT_P1_RXSNR_A(phy_stat)                                      \
+	le32_get_bits(*((__le32 *)(phy_stat) + 0x06), GENMASK(7, 0))
+
 #define REG_OFDM0_XAAGC1	0x0c50
 #define REG_OFDM0_XBAGC1	0x0c58
 
-- 
2.17.1

