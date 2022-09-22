Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B00D65E57BA
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Sep 2022 03:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbiIVBFj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Sep 2022 21:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbiIVBFe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Sep 2022 21:05:34 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DF1507C75B
        for <linux-wireless@vger.kernel.org>; Wed, 21 Sep 2022 18:05:31 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 28M150710019428, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 28M150710019428
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 22 Sep 2022 09:05:00 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 22 Sep 2022 09:05:23 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Thu, 22 Sep
 2022 09:05:23 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <dian_syuan0116@realtek.com>, <phhuang@realtek.com>,
        <linux-wireless@vger.kernel.org>
Subject: [PATCH 5/5] wifi: rtw89: support for processing P2P power saving
Date:   Thu, 22 Sep 2022 09:04:35 +0800
Message-ID: <20220922010435.12167-6-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220922010435.12167-1-pkshih@realtek.com>
References: <20220922010435.12167-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 09/22/2022 00:48:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzkvMjEgpFWkyCAxMDo1MjowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Dian-Syuan Yang <dian_syuan0116@realtek.com>

Support P2P client to process Notice of Absence (NoA) mechanism when it
connects with P2P GO applying an NoA schedule. We define some action
types including init, update, remove and terminate in h2c function to
enable/disable NoA schedule.

Signed-off-by: Dian-Syuan Yang <dian_syuan0116@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h     |  3 +
 drivers/net/wireless/realtek/rtw89/fw.c       | 92 ++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/fw.h       | 94 +++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/mac.c      |  7 ++
 drivers/net/wireless/realtek/rtw89/mac.h      |  1 +
 drivers/net/wireless/realtek/rtw89/mac80211.c |  3 +
 drivers/net/wireless/realtek/rtw89/ps.c       | 61 ++++++++++++
 drivers/net/wireless/realtek/rtw89/ps.h       |  1 +
 8 files changed, 262 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 6e54a00d55b68..7ecf8dfd2d413 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -2192,6 +2192,8 @@ struct rtw89_phy_rate_pattern {
 	bool enable;
 };
 
+#define RTW89_P2P_MAX_NOA_NUM 2
+
 struct rtw89_vif {
 	struct list_head list;
 	struct rtw89_dev *rtwdev;
@@ -2207,6 +2209,7 @@ struct rtw89_vif {
 	u8 wmm;
 	u8 bcn_hit_cond;
 	u8 hit_rule;
+	u8 last_noa_nr;
 	bool trigger;
 	bool lsig_txop;
 	u8 tgt_ind;
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index e4b12cdeb2de6..d57e3610fb88e 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -931,6 +931,58 @@ int rtw89_fw_h2c_lps_parm(struct rtw89_dev *rtwdev,
 	return ret;
 }
 
+#define H2C_P2P_ACT_LEN 20
+int rtw89_fw_h2c_p2p_act(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif,
+			 struct ieee80211_p2p_noa_desc *desc,
+			 u8 act, u8 noa_id)
+{
+	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
+	bool p2p_type_gc = rtwvif->wifi_role == RTW89_WIFI_ROLE_P2P_CLIENT;
+	u8 ctwindow_oppps = vif->bss_conf.p2p_noa_attr.oppps_ctwindow;
+	struct sk_buff *skb;
+	u8 *cmd;
+	int ret;
+
+	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, H2C_P2P_ACT_LEN);
+	if (!skb) {
+		rtw89_err(rtwdev, "failed to alloc skb for h2c p2p act\n");
+		return -ENOMEM;
+	}
+	skb_put(skb, H2C_P2P_ACT_LEN);
+	cmd = skb->data;
+
+	RTW89_SET_FWCMD_P2P_MACID(cmd, rtwvif->mac_id);
+	RTW89_SET_FWCMD_P2P_P2PID(cmd, 0);
+	RTW89_SET_FWCMD_P2P_NOAID(cmd, noa_id);
+	RTW89_SET_FWCMD_P2P_ACT(cmd, act);
+	RTW89_SET_FWCMD_P2P_TYPE(cmd, p2p_type_gc);
+	RTW89_SET_FWCMD_P2P_ALL_SLEP(cmd, 0);
+	if (desc) {
+		RTW89_SET_FWCMD_NOA_START_TIME(cmd, desc->start_time);
+		RTW89_SET_FWCMD_NOA_INTERVAL(cmd, desc->interval);
+		RTW89_SET_FWCMD_NOA_DURATION(cmd, desc->duration);
+		RTW89_SET_FWCMD_NOA_COUNT(cmd, desc->count);
+		RTW89_SET_FWCMD_NOA_CTWINDOW(cmd, ctwindow_oppps);
+	}
+
+	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
+			      H2C_CAT_MAC, H2C_CL_MAC_PS,
+			      H2C_FUNC_P2P_ACT, 0, 0,
+			      H2C_P2P_ACT_LEN);
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
+
 static void __rtw89_fw_h2c_set_tx_path(struct rtw89_dev *rtwdev,
 				       struct sk_buff *skb)
 {
@@ -1447,6 +1499,46 @@ int rtw89_fw_h2c_set_edca(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
 	return ret;
 }
 
+#define H2C_TSF32_TOGL_LEN 4
+int rtw89_fw_h2c_tsf32_toggle(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
+			      bool en)
+{
+	struct sk_buff *skb;
+	u16 early_us = en ? 2000 : 0;
+	u8 *cmd;
+	int ret;
+
+	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, H2C_TSF32_TOGL_LEN);
+	if (!skb) {
+		rtw89_err(rtwdev, "failed to alloc skb for h2c p2p act\n");
+		return -ENOMEM;
+	}
+	skb_put(skb, H2C_TSF32_TOGL_LEN);
+	cmd = skb->data;
+
+	RTW89_SET_FWCMD_TSF32_TOGL_BAND(cmd, rtwvif->mac_idx);
+	RTW89_SET_FWCMD_TSF32_TOGL_EN(cmd, en);
+	RTW89_SET_FWCMD_TSF32_TOGL_PORT(cmd, rtwvif->port);
+	RTW89_SET_FWCMD_TSF32_TOGL_EARLY(cmd, early_us);
+
+	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
+			      H2C_CAT_MAC, H2C_CL_MAC_FW_OFLD,
+			      H2C_FUNC_TSF32_TOGL, 0, 0,
+			      H2C_TSF32_TOGL_LEN);
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
+
 #define H2C_OFLD_CFG_LEN 8
 int rtw89_fw_h2c_set_ofld_cfg(struct rtw89_dev *rtwdev)
 {
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 249a463408534..0047d5d0e9b19 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -155,6 +155,13 @@ enum rtw89_chan_type {
 	RTW89_CHAN_DFS,
 };
 
+enum rtw89_p2pps_action {
+	RTW89_P2P_ACT_INIT = 0,
+	RTW89_P2P_ACT_UPDATE = 1,
+	RTW89_P2P_ACT_REMOVE = 2,
+	RTW89_P2P_ACT_TERMINATE = 3,
+};
+
 #define FWDL_SECTION_MAX_NUM 10
 #define FWDL_SECTION_CHKSUM_LEN	8
 #define FWDL_SECTION_PER_PKT_LEN 2020
@@ -2442,6 +2449,86 @@ static inline void RTW89_SET_FWCMD_SCANOFLD_TSF_SLOW(void *cmd, u32 val)
 	le32p_replace_bits((__le32 *)((u8 *)(cmd) + 16), val, GENMASK(31, 0));
 }
 
+static inline void RTW89_SET_FWCMD_P2P_MACID(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)cmd, val, GENMASK(7, 0));
+}
+
+static inline void RTW89_SET_FWCMD_P2P_P2PID(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)cmd, val, GENMASK(11, 8));
+}
+
+static inline void RTW89_SET_FWCMD_P2P_NOAID(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)cmd, val, GENMASK(15, 12));
+}
+
+static inline void RTW89_SET_FWCMD_P2P_ACT(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)cmd, val, GENMASK(19, 16));
+}
+
+static inline void RTW89_SET_FWCMD_P2P_TYPE(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)cmd, val, BIT(20));
+}
+
+static inline void RTW89_SET_FWCMD_P2P_ALL_SLEP(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)cmd, val, BIT(21));
+}
+
+static inline void RTW89_SET_FWCMD_NOA_START_TIME(void *cmd, __le32 val)
+{
+	*((__le32 *)cmd + 1) = val;
+}
+
+static inline void RTW89_SET_FWCMD_NOA_INTERVAL(void *cmd, __le32 val)
+{
+	*((__le32 *)cmd + 2) = val;
+}
+
+static inline void RTW89_SET_FWCMD_NOA_DURATION(void *cmd, __le32 val)
+{
+	*((__le32 *)cmd + 3) = val;
+}
+
+static inline void RTW89_SET_FWCMD_NOA_COUNT(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)(cmd) + 4, val, GENMASK(7, 0));
+}
+
+static inline void RTW89_SET_FWCMD_NOA_CTWINDOW(void *cmd, u32 val)
+{
+	u8 ctwnd;
+
+	if (!(val & IEEE80211_P2P_OPPPS_ENABLE_BIT))
+		return;
+	ctwnd = FIELD_GET(IEEE80211_P2P_OPPPS_CTWINDOW_MASK, val);
+	le32p_replace_bits((__le32 *)(cmd) + 4, ctwnd, GENMASK(23, 8));
+}
+
+static inline void RTW89_SET_FWCMD_TSF32_TOGL_BAND(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)cmd, val, BIT(0));
+}
+
+static inline void RTW89_SET_FWCMD_TSF32_TOGL_EN(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)cmd, val, BIT(1));
+}
+
+static inline void RTW89_SET_FWCMD_TSF32_TOGL_PORT(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)cmd, val, GENMASK(4, 2));
+}
+
+static inline void RTW89_SET_FWCMD_TSF32_TOGL_EARLY(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)cmd, val, GENMASK(31, 16));
+}
+
 #define RTW89_C2H_HEADER_LEN 8
 
 #define RTW89_GET_C2H_CATEGORY(c2h) \
@@ -2592,6 +2679,7 @@ struct rtw89_fw_h2c_rf_reg_info {
 /* CLASS 2 - PS */
 #define H2C_CL_MAC_PS			0x2
 #define H2C_FUNC_MAC_LPS_PARM		0x0
+#define H2C_FUNC_P2P_ACT		0x1
 
 /* CLASS 3 - FW download */
 #define H2C_CL_MAC_FWDL		0x3
@@ -2618,6 +2706,7 @@ struct rtw89_fw_h2c_rf_reg_info {
 #define H2C_FUNC_PACKET_OFLD		0x1
 #define H2C_FUNC_MAC_MACID_PAUSE	0x8
 #define H2C_FUNC_USR_EDCA		0xF
+#define H2C_FUNC_TSF32_TOGL		0x10
 #define H2C_FUNC_OFLD_CFG		0x14
 #define H2C_FUNC_ADD_SCANOFLD_CH	0x16
 #define H2C_FUNC_SCANOFLD		0x17
@@ -2751,6 +2840,11 @@ void rtw89_hw_scan_abort(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif);
 int rtw89_fw_h2c_trigger_cpu_exception(struct rtw89_dev *rtwdev);
 int rtw89_fw_h2c_pkt_drop(struct rtw89_dev *rtwdev,
 			  const struct rtw89_pkt_drop_params *params);
+int rtw89_fw_h2c_p2p_act(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif,
+			 struct ieee80211_p2p_noa_desc *desc,
+			 u8 act, u8 noa_id);
+int rtw89_fw_h2c_tsf32_toggle(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
+			      bool en);
 
 static inline void rtw89_fw_h2c_init_ba_cam(struct rtw89_dev *rtwdev)
 {
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index dad55952e6bdc..d5a2e30a4ba0d 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -3843,6 +3843,12 @@ rtw89_mac_c2h_pkt_ofld_rsp(struct rtw89_dev *rtwdev, struct sk_buff *c2h,
 {
 }
 
+static void
+rtw89_mac_c2h_tsf32_toggle_rpt(struct rtw89_dev *rtwdev, struct sk_buff *c2h,
+			       u32 len)
+{
+}
+
 static
 void (* const rtw89_mac_c2h_ofld_handler[])(struct rtw89_dev *rtwdev,
 					    struct sk_buff *c2h, u32 len) = {
@@ -3852,6 +3858,7 @@ void (* const rtw89_mac_c2h_ofld_handler[])(struct rtw89_dev *rtwdev,
 	[RTW89_MAC_C2H_FUNC_BCN_RESEND] = NULL,
 	[RTW89_MAC_C2H_FUNC_MACID_PAUSE] = rtw89_mac_c2h_macid_pause,
 	[RTW89_MAC_C2H_FUNC_SCANOFLD_RSP] = rtw89_mac_c2h_scanofld_rsp,
+	[RTW89_MAC_C2H_FUNC_TSF32_TOGL_RPT] = rtw89_mac_c2h_tsf32_toggle_rpt,
 };
 
 static
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index 22db80716b560..9cb5d20e6e33a 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -306,6 +306,7 @@ enum rtw89_mac_c2h_ofld_func {
 	RTW89_MAC_C2H_FUNC_PKT_OFLD_RSP,
 	RTW89_MAC_C2H_FUNC_BCN_RESEND,
 	RTW89_MAC_C2H_FUNC_MACID_PAUSE,
+	RTW89_MAC_C2H_FUNC_TSF32_TOGL_RPT = 0x6,
 	RTW89_MAC_C2H_FUNC_SCANOFLD_RSP = 0x9,
 	RTW89_MAC_C2H_FUNC_OFLD_MAX,
 };
diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index 70f555887c6ea..cf70570087bf8 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -407,6 +407,9 @@ static void rtw89_ops_bss_info_changed(struct ieee80211_hw *hw,
 	if (changed & BSS_CHANGED_MU_GROUPS)
 		rtw89_mac_bf_set_gid_table(rtwdev, vif, conf);
 
+	if (changed & BSS_CHANGED_P2P_PS)
+		rtw89_process_p2p_ps(rtwdev, vif);
+
 	mutex_unlock(&rtwdev->mutex);
 }
 
diff --git a/drivers/net/wireless/realtek/rtw89/ps.c b/drivers/net/wireless/realtek/rtw89/ps.c
index 3c56a5ef40f84..bf41a11416792 100644
--- a/drivers/net/wireless/realtek/rtw89/ps.c
+++ b/drivers/net/wireless/realtek/rtw89/ps.c
@@ -183,3 +183,64 @@ void rtw89_set_coex_ctrl_lps(struct rtw89_dev *rtwdev, bool btc_ctrl)
 	if (btc_ctrl)
 		rtw89_leave_lps(rtwdev);
 }
+
+static void rtw89_tsf32_toggle(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
+			       enum rtw89_p2pps_action act)
+{
+	if (act == RTW89_P2P_ACT_UPDATE || act == RTW89_P2P_ACT_REMOVE)
+		return;
+
+	if (act == RTW89_P2P_ACT_INIT)
+		rtw89_fw_h2c_tsf32_toggle(rtwdev, rtwvif, true);
+	else if (act == RTW89_P2P_ACT_TERMINATE)
+		rtw89_fw_h2c_tsf32_toggle(rtwdev, rtwvif, false);
+}
+
+static void rtw89_p2p_disable_all_noa(struct rtw89_dev *rtwdev,
+				      struct ieee80211_vif *vif)
+{
+	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
+	enum rtw89_p2pps_action act;
+	u8 noa_id;
+
+	if (rtwvif->last_noa_nr == 0)
+		return;
+
+	for (noa_id = 0; noa_id < rtwvif->last_noa_nr; noa_id++) {
+		if (noa_id == rtwvif->last_noa_nr - 1)
+			act = RTW89_P2P_ACT_TERMINATE;
+		else
+			act = RTW89_P2P_ACT_REMOVE;
+		rtw89_tsf32_toggle(rtwdev, rtwvif, act);
+		rtw89_fw_h2c_p2p_act(rtwdev, vif, NULL, act, noa_id);
+	}
+}
+
+static void rtw89_p2p_update_noa(struct rtw89_dev *rtwdev,
+				 struct ieee80211_vif *vif)
+{
+	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
+	struct ieee80211_p2p_noa_desc *desc;
+	enum rtw89_p2pps_action act;
+	u8 noa_id;
+
+	for (noa_id = 0; noa_id < RTW89_P2P_MAX_NOA_NUM; noa_id++) {
+		desc = &vif->bss_conf.p2p_noa_attr.desc[noa_id];
+		if (!desc->count || !desc->duration)
+			break;
+
+		if (noa_id == 0)
+			act = RTW89_P2P_ACT_INIT;
+		else
+			act = RTW89_P2P_ACT_UPDATE;
+		rtw89_tsf32_toggle(rtwdev, rtwvif, act);
+		rtw89_fw_h2c_p2p_act(rtwdev, vif, desc, act, noa_id);
+	}
+	rtwvif->last_noa_nr = noa_id;
+}
+
+void rtw89_process_p2p_ps(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif)
+{
+	rtw89_p2p_disable_all_noa(rtwdev, vif);
+	rtw89_p2p_update_noa(rtwdev, vif);
+}
diff --git a/drivers/net/wireless/realtek/rtw89/ps.h b/drivers/net/wireless/realtek/rtw89/ps.h
index 7d371293d6bc9..0feae39916238 100644
--- a/drivers/net/wireless/realtek/rtw89/ps.h
+++ b/drivers/net/wireless/realtek/rtw89/ps.h
@@ -12,5 +12,6 @@ void rtw89_leave_ps_mode(struct rtw89_dev *rtwdev);
 void rtw89_enter_ips(struct rtw89_dev *rtwdev);
 void rtw89_leave_ips(struct rtw89_dev *rtwdev);
 void rtw89_set_coex_ctrl_lps(struct rtw89_dev *rtwdev, bool btc_ctrl);
+void rtw89_process_p2p_ps(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif);
 
 #endif
-- 
2.25.1

