Return-Path: <linux-wireless+bounces-30546-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC7EFD03CCA
	for <lists+linux-wireless@lfdr.de>; Thu, 08 Jan 2026 16:24:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B0E21305F616
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Jan 2026 15:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 027D94849EA;
	Thu,  8 Jan 2026 12:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="whuNAywN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465FC484A16
	for <linux-wireless@vger.kernel.org>; Thu,  8 Jan 2026 12:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767873816; cv=none; b=uuPU7B1E6KUFIwwfOkArHy8wRNiF8NLKR9iWedHy4Tb6xxLvOPA6OETLG11zZ9kifJWn+aCoSUZPNRQwqEh5cknAGZCcnYJ6uDMSxLIa0gPO9wHZtF2RuugoWPdsWmSelt1BZMGBXfQX2iLhet8SpfrzPkCXyCyytPqzAXaU9Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767873816; c=relaxed/simple;
	bh=a6pyl+Vj7SDBfBlG2IQb0nHT5o3yZ0Dj1jcvUyfKlK0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lLcQvgfoCa4ogGZj1GLO/kGZr7scWrdYIwZvst0A4MAQiD4/XbYnLeFFxa6bhR4It9ue7WpMegAi9cFZcxoyT8ZNm85uaXYwQLsG9ZFzwl+dOHGrh+2ZBiEVybKemIuNUhC+oMq16hp1D2dGmeZ64xoeTj6RFUmZIZBvXK2ZSe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=whuNAywN; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 608C3UKs8969969, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1767873810; bh=+EJU4Bt3SBHUX1tqVTsj0IFFxPutfDhm1RvCp/IP1dc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=whuNAywNHfMkgmbg4YpWyXgjTR9OmvztH9Ru2jeOOxawE+iJLQm5yy5kdBSh8UD2f
	 czgje5KHHWnlmG3YVhOS3PYOxdOKszpDYeBMxYc/u5GzpO68iCKmMZZ1p5PzBlViCv
	 /JIyFanaYJTDgnlzBnukm/JgyzHGkUWss+VV5VGhARxdWz2BeHFad/9eSMMbfD+eKn
	 acCZANY5UF2kc0vBvuNPv279X/MaSvRGxy5xwAowonl+RmM8fDKI/VizGPLzpnl0nM
	 MU2lQs4l/UpBgAz6fncDqfAuizcWREm3rJiCSkoJ+g02MPYSs8CH6fxPbm6pVWvrCR
	 DYDj1/HhEWXdw==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 608C3UKs8969969
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 8 Jan 2026 20:03:30 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 8 Jan 2026 20:03:30 +0800
Received: from [127.0.1.1] (172.21.40.76) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Thu, 8 Jan 2026 20:03:30 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <leo.li@realtek.com>
Subject: [PATCH rtw-next 02/13] wifi: rtw89: coex: update scoreboard value according to power state for two BT
Date: Thu, 8 Jan 2026 20:03:09 +0800
Message-ID: <20260108120320.2217402-3-pkshih@realtek.com>
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

Assign timeslot to WiFi if power state is on. Since firmware isn't working
at this moment, write scoreboard register to notify BT. Extend the code to
support two BT for coming chips.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 1a53824f58b5..be478540f742 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -1492,13 +1492,27 @@ static int rtw89_mac_pwr_off_func_for_unplugged(struct rtw89_dev *rtwdev)
 	return 0;
 }
 
+static void rtw89_mac_update_scoreboard(struct rtw89_dev *rtwdev, u8 val)
+{
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+	u32 reg;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(chip->btc_sb.n); i++) {
+		reg = chip->btc_sb.n[i].cfg;
+		if (!reg)
+			continue;
+
+		rtw89_write8(rtwdev, reg + 3, val);
+	}
+}
+
 static int rtw89_mac_power_switch(struct rtw89_dev *rtwdev, bool on)
 {
 	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 	const struct rtw89_pwr_cfg * const *cfg_seq;
 	int (*cfg_func)(struct rtw89_dev *rtwdev);
-	u32 reg = chip->btc_sb.n[0].cfg;
 	int ret;
 
 	rtw89_mac_power_switch_boot_mode(rtwdev);
@@ -1538,14 +1552,16 @@ static int rtw89_mac_power_switch(struct rtw89_dev *rtwdev, bool on)
 		set_bit(RTW89_FLAG_POWERON, rtwdev->flags);
 		set_bit(RTW89_FLAG_DMAC_FUNC, rtwdev->flags);
 		set_bit(RTW89_FLAG_CMAC0_FUNC, rtwdev->flags);
-		rtw89_write8(rtwdev, reg + 3, MAC_AX_NOTIFY_TP_MAJOR);
+
+		rtw89_mac_update_scoreboard(rtwdev, MAC_AX_NOTIFY_TP_MAJOR);
 	} else {
 		clear_bit(RTW89_FLAG_POWERON, rtwdev->flags);
 		clear_bit(RTW89_FLAG_DMAC_FUNC, rtwdev->flags);
 		clear_bit(RTW89_FLAG_CMAC0_FUNC, rtwdev->flags);
 		clear_bit(RTW89_FLAG_CMAC1_FUNC, rtwdev->flags);
 		clear_bit(RTW89_FLAG_FW_RDY, rtwdev->flags);
-		rtw89_write8(rtwdev, reg + 3, MAC_AX_NOTIFY_PWR_MAJOR);
+
+		rtw89_mac_update_scoreboard(rtwdev, MAC_AX_NOTIFY_PWR_MAJOR);
 		rtw89_set_entity_state(rtwdev, RTW89_PHY_0, false);
 		rtw89_set_entity_state(rtwdev, RTW89_PHY_1, false);
 	}
-- 
2.25.1


