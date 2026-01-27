Return-Path: <linux-wireless+bounces-31209-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MAyRCpd9eGkFqQEAu9opvQ
	(envelope-from <linux-wireless+bounces-31209-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jan 2026 09:55:51 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CFFD9157C
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jan 2026 09:55:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0B08B3049957
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jan 2026 08:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69802229B2A;
	Tue, 27 Jan 2026 08:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="HZiZtA+v"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C0329D289
	for <linux-wireless@vger.kernel.org>; Tue, 27 Jan 2026 08:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769503906; cv=none; b=pTyZmPSd57UIsNmUsyKcUYAnrV/eC50cR+p5N8hHqL5bnpcT9ljNcENdWm3CQRwnfU+oWGG29T5OukJ4PhOjvbNTPHsXB/6PZRLfe1GGUhgbv9BedkT77DOYscCsoB6cfUA/WyOBEHJ9V5dQa+ommPWt6jMRji3PcfOcF/Cy84A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769503906; c=relaxed/simple;
	bh=nxB3PkdvMbMlJ/Aj1GslpNQEQqcIiP49nfN3P1ExdEw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oDnHtFBF2Dgp7Kt9iXt5AARysX7BtT5cs3518OlyVFNEkhxy14PtYUt0Ejl6EKcy9dCmBk12zQNIweZ1TzpVq4oKX5GXb/QUC+OeAKpAf0T22D1xtkMkk02BygjPGBRazf/ax64uxarMu0U2ZNGpU67Gf4MADm/9Cg7b8rNRjjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=HZiZtA+v; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 60R8pg8D32655511, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1769503902; bh=eE4sI3UuPLzN1PcOWZAXijKmErYJHfCUFff4zFwp4Xs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=HZiZtA+vxkM/tZ8R2IHawXvl61Itw/BsKUZLYUQSVLCV+KUrS3t+W0qf7YWAN18Nj
	 Snt3eOZDEwYMgfud4hQ7HVOIAvgIJmKI0QZq/2Uisb8PM+ryvGJUtR1nNylc863XJI
	 vxu7ol6hXZGdONvp2OXxfZRKCbzNjRmdFJjZGiTnwVgLn3nqMBHJ50djlFxN+k4mW5
	 y8obYrimc32123kSQGV6+pvb27uXllAsH/mCQXkQ0hYGhHbSUa87pCXL0X4gPatrzY
	 6kYrhDNRIHrcYnjPBfPrQNefkhRYdxICwv9qW/h8UgRj+XxSotwIdS3OQF2tyY8nSh
	 /h7cGqJLZL3nA==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 60R8pg8D32655511
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 27 Jan 2026 16:51:42 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 27 Jan 2026 16:51:42 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Tue, 27 Jan 2026 16:51:42 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <dian_syuan0116@realtek.com>,
        <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 4/6] wifi: rtw89: mac: set MU group membership and position to registers
Date: Tue, 27 Jan 2026 16:50:34 +0800
Message-ID: <20260127085036.44060-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260127085036.44060-1-pkshih@realtek.com>
References: <20260127085036.44060-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31209-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[realtek.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,realtek.com:email,realtek.com:dkim,realtek.com:mid]
X-Rspamd-Queue-Id: 7CFFD9157C
X-Rspamd-Action: no action

The WiFi 7 chips use different registers to configure MU group for
beamforming. Define specific registers and refactor the common flow.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac.c    | 21 +++++++++++++++------
 drivers/net/wireless/realtek/rtw89/mac.h    |  6 ++++++
 drivers/net/wireless/realtek/rtw89/mac_be.c |  7 +++++++
 drivers/net/wireless/realtek/rtw89/reg.h    | 13 +++++++++++++
 4 files changed, 41 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 4f0f17c499fa..8472f1a63951 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -4374,6 +4374,12 @@ static const struct rtw89_port_reg rtw89_port_base_ax = {
 		    R_AX_PORT_HGQ_WINDOW_CFG + 3},
 };
 
+static const struct rtw89_mac_mu_gid_addr rtw89_mac_mu_gid_addr_ax = {
+	.position_en = {R_AX_GID_POSITION_EN0, R_AX_GID_POSITION_EN1},
+	.position = {R_AX_GID_POSITION0, R_AX_GID_POSITION1,
+		     R_AX_GID_POSITION2, R_AX_GID_POSITION3},
+};
+
 static void rtw89_mac_check_packet_ctrl(struct rtw89_dev *rtwdev,
 					struct rtw89_vif_link *rtwvif_link, u8 type)
 {
@@ -6770,6 +6776,8 @@ void rtw89_mac_bf_disassoc(struct rtw89_dev *rtwdev,
 void rtw89_mac_bf_set_gid_table(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif,
 				struct ieee80211_bss_conf *conf)
 {
+	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
+	const struct rtw89_mac_mu_gid_addr *addr = mac->mu_gid;
 	struct rtw89_vif *rtwvif = vif_to_rtwvif(vif);
 	struct rtw89_vif_link *rtwvif_link;
 	u8 mac_idx;
@@ -6789,20 +6797,20 @@ void rtw89_mac_bf_set_gid_table(struct rtw89_dev *rtwdev, struct ieee80211_vif *
 
 	p = (__le32 *)conf->mu_group.membership;
 	rtw89_write32(rtwdev,
-		      rtw89_mac_reg_by_idx(rtwdev, R_AX_GID_POSITION_EN0, mac_idx),
+		      rtw89_mac_reg_by_idx(rtwdev, addr->position_en[0], mac_idx),
 		      le32_to_cpu(p[0]));
 	rtw89_write32(rtwdev,
-		      rtw89_mac_reg_by_idx(rtwdev, R_AX_GID_POSITION_EN1, mac_idx),
+		      rtw89_mac_reg_by_idx(rtwdev, addr->position_en[1], mac_idx),
 		      le32_to_cpu(p[1]));
 
 	p = (__le32 *)conf->mu_group.position;
-	rtw89_write32(rtwdev, rtw89_mac_reg_by_idx(rtwdev, R_AX_GID_POSITION0, mac_idx),
+	rtw89_write32(rtwdev, rtw89_mac_reg_by_idx(rtwdev, addr->position[0], mac_idx),
 		      le32_to_cpu(p[0]));
-	rtw89_write32(rtwdev, rtw89_mac_reg_by_idx(rtwdev, R_AX_GID_POSITION1, mac_idx),
+	rtw89_write32(rtwdev, rtw89_mac_reg_by_idx(rtwdev, addr->position[1], mac_idx),
 		      le32_to_cpu(p[1]));
-	rtw89_write32(rtwdev, rtw89_mac_reg_by_idx(rtwdev, R_AX_GID_POSITION2, mac_idx),
+	rtw89_write32(rtwdev, rtw89_mac_reg_by_idx(rtwdev, addr->position[2], mac_idx),
 		      le32_to_cpu(p[2]));
-	rtw89_write32(rtwdev, rtw89_mac_reg_by_idx(rtwdev, R_AX_GID_POSITION3, mac_idx),
+	rtw89_write32(rtwdev, rtw89_mac_reg_by_idx(rtwdev, addr->position[3], mac_idx),
 		      le32_to_cpu(p[3]));
 }
 
@@ -7282,6 +7290,7 @@ const struct rtw89_mac_gen_def rtw89_mac_gen_ax = {
 	.port_base = &rtw89_port_base_ax,
 	.agg_len_ht = R_AX_AGG_LEN_HT_0,
 	.ps_status = R_AX_PPWRBIT_SETTING,
+	.mu_gid = &rtw89_mac_mu_gid_addr_ax,
 
 	.muedca_ctrl = {
 		.addr = R_AX_MUEDCA_EN,
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index 0c8614fc3000..e71a71648ab8 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -1015,6 +1015,11 @@ struct rtw89_mac_size_set {
 
 extern const struct rtw89_mac_size_set rtw89_mac_size;
 
+struct rtw89_mac_mu_gid_addr {
+	u32 position_en[2];
+	u32 position[4];
+};
+
 struct rtw89_mac_gen_def {
 	u32 band1_offset;
 	u32 filter_model_addr;
@@ -1025,6 +1030,7 @@ struct rtw89_mac_gen_def {
 	const struct rtw89_port_reg *port_base;
 	u32 agg_len_ht;
 	u32 ps_status;
+	const struct rtw89_mac_mu_gid_addr *mu_gid;
 
 	struct rtw89_reg_def muedca_ctrl;
 	struct rtw89_reg_def bfee_ctrl;
diff --git a/drivers/net/wireless/realtek/rtw89/mac_be.c b/drivers/net/wireless/realtek/rtw89/mac_be.c
index 3a84cd529148..dc66b1ee851a 100644
--- a/drivers/net/wireless/realtek/rtw89/mac_be.c
+++ b/drivers/net/wireless/realtek/rtw89/mac_be.c
@@ -62,6 +62,12 @@ static const struct rtw89_port_reg rtw89_port_base_be = {
 		    R_BE_PORT_HGQ_WINDOW_CFG + 3},
 };
 
+static const struct rtw89_mac_mu_gid_addr rtw89_mac_mu_gid_addr_be = {
+	.position_en = {R_BE_GID_POSITION_EN0, R_BE_GID_POSITION_EN1},
+	.position = {R_BE_GID_POSITION0, R_BE_GID_POSITION1,
+		     R_BE_GID_POSITION2, R_BE_GID_POSITION3},
+};
+
 static int rtw89_mac_check_mac_en_be(struct rtw89_dev *rtwdev, u8 mac_idx,
 				     enum rtw89_mac_hwmod_sel sel)
 {
@@ -3170,6 +3176,7 @@ const struct rtw89_mac_gen_def rtw89_mac_gen_be = {
 	.port_base = &rtw89_port_base_be,
 	.agg_len_ht = R_BE_AGG_LEN_HT_0,
 	.ps_status = R_BE_WMTX_POWER_BE_BIT_CTL,
+	.mu_gid = &rtw89_mac_mu_gid_addr_be,
 
 	.muedca_ctrl = {
 		.addr = R_BE_MUEDCA_EN,
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 9b2e97ed5c7d..9b605617c3f0 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -6501,6 +6501,19 @@
 #define BE_WMAC_RFMOD_160M 3
 #define BE_WMAC_RFMOD_320M 4
 
+#define R_BE_GID_POSITION0 0x10070
+#define R_BE_GID_POSITION0_C1 0x14070
+#define R_BE_GID_POSITION1 0x10074
+#define R_BE_GID_POSITION1_C1 0x14074
+#define R_BE_GID_POSITION2 0x10078
+#define R_BE_GID_POSITION2_C1 0x14078
+#define R_BE_GID_POSITION3 0x1007C
+#define R_BE_GID_POSITION3_C1 0x1407C
+#define R_BE_GID_POSITION_EN0 0x10080
+#define R_BE_GID_POSITION_EN0_C1 0x14080
+#define R_BE_GID_POSITION_EN1 0x10084
+#define R_BE_GID_POSITION_EN1_C1 0x14084
+
 #define R_BE_TX_SUB_BAND_VALUE 0x10088
 #define R_BE_TX_SUB_BAND_VALUE_C1 0x14088
 #define B_BE_PRI20_BITMAP_MASK GENMASK(31, 16)
-- 
2.25.1


