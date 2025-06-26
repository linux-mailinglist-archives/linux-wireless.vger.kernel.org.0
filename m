Return-Path: <linux-wireless+bounces-24529-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8AA8AE9945
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 10:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64ED9189B8C7
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 08:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56C32BD5A2;
	Thu, 26 Jun 2025 08:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bPf/VXMy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DCEC2C08D0
	for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 08:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750928195; cv=none; b=hRlBw3rZxnIANYs/uBrnDpg5/rnwAxfZUYjisdCrBsUZV3yiHIXfXfx21yyL4S31GtYDZxenbshP8pPEFyhclrs/4B89WkC6BnYoX8y89pJLqAYiAK/IjE20b9i5xkwTZyJQkeNqYm1RO5BoBjn4S0HhhcHOuMT7mD3nFklVmu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750928195; c=relaxed/simple;
	bh=yJPFFRrEtfLrU/IrZwIP86F5vsPeQCg7lcvpJ/N8gfE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e9F7uzyXkX+QlEmSYqfVuinhZIMM80MUhDHa2pPfYF6H19iN83CE5ObuBwF0BWsGN4TomJInkmp/MONQvZAnix3btee38WrzbYB7PmZacPRXUW5nEihC+g1p7QumC4E9+AUChXiwauRJeWC3KcTzXZywOLUwIkeq1dyEBYzKOLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bPf/VXMy; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-748e63d4b05so520606b3a.2
        for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 01:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750928193; x=1751532993; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XEnTNGf+JVSlAmdexfBtW1ws7OdnxAZZ4hs1eOrDZk4=;
        b=bPf/VXMyi3y+uZ5dIjH67KFUKvQjCRe1QhzLSv/lQblMx2IRW2B0yO/TLXAnnFjhsh
         zfN5Tc5K/Ig6AYpeyl6BWHqwGWDA1BQsAcIJPq6OIyf6MncW4Km3A+S7wwCtm3G5U4/w
         ozFrtQMvAQmu8UhiSjWT5yQe7SVnxbLCYyHJszeTe4FfHXD3zYVRdZfSlzODBSTxE8Uf
         oXVCCy+E/Pw7a9gmvTzhyfJfez0udEUah9xtTV4vCjpUMI+ywZz54j0Szs5JEpXucaSw
         mKkdOV5i9+ik3wEew7g27IliS3gp1Q4zLVp71vHo6Mxc8MLgH8Vqxc27HiEnoankoIcl
         fLTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750928193; x=1751532993;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XEnTNGf+JVSlAmdexfBtW1ws7OdnxAZZ4hs1eOrDZk4=;
        b=FH6/Nat2nlz3FhaawSVaa6afA3zJwc3LECq5k9T/tpOHnZ34WGP5MyHOh0n3KBe40a
         awiDKng/8Y5Ri7n8/GWe1xK10nJsQUEMO2ozjFEfFsOXsyI+KV8sSGWBSacrrnrhIHmZ
         XbArYcUeEz7xKopC2iQOQbdjnymos2A1QJKDSBLXYTknnD1iy35uKJuvhNcaw5g7W2fk
         i4Ez7uCGO4l32oDfnyTtmVbq6lgdzRPmOOOB5bVCA0nZTNe/9po1zXM2F77I5AoR1qiJ
         FBwqgeim4Ta2cZPe4y1lUTtEqmmlI+Vxod9/PGR2tJA1Sg/BWpDQvbE0BFwFjTI2Y9HA
         6ZGg==
X-Gm-Message-State: AOJu0YzTQD+jh8MHRGHAMEn3zG/BWGQdYgxN3H8+x/aevAVLskRxQ+Sy
	BquvLigqzBXxekRGPCftgKx7+6Klv0o99n2eFXPr48/nhFTvf0mjlkTR56gkAgq8
X-Gm-Gg: ASbGnct//X7cRoibzb3LFFpA7+lmPX9kO7UJmPvOET/8/TKSuDXoc2hjNlYQaPvc8V3
	nH0pN3e3+8DnYmxfJroVh68qs/EJf1nlwsmtKpuY2/vRVloeHtWGedJ7CO1+8dEn31L8mFKLfXW
	EdugtF+p4/Dq3M/pvBqFmmlFgxx9f/dKKJAXSwTHrSvOEF2f7ZbxNOUCgw18UbqL76f0IRQJ4H9
	r6NeLfkGpjEMugYxb8oul3R6fzOxVLI0MrDbWmwJaYSCvveQxaWHyMfDQnjplX7WU3k7OBk6/kq
	u1AZXXKAexoQVE9eiRtJdiIxfx3om5goVMoTvdhm4HOGETFqPNg7OnOt9s7HnQnEO5YUqeXNYux
	zAw==
X-Google-Smtp-Source: AGHT+IGjIhlopk2iJfEf8XB33dORDbgSIdiJ0CG7tQ+mUCErucaOoia9gGplEZKZ0SmYYBWbFpMenQ==
X-Received: by 2002:a05:6a00:8c6:b0:748:2cbb:be45 with SMTP id d2e1a72fcca58-74ad44fa80fmr8664206b3a.15.1750928192971;
        Thu, 26 Jun 2025 01:56:32 -0700 (PDT)
Received: from glados.lan ([2804:d51:4975:7202:7e03:331b:6be0:eea6])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b34c4446073sm1200626a12.50.2025.06.26.01.56.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 01:56:32 -0700 (PDT)
From: Marcos Alano <marcoshalano@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: wens@kernel.org,
	wireless-regdb@lists.infradead.org,
	Marcos Alano <marcoshalano@gmail.com>
Subject: [PATCH v2] wireless-regdb: Update regulatory rules for Brazil (BR) on 6GHz
Date: Thu, 26 Jun 2025 05:55:22 -0300
Message-ID: <20250626085522.2391666-1-marcoshalano@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change rules for 6GHz on Brazil removing `NO-IR` and adding
`AUTO-BW` so the 6GHz band can be used.

Add the relevant normatives in comments.

Signed-off-by: Marcos Alano <marcoshalano@gmail.com>
---
 db.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/db.txt b/db.txt
index 803f1bc..f74819c 100644
--- a/db.txt
+++ b/db.txt
@@ -321,8 +321,8 @@ country BO: DFS-JP
 
 # Source:
 # https://www.gov.br/anatel/pt-br/regulado/radiofrequencia/radiacao-restrita
-# https://informacoes.anatel.gov.br/legislacao/resolucoes/2017/936-resolucao-680
-# https://informacoes.anatel.gov.br/legislacao/atos-de-certificacao-de-produtos/2017/1139-ato-14448
+# https://informacoes.anatel.gov.br/legislacao/resolucoes/2025/2001-resolucao-772
+# https://informacoes.anatel.gov.br/legislacao/atos-de-requisitos-tecnicos-de-gestao-do-espectro/2024/1920-ato-915
 country BR: DFS-FCC
 	(2400 - 2483.5 @ 40), (30)
 	# The next three ranges have been reduced by 3dB, could be increased
@@ -331,7 +331,7 @@ country BR: DFS-FCC
 	(5250 - 5350 @ 80), (27), NO-OUTDOOR, DFS, AUTO-BW
 	(5470 - 5725 @ 160), (27), DFS, AUTO-BW
 	(5725 - 5850 @ 80), (30), AUTO-BW
-	(5925 - 7125 @ 320), (12), NO-OUTDOOR, NO-IR
+	(5925 - 7125 @ 320), (12), NO-OUTDOOR
 	# EIRP=40dBm (43dBm peak)
 	(57000 - 71000 @ 2160), (40)
 
-- 
2.49.0


