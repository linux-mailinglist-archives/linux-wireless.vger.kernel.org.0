Return-Path: <linux-wireless+bounces-9411-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B35911E36
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 10:13:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBFD21C219D0
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 08:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ECE214D2A4;
	Fri, 21 Jun 2024 08:04:40 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE5A16D4D1
	for <linux-wireless@vger.kernel.org>; Fri, 21 Jun 2024 08:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718957080; cv=none; b=aAy/bn6n4yWx+6499ofKBWDaYTMffHyQb9BZVAWljZ97JkCpWzZVZrgtNrTdjZa0Icqx64O8xT7wN5bBHzQf+qRVGjaaVlPrFCSWKW+RGH7FpZsd8ChNnv1GgJLw6XGvi7xK6IQVXrf6dpeukDk56FnS5MH9XGIyDpfoR/8AGQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718957080; c=relaxed/simple;
	bh=weuisKtp7V7ZnJ0ojQ9JLk55onJO8sYaoFdmzRw19J4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TXwzSIanL6qlKH76hmn1/y7zuoSBN3r+IK7YUR0NGUrqrqdum8AU94+7w3cd5XwWVjnDlNvNK/IdUzhzTnMEZO0nlO6k4GBDl02gNvNpHSq8ESeXeBMf1JEtu45TqSvnYCDtH85ovYFQbte9fV7ainfEAcn41tjN3R+f1FHnQ2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 45L84Fm343890090, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 45L84Fm343890090
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Jun 2024 16:04:15 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 21 Jun 2024 16:04:16 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 21 Jun
 2024 16:04:15 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <wens@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <wireless-regdb@lists.infradead.org>
Subject: [PATCH v2 3/5] wireless-regdb: Update regulatory info for Colombia (CO) on 6GHz
Date: Fri, 21 Jun 2024 16:03:46 +0800
Message-ID: <20240621080348.55504-3-pkshih@realtek.com>
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

REPUBLIC OF COLOMBIA, NATIONAL SPECTRUM AGENCY announced RESOLUTION
No. 000737 OF 2022-11-18 [2] accessed via [1], which specific operating
conditions inf the band of 5925 - 7125 MHz.
  - P.I.R.E. maximum 30 dBm and spectral density of P.I.R.E. maximum
    5 dBm/MHz for the access devices.
  - P.I.R.E. maximum 24 dBm and spectral density of P.I.R.E. maximum
    -1 dBm/MHz for client devices.

Permitted indoor use only.

Considering -1 dBm/MHz for client devices, 12 dBm is adopted.

[1] https://www.ane.gov.co/SitePages/det-noticias.aspx?p=414
[2] https://www.ane.gov.co/Sliders/archivos/gesti%C3%B3n%20t%C3%A9cnica/Estudios%20de%20gesti%C3%B3n%20y%20planeaci%C3%B3n/Banda%206%20GHz/Documentos%20decisi%C3%B3n/Resolucion%20000737%20del%2018112022.pdf

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2: no change
---
 db.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/db.txt b/db.txt
index 232ca875c6c2..c98749442873 100644
--- a/db.txt
+++ b/db.txt
@@ -424,12 +424,15 @@ country CN: DFS-FCC
 	(59400 - 63720 @ 2160), (44)
 	(63720 - 65880 @ 2160), (28)
 
+# Source:
+# https://www.ane.gov.co/Sliders/archivos/gesti%C3%B3n%20t%C3%A9cnica/Estudios%20de%20gesti%C3%B3n%20y%20planeaci%C3%B3n/Banda%206%20GHz/Documentos%20decisi%C3%B3n/Resolucion%20000737%20del%2018112022.pdf
 country CO: DFS-FCC
 	(2402 - 2482 @ 40), (20)
 	(5170 - 5250 @ 80), (17), AUTO-BW
 	(5250 - 5330 @ 80), (24), DFS, AUTO-BW
 	(5490 - 5730 @ 160), (24), DFS
 	(5735 - 5835 @ 80), (30)
+	(5925 - 7125 @ 320), (12), NO-OUTDOOR
 
 country CR: DFS-FCC
 	(2402 - 2482 @ 40), (20)
-- 
2.25.1


