Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E91567C129
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jul 2019 14:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727599AbfGaMXM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 31 Jul 2019 08:23:12 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:36787 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726561AbfGaMXM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 31 Jul 2019 08:23:12 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x6VCMuT3007674, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x6VCMuT3007674
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 31 Jul 2019 20:22:56 +0800
Received: from localhost.localdomain (172.21.68.126) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.439.0; Wed, 31 Jul 2019 20:22:55 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>,
        <sgruszka@redhat.com>
Subject: [PATCH v3 3/3] rtw88: add BT co-existence support
Date:   Wed, 31 Jul 2019 20:22:47 +0800
Message-ID: <1564575767-27557-4-git-send-email-yhchuang@realtek.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1564575767-27557-1-git-send-email-yhchuang@realtek.com>
References: <1564575767-27557-1-git-send-email-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.126]
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Yan-Hsuan Chuang <yhchuang@realtek.com>

Both RTL8822BE/RTL8822CE are WiFi + BT combo chips. Since
WiFi and BT use 2.4GHz to transmit, it is important to
make sure they run concurrently without interfering each
other. To achieve this, WiFi driver requires a mechanism
to collaborate with BT, whether they share the antenna(s)
or not.

The final decision made by the co-existence mechanism is
to choose a proper strategy, or called "tdma/table", and
inform either firmware or hardware of the strategy.
To choose a strategy, co-existence mechanism needs to
have enough information from WiFi and BT.

BT information is provided through firmware C2H.
The contents describe the current status of BT, such as
if BT is connected or is idle, or the profile that is
being used.

WiFi information can be provided by WiFi itself. The WiFi
driver will call various of "notify" functions each time
the state of WiFi changed, such as WiFi is going to switch
channel or is connected. Also WiFi driver can know if it
shares antenna with BT by reading efuse content. Antenna
configuration of the module will finally get a different
strategy.

Upon receiving any information from WiFi or BT, the WiFi
driver will run the co-existence mechanism immediately.
It will set the RF antenna configuration according to the
strategy through the TDMA H2C to firmware and a hardware
table. Based on the tdma/table, WiFi + BT should work with
each other, and having a better user experience.

Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
v1 -> v2
    - no change

v2 -> v3

    - add TDMA mode with 4 slots
    - free skbs from rtw_coex_info_request
    

 drivers/net/wireless/realtek/rtw88/Makefile   |    1 +
 drivers/net/wireless/realtek/rtw88/coex.c     | 2507 +++++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw88/coex.h     |  369 ++++
 drivers/net/wireless/realtek/rtw88/fw.c       |  106 ++
 drivers/net/wireless/realtek/rtw88/fw.h       |   71 +
 drivers/net/wireless/realtek/rtw88/mac80211.c |   19 +
 drivers/net/wireless/realtek/rtw88/main.c     |   45 +-
 drivers/net/wireless/realtek/rtw88/main.h     |  233 +++
 drivers/net/wireless/realtek/rtw88/ps.c       |    9 +
 drivers/net/wireless/realtek/rtw88/reg.h      |   62 +
 drivers/net/wireless/realtek/rtw88/rtw8822b.c |  460 ++++-
 drivers/net/wireless/realtek/rtw88/rtw8822c.c |  355 +++-
 12 files changed, 4209 insertions(+), 28 deletions(-)
 create mode 100644 drivers/net/wireless/realtek/rtw88/coex.c
 create mode 100644 drivers/net/wireless/realtek/rtw88/coex.h

diff --git a/drivers/net/wireless/realtek/rtw88/Makefile b/drivers/net/wireless/realtek/rtw88/Makefile
index e0bfefd..77edee2 100644
--- a/drivers/net/wireless/realtek/rtw88/Makefile
+++ b/drivers/net/wireless/realtek/rtw88/Makefile
@@ -9,6 +9,7 @@ rtw88-y += main.o \
 	   rx.o \
 	   mac.o \
 	   phy.o \
+	   coex.o \
 	   efuse.o \
 	   fw.o \
 	   ps.o \
diff --git a/drivers/net/wireless/realtek/rtw88/coex.c b/drivers/net/wireless/realtek/rtw88/coex.c
new file mode 100644
index 0000000..4577fce
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtw88/coex.c
@@ -0,0 +1,2507 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/* Copyright(c) 2018-2019  Realtek Corporation
+ */
+
+#include "main.h"
+#include "coex.h"
+#include "fw.h"
+#include "ps.h"
+#include "debug.h"
+#include "reg.h"
+
+static u8 rtw_coex_next_rssi_state(struct rtw_dev *rtwdev, u8 pre_state,
+				   u8 rssi, u8 rssi_thresh)
+{
+	struct rtw_chip_info *chip = rtwdev->chip;
+	u8 tol = chip->rssi_tolerance;
+	u8 next_state;
+
+	if (pre_state == COEX_RSSI_STATE_LOW ||
+	    pre_state == COEX_RSSI_STATE_STAY_LOW) {
+		if (rssi >= (rssi_thresh + tol))
+			next_state = COEX_RSSI_STATE_HIGH;
+		else
+			next_state = COEX_RSSI_STATE_STAY_LOW;
+	} else {
+		if (rssi < rssi_thresh)
+			next_state = COEX_RSSI_STATE_LOW;
+		else
+			next_state = COEX_RSSI_STATE_STAY_HIGH;
+	}
+
+	return next_state;
+}
+
+static void rtw_coex_limited_tx(struct rtw_dev *rtwdev,
+				bool tx_limit_en, bool ampdu_limit_en)
+{
+	struct rtw_chip_info *chip = rtwdev->chip;
+	struct rtw_coex *coex = &rtwdev->coex;
+	struct rtw_coex_stat *coex_stat = &coex->stat;
+	bool wifi_under_b_mode = false;
+
+	if (!chip->scbd_support)
+		return;
+
+	/* force max tx retry limit = 8 */
+	if (coex_stat->wl_tx_limit_en == tx_limit_en &&
+	    coex_stat->wl_ampdu_limit_en == ampdu_limit_en)
+		return;
+
+	if (!coex_stat->wl_tx_limit_en) {
+		coex_stat->darfrc = rtw_read32(rtwdev, REG_DARFRC);
+		coex_stat->darfrch = rtw_read32(rtwdev, REG_DARFRCH);
+		coex_stat->retry_limit = rtw_read16(rtwdev, REG_RETRY_LIMIT);
+	}
+
+	if (!coex_stat->wl_ampdu_limit_en)
+		coex_stat->ampdu_max_time =
+				rtw_read8(rtwdev, REG_AMPDU_MAX_TIME_V1);
+
+	coex_stat->wl_tx_limit_en = tx_limit_en;
+	coex_stat->wl_ampdu_limit_en = ampdu_limit_en;
+
+	if (tx_limit_en) {
+		/* set BT polluted packet on for tx rate adaptive,
+		 * not including tx retry broken by PTA
+		 */
+		rtw_write8_set(rtwdev, REG_TX_HANG_CTRL, BIT_EN_GNT_BT_AWAKE);
+
+		/* set queue life time to avoid can't reach tx retry limit
+		 * if tx is always broken by GNT_BT
+		 */
+		rtw_write8_set(rtwdev, REG_LIFETIME_EN, 0xf);
+		rtw_write16(rtwdev, REG_RETRY_LIMIT, 0x0808);
+
+		/* auto rate fallback step within 8 retries */
+		if (wifi_under_b_mode) {
+			rtw_write32(rtwdev, REG_DARFRC, 0x1000000);
+			rtw_write32(rtwdev, REG_DARFRCH, 0x1010101);
+		} else {
+			rtw_write32(rtwdev, REG_DARFRC, 0x1000000);
+			rtw_write32(rtwdev, REG_DARFRCH, 0x4030201);
+		}
+	} else {
+		rtw_write8_clr(rtwdev, REG_TX_HANG_CTRL, BIT_EN_GNT_BT_AWAKE);
+		rtw_write8_clr(rtwdev, REG_LIFETIME_EN, 0xf);
+
+		rtw_write16(rtwdev, REG_RETRY_LIMIT, coex_stat->retry_limit);
+		rtw_write32(rtwdev, REG_DARFRC, coex_stat->darfrc);
+		rtw_write32(rtwdev, REG_DARFRCH, coex_stat->darfrch);
+	}
+
+	if (ampdu_limit_en)
+		rtw_write8(rtwdev, REG_AMPDU_MAX_TIME_V1, 0x20);
+	else
+		rtw_write8(rtwdev, REG_AMPDU_MAX_TIME_V1,
+			   coex_stat->ampdu_max_time);
+}
+
+static void rtw_coex_limited_wl(struct rtw_dev *rtwdev)
+{
+	struct rtw_coex *coex = &rtwdev->coex;
+	struct rtw_coex_dm *coex_dm = &coex->dm;
+	struct rtw_coex_stat *coex_stat = &coex->stat;
+	bool tx_limit = false;
+	bool tx_agg_ctrl = false;
+
+	if (coex->under_5g ||
+	    coex_dm->bt_status == COEX_BTSTATUS_NCON_IDLE) {
+		/* no need to limit tx */
+	} else {
+		tx_limit = true;
+		if (coex_stat->bt_hid_exist || coex_stat->bt_hfp_exist ||
+		    coex_stat->bt_hid_pair_num > 0)
+			tx_agg_ctrl = true;
+	}
+
+	rtw_coex_limited_tx(rtwdev, tx_limit, tx_agg_ctrl);
+}
+
+static void rtw_coex_wl_ccklock_action(struct rtw_dev *rtwdev)
+{
+	struct rtw_coex *coex = &rtwdev->coex;
+	struct rtw_coex_stat *coex_stat = &coex->stat;
+	u8 para[6] = {0};
+
+	if (coex->stop_dm)
+		return;
+
+	para[0] = COEX_H2C69_WL_LEAKAP;
+
+	if (coex_stat->tdma_timer_base == 3 && coex_stat->wl_slot_extend) {
+		para[1] = PARA1_H2C69_DIS_5MS; /* disable 5ms extend */
+		rtw_fw_bt_wifi_control(rtwdev, para[0], &para[1]);
+		coex_stat->wl_slot_extend = false;
+		coex_stat->cnt_wl[COEX_CNT_WL_5MS_NOEXTEND] = 0;
+		return;
+	}
+
+	if (coex_stat->wl_slot_extend && coex_stat->wl_force_lps_ctrl &&
+	    !coex_stat->wl_cck_lock_ever) {
+		if (coex_stat->wl_fw_dbg_info[7] <= 5)
+			coex_stat->cnt_wl[COEX_CNT_WL_5MS_NOEXTEND]++;
+		else
+			coex_stat->cnt_wl[COEX_CNT_WL_5MS_NOEXTEND] = 0;
+
+		if (coex_stat->cnt_wl[COEX_CNT_WL_5MS_NOEXTEND] == 7) {
+			para[1] = 0x1; /* disable 5ms extend */
+			rtw_fw_bt_wifi_control(rtwdev, para[0], &para[1]);
+			coex_stat->wl_slot_extend = false;
+			coex_stat->cnt_wl[COEX_CNT_WL_5MS_NOEXTEND] = 0;
+		}
+	} else if (!coex_stat->wl_slot_extend && coex_stat->wl_cck_lock) {
+		para[1] = 0x0; /* enable 5ms extend */
+		rtw_fw_bt_wifi_control(rtwdev, para[0], &para[1]);
+		coex_stat->wl_slot_extend = true;
+	}
+}
+
+static void rtw_coex_wl_ccklock_detect(struct rtw_dev *rtwdev)
+{
+	struct rtw_coex *coex = &rtwdev->coex;
+	struct rtw_coex_stat *coex_stat = &coex->stat;
+
+	/* TODO: wait for rx_rate_change_notify implement */
+	coex_stat->wl_cck_lock = false;
+	coex_stat->wl_cck_lock_pre = false;
+	coex_stat->wl_cck_lock_ever = false;
+}
+
+static void rtw_coex_wl_noisy_detect(struct rtw_dev *rtwdev)
+{
+	struct rtw_coex *coex = &rtwdev->coex;
+	struct rtw_coex_stat *coex_stat = &coex->stat;
+	struct rtw_dm_info *dm_info = &rtwdev->dm_info;
+	u32 cnt_cck;
+
+	/* wifi noisy environment identification */
+	cnt_cck = dm_info->cck_ok_cnt + dm_info->cck_err_cnt;
+
+	if (!coex_stat->wl_gl_busy) {
+		if (cnt_cck > 250) {
+			if (coex_stat->cnt_wl[COEX_CNT_WL_NOISY2] < 5)
+				coex_stat->cnt_wl[COEX_CNT_WL_NOISY2]++;
+
+			if (coex_stat->cnt_wl[COEX_CNT_WL_NOISY2] == 5) {
+				coex_stat->cnt_wl[COEX_CNT_WL_NOISY0] = 0;
+				coex_stat->cnt_wl[COEX_CNT_WL_NOISY1] = 0;
+			}
+		} else if (cnt_cck < 100) {
+			if (coex_stat->cnt_wl[COEX_CNT_WL_NOISY0] < 5)
+				coex_stat->cnt_wl[COEX_CNT_WL_NOISY0]++;
+
+			if (coex_stat->cnt_wl[COEX_CNT_WL_NOISY0] == 5) {
+				coex_stat->cnt_wl[COEX_CNT_WL_NOISY1] = 0;
+				coex_stat->cnt_wl[COEX_CNT_WL_NOISY2] = 0;
+			}
+		} else {
+			if (coex_stat->cnt_wl[COEX_CNT_WL_NOISY1] < 5)
+				coex_stat->cnt_wl[COEX_CNT_WL_NOISY1]++;
+
+			if (coex_stat->cnt_wl[COEX_CNT_WL_NOISY1] == 5) {
+				coex_stat->cnt_wl[COEX_CNT_WL_NOISY0] = 0;
+				coex_stat->cnt_wl[COEX_CNT_WL_NOISY2] = 0;
+			}
+		}
+
+		if (coex_stat->cnt_wl[COEX_CNT_WL_NOISY2] == 5)
+			coex_stat->wl_noisy_level = 2;
+		else if (coex_stat->cnt_wl[COEX_CNT_WL_NOISY1] == 5)
+			coex_stat->wl_noisy_level = 1;
+		else
+			coex_stat->wl_noisy_level = 0;
+	}
+}
+
+static void rtw_coex_tdma_timer_base(struct rtw_dev *rtwdev, u8 type)
+{
+	struct rtw_coex *coex = &rtwdev->coex;
+	struct rtw_coex_stat *coex_stat = &coex->stat;
+	u8 para[2] = {0};
+
+	if (coex_stat->tdma_timer_base == type)
+		return;
+
+	coex_stat->tdma_timer_base = type;
+
+	para[0] = COEX_H2C69_TDMA_SLOT;
+
+	if (type == 3) /* 4-slot  */
+		para[1] = PARA1_H2C69_TDMA_4SLOT; /* 4-slot */
+	else /* 2-slot  */
+		para[1] = PARA1_H2C69_TDMA_2SLOT;
+
+	rtw_fw_bt_wifi_control(rtwdev, para[0], &para[1]);
+
+	/* no 5ms_wl_slot_extend for 4-slot mode  */
+	if (coex_stat->tdma_timer_base == 3)
+		rtw_coex_wl_ccklock_action(rtwdev);
+}
+
+static void rtw_coex_set_wl_pri_mask(struct rtw_dev *rtwdev, u8 bitmap,
+				     u8 data)
+{
+	u32 addr;
+
+	addr = REG_BT_COEX_TABLE_H + (bitmap / 8);
+	bitmap = bitmap % 8;
+
+	rtw_write8_mask(rtwdev, addr, BIT(bitmap), data);
+}
+
+void rtw_coex_write_scbd(struct rtw_dev *rtwdev, u16 bitpos, bool set)
+{
+	struct rtw_chip_info *chip = rtwdev->chip;
+	struct rtw_coex *coex = &rtwdev->coex;
+	struct rtw_coex_stat *coex_stat = &coex->stat;
+	u16 val = 0x2;
+
+	if (!chip->scbd_support)
+		return;
+
+	val |= coex_stat->score_board;
+
+	/* for 8822b, scbd[10] is CQDDR on
+	 * for 8822c, scbd[10] is no fix 2M
+	 */
+	if (!chip->new_scbd10_def && (bitpos & COEX_SCBD_FIX2M)) {
+		if (set)
+			val &= ~COEX_SCBD_FIX2M;
+		else
+			val |= COEX_SCBD_FIX2M;
+	} else {
+		if (set)
+			val |= bitpos;
+		else
+			val &= ~bitpos;
+	}
+
+	if (val != coex_stat->score_board) {
+		coex_stat->score_board = val;
+		val |= BIT_BT_INT_EN;
+		rtw_write16(rtwdev, REG_WIFI_BT_INFO, val);
+	}
+}
+
+static u16 rtw_coex_read_scbd(struct rtw_dev *rtwdev)
+{
+	struct rtw_chip_info *chip = rtwdev->chip;
+
+	if (!chip->scbd_support)
+		return 0;
+
+	return (rtw_read16(rtwdev, REG_WIFI_BT_INFO)) & ~(BIT_BT_INT_EN);
+}
+
+static void rtw_coex_check_rfk(struct rtw_dev *rtwdev)
+{
+	struct rtw_chip_info *chip = rtwdev->chip;
+	struct rtw_coex *coex = &rtwdev->coex;
+	struct rtw_coex_stat *coex_stat = &coex->stat;
+	struct rtw_coex_rfe *coex_rfe = &coex->rfe;
+	u8 cnt = 0;
+	u32 wait_cnt;
+	bool btk, wlk;
+
+	if (coex_rfe->wlg_at_btg && chip->scbd_support &&
+	    coex_stat->bt_iqk_state != 0xff) {
+		wait_cnt = COEX_RFK_TIMEOUT / COEX_MIN_DELAY;
+		do {
+			/* BT RFK */
+			btk = !!(rtw_coex_read_scbd(rtwdev) & COEX_SCBD_BT_RFK);
+
+			/* WL RFK */
+			wlk = !!(rtw_read8(rtwdev, REG_ARFR4) & BIT_WL_RFK);
+
+			if (!btk && !wlk)
+				break;
+
+			mdelay(COEX_MIN_DELAY);
+		} while (++cnt < wait_cnt);
+
+		if (cnt >= wait_cnt)
+			coex_stat->bt_iqk_state = 0xff;
+	}
+}
+
+static void rtw_coex_query_bt_info(struct rtw_dev *rtwdev)
+{
+	struct rtw_coex *coex = &rtwdev->coex;
+	struct rtw_coex_stat *coex_stat = &coex->stat;
+
+	if (coex_stat->bt_disabled)
+		return;
+
+	rtw_fw_query_bt_info(rtwdev);
+}
+
+static void rtw_coex_monitor_bt_enable(struct rtw_dev *rtwdev)
+{
+	struct rtw_chip_info *chip = rtwdev->chip;
+	struct rtw_coex *coex = &rtwdev->coex;
+	struct rtw_coex_stat *coex_stat = &coex->stat;
+	struct rtw_coex_dm *coex_dm = &coex->dm;
+	bool bt_disabled = false;
+	u16 score_board;
+
+	if (chip->scbd_support) {
+		score_board = rtw_coex_read_scbd(rtwdev);
+		bt_disabled = !(score_board & COEX_SCBD_ONOFF);
+	}
+
+	if (coex_stat->bt_disabled != bt_disabled) {
+		rtw_dbg(rtwdev, RTW_DBG_COEX, "coex: BT state changed (%d) -> (%d)\n",
+			coex_stat->bt_disabled, bt_disabled);
+
+		coex_stat->bt_disabled = bt_disabled;
+		coex_stat->bt_ble_scan_type = 0;
+		coex_dm->cur_bt_lna_lvl = 0;
+	}
+
+	if (!coex_stat->bt_disabled) {
+		coex_stat->bt_reenable = true;
+		ieee80211_queue_delayed_work(rtwdev->hw,
+					     &coex->bt_reenable_work, 15 * HZ);
+	} else {
+		coex_stat->bt_mailbox_reply = false;
+		coex_stat->bt_reenable = false;
+	}
+}
+
+static void rtw_coex_update_wl_link_info(struct rtw_dev *rtwdev, u8 reason)
+{
+	struct rtw_coex *coex = &rtwdev->coex;
+	struct rtw_coex_stat *coex_stat = &coex->stat;
+	struct rtw_coex_dm *coex_dm = &coex->dm;
+	struct rtw_chip_info *chip = rtwdev->chip;
+	struct rtw_traffic_stats *stats = &rtwdev->stats;
+	bool is_5G = false;
+	bool scan = false, link = false;
+	int i;
+	u8 rssi_state;
+	u8 rssi_step;
+	u8 rssi;
+
+	scan = rtw_flag_check(rtwdev, RTW_FLAG_SCANNING);
+	coex_stat->wl_connected = !!rtwdev->sta_cnt;
+	coex_stat->wl_gl_busy = rtw_flag_check(rtwdev, RTW_FLAG_BUSY_TRAFFIC);
+
+	if (stats->tx_throughput > stats->rx_throughput)
+		coex_stat->wl_tput_dir = COEX_WL_TPUT_TX;
+	else
+		coex_stat->wl_tput_dir = COEX_WL_TPUT_RX;
+
+	if (scan || link || reason == COEX_RSN_2GCONSTART ||
+	    reason == COEX_RSN_2GSCANSTART || reason == COEX_RSN_2GSWITCHBAND)
+		coex_stat->wl_linkscan_proc = true;
+	else
+		coex_stat->wl_linkscan_proc = false;
+
+	rtw_coex_wl_noisy_detect(rtwdev);
+
+	for (i = 0; i < 4; i++) {
+		rssi_state = coex_dm->wl_rssi_state[i];
+		rssi_step = chip->wl_rssi_step[i];
+		rssi = rtwdev->dm_info.min_rssi;
+		rssi_state = rtw_coex_next_rssi_state(rtwdev, rssi_state,
+						      rssi, rssi_step);
+		coex_dm->wl_rssi_state[i] = rssi_state;
+	}
+
+	switch (reason) {
+	case COEX_RSN_5GSCANSTART:
+	case COEX_RSN_5GSWITCHBAND:
+	case COEX_RSN_5GCONSTART:
+
+		is_5G = true;
+		break;
+	case COEX_RSN_2GSCANSTART:
+	case COEX_RSN_2GSWITCHBAND:
+	case COEX_RSN_2GCONSTART:
+
+		is_5G = false;
+		break;
+	default:
+		if (rtwdev->hal.current_band_type == RTW_BAND_5G)
+			is_5G = true;
+		else
+			is_5G = false;
+		break;
+	}
+
+	coex->under_5g = is_5G;
+}
+
+static inline u8 *get_payload_from_coex_resp(struct sk_buff *resp)
+{
+	struct rtw_c2h_cmd *c2h;
+	u32 pkt_offset;
+
+	pkt_offset = *((u32 *)resp->cb);
+	c2h = (struct rtw_c2h_cmd *)(resp->data + pkt_offset);
+
+	return c2h->payload;
+}
+
+void rtw_coex_info_response(struct rtw_dev *rtwdev, struct sk_buff *skb)
+{
+	struct rtw_coex *coex = &rtwdev->coex;
+	u8 *payload = get_payload_from_coex_resp(skb);
+
+	if (payload[0] != COEX_RESP_ACK_BY_WL_FW)
+		return;
+
+	skb_queue_tail(&coex->queue, skb);
+	wake_up(&coex->wait);
+}
+
+static struct sk_buff *rtw_coex_info_request(struct rtw_dev *rtwdev,
+					     struct rtw_coex_info_req *req)
+{
+	struct rtw_coex *coex = &rtwdev->coex;
+	struct sk_buff *skb_resp = NULL;
+
+	mutex_lock(&coex->mutex);
+
+	rtw_fw_query_bt_mp_info(rtwdev, req);
+
+	if (!wait_event_timeout(coex->wait, !skb_queue_empty(&coex->queue),
+				COEX_REQUEST_TIMEOUT)) {
+		rtw_err(rtwdev, "coex request time out\n");
+		goto out;
+	}
+
+	skb_resp = skb_dequeue(&coex->queue);
+	if (!skb_resp) {
+		rtw_err(rtwdev, "failed to get coex info response\n");
+		goto out;
+	}
+
+out:
+	mutex_unlock(&coex->mutex);
+	return skb_resp;
+}
+
+static bool rtw_coex_get_bt_scan_type(struct rtw_dev *rtwdev, u8 *scan_type)
+{
+	struct rtw_coex_info_req req = {0};
+	struct sk_buff *skb;
+	u8 *payload;
+	bool ret = false;
+
+	req.op_code = BT_MP_INFO_OP_SCAN_TYPE;
+	skb = rtw_coex_info_request(rtwdev, &req);
+	if (!skb)
+		goto out;
+
+	payload = get_payload_from_coex_resp(skb);
+	*scan_type = GET_COEX_RESP_BT_SCAN_TYPE(payload);
+	dev_kfree_skb_any(skb);
+	ret = true;
+
+out:
+	return ret;
+}
+
+static bool rtw_coex_set_lna_constrain_level(struct rtw_dev *rtwdev,
+					     u8 lna_constrain_level)
+{
+	struct rtw_coex_info_req req = {0};
+	struct sk_buff *skb;
+	bool ret = false;
+
+	req.op_code = BT_MP_INFO_OP_LNA_CONSTRAINT;
+	req.para1 = lna_constrain_level;
+	skb = rtw_coex_info_request(rtwdev, &req);
+	if (!skb)
+		goto out;
+
+	dev_kfree_skb_any(skb);
+	ret = true;
+
+out:
+	return ret;
+}
+
+static void rtw_coex_update_bt_link_info(struct rtw_dev *rtwdev)
+{
+	struct rtw_coex *coex = &rtwdev->coex;
+	struct rtw_coex_stat *coex_stat = &coex->stat;
+	struct rtw_coex_dm *coex_dm = &coex->dm;
+	struct rtw_chip_info *chip = rtwdev->chip;
+	u8 i;
+	u8 rssi_state;
+	u8 rssi_step;
+	u8 rssi;
+
+	/* update wl/bt rssi by btinfo */
+	for (i = 0; i < COEX_RSSI_STEP; i++) {
+		rssi_state = coex_dm->bt_rssi_state[i];
+		rssi_step = chip->bt_rssi_step[i];
+		rssi = coex_stat->bt_rssi;
+		rssi_state = rtw_coex_next_rssi_state(rtwdev, rssi_state,
+						      rssi, rssi_step);
+		coex_dm->bt_rssi_state[i] = rssi_state;
+	}
+
+	for (i = 0; i < COEX_RSSI_STEP; i++) {
+		rssi_state = coex_dm->wl_rssi_state[i];
+		rssi_step = chip->wl_rssi_step[i];
+		rssi = rtwdev->dm_info.min_rssi;
+		rssi_state = rtw_coex_next_rssi_state(rtwdev, rssi_state,
+						      rssi, rssi_step);
+		coex_dm->wl_rssi_state[i] = rssi_state;
+	}
+
+	if (coex_stat->bt_ble_scan_en &&
+	    coex_stat->cnt_bt[COEX_CNT_BT_INFOUPDATE] % 3 == 0) {
+		u8 scan_type;
+
+		if (rtw_coex_get_bt_scan_type(rtwdev, &scan_type)) {
+			coex_stat->bt_ble_scan_type = scan_type;
+			if ((coex_stat->bt_ble_scan_type & 0x1) == 0x1)
+				coex_stat->bt_init_scan = true;
+			else
+				coex_stat->bt_init_scan = false;
+		}
+	}
+
+	coex_stat->bt_profile_num = 0;
+
+	/* set link exist status */
+	if (!(coex_stat->bt_info_lb2 & COEX_INFO_CONNECTION)) {
+		coex_stat->bt_link_exist = false;
+		coex_stat->bt_pan_exist = false;
+		coex_stat->bt_a2dp_exist = false;
+		coex_stat->bt_hid_exist = false;
+		coex_stat->bt_hfp_exist = false;
+	} else {
+		/* connection exists */
+		coex_stat->bt_link_exist = true;
+		if (coex_stat->bt_info_lb2 & COEX_INFO_FTP) {
+			coex_stat->bt_pan_exist = true;
+			coex_stat->bt_profile_num++;
+		} else {
+			coex_stat->bt_pan_exist = false;
+		}
+
+		if (coex_stat->bt_info_lb2 & COEX_INFO_A2DP) {
+			coex_stat->bt_a2dp_exist = true;
+			coex_stat->bt_profile_num++;
+		} else {
+			coex_stat->bt_a2dp_exist = false;
+		}
+
+		if (coex_stat->bt_info_lb2 & COEX_INFO_HID) {
+			coex_stat->bt_hid_exist = true;
+			coex_stat->bt_profile_num++;
+		} else {
+			coex_stat->bt_hid_exist = false;
+		}
+
+		if (coex_stat->bt_info_lb2 & COEX_INFO_SCO_ESCO) {
+			coex_stat->bt_hfp_exist = true;
+			coex_stat->bt_profile_num++;
+		} else {
+			coex_stat->bt_hfp_exist = false;
+		}
+	}
+
+	if (coex_stat->bt_info_lb2 & COEX_INFO_INQ_PAGE) {
+		coex_dm->bt_status = COEX_BTSTATUS_INQ_PAGE;
+	} else if (!(coex_stat->bt_info_lb2 & COEX_INFO_CONNECTION)) {
+		coex_dm->bt_status = COEX_BTSTATUS_NCON_IDLE;
+	} else if (coex_stat->bt_info_lb2 == COEX_INFO_CONNECTION) {
+		coex_dm->bt_status = COEX_BTSTATUS_CON_IDLE;
+	} else if ((coex_stat->bt_info_lb2 & COEX_INFO_SCO_ESCO) ||
+		   (coex_stat->bt_info_lb2 & COEX_INFO_SCO_BUSY)) {
+		if (coex_stat->bt_info_lb2 & COEX_INFO_ACL_BUSY)
+			coex_dm->bt_status = COEX_BTSTATUS_ACL_SCO_BUSY;
+		else
+			coex_dm->bt_status = COEX_BTSTATUS_SCO_BUSY;
+	} else if (coex_stat->bt_info_lb2 & COEX_INFO_ACL_BUSY) {
+		coex_dm->bt_status = COEX_BTSTATUS_ACL_BUSY;
+	} else {
+		coex_dm->bt_status = COEX_BTSTATUS_MAX;
+	}
+
+	coex_stat->cnt_bt[COEX_CNT_BT_INFOUPDATE]++;
+
+	rtw_dbg(rtwdev, RTW_DBG_COEX, "coex: bt status(%d)\n", coex_dm->bt_status);
+}
+
+static void rtw_coex_update_wl_ch_info(struct rtw_dev *rtwdev, u8 type)
+{
+	struct rtw_chip_info *chip = rtwdev->chip;
+	struct rtw_coex_dm *coex_dm = &rtwdev->coex.dm;
+	struct rtw_efuse *efuse = &rtwdev->efuse;
+	u8 link = 0;
+	u8 center_chan = 0;
+	u8 bw;
+	int i;
+
+	bw = rtwdev->hal.current_band_width;
+
+	if (type != COEX_MEDIA_DISCONNECT)
+		center_chan = rtwdev->hal.current_channel;
+
+	if (center_chan == 0 || (efuse->share_ant && center_chan <= 14)) {
+		link = 0;
+	} else if (center_chan <= 14) {
+		link = 0x1;
+
+		if (bw == RTW_CHANNEL_WIDTH_40)
+			bw = chip->bt_afh_span_bw40;
+		else
+			bw = chip->bt_afh_span_bw20;
+	} else if (chip->afh_5g_num > 1) {
+		for (i = 0; i < chip->afh_5g_num; i++) {
+			if (center_chan == chip->afh_5g[i].wl_5g_ch) {
+				link = 0x3;
+				center_chan = chip->afh_5g[i].bt_skip_ch;
+				bw = chip->afh_5g[i].bt_skip_span;
+				break;
+			}
+		}
+	}
+
+	coex_dm->wl_ch_info[0] = link;
+	coex_dm->wl_ch_info[1] = center_chan;
+	coex_dm->wl_ch_info[2] = bw;
+
+	rtw_fw_wl_ch_info(rtwdev, link, center_chan, bw);
+}
+
+static void rtw_coex_set_bt_tx_power(struct rtw_dev *rtwdev, u8 bt_pwr_dec_lvl)
+{
+	struct rtw_coex *coex = &rtwdev->coex;
+	struct rtw_coex_dm *coex_dm = &coex->dm;
+
+	if (bt_pwr_dec_lvl == coex_dm->cur_bt_pwr_lvl)
+		return;
+
+	coex_dm->cur_bt_pwr_lvl = bt_pwr_dec_lvl;
+
+	rtw_fw_force_bt_tx_power(rtwdev, bt_pwr_dec_lvl);
+}
+
+static void rtw_coex_set_bt_rx_gain(struct rtw_dev *rtwdev, u8 bt_lna_lvl)
+{
+	struct rtw_coex *coex = &rtwdev->coex;
+	struct rtw_coex_dm *coex_dm = &coex->dm;
+
+	if (bt_lna_lvl == coex_dm->cur_bt_lna_lvl)
+		return;
+
+	coex_dm->cur_bt_lna_lvl = bt_lna_lvl;
+
+	/* notify BT rx gain table changed */
+	if (bt_lna_lvl < 7) {
+		rtw_coex_set_lna_constrain_level(rtwdev, bt_lna_lvl);
+		rtw_coex_write_scbd(rtwdev, COEX_SCBD_RXGAIN, true);
+	} else {
+		rtw_coex_write_scbd(rtwdev, COEX_SCBD_RXGAIN, false);
+	}
+}
+
+static void rtw_coex_set_rf_para(struct rtw_dev *rtwdev,
+				 struct coex_rf_para para)
+{
+	struct rtw_coex *coex = &rtwdev->coex;
+	struct rtw_coex_stat *coex_stat = &coex->stat;
+	u8 offset = 0;
+
+	if (coex->freerun && coex_stat->wl_noisy_level <= 1)
+		offset = 3;
+
+	rtw_coex_set_wl_tx_power(rtwdev, para.wl_pwr_dec_lvl);
+	rtw_coex_set_bt_tx_power(rtwdev, para.bt_pwr_dec_lvl + offset);
+	rtw_coex_set_wl_rx_gain(rtwdev, para.wl_low_gain_en);
+	rtw_coex_set_bt_rx_gain(rtwdev, para.bt_lna_lvl);
+}
+
+static u32 rtw_coex_read_indirect_reg(struct rtw_dev *rtwdev, u16 addr)
+{
+	u32 val;
+
+	if (!ltecoex_read_reg(rtwdev, addr, &val)) {
+		rtw_err(rtwdev, "failed to read indirect register\n");
+		return 0;
+	}
+
+	return val;
+}
+
+void rtw_coex_write_indirect_reg(struct rtw_dev *rtwdev, u16 addr,
+				 u32 mask, u32 val)
+{
+	u32 shift = __ffs(mask);
+	u32 tmp;
+
+	tmp = rtw_coex_read_indirect_reg(rtwdev, addr);
+	tmp = (tmp & (~mask)) | ((val << shift) & mask);
+
+	if (!ltecoex_reg_write(rtwdev, addr, tmp))
+		rtw_err(rtwdev, "failed to write indirect register\n");
+}
+
+static void rtw_coex_coex_ctrl_owner(struct rtw_dev *rtwdev, bool wifi_control)
+{
+	if (wifi_control)
+		rtw_write32_set(rtwdev, REG_SYS_SDIO_CTRL, BIT_LTE_MUX_CTRL_PATH);
+	else
+		rtw_write32_clr(rtwdev, REG_SYS_SDIO_CTRL, BIT_LTE_MUX_CTRL_PATH);
+}
+
+static void rtw_coex_set_gnt_bt(struct rtw_dev *rtwdev, u8 state)
+{
+	rtw_coex_write_indirect_reg(rtwdev, 0x38, 0xc000, state);
+	rtw_coex_write_indirect_reg(rtwdev, 0x38, 0x0c00, state);
+}
+
+static void rtw_coex_set_gnt_wl(struct rtw_dev *rtwdev, u8 state)
+{
+	rtw_coex_write_indirect_reg(rtwdev, 0x38, 0x3000, state);
+	rtw_coex_write_indirect_reg(rtwdev, 0x38, 0x0300, state);
+}
+
+static void rtw_coex_set_table(struct rtw_dev *rtwdev, u32 table0, u32 table1)
+{
+#define DEF_BRK_TABLE_VAL	0xf0ffffff
+	rtw_write32(rtwdev, REG_BT_COEX_TABLE0, table0);
+	rtw_write32(rtwdev, REG_BT_COEX_TABLE1, table1);
+	rtw_write32(rtwdev, REG_BT_COEX_BRK_TABLE, DEF_BRK_TABLE_VAL);
+}
+
+static void rtw_coex_table(struct rtw_dev *rtwdev, u8 type)
+{
+	struct rtw_coex *coex = &rtwdev->coex;
+	struct rtw_coex_dm *coex_dm = &coex->dm;
+	struct rtw_chip_info *chip = rtwdev->chip;
+	struct rtw_efuse *efuse = &rtwdev->efuse;
+
+	coex_dm->cur_table = type;
+
+	if (efuse->share_ant) {
+		if (type < chip->table_sant_num)
+			rtw_coex_set_table(rtwdev,
+					   chip->table_sant[type].bt,
+					   chip->table_sant[type].wl);
+	} else {
+		type = type - 100;
+		if (type < chip->table_nsant_num)
+			rtw_coex_set_table(rtwdev,
+					   chip->table_nsant[type].bt,
+					   chip->table_nsant[type].wl);
+	}
+}
+
+static void rtw_coex_ignore_wlan_act(struct rtw_dev *rtwdev, bool enable)
+{
+	struct rtw_coex *coex = &rtwdev->coex;
+
+	if (coex->stop_dm)
+		return;
+
+	rtw_fw_bt_ignore_wlan_action(rtwdev, enable);
+}
+
+static void rtw_coex_power_save_state(struct rtw_dev *rtwdev, u8 ps_type,
+				      u8 lps_val, u8 rpwm_val)
+{
+	struct rtw_lps_conf *lps_conf = &rtwdev->lps_conf;
+	struct rtw_vif *rtwvif;
+	struct rtw_coex *coex = &rtwdev->coex;
+	struct rtw_coex_stat *coex_stat = &coex->stat;
+	u8 lps_mode = 0x0;
+
+	lps_mode = rtwdev->lps_conf.mode;
+
+	switch (ps_type) {
+	case COEX_PS_WIFI_NATIVE:
+		/* recover to original 32k low power setting */
+		coex_stat->wl_force_lps_ctrl = false;
+
+		rtwvif = lps_conf->rtwvif;
+		if (rtwvif && rtw_in_lps(rtwdev))
+			rtw_leave_lps(rtwdev, rtwvif);
+		break;
+	case COEX_PS_LPS_OFF:
+		coex_stat->wl_force_lps_ctrl = true;
+		if (lps_mode)
+			rtw_fw_coex_tdma_type(rtwdev, 0x8, 0, 0, 0, 0);
+
+		rtwvif = lps_conf->rtwvif;
+		if (rtwvif && rtw_in_lps(rtwdev))
+			rtw_leave_lps(rtwdev, rtwvif);
+		break;
+	default:
+		break;
+	}
+}
+
+static void rtw_coex_set_tdma(struct rtw_dev *rtwdev, u8 byte1, u8 byte2,
+			      u8 byte3, u8 byte4, u8 byte5)
+{
+	struct rtw_coex *coex = &rtwdev->coex;
+	struct rtw_coex_dm *coex_dm = &coex->dm;
+	struct rtw_chip_info *chip = rtwdev->chip;
+	u8 ps_type = COEX_PS_WIFI_NATIVE;
+	bool ap_enable = false;
+
+	if (ap_enable && (byte1 & BIT(4) && !(byte1 & BIT(5)))) {
+		byte1 &= ~BIT(4);
+		byte1 |= BIT(5);
+
+		byte5 |= BIT(5);
+		byte5 &= ~BIT(6);
+
+		ps_type = COEX_PS_WIFI_NATIVE;
+		rtw_coex_power_save_state(rtwdev, ps_type, 0x0, 0x0);
+	} else if (byte1 & BIT(4) && !(byte1 & BIT(5))) {
+		if (chip->pstdma_type == COEX_PSTDMA_FORCE_LPSOFF)
+			ps_type = COEX_PS_LPS_OFF;
+		else
+			ps_type = COEX_PS_LPS_ON;
+		rtw_coex_power_save_state(rtwdev, ps_type, 0x50, 0x4);
+	} else {
+		ps_type = COEX_PS_WIFI_NATIVE;
+		rtw_coex_power_save_state(rtwdev, ps_type, 0x0, 0x0);
+	}
+
+	coex_dm->ps_tdma_para[0] = byte1;
+	coex_dm->ps_tdma_para[1] = byte2;
+	coex_dm->ps_tdma_para[2] = byte3;
+	coex_dm->ps_tdma_para[3] = byte4;
+	coex_dm->ps_tdma_para[4] = byte5;
+
+	rtw_fw_coex_tdma_type(rtwdev, byte1, byte2, byte3, byte4, byte5);
+}
+
+static void rtw_coex_tdma(struct rtw_dev *rtwdev, bool force, u32 tcase)
+{
+	struct rtw_coex *coex = &rtwdev->coex;
+	struct rtw_coex_dm *coex_dm = &coex->dm;
+	struct rtw_chip_info *chip = rtwdev->chip;
+	struct rtw_efuse *efuse = &rtwdev->efuse;
+	u8 n, type;
+	bool turn_on;
+
+	if (tcase & TDMA_4SLOT)/* 4-slot (50ms) mode */
+		rtw_coex_tdma_timer_base(rtwdev, 3);
+	else
+		rtw_coex_tdma_timer_base(rtwdev, 0);
+
+	type = (u8)(tcase & 0xff);
+
+	turn_on = (type == 0 || type == 100) ? false : true;
+
+	if (!force) {
+		if (turn_on == coex_dm->cur_ps_tdma_on &&
+		    type == coex_dm->cur_ps_tdma) {
+			return;
+		}
+	}
+
+	if (turn_on) {
+		/* enable TBTT interrupt */
+		rtw_write8_set(rtwdev, REG_BCN_CTRL, BIT_EN_BCN_FUNCTION);
+		rtw_coex_write_scbd(rtwdev, COEX_SCBD_TDMA, true);
+	} else {
+		rtw_coex_write_scbd(rtwdev, COEX_SCBD_TDMA, false);
+	}
+
+	if (efuse->share_ant) {
+		if (type < chip->tdma_sant_num)
+			rtw_coex_set_tdma(rtwdev,
+					  chip->tdma_sant[type].para[0],
+					  chip->tdma_sant[type].para[1],
+					  chip->tdma_sant[type].para[2],
+					  chip->tdma_sant[type].para[3],
+					  chip->tdma_sant[type].para[4]);
+	} else {
+		n = type - 100;
+		if (n < chip->tdma_nsant_num)
+			rtw_coex_set_tdma(rtwdev,
+					  chip->tdma_nsant[n].para[0],
+					  chip->tdma_nsant[n].para[1],
+					  chip->tdma_nsant[n].para[2],
+					  chip->tdma_nsant[n].para[3],
+					  chip->tdma_nsant[n].para[4]);
+	}
+
+	/* update pre state */
+	coex_dm->cur_ps_tdma_on = turn_on;
+	coex_dm->cur_ps_tdma = type;
+
+	rtw_dbg(rtwdev, RTW_DBG_COEX, "coex: coex tdma type (%d)\n", type);
+}
+
+static void rtw_coex_set_ant_path(struct rtw_dev *rtwdev, bool force, u8 phase)
+{
+	struct rtw_coex *coex = &rtwdev->coex;
+	struct rtw_coex_stat *coex_stat = &coex->stat;
+	struct rtw_coex_dm *coex_dm = &coex->dm;
+	u8 ctrl_type = COEX_SWITCH_CTRL_MAX;
+	u8 pos_type = COEX_SWITCH_TO_MAX;
+
+	if (!force && coex_dm->cur_ant_pos_type == phase)
+		return;
+
+	coex_dm->cur_ant_pos_type = phase;
+
+	/* avoid switch coex_ctrl_owner during BT IQK */
+	rtw_coex_check_rfk(rtwdev);
+
+	switch (phase) {
+	case COEX_SET_ANT_POWERON:
+		/* set path control owner to BT at power-on */
+		if (coex_stat->bt_disabled)
+			rtw_coex_coex_ctrl_owner(rtwdev, true);
+		else
+			rtw_coex_coex_ctrl_owner(rtwdev, false);
+
+		ctrl_type = COEX_SWITCH_CTRL_BY_BBSW;
+		pos_type = COEX_SWITCH_TO_BT;
+		break;
+	case COEX_SET_ANT_INIT:
+		if (coex_stat->bt_disabled) {
+			/* set GNT_BT to SW low */
+			rtw_coex_set_gnt_bt(rtwdev, COEX_GNT_SET_SW_LOW);
+
+			/* set GNT_WL to SW high */
+			rtw_coex_set_gnt_wl(rtwdev, COEX_GNT_SET_SW_HIGH);
+		} else {
+			/* set GNT_BT to SW high */
+			rtw_coex_set_gnt_bt(rtwdev, COEX_GNT_SET_SW_HIGH);
+
+			/* set GNT_WL to SW low */
+			rtw_coex_set_gnt_wl(rtwdev, COEX_GNT_SET_SW_LOW);
+		}
+
+		/* set path control owner to wl at initial step */
+		rtw_coex_coex_ctrl_owner(rtwdev, true);
+
+		ctrl_type = COEX_SWITCH_CTRL_BY_BBSW;
+		pos_type = COEX_SWITCH_TO_BT;
+		break;
+	case COEX_SET_ANT_WONLY:
+		/* set GNT_BT to SW Low */
+		rtw_coex_set_gnt_bt(rtwdev, COEX_GNT_SET_SW_LOW);
+
+		/* Set GNT_WL to SW high */
+		rtw_coex_set_gnt_wl(rtwdev, COEX_GNT_SET_SW_HIGH);
+
+		/* set path control owner to wl at initial step */
+		rtw_coex_coex_ctrl_owner(rtwdev, true);
+
+		ctrl_type = COEX_SWITCH_CTRL_BY_BBSW;
+		pos_type = COEX_SWITCH_TO_WLG;
+		break;
+	case COEX_SET_ANT_WOFF:
+		/* set path control owner to BT */
+		rtw_coex_coex_ctrl_owner(rtwdev, false);
+
+		ctrl_type = COEX_SWITCH_CTRL_BY_BT;
+		pos_type = COEX_SWITCH_TO_NOCARE;
+		break;
+	case COEX_SET_ANT_2G:
+		/* set GNT_BT to PTA */
+		rtw_coex_set_gnt_bt(rtwdev, COEX_GNT_SET_HW_PTA);
+
+		/* set GNT_WL to PTA */
+		rtw_coex_set_gnt_wl(rtwdev, COEX_GNT_SET_HW_PTA);
+
+		/* set path control owner to wl at runtime step */
+		rtw_coex_coex_ctrl_owner(rtwdev, true);
+
+		ctrl_type = COEX_SWITCH_CTRL_BY_PTA;
+		pos_type = COEX_SWITCH_TO_NOCARE;
+		break;
+	case COEX_SET_ANT_5G:
+		/* set GNT_BT to PTA */
+		rtw_coex_set_gnt_bt(rtwdev, COEX_GNT_SET_SW_HIGH);
+
+		/* set GNT_WL to SW high */
+		rtw_coex_set_gnt_wl(rtwdev, COEX_GNT_SET_SW_HIGH);
+
+		/* set path control owner to wl at runtime step */
+		rtw_coex_coex_ctrl_owner(rtwdev, true);
+
+		ctrl_type = COEX_SWITCH_CTRL_BY_BBSW;
+		pos_type = COEX_SWITCH_TO_WLA;
+		break;
+	case COEX_SET_ANT_2G_FREERUN:
+		/* set GNT_BT to SW high */
+		rtw_coex_set_gnt_bt(rtwdev, COEX_GNT_SET_SW_HIGH);
+
+		/* Set GNT_WL to SW high */
+		rtw_coex_set_gnt_wl(rtwdev, COEX_GNT_SET_SW_HIGH);
+
+		/* set path control owner to wl at runtime step */
+		rtw_coex_coex_ctrl_owner(rtwdev, true);
+
+		ctrl_type = COEX_SWITCH_CTRL_BY_BBSW;
+		pos_type = COEX_SWITCH_TO_WLG_BT;
+		break;
+	case COEX_SET_ANT_2G_WLBT:
+		/* set GNT_BT to SW high */
+		rtw_coex_set_gnt_bt(rtwdev, COEX_GNT_SET_HW_PTA);
+
+		/* Set GNT_WL to SW high */
+		rtw_coex_set_gnt_wl(rtwdev, COEX_GNT_SET_HW_PTA);
+
+		/* set path control owner to wl at runtime step */
+		rtw_coex_coex_ctrl_owner(rtwdev, true);
+
+		ctrl_type = COEX_SWITCH_CTRL_BY_BBSW;
+		pos_type = COEX_SWITCH_TO_WLG_BT;
+		break;
+	default:
+		WARN_ON("unknown phase when setting antenna path\n");
+		return;
+	}
+
+	if (ctrl_type < COEX_SWITCH_CTRL_MAX && pos_type < COEX_SWITCH_TO_MAX)
+		rtw_coex_set_ant_switch(rtwdev, ctrl_type, pos_type);
+}
+
+static u8 rtw_coex_algorithm(struct rtw_dev *rtwdev)
+{
+	struct rtw_coex *coex = &rtwdev->coex;
+	struct rtw_coex_stat *coex_stat = &coex->stat;
+	u8 algorithm = COEX_ALGO_NOPROFILE;
+	u8 profile_map = 0;
+
+	if (coex_stat->bt_hfp_exist)
+		profile_map |= BPM_HFP;
+	if (coex_stat->bt_hid_exist)
+		profile_map |= BPM_HID;
+	if (coex_stat->bt_a2dp_exist)
+		profile_map |= BPM_A2DP;
+	if (coex_stat->bt_pan_exist)
+		profile_map |= BPM_PAN;
+
+	switch (profile_map) {
+	case BPM_HFP:
+		algorithm = COEX_ALGO_HFP;
+		break;
+	case           BPM_HID:
+	case BPM_HFP + BPM_HID:
+		algorithm = COEX_ALGO_HID;
+		break;
+	case BPM_HFP           + BPM_A2DP:
+	case           BPM_HID + BPM_A2DP:
+	case BPM_HFP + BPM_HID + BPM_A2DP:
+		algorithm = COEX_ALGO_A2DP_HID;
+		break;
+	case BPM_HFP                      + BPM_PAN:
+	case           BPM_HID            + BPM_PAN:
+	case BPM_HFP + BPM_HID            + BPM_PAN:
+		algorithm = COEX_ALGO_PAN_HID;
+		break;
+	case BPM_HFP           + BPM_A2DP + BPM_PAN:
+	case           BPM_HID + BPM_A2DP + BPM_PAN:
+	case BPM_HFP + BPM_HID + BPM_A2DP + BPM_PAN:
+		algorithm = COEX_ALGO_A2DP_PAN_HID;
+		break;
+	case                                BPM_PAN:
+		algorithm = COEX_ALGO_PAN;
+		break;
+	case                     BPM_A2DP + BPM_PAN:
+		algorithm = COEX_ALGO_A2DP_PAN;
+		break;
+	case                     BPM_A2DP:
+		if (coex_stat->bt_multi_link) {
+			if (coex_stat->bt_hid_pair_num > 0)
+				algorithm = COEX_ALGO_A2DP_HID;
+			else
+				algorithm = COEX_ALGO_A2DP_PAN;
+		} else {
+			algorithm = COEX_ALGO_A2DP;
+		}
+		break;
+	default:
+		algorithm = COEX_ALGO_NOPROFILE;
+		break;
+	}
+
+	return algorithm;
+}
+
+static void rtw_coex_action_coex_all_off(struct rtw_dev *rtwdev)
+{
+	struct rtw_efuse *efuse = &rtwdev->efuse;
+	struct rtw_chip_info *chip = rtwdev->chip;
+	u8 table_case, tdma_case;
+
+	if (efuse->share_ant) {
+		/* Shared-Ant */
+		table_case = 2;
+		tdma_case = 0;
+	} else {
+		/* Non-Shared-Ant */
+		table_case = 100;
+		tdma_case = 100;
+	}
+
+	rtw_coex_set_rf_para(rtwdev, chip->wl_rf_para_rx[0]);
+	rtw_coex_table(rtwdev, table_case);
+	rtw_coex_tdma(rtwdev, false, tdma_case);
+}
+
+static void rtw_coex_action_freerun(struct rtw_dev *rtwdev)
+{
+	struct rtw_coex *coex = &rtwdev->coex;
+	struct rtw_coex_stat *coex_stat = &coex->stat;
+	struct rtw_coex_dm *coex_dm = &coex->dm;
+	struct rtw_efuse *efuse = &rtwdev->efuse;
+	struct rtw_chip_info *chip = rtwdev->chip;
+	u8 level = 0;
+
+	if (efuse->share_ant)
+		return;
+
+	coex->freerun = true;
+
+	if (coex_stat->wl_connected)
+		rtw_coex_update_wl_ch_info(rtwdev, COEX_MEDIA_CONNECT);
+
+	rtw_coex_set_ant_path(rtwdev, false, COEX_SET_ANT_2G_FREERUN);
+
+	rtw_coex_write_scbd(rtwdev, COEX_SCBD_FIX2M, false);
+
+	if (COEX_RSSI_HIGH(coex_dm->wl_rssi_state[0]))
+		level = 2;
+	else if (COEX_RSSI_HIGH(coex_dm->wl_rssi_state[1]))
+		level = 3;
+	else if (COEX_RSSI_HIGH(coex_dm->wl_rssi_state[2]))
+		level = 4;
+	else
+		level = 5;
+
+	if (level > chip->wl_rf_para_num - 1)
+		level = chip->wl_rf_para_num - 1;
+
+	if (coex_stat->wl_tput_dir == COEX_WL_TPUT_TX)
+		rtw_coex_set_rf_para(rtwdev, chip->wl_rf_para_tx[level]);
+	else
+		rtw_coex_set_rf_para(rtwdev, chip->wl_rf_para_rx[level]);
+
+	rtw_coex_table(rtwdev, 100);
+	rtw_coex_tdma(rtwdev, false, 100);
+}
+
+static void rtw_coex_action_bt_whql_test(struct rtw_dev *rtwdev)
+{
+	struct rtw_efuse *efuse = &rtwdev->efuse;
+	struct rtw_chip_info *chip = rtwdev->chip;
+	u8 table_case, tdma_case;
+
+	if (efuse->share_ant) {
+		/* Shared-Ant */
+		table_case = 2;
+		tdma_case = 0;
+	} else {
+		/* Non-Shared-Ant */
+		table_case = 100;
+		tdma_case = 100;
+	}
+
+	rtw_coex_set_ant_path(rtwdev, false, COEX_SET_ANT_2G);
+	rtw_coex_set_rf_para(rtwdev, chip->wl_rf_para_rx[0]);
+	rtw_coex_table(rtwdev, table_case);
+	rtw_coex_tdma(rtwdev, false, tdma_case);
+}
+
+static void rtw_coex_action_bt_relink(struct rtw_dev *rtwdev)
+{
+	struct rtw_efuse *efuse = &rtwdev->efuse;
+	struct rtw_chip_info *chip = rtwdev->chip;
+	u8 table_case, tdma_case;
+
+	if (efuse->share_ant) {
+		/* Shared-Ant */
+		table_case = 1;
+		tdma_case = 0;
+	} else {
+		/* Non-Shared-Ant */
+		table_case = 100;
+		tdma_case = 100;
+	}
+
+	rtw_coex_set_ant_path(rtwdev, false, COEX_SET_ANT_2G);
+	rtw_coex_set_rf_para(rtwdev, chip->wl_rf_para_rx[0]);
+	rtw_coex_table(rtwdev, table_case);
+	rtw_coex_tdma(rtwdev, false, tdma_case);
+}
+
+static void rtw_coex_action_bt_idle(struct rtw_dev *rtwdev)
+{
+	struct rtw_coex *coex = &rtwdev->coex;
+	struct rtw_coex_stat *coex_stat = &coex->stat;
+	struct rtw_coex_dm *coex_dm = &coex->dm;
+	struct rtw_efuse *efuse = &rtwdev->efuse;
+	struct rtw_chip_info *chip = rtwdev->chip;
+	struct rtw_coex_rfe *coex_rfe = &coex->rfe;
+	u8 table_case = 0xff, tdma_case = 0xff;
+
+	if (coex_rfe->ant_switch_with_bt &&
+	    coex_dm->bt_status == COEX_BTSTATUS_NCON_IDLE) {
+		if (efuse->share_ant &&
+		    COEX_RSSI_HIGH(coex_dm->wl_rssi_state[1])) {
+			table_case = 0;
+			tdma_case = 0;
+		} else if (!efuse->share_ant) {
+			table_case = 100;
+			tdma_case = 100;
+		}
+	}
+
+	if (table_case != 0xff && tdma_case != 0xff) {
+		rtw_coex_set_ant_path(rtwdev, false, COEX_SET_ANT_2G_FREERUN);
+		rtw_coex_table(rtwdev, table_case);
+		rtw_coex_tdma(rtwdev, false, tdma_case);
+		return;
+	}
+
+	rtw_coex_set_ant_path(rtwdev, false, COEX_SET_ANT_2G);
+
+	if (efuse->share_ant) {
+		/* Shared-Ant */
+		if (!coex_stat->wl_gl_busy) {
+			table_case = 10;
+			tdma_case = 3;
+		} else if (coex_dm->bt_status == COEX_BTSTATUS_NCON_IDLE) {
+			table_case = 6;
+			tdma_case = 7;
+		} else {
+			table_case = 12;
+			tdma_case = 7;
+		}
+	} else {
+		/* Non-Shared-Ant */
+		if (!coex_stat->wl_gl_busy) {
+			table_case = 112;
+			tdma_case = 104;
+		} else if ((coex_stat->bt_ble_scan_type & 0x2) &&
+			    coex_dm->bt_status == COEX_BTSTATUS_NCON_IDLE) {
+			table_case = 114;
+			tdma_case = 103;
+		} else {
+			table_case = 112;
+			tdma_case = 103;
+		}
+	}
+
+	rtw_coex_set_rf_para(rtwdev, chip->wl_rf_para_rx[0]);
+	rtw_coex_table(rtwdev, table_case);
+	rtw_coex_tdma(rtwdev, false, tdma_case);
+}
+
+static void rtw_coex_action_bt_inquiry(struct rtw_dev *rtwdev)
+{
+	struct rtw_coex *coex = &rtwdev->coex;
+	struct rtw_coex_stat *coex_stat = &coex->stat;
+	struct rtw_efuse *efuse = &rtwdev->efuse;
+	struct rtw_chip_info *chip = rtwdev->chip;
+	bool wl_hi_pri = false;
+	u8 table_case, tdma_case;
+
+	if (coex_stat->wl_linkscan_proc || coex_stat->wl_hi_pri_task1 ||
+	    coex_stat->wl_hi_pri_task2)
+		wl_hi_pri = true;
+
+	if (efuse->share_ant) {
+		/* Shared-Ant */
+		if (wl_hi_pri) {
+			table_case = 15;
+			if (coex_stat->bt_a2dp_exist &&
+			    !coex_stat->bt_pan_exist)
+				tdma_case = 11;
+			else if (coex_stat->wl_hi_pri_task1)
+				tdma_case = 6;
+			else if (!coex_stat->bt_page)
+				tdma_case = 8;
+			else
+				tdma_case = 9;
+		} else if (coex_stat->wl_connected) {
+			table_case = 10;
+			tdma_case = 10;
+		} else {
+			table_case = 1;
+			tdma_case = 0;
+		}
+	} else {
+		/* Non_Shared-Ant */
+		if (wl_hi_pri) {
+			table_case = 113;
+			if (coex_stat->bt_a2dp_exist &&
+			    !coex_stat->bt_pan_exist)
+				tdma_case = 111;
+			else if (coex_stat->wl_hi_pri_task1)
+				tdma_case = 106;
+			else if (!coex_stat->bt_page)
+				tdma_case = 108;
+			else
+				tdma_case = 109;
+		} else if (coex_stat->wl_connected) {
+			table_case = 101;
+			tdma_case = 110;
+		} else {
+			table_case = 100;
+			tdma_case = 100;
+		}
+	}
+
+	rtw_dbg(rtwdev, RTW_DBG_COEX, "coex: wifi hi(%d), bt page(%d)\n",
+		wl_hi_pri, coex_stat->bt_page);
+
+	rtw_coex_set_ant_path(rtwdev, false, COEX_SET_ANT_2G);
+	rtw_coex_set_rf_para(rtwdev, chip->wl_rf_para_rx[0]);
+	rtw_coex_table(rtwdev, table_case);
+	rtw_coex_tdma(rtwdev, false, tdma_case);
+}
+
+static void rtw_coex_action_bt_hfp(struct rtw_dev *rtwdev)
+{
+	struct rtw_coex *coex = &rtwdev->coex;
+	struct rtw_coex_stat *coex_stat = &coex->stat;
+	struct rtw_efuse *efuse = &rtwdev->efuse;
+	struct rtw_chip_info *chip = rtwdev->chip;
+	u8 table_case, tdma_case;
+
+	if (efuse->share_ant) {
+		/* Shared-Ant */
+		if (coex_stat->bt_multi_link) {
+			table_case = 10;
+			tdma_case = 17;
+		} else {
+			table_case = 10;
+			tdma_case = 5;
+		}
+	} else {
+		/* Non-Shared-Ant */
+		if (coex_stat->bt_multi_link) {
+			table_case = 112;
+			tdma_case = 117;
+		} else {
+			table_case = 105;
+			tdma_case = 100;
+		}
+	}
+
+	rtw_coex_set_ant_path(rtwdev, false, COEX_SET_ANT_2G);
+	rtw_coex_set_rf_para(rtwdev, chip->wl_rf_para_rx[0]);
+	rtw_coex_table(rtwdev, table_case);
+	rtw_coex_tdma(rtwdev, false, tdma_case);
+}
+
+static void rtw_coex_action_bt_hid(struct rtw_dev *rtwdev)
+{
+	struct rtw_coex *coex = &rtwdev->coex;
+	struct rtw_coex_stat *coex_stat = &coex->stat;
+	struct rtw_efuse *efuse = &rtwdev->efuse;
+	struct rtw_chip_info *chip = rtwdev->chip;
+	u8 table_case, tdma_case;
+	u32 wl_bw;
+
+	wl_bw = rtwdev->hal.current_band_width;
+
+	if (efuse->share_ant) {
+		/* Shared-Ant */
+		if (coex_stat->bt_ble_exist) {
+			/* RCU */
+			if (!coex_stat->wl_gl_busy)
+				table_case = 14;
+			else
+				table_case = 15;
+
+			if (coex_stat->bt_a2dp_active || wl_bw == 0)
+				tdma_case = 18;
+			else if (coex_stat->wl_gl_busy)
+				tdma_case = 8;
+			else
+				tdma_case = 4;
+		} else {
+			if (coex_stat->bt_a2dp_active || wl_bw == 0) {
+				table_case = 8;
+				tdma_case = 4;
+			} else {
+				/* for 4/18 HID */
+				if (coex_stat->bt_418_hid_exist &&
+				    coex_stat->wl_gl_busy)
+					table_case = 12;
+				else
+					table_case = 10;
+				tdma_case = 4;
+			}
+		}
+	} else {
+		/* Non-Shared-Ant */
+		if (coex_stat->bt_a2dp_active) {
+			table_case = 113;
+			tdma_case = 118;
+		} else if (coex_stat->bt_ble_exist) {
+			/* BLE */
+			table_case = 113;
+
+			if (coex_stat->wl_gl_busy)
+				tdma_case = 106;
+			else
+				tdma_case = 104;
+		} else {
+			table_case = 113;
+			tdma_case = 104;
+		}
+	}
+
+	rtw_coex_set_ant_path(rtwdev, false, COEX_SET_ANT_2G);
+	rtw_coex_set_rf_para(rtwdev, chip->wl_rf_para_rx[0]);
+	rtw_coex_table(rtwdev, table_case);
+	rtw_coex_tdma(rtwdev, false, tdma_case);
+}
+
+static void rtw_coex_action_bt_a2dp(struct rtw_dev *rtwdev)
+{
+	struct rtw_coex *coex = &rtwdev->coex;
+	struct rtw_coex_stat *coex_stat = &coex->stat;
+	struct rtw_coex_dm *coex_dm = &coex->dm;
+	struct rtw_efuse *efuse = &rtwdev->efuse;
+	struct rtw_chip_info *chip = rtwdev->chip;
+	u8 table_case, tdma_case;
+	u32 slot_type = 0;
+
+	if (efuse->share_ant) {
+		/* Shared-Ant */
+		if (coex_stat->wl_gl_busy && coex_stat->wl_noisy_level == 0)
+			table_case = 10;
+		else
+			table_case = 9;
+
+		slot_type = TDMA_4SLOT;
+
+		if (coex_stat->wl_gl_busy)
+			tdma_case = 13;
+		else
+			tdma_case = 14;
+	} else {
+		/* Non-Shared-Ant */
+		table_case = 112;
+
+		if (COEX_RSSI_HIGH(coex_dm->wl_rssi_state[1]))
+			tdma_case = 112;
+		else
+			tdma_case = 113;
+	}
+
+	rtw_coex_set_ant_path(rtwdev, false, COEX_SET_ANT_2G);
+	rtw_coex_set_rf_para(rtwdev, chip->wl_rf_para_rx[0]);
+	rtw_coex_table(rtwdev, table_case);
+	rtw_coex_tdma(rtwdev, false, tdma_case | slot_type);
+}
+
+static void rtw_coex_action_bt_a2dpsink(struct rtw_dev *rtwdev)
+{
+	struct rtw_coex *coex = &rtwdev->coex;
+	struct rtw_coex_stat *coex_stat = &coex->stat;
+	struct rtw_efuse *efuse = &rtwdev->efuse;
+	struct rtw_chip_info *chip = rtwdev->chip;
+	u8 table_case, tdma_case;
+	bool ap_enable = false;
+
+	if (efuse->share_ant) { /* Shared-Ant */
+		if (ap_enable) {
+			table_case = 2;
+			tdma_case = 0;
+		} else if (coex_stat->wl_gl_busy) {
+			table_case = 28;
+			tdma_case = 20;
+		} else {
+			table_case = 28;
+			tdma_case = 26;
+		}
+	} else { /* Non-Shared-Ant */
+		if (ap_enable) {
+			table_case = 100;
+			tdma_case = 100;
+		} else {
+			table_case = 119;
+			tdma_case = 120;
+		}
+	}
+
+	rtw_coex_set_ant_path(rtwdev, false, COEX_SET_ANT_2G);
+	rtw_coex_set_rf_para(rtwdev, chip->wl_rf_para_rx[0]);
+	rtw_coex_table(rtwdev, table_case);
+	rtw_coex_tdma(rtwdev, false, tdma_case);
+}
+
+static void rtw_coex_action_bt_pan(struct rtw_dev *rtwdev)
+{
+	struct rtw_coex *coex = &rtwdev->coex;
+	struct rtw_coex_stat *coex_stat = &coex->stat;
+	struct rtw_efuse *efuse = &rtwdev->efuse;
+	struct rtw_chip_info *chip = rtwdev->chip;
+	u8 table_case, tdma_case;
+
+	if (efuse->share_ant) {
+		/* Shared-Ant */
+		if (coex_stat->wl_gl_busy && coex_stat->wl_noisy_level == 0)
+			table_case = 14;
+		else
+			table_case = 10;
+
+		if (coex_stat->wl_gl_busy)
+			tdma_case = 17;
+		else
+			tdma_case = 19;
+	} else {
+		/* Non-Shared-Ant */
+		table_case = 112;
+
+		if (coex_stat->wl_gl_busy)
+			tdma_case = 117;
+		else
+			tdma_case = 119;
+	}
+
+	rtw_coex_set_ant_path(rtwdev, false, COEX_SET_ANT_2G);
+	rtw_coex_set_rf_para(rtwdev, chip->wl_rf_para_rx[0]);
+	rtw_coex_table(rtwdev, table_case);
+	rtw_coex_tdma(rtwdev, false, tdma_case);
+}
+
+static void rtw_coex_action_bt_a2dp_hid(struct rtw_dev *rtwdev)
+{
+	struct rtw_coex *coex = &rtwdev->coex;
+	struct rtw_coex_stat *coex_stat = &coex->stat;
+	struct rtw_coex_dm *coex_dm = &coex->dm;
+	struct rtw_efuse *efuse = &rtwdev->efuse;
+	struct rtw_chip_info *chip = rtwdev->chip;
+	u8 table_case, tdma_case;
+	u32 slot_type = 0;
+
+	if (efuse->share_ant) {
+		/* Shared-Ant */
+		if (coex_stat->bt_ble_exist)
+			table_case = 26;
+		else
+			table_case = 9;
+
+		if (coex_stat->wl_gl_busy) {
+			slot_type = TDMA_4SLOT;
+			tdma_case = 13;
+		} else {
+			tdma_case = 14;
+		}
+	} else {
+		/* Non-Shared-Ant */
+		if (coex_stat->bt_ble_exist)
+			table_case = 121;
+		else
+			table_case = 113;
+
+		if (COEX_RSSI_HIGH(coex_dm->wl_rssi_state[1]))
+			tdma_case = 112;
+		else
+			tdma_case = 113;
+	}
+
+	rtw_coex_set_ant_path(rtwdev, false, COEX_SET_ANT_2G);
+	rtw_coex_set_rf_para(rtwdev, chip->wl_rf_para_rx[0]);
+	rtw_coex_table(rtwdev, table_case);
+	rtw_coex_tdma(rtwdev, false, tdma_case | slot_type);
+}
+
+static void rtw_coex_action_bt_a2dp_pan(struct rtw_dev *rtwdev)
+{
+	struct rtw_coex *coex = &rtwdev->coex;
+	struct rtw_coex_stat *coex_stat = &coex->stat;
+	struct rtw_efuse *efuse = &rtwdev->efuse;
+	struct rtw_chip_info *chip = rtwdev->chip;
+	u8 table_case, tdma_case;
+
+	if (efuse->share_ant) {
+		/* Shared-Ant */
+		if (coex_stat->wl_gl_busy &&
+		    coex_stat->wl_noisy_level == 0)
+			table_case = 14;
+		else
+			table_case = 10;
+
+		if (coex_stat->wl_gl_busy)
+			tdma_case = 15;
+		else
+			tdma_case = 20;
+	} else {
+		/* Non-Shared-Ant */
+		table_case = 112;
+
+		if (coex_stat->wl_gl_busy)
+			tdma_case = 115;
+		else
+			tdma_case = 120;
+	}
+
+	rtw_coex_set_ant_path(rtwdev, false, COEX_SET_ANT_2G);
+	rtw_coex_set_rf_para(rtwdev, chip->wl_rf_para_rx[0]);
+	rtw_coex_table(rtwdev, table_case);
+	rtw_coex_tdma(rtwdev, false, tdma_case);
+}
+
+static void rtw_coex_action_bt_pan_hid(struct rtw_dev *rtwdev)
+{
+	struct rtw_coex *coex = &rtwdev->coex;
+	struct rtw_coex_stat *coex_stat = &coex->stat;
+	struct rtw_efuse *efuse = &rtwdev->efuse;
+	struct rtw_chip_info *chip = rtwdev->chip;
+	u8 table_case, tdma_case;
+
+	if (efuse->share_ant) {
+		/* Shared-Ant */
+		table_case = 9;
+
+		if (coex_stat->wl_gl_busy)
+			tdma_case = 18;
+		else
+			tdma_case = 19;
+	} else {
+		/* Non-Shared-Ant */
+		table_case = 113;
+
+		if (coex_stat->wl_gl_busy)
+			tdma_case = 117;
+		else
+			tdma_case = 119;
+	}
+
+	rtw_coex_set_ant_path(rtwdev, false, COEX_SET_ANT_2G);
+	rtw_coex_set_rf_para(rtwdev, chip->wl_rf_para_rx[0]);
+	rtw_coex_table(rtwdev, table_case);
+	rtw_coex_tdma(rtwdev, false, tdma_case);
+}
+
+static void rtw_coex_action_bt_a2dp_pan_hid(struct rtw_dev *rtwdev)
+{
+	struct rtw_coex *coex = &rtwdev->coex;
+	struct rtw_coex_stat *coex_stat = &coex->stat;
+	struct rtw_efuse *efuse = &rtwdev->efuse;
+	struct rtw_chip_info *chip = rtwdev->chip;
+	u8 table_case, tdma_case;
+
+	if (efuse->share_ant) {
+		/* Shared-Ant */
+		table_case = 10;
+
+		if (coex_stat->wl_gl_busy)
+			tdma_case = 15;
+		else
+			tdma_case = 20;
+	} else {
+		/* Non-Shared-Ant */
+		table_case = 113;
+
+		if (coex_stat->wl_gl_busy)
+			tdma_case = 115;
+		else
+			tdma_case = 120;
+	}
+
+	rtw_coex_set_ant_path(rtwdev, false, COEX_SET_ANT_2G);
+	rtw_coex_set_rf_para(rtwdev, chip->wl_rf_para_rx[0]);
+	rtw_coex_table(rtwdev, table_case);
+	rtw_coex_tdma(rtwdev, false, tdma_case);
+}
+
+static void rtw_coex_action_wl_under5g(struct rtw_dev *rtwdev)
+{
+	struct rtw_efuse *efuse = &rtwdev->efuse;
+	struct rtw_chip_info *chip = rtwdev->chip;
+	u8 table_case, tdma_case;
+
+	rtw_coex_write_scbd(rtwdev, COEX_SCBD_FIX2M, false);
+
+	if (efuse->share_ant) {
+		/* Shared-Ant */
+		table_case = 0;
+		tdma_case = 0;
+	} else {
+		/* Non-Shared-Ant */
+		table_case = 100;
+		tdma_case = 100;
+	}
+
+	rtw_coex_set_ant_path(rtwdev, true, COEX_SET_ANT_5G);
+	rtw_coex_set_rf_para(rtwdev, chip->wl_rf_para_rx[0]);
+	rtw_coex_table(rtwdev, table_case);
+	rtw_coex_tdma(rtwdev, false, tdma_case);
+}
+
+static void rtw_coex_action_wl_only(struct rtw_dev *rtwdev)
+{
+	struct rtw_efuse *efuse = &rtwdev->efuse;
+	struct rtw_chip_info *chip = rtwdev->chip;
+	u8 table_case, tdma_case;
+
+	if (efuse->share_ant) {
+		/* Shared-Ant */
+		table_case = 2;
+		tdma_case = 0;
+	} else {
+		/* Non-Shared-Ant */
+		table_case = 100;
+		tdma_case = 100;
+	}
+
+	rtw_coex_set_ant_path(rtwdev, true, COEX_SET_ANT_2G);
+	rtw_coex_set_rf_para(rtwdev, chip->wl_rf_para_rx[0]);
+	rtw_coex_table(rtwdev, table_case);
+	rtw_coex_tdma(rtwdev, false, tdma_case);
+}
+
+static void rtw_coex_action_wl_native_lps(struct rtw_dev *rtwdev)
+{
+	struct rtw_coex *coex = &rtwdev->coex;
+	struct rtw_efuse *efuse = &rtwdev->efuse;
+	struct rtw_chip_info *chip = rtwdev->chip;
+	u8 table_case, tdma_case;
+
+	if (coex->under_5g)
+		return;
+
+	if (efuse->share_ant) {
+		/* Shared-Ant */
+		table_case = 28;
+		tdma_case = 0;
+	} else {
+		/* Non-Shared-Ant */
+		table_case = 100;
+		tdma_case = 100;
+	}
+
+	rtw_coex_set_ant_path(rtwdev, true, COEX_SET_ANT_2G);
+	rtw_coex_set_rf_para(rtwdev, chip->wl_rf_para_rx[0]);
+	rtw_coex_table(rtwdev, table_case);
+	rtw_coex_tdma(rtwdev, false, tdma_case);
+}
+
+static void rtw_coex_action_wl_linkscan(struct rtw_dev *rtwdev)
+{
+	struct rtw_coex *coex = &rtwdev->coex;
+	struct rtw_coex_stat *coex_stat = &coex->stat;
+	struct rtw_efuse *efuse = &rtwdev->efuse;
+	struct rtw_chip_info *chip = rtwdev->chip;
+	u8 table_case, tdma_case;
+
+	if (efuse->share_ant) {
+		/* Shared-Ant */
+		if (coex_stat->bt_a2dp_exist) {
+			table_case = 9;
+			tdma_case = 11;
+		} else {
+			table_case = 9;
+			tdma_case = 7;
+		}
+	} else {
+		/* Non-Shared-Ant */
+		if (coex_stat->bt_a2dp_exist) {
+			table_case = 112;
+			tdma_case = 111;
+		} else {
+			table_case = 112;
+			tdma_case = 107;
+		}
+	}
+
+	rtw_coex_set_ant_path(rtwdev, true, COEX_SET_ANT_2G);
+	rtw_coex_set_rf_para(rtwdev, chip->wl_rf_para_rx[0]);
+	rtw_coex_table(rtwdev, table_case);
+	rtw_coex_tdma(rtwdev, false, tdma_case);
+}
+
+static void rtw_coex_action_wl_not_connected(struct rtw_dev *rtwdev)
+{
+	struct rtw_efuse *efuse = &rtwdev->efuse;
+	struct rtw_chip_info *chip = rtwdev->chip;
+	u8 table_case, tdma_case;
+
+	if (efuse->share_ant) {
+		/* Shared-Ant */
+		table_case = 1;
+		tdma_case = 0;
+	} else {
+		/* Non-Shared-Ant */
+		table_case = 100;
+		tdma_case = 100;
+	}
+
+	rtw_coex_set_ant_path(rtwdev, true, COEX_SET_ANT_2G);
+	rtw_coex_set_rf_para(rtwdev, chip->wl_rf_para_rx[0]);
+	rtw_coex_table(rtwdev, table_case);
+	rtw_coex_tdma(rtwdev, false, tdma_case);
+}
+
+static void rtw_coex_action_wl_connected(struct rtw_dev *rtwdev)
+{
+	struct rtw_coex *coex = &rtwdev->coex;
+	struct rtw_coex_stat *coex_stat = &coex->stat;
+	struct rtw_coex_dm *coex_dm = &coex->dm;
+	struct rtw_efuse *efuse = &rtwdev->efuse;
+	u8 algorithm;
+
+	/* Non-Shared-Ant */
+	if (!efuse->share_ant && coex_stat->wl_gl_busy &&
+	    COEX_RSSI_HIGH(coex_dm->wl_rssi_state[3]) &&
+	    COEX_RSSI_HIGH(coex_dm->bt_rssi_state[0])) {
+		rtw_coex_action_freerun(rtwdev);
+		return;
+	}
+
+	algorithm = rtw_coex_algorithm(rtwdev);
+
+	switch (algorithm) {
+	case COEX_ALGO_HFP:
+		rtw_coex_action_bt_hfp(rtwdev);
+		break;
+	case COEX_ALGO_HID:
+		rtw_coex_action_bt_hid(rtwdev);
+		break;
+	case COEX_ALGO_A2DP:
+		if (coex_stat->bt_a2dp_sink)
+			rtw_coex_action_bt_a2dpsink(rtwdev);
+		else
+			rtw_coex_action_bt_a2dp(rtwdev);
+		break;
+	case COEX_ALGO_PAN:
+		rtw_coex_action_bt_pan(rtwdev);
+		break;
+	case COEX_ALGO_A2DP_HID:
+		rtw_coex_action_bt_a2dp_hid(rtwdev);
+		break;
+	case COEX_ALGO_A2DP_PAN:
+		rtw_coex_action_bt_a2dp_pan(rtwdev);
+		break;
+	case COEX_ALGO_PAN_HID:
+		rtw_coex_action_bt_pan_hid(rtwdev);
+		break;
+	case COEX_ALGO_A2DP_PAN_HID:
+		rtw_coex_action_bt_a2dp_pan_hid(rtwdev);
+		break;
+	default:
+	case COEX_ALGO_NOPROFILE:
+		rtw_coex_action_bt_idle(rtwdev);
+		break;
+	}
+}
+
+static void rtw_coex_run_coex(struct rtw_dev *rtwdev, u8 reason)
+{
+	struct rtw_coex *coex = &rtwdev->coex;
+	struct rtw_coex_dm *coex_dm = &coex->dm;
+	struct rtw_coex_stat *coex_stat = &coex->stat;
+
+	lockdep_assert_held(&rtwdev->mutex);
+
+	coex_dm->reason = reason;
+
+	/* update wifi_link_info_ext variable */
+	rtw_coex_update_wl_link_info(rtwdev, reason);
+
+	rtw_coex_monitor_bt_enable(rtwdev);
+
+	if (coex->stop_dm)
+		return;
+
+	if (coex_stat->wl_under_ips)
+		return;
+
+	if (coex->freeze && !coex_stat->bt_setup_link)
+		return;
+
+	coex_stat->cnt_wl[COEX_CNT_WL_COEXRUN]++;
+	coex->freerun = false;
+
+	/* Pure-5G Coex Process */
+	if (coex->under_5g) {
+		coex_stat->wl_coex_mode = COEX_WLINK_5G;
+		rtw_coex_action_wl_under5g(rtwdev);
+		goto exit;
+	}
+
+	coex_stat->wl_coex_mode = COEX_WLINK_2G1PORT;
+	rtw_coex_write_scbd(rtwdev, COEX_SCBD_FIX2M, false);
+	if (coex_stat->bt_disabled) {
+		rtw_coex_action_wl_only(rtwdev);
+		goto exit;
+	}
+
+	if (coex_stat->wl_under_lps && !coex_stat->wl_force_lps_ctrl) {
+		rtw_coex_action_wl_native_lps(rtwdev);
+		goto exit;
+	}
+
+	if (coex_stat->bt_whck_test) {
+		rtw_coex_action_bt_whql_test(rtwdev);
+		goto exit;
+	}
+
+	if (coex_stat->bt_setup_link) {
+		rtw_coex_action_bt_relink(rtwdev);
+		goto exit;
+	}
+
+	if (coex_stat->bt_inq_page) {
+		rtw_coex_action_bt_inquiry(rtwdev);
+		goto exit;
+	}
+
+	if ((coex_dm->bt_status == COEX_BTSTATUS_NCON_IDLE ||
+	     coex_dm->bt_status == COEX_BTSTATUS_CON_IDLE) &&
+	     coex_stat->wl_connected) {
+		rtw_coex_action_bt_idle(rtwdev);
+		goto exit;
+	}
+
+	if (coex_stat->wl_linkscan_proc) {
+		rtw_coex_action_wl_linkscan(rtwdev);
+		goto exit;
+	}
+
+	if (coex_stat->wl_connected)
+		rtw_coex_action_wl_connected(rtwdev);
+	else
+		rtw_coex_action_wl_not_connected(rtwdev);
+
+exit:
+	rtw_coex_set_gnt_fix(rtwdev);
+	rtw_coex_limited_wl(rtwdev);
+}
+
+static void rtw_coex_init_coex_var(struct rtw_dev *rtwdev)
+{
+	struct rtw_coex *coex = &rtwdev->coex;
+	struct rtw_coex_stat *coex_stat = &coex->stat;
+	struct rtw_coex_dm *coex_dm = &coex->dm;
+	u8 i;
+
+	memset(coex_dm, 0, sizeof(*coex_dm));
+	memset(coex_stat, 0, sizeof(*coex_stat));
+
+	for (i = 0; i < COEX_CNT_WL_MAX; i++)
+		coex_stat->cnt_wl[i] = 0;
+
+	for (i = 0; i < COEX_CNT_BT_MAX; i++)
+		coex_stat->cnt_bt[i] = 0;
+
+	for (i = 0; i < ARRAY_SIZE(coex_dm->bt_rssi_state); i++)
+		coex_dm->bt_rssi_state[i] = COEX_RSSI_STATE_LOW;
+
+	for (i = 0; i < ARRAY_SIZE(coex_dm->wl_rssi_state); i++)
+		coex_dm->wl_rssi_state[i] = COEX_RSSI_STATE_LOW;
+
+	coex_stat->wl_coex_mode = COEX_WLINK_MAX;
+}
+
+static void __rtw_coex_init_hw_config(struct rtw_dev *rtwdev, bool wifi_only)
+{
+	struct rtw_coex *coex = &rtwdev->coex;
+
+	rtw_coex_init_coex_var(rtwdev);
+	rtw_coex_monitor_bt_enable(rtwdev);
+	rtw_coex_set_rfe_type(rtwdev);
+	rtw_coex_set_init(rtwdev);
+
+	/* set Tx response = Hi-Pri (ex: Transmitting ACK,BA,CTS) */
+	rtw_coex_set_wl_pri_mask(rtwdev, COEX_WLPRI_TX_RSP, 1);
+
+	/* set Tx beacon = Hi-Pri */
+	rtw_coex_set_wl_pri_mask(rtwdev, COEX_WLPRI_TX_BEACON, 1);
+
+	/* set Tx beacon queue = Hi-Pri */
+	rtw_coex_set_wl_pri_mask(rtwdev, COEX_WLPRI_TX_BEACONQ, 1);
+
+	/* antenna config */
+	if (coex->wl_rf_off) {
+		rtw_coex_set_ant_path(rtwdev, true, COEX_SET_ANT_WOFF);
+		rtw_coex_write_scbd(rtwdev, COEX_SCBD_ALL, false);
+		coex->stop_dm = true;
+	} else if (wifi_only) {
+		rtw_coex_set_ant_path(rtwdev, true, COEX_SET_ANT_WONLY);
+		rtw_coex_write_scbd(rtwdev, COEX_SCBD_ACTIVE | COEX_SCBD_SCAN,
+				    true);
+		coex->stop_dm = true;
+	} else {
+		rtw_coex_set_ant_path(rtwdev, true, COEX_SET_ANT_INIT);
+		rtw_coex_write_scbd(rtwdev, COEX_SCBD_ACTIVE | COEX_SCBD_SCAN,
+				    true);
+		coex->stop_dm = false;
+		coex->freeze = true;
+	}
+
+	/* PTA parameter */
+	rtw_coex_table(rtwdev, 0);
+	rtw_coex_tdma(rtwdev, true, 0);
+	rtw_coex_query_bt_info(rtwdev);
+}
+
+void rtw_coex_power_on_setting(struct rtw_dev *rtwdev)
+{
+	struct rtw_coex *coex = &rtwdev->coex;
+
+	coex->stop_dm = true;
+	coex->wl_rf_off = false;
+
+	/* enable BB, we can write 0x948 */
+	rtw_write8_set(rtwdev, REG_SYS_FUNC_EN, BIT(0) | BIT(1));
+
+	rtw_coex_monitor_bt_enable(rtwdev);
+	rtw_coex_set_rfe_type(rtwdev);
+
+	/* set antenna path to BT */
+	rtw_coex_set_ant_path(rtwdev, true, COEX_SET_ANT_POWERON);
+
+	/* red x issue */
+	rtw_write8(rtwdev, 0xff1a, 0x0);
+}
+
+void rtw_coex_init_hw_config(struct rtw_dev *rtwdev, bool wifi_only)
+{
+	__rtw_coex_init_hw_config(rtwdev, wifi_only);
+}
+
+void rtw_coex_ips_notify(struct rtw_dev *rtwdev, u8 type)
+{
+	struct rtw_coex *coex = &rtwdev->coex;
+	struct rtw_coex_stat *coex_stat = &coex->stat;
+
+	if (coex->stop_dm)
+		return;
+
+	if (type == COEX_IPS_ENTER) {
+		coex_stat->wl_under_ips = true;
+
+		/* for lps off */
+		rtw_coex_write_scbd(rtwdev, COEX_SCBD_ALL, false);
+
+		rtw_coex_set_ant_path(rtwdev, true, COEX_SET_ANT_WOFF);
+		rtw_coex_action_coex_all_off(rtwdev);
+	} else if (type == COEX_IPS_LEAVE) {
+		rtw_coex_write_scbd(rtwdev, COEX_SCBD_ACTIVE | COEX_SCBD_ONOFF, true);
+
+		/* run init hw config (exclude wifi only) */
+		__rtw_coex_init_hw_config(rtwdev, false);
+		/* sw all off */
+
+		coex_stat->wl_under_ips = false;
+	}
+}
+
+void rtw_coex_lps_notify(struct rtw_dev *rtwdev, u8 type)
+{
+	struct rtw_coex *coex = &rtwdev->coex;
+	struct rtw_coex_stat *coex_stat = &coex->stat;
+
+	if (coex->stop_dm)
+		return;
+
+	if (type == COEX_LPS_ENABLE) {
+		coex_stat->wl_under_lps = true;
+
+		if (coex_stat->wl_force_lps_ctrl) {
+			/* for ps-tdma */
+			rtw_coex_write_scbd(rtwdev, COEX_SCBD_ACTIVE, true);
+		} else {
+			/* for native ps */
+			rtw_coex_write_scbd(rtwdev, COEX_SCBD_ACTIVE, false);
+
+			rtw_coex_run_coex(rtwdev, COEX_RSN_LPS);
+		}
+	} else if (type == COEX_LPS_DISABLE) {
+		coex_stat->wl_under_lps = false;
+
+		/* for lps off */
+		rtw_coex_write_scbd(rtwdev, COEX_SCBD_ACTIVE, true);
+
+		if (!coex_stat->wl_force_lps_ctrl)
+			rtw_coex_query_bt_info(rtwdev);
+	}
+}
+
+void rtw_coex_scan_notify(struct rtw_dev *rtwdev, u8 type)
+{
+	struct rtw_coex *coex = &rtwdev->coex;
+	struct rtw_coex_stat *coex_stat = &coex->stat;
+
+	if (coex->stop_dm)
+		return;
+
+	coex->freeze = false;
+
+	if (type != COEX_SCAN_FINISH)
+		rtw_coex_write_scbd(rtwdev, COEX_SCBD_ACTIVE | COEX_SCBD_SCAN |
+				    COEX_SCBD_ONOFF, true);
+
+	if (type == COEX_SCAN_START_5G) {
+		rtw_coex_set_ant_path(rtwdev, true, COEX_SET_ANT_5G);
+		rtw_coex_run_coex(rtwdev, COEX_RSN_5GSCANSTART);
+	} else if ((type == COEX_SCAN_START_2G) || (type == COEX_SCAN_START)) {
+		coex_stat->wl_hi_pri_task2 = true;
+
+		/* Force antenna setup for no scan result issue */
+		rtw_coex_set_ant_path(rtwdev, true, COEX_SET_ANT_2G);
+		rtw_coex_run_coex(rtwdev, COEX_RSN_2GSCANSTART);
+	} else {
+		coex_stat->wl_hi_pri_task2 = false;
+		rtw_coex_run_coex(rtwdev, COEX_RSN_SCANFINISH);
+	}
+}
+
+void rtw_coex_switchband_notify(struct rtw_dev *rtwdev, u8 type)
+{
+	struct rtw_coex *coex = &rtwdev->coex;
+
+	if (coex->stop_dm)
+		return;
+
+	if (type == COEX_SWITCH_TO_5G)
+		rtw_coex_run_coex(rtwdev, COEX_RSN_5GSWITCHBAND);
+	else if (type == COEX_SWITCH_TO_24G_NOFORSCAN)
+		rtw_coex_run_coex(rtwdev, COEX_RSN_2GSWITCHBAND);
+	else
+		rtw_coex_scan_notify(rtwdev, COEX_SCAN_START_2G);
+}
+
+void rtw_coex_connect_notify(struct rtw_dev *rtwdev, u8 type)
+{
+	struct rtw_coex *coex = &rtwdev->coex;
+	struct rtw_coex_stat *coex_stat = &coex->stat;
+
+	if (coex->stop_dm)
+		return;
+
+	rtw_coex_write_scbd(rtwdev, COEX_SCBD_ACTIVE | COEX_SCBD_SCAN |
+			    COEX_SCBD_ONOFF, true);
+
+	if (type == COEX_ASSOCIATE_5G_START) {
+		rtw_coex_set_ant_path(rtwdev, true, COEX_SET_ANT_5G);
+		rtw_coex_run_coex(rtwdev, COEX_RSN_5GCONSTART);
+	} else if (type == COEX_ASSOCIATE_5G_FINISH) {
+		rtw_coex_set_ant_path(rtwdev, true, COEX_SET_ANT_5G);
+		rtw_coex_run_coex(rtwdev, COEX_RSN_5GCONFINISH);
+	} else if (type == COEX_ASSOCIATE_START) {
+		coex_stat->wl_hi_pri_task1 = true;
+		coex_stat->cnt_wl[COEX_CNT_WL_CONNPKT] = 2;
+
+		/* Force antenna setup for no scan result issue */
+		rtw_coex_set_ant_path(rtwdev, true, COEX_SET_ANT_2G);
+
+		rtw_coex_run_coex(rtwdev, COEX_RSN_2GCONSTART);
+
+		/* To keep TDMA case during connect process,
+		 * to avoid changed by Btinfo and runcoexmechanism
+		 */
+		coex->freeze = true;
+		ieee80211_queue_delayed_work(rtwdev->hw, &coex->defreeze_work,
+					     5 * HZ);
+	} else {
+		coex_stat->wl_hi_pri_task1 = false;
+		coex->freeze = false;
+
+		rtw_coex_run_coex(rtwdev, COEX_RSN_2GCONFINISH);
+	}
+}
+
+void rtw_coex_media_status_notify(struct rtw_dev *rtwdev, u8 type)
+{
+	struct rtw_coex *coex = &rtwdev->coex;
+	struct rtw_coex_stat *coex_stat = &coex->stat;
+	u8 para[6] = {0};
+
+	if (coex->stop_dm)
+		return;
+
+	if (type == COEX_MEDIA_CONNECT_5G) {
+		rtw_coex_write_scbd(rtwdev, COEX_SCBD_ACTIVE, true);
+
+		rtw_coex_set_ant_path(rtwdev, true, COEX_SET_ANT_5G);
+		rtw_coex_run_coex(rtwdev, COEX_RSN_5GMEDIA);
+	} else if (type == COEX_MEDIA_CONNECT) {
+		rtw_coex_write_scbd(rtwdev, COEX_SCBD_ACTIVE, true);
+
+		/* Force antenna setup for no scan result issue */
+		rtw_coex_set_ant_path(rtwdev, true, COEX_SET_ANT_2G);
+
+		/* Set CCK Rx high Pri */
+		rtw_coex_set_wl_pri_mask(rtwdev, COEX_WLPRI_RX_CCK, 1);
+
+		/* always enable 5ms extend if connect */
+		para[0] = COEX_H2C69_WL_LEAKAP;
+		para[1] = PARA1_H2C69_EN_5MS; /* enable 5ms extend */
+		rtw_fw_bt_wifi_control(rtwdev, para[0], &para[1]);
+		coex_stat->wl_slot_extend = true;
+		rtw_coex_run_coex(rtwdev, COEX_RSN_2GMEDIA);
+	} else {
+		rtw_coex_write_scbd(rtwdev, COEX_SCBD_ACTIVE, false);
+
+		rtw_coex_set_wl_pri_mask(rtwdev, COEX_WLPRI_RX_CCK, 0);
+
+		rtw_coex_run_coex(rtwdev, COEX_RSN_MEDIADISCON);
+	}
+
+	rtw_coex_update_wl_ch_info(rtwdev, type);
+}
+
+void rtw_coex_bt_info_notify(struct rtw_dev *rtwdev, u8 *buf, u8 length)
+{
+	struct rtw_coex *coex = &rtwdev->coex;
+	struct rtw_coex_stat *coex_stat = &coex->stat;
+	struct rtw_chip_info *chip = rtwdev->chip;
+	unsigned long bt_relink_time;
+	u8 i, rsp_source = 0, type;
+
+	rsp_source = buf[0] & 0xf;
+	if (rsp_source >= COEX_BTINFO_SRC_MAX)
+		rsp_source = COEX_BTINFO_SRC_WL_FW;
+
+	if (rsp_source == COEX_BTINFO_SRC_BT_IQK) {
+		coex_stat->bt_iqk_state = buf[1];
+		if (coex_stat->bt_iqk_state == 1)
+			coex_stat->cnt_bt[COEX_CNT_BT_IQK]++;
+		else if (coex_stat->bt_iqk_state == 2)
+			coex_stat->cnt_bt[COEX_CNT_BT_IQKFAIL]++;
+
+		return;
+	}
+
+	if (rsp_source == COEX_BTINFO_SRC_BT_SCBD) {
+		rtw_coex_monitor_bt_enable(rtwdev);
+		if (coex_stat->bt_disabled != coex_stat->bt_disabled_pre) {
+			coex_stat->bt_disabled_pre = coex_stat->bt_disabled;
+			rtw_coex_run_coex(rtwdev, COEX_RSN_BTINFO);
+		}
+		return;
+	}
+
+	if (rsp_source == COEX_BTINFO_SRC_BT_RSP ||
+	    rsp_source == COEX_BTINFO_SRC_BT_ACT) {
+		if (coex_stat->bt_disabled) {
+			coex_stat->bt_disabled = false;
+			coex_stat->bt_reenable = true;
+			ieee80211_queue_delayed_work(rtwdev->hw,
+						     &coex->bt_reenable_work,
+						     15 * HZ);
+		}
+	}
+
+	for (i = 0; i < length; i++) {
+		if (i < COEX_BTINFO_LENGTH_MAX)
+			coex_stat->bt_info_c2h[rsp_source][i] = buf[i];
+		else
+			break;
+	}
+
+	if (rsp_source == COEX_BTINFO_SRC_WL_FW) {
+		rtw_coex_update_bt_link_info(rtwdev);
+		rtw_coex_run_coex(rtwdev, COEX_RSN_BTINFO);
+		return;
+	}
+
+	/* get the same info from bt, skip it */
+	if (coex_stat->bt_info_c2h[rsp_source][1] == coex_stat->bt_info_lb2 &&
+	    coex_stat->bt_info_c2h[rsp_source][2] == coex_stat->bt_info_lb3 &&
+	    coex_stat->bt_info_c2h[rsp_source][3] == coex_stat->bt_info_hb0 &&
+	    coex_stat->bt_info_c2h[rsp_source][4] == coex_stat->bt_info_hb1 &&
+	    coex_stat->bt_info_c2h[rsp_source][5] == coex_stat->bt_info_hb2 &&
+	    coex_stat->bt_info_c2h[rsp_source][6] == coex_stat->bt_info_hb3)
+		return;
+
+	coex_stat->bt_info_lb2 = coex_stat->bt_info_c2h[rsp_source][1];
+	coex_stat->bt_info_lb3 = coex_stat->bt_info_c2h[rsp_source][2];
+	coex_stat->bt_info_hb0 = coex_stat->bt_info_c2h[rsp_source][3];
+	coex_stat->bt_info_hb1 = coex_stat->bt_info_c2h[rsp_source][4];
+	coex_stat->bt_info_hb2 = coex_stat->bt_info_c2h[rsp_source][5];
+	coex_stat->bt_info_hb3 = coex_stat->bt_info_c2h[rsp_source][6];
+
+	/* 0xff means BT is under WHCK test */
+	coex_stat->bt_whck_test = (coex_stat->bt_info_lb2 == 0xff);
+	coex_stat->bt_inq_page = ((coex_stat->bt_info_lb2 & BIT(2)) == BIT(2));
+	coex_stat->bt_acl_busy = ((coex_stat->bt_info_lb2 & BIT(3)) == BIT(3));
+	coex_stat->cnt_bt[COEX_CNT_BT_RETRY] = coex_stat->bt_info_lb3 & 0xf;
+	if (coex_stat->cnt_bt[COEX_CNT_BT_RETRY] >= 1)
+		coex_stat->cnt_bt[COEX_CNT_BT_POPEVENT]++;
+
+	coex_stat->bt_fix_2M = ((coex_stat->bt_info_lb3 & BIT(4)) == BIT(4));
+	coex_stat->bt_inq = ((coex_stat->bt_info_lb3 & BIT(5)) == BIT(5));
+	if (coex_stat->bt_inq)
+		coex_stat->cnt_bt[COEX_CNT_BT_INQ]++;
+
+	coex_stat->bt_page = ((coex_stat->bt_info_lb3 & BIT(7)) == BIT(7));
+	if (coex_stat->bt_page) {
+		coex_stat->cnt_bt[COEX_CNT_BT_PAGE]++;
+		if (coex_stat->wl_linkscan_proc ||
+		    coex_stat->wl_hi_pri_task1 ||
+		    coex_stat->wl_hi_pri_task2 || coex_stat->wl_gl_busy)
+			rtw_coex_write_scbd(rtwdev, COEX_SCBD_SCAN, true);
+		else
+			rtw_coex_write_scbd(rtwdev, COEX_SCBD_SCAN, false);
+	} else {
+		rtw_coex_write_scbd(rtwdev, COEX_SCBD_SCAN, false);
+	}
+
+	/* unit: % (value-100 to translate to unit: dBm in coex info) */
+	if (chip->bt_rssi_type == COEX_BTRSSI_RATIO) {
+		coex_stat->bt_rssi = coex_stat->bt_info_hb0 * 2 + 10;
+	} else { /* original unit: dbm -> unit: % ->  value-100 in coex info */
+		if (coex_stat->bt_info_hb0 <= 127)
+			coex_stat->bt_rssi = 100;
+		else if (256 - coex_stat->bt_info_hb0 <= 100)
+			coex_stat->bt_rssi = 100 - (256 - coex_stat->bt_info_hb0);
+		else
+			coex_stat->bt_rssi = 0;
+	}
+
+	coex_stat->bt_ble_exist = ((coex_stat->bt_info_hb1 & BIT(0)) == BIT(0));
+	if (coex_stat->bt_info_hb1 & BIT(1))
+		coex_stat->cnt_bt[COEX_CNT_BT_REINIT]++;
+
+	if (coex_stat->bt_info_hb1 & BIT(2)) {
+		coex_stat->cnt_bt[COEX_CNT_BT_SETUPLINK]++;
+		coex_stat->bt_setup_link = true;
+		if (coex_stat->bt_reenable)
+			bt_relink_time = 6 * HZ;
+		else
+			bt_relink_time = 2 * HZ;
+
+		ieee80211_queue_delayed_work(rtwdev->hw,
+					     &coex->bt_relink_work,
+					     bt_relink_time);
+	}
+
+	if (coex_stat->bt_info_hb1 & BIT(3))
+		coex_stat->cnt_bt[COEX_CNT_BT_IGNWLANACT]++;
+
+	coex_stat->bt_ble_voice = ((coex_stat->bt_info_hb1 & BIT(4)) == BIT(4));
+	coex_stat->bt_ble_scan_en = ((coex_stat->bt_info_hb1 & BIT(5)) == BIT(5));
+	if (coex_stat->bt_info_hb1 & BIT(6))
+		coex_stat->cnt_bt[COEX_CNT_BT_ROLESWITCH]++;
+
+	coex_stat->bt_multi_link = ((coex_stat->bt_info_hb1 & BIT(7)) == BIT(7));
+	/* resend wifi info to bt, it is reset and lost the info */
+	if ((coex_stat->bt_info_hb1 & BIT(1))) {
+		if (coex_stat->wl_connected)
+			type = COEX_MEDIA_CONNECT;
+		else
+			type = COEX_MEDIA_DISCONNECT;
+		rtw_coex_update_wl_ch_info(rtwdev, type);
+	}
+
+	/* if ignore_wlan_act && not set_up_link */
+	if ((coex_stat->bt_info_hb1 & BIT(3)) &&
+	    (!(coex_stat->bt_info_hb1 & BIT(2))))
+		rtw_coex_ignore_wlan_act(rtwdev, false);
+
+	coex_stat->bt_opp_exist = ((coex_stat->bt_info_hb2 & BIT(0)) == BIT(0));
+	if (coex_stat->bt_info_hb2 & BIT(1))
+		coex_stat->cnt_bt[COEX_CNT_BT_AFHUPDATE]++;
+
+	coex_stat->bt_a2dp_active = (coex_stat->bt_info_hb2 & BIT(2)) == BIT(2);
+	coex_stat->bt_slave = ((coex_stat->bt_info_hb2 & BIT(3)) == BIT(3));
+	coex_stat->bt_hid_slot = (coex_stat->bt_info_hb2 & 0x30) >> 4;
+	coex_stat->bt_hid_pair_num = (coex_stat->bt_info_hb2 & 0xc0) >> 6;
+	if (coex_stat->bt_hid_pair_num > 0 && coex_stat->bt_hid_slot >= 2)
+		coex_stat->bt_418_hid_exist = true;
+	else if (coex_stat->bt_hid_pair_num == 0)
+		coex_stat->bt_418_hid_exist = false;
+
+	if ((coex_stat->bt_info_lb2 & 0x49) == 0x49)
+		coex_stat->bt_a2dp_bitpool = (coex_stat->bt_info_hb3 & 0x7f);
+	else
+		coex_stat->bt_a2dp_bitpool = 0;
+
+	coex_stat->bt_a2dp_sink = ((coex_stat->bt_info_hb3 & BIT(7)) == BIT(7));
+
+	rtw_coex_update_bt_link_info(rtwdev);
+	rtw_coex_run_coex(rtwdev, COEX_RSN_BTINFO);
+}
+
+void rtw_coex_wl_fwdbginfo_notify(struct rtw_dev *rtwdev, u8 *buf, u8 length)
+{
+	struct rtw_coex *coex = &rtwdev->coex;
+	struct rtw_coex_stat *coex_stat = &coex->stat;
+	u8 val;
+	int i;
+
+	if (WARN(length < 8, "invalid wl info c2h length\n"))
+		return;
+
+	if (buf[0] != 0x08)
+		return;
+
+	for (i = 1; i < 8; i++) {
+		val = coex_stat->wl_fw_dbg_info_pre[i];
+		if (buf[i] >= val)
+			coex_stat->wl_fw_dbg_info[i] = buf[i] - val;
+		else
+			coex_stat->wl_fw_dbg_info[i] = val - buf[i];
+
+		coex_stat->wl_fw_dbg_info_pre[i] = buf[i];
+	}
+
+	coex_stat->cnt_wl[COEX_CNT_WL_FW_NOTIFY]++;
+	rtw_coex_wl_ccklock_action(rtwdev);
+	rtw_coex_wl_ccklock_detect(rtwdev);
+}
+
+void rtw_coex_coex_dm_reset(struct rtw_dev *rtwdev)
+{
+	__rtw_coex_init_hw_config(rtwdev, false);
+}
+
+void rtw_coex_wl_status_change_notify(struct rtw_dev *rtwdev)
+{
+	struct rtw_coex *coex = &rtwdev->coex;
+
+	if (coex->stop_dm)
+		return;
+
+	rtw_coex_run_coex(rtwdev, COEX_RSN_WLSTATUS);
+}
+
+void rtw_coex_bt_relink_work(struct work_struct *work)
+{
+	struct rtw_dev *rtwdev = container_of(work, struct rtw_dev,
+					      coex.bt_relink_work.work);
+	struct rtw_coex_stat *coex_stat = &rtwdev->coex.stat;
+
+	mutex_lock(&rtwdev->mutex);
+	coex_stat->bt_setup_link = false;
+	rtw_coex_run_coex(rtwdev, COEX_RSN_WLSTATUS);
+	mutex_unlock(&rtwdev->mutex);
+}
+
+void rtw_coex_bt_reenable_work(struct work_struct *work)
+{
+	struct rtw_dev *rtwdev = container_of(work, struct rtw_dev,
+					      coex.bt_reenable_work.work);
+	struct rtw_coex_stat *coex_stat = &rtwdev->coex.stat;
+
+	mutex_lock(&rtwdev->mutex);
+	coex_stat->bt_reenable = false;
+	mutex_unlock(&rtwdev->mutex);
+}
+
+void rtw_coex_defreeze_work(struct work_struct *work)
+{
+	struct rtw_dev *rtwdev = container_of(work, struct rtw_dev,
+					      coex.defreeze_work.work);
+	struct rtw_coex *coex = &rtwdev->coex;
+	struct rtw_coex_stat *coex_stat = &rtwdev->coex.stat;
+
+	mutex_lock(&rtwdev->mutex);
+	coex->freeze = false;
+	coex_stat->wl_hi_pri_task1 = false;
+	rtw_coex_run_coex(rtwdev, COEX_RSN_WLSTATUS);
+	mutex_unlock(&rtwdev->mutex);
+}
diff --git a/drivers/net/wireless/realtek/rtw88/coex.h b/drivers/net/wireless/realtek/rtw88/coex.h
new file mode 100644
index 0000000..56e871b
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtw88/coex.h
@@ -0,0 +1,369 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/* Copyright(c) 2018-2019  Realtek Corporation
+ */
+
+#ifndef __RTW_COEX_H__
+#define __RTW_COEX_H__
+
+/* BT profile map bit definition */
+#define BPM_HFP		BIT(0)
+#define BPM_HID		BIT(1)
+#define BPM_A2DP		BIT(2)
+#define BPM_PAN		BIT(3)
+
+#define COEX_RESP_ACK_BY_WL_FW	0x1
+#define COEX_REQUEST_TIMEOUT	msecs_to_jiffies(10)
+
+#define COEX_MIN_DELAY		10 /* delay unit in ms */
+#define COEX_RFK_TIMEOUT	600 /* RFK timeout in ms */
+
+#define COEX_RF_OFF	0x0
+#define COEX_RF_ON	0x1
+
+#define COEX_H2C69_WL_LEAKAP	0xc
+#define PARA1_H2C69_DIS_5MS	0x1
+#define PARA1_H2C69_EN_5MS	0x0
+
+#define COEX_H2C69_TDMA_SLOT	0xb
+#define PARA1_H2C69_TDMA_4SLOT	0xc1
+#define PARA1_H2C69_TDMA_2SLOT	0x1
+
+#define TDMA_4SLOT	BIT(8)
+
+#define COEX_RSSI_STEP		4
+#define COEX_RSSI_HIGH(rssi) \
+	({ typeof(rssi) __rssi__ = rssi; \
+	   (__rssi__ == COEX_RSSI_STATE_HIGH || \
+	    __rssi__ == COEX_RSSI_STATE_STAY_HIGH ? true : false); })
+
+#define COEX_RSSI_MEDIUM(rssi) \
+	({ typeof(rssi) __rssi__ = rssi; \
+	   (__rssi__ == COEX_RSSI_STATE_MEDIUM || \
+	    __rssi__ == COEX_RSSI_STATE_STAY_MEDIUM ? true : false); })
+
+#define COEX_RSSI_LOW(rssi) \
+	({ typeof(rssi) __rssi__ = rssi; \
+	   (__rssi__ == COEX_RSSI_STATE_LOW || \
+	    __rssi__ == COEX_RSSI_STATE_STAY_LOW ? true : false); })
+
+#define GET_COEX_RESP_BT_SCAN_TYPE(payload)				\
+	le64_get_bits(*((__le64 *)(payload)), GENMASK(31, 24))
+
+enum coex_mp_info_op {
+	BT_MP_INFO_OP_PATCH_VER	= 0x00,
+	BT_MP_INFO_OP_READ_REG	= 0x11,
+	BT_MP_INFO_OP_SUPP_FEAT	= 0x2a,
+	BT_MP_INFO_OP_SUPP_VER	= 0x2b,
+	BT_MP_INFO_OP_SCAN_TYPE	= 0x2d,
+	BT_MP_INFO_OP_LNA_CONSTRAINT	= 0x32,
+};
+
+enum coex_set_ant_phase {
+	COEX_SET_ANT_INIT,
+	COEX_SET_ANT_WONLY,
+	COEX_SET_ANT_WOFF,
+	COEX_SET_ANT_2G,
+	COEX_SET_ANT_5G,
+	COEX_SET_ANT_POWERON,
+	COEX_SET_ANT_2G_WLBT,
+	COEX_SET_ANT_2G_FREERUN,
+
+	COEX_SET_ANT_MAX
+};
+
+enum coex_runreason {
+	COEX_RSN_2GSCANSTART	= 0,
+	COEX_RSN_5GSCANSTART	= 1,
+	COEX_RSN_SCANFINISH	= 2,
+	COEX_RSN_2GSWITCHBAND	= 3,
+	COEX_RSN_5GSWITCHBAND	= 4,
+	COEX_RSN_2GCONSTART	= 5,
+	COEX_RSN_5GCONSTART	= 6,
+	COEX_RSN_2GCONFINISH	= 7,
+	COEX_RSN_5GCONFINISH	= 8,
+	COEX_RSN_2GMEDIA	= 9,
+	COEX_RSN_5GMEDIA	= 10,
+	COEX_RSN_MEDIADISCON	= 11,
+	COEX_RSN_BTINFO		= 12,
+	COEX_RSN_LPS		= 13,
+	COEX_RSN_WLSTATUS	= 14,
+
+	COEX_RSN_MAX
+};
+
+enum coex_lte_coex_table_type {
+	COEX_CTT_WL_VS_LTE,
+	COEX_CTT_BT_VS_LTE,
+};
+
+enum coex_gnt_setup_state {
+	COEX_GNT_SET_HW_PTA	= 0x0,
+	COEX_GNT_SET_SW_LOW	= 0x1,
+	COEX_GNT_SET_SW_HIGH	= 0x3,
+};
+
+enum coex_ext_ant_switch_pos_type {
+	COEX_SWITCH_TO_BT,
+	COEX_SWITCH_TO_WLG,
+	COEX_SWITCH_TO_WLA,
+	COEX_SWITCH_TO_NOCARE,
+	COEX_SWITCH_TO_WLG_BT,
+
+	COEX_SWITCH_TO_MAX
+};
+
+enum coex_ext_ant_switch_ctrl_type {
+	COEX_SWITCH_CTRL_BY_BBSW,
+	COEX_SWITCH_CTRL_BY_PTA,
+	COEX_SWITCH_CTRL_BY_ANTDIV,
+	COEX_SWITCH_CTRL_BY_MAC,
+	COEX_SWITCH_CTRL_BY_BT,
+	COEX_SWITCH_CTRL_BY_FW,
+
+	COEX_SWITCH_CTRL_MAX
+};
+
+enum coex_algorithm {
+	COEX_ALGO_NOPROFILE	= 0,
+	COEX_ALGO_HFP		= 1,
+	COEX_ALGO_HID		= 2,
+	COEX_ALGO_A2DP		= 3,
+	COEX_ALGO_PAN		= 4,
+	COEX_ALGO_A2DP_HID	= 5,
+	COEX_ALGO_A2DP_PAN	= 6,
+	COEX_ALGO_PAN_HID	= 7,
+	COEX_ALGO_A2DP_PAN_HID	= 8,
+
+	COEX_ALGO_MAX
+};
+
+enum coex_wl_link_mode {
+	COEX_WLINK_2G1PORT	= 0x0,
+	COEX_WLINK_5G		= 0x3,
+	COEX_WLINK_MAX
+};
+
+enum coex_wl2bt_scoreboard {
+	COEX_SCBD_ACTIVE	= BIT(0),
+	COEX_SCBD_ONOFF		= BIT(1),
+	COEX_SCBD_SCAN		= BIT(2),
+	COEX_SCBD_UNDERTEST	= BIT(3),
+	COEX_SCBD_RXGAIN	= BIT(4),
+	COEX_SCBD_BT_RFK	= BIT(5),
+	COEX_SCBD_WLBUSY	= BIT(6),
+	COEX_SCBD_EXTFEM	= BIT(8),
+	COEX_SCBD_TDMA		= BIT(9),
+	COEX_SCBD_FIX2M		= BIT(10),
+	COEX_SCBD_ALL		= GENMASK(15, 0),
+};
+
+enum coex_power_save_type {
+	COEX_PS_WIFI_NATIVE	= 0,
+	COEX_PS_LPS_ON		= 1,
+	COEX_PS_LPS_OFF		= 2,
+};
+
+enum coex_rssi_state {
+	COEX_RSSI_STATE_HIGH,
+	COEX_RSSI_STATE_MEDIUM,
+	COEX_RSSI_STATE_LOW,
+	COEX_RSSI_STATE_STAY_HIGH,
+	COEX_RSSI_STATE_STAY_MEDIUM,
+	COEX_RSSI_STATE_STAY_LOW,
+};
+
+enum coex_notify_type_ips {
+	COEX_IPS_LEAVE		= 0x0,
+	COEX_IPS_ENTER		= 0x1,
+};
+
+enum coex_notify_type_lps {
+	COEX_LPS_DISABLE	= 0x0,
+	COEX_LPS_ENABLE		= 0x1,
+};
+
+enum coex_notify_type_scan {
+	COEX_SCAN_FINISH,
+	COEX_SCAN_START,
+	COEX_SCAN_START_2G,
+	COEX_SCAN_START_5G,
+};
+
+enum coex_notify_type_switchband {
+	COEX_NOT_SWITCH,
+	COEX_SWITCH_TO_24G,
+	COEX_SWITCH_TO_5G,
+	COEX_SWITCH_TO_24G_NOFORSCAN,
+};
+
+enum coex_notify_type_associate {
+	COEX_ASSOCIATE_FINISH,
+	COEX_ASSOCIATE_START,
+	COEX_ASSOCIATE_5G_FINISH,
+	COEX_ASSOCIATE_5G_START,
+};
+
+enum coex_notify_type_media_status {
+	COEX_MEDIA_DISCONNECT,
+	COEX_MEDIA_CONNECT,
+	COEX_MEDIA_CONNECT_5G,
+};
+
+enum coex_bt_status {
+	COEX_BTSTATUS_NCON_IDLE		= 0,
+	COEX_BTSTATUS_CON_IDLE		= 1,
+	COEX_BTSTATUS_INQ_PAGE		= 2,
+	COEX_BTSTATUS_ACL_BUSY		= 3,
+	COEX_BTSTATUS_SCO_BUSY		= 4,
+	COEX_BTSTATUS_ACL_SCO_BUSY	= 5,
+
+	COEX_BTSTATUS_MAX
+};
+
+enum coex_wl_tput_dir {
+	COEX_WL_TPUT_TX			= 0x0,
+	COEX_WL_TPUT_RX			= 0x1,
+	COEX_WL_TPUT_MAX
+};
+
+enum coex_wl_priority_mask {
+	COEX_WLPRI_RX_RSP	= 2,
+	COEX_WLPRI_TX_RSP	= 3,
+	COEX_WLPRI_TX_BEACON	= 4,
+	COEX_WLPRI_TX_OFDM	= 11,
+	COEX_WLPRI_TX_CCK	= 12,
+	COEX_WLPRI_TX_BEACONQ	= 27,
+	COEX_WLPRI_RX_CCK	= 28,
+	COEX_WLPRI_RX_OFDM	= 29,
+	COEX_WLPRI_MAX
+};
+
+enum coex_commom_chip_setup {
+	COEX_CSETUP_INIT_HW		= 0x0,
+	COEX_CSETUP_ANT_SWITCH		= 0x1,
+	COEX_CSETUP_GNT_FIX		= 0x2,
+	COEX_CSETUP_GNT_DEBUG		= 0x3,
+	COEX_CSETUP_RFE_TYPE		= 0x4,
+	COEX_CSETUP_COEXINFO_HW		= 0x5,
+	COEX_CSETUP_WL_TX_POWER		= 0x6,
+	COEX_CSETUP_WL_RX_GAIN		= 0x7,
+	COEX_CSETUP_WLAN_ACT_IPS	= 0x8,
+	COEX_CSETUP_MAX
+};
+
+enum coex_indirect_reg_type {
+	COEX_INDIRECT_1700		= 0x0,
+	COEX_INDIRECT_7C0		= 0x1,
+	COEX_INDIRECT_MAX
+};
+
+enum coex_pstdma_type {
+	COEX_PSTDMA_FORCE_LPSOFF	= 0x0,
+	COEX_PSTDMA_FORCE_LPSON		= 0x1,
+	COEX_PSTDMA_MAX
+};
+
+enum coex_btrssi_type {
+	COEX_BTRSSI_RATIO		= 0x0,
+	COEX_BTRSSI_DBM			= 0x1,
+	COEX_BTRSSI_MAX
+};
+
+struct coex_table_para {
+	u32 bt;
+	u32 wl;
+};
+
+struct coex_tdma_para {
+	u8 para[5];
+};
+
+struct coex_5g_afh_map {
+	u32 wl_5g_ch;
+	u8 bt_skip_ch;
+	u8 bt_skip_span;
+};
+
+struct coex_rf_para {
+	u8 wl_pwr_dec_lvl;
+	u8 bt_pwr_dec_lvl;
+	bool wl_low_gain_en;
+	u8 bt_lna_lvl;
+};
+
+static inline void rtw_coex_set_init(struct rtw_dev *rtwdev)
+{
+	struct rtw_chip_info *chip = rtwdev->chip;
+
+	chip->ops->coex_set_init(rtwdev);
+}
+
+static inline
+void rtw_coex_set_ant_switch(struct rtw_dev *rtwdev, u8 ctrl_type, u8 pos_type)
+{
+	struct rtw_chip_info *chip = rtwdev->chip;
+
+	if (!chip->ops->coex_set_ant_switch)
+		return;
+
+	chip->ops->coex_set_ant_switch(rtwdev, ctrl_type, pos_type);
+}
+
+static inline void rtw_coex_set_gnt_fix(struct rtw_dev *rtwdev)
+{
+	struct rtw_chip_info *chip = rtwdev->chip;
+
+	chip->ops->coex_set_gnt_fix(rtwdev);
+}
+
+static inline void rtw_coex_set_gnt_debug(struct rtw_dev *rtwdev)
+{
+	struct rtw_chip_info *chip = rtwdev->chip;
+
+	chip->ops->coex_set_gnt_debug(rtwdev);
+}
+
+static inline  void rtw_coex_set_rfe_type(struct rtw_dev *rtwdev)
+{
+	struct rtw_chip_info *chip = rtwdev->chip;
+
+	chip->ops->coex_set_rfe_type(rtwdev);
+}
+
+static inline void rtw_coex_set_wl_tx_power(struct rtw_dev *rtwdev, u8 wl_pwr)
+{
+	struct rtw_chip_info *chip = rtwdev->chip;
+
+	chip->ops->coex_set_wl_tx_power(rtwdev, wl_pwr);
+}
+
+static inline
+void rtw_coex_set_wl_rx_gain(struct rtw_dev *rtwdev, bool low_gain)
+{
+	struct rtw_chip_info *chip = rtwdev->chip;
+
+	chip->ops->coex_set_wl_rx_gain(rtwdev, low_gain);
+}
+
+void rtw_coex_info_response(struct rtw_dev *rtwdev, struct sk_buff *skb);
+void rtw_coex_write_indirect_reg(struct rtw_dev *rtwdev, u16 addr,
+				 u32 mask, u32 val);
+void rtw_coex_write_scbd(struct rtw_dev *rtwdev, u16 bitpos, bool set);
+
+void rtw_coex_bt_relink_work(struct work_struct *work);
+void rtw_coex_bt_reenable_work(struct work_struct *work);
+void rtw_coex_defreeze_work(struct work_struct *work);
+
+void rtw_coex_power_on_setting(struct rtw_dev *rtwdev);
+void rtw_coex_init_hw_config(struct rtw_dev *rtwdev, bool wifi_only);
+void rtw_coex_ips_notify(struct rtw_dev *rtwdev, u8 type);
+void rtw_coex_lps_notify(struct rtw_dev *rtwdev, u8 type);
+void rtw_coex_scan_notify(struct rtw_dev *rtwdev, u8 type);
+void rtw_coex_connect_notify(struct rtw_dev *rtwdev, u8 action);
+void rtw_coex_media_status_notify(struct rtw_dev *rtwdev, u8 status);
+void rtw_coex_bt_info_notify(struct rtw_dev *rtwdev, u8 *buf, u8 len);
+void rtw_coex_wl_fwdbginfo_notify(struct rtw_dev *rtwdev, u8 *buf, u8 length);
+void rtw_coex_switchband_notify(struct rtw_dev *rtwdev, u8 type);
+void rtw_coex_wl_status_change_notify(struct rtw_dev *rtwdev);
+
+#endif
diff --git a/drivers/net/wireless/realtek/rtw88/fw.c b/drivers/net/wireless/realtek/rtw88/fw.c
index 3b06f71..b082e2c 100644
--- a/drivers/net/wireless/realtek/rtw88/fw.c
+++ b/drivers/net/wireless/realtek/rtw88/fw.c
@@ -3,6 +3,7 @@
  */
 
 #include "main.h"
+#include "coex.h"
 #include "fw.h"
 #include "tx.h"
 #include "reg.h"
@@ -39,6 +40,12 @@ void rtw_fw_c2h_cmd_handle(struct rtw_dev *rtwdev, struct sk_buff *skb)
 	mutex_lock(&rtwdev->mutex);
 
 	switch (c2h->id) {
+	case C2H_BT_INFO:
+		rtw_coex_bt_info_notify(rtwdev, c2h->payload, len);
+		break;
+	case C2H_WLAN_INFO:
+		rtw_coex_wl_fwdbginfo_notify(rtwdev, c2h->payload, len);
+		break;
 	case C2H_HALMAC:
 		rtw_fw_c2h_cmd_handle_ext(rtwdev, skb);
 		break;
@@ -63,6 +70,9 @@ void rtw_fw_c2h_cmd_rx_irqsafe(struct rtw_dev *rtwdev, u32 pkt_offset,
 		c2h->id, c2h->seq, len);
 
 	switch (c2h->id) {
+	case C2H_BT_MP_INFO:
+		rtw_coex_info_response(rtwdev, skb);
+		break;
 	default:
 		/* pass offset for further operation */
 		*((u32 *)skb->cb) = pkt_offset;
@@ -206,6 +216,102 @@ void rtw_fw_do_iqk(struct rtw_dev *rtwdev, struct rtw_iqk_para *para)
 	rtw_fw_send_h2c_packet(rtwdev, h2c_pkt);
 }
 
+void rtw_fw_query_bt_info(struct rtw_dev *rtwdev)
+{
+	u8 h2c_pkt[H2C_PKT_SIZE] = {0};
+
+	SET_H2C_CMD_ID_CLASS(h2c_pkt, H2C_CMD_QUERY_BT_INFO);
+
+	SET_QUERY_BT_INFO(h2c_pkt, true);
+
+	rtw_fw_send_h2c_command(rtwdev, h2c_pkt);
+}
+
+void rtw_fw_wl_ch_info(struct rtw_dev *rtwdev, u8 link, u8 ch, u8 bw)
+{
+	u8 h2c_pkt[H2C_PKT_SIZE] = {0};
+
+	SET_H2C_CMD_ID_CLASS(h2c_pkt, H2C_CMD_WL_CH_INFO);
+
+	SET_WL_CH_INFO_LINK(h2c_pkt, link);
+	SET_WL_CH_INFO_CHNL(h2c_pkt, ch);
+	SET_WL_CH_INFO_BW(h2c_pkt, bw);
+
+	rtw_fw_send_h2c_command(rtwdev, h2c_pkt);
+}
+
+void rtw_fw_query_bt_mp_info(struct rtw_dev *rtwdev,
+			     struct rtw_coex_info_req *req)
+{
+	u8 h2c_pkt[H2C_PKT_SIZE] = {0};
+
+	SET_H2C_CMD_ID_CLASS(h2c_pkt, H2C_CMD_QUERY_BT_MP_INFO);
+
+	SET_BT_MP_INFO_SEQ(h2c_pkt, req->seq);
+	SET_BT_MP_INFO_OP_CODE(h2c_pkt, req->op_code);
+	SET_BT_MP_INFO_PARA1(h2c_pkt, req->para1);
+	SET_BT_MP_INFO_PARA2(h2c_pkt, req->para2);
+	SET_BT_MP_INFO_PARA3(h2c_pkt, req->para3);
+
+	rtw_fw_send_h2c_command(rtwdev, h2c_pkt);
+}
+
+void rtw_fw_force_bt_tx_power(struct rtw_dev *rtwdev, u8 bt_pwr_dec_lvl)
+{
+	u8 h2c_pkt[H2C_PKT_SIZE] = {0};
+	u8 index = 0 - bt_pwr_dec_lvl;
+
+	SET_H2C_CMD_ID_CLASS(h2c_pkt, H2C_CMD_FORCE_BT_TX_POWER);
+
+	SET_BT_TX_POWER_INDEX(h2c_pkt, index);
+
+	rtw_fw_send_h2c_command(rtwdev, h2c_pkt);
+}
+
+void rtw_fw_bt_ignore_wlan_action(struct rtw_dev *rtwdev, bool enable)
+{
+	u8 h2c_pkt[H2C_PKT_SIZE] = {0};
+
+	SET_H2C_CMD_ID_CLASS(h2c_pkt, H2C_CMD_IGNORE_WLAN_ACTION);
+
+	SET_IGNORE_WLAN_ACTION_EN(h2c_pkt, enable);
+
+	rtw_fw_send_h2c_command(rtwdev, h2c_pkt);
+}
+
+void rtw_fw_coex_tdma_type(struct rtw_dev *rtwdev,
+			   u8 para1, u8 para2, u8 para3, u8 para4, u8 para5)
+{
+	u8 h2c_pkt[H2C_PKT_SIZE] = {0};
+
+	SET_H2C_CMD_ID_CLASS(h2c_pkt, H2C_CMD_COEX_TDMA_TYPE);
+
+	SET_COEX_TDMA_TYPE_PARA1(h2c_pkt, para1);
+	SET_COEX_TDMA_TYPE_PARA2(h2c_pkt, para2);
+	SET_COEX_TDMA_TYPE_PARA3(h2c_pkt, para3);
+	SET_COEX_TDMA_TYPE_PARA4(h2c_pkt, para4);
+	SET_COEX_TDMA_TYPE_PARA5(h2c_pkt, para5);
+
+	rtw_fw_send_h2c_command(rtwdev, h2c_pkt);
+}
+
+void rtw_fw_bt_wifi_control(struct rtw_dev *rtwdev, u8 op_code, u8 *data)
+{
+	u8 h2c_pkt[H2C_PKT_SIZE] = {0};
+
+	SET_H2C_CMD_ID_CLASS(h2c_pkt, H2C_CMD_BT_WIFI_CONTROL);
+
+	SET_BT_WIFI_CONTROL_OP_CODE(h2c_pkt, op_code);
+
+	SET_BT_WIFI_CONTROL_DATA1(h2c_pkt, *data);
+	SET_BT_WIFI_CONTROL_DATA2(h2c_pkt, *(data + 1));
+	SET_BT_WIFI_CONTROL_DATA3(h2c_pkt, *(data + 2));
+	SET_BT_WIFI_CONTROL_DATA4(h2c_pkt, *(data + 3));
+	SET_BT_WIFI_CONTROL_DATA5(h2c_pkt, *(data + 4));
+
+	rtw_fw_send_h2c_command(rtwdev, h2c_pkt);
+}
+
 void rtw_fw_send_rssi_info(struct rtw_dev *rtwdev, struct rtw_sta_info *si)
 {
 	u8 h2c_pkt[H2C_PKT_SIZE] = {0};
diff --git a/drivers/net/wireless/realtek/rtw88/fw.h b/drivers/net/wireless/realtek/rtw88/fw.h
index 67f6cf7..e95d85b 100644
--- a/drivers/net/wireless/realtek/rtw88/fw.h
+++ b/drivers/net/wireless/realtek/rtw88/fw.h
@@ -35,7 +35,9 @@
 
 enum rtw_c2h_cmd_id {
 	C2H_BT_INFO = 0x09,
+	C2H_BT_MP_INFO = 0x0b,
 	C2H_HW_FEATURE_REPORT = 0x19,
+	C2H_WLAN_INFO = 0x27,
 	C2H_HW_FEATURE_DUMP = 0xfd,
 	C2H_HALMAC = 0xff,
 };
@@ -71,6 +73,14 @@ enum rtw_fw_rf_type {
 	FW_RF_MAX_TYPE = 0xF,
 };
 
+struct rtw_coex_info_req {
+	u8 seq;
+	u8 op_code;
+	u8 para1;
+	u8 para2;
+	u8 para3;
+};
+
 struct rtw_iqk_para {
 	u8 clear;
 	u8 segment_iqk;
@@ -139,6 +149,14 @@ static inline void rtw_h2c_pkt_set_header(u8 *h2c_pkt, u8 sub_id)
 #define H2C_CMD_RA_INFO			0x40
 #define H2C_CMD_RSSI_MONITOR		0x42
 
+#define H2C_CMD_COEX_TDMA_TYPE		0x60
+#define H2C_CMD_QUERY_BT_INFO		0x61
+#define H2C_CMD_FORCE_BT_TX_POWER	0x62
+#define H2C_CMD_IGNORE_WLAN_ACTION	0x63
+#define H2C_CMD_WL_CH_INFO		0x66
+#define H2C_CMD_QUERY_BT_MP_INFO	0x67
+#define H2C_CMD_BT_WIFI_CONTROL		0x69
+
 #define SET_H2C_CMD_ID_CLASS(h2c_pkt, value)				       \
 	le32p_replace_bits((__le32 *)(h2c_pkt) + 0x00, value, GENMASK(7, 0))
 
@@ -191,6 +209,50 @@ static inline void rtw_h2c_pkt_set_header(u8 *h2c_pkt, u8 sub_id)
 	le32p_replace_bits((__le32 *)(h2c_pkt) + 0x01, value, GENMASK(23, 16))
 #define SET_RA_INFO_RA_MASK3(h2c_pkt, value)                                   \
 	le32p_replace_bits((__le32 *)(h2c_pkt) + 0x01, value, GENMASK(31, 24))
+#define SET_QUERY_BT_INFO(h2c_pkt, value)                                      \
+	le32p_replace_bits((__le32 *)(h2c_pkt) + 0x00, value, BIT(8))
+#define SET_WL_CH_INFO_LINK(h2c_pkt, value)                                    \
+	le32p_replace_bits((__le32 *)(h2c_pkt) + 0x00, value, GENMASK(15, 8))
+#define SET_WL_CH_INFO_CHNL(h2c_pkt, value)                                    \
+	le32p_replace_bits((__le32 *)(h2c_pkt) + 0x00, value, GENMASK(23, 16))
+#define SET_WL_CH_INFO_BW(h2c_pkt, value)                                      \
+	le32p_replace_bits((__le32 *)(h2c_pkt) + 0x00, value, GENMASK(31, 24))
+#define SET_BT_MP_INFO_SEQ(h2c_pkt, value)                                     \
+	le32p_replace_bits((__le32 *)(h2c_pkt) + 0x00, value, GENMASK(15, 12))
+#define SET_BT_MP_INFO_OP_CODE(h2c_pkt, value)                                 \
+	le32p_replace_bits((__le32 *)(h2c_pkt) + 0x00, value, GENMASK(23, 16))
+#define SET_BT_MP_INFO_PARA1(h2c_pkt, value)                                   \
+	le32p_replace_bits((__le32 *)(h2c_pkt) + 0x00, value, GENMASK(31, 24))
+#define SET_BT_MP_INFO_PARA2(h2c_pkt, value)                                   \
+	le32p_replace_bits((__le32 *)(h2c_pkt) + 0x01, value, GENMASK(7, 0))
+#define SET_BT_MP_INFO_PARA3(h2c_pkt, value)                                   \
+	le32p_replace_bits((__le32 *)(h2c_pkt) + 0x01, value, GENMASK(15, 8))
+#define SET_BT_TX_POWER_INDEX(h2c_pkt, value)                                  \
+	le32p_replace_bits((__le32 *)(h2c_pkt) + 0x00, value, GENMASK(15, 8))
+#define SET_IGNORE_WLAN_ACTION_EN(h2c_pkt, value)                              \
+	le32p_replace_bits((__le32 *)(h2c_pkt) + 0x00, value, BIT(8))
+#define SET_COEX_TDMA_TYPE_PARA1(h2c_pkt, value)                               \
+	le32p_replace_bits((__le32 *)(h2c_pkt) + 0x00, value, GENMASK(15, 8))
+#define SET_COEX_TDMA_TYPE_PARA2(h2c_pkt, value)                               \
+	le32p_replace_bits((__le32 *)(h2c_pkt) + 0x00, value, GENMASK(23, 16))
+#define SET_COEX_TDMA_TYPE_PARA3(h2c_pkt, value)                               \
+	le32p_replace_bits((__le32 *)(h2c_pkt) + 0x00, value, GENMASK(31, 24))
+#define SET_COEX_TDMA_TYPE_PARA4(h2c_pkt, value)                               \
+	le32p_replace_bits((__le32 *)(h2c_pkt) + 0x01, value, GENMASK(7, 0))
+#define SET_COEX_TDMA_TYPE_PARA5(h2c_pkt, value)                               \
+	le32p_replace_bits((__le32 *)(h2c_pkt) + 0x01, value, GENMASK(15, 8))
+#define SET_BT_WIFI_CONTROL_OP_CODE(h2c_pkt, value)                            \
+	le32p_replace_bits((__le32 *)(h2c_pkt) + 0x00, value, GENMASK(15, 8))
+#define SET_BT_WIFI_CONTROL_DATA1(h2c_pkt, value)                              \
+	le32p_replace_bits((__le32 *)(h2c_pkt) + 0x00, value, GENMASK(23, 16))
+#define SET_BT_WIFI_CONTROL_DATA2(h2c_pkt, value)                              \
+	le32p_replace_bits((__le32 *)(h2c_pkt) + 0x00, value, GENMASK(31, 24))
+#define SET_BT_WIFI_CONTROL_DATA3(h2c_pkt, value)                              \
+	le32p_replace_bits((__le32 *)(h2c_pkt) + 0x01, value, GENMASK(7, 0))
+#define SET_BT_WIFI_CONTROL_DATA4(h2c_pkt, value)                              \
+	le32p_replace_bits((__le32 *)(h2c_pkt) + 0x01, value, GENMASK(15, 8))
+#define SET_BT_WIFI_CONTROL_DATA5(h2c_pkt, value)                              \
+	le32p_replace_bits((__le32 *)(h2c_pkt) + 0x01, value, GENMASK(23, 16))
 
 static inline struct rtw_c2h_cmd *get_c2h_from_skb(struct sk_buff *skb)
 {
@@ -208,6 +270,15 @@ void rtw_fw_send_phydm_info(struct rtw_dev *rtwdev);
 
 void rtw_fw_do_iqk(struct rtw_dev *rtwdev, struct rtw_iqk_para *para);
 void rtw_fw_set_pwr_mode(struct rtw_dev *rtwdev);
+void rtw_fw_query_bt_info(struct rtw_dev *rtwdev);
+void rtw_fw_wl_ch_info(struct rtw_dev *rtwdev, u8 link, u8 ch, u8 bw);
+void rtw_fw_query_bt_mp_info(struct rtw_dev *rtwdev,
+			     struct rtw_coex_info_req *req);
+void rtw_fw_force_bt_tx_power(struct rtw_dev *rtwdev, u8 bt_pwr_dec_lvl);
+void rtw_fw_bt_ignore_wlan_action(struct rtw_dev *rtwdev, bool enable);
+void rtw_fw_coex_tdma_type(struct rtw_dev *rtwdev,
+			   u8 para1, u8 para2, u8 para3, u8 para4, u8 para5);
+void rtw_fw_bt_wifi_control(struct rtw_dev *rtwdev, u8 op_code, u8 *data);
 void rtw_fw_send_rssi_info(struct rtw_dev *rtwdev, struct rtw_sta_info *si);
 void rtw_fw_send_ra_info(struct rtw_dev *rtwdev, struct rtw_sta_info *si);
 void rtw_fw_media_status_report(struct rtw_dev *rtwdev, u8 mac_id, bool conn);
diff --git a/drivers/net/wireless/realtek/rtw88/mac80211.c b/drivers/net/wireless/realtek/rtw88/mac80211.c
index abe6a14..fedea28 100644
--- a/drivers/net/wireless/realtek/rtw88/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw88/mac80211.c
@@ -7,6 +7,7 @@
 #include "tx.h"
 #include "fw.h"
 #include "mac.h"
+#include "coex.h"
 #include "ps.h"
 #include "reg.h"
 #include "debug.h"
@@ -253,6 +254,7 @@ static void rtw_ops_bss_info_changed(struct ieee80211_hw *hw,
 		enum rtw_net_type net_type;
 
 		if (conf->assoc) {
+			rtw_coex_connect_notify(rtwdev, COEX_ASSOCIATE_FINISH);
 			net_type = RTW_NET_MGD_LINKED;
 			chip->ops->do_iqk(rtwdev);
 
@@ -262,6 +264,7 @@ static void rtw_ops_bss_info_changed(struct ieee80211_hw *hw,
 			rtw_add_rsvd_page(rtwdev, RSVD_NULL, true);
 			rtw_fw_download_rsvd_page(rtwdev, vif);
 			rtw_send_rsvd_page_h2c(rtwdev);
+			rtw_coex_media_status_notify(rtwdev, conf->assoc);
 		} else {
 			net_type = RTW_NET_NO_LINK;
 			rtwvif->aid = 0;
@@ -469,6 +472,8 @@ static void rtw_ops_sw_scan_start(struct ieee80211_hw *hw,
 	config |= PORT_SET_MAC_ADDR;
 	rtw_vif_port_config(rtwdev, rtwvif, config);
 
+	rtw_coex_scan_notify(rtwdev, COEX_SCAN_START);
+
 	rtw_flag_set(rtwdev, RTW_FLAG_DIG_DISABLE);
 	rtw_flag_set(rtwdev, RTW_FLAG_SCANNING);
 
@@ -491,6 +496,19 @@ static void rtw_ops_sw_scan_complete(struct ieee80211_hw *hw,
 	config |= PORT_SET_MAC_ADDR;
 	rtw_vif_port_config(rtwdev, rtwvif, config);
 
+	rtw_coex_scan_notify(rtwdev, COEX_SCAN_FINISH);
+
+	mutex_unlock(&rtwdev->mutex);
+}
+
+static void rtw_ops_mgd_prepare_tx(struct ieee80211_hw *hw,
+				   struct ieee80211_vif *vif,
+				   u16 duration)
+{
+	struct rtw_dev *rtwdev = hw->priv;
+
+	mutex_lock(&rtwdev->mutex);
+	rtw_coex_connect_notify(rtwdev, COEX_ASSOCIATE_START);
 	mutex_unlock(&rtwdev->mutex);
 }
 
@@ -509,5 +527,6 @@ const struct ieee80211_ops rtw_ops = {
 	.ampdu_action		= rtw_ops_ampdu_action,
 	.sw_scan_start		= rtw_ops_sw_scan_start,
 	.sw_scan_complete	= rtw_ops_sw_scan_complete,
+	.mgd_prepare_tx		= rtw_ops_mgd_prepare_tx,
 };
 EXPORT_SYMBOL(rtw_ops);
diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index 5a2c062..e5a6bc0 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -8,6 +8,7 @@
 #include "ps.h"
 #include "sec.h"
 #include "mac.h"
+#include "coex.h"
 #include "phy.h"
 #include "reg.h"
 #include "efuse.h"
@@ -149,6 +150,7 @@ static void rtw_watch_dog_work(struct work_struct *work)
 	struct rtw_dev *rtwdev = container_of(work, struct rtw_dev,
 					      watch_dog_work.work);
 	struct rtw_watch_dog_iter_data data = {};
+	bool busy_traffic = rtw_flag_check(rtwdev, RTW_FLAG_BUSY_TRAFFIC);
 
 	if (!rtw_flag_check(rtwdev, RTW_FLAG_RUNNING))
 		return;
@@ -156,6 +158,14 @@ static void rtw_watch_dog_work(struct work_struct *work)
 	ieee80211_queue_delayed_work(rtwdev->hw, &rtwdev->watch_dog_work,
 				     RTW_WATCH_DOG_DELAY_TIME);
 
+	if (rtwdev->stats.tx_cnt > 100 || rtwdev->stats.rx_cnt > 100)
+		rtw_flag_set(rtwdev, RTW_FLAG_BUSY_TRAFFIC);
+	else
+		rtw_flag_clear(rtwdev, RTW_FLAG_BUSY_TRAFFIC);
+
+	if (busy_traffic != rtw_flag_check(rtwdev, RTW_FLAG_BUSY_TRAFFIC))
+		rtw_coex_wl_status_change_notify(rtwdev);
+
 	/* reset tx/rx statictics */
 	rtwdev->stats.tx_unicast = 0;
 	rtwdev->stats.rx_unicast = 0;
@@ -298,6 +308,15 @@ void rtw_set_channel(struct rtw_dev *rtwdev)
 
 	chip->ops->set_channel(rtwdev, center_chan, bandwidth, primary_chan_idx);
 
+	if (hal->current_band_type == RTW_BAND_5G) {
+		rtw_coex_switchband_notify(rtwdev, COEX_SWITCH_TO_5G);
+	} else {
+		if (rtw_flag_check(rtwdev, RTW_FLAG_SCANNING))
+			rtw_coex_switchband_notify(rtwdev, COEX_SWITCH_TO_24G);
+		else
+			rtw_coex_switchband_notify(rtwdev, COEX_SWITCH_TO_24G_NOFORSCAN);
+	}
+
 	rtw_phy_set_tx_power_level(rtwdev, center_chan);
 }
 
@@ -641,6 +660,7 @@ static int rtw_power_on(struct rtw_dev *rtwdev)
 {
 	struct rtw_chip_info *chip = rtwdev->chip;
 	struct rtw_fw_state *fw = &rtwdev->fw;
+	bool wifi_only;
 	int ret;
 
 	ret = rtw_hci_setup(rtwdev);
@@ -684,6 +704,10 @@ static int rtw_power_on(struct rtw_dev *rtwdev)
 		goto err_off;
 	}
 
+	wifi_only = !rtwdev->efuse.btcoex;
+	rtw_coex_power_on_setting(rtwdev);
+	rtw_coex_init_hw_config(rtwdev, wifi_only);
+
 	return 0;
 
 err_off:
@@ -722,10 +746,15 @@ static void rtw_power_off(struct rtw_dev *rtwdev)
 
 void rtw_core_stop(struct rtw_dev *rtwdev)
 {
+	struct rtw_coex *coex = &rtwdev->coex;
+
 	rtw_flag_clear(rtwdev, RTW_FLAG_RUNNING);
 	rtw_flag_clear(rtwdev, RTW_FLAG_FW_RUNNING);
 
 	cancel_delayed_work_sync(&rtwdev->watch_dog_work);
+	cancel_delayed_work_sync(&coex->bt_relink_work);
+	cancel_delayed_work_sync(&coex->bt_reenable_work);
+	cancel_delayed_work_sync(&coex->defreeze_work);
 
 	rtw_power_off(rtwdev);
 }
@@ -876,7 +905,6 @@ static int rtw_chip_parameter_setup(struct rtw_dev *rtwdev)
 	struct rtw_chip_info *chip = rtwdev->chip;
 	struct rtw_hal *hal = &rtwdev->hal;
 	struct rtw_efuse *efuse = &rtwdev->efuse;
-	u32 wl_bt_pwr_ctrl;
 	int ret = 0;
 
 	switch (rtw_hci_type(rtwdev)) {
@@ -888,9 +916,6 @@ static int rtw_chip_parameter_setup(struct rtw_dev *rtwdev)
 		return -EINVAL;
 	}
 
-	wl_bt_pwr_ctrl = rtw_read32(rtwdev, REG_WL_BT_PWR_CTRL);
-	if (wl_bt_pwr_ctrl & BIT_BT_FUNC_EN)
-		rtwdev->efuse.btcoex = true;
 	hal->chip_version = rtw_read32(rtwdev, REG_SYS_CFG1);
 	hal->fab_version = BIT_GET_VENDOR_ID(hal->chip_version) >> 2;
 	hal->cut_version = BIT_GET_CHIP_VER(hal->chip_version);
@@ -1044,11 +1069,14 @@ static int rtw_chip_efuse_info_setup(struct rtw_dev *rtwdev)
 		efuse->lna_type_5g = 0;
 	if (efuse->channel_plan == 0xff)
 		efuse->channel_plan = 0x7f;
+	if (efuse->rf_board_option == 0xff)
+		efuse->rf_board_option = 0;
 	if (efuse->bt_setting & BIT(0))
 		efuse->share_ant = true;
 	if (efuse->regd == 0xff)
 		efuse->regd = 0;
 
+	efuse->btcoex = (efuse->rf_board_option & 0xe0) == 0x20;
 	efuse->ext_pa_2g = efuse->pa_type_2g & BIT(4) ? 1 : 0;
 	efuse->ext_lna_2g = efuse->lna_type_2g & BIT(3) ? 1 : 0;
 	efuse->ext_pa_5g = efuse->pa_type_5g & BIT(0) ? 1 : 0;
@@ -1111,6 +1139,7 @@ EXPORT_SYMBOL(rtw_chip_info_setup);
 
 int rtw_core_init(struct rtw_dev *rtwdev)
 {
+	struct rtw_coex *coex = &rtwdev->coex;
 	int ret;
 
 	INIT_LIST_HEAD(&rtwdev->rsvd_page_list);
@@ -1120,8 +1149,12 @@ int rtw_core_init(struct rtw_dev *rtwdev)
 
 	INIT_DELAYED_WORK(&rtwdev->watch_dog_work, rtw_watch_dog_work);
 	INIT_DELAYED_WORK(&rtwdev->lps_work, rtw_lps_work);
+	INIT_DELAYED_WORK(&coex->bt_relink_work, rtw_coex_bt_relink_work);
+	INIT_DELAYED_WORK(&coex->bt_reenable_work, rtw_coex_bt_reenable_work);
+	INIT_DELAYED_WORK(&coex->defreeze_work, rtw_coex_defreeze_work);
 	INIT_WORK(&rtwdev->c2h_work, rtw_c2h_work);
 	skb_queue_head_init(&rtwdev->c2h_queue);
+	skb_queue_head_init(&rtwdev->coex.queue);
 	skb_queue_head_init(&rtwdev->tx_report.queue);
 
 	spin_lock_init(&rtwdev->dm_lock);
@@ -1130,8 +1163,11 @@ int rtw_core_init(struct rtw_dev *rtwdev)
 	spin_lock_init(&rtwdev->tx_report.q_lock);
 
 	mutex_init(&rtwdev->mutex);
+	mutex_init(&rtwdev->coex.mutex);
 	mutex_init(&rtwdev->hal.tx_power_mutex);
 
+	init_waitqueue_head(&rtwdev->coex.wait);
+
 	rtwdev->sec.total_cam_num = 32;
 	rtwdev->hal.current_channel = 1;
 	set_bit(RTW_BC_MC_MACID, rtwdev->mac_id_map);
@@ -1174,6 +1210,7 @@ void rtw_core_deinit(struct rtw_dev *rtwdev)
 	}
 
 	mutex_destroy(&rtwdev->mutex);
+	mutex_destroy(&rtwdev->coex.mutex);
 	mutex_destroy(&rtwdev->hal.tx_power_mutex);
 }
 EXPORT_SYMBOL(rtw_core_deinit);
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index 8fa0575..9208b9c 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -310,6 +310,7 @@ enum rtw_flags {
 	RTW_FLAG_INACTIVE_PS,
 	RTW_FLAG_LEISURE_PS,
 	RTW_FLAG_DIG_DISABLE,
+	RTW_FLAG_BUSY_TRAFFIC,
 
 	NUM_OF_RTW_FLAGS,
 };
@@ -640,6 +641,16 @@ struct rtw_chip_ops {
 	void (*cfg_ldo25)(struct rtw_dev *rtwdev, bool enable);
 	void (*false_alarm_statistics)(struct rtw_dev *rtwdev);
 	void (*do_iqk)(struct rtw_dev *rtwdev);
+
+	/* for coex */
+	void (*coex_set_init)(struct rtw_dev *rtwdev);
+	void (*coex_set_ant_switch)(struct rtw_dev *rtwdev,
+				    u8 ctrl_type, u8 pos_type);
+	void (*coex_set_gnt_fix)(struct rtw_dev *rtwdev);
+	void (*coex_set_gnt_debug)(struct rtw_dev *rtwdev);
+	void (*coex_set_rfe_type)(struct rtw_dev *rtwdev);
+	void (*coex_set_wl_tx_power)(struct rtw_dev *rtwdev, u8 wl_pwr);
+	void (*coex_set_wl_rx_gain)(struct rtw_dev *rtwdev, bool low_gain);
 };
 
 #define RTW_PWR_POLLING_CNT	20000
@@ -852,6 +863,216 @@ struct rtw_chip_info {
 
 	const struct rtw_rfe_def *rfe_defs;
 	u32 rfe_defs_size;
+
+	/* coex paras */
+	u32 coex_para_ver;
+	u8 bt_desired_ver;
+	bool scbd_support;
+	bool new_scbd10_def; /* true: fix 2M(8822c) */
+	u8 pstdma_type; /* 0: LPSoff, 1:LPSon */
+	u8 bt_rssi_type;
+	u8 ant_isolation;
+	u8 rssi_tolerance;
+	u8 table_sant_num;
+	u8 table_nsant_num;
+	u8 tdma_sant_num;
+	u8 tdma_nsant_num;
+	u8 bt_afh_span_bw20;
+	u8 bt_afh_span_bw40;
+	u8 afh_5g_num;
+	u8 wl_rf_para_num;
+	const u8 *bt_rssi_step;
+	const u8 *wl_rssi_step;
+	const struct coex_table_para *table_nsant;
+	const struct coex_table_para *table_sant;
+	const struct coex_tdma_para *tdma_sant;
+	const struct coex_tdma_para *tdma_nsant;
+	const struct coex_rf_para *wl_rf_para_tx;
+	const struct coex_rf_para *wl_rf_para_rx;
+	const struct coex_5g_afh_map *afh_5g;
+};
+
+enum rtw_coex_bt_state_cnt {
+	COEX_CNT_BT_RETRY,
+	COEX_CNT_BT_REINIT,
+	COEX_CNT_BT_REENABLE,
+	COEX_CNT_BT_POPEVENT,
+	COEX_CNT_BT_SETUPLINK,
+	COEX_CNT_BT_IGNWLANACT,
+	COEX_CNT_BT_INQ,
+	COEX_CNT_BT_PAGE,
+	COEX_CNT_BT_ROLESWITCH,
+	COEX_CNT_BT_AFHUPDATE,
+	COEX_CNT_BT_INFOUPDATE,
+	COEX_CNT_BT_IQK,
+	COEX_CNT_BT_IQKFAIL,
+
+	COEX_CNT_BT_MAX
+};
+
+enum rtw_coex_wl_state_cnt {
+	COEX_CNT_WL_CONNPKT,
+	COEX_CNT_WL_COEXRUN,
+	COEX_CNT_WL_NOISY0,
+	COEX_CNT_WL_NOISY1,
+	COEX_CNT_WL_NOISY2,
+	COEX_CNT_WL_5MS_NOEXTEND,
+	COEX_CNT_WL_FW_NOTIFY,
+
+	COEX_CNT_WL_MAX
+};
+
+struct rtw_coex_rfe {
+	bool ant_switch_exist;
+	bool ant_switch_diversity;
+	bool ant_switch_with_bt;
+	u8 rfe_module_type;
+	u8 ant_switch_polarity;
+
+	/* true if WLG at BTG, else at WLAG */
+	bool wlg_at_btg;
+};
+
+struct rtw_coex_dm {
+	bool cur_ps_tdma_on;
+	bool cur_wl_rx_low_gain_en;
+
+	u8 reason;
+	u8 bt_rssi_state[4];
+	u8 wl_rssi_state[4];
+	u8 wl_ch_info[3];
+	u8 cur_ps_tdma;
+	u8 cur_table;
+	u8 ps_tdma_para[5];
+	u8 cur_bt_pwr_lvl;
+	u8 cur_bt_lna_lvl;
+	u8 cur_wl_pwr_lvl;
+	u8 bt_status;
+	u32 cur_ant_pos_type;
+	u32 cur_switch_status;
+	u32 setting_tdma;
+};
+
+#define COEX_BTINFO_SRC_WL_FW	0x0
+#define COEX_BTINFO_SRC_BT_RSP	0x1
+#define COEX_BTINFO_SRC_BT_ACT	0x2
+#define COEX_BTINFO_SRC_BT_IQK	0x3
+#define COEX_BTINFO_SRC_BT_SCBD	0x4
+#define COEX_BTINFO_SRC_MAX	0x5
+
+#define COEX_INFO_FTP		BIT(7)
+#define COEX_INFO_A2DP		BIT(6)
+#define COEX_INFO_HID		BIT(5)
+#define COEX_INFO_SCO_BUSY	BIT(4)
+#define COEX_INFO_ACL_BUSY	BIT(3)
+#define COEX_INFO_INQ_PAGE	BIT(2)
+#define COEX_INFO_SCO_ESCO	BIT(1)
+#define COEX_INFO_CONNECTION	BIT(0)
+#define COEX_BTINFO_LENGTH_MAX	10
+
+struct rtw_coex_stat {
+	bool bt_disabled;
+	bool bt_disabled_pre;
+	bool bt_link_exist;
+	bool bt_whck_test;
+	bool bt_inq_page;
+	bool bt_inq;
+	bool bt_page;
+	bool bt_ble_voice;
+	bool bt_ble_exist;
+	bool bt_hfp_exist;
+	bool bt_a2dp_exist;
+	bool bt_hid_exist;
+	bool bt_pan_exist; /* PAN or OPP */
+	bool bt_opp_exist; /* OPP only */
+	bool bt_acl_busy;
+	bool bt_fix_2M;
+	bool bt_setup_link;
+	bool bt_multi_link;
+	bool bt_a2dp_sink;
+	bool bt_a2dp_active;
+	bool bt_reenable;
+	bool bt_ble_scan_en;
+	bool bt_init_scan;
+	bool bt_slave;
+	bool bt_418_hid_exist;
+	bool bt_mailbox_reply;
+
+	bool wl_under_lps;
+	bool wl_under_ips;
+	bool wl_hi_pri_task1;
+	bool wl_hi_pri_task2;
+	bool wl_force_lps_ctrl;
+	bool wl_gl_busy;
+	bool wl_linkscan_proc;
+	bool wl_ps_state_fail;
+	bool wl_tx_limit_en;
+	bool wl_ampdu_limit_en;
+	bool wl_connected;
+	bool wl_slot_extend;
+	bool wl_cck_lock;
+	bool wl_cck_lock_pre;
+	bool wl_cck_lock_ever;
+
+	u32 bt_supported_version;
+	u32 bt_supported_feature;
+	s8 bt_rssi;
+	u8 kt_ver;
+	u8 gnt_workaround_state;
+	u8 tdma_timer_base;
+	u8 bt_profile_num;
+	u8 bt_info_c2h[COEX_BTINFO_SRC_MAX][COEX_BTINFO_LENGTH_MAX];
+	u8 bt_info_lb2;
+	u8 bt_info_lb3;
+	u8 bt_info_hb0;
+	u8 bt_info_hb1;
+	u8 bt_info_hb2;
+	u8 bt_info_hb3;
+	u8 bt_ble_scan_type;
+	u8 bt_hid_pair_num;
+	u8 bt_hid_slot;
+	u8 bt_a2dp_bitpool;
+	u8 bt_iqk_state;
+
+	u8 wl_noisy_level;
+	u8 wl_fw_dbg_info[10];
+	u8 wl_fw_dbg_info_pre[10];
+	u8 wl_coex_mode;
+	u8 ampdu_max_time;
+	u8 wl_tput_dir;
+
+	u16 score_board;
+	u16 retry_limit;
+
+	/* counters to record bt states */
+	u32 cnt_bt[COEX_CNT_BT_MAX];
+
+	/* counters to record wifi states */
+	u32 cnt_wl[COEX_CNT_WL_MAX];
+
+	u32 darfrc;
+	u32 darfrch;
+};
+
+struct rtw_coex {
+	/* protects coex info request section */
+	struct mutex mutex;
+	struct sk_buff_head queue;
+	wait_queue_head_t wait;
+
+	bool under_5g;
+	bool stop_dm;
+	bool freeze;
+	bool freerun;
+	bool wl_rf_off;
+
+	struct rtw_coex_stat stat;
+	struct rtw_coex_dm dm;
+	struct rtw_coex_rfe rfe;
+
+	struct delayed_work bt_relink_work;
+	struct delayed_work bt_reenable_work;
+	struct delayed_work defreeze_work;
 };
 
 #define DACK_MSBK_BACKUP_NUM	0xf
@@ -861,6 +1082,16 @@ struct rtw_dm_info {
 	u32 cck_fa_cnt;
 	u32 ofdm_fa_cnt;
 	u32 total_fa_cnt;
+
+	u32 cck_ok_cnt;
+	u32 cck_err_cnt;
+	u32 ofdm_ok_cnt;
+	u32 ofdm_err_cnt;
+	u32 ht_ok_cnt;
+	u32 ht_err_cnt;
+	u32 vht_ok_cnt;
+	u32 vht_err_cnt;
+
 	u8 min_rssi;
 	u8 pre_min_rssi;
 	u16 fa_history[4];
@@ -888,6 +1119,7 @@ struct rtw_efuse {
 	u8 addr[ETH_ALEN];
 	u8 channel_plan;
 	u8 country_code[2];
+	u8 rf_board_option;
 	u8 rfe_option;
 	u8 thermal_meter;
 	u8 crystal_cap;
@@ -1047,6 +1279,7 @@ struct rtw_dev {
 	struct rtw_regulatory regd;
 
 	struct rtw_dm_info dm_info;
+	struct rtw_coex coex;
 
 	/* ensures exclusive access from mac80211 callbacks */
 	struct mutex mutex;
diff --git a/drivers/net/wireless/realtek/rtw88/ps.c b/drivers/net/wireless/realtek/rtw88/ps.c
index 607bfa4..9ecd14fe 100644
--- a/drivers/net/wireless/realtek/rtw88/ps.c
+++ b/drivers/net/wireless/realtek/rtw88/ps.c
@@ -6,6 +6,7 @@
 #include "fw.h"
 #include "ps.h"
 #include "mac.h"
+#include "coex.h"
 #include "debug.h"
 
 static int rtw_ips_pwr_up(struct rtw_dev *rtwdev)
@@ -26,6 +27,8 @@ int rtw_enter_ips(struct rtw_dev *rtwdev)
 {
 	rtw_flag_set(rtwdev, RTW_FLAG_INACTIVE_PS);
 
+	rtw_coex_ips_notify(rtwdev, COEX_IPS_ENTER);
+
 	rtw_core_stop(rtwdev);
 
 	return 0;
@@ -53,6 +56,8 @@ int rtw_leave_ips(struct rtw_dev *rtwdev)
 
 	rtw_iterate_vifs_atomic(rtwdev, rtw_restore_port_cfg_iter, rtwdev);
 
+	rtw_coex_ips_notify(rtwdev, COEX_IPS_LEAVE);
+
 	return 0;
 }
 
@@ -67,6 +72,8 @@ static void rtw_leave_lps_core(struct rtw_dev *rtwdev)
 
 	rtw_fw_set_pwr_mode(rtwdev);
 	rtw_flag_clear(rtwdev, RTW_FLAG_LEISURE_PS);
+
+	rtw_coex_lps_notify(rtwdev, COEX_LPS_DISABLE);
 }
 
 static void rtw_enter_lps_core(struct rtw_dev *rtwdev)
@@ -78,6 +85,8 @@ static void rtw_enter_lps_core(struct rtw_dev *rtwdev)
 	conf->rlbm = 1;
 	conf->smart_ps = 2;
 
+	rtw_coex_lps_notify(rtwdev, COEX_LPS_ENABLE);
+
 	rtw_fw_set_pwr_mode(rtwdev);
 	rtw_flag_set(rtwdev, RTW_FLAG_LEISURE_PS);
 }
diff --git a/drivers/net/wireless/realtek/rtw88/reg.h b/drivers/net/wireless/realtek/rtw88/reg.h
index e2628f0..0bd0717 100644
--- a/drivers/net/wireless/realtek/rtw88/reg.h
+++ b/drivers/net/wireless/realtek/rtw88/reg.h
@@ -37,17 +37,28 @@
 
 #define REG_GPIO_MUXCFG		0x0040
 #define BIT_FSPI_EN		BIT(19)
+#define BIT_BT_AOD_GPIO3	BIT(9)
+#define BIT_BT_PTA_EN		BIT(5)
 #define BIT_WLRFE_4_5_EN	BIT(2)
 
 #define REG_LED_CFG		0x004C
 #define BIT_LNAON_SEL_EN	BIT(26)
 #define BIT_PAPE_SEL_EN		BIT(25)
+#define BIT_DPDT_WL_SEL		BIT(24)
+#define BIT_DPDT_SEL_EN		BIT(23)
 #define REG_PAD_CTRL1		0x0064
 #define BIT_PAPE_WLBT_SEL	BIT(29)
 #define BIT_LNAON_WLBT_SEL	BIT(28)
+#define BIT_BTGP_JTAG_EN	BIT(24)
+#define BIT_BTGP_SPI_EN		BIT(20)
+#define BIT_LED1DIS		BIT(15)
+#define BIT_SW_DPDT_SEL_DATA	BIT(0)
 #define REG_WL_BT_PWR_CTRL	0x0068
 #define BIT_BT_FUNC_EN		BIT(18)
 #define BIT_BT_DIG_CLK_EN	BIT(8)
+#define REG_SYS_SDIO_CTRL	0x0070
+#define BIT_DBG_GNT_WL_BT	BIT(27)
+#define BIT_LTE_MUX_CTRL_PATH	BIT(26)
 #define REG_HCI_OPT_CTRL	0x0074
 
 #define REG_MCUFW_CTRL		0x0080
@@ -70,6 +81,8 @@
 #define FW_READY_MASK		0xffff
 
 #define REG_WLRF1		0x00EC
+#define REG_WIFI_BT_INFO	0x00AA
+#define BIT_BT_INT_EN		BIT(15)
 #define REG_SYS_CFG1		0x00F0
 #define	BIT_RTL_ID		BIT(23)
 #define BIT_RF_TYPE_ID		BIT(27)
@@ -187,6 +200,7 @@
 #define REG_LIFETIME_EN		0x0426
 #define BIT_BA_PARSER_EN	BIT(5)
 #define REG_SPEC_SIFS		0x0428
+#define REG_RETRY_LIMIT		0x042a
 #define REG_DARFRC		0x0430
 #define REG_DARFRCH		0x0434
 #define REG_RARFRCH		0x043C
@@ -199,18 +213,25 @@
 #define REG_AMPDU_MAX_TIME_V1	0x0455
 #define REG_BCNQ1_BDNY_V1	0x0456
 #define REG_TX_HANG_CTRL	0x045E
+#define BIT_EN_GNT_BT_AWAKE	BIT(3)
 #define BIT_EN_EOF_V1		BIT(2)
 #define REG_DATA_SC		0x0483
 #define REG_ARFR4		0x049C
+#define BIT_WL_RFK		BIT(0)
 #define REG_ARFRH4		0x04A0
 #define REG_ARFR5		0x04A4
 #define REG_ARFRH5		0x04A8
 #define REG_SW_AMPDU_BURST_MODE_CTRL 0x04BC
 #define BIT_PRE_TX_CMD		BIT(6)
+#define REG_QUEUE_CTRL		0x04C6
+#define BIT_PTA_WL_TX_EN	BIT(4)
+#define BIT_PTA_EDCCA_EN	BIT(5)
 #define REG_PROT_MODE_CTRL	0x04C8
 #define REG_BAR_MODE_CTRL	0x04CC
 #define REG_PRECNT_CTRL		0x04E5
+#define BIT_BTCCA_CTRL		(BIT(0) | BIT(1))
 #define BIT_EN_PRECNT		BIT(11)
+#define REG_DUMMY_PAGE4_V1	0x04FC
 
 #define REG_EDCA_VO_PARAM	0x0500
 #define REG_EDCA_VI_PARAM	0x0504
@@ -297,11 +318,34 @@
 #define REG_RXFLTMAP0		0x06A0
 #define REG_RXFLTMAP1		0x06A2
 #define REG_RXFLTMAP2		0x06A4
+#define REG_BT_COEX_TABLE0	0x06C0
+#define REG_BT_COEX_TABLE1	0x06C4
+#define REG_BT_COEX_BRK_TABLE	0x06C8
+#define REG_BT_COEX_TABLE_H	0x06CC
+#define REG_BT_COEX_TABLE_H1	0x06CD
+#define REG_BT_COEX_TABLE_H2	0x06CE
+#define REG_BT_COEX_TABLE_H3	0x06CF
 #define REG_BBPSF_CTRL		0x06DC
 
+#define REG_BT_COEX_V2		0x0763
+#define BIT_GNT_BT_POLARITY	BIT(4)
+#define BIT_LTE_COEX_EN		BIT(7)
+#define REG_BT_STAT_CTRL	0x0778
+#define REG_BT_TDMA_TIME	0x0790
 #define REG_WMAC_OPTION_FUNCTION 0x07D0
 #define REG_WMAC_OPTION_FUNCTION_1 0x07D4
 
+#define REG_RX_GAIN_EN		0x081c
+
+#define REG_RFE_CTRL_E		0x0974
+
+#define REG_RFE_CTRL8		0x0cb4
+#define BIT_MASK_RFE_SEL89	GENMASK(7, 0)
+#define REG_RFE_INV8		0x0cbd
+#define BIT_MASK_RFE_INV89	GENMASK(1, 0)
+#define REG_RFE_INV16		0x0cbe
+#define BIT_RFE_BUF_EN		BIT(3)
+
 #define REG_ANAPAR_XTAL_0	0x1040
 #define REG_CPU_DMEM_CON	0x1080
 #define BIT_WL_PLATFORM_RST	BIT(16)
@@ -407,15 +451,33 @@
 #define LTECOEX_WRITE_DATA REG_WL2LTECOEX_INDIRECT_ACCESS_WRITE_DATA_V1
 #define LTECOEX_READ_DATA REG_WL2LTECOEX_INDIRECT_ACCESS_READ_DATA_V1
 
+#define REG_IGN_GNT_BT1	0x1860
+
+#define REG_RFESEL_CTRL	0x1990
+
+#define REG_NOMASK_TXBT	0x1ca7
+#define REG_ANAPAR	0x1c30
+#define BIT_ANAPAR_BTPS	BIT(22)
+#define REG_RSTB_SEL	0x1c38
+
+#define REG_IGN_GNTBT4	0x4160
+
+#define RF_MODOPT	0x01
 #define RF_DTXLOK	0x08
 #define RF_CFGCH	0x18
+#define RF_RCK		0x1d
 #define RF_LUTWA	0x33
 #define RF_LUTWD1	0x3e
 #define RF_LUTWD0	0x3f
 #define RF_XTALX2	0xb8
 #define RF_MALSEL	0xbe
+#define RF_RCKD		0xde
 #define RF_LUTDBG	0xdf
 #define RF_LUTWE2	0xee
 #define RF_LUTWE	0xef
 
+#define LTE_COEX_CTRL	0x38
+#define LTE_WL_TRX_CTRL	0xa0
+#define LTE_BT_TRX_CTRL	0xa4
+
 #endif
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822b.c b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
index d61d534..568033a 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822b.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
@@ -3,6 +3,7 @@
  */
 
 #include "main.h"
+#include "coex.h"
 #include "fw.h"
 #include "tx.h"
 #include "rx.h"
@@ -31,6 +32,7 @@ static int rtw8822b_read_efuse(struct rtw_dev *rtwdev, u8 *log_map)
 	map = (struct rtw8822b_efuse *)log_map;
 
 	efuse->rfe_option = map->rfe_option;
+	efuse->rf_board_option = map->rf_board_option;
 	efuse->crystal_cap = map->xtal_k;
 	efuse->pa_type_2g = map->pa_type;
 	efuse->pa_type_5g = map->pa_type;
@@ -104,24 +106,6 @@ static void rtw8822b_phy_set_param(struct rtw_dev *rtwdev)
 	rtw_phy_init(rtwdev);
 
 	rtw8822b_phy_rfe_init(rtwdev);
-
-	/* wifi path controller */
-	rtw_write32_mask(rtwdev, 0x70, 0x4000000, 1);
-	/* BB control */
-	rtw_write32_mask(rtwdev, 0x4c, 0x01800000, 0x2);
-	/* antenna mux switch */
-	rtw_write8(rtwdev, 0x974, 0xff);
-	rtw_write32_mask(rtwdev, 0x1990, 0x300, 0);
-	rtw_write32_mask(rtwdev, 0xcbc, 0x80000, 0x0);
-	/* SW control */
-	rtw_write8(rtwdev, 0xcb4, 0x77);
-	/* switch to WL side controller and gnt_wl gnt_bt debug signal */
-	rtw_write32_mask(rtwdev, 0x70, 0xff000000, 0x0e);
-	/* gnt_wl = 1, gnt_bt = 0 */
-	rtw_write32(rtwdev, 0x1704, 0x7700);
-	rtw_write32(rtwdev, 0x1700, 0xc00f0038);
-	/* switch for WL 2G */
-	rtw_write8(rtwdev, 0xcbd, 0x2);
 }
 
 #define WLAN_SLOT_TIME		0x09
@@ -960,6 +944,7 @@ static void rtw8822b_false_alarm_statistics(struct rtw_dev *rtwdev)
 	u32 cck_enable;
 	u32 cck_fa_cnt;
 	u32 ofdm_fa_cnt;
+	u32 crc32_cnt;
 
 	cck_enable = rtw_read32(rtwdev, 0x808) & BIT(28);
 	cck_fa_cnt = rtw_read16(rtwdev, 0xa5c);
@@ -970,6 +955,19 @@ static void rtw8822b_false_alarm_statistics(struct rtw_dev *rtwdev)
 	dm_info->total_fa_cnt = ofdm_fa_cnt;
 	dm_info->total_fa_cnt += cck_enable ? cck_fa_cnt : 0;
 
+	crc32_cnt = rtw_read32(rtwdev, 0xf04);
+	dm_info->cck_ok_cnt = crc32_cnt & 0xffff;
+	dm_info->cck_err_cnt = (crc32_cnt & 0xffff0000) >> 16;
+	crc32_cnt = rtw_read32(rtwdev, 0xf14);
+	dm_info->ofdm_ok_cnt = crc32_cnt & 0xffff;
+	dm_info->ofdm_err_cnt = (crc32_cnt & 0xffff0000) >> 16;
+	crc32_cnt = rtw_read32(rtwdev, 0xf10);
+	dm_info->ht_ok_cnt = crc32_cnt & 0xffff;
+	dm_info->ht_err_cnt = (crc32_cnt & 0xffff0000) >> 16;
+	crc32_cnt = rtw_read32(rtwdev, 0xf0c);
+	dm_info->vht_ok_cnt = crc32_cnt & 0xffff;
+	dm_info->vht_err_cnt = (crc32_cnt & 0xffff0000) >> 16;
+
 	rtw_write32_set(rtwdev, 0x9a4, BIT(17));
 	rtw_write32_clr(rtwdev, 0x9a4, BIT(17));
 	rtw_write32_clr(rtwdev, 0xa2c, BIT(15));
@@ -1003,6 +1001,254 @@ static void rtw8822b_do_iqk(struct rtw_dev *rtwdev)
 		counter, reload, ++do_iqk_cnt, iqk_fail_mask);
 }
 
+static void rtw8822b_coex_cfg_init(struct rtw_dev *rtwdev)
+{
+	/* enable TBTT nterrupt */
+	rtw_write8_set(rtwdev, REG_BCN_CTRL, BIT_EN_BCN_FUNCTION);
+
+	/* BT report packet sample rate */
+	/* 0x790[5:0]=0x5 */
+	rtw_write8_set(rtwdev, REG_BT_TDMA_TIME, 0x05);
+
+	/* enable BT counter statistics */
+	rtw_write8(rtwdev, REG_BT_STAT_CTRL, 0x1);
+
+	/* enable PTA (3-wire function form BT side) */
+	rtw_write32_set(rtwdev, REG_GPIO_MUXCFG, BIT_BT_PTA_EN);
+	rtw_write32_set(rtwdev, REG_GPIO_MUXCFG, BIT_BT_AOD_GPIO3);
+
+	/* enable PTA (tx/rx signal form WiFi side) */
+	rtw_write8_set(rtwdev, REG_QUEUE_CTRL, BIT_PTA_WL_TX_EN);
+	/* wl tx signal to PTA not case EDCCA */
+	rtw_write8_clr(rtwdev, REG_QUEUE_CTRL, BIT_PTA_EDCCA_EN);
+	/* GNT_BT=1 while select both */
+	rtw_write8_set(rtwdev, REG_BT_COEX_V2, BIT_GNT_BT_POLARITY);
+}
+
+static void rtw8822b_coex_cfg_ant_switch(struct rtw_dev *rtwdev,
+					 u8 ctrl_type, u8 pos_type)
+{
+	struct rtw_coex *coex = &rtwdev->coex;
+	struct rtw_coex_dm *coex_dm = &coex->dm;
+	struct rtw_coex_rfe *coex_rfe = &coex->rfe;
+	bool polarity_inverse;
+	u8 regval = 0;
+
+	if (((ctrl_type << 8) + pos_type) == coex_dm->cur_switch_status)
+		return;
+
+	coex_dm->cur_switch_status = (ctrl_type << 8) + pos_type;
+
+	if (coex_rfe->ant_switch_diversity &&
+	    ctrl_type == COEX_SWITCH_CTRL_BY_BBSW)
+		ctrl_type = COEX_SWITCH_CTRL_BY_ANTDIV;
+
+	polarity_inverse = (coex_rfe->ant_switch_polarity == 1);
+
+	switch (ctrl_type) {
+	default:
+	case COEX_SWITCH_CTRL_BY_BBSW:
+		/* 0x4c[23] = 0 */
+		rtw_write8_mask(rtwdev, REG_LED_CFG + 2, BIT_DPDT_SEL_EN >> 16, 0x0);
+		/* 0x4c[24] = 1 */
+		rtw_write8_mask(rtwdev, REG_LED_CFG + 3, BIT_DPDT_WL_SEL >> 24, 0x1);
+		/* BB SW, DPDT use RFE_ctrl8 and RFE_ctrl9 as ctrl pin */
+		rtw_write8_mask(rtwdev, REG_RFE_CTRL8, BIT_MASK_RFE_SEL89, 0x77);
+
+		if (pos_type == COEX_SWITCH_TO_WLG_BT) {
+			if (coex_rfe->rfe_module_type != 0x4 &&
+			    coex_rfe->rfe_module_type != 0x2)
+				regval = 0x3;
+			else
+				regval = (!polarity_inverse ? 0x2 : 0x1);
+		} else if (pos_type == COEX_SWITCH_TO_WLG) {
+			regval = (!polarity_inverse ? 0x2 : 0x1);
+		} else {
+			regval = (!polarity_inverse ? 0x1 : 0x2);
+		}
+
+		rtw_write8_mask(rtwdev, REG_RFE_INV8, BIT_MASK_RFE_INV89, regval);
+		break;
+	case COEX_SWITCH_CTRL_BY_PTA:
+		/* 0x4c[23] = 0 */
+		rtw_write8_mask(rtwdev, REG_LED_CFG + 2, BIT_DPDT_SEL_EN >> 16, 0x0);
+		/* 0x4c[24] = 1 */
+		rtw_write8_mask(rtwdev, REG_LED_CFG + 3, BIT_DPDT_WL_SEL >> 24, 0x1);
+		/* PTA,  DPDT use RFE_ctrl8 and RFE_ctrl9 as ctrl pin */
+		rtw_write8_mask(rtwdev, REG_RFE_CTRL8, BIT_MASK_RFE_SEL89, 0x66);
+
+		regval = (!polarity_inverse ? 0x2 : 0x1);
+		rtw_write8_mask(rtwdev, REG_RFE_INV8, BIT_MASK_RFE_INV89, regval);
+		break;
+	case COEX_SWITCH_CTRL_BY_ANTDIV:
+		/* 0x4c[23] = 0 */
+		rtw_write8_mask(rtwdev, REG_LED_CFG + 2, BIT_DPDT_SEL_EN >> 16, 0x0);
+		/* 0x4c[24] = 1 */
+		rtw_write8_mask(rtwdev, REG_LED_CFG + 3, BIT_DPDT_WL_SEL >> 24, 0x1);
+		rtw_write8_mask(rtwdev, REG_RFE_CTRL8, BIT_MASK_RFE_SEL89, 0x88);
+		break;
+	case COEX_SWITCH_CTRL_BY_MAC:
+		/* 0x4c[23] = 1 */
+		rtw_write8_mask(rtwdev, REG_LED_CFG + 2, BIT_DPDT_SEL_EN >> 16, 0x1);
+
+		regval = (!polarity_inverse ? 0x0 : 0x1);
+		rtw_write8_mask(rtwdev, REG_PAD_CTRL1, BIT_SW_DPDT_SEL_DATA, regval);
+		break;
+	case COEX_SWITCH_CTRL_BY_FW:
+		/* 0x4c[23] = 0 */
+		rtw_write8_mask(rtwdev, REG_LED_CFG + 2, BIT_DPDT_SEL_EN >> 16, 0x0);
+		/* 0x4c[24] = 1 */
+		rtw_write8_mask(rtwdev, REG_LED_CFG + 3, BIT_DPDT_WL_SEL >> 24, 0x1);
+		break;
+	case COEX_SWITCH_CTRL_BY_BT:
+		/* 0x4c[23] = 0 */
+		rtw_write8_mask(rtwdev, REG_LED_CFG + 2, BIT_DPDT_SEL_EN >> 16, 0x0);
+		/* 0x4c[24] = 0 */
+		rtw_write8_mask(rtwdev, REG_LED_CFG + 3, BIT_DPDT_WL_SEL >> 24, 0x0);
+		break;
+	}
+}
+
+static void rtw8822b_coex_cfg_gnt_fix(struct rtw_dev *rtwdev)
+{
+}
+
+static void rtw8822b_coex_cfg_gnt_debug(struct rtw_dev *rtwdev)
+{
+	rtw_write8_mask(rtwdev, REG_PAD_CTRL1 + 2, BIT_BTGP_SPI_EN >> 16, 0);
+	rtw_write8_mask(rtwdev, REG_PAD_CTRL1 + 3, BIT_BTGP_JTAG_EN >> 24, 0);
+	rtw_write8_mask(rtwdev, REG_GPIO_MUXCFG + 2, BIT_FSPI_EN >> 16, 0);
+	rtw_write8_mask(rtwdev, REG_PAD_CTRL1 + 1, BIT_LED1DIS >> 8, 0);
+	rtw_write8_mask(rtwdev, REG_SYS_SDIO_CTRL + 3, BIT_DBG_GNT_WL_BT >> 24, 0);
+}
+
+static void rtw8822b_coex_cfg_rfe_type(struct rtw_dev *rtwdev)
+{
+	struct rtw_coex *coex = &rtwdev->coex;
+	struct rtw_coex_rfe *coex_rfe = &coex->rfe;
+	struct rtw_efuse *efuse = &rtwdev->efuse;
+	bool is_ext_fem = false;
+
+	coex_rfe->rfe_module_type = rtwdev->efuse.rfe_option;
+	coex_rfe->ant_switch_polarity = 0;
+	coex_rfe->ant_switch_diversity = false;
+	if (coex_rfe->rfe_module_type == 0x12 ||
+	    coex_rfe->rfe_module_type == 0x15 ||
+	    coex_rfe->rfe_module_type == 0x16)
+		coex_rfe->ant_switch_exist = false;
+	else
+		coex_rfe->ant_switch_exist = true;
+
+	if (coex_rfe->rfe_module_type == 2 ||
+	    coex_rfe->rfe_module_type == 4) {
+		rtw_coex_write_scbd(rtwdev, COEX_SCBD_EXTFEM, true);
+		is_ext_fem = true;
+	} else {
+		rtw_coex_write_scbd(rtwdev, COEX_SCBD_EXTFEM, false);
+	}
+
+	coex_rfe->wlg_at_btg = false;
+
+	if (efuse->share_ant &&
+	    coex_rfe->ant_switch_exist && !is_ext_fem)
+		coex_rfe->ant_switch_with_bt = true;
+	else
+		coex_rfe->ant_switch_with_bt = false;
+
+	/* Ext switch buffer mux */
+	rtw_write8(rtwdev, REG_RFE_CTRL_E, 0xff);
+	rtw_write8_mask(rtwdev, REG_RFESEL_CTRL + 1, 0x3, 0x0);
+	rtw_write8_mask(rtwdev, REG_RFE_INV16, BIT_RFE_BUF_EN, 0x0);
+
+	/* Disable LTE Coex Function in WiFi side */
+	rtw_coex_write_indirect_reg(rtwdev, LTE_COEX_CTRL, BIT_LTE_COEX_EN, 0);
+
+	/* BTC_CTT_WL_VS_LTE */
+	rtw_coex_write_indirect_reg(rtwdev, LTE_WL_TRX_CTRL, MASKLWORD, 0xffff);
+
+	/* BTC_CTT_BT_VS_LTE */
+	rtw_coex_write_indirect_reg(rtwdev, LTE_BT_TRX_CTRL, MASKLWORD, 0xffff);
+}
+
+static void rtw8822b_coex_cfg_wl_tx_power(struct rtw_dev *rtwdev, u8 wl_pwr)
+{
+	struct rtw_coex *coex = &rtwdev->coex;
+	struct rtw_coex_dm *coex_dm = &coex->dm;
+	static const u16 reg_addr[] = {0xc58, 0xe58};
+	static const u8	wl_tx_power[] = {0xd8, 0xd4, 0xd0, 0xcc, 0xc8};
+	u8 i, pwr;
+
+	if (wl_pwr == coex_dm->cur_wl_pwr_lvl)
+		return;
+
+	coex_dm->cur_wl_pwr_lvl = wl_pwr;
+
+	if (coex_dm->cur_wl_pwr_lvl >= ARRAY_SIZE(wl_tx_power))
+		coex_dm->cur_wl_pwr_lvl = ARRAY_SIZE(wl_tx_power) - 1;
+
+	pwr = wl_tx_power[coex_dm->cur_wl_pwr_lvl];
+
+	for (i = 0; i < ARRAY_SIZE(reg_addr); i++)
+		rtw_write8_mask(rtwdev, reg_addr[i], 0xff, pwr);
+}
+
+static void rtw8822b_coex_cfg_wl_rx_gain(struct rtw_dev *rtwdev, bool low_gain)
+{
+	struct rtw_coex *coex = &rtwdev->coex;
+	struct rtw_coex_dm *coex_dm = &coex->dm;
+	/* WL Rx Low gain on */
+	static const u32 wl_rx_low_gain_on[] = {
+		0xff000003, 0xbd120003, 0xbe100003, 0xbf080003, 0xbf060003,
+		0xbf050003, 0xbc140003, 0xbb160003, 0xba180003, 0xb91a0003,
+		0xb81c0003, 0xb71e0003, 0xb4200003, 0xb5220003, 0xb4240003,
+		0xb3260003, 0xb2280003, 0xb12a0003, 0xb02c0003, 0xaf2e0003,
+		0xae300003, 0xad320003, 0xac340003, 0xab360003, 0x8d380003,
+		0x8c3a0003, 0x8b3c0003, 0x8a3e0003, 0x6e400003, 0x6d420003,
+		0x6c440003, 0x6b460003, 0x6a480003, 0x694a0003, 0x684c0003,
+		0x674e0003, 0x66500003, 0x65520003, 0x64540003, 0x64560003,
+		0x007e0403
+	};
+
+	/* WL Rx Low gain off */
+	static const u32 wl_rx_low_gain_off[] = {
+		0xff000003, 0xf4120003, 0xf5100003, 0xf60e0003, 0xf70c0003,
+		0xf80a0003, 0xf3140003, 0xf2160003, 0xf1180003, 0xf01a0003,
+		0xef1c0003, 0xee1e0003, 0xed200003, 0xec220003, 0xeb240003,
+		0xea260003, 0xe9280003, 0xe82a0003, 0xe72c0003, 0xe62e0003,
+		0xe5300003, 0xc8320003, 0xc7340003, 0xc6360003, 0xc5380003,
+		0xc43a0003, 0xc33c0003, 0xc23e0003, 0xc1400003, 0xc0420003,
+		0xa5440003, 0xa4460003, 0xa3480003, 0xa24a0003, 0xa14c0003,
+		0x834e0003, 0x82500003, 0x81520003, 0x80540003, 0x65560003,
+		0x007e0403
+	};
+	u8 i;
+
+	if (low_gain == coex_dm->cur_wl_rx_low_gain_en)
+		return;
+
+	coex_dm->cur_wl_rx_low_gain_en = low_gain;
+
+	if (coex_dm->cur_wl_rx_low_gain_en) {
+		for (i = 0; i < ARRAY_SIZE(wl_rx_low_gain_on); i++)
+			rtw_write32(rtwdev, REG_RX_GAIN_EN, wl_rx_low_gain_on[i]);
+
+		/* set Rx filter corner RCK offset */
+		rtw_write_rf(rtwdev, RF_PATH_A, RF_RCKD, 0x2, 0x1);
+		rtw_write_rf(rtwdev, RF_PATH_A, RF_RCK, 0x3f, 0x3f);
+		rtw_write_rf(rtwdev, RF_PATH_B, RF_RCKD, 0x2, 0x1);
+		rtw_write_rf(rtwdev, RF_PATH_B, RF_RCK, 0x3f, 0x3f);
+	} else {
+		for (i = 0; i < ARRAY_SIZE(wl_rx_low_gain_off); i++)
+			rtw_write32(rtwdev, 0x81c, wl_rx_low_gain_off[i]);
+
+		/* set Rx filter corner RCK offset */
+		rtw_write_rf(rtwdev, RF_PATH_A, RF_RCK, 0x3f, 0x4);
+		rtw_write_rf(rtwdev, RF_PATH_A, RF_RCKD, 0x2, 0x0);
+		rtw_write_rf(rtwdev, RF_PATH_B, RF_RCK, 0x3f, 0x4);
+		rtw_write_rf(rtwdev, RF_PATH_B, RF_RCKD, 0x2, 0x0);
+	}
+}
+
 static struct rtw_pwr_seq_cmd trans_carddis_to_cardemu_8822b[] = {
 	{0x0086,
 	 RTW_PWR_CUT_ALL_MSK,
@@ -1549,8 +1795,160 @@ static struct rtw_chip_ops rtw8822b_ops = {
 	.cfg_ldo25		= rtw8822b_cfg_ldo25,
 	.false_alarm_statistics	= rtw8822b_false_alarm_statistics,
 	.do_iqk			= rtw8822b_do_iqk,
+
+	.coex_set_init		= rtw8822b_coex_cfg_init,
+	.coex_set_ant_switch	= rtw8822b_coex_cfg_ant_switch,
+	.coex_set_gnt_fix	= rtw8822b_coex_cfg_gnt_fix,
+	.coex_set_gnt_debug	= rtw8822b_coex_cfg_gnt_debug,
+	.coex_set_rfe_type	= rtw8822b_coex_cfg_rfe_type,
+	.coex_set_wl_tx_power	= rtw8822b_coex_cfg_wl_tx_power,
+	.coex_set_wl_rx_gain	= rtw8822b_coex_cfg_wl_rx_gain,
+};
+
+/* Shared-Antenna Coex Table */
+static const struct coex_table_para table_sant_8822b[] = {
+	{0xffffffff, 0xffffffff}, /* case-0 */
+	{0x55555555, 0x55555555},
+	{0x66555555, 0x66555555},
+	{0xaaaaaaaa, 0xaaaaaaaa},
+	{0x5a5a5a5a, 0x5a5a5a5a},
+	{0xfafafafa, 0xfafafafa}, /* case-5 */
+	{0x6a5a6a5a, 0xaaaaaaaa},
+	{0x6a5a56aa, 0x6a5a56aa},
+	{0x6a5a5a5a, 0x6a5a5a5a},
+	{0x66555555, 0x5a5a5a5a},
+	{0x66555555, 0x6a5a5a5a}, /* case-10 */
+	{0x66555555, 0xfafafafa},
+	{0x66555555, 0x6a5a5aaa},
+	{0x66555555, 0x5aaa5aaa},
+	{0x66555555, 0xaaaa5aaa},
+	{0x66555555, 0xaaaaaaaa}, /* case-15 */
+	{0xffff55ff, 0xfafafafa},
+	{0xffff55ff, 0x6afa5afa},
+	{0xaaffffaa, 0xfafafafa},
+	{0xaa5555aa, 0x5a5a5a5a},
+	{0xaa5555aa, 0x6a5a5a5a}, /* case-20 */
+	{0xaa5555aa, 0xaaaaaaaa},
+	{0xffffffff, 0x5a5a5a5a},
+	{0xffffffff, 0x6a5a5a5a},
+	{0xffffffff, 0x55555555},
+	{0xffffffff, 0x6a5a5aaa}, /* case-25 */
+	{0x55555555, 0x5a5a5a5a},
+	{0x55555555, 0xaaaaaaaa},
+	{0x55555555, 0x6a5a6a5a},
+	{0x66556655, 0x66556655}
+};
+
+/* Non-Shared-Antenna Coex Table */
+static const struct coex_table_para table_nsant_8822b[] = {
+	{0xffffffff, 0xffffffff}, /* case-100 */
+	{0x55555555, 0x55555555},
+	{0x66555555, 0x66555555},
+	{0xaaaaaaaa, 0xaaaaaaaa},
+	{0x5a5a5a5a, 0x5a5a5a5a},
+	{0xfafafafa, 0xfafafafa}, /* case-105 */
+	{0x5afa5afa, 0x5afa5afa},
+	{0x55555555, 0xfafafafa},
+	{0x66555555, 0xfafafafa},
+	{0x66555555, 0x5a5a5a5a},
+	{0x66555555, 0x6a5a5a5a}, /* case-110 */
+	{0x66555555, 0xaaaaaaaa},
+	{0xffff55ff, 0xfafafafa},
+	{0xffff55ff, 0x5afa5afa},
+	{0xffff55ff, 0xaaaaaaaa},
+	{0xaaffffaa, 0xfafafafa}, /* case-115 */
+	{0xaaffffaa, 0x5afa5afa},
+	{0xaaffffaa, 0xaaaaaaaa},
+	{0xffffffff, 0xfafafafa},
+	{0xffffffff, 0x5afa5afa},
+	{0xffffffff, 0xaaaaaaaa}, /* case-120 */
+	{0x55ff55ff, 0x5afa5afa},
+	{0x55ff55ff, 0xaaaaaaaa},
+	{0x55ff55ff, 0x55ff55ff}
 };
 
+/* Shared-Antenna TDMA */
+static const struct coex_tdma_para tdma_sant_8822b[] = {
+	{ {0x00, 0x00, 0x00, 0x00, 0x00} }, /* case-0 */
+	{ {0x61, 0x45, 0x03, 0x11, 0x11} },
+	{ {0x61, 0x3a, 0x03, 0x11, 0x11} },
+	{ {0x61, 0x30, 0x03, 0x11, 0x11} },
+	{ {0x61, 0x20, 0x03, 0x11, 0x11} },
+	{ {0x61, 0x10, 0x03, 0x11, 0x11} }, /* case-5 */
+	{ {0x61, 0x45, 0x03, 0x11, 0x10} },
+	{ {0x61, 0x3a, 0x03, 0x11, 0x10} },
+	{ {0x61, 0x30, 0x03, 0x11, 0x10} },
+	{ {0x61, 0x20, 0x03, 0x11, 0x10} },
+	{ {0x61, 0x10, 0x03, 0x11, 0x10} }, /* case-10 */
+	{ {0x61, 0x08, 0x03, 0x11, 0x14} },
+	{ {0x61, 0x08, 0x03, 0x10, 0x14} },
+	{ {0x51, 0x08, 0x03, 0x10, 0x54} },
+	{ {0x51, 0x08, 0x03, 0x10, 0x55} },
+	{ {0x51, 0x08, 0x07, 0x10, 0x54} }, /* case-15 */
+	{ {0x51, 0x45, 0x03, 0x10, 0x10} },
+	{ {0x51, 0x3a, 0x03, 0x10, 0x50} },
+	{ {0x51, 0x30, 0x03, 0x10, 0x50} },
+	{ {0x51, 0x20, 0x03, 0x10, 0x50} },
+	{ {0x51, 0x10, 0x03, 0x10, 0x50} }, /* case-20 */
+	{ {0x51, 0x4a, 0x03, 0x10, 0x50} },
+	{ {0x51, 0x0c, 0x03, 0x10, 0x54} },
+	{ {0x55, 0x08, 0x03, 0x10, 0x54} },
+	{ {0x65, 0x10, 0x03, 0x11, 0x11} },
+	{ {0x51, 0x10, 0x03, 0x10, 0x51} }, /* case-25 */
+	{ {0x51, 0x08, 0x03, 0x10, 0x50} }
+};
+
+/* Non-Shared-Antenna TDMA */
+static const struct coex_tdma_para tdma_nsant_8822b[] = {
+	{ {0x00, 0x00, 0x00, 0x00, 0x00} }, /* case-100 */
+	{ {0x61, 0x45, 0x03, 0x11, 0x11} },
+	{ {0x61, 0x3a, 0x03, 0x11, 0x11} },
+	{ {0x61, 0x30, 0x03, 0x11, 0x11} },
+	{ {0x61, 0x20, 0x03, 0x11, 0x11} },
+	{ {0x61, 0x10, 0x03, 0x11, 0x11} }, /* case-105 */
+	{ {0x61, 0x45, 0x03, 0x11, 0x10} },
+	{ {0x61, 0x3a, 0x03, 0x11, 0x10} },
+	{ {0x61, 0x30, 0x03, 0x11, 0x10} },
+	{ {0x61, 0x20, 0x03, 0x11, 0x10} },
+	{ {0x61, 0x10, 0x03, 0x11, 0x10} }, /* case-110 */
+	{ {0x61, 0x08, 0x03, 0x11, 0x14} },
+	{ {0x61, 0x08, 0x03, 0x10, 0x14} },
+	{ {0x51, 0x08, 0x03, 0x10, 0x54} },
+	{ {0x51, 0x08, 0x03, 0x10, 0x55} },
+	{ {0x51, 0x08, 0x07, 0x10, 0x54} }, /* case-115 */
+	{ {0x51, 0x45, 0x03, 0x10, 0x50} },
+	{ {0x51, 0x3a, 0x03, 0x10, 0x50} },
+	{ {0x51, 0x30, 0x03, 0x10, 0x50} },
+	{ {0x51, 0x20, 0x03, 0x10, 0x50} },
+	{ {0x51, 0x10, 0x03, 0x10, 0x50} }  /* case-120 */
+};
+
+/* rssi in percentage % (dbm = % - 100) */
+static const u8 wl_rssi_step_8822b[] = {60, 50, 44, 30};
+static const u8 bt_rssi_step_8822b[] = {30, 30, 30, 30};
+static const struct coex_5g_afh_map afh_5g_8822b[] = { {0, 0, 0} };
+
+/* wl_tx_dec_power, bt_tx_dec_power, wl_rx_gain, bt_rx_lna_constrain */
+static const struct coex_rf_para rf_para_tx_8822b[] = {
+	{0, 0, false, 7},  /* for normal */
+	{0, 16, false, 7}, /* for WL-CPT */
+	{4, 0, true, 1},
+	{3, 6, true, 1},
+	{2, 9, true, 1},
+	{1, 13, true, 1}
+};
+
+static const struct coex_rf_para rf_para_rx_8822b[] = {
+	{0, 0, false, 7},  /* for normal */
+	{0, 16, false, 7}, /* for WL-CPT */
+	{4, 0, true, 1},
+	{3, 6, true, 1},
+	{2, 9, true, 1},
+	{1, 13, true, 1}
+};
+
+static_assert(ARRAY_SIZE(rf_para_tx_8822b) == ARRAY_SIZE(rf_para_rx_8822b));
+
 struct rtw_chip_info rtw8822b_hw_spec = {
 	.ops = &rtw8822b_ops,
 	.id = RTW_CHIP_TYPE_8822B,
@@ -1588,6 +1986,32 @@ struct rtw_chip_info rtw8822b_hw_spec = {
 	.rf_tbl = {&rtw8822b_rf_a_tbl, &rtw8822b_rf_b_tbl},
 	.rfe_defs = rtw8822b_rfe_defs,
 	.rfe_defs_size = ARRAY_SIZE(rtw8822b_rfe_defs),
+
+	.coex_para_ver = 0x19062706,
+	.bt_desired_ver = 0x6,
+	.scbd_support = true,
+	.new_scbd10_def = false,
+	.pstdma_type = COEX_PSTDMA_FORCE_LPSOFF,
+	.bt_rssi_type = COEX_BTRSSI_RATIO,
+	.ant_isolation = 15,
+	.rssi_tolerance = 2,
+	.wl_rssi_step = wl_rssi_step_8822b,
+	.bt_rssi_step = bt_rssi_step_8822b,
+	.table_sant_num = ARRAY_SIZE(table_sant_8822b),
+	.table_sant = table_sant_8822b,
+	.table_nsant_num = ARRAY_SIZE(table_nsant_8822b),
+	.table_nsant = table_nsant_8822b,
+	.tdma_sant_num = ARRAY_SIZE(tdma_sant_8822b),
+	.tdma_sant = tdma_sant_8822b,
+	.tdma_nsant_num = ARRAY_SIZE(tdma_nsant_8822b),
+	.tdma_nsant = tdma_nsant_8822b,
+	.wl_rf_para_num = ARRAY_SIZE(rf_para_tx_8822b),
+	.wl_rf_para_tx = rf_para_tx_8822b,
+	.wl_rf_para_rx = rf_para_rx_8822b,
+	.bt_afh_span_bw20 = 0x24,
+	.bt_afh_span_bw40 = 0x36,
+	.afh_5g_num = ARRAY_SIZE(afh_5g_8822b),
+	.afh_5g = afh_5g_8822b,
 };
 EXPORT_SYMBOL(rtw8822b_hw_spec);
 
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.c b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
index f6214ff..207f64c 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
@@ -3,6 +3,7 @@
  */
 
 #include "main.h"
+#include "coex.h"
 #include "fw.h"
 #include "tx.h"
 #include "rx.h"
@@ -31,6 +32,7 @@ static int rtw8822c_read_efuse(struct rtw_dev *rtwdev, u8 *log_map)
 	map = (struct rtw8822c_efuse *)log_map;
 
 	efuse->rfe_option = map->rfe_option;
+	efuse->rf_board_option = map->rf_board_option;
 	efuse->crystal_cap = map->xtal_k;
 	efuse->channel_plan = map->channel_plan;
 	efuse->country_code[0] = map->country_code[0];
@@ -1041,12 +1043,6 @@ static void rtw8822c_phy_set_param(struct rtw_dev *rtwdev)
 	dm_info->cck_gi_l_bnd = ((cck_gi_l_bnd_msb << 4) | (cck_gi_l_bnd_lsb));
 
 	rtw8822c_rf_init(rtwdev);
-	/* wifi path controller */
-	rtw_write32_mask(rtwdev, 0x70, 0xff000000, 0x0e);
-	rtw_write32_mask(rtwdev, 0x1704, 0xffffffff, 0x7700);
-	rtw_write32_mask(rtwdev, 0x1700, 0xffffffff, 0xc00f0038);
-	rtw_write32_mask(rtwdev, 0x6c0, 0xffffffff, 0xaaaaaaaa);
-	rtw_write32_mask(rtwdev, 0x6c4, 0xffffffff, 0xaaaaaaaa);
 }
 
 #define WLAN_TXQ_RPT_EN		0x1F
@@ -1817,6 +1813,7 @@ static void rtw8822c_false_alarm_statistics(struct rtw_dev *rtwdev)
 	struct rtw_dm_info *dm_info = &rtwdev->dm_info;
 	u32 cck_enable;
 	u32 cck_fa_cnt;
+	u32 crc32_cnt;
 	u32 ofdm_fa_cnt;
 	u32 ofdm_fa_cnt1, ofdm_fa_cnt2, ofdm_fa_cnt3, ofdm_fa_cnt4, ofdm_fa_cnt5;
 	u16 parity_fail, rate_illegal, crc8_fail, mcs_fail, sb_search_fail,
@@ -1848,6 +1845,19 @@ static void rtw8822c_false_alarm_statistics(struct rtw_dev *rtwdev)
 	dm_info->total_fa_cnt = ofdm_fa_cnt;
 	dm_info->total_fa_cnt += cck_enable ? cck_fa_cnt : 0;
 
+	crc32_cnt = rtw_read32(rtwdev, 0x2c04);
+	dm_info->cck_ok_cnt = crc32_cnt & 0xffff;
+	dm_info->cck_err_cnt = (crc32_cnt & 0xffff0000) >> 16;
+	crc32_cnt = rtw_read32(rtwdev, 0x2c14);
+	dm_info->ofdm_ok_cnt = crc32_cnt & 0xffff;
+	dm_info->ofdm_err_cnt = (crc32_cnt & 0xffff0000) >> 16;
+	crc32_cnt = rtw_read32(rtwdev, 0x2c10);
+	dm_info->ht_ok_cnt = crc32_cnt & 0xffff;
+	dm_info->ht_err_cnt = (crc32_cnt & 0xffff0000) >> 16;
+	crc32_cnt = rtw_read32(rtwdev, 0x2c0c);
+	dm_info->vht_ok_cnt = crc32_cnt & 0xffff;
+	dm_info->vht_err_cnt = (crc32_cnt & 0xffff0000) >> 16;
+
 	rtw_write32_mask(rtwdev, REG_CCANRX, BIT_CCK_FA_RST, 0);
 	rtw_write32_mask(rtwdev, REG_CCANRX, BIT_CCK_FA_RST, 2);
 	rtw_write32_mask(rtwdev, REG_CCANRX, BIT_OFDM_FA_RST, 0);
@@ -1864,6 +1874,161 @@ static void rtw8822c_do_iqk(struct rtw_dev *rtwdev)
 {
 }
 
+/* for coex */
+static void rtw8822c_coex_cfg_init(struct rtw_dev *rtwdev)
+{
+	/* enable TBTT nterrupt */
+	rtw_write8_set(rtwdev, REG_BCN_CTRL, BIT_EN_BCN_FUNCTION);
+
+	/* BT report packet sample rate	 */
+	/* 0x790[5:0]=0x5 */
+	rtw_write8_set(rtwdev, REG_BT_TDMA_TIME, 0x05);
+
+	/* enable BT counter statistics */
+	rtw_write8(rtwdev, REG_BT_STAT_CTRL, 0x1);
+
+	/* enable PTA (3-wire function form BT side) */
+	rtw_write32_set(rtwdev, REG_GPIO_MUXCFG, BIT_BT_PTA_EN);
+	rtw_write32_set(rtwdev, REG_GPIO_MUXCFG, BIT_BT_AOD_GPIO3);
+
+	/* enable PTA (tx/rx signal form WiFi side) */
+	rtw_write8_set(rtwdev, REG_QUEUE_CTRL, BIT_PTA_WL_TX_EN);
+	/* wl tx signal to PTA not case EDCCA */
+	rtw_write8_clr(rtwdev, REG_QUEUE_CTRL, BIT_PTA_EDCCA_EN);
+	/* GNT_BT=1 while select both */
+	rtw_write8_set(rtwdev, REG_BT_COEX_V2, BIT_GNT_BT_POLARITY);
+	/* BT_CCA = ~GNT_WL_BB, (not or GNT_BT_BB, LTE_Rx */
+	rtw_write8_clr(rtwdev, REG_DUMMY_PAGE4_V1, BIT_BTCCA_CTRL);
+
+	/* to avoid RF parameter error */
+	rtw_write_rf(rtwdev, RF_PATH_B, 0x1, 0xfffff, 0x40000);
+}
+
+static void rtw8822c_coex_cfg_gnt_fix(struct rtw_dev *rtwdev)
+{
+	struct rtw_coex *coex = &rtwdev->coex;
+	struct rtw_coex_stat *coex_stat = &coex->stat;
+	struct rtw_efuse *efuse = &rtwdev->efuse;
+	u32 rf_0x1;
+
+	if (coex_stat->gnt_workaround_state == coex_stat->wl_coex_mode)
+		return;
+
+	coex_stat->gnt_workaround_state = coex_stat->wl_coex_mode;
+
+	if ((coex_stat->kt_ver == 0 && coex->under_5g) || coex->freerun)
+		rf_0x1 = 0x40021;
+	else
+		rf_0x1 = 0x40000;
+
+	/* BT at S1 for Shared-Ant */
+	if (efuse->share_ant)
+		rf_0x1 |= BIT(13);
+
+	rtw_write_rf(rtwdev, RF_PATH_B, 0x1, 0xfffff, rf_0x1);
+
+	/* WL-S0 2G RF TRX cannot be masked by GNT_BT
+	 * enable "WLS0 BB chage RF mode if GNT_BT = 1" for shared-antenna type
+	 * disable:0x1860[3] = 1, enable:0x1860[3] = 0
+	 *
+	 * enable "DAC off if GNT_WL = 0" for non-shared-antenna
+	 * disable 0x1c30[22] = 0,
+	 * enable: 0x1c30[22] = 1, 0x1c38[12] = 0, 0x1c38[28] = 1
+	 *
+	 * disable WL-S1 BB chage RF mode if GNT_BT
+	 * since RF TRx mask can do it
+	 */
+	rtw_write8_mask(rtwdev, 0x1c32, BIT(6), 1);
+	rtw_write8_mask(rtwdev, 0x1c39, BIT(4), 0);
+	rtw_write8_mask(rtwdev, 0x1c3b, BIT(4), 1);
+	rtw_write8_mask(rtwdev, 0x4160, BIT(3), 1);
+
+	/* disable WL-S0 BB chage RF mode if wifi is at 5G,
+	 * or antenna path is separated
+	 */
+	if (coex_stat->wl_coex_mode == COEX_WLINK_5G ||
+	    coex->under_5g || !efuse->share_ant) {
+		if (coex_stat->kt_ver >= 3) {
+			rtw_write8_mask(rtwdev, 0x1860, BIT(3), 0);
+			rtw_write8_mask(rtwdev, 0x1ca7, BIT(3), 1);
+		} else {
+			rtw_write8_mask(rtwdev, 0x1860, BIT(3), 1);
+		}
+	} else {
+		/* shared-antenna */
+		rtw_write8_mask(rtwdev, 0x1860, BIT(3), 0);
+		if (coex_stat->kt_ver >= 3)
+			rtw_write8_mask(rtwdev, 0x1ca7, BIT(3), 0);
+	}
+}
+
+static void rtw8822c_coex_cfg_gnt_debug(struct rtw_dev *rtwdev)
+{
+	rtw_write8_mask(rtwdev, 0x66, BIT(4), 0);
+	rtw_write8_mask(rtwdev, 0x67, BIT(0), 0);
+	rtw_write8_mask(rtwdev, 0x42, BIT(3), 0);
+	rtw_write8_mask(rtwdev, 0x65, BIT(7), 0);
+	rtw_write8_mask(rtwdev, 0x73, BIT(3), 0);
+}
+
+static void rtw8822c_coex_cfg_rfe_type(struct rtw_dev *rtwdev)
+{
+	struct rtw_coex *coex = &rtwdev->coex;
+	struct rtw_coex_rfe *coex_rfe = &coex->rfe;
+	struct rtw_efuse *efuse = &rtwdev->efuse;
+
+	coex_rfe->rfe_module_type = rtwdev->efuse.rfe_option;
+	coex_rfe->ant_switch_polarity = 0;
+	coex_rfe->ant_switch_exist = false;
+	coex_rfe->ant_switch_with_bt = false;
+	coex_rfe->ant_switch_diversity = false;
+
+	if (efuse->share_ant)
+		coex_rfe->wlg_at_btg = true;
+	else
+		coex_rfe->wlg_at_btg = false;
+
+	/* disable LTE coex in wifi side */
+	rtw_coex_write_indirect_reg(rtwdev, 0x38, BIT_LTE_COEX_EN, 0x0);
+	rtw_coex_write_indirect_reg(rtwdev, 0xa0, MASKLWORD, 0xffff);
+	rtw_coex_write_indirect_reg(rtwdev, 0xa4, MASKLWORD, 0xffff);
+}
+
+static void rtw8822c_coex_cfg_wl_tx_power(struct rtw_dev *rtwdev, u8 wl_pwr)
+{
+	struct rtw_coex *coex = &rtwdev->coex;
+	struct rtw_coex_dm *coex_dm = &coex->dm;
+
+	if (wl_pwr == coex_dm->cur_wl_pwr_lvl)
+		return;
+
+	coex_dm->cur_wl_pwr_lvl = wl_pwr;
+}
+
+static void rtw8822c_coex_cfg_wl_rx_gain(struct rtw_dev *rtwdev, bool low_gain)
+{
+	struct rtw_coex *coex = &rtwdev->coex;
+	struct rtw_coex_dm *coex_dm = &coex->dm;
+
+	if (low_gain == coex_dm->cur_wl_rx_low_gain_en)
+		return;
+
+	coex_dm->cur_wl_rx_low_gain_en = low_gain;
+
+	if (coex_dm->cur_wl_rx_low_gain_en) {
+		/* set Rx filter corner RCK offset */
+		rtw_write_rf(rtwdev, RF_PATH_A, 0xde, 0xfffff, 0x22);
+		rtw_write_rf(rtwdev, RF_PATH_A, 0x1d, 0xfffff, 0x36);
+		rtw_write_rf(rtwdev, RF_PATH_B, 0xde, 0xfffff, 0x22);
+		rtw_write_rf(rtwdev, RF_PATH_B, 0x1d, 0xfffff, 0x36);
+	} else {
+		/* set Rx filter corner RCK offset */
+		rtw_write_rf(rtwdev, RF_PATH_A, 0xde, 0xfffff, 0x20);
+		rtw_write_rf(rtwdev, RF_PATH_A, 0x1d, 0xfffff, 0x0);
+		rtw_write_rf(rtwdev, RF_PATH_B, 0x1d, 0xfffff, 0x0);
+	}
+}
+
 static struct rtw_pwr_seq_cmd trans_carddis_to_cardemu_8822c[] = {
 	{0x0086,
 	 RTW_PWR_CUT_ALL_MSK,
@@ -2232,8 +2397,160 @@ static struct rtw_chip_ops rtw8822c_ops = {
 	.cfg_ldo25		= rtw8822c_cfg_ldo25,
 	.false_alarm_statistics	= rtw8822c_false_alarm_statistics,
 	.do_iqk			= rtw8822c_do_iqk,
+
+	.coex_set_init		= rtw8822c_coex_cfg_init,
+	.coex_set_ant_switch	= NULL,
+	.coex_set_gnt_fix	= rtw8822c_coex_cfg_gnt_fix,
+	.coex_set_gnt_debug	= rtw8822c_coex_cfg_gnt_debug,
+	.coex_set_rfe_type	= rtw8822c_coex_cfg_rfe_type,
+	.coex_set_wl_tx_power	= rtw8822c_coex_cfg_wl_tx_power,
+	.coex_set_wl_rx_gain	= rtw8822c_coex_cfg_wl_rx_gain,
+};
+
+/* Shared-Antenna Coex Table */
+static const struct coex_table_para table_sant_8822c[] = {
+	{0xffffffff, 0xffffffff}, /* case-0 */
+	{0x55555555, 0x55555555},
+	{0x66555555, 0x66555555},
+	{0xaaaaaaaa, 0xaaaaaaaa},
+	{0x5a5a5a5a, 0x5a5a5a5a},
+	{0xfafafafa, 0xfafafafa}, /* case-5 */
+	{0x6a5a6a5a, 0xaaaaaaaa},
+	{0x6a5a56aa, 0x6a5a56aa},
+	{0x6a5a5a5a, 0x6a5a5a5a},
+	{0x66555555, 0x5a5a5a5a},
+	{0x66555555, 0x6a5a5a5a}, /* case-10 */
+	{0x66555555, 0xfafafafa},
+	{0x66555555, 0x6a5a5aaa},
+	{0x66555555, 0x5aaa5aaa},
+	{0x66555555, 0xaaaa5aaa},
+	{0x66555555, 0xaaaaaaaa}, /* case-15 */
+	{0xffff55ff, 0xfafafafa},
+	{0xffff55ff, 0x6afa5afa},
+	{0xaaffffaa, 0xfafafafa},
+	{0xaa5555aa, 0x5a5a5a5a},
+	{0xaa5555aa, 0x6a5a5a5a}, /* case-20 */
+	{0xaa5555aa, 0xaaaaaaaa},
+	{0xffffffff, 0x5a5a5a5a},
+	{0xffffffff, 0x6a5a5a5a},
+	{0xffffffff, 0x55555555},
+	{0xffffffff, 0x6a5a5aaa}, /* case-25 */
+	{0x55555555, 0x5a5a5a5a},
+	{0x55555555, 0xaaaaaaaa},
+	{0x55555555, 0x6a5a6a5a},
+	{0x66556655, 0x66556655}
+};
+
+/* Non-Shared-Antenna Coex Table */
+static const struct coex_table_para table_nsant_8822c[] = {
+	{0xffffffff, 0xffffffff}, /* case-100 */
+	{0x55555555, 0x55555555},
+	{0x66555555, 0x66555555},
+	{0xaaaaaaaa, 0xaaaaaaaa},
+	{0x5a5a5a5a, 0x5a5a5a5a},
+	{0xfafafafa, 0xfafafafa}, /* case-105 */
+	{0x5afa5afa, 0x5afa5afa},
+	{0x55555555, 0xfafafafa},
+	{0x66555555, 0xfafafafa},
+	{0x66555555, 0x5a5a5a5a},
+	{0x66555555, 0x6a5a5a5a}, /* case-110 */
+	{0x66555555, 0xaaaaaaaa},
+	{0xffff55ff, 0xfafafafa},
+	{0xffff55ff, 0x5afa5afa},
+	{0xffff55ff, 0xaaaaaaaa},
+	{0xaaffffaa, 0xfafafafa}, /* case-115 */
+	{0xaaffffaa, 0x5afa5afa},
+	{0xaaffffaa, 0xaaaaaaaa},
+	{0xffffffff, 0xfafafafa},
+	{0xffffffff, 0x5afa5afa},
+	{0xffffffff, 0xaaaaaaaa},/* case-120 */
+	{0x55ff55ff, 0x5afa5afa},
+	{0x55ff55ff, 0xaaaaaaaa},
+	{0x55ff55ff, 0x55ff55ff}
+};
+
+/* Shared-Antenna TDMA */
+static const struct coex_tdma_para tdma_sant_8822c[] = {
+	{ {0x00, 0x00, 0x00, 0x00, 0x00} }, /* case-0 */
+	{ {0x61, 0x45, 0x03, 0x11, 0x11} },
+	{ {0x61, 0x3a, 0x03, 0x11, 0x11} },
+	{ {0x61, 0x30, 0x03, 0x11, 0x11} },
+	{ {0x61, 0x20, 0x03, 0x11, 0x11} },
+	{ {0x61, 0x10, 0x03, 0x11, 0x11} }, /* case-5 */
+	{ {0x61, 0x45, 0x03, 0x11, 0x10} },
+	{ {0x61, 0x3a, 0x03, 0x11, 0x10} },
+	{ {0x61, 0x30, 0x03, 0x11, 0x10} },
+	{ {0x61, 0x20, 0x03, 0x11, 0x10} },
+	{ {0x61, 0x10, 0x03, 0x11, 0x10} }, /* case-10 */
+	{ {0x61, 0x08, 0x03, 0x11, 0x14} },
+	{ {0x61, 0x08, 0x03, 0x10, 0x14} },
+	{ {0x51, 0x08, 0x03, 0x10, 0x54} },
+	{ {0x51, 0x08, 0x03, 0x10, 0x55} },
+	{ {0x51, 0x08, 0x07, 0x10, 0x54} }, /* case-15 */
+	{ {0x51, 0x45, 0x03, 0x10, 0x10} },
+	{ {0x51, 0x3a, 0x03, 0x10, 0x50} },
+	{ {0x51, 0x30, 0x03, 0x10, 0x50} },
+	{ {0x51, 0x20, 0x03, 0x10, 0x50} },
+	{ {0x51, 0x10, 0x03, 0x10, 0x50} }, /* case-20 */
+	{ {0x51, 0x4a, 0x03, 0x10, 0x50} },
+	{ {0x51, 0x0c, 0x03, 0x10, 0x54} },
+	{ {0x55, 0x08, 0x03, 0x10, 0x54} },
+	{ {0x65, 0x10, 0x03, 0x11, 0x11} },
+	{ {0x51, 0x10, 0x03, 0x10, 0x51} }, /* case-25 */
+	{ {0x51, 0x08, 0x03, 0x10, 0x50} }
 };
 
+/* Non-Shared-Antenna TDMA */
+static const struct coex_tdma_para tdma_nsant_8822c[] = {
+	{ {0x00, 0x00, 0x00, 0x00, 0x00} }, /* case-100 */
+	{ {0x61, 0x45, 0x03, 0x11, 0x11} },
+	{ {0x61, 0x3a, 0x03, 0x11, 0x11} },
+	{ {0x61, 0x30, 0x03, 0x11, 0x11} },
+	{ {0x61, 0x20, 0x03, 0x11, 0x11} },
+	{ {0x61, 0x10, 0x03, 0x11, 0x11} }, /* case-105 */
+	{ {0x61, 0x45, 0x03, 0x11, 0x10} },
+	{ {0x61, 0x3a, 0x03, 0x11, 0x10} },
+	{ {0x61, 0x30, 0x03, 0x11, 0x10} },
+	{ {0x61, 0x20, 0x03, 0x11, 0x10} },
+	{ {0x61, 0x10, 0x03, 0x11, 0x10} }, /* case-110 */
+	{ {0x61, 0x08, 0x03, 0x11, 0x14} },
+	{ {0x61, 0x08, 0x03, 0x10, 0x14} },
+	{ {0x51, 0x08, 0x03, 0x10, 0x54} },
+	{ {0x51, 0x08, 0x03, 0x10, 0x55} },
+	{ {0x51, 0x08, 0x07, 0x10, 0x54} }, /* case-115 */
+	{ {0x51, 0x45, 0x03, 0x10, 0x50} },
+	{ {0x51, 0x3a, 0x03, 0x10, 0x50} },
+	{ {0x51, 0x30, 0x03, 0x10, 0x50} },
+	{ {0x51, 0x20, 0x03, 0x10, 0x50} },
+	{ {0x51, 0x10, 0x03, 0x10, 0x50} }  /* case-120 */
+};
+
+/* rssi in percentage % (dbm = % - 100) */
+static const u8 wl_rssi_step_8822c[] = {60, 50, 44, 30};
+static const u8 bt_rssi_step_8822c[] = {8, 15, 20, 25};
+static const struct coex_5g_afh_map afh_5g_8822c[] = { {0, 0, 0} };
+
+/* wl_tx_dec_power, bt_tx_dec_power, wl_rx_gain, bt_rx_lna_constrain */
+static const struct coex_rf_para rf_para_tx_8822c[] = {
+	{0, 0, false, 7},  /* for normal */
+	{0, 16, false, 7}, /* for WL-CPT */
+	{8, 17, true, 4},
+	{7, 18, true, 4},
+	{6, 19, true, 4},
+	{5, 20, true, 4}
+};
+
+static const struct coex_rf_para rf_para_rx_8822c[] = {
+	{0, 0, false, 7},  /* for normal */
+	{0, 16, false, 7}, /* for WL-CPT */
+	{3, 24, true, 5},
+	{2, 26, true, 5},
+	{1, 27, true, 5},
+	{0, 28, true, 5}
+};
+
+static_assert(ARRAY_SIZE(rf_para_tx_8822c) == ARRAY_SIZE(rf_para_rx_8822c));
+
 struct rtw_chip_info rtw8822c_hw_spec = {
 	.ops = &rtw8822c_ops,
 	.id = RTW_CHIP_TYPE_8822C,
@@ -2272,6 +2589,32 @@ struct rtw_chip_info rtw8822c_hw_spec = {
 	.rf_tbl = {&rtw8822c_rf_a_tbl, &rtw8822c_rf_b_tbl},
 	.rfe_defs = rtw8822c_rfe_defs,
 	.rfe_defs_size = ARRAY_SIZE(rtw8822c_rfe_defs),
+
+	.coex_para_ver = 0x19062706,
+	.bt_desired_ver = 0x6,
+	.scbd_support = true,
+	.new_scbd10_def = true,
+	.pstdma_type = COEX_PSTDMA_FORCE_LPSOFF,
+	.bt_rssi_type = COEX_BTRSSI_DBM,
+	.ant_isolation = 15,
+	.rssi_tolerance = 2,
+	.wl_rssi_step = wl_rssi_step_8822c,
+	.bt_rssi_step = bt_rssi_step_8822c,
+	.table_sant_num = ARRAY_SIZE(table_sant_8822c),
+	.table_sant = table_sant_8822c,
+	.table_nsant_num = ARRAY_SIZE(table_nsant_8822c),
+	.table_nsant = table_nsant_8822c,
+	.tdma_sant_num = ARRAY_SIZE(tdma_sant_8822c),
+	.tdma_sant = tdma_sant_8822c,
+	.tdma_nsant_num = ARRAY_SIZE(tdma_nsant_8822c),
+	.tdma_nsant = tdma_nsant_8822c,
+	.wl_rf_para_num = ARRAY_SIZE(rf_para_tx_8822c),
+	.wl_rf_para_tx = rf_para_tx_8822c,
+	.wl_rf_para_rx = rf_para_rx_8822c,
+	.bt_afh_span_bw20 = 0x24,
+	.bt_afh_span_bw40 = 0x36,
+	.afh_5g_num = ARRAY_SIZE(afh_5g_8822c),
+	.afh_5g = afh_5g_8822c,
 };
 EXPORT_SYMBOL(rtw8822c_hw_spec);
 
-- 
2.7.4

