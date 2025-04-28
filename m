Return-Path: <linux-wireless+bounces-22132-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A41A9EF00
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Apr 2025 13:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B570A3A7347
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Apr 2025 11:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEAD726388C;
	Mon, 28 Apr 2025 11:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="bW9wo89c"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0812641DE
	for <linux-wireless@vger.kernel.org>; Mon, 28 Apr 2025 11:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745839547; cv=none; b=Gff3A0xnQIPorbUtcedu2d4lJD8m/BcitQrbIxoYV2IQgxIAUZ5j1k/23Os1Sa8HthcFNTdVLuVfXuzaYwdF0lypESwE8ntui0poKMTQiQBDF0rJtvePP5OjBiYxoHwI3cZBnWE+GR+QKJpyKxijooQCqDka/ae0uoEWOEsZ3d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745839547; c=relaxed/simple;
	bh=UUVK0lyIqoXzEwNBuTiWzc+Qhv+fGHJTHaJz9kscgvk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NML06U2yctIyUKdAUzkPyG5o04d94/SksfkTRszVhblSSMlQxvPU4ETZ4ZGKqRNx8sSXNAXMWVOVoCR0twZZROG5ctT3avuJp25xghKQ5aZyqfA/oTc/+KNA+JjMz1duPWL5tb7pZV8US4Udglo8N0pkwJQFTKl4R/thrMPR61E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=bW9wo89c; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 53SBPhSL22101196, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1745839543; bh=UUVK0lyIqoXzEwNBuTiWzc+Qhv+fGHJTHaJz9kscgvk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=bW9wo89c0i8851RN6ZeucMeOOyrAGqDO7M2e+lg5Y7QGDQULm1p2U68jIXKu20oNA
	 0kjLsr8tMbOBzaYMToIRc52ST837kD/jDdNW9F2o2srS9mnWTxBr8RKdfYZnNOBSCs
	 vqWp/Ni6Umbm7K24SlGRY69XiXWCupoYXqZNikvd6S75KDCwQ0clFxRLQwCtWNjUuI
	 kCG6+wnJkQ+X4L+k9Rx2i2g6SvyVz5wKCiwX3wMCnCdpQk9qDr7h58vLhqkXoBY2SE
	 4NpOMWozUBQPI0qNuxMbQUPjiCHSMvpsJvPYx2uPZFNi2WOnWUvnoGBMMhRlhaQUcz
	 sML5lTroGqUeQ==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 53SBPhSL22101196
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 28 Apr 2025 19:25:43 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 28 Apr 2025 19:25:43 +0800
Received: from [127.0.1.1] (172.16.19.226) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 28 Apr
 2025 19:25:42 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <phhuang@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 02/10] wifi: rtw89: 8922a: use SW CRYPTO when broadcast in MLO mode
Date: Mon, 28 Apr 2025 19:24:48 +0800
Message-ID: <20250428112456.13165-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250428112456.13165-1-pkshih@realtek.com>
References: <20250428112456.13165-1-pkshih@realtek.com>
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

8922A doesn't support broadcast/multicast traffic under MLO mode.
So let mac80211 do the encryption/decryption for us when the
connection is in MLO mode. Future BE ICs fixes this issue.

Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/cam.c       | 4 ++++
 drivers/net/wireless/realtek/rtw89/core.h      | 1 +
 drivers/net/wireless/realtek/rtw89/rtw8851b.c  | 1 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c  | 1 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c  | 1 +
 drivers/net/wireless/realtek/rtw89/rtw8852bt.c | 1 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c  | 1 +
 drivers/net/wireless/realtek/rtw89/rtw8922a.c  | 1 +
 8 files changed, 11 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/cam.c b/drivers/net/wireless/realtek/rtw89/cam.c
index eca3d767ff60..34316e64b777 100644
--- a/drivers/net/wireless/realtek/rtw89/cam.c
+++ b/drivers/net/wireless/realtek/rtw89/cam.c
@@ -469,6 +469,10 @@ int rtw89_cam_sec_key_add(struct rtw89_dev *rtwdev,
 	bool ext_key = false;
 	int ret;
 
+	if (ieee80211_vif_is_mld(vif) && !chip->hw_mlo_bmc_crypto &&
+	    !(key->flags & IEEE80211_KEY_FLAG_PAIRWISE))
+		return -EOPNOTSUPP;
+
 	switch (key->cipher) {
 	case WLAN_CIPHER_SUITE_WEP40:
 		hw_key_type = RTW89_SEC_KEY_TYPE_WEP40;
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index be1259cfa712..8f51bbde1fad 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -4292,6 +4292,7 @@ struct rtw89_chip_info {
 	bool hw_sec_hdr;
 	bool hw_mgmt_tx_encrypt;
 	bool hw_tkip_crypto;
+	bool hw_mlo_bmc_crypto;
 	u8 rf_path_num;
 	u8 tx_nss;
 	u8 rx_nss;
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b.c b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
index 174b90661037..fafa200a9c8d 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
@@ -2506,6 +2506,7 @@ const struct rtw89_chip_info rtw8851b_chip_info = {
 	.hw_sec_hdr		= false,
 	.hw_mgmt_tx_encrypt	= false,
 	.hw_tkip_crypto		= false,
+	.hw_mlo_bmc_crypto	= false,
 	.rf_path_num		= 1,
 	.tx_nss			= 1,
 	.rx_nss			= 1,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index 408c2f7b3eec..cd5987fc52d7 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -2224,6 +2224,7 @@ const struct rtw89_chip_info rtw8852a_chip_info = {
 	.hw_sec_hdr		= false,
 	.hw_mgmt_tx_encrypt	= false,
 	.hw_tkip_crypto		= false,
+	.hw_mlo_bmc_crypto	= false,
 	.rf_path_num		= 2,
 	.tx_nss			= 2,
 	.rx_nss			= 2,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index dec736a07c54..dacdb384de2c 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -860,6 +860,7 @@ const struct rtw89_chip_info rtw8852b_chip_info = {
 	.hw_sec_hdr		= false,
 	.hw_mgmt_tx_encrypt	= false,
 	.hw_tkip_crypto		= false,
+	.hw_mlo_bmc_crypto	= false,
 	.rf_path_num		= 2,
 	.tx_nss			= 2,
 	.rx_nss			= 2,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852bt.c b/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
index 3aaf70e32652..289dce688d72 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
@@ -793,6 +793,7 @@ const struct rtw89_chip_info rtw8852bt_chip_info = {
 	.hw_sec_hdr		= false,
 	.hw_mgmt_tx_encrypt     = false,
 	.hw_tkip_crypto		= true,
+	.hw_mlo_bmc_crypto	= false,
 	.rf_path_num		= 2,
 	.tx_nss			= 2,
 	.rx_nss			= 2,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index 9a2235f28e24..2a6143a8d256 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -3047,6 +3047,7 @@ const struct rtw89_chip_info rtw8852c_chip_info = {
 	.hw_sec_hdr		= true,
 	.hw_mgmt_tx_encrypt	= true,
 	.hw_tkip_crypto		= true,
+	.hw_mlo_bmc_crypto	= false,
 	.rf_path_num		= 2,
 	.tx_nss			= 2,
 	.rx_nss			= 2,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.c b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
index 2ff847eb76fd..1d0f6e7df497 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
@@ -2858,6 +2858,7 @@ const struct rtw89_chip_info rtw8922a_chip_info = {
 	.hw_sec_hdr		= true,
 	.hw_mgmt_tx_encrypt	= true,
 	.hw_tkip_crypto		= true,
+	.hw_mlo_bmc_crypto	= false,
 	.rf_path_num		= 2,
 	.tx_nss			= 2,
 	.rx_nss			= 2,
-- 
2.25.1


