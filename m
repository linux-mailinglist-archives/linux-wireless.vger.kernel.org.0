Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D246D3AC425
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Jun 2021 08:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbhFRGt2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Jun 2021 02:49:28 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:38864 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbhFRGtY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Jun 2021 02:49:24 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 15I6lAgtD010995, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36502.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 15I6lAgtD010995
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 18 Jun 2021 14:47:11 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36502.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 18 Jun 2021 14:47:10 +0800
Received: from localhost (172.16.16.17) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 18 Jun
 2021 14:47:08 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 03/24] rtw89: add core and trx files
Date:   Fri, 18 Jun 2021 14:46:04 +0800
Message-ID: <20210618064625.14131-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210618064625.14131-1-pkshih@realtek.com>
References: <20210618064625.14131-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.16.17]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 06/18/2021 06:27:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIxLzYvMTggpFekyCAwNjowMTowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36502.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 06/18/2021 06:23:56
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 164465 [Jun 18 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: pkshih@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 448 448 71fb1b37213ce9a885768d4012c46ac449c77b17
X-KSE-AntiSpam-Info: {Tracking_all_Bitcoin, bb}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: realtek.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 06/18/2021 06:27:00
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Implement main flows that contains register/unregister mac80211 hw with
hardware capability, power on/off sequence, STA state actions, and
TX/RX path.

The chip info is read from efuse while probing PCI, and then it can be
used to induce supported channel, band, bitrate, ht/vht/he capability,
and etc. Then, we register hardware with these capabilities.

When network interface is up, driver does power-on sequence to enable MAC,
BB and RF function blocks. Oppositely, do power-off sequence when
interface is going to down.

To maintain STA state, five callbacks are implemented -- add, assoc,
disassoc, disconnect and remove. In which state, driver tells firmware STA
info via H2C.

TX flow:
When a SKB is going to be transmitted, we must know its type first. If
the type is mgmt or fwcmd made by driver, SKB is queued into corresponding
DMA channel and PCI ring. The other type is data frame that is more
complex, because it needs to establish BA session to have better throughput
with AMPDU and AMSDU.
In order to have better PCI DMA efficiency, we don't kick off DMA every
SKB. With wake TX queue, kick off DMA after a bunch of SKBs are written.
To achieve this, we have two HCI ops -- tx_write and tx_kick_off.

BA establishment work:
For data frames, we start to establish BA session if the STA is associated
with APMDU capability and the TID session isn't established, and then the
BA work is used to ask mac80211 to start AMPDU actions. Driver implements
AMPDU action callbacks to know the session is established, so that we can
set AGG_EN bit in TX descriptor to enable AMPDU.

RX flow:
When a RX SKB is delivered from PCI, rtw89_core_rx() process it depneds on
its type -- WIFI, C2H or PPDU. If type is C2H, it's queued into a C2H
queue, and wake a work to handle the C2H packet. If type is WIFI, it's a
normal RX packet. When mgmt or data frame is received, it is queued
into pending RX SKB queue to wait for corresponding PPDU packet (another
RX packet with PPDU type) to fill its rx_status, like RSSI. And, then
indicate this packet to mac80211. When control frame is received, indicate
it to mac80211 immediately.

Track work:
Use track work to monitor PHY status to know the changes of environment,
and then update RA status or do RFK accordingly.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c | 2359 +++++++++++++++
 drivers/net/wireless/realtek/rtw89/core.h | 3336 +++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/txrx.h |  393 +++
 drivers/net/wireless/realtek/rtw89/util.c |   37 +
 drivers/net/wireless/realtek/rtw89/util.h |   31 +
 5 files changed, 6156 insertions(+)
 create mode 100644 drivers/net/wireless/realtek/rtw89/core.c
 create mode 100644 drivers/net/wireless/realtek/rtw89/core.h
 create mode 100644 drivers/net/wireless/realtek/rtw89/txrx.h
 create mode 100644 drivers/net/wireless/realtek/rtw89/util.c
 create mode 100644 drivers/net/wireless/realtek/rtw89/util.h

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
new file mode 100644
index 000000000000..3bd31e669aea
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -0,0 +1,2359 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/* Copyright(c) 2019-2020  Realtek Corporation
+ */
+
+#include "coex.h"
+#include "core.h"
+#include "efuse.h"
+#include "fw.h"
+#include "mac.h"
+#include "phy.h"
+#include "ps.h"
+#include "reg.h"
+#include "sar.h"
+#include "ser.h"
+#include "txrx.h"
+#include "util.h"
+
+static bool rtw89_disable_ps_mode;
+module_param_named(disable_ps_mode, rtw89_disable_ps_mode, bool, 0644);
+MODULE_PARM_DESC(disable_ps_mode, "Set Y to disable low power mode");
+
+static struct ieee80211_channel rtw89_channels_2ghz[] = {
+	{ .center_freq = 2412, .hw_value = 1, },
+	{ .center_freq = 2417, .hw_value = 2, },
+	{ .center_freq = 2422, .hw_value = 3, },
+	{ .center_freq = 2427, .hw_value = 4, },
+	{ .center_freq = 2432, .hw_value = 5, },
+	{ .center_freq = 2437, .hw_value = 6, },
+	{ .center_freq = 2442, .hw_value = 7, },
+	{ .center_freq = 2447, .hw_value = 8, },
+	{ .center_freq = 2452, .hw_value = 9, },
+	{ .center_freq = 2457, .hw_value = 10, },
+	{ .center_freq = 2462, .hw_value = 11, },
+	{ .center_freq = 2467, .hw_value = 12, },
+	{ .center_freq = 2472, .hw_value = 13, },
+	{ .center_freq = 2484, .hw_value = 14, },
+};
+
+static struct ieee80211_channel rtw89_channels_5ghz[] = {
+	{.center_freq = 5180, .hw_value = 36,},
+	{.center_freq = 5200, .hw_value = 40,},
+	{.center_freq = 5220, .hw_value = 44,},
+	{.center_freq = 5240, .hw_value = 48,},
+	{.center_freq = 5260, .hw_value = 52,},
+	{.center_freq = 5280, .hw_value = 56,},
+	{.center_freq = 5300, .hw_value = 60,},
+	{.center_freq = 5320, .hw_value = 64,},
+	{.center_freq = 5500, .hw_value = 100,},
+	{.center_freq = 5520, .hw_value = 104,},
+	{.center_freq = 5540, .hw_value = 108,},
+	{.center_freq = 5560, .hw_value = 112,},
+	{.center_freq = 5580, .hw_value = 116,},
+	{.center_freq = 5600, .hw_value = 120,},
+	{.center_freq = 5620, .hw_value = 124,},
+	{.center_freq = 5640, .hw_value = 128,},
+	{.center_freq = 5660, .hw_value = 132,},
+	{.center_freq = 5680, .hw_value = 136,},
+	{.center_freq = 5700, .hw_value = 140,},
+	{.center_freq = 5720, .hw_value = 144,},
+	{.center_freq = 5745, .hw_value = 149,},
+	{.center_freq = 5765, .hw_value = 153,},
+	{.center_freq = 5785, .hw_value = 157,},
+	{.center_freq = 5805, .hw_value = 161,},
+	{.center_freq = 5825, .hw_value = 165,
+	 .flags = IEEE80211_CHAN_NO_HT40MINUS},
+};
+
+static struct ieee80211_rate rtw89_bitrates[] = {
+	{ .bitrate = 10,  .hw_value = 0x00, },
+	{ .bitrate = 20,  .hw_value = 0x01, },
+	{ .bitrate = 55,  .hw_value = 0x02, },
+	{ .bitrate = 110, .hw_value = 0x03, },
+	{ .bitrate = 60,  .hw_value = 0x04, },
+	{ .bitrate = 90,  .hw_value = 0x05, },
+	{ .bitrate = 120, .hw_value = 0x06, },
+	{ .bitrate = 180, .hw_value = 0x07, },
+	{ .bitrate = 240, .hw_value = 0x08, },
+	{ .bitrate = 360, .hw_value = 0x09, },
+	{ .bitrate = 480, .hw_value = 0x0a, },
+	{ .bitrate = 540, .hw_value = 0x0b, },
+};
+
+u16 rtw89_ra_report_to_bitrate(struct rtw89_dev *rtwdev, u8 rpt_rate)
+{
+	struct ieee80211_rate rate;
+
+	if (unlikely(rpt_rate >= ARRAY_SIZE(rtw89_bitrates))) {
+		rtw89_info(rtwdev, "invalid rpt rate %d\n", rpt_rate);
+		return 0;
+	}
+
+	rate = rtw89_bitrates[rpt_rate];
+
+	return rate.bitrate;
+}
+
+static struct ieee80211_supported_band rtw89_sband_2ghz = {
+	.band		= NL80211_BAND_2GHZ,
+	.channels	= rtw89_channels_2ghz,
+	.n_channels	= ARRAY_SIZE(rtw89_channels_2ghz),
+	.bitrates	= rtw89_bitrates,
+	.n_bitrates	= ARRAY_SIZE(rtw89_bitrates),
+	.ht_cap		= {0},
+	.vht_cap	= {0},
+};
+
+static struct ieee80211_supported_band rtw89_sband_5ghz = {
+	.band		= NL80211_BAND_5GHZ,
+	.channels	= rtw89_channels_5ghz,
+	.n_channels	= ARRAY_SIZE(rtw89_channels_5ghz),
+
+	/* 5G has no CCK rates, 1M/2M/5.5M/11M */
+	.bitrates	= rtw89_bitrates + 4,
+	.n_bitrates	= ARRAY_SIZE(rtw89_bitrates) - 4,
+	.ht_cap		= {0},
+	.vht_cap	= {0},
+};
+
+static void rtw89_traffic_stats_accu(struct rtw89_dev *rtwdev,
+				     struct rtw89_traffic_stats *stats,
+				     struct sk_buff *skb, bool tx)
+{
+	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
+
+	if (!ieee80211_is_data(hdr->frame_control))
+		return;
+
+	if (is_broadcast_ether_addr(hdr->addr1) ||
+	    is_multicast_ether_addr(hdr->addr1))
+		return;
+
+	if (tx) {
+		stats->tx_cnt++;
+		stats->tx_unicast += skb->len;
+	} else {
+		stats->rx_cnt++;
+		stats->rx_unicast += skb->len;
+	}
+}
+
+static void rtw89_get_channel_params(struct cfg80211_chan_def *chandef,
+				     struct rtw89_channel_params *chan_param)
+{
+	struct ieee80211_channel *channel = chandef->chan;
+	enum nl80211_chan_width width = chandef->width;
+	u8 *cch_by_bw = chan_param->cch_by_bw;
+	u32 primary_freq, center_freq;
+	u8 center_chan;
+	u8 bandwidth = RTW89_CHANNEL_WIDTH_20;
+	u8 primary_chan_idx = 0;
+	u8 i;
+
+	center_chan = channel->hw_value;
+	primary_freq = channel->center_freq;
+	center_freq = chandef->center_freq1;
+
+	/* assign the center channel used while 20M bw is selected */
+	cch_by_bw[RTW89_CHANNEL_WIDTH_20] = channel->hw_value;
+
+	switch (width) {
+	case NL80211_CHAN_WIDTH_20_NOHT:
+	case NL80211_CHAN_WIDTH_20:
+		bandwidth = RTW89_CHANNEL_WIDTH_20;
+		primary_chan_idx = RTW89_SC_DONT_CARE;
+		break;
+	case NL80211_CHAN_WIDTH_40:
+		bandwidth = RTW89_CHANNEL_WIDTH_40;
+		if (primary_freq > center_freq) {
+			primary_chan_idx = RTW89_SC_20_UPPER;
+			center_chan -= 2;
+		} else {
+			primary_chan_idx = RTW89_SC_20_LOWER;
+			center_chan += 2;
+		}
+		break;
+	case NL80211_CHAN_WIDTH_80:
+		bandwidth = RTW89_CHANNEL_WIDTH_80;
+		if (primary_freq > center_freq) {
+			if (primary_freq - center_freq == 10) {
+				primary_chan_idx = RTW89_SC_20_UPPER;
+				center_chan -= 2;
+			} else {
+				primary_chan_idx = RTW89_SC_20_UPMOST;
+				center_chan -= 6;
+			}
+			/* assign the center channel used
+			 * while 40M bw is selected
+			 */
+			cch_by_bw[RTW89_CHANNEL_WIDTH_40] = center_chan + 4;
+		} else {
+			if (center_freq - primary_freq == 10) {
+				primary_chan_idx = RTW89_SC_20_LOWER;
+				center_chan += 2;
+			} else {
+				primary_chan_idx = RTW89_SC_20_LOWEST;
+				center_chan += 6;
+			}
+			/* assign the center channel used
+			 * while 40M bw is selected
+			 */
+			cch_by_bw[RTW89_CHANNEL_WIDTH_40] = center_chan - 4;
+		}
+		break;
+	default:
+		center_chan = 0;
+		break;
+	}
+
+	chan_param->center_chan = center_chan;
+	chan_param->primary_chan = channel->hw_value;
+	chan_param->bandwidth = bandwidth;
+	chan_param->pri_ch_idx = primary_chan_idx;
+
+	/* assign the center channel used while current bw is selected */
+	cch_by_bw[bandwidth] = center_chan;
+
+	for (i = bandwidth + 1; i <= RTW89_MAX_CHANNEL_WIDTH; i++)
+		cch_by_bw[i] = 0;
+}
+
+void rtw89_set_channel(struct rtw89_dev *rtwdev)
+{
+	struct ieee80211_hw *hw = rtwdev->hw;
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+	struct rtw89_hal *hal = &rtwdev->hal;
+	struct rtw89_channel_params ch_param;
+	struct rtw89_channel_help_params bak;
+	u8 center_chan, bandwidth;
+	u8 band_type;
+	bool band_changed;
+	u8 i;
+
+	rtw89_get_channel_params(&hw->conf.chandef, &ch_param);
+	if (WARN(ch_param.center_chan == 0, "Invalid channel\n"))
+		return;
+
+	center_chan = ch_param.center_chan;
+	bandwidth = ch_param.bandwidth;
+	band_type = center_chan > 14 ? RTW89_BAND_5G : RTW89_BAND_2G;
+	band_changed = hal->current_band_type != band_type ||
+		       hal->current_channel == 0;
+
+	hal->current_band_width = bandwidth;
+	hal->current_channel = center_chan;
+	hal->current_primary_channel = ch_param.primary_chan;
+	hal->current_band_type = band_type;
+
+	switch (center_chan) {
+	case 1 ... 14:
+		hal->current_subband = RTW89_CH_2G;
+		break;
+	case 36 ... 64:
+		hal->current_subband = RTW89_CH_5G_BAND_1;
+		break;
+	case 100 ... 144:
+		hal->current_subband = RTW89_CH_5G_BAND_3;
+		break;
+	case 149 ... 177:
+		hal->current_subband = RTW89_CH_5G_BAND_4;
+		break;
+	}
+
+	for (i = RTW89_CHANNEL_WIDTH_20; i <= RTW89_MAX_CHANNEL_WIDTH; i++)
+		hal->cch_by_bw[i] = ch_param.cch_by_bw[i];
+
+	rtw89_chip_set_channel_prepare(rtwdev, &bak);
+
+	chip->ops->set_channel(rtwdev, &ch_param);
+
+	rtw89_chip_set_txpwr(rtwdev);
+
+	rtw89_chip_set_channel_done(rtwdev, &bak);
+
+	if (band_changed) {
+		rtw89_btc_ntfy_switch_band(rtwdev, RTW89_PHY_0, hal->current_band_type);
+		rtw89_chip_rfk_band_changed(rtwdev);
+	}
+}
+
+static enum rtw89_core_tx_type
+rtw89_core_get_tx_type(struct rtw89_dev *rtwdev,
+		       struct sk_buff *skb)
+{
+	struct ieee80211_hdr *hdr = (void *)skb->data;
+	__le16 fc = hdr->frame_control;
+
+	if (ieee80211_is_mgmt(fc) || ieee80211_is_nullfunc(fc))
+		return RTW89_CORE_TX_TYPE_MGMT;
+
+	return RTW89_CORE_TX_TYPE_DATA;
+}
+
+static void
+rtw89_core_tx_update_ampdu_info(struct rtw89_dev *rtwdev,
+				struct rtw89_core_tx_request *tx_req, u8 tid)
+{
+	struct ieee80211_sta *sta = tx_req->sta;
+	struct rtw89_tx_desc_info *desc_info = &tx_req->desc_info;
+	struct rtw89_sta *rtwsta;
+	u8 ampdu_num;
+
+	if (!sta) {
+		rtw89_warn(rtwdev, "cannot set ampdu info without sta\n");
+		return;
+	}
+
+	rtwsta = (struct rtw89_sta *)sta->drv_priv;
+
+	ampdu_num = (u8)((rtwsta->ampdu_params[tid].agg_num ?
+			  rtwsta->ampdu_params[tid].agg_num :
+			  4 << sta->ht_cap.ampdu_factor) - 1);
+
+	desc_info->agg_en = true;
+	desc_info->ampdu_density = sta->ht_cap.ampdu_density;
+	desc_info->ampdu_num = ampdu_num;
+}
+
+static void
+rtw89_core_tx_update_sec_key(struct rtw89_dev *rtwdev,
+			     struct rtw89_core_tx_request *tx_req)
+{
+	struct ieee80211_vif *vif = tx_req->vif;
+	struct ieee80211_tx_info *info;
+	struct ieee80211_key_conf *key;
+	struct rtw89_vif *rtwvif;
+	struct rtw89_addr_cam_entry *addr_cam;
+	struct rtw89_sec_cam_entry *sec_cam;
+	struct rtw89_tx_desc_info *desc_info = &tx_req->desc_info;
+	struct sk_buff *skb = tx_req->skb;
+	u8 sec_type = RTW89_SEC_KEY_TYPE_NONE;
+
+	if (!vif) {
+		rtw89_warn(rtwdev, "cannot set sec key without vif\n");
+		return;
+	}
+
+	rtwvif = (struct rtw89_vif *)vif->drv_priv;
+	addr_cam = &rtwvif->addr_cam;
+
+	info = IEEE80211_SKB_CB(skb);
+	key = info->control.hw_key;
+	sec_cam = addr_cam->sec_entries[key->hw_key_idx];
+	if (!sec_cam) {
+		rtw89_warn(rtwdev, "sec cam entry is empty\n");
+		return;
+	}
+
+	switch (key->cipher) {
+	case WLAN_CIPHER_SUITE_WEP40:
+		sec_type = RTW89_SEC_KEY_TYPE_WEP40;
+		break;
+	case WLAN_CIPHER_SUITE_WEP104:
+		sec_type = RTW89_SEC_KEY_TYPE_WEP104;
+		break;
+	case WLAN_CIPHER_SUITE_TKIP:
+		sec_type = RTW89_SEC_KEY_TYPE_TKIP;
+		break;
+	case WLAN_CIPHER_SUITE_CCMP:
+		sec_type = RTW89_SEC_KEY_TYPE_CCMP128;
+		break;
+	case WLAN_CIPHER_SUITE_CCMP_256:
+		sec_type = RTW89_SEC_KEY_TYPE_CCMP256;
+		break;
+	case WLAN_CIPHER_SUITE_GCMP:
+		sec_type = RTW89_SEC_KEY_TYPE_GCMP128;
+		break;
+	case WLAN_CIPHER_SUITE_GCMP_256:
+		sec_type = RTW89_SEC_KEY_TYPE_GCMP256;
+		break;
+	default:
+		rtw89_warn(rtwdev, "key cipher not supported %d\n", key->cipher);
+		return;
+	}
+
+	desc_info->sec_en = true;
+	desc_info->sec_type = sec_type;
+	desc_info->sec_cam_idx = sec_cam->sec_cam_idx;
+}
+
+static void
+rtw89_core_tx_update_mgmt_info(struct rtw89_dev *rtwdev,
+			       struct rtw89_core_tx_request *tx_req)
+{
+	struct rtw89_tx_desc_info *desc_info = &tx_req->desc_info;
+	u8 qsel, ch_dma;
+
+	qsel = RTW89_TX_QSEL_B0_MGMT;
+	ch_dma = rtw89_core_get_ch_dma(rtwdev, qsel);
+
+	desc_info->qsel = RTW89_TX_QSEL_B0_MGMT;
+	desc_info->ch_dma = ch_dma;
+
+	/* fixed data rate for mgmt frames */
+	desc_info->en_wd_info = true;
+	desc_info->use_rate = true;
+	desc_info->dis_data_fb = true;
+	desc_info->data_rate = 0x00;
+}
+
+static void
+rtw89_core_tx_update_h2c_info(struct rtw89_dev *rtwdev,
+			      struct rtw89_core_tx_request *tx_req)
+{
+	struct rtw89_tx_desc_info *desc_info = &tx_req->desc_info;
+
+	desc_info->is_bmc = false;
+	desc_info->wd_page = false;
+	desc_info->ch_dma = RTW89_DMA_H2C;
+}
+
+static bool
+__rtw89_core_tx_check_he_qos_htc(struct rtw89_dev *rtwdev,
+				 struct rtw89_core_tx_request *tx_req,
+				 enum btc_pkt_type pkt_type)
+{
+	struct ieee80211_sta *sta = tx_req->sta;
+	struct sk_buff *skb = tx_req->skb;
+	struct ieee80211_hdr *hdr = (void *)skb->data;
+	__le16 fc = hdr->frame_control;
+
+	/* AP IOT issue with EAPoL, ARP and DHCP */
+	if (pkt_type < PACKET_MAX)
+		return false;
+
+	if (!sta || !sta->he_cap.has_he)
+		return false;
+
+	if (!ieee80211_is_data_qos(fc))
+		return false;
+
+	if (skb_headroom(skb) < IEEE80211_HT_CTL_LEN)
+		return false;
+
+	return true;
+}
+
+static void
+__rtw89_core_tx_adjust_he_qos_htc(struct rtw89_dev *rtwdev,
+				  struct rtw89_core_tx_request *tx_req)
+{
+	struct sk_buff *skb = tx_req->skb;
+	struct ieee80211_hdr *hdr = (void *)skb->data;
+	__le16 fc = hdr->frame_control;
+	void *data;
+	__le32 *htc;
+	u8 *qc;
+	int hdr_len;
+
+	hdr_len = ieee80211_has_a4(fc) ? 32 : 26;
+	data = skb_push(skb, IEEE80211_HT_CTL_LEN);
+	memmove(data, data + IEEE80211_HT_CTL_LEN, hdr_len);
+
+	hdr = data;
+	htc = data + hdr_len;
+	hdr->frame_control |= cpu_to_le16(IEEE80211_FCTL_ORDER);
+	memset(htc, 0, sizeof(*htc));
+	*htc = le32_encode_bits(RTW89_HTC_VARIANT_HE, RTW89_HTC_MASK_VARIANT) |
+	       le32_encode_bits(RTW89_HTC_VARIANT_HE_CID_CAS, RTW89_HTC_MASK_CTL_ID);
+
+	qc = data + hdr_len - IEEE80211_QOS_CTL_LEN;
+	qc[0] |= IEEE80211_QOS_CTL_EOSP;
+}
+
+static void
+rtw89_core_tx_update_he_qos_htc(struct rtw89_dev *rtwdev,
+				struct rtw89_core_tx_request *tx_req,
+				enum btc_pkt_type pkt_type)
+{
+	struct rtw89_tx_desc_info *desc_info = &tx_req->desc_info;
+	struct ieee80211_vif *vif = tx_req->vif;
+	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
+
+	if (!__rtw89_core_tx_check_he_qos_htc(rtwdev, tx_req, pkt_type))
+		goto desc_bk;
+
+	__rtw89_core_tx_adjust_he_qos_htc(rtwdev, tx_req);
+
+	desc_info->pkt_size += IEEE80211_HT_CTL_LEN;
+	desc_info->a_ctrl_bsr = true;
+
+desc_bk:
+	if (!rtwvif || rtwvif->last_a_ctrl == desc_info->a_ctrl_bsr)
+		return;
+
+	rtwvif->last_a_ctrl = desc_info->a_ctrl_bsr;
+	desc_info->bk = true;
+}
+
+static void
+rtw89_core_tx_update_data_info(struct rtw89_dev *rtwdev,
+			       struct rtw89_core_tx_request *tx_req)
+{
+	struct rtw89_tx_desc_info *desc_info = &tx_req->desc_info;
+	struct sk_buff *skb = tx_req->skb;
+	u8 tid, tid_indicate;
+	u8 qsel, ch_dma;
+
+	tid = skb->priority & IEEE80211_QOS_CTL_TAG1D_MASK;
+	tid_indicate = rtw89_core_get_tid_indicate(rtwdev, tid);
+	qsel = rtw89_core_get_qsel(rtwdev, tid);
+	ch_dma = rtw89_core_get_ch_dma(rtwdev, qsel);
+
+	desc_info->ch_dma = ch_dma;
+	desc_info->tid_indicate = tid_indicate;
+	desc_info->qsel = qsel;
+
+	/* enable wd_info for AMPDU */
+	desc_info->en_wd_info = true;
+
+	if (IEEE80211_SKB_CB(skb)->flags & IEEE80211_TX_CTL_AMPDU)
+		rtw89_core_tx_update_ampdu_info(rtwdev, tx_req, tid);
+	if (IEEE80211_SKB_CB(skb)->control.hw_key)
+		rtw89_core_tx_update_sec_key(rtwdev, tx_req);
+}
+
+static enum btc_pkt_type
+rtw89_core_tx_btc_spec_pkt_notify(struct rtw89_dev *rtwdev,
+				  struct rtw89_core_tx_request *tx_req)
+{
+	struct sk_buff *skb = tx_req->skb;
+	struct udphdr *udphdr;
+
+	if (IEEE80211_SKB_CB(skb)->control.flags & IEEE80211_TX_CTRL_PORT_CTRL_PROTO) {
+		ieee80211_queue_work(rtwdev->hw, &rtwdev->btc.eapol_notify_work);
+		return PACKET_EAPOL;
+	}
+
+	if (skb->protocol == htons(ETH_P_ARP)) {
+		ieee80211_queue_work(rtwdev->hw, &rtwdev->btc.arp_notify_work);
+		return PACKET_ARP;
+	}
+
+	if (skb->protocol == htons(ETH_P_IP) &&
+	    ip_hdr(skb)->protocol == IPPROTO_UDP) {
+		udphdr = udp_hdr(skb);
+		if (((udphdr->source == htons(67) && udphdr->dest == htons(68)) ||
+		     (udphdr->source == htons(68) && udphdr->dest == htons(67))) &&
+		    skb->len > 282) {
+			ieee80211_queue_work(rtwdev->hw, &rtwdev->btc.dhcp_notify_work);
+			return PACKET_DHCP;
+		}
+	}
+
+	return PACKET_MAX;
+}
+
+static void
+rtw89_core_tx_update_desc_info(struct rtw89_dev *rtwdev,
+			       struct rtw89_core_tx_request *tx_req)
+{
+	struct rtw89_tx_desc_info *desc_info = &tx_req->desc_info;
+	struct sk_buff *skb = tx_req->skb;
+	struct ieee80211_hdr *hdr = (void *)skb->data;
+	enum rtw89_core_tx_type tx_type;
+	enum btc_pkt_type pkt_type;
+	bool is_bmc;
+	u16 seq;
+
+	seq = (le16_to_cpu(hdr->seq_ctrl) & IEEE80211_SCTL_SEQ) >> 4;
+	if (tx_req->tx_type != RTW89_CORE_TX_TYPE_FWCMD) {
+		tx_type = rtw89_core_get_tx_type(rtwdev, skb);
+		tx_req->tx_type = tx_type;
+	}
+	is_bmc = (is_broadcast_ether_addr(hdr->addr1) ||
+		  is_multicast_ether_addr(hdr->addr1));
+
+	desc_info->seq = seq;
+	desc_info->pkt_size = skb->len;
+	desc_info->is_bmc = is_bmc;
+	desc_info->wd_page = true;
+
+	switch (tx_req->tx_type) {
+	case RTW89_CORE_TX_TYPE_MGMT:
+		rtw89_core_tx_update_mgmt_info(rtwdev, tx_req);
+		break;
+	case RTW89_CORE_TX_TYPE_DATA:
+		rtw89_core_tx_update_data_info(rtwdev, tx_req);
+		pkt_type = rtw89_core_tx_btc_spec_pkt_notify(rtwdev, tx_req);
+		rtw89_core_tx_update_he_qos_htc(rtwdev, tx_req, pkt_type);
+		break;
+	case RTW89_CORE_TX_TYPE_FWCMD:
+		rtw89_core_tx_update_h2c_info(rtwdev, tx_req);
+		break;
+	}
+}
+
+void rtw89_core_tx_kick_off(struct rtw89_dev *rtwdev, u8 qsel)
+{
+	u8 ch_dma;
+
+	ch_dma = rtw89_core_get_ch_dma(rtwdev, qsel);
+
+	rtw89_hci_tx_kick_off(rtwdev, ch_dma);
+}
+
+int rtw89_h2c_tx(struct rtw89_dev *rtwdev,
+		 struct sk_buff *skb, bool fwdl)
+{
+	struct rtw89_core_tx_request tx_req = {0};
+	int ret;
+
+	tx_req.skb = skb;
+	tx_req.tx_type = RTW89_CORE_TX_TYPE_FWCMD;
+	if (fwdl)
+		tx_req.desc_info.fw_dl = true;
+
+	rtw89_core_tx_update_desc_info(rtwdev, &tx_req);
+
+	if (!fwdl)
+		rtw89_hex_dump(rtwdev, RTW89_DBG_FW, "H2C: ", skb->data, skb->len);
+
+	ret = rtw89_hci_tx_write(rtwdev, &tx_req);
+	if (ret) {
+		rtw89_err(rtwdev, "failed to transmit skb to HCI\n");
+		return ret;
+	}
+	rtw89_hci_tx_kick_off(rtwdev, RTW89_TXCH_CH12);
+
+	return 0;
+}
+
+int rtw89_core_tx_write(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif,
+			struct ieee80211_sta *sta, struct sk_buff *skb, int *qsel)
+{
+	struct rtw89_core_tx_request tx_req = {0};
+	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
+	int ret;
+
+	tx_req.skb = skb;
+	tx_req.sta = sta;
+	tx_req.vif = vif;
+
+	rtw89_traffic_stats_accu(rtwdev, &rtwdev->stats, skb, true);
+	rtw89_traffic_stats_accu(rtwdev, &rtwvif->stats, skb, true);
+	rtw89_core_tx_update_desc_info(rtwdev, &tx_req);
+	ret = rtw89_hci_tx_write(rtwdev, &tx_req);
+	if (ret) {
+		rtw89_err(rtwdev, "failed to transmit skb to HCI\n");
+		return ret;
+	}
+
+	if (qsel)
+		*qsel = tx_req.desc_info.qsel;
+
+	return 0;
+}
+
+void rtw89_core_fill_txdesc(struct rtw89_dev *rtwdev,
+			    struct rtw89_tx_desc_info *desc_info,
+			    void *txdesc)
+{
+	RTW89_SET_TXWD_BODY_WP_OFFSET(txdesc, desc_info->wp_offset);
+	RTW89_SET_TXWD_BODY_WD_INFO_EN(txdesc, desc_info->en_wd_info);
+	RTW89_SET_TXWD_BODY_CHANNEL_DMA(txdesc, desc_info->ch_dma);
+	RTW89_SET_TXWD_BODY_HDR_LLC_LEN(txdesc, desc_info->hdr_llc_len);
+	RTW89_SET_TXWD_BODY_WD_PAGE(txdesc, desc_info->wd_page);
+	RTW89_SET_TXWD_BODY_FW_DL(txdesc, desc_info->fw_dl);
+	RTW89_SET_TXWD_BODY_SW_SEQ(txdesc, desc_info->seq);
+
+	RTW89_SET_TXWD_BODY_TID_INDICATE(txdesc, desc_info->tid_indicate);
+	RTW89_SET_TXWD_BODY_QSEL(txdesc, desc_info->qsel);
+	RTW89_SET_TXWD_BODY_TXPKT_SIZE(txdesc, desc_info->pkt_size);
+	RTW89_SET_TXWD_BODY_AGG_EN(txdesc, desc_info->agg_en);
+	RTW89_SET_TXWD_BODY_BK(txdesc, desc_info->bk);
+
+	if (!desc_info->en_wd_info)
+		return;
+
+	RTW89_SET_TXWD_INFO_USE_RATE(txdesc, desc_info->use_rate);
+	RTW89_SET_TXWD_INFO_DATA_RATE(txdesc, desc_info->data_rate);
+	RTW89_SET_TXWD_INFO_DISDATAFB(txdesc, desc_info->dis_data_fb);
+	RTW89_SET_TXWD_INFO_MAX_AGGNUM(txdesc, desc_info->ampdu_num);
+	RTW89_SET_TXWD_INFO_AMPDU_DENSITY(txdesc, desc_info->ampdu_density);
+	RTW89_SET_TXWD_INFO_SEC_TYPE(txdesc, desc_info->sec_type);
+	RTW89_SET_TXWD_INFO_SEC_HW_ENC(txdesc, desc_info->sec_en);
+	RTW89_SET_TXWD_INFO_SEC_CAM_IDX(txdesc, desc_info->sec_cam_idx);
+	RTW89_SET_TXWD_INFO_RTS_EN(txdesc, 1);
+	RTW89_SET_TXWD_INFO_HW_RTS_EN(txdesc, 1);
+	RTW89_SET_TXWD_INFO_A_CTRL_BSR(txdesc, desc_info->a_ctrl_bsr);
+}
+EXPORT_SYMBOL(rtw89_core_fill_txdesc);
+
+static int rtw89_core_rx_process_mac_ppdu(struct rtw89_dev *rtwdev,
+					  struct sk_buff *skb,
+					  struct rtw89_rx_phy_ppdu *phy_ppdu)
+{
+	bool rx_cnt_valid = false;
+	u8 plcp_size = 0;
+	u8 usr_num = 0;
+	u8 *phy_sts;
+
+	rx_cnt_valid = RTW89_GET_RXINFO_RX_CNT_VLD(skb->data);
+	plcp_size = RTW89_GET_RXINFO_PLCP_LEN(skb->data) << 3;
+	usr_num = RTW89_GET_RXINFO_USR_NUM(skb->data);
+	if (usr_num > RTW89_PPDU_MAX_USR) {
+		rtw89_warn(rtwdev, "Invalid user number in mac info\n");
+		return -EINVAL;
+	}
+
+	phy_sts = skb->data + RTW89_PPDU_MAC_INFO_SIZE;
+	phy_sts += usr_num * RTW89_PPDU_MAC_INFO_USR_SIZE;
+	/* 8-byte alignment */
+	if (usr_num & BIT(0))
+		phy_sts += RTW89_PPDU_MAC_INFO_USR_SIZE;
+	if (rx_cnt_valid)
+		phy_sts += RTW89_PPDU_MAC_RX_CNT_SIZE;
+	phy_sts += plcp_size;
+
+	phy_ppdu->buf = phy_sts;
+	phy_ppdu->len = skb->data + skb->len - phy_sts;
+
+	return 0;
+}
+
+static void rtw89_core_rx_process_phy_ppdu_iter(void *data,
+						struct ieee80211_sta *sta)
+{
+	struct rtw89_sta *rtwsta = (struct rtw89_sta *)sta->drv_priv;
+	struct rtw89_rx_phy_ppdu *phy_ppdu = (struct rtw89_rx_phy_ppdu *)data;
+
+	if (rtwsta->mac_id == phy_ppdu->mac_id && phy_ppdu->to_self)
+		ewma_rssi_add(&rtwsta->avg_rssi, phy_ppdu->rssi_avg);
+}
+
+#define VAR_LEN 0xff
+#define VAR_LEN_UNIT 8
+static u16 rtw89_core_get_phy_status_ie_len(struct rtw89_dev *rtwdev, u8 *addr)
+{
+	static const u8 physts_ie_len_tab[32] = {
+		16, 32, 24, 24, 8, 8, 8, 8, VAR_LEN, 8, VAR_LEN, 176, VAR_LEN,
+		VAR_LEN, VAR_LEN, VAR_LEN, VAR_LEN, VAR_LEN, 16, 24, VAR_LEN,
+		VAR_LEN, VAR_LEN, 0, 24, 24, 24, 24, 32, 32, 32, 32
+	};
+	u16 ie_len;
+	u8 ie;
+
+	ie = RTW89_GET_PHY_STS_IE_TYPE(addr);
+	if (physts_ie_len_tab[ie] != VAR_LEN)
+		ie_len = physts_ie_len_tab[ie];
+	else
+		ie_len = RTW89_GET_PHY_STS_IE_LEN(addr) * VAR_LEN_UNIT;
+
+	return ie_len;
+}
+
+static void rtw89_core_parse_phy_status_ie01(struct rtw89_dev *rtwdev, u8 *addr,
+					     struct rtw89_rx_phy_ppdu *phy_ppdu)
+{
+	s16 cfo;
+
+	/* sign conversion for S(12,2) */
+	cfo = sign_extend32(RTW89_GET_PHY_STS_IE0_CFO(addr), 11);
+	rtw89_phy_cfo_parse(rtwdev, cfo, phy_ppdu);
+}
+
+static int rtw89_core_process_phy_status_ie(struct rtw89_dev *rtwdev, u8 *addr,
+					    struct rtw89_rx_phy_ppdu *phy_ppdu)
+{
+	u8 ie;
+
+	ie = RTW89_GET_PHY_STS_IE_TYPE(addr);
+	switch (ie) {
+	case RTW89_PHYSTS_IE01_CMN_OFDM:
+		rtw89_core_parse_phy_status_ie01(rtwdev, addr, phy_ppdu);
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static void rtw89_core_update_phy_ppdu(struct rtw89_rx_phy_ppdu *phy_ppdu)
+{
+	s8 *rssi = phy_ppdu->rssi;
+	u8 *buf = phy_ppdu->buf;
+
+	phy_ppdu->rssi_avg = RTW89_GET_PHY_STS_RSSI_AVG(buf);
+	rssi[RF_PATH_A] = RTW89_RSSI_RAW_TO_DBM(RTW89_GET_PHY_STS_RSSI_A(buf));
+	rssi[RF_PATH_B] = RTW89_RSSI_RAW_TO_DBM(RTW89_GET_PHY_STS_RSSI_B(buf));
+	rssi[RF_PATH_C] = RTW89_RSSI_RAW_TO_DBM(RTW89_GET_PHY_STS_RSSI_C(buf));
+	rssi[RF_PATH_D] = RTW89_RSSI_RAW_TO_DBM(RTW89_GET_PHY_STS_RSSI_D(buf));
+}
+
+static int rtw89_core_rx_process_phy_ppdu(struct rtw89_dev *rtwdev,
+					  struct rtw89_rx_phy_ppdu *phy_ppdu)
+{
+	if (RTW89_GET_PHY_STS_LEN(phy_ppdu->buf) << 3 != phy_ppdu->len) {
+		rtw89_warn(rtwdev, "phy ppdu len mismatch\n");
+		return -EINVAL;
+	}
+	rtw89_core_update_phy_ppdu(phy_ppdu);
+	ieee80211_iterate_stations_atomic(rtwdev->hw,
+					  rtw89_core_rx_process_phy_ppdu_iter,
+					  phy_ppdu);
+
+	return 0;
+}
+
+static int rtw89_core_rx_parse_phy_sts(struct rtw89_dev *rtwdev,
+				       struct rtw89_rx_phy_ppdu *phy_ppdu)
+{
+	u16 ie_len;
+	u8 *pos, *end;
+
+	if (!phy_ppdu->to_self)
+		return 0;
+
+	pos = (u8 *)phy_ppdu->buf + PHY_STS_HDR_LEN;
+	end = (u8 *)phy_ppdu->buf + phy_ppdu->len;
+	while (pos < end) {
+		ie_len = rtw89_core_get_phy_status_ie_len(rtwdev, pos);
+		rtw89_core_process_phy_status_ie(rtwdev, pos, phy_ppdu);
+		pos += ie_len;
+		if (pos > end || ie_len == 0) {
+			rtw89_debug(rtwdev, RTW89_DBG_TXRX,
+				    "phy status parse failed\n");
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
+static void rtw89_core_rx_process_phy_sts(struct rtw89_dev *rtwdev,
+					  struct rtw89_rx_phy_ppdu *phy_ppdu)
+{
+	int ret;
+
+	ret = rtw89_core_rx_parse_phy_sts(rtwdev, phy_ppdu);
+	if (ret)
+		rtw89_debug(rtwdev, RTW89_DBG_TXRX, "parse phy sts failed\n");
+	else
+		phy_ppdu->valid = true;
+}
+
+static u8 rtw89_rxdesc_to_nl_he_gi(struct rtw89_dev *rtwdev,
+				   const struct rtw89_rx_desc_info *desc_info,
+				   bool rx_status)
+{
+	switch (desc_info->gi_ltf) {
+	case RTW89_GILTF_SGI_4XHE08:
+	case RTW89_GILTF_2XHE08:
+	case RTW89_GILTF_1XHE08:
+		return NL80211_RATE_INFO_HE_GI_0_8;
+	case RTW89_GILTF_2XHE16:
+	case RTW89_GILTF_1XHE16:
+		return NL80211_RATE_INFO_HE_GI_1_6;
+	case RTW89_GILTF_LGI_4XHE32:
+		return NL80211_RATE_INFO_HE_GI_3_2;
+	default:
+		rtw89_warn(rtwdev, "invalid gi_ltf=%d", desc_info->gi_ltf);
+		return rx_status ? NL80211_RATE_INFO_HE_GI_3_2 : U8_MAX;
+	}
+}
+
+static bool rtw89_core_rx_ppdu_match(struct rtw89_dev *rtwdev,
+				     struct rtw89_rx_desc_info *desc_info,
+				     struct ieee80211_rx_status *status)
+{
+	u8 band = desc_info->bb_sel ? RTW89_PHY_1 : RTW89_PHY_0;
+	u8 data_rate_mode, bw, rate_idx = MASKBYTE0, gi_ltf;
+	u16 data_rate;
+	bool ret;
+
+	data_rate = desc_info->data_rate;
+	data_rate_mode = GET_DATA_RATE_MODE(data_rate);
+	if (data_rate_mode == DATA_RATE_MODE_NON_HT) {
+		rate_idx = GET_DATA_RATE_NOT_HT_IDX(data_rate);
+		/* No 4 CCK rates for 5G */
+		if (status->band == NL80211_BAND_5GHZ)
+			rate_idx -= 4;
+	} else if (data_rate_mode == DATA_RATE_MODE_HT) {
+		rate_idx = GET_DATA_RATE_HT_IDX(data_rate);
+	} else if (data_rate_mode == DATA_RATE_MODE_VHT) {
+		rate_idx = GET_DATA_RATE_VHT_HE_IDX(data_rate);
+	} else if (data_rate_mode == DATA_RATE_MODE_HE) {
+		rate_idx = GET_DATA_RATE_VHT_HE_IDX(data_rate);
+	} else {
+		rtw89_warn(rtwdev, "invalid RX rate mode %d\n", data_rate_mode);
+	}
+
+	if (desc_info->bw == RTW89_CHANNEL_WIDTH_80)
+		bw = RATE_INFO_BW_80;
+	else if (desc_info->bw == RTW89_CHANNEL_WIDTH_40)
+		bw = RATE_INFO_BW_40;
+	else
+		bw = RATE_INFO_BW_20;
+
+	gi_ltf = rtw89_rxdesc_to_nl_he_gi(rtwdev, desc_info, false);
+	ret = rtwdev->ppdu_sts.curr_rx_ppdu_cnt[band] == desc_info->ppdu_cnt &&
+	      status->rate_idx == rate_idx &&
+	      status->he_gi == gi_ltf &&
+	      status->bw == bw;
+
+	return ret;
+}
+
+struct rtw89_vif_rx_stats_iter_data {
+	struct rtw89_dev *rtwdev;
+	struct rtw89_rx_phy_ppdu *phy_ppdu;
+	struct rtw89_rx_desc_info *desc_info;
+	struct sk_buff *skb;
+	const u8 *bssid;
+};
+
+static void rtw89_vif_rx_stats_iter(void *data, u8 *mac,
+				    struct ieee80211_vif *vif)
+{
+	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
+	struct rtw89_vif_rx_stats_iter_data *iter_data = data;
+	struct rtw89_dev *rtwdev = iter_data->rtwdev;
+	struct rtw89_pkt_stat *pkt_stat = &rtwdev->phystat.cur_pkt_stat;
+	struct rtw89_rx_desc_info *desc_info = iter_data->desc_info;
+	struct sk_buff *skb = iter_data->skb;
+	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
+	const u8 *bssid = iter_data->bssid;
+
+	if (!ether_addr_equal(vif->bss_conf.bssid, bssid))
+		return;
+
+	if (ieee80211_is_beacon(hdr->frame_control))
+		pkt_stat->beacon_nr++;
+
+	if (!ether_addr_equal(vif->addr, hdr->addr1))
+		return;
+
+	if (desc_info->data_rate < RTW89_HW_RATE_NR)
+		pkt_stat->rx_rate_cnt[desc_info->data_rate]++;
+
+	rtw89_traffic_stats_accu(rtwdev, &rtwvif->stats, skb, false);
+}
+
+static void rtw89_core_rx_stats(struct rtw89_dev *rtwdev,
+				struct rtw89_rx_phy_ppdu *phy_ppdu,
+				struct rtw89_rx_desc_info *desc_info,
+				struct sk_buff *skb)
+{
+	struct rtw89_vif_rx_stats_iter_data iter_data;
+
+	rtw89_traffic_stats_accu(rtwdev, &rtwdev->stats, skb, false);
+
+	iter_data.rtwdev = rtwdev;
+	iter_data.phy_ppdu = phy_ppdu;
+	iter_data.desc_info = desc_info;
+	iter_data.skb = skb;
+	iter_data.bssid = get_hdr_bssid((struct ieee80211_hdr *)skb->data);
+	rtw89_iterate_vifs_bh(rtwdev, rtw89_vif_rx_stats_iter, &iter_data);
+}
+
+static void rtw89_core_rx_pending_skb(struct rtw89_dev *rtwdev,
+				      struct rtw89_rx_phy_ppdu *phy_ppdu,
+				      struct rtw89_rx_desc_info *desc_info,
+				      struct sk_buff *skb)
+{
+	u8 band = desc_info->bb_sel ? RTW89_PHY_1 : RTW89_PHY_0;
+	int curr = rtwdev->ppdu_sts.curr_rx_ppdu_cnt[band];
+	struct sk_buff *skb_ppdu = NULL, *tmp;
+	struct ieee80211_rx_status *rx_status;
+
+	if (curr > RTW89_MAX_PPDU_CNT)
+		return;
+
+	skb_queue_walk_safe(&rtwdev->ppdu_sts.rx_queue[band], skb_ppdu, tmp) {
+		skb_unlink(skb_ppdu, &rtwdev->ppdu_sts.rx_queue[band]);
+		rx_status = IEEE80211_SKB_RXCB(skb_ppdu);
+		if (rtw89_core_rx_ppdu_match(rtwdev, desc_info, rx_status))
+			rtw89_chip_query_ppdu(rtwdev, phy_ppdu, rx_status);
+		rtw89_core_rx_stats(rtwdev, phy_ppdu, desc_info, skb_ppdu);
+		ieee80211_rx_napi(rtwdev->hw, NULL, skb_ppdu, &rtwdev->napi);
+		rtwdev->napi_budget_countdown--;
+	}
+}
+
+static void rtw89_core_rx_process_ppdu_sts(struct rtw89_dev *rtwdev,
+					   struct rtw89_rx_desc_info *desc_info,
+					   struct sk_buff *skb)
+{
+	struct rtw89_rx_phy_ppdu phy_ppdu = {.buf = skb->data, .valid = false,
+					     .len = skb->len,
+					     .to_self = desc_info->addr1_match,
+					     .mac_id = desc_info->mac_id};
+	int ret;
+
+	if (desc_info->mac_info_valid)
+		rtw89_core_rx_process_mac_ppdu(rtwdev, skb, &phy_ppdu);
+	ret = rtw89_core_rx_process_phy_ppdu(rtwdev, &phy_ppdu);
+	if (ret)
+		rtw89_debug(rtwdev, RTW89_DBG_TXRX, "process ppdu failed\n");
+
+	rtw89_core_rx_process_phy_sts(rtwdev, &phy_ppdu);
+	rtw89_core_rx_pending_skb(rtwdev, &phy_ppdu, desc_info, skb);
+	dev_kfree_skb_any(skb);
+}
+
+static void rtw89_core_rx_process_report(struct rtw89_dev *rtwdev,
+					 struct rtw89_rx_desc_info *desc_info,
+					 struct sk_buff *skb)
+{
+	switch (desc_info->pkt_type) {
+	case RTW89_CORE_RX_TYPE_C2H:
+		rtw89_fw_c2h_irqsafe(rtwdev, skb);
+		break;
+	case RTW89_CORE_RX_TYPE_PPDU_STAT:
+		rtw89_core_rx_process_ppdu_sts(rtwdev, desc_info, skb);
+		break;
+	default:
+		rtw89_debug(rtwdev, RTW89_DBG_TXRX, "unhandled pkt_type=%d\n",
+			    desc_info->pkt_type);
+		dev_kfree_skb_any(skb);
+		break;
+	}
+}
+
+void rtw89_core_query_rxdesc(struct rtw89_dev *rtwdev,
+			     struct rtw89_rx_desc_info *desc_info,
+			     u8 *data, u32 data_offset)
+{
+	struct rtw89_rxdesc_short *rxd_s;
+	struct rtw89_rxdesc_long *rxd_l;
+	u8 shift_len, drv_info_len;
+
+	rxd_s = (struct rtw89_rxdesc_short *)(data + data_offset);
+	desc_info->pkt_size = RTW89_GET_RXWD_PKT_SIZE(rxd_s);
+	desc_info->drv_info_size = RTW89_GET_RXWD_DRV_INFO_SIZE(rxd_s);
+	desc_info->long_rxdesc = RTW89_GET_RXWD_LONG_RXD(rxd_s);
+	desc_info->pkt_type = RTW89_GET_RXWD_RPKT_TYPE(rxd_s);
+	desc_info->mac_info_valid = RTW89_GET_RXWD_MAC_INFO_VALID(rxd_s);
+	desc_info->bw = RTW89_GET_RXWD_BW(rxd_s);
+	desc_info->data_rate = RTW89_GET_RXWD_DATA_RATE(rxd_s);
+	desc_info->gi_ltf = RTW89_GET_RXWD_GI_LTF(rxd_s);
+	desc_info->user_id = RTW89_GET_RXWD_USER_ID(rxd_s);
+	desc_info->sr_en = RTW89_GET_RXWD_SR_EN(rxd_s);
+	desc_info->ppdu_cnt = RTW89_GET_RXWD_PPDU_CNT(rxd_s);
+	desc_info->ppdu_type = RTW89_GET_RXWD_PPDU_TYPE(rxd_s);
+	desc_info->free_run_cnt = RTW89_GET_RXWD_FREE_RUN_CNT(rxd_s);
+	desc_info->icv_err = RTW89_GET_RXWD_ICV_ERR(rxd_s);
+	desc_info->crc32_err = RTW89_GET_RXWD_CRC32_ERR(rxd_s);
+	desc_info->hw_dec = RTW89_GET_RXWD_HW_DEC(rxd_s);
+	desc_info->sw_dec = RTW89_GET_RXWD_SW_DEC(rxd_s);
+	desc_info->addr1_match = RTW89_GET_RXWD_A1_MATCH(rxd_s);
+
+	shift_len = desc_info->shift << 1; /* 2-byte unit */
+	drv_info_len = desc_info->drv_info_size << 3; /* 8-byte unit */
+	desc_info->offset = data_offset + shift_len + drv_info_len;
+	desc_info->ready = true;
+
+	if (!desc_info->long_rxdesc)
+		return;
+
+	rxd_l = (struct rtw89_rxdesc_long *)(data + data_offset);
+	desc_info->frame_type = RTW89_GET_RXWD_TYPE(rxd_l);
+	desc_info->addr_cam_valid = RTW89_GET_RXWD_ADDR_CAM_VLD(rxd_l);
+	desc_info->addr_cam_id = RTW89_GET_RXWD_ADDR_CAM_ID(rxd_l);
+	desc_info->sec_cam_id = RTW89_GET_RXWD_SEC_CAM_ID(rxd_l);
+	desc_info->mac_id = RTW89_GET_RXWD_MAC_ID(rxd_l);
+	desc_info->rx_pl_id = RTW89_GET_RXWD_RX_PL_ID(rxd_l);
+}
+EXPORT_SYMBOL(rtw89_core_query_rxdesc);
+
+struct rtw89_core_iter_rx_status {
+	struct rtw89_dev *rtwdev;
+	struct ieee80211_rx_status *rx_status;
+	struct rtw89_rx_desc_info *desc_info;
+	u8 mac_id;
+};
+
+static
+void rtw89_core_stats_sta_rx_status_iter(void *data, struct ieee80211_sta *sta)
+{
+	struct rtw89_core_iter_rx_status *iter_data =
+				(struct rtw89_core_iter_rx_status *)data;
+	struct ieee80211_rx_status *rx_status = iter_data->rx_status;
+	struct rtw89_sta *rtwsta = (struct rtw89_sta *)sta->drv_priv;
+	struct rtw89_rx_desc_info *desc_info = iter_data->desc_info;
+	u8 mac_id = iter_data->mac_id;
+
+	if (mac_id != rtwsta->mac_id)
+		return;
+
+	rtwsta->rx_status = *rx_status;
+	rtwsta->rx_hw_rate = desc_info->data_rate;
+}
+
+static void rtw89_core_stats_sta_rx_status(struct rtw89_dev *rtwdev,
+					   struct rtw89_rx_desc_info *desc_info,
+					   struct ieee80211_rx_status *rx_status)
+{
+	struct rtw89_core_iter_rx_status iter_data;
+
+	if (!desc_info->addr1_match || !desc_info->long_rxdesc)
+		return;
+
+	if (desc_info->frame_type != RTW89_RX_TYPE_DATA)
+		return;
+
+	iter_data.rtwdev = rtwdev;
+	iter_data.rx_status = rx_status;
+	iter_data.desc_info = desc_info;
+	iter_data.mac_id = desc_info->mac_id;
+	ieee80211_iterate_stations_atomic(rtwdev->hw,
+					  rtw89_core_stats_sta_rx_status_iter,
+					  &iter_data);
+}
+
+static void rtw89_core_update_rx_status(struct rtw89_dev *rtwdev,
+					struct rtw89_rx_desc_info *desc_info,
+					struct ieee80211_rx_status *rx_status)
+{
+	struct ieee80211_hw *hw = rtwdev->hw;
+	u16 data_rate;
+	u8 data_rate_mode;
+
+	/* currently using single PHY */
+	rx_status->freq = hw->conf.chandef.chan->center_freq;
+	rx_status->band = hw->conf.chandef.chan->band;
+
+	if (desc_info->icv_err || desc_info->crc32_err)
+		rx_status->flag |= RX_FLAG_FAILED_FCS_CRC;
+
+	if (desc_info->hw_dec &&
+	    !(desc_info->sw_dec || desc_info->icv_err))
+		rx_status->flag |= RX_FLAG_DECRYPTED;
+
+	if (desc_info->bw == RTW89_CHANNEL_WIDTH_80)
+		rx_status->bw = RATE_INFO_BW_80;
+	else if (desc_info->bw == RTW89_CHANNEL_WIDTH_40)
+		rx_status->bw = RATE_INFO_BW_40;
+	else
+		rx_status->bw = RATE_INFO_BW_20;
+
+	data_rate = desc_info->data_rate;
+	data_rate_mode = GET_DATA_RATE_MODE(data_rate);
+	if (data_rate_mode == DATA_RATE_MODE_NON_HT) {
+		rx_status->encoding = RX_ENC_LEGACY;
+		rx_status->rate_idx = GET_DATA_RATE_NOT_HT_IDX(data_rate);
+		/* No 4 CCK rates for 5G */
+		if (rx_status->band == NL80211_BAND_5GHZ)
+			rx_status->rate_idx -= 4;
+		if (rtwdev->scanning)
+			rx_status->rate_idx = min_t(u8, rx_status->rate_idx,
+						    ARRAY_SIZE(rtw89_bitrates) - 5);
+	} else if (data_rate_mode == DATA_RATE_MODE_HT) {
+		rx_status->encoding = RX_ENC_HT;
+		rx_status->rate_idx = GET_DATA_RATE_HT_IDX(data_rate);
+		if (desc_info->gi_ltf)
+			rx_status->enc_flags |= RX_ENC_FLAG_SHORT_GI;
+	} else if (data_rate_mode == DATA_RATE_MODE_VHT) {
+		rx_status->encoding = RX_ENC_VHT;
+		rx_status->rate_idx = GET_DATA_RATE_VHT_HE_IDX(data_rate);
+		rx_status->nss = GET_DATA_RATE_NSS(data_rate) + 1;
+		if (desc_info->gi_ltf)
+			rx_status->enc_flags |= RX_ENC_FLAG_SHORT_GI;
+	} else if (data_rate_mode == DATA_RATE_MODE_HE) {
+		rx_status->encoding = RX_ENC_HE;
+		rx_status->rate_idx = GET_DATA_RATE_VHT_HE_IDX(data_rate);
+		rx_status->nss = GET_DATA_RATE_NSS(data_rate) + 1;
+	} else {
+		rtw89_warn(rtwdev, "invalid RX rate mode %d\n", data_rate_mode);
+	}
+
+	/* he_gi is used to match ppdu, so we always fill it. */
+	rx_status->he_gi = rtw89_rxdesc_to_nl_he_gi(rtwdev, desc_info, true);
+	rx_status->flag |= RX_FLAG_MACTIME_START;
+	rx_status->mactime = desc_info->free_run_cnt;
+
+	rtw89_core_stats_sta_rx_status(rtwdev, desc_info, rx_status);
+}
+
+static enum rtw89_ps_mode rtw89_update_ps_mode(struct rtw89_dev *rtwdev)
+{
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+
+	if (rtw89_disable_ps_mode || !chip->ps_mode_supported)
+		return RTW89_PS_MODE_NONE;
+
+	if (chip->ps_mode_supported & BIT(RTW89_PS_MODE_PWR_GATED))
+		return RTW89_PS_MODE_PWR_GATED;
+
+	if (chip->ps_mode_supported & BIT(RTW89_PS_MODE_CLK_GATED))
+		return RTW89_PS_MODE_CLK_GATED;
+
+	if (chip->ps_mode_supported & BIT(RTW89_PS_MODE_RFOFF))
+		return RTW89_PS_MODE_RFOFF;
+
+	return RTW89_PS_MODE_NONE;
+}
+
+static void rtw89_core_flush_ppdu_rx_queue(struct rtw89_dev *rtwdev,
+					   struct rtw89_rx_desc_info *desc_info)
+{
+	struct rtw89_ppdu_sts_info *ppdu_sts = &rtwdev->ppdu_sts;
+	u8 band = desc_info->bb_sel ? RTW89_PHY_1 : RTW89_PHY_0;
+	struct sk_buff *skb_ppdu, *tmp;
+
+	skb_queue_walk_safe(&ppdu_sts->rx_queue[band], skb_ppdu, tmp) {
+		skb_unlink(skb_ppdu, &ppdu_sts->rx_queue[band]);
+		rtw89_core_rx_stats(rtwdev, NULL, desc_info, skb_ppdu);
+		ieee80211_rx_napi(rtwdev->hw, NULL, skb_ppdu, &rtwdev->napi);
+		rtwdev->napi_budget_countdown--;
+	}
+}
+
+void rtw89_core_rx(struct rtw89_dev *rtwdev,
+		   struct rtw89_rx_desc_info *desc_info,
+		   struct sk_buff *skb)
+{
+	struct ieee80211_rx_status *rx_status;
+	struct rtw89_ppdu_sts_info *ppdu_sts = &rtwdev->ppdu_sts;
+	u8 ppdu_cnt = desc_info->ppdu_cnt;
+	u8 band = desc_info->bb_sel ? RTW89_PHY_1 : RTW89_PHY_0;
+
+	if (desc_info->pkt_type != RTW89_CORE_RX_TYPE_WIFI) {
+		rtw89_core_rx_process_report(rtwdev, desc_info, skb);
+		return;
+	}
+
+	if (ppdu_sts->curr_rx_ppdu_cnt[band] != ppdu_cnt) {
+		rtw89_core_flush_ppdu_rx_queue(rtwdev, desc_info);
+		ppdu_sts->curr_rx_ppdu_cnt[band] = ppdu_cnt;
+	}
+
+	rx_status = IEEE80211_SKB_RXCB(skb);
+	memset(rx_status, 0, sizeof(*rx_status));
+	rtw89_core_update_rx_status(rtwdev, desc_info, rx_status);
+	if (desc_info->long_rxdesc &&
+	    BIT(desc_info->frame_type) & PPDU_FILTER_BITMAP) {
+		skb_queue_tail(&ppdu_sts->rx_queue[band], skb);
+	} else {
+		rtw89_core_rx_stats(rtwdev, NULL, desc_info, skb);
+		ieee80211_rx_napi(rtwdev->hw, NULL, skb, &rtwdev->napi);
+		rtwdev->napi_budget_countdown--;
+	}
+}
+EXPORT_SYMBOL(rtw89_core_rx);
+
+void rtw89_core_napi_start(struct rtw89_dev *rtwdev)
+{
+	if (test_and_set_bit(RTW89_FLAG_NAPI_RUNNING, rtwdev->flags))
+		return;
+
+	napi_enable(&rtwdev->napi);
+}
+EXPORT_SYMBOL(rtw89_core_napi_start);
+
+void rtw89_core_napi_stop(struct rtw89_dev *rtwdev)
+{
+	if (!test_and_clear_bit(RTW89_FLAG_NAPI_RUNNING, rtwdev->flags))
+		return;
+
+	napi_synchronize(&rtwdev->napi);
+	napi_disable(&rtwdev->napi);
+}
+EXPORT_SYMBOL(rtw89_core_napi_stop);
+
+void rtw89_core_napi_init(struct rtw89_dev *rtwdev)
+{
+	init_dummy_netdev(&rtwdev->netdev);
+	netif_napi_add(&rtwdev->netdev, &rtwdev->napi,
+		       rtwdev->hci.ops->napi_poll, NAPI_POLL_WEIGHT);
+}
+EXPORT_SYMBOL(rtw89_core_napi_init);
+
+void rtw89_core_napi_deinit(struct rtw89_dev *rtwdev)
+{
+	rtw89_core_napi_stop(rtwdev);
+	netif_napi_del(&rtwdev->napi);
+}
+EXPORT_SYMBOL(rtw89_core_napi_deinit);
+
+static void rtw89_core_ba_work(struct work_struct *work)
+{
+	struct rtw89_dev *rtwdev =
+		container_of(work, struct rtw89_dev, ba_work);
+	struct rtw89_txq *rtwtxq, *tmp;
+	int ret;
+
+	spin_lock_bh(&rtwdev->ba_lock);
+	list_for_each_entry_safe(rtwtxq, tmp, &rtwdev->ba_list, list) {
+		struct ieee80211_txq *txq = rtw89_txq_to_txq(rtwtxq);
+		struct ieee80211_sta *sta = txq->sta;
+		struct rtw89_sta *rtwsta = (struct rtw89_sta *)sta->drv_priv;
+		u8 tid = txq->tid;
+
+		if (!sta) {
+			rtw89_warn(rtwdev, "cannot start BA without sta\n");
+			goto skip_ba_work;
+		}
+
+		if (rtwsta->disassoc) {
+			rtw89_debug(rtwdev, RTW89_DBG_TXRX,
+				    "cannot start BA with disassoc sta\n");
+			goto skip_ba_work;
+		}
+
+		ret = ieee80211_start_tx_ba_session(sta, tid, 0);
+		if (ret) {
+			rtw89_debug(rtwdev, RTW89_DBG_TXRX,
+				    "failed to setup BA session for %pM:%2d: %d\n",
+				    sta->addr, tid, ret);
+			if (ret == -EINVAL)
+				set_bit(RTW89_TXQ_F_BLOCK_BA, &rtwtxq->flags);
+		}
+skip_ba_work:
+		list_del_init(&rtwtxq->list);
+	}
+	spin_unlock_bh(&rtwdev->ba_lock);
+}
+
+static void rtw89_core_free_sta_pending_ba(struct rtw89_dev *rtwdev,
+					   struct ieee80211_sta *sta)
+{
+	struct rtw89_txq *rtwtxq, *tmp;
+
+	spin_lock_bh(&rtwdev->ba_lock);
+	list_for_each_entry_safe(rtwtxq, tmp, &rtwdev->ba_list, list) {
+		struct ieee80211_txq *txq = rtw89_txq_to_txq(rtwtxq);
+
+		if (sta == txq->sta)
+			list_del_init(&rtwtxq->list);
+	}
+	spin_unlock_bh(&rtwdev->ba_lock);
+}
+
+static void rtw89_core_txq_check_agg(struct rtw89_dev *rtwdev,
+				     struct rtw89_txq *rtwtxq,
+				     struct sk_buff *skb)
+{
+	struct ieee80211_hw *hw = rtwdev->hw;
+	struct ieee80211_txq *txq = rtw89_txq_to_txq(rtwtxq);
+	struct ieee80211_sta *sta = txq->sta;
+	struct rtw89_sta *rtwsta = (struct rtw89_sta *)sta->drv_priv;
+
+	if (unlikely(skb_get_queue_mapping(skb) == IEEE80211_AC_VO))
+		return;
+
+	if (unlikely(skb->protocol == cpu_to_be16(ETH_P_PAE)))
+		return;
+
+	if (unlikely(!sta))
+		return;
+
+	if (unlikely(test_bit(RTW89_TXQ_F_BLOCK_BA, &rtwtxq->flags)))
+		return;
+
+	if (test_bit(RTW89_TXQ_F_AMPDU, &rtwtxq->flags)) {
+		IEEE80211_SKB_CB(skb)->flags |= IEEE80211_TX_CTL_AMPDU;
+		return;
+	}
+
+	spin_lock_bh(&rtwdev->ba_lock);
+	if (!rtwsta->disassoc && list_empty(&rtwtxq->list)) {
+		list_add_tail(&rtwtxq->list, &rtwdev->ba_list);
+		ieee80211_queue_work(hw, &rtwdev->ba_work);
+	}
+	spin_unlock_bh(&rtwdev->ba_lock);
+}
+
+static void rtw89_core_txq_push(struct rtw89_dev *rtwdev,
+				struct rtw89_txq *rtwtxq,
+				unsigned long frame_cnt,
+				unsigned long byte_cnt)
+{
+	struct ieee80211_txq *txq = rtw89_txq_to_txq(rtwtxq);
+	struct ieee80211_vif *vif = txq->vif;
+	struct ieee80211_sta *sta = txq->sta;
+	struct sk_buff *skb;
+	unsigned long i;
+	int ret;
+
+	for (i = 0; i < frame_cnt; i++) {
+		skb = ieee80211_tx_dequeue_ni(rtwdev->hw, txq);
+		if (!skb) {
+			rtw89_debug(rtwdev, RTW89_DBG_TXRX, "dequeue a NULL skb\n");
+			return;
+		}
+		rtw89_core_txq_check_agg(rtwdev, rtwtxq, skb);
+		ret = rtw89_core_tx_write(rtwdev, vif, sta, skb, NULL);
+		if (ret) {
+			rtw89_err(rtwdev, "failed to push txq: %d\n", ret);
+			ieee80211_free_txskb(rtwdev->hw, skb);
+			break;
+		}
+	}
+}
+
+static u32 rtw89_check_and_reclaim_tx_resource(struct rtw89_dev *rtwdev, u8 tid)
+{
+	u8 qsel, ch_dma;
+
+	qsel = rtw89_core_get_qsel(rtwdev, tid);
+	ch_dma = rtw89_core_get_ch_dma(rtwdev, qsel);
+
+	return rtw89_hci_check_and_reclaim_tx_resource(rtwdev, ch_dma);
+}
+
+static bool rtw89_core_txq_agg_wait(struct rtw89_dev *rtwdev,
+				    struct ieee80211_txq *txq,
+				    unsigned long *frame_cnt,
+				    bool *sched_txq, bool *reinvoke)
+{
+	struct rtw89_txq *rtwtxq = (struct rtw89_txq *)txq->drv_priv;
+	struct ieee80211_sta *sta = txq->sta;
+	struct rtw89_sta *rtwsta = (struct rtw89_sta *)sta->drv_priv;
+
+	if (!sta || rtwsta->max_agg_wait <= 0)
+		return false;
+
+	if (rtwdev->stats.tx_tfc_lv <= RTW89_TFC_MID)
+		return false;
+
+	if (*frame_cnt > 1) {
+		*frame_cnt -= 1;
+		*sched_txq = true;
+		*reinvoke = true;
+		rtwtxq->wait_cnt = 1;
+		return false;
+	}
+
+	if (*frame_cnt == 1 && rtwtxq->wait_cnt < rtwsta->max_agg_wait) {
+		*reinvoke = true;
+		rtwtxq->wait_cnt++;
+		return true;
+	}
+
+	rtwtxq->wait_cnt = 0;
+	return false;
+}
+
+static void rtw89_core_txq_schedule(struct rtw89_dev *rtwdev, u8 ac, bool *reinvoke)
+{
+	struct ieee80211_hw *hw = rtwdev->hw;
+	struct ieee80211_txq *txq;
+	struct rtw89_txq *rtwtxq;
+	unsigned long frame_cnt;
+	unsigned long byte_cnt;
+	u32 tx_resource;
+	bool sched_txq;
+
+	ieee80211_txq_schedule_start(hw, ac);
+	while ((txq = ieee80211_next_txq(hw, ac))) {
+		rtwtxq = (struct rtw89_txq *)txq->drv_priv;
+		tx_resource = rtw89_check_and_reclaim_tx_resource(rtwdev, txq->tid);
+		sched_txq = false;
+
+		ieee80211_txq_get_depth(txq, &frame_cnt, &byte_cnt);
+		if (rtw89_core_txq_agg_wait(rtwdev, txq, &frame_cnt, &sched_txq, reinvoke)) {
+			ieee80211_return_txq(hw, txq, true);
+			continue;
+		}
+		frame_cnt = min_t(unsigned long, frame_cnt, tx_resource);
+		rtw89_core_txq_push(rtwdev, rtwtxq, frame_cnt, byte_cnt);
+		ieee80211_return_txq(hw, txq, sched_txq);
+		if (frame_cnt != 0)
+			rtw89_core_tx_kick_off(rtwdev, rtw89_core_get_qsel(rtwdev, txq->tid));
+	}
+	ieee80211_txq_schedule_end(hw, ac);
+}
+
+static void rtw89_core_txq_work(struct work_struct *w)
+{
+	struct rtw89_dev *rtwdev = container_of(w, struct rtw89_dev, txq_work);
+	bool reinvoke = false;
+	u8 ac;
+
+	for (ac = 0; ac < IEEE80211_NUM_ACS; ac++)
+		rtw89_core_txq_schedule(rtwdev, ac, &reinvoke);
+
+	if (reinvoke) {
+		/* reinvoke to process the last frame */
+		mod_delayed_work(rtwdev->txq_wq, &rtwdev->txq_reinvoke_work, 1);
+	}
+}
+
+static void rtw89_core_txq_reinvoke_work(struct work_struct *w)
+{
+	struct rtw89_dev *rtwdev = container_of(w, struct rtw89_dev,
+						txq_reinvoke_work.work);
+
+	queue_work(rtwdev->txq_wq, &rtwdev->txq_work);
+}
+
+static enum rtw89_tfc_lv rtw89_get_traffic_level(struct rtw89_dev *rtwdev,
+						 u32 throughput, u64 cnt)
+{
+	if (cnt < 100)
+		return RTW89_TFC_IDLE;
+	if (throughput > 50)
+		return RTW89_TFC_HIGH;
+	if (throughput > 10)
+		return RTW89_TFC_MID;
+	if (throughput > 2)
+		return RTW89_TFC_LOW;
+	return RTW89_TFC_ULTRA_LOW;
+}
+
+static void rtw89_traffic_stats_calc(struct rtw89_dev *rtwdev,
+				     struct rtw89_traffic_stats *stats)
+{
+	enum rtw89_tfc_lv tx_tfc_lv = stats->tx_tfc_lv;
+	enum rtw89_tfc_lv rx_tfc_lv = stats->rx_tfc_lv;
+
+	stats->tx_throughput_raw = (u32)(stats->tx_unicast >> RTW89_TP_SHIFT);
+	stats->rx_throughput_raw = (u32)(stats->rx_unicast >> RTW89_TP_SHIFT);
+
+	ewma_tp_add(&stats->tx_ewma_tp, stats->tx_throughput_raw);
+	ewma_tp_add(&stats->rx_ewma_tp, stats->rx_throughput_raw);
+
+	stats->tx_throughput = ewma_tp_read(&stats->tx_ewma_tp);
+	stats->rx_throughput = ewma_tp_read(&stats->rx_ewma_tp);
+	stats->tx_tfc_lv = rtw89_get_traffic_level(rtwdev, stats->tx_throughput,
+						   stats->tx_cnt);
+	stats->rx_tfc_lv = rtw89_get_traffic_level(rtwdev, stats->rx_throughput,
+						   stats->rx_cnt);
+	stats->tx_avg_len = (u32)(stats->tx_cnt ? stats->tx_unicast / stats->tx_cnt : 0);
+	stats->rx_avg_len = (u32)(stats->rx_cnt ? stats->rx_unicast / stats->rx_cnt : 0);
+
+	stats->tx_unicast = 0;
+	stats->rx_unicast = 0;
+	stats->tx_cnt = 0;
+	stats->rx_cnt = 0;
+
+	if (tx_tfc_lv != stats->tx_tfc_lv || rx_tfc_lv != stats->rx_tfc_lv)
+		ieee80211_queue_work(rtwdev->hw, &rtwdev->btc.wl_sta_notify_work);
+}
+
+static void rtw89_vif_traffic_stats_iter(void *data, u8 *mac,
+					 struct ieee80211_vif *vif)
+{
+	struct rtw89_dev *rtwdev = data;
+	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
+
+	rtw89_traffic_stats_calc(rtwdev, &rtwvif->stats);
+}
+
+static void rtw89_traffic_stats_track(struct rtw89_dev *rtwdev)
+{
+	rtw89_traffic_stats_calc(rtwdev, &rtwdev->stats);
+
+	rtw89_iterate_vifs(rtwdev, rtw89_vif_traffic_stats_iter, rtwdev, false);
+}
+
+static void rtw89_vif_enter_lps_iter(void *data, u8 *mac,
+				     struct ieee80211_vif *vif)
+{
+	struct rtw89_dev *rtwdev = data;
+	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
+
+	if (rtwvif->wifi_role != RTW89_WIFI_ROLE_STATION)
+		return;
+
+	if (rtwvif->stats.tx_tfc_lv == RTW89_TFC_IDLE &&
+	    rtwvif->stats.rx_tfc_lv == RTW89_TFC_IDLE)
+		rtw89_enter_lps(rtwdev, rtwvif->mac_id);
+}
+
+static void rtw89_enter_lps_track(struct rtw89_dev *rtwdev)
+{
+	rtw89_iterate_vifs(rtwdev, rtw89_vif_enter_lps_iter, rtwdev, false);
+}
+
+void rtw89_traffic_stats_init(struct rtw89_dev *rtwdev,
+			      struct rtw89_traffic_stats *stats)
+{
+	stats->tx_unicast = 0;
+	stats->rx_unicast = 0;
+	stats->tx_cnt = 0;
+	stats->rx_cnt = 0;
+	ewma_tp_init(&stats->tx_ewma_tp);
+	ewma_tp_init(&stats->rx_ewma_tp);
+}
+
+static void rtw89_track_work(struct work_struct *work)
+{
+	struct rtw89_dev *rtwdev = container_of(work, struct rtw89_dev,
+						track_work.work);
+
+	mutex_lock(&rtwdev->mutex);
+
+	if (!test_bit(RTW89_FLAG_RUNNING, rtwdev->flags))
+		goto out;
+
+	ieee80211_queue_delayed_work(rtwdev->hw, &rtwdev->track_work,
+				     RTW89_TRACK_WORK_PERIOD);
+
+	rtw89_leave_lps(rtwdev, false);
+
+	rtw89_traffic_stats_track(rtwdev);
+	rtw89_mac_bf_monitor_track(rtwdev);
+	rtw89_phy_stat_track(rtwdev);
+	rtw89_phy_env_monitor_track(rtwdev);
+	rtw89_phy_dig(rtwdev);
+	rtw89_chip_rfk_track(rtwdev);
+	rtw89_phy_ra_update(rtwdev);
+	rtw89_phy_cfo_track(rtwdev);
+
+	if (rtwdev->lps_enabled && !rtwdev->btc.lps && !rtwdev->scanning)
+		rtw89_enter_lps_track(rtwdev);
+
+out:
+	mutex_unlock(&rtwdev->mutex);
+}
+
+int rtw89_core_power_on(struct rtw89_dev *rtwdev)
+{
+	int ret;
+
+	ret = rtw89_mac_pwr_on(rtwdev);
+	if (ret) {
+		rtw89_err(rtwdev, "failed to start power sequence\n");
+		goto err;
+	}
+
+	return 0;
+
+err:
+	return ret;
+}
+
+u8 rtw89_core_acquire_bit_map(unsigned long *addr, unsigned long size)
+{
+	unsigned long bit;
+
+	bit = find_first_zero_bit(addr, size);
+	if (bit < size)
+		set_bit(bit, addr);
+
+	return bit;
+}
+
+void rtw89_core_release_bit_map(unsigned long *addr, u8 bit)
+{
+	clear_bit(bit, addr);
+}
+
+void rtw89_core_release_all_bits_map(unsigned long *addr, unsigned int nbits)
+{
+	bitmap_zero(addr, nbits);
+}
+
+#define RTW89_TYPE_MAPPING(_type)	\
+	case NL80211_IFTYPE_ ## _type:	\
+		rtwvif->wifi_role = RTW89_WIFI_ROLE_ ## _type;	\
+		break
+void rtw89_vif_type_mapping(struct ieee80211_vif *vif, bool assoc)
+{
+	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
+
+	switch (vif->type) {
+	RTW89_TYPE_MAPPING(ADHOC);
+	RTW89_TYPE_MAPPING(STATION);
+	RTW89_TYPE_MAPPING(AP);
+	RTW89_TYPE_MAPPING(AP_VLAN);
+	RTW89_TYPE_MAPPING(MONITOR);
+	RTW89_TYPE_MAPPING(MESH_POINT);
+	RTW89_TYPE_MAPPING(P2P_CLIENT);
+	RTW89_TYPE_MAPPING(P2P_GO);
+	RTW89_TYPE_MAPPING(P2P_DEVICE);
+	RTW89_TYPE_MAPPING(NAN);
+	default:
+		WARN_ON(1);
+		break;
+	}
+
+	switch (vif->type) {
+	case NL80211_IFTYPE_AP:
+	case NL80211_IFTYPE_MESH_POINT:
+		rtwvif->net_type = RTW89_NET_TYPE_AP_MODE;
+		rtwvif->self_role = RTW89_SELF_ROLE_AP;
+		break;
+	case NL80211_IFTYPE_ADHOC:
+		rtwvif->net_type = RTW89_NET_TYPE_AD_HOC;
+		break;
+	case NL80211_IFTYPE_STATION:
+		if (assoc) {
+			rtwvif->net_type = RTW89_NET_TYPE_INFRA;
+			rtwvif->trigger = vif->bss_conf.he_support;
+		} else {
+			rtwvif->net_type = RTW89_NET_TYPE_NO_LINK;
+			rtwvif->trigger = false;
+		}
+		rtwvif->self_role = RTW89_SELF_ROLE_CLIENT;
+		rtwvif->addr_cam.sec_ent_mode = RTW89_ADDR_CAM_SEC_NORMAL;
+		break;
+	default:
+		WARN_ON(1);
+		break;
+	}
+}
+
+int rtw89_core_sta_add(struct rtw89_dev *rtwdev,
+		       struct ieee80211_vif *vif,
+		       struct ieee80211_sta *sta)
+{
+	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
+	struct rtw89_sta *rtwsta = (struct rtw89_sta *)sta->drv_priv;
+	int i;
+
+	rtwsta->rtwvif = rtwvif;
+	rtwsta->prev_rssi = 0;
+
+	for (i = 0; i < ARRAY_SIZE(sta->txq); i++)
+		rtw89_core_txq_init(rtwdev, sta->txq[i]);
+
+	ewma_rssi_init(&rtwsta->avg_rssi);
+
+	if (vif->type == NL80211_IFTYPE_STATION) {
+		rtwvif->mgd.ap = sta;
+		rtw89_btc_ntfy_role_info(rtwdev, rtwvif, rtwsta,
+					 BTC_ROLE_MSTS_STA_CONN_START);
+		rtw89_chip_rfk_channel(rtwdev);
+	}
+
+	return 0;
+}
+
+int rtw89_core_sta_disassoc(struct rtw89_dev *rtwdev,
+			    struct ieee80211_vif *vif,
+			    struct ieee80211_sta *sta)
+{
+	struct rtw89_sta *rtwsta = (struct rtw89_sta *)sta->drv_priv;
+
+	rtwdev->total_sta_assoc--;
+	rtwsta->disassoc = true;
+
+	return 0;
+}
+
+int rtw89_core_sta_disconnect(struct rtw89_dev *rtwdev,
+			      struct ieee80211_vif *vif,
+			      struct ieee80211_sta *sta)
+{
+	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
+	int ret;
+
+	rtw89_mac_bf_monitor_calc(rtwdev, sta, true);
+	rtw89_mac_bf_disassoc(rtwdev, vif, sta);
+	rtw89_core_free_sta_pending_ba(rtwdev, sta);
+
+	rtw89_vif_type_mapping(vif, false);
+
+	ret = rtw89_fw_h2c_assoc_cmac_tbl(rtwdev, vif, sta);
+	if (ret) {
+		rtw89_warn(rtwdev, "failed to send h2c cmac table\n");
+		return ret;
+	}
+
+	ret = rtw89_fw_h2c_join_info(rtwdev, rtwvif, 1);
+	if (ret) {
+		rtw89_warn(rtwdev, "failed to send h2c join info\n");
+		return ret;
+	}
+
+	/* update cam aid mac_id net_type */
+	rtw89_fw_h2c_cam(rtwdev, rtwvif);
+	if (ret) {
+		rtw89_warn(rtwdev, "failed to send h2c cam\n");
+		return ret;
+	}
+
+	return ret;
+}
+
+int rtw89_core_sta_assoc(struct rtw89_dev *rtwdev,
+			 struct ieee80211_vif *vif,
+			 struct ieee80211_sta *sta)
+{
+	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
+	struct rtw89_sta *rtwsta = (struct rtw89_sta *)sta->drv_priv;
+	int ret;
+
+	rtw89_vif_type_mapping(vif, true);
+
+	ret = rtw89_fw_h2c_assoc_cmac_tbl(rtwdev, vif, sta);
+	if (ret) {
+		rtw89_warn(rtwdev, "failed to send h2c cmac table\n");
+		return ret;
+	}
+
+	/* for station mode, assign the mac_id from itself */
+	if (vif->type == NL80211_IFTYPE_STATION)
+		rtwsta->mac_id = rtwvif->mac_id;
+
+	ret = rtw89_fw_h2c_join_info(rtwdev, rtwvif, 0);
+	if (ret) {
+		rtw89_warn(rtwdev, "failed to send h2c join info\n");
+		return ret;
+	}
+
+	/* update cam aid mac_id net_type */
+	rtw89_fw_h2c_cam(rtwdev, rtwvif);
+	if (ret) {
+		rtw89_warn(rtwdev, "failed to send h2c cam\n");
+		return ret;
+	}
+
+	ret = rtw89_fw_h2c_general_pkt(rtwdev, rtwsta->mac_id);
+	if (ret) {
+		rtw89_warn(rtwdev, "failed to send h2c general packet\n");
+		return ret;
+	}
+
+	rtwdev->total_sta_assoc++;
+	rtw89_phy_ra_assoc(rtwdev, sta);
+	rtw89_mac_bf_assoc(rtwdev, vif, sta);
+	rtw89_mac_bf_monitor_calc(rtwdev, sta, false);
+
+	if (vif->type == NL80211_IFTYPE_STATION)
+		rtw89_btc_ntfy_role_info(rtwdev, rtwvif, rtwsta,
+					 BTC_ROLE_MSTS_STA_CONN_END);
+
+	return ret;
+}
+
+int rtw89_core_sta_remove(struct rtw89_dev *rtwdev,
+			  struct ieee80211_vif *vif,
+			  struct ieee80211_sta *sta)
+{
+	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
+	struct rtw89_sta *rtwsta = (struct rtw89_sta *)sta->drv_priv;
+
+	if (vif->type == NL80211_IFTYPE_STATION)
+		rtw89_btc_ntfy_role_info(rtwdev, rtwvif, rtwsta,
+					 BTC_ROLE_MSTS_STA_DIS_CONN);
+
+	return 0;
+}
+
+static void rtw89_init_ht_cap(struct rtw89_dev *rtwdev,
+			      struct ieee80211_sta_ht_cap *ht_cap)
+{
+	ht_cap->ht_supported = true;
+	ht_cap->cap = 0;
+	ht_cap->cap |= IEEE80211_HT_CAP_SGI_20 |
+		       IEEE80211_HT_CAP_MAX_AMSDU |
+		       IEEE80211_HT_CAP_TX_STBC |
+		       (1 << IEEE80211_HT_CAP_RX_STBC_SHIFT);
+
+	ht_cap->cap |= IEEE80211_HT_CAP_LDPC_CODING;
+
+	ht_cap->cap |= IEEE80211_HT_CAP_SUP_WIDTH_20_40 |
+		       IEEE80211_HT_CAP_DSSSCCK40 |
+		       IEEE80211_HT_CAP_SGI_40;
+	ht_cap->ampdu_factor = IEEE80211_HT_MAX_AMPDU_64K;
+	ht_cap->ampdu_density = IEEE80211_HT_MPDU_DENSITY_NONE;
+	ht_cap->mcs.tx_params = IEEE80211_HT_MCS_TX_DEFINED;
+	ht_cap->mcs.rx_mask[0] = 0xFF;
+	ht_cap->mcs.rx_mask[1] = 0xFF;
+	ht_cap->mcs.rx_mask[4] = 0x01;
+	ht_cap->mcs.rx_highest = cpu_to_le16(300);
+}
+
+static void rtw89_init_vht_cap(struct rtw89_dev *rtwdev,
+			       struct ieee80211_sta_vht_cap *vht_cap)
+{
+	u16 mcs_map;
+	__le16 highest;
+	u8 sts_cap = 3;
+
+	vht_cap->vht_supported = true;
+	vht_cap->cap = IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_11454 |
+		       IEEE80211_VHT_CAP_SHORT_GI_80 |
+		       IEEE80211_VHT_CAP_RXSTBC_1 |
+		       IEEE80211_VHT_CAP_HTC_VHT |
+		       IEEE80211_VHT_CAP_MAX_A_MPDU_LENGTH_EXPONENT_MASK |
+		       0;
+	vht_cap->cap |= IEEE80211_VHT_CAP_TXSTBC;
+	vht_cap->cap |= IEEE80211_VHT_CAP_RXLDPC;
+	vht_cap->cap |= IEEE80211_VHT_CAP_MU_BEAMFORMEE_CAPABLE |
+			IEEE80211_VHT_CAP_SU_BEAMFORMEE_CAPABLE;
+	vht_cap->cap |= sts_cap << IEEE80211_VHT_CAP_BEAMFORMEE_STS_SHIFT;
+
+	mcs_map = IEEE80211_VHT_MCS_SUPPORT_0_9 << 0 |
+		  IEEE80211_VHT_MCS_NOT_SUPPORTED << 4 |
+		  IEEE80211_VHT_MCS_NOT_SUPPORTED << 6 |
+		  IEEE80211_VHT_MCS_NOT_SUPPORTED << 8 |
+		  IEEE80211_VHT_MCS_NOT_SUPPORTED << 10 |
+		  IEEE80211_VHT_MCS_NOT_SUPPORTED << 12 |
+		  IEEE80211_VHT_MCS_NOT_SUPPORTED << 14;
+	highest = cpu_to_le16(867);
+	mcs_map |= IEEE80211_VHT_MCS_SUPPORT_0_9 << 2;
+	vht_cap->vht_mcs.rx_mcs_map = cpu_to_le16(mcs_map);
+	vht_cap->vht_mcs.tx_mcs_map = cpu_to_le16(mcs_map);
+	vht_cap->vht_mcs.rx_highest = highest;
+	vht_cap->vht_mcs.tx_highest = highest;
+}
+
+#define RTW89_SBAND_IFTYPES_NR 2
+
+static void rtw89_init_he_cap(struct rtw89_dev *rtwdev,
+			      enum nl80211_band band,
+			      struct ieee80211_supported_band *sband)
+{
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+	struct rtw89_hal *hal = &rtwdev->hal;
+	struct ieee80211_sband_iftype_data *iftype_data;
+	bool no_ng16 = (chip->chip_id == RTL8852A && hal->cv == CHIP_CBV) ||
+		       (chip->chip_id == RTL8852B && hal->cv == CHIP_CAV);
+	u16 mcs_map = 0;
+	int i;
+	int nss = chip->rx_nss;
+	int idx = 0;
+
+	iftype_data = kcalloc(RTW89_SBAND_IFTYPES_NR, sizeof(*iftype_data), GFP_KERNEL);
+	if (!iftype_data)
+		return;
+
+	for (i = 0; i < 8; i++) {
+		if (i < nss)
+			mcs_map |= IEEE80211_HE_MCS_SUPPORT_0_11 << (i * 2);
+		else
+			mcs_map |= IEEE80211_HE_MCS_NOT_SUPPORTED << (i * 2);
+	}
+
+	for (i = 0; i < NUM_NL80211_IFTYPES; i++) {
+		struct ieee80211_sta_he_cap *he_cap;
+		u8 *mac_cap_info;
+		u8 *phy_cap_info;
+
+		switch (i) {
+		case NL80211_IFTYPE_STATION:
+		case NL80211_IFTYPE_AP:
+			break;
+		default:
+			continue;
+		}
+
+		if (idx >= RTW89_SBAND_IFTYPES_NR) {
+			rtw89_warn(rtwdev, "run out of iftype_data\n");
+			break;
+		}
+
+		iftype_data[idx].types_mask = BIT(i);
+		he_cap = &iftype_data[idx].he_cap;
+		mac_cap_info = he_cap->he_cap_elem.mac_cap_info;
+		phy_cap_info = he_cap->he_cap_elem.phy_cap_info;
+
+		he_cap->has_he = true;
+		if (i == NL80211_IFTYPE_AP)
+			mac_cap_info[0] = IEEE80211_HE_MAC_CAP0_HTC_HE;
+		if (i == NL80211_IFTYPE_STATION)
+			mac_cap_info[1] = IEEE80211_HE_MAC_CAP1_TF_MAC_PAD_DUR_16US;
+		mac_cap_info[2] = IEEE80211_HE_MAC_CAP2_ALL_ACK |
+				  IEEE80211_HE_MAC_CAP2_BSR;
+		mac_cap_info[3] = IEEE80211_HE_MAC_CAP3_MAX_AMPDU_LEN_EXP_EXT_2;
+		if (i == NL80211_IFTYPE_AP)
+			mac_cap_info[3] |= IEEE80211_HE_MAC_CAP3_OMI_CONTROL;
+		mac_cap_info[4] = IEEE80211_HE_MAC_CAP4_OPS |
+				  IEEE80211_HE_MAC_CAP4_AMSDU_IN_AMPDU;
+		if (i == NL80211_IFTYPE_STATION)
+			mac_cap_info[5] = IEEE80211_HE_MAC_CAP5_HT_VHT_TRIG_FRAME_RX;
+		phy_cap_info[0] = IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_IN_2G |
+				  IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_80MHZ_IN_5G;
+		phy_cap_info[1] = IEEE80211_HE_PHY_CAP1_DEVICE_CLASS_A |
+				  IEEE80211_HE_PHY_CAP1_LDPC_CODING_IN_PAYLOAD |
+				  IEEE80211_HE_PHY_CAP1_HE_LTF_AND_GI_FOR_HE_PPDUS_0_8US;
+		phy_cap_info[2] = IEEE80211_HE_PHY_CAP2_NDP_4x_LTF_AND_3_2US |
+				  IEEE80211_HE_PHY_CAP2_STBC_TX_UNDER_80MHZ |
+				  IEEE80211_HE_PHY_CAP2_STBC_RX_UNDER_80MHZ |
+				  IEEE80211_HE_PHY_CAP2_DOPPLER_TX;
+		phy_cap_info[3] = IEEE80211_HE_PHY_CAP3_DCM_MAX_CONST_RX_16_QAM;
+		if (i == NL80211_IFTYPE_STATION)
+			phy_cap_info[3] |= IEEE80211_HE_PHY_CAP3_DCM_MAX_CONST_TX_16_QAM |
+					   IEEE80211_HE_PHY_CAP3_DCM_MAX_TX_NSS_2;
+		if (i == NL80211_IFTYPE_AP)
+			phy_cap_info[3] |= IEEE80211_HE_PHY_CAP3_RX_PARTIAL_BW_SU_IN_20MHZ_MU;
+		phy_cap_info[4] = IEEE80211_HE_PHY_CAP4_SU_BEAMFORMEE |
+				  IEEE80211_HE_PHY_CAP4_BEAMFORMEE_MAX_STS_UNDER_80MHZ_4;
+		phy_cap_info[5] = no_ng16 ? 0 :
+				  IEEE80211_HE_PHY_CAP5_NG16_SU_FEEDBACK |
+				  IEEE80211_HE_PHY_CAP5_NG16_MU_FEEDBACK;
+		phy_cap_info[6] = IEEE80211_HE_PHY_CAP6_CODEBOOK_SIZE_42_SU |
+				  IEEE80211_HE_PHY_CAP6_CODEBOOK_SIZE_75_MU |
+				  IEEE80211_HE_PHY_CAP6_TRIG_SU_BEAMFORMING_FB |
+				  IEEE80211_HE_PHY_CAP6_PARTIAL_BW_EXT_RANGE;
+		phy_cap_info[7] = IEEE80211_HE_PHY_CAP7_POWER_BOOST_FACTOR_SUPP |
+				  IEEE80211_HE_PHY_CAP7_HE_SU_MU_PPDU_4XLTF_AND_08_US_GI |
+				  IEEE80211_HE_PHY_CAP7_MAX_NC_1;
+		phy_cap_info[8] = IEEE80211_HE_PHY_CAP8_HE_ER_SU_PPDU_4XLTF_AND_08_US_GI |
+				  IEEE80211_HE_PHY_CAP8_HE_ER_SU_1XLTF_AND_08_US_GI |
+				  IEEE80211_HE_PHY_CAP8_DCM_MAX_RU_996;
+		phy_cap_info[9] = IEEE80211_HE_PHY_CAP9_LONGER_THAN_16_SIGB_OFDM_SYM |
+				  IEEE80211_HE_PHY_CAP9_RX_1024_QAM_LESS_THAN_242_TONE_RU |
+				  IEEE80211_HE_PHY_CAP9_RX_FULL_BW_SU_USING_MU_WITH_COMP_SIGB |
+				  IEEE80211_HE_PHY_CAP9_RX_FULL_BW_SU_USING_MU_WITH_NON_COMP_SIGB |
+				  IEEE80211_HE_PHY_CAP9_NOMIMAL_PKT_PADDING_16US;
+		if (i == NL80211_IFTYPE_STATION)
+			phy_cap_info[9] |= IEEE80211_HE_PHY_CAP9_TX_1024_QAM_LESS_THAN_242_TONE_RU;
+		he_cap->he_mcs_nss_supp.rx_mcs_80 = cpu_to_le16(mcs_map);
+		he_cap->he_mcs_nss_supp.tx_mcs_80 = cpu_to_le16(mcs_map);
+
+		idx++;
+	}
+
+	sband->iftype_data = iftype_data;
+	sband->n_iftype_data = idx;
+}
+
+static int rtw89_core_set_supported_band(struct rtw89_dev *rtwdev)
+{
+	struct ieee80211_hw *hw = rtwdev->hw;
+	struct ieee80211_supported_band *sband_2ghz = NULL, *sband_5ghz = NULL;
+	u32 size = sizeof(struct ieee80211_supported_band);
+
+	sband_2ghz = kmemdup(&rtw89_sband_2ghz, size, GFP_KERNEL);
+	if (!sband_2ghz)
+		goto err;
+	rtw89_init_ht_cap(rtwdev, &sband_2ghz->ht_cap);
+	rtw89_init_he_cap(rtwdev, NL80211_BAND_2GHZ, sband_2ghz);
+	hw->wiphy->bands[NL80211_BAND_2GHZ] = sband_2ghz;
+
+	sband_5ghz = kmemdup(&rtw89_sband_5ghz, size, GFP_KERNEL);
+	if (!sband_5ghz)
+		goto err;
+	rtw89_init_ht_cap(rtwdev, &sband_5ghz->ht_cap);
+	rtw89_init_vht_cap(rtwdev, &sband_5ghz->vht_cap);
+	rtw89_init_he_cap(rtwdev, NL80211_BAND_5GHZ, sband_5ghz);
+	hw->wiphy->bands[NL80211_BAND_5GHZ] = sband_5ghz;
+
+	return 0;
+
+err:
+	hw->wiphy->bands[NL80211_BAND_2GHZ] = NULL;
+	hw->wiphy->bands[NL80211_BAND_5GHZ] = NULL;
+	if (sband_2ghz)
+		kfree(sband_2ghz->iftype_data);
+	if (sband_5ghz)
+		kfree(sband_5ghz->iftype_data);
+	kfree(sband_2ghz);
+	kfree(sband_5ghz);
+	return -ENOMEM;
+}
+
+static void rtw89_core_clr_supported_band(struct rtw89_dev *rtwdev)
+{
+	struct ieee80211_hw *hw = rtwdev->hw;
+
+	kfree(hw->wiphy->bands[NL80211_BAND_2GHZ]->iftype_data);
+	kfree(hw->wiphy->bands[NL80211_BAND_5GHZ]->iftype_data);
+	kfree(hw->wiphy->bands[NL80211_BAND_2GHZ]);
+	kfree(hw->wiphy->bands[NL80211_BAND_5GHZ]);
+	hw->wiphy->bands[NL80211_BAND_2GHZ] = NULL;
+	hw->wiphy->bands[NL80211_BAND_5GHZ] = NULL;
+}
+
+static void rtw89_core_ppdu_sts_init(struct rtw89_dev *rtwdev)
+{
+	int i;
+
+	for (i = 0; i < RTW89_PHY_MAX; i++)
+		skb_queue_head_init(&rtwdev->ppdu_sts.rx_queue[i]);
+	for (i = 0; i < RTW89_PHY_MAX; i++)
+		rtwdev->ppdu_sts.curr_rx_ppdu_cnt[i] = U8_MAX;
+}
+
+int rtw89_core_start(struct rtw89_dev *rtwdev)
+{
+	int ret;
+
+	rtwdev->mac.qta_mode = RTW89_QTA_SCC;
+	ret = rtw89_mac_init(rtwdev);
+	if (ret) {
+		rtw89_err(rtwdev, "mac init fail, ret:%d\n", ret);
+		return ret;
+	}
+
+	rtw89_btc_ntfy_poweron(rtwdev);
+
+	/* efuse process */
+
+	/* pre-config BB/RF, BB reset/RFC reset */
+	rtw89_mac_disable_bb_rf(rtwdev);
+	rtw89_mac_enable_bb_rf(rtwdev);
+	rtw89_phy_init_bb_reg(rtwdev);
+	rtw89_phy_init_rf_reg(rtwdev);
+
+	rtw89_btc_ntfy_init(rtwdev, BTC_MODE_NORMAL);
+
+	rtw89_phy_dm_init(rtwdev);
+
+	rtw89_mac_cfg_ppdu_status(rtwdev, RTW89_MAC_0, true);
+	rtw89_mac_update_rts_threshold(rtwdev, RTW89_MAC_0);
+
+	ret = rtw89_hci_start(rtwdev);
+	if (ret) {
+		rtw89_err(rtwdev, "failed to start hci\n");
+		return ret;
+	}
+
+	ieee80211_queue_delayed_work(rtwdev->hw, &rtwdev->track_work,
+				     RTW89_TRACK_WORK_PERIOD);
+
+	set_bit(RTW89_FLAG_RUNNING, rtwdev->flags);
+
+	rtw89_btc_ntfy_radio_state(rtwdev, BTC_RFCTRL_WL_ON);
+	rtw89_fw_h2c_fw_log(rtwdev, rtwdev->fw.fw_log_enable);
+
+	return 0;
+}
+
+void rtw89_core_stop(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_btc *btc = &rtwdev->btc;
+
+	/* Prvent to stop twice; enter_ips and ops_stop */
+	if (!test_bit(RTW89_FLAG_RUNNING, rtwdev->flags))
+		return;
+
+	rtw89_btc_ntfy_radio_state(rtwdev, BTC_RFCTRL_WL_OFF);
+
+	clear_bit(RTW89_FLAG_RUNNING, rtwdev->flags);
+
+	mutex_unlock(&rtwdev->mutex);
+
+	cancel_work_sync(&rtwdev->c2h_work);
+	cancel_work_sync(&btc->eapol_notify_work);
+	cancel_work_sync(&btc->arp_notify_work);
+	cancel_work_sync(&btc->dhcp_notify_work);
+	cancel_work_sync(&btc->wl_sta_notify_work);
+	cancel_delayed_work_sync(&rtwdev->txq_reinvoke_work);
+	cancel_delayed_work_sync(&rtwdev->track_work);
+	cancel_delayed_work_sync(&rtwdev->coex_act1_work);
+	cancel_delayed_work_sync(&rtwdev->cfo_track_work);
+
+	mutex_lock(&rtwdev->mutex);
+
+	rtw89_btc_ntfy_poweroff(rtwdev);
+	rtw89_hci_flush_queues(rtwdev, BIT(rtwdev->hw->queues) - 1, true);
+	rtw89_mac_flush_txq(rtwdev, BIT(rtwdev->hw->queues) - 1, true);
+	rtw89_hci_stop(rtwdev);
+	rtw89_hci_deinit(rtwdev);
+	rtw89_mac_pwr_off(rtwdev);
+	rtw89_hci_reset(rtwdev);
+}
+
+int rtw89_core_init(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_btc *btc = &rtwdev->btc;
+	int ret;
+
+	INIT_LIST_HEAD(&rtwdev->ba_list);
+	INIT_WORK(&rtwdev->ba_work, rtw89_core_ba_work);
+	INIT_WORK(&rtwdev->txq_work, rtw89_core_txq_work);
+	INIT_DELAYED_WORK(&rtwdev->txq_reinvoke_work, rtw89_core_txq_reinvoke_work);
+	INIT_DELAYED_WORK(&rtwdev->track_work, rtw89_track_work);
+	INIT_DELAYED_WORK(&rtwdev->coex_act1_work, rtw89_coex_act1_work);
+	INIT_DELAYED_WORK(&rtwdev->cfo_track_work, rtw89_phy_cfo_track_work);
+	rtwdev->txq_wq = alloc_workqueue("rtw89_tx_wq", WQ_UNBOUND | WQ_HIGHPRI, 0);
+	spin_lock_init(&rtwdev->ba_lock);
+	mutex_init(&rtwdev->mutex);
+	mutex_init(&rtwdev->rf_mutex);
+	rtwdev->total_sta_assoc = 0;
+
+	INIT_WORK(&rtwdev->c2h_work, rtw89_fw_c2h_work);
+	skb_queue_head_init(&rtwdev->c2h_queue);
+	rtw89_core_ppdu_sts_init(rtwdev);
+	rtw89_traffic_stats_init(rtwdev, &rtwdev->stats);
+
+	rtwdev->ps_mode = rtw89_update_ps_mode(rtwdev);
+	rtwdev->hal.rx_fltr = DEFAULT_AX_RX_FLTR;
+
+	INIT_WORK(&btc->eapol_notify_work, rtw89_btc_ntfy_eapol_packet_work);
+	INIT_WORK(&btc->arp_notify_work, rtw89_btc_ntfy_arp_packet_work);
+	INIT_WORK(&btc->dhcp_notify_work, rtw89_btc_ntfy_dhcp_packet_work);
+	INIT_WORK(&btc->wl_sta_notify_work, rtw89_btc_ntfy_wl_sta_work);
+
+	ret = rtw89_load_firmware(rtwdev);
+	if (ret) {
+		rtw89_warn(rtwdev, "no firmware loaded\n");
+		return ret;
+	}
+	rtw89_ser_init(rtwdev);
+
+	return 0;
+}
+EXPORT_SYMBOL(rtw89_core_init);
+
+void rtw89_core_deinit(struct rtw89_dev *rtwdev)
+{
+	rtw89_ser_deinit(rtwdev);
+	rtw89_unload_firmware(rtwdev);
+
+	destroy_workqueue(rtwdev->txq_wq);
+	mutex_destroy(&rtwdev->rf_mutex);
+	mutex_destroy(&rtwdev->mutex);
+}
+EXPORT_SYMBOL(rtw89_core_deinit);
+
+static void rtw89_read_chip_ver(struct rtw89_dev *rtwdev)
+{
+	u8 cv;
+
+	cv = rtw89_read32_mask(rtwdev, R_AX_SYS_CFG1, B_AX_CHIP_VER_MSK);
+	if (cv <= CHIP_CBV) {
+		if (rtw89_read32(rtwdev, R_AX_GPIO0_7_FUNC_SEL) == RTW89_R32_DEAD)
+			cv = CHIP_CAV;
+		else
+			cv = CHIP_CBV;
+	}
+
+	rtwdev->hal.cv = cv;
+}
+
+static int rtw89_chip_efuse_info_setup(struct rtw89_dev *rtwdev)
+{
+	int ret;
+
+	ret = rtw89_mac_partial_init(rtwdev);
+	if (ret)
+		return ret;
+
+	ret = rtw89_parse_efuse_map(rtwdev);
+	if (ret)
+		return ret;
+
+	ret = rtw89_parse_phycap_map(rtwdev);
+	if (ret)
+		return ret;
+
+	rtw89_mac_pwr_off(rtwdev);
+
+	return 0;
+}
+
+static int rtw89_chip_board_info_setup(struct rtw89_dev *rtwdev)
+{
+	rtw89_chip_fem_setup(rtwdev);
+
+	return 0;
+}
+
+int rtw89_chip_info_setup(struct rtw89_dev *rtwdev)
+{
+	int ret;
+
+	rtw89_read_chip_ver(rtwdev);
+
+	ret = rtw89_wait_firmware_completion(rtwdev);
+	if (ret) {
+		rtw89_err(rtwdev, "failed to wait firmware completion\n");
+		return ret;
+	}
+
+	ret = rtw89_fw_recognize(rtwdev);
+	if (ret) {
+		rtw89_err(rtwdev, "failed to recognize firmware\n");
+		return ret;
+	}
+
+	ret = rtw89_chip_efuse_info_setup(rtwdev);
+	if (ret)
+		return ret;
+
+	ret = rtw89_chip_board_info_setup(rtwdev);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+EXPORT_SYMBOL(rtw89_chip_info_setup);
+
+static int rtw89_core_register_hw(struct rtw89_dev *rtwdev)
+{
+	struct ieee80211_hw *hw = rtwdev->hw;
+	struct rtw89_efuse *efuse = &rtwdev->efuse;
+	int ret;
+	int tx_headroom = IEEE80211_HT_CTL_LEN;
+
+	hw->vif_data_size = sizeof(struct rtw89_vif);
+	hw->sta_data_size = sizeof(struct rtw89_sta);
+	hw->txq_data_size = sizeof(struct rtw89_txq);
+
+	SET_IEEE80211_PERM_ADDR(hw, efuse->addr);
+
+	hw->extra_tx_headroom = tx_headroom;
+	hw->queues = IEEE80211_NUM_ACS;
+	hw->max_rx_aggregation_subframes = RTW89_MAX_RX_AGG_NUM;
+	hw->max_tx_aggregation_subframes = RTW89_MAX_TX_AGG_NUM;
+
+	ieee80211_hw_set(hw, SIGNAL_DBM);
+	ieee80211_hw_set(hw, HAS_RATE_CONTROL);
+	ieee80211_hw_set(hw, MFP_CAPABLE);
+	ieee80211_hw_set(hw, REPORTS_TX_ACK_STATUS);
+	ieee80211_hw_set(hw, AMPDU_AGGREGATION);
+	ieee80211_hw_set(hw, RX_INCLUDES_FCS);
+	ieee80211_hw_set(hw, TX_AMSDU);
+	ieee80211_hw_set(hw, SUPPORT_FAST_XMIT);
+	ieee80211_hw_set(hw, SUPPORTS_AMSDU_IN_AMPDU);
+	ieee80211_hw_set(hw, SUPPORTS_PS);
+	ieee80211_hw_set(hw, SUPPORTS_DYNAMIC_PS);
+
+	hw->wiphy->interface_modes = BIT(NL80211_IFTYPE_STATION);
+	hw->wiphy->available_antennas_tx = BIT(rtwdev->chip->rf_path_num) - 1;
+	hw->wiphy->available_antennas_rx = BIT(rtwdev->chip->rf_path_num) - 1;
+
+	hw->wiphy->features |= NL80211_FEATURE_SCAN_RANDOM_MAC_ADDR;
+
+	wiphy_ext_feature_set(hw->wiphy, NL80211_EXT_FEATURE_CAN_REPLACE_PTK0);
+
+	ret = rtw89_core_set_supported_band(rtwdev);
+	if (ret) {
+		rtw89_err(rtwdev, "failed to set supported band\n");
+		return ret;
+	}
+
+	hw->wiphy->reg_notifier = rtw89_regd_notifier;
+	hw->wiphy->sar_capa = &rtw89_sar_capa;
+
+	ret = ieee80211_register_hw(hw);
+	if (ret) {
+		rtw89_err(rtwdev, "failed to register hw\n");
+		goto err;
+	}
+
+	ret = rtw89_regd_init(rtwdev, rtw89_regd_notifier);
+	if (ret) {
+		rtw89_err(rtwdev, "failed to init regd\n");
+		goto err;
+	}
+
+	return 0;
+
+err:
+	return ret;
+}
+
+static void rtw89_core_unregister_hw(struct rtw89_dev *rtwdev)
+{
+	struct ieee80211_hw *hw = rtwdev->hw;
+
+	ieee80211_unregister_hw(hw);
+	rtw89_core_clr_supported_band(rtwdev);
+}
+
+int rtw89_core_register(struct rtw89_dev *rtwdev)
+{
+	int ret;
+
+	ret = rtw89_core_register_hw(rtwdev);
+	if (ret) {
+		rtw89_err(rtwdev, "failed to register core hw\n");
+		return ret;
+	}
+
+	rtw89_debugfs_init(rtwdev);
+
+	return 0;
+}
+EXPORT_SYMBOL(rtw89_core_register);
+
+void rtw89_core_unregister(struct rtw89_dev *rtwdev)
+{
+	rtw89_core_unregister_hw(rtwdev);
+}
+EXPORT_SYMBOL(rtw89_core_unregister);
+
+MODULE_AUTHOR("Realtek Corporation");
+MODULE_DESCRIPTION("Realtek 802.11ax wireless core module");
+MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
new file mode 100644
index 000000000000..d535b9293911
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -0,0 +1,3336 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/* Copyright(c) 2019-2020  Realtek Corporation
+ */
+
+#ifndef __RTW89_CORE_H__
+#define __RTW89_CORE_H__
+
+#include <linux/average.h>
+#include <linux/bitfield.h>
+#include <linux/firmware.h>
+#include <linux/iopoll.h>
+#include <linux/workqueue.h>
+#include <net/mac80211.h>
+
+struct rtw89_dev;
+
+extern const struct ieee80211_ops rtw89_ops;
+extern const struct rtw89_chip_info rtw8852a_chip_info;
+
+#define MASKBYTE0 0xff
+#define MASKBYTE1 0xff00
+#define MASKBYTE2 0xff0000
+#define MASKBYTE3 0xff000000
+#define MASKBYTE4 0xff00000000ULL
+#define MASKHWORD 0xffff0000
+#define MASKLWORD 0x0000ffff
+#define MASKDWORD 0xffffffff
+#define RFREG_MASK 0xfffff
+#define INV_RF_DATA 0xffffffff
+
+#define RTW89_TRACK_WORK_PERIOD	round_jiffies_relative(HZ * 2)
+#define CFO_TRACK_MAX_USER 64
+#define MAX_RSSI 110
+#define RSSI_FACTOR 1
+#define RTW89_RSSI_RAW_TO_DBM(rssi) ((s8)((rssi) >> RSSI_FACTOR) - MAX_RSSI)
+#define RTW89_MAX_HW_PORT_NUM 5
+
+#define RTW89_HTC_MASK_VARIANT GENMASK(1, 0)
+#define RTW89_HTC_VARIANT_HE 3
+#define RTW89_HTC_MASK_CTL_ID GENMASK(5, 2)
+#define RTW89_HTC_VARIANT_HE_CID_CAS 6
+#define RTW89_HTC_MASK_CTL_INFO GENMASK(31, 6)
+
+enum rtw89_subband {
+	RTW89_CH_2G = 0,
+	RTW89_CH_5G_BAND_1 = 1,
+	/* RTW89_CH_5G_BAND_2 = 2, unused */
+	RTW89_CH_5G_BAND_3 = 3,
+	RTW89_CH_5G_BAND_4 = 4,
+
+	RTW89_SUBBAND_NR,
+};
+
+enum rtw89_hci_type {
+	RTW89_HCI_TYPE_PCIE,
+	RTW89_HCI_TYPE_USB,
+	RTW89_HCI_TYPE_SDIO,
+};
+
+enum rtw89_core_chip_id {
+	RTL8852A,
+	RTL8852B,
+	RTL8852C,
+};
+
+enum rtw89_cv {
+	CHIP_CAV,
+	CHIP_CBV,
+	CHIP_CCV,
+	CHIP_CDV,
+	CHIP_CEV,
+	CHIP_CFV,
+	CHIP_CV_MAX,
+	CHIP_CV_INVALID = CHIP_CV_MAX,
+};
+
+enum rtw89_core_tx_type {
+	RTW89_CORE_TX_TYPE_DATA,
+	RTW89_CORE_TX_TYPE_MGMT,
+	RTW89_CORE_TX_TYPE_FWCMD,
+};
+
+enum rtw89_core_rx_type {
+	RTW89_CORE_RX_TYPE_WIFI		= 0,
+	RTW89_CORE_RX_TYPE_PPDU_STAT	= 1,
+	RTW89_CORE_RX_TYPE_CHAN_INFO	= 2,
+	RTW89_CORE_RX_TYPE_BB_SCOPE	= 3,
+	RTW89_CORE_RX_TYPE_F2P_TXCMD	= 4,
+	RTW89_CORE_RX_TYPE_SS2FW	= 5,
+	RTW89_CORE_RX_TYPE_TX_REPORT	= 6,
+	RTW89_CORE_RX_TYPE_TX_REL_HOST	= 7,
+	RTW89_CORE_RX_TYPE_DFS_REPORT	= 8,
+	RTW89_CORE_RX_TYPE_TX_REL_CPU	= 9,
+	RTW89_CORE_RX_TYPE_C2H		= 10,
+	RTW89_CORE_RX_TYPE_CSI		= 11,
+	RTW89_CORE_RX_TYPE_CQI		= 12,
+};
+
+enum rtw89_txq_flags {
+	RTW89_TXQ_F_AMPDU		= 0,
+	RTW89_TXQ_F_BLOCK_BA		= 1,
+};
+
+enum rtw89_net_type {
+	RTW89_NET_TYPE_NO_LINK		= 0,
+	RTW89_NET_TYPE_AD_HOC		= 1,
+	RTW89_NET_TYPE_INFRA		= 2,
+	RTW89_NET_TYPE_AP_MODE		= 3,
+};
+
+enum rtw89_wifi_role {
+	RTW89_WIFI_ROLE_NONE,
+	RTW89_WIFI_ROLE_STATION,
+	RTW89_WIFI_ROLE_AP,
+	RTW89_WIFI_ROLE_AP_VLAN,
+	RTW89_WIFI_ROLE_ADHOC,
+	RTW89_WIFI_ROLE_ADHOC_MASTER,
+	RTW89_WIFI_ROLE_MESH_POINT,
+	RTW89_WIFI_ROLE_MONITOR,
+	RTW89_WIFI_ROLE_P2P_DEVICE,
+	RTW89_WIFI_ROLE_P2P_CLIENT,
+	RTW89_WIFI_ROLE_P2P_GO,
+	RTW89_WIFI_ROLE_NAN,
+	RTW89_WIFI_ROLE_MLME_MAX
+};
+
+enum rtw89_upd_mode {
+	RTW89_VIF_CREATE,
+	RTW89_VIF_REMOVE,
+	RTW89_VIF_TYPE_CHANGE,
+	RTW89_VIF_INFO_CHANGE,
+	RTW89_VIF_CON_DISCONN
+};
+
+enum rtw89_self_role {
+	RTW89_SELF_ROLE_CLIENT,
+	RTW89_SELF_ROLE_AP,
+	RTW89_SELF_ROLE_AP_CLIENT
+};
+
+enum rtw89_msk_sO_el {
+	RTW89_NO_MSK,
+	RTW89_SMA,
+	RTW89_TMA,
+	RTW89_BSSID
+};
+
+enum rtw89_sch_tx_sel {
+	RTW89_SCH_TX_SEL_ALL,
+	RTW89_SCH_TX_SEL_HIQ,
+	RTW89_SCH_TX_SEL_MG0,
+	RTW89_SCH_TX_SEL_MACID,
+};
+
+/* RTW89_ADDR_CAM_SEC_NONE	: not enabled
+ * RTW89_ADDR_CAM_SEC_ALL_UNI	: 0 - 6 unicast
+ * RTW89_ADDR_CAM_SEC_NORMAL	: 0 - 1 unicast, 2 - 4 group, 5 - 6 BIP
+ * RTW89_ADDR_CAM_SEC_4GROUP	: 0 - 1 unicast, 2 - 5 group, 6 BIP
+ */
+enum rtw89_add_cam_sec_mode {
+	RTW89_ADDR_CAM_SEC_NONE		= 0,
+	RTW89_ADDR_CAM_SEC_ALL_UNI	= 1,
+	RTW89_ADDR_CAM_SEC_NORMAL	= 2,
+	RTW89_ADDR_CAM_SEC_4GROUP	= 3,
+};
+
+enum rtw89_sec_key_type {
+	RTW89_SEC_KEY_TYPE_NONE		= 0,
+	RTW89_SEC_KEY_TYPE_WEP40	= 1,
+	RTW89_SEC_KEY_TYPE_WEP104	= 2,
+	RTW89_SEC_KEY_TYPE_TKIP		= 3,
+	RTW89_SEC_KEY_TYPE_WAPI		= 4,
+	RTW89_SEC_KEY_TYPE_GCMSMS4	= 5,
+	RTW89_SEC_KEY_TYPE_CCMP128	= 6,
+	RTW89_SEC_KEY_TYPE_CCMP256	= 7,
+	RTW89_SEC_KEY_TYPE_GCMP128	= 8,
+	RTW89_SEC_KEY_TYPE_GCMP256	= 9,
+	RTW89_SEC_KEY_TYPE_BIP_CCMP128	= 10,
+};
+
+enum rtw89_port {
+	RTW89_PORT_0 = 0,
+	RTW89_PORT_1 = 1,
+	RTW89_PORT_2 = 2,
+	RTW89_PORT_3 = 3,
+	RTW89_PORT_4 = 4,
+	RTW89_PORT_NUM
+};
+
+enum rtw89_band {
+	RTW89_BAND_2G = 0,
+	RTW89_BAND_5G = 1,
+	RTW89_BAND_MAX,
+};
+
+enum rtw89_hw_rate {
+	RTW89_HW_RATE_CCK1	= 0x0,
+	RTW89_HW_RATE_CCK2	= 0x1,
+	RTW89_HW_RATE_CCK5_5	= 0x2,
+	RTW89_HW_RATE_CCK11	= 0x3,
+	RTW89_HW_RATE_OFDM6	= 0x4,
+	RTW89_HW_RATE_OFDM9	= 0x5,
+	RTW89_HW_RATE_OFDM12	= 0x6,
+	RTW89_HW_RATE_OFDM18	= 0x7,
+	RTW89_HW_RATE_OFDM24	= 0x8,
+	RTW89_HW_RATE_OFDM36	= 0x9,
+	RTW89_HW_RATE_OFDM48	= 0xA,
+	RTW89_HW_RATE_OFDM54	= 0xB,
+	RTW89_HW_RATE_MCS0	= 0x80,
+	RTW89_HW_RATE_MCS1	= 0x81,
+	RTW89_HW_RATE_MCS2	= 0x82,
+	RTW89_HW_RATE_MCS3	= 0x83,
+	RTW89_HW_RATE_MCS4	= 0x84,
+	RTW89_HW_RATE_MCS5	= 0x85,
+	RTW89_HW_RATE_MCS6	= 0x86,
+	RTW89_HW_RATE_MCS7	= 0x87,
+	RTW89_HW_RATE_MCS8	= 0x88,
+	RTW89_HW_RATE_MCS9	= 0x89,
+	RTW89_HW_RATE_MCS10	= 0x8A,
+	RTW89_HW_RATE_MCS11	= 0x8B,
+	RTW89_HW_RATE_MCS12	= 0x8C,
+	RTW89_HW_RATE_MCS13	= 0x8D,
+	RTW89_HW_RATE_MCS14	= 0x8E,
+	RTW89_HW_RATE_MCS15	= 0x8F,
+	RTW89_HW_RATE_MCS16	= 0x90,
+	RTW89_HW_RATE_MCS17	= 0x91,
+	RTW89_HW_RATE_MCS18	= 0x92,
+	RTW89_HW_RATE_MCS19	= 0x93,
+	RTW89_HW_RATE_MCS20	= 0x94,
+	RTW89_HW_RATE_MCS21	= 0x95,
+	RTW89_HW_RATE_MCS22	= 0x96,
+	RTW89_HW_RATE_MCS23	= 0x97,
+	RTW89_HW_RATE_MCS24	= 0x98,
+	RTW89_HW_RATE_MCS25	= 0x99,
+	RTW89_HW_RATE_MCS26	= 0x9A,
+	RTW89_HW_RATE_MCS27	= 0x9B,
+	RTW89_HW_RATE_MCS28	= 0x9C,
+	RTW89_HW_RATE_MCS29	= 0x9D,
+	RTW89_HW_RATE_MCS30	= 0x9E,
+	RTW89_HW_RATE_MCS31	= 0x9F,
+	RTW89_HW_RATE_VHT_NSS1_MCS0	= 0x100,
+	RTW89_HW_RATE_VHT_NSS1_MCS1	= 0x101,
+	RTW89_HW_RATE_VHT_NSS1_MCS2	= 0x102,
+	RTW89_HW_RATE_VHT_NSS1_MCS3	= 0x103,
+	RTW89_HW_RATE_VHT_NSS1_MCS4	= 0x104,
+	RTW89_HW_RATE_VHT_NSS1_MCS5	= 0x105,
+	RTW89_HW_RATE_VHT_NSS1_MCS6	= 0x106,
+	RTW89_HW_RATE_VHT_NSS1_MCS7	= 0x107,
+	RTW89_HW_RATE_VHT_NSS1_MCS8	= 0x108,
+	RTW89_HW_RATE_VHT_NSS1_MCS9	= 0x109,
+	RTW89_HW_RATE_VHT_NSS2_MCS0	= 0x110,
+	RTW89_HW_RATE_VHT_NSS2_MCS1	= 0x111,
+	RTW89_HW_RATE_VHT_NSS2_MCS2	= 0x112,
+	RTW89_HW_RATE_VHT_NSS2_MCS3	= 0x113,
+	RTW89_HW_RATE_VHT_NSS2_MCS4	= 0x114,
+	RTW89_HW_RATE_VHT_NSS2_MCS5	= 0x115,
+	RTW89_HW_RATE_VHT_NSS2_MCS6	= 0x116,
+	RTW89_HW_RATE_VHT_NSS2_MCS7	= 0x117,
+	RTW89_HW_RATE_VHT_NSS2_MCS8	= 0x118,
+	RTW89_HW_RATE_VHT_NSS2_MCS9	= 0x119,
+	RTW89_HW_RATE_VHT_NSS3_MCS0	= 0x120,
+	RTW89_HW_RATE_VHT_NSS3_MCS1	= 0x121,
+	RTW89_HW_RATE_VHT_NSS3_MCS2	= 0x122,
+	RTW89_HW_RATE_VHT_NSS3_MCS3	= 0x123,
+	RTW89_HW_RATE_VHT_NSS3_MCS4	= 0x124,
+	RTW89_HW_RATE_VHT_NSS3_MCS5	= 0x125,
+	RTW89_HW_RATE_VHT_NSS3_MCS6	= 0x126,
+	RTW89_HW_RATE_VHT_NSS3_MCS7	= 0x127,
+	RTW89_HW_RATE_VHT_NSS3_MCS8	= 0x128,
+	RTW89_HW_RATE_VHT_NSS3_MCS9	= 0x129,
+	RTW89_HW_RATE_VHT_NSS4_MCS0	= 0x130,
+	RTW89_HW_RATE_VHT_NSS4_MCS1	= 0x131,
+	RTW89_HW_RATE_VHT_NSS4_MCS2	= 0x132,
+	RTW89_HW_RATE_VHT_NSS4_MCS3	= 0x133,
+	RTW89_HW_RATE_VHT_NSS4_MCS4	= 0x134,
+	RTW89_HW_RATE_VHT_NSS4_MCS5	= 0x135,
+	RTW89_HW_RATE_VHT_NSS4_MCS6	= 0x136,
+	RTW89_HW_RATE_VHT_NSS4_MCS7	= 0x137,
+	RTW89_HW_RATE_VHT_NSS4_MCS8	= 0x138,
+	RTW89_HW_RATE_VHT_NSS4_MCS9	= 0x139,
+	RTW89_HW_RATE_HE_NSS1_MCS0	= 0x180,
+	RTW89_HW_RATE_HE_NSS1_MCS1	= 0x181,
+	RTW89_HW_RATE_HE_NSS1_MCS2	= 0x182,
+	RTW89_HW_RATE_HE_NSS1_MCS3	= 0x183,
+	RTW89_HW_RATE_HE_NSS1_MCS4	= 0x184,
+	RTW89_HW_RATE_HE_NSS1_MCS5	= 0x185,
+	RTW89_HW_RATE_HE_NSS1_MCS6	= 0x186,
+	RTW89_HW_RATE_HE_NSS1_MCS7	= 0x187,
+	RTW89_HW_RATE_HE_NSS1_MCS8	= 0x188,
+	RTW89_HW_RATE_HE_NSS1_MCS9	= 0x189,
+	RTW89_HW_RATE_HE_NSS1_MCS10	= 0x18A,
+	RTW89_HW_RATE_HE_NSS1_MCS11	= 0x18B,
+	RTW89_HW_RATE_HE_NSS2_MCS0	= 0x190,
+	RTW89_HW_RATE_HE_NSS2_MCS1	= 0x191,
+	RTW89_HW_RATE_HE_NSS2_MCS2	= 0x192,
+	RTW89_HW_RATE_HE_NSS2_MCS3	= 0x193,
+	RTW89_HW_RATE_HE_NSS2_MCS4	= 0x194,
+	RTW89_HW_RATE_HE_NSS2_MCS5	= 0x195,
+	RTW89_HW_RATE_HE_NSS2_MCS6	= 0x196,
+	RTW89_HW_RATE_HE_NSS2_MCS7	= 0x197,
+	RTW89_HW_RATE_HE_NSS2_MCS8	= 0x198,
+	RTW89_HW_RATE_HE_NSS2_MCS9	= 0x199,
+	RTW89_HW_RATE_HE_NSS2_MCS10	= 0x19A,
+	RTW89_HW_RATE_HE_NSS2_MCS11	= 0x19B,
+	RTW89_HW_RATE_HE_NSS3_MCS0	= 0x1A0,
+	RTW89_HW_RATE_HE_NSS3_MCS1	= 0x1A1,
+	RTW89_HW_RATE_HE_NSS3_MCS2	= 0x1A2,
+	RTW89_HW_RATE_HE_NSS3_MCS3	= 0x1A3,
+	RTW89_HW_RATE_HE_NSS3_MCS4	= 0x1A4,
+	RTW89_HW_RATE_HE_NSS3_MCS5	= 0x1A5,
+	RTW89_HW_RATE_HE_NSS3_MCS6	= 0x1A6,
+	RTW89_HW_RATE_HE_NSS3_MCS7	= 0x1A7,
+	RTW89_HW_RATE_HE_NSS3_MCS8	= 0x1A8,
+	RTW89_HW_RATE_HE_NSS3_MCS9	= 0x1A9,
+	RTW89_HW_RATE_HE_NSS3_MCS10	= 0x1AA,
+	RTW89_HW_RATE_HE_NSS3_MCS11	= 0x1AB,
+	RTW89_HW_RATE_HE_NSS4_MCS0	= 0x1B0,
+	RTW89_HW_RATE_HE_NSS4_MCS1	= 0x1B1,
+	RTW89_HW_RATE_HE_NSS4_MCS2	= 0x1B2,
+	RTW89_HW_RATE_HE_NSS4_MCS3	= 0x1B3,
+	RTW89_HW_RATE_HE_NSS4_MCS4	= 0x1B4,
+	RTW89_HW_RATE_HE_NSS4_MCS5	= 0x1B5,
+	RTW89_HW_RATE_HE_NSS4_MCS6	= 0x1B6,
+	RTW89_HW_RATE_HE_NSS4_MCS7	= 0x1B7,
+	RTW89_HW_RATE_HE_NSS4_MCS8	= 0x1B8,
+	RTW89_HW_RATE_HE_NSS4_MCS9	= 0x1B9,
+	RTW89_HW_RATE_HE_NSS4_MCS10	= 0x1BA,
+	RTW89_HW_RATE_HE_NSS4_MCS11	= 0x1BB,
+	RTW89_HW_RATE_NR,
+
+	RTW89_HW_RATE_MASK_MOD = GENMASK(8, 7),
+	RTW89_HW_RATE_MASK_VAL = GENMASK(6, 0),
+};
+
+/* 2G channels,
+ * 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14
+ */
+#define RTW89_2G_CH_NUM 14
+
+/* 5G channels,
+ * 36, 38, 40, 42, 44, 46, 48, 50,
+ * 52, 54, 56, 58, 60, 62, 64,
+ * 100, 102, 104, 106, 108, 110, 112, 114,
+ * 116, 118, 120, 122, 124, 126, 128, 130,
+ * 132, 134, 136, 138, 140, 142, 144,
+ * 149, 151, 153, 155, 157, 159, 161, 163,
+ * 165, 167, 169, 171, 173, 175, 177
+ */
+#define RTW89_5G_CH_NUM 53
+
+enum rtw89_rate_section {
+	RTW89_RS_CCK,
+	RTW89_RS_OFDM,
+	RTW89_RS_MCS, /* for HT/VHT/HE */
+	RTW89_RS_HEDCM,
+	RTW89_RS_OFFSET,
+	RTW89_RS_MAX,
+	RTW89_RS_LMT_NUM = RTW89_RS_MCS + 1,
+};
+
+enum rtw89_rate_max {
+	RTW89_RATE_CCK_MAX	= 4,
+	RTW89_RATE_OFDM_MAX	= 8,
+	RTW89_RATE_MCS_MAX	= 12,
+	RTW89_RATE_HEDCM_MAX	= 4, /* for HEDCM MCS0/1/3/4 */
+	RTW89_RATE_OFFSET_MAX	= 5, /* for HE(HEDCM)/VHT/HT/OFDM/CCK offset */
+};
+
+enum rtw89_nss {
+	RTW89_NSS_1		= 0,
+	RTW89_NSS_2		= 1,
+	/* HE DCM only support 1ss and 2ss */
+	RTW89_NSS_HEDCM_MAX	= RTW89_NSS_2 + 1,
+	RTW89_NSS_3		= 2,
+	RTW89_NSS_4		= 3,
+	RTW89_NSS_MAX,
+};
+
+enum rtw89_ntx {
+	RTW89_1TX	= 0,
+	RTW89_2TX	= 1,
+	RTW89_NTX_NUM,
+};
+
+enum rtw89_beamforming_type {
+	RTW89_NONBF	= 0,
+	RTW89_BF	= 1,
+	RTW89_BF_NUM,
+};
+
+enum rtw89_regulation_type {
+	RTW89_WW	= 0,
+	RTW89_ETSI	= 1,
+	RTW89_FCC	= 2,
+	RTW89_MKK	= 3,
+	RTW89_NA	= 4,
+	RTW89_IC	= 5,
+	RTW89_KCC	= 6,
+	RTW89_NCC	= 7,
+	RTW89_CHILE	= 8,
+	RTW89_ACMA	= 9,
+	RTW89_MEXICO	= 10,
+	RTW89_UKRAINE	= 11,
+	RTW89_CN	= 12,
+	RTW89_REGD_NUM,
+};
+
+extern const u8 rtw89_rs_idx_max[RTW89_RS_MAX];
+extern const u8 rtw89_rs_nss_max[RTW89_RS_MAX];
+
+struct rtw89_txpwr_byrate {
+	s8 cck[RTW89_RATE_CCK_MAX];
+	s8 ofdm[RTW89_RATE_OFDM_MAX];
+	s8 mcs[RTW89_NSS_MAX][RTW89_RATE_MCS_MAX];
+	s8 hedcm[RTW89_NSS_HEDCM_MAX][RTW89_RATE_HEDCM_MAX];
+	s8 offset[RTW89_RATE_OFFSET_MAX];
+};
+
+enum rtw89_bandwidth_section_num {
+	RTW89_BW20_SEC_NUM = 8,
+	RTW89_BW40_SEC_NUM = 4,
+	RTW89_BW80_SEC_NUM = 2,
+};
+
+struct rtw89_txpwr_limit {
+	s8 cck_20m[RTW89_BF_NUM];
+	s8 cck_40m[RTW89_BF_NUM];
+	s8 ofdm[RTW89_BF_NUM];
+	s8 mcs_20m[RTW89_BW20_SEC_NUM][RTW89_BF_NUM];
+	s8 mcs_40m[RTW89_BW40_SEC_NUM][RTW89_BF_NUM];
+	s8 mcs_80m[RTW89_BW80_SEC_NUM][RTW89_BF_NUM];
+	s8 mcs_160m[RTW89_BF_NUM];
+	s8 mcs_40m_0p5[RTW89_BF_NUM];
+	s8 mcs_40m_2p5[RTW89_BF_NUM];
+};
+
+#define RTW89_RU_SEC_NUM 8
+
+struct rtw89_txpwr_limit_ru {
+	s8 ru26[RTW89_RU_SEC_NUM];
+	s8 ru52[RTW89_RU_SEC_NUM];
+	s8 ru106[RTW89_RU_SEC_NUM];
+};
+
+struct rtw89_rate_desc {
+	enum rtw89_nss nss;
+	enum rtw89_rate_section rs;
+	u8 idx;
+};
+
+#define PHY_STS_HDR_LEN 8
+#define RF_PATH_MAX 4
+#define RTW89_MAX_PPDU_CNT 8
+struct rtw89_rx_phy_ppdu {
+	u8 *buf;
+	u32 len;
+	u8 rssi_avg;
+	s8 rssi[RF_PATH_MAX];
+	u8 mac_id;
+	bool to_self;
+	bool valid;
+};
+
+enum rtw89_mac_idx {
+	RTW89_MAC_0 = 0,
+	RTW89_MAC_1 = 1,
+};
+
+enum rtw89_phy_idx {
+	RTW89_PHY_0 = 0,
+	RTW89_PHY_1 = 1,
+	RTW89_PHY_MAX
+};
+
+enum rtw89_rf_path {
+	RF_PATH_A = 0,
+	RF_PATH_B = 1,
+	RF_PATH_C = 2,
+	RF_PATH_D = 3,
+	RF_PATH_AB,
+	RF_PATH_AC,
+	RF_PATH_AD,
+	RF_PATH_BC,
+	RF_PATH_BD,
+	RF_PATH_CD,
+	RF_PATH_ABC,
+	RF_PATH_ABD,
+	RF_PATH_ACD,
+	RF_PATH_BCD,
+	RF_PATH_ABCD,
+};
+
+enum rtw89_rf_path_bit {
+	RF_A	= BIT(0),
+	RF_B	= BIT(1),
+	RF_C	= BIT(2),
+	RF_D	= BIT(3),
+
+	RF_AB	= (RF_A | RF_B),
+	RF_AC	= (RF_A | RF_C),
+	RF_AD	= (RF_A | RF_D),
+	RF_BC	= (RF_B | RF_C),
+	RF_BD	= (RF_B | RF_D),
+	RF_CD	= (RF_C | RF_D),
+
+	RF_ABC	= (RF_A | RF_B | RF_C),
+	RF_ABD	= (RF_A | RF_B | RF_D),
+	RF_ACD	= (RF_A | RF_C | RF_D),
+	RF_BCD	= (RF_B | RF_C | RF_D),
+
+	RF_ABCD	= (RF_A | RF_B | RF_C | RF_D),
+};
+
+enum rtw89_bandwidth {
+	RTW89_CHANNEL_WIDTH_20	= 0,
+	RTW89_CHANNEL_WIDTH_40	= 1,
+	RTW89_CHANNEL_WIDTH_80	= 2,
+	RTW89_CHANNEL_WIDTH_160	= 3,
+	RTW89_CHANNEL_WIDTH_80_80	= 4,
+	RTW89_CHANNEL_WIDTH_5	= 5,
+	RTW89_CHANNEL_WIDTH_10	= 6,
+};
+
+enum rtw89_ps_mode {
+	RTW89_PS_MODE_NONE	= 0,
+	RTW89_PS_MODE_RFOFF	= 1,
+	RTW89_PS_MODE_CLK_GATED	= 2,
+	RTW89_PS_MODE_PWR_GATED	= 3,
+};
+
+#define RTW89_MAX_CHANNEL_WIDTH RTW89_CHANNEL_WIDTH_80
+#define RTW89_2G_BW_NUM (RTW89_CHANNEL_WIDTH_40 + 1)
+#define RTW89_5G_BW_NUM (RTW89_CHANNEL_WIDTH_80 + 1)
+#define RTW89_PPE_BW_NUM (RTW89_CHANNEL_WIDTH_80 + 1)
+
+enum rtw89_ru_bandwidth {
+	RTW89_RU26 = 0,
+	RTW89_RU52 = 1,
+	RTW89_RU106 = 2,
+	RTW89_RU_NUM,
+};
+
+enum rtw89_sc_offset {
+	RTW89_SC_DONT_CARE	= 0,
+	RTW89_SC_20_UPPER	= 1,
+	RTW89_SC_20_LOWER	= 2,
+	RTW89_SC_20_UPMOST	= 3,
+	RTW89_SC_20_LOWEST	= 4,
+	RTW89_SC_40_UPPER	= 9,
+	RTW89_SC_40_LOWER	= 10,
+};
+
+struct rtw89_channel_params {
+	u8 center_chan;
+	u8 primary_chan;
+	u8 bandwidth;
+	u8 pri_ch_idx;
+	u8 cch_by_bw[RTW89_MAX_CHANNEL_WIDTH + 1];
+};
+
+struct rtw89_channel_help_params {
+	u16 tx_en;
+};
+
+struct rtw89_port_reg {
+	u32 port_cfg;
+	u32 tbtt_prohib;
+	u32 bcn_area;
+	u32 bcn_early;
+	u32 tbtt_early;
+	u32 tbtt_agg;
+	u32 bcn_space;
+	u32 bcn_forcetx;
+	u32 bcn_err_cnt;
+	u32 bcn_err_flag;
+	u32 dtim_ctrl;
+	u32 tbtt_shift;
+	u32 bcn_cnt_tmr;
+	u32 tsftr_l;
+	u32 tsftr_h;
+};
+
+struct rtw89_txwd_body {
+	__le32 dword0;
+	__le32 dword1;
+	__le32 dword2;
+	__le32 dword3;
+	__le32 dword4;
+	__le32 dword5;
+} __packed;
+
+struct rtw89_txwd_info {
+	__le32 dword0;
+	__le32 dword1;
+	__le32 dword2;
+	__le32 dword3;
+	__le32 dword4;
+	__le32 dword5;
+} __packed;
+
+struct rtw89_rx_desc_info {
+	u16 pkt_size;
+	u8 pkt_type;
+	u8 drv_info_size;
+	u8 shift;
+	u8 wl_hd_iv_len;
+	bool long_rxdesc;
+	bool bb_sel;
+	bool mac_info_valid;
+	u16 data_rate;
+	u8 gi_ltf;
+	u8 bw;
+	u32 free_run_cnt;
+	u8 user_id;
+	bool sr_en;
+	u8 ppdu_cnt;
+	u8 ppdu_type;
+	bool icv_err;
+	bool crc32_err;
+	bool hw_dec;
+	bool sw_dec;
+	bool addr1_match;
+	u8 frag;
+	u16 seq;
+	u8 frame_type;
+	u8 rx_pl_id;
+	bool addr_cam_valid;
+	u8 addr_cam_id;
+	u8 sec_cam_id;
+	u8 mac_id;
+	u16 offset;
+	bool ready;
+};
+
+struct rtw89_rxdesc_short {
+	__le32 dword0;
+	__le32 dword1;
+	__le32 dword2;
+	__le32 dword3;
+} __packed;
+
+struct rtw89_rxdesc_long {
+	__le32 dword0;
+	__le32 dword1;
+	__le32 dword2;
+	__le32 dword3;
+	__le32 dword4;
+	__le32 dword5;
+	__le32 dword6;
+	__le32 dword7;
+} __packed;
+
+struct rtw89_tx_desc_info {
+	u16 pkt_size;
+	u8 wp_offset;
+	u8 qsel;
+	u8 ch_dma;
+	u8 hdr_llc_len;
+	bool is_bmc;
+	bool en_wd_info;
+	bool wd_page;
+	bool use_rate;
+	bool dis_data_fb;
+	bool tid_indicate;
+	bool agg_en;
+	bool bk;
+	u8 ampdu_density;
+	u8 ampdu_num;
+	bool sec_en;
+	u8 sec_type;
+	u8 sec_cam_idx;
+	u16 data_rate;
+	bool fw_dl;
+	u16 seq;
+	bool a_ctrl_bsr;
+};
+
+struct rtw89_core_tx_request {
+	enum rtw89_core_tx_type tx_type;
+
+	struct sk_buff *skb;
+	struct ieee80211_vif *vif;
+	struct ieee80211_sta *sta;
+	struct rtw89_tx_desc_info desc_info;
+};
+
+struct rtw89_txq {
+	struct list_head list;
+	unsigned long flags;
+	int wait_cnt;
+};
+
+struct rtw89_mac_ax_gnt {
+	u8 gnt_bt_sw_en;
+	u8 gnt_bt;
+	u8 gnt_wl_sw_en;
+	u8 gnt_wl;
+};
+
+#define RTW89_MAC_AX_COEX_GNT_NR 2
+struct rtw89_mac_ax_coex_gnt {
+	struct rtw89_mac_ax_gnt band[RTW89_MAC_AX_COEX_GNT_NR];
+};
+
+enum rtw89_btc_ncnt {
+	BTC_NCNT_POWER_ON = 0x0,
+	BTC_NCNT_POWER_OFF,
+	BTC_NCNT_INIT_COEX,
+	BTC_NCNT_SCAN_START,
+	BTC_NCNT_SCAN_FINISH,
+	BTC_NCNT_SPECIAL_PACKET,
+	BTC_NCNT_SWITCH_BAND,
+	BTC_NCNT_RFK_TIMEOUT,
+	BTC_NCNT_SHOW_COEX_INFO,
+	BTC_NCNT_ROLE_INFO,
+	BTC_NCNT_CONTROL,
+	BTC_NCNT_RADIO_STATE,
+	BTC_NCNT_CUSTOMERIZE,
+	BTC_NCNT_WL_RFK,
+	BTC_NCNT_WL_STA,
+	BTC_NCNT_FWINFO,
+	BTC_NCNT_TIMER,
+	BTC_NCNT_NUM
+};
+
+enum rtw89_btc_btinfo {
+	BTC_BTINFO_L0 = 0,
+	BTC_BTINFO_L1,
+	BTC_BTINFO_L2,
+	BTC_BTINFO_L3,
+	BTC_BTINFO_H0,
+	BTC_BTINFO_H1,
+	BTC_BTINFO_H2,
+	BTC_BTINFO_H3,
+	BTC_BTINFO_MAX
+};
+
+enum rtw89_btc_dcnt {
+	BTC_DCNT_RUN = 0x0,
+	BTC_DCNT_CX_RUNINFO,
+	BTC_DCNT_RPT,
+	BTC_DCNT_RPT_FREEZE,
+	BTC_DCNT_CYCLE,
+	BTC_DCNT_CYCLE_FREEZE,
+	BTC_DCNT_W1,
+	BTC_DCNT_W1_FREEZE,
+	BTC_DCNT_B1,
+	BTC_DCNT_B1_FREEZE,
+	BTC_DCNT_TDMA_NONSYNC,
+	BTC_DCNT_SLOT_NONSYNC,
+	BTC_DCNT_BTCNT_FREEZE,
+	BTC_DCNT_WL_SLOT_DRIFT,
+	BTC_DCNT_WL_STA_LAST,
+	BTC_DCNT_NUM,
+};
+
+enum rtw89_btc_wl_state_cnt {
+	BTC_WCNT_SCANAP = 0x0,
+	BTC_WCNT_DHCP,
+	BTC_WCNT_EAPOL,
+	BTC_WCNT_ARP,
+	BTC_WCNT_SCBDUPDATE,
+	BTC_WCNT_RFK_REQ,
+	BTC_WCNT_RFK_GO,
+	BTC_WCNT_RFK_REJECT,
+	BTC_WCNT_RFK_TIMEOUT,
+	BTC_WCNT_CH_UPDATE,
+	BTC_WCNT_NUM
+};
+
+enum rtw89_btc_bt_state_cnt {
+	BTC_BCNT_RETRY = 0x0,
+	BTC_BCNT_REINIT,
+	BTC_BCNT_REENABLE,
+	BTC_BCNT_SCBDREAD,
+	BTC_BCNT_RELINK,
+	BTC_BCNT_IGNOWL,
+	BTC_BCNT_INQPAG,
+	BTC_BCNT_INQ,
+	BTC_BCNT_PAGE,
+	BTC_BCNT_ROLESW,
+	BTC_BCNT_AFH,
+	BTC_BCNT_INFOUPDATE,
+	BTC_BCNT_INFOSAME,
+	BTC_BCNT_SCBDUPDATE,
+	BTC_BCNT_HIPRI_TX,
+	BTC_BCNT_HIPRI_RX,
+	BTC_BCNT_LOPRI_TX,
+	BTC_BCNT_LOPRI_RX,
+	BTC_BCNT_RATECHG,
+	BTC_BCNT_NUM
+};
+
+enum rtw89_btc_bt_profile {
+	BTC_BT_NOPROFILE = 0,
+	BTC_BT_HFP = BIT(0),
+	BTC_BT_HID = BIT(1),
+	BTC_BT_A2DP = BIT(2),
+	BTC_BT_PAN = BIT(3),
+	BTC_PROFILE_MAX = 4,
+};
+
+struct rtw89_btc_ant_info {
+	u8 type;  /* shared, dedicated */
+	u8 num;
+	u8 isolation;
+
+	u8 single_pos: 1;/* Single antenna at S0 or S1 */
+	u8 diversity: 1;
+};
+
+enum rtw89_tfc_dir {
+	RTW89_TFC_UL,
+	RTW89_TFC_DL,
+};
+
+struct rtw89_btc_wl_smap {
+	u32 busy: 1;
+	u32 scan: 1;
+	u32 connecting: 1;
+	u32 roaming: 1;
+	u32 _4way: 1;
+	u32 rf_off: 1;
+	u32 lps: 1;
+	u32 ips: 1;
+	u32 init_ok: 1;
+	u32 traffic_dir : 2;
+	u32 rf_off_pre: 1;
+	u32 lps_pre: 1;
+};
+
+enum rtw89_tfc_lv {
+	RTW89_TFC_IDLE,
+	RTW89_TFC_ULTRA_LOW,
+	RTW89_TFC_LOW,
+	RTW89_TFC_MID,
+	RTW89_TFC_HIGH,
+};
+
+#define RTW89_TP_SHIFT 18 /* bytes/2s --> Mbps */
+DECLARE_EWMA(tp, 10, 2);
+
+struct rtw89_traffic_stats {
+	/* units in bytes */
+	u64 tx_unicast;
+	u64 rx_unicast;
+	u32 tx_avg_len;
+	u32 rx_avg_len;
+
+	/* count for packets */
+	u64 tx_cnt;
+	u64 rx_cnt;
+
+	/* units in Mbps */
+	u32 tx_throughput;
+	u32 rx_throughput;
+	u32 tx_throughput_raw;
+	u32 rx_throughput_raw;
+	enum rtw89_tfc_lv tx_tfc_lv;
+	enum rtw89_tfc_lv rx_tfc_lv;
+	struct ewma_tp tx_ewma_tp;
+	struct ewma_tp rx_ewma_tp;
+
+	u16 tx_rate;
+	u16 rx_rate;
+};
+
+struct rtw89_btc_statistic {
+	u8 rssi; /* 0%~110% (dBm = rssi -110) */
+	struct rtw89_traffic_stats traffic;
+};
+
+#define BTC_WL_RSSI_THMAX 4
+
+struct rtw89_btc_wl_link_info {
+	struct rtw89_btc_statistic stat;
+	enum rtw89_tfc_dir dir;
+	u8 rssi_state[BTC_WL_RSSI_THMAX];
+	u8 mac_addr[ETH_ALEN];
+	u8 busy;
+	u8 ch;
+	u8 bw;
+	u8 band;
+	u8 role;
+	u8 pid;
+	u8 phy;
+	u8 dtim_period;
+	u8 mode;
+
+	u8 mac_id;
+	u8 tx_retry;
+
+	u32 bcn_period;
+	u32 busy_t;
+	u32 tx_time;
+	u32 client_cnt;
+	u32 rx_rate_drop_cnt;
+
+	u32 active: 1;
+	u32 noa: 1;
+	u32 client_ps: 1;
+	u32 connected: 2;
+};
+
+union rtw89_btc_wl_state_map {
+	u32 val;
+	struct rtw89_btc_wl_smap map;
+};
+
+struct rtw89_btc_bt_hfp_desc {
+	u32 exist: 1;
+	u32 type: 2;
+	u32 rsvd: 29;
+};
+
+struct rtw89_btc_bt_hid_desc {
+	u32 exist: 1;
+	u32 slot_info: 2;
+	u32 pair_cnt: 2;
+	u32 type: 8;
+	u32 rsvd: 19;
+};
+
+struct rtw89_btc_bt_a2dp_desc {
+	u8 exist: 1;
+	u8 exist_last: 1;
+	u8 play_latency: 1;
+	u8 type: 3;
+	u8 active: 1;
+	u8 sink: 1;
+
+	u8 bitpool;
+	u16 vendor_id;
+	u32 device_name;
+	u32 flush_time;
+};
+
+struct rtw89_btc_bt_pan_desc {
+	u32 exist: 1;
+	u32 type: 1;
+	u32 active: 1;
+	u32 rsvd: 29;
+};
+
+struct rtw89_btc_bt_rfk_info {
+	u32 run: 1;
+	u32 req: 1;
+	u32 timeout: 1;
+	u32 rsvd: 29;
+};
+
+union rtw89_btc_bt_rfk_info_map {
+	u32 val;
+	struct rtw89_btc_bt_rfk_info map;
+};
+
+struct rtw89_btc_bt_ver_info {
+	u32 fw_coex; /* match with which coex_ver */
+	u32 fw;
+};
+
+struct rtw89_btc_bool_sta_chg {
+	u32 now: 1;
+	u32 last: 1;
+	u32 remain: 1;
+	u32 srvd: 29;
+};
+
+struct rtw89_btc_u8_sta_chg {
+	u8 now;
+	u8 last;
+	u8 remain;
+	u8 rsvd;
+};
+
+struct rtw89_btc_wl_scan_info {
+	u8 band[RTW89_PHY_MAX];
+	u8 phy_map;
+	u8 rsvd;
+};
+
+struct rtw89_btc_wl_dbcc_info {
+	u8 op_band[RTW89_PHY_MAX]; /* op band in each phy */
+	u8 scan_band[RTW89_PHY_MAX]; /* scan band in  each phy */
+	u8 real_band[RTW89_PHY_MAX];
+	u8 role[RTW89_PHY_MAX]; /* role in each phy */
+};
+
+struct rtw89_btc_wl_active_role {
+	u8 connected: 1;
+	u8 pid: 3;
+	u8 phy: 1;
+	u8 noa: 1;
+	u8 band: 2;
+
+	u8 client_ps: 1;
+	u8 bw: 7;
+
+	u8 role;
+	u8 ch;
+
+	u16 tx_lvl;
+	u16 rx_lvl;
+	u16 tx_rate;
+	u16 rx_rate;
+};
+
+struct rtw89_btc_wl_role_info_bpos {
+	u16 none: 1;
+	u16 station: 1;
+	u16 ap: 1;
+	u16 vap: 1;
+	u16 adhoc: 1;
+	u16 adhoc_master: 1;
+	u16 mesh: 1;
+	u16 moniter: 1;
+	u16 p2p_device: 1;
+	u16 p2p_gc: 1;
+	u16 p2p_go: 1;
+	u16 nan: 1;
+};
+
+union rtw89_btc_wl_role_info_map {
+	u16 val;
+	struct rtw89_btc_wl_role_info_bpos role;
+};
+
+struct rtw89_btc_wl_role_info { /* struct size must be n*4 bytes */
+	u8 connect_cnt;
+	u8 link_mode;
+	union rtw89_btc_wl_role_info_map role_map;
+	struct rtw89_btc_wl_active_role active_role[RTW89_MAX_HW_PORT_NUM];
+};
+
+struct rtw89_btc_wl_ver_info {
+	u32 fw_coex; /* match with which coex_ver */
+	u32 fw;
+	u32 mac;
+	u32 bb;
+	u32 rf;
+};
+
+struct rtw89_btc_wl_afh_info {
+	u8 en;
+	u8 ch;
+	u8 bw;
+	u8 rsvd;
+} __packed;
+
+struct rtw89_btc_wl_rfk_info {
+	u32 state: 2;
+	u32 path_map: 4;
+	u32 phy_map: 2;
+	u32 band: 2;
+	u32 type: 8;
+	u32 rsvd: 14;
+};
+
+struct rtw89_btc_bt_smap {
+	u32 connect: 1;
+	u32 ble_connect: 1;
+	u32 acl_busy: 1;
+	u32 sco_busy: 1;
+	u32 mesh_busy: 1;
+	u32 inq_pag: 1;
+};
+
+union rtw89_btc_bt_state_map {
+	u32 val;
+	struct rtw89_btc_bt_smap map;
+};
+
+#define BTC_BT_RSSI_THMAX 4
+#define BTC_BT_AFH_GROUP 12
+
+struct rtw89_btc_bt_link_info {
+	struct rtw89_btc_u8_sta_chg profile_cnt;
+	struct rtw89_btc_bool_sta_chg multi_link;
+	struct rtw89_btc_bool_sta_chg relink;
+	struct rtw89_btc_bt_hfp_desc hfp_desc;
+	struct rtw89_btc_bt_hid_desc hid_desc;
+	struct rtw89_btc_bt_a2dp_desc a2dp_desc;
+	struct rtw89_btc_bt_pan_desc pan_desc;
+	union rtw89_btc_bt_state_map status;
+
+	u8 sut_pwr_level[BTC_PROFILE_MAX];
+	u8 golden_rx_shift[BTC_PROFILE_MAX];
+	u8 rssi_state[BTC_BT_RSSI_THMAX];
+	u8 afh_map[BTC_BT_AFH_GROUP];
+
+	u32 role_sw: 1;
+	u32 slave_role: 1;
+	u32 afh_update: 1;
+	u32 cqddr: 1;
+	u32 rssi: 8;
+	u32 tx_3m: 1;
+	u32 rsvd: 19;
+};
+
+struct rtw89_btc_3rdcx_info {
+	u8 type;   /* 0: none, 1:zigbee, 2:LTE  */
+	u8 hw_coex;
+	u16 rsvd;
+};
+
+struct rtw89_btc_dm_emap {
+	u32 init: 1;
+	u32 pta_owner: 1;
+	u32 wl_rfk_timeout: 1;
+	u32 bt_rfk_timeout: 1;
+
+	u32 wl_fw_hang: 1;
+	u32 offload_mismatch: 1;
+	u32 cycle_hang: 1;
+	u32 w1_hang: 1;
+
+	u32 b1_hang: 1;
+	u32 tdma_no_sync: 1;
+	u32 wl_slot_drift: 1;
+};
+
+union rtw89_btc_dm_error_map {
+	u32 val;
+	struct rtw89_btc_dm_emap map;
+};
+
+struct rtw89_btc_rf_para {
+	u32 tx_pwr_freerun;
+	u32 rx_gain_freerun;
+	u32 tx_pwr_perpkt;
+	u32 rx_gain_perpkt;
+};
+
+struct rtw89_btc_wl_info {
+	struct rtw89_btc_wl_link_info link_info[RTW89_MAX_HW_PORT_NUM];
+	struct rtw89_btc_wl_rfk_info rfk_info;
+	struct rtw89_btc_wl_ver_info  ver_info;
+	struct rtw89_btc_wl_afh_info afh_info;
+	struct rtw89_btc_wl_role_info role_info;
+	struct rtw89_btc_wl_scan_info scan_info;
+	struct rtw89_btc_wl_dbcc_info dbcc_info;
+	struct rtw89_btc_rf_para rf_para;
+	union rtw89_btc_wl_state_map status;
+
+	u8 port_id[RTW89_WIFI_ROLE_MLME_MAX];
+	u8 rssi_level;
+
+	u32 scbd;
+};
+
+struct rtw89_btc_module {
+	struct rtw89_btc_ant_info ant;
+	u8 rfe_type;
+	u8 cv;
+
+	u8 bt_solo: 1;
+	u8 bt_pos: 1;
+	u8 switch_type: 1;
+
+	u8 rsvd;
+};
+
+#define RTW89_BTC_DM_MAXSTEP 30
+#define RTW89_BTC_DM_CNT_MAX (RTW89_BTC_DM_MAXSTEP * 8)
+
+struct rtw89_btc_dm_step {
+	u16 step[RTW89_BTC_DM_MAXSTEP];
+	u8 step_pos;
+	bool step_ov;
+};
+
+struct rtw89_btc_init_info {
+	struct rtw89_btc_module module;
+	u8 wl_guard_ch;
+
+	u8 wl_only: 1;
+	u8 wl_init_ok: 1;
+	u8 dbcc_en: 1;
+	u8 cx_other: 1;
+	u8 bt_only: 1;
+
+	u16 rsvd;
+};
+
+struct rtw89_btc_wl_tx_limit_para {
+	u16 enable;
+	u32 tx_time;	/* unit: us */
+	u16 tx_retry;
+};
+
+struct rtw89_btc_bt_scan_info {
+	u16 win;
+	u16 intvl;
+	u32 enable: 1;
+	u32 interlace: 1;
+	u32 rsvd: 30;
+};
+
+enum rtw89_btc_bt_scan_type {
+	BTC_SCAN_INQ	= 0,
+	BTC_SCAN_PAGE,
+	BTC_SCAN_BLE,
+	BTC_SCAN_INIT,
+	BTC_SCAN_TV,
+	BTC_SCAN_ADV,
+	BTC_SCAN_MAX1,
+};
+
+struct rtw89_btc_bt_info {
+	struct rtw89_btc_bt_link_info link_info;
+	struct rtw89_btc_bt_scan_info scan_info[BTC_SCAN_MAX1];
+	struct rtw89_btc_bt_ver_info ver_info;
+	struct rtw89_btc_bool_sta_chg enable;
+	struct rtw89_btc_bool_sta_chg inq_pag;
+	struct rtw89_btc_rf_para rf_para;
+	union rtw89_btc_bt_rfk_info_map rfk_info;
+
+	u8 raw_info[BTC_BTINFO_MAX]; /* raw bt info from mailbox */
+
+	u32 scbd;
+	u32 feature;
+
+	u32 mbx_avl: 1;
+	u32 whql_test: 1;
+	u32 igno_wl: 1;
+	u32 reinit: 1;
+	u32 ble_scan_en: 1;
+	u32 btg_type: 1;
+	u32 inq: 1;
+	u32 pag: 1;
+	u32 run_patch_code: 1;
+	u32 hi_lna_rx: 1;
+	u32 rsvd: 22;
+};
+
+struct rtw89_btc_cx {
+	struct rtw89_btc_wl_info wl;
+	struct rtw89_btc_bt_info bt;
+	struct rtw89_btc_3rdcx_info other;
+	u32 state_map;
+	u32 cnt_bt[BTC_BCNT_NUM];
+	u32 cnt_wl[BTC_WCNT_NUM];
+};
+
+struct rtw89_btc_fbtc_tdma {
+	u8 type;
+	u8 rxflctrl;
+	u8 txpause;
+	u8 wtgle_n;
+	u8 leak_n;
+	u8 ext_ctrl;
+	u8 rsvd0;
+	u8 rsvd1;
+} __packed;
+
+#define CXMREG_MAX 30
+#define FCXMAX_STEP 255 /*STEP trace record cnt, Max:65535, default:255*/
+#define BTCRPT_VER 1
+#define BTC_CYCLE_SLOT_MAX 48 /* must be even number, non-zero */
+
+enum rtw89_btc_bt_rfk_counter {
+	BTC_BCNT_RFK_REQ = 0,
+	BTC_BCNT_RFK_GO = 1,
+	BTC_BCNT_RFK_REJECT = 2,
+	BTC_BCNT_RFK_FAIL = 3,
+	BTC_BCNT_RFK_TIMEOUT = 4,
+	BTC_BCNT_RFK_MAX
+};
+
+struct rtw89_btc_fbtc_rpt_ctrl {
+	u16 fver;
+	u16 rpt_cnt; /* tmr counters */
+	u32 wl_fw_coex_ver; /* match which driver's coex version */
+	u32 wl_fw_cx_offload;
+	u32 wl_fw_ver;
+	u32 rpt_enable;
+	u32 rpt_para; /* ms */
+	u32 mb_send_fail_cnt; /* fw send mailbox fail counter */
+	u32 mb_send_ok_cnt; /* fw send mailbox ok counter */
+	u32 mb_recv_cnt; /* fw recv mailbox counter */
+	u32 mb_a2dp_empty_cnt; /* a2dp empty count */
+	u32 mb_a2dp_flct_cnt; /* a2dp empty flow control counter */
+	u32 mb_a2dp_full_cnt; /* a2dp empty full counter */
+	u32 bt_rfk_cnt[BTC_BCNT_RFK_MAX];
+	u32 c2h_cnt; /* fw send c2h counter  */
+	u32 h2c_cnt; /* fw recv h2c counter */
+} __packed;
+
+enum rtw89_fbtc_ext_ctrl_type {
+	CXECTL_OFF = 0x0, /* tdma off */
+	CXECTL_B2 = 0x1, /* allow B2 (beacon-early) */
+	CXECTL_EXT = 0x2,
+	CXECTL_MAX
+};
+
+union rtw89_btc_fbtc_rxflct {
+	u8 val;
+	u8 type: 3;
+	u8 tgln_n: 5;
+};
+
+enum rtw89_btc_cxst_state {
+	CXST_OFF = 0x0,
+	CXST_B2W = 0x1,
+	CXST_W1 = 0x2,
+	CXST_W2 = 0x3,
+	CXST_W2B = 0x4,
+	CXST_B1 = 0x5,
+	CXST_B2 = 0x6,
+	CXST_B3 = 0x7,
+	CXST_B4 = 0x8,
+	CXST_LK = 0x9,
+	CXST_BLK = 0xa,
+	CXST_E2G = 0xb,
+	CXST_E5G = 0xc,
+	CXST_EBT = 0xd,
+	CXST_ENULL = 0xe,
+	CXST_WLK = 0xf,
+	CXST_W1FDD = 0x10,
+	CXST_B1FDD = 0x11,
+	CXST_MAX = 0x12,
+};
+
+enum {
+	CXBCN_ALL = 0x0,
+	CXBCN_ALL_OK,
+	CXBCN_BT_SLOT,
+	CXBCN_BT_OK,
+	CXBCN_MAX
+};
+
+enum btc_slot_type {
+	SLOT_MIX = 0x0, /* accept BT Lower-Pri Tx/Rx request 0x778 = 1 */
+	SLOT_ISO = 0x1, /* no accept BT Lower-Pri Tx/Rx request 0x778 = d*/
+	CXSTYPE_NUM,
+};
+
+enum { /* TIME */
+	CXT_BT = 0x0,
+	CXT_WL = 0x1,
+	CXT_MAX
+};
+
+enum { /* TIME-A2DP */
+	CXT_FLCTRL_OFF = 0x0,
+	CXT_FLCTRL_ON = 0x1,
+	CXT_FLCTRL_MAX
+};
+
+enum { /* STEP TYPE */
+	CXSTEP_NONE = 0x0,
+	CXSTEP_EVNT = 0x1,
+	CXSTEP_SLOT = 0x2,
+	CXSTEP_MAX,
+};
+
+#define FCXGPIODBG_VER 1
+#define BTC_DBG_MAX1  32
+struct rtw89_btc_fbtc_gpio_dbg {
+	u8 fver;
+	u8 rsvd;
+	u16 rsvd2;
+	u32 en_map; /* which debug signal (see btc_wl_gpio_debug) is enable */
+	u32 pre_state; /* the debug signal is 1 or 0  */
+	u8 gpio_map[BTC_DBG_MAX1]; /*the debug signals to GPIO-Position */
+} __packed;
+
+#define FCXMREG_VER 1
+struct rtw89_btc_fbtc_mreg_val {
+	u8 fver;
+	u8 reg_num;
+	__le16 rsvd;
+	__le32 mreg_val[CXMREG_MAX];
+} __packed;
+
+#define RTW89_DEF_FBTC_MREG(__type, __bytes, __offset) \
+	{ .type = cpu_to_le16(__type), .bytes = cpu_to_le16(__bytes), \
+	  .offset = cpu_to_le32(__offset), }
+
+struct rtw89_btc_fbtc_mreg {
+	__le16 type;
+	__le16 bytes;
+	__le32 offset;
+} __packed;
+
+struct rtw89_btc_fbtc_slot {
+	__le16 dur;
+	__le32 cxtbl;
+	__le16 cxtype;
+} __packed;
+
+#define FCXSLOTS_VER 1
+struct rtw89_btc_fbtc_slots {
+	u8 fver;
+	u8 tbl_num;
+	__le16 rsvd;
+	__le32 update_map;
+	struct rtw89_btc_fbtc_slot slot[CXST_MAX];
+} __packed;
+
+#define FCXSTEP_VER 2
+struct rtw89_btc_fbtc_step {
+	u8 type;
+	u8 val;
+	__le16 difft;
+} __packed;
+
+struct rtw89_btc_fbtc_steps {
+	u8 fver;
+	u8 rsvd;
+	__le16 cnt;
+	__le16 pos_old;
+	__le16 pos_new;
+	struct rtw89_btc_fbtc_step step[FCXMAX_STEP];
+} __packed;
+
+#define FCXCYSTA_VER 2
+struct rtw89_btc_fbtc_cysta { /* statistics for cycles */
+	u8 fver;
+	u8 rsvd;
+	__le16 cycles; /* total cycle number */
+	__le16 cycles_a2dp[CXT_FLCTRL_MAX];
+	__le16 a2dpept; /* a2dp empty cnt */
+	__le16 a2dpeptto; /* a2dp empty timeout cnt*/
+	__le16 tavg_cycle[CXT_MAX]; /* avg wl/bt cycle time */
+	__le16 tmax_cycle[CXT_MAX]; /* max wl/bt cycle time */
+	__le16 tmaxdiff_cycle[CXT_MAX]; /* max wl-wl bt-bt cycle diff time */
+	__le16 tavg_a2dp[CXT_FLCTRL_MAX]; /* avg a2dp PSTDMA/TDMA time */
+	__le16 tmax_a2dp[CXT_FLCTRL_MAX]; /* max a2dp PSTDMA/TDMA time */
+	__le16 tavg_a2dpept; /* avg a2dp empty time */
+	__le16 tmax_a2dpept; /* max a2dp empty time */
+	__le16 tavg_lk; /* avg leak-slot time */
+	__le16 tmax_lk; /* max leak-slot time */
+	__le32 slot_cnt[CXST_MAX]; /* slot count */
+	__le32 bcn_cnt[CXBCN_MAX];
+	__le32 leakrx_cnt; /* the rximr occur at leak slot  */
+	__le32 collision_cnt; /* counter for event/timer occur at same time */
+	__le32 skip_cnt;
+	__le32 exception;
+	__le32 except_cnt;
+#if (FCXCYSTA_VER > 1)
+	__le16 tslot_cycle[BTC_CYCLE_SLOT_MAX];
+#endif
+} __packed;
+
+#define FCXNULLSTA_VER 1
+struct rtw89_btc_fbtc_cynullsta { /* cycle null statistics */
+	u8 fver;
+	u8 rsvd;
+	__le16 rsvd2;
+	__le32 max_t[2]; /* max_t for 0:null0/1:null1 */
+	__le32 avg_t[2]; /* avg_t for 0:null0/1:null1 */
+	__le32 result[2][4]; /* 0:fail, 1:ok, 2:on_time, 3:retry */
+} __packed;
+
+#define FCX_BTVER_VER 1
+struct rtw89_btc_fbtc_btver {
+	u8 fver;
+	u8 rsvd;
+	__le16 rsvd2;
+	__le32 coex_ver; /*bit[15:8]->shared, bit[7:0]->non-shared */
+	__le32 fw_ver;
+	__le32 feature;
+} __packed;
+
+#define FCX_BTSCAN_VER 1
+struct rtw89_btc_fbtc_btscan {
+	u8 fver;
+	u8 rsvd;
+	__le16 rsvd2;
+	u8 scan[6];
+} __packed;
+
+#define FCX_BTAFH_VER 1
+struct rtw89_btc_fbtc_btafh {
+	u8 fver;
+	u8 rsvd;
+	__le16 rsvd2;
+	u8 afh_l[4]; /*bit0:2402, bit1: 2403.... bit31:2433 */
+	u8 afh_m[4]; /*bit0:2434, bit1: 2435.... bit31:2465 */
+	u8 afh_h[4]; /*bit0:2466, bit1:2467......bit14:2480 */
+} __packed;
+
+#define FCX_BTDEVINFO_VER 1
+struct rtw89_btc_fbtc_btdevinfo {
+	u8 fver;
+	u8 rsvd;
+	__le16 vendor_id;
+	__le32 dev_name; /* only 24 bits valid */
+	__le32 flush_time;
+} __packed;
+
+#define RTW89_BTC_WL_DEF_TX_PWR GENMASK(7, 0)
+struct rtw89_btc_rf_trx_para {
+	u32 wl_tx_power; /* absolute Tx power (dBm), 0xff-> no BTC control */
+	u32 wl_rx_gain;  /* rx gain table index (TBD.) */
+	u8 bt_tx_power; /* decrease Tx power (dB) */
+	u8 bt_rx_gain;  /* LNA constrain level */
+};
+
+struct rtw89_btc_dm {
+	struct rtw89_btc_fbtc_slot slot[CXST_MAX];
+	struct rtw89_btc_fbtc_slot slot_now[CXST_MAX];
+	struct rtw89_btc_fbtc_tdma tdma;
+	struct rtw89_btc_fbtc_tdma tdma_now;
+	struct rtw89_mac_ax_coex_gnt gnt;
+	struct rtw89_btc_init_info init_info; /* pass to wl_fw if offload */
+	struct rtw89_btc_rf_trx_para rf_trx_para;
+	struct rtw89_btc_wl_tx_limit_para wl_tx_limit;
+	struct rtw89_btc_dm_step dm_step;
+	union rtw89_btc_dm_error_map error;
+	u32 cnt_dm[BTC_DCNT_NUM];
+	u32 cnt_notify[BTC_NCNT_NUM];
+
+	u32 update_slot_map;
+	u32 set_ant_path;
+
+	u32 wl_only: 1;
+	u32 wl_fw_cx_offload: 1;
+	u32 freerun: 1;
+	u32 wl_ps_ctrl: 2;
+	u32 wl_mimo_ps: 1;
+	u32 leak_ap: 1;
+	u32 noisy_level: 3;
+	u32 coex_info_map: 8;
+	u32 bt_only: 1;
+	u32 wl_btg_rx: 1;
+	u32 trx_para_level: 8;
+	u32 rsvd: 4;
+
+	u16 slot_dur[CXST_MAX];
+
+	u8 run_reason;
+	u8 run_action;
+};
+
+struct rtw89_btc_ctrl {
+	u32 manual: 1;
+	u32 igno_bt: 1;
+	u32 always_freerun: 1;
+	u32 trace_step: 16;
+	u32 rsvd: 12;
+};
+
+struct rtw89_btc_dbg {
+	/* cmd "rb" */
+	bool rb_done;
+	u32 rb_val;
+};
+
+#define FCXTDMA_VER 1
+
+enum rtw89_btc_btf_fw_event {
+	BTF_EVNT_RPT = 0,
+	BTF_EVNT_BT_INFO = 1,
+	BTF_EVNT_BT_SCBD = 2,
+	BTF_EVNT_BT_REG = 3,
+	BTF_EVNT_CX_RUNINFO = 4,
+	BTF_EVNT_BT_PSD = 5,
+	BTF_EVNT_BUF_OVERFLOW,
+	BTF_EVNT_C2H_LOOPBACK,
+	BTF_EVNT_MAX,
+};
+
+enum btf_fw_event_report {
+	BTC_RPT_TYPE_CTRL = 0x0,
+	BTC_RPT_TYPE_TDMA,
+	BTC_RPT_TYPE_SLOT,
+	BTC_RPT_TYPE_CYSTA,
+	BTC_RPT_TYPE_STEP,
+	BTC_RPT_TYPE_NULLSTA,
+	BTC_RPT_TYPE_MREG,
+	BTC_RPT_TYPE_GPIO_DBG,
+	BTC_RPT_TYPE_BT_VER,
+	BTC_RPT_TYPE_BT_SCAN,
+	BTC_RPT_TYPE_BT_AFH,
+	BTC_RPT_TYPE_BT_DEVICE,
+	BTC_RPT_TYPE_TEST,
+	BTC_RPT_TYPE_MAX = 31
+};
+
+enum rtw_btc_btf_reg_type {
+	REG_MAC = 0x0,
+	REG_BB = 0x1,
+	REG_RF = 0x2,
+	REG_BT_RF = 0x3,
+	REG_BT_MODEM = 0x4,
+	REG_BT_BLUEWIZE = 0x5,
+	REG_BT_VENDOR = 0x6,
+	REG_BT_LE = 0x7,
+	REG_MAX_TYPE,
+};
+
+struct rtw89_btc_rpt_cmn_info {
+	u32 rx_cnt;
+	u32 rx_len;
+	u32 req_len; /* expected rsp len */
+	u8 req_fver; /* expected rsp fver */
+	u8 rsp_fver; /* fver from fw */
+	u8 valid;
+} __packed;
+
+struct rtw89_btc_report_ctrl_state {
+	struct rtw89_btc_rpt_cmn_info cinfo; /* common info, by driver */
+	struct rtw89_btc_fbtc_rpt_ctrl finfo; /* info from fw */
+};
+
+struct rtw89_btc_rpt_fbtc_tdma {
+	struct rtw89_btc_rpt_cmn_info cinfo; /* common info, by driver */
+	struct rtw89_btc_fbtc_tdma finfo; /* info from fw */
+};
+
+struct rtw89_btc_rpt_fbtc_slots {
+	struct rtw89_btc_rpt_cmn_info cinfo; /* common info, by driver */
+	struct rtw89_btc_fbtc_slots finfo; /* info from fw */
+};
+
+struct rtw89_btc_rpt_fbtc_cysta {
+	struct rtw89_btc_rpt_cmn_info cinfo; /* common info, by driver */
+	struct rtw89_btc_fbtc_cysta finfo; /* info from fw */
+};
+
+struct rtw89_btc_rpt_fbtc_step {
+	struct rtw89_btc_rpt_cmn_info cinfo; /* common info, by driver */
+	struct rtw89_btc_fbtc_steps finfo; /* info from fw */
+};
+
+struct rtw89_btc_rpt_fbtc_nullsta {
+	struct rtw89_btc_rpt_cmn_info cinfo; /* common info, by driver */
+	struct rtw89_btc_fbtc_cynullsta finfo; /* info from fw */
+};
+
+struct rtw89_btc_rpt_fbtc_mreg {
+	struct rtw89_btc_rpt_cmn_info cinfo; /* common info, by driver */
+	struct rtw89_btc_fbtc_mreg_val finfo; /* info from fw */
+};
+
+struct rtw89_btc_rpt_fbtc_gpio_dbg {
+	struct rtw89_btc_rpt_cmn_info cinfo; /* common info, by driver */
+	struct rtw89_btc_fbtc_gpio_dbg finfo; /* info from fw */
+};
+
+struct rtw89_btc_rpt_fbtc_btver {
+	struct rtw89_btc_rpt_cmn_info cinfo; /* common info, by driver */
+	struct rtw89_btc_fbtc_btver finfo; /* info from fw */
+};
+
+struct rtw89_btc_rpt_fbtc_btscan {
+	struct rtw89_btc_rpt_cmn_info cinfo; /* common info, by driver */
+	struct rtw89_btc_fbtc_btscan finfo; /* info from fw */
+};
+
+struct rtw89_btc_rpt_fbtc_btafh {
+	struct rtw89_btc_rpt_cmn_info cinfo; /* common info, by driver */
+	struct rtw89_btc_fbtc_btafh finfo; /* info from fw */
+};
+
+struct rtw89_btc_rpt_fbtc_btdev {
+	struct rtw89_btc_rpt_cmn_info cinfo; /* common info, by driver */
+	struct rtw89_btc_fbtc_btdevinfo finfo; /* info from fw */
+};
+
+enum rtw89_btc_btfre_type {
+	BTFRE_INVALID_INPUT = 0x0, /* invalid input parameters */
+	BTFRE_UNDEF_TYPE,
+	BTFRE_EXCEPTION,
+	BTFRE_MAX,
+};
+
+struct rtw89_btc_btf_fwinfo {
+	u32 cnt_c2h;
+	u32 cnt_h2c;
+	u32 cnt_h2c_fail;
+	u32 event[BTF_EVNT_MAX];
+
+	u32 err[BTFRE_MAX];
+	u32 len_mismch;
+	u32 fver_mismch;
+	u32 rpt_en_map;
+
+	struct rtw89_btc_report_ctrl_state rpt_ctrl;
+	struct rtw89_btc_rpt_fbtc_tdma rpt_fbtc_tdma;
+	struct rtw89_btc_rpt_fbtc_slots rpt_fbtc_slots;
+	struct rtw89_btc_rpt_fbtc_cysta rpt_fbtc_cysta;
+	struct rtw89_btc_rpt_fbtc_step rpt_fbtc_step;
+	struct rtw89_btc_rpt_fbtc_nullsta rpt_fbtc_nullsta;
+	struct rtw89_btc_rpt_fbtc_mreg rpt_fbtc_mregval;
+	struct rtw89_btc_rpt_fbtc_gpio_dbg rpt_fbtc_gpio_dbg;
+	struct rtw89_btc_rpt_fbtc_btver rpt_fbtc_btver;
+	struct rtw89_btc_rpt_fbtc_btscan rpt_fbtc_btscan;
+	struct rtw89_btc_rpt_fbtc_btafh rpt_fbtc_btafh;
+	struct rtw89_btc_rpt_fbtc_btdev rpt_fbtc_btdev;
+};
+
+#define RTW89_BTC_POLICY_MAXLEN 512
+
+struct rtw89_btc {
+	struct rtw89_btc_cx cx;
+	struct rtw89_btc_dm dm;
+	struct rtw89_btc_ctrl ctrl;
+	struct rtw89_btc_module mdinfo;
+	struct rtw89_btc_btf_fwinfo fwinfo;
+	struct rtw89_btc_dbg dbg;
+
+	struct work_struct eapol_notify_work;
+	struct work_struct arp_notify_work;
+	struct work_struct dhcp_notify_work;
+	struct work_struct wl_sta_notify_work;
+
+	u32 bt_req_len;
+
+	u8 policy[RTW89_BTC_POLICY_MAXLEN];
+	u16 policy_len;
+	u16 policy_type;
+	bool bt_req_en;
+	bool update_policy_force;
+	bool lps;
+};
+
+enum rtw89_ra_mode {
+	RTW89_RA_MODE_CCK = BIT(0),
+	RTW89_RA_MODE_OFDM = BIT(1),
+	RTW89_RA_MODE_HT = BIT(2),
+	RTW89_RA_MODE_VHT = BIT(3),
+	RTW89_RA_MODE_HE = BIT(4),
+};
+
+enum rtw89_ra_report_mode {
+	RTW89_RA_RPT_MODE_LEGACY,
+	RTW89_RA_RPT_MODE_HT,
+	RTW89_RA_RPT_MODE_VHT,
+	RTW89_RA_RPT_MODE_HE,
+};
+
+enum rtw89_dig_noisy_level {
+	RTW89_DIG_NOISY_LEVEL0 = -1,
+	RTW89_DIG_NOISY_LEVEL1 = 0,
+	RTW89_DIG_NOISY_LEVEL2 = 1,
+	RTW89_DIG_NOISY_LEVEL3 = 2,
+	RTW89_DIG_NOISY_LEVEL_MAX = 3,
+};
+
+enum rtw89_gi_ltf {
+	RTW89_GILTF_LGI_4XHE32 = 0,
+	RTW89_GILTF_SGI_4XHE08 = 1,
+	RTW89_GILTF_2XHE16 = 2,
+	RTW89_GILTF_2XHE08 = 3,
+	RTW89_GILTF_1XHE16 = 4,
+	RTW89_GILTF_1XHE08 = 5,
+	RTW89_GILTF_MAX
+};
+
+enum rtw89_rx_frame_type {
+	RTW89_RX_TYPE_MGNT = 0,
+	RTW89_RX_TYPE_CTRL = 1,
+	RTW89_RX_TYPE_DATA = 2,
+	RTW89_RX_TYPE_RSVD = 3,
+};
+
+struct rtw89_ra_info {
+	u8 is_dis_ra:1;
+	/* Bit0 : CCK
+	 * Bit1 : OFDM
+	 * Bit2 : HT
+	 * Bit3 : VHT
+	 * Bit4 : HE
+	 */
+	u8 mode_ctrl:5;
+	u8 bw_cap:2;
+	u8 macid;
+	u8 dcm_cap:1;
+	u8 er_cap:1;
+	u8 init_rate_lv:2;
+	u8 upd_all:1;
+	u8 en_sgi:1;
+	u8 ldpc_cap:1;
+	u8 stbc_cap:1;
+	u8 ss_num:3;
+	u8 giltf:3;
+	u8 upd_bw_nss_mask:1;
+	u8 upd_mask:1;
+	u64 ra_mask; /* 63 bits ra_mask + 1 bit CSI ctrl */
+	/* BFee CSI */
+	u8 band_num;
+	u8 ra_csi_rate_en:1;
+	u8 fixed_csi_rate_en:1;
+	u8 cr_tbl_sel:1;
+	u8 rsvd2:5;
+	u8 csi_mcs_ss_idx;
+	u8 csi_mode:2;
+	u8 csi_gi_ltf:3;
+	u8 csi_bw:3;
+};
+
+#define RTW89_PPDU_MAX_USR 4
+#define RTW89_PPDU_MAC_INFO_USR_SIZE 4
+#define RTW89_PPDU_MAC_INFO_SIZE 8
+#define RTW89_PPDU_MAC_RX_CNT_SIZE 96
+
+#define RTW89_MAX_RX_AGG_NUM 64
+#define RTW89_MAX_TX_AGG_NUM 128
+
+struct rtw89_ampdu_params {
+	u16 agg_num;
+	bool amsdu;
+};
+
+struct rtw89_ra_report {
+	struct rate_info txrate;
+	u32 bit_rate;
+	u16 hw_rate;
+};
+
+DECLARE_EWMA(rssi, 10, 16);
+
+struct rtw89_sta {
+	u8 mac_id;
+	bool disassoc;
+	struct rtw89_vif *rtwvif;
+	struct rtw89_ra_info ra;
+	struct rtw89_ra_report ra_report;
+	int max_agg_wait;
+	u8 prev_rssi;
+	struct ewma_rssi avg_rssi;
+	struct rtw89_ampdu_params ampdu_params[IEEE80211_NUM_TIDS];
+	struct ieee80211_rx_status rx_status;
+	u16 rx_hw_rate;
+
+	bool use_cfg_mask;
+	struct cfg80211_bitrate_mask mask;
+
+	bool cctl_tx_time;
+	u32 ampdu_max_time:4;
+	bool cctl_tx_retry_limit;
+	u32 data_tx_cnt_lmt:6;
+};
+
+#define RTW89_MAX_ADDR_CAM_NUM		128
+#define RTW89_MAX_BSSID_CAM_NUM		20
+#define RTW89_MAX_SEC_CAM_NUM		128
+#define RTW89_SEC_CAM_IN_ADDR_CAM	7
+
+struct rtw89_addr_cam_entry {
+	u8 addr_cam_idx;
+	u8 offset;
+	u8 len;
+	u8 valid	: 1;
+	u8 addr_mask	: 6;
+	u8 wapi		: 1;
+	u8 mask_sel	: 2;
+	u8 bssid_cam_idx: 6;
+	u8 tma[ETH_ALEN];
+	u8 sma[ETH_ALEN];
+
+	u8 sec_ent_mode;
+	DECLARE_BITMAP(sec_cam_map, RTW89_SEC_CAM_IN_ADDR_CAM);
+	u8 sec_ent_keyid[RTW89_SEC_CAM_IN_ADDR_CAM];
+	u8 sec_ent[RTW89_SEC_CAM_IN_ADDR_CAM];
+	struct rtw89_sec_cam_entry *sec_entries[RTW89_SEC_CAM_IN_ADDR_CAM];
+};
+
+struct rtw89_bssid_cam_entry {
+	u8 bssid[ETH_ALEN];
+	u8 phy_idx;
+	u8 bssid_cam_idx;
+	u8 offset;
+	u8 len;
+	u8 valid : 1;
+	u8 num;
+};
+
+struct rtw89_sec_cam_entry {
+	u8 sec_cam_idx;
+	u8 offset;
+	u8 len;
+	u8 type : 4;
+	u8 ext_key : 1;
+	u8 spp_mode : 1;
+	/* 256 bits */
+	u8 key[32];
+};
+
+struct rtw89_efuse {
+	bool valid;
+	u8 xtal_cap;
+	u8 addr[ETH_ALEN];
+	u8 rfe_type;
+	char country_code[2];
+};
+
+struct rtw89_vif {
+	struct list_head list;
+	u8 mac_id;
+	u8 port;
+	u8 mac_addr[ETH_ALEN];
+	u8 bssid[ETH_ALEN];
+	u8 phy_idx;
+	u8 mac_idx;
+	u8 net_type;
+	u8 wifi_role;
+	u8 self_role;
+	u8 wmm;
+	u8 bcn_hit_cond;
+	u8 hit_rule;
+	bool trigger;
+	bool lsig_txop;
+	u8 tgt_ind;
+	u8 frm_tgt_ind;
+	bool wowlan_pattern;
+	bool wowlan_uc;
+	bool wowlan_magic;
+	bool is_hesta;
+	bool last_a_ctrl;
+	union {
+		struct {
+			struct ieee80211_sta *ap;
+		} mgd;
+		struct {
+			struct list_head sta_list;
+		} ap;
+	};
+	struct rtw89_addr_cam_entry addr_cam;
+	struct rtw89_bssid_cam_entry bssid_cam;
+	struct ieee80211_tx_queue_params tx_params[IEEE80211_NUM_ACS];
+	struct rtw89_traffic_stats stats;
+};
+
+enum rtw89_lv1_rcvy_step {
+	RTW89_LV1_RCVY_STEP_1,
+	RTW89_LV1_RCVY_STEP_2,
+};
+
+struct rtw89_hci_ops {
+	int (*tx_write)(struct rtw89_dev *rtwdev, struct rtw89_core_tx_request *tx_req);
+	void (*tx_kick_off)(struct rtw89_dev *rtwdev, u8 txch);
+	void (*flush_queues)(struct rtw89_dev *rtwdev, u32 queues, bool drop);
+	void (*reset)(struct rtw89_dev *rtwdev);
+	int (*start)(struct rtw89_dev *rtwdev);
+	void (*stop)(struct rtw89_dev *rtwdev);
+	void (*link_ps)(struct rtw89_dev *rtwdev, bool enter);
+
+	u8 (*read8)(struct rtw89_dev *rtwdev, u32 addr);
+	u16 (*read16)(struct rtw89_dev *rtwdev, u32 addr);
+	u32 (*read32)(struct rtw89_dev *rtwdev, u32 addr);
+	void (*write8)(struct rtw89_dev *rtwdev, u32 addr, u8 data);
+	void (*write16)(struct rtw89_dev *rtwdev, u32 addr, u16 data);
+	void (*write32)(struct rtw89_dev *rtwdev, u32 addr, u32 data);
+
+	int (*mac_pre_init)(struct rtw89_dev *rtwdev);
+	int (*mac_post_init)(struct rtw89_dev *rtwdev);
+	int (*deinit)(struct rtw89_dev *rtwdev);
+
+	u32 (*check_and_reclaim_tx_resource)(struct rtw89_dev *rtwdev, u8 txch);
+	int (*mac_lv1_rcvy)(struct rtw89_dev *rtwdev, enum rtw89_lv1_rcvy_step step);
+	void (*dump_err_status)(struct rtw89_dev *rtwdev);
+	int (*napi_poll)(struct napi_struct *napi, int budget);
+};
+
+struct rtw89_hci_info {
+	const struct rtw89_hci_ops *ops;
+	enum rtw89_hci_type type;
+	u32 rpwm_addr;
+	u32 cpwm_addr;
+};
+
+struct rtw89_chip_ops {
+	void (*bb_reset)(struct rtw89_dev *rtwdev,
+			 enum rtw89_phy_idx phy_idx);
+	void (*bb_sethw)(struct rtw89_dev *rtwdev);
+	u32 (*read_rf)(struct rtw89_dev *rtwdev, enum rtw89_rf_path rf_path,
+		       u32 addr, u32 mask);
+	bool (*write_rf)(struct rtw89_dev *rtwdev, enum rtw89_rf_path rf_path,
+			 u32 addr, u32 mask, u32 data);
+	void (*set_channel)(struct rtw89_dev *rtwdev,
+			    struct rtw89_channel_params *param);
+	void (*set_channel_help)(struct rtw89_dev *rtwdev, bool enter,
+				 struct rtw89_channel_help_params *p);
+	int (*read_efuse)(struct rtw89_dev *rtwdev, u8 *log_map);
+	int (*read_phycap)(struct rtw89_dev *rtwdev, u8 *phycap_map);
+	void (*fem_setup)(struct rtw89_dev *rtwdev);
+	void (*rfk_init)(struct rtw89_dev *rtwdev);
+	void (*rfk_channel)(struct rtw89_dev *rtwdev);
+	void (*rfk_band_changed)(struct rtw89_dev *rtwdev);
+	void (*rfk_track)(struct rtw89_dev *rtwdev);
+	void (*power_trim)(struct rtw89_dev *rtwdev);
+	void (*set_txpwr)(struct rtw89_dev *rtwdev);
+	void (*set_txpwr_ctrl)(struct rtw89_dev *rtwdev);
+	int (*init_txpwr_unit)(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx);
+	u8 (*get_thermal)(struct rtw89_dev *rtwdev, enum rtw89_rf_path rf_path);
+	void (*ctrl_btg)(struct rtw89_dev *rtwdev, bool btg);
+	void (*query_ppdu)(struct rtw89_dev *rtwdev,
+			   struct rtw89_rx_phy_ppdu *phy_ppdu,
+			   struct ieee80211_rx_status *status);
+	void (*bb_ctrl_btc_preagc)(struct rtw89_dev *rtwdev, bool bt_en);
+	void (*set_txpwr_ul_tb_offset)(struct rtw89_dev *rtwdev,
+				       s16 pw_ofst, enum rtw89_mac_idx mac_idx);
+
+	void (*btc_set_rfe)(struct rtw89_dev *rtwdev);
+	void (*btc_init_cfg)(struct rtw89_dev *rtwdev);
+	void (*btc_set_wl_pri)(struct rtw89_dev *rtwdev, u8 map, bool state);
+	void (*btc_set_wl_txpwr_ctrl)(struct rtw89_dev *rtwdev, u32 txpwr_val);
+	s8 (*btc_get_bt_rssi)(struct rtw89_dev *rtwdev, s8 val);
+	void (*btc_bt_aci_imp)(struct rtw89_dev *rtwdev);
+	void (*btc_update_bt_cnt)(struct rtw89_dev *rtwdev);
+};
+
+enum rtw89_dma_ch {
+	RTW89_DMA_ACH0 = 0,
+	RTW89_DMA_ACH1 = 1,
+	RTW89_DMA_ACH2 = 2,
+	RTW89_DMA_ACH3 = 3,
+	RTW89_DMA_ACH4 = 4,
+	RTW89_DMA_ACH5 = 5,
+	RTW89_DMA_ACH6 = 6,
+	RTW89_DMA_ACH7 = 7,
+	RTW89_DMA_B0MG = 8,
+	RTW89_DMA_B0HI = 9,
+	RTW89_DMA_B1MG = 10,
+	RTW89_DMA_B1HI = 11,
+	RTW89_DMA_H2C = 12,
+	RTW89_DMA_CH_NUM = 13
+};
+
+enum rtw89_qta_mode {
+	RTW89_QTA_SCC,
+	RTW89_QTA_DBCC,
+	RTW89_QTA_SCC_WD128,
+	RTW89_QTA_DBCC_WD128,
+	RTW89_QTA_SCC_STF,
+	RTW89_QTA_DBCC_STF,
+	RTW89_QTA_SU_TP,
+	RTW89_QTA_DLFW,
+	RTW89_QTA_BCN_TEST,
+	RTW89_QTA_LAMODE,
+
+	/* keep last */
+	RTW89_QTA_INVALID,
+};
+
+struct rtw89_hfc_ch_cfg {
+	u16 min;
+	u16 max;
+#define grp_0 0
+#define grp_1 1
+#define grp_num 2
+	u8 grp;
+};
+
+struct rtw89_hfc_ch_info {
+	u16 aval;
+	u16 used;
+};
+
+struct rtw89_hfc_pub_cfg {
+	u16 grp0;
+	u16 grp1;
+	u16 pub_max;
+	u16 wp_thrd;
+};
+
+struct rtw89_hfc_pub_info {
+	u16 g0_used;
+	u16 g1_used;
+	u16 g0_aval;
+	u16 g1_aval;
+	u16 pub_aval;
+	u16 wp_aval;
+};
+
+struct rtw89_hfc_prec_cfg {
+	u16 ch011_prec;
+	u16 h2c_prec;
+	u16 wp_ch07_prec;
+	u16 wp_ch811_prec;
+	u8 ch011_full_cond;
+	u8 h2c_full_cond;
+	u8 wp_ch07_full_cond;
+	u8 wp_ch811_full_cond;
+};
+
+struct rtw89_hfc_param {
+	bool en;
+	bool h2c_en;
+	u8 mode;
+	struct rtw89_hfc_ch_cfg *ch_cfg;
+	struct rtw89_hfc_ch_info ch_info[RTW89_DMA_CH_NUM];
+	struct rtw89_hfc_pub_cfg *pub_cfg;
+	struct rtw89_hfc_pub_info pub_info;
+	struct rtw89_hfc_prec_cfg *prec_cfg;
+};
+
+struct rtw89_hfc_param_ini {
+	struct rtw89_hfc_ch_cfg *ch_cfg;
+	struct rtw89_hfc_pub_cfg *pub_cfg;
+	struct rtw89_hfc_prec_cfg *prec_cfg;
+	u8 mode;
+};
+
+struct rtw89_dle_size {
+	u16 pge_size;
+	u16 lnk_pge_num;
+	u16 unlnk_pge_num;
+};
+
+struct rtw89_wde_quota {
+	u16 hif;
+	u16 wcpu;
+	u16 pkt_in;
+	u16 cpu_io;
+};
+
+struct rtw89_ple_quota {
+	u16 cma0_tx;
+	u16 cma1_tx;
+	u16 c2h;
+	u16 h2c;
+	u16 wcpu;
+	u16 mpdu_proc;
+	u16 cma0_dma;
+	u16 cma1_dma;
+	u16 bb_rpt;
+	u16 wd_rel;
+	u16 cpu_io;
+};
+
+struct rtw89_dle_mem {
+	enum rtw89_qta_mode mode;
+	struct rtw89_dle_size *wde_size;
+	struct rtw89_dle_size *ple_size;
+	struct rtw89_wde_quota *wde_min_qt;
+	struct rtw89_wde_quota *wde_max_qt;
+	struct rtw89_ple_quota *ple_min_qt;
+	struct rtw89_ple_quota *ple_max_qt;
+};
+
+struct rtw89_reg_def {
+	u32 addr;
+	u32 mask;
+};
+
+struct rtw89_reg2_def {
+	u32 addr;
+	u32 data;
+};
+
+struct rtw89_reg3_def {
+	u32 addr;
+	u32 mask;
+	u32 data;
+};
+
+struct rtw89_reg5_def {
+	u8 flag; /* recognized by parsers */
+	u8 path;
+	u32 addr;
+	u32 mask;
+	u32 data;
+};
+
+struct rtw89_phy_table {
+	const struct rtw89_reg2_def *regs;
+	u32 n_regs;
+	enum rtw89_rf_path rf_path;
+};
+
+struct rtw89_txpwr_table {
+	const void *data;
+	u32 size;
+	void (*load)(struct rtw89_dev *rtwdev,
+		     const struct rtw89_txpwr_table *tbl);
+};
+
+struct rtw89_chip_info {
+	enum rtw89_core_chip_id chip_id;
+	const struct rtw89_chip_ops *ops;
+	const char *fw_name;
+	u32 fifo_size;
+	u32 dle_lamode_size;
+	u16 max_amsdu_limit;
+	struct rtw89_hfc_param_ini *hfc_param_ini;
+	struct rtw89_dle_mem *dle_mem;
+	u32 rf_base_addr[2];
+	u8 rf_path_num;
+	u8 tx_nss;
+	u8 rx_nss;
+	u8 acam_num;
+	u8 bcam_num;
+	u8 scam_num;
+
+	u8 sec_ctrl_efuse_size;
+	u32 physical_efuse_size;
+	u32 logical_efuse_size;
+	u32 limit_efuse_size;
+	u32 phycap_addr;
+	u32 phycap_size;
+
+	const struct rtw89_pwr_cfg * const *pwr_on_seq;
+	const struct rtw89_pwr_cfg * const *pwr_off_seq;
+	const struct rtw89_phy_table *bb_table;
+	const struct rtw89_phy_table *rf_table[RF_PATH_MAX];
+	const struct rtw89_phy_table *nctl_table;
+	const struct rtw89_txpwr_table *byr_table;
+	const struct rtw89_phy_dig_gain_table *dig_table;
+	const s8 (*txpwr_lmt_2g)[RTW89_2G_BW_NUM][RTW89_NTX_NUM]
+				[RTW89_RS_LMT_NUM][RTW89_BF_NUM]
+				[RTW89_REGD_NUM][RTW89_2G_CH_NUM];
+	const s8 (*txpwr_lmt_5g)[RTW89_5G_BW_NUM][RTW89_NTX_NUM]
+				[RTW89_RS_LMT_NUM][RTW89_BF_NUM]
+				[RTW89_REGD_NUM][RTW89_5G_CH_NUM];
+	const s8 (*txpwr_lmt_ru_2g)[RTW89_RU_NUM][RTW89_NTX_NUM]
+				   [RTW89_REGD_NUM][RTW89_2G_CH_NUM];
+	const s8 (*txpwr_lmt_ru_5g)[RTW89_RU_NUM][RTW89_NTX_NUM]
+				   [RTW89_REGD_NUM][RTW89_5G_CH_NUM];
+
+	u8 txpwr_factor_rf;
+	u8 txpwr_factor_mac;
+
+	u32 para_ver;
+	u32 wlcx_desired;
+	u8 btcx_desired;
+	u8 scbd;
+	u8 mailbox;
+
+	u8 afh_guard_ch;
+
+	u8 mon_reg_num;
+	const struct rtw89_btc_fbtc_mreg *mon_reg;
+	u8 rf_para_ulink_num;
+	const struct rtw89_btc_rf_trx_para *rf_para_ulink;
+	u8 rf_para_dlink_num;
+	const struct rtw89_btc_rf_trx_para *rf_para_dlink;
+	u8 ps_mode_supported;
+};
+
+enum rtw89_hcifc_mode {
+	RTW89_HCIFC_POH = 0,
+	RTW89_HCIFC_STF = 1,
+	RTW89_HCIFC_SDIO = 2,
+
+	/* keep last */
+	RTW89_HCIFC_MODE_INVALID,
+};
+
+struct rtw89_dle_info {
+	enum rtw89_qta_mode qta_mode;
+	u16 wde_pg_size;
+	u16 ple_pg_size;
+	u16 c0_rx_qta;
+	u16 c1_rx_qta;
+};
+
+enum rtw89_host_rpr_mode {
+	RTW89_RPR_MODE_POH = 0,
+	RTW89_RPR_MODE_STF
+};
+
+struct rtw89_mac_info {
+	struct rtw89_dle_info dle_info;
+	struct rtw89_hfc_param hfc_param;
+	enum rtw89_qta_mode qta_mode;
+	u8 rpwm_seq_num;
+	u8 cpwm_seq_num;
+};
+
+enum rtw89_fw_type {
+	RTW89_FW_NORMAL = 1,
+	RTW89_FW_WOWLAN = 3,
+};
+
+struct rtw89_fw_suit {
+	const u8 *data;
+	u32 size;
+	u8 major_ver;
+	u8 minor_ver;
+	u8 sub_ver;
+	u8 sub_idex;
+	u16 build_year;
+	u16 build_mon;
+	u16 build_date;
+	u16 build_hour;
+	u16 build_min;
+	u8 cmd_ver;
+};
+
+struct rtw89_fw_info {
+	const struct firmware *firmware;
+	struct rtw89_dev *rtwdev;
+	struct completion completion;
+	u8 h2c_seq;
+	u8 rec_seq;
+	struct rtw89_fw_suit normal;
+	struct rtw89_fw_suit wowlan;
+	bool fw_log_enable;
+};
+
+struct rtw89_cam_info {
+	DECLARE_BITMAP(addr_cam_map, RTW89_MAX_ADDR_CAM_NUM);
+	DECLARE_BITMAP(bssid_cam_map, RTW89_MAX_BSSID_CAM_NUM);
+	DECLARE_BITMAP(sec_cam_map, RTW89_MAX_SEC_CAM_NUM);
+};
+
+enum rtw89_sar_sources {
+	RTW89_SAR_SOURCE_NONE,
+	RTW89_SAR_SOURCE_COMMON,
+
+	RTW89_SAR_SOURCE_NR,
+};
+
+struct rtw89_sar_cfg_common {
+	bool set[RTW89_SUBBAND_NR];
+	s32 cfg[RTW89_SUBBAND_NR];
+};
+
+struct rtw89_sar_info {
+	/* used to decide how to acces SAR cfg union */
+	enum rtw89_sar_sources src;
+
+	/* reserved for different knids of SAR cfg struct.
+	 * supposed that a single cfg struct cannot handle various SAR sources.
+	 */
+	union {
+		struct rtw89_sar_cfg_common cfg_common;
+	};
+};
+
+struct rtw89_hal {
+	u32 rx_fltr;
+	u8 cv;
+	u8 current_channel;
+	u8 current_primary_channel;
+	enum rtw89_subband current_subband;
+	u8 current_band_width;
+	u8 current_band_type;
+	/* center channel for different available bandwidth,
+	 * val of (bw > current_band_width) is invalid
+	 */
+	u8 cch_by_bw[RTW89_MAX_CHANNEL_WIDTH + 1];
+	u32 sw_amsdu_max_size;
+	u32 antenna_tx;
+	u32 antenna_rx;
+};
+
+#define RTW89_MAX_MAC_ID_NUM 128
+
+enum rtw89_flags {
+	RTW89_FLAG_POWERON,
+	RTW89_FLAG_FW_RDY,
+	RTW89_FLAG_RUNNING,
+	RTW89_FLAG_BFEE_MON,
+	RTW89_FLAG_BFEE_EN,
+	RTW89_FLAG_NAPI_RUNNING,
+	RTW89_FLAG_LEISURE_PS,
+	RTW89_FLAG_LOW_POWER_MODE,
+	RTW89_FLAG_INACTIVE_PS,
+
+	NUM_OF_RTW89_FLAGS,
+};
+
+struct rtw89_pkt_stat {
+	u16 beacon_nr;
+	u32 rx_rate_cnt[RTW89_HW_RATE_NR];
+};
+
+DECLARE_EWMA(thermal, 4, 4);
+
+struct rtw89_phy_stat {
+	struct ewma_thermal avg_thermal[RF_PATH_MAX];
+	struct rtw89_pkt_stat cur_pkt_stat;
+	struct rtw89_pkt_stat last_pkt_stat;
+};
+
+#define RTW89_DACK_PATH_NR 2
+#define RTW89_DACK_IDX_NR 2
+#define RTW89_DACK_MSBK_NR 16
+struct rtw89_dack_info {
+	bool dack_done;
+	u8 msbk_d[RTW89_DACK_PATH_NR][RTW89_DACK_IDX_NR][RTW89_DACK_MSBK_NR];
+	u8 dadck_d[RTW89_DACK_PATH_NR][RTW89_DACK_IDX_NR];
+	u16 addck_d[RTW89_DACK_PATH_NR][RTW89_DACK_IDX_NR];
+	u16 biask_d[RTW89_DACK_PATH_NR][RTW89_DACK_IDX_NR];
+	u32 dack_cnt;
+	bool addck_timeout[RTW89_DACK_PATH_NR];
+	bool dadck_timeout[RTW89_DACK_PATH_NR];
+	bool msbk_timeout[RTW89_DACK_PATH_NR];
+};
+
+#define RTW89_IQK_CHS_NR 2
+#define RTW89_IQK_PATH_NR 4
+struct rtw89_iqk_info {
+	bool lok_cor_fail[RTW89_IQK_CHS_NR][RTW89_IQK_PATH_NR];
+	bool lok_fin_fail[RTW89_IQK_CHS_NR][RTW89_IQK_PATH_NR];
+	bool iqk_tx_fail[RTW89_IQK_CHS_NR][RTW89_IQK_PATH_NR];
+	bool iqk_rx_fail[RTW89_IQK_CHS_NR][RTW89_IQK_PATH_NR];
+	u32 iqk_fail_cnt;
+	bool is_iqk_init;
+	u32 iqk_channel[RTW89_IQK_CHS_NR];
+	u8 iqk_band[RTW89_IQK_PATH_NR];
+	u8 iqk_ch[RTW89_IQK_PATH_NR];
+	u8 iqk_bw[RTW89_IQK_PATH_NR];
+	u8 kcount;
+	u8 iqk_times;
+	u8 version;
+	u32 nb_txcfir[RTW89_IQK_PATH_NR];
+	u32 nb_rxcfir[RTW89_IQK_PATH_NR];
+	u32 bp_txkresult[RTW89_IQK_PATH_NR];
+	u32 bp_rxkresult[RTW89_IQK_PATH_NR];
+	u32 bp_iqkenable[RTW89_IQK_PATH_NR];
+	bool is_wb_txiqk[RTW89_IQK_PATH_NR];
+	bool is_wb_rxiqk[RTW89_IQK_PATH_NR];
+	bool is_nbiqk;
+	bool iqk_fft_en;
+	bool iqk_xym_en;
+	bool iqk_sram_en;
+	bool iqk_cfir_en;
+	u8 thermal[RTW89_IQK_PATH_NR];
+	bool thermal_rek_en;
+	u32 syn1to2;
+	u8 iqk_mcc_ch[RTW89_IQK_CHS_NR][RTW89_IQK_PATH_NR];
+	u8 iqk_table_idx[RTW89_IQK_PATH_NR];
+};
+
+#define RTW89_DPK_RF_PATH 2
+#define RTW89_DPK_AVG_THERMAL_NUM 8
+#define RTW89_DPK_BKUP_NUM 2
+struct rtw89_dpk_bkup_para {
+	enum rtw89_band band;
+	enum rtw89_bandwidth bw;
+	u8 ch;
+	bool path_ok;
+	u8 txagc_dpk;
+	u8 ther_dpk;
+	u8 gs;
+	u16 pwsf;
+};
+
+struct rtw89_dpk_info {
+	bool is_dpk_enable;
+	bool is_dpk_reload_en;
+	u16 dc_i[RTW89_DPK_RF_PATH];
+	u16 dc_q[RTW89_DPK_RF_PATH];
+	u8 corr_val[RTW89_DPK_RF_PATH];
+	u8 corr_idx[RTW89_DPK_RF_PATH];
+	u8 cur_idx[RTW89_DPK_RF_PATH];
+	struct rtw89_dpk_bkup_para bp[RTW89_DPK_RF_PATH][RTW89_DPK_BKUP_NUM];
+};
+
+struct rtw89_fem_info {
+	bool elna_2g;
+	bool elna_5g;
+	bool epa_2g;
+	bool epa_5g;
+};
+
+struct rtw89_phy_ch_info {
+	u8 rssi_min;
+	u16 rssi_min_macid;
+	u8 pre_rssi_min;
+	u8 rssi_max;
+	u16 rssi_max_macid;
+	u8 rxsc_160;
+	u8 rxsc_80;
+	u8 rxsc_40;
+	u8 rxsc_20;
+	u8 rxsc_l;
+	u8 is_noisy;
+};
+
+struct rtw89_agc_gaincode_set {
+	u8 lna_idx;
+	u8 tia_idx;
+	u8 rxb_idx;
+};
+
+#define IGI_RSSI_TH_NUM 5
+#define FA_TH_NUM 4
+#define LNA_GAIN_NUM 7
+#define TIA_GAIN_NUM 2
+struct rtw89_dig_info {
+	struct rtw89_agc_gaincode_set cur_gaincode;
+	bool force_gaincode_idx_en;
+	struct rtw89_agc_gaincode_set force_gaincode;
+	u8 igi_rssi_th[IGI_RSSI_TH_NUM];
+	u16 fa_th[FA_TH_NUM];
+	u8 igi_rssi;
+	u8 igi_fa_rssi;
+	u8 fa_rssi_ofst;
+	u8 dyn_igi_max;
+	u8 dyn_igi_min;
+	bool dyn_pd_th_en;
+	u8 dyn_pd_th_max;
+	u8 pd_low_th_ofst;
+	u8 ib_pbk;
+	s8 ib_pkpwr;
+	s8 lna_gain_a[LNA_GAIN_NUM];
+	s8 lna_gain_g[LNA_GAIN_NUM];
+	s8 *lna_gain;
+	s8 tia_gain_a[TIA_GAIN_NUM];
+	s8 tia_gain_g[TIA_GAIN_NUM];
+	s8 *tia_gain;
+	bool is_linked_pre;
+};
+
+enum rtw89_multi_cfo_mode {
+	RTW89_PKT_BASED_AVG_MODE = 0,
+	RTW89_ENTRY_BASED_AVG_MODE = 1,
+	RTW89_TP_BASED_AVG_MODE = 2,
+};
+
+enum rtw89_phy_cfo_status {
+	RTW89_PHY_DCFO_STATE_NORMAL = 0,
+	RTW89_PHY_DCFO_STATE_ENHANCE = 1,
+	RTW89_PHY_DCFO_STATE_MAX
+};
+
+struct rtw89_cfo_tracking_info {
+	u16 cfo_timer_ms;
+	bool cfo_trig_by_timer_en;
+	enum rtw89_phy_cfo_status phy_cfo_status;
+	u8 phy_cfo_trk_cnt;
+	bool is_adjust;
+	enum rtw89_multi_cfo_mode rtw89_multi_cfo_mode;
+	bool apply_compensation;
+	u8 crystal_cap;
+	u8 crystal_cap_default;
+	u8 def_x_cap;
+	s8 x_cap_ofst;
+	u32 sta_cfo_tolerance;
+	s32 cfo_tail[CFO_TRACK_MAX_USER];
+	u16 cfo_cnt[CFO_TRACK_MAX_USER];
+	s32 cfo_avg_pre;
+	s32 cfo_avg[CFO_TRACK_MAX_USER];
+	s32 pre_cfo_avg[CFO_TRACK_MAX_USER];
+	u32 packet_count;
+	u32 packet_count_pre;
+	s32 residual_cfo_acc;
+	u8 phy_cfotrk_state;
+	u8 phy_cfotrk_cnt;
+};
+
+/* 2GL, 2GH, 5GL1, 5GH1, 5GM1, 5GM2, 5GH1, 5GH2 */
+#define TSSI_TRIM_CH_GROUP_NUM 8
+
+#define TSSI_CCK_CH_GROUP_NUM 6
+#define TSSI_MCS_2G_CH_GROUP_NUM 5
+#define TSSI_MCS_5G_CH_GROUP_NUM 14
+#define TSSI_MCS_CH_GROUP_NUM \
+	(TSSI_MCS_2G_CH_GROUP_NUM + TSSI_MCS_5G_CH_GROUP_NUM)
+
+struct rtw89_tssi_info {
+	u8 thermal[RF_PATH_MAX];
+	s8 tssi_trim[RF_PATH_MAX][TSSI_TRIM_CH_GROUP_NUM];
+	s8 tssi_cck[RF_PATH_MAX][TSSI_CCK_CH_GROUP_NUM];
+	s8 tssi_mcs[RF_PATH_MAX][TSSI_MCS_CH_GROUP_NUM];
+	s8 extra_ofst[RF_PATH_MAX];
+	bool tssi_tracking_check[RF_PATH_MAX];
+	u8 default_txagc_offset[RF_PATH_MAX];
+	u32 base_thermal[RF_PATH_MAX];
+};
+
+struct rtw89_power_trim_info {
+	bool pg_thermal_trim;
+	bool pg_pa_bias_trim;
+	u8 thermal_trim[RF_PATH_MAX];
+	u8 pa_bias_trim[RF_PATH_MAX];
+};
+
+struct rtw89_regulatory {
+	char alpha2[3];
+	u8 txpwr_regd[RTW89_BAND_MAX];
+};
+
+enum rtw89_ifs_clm_application {
+	RTW89_IFS_CLM_INIT = 0,
+	RTW89_IFS_CLM_BACKGROUND = 1,
+	RTW89_IFS_CLM_ACS = 2,
+	RTW89_IFS_CLM_DIG = 3,
+	RTW89_IFS_CLM_TDMA_DIG = 4,
+	RTW89_IFS_CLM_DBG = 5,
+	RTW89_IFS_CLM_DBG_MANUAL = 6
+};
+
+enum rtw89_env_racing_lv {
+	RTW89_RAC_RELEASE = 0,
+	RTW89_RAC_LV_1 = 1,
+	RTW89_RAC_LV_2 = 2,
+	RTW89_RAC_LV_3 = 3,
+	RTW89_RAC_LV_4 = 4,
+	RTW89_RAC_MAX_NUM = 5
+};
+
+struct rtw89_ccx_para_info {
+	enum rtw89_env_racing_lv rac_lv;
+	u16 mntr_time;
+	u8 nhm_manual_th_ofst;
+	u8 nhm_manual_th0;
+	enum rtw89_ifs_clm_application ifs_clm_app;
+	u32 ifs_clm_manual_th_times;
+	u32 ifs_clm_manual_th0;
+	u8 fahm_manual_th_ofst;
+	u8 fahm_manual_th0;
+	u8 fahm_numer_opt;
+	u8 fahm_denom_opt;
+};
+
+enum rtw89_ccx_edcca_opt_sc_idx {
+	RTW89_CCX_EDCCA_SEG0_P0 = 0,
+	RTW89_CCX_EDCCA_SEG0_S1 = 1,
+	RTW89_CCX_EDCCA_SEG0_S2 = 2,
+	RTW89_CCX_EDCCA_SEG0_S3 = 3,
+	RTW89_CCX_EDCCA_SEG1_P0 = 4,
+	RTW89_CCX_EDCCA_SEG1_S1 = 5,
+	RTW89_CCX_EDCCA_SEG1_S2 = 6,
+	RTW89_CCX_EDCCA_SEG1_S3 = 7
+};
+
+enum rtw89_ccx_edcca_opt_bw_idx {
+	RTW89_CCX_EDCCA_BW20_0 = 0,
+	RTW89_CCX_EDCCA_BW20_1 = 1,
+	RTW89_CCX_EDCCA_BW20_2 = 2,
+	RTW89_CCX_EDCCA_BW20_3 = 3,
+	RTW89_CCX_EDCCA_BW20_4 = 4,
+	RTW89_CCX_EDCCA_BW20_5 = 5,
+	RTW89_CCX_EDCCA_BW20_6 = 6,
+	RTW89_CCX_EDCCA_BW20_7 = 7
+};
+
+#define RTW89_NHM_TH_NUM 11
+#define RTW89_FAHM_TH_NUM 11
+#define RTW89_NHM_RPT_NUM 12
+#define RTW89_FAHM_RPT_NUM 12
+#define RTW89_IFS_CLM_NUM 4
+struct rtw89_env_monitor_info {
+	u32 ccx_trigger_time;
+	u64 start_time;
+	u8 ccx_rpt_stamp;
+	u8 ccx_watchdog_result;
+	bool ccx_ongoing;
+	u8 ccx_rac_lv;
+	bool ccx_manual_ctrl;
+	u8 ccx_pre_rssi;
+	u16 clm_mntr_time;
+	u16 nhm_mntr_time;
+	u16 ifs_clm_mntr_time;
+	enum rtw89_ifs_clm_application ifs_clm_app;
+	u16 fahm_mntr_time;
+	u16 edcca_clm_mntr_time;
+	u16 ccx_period;
+	u8 ccx_unit_idx;
+	enum rtw89_ccx_edcca_opt_bw_idx ccx_edcca_opt_bw_idx;
+	u8 nhm_th[RTW89_NHM_TH_NUM];
+	u16 ifs_clm_th_l[RTW89_IFS_CLM_NUM];
+	u16 ifs_clm_th_h[RTW89_IFS_CLM_NUM];
+	u8 fahm_numer_opt;
+	u8 fahm_denom_opt;
+	u8 fahm_th[RTW89_FAHM_TH_NUM];
+	u16 clm_result;
+	u16 nhm_result[RTW89_NHM_RPT_NUM];
+	u8 nhm_wgt[RTW89_NHM_RPT_NUM];
+	u16 nhm_tx_cnt;
+	u16 nhm_cca_cnt;
+	u16 nhm_idle_cnt;
+	u16 ifs_clm_tx;
+	u16 ifs_clm_edcca_excl_cca;
+	u16 ifs_clm_ofdmfa;
+	u16 ifs_clm_ofdmcca_excl_fa;
+	u16 ifs_clm_cckfa;
+	u16 ifs_clm_cckcca_excl_fa;
+	u16 ifs_clm_total_ifs;
+	u8 ifs_clm_his[RTW89_IFS_CLM_NUM];
+	u16 ifs_clm_avg[RTW89_IFS_CLM_NUM];
+	u16 ifs_clm_cca[RTW89_IFS_CLM_NUM];
+	u16 fahm_result[RTW89_FAHM_RPT_NUM];
+	u16 fahm_denom_result;
+	u16 edcca_clm_result;
+	u8 clm_ratio;
+	u8 nhm_rpt[RTW89_NHM_RPT_NUM];
+	u8 nhm_tx_ratio;
+	u8 nhm_cca_ratio;
+	u8 nhm_idle_ratio;
+	u8 nhm_ratio;
+	u16 nhm_result_sum;
+	u8 nhm_pwr;
+	u8 ifs_clm_tx_ratio;
+	u8 ifs_clm_edcca_excl_cca_ratio;
+	u8 ifs_clm_cck_fa_ratio;
+	u8 ifs_clm_ofdm_fa_ratio;
+	u8 ifs_clm_cck_cca_excl_fa_ratio;
+	u8 ifs_clm_ofdm_cca_excl_fa_ratio;
+	u16 ifs_clm_cck_fa_permil;
+	u16 ifs_clm_ofdm_fa_permil;
+	u32 ifs_clm_ifs_avg[RTW89_IFS_CLM_NUM];
+	u32 ifs_clm_cca_avg[RTW89_IFS_CLM_NUM];
+	u8 fahm_rpt[RTW89_FAHM_RPT_NUM];
+	u16 fahm_result_sum;
+	u8 fahm_ratio;
+	u8 fahm_denom_ratio;
+	u8 fahm_pwr;
+	u8 edcca_clm_ratio;
+};
+
+enum rtw89_ser_rcvy_step {
+	RTW89_SER_DRV_STOP_TX,
+	RTW89_SER_DRV_STOP_RX,
+	RTW89_SER_DRV_STOP_RUN,
+	RTW89_SER_HAL_STOP_DMA,
+	RTW89_NUM_OF_SER_FLAGS
+};
+
+struct rtw89_ser {
+	u8 state;
+	u8 alarm_event;
+
+	struct work_struct ser_hdl_work;
+	struct delayed_work ser_alarm_work;
+	struct state_ent *st_tbl;
+	struct event_ent *ev_tbl;
+	struct list_head msg_q;
+	spinlock_t msg_q_lock; /* lock when read/write ser msg */
+	DECLARE_BITMAP(flags, RTW89_NUM_OF_SER_FLAGS);
+};
+
+enum rtw89_mac_ax_ps_mode {
+	RTW89_MAC_AX_PS_MODE_ACTIVE = 0,
+	RTW89_MAC_AX_PS_MODE_LEGACY = 1,
+	RTW89_MAC_AX_PS_MODE_WMMPS  = 2,
+	RTW89_MAC_AX_PS_MODE_MAX    = 3,
+};
+
+enum rtw89_last_rpwm_mode {
+	RTW89_LAST_RPWM_PS        = 0x0,
+	RTW89_LAST_RPWM_ACTIVE    = 0x6,
+};
+
+struct rtw89_lps_parm {
+	u8 macid;
+	u8 psmode; /* enum rtw89_mac_ax_ps_mode */
+	u8 lastrpwm; /* enum rtw89_last_rpwm_mode */
+};
+
+struct rtw89_ppdu_sts_info {
+	struct sk_buff_head rx_queue[RTW89_PHY_MAX];
+	u8 curr_rx_ppdu_cnt[RTW89_PHY_MAX];
+};
+
+struct rtw89_dev {
+	struct ieee80211_hw *hw;
+	struct device *dev;
+
+	bool dbcc_en;
+	const struct rtw89_chip_info *chip;
+	struct rtw89_hal hal;
+	struct rtw89_mac_info mac;
+	struct rtw89_fw_info fw;
+	struct rtw89_hci_info hci;
+	struct rtw89_efuse efuse;
+	struct rtw89_traffic_stats stats;
+
+	/* ensures exclusive access from mac80211 callbacks */
+	struct mutex mutex;
+	/* used to protect rf read write */
+	struct mutex rf_mutex;
+	struct workqueue_struct *txq_wq;
+	struct work_struct txq_work;
+	struct delayed_work txq_reinvoke_work;
+	/* used to protect ba_list */
+	spinlock_t ba_lock;
+	/* txqs to setup ba session */
+	struct list_head ba_list;
+	struct work_struct ba_work;
+
+	struct rtw89_cam_info cam_info;
+
+	struct sk_buff_head c2h_queue;
+	struct work_struct c2h_work;
+
+	struct rtw89_ser ser;
+
+	DECLARE_BITMAP(hw_port, RTW89_MAX_HW_PORT_NUM);
+	DECLARE_BITMAP(mac_id_map, RTW89_MAX_MAC_ID_NUM);
+	DECLARE_BITMAP(flags, NUM_OF_RTW89_FLAGS);
+
+	struct rtw89_phy_stat phystat;
+	struct rtw89_dack_info dack;
+	struct rtw89_iqk_info iqk;
+	struct rtw89_dpk_info dpk;
+	bool is_tssi_mode[RF_PATH_MAX];
+	bool is_bt_iqk_timeout;
+
+	struct rtw89_fem_info fem;
+	struct rtw89_txpwr_byrate byr[RTW89_BAND_MAX];
+	struct rtw89_tssi_info tssi;
+	struct rtw89_power_trim_info pwr_trim;
+
+	struct rtw89_cfo_tracking_info cfo_tracking;
+	struct rtw89_env_monitor_info env_monitor;
+	struct rtw89_dig_info dig;
+	struct rtw89_phy_ch_info ch_info;
+	struct delayed_work track_work;
+	struct delayed_work coex_act1_work;
+	struct delayed_work cfo_track_work;
+	struct rtw89_ppdu_sts_info ppdu_sts;
+	u8 total_sta_assoc;
+	bool scanning;
+
+	const struct rtw89_regulatory *regd;
+	struct rtw89_sar_info sar;
+
+	struct rtw89_btc btc;
+	enum rtw89_ps_mode ps_mode;
+	bool lps_enabled;
+
+	/* napi structure */
+	struct net_device netdev;
+	struct napi_struct napi;
+	int napi_budget_countdown;
+
+	/* HCI related data, keep last */
+	u8 priv[0] __aligned(sizeof(void *));
+};
+
+static inline int rtw89_hci_tx_write(struct rtw89_dev *rtwdev,
+				     struct rtw89_core_tx_request *tx_req)
+{
+	return rtwdev->hci.ops->tx_write(rtwdev, tx_req);
+}
+
+static inline void rtw89_hci_reset(struct rtw89_dev *rtwdev)
+{
+	rtwdev->hci.ops->reset(rtwdev);
+}
+
+static inline int rtw89_hci_start(struct rtw89_dev *rtwdev)
+{
+	return rtwdev->hci.ops->start(rtwdev);
+}
+
+static inline void rtw89_hci_stop(struct rtw89_dev *rtwdev)
+{
+	rtwdev->hci.ops->stop(rtwdev);
+}
+
+static inline int rtw89_hci_deinit(struct rtw89_dev *rtwdev)
+{
+	return rtwdev->hci.ops->deinit(rtwdev);
+}
+
+static inline void rtw89_hci_link_ps(struct rtw89_dev *rtwdev, bool enter)
+{
+	rtwdev->hci.ops->link_ps(rtwdev, enter);
+}
+
+static inline u32 rtw89_hci_check_and_reclaim_tx_resource(struct rtw89_dev *rtwdev, u8 txch)
+{
+	return rtwdev->hci.ops->check_and_reclaim_tx_resource(rtwdev, txch);
+}
+
+static inline void rtw89_hci_tx_kick_off(struct rtw89_dev *rtwdev, u8 txch)
+{
+	return rtwdev->hci.ops->tx_kick_off(rtwdev, txch);
+}
+
+static inline void rtw89_hci_flush_queues(struct rtw89_dev *rtwdev, u32 queues,
+					  bool drop)
+{
+	if (rtwdev->hci.ops->flush_queues)
+		return rtwdev->hci.ops->flush_queues(rtwdev, queues, drop);
+}
+
+static inline u8 rtw89_read8(struct rtw89_dev *rtwdev, u32 addr)
+{
+	return rtwdev->hci.ops->read8(rtwdev, addr);
+}
+
+static inline u16 rtw89_read16(struct rtw89_dev *rtwdev, u32 addr)
+{
+	return rtwdev->hci.ops->read16(rtwdev, addr);
+}
+
+static inline u32 rtw89_read32(struct rtw89_dev *rtwdev, u32 addr)
+{
+	return rtwdev->hci.ops->read32(rtwdev, addr);
+}
+
+static inline void rtw89_write8(struct rtw89_dev *rtwdev, u32 addr, u8 data)
+{
+	rtwdev->hci.ops->write8(rtwdev, addr, data);
+}
+
+static inline void rtw89_write16(struct rtw89_dev *rtwdev, u32 addr, u16 data)
+{
+	rtwdev->hci.ops->write16(rtwdev, addr, data);
+}
+
+static inline void rtw89_write32(struct rtw89_dev *rtwdev, u32 addr, u32 data)
+{
+	rtwdev->hci.ops->write32(rtwdev, addr, data);
+}
+
+static inline void
+rtw89_write8_set(struct rtw89_dev *rtwdev, u32 addr, u8 bit)
+{
+	u8 val;
+
+	val = rtw89_read8(rtwdev, addr);
+	rtw89_write8(rtwdev, addr, val | bit);
+}
+
+static inline void
+rtw89_write16_set(struct rtw89_dev *rtwdev, u32 addr, u16 bit)
+{
+	u16 val;
+
+	val = rtw89_read16(rtwdev, addr);
+	rtw89_write16(rtwdev, addr, val | bit);
+}
+
+static inline void
+rtw89_write32_set(struct rtw89_dev *rtwdev, u32 addr, u32 bit)
+{
+	u32 val;
+
+	val = rtw89_read32(rtwdev, addr);
+	rtw89_write32(rtwdev, addr, val | bit);
+}
+
+static inline void
+rtw89_write8_clr(struct rtw89_dev *rtwdev, u32 addr, u8 bit)
+{
+	u8 val;
+
+	val = rtw89_read8(rtwdev, addr);
+	rtw89_write8(rtwdev, addr, val & ~bit);
+}
+
+static inline void
+rtw89_write16_clr(struct rtw89_dev *rtwdev, u32 addr, u16 bit)
+{
+	u16 val;
+
+	val = rtw89_read16(rtwdev, addr);
+	rtw89_write16(rtwdev, addr, val & ~bit);
+}
+
+static inline void
+rtw89_write32_clr(struct rtw89_dev *rtwdev, u32 addr, u32 bit)
+{
+	u32 val;
+
+	val = rtw89_read32(rtwdev, addr);
+	rtw89_write32(rtwdev, addr, val & ~bit);
+}
+
+static inline u32
+rtw89_read32_mask(struct rtw89_dev *rtwdev, u32 addr, u32 mask)
+{
+	u32 shift = __ffs(mask);
+	u32 orig;
+	u32 ret;
+
+	orig = rtw89_read32(rtwdev, addr);
+	ret = (orig & mask) >> shift;
+
+	return ret;
+}
+
+static inline u16
+rtw89_read16_mask(struct rtw89_dev *rtwdev, u32 addr, u32 mask)
+{
+	u32 shift = __ffs(mask);
+	u32 orig;
+	u32 ret;
+
+	orig = rtw89_read16(rtwdev, addr);
+	ret = (orig & mask) >> shift;
+
+	return ret;
+}
+
+static inline u8
+rtw89_read8_mask(struct rtw89_dev *rtwdev, u32 addr, u32 mask)
+{
+	u32 shift = __ffs(mask);
+	u32 orig;
+	u32 ret;
+
+	orig = rtw89_read8(rtwdev, addr);
+	ret = (orig & mask) >> shift;
+
+	return ret;
+}
+
+static inline void
+rtw89_write32_mask(struct rtw89_dev *rtwdev, u32 addr, u32 mask, u32 data)
+{
+	u32 shift = __ffs(mask);
+	u32 orig;
+	u32 set;
+
+	WARN(addr & 0x3, "should be 4-byte aligned, addr = 0x%08x\n", addr);
+
+	orig = rtw89_read32(rtwdev, addr);
+	set = (orig & ~mask) | ((data << shift) & mask);
+	rtw89_write32(rtwdev, addr, set);
+}
+
+static inline void
+rtw89_write16_mask(struct rtw89_dev *rtwdev, u32 addr, u32 mask, u16 data)
+{
+	u32 shift;
+	u16 orig, set;
+
+	mask &= 0xffff;
+	shift = __ffs(mask);
+
+	orig = rtw89_read16(rtwdev, addr);
+	set = (orig & ~mask) | ((data << shift) & mask);
+	rtw89_write16(rtwdev, addr, set);
+}
+
+static inline void
+rtw89_write8_mask(struct rtw89_dev *rtwdev, u32 addr, u32 mask, u8 data)
+{
+	u32 shift;
+	u8 orig, set;
+
+	mask &= 0xff;
+	shift = __ffs(mask);
+
+	orig = rtw89_read8(rtwdev, addr);
+	set = (orig & ~mask) | ((data << shift) & mask);
+	rtw89_write8(rtwdev, addr, set);
+}
+
+static inline u32
+rtw89_read_rf(struct rtw89_dev *rtwdev, enum rtw89_rf_path rf_path,
+	      u32 addr, u32 mask)
+{
+	u32 val;
+
+	mutex_lock(&rtwdev->rf_mutex);
+	val = rtwdev->chip->ops->read_rf(rtwdev, rf_path, addr, mask);
+	mutex_unlock(&rtwdev->rf_mutex);
+
+	return val;
+}
+
+static inline void
+rtw89_write_rf(struct rtw89_dev *rtwdev, enum rtw89_rf_path rf_path,
+	       u32 addr, u32 mask, u32 data)
+{
+	mutex_lock(&rtwdev->rf_mutex);
+	rtwdev->chip->ops->write_rf(rtwdev, rf_path, addr, mask, data);
+	mutex_unlock(&rtwdev->rf_mutex);
+}
+
+static inline struct ieee80211_txq *rtw89_txq_to_txq(struct rtw89_txq *rtwtxq)
+{
+	void *p = rtwtxq;
+
+	return container_of(p, struct ieee80211_txq, drv_priv);
+}
+
+static inline void rtw89_core_txq_init(struct rtw89_dev *rtwdev,
+				       struct ieee80211_txq *txq)
+{
+	struct rtw89_txq *rtwtxq;
+
+	if (!txq)
+		return;
+
+	rtwtxq = (struct rtw89_txq *)txq->drv_priv;
+	INIT_LIST_HEAD(&rtwtxq->list);
+}
+
+static inline struct ieee80211_vif *rtwvif_to_vif(struct rtw89_vif *rtwvif)
+{
+	void *p = rtwvif;
+
+	return container_of(p, struct ieee80211_vif, drv_priv);
+}
+
+static inline struct ieee80211_sta *rtwsta_to_sta(struct rtw89_sta *rtwsta)
+{
+	void *p = rtwsta;
+
+	return container_of(p, struct ieee80211_sta, drv_priv);
+}
+
+static inline
+void rtw89_chip_set_channel_prepare(struct rtw89_dev *rtwdev,
+				    struct rtw89_channel_help_params *p)
+{
+	rtwdev->chip->ops->set_channel_help(rtwdev, true, p);
+}
+
+static inline
+void rtw89_chip_set_channel_done(struct rtw89_dev *rtwdev,
+				 struct rtw89_channel_help_params *p)
+{
+	rtwdev->chip->ops->set_channel_help(rtwdev, false, p);
+}
+
+static inline void rtw89_chip_fem_setup(struct rtw89_dev *rtwdev)
+{
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+
+	if (chip->ops->fem_setup)
+		chip->ops->fem_setup(rtwdev);
+}
+
+static inline void rtw89_chip_bb_sethw(struct rtw89_dev *rtwdev)
+{
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+
+	if (chip->ops->bb_sethw)
+		chip->ops->bb_sethw(rtwdev);
+}
+
+static inline void rtw89_chip_rfk_init(struct rtw89_dev *rtwdev)
+{
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+
+	if (chip->ops->rfk_init)
+		chip->ops->rfk_init(rtwdev);
+}
+
+static inline void rtw89_chip_rfk_channel(struct rtw89_dev *rtwdev)
+{
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+
+	if (chip->ops->rfk_channel)
+		chip->ops->rfk_channel(rtwdev);
+}
+
+static inline void rtw89_chip_rfk_band_changed(struct rtw89_dev *rtwdev)
+{
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+
+	if (chip->ops->rfk_band_changed)
+		chip->ops->rfk_band_changed(rtwdev);
+}
+
+static inline void rtw89_chip_rfk_track(struct rtw89_dev *rtwdev)
+{
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+
+	if (chip->ops->rfk_track)
+		chip->ops->rfk_track(rtwdev);
+}
+
+static inline void rtw89_chip_set_txpwr_ctrl(struct rtw89_dev *rtwdev)
+{
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+
+	if (chip->ops->set_txpwr_ctrl)
+		chip->ops->set_txpwr_ctrl(rtwdev);
+}
+
+static inline void rtw89_chip_set_txpwr(struct rtw89_dev *rtwdev)
+{
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+	u8 ch = rtwdev->hal.current_channel;
+
+	if (!ch)
+		return;
+
+	if (chip->ops->set_txpwr)
+		chip->ops->set_txpwr(rtwdev);
+}
+
+static inline void rtw89_chip_power_trim(struct rtw89_dev *rtwdev)
+{
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+
+	if (chip->ops->power_trim)
+		chip->ops->power_trim(rtwdev);
+}
+
+static inline void rtw89_chip_init_txpwr_unit(struct rtw89_dev *rtwdev,
+					      enum rtw89_phy_idx phy_idx)
+{
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+
+	if (chip->ops->init_txpwr_unit)
+		chip->ops->init_txpwr_unit(rtwdev, phy_idx);
+}
+
+static inline u8 rtw89_chip_get_thermal(struct rtw89_dev *rtwdev,
+					enum rtw89_rf_path rf_path)
+{
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+
+	if (!chip->ops->get_thermal)
+		return 0x10;
+
+	return chip->ops->get_thermal(rtwdev, rf_path);
+}
+
+static inline void rtw89_chip_query_ppdu(struct rtw89_dev *rtwdev,
+					 struct rtw89_rx_phy_ppdu *phy_ppdu,
+					 struct ieee80211_rx_status *status)
+{
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+
+	if (chip->ops->query_ppdu)
+		chip->ops->query_ppdu(rtwdev, phy_ppdu, status);
+}
+
+static inline void rtw89_chip_bb_ctrl_btc_preagc(struct rtw89_dev *rtwdev,
+						 bool bt_en)
+{
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+
+	if (chip->ops->bb_ctrl_btc_preagc)
+		chip->ops->bb_ctrl_btc_preagc(rtwdev, bt_en);
+}
+
+static inline
+void rtw89_chip_cfg_txpwr_ul_tb_offset(struct rtw89_dev *rtwdev,
+				       struct ieee80211_vif *vif)
+{
+	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+
+	if (!vif->bss_conf.he_support || !vif->bss_conf.assoc)
+		return;
+
+	if (chip->ops->set_txpwr_ul_tb_offset)
+		chip->ops->set_txpwr_ul_tb_offset(rtwdev, 0, rtwvif->mac_idx);
+}
+
+static inline void rtw89_load_txpwr_table(struct rtw89_dev *rtwdev,
+					  const struct rtw89_txpwr_table *tbl)
+{
+	tbl->load(rtwdev, tbl);
+}
+
+static inline u8 rtw89_regd_get(struct rtw89_dev *rtwdev, u8 band)
+{
+	return rtwdev->regd->txpwr_regd[band];
+}
+
+static inline void rtw89_ctrl_btg(struct rtw89_dev *rtwdev, bool btg)
+{
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+
+	if (chip->ops->ctrl_btg)
+		chip->ops->ctrl_btg(rtwdev, btg);
+}
+
+static inline u8 *get_hdr_bssid(struct ieee80211_hdr *hdr)
+{
+	__le16 fc = hdr->frame_control;
+
+	if (ieee80211_has_tods(fc))
+		return hdr->addr1;
+	else if (ieee80211_has_fromds(fc))
+		return hdr->addr2;
+	else
+		return hdr->addr3;
+}
+
+static inline bool rtw89_sta_has_beamformer_cap(struct ieee80211_sta *sta)
+{
+	if ((sta->vht_cap.cap & IEEE80211_VHT_CAP_MU_BEAMFORMER_CAPABLE) ||
+	    (sta->vht_cap.cap & IEEE80211_VHT_CAP_SU_BEAMFORMER_CAPABLE) ||
+	    (sta->he_cap.he_cap_elem.phy_cap_info[3] & IEEE80211_HE_PHY_CAP3_SU_BEAMFORMER) ||
+	    (sta->he_cap.he_cap_elem.phy_cap_info[4] & IEEE80211_HE_PHY_CAP4_MU_BEAMFORMER))
+		return true;
+	return false;
+}
+
+static inline struct rtw89_fw_suit *rtw89_fw_suit_get(struct rtw89_dev *rtwdev,
+						      enum rtw89_fw_type type)
+{
+	struct rtw89_fw_info *fw_info = &rtwdev->fw;
+
+	if (type == RTW89_FW_WOWLAN)
+		return &fw_info->wowlan;
+	return &fw_info->normal;
+}
+
+int rtw89_core_tx_write(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif,
+			struct ieee80211_sta *sta, struct sk_buff *skb, int *qsel);
+int rtw89_h2c_tx(struct rtw89_dev *rtwdev,
+		 struct sk_buff *skb, bool fwdl);
+void rtw89_core_tx_kick_off(struct rtw89_dev *rtwdev, u8 qsel);
+void rtw89_core_fill_txdesc(struct rtw89_dev *rtwdev,
+			    struct rtw89_tx_desc_info *desc_info,
+			    void *txdesc);
+void rtw89_core_rx(struct rtw89_dev *rtwdev,
+		   struct rtw89_rx_desc_info *desc_info,
+		   struct sk_buff *skb);
+void rtw89_core_query_rxdesc(struct rtw89_dev *rtwdev,
+			     struct rtw89_rx_desc_info *desc_info,
+			     u8 *data, u32 data_offset);
+void rtw89_core_napi_start(struct rtw89_dev *rtwdev);
+void rtw89_core_napi_stop(struct rtw89_dev *rtwdev);
+void rtw89_core_napi_init(struct rtw89_dev *rtwdev);
+void rtw89_core_napi_deinit(struct rtw89_dev *rtwdev);
+int rtw89_core_power_on(struct rtw89_dev *rtwdev);
+int rtw89_core_sta_add(struct rtw89_dev *rtwdev,
+		       struct ieee80211_vif *vif,
+		       struct ieee80211_sta *sta);
+int rtw89_core_sta_assoc(struct rtw89_dev *rtwdev,
+			 struct ieee80211_vif *vif,
+			 struct ieee80211_sta *sta);
+int rtw89_core_sta_disassoc(struct rtw89_dev *rtwdev,
+			    struct ieee80211_vif *vif,
+			    struct ieee80211_sta *sta);
+int rtw89_core_sta_disconnect(struct rtw89_dev *rtwdev,
+			      struct ieee80211_vif *vif,
+			      struct ieee80211_sta *sta);
+int rtw89_core_sta_remove(struct rtw89_dev *rtwdev,
+			  struct ieee80211_vif *vif,
+			  struct ieee80211_sta *sta);
+int rtw89_core_init(struct rtw89_dev *rtwdev);
+void rtw89_core_deinit(struct rtw89_dev *rtwdev);
+int rtw89_core_register(struct rtw89_dev *rtwdev);
+void rtw89_core_unregister(struct rtw89_dev *rtwdev);
+void rtw89_set_channel(struct rtw89_dev *rtwdev);
+u8 rtw89_core_acquire_bit_map(unsigned long *addr, unsigned long size);
+void rtw89_core_release_bit_map(unsigned long *addr, u8 bit);
+void rtw89_core_release_all_bits_map(unsigned long *addr, unsigned int nbits);
+void rtw89_vif_type_mapping(struct ieee80211_vif *vif, bool assoc);
+int rtw89_chip_info_setup(struct rtw89_dev *rtwdev);
+u16 rtw89_ra_report_to_bitrate(struct rtw89_dev *rtwdev, u8 rpt_rate);
+int rtw89_regd_init(struct rtw89_dev *rtwdev,
+		    void (*reg_notifier)(struct wiphy *wiphy, struct regulatory_request *request));
+void rtw89_regd_notifier(struct wiphy *wiphy, struct regulatory_request *request);
+void rtw89_traffic_stats_init(struct rtw89_dev *rtwdev,
+			      struct rtw89_traffic_stats *stats);
+int rtw89_core_start(struct rtw89_dev *rtwdev);
+void rtw89_core_stop(struct rtw89_dev *rtwdev);
+
+#endif
diff --git a/drivers/net/wireless/realtek/rtw89/txrx.h b/drivers/net/wireless/realtek/rtw89/txrx.h
new file mode 100644
index 000000000000..0dc99cbc6761
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtw89/txrx.h
@@ -0,0 +1,393 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/* Copyright(c) 2020  Realtek Corporation
+ */
+
+#ifndef __RTW89_TXRX_H__
+#define __RTW89_TXRX_H__
+
+#include "debug.h"
+
+#define DATA_RATE_MODE_CTRL_MASK	GENMASK(8, 7)
+#define DATA_RATE_NOT_HT_IDX_MASK	GENMASK(3, 0)
+#define DATA_RATE_MODE_NON_HT		0x0
+#define DATA_RATE_HT_IDX_MASK		GENMASK(4, 0)
+#define DATA_RATE_MODE_HT		0x1
+#define DATA_RATE_VHT_HE_NSS_MASK	GENMASK(6, 4)
+#define DATA_RATE_VHT_HE_IDX_MASK	GENMASK(3, 0)
+#define DATA_RATE_MODE_VHT		0x2
+#define DATA_RATE_MODE_HE		0x3
+#define GET_DATA_RATE_MODE(r)		FIELD_GET(DATA_RATE_MODE_CTRL_MASK, r)
+#define GET_DATA_RATE_NOT_HT_IDX(r)	FIELD_GET(DATA_RATE_NOT_HT_IDX_MASK, r)
+#define GET_DATA_RATE_HT_IDX(r)		FIELD_GET(DATA_RATE_HT_IDX_MASK, r)
+#define GET_DATA_RATE_VHT_HE_IDX(r)	FIELD_GET(DATA_RATE_VHT_HE_IDX_MASK, r)
+#define GET_DATA_RATE_NSS(r)		FIELD_GET(DATA_RATE_VHT_HE_NSS_MASK, r)
+
+/* TX WD BODY DWORD 0 */
+#define RTW89_SET_TXWD_BODY_WP_OFFSET(txdesc, val) \
+	RTW89_SET_TXWD(txdesc, val, 0x00, GENMASK(31, 24))
+#define RTW89_SET_TXWD_BODY_MORE_DATA(txdesc, val) \
+	RTW89_SET_TXWD(txdesc, val, 0x00, BIT(23))
+#define RTW89_SET_TXWD_BODY_WD_INFO_EN(txdesc, val) \
+	RTW89_SET_TXWD(txdesc, val, 0x00, BIT(22))
+#define RTW89_SET_TXWD_BODY_FW_DL(txdesc, val) \
+	RTW89_SET_TXWD(txdesc, val, 0x00, BIT(20))
+#define RTW89_SET_TXWD_BODY_CHANNEL_DMA(txdesc, val) \
+	RTW89_SET_TXWD(txdesc, val, 0x00, GENMASK(19, 16))
+#define RTW89_SET_TXWD_BODY_HDR_LLC_LEN(txdesc, val) \
+	RTW89_SET_TXWD(txdesc, val, 0x00, GENMASK(15, 11))
+#define RTW89_SET_TXWD_BODY_WD_PAGE(txdesc, val) \
+	RTW89_SET_TXWD(txdesc, val, 0x00, BIT(7))
+#define RTW89_SET_TXWD_BODY_HW_AMSDU(txdesc, val) \
+	RTW89_SET_TXWD(txdesc, val, 0x00, BIT(5))
+
+/* TX WD BODY DWORD 1 */
+#define RTW89_SET_TXWD_BODY_PAYLOAD_ID(txdesc, val) \
+	RTW89_SET_TXWD(txdesc, val, 0x01, GENMASK(31, 16))
+
+/* TX WD BODY DWORD 2 */
+#define RTW89_SET_TXWD_BODY_MACID(txdesc, val) \
+	RTW89_SET_TXWD(txdesc, val, 0x02, GENMASK(30, 24))
+#define RTW89_SET_TXWD_BODY_TID_INDICATE(txdesc, val) \
+	RTW89_SET_TXWD(txdesc, val, 0x02, BIT(23))
+#define RTW89_SET_TXWD_BODY_QSEL(txdesc, val) \
+	RTW89_SET_TXWD(txdesc, val, 0x02, GENMASK(22, 17))
+#define RTW89_SET_TXWD_BODY_TXPKT_SIZE(txdesc, val) \
+	RTW89_SET_TXWD(txdesc, val, 0x02, GENMASK(13, 0))
+
+/* TX WD BODY DWORD 3 */
+#define RTW89_SET_TXWD_BODY_BK(txdesc, val) \
+	RTW89_SET_TXWD(txdesc, val, 0x03, BIT(13))
+#define RTW89_SET_TXWD_BODY_AGG_EN(txdesc, val) \
+	RTW89_SET_TXWD(txdesc, val, 0x03, BIT(12))
+#define RTW89_SET_TXWD_BODY_SW_SEQ(txdesc, val) \
+	RTW89_SET_TXWD(txdesc, val, 0x03, GENMASK(11, 0))
+
+/* TX WD BODY DWORD 4 */
+
+/* TX WD BODY DWORD 5 */
+
+/* TX WD INFO DWORD 0 */
+#define RTW89_SET_TXWD_INFO_USE_RATE(txdesc, val) \
+	RTW89_SET_TXWD(txdesc, val, 0x6, BIT(30))
+#define RTW89_SET_TXWD_INFO_DATA_BW(txdesc, val) \
+	RTW89_SET_TXWD(txdesc, val, 0x6, GENMASK(29, 28))
+#define RTW89_SET_TXWD_INFO_GI_LTF(txdesc, val) \
+	RTW89_SET_TXWD(txdesc, val, 0x6, GENMASK(27, 25))
+#define RTW89_SET_TXWD_INFO_DATA_RATE(txdesc, val) \
+	RTW89_SET_TXWD(txdesc, val, 0x6, GENMASK(24, 16))
+#define RTW89_SET_TXWD_INFO_DISDATAFB(txdesc, val) \
+	RTW89_SET_TXWD(txdesc, val, 0x6, BIT(10))
+
+/* TX WD INFO DWORD 1 */
+#define RTW89_SET_TXWD_INFO_A_CTRL_BSR(txdesc, val) \
+	RTW89_SET_TXWD(txdesc, val, 0x7, BIT(14))
+#define RTW89_SET_TXWD_INFO_MAX_AGGNUM(txdesc, val) \
+	RTW89_SET_TXWD(txdesc, val, 0x7, GENMASK(7, 0))
+
+/* TX WD INFO DWORD 2 */
+#define RTW89_SET_TXWD_INFO_AMPDU_DENSITY(txdesc, val) \
+	RTW89_SET_TXWD(txdesc, val, 0x8, GENMASK(20, 18))
+#define RTW89_SET_TXWD_INFO_SEC_TYPE(txdesc, val) \
+	RTW89_SET_TXWD(txdesc, val, 0x8, GENMASK(12, 9))
+#define RTW89_SET_TXWD_INFO_SEC_HW_ENC(txdesc, val) \
+	RTW89_SET_TXWD(txdesc, val, 0x8, BIT(8))
+#define RTW89_SET_TXWD_INFO_SEC_CAM_IDX(txdesc, val) \
+	RTW89_SET_TXWD(txdesc, val, 0x8, GENMASK(7, 0))
+
+/* TX WD INFO DWORD 3 */
+
+/* TX WD INFO DWORD 4 */
+#define RTW89_SET_TXWD_INFO_RTS_EN(txdesc, val) \
+	RTW89_SET_TXWD(txdesc, val, 0xA, BIT(27))
+#define RTW89_SET_TXWD_INFO_HW_RTS_EN(txdesc, val) \
+	RTW89_SET_TXWD(txdesc, val, 0xA, BIT(31))
+
+/* TX WD INFO DWORD 5 */
+
+/* RX DESC helpers */
+/* Short Descriptor */
+#define RTW89_GET_RXWD_LONG_RXD(rxdesc) \
+	le32_get_bits((rxdesc)->dword0, BIT(31))
+#define RTW89_GET_RXWD_DRV_INFO_SIZE(rxdesc) \
+	le32_get_bits((rxdesc)->dword0, GENMASK(30, 28))
+#define RTW89_GET_RXWD_RPKT_TYPE(rxdesc) \
+	le32_get_bits((rxdesc)->dword0, GENMASK(27, 24))
+#define RTW89_GET_RXWD_MAC_INFO_VALID(rxdesc) \
+	le32_get_bits((rxdesc)->dword0, BIT(23))
+#define RTW89_GET_RXWD_BB_SEL(rxdesc) \
+	le32_get_bits((rxdesc)->dword0, BIT(22))
+#define RTW89_GET_RXWD_HD_IV_LEN(rxdesc) \
+	le32_get_bits((rxdesc)->dword0, GENMASK(21, 16))
+#define RTW89_GET_RXWD_SHIFT(rxdesc) \
+	le32_get_bits((rxdesc)->dword0, GENMASK(15, 14))
+#define RTW89_GET_RXWD_PKT_SIZE(rxdesc) \
+	le32_get_bits((rxdesc)->dword0, GENMASK(13, 0))
+#define RTW89_GET_RXWD_BW(rxdesc) \
+	le32_get_bits((rxdesc)->dword1, GENMASK(31, 30))
+#define RTW89_GET_RXWD_GI_LTF(rxdesc) \
+	le32_get_bits((rxdesc)->dword1, GENMASK(27, 25))
+#define RTW89_GET_RXWD_DATA_RATE(rxdesc) \
+	le32_get_bits((rxdesc)->dword1, GENMASK(24, 16))
+#define RTW89_GET_RXWD_USER_ID(rxdesc) \
+	le32_get_bits((rxdesc)->dword1, GENMASK(15, 8))
+#define RTW89_GET_RXWD_SR_EN(rxdesc) \
+	le32_get_bits((rxdesc)->dword1, BIT(7))
+#define RTW89_GET_RXWD_PPDU_CNT(rxdesc) \
+	le32_get_bits((rxdesc)->dword1, GENMASK(6, 4))
+#define RTW89_GET_RXWD_PPDU_TYPE(rxdesc) \
+	le32_get_bits((rxdesc)->dword1, GENMASK(3, 0))
+#define RTW89_GET_RXWD_FREE_RUN_CNT(rxdesc) \
+	le32_get_bits((rxdesc)->dword2, GENMASK(31, 0))
+#define RTW89_GET_RXWD_ICV_ERR(rxdesc) \
+	le32_get_bits((rxdesc)->dword3, BIT(10))
+#define RTW89_GET_RXWD_CRC32_ERR(rxdesc) \
+	le32_get_bits((rxdesc)->dword3, BIT(9))
+#define RTW89_GET_RXWD_HW_DEC(rxdesc) \
+	le32_get_bits((rxdesc)->dword3, BIT(2))
+#define RTW89_GET_RXWD_SW_DEC(rxdesc) \
+	le32_get_bits((rxdesc)->dword3, BIT(1))
+#define RTW89_GET_RXWD_A1_MATCH(rxdesc) \
+	le32_get_bits((rxdesc)->dword3, BIT(0))
+
+/* Long Descriptor */
+#define RTW89_GET_RXWD_FRAG(rxdesc) \
+	le32_get_bits((rxdesc)->dword4, GENMASK(31, 28))
+#define RTW89_GET_RXWD_SEQ(rxdesc) \
+	le32_get_bits((rxdesc)->dword4, GENMASK(27, 16))
+#define RTW89_GET_RXWD_TYPE(rxdesc) \
+	le32_get_bits((rxdesc)->dword4, GENMASK(1, 0))
+#define RTW89_GET_RXWD_ADDR_CAM_VLD(rxdesc) \
+	le32_get_bits((rxdesc)->dword5, BIT(28))
+#define RTW89_GET_RXWD_RX_PL_ID(rxdesc) \
+	le32_get_bits((rxdesc)->dword5, GENMASK(27, 24))
+#define RTW89_GET_RXWD_MAC_ID(rxdesc) \
+	le32_get_bits((rxdesc)->dword5, GENMASK(23, 16))
+#define RTW89_GET_RXWD_ADDR_CAM_ID(rxdesc) \
+	le32_get_bits((rxdesc)->dword5, GENMASK(15, 8))
+#define RTW89_GET_RXWD_SEC_CAM_ID(rxdesc) \
+	le32_get_bits((rxdesc)->dword5, GENMASK(7, 0))
+
+#define RTW89_GET_RXINFO_USR_NUM(rpt) \
+	le32_get_bits(*((__le32 *)rpt), GENMASK(3, 0))
+#define RTW89_GET_RXINFO_FW_DEFINE(rpt) \
+	le32_get_bits(*((__le32 *)rpt), GENMASK(15, 8))
+#define RTW89_GET_RXINFO_LSIG_LEN(rpt) \
+	le32_get_bits(*((__le32 *)rpt), GENMASK(27, 16))
+#define RTW89_GET_RXINFO_IS_TO_SELF(rpt) \
+	le32_get_bits(*((__le32 *)rpt), BIT(28))
+#define RTW89_GET_RXINFO_RX_CNT_VLD(rpt) \
+	le32_get_bits(*((__le32 *)rpt), BIT(29))
+#define RTW89_GET_RXINFO_LONG_RXD(rpt) \
+	le32_get_bits(*((__le32 *)rpt), GENMASK(31, 30))
+#define RTW89_GET_RXINFO_SERVICE(rpt) \
+	le32_get_bits(*((__le32 *)(rpt) + 1), GENMASK(15, 0))
+#define RTW89_GET_RXINFO_PLCP_LEN(rpt) \
+	le32_get_bits(*((__le32 *)(rpt) + 1), GENMASK(23, 16))
+#define RTW89_GET_RXINFO_MAC_ID_VALID(rpt, usr) \
+	le32_get_bits(*((__le32 *)(rpt) + (usr) + 2), BIT(0))
+#define RTW89_GET_RXINFO_DATA(rpt, usr) \
+	le32_get_bits(*((__le32 *)(rpt) + (usr) + 2), BIT(1))
+#define RTW89_GET_RXINFO_CTRL(rpt, usr) \
+	le32_get_bits(*((__le32 *)(rpt) + (usr) + 2), BIT(2))
+#define RTW89_GET_RXINFO_MGMT(rpt, usr) \
+	le32_get_bits(*((__le32 *)(rpt) + (usr) + 2), BIT(3))
+#define RTW89_GET_RXINFO_BCM(rpt, usr) \
+	le32_get_bits(*((__le32 *)(rpt) + (usr) + 2), BIT(4))
+#define RTW89_GET_RXINFO_MACID(rpt, usr) \
+	le32_get_bits(*((__le32 *)(rpt) + (usr) + 2), GENMASK(15, 8))
+
+#define RTW89_GET_PHY_STS_RSSI_A(sts) \
+	le32_get_bits(*((__le32 *)(sts) + 1), GENMASK(7, 0))
+#define RTW89_GET_PHY_STS_RSSI_B(sts) \
+	le32_get_bits(*((__le32 *)(sts) + 1), GENMASK(15, 8))
+#define RTW89_GET_PHY_STS_RSSI_C(sts) \
+	le32_get_bits(*((__le32 *)(sts) + 1), GENMASK(23, 16))
+#define RTW89_GET_PHY_STS_RSSI_D(sts) \
+	le32_get_bits(*((__le32 *)(sts) + 1), GENMASK(31, 24))
+#define RTW89_GET_PHY_STS_LEN(sts) \
+	le32_get_bits(*((__le32 *)sts), GENMASK(15, 8))
+#define RTW89_GET_PHY_STS_RSSI_AVG(sts) \
+	le32_get_bits(*((__le32 *)sts), GENMASK(31, 24))
+#define RTW89_GET_PHY_STS_IE_TYPE(ie) \
+	le32_get_bits(*((__le32 *)ie), GENMASK(4, 0))
+#define RTW89_GET_PHY_STS_IE_LEN(ie) \
+	le32_get_bits(*((__le32 *)ie), GENMASK(11, 5))
+#define RTW89_GET_PHY_STS_IE0_CFO(ie) \
+	le32_get_bits(*((__le32 *)(ie) + 1), GENMASK(31, 20))
+
+enum rtw89_tx_channel {
+	RTW89_TXCH_ACH0	= 0,
+	RTW89_TXCH_ACH1	= 1,
+	RTW89_TXCH_ACH2	= 2,
+	RTW89_TXCH_ACH3	= 3,
+	RTW89_TXCH_ACH4	= 4,
+	RTW89_TXCH_ACH5	= 5,
+	RTW89_TXCH_ACH6	= 6,
+	RTW89_TXCH_ACH7	= 7,
+	RTW89_TXCH_CH8	= 8,  /* MGMT Band 0 */
+	RTW89_TXCH_CH9	= 9,  /* HI Band 0 */
+	RTW89_TXCH_CH10	= 10, /* MGMT Band 1 */
+	RTW89_TXCH_CH11	= 11, /* HI Band 1 */
+	RTW89_TXCH_CH12	= 12, /* FW CMD */
+
+	/* keep last */
+	RTW89_TXCH_NUM,
+	RTW89_TXCH_MAX = RTW89_TXCH_NUM - 1
+};
+
+enum rtw89_rx_channel {
+	RTW89_RXCH_RXQ	= 0,
+	RTW89_RXCH_RPQ	= 1,
+
+	/* keep last */
+	RTW89_RXCH_NUM,
+	RTW89_RXCH_MAX = RTW89_RXCH_NUM - 1
+};
+
+enum rtw89_tx_qsel {
+	RTW89_TX_QSEL_BE_0		= 0x00,
+	RTW89_TX_QSEL_BK_0		= 0x01,
+	RTW89_TX_QSEL_VI_0		= 0x02,
+	RTW89_TX_QSEL_VO_0		= 0x03,
+	RTW89_TX_QSEL_BE_1		= 0x04,
+	RTW89_TX_QSEL_BK_1		= 0x05,
+	RTW89_TX_QSEL_VI_1		= 0x06,
+	RTW89_TX_QSEL_VO_1		= 0x07,
+	RTW89_TX_QSEL_BE_2		= 0x08,
+	RTW89_TX_QSEL_BK_2		= 0x09,
+	RTW89_TX_QSEL_VI_2		= 0x0a,
+	RTW89_TX_QSEL_VO_2		= 0x0b,
+	RTW89_TX_QSEL_BE_3		= 0x0c,
+	RTW89_TX_QSEL_BK_3		= 0x0d,
+	RTW89_TX_QSEL_VI_3		= 0x0e,
+	RTW89_TX_QSEL_VO_3		= 0x0f,
+	RTW89_TX_QSEL_B0_BCN		= 0x10,
+	RTW89_TX_QSEL_B0_HI		= 0x11,
+	RTW89_TX_QSEL_B0_MGMT		= 0x12,
+	RTW89_TX_QSEL_B0_NOPS		= 0x13,
+	RTW89_TX_QSEL_B0_MGMT_FAST	= 0x14,
+	/* reserved */
+	/* reserved */
+	/* reserved */
+	RTW89_TX_QSEL_B1_BCN		= 0x18,
+	RTW89_TX_QSEL_B1_HI		= 0x19,
+	RTW89_TX_QSEL_B1_MGMT		= 0x1a,
+	RTW89_TX_QSEL_B1_NOPS		= 0x1b,
+	RTW89_TX_QSEL_B1_MGMT_FAST	= 0x1c,
+	/* reserved */
+	/* reserved */
+	/* reserved */
+};
+
+enum rtw89_phy_status_ie_type {
+	RTW89_PHYSTS_IE00_CMN_CCK			= 0,
+	RTW89_PHYSTS_IE01_CMN_OFDM			= 1,
+	RTW89_PHYSTS_IE02_CMN_EXT_AX			= 2,
+	RTW89_PHYSTS_IE03_CMN_EXT_SEG_1			= 3,
+	RTW89_PHYSTS_IE04_CMN_EXT_PATH_A		= 4,
+	RTW89_PHYSTS_IE05_CMN_EXT_PATH_B		= 5,
+	RTW89_PHYSTS_IE06_CMN_EXT_PATH_C		= 6,
+	RTW89_PHYSTS_IE07_CMN_EXT_PATH_D		= 7,
+	RTW89_PHYSTS_IE08_FTR_CH			= 8,
+	RTW89_PHYSTS_IE09_FTR_PLCP_0			= 9,
+	RTW89_PHYSTS_IE10_FTR_PLCP_EXT			= 10,
+	RTW89_PHYSTS_IE11_FTR_PLCP_HISTOGRAM		= 11,
+	RTW89_PHYSTS_IE12_MU_EIGEN_INFO			= 12,
+	RTW89_PHYSTS_IE13_DL_MU_DEF			= 13,
+	RTW89_PHYSTS_IE14_TB_UL_CQI			= 14,
+	RTW89_PHYSTS_IE15_TB_UL_DEF			= 15,
+	RTW89_PHYSTS_IE16_RSVD16			= 16,
+	RTW89_PHYSTS_IE17_TB_UL_CTRL			= 17,
+	RTW89_PHYSTS_IE18_DBG_OFDM_FD_CMN		= 18,
+	RTW89_PHYSTS_IE19_DBG_OFDM_TD_CMN		= 19,
+	RTW89_PHYSTS_IE20_DBG_OFDM_FD_USER_SEG_0	= 20,
+	RTW89_PHYSTS_IE21_DBG_OFDM_FD_USER_SEG_1	= 21,
+	RTW89_PHYSTS_IE22_DBG_OFDM_FD_USER_AGC		= 22,
+	RTW89_PHYSTS_IE23_RSVD23			= 23,
+	RTW89_PHYSTS_IE24_DBG_OFDM_TD_PATH_A		= 24,
+	RTW89_PHYSTS_IE25_DBG_OFDM_TD_PATH_B		= 25,
+	RTW89_PHYSTS_IE26_DBG_OFDM_TD_PATH_C		= 26,
+	RTW89_PHYSTS_IE27_DBG_OFDM_TD_PATH_D		= 27,
+	RTW89_PHYSTS_IE28_DBG_CCK_PATH_A		= 28,
+	RTW89_PHYSTS_IE29_DBG_CCK_PATH_B		= 29,
+	RTW89_PHYSTS_IE30_DBG_CCK_PATH_C		= 30,
+	RTW89_PHYSTS_IE31_DBG_CCK_PATH_D		= 31,
+
+	/* keep last */
+	RTW89_PHYSTS_IE_NUM,
+	RTW89_PHYSTS_IE_MAX = RTW89_PHYSTS_IE_NUM - 1
+};
+
+static inline u8 rtw89_core_get_qsel(struct rtw89_dev *rtwdev, u8 tid)
+{
+	switch (tid) {
+	default:
+		rtw89_warn(rtwdev, "Should use tag 1d: %d\n", tid);
+		fallthrough;
+	case 0:
+	case 3:
+		return RTW89_TX_QSEL_BE_0;
+	case 1:
+	case 2:
+		return RTW89_TX_QSEL_BK_0;
+	case 4:
+	case 5:
+		return RTW89_TX_QSEL_VI_0;
+	case 6:
+	case 7:
+		return RTW89_TX_QSEL_VO_0;
+	}
+}
+
+static inline u8 rtw89_core_get_ch_dma(struct rtw89_dev *rtwdev, u8 qsel)
+{
+	switch (qsel) {
+	default:
+		rtw89_warn(rtwdev, "Cannot map qsel to dma: %d\n", qsel);
+		fallthrough;
+	case RTW89_TX_QSEL_BE_0:
+		return RTW89_TXCH_ACH0;
+	case RTW89_TX_QSEL_BK_0:
+		return RTW89_TXCH_ACH1;
+	case RTW89_TX_QSEL_VI_0:
+		return RTW89_TXCH_ACH2;
+	case RTW89_TX_QSEL_VO_0:
+		return RTW89_TXCH_ACH3;
+	case RTW89_TX_QSEL_B0_MGMT:
+		return RTW89_TXCH_CH8;
+	case RTW89_TX_QSEL_B0_HI:
+		return RTW89_TXCH_CH9;
+	case RTW89_TX_QSEL_B1_MGMT:
+		return RTW89_TXCH_CH10;
+	case RTW89_TX_QSEL_B1_HI:
+		return RTW89_TXCH_CH11;
+	}
+}
+
+static inline u8 rtw89_core_get_tid_indicate(struct rtw89_dev *rtwdev, u8 tid)
+{
+	switch (tid) {
+	case 3:
+	case 2:
+	case 5:
+	case 7:
+		return 1;
+	default:
+		rtw89_warn(rtwdev, "Should use tag 1d: %d\n", tid);
+		fallthrough;
+	case 0:
+	case 1:
+	case 4:
+	case 6:
+		return 0;
+	}
+}
+
+static __always_inline void RTW89_SET_TXWD(u8 *txdesc, u32 val, u8 offset, u32 mask)
+{
+	u32 *txd32 = (u32 *)txdesc;
+
+	le32p_replace_bits((__le32 *)(txd32 + offset), val, mask);
+}
+
+#endif
diff --git a/drivers/net/wireless/realtek/rtw89/util.c b/drivers/net/wireless/realtek/rtw89/util.c
new file mode 100644
index 000000000000..a0650bb88d0c
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtw89/util.c
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/* Copyright(c) 2019-2020  Realtek Corporation
+ */
+
+#include "util.h"
+
+static void
+__rtw89_vifs_collect_iter(void *data, u8 *mac, struct ieee80211_vif *vif)
+{
+	struct list_head *vif_list = (struct list_head *)data;
+	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
+
+	list_add_tail(&rtwvif->list, vif_list);
+}
+
+void __rtw89_iterate_vifs(struct rtw89_dev *rtwdev,
+			  void (*iterator)(void *data, u8 *mac,
+					   struct ieee80211_vif *vif),
+			  void *data)
+{
+	struct ieee80211_vif *vif;
+	struct rtw89_vif *rtwvif;
+	LIST_HEAD(vif_list);
+
+	/* iflist_mtx & mutex are held */
+	lockdep_assert_held(&rtwdev->mutex);
+
+	/* Since iflist_mtx is held, we can use vif outside of iterator */
+	ieee80211_iterate_active_interfaces_atomic(rtwdev->hw,
+			IEEE80211_IFACE_ITER_NORMAL, __rtw89_vifs_collect_iter,
+			&vif_list);
+
+	list_for_each_entry(rtwvif, &vif_list, list) {
+		vif = rtwvif_to_vif(rtwvif);
+		iterator(data, vif->addr, vif);
+	}
+}
diff --git a/drivers/net/wireless/realtek/rtw89/util.h b/drivers/net/wireless/realtek/rtw89/util.h
new file mode 100644
index 000000000000..935ceecdbb75
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtw89/util.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+ * Copyright(c) 2019-2020  Realtek Corporation
+ */
+#ifndef __RTW89_UTIL_H__
+#define __RTW89_UTIL_H__
+
+#include "core.h"
+
+#define rtw89_iterate_vifs_bh(rtwdev, iterator, data)                          \
+	ieee80211_iterate_active_interfaces_atomic((rtwdev)->hw,               \
+			IEEE80211_IFACE_ITER_NORMAL, iterator, data)
+void __rtw89_iterate_vifs(struct rtw89_dev *rtwdev,
+			  void (*iterator)(void *data, u8 *mac,
+					   struct ieee80211_vif *vif),
+			  void *data);
+static inline
+void rtw89_iterate_vifs(struct rtw89_dev *rtwdev,
+			void (*iterator)(void *data, u8 *mac,
+					 struct ieee80211_vif *vif),
+			void *data, bool held_vifmtx)
+{
+	if (!held_vifmtx) {
+		ieee80211_iterate_active_interfaces((rtwdev)->hw,
+				IEEE80211_IFACE_ITER_NORMAL, iterator, data);
+		return;
+	}
+
+	__rtw89_iterate_vifs(rtwdev, iterator, data);
+}
+
+#endif
-- 
2.25.1

