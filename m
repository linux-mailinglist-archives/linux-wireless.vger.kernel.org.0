Return-Path: <linux-wireless+bounces-30557-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 838A1D03C35
	for <lists+linux-wireless@lfdr.de>; Thu, 08 Jan 2026 16:20:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 327AB323197C
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Jan 2026 14:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 598EF497B31;
	Thu,  8 Jan 2026 12:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="d8Ttehey"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533AB480326
	for <linux-wireless@vger.kernel.org>; Thu,  8 Jan 2026 12:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767873878; cv=none; b=gPAetbLy7zwznLXFZZiEY7uYYsiRwFKiJIs6f2UzpPv/3+xYCDOVkeg4c2+XgBb0r48I5z7d+lYT8ErY8AHpuzCiX6meMXw8SUGo+q+Qgec3bqOIFUO0keH2dpWJaIHEpabJuF7HRStACo0fOSwKGzGvJLrV9JM3avUCbkrTKJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767873878; c=relaxed/simple;
	bh=iv0p9IuDHGnva+udHwrSzF+7+6r3Oxh0T2C413wv6nM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M7m2KLGbmJUc6cxl2u+0WxaMFXaYxz4IfFv1xHNyTat4UGuQ7rFkfFoZSbANxdBzly0Z0MccGvluvyY2drSEEk3ez5oASY8Fh+fWlFbAlx+03tTzmqFDsJ5LTSCyhbvJfOss75myzUkjsjX1xlOOVz4W5WY29g8d2n1RtM1w2hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=d8Ttehey; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 608C4SvA4970713, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1767873868; bh=KCzIgQmRmjObMQ3Dc6dP4AZhVSIdpfUAQ55h0KdoBls=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=d8TteheykLVvhVtvd+KjcUSNUPNxKyxPPwxg0ZuG6G7xoE/4WUZUtgV1VrsI1EwHo
	 dkN9NPp/m6ZYpDfDffXFzZMA69vbTXGviuHliyZv8Zv2/vHMZjDNP8tWrO8gi7GbU+
	 X7z9USE22WCgZ3nb43LwO4zfL3yFxkyQ7uA2gUUEdNGGZUtLp9AXhrl1bReX7LsrDs
	 B4mxijk/9Ti9RyRSW6Vkj8crbm8xD1EThAR8kcdItdwa3e9Fp6b7OVYRDAPgP4EfUI
	 ufOquP/0kis6MB/tdGTkyI6dfbu8yeuGhZg1QaOhxJUBLBo5/M2nCuS7EPryqvC9LN
	 uVsH4ZlO1n1Xg==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 608C4SvA4970713
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 8 Jan 2026 20:04:28 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 8 Jan 2026 20:04:28 +0800
Received: from [127.0.1.1] (172.21.40.76) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Thu, 8 Jan 2026 20:04:28 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <leo.li@realtek.com>
Subject: [PATCH rtw-next 13/13] wifi: rtw89: mac: set EDCCA configurations for RTL8922D
Date: Thu, 8 Jan 2026 20:03:20 +0800
Message-ID: <20260108120320.2217402-14-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260108120320.2217402-1-pkshih@realtek.com>
References: <20260108120320.2217402-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Update EDCCA settings of MAC part for RTL8922D to consider EDCCA state
signaled by BB circuit.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c   |   1 +
 drivers/net/wireless/realtek/rtw89/mac.c    |   1 +
 drivers/net/wireless/realtek/rtw89/mac.h    |  27 +++
 drivers/net/wireless/realtek/rtw89/mac_be.c |  60 +++++++
 drivers/net/wireless/realtek/rtw89/reg.h    | 184 ++++++++++++++++++++
 5 files changed, 273 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 6811a3970ddb..529adf1d0f6e 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -5686,6 +5686,7 @@ int rtw89_core_start(struct rtw89_dev *rtwdev)
 
 	rtw89_phy_dm_init(rtwdev);
 
+	rtw89_mac_set_edcca_mode_bands(rtwdev, true);
 	rtw89_mac_cfg_ppdu_status_bands(rtwdev, true);
 	rtw89_mac_cfg_phy_rpt_bands(rtwdev, true);
 	rtw89_mac_update_rts_threshold(rtwdev);
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index f484e81d6595..3b9c6f9b7f5a 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -7309,6 +7309,7 @@ const struct rtw89_mac_gen_def rtw89_mac_gen_ax = {
 	.typ_fltr_opt = rtw89_mac_typ_fltr_opt_ax,
 	.cfg_ppdu_status = rtw89_mac_cfg_ppdu_status_ax,
 	.cfg_phy_rpt = NULL,
+	.set_edcca_mode = NULL,
 
 	.dle_mix_cfg = dle_mix_cfg_ax,
 	.chk_dle_rdy = chk_dle_rdy_ax,
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index c5630ec88383..c9dbd1549b5b 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -1055,6 +1055,7 @@ struct rtw89_mac_gen_def {
 			    u8 mac_idx);
 	int (*cfg_ppdu_status)(struct rtw89_dev *rtwdev, u8 mac_idx, bool enable);
 	void (*cfg_phy_rpt)(struct rtw89_dev *rtwdev, u8 mac_idx, bool enable);
+	void (*set_edcca_mode)(struct rtw89_dev *rtwdev, u8 mac_idx, bool normal);
 
 	int (*dle_mix_cfg)(struct rtw89_dev *rtwdev, const struct rtw89_dle_mem *cfg);
 	int (*chk_dle_rdy)(struct rtw89_dev *rtwdev, bool wde_or_ple);
@@ -1129,6 +1130,14 @@ u32 rtw89_mac_reg_by_idx(struct rtw89_dev *rtwdev, u32 reg_base, u8 band)
 	return band == 0 ? reg_base : (reg_base + mac->band1_offset);
 }
 
+static inline void
+rtw89_write16_idx(struct rtw89_dev *rtwdev, u32 addr, u16 data, u8 band)
+{
+	addr = rtw89_mac_reg_by_idx(rtwdev, addr, band);
+
+	rtw89_write16(rtwdev, addr, data);
+}
+
 static inline
 u32 rtw89_mac_reg_by_port(struct rtw89_dev *rtwdev, u32 base, u8 port, u8 mac_idx)
 {
@@ -1364,6 +1373,24 @@ int rtw89_mac_cfg_ppdu_status_bands(struct rtw89_dev *rtwdev, bool enable)
 	return rtw89_mac_cfg_ppdu_status(rtwdev, RTW89_MAC_1, enable);
 }
 
+static inline
+void rtw89_mac_set_edcca_mode(struct rtw89_dev *rtwdev, u8 mac_idx, bool normal)
+{
+	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
+
+	if (!mac->set_edcca_mode)
+		return;
+
+	mac->set_edcca_mode(rtwdev, mac_idx, normal);
+}
+
+static inline
+void rtw89_mac_set_edcca_mode_bands(struct rtw89_dev *rtwdev, bool normal)
+{
+	rtw89_mac_set_edcca_mode(rtwdev, RTW89_MAC_0, normal);
+	rtw89_mac_set_edcca_mode(rtwdev, RTW89_MAC_1, normal);
+}
+
 void rtw89_mac_set_rx_fltr(struct rtw89_dev *rtwdev, u8 mac_idx, u32 rx_fltr);
 void rtw89_mac_update_rts_threshold(struct rtw89_dev *rtwdev);
 void rtw89_mac_flush_txq(struct rtw89_dev *rtwdev, u32 queues, bool drop);
diff --git a/drivers/net/wireless/realtek/rtw89/mac_be.c b/drivers/net/wireless/realtek/rtw89/mac_be.c
index 35c16bcca3b7..58135864786f 100644
--- a/drivers/net/wireless/realtek/rtw89/mac_be.c
+++ b/drivers/net/wireless/realtek/rtw89/mac_be.c
@@ -2391,6 +2391,65 @@ void rtw89_mac_cfg_phy_rpt_be(struct rtw89_dev *rtwdev, u8 mac_idx, bool enable)
 }
 EXPORT_SYMBOL(rtw89_mac_cfg_phy_rpt_be);
 
+static
+void rtw89_mac_set_edcca_mode_be(struct rtw89_dev *rtwdev, u8 mac_idx, bool normal)
+{
+	u16 resp_ack, resp_rts, resp_rts_punc, resp_normal, resp_normal_punc;
+
+	if (rtwdev->chip->chip_id == RTL8922A)
+		return;
+
+	resp_ack = RESP_ACK_CFG_BE;
+	resp_rts = RESP_RTS_CFG_BE;
+	resp_rts_punc = RESP_RTS_PUNC_CFG_BE;
+	resp_normal = RESP_NORMAL_CFG_BE;
+	resp_normal_punc = RESP_NORMAL_PUNC_CFG_BE;
+
+	if (normal) {
+		rtw89_write16_idx(rtwdev, R_BE_WMAC_ACK_BA_RESP_LEGACY,
+				  resp_ack, mac_idx);
+		rtw89_write16_idx(rtwdev, R_BE_WMAC_ACK_BA_RESP_HE,
+				  resp_ack, mac_idx);
+		rtw89_write16_idx(rtwdev, R_BE_WMAC_ACK_BA_RESP_EHT_LEG_PUNC,
+				  resp_ack, mac_idx);
+		rtw89_write16_idx(rtwdev, R_BE_WMAC_RX_RTS_RESP_LEGACY,
+				  resp_rts, mac_idx);
+		rtw89_write16_idx(rtwdev, R_BE_WMAC_RX_RTS_RESP_LEGACY_PUNC,
+				  resp_rts_punc, mac_idx);
+		rtw89_write16_idx(rtwdev, R_BE_WMAC_RX_MURTS_RESP_LEGACY,
+				  resp_normal, mac_idx);
+		rtw89_write16_idx(rtwdev, R_BE_WMAC_RX_MURTS_RESP_LEGACY_PUNC,
+				  resp_normal_punc, mac_idx);
+		rtw89_write16_idx(rtwdev, R_BE_WMAC_OTHERS_RESP_LEGACY,
+				  resp_normal, mac_idx);
+		rtw89_write16_idx(rtwdev, R_BE_WMAC_OTHERS_RESP_HE,
+				  resp_normal_punc, mac_idx);
+		rtw89_write16_idx(rtwdev, R_BE_WMAC_OTHERS_RESP_EHT_LEG_PUNC,
+				  resp_normal_punc, mac_idx);
+	} else {
+		rtw89_write16_idx(rtwdev, R_BE_WMAC_ACK_BA_RESP_LEGACY,
+				  resp_normal, mac_idx);
+		rtw89_write16_idx(rtwdev, R_BE_WMAC_ACK_BA_RESP_HE,
+				  resp_normal_punc, mac_idx);
+		rtw89_write16_idx(rtwdev, R_BE_WMAC_ACK_BA_RESP_EHT_LEG_PUNC,
+				  resp_normal_punc, mac_idx);
+		rtw89_write16_idx(rtwdev, R_BE_WMAC_RX_RTS_RESP_LEGACY,
+				  resp_rts, mac_idx);
+		rtw89_write16_idx(rtwdev, R_BE_WMAC_RX_RTS_RESP_LEGACY_PUNC,
+				  resp_rts_punc, mac_idx);
+		rtw89_write16_idx(rtwdev, R_BE_WMAC_RX_MURTS_RESP_LEGACY,
+				  resp_normal, mac_idx);
+		rtw89_write16_idx(rtwdev, R_BE_WMAC_RX_MURTS_RESP_LEGACY_PUNC,
+				  resp_normal_punc, mac_idx);
+		rtw89_write16_idx(rtwdev, R_BE_WMAC_OTHERS_RESP_LEGACY,
+				  resp_normal, mac_idx);
+		rtw89_write16_idx(rtwdev, R_BE_WMAC_OTHERS_RESP_HE,
+				  resp_normal_punc, mac_idx);
+		rtw89_write16_idx(rtwdev, R_BE_WMAC_OTHERS_RESP_EHT_LEG_PUNC,
+				  resp_normal_punc, mac_idx);
+	}
+}
+
 static
 int rtw89_mac_cfg_ppdu_status_be(struct rtw89_dev *rtwdev, u8 mac_idx, bool enable)
 {
@@ -2993,6 +3052,7 @@ const struct rtw89_mac_gen_def rtw89_mac_gen_be = {
 	.typ_fltr_opt = rtw89_mac_typ_fltr_opt_be,
 	.cfg_ppdu_status = rtw89_mac_cfg_ppdu_status_be,
 	.cfg_phy_rpt = rtw89_mac_cfg_phy_rpt_be,
+	.set_edcca_mode = rtw89_mac_set_edcca_mode_be,
 
 	.dle_mix_cfg = dle_mix_cfg_be,
 	.chk_dle_rdy = chk_dle_rdy_be,
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 8233841bb8ff..0555d2c0dee9 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -7488,6 +7488,8 @@
 #define B_BE_ACK_BA_RESP_LEGACY_CHK_SEC_CCA20 BIT(2)
 #define B_BE_ACK_BA_RESP_LEGACY_CHK_EDCCA BIT(1)
 #define B_BE_ACK_BA_RESP_LEGACY_CHK_CCA BIT(0)
+#define RESP_ACK_CFG_BE (B_BE_ACK_BA_RESP_LEGACY_CHK_BTCCA | \
+			 B_BE_ACK_BA_RESP_LEGACY_CHK_TX_NAV)
 
 #define R_BE_WMAC_ACK_BA_RESP_HE 0x11204
 #define R_BE_WMAC_ACK_BA_RESP_HE_C1 0x15204
@@ -7529,6 +7531,188 @@
 #define B_BE_ACK_BA_EHT_LEG_PUNC_CHK_EDCCA BIT(1)
 #define B_BE_ACK_BA_EHT_LEG_PUNC_CHK_CCA BIT(0)
 
+#define R_BE_WMAC_RX_RTS_RESP_LEGACY 0x1120C
+#define R_BE_WMAC_RX_RTS_RESP_LEGACY_C1 0x1520C
+#define B_BE_RX_RTS_RESP_LEGACY_CHK_NSTR BIT(16)
+#define B_BE_RX_RTS_RESP_LEGACY_CHK_TX_NAV BIT(15)
+#define B_BE_RX_RTS_RESP_LEGACY_CHK_INTRA_NAV BIT(14)
+#define B_BE_RX_RTS_RESP_LEGACY_CHK_BASIC_NAV BIT(13)
+#define B_BE_RX_RTS_RESP_LEGACY_CHK_BTCCA BIT(12)
+#define B_BE_RX_RTS_RESP_LEGACY_CHK_SEC_EDCCA160 BIT(11)
+#define B_BE_RX_RTS_RESP_LEGACY_CHK_SEC_EDCCA80 BIT(10)
+#define B_BE_RX_RTS_RESP_LEGACY_CHK_SEC_EDCCA40 BIT(9)
+#define B_BE_RX_RTS_RESP_LEGACY_CHK_SEC_EDCCA20 BIT(8)
+#define B_BE_RX_RTS_RESP_LEGACY_CHK_EDCCA_PER20_BMP BIT(7)
+#define B_BE_RX_RTS_RESP_LEGACY_CHK_CCA_PER20_BMP BIT(6)
+#define B_BE_RX_RTS_RESP_LEGACY_CHK_SEC_CCA160 BIT(5)
+#define B_BE_RX_RTS_RESP_LEGACY_CHK_SEC_CCA80 BIT(4)
+#define B_BE_RX_RTS_RESP_LEGACY_CHK_SEC_CCA40 BIT(3)
+#define B_BE_RX_RTS_RESP_LEGACY_CHK_SEC_CCA20 BIT(2)
+#define B_BE_RX_RTS_RESP_LEGACY_CHK_EDCCA BIT(1)
+#define B_BE_RX_RTS_RESP_LEGACY_CHK_CCA BIT(0)
+#define RESP_RTS_CFG_BE (B_BE_RX_RTS_RESP_LEGACY_CHK_CCA | \
+			 B_BE_RX_RTS_RESP_LEGACY_CHK_EDCCA | \
+			 B_BE_RX_RTS_RESP_LEGACY_CHK_SEC_CCA20 | \
+			 B_BE_RX_RTS_RESP_LEGACY_CHK_SEC_CCA40 | \
+			 B_BE_RX_RTS_RESP_LEGACY_CHK_SEC_CCA80 | \
+			 B_BE_RX_RTS_RESP_LEGACY_CHK_SEC_CCA160 | \
+			 B_BE_RX_RTS_RESP_LEGACY_CHK_SEC_EDCCA20 | \
+			 B_BE_RX_RTS_RESP_LEGACY_CHK_SEC_EDCCA40 | \
+			 B_BE_RX_RTS_RESP_LEGACY_CHK_SEC_EDCCA80 | \
+			 B_BE_RX_RTS_RESP_LEGACY_CHK_SEC_EDCCA160 | \
+			 B_BE_RX_RTS_RESP_LEGACY_CHK_BTCCA | \
+			 B_BE_RX_RTS_RESP_LEGACY_CHK_BASIC_NAV | \
+			 B_BE_RX_RTS_RESP_LEGACY_CHK_INTRA_NAV | \
+			 B_BE_RX_RTS_RESP_LEGACY_CHK_TX_NAV)
+#define RESP_RTS_PUNC_CFG_BE (B_BE_RX_RTS_RESP_LEGACY_CHK_CCA | \
+			      B_BE_RX_RTS_RESP_LEGACY_CHK_EDCCA | \
+			      B_BE_RX_RTS_RESP_LEGACY_CHK_CCA_PER20_BMP | \
+			      B_BE_RX_RTS_RESP_LEGACY_CHK_EDCCA_PER20_BMP | \
+			      B_BE_RX_RTS_RESP_LEGACY_CHK_BTCCA | \
+			      B_BE_RX_RTS_RESP_LEGACY_CHK_BASIC_NAV | \
+			      B_BE_RX_RTS_RESP_LEGACY_CHK_INTRA_NAV | \
+			      B_BE_RX_RTS_RESP_LEGACY_CHK_TX_NAV)
+#define RESP_NORMAL_CFG_BE (B_BE_RX_RTS_RESP_LEGACY_CHK_CCA | \
+			    B_BE_RX_RTS_RESP_LEGACY_CHK_EDCCA | \
+			    B_BE_RX_RTS_RESP_LEGACY_CHK_SEC_CCA20 | \
+			    B_BE_RX_RTS_RESP_LEGACY_CHK_SEC_CCA40 | \
+			    B_BE_RX_RTS_RESP_LEGACY_CHK_SEC_CCA80 | \
+			    B_BE_RX_RTS_RESP_LEGACY_CHK_SEC_CCA160 | \
+			    B_BE_RX_RTS_RESP_LEGACY_CHK_SEC_EDCCA20 | \
+			    B_BE_RX_RTS_RESP_LEGACY_CHK_SEC_EDCCA40 | \
+			    B_BE_RX_RTS_RESP_LEGACY_CHK_SEC_EDCCA80 | \
+			    B_BE_RX_RTS_RESP_LEGACY_CHK_SEC_EDCCA160 | \
+			    B_BE_RX_RTS_RESP_LEGACY_CHK_BTCCA | \
+			    B_BE_RX_RTS_RESP_LEGACY_CHK_BASIC_NAV | \
+			    B_BE_RX_RTS_RESP_LEGACY_CHK_TX_NAV)
+#define RESP_NORMAL_PUNC_CFG_BE (B_BE_RX_RTS_RESP_LEGACY_CHK_CCA | \
+				 B_BE_RX_RTS_RESP_LEGACY_CHK_EDCCA | \
+				 B_BE_RX_RTS_RESP_LEGACY_CHK_CCA_PER20_BMP | \
+				 B_BE_RX_RTS_RESP_LEGACY_CHK_EDCCA_PER20_BMP | \
+				 B_BE_RX_RTS_RESP_LEGACY_CHK_BTCCA | \
+				 B_BE_RX_RTS_RESP_LEGACY_CHK_BASIC_NAV | \
+				 B_BE_RX_RTS_RESP_LEGACY_CHK_TX_NAV)
+
+#define R_BE_WMAC_RX_RTS_RESP_LEGACY_PUNC 0x11210
+#define R_BE_WMAC_RX_RTS_RESP_LEGACY_PUNC_C1 0x15210
+#define B_BE_RX_RTS_RESP_LEGACY_PUNC_CHK_NSTR BIT(16)
+#define B_BE_RX_RTS_RESP_LEGACY_PUNC_CHK_TX_NAV BIT(15)
+#define B_BE_RX_RTS_RESP_LEGACY_PUNC_CHK_INTRA_NAV BIT(14)
+#define B_BE_RX_RTS_RESP_LEGACY_PUNC_CHK_BASIC_NAV BIT(13)
+#define B_BE_RX_RTS_RESP_LEGACY_PUNC_CHK_BTCCA BIT(12)
+#define B_BE_RX_RTS_RESP_LEGACY_PUNC_CHK_SEC_EDCCA160 BIT(11)
+#define B_BE_RX_RTS_RESP_LEGACY_PUNC_CHK_SEC_EDCCA80 BIT(10)
+#define B_BE_RX_RTS_RESP_LEGACY_PUNC_CHK_SEC_EDCCA40 BIT(9)
+#define B_BE_RX_RTS_RESP_LEGACY_PUNC_CHK_SEC_EDCCA20 BIT(8)
+#define B_BE_RX_RTS_RESP_LEGACY_PUNC_CHK_EDCCA_PER20_BMP BIT(7)
+#define B_BE_RX_RTS_RESP_LEGACY_PUNC_CHK_CCA_PER20_BMP BIT(6)
+#define B_BE_RX_RTS_RESP_LEGACY_PUNC_CHK_SEC_CCA160 BIT(5)
+#define B_BE_RX_RTS_RESP_LEGACY_PUNC_CHK_SEC_CCA80 BIT(4)
+#define B_BE_RX_RTS_RESP_LEGACY_PUNC_CHK_SEC_CCA40 BIT(3)
+#define B_BE_RX_RTS_RESP_LEGACY_PUNC_CHK_SEC_CCA20 BIT(2)
+#define B_BE_RX_RTS_RESP_LEGACY_PUNC_CHK_EDCCA BIT(1)
+#define B_BE_RX_RTS_RESP_LEGACY_PUNC_CHK_CCA BIT(0)
+
+#define R_BE_WMAC_RX_MURTS_RESP_LEGACY 0x11214
+#define R_BE_WMAC_RX_MURTS_RESP_LEGACY_C1 0x15214
+#define B_BE_MURTS_RESP_LEGACY_CHK_NSTR BIT(16)
+#define B_BE_MURTS_RESP_LEGACY_CHK_TX_NAV BIT(15)
+#define B_BE_MURTS_RESP_LEGACY_CHK_INTRA_NAV BIT(14)
+#define B_BE_MURTS_RESP_LEGACY_CHK_BASIC_NAV BIT(13)
+#define B_BE_MURTS_RESP_LEGACY_CHK_BTCCA BIT(12)
+#define B_BE_MURTS_RESP_LEGACY_CHK_SEC_EDCCA160 BIT(11)
+#define B_BE_MURTS_RESP_LEGACY_CHK_SEC_EDCCA80 BIT(10)
+#define B_BE_MURTS_RESP_LEGACY_CHK_SEC_EDCCA40 BIT(9)
+#define B_BE_MURTS_RESP_LEGACY_CHK_SEC_EDCCA20 BIT(8)
+#define B_BE_MURTS_RESP_LEGACY_CHK_EDCCA_PER20_BMP BIT(7)
+#define B_BE_MURTS_RESP_LEGACY_CHK_CCA_PER20_BMP BIT(6)
+#define B_BE_MURTS_RESP_LEGACY_CHK_SEC_CCA160 BIT(5)
+#define B_BE_MURTS_RESP_LEGACY_CHK_SEC_CCA80 BIT(4)
+#define B_BE_MURTS_RESP_LEGACY_CHK_SEC_CCA40 BIT(3)
+#define B_BE_MURTS_RESP_LEGACY_CHK_SEC_CCA20 BIT(2)
+#define B_BE_MURTS_RESP_LEGACY_CHK_EDCCA BIT(1)
+#define B_BE_MURTS_RESP_LEGACY_CHK_CCA BIT(0)
+
+#define R_BE_WMAC_RX_MURTS_RESP_LEGACY_PUNC 0x11218
+#define R_BE_WMAC_RX_MURTS_RESP_LEGACY_PUNC_C1 0x15218
+#define B_BE_MURTS_RESP_LEGACY_PUNC_CHK_NSTR BIT(16)
+#define B_BE_MURTS_RESP_LEGACY_PUNC_CHK_TX_NAV BIT(15)
+#define B_BE_MURTS_RESP_LEGACY_PUNC_CHK_INTRA_NAV BIT(14)
+#define B_BE_MURTS_RESP_LEGACY_PUNC_CHK_BASIC_NAV BIT(13)
+#define B_BE_MURTS_RESP_LEGACY_PUNC_CHK_BTCCA BIT(12)
+#define B_BE_MURTS_RESP_LEGACY_PUNC_CHK_SEC_EDCCA160 BIT(11)
+#define B_BE_MURTS_RESP_LEGACY_PUNC_CHK_SEC_EDCCA80 BIT(10)
+#define B_BE_MURTS_RESP_LEGACY_PUNC_CHK_SEC_EDCCA40 BIT(9)
+#define B_BE_MURTS_RESP_LEGACY_PUNC_CHK_SEC_EDCCA20 BIT(8)
+#define B_BE_MURTS_RESP_LEGACY_PUNC_CHK_EDCCA_PER20_BMP BIT(7)
+#define B_BE_MURTS_RESP_LEGACY_PUNC_CHK_CCA_PER20_BMP BIT(6)
+#define B_BE_MURTS_RESP_LEGACY_PUNC_CHK_SEC_CCA160 BIT(5)
+#define B_BE_MURTS_RESP_LEGACY_PUNC_CHK_SEC_CCA80 BIT(4)
+#define B_BE_MURTS_RESP_LEGACY_PUNC_CHK_SEC_CCA40 BIT(3)
+#define B_BE_MURTS_RESP_LEGACY_PUNC_CHK_SEC_CCA20 BIT(2)
+#define B_BE_MURTS_RESP_LEGACY_PUNC_CHK_EDCCA BIT(1)
+#define B_BE_MURTS_RESP_LEGACY_PUNC_CHK_CCA BIT(0)
+
+#define R_BE_WMAC_OTHERS_RESP_LEGACY 0x1121C
+#define R_BE_WMAC_OTHERS_RESP_LEGACY_C1 0x1521C
+#define B_BE_OTHERS_RESP_LEGACY_CHK_NSTR BIT(16)
+#define B_BE_OTHERS_RESP_LEGACY_CHK_TX_NAV BIT(15)
+#define B_BE_OTHERS_RESP_LEGACY_CHK_INTRA_NAV BIT(14)
+#define B_BE_OTHERS_RESP_LEGACY_CHK_BASIC_NAV BIT(13)
+#define B_BE_OTHERS_RESP_LEGACY_CHK_BTCCA BIT(12)
+#define B_BE_OTHERS_RESP_LEGACY_CHK_SEC_EDCCA160 BIT(11)
+#define B_BE_OTHERS_RESP_LEGACY_CHK_SEC_EDCCA80 BIT(10)
+#define B_BE_OTHERS_RESP_LEGACY_CHK_SEC_EDCCA40 BIT(9)
+#define B_BE_OTHERS_RESP_LEGACY_CHK_SEC_EDCCA20 BIT(8)
+#define B_BE_OTHERS_RESP_LEGACY_CHK_EDCCA_PER20_BMP BIT(7)
+#define B_BE_OTHERS_RESP_LEGACY_CHK_CCA_PER20_BMP BIT(6)
+#define B_BE_OTHERS_RESP_LEGACY_CHK_SEC_CCA160 BIT(5)
+#define B_BE_OTHERS_RESP_LEGACY_CHK_SEC_CCA80 BIT(4)
+#define B_BE_OTHERS_RESP_LEGACY_CHK_SEC_CCA40 BIT(3)
+#define B_BE_OTHERS_RESP_LEGACY_CHK_SEC_CCA20 BIT(2)
+#define B_BE_OTHERS_RESP_LEGACY_CHK_EDCCA BIT(1)
+#define B_BE_OTHERS_RESP_LEGACY_CHK_CCA BIT(0)
+
+#define R_BE_WMAC_OTHERS_RESP_HE 0x11220
+#define R_BE_WMAC_OTHERS_RESP_HE_C1 0x15220
+#define B_BE_OTHERS_RESP_HE_CHK_NSTR BIT(16)
+#define B_BE_OTHERS_RESP_HE_CHK_TX_NAV BIT(15)
+#define B_BE_OTHERS_RESP_HE_CHK_INTRA_NAV BIT(14)
+#define B_BE_OTHERS_RESP_HE_CHK_BASIC_NAV BIT(13)
+#define B_BE_OTHERS_RESP_HE_CHK_BTCCA BIT(12)
+#define B_BE_OTHERS_RESP_HE_CHK_SEC_EDCCA160 BIT(11)
+#define B_BE_OTHERS_RESP_HE_CHK_SEC_EDCCA80 BIT(10)
+#define B_BE_OTHERS_RESP_HE_CHK_SEC_EDCCA40 BIT(9)
+#define B_BE_OTHERS_RESP_HE_CHK_SEC_EDCCA20 BIT(8)
+#define B_BE_OTHERS_RESP_HE_CHK_EDCCA_PER20_BMP BIT(7)
+#define B_BE_OTHERS_RESP_HE_CHK_CCA_PER20_BMP BIT(6)
+#define B_BE_OTHERS_RESP_HE_CHK_SEC_CCA160 BIT(5)
+#define B_BE_OTHERS_RESP_HE_CHK_SEC_CCA80 BIT(4)
+#define B_BE_OTHERS_RESP_HE_CHK_SEC_CCA40 BIT(3)
+#define B_BE_OTHERS_RESP_HE_CHK_SEC_CCA20 BIT(2)
+#define B_BE_OTHERS_RESP_HE_CHK_EDCCA BIT(1)
+#define B_BE_OTHERS_RESP_HE_CHK_CCA BIT(0)
+
+#define R_BE_WMAC_OTHERS_RESP_EHT_LEG_PUNC 0x11224
+#define R_BE_WMAC_OTHERS_RESP_EHT_LEG_PUNC_C1 0x15224
+#define B_BE_OTHERS_RESP_EHT_LEG_PUNC_CHK_NSTR BIT(16)
+#define B_BE_OTHERS_RESP_EHT_LEG_PUNC_CHK_TX_NAV BIT(15)
+#define B_BE_OTHERS_RESP_EHT_LEG_PUNC_CHK_INTRA_NAV BIT(14)
+#define B_BE_OTHERS_RESP_EHT_LEG_PUNC_CHK_BASIC_NAV BIT(13)
+#define B_BE_OTHERS_RESP_EHT_LEG_PUNC_CHK_BTCCA BIT(12)
+#define B_BE_OTHERS_RESP_EHT_LEG_PUNC_CHK_SEC_EDCCA160 BIT(11)
+#define B_BE_OTHERS_RESP_EHT_LEG_PUNC_CHK_SEC_EDCCA80 BIT(10)
+#define B_BE_OTHERS_RESP_EHT_LEG_PUNC_CHK_SEC_EDCCA40 BIT(9)
+#define B_BE_OTHERS_RESP_EHT_LEG_PUNC_CHK_SEC_EDCCA20 BIT(8)
+#define B_BE_OTHERS_RESP_EHT_LEG_PUNC_CHK_EDCCA_PER20_BMP BIT(7)
+#define B_BE_OTHERS_RESP_EHT_LEG_PUNC_CHK_CCA_PER20_BMP BIT(6)
+#define B_BE_OTHERS_RESP_EHT_LEG_PUNC_CHK_SEC_CCA160 BIT(5)
+#define B_BE_OTHERS_RESP_EHT_LEG_PUNC_CHK_SEC_CCA80 BIT(4)
+#define B_BE_OTHERS_RESP_EHT_LEG_PUNC_CHK_SEC_CCA40 BIT(3)
+#define B_BE_OTHERS_RESP_EHT_LEG_PUNC_CHK_SEC_CCA20 BIT(2)
+#define B_BE_OTHERS_RESP_EHT_LEG_PUNC_CHK_EDCCA BIT(1)
+#define B_BE_OTHERS_RESP_EHT_LEG_PUNC_CHK_CCA BIT(0)
+
 #define R_BE_RCR 0x11400
 #define R_BE_RCR_C1 0x15400
 #define B_BE_BUSY_CHKSN BIT(15)
-- 
2.25.1


