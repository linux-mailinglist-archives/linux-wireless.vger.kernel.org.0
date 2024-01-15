Return-Path: <linux-wireless+bounces-1912-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2DB982D36B
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jan 2024 04:38:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04D0DB20CBB
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jan 2024 03:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32A924695;
	Mon, 15 Jan 2024 03:38:47 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B6C469D
	for <linux-wireless@vger.kernel.org>; Mon, 15 Jan 2024 03:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 40F3cZpZ53528850, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 40F3cZpZ53528850
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Jan 2024 11:38:35 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.17; Mon, 15 Jan 2024 11:38:35 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 15 Jan
 2024 11:38:34 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH 7/8] wifi: rtw89: fw: use struct to fill JOIN H2C command
Date: Mon, 15 Jan 2024 11:37:41 +0800
Message-ID: <20240115033742.16372-8-pkshih@realtek.com>
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

The JOIN command is used to tell firmware an new station is joining, and
create an entry for it. This patch is only to convert to set data via
struct, and don't change logic at all.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c | 37 ++++++------
 drivers/net/wireless/realtek/rtw89/fw.h | 79 +++++--------------------
 2 files changed, 36 insertions(+), 80 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 255be99b3630..03825fe1d9c2 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -2904,7 +2904,6 @@ int rtw89_fw_h2c_role_maintain(struct rtw89_dev *rtwdev,
 	return ret;
 }
 
-#define H2C_JOIN_INFO_LEN 4
 int rtw89_fw_h2c_join_info(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
 			   struct rtw89_sta *rtwsta, bool dis_conn)
 {
@@ -2912,6 +2911,8 @@ int rtw89_fw_h2c_join_info(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
 	u8 mac_id = rtwsta ? rtwsta->mac_id : rtwvif->mac_id;
 	u8 self_role = rtwvif->self_role;
 	u8 net_type = rtwvif->net_type;
+	struct rtw89_h2c_join *h2c;
+	u32 len = sizeof(*h2c);
 	int ret;
 
 	if (net_type == RTW89_NET_TYPE_AP_MODE && rtwsta) {
@@ -2919,30 +2920,32 @@ int rtw89_fw_h2c_join_info(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
 		net_type = dis_conn ? RTW89_NET_TYPE_NO_LINK : net_type;
 	}
 
-	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, H2C_JOIN_INFO_LEN);
+	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, len);
 	if (!skb) {
 		rtw89_err(rtwdev, "failed to alloc skb for h2c join\n");
 		return -ENOMEM;
 	}
-	skb_put(skb, H2C_JOIN_INFO_LEN);
-	SET_JOININFO_MACID(skb->data, mac_id);
-	SET_JOININFO_OP(skb->data, dis_conn);
-	SET_JOININFO_BAND(skb->data, rtwvif->mac_idx);
-	SET_JOININFO_WMM(skb->data, rtwvif->wmm);
-	SET_JOININFO_TGR(skb->data, rtwvif->trigger);
-	SET_JOININFO_ISHESTA(skb->data, 0);
-	SET_JOININFO_DLBW(skb->data, 0);
-	SET_JOININFO_TF_MAC_PAD(skb->data, 0);
-	SET_JOININFO_DL_T_PE(skb->data, 0);
-	SET_JOININFO_PORT_ID(skb->data, rtwvif->port);
-	SET_JOININFO_NET_TYPE(skb->data, net_type);
-	SET_JOININFO_WIFI_ROLE(skb->data, rtwvif->wifi_role);
-	SET_JOININFO_SELF_ROLE(skb->data, self_role);
+	skb_put(skb, len);
+	h2c = (struct rtw89_h2c_join *)skb->data;
+
+	h2c->w0 = le32_encode_bits(mac_id, RTW89_H2C_JOININFO_W0_MACID) |
+		  le32_encode_bits(dis_conn, RTW89_H2C_JOININFO_W0_OP) |
+		  le32_encode_bits(rtwvif->mac_idx, RTW89_H2C_JOININFO_W0_BAND) |
+		  le32_encode_bits(rtwvif->wmm, RTW89_H2C_JOININFO_W0_WMM) |
+		  le32_encode_bits(rtwvif->trigger, RTW89_H2C_JOININFO_W0_TGR) |
+		  le32_encode_bits(0, RTW89_H2C_JOININFO_W0_ISHESTA) |
+		  le32_encode_bits(0, RTW89_H2C_JOININFO_W0_DLBW) |
+		  le32_encode_bits(0, RTW89_H2C_JOININFO_W0_TF_MAC_PAD) |
+		  le32_encode_bits(0, RTW89_H2C_JOININFO_W0_DL_T_PE) |
+		  le32_encode_bits(rtwvif->port, RTW89_H2C_JOININFO_W0_PORT_ID) |
+		  le32_encode_bits(net_type, RTW89_H2C_JOININFO_W0_NET_TYPE) |
+		  le32_encode_bits(rtwvif->wifi_role, RTW89_H2C_JOININFO_W0_WIFI_ROLE) |
+		  le32_encode_bits(self_role, RTW89_H2C_JOININFO_W0_SELF_ROLE);
 
 	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
 			      H2C_CAT_MAC, H2C_CL_MAC_MEDIA_RPT,
 			      H2C_FUNC_MAC_JOININFO, 0, 1,
-			      H2C_JOIN_INFO_LEN);
+			      len);
 
 	ret = rtw89_h2c_tx(rtwdev, skb, false);
 	if (ret) {
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index b5f724087954..036fe4f983e6 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -1747,70 +1747,23 @@ static inline void SET_FWROLE_MAINTAIN_WIFI_ROLE(void *h2c, u32 val)
 	le32p_replace_bits((__le32 *)h2c, val, GENMASK(16, 13));
 }
 
-static inline void SET_JOININFO_MACID(void *h2c, u32 val)
-{
-	le32p_replace_bits((__le32 *)h2c, val, GENMASK(7, 0));
-}
-
-static inline void SET_JOININFO_OP(void *h2c, u32 val)
-{
-	le32p_replace_bits((__le32 *)h2c, val, BIT(8));
-}
-
-static inline void SET_JOININFO_BAND(void *h2c, u32 val)
-{
-	le32p_replace_bits((__le32 *)h2c, val, BIT(9));
-}
-
-static inline void SET_JOININFO_WMM(void *h2c, u32 val)
-{
-	le32p_replace_bits((__le32 *)h2c, val, GENMASK(11, 10));
-}
-
-static inline void SET_JOININFO_TGR(void *h2c, u32 val)
-{
-	le32p_replace_bits((__le32 *)h2c, val, BIT(12));
-}
-
-static inline void SET_JOININFO_ISHESTA(void *h2c, u32 val)
-{
-	le32p_replace_bits((__le32 *)h2c, val, BIT(13));
-}
-
-static inline void SET_JOININFO_DLBW(void *h2c, u32 val)
-{
-	le32p_replace_bits((__le32 *)h2c, val, GENMASK(15, 14));
-}
-
-static inline void SET_JOININFO_TF_MAC_PAD(void *h2c, u32 val)
-{
-	le32p_replace_bits((__le32 *)h2c, val, GENMASK(17, 16));
-}
-
-static inline void SET_JOININFO_DL_T_PE(void *h2c, u32 val)
-{
-	le32p_replace_bits((__le32 *)h2c, val, GENMASK(20, 18));
-}
-
-static inline void SET_JOININFO_PORT_ID(void *h2c, u32 val)
-{
-	le32p_replace_bits((__le32 *)h2c, val, GENMASK(23, 21));
-}
-
-static inline void SET_JOININFO_NET_TYPE(void *h2c, u32 val)
-{
-	le32p_replace_bits((__le32 *)h2c, val, GENMASK(25, 24));
-}
-
-static inline void SET_JOININFO_WIFI_ROLE(void *h2c, u32 val)
-{
-	le32p_replace_bits((__le32 *)h2c, val, GENMASK(29, 26));
-}
+struct rtw89_h2c_join {
+	__le32 w0;
+} __packed;
 
-static inline void SET_JOININFO_SELF_ROLE(void *h2c, u32 val)
-{
-	le32p_replace_bits((__le32 *)h2c, val, GENMASK(31, 30));
-}
+#define RTW89_H2C_JOININFO_W0_MACID GENMASK(7, 0)
+#define RTW89_H2C_JOININFO_W0_OP BIT(8)
+#define RTW89_H2C_JOININFO_W0_BAND BIT(9)
+#define RTW89_H2C_JOININFO_W0_WMM GENMASK(11, 10)
+#define RTW89_H2C_JOININFO_W0_TGR BIT(12)
+#define RTW89_H2C_JOININFO_W0_ISHESTA BIT(13)
+#define RTW89_H2C_JOININFO_W0_DLBW GENMASK(15, 14)
+#define RTW89_H2C_JOININFO_W0_TF_MAC_PAD GENMASK(17, 16)
+#define RTW89_H2C_JOININFO_W0_DL_T_PE GENMASK(20, 18)
+#define RTW89_H2C_JOININFO_W0_PORT_ID GENMASK(23, 21)
+#define RTW89_H2C_JOININFO_W0_NET_TYPE GENMASK(25, 24)
+#define RTW89_H2C_JOININFO_W0_WIFI_ROLE GENMASK(29, 26)
+#define RTW89_H2C_JOININFO_W0_SELF_ROLE GENMASK(31, 30)
 
 struct rtw89_h2c_notify_dbcc {
 	__le32 w0;
-- 
2.25.1


