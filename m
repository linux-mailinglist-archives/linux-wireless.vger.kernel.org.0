Return-Path: <linux-wireless+bounces-8651-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 729818FF9F4
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jun 2024 04:32:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A34A1F23A62
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jun 2024 02:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC3B62F37;
	Fri,  7 Jun 2024 02:32:08 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6685A10799
	for <linux-wireless@vger.kernel.org>; Fri,  7 Jun 2024 02:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717727528; cv=none; b=rSo98OGgLSJm08uFXTdN4CrGM5r8w4VxWLS2kokTR/xc+qbi8nJboF+CBOFX7WgBGVxUBGGQcu0RjQLbJtS/E5/lCS44xuYfwPZzbGRf/ImRpJNVedPMe7x56/ykGO7KuAROPDShWyYhml5ldxHgEqVjAiM+uMyWwHP+/NEvDoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717727528; c=relaxed/simple;
	bh=A2AOQn84H1MLFg6oGHqvMxSw3UV6uU7DtXbYs0aJjGs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BKlvzcVexmQXzpgcMTVp4LMm92kWG36ZkLYFrOObiMkEsBY7E4YoECFyltYT5k/vO+9NoEYicB+et/OM4P6UnwAvjf1azbJh4pQDrRdapXHqfzbjwhLC8QsMTb03PF9Gl7YUVsV1iJbumo3k62b9omFR1dzfDFhaqaNOHAjQc5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4572VNntC3495102, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4572VNntC3495102
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Jun 2024 10:31:23 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 7 Jun 2024 10:31:23 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 7 Jun
 2024 10:31:23 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <wens@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <wireless-regdb@lists.infradead.org>
Subject: [PATCH 2/5] wireless-regdb: Update regulatory info for United Arab Emirates (AE) on 6GHz
Date: Fri, 7 Jun 2024 10:30:55 +0800
Message-ID: <20240607023058.34002-2-pkshih@realtek.com>
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

Telecommunications Regulatory Authority (TRA) has designated an additional
500 MHz radio spectrum of 6 GHz band (specifically 5925-6425 MHz) to
Wi-Fi for indoor use at an EIRP of 250 mW under class authorization. [1]

[1] https://wam.ae/en/details/1395302898209

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 db.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/db.txt b/db.txt
index 9c2c031d9de7..232ca875c6c2 100644
--- a/db.txt
+++ b/db.txt
@@ -44,12 +44,15 @@ country AD: DFS-ETSI
 	# 60 GHz band channels 1-4, ref: Etsi En 302 567
 	(57000 - 66000 @ 2160), (40)
 
+# Source:
+# https://wam.ae/en/details/1395302898209
 country AE: DFS-FCC
 	(2402 - 2482 @ 40), (20)
 	(5170 - 5250 @ 80), (17), AUTO-BW
 	(5250 - 5330 @ 80), (24), DFS, AUTO-BW
 	(5490 - 5730 @ 160), (24), DFS
 	(5735 - 5835 @ 80), (30)
+	(5925 - 6425 @ 320), (250 mW), NO-OUTDOOR
 
 country AF: DFS-ETSI
 	(2402 - 2482 @ 40), (20)
-- 
2.25.1


