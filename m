Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9409116779
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2019 08:22:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbfLIHV4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Dec 2019 02:21:56 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:46354 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727180AbfLIHVz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Dec 2019 02:21:55 -0500
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID xB97Llk1018999, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id xB97Llk1018999
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 9 Dec 2019 15:21:47 +0800
Received: from localhost.localdomain (172.21.68.126) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.468.0; Mon, 9 Dec 2019 15:21:46 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>
Subject: [PATCH v2 6/6] rtw88: add wowlan net-detect support
Date:   Mon, 9 Dec 2019 15:21:39 +0800
Message-ID: <20191209072139.26068-7-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191209072139.26068-1-yhchuang@realtek.com>
References: <20191209072139.26068-1-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.126]
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Chin-Yen Lee <timlee@realtek.com>

Net-detect is an option of wowlan to allow the device to
be woken up from suspend mode when configured network is detected.

When user enables net-detect and lets the device enter suspend
state, wowlan firmware will periodically scan until beacon or
probe response of configured networks are received.
Between two scans, wowlan firmware keeps wifi chip in idle mode
to reduce power consumption. If configured networks are detected,
wowlan firmware will trigger resume process.

Signed-off-by: Chin-Yen Lee <timlee@realtek.com>
Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---

v1 -> v2
 * no change

 drivers/net/wireless/realtek/rtw88/fw.c       | 292 +++++++++++++++++-
 drivers/net/wireless/realtek/rtw88/fw.h       | 113 +++++++
 drivers/net/wireless/realtek/rtw88/main.c     |   1 +
 drivers/net/wireless/realtek/rtw88/main.h     |  25 ++
 drivers/net/wireless/realtek/rtw88/rtw8822c.c |   5 +-
 drivers/net/wireless/realtek/rtw88/wow.c      | 139 ++++++++-
 drivers/net/wireless/realtek/rtw88/wow.h      |  11 +
 7 files changed, 571 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/fw.c b/drivers/net/wireless/realtek/rtw88/fw.c
index 0523851cf98d..e3e91ae0d3d2 100644
--- a/drivers/net/wireless/realtek/rtw88/fw.c
+++ b/drivers/net/wireless/realtek/rtw88/fw.c
@@ -567,6 +567,9 @@ void rtw_fw_set_remote_wake_ctrl_cmd(struct rtw_dev *rtwdev, bool enable)
 
 	SET_REMOTE_WAKECTRL_ENABLE(h2c_pkt, enable);
 
+	if (rtw_wow_no_link(rtwdev))
+		SET_REMOTE_WAKE_CTRL_NLO_OFFLOAD_EN(h2c_pkt, enable);
+
 	rtw_fw_send_h2c_command(rtwdev, h2c_pkt);
 }
 
@@ -584,6 +587,26 @@ static u8 rtw_get_rsvd_page_location(struct rtw_dev *rtwdev,
 	return location;
 }
 
+void rtw_fw_set_nlo_info(struct rtw_dev *rtwdev, bool enable)
+{
+	u8 h2c_pkt[H2C_PKT_SIZE] = {0};
+	u8 loc_nlo;
+
+	loc_nlo = rtw_get_rsvd_page_location(rtwdev, RSVD_NLO_INFO);
+
+	SET_H2C_CMD_ID_CLASS(h2c_pkt, H2C_CMD_NLO_INFO);
+
+	SET_NLO_FUN_EN(h2c_pkt, enable);
+	if (enable) {
+		if (rtw_fw_lps_deep_mode)
+			SET_NLO_PS_32K(h2c_pkt, enable);
+		SET_NLO_IGNORE_SECURITY(h2c_pkt, enable);
+		SET_NLO_LOC_NLO_INFO(h2c_pkt, loc_nlo);
+	}
+
+	rtw_fw_send_h2c_command(rtwdev, h2c_pkt);
+}
+
 void rtw_fw_set_pg_info(struct rtw_dev *rtwdev)
 {
 	struct rtw_lps_conf *conf = &rtwdev->lps_conf;
@@ -603,6 +626,40 @@ void rtw_fw_set_pg_info(struct rtw_dev *rtwdev)
 	rtw_fw_send_h2c_command(rtwdev, h2c_pkt);
 }
 
+u8 rtw_get_rsvd_page_probe_req_location(struct rtw_dev *rtwdev,
+					struct cfg80211_ssid *ssid)
+{
+	struct rtw_rsvd_page *rsvd_pkt;
+	u8 location = 0;
+
+	list_for_each_entry(rsvd_pkt, &rtwdev->rsvd_page_list, list) {
+		if (rsvd_pkt->type != RSVD_PROBE_REQ)
+			continue;
+		if ((!ssid && !rsvd_pkt->ssid) ||
+		    rtw_ssid_equal(rsvd_pkt->ssid, ssid))
+			location = rsvd_pkt->page;
+	}
+
+	return location;
+}
+
+u16 rtw_get_rsvd_page_probe_req_size(struct rtw_dev *rtwdev,
+				     struct cfg80211_ssid *ssid)
+{
+	struct rtw_rsvd_page *rsvd_pkt;
+	u16 size = 0;
+
+	list_for_each_entry(rsvd_pkt, &rtwdev->rsvd_page_list, list) {
+		if (rsvd_pkt->type != RSVD_PROBE_REQ)
+			continue;
+		if ((!ssid && !rsvd_pkt->ssid) ||
+		    rtw_ssid_equal(rsvd_pkt->ssid, ssid))
+			size = rsvd_pkt->skb->len;
+	}
+
+	return size;
+}
+
 void rtw_send_rsvd_page_h2c(struct rtw_dev *rtwdev)
 {
 	u8 h2c_pkt[H2C_PKT_SIZE] = {0};
@@ -648,6 +705,95 @@ rtw_beacon_get(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 	return skb_new;
 }
 
+static struct sk_buff *rtw_nlo_info_get(struct ieee80211_hw *hw)
+{
+	struct rtw_dev *rtwdev = hw->priv;
+	struct rtw_chip_info *chip = rtwdev->chip;
+	struct rtw_pno_request *pno_req = &rtwdev->wow.pno_req;
+	struct rtw_nlo_info_hdr *nlo_hdr;
+	struct cfg80211_ssid *ssid;
+	struct sk_buff *skb;
+	u8 *pos, loc;
+	u32 size;
+	int i;
+
+	if (!pno_req->inited || !pno_req->match_set_cnt)
+		return NULL;
+
+	size = sizeof(struct rtw_nlo_info_hdr) + pno_req->match_set_cnt *
+		      IEEE80211_MAX_SSID_LEN + chip->tx_pkt_desc_sz;
+
+	skb = alloc_skb(size, GFP_KERNEL);
+	if (!skb)
+		return NULL;
+
+	skb_reserve(skb, chip->tx_pkt_desc_sz);
+
+	nlo_hdr = skb_put_zero(skb, sizeof(struct rtw_nlo_info_hdr));
+
+	nlo_hdr->nlo_count = pno_req->match_set_cnt;
+	nlo_hdr->hidden_ap_count = pno_req->match_set_cnt;
+
+	/* pattern check for firmware */
+	memset(nlo_hdr->pattern_check, 0xA5, FW_NLO_INFO_CHECK_SIZE);
+
+	for (i = 0; i < pno_req->match_set_cnt; i++)
+		nlo_hdr->ssid_len[i] = pno_req->match_sets[i].ssid.ssid_len;
+
+	for (i = 0; i < pno_req->match_set_cnt; i++) {
+		ssid = &pno_req->match_sets[i].ssid;
+		loc  = rtw_get_rsvd_page_probe_req_location(rtwdev, ssid);
+		if (!loc) {
+			rtw_err(rtwdev, "failed to get probe req rsvd loc\n");
+			kfree(skb);
+			return NULL;
+		}
+		nlo_hdr->location[i] = loc;
+	}
+
+	for (i = 0; i < pno_req->match_set_cnt; i++) {
+		pos = skb_put_zero(skb, IEEE80211_MAX_SSID_LEN);
+		memcpy(pos, pno_req->match_sets[i].ssid.ssid,
+		       pno_req->match_sets[i].ssid.ssid_len);
+	}
+
+	return skb;
+}
+
+static struct sk_buff *rtw_cs_channel_info_get(struct ieee80211_hw *hw)
+{
+	struct rtw_dev *rtwdev = hw->priv;
+	struct rtw_chip_info *chip = rtwdev->chip;
+	struct rtw_pno_request *pno_req = &rtwdev->wow.pno_req;
+	struct ieee80211_channel *channels = pno_req->channels;
+	struct sk_buff *skb;
+	int count =  pno_req->channel_cnt;
+	u8 *pos;
+	int i = 0;
+
+	skb = alloc_skb(4 * count + chip->tx_pkt_desc_sz, GFP_KERNEL);
+	if (!skb)
+		return NULL;
+
+	skb_reserve(skb, chip->tx_pkt_desc_sz);
+
+	for (i = 0; i < count; i++) {
+		pos = skb_put_zero(skb, 4);
+
+		CHSW_INFO_SET_CH(pos, channels[i].hw_value);
+
+		if (channels[i].flags & IEEE80211_CHAN_RADAR)
+			CHSW_INFO_SET_ACTION_ID(pos, 0);
+		else
+			CHSW_INFO_SET_ACTION_ID(pos, 1);
+		CHSW_INFO_SET_TIMEOUT(pos, 1);
+		CHSW_INFO_SET_PRI_CH_IDX(pos, 1);
+		CHSW_INFO_SET_BW(pos, 0);
+	}
+
+	return skb;
+}
+
 static struct sk_buff *rtw_lps_pg_dpk_get(struct ieee80211_hw *hw)
 {
 	struct rtw_dev *rtwdev = hw->priv;
@@ -705,11 +851,12 @@ static struct sk_buff *rtw_lps_pg_info_get(struct ieee80211_hw *hw,
 
 static struct sk_buff *rtw_get_rsvd_page_skb(struct ieee80211_hw *hw,
 					     struct ieee80211_vif *vif,
-					     enum rtw_rsvd_packet_type type)
+					     struct rtw_rsvd_page *rsvd_pkt)
 {
 	struct sk_buff *skb_new;
+	struct cfg80211_ssid *ssid;
 
-	switch (type) {
+	switch (rsvd_pkt->type) {
 	case RSVD_BEACON:
 		skb_new = rtw_beacon_get(hw, vif);
 		break;
@@ -731,6 +878,21 @@ static struct sk_buff *rtw_get_rsvd_page_skb(struct ieee80211_hw *hw,
 	case RSVD_LPS_PG_INFO:
 		skb_new = rtw_lps_pg_info_get(hw, vif);
 		break;
+	case RSVD_PROBE_REQ:
+		ssid = (struct cfg80211_ssid *)rsvd_pkt->ssid;
+		if (ssid)
+			skb_new = ieee80211_probereq_get(hw, vif->addr,
+							 ssid->ssid,
+							 ssid->ssid_len, 0);
+		else
+			skb_new = ieee80211_probereq_get(hw, vif->addr, NULL, 0, 0);
+		break;
+	case RSVD_NLO_INFO:
+		skb_new = rtw_nlo_info_get(hw);
+		break;
+	case RSVD_CH_INFO:
+		skb_new = rtw_cs_channel_info_get(hw);
+		break;
 	default:
 		return NULL;
 	}
@@ -772,25 +934,53 @@ static void rtw_rsvd_page_list_to_buf(struct rtw_dev *rtwdev, u8 page_size,
 		memcpy(buf, skb->data, skb->len);
 }
 
+static struct rtw_rsvd_page *rtw_alloc_rsvd_page(struct rtw_dev *rtwdev,
+						 enum rtw_rsvd_packet_type type,
+						 bool txdesc)
+{
+	struct rtw_rsvd_page *rsvd_pkt = NULL;
+
+	rsvd_pkt = kzalloc(sizeof(*rsvd_pkt), GFP_KERNEL);
+
+	if (!rsvd_pkt)
+		return NULL;
+
+	rsvd_pkt->type = type;
+	rsvd_pkt->add_txdesc = txdesc;
+
+	return rsvd_pkt;
+}
+
+static void rtw_insert_rsvd_page(struct rtw_dev *rtwdev,
+				 struct rtw_rsvd_page *rsvd_pkt)
+{
+	lockdep_assert_held(&rtwdev->mutex);
+	list_add_tail(&rsvd_pkt->list, &rtwdev->rsvd_page_list);
+}
+
 void rtw_add_rsvd_page(struct rtw_dev *rtwdev, enum rtw_rsvd_packet_type type,
 		       bool txdesc)
 {
 	struct rtw_rsvd_page *rsvd_pkt;
 
-	lockdep_assert_held(&rtwdev->mutex);
+	rsvd_pkt = rtw_alloc_rsvd_page(rtwdev, type, txdesc);
+	if (!rsvd_pkt)
+		return;
 
-	list_for_each_entry(rsvd_pkt, &rtwdev->rsvd_page_list, list) {
-		if (rsvd_pkt->type == type)
-			return;
-	}
+	rtw_insert_rsvd_page(rtwdev, rsvd_pkt);
+}
 
-	rsvd_pkt = kmalloc(sizeof(*rsvd_pkt), GFP_KERNEL);
+void rtw_add_rsvd_page_probe_req(struct rtw_dev *rtwdev,
+				 struct cfg80211_ssid *ssid)
+{
+	struct rtw_rsvd_page *rsvd_pkt;
+
+	rsvd_pkt = rtw_alloc_rsvd_page(rtwdev, RSVD_PROBE_REQ, true);
 	if (!rsvd_pkt)
 		return;
 
-	rsvd_pkt->type = type;
-	rsvd_pkt->add_txdesc = txdesc;
-	list_add_tail(&rsvd_pkt->list, &rtwdev->rsvd_page_list);
+	rsvd_pkt->ssid = ssid;
+	rtw_insert_rsvd_page(rtwdev, rsvd_pkt);
 }
 
 void rtw_reset_rsvd_page(struct rtw_dev *rtwdev)
@@ -887,7 +1077,7 @@ static u8 *rtw_build_rsvd_page(struct rtw_dev *rtwdev,
 	page_margin = page_size - tx_desc_sz;
 
 	list_for_each_entry(rsvd_pkt, &rtwdev->rsvd_page_list, list) {
-		iter = rtw_get_rsvd_page_skb(hw, vif, rsvd_pkt->type);
+		iter = rtw_get_rsvd_page_skb(hw, vif, rsvd_pkt);
 		if (!iter) {
 			rtw_err(rtwdev, "failed to build rsvd packet\n");
 			goto release_skb;
@@ -1065,3 +1255,81 @@ int rtw_dump_drv_rsvd_page(struct rtw_dev *rtwdev,
 	rtw_write8(rtwdev, REG_RCR + 2, rcr);
 	return 0;
 }
+
+static void __rtw_fw_update_pkt(struct rtw_dev *rtwdev, u8 pkt_id, u16 size,
+				u8 location)
+{
+	u8 h2c_pkt[H2C_PKT_SIZE] = {0};
+	u16 total_size = H2C_PKT_HDR_SIZE + H2C_PKT_UPDATE_PKT_LEN;
+
+	rtw_h2c_pkt_set_header(h2c_pkt, H2C_PKT_UPDATE_PKT);
+
+	SET_PKT_H2C_TOTAL_LEN(h2c_pkt, total_size);
+	UPDATE_PKT_SET_PKT_ID(h2c_pkt, pkt_id);
+	UPDATE_PKT_SET_LOCATION(h2c_pkt, location);
+
+	/* include txdesc size */
+	UPDATE_PKT_SET_SIZE(h2c_pkt, size);
+
+	rtw_fw_send_h2c_packet(rtwdev, h2c_pkt);
+}
+
+void rtw_fw_update_pkt_probe_req(struct rtw_dev *rtwdev,
+				 struct cfg80211_ssid *ssid)
+{
+	u8 loc;
+	u32 size;
+
+	loc = rtw_get_rsvd_page_probe_req_location(rtwdev, ssid);
+	if (!loc) {
+		rtw_err(rtwdev, "failed to get probe_req rsvd loc\n");
+		return;
+	}
+
+	size = rtw_get_rsvd_page_probe_req_size(rtwdev, ssid);
+	if (!size) {
+		rtw_err(rtwdev, "failed to get probe_req rsvd size\n");
+		return;
+	}
+
+	__rtw_fw_update_pkt(rtwdev, RTW_PACKET_PROBE_REQ, size, loc);
+}
+
+void rtw_fw_channel_switch(struct rtw_dev *rtwdev, bool enable)
+{
+	struct rtw_pno_request *rtw_pno_req = &rtwdev->wow.pno_req;
+	u8 h2c_pkt[H2C_PKT_SIZE] = {0};
+	u16 total_size = H2C_PKT_HDR_SIZE + H2C_PKT_CH_SWITCH_LEN;
+	u8 loc_ch_info;
+	const struct rtw_ch_switch_option cs_option = {
+		.dest_ch_en = 1,
+		.dest_ch = 1,
+		.periodic_option = 2,
+		.normal_period = 5,
+		.normal_period_sel = 0,
+		.normal_cycle = 10,
+		.slow_period = 1,
+		.slow_period_sel = 1,
+	};
+
+	rtw_h2c_pkt_set_header(h2c_pkt, H2C_PKT_CH_SWITCH);
+	SET_PKT_H2C_TOTAL_LEN(h2c_pkt, total_size);
+
+	CH_SWITCH_SET_START(h2c_pkt, enable);
+	CH_SWITCH_SET_DEST_CH_EN(h2c_pkt, cs_option.dest_ch_en);
+	CH_SWITCH_SET_DEST_CH(h2c_pkt, cs_option.dest_ch);
+	CH_SWITCH_SET_NORMAL_PERIOD(h2c_pkt, cs_option.normal_period);
+	CH_SWITCH_SET_NORMAL_PERIOD_SEL(h2c_pkt, cs_option.normal_period_sel);
+	CH_SWITCH_SET_SLOW_PERIOD(h2c_pkt, cs_option.slow_period);
+	CH_SWITCH_SET_SLOW_PERIOD_SEL(h2c_pkt, cs_option.slow_period_sel);
+	CH_SWITCH_SET_NORMAL_CYCLE(h2c_pkt, cs_option.normal_cycle);
+	CH_SWITCH_SET_PERIODIC_OPT(h2c_pkt, cs_option.periodic_option);
+
+	CH_SWITCH_SET_CH_NUM(h2c_pkt, rtw_pno_req->channel_cnt);
+	CH_SWITCH_SET_INFO_SIZE(h2c_pkt, rtw_pno_req->channel_cnt * 4);
+
+	loc_ch_info = rtw_get_rsvd_page_location(rtwdev, RSVD_CH_INFO);
+	CH_SWITCH_SET_INFO_LOC(h2c_pkt, loc_ch_info);
+
+	rtw_fw_send_h2c_packet(rtwdev, h2c_pkt);
+}
diff --git a/drivers/net/wireless/realtek/rtw88/fw.h b/drivers/net/wireless/realtek/rtw88/fw.h
index 9ea27cca11ac..ccd27bd45775 100644
--- a/drivers/net/wireless/realtek/rtw88/fw.h
+++ b/drivers/net/wireless/realtek/rtw88/fw.h
@@ -12,6 +12,8 @@
 #define FW_HDR_SIZE			64
 #define FW_HDR_CHKSUM_SIZE		8
 
+#define FW_NLO_INFO_CHECK_SIZE		4
+
 #define FIFO_PAGE_SIZE_SHIFT		12
 #define FIFO_PAGE_SIZE			4096
 #define RSVD_PAGE_START_ADDR		0x780
@@ -45,6 +47,9 @@ enum rtw_rsvd_packet_type {
 	RSVD_QOS_NULL,
 	RSVD_LPS_PG_DPK,
 	RSVD_LPS_PG_INFO,
+	RSVD_PROBE_REQ,
+	RSVD_NLO_INFO,
+	RSVD_CH_INFO,
 };
 
 enum rtw_fw_rf_type {
@@ -98,6 +103,7 @@ struct rtw_rsvd_page {
 	enum rtw_rsvd_packet_type type;
 	u8 page;
 	bool add_txdesc;
+	struct cfg80211_ssid *ssid;
 };
 
 enum rtw_keep_alive_pkt_type {
@@ -105,6 +111,24 @@ enum rtw_keep_alive_pkt_type {
 	KEEP_ALIVE_ARP_RSP = 1,
 };
 
+struct rtw_nlo_info_hdr {
+	u8 nlo_count;
+	u8 hidden_ap_count;
+	u8 rsvd1[2];
+	u8 pattern_check[FW_NLO_INFO_CHECK_SIZE];
+	u8 rsvd2[8];
+	u8 ssid_len[16];
+	u8 chiper[16];
+	u8 rsvd3[16];
+	u8 location[8];
+} __packed;
+
+enum rtw_packet_type {
+	RTW_PACKET_PROBE_REQ = 0x00,
+
+	RTW_PACKET_UNDEFINE = 0x7FFFFFFF,
+};
+
 struct rtw_fw_wow_keep_alive_para {
 	bool adopt;
 	u8 pkt_type;
@@ -117,6 +141,21 @@ struct rtw_fw_wow_disconnect_para {
 	u8 retry_count;
 };
 
+struct rtw_ch_switch_option {
+	u8 periodic_option;
+	u32 tsf_high;
+	u32 tsf_low;
+	u8 dest_ch_en;
+	u8 absolute_time_en;
+	u8 dest_ch;
+	u8 normal_period;
+	u8 normal_period_sel;
+	u8 normal_cycle;
+	u8 slow_period;
+	u8 slow_period_sel;
+	u8 nlo_en;
+};
+
 struct rtw_fw_hdr {
 	__le16 signature;
 	u8 category;
@@ -163,6 +202,12 @@ struct rtw_fw_hdr {
 #define H2C_PKT_PHYDM_INFO 0x11
 #define H2C_PKT_IQK 0x0E
 
+#define H2C_PKT_CH_SWITCH 0x02
+#define H2C_PKT_UPDATE_PKT 0x0C
+
+#define H2C_PKT_CH_SWITCH_LEN 0x20
+#define H2C_PKT_UPDATE_PKT_LEN 0x4
+
 #define SET_PKT_H2C_CATEGORY(h2c_pkt, value)                                   \
 	le32p_replace_bits((__le32 *)(h2c_pkt) + 0x00, value, GENMASK(6, 0))
 #define SET_PKT_H2C_CMD_ID(h2c_pkt, value)                                     \
@@ -199,6 +244,57 @@ static inline void rtw_h2c_pkt_set_header(u8 *h2c_pkt, u8 sub_id)
 #define IQK_SET_SEGMENT_IQK(h2c_pkt, value)                                    \
 	le32p_replace_bits((__le32 *)(h2c_pkt) + 0x02, value, BIT(1))
 
+#define CHSW_INFO_SET_CH(pkt, value)					       \
+	le32p_replace_bits((__le32 *)(pkt) + 0x00, value, GENMASK(7, 0))
+#define CHSW_INFO_SET_PRI_CH_IDX(pkt, value)				       \
+	le32p_replace_bits((__le32 *)(pkt) + 0x00, value, GENMASK(11, 8))
+#define CHSW_INFO_SET_BW(pkt, value)					       \
+	le32p_replace_bits((__le32 *)(pkt) + 0x00, value, GENMASK(15, 12))
+#define CHSW_INFO_SET_TIMEOUT(pkt, value)				       \
+	le32p_replace_bits((__le32 *)(pkt) + 0x00, value, GENMASK(23, 16))
+#define CHSW_INFO_SET_ACTION_ID(pkt, value)				       \
+	le32p_replace_bits((__le32 *)(pkt) + 0x00, value, GENMASK(30, 24))
+
+#define UPDATE_PKT_SET_SIZE(h2c_pkt, value)				       \
+	le32p_replace_bits((__le32 *)(h2c_pkt) + 0x02, value, GENMASK(15, 0))
+#define UPDATE_PKT_SET_PKT_ID(h2c_pkt, value)				       \
+	le32p_replace_bits((__le32 *)(h2c_pkt) + 0x02, value, GENMASK(23, 16))
+#define UPDATE_PKT_SET_LOCATION(h2c_pkt, value)				       \
+	le32p_replace_bits((__le32 *)(h2c_pkt) + 0x02, value, GENMASK(31, 24))
+
+#define CH_SWITCH_SET_START(h2c_pkt, value)				       \
+	le32p_replace_bits((__le32 *)(h2c_pkt) + 0x02, value, BIT(0))
+#define CH_SWITCH_SET_DEST_CH_EN(h2c_pkt, value)			       \
+	le32p_replace_bits((__le32 *)(h2c_pkt) + 0x02, value, BIT(1))
+#define CH_SWITCH_SET_ABSOLUTE_TIME(h2c_pkt, value)			       \
+	le32p_replace_bits((__le32 *)(h2c_pkt) + 0x02, value, BIT(2))
+#define CH_SWITCH_SET_PERIODIC_OPT(h2c_pkt, value)			       \
+	le32p_replace_bits((__le32 *)(h2c_pkt) + 0x02, value, GENMASK(4, 3))
+#define CH_SWITCH_SET_INFO_LOC(h2c_pkt, value)				       \
+	le32p_replace_bits((__le32 *)(h2c_pkt) + 0x02, value, GENMASK(15, 8))
+#define CH_SWITCH_SET_CH_NUM(h2c_pkt, value)				       \
+	le32p_replace_bits((__le32 *)(h2c_pkt) + 0x02, value, GENMASK(23, 16))
+#define CH_SWITCH_SET_PRI_CH_IDX(h2c_pkt, value)			       \
+	le32p_replace_bits((__le32 *)(h2c_pkt) + 0x02, value, GENMASK(27, 24))
+#define CH_SWITCH_SET_DEST_CH(h2c_pkt, value)				       \
+	le32p_replace_bits((__le32 *)(h2c_pkt) + 0x03, value, GENMASK(7, 0))
+#define CH_SWITCH_SET_NORMAL_PERIOD(h2c_pkt, value)			       \
+	le32p_replace_bits((__le32 *)(h2c_pkt) + 0x03, value, GENMASK(13, 8))
+#define CH_SWITCH_SET_NORMAL_PERIOD_SEL(h2c_pkt, value)			       \
+	le32p_replace_bits((__le32 *)(h2c_pkt) + 0x03, value, GENMASK(15, 14))
+#define CH_SWITCH_SET_SLOW_PERIOD(h2c_pkt, value)			       \
+	le32p_replace_bits((__le32 *)(h2c_pkt) + 0x03, value, GENMASK(21, 16))
+#define CH_SWITCH_SET_SLOW_PERIOD_SEL(h2c_pkt, value)			       \
+	le32p_replace_bits((__le32 *)(h2c_pkt) + 0x03, value, GENMASK(23, 22))
+#define CH_SWITCH_SET_NORMAL_CYCLE(h2c_pkt, value)			       \
+	le32p_replace_bits((__le32 *)(h2c_pkt) + 0x03, value, GENMASK(31, 24))
+#define CH_SWITCH_SET_TSF_HIGH(h2c_pkt, value)				       \
+	le32p_replace_bits((__le32 *)(h2c_pkt) + 0x04, value, GENMASK(31, 0))
+#define CH_SWITCH_SET_TSF_LOW(h2c_pkt, value)				       \
+	le32p_replace_bits((__le32 *)(h2c_pkt) + 0x05, value, GENMASK(31, 0))
+#define CH_SWITCH_SET_INFO_SIZE(h2c_pkt, value)				       \
+	le32p_replace_bits((__le32 *)(h2c_pkt) + 0x06, value, GENMASK(15, 0))
+
 /* Command H2C */
 #define H2C_CMD_RSVD_PAGE		0x0
 #define H2C_CMD_MEDIA_STATUS_RPT	0x01
@@ -220,6 +316,8 @@ static inline void rtw_h2c_pkt_set_header(u8 *h2c_pkt, u8 sub_id)
 #define H2C_CMD_WOWLAN			0x80
 #define H2C_CMD_REMOTE_WAKE_CTRL	0x81
 #define H2C_CMD_AOAC_GLOBAL_INFO	0x82
+#define H2C_CMD_NLO_INFO		0x8C
+
 #define SET_H2C_CMD_ID_CLASS(h2c_pkt, value)				       \
 	le32p_replace_bits((__le32 *)(h2c_pkt) + 0x00, value, GENMASK(7, 0))
 
@@ -366,6 +464,15 @@ static inline void rtw_h2c_pkt_set_header(u8 *h2c_pkt, u8 sub_id)
 #define SET_AOAC_GLOBAL_INFO_GROUP_ENC_ALG(h2c_pkt, value)		       \
 	le32p_replace_bits((__le32 *)(h2c_pkt) + 0x00, value, GENMASK(23, 16))
 
+#define SET_NLO_FUN_EN(h2c_pkt, value)                                         \
+	le32p_replace_bits((__le32 *)(h2c_pkt) + 0x00, value, BIT(8))
+#define SET_NLO_PS_32K(h2c_pkt, value)                                         \
+	le32p_replace_bits((__le32 *)(h2c_pkt) + 0x00, value, BIT(9))
+#define SET_NLO_IGNORE_SECURITY(h2c_pkt, value)                                \
+	le32p_replace_bits((__le32 *)(h2c_pkt) + 0x00, value, BIT(10))
+#define SET_NLO_LOC_NLO_INFO(h2c_pkt, value)                                   \
+	le32p_replace_bits((__le32 *)(h2c_pkt) + 0x00, value, GENMASK(23, 16))
+
 static inline struct rtw_c2h_cmd *get_c2h_from_skb(struct sk_buff *skb)
 {
 	u32 pkt_offset;
@@ -397,6 +504,8 @@ void rtw_fw_send_ra_info(struct rtw_dev *rtwdev, struct rtw_sta_info *si);
 void rtw_fw_media_status_report(struct rtw_dev *rtwdev, u8 mac_id, bool conn);
 void rtw_add_rsvd_page(struct rtw_dev *rtwdev, enum rtw_rsvd_packet_type type,
 		       bool txdesc);
+void rtw_add_rsvd_page_probe_req(struct rtw_dev *rtwdev,
+				 struct cfg80211_ssid *ssid);
 int rtw_fw_write_data_rsvd_page(struct rtw_dev *rtwdev, u16 pg_addr,
 				u8 *buf, u32 size);
 void rtw_reset_rsvd_page(struct rtw_dev *rtwdev);
@@ -413,4 +522,8 @@ void rtw_fw_set_aoac_global_info_cmd(struct rtw_dev *rtwdev,
 				     u8 pairwise_key_enc,
 				     u8 group_key_enc);
 
+void rtw_fw_set_nlo_info(struct rtw_dev *rtwdev, bool enable);
+void rtw_fw_update_pkt_probe_req(struct rtw_dev *rtwdev,
+				 struct cfg80211_ssid *ssid);
+void rtw_fw_channel_switch(struct rtw_dev *rtwdev, bool enable);
 #endif
diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index 1ac48ccdb3c8..3d26c4a6e8da 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -1495,6 +1495,7 @@ int rtw_register_hw(struct rtw_dev *rtwdev, struct ieee80211_hw *hw)
 
 #ifdef CONFIG_PM
 	hw->wiphy->wowlan = rtwdev->chip->wowlan_stub;
+	hw->wiphy->max_sched_scan_ssids = rtwdev->chip->max_sched_scan_ssids;
 #endif
 	rtw_set_supported_band(hw, rtwdev->chip);
 	SET_IEEE80211_PERM_ADDR(hw, rtwdev->efuse.addr);
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index 74368ef954fa..4fa17aab3838 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -929,12 +929,24 @@ struct rtw_wow_pattern {
 	u8 mask[RTW_MAX_PATTERN_MASK_SIZE];
 };
 
+struct rtw_pno_request {
+	bool inited;
+	u32 match_set_cnt;
+	struct cfg80211_match_set *match_sets;
+	u8 channel_cnt;
+	struct ieee80211_channel *channels;
+	struct cfg80211_sched_scan_plan scan_plan;
+};
+
 struct rtw_wow_param {
 	struct ieee80211_vif *wow_vif;
 	DECLARE_BITMAP(flags, RTW_WOW_FLAG_MAX);
 	u8 txpause;
 	u8 pattern_cnt;
 	struct rtw_wow_pattern patterns[RTW_MAX_PATTERN_NUM];
+
+	bool ips_enabled;
+	struct rtw_pno_request pno_req;
 };
 
 struct rtw_intf_phy_para_table {
@@ -1067,6 +1079,7 @@ struct rtw_chip_info {
 
 	const char *wow_fw_name;
 	const struct wiphy_wowlan_support *wowlan_stub;
+	const u8 max_sched_scan_ssids;
 
 	/* coex paras */
 	u32 coex_para_ver;
@@ -1647,6 +1660,18 @@ static inline struct ieee80211_vif *rtwvif_to_vif(struct rtw_vif *rtwvif)
 	return container_of(p, struct ieee80211_vif, drv_priv);
 }
 
+static inline bool rtw_ssid_equal(struct cfg80211_ssid *a,
+				  struct cfg80211_ssid *b)
+{
+	if (!a || !b || a->ssid_len != b->ssid_len)
+		return false;
+
+	if (memcmp(a->ssid, b->ssid, a->ssid_len))
+		return false;
+
+	return true;
+}
+
 void rtw_get_channel_params(struct cfg80211_chan_def *chandef,
 			    struct rtw_channel_params *ch_param);
 bool check_hw_ready(struct rtw_dev *rtwdev, u32 addr, u32 mask, u32 target);
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.c b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
index 4836c0044b05..655ca9265f68 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
@@ -4063,10 +4063,12 @@ static const struct rtw_pwr_track_tbl rtw8822c_rtw_pwr_track_tbl = {
 #ifdef CONFIG_PM
 static const struct wiphy_wowlan_support rtw_wowlan_stub_8822c = {
 	.flags = WIPHY_WOWLAN_MAGIC_PKT | WIPHY_WOWLAN_GTK_REKEY_FAILURE |
-		 WIPHY_WOWLAN_DISCONNECT | WIPHY_WOWLAN_SUPPORTS_GTK_REKEY,
+		 WIPHY_WOWLAN_DISCONNECT | WIPHY_WOWLAN_SUPPORTS_GTK_REKEY |
+		 WIPHY_WOWLAN_NET_DETECT,
 	.n_patterns = RTW_MAX_PATTERN_NUM,
 	.pattern_max_len = RTW_MAX_PATTERN_SIZE,
 	.pattern_min_len = 1,
+	.max_nd_match_sets = 4,
 };
 #endif
 
@@ -4119,6 +4121,7 @@ struct rtw_chip_info rtw8822c_hw_spec = {
 #ifdef CONFIG_PM
 	.wow_fw_name = "rtw88/rtw8822c_wow_fw.bin",
 	.wowlan_stub = &rtw_wowlan_stub_8822c,
+	.max_sched_scan_ssids = 4,
 #endif
 	.coex_para_ver = 0x19062706,
 	.bt_desired_ver = 0x6,
diff --git a/drivers/net/wireless/realtek/rtw88/wow.c b/drivers/net/wireless/realtek/rtw88/wow.c
index fc9521740bc1..fc875fc400a5 100644
--- a/drivers/net/wireless/realtek/rtw88/wow.c
+++ b/drivers/net/wireless/realtek/rtw88/wow.c
@@ -28,6 +28,8 @@ static void rtw_wow_show_wakeup_reason(struct rtw_dev *rtwdev)
 		rtw_dbg(rtwdev, RTW_DBG_WOW, "WOW: Rx ptk rekey\n");
 	else if (reason == RTW_WOW_RSN_RX_PATTERN_MATCH)
 		rtw_dbg(rtwdev, RTW_DBG_WOW, "WOW: Rx pattern match packet\n");
+	else if (reason == RTW_WOW_RSN_RX_NLO)
+		rtw_dbg(rtwdev, RTW_DBG_WOW, "Rx NLO\n");
 	else
 		rtw_warn(rtwdev, "Unknown wakeup reason %x\n", reason);
 }
@@ -362,6 +364,10 @@ static int rtw_wow_fw_start(struct rtw_dev *rtwdev)
 		rtw_wow_fw_security_type(rtwdev);
 		rtw_fw_set_disconnect_decision_cmd(rtwdev, true);
 		rtw_fw_set_keep_alive_cmd(rtwdev, true);
+	} else if (rtw_wow_no_link(rtwdev)) {
+		rtw_fw_set_nlo_info(rtwdev, true);
+		rtw_fw_update_pkt_probe_req(rtwdev, NULL);
+		rtw_fw_channel_switch(rtwdev, true);
 	}
 
 	rtw_fw_set_wowlan_ctrl_cmd(rtwdev, true);
@@ -376,6 +382,9 @@ static int rtw_wow_fw_stop(struct rtw_dev *rtwdev)
 		rtw_fw_set_disconnect_decision_cmd(rtwdev, false);
 		rtw_fw_set_keep_alive_cmd(rtwdev, false);
 		rtw_wow_clear_pattern(rtwdev);
+	} else if (rtw_wow_no_link(rtwdev)) {
+		rtw_fw_channel_switch(rtwdev, false);
+		rtw_fw_set_nlo_info(rtwdev, false);
 	}
 
 	rtw_fw_set_wowlan_ctrl_cmd(rtwdev, false);
@@ -423,6 +432,22 @@ static void rtw_wow_fw_media_status(struct rtw_dev *rtwdev, bool connect)
 	rtw_iterate_stas_atomic(rtwdev, rtw_wow_fw_media_status_iter, &data);
 }
 
+void __rtw_wow_config_pno_rsvd_page(struct rtw_dev *rtwdev)
+{
+	struct rtw_wow_param *rtw_wow = &rtwdev->wow;
+	struct rtw_pno_request *rtw_pno_req = &rtw_wow->pno_req;
+	struct cfg80211_ssid *ssid;
+	int i;
+
+	for (i = 0 ; i < rtw_pno_req->match_set_cnt; i++) {
+		ssid = &rtw_pno_req->match_sets[i].ssid;
+		rtw_add_rsvd_page_probe_req(rtwdev, ssid);
+	}
+	rtw_add_rsvd_page_probe_req(rtwdev, NULL);
+	rtw_add_rsvd_page(rtwdev, RSVD_NLO_INFO, false);
+	rtw_add_rsvd_page(rtwdev, RSVD_CH_INFO, true);
+}
+
 void __rtw_wow_config_linked_rsvd_page(struct rtw_dev *rtwdev)
 {
 	rtw_add_rsvd_page(rtwdev, RSVD_PS_POLL, true);
@@ -436,8 +461,12 @@ static void rtw_wow_config_rsvd_page(struct rtw_dev *rtwdev)
 {
 	rtw_reset_rsvd_page(rtwdev);
 
-	if (rtw_wow_mgd_linked(rtwdev))
+	if (rtw_wow_mgd_linked(rtwdev)) {
 		__rtw_wow_config_linked_rsvd_page(rtwdev);
+	} else if (test_bit(RTW_FLAG_WOWLAN, rtwdev->flags) &&
+		   rtw_wow_no_link(rtwdev)) {
+		__rtw_wow_config_pno_rsvd_page(rtwdev);
+	}
 }
 
 static int rtw_wow_dl_fw_rsvd_page(struct rtw_dev *rtwdev)
@@ -480,11 +509,75 @@ static int rtw_wow_swap_fw(struct rtw_dev *rtwdev, enum rtw_fw_type type)
 	return ret;
 }
 
+static void rtw_wow_check_pno(struct rtw_dev *rtwdev,
+			      struct cfg80211_sched_scan_request *nd_config)
+{
+	struct rtw_wow_param *rtw_wow = &rtwdev->wow;
+	struct rtw_pno_request *pno_req = &rtw_wow->pno_req;
+	struct ieee80211_channel *channel;
+	int i, size;
+
+	if (!nd_config->n_match_sets || !nd_config->n_channels)
+		goto err;
+
+	pno_req->match_set_cnt = nd_config->n_match_sets;
+	size = sizeof(*pno_req->match_sets) * pno_req->match_set_cnt;
+	pno_req->match_sets = kmemdup(nd_config->match_sets, size, GFP_KERNEL);
+	if (!pno_req->match_sets)
+		goto err;
+
+	pno_req->channel_cnt = nd_config->n_channels;
+	size = sizeof(*nd_config->channels[0]) * nd_config->n_channels;
+	pno_req->channels = kmalloc(size, GFP_KERNEL);
+	if (!pno_req->channels)
+		goto channel_err;
+
+	for (i = 0 ; i < pno_req->channel_cnt; i++) {
+		channel = pno_req->channels + i;
+		memcpy(channel, nd_config->channels[i], sizeof(*channel));
+	}
+
+	pno_req->scan_plan = *nd_config->scan_plans;
+	pno_req->inited = true;
+
+	rtw_dbg(rtwdev, RTW_DBG_WOW, "WOW: net-detect is enabled\n");
+
+	return;
+
+channel_err:
+	kfree(pno_req->match_sets);
+
+err:
+	rtw_dbg(rtwdev, RTW_DBG_WOW, "WOW: net-detect is disabled\n");
+}
+
 static int __rtw_wow_leave_linked_ps(struct rtw_dev *rtwdev)
 {
 	if (!test_bit(RTW_FLAG_WOWLAN, rtwdev->flags))
 		cancel_delayed_work_sync(&rtwdev->watch_dog_work);
 
+	rtw_leave_lps(rtwdev);
+
+	return 0;
+}
+
+static int __rtw_wow_leave_no_link_ps(struct rtw_dev *rtwdev)
+{
+	struct rtw_wow_param *rtw_wow = &rtwdev->wow;
+	int ret = 0;
+
+	if (test_bit(RTW_FLAG_WOWLAN, rtwdev->flags)) {
+		if (rtw_fw_lps_deep_mode)
+			rtw_leave_lps_deep(rtwdev);
+	} else {
+		if (test_bit(RTW_FLAG_INACTIVE_PS, rtwdev->flags)) {
+			rtw_wow->ips_enabled = true;
+			ret = rtw_leave_ips(rtwdev);
+			if (ret)
+				return ret;
+		}
+	}
+
 	return 0;
 }
 
@@ -494,6 +587,18 @@ static int rtw_wow_leave_ps(struct rtw_dev *rtwdev)
 
 	if (rtw_wow_mgd_linked(rtwdev))
 		ret = __rtw_wow_leave_linked_ps(rtwdev);
+	else if (rtw_wow_no_link(rtwdev))
+		ret = __rtw_wow_leave_no_link_ps(rtwdev);
+
+	return ret;
+}
+
+static int rtw_wow_restore_ps(struct rtw_dev *rtwdev)
+{
+	int ret = 0;
+
+	if (rtw_wow_no_link(rtwdev) && rtwdev->wow.ips_enabled)
+		ret = rtw_enter_ips(rtwdev);
 
 	return ret;
 }
@@ -509,12 +614,22 @@ static int __rtw_wow_enter_linked_ps(struct rtw_dev *rtwdev)
 	return 0;
 }
 
+static int __rtw_wow_enter_no_link_ps(struct rtw_dev *rtwdev)
+{
+	/* firmware enters deep ps by itself if supported */
+	set_bit(RTW_FLAG_LEISURE_PS_DEEP, rtwdev->flags);
+
+	return 0;
+}
+
 static int rtw_wow_enter_ps(struct rtw_dev *rtwdev)
 {
 	int ret = 0;
 
 	if (rtw_wow_mgd_linked(rtwdev))
 		ret = __rtw_wow_enter_linked_ps(rtwdev);
+	else if (rtw_wow_no_link(rtwdev) && rtw_fw_lps_deep_mode)
+		ret = __rtw_wow_enter_no_link_ps(rtwdev);
 
 	return ret;
 }
@@ -653,6 +768,10 @@ static void rtw_wow_vif_iter(void *data, u8 *mac, struct ieee80211_vif *vif)
 	case RTW_NET_MGD_LINKED:
 		rtw_wow->wow_vif = vif;
 		break;
+	case RTW_NET_NO_LINK:
+		if (rtw_wow->pno_req.inited)
+			rtwdev->wow.wow_vif = vif;
+		break;
 	default:
 		break;
 	}
@@ -673,6 +792,9 @@ static int rtw_wow_set_wakeups(struct rtw_dev *rtwdev,
 	if (wowlan->gtk_rekey_failure)
 		set_bit(RTW_WOW_FLAG_EN_REKEY_PKT, rtw_wow->flags);
 
+	if (wowlan->nd_config)
+		rtw_wow_check_pno(rtwdev, wowlan->nd_config);
+
 	rtw_iterate_vifs_atomic(rtwdev, rtw_wow_vif_iter, rtwdev);
 	if (!rtw_wow->wow_vif)
 		return -EPERM;
@@ -692,6 +814,12 @@ static int rtw_wow_set_wakeups(struct rtw_dev *rtwdev,
 static void rtw_wow_clear_wakeups(struct rtw_dev *rtwdev)
 {
 	struct rtw_wow_param *rtw_wow = &rtwdev->wow;
+	struct rtw_pno_request *pno_req = &rtw_wow->pno_req;
+
+	if (pno_req->inited) {
+		kfree(pno_req->channels);
+		kfree(pno_req->match_sets);
+	}
 
 	memset(rtw_wow, 0, sizeof(rtwdev->wow));
 }
@@ -715,6 +843,7 @@ int rtw_wow_suspend(struct rtw_dev *rtwdev, struct cfg80211_wowlan *wowlan)
 	ret = rtw_wow_enable(rtwdev);
 	if (ret) {
 		rtw_err(rtwdev, "failed to enable wow\n");
+		rtw_wow_restore_ps(rtwdev);
 		goto out;
 	}
 
@@ -746,8 +875,14 @@ int rtw_wow_resume(struct rtw_dev *rtwdev)
 	rtw_wow_show_wakeup_reason(rtwdev);
 
 	ret = rtw_wow_disable(rtwdev);
-	if (ret)
+	if (ret) {
 		rtw_err(rtwdev, "failed to disable wow\n");
+		goto out;
+	}
+
+	ret = rtw_wow_restore_ps(rtwdev);
+	if (ret)
+		rtw_err(rtwdev, "failed to restore ps to normal mode\n");
 
 out:
 	rtw_wow_clear_wakeups(rtwdev);
diff --git a/drivers/net/wireless/realtek/rtw88/wow.h b/drivers/net/wireless/realtek/rtw88/wow.h
index 54f742f4c955..289368a2cba4 100644
--- a/drivers/net/wireless/realtek/rtw88/wow.h
+++ b/drivers/net/wireless/realtek/rtw88/wow.h
@@ -5,6 +5,8 @@
 #ifndef __RTW_WOW_H__
 #define __RTW_WOW_H__
 
+#define PNO_CHECK_BYTE 4
+
 enum rtw_wow_pattern_type {
 	RTW_PATTERN_BROADCAST = 0,
 	RTW_PATTERN_MULTICAST,
@@ -20,6 +22,7 @@ enum rtw_wake_reason {
 	RTW_WOW_RSN_DISCONNECT = 0x10,
 	RTW_WOW_RSN_RX_MAGIC_PKT = 0x21,
 	RTW_WOW_RSN_RX_PATTERN_MATCH = 0x23,
+	RTW_WOW_RSN_RX_NLO = 0x55,
 };
 
 struct rtw_fw_media_status_iter_data {
@@ -41,6 +44,14 @@ static inline bool rtw_wow_mgd_linked(struct rtw_dev *rtwdev)
 	return (rtwvif->net_type == RTW_NET_MGD_LINKED);
 }
 
+static inline bool rtw_wow_no_link(struct rtw_dev *rtwdev)
+{
+	struct ieee80211_vif *wow_vif = rtwdev->wow.wow_vif;
+	struct rtw_vif *rtwvif = (struct rtw_vif *)wow_vif->drv_priv;
+
+	return (rtwvif->net_type == RTW_NET_NO_LINK);
+}
+
 int rtw_wow_suspend(struct rtw_dev *rtwdev, struct cfg80211_wowlan *wowlan);
 int rtw_wow_resume(struct rtw_dev *rtwdev);
 
-- 
2.17.1

