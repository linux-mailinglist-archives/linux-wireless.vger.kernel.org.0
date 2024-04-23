Return-Path: <linux-wireless+bounces-6730-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 031AE8AE762
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Apr 2024 15:06:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B333E28DD6C
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Apr 2024 13:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B64F8134CC0;
	Tue, 23 Apr 2024 13:06:05 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E9013540E
	for <linux-wireless@vger.kernel.org>; Tue, 23 Apr 2024 13:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713877565; cv=none; b=U8opCthtbTewNwVOhuZEHZVrP7yH6a8yqlaJwXyaNtgbvvAYeBAfeh2JOTRweYO5UBe9pkw+qSwiKqXXUFqJ5vhUBhqhZLHYS+2R/qYuu3bHcqNZiYTKzh+hRQF0BZYhRQadJJIVwF71z+Hvj0NR4NKtzwrxXdGrBDju/bn7Y0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713877565; c=relaxed/simple;
	bh=Y0mI56WPoLl5YJ+pvVqt7imgaLMG0F+RMJytgJOiNL0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kHvQ/eLwslzTBWg4pbCoyqs4+fUsCsdcoNIoh54aAAyp8AvnPVgTfRn+TUjRAwU6bTylIx3LiMUVRzJFUJeHTaDrt2CjESWKlg3vsL6b5Ap8frSklmsuhyXzy+d2MYiTlsxhVKeeN/5GaQBh8glBd+LlcobgWNPEUs7PFghE9CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 43ND5w1421251234, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 43ND5w1421251234
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 23 Apr 2024 21:05:59 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 23 Apr 2024 21:05:59 +0800
Received: from [127.0.1.1] (172.16.20.182) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 23 Apr
 2024 21:05:58 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <ku920601@realtek.com>
Subject: [PATCH 7/8] wifi: rtw89: coex: Add Wi-Fi role v8 condition when set BTG control
Date: Tue, 23 Apr 2024 21:05:01 +0800
Message-ID: <20240423130502.32682-8-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240423130502.32682-1-pkshih@realtek.com>
References: <20240423130502.32682-1-pkshih@realtek.com>
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

From: Ching-Te Ku <ku920601@realtek.com>

BTG(A hardware block, which Wi-Fi 2.4Ghz & Bluetooth shared a part
of hardware). Because some information are saved in role info. So the
logic also need to get value from the version 8 role info.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index ab51aa3ffbe1..0942a182976a 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -4713,6 +4713,7 @@ static void _set_btg_ctrl(struct rtw89_dev *rtwdev)
 	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
 	struct rtw89_btc_wl_role_info_v1 *wl_rinfo_v1 = &wl->role_info_v1;
 	struct rtw89_btc_wl_role_info_v2 *wl_rinfo_v2 = &wl->role_info_v2;
+	struct rtw89_btc_wl_role_info_v8 *wl_rinfo_v8 = &wl->role_info_v8;
 	struct rtw89_btc_wl_role_info *wl_rinfo_v0 = &wl->role_info;
 	struct rtw89_btc_wl_dbcc_info *wl_dinfo = &wl->dbcc_info;
 	const struct rtw89_chip_info *chip = rtwdev->chip;
@@ -4733,6 +4734,8 @@ static void _set_btg_ctrl(struct rtw89_dev *rtwdev)
 		wl_rinfo.link_mode = wl_rinfo_v1->link_mode;
 	else if (ver->fwlrole == 2)
 		wl_rinfo.link_mode = wl_rinfo_v2->link_mode;
+	else if (ver->fwlrole == 8)
+		wl_rinfo.link_mode = wl_rinfo_v8->link_mode;
 	else
 		return;
 
@@ -4746,6 +4749,8 @@ static void _set_btg_ctrl(struct rtw89_dev *rtwdev)
 			wl_rinfo.dbcc_2g_phy = wl_rinfo_v1->dbcc_2g_phy;
 		} else if (ver->fwlrole == 2) {
 			wl_rinfo.dbcc_2g_phy = wl_rinfo_v2->dbcc_2g_phy;
+		} else if (ver->fwlrole == 8) {
+			wl_rinfo.dbcc_2g_phy = wl_rinfo_v8->dbcc_2g_phy;
 		} else {
 			return;
 		}
-- 
2.25.1


