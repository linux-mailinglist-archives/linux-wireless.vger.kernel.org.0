Return-Path: <linux-wireless+bounces-9351-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CF34911A48
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 07:24:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F228CB23414
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 05:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 988242A8FE;
	Fri, 21 Jun 2024 05:24:42 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B360063A
	for <linux-wireless@vger.kernel.org>; Fri, 21 Jun 2024 05:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718947482; cv=none; b=u5+96N13Ew8lg0ad7IWPMmVA8Z97n9HJi18aqh2pqx1n6DQK2gNM05warNJTow9gGJPf51J08KMhkgjVrFEVGlgep3xqPAXcAno13oE4z2LxYWoMdpSxoDsBENORX0HndgV1gZNk1K2glKdkdfPC3eUo2HzcwxZOoEYlAUjwZQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718947482; c=relaxed/simple;
	bh=dNGtxUk+Ts8ra9WZ/e08pTgxBpJ2NqxcJZhu4zcTS5g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eSXf50PajbFeks2D6SOAqpq3uDqFuoGpyxVhusS3JrKEvRAkCEGif/NR9MYItv0/scnfLDILPEQxxIGJqcurCTS7YtmeMFGbrADLWc0youdZ7oIuwgmeRiwrFiWI3QcbHdhOlYR7QkNCVHhRxHdgOmULWo0yWVZajEAGrvAPRGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 45L5MIOr83755586, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 45L5MIOr83755586
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Jun 2024 13:22:18 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 21 Jun 2024 13:22:18 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 21 Jun
 2024 13:22:17 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <wens@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <wireless-regdb@lists.infradead.org>
Subject: [PATCH 1/6] wireless-regdb: Update regulatory info for Iceland (IS) on 6GHz
Date: Fri, 21 Jun 2024 13:22:00 +0800
Message-ID: <20240621052205.28925-1-pkshih@realtek.com>
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
Local Area Networks (WAS/RLAN), which [2] defines

 - LOW POWER INDOOR (LPI) DEVICES
   * Restricted to indoor use only
   * Maximum mean e.i.r.p. 23 dBm
   * Maximum mean e.i.r.p. density 10 dBm/MHz

 - VERY LOW POWER (VLP) WAS/RLAN DEVICES
   * Indoors and outdoors; Use on drones is prohibited
   * Maximum mean e.i.r.p. 14 dBm
   * Maximum mean e.i.r.p. density 1 dBm/MHz

Iceland has implemented on 02-06-2021 [1]. The implementation is through
reference in the National Table of Frequency Allocation [3].

[1] https://docdb.cept.org/implementation/16737
[2] https://docdb.cept.org/download/1448
[3] https://www.fjarskiptastofa.is/library?itemid=b2aa76ed-aebf-4783-9b24-e2a800868f98

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 db.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/db.txt b/db.txt
index 02af58d9e817..7b34fe2d8660 100644
--- a/db.txt
+++ b/db.txt
@@ -920,6 +920,7 @@ country IR: DFS-JP
 #  EU decision 2006/771/EC: https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:02008D0432-20080611
 # Harmonized CEPT countries (July 2019): https://www.ecodocdb.dk/download/25c41779-cd6e/Rec7003e.pdf
 # IS: https://www.pfs.is/library/Skrar/Tidnir-og-taekni/MHZ_21022019.pdf
+# CEPT ECC Decision (20)01 for 6GHz: https://docdb.cept.org/download/1448
 country IS: DFS-ETSI
 	(2400 - 2483.5 @ 40), (100 mW)
 	(5150 - 5250 @ 80), (200 mW), NO-OUTDOOR, AUTO-BW, wmmrule=ETSI
@@ -927,6 +928,7 @@ country IS: DFS-ETSI
 	(5470 - 5725 @ 160), (500 mW), DFS, wmmrule=ETSI
 	# short range devices (ETSI EN 300 440-1)
 	(5725 - 5875 @ 80), (25 mW)
+	(5945 - 6425 @ 320), (23), NO-OUTDOOR
 	# 60 GHz band channels 1-4 (ETSI EN 302 567)
 	(57000 - 66000 @ 2160), (40)
 
-- 
2.25.1


