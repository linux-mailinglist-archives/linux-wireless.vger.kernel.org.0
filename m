Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D84D17DA20
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Mar 2020 08:59:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725942AbgCIH7I (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Mar 2020 03:59:08 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:57821 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbgCIH7I (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Mar 2020 03:59:08 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID 0297wvsB011846, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTEXMB06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id 0297wvsB011846
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 9 Mar 2020 15:58:57 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 9 Mar 2020 15:58:57 +0800
Received: from localhost.localdomain (172.21.68.128) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 9 Mar 2020 15:58:57 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>
Subject: [PATCH v2 1/2] rtw88: add a debugfs entry to dump coex's info
Date:   Mon, 9 Mar 2020 15:58:51 +0800
Message-ID: <20200309075852.11454-2-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200309075852.11454-1-yhchuang@realtek.com>
References: <20200309075852.11454-1-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.128]
X-ClientProxiedBy: RTEXMB03.realtek.com.tw (172.21.6.96) To
 RTEXMB04.realtek.com.tw (172.21.6.97)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Yan-Hsuan Chuang <yhchuang@realtek.com>

Add a new entry "coex_info" in debugfs to dump coex's states for
us to debug on coex's issues.

The basic concept for co-existence (coex, usually for WiFi + BT)
is to decide a strategy based on the current status of WiFi and
BT. So, it means the WiFi driver requires to gather information
from BT side and choose a strategy (TDMA/table/HW settings).

Althrough we can easily check the current status of WiFi, e.g.,
from kernel log or just dump the hardware registers, it is still
very difficult for us to gather so many different types of WiFi
states (such as RFE config, antenna, channel/band, TRX, Power
save). Also we will need BT's information that is stored in
"struct rtw_coex". So it is necessary for us to have a debugfs
that can dump all of the WiFi/BT information required.

Note that to debug on coex related issues, we usually need a
longer period of time of coex_info dump every 2 seconds (for
example, 30 secs, so we should have 15 times of coex_info's
dump).

Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---

v1 -> v2
 * don't ignore "ignore wlan command"

 drivers/net/wireless/realtek/rtw88/coex.c     | 492 ++++++++++++++++++
 drivers/net/wireless/realtek/rtw88/coex.h     |  10 +
 drivers/net/wireless/realtek/rtw88/debug.c    |  17 +
 drivers/net/wireless/realtek/rtw88/main.h     |  18 +
 drivers/net/wireless/realtek/rtw88/rtw8822b.c |  30 ++
 drivers/net/wireless/realtek/rtw88/rtw8822c.c |  28 +
 6 files changed, 595 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/coex.c b/drivers/net/wireless/realtek/rtw88/coex.c
index f91dc21a8bf1..2dd95c8acd93 100644
--- a/drivers/net/wireless/realtek/rtw88/coex.c
+++ b/drivers/net/wireless/realtek/rtw88/coex.c
@@ -483,6 +483,94 @@ static struct sk_buff *rtw_coex_info_request(struct rtw_dev *rtwdev,
 	return skb_resp;
 }
 
+static bool rtw_coex_get_bt_reg(struct rtw_dev *rtwdev,
+				u8 type, u16 addr, u16 *val)
+{
+	struct rtw_coex_info_req req = {0};
+	struct sk_buff *skb;
+	__le16 le_addr;
+	u8 *payload;
+
+	le_addr = cpu_to_le16(addr);
+	req.op_code = BT_MP_INFO_OP_READ_REG;
+	req.para1 = type;
+	req.para2 = le16_get_bits(le_addr, GENMASK(7, 0));
+	req.para3 = le16_get_bits(le_addr, GENMASK(15, 8));
+	skb = rtw_coex_info_request(rtwdev, &req);
+	if (!skb) {
+		*val = 0xeaea;
+		return false;
+	}
+
+	payload = get_payload_from_coex_resp(skb);
+	*val = GET_COEX_RESP_BT_REG_VAL(payload);
+
+	return true;
+}
+
+static bool rtw_coex_get_bt_patch_version(struct rtw_dev *rtwdev,
+					  u32 *patch_version)
+{
+	struct rtw_coex_info_req req = {0};
+	struct sk_buff *skb;
+	u8 *payload;
+	bool ret = false;
+
+	req.op_code = BT_MP_INFO_OP_PATCH_VER;
+	skb = rtw_coex_info_request(rtwdev, &req);
+	if (!skb)
+		goto out;
+
+	payload = get_payload_from_coex_resp(skb);
+	*patch_version = GET_COEX_RESP_BT_PATCH_VER(payload);
+	ret = true;
+
+out:
+	return ret;
+}
+
+static bool rtw_coex_get_bt_supported_version(struct rtw_dev *rtwdev,
+					      u32 *supported_version)
+{
+	struct rtw_coex_info_req req = {0};
+	struct sk_buff *skb;
+	u8 *payload;
+	bool ret = false;
+
+	req.op_code = BT_MP_INFO_OP_SUPP_VER;
+	skb = rtw_coex_info_request(rtwdev, &req);
+	if (!skb)
+		goto out;
+
+	payload = get_payload_from_coex_resp(skb);
+	*supported_version = GET_COEX_RESP_BT_SUPP_VER(payload);
+	ret = true;
+
+out:
+	return ret;
+}
+
+static bool rtw_coex_get_bt_supported_feature(struct rtw_dev *rtwdev,
+					      u32 *supported_feature)
+{
+	struct rtw_coex_info_req req = {0};
+	struct sk_buff *skb;
+	u8 *payload;
+	bool ret = false;
+
+	req.op_code = BT_MP_INFO_OP_SUPP_FEAT;
+	skb = rtw_coex_info_request(rtwdev, &req);
+	if (!skb)
+		goto out;
+
+	payload = get_payload_from_coex_resp(skb);
+	*supported_feature = GET_COEX_RESP_BT_SUPP_FEAT(payload);
+	ret = true;
+
+out:
+	return ret;
+}
+
 static bool rtw_coex_get_bt_scan_type(struct rtw_dev *rtwdev, u8 *scan_type)
 {
 	struct rtw_coex_info_req req = {0};
@@ -2503,3 +2591,407 @@ void rtw_coex_defreeze_work(struct work_struct *work)
 	rtw_coex_run_coex(rtwdev, COEX_RSN_WLSTATUS);
 	mutex_unlock(&rtwdev->mutex);
 }
+
+#ifdef CONFIG_RTW88_DEBUGFS
+#define INFO_SIZE	80
+
+#define case_BTINFO(src) \
+	case COEX_BTINFO_SRC_##src: return #src
+
+static const char *rtw_coex_get_bt_info_src_string(u8 bt_info_src)
+{
+	switch (bt_info_src) {
+	case_BTINFO(WL_FW);
+	case_BTINFO(BT_RSP);
+	case_BTINFO(BT_ACT);
+	default:
+		return "Unknown";
+	}
+}
+
+#define case_RSN(src) \
+	case COEX_RSN_##src: return #src
+
+static const char *rtw_coex_get_reason_string(u8 reason)
+{
+	switch (reason) {
+	case_RSN(2GSCANSTART);
+	case_RSN(5GSCANSTART);
+	case_RSN(SCANFINISH);
+	case_RSN(2GSWITCHBAND);
+	case_RSN(5GSWITCHBAND);
+	case_RSN(2GCONSTART);
+	case_RSN(5GCONSTART);
+	case_RSN(2GCONFINISH);
+	case_RSN(5GCONFINISH);
+	case_RSN(2GMEDIA);
+	case_RSN(5GMEDIA);
+	case_RSN(MEDIADISCON);
+	case_RSN(BTINFO);
+	case_RSN(LPS);
+	case_RSN(WLSTATUS);
+	default:
+		return "Unknown";
+	}
+}
+
+static int rtw_coex_addr_info(struct rtw_dev *rtwdev,
+			      const struct rtw_reg_domain *reg,
+			      char addr_info[], int n)
+{
+	const char *rf_prefix = "";
+	const char *sep = n == 0 ? "" : "/ ";
+	int ffs, fls;
+	int max_fls;
+
+	if (INFO_SIZE - n <= 0)
+		return 0;
+
+	switch (reg->domain) {
+	case RTW_REG_DOMAIN_MAC32:
+		max_fls = 31;
+		break;
+	case RTW_REG_DOMAIN_MAC16:
+		max_fls = 15;
+		break;
+	case RTW_REG_DOMAIN_MAC8:
+		max_fls = 7;
+		break;
+	case RTW_REG_DOMAIN_RF_A:
+	case RTW_REG_DOMAIN_RF_B:
+		rf_prefix = "RF_";
+		max_fls = 19;
+		break;
+	default:
+		return 0;
+	}
+
+	ffs = __ffs(reg->mask);
+	fls = __fls(reg->mask);
+
+	if (ffs == 0 && fls == max_fls)
+		return snprintf(addr_info + n, INFO_SIZE - n, "%s%s%x",
+				sep, rf_prefix, reg->addr);
+	else if (ffs == fls)
+		return snprintf(addr_info + n, INFO_SIZE - n, "%s%s%x[%d]",
+				sep, rf_prefix, reg->addr, ffs);
+	else
+		return snprintf(addr_info + n, INFO_SIZE - n, "%s%s%x[%d:%d]",
+				sep, rf_prefix, reg->addr, fls, ffs);
+}
+
+static int rtw_coex_val_info(struct rtw_dev *rtwdev,
+			     const struct rtw_reg_domain *reg,
+			     char val_info[], int n)
+{
+	const char *sep = n == 0 ? "" : "/ ";
+	u8 rf_path;
+
+	if (INFO_SIZE - n <= 0)
+		return 0;
+
+	switch (reg->domain) {
+	case RTW_REG_DOMAIN_MAC32:
+		return snprintf(val_info + n, INFO_SIZE - n, "%s0x%x", sep,
+				rtw_read32_mask(rtwdev, reg->addr, reg->mask));
+	case RTW_REG_DOMAIN_MAC16:
+		return snprintf(val_info + n, INFO_SIZE - n, "%s0x%x", sep,
+				rtw_read16_mask(rtwdev, reg->addr, reg->mask));
+	case RTW_REG_DOMAIN_MAC8:
+		return snprintf(val_info + n, INFO_SIZE - n, "%s0x%x", sep,
+				rtw_read8_mask(rtwdev, reg->addr, reg->mask));
+	case RTW_REG_DOMAIN_RF_A:
+		rf_path = RF_PATH_A;
+		break;
+	case RTW_REG_DOMAIN_RF_B:
+		rf_path = RF_PATH_B;
+		break;
+	default:
+		return 0;
+	}
+
+	/* only RF go through here */
+	return snprintf(val_info + n, INFO_SIZE - n, "%s0x%x", sep,
+			rtw_read_rf(rtwdev, rf_path, reg->addr, reg->mask));
+}
+
+static void rtw_coex_set_coexinfo_hw(struct rtw_dev *rtwdev, struct seq_file *m)
+{
+	struct rtw_chip_info *chip = rtwdev->chip;
+	const struct rtw_reg_domain *reg;
+	char addr_info[INFO_SIZE];
+	int n_addr = 0;
+	char val_info[INFO_SIZE];
+	int n_val = 0;
+	int i;
+
+	for (i = 0; i < chip->coex_info_hw_regs_num; i++) {
+		reg = &chip->coex_info_hw_regs[i];
+
+		n_addr += rtw_coex_addr_info(rtwdev, reg, addr_info, n_addr);
+		n_val += rtw_coex_val_info(rtwdev, reg, val_info, n_val);
+
+		if (reg->domain == RTW_REG_DOMAIN_NL) {
+			seq_printf(m, "%-40s = %s\n", addr_info, val_info);
+			n_addr = 0;
+			n_val = 0;
+		}
+	}
+
+	if (n_addr != 0 && n_val != 0)
+		seq_printf(m, "%-40s = %s\n", addr_info, val_info);
+}
+
+struct rtw_coex_sta_stat_iter_data {
+	struct rtw_vif *rtwvif;
+	struct seq_file *file;
+};
+
+static void rtw_coex_sta_stat_iter(void *data, struct ieee80211_sta *sta)
+{
+	struct rtw_coex_sta_stat_iter_data *sta_iter_data = data;
+	struct rtw_vif *rtwvif = sta_iter_data->rtwvif;
+	struct rtw_sta_info *si = (struct rtw_sta_info *)sta->drv_priv;
+	struct seq_file *m = sta_iter_data->file;
+	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif);
+	u8 rssi;
+
+	if (si->vif != vif)
+		return;
+
+	rssi = ewma_rssi_read(&si->avg_rssi);
+	seq_printf(m, "\tPeer %3d\n", si->mac_id);
+	seq_printf(m, "\t\t%-24s = %d\n", "RSSI", rssi);
+	seq_printf(m, "\t\t%-24s = %d\n", "BW mode", si->bw_mode);
+}
+
+struct rtw_coex_vif_stat_iter_data {
+	struct rtw_dev *rtwdev;
+	struct seq_file *file;
+};
+
+static void rtw_coex_vif_stat_iter(void *data, u8 *mac,
+				   struct ieee80211_vif *vif)
+{
+	struct rtw_coex_vif_stat_iter_data *vif_iter_data = data;
+	struct rtw_coex_sta_stat_iter_data sta_iter_data;
+	struct rtw_dev *rtwdev = vif_iter_data->rtwdev;
+	struct rtw_vif *rtwvif = (struct rtw_vif *)vif->drv_priv;
+	struct seq_file *m = vif_iter_data->file;
+	struct ieee80211_bss_conf *bss_conf = &vif->bss_conf;
+
+	seq_printf(m, "Iface on Port (%d)\n", rtwvif->port);
+	seq_printf(m, "\t%-32s = %d\n",
+		   "Beacon interval", bss_conf->beacon_int);
+	seq_printf(m, "\t%-32s = %d\n",
+		   "Network Type", rtwvif->net_type);
+
+	sta_iter_data.rtwvif = rtwvif;
+	sta_iter_data.file = m;
+	rtw_iterate_stas_atomic(rtwdev, rtw_coex_sta_stat_iter,
+				&sta_iter_data);
+}
+
+void rtw_coex_display_coex_info(struct rtw_dev *rtwdev, struct seq_file *m)
+{
+	struct rtw_chip_info *chip = rtwdev->chip;
+	struct rtw_dm_info *dm_info = &rtwdev->dm_info;
+	struct rtw_coex *coex = &rtwdev->coex;
+	struct rtw_coex_stat *coex_stat = &coex->stat;
+	struct rtw_coex_dm *coex_dm = &coex->dm;
+	struct rtw_hal *hal = &rtwdev->hal;
+	struct rtw_efuse *efuse = &rtwdev->efuse;
+	struct rtw_fw_state *fw = &rtwdev->fw;
+	struct rtw_coex_vif_stat_iter_data vif_iter_data;
+	u8 reason = coex_dm->reason;
+	u8 sys_lte;
+	u16 score_board_WB, score_board_BW;
+	u32 wl_reg_6c0, wl_reg_6c4, wl_reg_6c8, wl_reg_778, wl_reg_6cc;
+	u32 lte_coex, bt_coex;
+	u32 bt_hi_pri, bt_lo_pri;
+	int i;
+
+	score_board_BW = rtw_coex_read_scbd(rtwdev);
+	score_board_WB = coex_stat->score_board;
+	wl_reg_6c0 = rtw_read32(rtwdev, 0x6c0);
+	wl_reg_6c4 = rtw_read32(rtwdev, 0x6c4);
+	wl_reg_6c8 = rtw_read32(rtwdev, 0x6c8);
+	wl_reg_6cc = rtw_read32(rtwdev, 0x6cc);
+	wl_reg_778 = rtw_read32(rtwdev, 0x778);
+	bt_hi_pri = rtw_read32(rtwdev, 0x770);
+	bt_lo_pri = rtw_read32(rtwdev, 0x774);
+	rtw_write8(rtwdev, 0x76e, 0xc);
+	sys_lte = rtw_read8(rtwdev, 0x73);
+	lte_coex = rtw_coex_read_indirect_reg(rtwdev, 0x38);
+	bt_coex = rtw_coex_read_indirect_reg(rtwdev, 0x54);
+
+	if (!coex_stat->bt_disabled && !coex_stat->bt_mailbox_reply) {
+		rtw_coex_get_bt_supported_version(rtwdev,
+				&coex_stat->bt_supported_version);
+		rtw_coex_get_bt_patch_version(rtwdev, &coex_stat->patch_ver);
+		rtw_coex_get_bt_supported_feature(rtwdev,
+				&coex_stat->bt_supported_feature);
+		rtw_coex_get_bt_reg(rtwdev, 3, 0xae, &coex_stat->bt_reg_vendor_ae);
+		rtw_coex_get_bt_reg(rtwdev, 3, 0xac, &coex_stat->bt_reg_vendor_ac);
+
+		if (coex_stat->patch_ver != 0)
+			coex_stat->bt_mailbox_reply = true;
+	}
+
+	seq_printf(m, "**********************************************\n");
+	seq_printf(m, "\t\tBT Coexist info %x\n", chip->id);
+	seq_printf(m, "**********************************************\n");
+	seq_printf(m, "%-40s = %s/ %d\n",
+		   "Mech/ RFE",
+		   efuse->share_ant ? "Shared" : "Non-Shared",
+		   efuse->rfe_option);
+	seq_printf(m, "%-40s = %08x/ 0x%02x/ 0x%08x %s\n",
+		   "Coex Ver/ BT Dez/ BT Rpt",
+		   chip->coex_para_ver, chip->bt_desired_ver,
+		   coex_stat->bt_supported_version,
+		   coex_stat->bt_disabled ? "(BT disabled)" :
+		   coex_stat->bt_supported_version >= chip->bt_desired_ver ?
+		   "(Match)" : "(Mismatch)");
+	seq_printf(m, "%-40s = %s/ %u/ %d\n",
+		   "Role/ RoleSwCnt/ IgnWL/ Feature",
+		   coex_stat->bt_slave ? "Slave" : "Master",
+		   coex_stat->cnt_bt[COEX_CNT_BT_ROLESWITCH],
+		   coex_dm->ignore_wl_act);
+	seq_printf(m, "%-40s = %u.%u/ 0x%x/ %c\n",
+		   "WL FW/ BT FW/ KT",
+		   fw->version, fw->sub_version,
+		   coex_stat->patch_ver, coex_stat->kt_ver + 65);
+	seq_printf(m, "%-40s = %u/ %u/ %u/ ch-(%u)\n",
+		   "AFH Map",
+		   coex_dm->wl_ch_info[0], coex_dm->wl_ch_info[1],
+		   coex_dm->wl_ch_info[2], hal->current_channel);
+
+	seq_printf(m, "**********************************************\n");
+	seq_printf(m, "\t\tBT Status\n");
+	seq_printf(m, "**********************************************\n");
+	seq_printf(m, "%-40s = %s/ %ddBm/ %u/ %u\n",
+		   "BT status/ rssi/ retry/ pop",
+		   coex_dm->bt_status == COEX_BTSTATUS_NCON_IDLE ? "non-conn" :
+		   coex_dm->bt_status == COEX_BTSTATUS_CON_IDLE ? "conn-idle" : "busy",
+		   coex_stat->bt_rssi - 100,
+		   coex_stat->cnt_bt[COEX_CNT_BT_RETRY],
+		   coex_stat->cnt_bt[COEX_CNT_BT_POPEVENT]);
+	seq_printf(m, "%-40s = %s%s%s%s%s (multi-link %d)\n",
+		   "Profiles",
+		   coex_stat->bt_a2dp_exist ? (coex_stat->bt_a2dp_sink ?
+					       "A2DP sink," : "A2DP,") : "",
+		   coex_stat->bt_hfp_exist ? "HFP," : "",
+		   coex_stat->bt_hid_exist ?
+		   (coex_stat->bt_ble_exist ? "HID(RCU)," :
+		    coex_stat->bt_hid_slot >= 2 ? "HID(4/18)" :
+		    "HID(2/18),") : "",
+		   coex_stat->bt_pan_exist ? coex_stat->bt_opp_exist ?
+		   "OPP," : "PAN," : "",
+		   coex_stat->bt_ble_voice ? "Voice," : "",
+		   coex_stat->bt_multi_link);
+	seq_printf(m, "%-40s = %u/ %u/ %u/ 0x%08x\n",
+		   "Reinit/ Relink/ IgnWl/ Feature",
+		   coex_stat->cnt_bt[COEX_CNT_BT_REINIT],
+		   coex_stat->cnt_bt[COEX_CNT_BT_SETUPLINK],
+		   coex_stat->cnt_bt[COEX_CNT_BT_IGNWLANACT],
+		   coex_stat->bt_supported_feature);
+	seq_printf(m, "%-40s = %u/ %u/ %u/ %u\n",
+		   "Page/ Inq/ iqk/ iqk fail",
+		   coex_stat->cnt_bt[COEX_CNT_BT_PAGE],
+		   coex_stat->cnt_bt[COEX_CNT_BT_INQ],
+		   coex_stat->cnt_bt[COEX_CNT_BT_IQK],
+		   coex_stat->cnt_bt[COEX_CNT_BT_IQKFAIL]);
+	seq_printf(m, "%-40s = 0x%04x/ 0x%04x/ 0x%04x/ 0x%04x\n",
+		   "0xae/ 0xac/ score board (W->B)/ (B->W)",
+		   coex_stat->bt_reg_vendor_ae,
+		   coex_stat->bt_reg_vendor_ac,
+		   score_board_WB, score_board_BW);
+	seq_printf(m, "%-40s = %u/%u, %u/%u\n",
+		   "Hi-Pri TX/RX, Lo-Pri TX/RX",
+		   bt_hi_pri & 0xffff, bt_hi_pri >> 16,
+		   bt_lo_pri & 0xffff, bt_lo_pri >> 16);
+	for (i = 0; i < COEX_BTINFO_SRC_BT_IQK; i++)
+		seq_printf(m, "%-40s = %7ph\n",
+			   rtw_coex_get_bt_info_src_string(i),
+			   coex_stat->bt_info_c2h[i]);
+
+	seq_printf(m, "**********************************************\n");
+	seq_printf(m, "\t\tWiFi Status\n");
+	seq_printf(m, "**********************************************\n");
+	seq_printf(m, "%-40s = %d\n",
+		   "Scanning", test_bit(RTW_FLAG_SCANNING, rtwdev->flags));
+	seq_printf(m, "%-40s = %u/ TX %d Mbps/ RX %d Mbps\n",
+		   "G_busy/ TX/ RX",
+		   coex_stat->wl_gl_busy,
+		   rtwdev->stats.tx_throughput, rtwdev->stats.rx_throughput);
+	seq_printf(m, "%-40s = %u/ %u/ %u\n",
+		   "IPS/ Low Power/ PS mode",
+		   test_bit(RTW_FLAG_INACTIVE_PS, rtwdev->flags),
+		   test_bit(RTW_FLAG_LEISURE_PS_DEEP, rtwdev->flags),
+		   rtwdev->lps_conf.mode);
+
+	vif_iter_data.rtwdev = rtwdev;
+	vif_iter_data.file = m;
+	rtw_iterate_vifs_atomic(rtwdev, rtw_coex_vif_stat_iter, &vif_iter_data);
+
+	seq_printf(m, "**********************************************\n");
+	seq_printf(m, "\t\tMechanism\n");
+	seq_printf(m, "**********************************************\n");
+	seq_printf(m, "%-40s = %5ph (case-%d)\n",
+		   "TDMA",
+		   coex_dm->ps_tdma_para, coex_dm->cur_ps_tdma);
+	seq_printf(m, "%-40s = %d\n",
+		   "Timer base", coex_stat->tdma_timer_base);
+	seq_printf(m, "%-40s = %d/ 0x%08x/ 0x%08x/ 0x%08x\n",
+		   "Table/ 0x6c0/ 0x6c4/ 0x6c8",
+		   coex_dm->cur_table, wl_reg_6c0, wl_reg_6c4, wl_reg_6c8);
+	seq_printf(m, "%-40s = 0x%08x/ 0x%08x/ reason (%s)\n",
+		   "0x778/ 0x6cc/ Reason",
+		   wl_reg_778, wl_reg_6cc, rtw_coex_get_reason_string(reason));
+	seq_printf(m, "%-40s = %u/ %u/ %u/ %u/ %u\n",
+		   "Null All/ Retry/ Ack/ BT Empty/ BT Late",
+		   coex_stat->wl_fw_dbg_info[1], coex_stat->wl_fw_dbg_info[2],
+		   coex_stat->wl_fw_dbg_info[3], coex_stat->wl_fw_dbg_info[4],
+		   coex_stat->wl_fw_dbg_info[5]);
+	seq_printf(m, "%-40s = %u/ %u/ %s/ %u\n",
+		   "Cnt TDMA Toggle/ Lk 5ms/ Lk 5ms on/ FW",
+		   coex_stat->wl_fw_dbg_info[6],
+		   coex_stat->wl_fw_dbg_info[7],
+		   coex_stat->wl_slot_extend ? "Yes" : "No",
+		   coex_stat->cnt_wl[COEX_CNT_WL_FW_NOTIFY]);
+
+	seq_printf(m, "**********************************************\n");
+	seq_printf(m, "\t\tHW setting\n");
+	seq_printf(m, "**********************************************\n");
+	seq_printf(m, "%-40s = %s/ %s\n",
+		   "LTE Coex/ Path Owner",
+		   lte_coex & BIT(7) ? "ON" : "OFF",
+		   sys_lte & BIT(2) ? "WL" : "BT");
+	seq_printf(m, "%-40s = RF:%s_BB:%s/ RF:%s_BB:%s/ %s\n",
+		   "GNT_WL_CTRL/ GNT_BT_CTRL/ Dbg",
+		   lte_coex & BIT(12) ? "SW" : "HW",
+		   lte_coex & BIT(8) ? "SW" : "HW",
+		   lte_coex & BIT(14) ? "SW" : "HW",
+		   lte_coex & BIT(10) ? "SW" : "HW",
+		   sys_lte & BIT(3) ? "On" : "Off");
+	seq_printf(m, "%-40s = %lu/ %lu\n",
+		   "GNT_WL/ GNT_BT",
+		   (bt_coex & BIT(2)) >> 2, (bt_coex & BIT(3)) >> 3);
+	seq_printf(m, "%-40s = %u/ %u/ %u/ %u\n",
+		   "CRC OK CCK/ OFDM/ HT/ VHT",
+		   dm_info->cck_ok_cnt, dm_info->ofdm_ok_cnt,
+		   dm_info->ht_ok_cnt, dm_info->vht_ok_cnt);
+	seq_printf(m, "%-40s = %u/ %u/ %u/ %u\n",
+		   "CRC ERR CCK/ OFDM/ HT/ VHT",
+		   dm_info->cck_err_cnt, dm_info->ofdm_err_cnt,
+		   dm_info->ht_err_cnt, dm_info->vht_err_cnt);
+	seq_printf(m, "%-40s = %s/ %s/ %s/ %u\n",
+		   "HiPr/ Locking/ Locked/ Noisy",
+		   coex_stat->wl_hi_pri_task1 ? "Y" : "N",
+		   coex_stat->wl_cck_lock ? "Y" : "N",
+		   coex_stat->wl_cck_lock_ever ? "Y" : "N",
+		   coex_stat->wl_noisy_level);
+
+	rtw_coex_set_coexinfo_hw(rtwdev, m);
+}
+#endif /* CONFIG_RTW88_DEBUGFS */
diff --git a/drivers/net/wireless/realtek/rtw88/coex.h b/drivers/net/wireless/realtek/rtw88/coex.h
index 008d1af5996b..4c3a01968f5e 100644
--- a/drivers/net/wireless/realtek/rtw88/coex.h
+++ b/drivers/net/wireless/realtek/rtw88/coex.h
@@ -46,6 +46,14 @@
 	   (__rssi__ == COEX_RSSI_STATE_LOW || \
 	    __rssi__ == COEX_RSSI_STATE_STAY_LOW ? true : false); })
 
+#define GET_COEX_RESP_BT_SUPP_VER(payload)				\
+	le64_get_bits(*((__le64 *)(payload)), GENMASK_ULL(39, 32))
+#define GET_COEX_RESP_BT_SUPP_FEAT(payload)				\
+	le64_get_bits(*((__le64 *)(payload)), GENMASK_ULL(39, 24))
+#define GET_COEX_RESP_BT_PATCH_VER(payload)				\
+	le64_get_bits(*((__le64 *)(payload)), GENMASK_ULL(55, 24))
+#define GET_COEX_RESP_BT_REG_VAL(payload)				\
+	le64_get_bits(*((__le64 *)(payload)), GENMASK_ULL(39, 24))
 #define GET_COEX_RESP_BT_SCAN_TYPE(payload)				\
 	le64_get_bits(*((__le64 *)(payload)), GENMASK(31, 24))
 
@@ -367,4 +375,6 @@ void rtw_coex_wl_fwdbginfo_notify(struct rtw_dev *rtwdev, u8 *buf, u8 length);
 void rtw_coex_switchband_notify(struct rtw_dev *rtwdev, u8 type);
 void rtw_coex_wl_status_change_notify(struct rtw_dev *rtwdev);
 
+void rtw_coex_display_coex_info(struct rtw_dev *rtwdev, struct seq_file *m);
+
 #endif
diff --git a/drivers/net/wireless/realtek/rtw88/debug.c b/drivers/net/wireless/realtek/rtw88/debug.c
index 5a181e01ebef..b2d264270752 100644
--- a/drivers/net/wireless/realtek/rtw88/debug.c
+++ b/drivers/net/wireless/realtek/rtw88/debug.c
@@ -5,6 +5,7 @@
 #include <linux/debugfs.h>
 #include <linux/seq_file.h>
 #include "main.h"
+#include "coex.h"
 #include "sec.h"
 #include "fw.h"
 #include "debug.h"
@@ -691,6 +692,17 @@ static int rtw_debugfs_get_phy_info(struct seq_file *m, void *v)
 		   dm_info->ht_ok_cnt, dm_info->ht_err_cnt);
 	seq_printf(m, " * VHT cnt (ok, err) = (%u, %u)\n",
 		   dm_info->vht_ok_cnt, dm_info->vht_err_cnt);
+
+	return 0;
+}
+
+static int rtw_debugfs_get_coex_info(struct seq_file *m, void *v)
+{
+	struct rtw_debugfs_priv *debugfs_priv = m->private;
+	struct rtw_dev *rtwdev = debugfs_priv->rtwdev;
+
+	rtw_coex_display_coex_info(rtwdev, m);
+
 	return 0;
 }
 
@@ -784,6 +796,10 @@ static struct rtw_debugfs_priv rtw_debug_priv_phy_info = {
 	.cb_read = rtw_debugfs_get_phy_info,
 };
 
+static struct rtw_debugfs_priv rtw_debug_priv_coex_info = {
+	.cb_read = rtw_debugfs_get_coex_info,
+};
+
 #define rtw_debugfs_add_core(name, mode, fopname, parent)		\
 	do {								\
 		rtw_debug_priv_ ##name.rtwdev = rtwdev;			\
@@ -814,6 +830,7 @@ void rtw_debugfs_init(struct rtw_dev *rtwdev)
 	rtw_debugfs_add_rw(dump_cam);
 	rtw_debugfs_add_rw(rsvd_page);
 	rtw_debugfs_add_r(phy_info);
+	rtw_debugfs_add_r(coex_info);
 	rtw_debugfs_add_r(mac_0);
 	rtw_debugfs_add_r(mac_1);
 	rtw_debugfs_add_r(mac_2);
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index c074cef22120..7a4afa17217c 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -515,6 +515,18 @@ struct rtw_hw_reg {
 	u32 mask;
 };
 
+struct rtw_reg_domain {
+	u32 addr;
+	u32 mask;
+#define RTW_REG_DOMAIN_MAC32	0
+#define RTW_REG_DOMAIN_MAC16	1
+#define RTW_REG_DOMAIN_MAC8	2
+#define RTW_REG_DOMAIN_RF_A	3
+#define RTW_REG_DOMAIN_RF_B	4
+#define RTW_REG_DOMAIN_NL	0xFF
+	u8 domain;
+};
+
 struct rtw_backup_info {
 	u8 len;
 	u32 reg;
@@ -1106,6 +1118,7 @@ struct rtw_chip_info {
 	u8 bt_afh_span_bw40;
 	u8 afh_5g_num;
 	u8 wl_rf_para_num;
+	u8 coex_info_hw_regs_num;
 	const u8 *bt_rssi_step;
 	const u8 *wl_rssi_step;
 	const struct coex_table_para *table_nsant;
@@ -1115,6 +1128,7 @@ struct rtw_chip_info {
 	const struct coex_rf_para *wl_rf_para_tx;
 	const struct coex_rf_para *wl_rf_para_rx;
 	const struct coex_5g_afh_map *afh_5g;
+	const struct rtw_reg_domain *coex_info_hw_regs;
 };
 
 enum rtw_coex_bt_state_cnt {
@@ -1161,6 +1175,7 @@ struct rtw_coex_rfe {
 struct rtw_coex_dm {
 	bool cur_ps_tdma_on;
 	bool cur_wl_rx_low_gain_en;
+	bool ignore_wl_act;
 
 	u8 reason;
 	u8 bt_rssi_state[4];
@@ -1241,6 +1256,9 @@ struct rtw_coex_stat {
 
 	u32 bt_supported_version;
 	u32 bt_supported_feature;
+	u32 patch_ver;
+	u16 bt_reg_vendor_ae;
+	u16 bt_reg_vendor_ac;
 	s8 bt_rssi;
 	u8 kt_ver;
 	u8 gnt_workaround_state;
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822b.c b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
index 96aa332fb28d..4dd7d4143b04 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822b.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
@@ -2371,6 +2371,33 @@ static const struct rtw_pwr_track_tbl rtw8822b_rtw_pwr_track_tbl = {
 	.pwrtrk_2g_ccka_p = rtw8822b_pwrtrk_2g_cck_a_p,
 };
 
+static const struct rtw_reg_domain coex_info_hw_regs_8822b[] = {
+	{0xcb0, MASKDWORD, RTW_REG_DOMAIN_MAC32},
+	{0xcb4, MASKDWORD, RTW_REG_DOMAIN_MAC32},
+	{0xcba, MASKBYTE0, RTW_REG_DOMAIN_MAC8},
+	{0xcbd, MASKBYTE0, RTW_REG_DOMAIN_MAC8},
+	{0xc58, MASKBYTE0, RTW_REG_DOMAIN_MAC8},
+	{0xcbd, BIT(0), RTW_REG_DOMAIN_MAC8},
+	{0, 0, RTW_REG_DOMAIN_NL},
+	{0x430, MASKDWORD, RTW_REG_DOMAIN_MAC32},
+	{0x434, MASKDWORD, RTW_REG_DOMAIN_MAC32},
+	{0x42a, MASKLWORD, RTW_REG_DOMAIN_MAC16},
+	{0x426, MASKBYTE0, RTW_REG_DOMAIN_MAC8},
+	{0x45e, BIT(3), RTW_REG_DOMAIN_MAC8},
+	{0x454, MASKLWORD, RTW_REG_DOMAIN_MAC16},
+	{0, 0, RTW_REG_DOMAIN_NL},
+	{0x4c, BIT(24) | BIT(23), RTW_REG_DOMAIN_MAC32},
+	{0x64, BIT(0), RTW_REG_DOMAIN_MAC8},
+	{0x4c6, BIT(4), RTW_REG_DOMAIN_MAC8},
+	{0x40, BIT(5), RTW_REG_DOMAIN_MAC8},
+	{0x1, RFREG_MASK, RTW_REG_DOMAIN_RF_B},
+	{0, 0, RTW_REG_DOMAIN_NL},
+	{0x550, MASKDWORD, RTW_REG_DOMAIN_MAC32},
+	{0x522, MASKBYTE0, RTW_REG_DOMAIN_MAC8},
+	{0x953, BIT(1), RTW_REG_DOMAIN_MAC8},
+	{0xc50,  MASKBYTE0, RTW_REG_DOMAIN_MAC8},
+};
+
 struct rtw_chip_info rtw8822b_hw_spec = {
 	.ops = &rtw8822b_ops,
 	.id = RTW_CHIP_TYPE_8822B,
@@ -2439,6 +2466,9 @@ struct rtw_chip_info rtw8822b_hw_spec = {
 	.bt_afh_span_bw40 = 0x36,
 	.afh_5g_num = ARRAY_SIZE(afh_5g_8822b),
 	.afh_5g = afh_5g_8822b,
+
+	.coex_info_hw_regs_num = ARRAY_SIZE(coex_info_hw_regs_8822b),
+	.coex_info_hw_regs = coex_info_hw_regs_8822b,
 };
 EXPORT_SYMBOL(rtw8822b_hw_spec);
 
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.c b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
index 146f693c7592..0c2bdafbcfd2 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
@@ -4092,6 +4092,31 @@ static const struct wiphy_wowlan_support rtw_wowlan_stub_8822c = {
 };
 #endif
 
+static const struct rtw_reg_domain coex_info_hw_regs_8822c[] = {
+	{0x1860, BIT(3), RTW_REG_DOMAIN_MAC8},
+	{0x4160, BIT(3), RTW_REG_DOMAIN_MAC8},
+	{0x1c32, BIT(6), RTW_REG_DOMAIN_MAC8},
+	{0x1c38, BIT(28), RTW_REG_DOMAIN_MAC32},
+	{0, 0, RTW_REG_DOMAIN_NL},
+	{0x430, MASKDWORD, RTW_REG_DOMAIN_MAC32},
+	{0x434, MASKDWORD, RTW_REG_DOMAIN_MAC32},
+	{0x42a, MASKLWORD, RTW_REG_DOMAIN_MAC16},
+	{0x426, MASKBYTE0, RTW_REG_DOMAIN_MAC8},
+	{0x45e, BIT(3), RTW_REG_DOMAIN_MAC8},
+	{0x454, MASKLWORD, RTW_REG_DOMAIN_MAC16},
+	{0, 0, RTW_REG_DOMAIN_NL},
+	{0x4c, BIT(24) | BIT(23), RTW_REG_DOMAIN_MAC32},
+	{0x64, BIT(0), RTW_REG_DOMAIN_MAC8},
+	{0x4c6, BIT(4), RTW_REG_DOMAIN_MAC8},
+	{0x40, BIT(5), RTW_REG_DOMAIN_MAC8},
+	{0x1, RFREG_MASK, RTW_REG_DOMAIN_RF_B},
+	{0, 0, RTW_REG_DOMAIN_NL},
+	{0x550, MASKDWORD, RTW_REG_DOMAIN_MAC32},
+	{0x522, MASKBYTE0, RTW_REG_DOMAIN_MAC8},
+	{0x953, BIT(1), RTW_REG_DOMAIN_MAC8},
+	{0xc50, MASKBYTE0, RTW_REG_DOMAIN_MAC8},
+};
+
 struct rtw_chip_info rtw8822c_hw_spec = {
 	.ops = &rtw8822c_ops,
 	.id = RTW_CHIP_TYPE_8822C,
@@ -4168,6 +4193,9 @@ struct rtw_chip_info rtw8822c_hw_spec = {
 	.bt_afh_span_bw40 = 0x36,
 	.afh_5g_num = ARRAY_SIZE(afh_5g_8822c),
 	.afh_5g = afh_5g_8822c,
+
+	.coex_info_hw_regs_num = ARRAY_SIZE(coex_info_hw_regs_8822c),
+	.coex_info_hw_regs = coex_info_hw_regs_8822c,
 };
 EXPORT_SYMBOL(rtw8822c_hw_spec);
 
-- 
2.17.1

