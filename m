Return-Path: <linux-wireless+bounces-9474-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 948F09140B0
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Jun 2024 04:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F2A32836F7
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Jun 2024 02:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A2F68827;
	Mon, 24 Jun 2024 02:57:25 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F8A8C13
	for <linux-wireless@vger.kernel.org>; Mon, 24 Jun 2024 02:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719197844; cv=none; b=CWsLpACdZ841VcELM05qcnu93FdqdSLWNwyHnKfGWRrt69KqubabV67VVwjdzwJXGoClkYAZYn4dO+woAs1GqWION883sYRPGrnrbcqeA+eBVYgaKKMNJsqQ6Ms1ySqOKMGXQinbq5MXZGzGhPfyqMCgZ0Wv50Khrmn4fmnFQZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719197844; c=relaxed/simple;
	bh=fBohlTe/lQJpVFLaRoQju6PU7kyAcjQUx2HZoOfVvgk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NSBpDQs+2eSN2U0v+tBX7aom8DxXbE7bfnQgy11lxIeGnxyjolW4uASlhHNSfZhdButDSvzsf2ei0OC3ByfOKls8sCzfxAF+h+M8N+dQcn3AiOhtq0Kb/pGVGfyfyaTueNfATKuAAkMHAjIUC90XFRk7p1ZvIrfqdHOFMEaGLw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 45O2uZzF52577508, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 45O2uZzF52577508
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Jun 2024 10:56:35 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 24 Jun 2024 10:56:35 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 24 Jun
 2024 10:56:34 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <wens@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <wireless-regdb@lists.infradead.org>
Subject: [PATCH v2 2/4] wireless-regdb: Update regulatory info for Jordan (JO) for 2022
Date: Mon, 24 Jun 2024 10:56:21 +0800
Message-ID: <20240624025623.6021-2-pkshih@realtek.com>
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

The Hashemite Kingdom of Jordan, Telecommunications Regulatory Authority
issued pursuant to the provisions of Articles (12A) and (22) of the
Telecommunications Law No. 31 of 1995, as amended. [1]

The effective radiated power (EIRP) of devices used in local radio computer
networks must not exceed the following values:

 - 2400-2483.5 MHz: 100 milliwatts (20 dBm)
 - 5150-5350 MHz: 200 milliwatts (23 dBm), (ETSI: 20 dBm, DFS)
 - 5470-5725 MHz: 1 watt (30 dBm), (ETSI: 27 dBm, indoor only, DFS)
 - 5725-5875 MHz: 200 mW (23 dBm), (ETSI: indoor only)
 - 5925-6425 MHz:
   * 25 milliwatts (14 dBm) (for outdoor and portable devices)
   * 200 milliwatts (23 dBm) (for devices operated indoors only)
 - 57-71 GHz: 10 W (40 dBm)

Follow ETSI EN 301 893 [2], which specifies reduced power limit of
20 and 27 dBm for the range 5150-5350 and 5470-5725 respectively for
devices that don't implement TPC; and classifies the 5470 - 5725 MHz and
5725 - 5875 MHz ranges as indoor use only; and DFS is required for bands
5250 - 5350 Mhz and 5470 - 5725 Mhz. (Add these rules followed rules of
[1] with "ETSI:" annotation)

[1] https://trc.gov.jo/EchoBusV3.0/SystemAssets/PDF/RSMD/cb9f9a83-43a6-4e66-8432-6e02ecaf465b_RLAN%20Arabic%20%20Final%20-%20clean%20with%2057-71%20GHz.pdf
[2] https://www.etsi.org/deliver/etsi_en/301800_301899/301893/02.01.01_60/en_301893v020101p.pdf

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2:
  - Follow ETSI EN 301 893 to modify limits, and add description in commit
    message.
  - add 57-71 GHz
---
 db.txt | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/db.txt b/db.txt
index 61c46186919e..60343a745ecf 100644
--- a/db.txt
+++ b/db.txt
@@ -957,10 +957,16 @@ country JM: DFS-FCC
 	(5490 - 5730 @ 160), (24), DFS
 	(5735 - 5835 @ 80), (30)
 
+# Source:
+# https://trc.gov.jo/EchoBusV3.0/SystemAssets/PDF/RSMD/cb9f9a83-43a6-4e66-8432-6e02ecaf465b_RLAN%20Arabic%20%20Final%20-%20clean%20with%2057-71%20GHz.pdf
+# ETSI EN 301 893: https://www.etsi.org/deliver/etsi_en/301800_301899/301893/02.01.01_60/en_301893v020101p.pdf
 country JO: DFS-JP
-	(2402 - 2482 @ 40), (20)
-	(5170 - 5250 @ 80), (23)
-	(5735 - 5835 @ 80), (23)
+	(2400 - 2483.5 @ 40), (20)
+	(5150 - 5350 @ 80), (20), DFS
+	(5470 - 5725 @ 80), (27), DFS, NO-OUTDOOR
+	(5725 - 5875 @ 80), (23), NO-OUTDOOR
+	(5925 - 6425 @ 320), (23), NO-OUTDOOR
+	(57000 - 71000 @ 2160), (40)
 
 # Source:
 # https://www.soumu.go.jp/main_content/000635492.pdf
-- 
2.25.1


