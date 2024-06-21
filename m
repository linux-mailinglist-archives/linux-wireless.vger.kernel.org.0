Return-Path: <linux-wireless+bounces-9413-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09D0D911E38
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 10:13:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A63E41F21E9F
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 08:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B8B16D4D0;
	Fri, 21 Jun 2024 08:05:39 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21FC416E860
	for <linux-wireless@vger.kernel.org>; Fri, 21 Jun 2024 08:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718957139; cv=none; b=eYQmAyG6RBnV6ZL4athPABN+9RrUASjE12Pg2VO0SPVtPzlKcjrbPULVc4Ck2qnonPRzFnO5gEfDPwlhq8mz8DjT3C8qulv0ryTAu/iEfXFgNUTNqLVv3md9SR3JCDHWIgpMMlCZp7aNL3FcOWjW13zbq6bj4xdVeS7jRa7Lrmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718957139; c=relaxed/simple;
	bh=KSqxvwgHHG0R64NO3i+CZ4XLBJGQxlDUz2ypPlVIE10=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A7Tp/UTadnxnXMd+q5PcU1353et2YIihFDN3nVjoS+8ribPymGUUVmOqCURj7W9xACeF0oI8qWgp4S74N34Ew7i8Lpk9C5q64P1df6T9a/S0E+SNrp5Xqptkow4OdPtGUkeHDffwYqbVROIEEtmc1vMh1oH7BYVz/rrUKbSB17c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 45L85O6A03890677, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 45L85O6A03890677
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Jun 2024 16:05:24 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 21 Jun 2024 16:05:24 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 21 Jun
 2024 16:05:24 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <wens@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <wireless-regdb@lists.infradead.org>
Subject: [PATCH v2 4/5] wireless-regdb: Update regulatory info for Costa Rica (CR) for 2021
Date: Fri, 21 Jun 2024 16:05:16 +0800
Message-ID: <20240621080516.55644-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240621080348.55504-1-pkshih@realtek.com>
References: <20240621080348.55504-1-pkshih@realtek.com>
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

DECENTRALIZED INSTITUTIONS, REGULATORY AUTHORITY OF PUBLIC SERVICES,
announced ALCANCE NO 87 A LA GACETA NO 83 (in Spanish) on April 30, 2021.

For 6GHz band (frequency 5925-7125), allowed only the following usage
applications free in this segment:
 - Applications of low power in interiors (LPI), according to the limits of
   power 30 dBm.
 - Applications of very low power (VLP), indoors and exteriors, with an
   EIRP maximum of 14 dBm.

Also update and add limits of 2 and 5 GHz bands accordingly.

[1] https://storage.googleapis.com/eleoscompliance1.appspot.com/public/PNAF%20modificaci%C3%B3n%20ALCA87_30_04_2021.pdf

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2: fill power limit along with third column of reference.
---
 db.txt | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/db.txt b/db.txt
index c98749442873..ddbf484ef0ad 100644
--- a/db.txt
+++ b/db.txt
@@ -434,12 +434,16 @@ country CO: DFS-FCC
 	(5735 - 5835 @ 80), (30)
 	(5925 - 7125 @ 320), (12), NO-OUTDOOR
 
+# Source:
+# https://storage.googleapis.com/eleoscompliance1.appspot.com/public/PNAF%20modificaci%C3%B3n%20ALCA87_30_04_2021.pdf
 country CR: DFS-FCC
-	(2402 - 2482 @ 40), (20)
-	(5170 - 5250 @ 20), (17)
-	(5250 - 5330 @ 20), (24), DFS
-	(5490 - 5730 @ 20), (24), DFS
-	(5735 - 5835 @ 20), (30)
+	(2402 - 2482 @ 40), (36)
+	(5170 - 5250 @ 20), (30)
+	(5250 - 5330 @ 20), (30), DFS
+	(5490 - 5730 @ 20), (30), DFS
+	(5735 - 5835 @ 20), (36)
+	(5875 - 5925 @ 20), (30)
+	(5925 - 7125 @ 320), (30), NO-OUTDOOR
 
 # Source:
 # https://www.mincom.gob.cu/es/marco-legal
-- 
2.25.1


