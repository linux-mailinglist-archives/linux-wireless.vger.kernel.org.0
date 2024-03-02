Return-Path: <linux-wireless+bounces-4320-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 265ED86EDB4
	for <lists+linux-wireless@lfdr.de>; Sat,  2 Mar 2024 02:00:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BAE8DB2402A
	for <lists+linux-wireless@lfdr.de>; Sat,  2 Mar 2024 01:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F73A10942;
	Sat,  2 Mar 2024 01:00:08 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624537482
	for <linux-wireless@vger.kernel.org>; Sat,  2 Mar 2024 01:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709341208; cv=none; b=JY8d55rmnsBRTwn47jImJ32FE7zrZF+f2WZGhMKVl7FUIkh0qO9udQjWxqvV+on0hUI6LWh3wx3PNHFrTGHSiZYEsx0ihm+B4m2btiHlUcNP1cALxHwJQ5Qv90vUfoJrhtzYKQEjEPLGkDsjbmHd78UahsA4+HGYurgj9MxwV3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709341208; c=relaxed/simple;
	bh=EU35oZDg58FzvIpCxltGl5VTlzicXLQTmNP/lawpntU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XrstNBVBAcCSJWMiKDJNCgW0s6+NejHjjxhZknBweMW6pz5FT+fv2DLFfcBLFuggD2Tx+YyWsygt1Uryi1nDV5uQ82WwQ7ngxLQ0KGHMSotXofap0ushLSAbCjkWuWwt4QI1zdqWLWPFRcB6kU2UkhUBysR9Pj7o1NAeq5hDH8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4220xx9T32370316, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4220xx9T32370316
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 2 Mar 2024 08:59:59 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.32; Sat, 2 Mar 2024 09:00:00 +0800
Received: from [127.0.1.1] (172.16.16.155) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Sat, 2 Mar
 2024 08:59:59 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <timlee@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 7/7] wifi: rtw89: wow: move release offload packet earlier for WoWLAN mode
Date: Sat, 2 Mar 2024 08:58:28 +0800
Message-ID: <20240302005828.13666-8-pkshih@realtek.com>
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
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

From: Chin-Yen Lee <timlee@realtek.com>

Now WoWLAN firmware will disable PCIE DMA after driver call cfg_wake
function, and it will lead to release offload packet fail because driver
can't receive completion notification from firmware. We move release
offload packet earlier to avoid this error.

Signed-off-by: Chin-Yen Lee <timlee@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/wow.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/wow.c b/drivers/net/wireless/realtek/rtw89/wow.c
index 689a4e94387a..ccad026defb5 100644
--- a/drivers/net/wireless/realtek/rtw89/wow.c
+++ b/drivers/net/wireless/realtek/rtw89/wow.c
@@ -667,14 +667,14 @@ static int rtw89_wow_fw_stop(struct rtw89_dev *rtwdev)
 		goto out;
 	}
 
+	rtw89_fw_release_general_pkt_list(rtwdev, true);
+
 	ret = rtw89_wow_cfg_wake(rtwdev, false);
 	if (ret) {
 		rtw89_err(rtwdev, "wow: failed to disable config wake\n");
 		goto out;
 	}
 
-	rtw89_fw_release_general_pkt_list(rtwdev, true);
-
 	ret = rtw89_wow_check_fw_status(rtwdev, false);
 	if (ret) {
 		rtw89_err(rtwdev, "wow: failed to check disable fw ready\n");
-- 
2.25.1


