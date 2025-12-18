Return-Path: <linux-wireless+bounces-29891-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 62B64CCA7D6
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Dec 2025 07:36:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C88030A24AA
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Dec 2025 06:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E3A0328616;
	Thu, 18 Dec 2025 06:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="U3OvR04L"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5755232861F
	for <linux-wireless@vger.kernel.org>; Thu, 18 Dec 2025 06:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766039556; cv=none; b=RdnwxujPl10gCp3SIJRGubtOHV7x//L4ktj52NXzZaSk0/7lD7N2AR8k2+4yuiwW7eVLtThQKcFDJGe7gL9JRUZIIIk77xHudF/sGPZiYrZClqFmZvlN8F36bFcIDuuIeoM15paGuVuSMeq7BkMneWeoc/rh+tWVJwYmpu3822A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766039556; c=relaxed/simple;
	bh=G8NmO7raQcN+UPy9AqVJ3Na//xgJ4LYKgEsKrtJEUNQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tIIcQxF6nUhRIdOO8dDsOzbOEhvMNqRFu1Tt0CivRNAeWnmOXjcmjZ9e5iEtT1kQm+6yYBYYYG7QPNBpmmId7me4HtB3nNxGVSdnAdaGVZwXK6oVYlbNj9if0p06kl0CGSQ4X57pg5edlYmn6vVyZEMfjlJWEHISi3f/d/WQnQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=U3OvR04L; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5BI6WUnT43338889, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1766039550; bh=IWt02l9itK31A4R/+5eOF9r55IC7fsYTFMcWX6yk7/4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=U3OvR04Lz8KFUtKavLONpxM4sa6SNSqiN69sv22CBs1iSCnwS0e4i9GnpagvcCGDz
	 sIi860DOs3UKyfK2HUVU9ICOUFmHIdU8SDamj/40cuJagOLpRyjJQzyZmHXbx1pKS/
	 CgcxQVSn6B4UXHoc+EHVu0OmgQhYt3I+apHVKRlRxH2D5bE4SGNHpANzZ98O6HaZ8E
	 azpwF/M6/kWs4BKbHAb+dc29eVoQpvOWh+dLv4Tq/M57TzvGuFz7dSP7MUAVVAD9WP
	 iZUWyVEYf/xBzA1QspN5j6DLDnUL1Jxbo2mcJH1eNNdF1L4Hoa8eJpYX8TySMPx8hb
	 F2Rekh7CdIfgA==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5BI6WUnT43338889
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 18 Dec 2025 14:32:30 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 18 Dec 2025 14:32:30 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Thu, 18 Dec 2025 14:32:30 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <damon.chen@realtek.com>,
        <kevin_yang@realtek.com>
Subject: [PATCH rtw-next v2 10/12] wifi: rtw89: warn unexpected polling value of XTAL SI
Date: Thu, 18 Dec 2025 14:31:15 +0800
Message-ID: <20251218063117.26278-11-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251218063117.26278-1-pkshih@realtek.com>
References: <20251218063117.26278-1-pkshih@realtek.com>
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
v2: handle USB being unplugged case to avoid warnings.
---
 drivers/net/wireless/realtek/rtw89/mac.c    | 31 +++++++++++++++++++--
 drivers/net/wireless/realtek/rtw89/mac_be.c | 13 ++++++++-
 2 files changed, 40 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index e5f2fa3b2b37..8987077bf756 100644
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
@@ -7033,6 +7047,12 @@ int rtw89_mac_write_xtal_si_ax(struct rtw89_dev *rtwdev, u8 offset, u8 val, u8 m
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
 
@@ -7056,7 +7076,12 @@ int rtw89_mac_read_xtal_si_ax(struct rtw89_dev *rtwdev, u8 offset, u8 *val)
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


