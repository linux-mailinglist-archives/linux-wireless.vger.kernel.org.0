Return-Path: <linux-wireless+bounces-9350-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 530EA911A47
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 07:24:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E5A0284197
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 05:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF5E12D1EA;
	Fri, 21 Jun 2024 05:24:31 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8B063A
	for <linux-wireless@vger.kernel.org>; Fri, 21 Jun 2024 05:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718947471; cv=none; b=HpNMElkRwp76jTkYy3GmgUhCi6ZbkIv1HiYm8/9lbaRrtRrGBE43j1sehfol4lvJdCLZAvKU/+FU/4rUN2PonBgaSwfJEGouMGO8+v6hVqDTIdAA9Lf77KVnLT2+MXflRgWTErTxk2EcSILahOeGHyIQhzafZETRbTV1dZdWY4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718947471; c=relaxed/simple;
	bh=W9MGhylCcbwC5aLLicGEbNTctE9LQX5M7XR3VkgQk4c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e86JD+fXVV9cygaUItCXAkU5NFQGszpnIL+afbMOm8Uc+QQRcU7bhAAQkns/Q7JI1cThwE3e9HH24rTB36H6lFlgYV05z1nRW5uxaKtHzGU3jpXJKzT9beGeSiWujBiNM+XmMPQSNq9kJl7ikyaB5CUwUrsRMbiz2VOZwDkujYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 45L5MMTu83755592, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 45L5MMTu83755592
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Jun 2024 13:22:22 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 21 Jun 2024 13:22:22 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 21 Jun
 2024 13:22:22 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <wens@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <wireless-regdb@lists.infradead.org>
Subject: [PATCH 2/6] wireless-regdb: Update regulatory info for Liechtenstein (LI) on 6GHz
Date: Fri, 21 Jun 2024 13:22:01 +0800
Message-ID: <20240621052205.28925-2-pkshih@realtek.com>
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

CEPT ECC/DEC/(20)01 of 20 November 2020 on the harmonised use of the
frequency band 5945-6425 MHz for Wireless Access Systems including Radio
Local Area Networks (WAS/RLAN), which [1] defines

 - LOW POWER INDOOR (LPI) DEVICES
   * Restricted to indoor use only
   * Maximum mean e.i.r.p. 23 dBm
   * Maximum mean e.i.r.p. density 10 dBm/MHz

 - VERY LOW POWER (VLP) WAS/RLAN DEVICES
   * Indoors and outdoors; Use on drones is prohibited
   * Maximum mean e.i.r.p. 14 dBm
   * Maximum mean e.i.r.p. density 1 dBm/MHz

Liechtenstein, Frequency Allocation Plan (FAP) and Specific Assignments [2]
note references of 5945 - 6425 MHz on Wideband data transmission systems:
 - RIR1010-11,
 - ECC/DEC/(20)01
 - EC Decision (EU) 2021/1067 on WAS/RLANs.

[1] https://docdb.cept.org/download/1448
[2] https://archiv.llv.li/files/ak/pdf-llv-ak-frequenzzuweisungsplan.pdf

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 db.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/db.txt b/db.txt
index 7b34fe2d8660..e10c3fc752e9 100644
--- a/db.txt
+++ b/db.txt
@@ -1071,6 +1071,7 @@ country LC: DFS-ETSI
 # LI: https://www.ofcomnet.ch/api/rir/1010/04
 # LI: https://www.ofcomnet.ch/api/rir/1008/12
 # LI: https://www.ofcomnet.ch/#/fatTable
+# CEPT ECC Decision (20)01 for 6GHz: https://docdb.cept.org/download/1448
 country LI: DFS-ETSI
 	(2400 - 2483.5 @ 40), (100 mW)
 	(5150 - 5250 @ 80), (200 mW), NO-OUTDOOR, AUTO-BW, wmmrule=ETSI
@@ -1078,6 +1079,7 @@ country LI: DFS-ETSI
 	(5470 - 5725 @ 160), (500 mW), DFS, wmmrule=ETSI
 	# short range devices (ETSI EN 300 440-1)
 	(5725 - 5875 @ 80), (25 mW)
+	(5945 - 6425 @ 320), (23), NO-OUTDOOR
 	# 60 GHz band channels 1-4 (ETSI EN 302 567)
 	(57000 - 66000 @ 2160), (40)
 
-- 
2.25.1


