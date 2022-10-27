Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7D860EF7F
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Oct 2022 07:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233923AbiJ0F2M (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Oct 2022 01:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234043AbiJ0F14 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Oct 2022 01:27:56 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 074F015A8EE
        for <linux-wireless@vger.kernel.org>; Wed, 26 Oct 2022 22:27:54 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 29R5RDstC020054, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 29R5RDstC020054
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 27 Oct 2022 13:27:13 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.9; Thu, 27 Oct 2022 13:27:47 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Thu, 27 Oct
 2022 13:27:46 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <gary.chang@realtek.com>, <timlee@realtek.com>,
        <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 5/7] wifi: rtw89: add related H2C for WoWLAN mode
Date:   Thu, 27 Oct 2022 13:27:05 +0800
Message-ID: <20221027052707.14605-6-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221027052707.14605-1-pkshih@realtek.com>
References: <20221027052707.14605-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 10/27/2022 05:04:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzEwLzI2IKRVpMggMTE6MzI6MDA=?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Chin-Yen Lee <timlee@realtek.com>

In this patch we define some H2C, which will be called during suspend
flow, to enable WoWLAN function provided by WoWLAN firmware.

These H2C includes keep alive used to send null packet to AP periodically
to avoid being disconnected by AP, disconnect detection used to configure
how we check if AP is offline, wake up control used to decide which WiFi
events could trigger resume flow, and global control used to enable WoWLAN
function.

Signed-off-by: Chin-Yen Lee <timlee@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h |  30 +++
 drivers/net/wireless/realtek/rtw89/fw.c   | 229 ++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/fw.h   | 160 +++++++++++++++
 3 files changed, 419 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 6b6bb3260fff4..d20cb3ae89e98 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -477,6 +477,20 @@ enum rtw89_regulation_type {
 	RTW89_REGD_NUM,
 };
 
+enum rtw89_fw_pkt_ofld_type {
+	RTW89_PKT_OFLD_TYPE_PROBE_RSP = 0,
+	RTW89_PKT_OFLD_TYPE_PS_POLL = 1,
+	RTW89_PKT_OFLD_TYPE_NULL_DATA = 2,
+	RTW89_PKT_OFLD_TYPE_QOS_NULL = 3,
+	RTW89_PKT_OFLD_TYPE_CTS2SELF = 4,
+	RTW89_PKT_OFLD_TYPE_ARP_RSP = 5,
+	RTW89_PKT_OFLD_TYPE_NDP = 6,
+	RTW89_PKT_OFLD_TYPE_EAPOL_KEY = 7,
+	RTW89_PKT_OFLD_TYPE_SA_QUERY = 8,
+	RTW89_PKT_OFLD_TYPE_PROBE_REQ = 12,
+	RTW89_PKT_OFLD_TYPE_NUM,
+};
+
 struct rtw89_txpwr_byrate {
 	s8 cck[RTW89_RATE_CCK_MAX];
 	s8 ofdm[RTW89_RATE_OFDM_MAX];
@@ -636,6 +650,13 @@ enum rtw89_sc_offset {
 	RTW89_SC_40_LOWER	= 10,
 };
 
+enum rtw89_wow_flags {
+	RTW89_WOW_FLAG_EN_MAGIC_PKT,
+	RTW89_WOW_FLAG_EN_REKEY_PKT,
+	RTW89_WOW_FLAG_EN_DISCONNECT,
+	RTW89_WOW_FLAG_NUM,
+};
+
 struct rtw89_chan {
 	u8 channel;
 	u8 primary_channel;
@@ -3453,6 +3474,13 @@ struct rtw89_phy_efuse_gain {
 	s8 comp[RF_PATH_MAX][RTW89_SUBBAND_NR]; /* S(8, 0) */
 };
 
+struct rtw89_wow_param {
+	struct ieee80211_vif *wow_vif;
+	DECLARE_BITMAP(flags, RTW89_WOW_FLAG_NUM);
+	u8 pattern_cnt;
+	struct list_head pkt_list;
+};
+
 struct rtw89_dev {
 	struct ieee80211_hw *hw;
 	struct device *dev;
@@ -3541,6 +3569,8 @@ struct rtw89_dev {
 	enum rtw89_ps_mode ps_mode;
 	bool lps_enabled;
 
+	struct rtw89_wow_param wow;
+
 	/* napi structure */
 	struct net_device netdev;
 	struct napi_struct napi;
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 545b06bbde6c2..13c920f66908c 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -853,6 +853,56 @@ int rtw89_fw_h2c_fw_log(struct rtw89_dev *rtwdev, bool enable)
 	return ret;
 }
 
+static int rtw89_fw_h2c_add_wow_fw_ofld(struct rtw89_dev *rtwdev,
+					struct rtw89_vif *rtwvif,
+					enum rtw89_fw_pkt_ofld_type type,
+					u8 *id)
+{
+	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif);
+	struct rtw89_wow_param *rtw_wow = &rtwdev->wow;
+	struct rtw89_pktofld_info *info;
+	struct sk_buff *skb;
+	int ret;
+
+	info = kzalloc(sizeof(*info), GFP_KERNEL);
+	if (!info)
+		return -ENOMEM;
+
+	switch (type) {
+	case RTW89_PKT_OFLD_TYPE_PS_POLL:
+		skb = ieee80211_pspoll_get(rtwdev->hw, vif);
+		break;
+	case RTW89_PKT_OFLD_TYPE_PROBE_RSP:
+		skb = ieee80211_proberesp_get(rtwdev->hw, vif);
+		break;
+	case RTW89_PKT_OFLD_TYPE_NULL_DATA:
+		skb = ieee80211_nullfunc_get(rtwdev->hw, vif, -1, false);
+		break;
+	case RTW89_PKT_OFLD_TYPE_QOS_NULL:
+		skb = ieee80211_nullfunc_get(rtwdev->hw, vif, -1, true);
+		break;
+	default:
+		goto err;
+	}
+
+	if (!skb)
+		goto err;
+
+	list_add_tail(&info->list, &rtw_wow->pkt_list);
+	ret = rtw89_fw_h2c_add_pkt_offload(rtwdev, &info->id, skb);
+	kfree_skb(skb);
+
+	if (ret)
+		return ret;
+
+	*id = info->id;
+	return 0;
+
+err:
+	kfree(info);
+	return -ENOMEM;
+}
+
 #define H2C_GENERAL_PKT_LEN 6
 #define H2C_GENERAL_PKT_ID_UND 0xff
 int rtw89_fw_h2c_general_pkt(struct rtw89_dev *rtwdev, u8 macid)
@@ -2927,3 +2977,182 @@ int rtw89_fw_h2c_pkt_drop(struct rtw89_dev *rtwdev,
 	dev_kfree_skb_any(skb);
 	return ret;
 }
+
+#define H2C_KEEP_ALIVE_LEN 4
+int rtw89_fw_h2c_keep_alive(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
+			    bool enable)
+{
+	struct sk_buff *skb;
+	u8 pkt_id = 0;
+	int ret;
+
+	if (enable) {
+		ret = rtw89_fw_h2c_add_wow_fw_ofld(rtwdev, rtwvif,
+						   RTW89_PKT_OFLD_TYPE_NULL_DATA, &pkt_id);
+		if (ret)
+			return -EPERM;
+	}
+
+	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, H2C_KEEP_ALIVE_LEN);
+	if (!skb) {
+		rtw89_err(rtwdev, "failed to alloc skb for keep alive\n");
+		return -ENOMEM;
+	}
+
+	skb_put(skb, H2C_KEEP_ALIVE_LEN);
+
+	RTW89_SET_KEEP_ALIVE_ENABLE(skb->data, enable);
+	RTW89_SET_KEEP_ALIVE_PKT_NULL_ID(skb->data, pkt_id);
+	RTW89_SET_KEEP_ALIVE_PERIOD(skb->data, 5);
+	RTW89_SET_KEEP_ALIVE_MACID(skb->data, rtwvif->mac_id);
+
+	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
+			      H2C_CAT_MAC,
+			      H2C_CL_MAC_WOW,
+			      H2C_FUNC_KEEP_ALIVE, 0, 1,
+			      H2C_KEEP_ALIVE_LEN);
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
+
+	return ret;
+}
+
+#define H2C_DISCONNECT_DETECT_LEN 8
+int rtw89_fw_h2c_disconnect_detect(struct rtw89_dev *rtwdev,
+				   struct rtw89_vif *rtwvif, bool enable)
+{
+	struct rtw89_wow_param *rtw_wow = &rtwdev->wow;
+	struct sk_buff *skb;
+	u8 macid = rtwvif->mac_id;
+	int ret;
+
+	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, H2C_DISCONNECT_DETECT_LEN);
+	if (!skb) {
+		rtw89_err(rtwdev, "failed to alloc skb for keep alive\n");
+		return -ENOMEM;
+	}
+
+	skb_put(skb, H2C_DISCONNECT_DETECT_LEN);
+
+	if (test_bit(RTW89_WOW_FLAG_EN_DISCONNECT, rtw_wow->flags)) {
+		RTW89_SET_DISCONNECT_DETECT_ENABLE(skb->data, enable);
+		RTW89_SET_DISCONNECT_DETECT_DISCONNECT(skb->data, !enable);
+		RTW89_SET_DISCONNECT_DETECT_MAC_ID(skb->data, macid);
+		RTW89_SET_DISCONNECT_DETECT_CHECK_PERIOD(skb->data, 100);
+		RTW89_SET_DISCONNECT_DETECT_TRY_PKT_COUNT(skb->data, 5);
+	}
+
+	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
+			      H2C_CAT_MAC,
+			      H2C_CL_MAC_WOW,
+			      H2C_FUNC_DISCONNECT_DETECT, 0, 1,
+			      H2C_DISCONNECT_DETECT_LEN);
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
+
+	return ret;
+}
+
+#define H2C_WOW_GLOBAL_LEN 8
+int rtw89_fw_h2c_wow_global(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
+			    bool enable)
+{
+	struct sk_buff *skb;
+	u8 macid = rtwvif->mac_id;
+	int ret;
+
+	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, H2C_WOW_GLOBAL_LEN);
+	if (!skb) {
+		rtw89_err(rtwdev, "failed to alloc skb for keep alive\n");
+		return -ENOMEM;
+	}
+
+	skb_put(skb, H2C_WOW_GLOBAL_LEN);
+
+	RTW89_SET_WOW_GLOBAL_ENABLE(skb->data, enable);
+	RTW89_SET_WOW_GLOBAL_MAC_ID(skb->data, macid);
+
+	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
+			      H2C_CAT_MAC,
+			      H2C_CL_MAC_WOW,
+			      H2C_FUNC_WOW_GLOBAL, 0, 1,
+			      H2C_WOW_GLOBAL_LEN);
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
+
+	return ret;
+}
+
+#define H2C_WAKEUP_CTRL_LEN 4
+int rtw89_fw_h2c_wow_wakeup_ctrl(struct rtw89_dev *rtwdev,
+				 struct rtw89_vif *rtwvif,
+				 bool enable)
+{
+	struct rtw89_wow_param *rtw_wow = &rtwdev->wow;
+	struct sk_buff *skb;
+	u8 macid = rtwvif->mac_id;
+	int ret;
+
+	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, H2C_WAKEUP_CTRL_LEN);
+	if (!skb) {
+		rtw89_err(rtwdev, "failed to alloc skb for keep alive\n");
+		return -ENOMEM;
+	}
+
+	skb_put(skb, H2C_WAKEUP_CTRL_LEN);
+
+	if (rtw_wow->pattern_cnt)
+		RTW89_SET_WOW_WAKEUP_CTRL_PATTERN_MATCH_ENABLE(skb->data, enable);
+	if (test_bit(RTW89_WOW_FLAG_EN_MAGIC_PKT, rtw_wow->flags))
+		RTW89_SET_WOW_WAKEUP_CTRL_MAGIC_ENABLE(skb->data, enable);
+	if (test_bit(RTW89_WOW_FLAG_EN_DISCONNECT, rtw_wow->flags))
+		RTW89_SET_WOW_WAKEUP_CTRL_DEAUTH_ENABLE(skb->data, enable);
+
+	RTW89_SET_WOW_WAKEUP_CTRL_MAC_ID(skb->data, macid);
+
+	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
+			      H2C_CAT_MAC,
+			      H2C_CL_MAC_WOW,
+			      H2C_FUNC_WAKEUP_CTRL, 0, 1,
+			      H2C_WAKEUP_CTRL_LEN);
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
+
+	return ret;
+}
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 10a9ca4da0df0..d83009fc6a207 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -1881,6 +1881,146 @@ static inline void RTW89_SET_FWCMD_PKT_DROP_MACID_BAND_SEL_3(void *cmd, u32 val)
 	le32p_replace_bits((__le32 *)cmd + 5, val, GENMASK(31, 0));
 }
 
+static inline void RTW89_SET_KEEP_ALIVE_ENABLE(void *h2c, u32 val)
+{
+	le32p_replace_bits((__le32 *)h2c, val, GENMASK(1, 0));
+}
+
+static inline void RTW89_SET_KEEP_ALIVE_PKT_NULL_ID(void *h2c, u32 val)
+{
+	le32p_replace_bits((__le32 *)h2c, val, GENMASK(15, 8));
+}
+
+static inline void RTW89_SET_KEEP_ALIVE_PERIOD(void *h2c, u32 val)
+{
+	le32p_replace_bits((__le32 *)h2c, val, GENMASK(24, 16));
+}
+
+static inline void RTW89_SET_KEEP_ALIVE_MACID(void *h2c, u32 val)
+{
+	le32p_replace_bits((__le32 *)h2c, val, GENMASK(31, 24));
+}
+
+static inline void RTW89_SET_DISCONNECT_DETECT_ENABLE(void *h2c, u32 val)
+{
+	le32p_replace_bits((__le32 *)h2c, val, BIT(0));
+}
+
+static inline void RTW89_SET_DISCONNECT_DETECT_TRYOK_BCNFAIL_COUNT_EN(void *h2c, u32 val)
+{
+	le32p_replace_bits((__le32 *)h2c, val, BIT(1));
+}
+
+static inline void RTW89_SET_DISCONNECT_DETECT_DISCONNECT(void *h2c, u32 val)
+{
+	le32p_replace_bits((__le32 *)h2c, val, BIT(2));
+}
+
+static inline void RTW89_SET_DISCONNECT_DETECT_MAC_ID(void *h2c, u32 val)
+{
+	le32p_replace_bits((__le32 *)h2c, val, GENMASK(15, 8));
+}
+
+static inline void RTW89_SET_DISCONNECT_DETECT_CHECK_PERIOD(void *h2c, u32 val)
+{
+	le32p_replace_bits((__le32 *)h2c, val, GENMASK(23, 16));
+}
+
+static inline void RTW89_SET_DISCONNECT_DETECT_TRY_PKT_COUNT(void *h2c, u32 val)
+{
+	le32p_replace_bits((__le32 *)h2c, val, GENMASK(31, 24));
+}
+
+static inline void RTW89_SET_DISCONNECT_DETECT_TRYOK_BCNFAIL_COUNT_LIMIT(void *h2c, u32 val)
+{
+	le32p_replace_bits((__le32 *)(h2c) + 1, val, GENMASK(7, 0));
+}
+
+static inline void RTW89_SET_WOW_GLOBAL_ENABLE(void *h2c, u32 val)
+{
+	le32p_replace_bits((__le32 *)h2c, val, BIT(0));
+}
+
+static inline void RTW89_SET_WOW_GLOBAL_DROP_ALL_PKT(void *h2c, u32 val)
+{
+	le32p_replace_bits((__le32 *)h2c, val, BIT(1));
+}
+
+static inline void RTW89_SET_WOW_GLOBAL_RX_PARSE_AFTER_WAKE(void *h2c, u32 val)
+{
+	le32p_replace_bits((__le32 *)h2c, val, BIT(2));
+}
+
+static inline void RTW89_SET_WOW_GLOBAL_WAKE_BAR_PULLED(void *h2c, u32 val)
+{
+	le32p_replace_bits((__le32 *)h2c, val, BIT(3));
+}
+
+static inline void RTW89_SET_WOW_GLOBAL_MAC_ID(void *h2c, u32 val)
+{
+	le32p_replace_bits((__le32 *)h2c, val, GENMASK(15, 8));
+}
+
+static inline void RTW89_SET_WOW_GLOBAL_PAIRWISE_SEC_ALGO(void *h2c, u32 val)
+{
+	le32p_replace_bits((__le32 *)h2c, val, GENMASK(23, 16));
+}
+
+static inline void RTW89_SET_WOW_GLOBAL_GROUP_SEC_ALGO(void *h2c, u32 val)
+{
+	le32p_replace_bits((__le32 *)h2c, val, GENMASK(31, 24));
+}
+
+static inline void RTW89_SET_WOW_GLOBAL_REMOTECTRL_INFO_CONTENT(void *h2c, u32 val)
+{
+	le32p_replace_bits((__le32 *)(h2c) + 1, val, GENMASK(31, 0));
+}
+
+static inline void RTW89_SET_WOW_WAKEUP_CTRL_PATTERN_MATCH_ENABLE(void *h2c, u32 val)
+{
+	le32p_replace_bits((__le32 *)h2c, val, BIT(0));
+}
+
+static inline void RTW89_SET_WOW_WAKEUP_CTRL_MAGIC_ENABLE(void *h2c, u32 val)
+{
+	le32p_replace_bits((__le32 *)h2c, val, BIT(1));
+}
+
+static inline void RTW89_SET_WOW_WAKEUP_CTRL_HW_UNICAST_ENABLE(void *h2c, u32 val)
+{
+	le32p_replace_bits((__le32 *)h2c, val, BIT(2));
+}
+
+static inline void RTW89_SET_WOW_WAKEUP_CTRL_FW_UNICAST_ENABLE(void *h2c, u32 val)
+{
+	le32p_replace_bits((__le32 *)h2c, val, BIT(3));
+}
+
+static inline void RTW89_SET_WOW_WAKEUP_CTRL_DEAUTH_ENABLE(void *h2c, u32 val)
+{
+	le32p_replace_bits((__le32 *)h2c, val, BIT(4));
+}
+
+static inline void RTW89_SET_WOW_WAKEUP_CTRL_REKEYP_ENABLE(void *h2c, u32 val)
+{
+	le32p_replace_bits((__le32 *)h2c, val, BIT(5));
+}
+
+static inline void RTW89_SET_WOW_WAKEUP_CTRL_EAP_ENABLE(void *h2c, u32 val)
+{
+	le32p_replace_bits((__le32 *)h2c, val, BIT(6));
+}
+
+static inline void RTW89_SET_WOW_WAKEUP_CTRL_ALL_DATA_ENABLE(void *h2c, u32 val)
+{
+	le32p_replace_bits((__le32 *)h2c, val, BIT(7));
+}
+
+static inline void RTW89_SET_WOW_WAKEUP_CTRL_MAC_ID(void *h2c, u32 val)
+{
+	le32p_replace_bits((__le32 *)h2c, val, GENMASK(31, 24));
+}
+
 enum rtw89_btc_btf_h2c_class {
 	BTFC_SET = 0x10,
 	BTFC_GET = 0x11,
@@ -2697,6 +2837,14 @@ struct rtw89_fw_h2c_rf_reg_info {
 #define H2C_FUNC_LOG_CFG		0x0
 #define H2C_FUNC_MAC_GENERAL_PKT	0x1
 
+/* CLASS 1 - WOW */
+#define H2C_CL_MAC_WOW			0x1
+#define H2C_FUNC_KEEP_ALIVE		0x0
+#define H2C_FUNC_DISCONNECT_DETECT	0x1
+#define H2C_FUNC_WOW_GLOBAL		0x2
+#define H2C_FUNC_WAKEUP_CTRL		0x8
+#define H2C_FUNC_WOW_CAM_UPD		0xC
+
 /* CLASS 2 - PS */
 #define H2C_CL_MAC_PS			0x2
 #define H2C_FUNC_MAC_LPS_PARM		0x0
@@ -2866,6 +3014,18 @@ int rtw89_fw_h2c_p2p_act(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif,
 			 u8 act, u8 noa_id);
 int rtw89_fw_h2c_tsf32_toggle(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
 			      bool en);
+int rtw89_fw_h2c_wow_global(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
+			    bool enable);
+int rtw89_fw_h2c_wow_wakeup_ctrl(struct rtw89_dev *rtwdev,
+				 struct rtw89_vif *rtwvif, bool enable);
+int rtw89_fw_h2c_keep_alive(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
+			    bool enable);
+int rtw89_fw_h2c_disconnect_detect(struct rtw89_dev *rtwdev,
+				   struct rtw89_vif *rtwvif, bool enable);
+int rtw89_fw_h2c_wow_global(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
+			    bool enable);
+int rtw89_fw_h2c_wow_wakeup_ctrl(struct rtw89_dev *rtwdev,
+				 struct rtw89_vif *rtwvif, bool enable);
 
 static inline void rtw89_fw_h2c_init_ba_cam(struct rtw89_dev *rtwdev)
 {
-- 
2.25.1

