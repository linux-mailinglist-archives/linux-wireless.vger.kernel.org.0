Return-Path: <linux-wireless+bounces-28957-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 979C3C5B776
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Nov 2025 07:06:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0706B3BE5E0
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Nov 2025 06:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C4902EB857;
	Fri, 14 Nov 2025 06:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="Ok1droud"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9CC2DF71C
	for <linux-wireless@vger.kernel.org>; Fri, 14 Nov 2025 06:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763100182; cv=none; b=cgRXOi6b6DNCIFFj2W0Sy/EhsO3Doee/41nxGin/vYclL0qTDOmgpPsMdGQRft9QIUFFOqq7vQNNLEkUvQW43Xh+gBPqekNN11r4RIUz0TBIYJAj/AHd8tZVqo595NbnZTd7wWHPzFNxJT8ouO4dqMrJNrr+0/1OZDE/UYK1734=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763100182; c=relaxed/simple;
	bh=yQAPG66ZblieV+6+KL9bQWT18CcFqh6uRvVqDtSHWA8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rdFWuTEttNI5+3G3MAqW0kbFdZezrw+EG5lOgeh9Lur3SxjBBSRT1xXznu+7j4q7PFj5vUO7bwEWZ+JyNzvTFQjFbbMb+bxDhT8Hb1Lvi6UpoWp+TcXEKVHrylIFFAdFXAk8LmGWrs/JciIXx2VVOWH6RTefEnURHqNXGF3Gjmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=Ok1droud; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5AE62vr861038296, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1763100177; bh=XF2JtMPQ5ZC+As6R0o38gl0g7OzpXcfvEaDaZq1KWrc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=Ok1droudz/RO35jeL3w+HjudkK7D+rg/9Uri9PRMq9RzVPbOYL+g6B3Bl8wCsA4X+
	 M+ap3DfbrB6EeaLlEqdM0aL7Vv8uGGaIP52PvfcS7KASF0FTtlmxZThiHIU9sypL97
	 Qp0kabuXQGIsn6dDAgyfZ9g4lWhgFfICvHJlFP86DdNuB/pSfhqZ5MyLw6tB9oFycG
	 ikWBTFmCTbWX6jiAiapL9m9YbebbF/zEbkE8OM7WbVajNNBJ3+cq0lXys/XcCnPhTq
	 VuV+/vRZIkSRXzlUwgXxkqFDS+GFToSOiWLcTTIJo/to2XzOwv8mGi6/ejBrsj+MR/
	 gJ1K6O0R0nLfQ==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5AE62vr861038296
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 14 Nov 2025 14:02:57 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Fri, 14 Nov 2025 14:02:57 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27 via Frontend
 Transport; Fri, 14 Nov 2025 14:02:57 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>
Subject: [PATCH v2 rtw-next 10/14] wifi: rtw89: align RA H2C format v1 for RTL8922A
Date: Fri, 14 Nov 2025 14:01:24 +0800
Message-ID: <20251114060128.35363-11-pkshih@realtek.com>
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

For RTL8922A, the bits [16:31] of word 3 of v1 format isn't as WiFi 6
chips. Instead, it only needs to fill additional band type and partial
bandwidth ER.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2: no change
---
 drivers/net/wireless/realtek/rtw89/core.h |  9 ++++++-
 drivers/net/wireless/realtek/rtw89/fw.c   | 33 ++++++++++++++---------
 drivers/net/wireless/realtek/rtw89/fw.h   |  7 +++++
 drivers/net/wireless/realtek/rtw89/phy.c  |  4 +++
 4 files changed, 39 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 8943166de52c..1f99d5f264d2 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3384,11 +3384,18 @@ struct rtw89_ra_info {
 	u8 cr_tbl_sel:1;
 	u8 fix_giltf_en:1;
 	u8 fix_giltf:3;
-	u8 rsvd2:1;
+	u8 partial_bw_er:1;
 	u8 csi_mcs_ss_idx;
 	u8 csi_mode:2;
 	u8 csi_gi_ltf:3;
 	u8 csi_bw:3;
+	/* after v1 */
+	u8 is_noisy:1;
+	u8 psra_en:1;
+	u8 rsvd0:1;
+	u8 macid_msb:2;
+	u8 band:2; /* enum rtw89_band */
+	u8 is_new_dbgreg:1;
 };
 
 #define RTW89_PPDU_MAC_INFO_USR_SIZE 4
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index b234df109634..0dc5aa5ed218 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -4739,13 +4739,16 @@ int rtw89_fw_h2c_ra(struct rtw89_dev *rtwdev, struct rtw89_ra_info *ra, bool csi
 	struct rtw89_h2c_ra_v1 *h2c_v1;
 	struct rtw89_h2c_ra *h2c;
 	u32 len = sizeof(*h2c);
-	bool format_v1 = false;
 	struct sk_buff *skb;
+	u8 ver = U8_MAX;
 	int ret;
 
-	if (chip->chip_gen == RTW89_CHIP_BE) {
+	if (chip->chip_gen == RTW89_CHIP_AX) {
+		len = sizeof(*h2c);
+		ver = 0;
+	} else {
 		len = sizeof(*h2c_v1);
-		format_v1 = true;
+		ver = 1;
 	}
 
 	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, len);
@@ -4777,16 +4780,8 @@ int rtw89_fw_h2c_ra(struct rtw89_dev *rtwdev, struct rtw89_ra_info *ra, bool csi
 	h2c->w3 = le32_encode_bits(ra->fix_giltf_en, RTW89_H2C_RA_W3_FIX_GILTF_EN) |
 		  le32_encode_bits(ra->fix_giltf, RTW89_H2C_RA_W3_FIX_GILTF);
 
-	if (!format_v1)
-		goto csi;
-
-	h2c_v1 = (struct rtw89_h2c_ra_v1 *)h2c;
-	h2c_v1->w4 = le32_encode_bits(ra->mode_ctrl, RTW89_H2C_RA_V1_W4_MODE_EHT) |
-		     le32_encode_bits(ra->bw_cap, RTW89_H2C_RA_V1_W4_BW_EHT);
-
-csi:
-	if (!csi)
-		goto done;
+	if (!csi || ver >= 1)
+		goto next_v1;
 
 	h2c->w2 |= le32_encode_bits(1, RTW89_H2C_RA_W2_BFEE_CSI_CTL);
 	h2c->w3 |= le32_encode_bits(ra->band_num, RTW89_H2C_RA_W3_BAND_NUM) |
@@ -4798,6 +4793,18 @@ int rtw89_fw_h2c_ra(struct rtw89_dev *rtwdev, struct rtw89_ra_info *ra, bool csi
 		   le32_encode_bits(ra->csi_gi_ltf, RTW89_H2C_RA_W3_FIXED_CSI_GI_LTF) |
 		   le32_encode_bits(ra->csi_bw, RTW89_H2C_RA_W3_FIXED_CSI_BW);
 
+next_v1:
+	if (ver < 1)
+		goto done;
+
+	h2c->w3 |= le32_encode_bits(ra->partial_bw_er,
+				    RTW89_H2C_RA_V1_W3_PARTIAL_BW_SU_ER) |
+		   le32_encode_bits(ra->band, RTW89_H2C_RA_V1_W3_BAND);
+
+	h2c_v1 = (struct rtw89_h2c_ra_v1 *)h2c;
+	h2c_v1->w4 = le32_encode_bits(ra->mode_ctrl, RTW89_H2C_RA_V1_W4_MODE_EHT) |
+		     le32_encode_bits(ra->bw_cap, RTW89_H2C_RA_V1_W4_BW_EHT);
+
 done:
 	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
 			      H2C_CAT_OUTSRC, H2C_CL_OUTSRC_RA,
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index bb3e7bbb41de..e62b61f584fb 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -447,6 +447,13 @@ struct rtw89_h2c_ra {
 #define RTW89_H2C_RA_W3_FIXED_CSI_MODE GENMASK(25, 24)
 #define RTW89_H2C_RA_W3_FIXED_CSI_GI_LTF GENMASK(28, 26)
 #define RTW89_H2C_RA_W3_FIXED_CSI_BW GENMASK(31, 29)
+#define RTW89_H2C_RA_V1_W3_PARTIAL_BW_SU_ER BIT(15)
+#define RTW89_H2C_RA_V1_W3_FIXED_CSI_RATE_L GENMASK(23, 16)
+#define RTW89_H2C_RA_V1_W3_IS_NOISY BIT(24)
+#define RTW89_H2C_RA_V1_W3_PSRA_EN BIT(25)
+#define RTW89_H2C_RA_V1_W3_MACID_MSB GENMASK(28, 27)
+#define RTW89_H2C_RA_V1_W3_BAND GENMASK(30, 29)
+#define RTW89_H2C_RA_V1_W3_NEW_DBGREG BIT(31)
 
 struct rtw89_h2c_ra_v1 {
 	struct rtw89_h2c_ra v0;
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index 08eb3fa6b347..9f418b1fb7ed 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -476,6 +476,10 @@ static void rtw89_phy_ra_sta_update(struct rtw89_dev *rtwdev,
 	ra->ra_mask = ra_mask;
 	ra->fix_giltf_en = fix_giltf_en;
 	ra->fix_giltf = fix_giltf;
+	ra->partial_bw_er = link_sta->he_cap.has_he ?
+			    !!(link_sta->he_cap.he_cap_elem.phy_cap_info[6] &
+			       IEEE80211_HE_PHY_CAP6_PARTIAL_BW_EXT_RANGE) : 0;
+	ra->band = chan->band_type;
 
 	if (!csi)
 		return;
-- 
2.25.1


