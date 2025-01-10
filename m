Return-Path: <linux-wireless+bounces-17273-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D25A08514
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jan 2025 02:54:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52B891691F8
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jan 2025 01:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC716157A5C;
	Fri, 10 Jan 2025 01:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="H18kdx7p"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B421C5F37
	for <linux-wireless@vger.kernel.org>; Fri, 10 Jan 2025 01:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736474085; cv=none; b=CNEKRYgO7CvEeAY9RmCRHN5RAM7Mw6Uwe3mainH/Kvfe89EwV0Ynm5JJUTTjImKOr/JvUF02GWqpowije6eB5QsLZBSFI1ecgE89qV0V97hWUEtY9HS7wXjafOAsV+OUmqae2vC+r2LpgGlcI0mcdxXvDf368rWMQ/Hs+J8lo0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736474085; c=relaxed/simple;
	bh=Nex1/e1Siv+gP8P70TbfWEvzKf5mu+2tSb372dAxauw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r4KOWzP3AknY6Rm/FHjM+6ocbtkeMeqRdjP5d8YyGgEwUIqJb4XfUoSSPRcaVZcHn/mbrBPxIgYHccVDpeMA+7i/I5asESO0cChF8FNr0XlyuuADxXGd8AhN93njxXe+xOQFYvPynEoYYduLqg/TRdI71aXGOLYXMAQmqBZEO0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=H18kdx7p; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 50A1sfcB73982815, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1736474081; bh=Nex1/e1Siv+gP8P70TbfWEvzKf5mu+2tSb372dAxauw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=H18kdx7pGSJzcDIpIgaH3e7fVvX78cMbuOsp1SH4RS6n/X7uQfiMD55pZBDNEjaWJ
	 LKRoS8QgIs6yRKbMx5zkOpdIJbeHTZ0TFcIzjMNXEkTSmdtSyqKFIV53/aTYyKPCSu
	 JqSFSX6sK+pbSLvoVdesdULaLLuxHbXByzRun6uyONTQflvrACgD+Z/18AC6aB+uUP
	 cibjWdJwnWSCQJFFQmTOYwtE8evWURgrqbTs45SbSS/WFf7fJbKM/O8Bm0xNWqrwz9
	 guW/XLqtyrH2HREH1UkwzmLnZUhkcWD48Q2Bwj8IymForRRD5oZyfLCHf80oQ1ADuZ
	 3u9IdztkITnCA==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 50A1sfcB73982815
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 10 Jan 2025 09:54:41 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 10 Jan 2025 09:54:41 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 10 Jan
 2025 09:54:40 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <ku920601@realtek.com>
Subject: [PATCH 3/3] wifi: rtw89: coex: Update Wi-Fi/Bluetooth coexistence version to 7.0.2
Date: Fri, 10 Jan 2025 09:54:16 +0800
Message-ID: <20250110015416.10704-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250110015416.10704-1-pkshih@realtek.com>
References: <20250110015416.10704-1-pkshih@realtek.com>
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

With this version, fix Wi-Fi scan/connecting/RF calibration triggered A2DP
sound lag related issues.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index cde65ee43bac..7e43ba0c4098 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -10,7 +10,7 @@
 #include "ps.h"
 #include "reg.h"
 
-#define RTW89_COEX_VERSION 0x07000113
+#define RTW89_COEX_VERSION 0x07000213
 #define FCXDEF_STEP 50 /* MUST <= FCXMAX_STEP and match with wl fw*/
 #define BTC_E2G_LIMIT_DEF 80
 
-- 
2.25.1


