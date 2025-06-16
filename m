Return-Path: <linux-wireless+bounces-24131-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74D38ADAB69
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Jun 2025 11:04:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25033170FF0
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Jun 2025 09:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD99A2356BD;
	Mon, 16 Jun 2025 09:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="YE7WPH8Y"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBC41A7253
	for <linux-wireless@vger.kernel.org>; Mon, 16 Jun 2025 09:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750064644; cv=none; b=eBvR2kdFoN4jxak5ZBet/IoEv17QT9oU7RuS5aR2jev/sUz2ssKBOrM9WcMZQb0eeNAdP50qL7pVgtLMemXUuLwwa6hGLca0TL6U4aNWDXA7cZzzhZJSFmHf+z3a1xjDQZYgXsc+yVwyCkHFkV4br+LBBR6Ntv6F5ElsZLXDlpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750064644; c=relaxed/simple;
	bh=YpaF51cBFsHDw49PZnyPwsqTp9UuLBkP6jQ9kiohYnk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mwoHFFhNoG4O5QCMC1xmkMcbgXScT+jhtCW2sC7W9+obVtfBYTD/pVbKeyy1qNTcPB+tuZuOAcp1Ju26SoIfGbtaeHzR+OCakPxGWFOc90YL+fKFA2Sik+EjH7tlP+emLMi6tomm52lkSMOW1vh6ygaOJpVf+Z5cgtFS+KbPvkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=YE7WPH8Y; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 55G940FS0175689, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1750064640; bh=up3ZWljWk6qYfC7h6sjp7C1KSNC9j1OC+oHc3veGqXo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=YE7WPH8Yqf+Lugc17cu/6vD1kuZJRlnV/Ma+gXj8t7lUMHJVsCzkBuAOfCUEG+3aF
	 qA5wbnelzB9ttkh8R4DustR0DDHcBVcuWpRW82GudfZvIPqHhesMcnDq8OyPQe5ZyU
	 woizqNVCQKQS/+C1ViGO4c/DyMTD26oKWA03ildBDWds4EaxBEo75xOqPx+QDEMUKp
	 CpIkxSagymOuQ8rlAO4yZzSLGn92DflAscKJGiH142mh9hroqxaoGiwXbXZTUVsBDg
	 6it9KT2ZpyY1qFPnaAPXyerZfeADrTUERCesyiVKxRPfeSAJTgI2wzg875cuwXHZ72
	 CrV3ftyyFXxZg==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 55G940FS0175689
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 16 Jun 2025 17:04:00 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 16 Jun 2025 17:03:37 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 16 Jun
 2025 17:03:37 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <ku920601@realtek.com>
Subject: [PATCH rtw-next 06/11] wifi: rtw89: coex: Update scoreboard to avoid Bluetooth re-link fail
Date: Mon, 16 Jun 2025 17:02:47 +0800
Message-ID: <20250616090252.51098-7-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250616090252.51098-1-pkshih@realtek.com>
References: <20250616090252.51098-1-pkshih@realtek.com>
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

From: Ching-Te Ku <ku920601@realtek.com>

When platform resume, there will have fail rate when Bluetooth try to
re-link. And when Bluetooth is booting up, it will run the ROM code
first, then load the firmware code from file. Catch this change and
set the mechanism for Bluetooth re-link.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index d34af499e137..399c86288d76 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -7420,6 +7420,8 @@ static void _update_bt_scbd(struct rtw89_dev *rtwdev, bool only_update)
 	bt->rfk_info.map.req = !!(val & BTC_BSCB_RFK_REQ);
 	bt->hi_lna_rx = !!(val & BTC_BSCB_BT_HILNA);
 	bt->link_info.status.map.connect = !!(val & BTC_BSCB_BT_CONNECT);
+	if (bt->run_patch_code != !!(val & BTC_BSCB_PATCH_CODE))
+		status_change = true;
 	bt->run_patch_code = !!(val & BTC_BSCB_PATCH_CODE);
 
 	if (!only_update && status_change)
-- 
2.25.1


