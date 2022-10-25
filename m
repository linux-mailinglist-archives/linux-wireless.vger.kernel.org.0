Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F95160C805
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Oct 2022 11:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbiJYJ0R (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Oct 2022 05:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbiJYJZi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Oct 2022 05:25:38 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6D51F7539E
        for <linux-wireless@vger.kernel.org>; Tue, 25 Oct 2022 02:20:51 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 29P9KAb94006541, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 29P9KAb94006541
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 25 Oct 2022 17:20:10 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.9; Tue, 25 Oct 2022 17:20:44 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Tue, 25 Oct
 2022 17:20:43 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <gary.chang@realtek.com>, <timlee@realtek.com>,
        <linux-wireless@vger.kernel.org>
Subject: [PATCH 7/7] wifi: rtw89: add WoWLAN pattern match support
Date:   Tue, 25 Oct 2022 17:19:54 +0800
Message-ID: <20221025091954.23957-8-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221025091954.23957-1-pkshih@realtek.com>
References: <20221025091954.23957-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 10/25/2022 08:58:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzEwLzI1IKRXpMggMDY6MzM6MDA=?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Chin-Yen Lee <timlee@realtek.com>

Pattern match is an option of WoWLAN to allow the device to be woken up
from suspend mode when receiving packets matched user-designed patterns.

The patterns are written into hardware via WoWLAN firmware in suspend
flow if users have set up them. If packets matched designed pattern are
received, WoWLAN firmware will send an interrupt and then wake up the
device.

Signed-off-by: Chin-Yen Lee <timlee@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h     |  18 ++
 drivers/net/wireless/realtek/rtw89/fw.c       |  52 ++++
 drivers/net/wireless/realtek/rtw89/fw.h       |  67 +++++
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |   3 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |   3 +
 drivers/net/wireless/realtek/rtw89/util.h     |  11 +
 drivers/net/wireless/realtek/rtw89/wow.c      | 228 +++++++++++++++++-
 7 files changed, 381 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 9f80359e27aa2..b60de6662548b 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3489,9 +3489,27 @@ struct rtw89_phy_efuse_gain {
 	s8 comp[RF_PATH_MAX][RTW89_SUBBAND_NR]; /* S(8, 0) */
 };
 
+#define RTW89_MAX_PATTERN_NUM             18
+#define RTW89_MAX_PATTERN_MASK_SIZE       4
+#define RTW89_MAX_PATTERN_SIZE            128
+
+struct rtw89_wow_cam_info {
+	bool r_w;
+	u8 idx;
+	u32 mask[RTW89_MAX_PATTERN_MASK_SIZE];
+	u16 crc;
+	bool negative_pattern_match;
+	bool skip_mac_hdr;
+	bool uc;
+	bool mc;
+	bool bc;
+	bool valid;
+};
+
 struct rtw89_wow_param {
 	struct ieee80211_vif *wow_vif;
 	DECLARE_BITMAP(flags, RTW89_WOW_FLAG_NUM);
+	struct rtw89_wow_cam_info patterns[RTW89_MAX_PATTERN_NUM];
 	u8 pattern_cnt;
 	struct list_head pkt_list;
 };
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index dc632b33fc7c2..85883047943e3 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -3155,3 +3155,55 @@ int rtw89_fw_h2c_wow_wakeup_ctrl(struct rtw89_dev *rtwdev,
 
 	return ret;
 }
+
+#define H2C_WOW_CAM_UPD_LEN 24
+int rtw89_fw_wow_cam_update(struct rtw89_dev *rtwdev,
+			    struct rtw89_wow_cam_info *cam_info)
+{
+	struct sk_buff *skb;
+	int ret;
+
+	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, H2C_WOW_CAM_UPD_LEN);
+	if (!skb) {
+		rtw89_err(rtwdev, "failed to alloc skb for keep alive\n");
+		return -ENOMEM;
+	}
+
+	skb_put(skb, H2C_WOW_CAM_UPD_LEN);
+
+	RTW89_SET_WOW_CAM_UPD_R_W(skb->data, cam_info->r_w);
+	RTW89_SET_WOW_CAM_UPD_IDX(skb->data, cam_info->idx);
+	if (cam_info->valid) {
+		RTW89_SET_WOW_CAM_UPD_WKFM1(skb->data, cam_info->mask[0]);
+		RTW89_SET_WOW_CAM_UPD_WKFM2(skb->data, cam_info->mask[1]);
+		RTW89_SET_WOW_CAM_UPD_WKFM3(skb->data, cam_info->mask[2]);
+		RTW89_SET_WOW_CAM_UPD_WKFM4(skb->data, cam_info->mask[3]);
+		RTW89_SET_WOW_CAM_UPD_CRC(skb->data, cam_info->crc);
+		RTW89_SET_WOW_CAM_UPD_NEGATIVE_PATTERN_MATCH(skb->data,
+							     cam_info->negative_pattern_match);
+		RTW89_SET_WOW_CAM_UPD_SKIP_MAC_HDR(skb->data,
+						   cam_info->skip_mac_hdr);
+		RTW89_SET_WOW_CAM_UPD_UC(skb->data, cam_info->uc);
+		RTW89_SET_WOW_CAM_UPD_MC(skb->data, cam_info->mc);
+		RTW89_SET_WOW_CAM_UPD_BC(skb->data, cam_info->bc);
+	}
+	RTW89_SET_WOW_CAM_UPD_VALID(skb->data, cam_info->valid);
+
+	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
+			      H2C_CAT_MAC,
+			      H2C_CL_MAC_WOW,
+			      H2C_FUNC_WOW_CAM_UPD, 0, 1,
+			      H2C_WOW_CAM_UPD_LEN);
+
+	ret = rtw89_h2c_tx(rtwdev, skb, false);
+	if (ret) {
+		rtw89_err(rtwdev, "failed to send h2c\n");
+		goto fail;
+	}
+
+	return 0;
+fail:
+	dev_kfree_skb_any(skb);
+
+	return ret;
+}
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index d83009fc6a207..6a9e92f8d4292 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -2021,6 +2021,71 @@ static inline void RTW89_SET_WOW_WAKEUP_CTRL_MAC_ID(void *h2c, u32 val)
 	le32p_replace_bits((__le32 *)h2c, val, GENMASK(31, 24));
 }
 
+static inline void RTW89_SET_WOW_CAM_UPD_R_W(void *h2c, u32 val)
+{
+	le32p_replace_bits((__le32 *)h2c, val, BIT(0));
+}
+
+static inline void RTW89_SET_WOW_CAM_UPD_IDX(void *h2c, u32 val)
+{
+	le32p_replace_bits((__le32 *)h2c, val, GENMASK(7, 1));
+}
+
+static inline void RTW89_SET_WOW_CAM_UPD_WKFM1(void *h2c, u32 val)
+{
+	le32p_replace_bits((__le32 *)h2c + 1, val, GENMASK(31, 0));
+}
+
+static inline void RTW89_SET_WOW_CAM_UPD_WKFM2(void *h2c, u32 val)
+{
+	le32p_replace_bits((__le32 *)h2c + 2, val, GENMASK(31, 0));
+}
+
+static inline void RTW89_SET_WOW_CAM_UPD_WKFM3(void *h2c, u32 val)
+{
+	le32p_replace_bits((__le32 *)h2c + 3, val, GENMASK(31, 0));
+}
+
+static inline void RTW89_SET_WOW_CAM_UPD_WKFM4(void *h2c, u32 val)
+{
+	le32p_replace_bits((__le32 *)h2c + 4, val, GENMASK(31, 0));
+}
+
+static inline void RTW89_SET_WOW_CAM_UPD_CRC(void *h2c, u32 val)
+{
+	le32p_replace_bits((__le32 *)h2c + 5, val, GENMASK(15, 0));
+}
+
+static inline void RTW89_SET_WOW_CAM_UPD_NEGATIVE_PATTERN_MATCH(void *h2c, u32 val)
+{
+	le32p_replace_bits((__le32 *)h2c + 5, val, BIT(22));
+}
+
+static inline void RTW89_SET_WOW_CAM_UPD_SKIP_MAC_HDR(void *h2c, u32 val)
+{
+	le32p_replace_bits((__le32 *)h2c + 5, val, BIT(23));
+}
+
+static inline void RTW89_SET_WOW_CAM_UPD_UC(void *h2c, u32 val)
+{
+	le32p_replace_bits((__le32 *)h2c + 5, val, BIT(24));
+}
+
+static inline void RTW89_SET_WOW_CAM_UPD_MC(void *h2c, u32 val)
+{
+	le32p_replace_bits((__le32 *)h2c + 5, val, BIT(25));
+}
+
+static inline void RTW89_SET_WOW_CAM_UPD_BC(void *h2c, u32 val)
+{
+	le32p_replace_bits((__le32 *)h2c + 5, val, BIT(26));
+}
+
+static inline void RTW89_SET_WOW_CAM_UPD_VALID(void *h2c, u32 val)
+{
+	le32p_replace_bits((__le32 *)h2c + 5, val, BIT(31));
+}
+
 enum rtw89_btc_btf_h2c_class {
 	BTFC_SET = 0x10,
 	BTFC_GET = 0x11,
@@ -3027,6 +3092,8 @@ int rtw89_fw_h2c_wow_global(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
 int rtw89_fw_h2c_wow_wakeup_ctrl(struct rtw89_dev *rtwdev,
 				 struct rtw89_vif *rtwvif, bool enable);
 
+int rtw89_fw_wow_cam_update(struct rtw89_dev *rtwdev,
+			    struct rtw89_wow_cam_info *cam_info);
 static inline void rtw89_fw_h2c_init_ba_cam(struct rtw89_dev *rtwdev)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index becce3b48f518..4cea5fb4327d7 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -1993,6 +1993,9 @@ static void rtw8852a_query_ppdu(struct rtw89_dev *rtwdev,
 #ifdef CONFIG_PM
 static const struct wiphy_wowlan_support rtw_wowlan_stub_8852a = {
 	.flags = WIPHY_WOWLAN_MAGIC_PKT | WIPHY_WOWLAN_DISCONNECT,
+	.n_patterns = RTW89_MAX_PATTERN_NUM,
+	.pattern_max_len = RTW89_MAX_PATTERN_SIZE,
+	.pattern_min_len = 1,
 };
 #endif
 
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index c731901bc90b3..c25103e06253a 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -2799,6 +2799,9 @@ static int rtw8852c_mac_disable_bb_rf(struct rtw89_dev *rtwdev)
 #ifdef CONFIG_PM
 static const struct wiphy_wowlan_support rtw_wowlan_stub_8852c = {
 	.flags = WIPHY_WOWLAN_MAGIC_PKT | WIPHY_WOWLAN_DISCONNECT,
+	.n_patterns = RTW89_MAX_PATTERN_NUM,
+	.pattern_max_len = RTW89_MAX_PATTERN_SIZE,
+	.pattern_min_len = 1,
 };
 #endif
 
diff --git a/drivers/net/wireless/realtek/rtw89/util.h b/drivers/net/wireless/realtek/rtw89/util.h
index 1ae80b7561daa..e2ed4565025dd 100644
--- a/drivers/net/wireless/realtek/rtw89/util.h
+++ b/drivers/net/wireless/realtek/rtw89/util.h
@@ -44,4 +44,15 @@ static inline s32 s32_div_u32_round_closest(s32 dividend, u32 divisor)
 	return s32_div_u32_round_down(dividend + divisor / 2, divisor, NULL);
 }
 
+static inline void ether_addr_copy_mask(u8 *dst, const u8 *src, u8 mask)
+{
+	int i;
+
+	eth_zero_addr(dst);
+	for (i = 0; i < ETH_ALEN; i++) {
+		if (mask & BIT(i))
+			dst[i] = src[i];
+	}
+}
+
 #endif
diff --git a/drivers/net/wireless/realtek/rtw89/wow.c b/drivers/net/wireless/realtek/rtw89/wow.c
index 2570a05ef0e7a..16717f3b86872 100644
--- a/drivers/net/wireless/realtek/rtw89/wow.c
+++ b/drivers/net/wireless/realtek/rtw89/wow.c
@@ -162,6 +162,227 @@ static void rtw89_wow_vif_iter(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvi
 	}
 }
 
+static u16 __rtw89_cal_crc16(u8 data, u16 crc)
+{
+	u8 shift_in, data_bit;
+	u8 crc_bit4, crc_bit11, crc_bit15;
+	u16 crc_result;
+	int index;
+
+	for (index = 0; index < 8; index++) {
+		crc_bit15 = crc & BIT(15) ? 1 : 0;
+		data_bit = data & BIT(index) ? 1 : 0;
+		shift_in = crc_bit15 ^ data_bit;
+
+		crc_result = crc << 1;
+
+		if (shift_in == 0)
+			crc_result &= ~BIT(0);
+		else
+			crc_result |= BIT(0);
+
+		crc_bit11 = (crc & BIT(11) ? 1 : 0) ^ shift_in;
+
+		if (crc_bit11 == 0)
+			crc_result &= ~BIT(12);
+		else
+			crc_result |= BIT(12);
+
+		crc_bit4 = (crc & BIT(4) ? 1 : 0) ^ shift_in;
+
+		if (crc_bit4 == 0)
+			crc_result &= ~BIT(5);
+		else
+			crc_result |= BIT(5);
+
+		crc = crc_result;
+	}
+	return crc;
+}
+
+static u16 rtw89_calc_crc(u8 *pdata, int length)
+{
+	u16 crc = 0xffff;
+	int i;
+
+	for (i = 0; i < length; i++)
+		crc = __rtw89_cal_crc16(pdata[i], crc);
+
+	/* get 1' complement */
+	return ~crc;
+}
+
+static int rtw89_wow_pattern_get_type(struct rtw89_vif *rtwvif,
+				      struct rtw89_wow_cam_info *rtw_pattern,
+				      const u8 *pattern, u8 da_mask)
+{
+	u8 da[ETH_ALEN];
+
+	ether_addr_copy_mask(da, pattern, da_mask);
+
+	/* Each pattern is divided into different kinds by DA address
+	 *  a. DA is broadcast address: set bc = 0;
+	 *  b. DA is multicast address: set mc = 0
+	 *  c. DA is unicast address same as dev's mac address: set uc = 0
+	 *  d. DA is unmasked. Also called wildcard type: set uc = bc = mc = 0
+	 *  e. Others is invalid type.
+	 */
+
+	if (is_broadcast_ether_addr(da))
+		rtw_pattern->bc = true;
+	else if (is_multicast_ether_addr(da))
+		rtw_pattern->mc = true;
+	else if (ether_addr_equal(da, rtwvif->mac_addr) &&
+		 da_mask == GENMASK(5, 0))
+		rtw_pattern->uc = true;
+	else if (!da_mask) /*da_mask == 0 mean wildcard*/
+		return 0;
+	else
+		return -EPERM;
+
+	return 0;
+}
+
+static int rtw89_wow_pattern_generate(struct rtw89_dev *rtwdev,
+				      struct rtw89_vif *rtwvif,
+				      const struct cfg80211_pkt_pattern *pkt_pattern,
+				      struct rtw89_wow_cam_info *rtw_pattern)
+{
+	u8 mask_hw[RTW89_MAX_PATTERN_MASK_SIZE * 4] = {0};
+	u8 content[RTW89_MAX_PATTERN_SIZE] = {0};
+	const u8 *mask;
+	const u8 *pattern;
+	u8 mask_len;
+	u16 count;
+	u32 len;
+	int i, ret;
+
+	pattern = pkt_pattern->pattern;
+	len = pkt_pattern->pattern_len;
+	mask = pkt_pattern->mask;
+	mask_len = DIV_ROUND_UP(len, 8);
+	memset(rtw_pattern, 0, sizeof(*rtw_pattern));
+
+	ret = rtw89_wow_pattern_get_type(rtwvif, rtw_pattern, pattern,
+					 mask[0] & GENMASK(5, 0));
+	if (ret)
+		return ret;
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
+		mask_hw[i] = u8_get_bits(mask[i], GENMASK(7, 6)) |
+			     u8_get_bits(mask[i + 1], GENMASK(5, 0)) << 2;
+	}
+	mask_hw[i] = u8_get_bits(mask[i], GENMASK(7, 6));
+
+	/* Set bit 0-5 to zero */
+	mask_hw[0] &= ~GENMASK(5, 0);
+
+	memcpy(rtw_pattern->mask, mask_hw, sizeof(rtw_pattern->mask));
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
+	rtw_pattern->crc = rtw89_calc_crc(content, count);
+
+	return 0;
+}
+
+static int rtw89_wow_parse_patterns(struct rtw89_dev *rtwdev,
+				    struct rtw89_vif *rtwvif,
+				    struct cfg80211_wowlan *wowlan)
+{
+	struct rtw89_wow_param *rtw_wow = &rtwdev->wow;
+	struct rtw89_wow_cam_info *rtw_pattern = rtw_wow->patterns;
+	int i;
+	int ret;
+
+	if (!wowlan->n_patterns || !wowlan->patterns)
+		return 0;
+
+	for (i = 0; i < wowlan->n_patterns; i++) {
+		rtw_pattern = &rtw_wow->patterns[i];
+		ret = rtw89_wow_pattern_generate(rtwdev, rtwvif,
+						 &wowlan->patterns[i],
+						 rtw_pattern);
+		if (ret) {
+			rtw89_err(rtwdev, "failed to generate pattern(%d)\n", i);
+			rtw_wow->pattern_cnt = 0;
+			return ret;
+		}
+
+		rtw_pattern->r_w = true;
+		rtw_pattern->idx = i;
+		rtw_pattern->negative_pattern_match = false;
+		rtw_pattern->skip_mac_hdr = true;
+		rtw_pattern->valid = true;
+	}
+	rtw_wow->pattern_cnt = wowlan->n_patterns;
+
+	return 0;
+}
+
+static void rtw89_wow_pattern_clear_cam(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_wow_param *rtw_wow = &rtwdev->wow;
+	struct rtw89_wow_cam_info *rtw_pattern = rtw_wow->patterns;
+	int i = 0;
+
+	for (i = 0; i < rtw_wow->pattern_cnt; i++) {
+		rtw_pattern = &rtw_wow->patterns[i];
+		rtw_pattern->valid = false;
+		rtw89_fw_wow_cam_update(rtwdev, rtw_pattern);
+	}
+}
+
+static void rtw89_wow_pattern_write(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_wow_param *rtw_wow = &rtwdev->wow;
+	struct rtw89_wow_cam_info *rtw_pattern = rtw_wow->patterns;
+	int i;
+
+	for (i = 0; i < rtw_wow->pattern_cnt; i++)
+		rtw89_fw_wow_cam_update(rtwdev, rtw_pattern + i);
+}
+
+static void rtw89_wow_pattern_clear(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_wow_param *rtw_wow = &rtwdev->wow;
+
+	rtw89_wow_pattern_clear_cam(rtwdev);
+
+	rtw_wow->pattern_cnt = 0;
+	memset(rtw_wow->patterns, 0, sizeof(rtw_wow->patterns));
+}
+
 static void rtw89_wow_clear_wakeups(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_wow_param *rtw_wow = &rtwdev->wow;
@@ -188,7 +409,8 @@ static int rtw89_wow_set_wakeups(struct rtw89_dev *rtwdev,
 	if (!rtw_wow->wow_vif)
 		return -EPERM;
 
-	return 0;
+	rtwvif = (struct rtw89_vif *)rtw_wow->wow_vif->drv_priv;
+	return rtw89_wow_parse_patterns(rtwdev, rtwvif, wowlan);
 }
 
 static int rtw89_wow_cfg_wake(struct rtw89_dev *rtwdev, bool wow)
@@ -441,6 +663,8 @@ static int rtw89_wow_fw_start(struct rtw89_dev *rtwdev)
 	struct rtw89_vif *rtwvif = (struct rtw89_vif *)rtw_wow->wow_vif->drv_priv;
 	int ret;
 
+	rtw89_wow_pattern_write(rtwdev);
+
 	ret = rtw89_fw_h2c_keep_alive(rtwdev, rtwvif, true);
 	if (ret) {
 		rtw89_err(rtwdev, "wow: failed to enable keep alive\n");
@@ -475,6 +699,8 @@ static int rtw89_wow_fw_stop(struct rtw89_dev *rtwdev)
 	struct rtw89_vif *rtwvif = (struct rtw89_vif *)rtw_wow->wow_vif->drv_priv;
 	int ret;
 
+	rtw89_wow_pattern_clear(rtwdev);
+
 	ret = rtw89_fw_h2c_keep_alive(rtwdev, rtwvif, false);
 	if (ret) {
 		rtw89_err(rtwdev, "wow: failed to disable keep alive\n");
-- 
2.25.1

