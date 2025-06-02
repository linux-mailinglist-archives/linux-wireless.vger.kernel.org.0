Return-Path: <linux-wireless+bounces-23534-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C7CDACADD5
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Jun 2025 14:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C3B5189FF00
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Jun 2025 12:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A6921325D;
	Mon,  2 Jun 2025 12:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g8B3lVsx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88A3210184
	for <linux-wireless@vger.kernel.org>; Mon,  2 Jun 2025 12:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748866492; cv=none; b=ngmWDRAeHBhxJvWXKYtdIV4cluUIV7nnGAiFX25gTID6GCyWijdA5xeh0uS1vMRQc79s9dpOb1KHLs4gstyUMpLrb32tjiqDwUf9agDma8QUZ1NvBbmw6ONDnodN6P8EY25Qt9Ri9GH43+b1BMeYrp1O1MwU7AftHQpRwkZNr9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748866492; c=relaxed/simple;
	bh=OQTUmDmZc/HyUS2TuSojaZV4FgsQOWBRiTT6qrPB9nk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cdN01b4/IRcKTvuqMy5Kme9LDGnARDpMUOmB8Ry2mAhADHgz0J0IsHFiiOtnszT10vxk+sDaFIEzcl5WSQV0VGAsgkxT6CkEcLjEILhzo8Cmkt+VAUUxo0GSMBQbntK/bJKjoUf8ZWCBeo04y0SbcF3ygUFOsaJjaSKE+37QpRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g8B3lVsx; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-530807a8669so993064e0c.2
        for <linux-wireless@vger.kernel.org>; Mon, 02 Jun 2025 05:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748866489; x=1749471289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tWr6AOJZN4L7ViQbt0QAk8y9QOBvmnShKqnOnGfOD/I=;
        b=g8B3lVsxvVjxHF3RO3ZIIxc++MvicnQHWqZx8CNu5TFHuVx7hROh7Fe+ZVPrBq2QR8
         HXiEBevIkL1oP8l2jWMy3TAOirUFGZgZQKSu5XK6pRJRQQiBcubHng2cK4MzitQoYg/Y
         q61GicMaVdaUuIjZRAi18XagIhUZ9D6NfPC6R6xVp9XmBSbmrFxKtvBOtYRrETW7K5X7
         EaBrs/O0k/rt9Bf8quNJVOPGR6ey27O7UkhW47ueqMaWXOBj1jAXvDQaIObk27OyAuhS
         nnP0wOxUXiPZ5duZKVsSh35aFhb6ku8Dofp7J5cT+Fw6TurPX+W/cI+qzhiUrc08B2aU
         deTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748866489; x=1749471289;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tWr6AOJZN4L7ViQbt0QAk8y9QOBvmnShKqnOnGfOD/I=;
        b=uXVqCVmIyyoaRMRKl8Z5zUDrvAmGCx6nG8dozJu/oHdtp3NBgnS+q1mPm1MBGBjyZh
         wlL2yuGKwExzAAgtvS5SiP14VTPp+nPK2CLtv5JPAwb/ZjAkH2PCQu7D2wpjfOwMiPTv
         2pI3Zyqe2x+sfDAhuubxdaLsGRMiA9PrKim+yBJ6jaXEfq/SHrqt7dDNMc82aWG5N/Di
         nFE9gGcYYubZiHOkWcNd2AwhkLCXJWvXe0pqEcOSpCAZAC8QbOcAosuINkhwziS7dtln
         sp3d21+TLLrf90LXelNWRzdpBg4NbESuno1V8ISY/rhTa31YyV+RBg8TrdBj9sTSSYkE
         ktrw==
X-Gm-Message-State: AOJu0Yy03f0NGwB6gkwqQH+qgo6CduosGO6B8vAwt7KwVd2UA0SXYOPU
	4oVSTKtfkK9l7CaqSROTMfjQUutU/3xmVXqTHIrEBIM5YDNFwcVnWkHLclUJXw==
X-Gm-Gg: ASbGnctcQ2QshYCaVzXyaa6wHwM3/LA0Zn+rOKwMcn1RIzMa15sosPdyjrw1Ky62Zy7
	qsHq18b7l4+uvRoVzdMhkSm8vaDtmvwwJTrSWSNrRZq9K43dp9a5FkwuPmckGRual028cvjihO8
	aD42W+EHQt81hik9dA2jhdjojCHOLdUdBezH7OYAFS6ExJPj0awLYLJV8SLEbdDSRIs+isP5WYq
	vewOdU7HPe99Vmu1sYYZLnFaWxwwoJfXxTZHWo0LAKBaTqBFcb08A2dDdcY7ARDuGCq4CXgXc13
	uGwnfsN9shFBYrVSkz5wBIDo9/mKwLNGxoRkmTFwC/CUAs86b6bWKHey/FOHnoH0ZrrOwmXfsL8
	phgxEzUagqg==
X-Google-Smtp-Source: AGHT+IFeZNVSEluL7dtlWwkltAKCPDXDsr30OO6vpEyQUFDxxSYXRx/1crj1EkUR0RUQX8dgOqroQg==
X-Received: by 2002:a05:6122:310b:b0:52c:7abb:efee with SMTP id 71dfb90a1353d-5309379b766mr4777226e0c.9.1748866489210;
        Mon, 02 Jun 2025 05:14:49 -0700 (PDT)
Received: from glados.lan (177-1-191-98.user3p.v-tal.net.br. [177.1.191.98])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-53074ab0d37sm7340676e0c.8.2025.06.02.05.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jun 2025 05:14:48 -0700 (PDT)
From: Marcos Alano <marcoshalano@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: wireless-regdb@lists.infradead.org,
	Marcos Alano <marcoshalano@gmail.com>
Subject: [PATCH] wireless-regdb: Update regulatory rules for Brazil (BR) on 6GHz
Date: Mon,  2 Jun 2025 09:14:34 -0300
Message-ID: <20250602121434.3011282-1-marcoshalano@gmail.com>
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
index e331d4f..3b0adbb 100644
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
+	(5925 - 7125 @ 320), (30), NO-OUTDOOR, AUTO-BW
 	# EIRP=40dBm (43dBm peak)
 	(57000 - 71000 @ 2160), (40)
 
-- 
2.49.0


