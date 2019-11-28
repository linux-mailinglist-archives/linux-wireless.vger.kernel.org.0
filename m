Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71DE810C891
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Nov 2019 13:19:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbfK1MTY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 Nov 2019 07:19:24 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:59539 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbfK1MTW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 Nov 2019 07:19:22 -0500
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID xASCJFDY004460, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id xASCJFDY004460
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 28 Nov 2019 20:19:15 +0800
Received: from localhost.localdomain (172.21.68.126) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.468.0; Thu, 28 Nov 2019 20:19:15 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>
Subject: [PATCH 5/6] rtw88: Add wowlan pattern match support
Date:   Thu, 28 Nov 2019 20:19:06 +0800
Message-ID: <20191128121907.6178-6-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191128121907.6178-1-yhchuang@realtek.com>
References: <20191128121907.6178-1-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.126]
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Chin-Yen Lee <timlee@realtek.com>

Pattern match is an option of wowlan to allow the device
to be woken up from suspend mode when receiving packets
matched user-designed patterns.

The patterns are written into hardware cam in suspend flow
if users have set up them. If packets matched designed
pattern are received, wowlan firmware will get an interrupt
and then wake up the device.

Signed-off-by: Chin-Yen Lee <timlee@realtek.com>
Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/fw.c       |   6 +
 drivers/net/wireless/realtek/rtw88/fw.h       |   4 +
 drivers/net/wireless/realtek/rtw88/main.h     |  14 ++
 drivers/net/wireless/realtek/rtw88/reg.h      |  14 ++
 drivers/net/wireless/realtek/rtw88/rtw8822c.c |   3 +
 drivers/net/wireless/realtek/rtw88/wow.c      | 224 ++++++++++++++++++
 drivers/net/wireless/realtek/rtw88/wow.h      |   9 +
 7 files changed, 274 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/fw.c b/drivers/net/wireless/realtek/rtw88/fw.c
index 16ff59576154..0523851cf98d 100644
--- a/drivers/net/wireless/realtek/rtw88/fw.c
+++ b/drivers/net/wireless/realtek/rtw88/fw.c
@@ -538,6 +538,8 @@ void rtw_fw_set_wowlan_ctrl_cmd(struct rtw_dev *rtwdev, bool enable)
 			SET_WOWLAN_DEAUTH_WAKEUP_ENABLE(h2c_pkt, enable);
 		if (test_bit(RTW_WOW_FLAG_EN_REKEY_PKT, rtw_wow->flags))
 			SET_WOWLAN_REKEY_WAKEUP_ENABLE(h2c_pkt, enable);
+		if (rtw_wow->pattern_cnt)
+			SET_WOWLAN_PATTERN_MATCH_ENABLE(h2c_pkt, enable);
 	}
 
 	rtw_fw_send_h2c_command(rtwdev, h2c_pkt);
@@ -596,6 +598,7 @@ void rtw_fw_set_pg_info(struct rtw_dev *rtwdev)
 	LPS_PG_INFO_LOC(h2c_pkt, loc_pg);
 	LPS_PG_DPK_LOC(h2c_pkt, loc_dpk);
 	LPS_PG_SEC_CAM_EN(h2c_pkt, conf->sec_cam_backup);
+	LPS_PG_PATTERN_CAM_EN(h2c_pkt, conf->pattern_cam_backup);
 
 	rtw_fw_send_h2c_command(rtwdev, h2c_pkt);
 }
@@ -677,6 +680,7 @@ static struct sk_buff *rtw_lps_pg_info_get(struct ieee80211_hw *hw,
 	struct rtw_chip_info *chip = rtwdev->chip;
 	struct rtw_lps_conf *conf = &rtwdev->lps_conf;
 	struct rtw_lps_pg_info_hdr *pg_info_hdr;
+	struct rtw_wow_param *rtw_wow = &rtwdev->wow;
 	struct sk_buff *skb;
 	u32 size;
 
@@ -691,8 +695,10 @@ static struct sk_buff *rtw_lps_pg_info_get(struct ieee80211_hw *hw,
 	pg_info_hdr->macid = find_first_bit(rtwdev->mac_id_map, RTW_MAX_MAC_ID_NUM);
 	pg_info_hdr->sec_cam_count =
 		rtw_sec_cam_pg_backup(rtwdev, pg_info_hdr->sec_cam);
+	pg_info_hdr->pattern_count = rtw_wow->pattern_cnt;
 
 	conf->sec_cam_backup = pg_info_hdr->sec_cam_count != 0;
+	conf->pattern_cam_backup = rtw_wow->pattern_cnt != 0;
 
 	return skb;
 }
diff --git a/drivers/net/wireless/realtek/rtw88/fw.h b/drivers/net/wireless/realtek/rtw88/fw.h
index 9ffc1b1ea895..9ea27cca11ac 100644
--- a/drivers/net/wireless/realtek/rtw88/fw.h
+++ b/drivers/net/wireless/realtek/rtw88/fw.h
@@ -246,6 +246,8 @@ static inline void rtw_h2c_pkt_set_header(u8 *h2c_pkt, u8 sub_id)
 	le32p_replace_bits((__le32 *)(h2c_pkt) + 0x00, value, GENMASK(31, 24))
 #define LPS_PG_SEC_CAM_EN(h2c_pkt, value)                                      \
 	le32p_replace_bits((__le32 *)(h2c_pkt) + 0x00, value, BIT(8))
+#define LPS_PG_PATTERN_CAM_EN(h2c_pkt, value)				       \
+	le32p_replace_bits((__le32 *)(h2c_pkt) + 0x00, value, BIT(10))
 #define SET_RSSI_INFO_MACID(h2c_pkt, value)                                    \
 	le32p_replace_bits((__le32 *)(h2c_pkt) + 0x00, value, GENMASK(15, 8))
 #define SET_RSSI_INFO_RSSI(h2c_pkt, value)                                     \
@@ -343,6 +345,8 @@ static inline void rtw_h2c_pkt_set_header(u8 *h2c_pkt, u8 sub_id)
 
 #define SET_WOWLAN_FUNC_ENABLE(h2c_pkt, value)				       \
 	le32p_replace_bits((__le32 *)(h2c_pkt) + 0x00, value, BIT(8))
+#define SET_WOWLAN_PATTERN_MATCH_ENABLE(h2c_pkt, value)			       \
+	le32p_replace_bits((__le32 *)(h2c_pkt) + 0x00, value, BIT(9))
 #define SET_WOWLAN_MAGIC_PKT_ENABLE(h2c_pkt, value)			       \
 	le32p_replace_bits((__le32 *)(h2c_pkt) + 0x00, value, BIT(10))
 #define SET_WOWLAN_UNICAST_PKT_ENABLE(h2c_pkt, value)			       \
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index e403d24adbcf..74368ef954fa 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -19,6 +19,10 @@
 #define RTW_MAX_SEC_CAM_NUM		32
 #define MAX_PG_CAM_BACKUP_NUM		8
 
+#define RTW_MAX_PATTERN_NUM		12
+#define RTW_MAX_PATTERN_MASK_SIZE	16
+#define RTW_MAX_PATTERN_SIZE		128
+
 #define RTW_WATCH_DOG_DELAY_TIME	round_jiffies_relative(HZ * 2)
 
 #define RFREG_MASK			0xfffff
@@ -623,6 +627,7 @@ struct rtw_lps_conf {
 	u8 smart_ps;
 	u8 port_id;
 	bool sec_cam_backup;
+	bool pattern_cam_backup;
 };
 
 enum rtw_hw_key_type {
@@ -917,10 +922,19 @@ struct rtw_intf_phy_para {
 	u16 platform;
 };
 
+struct rtw_wow_pattern {
+	u16 crc;
+	u8 type;
+	u8 valid;
+	u8 mask[RTW_MAX_PATTERN_MASK_SIZE];
+};
+
 struct rtw_wow_param {
 	struct ieee80211_vif *wow_vif;
 	DECLARE_BITMAP(flags, RTW_WOW_FLAG_MAX);
 	u8 txpause;
+	u8 pattern_cnt;
+	struct rtw_wow_pattern patterns[RTW_MAX_PATTERN_NUM];
 };
 
 struct rtw_intf_phy_para_table {
diff --git a/drivers/net/wireless/realtek/rtw88/reg.h b/drivers/net/wireless/realtek/rtw88/reg.h
index d09208a53b54..3b75eae8c67f 100644
--- a/drivers/net/wireless/realtek/rtw88/reg.h
+++ b/drivers/net/wireless/realtek/rtw88/reg.h
@@ -336,6 +336,20 @@
 #define BIT_RFMOD_80M		BIT(8)
 #define BIT_RFMOD_40M		BIT(7)
 #define REG_WMAC_TRXPTCL_CTL_H	0x066C
+#define REG_WKFMCAM_CMD		0x0698
+#define BIT_WKFCAM_POLLING_V1	BIT(31)
+#define BIT_WKFCAM_CLR_V1	BIT(30)
+#define BIT_WKFCAM_WE		BIT(16)
+#define BIT_SHIFT_WKFCAM_ADDR_V2	8
+#define BIT_MASK_WKFCAM_ADDR_V2		0xff
+#define BIT_WKFCAM_ADDR_V2(x)						       \
+	(((x) & BIT_MASK_WKFCAM_ADDR_V2) << BIT_SHIFT_WKFCAM_ADDR_V2)
+#define REG_WKFMCAM_RWD         0x069C
+#define BIT_WKFMCAM_VALID	BIT(31)
+#define BIT_WKFMCAM_BC		BIT(26)
+#define BIT_WKFMCAM_MC		BIT(25)
+#define BIT_WKFMCAM_UC		BIT(24)
+
 #define REG_RXFLTMAP0		0x06A0
 #define REG_RXFLTMAP1		0x06A2
 #define REG_RXFLTMAP2		0x06A4
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.c b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
index e10fe672f79c..4836c0044b05 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
@@ -4064,6 +4064,9 @@ static const struct rtw_pwr_track_tbl rtw8822c_rtw_pwr_track_tbl = {
 static const struct wiphy_wowlan_support rtw_wowlan_stub_8822c = {
 	.flags = WIPHY_WOWLAN_MAGIC_PKT | WIPHY_WOWLAN_GTK_REKEY_FAILURE |
 		 WIPHY_WOWLAN_DISCONNECT | WIPHY_WOWLAN_SUPPORTS_GTK_REKEY,
+	.n_patterns = RTW_MAX_PATTERN_NUM,
+	.pattern_max_len = RTW_MAX_PATTERN_SIZE,
+	.pattern_min_len = 1,
 };
 #endif
 
diff --git a/drivers/net/wireless/realtek/rtw88/wow.c b/drivers/net/wireless/realtek/rtw88/wow.c
index e1657d3cb615..fc9521740bc1 100644
--- a/drivers/net/wireless/realtek/rtw88/wow.c
+++ b/drivers/net/wireless/realtek/rtw88/wow.c
@@ -26,10 +26,220 @@ static void rtw_wow_show_wakeup_reason(struct rtw_dev *rtwdev)
 		rtw_dbg(rtwdev, RTW_DBG_WOW, "WOW: Rx gtk rekey\n");
 	else if (reason == RTW_WOW_RSN_RX_PTK_REKEY)
 		rtw_dbg(rtwdev, RTW_DBG_WOW, "WOW: Rx ptk rekey\n");
+	else if (reason == RTW_WOW_RSN_RX_PATTERN_MATCH)
+		rtw_dbg(rtwdev, RTW_DBG_WOW, "WOW: Rx pattern match packet\n");
 	else
 		rtw_warn(rtwdev, "Unknown wakeup reason %x\n", reason);
 }
 
+static void __rtw_wow_pattern_write_cam(struct rtw_dev *rtwdev, u8 addr,
+					u32 wdata)
+{
+	rtw_write32(rtwdev, REG_WKFMCAM_RWD, wdata);
+	rtw_write32(rtwdev, REG_WKFMCAM_CMD, BIT_WKFCAM_POLLING_V1 |
+		    BIT_WKFCAM_WE | BIT_WKFCAM_ADDR_V2(addr));
+
+	if (!check_hw_ready(rtwdev, REG_WKFMCAM_CMD, BIT_WKFCAM_POLLING_V1, 0))
+		rtw_err(rtwdev, "failed to write pattern cam\n");
+}
+
+static void __rtw_wow_pattern_write_cam_ent(struct rtw_dev *rtwdev, u8 id,
+					    struct rtw_wow_pattern *rtw_pattern)
+{
+	int i;
+	u8 addr;
+	u32 wdata;
+
+	for (i = 0; i < RTW_MAX_PATTERN_MASK_SIZE / 4; i++) {
+		addr = (id << 3) + i;
+		wdata = rtw_pattern->mask[i * 4];
+		wdata |= rtw_pattern->mask[i * 4 + 1] << 8;
+		wdata |= rtw_pattern->mask[i * 4 + 2] << 16;
+		wdata |= rtw_pattern->mask[i * 4 + 3] << 24;
+		__rtw_wow_pattern_write_cam(rtwdev, addr, wdata);
+	}
+
+	wdata = rtw_pattern->crc;
+	addr = (id << 3) + RTW_MAX_PATTERN_MASK_SIZE / 4;
+
+	switch (rtw_pattern->type) {
+	case RTW_PATTERN_BROADCAST:
+		wdata |= BIT_WKFMCAM_BC | BIT_WKFMCAM_VALID;
+		break;
+	case RTW_PATTERN_MULTICAST:
+		wdata |= BIT_WKFMCAM_MC | BIT_WKFMCAM_VALID;
+		break;
+	case RTW_PATTERN_UNICAST:
+		wdata |= BIT_WKFMCAM_UC | BIT_WKFMCAM_VALID;
+		break;
+	default:
+		break;
+	}
+	__rtw_wow_pattern_write_cam(rtwdev, addr, wdata);
+}
+
+/* RTK internal CRC16 for Pattern Cam */
+static u16 __rtw_cal_crc16(u8 data, u16 crc)
+{
+	u8 shift_in, data_bit;
+	u8 crc_bit4, crc_bit11, crc_bit15;
+	u16 crc_result;
+	int index;
+
+	for (index = 0; index < 8; index++) {
+		crc_bit15 = ((crc & BIT(15)) ? 1 : 0);
+		data_bit = (data & (BIT(0) << index) ? 1 : 0);
+		shift_in = crc_bit15 ^ data_bit;
+
+		crc_result = crc << 1;
+
+		if (shift_in == 0)
+			crc_result &= (~BIT(0));
+		else
+			crc_result |= BIT(0);
+
+		crc_bit11 = ((crc & BIT(11)) ? 1 : 0) ^ shift_in;
+
+		if (crc_bit11 == 0)
+			crc_result &= (~BIT(12));
+		else
+			crc_result |= BIT(12);
+
+		crc_bit4 = ((crc & BIT(4)) ? 1 : 0) ^ shift_in;
+
+		if (crc_bit4 == 0)
+			crc_result &= (~BIT(5));
+		else
+			crc_result |= BIT(5);
+
+		crc = crc_result;
+	}
+	return crc;
+}
+
+static u16 rtw_calc_crc(u8 *pdata, int length)
+{
+	u16 crc = 0xffff;
+	int i;
+
+	for (i = 0; i < length; i++)
+		crc = __rtw_cal_crc16(pdata[i], crc);
+
+	/* get 1' complement */
+	return ~crc;
+}
+
+static void rtw_wow_pattern_generate(struct rtw_dev *rtwdev,
+				     struct rtw_vif *rtwvif,
+				     const struct cfg80211_pkt_pattern *pkt_pattern,
+				     struct rtw_wow_pattern *rtw_pattern)
+{
+	const u8 *mask;
+	const u8 *pattern;
+	u8 mask_hw[RTW_MAX_PATTERN_MASK_SIZE] = {0};
+	u8 content[RTW_MAX_PATTERN_SIZE] = {0};
+	u8 mac_addr[ETH_ALEN] = {0};
+	u8 mask_len;
+	u16 count;
+	int len;
+	int i;
+
+	pattern = pkt_pattern->pattern;
+	len = pkt_pattern->pattern_len;
+	mask = pkt_pattern->mask;
+
+	ether_addr_copy(mac_addr, rtwvif->mac_addr);
+	memset(rtw_pattern, 0, sizeof(*rtw_pattern));
+
+	mask_len = DIV_ROUND_UP(len, 8);
+
+	if (is_broadcast_ether_addr(pattern))
+		rtw_pattern->type = RTW_PATTERN_BROADCAST;
+	else if (is_multicast_ether_addr(pattern))
+		rtw_pattern->type = RTW_PATTERN_MULTICAST;
+	else if (ether_addr_equal(pattern, mac_addr))
+		rtw_pattern->type = RTW_PATTERN_UNICAST;
+	else
+		rtw_pattern->type = RTW_PATTERN_INVALID;
+
+	/* translate mask from os to mask for hw
+	 * pattern from OS uses 'ethenet frame', like this:
+	 * |    6   |    6   |   2  |     20    |  Variable  |  4  |
+	 * |--------+--------+------+-----------+------------+-----|
+	 * |    802.3 Mac Header    | IP Header | TCP Packet | FCS |
+	 * |   DA   |   SA   | Type |
+	 *
+	 * BUT, packet catched by our HW is in '802.11 frame', begin from LLC
+	 * |     24 or 30      |    6   |   2  |     20    |  Variable  |  4  |
+	 * |-------------------+--------+------+-----------+------------+-----|
+	 * | 802.11 MAC Header |       LLC     | IP Header | TCP Packet | FCS |
+	 *		       | Others | Tpye |
+	 *
+	 * Therefore, we need translate mask_from_OS to mask_to_hw.
+	 * We should left-shift mask by 6 bits, then set the new bit[0~5] = 0,
+	 * because new mask[0~5] means 'SA', but our HW packet begins from LLC,
+	 * bit[0~5] corresponds to first 6 Bytes in LLC, they just don't match.
+	 */
+
+	/* Shift 6 bits */
+	for (i = 0; i < mask_len - 1; i++) {
+		mask_hw[i] = u8_get_bits(mask[i], GENMASK(7, 6));
+		mask_hw[i] |= u8_get_bits(mask[i + 1], GENMASK(5, 0)) << 2;
+	}
+	mask_hw[i] = u8_get_bits(mask[i], GENMASK(7, 6));
+
+	/* Set bit 0-5 to zero */
+	mask_hw[0] &= (~GENMASK(5, 0));
+
+	memcpy(rtw_pattern->mask, mask_hw, RTW_MAX_PATTERN_MASK_SIZE);
+
+	/* To get the wake up pattern from the mask.
+	 * We do not count first 12 bits which means
+	 * DA[6] and SA[6] in the pattern to match HW design.
+	 */
+	count = 0;
+	for (i = 12; i < len; i++) {
+		if ((mask[i / 8] >> (i % 8)) & 0x01) {
+			content[count] = pattern[i];
+			count++;
+		}
+	}
+
+	rtw_pattern->crc = rtw_calc_crc(content, count);
+}
+
+static void __rtw_wow_pattern_clear_cam(struct rtw_dev *rtwdev)
+{
+	bool ret;
+
+	rtw_write32(rtwdev, REG_WKFMCAM_CMD, BIT_WKFCAM_POLLING_V1 |
+		    BIT_WKFCAM_CLR_V1);
+
+	ret = check_hw_ready(rtwdev, REG_WKFMCAM_CMD, BIT_WKFCAM_POLLING_V1, 0);
+	if (!ret)
+		rtw_err(rtwdev, "failed to clean pattern cam\n");
+}
+
+static void rtw_wow_set_pattern(struct rtw_dev *rtwdev)
+{
+	struct rtw_wow_param *rtw_wow = &rtwdev->wow;
+	struct rtw_wow_pattern *rtw_pattern = rtw_wow->patterns;
+	int i = 0;
+
+	for (i = 0; i < rtw_wow->pattern_cnt; i++)
+		__rtw_wow_pattern_write_cam_ent(rtwdev, i, rtw_pattern + i);
+}
+
+static void rtw_wow_clear_pattern(struct rtw_dev *rtwdev)
+{
+	struct rtw_wow_param *rtw_wow = &rtwdev->wow;
+
+	__rtw_wow_pattern_clear_cam(rtwdev);
+
+	rtw_wow->pattern_cnt = 0;
+	memset(rtw_wow->patterns, 0, sizeof(rtw_wow->patterns));
+}
+
 static void rtw_wow_bb_stop(struct rtw_dev *rtwdev)
 {
 	struct rtw_wow_param *rtw_wow = &rtwdev->wow;
@@ -148,6 +358,7 @@ static int rtw_wow_fw_start(struct rtw_dev *rtwdev)
 {
 	if (rtw_wow_mgd_linked(rtwdev)) {
 		rtw_send_rsvd_page_h2c(rtwdev);
+		rtw_wow_set_pattern(rtwdev);
 		rtw_wow_fw_security_type(rtwdev);
 		rtw_fw_set_disconnect_decision_cmd(rtwdev, true);
 		rtw_fw_set_keep_alive_cmd(rtwdev, true);
@@ -164,6 +375,7 @@ static int rtw_wow_fw_stop(struct rtw_dev *rtwdev)
 	if (rtw_wow_mgd_linked(rtwdev)) {
 		rtw_fw_set_disconnect_decision_cmd(rtwdev, false);
 		rtw_fw_set_keep_alive_cmd(rtwdev, false);
+		rtw_wow_clear_pattern(rtwdev);
 	}
 
 	rtw_fw_set_wowlan_ctrl_cmd(rtwdev, false);
@@ -450,6 +662,9 @@ static int rtw_wow_set_wakeups(struct rtw_dev *rtwdev,
 			       struct cfg80211_wowlan *wowlan)
 {
 	struct rtw_wow_param *rtw_wow = &rtwdev->wow;
+	struct rtw_wow_pattern *rtw_patterns = rtw_wow->patterns;
+	struct rtw_vif *rtwvif;
+	int i;
 
 	if (wowlan->disconnect)
 		set_bit(RTW_WOW_FLAG_EN_DISCONNECT, rtw_wow->flags);
@@ -462,6 +677,15 @@ static int rtw_wow_set_wakeups(struct rtw_dev *rtwdev,
 	if (!rtw_wow->wow_vif)
 		return -EPERM;
 
+	rtwvif = (struct rtw_vif *)rtw_wow->wow_vif->drv_priv;
+	if (wowlan->n_patterns && wowlan->patterns) {
+		rtw_wow->pattern_cnt = wowlan->n_patterns;
+		for (i = 0; i < wowlan->n_patterns; i++)
+			rtw_wow_pattern_generate(rtwdev, rtwvif,
+						 wowlan->patterns + i,
+						 rtw_patterns + i);
+	}
+
 	return 0;
 }
 
diff --git a/drivers/net/wireless/realtek/rtw88/wow.h b/drivers/net/wireless/realtek/rtw88/wow.h
index 617806a2f28d..54f742f4c955 100644
--- a/drivers/net/wireless/realtek/rtw88/wow.h
+++ b/drivers/net/wireless/realtek/rtw88/wow.h
@@ -5,12 +5,21 @@
 #ifndef __RTW_WOW_H__
 #define __RTW_WOW_H__
 
+enum rtw_wow_pattern_type {
+	RTW_PATTERN_BROADCAST = 0,
+	RTW_PATTERN_MULTICAST,
+	RTW_PATTERN_UNICAST,
+	RTW_PATTERN_VALID,
+	RTW_PATTERN_INVALID,
+};
+
 enum rtw_wake_reason {
 	RTW_WOW_RSN_RX_PTK_REKEY = 0x1,
 	RTW_WOW_RSN_RX_GTK_REKEY = 0x2,
 	RTW_WOW_RSN_RX_DEAUTH = 0x8,
 	RTW_WOW_RSN_DISCONNECT = 0x10,
 	RTW_WOW_RSN_RX_MAGIC_PKT = 0x21,
+	RTW_WOW_RSN_RX_PATTERN_MATCH = 0x23,
 };
 
 struct rtw_fw_media_status_iter_data {
-- 
2.17.1

