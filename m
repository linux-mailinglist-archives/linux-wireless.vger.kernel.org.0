Return-Path: <linux-wireless+bounces-10470-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BE90C93AC3D
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jul 2024 07:27:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58552B21E8E
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jul 2024 05:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0206225632;
	Wed, 24 Jul 2024 05:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="Fnztm1lj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0997F208D7
	for <linux-wireless@vger.kernel.org>; Wed, 24 Jul 2024 05:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721798817; cv=none; b=YuqUc98DV9I3TeZz10jEtuMXL2Fd5YleJpna69SUx6Rpe2zinsKGBAqc33DR+Dl2Til7TdfvlMl0NJkeFbQuCRiYg3Nws7Erp42ao626/dxYZmhfTNzdUB3WJOMRKSQuvdsczofgEp2VItu7WQAvIEkw4dVWgPfSjMfMkTY1eCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721798817; c=relaxed/simple;
	bh=IncMBrh57t11nXuBifZGMzjifmoD2j4rfk8oe2693Pc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kb8Zg/dG5Fl1mj87SwiHBeHmyOsoDu/JnsUxd8PxuP0vOKaZgaImq8T8Pyw+rzafPcfs7e71MOrHf93SIHKPGvuKTzej5P0VfqLGOADPirt63V1wKsJIJZGh5IWq7XqzDhc6V/inNnpOwc5AhNUHyQ1b6qfS2G8dsRE9U3b7BVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=Fnztm1lj; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 46O5Qs8I21894632, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1721798814; bh=IncMBrh57t11nXuBifZGMzjifmoD2j4rfk8oe2693Pc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=Fnztm1ljh2eU+fUgPCl6xOLTfEboJK5JZeov2EAhNxCIzHCwojtQsoOlvyQl6S6KB
	 xLnkeO0jxGHbKp0zpxBGwWBC+lUxNUH1z8lNaT4nT5++K+tS/2h7rZF7016w3F6Rmp
	 mJOQWVjh7Gmz46rbQvBlA81vaVvogOFYC16vrYkFwnjxoPyu9qpy98b5qz0yq2oB51
	 2CQm2rd2J3LVIrbU069JgBIZLft6KUzJnAue9K6M7rpf+5PswcW//75nNBK7P/0flt
	 nzBm+GQKQBj7+koO0sfrOQbUWXYHkRoTEsgRHdBbokZWC6CGzD4XvvQQuxKoaak2H9
	 HQ6uowpiq6gbQ==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 46O5Qs8I21894632
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 24 Jul 2024 13:26:54 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 24 Jul 2024 13:26:54 +0800
Received: from [127.0.1.1] (172.16.23.66) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 24 Jul
 2024 13:26:53 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <damon.chen@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH 3/4] wifi: rtw89: 885xb: reset IDMEM mode to prevent download firmware failure
Date: Wed, 24 Jul 2024 13:26:25 +0800
Message-ID: <20240724052626.12774-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240724052626.12774-1-pkshih@realtek.com>
References: <20240724052626.12774-1-pkshih@realtek.com>
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

For different firmware type, it could change IDMEM mode, so reset it to
default to avoid encountering error for RTL8851B/RTL8852B/RTL8852BT
if that kind of firmware was downloaded before.

    rtw89_8851be 0000:02:00.0: Firmware version 0.29.41.3, cmd version 0, type 5
    rtw89_8851be 0000:02:00.0: Firmware version 0.29.41.3, cmd version 0, type 3
    rtw89_8851be 0000:02:00.0: MAC has already powered on
    rtw89_8851be 0000:02:00.0: fw security fail
    rtw89_8851be 0000:02:00.0: download firmware fail
    rtw89_8851be 0000:02:00.0: [ERR]fwdl 0x1E0 = 0x62
    rtw89_8851be 0000:02:00.0: [ERR]fwdl 0x83F2 = 0x8
    rtw89_8851be 0000:02:00.0: [ERR]fw PC = 0xb892f51c
    rtw89_8851be 0000:02:00.0: [ERR]fw PC = 0xb892f524
    rtw89_8851be 0000:02:00.0: [ERR]fw PC = 0xb892f51c
    rtw89_8851be 0000:02:00.0: [ERR]fw PC = 0xb892f500
    rtw89_8851be 0000:02:00.0: [ERR]fw PC = 0xb892f51c
    rtw89_8851be 0000:02:00.0: [ERR]fw PC = 0xb892f53c
    rtw89_8851be 0000:02:00.0: [ERR]fw PC = 0xb892f520
    rtw89_8851be 0000:02:00.0: [ERR]fw PC = 0xb892f520
    rtw89_8851be 0000:02:00.0: [ERR]fw PC = 0xb892f508
    rtw89_8851be 0000:02:00.0: [ERR]fw PC = 0xb892f534
    rtw89_8851be 0000:02:00.0: [ERR]fw PC = 0xb892f520
    rtw89_8851be 0000:02:00.0: [ERR]fw PC = 0xb892f534
    rtw89_8851be 0000:02:00.0: [ERR]fw PC = 0xb892f508
    rtw89_8851be 0000:02:00.0: [ERR]fw PC = 0xb892f53c
    rtw89_8851be 0000:02:00.0: [ERR]fw PC = 0xb892f524
    rtw89_8851be 0000:02:00.0: failed to setup chip information
    rtw89_8851be: probe of 0000:02:00.0 failed with error -16

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index b479434e6301..a61d3a885ff0 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -3788,7 +3788,7 @@ static int rtw89_mac_enable_cpu_ax(struct rtw89_dev *rtwdev, u8 boot_reason,
 
 	rtw89_write32(rtwdev, R_AX_WCPU_FW_CTRL, val);
 
-	if (rtwdev->chip->chip_id == RTL8852B)
+	if (rtw89_is_rtl885xb(rtwdev))
 		rtw89_write32_mask(rtwdev, R_AX_SEC_CTRL,
 				   B_AX_SEC_IDMEM_SIZE_CONFIG_MASK, 0x2);
 
-- 
2.25.1


