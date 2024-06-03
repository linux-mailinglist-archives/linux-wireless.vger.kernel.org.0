Return-Path: <linux-wireless+bounces-8402-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 303468D7B5E
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Jun 2024 08:10:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE7F9B218B6
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Jun 2024 06:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F256420DF7;
	Mon,  3 Jun 2024 06:10:09 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F512C6BB
	for <linux-wireless@vger.kernel.org>; Mon,  3 Jun 2024 06:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717395009; cv=none; b=bMUdLHqXF2DQCL0wqsbAEnWPq6yseuTPyT7w0DQptYAIwPFkXaJDjnBsMVamVhR1oLixcYvfYin4VXCPJ5OEQ2C4YqJT34DdqVQ9cvXP7xA6uyIoi3u3mDygW2kjjxgTtQ2XbzSVh6uoIV2mlPzDPaUwSiT6BOBUuYsXnfVQ7w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717395009; c=relaxed/simple;
	bh=LaHSV+JXpj0rdMBgjeFgYysDmKtbr0u/T0AT6nZ+dxk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U01Ud12uBIisXqjoZTbRMJP7e9jOHagTLXhp5jPs0offHryz38dZxl81vo4z3El3OrArdhhX4cjD+ooqQfdg2CVoDdVL8f+Ta/XNezNVSxgotQIBblOrLvevcqDJSccIlbtD7dVqHjRNzMDw8Gy/MN/3OO3iprFxumPTN+KdRVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 45369vFJ22477225, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 45369vFJ22477225
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Jun 2024 14:09:57 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 3 Jun 2024 14:09:57 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 3 Jun
 2024 14:09:57 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <wens@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <wireless-regdb@lists.infradead.org>
Subject: [PATCH 4/4] wireless-regdb: Update regulatory info for Mexico (MX) on 6GHz
Date: Mon, 3 Jun 2024 14:09:48 +0800
Message-ID: <20240603060948.99147-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240603060558.98791-1-pkshih@realtek.com>
References: <20240603060558.98791-1-pkshih@realtek.com>
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

The Plenary Session of the Federal Telecommunications Institute (IFT)
determined, in its IV ordinary session of 2023, to classify the
5925 - 6425 MHz frequency segment as free spectrum and issued the
technical operating conditions that allow coexistence with the existing
services in the country [2].

Within the operating conditions of this band as free spectrum, its use was
determined for low power indoor and very low power indoor and outdoor
systems.

According to WBA Response to the Mexico IFT 6 GHz Consultation [3]. The
Low Power Indoor is
	33 dBm Max Tx Power (EIRP) & 8dBm/MHz PSD (EIRP) for Access Points
and
	27 dBm Max Tx Power (EIRP) & 2dBm/MHz PSD (EIRP) for Clients

The Very Low Power is 4 dBm Max Tx Power (EIRP)

[1] https://www.ift.org.mx/comunicacion-y-medios/comunicados-ift/es/el-pleno-del-ift-clasifica-la-banda-de-5925-6425-mhz-como-espectro-libre-comunicado-132023-16-de
[2] https://www.ift.org.mx/sites/default/files/comunicacion-y-medios/comunicados-ift/comunicado13ift_1.pdf
[3] https://www.ift.org.mx/sites/default/files/industria/temasrelevantes/consultaspublicas/documentos/20210119-cpi6ghz2020-162.pdf

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 db.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/db.txt b/db.txt
index 1999086d4694..970f47a87247 100644
--- a/db.txt
+++ b/db.txt
@@ -1293,12 +1293,16 @@ country MW: DFS-ETSI
 	(5250 - 5330 @ 80), (20), DFS, AUTO-BW
 	(5490 - 5710 @ 160), (27), DFS
 
+# Source:
+# https://www.ift.org.mx/sites/default/files/comunicacion-y-medios/comunicados-ift/comunicado13ift_1.pdf
+# https://www.ift.org.mx/sites/default/files/industria/temasrelevantes/consultaspublicas/documentos/20210119-cpi6ghz2020-162.pdf
 country MX: DFS-FCC
 	(2402 - 2482 @ 40), (20)
 	(5170 - 5250 @ 80), (17), AUTO-BW
 	(5250 - 5330 @ 80), (24), DFS, AUTO-BW
 	(5490 - 5730 @ 160), (24), DFS
 	(5735 - 5835 @ 80), (30)
+	(5925 - 6425 @ 320), (33), NO-OUTDOOR
 
 # Source:
 # https://www.mcmc.gov.my/skmmgovmy/media/General/CA-No-1-of-2022_-signed_19012022.pdf
-- 
2.25.1


