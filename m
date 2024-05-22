Return-Path: <linux-wireless+bounces-7932-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 114948CBB72
	for <lists+linux-wireless@lfdr.de>; Wed, 22 May 2024 08:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A74781F230E8
	for <lists+linux-wireless@lfdr.de>; Wed, 22 May 2024 06:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1364C79B8E;
	Wed, 22 May 2024 06:32:04 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F95B79952
	for <linux-wireless@vger.kernel.org>; Wed, 22 May 2024 06:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716359524; cv=none; b=dNV84GHmXdupypjCkIGs9UEA+a+9OA0YyxlEh6+DIZQloEokwA16cNrlY2VHK5lRIK8ipxZE+f7jta2LI97j0yWFOleBhcNbpg0AJp/SjYjIXk5gJGzEgpZKGPFVcDxOJAB0dxshB9hs3iQ4mHbMITQVRVYhnNp9FUlZC6yrhxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716359524; c=relaxed/simple;
	bh=/l9Szdj1wqsc8ihpU7jYa0KD1IqfHEUplLazHLFp0F0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hPTWI1nxJ2swY3pgrNntqYFkEG/O4zUjxT/M5uDuMG0ftZOwGB7DYrgQ1Kwv4/vinjNdxrJp9HbvYtiertVjFr17pxH6xsA9xBipmZsteELH/p4MnWQWJ99iTttb4CGtMMuZV+zrkCfyTLMCAI1r/4iW85xtw3gLsPuNU+gWay4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 44M6UBAZ03582126, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 44M6UBAZ03582126
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 May 2024 14:30:11 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 22 May 2024 14:30:11 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 22 May
 2024 14:30:11 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <wens@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <wireless-regdb@lists.infradead.org>
Subject: [PATCH 4/4] wireless-regdb: Update regulatory info for Thailand (TH) on 6GHz
Date: Wed, 22 May 2024 14:29:46 +0800
Message-ID: <20240522062946.69832-1-pkshih@realtek.com>
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

The Broadcasting Commission Television business and the National
Telecommunications Commission announced Technical standards for
telecommunications equipment and equipment for radiocommunication equipment
that uses the frequency 5.925 - 6.425 GHz [2], which section 2.1 describes
e.i.r.p. (Equivalent Isotropically Radiated Power) is 250mW and 25mW for
indoor and indoor/outdoor respectively.

[1] https://ratchakitcha.soc.go.th/documents/140D100S0000000004000.pdf
[2] https://ratchakitcha.soc.go.th/documents/140D100S0000000004200.pdf
[3] https://ratchakitcha.soc.go.th/documents/140D100S0000000004300.pdf

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 db.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/db.txt b/db.txt
index 022ecb3719b6..c7008e23b7ca 100644
--- a/db.txt
+++ b/db.txt
@@ -1702,12 +1702,17 @@ country TG: DFS-ETSI
 	(5250 - 5330 @ 40), (20), DFS
 	(5490 - 5710 @ 40), (27), DFS
 
+# Source:
+# https://ratchakitcha.soc.go.th/documents/140D100S0000000004000.pdf
+# https://ratchakitcha.soc.go.th/documents/140D100S0000000004200.pdf
+# https://ratchakitcha.soc.go.th/documents/140D100S0000000004300.pdf
 country TH: DFS-FCC
 	(2402 - 2482 @ 40), (20)
 	(5170 - 5250 @ 80), (17), AUTO-BW
 	(5250 - 5330 @ 80), (24), DFS, AUTO-BW
 	(5490 - 5730 @ 160), (24), DFS
 	(5735 - 5835 @ 80), (30)
+	(5925 - 6425 @ 320), (25 mW)
 
 country TN: DFS-ETSI
 	(2402 - 2482 @ 40), (20)
-- 
2.25.1


