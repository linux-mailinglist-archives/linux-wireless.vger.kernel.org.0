Return-Path: <linux-wireless+bounces-1265-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 855FD81D426
	for <lists+linux-wireless@lfdr.de>; Sat, 23 Dec 2023 14:09:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7E8FB21567
	for <lists+linux-wireless@lfdr.de>; Sat, 23 Dec 2023 13:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF98D2F2;
	Sat, 23 Dec 2023 13:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gfqls4tl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC13D2E9
	for <linux-wireless@vger.kernel.org>; Sat, 23 Dec 2023 13:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6d9a7233133so1129b3a.0
        for <linux-wireless@vger.kernel.org>; Sat, 23 Dec 2023 05:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703336938; x=1703941738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=giEk1ukUCaG6bmqGiBslb7r3jzbq49P7oe4tCxYAA1E=;
        b=Gfqls4tlq7nQG4KTB/xAk+zVyNWh3cfUcqqHOvy5WWaKJ+WMHmGMNzpfwh2bK1Ctye
         mXJLjUhDXc44q+nXW8EOC/FYFX+iK750FidQdNmArxlPStSaaQ8yBGScKFQN+k00P4M0
         C9yjgY0MRvNG0Cd7cJ3mB4IL3NvemKSpUkR5RqGpRJUQYZZGqxXcD3luhDYjbLrMowOH
         hrYLsYKCNA+23/xUzbLiysgAUH4627lGM4c1Zj3uoe8IxtZQymoKoXOYUsahsVbvSgE5
         mdKOX49Oxm3BMcosK6aHtyC8aBbltuX9fo7BidOJCKDb9Ly1PcnT4eyDcKpsCYEqg9L2
         qIIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703336938; x=1703941738;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=giEk1ukUCaG6bmqGiBslb7r3jzbq49P7oe4tCxYAA1E=;
        b=LAbM8+4XTvX+HKy/f2gJUn6cnAjrttNVa5A0bZQXd1OlBjJxUs+OAX9AR4hHesYoNL
         IVPZwf75hyU2aZ8OYLDMxtEWr8O1whrkjADkaZxcnheKTPGjf8b2L/45ble79alQq4SK
         m/M8lXldiVv4ybJQFvAcywuyYjMy88NntAQEow52h27PygZRXYbhoHgVQkb0jeo4Cs5w
         BBljZXLMzLH7ocQomnrg1DxN/XDB4OykANOh3Z7gEoc1CIXMk9pf8I8oL/VvBr96Q3Mi
         jp33hsuFAX9VSK++H6Y9929fWWfeDrDkMNG0n+t0eDf9fPjg0M8HiEmwgL0UeAWV0KTL
         AtWQ==
X-Gm-Message-State: AOJu0YzCliWQfxJLwQXN/8IG5i915abuKGULCkiaieOC5JT1ZcqdVEXx
	2AVxgvEVdd7YauvBlpmGKCJzdoXgCJ+llw==
X-Google-Smtp-Source: AGHT+IHDAFk+ShOsE8erbpqJpgU4kaJHDB5HCe2u4GxUw9HU/il708ZE/Pc8RHzDzw0NFtXoeGfoFQ==
X-Received: by 2002:aa7:804e:0:b0:6d9:a70d:7732 with SMTP id y14-20020aa7804e000000b006d9a70d7732mr66153pfm.24.1703336937650;
        Sat, 23 Dec 2023 05:08:57 -0800 (PST)
Received: from nuc11atkpe.. (113x34x39x75.ap113.ftth.ucom.ne.jp. [113.34.39.75])
        by smtp.gmail.com with ESMTPSA id fa20-20020a056a002d1400b006d64c4cb661sm4999489pfb.200.2023.12.23.05.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Dec 2023 05:08:57 -0800 (PST)
From: CaffeeLake <pascalcoffeelake@gmail.com>
X-Google-Original-From: CaffeeLake <PascalCoffeeLake@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: wireless-regdb@lists.infradead.org,
	CaffeeLake <PascalCoffeeLake@gmail.com>
Subject: [PATCH] wireless-regdb: Update regulatory rules for Japan (JP) for December 2023
Date: Sat, 23 Dec 2023 22:08:52 +0900
Message-ID: <20231223130852.44711-1-PascalCoffeeLake@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support 320MHz bandwidth for JP region.

The Ministry of Internal Affairs and Communications has approved 320MHz bandwidth with 11be in Japan.

Source: https://www.soumu.go.jp/main_content/000919158.pdf

Signed-off-by: CaffeeLake <PascalCoffeeLake@gmail.com>
---
 db.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/db.txt b/db.txt
index 24bb6d4..01e7338 100644
--- a/db.txt
+++ b/db.txt
@@ -944,6 +944,7 @@ country JO: DFS-JP
 # Source:
 # https://www.soumu.go.jp/main_content/000635492.pdf
 # https://www.soumu.go.jp/main_content/000833682.pdf
+# https://www.soumu.go.jp/main_content/000919158.pdf
 country JP: DFS-JP
 	(2402 - 2482 @ 40), (20)
 	(2474 - 2494 @ 20), (20), NO-OFDM
@@ -951,7 +952,7 @@ country JP: DFS-JP
 	(5170 - 5250 @ 80), (20), AUTO-BW
 	(5250 - 5330 @ 80), (20), DFS, AUTO-BW
 	(5490 - 5730 @ 160), (23), DFS
-	(5925 - 6425 @ 160), (200 mW), NO-OUTDOOR
+	(5925 - 6425 @ 320), (200 mW), NO-OUTDOOR
 	# 60 GHz band channels 2-4 at 10mW,
 	# ref: http://www.arib.or.jp/english/html/overview/doc/1-STD-T74v1_1.pdf
 	(57000 - 66000 @ 2160), (10 mW)
--
2.43.0


