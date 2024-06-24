Return-Path: <linux-wireless+bounces-9473-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 146E49140AF
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Jun 2024 04:57:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A20A8B21C0B
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Jun 2024 02:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34604C6E;
	Mon, 24 Jun 2024 02:57:23 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BEC8827
	for <linux-wireless@vger.kernel.org>; Mon, 24 Jun 2024 02:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719197843; cv=none; b=ojENAdwfz3Xm8tWGdnK81hEl1OaxFJOQTEFVrSnoF/0/vQYI97GS3nUbRj001lYSliFU6dMhcJXnRIJwDJ7jp9941t8RlDzncGZW9OF6TxUIP0AkGlVftwi6yifpKAy5TKOO1BwQKeSKnQZRzaqvwaXWC2+GUPegOK7R5HMdt54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719197843; c=relaxed/simple;
	bh=UHFq25FG/GR/fGR70BNBZ2KoEq2SjAjx1ENxoNm2Org=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ab0WMs3TybbBj8c+zz6rxpot04qoeOogs9mAfqNrzekxEb+k55l4bKlVsezm8cS6t2ID4YjK6FzNRMAV2BypVy9SZCL7oG+eB1wwKzap62FsVJNwAyInnwwX88qWyJdx2w5zM0Jqg8CtEGNtuePrUXcTYSSS31Hc4RE6Ag5qnQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 45O2udP432577514, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 45O2udP432577514
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Jun 2024 10:56:39 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 24 Jun 2024 10:56:39 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 24 Jun
 2024 10:56:38 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <wens@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <wireless-regdb@lists.infradead.org>
Subject: [PATCH v2 3/4] wireless-regdb: Update regulatory info for Kenya (KE) for 2022
Date: Mon, 24 Jun 2024 10:56:22 +0800
Message-ID: <20240624025623.6021-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240624025623.6021-1-pkshih@realtek.com>
References: <20240624025623.6021-1-pkshih@realtek.com>
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
                  (ETSI: -6 dBm to be 17 dBm)
 - 5470-5725 MHz: 250mW; Max mean e.i.r.p. of 1W &
		  Max mean e.i.r.p. density of 50mW /MHz
                  (ETSI: -6 dBm to be 18 dBm)
 - 5725-5875 MHz: 23 dBm/MHz; Mean e.i.r.p. of 2W in any 10 MHz band
                  (ETSI: -6 dBm to be 17 dBm)
 - 5925-6425 MHz:
   * LPI: 23 dBm (200 mW)
	  Mean e.i.r.p. density for in-band emissions 10 dBm/MHz
	  Indoor only
   * VLP: 14 dBm (25 mW)
	  Mean e.i.r.p. density for in-band emissions 1 dBm/MHz
	  Indoor and outdoor use

Reference ETSI EN 301 893 [2], for the 5 GHz and 5.8 GHz ranges, TPC is
required. being able to reduce TX power by up to 6 dB. (Add this rule
followed by [1] with annotation "ETSI:")

[1] https://www.ca.go.ke/sites/default/files/2023-06/Guidelines-on-the-Use-of-Radiofrequency-Spectrum-by-Short-Range-Devices-2022.pdf
[2] https://www.etsi.org/deliver/etsi_en/301800_301899/301893/02.01.01_60/en_301893v020101p.pdf

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2:
  - align freq range of reference
  - use power unit as reference
  - -6dBm for 5 GHz and 5.8 GHz ranges
---
 db.txt | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/db.txt b/db.txt
index 60343a745ecf..648530192b75 100644
--- a/db.txt
+++ b/db.txt
@@ -984,11 +984,15 @@ country JP: DFS-JP
 	# ref: http://www.arib.or.jp/english/html/overview/doc/1-STD-T74v1_1.pdf
 	(57000 - 66000 @ 2160), (10 mW)
 
+# Source:
+# https://www.ca.go.ke/sites/default/files/2023-06/Guidelines-on-the-Use-of-Radiofrequency-Spectrum-by-Short-Range-Devices-2022.pdf
+# ETSI EN 301 893: https://www.etsi.org/deliver/etsi_en/301800_301899/301893/02.01.01_60/en_301893v020101p.pdf
 country KE: DFS-JP
-	(2402 - 2482 @ 40), (20)
-	(5170 - 5250 @ 80), (23)
-	(5490 - 5570 @ 80), (30), DFS
-	(5735 - 5775 @ 40), (23)
+	(2400 - 2483.5 @ 40), (2000 mW)
+	(5150 - 5350 @ 80), (17), DFS
+	(5470 - 5725 @ 80), (18), DFS
+	(5725 - 5875 @ 40), (17), DFS
+	(5925 - 6425 @ 320), (23), NO-OUTDOOR
 
 country KH: DFS-ETSI
 	(2402 - 2482 @ 40), (20)
-- 
2.25.1


