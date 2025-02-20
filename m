Return-Path: <linux-wireless+bounces-19168-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D29A3D15C
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Feb 2025 07:24:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 379DE175D48
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Feb 2025 06:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C721E04A9;
	Thu, 20 Feb 2025 06:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="LKyrat99"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33B71DE4EF
	for <linux-wireless@vger.kernel.org>; Thu, 20 Feb 2025 06:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740032667; cv=none; b=kwOLRm5uXdB0PH1DRTnj/Q7l8CN2Ye4n/YWxdAhA7pRPysZqkbHN8brvZZx68xR/oJc17jmNBrT4qy5sEKSQJ/bbmJs0yXZDAnf7HAgbZKINcYXeWlG+2PUOaC82yeJiRmQ3sU+0TQk/vYPWuEBJEgc5Qua2+gSkzYfich0PRaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740032667; c=relaxed/simple;
	bh=KJJ14EIpeuGUEKORWyHq+6EULKFS3YvDIB4C/RIEJ0Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GEudhZz2dA8kb7DmOAedrp5xuymJ8AJEc4WK/1pvn404a3exPxlU7gVXRUJyY9jDAORnsNKuL9enMB1U/uMPSbXhW0KUBStHBUE+cP/9eaQ7oH/PE13YZW+2bA1eNh53IPZCAq/pwPpOMxUHheXjq62TG6hVK77UFWq3P7NDGRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=LKyrat99; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 51K6ONKk8684903, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1740032663; bh=KJJ14EIpeuGUEKORWyHq+6EULKFS3YvDIB4C/RIEJ0Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=LKyrat99WOvRDgr/kmsf7ys9VBBJx4FLLJen9OK57qbJ3y4JTkp8wR7HSGkf5eoFy
	 aj1pdxAc079fcbZnzb1EVkPb2PuprJfCzzVE7Qslk9glxWu9mbqm1xRax32x60xLy1
	 R7FPV5Suf5WX75+jeHPMf9HFCBAqYFiZdlilRKInx3+sjdU5vGaJB0qrgfJr8wdyY0
	 DOS/F60R4YowCtbHE9RXwgchCpYKnlpUufOcLqyj60s6VPNZPTA/gmbucTW69uuY/c
	 kmVmMu/Dh+Ex9yMN18VFwJG5VU7L6omn4xtTWmfzwSe8BK1rYnTt/j/1GbLiGnAVfI
	 4wpUh+ALBTXVw==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 51K6ONKk8684903
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 20 Feb 2025 14:24:23 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 20 Feb 2025 14:24:23 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 20 Feb
 2025 14:24:23 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <damon.chen@realtek.com>
Subject: [PATCH] wifi: rtw89: add support for HW TKIP crypto
Date: Thu, 20 Feb 2025 14:23:44 +0800
Message-ID: <20250220062344.15836-1-pkshih@realtek.com>
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

From: Kuan-Chung Chen <damon.chen@realtek.com>

For 8852BTE, 8852CE, and 8922AE, TKIP encryption and decryption
will be handled by hardware. All other chips will retain their
existing software-based encryption and decryption.

Signed-off-by: Kuan-Chung Chen <damon.chen@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/cam.c       | 6 ++++++
 drivers/net/wireless/realtek/rtw89/core.h      | 1 +
 drivers/net/wireless/realtek/rtw89/mac_be.c    | 4 ++--
 drivers/net/wireless/realtek/rtw89/rtw8851b.c  | 1 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c  | 1 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c  | 1 +
 drivers/net/wireless/realtek/rtw89/rtw8852bt.c | 1 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c  | 1 +
 drivers/net/wireless/realtek/rtw89/rtw8922a.c  | 1 +
 9 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/cam.c b/drivers/net/wireless/realtek/rtw89/cam.c
index 8fa1e6c1ce13..eca3d767ff60 100644
--- a/drivers/net/wireless/realtek/rtw89/cam.c
+++ b/drivers/net/wireless/realtek/rtw89/cam.c
@@ -476,6 +476,12 @@ int rtw89_cam_sec_key_add(struct rtw89_dev *rtwdev,
 	case WLAN_CIPHER_SUITE_WEP104:
 		hw_key_type = RTW89_SEC_KEY_TYPE_WEP104;
 		break;
+	case WLAN_CIPHER_SUITE_TKIP:
+		if (!chip->hw_tkip_crypto)
+			return -EOPNOTSUPP;
+		hw_key_type = RTW89_SEC_KEY_TYPE_TKIP;
+		key->flags |= IEEE80211_KEY_FLAG_GENERATE_MMIC;
+		break;
 	case WLAN_CIPHER_SUITE_CCMP:
 		hw_key_type = RTW89_SEC_KEY_TYPE_CCMP128;
 		if (!chip->hw_mgmt_tx_encrypt)
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index b3fdd8eded21..676f5e21744f 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -4281,6 +4281,7 @@ struct rtw89_chip_info {
 	bool ul_tb_pwr_diff;
 	bool hw_sec_hdr;
 	bool hw_mgmt_tx_encrypt;
+	bool hw_tkip_crypto;
 	u8 rf_path_num;
 	u8 tx_nss;
 	u8 rx_nss;
diff --git a/drivers/net/wireless/realtek/rtw89/mac_be.c b/drivers/net/wireless/realtek/rtw89/mac_be.c
index 16ee378c5418..d2a37eead66e 100644
--- a/drivers/net/wireless/realtek/rtw89/mac_be.c
+++ b/drivers/net/wireless/realtek/rtw89/mac_be.c
@@ -708,8 +708,8 @@ static int sec_eng_init_be(struct rtw89_dev *rtwdev)
 	val32 |= B_BE_CLK_EN_CGCMP | B_BE_CLK_EN_WAPI | B_BE_CLK_EN_WEP_TKIP |
 		 B_BE_SEC_TX_ENC | B_BE_SEC_RX_DEC |
 		 B_BE_MC_DEC | B_BE_BC_DEC |
-		 B_BE_BMC_MGNT_DEC | B_BE_UC_MGNT_DEC;
-	val32 &= ~B_BE_SEC_PRE_ENQUE_TX;
+		 B_BE_BMC_MGNT_DEC | B_BE_UC_MGNT_DEC |
+		 B_BE_SEC_PRE_ENQUE_TX;
 	rtw89_write32(rtwdev, R_BE_SEC_ENG_CTRL, val32);
 
 	rtw89_write32_set(rtwdev, R_BE_SEC_MPDU_PROC, B_BE_APPEND_ICV | B_BE_APPEND_MIC);
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b.c b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
index 82289dbad1f4..e5ccd55655b6 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
@@ -2500,6 +2500,7 @@ const struct rtw89_chip_info rtw8851b_chip_info = {
 	.ul_tb_pwr_diff		= false,
 	.hw_sec_hdr		= false,
 	.hw_mgmt_tx_encrypt	= false,
+	.hw_tkip_crypto		= false,
 	.rf_path_num		= 1,
 	.tx_nss			= 1,
 	.rx_nss			= 1,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index 2046832d021f..42642135d274 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -2218,6 +2218,7 @@ const struct rtw89_chip_info rtw8852a_chip_info = {
 	.ul_tb_pwr_diff		= false,
 	.hw_sec_hdr		= false,
 	.hw_mgmt_tx_encrypt	= false,
+	.hw_tkip_crypto		= false,
 	.rf_path_num		= 2,
 	.tx_nss			= 2,
 	.rx_nss			= 2,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index 652914a36245..e9ff6bcdd9ec 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -854,6 +854,7 @@ const struct rtw89_chip_info rtw8852b_chip_info = {
 	.ul_tb_pwr_diff		= false,
 	.hw_sec_hdr		= false,
 	.hw_mgmt_tx_encrypt	= false,
+	.hw_tkip_crypto		= false,
 	.rf_path_num		= 2,
 	.tx_nss			= 2,
 	.rx_nss			= 2,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852bt.c b/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
index 6f15245b2f74..2f5804f77f9d 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
@@ -787,6 +787,7 @@ const struct rtw89_chip_info rtw8852bt_chip_info = {
 	.ul_tb_pwr_diff		= false,
 	.hw_sec_hdr		= false,
 	.hw_mgmt_tx_encrypt     = false,
+	.hw_tkip_crypto		= true,
 	.rf_path_num		= 2,
 	.tx_nss			= 2,
 	.rx_nss			= 2,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index ecc1ff358583..89f258b98e75 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -3013,6 +3013,7 @@ const struct rtw89_chip_info rtw8852c_chip_info = {
 	.ul_tb_pwr_diff		= true,
 	.hw_sec_hdr		= true,
 	.hw_mgmt_tx_encrypt	= true,
+	.hw_tkip_crypto		= true,
 	.rf_path_num		= 2,
 	.tx_nss			= 2,
 	.rx_nss			= 2,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.c b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
index 898a65a721dc..99221677065c 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
@@ -2772,6 +2772,7 @@ const struct rtw89_chip_info rtw8922a_chip_info = {
 	.ul_tb_pwr_diff		= false,
 	.hw_sec_hdr		= true,
 	.hw_mgmt_tx_encrypt	= true,
+	.hw_tkip_crypto		= true,
 	.rf_path_num		= 2,
 	.tx_nss			= 2,
 	.rx_nss			= 2,
-- 
2.25.1


