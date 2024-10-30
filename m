Return-Path: <linux-wireless+bounces-14704-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D58F99B59ED
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Oct 2024 03:29:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94003284A34
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Oct 2024 02:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2494C193426;
	Wed, 30 Oct 2024 02:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="QL/4TGUo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B9D16F27E
	for <linux-wireless@vger.kernel.org>; Wed, 30 Oct 2024 02:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730255371; cv=none; b=l08SPAQm93M/VyeL458NCFdOMDUWyAwFHZ5MygSPx4kvCCfAYwuk4sTB5EM4qcnkDoIu5pYsy2tgYzK4UXvaZ3JL7ZTYTngink6lYcWv6ZqZbdYVnnBM1SRRsWtrmFFg4jJwJT955hS44NsMJn1cn6hkmJgAoDAUZRarOINFEak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730255371; c=relaxed/simple;
	bh=Ld++oJviXW7RzLASoSg2WuhjE5SoCgkLWYnxHln2Fas=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rrO1bN8qN5K4rlfHIMjoFOIEwgJ0mOIfyLn+Z0hJWxi+EDKGFjBpThK2FLgvQ8XB+ZpCpeP39z/G3qmraR2WGFCwCImAdrOyTek36taStacHrFhcAQsH8sVpZglA9HRoJCct2HKJnmSEaqswhISNGuq8FI0HJgDbzdNIUBQfY3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=QL/4TGUo; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 49U2TQ6E03322121, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1730255366; bh=Ld++oJviXW7RzLASoSg2WuhjE5SoCgkLWYnxHln2Fas=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=QL/4TGUoY4NPbA9llvsCB/3Kwmahu9dxq5HDLHIIvKnXlkfOyXPgsmRAq7hLIl8a+
	 x0LK4N/TJVhCIrdF3gnE4NhcR8WQPexBkMGeHtmJzbZ1Z/S2Sv7th55YhxFu0S0LwS
	 Xg5RxI29jJjpoo0jsgjm7oYXQc1dMJP1xQMxAglFfukxrVYQDGImmathERxkYmTaiH
	 st7fhpIXSbX+f1RxIPDTF60IkizzvDjXgei+krptVOS/uVjVOvKCSShRLakZc9nPMc
	 rDgBqXkViBnfzUob8Wx5Pm2RUpqO04+PPj7PNPJTbj9ZU2nthbcbPkQX6AJG7Fr4UG
	 DafKMLObcVjcA==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 49U2TQ6E03322121
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 30 Oct 2024 10:29:26 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 30 Oct 2024 10:29:26 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 30 Oct
 2024 10:29:26 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <damon.chen@realtek.com>
Subject: [PATCH] wifi: rtw89: 8922a: fill the missing OP1dB configuration
Date: Wed, 30 Oct 2024 10:29:03 +0800
Message-ID: <20241030022903.13243-1-pkshih@realtek.com>
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

OP1dB stands for Output 1dB Compression Point. At this point, the power
amplifier starts to enter the saturation region, resulting in distortion.
The configuration of OP1dB can optimize the RX gain saturation region,
improving RX throughput from 573 to 675 Mbps.

Signed-off-by: Kuan-Chung Chen <damon.chen@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h     |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8922a.c | 60 +++++++++++++++++++
 2 files changed, 61 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 5fa59cd138c1..e9ad6250d980 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -4943,6 +4943,7 @@ struct rtw89_agc_gaincode_set {
 
 #define IGI_RSSI_TH_NUM 5
 #define FA_TH_NUM 4
+#define TIA_LNA_OP1DB_NUM 8
 #define LNA_GAIN_NUM 7
 #define TIA_GAIN_NUM 2
 struct rtw89_dig_info {
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.c b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
index 27069a55e368..d431ff8e18a9 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
@@ -966,6 +966,42 @@ static const struct rtw8922a_bb_gain bb_gain_tia[TIA_GAIN_NUM] = {
 	  .gain_g_mask = 0x1FF, .gain_a_mask = 0x3FE00 },
 };
 
+static const struct rtw8922a_bb_gain bb_op1db_lna[LNA_GAIN_NUM] = {
+	{ .gain_g = {0x40ac, 0x44ac}, .gain_a = {0x4078, 0x4478},
+	  .gain_g_mask = 0xFF00, .gain_a_mask = 0xFF000000},
+	{ .gain_g = {0x40ac, 0x44ac}, .gain_a = {0x407c, 0x447c},
+	  .gain_g_mask = 0xFF0000, .gain_a_mask = 0xFF},
+	{ .gain_g = {0x40ac, 0x44ac}, .gain_a = {0x407c, 0x447c},
+	  .gain_g_mask = 0xFF000000, .gain_a_mask = 0xFF00},
+	{ .gain_g = {0x40b0, 0x44b0}, .gain_a = {0x407c, 0x447c},
+	  .gain_g_mask = 0xFF, .gain_a_mask = 0xFF0000},
+	{ .gain_g = {0x40b0, 0x44b0}, .gain_a = {0x407c, 0x447c},
+	  .gain_g_mask = 0xFF00, .gain_a_mask = 0xFF000000},
+	{ .gain_g = {0x40b0, 0x44b0}, .gain_a = {0x4080, 0x4480},
+	  .gain_g_mask = 0xFF0000, .gain_a_mask = 0xFF},
+	{ .gain_g = {0x40b0, 0x44b0}, .gain_a = {0x4080, 0x4480},
+	  .gain_g_mask = 0xFF000000, .gain_a_mask = 0xFF00},
+};
+
+static const struct rtw8922a_bb_gain bb_op1db_tia_lna[TIA_LNA_OP1DB_NUM] = {
+	{ .gain_g = {0x40b4, 0x44b4}, .gain_a = {0x4080, 0x4480},
+	  .gain_g_mask = 0xFF0000, .gain_a_mask = 0xFF000000},
+	{ .gain_g = {0x40b4, 0x44b4}, .gain_a = {0x4084, 0x4484},
+	  .gain_g_mask = 0xFF000000, .gain_a_mask = 0xFF},
+	{ .gain_g = {0x40b8, 0x44b8}, .gain_a = {0x4084, 0x4484},
+	  .gain_g_mask = 0xFF, .gain_a_mask = 0xFF00},
+	{ .gain_g = {0x40b8, 0x44b8}, .gain_a = {0x4084, 0x4484},
+	  .gain_g_mask = 0xFF00, .gain_a_mask = 0xFF0000},
+	{ .gain_g = {0x40b8, 0x44b8}, .gain_a = {0x4084, 0x4484},
+	  .gain_g_mask = 0xFF0000, .gain_a_mask = 0xFF000000},
+	{ .gain_g = {0x40b8, 0x44b8}, .gain_a = {0x4088, 0x4488},
+	  .gain_g_mask = 0xFF000000, .gain_a_mask = 0xFF},
+	{ .gain_g = {0x40bc, 0x44bc}, .gain_a = {0x4088, 0x4488},
+	  .gain_g_mask = 0xFF, .gain_a_mask = 0xFF00},
+	{ .gain_g = {0x40bc, 0x44bc}, .gain_a = {0x4088, 0x4488},
+	  .gain_g_mask = 0xFF00, .gain_a_mask = 0xFF0000},
+};
+
 struct rtw8922a_bb_gain_bypass {
 	u32 gain_g[BB_PATH_NUM_8922A];
 	u32 gain_a[BB_PATH_NUM_8922A];
@@ -1057,6 +1093,30 @@ static void rtw8922a_set_lna_tia_gain(struct rtw89_dev *rtwdev,
 		val = gain->tia_gain[gain_band][bw_type][path][i];
 		rtw89_phy_write32_idx(rtwdev, reg, mask, val, phy_idx);
 	}
+
+	for (i = 0; i < LNA_GAIN_NUM; i++) {
+		if (chan->band_type == RTW89_BAND_2G) {
+			reg = bb_op1db_lna[i].gain_g[path];
+			mask = bb_op1db_lna[i].gain_g_mask;
+		} else {
+			reg = bb_op1db_lna[i].gain_a[path];
+			mask = bb_op1db_lna[i].gain_a_mask;
+		}
+		val = gain->lna_op1db[gain_band][bw_type][path][i];
+		rtw89_phy_write32_idx(rtwdev, reg, mask, val, phy_idx);
+	}
+
+	for (i = 0; i < TIA_LNA_OP1DB_NUM; i++) {
+		if (chan->band_type == RTW89_BAND_2G) {
+			reg = bb_op1db_tia_lna[i].gain_g[path];
+			mask = bb_op1db_tia_lna[i].gain_g_mask;
+		} else {
+			reg = bb_op1db_tia_lna[i].gain_a[path];
+			mask = bb_op1db_tia_lna[i].gain_a_mask;
+		}
+		val = gain->tia_lna_op1db[gain_band][bw_type][path][i];
+		rtw89_phy_write32_idx(rtwdev, reg, mask, val, phy_idx);
+	}
 }
 
 static void rtw8922a_set_gain(struct rtw89_dev *rtwdev,
-- 
2.25.1


