Return-Path: <linux-wireless+bounces-7094-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50BA78B936C
	for <lists+linux-wireless@lfdr.de>; Thu,  2 May 2024 04:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74A9E1C2207B
	for <lists+linux-wireless@lfdr.de>; Thu,  2 May 2024 02:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A65179BD;
	Thu,  2 May 2024 02:25:54 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5AC617997
	for <linux-wireless@vger.kernel.org>; Thu,  2 May 2024 02:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714616754; cv=none; b=E1lMO+Lt7O587j1WbHEo6V1SoG5ZnGCIX18OQDwhpnUUEDqY3sUZFgUw2bcxWW5QLJYu+bDasooh9JIXbi4gv+Q0bR5SIXZ/GcATBVcfkC0ZDMphMXgFgmrvbbRXbyHzxbcvqLUUpA0Np1iqsytSdyXsQvsGCKI6EX2H8vWJZ8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714616754; c=relaxed/simple;
	bh=4w+BJ/Xlv9tIEKEBakYGdU4bvmvNHIH9miT5M36Jbuc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rv12fnL+9+rv0aKM70MCX3iF9uDP2AsFceYG0pfrYhd3RmI+YZTsZubOH19r/pFp653e2yLbhS7gN5vX0/TYVnOpyIqdcVmqw3J/cj4pPTX1uJclu15X+kzoTR/dU9PVPzM19MHOMtCbQVgHtDW968/lZpAZyf4f0EsR4j/eHWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4422Pot262026685, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4422Pot262026685
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 2 May 2024 10:25:50 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 2 May 2024 10:25:51 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 2 May
 2024 10:25:50 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <timlee@realtek.com>
Subject: [PATCH v2 07/12] wifi: rtw89: wow: construct EAPoL packet for GTK rekey offload
Date: Thu, 2 May 2024 10:25:00 +0800
Message-ID: <20240502022505.28966-8-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240502022505.28966-1-pkshih@realtek.com>
References: <20240502022505.28966-1-pkshih@realtek.com>
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

From: Chih-Kang Chang <gary.chang@realtek.com>

We construct EAPoL packet with various encryption method, and download
to firmware. Also we add Key Encryption Key (KEK) and Key Confirmation Key
(KCK) to H2C command. Once firmware received EAPoL group rekey packet(1/2)
can TX EAPoL group rekey packet(2/2) when suspend.

Signed-off-by: Chih-Kang Chang <gary.chang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c     |   3 +-
 drivers/net/wireless/realtek/rtw89/core.h     |  13 ++
 drivers/net/wireless/realtek/rtw89/fw.c       | 113 ++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/fw.h       |  21 ++++
 drivers/net/wireless/realtek/rtw89/mac80211.c |  23 ++++
 5 files changed, 172 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index e0bb0028a0d4..ddc390d24ec1 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -4511,7 +4511,8 @@ static int rtw89_core_register_hw(struct rtw89_dev *rtwdev)
 
 	hw->wiphy->flags |= WIPHY_FLAG_SUPPORTS_TDLS |
 			    WIPHY_FLAG_TDLS_EXTERNAL_SETUP |
-			    WIPHY_FLAG_AP_UAPSD;
+			    WIPHY_FLAG_AP_UAPSD |
+			    WIPHY_FLAG_SUPPORTS_EXT_KEK_KCK;
 
 	if (!chip->support_rnr)
 		hw->wiphy->flags |= WIPHY_FLAG_SPLIT_SCAN_6GHZ;
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 6b456f214fed..f4b439ec30fd 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -5166,11 +5166,24 @@ struct rtw89_wow_key_info {
 	u8 gtk_rx_iv[4][8];
 } __packed;
 
+struct rtw89_wow_gtk_info {
+	u8 kck[32];
+	u8 kek[32];
+	u8 tk1[16];
+	u8 txmickey[8];
+	u8 rxmickey[8];
+	__le32 igtk_keyid;
+	__le64 ipn;
+	u8 igtk[2][32];
+	u8 psk[32];
+} __packed;
+
 struct rtw89_wow_param {
 	struct ieee80211_vif *wow_vif;
 	DECLARE_BITMAP(flags, RTW89_WOW_FLAG_NUM);
 	struct rtw89_wow_cam_info patterns[RTW89_MAX_PATTERN_NUM];
 	struct rtw89_wow_key_info key_info;
+	struct rtw89_wow_gtk_info gtk_info;
 	u8 pattern_cnt;
 	u8 ptk_alg;
 	u8 gtk_alg;
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 059c92ecfc7c..a7ae5f85d57d 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -13,6 +13,13 @@
 #include "reg.h"
 #include "util.h"
 
+struct rtw89_eapol_2_of_2 {
+	struct ieee80211_hdr_3addr hdr;
+	u8 gtkbody[14];
+	u8 key_des_ver;
+	u8 rsvd[92];
+} __packed __aligned(2);
+
 static const u8 mss_signature[] = {0x4D, 0x53, 0x53, 0x4B, 0x50, 0x4F, 0x4F, 0x4C};
 
 union rtw89_fw_element_arg {
@@ -2147,6 +2154,44 @@ int rtw89_fw_h2c_fw_log(struct rtw89_dev *rtwdev, bool enable)
 	return ret;
 }
 
+static struct sk_buff *rtw89_eapol_get(struct rtw89_dev *rtwdev,
+				       struct rtw89_vif *rtwvif)
+{
+	static const u8 gtkbody[] = {0xAA, 0xAA, 0x03, 0x00, 0x00, 0x00, 0x88,
+				     0x8E, 0x01, 0x03, 0x00, 0x5F, 0x02, 0x03};
+	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif);
+	struct ieee80211_bss_conf *bss_conf = &vif->bss_conf;
+	struct rtw89_wow_param *rtw_wow = &rtwdev->wow;
+	struct rtw89_eapol_2_of_2 *eapol_pkt;
+	struct sk_buff *skb;
+	u8 key_des_ver;
+
+	if (rtw_wow->ptk_alg == 3)
+		key_des_ver = 1;
+	else if (rtw_wow->akm == 1 || rtw_wow->akm == 2)
+		key_des_ver = 2;
+	else if (rtw_wow->akm > 2 && rtw_wow->akm < 7)
+		key_des_ver = 3;
+	else
+		key_des_ver = 0;
+
+	skb = dev_alloc_skb(sizeof(*eapol_pkt));
+	if (!skb)
+		return NULL;
+
+	eapol_pkt = skb_put_zero(skb, sizeof(*eapol_pkt));
+	eapol_pkt->hdr.frame_control = cpu_to_le16(IEEE80211_FTYPE_DATA |
+						   IEEE80211_FCTL_TODS |
+						   IEEE80211_FCTL_PROTECTED);
+	ether_addr_copy(eapol_pkt->hdr.addr1, bss_conf->bssid);
+	ether_addr_copy(eapol_pkt->hdr.addr2, vif->addr);
+	ether_addr_copy(eapol_pkt->hdr.addr3, bss_conf->bssid);
+	memcpy(eapol_pkt->gtkbody, gtkbody, sizeof(gtkbody));
+	eapol_pkt->key_des_ver = key_des_ver;
+
+	return skb;
+}
+
 static int rtw89_fw_h2c_add_general_pkt(struct rtw89_dev *rtwdev,
 					struct rtw89_vif *rtwvif,
 					enum rtw89_fw_pkt_ofld_type type,
@@ -2174,6 +2219,9 @@ static int rtw89_fw_h2c_add_general_pkt(struct rtw89_dev *rtwdev,
 	case RTW89_PKT_OFLD_TYPE_QOS_NULL:
 		skb = ieee80211_nullfunc_get(rtwdev->hw, vif, -1, true);
 		break;
+	case RTW89_PKT_OFLD_TYPE_EAPOL_KEY:
+		skb = rtw89_eapol_get(rtwdev, rtwvif);
+		break;
 	default:
 		goto err;
 	}
@@ -6493,6 +6541,71 @@ int rtw89_fw_wow_cam_update(struct rtw89_dev *rtwdev,
 	return ret;
 }
 
+int rtw89_fw_h2c_wow_gtk_ofld(struct rtw89_dev *rtwdev,
+			      struct rtw89_vif *rtwvif,
+			      bool enable)
+{
+	struct rtw89_wow_param *rtw_wow = &rtwdev->wow;
+	struct rtw89_wow_gtk_info *gtk_info = &rtw_wow->gtk_info;
+	struct rtw89_h2c_wow_gtk_ofld *h2c;
+	u8 macid = rtwvif->mac_id;
+	u32 len = sizeof(*h2c);
+	struct sk_buff *skb;
+	u8 pkt_id_eapol = 0;
+	int ret;
+
+	if (!rtw_wow->gtk_alg)
+		return 0;
+
+	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, len);
+	if (!skb) {
+		rtw89_err(rtwdev, "failed to alloc skb for gtk ofld\n");
+		return -ENOMEM;
+	}
+
+	skb_put(skb, len);
+	h2c = (struct rtw89_h2c_wow_gtk_ofld *)skb->data;
+
+	if (!enable) {
+		skb_put_zero(skb, sizeof(*gtk_info));
+		goto hdr;
+	}
+
+	ret = rtw89_fw_h2c_add_general_pkt(rtwdev, rtwvif,
+					   RTW89_PKT_OFLD_TYPE_EAPOL_KEY,
+					   &pkt_id_eapol);
+	if (ret)
+		goto fail;
+
+	/* not support TKIP and IEEE80211W yet */
+	h2c->w0 = le32_encode_bits(enable, RTW89_H2C_WOW_GTK_OFLD_W0_EN) |
+		  le32_encode_bits(0, RTW89_H2C_WOW_GTK_OFLD_W0_TKIP_EN) |
+		  le32_encode_bits(0, RTW89_H2C_WOW_GTK_OFLD_W0_IEEE80211W_EN) |
+		  le32_encode_bits(macid, RTW89_H2C_WOW_GTK_OFLD_W0_MAC_ID) |
+		  le32_encode_bits(pkt_id_eapol, RTW89_H2C_WOW_GTK_OFLD_W0_GTK_RSP_ID);
+	h2c->w1 = le32_encode_bits(rtw_wow->akm, RTW89_H2C_WOW_GTK_OFLD_W1_ALGO_AKM_SUIT);
+	h2c->gtk_info = rtw_wow->gtk_info;
+
+hdr:
+	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
+			      H2C_CAT_MAC,
+			      H2C_CL_MAC_WOW,
+			      H2C_FUNC_GTK_OFLD, 0, 1,
+			      len);
+
+	ret = rtw89_h2c_tx(rtwdev, skb, false);
+	if (ret) {
+		rtw89_err(rtwdev, "failed to send h2c\n");
+		goto fail;
+	}
+	return 0;
+
+fail:
+	dev_kfree_skb_any(skb);
+
+	return ret;
+}
+
 /* Return < 0, if failures happen during waiting for the condition.
  * Return 0, when waiting for the condition succeeds.
  * Return > 0, if the wait is considered unreachable due to driver/FW design,
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index ce6bf8c3ec96..03cad18f2dac 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -1979,6 +1979,23 @@ static inline void RTW89_SET_WOW_CAM_UPD_VALID(void *h2c, u32 val)
 	le32p_replace_bits((__le32 *)h2c + 5, val, BIT(31));
 }
 
+struct rtw89_h2c_wow_gtk_ofld {
+	__le32 w0;
+	__le32 w1;
+	struct rtw89_wow_gtk_info gtk_info;
+} __packed;
+
+#define RTW89_H2C_WOW_GTK_OFLD_W0_EN BIT(0)
+#define RTW89_H2C_WOW_GTK_OFLD_W0_TKIP_EN BIT(1)
+#define RTW89_H2C_WOW_GTK_OFLD_W0_IEEE80211W_EN BIT(2)
+#define RTW89_H2C_WOW_GTK_OFLD_W0_PAIRWISE_WAKEUP BIT(3)
+#define RTW89_H2C_WOW_GTK_OFLD_W0_NOREKEY_WAKEUP BIT(4)
+#define RTW89_H2C_WOW_GTK_OFLD_W0_MAC_ID GENMASK(23, 16)
+#define RTW89_H2C_WOW_GTK_OFLD_W0_GTK_RSP_ID GENMASK(31, 24)
+#define RTW89_H2C_WOW_GTK_OFLD_W1_PMF_SA_QUERY_ID GENMASK(7, 0)
+#define RTW89_H2C_WOW_GTK_OFLD_W1_PMF_BIP_SEC_ALGO GENMASK(9, 8)
+#define RTW89_H2C_WOW_GTK_OFLD_W1_ALGO_AKM_SUIT GENMASK(17, 10)
+
 enum rtw89_btc_btf_h2c_class {
 	BTFC_SET = 0x10,
 	BTFC_GET = 0x11,
@@ -3843,6 +3860,7 @@ struct rtw89_fw_h2c_rf_reg_info {
 #define H2C_FUNC_KEEP_ALIVE		0x0
 #define H2C_FUNC_DISCONNECT_DETECT	0x1
 #define H2C_FUNC_WOW_GLOBAL		0x2
+#define H2C_FUNC_GTK_OFLD		0x3
 #define H2C_FUNC_WAKEUP_CTRL		0x8
 #define H2C_FUNC_WOW_CAM_UPD		0xC
 
@@ -4361,6 +4379,9 @@ int rtw89_fw_h2c_wow_wakeup_ctrl(struct rtw89_dev *rtwdev,
 				 struct rtw89_vif *rtwvif, bool enable);
 int rtw89_fw_wow_cam_update(struct rtw89_dev *rtwdev,
 			    struct rtw89_wow_cam_info *cam_info);
+int rtw89_fw_h2c_wow_gtk_ofld(struct rtw89_dev *rtwdev,
+			      struct rtw89_vif *rtwvif,
+			      bool enable);
 int rtw89_fw_h2c_add_mcc(struct rtw89_dev *rtwdev,
 			 const struct rtw89_fw_mcc_add_req *p);
 int rtw89_fw_h2c_start_mcc(struct rtw89_dev *rtwdev,
diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index 31d1ffb16e83..2fd23f79544d 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -1106,6 +1106,28 @@ static void rtw89_ops_set_wakeup(struct ieee80211_hw *hw, bool enabled)
 
 	device_set_wakeup_enable(rtwdev->dev, enabled);
 }
+
+static void rtw89_set_rekey_data(struct ieee80211_hw *hw,
+				 struct ieee80211_vif *vif,
+				 struct cfg80211_gtk_rekey_data *data)
+{
+	struct rtw89_dev *rtwdev = hw->priv;
+	struct rtw89_wow_param *rtw_wow = &rtwdev->wow;
+	struct rtw89_wow_gtk_info *gtk_info = &rtw_wow->gtk_info;
+
+	if (data->kek_len > sizeof(gtk_info->kek) ||
+	    data->kck_len > sizeof(gtk_info->kck)) {
+		rtw89_warn(rtwdev, "kek or kck length over fw limit\n");
+		return;
+	}
+
+	mutex_lock(&rtwdev->mutex);
+
+	memcpy(gtk_info->kek, data->kek, data->kek_len);
+	memcpy(gtk_info->kck, data->kck, data->kck_len);
+
+	mutex_unlock(&rtwdev->mutex);
+}
 #endif
 
 const struct ieee80211_ops rtw89_ops = {
@@ -1151,6 +1173,7 @@ const struct ieee80211_ops rtw89_ops = {
 	.suspend		= rtw89_ops_suspend,
 	.resume			= rtw89_ops_resume,
 	.set_wakeup		= rtw89_ops_set_wakeup,
+	.set_rekey_data		= rtw89_set_rekey_data,
 #endif
 };
 EXPORT_SYMBOL(rtw89_ops);
-- 
2.25.1


