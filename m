Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82D945B7FC5
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Sep 2022 05:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbiINDvf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 13 Sep 2022 23:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiINDv3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 13 Sep 2022 23:51:29 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C07A46FA01
        for <linux-wireless@vger.kernel.org>; Tue, 13 Sep 2022 20:51:27 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 28E3optfF007525, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 28E3optfF007525
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 14 Sep 2022 11:50:51 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 14 Sep 2022 11:51:12 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Wed, 14 Sep
 2022 11:51:11 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 2/4] wifi: rtw89: introudce functions to drop packets
Date:   Wed, 14 Sep 2022 11:50:32 +0800
Message-ID: <20220914035034.14521-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220914035034.14521-1-pkshih@realtek.com>
References: <20220914035034.14521-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 09/14/2022 03:18:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzkvMTMgpFWkyCAxMToxMjowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Zong-Zhe Yang <kevin_yang@realtek.com>

Introudce a H2C feature to drop packets according to given parameters.
And, we implement instances to drop packets from BE, BK, VI, VO queues
by vif or sta. Then, we refine our callback of ieee80211_ops::flush to
deal with the case of drop=true via this feature.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h     | 27 +++++++++
 drivers/net/wireless/realtek/rtw89/fw.c       | 56 +++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/fw.h       | 33 +++++++++++
 drivers/net/wireless/realtek/rtw89/mac.c      | 45 +++++++++++++++
 drivers/net/wireless/realtek/rtw89/mac.h      |  1 +
 drivers/net/wireless/realtek/rtw89/mac80211.c | 22 +++++++-
 6 files changed, 183 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index bd2c09e69f08d..c3eb598120617 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -2734,6 +2734,7 @@ enum rtw89_fw_feature {
 	RTW89_FW_FEATURE_SCAN_OFFLOAD,
 	RTW89_FW_FEATURE_TX_WAKE,
 	RTW89_FW_FEATURE_CRASH_TRIGGER,
+	RTW89_FW_FEATURE_PACKET_DROP,
 	RTW89_FW_FEATURE_NO_DEEP_PS,
 };
 
@@ -2882,6 +2883,32 @@ enum rtw89_flags {
 	NUM_OF_RTW89_FLAGS,
 };
 
+enum rtw89_pkt_drop_sel {
+	RTW89_PKT_DROP_SEL_MACID_BE_ONCE,
+	RTW89_PKT_DROP_SEL_MACID_BK_ONCE,
+	RTW89_PKT_DROP_SEL_MACID_VI_ONCE,
+	RTW89_PKT_DROP_SEL_MACID_VO_ONCE,
+	RTW89_PKT_DROP_SEL_MACID_ALL,
+	RTW89_PKT_DROP_SEL_MG0_ONCE,
+	RTW89_PKT_DROP_SEL_HIQ_ONCE,
+	RTW89_PKT_DROP_SEL_HIQ_PORT,
+	RTW89_PKT_DROP_SEL_HIQ_MBSSID,
+	RTW89_PKT_DROP_SEL_BAND,
+	RTW89_PKT_DROP_SEL_BAND_ONCE,
+	RTW89_PKT_DROP_SEL_REL_MACID,
+	RTW89_PKT_DROP_SEL_REL_HIQ_PORT,
+	RTW89_PKT_DROP_SEL_REL_HIQ_MBSSID,
+};
+
+struct rtw89_pkt_drop_params {
+	enum rtw89_pkt_drop_sel sel;
+	enum rtw89_mac_idx mac_band;
+	u8 macid;
+	u8 port;
+	u8 mbssid;
+	bool tf_trs;
+};
+
 struct rtw89_pkt_stat {
 	u16 beacon_nr;
 	u32 rx_rate_cnt[RTW89_HW_RATE_NR];
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 7605c77022fdf..a312da5042c41 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -225,6 +225,8 @@ static const struct __fw_feat_cfg fw_feat_tbl[] = {
 	__CFG_FW_FEAT(RTL8852A, ge, 0, 13, 35, 0, SCAN_OFFLOAD),
 	__CFG_FW_FEAT(RTL8852A, ge, 0, 13, 35, 0, TX_WAKE),
 	__CFG_FW_FEAT(RTL8852A, ge, 0, 13, 36, 0, CRASH_TRIGGER),
+	__CFG_FW_FEAT(RTL8852A, ge, 0, 13, 38, 0, PACKET_DROP),
+	__CFG_FW_FEAT(RTL8852C, ge, 0, 27, 20, 0, PACKET_DROP),
 	__CFG_FW_FEAT(RTL8852C, le, 0, 27, 33, 0, NO_DEEP_PS),
 	__CFG_FW_FEAT(RTL8852C, ge, 0, 27, 34, 0, TX_WAKE),
 	__CFG_FW_FEAT(RTL8852C, ge, 0, 27, 36, 0, SCAN_OFFLOAD),
@@ -2733,3 +2735,57 @@ int rtw89_fw_h2c_trigger_cpu_exception(struct rtw89_dev *rtwdev)
 	dev_kfree_skb_any(skb);
 	return ret;
 }
+
+#define H2C_PKT_DROP_LEN 24
+int rtw89_fw_h2c_pkt_drop(struct rtw89_dev *rtwdev,
+			  const struct rtw89_pkt_drop_params *params)
+{
+	struct sk_buff *skb;
+	int ret;
+
+	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, H2C_PKT_DROP_LEN);
+	if (!skb) {
+		rtw89_err(rtwdev,
+			  "failed to alloc skb for packet drop\n");
+		return -ENOMEM;
+	}
+
+	switch (params->sel) {
+	case RTW89_PKT_DROP_SEL_MACID_BE_ONCE:
+	case RTW89_PKT_DROP_SEL_MACID_BK_ONCE:
+	case RTW89_PKT_DROP_SEL_MACID_VI_ONCE:
+	case RTW89_PKT_DROP_SEL_MACID_VO_ONCE:
+		break;
+	default:
+		rtw89_debug(rtwdev, RTW89_DBG_FW,
+			    "H2C of pkt drop might not fully support sel: %d yet\n",
+			    params->sel);
+		break;
+	}
+
+	skb_put(skb, H2C_PKT_DROP_LEN);
+	RTW89_SET_FWCMD_PKT_DROP_SEL(skb->data, params->sel);
+	RTW89_SET_FWCMD_PKT_DROP_MACID(skb->data, params->macid);
+	RTW89_SET_FWCMD_PKT_DROP_BAND(skb->data, params->mac_band);
+	RTW89_SET_FWCMD_PKT_DROP_PORT(skb->data, params->port);
+	RTW89_SET_FWCMD_PKT_DROP_MBSSID(skb->data, params->mbssid);
+	RTW89_SET_FWCMD_PKT_DROP_ROLE_A_INFO_TF_TRS(skb->data, params->tf_trs);
+
+	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
+			      H2C_CAT_MAC,
+			      H2C_CL_MAC_FW_OFLD,
+			      H2C_FUNC_PKT_DROP, 0, 0,
+			      H2C_PKT_DROP_LEN);
+
+	ret = rtw89_h2c_tx(rtwdev, skb, false);
+	if (ret) {
+		rtw89_err(rtwdev, "failed to send h2c\n");
+		goto fail;
+	}
+
+	return 0;
+
+fail:
+	dev_kfree_skb_any(skb);
+	return ret;
+}
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index a055ea55b2ad7..b5ee92b727c4b 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -1813,6 +1813,36 @@ static inline void RTW89_SET_FWCMD_CPU_EXCEPTION_TYPE(void *cmd, u32 val)
 	le32p_replace_bits((__le32 *)cmd, val, GENMASK(31, 0));
 }
 
+static inline void RTW89_SET_FWCMD_PKT_DROP_SEL(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)cmd, val, GENMASK(7, 0));
+}
+
+static inline void RTW89_SET_FWCMD_PKT_DROP_MACID(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)cmd, val, GENMASK(15, 8));
+}
+
+static inline void RTW89_SET_FWCMD_PKT_DROP_BAND(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)cmd, val, GENMASK(23, 16));
+}
+
+static inline void RTW89_SET_FWCMD_PKT_DROP_PORT(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)cmd, val, GENMASK(31, 24));
+}
+
+static inline void RTW89_SET_FWCMD_PKT_DROP_MBSSID(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)cmd + 1, val, GENMASK(7, 0));
+}
+
+static inline void RTW89_SET_FWCMD_PKT_DROP_ROLE_A_INFO_TF_TRS(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)cmd + 1, val, GENMASK(15, 8));
+}
+
 enum rtw89_btc_btf_h2c_class {
 	BTFC_SET = 0x10,
 	BTFC_GET = 0x11,
@@ -2581,6 +2611,7 @@ struct rtw89_fw_h2c_rf_reg_info {
 #define H2C_FUNC_OFLD_CFG		0x14
 #define H2C_FUNC_ADD_SCANOFLD_CH	0x16
 #define H2C_FUNC_SCANOFLD		0x17
+#define H2C_FUNC_PKT_DROP		0x1b
 
 /* CLASS 10 - Security CAM */
 #define H2C_CL_MAC_SEC_CAM		0xa
@@ -2708,6 +2739,8 @@ int rtw89_hw_scan_offload(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif,
 			  bool enable);
 void rtw89_hw_scan_abort(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif);
 int rtw89_fw_h2c_trigger_cpu_exception(struct rtw89_dev *rtwdev);
+int rtw89_fw_h2c_pkt_drop(struct rtw89_dev *rtwdev,
+			  const struct rtw89_pkt_drop_params *params);
 
 static inline void rtw89_fw_h2c_init_ba_cam(struct rtw89_dev *rtwdev)
 {
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index dd9dbe5ad6d30..2fda7929e50fd 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -4716,3 +4716,48 @@ int rtw89_mac_read_xtal_si(struct rtw89_dev *rtwdev, u8 offset, u8 *val)
 
 	return 0;
 }
+
+static
+void rtw89_mac_pkt_drop_sta(struct rtw89_dev *rtwdev, struct rtw89_sta *rtwsta)
+{
+	static const enum rtw89_pkt_drop_sel sels[] = {
+		RTW89_PKT_DROP_SEL_MACID_BE_ONCE,
+		RTW89_PKT_DROP_SEL_MACID_BK_ONCE,
+		RTW89_PKT_DROP_SEL_MACID_VI_ONCE,
+		RTW89_PKT_DROP_SEL_MACID_VO_ONCE,
+	};
+	struct rtw89_vif *rtwvif = rtwsta->rtwvif;
+	struct rtw89_pkt_drop_params params = {0};
+	int i;
+
+	params.mac_band = RTW89_MAC_0;
+	params.macid = rtwsta->mac_id;
+	params.port = rtwvif->port;
+	params.mbssid = 0;
+	params.tf_trs = rtwvif->trigger;
+
+	for (i = 0; i < ARRAY_SIZE(sels); i++) {
+		params.sel = sels[i];
+		rtw89_fw_h2c_pkt_drop(rtwdev, &params);
+	}
+}
+
+static void rtw89_mac_pkt_drop_vif_iter(void *data, struct ieee80211_sta *sta)
+{
+	struct rtw89_sta *rtwsta = (struct rtw89_sta *)sta->drv_priv;
+	struct rtw89_vif *rtwvif = rtwsta->rtwvif;
+	struct rtw89_dev *rtwdev = rtwvif->rtwdev;
+	struct rtw89_vif *target = data;
+
+	if (rtwvif != target)
+		return;
+
+	rtw89_mac_pkt_drop_sta(rtwdev, rtwsta);
+}
+
+void rtw89_mac_pkt_drop_vif(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
+{
+	ieee80211_iterate_stations_atomic(rtwdev->hw,
+					  rtw89_mac_pkt_drop_vif_iter,
+					  rtwvif);
+}
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index 986e359a82237..12ef97bac39ad 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -963,5 +963,6 @@ enum rtw89_mac_xtal_si_offset {
 
 int rtw89_mac_write_xtal_si(struct rtw89_dev *rtwdev, u8 offset, u8 val, u8 mask);
 int rtw89_mac_read_xtal_si(struct rtw89_dev *rtwdev, u8 offset, u8 *val);
+void rtw89_mac_pkt_drop_vif(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif);
 
 #endif
diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index a8c711ea5d456..b29fd63b83b85 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -13,6 +13,7 @@
 #include "reg.h"
 #include "sar.h"
 #include "ser.h"
+#include "util.h"
 
 static void rtw89_ops_tx(struct ieee80211_hw *hw,
 			 struct ieee80211_tx_control *control,
@@ -610,6 +611,20 @@ static void rtw89_ops_sta_statistics(struct ieee80211_hw *hw,
 	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_BITRATE);
 }
 
+static
+void __rtw89_drop_packets(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif)
+{
+	struct rtw89_vif *rtwvif;
+
+	if (vif) {
+		rtwvif = (struct rtw89_vif *)vif->drv_priv;
+		rtw89_mac_pkt_drop_vif(rtwdev, rtwvif);
+	} else {
+		rtw89_for_each_rtwvif(rtwdev, rtwvif)
+			rtw89_mac_pkt_drop_vif(rtwdev, rtwvif);
+	}
+}
+
 static void rtw89_ops_flush(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 			    u32 queues, bool drop)
 {
@@ -618,7 +633,12 @@ static void rtw89_ops_flush(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	mutex_lock(&rtwdev->mutex);
 	rtw89_leave_lps(rtwdev);
 	rtw89_hci_flush_queues(rtwdev, queues, drop);
-	rtw89_mac_flush_txq(rtwdev, queues, drop);
+
+	if (drop && RTW89_CHK_FW_FEATURE(PACKET_DROP, &rtwdev->fw))
+		__rtw89_drop_packets(rtwdev, vif);
+	else
+		rtw89_mac_flush_txq(rtwdev, queues, drop);
+
 	mutex_unlock(&rtwdev->mutex);
 }
 
-- 
2.25.1

