Return-Path: <linux-wireless+bounces-10948-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE47E9477DE
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Aug 2024 11:02:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11BE5B223B2
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Aug 2024 09:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7AE4153820;
	Mon,  5 Aug 2024 09:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="s/3WzLAq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E8C14E2D8
	for <linux-wireless@vger.kernel.org>; Mon,  5 Aug 2024 09:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722848471; cv=none; b=maWLr2m1oGNxzyEEsN3LyrCHlvt3/03olH1wYmgsRs6wCNfxX+7Sp1ZqPY0GXVlTzqYQataKftg/Bv3EOuE1xBw6wTlifiPRneXTzb2fkPVbglvUo5HmlHRcCR/7V1/CYx4HWm42sPaRYs90jLD6lFnvDofG+92x2VHLy6L52uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722848471; c=relaxed/simple;
	bh=6ACUFDVKuG0E9A1ukMBJXqcAmWyxGPhK0ou880otGeM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gxG3WBJg/+n9EqNnM1JMOiw/SKVJIPiGBqw7VDDD639HFjcQbgfxGrPA5JnoqZ511/5+bOiKh1ewECJpknum/GEvJ9lIwlDfaGQ2hxR+ZbDSPWRe48v7pAHqNKTTeFLCGINBd4jKfcu6rnBJN+I8NfvnSKKbXj9nOCftIQWvbHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=s/3WzLAq; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 475916YV03834732, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1722848466; bh=6ACUFDVKuG0E9A1ukMBJXqcAmWyxGPhK0ou880otGeM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=s/3WzLAqcgz0/qvYQLrSoZUziE/65tQboQ4IJl4cUvxMl326oHB9fW/0f+nUV4Ywd
	 pkI1sgQFg3BinsbFbEH7yzmnTjTiIiff2G+nvkn/CbWxtUZ3xhfplgGmcu9hWTZCYU
	 YZzG1fZ5Dq5GxLPbyOxcGL1ylkf26QFGpSQNElkHVqlYRnQZK8+0Kdwqh0MTba9KHb
	 Fpkg3yJgcqtwOvr7n2PTd0xHq+tWtHU/VgtipCyhpWUeadmepRqNZCNF7ycBkgjF4d
	 AskUYj6TYBkmGThLTHtd2ghQA/pqZz/mEmSLrh1P1SK8dIatpN2WVlxxu885AORs8d
	 7GNFbpB84/D8Q==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 475916YV03834732
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 5 Aug 2024 17:01:06 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 5 Aug 2024 17:01:05 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 5 Aug
 2024 17:01:05 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <timlee@realtek.com>
Subject: [PATCH 2/5] wifi: rtw89: wow: implement PS mode for net-detect
Date: Mon, 5 Aug 2024 17:00:25 +0800
Message-ID: <20240805090028.27768-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240805090028.27768-1-pkshih@realtek.com>
References: <20240805090028.27768-1-pkshih@realtek.com>
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

From: Chin-Yen Lee <timlee@realtek.com>

When net-detect is enabled, WoWLAN firmware will periodically
scan until beacon or probe response of configured networks are
received. To reduce power consumption, the FW-IPS mode is
implemented to keep WiFi chip in idle mode between each scan.
The FW-IPS is controlled by WoWLAN firmware to turn of some critical
electrical components, and is different from the original IPS mode
which most electrical components are turned off.

Signed-off-by: Chin-Yen Lee <timlee@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c  | 36 ++++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/fw.h  | 10 +++++++
 drivers/net/wireless/realtek/rtw89/wow.c | 34 +++++++++++++++++-----
 drivers/net/wireless/realtek/rtw89/wow.h | 16 +++++++++++
 4 files changed, 89 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 4c0a1aed6efd..e545d2a7fb49 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -6856,7 +6856,43 @@ int rtw89_fw_h2c_wow_gtk_ofld(struct rtw89_dev *rtwdev,
 		goto fail;
 	}
 	return 0;
+fail:
+	dev_kfree_skb_any(skb);
+
+	return ret;
+}
+
+int rtw89_fw_h2c_fwips(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
+		       bool enable)
+{
+	struct rtw89_h2c_fwips *h2c;
+	u32 len = sizeof(*h2c);
+	struct sk_buff *skb;
+	int ret;
+
+	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, len);
+	if (!skb) {
+		rtw89_err(rtwdev, "failed to alloc skb for fw ips\n");
+		return -ENOMEM;
+	}
+	skb_put(skb, len);
+	h2c = (struct rtw89_h2c_fwips *)skb->data;
+
+	h2c->w0 = le32_encode_bits(rtwvif->mac_id, RTW89_H2C_FW_IPS_W0_MACID) |
+		  le32_encode_bits(enable, RTW89_H2C_FW_IPS_W0_ENABLE);
+
+	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
+			      H2C_CAT_MAC,
+			      H2C_CL_MAC_PS,
+			      H2C_FUNC_IPS_CFG, 0, 1,
+			      len);
 
+	ret = rtw89_h2c_tx(rtwdev, skb, false);
+	if (ret) {
+		rtw89_err(rtwdev, "failed to send h2c\n");
+		goto fail;
+	}
+	return 0;
 fail:
 	dev_kfree_skb_any(skb);
 
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 0b0c5b5c6bb9..1bbdf0613ca4 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -2748,6 +2748,13 @@ struct rtw89_h2c_scanofld_be {
 #define RTW89_H2C_SCANOFLD_BE_W9_SIZE_MACC GENMASK(15, 8)
 #define RTW89_H2C_SCANOFLD_BE_W9_SIZE_OP GENMASK(23, 16)
 
+struct rtw89_h2c_fwips {
+	__le32 w0;
+} __packed;
+
+#define RTW89_H2C_FW_IPS_W0_MACID GENMASK(7, 0)
+#define RTW89_H2C_FW_IPS_W0_ENABLE BIT(8)
+
 static inline void RTW89_SET_FWCMD_P2P_MACID(void *cmd, u32 val)
 {
 	le32p_replace_bits((__le32 *)cmd, val, GENMASK(7, 0));
@@ -3965,6 +3972,7 @@ enum rtw89_wow_h2c_func {
 #define H2C_CL_MAC_PS			0x2
 #define H2C_FUNC_MAC_LPS_PARM		0x0
 #define H2C_FUNC_P2P_ACT		0x1
+#define H2C_FUNC_IPS_CFG		0x3
 
 /* CLASS 3 - FW download */
 #define H2C_CL_MAC_FWDL		0x3
@@ -4446,6 +4454,8 @@ int rtw89_fw_h2c_lps_parm(struct rtw89_dev *rtwdev,
 			  struct rtw89_lps_parm *lps_param);
 int rtw89_fw_h2c_lps_ch_info(struct rtw89_dev *rtwdev,
 			     struct rtw89_vif *rtwvif);
+int rtw89_fw_h2c_fwips(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
+		       bool enable);
 struct sk_buff *rtw89_fw_h2c_alloc_skb_with_hdr(struct rtw89_dev *rtwdev, u32 len);
 struct sk_buff *rtw89_fw_h2c_alloc_skb_no_hdr(struct rtw89_dev *rtwdev, u32 len);
 int rtw89_fw_msg_reg(struct rtw89_dev *rtwdev,
diff --git a/drivers/net/wireless/realtek/rtw89/wow.c b/drivers/net/wireless/realtek/rtw89/wow.c
index 9882064ef68d..fa7fd6571051 100644
--- a/drivers/net/wireless/realtek/rtw89/wow.c
+++ b/drivers/net/wireless/realtek/rtw89/wow.c
@@ -687,17 +687,30 @@ static void rtw89_wow_enter_deep_ps(struct rtw89_dev *rtwdev)
 	__rtw89_enter_ps_mode(rtwdev, rtwvif);
 }
 
-static void rtw89_wow_enter_lps(struct rtw89_dev *rtwdev)
+static void rtw89_wow_enter_ps(struct rtw89_dev *rtwdev)
 {
 	struct ieee80211_vif *wow_vif = rtwdev->wow.wow_vif;
 	struct rtw89_vif *rtwvif = (struct rtw89_vif *)wow_vif->drv_priv;
 
-	rtw89_enter_lps(rtwdev, rtwvif, false);
+	if (rtw89_wow_mgd_linked(rtwdev))
+		rtw89_enter_lps(rtwdev, rtwvif, false);
+	else if (rtw89_wow_no_link(rtwdev))
+		rtw89_fw_h2c_fwips(rtwdev, rtwvif, true);
 }
 
-static void rtw89_wow_leave_lps(struct rtw89_dev *rtwdev)
+static void rtw89_wow_leave_ps(struct rtw89_dev *rtwdev, bool enable_wow)
 {
-	rtw89_leave_lps(rtwdev);
+	struct ieee80211_vif *wow_vif = rtwdev->wow.wow_vif;
+	struct rtw89_vif *rtwvif = (struct rtw89_vif *)wow_vif->drv_priv;
+
+	if (rtw89_wow_mgd_linked(rtwdev)) {
+		rtw89_leave_lps(rtwdev);
+	} else if (rtw89_wow_no_link(rtwdev)) {
+		if (enable_wow)
+			rtw89_leave_ips(rtwdev);
+		else
+			rtw89_fw_h2c_fwips(rtwdev, rtwvif, false);
+	}
 }
 
 static int rtw89_wow_config_mac(struct rtw89_dev *rtwdev, bool enable_wow)
@@ -1430,7 +1443,7 @@ static int rtw89_wow_enable(struct rtw89_dev *rtwdev)
 		goto out;
 	}
 
-	rtw89_wow_enter_lps(rtwdev);
+	rtw89_wow_enter_ps(rtwdev);
 
 	ret = rtw89_wow_enable_trx_post(rtwdev);
 	if (ret) {
@@ -1455,7 +1468,7 @@ static int rtw89_wow_disable(struct rtw89_dev *rtwdev)
 		goto out;
 	}
 
-	rtw89_wow_leave_lps(rtwdev);
+	rtw89_wow_leave_ps(rtwdev, false);
 
 	ret = rtw89_wow_fw_stop(rtwdev);
 	if (ret) {
@@ -1480,6 +1493,12 @@ static int rtw89_wow_disable(struct rtw89_dev *rtwdev)
 	return ret;
 }
 
+static void rtw89_wow_restore_ps(struct rtw89_dev *rtwdev)
+{
+	if (rtw89_wow_no_link(rtwdev))
+		rtw89_enter_ips(rtwdev);
+}
+
 int rtw89_wow_resume(struct rtw89_dev *rtwdev)
 {
 	int ret;
@@ -1504,6 +1523,7 @@ int rtw89_wow_resume(struct rtw89_dev *rtwdev)
 	if (ret)
 		rtw89_err(rtwdev, "failed to disable wow\n");
 
+	rtw89_wow_restore_ps(rtwdev);
 out:
 	rtw89_wow_clear_wakeups(rtwdev);
 	return ret;
@@ -1519,7 +1539,7 @@ int rtw89_wow_suspend(struct rtw89_dev *rtwdev, struct cfg80211_wowlan *wowlan)
 		return ret;
 	}
 
-	rtw89_wow_leave_lps(rtwdev);
+	rtw89_wow_leave_ps(rtwdev, true);
 
 	ret = rtw89_wow_enable(rtwdev);
 	if (ret) {
diff --git a/drivers/net/wireless/realtek/rtw89/wow.h b/drivers/net/wireless/realtek/rtw89/wow.h
index 0d90add0e88d..5eff3084119b 100644
--- a/drivers/net/wireless/realtek/rtw89/wow.h
+++ b/drivers/net/wireless/realtek/rtw89/wow.h
@@ -95,6 +95,22 @@ static inline int rtw89_wow_get_sec_hdr_len(struct rtw89_dev *rtwdev)
 }
 
 #ifdef CONFIG_PM
+static inline bool rtw89_wow_mgd_linked(struct rtw89_dev *rtwdev)
+{
+	struct ieee80211_vif *wow_vif = rtwdev->wow.wow_vif;
+	struct rtw89_vif *rtwvif = (struct rtw89_vif *)wow_vif->drv_priv;
+
+	return rtwvif->net_type == RTW89_NET_TYPE_INFRA;
+}
+
+static inline bool rtw89_wow_no_link(struct rtw89_dev *rtwdev)
+{
+	struct ieee80211_vif *wow_vif = rtwdev->wow.wow_vif;
+	struct rtw89_vif *rtwvif = (struct rtw89_vif *)wow_vif->drv_priv;
+
+	return rtwvif->net_type == RTW89_NET_TYPE_NO_LINK;
+}
+
 int rtw89_wow_suspend(struct rtw89_dev *rtwdev, struct cfg80211_wowlan *wowlan);
 int rtw89_wow_resume(struct rtw89_dev *rtwdev);
 void rtw89_wow_parse_akm(struct rtw89_dev *rtwdev, struct sk_buff *skb);
-- 
2.25.1


