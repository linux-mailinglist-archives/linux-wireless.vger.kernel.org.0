Return-Path: <linux-wireless+bounces-7928-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 774F98CB908
	for <lists+linux-wireless@lfdr.de>; Wed, 22 May 2024 04:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 331F0281A28
	for <lists+linux-wireless@lfdr.de>; Wed, 22 May 2024 02:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E7D1E894;
	Wed, 22 May 2024 02:45:56 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC76B33C9
	for <linux-wireless@vger.kernel.org>; Wed, 22 May 2024 02:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716345956; cv=none; b=YwU+dLA11zV6tL8xuUejo0mALL+Lkbj1wO+8znITUjyRkPP1CI536iQ8+rRwv/10hVbBRVk7ZUYhKIHS7J9kp6+N4b8zwJJYOlMH0jOFXJLq9GAyiSow7I7JVxgCxgZMiFDp/nguHH3wdpwYok8vrkmsMB3hSz4kJhVcof29lqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716345956; c=relaxed/simple;
	bh=WWMoPUR2n6MxARQArGDNNKqYaQAkQGg4TMpkFw6BdmA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=G9MIDv2DFbSri6+y6ueoVWMGmHHPNkpVe3bD49s+Ke7SiIuR6vequ1j0nx8hfEDYdGFTUxD0hz/ifFgMVmX9wGM0tYtg+bX5k5NRvnrNhxPoHAOyq5zeHFl2O6eFd66OqNvkFxjbKmUDlC5GbiX57IsOUOKtiLG926Dxvg6h1Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 44M2jpe173364134, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 44M2jpe173364134
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 22 May 2024 10:45:51 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 22 May 2024 10:45:51 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 22 May
 2024 10:45:51 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <phhuang@realtek.com>
Subject: [PATCH] wifi: rtw89: Fix P2P behavior for WiFi 7 chips
Date: Wed, 22 May 2024 10:45:31 +0800
Message-ID: <20240522024531.11401-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
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

From: Po-Hao Huang <phhuang@realtek.com>

Previously we used CCK rate when scanning for P2P on WiFi 7 chips.
Fix this by explicitly setting the rate to OFDM 6Mbps.

Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c | 10 ++++++++++
 drivers/net/wireless/realtek/rtw89/fw.h |  4 ++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 044a5b90c7f4..ec559191db1f 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -4850,6 +4850,7 @@ int rtw89_fw_h2c_scan_offload_be(struct rtw89_dev *rtwdev,
 {
 	struct rtw89_hw_scan_info *scan_info = &rtwdev->scan_info;
 	struct rtw89_wait_info *wait = &rtwdev->mac.fw_ofld_wait;
+	struct cfg80211_scan_request *req = rtwvif->scan_req;
 	struct rtw89_h2c_scanofld_be_macc_role *macc_role;
 	struct rtw89_chan *op = &scan_info->op_chan;
 	struct rtw89_h2c_scanofld_be_opch *opch;
@@ -4923,6 +4924,15 @@ int rtw89_fw_h2c_scan_offload_be(struct rtw89_dev *rtwdev,
 				   RTW89_H2C_SCANOFLD_BE_W6_CHAN_PROHIB_LOW);
 	h2c->w7 = le32_encode_bits(option->prohib_chan >> 32,
 				   RTW89_H2C_SCANOFLD_BE_W7_CHAN_PROHIB_HIGH);
+	if (req->no_cck) {
+		h2c->w0 |= le32_encode_bits(true, RTW89_H2C_SCANOFLD_BE_W0_PROBE_WITH_RATE);
+		h2c->w8 = le32_encode_bits(RTW89_HW_RATE_OFDM6,
+					   RTW89_H2C_SCANOFLD_BE_W8_PROBE_RATE_2GHZ) |
+			  le32_encode_bits(RTW89_HW_RATE_OFDM6,
+					   RTW89_H2C_SCANOFLD_BE_W8_PROBE_RATE_5GHZ) |
+			  le32_encode_bits(RTW89_HW_RATE_OFDM6,
+					   RTW89_H2C_SCANOFLD_BE_W8_PROBE_RATE_6GHZ);
+	}
 	ptr += sizeof(*h2c);
 
 	for (i = 0; i < option->num_macc_role; i++) {
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 4151c9d566bd..01fea0b004d3 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -2722,6 +2722,7 @@ struct rtw89_h2c_scanofld_be {
 #define RTW89_H2C_SCANOFLD_BE_W0_MACID GENMASK(23, 8)
 #define RTW89_H2C_SCANOFLD_BE_W0_PORT GENMASK(26, 24)
 #define RTW89_H2C_SCANOFLD_BE_W0_BAND GENMASK(28, 27)
+#define RTW89_H2C_SCANOFLD_BE_W0_PROBE_WITH_RATE BIT(29)
 #define RTW89_H2C_SCANOFLD_BE_W1_NUM_MACC_ROLE GENMASK(7, 0)
 #define RTW89_H2C_SCANOFLD_BE_W1_NUM_OP GENMASK(15, 8)
 #define RTW89_H2C_SCANOFLD_BE_W1_NORM_PD GENMASK(31, 16)
@@ -2738,6 +2739,9 @@ struct rtw89_h2c_scanofld_be {
 #define RTW89_H2C_SCANOFLD_BE_W5_MLO_MODE GENMASK(31, 0)
 #define RTW89_H2C_SCANOFLD_BE_W6_CHAN_PROHIB_LOW GENMASK(31, 0)
 #define RTW89_H2C_SCANOFLD_BE_W7_CHAN_PROHIB_HIGH GENMASK(31, 0)
+#define RTW89_H2C_SCANOFLD_BE_W8_PROBE_RATE_2GHZ GENMASK(7, 0)
+#define RTW89_H2C_SCANOFLD_BE_W8_PROBE_RATE_5GHZ GENMASK(15, 8)
+#define RTW89_H2C_SCANOFLD_BE_W8_PROBE_RATE_6GHZ GENMASK(23, 16)
 
 static inline void RTW89_SET_FWCMD_P2P_MACID(void *cmd, u32 val)
 {
-- 
2.25.1


