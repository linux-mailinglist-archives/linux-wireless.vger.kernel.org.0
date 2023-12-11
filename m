Return-Path: <linux-wireless+bounces-637-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C598980C358
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Dec 2023 09:35:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE2D2B20B45
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Dec 2023 08:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD3521105;
	Mon, 11 Dec 2023 08:35:09 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18DECC4
	for <linux-wireless@vger.kernel.org>; Mon, 11 Dec 2023 00:35:05 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3BB8Z0Ku82598528, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3BB8Z0Ku82598528
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Dec 2023 16:35:00 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Mon, 11 Dec 2023 16:35:00 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Mon, 11 Dec
 2023 16:34:59 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH 5/6] wifi: rtw89: add DBCC H2C to notify firmware the status
Date: Mon, 11 Dec 2023 16:33:40 +0800
Message-ID: <20231211083341.118047-6-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231211083341.118047-1-pkshih@realtek.com>
References: <20231211083341.118047-1-pkshih@realtek.com>
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
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

To support MLO of WiFi 7, we should configure hardware as DBCC mode, and
notify this status to firmware.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c | 35 +++++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/fw.h |  8 ++++++
 2 files changed, 43 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 81034b6ce4b0..f3555e0ed63b 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -2224,6 +2224,41 @@ int rtw89_fw_h2c_join_info(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
 	return ret;
 }
 
+int rtw89_fw_h2c_notify_dbcc(struct rtw89_dev *rtwdev, bool en)
+{
+	struct rtw89_h2c_notify_dbcc *h2c;
+	u32 len = sizeof(*h2c);
+	struct sk_buff *skb;
+	int ret;
+
+	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, len);
+	if (!skb) {
+		rtw89_err(rtwdev, "failed to alloc skb for h2c notify dbcc\n");
+		return -ENOMEM;
+	}
+	skb_put(skb, len);
+	h2c = (struct rtw89_h2c_notify_dbcc *)skb->data;
+
+	h2c->w0 = le32_encode_bits(en, RTW89_H2C_NOTIFY_DBCC_EN);
+
+	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
+			      H2C_CAT_MAC, H2C_CL_MAC_MEDIA_RPT,
+			      H2C_FUNC_NOTIFY_DBCC, 0, 1,
+			      len);
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
 int rtw89_fw_h2c_macid_pause(struct rtw89_dev *rtwdev, u8 sh, u8 grp,
 			     bool pause)
 {
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 2b2d14284465..8501f6c6819d 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -1685,6 +1685,12 @@ static inline void SET_JOININFO_SELF_ROLE(void *h2c, u32 val)
 	le32p_replace_bits((__le32 *)h2c, val, GENMASK(31, 30));
 }
 
+struct rtw89_h2c_notify_dbcc {
+	__le32 w0;
+} __packed;
+
+#define RTW89_H2C_NOTIFY_DBCC_EN BIT(0)
+
 static inline void SET_GENERAL_PKT_MACID(void *h2c, u32 val)
 {
 	le32p_replace_bits((__le32 *)h2c, val, GENMASK(7, 0));
@@ -3577,6 +3583,7 @@ struct rtw89_fw_h2c_rf_reg_info {
 #define H2C_CL_MAC_MEDIA_RPT		0x8
 #define H2C_FUNC_MAC_JOININFO		0x0
 #define H2C_FUNC_MAC_FWROLE_MAINTAIN	0x4
+#define H2C_FUNC_NOTIFY_DBCC		0x5
 
 /* CLASS 9 - FW offload */
 #define H2C_CL_MAC_FW_OFLD		0x9
@@ -3702,6 +3709,7 @@ int rtw89_fw_h2c_role_maintain(struct rtw89_dev *rtwdev,
 			       enum rtw89_upd_mode upd_mode);
 int rtw89_fw_h2c_join_info(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
 			   struct rtw89_sta *rtwsta, bool dis_conn);
+int rtw89_fw_h2c_notify_dbcc(struct rtw89_dev *rtwdev, bool en);
 int rtw89_fw_h2c_macid_pause(struct rtw89_dev *rtwdev, u8 sh, u8 grp,
 			     bool pause);
 int rtw89_fw_h2c_set_edca(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
-- 
2.25.1


