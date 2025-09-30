Return-Path: <linux-wireless+bounces-27725-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9DBFBAB621
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Sep 2025 06:36:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1356E7A5B7A
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Sep 2025 04:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEC2925A2A7;
	Tue, 30 Sep 2025 04:36:34 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from wens.tw (mirror2.csie.ntu.edu.tw [140.112.30.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0649624BD1A
	for <linux-wireless@vger.kernel.org>; Tue, 30 Sep 2025 04:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.112.30.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759206994; cv=none; b=OOQMYmPa1RwABFJxgTFQZ8TKBq/0gJ007d5ikVmkbJtkP3tdpcOnUzLYVrTVeo4+5BJUEtvKVIE6EqkZ8ftBykXcKjiukATmkdMEm7abhOcluxF86mqR/JjTbqG0yYJEPXLo5PliT8BlK0vY5kUcwHnYuakxRejOoQirQEq0bdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759206994; c=relaxed/simple;
	bh=Gk0y9fPZEcIzJKRAs7W/ROHc3kfAT9QdicKkZqErYdg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TrsIY4dyiw13WL2A+wjudS1hWmWrOgcnsU+yGGss2dE8iI80FH2mEhruBNd7wsTC0xVBcvXpDiD0u3mr7L+EquLRwbxdWGWp99dHQP2SY8zONBjWTbWRg9LUpD7KuO8pA/jVDamHOYjnzlrwHP6lRygrpliwRr1uq+c+X1Lafvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=wens.tw; arc=none smtp.client-ip=140.112.30.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wens.tw
Received: by wens.tw (Postfix, from userid 1000)
	id CFFB25FE36; Tue, 30 Sep 2025 12:29:54 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: Ping-Ke Shih <pkshih@realtek.com>,
	Pavel Starosek <starosekpd@gmail.com>
Cc: Chen-Yu Tsai <wens@kernel.org>,
	wireless-regdb@lists.infradead.org,
	linux-wireless@vger.kernel.org
Subject: [PATCH] wireless-regdb: Permit lower 6 GHz band for Kazakhstan (KZ)
Date: Tue, 30 Sep 2025 12:29:46 +0800
Message-ID: <20250930042948.427154-1-wens@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

By Order of the Minister of Digital Development No. 564/NK dated
September 19, 2024 [1], an amendment was made to the assignment of
frequency bands, opening up the lower part of the 6 GHz band (5,945 MHz
to 6,425 MHz) was opened up to "SRD (wideband data transmission systems)
WAS/RLAN Data transmission systems/radio local area networks".

The power is limited to 200 mW e.i.r.p. with a spectral density of 10
mW/MHz. Only indoor use is permitted.

While at it, also change the power limits to use mW units to match the
official documents.

Initial information was provided by the Wi-Fi Alliance website, which
has a map [2] showing all countries that have enabled 6 GHz WiFi, and
links to official documents. This document was not sufficient as it did
not include power limits or other restrictions.

A subsequent search found a blog post [3] providing details and titles
of the official documents in English. An AI agent was used to search
for the original text of said order [1] after rummaging through
government websites in Russian and Kazakh failed to find anything.

[1] https://adilet.zan.kz/rus/docs/V2400035100
[2] https://www.wi-fi.org/regulations-enabling-6-ghz-wi-fi
[3] https://www.onewindow.pro/blog-posts/6-ghz-band-regulation-in-the-republic-of-kazakhstan

Signed-off-by: Chen-Yu Tsai <wens@kernel.org>
---
If you received this patch, please help review it. The changes are
based on translations of the original text / tables, so a second set
of eyes would be appreciated.

 db.txt | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/db.txt b/db.txt
index 6e1ad30..16bcb32 100644
--- a/db.txt
+++ b/db.txt
@@ -1136,11 +1136,12 @@ country KY: DFS-FCC
 # http://adilet.zan.kz/rus/docs/V1500010730
 # http://adilet.zan.kz/rus/docs/V1500010375
 country KZ: DFS-ETSI
-	(2400 - 2483.5 @ 40), (20)
-	(5150 - 5250 @ 80), (23), NO-OUTDOOR, AUTO-BW
+	(2400 - 2483.5 @ 40), (100 mW)
+	(5150 - 5250 @ 80), (200 mW), NO-OUTDOOR, AUTO-BW
 	(5250 - 5350 @ 80), (20), NO-OUTDOOR, DFS, AUTO-BW
-	(5470 - 5725 @ 160), (20), NO-OUTDOOR, DFS
-	(5725 - 5850 @ 80), (20), NO-OUTDOOR
+	(5470 - 5725 @ 160), (100 mW), NO-OUTDOOR, DFS
+	(5725 - 5850 @ 80), (100 mW), NO-OUTDOOR
+	(5925 - 6425 @ 320), (200 mW), NO-OUTDOOR
 	(57000 - 66000 @ 2160), (40)
 
 country LB: DFS-FCC
-- 
2.47.3


