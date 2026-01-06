Return-Path: <linux-wireless+bounces-30384-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 531B5CF6912
	for <lists+linux-wireless@lfdr.de>; Tue, 06 Jan 2026 04:10:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 930AC307EA35
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Jan 2026 03:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16ABC3A1E95;
	Tue,  6 Jan 2026 03:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="mlhBxCIT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F90A20A5E5
	for <linux-wireless@vger.kernel.org>; Tue,  6 Jan 2026 03:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767668996; cv=none; b=QYLEDj6JVHwObAqvsJLiSvdJM/gmUCLyvPi/wBeCgEQqwhlRHywuKora0yPM7Scweqiz5izGTlmZADfSjnaKG+XGnRQOzcmTVheHOQwgUn6VTeboyItsFzc46NsN67DDfiBi4FCu0+Q6qLNkWtKuiDmwpwgkuy2YZxpT1rujP04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767668996; c=relaxed/simple;
	bh=HMq1X5r5iakMqu4VdOLs7dn7jQqj0gubEeZIuSBgHBo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M/T5iplUgl/kFn686fF0wG4qm7L7cmIGyhlkJuwctCjZ4d7hV+K7+eRo1OFLl8YXv/osqkghi4QadhJMiJ90roxnzBQyCA8yqRBVuWF4yKce3XJTdaCRRH1lBDOt8U2vCsZ0mzeHzl6qByc27/tlDXMSkKlitkxayfBJfuMRXmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=mlhBxCIT; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 60639o4cA4169021, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1767668990; bh=Fzd+g9Ka5+3wWd6uTdiPu0N5MdFzP/aC7miY34hO/44=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=mlhBxCITAhGOVLNbZJHo1RARVmH7Jvjew9fYBq0YhvxCLwdH66oxvqYC1+/7Q3S+/
	 4bCFc4edV6bQwBMqrJiWSwyXAdhHjKL6w/JMfeKwUP0ROS8P+VlqFr7kJntSdoZcM0
	 bW6+V/L2LB1DjzNSZ2Fvuq7RdbmUpZdB419CSDELTttdZQ9z6qTmjL7i34UxZf9ORt
	 zyQfLVMea7AryDPeRu2ZwjxIkE2bckxZwphjGOexxwiSSlvNxHul811OANySZl79EB
	 SVCgd2NKLL+KJJ2x/90cE67h+XibOEG6lzWGWu2+bOQvpWWT1aWb4n2SxrmCDFTwjc
	 2wyv/8mIZPOrA==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 60639o4cA4169021
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 6 Jan 2026 11:09:50 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 6 Jan 2026 11:09:50 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Tue, 6 Jan 2026 11:09:50 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH rtw-next v2 03/10] wifi: rtw89: fw: add DMAC v3 H2C command for RTL8922D
Date: Tue, 6 Jan 2026 11:09:04 +0800
Message-ID: <20260106030911.15528-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260106030911.15528-1-pkshih@realtek.com>
References: <20260106030911.15528-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Write association data including address and security key of peer to
hardware. Add the command for RTL8922D accordingly.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/cam.c | 134 +++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/cam.h | 129 ++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/fw.c  |  95 ++++++++++++++++
 drivers/net/wireless/realtek/rtw89/fw.h  |   7 ++
 4 files changed, 365 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/cam.c b/drivers/net/wireless/realtek/rtw89/cam.c
index 9370cbda945c..9f63d67777fa 100644
--- a/drivers/net/wireless/realtek/rtw89/cam.c
+++ b/drivers/net/wireless/realtek/rtw89/cam.c
@@ -1140,3 +1140,137 @@ void rtw89_cam_fill_dctl_sec_cam_info_v2(struct rtw89_dev *rtwdev,
 		   le32_encode_bits(mld_bssid[5], DCTLINFO_V2_W12_MLD_BSSID_5);
 	h2c->m12 = cpu_to_le32(DCTLINFO_V2_W12_ALL);
 }
+
+void rtw89_cam_fill_dctl_sec_cam_info_v3(struct rtw89_dev *rtwdev,
+					 struct rtw89_vif_link *rtwvif_link,
+					 struct rtw89_sta_link *rtwsta_link,
+					 struct rtw89_h2c_dctlinfo_ud_v3 *h2c)
+{
+	struct ieee80211_sta *sta = rtwsta_link_to_sta_safe(rtwsta_link);
+	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif_link->rtwvif);
+	struct rtw89_vif *rtwvif = rtwvif_link->rtwvif;
+	struct rtw89_addr_cam_entry *addr_cam =
+		rtw89_get_addr_cam_of(rtwvif_link, rtwsta_link);
+	bool is_mld = sta ? sta->mlo : ieee80211_vif_is_mld(vif);
+	struct rtw89_wow_param *rtw_wow = &rtwdev->wow;
+	u8 *ptk_tx_iv = rtw_wow->key_info.ptk_tx_iv;
+	u8 *mld_sma, *mld_tma, *mld_bssid;
+
+	h2c->c0 = le32_encode_bits(rtwsta_link ? rtwsta_link->mac_id :
+						 rtwvif_link->mac_id,
+				   DCTLINFO_V3_C0_MACID) |
+		  le32_encode_bits(1, DCTLINFO_V3_C0_OP);
+
+	h2c->w2 = le32_encode_bits(is_mld, DCTLINFO_V3_W2_IS_MLD);
+	h2c->m2 = cpu_to_le32(DCTLINFO_V3_W2_IS_MLD);
+
+	h2c->w4 = le32_encode_bits(addr_cam->sec_ent_keyid[0],
+				   DCTLINFO_V3_W4_SEC_ENT0_KEYID) |
+		  le32_encode_bits(addr_cam->sec_ent_keyid[1],
+				   DCTLINFO_V3_W4_SEC_ENT1_KEYID) |
+		  le32_encode_bits(addr_cam->sec_ent_keyid[2],
+				   DCTLINFO_V3_W4_SEC_ENT2_KEYID) |
+		  le32_encode_bits(addr_cam->sec_ent_keyid[3],
+				   DCTLINFO_V3_W4_SEC_ENT3_KEYID) |
+		  le32_encode_bits(addr_cam->sec_ent_keyid[4],
+				   DCTLINFO_V3_W4_SEC_ENT4_KEYID) |
+		  le32_encode_bits(addr_cam->sec_ent_keyid[5],
+				   DCTLINFO_V3_W4_SEC_ENT5_KEYID) |
+		  le32_encode_bits(addr_cam->sec_ent_keyid[6],
+				   DCTLINFO_V3_W4_SEC_ENT6_KEYID);
+	h2c->m4 = cpu_to_le32(DCTLINFO_V3_W4_SEC_ENT0_KEYID |
+			      DCTLINFO_V3_W4_SEC_ENT1_KEYID |
+			      DCTLINFO_V3_W4_SEC_ENT2_KEYID |
+			      DCTLINFO_V3_W4_SEC_ENT3_KEYID |
+			      DCTLINFO_V3_W4_SEC_ENT4_KEYID |
+			      DCTLINFO_V3_W4_SEC_ENT5_KEYID |
+			      DCTLINFO_V3_W4_SEC_ENT6_KEYID);
+
+	h2c->w5 = le32_encode_bits(addr_cam->sec_cam_map[0],
+				   DCTLINFO_V3_W5_SEC_ENT_VALID_V1);
+	h2c->m5 = cpu_to_le32(DCTLINFO_V3_W5_SEC_ENT_VALID_V1);
+
+	h2c->w6 = le32_encode_bits(addr_cam->sec_ent[0],
+				   DCTLINFO_V3_W6_SEC_ENT0_V2) |
+		  le32_encode_bits(addr_cam->sec_ent[1],
+				   DCTLINFO_V3_W6_SEC_ENT1_V2) |
+		  le32_encode_bits(addr_cam->sec_ent[2],
+				   DCTLINFO_V3_W6_SEC_ENT2_V2);
+	h2c->m6 = cpu_to_le32(DCTLINFO_V3_W6_SEC_ENT0_V2 |
+			      DCTLINFO_V3_W6_SEC_ENT1_V2 |
+			      DCTLINFO_V3_W6_SEC_ENT2_V2);
+
+	h2c->w7 = le32_encode_bits(addr_cam->sec_ent[3],
+				   DCTLINFO_V3_W7_SEC_ENT3_V2) |
+		  le32_encode_bits(addr_cam->sec_ent[4],
+				   DCTLINFO_V3_W7_SEC_ENT4_V2) |
+		  le32_encode_bits(addr_cam->sec_ent[5],
+				   DCTLINFO_V3_W7_SEC_ENT5_V2);
+	h2c->m7 = cpu_to_le32(DCTLINFO_V3_W7_SEC_ENT3_V2 |
+			      DCTLINFO_V3_W7_SEC_ENT4_V2 |
+			      DCTLINFO_V3_W7_SEC_ENT5_V2);
+
+	h2c->w8 = le32_encode_bits(addr_cam->sec_ent[6],
+				   DCTLINFO_V3_W8_SEC_ENT6_V2);
+	h2c->m8 = cpu_to_le32(DCTLINFO_V3_W8_SEC_ENT6_V2);
+
+	if (rtw_wow->ptk_alg) {
+		h2c->w0 = le32_encode_bits(ptk_tx_iv[0] | ptk_tx_iv[1] << 8,
+					   DCTLINFO_V3_W0_AES_IV_L);
+		h2c->m0 = cpu_to_le32(DCTLINFO_V3_W0_AES_IV_L);
+
+		h2c->w1 = le32_encode_bits(ptk_tx_iv[4] |
+					   ptk_tx_iv[5] << 8 |
+					   ptk_tx_iv[6] << 16 |
+					   ptk_tx_iv[7] << 24,
+					   DCTLINFO_V3_W1_AES_IV_H);
+		h2c->m1 = cpu_to_le32(DCTLINFO_V3_W1_AES_IV_H);
+
+		h2c->w4 |= le32_encode_bits(rtw_wow->ptk_keyidx,
+					    DCTLINFO_V3_W4_SEC_KEY_ID);
+		h2c->m4 |= cpu_to_le32(DCTLINFO_V3_W4_SEC_KEY_ID);
+	}
+
+	if (!is_mld)
+		return;
+
+	if (rtwvif_link->net_type == RTW89_NET_TYPE_INFRA) {
+		mld_sma = rtwvif->mac_addr;
+		mld_tma = vif->cfg.ap_addr;
+		mld_bssid = vif->cfg.ap_addr;
+	} else if (rtwvif_link->net_type == RTW89_NET_TYPE_AP_MODE && sta) {
+		mld_sma = rtwvif->mac_addr;
+		mld_tma = sta->addr;
+		mld_bssid = rtwvif->mac_addr;
+	} else {
+		return;
+	}
+
+	h2c->w9 = le32_encode_bits(mld_sma[0], DCTLINFO_V3_W9_MLD_SMA_0_V2) |
+		  le32_encode_bits(mld_sma[1], DCTLINFO_V3_W9_MLD_SMA_1_V2) |
+		  le32_encode_bits(mld_sma[2], DCTLINFO_V3_W9_MLD_SMA_2_V2) |
+		  le32_encode_bits(mld_sma[3], DCTLINFO_V3_W9_MLD_SMA_3_V2);
+	h2c->m9 = cpu_to_le32(DCTLINFO_V3_W9_ALL);
+
+	h2c->w10 = le32_encode_bits(mld_sma[4], DCTLINFO_V3_W10_MLD_SMA_4_V2) |
+		   le32_encode_bits(mld_sma[5], DCTLINFO_V3_W10_MLD_SMA_5_V2) |
+		   le32_encode_bits(mld_tma[0], DCTLINFO_V3_W10_MLD_TMA_0_V2) |
+		   le32_encode_bits(mld_tma[1], DCTLINFO_V3_W10_MLD_TMA_1_V2);
+	h2c->m10 = cpu_to_le32(DCTLINFO_V3_W10_ALL);
+
+	h2c->w11 = le32_encode_bits(mld_tma[2], DCTLINFO_V3_W11_MLD_TMA_2_V2) |
+		   le32_encode_bits(mld_tma[3], DCTLINFO_V3_W11_MLD_TMA_3_V2) |
+		   le32_encode_bits(mld_tma[4], DCTLINFO_V3_W11_MLD_TMA_4_V2) |
+		   le32_encode_bits(mld_tma[5], DCTLINFO_V3_W11_MLD_TMA_5_V2);
+	h2c->m11 = cpu_to_le32(DCTLINFO_V3_W11_ALL);
+
+	h2c->w12 = le32_encode_bits(mld_bssid[0], DCTLINFO_V3_W12_MLD_TA_BSSID_0_V2) |
+		   le32_encode_bits(mld_bssid[1], DCTLINFO_V3_W12_MLD_TA_BSSID_1_V2) |
+		   le32_encode_bits(mld_bssid[2], DCTLINFO_V3_W12_MLD_TA_BSSID_2_V2) |
+		   le32_encode_bits(mld_bssid[3], DCTLINFO_V3_W12_MLD_TA_BSSID_3_V2);
+	h2c->m12 = cpu_to_le32(DCTLINFO_V3_W12_ALL);
+
+	h2c->w13 = le32_encode_bits(mld_bssid[4], DCTLINFO_V3_W13_MLD_TA_BSSID_4_V2) |
+		   le32_encode_bits(mld_bssid[5], DCTLINFO_V3_W13_MLD_TA_BSSID_5_V2);
+	h2c->m13 = cpu_to_le32(DCTLINFO_V3_W13_ALL);
+}
diff --git a/drivers/net/wireless/realtek/rtw89/cam.h b/drivers/net/wireless/realtek/rtw89/cam.h
index c46b6f91bbdb..22868f262243 100644
--- a/drivers/net/wireless/realtek/rtw89/cam.h
+++ b/drivers/net/wireless/realtek/rtw89/cam.h
@@ -302,6 +302,131 @@ struct rtw89_h2c_dctlinfo_ud_v2 {
 #define DCTLINFO_V2_W12_MLD_BSSID_5 GENMASK(15, 8)
 #define DCTLINFO_V2_W12_ALL GENMASK(15, 0)
 
+struct rtw89_h2c_dctlinfo_ud_v3 {
+	__le32 c0;
+	__le32 w0;
+	__le32 w1;
+	__le32 w2;
+	__le32 w3;
+	__le32 w4;
+	__le32 w5;
+	__le32 w6;
+	__le32 w7;
+	__le32 w8;
+	__le32 w9;
+	__le32 w10;
+	__le32 w11;
+	__le32 w12;
+	__le32 w13;
+	__le32 w14;
+	__le32 w15;
+	__le32 m0;
+	__le32 m1;
+	__le32 m2;
+	__le32 m3;
+	__le32 m4;
+	__le32 m5;
+	__le32 m6;
+	__le32 m7;
+	__le32 m8;
+	__le32 m9;
+	__le32 m10;
+	__le32 m11;
+	__le32 m12;
+	__le32 m13;
+	__le32 m14;
+	__le32 m15;
+} __packed;
+
+#define DCTLINFO_V3_C0_MACID GENMASK(15, 0)
+#define DCTLINFO_V3_C0_OP BIT(16)
+
+#define DCTLINFO_V3_W0_QOS_FIELD_H GENMASK(7, 0)
+#define DCTLINFO_V3_W0_HW_EXSEQ_MACID GENMASK(14, 8)
+#define DCTLINFO_V3_W0_QOS_DATA BIT(15)
+#define DCTLINFO_V3_W0_AES_IV_L GENMASK(31, 16)
+#define DCTLINFO_V3_W0_ALL GENMASK(31, 0)
+#define DCTLINFO_V3_W1_AES_IV_H GENMASK(31, 0)
+#define DCTLINFO_V3_W1_ALL GENMASK(31, 0)
+#define DCTLINFO_V3_W2_SEQ0 GENMASK(11, 0)
+#define DCTLINFO_V3_W2_SEQ1 GENMASK(23, 12)
+#define DCTLINFO_V3_W2_AMSDU_MAX_LEN GENMASK(26, 24)
+#define DCTLINFO_V3_W2_STA_AMSDU_EN BIT(27)
+#define DCTLINFO_V3_W2_CHKSUM_OFLD_EN BIT(28)
+#define DCTLINFO_V3_W2_WITH_LLC BIT(29)
+#define DCTLINFO_V3_W2_NAT25_EN BIT(30)
+#define DCTLINFO_V3_W2_IS_MLD BIT(31)
+#define DCTLINFO_V3_W2_ALL GENMASK(31, 0)
+#define DCTLINFO_V3_W3_SEQ2 GENMASK(11, 0)
+#define DCTLINFO_V3_W3_SEQ3 GENMASK(23, 12)
+#define DCTLINFO_V3_W3_TGT_IND GENMASK(27, 24)
+#define DCTLINFO_V3_W3_TGT_IND_EN BIT(28)
+#define DCTLINFO_V3_W3_HTC_LB GENMASK(31, 29)
+#define DCTLINFO_V3_W3_ALL GENMASK(31, 0)
+#define DCTLINFO_V3_W4_VLAN_TAG_SEL GENMASK(7, 5)
+#define DCTLINFO_V3_W4_HTC_ORDER BIT(8)
+#define DCTLINFO_V3_W4_SEC_KEY_ID GENMASK(10, 9)
+#define DCTLINFO_V3_W4_VLAN_RX_DYNAMIC_PCP_EN BIT(11)
+#define DCTLINFO_V3_W4_VLAN_RX_PKT_DROP BIT(12)
+#define DCTLINFO_V3_W4_VLAN_RX_VALID BIT(13)
+#define DCTLINFO_V3_W4_VLAN_TX_VALID BIT(14)
+#define DCTLINFO_V3_W4_WAPI BIT(15)
+#define DCTLINFO_V3_W4_SEC_ENT_MODE GENMASK(17, 16)
+#define DCTLINFO_V3_W4_SEC_ENT0_KEYID GENMASK(19, 18)
+#define DCTLINFO_V3_W4_SEC_ENT1_KEYID GENMASK(21, 20)
+#define DCTLINFO_V3_W4_SEC_ENT2_KEYID GENMASK(23, 22)
+#define DCTLINFO_V3_W4_SEC_ENT3_KEYID GENMASK(25, 24)
+#define DCTLINFO_V3_W4_SEC_ENT4_KEYID GENMASK(27, 26)
+#define DCTLINFO_V3_W4_SEC_ENT5_KEYID GENMASK(29, 28)
+#define DCTLINFO_V3_W4_SEC_ENT6_KEYID GENMASK(31, 30)
+#define DCTLINFO_V3_W4_ALL GENMASK(31, 5)
+#define DCTLINFO_V3_W5_SEC_ENT7_KEYID GENMASK(1, 0)
+#define DCTLINFO_V3_W5_SEC_ENT8_KEYID GENMASK(3, 2)
+#define DCTLINFO_V3_W5_SEC_ENT_VALID_V1 GENMASK(23, 8)
+#define DCTLINFO_V3_W5_ALL (GENMASK(23, 8) | GENMASK(3, 0))
+#define DCTLINFO_V3_W6_SEC_ENT0_V2 GENMASK(8, 0)
+#define DCTLINFO_V3_W6_SEC_ENT1_V2 GENMASK(18, 10)
+#define DCTLINFO_V3_W6_SEC_ENT2_V2 GENMASK(28, 20)
+#define DCTLINFO_V3_W6_ALL GENMASK(28, 0)
+#define DCTLINFO_V3_W7_SEC_ENT3_V2 GENMASK(8, 0)
+#define DCTLINFO_V3_W7_SEC_ENT4_V2 GENMASK(18, 10)
+#define DCTLINFO_V3_W7_SEC_ENT5_V2 GENMASK(28, 20)
+#define DCTLINFO_V3_W7_ALL GENMASK(28, 0)
+#define DCTLINFO_V3_W8_SEC_ENT6_V2 GENMASK(8, 0)
+#define DCTLINFO_V3_W8_SEC_ENT7_V1 GENMASK(18, 10)
+#define DCTLINFO_V3_W8_SEC_ENT8_V1 GENMASK(28, 20)
+#define DCTLINFO_V3_W8_ALL GENMASK(28, 0)
+#define DCTLINFO_V3_W9_MLD_SMA_0_V2 GENMASK(7, 0)
+#define DCTLINFO_V3_W9_MLD_SMA_1_V2 GENMASK(15, 8)
+#define DCTLINFO_V3_W9_MLD_SMA_2_V2 GENMASK(23, 16)
+#define DCTLINFO_V3_W9_MLD_SMA_3_V2 GENMASK(31, 24)
+#define DCTLINFO_V3_W9_MLD_SMA_L_V2 GENMASK(31, 0)
+#define DCTLINFO_V3_W9_ALL GENMASK(31, 0)
+#define DCTLINFO_V3_W10_MLD_SMA_4_V2 GENMASK(7, 0)
+#define DCTLINFO_V3_W10_MLD_SMA_5_V2 GENMASK(15, 8)
+#define DCTLINFO_V3_W10_MLD_SMA_H_V2 GENMASK(15, 0)
+#define DCTLINFO_V3_W10_MLD_TMA_0_V2 GENMASK(23, 16)
+#define DCTLINFO_V3_W10_MLD_TMA_1_V2 GENMASK(31, 24)
+#define DCTLINFO_V3_W10_MLD_TMA_L_V2 GENMASK(31, 16)
+#define DCTLINFO_V3_W10_ALL GENMASK(31, 0)
+#define DCTLINFO_V3_W11_MLD_TMA_2_V2 GENMASK(7, 0)
+#define DCTLINFO_V3_W11_MLD_TMA_3_V2 GENMASK(15, 8)
+#define DCTLINFO_V3_W11_MLD_TMA_4_V2 GENMASK(23, 16)
+#define DCTLINFO_V3_W11_MLD_TMA_5_V2 GENMASK(31, 24)
+#define DCTLINFO_V3_W11_MLD_TMA_H_V2 GENMASK(31, 0)
+#define DCTLINFO_V3_W11_ALL GENMASK(31, 0)
+#define DCTLINFO_V3_W12_MLD_TA_BSSID_0_V2 GENMASK(7, 0)
+#define DCTLINFO_V3_W12_MLD_TA_BSSID_1_V2 GENMASK(15, 8)
+#define DCTLINFO_V3_W12_MLD_TA_BSSID_2_V2 GENMASK(23, 16)
+#define DCTLINFO_V3_W12_MLD_TA_BSSID_3_V2 GENMASK(31, 24)
+#define DCTLINFO_V3_W12_MLD_TA_BSSID_L_V2 GENMASK(31, 0)
+#define DCTLINFO_V3_W12_ALL GENMASK(31, 0)
+#define DCTLINFO_V3_W13_MLD_TA_BSSID_4_V2 GENMASK(7, 0)
+#define DCTLINFO_V3_W13_MLD_TA_BSSID_5_V2 GENMASK(15, 8)
+#define DCTLINFO_V3_W13_MLD_TA_BSSID_H_V2 GENMASK(15, 0)
+#define DCTLINFO_V3_W13_HW_EXSEQ_MACID_V1 GENMASK(24, 16)
+#define DCTLINFO_V3_W13_ALL GENMASK(24, 0)
+
 int rtw89_cam_init(struct rtw89_dev *rtwdev, struct rtw89_vif_link *vif);
 void rtw89_cam_deinit(struct rtw89_dev *rtwdev, struct rtw89_vif_link *vif);
 int rtw89_cam_init_addr_cam(struct rtw89_dev *rtwdev,
@@ -328,6 +453,10 @@ void rtw89_cam_fill_dctl_sec_cam_info_v2(struct rtw89_dev *rtwdev,
 					 struct rtw89_vif_link *rtwvif_link,
 					 struct rtw89_sta_link *rtwsta_link,
 					 struct rtw89_h2c_dctlinfo_ud_v2 *h2c);
+void rtw89_cam_fill_dctl_sec_cam_info_v3(struct rtw89_dev *rtwdev,
+					 struct rtw89_vif_link *rtwvif_link,
+					 struct rtw89_sta_link *rtwsta_link,
+					 struct rtw89_h2c_dctlinfo_ud_v3 *h2c);
 int rtw89_cam_fill_bssid_cam_info(struct rtw89_dev *rtwdev,
 				  struct rtw89_vif_link *rtwvif_link,
 				  struct rtw89_sta_link *rtwsta_link,
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 40e5d5fab651..a8dda05afc3d 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -2277,6 +2277,45 @@ int rtw89_fw_h2c_dctl_sec_cam_v2(struct rtw89_dev *rtwdev,
 }
 EXPORT_SYMBOL(rtw89_fw_h2c_dctl_sec_cam_v2);
 
+int rtw89_fw_h2c_dctl_sec_cam_v3(struct rtw89_dev *rtwdev,
+				 struct rtw89_vif_link *rtwvif_link,
+				 struct rtw89_sta_link *rtwsta_link)
+{
+	struct rtw89_h2c_dctlinfo_ud_v3 *h2c;
+	u32 len = sizeof(*h2c);
+	struct sk_buff *skb;
+	int ret;
+
+	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, len);
+	if (!skb) {
+		rtw89_err(rtwdev, "failed to alloc skb for dctl sec cam\n");
+		return -ENOMEM;
+	}
+	skb_put(skb, len);
+	h2c = (struct rtw89_h2c_dctlinfo_ud_v3 *)skb->data;
+
+	rtw89_cam_fill_dctl_sec_cam_info_v3(rtwdev, rtwvif_link, rtwsta_link, h2c);
+
+	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
+			      H2C_CAT_MAC,
+			      H2C_CL_MAC_FR_EXCHG,
+			      H2C_FUNC_MAC_DCTLINFO_UD_V3, 0, 0,
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
+EXPORT_SYMBOL(rtw89_fw_h2c_dctl_sec_cam_v3);
+
 int rtw89_fw_h2c_default_dmac_tbl_v2(struct rtw89_dev *rtwdev,
 				     struct rtw89_vif_link *rtwvif_link,
 				     struct rtw89_sta_link *rtwsta_link)
@@ -2332,6 +2371,62 @@ int rtw89_fw_h2c_default_dmac_tbl_v2(struct rtw89_dev *rtwdev,
 }
 EXPORT_SYMBOL(rtw89_fw_h2c_default_dmac_tbl_v2);
 
+int rtw89_fw_h2c_default_dmac_tbl_v3(struct rtw89_dev *rtwdev,
+				     struct rtw89_vif_link *rtwvif_link,
+				     struct rtw89_sta_link *rtwsta_link)
+{
+	u8 mac_id = rtwsta_link ? rtwsta_link->mac_id : rtwvif_link->mac_id;
+	struct rtw89_h2c_dctlinfo_ud_v3 *h2c;
+	u32 len = sizeof(*h2c);
+	struct sk_buff *skb;
+	int ret;
+
+	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, len);
+	if (!skb) {
+		rtw89_err(rtwdev, "failed to alloc skb for dctl v2\n");
+		return -ENOMEM;
+	}
+	skb_put(skb, len);
+	h2c = (struct rtw89_h2c_dctlinfo_ud_v3 *)skb->data;
+
+	h2c->c0 = le32_encode_bits(mac_id, DCTLINFO_V3_C0_MACID) |
+		  le32_encode_bits(1, DCTLINFO_V3_C0_OP);
+
+	h2c->m0 = cpu_to_le32(DCTLINFO_V3_W0_ALL);
+	h2c->m1 = cpu_to_le32(DCTLINFO_V3_W1_ALL);
+	h2c->m2 = cpu_to_le32(DCTLINFO_V3_W2_ALL);
+	h2c->m3 = cpu_to_le32(DCTLINFO_V3_W3_ALL);
+	h2c->m4 = cpu_to_le32(DCTLINFO_V3_W4_ALL);
+	h2c->m5 = cpu_to_le32(DCTLINFO_V3_W5_ALL);
+	h2c->m6 = cpu_to_le32(DCTLINFO_V3_W6_ALL);
+	h2c->m7 = cpu_to_le32(DCTLINFO_V3_W7_ALL);
+	h2c->m8 = cpu_to_le32(DCTLINFO_V3_W8_ALL);
+	h2c->m9 = cpu_to_le32(DCTLINFO_V3_W9_ALL);
+	h2c->m10 = cpu_to_le32(DCTLINFO_V3_W10_ALL);
+	h2c->m11 = cpu_to_le32(DCTLINFO_V3_W11_ALL);
+	h2c->m12 = cpu_to_le32(DCTLINFO_V3_W12_ALL);
+	h2c->m13 = cpu_to_le32(DCTLINFO_V3_W13_ALL);
+
+	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
+			      H2C_CAT_MAC,
+			      H2C_CL_MAC_FR_EXCHG,
+			      H2C_FUNC_MAC_DCTLINFO_UD_V3, 0, 0,
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
+EXPORT_SYMBOL(rtw89_fw_h2c_default_dmac_tbl_v3);
+
 int rtw89_fw_h2c_ba_cam(struct rtw89_dev *rtwdev,
 			struct rtw89_vif_link *rtwvif_link,
 			struct rtw89_sta_link *rtwsta_link,
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 6a297fad148b..479df9df0b28 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -4335,6 +4335,7 @@ enum rtw89_ps_h2c_func {
 #define H2C_FUNC_MAC_CCTLINFO_UD_V1	0xa
 #define H2C_FUNC_MAC_DCTLINFO_UD_V2	0xc
 #define H2C_FUNC_MAC_BCN_UPD_BE		0xd
+#define H2C_FUNC_MAC_DCTLINFO_UD_V3	0x10
 #define H2C_FUNC_MAC_CCTLINFO_UD_G7	0x11
 
 /* CLASS 6 - Address CAM */
@@ -4849,6 +4850,9 @@ int rtw89_fw_h2c_default_cmac_tbl_g7(struct rtw89_dev *rtwdev,
 int rtw89_fw_h2c_default_dmac_tbl_v2(struct rtw89_dev *rtwdev,
 				     struct rtw89_vif_link *rtwvif_link,
 				     struct rtw89_sta_link *rtwsta_link);
+int rtw89_fw_h2c_default_dmac_tbl_v3(struct rtw89_dev *rtwdev,
+				     struct rtw89_vif_link *rtwvif_link,
+				     struct rtw89_sta_link *rtwsta_link);
 int rtw89_fw_h2c_assoc_cmac_tbl(struct rtw89_dev *rtwdev,
 				struct rtw89_vif_link *rtwvif_link,
 				struct rtw89_sta_link *rtwsta_link);
@@ -4883,6 +4887,9 @@ int rtw89_fw_h2c_dctl_sec_cam_v1(struct rtw89_dev *rtwdev,
 int rtw89_fw_h2c_dctl_sec_cam_v2(struct rtw89_dev *rtwdev,
 				 struct rtw89_vif_link *rtwvif_link,
 				 struct rtw89_sta_link *rtwsta_link);
+int rtw89_fw_h2c_dctl_sec_cam_v3(struct rtw89_dev *rtwdev,
+				 struct rtw89_vif_link *rtwvif_link,
+				 struct rtw89_sta_link *rtwsta_link);
 void rtw89_fw_c2h_irqsafe(struct rtw89_dev *rtwdev, struct sk_buff *c2h);
 void rtw89_fw_c2h_work(struct wiphy *wiphy, struct wiphy_work *work);
 void rtw89_fw_c2h_purge_obsoleted_scan_events(struct rtw89_dev *rtwdev);
-- 
2.25.1


