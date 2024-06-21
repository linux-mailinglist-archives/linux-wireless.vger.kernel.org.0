Return-Path: <linux-wireless+bounces-9347-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ACA9F911A40
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 07:23:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31519B219DD
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 05:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C9612C7FF;
	Fri, 21 Jun 2024 05:23:11 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8532A8FE
	for <linux-wireless@vger.kernel.org>; Fri, 21 Jun 2024 05:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718947391; cv=none; b=LlWlI7e2XA+9o3oxx/QVdVrrpw7RxRFT0EhpucOiLROchAKYS9xnaHikDKVk2IbMhUHAjcxoOv25C8ywg1R1MKBNKBvdusO63We7HPqOgRIMOJTpzAJMDPTm0fNoc+xR6bXnmDJ5obLkBSBjAzEO2wGXyTp7M7Dg1vYfzgwWPVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718947391; c=relaxed/simple;
	bh=e1bABLcoBwtSfyPmNk7TymzdsCllY2iNXR67SxeJmZo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WzUJgOfz8eJUdWqX+V5E2m+ahgda1961fzmeUf8PVI2qG9oISwyGJK1blvBHDBvUzIsRnW9JZM/S2qpW4yLXE4MHEhvpJXCYTgliwuFjSvdeOm/hXzf6R6s/CH8eV0d3pgOUSMMz1FUAUhfQ866/acZrP0SvK+44WTqShtjIkaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 45L5MUME03755614, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 45L5MUME03755614
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Jun 2024 13:22:30 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 21 Jun 2024 13:22:30 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 21 Jun
 2024 13:22:30 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <wens@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <wireless-regdb@lists.infradead.org>
Subject: [PATCH 4/6] wireless-regdb: Update regulatory info for Kenya (KE) for 2022
Date: Fri, 21 Jun 2024 13:22:03 +0800
Message-ID: <20240621052205.28925-4-pkshih@realtek.com>
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

Communications of Authority of Kenya issued GUIDELINES ON THE USE OF
RADIOFREQUENCY SPECTRUM BY SHORT RANGE DEVICES on JUNE 2022 [1].
The section 5.8. covers frequency bands and technical parameters for
non-specific short range applications and wireless access systems.

 - 2400-2483.5 MHz: 2W e.i.r.p.
 - 5150-5350 MHz: 200mW; max e.i.r.p. density of 10mW/MHz
 - 5470-5725 MHz: 250mW; Max mean e.i.r.p. of 1W &
		  Max mean e.i.r.p. density of 50mW /MHz
 - 5725-5875 MHz: 23 dBm/MHz; Mean e.i.r.p. of 2W in any 10 MHz band
 - 5925-6425 MHz:
   * LPI: 23 dBm (200 mW)
	  Mean e.i.r.p. density for in-band emissions 10 dBm/MHz
	  Indoor only
   * VLP: 14 dBm (25 mW)
	  Mean e.i.r.p. density for in-band emissions 1 dBm/MHz
	  Indoor and outdoor use

[1] https://www.ca.go.ke/sites/default/files/2023-06/Guidelines-on-the-Use-of-Radiofrequency-Spectrum-by-Short-Range-Devices-2022.pdf

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 db.txt | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/db.txt b/db.txt
index a742498c1116..5603933e3563 100644
--- a/db.txt
+++ b/db.txt
@@ -982,11 +982,14 @@ country JP: DFS-JP
 	# ref: http://www.arib.or.jp/english/html/overview/doc/1-STD-T74v1_1.pdf
 	(57000 - 66000 @ 2160), (10 mW)
 
+# Source:
+# https://www.ca.go.ke/sites/default/files/2023-06/Guidelines-on-the-Use-of-Radiofrequency-Spectrum-by-Short-Range-Devices-2022.pdf
 country KE: DFS-JP
-	(2402 - 2482 @ 40), (20)
-	(5170 - 5250 @ 80), (23)
-	(5490 - 5570 @ 80), (30), DFS
-	(5735 - 5775 @ 40), (23)
+	(2400 - 2483.5 @ 40), (33)
+	(5150 - 5350 @ 80), (23), DFS
+	(5490 - 5570 @ 80), (24), DFS
+	(5735 - 5775 @ 40), (23), DFS
+	(5925 - 6425 @ 320), (23), NO-OUTDOOR
 
 country KH: DFS-ETSI
 	(2402 - 2482 @ 40), (20)
-- 
2.25.1


