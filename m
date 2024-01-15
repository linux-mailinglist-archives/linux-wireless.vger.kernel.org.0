Return-Path: <linux-wireless+bounces-1913-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9912382D36C
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jan 2024 04:38:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 997A51C20893
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jan 2024 03:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5508D5232;
	Mon, 15 Jan 2024 03:38:48 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D674694
	for <linux-wireless@vger.kernel.org>; Mon, 15 Jan 2024 03:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 40F3ceKD33528856, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 40F3ceKD33528856
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Jan 2024 11:38:40 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.32; Mon, 15 Jan 2024 11:38:40 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 15 Jan
 2024 11:38:39 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH 8/8] wifi: rtw89: fw: extend JOIN H2C command to support WiFi 7 chips
Date: Mon, 15 Jan 2024 11:37:42 +0800
Message-ID: <20240115033742.16372-9-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240115033742.16372-1-pkshih@realtek.com>
References: <20240115033742.16372-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

WiFi 7 chips will support MLD, so there are more fields about that. But
currently we don't support MLD yet, just define fields and bits by this
patch ahead, and fill STA_TYPE only.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c | 45 +++++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/fw.h | 23 +++++++++++++
 2 files changed, 68 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 03825fe1d9c2..362ea2e228d2 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -2904,17 +2904,51 @@ int rtw89_fw_h2c_role_maintain(struct rtw89_dev *rtwdev,
 	return ret;
 }
 
+static enum rtw89_fw_sta_type
+rtw89_fw_get_sta_type(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
+		      struct rtw89_sta *rtwsta)
+{
+	struct ieee80211_sta *sta = rtwsta_to_sta_safe(rtwsta);
+	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif);
+
+	if (!sta)
+		goto by_vif;
+
+	if (sta->deflink.eht_cap.has_eht)
+		return RTW89_FW_BE_STA;
+	else if (sta->deflink.he_cap.has_he)
+		return RTW89_FW_AX_STA;
+	else
+		return RTW89_FW_N_AC_STA;
+
+by_vif:
+	if (vif->bss_conf.eht_support)
+		return RTW89_FW_BE_STA;
+	else if (vif->bss_conf.he_support)
+		return RTW89_FW_AX_STA;
+	else
+		return RTW89_FW_N_AC_STA;
+}
+
 int rtw89_fw_h2c_join_info(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
 			   struct rtw89_sta *rtwsta, bool dis_conn)
 {
 	struct sk_buff *skb;
 	u8 mac_id = rtwsta ? rtwsta->mac_id : rtwvif->mac_id;
 	u8 self_role = rtwvif->self_role;
+	enum rtw89_fw_sta_type sta_type;
 	u8 net_type = rtwvif->net_type;
+	struct rtw89_h2c_join_v1 *h2c_v1;
 	struct rtw89_h2c_join *h2c;
 	u32 len = sizeof(*h2c);
+	bool format_v1 = false;
 	int ret;
 
+	if (rtwdev->chip->chip_gen == RTW89_CHIP_BE) {
+		len = sizeof(*h2c_v1);
+		format_v1 = true;
+	}
+
 	if (net_type == RTW89_NET_TYPE_AP_MODE && rtwsta) {
 		self_role = RTW89_SELF_ROLE_AP_CLIENT;
 		net_type = dis_conn ? RTW89_NET_TYPE_NO_LINK : net_type;
@@ -2942,6 +2976,17 @@ int rtw89_fw_h2c_join_info(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
 		  le32_encode_bits(rtwvif->wifi_role, RTW89_H2C_JOININFO_W0_WIFI_ROLE) |
 		  le32_encode_bits(self_role, RTW89_H2C_JOININFO_W0_SELF_ROLE);
 
+	if (!format_v1)
+		goto done;
+
+	h2c_v1 = (struct rtw89_h2c_join_v1 *)skb->data;
+
+	sta_type = rtw89_fw_get_sta_type(rtwdev, rtwvif, rtwsta);
+
+	h2c_v1->w1 = le32_encode_bits(sta_type, RTW89_H2C_JOININFO_W1_STA_TYPE);
+	h2c_v1->w2 = 0;
+
+done:
 	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
 			      H2C_CAT_MAC, H2C_CL_MAC_MEDIA_RPT,
 			      H2C_FUNC_MAC_JOININFO, 0, 1,
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 036fe4f983e6..7a80f45ce27b 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -1747,10 +1747,22 @@ static inline void SET_FWROLE_MAINTAIN_WIFI_ROLE(void *h2c, u32 val)
 	le32p_replace_bits((__le32 *)h2c, val, GENMASK(16, 13));
 }
 
+enum rtw89_fw_sta_type { /* value of RTW89_H2C_JOININFO_W1_STA_TYPE */
+	RTW89_FW_N_AC_STA = 0,
+	RTW89_FW_AX_STA = 1,
+	RTW89_FW_BE_STA = 2,
+};
+
 struct rtw89_h2c_join {
 	__le32 w0;
 } __packed;
 
+struct rtw89_h2c_join_v1 {
+	__le32 w0;
+	__le32 w1;
+	__le32 w2;
+} __packed;
+
 #define RTW89_H2C_JOININFO_W0_MACID GENMASK(7, 0)
 #define RTW89_H2C_JOININFO_W0_OP BIT(8)
 #define RTW89_H2C_JOININFO_W0_BAND BIT(9)
@@ -1764,6 +1776,17 @@ struct rtw89_h2c_join {
 #define RTW89_H2C_JOININFO_W0_NET_TYPE GENMASK(25, 24)
 #define RTW89_H2C_JOININFO_W0_WIFI_ROLE GENMASK(29, 26)
 #define RTW89_H2C_JOININFO_W0_SELF_ROLE GENMASK(31, 30)
+#define RTW89_H2C_JOININFO_W1_STA_TYPE GENMASK(2, 0)
+#define RTW89_H2C_JOININFO_W1_IS_MLD BIT(3)
+#define RTW89_H2C_JOININFO_W1_MAIN_MACID GENMASK(11, 4)
+#define RTW89_H2C_JOININFO_W1_MLO_MODE BIT(12)
+#define RTW89_H2C_JOININFO_W1_EMLSR_CAB BIT(13)
+#define RTW89_H2C_JOININFO_W1_NSTR_EN BIT(14)
+#define RTW89_H2C_JOININFO_W1_INIT_PWR_STATE BIT(15)
+#define RTW89_H2C_JOININFO_W1_EMLSR_PADDING GENMASK(18, 16)
+#define RTW89_H2C_JOININFO_W1_EMLSR_TRANS_DELAY GENMASK(21, 19)
+#define RTW89_H2C_JOININFO_W2_MACID_EXT GENMASK(7, 0)
+#define RTW89_H2C_JOININFO_W2_MAIN_MACID_EXT GENMASK(15, 8)
 
 struct rtw89_h2c_notify_dbcc {
 	__le32 w0;
-- 
2.25.1


