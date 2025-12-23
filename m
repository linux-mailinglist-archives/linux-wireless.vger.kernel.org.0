Return-Path: <linux-wireless+bounces-30067-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 76755CD7F19
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Dec 2025 04:08:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8DC3330528FE
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Dec 2025 03:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB2702D12F3;
	Tue, 23 Dec 2025 03:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="iDt2xUYn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DA72D0620
	for <linux-wireless@vger.kernel.org>; Tue, 23 Dec 2025 03:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766459284; cv=none; b=mzsfwDXqy9drhe9HT6dt3P0jBuqxOhfYt1SiH4gkoiViFwCZmO9Y+eS2PU3xm+n/JMRxfTabg2FhEYU1/RNPSUL2hiC8Fj7s3XMr4x+D55jqIEqt7rd83HjOfAvbUZkkba0FNIAGWE93q8gMcUuFSRP2eyH2R/kd7m9F/5+RRqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766459284; c=relaxed/simple;
	bh=C3mTMCfFA6KPHV0vdpFmSEnLHgG9VYaKHf96utJomXg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UPFnj04+Ug1nmCcaAhcnwG2kFJ1mWJCiKYt4PKNsD9tUGqznNbDDLDRxvjQaO4WbNhyLK6ZFRDU8TJSUwmP7bF0HArEYegBQYs/LiqPyhqVrgE8ww1xIPVzp+Ypz1buuaqp1Bt7+0w7RRwumDDl5Mt0wX6poQLwXXNNyyIh+MSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=iDt2xUYn; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5BN380Of8571273, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1766459280; bh=8IufgNTca5vWN+3WYFWQq7pu6yBkfSdIIiOUG7ovCHY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=iDt2xUYn6CGrkZbrvLtgbu/NqGoKcaeIZ41Jlze0FMNUHm65xMK5przwluVm1XCFR
	 iBMkJpYl8mNbpSat4h1uH9Ui/aYi0w5ZeSwghbjkH2KbqLO/2uiomL8Cfsam2NUGZP
	 hHZUXyd3bB4fNPUuTCNaG20l/wluBCGiM7d3yrO8TrM3K6u9GSTxjcJoGaxaEDifOF
	 J5EFqlrAEwBZpkL0C/baHPb8UCeF9iYACD03hZ149r0kRs9TKSxpXD6oTyWbqb3hST
	 94Sh6RQl5ps0DttIX78TpH9+z61GLdGqOAnvFQNNzkwkJAPQeKQS7XU9UJwvNfpjGX
	 bi09H3GvGUZ/Q==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5BN380Of8571273
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 23 Dec 2025 11:08:00 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 23 Dec 2025 11:08:00 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 23 Dec 2025 11:07:59 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Tue, 23 Dec 2025 11:07:59 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <damon.chen@realtek.com>,
        <kevin_yang@realtek.com>
Subject: [PATCH rtw-next v3 10/12] wifi: rtw89: warn unexpected polling value of XTAL SI
Date: Tue, 23 Dec 2025 11:06:49 +0800
Message-ID: <20251223030651.480633-11-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251223030651.480633-1-pkshih@realtek.com>
References: <20251223030651.480633-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

XTAL SI is an indirect serial interface to access registers in another
hardware domain. When BT driver initializes UART interface, firmware might
rarely control XTAL SI at the same time causing access racing.

Current is to adjust initialization flow to avoid the racing. To make
the racing visible if it still presents, add a message to address this.

USB adapters might be unplugged suddenly, causing flooding messages. Check
RTW89_FLAG_UNPLUGGED flag to avoid them.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
v3: no change
v2: handle USB being unplugged case to avoid warnings.
---
 drivers/net/wireless/realtek/rtw89/mac.c    | 31 +++++++++++++++++++--
 drivers/net/wireless/realtek/rtw89/mac_be.c | 13 ++++++++-
 2 files changed, 40 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 637fbf15a850..7cbe3ffd5dc8 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -1483,6 +1483,15 @@ static void rtw89_mac_power_switch_boot_mode(struct rtw89_dev *rtwdev)
 	rtw89_write32_clr(rtwdev, R_AX_RSV_CTRL, B_AX_R_DIS_PRST);
 }
 
+static int rtw89_mac_pwr_off_func_for_unplugged(struct rtw89_dev *rtwdev)
+{
+	/*
+	 * Avoid accessing IO for unplugged power-off to prevent warnings,
+	 * especially XTAL SI.
+	 */
+	return 0;
+}
+
 static int rtw89_mac_power_switch(struct rtw89_dev *rtwdev, bool on)
 {
 	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
@@ -1497,8 +1506,13 @@ static int rtw89_mac_power_switch(struct rtw89_dev *rtwdev, bool on)
 		cfg_seq = chip->pwr_on_seq;
 		cfg_func = chip->ops->pwr_on_func;
 	} else {
-		cfg_seq = chip->pwr_off_seq;
-		cfg_func = chip->ops->pwr_off_func;
+		if (test_bit(RTW89_FLAG_UNPLUGGED, rtwdev->flags)) {
+			cfg_seq = NULL;
+			cfg_func = rtw89_mac_pwr_off_func_for_unplugged;
+		} else {
+			cfg_seq = chip->pwr_off_seq;
+			cfg_func = chip->ops->pwr_off_func;
+		}
 	}
 
 	if (test_bit(RTW89_FLAG_FW_RDY, rtwdev->flags))
@@ -6969,6 +6983,12 @@ int rtw89_mac_write_xtal_si_ax(struct rtw89_dev *rtwdev, u8 offset, u8 val, u8 m
 		return ret;
 	}
 
+	if (!test_bit(RTW89_FLAG_UNPLUGGED, rtwdev->flags) &&
+	    (u32_get_bits(val32, B_AX_WL_XTAL_SI_ADDR_MASK) != offset ||
+	     u32_get_bits(val32, B_AX_WL_XTAL_SI_DATA_MASK) != val))
+		rtw89_warn(rtwdev, "xtal si write: offset=%x val=%x poll=%x\n",
+			   offset, val, val32);
+
 	return 0;
 }
 
@@ -6992,7 +7012,12 @@ int rtw89_mac_read_xtal_si_ax(struct rtw89_dev *rtwdev, u8 offset, u8 *val)
 		return ret;
 	}
 
-	*val = rtw89_read8(rtwdev, R_AX_WLAN_XTAL_SI_CTRL + 1);
+	if (!test_bit(RTW89_FLAG_UNPLUGGED, rtwdev->flags) &&
+	    u32_get_bits(val32, B_AX_WL_XTAL_SI_ADDR_MASK) != offset)
+		rtw89_warn(rtwdev, "xtal si read: offset=%x poll=%x\n",
+			   offset, val32);
+
+	*val = u32_get_bits(val32, B_AX_WL_XTAL_SI_DATA_MASK);
 
 	return 0;
 }
diff --git a/drivers/net/wireless/realtek/rtw89/mac_be.c b/drivers/net/wireless/realtek/rtw89/mac_be.c
index 2bc329c13443..c0204e68c172 100644
--- a/drivers/net/wireless/realtek/rtw89/mac_be.c
+++ b/drivers/net/wireless/realtek/rtw89/mac_be.c
@@ -396,6 +396,12 @@ int rtw89_mac_write_xtal_si_be(struct rtw89_dev *rtwdev, u8 offset, u8 val, u8 m
 		return ret;
 	}
 
+	if (!test_bit(RTW89_FLAG_UNPLUGGED, rtwdev->flags) &&
+	    (u32_get_bits(val32, B_BE_WL_XTAL_SI_ADDR_MASK) != offset ||
+	     u32_get_bits(val32, B_BE_WL_XTAL_SI_DATA_MASK) != val))
+		rtw89_warn(rtwdev, "xtal si write: offset=%x val=%x poll=%x\n",
+			   offset, val, val32);
+
 	return 0;
 }
 
@@ -420,7 +426,12 @@ int rtw89_mac_read_xtal_si_be(struct rtw89_dev *rtwdev, u8 offset, u8 *val)
 		return ret;
 	}
 
-	*val = rtw89_read8(rtwdev, R_BE_WLAN_XTAL_SI_CTRL + 1);
+	if (!test_bit(RTW89_FLAG_UNPLUGGED, rtwdev->flags) &&
+	    u32_get_bits(val32, B_BE_WL_XTAL_SI_ADDR_MASK) != offset)
+		rtw89_warn(rtwdev, "xtal si read: offset=%x poll=%x\n",
+			   offset, val32);
+
+	*val = u32_get_bits(val32, B_BE_WL_XTAL_SI_DATA_MASK);
 
 	return 0;
 }
-- 
2.25.1


