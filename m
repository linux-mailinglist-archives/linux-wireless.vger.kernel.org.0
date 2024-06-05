Return-Path: <linux-wireless+bounces-8517-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D5008FC4C8
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Jun 2024 09:42:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A4D21F22340
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Jun 2024 07:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0507318C33D;
	Wed,  5 Jun 2024 07:42:53 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9346218C33B
	for <linux-wireless@vger.kernel.org>; Wed,  5 Jun 2024 07:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717573372; cv=none; b=jGhU1HZRe5aMVGaOxeQvwO3Cx1ZP6ti5cTxy4QE0n1qV9aUlt/NlhzI7i92debFXLcHNwq0rBRO36NlDrd4n3ADzonj1daLX5LGvKvzz1Cye01b3Ate7gn9cQAbguso4bSSriPZm8LXHwawyonKI2Dti7R3BbaQ+6315CFfGeKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717573372; c=relaxed/simple;
	bh=62Qc27H/QnIqEmuG1+pSmcUExjDKmFKqQU8OCHO6Mpc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=L+8EU70haGwQMdobzGRamD8drT0sj0bDVwP97hp7CXxZYTLLNPZjyeTeXTC+qlDkP7CDeTvi64w0/F3JigUDMsxIjO2VhHHKrhPIo8bhnzfHOrTTCnrt37cku3MYCVFgtpnimFG2YJjvGVX4dlouQmU+0+VI3bZBkaDlHroOwJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4557gTYf91236942, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4557gTYf91236942
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Jun 2024 15:42:29 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 5 Jun 2024 15:42:29 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 5 Jun
 2024 15:42:27 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <wens@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <wireless-regdb@lists.infradead.org>
Subject: [PATCH v3 1/4] wireless-regdb: Update regulatory info for Malaysia (MY) for 2022
Date: Wed, 5 Jun 2024 15:42:06 +0800
Message-ID: <20240605074209.8713-1-pkshih@realtek.com>
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

Malaysia Communications and Multimedia Commission announced CLASS
ASSIGNMENT NO. 1 OF 2022, which page 11 describes frequency bands
5925-6425 MHz are used with conditions of 25 mW EIRP for indoor and outdoor
use and 200 mW EIRP for indoor use only. Add frequency range of
5925-6425 MHz and update limits of existing entries accordingly.

[1] https://www.mcmc.gov.my/skmmgovmy/media/General/CA-No-1-of-2022_-signed_19012022.pdf

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
v3: no change
v2: update limit of existing entries accordingly.
    But don't remove entries that DFS and TPC are required for now.
---
 db.txt | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/db.txt b/db.txt
index f27dd5214630..8773de6ed6a8 100644
--- a/db.txt
+++ b/db.txt
@@ -1294,12 +1294,15 @@ country MX: DFS-FCC
 	(5490 - 5730 @ 160), (24), DFS
 	(5735 - 5835 @ 80), (30)
 
+# Source:
+# https://www.mcmc.gov.my/skmmgovmy/media/General/CA-No-1-of-2022_-signed_19012022.pdf
 country MY: DFS-FCC
-	(2402 - 2482 @ 40), (20)
-	(5170 - 5250 @ 80), (24), AUTO-BW
-	(5250 - 5330 @ 80), (24), DFS, AUTO-BW
-	(5490 - 5650 @ 160), (24), DFS
-	(5735 - 5835 @ 80), (24)
+	(2402 - 2482 @ 40), (500 mW)
+	(5170 - 5250 @ 80), (1000 mW), AUTO-BW
+	(5250 - 5330 @ 80), (1000 mW), DFS, AUTO-BW
+	(5490 - 5650 @ 160), (1000 mW), DFS
+	(5735 - 5835 @ 80), (1000 mW)
+	(5925 - 6425 @ 320), (200 mW), NO-OUTDOOR
 
 country NG: DFS-ETSI
 	(2402 - 2482 @ 40), (20)
-- 
2.25.1


