Return-Path: <linux-wireless+bounces-7929-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF4A28CBB6E
	for <lists+linux-wireless@lfdr.de>; Wed, 22 May 2024 08:32:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70F0A1F23076
	for <lists+linux-wireless@lfdr.de>; Wed, 22 May 2024 06:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23504770FF;
	Wed, 22 May 2024 06:32:01 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB78375802
	for <linux-wireless@vger.kernel.org>; Wed, 22 May 2024 06:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716359521; cv=none; b=o+r5cS7esMOhwrN2i72bR2IabJOSnogz3rOA3BxqREa4PqlSDyp5A/+Hul8Ex9lQaCVBif1yrLlxqzNIPgI4WZ1CdvGuJea82lvAEGh3m99Ls4T3wYW7nYVJqSB48R/VzsxOKruskprN50kCOHuIr0bX4U2fHFOJShN6UOtMQj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716359521; c=relaxed/simple;
	bh=UjTIMUnFfJwFmNlEo3c45NJW5zhIc4qLC8VlX1Z8FmY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VweSYAbWFmJLS5Op4boivg09pqZ5BhRmA/WFFtlYVDgesBBGpp3UHAH4P0387K2ao38vyxMWE2mQYfgU0mH3fMxW6WcIyvAWTPcZVE56lG5eeKaazqaEeHF356r8FjKWbXzMgbufDPQqVEbaeCgX9mlPWWMeFgW9dkdUV2p9HrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 44M6TECU03582022, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 44M6TECU03582022
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 May 2024 14:29:14 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 22 May 2024 14:29:15 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 22 May
 2024 14:29:14 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <wens@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <wireless-regdb@lists.infradead.org>
Subject: [PATCH 3/4] wireless-regdb: Update regulatory rules for South Africa (ZA) on 6GHz
Date: Wed, 22 May 2024 14:28:34 +0800
Message-ID: <20240522062835.69628-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240522062835.69628-1-pkshih@realtek.com>
References: <20240522062835.69628-1-pkshih@realtek.com>
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

Independent communications authority of South Africa released NOTICE 1822
OF 2023, which defined 5925-6425 MHz for application of Wireless Access
System/Radio Local Area Network, TX power is 14 dBm e.i.r.p. for
Very Low Power (VLP), Indoor/Outdoor.

[1] https://www.gov.za/sites/default/files/gcis_document/202305/48643gon1822.pdf

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 db.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/db.txt b/db.txt
index 4f3128556f89..022ecb3719b6 100644
--- a/db.txt
+++ b/db.txt
@@ -1892,11 +1892,13 @@ country YT: DFS-ETSI
 	(5250 - 5330 @ 80), (20), DFS, AUTO-BW, wmmrule=ETSI
 	(5490 - 5710 @ 160), (27), DFS, wmmrule=ETSI
 
+# Source: https://www.gov.za/sites/default/files/gcis_document/202305/48643gon1822.pdf
 country ZA: DFS-ETSI
 	(2402 - 2482 @ 40), (20)
 	(5170 - 5250 @ 80), (20), AUTO-BW
 	(5250 - 5330 @ 80), (20), DFS, AUTO-BW
 	(5490 - 5710 @ 160), (30)
+	(5925 - 6425 @ 320), (14)
 
 country ZW: DFS-ETSI
 	(2402 - 2482 @ 40), (20)
-- 
2.25.1


