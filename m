Return-Path: <linux-wireless+bounces-8649-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD668FF9F2
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jun 2024 04:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C5881F23CF0
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jun 2024 02:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B634C11718;
	Fri,  7 Jun 2024 02:32:06 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E822310799
	for <linux-wireless@vger.kernel.org>; Fri,  7 Jun 2024 02:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717727526; cv=none; b=Fw8SDC4gz2TaY85bKy/TUNfC/dJx3p0S4dFY1LUTXWVFRf9j74DJheDsXmx642tan1cuOkKyym9R/m4k6foalsNtZwdHn+JcEu7AI9K8i9n3gURwhIZ2g7WCXsjY+GN74Y3RYlNBFaZX7Mrv5Xr47O5GOkUAY8T1/N8OcRoN/4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717727526; c=relaxed/simple;
	bh=P+ZqLl1KlYhdQ+VxqyLCHur5WZx5barbvhceU9Wb4lM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RLKNUOCwdgvy7nnVt7PKmypxLPQdrarQ2vmuKhgNRx3lo2+jGt/BMQIEMSLJQsDxny3rzVXie3Ynj/2XcpAjfEJFFeSlgoaWhcoQl2egbhF1YEEfXlgVbOQ1g+mqeAu+us3L1WRniKYm+y+GBFJkSPgORC+FFvVz7u54iqkZ9Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4572VUP603495113, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4572VUP603495113
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Jun 2024 10:31:30 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 7 Jun 2024 10:31:30 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 7 Jun
 2024 10:31:30 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <wens@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <wireless-regdb@lists.infradead.org>
Subject: [PATCH 4/5] wireless-regdb: Update regulatory info for Costa Rica (CR) for 2021
Date: Fri, 7 Jun 2024 10:30:57 +0800
Message-ID: <20240607023058.34002-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240607023058.34002-1-pkshih@realtek.com>
References: <20240607023058.34002-1-pkshih@realtek.com>
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

DECENTRALIZED INSTITUTIONS, REGULATORY AUTHORITY OF PUBLIC SERVICES,
announced ALCANCE NO 87 A LA GACETA NO 83 (in Spanish) on April 30, 2021.

For 6GHz band (frequency 5925-7125), allowed only the following usage
applications free in this segment:
 - Applications of low power in interiors (LPI), according to the limits of
   power 24 dBm.
 - Applications of very low power (VLP), indoors and exteriors, with an
   EIRP maximum of 14 dBm.

Also update and add limits of 2 and 5 GHz bands accordingly.

[1] https://storage.googleapis.com/eleoscompliance1.appspot.com/public/PNAF%20modificaci%C3%B3n%20ALCA87_30_04_2021.pdf

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 db.txt | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/db.txt b/db.txt
index c98749442873..cdec93783b20 100644
--- a/db.txt
+++ b/db.txt
@@ -434,12 +434,16 @@ country CO: DFS-FCC
 	(5735 - 5835 @ 80), (30)
 	(5925 - 7125 @ 320), (12), NO-OUTDOOR
 
+# Source:
+# https://storage.googleapis.com/eleoscompliance1.appspot.com/public/PNAF%20modificaci%C3%B3n%20ALCA87_30_04_2021.pdf
 country CR: DFS-FCC
-	(2402 - 2482 @ 40), (20)
-	(5170 - 5250 @ 20), (17)
+	(2402 - 2482 @ 40), (30)
+	(5170 - 5250 @ 20), (24)
 	(5250 - 5330 @ 20), (24), DFS
 	(5490 - 5730 @ 20), (24), DFS
 	(5735 - 5835 @ 20), (30)
+	(5875 - 5925 @ 20), (24)
+	(5925 - 7125 @ 320), (24), NO-OUTDOOR
 
 # Source:
 # https://www.mincom.gob.cu/es/marco-legal
-- 
2.25.1


