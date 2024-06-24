Return-Path: <linux-wireless+bounces-9472-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D6D9140AE
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Jun 2024 04:57:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 483AC1C213A2
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Jun 2024 02:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A69524C;
	Mon, 24 Jun 2024 02:57:21 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0C64C97
	for <linux-wireless@vger.kernel.org>; Mon, 24 Jun 2024 02:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719197841; cv=none; b=Na2WdvSDJCZryIrgnTXXXcmFdtDNAdLVgleYU954FPo4IxCRnz4xdghPgTnOfKBGUkq/WCyGkzQUCigheDGSCoz/6eA869c3ohVDG9iDE7YxJPG4Bco1yPxnzx6BqXRumSfcyXrlqiMf/b/SIa6aDUAxOXWkS8FQfJoy/2Y0AwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719197841; c=relaxed/simple;
	bh=nFRMHa2b+2qmr4fpWlpkYpriupunbghM5Rqo8uHocDQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aOjEUY4HcElebJq4DC5tFdmdK3TvcY2hNbVDjzRTAdqh2U5HdRfg4+gpL1oET7psLLyJKOprOvsnGgvBPoPXsJYopRQ0c0752vHGRqsM3vN3eTkd2AmOO3e/FieaitY8+DsQyLZFtzi6uMeVpzQvnso+GIGq+Y9OqcDt+xs6JR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 45O2uVtF52577482, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 45O2uVtF52577482
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Jun 2024 10:56:31 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 24 Jun 2024 10:56:31 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 24 Jun
 2024 10:56:31 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <wens@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <wireless-regdb@lists.infradead.org>
Subject: [PATCH v2 1/4] wireless-regdb: Update regulatory info for Liechtenstein (LI) on 6GHz
Date: Mon, 24 Jun 2024 10:56:20 +0800
Message-ID: <20240624025623.6021-1-pkshih@realtek.com>
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
 - RIR1010-11 [1]
 - ECC/DEC/(20)01 [3]
 - EC Decision (EU) 2021/1067 on WAS/RLANs [4]

[1] https://docdb.cept.org/download/1448
[2] https://archiv.llv.li/files/ak/pdf-llv-ak-frequenzzuweisungsplan.pdf
[3] https://www.ofcomnet.ch/api/rir/1010/11
[4] https://eur-lex.europa.eu/legal-content/EN/TXT/PDF/?uri=CELEX:32021D1067

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2: add reference links to commit message and db.txt
---
 db.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/db.txt b/db.txt
index b2c57b58bc3f..61c46186919e 100644
--- a/db.txt
+++ b/db.txt
@@ -1071,6 +1071,8 @@ country LC: DFS-ETSI
 # LI: https://www.ofcomnet.ch/api/rir/1010/04
 # LI: https://www.ofcomnet.ch/api/rir/1008/12
 # LI: https://www.ofcomnet.ch/#/fatTable
+# CEPT ECC Decision (20)01 for 6GHz: https://docdb.cept.org/download/1448
+# LI: https://www.ofcomnet.ch/api/rir/1010/11
 country LI: DFS-ETSI
 	(2400 - 2483.5 @ 40), (100 mW)
 	(5150 - 5250 @ 80), (200 mW), NO-OUTDOOR, AUTO-BW, wmmrule=ETSI
@@ -1078,6 +1080,7 @@ country LI: DFS-ETSI
 	(5470 - 5725 @ 160), (500 mW), DFS, wmmrule=ETSI
 	# short range devices (ETSI EN 300 440-1)
 	(5725 - 5875 @ 80), (25 mW)
+	(5945 - 6425 @ 320), (23), NO-OUTDOOR
 	# 60 GHz band channels 1-4 (ETSI EN 302 567)
 	(57000 - 66000 @ 2160), (40)
 
-- 
2.25.1


