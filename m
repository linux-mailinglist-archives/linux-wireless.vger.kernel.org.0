Return-Path: <linux-wireless+bounces-28960-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AD64EC5B797
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Nov 2025 07:08:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EA6FA356844
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Nov 2025 06:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F39172E11D2;
	Fri, 14 Nov 2025 06:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="rBBWUodq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8BF2E1726
	for <linux-wireless@vger.kernel.org>; Fri, 14 Nov 2025 06:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763100198; cv=none; b=Cg10LOupRKYaTF8sbVY3s4CdEiVagdvUs8VmP65WrJDMDmNm/nN77ODMSX3+h04TunC2TwaoP7rWZHk/EWl84a6peuslzQK8Jum6mRbxloV9XqeqG5ZAOBOjxobVHb6w3QMsfjixwA2KshUANucKW0n3gIxrHlcTJL8k9bN+44Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763100198; c=relaxed/simple;
	bh=PvAzQMRHKFdXCNAbUG4/crMLJ+taYYCTOZsAjnrQDLw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lqKVSSuZyAjvQwNuj21cKdPEH8g0X48RuKK9m0cqG/azkHoKr9p+Sv0eC6o51igTANFZ63cy8uyJjmDhfj5QQlUircSeAU8TV9mq3T+bIuL9RAxdAh8bLmeY22hpBle+MkkFNy8nyxZ8gghAJEOVNfjGbr5q6aycbYSMNNGW3Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=rBBWUodq; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5AE63DjoC1038364, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1763100193; bh=I9XDxaovE0HMZ0A/ygZMK/1C6L1SdNaaWNcO8/Di8SE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=rBBWUodqoXQHpHwhgUj6ndSUkAaItj+q+j/YVYeeWqfcjI+k0+jv8GAQeP85H3muT
	 kWOuw8Qbz8aeSvtJgiKlQJrsBiJ625NhfElOkIkwJ42giskXgZOrQdWGFhUzdFiVYR
	 4++osFQWtCxhnBA541ZaEzLXCwTeTeh1CP+h6VLaZiGQDnYVmJY4TiMbYS4HSqmCaF
	 sMWAf1IGKLLY3eRBDSOZMyfuqCCtMHcY0ell7QAviPlBwVxmv51L/yfvd6brgMknvH
	 FWAUQBXpIYGC2njxbuPAWbFlZ0ELJRR5MVfC0gQVQ7arV3/+z5wu3iopyupnGiE72+
	 /6dg4wMUMUKKA==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5AE63DjoC1038364
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 14 Nov 2025 14:03:13 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Fri, 14 Nov 2025 14:03:13 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27 via Frontend
 Transport; Fri, 14 Nov 2025 14:03:13 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>
Subject: [PATCH v2 rtw-next 13/14] wifi: rtw89: update format of addr cam H2C command
Date: Fri, 14 Nov 2025 14:01:27 +0800
Message-ID: <20251114060128.35363-14-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251114060128.35363-1-pkshih@realtek.com>
References: <20251114060128.35363-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Chih-Kang Chang <gary.chang@realtek.com>

The addr cam H2C command is to tell firmware the addr related info.
For RTL8922D and RTL8922A after firmware version 0.35.84.0, the addr cam
must be updated with update mode to avoid clearing previously set
fields. Update it accordingly.

Signed-off-by: Chih-Kang Chang <gary.chang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2: no change
---
 drivers/net/wireless/realtek/rtw89/cam.c      | 10 ++++---
 drivers/net/wireless/realtek/rtw89/cam.h      | 12 ++++++---
 drivers/net/wireless/realtek/rtw89/core.c     | 12 ++++++---
 drivers/net/wireless/realtek/rtw89/core.h     |  1 +
 drivers/net/wireless/realtek/rtw89/fw.c       | 26 ++++++++++++++++---
 drivers/net/wireless/realtek/rtw89/fw.h       |  3 ++-
 drivers/net/wireless/realtek/rtw89/mac.c      |  4 +--
 drivers/net/wireless/realtek/rtw89/mac80211.c |  4 +--
 drivers/net/wireless/realtek/rtw89/wow.c      |  6 +++--
 9 files changed, 56 insertions(+), 22 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/cam.c b/drivers/net/wireless/realtek/rtw89/cam.c
index 5f282a02a356..9370cbda945c 100644
--- a/drivers/net/wireless/realtek/rtw89/cam.c
+++ b/drivers/net/wireless/realtek/rtw89/cam.c
@@ -236,7 +236,8 @@ static int __rtw89_cam_detach_sec_cam(struct rtw89_dev *rtwdev,
 		if (ret)
 			rtw89_err(rtwdev,
 				  "failed to update dctl cam del key: %d\n", ret);
-		ret = rtw89_fw_h2c_cam(rtwdev, rtwvif_link, rtwsta_link, NULL);
+		ret = rtw89_fw_h2c_cam(rtwdev, rtwvif_link, rtwsta_link, NULL,
+				       RTW89_ROLE_INFO_CHANGE);
 		if (ret)
 			rtw89_err(rtwdev, "failed to update cam del key: %d\n", ret);
 	}
@@ -276,7 +277,8 @@ static int __rtw89_cam_attach_sec_cam(struct rtw89_dev *rtwdev,
 			  ret);
 		return ret;
 	}
-	ret = rtw89_fw_h2c_cam(rtwdev, rtwvif_link, rtwsta_link, NULL);
+	ret = rtw89_fw_h2c_cam(rtwdev, rtwvif_link, rtwsta_link, NULL,
+			       RTW89_ROLE_INFO_CHANGE);
 	if (ret) {
 		rtw89_err(rtwdev, "failed to update addr cam sec entry: %d\n",
 			  ret);
@@ -761,7 +763,7 @@ int rtw89_cam_init(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_link)
 int rtw89_cam_fill_bssid_cam_info(struct rtw89_dev *rtwdev,
 				  struct rtw89_vif_link *rtwvif_link,
 				  struct rtw89_sta_link *rtwsta_link,
-				  struct rtw89_h2c_addr_cam *h2c)
+				  struct rtw89_h2c_addr_cam_v0 *h2c)
 {
 	struct rtw89_bssid_cam_entry *bssid_cam = rtw89_get_bssid_cam_of(rtwvif_link,
 									 rtwsta_link);
@@ -813,7 +815,7 @@ void rtw89_cam_fill_addr_cam_info(struct rtw89_dev *rtwdev,
 				  struct rtw89_vif_link *rtwvif_link,
 				  struct rtw89_sta_link *rtwsta_link,
 				  const u8 *scan_mac_addr,
-				  struct rtw89_h2c_addr_cam *h2c)
+				  struct rtw89_h2c_addr_cam_v0 *h2c)
 {
 	struct ieee80211_vif *vif = rtwvif_link_to_vif(rtwvif_link);
 	struct rtw89_addr_cam_entry *addr_cam =
diff --git a/drivers/net/wireless/realtek/rtw89/cam.h b/drivers/net/wireless/realtek/rtw89/cam.h
index 833a956f0176..c46b6f91bbdb 100644
--- a/drivers/net/wireless/realtek/rtw89/cam.h
+++ b/drivers/net/wireless/realtek/rtw89/cam.h
@@ -12,7 +12,7 @@
 #define RTW89_BSSID_MATCH_ALL GENMASK(5, 0)
 #define RTW89_BSSID_MATCH_5_BYTES GENMASK(4, 0)
 
-struct rtw89_h2c_addr_cam {
+struct rtw89_h2c_addr_cam_v0 {
 	__le32 w0;
 	__le32 w1;
 	__le32 w2;
@@ -30,6 +30,11 @@ struct rtw89_h2c_addr_cam {
 	__le32 w14;
 } __packed;
 
+struct rtw89_h2c_addr_cam {
+	struct rtw89_h2c_addr_cam_v0 v0;
+	__le32 w15;
+} __packed;
+
 #define ADDR_CAM_W1_IDX GENMASK(7, 0)
 #define ADDR_CAM_W1_OFFSET GENMASK(15, 8)
 #define ADDR_CAM_W1_LEN GENMASK(23, 16)
@@ -109,6 +114,7 @@ struct rtw89_h2c_addr_cam {
 #define ADDR_CAM_W14_BSSID_BSSID3 GENMASK(15, 8)
 #define ADDR_CAM_W14_BSSID_BSSID4 GENMASK(23, 16)
 #define ADDR_CAM_W14_BSSID_BSSID5 GENMASK(31, 24)
+#define ADDR_CAM_W15_UPD_MODE GENMASK(2, 0)
 
 struct rtw89_h2c_dctlinfo_ud_v1 {
 	__le32 c0;
@@ -313,7 +319,7 @@ void rtw89_cam_fill_addr_cam_info(struct rtw89_dev *rtwdev,
 				  struct rtw89_vif_link *rtwvif_link,
 				  struct rtw89_sta_link *rtwsta_link,
 				  const u8 *scan_mac_addr,
-				  struct rtw89_h2c_addr_cam *h2c);
+				  struct rtw89_h2c_addr_cam_v0 *h2c);
 void rtw89_cam_fill_dctl_sec_cam_info_v1(struct rtw89_dev *rtwdev,
 					 struct rtw89_vif_link *rtwvif_link,
 					 struct rtw89_sta_link *rtwsta_link,
@@ -325,7 +331,7 @@ void rtw89_cam_fill_dctl_sec_cam_info_v2(struct rtw89_dev *rtwdev,
 int rtw89_cam_fill_bssid_cam_info(struct rtw89_dev *rtwdev,
 				  struct rtw89_vif_link *rtwvif_link,
 				  struct rtw89_sta_link *rtwsta_link,
-				  struct rtw89_h2c_addr_cam *h2c);
+				  struct rtw89_h2c_addr_cam_v0 *h2c);
 int rtw89_cam_sec_key_add(struct rtw89_dev *rtwdev,
 			  struct ieee80211_vif *vif,
 			  struct ieee80211_sta *sta,
diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index ea22925b8772..a14edc321ca7 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -4823,7 +4823,8 @@ int rtw89_core_sta_link_disconnect(struct rtw89_dev *rtwdev,
 	}
 
 	/* update cam aid mac_id net_type */
-	ret = rtw89_fw_h2c_cam(rtwdev, rtwvif_link, rtwsta_link, NULL);
+	ret = rtw89_fw_h2c_cam(rtwdev, rtwvif_link, rtwsta_link, NULL,
+			       RTW89_ROLE_CON_DISCONN);
 	if (ret) {
 		rtw89_warn(rtwdev, "failed to send h2c cam\n");
 		return ret;
@@ -4897,7 +4898,8 @@ int rtw89_core_sta_link_assoc(struct rtw89_dev *rtwdev,
 	}
 
 	/* update cam aid mac_id net_type */
-	ret = rtw89_fw_h2c_cam(rtwdev, rtwvif_link, rtwsta_link, NULL);
+	ret = rtw89_fw_h2c_cam(rtwdev, rtwvif_link, rtwsta_link, NULL,
+			       RTW89_ROLE_CON_DISCONN);
 	if (ret) {
 		rtw89_warn(rtwdev, "failed to send h2c cam\n");
 		return ret;
@@ -6029,7 +6031,8 @@ void rtw89_core_scan_start(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwv
 	rtw89_phy_config_edcca(rtwdev, bb, true);
 	rtw89_tas_scan(rtwdev, true);
 
-	rtw89_fw_h2c_cam(rtwdev, rtwvif_link, NULL, mac_addr);
+	rtw89_fw_h2c_cam(rtwdev, rtwvif_link, NULL, mac_addr,
+			 RTW89_ROLE_INFO_CHANGE);
 }
 
 void rtw89_core_scan_complete(struct rtw89_dev *rtwdev,
@@ -6049,7 +6052,8 @@ void rtw89_core_scan_complete(struct rtw89_dev *rtwdev,
 
 	rcu_read_unlock();
 
-	rtw89_fw_h2c_cam(rtwdev, rtwvif_link, NULL, NULL);
+	rtw89_fw_h2c_cam(rtwdev, rtwvif_link, NULL, NULL,
+			 RTW89_ROLE_INFO_CHANGE);
 
 	rtw89_chip_rfk_scan(rtwdev, rtwvif_link, false);
 	rtw89_btc_ntfy_scan_finish(rtwdev, rtwvif_link->phy_idx);
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index c33ff7c0090f..ab71489b89a3 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -4678,6 +4678,7 @@ enum rtw89_fw_feature {
 	RTW89_FW_FEATURE_RFK_NTFY_MCC_V0,
 	RTW89_FW_FEATURE_LPS_DACK_BY_C2H_REG,
 	RTW89_FW_FEATURE_BEACON_TRACKING,
+	RTW89_FW_FEATURE_ADDR_CAM_V0,
 };
 
 struct rtw89_fw_suit {
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 9f132a469629..18eab404885c 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -881,6 +881,7 @@ static const struct __fw_feat_cfg fw_feat_tbl[] = {
 	__CFG_FW_FEAT(RTL8922A, ge, 0, 35, 76, 0, LPS_DACK_BY_C2H_REG),
 	__CFG_FW_FEAT(RTL8922A, ge, 0, 35, 79, 0, CRASH_TRIGGER_TYPE_1),
 	__CFG_FW_FEAT(RTL8922A, ge, 0, 35, 80, 0, BEACON_TRACKING),
+	__CFG_FW_FEAT(RTL8922A, lt, 0, 35, 84, 0, ADDR_CAM_V0),
 };
 
 static void rtw89_fw_iterate_feature_cfg(struct rtw89_fw_info *fw,
@@ -2133,25 +2134,42 @@ void rtw89_fw_log_dump(struct rtw89_dev *rtwdev, u8 *buf, u32 len)
 }
 
 int rtw89_fw_h2c_cam(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_link,
-		     struct rtw89_sta_link *rtwsta_link, const u8 *scan_mac_addr)
+		     struct rtw89_sta_link *rtwsta_link, const u8 *scan_mac_addr,
+		     enum rtw89_upd_mode upd_mode)
 {
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+	struct rtw89_h2c_addr_cam_v0 *h2c_v0;
 	struct rtw89_h2c_addr_cam *h2c;
 	u32 len = sizeof(*h2c);
 	struct sk_buff *skb;
+	u8 ver = U8_MAX;
 	int ret;
 
+	if (RTW89_CHK_FW_FEATURE(ADDR_CAM_V0, &rtwdev->fw) ||
+	    chip->chip_gen == RTW89_CHIP_AX) {
+		len = sizeof(*h2c_v0);
+		ver = 0;
+	}
+
 	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, len);
 	if (!skb) {
 		rtw89_err(rtwdev, "failed to alloc skb for fw dl\n");
 		return -ENOMEM;
 	}
 	skb_put(skb, len);
-	h2c = (struct rtw89_h2c_addr_cam *)skb->data;
+	h2c_v0 = (struct rtw89_h2c_addr_cam_v0 *)skb->data;
 
 	rtw89_cam_fill_addr_cam_info(rtwdev, rtwvif_link, rtwsta_link,
-				     scan_mac_addr, h2c);
-	rtw89_cam_fill_bssid_cam_info(rtwdev, rtwvif_link, rtwsta_link, h2c);
+				     scan_mac_addr, h2c_v0);
+	rtw89_cam_fill_bssid_cam_info(rtwdev, rtwvif_link, rtwsta_link, h2c_v0);
 
+	if (ver == 0)
+		goto hdr;
+
+	h2c = (struct rtw89_h2c_addr_cam *)skb->data;
+	h2c->w15 = le32_encode_bits(upd_mode, ADDR_CAM_W15_UPD_MODE);
+
+hdr:
 	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
 			      H2C_CAT_MAC,
 			      H2C_CL_MAC_ADDR_CAM_UPDATE,
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index e62b61f584fb..cedb4a47a769 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -4887,7 +4887,8 @@ int rtw89_fw_h2c_tbtt_tuning(struct rtw89_dev *rtwdev,
 			     struct rtw89_vif_link *rtwvif_link, u32 offset);
 int rtw89_fw_h2c_pwr_lvl(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_link);
 int rtw89_fw_h2c_cam(struct rtw89_dev *rtwdev, struct rtw89_vif_link *vif,
-		     struct rtw89_sta_link *rtwsta_link, const u8 *scan_mac_addr);
+		     struct rtw89_sta_link *rtwsta_link, const u8 *scan_mac_addr,
+		     enum rtw89_upd_mode upd_mode);
 int rtw89_fw_h2c_dctl_sec_cam_v1(struct rtw89_dev *rtwdev,
 				 struct rtw89_vif_link *rtwvif_link,
 				 struct rtw89_sta_link *rtwsta_link);
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 386cc982d7c9..bde3791dd330 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -4835,7 +4835,7 @@ int rtw89_mac_vif_init(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_l
 	if (ret)
 		return ret;
 
-	ret = rtw89_fw_h2c_cam(rtwdev, rtwvif_link, NULL, NULL);
+	ret = rtw89_fw_h2c_cam(rtwdev, rtwvif_link, NULL, NULL, RTW89_ROLE_CREATE);
 	if (ret)
 		return ret;
 
@@ -4860,7 +4860,7 @@ int rtw89_mac_vif_deinit(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif
 
 	rtw89_cam_deinit(rtwdev, rtwvif_link);
 
-	ret = rtw89_fw_h2c_cam(rtwdev, rtwvif_link, NULL, NULL);
+	ret = rtw89_fw_h2c_cam(rtwdev, rtwvif_link, NULL, NULL, RTW89_ROLE_REMOVE);
 	if (ret)
 		return ret;
 
diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index 4a7364432428..82598673ddec 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -759,7 +759,7 @@ static void rtw89_ops_link_info_changed(struct ieee80211_hw *hw,
 	if (changed & BSS_CHANGED_BSSID) {
 		ether_addr_copy(rtwvif_link->bssid, conf->bssid);
 		rtw89_cam_bssid_changed(rtwdev, rtwvif_link);
-		rtw89_fw_h2c_cam(rtwdev, rtwvif_link, NULL, NULL);
+		rtw89_fw_h2c_cam(rtwdev, rtwvif_link, NULL, NULL, RTW89_ROLE_INFO_CHANGE);
 		WRITE_ONCE(rtwvif_link->sync_bcn_tsf, 0);
 	}
 
@@ -818,7 +818,7 @@ static int rtw89_ops_start_ap(struct ieee80211_hw *hw,
 	rtw89_chip_h2c_assoc_cmac_tbl(rtwdev, rtwvif_link, NULL);
 	rtw89_fw_h2c_role_maintain(rtwdev, rtwvif_link, NULL, RTW89_ROLE_TYPE_CHANGE);
 	rtw89_fw_h2c_join_info(rtwdev, rtwvif_link, NULL, true);
-	rtw89_fw_h2c_cam(rtwdev, rtwvif_link, NULL, NULL);
+	rtw89_fw_h2c_cam(rtwdev, rtwvif_link, NULL, NULL, RTW89_ROLE_TYPE_CHANGE);
 	rtw89_chip_rfk_channel(rtwdev, rtwvif_link);
 
 	if (RTW89_CHK_FW_FEATURE(NOTIFY_AP_INFO, &rtwdev->fw)) {
diff --git a/drivers/net/wireless/realtek/rtw89/wow.c b/drivers/net/wireless/realtek/rtw89/wow.c
index b9fce0be3ab7..46aba4cb2ee9 100644
--- a/drivers/net/wireless/realtek/rtw89/wow.c
+++ b/drivers/net/wireless/realtek/rtw89/wow.c
@@ -1221,7 +1221,8 @@ static int rtw89_wow_cfg_wake(struct rtw89_dev *rtwdev, bool wow)
 		}
 	}
 
-	ret = rtw89_fw_h2c_cam(rtwdev, rtwvif_link, rtwsta_link, NULL);
+	ret = rtw89_fw_h2c_cam(rtwdev, rtwvif_link, rtwsta_link, NULL,
+			       RTW89_ROLE_INFO_CHANGE);
 	if (ret) {
 		rtw89_warn(rtwdev, "failed to send h2c cam\n");
 		return ret;
@@ -1318,7 +1319,8 @@ static int rtw89_wow_swap_fw(struct rtw89_dev *rtwdev, bool wow)
 		return ret;
 	}
 
-	ret = rtw89_fw_h2c_cam(rtwdev, rtwvif_link, rtwsta_link, NULL);
+	ret = rtw89_fw_h2c_cam(rtwdev, rtwvif_link, rtwsta_link, NULL,
+			       RTW89_ROLE_FW_RESTORE);
 	if (ret) {
 		rtw89_warn(rtwdev, "failed to send h2c cam\n");
 		return ret;
-- 
2.25.1


