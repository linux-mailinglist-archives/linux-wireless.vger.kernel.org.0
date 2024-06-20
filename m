Return-Path: <linux-wireless+bounces-9270-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D7EF90FC73
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2024 07:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F6061C20D14
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2024 05:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DBB639879;
	Thu, 20 Jun 2024 05:59:04 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B59C383AE
	for <linux-wireless@vger.kernel.org>; Thu, 20 Jun 2024 05:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718863144; cv=none; b=JMWSBrf/VRyuA6r2MrYR0htVoUfUQspY9s73INVnEabwbOB/FApIkRwNnB/PeIt60b6sSFuM4BqJ0cZ06ffJtTZZCFMZ8TkYk4jxX6bCGFdsHf1pEp/oOfy4eK8eyEozMC0YNrTTeynzvgMCEmgFJX6yl6TVAEdABa68gbrwZro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718863144; c=relaxed/simple;
	bh=61owA6kjwV2egwSEMKtGTUx1YK31mCoXSShR2fI6dKs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=teBv+0Yz8g67KO0owdQ9nvEi8BiwBa1QdzHk7dm7aEo4Fkts6TMnGkX73JhU38F2PJlgJ5xBt/Mn7BYkn0lWEWn+ZXJ739oxLC5A/uOoovdQFon2LYIraHUOpWmYTd+MnhJl/Cq7pFqXj+9NAP6W1Z/Bp6R6aJT8VYA84iMDC9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 45K5x0Vi92577703, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 45K5x0Vi92577703
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 20 Jun 2024 13:59:00 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 20 Jun 2024 13:59:00 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 20 Jun
 2024 13:58:58 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>
Subject: [PATCH 6/7] wifi: rtw89: wow: enable beacon filter after swapping firmware
Date: Thu, 20 Jun 2024 13:58:24 +0800
Message-ID: <20240620055825.17592-7-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240620055825.17592-1-pkshih@realtek.com>
References: <20240620055825.17592-1-pkshih@realtek.com>
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

From: Chih-Kang Chang <gary.chang@realtek.com>

To avoid wake up by AP disconnection, but no beacon filter setting and
driver can't disconnect successfully. We need to enable beacon filter
after swapping firmware in WoWLAN mode.

Signed-off-by: Chih-Kang Chang <gary.chang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/wow.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/wow.c b/drivers/net/wireless/realtek/rtw89/wow.c
index a49265cda98f..9882064ef68d 100644
--- a/drivers/net/wireless/realtek/rtw89/wow.c
+++ b/drivers/net/wireless/realtek/rtw89/wow.c
@@ -1295,12 +1295,16 @@ static int rtw89_wow_disable_trx_pre(struct rtw89_dev *rtwdev)
 
 static int rtw89_wow_disable_trx_post(struct rtw89_dev *rtwdev)
 {
+	struct rtw89_wow_param *rtw_wow = &rtwdev->wow;
+	struct ieee80211_vif *vif = rtw_wow->wow_vif;
 	int ret;
 
 	ret = rtw89_mac_cfg_ppdu_status(rtwdev, RTW89_MAC_0, true);
 	if (ret)
 		rtw89_err(rtwdev, "cfg ppdu status\n");
 
+	rtw89_fw_h2c_set_bcn_fltr_cfg(rtwdev, vif, true);
+
 	return ret;
 }
 
-- 
2.25.1


