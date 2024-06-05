Return-Path: <linux-wireless+bounces-8520-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ABC38FC4CE
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Jun 2024 09:43:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAECB1C22134
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Jun 2024 07:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC77C18C33D;
	Wed,  5 Jun 2024 07:42:58 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B4F18F2DC
	for <linux-wireless@vger.kernel.org>; Wed,  5 Jun 2024 07:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717573378; cv=none; b=YQOJLNy8Y6AnO3pCFxEzNy2njoxjdOorDcPfLsT2VKYDzfIIwsV+nvDt/s4tv7dWndr4NMEnItvu0tUQaPzZTIIM68Uv7Am0AO/KHgZ3MGPpQXQLjGwUYYsca8+mZFq4x3ERqEeVyM7ZScU5EYs0g8olQhtJRxXZW4y8MlNSJvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717573378; c=relaxed/simple;
	bh=k66faSDs9O/3zMBStTX0wwVlbfVhuXNCht6jftRMNks=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o/BZuO6OfslloOdBo4qBvjaBJnGnCn4MjEjTULRTQYIWWmWE0/A5IRhVjQMijyXFM/DS947Y1R0kUA/14dFqzQ6nSxc6Yd9HZWT00C5+PzAMcpDdhg3SRZux53Tm6ZKn1775frAOXlMKs5tYk9vPHS+p0uH5YeEjW2tyt/Ly6is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4557gb7I31237066, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4557gb7I31237066
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Jun 2024 15:42:37 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 5 Jun 2024 15:42:37 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 5 Jun
 2024 15:42:36 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <wens@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <wireless-regdb@lists.infradead.org>
Subject: [PATCH v3 3/4] wireless-regdb: Update regulatory info for Chile (CL) on 6GHz
Date: Wed, 5 Jun 2024 15:42:08 +0800
Message-ID: <20240605074209.8713-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240605074209.8713-1-pkshih@realtek.com>
References: <20240605074209.8713-1-pkshih@realtek.com>
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

MINISTRY OF TRANSPORT AND TELECOMMUNICATIONS; UNDERSECRETARY OF
TELECOMMUNICATIONS announced RESOLUTION 1985 EXEMPT FIXED TECHNICAL
STANDARD FOR REDUCED RANGE EQUIPMENT. Section j.1) describes access
equipment, also referred to as AP, must be for exclusive indoor use with
condition of Maximum EIRP of 30 dBm (Maximum spectral density of 5 dBm/MHz).

User terminal devices that are associated with low-power AP equipment must
operate at the following power levels of Maximum EIRP of 24 dBm
(Maximum spectral density of -1 dBm/MHz). Devices that use internal
batteries may operate outdoors, with a maximum average EIRP power of
17 dBm.

With -1 dBm/MHz for user terminal devices and smallest channel is 20 MHz,
limit 12 dBm is adopted.

[1] https://www.bcn.cl/leychile/navegar?idNorma=1109333&idParte=9841504&idVersion=&r_c=6

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
v3: no change
v2: considering clause of -1 dBm/MHz, set limit to 12 dBm.
---
 db.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/db.txt b/db.txt
index 99d3f61092b7..d3b106526252 100644
--- a/db.txt
+++ b/db.txt
@@ -395,11 +395,14 @@ country CI: DFS-FCC
 	(5490 - 5730 @ 160), (24), DFS
 	(5735 - 5835 @ 80), (30)
 
+# Source:
+# https://www.bcn.cl/leychile/navegar?idNorma=1109333&idParte=9841504&idVersion=&r_c=6
 country CL: DFS-JP
 	(2402 - 2482 @ 40), (20)
 	(5170 - 5250 @ 80), (20), AUTO-BW
 	(5250 - 5330 @ 80), (20), DFS, AUTO-BW
 	(5735 - 5835 @ 80), (20)
+	(5925 - 6425 @ 320), (12), NO-OUTDOOR
 
 # Source:
 # https://wap.miit.gov.cn/cms_files/filemanager/1226211233/attach/20219/d125301b13454551b698ff5afa49ca28.pdf
-- 
2.25.1


