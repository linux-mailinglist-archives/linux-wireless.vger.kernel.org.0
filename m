Return-Path: <linux-wireless+bounces-4319-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB1686EDB0
	for <lists+linux-wireless@lfdr.de>; Sat,  2 Mar 2024 02:00:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1878D286F16
	for <lists+linux-wireless@lfdr.de>; Sat,  2 Mar 2024 01:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2D5DF519;
	Sat,  2 Mar 2024 01:00:01 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0F9B662
	for <linux-wireless@vger.kernel.org>; Sat,  2 Mar 2024 00:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709341201; cv=none; b=sdki85PUtxpd3kiNl8MgtZqNDrSt5Nx1KOAev3vbZe3YoK00+Urm5cycOVhLUMLnFqGQn27/reTmCYHy4qzXatIlA5zjvUOvrYRchs++iH+hWroG0C1KceaSsSZZ4XYX+sL3CFtaDd6U2fZIPaUyPuMAsII4RSR99GvyOXWvDLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709341201; c=relaxed/simple;
	bh=WJGJVMPQWM52lZHtpSxcLiAmDlTZSxbJDipplqmO0T0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=onmKn5Ue4Iftfe4A/fncVEO8xpVmKNl6NxOPdKqaPr/OLeYZJB49Jxr7ekiUxldAkJGE38OGhWRZHdK+79Ppt7YyRUzdm7hGBvhftVd9x3fgerzc4voBmRr7QVfJknZMhD6HYuFAzrP1Zz2ya5o1N8qKrq8zRsAQEXTyC7rRoG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4220xsTdB2370306, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4220xsTdB2370306
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 2 Mar 2024 08:59:54 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.17; Sat, 2 Mar 2024 08:59:55 +0800
Received: from [127.0.1.1] (172.16.16.155) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Sat, 2 Mar
 2024 08:59:54 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <timlee@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 6/7] wifi: rtw89: wow: set security engine options for 802.11ax chips only
Date: Sat, 2 Mar 2024 08:58:27 +0800
Message-ID: <20240302005828.13666-7-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240302005828.13666-1-pkshih@realtek.com>
References: <20240302005828.13666-1-pkshih@realtek.com>
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

From: Chin-Yen Lee <timlee@realtek.com>

The security engine is set for management frames by default for 802.11be
chips, so no need to set it in WoWLAN flow.

Signed-off-by: Chin-Yen Lee <timlee@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 38124f9a178b..521decd932c0 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -2025,6 +2025,9 @@ void rtw89_mac_hw_mgnt_sec(struct rtw89_dev *rtwdev, bool enable)
 {
 	u32 msk32 = B_AX_UC_MGNT_DEC | B_AX_BMC_MGNT_DEC;
 
+	if (rtwdev->chip->chip_gen != RTW89_CHIP_AX)
+		return;
+
 	if (enable)
 		rtw89_write32_set(rtwdev, R_AX_SEC_ENG_CTRL, msk32);
 	else
-- 
2.25.1


