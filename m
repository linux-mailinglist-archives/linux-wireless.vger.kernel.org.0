Return-Path: <linux-wireless+bounces-9352-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1690911A49
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 07:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52AA2B21B09
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 05:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2097F2A8FE;
	Fri, 21 Jun 2024 05:25:36 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5083063A
	for <linux-wireless@vger.kernel.org>; Fri, 21 Jun 2024 05:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718947536; cv=none; b=Jes0oT7kUzNKIrozZc9k5zY+gR2jOqZyr9K5MNRyPhB4OW4Igm2ERgoRtE1k9wu6pWGCll7pvAWdHsVvBRMI10QebtUnniaLJyxcqwrRFD9AEHtItRBEwjvBO/FQhRgS+DBqjVPIP+DXVTyNR+f6Tc9ATX3/wG7i1ge2Tbzk0Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718947536; c=relaxed/simple;
	bh=X64GoHEqBXzQFb1VKf37MDgL8Bt2SgKn1MBszvNdetk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BrzInORnzLG1bVInL0Y2nw6fHS2ZVPkMRq/3o6DRCT2WCenzPUE1hd8u7AXp+Sek1sXYfA42IlreuTa0khXyJvqPhYNa2ZO0KxoFWdEBBcDlRnF/OZQ49Dc2qKhcj161XBuVKBiQofigwxjUSLaI83M97Uv1/v4Jdhc8TZugPoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 45L5MYiK43755626, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 45L5MYiK43755626
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Jun 2024 13:22:34 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 21 Jun 2024 13:22:34 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 21 Jun
 2024 13:22:34 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <wens@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <wireless-regdb@lists.infradead.org>
Subject: [PATCH 5/6] wireless-regdb: Update regulatory info for Macao (MO) for 2024
Date: Fri, 21 Jun 2024 13:22:04 +0800
Message-ID: <20240621052205.28925-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240621052205.28925-1-pkshih@realtek.com>
References: <20240621052205.28925-1-pkshih@realtek.com>
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

MACAU SPECIAL ADMINISTRATIVE REGION OFFICE OF THE CHIEF EXECUTIVE released
Order from the Chief Executive No. 64/2024, which wireless data
communications equipment defined as

 - 2400-2483.5MHz 200mW
 - 5150-5350MHz   200mW
 - 5470-5725MHz   1W
 - 5725-5850MHz   1W
 - 5925-6425MHz   250 mW (for indoor use)
                  25 mW (for use in outdoor spaces)

[1] https://bo.io.gov.mo/bo/i/2024/16/despce.asp#64

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 db.txt | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/db.txt b/db.txt
index 5603933e3563..c7371e568b4d 100644
--- a/db.txt
+++ b/db.txt
@@ -1252,12 +1252,14 @@ country MN: DFS-FCC
 	(5735 - 5835 @ 80), (30)
 	(5925 - 6425 @ 320), (100mW)
 
+# Source:
+# https://bo.io.gov.mo/bo/i/2024/16/despce.asp#64
 country MO: DFS-FCC
-	(2402 - 2482 @ 40), (23)
-	(5170 - 5250 @ 80), (23), AUTO-BW
-	(5250 - 5330 @ 80), (23), DFS, AUTO-BW
-	(5490 - 5730 @ 160), (30), DFS
-	(5735 - 5835 @ 80), (30)
+	(2400 - 2483.5 @ 40), (23)
+	(5150 - 5350 @ 80), (23)
+	(5470 - 5725 @ 160), (30), DFS
+	(5725 - 5850 @ 80), (30)
+	(5925 - 6425 @ 320), (250mW), NO-OUTDOOR
 
 country MP: DFS-FCC
 	(2402 - 2472 @ 40), (30)
-- 
2.25.1


