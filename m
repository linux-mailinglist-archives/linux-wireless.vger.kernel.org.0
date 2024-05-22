Return-Path: <linux-wireless+bounces-7931-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F1398CBB70
	for <lists+linux-wireless@lfdr.de>; Wed, 22 May 2024 08:32:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 009C21F23114
	for <lists+linux-wireless@lfdr.de>; Wed, 22 May 2024 06:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7391179B99;
	Wed, 22 May 2024 06:32:02 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0E033080
	for <linux-wireless@vger.kernel.org>; Wed, 22 May 2024 06:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716359522; cv=none; b=ctFSc8aMzq2KbwUh/YYTgXnZyaV8io84VwPzBj3L72bAEvr6gIk6quS8U+JWBl5v06eIIn2QscBA/jCSpt46fFCq7nLiHu3miRJRNsscVJ4iWQ7f9uIpX8B8eQQmyvNrwVlSmONEKQ3VCROlsVBOxdWLiYR9cJUxTOhkOO6O8lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716359522; c=relaxed/simple;
	bh=WUK/mpB8BoXspY+yG8dUXrTPOo2roQcpQ8kjfRH43pE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=N3nJd02j+8j5m/5hwsTcGgxH4Yd9/MOU7bKA3N3IUTRBa5WcbSw+Bhg3sCbVzdYkV2VK61FemOG5PrxC9NV46Ky7AggArwKJuFWPGaZcc57fQsTamQF+tdpEeltpsIAnLBFf4WZX77LEapGD6kN/rOefnPEu6WKBe5CaUngq2nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 44M6T6lrC3582003, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 44M6T6lrC3582003
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 May 2024 14:29:06 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 22 May 2024 14:29:07 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 22 May
 2024 14:29:06 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <wens@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <wireless-regdb@lists.infradead.org>
Subject: [PATCH 1/4] wireless-regdb: Update regulatory rules for Mongolia (MN) on 6GHz
Date: Wed, 22 May 2024 14:28:32 +0800
Message-ID: <20240522062835.69628-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
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

Communications Regulatory Commission- CRC released Amendment to Resolution
No. 37 of 2020 [1] on 2022.01.31, which supports freqency range
5925-6425 MHz, output power limitation is 100mW, Indoor and and outdoor
will be used.

[1] Amendment to Resolution No. 37 of 2020
    https://www.crc.gov.mn/storage/PDF/2022/2022-togtool1.pdf

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 db.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/db.txt b/db.txt
index 45ec3f3ff3ee..6182e194b7ea 100644
--- a/db.txt
+++ b/db.txt
@@ -1209,12 +1209,15 @@ country MK: DFS-ETSI
 	# 60 GHz band channels 1-4, ref: Etsi En 302 567
 	(57000 - 66000 @ 2160), (40)
 
+# Communications Regulatory Commission- CRC released Amendment to Resolution No. 37 of 2020
+# https://www.crc.gov.mn/storage/PDF/2022/2022-togtool1.pdf
 country MN: DFS-FCC
 	(2402 - 2482 @ 40), (20)
 	(5170 - 5250 @ 80), (24), AUTO-BW
 	(5250 - 5330 @ 80), (24), DFS, AUTO-BW
 	(5490 - 5730 @ 160), (24), DFS
 	(5735 - 5835 @ 80), (30)
+	(5925 - 6425 @ 320), (100mW)
 
 country MO: DFS-FCC
 	(2402 - 2482 @ 40), (23)
-- 
2.25.1


