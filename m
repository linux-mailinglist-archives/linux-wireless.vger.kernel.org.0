Return-Path: <linux-wireless+bounces-8652-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A948FF9F5
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jun 2024 04:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3B7F1C21B76
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jun 2024 02:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 203E117993;
	Fri,  7 Jun 2024 02:32:09 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8641915ACB
	for <linux-wireless@vger.kernel.org>; Fri,  7 Jun 2024 02:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717727529; cv=none; b=bgju3GaZxoE/Twn2lkFgkFux6bLBk/1UULNgm33Rye/bcOy6jBjCLDJEBplK0DsvqUU9pAaUUlwsSb9MIQpzmRLVP1Xqv02SzY+LCPMTrYC8rLbn6pONMrEaqLgeuBxraeVbVI0/PzXPxZ8ZtalRd6iH8+2RTMafA6HDj8S+1LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717727529; c=relaxed/simple;
	bh=uY/+mMFipFQurRIsFjmJWhKgSARza90eY6po9Fdu3xY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=n1xaI6ORxECw3ehdp7wIJh2emPnsfmSihOakeadpsq8yksxbJ7oCa6KYR+CG70JrHec7Z1bEHkAQfrbG2JA22F6cN1m7eAZ3Hr1RBCBs5cx/gKak1EmOUFEYUq0sZDAg7M5y1iToJUgwFTWH6L0FLiH7pLYKkxA8Y1urNoF0ocU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4572VJrH43495091, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4572VJrH43495091
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Jun 2024 10:31:19 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 7 Jun 2024 10:31:19 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 7 Jun
 2024 10:31:19 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <wens@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <wireless-regdb@lists.infradead.org>
Subject: [PATCH 1/5] wireless-regdb: Update regulatory info for Argentina (AR) on 6GHz
Date: Fri, 7 Jun 2024 10:30:54 +0800
Message-ID: <20240607023058.34002-1-pkshih@realtek.com>
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

NATIONAL COMMUNICATIONS ENTITY issued Technical Characteristics WiFI6
Equipment on 05/22/2023 by Appendix 1 of [1], which 1) an access point or
subordinate device may operate in the 5925-7125 MHz band with a Power
Maximum Radiated Isotropic Equivalent (EIRP) of 30 dBm and a maximum
EIRP spectral density of 5 dBm in a bandwidth of 1 MHz; 2) A client device
may operate in the 5925-7125 MHz band with an Isotropic Radiated Power
equivalent (EIRP) of 24 dBm and a maximum EIRP spectral density of -1 dBm
over a width of 1 MHz band.

Considering -1 dBm/MHz for client device, 12 dBm is adopted.

[1] https://www.boletinoficial.gob.ar/detalleAviso/primera/287126/20230524

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 db.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/db.txt b/db.txt
index 966c708bf0df..9c2c031d9de7 100644
--- a/db.txt
+++ b/db.txt
@@ -89,12 +89,15 @@ country AN: DFS-ETSI
 	(5250 - 5330 @ 80), (20), DFS, AUTO-BW
 	(5490 - 5710 @ 160), (27), DFS
 
+# Source:
+# https://www.boletinoficial.gob.ar/detalleAviso/primera/287126/20230524
 country AR: DFS-FCC
 	(2402 - 2482 @ 40), (20)
 	(5170 - 5250 @ 80), (17), AUTO-BW
 	(5250 - 5330 @ 80), (24), DFS, AUTO-BW
 	(5490 - 5730 @ 160), (24), DFS
 	(5735 - 5835 @ 80), (30)
+	(5925 - 7125 @ 320), (12), NO-OUTDOOR
 
 country AS: DFS-FCC
 	(2402 - 2472 @ 40), (30)
-- 
2.25.1


