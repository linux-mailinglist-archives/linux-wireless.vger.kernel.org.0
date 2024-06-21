Return-Path: <linux-wireless+bounces-9348-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26454911A41
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 07:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE4911F21B59
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 05:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE9F12C7FF;
	Fri, 21 Jun 2024 05:23:53 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4222A8FE
	for <linux-wireless@vger.kernel.org>; Fri, 21 Jun 2024 05:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718947432; cv=none; b=KtGNA/X7jCwinHWcLGf32k2pu7KZNtSXkJcQ+3O55j0p/xrYxFMaS5i5tLmKDWuB3nTpxu8JePnS2mLuhmOFhhfr7TRCPNu7OVmkaLVbk5UY9wrWTQRpu8hrHjWCPtqOcMumBP80KK5kSq8bLzt+pmIIybRm53XmJYsraWzeTMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718947432; c=relaxed/simple;
	bh=7uPcZ9xX/IbbMC0C++Yxz3+sQZNX8uXau2BG3GRJM78=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MTrdM9BZvE330+q3ucRj1QRQzqG1woAcY4zDx4UNnDS+4+laMaHTJUgUS2RmJ5NdKoQsHdLo0WV/9WHtEs4Ns4WBsFtZHM484Rhed475jSmYnoh/CB/BVgZr8k7sXDzB3ZZ8dWqQDgoiUna5FLKNHL/ghdCTriBHzDoMXSdrdV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 45L5MbQlA3755629, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 45L5MbQlA3755629
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Jun 2024 13:22:37 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 21 Jun 2024 13:22:38 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 21 Jun
 2024 13:22:37 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <wens@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <wireless-regdb@lists.infradead.org>
Subject: [PATCH 6/6] wireless-regdb: Update regulatory info for Mauritius(MU) on 6GHz
Date: Fri, 21 Jun 2024 13:22:05 +0800
Message-ID: <20240621052205.28925-6-pkshih@realtek.com>
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

Information & Communication Technologies Authority released DECISION FOR
ALLOCATION OF ADDITIONAL SPECTRUM IN THE FREQUENCY RANGE 5945-6425 MHz FOR
BROADBAND WIRELESS ACCESS SERVICES IN MAURITIUS [1].
The technical conditions:

 - LOW POWER INDOOR (LPI) DEVICES
   * Maximum mean e.i.r.p.: 23 dBm
   * Maximum mean e.i.r.p. density: 10 dBm/MHz
   * indoor use only
 - VERY LOW POWER (VLP) WAS/RLAN DEVICES
   * Maximum mean e.i.r.p.: 14 dBm
   * Maximum mean e.i.r.p. density: 1 dBm/MHz
   * Indoors and outdoors; Use on radio-controlled models is prohibited

[1] https://www.icta.mu/documents/2022/08/wifi6e_decision_0822.pdf

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 db.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/db.txt b/db.txt
index c7371e568b4d..50f4ddb5a808 100644
--- a/db.txt
+++ b/db.txt
@@ -1301,12 +1301,15 @@ country MT: DFS-ETSI
 	# 60 GHz band channels 1-4 (ETSI EN 302 567)
 	(57000 - 66000 @ 2160), (40)
 
+# Source:
+# https://www.icta.mu/documents/2022/08/wifi6e_decision_0822.pdf
 country MU: DFS-FCC
 	(2402 - 2482 @ 40), (20)
 	(5170 - 5250 @ 80), (24), AUTO-BW
 	(5250 - 5330 @ 80), (24), DFS, AUTO-BW
 	(5490 - 5730 @ 160), (24), DFS
 	(5735 - 5835 @ 80), (30)
+	(5945 - 6425 @ 320), (23), NO-OUTDOOR
 
 # Source:
 # http://www.cam.gov.mv/docs/tech_standards/TAM-TS-100-2004-WLAN.pdf
-- 
2.25.1


