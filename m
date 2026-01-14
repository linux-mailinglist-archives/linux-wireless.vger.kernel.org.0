Return-Path: <linux-wireless+bounces-30802-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A889AD1BF88
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jan 2026 02:41:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C669430049FC
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jan 2026 01:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D92D2874E1;
	Wed, 14 Jan 2026 01:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="kwBtiZyC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE411B6527
	for <linux-wireless@vger.kernel.org>; Wed, 14 Jan 2026 01:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768354876; cv=none; b=c96GV2qLCOqHHbmwXBdkxaMeg/Ul7mcPV9b0kP013Dumjae4Qt3c4Lv3MyW791g5eTyGFOg3ylohymAVrYcy4H/RI93tMklTB7kNKFb4r4SkApK7WzDaz2HmaU/WOW2VkfRtCYHEYAQ8NLm8pyIrcFAR0QFDf33Rfi/XppizHVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768354876; c=relaxed/simple;
	bh=+7W33IjlD9nJkcYDD7tUWYp8Fj2wDl73uAx17vpUSTY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=skOZHnF5GQhsZDbPRGrP0tMnIl5Fc7oE8lakrOrBlwwv90Ke0eqKRYsyEfrsFQrDWTzRYt5LhFPRl+oNlGCasZHHRj6SENrTgVSeLvO7ROaOPz1+eGJ7tCZZi2o5dJ1x5pnVMOuOhMkKf9TbjJp4I5qD/8St5IXDeYit8+PQ31w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=kwBtiZyC; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 60E1fCTV14168647, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1768354872; bh=KKc8p+wx75OLIeCjlh4EuNoEM0kMTb1qpFpvOXemDSM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=kwBtiZyCSZCN3XGrX/7qKmE6dJN6oxdpZuACxolt/pHdetfa3x/aWP29EEb3V9ExH
	 Sd1TGja+LehZ57wXzH6BrV1mRfgaYwS661qAdWNkjARfeuTh5pw7LXPwE/5rYuiWh6
	 by+2cczWrhC+tx9FUt7nxV6LbITz/N2Bd8KYnDzaRk79WUJcDJEwWSBSzZaI+Zt42O
	 NDvENNeQ6m5Xk3WPLNdvD3zbW+2n1Lhhl9MtBlJaZJI3ZTz1FFqYAtOgjKRmEsEVON
	 LTkbAl6JQltcPxvJ9vI/o+b29fdo5Q2Z+XAiOepZzINgsP/v+mJROIDzcdh5DsroO4
	 Ds8Lo8pENAL3w==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 60E1fCTV14168647
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 14 Jan 2026 09:41:12 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 14 Jan 2026 09:41:12 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Wed, 14 Jan 2026 09:41:12 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <echuang@realtek.com>, <phhuang@realtek.com>
Subject: [PATCH rtw-next 10/12] wifi: rtw89: phy: refine initial flow of BB wrapper
Date: Wed, 14 Jan 2026 09:39:48 +0800
Message-ID: <20260114013950.19704-11-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260114013950.19704-1-pkshih@realtek.com>
References: <20260114013950.19704-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Set initial value of TX power and TX path per MAC ID to 0x0, and reorder
initial flow as vendor driver does.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/phy_be.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/phy_be.c b/drivers/net/wireless/realtek/rtw89/phy_be.c
index d037bbb907a8..2dbc194eb329 100644
--- a/drivers/net/wireless/realtek/rtw89/phy_be.c
+++ b/drivers/net/wireless/realtek/rtw89/phy_be.c
@@ -461,7 +461,7 @@ void rtw89_phy_bb_wrap_pwr_by_macid_init(struct rtw89_dev *rtwdev)
 
 	for (macid_idx = 0; macid_idx < 4 * max_macid; macid_idx += 4) {
 		cr = base_macid_lmt + macid_idx;
-		rtw89_write_bb_wrap_flush(rtwdev, cr, 0x03007F7F);
+		rtw89_write_bb_wrap_flush(rtwdev, cr, 0);
 	}
 }
 
@@ -474,7 +474,7 @@ void rtw89_phy_bb_wrap_tx_path_by_macid_init(struct rtw89_dev *rtwdev)
 	int i, max_macid = 32;
 
 	for (i = 0; i < max_macid; i++, cr += 4)
-		rtw89_write_bb_wrap_flush(rtwdev, cr, 0x03C86000);
+		rtw89_write_bb_wrap_flush(rtwdev, cr, 0);
 }
 
 static void rtw89_phy_bb_wrap_tpu_set_all(struct rtw89_dev *rtwdev,
@@ -902,13 +902,13 @@ static void rtw89_phy_bb_wrap_ul_pwr(struct rtw89_dev *rtwdev)
 static void __rtw89_phy_bb_wrap_init_be(struct rtw89_dev *rtwdev,
 					enum rtw89_mac_idx mac_idx)
 {
-	rtw89_phy_bb_wrap_pwr_by_macid_init(rtwdev);
 	rtw89_phy_bb_wrap_tx_path_by_macid_init(rtwdev);
-	rtw89_phy_bb_wrap_listen_path_en_init(rtwdev);
-	rtw89_phy_bb_wrap_force_cr_init(rtwdev, mac_idx);
-	rtw89_phy_bb_wrap_ftm_init(rtwdev, mac_idx);
+	rtw89_phy_bb_wrap_pwr_by_macid_init(rtwdev);
 	rtw89_phy_bb_wrap_tpu_set_all(rtwdev, mac_idx);
 	rtw89_phy_bb_wrap_tx_rfsi_ctrl_init(rtwdev, mac_idx);
+	rtw89_phy_bb_wrap_force_cr_init(rtwdev, mac_idx);
+	rtw89_phy_bb_wrap_ftm_init(rtwdev, mac_idx);
+	rtw89_phy_bb_wrap_listen_path_en_init(rtwdev);
 	rtw89_phy_bb_wrap_ul_pwr(rtwdev);
 }
 
-- 
2.25.1


