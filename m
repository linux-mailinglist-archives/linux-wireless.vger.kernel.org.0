Return-Path: <linux-wireless+bounces-6917-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B538B3017
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Apr 2024 08:12:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21E472814C3
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Apr 2024 06:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 474132F2F;
	Fri, 26 Apr 2024 06:12:26 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2C413A3EF
	for <linux-wireless@vger.kernel.org>; Fri, 26 Apr 2024 06:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714111946; cv=none; b=eLdK6g+X1fP9LC46l/wK0NV9955jsKO1ZaT0nezENhLjnANhyjiSe9txgBr4TbDuZKBua/teSc+9QfqqIBhfDDhYZUfZMozE+EonwNjNQDpKrVfOA0fpH94v4UrIDE3sr5LQIY+8QSFdbkMICVqC9y3tlK9ZZxmdOPiq2APRYBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714111946; c=relaxed/simple;
	bh=ZvmgOAgf8gGn89mkhf+6H/UZ9rz2cCID22Qqhup9omU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UgO1a+UJP6HfW8sQZJMAVES5ls74DXq4xnN9MsodfnvAclmwY42om7uwKDsWRk5ef6aQ/jqA8pTVcyVdPlwoTCRLB9B4d1OqgeGmjeTFrF8TDDEBHQyuD5oPrsHMEOvEfAV6joMaLxm/x8MwGzEwMKGPrmqDxDlQ5K0L9IO088k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 43Q6CLxH4161678, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 43Q6CLxH4161678
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 26 Apr 2024 14:12:21 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 26 Apr 2024 14:12:21 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 26 Apr
 2024 14:12:20 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <leo.li@realtek.com>, <timlee@realtek.com>
Subject: [PATCH 2/2] wifi: rtw89: 8852c: refine power sequence to imporve power consumption
Date: Fri, 26 Apr 2024 14:12:00 +0800
Message-ID: <20240426061200.44262-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240426061200.44262-1-pkshih@realtek.com>
References: <20240426061200.44262-1-pkshih@realtek.com>
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
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

From: Chia-Yuan Li <leo.li@realtek.com>

Power sequence is a flow to enable/disable WiFi card with hardware
parameters. Adjust power and clock parameters according to results
of internal simulation and verification, so apply them to have better
power consumption.

Signed-off-by: Chia-Yuan Li <leo.li@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/rtw8852c.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index efc772eb79a4..3571b41786d7 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -203,6 +203,9 @@ static int rtw8852c_pwr_on_func(struct rtw89_dev *rtwdev)
 	rtw89_write32_clr(rtwdev, R_AX_SYS_PW_CTRL, B_AX_APDM_HPDN);
 	rtw89_write32_clr(rtwdev, R_AX_SYS_PW_CTRL, B_AX_APFM_SWLPS);
 
+	rtw89_write32_mask(rtwdev, R_AX_SPS_DIG_ON_CTRL0,
+			   B_AX_OCP_L1_MASK, 0x7);
+
 	ret = read_poll_timeout(rtw89_read32, val32, val32 & B_AX_RDY_SYSPWR,
 				1000, 20000, false, rtwdev, R_AX_SYS_PW_CTRL);
 	if (ret)
@@ -266,7 +269,7 @@ static int rtw8852c_pwr_on_func(struct rtw89_dev *rtwdev)
 	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_ANAPAR_WL, 0, XTAL_SI_SRAM2RFC);
 	if (ret)
 		return ret;
-	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_XTAL_XMD_2, 0, XTAL_SI_LDO_LPS);
+	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_XTAL_XMD_2, 0x10, XTAL_SI_LDO_LPS);
 	if (ret)
 		return ret;
 	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_XTAL_XMD_4, 0, XTAL_SI_LPS_CAP);
@@ -361,8 +364,11 @@ static int rtw8852c_pwr_off_func(struct rtw89_dev *rtwdev)
 	if (ret)
 		return ret;
 
-	rtw89_write32(rtwdev, R_AX_WLLPS_CTRL, 0x0001A0B0);
+	rtw89_write32(rtwdev, R_AX_WLLPS_CTRL, SW_LPS_OPTION);
 	rtw89_write32_set(rtwdev, R_AX_SYS_PW_CTRL, B_AX_XTAL_OFF_A_DIE);
+	rtw89_write32_set(rtwdev, R_AX_SYS_SWR_CTRL1, B_AX_SYM_CTRL_SPS_PWMFREQ);
+	rtw89_write32_mask(rtwdev, R_AX_SPS_DIG_ON_CTRL0,
+			   B_AX_REG_ZCDC_H_MASK, 0x3);
 	rtw89_write32_set(rtwdev, R_AX_SYS_PW_CTRL, B_AX_APFM_SWLPS);
 
 	return 0;
-- 
2.25.1


