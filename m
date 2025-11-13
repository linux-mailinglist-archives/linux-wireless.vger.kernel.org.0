Return-Path: <linux-wireless+bounces-28888-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E74C557D1
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Nov 2025 03:58:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9FEC3ADC56
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Nov 2025 02:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E2D25BEE8;
	Thu, 13 Nov 2025 02:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="NXRr2rTY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13F1246333
	for <linux-wireless@vger.kernel.org>; Thu, 13 Nov 2025 02:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763002655; cv=none; b=gqVw4T3nVlc/sIEn8kJzq3UcxUsIa3072/P3PC00JnRppFgB6q86dZr+xphL1QAF4ZooEfcZEsDZLNEt0GhS1x1WDV/lhJOAoAfeAbgS7ZbdJiWmktjDo9acKHCqFFzKKHmVrqcPL3hUBxzpPWIHb/fqzBoWNSwgm3ez1Vsw9lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763002655; c=relaxed/simple;
	bh=Lrll6NYLhwrGFMksZ4pzhPVrOe5cYBEoIn3y0M4Kr0A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IQYsM08N5iJ9nya6QDA0DmOhnp4iaSNt3AHJyg7nPQrKBIRBsOZa2Usfg9KotkU/hN+PbYTuUYI9kN3Hq62GygHKsO15v1c/CJypDt28O48eINJgYSuiWxZ5P2G0EMLUUtmj3YQ2w7TnAippckV5xkcYpMNCepIJU5txIWARgxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=NXRr2rTY; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5AD2vVsM52839421, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1763002652; bh=PYcB4r7v644STgkTR1FbQclGPIadhrkG9o49LjK/gic=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=NXRr2rTYsts/tIZ+PK8Vfb9i8tp4E86/17u2kSees/7hzXavhOeVKf01dgG99jz5r
	 tKkk4TvOxyz9hPxoYoIpdZaW/xmtRoDASLtINSferRnrcT1pOCLRA94ztxM08h75uP
	 sGnNcoWC7YgYmMbTTkpKAVYtIU2z1Lc++VAHAszkT6yI5A7WConQaDH+NrI4/JYsUz
	 8EOSz9U1WsiCSqiJ20axs5D4VrJnLqOZ51nNVSUuL/QY0S29dMxnfgMQlbbWqQ+wES
	 OhKmOIXTTbzxW7fFSSDv3TNMib/8dbohOE4snc4EoVEQyTDoVefOgfKNqfBKguJ2MZ
	 2SPTDNMzt7WAQ==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5AD2vVsM52839421
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 13 Nov 2025 10:57:31 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Thu, 13 Nov 2025 10:57:32 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27 via Frontend
 Transport; Thu, 13 Nov 2025 10:57:32 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>
Subject: [PATCH rtw-next 07/14] wifi: rtw89: phy: consider type 15 in BB gain table
Date: Thu, 13 Nov 2025 10:56:13 +0800
Message-ID: <20251113025620.31086-8-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251113025620.31086-1-pkshih@realtek.com>
References: <20251113025620.31086-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

BB gain table is a table to configure gain for certain channels. Newly
added type 15 is considered to write registers accordingly.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/phy_be.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/phy_be.c b/drivers/net/wireless/realtek/rtw89/phy_be.c
index 3316a38a62d0..bd17714f13d1 100644
--- a/drivers/net/wireless/realtek/rtw89/phy_be.c
+++ b/drivers/net/wireless/realtek/rtw89/phy_be.c
@@ -266,6 +266,10 @@ static void rtw89_phy_config_bb_gain_be(struct rtw89_dev *rtwdev,
 	case 3:
 		rtw89_phy_cfg_bb_gain_op1db_be(rtwdev, arg, reg->data);
 		break;
+	case 15:
+		rtw89_phy_write32_idx(rtwdev, reg->addr & 0xFFFFF, MASKHWORD,
+				      reg->data, RTW89_PHY_0);
+		break;
 	case 4:
 		/* This cfg_type is only used by rfe_type >= 50 with eFEM */
 		if (efuse->rfe_type < 50)
-- 
2.25.1


