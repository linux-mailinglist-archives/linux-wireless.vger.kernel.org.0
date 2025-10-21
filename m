Return-Path: <linux-wireless+bounces-28146-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B00B4BF6CCA
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Oct 2025 15:35:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86619423076
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Oct 2025 13:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA1AE338587;
	Tue, 21 Oct 2025 13:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="ZHNrKs+g"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08A3280CFC
	for <linux-wireless@vger.kernel.org>; Tue, 21 Oct 2025 13:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761053668; cv=none; b=oGGhkSIF45ZHWHtqZR7+62ItQh5FW+SvCOjc4kVd628BdFcwTeZ8jJK/oD9jMZ43xY2252G0cBiX6EndzuOAiizwukYMZJArfL3M0HHWVPPPUBv2wTdsfrQEgv1TTSvN2ZJjEB4UkbD4SBA/ahL9s7nqXBGH7nh0l25Y5KSvJIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761053668; c=relaxed/simple;
	bh=+9vx7gy4sPVGQELA/9PT0OtsBp7BKKB/L6/5WuFL/vM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QcnmUwt/9WDaMAMxX5Fqn/BiAhGNWWSh8fcnYuICv/gSjOxBOy/GJ/gU8PEZdgIxWRwNbofTjPO8iMDfkMUGR7FWHSzwDd93ZwpND4ZLRMyJxSFgpZjW31/tBLddE31FnkRlxUWpqw/8hNs8oRciGzuwjbiX6Kr53FPYD4ON9Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=ZHNrKs+g; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 59LDYMZz83088103, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1761053662; bh=ufGNYklE2FeHziSdiZ0Z13US5svZ1c0RrT5gx5T1yfc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=ZHNrKs+gjD4OJdaJstKQfDFMCB3QjdJR9Cl2cxNmmsg9XdTM+tpCLa+ENiBv8JRKy
	 ckSodTO73RqcPPagqSCUfXL8B9LE7rGKvvXcZqUm8O4TQC1GLZRiAuxSsFAzgFT/Jj
	 wOP5BygXxzvj5Ak5nHOp8NBlH+nAx/PmtmqSDhUqnm07mkUQqcuJiPvz+UzblzLIw5
	 lHpGwSJ3gfvI4Ghh8GE8ZfFFKQ4s3pTIsLsBaak4ir0FN0FpGDqAK9x9xelCGGrI+l
	 DwPQWeYqj7S1K1qzCylcDYVpItr1K1ta+lvJM+V9oZcXyOd5CTpW/D7LvvysQQg1zU
	 bY0qoyodFpsUg==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 59LDYMZz83088103
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 21 Oct 2025 21:34:22 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Tue, 21 Oct 2025 21:34:22 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Tue, 21 Oct 2025 21:34:21 +0800
Received: from [127.0.1.1] (10.22.225.127) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27 via Frontend
 Transport; Tue, 21 Oct 2025 21:34:21 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <timlee@realtek.com>, <emma_tsai@realtek.com>, <damon.chen@realtek.com>,
        <kevin_yang@realtek.com>
Subject: [rtw-next 6/8] wifi: rtw89: 8852c: fix ADC oscillation in 160MHz affecting RX performance
Date: Tue, 21 Oct 2025 21:34:00 +0800
Message-ID: <20251021133402.15467-7-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251021133402.15467-1-pkshih@realtek.com>
References: <20251021133402.15467-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Kuan-Chung Chen <damon.chen@realtek.com>

When operating in 160 MHz, the ADC may oscillate and affect AGC, leading
to unstable RX quality. This issue can be resolved by ensuring proper
RF filter bandwidth switching to avoid ADC oscillation.

Signed-off-by: Kuan-Chung Chen <damon.chen@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 .../net/wireless/realtek/rtw89/rtw8852c_rfk.c | 59 ++++++++++++-------
 1 file changed, 39 insertions(+), 20 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c
index e7fd028c5e82..cbee484dee30 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c
@@ -3987,37 +3987,56 @@ static void _ctrl_ch(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 	}
 }
 
+static void _set_rxbb_bw(struct rtw89_dev *rtwdev, enum rtw89_rf_path path,
+			 enum rtw89_bandwidth bw)
+{
+	u32 val;
+
+	rtw89_write_rf(rtwdev, path, RR_LUTWE2, RR_LUTWE2_RTXBW, 0x1);
+	rtw89_write_rf(rtwdev, path, RR_LUTWA, RR_LUTWA_M2, 0xa);
+
+	switch (bw) {
+	case RTW89_CHANNEL_WIDTH_20:
+		val = 0x1b;
+		break;
+	case RTW89_CHANNEL_WIDTH_40:
+		val = 0x13;
+		break;
+	case RTW89_CHANNEL_WIDTH_80:
+		val = 0xb;
+		break;
+	case RTW89_CHANNEL_WIDTH_160:
+	default:
+		val = 0x3;
+		break;
+	}
+
+	rtw89_write_rf(rtwdev, path, RR_LUTWD0, RR_LUTWD0_LB, val);
+	rtw89_write_rf(rtwdev, path, RR_LUTWE2, RR_LUTWE2_RTXBW, 0x0);
+}
+
+static void _set_tia_bw(struct rtw89_dev *rtwdev, enum rtw89_rf_path path,
+			enum rtw89_bandwidth bw)
+{
+	if (bw == RTW89_CHANNEL_WIDTH_160)
+		rtw89_write_rf(rtwdev, path, RR_RXBB2, RR_RXBB2_EBW, 0x0);
+	else
+		rtw89_write_rf(rtwdev, path, RR_RXBB2, RR_RXBB2_EBW, 0x2);
+}
+
 static void _rxbb_bw(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 		     enum rtw89_bandwidth bw)
 {
 	u8 kpath;
 	u8 path;
-	u32 val;
 
 	kpath = _kpath(rtwdev, phy);
 	for (path = 0; path < 2; path++) {
 		if (!(kpath & BIT(path)))
 			continue;
 
-		rtw89_write_rf(rtwdev, path, RR_LUTWE2, RR_LUTWE2_RTXBW, 0x1);
-		rtw89_write_rf(rtwdev, path, RR_LUTWA, RR_LUTWA_M2, 0xa);
-		switch (bw) {
-		case RTW89_CHANNEL_WIDTH_20:
-			val = 0x1b;
-			break;
-		case RTW89_CHANNEL_WIDTH_40:
-			val = 0x13;
-			break;
-		case RTW89_CHANNEL_WIDTH_80:
-			val = 0xb;
-			break;
-		case RTW89_CHANNEL_WIDTH_160:
-		default:
-			val = 0x3;
-			break;
-		}
-		rtw89_write_rf(rtwdev, path, RR_LUTWD0, RR_LUTWD0_LB, val);
-		rtw89_write_rf(rtwdev, path, RR_LUTWE2, RR_LUTWE2_RTXBW, 0x0);
+		_set_rxbb_bw(rtwdev, path, bw);
+		_set_tia_bw(rtwdev, path, bw);
 	}
 }
 
-- 
2.25.1


