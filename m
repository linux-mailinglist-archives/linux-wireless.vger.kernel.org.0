Return-Path: <linux-wireless+bounces-9349-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E9E7911A46
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 07:24:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DECD72842E5
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 05:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 839B912C81D;
	Fri, 21 Jun 2024 05:24:25 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA57663A
	for <linux-wireless@vger.kernel.org>; Fri, 21 Jun 2024 05:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718947465; cv=none; b=i/wGtxA/wBjXFZ79S0jhSGMxWIpylDR2sMxJS8314DS9hRZm9/5kBWZT3FqM9RbzidGlUTUDOHgo36yLu2EaboMLNGlmzY5Tiqn2hURFpb/At542EeSXOGZSpKWjC/1siByR04dfGcPHCZWQR4e1jzli6QZ3juJuG0xTWlF9Dm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718947465; c=relaxed/simple;
	bh=8hKIzWmzBTXKbNyraNBg03087lxrGhpOOpjAzFjOLec=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LlrD1I/Tv/FxswW7Vw3XQIE1muVkriz6mrQhyFQVkA8u5oZiNONOgEc5tCJBO3r0by5Hb7wAVLz1eY0bSO+Dma0fmXiYU0+5Ph6Mdb4o0Jn3ThE6K2iLa9qwn+QFk1LpZUoWXyY9RKMPCz+imUtM6edgfd/6JJzg32zkfYwCpfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 45L5MQRv83755608, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 45L5MQRv83755608
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Jun 2024 13:22:26 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 21 Jun 2024 13:22:26 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 21 Jun
 2024 13:22:26 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <wens@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <wireless-regdb@lists.infradead.org>
Subject: [PATCH 3/6] wireless-regdb: Update regulatory info for Jordan (JO) for 2022
Date: Fri, 21 Jun 2024 13:22:02 +0800
Message-ID: <20240621052205.28925-3-pkshih@realtek.com>
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

The Hashemite Kingdom of Jordan, Telecommunications Regulatory Authority
issued pursuant to the provisions of Articles (12A) and (22) of the
Telecommunications Law No. 31 of 1995, as amended. [1]

The effective radiated power (EIRP) of devices used in local radio computer
networks must not exceed the following values:

 - 2400-2483.5 MHz: 100 milliwatts (20 dBm)
 - 5150-5350 MHz: 200 milliwatts (23 dBm)
 - 5470-5725 MHz: 1 watt (30 dBm)
 - 5725-5875 MHz: 200 mW (23 dBm)
 - 5925-6425 MHz:
   * 25 milliwatts (14 dBm) (for outdoor and portable devices)
   * 200 milliwatts (23 dBm) (for devices operated indoors only)

[1] https://trc.gov.jo/EchoBusV3.0/SystemAssets/PDF/RSMD/cb9f9a83-43a6-4e66-8432-6e02ecaf465b_RLAN%20Arabic%20%20Final%20-%20clean%20with%2057-71%20GHz.pdf

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 db.txt | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/db.txt b/db.txt
index e10c3fc752e9..a742498c1116 100644
--- a/db.txt
+++ b/db.txt
@@ -957,10 +957,14 @@ country JM: DFS-FCC
 	(5490 - 5730 @ 160), (24), DFS
 	(5735 - 5835 @ 80), (30)
 
+# Source:
+# https://trc.gov.jo/EchoBusV3.0/SystemAssets/PDF/RSMD/cb9f9a83-43a6-4e66-8432-6e02ecaf465b_RLAN%20Arabic%20%20Final%20-%20clean%20with%2057-71%20GHz.pdf
 country JO: DFS-JP
-	(2402 - 2482 @ 40), (20)
-	(5170 - 5250 @ 80), (23)
-	(5735 - 5835 @ 80), (23)
+	(2400 - 2483.5 @ 40), (20)
+	(5150 - 5350 @ 80), (23)
+	(5470 - 5725 @ 80), (30)
+	(5725 - 5875 @ 80), (23)
+	(5925 - 6425 @ 320), (23), NO-OUTDOOR
 
 # Source:
 # https://www.soumu.go.jp/main_content/000635492.pdf
-- 
2.25.1


